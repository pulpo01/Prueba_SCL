CREATE OR REPLACE PROCEDURE PV_VALMOVFREC_PR (
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALMOVFREC_PR
-- * Descripción        : Valida que no exista movimiento pendiente
-- *
-- * Fecha de creación  : 21/04/2004
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        SCOD_ACTABO GA_ACTABO.COD_ACTABO%TYPE;
                nABONADO        GA_ABOCEL.NUM_ABONADO%TYPE;

                SEXISTE         VARCHAR2(10);

        vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN
/* INI COL|36787|07/03/2007|SAQL */
--      vFormatoSel2 := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL2');
--    vFormatoSel7 := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL7');
        vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
/* FIN COL|36787|07/03/2007|SAQL */
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

        nABONADO            := TO_NUMBER(string(5));
    bRESULTADO          :='TRUE';
    vMENSAJE            := '';
        SEXISTE             := '';

    BEGIN
        SELECT DISTINCT 'EXISTE'
        INTO   SEXISTE
        FROM   ICC_MOVIMIENTO
        WHERE  NUM_ABONADO = nABONADO
                AND    COD_ACTABO  IN ('FI','FB','FM');

                IF SEXISTE IS NOT NULL THEN
                        bRESULTADO := 'FALSE';
                        vMENSAJE   := 'Abonado tiene movimientos pendientes.';
                END IF;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
            bRESULTADO := 'TRUE';
      WHEN OTHERS            THEN
            bRESULTADO := 'FALSE';
            vMENSAJE   := 'Error al recuperar datos de Mov. del celular.';
    END;

END PV_VALMOVFREC_PR;
/
SHOW ERRORS
