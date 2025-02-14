CREATE OR REPLACE PROCEDURE PV_CAMBIOPLAN_SCL_PR( pCelular    IN NUMBER,
	   	  		  								  pPlanOrigen IN VARCHAR2,
	   	  		  								  pPlanNuevo  IN VARCHAR2,
												  pFecCambio  IN VARCHAR2,
												  pIndCentral IN NUMBER,
												  pCarga	  IN NUMBER,
												  pError     OUT NUMBER,
												  pMsgError  OUT VARCHAR2
												 )
IS

  nAbonado         GA_ABOCEL.NUM_ABONADO%TYPE;
  vCodCliente      GA_ABOCEL.COD_CLIENTE%TYPE;
  vNumCelular      GA_ABOCEL.NUM_CELULAR%TYPE;
  vCodTipContrato  GA_ABOCEL.COD_TIPCONTRATO%TYPE;
  vIndEqPrestado   GA_ABOCEL.IND_EQPRESTADO%TYPE;
  vNumSerie        GA_ABOCEL.NUM_SERIE%TYPE;
  vUso             GA_ABOCEL.COD_USO%TYPE;
  vCodTecnologia   GA_ABOCEL.COD_TECNOLOGIA%TYPE;
  vCodCentral	   GA_ABOCEL.COD_CENTRAL%TYPE;
  vTipTerminal	   GA_ABOCEL.TIP_TERMINAL%TYPE;
  vNumImei		   GA_ABOCEL.NUM_IMEI%TYPE;

  sCodActAbo	   GA_ACTABO.COD_ACTABO%TYPE;
  sAuxCodActabo	   GA_ACTABO.COD_ACTABO%TYPE;
  sCodPlanServ1    GA_PLANTECPLSERV.COD_PLANSERV%TYPE;
  sCodPlanServ2    GA_PLANTECPLSERV.COD_PLANSERV%TYPE;
  nCodActuacion	   ICC_MOVIMIENTO.COD_ACTUACION%TYPE;
  sNUMIMSI		   ICC_MOVIMIENTO.IMSI%TYPE:=NULL;

  sCodTiplan	   TA_PLANTARIF.COD_TIPLAN%TYPE;
  vTipPlanPrepago  GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  sCodTecnologia   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  v_Formato_Sel2   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  v_Formato_Sel7   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  v_Formato_Sel19   GED_PARAMETROS.VAL_PARAMETRO%TYPE;
  vFecSys		   DATE;
  vFecCamb		   DATE;

  vCodPlanOri      GA_ABOCEL.COD_PLANTARIF%TYPE;
  vCodPlanDes 	   GA_ABOCEL.COD_PLANTARIF%TYPE;

  sNumMov		   ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;
  vNumTransaccion  GA_TRANSACABO.NUM_TRANSACCION%TYPE;
  sNumMin		   ICC_MOVIMIENTO.NUM_MIN%TYPE;
  v_IMSI		   ICC_MOVIMIENTO.IMSI%TYPE;
  v_IMEI           ICC_MOVIMIENTO.IMEI%TYPE;
  v_ICC			   ICC_MOVIMIENTO.ICC%TYPE;


  ERROR_PROCESO EXCEPTION;

  vCodRetorno	   GA_TRANSACABO.COD_RETORNO%TYPE;
  nNumErrorPl	   NUMBER(2);
  sMsgErrorPl	   VARCHAR2(200);

  nNumError		   NUMBER(2);
  sMsgError		   VARCHAR2(200);
  sNOM_TABLA	   GA_ERRORES.NOM_TABLA%TYPE;
  sNOM_PROC        GA_ERRORES.NOM_PROC%TYPE;
  sCOD_ACT         GA_ERRORES.COD_ACT%TYPE;
  sCOD_SQLCODE     VARCHAR2(30);
  sCOD_SQLERRM	   VARCHAR2(200);
  sERROR           VARCHAR2(2);

