CREATE OR REPLACE PACKAGE PV_TRATAMIENTO_SS_PG

/*
<Documentación
        TipoDoc = "Package">
        <Elemento
                Nombre = "PV_TRATAMIENTO_SS_PG"
                Lenguaje="PL/SQL"
                Fecha creación="14-Dic-2006"
                Creado por="Manuel Acevedo"
                Fecha modificacion=""
                Modificado por=""
                Ambiente Desarrollo="BD">
                <Retorno>N/A</Retorno>
                <Descripción>Contiene procedimientos para ejecutar en OOSS Coeficiente Reductor</Descripción>
                <Parámetros>
                        <Entrada>N/A</Entrada>
                        <Salida>N/A</Salida>
                </Parámetros>
        </Elemento>
</Documentación>
*/
IS

  -- SS CONTRATADOS --
  TYPE  typ_rec_ss_contratados IS RECORD (
        t_v_origen          VARCHAR2(3),
        t_v_cod_servicio    VARCHAR2(3),
        t_v_cod_servsupl    NUMBER,
        t_v_cod_nivel       NUMBER,
        t_v_cod_accion      VARCHAR2(1));

  TYPE  typ_tab_ss_contratados IS TABLE OF typ_rec_ss_contratados
          INDEX BY BINARY_INTEGER;

  tab_contratados    typ_tab_ss_contratados;

  ind_contratados    BINARY_INTEGER := 0;

  -- SS PLAN NUEVO --
  TYPE  typ_rec_ss_nuevo IS RECORD (
        t_v_origen          VARCHAR2(3),
        t_v_cod_servicio    VARCHAR2(3),
        t_v_cod_servsupl    NUMBER,
        t_v_cod_nivel       NUMBER,
        t_v_cod_accion      VARCHAR2(1));

  TYPE  typ_tab_ss_nuevo IS TABLE OF typ_rec_ss_nuevo
          INDEX BY BINARY_INTEGER;

  tab_nuevo    typ_tab_ss_nuevo;

  ind_nuevo    BINARY_INTEGER := 0;

  -- SS PERFILES --
  TYPE  typ_rec_ss_perfiles IS RECORD (
        t_v_origen          VARCHAR2(3),
        t_v_cod_servicio    VARCHAR2(3),
        t_v_cod_servsupl    NUMBER,
        t_v_cod_nivel       NUMBER,
        t_v_cod_accion      VARCHAR2(1));

  TYPE  typ_tab_ss_perfiles IS TABLE OF typ_rec_ss_perfiles
          INDEX BY BINARY_INTEGER;

  tab_perfiles    typ_tab_ss_perfiles;

  ind_perfiles    BINARY_INTEGER := 0;

   -- TIPOS DE ORIGENES --
   CV_def                   CONSTANT VARCHAR2 (3)   := 'DEF'; -- SERVICIO DEFAULT AL PLAN --
   CV_opc                   CONSTANT VARCHAR2 (3)   := 'OPC'; -- SERVICIO OPCIONAL AL PLAN --
   CV_per                   CONSTANT VARCHAR2 (3)   := 'PER'; -- SERVICIO DE PERFIL DE CENTRALES --
   CV_tra                   CONSTANT VARCHAR2 (3)   := 'TRA'; -- SERVICIO AGREGADO POR UN TRASPASO --
   CV_con                   CONSTANT VARCHAR2 (3)   := 'CON'; -- SERVICIO AGREGADO POR UNA CONVERSION --
   CV_atl                   CONSTANT VARCHAR2 (3)   := 'ATL'; -- SERVICIO ATLANTIDA--
   CV_esp                   CONSTANT VARCHAR2 (3)   := 'ESP'; -- SERVICIO ESPECIAL--

   -- TIPOS DE ACCIONES --
   CV_a                     CONSTANT VARCHAR2 (1)  := 'A'; -- ACTIVAR --
   CV_d                     CONSTANT VARCHAR2 (1)  := 'D'; -- DESACTIVAR --
   CV_m                     CONSTANT VARCHAR2 (1)  := 'M'; -- MANTENER --
   CV_n                     CONSTANT VARCHAR2 (1)  := 'N'; -- NO CONSIDERAR --

   --CONSTANTES CON TIPOLOGIA PARA TIPO DE PLANES TARIFARIOS --
   CV_atlantida             VARCHAR2(3) := 'ATL'; -- PLAN ATLANTIDA --
   CV_prepago               VARCHAR2(3) := 'PRE'; -- PLAN PREPAGO --
   CV_postpago              VARCHAR2(3) := 'POS'; -- PLAN POSTPAGO --
   CV_hibrido               VARCHAR2(3) := 'HIB'; -- PLAN HIBRIDO --

   CV_alta_postpago         CONSTANT VARCHAR2 (15) := 'ALTA_POSTPAGO';
   CV_alta_hibrido          CONSTANT VARCHAR2 (15) := 'ALTA_HIBRIDO';
   CV_alta_prepago          CONSTANT VARCHAR2 (15) := 'ALTA_PREPAGO';

   CN_estado                CONSTANT NUMBER(1) := 3;

   CN_estado1               CONSTANT NUMBER(1) := 1;

   CV_si                    CONSTANT VARCHAR2 (1)  := 'S';
   GV_ind_opcionales        VARCHAR2 (1);

   CV_pv                    VARCHAR2(2) := 'PV';
   CV_error_no_clasif       VARCHAR2(30):= 'Error no Clasificado';
   CV_enproceso             VARCHAR2(30):= 'En Proceso';
   CV_procesoexi            VARCHAR2(30):= 'Proceso Existoso';

   CN_opc_comerc_central1   CONSTANT NUMBER(1) := 1;
   CN_opc_comerc_central2   CONSTANT NUMBER(1) := 2;
   CN_opc_comerc_central3   CONSTANT NUMBER(1) := 3;

   CN_ind_gestor            CONSTANT NUMBER  := 1;

   CN_producto              NUMBER(1) := 1;

   -- TIPO DE RELACIONES--
   CN_ss_opcional           CONSTANT NUMBER (1)     := 2; -- SERVICIO OPCIONAL --
   CN_ss_default            CONSTANT NUMBER (1)     := 3; -- SERVICIO POR DEFAULT --

   -- CODIGO TIPO DE PLANES TARIFARIOS --
   CV_codtiplan1            VARCHAR2(1) := '1'; -- PLAN PREPAGO  --
   CV_codtiplan2            VARCHAR2(1) := '2'; -- PLAN POSTPAGO --
   CV_codtiplan3            VARCHAR2(1) := '3'; -- PLAN HIBRIDO  --

   CV_mantiene_producto     CONSTANT BOOLEAN :=TRUE;

   CV_grupos_wap_mms_roa    CONSTANT VARCHAR2 (18)  := 'GRUPOS_WAP_MMS_ROA';
   CV_servicios_interopco   CONSTANT VARCHAR2 (19)  := 'SERVICIOS_INTEROPCO';
   CV_ss_opc_comerc_centr   CONSTANT VARCHAR2 (19)  := 'SS_OPC_COMERC_CENTR';
   CV_grupo_sms_on_demand   CONSTANT VARCHAR2 (19)  := 'GRUPO_SMS_ON_DEMAND';

   CV_op_local              CONSTANT VARCHAR2 (19) := 'COD_OPERADORA_LOCAL';
   CV_mo_ge                 CONSTANT VARCHAR2 (3)  := 'GE';
   CV_mo_ga                 CONSTANT VARCHAR2 (3)  := 'GA';
   CV_tabla                 CONSTANT VARCHAR2 (20) := 'GAD_SERVSUP_PLAN';
   CV_columna               CONSTANT VARCHAR2 (20) := 'COD_SERVICIO';

   CV_aplica_atlantida      CONSTANT VARCHAR2 (16) := 'APLICA_ATLANTIDA';
   CV_true                  CONSTANT VARCHAR2 (4)  := 'TRUE';
   CV_ooss                  CONSTANT VARCHAR2 (30) := 'TP,T2,RO,R2,AE,A2';

   CV_usuario_admin         CONSTANT VARCHAR2 (12) := 'GRP_USUADMIN';

   CN_tip_serv              CONSTANT NUMBER (1)    := 2;

   CN_relacion3             CONSTANT NUMBER(1) := 3;   --Codigo tipo de relacion de servicios .
   CN_Relacion4             CONSTANT NUMBER(1) := 4;   --Codigo tipo de relacion de servicios .
   CN_relacion1             CONSTANT NUMBER(1) := 1;   --Codigo tipo de relacion de servicios .

   --Constantes Globales--
   CV_fa                    CONSTANT    VARCHAR2(2) := 'FA';

   GN_EVENTO                NUMBER;

   I                        NUMBER;

   GV_ind_trasp_opc         VARCHAR2(10);

