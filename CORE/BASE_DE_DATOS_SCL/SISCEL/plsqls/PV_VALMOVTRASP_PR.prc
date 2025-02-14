CREATE OR REPLACE PROCEDURE PV_VALMOVTRASP_PR (
    v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALMOVTRASP_PR
-- * Descripción        : Valida el tipo de movimiento segun traspaso
-- *
-- * Fecha de creación  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        NCOD_PRODUCTO             GA_MOV_TRASPASO_TD.COD_PRODUCTO%TYPE;
        SCOD_ACTABO                           GA_MOV_TRASPASO_TD.COD_ACTABO%TYPE;
        STIP_MOVIMIENTO                       GA_MOV_TRASPASO_TD.TIP_MOVIMIENTO%TYPE;

        DFEC_SYST                             VARCHAR2(10);
        SSTIP_MOVIMIENTO          VARCHAR2(2);
        vFormatoSel2    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
        vFormatoSel7    GED_PARAMETROS.VAL_PARAMETRO%TYPE;

BEGIN
/* INI COL|36787|28/02/2007|SAQL */
        -- vFormatoSel2 := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL2');
   --     vFormatoSel7 := ge_fn_devvalparam('GA', 1, 'FORMATO_SEL7');
        vFormatoSel2 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL2');
        vFormatoSel7 := ge_fn_devvalparam('GE', 1, 'FORMATO_SEL7');
/* FIN COL|36787|28/02/2007|SAQL */
        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
        SCOD_ACTABO          := string(4);
        DFEC_SYST            := string(20);
        STIP_MOVIMIENTO      := trim(string(21));

        dbms_output.PUT_LINE('SCOD_ACTABO   =' || SCOD_ACTABO  );
        dbms_output.PUT_LINE('DFEC_SYST=' || DFEC_SYST);
        dbms_output.PUT_LINE('STIP_MOVIMIENTO=' || STIP_MOVIMIENTO);

        bRESULTADO          :='TRUE';
        vMENSAJE            := '';

    BEGIN
        SELECT TIP_MOVIMIENTO
        INTO
            SSTIP_MOVIMIENTO
        FROM GA_MOV_TRASPASO_TD
        WHERE COD_PRODUCTO   = 1                       AND
                      COD_ACTABO     = SCOD_ACTABO             AND
                          trim(TIP_MOVIMIENTO) = STIP_MOVIMIENTO   AND
                TO_DATE(DFEC_SYST , vFormatoSel2) BETWEEN FEC_DESDE AND FEC_HASTA;


EXCEPTION
      WHEN NO_DATA_FOUND THEN
            bRESULTADO := 'FALSE';
            vMENSAJE   := 'No definido tipo movimiento segun actuacion';
          WHEN OTHERS            THEN
                    bRESULTADO := 'FALSE';
            vMENSAJE   := 'Error al recuperar datos de Mov. de Traspaso.';
    END;

END PV_VALMOVTRASP_PR;
/
SHOW ERRORS
