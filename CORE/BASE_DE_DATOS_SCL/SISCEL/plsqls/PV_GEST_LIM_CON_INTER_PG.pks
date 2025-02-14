CREATE OR REPLACE PACKAGE PV_GEST_LIM_CON_INTER_PG
IS

TYPE RefCursor          IS REF CURSOR;
ERROR_VALIDACION        EXCEPTION;
ERROR_GENERAL           EXCEPTION;
GV_PACKAGE              CONSTANT VARCHAR2(32)                   := 'PV_GEST_LIM_CON_INTER_PG';
gv_error_others         CONSTANT NUMBER                         := '156';
gv_error_no_clasif      CONSTANT VARCHAR2(100)                  := 'Error no Clasificado';
gn_largoerrtec          CONSTANT NUMBER(3)                      := 500;
gn_largodesc            CONSTANT NUMBER(3)                      := 100;
gv_cod_modulo           CONSTANT VARCHAR2(2)                    := 'GA';
gn_cod_producto         CONSTANT NUMBER                         := 1;

PROCEDURE PV_EJEC_GA_ESTADO_VENDEDOR_PR(
    EN_COD_VENDEDOR     IN  VE_VENDEDORES.COD_VENDEDOR%TYPE,
    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_BLOQ_DESBLOQ_VENDEDOR_PR(
    EN_COD_VENDEDOR     IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
    EV_ACCION           IN VARCHAR2,
    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
    SV_MENS_RETORNO      OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
    SN_NUM_EVENTO        OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_EJECUTA_ESQ_RESTRICCION_PR(
                                        EV_SECUENCIA       IN VARCHAR2,
                                        EV_CODMODULO       IN VARCHAR2,
                                        EV_CODPRODUCTO     IN VARCHAR2,
                                        EV_CODACTABO       IN VARCHAR2,
                                        EV_EVENTO          IN VARCHAR2,
                                        EV_PROGRAMA        IN VARCHAR2,
                                        EV_PROCESO         IN VARCHAR2,
                                        EV_CODACTABODET    IN VARCHAR2,
                                        EV_NUMABONADO      IN VARCHAR2,
                                        EV_CODCLIENTE      IN VARCHAR2,
                                        EV_CODMODGENER     IN VARCHAR2,
                                        EV_NUMVENTA        IN VARCHAR2,
                                        EV_CODOS           IN VARCHAR2,
                                        EV_CODVENDEDOR     IN VARCHAR2,
                                        EV_DESSS           IN VARCHAR2,
                                        EV_CODPLANTARIFD   IN VARCHAR2,
                                        EV_CODUSO          IN VARCHAR2,
                                        EV_CODCUENTAORIGEN IN VARCHAR2,
                                        EV_CODCUENTADEST   IN VARCHAR2,
                                        EV_CODCLIENTEDEST  IN VARCHAR2,
                                        EV_CODTIPPLANTARIF IN VARCHAR2,
                                        EV_CODTIPPLANTARID IN VARCHAR2,
                                        EV_CODCICLO        IN VARCHAR2,
                                        EV_CODFECHASISTEMA IN VARCHAR2,
                                        EV_RESTRICCION     IN VARCHAR2,
                                        EV_CODMODULODET    IN VARCHAR2,
                                        EV_NUMID           IN VARCHAR2,
                                        EV_CODCENTRAL      IN VARCHAR2,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_EJECUTA_ABO_LIM_CONS_PR(
                                        EN_COD_CLIENTE     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                        EN_ABONO           IN NUMBER,
                                        EV_USUARIO         IN VARCHAR2,
                                        EV_MODULO          IN PV_IORSERV.COD_MODULO%TYPE,
                                        EN_NUMTAR          IN VARCHAR2,
                                        EV_COD_OOSS        IN VARCHAR2,
                                        EN_ABONADO         IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_INSERT_CI_ORSERV_PR(
                                        EN_NUM_OS          IN CI_ORSERV.NUM_OS%TYPE,
                                        EV_COD_OS          IN CI_ORSERV.COD_OS%TYPE,
                                        EN_PRODUCTO        IN CI_ORSERV.PRODUCTO%TYPE,
                                        EN_COD_INTER       IN CI_ORSERV.COD_INTER%TYPE,
                                        EV_USUARIO         IN CI_ORSERV.USUARIO%TYPE,
                                        EV_COMENTARIO      IN CI_ORSERV.COMENTARIO%TYPE,
                                        EV_COD_MODULO      IN CI_ORSERV.COD_MODULO%TYPE,
                                        EN_ID_GESTOR       IN CI_ORSERV.ID_GESTOR%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
);


PROCEDURE PV_REGISTRAR_ABO_LIM_CON_PR(
                                        EN_COD_CLIENTE     IN GA_ABOCEL.COD_CLIENTE%TYPE,
                                        EN_ABONADO         IN GA_ABOCEL.NUM_ABONADO%TYPE,
                                        EN_ABONO           IN NUMBER,
                                        EV_USUARIO         IN VARCHAR2,
                                        EV_MODULO          IN PV_IORSERV.COD_MODULO%TYPE,
                                        EN_NUMTAR          IN VARCHAR2,
                                        EN_NUM_OS          IN CI_ORSERV.NUM_OS%TYPE,
                                        EV_COD_OOSS        IN VARCHAR2,
                                        EN_PRODUCTO        IN CI_ORSERV.PRODUCTO%TYPE,
                                        EN_COD_INTER       IN CI_ORSERV.COD_INTER%TYPE,
                                        EV_COMENTARIO      IN CI_ORSERV.COMENTARIO%TYPE,
                                        SN_COD_RETORNO     OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                        SV_MENS_RETORNO    OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                        SN_NUM_EVENTO      OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_EJECUTA_MOD_LIM_CONS_PR(

		                                                EN_COD_CLIENTE  		IN GA_ABOCEL.COD_CLIENTE%TYPE,
		                                                EN_NUM_ABONADO     		IN GA_ABOCEL.NUM_ABONADO%TYPE,
		                                                EN_DET_MONTO       		IN NUMBER,
		                                                EV_RESP_CONTINUAR  		IN VARCHAR2,
		                                                EV_COD_PLANTARIF   		IN GA_ABOCEL.COD_PLANTARIF%TYPE,
		                                                EV_COD_LIMCONS     		IN TOL_LIMITE_TD.COD_LIMCONS%TYPE,
		                                                EV_USUARIO_BD			IN VARCHAR2,
		                                                EV_COMEN_VENDEDOR      	IN CI_ORSERV.COMENTARIO%TYPE,
                                                        EN_NUM_OS               IN CI_ORSERV.NUM_OS%TYPE,
                                                        EV_COD_OS               IN CI_ORSERV.COD_OS%TYPE,
                                                        EN_COD_PRODUCTO         IN CI_ORSERV.PRODUCTO%TYPE,
                                                        EN_COD_INTER            IN CI_ORSERV.COD_INTER%TYPE,
		                                                SN_COD_RETORNO     		OUT NOCOPY GE_ERRORES_TD.COD_MSGERROR%TYPE,
		                                                SV_MENS_RETORNO    		OUT NOCOPY GE_ERRORES_TD.DET_MSGERROR%TYPE,
		                                                SN_NUM_EVENTO      		OUT NOCOPY GE_ERRORES_PG.EVENTO
		
);

PROCEDURE PV_GET_OPERADORA_CLI_PR(
                                    EN_COD_CLIENTE      IN VE_VENDEDORES.COD_VENDEDOR%TYPE,
                                    SV_COD_OPERADORA    OUT GE_CLIENTES.COD_OPERADORA%TYPE,
                                    SN_COD_RETORNO      OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                    SV_MENS_RETORNO     OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                    SN_NUM_EVENTO       OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_CNSLTA_P_GA_INTERAL_PR( EV_NUM_TRASACC  IN VARCHAR2, 
                                     EV_TIPMOV       IN VARCHAR2,
									 EV_TIPSTOCK     IN VARCHAR2,
									 EV_CODBODEGA  	 IN VARCHAR2,
									 EV_CODARTICULO  IN VARCHAR2,
									 EV_CODUSO       IN VARCHAR2,
									 EV_CODESTADO    IN VARCHAR2,
									 EV_NUMVENTA     IN VARCHAR2,
									 EV_ICANTIDAD    IN VARCHAR2,
									 EV_NUMSERIE     IN VARCHAR2,
									 EV_IINDTELEF    IN VARCHAR2,
									 SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.CODERROR,
									 SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.MSGERROR,
									 SN_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

PROCEDURE PV_INTRFZ_ABONADOS_PR(EV_ACTABO                   IN VARCHAR2,
                                EV_PRODUCTO                 IN VARCHAR2,
                                EV_ABONADO                  IN VARCHAR2,
                                EV_ORIGEN                   IN VARCHAR2,
                                EV_DESTINO                  IN VARCHAR2,
                                EV_VAR3                     IN VARCHAR2,
                                EV_VAR4                     IN VARCHAR2,
                                EV_VAR5                     IN VARCHAR2,
                                EV_VAR6                     IN VARCHAR2,
                                SN_NUM_TRANSACCION          OUT NUMBER,
                                SN_COD_RETORNO              OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO             OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO               OUT NOCOPY GE_ERRORES_PG.EVENTO
);

PROCEDURE PV_CONSULTA_FOLIO_PR( EV_COD_CATTRIBUT    IN GE_CATRIBDOCUM.COD_CATRIBUT%TYPE,
                                EN_COD_VENDEDOR     IN NUMBER,
                                EV_COD_OFICINA      IN VARCHAR2,
                                EV_PREFIJO_FOLIO    IN VARCHAR2,
                                EN_CORRELATIVO      IN NUMBER,
                                EN_RANGO_INICIAL    IN NUMBER,
                                EN_OPCION           IN NUMBER,
                                SV_RESULTADO        OUT VARCHAR2,
                                SN_COD_RETORNO  OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO   OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

PROCEDURE PV_DES_RESERVART_PR(
                                EN_NUMTRANSACCION       IN GA_RESERVART.NUM_TRANSACCION%TYPE,
                                SN_COD_RETORNO     	   OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                SV_MENS_RETORNO  	   OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                SN_NUM_EVENTO    	   OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

PROCEDURE PV_ROLLBACK_RESERV_PR (EN_NUMTRANSACCION       IN GA_RESERVART.NUM_TRANSACCION%TYPE,
                                                         SN_COD_RETORNO            OUT NOCOPY GE_ERRORES_PG.CODERROR,
                                                         SV_MENS_RETORNO         OUT NOCOPY GE_ERRORES_PG.MSGERROR,
                                                       SN_NUM_EVENTO           OUT NOCOPY GE_ERRORES_PG.EVENTO 
);

END PV_GEST_LIM_CON_INTER_PG;
/
SHOW ERRORS