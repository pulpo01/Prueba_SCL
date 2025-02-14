CREATE OR REPLACE PROCEDURE        P_GA_INTERAL
(
  v_transac_x IN char ,
  v_tipo_x IN char ,
  v_tipstock_x IN char ,
  v_bodega_x IN char ,
  v_articulo_x IN char ,
  v_uso_x IN char ,
  v_estado_x IN char ,
  v_venta_x IN char ,
  v_cantid_x IN char ,
  v_serie_x IN char ,
  v_indtel_x IN char )
IS
  v_interal   ga_pac_interal.type_inter;
BEGIN
  v_interal.tipo      := to_number(v_tipo_x);
  v_interal.tipstock  := to_number(v_tipstock_x);
  v_interal.bodega    := to_number(v_bodega_x);
  v_interal.articulo  := to_number(v_articulo_x);
  v_interal.uso       := to_number(v_uso_x);
  v_interal.estado    := to_number(v_estado_x);
  v_interal.venta     := to_number(nvl(v_venta_x,'0'));
  v_interal.cantid    := to_number(v_cantid_x);
  v_interal.serie     := v_serie_x;
  v_interal.indtel    := to_number(v_indtel_x);
  v_interal.transac   := to_number(v_transac_x);
  v_interal.error     := 0;
  v_interal.central   := null;
  v_interal.subalm    := null;
  v_interal.celular   := null;
  v_interal.cat       := null;
  ga_pac_interal.p_trata_interfaz(v_interal);
END P_GA_INTERAL;
/
SHOW ERRORS
