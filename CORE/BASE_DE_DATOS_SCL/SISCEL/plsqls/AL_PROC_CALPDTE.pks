CREATE OR REPLACE PACKAGE AL_PROC_CALPDTE IS
  --
  -- Retrofitted
  PROCEDURE p_trata_movim(
  v_inter IN OUT al_intercierre%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type )
;
  --
  -- Retrofitted
  PROCEDURE p_proceso_entrada(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_proceso_salida(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_proceso_traspaso(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type )-- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_entrada_mercaderia(
  v_mercaderia IN al_pmp_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type )
;
  --
  -- Retrofitted
  PROCEDURE p_entrada_afijo(
  v_fijo IN al_pmp_afijo%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_entrada_compra(
  v_compra IN al_compras_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_salida_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_cantidad IN al_pmp_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_salida_compras(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_mescompra IN al_compras_mercaderia.mes_compra%type ,
  v_cantidad IN al_compras_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_salida_compra_ns(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_cantidad IN al_compras_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_salida_afijo_s(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fecha IN al_pmp_afijo.fec_finafijo%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_salida_afijo_ns(
  v_articulo IN al_pmp_afijo.cod_articulo%type ,
  v_fecha IN al_pmp_afijo.fec_finafijo%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_valor_afijo(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fecafijo IN OUT al_pmp_afijo.fec_afijo%type ,
  v_compra IN OUT al_pmp_afijo.prc_compra%type ,
  v_precio IN OUT al_pmp_afijo.prc_actual%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_valor_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_pmp IN OUT al_pmp_mercaderia.prc_pmp%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  --
  -- Retrofitted
  PROCEDURE p_afijo_mercaderia(
  v_articulo IN al_pmp_afijo.cod_articulo%type ,
  v_cantidad IN al_movimientos.num_cantidad%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_obtiene_mes_ingreso(
  v_serie IN al_series.num_serie%type ,
  v_mescompra IN OUT al_series.fec_entrada%type )
;
  --
  -- Retrofitted
  PROCEDURE p_actualiza_fec_entrada(
  v_serie IN al_series.num_serie%type ,
  v_fecha IN al_series.fec_entrada%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
    exception_error exception;
END AL_PROC_CALPDTE;
/
SHOW ERRORS
