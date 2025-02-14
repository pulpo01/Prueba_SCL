CREATE OR REPLACE PROCEDURE        p_actualiza_cantidad(
  v_orden_ing IN al_lineas_ordenes.num_orden%type ,
  v_linea_ing IN al_lineas_ordenes.num_linea%type ,
  v_orden IN al_lineas_ordenes.num_orden%type ,
  v_tipo IN al_lineas_ordenes.tip_orden%type ,
  v_linea IN al_lineas_ordenes.num_linea%type ,
  v_cant IN al_lineas_ordenes.can_orden%type )
IS
BEGIN
   if v_tipo = 1 then
      delete al_fic_series
             where num_orden_ing = v_orden_ing
               and num_linea_ing = v_linea_ing;
      if SQL%FOUND then
         update al_lineas_ordenes1
            set can_servida     = nvl(can_servida,0) + v_cant,
                can_orden_ing   = can_orden_ing - v_cant,
                can_series      = can_series - v_cant
                where num_orden = v_orden
                  and tip_orden = v_tipo
                  and num_linea = v_linea;
      else
          update al_lineas_ordenes1
             set can_servida     = nvl(can_servida,0) + v_cant,
                 can_orden_ing   = can_orden_ing - v_cant
                 where num_orden = v_orden
                   and tip_orden = v_tipo
                   and num_linea = v_linea;
      end if;
   else
 -- se trata de devolucion al proveedor, tip_orden=3
      update al_lineas_ordenes3
         set can_servida     = nvl(can_servida,0) + v_cant,
             can_orden_ing   = can_orden_ing - v_cant
             where num_orden = v_orden
               and tip_orden = v_tipo
               and num_linea = v_linea;
   end if;
EXCEPTION
 when OTHERS then
        raise_application_error (-20171,
                      '<ALMACEN> Error actualizacion Orden de Compra ' ||
                       to_char(SQLCODE));
END p_actualiza_cantidad;
/
SHOW ERRORS
