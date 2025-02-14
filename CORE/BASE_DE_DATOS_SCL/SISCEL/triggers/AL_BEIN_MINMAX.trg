CREATE OR REPLACE TRIGGER SISCEL.al_bein_minmax
BEFORE INSERT
ON SISCEL.AL_MINIMOS_MAXIMOS
FOR EACH ROW

DECLARE
  v_minmax al_minimos_maximos%rowtype;
begin
--
-- Asignacion de los valores de la nueva fila a la variable v_minmax
--
   v_minmax.cod_bodega    := :new.cod_bodega;
   v_minmax.tip_stock     := :new.tip_stock;
   v_minmax.cod_articulo  := :new.cod_articulo;
   v_minmax.cod_uso       := :new.cod_uso;
   v_minmax.cod_estado    := :new.cod_estado;
   v_minmax.can_minima    := :new.can_minima;
   v_minmax.can_maxima    := :new.can_maxima;
--
-- Llamada al procedimiento de alarmas para generar una alarma en caso de que
-- la fila generada tenga equivalencia en stock y la cantidad minima definida
-- sea superior a la cantidad en stock existente.
--
   al_pro_alarma.p_alarma_minmax (v_minmax);
end;
/
SHOW ERRORS
