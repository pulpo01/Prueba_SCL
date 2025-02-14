CREATE OR REPLACE package AL_PAC_MERCADERIA
 IS
  --
  -- Retrofitted
  PROCEDURE p_trata_movim_pdte(
  v_periodo in number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type,
  v_compacta IN OUT boolean )
;
  --
  -- Retrofitted
  PROCEDURE p_bloqueo_tablas_pmp(
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_proceso_entrada(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)
;
  --
  -- Retrofitted
  PROCEDURE p_proceso_salida(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type )
;
  --
  -- Retrofitted
  PROCEDURE p_proceso_traspaso(
  v_pdte IN al_pdte_calculo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)
;
  --
  -- Retrofitted
  PROCEDURE p_entrada_mercaderia(
  v_mercaderia IN al_pmp_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)
;
  --
  -- Retrofitted
  PROCEDURE p_entrada_afijo(
  v_fijo IN al_pmp_afijo%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora ge_operadora_scl.cod_operadora_scl%type )
;
  --
  -- Retrofitted
  PROCEDURE p_entrada_compra(
  v_compra IN al_compras_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)
;
  --
  -- Retrofitted
  PROCEDURE p_salida_mercaderia(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_cantidad IN al_pmp_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_salida_compra_ns(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_cantidad IN al_compras_mercaderia.can_stock%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
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
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_valor_afijo(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_fec_movimiento IN al_pmp_afijo.fec_afijo%type ,
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
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_afijo_mercaderia(
  v_articulo IN al_pmp_afijo.cod_articulo%type ,
  v_cantidad IN al_movimientos.num_cantidad%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_fec_movim IN al_pdte_calculo.fec_movimiento%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_operadora ge_operadora_scl.cod_operadora_scl%type)
;
  --
  -- Retrofitted
PROCEDURE p_obtiene_prc_pmp(
  v_cod_articulo IN al_pmp_mercaderia.cod_articulo%type,
  v_prc_pmp IN OUT al_pmp_mercaderia.prc_pmp%type,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
PROCEDURE p_guarda_error(
  v_pdte  IN al_pdte_calculo%rowtype ,
  v_error IN al_intercierre.cod_retorno%type ,
  v_mensa IN al_intercierre.des_cadena%type )
;
  --
  -- Retrofitted
PROCEDURE p_borra_errores
;
PROCEDURE p_compacta(v_dia_inicio_pdte IN DATE,v_dia_fin_pdte IN DATE, v_error IN OUT al_intercierre.cod_retorno%TYPE)
;
PROCEDURE p_traza_procedimiento(p_des_cadena in Varchar2)
;
PROCEDURE p_valida_cantidades (
v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type,
v_error IN OUT al_intercierre.cod_retorno%type)
;
PROCEDURE p_act_mov_rezagados(v_dia_inicio_pdte IN al_pmp_mercaderia.fec_ejercicio%type,
                              v_error IN OUT al_intercierre.cod_retorno%type)
;
--
    exception_error exception;
    v_margen_obs al_pmp_mercaderia.pct_obs%type;
	-- margen para obsolescencia
--
--
END AL_PAC_MERCADERIA;
/
SHOW ERRORS
