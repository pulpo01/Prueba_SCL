CREATE OR REPLACE PACKAGE AL_PROC_CIERRE IS
   type v_rec_ipc is table of number(5,2) index by binary_integer;
   type v_rec_mes is table of date index by binary_integer;
  PROCEDURE p_cierre(
  v_intercierre IN OUT al_intercierre%rowtype ,
  v_cierre IN varchar2 ,
  v_mes_cierre IN date ,
  v_new_ejer IN OUT al_cierres_alma.fec_inicio%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_calculo_pmp_afijo(
  v_mes_cierre IN date ,
  v_cierre IN varchar2 ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_dia IN al_datos_generales.dia_afijo_mes%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_cierre_anual(
  v_mes_cierre IN date ,
  v_cierre IN varchar2 ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_dia IN al_datos_generales.dia_afijo_mes%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_obtiene_ipc(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_ipc IN OUT v_rec_ipc ,
  v_mes IN OUT v_rec_mes ,
  v_nro IN OUT number ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_obtiene_dia(
  v_dia IN OUT al_datos_generales.dia_afijo_mes%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_inserta_acumulado(
  v_acum IN al_acum_pmp_afijo%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_calculo_pmp_mercaderia(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type ,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_sel_fecha_minima(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_fec_min IN OUT date ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_mira_primer_trim(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_fec_1er IN date ,
  v_ini_ejer IN date ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_mira_segundo_trim(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_fec_1er IN date ,
  v_fec_2do IN date ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_select_max_precio(
  v_articulo IN al_compras_mercaderia.cod_articulo%type ,
  v_fecha IN al_compras_mercaderia.mes_compra%type ,
  v_precio IN OUT al_compras_mercaderia.prc_compra%type ,
  v_error IN OUT number,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type  ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_select_pmp_ant(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_ini_ejer IN al_pmp_mercaderia.fec_ejercicio%type ,
  v_precio IN OUT al_pmp_mercaderia.prc_pmp%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)  -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_select_can_stock(
  v_articulo IN al_pmp_mercaderia.cod_articulo%type ,
  v_stock IN OUT al_pmp_mercaderia.can_stock%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_aplica_ipc(
  v_fecha IN date ,
  v_precio IN al_pmp_mercaderia.prc_pmp%type ,
  v_ipc IN v_rec_ipc ,
  v_mes IN v_rec_mes ,
  v_nro IN number ,
  v_pmp IN OUT al_pmp_mercaderia.prc_pmp%type ,
  v_moneda_val IN ge_monedas.cod_moneda%type ,
  v_decim IN ge_monedas.num_decimal%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_inserta_pmp_mercaderia(
  v_pmp_merc IN al_pmp_mercaderia%rowtype ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_obtiene_ejercicio(
  v_ini_ejer IN OUT al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN OUT al_cierres_alma.fec_fin%type ,
  v_ult_mes IN OUT al_cierres_alma.mes_cierre%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_update_cierres(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_mes IN al_cierres_alma.mes_cierre%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_genera_ejercicio(
  v_fin_ejer IN al_cierres_alma.fec_fin%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_bloqueo_tablas(
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_paso_historico(
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_inserta_historico(
  v_acum IN al_acum_pmp_afijo%rowtype ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type )
;
  PROCEDURE p_borrado_nuevo(
  v_ejercicio IN al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_intercierre.cod_retorno%type ,
  v_mensa IN OUT al_intercierre.des_cadena%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type)-- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
  PROCEDURE p_sel_precio_act(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_ini_ejer IN al_cierres_alma.fec_inicio%type ,
  v_precio IN OUT al_pmp_mercaderia.prc_pmp%type,
  v_operadora IN ge_operadora_scl.cod_operadora_scl%type ) -- 30-12-2002 Modificacion multiempresa Ulises Uribe
;
   exception_error exception;
END AL_PROC_CIERRE;
/
SHOW ERRORS
