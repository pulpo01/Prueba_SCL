CREATE OR REPLACE PROCEDURE PV_PR_VALMIN_MDN(
                                                   v_param_entrada IN  VARCHAR2,
                                                   bRESULTADO      OUT VARCHAR2,
                                           vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
                                                  )
IS
         string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
         ActMin_MDN ga_abocel.NUM_MIN_MDN%type;
         NvoMin_MDN ga_abocel.NUM_MIN_MDN%type;
         nCelular       ga_abocel.NUM_CELULAR%type;
         nABONADO   ga_abocel.NUM_ABONADO%TYPE;

BEGIN
         bRESULTADO := 'TRUE';

         Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO           := TO_NUMBER(string(5));

         -- Recuperamos el numero de Celular del Abonado --
         SELECT NUM_CELULAR INTO nCelular
                        FROM  GA_ABOCEL
                        WHERE NUM_ABONADO = nAbonado
         UNION
         SELECT NUM_CELULAR
                        FROM  GA_ABOAMIST
                        WHERE NUM_ABONADO = nAbonado;

         -- Recuperamos el Nuevo numero MIN_MDN --
         SELECT GE_FN_MIN_DE_MDN(nCelular) INTO NvoMin_MDN FROM DUAL;

         -- Recuperamos el MIN Actual --
         SELECT FN_RECUPERA_NUM_MIN(nAbonado) INTO ActMin_MDN FROM DUAL;

         IF NvoMin_MDN = ActMin_MDN THEN
                bRESULTADO := 'FALSE';
                vMENSAJE   := 'ABONADO NO HA SUFRIDO CAMBIO EN SU NUMERO DE MIN."NO SE PERMITIRA ACCESO A LA ORDEN DE SERVICIO';
         END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PR_VALMIN_MDN: NO SE PUEDE VALIDAR CAMBIO EN SU NUMERO DE MIN.';

END;
/
SHOW ERRORS
