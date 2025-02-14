CREATE OR REPLACE TRIGGER SISCEL.al_beup_stock
BEFORE UPDATE
ON SISCEL.AL_STOCK
FOR EACH ROW

DECLARE
  v_stock al_stock%rowtype;
BEGIN
  v_stock.cod_bodega    := :new.cod_bodega;
  v_stock.tip_stock     := :new.tip_stock;
  v_stock.cod_articulo  := :new.cod_articulo;
  v_stock.cod_uso       := :new.cod_uso;
  v_stock.cod_estado    := :new.cod_estado;
  v_stock.can_stock     := :new.can_stock;
  v_stock.fec_creacion  := :new.fec_creacion;
  v_stock.num_desde     := :new.num_desde;
  v_stock.num_hasta     := :new.num_hasta;
  al_pro_alarma.p_alarma_stock (v_stock);
end;
/
SHOW ERRORS
