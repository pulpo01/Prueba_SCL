CREATE OR REPLACE TRIGGER SISCEL.al_afde_linord3
AFTER DELETE
ON SISCEL.AL_LINEAS_ORDENES3
FOR EACH ROW

DECLARE
 v_orden    al_lineas_ordenes3.num_orden%type;
 v_tstock   al_lineas_ordenes3.tip_stock%type;
 v_articulo al_lineas_ordenes3.cod_articulo%type;
 v_uso      al_lineas_ordenes3.cod_uso%type;
 v_estado   al_lineas_ordenes3.cod_estado%type;
   v_cantidad al_lineas_ordenes3.can_orden%type;
   v_tipmovim al_lineas_ordenes3.tip_movimiento%type;
   v_numdesde al_lineas_ordenes3.num_desde%type;
   v_numhasta al_lineas_ordenes3.num_hasta%type;
BEGIN
--
   v_orden     := :old.num_orden;
 v_tstock  := :old.tip_stock;
 v_articulo := :old.cod_articulo;
 v_uso   := :old.cod_uso;
 v_estado  := :old.cod_estado;
 v_cantidad := :old.can_orden;
   v_tipmovim  := :old.tip_movimiento;
   v_numdesde  := :old.num_desde;
   v_numhasta  := :old.num_hasta;
   al_proc_devolucion.p_borrado_linord3(v_orden,
                                        v_tstock,
      		   v_articulo,
                                        v_uso,
                                        v_estado,
                                        v_cantidad,
                                        v_tipmovim,
                                        v_numdesde,
                                        v_numhasta);
END;
/
SHOW ERRORS
