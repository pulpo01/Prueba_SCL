CREATE OR REPLACE PACKAGE BODY Al_Trata_Traspa IS

PROCEDURE p_tratamiento(v_traspa IN al_traspasos%ROWTYPE ) IS
	v_reserva    al_datos_generales.cod_estado_res%TYPE;
	v_transito   al_datos_generales.cod_estado_tra%TYPE;
	v_lintra     al_lin_traspaso%ROWTYPE;
	v_sertra     al_ser_traspaso%ROWTYPE;
	v_seriado    al_articulos.ind_seriado%TYPE;
	v_movim      al_movimientos%ROWTYPE;
	v_peticion   al_petiguias_alma%ROWTYPE;
	v_stock_localizacion al_stock_localizacion%ROWTYPE;   -- Creada para localizacion
	CURSOR c_lintra IS
	SELECT * FROM al_lin_traspaso
	WHERE num_traspaso = v_traspa.num_traspaso;
BEGIN
	p_select_estados (v_reserva, v_transito);
	v_movim.cod_bodega              := v_traspa.cod_bodega_ori;
	v_movim.cod_transaccion         := 2;
	v_movim.num_transaccion         := v_traspa.num_traspaso;
	v_movim.fec_movimiento          := SYSDATE;
	IF v_traspa.cod_estado  = 'EN' THEN
		p_select_peticion (v_peticion.num_peticion);
		v_peticion.tip_petidor       := 2;
		v_peticion.num_petidor       := v_traspa.num_traspaso;
		p_genera_peticion (v_peticion);
	END IF;
	FOR v_lintra IN c_lintra LOOP
		p_select_seriado (v_lintra.cod_articulo, v_seriado);
		v_movim.tip_stock              := v_lintra.tip_stock;
		v_movim.cod_articulo           := v_lintra.cod_articulo;
		v_movim.cod_uso                := v_lintra.cod_uso;
		v_movim.cod_estadomov          := 'SO';
		v_movim.cod_uso_dest           := NULL;
		v_movim.num_desde              := 0;
		v_movim.num_hasta              := NULL;
		v_movim.num_guia               := NULL;
		v_movim.prc_unidad             := NULL;
		v_movim.cod_central_dest       := NULL;
		v_movim.cod_subalm_dest        := NULL;
		v_movim.num_telefono_dest      := NULL;
		v_movim.cod_cat_dest           := NULL;
		IF v_traspa.cod_estado = 'AU' THEN
			v_movim.cod_estado          := v_lintra.cod_estado;
			v_movim.cod_estado_dest     := v_reserva;
			v_movim.tip_movimiento      := v_traspa.tip_movim_aut;
			v_movim.nom_usuarora        := v_traspa.usu_autoriza;
			v_movim.tip_stock_dest      := NULL;
			v_movim.cod_bodega_dest     := NULL;
		ELSIF v_traspa.cod_estado  = 'EN' THEN
			v_movim.cod_estado       := v_reserva;
			v_movim.cod_estado_dest  := v_transito;
			v_movim.tip_movimiento   := v_traspa.tip_movim_env;
			v_movim.nom_usuarora     := v_traspa.usu_despacho;
			v_movim.tip_stock_dest   := NULL;
			v_movim.cod_bodega_dest  := NULL;
		ELSE
			v_movim.cod_estado          := v_transito;
			v_movim.cod_estado_dest     := v_lintra.cod_estado;
			v_movim.tip_movimiento      := v_traspa.tip_movim_rec;
			v_movim.nom_usuarora        := v_traspa.usu_recepcion;
			p_select_tip_stock_dest (v_movim.tip_movimiento, v_movim.tip_stock_dest);
			v_movim.cod_bodega_dest     := v_traspa.cod_bodega_dest;
        END IF;
		IF v_seriado = 1 THEN
           p_trata_series (v_lintra, v_movim, v_traspa.cod_estado);
        ELSE
		    v_movim.num_sec_loca        := v_lintra.NUM_SEC_LOCA_ORI;
			v_movim.num_cantidad        := v_lintra.can_traspaso;
			v_movim.num_serie           := NULL;
			v_movim.num_seriemec        := NULL;
			v_movim.num_telefono        := NULL;
			v_movim.cap_code            := NULL;
			v_movim.cod_producto        := NULL;
			v_movim.cod_central         := NULL;
			v_movim.cod_moneda          := NULL;
			v_movim.cod_subalm          := NULL;
			v_movim.cod_cat             := NULL;
			p_select_movimiento (v_movim.num_movimiento);
			Al_Pac_Validaciones.p_inserta_movim (v_movim);
			-- Se implemanta localizacion de Stock..... para articulos no seriados
			IF (v_traspa.cod_estado = 'RM') THEN
				v_stock_localizacion.COD_ARTICULO := v_lintra.COD_ARTICULO;
				v_stock_localizacion.FEC_CREACION := SYSDATE;
				v_stock_localizacion.CAN_STOCK    := v_lintra.CAN_TRASPASO;
				IF (v_lintra.NUM_SEC_LOCA_ORI IS NOT NULL) THEN
					v_stock_localizacion.NUM_SEC_LOCA := v_lintra.NUM_SEC_LOCA_ORI;
					Al_Proc_Movto.p_salida_stock_localizacion(v_stock_localizacion);
				END IF;
				IF (v_lintra.NUM_SEC_LOCA_DEST IS NOT NULL) THEN
				   v_stock_localizacion.NUM_SEC_LOCA := v_lintra.NUM_SEC_LOCA_DEST;
				   Al_Proc_Movto.p_entrada_stock_localizacion(v_stock_localizacion);
				END IF;
			END IF;
			-- Fin de implementacisn de Localizacion de Stock
        END IF;
	END LOOP;
