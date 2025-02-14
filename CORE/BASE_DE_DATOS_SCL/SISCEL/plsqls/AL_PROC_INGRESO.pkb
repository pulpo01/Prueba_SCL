CREATE OR REPLACE PACKAGE BODY        AL_PROC_INGRESO

IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PROC_INGRESO
-- * Descripcisn        : Rutinas para procesos ingreso mercaderia
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************

  PROCEDURE p_obtiene_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_seriado IN OUT al_articulos.ind_seriado%TYPE ,
  v_tipart IN OUT al_articulos.tip_articulo%TYPE )
  IS
      BEGIN
       SELECT ind_seriado,tip_articulo INTO v_seriado,v_tipart
                FROM al_articulos
                WHERE cod_articulo = v_articulo;
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20170,'<ALMACEN> Articulo no catalogado
  ');
      END p_obtiene_seriado;
  PROCEDURE p_actualiza_cantidad(
  v_orden_ing IN al_lineas_ordenes.num_orden%TYPE ,
  v_linea_ing IN al_lineas_ordenes.num_linea%TYPE ,
  v_orden IN al_lineas_ordenes.num_orden%TYPE ,
  v_tipo IN al_lineas_ordenes.tip_orden%TYPE ,
  v_linea IN al_lineas_ordenes.num_linea%TYPE ,
  v_cant IN al_lineas_ordenes.can_orden%TYPE )
  IS
      BEGIN
         IF v_tipo = 1 THEN
            DELETE al_fic_series
            WHERE num_orden_ing = v_orden_ing
                 AND num_linea_ing = v_linea_ing;
            IF SQL%FOUND THEN
               UPDATE al_lineas_ordenes1
                  SET can_servida     = NVL(can_servida,0) + v_cant,
                      can_orden_ing   = can_orden_ing - v_cant,
                      can_series      = can_series - v_cant
                      WHERE num_orden = v_orden
                        AND tip_orden = v_tipo
                        AND num_linea = v_linea;
            ELSE
                UPDATE al_lineas_ordenes1
                   SET can_servida     = NVL(can_servida,0) + v_cant,
                       can_orden_ing   = can_orden_ing - v_cant
                       WHERE num_orden = v_orden
                         AND tip_orden = v_tipo
                         AND num_linea = v_linea;
            END IF;
         ELSE
       -- se trata de devolucion al proveedor, tip_orden=3
            UPDATE al_lineas_ordenes3
               SET can_servida     = NVL(can_servida,0) + v_cant,
                   can_orden_ing   = can_orden_ing - v_cant
                   WHERE num_orden = v_orden
                     AND tip_orden = v_tipo
                     AND num_linea = v_linea;
         END IF;
      EXCEPTION
       WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20171,
                            '<ALMACEN> Error actualizacion Orden de Compra ' ||
                             TO_CHAR(SQLCODE));
      END p_actualiza_cantidad;
  PROCEDURE p_obtiene_documento(
  v_documento IN OUT al_datos_generales.tip_articulo_doc%TYPE )
  IS
      BEGIN
       SELECT tip_articulo_doc
                INTO v_documento
                FROM al_datos_generales;
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20172,
                   '<ALMACEN> Datos Generales NO Parametrizados '
                   || TO_CHAR(SQLCODE));
      END p_obtiene_documento;
