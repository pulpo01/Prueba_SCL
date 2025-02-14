CREATE OR REPLACE PACKAGE            NP_GESTOR_MAYORISTAS_PG
 IS
GN_mayorista   NUMBER(1)   :=1;
GN_indrecambio NUMBER(1)   :=9;
GN_tiplan_pos  TA_PLANTARIF.COD_TIPLAN%TYPE:='2';
GN_tiplan_hib  TA_PLANTARIF.COD_TIPLAN%TYPE:='3';
GV_monedalocal VARCHAR2(12):='MONEDA_LOCAL';
  CV_version                CONSTANT  VARCHAR2(5):='2.0';
  CV_error_no_clasif     CONSTANT  VARCHAR2(30):='Error no clasificado';
  TYPE refcursor               IS REF CURSOR;
  CV_cod_modulo                CONSTANT   ged_parametros.cod_modulo%TYPE:='AL';
  CN_largoquery                   CONSTANT   NUMBER:=3000;
  CN_largoerrtec               CONSTANT   NUMBER:=500;
  CN_largodesc                    CONSTANT   NUMBER:=1000;
  CV_rechazo                                        CONSTANT   VARCHAR2(7):='RECHAZO';
  CV_formato                   CONSTANT  VARCHAR2(25):= 'dd-mm-yyyy hh24:mi:ss';
  CV_dd_mm_yyyy                CONSTANT  VARCHAR2(25):= 'dd-mm-yyyy';
  CV_NU                        CONSTANT  VARCHAR2(2):= 'NU';
  CV_SP                        CONSTANT  VARCHAR2(2):= 'SP';
  CV_PE                        CONSTANT  VARCHAR2(2):= 'PE';
  CV_causa_renorepo            CONSTANT  VARCHAR2(2):= 'RM';
     CV_cero  NUMBER(1)   :=0;
  CV_uno  NUMBER(1)   :=1;


PROCEDURE NP_CLIENTE_MAYORISTA_PR
(EN_cliente         IN npt_pedido.cod_cliente%TYPE,
 SN_EstadoCliente   OUT     number,
 SC_Error           OUT     varchar2);

PROCEDURE NP_MONTO_DESSUGERIDO_PR
(EN_cliente          IN npt_pedido.cod_cliente%TYPE,
 EN_codArticulo      IN npt_detalle_pedido.cod_articulo%Type,
 EN_MontoDescuento   IN      number,
 EN_SecSerie         IN      number,
 EN_NumLinea         IN      number,
 SN_MontoSugerido    OUT     number,
 SN_CantidadSeries   OUT     number,
 SC_Error            OUT     varchar2
);

PROCEDURE NP_ALAMCENA_SERIE_PEDIDO_PR
(EN_CodPedido        IN npt_pedido.cod_pedido%TYPE,
 EN_cliente          IN npt_pedido.cod_cliente%TYPE,
 EN_SecSerie         IN      number,
 SC_Error            OUT     varchar2
);

PROCEDURE NP_ACTUALIZAESTADOSERIE_PR(
 ES_SERIE            IN NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%type,
 EN_ABONADO          IN GA_ABOCEL.NUM_ABONADO%type,
 EC_Error            OUT varchar2
);

PROCEDURE NP_ALAMCENASERIE_NUEVA_PR
(EN_CodPedido        IN npt_pedido.cod_pedido%TYPE,
 SC_Error            OUT     varchar2
);

PROCEDURE NP_ElIMINASERIE_BAJA_PR
(EN_CodPedido        IN npt_pedido.cod_pedido%TYPE,
 SC_Error            OUT NOCOPY     varchar2
);
PROCEDURE NP_LIMPIASERIEESTANCADA_PR;

