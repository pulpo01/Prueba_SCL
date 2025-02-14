CREATE OR REPLACE TRIGGER AL_AFUP_CABORD1
AFTER UPDATE
ON AL_CABECERA_ORDENES1
FOR EACH ROW
 
WHEN (NEW.COD_ESTADO = 'CE')
DECLARE
 v_cabord1       al_cabecera_ordenes1%ROWTYPE;
 v_fec_historico DATE := SYSDATE;
BEGIN
 v_cabord1.num_orden       := :NEW.num_orden;
 v_cabord1.num_orden_sap       := :NEW.num_orden_sap;
 v_cabord1.tip_orden       := :NEW.tip_orden;
 v_cabord1.cod_bodega      := :NEW.cod_bodega;
   v_cabord1.cod_proveedor   := :NEW.cod_proveedor;
 v_cabord1.fec_creacion    := :NEW.fec_creacion;
 v_cabord1.cod_sector      := :NEW.cod_sector;
 v_cabord1.cod_transp      := :NEW.cod_transp;
 v_cabord1.tip_pedido      := :NEW.tip_pedido;
 v_cabord1.fec_autoriza    := :NEW.fec_autoriza;
 v_cabord1.fec_embarque    := :NEW.fec_embarque ;
 v_cabord1.fec_arribo      := :NEW.fec_arribo;
 v_cabord1.cod_moneda      := :NEW.cod_moneda;
 v_cabord1.cod_estado      := :NEW.cod_estado;
 v_cabord1.pct_iva         := :NEW.pct_iva;
 v_cabord1.tot_arancel_est := :NEW.tot_arancel_est;
 v_cabord1.tot_flete_est   := :NEW.tot_flete_est;
 v_cabord1.tip_orden_ref   := :NEW.tip_orden_ref;
 v_cabord1.num_orden_ref   := :NEW.num_orden_ref;
 v_cabord1.usu_creacion    := :NEW.usu_creacion;
 v_cabord1.usu_autoriza    := :NEW.usu_autoriza;
 v_cabord1.num_orden_prov  := :NEW.num_orden_prov;
 v_cabord1.cod_grpconcepto := :NEW.cod_grpconcepto;
   AL_PASOHIS_ORD.p_pasohis_ord(v_cabord1,
                        v_fec_historico);
--
END;
/
SHOW ERRORS