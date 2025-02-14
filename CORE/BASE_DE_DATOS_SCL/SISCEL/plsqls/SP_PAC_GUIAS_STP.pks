CREATE OR REPLACE PACKAGE Sp_Pac_Guias_Stp IS
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_guias(
  v_peticion IN SP_PETIGUIAS.num_peticion%TYPE ,
  v_detalle IN AL_CAB_GUIAS.ind_detalle%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_filas(
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_cabecera(
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_cabecera(
  v_cabguia IN AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_linea(
  v_linguia IN AL_LIN_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_articulo(
  v_articulo IN AL_ARTICULOS.cod_articulo%TYPE ,
  v_desc IN OUT AL_ARTICULOS.des_articulo%TYPE ,
  v_seriado IN OUT AL_ARTICULOS.ind_seriado%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_des_bodega(
  v_bodega IN AL_BODEGAS.cod_bodega%TYPE ,
  v_descr IN OUT AL_BODEGAS.des_bodega%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_numguia(
  v_guia IN OUT AL_CAB_GUIAS.num_guia%TYPE ,
  v_fecha IN OUT AL_CAB_GUIAS.fec_guia%TYPE ,
  v_conta IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_insert_interguias(
  v_inter IN AL_INTERGUIAS%ROWTYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_peticion(
  v_peticion IN SP_PETIGUIAS.num_peticion%TYPE ,
  v_petidor IN OUT SP_PETIGUIAS.tip_petidor%TYPE ,
  v_numpeti IN OUT SP_PETIGUIAS.num_petidor%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_reemplazo(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_abonado IN OUT SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN OUT SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_bodega_ori IN OUT SP_ORDENES_REPARACION.cod_bodega_reem%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_envio(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_taller IN OUT SP_ORDENES_REPARACION.cod_taller%TYPE ,
  v_bodega_ori IN OUT SP_ORDENES_REPARACION.cod_bodega%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_linea_or(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_contador IN OUT NUMBER ,
  v_ind_equiacc IN OUT AL_ARTICULOS.ind_equiacc%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_lineas(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_contador IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_seriados(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_linea IN NUMBER ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_linguias IN OUT AL_DATOS_GENERALES.num_linguias%TYPE ,
  v_contador IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_borra_peticion(
  v_peticion IN SP_PETIGUIAS.num_peticion%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_taller(
  v_taller IN SP_ORDENES_REPARACION.cod_taller%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_datos_taller(
  v_taller IN SP_TALLERES.cod_taller%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_direccion IN OUT GE_DIRECCIONES.cod_direccion%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_cliente(
  v_abonado IN SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_cabguia IN OUT AL_CAB_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_datos_cliente(
  v_cliente IN GE_CLIENTES.cod_cliente%TYPE ,
  v_nombre IN OUT GE_CLIENTES.nom_cliente%TYPE ,
  v_tipident IN OUT GE_CLIENTES.cod_tipident%TYPE ,
  v_numident IN OUT GE_CLIENTES.num_ident%TYPE ,
  v_actividad IN OUT GE_CLIENTES.cod_actividad%TYPE ,
  v_telefono IN OUT GE_CLIENTES.tef_cliente1%TYPE ,
  v_fax IN OUT GE_CLIENTES.num_fax%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_tiporut(
  v_tiprut IN OUT GA_DATOSGENER.cod_tipid_num_ident%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_giro(
  v_actividad IN GE_ACTIVIDADES.cod_actividad%TYPE ,
  v_giro IN OUT GE_ACTIVIDADES.des_actividad%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_direccion(
  v_direccion IN GE_DIRECCIONES.cod_direccion%TYPE ,
  v_desdirec IN OUT AL_CAB_GUIAS.des_direccion%TYPE ,
  v_region IN OUT GE_DIRECCIONES.cod_region%TYPE ,
  v_provincia IN OUT GE_DIRECCIONES.cod_provincia%TYPE ,
  v_ciudad IN OUT GE_DIRECCIONES.cod_ciudad%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_ciudad(
  v_region IN GE_DIRECCIONES.cod_direccion%TYPE ,
  v_provincia IN GE_DIRECCIONES.cod_provincia%TYPE ,
  v_ciudad IN GE_DIRECCIONES.cod_ciudad%TYPE ,
  v_desciu IN OUT AL_CAB_GUIAS.des_ciudad%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_cliente_direccion(
  v_cliente IN GA_DIRECCLI.cod_cliente%TYPE ,
  v_direccion IN OUT GA_DIRECCLI.cod_direccion%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_cliente_abonado(
  v_abonado IN SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_cliente IN OUT GE_CLIENTES.cod_cliente%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_obtiene_cliente_aborent(
  v_abonado IN SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_cliente IN OUT GE_CLIENTES.cod_cliente%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_carga_serguia(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_linea IN NUMBER ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_linguia IN OUT AL_LIN_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_genera_serguia(
  v_serguia IN AL_SER_GUIAS%ROWTYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_trata_envios(
  v_peticion IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_detalle IN AL_CAB_GUIAS.ind_detalle%TYPE ,
  v_contador IN OUT NUMBER ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_pone_numguia(
  v_numpeti IN SP_ORDENES_REPARACION.num_orden%TYPE ,
  v_petidor IN SP_PETIGUIAS.tip_petidor%TYPE ,
  v_numguia IN SP_ORDENES_REPARACION.num_guia_env%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
  -- Retrofitted
  PROCEDURE sp_p_select_entrega(
  v_numpeti IN SP_PETIGUIAS.num_petidor%TYPE ,
  v_abonado IN OUT SP_ORDENES_REPARACION.num_abonado%TYPE ,
  v_producto IN OUT SP_ORDENES_REPARACION.cod_producto%TYPE ,
  v_bodega_ori IN OUT SP_ORDENES_REPARACION.cod_bodega_reem%TYPE ,
  v_error IN OUT AL_INTERGUIAS.cod_retorno%TYPE ,
  v_mensa IN OUT AL_INTERGUIAS.des_cadena%TYPE )
;
  --
    EXCEPTION_ERROR    EXCEPTION;
END Sp_Pac_Guias_Stp;
/
SHOW ERRORS
