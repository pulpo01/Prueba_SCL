CREATE OR REPLACE PACKAGE pv_general_ooss_pg
IS
   TYPE vcursor IS REF CURSOR;

   vp_num_abonado             ga_abocel.num_celular%TYPE;
   vp_cod_producto            ga_abocel.cod_producto%TYPE;
   vp_cod_cliente             ga_abocel.cod_cliente%TYPE;
   vp_cod_cuenta              ga_abocel.cod_cuenta%TYPE;
   vp_cod_subcuenta           ga_abocel.cod_subcuenta%TYPE;
   vp_cod_usuario             ga_abocel.cod_usuario%TYPE;
   vp_cod_region              ga_abocel.cod_region%TYPE;
   vp_cod_provincia           ga_abocel.cod_provincia%TYPE;
   vp_cod_ciudad              ga_abocel.cod_ciudad%TYPE;
   vp_cod_celda               ga_abocel.cod_celda%TYPE;
   vp_cod_central             ga_abocel.cod_central%TYPE;
   vp_cod_uso                 ga_abocel.cod_uso%TYPE;
   vp_cod_situacion           ga_abocel.cod_situacion%TYPE;
   vp_ind_procalta            ga_abocel.ind_procalta%TYPE;
   vp_ind_procequi            ga_abocel.ind_procequi%TYPE;
   vp_cod_vendedor            ga_abocel.cod_vendedor%TYPE;
   vp_cod_vendedor_agente     ga_abocel.cod_vendedor_agente%TYPE;
   vp_tip_plantarif           ga_abocel.tip_plantarif%TYPE;
   vp_tip_terminal            ga_abocel.tip_terminal%TYPE;
   vp_cod_plantarif           ga_abocel.cod_plantarif%TYPE;
   vp_cod_cargobasico         ga_abocel.cod_cargobasico%TYPE;
   vp_cod_planserv            ga_abocel.cod_planserv%TYPE;
   vp_cod_limconsumo          ga_abocel.cod_limconsumo%TYPE;
   vp_num_serie               ga_abocel.num_serie%TYPE;
   vp_num_seriehex            ga_abocel.num_seriehex%TYPE;
   vp_nom_usuarora            ga_abocel.nom_usuarora%TYPE;
   vp_fec_alta                ga_abocel.fec_alta%TYPE;
   vp_num_percontrato         ga_abocel.num_percontrato%TYPE;
   vp_cod_estado              ga_abocel.cod_estado%TYPE;
   vp_num_seriemec            ga_abocel.num_seriemec%TYPE;
   vp_cod_holding             ga_abocel.cod_holding%TYPE;
   vp_cod_empresa             ga_abocel.cod_empresa%TYPE;
   vp_cod_grpserv             ga_abocel.cod_grpserv%TYPE;
   vp_ind_supertel            ga_abocel.ind_supertel%TYPE;
   vp_num_telefija            ga_abocel.num_telefija%TYPE;
   vp_cod_opredfija           ga_abocel.cod_opredfija%TYPE;
   vp_cod_carrier             ga_abocel.cod_carrier%TYPE;
   vp_ind_prepago             ga_abocel.ind_prepago%TYPE;
   vp_ind_plexsys             ga_abocel.ind_plexsys%TYPE;
   vp_cod_central_plex        ga_abocel.cod_central_plex%TYPE;
   vp_num_celular_plex        ga_abocel.num_celular_plex%TYPE;
   vp_num_venta               ga_abocel.num_venta%TYPE;
   vp_cod_modventa            ga_abocel.cod_modventa%TYPE;
   vp_cod_tipcontrato         ga_abocel.cod_tipcontrato%TYPE;
   vp_num_contrato            ga_abocel.num_contrato%TYPE;
   vp_num_anexo               ga_abocel.num_anexo%TYPE;
   vp_fec_cumplan             ga_abocel.fec_cumplan%TYPE;
   vp_cod_credmor             ga_abocel.cod_credmor%TYPE;
   vp_cod_credcon             ga_abocel.cod_credcon%TYPE;
   vp_cod_ciclo               ga_abocel.cod_ciclo%TYPE;
   vp_ind_factur              ga_abocel.ind_factur%TYPE;
   vp_ind_suspen              ga_abocel.ind_suspen%TYPE;
   vp_ind_rehabi              ga_abocel.ind_rehabi%TYPE;
   vp_ind_insguias            ga_abocel.ind_insguias%TYPE;
   vp_fec_fincontra           ga_abocel.fec_fincontra%TYPE;
   vp_fec_recdocum            ga_abocel.fec_recdocum%TYPE;
   vp_fec_cumplimen           ga_abocel.fec_cumplimen%TYPE;
   vp_fec_acepventa           ga_abocel.fec_acepventa%TYPE;
   vp_fec_actcen              ga_abocel.fec_actcen%TYPE;
   vp_fec_baja                ga_abocel.fec_baja%TYPE;
   vp_fec_bajacen             ga_abocel.fec_bajacen%TYPE;
   vp_fec_ultmod              ga_abocel.fec_ultmod%TYPE;
   vp_cod_causabaja           ga_abocel.cod_causabaja%TYPE;
   vp_num_personal            ga_abocel.num_personal%TYPE;
   vp_ind_seguro              ga_abocel.ind_seguro%TYPE;
   vp_clase_servicio          ga_abocel.clase_servicio%TYPE;
   vp_perfil_abonado          ga_abocel.perfil_abonado%TYPE;
   vp_num_min                 ga_abocel.num_min%TYPE;
   vp_cod_vendealer           ga_abocel.cod_vendealer%TYPE;
   vp_ind_disp                ga_abocel.ind_disp%TYPE;
   vp_cod_password            ga_abocel.cod_password%TYPE;
   vp_ind_password            ga_abocel.ind_password%TYPE;
   vp_cod_afinidad            ga_abocel.cod_afinidad%TYPE;
   vp_fec_prorroga            ga_abocel.fec_prorroga%TYPE;
   vp_ind_eqprestado          ga_abocel.ind_eqprestado%TYPE;
   vp_flg_contdigi            ga_abocel.flg_contdigi%TYPE;
   vp_fec_altantras           ga_abocel.fec_altantras%TYPE;
   vp_cod_tecnologia          ga_abocel.cod_tecnologia%TYPE;
   vp_num_imei                ga_abocel.num_imei%TYPE;
   vp_cod_indemnizacion       ga_abocel.cod_indemnizacion%TYPE;
   vp_num_min_mdn             ga_abocel.num_min_mdn%TYPE;
   vp_fec_activacion          ga_abocel.fec_activacion%TYPE;
   vp_ind_telefono            ga_abocel.ind_telefono%TYPE;
   cn_cod_producto   CONSTANT NUMBER (1)                           := 1;
   cv_cod_actabo     CONSTANT VARCHAR2 (2)                         := 'AS';
   cv_cod_modulo     CONSTANT VARCHAR2 (4)                         := 'GA';
   cn_cod_ciclo      CONSTANT NUMBER (2)                           := 25;

   CV_error_no_clasif           CONSTANT VARCHAR2(30):='Error no clasificado';

