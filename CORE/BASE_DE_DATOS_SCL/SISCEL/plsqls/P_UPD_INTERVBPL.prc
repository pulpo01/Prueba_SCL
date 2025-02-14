CREATE OR REPLACE PROCEDURE        p_upd_intervbpl(
  v_interfaz IN al_inter_vbpl.num_interfaz%type ,
  v_numero IN al_inter_vbpl.num_telefono%type )
IS
BEGIN
  update al_inter_vbpl
         set num_telefono = v_numero
         where num_interfaz = v_interfaz;
EXCEPTION
   when OTHERS then
        raise_application_error (-20159,'Error Actualizacion Interfaz '
                                 || to_char(SQLCODE));
END p_upd_intervbpl;
/
SHOW ERRORS
