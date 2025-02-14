CREATE OR REPLACE TRIGGER AL_BEIN_HLINORD
BEFORE INSERT ON AL_HLINEAS_ORDENES
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

DECLARE
   v_hlinord al_hlineas_ordenes%ROWTYPE ;
BEGIN
   v_hlinord.num_orden      := :NEW.num_orden;
   v_hlinord.tip_orden      := :NEW.tip_orden;
   v_hlinord.fec_historico  := :NEW.fec_historico;
   v_hlinord.num_linea      := :NEW.num_linea;
   v_hlinord.cod_articulo   := :NEW.cod_articulo;
   v_hlinord.can_orden      := :NEW.can_orden;
   v_hlinord.can_servida    := :NEW.can_servida;
   v_hlinord.cod_causa      := :NEW.cod_causa;
   DBMS_OUTPUT.PUT_LINE('cod_causa ' || TO_CHAR(:NEW.cod_causa));
   v_hlinord.can_series     := :NEW.can_series;
   v_hlinord.cod_accion     := :NEW.cod_accion;
   v_hlinord.prc_unidad     := :NEW.prc_unidad;
   v_hlinord.tip_stock      := :NEW.tip_stock;
   v_hlinord.cod_uso        := :NEW.cod_uso;
   v_hlinord.cod_estado     := :NEW.cod_estado;
   v_hlinord.num_linea_ref  := :NEW.num_linea_ref;
   v_hlinord.tip_movimiento := :NEW.tip_movimiento;
   v_hlinord.can_orden_ing  := :NEW.can_orden_ing;
   v_hlinord.num_desde      := :NEW.num_desde;
   v_hlinord.num_hasta      := :NEW.num_hasta;
   v_hlinord.prc_ff         := :NEW.prc_ff;
   v_hlinord.prc_adic       := :NEW.prc_adic;
   v_hlinord.cod_plaza      := :NEW.cod_plaza;
   v_hlinord.cod_metodo_Carga      := :NEW.cod_metodo_carga;
   v_hlinord.cod_grpconcepto := :NEW.cod_grpconcepto;
   IF :NEW.cod_accion = 1 THEN
      al_trata_horden.p_insert_hlinord(v_hlinord);
   ELSE
  al_trata_horden.p_delete_hlinord(v_hlinord);
   END IF;
   :NEW.tip_orden := 9;
END;
/
SHOW ERRORS
