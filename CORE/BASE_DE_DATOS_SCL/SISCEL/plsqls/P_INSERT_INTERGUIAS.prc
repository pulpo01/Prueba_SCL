CREATE OR REPLACE PROCEDURE        p_insert_interguias(
  v_inter IN al_interguias%rowtype )
IS
BEGIN
    insert into al_interguias (num_peticion,
                               cod_retorno,
                               des_cadena)
                       values (v_inter.num_peticion,
                               v_inter.cod_retorno,
                               v_inter.des_cadena);
EXCEPTION
   when others then
        raise_application_error (-20177,'Error Insert en INTERGUIAS');
END p_insert_interguias;
/
SHOW ERRORS
