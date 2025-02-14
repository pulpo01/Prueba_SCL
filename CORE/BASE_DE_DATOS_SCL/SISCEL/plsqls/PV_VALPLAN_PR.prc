CREATE OR REPLACE PROCEDURE PV_VALPLAN_PR
 (
    V_param_entrada IN  VARCHAR2,
    bRESULTADO      OUT VARCHAR2,
    vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE

        )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_VALPLAN_PR
-- * Descripcion        : Verificar que el plan sea valido ( existe en la ta_plantarif)
-- *
-- * Fecha de creacion  : 13-01-2003 12:46
-- * Responsable        : Area Postventa
-- *************************************************************

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

        sCodPTarifNuevo        TA_PLANTARIF.COD_PLANTARIF%TYPE;

        scod_limconsumo        TA_PLANTARIF.COD_LIMCONSUMO%TYPE;
        scod_cargobasico       TA_PLANTARIF.COD_CARGOBASICO%TYPE;
        nnum_abonados          TA_PLANTARIF.NUM_ABONADOS%TYPE;

BEGIN
     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);
     sCodPTarifNuevo       :=STRING(12);

     bRESULTADO:='TRUE';


    SELECT COD_LIMCONSUMO, COD_CARGOBASICO, NUM_ABONADOS
        into scod_limconsumo,scod_cargobasico,nnum_abonados
    FROM TA_PLANTARIF
    WHERE COD_PLANTARIF = sCodPTarifNuevo
    AND COD_PRODUCTO = 1;


EXCEPTION WHEN NO_DATA_FOUND THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Faltan datos del plan tarifario del cliente destino';
              WHEN OTHERS  THEN
                           bRESULTADO:='FALSE';
                           vMENSAJE:='Error de Acceso ';
END PV_VALPLAN_PR;
/
SHOW ERRORS
