CREATE OR REPLACE TRIGGER AL_BEIN_LINORD
BEFORE INSERT ON AL_LINEAS_ORDENES
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

DECLARE
   v_linord al_lineas_ordenes%rowtype ;
begin
   v_linord.num_orden := :new.num_orden;
   v_linord.tip_orden := :new.tip_orden;
   v_linord.num_linea := :new.num_linea;
   v_linord.cod_articulo := :new.cod_articulo;
   v_linord.can_orden := :new.can_orden;
   v_linord.can_servida := :new.can_servida;
   v_linord.cod_causa := :new.cod_causa;
   v_linord.can_series := :new.can_series;
   v_linord.cod_accion := :new.cod_accion;
   v_linord.prc_unidad := :new.prc_unidad;
   v_linord.tip_stock  := :new.tip_stock;
   v_linord.cod_uso    := :new.cod_uso;
   v_linord.cod_estado := :new.cod_estado;
   v_linord.num_linea_ref := :new.num_linea_ref;
   v_linord.tip_movimiento := :new.tip_movimiento;
   v_linord.can_orden_ing := :new.can_orden_ing;
   v_linord.num_desde := :new.num_desde;
   v_linord.num_hasta := :new.num_hasta;
   v_linord.prc_ff := :new.prc_ff;
   v_linord.prc_adic := :new.prc_adic;
   v_linord.num_sec_loca := :new.num_sec_loca;
   v_linord.cod_plaza := :new.cod_plaza; /*AARM, Se Agrega el Cod Plaza*/
   v_linord.cod_metodo_carga := :new.cod_metodo_carga;
   v_linord.cod_grpconcepto := :new.cod_grpconcepto;

   if :new.cod_accion = 1 then
      al_trata_orden.p_insert_linord(v_linord);
   elsif :new.cod_accion = 2 then
         al_trata_orden.p_update_linord(v_linord);
   else
   	   	 al_trata_orden.p_delete_linord(v_linord);
   end if;
   :new.tip_orden := 9;
end;
/
SHOW ERRORS