END p_tratamiento;

PROCEDURE p_actualiza_Serie_Localizada (v_num_serie IN al_series.NUM_SERIE%TYPE,
		  							   	v_num_sec_loca IN al_series.num_sec_loca%TYPE) IS
BEGIN
	 UPDATE AL_SERIES  SET NUM_SEC_LOCA = v_num_sec_loca
	 WHERE NUM_SERIE = v_num_serie;
END p_actualiza_Serie_Localizada;

PROCEDURE p_trata_series(v_lintra IN al_lin_traspaso%ROWTYPE , v_movim IN OUT al_movimientos%ROWTYPE ,
						 v_estado IN al_traspasos.cod_estado%TYPE )IS
	v_sertra    al_ser_traspaso%ROWTYPE;
	v_telefono  al_series.num_telefono%TYPE;
	v_subalm    al_series.cod_subalm%TYPE;
	v_central   al_series.cod_central%TYPE;
	v_categoria al_series.cod_cat%TYPE;
	v_stock_localizacion al_stock_localizacion%ROWTYPE;   -- Creada para localizacion
	CURSOR c_sertra (EN_num_traspaso al_lin_traspaso.num_traspaso%type,
	                 EN_lin_traspaso al_lin_traspaso.lin_traspaso%type)
	IS
	SELECT a.num_traspaso, a.lin_traspaso, a.num_serie, a.cap_code, b.num_telefono, b.num_seriemec,
	b.cod_central, b.cod_subalm, b.cod_cat, b.carga, a.num_sec_loca_ori, a.num_sec_loca_dest, b.plan
	FROM   al_series b, al_ser_traspaso a
	WHERE  a.num_serie = b.num_serie
	AND    a.num_traspaso = EN_num_traspaso
	AND    a.lin_traspaso = EN_lin_traspaso;
