CREATE OR REPLACE PACKAGE BODY          "AL_PAC_VALIDACIONES"  IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PAC_VALIDACIONES
-- * Descripcisn        : Rutinas de recuperacisn de datos genericos
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
  PROCEDURE p_existe_estado_stock(
  v_estado IN al_stock.cod_estado%TYPE ,
  v_error IN OUT NUMBER )
  IS
        BEGIN
           SELECT 1 INTO v_error
                  FROM al_stock
                  WHERE cod_estado = v_estado;
        EXCEPTION
           WHEN TOO_MANY_ROWS THEN
                v_error := 1;
           WHEN OTHERS THEN
                v_error := 0;
        END p_existe_estado_stock;
  PROCEDURE p_existe_uso_stock(
  v_uso IN al_stock.cod_uso%TYPE ,
  v_error IN OUT NUMBER )
  IS
        BEGIN
           SELECT 1 INTO v_error
                  FROM al_stock
                  WHERE cod_uso = v_uso;
        EXCEPTION
           WHEN TOO_MANY_ROWS THEN
                v_error := 1;
           WHEN OTHERS THEN
                v_error := 0;
        END p_existe_uso_stock;

/**********************************************************************************************************/
PROCEDURE p_obtiene_tipmovim (v_tipmovim IN al_movimientos.tip_movimiento%TYPE ,
                                                          v_entsal IN OUT al_tipos_movimientos.ind_entsal%TYPE ) IS
BEGIN
        SELECT ind_entsal INTO v_entsal
        FROM al_tipos_movimientos
        WHERE tip_movimiento  = v_tipmovim;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20130,'<ALMACEN> Tipo movimiento Incorrecto' || TO_CHAR(SQLCODE));
END p_obtiene_tipmovim;
/**********************************************************************************************************/
PROCEDURE p_obtiene_valoracion(v_tipstock IN al_movimientos.tip_stock%TYPE ,
                                                                 v_valoracion IN OUT al_tipos_stock.ind_valorar%TYPE ) IS
BEGIN
        SELECT ind_valorar INTO v_valoracion
        FROM al_tipos_stock
        WHERE tip_stock = v_tipstock;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20131,'<ALMACEN> Tipo de Stock Incorrecto' || TO_CHAR(SQLCODE));
END p_obtiene_valoracion;
/**********************************************************************************************************/
PROCEDURE p_obtiene_documento(v_documento IN OUT al_datos_generales.tip_articulo_doc%TYPE ) IS
BEGIN
        SELECT tip_articulo_doc INTO v_documento
        FROM al_datos_generales;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20132,'<ALMACEN> Datos Generales '|| TO_CHAR(SQLCODE));
END p_obtiene_documento;
PROCEDURE p_obtiene_meses(v_articulo IN al_articulos.cod_articulo%TYPE ,v_meses IN OUT al_articulos.mes_afijo%TYPE )IS
BEGIN
        SELECT mes_afijo
        INTO v_meses
        FROM al_articulos
        WHERE cod_articulo = v_articulo;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20133,'<ALMACEN> Articulos'|| TO_CHAR(SQLCODE));
END p_obtiene_meses;
PROCEDURE p_obtiene_mes_ingreso(v_serie IN al_series.num_serie%TYPE ,v_mescompra IN OUT al_series.fec_entrada%TYPE ) IS
BEGIN
        SELECT fec_entrada INTO v_mescompra
        FROM al_series
        WHERE num_serie = v_serie;
EXCEPTION
        WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR (-20139,'<ALMACEN> Series '|| TO_CHAR(SQLCODE));
