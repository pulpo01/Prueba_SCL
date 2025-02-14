CREATE OR REPLACE TRIGGER GSM_AFUP_SIMCARD_TG
AFTER UPDATE
ON GSM_SIMCARD_TO
FOR EACH ROW

WHEN (
NEW.COD_ESTADO <> OLD.COD_ESTADO
      )
DECLARE
v_registro  GSM_SIMCARD_TO%ROWTYPE;
BEGIN
  -- Actualizo el Registro.
  v_registro.NUM_SIMCARD        := :OLD.NUM_SIMCARD;
  v_registro.COD_MODULO         := :OLD.COD_MODULO;
  v_registro.COD_ESTADO         := :OLD.COD_ESTADO;
  v_registro.FEC_CREACION       := :OLD.FEC_CREACION;
  v_registro.FEC_ACTUALIZACION  := :OLD.FEC_ACTUALIZACION;
  v_registro.COD_USUARIO        := :OLD.COD_USUARIO;
  v_registro.TIP_AUC            := :OLD.TIP_AUC ;

  UPDATE GSM_SIMCARD_ESTADOS_TO SET FEC_TERMINO_ESTADO = SYSDATE,
                                    FEC_ACTUALIZACION  = SYSDATE,
                                    COD_USUARIO        = USER
  WHERE COD_MODULO  = v_registro.COD_MODULO AND
        COD_ESTADO  = v_registro.COD_ESTADO AND
        NUM_SIMCARD = v_registro.NUM_SIMCARD AND
        FEC_TERMINO_ESTADO IS NULL;
--        FEC_ACTUALIZACION  = v_registro.FEC_ACTUALIZACION AND


  -- Agrego nuevo estado a la tabla de  GSM_SIMCARD_ESTADOS_TO
  v_registro.NUM_SIMCARD        := :NEW.NUM_SIMCARD;
  v_registro.COD_MODULO         := :NEW.COD_MODULO;
  v_registro.COD_ESTADO         := :NEW.COD_ESTADO;
  v_registro.FEC_CREACION       := :NEW.FEC_CREACION;
  v_registro.FEC_ACTUALIZACION  := :NEW.FEC_ACTUALIZACION;
  v_registro.COD_USUARIO        := :NEW.COD_USUARIO;

  INSERT INTO GSM_SIMCARD_ESTADOS_TO (COD_MODULO, COD_ESTADO, NUM_SIMCARD,
                                      FEC_ESTADO, FEC_TERMINO_ESTADO,
                                      FEC_ACTUALIZACION, COD_USUARIO)
  VALUES (v_registro.COD_MODULO, v_registro.COD_ESTADO,
          v_registro.NUM_SIMCARD, SYSDATE, NULL, SYSDATE + 0.00001, USER);

END;
/
SHOW ERRORS
