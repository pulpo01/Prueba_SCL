CREATE OR REPLACE PROCEDURE        PV_PRC_PERFILDCTO_USUARIO (
--Verifica si existe OoSs pendiente
    	  v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nCODUSER      VE_VENDPERFIL.COD_VENDEDOR%TYPE;
------------------------------------------------

     nCodUsu NUMBER(2) := 0;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 nCODUSER  		:= string(10);


     bRESULTADO := 'TRUE';

    SELECT A.COD_VENDEDOR
	INTO nCodUsu
    FROM VE_VENDPERFIL A, GA_PERFILCARGOS B
    WHERE A.COD_VENDEDOR =nCODUSER
    And B.PRC_DTO_INF >= 1 And B.PRC_DTO_SUP <= 100
    AND B.COD_PERFIL = A.COD_PERFIL
    AND SYSDATE BETWEEN A.FEC_ASIGNACION AND NVL(A.FEC_DESASIGNAC,SYSDATE);


     IF nCodUsu <= 0 THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'VENDEDOR NO TIENE PERFIL PARA HACER DESCUENTO", vbExclamation, "SCL';
     END IF;

EXCEPTION
   WHEN OTHERS THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'ERROR EN PV_PRC_PERFILDCTO_USUARIO: NO SE PUEDE VALIDAR SI VENDEDOR TIENE PERFIL PARA HACER DESCUENTO.' || SQLERRM || '.';

END;
/
SHOW ERRORS
