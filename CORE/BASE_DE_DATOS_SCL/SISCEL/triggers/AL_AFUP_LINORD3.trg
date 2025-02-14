CREATE OR REPLACE TRIGGER al_afup_linord3
AFTER UPDATE
ON AL_LINEAS_ORDENES3
FOR EACH ROW

WHEN (
NEW.CAN_ORDEN <> OLD.CAN_ORDEN
      )
DECLARE
 v_orden       al_lineas_ordenes3.num_orden%type;
 v_tstock      al_lineas_ordenes3.tip_stock%type;
 v_articulo    al_lineas_ordenes3.cod_articulo%type;
 v_uso         al_lineas_ordenes3.cod_uso%type;
 v_estado      al_lineas_ordenes3.cod_estado%type;
 v_can_old     al_lineas_ordenes3.can_orden%type;
 v_can_new     al_lineas_ordenes3.can_orden%type;
 v_tipmovim    al_lineas_ordenes3.tip_movimiento%type;
 v_desde_old   al_lineas_ordenes3.num_desde%type;
 v_desde_new   al_lineas_ordenes3.num_desde%type;
 v_hasta_old   al_lineas_ordenes3.num_hasta%type;
 v_hasta_new   al_lineas_ordenes3.num_hasta%type;
 LN_prc_unidad al_lineas_ordenes3.prc_unidad%type;

BEGIN
--
 v_orden      := :new.num_orden;
 v_tstock     := :new.tip_stock;
 v_articulo   := :new.cod_articulo;
 v_uso        := :new.cod_uso;
 v_estado     := :new.cod_estado;
 v_can_old    := :old.can_orden;
 v_can_new    := :new.can_orden;
 v_tipmovim   := :new.tip_movimiento;
 v_desde_old  := :old.num_desde;
 v_desde_new  := :new.num_desde;
 v_hasta_old  := :old.num_hasta;
 v_hasta_new  := :new.num_hasta;
 LN_prc_unidad:= :new.prc_unidad;
 al_proc_devolucion.p_cambio_cantidad(v_orden,v_tstock,v_articulo,v_uso,v_estado,
 									  v_can_old,v_can_new,v_tipmovim,v_desde_old,
									  v_desde_new,v_hasta_old,v_hasta_new,LN_prc_unidad);
END;
/
SHOW ERRORS
