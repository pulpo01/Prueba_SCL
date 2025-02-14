CREATE OR REPLACE PROCEDURE PV_VALPLANNOPREPA_PR (
        v_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALPLANNOPREPA_PR
-- * Descripcion        : Valida que no tenga  Plan Tarif. Prepago
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

        string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
        scod_tiplan     TA_PLANTARIF.COD_TIPLAN%TYPE;
        sCOD_PLAN       TA_PLANTARIF.COD_PLANTARIF%TYPE;
BEGIN

        GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
    sCOD_PLAN           := STRING(12);
        bRESULTADO:='TRUE';
        SELECT COD_TIPLAN
        into
        scod_tiplan
        FROM TA_PLANTARIF
        WHERE
        COD_PRODUCTO  =  1 AND
        COD_PLANTARIF =  sCOD_PLAN;

        if scod_tiplan = '1' then
           bRESULTADO :=  'FALSE';
       vMENSAJE   :=  'No puede realizar esta Solicitud por tener un Plan Tarif. Prepago';
        end if;

        EXCEPTION WHEN NO_DATA_FOUND THEN
                            bRESULTADO :='FALSE';
                            vMENSAJE   :='Error Plan Tarifario no existe.';
                  WHEN OTHERS  THEN
                           bRESULTADO :='FALSE';
                           vMENSAJE   :='Error de Acceso ';
END PV_VALPLANNOPREPA_PR;
/
SHOW ERRORS
