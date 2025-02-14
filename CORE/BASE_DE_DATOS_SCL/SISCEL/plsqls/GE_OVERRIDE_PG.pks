CREATE OR REPLACE PACKAGE GE_OVERRIDE_PG IS

    TYPE refcursor       IS REF CURSOR;
    CV_version           CONSTANT VARCHAR(3)   := '1.0';
    CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
    CV_cod_modulo        CONSTANT VARCHAR2(2)  := 'GE';
    CN_cero              CONSTANT NUMBER(1)    := 0;
    CN_produc_cel        CONSTANT NUMBER(1)    := 1;
    CV_actabo_fa         CONSTANT VARCHAR2(2)  := 'FA';
    CV_situacion_AAA     CONSTANT VARCHAR2(3)  := 'AAA';
    CN_cod_producto      CONSTANT NUMBER(1)    := 1;
    CN_estado_seis       CONSTANT NUMBER(1)    := 6;
    CN_cod_tipserv       CONSTANT NUMBER(1)    := 2;
    CV_tip_serv_cb       CONSTANT VARCHAR2(2)  := 'CB';
    CV_tip_serv_ss       CONSTANT VARCHAR2(2)  := 'SS';
    CV_tip_serv_pa       CONSTANT VARCHAR2(2)  := 'PA';
    CV_modulo_pv         CONSTANT VARCHAR2(2)  := 'PV';

FUNCTION  GE_VAL_DATOS_CLIE_FN (EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE
) RETURN NUMBER;

FUNCTION  GE_IMPORTE_GRAVADO_FN (EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE,
                                 EV_COD_OFICINA  IN ge_clientes.cod_oficina%TYPE,
                                 EN_COD_CONCEPTO IN NUMBER,
                                 EN_IMPORTE      IN NUMBER
) RETURN NUMBER;

FUNCTION  GE_REC_PARAMETROS_FN (EV_COD_MODULO    IN ged_parametros.cod_modulo%TYPE,
                                EN_COD_PRODUCTO  IN ged_parametros.cod_producto%TYPE,
                                EV_NOM_PARAMETRO IN ged_parametros.nom_parametro%TYPE
) RETURN VARCHAR2;
PROCEDURE GE_REC_TIP_IDENT_PR(EN_VALOR         IN  NUMBER,
                              SC_REG_IDENT     OUT NOCOPY      refcursor);

PROCEDURE GE_REC_DATOS_CLIE_PR(EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE,
                               SC_REG_CLIE     OUT NOCOPY      refcursor);

PROCEDURE GE_REC_CLIE_PR(EV_COD_TIPIDENT  IN ge_clientes.cod_tipident%TYPE,
                         EV_NUM_IDENT     IN ge_clientes.num_ident%TYPE,
                         SC_REG_CLIE     OUT NOCOPY      refcursor);

PROCEDURE GE_REC_ABNCLIE_PR(EN_COD_CLIENTE  IN ge_clientes.cod_cliente%TYPE,
                            SC_REG_ABON     OUT NOCOPY      refcursor);

PROCEDURE GE_REC_CRGBSC_CLIE_PR(EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                                EN_NUM_ABONADO  IN ga_abocel.num_abonado%TYPE,
                                EN_NUM_DIAS     IN number,
                                SC_REG_CRG        OUT NOCOPY      refcursor);

PROCEDURE GE_REC_SS_CLIE_PR(EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                            EN_NUM_ABONADO  IN ga_abocel.num_abonado%TYPE,
                            EN_NUM_DIAS     IN number,
                            SC_REG_SS       OUT NOCOPY      refcursor);

PROCEDURE GE_REC_PA_CLIE_PR(EN_COD_CLIENTE  IN ga_abocel.cod_cliente%TYPE,
                            EN_NUM_ABONADO  IN ga_abocel.num_abonado%TYPE,
                            EN_NUM_DIAS     IN number,
                            SC_REG_PA       OUT NOCOPY      refcursor);

PROCEDURE GE_INS_OVERRIDE_PR   (EN_COD_CLIENTE                IN    ge_cargos_sobrescritos_to.cod_cliente%type,
                                EN_NUM_ABONADO              IN  ge_cargos_sobrescritos_to.num_abonado%type,
                                EV_COD_ORIGEN_TRANSACCION   IN  ge_cargos_sobrescritos_to.cod_origen_transaccion%type,
                                EN_TIPO_SERVICIO            IN  ge_cargos_sobrescritos_to.tipo_servicio%type,
                                EN_COD_PROD_CONTRATADO      IN  ge_cargos_sobrescritos_to.cod_prod_contratado%type,
                                EN_COD_CARGO_CONTRATADO     IN  ge_cargos_sobrescritos_to.cod_cargo_contratado%type,
                                EV_COD_PLANTARIF            IN  ge_cargos_sobrescritos_to.cod_plantarif%type,
                                EV_COD_CARGOBASICO          IN  ge_cargos_sobrescritos_to.cod_cargobasico%type,
                                EV_COD_SERVICIO             IN  ge_cargos_sobrescritos_to.cod_servicio%type,
                                EN_IMPORTE_ORIGEN           IN  ge_cargos_sobrescritos_to.importe_origen%type,
                                EN_IMPORTE_SOBRESCRITO      IN  ge_cargos_sobrescritos_to.importe_sobrescrito%type,
                                EV_COD_MONEDA               IN  ge_cargos_sobrescritos_to.cod_moneda%type,
                                EN_COD_CONCEPTO             IN  ge_cargos_sobrescritos_to.cod_concepto%type,
                                EN_NUM_VENTA                IN  ge_cargos_sobrescritos_to.num_venta%type,
                                EV_NOM_USUARORA             IN  ge_cargos_sobrescritos_to.nom_usuarora%type,
                                SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                                SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                                SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento );

PROCEDURE GE_REC_OVERRIDE_PR(EN_NUM_VENTA              IN ga_abocel.num_venta%TYPE,
                             EV_COD_ORIGEN_TRANSACCION IN ge_cargos_sobrescritos_to.cod_origen_transaccion%TYPE,
                             SC_REG_CRG               OUT NOCOPY      refcursor,
                             SN_COD_RETORNO           OUT NOCOPY   ge_errores_pg.CodError,
                             SV_MENS_RETORNO          OUT NOCOPY   ge_errores_pg.MsgError,
                             SN_NUM_EVENTO            OUT NOCOPY   ge_errores_pg.evento);
END GE_OVERRIDE_PG;
/
SHOW ERRORS

