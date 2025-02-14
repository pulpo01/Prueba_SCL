CREATE OR REPLACE PROCEDURE PV_VAL_CATTRIBUTCLIE (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

         nCLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;

------------------------------------------------

     vCOD_CATRIBUT        GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;
     vCAT_CLIENTE         GA_CATRIBUTCLIE.COD_CATRIBUT%TYPE;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
         nCLIENTE               := TO_NUMBER(string(6));

     bRESULTADO := 'TRUE';

     SELECT VAl_PARAMETRO
     INTO   vCAT_CLIENTE
     FROM   GED_PARAMETROS
     WHERE  NOM_PARAMETRO='CAT_TRIB_FACT';


     SELECT COD_CATRIBUT
     INTO   vCOD_CATRIBUT
     FROM   GA_CATRIBUTCLIE
     WHERE  COD_CLIENTE = nCLIENTE;


     IF vCAT_CLIENTE <> vCOD_CATRIBUT THEN
        bRESULTADO := 'FALSE';
            vMENSAJE   := 'CLIENTE NO TIENE UNA CATEGORIA TRIBUTARIA PERMITIDA PARA ESTA OPERACION';
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
                  vMENSAJE   := 'ERROR EN PV_VAL_CATTRIBUTCLIE: NO SE PUEDE VALIDAR CATEGORIA TRIBUTARIA DEL CLIENTE.';

END;
/
SHOW ERRORS
