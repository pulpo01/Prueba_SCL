CREATE OR REPLACE PROCEDURE Pv_Pr_Rehasuspension(
    nNUM_ABONADO  	IN NUMBER,		-- Número de Abonado
	vNOM_USUARORA  	IN VARCHAR2,	-- Usuario Responsable
	nCOD_ERROR		OUT NOCOPY NUMBER,		-- Código de Error --XO-200509030583: German Espinoza Z; 16/09/2005
	sMEN_ERROR		OUT NOCOPY VARCHAR2	-- Mensaje de Error        --XO-200509030583: German Espinoza Z; 16/09/2005

)
IS


	nNumError			NUMBER (2);   -- número de error
	sMsgError			VARCHAR(55);  -- mensaje de error
	bCargoBasico		BOOLEAN;	  -- flag para conocer si se procedera a cambiar cargo básico


	scodSituacion		GA_ABOCEL.COD_SITUACION%TYPE;

	vCiclo              GA_ABOCEL.COD_CICLO%TYPE;
	vCliente            GA_ABOCEL.COD_CLIENTE%TYPE;
	vNumCelular			GA_ABOCEL.NUM_CELULAR%TYPE;
	vCodCentral			GA_ABOCEL.COD_CENTRAL%TYPE;
	vTipTerminal        GA_ABOCEL.TIP_TERMINAL%TYPE;
	vNumSerieHex		GA_ABOCEL.NUM_SERIEHEX%TYPE;
	vIndPlexys 			GA_ABOCEL.IND_PLEXSYS%TYPE;
	vCodCentralPlex		GA_ABOCEL.COD_CENTRAL_PLEX%TYPE;
	vNumCelularPlex     GA_ABOCEL.NUM_CELULAR_PLEX%TYPE;
	vCodCargoBasico		GA_ABOCEL.COD_CARGOBASICO%TYPE;
	vCodProducto		GA_ABOCEL.COD_PRODUCTO%TYPE;
	vCodSusPreha		GA_CAUSUSP.COD_SUSPREHA%TYPE;
	vImpCargo_Abonado	TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
	vImpCargo_Causa		TA_CARGOSBASICO.IMP_CARGOBASICO%TYPE;
	vFecSys				DATE;
	nCodCaususpen		GA_CAUSINIE.COD_CAUSUSP%TYPE;
	vCodServicio		GA_SUSPREHABO.COD_SERVICIO%TYPE;
	sNumPeticion 		GA_PETSR.NUM_PETICION%TYPE;
    vTecnologia         GA_ABOCEL.COD_TECNOLOGIA%TYPE;
    vImei               ICC_MOVIMIENTO.IMEI%TYPE;
    vIcc                ICC_MOVIMIENTO.ICC%TYPE;
	vImsi               ICC_MOVIMIENTO.IMSI%TYPE;
	v_tecnologia_gsm    GA_ABOCEL.COD_TECNOLOGIA%TYPE;
-- Variables de salida para P_Cargo_Basico

	V_ERROR 			VARCHAR2(1) := '0';

	ERROR_PROCESO EXCEPTION;

	sNOM_TABLA 	 GA_ERRORES.NOM_TABLA%TYPE;
	sNOM_PROC	 GA_ERRORES.NOM_PROC%TYPE;
	sCOD_ACT	 GA_ERRORES.COD_ACT%TYPE;
	sCOD_SQLCODE GA_ERRORES.COD_SQLCODE%TYPE;
	sCOD_SQLERRM GA_ERRORES.COD_SQLERRM%TYPE;
	sERROR		 VARCHAR2(2);

    nSeq_NumMov NUMBER(10);
	sNumTrans VARCHAR2(5);
	vPrefijoCel VARCHAR(5);
	vNumMin VARCHAR(3);
	vActCentral VARCHAR(5);
	vCodActabo VARCHAR(5);



