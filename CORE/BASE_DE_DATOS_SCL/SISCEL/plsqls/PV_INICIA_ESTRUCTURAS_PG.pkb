CREATE OR REPLACE PACKAGE BODY PV_INICIA_ESTRUCTURAS_PG
IS
---------------------------------------------------------------------------------------------------------------
FUNCTION PV_INICIA_PV_TRASP_CARGOS_FN
        RETURN PV_TRASP_CARGOS
IS

BEGIN
        RETURN PV_TRASP_CARGOS( NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END PV_INICIA_PV_TRASP_CARGOS_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_INICIA_PV_CLIENTE_QT_FN
        RETURN PV_CLIENTE_QT
IS

BEGIN
        RETURN PV_CLIENTE_QT( NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
END PV_INICIA_PV_CLIENTE_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_INICIA_GA_ABONADO_QT_FN
        RETURN GA_ABONADO_QT
IS

BEGIN
                RETURN GA_ABONADO_QT( NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END     PV_INICIA_GA_ABONADO_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION FA_PRESUPUESTO_QT_FN
        RETURN FA_PRESUPUESTO_QT
IS

BEGIN
                RETURN FA_PRESUPUESTO_QT( NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );
END     FA_PRESUPUESTO_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_CARGOS_QT_FN
        RETURN PV_CARGOS_QT
IS

BEGIN
                RETURN PV_CARGOS_QT( NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL );
END     PV_CARGOS_QT_FN;
FUNCTION GA_SERVSUPLABO_QT_FN
        RETURN GA_SERVSUPLABO_QT
IS

BEGIN
                RETURN GA_SERVSUPLABO_QT( NULL, NULL );
END     GA_SERVSUPLABO_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_INICIA_GA_PRESUPUESTO_QT_FN
        RETURN GA_PRESUPUESTO_QT
IS

BEGIN
                RETURN GA_PRESUPUESTO_QT( NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END     PV_INICIA_GA_PRESUPUESTO_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_CICLOS_FACTURACION_QT_FN
        RETURN PV_CICLOS_FACTURACION_QT
IS

BEGIN
                RETURN PV_CICLOS_FACTURACION_QT( NULL, NULL, NULL, NULL, NULL, NULL);
END     PV_CICLOS_FACTURACION_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_ORDEN_SERVICIO_QT_FN
        RETURN PV_ORDEN_SERVICIO_QT
IS

BEGIN
                RETURN PV_ORDEN_SERVICIO_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END     PV_ORDEN_SERVICIO_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_DESACT_SERVFREC_QT_FN
        RETURN PV_DESACT_SERVFREC_QT
IS

BEGIN
                RETURN PV_DESACT_SERVFREC_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL );


END     PV_DESACT_SERVFREC_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_FORMATO_FEC_QT_FN
        RETURN PV_FORMATO_FEC_QT
IS

BEGIN
                RETURN PV_FORMATO_FEC_QT(NULL );


END     PV_FORMATO_FEC_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_GA_SEQ_NUMDIASNUM_QT_FN
        RETURN PV_GA_SEQ_NUMDIASNUM_QT
IS

BEGIN
                RETURN PV_GA_SEQ_NUMDIASNUM_QT(NULL, NULL );


END     PV_GA_SEQ_NUMDIASNUM_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_GA_INTARCEL_QT_FN
        RETURN PV_GA_INTARCEL_QT
IS

BEGIN
                RETURN PV_GA_INTARCEL_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );


END     PV_GA_INTARCEL_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_GED_PARAMETROS_QT_FN
        RETURN PV_GED_PARAMETROS_QT
IS

BEGIN
                RETURN PV_GED_PARAMETROS_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );


END     PV_GED_PARAMETROS_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_ICGENERICA_TO_QT_FN
        RETURN PV_ICGENERICA_TO_QT
IS

BEGIN
                RETURN PV_ICGENERICA_TO_QT(NULL, NULL );


END     PV_ICGENERICA_TO_QT_FN;


---------------------------------------------------------------------------------------------------------------
FUNCTION GE_CLIENTES_QT_FN
        RETURN GE_CLIENTES_QT
IS

BEGIN
                RETURN GE_CLIENTES_QT(NULL, NULL );


END     GE_CLIENTES_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_BOLSAS_DINAMICAS_QT_FN
        RETURN PV_BOLSAS_DINAMICAS_QT
IS

BEGIN
                RETURN PV_BOLSAS_DINAMICAS_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );


