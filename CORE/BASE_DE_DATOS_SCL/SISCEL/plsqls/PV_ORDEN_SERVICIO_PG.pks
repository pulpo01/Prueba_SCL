CREATE OR REPLACE PACKAGE PV_ORDEN_SERVICIO_PG
IS
   TYPE refcursor IS REF CURSOR;

   TYPE scadenagenera_ss_aux IS RECORD (
      cod_servicio   VARCHAR2 (6)
   );

   TYPE typ_tab_ss IS TABLE OF scadenagenera_ss_aux
      INDEX BY BINARY_INTEGER;

   scadenagenera_ss               typ_tab_ss;
   cv_error_no_clasif    CONSTANT VARCHAR2 (50)
                                        := 'No es posible clasificar el error';
   cv_cod_modulo         CONSTANT VARCHAR2 (2)  := 'GA';   
   cv_version            CONSTANT VARCHAR2 (2)  := '1';
   cn_estado_10          CONSTANT NUMBER (2)    := 10;
   cn_tip_estado_3       CONSTANT NUMBER (2)    := 3;
   cn_tip_estado_4       CONSTANT NUMBER (2)    := 4;
   cn_atrib_estado_2     CONSTANT NUMBER (2)    := 2;
   cn_atrib_estado_3     CONSTANT NUMBER (2)    := 3;
   cv_cod_aplic          CONSTANT VARCHAR2 (3)  := 'PVA';
   cn_cod_estado         CONSTANT NUMBER (3)    := 210;
   cv_tip_subjeto_c      CONSTANT VARCHAR2 (1)  := 'C';
   cv_tip_subjeto_a      CONSTANT VARCHAR2 (1)  := 'A';
   cn_producto           CONSTANT NUMBER        := 1;
   cv_val_prm_estado     CONSTANT VARCHAR2 (15) := 'EST_RESPCENTRAL';
   cv_val_prm_maxint     CONSTANT VARCHAR2 (12) := 'MAX_INTENTOS';
   cv_formato_fecha      CONSTANT VARCHAR2 (25) := 'DD-MM-YYYY HH24:MI:SS';
   cn_cero               CONSTANT NUMBER        := 0;
   cn_tiprango           CONSTANT VARCHAR2 (5)  := 'M';
   cn_incompatibilidad   CONSTANT NUMBER        := 3;
   cv_serv_traf_nacc     CONSTANT VARCHAR2 (21) := 'SERV_TRAF_NACCONTRAT';
   cv_baja_hibrido       CONSTANT VARCHAR2 (15) := 'BAJA_HIBRIDO';
   cv_error_no_data      CONSTANT VARCHAR2 (60)
                                          := 'No es posible obtener tip_comis';
   cv_pak_func_valida    CONSTANT VARCHAR2 (22) := '17';
   cn_cod_prod           CONSTANT NUMBER        := 1;
   -- Inicio JLMN
   cv_serv_frm           CONSTANT VARCHAR2 (10) := 'FRIEND_FAM';
   cv_tip_serv           CONSTANT VARCHAR2 (1)  := '2';
   cv_act_frm            CONSTANT VARCHAR2 (2)  := 'FA';
   cn_tip_estado         CONSTANT NUMBER        := 2;
   cn_ind_frf            CONSTANT NUMBER        := 1;
   cv_sit_baja           CONSTANT VARCHAR2 (3)  := 'BAA';
   cv_sit_baja_proceso   CONSTANT VARCHAR2 (3)  := 'BAP';
   cv_tip_frec_m         CONSTANT VARCHAR2 (1)  := 'M';

   TYPE tip_numfrec_serv IS RECORD (
      num_telefesp    GA_NUMESPABO.num_telefesp%TYPE,
      tip_frecuente   GA_NUMESPABO.tip_frecuente%TYPE,
      ind_ff          NUMBER,
      cod_cliente     GA_ABOCEL.cod_cliente%TYPE
   );

   TYPE tip_numfrec_serv_list IS TABLE OF tip_numfrec_serv
      INDEX BY PLS_INTEGER;

   TYPE tip_abon_cel IS RECORD (
      NUM_ABONADO   GA_ABOCEL.NUM_ABONADO%TYPE,
      num_celular   GA_ABOCEL.num_celular%TYPE,
      cod_cliente   GA_ABOCEL.cod_cliente%TYPE
   );

   TYPE tip_abon_cel_list IS TABLE OF tip_abon_cel
      INDEX BY PLS_INTEGER;

   TYPE tip_abon_serv IS RECORD (
      clase_servicio   GA_ABOCEL.clase_servicio%TYPE,
      perfil_abonado   GA_ABOCEL.perfil_abonado%TYPE,
      NUM_ABONADO      GA_ABOCEL.NUM_ABONADO%TYPE,
      cod_situacion    GA_ABOCEL.cod_situacion%TYPE
   );

   TYPE tip_abon_serv_list IS TABLE OF tip_abon_serv
      INDEX BY PLS_INTEGER;

   TYPE tip_ga_grupos_servsup IS TABLE OF GA_GRUPOS_SERVSUP%ROWTYPE
      INDEX BY PLS_INTEGER;

   TYPE tip_ga_actuaserv IS TABLE OF GA_ACTUASERV%ROWTYPE
      INDEX BY PLS_INTEGER;

   TYPE tip_ga_servsupl IS TABLE OF GA_SERVSUPL%ROWTYPE
      INDEX BY PLS_INTEGER;

   TYPE tip_ga_servsuplabo IS TABLE OF GA_SERVSUPLABO%ROWTYPE
      INDEX BY PLS_INTEGER;

   TYPE tip_ga_intarcel IS TABLE OF GA_INTARCEL%ROWTYPE
      INDEX BY PLS_INTEGER;

   TYPE tip_ga_numespabo IS TABLE OF GA_NUMESPABO%ROWTYPE
      INDEX BY PLS_INTEGER;

