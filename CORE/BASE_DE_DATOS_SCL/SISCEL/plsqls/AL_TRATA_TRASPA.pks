CREATE OR REPLACE PACKAGE        AL_TRATA_TRASPA IS
  --
  -- Retrofitted
  PROCEDURE p_tratamiento(
  v_traspa IN al_traspasos%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_trata_series(
  v_lintra IN al_lin_traspaso%ROWTYPE ,
  v_movim IN OUT al_movimientos%ROWTYPE ,
  v_estado IN al_traspasos.cod_estado%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_estados(
  v_reserva IN OUT al_datos_generales.cod_estado_res%TYPE ,
  v_transito IN OUT al_datos_generales.cod_estado_tra%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_seriado(
  v_articulo IN al_articulos.cod_articulo%TYPE ,
  v_seriado IN OUT al_articulos.ind_seriado%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_tip_stock_dest(
  v_tipmovim IN al_tipos_movimientos.tip_movimiento%TYPE ,
  v_dest IN OUT al_tipos_movimientos.tip_stock%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_cambio_cantidad(
  v_traspaso IN al_lin_traspaso.num_traspaso%TYPE ,
  v_tstock IN al_lin_traspaso.tip_stock%TYPE ,
  v_articulo IN al_lin_traspaso.cod_articulo%TYPE ,
  v_uso IN al_lin_traspaso.cod_uso%TYPE ,
  v_estado IN al_lin_traspaso.cod_estado%TYPE ,
  v_can_old IN al_lin_traspaso.can_traspaso%TYPE ,
  v_can_new IN al_lin_traspaso.can_traspaso%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_traspa(
  v_numero IN al_traspasos.num_traspaso%TYPE ,
  v_estado IN OUT al_traspasos.cod_estado%TYPE ,
  v_bodega IN OUT al_traspasos.cod_bodega_ori%TYPE ,
  v_tipmo IN OUT al_traspasos.tip_movim_aut%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_linea(
  v_numero IN al_lin_traspaso.num_traspaso%TYPE ,
  v_linea IN al_lin_traspaso.lin_traspaso%TYPE ,
  v_tstock IN OUT al_lin_traspaso.tip_stock%TYPE ,
  v_articulo IN OUT al_lin_traspaso.cod_articulo%TYPE ,
  v_uso IN OUT al_lin_traspaso.cod_uso%TYPE ,
  v_estado IN OUT al_lin_traspaso.cod_estado%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_borrado_lintra(
  v_traspaso IN al_lin_traspaso.num_traspaso%TYPE ,
  v_tstock IN al_lin_traspaso.tip_stock%TYPE ,
  v_articulo IN al_lin_traspaso.cod_articulo%TYPE ,
  v_uso IN al_lin_traspaso.cod_uso%TYPE ,
  v_estado IN al_lin_traspaso.cod_estado%TYPE ,
  v_cantidad IN al_lin_traspaso.can_traspaso%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_borrado_sertra(
  v_sertra IN al_ser_traspaso%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_inserta_sertra(
  v_sertra IN al_ser_traspaso%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_movimiento(
  v_movimiento IN OUT al_movimientos.num_movimiento%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_select_peticion(
  v_peticion IN OUT al_petiguias_alma.num_peticion%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_genera_peticion(
  v_peticion IN al_petiguias_alma%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_datos_serie(
  v_serie IN al_series.num_serie%TYPE ,
  v_telefono IN OUT al_series.num_serie%TYPE ,
  v_subalm IN OUT al_series.cod_subalm%TYPE ,
  v_central IN OUT al_series.cod_central%TYPE ,
  v_categoria IN OUT al_series.cod_cat%TYPE )
;

PROCEDURE p_actualiza_Serie_Localizada (v_num_serie IN al_series.NUM_SERIE%TYPE,
		  							   	v_num_sec_loca IN al_series.num_sec_loca%TYPE);
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
END Al_Trata_Traspa;
/
SHOW ERRORS
