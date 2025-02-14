CREATE OR REPLACE PACKAGE BODY        AL_PAC_LOCALIZA AS
PROCEDURE P_MODIFICA_RACK(
vp_FILOLD  IN NUMBER,
vp_COLOLD  IN NUMBER,
vp_FILNEW  IN NUMBER,
vp_COLNEW  IN NUMBER,
vp_BODEGA IN NUMBER,
vp_ZONA   IN VARCHAR,
vp_RACK   IN VARCHAR,
vp_USUARIO IN VARCHAR2
) IS
  v_x NUMBER;
  v_y NUMBER;
  v_sec_loca NUMBER;
ERROR_PROCESO_P_MODIFICA_RACK EXCEPTION;
BEGIN
	FOR v_x IN (vp_FILOLD+1)..vp_FILNEW LOOP
	 	FOR v_y IN 1..vp_COLOLD  LOOP
		   	SELECT AL_SEQ_LOCA.NEXTVAL INTO v_sec_loca FROM dual;
			INSERT INTO AL_LOCALIZA (NUM_SEC_LOCA, COD_BODEGA, COD_ZONA,COD_RACK, NUM_FILA, NUM_COLUMNA,FEC_CREA, COD_USUA )
            VALUES (v_sec_loca,vp_BODEGA,vp_ZONA,vp_RACK,v_x,v_y,SYSDATE, vp_USUARIO);
		END LOOP;
	END LOOP;
	FOR v_x IN 1..vp_FILNEW LOOP
		FOR v_y IN (vp_COLOLD+1)..vp_COLNEW LOOP
		  	SELECT AL_SEQ_LOCA.NEXTVAL INTO v_sec_loca FROM dual;
				INSERT INTO AL_LOCALIZA (NUM_SEC_LOCA, COD_BODEGA, COD_ZONA,COD_RACK, NUM_FILA, NUM_COLUMNA,FEC_CREA, COD_USUA )
				VALUES (v_sec_loca,vp_BODEGA,vp_ZONA,vp_RACK,v_x,v_y,SYSDATE, vp_USUARIO);
		END LOOP;
	END LOOP;

	UPDATE AL_LOCALIZA SET FEC_CREA = SYSDATE, COD_USUA =  vp_USUARIO
	WHERE COD_BODEGA = vp_BODEGA  AND
	      COD_ZONA   = vp_ZONA AND
		  COD_RACK   = vp_RACK;
	COMMIT;
EXCEPTION
          WHEN ERROR_PROCESO_P_MODIFICA_RACK THEN
		  	   ROLLBACK;
			   RAISE_APPLICATION_ERROR  (-20001,'TMError:' || 'No pudo insertar los elementos.');
END;

PROCEDURE  P_INGRESA_RACK (
vp_MAXFIL IN NUMBER,
vp_MAXCOL IN NUMBER,
vp_BODEGA IN NUMBER,
vp_ZONA   IN VARCHAR,
vp_RACK   IN VARCHAR,
vp_USUARIO IN VARCHAR2
) IS
  v_x NUMBER;
  v_y NUMBER;
  v_sec_loca NUMBER;
  v_fecha DATE;
ERROR_PROCESO_P_INGRESA_RACK EXCEPTION;
BEGIN
	SELECT SYSDATE INTO v_fecha FROM dual;
	FOR v_x IN 1..vp_MAXFIL LOOP
		FOR v_y IN 1..vp_MAXCOL LOOP
			SELECT AL_SEQ_LOCA.NEXTVAL INTO v_sec_loca FROM dual;
			INSERT INTO AL_LOCALIZA (NUM_SEC_LOCA, COD_BODEGA, COD_ZONA,COD_RACK, NUM_FILA, NUM_COLUMNA,FEC_CREA, COD_USUA )
			VALUES (v_sec_loca,vp_BODEGA,vp_ZONA,vp_RACK,v_x,v_y,v_fecha, vp_USUARIO);
		END LOOP;
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN ERROR_PROCESO_P_INGRESA_RACK THEN
		ROLLBACK;
		RAISE_APPLICATION_ERROR  (-20001,'TMError:' || 'No pudo insertar los elementos.');
END;
PROCEDURE  P_CIERR_LOCALIZACION (vp_NUM_MOVI IN NUMBER) IS
v_num_sec_nue  		 NUMBER;
v_num_sec_ant  		 NUMBER;
v_cantidadMove 		 NUMBER;
v_cuentaRegistro 	 NUMBER;
v_sw_seriado         NUMBER;
CURSOR Datos IS
	    SELECT A.COD_ARTICULO ACOD_ARTICULO, A.CAN_MOVI ACAN_MOVI,
		       A.NUM_SEC_ANT ANUM_SEC_ANT, A.NUM_SEC_NUE ANUM_SEC_NUE,
			   B.NUM_SERIE BNUM_SERIE, B.NUM_SEC_ANT BNUM_SEC_ANT,
			   B.NUM_SEC_NUE BNUM_SEC_NUE
	    FROM   AL_LIN_MOVI_LOCA A, AL_SER_MOVI_LOCA B
		WHERE  A.num_movi     = vp_NUM_MOVI AND
			   B.num_movi(+)  = A.num_movi  AND
		  	   B.NUM_LINEA(+) = A.NUM_LINEA
		ORDER BY A.COD_ARTICULO, A.NUM_SEC_NUE;
