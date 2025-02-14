CREATE OR REPLACE PACKAGE PV_COBRAR_PG IS
-- *************************************************************
-- * Paquete            : PPV_COBRAR_PG
-- * Descripción        : Funciones y procedimientos Transaccionales
-- * Función            : Packarge para Generar Cargos
-- * Fecha de creación  : noviembre 2006
-- * F. de Homologacion :
-- * Actualizacion      : Postventa SCL - Orlando Cabezas B.
-- *************************************************************

-- Declaracion de Variables Globales

-- Inicio especificacion PL/SQL

  TYPE  typ_tab_parametros IS TABLE OF PV_TMPPARAMETROS_SALIDA_TT%ROWTYPE
  INDEX BY BINARY_INTEGER;

  tab_parametros    typ_tab_parametros;
  TYPE refcursor IS REF CURSOR;
  ind_parametros    BINARY_INTEGER := 0;
  Lv_n_num_evento   NUMBER(9) := -1;
  
  CV_COD_TIPSERV       CONSTANT NUMBER(1)    := 2;

  GN_NUM_MOVIMIENTO   PV_TMPPARAMETROS_SALIDA_TT.NUM_MOVIMIENTO%TYPE;
  GV_IND_FACTUR       PV_TMPPARAMETROS_SALIDA_TT.IND_FACTUR%TYPE;
  GV_DES_SERV         PV_TMPPARAMETROS_SALIDA_TT.DES_SERV%TYPE;
  GN_NUM_UNIDADES     PV_TMPPARAMETROS_SALIDA_TT.NUM_UNIDADES%TYPE;
  GN_IMP_CARGO        PV_TMPPARAMETROS_SALIDA_TT.IMP_CARGO%TYPE;
  GN_COD_CONCEPTO     PV_TMPPARAMETROS_SALIDA_TT.COD_CONCEPTO%TYPE;
  GV_COD_MONEDA       PV_TMPPARAMETROS_SALIDA_TT.COD_MONEDA%TYPE;
  GV_DES_MONEDA       PV_TMPPARAMETROS_SALIDA_TT.DES_MONEDA%TYPE;


  PROCEDURE PV_CARGO_DESCUENTO_PR(
                         EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                         SV_GLOSA         IN OUT NOCOPY VARCHAR2);




  PROCEDURE PV_CARGO_MAESTRO_OCASIONAL_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EN_COD_OS        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 );


 PROCEDURE PV_CARGO_MAESTRO_SEG_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EN_COD_OS        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EN_COD_PLANTARIFANT   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_ANT%TYPE,
                                                 EN_COD_PLANTARIFNUE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_NUE%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 );


PROCEDURE PV_CARGO_SEGMENTACION_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EV_PLANTARIF_ANT  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 EV_PLANTARIF_NUE  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 SV_RETORNO         IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA                IN OUT NOCOPY VARCHAR2
                                                 );


  PROCEDURE PV_INS_TMPPARAMETROS_SALIDA_PR( EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                          SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                                  SV_GLOSA         IN OUT NOCOPY VARCHAR2);

  PROCEDURE PV_CARGO_OCASIONAL_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2);



  PROCEDURE PV_CARGO_OCASIONALTRASPP_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EN_COD_OS        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EN_TIP_PANTALLA  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_PANTALLA%TYPE,  
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2);

PROCEDURE PV_COBRO_INDEMNIZACION_PR(
                         EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 SV_RETORNO       IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA         IN OUT NOCOPY VARCHAR2 );
                                                 
                                                 
PROCEDURE PV_CARGO_ADELANTADO_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EV_PLANTARIF_ANT  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 EV_PLANTARIF_NUE  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 SV_record         OUT NOCOPY refcursor,
                                                 SV_RETORNO        IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA          IN OUT NOCOPY VARCHAR2
                                                 );


PROCEDURE PV_CARGO_ADELANSS_TRASABO_PR(
                                                 EN_COD_PRODUCTO  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                                                 EN_COD_ACTABO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                                                 EN_COD_PLANSERV  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                                                 EN_TIP_SERVICIO  IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                                                 EN_COD_CLIENTE   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                                                 EN_NUM_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                                                 EN_COD_PLANCOM   IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                                                 EN_NUM_CELULAR   IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                                                 EV_COD_OPERA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                                                 EV_TIP_CONT      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                                                 EN_MES           IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                                                 EV_COD_ANT       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                                                 EV_ESTADO_EQ     IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                                                 EV_COD_CNUE      IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                                                 EV_MESNUE        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                                                 EN_COD_ARTI      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                                                 EV_COD_CAUSA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                                                 EV_COD_CAUSA_NUE IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                                                 EV_COD_CATEG     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                                                 EN_COD_MODVTA    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                                                 EN_COD_VENDE     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                                                 EN_TIP_ABONADO   IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                                                 EV_PLANTARIF_ANT  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                 EV_PLANTARIF_NUE  IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                -- SV_record         OUT NOCOPY refcursor,
                                                 SV_RETORNO        IN OUT NOCOPY VARCHAR2,
                                                 SV_GLOSA          IN OUT NOCOPY VARCHAR2
                                                 );                                                                                                   




END PV_COBRAR_PG;
/
SHOW ERRORS