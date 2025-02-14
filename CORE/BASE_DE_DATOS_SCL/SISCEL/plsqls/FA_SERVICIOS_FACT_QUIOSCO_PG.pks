CREATE OR REPLACE PACKAGE fa_servicios_fact_quiosco_pg IS
   TYPE refcursor IS REF CURSOR;

   cv_modulo_ga           CONSTANT VARCHAR2 (2)  := 'GA';
   cv_modulo_ge           CONSTANT VARCHAR2 (2)  := 'GE';
   cv_modulo_fa           CONSTANT VARCHAR2 (2)  := 'FA';
   cv_error_no_clasif     CONSTANT VARCHAR2 (30) := 'Error no clasificado';
   cn_largoerrtec         CONSTANT NUMBER        := 4000;
   cn_largodesc           CONSTANT NUMBER        := 2000;
   cn_largomaxmenslinea   CONSTANT NUMBER        := 100;
   -- para busqueda de los ciclos
   cv_tab_faciclos        CONSTANT VARCHAR2 (9)  := 'FA_CICLOS';
   cv_col_faciclos        CONSTANT VARCHAR2 (9)  := 'COD_CICLO';

   PROCEDURE fa_con_presupuesto_pr (
      en_num_proceso    IN              fa_presupuesto.num_proceso%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_det_concepto_presup_pr (
      en_num_proceso    IN              fa_presupuesto.num_proceso%TYPE,
      en_cod_concepto   IN              fa_presupuesto.cod_concepto%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_getcodigodespacho_pr (
      sv_coddespacho   OUT NOCOPY   fa_codespacho.cod_despacho%TYPE,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE fa_getciclofacturacion_pr (
      ev_cod_ciclo          OUT NOCOPY   VARCHAR2,
      ev_ano                OUT NOCOPY   VARCHAR2,
      ev_cod_ciclfact       OUT NOCOPY   VARCHAR2,
      ev_fec_vencimie       OUT NOCOPY   VARCHAR2,
      ev_fec_emision        OUT NOCOPY   VARCHAR2,
      ev_fec_caducida       OUT NOCOPY   VARCHAR2,
      ev_fec_proxvenc       OUT NOCOPY   VARCHAR2,
      ev_fec_desdellam      OUT NOCOPY   VARCHAR2,
      ev_fec_hastallam      OUT NOCOPY   VARCHAR2,
      ev_dia_periodo        OUT NOCOPY   VARCHAR2,
      ev_fec_desdecfijos    OUT NOCOPY   VARCHAR2,
      ev_fec_hastacfijos    OUT NOCOPY   VARCHAR2,
      ev_fec_desdeocargos   OUT NOCOPY   VARCHAR2,
      ev_fec_hastaocargos   OUT NOCOPY   VARCHAR2,
      ev_fec_desderoa       OUT NOCOPY   VARCHAR2,
      ev_fec_hastaroa       OUT NOCOPY   VARCHAR2,
      ev_ind_facturacion    OUT NOCOPY   VARCHAR2,
      ev_dir_logs           OUT NOCOPY   VARCHAR2,
      ev_dir_spool          OUT NOCOPY   VARCHAR2,
      ev_des_leyen1         OUT NOCOPY   VARCHAR2,
      ev_des_leyen2         OUT NOCOPY   VARCHAR2,
      ev_des_leyen3         OUT NOCOPY   VARCHAR2,
      ev_des_leyen4         OUT NOCOPY   VARCHAR2,
      ev_des_leyen5         OUT NOCOPY   VARCHAR2,
      ev_ind_tasador        OUT NOCOPY   VARCHAR2,
      sn_codretorno         OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY   ge_errores_pg.evento);

   PROCEDURE fa_getlistciclospostpago_pr (
      en_cicloprepago   IN              fa_ciclos.cod_ciclo%TYPE,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_getdiasprorrateo_pr (
      ev_codciclo        IN              VARCHAR2,
      ev_formatofecha    IN              VARCHAR2,
      sv_diasprorrateo   OUT NOCOPY      VARCHAR2,
      sv_cantdias        OUT NOCOPY      VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_getimpuesto_pr (
      ev_codcliente   IN              VARCHAR2,
      ev_codoficina   IN              VARCHAR2,
      en_importe      IN              NUMBER,
      sn_imptotal     OUT NOCOPY      NUMBER,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento);

   -- P-ECU-08019 inicio ---------------------------------------------------------------------------
   PROCEDURE fa_inserta_mensaje_pr (
      en_corrmensaje     IN              fa_mensajes.corr_mensaje%TYPE,
      ev_numlinea        IN              fa_mensajes.num_linea%TYPE,
      ev_descmensaje     IN              fa_mensajes.desc_mensaje%TYPE,
      ev_descmenslin     IN              fa_mensajes.desc_menslin%TYPE,
      ev_codidioma       IN              fa_mensajes.cod_idioma%TYPE,
      en_cantlineasmen   IN              fa_mensajes.cant_lineasmen%TYPE,
      en_cantcaractlin   IN              fa_mensajes.cant_caractlin%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_inserta_mensaje_proc_pr (
      en_numproceso      IN              fa_mensproceso.num_proceso%TYPE,
      en_codformulario   IN              fa_mensproceso.cod_formulario%TYPE,
      en_codbloque       IN              fa_mensproceso.cod_bloque%TYPE,
      en_corrmensaje     IN              fa_mensproceso.corr_mensaje%TYPE,
      en_numlineas       IN              fa_mensproceso.num_lineas%TYPE,
      ev_codorigen       IN              fa_mensproceso.cod_origen%TYPE,
      ev_descmensaje     IN              fa_mensproceso.desc_mensaje%TYPE,
      ev_indfacturado    IN              fa_mensproceso.ind_facturado%TYPE,
      ev_nomusuario      IN              fa_mensproceso.nom_usuario%TYPE,
      ev_fecingreso      IN              fa_mensproceso.fec_ingreso%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_recibe_mensaje_pr (
      en_numproceso      IN              fa_mensproceso.num_proceso%TYPE,
      ev_descormensaje   IN              fa_mensproceso.desc_mensaje%TYPE,
      ev_mensaje         IN              ci_orserv.comentario%TYPE,
      ev_nomusuario      IN              fa_mensproceso.nom_usuario%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_recibe_mensaje_fs_pr (
      en_numtransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_numproceso       IN   fa_mensproceso.num_proceso%TYPE,
      ev_descormensaje    IN   fa_mensproceso.desc_mensaje%TYPE,
      ev_mensaje          IN   ci_orserv.comentario%TYPE,
      ev_nomusuario       IN   fa_mensproceso.nom_usuario%TYPE);

   PROCEDURE fa_obtiene_numproceso_pr (
      en_numventa       IN              fa_interfact.num_venta%TYPE,
      sn_numproceso     OUT NOCOPY      fa_interfact.num_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);

   PROCEDURE fa_recibe_mencargos_fs_pr (
      en_numtransaccion   IN   ga_transacabo.num_transaccion%TYPE,
      en_num_os           IN   ci_orserv.num_os%TYPE,
      ev_cod_os           IN   ci_orserv.cod_os%TYPE,
      ev_comentario       IN   ci_orserv.comentario%TYPE);

   PROCEDURE fa_inserta_mencargos_pr (
      en_numtransaccion   IN              ga_transacabo.num_transaccion%TYPE,
      en_num_os           IN              ci_orserv.num_os%TYPE,
      ev_cod_os           IN              ci_orserv.cod_os%TYPE,
      ev_comentario       IN              ci_orserv.comentario%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);
-- P-ECU-08019 fin ------------------------------------------------------------------------------
END fa_servicios_fact_quiosco_pg;
/

SHOW ERRORS
