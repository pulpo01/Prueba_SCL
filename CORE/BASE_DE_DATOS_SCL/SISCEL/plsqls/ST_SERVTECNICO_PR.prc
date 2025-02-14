CREATE OR REPLACE PROCEDURE ST_SERVTECNICO_PR
	   (
       v_param_entrada IN  VARCHAR2,
       bRESULTADO      OUT VARCHAR2,
       vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
	   )
IS
     string SISCEL.GE_TABTYPE_VCH2ARRAY:= SISCEL.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

	 nIndDisp				NUMBER;

BEGIN

     Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO 	:= TO_NUMBER(string(5));
     bRESULTADO := 'TRUE';

     BEGIN
        SELECT NVL(A.IND_DISP,1)
          INTO nIndDisp
          FROM GA_ABOCEL A
         WHERE A.NUM_ABONADO = nABONADO;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN

            SELECT NVL(A.IND_DISP,1)
              INTO nIndDisp
              FROM GA_ABOAMIST A
             WHERE A.NUM_ABONADO = nABONADO;
     END;

     IF nIndDisp = 1 THEN

         bRESULTADO := 'FALSE';
         vMENSAJE   := 'EL ABONADO NO TIENE SU EQUIPO EN SERVICIO TECNICO';

     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN ST_SERVTECNICO_PR: NO SE PUEDE VALIDAR EQUIPO EN SERVICIO TECNICO.' || SQLERRM || '.';


END;
/
SHOW ERRORS
