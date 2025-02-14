CREATE OR REPLACE PACKAGE BODY AL_TRASPASOCLS_PG IS


	PROCEDURE P_SELECCION_AUTOMATICA_PR
			  			   (EN_num_traspaso IN AL_TRASPASOS.NUM_TRASPASO%TYPE,
						    EN_lin_traspaso IN AL_LIN_TRASPASO.LIN_TRASPASO%TYPE,
	  						EN_cantida  IN AL_LIN_PETICION.CAN_TRASPASO%TYPE,
							EN_tipstock IN AL_TIPOS_STOCK.TIP_STOCK%TYPE,
							EN_articulo IN AL_ARTICULOS.COD_ARTICULO%TYPE,
						    EN_uso	   IN AL_USOS.COD_USO%TYPE,
							EN_estado   IN AL_ESTADOS.COD_ESTADO%TYPE)
	IS
  CURSOR C_Ser_Tras IS
	   	 SELECT a.num_serie, a.cap_code, a.num_telefono, a.num_seriemec,
		 	    a.cod_central, a.cod_subalm, a.cod_cat , a.num_sec_loca
	     FROM al_series a, al_localiza b, ged_codigos c, ged_codigos d, al_stock_localizacion e
	     WHERE a.tip_stock = EN_tipstock
	     AND a.cod_bodega = TN_bodega_ori
	  	 AND a.cod_articulo = EN_articulo
	     AND a.cod_uso = EN_uso
	     AND a.cod_estado = EN_estado
	     AND a.num_sec_loca = b.num_sec_loca(+)
	     AND a.num_sec_loca = e.num_sec_loca(+)
	     AND a.cod_articulo = e.cod_articulo(+)
 		 AND b.cod_rack = c.cod_valor(+)
		 AND c.cod_modulo(+) = CV_cod_modulo
		 AND c.nom_tabla(+) = CV_nom_tabla
		 AND c.nom_columna(+) = CV_nom_columna1
		 AND d.cod_modulo(+) = CV_cod_modulo
		 AND d.nom_tabla(+) = CV_nom_tabla
		 AND d.nom_columna(+) = CV_nom_columna2
	 	 AND d.cod_valor(+) = b.cod_zona
         ORDER BY a.FEC_ENTRADA ASC;

	BEGIN

		SELECT cod_bodega_ori, cod_bodega_dest
		INTO  TN_bodega_ori, TN_bodega_dest
		FROM al_traspasos
		WHERE num_traspaso = EN_num_traspaso;

		SELECT COUNT(num_serie)
		INTO TN_ser_ing
		FROM AL_SER_TRASPASO
		WHERE num_traspaso = EN_num_traspaso
		AND lin_traspaso = EN_lin_traspaso;

		TN_cantida := EN_cantida - TN_ser_ing;
        FOR V_Ser_Tras IN C_Ser_Tras LOOP
				GI_Error := 0;
				IF TV_operadora_local = CV_operadora_tmm THEN
	               IF TN_num_telefono  is not  NULL THEN
	                 IF Not SUBALM_SERIE_FN(TN_bodega_dest, TN_num_telefono,V_Ser_Tras.num_serie) THEN
						GI_Error := 1;
	                 END IF;
	               END IF;
	            END IF;


				IF TV_operadora_local = CV_operadora_tmc AND GI_Error = 0 THEN
				   IF VALIDA_COMODATO_FN(V_Ser_Tras.num_serie) THEN
					   GI_Error := 1;
				   END IF;
				END IF;
				IF GI_Error = 0 THEN
					BEGIN
						INSERT INTO AL_SER_TRASPASO
							   ( num_traspaso, lin_traspaso, num_serie, cap_code, num_telefono, num_seriemec, cod_central, cod_subalm, cod_cat,  num_sec_loca_ori)
						VALUES (EN_num_traspaso, EN_lin_traspaso, V_Ser_Tras.num_serie, V_Ser_Tras.cap_code ,V_Ser_Tras.num_telefono ,V_Ser_Tras.num_seriemec ,V_Ser_Tras.cod_central ,V_Ser_Tras.cod_subalm , V_Ser_Tras.cod_cat , V_Ser_Tras.num_sec_loca);
						TN_num_sec_loca :=  V_Ser_Tras.num_sec_loca;
						TN_cantida := TN_cantida - 1;
						EXCEPTION WHEN OTHERS THEN
						    NULL; -- ESTO ES SOLO PARA EVITAR EL NOT IN DEL CURSOR INICIAL Y MEJORAR LOS TIEMPO , SI SE CAE
						 	   	-- POR PK  SOLO VUELVE AL PRINCIPIO
					END;
				END IF;

			    EXIT WHEN TN_cantida = 0;

		END LOOP;
			IF TN_ser_ing = 0 AND TN_cantida = 0 THEN
				INSERT INTO AL_LIN_TRASPASO
					   (NUM_TRASPASO, LIN_TRASPASO, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, CAN_TRASPASO,FEC_ENTRADA,NUM_SEC_LOCA_ORI)
				VALUES(EN_num_traspaso, EN_lin_traspaso, EN_tipstock, EN_articulo, EN_uso, EN_estado, EN_cantida,SYSDATE,TN_num_sec_loca);
			ELSE
				IF TN_cantida = 0 THEN
					UPDATE AL_LIN_TRASPASO
					SET CAN_TRASPASO =  EN_cantida
					WHERE NUM_TRASPASO = EN_num_traspaso
					AND lin_TRASPASO = EN_lin_traspaso;
				ELSE
					AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,1, EN_num_traspaso, EN_lin_traspaso, 5, 2);
				END IF;
			END IF;
	END P_SELECCION_AUTOMATICA_PR;

	PROCEDURE P_SELECCION_MASIVA_PR(EN_num_traspaso IN AL_TRASPASOS.NUM_TRASPASO%TYPE,
						    EN_lin_traspaso IN AL_LIN_TRASPASO.lin_TRASPASO%TYPE,
	  						EN_cantida  IN AL_lin_PETICION.CAN_TRASPASO%TYPE,
							EN_tipstock IN AL_TIPOS_STOCK.TIP_STOCK%TYPE,
							EN_articulo IN AL_ARTICULOS.COD_ARTICULO%TYPE,
						    EN_uso	   IN AL_USOS.COD_USO%TYPE,
							EN_estado   IN AL_ESTADOS.COD_ESTADO%TYPE)

	IS