FUNCTION NP_OBTENER_CONFIG_EVENTO_FN
(EV_cod_actabo                  IN                                 NP_CONFIG_EVENTO_TD.cod_actabo%TYPE,
 EV_estado_ini                  IN                                 NP_CONFIG_EVENTO_TD.estado_ini%TYPE,
 EV_cod_caucaser                IN                                 NP_CONFIG_EVENTO_TD.cod_caucaser%TYPE,
 SR_config_evento            OUT NOCOPY NP_CONFIG_EVENTO_TD%ROWTYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_CAMBIA_ESTADO_SERIE_FN
(ER_det_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO%ROWTYPE,
 EV_est_inicial     IN         NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_UPDATE_NPDETSERACTVTA_FN
(ER_det_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO%ROWTYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_INSERT_NPHISTMOVSERIES_FN
(ER_hist_serie                  IN                                 np_hist_movim_series_to%ROWTYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_MAIN_LIQ_MAYORISTAF2_PR
(   EN_num_abonado       IN                                 ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
    EV_cod_actabo       IN                                 ICC_MOVIMIENTO.cod_actabo%TYPE,
    EV_num_serie       IN                              ICC_MOVIMIENTO.num_serie%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_VALIDA_SERIESTEMP_PR(
    EV_cod_cliente        IN VARCHAR2,
    EV_cod_pedido        IN VARCHAR2,
    EV_fec_desde_serie     IN VARCHAR2,
    EV_fec_hasta_serie     IN VARCHAR2,
    EV_ind_nota_fact     IN VARCHAR2
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_EE_MAYORISTAS_PR(
   EN_num_extra       IN al_ser_es_extras.num_extra%TYPE
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_ESTADO_INICIAL_FN
(EN_cod_cliente                 IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_cliente%TYPE,
 EN_cod_pedido                  IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_pedido%TYPE,
 EV_num_serie                   IN                                 NP_DETSER_ACTVTA_MAYORISTAS_TO.num_serie%TYPE,
 SV_estado_ini            OUT    NOCOPY    NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_estado%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_CAUSA_CAMBIO_FN
(EN_num_abonado                 IN                                 GA_EQUIPABOSER.NUM_ABONADO%TYPE,
 EV_num_serie                            IN                                    GA_EQUIPABOSER.NUM_SERIE%TYPE,
    SV_causa_cambio                OUT    NOCOPY    GA_EQUIPABOSER.COD_CAUSA%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE NP_REGISTRAVALORSERIE_PR(
 ES_SERIE           IN  NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%type,
 EN_ABONADO         IN  GA_ABOCEL.NUM_ABONADO%type,
 EN_cod_cliente                 IN     NP_DETSER_ACTVTA_MAYORISTAS_TO.cod_cliente%TYPE,
    EV_cod_actabo         IN        ICC_MOVIMIENTO.cod_actabo%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_COSTO_MININO_FN
(EN_cod_articulo             IN                              AL_ARTICULOS.COD_ARTICULO%TYPE,
 SN_monto_min                   OUT    NOCOPY    np_detser_actvta_mayoristas_to.MTO_NETO_SCL%TYPE,
    SN_cod_retorno     OUT NOCOPY ge_errores_pg.CodError,
    SV_mens_retorno    OUT NOCOPY ge_errores_pg.MsgError,
    SN_num_evento      OUT NOCOPY ge_errores_pg.Evento
) RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--P-MIX-07005--
PROCEDURE NP_OBTPRECIO_PUBLICO_PR(
 EN_numtrans                                    IN                              ga_transacabo.num_transaccion%TYPE,
 ES_SERIE            IN         NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%type,
 EN_ABONADO          IN         GA_ABOCEL.NUM_ABONADO%type);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE al_mantenedor_preciosretail_pr (
          EN_cod_vendedor                 IN   al_precios_retail_td.cod_vendedor%TYPE,
                EN_cod_articulo           IN   al_precios_retail_td.cod_articulo%TYPE,
          EN_precio_articulo              IN   al_precios_retail_td.precio_articulo%TYPE,
          EV_fec_desde                             IN   VARCHAR2,
          EV_fec_hasta                             IN   VARCHAR2,
          EV_fec_desde_new                      IN   VARCHAR2,
          EV_fec_hasta_new                      IN   VARCHAR2,
                EV_usuario_crea        IN   al_precios_retail_td.usu_creacion%TYPE,
          EV_fec_crea                              IN   VARCHAR2,
                EV_usuario_mod         IN   al_precios_retail_td.usu_actualiza%TYPE,
          EV_ind_accion                                  IN   VARCHAR2,
                EV_formato                                                    IN   VARCHAR2,
             EN_cod_uso                                              IN   AL_PRECIOS_RETAIL_TD.COD_USO%TYPE,
                EN_cod_estado                                  IN   AL_PRECIOS_RETAIL_TD.COD_ESTADO%TYPE,
                EV_categoria                                      IN   AL_PRECIOS_RETAIL_TD.COD_CATEGORIA%TYPE,
                EN_num_meses                                      IN   AL_PRECIOS_RETAIL_TD.COD_USO%TYPE,
                EN_recambio                                          IN   AL_PRECIOS_RETAIL_TD.IND_RECAMBIO%TYPE
                );
------------------------------------------------------------------------------------------------------

FUNCTION NP_OBTENER_VALOR_FINAL_FN
(EN_mayorista      IN                             VARCHAR2,
 EN_FechaDesde      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.FEC_MOVIMIENTO%TYPE,
 EN_FechaHasta      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.FEC_MOVIMIENTO%TYPE,
 EN_serie          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
 EN_estado          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE,
 EN_financiado    IN                             VARCHAR2
) RETURN NUMBER;
------------------------------------------------------------------------------------------------------

PROCEDURE NP_OBTENER_DATOS_FINAL_PR
(EN_mayorista      IN                             VARCHAR2,
 EN_FechaDesde      IN                             VARCHAR2,
 EN_FechaHasta      IN                             VARCHAR2,
 EN_serie          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.NUM_SERIE%TYPE,
 EN_estado          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ESTADO%TYPE ,
 EN_financiado    IN                             VARCHAR2,
 SV_mens_retorno  OUT NOCOPY VARCHAR2,
 tSeries          OUT NOCOPY refcursor
) ;

------------------------------------------------------------------------------------------------------
FUNCTION NP_OBTENER_TOTAL_SERIESSP_FN
(EV_mayorista      IN                             VARCHAR2,
 EN_Articulo      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ARTICULO%TYPE,
 EV_Canal          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_VENDEDOR%TYPE,
 EV_FechaDesde      IN                             VARCHAR2,
 EV_FechaHasta      IN                             VARCHAR2
) RETURN NUMBER;

PROCEDURE NP_OBTENER_SERIESSP_PR
(EV_mayorista      IN                             VARCHAR2,
 EN_Articulo      IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_ARTICULO%TYPE,
 EV_Canal          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_VENDEDOR%TYPE,
 EV_FechaDesde      IN                             VARCHAR2,
 EV_FechaHasta      IN                             VARCHAR2,
 SV_mens_retorno  OUT NOCOPY VARCHAR2,
 tSeries          OUT NOCOPY refcursor
) ;


PROCEDURE NP_UPDATE_SERIESSP_PR
(EV_mayorista      IN                             VARCHAR2,
 EN_Articulo      IN                             VARCHAR2,
 EV_Canal          IN                             NP_DETSER_ACTVTA_MAYORISTAS_TO.COD_VENDEDOR%TYPE,
 EV_FechaDesde      IN                             VARCHAR2,
 EV_FechaHasta      IN                             VARCHAR2,
 EN_Uso           IN                             AL_PRECIOS_RETAIL_TD.COD_USO%TYPE,
 EN_estado          IN                             AL_PRECIOS_RETAIL_TD.COD_ESTADO%TYPE,
 EV_Categoria     IN                             AL_PRECIOS_RETAIL_TD.COD_CATEGORIA%TYPE,
 EN_Meses          IN                             AL_PRECIOS_RETAIL_TD.NUM_MESES%TYPE,
 EV_Ventas        IN                             VARCHAR2
) ;
------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_VENDEDOR_FN(EN_Cod_Vendedor     IN          ve_vendedores.Cod_Vendedor%TYPE)
RETURN BOOLEAN;
-----------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_ARTICULO_FN(EN_Cod_Articulo     IN          al_articulos.Cod_Articulo%TYPE)
RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_USO_FN (EN_cod_uso IN al_usos.cod_uso%type)
RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_CATEGORIA_FN (EV_cod_categoria IN ve_categorias.cod_categoria%type)
RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_MESES_FN (EN_num_meses IN Ga_percontrato.num_meses%type)
RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------
FUNCTION AL_VALIDA_ESTADO_FN (EN_cod_estado IN al_estados.cod_estado%type)
RETURN BOOLEAN;
------------------------------------------------------------------------------------------------------
PROCEDURE AL_VALIDA_PRECIOS_MASIVO_PR
(EN_numproc    IN AL_PRECIOS_RETAIL_TT.num_proceso%TYPE,
EV_flagvalpre  IN VARCHAR2
);
------------------------------------------------------------------------------------------------------
PROCEDURE AL_INSERTA_PRECMASIVO_PR (EN_numproc AL_PRECIOS_RETAIL_TT.num_proceso%TYPE);
------------------------------------------------------------------------------------------------------

END NP_GESTOR_MAYORISTAS_PG;
/
SHOW ERRORS
