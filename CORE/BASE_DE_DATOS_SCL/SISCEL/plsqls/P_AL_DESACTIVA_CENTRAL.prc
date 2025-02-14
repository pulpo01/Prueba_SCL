CREATE OR REPLACE procedure P_AL_DESACTIVA_CENTRAL
(
  v_act_x IN char ,
  v_cen_x IN char ,
  v_cel_x IN char ,
  v_ser_x IN char ,
  v_ter_x IN char ,
  v_uso_x IN char ,
  v_ser_dec_x IN char )
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : P_AL_DESACTIVA_CENTRAL
-- * Descripcion        : Proceso para desactivacion de numeros en central
-- * Fecha de creacion  : Febrero 2000
-- * Responsable        : Thomas Armstrong (DMR Consulting)
-- *************************************************************

  v_actuacion icc_movimiento.cod_actuacion%type;
  v_central   icc_movimiento.cod_central%type;
  v_celular   icc_movimiento.num_celular%type;
  v_serie     icc_movimiento.num_serie%type;
  v_terminal  icc_movimiento.tip_terminal%type;
  v_prefijo   al_usos_min.num_min%type;
  v_serie_dec al_series.num_serie%TYPE;
  v_uso       al_usos.COD_USO%TYPE;
BEGIN
  v_actuacion := to_number(v_act_x);
  v_central   := to_number(v_cen_x);
  v_celular   := to_number(v_cel_x);
  v_uso       := to_number(v_uso_x);
  v_serie     := v_ser_x;
  v_terminal  := v_ter_x;
  v_serie_dec := v_ser_dec_x;
  al_pac_numeracion.p_select_prefijo_baja(v_uso,v_serie_dec,v_prefijo);
  al_proc_ingreso.p_desactiva_central(v_actuacion,v_prefijo,v_central,v_celular,v_serie,v_terminal,v_serie_dec);

END P_AL_DESACTIVA_CENTRAL;
/
SHOW ERRORS