/*
 <Documentacion TipoDoc = "Procedimiento">
 <Elemento Nombre = " P_SELECCION_AUTOMATICA_PR" Lenguaje="PL/SQL" Fecha="12-05-2006" Version="1.1"
       Diseñador="****" Programador="******" Ambiente="BD">
 <Retorno>String</Retorno>
 <Descripcion>Rutinas de traspaso de mercaderia</Descripcion>
 <Parametros>
 <Entrada>
 <param nom="EN_num_traspaso" Tipo="AL_TRASPASOS.NUM_TRASPASO%TYPE"> numero traspaso </param>
 <param nom="EN_lin_traspaso" Tipo="AL_LIN_TRASPASO.LIN_TRASPASO%TYPE"> linea de Traspaso </param>
 <param nom="EN_cantida" Tipo="AL_TRASPASOS.NUM_TRASPASO%TYPE"> Cantidad </param>
 <param nom="EN_tipstock" Tipo="AL_TIPOS_STOCK.TIP_STOCK%TYPE"> Tipo de stock </param>
 <param nom="EN_articulo" Tipo="AL_ARTICULOS.COD_ARTICULO%TYPE%TYPE"> Articulo </param>
 <param nom="EN_uso" Tipo="AL_USOS.COD_USO%TYPE"> Uso </param>
 <param nom="EN_estado" Tipo="AL_ESTADOS.COD_ESTADO%TYPE"> Estado </param>
 </Entrada>
 <Salida>
 </Salida>
 </Parametros>
 </Elemento>
 </Documentacion>
*/


	  CURSOR C_Ser_Tras_Mas IS
	   	 	SELECT a.num_serie,b.num_telefono, b.cap_code, b.cod_central, b.cod_subalm,
		               b.cod_cat, b.num_sec_loca, b.num_seriemec, b.cod_estado
			FROM AL_SERIES_TEMP_TO a, AL_SERIES b
			WHERE a.cod_modulo = cv_cod_modulo
  			  AND a.proc_invocador = cv_proc_invo_aut
  			  AND a.num_traspaso = en_num_traspaso
  			  AND a.lin_traspaso = en_lin_traspaso
                          AND a.num_serie = b.num_serie(+);


	BEGIN

	    dbms_output.put_line('entre');
		TN_cantida := EN_cantida;

		SELECT cod_operadora_scl
		INTO TV_operadora_local
		FROM ge_operadora_scl_local;

		SELECT cod_bodega_ori, cod_bodega_dest
		INTO  TN_bodega_ori, TN_bodega_dest
		FROM al_traspasos
		WHERE num_traspaso = EN_num_traspaso;

		SELECT COUNT(num_serie)
		INTO TN_ser_ing
		FROM AL_SER_TRASPASO
		WHERE num_traspaso = EN_num_traspaso
		AND lin_traspaso = EN_lin_traspaso;

		GI_Error := 2;

        FOR V_Ser_Tras IN C_Ser_Tras_Mas LOOP
			-- C.C.A. INCIDENCIA CO-200605100110 12-05-2006
			IF NOT VALIDA_TRASPASO_FN(V_Ser_Tras.num_serie, EN_num_traspaso, EN_lin_traspaso, EN_tipstock, EN_articulo, EN_uso, EN_estado) AND V_Ser_Tras.cod_estado <> 1 THEN
					TN_cantida := TN_cantida - 1;
			ELSE

				GI_Error := 0;
				IF TV_operadora_local = CV_operadora_tmc AND GI_Error = 0 THEN
				   IF VALIDA_COMODATO_FN(V_Ser_Tras.num_serie) THEN
				   	   AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,V_Ser_Tras.num_serie, EN_num_traspaso, EN_lin_traspaso, 4, 0);
					   TN_cantida := TN_cantida - 1;
					   GI_Error := 1;
				   END IF;
				END IF;
				IF GI_Error = 0 THEN
					BEGIN
						INSERT INTO AL_SER_TRASPASO
							   ( num_traspaso, lin_traspaso, num_serie, cap_code, num_telefono, num_seriemec, cod_central, cod_subalm, cod_cat,  num_sec_loca_ori)
						VALUES (EN_num_traspaso, EN_lin_traspaso, V_Ser_Tras.num_serie, V_Ser_Tras.cap_code, V_Ser_Tras.num_telefono, V_Ser_Tras.num_seriemec,
		                                                V_Ser_Tras.cod_central, V_Ser_Tras.cod_subalm, V_Ser_Tras.cod_cat, V_Ser_Tras.num_sec_loca);
						EXCEPTION
						WHEN DUP_VAL_ON_INDEX THEN
						     TN_cantida := TN_cantida - 1;
							 AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,V_Ser_Tras.num_serie, EN_num_traspaso, EN_lin_traspaso, 6, 0);
						WHEN  OTHERS THEN
						     TN_cantida := TN_cantida - 1;
							 AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,V_Ser_Tras.num_serie, EN_num_traspaso, EN_lin_traspaso, 7, 0);
					END;
				END IF;
			END IF;
		END LOOP;
			IF GI_Error <> 2 THEN
				IF TN_ser_ing = 0 THEN
					INSERT INTO AL_LIN_TRASPASO
						   (NUM_TRASPASO, LIN_TRASPASO, TIP_STOCK, COD_ARTICULO, COD_USO, COD_ESTADO, CAN_TRASPASO,FEC_ENTRADA,NUM_SEC_LOCA_ORI)
					VALUES(EN_num_traspaso, EN_lin_traspaso, EN_tipstock, EN_articulo, EN_uso, EN_estado, TN_cantida,SYSDATE,TN_num_sec_loca);
				ELSE
					UPDATE AL_LIN_TRASPASO
					SET CAN_TRASPASO =  TN_cantida
					WHERE NUM_TRASPASO = EN_num_traspaso
					AND lin_TRASPASO = EN_lin_traspaso;
				END IF;
			END IF;
	END P_SELECCION_MASIVA_PR;


	PROCEDURE P_VALIDA_MASIVO_PR(EN_num_traspaso IN AL_TRASPASOS_MASIVO.NUM_TRASPASO_MASIVO%TYPE)

	AS
	  CURSOR C_Art_Tras IS
			SELECT num_serie, cod_bodega_ori, cod_bodega_dest, tip_stock, cod_articulo,
				   cod_uso, cod_estado, num_telefono, num_cantidad
			FROM AL_TRASPASOS_MASIVO
			WHERE num_traspaso_masivo = EN_num_traspaso;

	BEGIN

		SELECT cod_operadora_scl
		INTO TV_operadora_local
		FROM ge_operadora_scl_local;

		IF AL_VALIDA_PERMISOS_FN(EN_num_traspaso) THEN
			FOR V_Art_Tras IN C_Art_Tras LOOP
				IF V_Art_Tras.num_serie LIKE 'NS%' THEN -- Articulos No Seriados
				   IF NOT VALIDA_STOCK_NO_SERIADO_FN(V_Art_Tras.cod_bodega_ori,V_Art_Tras.tip_stock,V_Art_Tras.cod_articulo,V_Art_Tras.cod_uso,V_Art_Tras.cod_estado) THEN
				   	  AL_GRABA_ERROR_TRASPASO_PR(V_Art_Tras.cod_articulo,'Articulo '||V_Art_Tras.cod_articulo, EN_num_traspaso, 1, 13, 1);
					  GI_Error := 1;
				   END IF;
				ELSE -- Articulos Seriados
					IF V_Art_Tras.num_cantidad <> 1 THEN
					    AL_GRABA_ERROR_TRASPASO_PR(V_Art_Tras.cod_articulo,V_Art_Tras.num_serie, EN_num_traspaso, 1, 2, 1);
						GI_Error := 1;
					ELSE
						 IF NOT VALIDA_STOCK_SERIADO_FN(V_Art_Tras.num_serie,V_Art_Tras.cod_bodega_ori,V_Art_Tras.tip_stock,V_Art_Tras.cod_articulo,V_Art_Tras.cod_uso,V_Art_Tras.cod_estado) THEN
						 	AL_GRABA_ERROR_TRASPASO_PR(V_Art_Tras.cod_articulo,V_Art_Tras.num_serie, EN_num_traspaso, 1, 1, 1);
							GI_Error := 1;
						 ELSE
						 	 IF NOT VALIDA_SERIE_EN_TRASPASOS_FN(V_Art_Tras.num_serie) THEN
							 	AL_GRABA_ERROR_TRASPASO_PR(V_Art_Tras.cod_articulo,V_Art_Tras.num_serie, EN_num_traspaso, 1, 3, 1);
								GI_Error := 1;
							 ELSE
								GI_Error := 0;
								IF TV_operadora_local = CV_operadora_tmm AND V_Art_Tras.num_telefono is not NULL THEN
					                 IF Not SUBALM_SERIE_FN(V_Art_Tras.cod_bodega_dest, V_Art_Tras.num_telefono, V_Art_Tras.num_serie) THEN
					                    AL_GRABA_ERROR_TRASPASO_PR(V_Art_Tras.cod_articulo,V_Art_Tras.num_serie, EN_num_traspaso, 1, 4, 1);
										GI_Error := 1;
					                 END IF;
					            END IF;

								IF TV_operadora_local = CV_operadora_tmc AND GI_Error = 0 THEN
								   IF VALIDA_COMODATO_FN( V_Art_Tras.num_serie) THEN
								   	   AL_GRABA_ERROR_TRASPASO_PR(V_Art_Tras.cod_articulo,V_Art_Tras.num_serie, EN_num_traspaso, 1, 5, 1);
									   GI_Error := 1;
								   END IF;
								END IF;
							 END IF;
						 END IF;
					END IF;
				END IF;
			END LOOP;
		END IF;


	END P_VALIDA_MASIVO_PR;

	FUNCTION VALIDA_TRASPASO_FN(EV_num_serie IN AL_SERIES.NUM_SERIE%TYPE,
			  				EN_num_traspaso IN AL_TRASPASOS.NUM_TRASPASO%TYPE,
  							EN_lin_traspaso IN AL_LIN_TRASPASO.lin_TRASPASO%TYPE,
  							EN_tipstock IN AL_TIPOS_STOCK.TIP_STOCK%TYPE,
							EN_articulo IN AL_ARTICULOS.COD_ARTICULO%TYPE,
						    EN_uso	   IN AL_USOS.COD_USO%TYPE,
							EN_estado   IN AL_ESTADOS.COD_ESTADO%TYPE) RETURN Boolean
	IS
