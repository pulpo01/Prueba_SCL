CREATE OR REPLACE PROCEDURE        p_obtiene_zonaimpo(
  v_region IN ge_zonaciudad.cod_region%type ,
  v_provincia IN ge_zonaciudad.cod_provincia%type ,
  v_ciudad IN ge_zonaciudad.cod_ciudad%type ,
  v_zonaimpo IN OUT ge_zonaciudad.cod_zonaimpo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   select cod_zonaimpo into v_zonaimpo
     from ge_zonaciudad
    where cod_region    =  v_region
      and cod_provincia =  v_provincia
      and cod_ciudad    =  v_ciudad
      and fec_desde     <= sysdate
      and fec_hasta     >= sysdate;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Obtencion Zona Impositiva/';
END p_obtiene_zonaimpo;
/
SHOW ERRORS