BEGIN
	FOR v_sertra IN c_sertra(v_lintra.num_traspaso,v_lintra.lin_traspaso) LOOP
		v_movim.num_cantidad      := 1;
		IF v_estado = 'EN' THEN
			p_obtiene_datos_serie (v_sertra.num_serie, v_telefono, v_subalm, v_central, v_categoria);
			IF v_telefono <> v_sertra.num_telefono THEN
				v_movim.num_telefono      := v_telefono;
				v_movim.num_telefono_dest := v_sertra.num_telefono;
			ELSE
				v_movim.num_telefono      := v_sertra.num_telefono;
				v_movim.num_telefono_dest := NULL;
			END IF;
            IF v_subalm <> v_sertra.cod_subalm THEN
				v_movim.cod_subalm      := v_subalm;
				v_movim.cod_subalm_dest := v_sertra.cod_subalm;
            ELSE
				v_movim.cod_subalm      := v_sertra.cod_subalm;
				v_movim.cod_subalm_dest := NULL;
            END IF;
			IF v_central <> v_sertra.cod_central THEN
				v_movim.cod_central      := v_central;
				v_movim.cod_central_dest := v_sertra.cod_central;
            ELSE
				v_movim.cod_central      := v_sertra.cod_central;
				v_movim.cod_central_dest := NULL;
            END IF;
            IF v_categoria <> v_sertra.cod_cat THEN
				v_movim.cod_cat      := v_categoria;
				v_movim.cod_cat_dest := v_sertra.cod_cat;
            ELSE
				v_movim.cod_cat      := v_sertra.cod_cat;
				v_movim.cod_cat_dest := NULL;
            END IF;
		ELSE
		    v_movim.num_telefono      := v_sertra.num_telefono;
		    v_movim.cod_central       := v_sertra.cod_central;
		    v_movim.cod_cat           := v_sertra.cod_cat;
		    v_movim.cod_subalm        := v_sertra.cod_subalm;
		    v_movim.num_telefono_dest := NULL;
		    v_movim.cod_subalm_dest   := v_sertra.cod_subalm;
		    v_movim.cod_central_dest  := v_sertra.cod_central;
		    v_movim.cod_cat_dest      := v_sertra.cod_cat;
		END IF;
		v_movim.num_serie         := v_sertra.num_serie;
		v_movim.num_seriemec      := v_sertra.num_seriemec;
		v_movim.cap_code          := v_sertra.cap_code;
		v_movim.cod_producto      := NULL;
		v_movim.cod_moneda        := NULL;
		v_movim.num_sec_loca      := v_sertra.num_sec_loca_ori;
		v_movim.plan      		  := v_sertra.plan;
		v_movim.carga      	      := v_sertra.carga;
		p_select_movimiento(v_movim.num_movimiento);
		Al_Pac_Validaciones.p_inserta_movim (v_movim);
		-- Se implemanta localizacion de Stock..... para articulos seriados
		IF (v_estado = 'RM') THEN
		   v_stock_localizacion.CAN_STOCK    := 1;
		   v_stock_localizacion.COD_ARTICULO := v_movim.cod_articulo;
		   v_stock_localizacion.FEC_CREACION := SYSDATE;
 	   	   IF (v_sertra.NUM_SEC_LOCA_ORI IS NOT NULL) THEN
		   	   v_stock_localizacion.NUM_SEC_LOCA := v_sertra.NUM_SEC_LOCA_ORI;
			   Al_Proc_Movto.p_salida_stock_localizacion(v_stock_localizacion);
		   END IF;
		   IF (v_sertra.NUM_SEC_LOCA_DEST IS NOT NULL) THEN
		   	  v_stock_localizacion.NUM_SEC_LOCA := v_sertra.NUM_SEC_LOCA_DEST;
			  Al_Proc_Movto.p_entrada_stock_localizacion(v_stock_localizacion);
			  p_actualiza_Serie_Localizada (v_movim.num_serie, v_stock_localizacion.NUM_SEC_LOCA);
		   END IF;
		END IF;
	END LOOP;
END p_trata_series;

PROCEDURE p_select_estados(v_reserva IN OUT al_datos_generales.cod_estado_res%TYPE ,
                           v_transito IN OUT al_datos_generales.cod_estado_tra%TYPE )IS
BEGIN
	SELECT cod_estado_res,cod_estado_tra
	INTO v_reserva,v_transito
	FROM al_datos_generales;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20180,'Error lectura Datos Generales');
END p_select_estados;

PROCEDURE p_select_seriado(v_articulo IN al_articulos.cod_articulo%TYPE ,v_seriado IN OUT al_articulos.ind_seriado%TYPE ) IS
BEGIN
	SELECT ind_seriado INTO v_seriado
	FROM al_articulos
	WHERE cod_articulo = v_articulo;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20181,'Error lectura Articulos');
END p_select_seriado;

PROCEDURE p_select_tip_stock_dest( v_tipmovim IN al_tipos_movimientos.tip_movimiento%TYPE ,  v_dest IN OUT al_tipos_movimientos.tip_stock%TYPE )IS
BEGIN
	SELECT tip_stock INTO v_dest
	FROM al_tipos_movimientos
	WHERE tip_movimiento = v_tipmovim;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20182,'Error lectura Tipo Movimiento');
END p_select_tip_stock_dest;

