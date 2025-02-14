CREATE OR REPLACE TRIGGER GSM_AFIN_SOL_AUC_TG
AFTER UPDATE
ON GSM_SOLICITUD_AUC_TO
FOR EACH ROW
             
WHEN ( NEW.COD_ESTADO = 'CE'   AND   NEW.COD_ESTADO <> OLD.COD_ESTADO )
declare
  v_solicitud_auc  GSM_SOLICITUD_AUC_TO%rowtype;
begin
        v_solicitud_auc.NUM_SEQ_SOLICITUD_AUC   :=  :new.NUM_SEQ_SOLICITUD_AUC;
        v_solicitud_auc.NUM_SEQ_SOLICITUD               :=      :new.NUM_SEQ_SOLICITUD;
        v_solicitud_auc.NUM_CANTIDAD                    :=      :new.NUM_CANTIDAD;
        v_solicitud_auc.COD_ESTADO                      :=      :new.COD_ESTADO;
        v_solicitud_auc.FEC_ACTUALIZACION               :=      :new.FEC_ACTUALIZACION;
        v_solicitud_auc.COD_USUARIO                     :=      :new.COD_USUARIO;
        v_solicitud_auc.NUM_INTENTOS                    :=      :new.NUM_INTENTOS;
        GSM_PAC_AUC.P_INSERTA_ICC(v_solicitud_auc);
END;
/
SHOW ERRORS
