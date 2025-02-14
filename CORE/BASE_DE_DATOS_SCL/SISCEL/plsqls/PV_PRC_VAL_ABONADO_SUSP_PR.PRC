CREATE OR REPLACE PROCEDURE PV_PRC_VAL_ABONADO_SUSP_PR (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vSITUACION  GA_ABOCEL.COD_SITUACION%TYPE;
     vCodModulo  GA_SUSPREHABO.COD_MODULO%TYPE;
     vTECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
------------------------------------------------

BEGIN

     SISCEL.GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO           := TO_NUMBER(string(5));
     vCodModulo         := '';
     bRESULTADO         :='TRUE';

     SELECT COD_SITUACION, COD_TECNOLOGIA
     INTO   vSITUACION, vTECNOLOGIA
     FROM   GA_ABOCEL
     WHERE  NUM_ABONADO = nABONADO
     union
     SELECT COD_SITUACION, COD_TECNOLOGIA
     FROM   GA_ABOAMIST
     WHERE  NUM_ABONADO = nABONADO;

     IF vSITUACION = 'SAA' THEN
		BEGIN
	        SELECT COD_MODULO
	        INTO   vCodModulo
	        FROM   GA_SUSPREHABO
	        WHERE  NUM_ABONADO    = nABONADO;

		EXCEPTION
	         WHEN NO_DATA_FOUND THEN
	              bRESULTADO := 'FALSE';
	              vMENSAJE   := 'ERROR EN PV_PRC_VAL_ABONADOS_SUSPENDIDOS_PR:ABONADO NO SE ENCUENTRA REGISTRADO COMO SUSPENDIDO';

	         WHEN OTHERS THEN
	              bRESULTADO := 'FALSE';
	              vMENSAJE   := 'ERROR EN PV_PRC_VAL_ABONADOS_SUSPENDIDOS_PR: NO SE PUEDE VALIDAR SUSPENSION DEL ABONADO.';

		END;
     END IF;

EXCEPTION
         WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_ABONADOS_SUSPENDIDOS_PR: NO SE PUEDE VALIDAR SUSPENSION DEL ABONADO.';

END;
/
SHOW ERRORS
