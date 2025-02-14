CREATE OR REPLACE PACKAGE pv_suspvolprog_pg
/*
<Documentación
TipoDoc = "Package">
<Elemento
Nombre = "GA_CONS_EUREKA_PG"
Lenguaje="PL/SQL"
Fecha="28-03-2006"
Versión="1.0"
Diseñador="Carlos Navarro H. - Marcelo Godoy S."
Programador="Marcelo Godoy S. - Carlos Navarro H."
Ambiente Desarrollo="BD">
<Retorno>NA</Retorno>
<Descripción>Package negocio de llamada a servicios Eureka</Descripción>
<Parámetros>
<Entrada>NA</Entrada>
<Salida>NA</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif             VARCHAR2 (50)                     := 'No es posible clasificar el error';
   cv_cod_modulo                  VARCHAR2 (2)                      := 'GA';
   cv_version                     VARCHAR2 (2)                      := '1';
   cv_prod_celular       CONSTANT NUMBER (2)                        := 1;
   cv_cod_actabo         CONSTANT VARCHAR2 (2)                      := 'ST';
   cn_cod_ciclo          CONSTANT NUMBER (2)                        := 25;
   cod_os_sus_vol_prog   CONSTANT NUMBER (5)                        := 10094;
   cod_os_reh_vol_prog   CONSTANT NUMBER (5)                        := 10096;
   cn_number_cero        CONSTANT NUMBER (1)                        := 0;
   gv_version            CONSTANT VARCHAR2 (5)                      := '1.0';
   gv_cod_modulo         CONSTANT VARCHAR2 (5)                      := 'GA';
   gv_null               CONSTANT NUMBER                            := NULL;
   gv_blanco             CONSTANT VARCHAR2 (1)                      := ' ';
   gn_ncobrar            CONSTANT NUMBER                            := 0;
   gn_cobrar             CONSTANT NUMBER                            := 1;
   gn_cod_producto       CONSTANT NUMBER                            := 1;
--   CV_error_no_clasif   CONSTANT VARCHAR2(30):='Error no clasificado';
   gv_mensaje_retorno             ge_errores_td.det_msgerror%TYPE;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_rec_susp_volprog_fn (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_rec_info_abonado_fn (
      seo_dat_abo       IN OUT NOCOPY   pv_abo_sus_vol_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ga_cons_hist_suspension_vol_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      ed_fec_inicio     IN              DATE,
      ed_fec_fin        IN              DATE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_modifica_suspension_pr (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rec_periodo_suspension_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_ins_periodo_suspension_pr (
      en_num_abonado    IN              pv_suspvolprog_to.num_abonado%TYPE,
      ed_fec_inicio     IN              pv_suspvolprog_to.fec_inicio%TYPE,
      ed_fec_fin        IN              pv_suspvolprog_to.fec_fin%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_ins_suspension_prg_pr (
      en_num_abonado          IN              pv_det_suspvolprog_to.num_abonado%TYPE,
      ed_fec_suspension       IN OUT NOCOPY   pv_det_suspvolprog_to.fec_suspension%TYPE,
      ed_fec_rehabilitacion   IN OUT NOCOPY   pv_det_suspvolprog_to.fec_rehabilitacion%TYPE,
      ev_causal               IN              pv_det_suspvolprog_to.cod_causal%TYPE,
      ev_usuario              IN              pv_det_suspvolprog_to.usuario%TYPE,
      num_os_sus              IN              pv_det_suspvolprog_to.num_os_sus%TYPE,
      num_os_reh              IN              pv_det_suspvolprog_to.num_os_reh%TYPE,
      ev_comentario           IN              pv_iorserv.comentario%TYPE,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ga_upd_suspension_abonado_fn (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rec_causa_suspension_pr (
      sc_resultado      OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_cons_suspension_vol_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rec_fec_susp_vol_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_param_general_susp_vol_pr (
      sv_dias_max_susp_vol    OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sv_dias_antes_sus_vol   OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sn_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_inscribe_ooss_pr (
      pv_iorserv        IN OUT NOCOPY   pv_iorserv_ot,
      pv_erecorrido     IN OUT NOCOPY   pv_erecorrido_qt,
      pv_movimientos    IN OUT NOCOPY   pv_movimientos_ot,
      pv_camcom         IN OUT NOCOPY   pv_camcom_ot,
      pv_param_abocel   IN OUT NOCOPY   pv_param_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_anula_susvolprog_pr (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE ga_anulaXbatch_pr (
      pv_det_suspvolprog   IN OUT NOCOPY   pv_det_suspvolprog_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE pv_recupera_servsupl_cob_pr (
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      sc_cursor         OUT NOCOPY      refcursor,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_recupera_servsupl_pr (
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      sc_cursor         OUT NOCOPY      refcursor,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_modifica_servcob_pr (
      en_cod_servsupl   IN              ga_servsupl_cob_to.cod_servsupl%TYPE,
      en_cod_servicio   IN              ga_servsupl_cob_to.cod_servicio%TYPE,
      en_ind_cob        IN              NUMBER,
      sn_num_evento     OUT NOCOPY      NUMBER,
      sv_mens_retorno   OUT NOCOPY      VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_upd_anula_erecorrido_fn (
      pv_erecorrido     IN              pv_erecorrido_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ga_rehabilita_pr (
      pv_det_suspvolprog IN OUT NOCOPY pv_det_suspvolprog_qt,
          EN_num_oosss       IN pv_iorserv.num_os%TYPE,
          EV_cod_os          IN pv_iorserv.cod_os%TYPE,
          SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      SN_num_evento      OUT NOCOPY   ge_errores_pg.evento
    );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_VAL_SINIESTRO_PENDIENTE_PR(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT NOCOPY VARCHAR2,
      vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_borra_periodos_pr (
      en_num_ooss       IN  pv_det_suspvolprog_to.num_os_sus%type,
          en_num_abonado    IN  ga_abocel.num_abonado%type,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
          );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_cons_ciclo_fact_fn (
      en_cod_cliente    IN fa_ciclocli.cod_cliente%TYPE,
          en_num_abonado        IN fa_ciclocli.num_abonado%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento             OUT NOCOPY ge_errores_pg.evento
   )
      RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_rec_periodos_histabonado_pr (
          en_num_abonado    IN  ga_abocel.num_abonado%type,
          sc_resultado      OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_cons_proxciclo_fact_fn (
      en_cod_cliente    IN fa_ciclocli.cod_cliente%TYPE,
          en_num_abonado        IN fa_ciclocli.num_abonado%TYPE,
      sn_cod_retorno    OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
      sn_num_evento             OUT NOCOPY ge_errores_pg.evento
   )
      RETURN NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_val_baja_abonado_pr(
      v_param_entrada IN  VARCHAR2,
      bRESULTADO      OUT NOCOPY VARCHAR2,
      vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
   );
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE PV_ESTADO_SUS_PROG_ABONADO_PR(
      EV_v_param_entrada IN  VARCHAR2,
      EV_bRESULTADO      OUT NOCOPY VARCHAR2,
      EV_vMENSAJE        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
          );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION pv_upd_anula_iorserv_fn (
     pv_iorserv     IN              pv_iorserv_ot,
     sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
     sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
     sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
  )
  RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


FUNCTION ga_upd_diasacum_suspension_fn (
      en_num_periodosusp   IN              pv_suspvolprog_to.num_periodosusp%TYPE,
      en_num_abonado       IN              pv_suspvolprog_to.num_abonado%TYPE,
      en_dias_acum         IN              pv_suspvolprog_to.dias_acum%TYPE,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION pv_upd_fh_ejecucion_reh_fn (
     pv_det_suspvolprog   IN           pv_det_suspvolprog_qt,
     sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
     sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
     sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
  )
      RETURN BOOLEAN;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

END pv_suspvolprog_pg;
/
SHOW ERRORS