PROCEDURE p_select_serhex(
  v_orden_ing IN al_fic_series.num_orden_ing%TYPE ,
  v_linea_ing IN al_fic_series.num_linea_ing%TYPE ,
  v_serie IN al_fic_series.num_serie%TYPE ,
  v_telefono IN al_fic_series.num_telefono%TYPE ,
  v_serhex IN OUT al_fic_series.num_serhex%TYPE )
  IS
      BEGIN
        SELECT num_serhex INTO v_serhex
               FROM al_fic_series
               WHERE num_orden_ing = v_orden_ing
                 AND num_linea_ing = v_linea_ing
                 AND num_serie     = v_serie;
      EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR (-20190,'Error captura serie hexadecimal '
                                      || TO_CHAR(SQLCODE));
      END p_select_serhex;

  PROCEDURE p_select_actuacion(
  v_actuacion  IN OUT ga_actabo.cod_actcen%TYPE,
  v_uso        IN     al_usos.cod_uso%TYPE,
  v_central    IN     icg_central.cod_central%TYPE)
  IS
	v_uso_ami      al_usos.cod_uso%TYPE;
	v_tecnologia   al_tecnologia.cod_tecnologia%TYPE;
  	CN_tecno_gsm   CONSTANT VARCHAR2(3):='GSM';
	CN_modulo      CONSTANT VARCHAR2(2):='AL';
    CN_producto    CONSTANT NUMBER(1):=1;
    v_actabo_gm             VARCHAR2(2):= 'GM';
	v_actabo_dg             VARCHAR2(2):= 'DG';
	v_actabo_da             VARCHAR2(2):= 'DA';
	v_actabo_mi             VARCHAR2(2):= 'MI';
  BEGIN

	 SELECT cod_uso_ami
	 INTO v_uso_ami
	 FROM al_datos_generales;

	 SELECT cod_tecnologia
	 INTO   v_tecnologia
	 FROM   icg_central
	 WHERE  cod_central = v_central;


	 IF v_uso = v_uso_ami THEN
        IF v_tecnologia = CN_tecno_gsm THEN
  	       BEGIN
			   SELECT cod_actcen
			     INTO v_actuacion
			     FROM ga_actabo
			    WHERE cod_modulo     = CN_modulo
			      AND cod_producto   = CN_producto
			      AND cod_tecnologia = v_tecnologia
			      AND cod_actabo     = v_actabo_gm;
	  	      EXCEPTION
	    	  WHEN NO_DATA_FOUND THEN
	                v_actuacion := NULL;
		    END;
		 ELSE
		    BEGIN
			  SELECT cod_actcen
				INTO v_actuacion
			    FROM ga_actabo
			   WHERE cod_modulo     = CN_modulo
				 AND cod_producto   = CN_producto
			     AND cod_tecnologia = v_tecnologia
				 AND cod_actabo     = v_actabo_da;
			   EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			            v_actuacion:= NULL;
			   END;
         END IF;
	  ELSE
         IF v_tecnologia = CN_tecno_gsm THEN
	        BEGIN
			  SELECT cod_actcen
				INTO v_actuacion
			    FROM ga_actabo
			   WHERE cod_modulo     = CN_modulo
				 AND cod_producto   = CN_producto
			     AND cod_tecnologia = v_tecnologia
				 AND cod_actabo     = v_actabo_dg;
			  EXCEPTION
			       WHEN NO_DATA_FOUND THEN
			          v_actuacion := NULL;
		     END;
	  	 ELSE
	  	     BEGIN
			   SELECT cod_actcen
				 INTO v_actuacion
				 FROM ga_actabo
				WHERE cod_modulo     = CN_modulo
				  AND cod_producto   = CN_producto
			      AND cod_tecnologia = v_tecnologia
				  AND cod_actabo     = v_actabo_mi;
			  EXCEPTION
			   WHEN NO_DATA_FOUND THEN
			   	    v_actuacion := NULL;
			    END;
		 END IF ;
	 END IF ;
EXCEPTION
  WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR (-20199,'Error Captura Actuacion Central');
