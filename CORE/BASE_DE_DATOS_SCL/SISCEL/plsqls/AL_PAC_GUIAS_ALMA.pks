CREATE OR REPLACE PACKAGE AL_PAC_GUIAS_ALMA IS
  --
  -- Retrofitted
  PROCEDURE p_genera_guias(
  v_peticion IN al_petiguias_alma.num_petidor%type ,
  v_detalle IN al_cab_guias.ind_detalle%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_filas(
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_carga_cabecera(
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_genera_cabecera(
  v_cabguia IN al_cab_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_genera_linea(
  v_linguia IN al_lin_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_direccion(
  v_direccion IN ge_direcciones.cod_direccion%type ,
  v_desdirec IN OUT al_cab_guias.des_direccion%type ,
  v_region IN OUT ge_direcciones.cod_region%type ,
  v_provincia IN OUT ge_direcciones.cod_provincia%type ,
  v_ciudad IN OUT ge_direcciones.cod_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_ciudad(
  v_region IN ge_direcciones.cod_direccion%type ,
  v_provincia IN ge_direcciones.cod_provincia%type ,
  v_ciudad IN ge_direcciones.cod_ciudad%type ,
  v_desciu IN OUT al_cab_guias.des_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_articulo(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_desc IN OUT al_articulos.des_articulo%type ,
  v_seriado IN OUT al_articulos.ind_seriado%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_des_bodega(
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_descr IN OUT al_bodegas.des_bodega%type ,
  v_direc IN OUT al_bodegas.cod_direccion%type ,
  v_respon IN OUT al_bodegas.nom_responsable%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_numguia(
  v_guia IN OUT al_cab_guias.num_guia%type ,
  v_fecha IN OUT al_cab_guias.fec_guia%type ,
  v_conta IN OUT number ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_insert_interguias(
  v_inter IN al_interguias%rowtype )
;
  --
  -- Retrofitted
  PROCEDURE p_select_peticion(
  v_peticion IN al_petiguias_alma.num_peticion%type ,
  v_petidor IN OUT al_petiguias_alma.tip_petidor%type ,
  v_numpeti IN OUT al_petiguias_alma.num_petidor%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_devolucion(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_proveedor IN OUT al_vcabecera_ordenes.cod_proveedor%type ,
  v_bodega_ori IN OUT al_vcabecera_ordenes.cod_bodega%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_traspaso(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_bodega_ori IN OUT al_traspasos.cod_bodega_ori%type ,
  v_bodega_des IN OUT al_traspasos.cod_bodega_dest%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_carga_lineas(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_linguia IN OUT al_lin_guias%rowtype ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_contador IN OUT number ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_carga_seriados(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_linea IN number ,
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_indvalor IN al_tipos_stock.ind_valorar%type ,
  v_linguia IN OUT al_lin_guias%rowtype ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_contador IN OUT number ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_borra_peticion(
  v_peticion IN al_petiguias_alma.num_peticion%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_proveedor(
  v_proveedor IN al_proveedores.cod_proveedor%type ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_moneda_val(
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_peso(
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_tipvalor(
  v_tipstock IN al_tipos_stock.tip_stock%type ,
  v_indvalor IN OUT al_tipos_stock.ind_valorar%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_valorar_linea(
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_indvalor IN al_tipos_stock.ind_valorar%type ,
  v_articulo IN al_articulos.cod_articulo%type ,
  v_serie IN al_lin_guias.num_serie%type ,
  v_valor IN OUT al_lin_guias.val_articulo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_consignacion(
  v_articulo IN al_lin_consignacion.cod_articulo%type ,
  v_valor IN OUT al_lin_consignacion.prc_articulo%type ,
  v_moneda IN OUT al_cab_consignacion.cod_moneda%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_mercaderia(
  v_articulo IN al_pmp_articulo.cod_articulo%type ,
  v_valor IN OUT al_pmp_articulo.prec_pmp%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_afijo_s(
  v_serie IN al_pmp_afijo.num_serie%type ,
  v_valor IN OUT al_pmp_afijo.prc_actual%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_obtiene_ejercicio(
  v_ejercicio IN OUT al_cierres_alma.fec_inicio%type ,
  v_ejercicio1 IN OUT al_cierres_alma.fec_inicio%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_carga_serguia(
  v_numpeti IN al_petiguias_alma.num_petidor%type ,
  v_linea IN number ,
  v_petidor IN al_petiguias_alma.tip_petidor%type ,
  v_linguia IN OUT al_lin_guias%rowtype ,
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_moneda_val IN OUT al_datos_generales.cod_moneda_val%type ,
  v_indvalor IN al_tipos_stock.ind_valorar%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_genera_serguia(
  v_serguia IN al_ser_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_revalora_linea(
  v_linguia IN al_lin_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  -- Retrofitted
  PROCEDURE p_select_pmc(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_ejercicio IN al_cierres_alma.fec_inicio%type ,
  v_pmc IN OUT al_pmp_articulo.prec_pmp%type ,
  v_existe IN OUT number )
;
    EXCEPTION_ERROR    exception;
END AL_PAC_GUIAS_ALMA;
/
SHOW ERRORS
