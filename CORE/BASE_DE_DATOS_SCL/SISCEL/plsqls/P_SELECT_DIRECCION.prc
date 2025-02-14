CREATE OR REPLACE PROCEDURE        p_select_direccion(
  v_direccion IN ge_direcciones.cod_direccion%type ,
  v_desdirec IN OUT al_cab_guias.des_direccion%type ,
  v_region IN OUT ge_direcciones.cod_region%type ,
  v_provincia IN OUT ge_direcciones.cod_provincia%type ,
  v_ciudad IN OUT ge_direcciones.cod_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   select nom_calle || ' ' || num_calle ||', '|| num_piso,
          cod_region,cod_provincia,cod_ciudad
     into v_desdirec,v_region,v_provincia,v_ciudad
     from ge_direcciones
    where cod_direccion = v_direccion;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Lectura Direcciones/';
END p_select_direccion;
/
SHOW ERRORS
