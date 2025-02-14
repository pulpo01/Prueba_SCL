CREATE OR REPLACE PACKAGE pv_grabar_simcard_sb_pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "PV_CAMBIO_SIMCARD_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="18-07-2007"
          Versión="1.0"
          Diseñador= "Marcelo Godoy"
        Programador="Marcelo Godoy"
          Ambiente Desarrollo="BD">
      <Descripción>Package servicios cambio de simcard</Descripción>
  </Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;
   

   cv_error_no_clasif   CONSTANT VARCHAR2(50) := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2(2)  := 'PV';
   cv_version           CONSTANT VARCHAR2(2)  := '1';
   cv_prod_celular      CONSTANT NUMBER  (2)  := 1;
   cv_cod_modulo_ga     CONSTANT VARCHAR2(2)  := 'GA';
   cv_programa            CONSTANT VARCHAR2(3)  := 'GPA';
   cn_def_retorno       CONSTANT number       := 156;
   cv_def_error         CONSTANT VARCHAR2(50) := 'Error al realizar el cambio de simcard';
   LV_des_error         ge_errores_pg.DesEvent;

    PROCEDURE pv_registra_nueva_simcard_pr (
      ev_cambioserie           IN OUT NOCOPY    PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_ins_serie_prom_pre_pr (
      ev_cambioserie           IN OUT NOCOPY    PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE pv_autentificacion_pr (
      ev_cambioserie           IN               PV_CAM_SIMCARD_OT,
      SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actualiza_caucambio_sim_pr (
      ev_cambioserie    IN              PV_CAM_SIMCARD_OT,
      sn_cod_retorno    IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_registra_equip_seriados_pr (
      ev_cambioserie    IN              PV_CAM_SIMCARD_OT,
      sn_cod_retorno    IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     IN OUT NOCOPY   ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actualiza_dat_abonados_pr (
      ev_cambioserie    IN              PV_CAM_SIMCARD_OT,
      sn_cod_retorno    IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   IN OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     IN OUT NOCOPY   ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actualiza_promociones_pr (
      ev_cambioserie    IN              PV_CAM_SIMCARD_OT,
      sn_cod_retorno    IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     IN OUT NOCOPY   ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_elimina_reserva_pr (
      ev_cambioserie       IN              PV_CAM_SIMCARD_OT,
      sn_cod_retorno       IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        IN OUT NOCOPY    ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_actualiza_pass_pr (
      ev_cambioserie    IN              PV_CAM_SIMCARD_OT,
      sn_cod_retorno    IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     IN OUT NOCOPY    ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
  FUNCTION pv_rec_num_servicios_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            OUT NOCOPY     ge_errores_pg.evento)
    RETURN VARCHAR2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION pv_consulta_secuencia_pr (
    EV_nombre                IN             VARCHAR2,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)
  RETURN number;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION pv_recupera_transacabo_pr (
    secuencia                IN             NUMBER,
    mensaje                  IN OUT NOCOPY  VARCHAR2,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento)
  RETURN VARCHAR2;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RFA ---
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE grabaError(
    EV_NombrePL              in              varchar2,
    LV_sSql                  IN              ge_errores_pg.vQuery,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_procesa_documento_pr (
    EV_cambioserie           IN              PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_registra_mod_abonado_pr (
    EV_cambioserie           IN              PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_resp_seguro_hist_pr (
    EV_cambioserie           IN              PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY    ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_act_serie_seguro_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_consulta_grupo_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_rec_canal_venta_pr (
    EV_cambioserie           IN out NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_ins_movimiento_central_pr (
    EV_cambioserie           IN OUT NOCOPY   PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 PROCEDURE pv_rec_parametros_iniciales_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_graba_cambio_simcard_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_actualiza_seguro_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_aceptarEqInterno_pr (
    EV_cambioserie           IN out nocopy  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_autenticacion2_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_insertEquiAbo_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_actualiza_stock_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY   ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_EjecutaInsertaCel_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_bInsertMovim_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_desActivaAutenticacion_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_activaAutenticacion_pr (
    EV_cambioserie           IN             PV_CAM_SIMCARD_OT,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE pv_rec_num_periodo_prom_pr (
    EV_cambioserie           IN OUT NOCOPY  PV_CAM_SIMCARD_OT,
    SN_cod_retorno           OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            OUT NOCOPY     ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
END pv_grabar_simcard_sb_pg;
/
SHOW ERRORS