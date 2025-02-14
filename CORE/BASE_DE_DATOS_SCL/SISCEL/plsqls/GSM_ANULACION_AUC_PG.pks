CREATE OR REPLACE PACKAGE GSM_ANULACION_AUC_PG IS

-- *************************************************************
-- * Paquete            : GSM_ANULACION_AUC_PKG
-- * Descripci"n        : Sub sistema de Generaci"n de Sim Card
-- * Fecha de creaci"n  : Agosto 2004
-- * Responsable        : Maritza Tapia A
-- *************************************************************

PROCEDURE GSM_INSERTA_MOVIMIENTO_PR (EN_solicitud IN  GSM_SOL_ANULACION_TO.NUM_SEQ_ANULACION%TYPE);

PROCEDURE GSM_PREFIJOS_SIMCARD_PR (V_SIMCARD IN GSM_SIMCARD_TO.NUM_SIMCARD%TYPE);

PROCEDURE GSM_PREFIJOS_RECICLADOS_PR(EV_num_simcard  GSM_SIMCARD_TO.NUM_SIMCARD%TYPE);

--FUNCTION GSM_VALIDA_SIMCARD_FN(EV_simcard gsm_simcard_to.NUM_SIMCARD%TYPE) RETURN BOOLEAN;

FUNCTION GSM_CANTIDAD_PARAMETROS_FN RETURN   NUMBER;

FUNCTION Gsm_Valida_Simcard_Fn(EN_Cantidad  IN NUMBER, EV_simcard GSM_SIMCARD_TO.NUM_SIMCARD%TYPE) RETURN BOOLEAN;

END GSM_ANULACION_AUC_PG;
/
SHOW ERRORS
