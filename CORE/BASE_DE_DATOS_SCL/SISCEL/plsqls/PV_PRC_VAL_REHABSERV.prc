CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_REHABSERV (
-- Valida si el abonado tenga rehabilitado el servicio.
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO     GA_ABOCEL.NUM_ABONADO%TYPE;

------------------------------------------------
	 nAbonadoAux  GA_ABOCEL.NUM_ABONADO%TYPE;
	 nIndRehabi	  GA_ABOCEL.IND_REHABI%TYPE;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 		:= TO_NUMBER(string(5));



     bRESULTADO := 'TRUE';

	 SELECT IND_REHABI
	 INTO   nIndRehabi
  	 FROM   GA_ABOCEL
	 WHERE  NUM_ABONADO = nABONADO;

	 IF nIndRehabi = 1 THEN

	     SELECT   COUNT(NUM_ABONADO)
		 INTO     nAbonadoAux
		 FROM     GA_SUSPREHABO
		 WHERE    NUM_ABONADO = nABONADO   AND
		          TIP_REGISTRO = 2 AND
		          IND_SINIESTRO = 0    AND
		          COD_MODULO = 'GA';


		 IF nAbonadoAux = 0 THEN
	  	      bRESULTADO := 'FALSE';
	       	  vMENSAJE   := 'EL ABONADO NO TIENE EFECTUADA UNA SUSPENSIoN DE SERVICIOS.' ;
		 END IF;

	 END IF;



     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR PV_PRC_VAL_REHABSERV: ' || SQLERRM || '.';


END;
/
SHOW ERRORS