ERROR_P_CIERR_LOCALIZACION EXCEPTION;
BEGIN
	v_sw_seriado   := 1;
	FOR vReg IN Datos LOOP
		IF vReg.BNUM_SERIE IS NOT NULL THEN -- Articulo  Seriado
			v_sw_seriado   := 0;
			v_cantidadMove := 1;
			v_num_sec_ant  := vReg.BNUM_SEC_ANT;
			v_num_sec_nue  := vReg.BNUM_SEC_NUE;
		ELSE                             --  Articulo no Seriado
			v_sw_seriado   := 1;
			v_cantidadMove := vReg.ACAN_MOVI;
			v_num_sec_ant  := vReg.ANUM_SEC_ANT;
			v_num_sec_nue  := vReg.ANUM_SEC_NUE;
		END IF;
		v_cuentaRegistro := 0;
   		SELECT COUNT(*) INTO v_cuentaRegistro
   		FROM AL_STOCK_LOCALIZACION
   		WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND
   			  NUM_SEC_LOCA =  v_num_sec_ant;
		IF v_cuentaRegistro = 0 THEN				-- No ha Sido Localizado
			SELECT COUNT(*) INTO v_cuentaRegistro
			FROM AL_STOCK_LOCALIZACION
			WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND NUM_SEC_LOCA =  v_num_sec_nue;

			IF v_cuentaRegistro = 1 THEN
				UPDATE AL_STOCK_LOCALIZACION SET CAN_STOCK = CAN_STOCK  + v_cantidadMove
				WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND NUM_SEC_LOCA =  v_num_sec_nue;
			ELSE
				INSERT INTO AL_STOCK_LOCALIZACION (COD_ARTICULO, NUM_SEC_LOCA,
				                                 FEC_CREACION,CAN_STOCK)
				VALUES (vReg.ACOD_ARTICULO, v_num_sec_nue, SYSDATE, v_cantidadMove);
			END IF;

		ELSE
			IF v_cuentaRegistro = 1 THEN
				/* Actualizo Registro Existente */
				UPDATE  AL_STOCK_LOCALIZACION SET CAN_STOCK = CAN_STOCK  - v_cantidadMove
				WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND NUM_SEC_LOCA =  v_num_sec_ant;
				/*  Ver si esta en cero.... si esta en cero deletear*/
				SELECT CAN_STOCK  INTO v_cuentaRegistro FROM AL_STOCK_LOCALIZACION
				WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND NUM_SEC_LOCA =  v_num_sec_ant;
				IF v_cuentaRegistro = 0 THEN
				 DELETE AL_STOCK_LOCALIZACION
				 WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND
				       NUM_SEC_LOCA =  v_num_sec_ant;
				END IF;
				/*  Evaluo si existe el nuevo si existe update si no Insert*/
				SELECT COUNT(*) INTO v_cuentaRegistro
				FROM AL_STOCK_LOCALIZACION
				WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND NUM_SEC_LOCA =  v_num_sec_nue;
				IF v_cuentaRegistro = 1 THEN
				  UPDATE AL_STOCK_LOCALIZACION SET CAN_STOCK = CAN_STOCK  + v_cantidadMove
				  WHERE COD_ARTICULO =  vReg.ACOD_ARTICULO AND NUM_SEC_LOCA =  v_num_sec_nue;
				ELSE
				  INSERT INTO AL_STOCK_LOCALIZACION (COD_ARTICULO, NUM_SEC_LOCA,
				                                     FEC_CREACION,CAN_STOCK)
				  VALUES (vReg.ACOD_ARTICULO, v_num_sec_nue, SYSDATE, v_cantidadMove);
				END IF;
			END IF;
		END IF;
		IF v_sw_seriado= 0 THEN
      		UPDATE al_series SET num_sec_loca = v_num_sec_nue
	  		WHERE num_serie = vReg.BNUM_SERIE;
		END IF;
	END LOOP;
EXCEPTION
	WHEN  ERROR_P_CIERR_LOCALIZACION THEN
    CLOSE  Datos;
	RAISE_APPLICATION_ERROR  (-20001,'TMError:' || 'No se puede cerrar la Relocalizacion');
END;





END Al_Pac_Localiza;
/
SHOW ERRORS
