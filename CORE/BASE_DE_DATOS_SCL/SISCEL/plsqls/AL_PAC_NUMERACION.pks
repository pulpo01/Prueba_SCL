DROP PACKAGE SISCEL.AL_PAC_NUMERACION;

CREATE OR REPLACE PACKAGE SISCEL.Al_PAC_NUMERACION
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : Al_PAC_NUMERACION
-- * Descripcisn        : Rutinas de numeracisn de series
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
  PROCEDURE p_hay_numeros(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_can IN al_lineas_ordenes1.can_orden%TYPE ,
  SN_nro_reutil IN OUT NUMBER ,
  v_nro_uso IN OUT NUMBER ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_hay_numeros_al(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_can IN al_lineas_ordenes1.can_orden%TYPE ,
  SN_nro_reutil IN OUT NUMBER ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_asigna_numeracion(
  TN_orden IN al_lineas_ordenes.num_orden%TYPE ,
  TN_tipo IN al_lineas_ordenes.tip_orden%TYPE ,
  TN_linea IN al_lineas_ordenes.num_linea%TYPE ,
  TEV_subalm IN ge_subalms.cod_subalm%TYPE ,
  TN_central IN icg_central.cod_central%TYPE ,
  TN_uso IN al_usos.cod_uso%TYPE ,
  VN_nro_reutil IN OUT NUMBER ,
  TV_terminal IN al_tipos_terminales.tip_terminal%TYPE ,
  TN_cat IN ga_catnumer.cod_cat%TYPE ,
  VN_error IN OUT NUMBER )
  ;
  PROCEDURE p_asigna_un_numero(
  EV_subalm IN al_series.cod_subalm%TYPE ,
  EN_central IN al_series.cod_central%TYPE ,
  EN_uso IN al_series.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE ,
  EN_numero IN OUT al_series.num_telefono%TYPE )
;
  PROCEDURE p_select_dias(
  v_dias IN OUT ga_datosgener.num_resnum%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_select_celular(
  v_producto IN OUT ge_datosgener.prod_celular%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_cuenta_reutil(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_producto IN ge_datosgener.prod_celular%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_cat IN al_datos_generales.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SN_nro_reutil IN OUT NUMBER )
;
  PROCEDURE p_cuenta_uso(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_producto IN ge_datosgener.prod_celular%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_cat IN al_datos_generales.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  v_nro_uso IN OUT NUMBER )
;
  PROCEDURE p_select_actuacion (
  v_actuacion IN OUT icg_actuacion.cod_actuacion%TYPE,
  v_actuacion_gsm IN OUT icg_actuacion.cod_actuacion%TYPE,
  EN_central_tecno IN      icg_central.cod_central%TYPE)
;
  PROCEDURE p_activar_central(
  v_actuacion IN icc_movimiento.cod_actuacion%TYPE ,
  v_prefijo IN al_usos_min.num_min%TYPE,
  EN_central IN icc_movimiento.cod_central%TYPE ,
  v_celular IN icc_movimiento.num_celular%TYPE ,
  v_serie IN icc_movimiento.num_serie%TYPE ,
  v_terminal IN icc_movimiento.tip_terminal%TYPE ,
  SV_error IN OUT NUMBER,
  v_plan IN icc_movimiento.PLAN%TYPE,
  v_carga IN icc_movimiento.carga%TYPE,
  v_serie_dec IN al_series.num_serie%TYPE,
  v_codactabochip in icc_movimiento.cod_actabo%type default null)
;
  PROCEDURE p_libera_numero(
  v_reutil IN OUT ga_celnum_reutil%ROWTYPE )
;
  PROCEDURE p_libera_numero_al(
  v_reutil IN OUT al_celnum_reutil%ROWTYPE )
;
  PROCEDURE p_numero_manual(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE )
;
  PROCEDURE p_numero_manual_al(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE )
;
  PROCEDURE p_manual_reutil(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_categoria IN al_series.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  v_dias IN al_usos.num_dias_hibernacion%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_manual_uso(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  v_celular IN al_series.num_telefono%TYPE ,
  v_producto IN al_series.cod_producto%TYPE ,
  EN_categoria IN al_series.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_upd_intervbpl(
  v_interfaz IN al_inter_vbpl.num_interfaz%TYPE ,
  EN_numero IN al_inter_vbpl.num_telefono%TYPE )
;
  PROCEDURE p_select_articulo(
  v_orden IN al_lineas_ordenes.num_orden%TYPE ,
  v_tipo IN al_lineas_ordenes.tip_orden%TYPE ,
  EN_linea IN al_lineas_ordenes.num_linea%TYPE ,
  v_articulo IN OUT al_articulos.cod_articulo%TYPE )
;
  PROCEDURE p_select_terminal(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_terminal IN OUT al_articulos.tip_terminal%TYPE )
;
  PROCEDURE p_select_prefijo(
  v_cod_uso IN al_usos.cod_uso%TYPE ,
  v_prefijo IN OUT al_usos_min.num_min%TYPE )
;
  PROCEDURE p_select_prefijo_baja(
  v_cod_uso IN al_usos.cod_uso%TYPE ,
  v_num_serie IN al_series.num_serie%TYPE ,
  v_prefijo IN OUT al_usos_min.num_min%TYPE )
;

PROCEDURE p_asigna_numeracion_almacen(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  EN_cantidad IN NUMBER ,
  SV_error IN OUT NUMBER,
  p_num_sol IN al_reserva_to.num_solicitud%TYPE)
;
PROCEDURE p_desasigna_numeracion_almacen(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  EN_cantidad IN NUMBER ,
  SV_error IN OUT NUMBER,
  p_num_sol IN al_reserva_to.num_solicitud%type)
;
PROCEDURE p_asigna_numero_ordenes(
  v_numeracion IN al_ser_numeracion.num_numeracion%TYPE ,
  EN_linea IN al_ser_numeracion.lin_numeracion%TYPE ,
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SN_nro_reutil IN OUT NUMBER ,
  EN_cat IN ga_catnumer.cod_cat%TYPE ,
  SV_error IN OUT NUMBER )
;
  PROCEDURE p_asigna_un_numero_al(
  EV_subalm IN al_series.cod_subalm%TYPE ,
  EN_central IN al_series.cod_central%TYPE ,
  EN_uso IN al_series.cod_uso%TYPE ,
  EN_cat IN al_series.cod_cat%TYPE ,
  EN_numero IN OUT al_series.num_telefono%TYPE )
;
  PROCEDURE p_cuenta_reutil_al(
  EV_subalm IN ge_subalms.cod_subalm%TYPE ,
  v_producto IN ge_datosgener.prod_celular%TYPE ,
  EN_central IN icg_central.cod_central%TYPE ,
  EN_cat IN al_datos_generales.cod_cat%TYPE ,
  EN_uso IN al_usos.cod_uso%TYPE ,
  SN_nro_reutil IN OUT NUMBER )
;
  PROCEDURE AL_RESERVA_PUNTUAL_PR (
      p_num_celular IN ga_celnum_reutil.num_celular%type,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central IN ga_celnum_reutil.cod_central%type,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%type,
          p_num_sol     IN al_reserva_to.num_solicitud%type,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%type)
;
  PROCEDURE AL_DESRESERVA_PUNTUAL_PR(
      p_num_celular IN ga_celnum_reutil.num_celular%type,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central IN ga_celnum_reutil.cod_central%type,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%type,
          p_num_sol     IN al_reserva_to.num_solicitud%type,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%type)
;
  FUNCTION AL_GENERA_AUDITORIA_FN (
      p_num_celular IN ga_celnum_reutil.num_celular%TYPE,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%TYPE,
          p_cod_central IN ga_celnum_reutil.cod_central%TYPE,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%TYPE,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%TYPE,
          p_fec_baja    IN ga_celnum_reutil.fec_baja%TYPE,
          p_ind_equip   IN ga_celnum_reutil.ind_equipado%TYPE,
          p_cod_producto IN ga_celnum_reutil.cod_producto%TYPE,
          p_num_sol     IN al_reserva_to.num_solicitud%TYPE,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%TYPE,
          p_cod_accion   IN al_reserva_to.cod_accion%TYPE)
          RETURN PLS_INTEGER
;
  PROCEDURE AL_RESERVA_RANGO_PR (
      p_num_desde   IN ga_celnum_uso.num_desde%type,
      p_num_hasta   IN ga_celnum_uso.num_hasta%type,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central IN ga_celnum_reutil.cod_central%type,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%type,
          p_cantidad    IN ga_celnum_uso.num_libres%type,
          p_num_sol     IN al_reserva_to.num_solicitud%type)
;
  PROCEDURE AL_DESRESERVA_RANGO_PR (
      p_num_desde   IN ga_celnum_uso.num_desde%type,
      p_num_hasta   IN ga_celnum_uso.num_hasta%type,
          p_cod_subalm  IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central IN ga_celnum_reutil.cod_central%type,
          p_cod_cat     IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso     IN ga_celnum_reutil.cod_uso%type,
          p_cantidad    IN ga_celnum_uso.num_libres%type,
          p_num_sol     IN al_reserva_to.num_solicitud%type)
;

  PROCEDURE AL_VALIDA_RESERVA_PR (
          p_cod_subalm   IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central  IN ga_celnum_reutil.cod_central%type,
          p_cod_cat      IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso      IN ga_celnum_reutil.cod_uso%type,
          p_num_sol      IN al_reserva_to.num_solicitud%type,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%type)
;
  PROCEDURE AL_VALIDA_DESRESERVA_PR (
          p_cod_subalm   IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central  IN ga_celnum_reutil.cod_central%type,
          p_cod_cat      IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso      IN ga_celnum_reutil.cod_uso%type,
          p_num_sol      IN al_reserva_to.num_solicitud%type,
          p_tipo_proceso IN al_reserva_to.tipo_proceso%type)
;

 PROCEDURE AL_GRABA_ERROR_RESERVA_PR (
          p_num_celular  IN ga_celnum_reutil.num_celular%type,
      p_num_sol      IN al_reserva_to.num_solicitud%type,
          p_cod_error    IN PLS_INTEGER)
;
  PROCEDURE AL_RESERVA_MASIVA_PR (
      p_num_celular       IN ga_celnum_reutil.num_celular%type,
          p_cod_subalm        IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central       IN ga_celnum_reutil.cod_central%type,
          p_cod_cat           IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso               IN ga_celnum_reutil.cod_uso%type,
          p_cod_producto      IN ga_celnum_reutil.cod_producto%type,
          v_fecha_baja        IN  ga_celnum_reutil.fec_baja%type,
      v_ind_equipado      IN ga_celnum_reutil.ind_equipado%type,
          p_num_sol           IN al_reserva_to.num_solicitud%type,
          p_tipo_proceso      IN al_reserva_to.tipo_proceso%type,
      v_DiasHibernacion   IN al_usos.num_dias_hibernacion%type,
      EN_uso_sin_uso      IN al_usos.cod_uso%type,
          v_cod_accion        IN PLS_INTEGER)
;
PROCEDURE AL_DESRESERVA_MASIVA_PR (
      p_num_celular      IN ga_celnum_reutil.num_celular%type,
          p_cod_subalm       IN ga_celnum_reutil.cod_subalm%type,
          p_cod_central      IN ga_celnum_reutil.cod_central%type,
          p_cod_cat          IN ga_celnum_reutil.cod_cat%type,
          p_cod_uso          IN ga_celnum_reutil.cod_uso%type,
          p_cod_producto     IN ga_celnum_reutil.cod_producto%type,
          v_fecha_baja       IN  ga_celnum_reutil.fec_baja%type,
      v_ind_equipado     IN ga_celnum_reutil.ind_equipado%type,
          p_num_sol          IN al_reserva_to.num_solicitud%type,
          p_tipo_proceso     IN al_reserva_to.tipo_proceso%type,
      v_DiasHibernacion  IN al_usos.num_dias_hibernacion%type,
      EN_uso_sin_uso     IN al_usos.cod_uso%type,
          v_cod_accion       IN PLS_INTEGER)
;
PROCEDURE AL_ASIGNA_NRO_ENTRADA_EXTRA_PR (
  EV_num_extra            IN al_ser_es_extras.num_extra%TYPE ,
  EN_linea                            IN al_ser_es_extras.num_linea%TYPE ,
  EV_subalm                       IN ge_subalms.cod_subalm%TYPE ,
  EN_central                      IN icg_central.cod_central%TYPE ,
  EN_uso                                  IN al_usos.cod_uso%TYPE ,
  EN_cat                                  IN ga_catnumer.cod_cat%TYPE ,
  SN_nro_reutil                   IN OUT NOCOPY PLS_INTEGER ,
  SV_error                                IN OUT NOCOPY PLS_INTEGER )
;
PROCEDURE AL_HAY_NUMERO_ENTRADA_EXTRA_PR(
  EV_subalm   IN ge_subalms.cod_subalm%TYPE ,
  EN_central  IN icg_central.cod_central%TYPE ,
  EN_uso      IN al_usos.cod_uso%TYPE ,
  EN_can      IN al_lineas_ordenes1.can_orden%TYPE ,
  EN_cat      IN ga_catnumer.cod_cat%TYPE
 )
;
PROCEDURE AL_UN_NRO_ENTRADA_EXTRA_PR(
  EV_subalm  IN al_series.cod_subalm%TYPE ,
  EN_central IN al_series.cod_central%TYPE ,
  EN_uso     IN al_series.cod_uso%TYPE ,
  EN_cat     IN al_series.cod_cat%TYPE ,
  EN_numero  IN OUT NOCOPY al_series.num_telefono%TYPE
  )
 ;
 PROCEDURE AL_ASIGNA_NUMERO_EXTRA_PR(
  EN_interfaz IN al_inter_vbpl.num_interfaz%TYPE,
  EV_subalm   IN al_series.cod_subalm%TYPE ,
  EN_central  IN al_series.cod_central%TYPE ,
  EN_uso      IN al_series.cod_uso%TYPE ,
  EN_cat      IN al_series.cod_cat%TYPE )
;
PROCEDURE p_audit_insert_celnumuso(  v_audit_ser_to IN OUT al_audit_celnum_uso_to%ROWTYPE );

PROCEDURE p_audit_insert_celnumreutil(v_audit_ser_to IN OUT al_audit_celnum_reutil_to%ROWTYPE );

END Al_PAC_NUMERACION;
/

CREATE OR REPLACE PUBLIC SYNONYM AL_PAC_NUMERACION FOR SISCEL.AL_PAC_NUMERACION;


GRANT EXECUTE ON SISCEL.AL_PAC_NUMERACION TO EBZ_SISCEL;

GRANT EXECUTE ON SISCEL.AL_PAC_NUMERACION TO SATELITES;

GRANT EXECUTE ON SISCEL.AL_PAC_NUMERACION TO SISCEL_ADMIN;

GRANT EXECUTE ON SISCEL.AL_PAC_NUMERACION TO SISCEL_AL;

GRANT EXECUTE ON SISCEL.AL_PAC_NUMERACION TO SISCEL_FA;

GRANT EXECUTE ON SISCEL.AL_PAC_NUMERACION TO SISCEL_SELECT;
