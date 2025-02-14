CREATE OR REPLACE PROCEDURE        p_actualiza_cargo(
  v_cargo IN ge_cargos.num_cargo%type ,
  v_guia IN al_cab_guias.num_guia%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   update ge_cargos
      set num_preguia = v_guia
    where num_cargo = v_cargo;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Actualizacion Cargo/';
END p_actualiza_cargo;
/
SHOW ERRORS
