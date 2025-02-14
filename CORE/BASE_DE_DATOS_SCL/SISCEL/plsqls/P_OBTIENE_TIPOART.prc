CREATE OR REPLACE PROCEDURE        p_obtiene_tipoart(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_tipo IN OUT al_articulos.tip_articulo%type )
IS
BEGIN
   select tip_articulo into v_tipo
          from al_articulos
          where cod_articulo = v_articulo;
EXCEPTION
   when OTHERS then
       raise_application_error (-20139,'<ALMACEN> Articulos '
                               || to_char(SQLCODE));
END p_obtiene_tipoart;
/
SHOW ERRORS
