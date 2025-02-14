CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_FECHAANULBAJA (
-- Valida si por fecha puede efectuar la anulacion de la baja.
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------
	 vACTABO     GA_ACTABO.COD_ACTABO%TYPE;
     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
	 nCODCLIENTE GA_ABOCEL.COD_CLIENTE%TYPE;


------------------------------------------------



	 vFechaActual   		VARCHAR2(10):= '0';
	 vRowid					VARCHAR2(18) := '0';
	 vNumDiasLiq    		ga_datosgener.num_diasliq%TYPE;
	 vNumDiasReutil 		ga_datosgener.num_diasreutil%TYPE;
	 vIndSituacion  		ge_clientes.cod_cliente%TYPE;



BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 nCODCLIENTE    := TO_NUMBER(string(6));
     nABONADO 		:= TO_NUMBER(string(5));
     vACTABO  		:= string(4);

     bRESULTADO := 'TRUE';

	 SELECT NUM_DIASLIQ
	 INTO   vNumDiasLiq
	 FROM   GA_DATOSGENER;

	 SELECT NUM_DIASREUTIL
	 INTO   vNumDiasReutil
	 FROM   GA_DATOSGENER;


	 IF (vNumDiasReutil <> '') AND (vNumDiasLiq <> '') THEN


		SELECT IND_SITUACION
		INTO   vIndSituacion
		FROM   GE_CLIENTES
		WHERE  COD_CLIENTE = nCODCLIENTE;

		IF vIndSituacion = 'CF' THEN
		 	SELECT ROWID
			INTO   vRowid
			FROM   GA_ABOCEL
			WHERE  NUM_ABONADO = nABONADO
			AND    FEC_BAJA + vNumDiasLiq >= TO_DATE (SYSDATE, 'DD-MM-YYYY');
		ELSE
		 	SELECT ROWID
			INTO   vRowid
			FROM   GA_ABOCEL
			WHERE  NUM_ABONADO = nABONADO
			AND    FEC_BAJA + vNumDiasReutil >= TO_DATE (SYSDATE, 'DD-MM-YYYY');
		END IF;


		IF (vRowid = '') THEN
		   IF vIndSituacion = 'CF' THEN
   	           bRESULTADO := 'FALSE';
			   vMENSAJE   := 'EL ABONADO HA SOBREPASADO LOS ' || vNumDiasLiq || ' DIAS PARA EFECTUAR LA ANULACION DE LA BAJA';
		   ELSE
   	           bRESULTADO := 'FALSE';
			   vMENSAJE   := 'EL ABONADO HA SOBREPASADO LOS ' || vNumDiasReutil || ' DIAS PARA EFECTUAR LA ANULACION DE LA BAJA';
		   END IF;

		END IF;

	END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_FECHAANULBAJA: NO SE PUEDE VALIDAR PLAN TARIFARIO DEL ABONADO.';


END;
/
SHOW ERRORS
