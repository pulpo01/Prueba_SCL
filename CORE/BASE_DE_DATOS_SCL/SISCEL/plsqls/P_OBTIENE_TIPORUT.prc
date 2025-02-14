CREATE OR REPLACE PROCEDURE p_obtiene_tiporut(
  v_tiprut IN OUT ga_datosgener.cod_tipid_num_ident%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   select cod_tipid_num_ident into v_tiprut
          from ga_datosgener;
EXCEPTION
  when OTHERS then
       v_error := 1;
       v_mensa := '/Error Obtencion Tipo identificacion = RUT/';
END p_obtiene_tiporut;
/
SHOW ERRORS
