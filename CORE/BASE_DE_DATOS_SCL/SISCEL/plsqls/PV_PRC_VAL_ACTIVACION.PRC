CREATE OR REPLACE PROCEDURE PV_PRC_VAL_ACTIVACION (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada -----------------------

     nABONADO              GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     		   GA_ACTABO.COD_ACTABO%TYPE;
	 vPlantarif  		   GA_ABOCEL.COD_PLANTARIF%TYPE;
     vTiplan     		   TA_PLANTARIF.COD_TIPLAN%TYPE;
	 dFecActivacion		   GA_ABOCEL.FEC_ACTIVACION%TYPE;
---------------------------------------------------------

     vCantidad NUMBER(2) := 0;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));

     bRESULTADO := 'TRUE';

	 BEGIN
			 SELECT COD_PLANTARIF
			 INTO vPlantarif
			 FROM GA_ABOCEL
			 WHERE NUM_ABONADO = nABONADO;

			 EXCEPTION
			 WHEN NO_DATA_FOUND THEN
			      SELECT COD_PLANTARIF
			 	  INTO vPlantarif
				  FROM GA_ABOAMIST
			 	  WHERE NUM_ABONADO = nABONADO;
	 END;

	 SELECT COD_TIPLAN
	 INTO vTiplan
	 FROM TA_PLANTARIF
	 WHERE COD_PLANTARIF = vPlantarif;


	 IF GE_FN_DEVVALPARAM('GA', 1, 'TIPOHIBRIDO') = vTiplan THEN

		SELECT FEC_ACTIVACION
		INTO dFecActivacion
		FROM   GA_ABOCEL A
		WHERE  A.NUM_ABONADO    = nABONADO;

		IF dFecActivacion IS NULL THEN
		   bRESULTADO := 'FALSE';
           vMENSAJE   := 'ABONADO NO ESTA ACTIVADO, NO PUEDE OPERAR ESTA OOSS';
		END IF;


	 END IF;


	 IF GE_FN_DEVVALPARAM('GA', 1, 'TIPOPREPAGO') = vTiplan THEN

		SELECT FEC_ACTIVACION
		INTO dFecActivacion
		FROM   GA_ABOAMIST A
		WHERE  A.NUM_ABONADO    = nABONADO;

		IF dFecActivacion IS NULL THEN
		   bRESULTADO := 'FALSE';
           vMENSAJE   := 'ABONADO NO ESTA ACTIVADO, NO PUEDE OPERAR ESTA OOSS';
	    END IF;

	 END IF;


     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_ACTIVACION: NO SE PUEDE VALIDAR ACTIVACION DEL ABONADO.';


END;
/
SHOW ERRORS
