CREATE OR REPLACE PACKAGE PV_OOSS_BATCH_HIBRIDO_PG IS
-- *************************************************************
-- * Paquete            : PV_OOSS_BATCH_HIBRIDO_PG
-- * Descripción        : Funciones y procedimientos de persistencia
-- * Función            : Packarge para Generar tablas Batch
-- * Fecha de creación  : Junio 2006
-- * F. de Homologacion :
-- * Actualizacion      : Postventa SCL - Orlando Cabezas B.
-- *************************************************************

-- Declaracion de Variables Globales

-- Inicio especificacion PL/SQL


   CV_0                     CONSTANT VARCHAR2 (1)   := '0';
   CV_1                     CONSTANT VARCHAR2 (1)   := '1';
   CV_3                     CONSTANT VARCHAR2 (1)   := '3';
   CV_4                     CONSTANT VARCHAR2 (1)   := '4';
   CV_PVA                   CONSTANT VARCHAR2 (3)   := 'PVA';
   CV_PACKAGE               CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INSCRIBE_OOSS_PR';
   CV_PACKAGE2              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_IORSERV_FN';
   CV_PACKAGE3              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_MOVIMIENTOS_FN';
   CV_PACKAGE4              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_PARAM_ABOCEL_FN';
   CV_PACKAGE5              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_INS_CAMCOM_FN';
   CV_PACKAGE6              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_GA_TRANSACABO_FN ';
   CV_PACKAGE7              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_ERECORRIDO';
   CV_PACKAGE8              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_PROG';
   CV_PACKAGE9              CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_UPD_IORSERV_FN';
   CV_PACKAGE10             CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_UPD_ERECORRIDO_FN';
   CV_PACKAGE11             CONSTANT VARCHAR2 (70)  := 'PV_OOSS_BATCH_HIBRIDO_PG.PV_VAL_OOSSBATCH_PEND_FN';


   CN_0                     CONSTANT NUMBER (1)     := 0;
   CN_1                     CONSTANT NUMBER (1)     := 1;
   CN_3                     CONSTANT NUMBER (1)     := 3;
   CN_4                     CONSTANT NUMBER (1)     := 4;
   CN_10                    CONSTANT NUMBER (2)     := 10;


   CV_PV                    VARCHAR2(2) := 'PV';
   CV_error_no_clasif       VARCHAR2(30):= 'Error no Clasificado';
   CV_ENPROCESO             VARCHAR2(30):= 'En Proceso';
   CV_PROCESOEXI            VARCHAR2(30):= 'Proceso Existoso';

   CV_TIPOSERV              VARCHAR2(30):= 'Error Conf. Ci_tiporserv';
   CV_INTESTADOC            VARCHAR2(30):= 'Error Conf. Fa_intestadoc';
   CV_INS_PARAM_ABO         VARCHAR2(70):= 'Error Inserción PV_PARAM_ABOCEL';
   CV_INS_CAMCOM            VARCHAR2(70):= 'Error Inserción PV_CAMCOM';
   CV_INS_MOVI              VARCHAR2(70):= 'Error Inserción PV_MOVIMIENTOS';
   CV_INS_ERECO             VARCHAR2(70):= 'Error Inserción PV_ERECORRIDO';
   CV_INS_PROG              VARCHAR2(70):= 'Error Inserción PV_PROG';
   CV_INS_IORSERV           VARCHAR2(70):= 'Error Inserción PV_IORSERV';
   CV_UPD_IORSERV                       VARCHAR2(70):= 'Error Actualizar PV_IORSERV';
   CV_UPD_ERECORRIDO        VARCHAR2(70):= 'Error Actualizar PV_ERECORRIDO';

   GN_EVENTO                NUMBER;