PROCEDURE PV_CARGA_SS_ACTUALES_PR(EN_num_abonado    IN  NUMBER,
                                  EV_cod_plan       IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                  EV_indicador      IN  VARCHAR2,
                                  SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                  SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                  SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_CARGA_SS_PLAN_NUEVO_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                    EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                    SN_cod_retorno            IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                    SV_mens_retorno           IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                    SN_num_evento             IN OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_CARGA_SS_PERF_CENT_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   SN_cod_retorno            IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno           IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento             IN OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_ACTIVOS_PR(EN_num_abonado            IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                 EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                 EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                 SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                 SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                 SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_DUPLICADOS_PR(SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                 SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                 SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_TRANSFERENCIAS_PR(EN_num_abonado                   IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                     SN_cod_retorno                   IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                     SV_mens_retorno                  IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                     SN_num_evento                    IN OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_CONVERSIONES_PR(EN_num_abonado                 IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plantarif_origen        IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   EV_cod_plantarif_destino       IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   SN_cod_retorno                 IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno                IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento                  IN OUT NOCOPY GE_ERRORES_PG.Evento);
/*
PROCEDURE PV_REGLA_SS_SMS_ONDEMAND_PR(EN_num_abonado           IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                      EV_cod_plantarif_origen  IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                      EV_cod_plantarif_destino IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                      SN_cod_retorno           OUT NOCOPY GE_ERRORES_PG.CodError,
                                      SV_mens_retorno          OUT NOCOPY GE_ERRORES_PG.MsgError,
                                      SN_num_evento            OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_WAPGPRSMMSROA_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       EV_cod_plantarif_destino  IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_INTEROPCO_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   EV_cod_plantarif_destino  IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                   SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento);
*/
PROCEDURE PV_REGLA_SS_GESTOR_PR(EN_num_abonado    IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                SN_cod_retorno    OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno   OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento     OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_PERFIL_PR(EN_num_abonado            IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                EV_cod_plantarif_origen   IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                EV_cod_plan_destino       IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno            OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno           OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento             OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_INCOMPATIBILIDAD_PR(EN_num_abonado         IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                       SN_cod_retorno         OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno        OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento          OUT NOCOPY GE_ERRORES_PG.Evento);


PROCEDURE PV_ACTIVA_DESACTIVA_SS_PR(EN_num_abonado        IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SN_cod_retorno        OUT NOCOPY GE_ERRORES_PG.CodError,
                                    SV_mens_retorno       OUT NOCOPY GE_ERRORES_PG.MsgError,
                                    SN_num_evento         OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_ATLANTIDA_PR(EN_num_abonado                 IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                   EV_cod_plan_destino            IN  TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                   EV_cod_ooss                    IN  CI_ORSERV.COD_OS%TYPE,
                                   SN_cod_retorno                 OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno                OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento                  OUT NOCOPY GE_ERRORES_PG.Evento);

FUNCTION PV_EXISTE_CAMBIO_PRODUCTO_FN (EN_num_abonado           IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                       EV_cod_plantarif_origen  IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       EV_cod_plantarif_destino IN  GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_retorno           IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno          IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento            IN OUT NOCOPY GE_ERRORES_PG.Evento) RETURN STRING;

FUNCTION PV_PLAN_DESTINO_ATLANTIDA_FN (EV_cod_plan_destino IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento) RETURN STRING;

PROCEDURE PV_CONSULTA_SS_LIGADOS_PR (EN_num_abonado      IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                     EV_cod_servicio     IN     GA_SERVSUPL.COD_SERVICIO%TYPE,
                                     EV_cod_accion       IN     VARCHAR2,
                                     SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                     SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                     SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_COD_TIPO_PLAN_TARIFARIO_PR (EV_cod_plan_tarifario    IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                         SV_cod_tipo_plan         IN OUT TA_PLANTARIF.COD_TIPLAN%TYPE,
                                         SV_des_tip_plan          IN OUT VARCHAR2,
                                         SN_cod_retorno           IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                         SV_mens_retorno          IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                         SN_num_evento            IN OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_RECUPERA_DATOS_ABONADO_PR(EN_num_abonado      IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                       SV_tip_terminal     IN OUT GA_ABOCEL.TIP_TERMINAL%TYPE,
                                       SV_cod_tecnologia   IN OUT GA_ABOCEL.COD_TECNOLOGIA%TYPE,
                                       SV_cod_plan_tarif   IN OUT GA_ABOCEL.COD_PLANTARIF%TYPE,
                                       SN_cod_central      IN OUT GA_ABOCEL.COD_CENTRAL%TYPE,
                                       SN_num_celular      IN OUT GA_ABOCEL.NUM_CELULAR%TYPE,
                                       SN_cod_sistema      IN OUT ICG_CENTRAL.COD_SISTEMA%TYPE,
                                       SN_cod_retorno      IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                       SV_mens_retorno     IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                       SN_num_evento       IN OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_ARMADO_CADENAS_SS_PR (EN_cod_cliente    IN     GA_ABOCEL.COD_CLIENTE%TYPE,
                                   EN_num_abonado    IN     GA_ABOCEL.num_abonado%TYPE,
                                   SN_cod_retorno    IN OUT NOCOPY GE_ERRORES_PG.CodError,
                                   SV_mens_retorno   IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                                   SN_num_evento     IN OUT NOCOPY GE_ERRORES_PG.Evento);


FUNCTION PV_INSERTA_ERROR_FN (EV_cod_error    IN PV_TMPPARAMETROS_SALIDA_TT.COD_ERROR%TYPE,
                              EV_des_error    IN PV_TMPPARAMETROS_SALIDA_TT.DES_ERROR%TYPE,
                              EV_num_abonado  IN GA_ABOCEL.NUM_ABONADO%TYPE,
                              SN_cod_retorno  IN OUT NOCOPY GE_ERRORES_PG.CodError,
                              SV_mens_retorno IN OUT NOCOPY GE_ERRORES_PG.MsgError,
                              SN_num_evento   IN OUT NOCOPY GE_ERRORES_PG.Evento) RETURN STRING;
/*
PROCEDURE PV_REGLA_SS_ROAMING_PR(EN_num_abonado              IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                EV_cod_plantarif_origen   IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                                        EV_cod_plantarif_destino  IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno              OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno             OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento               OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_WAPMMS_PR(EN_num_abonado              IN     GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                EV_cod_plantarif_origen     IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                                        EV_cod_plantarif_destino    IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno              OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno             OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento               OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_INTEROPCO2_PR(EN_num_abonado              IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                EV_cod_plantarif_origen   IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                                        EV_cod_plantarif_destino  IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno              OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno             OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento               OUT NOCOPY GE_ERRORES_PG.Evento);

PROCEDURE PV_REGLA_SS_SMS_PR(   EN_num_abonado              IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                EV_cod_plantarif_origen   IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                                        EV_cod_plantarif_destino  IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno              OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno             OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento               OUT NOCOPY GE_ERRORES_PG.Evento);
PROCEDURE PV_REGLA_SS_HIBRIDO_PR(       EN_num_abonado              IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                                                EV_cod_plantarif_origen   IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                                        EV_cod_plantarif_destino  IN     GA_ABOCEL.COD_PLANTARIF%TYPE,
                                SN_cod_retorno              OUT NOCOPY GE_ERRORES_PG.CodError,
                                SV_mens_retorno             OUT NOCOPY GE_ERRORES_PG.MsgError,
                                SN_num_evento               OUT NOCOPY GE_ERRORES_PG.Evento);           */

END PV_TRATAMIENTO_SS_PG;
/
SHOW ERRORS