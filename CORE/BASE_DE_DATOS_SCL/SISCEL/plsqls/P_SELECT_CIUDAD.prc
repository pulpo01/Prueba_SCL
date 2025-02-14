CREATE OR REPLACE PROCEDURE        p_select_ciudad(
  v_region IN ge_direcciones.cod_direccion%type ,
  v_provincia IN ge_direcciones.cod_provincia%type ,
  v_ciudad IN ge_direcciones.cod_ciudad%type ,
  v_desciu IN OUT al_cab_guias.des_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
  select des_ciudad
    into v_desciu
    from ge_ciudades
   where cod_region = v_region
     and cod_provincia = v_provincia
     and cod_ciudad = v_ciudad;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Lectura Ciudades/';
END p_select_ciudad;
/
SHOW ERRORS