BEGIN
	 vCodProducto := 1;
	 vCodActabo := 'CB';
	 -- Inicialización de Variables
	 nNumError:=0;
	 sMsgError:='Operacion Exitosa';
	 bCargoBasico:=TRUE;
	 vFecSys:=SYSDATE;
	 sNOM_PROC:='PV_PR_REHASUSPENSION';



     SELECT val_parametro INTO v_tecnologia_gsm
     FROM ged_parametros
     WHERE nom_parametro = 'TECNOLOGIA_GSM';


	 BEGIN
  	   	   -- Selección de Datos del Abonado Suspendido
 	  	   nNumError := 1;
 	   	   sMsgError := 'Error, al seleccionar desde GA_ABOCEL';
 	   	   sNOM_TABLA:='GA_ABOCEL';
 	   	   sCOD_ACT:='S';

		   SELECT NUM_CELULAR, COD_CENTRAL,TIP_TERMINAL, NUM_SERIEHEX,
		   		  IND_PLEXSYS, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX, COD_CLIENTE, COD_CICLO, COD_TECNOLOGIA,
				  NUM_SERIE, NUM_IMEI
		   INTO vNumCelular, vCodCentral, vTipTerminal, vNumSerieHex,
		   		vIndPlexys, vCodCentralPlex, vNumCelularPlex, vCliente, vCiclo, vTecnologia,
				vIcc, vImei
		   FROM GA_ABOCEL
		   WHERE NUM_ABONADO =nNUM_ABONADO;

   	 EXCEPTION
	 	   WHEN NO_DATA_FOUND THEN
		   BEGIN

   	   			 -- Selección de Datos del Abonado Suspendido
  	   			 	nNumError := 2;
   	   				sMsgError := 'Error, al seleccionar desde GA_ABOAMIST';
   	   				sNOM_TABLA:='GA_ABOAMIST';
   	   				sCOD_ACT:='S';

				   SELECT NUM_CELULAR, COD_CENTRAL,TIP_TERMINAL, NUM_SERIEHEX,
				   		  IND_PLEXSYS, COD_CENTRAL_PLEX, NUM_CELULAR_PLEX, COD_CLIENTE, COD_CICLO, COD_TECNOLOGIA,
						  NUM_SERIE, NUM_IMEI
				   INTO vNumCelular, vCodCentral, vTipTerminal, vNumSerieHex,
				   		vIndPlexys, vCodCentralPlex, vNumCelularPlex, vCliente, vCiclo, vTecnologia,
						vIcc, vImei
				   FROM GA_ABOAMIST
				   WHERE NUM_ABONADO = nNUM_ABONADO;

			EXCEPTION
					 WHEN OTHERS THEN
					 	  RAISE ERROR_PROCESO;
            END;
	 END;


	 BEGIN
		  nNumError := 3;
		  sMsgError := 'Error, al Ejecutar PL Cargo Básico';
		  sNOM_TABLA:='GA_INTARCEL';
		  sCOD_ACT:='S';

		  sNOM_PROC :='Pv_Pr_Rehasuspension';

          P_Cargo_Basico(vCodProducto,vCliente,TO_NUMBER(nNUM_ABONADO),vCodCargoBasico,vCiclo,
                         vFecSys,'R',sNOM_PROC,sNOM_TABLA,sCOD_ACT,sCOD_SQLCODE,
                         sCOD_SQLERRM,V_ERROR);


  	 EXCEPTION
	 	WHEN OTHERS THEN
			 RAISE ERROR_PROCESO;
	 END;


	 BEGIN

	 	 nNumError := 4;
	  	sMsgError  := 'Error, al obtener Num. Petición, GA_PETSR ';
	  	sNOM_TABLA := 'GA_PETSR';
	  	sCOD_ACT := 'S';

		SELECT B.NUM_PETICION
		INTO sNumPeticion
		FROM GA_ABOCEL A, GA_PETSR B
		WHERE A.NUM_ABONADO = B.NUM_ABONADO
		AND A.COD_SITUACION = 'SAA'
		AND A.NUM_ABONADO = nNUM_ABONADO
		--XO-200509030583: German Espinoza Z; 16/09/2005
		UNION
		SELECT B.NUM_PETICION
		FROM GA_ABOAMIST A, GA_PETSR B
		WHERE A.NUM_ABONADO = B.NUM_ABONADO
		AND A.COD_SITUACION IN ('SAA','STP')
		AND A.NUM_ABONADO = nNUM_ABONADO;
		--FIN/XO-200509030583: German Espinoza Z; 16/09/2005

		 nNumError := 5;
		 sMsgError := 'Error al Eliminar datos en GA_PETSR';
		 sNOM_TABLA:='GA_PETSR';
		 sCOD_ACT:='D';

		 DELETE GA_PETSR WHERE NUM_PETICION = sNumPeticion;

	 EXCEPTION
	 	WHEN OTHERS THEN
			 RAISE ERROR_PROCESO;

	 END;


     BEGIN
	  	-- Actualizacion GA_ABOCEL
   	  	nNumError := 6;
	  	sMsgError := 'Error, al Actualizar GA_ABOCEL';
	  	sNOM_TABLA:='GA_ABOCEL';
	  	sCOD_ACT:='U';
		scodSituacion := 'RTP';

		UPDATE GA_ABOCEL
		SET COD_SITUACION = sCodSituacion,
		    FEC_ULTMOD = SYSDATE
		WHERE NUM_ABONADO = nNUM_ABONADO;

		--XO-200509030583: German Espinoza Z; 16/09/2005
		-- Actualizacion GA_ABOAMIST
   	  	nNumError := 6;
	  	sMsgError := 'Error, al Actualizar GA_ABOAMIT';
	  	sNOM_TABLA:='GA_ABOAMIST';
	  	sCOD_ACT:='U';
		scodSituacion := 'RTP';

		UPDATE GA_ABOAMIST
		SET COD_SITUACION = sCodSituacion,
		    FEC_ULTMOD = SYSDATE
		WHERE NUM_ABONADO = nNUM_ABONADO;
		--FIN/XO-200509030583: German Espinoza Z; 16/09/2005

	EXCEPTION
	  	WHEN OTHERS THEN
			 RAISE ERROR_PROCESO;
	END;


    BEGIN
		  	-- Actualizacion GA_SUSPREHABO
    	  	nNumError := 7;
		  	sMsgError := 'Error, al Actualizar GA_SUSPREHABO';
		  	sNOM_TABLA:='GA_SUSPREHABO';
		  	sCOD_ACT:='U';

			UPDATE GA_SUSPREHABO
			SET FEC_REHABD = SYSDATE,
				TIP_REGISTRO = 3
			WHERE NUM_ABONADO = nNUM_ABONADO
   		    AND COD_MODULO = 'GA'
			AND TIP_REGISTRO = 2
			AND COD_SERVSUPL IS NULL
			AND COD_NIVEL    IS NULL
			AND FEC_REHABD   IS NULL;

	EXCEPTION
	  	WHEN OTHERS THEN
		 bCargoBasico:=FALSE;
	END;


 	sNOM_PROC:='Pv_Pr_Rehasuspension';


	BEGIN

 	   	 nNumError := 8;
	   	 sMsgError := 'Error, al obtener secuencia ICC_SEQ_NUMMOV';
	   	 sNOM_TABLA:='ICC_SEQ_NUMMOV';
	   	 sCOD_ACT:='S';

		 SELECT ICC_SEQ_NUMMOV.NEXTVAL
		 INTO  nSeq_NumMov
		 FROM DUAL;

 	   	 nNumError := 9;
	   	 sMsgError := 'Error, al Obtener COD_ACTUACION ';
	   	 sNOM_TABLA:='GA_ACTABO';
	   	 sCOD_ACT:='S';

		 SELECT COD_ACTCEN
		 INTO vActCentral
		 FROM GA_ACTABO
		 WHERE COD_ACTABO = 'RT' AND COD_PRODUCTO=vCodProducto
		 AND COD_TECNOLOGIA = vTecnologia
		 AND COD_MODULO = 'GA';

 	   	 nNumError := 10;
	   	 sMsgError := 'Error, al obtener Prefijo';
	   	 sNOM_TABLA:='AL_FN_PREFIJO_NUMERO';
	   	 sCOD_ACT:='S';

		 SELECT AL_FN_PREFIJO_NUMERO(vNumCelular)
		 INTO vPrefijoCel
		 FROM DUAL;

 	   	 nNumError := 11;
	   	 sMsgError := 'Error, al obtener COD_SERVICIO';
	   	 sNOM_TABLA:='GA_SUSPREHABO';
	   	 sCOD_ACT:='S';

		 SELECT COD_SERVICIO
		 INTO vCodServicio
		 FROM GA_SUSPREHABO
		 WHERE NUM_ABONADO=nNUM_ABONADO
		 AND COD_MODULO = 'GA'
 		 AND TIP_REGISTRO = 3
 		 AND COD_SERVSUPL IS NULL
 		 AND COD_NIVEL    IS NULL;

  	   	 nNumError := 12;
	   	 sMsgError := 'Error, al Generar Movimiento';
	   	 sNOM_TABLA:='ICC_MOVIMIENTO';
	   	 sCOD_ACT:='I';


        IF vTecnologia = v_tecnologia_gsm THEN
	    -- recuperar imsi de la simcard

			SELECT FRECUPERSIMCARD_FN(vIcc, 'IMSI')
			INTO vImsi
			FROM DUAL;

            INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO,
		 		    				 COD_ACTABO, COD_MODULO, COD_ACTUACION,
									 NOM_USUARORA,FEC_INGRESO, TIP_TERMINAL,
									 COD_CENTRAL, NUM_CELULAR, NUM_SERIE,
									 COD_SUSPREHA, COD_SERVICIOS, NUM_MIN,
									 STA, IMEI, ICC, IMSI, TIP_TECNOLOGIA)
							  VALUES (nseq_nummov, nNUM_ABONADO, '1',
							  		  'RT','GA', vActCentral,
									  vNOM_USUARORA, SYSDATE, vTipTerminal,
									  vCodCentral, vNumCelular, vIcc,
									  vCodServicio,'', vPrefijoCel,
									  'A', vImei, vIcc, vImsi, vTecnologia);
		ELSE
            INSERT INTO ICC_MOVIMIENTO (NUM_MOVIMIENTO, NUM_ABONADO, COD_ESTADO,
		 		    				 COD_ACTABO, COD_MODULO, COD_ACTUACION,
									 NOM_USUARORA,FEC_INGRESO, TIP_TERMINAL,
									 COD_CENTRAL, NUM_CELULAR, NUM_SERIE,
									 COD_SUSPREHA, COD_SERVICIOS, NUM_MIN,
									 STA, TIP_TECNOLOGIA)
							  VALUES (nseq_nummov, nNUM_ABONADO, '1',
							  		  'RT','GA', vActCentral,
									  vNOM_USUARORA, SYSDATE, vTipTerminal,
									  vCodCentral, vNumCelular, vNumSerieHex,
									  vCodServicio,'', vPrefijoCel,
									  'A', vTecnologia);
		END IF;

	EXCEPTION
	  	WHEN OTHERS THEN
			 RAISE ERROR_PROCESO;
	END;

  	nCOD_ERROR:=0;
	sMEN_ERROR:='Operacion Exitosa';


EXCEPTION

	WHEN ERROR_PROCESO THEN

		  sCOD_SQLCODE:=SQLCODE;
		  sCOD_SQLERRM:=SQLERRM;

		  nCOD_ERROR:=nNumError;
		  sMEN_ERROR:=sMsgError;

END;
/
SHOW ERRORS
