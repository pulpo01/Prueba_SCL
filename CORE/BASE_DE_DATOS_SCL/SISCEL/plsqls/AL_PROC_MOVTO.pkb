CREATE OR REPLACE PACKAGE BODY Al_Proc_Movto IS
/*
<NOMBRE>       : Al_Proc_Movto</NOMBRE>
<FECHACREA>    : 1<FECHACREA/>
<MODULO >      : AL</MODULO >
<AUTOR >       : ANONIMO</AUTOR >
<VERSION >     : 1.0</VERSION >
<DESCRIPCION>  : Actualiza stock de almacen</DESCRIPCION>
<FECHAMOD >    : 20/02/2007 </FECHAMOD >
<DESCMOD >     : INCIDENCIA 37776, se controla actualizaciones a al_stock por bloqueo</DESCMOD>
<VERSIONMOD >  : 1.1</VERSIONMOD >
<FECHAMOD >    : 01/05/2007 </FECHAMOD >
<AUTODMOD >    : Zenén Muñoz H. </AUTORMOD >
<DESCMOD >     : Incidendia 41151, se elimina insert en tabla: AL_PDTE_CALCULO, 01-06-2007
                 Se comentan los llamados en el Procedimientro: p_insert_pendiente, 05-06-2007 </DESCMOD>
<VERSIONMOD >  : 1.2</VERSIONMOD >
<FECHAMOD >    : 05/03/2009 </FECHAMOD >
<AUTODMOD >    : C.A.A.D. </AUTORMOD >
<DESCMOD >     : Incidendia 79891, Se incorporan nuevos insert a la tabla al_stock_control_to, por
                 problemas detectados de deadlock en la tabla al_stock.
</DESCMOD>
*/