END p_obtiene_mes_ingreso;
  PROCEDURE p_obtiene_tipoart(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_tipo IN OUT al_articulos.tip_articulo%TYPE )
  IS
        BEGIN
           SELECT tip_articulo INTO v_tipo
                  FROM al_articulos
                  WHERE cod_articulo = v_articulo;
        EXCEPTION
           WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR (-20139,'<ALMACEN> Articulos '
                                       || TO_CHAR(SQLCODE));
        END p_obtiene_tipoart;
  PROCEDURE p_obtiene_moneda(
  v_moneda IN OUT al_datos_generales.cod_moneda_val%TYPE )
  IS
        BEGIN
           SELECT cod_moneda_val INTO v_moneda
                  FROM al_datos_generales;
        EXCEPTION
           WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR
                  (-20149,'<ALMACEN> Error Lectura Moneda Valoracion '
                   || TO_CHAR(SQLCODE));
        END p_obtiene_moneda;
  PROCEDURE p_convertir_precio(
  v_moneda_in IN al_movimientos.cod_moneda%TYPE ,
  v_moneda_out IN OUT al_datos_generales.cod_moneda_val%TYPE ,
  v_precio_in IN NUMBER ,
  v_precio_out IN OUT NUMBER ,
  v_fec_cambio IN DATE )
  IS
          v_cambio_in    ge_conversion.cambio%TYPE;
          v_cambio_out   ge_conversion.cambio%TYPE;
          v_decim        ge_monedas.num_decimal%TYPE;
        BEGIN
          p_decimales (v_moneda_out,
                       v_decim);
          p_obtiene_cambio (v_moneda_in,
                            v_cambio_in,
                            v_fec_cambio);
          p_obtiene_cambio (v_moneda_out,
                            v_cambio_out,
                            v_fec_cambio);
          v_precio_out := ROUND(((v_precio_in * v_cambio_in)
          / v_cambio_out),v_decim);
        EXCEPTION
          WHEN OTHERS THEN
               RAISE_APPLICATION_ERROR(-20147,'Error Conversion Precio');
        END p_convertir_precio;
  PROCEDURE p_obtiene_cambio(
  v_moneda IN ge_conversion.cod_moneda%TYPE ,
  v_cambio IN OUT ge_conversion.cambio%TYPE ,
  v_fec_cambio IN DATE )
  IS
        BEGIN
           SELECT cambio INTO v_cambio
                  FROM ge_conversion
                  WHERE cod_moneda = v_moneda
                    AND v_fec_cambio BETWEEN fec_desde AND fec_hasta;
        EXCEPTION
           WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR (-20186,'<ALMACEN> Error Lectura cambio
  '
                                         || TO_CHAR(SQLCODE));
        END p_obtiene_cambio;
  PROCEDURE p_actuacion(
  v_actuacion IN icg_actuacion.cod_actuacion%TYPE ,
  v_tipo IN OUT CHAR )
  IS
          v_act ga_actabo.cod_actcen%TYPE;
                  v_act_gsm ga_actabo.cod_actcen%TYPE;
          v_des ga_actabo.cod_actcen%TYPE;
        BEGIN
--             SELECT cod_actuacion_act,cod_actuacion_des,cod_actuacion_act_gsm
--             INTO v_act,v_des,v_act_gsm
--             FROM al_datos_generales;
			   		--
				   	 SELECT cod_actcen
					 INTO   v_act
					 FROM   ga_actabo
					 WHERE  cod_modulo ='AL'
					 AND    cod_producto = 1
			 		 AND    cod_tecnologia ='CDMA'
					 AND    cod_actabo ='AA';
			 		 --
					 SELECT cod_actcen
					 INTO   v_des
					 FROM   ga_actabo
					 WHERE  cod_modulo ='AL'
					 AND    cod_producto = 1
			 		 AND    cod_tecnologia ='CDMA'
					 AND    cod_actabo ='MI';
					 --
					 SELECT cod_actcen
					 INTO   v_act_gsm
					 FROM   ga_actabo
					 WHERE  cod_modulo ='AL'
					 AND    cod_producto = 1
			 		 AND    cod_tecnologia ='GSM'
					 AND    cod_actabo ='AG';


          IF v_act = v_actuacion THEN
             v_tipo := 'A';
          ELSE
                    IF v_act_gsm=v_actuacion THEN
                      SELECT val_parametro
                          INTO v_tipo
                          FROM ged_parametros
                          WHERE cod_producto=1 AND
                              cod_modulo='AL' AND
                                  nom_parametro='COD_SIMCARD_GSM';
                    ELSE
             v_tipo := 'D';
            END IF;
                  END IF;
        END p_actuacion;
  PROCEDURE p_obtiene_ejercicio(
  v_ini_ejer IN OUT al_cierres_alma.fec_inicio%TYPE ,
  v_fin_ejer IN OUT al_cierres_alma.fec_fin%TYPE ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%TYPE) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
        BEGIN
           SELECT fec_inicio,fec_fin
             INTO v_ini_ejer,v_fin_ejer
             FROM al_cierres_alma
            WHERE ind_cerrado = 0
                          AND cod_operadora_scl = v_operadora -- 30-12-2002 Modificacion multiempresa Ulises Uribe
              AND ROWNUM = 1
            ORDER BY fec_inicio;
        EXCEPTION
           WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR (-20175,'Error Obtencion Ejercicio'
                                         || TO_CHAR(SQLCODE));
        END p_obtiene_ejercicio;
  PROCEDURE p_inserta_movim(
  v_movim IN al_movimientos%ROWTYPE )
  IS
        BEGIN
           INSERT INTO al_movimientos (num_movimiento,
                                       tip_movimiento,
                                       fec_movimiento,
                                       tip_stock,
                                       cod_bodega,
                                       cod_articulo,
                                       cod_uso,
                                       cod_estado,
                                       num_cantidad,
                                       cod_estadomov,
                                       nom_usuarora,
                                       tip_stock_dest,
                                       cod_bodega_dest,
                                       cod_uso_dest,
                                       cod_estado_dest,
                                       num_serie,
                                       num_desde,
                                       num_hasta,
                                       num_guia,
                                       prc_unidad,
                                       cod_transaccion,
                                       num_transaccion,
                                       num_seriemec,
                                       num_telefono,
                                       cap_code,
                                       cod_producto,
                                       cod_central,
                                       cod_moneda,
                                       cod_subalm,
                                       cod_central_dest,
                                       cod_subalm_dest,
                                       num_telefono_dest,
                                       cod_cat,
                                       cod_cat_dest,
                                       ind_telefono,
                                       PLAN,
                                       carga,
                                       num_sec_loca,
                                                                           cod_plaza,
                                                                           cod_hlr) /* AARM. agrego cod_plaza, diciembre 2002 */
                               VALUES (v_movim.num_movimiento,
                                       v_movim.tip_movimiento,
                                       v_movim.fec_movimiento,
                                       v_movim.tip_stock,
                                       v_movim.cod_bodega,
                                       v_movim.cod_articulo,
                                       v_movim.cod_uso,
                                       v_movim.cod_estado,
                                       v_movim.num_cantidad,
                                       v_movim.cod_estadomov,
                                       v_movim.nom_usuarora,
                                       v_movim.tip_stock_dest,
                                       v_movim.cod_bodega_dest,
                                       v_movim.cod_uso_dest,
                                       v_movim.cod_estado_dest,
                                       v_movim.num_serie,
                                       v_movim.num_desde,
                                       v_movim.num_hasta,
                                       v_movim.num_guia,
                                       v_movim.prc_unidad,
                                       v_movim.cod_transaccion,
                                       v_movim.num_transaccion,
                                       v_movim.num_seriemec,
                                       v_movim.num_telefono,
                                       v_movim.cap_code,
                                       v_movim.cod_producto,
                                       v_movim.cod_central,
                                       v_movim.cod_moneda,
                                       v_movim.cod_subalm,
                                       v_movim.cod_central_dest,
                                       v_movim.cod_subalm_dest,
                                       v_movim.num_telefono_dest,
                                       v_movim.cod_cat,
                                       v_movim.cod_cat_dest,
                                       v_movim.ind_telefono,
                                                                           v_movim.PLAN,
                                                                   v_movim.carga,
                                       v_movim.num_sec_loca,
                                                                           v_movim.cod_plaza,
                                                                           v_movim.cod_hlr);
