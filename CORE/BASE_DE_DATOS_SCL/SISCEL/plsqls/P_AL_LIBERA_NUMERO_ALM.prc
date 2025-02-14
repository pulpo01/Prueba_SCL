CREATE OR REPLACE PROCEDURE        P_AL_LIBERA_NUMERO_ALM(
  v_numero_x IN char ,
  v_subalm IN char ,
  v_producto_x IN char ,
  v_central_x IN char ,
  v_uso_x IN char ,
  v_cat_x IN char )
IS
  v_reutil  al_celnum_reutil%rowtype;
BEGIN
  v_reutil.num_celular    := to_number(v_numero_x);
  v_reutil.cod_subalm     := v_subalm;
  v_reutil.cod_producto   := to_number(v_producto_x);
  v_reutil.cod_central    := to_number(v_central_x);
  v_reutil.cod_uso        := to_number(v_uso_x);
  v_reutil.cod_cat        := to_number(v_cat_x);
  al_pac_numeracion.p_libera_numero_al (v_reutil);
END P_AL_LIBERA_NUMERO_ALM;
/
SHOW ERRORS
