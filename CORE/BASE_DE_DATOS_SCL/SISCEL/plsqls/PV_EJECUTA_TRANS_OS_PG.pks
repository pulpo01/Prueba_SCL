CREATE OR REPLACE PACKAGE PV_EJECUTA_TRANS_OS_PG IS
-- *************************************************************
-- * Paquete            : PV_EJECUTA_TRANS_OS_PG
-- * Descripción        : Funciones y procedimientos Transaccionales
-- * Función            : Packarge para LLAMADA A pl transaccionales
-- * Fecha de creación  : noviembre 2006
-- * F. de Homologacion :
-- * Actualizacion      : Postventa SCL - Orlando Cabezas B.
-- *************************************************************

-- Declaracion de Variables Globales

-- Inicio especificacion PL/SQL

TYPE refcursor IS REF CURSOR;

CV_ESTADO   CONSTANT VARCHAR2 (5)   := 'TRUE';


PROCEDURE PV_FACHADA_PARAMETRO(
                           EN_NUM_MOVIMIENTO     IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MOVIMIENTO%TYPE,
                           EV_COD_ACTABO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                           EN_COD_PRODUCTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                            EV_COD_TECNOLOGIA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TECNOLOGIA%TYPE,
                           EN_TIP_PANTALLA       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_PANTALLA%TYPE,
                           EN_COD_CONCEPTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CONCEPTO%TYPE,
                           EV_COD_MODULO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODULO%TYPE,
                           EV_COD_PLANTARIF_NUE  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_NUE%TYPE,
                           EV_COD_PLANTARIF_ANT  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_ANT%TYPE,
                           EN_TIP_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                           EV_COD_OS             IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                           EN_COD_CLIENTE        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                           EN_NUM_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                           EN_IND_FACTUR         IN PV_TMPPARAMETROS_ENTRADA_TT.IND_FACTUR%TYPE,
                           EV_COD_PLANSERV       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                           EV_COD_OPERACION      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                           EV_COD_TIPCONTRATO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                           EN_TIP_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_CELULAR%TYPE,
                           EN_NUM_MESES          IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                           EV_COD_ANTIGUEDAD     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                           EN_COD_CICLO          IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CICLO%TYPE,
                           EN_NUM_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                           EN_TIP_SERVICIO       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                           EN_COD_PLANCOM        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                           EV_PARAM1_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                           EV_PARAM2_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                           EV_PARAM3_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                           EN_COD_ARTI           IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                           EV_COD_CAUSA            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                           EV_COD_CAUSA_NUE      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                           EN_COD_VENDE            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                           EV_COD_CATEG            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                           EN_COD_MODVTA            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                           EV_COD_CAUSINIE         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSINIE%TYPE,
                           SV_record             out nocopy refcursor );

PROCEDURE PV_FACHADA_PARAMETRO_ODBC(
                           EN_NUM_MOVIMIENTO     IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MOVIMIENTO%TYPE,
                           EV_COD_ACTABO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
                           EN_COD_PRODUCTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                            EV_COD_TECNOLOGIA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TECNOLOGIA%TYPE,
                           EN_TIP_PANTALLA       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_PANTALLA%TYPE,
                           EN_COD_CONCEPTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CONCEPTO%TYPE,
                           EV_COD_MODULO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODULO%TYPE,
                           EV_COD_PLANTARIF_NUE  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_NUE%TYPE,
                           EV_COD_PLANTARIF_ANT  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_ANT%TYPE,
                           EN_TIP_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
                           EV_COD_OS             IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
                           EN_COD_CLIENTE        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
                           EN_NUM_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
                           EN_IND_FACTUR         IN PV_TMPPARAMETROS_ENTRADA_TT.IND_FACTUR%TYPE,
                           EV_COD_PLANSERV       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
                           EV_COD_OPERACION      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
                           EV_COD_TIPCONTRATO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
                           EN_TIP_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_CELULAR%TYPE,
                           EN_NUM_MESES          IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
                           EV_COD_ANTIGUEDAD     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
                           EN_COD_CICLO          IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CICLO%TYPE,
                           EN_NUM_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
                           EN_TIP_SERVICIO       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
                           EN_COD_PLANCOM        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
                           EV_PARAM1_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
                           EV_PARAM2_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
                           EV_PARAM3_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
                           EN_COD_ARTI           IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
                           EV_COD_CAUSA            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
                           EV_COD_CAUSA_NUE      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
                           EN_COD_VENDE            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
                           EV_COD_CATEG            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
                           EN_COD_MODVTA            IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
                           EV_COD_CAUSINIE        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSINIE%TYPE);
                          -- SV_record             out nocopy refcursor );

PROCEDURE PV_PROG_PRINCIPAL(
                           EV_COD_ACTABO     IN  icc_movimiento.COD_ACTABO%TYPE,
                              EV_COD_MODULO     IN  icc_movimiento.COD_MODULO%TYPE,
                           EN_COD_PRODUCTO   IN  PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
                           EV_COD_TECNOLOGIA IN  PV_TMPPARAMETROS_ENTRADA_TT.COD_TECNOLOGIA%TYPE,
                           EN_MOVIMIENTO     IN  PV_TMPPARAMETROS_ENTRADA_TT%ROWTYPE,
                           SV_record     out nocopy refcursor);


FUNCTION  pv_nuevomodulo_fn (EN_p_v_producto   IN NUMBER,
                             EV_p_v_actabo     IN VARCHAR2,
                             EV_p_v_modulo     IN VARCHAR2,
                             EV_p_v_tecnologia IN VARCHAR2) RETURN BOOLEAN;

FUNCTION  pv_retorna_version_fn RETURN VARCHAR2;

Lv_n_num_evento NUMBER(9) := -1;
END PV_EJECUTA_TRANS_OS_PG; 
/
SHOW ERRORS
