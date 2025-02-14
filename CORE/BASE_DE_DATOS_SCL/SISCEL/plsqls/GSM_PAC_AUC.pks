CREATE OR REPLACE PACKAGE Gsm_Pac_Auc IS

-- *************************************************************
-- * Paquete            : GSM_PAC_AUC
-- * Descripción        : Sub sistema de Generación de Sim Card
-- * Fecha de creación  : Noviembre 2002
-- * Responsable        : Ulises Uribe.
-- *************************************************************

Procedure P_Inserta_Icc(v_solicitud_auc IN GSM_SOLICITUD_AUC_TO%ROWTYPE);

Procedure P_ACTUALIZA_ICC (v_simcard IN GSM_SIMCARD_TO.num_simcard%TYPE, v_actuacion IN ICC_MOVIMIENTO.COD_ACTUACION%TYPE, v_movimiento IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE);

Procedure P_ACTUALIZAESTADOSICC (v_modulo IN GE_MODULOS.cod_modulo%TYPE,
                                 v_icc IN GSM_SIMCARD_TO.num_simcard%TYPE,
                                 v_icc_nue IN GSM_SIMCARD_TO.num_simcard%TYPE,
                                 v_actabo IN GSM_SIMCARD_TO.cod_estado%TYPE );



Procedure P_ERROR_AUC_IC (v_num_solicitud IN GSM_DET_SOLICITUD_AUC_TO.num_seq_solicitud_auc%TYPE);

Procedure P_SERVICIO_MOVIMIENTO(p_Num_Movimiento IN VARCHAR2 ,p_Servicio IN VARCHAR2);

END Gsm_Pac_Auc;
/
SHOW ERRORS