END     PV_BOLSAS_DINAMICAS_QT_FN;


---------------------------------------------------------------------------------------------------------------
FUNCTION GA_APROVISIONAR_QT_FN
        RETURN GA_APROVISIONAR_QT
IS

BEGIN
                RETURN GA_APROVISIONAR_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL );


END     GA_APROVISIONAR_QT_FN;


---------------------------------------------------------------------------------------------------------------
FUNCTION GA_ABOAMIST_QT_FN
        RETURN GA_ABOAMIST_QT
IS

BEGIN
                RETURN GA_ABOAMIST_QT(NULL, NULL, NULL  );


END     GA_ABOAMIST_QT_FN;


---------------------------------------------------------------------------------------------------------------
FUNCTION PV_IORSERV_QT_FN
        RETURN PV_IORSERV_QT
IS

BEGIN
                RETURN PV_IORSERV_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  );


END     PV_IORSERV_QT_FN;


---------------------------------------------------------------------------------------------------------------
FUNCTION PV_GESTOR_BCORP_QT_FN
        RETURN PV_GESTOR_BCORP_QT
IS

BEGIN
                RETURN PV_GESTOR_BCORP_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  );

END     PV_GESTOR_BCORP_QT_FN;
---------------------------------------------------------------------------------------------------------------

FUNCTION PV_LIMITE_CONSUMO_QT_FN
        RETURN PV_LIMITE_CONSUMO_QT
IS

BEGIN
         RETURN PV_LIMITE_CONSUMO_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_LIMITE_CONSUMO_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION GA_PROD_CONTRATADO_QT_FN
        RETURN GA_PROD_CONTRATADO_QT
IS

BEGIN
         RETURN GA_PROD_CONTRATADO_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL);

END GA_PROD_CONTRATADO_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_GA_PROMOC_QT_FN
        RETURN PV_GA_PROMOC_QT
IS

BEGIN
         RETURN PV_GA_PROMOC_QT(NULL, NULL, NULL, NULL);

END PV_GA_PROMOC_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_FA_CICLFACT_QT_FN
        RETURN PV_FA_CICLFACT_QT
IS

BEGIN
         RETURN PV_FA_CICLFACT_QT(NULL, NULL, NULL, NULL );

END PV_FA_CICLFACT_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_SERVDEFAULT_PLAN_QT_FN
        RETURN PV_SERVDEFAULT_PLAN_QT
IS

BEGIN
         RETURN PV_SERVDEFAULT_PLAN_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_SERVDEFAULT_PLAN_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_NUMCEL_PERS_QT_FN
        RETURN PV_NUMCEL_PERS_QT
IS

BEGIN
         RETURN PV_NUMCEL_PERS_QT(NULL, NULL );

END PV_NUMCEL_PERS_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_REGIST_NIVEL_MODIF_QT_FN
        RETURN PV_REGIST_NIVEL_MODIF_QT
IS

BEGIN
         RETURN PV_REGIST_NIVEL_MODIF_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END PV_REGIST_NIVEL_MODIF_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_REG_CAMB_PLAN_COMER_QT_FN
        RETURN PV_REG_CAMB_PLAN_COMER_QT
IS

BEGIN
         RETURN PV_REG_CAMB_PLAN_COMER_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_REG_CAMB_PLAN_COMER_QT_FN;

