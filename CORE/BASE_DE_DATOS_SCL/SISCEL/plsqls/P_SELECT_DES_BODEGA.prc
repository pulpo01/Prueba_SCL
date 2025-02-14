CREATE OR REPLACE PROCEDURE        p_select_des_bodega(
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_descr IN OUT al_bodegas.des_bodega%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   select des_bodega
     into v_descr
     from al_bodegas
    where cod_bodega = v_bodega;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Obtencion Descripcion Bodega/';
END p_select_des_bodega;
/
SHOW ERRORS
