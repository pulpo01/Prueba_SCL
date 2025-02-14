CREATE OR REPLACE PROCEDURE        p_select_articulo(
  v_orden IN al_lineas_ordenes.num_orden%type ,
  v_tipo IN al_lineas_ordenes.tip_orden%type ,
  v_linea IN al_lineas_ordenes.num_linea%type ,
  v_articulo IN OUT al_articulos.cod_articulo%type )
IS
BEGIN
   select cod_articulo
          into v_articulo
          from al_vlineas_ordenes
         where num_orden = v_orden
           and tip_orden = v_tipo
           and num_linea = v_linea;
EXCEPTION
   when OTHERS then
        raise_application_error (-20159,'Error Obtencion Articulo '
                                 || to_char(SQLCODE));
END p_select_articulo;
/
SHOW ERRORS