FUNCTION PV_VAL_OOSSBATCH_PEND_FN(
      EV_cod_Os            IN PV_IORSERV.COD_OS%TYPE,
          EN_cod_cliente       IN PV_CAMCOM.COD_CLIENTE%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN;



FUNCTION PV_INS_IORSERV_FN(
      EN_secuencia         IN PV_IORSERV.NUM_OS%TYPE,
      EV_cod_Os            IN PV_IORSERV.COD_OS%TYPE,
      EV_descripcion       IN PV_IORSERV.DESCRIPCION%TYPE,
      EN_producto          IN PV_IORSERV.PRODUCTO%TYPE,
      EV_usuario           IN PV_IORSERV.USUARIO%TYPE,
      EN_tip_Procesa       IN PV_IORSERV.TIP_PROCESA%TYPE,
      EV_cod_Modgener      IN PV_IORSERV.COD_MODGENER%TYPE,
          ED_FECPROG           IN PV_IORSERV.FH_EJECUCION%TYPE,
          EV_TSUBJETO          IN PV_IORSERV.TIP_SUBSUJETO%TYPE,
          EV_SUJETO            IN PV_IORSERV.TIP_SUJETO%TYPE,
          EV_PATHF             IN PV_IORSERV.PATH_FILE%TYPE,
          EV_NFILE             IN PV_IORSERV.NFILE%TYPE,
          EV_MODULO            IN PV_IORSERV.COD_MODULO%TYPE,
          EN_NumTar            IN PV_IORSERV.ID_GESTOR%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN;


FUNCTION PV_INS_ERECORRIDO_FN (
      EN_secuencia         IN PV_IORSERV.NUM_OS%TYPE,
      EV_descripcion       IN PV_ERECORRIDO.DESCRIPCION%TYPE,
          SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
)RETURN BOOLEAN;


FUNCTION PV_INS_PROG_FN (
      EN_secuencia         IN PV_IORSERV.NUM_OS%TYPE,
      ED_FECPROG           IN PV_IORSERV.FH_EJECUCION%TYPE,
          EV_usuario           IN PV_IORSERV.USUARIO%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY VARCHAR2
)RETURN BOOLEAN;



FUNCTION PV_INS_MOVIMIENTOS_FN(
      EN_secuencia         IN PV_MOVIMIENTOS.NUM_OS%TYPE,
      EN_actabo            IN PV_MOVIMIENTOS.COD_ACTABO%TYPE,
      EN_ind_estado        IN PV_MOVIMIENTOS.IND_ESTADO%TYPE,
          EN_carga                         IN pv_movimientos.carga%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
) RETURN BOOLEAN;


FUNCTION PV_INS_PARAM_ABOCEL_FN (
      EN_secuencia         IN PV_PARAM_ABOCEL.NUM_OS%TYPE,
      EV_num_abonado       IN PV_PARAM_ABOCEL.NUM_ABONADO%TYPE,
      EV_actabo            IN PV_PARAM_ABOCEL.COD_TIPMODI%TYPE,
      EV_usuario           IN PV_PARAM_ABOCEL.NUOM_USUARORA%TYPE,
      EN_celular           IN PV_PARAM_ABOCEL.NUM_CELULAR%TYPE,
      EV_tip_plantarif     IN PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE,
      EV_cod_plantarif     IN PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE,
--        EV_tip_plantarif_nue IN PV_PARAM_ABOCEL.TIP_PLANTARIF_NUE%TYPE,
--      EV_cod_plantarif_nue IN PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE,
          ED_FECPROG           IN PV_IORSERV.FH_EJECUCION%TYPE,
      SN_p_filasafectas   OUT NOCOPY  NUMBER,
          SN_p_retornora      OUT NOCOPY  NUMBER,
          SN_p_nroevento      OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno   OUT NOCOPY  VARCHAR2
)RETURN BOOLEAN;


FUNCTION PV_INS_CAMCOM_FN (
      EN_secuencia          IN PV_CAMCOM.NUM_OS%TYPE,
      EN_celular            IN PV_CAMCOM.NUM_CELULAR%TYPE,
      EN_cod_cliente        IN PV_CAMCOM.COD_CLIENTE%TYPE,
      EN_cod_cuenta         IN PV_CAMCOM.COD_CUENTA%TYPE,
      EV_bdatos             IN PV_CAMCOM.BDATOS%TYPE,
      EN_num_venta          IN PV_CAMCOM.NUM_VENTA%TYPE,
      EV_cod_actabo         IN PV_CAMCOM.COD_ACTABO%TYPE,
      ED_FECPROG            IN PV_IORSERV.FH_EJECUCION%TYPE,
          EN_num_abonado                IN pv_camcom.num_abonado%TYPE,
      SN_p_filasafectas    OUT NOCOPY  NUMBER,
          SN_p_retornora       OUT NOCOPY  NUMBER,
          SN_p_nroevento       OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno    OUT NOCOPY  VARCHAR2
)RETURN BOOLEAN;

FUNCTION PV_UPD_IORSERV_FN (
      EN_secuencia          IN PV_CAMCOM.NUM_OS%TYPE,
          EV_descripcion                IN  VARCHAR2,
      SN_p_filasafectas    OUT NOCOPY  NUMBER,
          SN_p_retornora       OUT NOCOPY  NUMBER,
          SN_p_nroevento       OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno    OUT NOCOPY  VARCHAR2
)RETURN BOOLEAN;


FUNCTION PV_UPD_ERECORRIDO_FN (
      EN_secuencia          IN PV_CAMCOM.NUM_OS%TYPE,
      EV_descripcion            IN  VARCHAR2,
      SN_p_filasafectas    OUT NOCOPY  NUMBER,
          SN_p_retornora       OUT NOCOPY  NUMBER,
          SN_p_nroevento       OUT NOCOPY  NUMBER,
      SV_p_vcod_retorno    OUT NOCOPY  VARCHAR2
)RETURN BOOLEAN;


PROCEDURE PV_INSCRIBE_OOSS_PR(
       EN_TRANSACABO         IN  GA_TRANSACABO.NUM_TRANSACCION%TYPE,
       EN_num_celular        IN  NUMBER,
       EV_cod_ooss           IN  VARCHAR2,
       EV_usuario            IN  VARCHAR2,
       EN_num_abonado        IN  NUMBER,
           EN_cod_cliente        IN  NUMBER,
           EV_cod_actabo                 IN  ga_actabo.cod_actabo%TYPE,
           EV_BDATOS             IN  VARCHAR2,
           EV_TIP_PLANTARIF      IN  PV_PARAM_ABOCEL.TIP_PLANTARIF%TYPE,
           EV_COD_PLANTARIF      IN  PV_PARAM_ABOCEL.COD_PLANTARIF%TYPE,
--         EV_TIP_PLANTARIF_NUE  IN  PV_PARAM_ABOCEL.TIP_PLANTARIF_NUE%TYPE,
--         EV_COD_PLANTARIF_NUE  IN  PV_PARAM_ABOCEL.COD_PLANTARIF_NUE%TYPE,
           EN_num_venta          IN  PV_CAMCOM.NUM_VENTA%TYPE,
       EN_cod_cuenta         IN  PV_CAMCOM.COD_CUENTA%TYPE,
       ED_FECPROG            IN  VARCHAR2,
           EN_carga                              IN  pv_movimientos.carga%TYPE,
           EV_TSUBJETO           IN  PV_IORSERV.TIP_SUBSUJETO%TYPE,
           EV_SUJETO             IN  PV_IORSERV.TIP_SUJETO%TYPE,
           EV_MODULO             IN  PV_IORSERV.COD_MODULO%TYPE,
           EN_NumTar             IN  PV_IORSERV.ID_GESTOR%TYPE
         );

END PV_OOSS_BATCH_HIBRIDO_PG;
/
SHOW ERRORS