PROCEDURE p_traspaso_series(
  v_serie IN al_series.num_serie%TYPE ,
  v_bodega IN al_series.cod_bodega%TYPE ,
  v_tipstock IN al_series.tip_stock%TYPE ,
  v_estado IN al_series.cod_estado%TYPE ,
  v_uso IN al_series.cod_uso%TYPE ,
  v_central IN al_series.cod_central%TYPE ,
  v_subalm IN al_series.cod_subalm%TYPE ,
  v_telefono IN al_series.num_telefono%TYPE ,
  v_cat IN al_series.cod_cat%TYPE,
  v_carga IN al_series.carga%TYPE,
  v_plan  IN al_series.PLAN%TYPE )
  IS
  BEGIN
      --10/07/97
        IF v_telefono IS NOT NULL AND
           (v_subalm  IS NULL OR
            v_central IS NULL OR
            v_cat     IS NULL) THEN
         RAISE_APPLICATION_ERROR (-20199,'Este es el proceso culpable,CATEGORIA');
        END IF;
      --10/07/97

      -- Ind. telefono = 0, cuando el numero de telefono es nulo.
      IF v_telefono IS NULL AND (v_subalm  IS NULL OR v_central IS NULL OR v_cat     IS NULL) THEN
           UPDATE al_series
           SET cod_bodega   = v_bodega,
                   tip_stock    = v_tipstock,
               cod_estado   = v_estado,
               cod_uso      = v_uso,
               cod_central  = v_central,
               cod_subalm   = v_subalm,
               num_telefono = v_telefono,
               cod_cat      = v_cat,
                   ind_telefono = 0,
               carga        = v_carga,
               PLAN         = v_plan
           WHERE num_serie = v_serie;
      ELSIF v_telefono IS NOT NULL AND v_subalm IS NOT NULL AND v_central IS NOT NULL AND v_cat IS NOT NULL THEN
           UPDATE al_series
           SET cod_bodega   = v_bodega,
               tip_stock    = v_tipstock,
               cod_estado   = v_estado,
               cod_uso      = v_uso,
               cod_central  = v_central,
               cod_subalm   = v_subalm,
               num_telefono = v_telefono,
               cod_cat      = v_cat,
               carga        = v_carga,
               PLAN         = v_plan
           WHERE num_serie = v_serie;
      ELSE
            UPDATE al_series
              SET cod_bodega   = v_bodega,
                  tip_stock    = v_tipstock,
                  cod_estado   = v_estado,
                  cod_uso      = v_uso;
      END IF;
      EXCEPTION
                 WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR (-20148,'<ALMACEN> Error traspaso Serie'|| TO_CHAR(SQLCODE));
 END p_traspaso_series;

 /*************************************************************************************/

  PROCEDURE p_proceso_traspaso(
  v_movim IN OUT al_movimientos%ROWTYPE ,
  v_valor_old IN al_tipos_stock.ind_valorar%TYPE ,
  v_valor_new IN al_tipos_stock.ind_valorar%TYPE ,
  v_documento IN al_datos_generales.tip_articulo_doc%TYPE )
  IS
        no_hace_nada   EXCEPTION;
            exception_error exception;
        v_stock        al_stock%ROWTYPE;
        v_tipo         al_articulos.tip_articulo%TYPE;
        v_pdte         al_pdte_calculo%ROWTYPE;
        v_moneda_val   ge_monedas.cod_moneda%TYPE;
        v_decim        ge_monedas.num_decimal%TYPE;
        v_auxiliar     al_stock.cod_bodega%TYPE;
        v_max_intentos al_series.num_desde%TYPE;
            v_intentos NUMBER(8);
            v_error ga_abocel.ind_disp%TYPE;

   BEGIN
        Al_Pac_Validaciones.p_obtiene_moneda (v_moneda_val);
        Al_Pac_Validaciones.p_decimales (v_moneda_val,
                                         v_decim);
        IF v_movim.cod_bodega_dest IS NULL THEN
           v_movim.cod_bodega_dest := v_movim.cod_bodega;
        END IF;
        IF v_movim.tip_stock_dest IS NULL THEN
           v_movim.tip_stock_dest := v_movim.tip_stock;
        END IF;
        IF v_movim.cod_uso_dest IS NULL THEN
           v_movim.cod_uso_dest := v_movim.cod_uso;
        END IF;
        IF v_movim.cod_estado_dest IS NULL THEN
           v_movim.cod_estado_dest := v_movim.cod_estado;
        END IF;
        IF v_movim.cod_central_dest IS NULL AND
           v_movim.cod_central IS NOT NULL THEN
           v_movim.cod_central_dest := v_movim.cod_central;
        END IF;
        IF v_movim.cod_subalm_dest IS NULL AND
           v_movim.cod_subalm IS NOT NULL THEN
           v_movim.cod_subalm_dest := v_movim.cod_subalm;
        END IF;
        IF v_movim.cod_cat_dest IS NULL AND
           v_movim.cod_cat IS NOT NULL THEN
           v_movim.cod_cat_dest := v_movim.cod_cat;
        END IF;
        IF v_movim.num_telefono_dest IS NULL AND
           v_movim.num_telefono IS NOT NULL THEN
           v_movim.num_telefono_dest := v_movim.num_telefono;
        END IF;
        IF v_movim.cod_bodega_dest = v_movim.cod_bodega AND
           v_movim.tip_stock_dest = v_movim.tip_stock AND
           v_movim.cod_uso_dest = v_movim.cod_uso AND
           v_movim.cod_estado_dest = v_movim.cod_estado AND
           (
            (v_movim.num_telefono IS NULL AND
             v_movim.num_telefono_dest IS NULL) OR
             v_movim.num_telefono = v_movim.num_telefono_dest
           ) AND
           (
            (v_movim.cod_cat IS NULL AND
             v_movim.cod_cat_dest IS NULL) OR
             v_movim.cod_cat = v_movim.cod_cat_dest
           ) AND
           (
            (v_movim.cod_central IS NULL AND
             v_movim.cod_central_dest IS NULL) OR
             v_movim.cod_central = v_movim.cod_central_dest
           ) AND
           (
            (v_movim.cod_subalm IS NULL AND
             v_movim.cod_subalm_dest IS NULL) OR
             v_movim.cod_subalm = v_movim.cod_subalm_dest
           ) THEN
           RAISE no_hace_nada;
        END IF;
      -- Tratamiento de entrada para el nuevo item
          -- OCB
        IF v_valor_old = 0 AND
          (v_valor_new = 1 OR
           v_valor_new = 2) THEN
          RAISE_APPLICATION_ERROR
          (-20175,'Traspaso no permitido');
        END IF;

        ---    Tratamiento de entrada del item destino
        v_stock.cod_bodega   := v_movim.cod_bodega_dest;
        v_stock.tip_stock    := v_movim.tip_stock_dest;
        v_stock.cod_articulo := v_movim.cod_articulo;
        v_stock.cod_uso        := v_movim.cod_uso_dest;
        v_stock.cod_estado   := v_movim.cod_estado_dest;
        v_stock.can_stock    := v_movim.num_cantidad;
        v_stock.fec_creacion := SYSDATE;
        v_stock.num_desde       := NVL(v_movim.num_desde,0);
        v_stock.num_hasta       := v_movim.num_hasta;
        v_stock.cod_plaza       := v_movim.cod_plaza;   /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
        p_entrada_stock (v_stock);


        IF v_movim.num_serie IS NOT NULL THEN


           p_validar_serie (v_movim.num_serie,
                            v_movim.cod_bodega,
                            v_movim.tip_stock,
                            v_movim.cod_uso,
                            v_movim.cod_estado,
                            v_movim.cod_articulo);
           p_traspaso_series (v_movim.num_serie,
                              v_movim.cod_bodega_dest,
                              v_movim.tip_stock_dest,
                              v_movim.cod_estado_dest,
                              v_movim.cod_uso_dest,
                              v_movim.cod_central_dest,
                              v_movim.cod_subalm_dest,
                              v_movim.num_telefono_dest,
                              v_movim.cod_cat_dest,
                              v_movim.carga,
                              v_movim.PLAN);
        END IF;

        -- Tratamiento de salida del item origen
        Al_Pac_Validaciones.p_obtiene_tipoart (v_movim.cod_articulo,v_tipo);

        IF v_tipo <> v_documento THEN
            -- Bloquea el registro que va a actualizar p_salida_stock
            -- para evitar deadlock
            p_bloq_stock(v_movim, v_error);

            IF v_error = 1 then
                RAISE EXCEPTION_ERROR;
            END IF;
            p_salida_stock(v_movim.cod_bodega,
                           v_movim.tip_stock,
                           v_movim.cod_articulo,
                           v_movim.cod_uso,
                           v_movim.cod_estado,
                           v_movim.num_cantidad,
                           NVL(v_movim.num_desde,0),
                           v_movim.cod_plaza);  /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
        ELSE
            p_salida_stock_doc (v_movim.cod_bodega,
                                v_movim.tip_stock,
                                v_movim.cod_articulo,
                                v_movim.cod_uso,
                                v_movim.cod_estado,
                                v_movim.num_cantidad,
                                NVL(v_movim.num_desde,0),
                                v_movim.num_hasta,
                                v_movim.cod_plaza);  /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
         END IF;

         IF v_valor_old = v_valor_new THEN
            RAISE no_hace_nada;
         END IF;
         v_pdte.cod_articulo    := v_movim.cod_articulo;
         v_pdte.num_movimiento  := v_movim.num_movimiento;
         v_pdte.fec_movimiento  := v_movim.fec_movimiento;
         v_pdte.ind_entsal      := 'T';
         v_pdte.ind_valor_ori   := v_valor_old;
         v_pdte.num_cantidad    := v_movim.num_cantidad;
         v_pdte.prc_unidad      := v_movim.prc_unidad;
         v_pdte.cod_moneda      := v_movim.cod_moneda;
         v_pdte.num_serie       := v_movim.num_serie;
         v_pdte.ind_valor_des   := v_valor_new;
-- Incidencia: 41151, se comenta llamados al Procedimientro: p_insert_pendiente, que elimina insert en tabla: AL_PDTE_CALCULO, 05-05-2007
--         p_insert_pendiente(v_pdte);
-- Fin: 41151
  EXCEPTION
            WHEN no_hace_nada THEN NULL;
            WHEN EXCEPTION_ERROR THEN
               BEGIN
                  INSERT INTO AL_STOCK_CONTROL_TO
                           ( COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE,
                           COD_PLAZA, IND_ENTSAL, COD_PROCESO, FEC_INGRESO, CAN_STOCK)
                  VALUES ( v_movim.cod_bodega, v_movim.tip_stock, v_movim.cod_articulo,
                             v_movim.cod_uso, v_movim.cod_estado, NVL(v_movim.num_desde,0),
                           v_movim.cod_plaza, 'S', 'N', SYSDATE, v_movim.num_cantidad );
                  EXCEPTION WHEN OTHERS THEN
                     RAISE_APPLICATION_ERROR (-20165, '<ALMACEN>, Error Insert AL_STOCK_CONTROL_TO 1' || ' ' || TO_CHAR(SQLCODE));
               END;
               RAISE_APPLICATION_ERROR (-20138,'<ALMACEN>, Error traspaso AL_STOCK ' || TO_CHAR(SQLCODE));
  END p_proceso_traspaso;


  /*************************************************************************************/

