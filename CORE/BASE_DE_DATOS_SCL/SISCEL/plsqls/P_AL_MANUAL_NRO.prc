CREATE OR REPLACE PROCEDURE        P_AL_MANUAL_NRO(
  v_numero_x IN char ,
  v_subalm IN char ,
  v_producto_x IN char ,
  v_central_x IN char ,
  v_uso_x IN char ,
  v_cat_x IN char )
IS
  v_numero   al_series.num_telefono%type;
  v_producto al_series.cod_producto%type;
  v_central  al_series.cod_central%type;
  v_uso      al_usos.cod_uso%type;
  v_cat      ga_catnumer.cod_cat%type;
BEGIN
  v_numero     := to_number(v_numero_x);
  v_producto   := to_number(v_producto_x);
  v_central    := to_number(v_central_x);
  v_uso        := to_number(v_uso_x);
  v_cat        := to_number(v_cat_x);
  al_pac_numeracion.p_numero_manual (v_subalm,
                                     v_central,
                                     v_numero,
                                     v_producto,
                                     v_uso,
                                     v_cat);
END P_AL_MANUAL_NRO;
/
SHOW ERRORS
