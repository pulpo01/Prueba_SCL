CREATE OR REPLACE PACKAGE Al_Proc_Movto
 IS


  PROCEDURE p_trata_movim(
  v_movim IN OUT al_movimientos%ROWTYPE )
;
  PROCEDURE p_proceso_entrada(
  v_movim IN al_movimientos%ROWTYPE ,
  v_valor IN al_tipos_stock.ind_valorar%TYPE ,
  v_documento IN al_datos_generales.tip_articulo_doc%TYPE )
;
  PROCEDURE p_proceso_salida(
  v_movim IN al_movimientos%ROWTYPE ,
  v_valor IN al_tipos_stock.ind_valorar%TYPE ,
  v_documento IN al_datos_generales.tip_articulo_doc%TYPE )

;

  PROCEDURE p_proceso_traspaso(
  v_movim IN OUT al_movimientos%ROWTYPE ,
  v_valor_old IN al_tipos_stock.ind_valorar%TYPE ,
  v_valor_new IN al_tipos_stock.ind_valorar%TYPE ,
  v_documento IN al_datos_generales.tip_articulo_doc%TYPE )
;
  PROCEDURE p_entrada_stock(
  v_stock IN al_stock%ROWTYPE )
;
  PROCEDURE p_entrada_series(
  v_series IN al_series%ROWTYPE )
;
  PROCEDURE p_salida_serie(
  v_serie IN al_series.num_serie%TYPE )
;
  PROCEDURE p_salida_stock_doc(
  v_bodega IN al_stock.cod_bodega%TYPE ,
  v_tipstock IN al_stock.tip_stock%TYPE ,
  v_articulo IN al_stock.cod_articulo%TYPE ,
  v_uso IN al_stock.cod_uso%TYPE ,
  v_estado IN al_stock.cod_estado%TYPE ,
  v_cantidad IN al_stock.can_stock%TYPE ,
  v_numdesde IN al_stock.num_desde%TYPE ,
  v_numhasta IN al_stock.num_hasta%TYPE ,
  v_cod_plaza IN al_stock.cod_plaza%TYPE) /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
;
  PROCEDURE p_salida_stock(
  v_bodega IN al_stock.cod_bodega%TYPE ,
  v_tipstock IN al_stock.tip_stock%TYPE ,
  v_articulo IN al_stock.cod_articulo%TYPE ,
  v_uso IN al_stock.cod_uso%TYPE ,
  v_estado IN al_stock.cod_estado%TYPE ,
  v_cantidad IN al_stock.can_stock%TYPE ,
  v_numdesde IN al_stock.num_desde%TYPE ,
  v_cod_plaza IN al_stock.cod_plaza%TYPE )   /* AARM, Agrego Cod_Plaza, Diciembre 2002*/
;
  PROCEDURE p_traspaso_series(
  v_serie IN al_series.num_serie%TYPE ,
  v_bodega IN al_series.cod_bodega%TYPE ,
  v_tipstock IN al_series.tip_stock%TYPE ,
  v_estado IN al_series.cod_estado%TYPE ,
  v_uso IN al_series.cod_uso%TYPE ,
  v_central IN al_series.cod_central%TYPE ,
  v_subalm IN al_series.cod_subalm%TYPE ,
  v_telefono IN al_series.num_telefono%TYPE ,
  v_cat IN al_series.cod_cat%TYPE,
  v_carga IN al_series.carga%TYPE,
  v_plan  IN al_series.PLAN%TYPE )
;
  PROCEDURE p_validar_serie(
  v_serie IN al_series.num_serie%TYPE ,
  v_bodega IN al_series.cod_bodega%TYPE ,
  v_tipstock IN al_series.tip_stock%TYPE ,
  v_uso IN al_series.cod_uso%TYPE ,
  v_estado IN al_series.cod_estado%TYPE ,
  v_articulo IN al_series.cod_articulo%TYPE )
;
  PROCEDURE p_insert_pendiente(
  v_pdte IN al_pdte_calculo%ROWTYPE )
;
  PROCEDURE p_es_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_ind_seriado IN OUT al_articulos.ind_seriado%TYPE )
;

  PROCEDURE p_obtener_oficina_default(
    v_cod_plaza IN OUT al_movimientos.cod_plaza%TYPE )
;


  PROCEDURE p_entrada_stock_localizacion(v_stock IN al_stock_localizacion%ROWTYPE );
  PROCEDURE p_salida_stock_localizacion(v_stock IN al_stock_localizacion%ROWTYPE );

  Procedure p_bloq_stock(v_movim IN al_movimientos%ROWTYPE,
            v_error IN OUT ga_abocel.ind_disp%TYPE);

  Procedure p_bloq_stock_entrada(v_stock IN al_stock%ROWTYPE,
            v_error IN OUT ga_abocel.ind_disp%TYPE);

  Procedure p_bloq_stock_doc(v_movim IN al_movimientos%ROWTYPE,
            v_error IN OUT ga_abocel.ind_disp%TYPE);

  --DECLARE  --HGGT
        v_val_cero        number:=0;

END Al_Proc_Movto;
/
SHOW ERROR