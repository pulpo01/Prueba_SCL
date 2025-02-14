CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_SUSPMORA (
-- Valida si el cliente posee cantidad  maxima de abonados por plan.
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO     GA_ABOCEL.NUM_ABONADO%TYPE;

------------------------------------------------
	 nAbonadoAux  GA_ABOCEL.NUM_ABONADO%TYPE;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));


     bRESULTADO := 'TRUE';



       SELECT COUNT(NUM_ABONADO)
	   INTO   nAbonadoAux
	   FROM   GA_SUSPREHABO
	   WHERE  COD_MODULO = 'CO'
	   AND    COD_CAUSUSP = '1'
	   AND    FEC_REHABD IS NULL
	   AND    NUM_ABONADO = nABONADO;


	   IF nAbonadoAux = 0 THEN
  	   	   	  bRESULTADO := 'FALSE';
       		  vMENSAJE   := 'SE REQUIERE QUE EL ABONADO SE ENCUENTRE EN LA SITUACION:' || 'ALTA ACTIVA DE ABONADO o SUSPENSION ACTIVA DE ABONADO (Causa MORA).';
	   END IF;


     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_SUSPMORA: ' || SQLERRM || '.';


END;
/
SHOW ERRORS
