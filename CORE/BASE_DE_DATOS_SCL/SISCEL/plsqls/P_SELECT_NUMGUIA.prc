CREATE OR REPLACE PROCEDURE        p_select_numguia(
  v_guia IN OUT al_cab_guias.num_guia%type ,
  v_fecha IN OUT al_cab_guias.fec_guia%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
IS
BEGIN
  select al_seq_guias.nextval,sysdate
    into v_guia,v_fecha
    from al_datos_generales;
EXCEPTION
  when OTHERS then
       v_error := 1;
       v_mensa := '/Error Obtencion No.Guia/';
END p_select_numguia;
/
SHOW ERRORS