END p_select_actuacion;
  PROCEDURE p_desactiva_central(
  v_actuacion IN icc_movimiento.cod_actuacion%TYPE ,
  v_prefijo IN al_usos_min.num_min%TYPE,
  v_central IN icc_movimiento.cod_central%TYPE ,
  v_celular IN icc_movimiento.num_celular%TYPE ,
  v_serie IN icc_movimiento.num_serie%TYPE ,
  v_terminal IN icc_movimiento.tip_terminal%TYPE,
  v_serie_dec IN al_series.num_serie%TYPE )
  IS
      v_actuacion_des_ami ga_actabo.cod_actcen%TYPE;
	  v_CodSimGsm  al_tipos_terminales.tip_terminal%TYPE;
	  v_cod_articulo al_series.cod_articulo%TYPE;
	  v_tecnologia  al_tecnologia.cod_tecnologia%TYPE;
 --
    CN_modulo      CONSTANT VARCHAR2(2):='AL';
    CN_producto    CONSTANT NUMBER(1):=1;
    v_actabo_da             VARCHAR2(2):= 'DA';
    v_actabo_gm             VARCHAR2(2):= 'GM';


BEGIN

    SELECT val_parametro
	INTO   v_CodSimGsm
	FROM   ged_parametros
	WHERE  cod_modulo   = CN_modulo
	  AND  cod_producto = CN_producto
      AND  nom_parametro='COD_SIMCARD_GSM';


   SELECT a.cod_tecnologia
     INTO   v_tecnologia
     FROM   icg_central a
    WHERE  a.cod_central = v_central;


-- Para poder parear , ingresamos el movimiento en la ga_movccontrol, como procesado .
   IF (v_terminal = v_CodSimGsm ) THEN
   	  BEGIN
		 SELECT cod_actcen
	     INTO   v_actuacion_des_ami
	     FROM   ga_actabo
	     WHERE  cod_modulo     = CN_modulo
		 AND    cod_producto   = CN_producto
	     AND    cod_tecnologia = v_tecnologia
	     AND    cod_actabo     = v_actabo_gm;
	   EXCEPTION
	    	WHEN NO_DATA_FOUND THEN
	    	v_actuacion_des_ami := NULL;
	   END;
   ELSE
   	   BEGIN
		 SELECT cod_actcen
	     INTO   v_actuacion_des_ami
	     FROM   ga_actabo
	     WHERE  cod_modulo     = CN_modulo
		 AND    cod_producto   = CN_producto
 	     AND    cod_tecnologia = v_tecnologia
	     AND    cod_actabo     = v_actabo_da;
	   EXCEPTION
	    	WHEN NO_DATA_FOUND THEN
	    	v_actuacion_des_ami := NULL;
	   END;
   END IF;
-- Este pL se le llama desde p_al_desactiva_central, que lo llama abonados
-- desde la baja amistar, con su actiacion de baja amistar , que
-- es la 54 , y no la tienen distinguida.
   IF (v_actuacion = v_actuacion_des_ami) OR (v_actuacion = 54) THEN
		INSERT INTO ga_movccontrol (num_linea,
						fec_inicio,
	                                        cod_plantarif,
		                                ind_tipmov,
	                                        ind_procesado,
						cmd_comverse)
                VALUES (v_celular,SYSDATE,
                        'ALM','2',1,
			'm 9' ||v_celular ||
			',SERVICE=PPS,STATE=DISABLED,USER=INFOHIA|D 9'||
			v_celular ||',SERVICE=PPS,USER=INFOHIA');
   END IF;
   INSERT INTO icc_movimiento (num_movimiento,
                                    num_abonado,
                                    cod_estado,
                                    cod_modulo,
                                    num_intentos,
                                    des_respuesta,
                                    cod_actuacion,
                                    cod_actabo,
                                    nom_usuarora,
                                    fec_ingreso,
                                    cod_central,
                                    num_celular,
                                    num_serie,
                                    tip_terminal,
                                    ind_bloqueo,
                                    num_min,
								  tip_tecnologia,
								  imsi,
								  imei,
								  icc)
                            VALUES (icc_seq_nummov.NEXTVAL,
                                    0,
                                    1,
                                    'AL',
                                    0,
                                    'PENDIENTE',
                                    v_actuacion,
                                    'XX',
                                    USER,
                                    SYSDATE,
                                    v_central,
                                    v_celular,
                                    v_serie,
                                    v_terminal,
                                    0,
                                    v_prefijo,
	   			    v_tecnologia,
				     AL_DATOS_GSM_FN('IMSI', v_terminal,v_serie_dec),
								  AL_DATOS_GSM_FN('IMEI', v_terminal,v_serie_dec),
								  AL_DATOS_GSM_FN('ICC', v_terminal,v_serie_dec));
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR
               (-20191,'Error al generar movimiento desactivacion en central '
                || TO_CHAR(SQLCODE));
      END p_desactiva_central;
  PROCEDURE p_select_mvto(
  v_mvto IN OUT al_movimientos.num_movimiento%TYPE )
  IS
      BEGIN
         SELECT al_seq_mvto.NEXTVAL
           INTO v_mvto
           FROM dual;
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20192,'Error obtencio No. Movimiento '
                                       || TO_CHAR(SQLCODE));
      END p_select_mvto;
  PROCEDURE p_select_terminal(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_terminal IN OUT al_articulos.tip_terminal%TYPE )
  IS
      BEGIN
         SELECT tip_terminal INTO v_terminal
                FROM al_articulos
               WHERE cod_articulo = v_articulo;
      EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR (-20192,'Error Obtencion Tipo Terminal '
                                       || TO_CHAR(SQLCODE));
      END p_select_terminal;