---------------------------------------------------------------------------------------------------------------
FUNCTION PV_REG_CAMB_PLAN_SERV_QT_FN
        RETURN PV_REG_CAMB_PLAN_SERV_QT
IS

BEGIN
         RETURN PV_REG_CAMB_PLAN_SERV_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  );

END PV_REG_CAMB_PLAN_SERV_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_VALIDAOoSS_PENDPLAN_QT_FN
        RETURN PV_VALIDAOoSS_PENDPLAN_QT
IS

BEGIN
         RETURN PV_VALIDAOoSS_PENDPLAN_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_VALIDAOoSS_PENDPLAN_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_REG_REORD_PLAN_QT_FN
        RETURN PV_REG_REORD_PLAN_QT
IS

BEGIN
         RETURN PV_REG_REORD_PLAN_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_REG_REORD_PLAN_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_VAL_BAJA_ATLANTIDA_QT_FN
        RETURN PV_VAL_BAJA_ATLANTIDA_QT
IS

BEGIN
         RETURN PV_VAL_BAJA_ATLANTIDA_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_VAL_BAJA_ATLANTIDA_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_VAL_RESTR_COMER_OS_QT_FN
        RETURN PV_VAL_RESTR_COMER_OS_QT
IS

BEGIN
         RETURN PV_VAL_RESTR_COMER_OS_QT(NULL,NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL );

END PV_VAL_RESTR_COMER_OS_QT_FN;


---------------------------------------------------------------------------------------------------------------

FUNCTION PV_VALIDA_SERV_ACTDEC_QT_FN
        RETURN PV_VALIDA_SERV_ACTDEC_QT
IS

BEGIN
         RETURN PV_VALIDA_SERV_ACTDEC_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL );

END PV_VALIDA_SERV_ACTDEC_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_PLANES_TARIFARIOS_QT_FN
        RETURN PV_PLANES_TARIFARIOS_QT
IS

BEGIN
         RETURN PV_PLANES_TARIFARIOS_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL  );

END PV_PLANES_TARIFARIOS_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_VAL_FREEDOM_QT_FN
        RETURN PV_VAL_FREEDOM_QT
IS

BEGIN
         RETURN PV_VAL_FREEDOM_QT(NULL, NULL, NULL, NULL, NULL);

END PV_VAL_FREEDOM_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_BUSQ_FORMA_PAGO_QT_FN
        RETURN PV_BUSQ_FORMA_PAGO_QT
IS

BEGIN
         RETURN PV_BUSQ_FORMA_PAGO_QT(NULL, NULL, NULL);

END PV_BUSQ_FORMA_PAGO_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_BUSQ_TIPO_DOC_QT_FN
        RETURN PV_BUSQ_TIPO_DOC_QT
IS

BEGIN
         RETURN PV_BUSQ_TIPO_DOC_QT(NULL, NULL, NULL, NULL, NULL, NULL);

END PV_BUSQ_TIPO_DOC_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_SECUENCIA_QT_FN
        RETURN PV_SECUENCIA_QT
IS

BEGIN
         RETURN PV_SECUENCIA_QT(NULL, NULL);

END PV_SECUENCIA_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_SOLICITUD_QT_FN
        RETURN PV_SOLICITUD_QT
IS

