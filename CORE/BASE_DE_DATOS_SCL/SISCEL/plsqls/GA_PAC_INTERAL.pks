CREATE OR REPLACE package GA_PAC_INTERAL
 IS
  TYPE type_inter IS RECORD (tipo          number(1),
        tipstock      al_movimientos.tip_stock%type,
        bodega        al_movimientos.cod_bodega%type,
        articulo      al_movimientos.cod_articulo%type,
        uso           al_movimientos.cod_uso%type,
        estado        al_movimientos.cod_estado%type,
        venta         al_movimientos.num_transaccion%type,
        cantid        al_movimientos.num_cantidad%type,
        serie         al_movimientos.num_serie%type,
        indtel        number(1),
        transac       ga_transacabo.num_transaccion%type,
        error         number(1),
        central       al_movimientos.cod_central%type,
        subalm        al_movimientos.cod_subalm%type,
        celular       al_movimientos.num_telefono%type,
        cat           al_movimientos.cod_cat%type);


  PROCEDURE p_trata_interfaz(
  v_inter IN OUT type_inter )
;
  PROCEDURE p_obtiene_tipmovim(
  v_tipo IN number ,
  v_tipmo IN OUT al_movimientos.tip_movimiento%type ,
  v_usado IN OUT ga_datosgener.cod_estusado%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_select_estados(
  v_reserva IN OUT al_datos_generales.cod_estado_rvt%type ,
  v_temporal IN OUT al_datos_generales.cod_estado_tem%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_select_producto(
  v_articulo IN al_series.cod_articulo%type ,
  v_producto IN OUT al_series.cod_producto%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_select_datos_serie(
  v_serie IN al_series.num_serie%type ,
  v_central IN OUT al_series.cod_central%type ,
  v_subalm IN OUT al_series.cod_subalm%type ,
  v_telefono IN OUT al_series.num_telefono%type ,
  v_cat IN OUT al_series.cod_cat%type ,
  v_tip_stock IN OUT al_series.tip_stock%type ,
  v_cod_bodega IN OUT al_series.cod_bodega%type ,
  v_plan IN OUT al_series.plan%type ,
  v_carga IN OUT al_series.carga%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_inserta_movim(
  v_movim IN al_movimientos%rowtype ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_insert_transacabo(
  v_transac IN ga_transacabo%rowtype )
;
  PROCEDURE p_select_precio(
  v_articulo IN al_series.cod_articulo%type ,
  v_precio IN OUT al_series.prc_compra%type,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type,
  v_serie IN al_series.num_serie%type )
;
  PROCEDURE p_valida_tipmovim(
  v_tipmo IN al_tipos_movimientos.tip_movimiento%type ,
  v_indes IN OUT al_tipos_movimientos.ind_entsal%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_select_datos_serie_mov(
  v_serie IN al_series.num_serie%type ,
  v_central IN OUT al_series.cod_central%type ,
  v_subalm IN OUT al_series.cod_subalm%type ,
  v_telefono IN OUT al_series.num_telefono%type ,
  v_cat IN OUT al_series.cod_cat%type ,
  v_seriemec IN OUT al_series.num_seriemec%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type,
  v_venta IN al_movimientos.num_transaccion%type,
  v_indtel IN al_series.ind_telefono%type)
;
  PROCEDURE p_select_movimiento(
  v_movim IN OUT al_movimientos.num_movimiento%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_obtiene_valor_dev(
  v_devol IN ga_devcliente.num_devolucion%type ,
  v_moneda IN OUT ga_devcliente.cod_moneda_sto%type ,
  v_valor IN OUT ga_devcliente.val_stock%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
  PROCEDURE p_update_devclte(
  v_devol IN ga_devcliente.num_devolucion%type ,
  v_tipmo IN al_tipos_movimientos.tip_movimiento%type ,
  v_error IN OUT ga_transacabo.cod_retorno%type ,
  v_mensa IN OUT ga_transacabo.des_cadena%type )
;
PROCEDURE p_select_datos_beeper(
  v_serie IN al_series.num_serie%type ,
  v_capcode IN OUT al_series.cap_code%type,
  v_seriemec IN OUT al_series.num_seriemec%type ,
  v_error IN OUT number ,
  v_mensa IN OUT ga_transacabo.des_cadena%type)
;
END GA_PAC_INTERAL;
/
SHOW ERRORS