PROCEDURE p_trata_cierre( v_orden_ing IN OUT al_cabecera_ordenes2.num_orden%TYPE ,
  						  v_tipord_ref IN OUT al_cabecera_ordenes2.tip_orden_ref%TYPE ,
  						  v_orden_ref IN OUT al_cabecera_ordenes2.num_orden_ref%TYPE ,
  						  v_bodega IN OUT al_bodegas.cod_bodega%TYPE ,
  						  v_usuario IN OUT ge_seg_usuario.nom_usuario%TYPE ,
  						  v_moneda IN OUT al_cabecera_ordenes2.cod_moneda%TYPE ) IS
	v_linord    al_vlineas_ordenes%ROWTYPE;
	v_movim     al_movimientos%ROWTYPE;
	v_seriado   al_articulos.ind_seriado%TYPE;
	v_tipart    al_articulos.tip_articulo%TYPE;
	v_documento al_datos_generales.tip_articulo_doc%TYPE;
	v_terminal  al_tipos_terminales.tip_terminal%TYPE;
	v_tip_numeracion al_cabecera_ordenes.tip_numeracion%TYPE;
	v_moneda_val   al_datos_generales.cod_moneda_val%TYPE;
	v_decim        ge_monedas.num_decimal%TYPE;
	v_precio       al_series.prc_compra%TYPE;
	v_prc_adic     al_lineas_ordenes2.prc_adic%TYPE;
	v_prc_ff       al_lineas_ordenes2.prc_ff%TYPE;
	v_cod_plaza    al_lineas_ordenes2.cod_plaza%TYPE;
	CURSOR c_lin_ing IS
	SELECT *
	FROM al_vlineas_ordenes
	WHERE num_orden = v_orden_ing AND tip_orden = 2;
