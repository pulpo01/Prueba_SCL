CREATE OR REPLACE PROCEDURE        p_genera_linea(
  v_linguia IN al_lin_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   insert into al_lin_guias (num_guia,
                             lin_guia,
                             cod_articulo,
                             des_articulo,
                             can_articulo,
                             num_serie,
                             cod_moneda,
                             val_articulo,
                             num_cargo)
                     values (v_linguia.num_guia,
                             v_linguia.lin_guia,
                             v_linguia.cod_articulo,
                             v_linguia.des_articulo,
                             v_linguia.can_articulo,
                             v_linguia.num_serie,
                             v_linguia.cod_moneda,
                             v_linguia.val_articulo,
                             v_linguia.num_cargo);
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error al Generar Lineas Guias/';
END p_genera_linea;
/
SHOW ERRORS
