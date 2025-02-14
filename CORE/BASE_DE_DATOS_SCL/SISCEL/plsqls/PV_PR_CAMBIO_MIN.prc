CREATE OR REPLACE PROCEDURE PV_PR_CAMBIO_MIN(
	   	  		  		   v_secuencia IN VARCHAR2, -- Secuencia GA_TRANSACABO
		  				   VP_ABONADO  IN VARCHAR2, -- Numero de Abonado--
						   sUsuario	   IN VARCHAR2,	-- Nombre de Usuario Conectado --
		  				   NumMin_ACT  IN VARCHAR2, -- Numero de MIN Actual --
						   NumMin_NVO  IN VARCHAR2, -- Numero de MIN Nuevo --
						   TABLA	   IN VARCHAR2,	-- Nombre de Tabla asociada --
	   	  		  		   sNumSecICC  IN VARCHAR2  -- Secuencia ICC_MOVIMIENTO
		  				  )
IS
	sNumAbonado		ga_abocel.NUM_ABONADO%TYPE;
	sTipTerminal    ga_abocel.TIP_TERMINAL%TYPE;
	sCodCentral		ga_abocel.COD_CENTRAL%TYPE;
	sNumCelular		ga_abocel.NUM_CELULAR%TYPE;
	sNumSerie		ga_abocel.NUM_SERIEHEX%TYPE;
	sNumSerieDec	ga_abocel.NUM_SERIE%TYPE;
	sCodTecnologia	ga_abocel.COD_TECNOLOGIA%TYPE;
	sNumImei		ga_abocel.NUM_IMEI%TYPE;
	sNumImsi		icc_movimiento.IMSI%TYPE;
	sNumMovimiento	icc_movimiento.NUM_MOVIMIENTO%TYPE;
	sCodActuacion	icc_movimiento.COD_ACTUACION%TYPE;

	sTecGSM         ga_abocel.COD_TECNOLOGIA%TYPE;

	sFecIngreso     ga_abocel.FEC_ULTMOD%TYPE;

	V_ERROR   		VARCHAR2(1) := '0';
	V_CADENA		VARCHAR2(255);
	V_param_ok		VARCHAR(5);

	Error_Proceso	EXCEPTION;
