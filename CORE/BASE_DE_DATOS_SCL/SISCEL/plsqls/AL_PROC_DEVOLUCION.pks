CREATE OR REPLACE PACKAGE Al_Proc_Devolucion
 IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : Al_Proc_Devolucion
-- * Descripción        : Rutinas para procesos de devolucion
-- * Fecha de creación  : 14-11-2002
-- * Responsable        : Logistica
-- *************************************************************

  PROCEDURE p_trata_devprov(
  v_orden IN al_cabecera_ordenes.num_orden%TYPE ,
  v_estorden IN al_cabecera_ordenes.cod_estado%TYPE ,
  v_bodega IN al_cabecera_ordenes.cod_bodega%TYPE )
;
  PROCEDURE p_proceso_seriados(
  v_orden IN al_cabecera_ordenes.num_orden%TYPE ,
  v_estorden IN al_cabecera_ordenes.cod_estado%TYPE ,
  v_linea IN al_lineas_ordenes.num_linea%TYPE ,
  v_uso IN al_lineas_ordenes.cod_uso%TYPE ,
  v_movim IN OUT al_movimientos%ROWTYPE )
;
  PROCEDURE p_obtiene_estados(
  v_reserva IN OUT al_datos_generales.cod_estado_res%TYPE )
;
  PROCEDURE p_obtiene_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_seriado IN OUT al_articulos.ind_seriado%TYPE )
;
  PROCEDURE p_borrado_linord3(
  v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  v_tstock IN al_lineas_ordenes3.tip_stock%TYPE ,
  v_articulo IN al_lineas_ordenes3.cod_articulo%TYPE ,
  v_uso IN al_lineas_ordenes3.cod_uso%TYPE ,
  v_estado IN al_lineas_ordenes3.cod_estado%TYPE ,
  v_cantidad IN al_lineas_ordenes3.can_orden%TYPE ,
  v_tipmovim IN al_lineas_ordenes3.tip_movimiento%TYPE ,
  v_numdesde IN al_lineas_ordenes3.num_desde%TYPE ,
  v_numhasta IN al_lineas_ordenes3.num_hasta%TYPE )
;
  PROCEDURE p_borrado_serord3(
  v_serord IN al_series_ordenes3%ROWTYPE )
;
  PROCEDURE p_inserta_serord3(
  v_serord IN al_series_ordenes3%ROWTYPE )
;
  PROCEDURE p_cambio_cantidad(
  v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  v_tstock IN al_lineas_ordenes3.tip_stock%TYPE ,
  v_articulo IN al_lineas_ordenes3.cod_articulo%TYPE ,
  v_uso IN al_lineas_ordenes3.cod_uso%TYPE ,
  v_estado IN al_lineas_ordenes3.cod_estado%TYPE ,
  v_can_old IN al_lineas_ordenes3.can_orden%TYPE ,
  v_can_new IN al_lineas_ordenes3.can_orden%TYPE ,
  v_tipmovim IN al_lineas_ordenes3.tip_movimiento%TYPE ,
  v_desde_old IN al_lineas_ordenes3.num_desde%TYPE ,
  v_desde_new IN al_lineas_ordenes3.num_desde%TYPE ,
  v_hasta_old IN al_lineas_ordenes3.num_hasta%TYPE ,
  v_hasta_new IN al_lineas_ordenes3.num_hasta%TYPE,
  EN_prc_unidad al_lineas_ordenes3.prc_unidad%type)
;
  PROCEDURE p_obtiene_cabord(
  v_orden IN al_cabecera_ordenes3.num_orden%TYPE ,
  v_estorden IN OUT NOCOPY  al_cabecera_ordenes3.cod_estado%TYPE ,
  v_bodega IN OUT NOCOPY  al_cabecera_ordenes3.cod_bodega%TYPE )
;
  PROCEDURE p_obtiene_linea(
  v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  v_linea IN al_lineas_ordenes3.num_linea%TYPE ,
  v_tstock IN OUT NOCOPY  al_lineas_ordenes3.tip_stock%TYPE ,
  v_articulo IN OUT NOCOPY  al_lineas_ordenes3.cod_articulo%TYPE ,
  v_uso IN OUT NOCOPY  al_lineas_ordenes3.cod_uso%TYPE ,
  v_estado IN OUT  NOCOPY al_lineas_ordenes3.cod_estado%TYPE ,
  v_tipmovim IN OUT NOCOPY  al_lineas_ordenes3.tip_movimiento%TYPE ,
  v_numdesde IN OUT NOCOPY  al_lineas_ordenes3.num_desde%TYPE ,
  v_numhasta IN OUT NOCOPY  al_lineas_ordenes3.num_hasta%TYPE )
;
  PROCEDURE p_inserta_linea(
  v_orden IN al_lineas_ordenes3.num_orden%TYPE ,
  EN_linea IN al_lineas_ordenes3.num_linea%TYPE,
  v_tstock IN al_lineas_ordenes3.tip_stock%TYPE ,
  v_articulo IN al_lineas_ordenes3.cod_articulo%TYPE ,
  v_uso IN al_lineas_ordenes3.cod_uso%TYPE ,
  v_estado IN al_lineas_ordenes3.cod_estado%TYPE ,
  v_cantidad IN al_lineas_ordenes3.can_orden%TYPE ,
  v_tipmovim IN al_lineas_ordenes3.tip_movimiento%TYPE ,
  v_numdesde IN al_lineas_ordenes3.num_desde%TYPE ,
  v_numhasta IN al_lineas_ordenes3.num_hasta%TYPE)
;
  PROCEDURE p_genera_peticion_guia(
  v_peticion IN al_petiguias_alma%ROWTYPE )
;
  PROCEDURE p_select_movimiento(
  v_movimiento IN OUT NOCOPY  al_movimientos.num_movimiento%TYPE )
;
  PROCEDURE p_obtiene_peticion(
  v_peticion IN OUT NOCOPY  al_petiguias_alma.num_peticion%TYPE )
;
END Al_Proc_Devolucion;
/
SHOW ERRORS