PROCEDURE p_trata_movim(v_movim IN OUT al_movimientos%ROWTYPE )  IS
        v_entsal       al_tipos_movimientos.ind_entsal%TYPE;
        v_valorar_new  al_tipos_stock.ind_valorar%TYPE;
        v_valorar_old  al_tipos_stock.ind_valorar%TYPE;
        v_documento    al_datos_generales.tip_articulo_doc%TYPE;
        v_ind_seriado  al_articulos.ind_seriado%TYPE;
        v_cod_Plaza    al_movimientos.cod_plaza%TYPE;
BEGIN
        p_es_seriado (v_movim.cod_articulo, v_ind_seriado);                             -- Verificamos si es Seriado o No.
        IF v_movim.cod_plaza IS NULL THEN
                                p_obtener_oficina_default (v_cod_plaza);      -- Verificamos si es nulo el cod_plaza. AARM, Diciembre 2002
                                v_movim.cod_plaza:=v_cod_plaza;
        END IF;

        IF v_movim.prc_unidad is null THEN
           v_movim.prc_unidad := 0;
        END IF;
        IF v_ind_seriado = 1 AND v_movim.num_serie IS NULL THEN
                RAISE_APPLICATION_ERROR (-20191, 'Movimiento de Articulo Seriado sin especificar serie');
        ELSIF v_ind_seriado = 0 AND v_movim.num_serie IS NOT NULL THEN
                RAISE_APPLICATION_ERROR (-20191,'Movimiento de Articulo No Seriado con Serie Especificada');
        END IF;
        Al_Pac_Validaciones.p_obtiene_tipmovim (v_movim.tip_movimiento,v_entsal);               -- Obtencion del tipo de movimiento solicitado
        Al_Pac_Validaciones.p_obtiene_valoracion (v_movim.tip_stock, v_valorar_old);    -- Obtencion del tipo de valoracion que corresponde al tipo de stock origen del movimiento
        Al_Pac_Validaciones.p_obtiene_documento (v_documento);
        -- Criva del tipo de movimiento
        IF v_entsal = 'E' THEN    -- Significa que es un movimiento de entrada
           p_proceso_entrada (v_movim, v_valorar_old, v_documento);
        ELSIF v_entsal = 'S' THEN --Significa que es un movimiento de salida

           p_proceso_salida (v_movim, v_valorar_old, v_documento);

        ELSE                      -- Significa que es un movimiento de traspaso
           IF v_movim.tip_stock_dest IS NOT NULL AND v_movim.tip_stock_dest <> v_movim.tip_stock THEN
              Al_Pac_Validaciones.p_obtiene_valoracion(v_movim.tip_stock_dest, v_valorar_new);
           ELSE
              v_valorar_new := v_valorar_old;
           END IF;
           p_proceso_traspaso (v_movim, v_valorar_old, v_valorar_new, v_documento);
        END IF;
END p_trata_movim;

/*************************************************************************************/


PROCEDURE p_proceso_entrada(v_movim IN al_movimientos%ROWTYPE ,
                            v_valor IN al_tipos_stock.ind_valorar%TYPE ,
                            v_documento IN al_datos_generales.tip_articulo_doc%TYPE) IS
        v_stock        al_stock%ROWTYPE;
        v_stock_localizacion al_stock_localizacion%ROWTYPE;
        v_series       al_series%ROWTYPE;
        v_moneda_val   al_datos_generales.cod_moneda_val%TYPE;
        v_precio       al_series.prc_compra%TYPE;
        v_pdte         al_pdte_calculo%ROWTYPE;
        v_decim        ge_monedas.num_decimal%TYPE;
BEGIN
        Al_Pac_Validaciones.p_obtiene_moneda (v_moneda_val);
        Al_Pac_Validaciones.p_decimales (v_moneda_val, v_decim);
        IF v_moneda_val <> v_movim.cod_moneda THEN
           Al_Pac_Validaciones.p_convertir_precio (v_movim.cod_moneda, v_moneda_val,
                                                                                        v_movim.prc_unidad,v_precio, v_movim.fec_movimiento);
        ELSE
           v_precio := v_movim.prc_unidad;
        END IF;
      -- Inicializacion de las variables componentes del registro de AL_STOCK
        v_stock.cod_bodega    := v_movim.cod_bodega;
        v_stock.tip_stock     := v_movim.tip_stock;
        v_stock.cod_articulo  := v_movim.cod_articulo;
        v_stock.cod_uso       := v_movim.cod_uso;
        v_stock.cod_estado    := v_movim.cod_estado;
        v_stock.can_stock     := v_movim.num_cantidad;
        v_stock.fec_creacion  := SYSDATE;
        v_stock.num_desde     := NVL(v_movim.num_desde,0);
        v_stock.num_hasta     := v_movim.num_hasta;
        v_stock.cod_plaza     := v_movim.cod_plaza; /*Agrego el código de Plaza, AARM, Diciembre 2002*/
        -- Llamada al tratamiento de entrada de AL_STOCK
        p_entrada_stock (v_stock);

        -- JLR Actualizamos el Stock Localizado.
        IF v_movim.num_sec_loca IS NOT NULL THEN
           v_stock_localizacion.cod_articulo  := v_movim.cod_articulo;
           v_stock_localizacion.num_sec_loca  := v_movim.num_sec_loca;
           v_stock_localizacion.fec_creacion  := v_stock.fec_creacion;
           v_stock_localizacion.can_stock     := v_movim.num_cantidad;
           p_entrada_stock_localizacion(v_stock_localizacion);   -- JLR Actualizamos el Stock Localizado.
        END IF;
    -- Si el numero de serie del movimiento viene implementado se debe crear
    -- la serie
    IF v_movim.num_serie IS NOT NULL THEN
                v_series.num_serie      := v_movim.num_serie;
                v_series.cod_bodega     := v_movim.cod_bodega;
                v_series.tip_stock      := v_movim.tip_stock;
                v_series.cod_articulo   := v_movim.cod_articulo;
                v_series.cod_uso                := v_movim.cod_uso;
                v_series.cod_estado     := v_movim.cod_estado;
                v_series.num_desde      := NVL(v_movim.num_desde,0);
                v_series.fec_entrada    := SYSDATE;
                v_series.cap_code       := v_movim.cap_code;
                v_series.num_telefono   := v_movim.num_telefono;
                v_series.num_seriemec   := v_movim.num_seriemec;
                v_series.prc_compra     := v_precio;
                v_series.cod_producto   := v_movim.cod_producto;
                v_series.cod_central    := v_movim.cod_central;
                v_series.cod_subalm     := v_movim.cod_subalm;
                v_series.cod_cat        := v_movim.cod_cat;
                v_series.ind_telefono   := v_movim.ind_telefono;
                v_series.num_sec_loca   := v_movim.num_sec_loca;                -- JLR  Localizacisn
                                v_series.PLAN                   := v_movim.PLAN;
                                v_series.carga                  := v_movim.carga;
                                v_series.cod_plaza      := v_movim.cod_plaza; --JLA (TMM) 16122002
                                v_series.cod_hlr      := v_movim.cod_hlr;

                p_entrada_series (v_series);
        END IF;
              -- 06-08-99 El calculo de mercaderia y compras, pasa a ser procesado BATCH...,
              -- para lo cual tomara los registros de guarda en al_pdte_calculo...
                v_pdte.cod_articulo    := v_movim.cod_articulo;
                v_pdte.num_movimiento  := v_movim.num_movimiento;
                v_pdte.fec_movimiento  := v_movim.fec_movimiento;
                v_pdte.ind_entsal      := 'E';
                v_pdte.ind_valor_ori   := v_valor;
                v_pdte.num_cantidad    := v_movim.num_cantidad;
                v_pdte.prc_unidad      := v_movim.prc_unidad;
                v_pdte.cod_moneda      := v_movim.cod_moneda;
                v_pdte.num_serie       := v_movim.num_serie;
                v_pdte.ind_valor_des   := NULL;