--      if (SQLCODE != 0) then
--      end if;
        EXCEPTION
           WHEN OTHERS THEN
        IF (TO_CHAR(SQLCODE) = '-20155') THEN
         RAISE_APPLICATION_ERROR(-20155, '<ALMACEN>, Registro de Stock bloqueado
                 temporalmente por otro usuario');
        ELSE
             RAISE_APPLICATION_ERROR(-20183 ,'<ALMACEN> Error al generar movimiento'|| TO_CHAR(SQLCODE));
       END IF;
        END p_inserta_movim;
  PROCEDURE p_decimales(
  v_moneda IN ge_monedas.cod_moneda%TYPE ,
  v_decim IN OUT ge_monedas.num_decimal%TYPE )
  IS
        BEGIN
           SELECT num_decimal INTO v_decim
                  FROM ge_monedas
                  WHERE cod_moneda = v_moneda;
        EXCEPTION
           WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20185,'Error Obtencion decimales'
                                        || TO_CHAR(SQLCODE));
        END p_decimales;
  PROCEDURE p_obtiene_producto(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_producto IN OUT al_articulos.cod_producto%TYPE )
  IS
          BEGIN
             SELECT cod_producto INTO v_producto
                    FROM al_articulos
          WHERE cod_articulo = v_articulo;
          EXCEPTION
             WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20185,'Error Obtencion Producto'
                                          || TO_CHAR(SQLCODE));
        END p_obtiene_producto;
  PROCEDURE p_existe_mercaderia(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_ejercicio IN al_cierres_alma.fec_inicio%TYPE ,
  v_existe IN OUT NUMBER,
  v_operadora  IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
  IS
        BEGIN
           SELECT 1 INTO v_existe
                  FROM al_pmp_articulo
                  WHERE cod_articulo  = v_articulo
                    AND fec_periodo = v_ejercicio
                                        AND cod_operadora_scl = v_operadora; -- 30-12-2002 Modificacion multiempresa Ulises Uribe
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
                v_existe := 0;
           WHEN OTHERS THEN
                v_existe := 1;
        END p_existe_mercaderia;
END AL_PAC_VALIDACIONES;
/
SHOW ERRORS