/*
 <Documentacion TipoDoc = "Función">
 <Elemento Nombre = " VALIDA_TRASPASO_FN " Lenguaje="PL/SQL" Fecha="12-05-2006" Version="1.1"
       Diseñador="****" Programador="******" Ambiente="BD">
 <Retorno>String</Retorno>
 <Descripcion>Rutinas de traspaso de mercaderia</Descripcion>
 <Parametros>
 <Entrada>
 <param nom="EV_num_serie" Tipo="AL_SERIES.NUM_SERIE%TYPE"> Numero de serie</param>
 <param nom="EN_num_traspaso" Tipo="AL_TRASPASOS.NUM_TRASPASO%TYPE"> numero traspaso</param>
 <param nom="EN_lin_traspaso" Tipo="AL_LIN_TRASPASO.lin_TRASPASO%TYPE"> Linea de traspaso</param>
 <param nom="EN_tipstock" Tipo="AL_TIPOS_STOCK.TIP_STOCK%TYPE"> Tipo Stock</param>
 <param nom="EN_articulo" Tipo="AL_ARTICULOS.COD_ARTICULO%TYPE"> Codigo Articulo </param>
 <param nom="EN_uso" Tipo="AL_USOS.COD_USO%TYPE"> Uso</param>
 <param nom="EN_estado" Tipo="AL_ESTADOS.COD_ESTADO%TYPE"> Estado de la serie</param>
 <Salida>
 </Salida>
 </Parametros>
 </Elemento>
 </Documentacion>
*/
    TV_existe_serie al_series.num_Serie%type;
	LV_return VARCHAR(5);

	BEGIN
		 BEGIN
	  	     SELECT a.num_serie
			 INTO TV_existe_serie
		     FROM al_localiza b, ged_codigos c, ged_codigos d, al_stock_localizacion e, al_series a
		     WHERE a.NUM_SERIE = EV_num_serie
			 AND a.tip_stock = EN_tipstock
		     AND a.cod_bodega = TN_bodega_ori
		  	 AND a.cod_articulo = EN_articulo
		     AND a.cod_uso = EN_uso
		     AND a.cod_estado = EN_estado
		     AND a.num_sec_loca = b.num_sec_loca(+)
		     AND a.num_sec_loca = e.num_sec_loca(+)
		     AND a.cod_articulo = e.cod_articulo(+)
			 AND b.cod_zona = d.cod_valor(+)
			 AND b.cod_rack = c.cod_valor(+)
			 AND c.cod_modulo(+) = CV_cod_modulo
			 AND c.nom_tabla(+) = CV_nom_tabla
			 AND c.nom_columna(+) = CV_nom_columna1
			 AND d.cod_modulo(+) = CV_cod_modulo
			 AND d.nom_tabla(+) = CV_nom_tabla
			 AND d.nom_columna(+) = CV_nom_columna2;

			 LV_return := 'TRUE';
			 dbms_output.put_line('Primera validacion OK');

			EXCEPTION
				    WHEN NO_DATA_FOUND THEN
				  	  	  AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,EV_num_serie, EN_num_traspaso, EN_lin_traspaso, 6, 0);
						  RETURN FALSE;
					WHEN TOO_MANY_ROWS  THEN
					      AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,EV_num_serie, EN_num_traspaso, EN_lin_traspaso, 2, 0);
						  RETURN FALSE;
					WHEN OTHERS THEN
		    	  		  RAISE_APPLICATION_ERROR(sqlcode, sqlerrm);
						  RETURN FALSE;
		 END;

		 -- C.C.A. INCIDENCIA CO-200605100110 12-05-2006
  		 BEGIN
		     TV_existe_serie := '' ;

	  	     SELECT a.num_serie
			 INTO TV_existe_serie
		     FROM al_ser_traspaso a, al_traspasos b
		     WHERE a.NUM_SERIE = EV_num_serie
			 AND A.NUM_TRASPASO <> EN_num_traspaso
			 AND A.NUM_TRASPASO = B.NUM_TRASPASO
			 AND B.COD_ESTADO <> 'RM';

	         IF TV_existe_serie = EV_num_serie THEN
                AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,EV_num_serie, EN_num_traspaso, EN_lin_traspaso, 6, 0);
			 END IF;

			 LV_return := 'FALSE';

			EXCEPTION
				    WHEN NO_DATA_FOUND THEN
					      dbms_output.put_line('Not_found');
						  RETURN TRUE;
					WHEN TOO_MANY_ROWS  THEN
					      dbms_output.put_line('TOO-MANY');
					      AL_GRABA_ERROR_TRASPASO_PR(EN_articulo,EV_num_serie, EN_num_traspaso, EN_lin_traspaso, 3, 0);
						  RETURN FALSE;
					WHEN OTHERS THEN
					      dbms_output.put_line('OTHERS');
		    	  		  RAISE_APPLICATION_ERROR(sqlcode, sqlerrm);
						  RETURN FALSE;
		 END;


		 IF LV_return = 'TRUE' THEN
		    RETURN TRUE;
		 ELSE
		    RETURN FALSE;
		 END IF;
		 -- C.C.A. INCIDENCIA CO-200605100110 12-05-2006

	END;

	FUNCTION SUBALM_SERIE_FN(EN_bodega_destino IN AL_BODEGAS.COD_BODEGA%TYPE ,
							EN_num_celular    IN AL_SERIES.NUM_TELEFONO%TYPE ,
							EV_num_serie      IN AL_SERIES.NUM_SERIE%TYPE) RETURN Boolean
	IS

		 TV_num_alm_bod_dest GE_CELDAS.COD_SUBALM%TYPE;
		 TN_num_telefono     AL_SERIES.NUM_TELEFONO%TYPE;
		 TV_sub_alm_celular  AL_SERIES.COD_SUBALM%TYPE;
	BEGIN

    	SELECT d.cod_subalm
		INTO TV_num_alm_bod_dest
    	FROM al_bodegas a,ge_celdas d, ge_ciudades c, ge_direcciones b
     	WHERE a.cod_bodega = EN_bodega_destino
	    AND   a.cod_direccion = b.cod_direccion
	    AND   b.cod_provincia = c.cod_provincia
	    AND   b.cod_region = c.cod_region
	    AND   b.cod_ciudad = c.cod_ciudad
	    AND   c.cod_celda = d.cod_celda;

	   TN_num_telefono := 0;

	   IF EN_num_celular is NULL THEN
	       SELECT nvl(a.num_telefono,0)
		   INTO TN_num_telefono
	       FROM AL_SERIES a
	       WHERE a.num_serie = EV_num_serie;
	   ELSE
	       TN_num_telefono := EN_num_celular;
	   END IF;

	   IF TN_num_telefono IS NOT NULL AND TN_num_telefono <> 0 THEN
	     SELECT cod_subalm
		 INTO TV_sub_alm_celular
	     FROM GA_CELNUM_USO
	     WHERE TN_num_telefono
		 BETWEEN num_desde AND num_hasta;
            IF TV_sub_alm_celular = TV_num_alm_bod_dest THEN
                RETURN TRUE;
			ELSE
				RETURN FALSE;
            END IF;
	   ELSE
   	     RETURN True;
	   END IF;
	END;

	FUNCTION VALIDA_COMODATO_FN(EV_num_serie IN AL_SERIES.NUM_SERIE%TYPE) RETURN Boolean
	IS

		TN_bodega_comodato AL_BODEGAS.COD_BODEGA%TYPE;
		I_comodato		  PLS_INTEGER;
		CV_cod_situacion   CONSTANT GA_ABOCEL.COD_SITUACION%TYPE := 'BAA';
		CV_nom_parametro   CONSTANT GED_PARAMETROS.NOM_PARAMETRO%TYPE := 'COD_BODEGA_COMODATO';

	BEGIN
		SELECT a.val_parametro
		INTO TN_bodega_comodato
		FROM GED_PARAMETROS a
		WHERE a.nom_parametro = CV_nom_parametro
		AND a.cod_modulo = CV_cod_modulo;

		SELECT count(b.cod_situacion)
		INTO I_comodato
		FROM AL_SERIES a,GA_ABOCEL b
		WHERE b.num_serie = a.num_serie
		AND b.num_serie = EV_num_serie
		AND b.cod_situacion <> CV_cod_situacion
		AND b.ind_eqprestado = 1
		AND a.cod_bodega = TN_bodega_comodato;

		IF I_comodato > 0 THEN
		   RETURN True;
		ELSE
		   RETURN False;
		END IF;
	END;

	FUNCTION VALIDA_STOCK_NO_SERIADO_FN(EN_cod_bodega IN AL_TRASPASOS_MASIVO.COD_BODEGA_ORI%TYPE,
			 							EN_tip_stock IN AL_TRASPASOS_MASIVO.TIP_STOCK%TYPE,
										EN_cod_articulo IN AL_TRASPASOS_MASIVO.COD_ARTICULO%TYPE,
										EN_cod_uso IN AL_TRASPASOS_MASIVO.COD_USO%TYPE,
										EN_cod_estado IN AL_TRASPASOS_MASIVO.COD_ESTADO%TYPE) RETURN Boolean
	IS

	  	I_stock PLS_INTEGER;
		I_ind_disponibilidad CONSTANT PLS_INTEGER := 1;
	BEGIN
		SELECT COUNT(1)
		INTO I_stock
		FROM AL_ESTADOS b, AL_STOCK a
		WHERE a.cod_bodega = EN_cod_bodega
		AND a.tip_stock = EN_tip_stock
		AND a.cod_articulo = EN_cod_articulo
		AND a.cod_uso = EN_cod_uso
		AND a.cod_estado = EN_cod_estado
		AND a.cod_estado  = b.cod_estado
		AND b.ind_disponibilidad = I_ind_disponibilidad;

		IF I_stock > 0 THEN
		   RETURN TRUE;
		ELSE
		   RETURN FALSE;
		END IF;
	END;


	FUNCTION VALIDA_STOCK_SERIADO_FN(EV_num_serie IN AL_TRASPASOS_MASIVO.NUM_SERIE%TYPE,
			 						  	EN_cod_bodega IN AL_TRASPASOS_MASIVO.COD_BODEGA_ORI%TYPE,
			 							EN_tip_stock IN AL_TRASPASOS_MASIVO.TIP_STOCK%TYPE,
										EN_cod_articulo IN AL_TRASPASOS_MASIVO.COD_ARTICULO%TYPE,
										EN_cod_uso IN AL_TRASPASOS_MASIVO.COD_USO%TYPE,
										EN_cod_estado IN AL_TRASPASOS_MASIVO.COD_ESTADO%TYPE) RETURN Boolean
	IS

	  	I_stock PLS_INTEGER;
		I_ind_disponibilidad CONSTANT PLS_INTEGER := 1;
	BEGIN
		SELECT COUNT(1)
		INTO I_stock
		FROM  AL_ESTADOS b, AL_SERIES a
		WHERE a.num_serie = EV_num_serie
	    AND a.cod_bodega = EN_cod_bodega
		AND a.tip_stock = EN_tip_stock
		AND a.cod_articulo = EN_cod_articulo
		AND a.cod_uso = EN_cod_uso
		AND a.cod_estado = EN_cod_estado
		AND a.cod_estado  = b.cod_estado
		AND b.ind_disponibilidad = I_ind_disponibilidad;

		IF I_stock > 0 THEN
		   RETURN TRUE;
		ELSE
		   RETURN FALSE;
		END IF;
	END;


	FUNCTION VALIDA_SERIE_EN_TRASPASOS_FN(EV_num_serie IN AL_TRASPASOS_MASIVO.NUM_SERIE%TYPE) RETURN Boolean
	IS

	  	I_stock PLS_INTEGER;
		CV_cod_estado_tras CONSTANT AL_TRASPASOS_MASIVO.COD_ESTADO_TRAS%TYPE := 'PD';


	BEGIN
		SELECT COUNT(1)
		INTO I_stock
		FROM AL_TRASPASOS_MASIVO a
		WHERE a.num_traspaso_masivo > 0
		AND a.num_serie = EV_num_serie
		AND a.cod_estado_tras = CV_cod_estado_tras;

		IF I_stock > 0 THEN
		   RETURN TRUE;
		ELSE
		   RETURN FALSE;
		END IF;
	END;


   PROCEDURE AL_GRABA_ERROR_TRASPASO_PR (EN_articulo	IN AL_ARTICULOS.COD_ARTICULO%TYPE,
   			 							EV_num_serie    IN AL_SERIES.NUM_SERIE%TYPE,
   			 							EN_num_traspaso IN AL_TRASPASOS.NUM_TRASPASO%TYPE,
						    			EN_lin_traspaso IN AL_LIN_TRASPASO.lin_TRASPASO%TYPE,
										EN_cod_error    IN PLS_INTEGER,
										EN_opcion    	IN PLS_INTEGER,
										EN_bodega_ori	IN AL_TRASPASOS_MASIVO.COD_BODEGA_ORI%TYPE DEFAULT null,
										EN_bodega_dest	IN AL_TRASPASOS_MASIVO.COD_BODEGA_DEST%TYPE DEFAULT null) IS

	  BEGIN
	  	    IF EN_opcion = 0 THEN
			  UPDATE AL_SERIES_TEMP_TO
			  SET    COD_ERROR = EN_cod_error
				WHERE COD_MODULO = CV_cod_modulo
				AND PROC_INVOCADOR = CV_proc_invo_aut
				AND NUM_TRASPASO = EN_num_traspaso
				AND lin_TRASPASO = EN_lin_traspaso
				AND NUM_SERIE = EV_num_serie;
		    END IF;
		    IF EN_opcion = 1 THEN
				INSERT INTO AL_SERIES_TEMP_TO
					   (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, num_serie, cod_articulo, cod_error)
				VALUES (CV_cod_modulo, CV_proc_invo_tra, EN_num_traspaso, 1, EV_num_serie, EN_articulo, EN_cod_error);
				IF EN_opcion = 1 THEN
					DELETE AL_TRASPASOS_MASIVO
					WHERE num_traspaso_masivo = EN_num_traspaso
					AND num_serie = EV_num_serie;
				END IF;
			END IF;
			IF EN_opcion = 2 THEN
				INSERT INTO AL_SERIES_TEMP_TO
					   (cod_modulo, proc_invocador, num_traspaso, lin_traspaso, num_serie,  cod_error, num_sec_loca_ori, num_sec_loca_dest )
				VALUES (CV_cod_modulo, CV_proc_invo_tra, EN_num_traspaso, 1, EV_num_serie, EN_cod_error, EN_bodega_ori, EN_bodega_dest );
			END IF;
	  END;

    FUNCTION AL_VALIDA_PERMISOS_FN(EN_num_traspaso IN AL_TRASPASOS.NUM_TRASPASO%TYPE) RETURN BOOLEAN

    IS
    /*
    <NOMBRE>	: AL_VALIDA_PERMISOS_PR                                                      </NOMBRE>
    <FECHACREA>	: JUNIO 2004                                                                <FECHACREA/>
    <MODULO >	: ADMINISTRACION DE INVENTARIO.                                             </MODULO >
    <AUTOR >	: Maritza Tapia Alvarez.                                                     </AUTOR >
    <VERSION >	: 01                                                                        </VERSION >
    <DESCRIPCION>: Realiza la validacion de formato al archivo ingresado en el Proceso de   </DESCRIPCION>
    <DESCRIPCION>: Generacion de Kit a traves de Carga Masiva                               </DESCRIPCION>
    <FECHAMOD >	: DD/MM/YYYY                                                                </FECHAMOD >
    <DESCMOD >	: Breve descripcion de Modificacion                                         </DESCMOD >
    <ParamEntr>	 : EN_num_traspaso Numero traspaso asociado                                     </ParamEntr>
    <ParamSal >	:                                                                           </ParamEntr>
    */


    TN_Bodega     AL_PERMISOS_TRASPASO.COD_BODEGA_1%TYPE;
    TN_valorar    AL_TIPOS_STOCK.IND_VALORAR%TYPE;
    TN_valorar1   AL_TIPOS_STOCK.IND_VALORAR%TYPE;
    TN_Tip_bodega AL_BODEGAS.TIP_BODEGA%TYPE;
    TN_TipBodega  AL_TIPOSTOCK_TIPBODEGA.TIP_BODEGA%TYPE;
    TN_bodega_origen AL_TRASPASOS_MASIVO.COD_BODEGA_ORI%TYPE;
    TN_bodega_destino AL_TRASPASOS_MASIVO.COD_BODEGA_DEST%TYPE;
    GN_count   pls_integer;
    CN_cero    CONSTANT pls_integer:=0;
    CN_uno     CONSTANT pls_integer:=1;
    CV_estado  CONSTANT varchar2(2):='PD';
    CV_proceso CONSTANT varchar2(7):='ALRMTRA';
    GN_error   pls_integer:=0;
    Error_General EXCEPTION;

    CURSOR c_BodegaOrigen(TN_traspaso AL_TRASPASOS_MASIVO.num_traspaso_masivo%type) IS
    SELECT DISTINCT a.cod_bodega_ori as bodega_ori
     		, a.cod_bodega_dest as bodega_dest
    		, b.tip_bodega as tip_bodega1
    		, c.tip_bodega as tip_bodega2
    		, d.ind_proveedor as  proveedor1
    		, e.ind_proveedor as proveedor2
     FROM AL_TRASPASOS_MASIVO A , AL_BODEGAS B, AL_BODEGAS C, AL_TIPOS_BODEGAS D , AL_TIPOS_BODEGAS E
     WHERE a.cod_estado_tras = CV_estado
     AND a.num_traspaso_masivo =  TN_traspaso
     AND a.cod_bodega_ori = b.cod_bodega
     AND a.cod_bodega_dest = c.cod_bodega
     AND b.tip_bodega = d.tip_bodega
     AND c.tip_bodega = e.tip_bodega;

    CURSOR c_Tipo_stock(TN_traspaso AL_TRASPASOS_MASIVO.num_traspaso_masivo%type) IS
     SELECT DISTINCT tip_stock_dest
     FROM   AL_TRASPASOS_MASIVO
     WHERE  cod_estado_tras = CV_estado
     AND    num_traspaso_masivo =  TN_traspaso;

    CURSOR c_stock(TN_traspaso AL_TRASPASOS_MASIVO.num_traspaso_masivo%type) IS
     SELECT DISTINCT tip_stock
     	   , tip_stock_dest
     FROM  AL_TRASPASOS_MASIVO
     WHERE cod_estado_tras = CV_estado
     AND   num_traspaso_masivo = TN_traspaso;


    CURSOR c_traspasos(TN_traspaso AL_TRASPASOS_MASIVO.num_traspaso_masivo%type) IS
     SELECT DISTINCT cod_bodega_dest
     		, tip_stock_dest
     FROM  AL_TRASPASOS_MASIVO
     WHERE cod_estado_tras = CV_estado
     AND   num_traspaso_masivo = TN_traspaso;


    BEGIN

        FOR bodega in c_BodegaOrigen(EN_num_traspaso)  LOOP
           TN_bodega_origen:= bodega.bodega_ori;
           TN_bodega_destino:= bodega.bodega_dest;
           IF NOT (bodega.tip_bodega1 = '1' Or bodega.tip_bodega2 = '1' Or bodega.proveedor1 = '1' Or bodega.proveedor2 = '1') THEN
                GN_error:=6;		-- No hay permisos de traspaso entre bodegas
                SELECT a.cod_bodega_1
                INTO  TN_Bodega
                FROM AL_PERMISOS_TRASPASO a
                WHERE ((a.cod_bodega_1 = bodega.bodega_ori
                AND a.cod_bodega_2 = bodega.bodega_dest)
                OR (a.cod_bodega_1 = bodega.bodega_dest
                AND a.cod_bodega_2 = bodega.bodega_ori))
                AND ROWNUM < 2;
           END IF;
        EXIT WHEN c_BodegaOrigen%NOTFOUND;
        END LOOP;


    	FOR stock in c_Tipo_stock(EN_num_traspaso)  LOOP
           SELECT count(a.tip_movimiento)
           INTO  GN_count
           FROM  AL_PROCESOS_TIPMOVIM A,AL_TIPOS_MOVIMIENTOS B
           WHERE a.tip_movimiento = b.tip_movimiento
           AND   a.cod_proceso = CV_proceso
           AND   b.tip_stock =  stock.tip_stock_dest;

           IF GN_count = 0 THEN
    	     	GN_error:=7;	-- Problemas en tipo stock destino TIPO STOCK
    	     	raise Error_General;
           END IF;
     	EXIT WHEN c_Tipo_stock%NOTFOUND;
    	END LOOP;

    	FOR stock in c_stock(EN_num_traspaso)  LOOP
           GN_error:=8;
           SELECT a.ind_valorar
           INTO   TN_valorar
           FROM   AL_TIPOS_STOCK a
           WHERE  a.tip_stock = stock.tip_stock;

           GN_error:=7;		-- Problemas en tipo stock destino TIPO STOCK
           SELECT a.ind_valorar
           INTO   TN_valorar1
           FROM   AL_TIPOS_STOCK a
           WHERE  a.tip_stock = stock.tip_stock_dest;

           IF 	TN_valorar = CN_cero THEN
           	IF 	TN_valorar1 = 1 THEN
           		GN_error:=9;--No esta permitido realizar un traspaso de un articulo no valorado a mercaderia
           	END IF;
           	IF 	TN_valorar1 = 2 THEN
           		GN_error:=10;--No esta permitido realizar un traspaso de un articulo no valorado a activo fijoNo esta permitido realizar un traspaso de un articulo no valorado a mercaderia
           	END IF;
           END IF;

     	EXIT WHEN c_stock%NOTFOUND;
    	END LOOP;

    	FOR traspaso in c_traspasos(EN_num_traspaso)  LOOP
    	  GN_error:=11;		-- Problemas en tipo bodega---> BODEGA:
    	  SELECT b.tip_bodega
    	  INTO   TN_Tip_bodega
    	  FROM   AL_BODEGAS b
    	  WHERE  b.cod_bodega = traspaso.cod_bodega_dest;


    	  GN_error:=12;		-- Problemas en relacion tipo bodega y tipo stock ---> TIP.STOCK:
    	  SELECT b.tip_bodega
    	  INTO  TN_TipBodega
    	  FROM  AL_TIPOSTOCK_TIPBODEGA b
    	  WHERE b.tip_bodega = TN_Tip_bodega
    	  AND   b.tip_stock = traspaso.tip_stock_dest;
    	EXIT WHEN c_traspasos%NOTFOUND;
    	END LOOP;

		RETURN TRUE;

    EXCEPTION
    	WHEN Error_General THEN
    		AL_TRASPASOCLS_PG.AL_GRABA_ERROR_TRASPASO_PR(NULL,'Error General', EN_num_traspaso, 1, GN_error, 2, TN_bodega_origen, TN_bodega_destino);
			RETURN FALSE;
		WHEN NO_DATA_FOUND THEN
    		AL_TRASPASOCLS_PG.AL_GRABA_ERROR_TRASPASO_PR(NULL,'Error General' , EN_num_traspaso, 1, GN_error, 2, TN_bodega_origen, TN_bodega_destino);
			RETURN FALSE;
    	WHEN OTHERS THEN
			raise_application_error(sqlcode,'Nativo :'||sqlerrm);
			RETURN FALSE;
    END AL_VALIDA_PERMISOS_FN;
END AL_TRASPASOCLS_PG;
/
SHOW ERRORS