-- Incidencia: 41151, se comenta llamados al Procedimientro: p_insert_pendiente, que elimina insert en tabla: AL_PDTE_CALCULO, 05-05-2007
--                p_insert_pendiente(v_pdte);
-- Fin: 41151
END p_proceso_entrada;

/*************************************************************************************/


PROCEDURE p_proceso_salida( v_movim IN al_movimientos%ROWTYPE , v_valor IN al_tipos_stock.ind_valorar%TYPE ,
                            v_documento IN al_datos_generales.tip_articulo_doc%TYPE ) IS
        v_tipo      al_articulos.tip_articulo%TYPE;
        v_pdte      al_pdte_calculo%ROWTYPE;
        v_stock_localizacion al_stock_localizacion%ROWTYPE; --  JLR Aclualizacion por Localizacion
        exception_error exception;
        v_error ga_abocel.ind_disp%TYPE;

BEGIN
        IF v_movim.num_serie IS NOT NULL THEN
        -- Obtencion del mes de ingreso en bodega de la serie
        -- Llamada al tratamiento de series
        p_validar_serie (v_movim.num_serie,v_movim.cod_bodega, v_movim.tip_stock,
                                 v_movim.cod_uso, v_movim.cod_estado,v_movim.cod_articulo);
        p_salida_serie (v_movim.num_serie);
        END IF;
    Al_Pac_Validaciones.p_obtiene_tipoart (v_movim.cod_articulo, v_tipo);
    -- Llamada al tratamiento de AL_STOCk

    v_stock_localizacion.cod_articulo := v_movim.cod_articulo;
    v_stock_localizacion.num_sec_loca := v_movim.num_sec_loca;
        v_stock_localizacion.can_stock    := v_movim.num_cantidad;

    IF v_tipo <> v_documento THEN
        -- Bloquea el registro que va a actualizar p_salida_stock
        -- para evitar deadlock
        p_bloq_stock(v_movim, v_error);

        IF v_error = 1 then
            RAISE EXCEPTION_ERROR;
        END IF;

        p_salida_stock (v_movim.cod_bodega, v_movim.tip_stock, v_movim.cod_articulo,
                        v_movim.cod_uso, v_movim.cod_estado, v_movim.num_cantidad, NVL(v_movim.num_desde,0),v_movim.cod_plaza );
        IF v_stock_localizacion.num_sec_loca IS NOT NULL THEN
                        p_salida_stock_localizacion (v_stock_localizacion);                     -- JLR Actualizacion por localizacisn.
                END IF;
        ELSE
        p_salida_stock_doc (v_movim.cod_bodega, v_movim.tip_stock, v_movim.cod_articulo, v_movim.cod_uso,
                            v_movim.cod_estado, v_movim.num_cantidad, NVL(v_movim.num_desde,0) ,v_movim.num_hasta, v_movim.cod_plaza);
    END IF;
    v_pdte.cod_articulo    := v_movim.cod_articulo;
    v_pdte.num_movimiento  := v_movim.num_movimiento;
    v_pdte.fec_movimiento  := v_movim.fec_movimiento;
    v_pdte.ind_entsal      := 'S';
    v_pdte.ind_valor_ori   := v_valor;
    v_pdte.num_cantidad    := v_movim.num_cantidad;
    v_pdte.prc_unidad      := v_movim.prc_unidad;
    v_pdte.cod_moneda      := v_movim.cod_moneda;
    v_pdte.num_serie       := v_movim.num_serie;
    v_pdte.ind_valor_des   := NULL;
-- Incidencia: 41151, se comenta llamados al Procedimientro: p_insert_pendiente, que elimina insert en tabla: AL_PDTE_CALCULO, 05-05-2007
--    p_insert_pendiente(v_pdte);
-- Fin: 41151
  EXCEPTION
         WHEN EXCEPTION_ERROR THEN
            BEGIN
                INSERT INTO AL_STOCK_CONTROL_TO
                       ( COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE,
                            COD_PLAZA, IND_ENTSAL, COD_PROCESO, FEC_INGRESO, CAN_STOCK )
                VALUES ( v_movim.cod_bodega, v_movim.tip_stock, v_movim.cod_articulo,
                            v_movim.cod_uso, v_movim.cod_estado, NVL(v_movim.num_desde,0),
                         v_movim.cod_plaza, 'S', 'N', SYSDATE, v_movim.num_cantidad );
                EXCEPTION WHEN OTHERS THEN
                   RAISE_APPLICATION_ERROR (-20165, '<ALMACEN>, Error Insert AL_STOCK_CONTROL_TO 2' || ' ' || TO_CHAR(SQLCODE));
            END;
            RAISE_APPLICATION_ERROR (-20138,'<ALMACEN>, Error Salida AL_STOCK ' || TO_CHAR(SQLCODE));
END p_proceso_salida;


/*************************************************************************************/


PROCEDURE p_entrada_stock( v_stock IN al_stock%ROWTYPE )IS
    v_error ga_abocel.ind_disp%TYPE;
    Exception_Error exception;

