CREATE OR REPLACE PACKAGE        AL_PROC_INGRESO
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_PROC_INGRESO
-- * Descripcion        : Rutinas para procesos ingreso mercaderia
-- * Fecha de creacion  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************
  PROCEDURE p_trata_cierre(
  v_orden_ing IN OUT al_cabecera_ordenes2.num_orden%TYPE ,
  v_tipord_ref IN OUT al_cabecera_ordenes2.tip_orden_ref%TYPE ,
  v_orden_ref IN OUT al_cabecera_ordenes2.num_orden_ref%TYPE ,
  v_bodega IN OUT al_bodegas.cod_bodega%TYPE ,
  v_usuario IN OUT ge_seg_usuario.nom_usuario%TYPE ,
  v_moneda IN OUT al_cabecera_ordenes2.cod_moneda%TYPE )
;
  PROCEDURE p_obtiene_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_seriado IN OUT al_articulos.ind_seriado%TYPE ,
  v_tipart IN OUT al_articulos.tip_articulo%TYPE )
;
  PROCEDURE p_actualiza_cantidad(
  v_orden_ing IN al_lineas_ordenes.num_orden%TYPE ,
  v_linea_ing IN al_lineas_ordenes.num_linea%TYPE ,
  v_orden IN al_lineas_ordenes.num_orden%TYPE ,
  v_tipo IN al_lineas_ordenes.tip_orden%TYPE ,
  v_linea IN al_lineas_ordenes.num_linea%TYPE ,
  v_cant IN al_lineas_ordenes.can_orden%TYPE )
;
  PROCEDURE p_obtiene_documento(
  v_documento IN OUT al_datos_generales.tip_articulo_doc%TYPE )
;
  PROCEDURE p_lee_series(
  v_orden_ing IN al_cabecera_ordenes2.num_orden%TYPE ,
  v_tipord_ref IN al_cabecera_ordenes2.tip_orden_ref%TYPE ,
  v_orden_ref IN al_cabecera_ordenes2.num_orden_ref%TYPE ,
  v_bodega IN al_bodegas.cod_bodega%TYPE ,
  v_usuario IN ge_seg_usuario.nom_usuario%TYPE ,
  v_linord IN al_vlineas_ordenes%ROWTYPE ,
  v_terminal IN al_tipos_terminales.tip_terminal%TYPE,
  v_precio   IN al_series.prc_compra%TYPE,
  v_prc_ff   IN al_lineas_ordenes2.prc_ff%TYPE,
  v_prc_adic IN al_lineas_ordenes2.prc_adic%TYPE,
  v_moneda_val IN al_datos_generales.cod_moneda_val%TYPE)
;
  PROCEDURE p_select_serhex(
  v_orden_ing IN al_fic_series.num_orden_ing%TYPE ,
  v_linea_ing IN al_fic_series.num_linea_ing%TYPE ,
  v_serie IN al_fic_series.num_serie%TYPE ,
  v_telefono IN al_fic_series.num_telefono%TYPE ,
  v_serhex IN OUT al_fic_series.num_serhex%TYPE )
;
  PROCEDURE p_select_actuacion(
  v_actuacion IN OUT ga_actabo.cod_actcen%TYPE,
  v_uso IN al_usos.cod_uso%TYPE,
  v_central IN icg_central.cod_central%TYPE)
;
  PROCEDURE p_desactiva_central(
  v_actuacion IN icc_movimiento.cod_actuacion%TYPE ,
  v_prefijo IN al_usos_min.num_min%TYPE,
  v_central IN icc_movimiento.cod_central%TYPE ,
  v_celular IN icc_movimiento.num_celular%TYPE ,
  v_serie IN icc_movimiento.num_serie%TYPE ,
  v_terminal IN icc_movimiento.tip_terminal%TYPE,
  v_serie_dec IN al_series.num_serie%TYPE )
;
  PROCEDURE p_select_mvto(
  v_mvto IN OUT al_movimientos.num_movimiento%TYPE )
;
  PROCEDURE p_select_terminal(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_terminal IN OUT al_articulos.tip_terminal%TYPE )
;
END Al_Proc_Ingreso;
/
SHOW ERRORS
