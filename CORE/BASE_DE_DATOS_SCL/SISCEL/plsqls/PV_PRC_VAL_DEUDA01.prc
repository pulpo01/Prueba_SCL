CREATE OR REPLACE PROCEDURE        PV_PRC_VAL_DEUDA01 (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

     string GE_TABTYPE_VCH2ARRAY := GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametro real de entrada ---------------------

     nCLIENTE       GA_ABOCEL.COD_CLIENTE%TYPE;

----------------------------------------------------

     vMonto CO_CARTERA.IMPORTE_DEBE%TYPE;

BEGIN
     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
	 nCLIENTE	:= TO_NUMBER(string(6));


     bRESULTADO := 'TRUE';

     SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
     INTO   vMonto
     FROM   CO_CARTERA
     WHERE  cod_cliente       = nCLIENTE
     AND    IND_FACTURADO     = 1
     AND    FEC_VENCIMIE      < TRUNC(SYSDATE)
     AND    COD_TIPDOCUM NOT IN (SELECT  TO_NUMBER(COD_VALOR)
                                 FROM    CO_CODIGOS
                                 WHERE   NOM_TABLA   = 'CO_CARTERA'
                                 AND     NOM_COLUMNA = 'COD_TIPDOCUM');

     IF vMonto > 0 THEN
        bRESULTADO := 'FALSE';
        vMENSAJE   := 'CLIENTE PRESENTA MOROSIDAD CON VALOR: '||to_char(vMonto);
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          bRESULTADO := 'FALSE';
          vMENSAJE   := 'ERROR EN PV_PRC_VAL_DEUDA01: NO SE PUEDE CALCULAR MOROSIDAD.';

END;
/
SHOW ERRORS