BEGIN
       p_bloq_stock_entrada(v_stock, v_error);

       IF v_error = 1 then
          RAISE EXCEPTION_ERROR;
       END IF;

       IF v_error = 0 THEN

          UPDATE al_stock SET can_stock = can_stock + v_stock.can_stock
          WHERE cod_bodega   = v_stock.cod_bodega
          AND tip_stock    = v_stock.tip_stock
          AND cod_articulo = v_stock.cod_articulo
          AND cod_uso      = v_stock.cod_uso
          AND cod_estado   = v_stock.cod_estado
          AND num_desde    = NVL(v_stock.num_desde,v_val_cero)
          AND cod_plaza    = v_stock.cod_plaza ;  /*Agrego el código de Plaza, AARM, Diciembre 2002*/

       ELSIF v_error = 3 THEN
            BEGIN
                INSERT INTO al_stock (cod_bodega,tip_stock,cod_articulo,cod_uso,cod_estado,can_stock,
                                      fec_creacion,num_desde,num_hasta,cod_plaza )
                                       /*Agrego el código de Plaza, AARM, Diciembre 2002*/
                VALUES (v_stock.cod_bodega,
                        v_stock.tip_stock,
                        v_stock.cod_articulo,
                        v_stock.cod_uso,
                        v_stock.cod_estado,
                        v_stock.can_stock,
                        v_stock.fec_creacion,
                        NVL(v_stock.num_desde,0),
                        v_stock.num_hasta,
                        v_stock.cod_plaza  );   /*Agrego el código de Plaza, AARM, Diciembre 2002*/
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                      BEGIN
                         INSERT INTO AL_STOCK_CONTROL_TO
                                 ( COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO,
                                  NUM_DESDE, COD_PLAZA, IND_ENTSAL, COD_PROCESO, FEC_INGRESO,
                                  CAN_STOCK )
                         VALUES ( v_stock.cod_bodega, v_stock.tip_stock, v_stock.cod_articulo,
                                   v_stock.cod_uso, v_stock.cod_estado, NVL(v_stock.num_desde,0),
                                  v_stock.cod_plaza, 'E', 'N', SYSDATE, v_stock.can_stock );
                         EXCEPTION WHEN OTHERS THEN
                            RAISE_APPLICATION_ERROR (-20136, '<ALMACEN>, Error Insert AL_STOCK_CONTROL_TO 3' || ' ' || TO_CHAR(SQLCODE));
                       END;
                      RAISE_APPLICATION_ERROR (-20137,'<ALMACEN>, Error Entrada AL_STOCK ' || TO_CHAR(SQLCODE));
                WHEN OTHERS THEN
                   RAISE_APPLICATION_ERROR (-20137,'<ALMACEN>, Error Entrada AL_STOCK ' || TO_CHAR(SQLCODE));
            END;
        END IF;

     EXCEPTION
        WHEN Exception_Error THEN
           BEGIN
              INSERT INTO AL_STOCK_CONTROL_TO
                       ( COD_BODEGA, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, NUM_DESDE,
                       COD_PLAZA, IND_ENTSAL, COD_PROCESO, FEC_INGRESO, CAN_STOCK )
              VALUES ( v_stock.cod_bodega, v_stock.tip_stock, v_stock.cod_articulo, v_stock.cod_uso,
                         v_stock.cod_estado, NVL(v_stock.num_desde,0), v_stock.cod_plaza, 'E', 'N',
                       SYSDATE, v_stock.can_stock );
              EXCEPTION WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR (-20165, '<ALMACEN>, Error Insert AL_STOCK_CONTROL_TO 4' || ' ' || TO_CHAR(SQLCODE));
           END;
           RAISE_APPLICATION_ERROR (-20138,'<ALMACEN>, Error Entrada AL_STOCK ' || TO_CHAR(SQLCODE));

        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20138,'<ALMACEN>, Error Entrada AL_STOCK ' || TO_CHAR(SQLCODE));
END p_entrada_stock;

/**************************************************************************************/
-- Creado Por JLR
-- Agrea Stock a localizacion.
PROCEDURE p_entrada_stock_localizacion(v_stock IN al_stock_localizacion%ROWTYPE ) IS
BEGIN
        UPDATE al_stock_localizacion SET can_stock = can_stock + v_stock.can_stock
        WHERE cod_articulo = v_stock.cod_articulo AND
              num_sec_loca = v_stock.num_sec_loca;
        IF SQL%NOTFOUND THEN
                INSERT INTO al_stock_localizacion (cod_articulo,
                                                   num_sec_loca,
                                                               fec_creacion,
                                                               can_stock)
                VALUES (v_stock.cod_articulo,
                        v_stock.num_sec_loca,
                v_stock.fec_creacion,
                v_stock.can_stock);
        END IF;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20134,'<ALMACEN>, Error Entrada AL_STOCK_LOCALIZAICON ' || TO_CHAR(SQLCODE));
END p_entrada_stock_localizacion;


/**************************************************************************************/


PROCEDURE p_entrada_series( v_series IN al_series%ROWTYPE ) IS
BEGIN

        IF v_series.num_telefono IS NOT NULL AND (v_series.cod_subalm IS NULL OR v_series.cod_central IS NULL
                                                                      OR v_series.cod_cat IS NULL) THEN
                RAISE_APPLICATION_ERROR (-20199,'Este es el proceso culpable,CATEGORIA');
        END IF;
        INSERT INTO al_series (num_serie,
                               cod_bodega,
                               tip_stock,
                               cod_articulo,
                               cod_uso,
                               cod_estado,
                               num_desde,
                               fec_entrada,
                               ind_telefono,
                               cap_code,
                               num_telefono,
                               num_seriemec,
                               prc_compra,
                               cod_producto,
                               cod_central,
                               cod_subalm,
                               cod_cat,
                               num_sec_loca,
                                                           PLAN,
                                                           carga,
                               cod_plaza,--JLA (TMM) 18122002
                                                           cod_hlr)
                               VALUES (v_series.num_serie,
                                       v_series.cod_bodega,
                                       v_series.tip_stock,
                                       v_series.cod_articulo,
                                       v_series.cod_uso,
                                       v_series.cod_estado,
                                       NVL(v_series.num_desde,0),
                                       v_series.fec_entrada,
                                       v_series.ind_telefono,
                                       v_series.cap_code,
                                       v_series.num_telefono,
                                       v_series.num_seriemec,
                                       v_series.prc_compra,
                                       v_series.cod_producto,
                                       v_series.cod_central,
                                       v_series.cod_subalm,
                                       v_series.cod_cat,
                                       v_series.num_sec_loca,
                                                                           v_series.PLAN,
                                       v_series.carga,
                                       V_series.cod_plaza, --JLA (TMM) 18122002
                                                                           V_series.cod_hlr);