BEGIN
	Al_Pac_Validaciones.p_obtiene_moneda (v_moneda_val);
	Al_Pac_Validaciones.p_decimales (v_moneda_val,v_decim);
	FOR v_linord IN c_lin_ing LOOP
		p_obtiene_seriado (v_linord.cod_articulo, v_seriado, v_tipart);
		p_obtiene_documento (v_documento);
		p_select_terminal (v_linord.cod_articulo, v_terminal);
		IF v_moneda_val <> v_moneda THEN
			Al_Pac_Validaciones.p_convertir_precio (v_moneda,v_moneda_val, NVL(v_linord.prc_unidad,0),v_precio,SYSDATE);
			Al_Pac_Validaciones.p_convertir_precio (v_moneda,v_moneda_val, NVL(v_linord.prc_ff,0),v_prc_ff,SYSDATE);
			Al_Pac_Validaciones.p_convertir_precio (v_moneda,v_moneda_val, NVL(v_linord.prc_adic,0),v_prc_adic,SYSDATE);
		ELSE
			v_precio := NVL(v_linord.prc_unidad,0);
			v_prc_ff := NVL(v_linord.prc_ff,0);
			v_prc_adic := NVL(v_linord.prc_adic,0);
		END IF;

		IF v_seriado = 1 THEN
		   p_lee_series (v_orden_ing, v_tipord_ref,  v_orden_ref, v_bodega, v_usuario,
		   				 v_linord, v_terminal, v_precio, v_prc_ff, v_prc_adic, v_moneda_val);
		ELSE
			v_movim.tip_movimiento  := v_linord.tip_movimiento;
			v_movim.fec_movimiento  := SYSDATE;
			v_movim.tip_stock       := v_linord.tip_stock;
			v_movim.cod_bodega      := v_bodega;
			v_movim.cod_articulo    := v_linord.cod_articulo;
			v_movim.cod_uso         := v_linord.cod_uso;
			v_movim.cod_estado      := v_linord.cod_estado;
			v_movim.num_cantidad    := v_linord.can_orden;
			v_movim.cod_estadomov   := 'SO';
			v_movim.nom_usuarora    := v_usuario;
			v_movim.tip_stock_dest  := NULL;
			v_movim.cod_bodega_dest := NULL;
			v_movim.cod_uso_dest    := NULL;
			v_movim.cod_estado_dest := NULL;
			v_movim.num_serie       := NULL;
			v_movim.num_sec_loca    := v_linord.num_sec_loca;
			IF v_tipart <> v_documento THEN
				v_movim.num_desde    := 0;
				v_movim.num_hasta    := NULL;
				v_movim.cod_plaza        := NULL; --JLA (TMM) 14122002
			ELSE
				v_movim.num_desde    := v_linord.num_desde;
				v_movim.num_hasta    := v_linord.num_hasta;
				v_movim.cod_plaza    :=	v_linord.cod_plaza;
			END IF;
--			v_movim.cod_plaza        := NULL; --JLA (TMM) 14122002
			v_movim.num_guia            := NULL;
			v_movim.prc_unidad          := NVL(v_precio,0) + NVL(v_prc_ff,0) + NVL(v_prc_adic,0);
			v_movim.cod_transaccion     := 1;
			v_movim.num_transaccion     := v_orden_ing;
			v_movim.num_seriemec        := NULL;
			v_movim.num_telefono        := NULL;
			v_movim.cap_code            := NULL;
			v_movim.cod_producto        := NULL;
			v_movim.cod_central         := NULL;
			v_movim.cod_moneda          := v_moneda_val;
			v_movim.cod_subalm          := NULL;
			v_movim.cod_central_dest    := NULL;
			v_movim.cod_subalm_dest     := NULL;
			v_movim.num_telefono_dest   := NULL;
			v_movim.cod_cat             := NULL;
			v_movim.cod_cat_dest        := NULL;
			p_select_mvto (v_movim.num_movimiento);
			Al_Pac_Validaciones.p_inserta_movim (v_movim);
		END IF;
		p_actualiza_cantidad (v_linord.num_orden, v_linord.num_linea, v_orden_ref,
                              v_tipord_ref, v_linord.num_linea_ref,  v_linord.can_orden);
	END LOOP;
END p_trata_cierre;

