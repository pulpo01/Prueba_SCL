CREATE OR REPLACE PACKAGE AL_PAC_VALIDACIONES IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PAC_VALIDACIONES
-- * Descripcisn        : Rutinas de recuperacisn de datos genericos
-- * Fecha de creacisn  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
  PROCEDURE p_existe_estado_stock(
  v_estado IN al_stock.cod_estado%TYPE ,
  v_error IN OUT NUMBER )
;
  PROCEDURE p_existe_uso_stock(
  v_uso IN al_stock.cod_uso%TYPE ,
  v_error IN OUT NUMBER )
;
  PROCEDURE p_obtiene_tipmovim(
  v_tipmovim IN al_movimientos.tip_movimiento%TYPE ,
  v_entsal IN OUT al_tipos_movimientos.ind_entsal%TYPE )
;
  PROCEDURE p_obtiene_valoracion(
  v_tipstock IN al_movimientos.tip_stock%TYPE ,
  v_valoracion IN OUT al_tipos_stock.ind_valorar%TYPE )
;
  PROCEDURE p_obtiene_documento(
  v_documento IN OUT al_datos_generales.tip_articulo_doc%TYPE )
;
  PROCEDURE p_obtiene_meses(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_meses IN OUT al_articulos.mes_afijo%TYPE )
;
  PROCEDURE p_obtiene_mes_ingreso(
  v_serie IN al_series.num_serie%TYPE ,
  v_mescompra IN OUT al_series.fec_entrada%TYPE )
;
  PROCEDURE p_obtiene_tipoart(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_tipo IN OUT al_articulos.tip_articulo%TYPE )
;
  PROCEDURE p_obtiene_moneda(
  v_moneda IN OUT al_datos_generales.cod_moneda_val%TYPE )
;
  PROCEDURE p_convertir_precio(
  v_moneda_in IN al_movimientos.cod_moneda%TYPE ,
  v_moneda_out IN OUT al_datos_generales.cod_moneda_val%TYPE ,
  v_precio_in IN NUMBER ,
  v_precio_out IN OUT NUMBER ,
  v_fec_cambio IN DATE )
;
  PROCEDURE p_obtiene_cambio(
  v_moneda IN ge_conversion.cod_moneda%TYPE ,
  v_cambio IN OUT ge_conversion.cambio%TYPE ,
  v_fec_cambio IN DATE )
;
  PROCEDURE p_actuacion(
  v_actuacion IN icg_actuacion.cod_actuacion%TYPE ,
  v_tipo IN OUT CHAR )
;
  PROCEDURE p_obtiene_ejercicio(
  v_ini_ejer IN OUT al_cierres_alma.fec_inicio%TYPE ,
  v_fin_ejer IN OUT al_cierres_alma.fec_fin%TYPE ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%TYPE)
;
  PROCEDURE p_inserta_movim(
  v_movim IN al_movimientos%ROWTYPE )
;
  PROCEDURE p_decimales(
  v_moneda IN ge_monedas.cod_moneda%TYPE ,
  v_decim IN OUT ge_monedas.num_decimal%TYPE )
;
  PROCEDURE p_obtiene_producto(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_producto IN OUT al_articulos.cod_producto%TYPE )
;
  PROCEDURE p_existe_mercaderia(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_ejercicio IN al_cierres_alma.fec_inicio%TYPE ,
  v_existe IN OUT NUMBER,
  v_operadora  IN ge_operadora_scl.cod_operadora_scl%type)
;
END AL_PAC_VALIDACIONES;
/
SHOW ERRORS
