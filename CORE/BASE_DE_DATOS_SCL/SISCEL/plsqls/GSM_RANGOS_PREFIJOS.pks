CREATE OR REPLACE PACKAGE Gsm_Rangos_Prefijos
 IS

   -- Ordena los prefijos asociados a una solicitud --
  PROCEDURE  ORDENA_RANGOS_IMSI (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);

  -- Ordena las icc asociadas a una solicitud --
  PROCEDURE  ORDENA_RANGOS_ICC (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);

  -- Inserta un rango de prefijos--
  PROCEDURE  INSERT_RANGOS_PREFIJO (PREFIJO IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE,
                                                                        MAXIMO  IN GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MAXIMO %TYPE,
                                                                        MINIMO  IN GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_MINIMO%TYPE,
                                                                        INTERVALO IN GSM_RANGOS_PREFIJOS_TO.NUM_VALOR_INTERVALO%TYPE);

  -- Inserta un rango de prefijos por una solicitud--
  PROCEDURE  INSERTA_RANGOS_SOLICITUD (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);

  -- Borra  gsm_rangos_prefijos_to  por un prefijo dado--
  PROCEDURE  DELETE_RANGOS_PREFIJO (PREFIJO IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE);

    -- Borra  simcard asociadas a una solicitud --
  PROCEDURE  ELIMINA_SIMCARD (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);

      -- inserta, ordena prefijos asociados a una solicitud
  PROCEDURE GSM_RANGOS_SIMCARD (V_SIMCARD IN GSM_SIMCARD_TO.NUM_SIMCARD%TYPE);

        -- inserta, ordena prefijos de imsir
  PROCEDURE  INSERTA_IMSIR (PREFIJOGENERADO IN VARCHAR2,RANGO_MIN IN NUMBER,RANGO_MAX IN NUMBER,
                                                    M_SPREFIJOGENERADO IN NUMBER,M_ILARGOIMSIR IN NUMBER );

--- Funcion creada para el proyecto IMSI/IMSIR
  FUNCTION GENERADORARCHIVO (p_prefijo IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE , p_total IN VARCHAR2,
                                                        p_valor_minimo  IN VARCHAR2, v_num_solicitud IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE)  RETURN VARCHAR2;

  FUNCTION GENERA_IMSIR (v_prefijo IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE , v_total IN VARCHAR2,
                                                 v_num_solicitud IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE)  RETURN VARCHAR2;

  PROCEDURE BUSCA_IMSIR (p_ind IN NUMBER, p_prefijo IN GSM_PREFIJO_TO.COD_PREFIJO%TYPE ,  p_total IN NUMBER,
                                                                  p_valor_minimo  IN VARCHAR2, p_num_solicitud IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE,
                                                                  resultado OUT VARCHAR2);

    PROCEDURE AL_BUSCA_DUPLICADOS_PR(en_numsol IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);

--  PROCEDURE  ACTUALIZA_PREFIJOS (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);

--  PROCEDURE  ORDENA_PREFIJOS_SOLICITUD (V_SOLICITUD IN GSM_CABSOL_SIMCARD_TO.NUM_SEQ_SOLICITUD%TYPE);


END Gsm_Rangos_Prefijos;
/
SHOW ERRORS
