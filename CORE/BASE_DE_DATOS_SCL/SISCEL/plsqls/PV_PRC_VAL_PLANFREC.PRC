CREATE OR REPLACE PROCEDURE PV_PRC_VAL_PLANFREC (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

     vCodPlanTarif 		 GA_ABOAMIST.COD_PLANTARIF%TYPE;
	 vMaxFijo			 PPD_PLANES.NUM_FREC_FIJOS%TYPE;
	 vMaxMensaje		 PPD_PLANES.NUM_FREC_MENSAJE%TYPE;
	 vMaxMovil	  		 PPD_PLANES.NUM_FREC_MOVIL%TYPE;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));
     vACTABO  		:= string(4);

     bRESULTADO := 'TRUE';

     SELECT (COD_PLANTARIF)
     INTO   vCodPlanTarif
     FROM   GA_ABOAMIST
     WHERE  NUM_ABONADO    = nABONADO;


     SELECT NUM_FREC_FIJOS, NUM_FREC_MOVIL, NUM_FREC_MENSAJE
     INTO   vMaxFijo,vMaxMovil,vMaxMensaje
     FROM   PPD_PLANES
     WHERE  COD_PLANTARIF    = vCodPlanTarif;

      IF (vMaxFijo = 0) OR (vMaxFijo is NULL)  THEN
	  	 IF (vMaxMovil = 0) OR (vMaxMovil is NULL) THEN
		 	IF (vMaxMensaje = 0) OR (vMaxMensaje is NULL) THEN
	         bRESULTADO := 'FALSE';
	         vMENSAJE   := 'PLAN TARIFARIO NO OFRECE NUMEROS FRECUENTES';
			END IF;
		 END IF;
      END IF;


     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_PLANFREC: NO SE PUEDE VALIDAR PLAN FRECUENTE.';


END;
/
SHOW ERRORS