PROCEDURE p_cambio_cantidad(v_traspaso IN al_lin_traspaso.num_traspaso%TYPE ,
							v_tstock IN al_lin_traspaso.tip_stock%TYPE , v_articulo IN al_lin_traspaso.cod_articulo%TYPE ,
							v_uso IN al_lin_traspaso.cod_uso%TYPE , v_estado IN al_lin_traspaso.cod_estado%TYPE ,
							v_can_old IN al_lin_traspaso.can_traspaso%TYPE ,
							v_can_new IN al_lin_traspaso.can_traspaso%TYPE )IS

	v_seriado  al_articulos.ind_seriado%TYPE;
	v_estatras al_traspasos.cod_estado%TYPE;
	v_bodega   al_traspasos.cod_bodega_ori%TYPE;
	v_reserva  al_datos_generales.cod_estado_res%TYPE;
	v_transito al_datos_generales.cod_estado_tra%TYPE;
	v_movim    al_movimientos%ROWTYPE;
	v_tipmo    al_traspasos.tip_movim_aut%TYPE;
BEGIN
	p_select_seriado (v_articulo, v_seriado);
	IF v_seriado = 0 THEN
		p_select_traspa (v_traspaso, v_estatras, v_bodega, v_tipmo);
		IF v_estatras = 'AU' THEN
			p_select_estados (v_reserva, v_transito);
			IF v_can_old > v_can_new THEN
				v_movim.num_cantidad     := v_can_old - v_can_new;
				v_movim.cod_estado       := v_reserva;
				v_movim.cod_estado_dest  := v_estado;
			ELSE
				v_movim.num_cantidad     := v_can_new - v_can_old;
				v_movim.cod_estado       := v_estado;
				v_movim.cod_estado_dest  := v_reserva;
			END IF;
			v_movim.fec_movimiento      := SYSDATE;
			v_movim.tip_movimiento      := v_tipmo;
			v_movim.tip_stock           := v_tstock;
			v_movim.cod_bodega          := v_bodega;
			v_movim.cod_articulo        := v_articulo;
			v_movim.cod_uso             := v_uso;
			v_movim.cod_estadomov       := 'SO';
			v_movim.nom_usuarora        := USER;
			v_movim.tip_stock_dest      := NULL;
			v_movim.cod_bodega_dest     := NULL;
			v_movim.cod_uso_dest        := NULL;
			v_movim.num_serie           := NULL;
			v_movim.num_desde           := 0;
			v_movim.num_hasta           := NULL;
			v_movim.num_guia            := NULL;
			v_movim.prc_unidad          := NULL;
			v_movim.cod_transaccion     := 2;
			v_movim.num_transaccion     := v_traspaso;
			v_movim.num_seriemec        := NULL;
			v_movim.num_telefono        := NULL;
			v_movim.cap_code            := NULL;
			v_movim.cod_producto        := NULL;
			v_movim.cod_central         := NULL;
			v_movim.cod_moneda          := NULL;
			v_movim.cod_subalm          := NULL;
			v_movim.cod_central_dest    := NULL;
			v_movim.cod_subalm_dest     := NULL;
			v_movim.num_telefono_dest   := NULL;
			v_movim.cod_cat_dest        := NULL;
			v_movim.cod_cat             := NULL;
			p_select_movimiento(v_movim.num_movimiento);
			Al_Pac_Validaciones.p_inserta_movim  (v_movim);
		END IF;
	END IF;
END p_cambio_cantidad;

  PROCEDURE p_select_traspa(
  v_numero IN al_traspasos.num_traspaso%TYPE ,
  v_estado IN OUT al_traspasos.cod_estado%TYPE ,
  v_bodega IN OUT al_traspasos.cod_bodega_ori%TYPE ,
  v_tipmo IN OUT al_traspasos.tip_movim_aut%TYPE )
  IS
  BEGIN
     SELECT cod_estado,cod_bodega_ori,tip_movim_aut
       INTO v_estado,v_bodega,v_tipmo
       FROM al_traspasos
      WHERE num_traspaso = v_numero;
  EXCEPTION
      WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20184,'Error Lectura Traspaso');
  END p_select_traspa;

PROCEDURE p_select_linea( v_numero IN al_lin_traspaso.num_traspaso%TYPE , v_linea IN al_lin_traspaso.lin_traspaso%TYPE ,
						  v_tstock IN OUT al_lin_traspaso.tip_stock%TYPE ,v_articulo IN OUT al_lin_traspaso.cod_articulo%TYPE ,
  						  v_uso IN OUT al_lin_traspaso.cod_uso%TYPE ,
						  v_estado IN OUT al_lin_traspaso.cod_estado%TYPE )IS
