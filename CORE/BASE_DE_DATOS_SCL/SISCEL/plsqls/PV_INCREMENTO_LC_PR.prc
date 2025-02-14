CREATE OR REPLACE PROCEDURE PV_INCREMENTO_LC_PR(
        V_PARAM_ENTRADA IN  VARCHAR2,
        bRESULTADO      OUT VARCHAR2,
        vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_INCREMENTO_LC_PR
-- * Descripcion        : Procedimiento Almacenado para implementar restriccion para TMM que el aumento de Limite de Consumo no supere un X%
-- * Fecha de creacion  : 09-01-2003 16:53
-- * Responsable        : Area Postventa
-- *************************************************************
        STRING GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        nNumAbonado     GA_ABOCEL.NUM_ABONADO%TYPE;
        nCodCliente     GE_CLIENTES.COD_CLIENTE%TYPE;
        nIncremento_LC  NUMBER(3);
        nIncremento     TOL_LIMITE_TD.IMP_LIMITE%TYPE;
        nLimiteCliAbo   TOL_LIMITE_TD.IMP_LIMITE%TYPE;
BEGIN
        DBMS_OUTPUT.PUT_LINE('PV_INCREMENTO_LC_PR');

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(V_PARAM_ENTRADA, STRING);
        nNumAbonado := TO_NUMBER(STRING(5));
        nCodCliente := TO_NUMBER(STRING(6));
        nIncremento := TO_NUMBER(STRING(20));

        nIncremento_LC := TO_NUMBER(GE_FN_DEVVALPARAM('GA', 1, 'INCREMENTO_LC'));

        BEGIN
                SELECT B.IMP_LIMITE
                  INTO nLimiteCliAbo
                  FROM GA_LIMITE_CLIABO_TO A, TOL_LIMITE_TD B
                 WHERE A.COD_CLIENTE = nCodCliente
                   AND A.NUM_ABONADO = nNumAbonado
                   AND SYSDATE BETWEEN A.FEC_DESDE AND NVL(A.FEC_HASTA,SYSDATE)
                   AND A.COD_LIMCONS = B.COD_LIMCONS;

                IF nIncremento >  ((100 + nIncremento_LC)/100) *  nLimiteCliAbo
                THEN
                        bRESULTADO := 'FALSE';
                        vMENSAJE := 'El incremento es mayor en un '||TO_CHAR(nIncremento_LC)||'% al actual';
                ELSE
                        bRESULTADO := 'TRUE';
                        vMENSAJE := 'El incremento es menor a un '||TO_CHAR(nIncremento_LC)||'% que el actual';
                END IF;

        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        bRESULTADO := 'TRUE';
                        vMENSAJE := 'No Existe Limite de Consumo Previo';
        END;


END PV_INCREMENTO_LC_PR;
/
SHOW ERRORS
