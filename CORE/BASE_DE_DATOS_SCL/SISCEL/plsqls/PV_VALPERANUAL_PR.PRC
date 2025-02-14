CREATE OR REPLACE PROCEDURE PV_VALPERANUAL_PR(

        v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE

        )
IS
        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

     nABONADO                     GA_ABOCEL.NUM_ABONADO%TYPE;
     vACTABO              GA_ACTABO.COD_ACTABO%TYPE;
         sVar                 NUMBER(2) := 0;
         NVAL_PARAMETRO       GED_PARAMETROS.VAL_PARAMETRO%TYPE;
         vEXISTE              VARCHAR2(20) :='';
BEGIN
         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     nABONADO           := TO_NUMBER(string(5));
     vACTABO            := string(4);

     bRESULTADO:='TRUE';
         vMENSAJE:='';

        BEGIN
                Select VAL_PARAMETRO
                into   NVAL_PARAMETRO
                From   GED_PARAMETROS
                Where  COD_MODULO    = 'GA'   AND
                   Cod_producto  = '1'    AND
                           NOM_PARAMETRO = 'PERIODO_ANUAL' ;
        EXCEPTION
                   WHEN OTHERS THEN
                   NVAL_PARAMETRO:= NULL;
        END;

        IF NVAL_PARAMETRO IS NOT NULL THEN

                BEGIN
                        Select MAX(FEC_MODIFICA)
                        into   vEXISTE
                FROM   GA_MODABOCEL
                    WHERE  NUM_ABONADO = nABONADO
                    AND    COD_TIPMODI = vACTABO ;

                EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                           vEXISTE:= NULL;
                END;

                IF vEXISTE IS NOT NULL THEN

                 SELECT 1
                         into sVar
                         FROM (SELECT ADD_MONTHS(MAX(FEC_MODIFICA),NVAL_PARAMETRO) FECHA_PERIODO
                           FROM GA_MODABOCEL
                           WHERE NUM_ABONADO = nABONADO
                                   AND COD_TIPMODI = vACTABO)
                                   WHERE  FECHA_PERIODO<SYSDATE;
                END IF;

        ELSE
                  bRESULTADO:='FALSE';
                  vMENSAJE:='FALTA PARAMETRO PERIODO_ANUAL';
        END IF;

EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='No cumple limite exigido para emitir esta OOSS';
              WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';
END;
/
SHOW ERRORS
