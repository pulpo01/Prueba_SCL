CREATE OR REPLACE TRIGGER AL_BEIN_SERORD
BEFORE INSERT
ON AL_SERIES_ORDENES
FOR EACH ROW
DECLARE
   v_serord al_series_ordenes%ROWTYPE;
BEGIN
   v_serord.num_orden      := :NEW.num_orden;
   v_serord.tip_orden      := :NEW.tip_orden;
   v_serord.num_linea      := :NEW.num_linea;
   v_serord.num_serie      := :NEW.num_serie;
   v_serord.cod_accion     := :NEW.cod_accion;
   v_serord.num_seriemec   := :NEW.num_seriemec;
   v_serord.cod_producto   := :NEW.cod_producto;
   v_serord.cod_central    := :NEW.cod_central;
   v_serord.cap_code       := :NEW.cap_code;
   v_serord.num_telefono   := :NEW.num_telefono;
   v_serord.cod_subalm     := :NEW.cod_subalm;
   v_serord.cod_cat        := :NEW.cod_cat;
   v_serord.ind_telefono   := :NEW.ind_telefono;
   v_serord.PLAN           := :NEW.PLAN;
   v_serord.carga          := :NEW.carga;
   v_serord.num_sec_loca   := :NEW.num_sec_loca;
   v_serord.a_key          := :NEW.a_key;
   v_serord.chk_digits     := :NEW.chk_digits;
   v_serord.NUM_SUBLOCK    := :NEW.NUM_SUBLOCK;  -- JLR SUBLOCK
   v_serord.COD_HLR        := :NEW.COD_HLR;      -- MLR HLR
   IF :NEW.cod_accion = 1 THEN
      al_trata_orden.p_insert_serord(v_serord);
   ELSIF :NEW.cod_accion = 2 THEN
         al_trata_orden.p_update_serord(v_serord);
   ELSE
  al_trata_orden.p_delete_serord(v_serord);
   END IF;
   :NEW.tip_orden := 9;
   :NEW.num_orden := 99;
END;
/
SHOW ERRORS
