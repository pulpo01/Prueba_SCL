CREATE OR REPLACE PROCEDURE P_AL_ANULA_GUIA(
  v_peticion_x IN char ,
  v_operadora IN al_consumo_documentos.cod_operadora%type,
  v_prefijo IN  al_consumo_documentos.pref_plaza%type,
  v_folio_x IN char ,
  v_usuario_x IN char )
IS
  v_peticion al_interguias.num_peticion%type;
  v_folio    al_consumo_documentos.num_folio%type;
  v_usuario  al_consumo_documentos.usu_consumo%type;
  v_error    al_interguias.cod_retorno%type;
  v_mensa    al_interguias.des_cadena%type;
BEGIN
--
  v_peticion := to_number(v_peticion_x);
  v_folio    := to_number(v_folio_x);
  v_usuario  := v_usuario_x;
  v_error    := 0;
  al_pac_anula_guias.p_anula_guia(v_operadora,
                                  v_prefijo,
                                                                  v_folio,
                                  v_usuario,
                                  v_mensa,
                                  v_error);

  if v_error  = 0 then
     v_mensa := '/Folio Anulado/';
  end if;

  insert into al_interguias (num_peticion,
                             cod_retorno,
                             des_cadena)
                     values (v_peticion,
                             v_error,
                             v_mensa);

EXCEPTION
  when OTHERS then
       raise_application_error (-20177,'Error Generacion Interguias');
--
END P_AL_ANULA_GUIA;
/
SHOW ERRORS
