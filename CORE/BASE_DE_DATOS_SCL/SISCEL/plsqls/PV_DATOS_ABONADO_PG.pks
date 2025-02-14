CREATE OR REPLACE PACKAGE PV_DATOS_ABONADO_PG
IS
   TYPE refCursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_cod_modulo_GE        CONSTANT VARCHAR2 (2)  := 'GE';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
   CV_gsFormato2           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL2';
   CV_gsFormato4           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL4';
   CV_gsFormato7           CONSTANT VARCHAR2 (20) := 'FORMATO_SEL7';
   CV_val_prm_estado       CONSTANT VARCHAR2 (15) := 'EST_RESPCENTRAL';
   CV_tip_plan_hibrido     CONSTANT     VARCHAR2 (20) := 'TIP_PLAN_HIBRIDO';
   CV_cod_usucontrolada    CONSTANT VARCHAR2 (30) := 'COD_USOCONTROLADA';

   CV_val_prm_maxint       CONSTANT VARCHAR  (12) := 'MAX_INTENTOS';
   CV_formato_fecha        CONSTANT VARCHAR  (22) := 'dd-mm-yyyy hh24:mi:ss' ;
   CV_cod_aplic            CONSTANT VARCHAR2 (3)  := 'PVA';
   CV_cod_actabo           CONSTANT VARCHAR2 (2)  := 'BA';
   CV_situacion            CONSTANT VARCHAR2 (3)  := 'CPP';
   CN_producto             CONSTANT NUMBER        := 1;

   CV_ACTABO_TERRENO       CONSTANT VARCHAR2(3)   := 'VT';
   CV_ACTABO_OFICINA       CONSTANT VARCHAR2(3)   := 'VO';
   CV_ACTABO_HIBRIDO       CONSTANT VARCHAR2(3)   := 'HH';

   CV_Cod_OOSS_Emp         CONSTANT VARCHAR2(5)       := '40006';
   CV_Cod_OOSS_Reord       CONSTANT VARCHAR2(5)   := '40008';

   CN_0                    CONSTANT NUMBER (1)     := 0;
   CV_0                    CONSTANT VARCHAR2 (1)   := '0';
   CV_1                    CONSTANT VARCHAR2 (1)   := '1';


   CN_ESTADO_SU            CONSTANT NUMBER (1)     := 0;
   CN_ESTADO_AC            CONSTANT NUMBER (1)     := 1;
   CN_ESTADO_PA            CONSTANT NUMBER (1)     := 2;
   CN_ESTADO_PM            CONSTANT NUMBER (1)     := 3;
   CN_ESTADO_PD            CONSTANT NUMBER (1)     := 4;
   GV_cod_actabo           CONSTANT ga_actabo.cod_actabo%TYPE := 'NL';
   GV_cod_modulo           CONSTANT     VARCHAR2(2)        :='GA';
   GN_cod_estado_icc       CONSTANT NUMBER(1)      :=1;
   GV_param_grpgsm         CONSTANT VARCHAR2(13)   := 'GRUPO_TEC_GSM';
   GN_num_intentos         CONSTANT NUMBER (1)     := 0;
   GN_ind_bloqueo          CONSTANT NUMBER (1)     := 0;
   CN_COD_TIPCONTRATO      CONSTANT NUMBER (2)     := 82;
   CN_NUM_PERCONTRATO      CONSTANT NUMBER (1)     := 0;



