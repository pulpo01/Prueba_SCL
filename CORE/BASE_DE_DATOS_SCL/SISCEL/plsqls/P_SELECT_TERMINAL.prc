CREATE OR REPLACE PROCEDURE        p_select_terminal(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_terminal IN OUT al_articulos.tip_terminal%type )
IS
BEGIN
   select tip_terminal
          into v_terminal
          from al_articulos
         where cod_articulo = v_articulo;
EXCEPTION
   when OTHERS then
        raise_application_error (-20159,'Error Obtencion Tipo Terminal '
                                 || to_char(SQLCODE));
END p_select_terminal;
/
SHOW ERRORS
