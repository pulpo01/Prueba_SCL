CREATE OR REPLACE PACKAGE pv_anula_siniestro_sb_pg
IS
   TYPE refcursor IS REF CURSOR;

   cv_error_no_clasif   CONSTANT VARCHAR2(50) := 'No es posible clasificar el error';
   cv_cod_modulo        CONSTANT VARCHAR2(2)  := 'PV';
   cv_version           CONSTANT VARCHAR2(2)  := '1';
   cv_prod_celular      CONSTANT NUMBER  (2)  := 1;
   cv_CodActAbo         CONSTANT VARCHAR2 (4)  := 'AN';
   cv_cod_modulo_ga     CONSTANT VARCHAR2(2)  := 'GA';
   cv_programa			CONSTANT VARCHAR2(3)  := 'GPA';
   cn_def_retorno       CONSTANT number       := 156;
   raise_err_def        CONSTANT number       :=  -20001;
   cv_def_error         CONSTANT VARCHAR2(50) := 'Error al realizar el cambio de simcard';
   cv_nombre_pachages   constant VARCHAR2(30) := 'pv_anula_siniestro_sb_pg';

   TYPE vCursor IS REF CURSOR;
---------------------------------------------------------------------------------------------------------
PROCEDURE grabaError(
    EV_NombrePL              IN             VARCHAR2,
	EV_param                 IN             PV_ANULA_SINIESTRO_OT,
    LV_sSql                  IN             ge_errores_pg.vQuery,
    SN_cod_retorno           IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno          IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento            IN OUT NOCOPY  ge_errores_pg.evento,
	EB_EjecutaRaise          IN BOOLEAN  default true);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_graba_anula_siniestro_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
FUNCTION PV_REC_DATOS_SINIESTROS_FN      (
      eo_dat_abo        IN                PV_DATOS_ABO_QT,
      sv_cursor         OUT               vcursor,
      sn_cod_retorno    OUT NOCOPY        ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY        ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY        ge_errores_pg.evento) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_rec_cargos_basicos_orgi_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_rec_cargos_basicos_ant_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_Anular_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_InsertarDetalle_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 FUNCTION pv_ChequeaTerminal_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento) RETURN BOOLEAN;
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_cuenta_suspenciones_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_datos_siniestros_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_cuenta_siniestro_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_recuperaModuloSuspencion_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
--------------------------------------------------------------------------------------------------------
 PROCEDURE pv_rehabilitar_suspension_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_act_estado_abonado_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_datos_causa_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_ga_susprehaboXabonado_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_rec_indSuspencion_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_act_ga_susprehabo_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_GeneraMovimientos_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_InsertaMovimiento_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_IngIntGestor_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
 PROCEDURE pv_RestituirCargoBasico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_rec_UltPlanTaifFact_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_recCargobasicSiniestro_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_RecImpCargoBasico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_RecImpCargoBasicoCausa_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_EjecutarPLCargoBasico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_BorrarListasNegras_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_PasoHistorico_pr (
    EV_param           IN OUT NOCOPY  PV_ANULA_SINIESTRO_OT,
	abonado            IN OUT NOCOPY  PV_DATOS_ABO_QT,
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);
-------------------------------------------------------------------------------------------------------
PROCEDURE pv_anulardenuncia_pr
 (
    EV_param           IN PV_ANULA_SINIESTRO_OT, 
    NUM_CONS_POLANUL   IN GA_SINIESTROS.NUM_CONSTPOL_ANULA%TYPE,  
    SN_cod_retorno     IN OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
    SV_mens_retorno    IN OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
    SN_num_evento      IN OUT NOCOPY  ge_errores_pg.evento);


END pv_anula_siniestro_sb_pg;
/
