CREATE OR REPLACE PROCEDURE        p_obtiene_direccion(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_direccion IN OUT ge_direcciones.cod_direccion%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
   select cod_direccion
     into v_direccion
     from ga_direccli
    where cod_cliente = v_cliente
      and cod_tipdireccion = 2;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Obtencion Direccion Cliente/';
END p_obtiene_direccion;
/
SHOW ERRORS
