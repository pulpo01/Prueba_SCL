CREATE OR REPLACE PACKAGE SISCEL.Al_Trata_Orden IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : Al_TRATA_ORDEN
-- * Descripcisn        : Rutinas para tratar las ordenes
-- * Fecha de creacisn  : 13-01-2003
-- * Responsable        : Logistica
-- *************************************************************

GN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
GV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
GN_num_evento       ge_errores_pg.Evento;
GV_des_error        ge_errores_pg.DesEvent;
GV_sSql             ge_errores_pg.vQuery;
gSqlERRM            varchar2(4000);

gvCodigo    GA_ERRORES.CODIGO%type := 1;
gvProceso   GA_ERRORES.NOM_PROC%type;
gvTabla     GA_ERRORES.NOM_TABLA%type;
gvError     GA_ERRORES.COD_SQLERRM%type;

  Procedure p_insert_cabord(
  v_cabord IN AL_CABECERA_ORDENES%ROWTYPE )
;
  Procedure p_delete_cabord(
  v_cabord IN AL_CABECERA_ORDENES%ROWTYPE )
;
  Procedure p_update_cabord(
  v_cabord IN OUT AL_CABECERA_ORDENES%ROWTYPE )
;
  Procedure p_insert_linord(
  v_linord IN AL_LINEAS_ORDENES%ROWTYPE )
;
   Procedure p_delete_linord(
  v_linord IN AL_LINEAS_ORDENES%ROWTYPE )
;
  Procedure p_update_linord(
  v_linord IN OUT AL_LINEAS_ORDENES%ROWTYPE )
;
  Procedure p_insert_serord(
  v_serord IN AL_SERIES_ORDENES%ROWTYPE )
;
  Procedure p_delete_serord(
  v_serord IN AL_SERIES_ORDENES%ROWTYPE )
;
  Procedure p_update_serord(
  v_serord IN OUT AL_SERIES_ORDENES%ROWTYPE )
;
  Procedure p_obtiene_documento(
  v_documento IN OUT AL_TIPOS_ARTICULOS.tip_articulo%TYPE )
;
  Procedure p_obtiene_tipdocum(
  v_articulo IN AL_ARTICULOS.cod_articulo%TYPE ,
  v_tipdocum IN OUT GE_TIPDOCUMEN.cod_tipdocum%TYPE )
;
 Procedure p_obtiene_tiparticulo(
  v_articulo IN AL_ARTICULOS.cod_articulo%TYPE ,
  v_tiparticulo IN OUT AL_ARTICULOS.tip_articulo%TYPE )
;
  Procedure p_valida_rango(
  v_articulo IN AL_STOCK.cod_articulo%TYPE ,
  v_desde IN AL_STOCK.num_desde%TYPE ,
  v_hasta IN AL_STOCK.num_hasta%TYPE,
  v_Num_Orden IN AL_LINEAS_ORDENES.Num_Orden%TYPE ,
  v_Tip_Orden IN AL_LINEAS_ORDENES.Tip_Orden%TYPE ,
  v_cod_plaza IN AL_LINEAS_ORDENES.cod_plaza%TYPE)
;
  Procedure p_valida_stock(
  v_articulo IN AL_STOCK.cod_articulo%TYPE ,
  v_desde IN AL_STOCK.num_desde%TYPE ,
  v_hasta IN AL_STOCK.num_hasta%TYPE ,
  v_cod_plaza IN AL_STOCK.cod_plaza%TYPE ,
  v_existe IN OUT NUMBER )
;
  Procedure p_valida_docum(
  v_articulo IN AL_STOCK.cod_articulo%TYPE ,
  v_desde IN AL_STOCK.num_desde%TYPE ,
  v_hasta IN AL_STOCK.num_hasta%TYPE ,
  v_Num_Orden IN AL_LINEAS_ORDENES.Num_Orden%TYPE ,/*AARM*/
  v_Tip_Orden IN AL_LINEAS_ORDENES.Tip_Orden%TYPE ,/*AARM*/
  v_cod_plaza IN AL_LINEAS_ORDENES.Cod_Plaza%TYPE ,/*AARM*/
  v_existe IN OUT NUMBER )
;
  Procedure p_borrar_anomalias(
  v_serie IN AL_SERIES.num_serie%TYPE )
;
  Procedure p_valida_can_orden(
  v_orden IN AL_LINEAS_ORDENES.num_orden%TYPE ,
  v_tipo IN AL_LINEAS_ORDENES.tip_orden%TYPE ,
  v_linea IN AL_LINEAS_ORDENES.num_linea%TYPE ,
  v_canser IN AL_LINEAS_ORDENES.can_series%TYPE ,
  v_caning IN AL_LINEAS_ORDENES.can_orden_ing%TYPE ,
  v_error IN OUT NUMBER )
;
/*AARM Para Obtener la Operadora y el Prefijo de la Plaza*/
  Procedure p_obtiene_operadora_Prefijo(
  v_num_Orden IN AL_LINEAS_ORDENES.num_orden%TYPE ,
  v_tip_Orden IN AL_LINEAS_ORDENES.tip_orden%TYPE ,
  v_cod_Plaza IN AL_LINEAS_ORDENES.cod_plaza%TYPE ,
--  v_tipodocum IN ge_tipdocumen.cod_tipdocum%type ,
  v_Operadora IN OUT GE_OPERADORA_SCL.cod_operadora_scl%TYPE)
--  v_Prefijo IN OUT ge_operplaza_td.pref_plaza%type  )
;
Procedure p_ingreso_notapedido(
        vp_cod_proveedor    IN  AL_PROVEEDORES.cod_proveedor%TYPE,
        vp_cod_bodega       IN  AL_BODEGAS.cod_bodega%TYPE,
        vp_cod_orden        IN  AL_CABECERA_ORDENES.num_orden%TYPE)
;
---------------------------

PROCEDURE  AL_CREA_ERROR_PR (vCodigo  IN GA_ERRORES.CODIGO%type
, vProceso  IN GA_ERRORES.NOM_PROC%type
, vTabla    IN GA_ERRORES.NOM_TABLA%type
,  vError   IN GA_ERRORES.COD_SQLERRM%type
);
--------------
   solapa             EXCEPTION;
   v_sentencia        VARCHAR2(1024);
   v_tabla            VARCHAR2(30);
   v_cursor           INTEGER;
   v_filas            INTEGER;
   v_serie_hex       VARCHAR2(11);
--------------
END Al_Trata_Orden;
/
