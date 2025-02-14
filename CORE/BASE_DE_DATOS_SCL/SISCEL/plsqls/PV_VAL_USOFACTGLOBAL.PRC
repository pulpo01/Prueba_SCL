CREATE OR REPLACE PROCEDURE PV_VAL_USOFACTGLOBAL (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

         vRESP VARCHAR2(6);
BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

     bRESULTADO := 'TRUE';

     SELECT VAl_PARAMETRO
     INTO   vRESP
     FROM   GED_PARAMETROS
     WHERE  NOM_PARAMETRO='USO_FAC_GLOBAL'
         AND    COD_MODULO='GA'
         AND    COD_PRODUCTO=1;

     IF vRESP = 'FALSE' THEN
        bRESULTADO := 'FALSE';
            vMENSAJE   := 'LA OPERADORA NO APLICA FACTURA GLOBAL';
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
                  vMENSAJE   := 'ERROR EN PV_VAL_USOFACTGLOBAL: NO SE PUEDE FACTURA GLOBAL A LA OPERADORA.';

END;
/
SHOW ERRORS
