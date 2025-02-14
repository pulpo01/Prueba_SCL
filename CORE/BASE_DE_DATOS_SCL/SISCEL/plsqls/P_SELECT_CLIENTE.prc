CREATE OR REPLACE PROCEDURE        p_select_cliente(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_nombre IN OUT ge_clientes.nom_cliente%type ,
  v_tipident IN OUT ge_clientes.cod_tipident%type ,
  v_numident IN OUT ge_clientes.num_ident%type ,
  v_actividad IN OUT ge_clientes.cod_actividad%type ,
  v_telefono IN OUT ge_clientes.tef_cliente1%type ,
  v_fax IN OUT ge_clientes.num_fax%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
-- 22-12 G.R. a?adido apellidos
-- como al_cab_guias.nom_destinatario es varchar2(40)
--, trunco a eso para evitar errores
     select substr(nom_cliente ||' '|| nom_apeclien1 ||'
'|| nom_apeclien2, 1, 40),
     cod_tipident,num_ident,cod_actividad,
          tef_cliente1,num_fax
     into v_nombre,v_tipident,v_numident,v_actividad,
          v_telefono,v_fax
     from ge_clientes
    where cod_cliente = v_cliente;
EXCEPTION
   when OTHERS then
        v_error := 1;
        v_mensa := '/Error Lectura Cliente/';
END p_select_cliente;
/
SHOW ERRORS
