CREATE OR REPLACE procedure P_AL_ACTIVA_CENTRAL
(
  v_cen_x IN char ,
  v_cel_x IN char ,
  v_ser_x IN char ,
  v_art_x IN char,
  v_uso_x IN char,
  v_ser_dec_x IN char)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : P_AL_ACTIVA_CENTRAL
-- * Descripcisn        : Proceso para activacion de nzmeros en central
-- * Fecha de creacisn  : Febrero 2000
-- * Responsable        : Thomas Armstrong (DMR Consulting)
-- *************************************************************
  v_actuacion icc_movimiento.cod_actuacion%type;
  v_actuacion_gsm icc_movimiento.cod_actuacion%type;
  v_actuacion_aux icc_movimiento.cod_actuacion%type;
  v_central   icc_movimiento.cod_central%type;
  v_celular   icc_movimiento.num_celular%type;
  v_serie     icc_movimiento.num_serie%type;
  v_terminal  icc_movimiento.tip_terminal%type;
  v_articulo  al_articulos.cod_articulo%type;
  v_error     number(1) := 0;
  v_prefijo   al_usos_min.num_min%type;
  v_serie_dec al_series.num_serie%TYPE;
  v_SimCard   al_tipos_terminales.tip_terminal%TYPE;
BEGIN
  v_central   := to_number(v_cen_x);
  v_celular   := to_number(v_cel_x);
  v_serie     := v_ser_x;
  v_articulo  := to_number(v_art_x);
  v_serie_dec := v_ser_dec_x;

  SELECT val_parametro
  INTO v_SimCard
  FROM ged_parametros
  WHERE cod_producto=1 AND
        cod_modulo='AL' AND
                nom_parametro='COD_SIMCARD_GSM';

  al_pac_numeracion.p_select_actuacion(v_actuacion,v_actuacion_gsm, v_central);
  IF v_terminal=v_SimCard THEN
    v_actuacion_aux:=v_actuacion_gsm;
  ELSE
    v_actuacion_aux:=v_actuacion;
  END IF;
  al_pac_numeracion.p_select_terminal(v_articulo,v_terminal);
  al_pac_numeracion.p_select_prefijo(v_uso_x,v_prefijo);
  -- Este PL no es valido para altas de amistar
  al_pac_numeracion.p_activar_central(v_actuacion_aux,v_central,v_celular,v_serie,v_terminal,v_error,v_prefijo,NULL,NULL,v_serie_dec);
  if v_error <> 0 then
     raise_application_error(-20177,'');
  end if;
END P_AL_ACTIVA_CENTRAL;
/
SHOW ERRORS
