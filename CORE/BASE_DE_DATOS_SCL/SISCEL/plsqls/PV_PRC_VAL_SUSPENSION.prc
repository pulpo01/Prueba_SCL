CREATE OR REPLACE PROCEDURE Pv_Prc_Val_Suspension (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     nABONADO    GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO     GA_ACTABO.COD_ACTABO%TYPE;
         vSITUACION  GA_ABOCEL.COD_SITUACION%TYPE;
         vCodModulo  GA_SUSPREHABO.COD_MODULO%TYPE;
         vTECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
         vCOUNT          INT;
------------------------------------------------

BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO           := TO_NUMBER(string(5));
     vACTABO            := string(4);

     bRESULTADO := 'TRUE';

         SELECT COD_SITUACION, COD_TECNOLOGIA
                 INTO   vSITUACION, vTECNOLOGIA
                 FROM   GA_ABOCEL
             WHERE  NUM_ABONADO = nABONADO
                 union
                 SELECT COD_SITUACION, COD_TECNOLOGIA
                 FROM   GA_ABOAMIST
                 WHERE  NUM_ABONADO = nABONADO;

         IF vSITUACION = 'SAA' THEN
                        --HB-051120030152, German Espinoza Zu?iga, 13/11/2003 20:30 Hrs.
                        --se dejaron afuera de la consulta los modulos CO y se cambio el mensaje de error

                        SELECT count(1)
                        INTO   vCodModulo
                        FROM   GA_SUSPREHABO
                        WHERE  NUM_ABONADO    = nABONADO
                        and cod_modulo<>'CO';

                        IF vCodModulo >0 THEN
                                 bRESULTADO := 'FALSE';
                                 vMENSAJE :='ABONADO YA SE ENCUENTRA SUSPENDIDO POR POSVENTA';
                                 --vMENSAJE   := 'SITUACION DE ABONADO NO ES PERMITIDA PARA ESTA OPERACION';
                        END IF;
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_SUSPENSION: NO SE PUEDE VALIDAR TIPO DE SUSPENSION DEL ABONADO.';


END;
/
SHOW ERRORS