PROCEDURE p_lee_series( v_orden_ing IN al_cabecera_ordenes2.num_orden%TYPE , v_tipord_ref IN al_cabecera_ordenes2.tip_orden_ref%TYPE ,
						  v_orden_ref IN al_cabecera_ordenes2.num_orden_ref%TYPE ,  v_bodega IN al_bodegas.cod_bodega%TYPE ,
						  v_usuario IN ge_seg_usuario.nom_usuario%TYPE , 	v_linord IN al_vlineas_ordenes%ROWTYPE ,
						  v_terminal IN al_tipos_terminales.tip_terminal%TYPE, v_precio   IN al_series.prc_compra%TYPE,
  						  v_prc_ff   IN al_lineas_ordenes2.prc_ff%TYPE,  v_prc_adic IN al_lineas_ordenes2.prc_adic%TYPE,
						  v_moneda_val IN al_datos_generales.cod_moneda_val%TYPE)  IS
	v_serord    al_vseries_ordenes%ROWTYPE;
	v_movim     al_movimientos%ROWTYPE;
	v_serhex    al_fic_series.num_serhex%TYPE;
	v_actuacion ga_actabo.cod_actcen%TYPE;
	v_actuacion_res ga_actabo.cod_actcen%TYPE;
	v_actuacion_ami ga_actabo.cod_actcen%TYPE;
	v_actuacion_res_ami ga_actabo.cod_actcen%TYPE;
	v_error     NUMBER;
	v_prefijo   al_usos_min.num_min%TYPE;
	v_CodSimGsm  al_tipos_terminales.tip_terminal%TYPE;
	v_tecnologia al_tecnologia.cod_tecnologia%TYPE;
--
    CN_modulo      CONSTANT VARCHAR2(2):='AL';
    CN_producto    CONSTANT NUMBER(1):=1;
	v_actabo_rg             VARCHAR2(2):= 'RG';
	v_actabo_ar             VARCHAR2(2):= 'AR';
	v_actabo_ga             VARCHAR2(2):= 'GA';
	v_actabo_mm             VARCHAR2(2):= 'MM';
	v_actabo_rm             VARCHAR2(2):= 'RM';
	v_actabo_ra             VARCHAR2(2):= 'RA';


	CURSOR c_ser_ing IS
	SELECT * FROM al_vseries_ordenes
	WHERE num_orden = v_orden_ing
	AND tip_orden = 2
	AND num_linea = v_linord.num_linea;