BEGIN

	-- pIndCentral -> Indicador de Central
	-- 1 va a Central(Icc_Movimiento)
	-- 0 NO va a Central(Icc_Movimiento)

	-- Inicializacion de Variables

	v_Formato_Sel2 :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL2');
	v_Formato_Sel7 :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL7');
	v_Formato_Sel19 :=GE_PAC_GENERAL.PARAM_GENERAL('FORMATO_SEL19');

	sCodActAbo := 'C7';
	nNumError  :=0;
	sMsgError  :='Inicio Operacion';
	vFecSys    :=SYSDATE;

	vFecCamb   := to_date(pFecCambio,v_Formato_Sel19 || ' ' || v_Formato_Sel7);
	vFecCamb   := to_date(to_char(vFecCamb,v_Formato_Sel2  || ' ' || v_Formato_Sel7),v_Formato_Sel2  || ' ' || v_Formato_Sel7);

	sNOM_PROC  :='PV_CAMBIOPLAN_SCL_PR';

    --Grupo GSM
   -- INI TMM_04026
	sCodTecnologia := GE_FN_DEVVALPARAM('GA',1,'GRUPO_TEC_GSM');
	-- FIN TMM_04026


              BEGIN
                 nNumError := 1;
                 sMsgError := 'Error, al seleccionar desde GA_ABOAMIST';
                 sNOM_TABLA:='GA_ABOAMIST';
                 sCOD_ACT:='S';

				 --TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.
				 --si no va a centrales no se restringe por la situacion del abonado
		         if pIndCentral=0 then
		         SELECT NUM_ABONADO,COD_CLIENTE,NUM_CELULAR,COD_TIPCONTRATO,COD_USO,
				        NUM_SERIE,COD_TECNOLOGIA,COD_CENTRAL,TIP_TERMINAL,NUM_IMEI,COD_PLANSERV
		           INTO nAbonado,vCodCliente,vNumCelular,vCodTipContrato,vUso,
				        vNumSerie,vCodTecnologia,vCodCentral,vTipTerminal,vNumImei,sCodPlanServ1
		           FROM GA_ABOAMIST
			          WHERE NUM_CELULAR = pCelular;
				else
					SELECT NUM_ABONADO,COD_CLIENTE,NUM_CELULAR,COD_TIPCONTRATO,COD_USO,
					        NUM_SERIE,COD_TECNOLOGIA,COD_CENTRAL,TIP_TERMINAL,NUM_IMEI,COD_PLANSERV
			          INTO nAbonado,vCodCliente,vNumCelular,vCodTipContrato,vUso,
					        vNumSerie,vCodTecnologia,vCodCentral,vTipTerminal,vNumImei,sCodPlanServ1
			          FROM GA_ABOAMIST
		          WHERE NUM_CELULAR = pCelular
				    AND COD_SITUACION = 'AAA';
				end if;
				--FIN TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.

              EXCEPTION
                  WHEN OTHERS THEN
                       RAISE ERROR_PROCESO;
              END;
	 --TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.
	 --END;
	 --FIN TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.

	-- VERIFICAMOS QUE EL PLAN DEL ABONADO EXISTA EN SCL
	BEGIN

		nNumError:=2;
		sMsgError:='No es Plan Prepago';
        sNOM_TABLA:='TA_PLANTARIF';
        sCOD_ACT:='S';

		SELECT COD_PLANTARIF,COD_TIPLAN
		  INTO vCodPlanOri,sCodTiplan
		  FROM TA_PLANTARIF
		 --WHERE COD_PLAN_COMVERSE = pPlanOrigen;
		 WHERE COD_PLANTARIF = pPlanOrigen;

		nNumError:=21;
		sMsgError:='No es Plan Prepago';
        sNOM_TABLA:='TA_PLANTARIF';
        sCOD_ACT:='S';


		SELECT COD_PLANTARIF
		  INTO vCodPlanDes
		  FROM TA_PLANTARIF
		 --WHERE COD_PLAN_COMVERSE = pPlanNuevo
 		 WHERE COD_PLANTARIF = pPlanNuevo;




	EXCEPTION
	    WHEN OTHERS THEN
		     RAISE ERROR_PROCESO;

	END;

	BEGIN

        nNumError := 22;
        sMsgError := 'El plan destino es el mismo que el origen';
        sNOM_TABLA:='';
        sCOD_ACT:='S';

		IF vCodPlanDes = vCodPlanOri THEN
		   RAISE ERROR_PROCESO;
		END IF;
	END;


	-- CAMBIAMOS LA SITUACION DEL ABONADO.
	BEGIN

		--TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.
		--solo si la orden va a centrales se cambia la situacion del abonado

		sNOM_TABLA:='GA_ABOAMIST';
	    sCOD_ACT:='U';

        if pIndCentral=1 then
        nNumError := 3;
        sMsgError := 'Error, al cambiar la situacion del abonado';

		UPDATE GA_ABOAMIST SET
	   		   COD_SITUACION = 'CPP',
	   		   FEC_ULTMOD = vFecCamb --SYSDATE
	     WHERE NUM_ABONADO = nAbonado;
		else
			nNumError := 31;
	        sMsgError := 'Error, al cambiar la fecha de modificacion';

			UPDATE GA_ABOAMIST SET
		   		   FEC_ULTMOD = vFecCamb --SYSDATE
		     WHERE NUM_ABONADO = nAbonado;
		end if;
		--FIN TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.

	EXCEPTION
	    WHEN OTHERS THEN
		     RAISE ERROR_PROCESO;

	END;


	-- TRASPASOS DE LOS SERVICIOS SUPLEMENTARIOS.

	BEGIN

	    nNumError := 4;
	    sMsgError := 'Error, al cambiar la situacion del abonado';
	    sNOM_TABLA:='PV_SSGENERA_SCL_PR';
	    sCOD_ACT:='P';


		PV_SSGENERA_SCL_PR( nAbonado, pCelular, vCodPlanOri, vCodPlanDes, vCodCentral,
							vCodTecnologia, vTipTerminal, vNumSerie, vNumImei, pIndCentral, vFecCamb,
							nNumErrorPl, sMsgErrorPl);

		IF nNumErrorPl <> 0 THEN
		   sNOM_TABLA:= sMsgErrorPl;
		   RAISE ERROR_PROCESO;
		END IF;

	END;

	-- BORRA LOS FRECUENTES DEL ABONADO
	BEGIN

        nNumError := 41;
        sMsgError := 'Error, al Borrar los Frecuentes del Abonado';
        sNOM_TABLA:='PPT_NUMEROFRECUENTE';
        sCOD_ACT:='D';

  		DELETE PPT_NUMEROFRECUENTE
  		 WHERE NUM_ABONADO = nAbonado;



	EXCEPTION
	    WHEN OTHERS THEN
		     RAISE ERROR_PROCESO;

	END;

	-- INSERTA EN LA GA_MODABOCEL
	BEGIN

        nNumError := 5;
        sMsgError := 'Error, al Insertar cambio del Abonado';
        sNOM_TABLA:='GA_MODABOCEL';
        sCOD_ACT:='I';

	    INSERT INTO  GA_MODABOCEL (NUM_ABONADO, FEC_MODIFICA, NOM_USUARORA, NUM_CELULAR, COD_PLANTARIF,COD_TIPMODI)
			   		 	  VALUES  (nAbonado,vFecCamb,user,vNumCelular,vCodPlanOri,sCodActAbo);



	EXCEPTION
	    WHEN OTHERS THEN
		     RAISE ERROR_PROCESO;

	END;


	BEGIN

		BEGIN

		    nNumError := 6;
		    sMsgError := 'Error, No se reconose plan de servicio';
		    sNOM_TABLA:='GA_PLANTECPLSERV';
		    sCOD_ACT:='S';

			SELECT COD_PLANSERV
			  INTO sCodPlanServ2
			  FROM GA_PLANTECPLSERV
	   		 WHERE COD_PRODUCTO = 1
	   		   AND COD_TECNOLOGIA = vCodTecnologia
	   		   AND COD_PLANTARIF = vCodPlanDes
	   		   AND SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA,SYSDATE);

		EXCEPTION
		    WHEN OTHERS THEN
		         RAISE ERROR_PROCESO;
	    END;

		IF sCodPlanServ1 <> sCodPlanServ2 THEN
		     --TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.
			 /* se comenta este codigo ya que el proceso almacenado PV_CAMBIOPLANSERV_PREPAGO
			    realiza un insert a la ga_intarcel, lo que no debe ser para los prepagos

			 SELECT GA_SEQ_TRANSACABO.NEXTVAL
			   INTO vNumTransaccion
			   FROM DUAL;

	      -- INI TMM_04026
	      --IF vCodTecnologia = sCodTecnologia  THEN
	      IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(vCodTecnologia) = sCodTecnologia  THEN
			-- FIN TMM_04026
			   SELECT FN_RECUPERA_IMSI(vNumSerie)
			     INTO sNUMIMSI
	    		 FROM DUAL;
			END IF;

			PV_CAMBIOPLANSERV_PREPAGO(vNumTransaccion,'CS',1,nAbonado,vCodCliente,sCodPlanServ2,sNUMIMSI);

			SELECT COD_RETORNO
			  INTO vCodRetorno
			  FROM GA_TRANSACABO
			 WHERE NUM_TRANSACCION = vNumTransaccion;

			IF vCodRetorno <> 0 THEN
			   nNumError := 7;
			   sMsgError := 'Error, al ejecutar plan de servicio';
			   sNOM_TABLA:='PV_CAMBIOPLANSERV_PREPAGO';
			   sCOD_ACT:='P';
			   RAISE ERROR_PROCESO;
			END IF;

			se saca el siguiente update del procedimiento PV_CAMBIOPLANSERV_PREPAGO, ya que este si debe realizarse
			*/
			nNumError := 7;
		    sMsgError := 'Error, Al Cambiar el plan de servicio';
		    sNOM_TABLA:='GA_ABOAMIST';
		    sCOD_ACT:='S';

			UPDATE GA_ABOAMIST
                 SET    COD_PLANSERV=sCodPlanServ2
                 WHERE  NUM_ABONADO = nAbonado;

			--FIN TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.

		END IF;

	EXCEPTION
	    WHEN OTHERS THEN
		     RAISE ERROR_PROCESO;

	END;


	IF pIndCentral = 1 THEN

	   nNumError := 81;
	   sMsgError := 'Error, Al buscar el codigo de actuacion';
	   sNOM_TABLA:='PV_ACTABO_TIPLAN';
	   sCOD_ACT:='S';
	   SELECT COD_ACTABO
	     INTO sAuxCodActabo
	     FROM PV_ACTABO_TIPLAN
   	    WHERE COD_TIPMODI = sCodActAbo
   		  AND COD_TIPLAN  = sCodTiplan;

		nNumError :=82;
		sMsgError:='No existe una actuacion de centrales';
		sNOM_TABLA:='FN_CODACTCEN';
	    sCOD_ACT  :='F';

		SELECT FN_CODACTCEN (1,sAuxCodActabo,'GA',vCodTecnologia)
		  INTO nCodActuacion
		  FROM DUAL;


		--INI TMM_04026
		IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(vCodTecnologia) = sCodTecnologia  THEN
		-- FIN TMM_04026
		   nNumError := 83;
		   sMsgError := 'Error, Al recuperar el numero de IMSI';
		   sNOM_TABLA:='FN_RECUPERA_IMSI';
		   sCOD_ACT  :='F';
		   SELECT FN_RECUPERA_IMSI(vNumSerie)
		     INTO sNUMIMSI
    		 FROM DUAL;
		END IF;

		-- Para GSM
		-- INI TMM_04026
		IF GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN(vCodTecnologia) = sCodTecnologia  THEN
		-- FIN TMM_04026
		   nNumError := 84;
		   sMsgError := 'Error, Al recuperar el numero de IMSI';
		   sNOM_TABLA:='FN_RECUPERA_IMSI';
		   sCOD_ACT  :='F';
		   SELECT FN_RECUPERA_IMSI(vNumSerie)
		     INTO v_IMSI
    		 FROM DUAL;
		   v_IMEI := vNumImei;
		   v_ICC  := vNumSerie;
		ELSE
		  v_IMSI := NULL;
		  v_IMEI := NULL;
		  v_ICC	 := NULL;
		END IF;

		nNumError := 9;
		sMsgError := 'Error, Al recuperar el numero de movimiento';
		sNOM_TABLA:='ICC_SEQ_NUMMOV.NEXTVAL';
		sCOD_ACT:='S';

		SELECT ICC_SEQ_NUMMOV.NEXTVAL
		  INTO sNumMov
		  FROM DUAL;

		nNumError := 10;
		sMsgError := 'No Exite Prefijo de Numero';
		sNOM_TABLA:='AL_FN_PREFIJO_NUMERO';
		sCOD_ACT  :='F';

		SELECT AL_FN_PREFIJO_NUMERO(pCelular)
		  INTO sNumMin
		  FROM DUAL;


	    nNumError := 11;
		sMsgError := 'Error, Insert ICC_MOVIMIENTO';
	    sNOM_TABLA:='ICC_MOVIMIENTO';
	    sCOD_ACT:='I';

    	INSERT INTO  ICC_MOVIMIENTO (NUM_MOVIMIENTO , NUM_ABONADO     , COD_ESTADO      , COD_ACTABO    , COD_MODULO  ,
			   		 				 COD_ACTUACION  , NOM_USUARORA    ,
									 FEC_INGRESO    , TIP_TERMINAL    , COD_CENTRAL     ,
    								 NUM_CELULAR    , NUM_SERIE       , NUM_MIN		 ,
									 PLAN           , CARGA			  ,
									 TIP_TECNOLOGIA , IMSI            , IMEI          , ICC)
		  					 VALUES (sNumMov		, nAbonado		  , 1			  ,sCodActAbo	 , 'GA',
							 		 nCodActuacion  , USER			  ,
									 SYSDATE		, vTipTerminal	  , vCodCentral   ,
									 pCelular		, vNumSerie		  , sNumMin		  ,
									 vCodPlanDes	, pCarga		  ,
									 vCodTecnologia	, v_IMSI 		  , v_IMEI 		 ,v_ICC);


	ELSE

		-- CAMBIAMOS LA SITUACION DEL ABONADO.
		BEGIN

	        nNumError := 13;
	        sMsgError := 'Error, al cambiar la situacion del abonado';
	        sNOM_TABLA:='GA_ABOAMIST';
	        sCOD_ACT:='U';
			--TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.
			--se saca del update el cod_situacion='AAA'

			UPDATE GA_ABOAMIST SET
				   COD_PLANTARIF = vCodPlanDes
		     WHERE NUM_ABONADO = nAbonado;
			 --FIN TM-200403100557, German Espinoza Z. 16/03/2004 16:10 hrs.

		EXCEPTION
		    WHEN OTHERS THEN
			     RAISE ERROR_PROCESO;

		END;

	END IF;

    nNumError := 0;
    sMsgError := 'Fin del Proceso';

	RAISE ERROR_PROCESO;


EXCEPTION

    WHEN ERROR_PROCESO THEN

		 IF nNumError > 0 THEN

	         sCOD_SQLCODE:=substr(to_char(SQLCODE), 1, 15);
	         sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);

	         ROLLBACK;

	         INSERT INTO GA_ERRORES(COD_ACTABO,CODIGO,FEC_ERROR,COD_PRODUCTO,NOM_PROC,
	         NOM_TABLA,COD_ACT,COD_SQLCODE,COD_SQLERRM)
	         VALUES(sCodActAbo,nAbonado,SYSDATE,1,sNOM_PROC,sNOM_TABLA,sCOD_ACT,
	         sCOD_SQLCODE,sCOD_SQLERRM);

	         COMMIT;

		 END IF;

         pError:=nNumError;
         pMsgError:=sMsgError;

	WHEN OTHERS THEN

         sCOD_SQLCODE:=substr(to_char(SQLCODE), 1, 15);
         sCOD_SQLERRM:=SUBSTR(SQLERRM,1,60);

         ROLLBACK;

         pError:=nNumError;
         pMsgError:='ERROR INESPERADO';

END;
/
SHOW ERRORS