BEGIN
         RETURN PV_SOLICITUD_QT(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

END PV_SOLICITUD_QT_FN;


---------------------------------------------------------------------------------------------------------------

FUNCTION PV_CONS_PREPAGOS_QT_FN
        RETURN PV_CONS_PREPAGOS_QT
IS

BEGIN
         RETURN PV_CONS_PREPAGOS_QT(NULL ,NULL ,NULL ,NULL ,NULL ,NULL ,NULL, NULL, NULL, NULL );

END PV_CONS_PREPAGOS_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_ACTABO_TIPLAN_QT_FN
        RETURN PV_ACTABO_TIPLAN_QT
IS

BEGIN
         RETURN PV_ACTABO_TIPLAN_QT(NULL ,NULL ,NULL,NULL );

END PV_ACTABO_TIPLAN_QT_FN;

---------------------------------------------------------------------------------------------------------------

FUNCTION PV_CONSALDO_ABONADO_QT_FN
        RETURN PV_CONSALDO_ABONADO_QT
IS

BEGIN
         RETURN PV_CONSALDO_ABONADO_QT(NULL ,NULL ,NULL );

END PV_CONSALDO_ABONADO_QT_FN;


---------------------------------------------------------------------------------------------------------------


FUNCTION PV_OBT_CAMB_PLAN_SERV_QT_FN
        RETURN PV_OBT_CAMB_PLAN_SERV_QT
IS

BEGIN
         RETURN PV_OBT_CAMB_PLAN_SERV_QT(NULL ,NULL ,NULL );

END PV_OBT_CAMB_PLAN_SERV_QT_FN;

--------------------------------------------------------------------------------------------------------------


FUNCTION PV_GA_IMPPENALIZA_QT_FN
        RETURN PV_GA_IMPPENALIZA_QT
IS

BEGIN
         RETURN PV_GA_IMPPENALIZA_QT(NULL ,NULL ,NULL,NULL ,NULL ,NULL,NULL ,NULL);

END PV_GA_IMPPENALIZA_QT_FN;
--------------------------------------------------------------------------------------------------------------
FUNCTION PV_GAT_DEVLEQUIP_QT_FN
        RETURN PV_GAT_DEVLEQUIP_QT
IS

BEGIN
         RETURN PV_GAT_DEVLEQUIP_QT(NULL ,NULL ,NULL,NULL ,NULL ,NULL,NULL ,NULL,NULL ,NULL,NULL ,NULL ,NULL,NULL ,NULL,NULL);

END PV_GAT_DEVLEQUIP_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------
FUNCTION   PV_GA_PARAMBAJAINDEMNIZ_QT_FN
       RETURN PV_GA_PARAMBAJAINDEMNIZ_QT
IS

BEGIN
         RETURN PV_GA_PARAMBAJAINDEMNIZ_QT(NULL ,NULL ,NULL,NULL ,NULL ,NULL);

END PV_GA_PARAMBAJAINDEMNIZ_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_GA_CARGOSBINDEMNIZ_QT_FN
                 RETURN PV_GA_CARGOSBINDEMNIZ_QT
IS

BEGIN
         RETURN PV_GA_CARGOSBINDEMNIZ_QT(NULL ,NULL ,NULL,NULL ,NULL ,NULL,NULL ,NULL,NULL ,NULL ,NULL);

END PV_GA_CARGOSBINDEMNIZ_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_GA_ABOCEL_QT_FN
                 RETURN PV_GA_ABOCEL_QT
IS

BEGIN
         RETURN PV_GA_ABOCEL_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                        NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END PV_GA_ABOCEL_QT_FN;






FUNCTION GE_PROCESOS_QT_FN
                 RETURN GE_PROCESOS_QT
IS

BEGIN
         RETURN GE_PROCESOS_QT(NULL,NULL,NULL,NULL,NULL);

END GE_PROCESOS_QT_FN;

FUNCTION VE_DESCUENTO_VEN_QT_FN
                 RETURN VE_DESCUENTO_VEN_QT
IS

BEGIN
         RETURN VE_DESCUENTO_VEN_QT(NULL,NULL,NULL);

END VE_DESCUENTO_VEN_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION FA_CARGOS_SN_QT_FN
                 RETURN FA_CARGOS_QT
IS

BEGIN
         RETURN FA_CARGOS_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL);

END FA_CARGOS_SN_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_ORDEN_SERVICIO_QT_FN
                 RETURN GE_ORDEN_SERVICIO_QT
IS

BEGIN
         RETURN GE_ORDEN_SERVICIO_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                         NULL,NULL,NULL,NULL);