EXCEPTION
        WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20135,'<ALMACEN>, Error Entrada AL_SERIES, Error Oracle: ' || TO_CHAR(SQLCODE));
END p_entrada_series;


/*************************************************************************************/



  PROCEDURE p_salida_serie(
  v_serie IN al_series.num_serie%TYPE )
  IS
              BEGIN
                 DELETE al_series
                        WHERE num_serie = v_serie;
              EXCEPTION
                 WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR
                      (-20140,'<ALMACEN> Error Salida Serie ' ||
                       'Sr.: ' || v_serie || '-, Error Oracle: ' || TO_CHAR(SQLCODE));
              END p_salida_serie;

/*************************************************************************************/
  PROCEDURE p_salida_stock_doc(
  v_bodega IN al_stock.cod_bodega%TYPE ,
  v_tipstock IN al_stock.tip_stock%TYPE ,
  v_articulo IN al_stock.cod_articulo%TYPE ,
  v_uso IN al_stock.cod_uso%TYPE ,
  v_estado IN al_stock.cod_estado%TYPE ,
  v_cantidad IN al_stock.can_stock%TYPE ,
  v_numdesde IN al_stock.num_desde%TYPE ,
  v_numhasta IN al_stock.num_hasta%TYPE,
  v_cod_plaza IN al_stock.cod_plaza%TYPE /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
   )
  IS
                 v_cant  al_stock.can_stock%TYPE;
                 v_rowid ROWID;
                 v_desde al_stock.num_desde%TYPE;
                 v_hasta al_stock.num_hasta%TYPE;
              BEGIN
              -- Verificacion de la cantidad actual en stock
                 SELECT ROWID,can_stock,num_desde,num_hasta
                   INTO v_rowid,v_cant,v_desde,v_hasta
                        FROM al_stock
                        WHERE cod_bodega  = v_bodega
                          AND tip_stock  = v_tipstock
                          AND cod_articulo = v_articulo
                          AND cod_uso   = v_uso
                          AND cod_estado  = v_estado
                                                  AND cod_plaza = v_cod_plaza /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
                          AND num_desde <= v_numdesde
                          AND num_hasta >= v_numhasta;
                 IF v_cant < v_cantidad THEN
                    RAISE_APPLICATION_ERROR
                     (-20141,'<ALMACEN>, Cantidad en Stock inferior, Error Oracle: ' || TO_CHAR(SQLCODE));
                 ELSIF v_cant = v_cantidad THEN
                    IF v_numdesde = v_desde AND
                       v_numhasta = v_hasta THEN
                       DELETE al_stock
                       WHERE ROWID = v_rowid;
                    ELSE
                       RAISE_APPLICATION_ERROR
                         (-20141,'<ALMACEN> No es el item de stock correcto, Error Oracle: '
                          || TO_CHAR(SQLCODE));
                    END IF;
                 ELSE
                    IF v_numdesde > v_desde AND
                       v_numhasta < v_hasta THEN
                       INSERT INTO al_stock (cod_bodega,
                                             tip_stock,
                                             cod_articulo,
                                             cod_uso,
                                             cod_estado,
                                             can_stock,
                                             fec_creacion,
                                             num_desde,
                                             num_hasta,
                                                                                         cod_plaza) /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
                              SELECT cod_bodega,
                                     tip_stock,
                                     cod_articulo,
                                     cod_uso,
                                     cod_estado,
                                     num_hasta - v_numhasta,
                                     SYSDATE,
                                     v_numhasta + 1,
                                     num_hasta,
                                                                         cod_plaza  /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
                                FROM al_stock
                                WHERE ROWID = v_rowid;
                       UPDATE al_stock
                              SET num_hasta = v_numdesde -1,
                              can_stock = v_numdesde - num_desde
                              WHERE ROWID = v_rowid;
                     ELSIF v_numdesde = v_desde AND
                           v_numhasta < v_hasta THEN
                        UPDATE al_stock
                               SET num_desde = v_numhasta + 1,
                               can_stock = num_hasta - v_numhasta
                               WHERE ROWID = v_rowid;
                     ELSIF v_numdesde > v_desde AND
                           v_numhasta = v_hasta THEN
                       UPDATE al_stock
                              SET num_hasta = v_numdesde -1,
                              can_stock = v_numdesde - num_desde
                              WHERE ROWID = v_rowid;
                     ELSE
                        RAISE_APPLICATION_ERROR
                         (-20141,'<ALMACEN> No es el item de stock correcto, Error Oracle: '
                          || TO_CHAR(SQLCODE));
                     END IF;
                 END IF;
              EXCEPTION
                 WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR (-20142,
    '<ALMACEN>, Error salida Stock, Error Oracle: ' || TO_CHAR(SQLCODE));
              END p_salida_stock_doc;



/*************************************************************************************/


PROCEDURE p_salida_stock( v_bodega IN al_stock.cod_bodega%TYPE , v_tipstock IN al_stock.tip_stock%TYPE ,
                          v_articulo IN al_stock.cod_articulo%TYPE , v_uso IN al_stock.cod_uso%TYPE ,
                          v_estado IN al_stock.cod_estado%TYPE , v_cantidad IN al_stock.can_stock%TYPE ,
                          v_numdesde IN al_stock.num_desde%TYPE, v_cod_plaza IN al_stock.cod_plaza%TYPE ) IS
--
        v_cant  al_stock.can_stock%TYPE;
        v_rowid ROWID;