BEGIN

	  V_ERROR     := '0';
      V_CADENA    := 'OK';
	  sNumAbonado := TO_NUMBER(VP_ABONADO);

	  sTecGSM := '';
	  SELECT VAL_PARAMETRO INTO sTecGSM
	  FROM   GED_PARAMETROS
	  WHERE  NOM_PARAMETRO = 'TECNOLOGIA_GSM' AND COD_MODULO = 'GA' AND COD_PRODUCTO = 1;
	  IF sTecGSM = '' THEN
			 V_ERROR  := '4';
			 V_CADENA := 'Error al obtener parametro tec. GSM';
			 RAISE ERROR_PROCESO;
	  END IF;

	  SELECT SYSDATE INTO sFecIngreso FROM DUAL;

	  BEGIN
		  ---- Primero vemos que tabla es la correspondiente para modificar GA_ABOCEL / GA_ABOAMIST--
		  IF TABLA = 'GA_ABOCEL' THEN
		  	 UPDATE GA_ABOCEL
			 		SET   FEC_ULTMOD  = sFecIngreso,
			 	 		  NUM_MIN_MDN = NumMin_NVO
					WHERE NUM_ABONADO = sNumAbonado;
			 SELECT TIP_TERMINAL, COD_CENTRAL, NUM_CELULAR, NUM_SERIEHEX, NUM_IMEI, COD_TECNOLOGIA, NUM_SERIE
			 		INTO sTipTerminal, sCodCentral, sNumCelular, sNumSerie, sNumImei, sCodTecnologia, sNumSerieDec
			 		FROM GA_ABOCEL
					WHERE NUM_ABONADO = sNumAbonado;
		  ELSE
		  	 UPDATE GA_ABOAMIST
			 		SET   FEC_ULTMOD  = sFecIngreso,
			 	 		  NUM_MIN_MDN = NumMin_NVO
					WHERE NUM_ABONADO = sNumAbonado;
			 SELECT TIP_TERMINAL, COD_CENTRAL, NUM_CELULAR, NUM_SERIEHEX, NUM_IMEI, COD_TECNOLOGIA, NUM_SERIE
			 		INTO sTipTerminal, sCodCentral, sNumCelular, sNumSerie, sNumImei, sCodTecnologia, sNumSerieDec
			 		FROM GA_ABOAMIST
					WHERE NUM_ABONADO = sNumAbonado;
		  END IF;
		  EXCEPTION
			 	WHEN OTHERS THEN
					 V_ERROR  := '4';
					 V_CADENA := 'Error al insertar en '|| TABLA ||' (Cambio MIN)';
					 RAISE ERROR_PROCESO;
	  END;
	  BEGIN
	  	   INSERT INTO GA_MODABOCEL (
	  		 	  			   NUM_ABONADO, FEC_MODIFICA,
							   COD_TIPMODI, NOM_USUARORA,
							   NUM_MIN_MDN
							   )
					    VALUES (
							   sNumAbonado, sFecIngreso,
							   'MN', sUsuario,
							   NumMin_Act
							   );
		    EXCEPTION
			 	WHEN OTHERS THEN
					 V_ERROR  := '4';
					 V_CADENA := 'Error al insertar en GA_MODABOCEL (Cambio MIN)';
					 RAISE ERROR_PROCESO;
	  END;
	  --Obtiene Codigo de Central--
	  SELECT NVL(FN_CODACTCEN (1,'MN','GA',sCodTecnologia), -1) INTO sCodActuacion FROM DUAL;

	  IF sCodActuacion < 0 then
			 V_ERROR  := '4';
			 V_CADENA := 'Error al obtener cod.act.central para cod_actabo MN';
			 RAISE ERROR_PROCESO;
	  END IF;

	  BEGIN
		  IF sCodTecnologia = sTecGSM THEN
		  	 SELECT FN_RECUPERA_IMSI(sNumSerieDec) INTO sNumImsi FROM DUAL;
			 IF sNumImsi = '' THEN
					 V_ERROR  := '4';
					 V_CADENA := 'Error, No se recupero NUM_IMSI';
					 RAISE ERROR_PROCESO;
			 END IF;

		  	 INSERT INTO ICC_MOVIMIENTO(
		  		 	  			   NUM_MOVIMIENTO, NUM_ABONADO, COD_ACTABO,
								   COD_MODULO, COD_ACTUACION, TIP_TERMINAL,
								   COD_CENTRAL, NUM_CELULAR, NUM_SERIE, FEC_INGRESO,
								   TIP_TECNOLOGIA,IMSI, IMEI, ICC, NOM_USUARORA
								   )
							VALUES (
								   sNumSecICC, sNumAbonado, 'MN',
								   'GA', sCodActuacion, sTipTerminal,
								   sCodCentral, sNumCelular, sNumSerie, sFecIngreso,
								   sCodTecnologia,sNumImsi, sNumImei, sNumSerieDec, USER
								   );
		  ELSE
		  	 INSERT INTO ICC_MOVIMIENTO(
		  		 	  			   NUM_MOVIMIENTO, NUM_ABONADO, COD_ACTABO,
								   COD_MODULO, COD_ACTUACION, TIP_TERMINAL,
								   COD_CENTRAL, NUM_CELULAR, NUM_SERIE, FEC_INGRESO,
								   TIP_TECNOLOGIA, NOM_USUARORA
								   )
							VALUES (
								   sNumSecICC, sNumAbonado, 'MN',
								   'GA', sCodActuacion, sTipTerminal,
								   sCodCentral, sNumCelular, sNumSerie, sFecIngreso,
								   sCodTecnologia, USER
								   );
		   END IF;
		   EXCEPTION
			 	WHEN OTHERS THEN
					 V_ERROR  := '4';
					 V_CADENA := 'Error al insertar en ICC_MOVIMIENTO (Cambio MIN)';
					 RAISE ERROR_PROCESO;
	   END;
	   RAISE ERROR_PROCESO;
EXCEPTION
     WHEN ERROR_PROCESO THEN
	 IF V_ERROR <> '0' THEN
	 	  ROLLBACK;
          INSERT INTO GA_ERRORES
                      (COD_PRODUCTO,
                       COD_ACTABO,
                       CODIGO,
                       FEC_ERROR,
                       NOM_PROC,
                       NOM_TABLA,
                       COD_ACT,
                       COD_SQLCODE,
                       COD_SQLERRM)
               VALUES (1,
                       'MN',
                       0,
                       sFecIngreso,
                       'Abonado : ' || sNumAbonado,
                       TABLA,
                       '',
                       '',
                       SUBSTR(V_CADENA,1,60));
		 COMMIT;
		 V_ERROR := '4';
     END IF;
	 INSERT INTO GA_TRANSACABO (NUM_TRANSACCION, COD_RETORNO, DES_CADENA)
                             VALUES (v_secuencia    , V_ERROR    , V_CADENA);
END;
/
SHOW ERRORS
