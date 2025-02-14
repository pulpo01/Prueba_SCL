CREATE OR REPLACE PROCEDURE        p_select_giro(
  v_actividad IN ge_actividades.cod_actividad%type ,
  v_giro IN OUT ge_actividades.des_actividad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
    select des_actividad
      into v_giro
      from ge_actividades
     where cod_actividad = v_actividad;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Obtencion Giro/';
END p_select_giro;
/
SHOW ERRORS
