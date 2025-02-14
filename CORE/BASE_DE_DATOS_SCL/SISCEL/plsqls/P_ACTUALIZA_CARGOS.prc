CREATE OR REPLACE PROCEDURE        p_actualiza_cargos(
  v_cargo IN ge_cargos.num_cargo%type ,
  v_folio IN al_cab_guias.num_folio%type )
IS
BEGIN
    update ge_cargos
       set num_guia  = v_folio
     where num_cargo = v_cargo;
EXCEPTION
    when OTHERS then
         raise_application_error (-20177,'Error Actualizacion Cargos '
                                  || to_char(SQLCODE));
END p_actualiza_cargos;
/
SHOW ERRORS
