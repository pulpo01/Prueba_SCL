CREATE OR REPLACE TRIGGER SISCEL.al_bede_stock
BEFORE DELETE
ON SISCEL.AL_STOCK
FOR EACH ROW

DECLARE
  v_stock al_stock%rowtype;
BEGIN
--
  v_stock.cod_bodega    := :old.cod_bodega;
  v_stock.tip_stock     := :old.tip_stock;
  v_stock.cod_articulo  := :old.cod_articulo;
  v_stock.cod_uso       := :old.cod_uso;
  v_stock.cod_estado    := :old.cod_estado;
  v_stock.can_stock     := 0;
  v_stock.fec_creacion  := :old.fec_creacion;
  v_stock.num_desde     := :old.num_desde;
  v_stock.num_hasta     := :old.num_hasta;
  al_pro_alarma.p_alarma_stock (v_stock);
--
END;
/
SHOW ERRORS
