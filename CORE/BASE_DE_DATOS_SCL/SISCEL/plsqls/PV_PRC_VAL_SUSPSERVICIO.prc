CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_SUSPSERVICIO (
-- Valida si el abonado no tenga suspendido el servicio.
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO     GA_ABOCEL.NUM_ABONADO%TYPE;

------------------------------------------------
	 nAbonadoAux  GA_ABOCEL.NUM_ABONADO%TYPE;
	 nIndSusp	  GA_ABOCEL.IND_REHABI%TYPE;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));



     bRESULTADO := 'TRUE';

	 SELECT IND_SUSPEN
	 INTO   nIndSusp
  	 FROM   GA_ABOCEL
	 WHERE  NUM_ABONADO = nABONADO;

	 IF nIndSusp = 0 THEN

	   	      bRESULTADO := 'FALSE';
	       	  vMENSAJE   := 'EL ABONADO SE ENCUENTRA COMO NO SUSPENDIBLE. ';

	 END IF;



     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR PV_PRC_VAL_SUSPSERVICIO: ' || SQLERRM || '.';


END;
/
SHOW ERRORS
