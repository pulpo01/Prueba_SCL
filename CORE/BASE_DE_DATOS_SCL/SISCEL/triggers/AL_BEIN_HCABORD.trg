CREATE OR REPLACE TRIGGER AL_BEIN_HCABORD
BEFORE INSERT
ON SISCEL.AL_HCABECERA_ORDENES
FOR EACH ROW
DECLARE
  v_hcabord al_hcabecera_ordenes%ROWTYPE;
BEGIN
  v_hcabord.num_orden := :NEW.num_orden;
  v_hcabord.num_orden_sap := :NEW.num_orden_sap;
  v_hcabord.tip_orden := :NEW.tip_orden;
  v_hcabord.fec_historico := :NEW.fec_historico;
  v_hcabord.cod_proveedor := :NEW.cod_proveedor;
  v_hcabord.cod_bodega := :NEW.cod_bodega;
  v_hcabord.fec_creacion := :NEW.fec_creacion;
  v_hcabord.cod_sector := :NEW.cod_sector;
  v_hcabord.cod_transp := :NEW.cod_transp;
  v_hcabord.tip_pedido := :NEW.tip_pedido;
  v_hcabord.fec_autoriza := :NEW.fec_autoriza;
  v_hcabord.fec_embarque := :NEW.fec_embarque;
  v_hcabord.fec_arribo := :NEW.fec_arribo;
  v_hcabord.cod_moneda := :NEW.cod_moneda;
  v_hcabord.cod_estado := :NEW.cod_estado;
  v_hcabord.pct_iva := :NEW.pct_iva;
  v_hcabord.tot_arancel_est := :NEW.tot_arancel_est;
  v_hcabord.tot_flete_est := :NEW.tot_flete_est;
  v_hcabord.tot_seguro_est := :NEW.tot_seguro_est;
  v_hcabord.tip_orden_ref := :NEW.tip_orden_ref;
  v_hcabord.num_orden_ref := :NEW.num_orden_ref;
  v_hcabord.usu_creacion := :NEW.usu_creacion;
  v_hcabord.usu_autoriza := :NEW.usu_autoriza;
  v_hcabord.cod_accion := :NEW.cod_accion;
  v_hcabord.num_orden_prov := :NEW.num_orden_prov;
  v_hcabord.tip_numeracion  := :NEW.tip_numeracion;
  v_hcabord.PLAN            := :NEW.PLAN;
  v_hcabord.carga           := :NEW.carga;
  v_hcabord.cod_grpconcepto := :NEW.cod_grpconcepto;
  IF :NEW.cod_accion = 1 THEN
     al_trata_horden.p_insert_hcabord(v_hcabord);
  ELSE
     al_trata_horden.p_delete_hcabord(v_hcabord);
  END IF;
:NEW.tip_orden := 9;
END;
/
SHOW ERRORS