BEGIN
	SELECT tip_stock,cod_articulo,cod_uso,cod_estado
	INTO v_tstock,v_articulo,v_uso,v_estado
	FROM al_lin_traspaso
	WHERE num_traspaso = v_numero
	AND lin_traspaso = v_linea;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20185,'Error Lectura Lineas');
END p_select_linea;

PROCEDURE  p_select_linea_numsec_loca (v_numero IN al_lin_traspaso.num_traspaso%TYPE,
									   v_linea IN al_lin_traspaso.lin_traspaso%TYPE,
									   v_num_sec_loca IN OUT al_lin_traspaso.num_sec_loca_ori%TYPE)IS
BEGIN
	SELECT num_sec_loca_ori INTO v_num_sec_loca FROM al_lin_traspaso
	WHERE num_traspaso = v_numero AND
	      lin_traspaso = v_linea;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20185,'Error Lectura Lineas para Localizacisn(NUM_SEC_LOCA)');
END p_select_linea_numsec_loca;


PROCEDURE p_borrado_lintra( v_traspaso IN al_lin_traspaso.num_traspaso%TYPE ,
                            v_tstock IN al_lin_traspaso.tip_stock%TYPE ,
                            v_articulo IN al_lin_traspaso.cod_articulo%TYPE ,
  v_uso IN al_lin_traspaso.cod_uso%TYPE ,
  v_estado IN al_lin_traspaso.cod_estado%TYPE ,
  v_cantidad IN al_lin_traspaso.can_traspaso%TYPE )
  IS
     v_seriado  al_articulos.ind_seriado%TYPE;
     v_estatras al_traspasos.cod_estado%TYPE;
     v_bodega   al_traspasos.cod_bodega_ori%TYPE;
     v_reserva  al_datos_generales.cod_estado_res%TYPE;
     v_transito al_datos_generales.cod_estado_tra%TYPE;
     v_movim    al_movimientos%ROWTYPE;
     v_tipmo    al_traspasos.tip_movim_aut%TYPE;
  BEGIN
     p_select_seriado (v_articulo,
                       v_seriado);
     IF v_seriado = 0 THEN
        p_select_traspa (v_traspaso,
                         v_estatras,
                         v_bodega,
                         v_tipmo);
        IF v_estatras = 'AU' THEN
           p_select_estados (v_reserva,
                             v_transito);
           v_movim.num_cantidad       := v_cantidad;
           v_movim.cod_estado         := v_reserva;
           v_movim.cod_estado_dest    := v_estado;
           v_movim.fec_movimiento     := SYSDATE;
           v_movim.tip_movimiento     := v_tipmo;
           v_movim.tip_stock          := v_tstock;
           v_movim.cod_bodega         := v_bodega;
           v_movim.cod_articulo       := v_articulo;
           v_movim.cod_uso            := v_uso;
           v_movim.cod_estadomov      := 'SO';
           v_movim.nom_usuarora       := USER;
           v_movim.tip_stock_dest     := NULL;
           v_movim.cod_bodega_dest    := NULL;
           v_movim.cod_uso_dest       := NULL;
           v_movim.num_serie          := NULL;
           v_movim.num_desde          := 0;
           v_movim.num_hasta          := NULL;
           v_movim.num_guia           := NULL;
           v_movim.prc_unidad         := NULL;
           v_movim.cod_transaccion    := 2;
           v_movim.num_transaccion    := v_traspaso;
           v_movim.num_seriemec       := NULL;
           v_movim.num_telefono       := NULL;
           v_movim.cap_code           := NULL;
           v_movim.cod_producto       := NULL;
           v_movim.cod_central        := NULL;
           v_movim.cod_moneda         := NULL;
           v_movim.cod_subalm         := NULL;
           v_movim.cod_central_dest   := NULL;
           v_movim.cod_subalm_dest    := NULL;
           v_movim.num_telefono_dest  := NULL;
           v_movim.cod_cat            := NULL;
           v_movim.cod_cat_dest       := NULL;
           p_select_movimiento(v_movim.num_movimiento);
           Al_Pac_Validaciones.p_inserta_movim  (v_movim);
        END IF;
     END IF;
  END p_borrado_lintra;
  --
  -- Retrofitted
  PROCEDURE p_borrado_sertra(
  v_sertra IN al_ser_traspaso%ROWTYPE )
  IS
     v_tstock   al_lin_traspaso.tip_stock%TYPE;
     v_articulo al_lin_traspaso.cod_articulo%TYPE;
     v_uso      al_lin_traspaso.cod_uso%TYPE;
     v_estado   al_lin_traspaso.cod_estado%TYPE;
     v_estatras al_traspasos.cod_estado%TYPE;
     v_bodega   al_traspasos.cod_bodega_ori%TYPE;
     V_tipmo    al_traspasos.tip_movim_aut%TYPE;
     v_reserva  al_datos_generales.cod_estado_res%TYPE;
     v_transito al_datos_generales.cod_estado_tra%TYPE;
     v_movim    al_movimientos%ROWTYPE;
  BEGIN
     p_select_traspa (v_sertra.num_traspaso,
                      v_estatras,
                      v_bodega,
                      v_tipmo);
     IF v_estatras = 'AU' THEN
        p_select_linea (v_sertra.num_traspaso,
                        v_sertra.lin_traspaso,
                        v_tstock,
                        v_articulo,
                        v_uso,
                        v_estado);
        p_select_estados (v_reserva,
                          v_transito);
        v_movim.num_cantidad       := 1;
        v_movim.cod_estado         := v_reserva;
        v_movim.cod_estado_dest    := v_estado;
        v_movim.fec_movimiento     := SYSDATE;
        v_movim.tip_movimiento     := v_tipmo;
        v_movim.tip_stock          := v_tstock;
        v_movim.cod_bodega         := v_bodega;
        v_movim.cod_articulo       := v_articulo;
        v_movim.cod_uso            := v_uso;
        v_movim.cod_estadomov      := 'SO';
        v_movim.nom_usuarora       := USER;
        v_movim.tip_stock_dest     := NULL;
        v_movim.cod_bodega_dest    := NULL;
        v_movim.cod_uso_dest       := NULL;
        v_movim.num_serie          := v_sertra.num_serie;
        v_movim.num_desde          := 0;
        v_movim.num_hasta          := NULL;
        v_movim.num_guia           := NULL;
        v_movim.prc_unidad         := NULL;
        v_movim.cod_transaccion    := 2;
        v_movim.num_transaccion    := v_sertra.num_traspaso;
        v_movim.num_seriemec       := v_sertra.num_seriemec;
        v_movim.num_telefono       := v_sertra.num_telefono;
        v_movim.cap_code           := v_sertra.cap_code;
        v_movim.cod_producto       := NULL;
        v_movim.cod_central        := v_sertra.cod_central;
        v_movim.cod_moneda         := NULL;
        v_movim.cod_subalm         := v_sertra.cod_subalm;
        v_movim.cod_central_dest   := NULL;
        v_movim.cod_subalm_dest    := NULL;
        v_movim.num_telefono_dest  := NULL;
        v_movim.cod_cat            := v_sertra.cod_cat;
        v_movim.cod_cat_dest       := NULL;
        p_select_movimiento(v_movim.num_movimiento);
        Al_Pac_Validaciones.p_inserta_movim  (v_movim);
     END IF;
  END p_borrado_sertra;


