CREATE OR REPLACE TRIGGER AL_BEIN_CABORD
BEFORE INSERT
ON AL_CABECERA_ORDENES
FOR EACH ROW

DECLARE
  v_cabord al_cabecera_ordenes%rowtype;
BEGIN
--
  v_cabord.num_orden       := :new.num_orden;
  v_cabord.num_orden_sap   := :new.num_orden_Sap;
  v_cabord.tip_orden       := :new.tip_orden;
  v_cabord.cod_proveedor   := :new.cod_proveedor;
  v_cabord.cod_bodega      := :new.cod_bodega;
  v_cabord.fec_creacion    := :new.fec_creacion;
  v_cabord.cod_sector      := :new.cod_sector;
  v_cabord.cod_transp      := :new.cod_transp;
  v_cabord.tip_pedido      := :new.tip_pedido;
  v_cabord.fec_autoriza    := :new.fec_autoriza;
  v_cabord.fec_embarque    := :new.fec_embarque;
  v_cabord.fec_arribo      := :new.fec_arribo;
  v_cabord.cod_moneda      := :new.cod_moneda;
  v_cabord.cod_estado      := :new.cod_estado;
  v_cabord.pct_iva         := :new.pct_iva;
  v_cabord.tot_arancel_est := :new.tot_arancel_est;
  v_cabord.tot_flete_est   := :new.tot_flete_est;
  v_cabord.tot_seguro_est  := :new.tot_seguro_est;
  v_cabord.tip_orden_ref   := :new.tip_orden_ref;
  v_cabord.num_orden_ref   := :new.num_orden_ref;
  v_cabord.usu_creacion    := :new.usu_creacion;
  v_cabord.usu_autoriza    := :new.usu_autoriza;
  v_cabord.cod_accion      := :new.cod_accion;
  v_cabord.num_orden_prov  := :new.num_orden_prov;
  v_cabord.tip_numeracion  := :new.tip_numeracion;
  v_cabord.plan            := :new.plan;
  v_cabord.carga           := :new.carga;
  v_cabord.cod_grpconcepto := :new.cod_grpconcepto;

  if :new.cod_accion = 1 then
     al_trata_orden.p_insert_cabord(v_cabord);
  elsif :new.cod_accion = 2 then
        al_trata_orden.p_update_cabord(v_cabord);
  else
     al_trata_orden.p_delete_cabord(v_cabord);
  end if;
  :new.tip_orden := 9;
--
END;
/
SHOW ERRORS