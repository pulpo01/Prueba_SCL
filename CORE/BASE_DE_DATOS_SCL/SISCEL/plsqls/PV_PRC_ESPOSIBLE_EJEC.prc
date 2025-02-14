CREATE OR REPLACE PROCEDURE        PV_PRC_ESPOSIBLE_EJEC (
--Verifica si existe OoSs pendiente
    	  v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     vCOD_OS      CI_TIPORSERV.COD_OS%TYPE;
------------------------------------------------

     nIndLock NUMBER(2) := 0;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 vCOD_OS  		:= string(9);


     bRESULTADO := 'TRUE';

    SELECT IND_LOCK
	INTO nIndLock
	FROM CI_TIPORSERV
    WHERE COD_OS = vCOD_OS;


     IF nIndLock <> 0 THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'NO SE PUEDE EJECUTAR, TIENE OOSS PENDIENTE", vbExclamation, "SCL';
     END IF;

EXCEPTION
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ERROR EN PRC_ESPOSIBLE_EJEC: NO SE PUEDE VALIDAR SI ES POSIBLE EJECUTAR OOSS.' || SQLERRM || '.';

END;
/
SHOW ERRORS