PROCEDURE p_inserta_sertra( v_sertra IN al_ser_traspaso%ROWTYPE )IS
	v_tstock   al_lin_traspaso.tip_stock%TYPE;
	v_articulo al_lin_traspaso.cod_articulo%TYPE;
	v_uso      al_lin_traspaso.cod_uso%TYPE;
	v_estado   al_lin_traspaso.cod_estado%TYPE;
	v_estatras al_traspasos.cod_estado%TYPE;
	v_bodega   al_traspasos.cod_bodega_ori%TYPE;
	V_tipmo    al_traspasos.tip_movim_aut%TYPE;
	v_reserva  al_datos_generales.cod_estado_res%TYPE;
	v_transito al_datos_generales.cod_estado_tra%TYPE;
	v_movim    al_movimientos%ROWTYPE;
    v_num_sec_loca 	al_lin_traspaso.num_sec_loca_ori%TYPE;

BEGIN
	p_select_traspa (v_sertra.num_traspaso, v_estatras, v_bodega, v_tipmo);
	IF v_estatras = 'AU' THEN
		p_select_linea (v_sertra.num_traspaso,v_sertra.lin_traspaso,v_tstock,v_articulo,v_uso,v_estado);
		p_select_linea_numsec_loca(v_sertra.num_traspaso, v_sertra.lin_traspaso, v_num_sec_loca);  -- JLR Localizacisn
		v_movim.num_sec_loca       := v_num_sec_loca;  -- JLR por Localizacisn !!! necesito saber donde se usa !!!...
        p_select_estados (v_reserva,v_transito);
        v_movim.num_cantidad       := 1;
        v_movim.cod_estado_dest    := v_reserva;
        v_movim.cod_estado         := v_estado;
        v_movim.fec_movimiento     := SYSDATE;
        v_movim.tip_movimiento     := v_tipmo;
        v_movim.tip_stock          := v_tstock;
        v_movim.cod_bodega         := v_bodega;
        v_movim.cod_articulo       := v_articulo;
        v_movim.cod_uso            := v_uso;
        v_movim.cod_estadomov      := 'SO';
        v_movim.nom_usuarora       := USER;
        v_movim.tip_stock_dest     := NULL;
        v_movim.cod_bodega_dest    := NULL;
        v_movim.cod_uso_dest       := NULL;
        v_movim.num_serie          := v_sertra.num_serie;
        v_movim.num_desde          := 0;
        v_movim.num_hasta          := NULL;
        v_movim.num_guia           := NULL;
        v_movim.prc_unidad         := NULL;
        v_movim.cod_transaccion    := 2;
        v_movim.num_transaccion    := v_sertra.num_traspaso;
        v_movim.num_seriemec       := v_sertra.num_seriemec;
        v_movim.num_telefono       := v_sertra.num_telefono;
        v_movim.cap_code           := v_sertra.cap_code;
        v_movim.cod_producto       := NULL;
        v_movim.cod_central        := v_sertra.cod_central;
        v_movim.cod_moneda         := NULL;
        v_movim.cod_subalm         := v_sertra.cod_subalm;
        v_movim.cod_central_dest   := NULL;
        v_movim.cod_subalm_dest    := NULL;
        v_movim.num_telefono_dest  := NULL;
        v_movim.cod_cat            := v_sertra.cod_cat;
        v_movim.cod_cat_dest       := NULL;
        v_movim.cod_cat_dest       := NULL;
        p_select_movimiento(v_movim.num_movimiento);
        Al_Pac_Validaciones.p_inserta_movim  (v_movim);
	END IF;