-----------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_programados_pr (
      eo_servfrec         IN              pv_desact_servfrec_qt,
      eo_frecuentes_lst   IN              pv_frecuentes_lst_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_online_pr (
      eo_servfrec         IN              pv_desact_servfrec_qt,
      eo_frecuentes_lst   IN              pv_frecuentes_lst_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

      -- Fin JLMN
-----------------------------------------------------------------------------------------------------
   PROCEDURE pv_generass_ctaseg_central_pr (
      so_ga_abonado     IN OUT NOCOPY   ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
-- metodo obtenerCodigoPenalizacion
   PROCEDURE pv_obtener_codpenaliza_pr (
      so_ga_abonado     IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------------------------------------------------
-- metodo:  obtenerRangoAntiguedad
   PROCEDURE pv_rango_antiguedad_pr (
      so_ga_abonado     IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
--1.- Metodo : registraNivelOoss (FE)
   PROCEDURE pv_regist_nivel_modifi_pr (
      eo_regist_nivel_modif   IN OUT NOCOPY   pv_regist_nivel_modif_qt,
      sn_cod_retorno          OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno         OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento           OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
--2.-  Metodo : RegistraCambPlanBatch (FE)
   PROCEDURE pv_registr_camb_plan_batch_pr (
      eo_orden_servicio   IN OUT NOCOPY   pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
--3.- Metodo validaOossPendPlan (Reg)
   PROCEDURE pv_validaooss_pendplan_pr (
      eo_validaooss_pendplan   IN OUT NOCOPY   pv_validaooss_pendplan_qt,
      sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento
   );

   ------------------------------------------------------------------------------------------------------
--4.- Metodo  :  AnulaOossPendPlan
   PROCEDURE pv_anulaooss_pendplan_pr (
      eo_iorserv        IN OUT NOCOPY   pv_iorserv_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

  -------------------------------------------------------------------------------------------------------
--5,- Metodo : validarRestriccionComerOoss         PV_ORDEN_SERVICIO_PG.PV_VAL_RESTRIC_COMER_OoSS_PR
   PROCEDURE pv_val_restric_comer_ooss_pr (
      eo_val_restric_comer_ooss   IN              pv_val_restr_comer_os_qt,
      sn_cod_retorno              OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno             OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento               OUT NOCOPY      ge_errores_pg.evento
   );

   -------------------------------------------------------------------------------------------------------
--6,- Metodo : obtenerConversionOOSS
   PROCEDURE pv_obtener_conversion_pr (
      eo_orserv         IN              pv_orden_servicio_qt,
      so_conversion     OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

  -------------------------------------------------------------------------------------------------------
-- 7.-  Metodo actualizarComentPvIorserv        PL      PV_ACT_COMENT_PVIORSERV_PR
   PROCEDURE pv_act_coment_pviorserv_pr (
      so_iorserv_qt     IN              pv_iorserv_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------
    -- 8.-  Metodo validarPortabilidad              FNC     PV_VALIDAR_PORTABILIDAD_FN
   FUNCTION pv_validar_portabilidad_fn (
      so_ga_abonado     IN OUT NOCOPY   ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR;

-----------------------------------------------------------------------------------------------------
    -- 9.-  Metodo insertarTransacabo
   PROCEDURE pv_insertar_trasacabo_pr (
      en_num_secuencia   IN              NUMBER,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

-------------------------------------------------------------------------------------------------------
---   asociado al m¿todo obtenerGrupoNivelContratado
   PROCEDURE pv_obt_grupo_nivelcont_pr (
      so_servsuplabo_qt   IN OUT NOCOPY   ga_servsuplabo_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

    ------------------------------------------------------------------------------------------------------
-- asociado al m¿todo bajaSSPrepago
   PROCEDURE pv_baja_ss_prepago_pr (
      so_abonado_qt     IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------------------------------------------------
-- asociada al m¿todo bajaRegTarif
   PROCEDURE pv_baja_reg_tarif_pr (
      so_abonado_qt     IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------
--  obtenerConverActAbo
   PROCEDURE pv_obtener_convert_actabo_pr (
      so_actabotiplan_qt   IN OUT NOCOPY   pv_actabo_tiplan_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno      OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_registra_ooss_enlinea_pr (
      so_ooss_online    IN              ge_ooss_en_linea_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   FUNCTION pv_validar_serv_dupl_fn (
      so_ga_abonado     IN              ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN VARCHAR2;

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_insert_traspaso_cargo_pr (
      reg_pv_traspaso_cargos   IN              pv_trasp_cargos,
      sn_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento            OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_bregmovccontrolada_pr (
      eo_abonado        IN OUT          ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_registra_excepcion_pv_pr (
      eo_ga_cliente     IN OUT NOCOPY   pv_ga_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_fachada_excepcion_pv_pr (
      en_num_abonado     IN              GA_ABOCEL.NUM_ABONADO%TYPE,
      en_plan_destino    IN              GA_ABOCEL.cod_plantarif%TYPE,
      en_cod_cliente     IN              GA_ABOCEL.cod_cliente%TYPE,
      ev_param           IN              VARCHAR2,
      sv_insertookv      OUT NOCOPY      NUMBER,
      sn_cod_retornov    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retornov   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_eventov     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_causa_de_excepcion_pr (
      so_causas         OUT NOCOPY   refcursor,
      sn_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
   );

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE pv_valida_lista_negra_pr (
      so_abonado        IN OUT NOCOPY   ga_abonado_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

------------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_ff_online_pr (
      eo_servfrec         IN              pv_desact_servfrec_qt,
      eo_frecuentes_lst   IN              pv_frecuentes_lst_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

----------------------------------------------------------------------------------------------------
   PROCEDURE pv_eli_frec_online_pr (
      eo_servfrec       IN              pv_desact_servfrec_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------
   PROCEDURE pv_reg_frec_ff_programados_pr (
      eo_servfrec       IN              pv_desact_servfrec_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------------------
   PROCEDURE pv_validareversa_pr (
      eo_orden_servicio   IN OUT          pv_orden_servicio_qt,
      sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------
--actualizarUsoIntarcel
   PROCEDURE pv_act_uso_intarcel_pr (
      so_ga_abocel      IN              pv_ga_abocel_qt,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-----------------------------------------------------------------------------------------
   PROCEDURE pv_obtieneooss_pendplan_pr (
      eo_iorserv        IN OUT NOCOPY   pv_iorserv_qt,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );

-------------------------------------------------------------------------------------------------------
   PROCEDURE pv_cnslta_combinatoria_pr (
      eo_combinatoria_os   IN OUT NOCOPY   pv_combinatoria_os_qt,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento
   );

-------------------------------------------------------------------------------------------------------
   PROCEDURE pv_cnslta_datos_comis_pr (
      eo_seg_usuario     IN OUT NOCOPY   ge_seg_usuario_qt,
      eo_pv_comis_ooss   IN OUT NOCOPY   pv_comis_ooss_qt,
      sn_cod_retorno     OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno    OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   );

--------------------------------------------------------------------------------------
   PROCEDURE cambia_estado_solicitud_pr (
      en_numsolicitud   IN              ERT_SOLICITUD.num_solicitud%TYPE,
      en_codestado      IN              ERT_SOLICITUD.cod_estado%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
      sv_mens_retorno   OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   );
--------------------------------------------------------------------------------------
PROCEDURE PV_ACTUALIZA_CLASESERVICIO_PR( EN_COD_PRODUCTO IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                         EN_NUM_ABONADO  IN GA_ABOCEL.NUM_ABONADO%TYPE
                                        );
--------------------------------------------------------------------------------------
--PROCEDIMIENTO QUE CONSULTA LA CANTIDAD DE EVENTOS REALIZADOS POR UN ABONADO-CLIENTE REFERENCTE A LOS NUMEROS FRECUENTES
--MODIFICACION, ELIMINACION E INSERCION
PROCEDURE PV_CONS_EVENTO_NUMFREC_PR(
      EN_NUM_ABONADO       IN        GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_COD_CLIENTE       IN        GA_ABOCEL.COD_CLIENTE%TYPE,
      EV_COD_OS            IN        PV_IORSERV.COD_OS%TYPE,
      SN_RETORNO        OUT NOCOPY      NUMBER,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   ) ;

--------------------------------------------------------------------------------------
--PROCEDIMIENTO QUE INSERTA UN REGISTRO POR EL USO DE LA OOSS CAMBIO DE NUMEROS FRECUENTES
--MODIFICACION, ELIMINACION E INSERCION
PROCEDURE PV_INSER_EVENTO_NUMFREC_PR(
      EN_NUM_ABONADO       IN        GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_COD_CLIENTE       IN        GA_ABOCEL.COD_CLIENTE%TYPE,
      EV_COD_OS            IN        PV_IORSERV.COD_OS%TYPE,
      EN_NUM_OS            IN        PV_IORSERV.NUM_OS%TYPE,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   ) ;

--------------------------------------------------------------------------------------
--FUNCION QUE CONSULTA LA CANTIDAD DE EVENTOS REALIZADOS POR UN ABONADO-CLIENTE REFERENCTE A LOS NUMEROS FRECUENTES
--MODIFICACION, ELIMINACION E INSERCION
PROCEDURE PV_MONTO_EVENTO_NUMFREC_PR(
      EN_NUM_ABONADO       IN        GA_ABOCEL.NUM_ABONADO%TYPE,
      EN_COD_CLIENTE       IN        GA_ABOCEL.COD_CLIENTE%TYPE,
      EV_COD_OS            IN        PV_IORSERV.COD_OS%TYPE,
      SN_MONTO        OUT NOCOPY      NUMBER,
      EN_COD_CONCEPTO   OUT NOCOPY      NUMBER,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   );

PROCEDURE PV_REG_CAUSACAMBIOPLAN_OS_PR(
      EN_NUM_OS            IN        PV_CAUSA_PLAN_OOSS_TO.NUM_OS%TYPE,
      EV_COD_OS            IN        PV_CAUSA_PLAN_OOSS_TO.COD_OS%TYPE,
      EV_CAUSA             IN        PV_CAUSA_PLAN_OOSS_TO.COD_CAUSA%TYPE,
      EV_COD_PLANTARIF     IN        PV_CAUSA_PLAN_OOSS_TO.COD_PLANTARIF%TYPE,
      EV_USUARIO           IN        PV_CAUSA_PLAN_OOSS_TO.NOM_USUARORA%TYPE,
      EN_NUM_ABONADO       IN        PV_CAUSA_PLAN_OOSS_TO.NUM_ABONADO%TYPE,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   );

-------------------------------------------------------------

PROCEDURE PV_CARGA_CAUSACAMBIOPLAN_PR(
      SV_CAUSAS         OUT NOCOPY      refcursor ,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   );

-------------------------------------------------------------


PROCEDURE PV_ACT_PARAM_COMERCIAL_PR(
      EO_PARAM_COMER     IN             PV_ACT_PARAM_COMERCIAL_QT,
      SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
      SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
      SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   );

-------------------------------------------------------------

PROCEDURE pv_registrar_carta_pr (
   EN_NUM_OOSS         IN CI_ORSERV.NUM_OS%TYPE,
                                  EN_COD_OOSS         IN CI_TIPORSERV.COD_OS%TYPE,
                                  EV_Texto            in CI_CARTAS.TEXTO%TYPE,
                                  SN_COD_RETORNO    OUT NOCOPY      GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                  SV_MENS_RETORNO   OUT NOCOPY      GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                  SN_NUM_EVENTO     OUT NOCOPY      GE_ERRORES_PG.EVENTO
   );


PROCEDURE pv_update_carta_pr (
   EN_NUM_OOSS         IN CI_ORSERV.NUM_OS%TYPE,
   SN_COD_RETORNO    OUT       varchar2,
   SV_MENS_RETORNO   OUT       varchar2,
   SN_NUM_EVENTO     OUT      varchar2
   );



END PV_ORDEN_SERVICIO_PG;
/
SHOW ERRORS