CREATE OR REPLACE PROCEDURE        p_select_serhex(
  v_orden_ing IN al_fic_series.num_orden_ing%type ,
  v_linea_ing IN al_fic_series.num_linea_ing%type ,
  v_serie IN al_fic_series.num_serie%type ,
  v_telefono IN al_fic_series.num_telefono%type ,
  v_serhex IN OUT al_fic_series.num_serhex%type )
IS
BEGIN
  select num_serhex into v_serhex
         from al_fic_series
         where num_orden_ing = v_orden_ing
           and num_linea_ing = v_linea_ing
           and num_serie     = v_serie
           and num_telefono  = v_telefono;
EXCEPTION
  when OTHERS then
       raise_application_error (-20190,'Error captura serie hexadecimal '
                                || to_char(SQLCODE));
END p_select_serhex;
/
SHOW ERRORS
