CREATE OR REPLACE PROCEDURE        p_obtiene_catimpos(
  v_cliente IN ge_catimpclientes.cod_cliente%type ,
  v_catimpos IN OUT ge_catimpclientes.cod_catimpos%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   select cod_catimpos into v_catimpos
     from ge_catimpclientes
    where cod_cliente =  v_cliente
      and fec_desde   <= sysdate
      and fec_hasta   >= sysdate;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Obtencion Categoria Impositiva Cliente/' ||
                   to_char(SQLCODE);
END p_obtiene_catimpos;
/
SHOW ERRORS
