CREATE OR REPLACE PROCEDURE        P_AL_ASIGNA_NUMERO(
  v_interfaz_x IN char ,
  v_subalm IN char ,
  v_central_x IN char ,
  v_uso_x IN char ,
  v_cat_x IN char )
IS
  v_central    icg_central.cod_central%type;
  v_uso        al_usos.cod_uso%type;
  v_interfaz   al_inter_vbpl.num_interfaz%type;
  v_numero     al_series.num_telefono%type;
  v_cat        ga_catnumer.cod_cat%type;
BEGIN
  v_central    := to_number(v_central_x);
  v_uso        := to_number(v_uso_x);
  v_interfaz   := to_number(v_interfaz_x);
  v_cat        := to_number(v_cat_x);
  al_pac_numeracion.p_asigna_un_numero (v_subalm,
                                        v_central,
                                        v_uso,
                                        v_cat,
                                        v_numero);
  al_pac_numeracion.p_upd_intervbpl(v_interfaz,
                                    v_numero);
END P_AL_ASIGNA_NUMERO;
/
SHOW ERRORS
