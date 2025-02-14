CREATE OR REPLACE PROCEDURE P_AL_ASIGNA_NUMEROS_ALMACEN(
  p_subalm IN ge_subalms.cod_subalm%TYPE ,
  p_central IN icg_central.cod_central%TYPE ,
  p_uso IN al_usos.cod_uso%TYPE ,
  p_cat IN ga_catnumer.cod_cat%TYPE ,
  p_cantidad IN ga_celnum_uso.num_libres%TYPE ,
  p_num_sol IN al_reserva_to.num_solicitud%TYPE)
IS
  v_error      PLS_INTEGER;
BEGIN
  v_error:=0;
  al_pac_numeracion.p_asigna_numeracion_almacen (p_subalm,p_central,p_uso,p_cat,p_cantidad,v_error,p_num_sol);
END P_AL_ASIGNA_NUMEROS_ALMACEN;
/
SHOW ERRORS
