CREATE OR REPLACE TRIGGER SISCEL.al_bein_stock
BEFORE INSERT
ON SISCEL.AL_STOCK
FOR EACH ROW

DECLARE
  v_stock al_stock%rowtype;
begin
--
-- Asignacion de los valores de la nueva fila a la variable v_stock
--
  v_stock.cod_bodega    := :new.cod_bodega;
  v_stock.tip_stock     := :new.tip_stock;
  v_stock.cod_articulo  := :new.cod_articulo;
  v_stock.cod_uso       := :new.cod_uso;
  v_stock.cod_estado    := :new.cod_estado;
  v_stock.can_stock     := :new.can_stock;
  v_stock.fec_creacion  := :new.fec_creacion;
  v_stock.num_desde     := :new.num_desde;
  v_stock.num_hasta     := :new.num_hasta;
--
-- Llamada al procedimientos de creacion de alarma en caso de que el item de
-- stock generado tenga definido un minimo y este sea mayor a la cantidad de
-- stock creada. (al_stock.can_stock < al_minimos_maximos.can_minima).
--
  al_pro_alarma.p_alarma_stock (v_stock);
end;
/
SHOW ERRORS