END p_inserta_sertra;

PROCEDURE p_select_movimiento(v_movimiento IN OUT al_movimientos.num_movimiento%TYPE )IS
BEGIN
	SELECT al_seq_mvto.NEXTVAL
	INTO v_movimiento
	FROM dual;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20183,'Error Obtencion No. Movimiento ' || TO_CHAR(SQLCODE));
END p_select_movimiento;

PROCEDURE p_select_peticion(v_peticion IN OUT al_petiguias_alma.num_peticion%TYPE )IS
BEGIN
	SELECT al_seq_petiguias.NEXTVAL
	INTO v_peticion
	FROM dual;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20183,'Error Obtencion No. Peticion '|| TO_CHAR(SQLCODE));
END p_select_peticion;

PROCEDURE p_genera_peticion(v_peticion IN al_petiguias_alma%ROWTYPE ) IS
BEGIN
	INSERT INTO al_petiguias_alma (num_peticion, tip_petidor,num_petidor)
	VALUES (v_peticion.num_peticion,v_peticion.tip_petidor,v_peticion.num_petidor);
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20183,'Error Generacion Peticion '|| TO_CHAR(SQLCODE));
END p_genera_peticion;
PROCEDURE p_obtiene_datos_serie( v_serie IN al_series.num_serie%TYPE , v_telefono IN OUT al_series.num_serie%TYPE ,
								 v_subalm IN OUT al_series.cod_subalm%TYPE ,v_central IN OUT al_series.cod_central%TYPE ,
								 v_categoria IN OUT al_series.cod_cat%TYPE )IS
BEGIN
	SELECT num_telefono,cod_subalm,cod_central,cod_cat
	INTO v_telefono,v_subalm,v_central,v_categoria
	FROM al_series
	WHERE num_serie = v_serie;
EXCEPTION
	WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR (-20183,'Error Obtencion Datos Serie'|| TO_CHAR(SQLCODE));
END p_obtiene_datos_serie;

END Al_Trata_Traspa;
/
SHOW ERRORS