------------------------------------------------------------------------------------------------------

        PROCEDURE PV_ACTUALIZA_SITUA_ABONADO_PR( EO_ABOAMIST         IN                  GA_ABOAMIST_QT,
                                                 SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_ACTUALIZA_INTARCEL_ACC_PR( EO_GA_INTARCEL       IN  OUT NOCOPY       PV_GA_INTARCEL_QT,
                                                SN_cod_retorno               OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno              OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento                OUT NOCOPY       ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_FEC_DESDELLAM_INTARCEL_PR( EO_GA_INTARCEL           IN OUT NOCOPY    PV_GA_INTARCEL_QT,
                                                SN_cod_retorno          OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno         OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento           OUT NOCOPY    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_REG_ELIM_INTARCEL_PR( EO_GA_INTARCEL                    IN OUT NOCOPY        PV_GA_INTARCEL_QT,
                                           SN_cod_retorno               OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                           SV_mens_retorno              OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                           SN_num_evento                OUT NOCOPY    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_OBTIENE_LISTA_ABONADOS_PR( EO_Abonado                IN                             GA_Abonado_QT,
                                                SO_Lista_Abonado         OUT NOCOPY          refCursor,
                                                SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                SN_num_evento            OUT NOCOPY          ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_OBTIENE_DATOS_ABONADO_PR( SO_Abonado                IN OUT NOCOPY   GA_Abonado_QT,
                                               SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                               SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                               SN_num_evento            OUT NOCOPY       ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_ELIMINA_CUENTA_PERSONAL_PR( EO_NUMCEL_PERS          IN                   PV_NUMCEL_PERS_QT,
                                                 SN_cod_retorno          OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno         OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento           OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_VALIDAOOSS_PENDPLAN_PR( EO_VALIDAOOSS_PENDPLAN       IN OUT NOCOPY   PV_VALIDAOOSS_PENDPLAN_QT,
                                             SN_cod_retorno              OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                             SV_mens_retorno             OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                             SN_num_evento               OUT NOCOPY       ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_CONSULTA_HIBRIDO_PR( EO_PlanesTarifarios     IN             PV_PLANES_TARIFARIOS_QT,
                                          SN_cod_retorno          OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno         OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento           OUT NOCOPY             ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_ACTUAL_PLANSERV_PR ( EO_SERVDEFAULT_PLAN IN OUT NOCOPY       PV_SERVDEFAULT_PLAN_QT,
                                          SN_cod_retorno         OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento          OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

    PROCEDURE PR_VENTA_S_PR( EO_Venta_Abonado  IN                        GA_VENTA_QT,
                             SO_Lista_Abonado        OUT NOCOPY      refCursor,
                             SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento       OUT NOCOPY  ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_OBTENER_FEC_CUMPLAN_PR ( SO_GA_ABOCEL    IN OUT NOCOPY       PV_GA_ABOCEL_QT,
                                              SN_cod_retorno     OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                              SV_mens_retorno    OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                              SN_num_evento      OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_MIGRAR_ABONADO_PR ( SO_GA_ABOCEL     IN                              PV_GA_ABOCEL_QT,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        FUNCTION PV_ACT_ABO_CTASEG_FN ( SO_GA_ABOCEL      IN                             PV_GA_ABOCEL_QT,
                                        SN_cod_retorno      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                        SV_mens_retorno     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                        SN_num_evento       OUT NOCOPY      ge_errores_pg.evento)
        RETURN VARCHAR;
------------------------------------------------------------------------------------------------------

    FUNCTION PV_VALIDA_PERMANENCIA_FN( EO_permanencia  IN        PV_VALIDA_PERM_QT,
                                       SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento       OUT NOCOPY       ge_errores_pg.evento)
        RETURN VARCHAR2;
------------------------------------------------------------------------------------------------------

    PROCEDURE PV_RESERVA_AMIST_PR( EO_celular  IN        PV_NUMCEL_PERS_QT,
                                   SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                   SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                   SN_num_evento       OUT NOCOPY       ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_OBTENER_ABONADO_CELULAR_PR( ESO_Abonado          IN OUT NOCOPY     GA_Abonado_QT,
                                                 SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento            OUT NOCOPY    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        PROCEDURE PV_OBTENER_MOVIMIENTO_PR ( EO_Abonado  IN         GA_Abonado_QT,
                                             SO_movimientos  OUT NOCOPY refcursor,
                                             SN_cod_retorno  OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                             SV_mens_retorno OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                             SN_num_evento   OUT NOCOPY ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

        FUNCTION PV_OBTIENE_ROL_USUARIO_FN (
                      SO_Cliente       IN     PV_GA_ABOCEL_QT,
                          SN_cod_retorno   OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
                          SV_mens_retorno  OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
                          SN_num_evento    OUT NOCOPY           ge_errores_pg.evento)
                RETURN NUMBER;
------------------------------------------------------------------------------------------------------

PROCEDURE PV_ACTUALIZA_SITUPERFIL_PR(EO_Abonado        IN               GA_ABONADO_QT,
                                                                         SN_cod_retorno    OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno   OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento     OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

PROCEDURE PV_BUSCA_ABONADOS_FILTRADOS_PR(EN_Cod_Cliente                 IN ge_clientes.cod_cliente%TYPE,
                                          EV_cod_tiplan                 IN ta_plantarif.cod_tiplan%TYPE,
                                          EN_num_abonado                IN ga_abocel.num_abonado%TYPE,
                                          EN_num_celular                IN ga_abocel.num_celular%TYPE,
                                          EV_num_rut                    IN ge_clientes.num_ident%TYPE,
                                          EN_max_filas                  IN NUMBER,
                                          EN_ultimo_reg                 IN NUMBER,
                                          EV_COD_PRESTACION             IN  GE_PRESTACIONES_TD.COD_PRESTACION%TYPE,
                                          SC_abonados         OUT NOCOPY  refCursor,
                                          SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento            OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------

PROCEDURE PV_VALIDA_FILTRO_ABONADOS_PR(EN_Cod_Cliente           IN ge_clientes.cod_cliente%TYPE,
                                          EV_cod_os                     IN pv_iorserv.cod_os%TYPE,
                                          EN_max_abonados                               IN NUMBER,
                                          SV_respuesta         OUT NOCOPY  VARCHAR2,
                                          SN_cod_retorno           OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                          SV_mens_retorno          OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                          SN_num_evento            OUT NOCOPY   ge_errores_pg.evento);
---------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_NUMPERSONAL_PR(
                                                                   EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                                   SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                   SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                   SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_NUMPERSONAL_PR(
                                                                   EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                                   SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                   SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                   SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_CORPORATIVO_PR(
                                                                          EO_GA_CORPORATIVO  IN OUT            PV_OBT_CAMB_PLAN_SERV_QT,
                                                                          SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_PERSONAL_PR(
                                                                      EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                                      SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                      SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                      SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_ATLANTIDA_PR(
                                                                         EO_GA_COD_CLIENTE  IN OUT            PV_cliente_QT,
                                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_DESACTIVAPER_PR(
                                                                         EO_GA_NUM_PERSONAL IN OUT            PV_GA_ABOCEL_QT,
                                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTUALIZA_NUMPERSONAL_PR(
                                                                         EO_GA_NUM_PERSONAL IN OUT            PV_GA_ABOCEL_QT,
                                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_VALACTIV_PER_PR(
                                                                         EO_GA_NUM_PERSONAL IN OUT            PV_GA_ABOCEL_QT,
                                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_REG_PERS_PR(
                                                                         EO_GA_NUM_PERSONAL   IN OUT      PV_VAL_BAJA_ATLANTIDA_QT,
                                                                         SN_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento        OUT NOCOPY  ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_REG_CLIENTE_PR(
                                                                         EO_GA_NUM_CELULAR    IN OUT      PV_CLIENTE_QT,
                                                                         SN_cod_retorno       OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                                                         SV_mens_retorno      OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                                                         SN_num_evento        OUT NOCOPY  ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE GA_ACTIVA_NUMPERSONAL2_PR (
                                                                         EV_num_cel_pers      IN VARCHAR2,
                                                                         EV_num_cel_corp          IN VARCHAR2,
                                                                         EN_num_movimiento    IN icc_movimiento.num_movant%TYPE,
                                                                         EV_cod_prog          IN VARCHAR2,
                                                                     SN_p_correlativo     OUT NOCOPY NUMBER,
                                                                         SN_cod_retorno           OUT NOCOPY INTEGER,
                                                                         SN_num_evento            OUT NOCOPY INTEGER,
                                                                         SV_msg_retorno           OUT NOCOPY VARCHAR2);

------------------------------------------------------------------------------------------------------
PROCEDURE VALIDAR_SITU_ABOEMP_PR (
                                                              EO_Abonado                 IN               GA_ABONADO_QT,
                                                                  SN_cod_retorno         OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                                                  SV_mens_retorno        OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                                                  SN_num_evento          OUT NOCOPY       ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------------
PROCEDURE VALIDAR_ORIDESUSO_PR (EO_Abonado                                      IN                              GA_Abonado_QT,
                                                                        SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                                        SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                                        SN_num_evento            OUT NOCOPY             ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_INSERT_GA_VENTA (EO_venta          IN GA_VENTA_QT,
                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                 SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                 SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALIDA_SOLICITUDES_BAJA_PR(SO_Abonado     IN            GA_Abonado_QT,
                                                                SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_USUARIO_PR( SO_Abonado     IN            GA_Abonado_QT,
                                                                 c_Usuario              OUT NOCOPY refcursor,
                                                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------

PROCEDURE PV_INSERT_GA_FINCICLO (SO_Abonado              IN          PV_GA_ABOCEL_QT,
                                            SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                    SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                    SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------
PROCEDURE PV_ACTUA_INTARCEL_ABONADO_PR(EO_Abonado              IN            GA_Abonado_QT,
                                                                                        SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                            SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                    SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_ABONADO_EMPRESA_PR(EO_Abonado           IN         GA_ABONADO_QT,
                                                                SO_Lista_Abonado     OUT NOCOPY refCursor,
                                                                                        SN_cod_retorno       OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                                                        SV_mens_retorno      OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                                                                        SN_num_evento        OUT NOCOPY ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_BLOQUE_ABONADOS_PR(SO_FILTRO                   IN OUT NOCOPY   PV_FILTRO_ABONADOS_QT,
                                                                                   SO_Lista_Abonado         OUT NOCOPY          refCursor,
                                                                                   SN_cod_retorno           OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                                                                   SV_mens_retorno          OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                                                                   SN_num_evento            OUT NOCOPY          ge_errores_pg.evento);

-----------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_NUMCORPORATIVO_PR(
                                                                   EO_GA_NUM_PERSONAL IN OUT        PV_VAL_BAJA_ATLANTIDA_QT,
                                                                   SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                   SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                   SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE PV_MASCARA_MODIFICAR_PR (EO_GA_NUM_PERSONAL IN OUT PV_GA_ABOCEL_QT,
                                                                          SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                                                                          SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                                                                          SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE PV_VALBAJAATL_EMP_PR( EO_CLIENTE       IN OUT      PV_CLIENTE_QT,
                                SN_cod_retorno   OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno  OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento    OUT NOCOPY  ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_CANT_PERSONAL_EMPRESA_PR(
                         EO_GA_NUM_PERSONAL IN OUT        pv_cliente_qt,
                         SN_cod_retorno     OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno    OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento      OUT NOCOPY    ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------
PROCEDURE PV_INS_INTARCEL_ACCIONES_PR (EO_INTARCEL IN PV_ORDEN_SERVICIO_QT,
             SN_cod_retorno            OUT NOCOPY    ge_errores_td.cod_msgerror%TYPE,
             SV_mens_retorno           OUT NOCOPY    ge_errores_td.det_msgerror%TYPE,
             SN_num_evento             OUT NOCOPY   ge_errores_pg.evento);
------------------------------------------------------------------------------------------------------
PROCEDURE PV_OBTIENE_USUA_VENTA_PR( EN_NUM_VENTA    IN ga_abocel.num_venta%TYPE,
                                      SV_NOM_USUARORA OUT NOCOPY ga_abocel.nom_usuarora%TYPE,
                                    SN_COD_RETORNO      OUT NOCOPY  ge_errores_td.cod_msgerror%TYPE,
                                    SV_MENS_RETORNO     OUT NOCOPY  ge_errores_td.det_msgerror%TYPE,
                                    SN_NUM_EVENTO       OUT NOCOPY  ge_errores_pg.evento);

-------------------------------------------------------------------------------------------------------


--- RRG 17-02-2009 COL 78551
PROCEDURE PV_VALIDAOOSS_PENDBAJA_PR(LN_NUM_ABONADO GA_ABOCEL.NUM_ABONADO%TYPE,
            LN_TIENE_ORDEN_BAJA              OUT NOCOPY        NUMBER,
            SN_cod_retorno            OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
            SV_mens_retorno           OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
            SN_num_evento             OUT NOCOPY    ge_errores_pg.evento);

PROCEDURE PV_OBTIENE_CALIFICA_ABONADO_PR(EN_NUM_ABONADO  IN PV_CALIFICA_CELULAR_TO.NUM_ABONADO%TYPE,
                                         EN_NUM_CELULAR  IN PV_CALIFICA_CELULAR_TO.NUM_CELULAR%TYPE,
                                         SV_COD_CALIFICA OUT NOCOPY   PV_CALIFICA_CELULAR_TO.COD_CALIFICA%TYPE,
                                         SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento   OUT NOCOPY   ge_errores_pg.evento);

PROCEDURE PV_CERRAR_VIGENCIA_PRECAL_PR(EN_NUM_ABONADO  IN PV_CALIFICA_CELULAR_TO.NUM_ABONADO%TYPE,
                                       EN_NUM_CELULAR  IN PV_CALIFICA_CELULAR_TO.NUM_CELULAR%TYPE,
                                       EN_ACCION       IN PV_CALIFICA_CELULAR_TH.COD_ACCIONCAL%TYPE,
                                       EV_USER         IN PV_CALIFICA_CELULAR_TH.NOM_USUARIO%TYPE,
                                       SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento   OUT NOCOPY   ge_errores_pg.evento);

PROCEDURE PV_ACTUALIZA_CADENASALDO_PR(EN_NUM_ABONADO  IN GA_DATABONADO_TO.NUM_ABONADO%TYPE,
                                      EV_CADENA       IN GA_DATABONADO_TO.CADENA%TYPE,
                                      SN_cod_retorno  OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                      SV_mens_retorno OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                      SN_num_evento   OUT NOCOPY   ge_errores_pg.evento);
                                      
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE PV_GENERA_SOLICMIGRAR_PR (     EN_COD_CLIENTE      IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EV_COD_PLANTARIF    IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                         EV_NUM_CELULAR      IN  GA_ABOCEL.NUM_CELULAR%TYPE,
                                         EV_USER             IN  GA_ABOCEL.NOM_USUARORA%TYPE,
                                         EV_SERIE            IN  AL_SERIES.NUM_SERIE%TYPE,
                                         EV_PROCEDENCIA      IN  GA_ABOCEL.IND_PROCEQUI%TYPE,
                                         EV_SALDO            IN  GA_DATABONADO_TO.CADENA%TYPE,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento);


PROCEDURE PV_MIGRAR_MASIVO_PR        (  EV_COD_ACTABO    IN  GA_ACTABO.COD_ACTABO%TYPE,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento);


PROCEDURE PV_MIGRAR_COMERCIAL_PR        (EV_COD_ACTABO       IN  GA_ACTABO.COD_ACTABO%TYPE,
                                         EN_NUM_ABONADO      IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                         EV_SALDO            IN  GA_DATABONADO_TO.CADENA%TYPE,
                                         SN_NUM_OS           OUT NOCOPY   CI_ORSERV.NUM_OS%TYPE,
                                         SN_cod_retorno      OUT NOCOPY   ge_errores_td.cod_msgerror%TYPE,
                                         SV_mens_retorno     OUT NOCOPY   ge_errores_td.det_msgerror%TYPE,
                                         SN_num_evento       OUT NOCOPY   ge_errores_pg.evento);


PROCEDURE PV_UPDATE_INTARCEL_ACC_PR(EO_GA_INTARCEL           IN  OUT NOCOPY       PV_GA_INTARCEL_QT, --inc 147444
                                    SN_cod_retorno           OUT NOCOPY           ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno          OUT NOCOPY           ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento            OUT NOCOPY           ge_errores_pg.evento);

END PV_DATOS_ABONADO_PG;
/
SHOW ERROR
