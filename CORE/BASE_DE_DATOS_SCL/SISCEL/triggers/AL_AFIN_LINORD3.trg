CREATE OR REPLACE TRIGGER al_afin_linord3
AFTER INSERT
ON AL_LINEAS_ORDENES3
FOR EACH ROW
DECLARE
 v_orden       al_lineas_ordenes3.num_orden%type;
 LN_linea      al_lineas_ordenes3.num_linea%type;
 v_tstock      al_lineas_ordenes3.tip_stock%type;
 v_articulo    al_lineas_ordenes3.cod_articulo%type;
 v_uso         al_lineas_ordenes3.cod_uso%type;
 v_estado      al_lineas_ordenes3.cod_estado%type;
 v_cantidad    al_lineas_ordenes3.can_orden%type;
 v_tipmovim    al_lineas_ordenes3.tip_movimiento%type;
 v_numdesde    al_lineas_ordenes3.num_desde%type;
 v_numhasta    al_lineas_ordenes3.num_hasta%type;
BEGIN
--
   v_orden     := :new.num_orden;
   LN_linea    := :new.num_linea;
   v_tstock    := :new.tip_stock;
   v_articulo  := :new.cod_articulo;
   v_uso       := :new.cod_uso;
   v_estado    := :new.cod_estado;
   v_cantidad  := :new.can_orden;
   v_tipmovim  := :new.tip_movimiento;
   v_numdesde  := :new.num_desde;
   v_numhasta  := :new.num_hasta;


   al_proc_devolucion.p_inserta_linea(v_orden,LN_linea,v_tstock,v_articulo,v_uso,
                                      v_estado,v_cantidad,v_tipmovim,v_numdesde,v_numhasta);
END;
/
SHOW ERRORS
