CREATE OR REPLACE PACKAGE Gsm_Prefijos_Bajas_Pg IS

-- *************************************************************
-- * Paquete            : GSM_PREFIJOS_BAJAS_PG
-- * Descripcisn        : Proceso de Recuperacin de prefijos
-- * Fecha de creacisn  : Agosto 2004
-- * Responsable        : LABQ
-- *************************************************************



FUNCTION GSM_INS_GSM_PROCESOS_TO_FN ( ED_fec_inicial IN DATE, ED_fec_final IN DATE, EN_cod_uso  IN NUMBER,
                                                                          EN_cant_registros IN NUMBER ,   SV_msgerror OUT VARCHAR2) RETURN BOOLEAN;

FUNCTION GSM_UPD_GSM_SIMCARD_TO_FN ( EV_num_simcard IN VARCHAR2, EV_cod_estado  IN VARCHAR2,
                                                                                                        SV_msgerror  OUT VARCHAR2) RETURN BOOLEAN;

PROCEDURE GSM_SIMCARD_ESTADOS_TO_PR(GV_retorno IN OUT VARCHAR2);

END Gsm_Prefijos_Bajas_Pg;
/
SHOW ERRORS
