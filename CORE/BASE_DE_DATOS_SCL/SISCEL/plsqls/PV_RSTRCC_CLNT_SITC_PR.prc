CREATE OR REPLACE PROCEDURE PV_rstrcc_clnt_sitc_PR (
          EV_param_entrada IN  VARCHAR2,
          SV_RESULTADO      OUT VARCHAR2,
                  SV_MENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

     LN_CLIENTE    GA_ABOCEL.COD_CLIENTE%TYPE;
     LV_ACTABO     GA_ACTABO.COD_ACTABO%TYPE;

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
     LN_CLIENTE           := TO_NUMBER(string(6));
     LV_ACTABO            := string(4);

         SELECT 'TRUE' INTO SV_RESULTADO FROM ga_abocel a
         WHERE a.cod_cliente = LN_CLIENTE
         AND NOT EXISTS (SELECT 1
                     FROM   pvd_actuacion_situacion b
                     WHERE  b.cod_producto  = a.cod_producto
                     AND    b.cod_actabo    = LV_ACTABO
                     AND    b.cod_situacion = a.cod_situacion)
         AND ROWNUM = 1;

     EXCEPTION
     WHEN NO_DATA_FOUND THEN
          SV_RESULTADO := 'FALSE';
          SV_MENSAJE   := 'Cliente no posee abonados con situación permitda para esta operación.';

     WHEN OTHERS THEN
          SV_RESULTADO := 'FALSE';
          SV_MENSAJE   := 'ERROR EN PV_rstrcc_clnt_sitc_PR: NO SE PUEDE VALIDAR SITUACION DEL CLIENTE.';

END;
/
SHOW ERRORS
