CREATE OR REPLACE PACKAGE PV_BOLSAS_DINAMICAS_PG IS

CN_cod_producto                      CONSTANT NUMBER(1)  := 1;
CV_tipplanemp                                            CONSTANT VARCHAR2(1) := 'E';
CN_flg_planblsdnmc                                       CONSTANT NUMBER(1)  := 1;
CN_cod_ret_no_found                                      CONSTANT NUMBER(4)  := 1162;

CN_valcarbas_existe                                      CONSTANT NUMBER(1)  := 1;

CN_NO_ATLNTD                                             CONSTANT NUMBER(1)  := 0;--no atlantatida

CN_codos_camcarbas                                       CONSTANT NUMBER(5)  := 10039;--Codigo orden de servicio cambio de cargo basico --

CV_MSGERR_BLSDIN_CNSLT1                          CONSTANT VARCHAR2(55)  := 'Error al obtener valor cargo básico periodo actual: ';
CV_MSGERR_BLSDIN_CNSLT2                          CONSTANT VARCHAR2(60)  := 'Error al obtener valor cargo básico periodo siguiente: ';
CV_MSGERR_BLSDIN_UPVIG1                          CONSTANT VARCHAR2(50)  := 'Error al cerrar vigencia del periodo actual: ';
CV_MSGERR_BLSDIN_UPVIG2                          CONSTANT VARCHAR2(50)  := 'Error al extender vigencia del periodo actual: ';
CV_MSGERR_BLSDIN_INVIG2                          CONSTANT VARCHAR2(55)  := 'Error al abrir nuevo registro con periodo siguiente : ';
CV_MSGERR_BLSDIN_DELVIG2                         CONSTANT VARCHAR2(55)  := 'Error al borrar registro con periodo siguiente : ';
CV_MSGERR_BLSDIN_EXISTE                          CONSTANT VARCHAR2(50)  := 'El valor cargo básico ingresado ya existe : ';


PROCEDURE PV_RSTRCN_PLANBLSDNMCA_PR(
          EV_param_entrada IN  VARCHAR2,
          SV_RESULTADO      OUT VARCHAR2,
                  SV_MENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
);

PROCEDURE PV_RSTRCN_CAMPLAN_PNDNTE_PR(
          EV_param_entrada IN  VARCHAR2,
          SV_RESULTADO     OUT VARCHAR2,
                  SV_MENSAJE       OUT GA_TRANSACABO.DES_CADENA%TYPE
);

PROCEDURE PV_ACTLZ_BLSDNMC_CAMCARBAS_PR(
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_cargobasico       IN ta_plantarif.cod_cargobasico%TYPE,
                  EV_cod_plantarif                 IN ta_plantarif.cod_plantarif%TYPE,
                  EN_imp_cargo_basico      IN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE,
                  EN_imp_final                     IN ta_rango_planes_td.imp_final%TYPE,
                  SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                  SN_num_evento            OUT NOCOPY ge_errores_pg.evento,
                  SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE

);

PROCEDURE PV_ACTLZ_BLSDNMC_CAMPLAN_PR(
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif1                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_plantarif2                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_cargobasico2      IN ta_plantarif.cod_cargobasico%TYPE,
                  EN_imp_cargo_basico      IN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE,
                  EN_imp_final                     IN ta_rango_planes_td.imp_final%TYPE,
                  SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                  SN_num_evento            OUT NOCOPY ge_errores_pg.evento,
                  SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE

);

PROCEDURE PV_ODBC_ACTLZBLSDNMCCAMPLAN_PR(
                  EN_num_transaccion       IN ga_transacabo.num_transaccion%TYPE,
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif1                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_plantarif2                IN ta_plantarif.cod_plantarif%TYPE,
                  EV_cod_cargobasico2      IN ta_plantarif.cod_cargobasico%TYPE,
                  EN_imp_cargo_basico      IN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE,
                  EN_imp_final                     IN ta_rango_planes_td.imp_final%TYPE
);


PROCEDURE PV_ANULCN_BLSDNMC_CAMPLAN_PR(
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif                 IN ta_plantarif.cod_plantarif%TYPE,
                  SN_cod_retorno           OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                  SN_num_evento            OUT NOCOPY ge_errores_pg.evento,
                  SV_mens_retorno          OUT NOCOPY ge_errores_td.det_msgerror%TYPE

);

PROCEDURE PV_ODBC_ANULCBLSDNMCCAMPLAN_PR(
                  EN_num_transaccion       IN ga_transacabo.num_transaccion%TYPE,
                  EN_cod_cliente           IN ge_clientes.cod_cliente%TYPE,
                  EN_cod_ciclo                     IN fa_ciclfact.cod_ciclo%TYPE,
                  EV_cod_plantarif                 IN ta_plantarif.cod_plantarif%TYPE
);

FUNCTION PV_obtener_fecha_maxima_FN RETURN DATE;

PROCEDURE PV_INSCOS_CAMCARBASATLACICL_PR(
                                                                                   EN_cod_cliente         IN                       ga_abocel.cod_cliente%TYPE,
                                                                                   EV_cod_os              IN                       pv_iorserv.cod_os%TYPE,
                                                                                   EV_usuario             IN                       pv_iorserv.usuario%TYPE,
                                                                                   EV_bdatos              IN                       pv_camcom.bdatos%TYPE,
                                                                                   EV_cod_plantarif   IN                           ta_plantarif.cod_plantarif%TYPE,
                                                                                   EN_cod_ciclo       IN               ge_clientes.cod_ciclo%TYPE,
                                                                                   EV_modulo              IN                       VARCHAR2,
                                                                                   EN_numtar              IN                       VARCHAR2,
                                                                                   EV_cod_actabo          IN                       ga_actabo.cod_actabo%TYPE,
                                                                                   SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                                                                   SN_num_evento           OUT NOCOPY ge_errores_pg.evento,
                                                                                   SV_mens_retorno         OUT NOCOPY ge_errores_td.det_msgerror%TYPE

);

FUNCTION PV_CNSLTA_CARBASICOCLTE_FN(
                                                                                   EN_cod_cliente  IN                      ga_abocel.cod_cliente%TYPE,
                                                                                   ED_fecha                IN                      DATE
) RETURN fa_dctos_serv_rec_td.imp_cargo_basico%TYPE ;

PROCEDURE PV_ANULAR_SOLICOS_ATLTD_PR(EN_cod_cliente             IN ga_abocel.cod_cliente%TYPE,
                                                                        ED_fec_anul                     IN DATE,
                                                                        EV_cod_os                       IN pv_iorserv.cod_os%TYPE,
                                                                        SN_cod_retorno          OUT NOCOPY ge_errores_td.cod_msgerror%TYPE);

END PV_BOLSAS_DINAMICAS_PG;
/
SHOW ERRORS
