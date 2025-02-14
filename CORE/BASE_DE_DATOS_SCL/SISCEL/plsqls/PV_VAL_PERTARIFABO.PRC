CREATE OR REPLACE PROCEDURE PV_VAL_PERTARIFABO (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

	 nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
	 nABONADO	 GA_ABOCEL.NUM_ABONADO%TYPE;
	 vCANT		 INTEGER;


BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 nABONADO 		:= TO_NUMBER(string(5));
	 nCLIENTE 		:= TO_NUMBER(string(6));

     bRESULTADO := 'TRUE';


	 SELECT COUNT(*)
	 INTO   vCANT
	 FROM   GA_INTARCEL
	 WHERE  COD_CLIENTE = nCLIENTE
	 AND    NUM_ABONADO = nABONADO
  	 AND    SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;

     IF vCANT = 0 THEN
        bRESULTADO := 'FALSE';
 	    vMENSAJE   := 'ABONADO NO POSEE PERIODO DE TARIFICACION VIGENTE.';
     END IF;

EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
		  vMENSAJE   := 'ERROR EN PV_VAL_PERTARIFCLIE: NO SE PUEDE OBTENER PERIODO DE FACT.VIGENTE DEL ABONADO.';

END;
/
SHOW ERRORS
