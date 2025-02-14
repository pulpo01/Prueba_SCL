CREATE OR REPLACE PROCEDURE PV_VALABOSUBTEL_PR(
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE

        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALABOSUBTEL_PR
-- * Descripcion        : Valida que el cliente no tiene abonados supertelefono
-- *
-- * Fecha de creacion  : 13-01-2003 12:23
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        ncod_cliente      GA_ABOCEL.COD_CLIENTE%TYPE;
        nnum_abonado      GA_ABOCEL.NUM_ABONADO%TYPE;

        -- Variables de Error, para procediemientos.

BEGIN
        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    ncod_cliente                := TO_NUMBER(STRING(6));

        bRESULTADO := 'FALSE';
        vMENSAJE   := 'El cliente tiene abonados supertelefono.';
    SELECT NUM_ABONADO
        INTO  nnum_abonado
        FROM GA_ABOCEL
    WHERE COD_CLIENTE = nCOD_CLIENTE
    AND IND_SUPERTEL = 1
    AND ROWNUM = 1;

    EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO := 'TRUE';
                           vMENSAJE   := 'El cliente no tiene abonados supertelefono.';
                  WHEN OTHERS  THEN
                           bRESULTADO := 'FALSE';
                           vMENSAJE   := 'Error de Acceso';
END PV_VALABOSUBTEL_PR;
/
SHOW ERRORS
