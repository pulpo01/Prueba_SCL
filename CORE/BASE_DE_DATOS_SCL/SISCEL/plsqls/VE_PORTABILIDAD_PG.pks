CREATE OR REPLACE PACKAGE ve_portabilidad_pg
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cn_producto          CONSTANT NUMBER (1)    := 1;
   cv_cod_modulo        CONSTANT VARCHAR2 (3)  := 'VE';
   cv_version           CONSTANT VARCHAR2 (3)  := '1.0';

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_central_pr (
      ev_cod_celda      IN              ge_celdas.cod_celda%TYPE,
      sc_centrales      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_imei_pr (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_tip_contrato_pr (
      ev_cod_tipcontrato   IN              ga_tipcontrato.cod_tipcontrato%TYPE,
      sn_cod_producto      OUT NOCOPY      ga_tipcontrato.cod_producto%TYPE,
      sv_cod_tipcontrato   OUT NOCOPY      ga_tipcontrato.cod_tipcontrato%TYPE,
      sv_des_tipcontrato   OUT NOCOPY      ga_tipcontrato.des_tipcontrato%TYPE,
      sv_ind_contseg       OUT NOCOPY      ga_tipcontrato.ind_contseg%TYPE,
      sv_ind_contcel       OUT NOCOPY      ga_tipcontrato.ind_contcel%TYPE,
      sn_ind_comodato      OUT NOCOPY      ga_tipcontrato.ind_comodato%TYPE,
      sn_canal_vta         OUT NOCOPY      ga_tipcontrato.canal_vta%TYPE,
      sn_meses_minimo      OUT NOCOPY      ga_tipcontrato.meses_minimo%TYPE,
      sv_ind_procequi      OUT NOCOPY      ga_tipcontrato.ind_procequi%TYPE,
      sv_ind_preciolista   OUT NOCOPY      ga_tipcontrato.ind_preciolista%TYPE,
      sv_ind_gmc           OUT NOCOPY      ga_tipcontrato.ind_gmc%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_rago_operadora_scl_pr (
      ev_num_celuar     IN              ta_numnacional.num_tdesde%TYPE,
      tip_numero        OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_icc_automatica_pr (
      en_cod_bodega     IN              al_series.cod_bodega%TYPE,
      en_tip_stock      IN              al_series.tip_stock%TYPE,
      en_cod_articulo   IN              al_series.cod_articulo%TYPE,
      en_cod_uso        IN              al_series.cod_uso%TYPE,
      ev_num_serie      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_bodegas_vendedor_pr (
      en_cod_vendedor   IN              ve_vendedores.cod_vendedor%TYPE,
      sc_bodegas        OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_cargos_sim_pre_pr (
      sc_cargos_sim     OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_rec_plan_imp_pre_pr (
      ev_plantarifario     IN              VARCHAR2,
      ev_cod_vendedor      IN              VARCHAR2,
      sv_cod_plantarif     OUT NOCOPY      VARCHAR2,
      sv_des_plantarif     OUT NOCOPY      VARCHAR2,
      sv_cod_cargobasico   OUT NOCOPY      VARCHAR2,
      sv_des_cargobasico   OUT NOCOPY      VARCHAR2,
      sn_imp_cargobasico   OUT NOCOPY      NUMBER,
      sn_valorimpuesto     OUT NOCOPY      NUMBER,
      sn_total             OUT NOCOPY      NUMBER,
      sn_impuesto          OUT NOCOPY      NUMBER,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_datos_abo_pr (
      so_abonado        IN OUT NOCOPY   ga_abonado_portab_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_cuenta_ident_pr (
      ev_cod_tipident         IN              ga_cuentas.cod_tipident%TYPE,
      ev_num_ident            IN              ga_cuentas.num_ident%TYPE,
      sn_cod_cuenta           OUT NOCOPY      ga_cuentas.cod_cuenta%TYPE,
      sv_des_cuenta           OUT NOCOPY      ga_cuentas.des_cuenta%TYPE,
      sv_tip_cuenta           OUT NOCOPY      ga_cuentas.tip_cuenta%TYPE,
      sv_nom_responsable      OUT NOCOPY      ga_cuentas.nom_responsable%TYPE,
      sv_cod_tipident         OUT NOCOPY      ga_cuentas.cod_tipident%TYPE,
      sv_num_ident            OUT NOCOPY      ga_cuentas.num_ident%TYPE,
      sn_cod_direccion        OUT NOCOPY      ga_cuentas.cod_direccion%TYPE,
      sd_fec_alta             OUT NOCOPY      ga_cuentas.fec_alta%TYPE,
      sv_ind_estado           OUT NOCOPY      ga_cuentas.ind_estado%TYPE,
      sv_tel_contacto         OUT NOCOPY      ga_cuentas.tel_contacto%TYPE,
      sv_ind_sector           OUT NOCOPY      ga_cuentas.ind_sector%TYPE,
      sv_cod_clascta          OUT NOCOPY      ga_cuentas.cod_clascta%TYPE,
      sv_cod_catribut         OUT NOCOPY      ga_cuentas.cod_catribut%TYPE,
      sv_des_valor            OUT NOCOPY      ged_codigos.des_valor%TYPE,
      sn_cod_categoria        OUT NOCOPY      ga_cuentas.cod_categoria%TYPE,
      sn_cod_sector           OUT NOCOPY      ga_cuentas.cod_sector%TYPE,
      sv_cod_subcategori      OUT NOCOPY      ga_cuentas.cod_subcategoria%TYPE,
      sv_ind_multuso          OUT NOCOPY      ga_cuentas.ind_multuso%TYPE,
      sv_ind_cliepotencial    OUT NOCOPY      ga_cuentas.ind_cliepotencial%TYPE,
      sv_des_razon_social     OUT NOCOPY      ga_cuentas.des_razon_social%TYPE,
      sd_fec_inivta_pac       OUT NOCOPY      ga_cuentas.fec_inivta_pac%TYPE,
      sv_cod_tipcomis         OUT NOCOPY      ga_cuentas.nom_usuario_asesor%TYPE,
      sv_nom_usuario_asesor   OUT NOCOPY      ga_cuentas.nom_usuario_asesor%TYPE,
      sd_fec_nacimiento       OUT NOCOPY      ga_cuentas.fec_nacimiento%TYPE,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_info_mdn_pr (
      en_mdn            IN              al_series.num_telefono%TYPE,
      sn_central        OUT NOCOPY      al_series.cod_central%TYPE,
      sn_uso            OUT NOCOPY      al_series.cod_uso%TYPE,
      sn_cat            OUT NOCOPY      al_series.cod_cat%TYPE,
      sv_subalm         OUT NOCOPY      al_series.cod_subalm%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_numeraserie_portabilidad_pr (
      ev_num_serie      IN              al_series.num_serie%TYPE,
      ev_num_celular    IN              ta_numnacional.num_tdesde%TYPE,
      ev_cod_central    IN              al_series.cod_central%TYPE,
      ev_cod_subalm     IN              al_series.cod_subalm%TYPE,
      ev_tip_terminal   IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_val_usuario_scl_pr (
      ev_nom_usuario    IN              ge_seg_usuario.nom_usuario%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ve_rec_limc_clie_emp_pr (
    ev_cod_cliente    IN              ge_clientes.cod_cliente%TYPE,
    ev_cod_limiteclie OUT NOCOPY      ga_limite_cliabo_to.cod_limcons%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ve_portabilidad_pg;
/

SHOW ERRORS