-- Inicio Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004
--FUNCTION PV_RETORNA_VERSION_GENERAL_FN RETURN VARCHAR2;
   FUNCTION retorna_version
      RETURN VARCHAR2;

-- Fin Modificacion - Rodrigo Munoz E. - TM-200411151097 - 30/11/2004
   PROCEDURE pv_datos_abonado_pr (
      vp_num_celular   IN       ga_abocel.num_celular%TYPE,
      vp_implimcons    OUT      NUMBER,
      vp_proc          OUT      VARCHAR2,
      vp_tabla         OUT      VARCHAR2,
      vp_act           OUT      VARCHAR2,
      vp_sqlcode       OUT      VARCHAR2,
      vp_sqlerrm       OUT      VARCHAR2,
      vp_error         OUT      VARCHAR2
   );

   PROCEDURE pv_parametros_ooss_pr (
      ev_cod_ooss       IN       VARCHAR2,
      sv_descripcion    OUT      VARCHAR2,
      sn_tip_procesa    OUT      NUMBER,
      sv_cod_modgener   OUT      VARCHAR2,
      sv_des_estadoc    OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2
   );

   FUNCTION pv_ins_iorserv_fn (
      en_num_os         IN       pv_iorserv.num_os%TYPE,             --NUMBER
      ev_cod_os         IN       pv_iorserv.cod_os%TYPE,          --VARCHAR2,
      ev_descripcion    IN       pv_iorserv.descripcion%TYPE,     --VARCHAR2,
      en_producto       IN       pv_iorserv.producto%TYPE,          --NUMBER,
      ev_usuario        IN       pv_iorserv.usuario%TYPE,         --VARCHAR2,
      en_tip_procesa    IN       pv_iorserv.tip_procesa%TYPE,       --NUMBER,
      ev_cod_modgener   IN       pv_iorserv.cod_modgener%TYPE,    --VARCHAR2,
      sv_error          OUT      VARCHAR2,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_ins_erecorrido_fn (
      en_num_os       IN       pv_erecorrido.num_os%TYPE           --VARCHAR2
                                                        ,
      en_des_estado   IN       pv_erecorrido.descripcion%TYPE      --VARCHAR2
                                                             ,
      sv_error        OUT      VARCHAR2,
      sv_proc         OUT      VARCHAR2,
      sv_tabla        OUT      VARCHAR2,
      sv_act          OUT      VARCHAR2,
      sv_sqlcode      OUT      VARCHAR2,
      sv_sqlerrm      OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_ins_movimientos_fn (
      ev_secuencia    IN       pv_movimientos.num_os%TYPE          --VARCHAR2
                                                         ,
      en_actabo       IN       pv_movimientos.cod_actabo%TYPE      --VARCHAR2
                                                             ,
      en_ind_estado   IN       pv_movimientos.ind_estado%TYPE        --NUMBER
                                                             ,
      en_carga        IN       pv_movimientos.carga%TYPE             --NUMBER
                                                        ,
      sv_error        OUT      VARCHAR2,
      sv_proc         OUT      VARCHAR2,
      sv_tabla        OUT      VARCHAR2,
      sv_act          OUT      VARCHAR2,
      sv_sqlcode      OUT      VARCHAR2,
      sv_sqlerrm      OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_ins_param_abocel_fn (
      ev_secuencia       IN       pv_param_abocel.num_os%TYPE,
      ev_num_abonado     IN       pv_param_abocel.num_abonado%TYPE,
      ev_actabo          IN       pv_param_abocel.cod_tipmodi%TYPE,
      ev_usuario         IN       pv_param_abocel.nuom_usuarora%TYPE,
      en_celular         IN       pv_param_abocel.num_celular%TYPE,
      ev_tip_plantarif   IN       pv_param_abocel.tip_plantarif%TYPE,
      ev_tip_terminal    IN       pv_param_abocel.tip_terminal%TYPE,
      ev_cod_plantarif   IN       pv_param_abocel.cod_plantarif%TYPE,
      ev_num_seriehex    IN       pv_param_abocel.num_seriehex%TYPE,
      en_cod_ciclo       IN       pv_param_abocel.cod_ciclo%TYPE,
      ev_cod_causa       IN       pv_param_abocel.cod_causa%TYPE,
      ev_cod_servicio    IN       pv_param_abocel.cod_servicio%TYPE,
      ev_observacion     IN       pv_param_abocel.obs_detalle%TYPE,
      sv_error           OUT      VARCHAR2,
      sv_proc            OUT      VARCHAR2,
      sv_tabla           OUT      VARCHAR2,
      sv_act             OUT      VARCHAR2,
      sv_sqlcode         OUT      VARCHAR2,
      sv_sqlerrm         OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_ins_camcom_fn (
      ev_secuencia            IN       pv_camcom.num_os%TYPE,
      ev_num_abonado          IN       pv_camcom.num_abonado%TYPE,
      en_celular              IN       pv_camcom.num_celular%TYPE,
      en_cod_cliente          IN       pv_camcom.cod_cliente%TYPE,
      en_cod_cuenta           IN       pv_camcom.cod_cuenta%TYPE,
      en_cod_producto         IN       pv_camcom.cod_producto%TYPE,
      ev_bdatos               IN       pv_camcom.bdatos%TYPE,
      en_num_venta            IN       pv_camcom.num_venta%TYPE,
      en_num_transaccion      IN       pv_camcom.num_transaccion%TYPE,
      en_num_folio            IN       pv_camcom.num_folio%TYPE,
      en_num_cuotas           IN       pv_camcom.num_cuotas%TYPE,
      en_num_proceso          IN       pv_camcom.num_proceso%TYPE,
      ev_cod_actabo           IN       pv_camcom.cod_actabo%TYPE,
      ev_fh_anula             IN       pv_camcom.fh_anula%TYPE,
      ev_cat_tribut           IN       pv_camcom.cat_tribut%TYPE,
      en_cod_estadoc          IN       pv_camcom.cod_estadoc%TYPE,
      ev_cod_causaelim        IN       pv_camcom.cod_causaelim%TYPE,
      ev_fec_vencimiento      IN       pv_camcom.fec_vencimiento%TYPE,
      ev_clase_servicio_act   IN       pv_camcom.clase_servicio_act%TYPE,
      ev_clase_servicio_des   IN       pv_camcom.clase_servicio_des%TYPE,
      en_ind_central_ss       IN       pv_camcom.ind_central_ss%TYPE,
      en_ind_portable         IN       pv_camcom.ind_portable%TYPE,
      en_tip_terminal         IN       pv_camcom.tip_terminal%TYPE,
      ev_tip_susp_avsinie     IN       pv_camcom.tip_susp_avsinie%TYPE,
      ev_pref_plaza           IN       pv_camcom.pref_plaza%TYPE,
      sv_error                OUT      VARCHAR2,
      sv_proc                 OUT      VARCHAR2,
      sv_tabla                OUT      VARCHAR2,
      sv_act                  OUT      VARCHAR2,
      sv_sqlcode              OUT      VARCHAR2,
      sv_sqlerrm              OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_upd_fin_registro_fn (
      en_num_os        IN       pv_erecorrido.num_os%TYPE          --VARCHAR2
                                                         ,
      ev_des_estadoc   IN       pv_erecorrido.descripcion%TYPE     --VARCHAR2
                                                              ,
      sv_error         OUT      VARCHAR2,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_val_largo_celular_fn (
      en_num_celular   IN       NUMBER,
      sv_error         OUT      VARCHAR2,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   PROCEDURE pv_inscribe_ooss_pr (
      en_num_celular          IN       NUMBER,
      en_cod_ooss             IN       VARCHAR2,
      ev_usuario              IN       VARCHAR2,
      gn_secuencia            IN       NUMBER,
      en_modgener             IN       VARCHAR2,
      en_cod_actabo           IN       VARCHAR2,
      en_num_abonado          IN       NUMBER,
      en_cod_producto         IN       NUMBER,
      en_ind_central_ss       IN       pv_camcom.ind_central_ss%TYPE,
                                                                    --NUMBER,
      en_tip_terminal         IN       VARCHAR,
      ev_tip_susp_avsinie     IN       pv_camcom.tip_susp_avsinie%TYPE,
      en_causa_sinie          IN       NUMBER,
      en_num_venta            IN       pv_camcom.num_venta%TYPE,     --NUMBER
      en_num_transaccion      IN       pv_camcom.num_transaccion%TYPE,
                                                                     --NUMBER
      en_num_folio            IN       pv_camcom.num_folio%TYPE,     --NUMBER
      en_num_cuotas           IN       pv_camcom.num_cuotas%TYPE,    --NUMBER
      en_num_proceso          IN       pv_camcom.num_proceso%TYPE,   --NUMBER
      ev_fh_anula             IN       pv_camcom.fh_anula%TYPE,    --VARCHAR2
      ev_cat_tribut           IN       pv_camcom.cat_tribut%TYPE,  --VARCHAR2
      en_cod_estadoc          IN       pv_camcom.cod_estadoc%TYPE,   --NUMBER
      ev_cod_causaelim        IN       pv_camcom.cod_causaelim%TYPE,
                                                                   --VARCHAR2
      ev_fec_vencimiento      IN       pv_camcom.fec_vencimiento%TYPE,
                                                                   --VARCHAR2
      ev_clase_servicio_act   IN       pv_camcom.clase_servicio_act%TYPE,
                                                                   --VARCHAR2
      ev_clase_servicio_des   IN       pv_camcom.clase_servicio_des%TYPE,
                                                                   --VARCHAR2
      en_ind_portable         IN       pv_camcom.ind_portable%TYPE,  --NUMBER
      ev_pref_plaza           IN       pv_camcom.pref_plaza%TYPE,  --VARCHAR2
      en_cod_cuenta           IN       pv_camcom.cod_cuenta%TYPE,    --NUMBER
      sv_descripcion          IN       VARCHAR2,
      sn_tip_procesa          IN       NUMBER,
      sv_cod_modgener         IN       VARCHAR2,
      sv_des_estadoc          IN       VARCHAR2,
      en_ind_estado           IN       pv_movimientos.ind_estado%TYPE,
      sn_imp_total            IN       pv_movimientos.carga%TYPE,
      sv_error                OUT      VARCHAR2,
      sv_proc                 OUT      VARCHAR2,
      sv_tabla                OUT      VARCHAR2,
      sv_act                  OUT      VARCHAR2,
      sv_sqlcode              OUT      VARCHAR2,
      sv_sqlerrm              OUT      VARCHAR2
   );

   FUNCTION pv_reg_carta_fn (
      en_num_ooss      IN       ci_orserv.num_os%TYPE,
      en_cod_ooss      IN       ci_tiporserv.cod_os%TYPE,
      en_cod_cliente   IN       ge_clientes.cod_cliente%TYPE,
      en_num_celular   IN       ga_abocel.num_celular%TYPE,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2,
      sv_error         OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_rec_msg_carta_fn (
      en_cod_ooss     IN       ci_tiporserv.cod_os%TYPE,
      en_cod_idioma   IN       ge_clientes.cod_idioma%TYPE,
      sv_proc         OUT      VARCHAR2,
      sv_tabla        OUT      VARCHAR2,
      sv_act          OUT      VARCHAR2,
      sv_sqlcode      OUT      VARCHAR2,
      sv_sqlerrm      OUT      VARCHAR2,
      sv_error        OUT      VARCHAR2
   )
      RETURN ci_tipcartas.texto%TYPE;

   FUNCTION pv_rec_tip_idioma_fn (
      en_cod_cliente   IN       ge_clientes.cod_cliente%TYPE,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2,
      sv_error         OUT      VARCHAR2
   )
      RETURN ge_clientes.cod_idioma%TYPE;

   FUNCTION pv_ejec_restriccion_fn (
      ev_cod_modulo      IN       VARCHAR2,
      en_cod_producto    IN       ga_abocel.cod_producto%TYPE,
      ev_cod_actuacion   IN       VARCHAR2,
      ev_evento          IN       VARCHAR2,
      ev_parametro       IN       VARCHAR2,
      sv_proc            OUT      VARCHAR2,
      sv_tabla           OUT      VARCHAR2,
      sv_act             OUT      VARCHAR2,
      sv_sqlcode         OUT      VARCHAR2,
      sv_sqlerrm         OUT      VARCHAR2,
      sv_error           OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_ga_transacabo_fn (
      en_num_transaccion   IN       ga_transacabo.num_transaccion%TYPE,
      sv_proc              OUT      VARCHAR2,
      sv_tabla             OUT      VARCHAR2,
      sv_act               OUT      VARCHAR2,
      sv_sqlcode           OUT      VARCHAR2,
      sv_sqlerrm           OUT      VARCHAR2,
      sv_error             OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_ga_errores_fn (
      en_num_abonado    IN       ga_abocel.num_abonado%TYPE,
      ev_cod_actabo     IN       VARCHAR2,
      en_cod_producto   IN       ga_abocel.cod_producto%TYPE,
      sv_error          OUT      VARCHAR2,
      ev_proc           IN       VARCHAR2,
      ev_tabla          IN       VARCHAR2,
      ev_act            IN       VARCHAR2,
      ev_sqlcode        IN       VARCHAR2,
      ev_sqlerrm        IN       VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_cargos_fn (
      en_cod_producto   IN       ga_abocel.cod_producto%TYPE,
      ev_cod_actabo     IN       ga_actuaserv.cod_actabo%TYPE,
      ev_cod_planserv   IN       ga_tarifas.cod_planserv%TYPE,
      sv_cod_concepto   OUT      ga_actuaserv.cod_concepto%TYPE,
      sv_cod_moneda     OUT      ga_tarifas.cod_moneda%TYPE,
      sn_imp_tarifa     OUT      ga_tarifas.imp_tarifa%TYPE,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_cargos_ss_fn (
      en_cod_producto   IN       ga_abocel.cod_producto%TYPE,
      ev_cod_actabo     IN       ga_actuaserv.cod_actabo%TYPE,
      ev_cod_planserv   IN       ga_tarifas.cod_planserv%TYPE,
      ev_cod_servicio   IN       ga_actuaserv.cod_servicio%TYPE,
      sv_cod_concepto   OUT      ga_actuaserv.cod_concepto%TYPE,
      sv_cod_moneda     OUT      ga_tarifas.cod_moneda%TYPE,
      sn_imp_tarifa     OUT      ga_tarifas.imp_tarifa%TYPE,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_cargos_penal_fn (
      en_cod_producto   IN       ga_abocel.cod_producto%TYPE,
      en_cod_penaliza   IN       ga_actuaserv.cod_actabo%TYPE,
      sv_cod_concepto   OUT      ga_actuaserv.cod_concepto%TYPE,
      sv_cod_moneda     OUT      ga_tarifas.cod_moneda%TYPE,
      sn_imp_tarifa     OUT      ga_tarifas.imp_tarifa%TYPE,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_cnv_monedas_fn (
      ev_cod_concepto   IN   ga_actuaserv.cod_concepto%TYPE,
      ev_cod_moneda     IN   ga_tarifas.cod_moneda%TYPE,
      en_imp_tarifa     IN   ga_tarifas.imp_tarifa%TYPE
   )
      RETURN ga_tarifas.imp_tarifa%TYPE;

   FUNCTION pv_inserta_cargos_fn (
      en_cod_cliente    IN       ga_abocel.cod_cliente%TYPE,
      en_cod_producto   IN       ga_abocel.cod_producto%TYPE,
      en_num_abonado    IN       ga_abocel.num_abonado%TYPE,
      en_num_terminal   IN       ga_abocel.num_celular%TYPE,
      ev_cod_plancom    IN       ga_cliente_pcom.cod_plancom%TYPE,
      ed_fec_alta       IN       ga_abocel.fec_alta%TYPE,
      en_cod_ciclfact   IN       fa_ciclfact.cod_ciclfact%TYPE,
      ev_cod_concepto   IN       ge_cargos.cod_concepto%TYPE,
      en_imp_cargo      IN       ge_cargos.imp_cargo%TYPE,
      ev_cod_moneda     IN       ge_cargos.cod_moneda%TYPE,
      ev_usuario        IN       ge_cargos.nom_usuarora%TYPE,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_recupera_codigo_servicio_fn (
      en_num_celular    IN       NUMBER,
      sv_cod_servicio   OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_recupera_ciclo_fact_fn (
      en_cod_cliente   IN       ga_cliente_pcom.cod_plancom%TYPE,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2,
      sv_error         OUT      VARCHAR2
   )
      RETURN fa_ciclfact.cod_ciclfact%TYPE;

   FUNCTION pv_valida_ciclo_vig_fn (
      en_cod_cliente    IN       ga_cliente_pcom.cod_plancom%TYPE,
      en_num_abonado    IN       ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN       fa_ciclfact.cod_ciclfact%TYPE,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_recupera_plan_comercial_fn (
      en_cod_cliente   IN       ga_cliente_pcom.cod_plancom%TYPE,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2,
      sv_error         OUT      VARCHAR2
   )
      RETURN ga_cliente_pcom.cod_plancom%TYPE;

   FUNCTION pv_upd_cargos_fn (
      en_cod_cliente    IN       ga_abocel.cod_cliente%TYPE,
      en_num_abonado    IN       ga_abocel.num_abonado%TYPE,
      en_cod_ciclfact   IN       fa_ciclfact.cod_ciclfact%TYPE,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2,
      sv_error          OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_valida_usuario_fn (
      ev_usuario   IN       ga_abocel.nom_usuarora%TYPE,
      sv_error     OUT      VARCHAR2,
      sv_proc      OUT      VARCHAR2,
      sv_tabla     OUT      VARCHAR2,
      sv_act       OUT      VARCHAR2,
      sv_sqlcode   OUT      VARCHAR2,
      sv_sqlerrm   OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   PROCEDURE pv_mov_central_pr (
      en_numsecuencia      IN       NUMBER,
      en_numabonado        IN       ga_abocel.num_abonado%TYPE,
      ev_codestado         IN       VARCHAR2,
      ev_codactabo         IN       ga_actabo.cod_actabo%TYPE,
      ev_codmodulo         IN       VARCHAR2,
      ev_usuario           IN       VARCHAR2,
      ev_fecingre          IN       VARCHAR2,
      ev_tipterminal       IN       VARCHAR2,
      en_codcentral        IN       ga_abocel.cod_central%TYPE,
      en_indbloqueo        IN       NUMBER,
      ev_tipterminal_nue   IN       VARCHAR2,
      en_numcelular        IN       ga_abocel.num_celular%TYPE,
      ev_numserie          IN       ga_abocel.num_serie%TYPE,
      en_numcelular_nue    IN       ga_abocel.num_celular%TYPE,
      ev_numserie_nue      IN       ga_abocel.num_serie%TYPE,
      ev_codsuspreha       IN       ga_susprehabo.cod_caususp%TYPE,
      ev_codservicios      IN       VARCHAR2,
      en_nummin            IN       ga_abocel.num_min%TYPE,
      en_nummin_nue        IN       ga_abocel.num_min%TYPE,
      ev_tiptecnologia     IN       icc_movimiento.tip_tecnologia%TYPE,
      ev_imsi_nue          IN       icc_movimiento.imsi%TYPE,
      ev_imei              IN       icc_movimiento.imei%TYPE,
      ev_imei_nue          IN       icc_movimiento.imei%TYPE,
      ev_icc               IN       icc_movimiento.icc%TYPE,
      ev_icc_nue           IN       icc_movimiento.icc%TYPE,
      en_carga             IN       icc_movimiento.carga%TYPE,
      en_central_nue       IN       icc_movimiento.cod_central_nue%TYPE,
      ev_plan              IN       icc_movimiento.PLAN%TYPE,
      en_valorplan         IN       icc_movimiento.valor_plan%TYPE,
      ev_nummsnb           IN       icc_movimiento.num_msnb%TYPE,
      sv_proc              OUT      VARCHAR2,
      sv_tabla             OUT      VARCHAR2,
      sv_act               OUT      VARCHAR2,
      sv_sqlcode           OUT      VARCHAR2,
      sv_sqlerrm           OUT      VARCHAR2,
      sv_error             OUT      VARCHAR2
   );

   PROCEDURE pv_registra_movimiento_pr (
      en_numsecuencia      IN       NUMBER,
      en_numabonado        IN       ga_abocel.num_abonado%TYPE,
      ev_codestado         IN       VARCHAR2,
      ev_codactabo         IN       ga_actabo.cod_actabo%TYPE,
      ev_codmodulo         IN       VARCHAR2,
      ev_usuario           IN       VARCHAR2,
      ev_fecingre          IN       VARCHAR2,
      ev_tipterminal       IN       VARCHAR2,
      en_codcentral        IN       ga_abocel.cod_central%TYPE,
      en_indbloqueo        IN       NUMBER,
      ev_tipterminal_nue   IN       VARCHAR2,
      en_numcelular        IN       ga_abocel.num_celular%TYPE,
      ev_numserie          IN       ga_abocel.num_serie%TYPE,
      en_numcelular_nue    IN       ga_abocel.num_celular%TYPE,
      ev_numserie_nue      IN       ga_abocel.num_serie%TYPE,
      ev_codsuspreha       IN       ga_susprehabo.cod_caususp%TYPE,
      ev_codservicios      IN       VARCHAR2,
      en_nummin            IN       ga_abocel.num_min%TYPE,
      en_nummin_nue        IN       ga_abocel.num_min%TYPE,
      ev_tiptecnologia     IN       icc_movimiento.tip_tecnologia%TYPE,
      ev_imsi_nue          IN       icc_movimiento.imsi%TYPE,
      ev_imei              IN       icc_movimiento.imei%TYPE,
      ev_imei_nue          IN       icc_movimiento.imei%TYPE,
      ev_icc               IN       icc_movimiento.icc%TYPE,
      ev_icc_nue           IN       icc_movimiento.icc%TYPE,
      en_carga             IN       icc_movimiento.carga%TYPE,
      en_central_nue       IN       icc_movimiento.cod_central_nue%TYPE,
      ev_plan              IN       icc_movimiento.PLAN%TYPE,
      en_valorplan         IN       icc_movimiento.valor_plan%TYPE,
      ev_nummsnb           IN       icc_movimiento.num_msnb%TYPE,
      sv_proc              OUT      VARCHAR2,
      sv_tabla             OUT      VARCHAR2,
      sv_act               OUT      VARCHAR2,
      sv_sqlcode           OUT      VARCHAR2,
      sv_sqlerrm           OUT      VARCHAR2,
      sv_error             OUT      VARCHAR2
   );

   FUNCTION pv_clase_serv_fn (
      ev_servsupl   IN       VARCHAR2,
      sv_codgrupo   IN OUT   siscel.ge_tabtype_vch2array,
      sv_codnivel   IN OUT   siscel.ge_tabtype_vch2array,
      sv_error      OUT      VARCHAR2,
      sv_proc       OUT      VARCHAR2,
      sv_tabla      OUT      VARCHAR2,
      sv_act        OUT      VARCHAR2,
      sv_sqlcode    OUT      VARCHAR2,
      sv_sqlerrm    OUT      VARCHAR2
   )
      RETURN VARCHAR2;

   FUNCTION pv_rec_serv_fn (
      ev_cod_servicio   IN       VARCHAR2,
      sv_cod_servicio   IN OUT   siscel.ge_tabtype_vch2array,
      sn_total_serv     OUT      NUMBER,
      sv_error          OUT      VARCHAR2,
      sv_proc           OUT      VARCHAR2,
      sv_tabla          OUT      VARCHAR2,
      sv_act            OUT      VARCHAR2,
      sv_sqlcode        OUT      VARCHAR2,
      sv_sqlerrm        OUT      VARCHAR2
   )
      RETURN BOOLEAN;

   FUNCTION pv_valida_servicio_fn (
      ev_codservicio   IN       ga_servsupl.cod_servicio%TYPE,
      ev_codgrupo      IN       ga_servsupl.cod_servsupl%TYPE,
      en_codnivel      IN       ga_servsupl.cod_nivel%TYPE,
      sv_error         OUT      VARCHAR2,
      sv_proc          OUT      VARCHAR2,
      sv_tabla         OUT      VARCHAR2,
      sv_act           OUT      VARCHAR2,
      sv_sqlcode       OUT      VARCHAR2,
      sv_sqlerrm       OUT      VARCHAR2
   )
      RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_inserta_modabocel_fn (
      en_num_abonado     IN              ga_modabocel.num_abonado%TYPE,
      ev_cod_tipmodi     IN              ga_modabocel.cod_tipmodi%TYPE,
      ed_fec_modifica    IN              ga_modabocel.fec_modifica%TYPE,
      ev_nom_usuario     IN              ga_modabocel.nom_usuarora%TYPE,
      ev_num_frecuente   IN              ga_modabocel.num_telefija%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION pv_recupera_plan_comercial_fn (
      en_cod_cliente    IN              ga_abocel.cod_cliente%TYPE,
      sn_cod_plancom    OUT NOCOPY      ga_cliente_pcom.cod_plancom%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento
   )
      RETURN BOOLEAN;
------------------------------------------------------------------------
FUNCTION PV_VALIDA_CICLO_VIG_FN     (EN_COD_CLIENTE      IN GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                     EN_NUM_ABONADO      IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EN_COD_CICLFACT     IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                       SN_cod_retorno      OUT NOCOPY  ge_errores_pg.CodError,
                                       SV_mens_retorno     OUT NOCOPY  ge_errores_pg.MsgError,
                                       SN_num_evento       OUT NOCOPY  ge_errores_pg.Evento
) RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_CNV_MONEDAS_FN             (EN_COD_CONCEPTO   IN         GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                           EV_COD_MONEDA     IN         GA_TARIFAS.COD_MONEDA%TYPE,
                                           EN_IMP_TARIFA     IN         GA_TARIFAS.IMP_TARIFA%TYPE,
                                        SN_convertido      OUT NOCOPY GA_TARIFAS.IMP_TARIFA%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                 ) RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION  PV_INSERTA_CARGOS_FN       (EN_COD_CLIENTE    IN         GA_ABOCEL.COD_CLIENTE%TYPE,
                                      EN_COD_PRODUCTO   IN         GA_ABOCEL.COD_PRODUCTO%TYPE,
                                      EN_NUM_ABONADO    IN            GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EN_NUM_TERMINAL   IN            GA_ABOCEL.NUM_CELULAR%TYPE,
                                      EN_COD_PLANCOM    IN            GA_CLIENTE_PCOM.COD_PLANCOM%TYPE,
                                      ED_FEC_ALTA       IN            GA_ABOCEL.FEC_ALTA%TYPE,
                                      EN_COD_CICLFACT   IN            FA_CICLFACT.COD_CICLFACT%TYPE,
                                      EV_COD_CONCEPTO   IN            GE_CARGOS.COD_CONCEPTO%TYPE,
                                      EN_IMP_CARGO      IN            GE_CARGOS.IMP_CARGO%TYPE,
                                      EV_COD_MONEDA     IN            GE_CARGOS.COD_MONEDA%TYPE,
                                      EV_USUARIO        IN            GE_CARGOS.NOM_USUARORA%TYPE,
                                      EN_ind_cuota      IN            GE_CARGOS.IND_CUOTA%TYPE,
                                      SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                         SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                 ) RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION  PV_UPD_CARGOS_INFACCEL_FN    (EN_COD_CLIENTE   IN         GA_ABOCEL.COD_CLIENTE%TYPE,
                                        EN_NUM_ABONADO   IN         GA_ABOCEL.NUM_ABONADO%TYPE,
                                           EN_COD_CICLFACT  IN         FA_CICLFACT.COD_CICLFACT%TYPE,
                                           EN_ind_cargos    IN         ga_infaccel.ind_cargos%TYPE,
                                        SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento    OUT NOCOPY ge_errores_pg.Evento
                                 ) RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENER_CAMBIO_MONEDA_FN   (EV_COD_MONEDA     IN         GA_TARIFAS.COD_MONEDA%TYPE,
                                           SN_cambio         OUT NOCOPY GE_CONVERSION.cambio%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                  ) RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_OBTENER_MONEDA_FN          (EN_COD_CONCEPTO   IN         GA_ACTUASERV.COD_CONCEPTO%TYPE,
                                           SV_COD_MONEDA     OUT NOCOPY GA_TARIFAS.COD_MONEDA%TYPE,
                                        SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_num_evento     OUT NOCOPY ge_errores_pg.Evento
                                 ) RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--INI COL-77866|05-05-2009|GEZ
   PROCEDURE pv_audreg_pr (EVModulo             IN                ge_aud_regulariza_td.cod_modulo%TYPE,
               ENNumInter          IN            ge_aud_regulariza_td.num_inter%TYPE,
               ENTipInter          IN            ge_aud_regulariza_td.tip_inter%TYPE,
               ENEstado          IN            ge_aud_regulariza_td.cod_estado%TYPE,
                EVIncidencia              IN            ge_aud_regulariza_td.cod_incidencia%TYPE,
                   EVTipModi          IN            ge_aud_regulariza_td.cod_tipmodi%TYPE,
               EVCodOs          IN            ge_aud_regulariza_td.cod_os%TYPE,
               EVDesEstado          IN            ge_aud_regulariza_td.des_estado%TYPE,
               EVObserv          IN            ge_aud_regulariza_td.observacion%TYPE,
               EVNomProc          IN            ge_aud_regulariza_td.nom_proc_prog%TYPE,
               EVTabla          IN            ge_aud_regulariza_td.nom_tabla%TYPE,
               EVAct          IN            ge_aud_regulariza_td.cod_act%TYPE,
               ENEvento          IN            ge_aud_regulariza_td.num_evento%TYPE,
               EVSqlCode          IN            ge_aud_regulariza_td.cod_sqlcode%TYPE,
               EVSqlerrm          IN            ge_aud_regulariza_td.cod_sqlerrm%TYPE,
               ENAuditoria          IN            NUMBER,
               SNEstado          OUT NOCOPY   NUMBER,
               SVCode          OUT NOCOPY   VARCHAR2,
               SVErrm          OUT NOCOPY   VARCHAR2
                        );

   PROCEDURE pv_audreg_sretorno_pr (
                      EVTransaccion              IN            VARCHAR2,
                    EVModulo             IN                ge_aud_regulariza_td.cod_modulo%TYPE,
                      ENNumInter          IN            ge_aud_regulariza_td.num_inter%TYPE,
                    ENTipInter          IN            ge_aud_regulariza_td.tip_inter%TYPE,
                    ENEstado          IN            ge_aud_regulariza_td.cod_estado%TYPE,
                    EVIncidencia              IN            ge_aud_regulariza_td.cod_incidencia%TYPE,
                    EVTipModi          IN            ge_aud_regulariza_td.cod_tipmodi%TYPE,
                    EVCodOs              IN            ge_aud_regulariza_td.cod_os%TYPE,
                    EVDesEstado          IN            ge_aud_regulariza_td.des_estado%TYPE,
                    EVObserv          IN            ge_aud_regulariza_td.observacion%TYPE,
                    EVNomProc          IN            ge_aud_regulariza_td.nom_proc_prog%TYPE,
                    EVTabla              IN            ge_aud_regulariza_td.nom_tabla%TYPE,
                    EVAct              IN            ge_aud_regulariza_td.cod_act%TYPE,
                    ENEvento          IN            ge_aud_regulariza_td.num_evento%TYPE,
                    EVSqlCode          IN            ge_aud_regulariza_td.cod_sqlcode%TYPE,
                    EVSqlerrm          IN            ge_aud_regulariza_td.cod_sqlerrm%TYPE,
                    ENAuditoria          IN            NUMBER
                        );

--FIN COL-77866|05-05-2009|GEZ

--INI COL-79523|06-03-2009|GEZ
PROCEDURE pv_situabo_actabo_pr(     EN_NumAbonado       IN                            ga_abocel.num_abonado%TYPE,
                                                        EV_CodActabo           IN                            pvd_actuacion_situacion.cod_actabo%TYPE,
                                                        SV_Estado                 OUT NOCOPY            VARCHAR2,
                                                        SV_Proc                      OUT NOCOPY             VARCHAR2,
                                                        SN_CodMsg               OUT NOCOPY              NUMBER,
                                                        SN_Evento                 OUT NOCOPY            NUMBER,
                                                        SV_Tabla                 OUT NOCOPY            VARCHAR2,
                                                        SV_Act                       OUT NOCOPY              VARCHAR2,
                                                        SV_Code                     OUT NOCOPY            VARCHAR2,
                                                        SV_Errm                     OUT NOCOPY            VARCHAR2);
--FIN COL-79523|06-03-2009|GEZ

END pv_general_ooss_pg;
/
SHOW ERRORS