--
-- Excepciones definidas por el usuario
--
Cantidad_Inferior    EXCEPTION;
No_Eliminado         EXCEPTION;
No_Actualizado         EXCEPTION;
--
BEGIN
        -- Verificacion de la cantidad actual en stock
        SELECT ROWID,can_stock INTO v_rowid,v_cant
        FROM al_stock
        WHERE cod_bodega  = v_bodega
        AND tip_stock     = v_tipstock
        AND cod_articulo  = v_articulo
        AND cod_uso       = v_uso
        AND cod_estado    = v_estado
        AND num_desde     = v_numdesde
        AND cod_plaza     = v_cod_plaza; /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
    --
        IF v_cant < v_cantidad THEN
            RAISE Cantidad_Inferior;
        ELSIF v_cant = v_cantidad THEN
            BEGIN
              DELETE al_stock
              WHERE ROWID = v_rowid;
            EXCEPTION
                WHEN OTHERS THEN
                RAISE No_Eliminado;
            END;
        ELSE
            BEGIN
                UPDATE al_stock SET can_stock = can_stock - v_cantidad
                WHERE ROWID = v_rowid;
            EXCEPTION
                WHEN OTHERS THEN
                RAISE No_Actualizado;
            END;
        END IF;

    EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR (-20139, '<ALMACEN>, Registro no encontrado, Error Oracle: ' || TO_CHAR(SQLCODE));
            --
            WHEN TOO_MANY_ROWS  THEN
                RAISE_APPLICATION_ERROR (-20145, '<ALMACEN>, Hay mas de un registro encontrado, Error Oracle: ' || TO_CHAR(SQLCODE));
            --
            WHEN Cantidad_Inferior THEN
                RAISE_APPLICATION_ERROR (-20141, '<ALMACEN>, Cantidad en Stock inferior, Error Oracle: ' || TO_CHAR(SQLCODE));
            --
            WHEN No_Eliminado THEN
                RAISE_APPLICATION_ERROR (-20143, '<ALMACEN>, Registro no eliminado, Error Oracle: ' || TO_CHAR(SQLCODE));

            WHEN No_Actualizado THEN
                RAISE_APPLICATION_ERROR (-20144, '<ALMACEN>, Registro no actualizado, Error Oracle: ' || TO_CHAR(SQLCODE));
            --
            WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR (-20142, '<ALMACEN>, Error salida Stock, Error Oracle: '|| TO_CHAR(SQLCODE));
END p_salida_stock;


/*************************************************************************************/


PROCEDURE p_salida_stock_localizacion( v_stock IN al_stock_localizacion%ROWTYPE ) IS
        v_cant  al_stock_localizacion.can_stock%TYPE;
        v_rowid ROWID;
BEGIN
        -- Verificacion de la cantidad actual en stock
        SELECT ROWID, can_stock INTO v_rowid, v_cant
        FROM al_stock_localizacion
        WHERE cod_articulo  = v_stock.cod_articulo AND
              num_sec_loca  = v_stock.num_sec_loca;
    IF v_cant < v_stock.can_stock THEN
        RAISE_APPLICATION_ERROR (-20141, '<ALMACEN>, Cantidad en Stock inferior, Error Oracle: ' || TO_CHAR(SQLCODE));
    ELSIF v_cant = v_stock.can_stock THEN
        DELETE al_stock_localizacion
        WHERE ROWID = v_rowid;
        ELSE
        UPDATE al_stock_localizacion SET can_stock = can_stock - v_stock.can_stock
        WHERE ROWID = v_rowid;
        END IF;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20142, '<ALMACEN>, Error salida Stock (AL_STOCK_LOCALIZACION), Error Oracle: '|| TO_CHAR(SQLCODE));
END p_salida_stock_localizacion;


/*************************************************************************************/



  PROCEDURE p_validar_serie(
  v_serie IN al_series.num_serie%TYPE ,
  v_bodega IN al_series.cod_bodega%TYPE ,
  v_tipstock IN al_series.tip_stock%TYPE ,
  v_uso IN al_series.cod_uso%TYPE ,
  v_estado IN al_series.cod_estado%TYPE ,
  v_articulo IN al_series.cod_articulo%TYPE)
  IS
              v_x_indtelefono al_series.ind_telefono%TYPE;

              BEGIN


                SELECT ind_telefono INTO v_x_indtelefono
                       FROM al_series
                       WHERE num_serie    = v_serie
                         AND cod_bodega   = v_bodega
                         AND tip_stock    = v_tipstock
                         AND cod_uso      = v_uso
                         AND cod_estado   = v_estado
                         AND cod_articulo = v_articulo;
              EXCEPTION
                WHEN OTHERS THEN
                     RAISE_APPLICATION_ERROR (-20188,  '<ALMACEN> Serie Inexistente : ' || v_serie || ' Error Oracle: '
                                              || TO_CHAR(SQLCODE));
              END p_validar_serie;

/*************************************************************************************/


PROCEDURE p_insert_pendiente(v_pdte IN al_pdte_calculo%ROWTYPE ) IS
BEGIN
  INSERT INTO al_pdte_calculo (cod_articulo,
                                              num_movimiento,
                                              fec_movimiento,
                                              ind_entsal,
                                              ind_valor_ori,
                                              num_cantidad,
                                              prc_unidad,
                                              cod_moneda,
                                              num_serie,
                                              ind_valor_des)
                                      VALUES (v_pdte.cod_articulo,
                                              v_pdte.num_movimiento,
                                              v_pdte.fec_movimiento,
                                              v_pdte.ind_entsal,
                                              v_pdte.ind_valor_ori,
                                              v_pdte.num_cantidad,
                                              v_pdte.prc_unidad,
                                              v_pdte.cod_moneda,
                                              v_pdte.num_serie,
                                              v_pdte.ind_valor_des);
              EXCEPTION
                 WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR (-20177,
          'Error Insert en Pendientes de Calculo, Error Oracle: '
                                               || TO_CHAR(SQLCODE));
END p_insert_pendiente;


/*************************************************************************************/


  PROCEDURE p_es_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_ind_seriado IN OUT al_articulos.ind_seriado%TYPE )
  IS
              BEGIN
                 SELECT ind_seriado INTO v_ind_seriado
                        FROM al_articulos
                        WHERE cod_articulo = v_articulo;
              EXCEPTION
                 WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR (-20193,'Articulo incorrecto, Error Oracle: '
                                               || TO_CHAR(SQLCODE));
              END p_es_seriado;


/*************************************************************************************/

PROCEDURE p_obtener_oficina_default(   /*Procedimiento creado para traer Default*/
   v_cod_plaza IN OUT al_movimientos.cod_plaza%TYPE )
  IS
              BEGIN
               execute immediate 'SELECT Cod_oficina_def FROM AL_DATOS_GENERALES'
                                  INTO v_cod_plaza;
              EXCEPTION
                 WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR (-20193,'Error al leer oficina por  defecto, Error Oracle: ' || TO_CHAR(SQLCODE));
              END p_obtener_oficina_default;
/*************************************************************************************/

PROCEDURE p_obtener_maxintentos(v_max_intentos IN OUT al_series.num_desde%TYPE) IS
     v_nom_parametro ged_parametros.nom_parametro%type;
  BEGIN
     v_max_intentos := 5;

     v_nom_parametro := 'CANT_INTENTOS_DFLT';
     begin
       SELECT to_number(VAL_PARAMETRO)
        INTO v_max_intentos
        FROM GED_PARAMETROS
        WHERE NOM_PARAMETRO = v_nom_parametro;
    EXCEPTION
         WHEN NO_DATA_FOUND THEN
               v_max_intentos := 5;
          WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20193,'Error Obtencion Maximo Intento  ' || TO_CHAR(SQLCODE));
     end;

