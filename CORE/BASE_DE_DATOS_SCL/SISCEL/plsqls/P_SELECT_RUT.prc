CREATE OR REPLACE PROCEDURE p_select_rut(
  v_rut IN OUT al_cab_guias.num_ident%type )
IS
BEGIN
   select num_ident into v_rut
          from ge_datosgener;
EXCEPTION
   when OTHERS then
         raise_application_error(-20157,'Error Lectura RUT'
                                 || to_char(SQLCODE));
END p_select_rut;
/
SHOW ERRORS