BEGIN

    SELECT val_parametro
	  INTO v_CodSimGsm
	  FROM ged_parametros
	 WHERE cod_modulo    = CN_modulo
	   AND cod_producto  = CN_producto
	   AND nom_parametro ='COD_SIMCARD_GSM';

	FOR v_serord IN c_ser_ing LOOP
		v_movim.tip_movimiento      := v_linord.tip_movimiento;
		v_movim.fec_movimiento      := SYSDATE;
		v_movim.tip_stock           := v_linord.tip_stock;
		v_movim.cod_bodega          := v_bodega;
		v_movim.cod_articulo        := v_linord.cod_articulo;
		v_movim.cod_uso             := v_linord.cod_uso;
		v_movim.cod_estado          := v_linord.cod_estado;
		v_movim.num_cantidad        := 1;
		v_movim.cod_estadomov       := 'SO';
		v_movim.nom_usuarora        := v_usuario;
		v_movim.tip_stock_dest      := NULL;
		v_movim.cod_bodega_dest     := NULL;
		v_movim.cod_uso_dest      := NULL;
		v_movim.cod_estado_dest     := NULL;
		v_movim.num_serie           := v_serord.num_serie;
		v_movim.num_desde           := 0;
		v_movim.num_hasta           := NULL;
		v_movim.cod_plaza           := NULL; --JLA (TMM) 14122002
		v_movim.num_guia            := NULL;
		v_movim.cod_transaccion     := 1;
		v_movim.prc_unidad          := NVL(v_precio,0) + NVL(v_prc_ff,0) + NVL(v_prc_adic,0);
		v_movim.num_transaccion     := v_orden_ing;
		v_movim.num_seriemec        := v_serord.num_seriemec;
		v_movim.num_telefono        := v_serord.num_telefono;
		v_movim.cap_code            := v_serord.cap_code;
		v_movim.cod_producto        := v_serord.cod_producto;
		v_movim.cod_central         := v_serord.cod_central;
		v_movim.cod_moneda          := v_moneda_val;
		v_movim.cod_subalm          := v_serord.cod_subalm;
		v_movim.cod_central_dest    := NULL;
		v_movim.cod_subalm_dest     := NULL;
		v_movim.num_telefono_dest   := NULL;
		v_movim.cod_cat             := v_serord.cod_cat;
		v_movim.cod_cat_dest        := NULL;
		v_movim.ind_telefono        := v_serord.ind_telefono;
		v_movim.num_sec_loca        := v_serord.num_sec_loca;
        v_movim.PLAN                := v_serord.PLAN;
        v_movim.carga               := v_serord.carga;
		v_movim.cod_hlr             :=v_serord.cod_hlr;

		p_select_mvto (v_movim.num_movimiento);
		Al_Pac_Validaciones.p_inserta_movim (v_movim);
		IF v_movim.num_telefono IS NOT NULL AND v_tipord_ref = 1 AND v_movim.ind_telefono = 1 THEN
			-- desactivar par serie/telefono
			-- aqui solo podemos usar el prefijo asociado al cod_uso, porque
			-- todavia no hay serie en AL_SERIES. De todas formas esta opcion no se usa ya.

            SELECT al_fn_prefijo_numero(v_movim.num_telefono)
            INTO v_prefijo
            FROM dual;

            p_select_serhex (v_orden_ing, v_linord.num_linea, v_serord.num_serie, v_serord.num_telefono, v_serhex);
            p_select_actuacion (v_actuacion,v_movim.cod_uso,v_movim.cod_central );




            p_desactiva_central (v_actuacion, v_prefijo, v_serord.cod_central, v_serord.num_telefono, v_serhex, v_terminal,v_serord.num_serie);
        END IF;

		BEGIN
	        SELECT cod_tecnologia
	        INTO v_tecnologia
	 		FROM icg_central
			WHERE cod_central = v_movim.cod_central;
		EXCEPTION
		    WHEN NO_DATA_FOUND THEN
		    v_tecnologia := NULL;
		END;

		IF v_movim.num_telefono IS NOT NULL AND v_tipord_ref = 1 AND v_movim.ind_telefono = 2 THEN
			-- activar par serie/telefono con restriccion no hablar

            SELECT al_fn_prefijo_numero(v_movim.num_telefono)
            INTO v_prefijo
            FROM dual;

			p_select_serhex (v_orden_ing, v_linord.num_linea, v_serord.num_serie, v_serord.num_telefono,v_serhex);

			IF (v_terminal =v_CodSimGsm  AND v_serord.cod_producto=1) THEN
			   BEGIN
				 SELECT cod_actcen
				 INTO   v_actuacion_res
				 FROM   ga_actabo
				 WHERE  cod_modulo     = CN_modulo
				 AND    cod_producto   = CN_producto
	 	         AND    cod_tecnologia = v_tecnologia
				 AND    cod_actabo     = v_actabo_rg;
			   EXCEPTION
			    	WHEN NO_DATA_FOUND THEN
			    	v_actuacion_res := NULL;
			   END;
     		ELSE
			   BEGIN
	  			 SELECT cod_actcen
				 INTO   v_actuacion_res
				 FROM   ga_actabo
				 WHERE  cod_modulo     = CN_modulo
				 AND    cod_producto   = CN_producto
	 	         AND    cod_tecnologia = v_tecnologia
				 AND    cod_actabo     = v_actabo_ar;
			   EXCEPTION
			    	WHEN NO_DATA_FOUND THEN
			    	v_actuacion_res := NULL;
			   END;
		    END IF;

			Al_Pac_Numeracion.p_activar_central (v_actuacion_res, v_prefijo, v_serord.cod_central,v_serord.num_telefono, v_serhex, v_terminal,v_error, NULL,NULL,v_serord.num_serie);

		END IF;
		-- activar par serie/telefono amistar
		-- JLV 19-11-99 Modificado, todos los amistar entraran con 5, para distinguir
		-- los nuevos de los que estaban antes.

		IF v_movim.num_telefono IS NOT NULL  AND v_tipord_ref = 1 AND v_movim.ind_telefono = 7  THEN
			-- SVG modificado para distinguir los amistar que van a entrar con Mensajeria Corta, que
			-- van a entrar con ind_telefono = 7

            SELECT al_fn_prefijo_numero(v_movim.num_telefono)
            INTO v_prefijo
            FROM dual;

			p_select_serhex (v_orden_ing, v_linord.num_linea, v_serord.num_serie, v_serord.num_telefono, v_serhex);

			IF (v_terminal =v_CodSimGsm AND v_serord.cod_producto=1) THEN
			  BEGIN
				  SELECT cod_actcen
				  INTO   v_actuacion_ami
				  FROM   ga_actabo
				  WHERE  cod_modulo     = CN_modulo
				  AND    cod_producto   = CN_producto
		   		  AND    cod_tecnologia = v_tecnologia
				  AND    cod_actabo     = v_actabo_ga;
			   EXCEPTION
			    	WHEN NO_DATA_FOUND THEN
			    	v_actuacion_ami := NULL;
			   END;
			ELSE
			  BEGIN
				  SELECT cod_actcen
				  INTO   v_actuacion_ami
				  FROM   ga_actabo
				  WHERE  cod_modulo     = CN_modulo
				  AND    cod_producto   = CN_producto
		   		  AND    cod_tecnologia = v_tecnologia
				  AND    cod_actabo     = v_actabo_mm;
			   EXCEPTION
			    	WHEN NO_DATA_FOUND THEN
			    	v_actuacion_ami := NULL;
			   END;
			END IF;

			Al_Pac_Numeracion.p_activar_central (v_actuacion_ami, v_prefijo, v_serord.cod_central,v_serord.num_telefono,v_serhex, v_terminal, v_error,	v_serord.PLAN, v_serord.carga,v_serord.num_serie);

		END IF;
     	--- Modificado por S.V.G para Amistar Restringido
		IF v_movim.num_telefono IS NOT NULL  AND v_tipord_ref = 1 AND v_movim.ind_telefono = 6  THEN
			-- activar par serie/telefono amistar

           SELECT al_fn_prefijo_numero(v_movim.num_telefono)
           INTO v_prefijo
           FROM dual;

		   p_select_serhex (v_orden_ing, v_linord.num_linea, v_serord.num_serie,v_serord.num_telefono, v_serhex);

           IF (v_terminal =v_CodSimGsm AND v_serord.cod_producto=1) THEN
		   	  BEGIN
				  SELECT cod_actcen
				  INTO   v_actuacion_res_ami
				  FROM   ga_actabo
				  WHERE  cod_modulo     = CN_modulo
				  AND    cod_producto   = CN_producto
		   		  AND    cod_tecnologia = v_tecnologia
				  AND    cod_actabo     = v_actabo_rm;
			   EXCEPTION
			    	WHEN NO_DATA_FOUND THEN
			    	v_actuacion_res_ami := NULL;
			   END;
		   ELSE
		   	  BEGIN
				  SELECT cod_actcen
				  INTO   v_actuacion_res_ami
				  FROM   ga_actabo
				  WHERE  cod_modulo     = CN_modulo
				  AND    cod_producto   = CN_producto
				  AND    cod_tecnologia = v_tecnologia
				  AND    cod_actabo     = v_actabo_ra;
			   EXCEPTION
			    	WHEN NO_DATA_FOUND THEN
			    	v_actuacion_res_ami := NULL;
			   END;
		   END IF;

			Al_Pac_Numeracion.p_activar_central (v_actuacion_res_ami, v_prefijo,  v_serord.cod_central,v_serord.num_telefono, v_serhex, v_terminal, v_error,v_serord.PLAN, v_serord.carga,v_serord.num_serie);
		END IF;
	END LOOP;
END p_lee_series;



END Al_Proc_Ingreso;
/
SHOW ERRORS
