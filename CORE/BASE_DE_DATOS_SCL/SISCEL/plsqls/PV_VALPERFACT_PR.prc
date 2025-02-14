CREATE OR REPLACE PROCEDURE PV_VALPERFACT_PR (
   v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALPERFACT_PR
-- * Descripción        : Valida Periodo de Facturacion Vigente
-- *
-- * Fecha de creación  : 13-01-2003 12:46
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
        vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
BEGIN
        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
        ncod_clienteo           :=TO_NUMBER(string(6));
        nNumAbonado                 :=TO_NUMBER(string(5));
        ncod_ciclo              :=TO_NUMBER(RTRIM(LTRIM((string(19)))));
        FECSYS                  :=string(20);
/* INI COL|36787|07/03/2007|SAQL */
--        vFormatoSel2 := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL2');
--        vFormatoSel7 := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL7');
        vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
        vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
/* FIN COL|36787|07/03/2007|SAQL */

    bRESULTADO:='TRUE';

    SELECT COD_CICLFACT
      INTO ncod_ciclfact
      FROM FA_CICLFACT
     WHERE COD_CICLO = nCOD_CICLO
       AND TO_DATE(FECSYS, vFormatoSel2) BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM;

    SELECT NUM_ABONADO
        into
        nNumAbonados
        FROM GA_INFACCEL
    WHERE COD_CLIENTE      = ncod_clienteo
          AND NUM_ABONADO  = nNumAbonado
          AND IND_ACTUAC =  1
          AND COD_CICLFACT = ncod_ciclfact;


EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           --vMENSAJE :='Abonado No tiene periodo de facturación '||
                           --                   'vigente. No puede ser traspasado';
                           vMENSAJE :='Abonado No tiene periodo de facturación vigente.';
              WHEN OTHERS  THEN
                                   dbms_output.PUT_LINE(SQLERRM);
                           bRESULTADO:='FALSE';
                           vMENSAJE  :='Error de Acceso ';

END PV_VALPERFACT_PR;
/
SHOW ERRORS
