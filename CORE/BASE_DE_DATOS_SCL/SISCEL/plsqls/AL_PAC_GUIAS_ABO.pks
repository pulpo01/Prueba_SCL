CREATE OR REPLACE package AL_PAC_GUIAS_ABO
 IS
  --
  PROCEDURE p_genera_guias(
  v_num_peticion IN al_petiguias_abo.num_peticion%type ,
  v_detalle IN al_cab_guias.ind_detalle%type )
;
  --
  PROCEDURE p_obtiene_filas(
  v_linguias IN OUT al_datos_generales.num_linguias%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_carga_cabecera(
  v_num_peticion IN al_petiguias_abo.num_peticion%type ,
  v_cabguia IN OUT al_cab_guias%rowtype ,
  v_oficina IN OUT al_petiguias_abo.cod_oficina%type ,
  v_concepto IN OUT al_petiguias_abo.cod_concepto%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_genera_linea(
  v_linguia IN al_lin_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
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
  PROCEDURE p_select_ciudad(
  v_region IN ge_direcciones.cod_direccion%type ,
  v_provincia IN ge_direcciones.cod_provincia%type ,
  v_ciudad IN ge_direcciones.cod_ciudad%type ,
  v_desciu IN OUT al_cab_guias.des_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_select_rut(
  v_rut IN OUT al_cab_guias.num_ident%type )
;
  --
  PROCEDURE p_select_cliente(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_nombre IN OUT ge_clientes.nom_cliente%type ,
  v_tipident IN OUT ge_clientes.cod_tipident%type ,
  v_numident IN OUT ge_clientes.num_ident%type ,
  v_actividad IN OUT ge_clientes.cod_actividad%type ,
  v_telefono IN OUT ge_clientes.tef_cliente1%type ,
  v_fax IN OUT ge_clientes.num_fax%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_tiporut(
  v_tiprut IN OUT ga_datosgener.cod_tipid_num_ident%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_select_giro(
  v_actividad IN ge_actividades.cod_actividad%type ,
  v_giro IN OUT ge_actividades.des_actividad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_direccion(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_direccion IN OUT ge_direcciones.cod_direccion%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_select_articulo(
  v_articulo IN al_articulos.cod_articulo%type ,
  v_desc IN OUT al_articulos.des_articulo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_actualiza_cargo(
  v_cargo IN ge_cargos.num_cargo%type ,
  v_guia IN al_cab_guias.num_guia%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_select_des_bodega(
  v_bodega IN al_bodegas.cod_bodega%type ,
  v_descr IN OUT al_bodegas.des_bodega%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_select_numguia(
  v_guia IN OUT al_cab_guias.num_guia%type ,
  v_fecha IN OUT al_cab_guias.fec_guia%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_insert_interguias(
  v_inter IN al_interguias%rowtype )
;
  --
  PROCEDURE p_obtiene_peso_iva(
  v_peso IN OUT fa_datosgener.cod_peso%type ,
  v_iva IN OUT fa_datosgener.cod_iva%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_iva(
  v_cliente IN ge_clientes.cod_cliente%type ,
  v_oficina IN ge_oficinas.cod_oficina%type ,
  v_concepto IN fa_conceptos.cod_concepto%type ,
  v_iva IN fa_datosgener.cod_iva%type ,
  v_impuesto IN OUT ge_impuestos.prc_impuesto%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_grpservi(
  v_concepto IN fa_grpserconc.cod_concepto%type ,
  v_grpservi IN OUT fa_grpserconc.cod_grpservi%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_oficina(
  v_oficina IN ge_oficinas.cod_oficina%type ,
  v_region IN OUT ge_direcciones.cod_region%type ,
  v_provincia IN OUT ge_direcciones.cod_provincia%type ,
  v_ciudad IN OUT ge_direcciones.cod_ciudad%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_zonaimpo(
  v_region IN ge_zonaciudad.cod_region%type ,
  v_provincia IN ge_zonaciudad.cod_provincia%type ,
  v_ciudad IN ge_zonaciudad.cod_ciudad%type ,
  v_zonaimpo IN OUT ge_zonaciudad.cod_zonaimpo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_catimpos(
  v_cliente IN ge_catimpclientes.cod_cliente%type ,
  v_catimpos IN OUT ge_catimpclientes.cod_catimpos%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_obtiene_pct(
  v_catimpos IN ge_impuestos.cod_catimpos%type ,
  v_zonaimpo IN ge_impuestos.cod_zonaimpo%type ,
  v_iva IN ge_impuestos.cod_tipimpues%type ,
  v_grpservi IN ge_impuestos.cod_grpservi%type ,
  v_impuesto IN OUT ge_impuestos.prc_impuesto%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_genera_serguia(
  v_serguia IN al_ser_guias%rowtype ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
  PROCEDURE p_updatea_linea(
  v_guia IN al_lin_guias.num_guia%type ,
  v_linea IN al_lin_guias.lin_guia%type ,
  v_val_articulo IN al_lin_guias.val_articulo%type ,
  v_cantidad IN al_lin_guias.can_articulo%type ,
  v_error IN OUT al_interguias.cod_retorno%type ,
  v_mensa IN OUT al_interguias.des_cadena%type )
;
  --
    EXCEPTION_ERROR    exception;
END AL_PAC_GUIAS_ABO;
/
SHOW ERRORS
