CREATE OR REPLACE PACKAGE FA_Servicios_Facturacion_PG IS   

        -- Nombre del package
        CV_NOMBRE_PACKAGE     CONSTANT VARCHAR2(27) := 'FA_Servicios_Facturacion_PG';
        TYPE refcursor    IS REF CURSOR;
        CV_MODULO_GA         CONSTANT VARCHAR2(2)  := 'GA';
        CV_MODULO_GE         CONSTANT VARCHAR2(2)  := 'GE';
        CV_MODULO_FA         CONSTANT VARCHAR2(2)  := 'FA';
        CV_error_no_clasif   CONSTANT VARCHAR2(30) := 'Error no clasificado';
        CN_LARGOERRTEC       CONSTANT NUMBER        := 4000;
        CN_LARGODESC         CONSTANT NUMBER        := 2000;
        CN_CODCONIMPIEPS     CONSTANT NUMBER        := 102; -- CODIGO DE CONCEPTO IMPUESTO IEPS,
        -- para busqueda de los ciclos
        CV_TAB_FACICLOS  CONSTANT VARCHAR2(9) := 'FA_CICLOS';
        CV_COL_FACICLOS  CONSTANT VARCHAR2(9) := 'COD_CICLO';

    PROCEDURE FA_con_presupuesto_PR(EN_num_proceso   IN  fa_presupuesto.num_proceso%TYPE,
                                                SC_cursordatos   OUT NOCOPY refcursor,
                                                                    SN_cod_retorno   OUT NOCOPY ge_errores_pg.CodError,
                                            SV_mens_retorno  OUT NOCOPY ge_errores_pg.MsgError,
                                            SN_num_evento    OUT NOCOPY ge_errores_pg.Evento);

    PROCEDURE FA_det_concepto_presup_PR(EN_num_proceso    IN  fa_presupuesto.num_proceso%TYPE,
                                            EN_cod_concepto   IN  fa_presupuesto.cod_concepto%TYPE,
                                                                            SC_cursordatos    OUT NOCOPY refcursor,
                                                    SN_cod_retorno    OUT NOCOPY ge_errores_pg.CodError,
                                                SV_mens_retorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_num_evento     OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE FA_getCodigoDespacho_PR(SV_codDespacho OUT NOCOPY fa_codespacho.cod_despacho%TYPE,
                                                                      SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                              SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                              SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE FA_getCicloFacturacion_PR(EV_cod_ciclo        OUT NOCOPY VARCHAR2,
                                                EV_ano              OUT NOCOPY VARCHAR2,
                                                                                EV_cod_ciclfact     OUT NOCOPY VARCHAR2,
                                                                                EV_fec_vencimie     OUT NOCOPY VARCHAR2,
                                                                                EV_fec_emision      OUT NOCOPY VARCHAR2,
                                                                                EV_fec_caducida     OUT NOCOPY VARCHAR2,
                                                                                EV_fec_proxvenc     OUT NOCOPY VARCHAR2,
                                                                        EV_fec_desdellam    OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastallam    OUT NOCOPY VARCHAR2,
                                                                                EV_dia_periodo      OUT NOCOPY VARCHAR2,
                                                                                EV_fec_desdecfijos  OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastacfijos  OUT NOCOPY VARCHAR2,
                                                                        EV_fec_desdeocargos OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastaocargos OUT NOCOPY VARCHAR2,
                                                                                EV_fec_desderoa         OUT NOCOPY VARCHAR2,
                                                                                EV_fec_hastaroa         OUT NOCOPY VARCHAR2,
                                                                                EV_ind_facturacion      OUT NOCOPY VARCHAR2,
                                                                        EV_dir_logs             OUT NOCOPY VARCHAR2,
                                                                                EV_dir_spool            OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen1           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen2           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen3           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen4           OUT NOCOPY VARCHAR2,
                                                                                EV_des_leyen5           OUT NOCOPY VARCHAR2,
                                                                                EV_ind_tasador          OUT NOCOPY VARCHAR2,
                                                                        SN_codRetorno           OUT NOCOPY ge_errores_pg.CodError,
                                                SV_menRetorno           OUT NOCOPY ge_errores_pg.MsgError,
                                                SN_numEvento            OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE FA_getListCiclosPostPago_PR(EN_CicloPrepago IN  fa_ciclos.cod_ciclo%TYPE,
                                              SC_cursorDatos  OUT NOCOPY REFCURSOR,
                                                                          SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                                  SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                                  SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE FA_getDiasProrrateo_PR(EV_codCiclo      IN  VARCHAR2,
                                         EV_formatoFecha  IN  VARCHAR2,
                                                                         SV_diasProrrateo OUT NOCOPY VARCHAR2,
                                                                         SV_cantDias      OUT NOCOPY VARCHAR2,
                                                                     SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                             SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                             SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);

        PROCEDURE FA_getImpuesto_PR(EV_codCliente IN VARCHAR2,
                                    EV_codOficina IN VARCHAR2,
                                    EN_importe    IN NUMBER,
                                    EN_codConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                    SN_imptotal   OUT NOCOPY NUMBER,
                                    SN_codRetorno OUT NOCOPY ge_errores_pg.CodError,
                                    SV_menRetorno OUT NOCOPY ge_errores_pg.MsgError,
                                    SN_numEvento  OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE FA_getFolios_PR(EV_codCliente  IN         GE_CLIENTES.COD_CLIENTE%TYPE,
                          EV_codOficina  IN         GE_OFICINAS.COD_OFICINA%TYPE,
                          SN_CodTipDocum OUT NOCOPY GE_TIPDOCUMEN.COD_TIPDOCUM%TYPE,
                          SV_DesTipDocum OUT NOCOPY GE_TIPDOCUMEN.DES_TIPDOCUM%TYPE,
                          SV_FOLIO       OUT NOCOPY VARCHAR2,   
                          SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                          SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                          SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);
 PROCEDURE FA_getProrrateo_PR(EV_numAbonado  IN         GA_ABOCEL.NUM_ABONADO%TYPE,
                              EV_IMPORTE     IN         NUMBER,
                              SN_IMPORTE     OUT NOCOPY NUMBER, 
                              SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento   OUT NOCOPY ge_errores_pg.Evento); 
  PROCEDURE FA_getProrrateoPA_PR(
                              EV_numAbonado  IN         GA_ABOCEL.NUM_ABONADO%TYPE,
                              EN_CARGO       IN         PF_CARGOS_PRODUCTOS_TD.COD_CARGO%TYPE,
                              SN_IMPORTE     OUT NOCOPY NUMBER, 
                              SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                              SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                              SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);                              
 FUNCTION FA_getImpuesto_FN (EN_codCliente IN GE_CLIENTES.COD_CLIENTE%TYPE,
                             EV_codOficina IN GE_OFICINAS.COD_OFICINA%TYPE, 
                             EN_IMPORTE IN NUMBER,
                             EN_CodConcepto IN FA_CONCEPTOS.COD_CONCEPTO%TYPE
                             ) RETURN NUMBER;
 
 PROCEDURE FA_ConsultaCobroAdelantado_PR(EN_numAbonado   IN       GA_ABOCEL.NUM_ABONADO%TYPE,
                                         EN_CodCiclfact  IN         FA_CICLFACT.COD_CICLFACT%TYPE,   
                                         EN_codConcepto  IN         FA_CONCEPTOS.COD_CONCEPTO%TYPE, 
                                         EN_EnvioH       IN         NUMBER, 
                                         SN_CantAbonados OUT NOCOPY NUMBER, 
                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento    OUT NOCOPY ge_errores_pg.Evento);   
 
 PROCEDURE FA_ConsultaCobroAdelantadoH_PR(EV_codCliente  IN         GA_ABOCEL.COD_CLIENTE%TYPE,
                                          EN_numVenta    IN         GA_VENTAS.NUM_VENTA%TYPE,
                                          EN_CodCiclfact IN         FA_CICLFACT.COD_CICLFACT%TYPE,   
                                          EN_codConcepto IN         FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                          SC_cursorDatos  OUT NOCOPY REFCURSOR, 
                                          SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                          SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                          SN_numEvento   OUT NOCOPY ge_errores_pg.Evento); 
  
  PROCEDURE FA_InsertaCobroAdelantadoUs_PR(EV_codCliente   IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EN_NumAbonado   IN  GA_ABOCEL.NUM_ABONADO%TYPE,  
                                         EN_numVenta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                         EN_CodCiclfact  IN  FA_CICLFACT.COD_CICLFACT%TYPE,   
                                         EN_codConcepto  IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                         EN_numProceso   IN  GA_COBROS_ADELANTADOS_TO.NUM_PROCESO%TYPE,
                                         EN_TipoConcepto IN  GA_COBROS_ADELANTADOS_TO.TIPO_SERVICIO%TYPE,
                                         EV_usuario      IN  GA_COBROS_ADELANTADOS_TO.NOM_USUARIO%TYPE,                                         
                                         SN_NumCobro    OUT NOCOPY GA_COBROS_ADELANTADOS_TO.NUM_COBRO%TYPE,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);
                                         
  PROCEDURE FA_InsertaCobroAdelantado_PR(EV_codCliente   IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EN_NumAbonado   IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                         EN_numVenta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                         EN_CodCiclfact  IN  FA_CICLFACT.COD_CICLFACT%TYPE,
                                         EN_codConcepto  IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                         EN_numProceso   IN  GA_COBROS_ADELANTADOS_TO.NUM_PROCESO%TYPE,
                                         EN_TipoConcepto IN  GA_COBROS_ADELANTADOS_TO.TIPO_SERVICIO%TYPE,
                                         SN_NumCobro    OUT NOCOPY GA_COBROS_ADELANTADOS_TO.NUM_COBRO%TYPE,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento);                                         
 
PROCEDURE FA_InsertaCobroAdelantadoH_PR (EV_codCliente   IN  GA_ABOCEL.COD_CLIENTE%TYPE,
                                         EN_numCobro     IN GA_COBROS_ADELANTADOS_TO.NUM_COBRO%TYPE, 
                                         EN_fec_alta     IN GA_COBROS_ADELANTADOS_TO.FEC_COBRO%TYPE,
                                         EN_NumAbonado   IN  GA_ABOCEL.NUM_ABONADO%TYPE,  
                                         EN_numVenta     IN  GA_VENTAS.NUM_VENTA%TYPE,
                                         EN_CodCiclfact  IN  FA_CICLFACT.COD_CICLFACT%TYPE,   
                                         EN_codConcepto  IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                         EN_numProceso   IN  GA_COBROS_ADELANTADOS_TO.NUM_PROCESO%TYPE,
                                         EN_TipoConcepto IN  GA_COBROS_ADELANTADOS_TO.TIPO_SERVICIO%TYPE,
                                         SN_codRetorno  OUT NOCOPY ge_errores_pg.CodError,
                                         SV_menRetorno  OUT NOCOPY ge_errores_pg.MsgError,
                                         SN_numEvento   OUT NOCOPY ge_errores_pg.Evento); 
                                         
PROCEDURE FA_ActualizaInfaccel_PR         (EN_NumAbonado  IN  GA_ABOCEL.NUM_ABONADO%TYPE,
                                           EN_codCliente  IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                           EN_codCiclfact IN  FA_CICLFACT.COD_CICLFACT%TYPE, 
                                           SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);
PROCEDURE FA_ActualizaIndFact_PR           (EN_NumVenta      IN  GA_ABOCEL.NUM_VENTA%TYPE,
                                           SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);  
PROCEDURE FA_obtieneConcepto_PR           (EN_codConcepto   IN  FA_CONCEPTOS.COD_CONCEPTO%TYPE,
                                           SV_DES_CONCEPTO  OUT NOCOPY  FA_CONCEPTOS.DES_CONCEPTO%TYPE,
                                           SN_COD_TIPCONCE  OUT NOCOPY FA_CONCEPTOS.COD_TIPCONCE%TYPE,
                                           SV_COD_MONEDA    OUT NOCOPY FA_CONCEPTOS.COD_MONEDA%TYPE, 
                                           SN_codRetorno    OUT NOCOPY ge_errores_pg.CodError,
                                           SV_menRetorno    OUT NOCOPY ge_errores_pg.MsgError,
                                           SN_numEvento     OUT NOCOPY ge_errores_pg.Evento);                                                                                                                                                                                                                                                                                                              
                                                       
END FA_Servicios_Facturacion_PG;
/
SHOW ERRORS