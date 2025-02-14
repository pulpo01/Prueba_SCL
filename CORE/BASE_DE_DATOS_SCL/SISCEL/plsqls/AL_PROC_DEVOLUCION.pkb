CREATE OR REPLACE PACKAGE BODY          "AL_PROC_DEVOLUCION" 
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : Al_Proc_Devolucion
-- * Descripción        : Rutinas para procesos de devolucion
-- * Fecha de creación  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************

  CN_tres  CONSTANT PLS_INTEGER :=3;

  PROCEDURE p_trata_devprov(v_orden IN al_cabecera_ordenes.num_orden%TYPE ,
  						  	v_estorden IN al_cabecera_ordenes.cod_estado%TYPE ,
  							v_bodega IN al_cabecera_ordenes.cod_bodega%TYPE )
  IS
      v_linord al_vlineas_ordenes%ROWTYPE;
      v_seriado al_articulos.ind_seriado%TYPE;
      v_reserva al_datos_generales.cod_estado_res%TYPE;
      v_movim   al_movimientos%ROWTYPE;
      v_peticion al_petiguias_alma%ROWTYPE;
      CURSOR c_linord(v_orden al_cabecera_ordenes.num_orden%TYPE ,
	                  v_tip_orden al_cabecera_ordenes.tip_orden%TYPE)
	  IS
          SELECT num_orden, tip_orden, num_linea, cod_articulo, can_orden, can_servida, cod_causa, can_series, tip_stock, cod_uso, cod_estado, prc_unidad, num_linea_ref, tip_movimiento, can_orden_ing, num_desde, num_hasta, prc_ff, prc_adic, num_sec_loca, cod_plaza, cod_metodo_carga, cod_grpconcepto
		  FROM al_lineas_ordenes3
          WHERE num_orden = v_orden
           AND  tip_orden = v_tip_orden;

  BEGIN
      p_obtiene_estados (v_reserva);

	  v_movim.fec_movimiento      := SYSDATE;
      v_movim.cod_bodega          := v_bodega;
      v_movim.nom_usuarora        := USER;
      v_movim.cod_estadomov       := 'SO';
      IF v_estorden = 'PA' THEN
         v_movim.cod_estado_dest  := v_reserva;
         v_peticion.num_peticion  := NULL;
      ELSE
         v_movim.cod_estado_dest  := NULL;
         p_obtiene_peticion (v_peticion.num_peticion);
         v_peticion.tip_petidor   := 1;
         v_peticion.num_petidor   := v_orden;
         p_genera_peticion_guia (v_peticion);
      END IF;
      v_movim.tip_stock_dest      := NULL;
      v_movim.cod_bodega_dest     := NULL;
      v_movim.cod_uso_dest        := NULL;
      v_movim.num_guia            := NULL;
      v_movim.cod_transaccion     := 6;
      v_movim.num_transaccion     := v_orden;

      FOR v_linord IN c_linord(v_orden, CN_tres) LOOP

		  v_movim.tip_movimiento    := v_linord.tip_movimiento;
          v_movim.tip_stock         := v_linord.tip_stock;
          v_movim.cod_articulo      := v_linord.cod_articulo;
          v_movim.cod_uso           := v_linord.cod_uso;
          IF v_estorden ='PA' THEN
            v_movim.cod_estado     := v_linord.cod_estado;
          ELSE
            v_movim.cod_estado     := v_reserva;
          END IF;
          v_movim.cod_central_dest  := NULL;
          v_movim.cod_subalm_dest   := NULL;
          v_movim.num_telefono_dest := NULL;
          v_movim.cod_cat_dest      := NULL;
		  v_movim.prc_unidad        := v_linord.prc_unidad;

          p_obtiene_seriado (v_linord.cod_articulo,v_seriado);
          IF v_seriado = 1 THEN
             v_movim.num_cantidad := 1;
             p_proceso_seriados (v_orden,v_estorden,v_linord.num_linea,v_linord.cod_uso,v_movim);
          ELSE
             v_movim.num_cantidad := v_linord.can_orden;
             v_movim.num_serie    := NULL;
             IF v_linord.num_desde IS NULL THEN
                v_movim.num_desde := 0;
             ELSE
                v_movim.num_desde    := v_linord.num_desde;
             END IF;
             v_movim.num_hasta       := v_linord.num_hasta;
             v_movim.num_seriemec    := NULL;
             v_movim.num_telefono    := NULL;
             v_movim.cap_code        := NULL;
             v_movim.cod_producto    := NULL;
             v_movim.cod_central     := NULL;
             v_movim.cod_moneda      := NULL;
             v_movim.cod_subalm      := NULL;
             v_movim.cod_cat         := NULL;
             v_movim.num_sec_loca    := v_linord.num_sec_loca;
             p_select_movimiento (v_movim.num_movimiento);
             Al_Pac_Validaciones.p_inserta_movim (v_movim);
          END IF;
      END LOOP;
  END p_trata_devprov;


  PROCEDURE p_proceso_seriados(v_orden IN al_cabecera_ordenes.num_orden%TYPE,
  							   v_estorden IN al_cabecera_ordenes.cod_estado%TYPE ,
  							   v_linea IN al_lineas_ordenes.num_linea%TYPE ,
  							   v_uso IN al_lineas_ordenes.cod_uso%TYPE ,
							   v_movim IN OUT NOCOPY al_movimientos%ROWTYPE )
  IS
       v_serord al_vseries_ordenes%ROWTYPE;
       v_reutil ga_celnum_reutil%ROWTYPE;
       CURSOR c_serord IS
              SELECT *
			  FROM al_vseries_ordenes
              WHERE num_orden = v_orden
              AND tip_orden = 3
              AND num_linea = v_linea;
        v_terminal al_articulos.tip_terminal%TYPE;
        v_indtelefono al_series.ind_telefono%TYPE;
        v_actuacion al_datos_generales.cod_actuacion_des%TYPE;
        v_serhex al_fic_series.num_serhex%TYPE;
        v_prefijo al_usos_min.num_min%TYPE;
  BEGIN
       FOR v_serord IN c_serord LOOP
           v_movim.num_cantidad      := 1;
           v_movim.num_serie         := v_serord.num_serie;
           v_movim.num_desde         := 0;
           v_movim.num_hasta         := NULL;
           v_movim.num_seriemec      := v_serord.num_seriemec;
           v_movim.num_telefono      := v_serord.num_telefono;
           v_movim.cap_code          := v_serord.cap_code;
           v_movim.cod_producto      := v_serord.cod_producto;
           v_movim.cod_central       := v_serord.cod_central;
           v_movim.cod_moneda        := NULL;
           v_movim.cod_subalm        := v_serord.cod_subalm;
           v_movim.cod_cat           := v_serord.cod_cat;
           v_movim.num_sec_loca      := v_serord.num_sec_loca;
           p_select_movimiento(v_movim.num_movimiento);
             --------------------------------------------------
             -- Recoge el indicativo de telefono para proceder
             -- a la desactivacion si procede
             --------------------------------------------------
           IF v_estorden IN ('CE','PE')  AND
              v_serord.num_telefono IS NOT NULL THEN
               Al_Proc_Es_Extra.p_select_ind_telefono
                                (v_serord.num_serie,
                                                           v_indtelefono);
             END IF;
             --------------------------------------------------
             Al_Pac_Validaciones.p_inserta_movim (v_movim);
           IF v_estorden IN ('CE','PE')  AND
    -- En caso de suponer la salida de una serie de equipo celular se libera el
    -- numero y si procede se desactiva
              v_serord.num_telefono IS NOT NULL THEN
              v_reutil.num_celular  := v_serord.num_telefono;
              v_reutil.cod_subalm   := v_serord.cod_subalm;
              v_reutil.cod_producto := v_serord.cod_producto;
              v_reutil.cod_central  := v_serord.cod_central;
              v_reutil.cod_cat      := v_serord.cod_cat;
              v_reutil.cod_uso      := v_uso;
              Al_Pac_Numeracion.p_libera_numero (v_reutil);
                  IF v_indtelefono > 1 THEN
                          Al_Proc_Ingreso.p_select_terminal
                                                (v_movim.cod_articulo,
                                                  v_terminal);
                                  Al_Proc_Ingreso.p_select_actuacion(v_actuacion,v_uso,v_reutil.cod_central);
                                  select al_fn_prefijo_numero(v_reutil.num_celular)
                                  into v_prefijo
                                  from dual;
                                  v_serhex:=null;
                                  Al_Proc_Es_Extra.p_conv_serhex(v_serord.num_serie ,v_serhex );
                                  Al_Proc_Ingreso.p_desactiva_central (v_actuacion,v_prefijo,
                                                                               v_serord.cod_central,
                                                                               v_serord.num_telefono,
                                                                               v_serhex,
                                                                               v_terminal,
                                                                                                                                                           v_serord.num_serie);
                  END IF;
           END IF;
       END LOOP;
    END p_proceso_seriados;



  PROCEDURE p_obtiene_estados(v_reserva IN OUT NOCOPY  al_datos_generales.cod_estado_res%TYPE )
  IS
  BEGIN
       SELECT cod_estado_res
              INTO v_reserva
              FROM al_datos_generales;
  EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20180,'Error lectura Datos Generales');
  END p_obtiene_estados;



  PROCEDURE p_obtiene_seriado(v_articulo IN al_articulos.cod_articulo%TYPE ,
  							  v_seriado IN OUT NOCOPY  al_articulos.ind_seriado%TYPE )
  IS
    BEGIN
       SELECT ind_seriado INTO v_seriado
              FROM al_articulos
              WHERE cod_articulo = v_articulo;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20181,'Error lectura Articulos');
    END p_obtiene_seriado;


  PROCEDURE p_borrado_linord3(v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  							  v_tstock IN al_lineas_ordenes3.tip_stock%TYPE ,
							  v_articulo IN al_lineas_ordenes3.cod_articulo%TYPE ,
							  v_uso IN al_lineas_ordenes3.cod_uso%TYPE ,
							  v_estado IN al_lineas_ordenes3.cod_estado%TYPE ,
							  v_cantidad IN al_lineas_ordenes3.can_orden%TYPE ,
							  v_tipmovim IN al_lineas_ordenes3.tip_movimiento%TYPE ,
							  v_numdesde IN al_lineas_ordenes3.num_desde%TYPE ,
							  v_numhasta IN al_lineas_ordenes3.num_hasta%TYPE )
  IS
      v_seriado      al_articulos.ind_seriado%TYPE;
      v_estorden     al_cabecera_ordenes3.cod_estado%TYPE;
      v_bodega       al_cabecera_ordenes3.cod_bodega%TYPE;
      v_reserva      al_datos_generales.cod_estado_res%TYPE;
      v_movim        al_movimientos%ROWTYPE;
  BEGIN
      p_obtiene_seriado (v_articulo,v_seriado);
      IF v_seriado = 0 THEN
         p_obtiene_cabord(v_orden,v_estorden,v_bodega);
         IF v_estorden = 'PA' THEN
            p_obtiene_estados (v_reserva);
            v_movim.tip_movimiento       := v_tipmovim;
            v_movim.fec_movimiento       := SYSDATE;
            v_movim.tip_stock            := v_tstock;
            v_movim.cod_bodega           := v_bodega;
            v_movim.cod_articulo         := v_articulo;
            v_movim.cod_uso              := v_uso;
            v_movim.cod_estado           := v_reserva;
            v_movim.num_cantidad         := v_cantidad;
            v_movim.cod_estadomov        := 'SO';
            v_movim.nom_usuarora         := USER;
            v_movim.tip_stock_dest       := NULL;
            v_movim.cod_bodega_dest      := NULL;
            v_movim.cod_uso_dest         := NULL;
            v_movim.cod_estado_dest      := v_estado;
            v_movim.num_serie            := NULL;
            IF v_numdesde IS NULL THEN
               v_movim.num_desde         := 0;
            ELSE
               v_movim.num_desde         := v_numdesde;
            END IF;
            v_movim.num_hasta            := v_numhasta;
            v_movim.num_guia             := NULL;
            v_movim.prc_unidad           := NULL;
            v_movim.cod_transaccion      := 6;
            v_movim.num_transaccion      := v_orden;
            v_movim.num_seriemec         := NULL;
            v_movim.num_telefono         := NULL;
            v_movim.cap_code             := NULL;
            v_movim.cod_producto         := NULL;
            v_movim.cod_central          := NULL;
            v_movim.cod_moneda           := NULL;
            v_movim.cod_subalm           := NULL;
            v_movim.cod_central_dest     := NULL;
            v_movim.cod_subalm_dest      := NULL;
            v_movim.num_telefono_dest    := NULL;
            v_movim.cod_cat              := NULL;
            v_movim.cod_cat_dest         := NULL;
            p_select_movimiento (v_movim.num_movimiento);
            Al_Pac_Validaciones.p_inserta_movim (v_movim);
         END IF;
      END IF;
    END p_borrado_linord3;

  PROCEDURE p_borrado_serord3(v_serord IN al_series_ordenes3%ROWTYPE )
  IS
      v_tstock     al_lineas_ordenes3.tip_stock%TYPE;
      v_articulo   al_lineas_ordenes3.cod_articulo%TYPE;
      v_uso        al_lineas_ordenes3.cod_uso%TYPE;
      v_estado     al_lineas_ordenes3.cod_estado%TYPE;
      v_tipmovim   al_lineas_ordenes3.tip_movimiento%TYPE;
      v_numdesde   al_lineas_ordenes3.num_desde%TYPE;
      v_numhasta   al_lineas_ordenes3.num_hasta%TYPE;
      v_estorden   al_cabecera_ordenes3.cod_estado%TYPE;
      v_bodega     al_cabecera_ordenes3.cod_bodega%TYPE;
      v_reserva    al_datos_generales.cod_estado_res%TYPE;
      v_movim      al_movimientos%ROWTYPE;
    BEGIN
      p_obtiene_cabord (v_serord.num_orden,v_estorden,v_bodega);
      IF v_estorden = 'PA' THEN
         p_obtiene_linea (v_serord.num_orden,v_serord.num_linea,v_tstock,v_articulo,
                          v_uso,v_estado,v_tipmovim,v_numdesde,v_numhasta);
         v_movim.tip_movimiento   := v_tipmovim;
         v_movim.fec_movimiento   := SYSDATE;
         v_movim.tip_stock        := v_tstock;
         v_movim.cod_bodega       := v_bodega;
         v_movim.cod_articulo     := v_articulo;
         v_movim.cod_uso          := v_uso;
         p_obtiene_estados (v_reserva);
         v_movim.cod_estado       := v_reserva;
         v_movim.num_cantidad     := 1;
         v_movim.cod_estadomov    := 'SO';
         v_movim.nom_usuarora     := USER;
         v_movim.tip_stock_dest   := NULL;
         v_movim.cod_bodega_dest  := NULL;
         v_movim.cod_uso_dest     := NULL;
         v_movim.cod_estado_dest  := v_estado;
         v_movim.num_serie        := v_serord.num_serie;
         IF v_numdesde IS NOT NULL THEN
            v_movim.num_desde     := v_numdesde;
         ELSE
            v_movim.num_desde     := 0;
         END IF;
         v_movim.num_hasta         := v_numhasta;
         v_movim.num_guia          := NULL;
         v_movim.prc_unidad        := NULL;
         v_movim.cod_transaccion   := 6;
         v_movim.num_transaccion   := v_serord.num_orden;
         v_movim.num_seriemec      := v_serord.num_seriemec;
         v_movim.num_telefono      := v_serord.num_telefono;
         v_movim.cap_code          := v_serord.cap_code;
         v_movim.cod_producto      := v_serord.cod_producto;
         v_movim.cod_central       := v_serord.cod_central;
         v_movim.cod_moneda        := NULL;
         v_movim.cod_subalm        := v_serord.cod_subalm;
         v_movim.cod_central_dest  := NULL;
         v_movim.cod_subalm_dest   := NULL;
         v_movim.num_telefono_dest := NULL;
         v_movim.cod_cat           := v_serord.cod_cat;
         v_movim.cod_cat_dest      := NULL;
         p_select_movimiento (v_movim.num_movimiento);
         Al_Pac_Validaciones.p_inserta_movim(v_movim);
      END IF;
    END p_borrado_serord3;

  PROCEDURE p_inserta_serord3(v_serord IN al_series_ordenes3%ROWTYPE )
  IS
      v_tstock     al_lineas_ordenes3.tip_stock%TYPE;
      v_articulo   al_lineas_ordenes3.cod_articulo%TYPE;
      v_uso        al_lineas_ordenes3.cod_uso%TYPE;
      v_estado     al_lineas_ordenes3.cod_estado%TYPE;
      v_tipmovim   al_lineas_ordenes3.tip_movimiento%TYPE;
      v_numdesde   al_lineas_ordenes3.num_desde%TYPE;
      v_numhasta   al_lineas_ordenes3.num_hasta%TYPE;
      v_estorden   al_cabecera_ordenes3.cod_estado%TYPE;
      v_bodega     al_cabecera_ordenes3.cod_bodega%TYPE;
      v_reserva    al_datos_generales.cod_estado_res%TYPE;
      v_movim      al_movimientos%ROWTYPE;
    BEGIN

      p_obtiene_cabord (v_serord.num_orden,v_estorden,v_bodega);
      IF v_estorden = 'PA' THEN
         p_obtiene_linea (v_serord.num_orden,
                          v_serord.num_linea,
                          v_tstock,
                          v_articulo,
                          v_uso,
                          v_estado,
                          v_tipmovim,
                          v_numdesde,
                          v_numhasta);
         v_movim.tip_movimiento   := v_tipmovim;
         v_movim.fec_movimiento   := SYSDATE;
         v_movim.tip_stock        := v_tstock;
         v_movim.cod_bodega       := v_bodega;
         v_movim.cod_articulo     := v_articulo;
         v_movim.cod_uso          := v_uso;
         v_movim.cod_estado       := v_estado;
         v_movim.num_cantidad     := 1;
         v_movim.cod_estadomov    := 'SO';
         v_movim.nom_usuarora     := USER;
         v_movim.tip_stock_dest   := NULL;
         v_movim.cod_bodega_dest  := NULL;
         v_movim.cod_uso_dest     := NULL;
         p_obtiene_estados (v_reserva);
         v_movim.cod_estado_dest  := v_reserva;
         v_movim.num_serie        := v_serord.num_serie;
         IF v_numdesde IS NOT NULL THEN
            v_movim.num_desde     := v_numdesde;
         ELSE
            v_movim.num_desde     := 0;
         END IF;
         v_movim.num_hasta         := v_numhasta;
         v_movim.num_guia          := NULL;
         v_movim.prc_unidad        := NULL;
         v_movim.cod_transaccion   := 6;
         v_movim.num_transaccion   := v_serord.num_orden;
         v_movim.num_seriemec      := v_serord.num_seriemec;
         v_movim.num_telefono      := v_serord.num_telefono;
         v_movim.cap_code          := v_serord.cap_code;
         v_movim.cod_producto      := v_serord.cod_producto;
         v_movim.cod_central       := v_serord.cod_central;
         v_movim.cod_moneda        := NULL;
         v_movim.cod_subalm        := v_serord.cod_subalm;
         v_movim.cod_central_dest  := NULL;
         v_movim.cod_subalm_dest   := NULL;
         v_movim.num_telefono_dest := NULL;
         v_movim.cod_cat           := v_serord.cod_cat;
         v_movim.cod_cat_dest      := NULL;
         p_select_movimiento (v_movim.num_movimiento);
         Al_Pac_Validaciones.p_inserta_movim(v_movim);
      END IF;
    END p_inserta_serord3;

  PROCEDURE p_cambio_cantidad(v_orden IN al_lineas_ordenes3.num_orden%TYPE,
  							  v_tstock IN al_lineas_ordenes3.tip_stock%TYPE ,
							  v_articulo IN al_lineas_ordenes3.cod_articulo%TYPE ,
							  v_uso IN al_lineas_ordenes3.cod_uso%TYPE ,
							  v_estado IN al_lineas_ordenes3.cod_estado%TYPE ,
							  v_can_old IN al_lineas_ordenes3.can_orden%TYPE ,
							  v_can_new IN al_lineas_ordenes3.can_orden%TYPE ,
							  v_tipmovim IN al_lineas_ordenes3.tip_movimiento%TYPE ,
							  v_desde_old IN al_lineas_ordenes3.num_desde%TYPE ,
							  v_desde_new IN al_lineas_ordenes3.num_desde%TYPE ,
							  v_hasta_old IN al_lineas_ordenes3.num_hasta%TYPE ,
							  v_hasta_new IN al_lineas_ordenes3.num_hasta%TYPE,
							  EN_prc_unidad IN al_lineas_ordenes3.prc_unidad%type)
  IS
       v_estorden   al_cabecera_ordenes3.cod_estado%TYPE;
       v_bodega     al_cabecera_ordenes3.cod_bodega%TYPE;
       v_reserva    al_datos_generales.cod_estado_res%TYPE;
       v_seriado    al_articulos.ind_seriado%TYPE;
       v_movim      al_movimientos%ROWTYPE;
  BEGIN
       p_obtiene_seriado (v_articulo,v_seriado);
       IF v_seriado = 0 THEN
          p_obtiene_cabord (v_orden,v_estorden,v_bodega);
          IF v_estorden = 'PA' THEN
             p_obtiene_estados (v_reserva);
             v_movim.tip_movimiento       := v_tipmovim;
             v_movim.fec_movimiento       := SYSDATE;
             v_movim.tip_stock            := v_tstock;
             v_movim.cod_bodega           := v_bodega;
             v_movim.cod_articulo         := v_articulo;
             v_movim.cod_uso              := v_uso;
             v_movim.cod_estado           := v_reserva;
             v_movim.num_cantidad         := v_can_old;
             v_movim.cod_estadomov        := 'SO';
             v_movim.nom_usuarora         := USER;
             v_movim.tip_stock_dest       := NULL;
             v_movim.cod_bodega_dest      := NULL;
             v_movim.cod_uso_dest         := NULL;
             v_movim.cod_estado_dest      := v_estado;
             v_movim.num_serie            := NULL;
             IF v_desde_old IS NOT NULL THEN
                v_movim.num_desde         := v_desde_old;
             ELSE
                v_movim.num_desde         := 0;
             END IF;
             v_movim.num_hasta            := v_hasta_old;
             v_movim.num_guia             := NULL;
             v_movim.prc_unidad           := EN_prc_unidad;
             v_movim.cod_transaccion      := 6;
             v_movim.num_transaccion      := v_orden;
             v_movim.num_seriemec         := NULL;
             v_movim.num_telefono         := NULL;
             v_movim.cap_code             := NULL;
             v_movim.cod_producto         := NULL;
             v_movim.cod_central          := NULL;
             v_movim.cod_moneda           := NULL;
             v_movim.cod_subalm           := NULL;
             v_movim.cod_central_dest     := NULL;
             v_movim.cod_subalm_dest      := NULL;
             v_movim.num_telefono_dest    := NULL;
             v_movim.cod_cat              := NULL;
             v_movim.cod_cat_dest         := NULL;
             p_select_movimiento (v_movim.num_movimiento);
             Al_Pac_Validaciones.p_inserta_movim (v_movim);
             v_movim.cod_estado           := v_estado;
             v_movim.num_cantidad         := v_can_new;
             v_movim.cod_estado_dest      := v_reserva;
             IF v_desde_new IS NOT NULL THEN
                v_movim.num_desde            := v_desde_new;
             ELSE
                v_movim.num_desde         := 0;
             END IF;
             v_movim.num_hasta            := v_hasta_new;
             v_movim.cod_moneda           := NULL;
             p_select_movimiento(v_movim.num_movimiento);
             Al_Pac_Validaciones.p_inserta_movim (v_movim);
          END IF;
       END IF;
  END p_cambio_cantidad;


  PROCEDURE p_obtiene_cabord(v_orden IN al_cabecera_ordenes3.num_orden%TYPE ,
  							 v_estorden IN OUT NOCOPY al_cabecera_ordenes3.cod_estado%TYPE ,
							 v_bodega IN OUT NOCOPY  al_cabecera_ordenes3.cod_bodega%TYPE )
  IS
    BEGIN
      SELECT cod_estado,cod_bodega
        INTO v_estorden,v_bodega
        FROM al_vcabecera_ordenes
       WHERE num_orden = v_orden AND
             tip_orden = 3;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20175,'Error en Lectura Cabecera'
                                     || TO_CHAR(SQLCODE));
  END p_obtiene_cabord;


  PROCEDURE p_obtiene_linea(v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  							v_linea IN al_lineas_ordenes3.num_linea%TYPE ,
  							v_tstock IN OUT NOCOPY  al_lineas_ordenes3.tip_stock%TYPE ,
 							v_articulo IN OUT NOCOPY  al_lineas_ordenes3.cod_articulo%TYPE ,
							v_uso IN OUT NOCOPY  al_lineas_ordenes3.cod_uso%TYPE ,
							v_estado IN OUT NOCOPY  al_lineas_ordenes3.cod_estado%TYPE ,
							v_tipmovim IN OUT NOCOPY  al_lineas_ordenes3.tip_movimiento%TYPE ,
							v_numdesde IN OUT NOCOPY  al_lineas_ordenes3.num_desde%TYPE ,
							v_numhasta IN OUT NOCOPY  al_lineas_ordenes3.num_hasta%TYPE )
  IS
    BEGIN
       SELECT tip_stock,cod_articulo,cod_uso,cod_estado,tip_movimiento,num_desde,num_hasta
         INTO v_tstock,v_articulo,v_uso,v_estado,v_tipmovim,v_numdesde,v_numhasta
         FROM al_vlineas_ordenes
        WHERE num_orden = v_orden
          AND tip_orden = CN_tres
          AND num_linea = v_linea;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20175,'Error en Lectura Linea');
  END p_obtiene_linea;


  PROCEDURE al_obtiene_precio_pr (EN_orden IN al_lineas_ordenes3.num_orden%TYPE,
  		  					   	  EN_linea IN al_lineas_ordenes3.num_linea%TYPE,
  								  SN_prc_unidad OUT NOCOPY al_lineas_ordenes3.prc_unidad%type)
  IS
  /*	<Documentaci+n TipoDoc = "Procedimiento">
			<Elemento Nombre = "al_obtiene_precio_pr" Lenguaje="PL/SQL" Fecha="24-04-2006" Versi+n="1.0.0" Diseªador="CAZ" Programador="CAZ" Ambiente="BD">
			<Retorno>NA</Retorno>
			<Descripci+n>Pl . </Descripci+n>
			<Par»metros>
			<Entrada>
					 <EN_orden="SV_retorno Tipo="NUMBER">Informaci?n de retorno</param>
					 <EN_linea="SV_retorno Tipo="NUMBER">Informaci?n de retorno</param>
			</Entrada>
			<Salida>
					<SN_prc_unidad="SV_retorno Tipo="NUMBER">Informaci?n de retorno</param>
			</Salida>
			</Par»metros>
			</Elemento>
			</Documentaci+n>
	*/
  BEGIN
    SELECT nvl(prc_unidad,0)
    INTO SN_prc_unidad
    FROM al_lineas_ordenes3
    WHERE num_orden=EN_orden
    AND num_linea=EN_linea;
  EXCEPTION
   WHEN OTHERS THEN
        SN_prc_unidad:=0;
  END al_obtiene_precio_pr;


  PROCEDURE p_inserta_linea(v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  							EN_linea IN al_lineas_ordenes3.num_linea%TYPE ,
							v_tstock IN al_lineas_ordenes3.tip_stock%TYPE ,
							v_articulo IN al_lineas_ordenes3.cod_articulo%TYPE ,
							v_uso IN al_lineas_ordenes3.cod_uso%TYPE ,
							v_estado IN al_lineas_ordenes3.cod_estado%TYPE ,
							v_cantidad IN al_lineas_ordenes3.can_orden%TYPE ,
							v_tipmovim IN al_lineas_ordenes3.tip_movimiento%TYPE ,
							v_numdesde IN al_lineas_ordenes3.num_desde%TYPE ,
							v_numhasta IN al_lineas_ordenes3.num_hasta%TYPE)
  IS
       v_estorden   al_cabecera_ordenes3.cod_estado%TYPE;
       v_bodega     al_cabecera_ordenes3.cod_bodega%TYPE;
       v_reserva    al_datos_generales.cod_estado_res%TYPE;
       v_seriado    al_articulos.ind_seriado%TYPE;
       v_movim      al_movimientos%ROWTYPE;
	   LN_prc_unidad al_lineas_ordenes3.prc_unidad%type:=0;

  BEGIN
       p_obtiene_seriado (v_articulo,v_seriado);
       IF v_seriado = 0 THEN
          p_obtiene_cabord (v_orden,v_estorden,v_bodega);
          IF v_estorden = 'PA' THEN
             p_obtiene_estados (v_reserva);
             v_movim.tip_movimiento       := v_tipmovim;
             v_movim.fec_movimiento       := SYSDATE;
             v_movim.tip_stock            := v_tstock;
             v_movim.cod_bodega           := v_bodega;
             v_movim.cod_articulo         := v_articulo;
             v_movim.cod_uso              := v_uso;
             v_movim.cod_estado           := v_estado;
             v_movim.num_cantidad         := v_cantidad;
             v_movim.cod_estadomov        := 'SO';
             v_movim.nom_usuarora         := USER;
             v_movim.tip_stock_dest       := NULL;
             v_movim.cod_bodega_dest      := NULL;
             v_movim.cod_uso_dest         := NULL;
             v_movim.cod_estado_dest      := v_reserva;
             v_movim.num_serie            := NULL;
             IF v_numdesde IS NOT NULL THEN
                v_movim.num_desde         := v_numdesde;
             ELSE
                v_movim.num_desde         := 0;
             END IF;
             v_movim.num_hasta            := v_numhasta;
             v_movim.num_guia             := NULL;
			 al_obtiene_precio_pr (v_orden,EN_linea,LN_prc_unidad);
             v_movim.prc_unidad           := LN_prc_unidad;
             v_movim.cod_transaccion      := 6;
             v_movim.num_transaccion      := v_orden;
             v_movim.num_seriemec         := NULL;
             v_movim.num_telefono         := NULL;
             v_movim.cap_code             := NULL;
             v_movim.cod_producto         := NULL;
             v_movim.cod_central          := NULL;
             v_movim.cod_moneda           := NULL;
             v_movim.cod_subalm           := NULL;
             v_movim.cod_central_dest     := NULL;
             v_movim.cod_subalm_dest      := NULL;
             v_movim.num_telefono_dest    := NULL;
             v_movim.cod_cat              := NULL;
             v_movim.cod_cat_dest         := NULL;
             p_select_movimiento(v_movim.num_movimiento);
             Al_Pac_Validaciones.p_inserta_movim (v_movim);
          END IF;
       END IF;
    END p_inserta_linea;

  PROCEDURE p_genera_peticion_guia(v_peticion IN al_petiguias_alma%ROWTYPE )
  IS
    BEGIN
       INSERT INTO al_petiguias_alma (num_peticion,tip_petidor,num_petidor)
       VALUES (v_peticion.num_peticion,v_peticion.tip_petidor,v_peticion.num_petidor);
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20175,'Error Insert Peticion '
                                     || TO_CHAR(SQLCODE));
  END p_genera_peticion_guia;

  PROCEDURE p_select_movimiento(v_movimiento IN OUT NOCOPY  al_movimientos.num_movimiento%TYPE )
  IS
    BEGIN
       SELECT al_seq_mvto.NEXTVAL
              INTO v_movimiento
              FROM dual;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20175,'Error Obtencion No. Movimiento '
                                     || TO_CHAR(SQLCODE));
  END p_select_movimiento;

  PROCEDURE p_obtiene_peticion(v_peticion IN OUT NOCOPY  al_petiguias_alma.num_peticion%TYPE )
  IS
    BEGIN
       SELECT al_seq_petiguias.NEXTVAL
              INTO v_peticion
              FROM dual;
    EXCEPTION
       WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR (-20175,'Error Obtencion No. Peticion '
                                     || TO_CHAR(SQLCODE));
  END p_obtiene_peticion;

END Al_Proc_Devolucion;
/
SHOW ERRORS
