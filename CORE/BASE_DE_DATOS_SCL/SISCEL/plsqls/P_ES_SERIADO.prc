CREATE OR REPLACE PROCEDURE        p_es_seriado(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_ind_seriado IN OUT al_articulos.ind_seriado%type )
IS
BEGIN
   select ind_seriado into v_ind_seriado
          from al_articulos
          where cod_articulo = v_articulo;
EXCEPTION
   when OTHERS then
        raise_application_error (-20193,'Articulo incorrecto '
                                 || to_char(SQLCODE));
END p_es_seriado;
/
SHOW ERRORS
