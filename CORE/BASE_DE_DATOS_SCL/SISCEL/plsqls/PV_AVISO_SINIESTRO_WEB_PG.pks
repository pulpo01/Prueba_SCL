CREATE OR REPLACE PACKAGE SISCEL.pv_aviso_siniestro_web_pg
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2 (50)
                                       := 'No es posible clasificar el error';
   cv_cod_modulo_ga     CONSTANT VARCHAR2 (2)  := 'GA';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'PV';
   cv_version           CONSTANT VARCHAR2 (2)  := '1';
   cv_prod_celular      CONSTANT NUMBER (2)    := 1;
   cv_evento            CONSTANT VARCHAR2 (10) := 'FORMLOAD';
   cn_cod_ooss          CONSTANT VARCHAR2 (5)  := '10060';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_tipos_siniestro_pr (
      eo_dat_abo         IN              pv_datos_abo_qt,
      sc_tip_siniestro   OUT             refcursor,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_tipo_suspension_pr (
      sc_tip_suspension   OUT          refcursor,
      sn_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_causa_siniestro_pr (
      eo_dat_abo           IN              pv_datos_abo_qt,
      ev_cod_actabo        IN              pv_serv_suspreha_to.cod_actabo%TYPE,
      sc_causa_siniestro   OUT             refcursor,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_recupera_estado_ooss_fn (
      en_num_ooss       IN              pv_iorserv.num_os%TYPE,
      sv_estado_ooss    OUT             pv_iorserv.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_valida_ooss_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      en_num_ooss       IN              pv_camcom.num_os%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_dett_siniestro_fn (
      en_num_siniestro   IN              ga_detsinie.num_siniestro%TYPE,
      sv_det_siniestro   OUT             ga_detsinie.obs_detalle%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_recupera_num_sinies_fn (
      eo_dat_abo         IN              pv_datos_abo_qt,
      ev_cod_servicio    IN              ga_siniestros.cod_servicio%TYPE,
      sn_num_siniestro   OUT             ga_siniestros.num_siniestro%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_val_tipo_siniestro_fn (
      eo_dat_abo         IN              pv_datos_abo_qt,
      en_tipo_terminal   IN              ga_siniestros.tip_terminal%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_val_ooss_pendiente_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      ev_cod_os         IN              pv_iorserv.cod_os%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_estado_transaccion_pr (
      eo_dat_abo         IN              pv_datos_abo_qt,
      en_num_ooss        IN              pv_camcom.num_os%TYPE,
      ev_cod_servicio    IN              ga_siniestros.cod_servicio%TYPE,
      sv_des_estado      OUT             pv_erecorrido.descripcion%TYPE,
      sn_num_siniestro   OUT             ga_siniestros.num_siniestro%TYPE,
      sv_det_siniestro   OUT             ga_detsinie.obs_detalle%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_acepta_as_pr (
      eo_dat_abo        IN              pv_datos_abo_qt,
      ev_cod_actabo     IN              pv_camcom.cod_actabo%TYPE,
      ev_tipo_sinie     IN              ged_codigos.cod_valor%TYPE,
      en_tipo_susp      IN              ged_codigos.cod_valor%TYPE,
      en_causa_sinie    IN              ga_siniestros.cod_causa%TYPE,
      ev_usuario        IN              VARCHAR2,
	  num_os            IN              NUMBER,
	  ev_comentario     IN              pv_iorserv.comentario%TYPE,
      ev_desvio_numero  IN              PV_CAMCOM.PREF_PLAZA%TYPE,  
      sn_num_solequ     OUT             NUMBER,
      sn_num_solsim     OUT             NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_val_sinistro_pendiente_fn (
      eo_dat_abo        IN              pv_datos_abo_qt,
      ev_tipo_sinie     IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_reg_coment_pv_iorserv_fn (
      ev_comentario       IN              pv_iorserv.comentario%TYPE,
	  en_num_os			  IN              pv_iorserv.num_os%TYPE,
	  sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END pv_aviso_siniestro_web_pg;
/
