CREATE OR REPLACE PACKAGE PV_GEST_LIM_CON_CONSULTAS_PG
IS

TYPE REFCURSOR          IS REF CURSOR;
ERROR_VALIDACION        EXCEPTION;
ERROR_GENERAL           EXCEPTION;
GV_PACKAGE              CONSTANT VARCHAR2(30)                   := 'PV_GEST_LIM_CON_CONSULTAS_PG';
GV_ERROR_OTHERS         CONSTANT NUMBER                         := '156';
GV_ERROR_NO_CLASIF      CONSTANT VARCHAR2(100)                  := 'Error no Clasificado';
GN_LARGOERRTEC          CONSTANT NUMBER(3)                      := 500;
GN_LARGODESC            CONSTANT NUMBER(3)                      := 100;
GV_COD_MODULO           CONSTANT VARCHAR2(2)                    := 'GA';
GN_COD_PRODUCTO         CONSTANT NUMBER                         := 1;


PROCEDURE PV_GET_DATOS_ABONADO_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SC_DATOS_ABONADO      OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_SINIESTRO_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SC_DATOS_SINIESTRO    OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTENER_PARAMETRO_PR(
                                    EV_NOM_PARAMETRO      IN GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                                    EV_COD_MODULO         IN GED_PARAMETROS.COD_MODULO%TYPE,
                                    EN_COD_PRODUCTO       IN GED_PARAMETROS.COD_PRODUCTO%TYPE,
                                    SV_VAL_PARAMETRO      OUT GED_PARAMETROS.VAL_PARAMETRO%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_LIMITE_CONSUMO_PR(
                                    EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SC_DATOS_LIM_CONSUMO    OUT REFCURSOR,
                                    SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO          OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO            OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_LIMCONSUMO_PR(
                                    EN_COD_CLIENTE       IN GE_CLIENTES.COD_CLIENTE%TYPE,
                                    EN_NUM_ABONADO       IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SC_DATOS_LIMCONSUMO  OUT REFCURSOR,
                                    SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LIM_CON_UTILIZADO_PR(
                                    EN_COD_CLIENTE        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EV_COD_UMBRAL_MIN     IN TOL_LIMITE_TD.COD_UMBRAL_MIN%TYPE, 
                                    EN_COD_CICLO          IN GA_ABOCEL.COD_CICLO%TYPE,
                                    SN_NIV_CONSUMO        OUT TOL_ACUMULA_TO.NIV_CONSUMO%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_GET_DESC_GRUPO_TECNO_PR(
                                    EV_COD_TECNOLOGIA     IN GA_ABOCEL.COD_TECNOLOGIA%TYPE,
                                    SV_DES_GRUPO          OUT AL_GRUPO_TECNOLOGIA_TD.DES_GRUPO%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DESC_SITUACION_PR(
                                EV_COD_SITUACION      IN GA_ABOCEL.COD_SITUACION%TYPE,
                                SV_DES_SITUACION      OUT GA_SITUABO.DES_SITUACION%TYPE,
                                SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_GET_SEQ_NEXTVAL_PR(
                                EV_SEQUENCE           IN VARCHAR2,
                                SV_NEXTVAL            OUT VARCHAR2,
                                SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_SEGMENTACION_PR(
                                    COD_CLIENTE          IN  GE_CLIENTES.COD_CLIENTE%TYPE,
                                    SC_DATOS_SEG_CLIE    OUT REFCURSOR,
                                    SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_PLANTARIF_PR(
                                    EN_COD_PLANTARIF          IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                    SC_DATOS_PLANTARIF   OUT REFCURSOR,
                                    SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_USUARIO_PR(
                                    EV_NOM_USUARIO        IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                    SC_DATOS_USUARIO      OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_GET_MONTO_MAXLC_PR(
                                EN_COD_CLIENTE        IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                SN_MONTO              OUT NUMBER,
                                SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_SINIESTRO_PR(
                                    EN_NUM_SINIESTRO        IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
                                    SC_SINIESTRO            OUT REFCURSOR,
                                    SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTENER_LIM_PENDIEN_PR(
                                    EN_COD_CLIENTE            IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                    EN_NUM_ABONADO            IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SN_CONTAR_LIM              OUT NUMBER,
                                    SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO            OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO              OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_COD_CARGOBASICOS_PR(
                                    EN_NUM_ABONADO            IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EN_COD_CLIENTE            IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                    EV_COD_CAUSA_SINIE      IN GA_SINIESTROS.COD_CAUSA%TYPE,
                                    SV_CARGO_CAUSINIE        OUT GA_CAUSINIE.COD_CARGOBASICO%TYPE,
                                    SV_CARGO_ORIG              OUT GA_INTARCEL.COD_CARGOBASICO%TYPE,
                                    SV_CARGO_ANT             OUT GA_INTARCEL.COD_CARGOBASICO%TYPE,
                                    SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO            OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO              OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_FECHA_ACTUAL_PR(
                                    EV_FORMATO_FECHA          IN VARCHAR2,
                                    SV_FECHA_ACTUAL           OUT VARCHAR2,
                                    SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO            OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO              OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DIAS_DIFERENCIA_PR(
                                    EV_FECHA                  IN VARCHAR2,
                                    SN_DIAS_DIFERENCIA        OUT NUMBER,
                                    SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO            OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO              OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTENER_SOL_PEND_CICLO_PR(
                                    EN_COD_CLIENTE            IN GA_FINCICLO.COD_CLIENTE%TYPE,
                                    SN_PENDIEN_CICLO          OUT NUMBER,
                                    SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO            OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO              OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_CONTRATOS_PR(
                                    EV_NOM_USUARIO        IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                    EV_COD_PROGRAMA       IN GE_SEG_PERFILES.COD_PROGRAMA%TYPE,
                                    EV_EQPRESTADO         IN GA_ABOCEL.IND_EQPRESTADO%TYPE,
                                    SC_LISTA_CONTRATOS    OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_PRODUCTO_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    EV_TIP_TERMINAL       IN GA_EQUIPABOSER.TIP_TERMINAL%TYPE,
                                    SC_DATOS_PRODUCTO     OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_CONTRATO_PR(
                                    EV_COD_TIPCONTRATO    IN GA_ABOCEL.COD_TIPCONTRATO%TYPE,
                                    SC_DATOS_CONTRATO     OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_MODALIDAD_PR(
                                    EV_NOM_USUARIO        IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                                    EV_PROGRAMA           IN GE_SEG_PERFILES.COD_PROGRAMA%TYPE,
                                    EV_COD_TIP_COMIS      IN VE_VENDEDORES.COD_TIPCOMIS%TYPE,
                                    EV_COD_TIPCONTRATO    IN GA_TIPCONTRATO.COD_TIPCONTRATO%TYPE,
                                    EN_NUM_MESES          IN GA_TIPCONTRATO.MESES_MINIMO%TYPE,
                                    EV_COD_PLANTARIF      IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                    SC_LISTA_MODALIDAD    OUT REFCURSOR,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_PRORROGAS_PR(
                                    SC_LISTA_PRORROGAS     OUT REFCURSOR,
                                    SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_BODEGAS_PR(
                                    EN_COD_VENDEDOR        IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                    EV_COD_OPERADORA       IN GE_OPERADORA_SCL.COD_OPERADORA_SCL%TYPE,
                                    SC_LISTA_BODEGAS       OUT REFCURSOR,
                                    SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_USOS_PR(
                                    SC_LISTA_USOS          OUT REFCURSOR,
                                    SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_ESTADOS_PR(
                                    SC_LISTA_ESTADOS          OUT REFCURSOR,
                                    SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_ARTICULOS_PR(
                                    EV_TIP_TERMINAL        IN AL_ARTICULOS.TIP_TERMINAL%TYPE,
                                    EV_COD_TECNOLOGIA      IN AL_TECNOARTICULO_TD.COD_TECNOLOGIA%TYPE,
                                    SC_LISTA_ARTICULOS     OUT REFCURSOR,
                                    SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_LISTA_CAT_TRIBUT_PR(
                                     EN_COD_CLIENTE                  IN GA_CATRIBUTCLIE.COD_CLIENTE%TYPE,
                                     SC_LISTA_CATTRIBUT             OUT NOCOPY REFCURSOR,
                                     SN_COD_RETORNO                  OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                     SV_MENS_RETORNO                 OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                     SN_NUM_EVENTO                   OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_SERIES_DISP_PR(
                                 EN_COD_MODVENTA        IN AL_PRECIOS_VENTA.COD_MODVENTA%TYPE,
                                 EV_COD_CATEGORIA       IN AL_PRECIOS_VENTA.COD_CATEGORIA%TYPE,
                                 EN_IND_CAUSA           IN GAT_OPCIONES_EQUIPOS.IND_CAUSA%TYPE,
                                 EV_COD_OPERACION       IN GAT_OPCIONES_EQUIPOS.COD_OPERACION%TYPE,
                                 EN_NUM_MESES           IN GAT_OPCIONES_EQUIPOS.NUM_MESES%TYPE,
                                 EV_COD_TIPCONTRATO     IN GAT_OPCIONES_EQUIPOS.COD_TIPCONTRATO%TYPE,
                                 EV_TIP_TERMINAL        IN AL_ARTICULOS.TIP_TERMINAL%TYPE,
                                 EN_COD_ESTADO          IN AL_TIPOS_STOCK.COD_ESTADO%TYPE,
                                 EN_COD_ARTICULO        IN AL_ARTICULOS.COD_ARTICULO%TYPE,
                                 EN_COD_BODEGA          IN AL_SERIES.COD_BODEGA%TYPE,
                                 EN_COD_USO             IN AL_SERIES.COD_USO%TYPE,
                                 EN_CANT_ROWS           IN NUMBER,
                                 SC_SERIES_DISP         OUT NOCOPY REFCURSOR,
                                 SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                 SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                 SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_PLAN_PR(  EV_COD_PLANTARIF       IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                 SC_PLAN_TARIF          OUT NOCOPY REFCURSOR,
                                 SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                 SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                 SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INS_MODABOCEL_PR(   EN_NUM_ABONADO         IN GA_MODABOCEL.NUM_ABONADO%TYPE,
                                 EV_COD_OPERACION       IN GA_MODABOCEL.COD_TIPMODI%TYPE,
                                 EV_NOM_USUARIO         IN GA_MODABOCEL.NOM_USUARORA%TYPE,
                                 EV_TIP_TERMINAL        IN GA_MODABOCEL.TIP_TERMINAL%TYPE,
                                 EV_NUM_SERIE           IN GA_MODABOCEL.NUM_SERIE%TYPE,
                                 EV_COD_CAUCAMBIO       IN GA_MODABOCEL.COD_CAUSA%TYPE,
                                 EN_IND_EQPRESTADO      IN GA_MODABOCEL.IND_EQPRESTADO%TYPE,
                                 EV_COD_TIPCONTRATO     IN GA_MODABOCEL.COD_TIPCONTRATO%TYPE,
                                 EN_NUM_MESES           IN GA_MODABOCEL.NUM_MESES%TYPE,
                                 SN_COD_RETORNO         OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                 SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                 SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INS_EQUIPABOSER_EQUI_PR(    
                                        EN_COD_BODEGA           IN GA_EQUIPABOSER.COD_BODEGA%TYPE,
                                        EV_NUM_SERIEMEC         IN GA_EQUIPABOSER.NUM_SERIEMEC%TYPE,
                                        EN_COD_ESTADO           IN GA_EQUIPABOSER.COD_ESTADO%TYPE,
                                        EN_NUM_MOVIMIENTO       IN GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE,
                                        EB_HAYCARGOART          IN VARCHAR2,
                                        EN_NUM_ABONADO          IN GA_EQUIPABOSER.NUM_ABONADO%TYPE,
                                        EV_NUM_SERIE            IN GA_EQUIPABOSER.NUM_SERIE%TYPE,
                                        EN_TIP_STOCK            IN GA_EQUIPABOSER.TIP_STOCK%TYPE,
                                        EN_COD_ARTICULO         IN GA_EQUIPABOSER.COD_ARTICULO%TYPE,
                                        EV_IND_PROCEQUI         IN GA_EQUIPABOSER.IND_PROCEQUI%TYPE,
                                        EB_PLISTA               IN VARCHAR2,
                                        EV_IND_PROPIEDAD        IN GA_EQUIPABOSER.IND_PROPIEDAD%TYPE,                                       
                                        EV_TIP_TERMINAL         IN GA_EQUIPABOSER.TIP_TERMINAL%TYPE,
                                        EV_DES_EQUIPO           IN GA_EQUIPABOSER.DES_EQUIPO%TYPE,
                                        EN_COD_USO              IN GA_EQUIPABOSER.COD_USO%TYPE,
                                        EN_IND_COMODATO         IN NUMBER,
                                        EV_COD_TECNOLOGIA       IN GA_EQUIPABOSER.COD_TECNOLOGIA%TYPE,
                                        EN_IMPORTE              IN GA_EQUIPABOSER.PRC_VENTA%TYPE,
                                        EN_TIPDTO               IN GA_EQUIPABOSER.TIP_DTO%TYPE,
                                        EN_VALDTO               IN GA_EQUIPABOSER.VAL_DTO%TYPE,
                                        EN_COD_MODVENTA         IN GA_EQUIPABOSER.COD_MODVENTA%TYPE,
                                        EN_COD_CUOTA            IN GA_EQUIPABOSER.COD_CUOTA%TYPE,
                                        EV_COD_CAUSA            IN GA_EQUIPABOSER.COD_CAUSA%TYPE,
                                        SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INS_GA_RESERVART_PR (EN_CODARTICULO       IN GA_RESERVART.COD_ARTICULO%TYPE,
                                     EN_CODBODEGA       IN GA_RESERVART.COD_BODEGA%TYPE,
                                     EN_CODSTOCK           IN GA_RESERVART.TIP_STOCK %TYPE,
                                     EN_CODUSOLINEA      IN GA_RESERVART.COD_USO%TYPE,
                                     EN_CODESTADO           IN GA_RESERVART.COD_ESTADO%TYPE,
                                     EV_USER             IN GA_RESERVART.NOM_USUARIO%TYPE,
                                     EV_NUMSERIE         IN GA_RESERVART.NUM_SERIE%TYPE,
                                     SN_NUM_TRANSACCION     OUT NOCOPY GA_RESERVART.NUM_TRANSACCION%TYPE,
                                     SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                      SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                      SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

PROCEDURE PV_GET_DATOS_SERIE_PR (
                               EN_CODUSO            IN AL_SERIES.COD_USO%TYPE,
                             EV_TIPTERMINAL       IN AL_ARTICULOS.TIP_TERMINAL%TYPE,
                             EV_NUMSERIE          IN AL_SERIES.NUM_SERIE%TYPE,
                             SV_DES_STOCK         OUT NOCOPY AL_TIPOS_STOCK.DES_STOCK%TYPE,
                             SV_NUM_SERIE         OUT NOCOPY AL_SERIES.NUM_SERIE%TYPE,
                             SV_NUM_SERIEMEC      OUT NOCOPY AL_SERIES.NUM_SERIEMEC%TYPE,
                             SN_TIP_STOCK            OUT NOCOPY AL_TIPOS_STOCK.TIP_STOCK%TYPE,
                             SN_IND_VALORAR       OUT NOCOPY AL_TIPOS_STOCK.IND_VALORAR%TYPE,
                             SN_COD_ESTADO         OUT NOCOPY AL_SERIES.COD_ESTADO%TYPE,
                             SN_NUM_TELEFONO       OUT NOCOPY AL_SERIES.NUM_TELEFONO%TYPE,
                             SN_COD_BODEGA           OUT NOCOPY AL_SERIES.COD_BODEGA%TYPE,
                             SN_COD_ARTICULO       OUT NOCOPY AL_ARTICULOS.COD_ARTICULO%TYPE,
                             SV_DES_ARTICULO       OUT NOCOPY AL_ARTICULOS.DES_ARTICULO%TYPE,
                             SN_MESGARANTIA       OUT NOCOPY AL_ARTICULOS.MES_GARANTIA%TYPE,
                             SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                             SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                             SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

PROCEDURE PV_GET_LISTA_CUOTAS_PR (
                EV_NOM_USUARIO       IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
                EN_COD_MODVENTA      IN GE_MODVENTA.COD_MODVENTA%TYPE,
                SC_LISTA_CUOTAS      OUT NOCOPY REFCURSOR,
                SV_APLICA_CUOTAS     OUT NOCOPY VARCHAR2,
                SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

PROCEDURE PV_GET_DATOS_CAUSA_PR(
                                    EV_COD_CAUCASER         IN GA_CAUCASER.COD_CAUCASER%TYPE,
                                    SC_DATOS_CAUSA          OUT REFCURSOR,
                                    SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_IND_ABONO_MODVENTA_PR(
                                       EN_COD_MODVENTA      IN GE_MODVENTA.COD_MODVENTA%TYPE,
                                       SN_IND_ABONO         OUT GE_MODVENTA.IND_ABONO%TYPE,
                                       SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                       SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                       SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_IND_VTA_EXTERNA_VEND_PR(
                                         EN_COD_VENDEDOR      IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                         SN_IND_VTA_EXTERNA   OUT VE_TIPCOMIS.IND_VTA_EXTERNA%TYPE,
                                         SN_COD_RETORNO       OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                         SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                         SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_UPDATE_SINIESTRO_PR(
                                    EN_NUM_SINIESTRO      IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_HISTORICO_SINIESTRO_PR(
                                    EN_NUM_SINIESTRO      IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INSTA_OS_ONLINE_PR(
                                EN_NUM_OS                 IN  CI_ORSERV.NUM_OS%TYPE,
                                EV_COD_OS                 IN  CI_ORSERV.COD_OS%TYPE,
                                EN_PRODUCTO               IN  CI_ORSERV.PRODUCTO%TYPE,
                                EN_TIP_INTER              IN  CI_ORSERV.TIP_INTER%TYPE,
                                EN_COD_INTER              IN  CI_ORSERV.COD_INTER%TYPE,
                                EV_USUARIO                IN  CI_ORSERV.USUARIO%TYPE,
                                --ED_FECHA                  IN  CI_ORSERV.FECHA%TYPE, 30-06-2011
                                EV_FECHA                  IN  VARCHAR2,
                                EV_COMENTARIO             IN  CI_ORSERV.COMENTARIO%TYPE,
                                EN_NUM_CARGO              IN  CI_ORSERV.NUM_CARGO%TYPE,
                                EV_COD_MODULO             IN  CI_ORSERV.COD_MODULO%TYPE,
                                EN_ID_GESTOR              IN  CI_ORSERV.ID_GESTOR%TYPE,
                                EN_NUM_MOVIMIENTO         IN  CI_ORSERV.NUM_MOVIMIENTO%TYPE,
                                EN_COD_ESTADO             IN  CI_ORSERV.COD_ESTADO%TYPE,
                                SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO           OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO             OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_DATOS_MODALIDAD_PR(
    EN_COD_MODVENTA     IN GE_MODVENTA.COD_MODVENTA%TYPE,
    SC_DATOS_MODALIDAD  OUT REFCURSOR,
    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INS_EQUIPABOSER_SIMC_PR(    
                                        EN_COD_BODEGA           IN GA_EQUIPABOSER.COD_BODEGA%TYPE,
                                        EV_NUM_SERIEMEC         IN GA_EQUIPABOSER.NUM_SERIEMEC%TYPE,
                                        EN_COD_ESTADO           IN GA_EQUIPABOSER.COD_ESTADO%TYPE,
                                        EN_NUM_MOVIMIENTO       IN GA_EQUIPABOSER.NUM_MOVIMIENTO%TYPE,
                                        EB_HAYCARGOART          IN VARCHAR2,
                                        EN_NUM_ABONADO          IN GA_EQUIPABOSER.NUM_ABONADO%TYPE,
                                        EV_NUM_SERIE            IN GA_EQUIPABOSER.NUM_SERIE%TYPE,
                                        EN_TIP_STOCK            IN GA_EQUIPABOSER.TIP_STOCK%TYPE,
                                        EN_COD_ARTICULO         IN GA_EQUIPABOSER.COD_ARTICULO%TYPE,
                                        EV_IND_PROCEQUI         IN GA_EQUIPABOSER.IND_PROCEQUI%TYPE,
                                        EV_IND_PROPIEDAD        IN GA_EQUIPABOSER.IND_PROPIEDAD%TYPE,                                       
                                        EV_TIP_TERMINAL         IN GA_EQUIPABOSER.TIP_TERMINAL%TYPE,
                                        EV_DES_EQUIPO           IN GA_EQUIPABOSER.DES_EQUIPO%TYPE,
                                        EN_COD_USO              IN GA_EQUIPABOSER.COD_USO%TYPE,
                                        EB_PLISTA               IN VARCHAR2,                                        
                                        EN_IND_COMODATO         IN NUMBER,                                        
                                        EV_COD_TECNOLOGIA       IN GA_EQUIPABOSER.COD_TECNOLOGIA%TYPE,
                                        EN_IMPORTE              IN GA_EQUIPABOSER.PRC_VENTA%TYPE,
                                        EN_TIPDTO               IN GA_EQUIPABOSER.TIP_DTO%TYPE,
                                        EN_VALDTO               IN GA_EQUIPABOSER.VAL_DTO%TYPE,
                                        EN_COD_MODVENTA         IN GA_EQUIPABOSER.COD_MODVENTA%TYPE,
                                        EN_COD_CUOTA            IN GA_EQUIPABOSER.COD_CUOTA%TYPE,
                                        EV_COD_CAUSA            IN GA_EQUIPABOSER.COD_CAUSA%TYPE,
                                        SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);
PROCEDURE PV_UPD_ABONADO_PR(    
                                        EV_NOM_TABLA            IN VARCHAR2,
                                        EV_NUM_SERIEMEC         IN GA_ABOCEL.NUM_SERIEMEC%TYPE,
                                        EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EV_NUM_SERIE            IN GA_ABOCEL.NUM_SERIE%TYPE,
                                        EV_IND_PROCEQUI         IN GA_ABOCEL.IND_PROCEQUI%TYPE,
                                        EN_COD_MODVENTA         IN GA_ABOCEL.COD_MODVENTA%TYPE,                                   
                                        EV_TIP_TERMINAL         IN GA_ABOCEL.TIP_TERMINAL%TYPE,
                                        EN_COD_USO              IN GA_ABOCEL.COD_USO%TYPE,
                                        EN_IND_COMODATO         IN NUMBER,
                                        EB_CHK_TERMINAL         IN VARCHAR2,
                                        EV_COD_TECNOLOGIA       IN GA_ABOCEL.COD_TECNOLOGIA%TYPE,
                                        EV_NUM_CONTRATO         IN GA_ABOCEL.NUM_CONTRATO%TYPE,
                                        EV_NUM_ANEXO            IN GA_ABOCEL.NUM_ANEXO%TYPE,
                                        EV_COD_TIPCONTRATO      IN GA_ABOCEL.COD_TIPCONTRATO%TYPE,
                                        SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INSTA_CONTCTA_PR(
                                EN_COD_PRODUCTO         IN GA_ABOCEL.COD_PRODUCTO%TYPE,
                                EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                EN_COD_CUENTA           IN GA_ABOCEL.COD_CUENTA%TYPE,
                                EV_COD_TIPCONTRATO      IN GA_ABOCEL.COD_TIPCONTRATO%TYPE,
                                EV_NUM_CONTRATO         IN GA_ABOCEL.NUM_CONTRATO%TYPE,
                                EV_NUM_ANEXO            IN GA_ABOCEL.NUM_ANEXO%TYPE,
                                SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_OBTIENE_BPLISTA_PR(
                                EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                EV_TIP_TERMINAL         IN GA_ABOCEL.TIP_TERMINAL%TYPE,
                                SV_PLISTA               OUT VARCHAR2,
                                SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_INS_MOVIMIENTO_PR(
                                EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                EV_TIP_TERMINAL         IN GA_ABOCEL.TIP_TERMINAL%TYPE,
                                EV_NUM_SERIE_NEW        IN GA_ABOCEL.NUM_SERIE%TYPE,
                                EV_NUM_SERIE_ABO        IN GA_ABOCEL.NUM_SERIE%TYPE,
                                EV_COD_TECNOLOGIA       IN GA_ABOCEL.COD_TECNOLOGIA%TYPE,
                                EN_COD_CLIENTE          IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                EN_COD_CENTRAL          IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                EN_NUM_CELULAR          IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                EV_NUM_IMEI             IN GA_ABOCEL.NUM_IMEI%TYPE,
                                EN_NUM_OS               IN CI_ORSERV.NUM_OS%TYPE,
                                EV_COD_OS               IN CI_ORSERV.COD_OS%TYPE,
                                EN_SECUENCIA_ICC_ANT    IN ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                EN_NUM_SINIESTRO        IN GA_SINIESTROS.NUM_SINIESTRO%TYPE,
                                EV_NOM_USUARIO          IN GA_USUARIOS.NOM_USUARIO%TYPE,
                                EN_SECUENCIA_ICC        IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_REABILITAR_SUSPENSION_PR(
                                EV_NOM_TABLA_ABO        IN VARCHAR2,
                                EV_COD_ACTABO           IN VARCHAR2,
                                EN_NUM_ABONADO          IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                EV_TIP_TERMINAL_ABO     IN GA_ABOCEL.TIP_TERMINAL%TYPE,
                                EV_NUM_SERIEHEX_ABO     IN GA_ABOCEL.NUM_SERIEHEX%TYPE,
                                EV_NUM_SERIE_ABO        IN GA_ABOCEL.NUM_SERIE%TYPE,
                                EV_COD_TECNOLOGIA_ABO   IN GA_ABOCEL.COD_TECNOLOGIA%TYPE,
                                EV_COD_PLANTARIF_ABO    IN GA_ABOCEL.COD_PLANTARIF%TYPE,
                                EN_COD_CENTRAL_ABO      IN GA_ABOCEL.COD_CENTRAL%TYPE,
                                EN_NUM_CELULAR_ABO      IN GA_ABOCEL.NUM_CELULAR%TYPE,
                                EV_NUM_IMEI_ABO         IN GA_ABOCEL.NUM_IMEI%TYPE,
                                EN_NUM_OS               IN CI_ORSERV.NUM_OS%TYPE,
                                EV_COD_OOSS             IN CI_ORSERV.COD_OS%TYPE,
                                EN_NUM_SEQ_MOV          IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                EV_NOM_USUARIO          IN GA_USUARIOS.NOM_USUARIO%TYPE,
                                SN_COD_RETORNO          OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_CAMBIA_ESTADO_MOV_PR(
                                    EN_NUM_MOVIMIENTO     IN ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO        OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO          OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_GET_ESTADO_VENTA_PR(
                                    EN_NUM_ABONADO        IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                    SV_EST_VENTA	      OUT GA_VENTAS.IND_ESTVENTA%TYPE,
                                    SN_COD_RETORNO        OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
                                    SV_MENS_RETORNO       OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
                                    SN_NUM_EVENTO         OUT NOCOPY GE_ERRORES_PG.EVENTO
);

END PV_GEST_LIM_CON_CONSULTAS_PG;
/

SHOW ERRORS