END GE_ORDEN_SERVICIO_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION FA_ESTADOC_QT_FN
                 RETURN FA_ESTADOC_QT
IS

BEGIN
         RETURN FA_ESTADOC_QT(NULL,NULL,NULL);

END FA_ESTADOC_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_MOVIMIENTOS_QT_FN
                 RETURN PV_MOVIMIENTOS_QT
IS

BEGIN
         RETURN PV_MOVIMIENTOS_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END PV_MOVIMIENTOS_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_CAMCOM_QT_FN
                 RETURN PV_CAMCOM_QT
IS

BEGIN
         RETURN PV_CAMCOM_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                             NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL);

END PV_CAMCOM_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_PARAMABOCEL_QT_FN
                 RETURN PV_PARAMABOCEL_QT
IS

BEGIN
         RETURN PV_PARAMABOCEL_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                      NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                      NULL,NULL,NULL,NULL,NULL,NULL);

END PV_PARAMABOCEL_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_CARGOS_QT_FN
                 RETURN GE_CARGOS_QT
IS

BEGIN
         RETURN GE_CARGOS_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                             NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
                                                 NULL,NULL);

END GE_CARGOS_QT_FN;


-------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_OOSS_EN_LINEA_QT_FN
                 RETURN GE_OOSS_EN_LINEA_QT
IS

BEGIN

          RETURN GE_OOSS_EN_LINEA_QT(NULL,NULL,NULL,NULL,NULL,NULL,
                                                                 NULL,NULL,NULL,NULL,NULL,NULL);

END GE_OOSS_EN_LINEA_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_VALIDA_PERM_QT_FN
                 RETURN PV_VALIDA_PERM_QT
IS

BEGIN

          RETURN PV_VALIDA_PERM_QT(NULL,NULL,NULL,NULL);

END PV_VALIDA_PERM_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_TRASPASO_PLAN_QT_FN
                 RETURN PV_TRASPASO_PLAN_QT
IS

BEGIN

          RETURN PV_TRASPASO_PLAN_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END PV_TRASPASO_PLAN_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION GA_VENTA_QT_FN
                 RETURN GA_VENTA_QT
IS

BEGIN

          RETURN GA_VENTA_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END GA_VENTA_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_DIRECCION_QT_FN
                 RETURN GE_DIRECCION_QT
IS

BEGIN

          RETURN GE_DIRECCION_QT(NULL,NULL,NULL,NULL,NULL);

END GE_DIRECCION_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION VE_VENDEDOR_QT_FN
                 RETURN VE_VENDEDOR_QT
IS

BEGIN

          RETURN VE_VENDEDOR_QT(NULL,NULL);

END VE_VENDEDOR_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------

FUNCTION PV_PLANTARIF_QT_FN
                 RETURN PV_PLANTARIF_QT
IS

BEGIN

          RETURN PV_PLANTARIF_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END PV_PLANTARIF_QT_FN;
-------------------------------------------------------------------------------------------------------------------------------

FUNCTION GE_SEG_USUARIO_QT_FN
                 RETURN GE_SEG_USUARIO_QT
IS

BEGIN

          RETURN GE_SEG_USUARIO_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END GE_SEG_USUARIO_QT_FN;

-------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_FILTRO_ABONADOS_QT_FN
                 RETURN PV_FILTRO_ABONADOS_QT
IS

BEGIN

          RETURN PV_FILTRO_ABONADOS_QT(NULL,NULL,NULL);

END PV_FILTRO_ABONADOS_QT_FN;


-------------------------------------------------------------------------------------------------------------------------------
FUNCTION PV_ACT_PARAM_COMERCIAL_QT_FN
                 RETURN PV_ACT_PARAM_COMERCIAL_QT
IS

BEGIN

          RETURN PV_ACT_PARAM_COMERCIAL_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

END PV_ACT_PARAM_COMERCIAL_QT_FN;

END PV_INICIA_ESTRUCTURAS_PG;
/
SHOW ERRORS