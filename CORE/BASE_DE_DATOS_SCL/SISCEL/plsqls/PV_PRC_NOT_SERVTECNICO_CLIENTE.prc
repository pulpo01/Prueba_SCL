CREATE OR REPLACE PROCEDURE Pv_Prc_Not_Servtecnico_Cliente (
-- Valida que el Cliente no tenga abonados con equipo en Servicio Tecnico
-- por lo tanto si GA_ABOCEL.IND_DISP= '0 ==> FALSE
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

         nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------



         nIndDisp                               NUMBER;

BEGIN

    Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(v_param_entrada, string);
        nCLIENTE                := TO_NUMBER(string(6));


    bRESULTADO := 'TRUE';

        SELECT COUNT(*)
        INTO   nIndDisp
        FROM   GA_ABOCEL A
        WHERE  A.COD_CLIENTE    = nCLIENTE
        AND    A.COD_SITUACION  = 'AAA'
        AND    NVL(A.IND_DISP,1)<>1;

        IF nIndDisp = 0 THEN

            SELECT COUNT(*)
            INTO   nIndDisp
            FROM   GA_ABOAMIST A
            WHERE  A.COD_CLIENTE    = nCLIENTE
                        AND    A.COD_SITUACION  = 'AAA'
                        AND    NVL(A.IND_DISP,1)<>1;

                        IF nIndDisp > 0 THEN

                           bRESULTADO := 'FALSE';
                           vMENSAJE   := 'EL CLIENTE TIENE ABONADO(S) CON SU EQUIPO EN SERVICIO TECNICO';

                        END IF;

    ELSE

         bRESULTADO := 'FALSE';
         vMENSAJE   := 'EL CLIENTE TIENE ABONADO(S) CON SU EQUIPO EN SERVICIO TECNICO';

        END IF;

    EXCEPTION
    WHEN OTHERS THEN
         bRESULTADO := 'FALSE';
         vMENSAJE   := 'ERROR EN PV_PRC_NOT_SERVTECNICO_CLIENTE: NO SE PUEDE VALIDAR EQUIPO EN SERVICIO TECNICO.' || SQLERRM || '.';


END;
/
SHOW ERRORS