END p_obtener_maxintentos;


/*************************************************************************************/


  Procedure p_bloq_stock(v_movim IN al_movimientos%ROWTYPE,
                       v_error IN OUT ga_abocel.ind_disp%TYPE)
  IS
                v_max_intentos al_series.num_desde%TYPE;
                v_intentos NUMBER(8);
                v_error_x NUMBER(1);
                v_auxiliar     al_stock.cod_bodega%TYPE;
  Begin
      --p_obtener_maxintentos(v_max_intentos);
       v_max_intentos := 5;
       v_intentos := 0;
       WHILE v_max_intentos >= v_intentos LOOP
            BEGIN
               v_error := 0;
               SELECT cod_bodega INTO v_auxiliar
               FROM al_stock
               WHERE cod_bodega = v_movim.cod_bodega
               AND tip_stock  = v_movim.tip_stock
               AND cod_articulo = v_movim.cod_articulo
               AND cod_uso = v_movim.cod_uso
               AND cod_estado  = v_movim.cod_estado
                  AND cod_plaza   = v_movim.cod_plaza  /* Sop. Agrego cod_plaza. Ago. 2003 */
               AND num_desde = NVL(v_movim.num_desde,0)
               FOR UPDATE NOWAIT;
               v_error := 0;
               v_intentos := v_max_intentos + 1;

           EXCEPTION
               WHEN OTHERS THEN
            v_error := 1;
                    IF (SQLCODE=-54 OR (SQLCODE=-60 OR (SQLCODE=-99 OR (SQLCODE=-104 OR (SQLCODE=-2049 OR (SQLCODE=-4020 OR (SQLCODE=-12829 OR (SQLCODE=-18014 OR (SQLCODE=-31443 OR SQLCODE=-32059))))))))) THEN
                       IF v_max_intentos >= v_intentos THEN
                          IF v_intentos = v_max_intentos THEN
                             v_intentos := v_max_intentos + 1;
                          END IF;
                          v_intentos := v_intentos + 1;
                       END IF;
                    ELSE
                       v_intentos := v_max_intentos + 1;
                    END IF;
           END;
       END LOOP;
End p_bloq_stock;

PROCEDURE p_bloq_stock_entrada(v_stock IN al_stock%ROWTYPE,
                       v_error IN OUT ga_abocel.ind_disp%TYPE)
  IS
        v_max_intentos al_series.num_desde%TYPE;
        v_intentos NUMBER(8);
        v_error_x NUMBER(1);
        v_auxiliar     al_stock.cod_bodega%TYPE;
BEGIN
--         p_obtener_maxintentos(v_max_intentos);
         v_max_intentos := 5;
        v_intentos := 0;

        WHILE v_max_intentos >= v_intentos LOOP
             BEGIN
               v_error := 0;
               SELECT cod_bodega INTO v_auxiliar
               FROM al_stock
               WHERE cod_bodega = v_stock.cod_bodega
               AND tip_stock  = v_stock.tip_stock
               AND cod_articulo = v_stock.cod_articulo
               AND cod_uso = v_stock.cod_uso
               AND cod_estado  = v_stock.cod_estado
                  AND cod_plaza   = v_stock.cod_plaza
               AND num_desde = NVL(v_stock.num_desde,0)
               FOR UPDATE NOWAIT;
               v_error := 0;
               v_intentos := v_max_intentos + 1;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN
                    v_error := 3;
                    v_intentos := v_max_intentos + 1;
               WHEN OTHERS THEN
            v_error := 1;
               IF (SQLCODE=-54 OR (SQLCODE=-60 OR (SQLCODE=-99 OR (SQLCODE=-104 OR (SQLCODE=-2049 OR (SQLCODE=-4020 OR (SQLCODE=-12829 OR (SQLCODE=-18014 OR (SQLCODE=-31443 OR SQLCODE=-32059))))))))) THEN
                  IF v_max_intentos >= v_intentos THEN
                     IF v_intentos = v_max_intentos THEN
                        v_intentos := v_max_intentos + 1;
                     END IF;
                     v_intentos := v_intentos + 1;
                  END IF;
               ELSE
                  v_intentos := v_max_intentos + 1;
               END IF;
            END;
        END LOOP;
END p_bloq_stock_entrada;


Procedure p_bloq_stock_doc(v_movim IN al_movimientos%ROWTYPE,
                       v_error IN OUT ga_abocel.ind_disp%TYPE)
  IS
                v_max_intentos al_series.num_desde%TYPE;
                v_intentos NUMBER(8);
                v_error_x NUMBER(1);
                v_auxiliar     al_stock.cod_bodega%TYPE;
Begin
--         p_obtener_maxintentos(v_max_intentos);
         v_max_intentos := 5;
         v_intentos := 0;
        WHILE v_max_intentos >= v_intentos LOOP
         BEGIN
           v_error := 0;
           SELECT cod_bodega INTO v_auxiliar
           FROM al_stock
           WHERE cod_bodega  = v_movim.cod_bodega
           AND tip_stock  = v_movim.tip_stock
           AND cod_articulo = v_movim.cod_articulo
           AND cod_uso = v_movim.cod_uso
           AND cod_estado  = v_movim.cod_estado
           AND num_desde <= NVL(v_movim.num_desde,0)
           AND num_hasta >= v_movim.num_hasta
           AND cod_Plaza = v_movim.cod_Plaza  /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
           FOR UPDATE NOWAIT;
             v_error := 0;
         v_intentos := v_max_intentos + 1;
        EXCEPTION
          WHEN OTHERS THEN
            v_error := 1;
            IF (SQLCODE=-54 OR (SQLCODE=-60 OR (SQLCODE=-99 OR (SQLCODE=-104 OR (SQLCODE=-2049 OR (SQLCODE=-4020 OR (SQLCODE=-12829 OR (SQLCODE=-18014 OR (SQLCODE=-31443 OR SQLCODE=-32059))))))))) THEN
                   IF v_max_intentos >= v_intentos THEN
                      IF v_intentos = v_max_intentos THEN
                 v_intentos := v_max_intentos + 1;
             END IF;
             v_intentos := v_intentos + 1;
          END IF;
                ELSE
                   v_intentos := v_max_intentos + 1;
            END IF;
      END;
     END LOOP;
End p_bloq_stock_doc;

END Al_Proc_Movto; 
/
SHOW ERROR