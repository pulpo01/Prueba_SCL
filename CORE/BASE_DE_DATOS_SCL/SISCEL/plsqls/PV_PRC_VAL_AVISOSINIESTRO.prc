CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_AVISOSINIESTRO (
-- Valida si el cliente posee cantidad  maxima de abonados por plan.
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;

------------------------------------------------
	 nTotalAbonados			NUMBER;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));


     bRESULTADO := 'TRUE';


	   SELECT COUNT(NUM_ABONADO)
	   INTO   nTotalAbonados
	   FROM   GA_SINIESTROS
	   WHERE  NUM_ABONADO = nABONADO;

	   IF nTotalAbonados = 0 THEN
  	   	   	  bRESULTADO := 'FALSE';
       		  vMENSAJE   := 'EL ABONADO NO TIENE REALIZADO UN AVISO DE SINIESTRO.';
	   END IF;


     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_AVISOSINIESTRO: ' || SQLERRM || '.';


END;
/
SHOW ERRORS
