CREATE OR REPLACE PROCEDURE PV_INTARCEL_A_CICLO_PR (
v_param_entrada IN  VARCHAR2,
bRESULTADO      OUT VARCHAR2,
vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VAL_INTARCEL_A_CICLO
-- * Descripción        : Valida existencia Periodo de Facturacion A CICLO
-- *
-- * Fecha de creación  : 10-05-2004
-- * Responsable        : Area Postventa
-- *************************************************************
    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        -- Variables de Error, para procediemientos.
    ncod_clienteo         GA_INFACCEL.COD_CLIENTE%TYPE;
    nNumAbonado           GA_INFACCEL.NUM_ABONADO%TYPE;
    nNumAbonados          GA_INFACCEL.NUM_ABONADO%TYPE;
    ncod_ciclfact         FA_CICLFACT.COD_CICLFACT%TYPE;
    ncod_ciclo            GA_ABOCEL.COD_CICLO%TYPE;
    FECSYS                VARCHAR2(10);
    vFormatoSel2          GED_PARAMETROS.VAL_PARAMETRO%TYPE;
    vFormatoSel7          GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        cantNumAbonados       integer;
BEGIN
    GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    ncod_clienteo           :=TO_NUMBER(string(6));
    nNumAbonado             :=TO_NUMBER(string(5));
    FECSYS                  :=string(20);
/* INI COL|36787|07/03/2007|SAQL */
--    vFormatoSel2            := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL2');
--    vFormatoSel7            := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL7');
    vFormatoSel2            := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
    vFormatoSel7            := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
/* FIN COL|36787|07/03/2007|SAQL */

    bRESULTADO:='TRUE';



    SELECT COUNT(NUM_ABONADO)
    into
    cantNumAbonados
    FROM GA_INTARCEL
    WHERE COD_CLIENTE      = ncod_clienteo
    AND NUM_ABONADO        = nNumAbonado
        AND trunc(FEC_DESDE)  > trunc(TO_DATE(FECSYS,vFormatoSel2));

        IF (cantNumAbonados > 0)  then
           bRESULTADO:='FALSE';
           vMENSAJE :='"No se pueden realizar traspasos de propiedad si el cliente origen posee cambios a ciclo pendiente';
        end if;


EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='true';
              WHEN OTHERS  THEN
                           dbms_output.PUT_LINE(SQLERRM);
                           bRESULTADO:='FALSE';
                           vMENSAJE  :='Error de Acceso ';


END PV_INTARCEL_A_CICLO_PR;
/
SHOW ERRORS
