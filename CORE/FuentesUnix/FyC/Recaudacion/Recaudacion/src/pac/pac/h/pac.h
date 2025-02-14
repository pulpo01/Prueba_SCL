/*=============================================================================
   Nombre     : pac.h
   Programa   : Libreria del PAC 
   Autor      : G.A.C  
  ============================================================================= */
#define iNum	   25000 	   /* Numero de Registros que escribiremos a la vez */
#define access     extern
#define GUA1       "GUA1"
#define GUA2       "GUA2"
#define SAL1       "SAL1"
#define SAL2       "SAL2"
#define SAL3       "SAL3"
#define CSR1       "CSR1"
#define MAXFETCH   500

/*---------------------------------------------------------------------------*/
/* INFORMACION DEL PROGRAMA                                                  */
/*---------------------------------------------------------------------------*/
#define	LOGNAME			"NEW_PAC"
#define GLOSA_PROG     	"PROGRAMA DE PAGOS AUTOMATICOS DE CUENTAS"
#define LAST_REVIEW		"27-JUNIO-2011" 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
static char szUsage[] = "\nUso:   new_pac -u Usuario/Password          "
						"\n\tParametros:                                       "
						"\n\t-c [CodBanco] (9999= Genera Todos los Bancos)     "
						"\n\t-f [Cod Ciclo Facturacion]                        "
						"\n\t-b [Cod Ciclo Banco] (Opcional. Por default 0)    "  
						"\n\t-l [LogNivel] (Opcional. Por Default 3)\n\n";

static char szRaya[] = "----------------------------------------------------------------";
/*char szhVersion  [] = "6.0.0";   Nueva version para TMG-TMS*/
/*char szhVersion  [] = "6.0.1";  Incidencia 132205 - 29.04.2010 - TMG-TMS */
/*char szhVersion  [] = "6.0.2";  Incidencia 137489 - 14.06.2010 - TMG-TMS */
/*char szhVersion  [] = "6.0.3";  Incidencia 157137 - 30.11.2010 - TMG-TMS */
char szhVersion  [] = "7.0.0";  /*RA 171526 - 27.06.2011 - CSR*/
/* Para Formato TMM1 */
long lRegAno         = 0 ;
char szFiller     [] = " " ;
char szCero       [] = "0" ;
char szhFecVenctoCiclo[15];

long lNumOperaciones    ;

char szFilePac      [60]  = "" ;
char szTime   	    [256] = "" ;
char szhResultado   []    = " ";
char szArchivo      [32]  = "" ;
char CtrlName       [128]      ; 
char szPathDat      [128] = "" ;
char szPac          [1024]     ;
char szFormatoBanco [7] ;

long lContRegPac      ;
long lCon             ;
long lContRegAAA      ;  

FILE  *CtrlFile       ;

/*---------------------------------------------------------------------------*/
/* Estructura para Preparar datos de las Estadisticas.                       */
/*---------------------------------------------------------------------------*/
typedef struct Estadisticas
{
  long  lContRegPac  	 ;	 
  long  lRegAnomalo  	 ;	 
}ESTADISTICAS; 

/*---------------------------------------------------------------------------*/
/* Estructura de datos para recoger los datos por la linea de comandos.      */
/*---------------------------------------------------------------------------*/
typedef struct LineaComando
{  
  char 	szUser      [255];       		   		  	 /* Nombre de Usuario    */
  char 	szPass      [255];       				 	 /* y Password de Oracle */
  long 	lCodCiclFact     ;      					 /* Ciclo de Facturacion */
  char 	szCodBanco   [16];          			     /* Codigo Banco Interno */
  char 	szCicloBanco  [3];         					 /* Ciclo Banco Exterior */
  char 	szNomFicPac  [40];
}LINEACOMANDO;

/*---------------------------------------------------------------------------*/
/* Estructura que corresponde con la Base de Datos CO_PAGOSPAC               */
/*---------------------------------------------------------------------------*/
typedef struct Histpac
{
  char   szRowid         [19];
  char   szCodBanco      [16];
  long   lCodCliente         ;
  long   lNumSecuencia       ;
  char   szCodTipDocum    [3];
  char   szCodVendAgent   [7];
  char   szLetra          [2];
  int    iCodCentremi        ;
  long   lNumFolio           ;
  char   szPref_Plaza    [26];
  char   szFecVencimie    [9];
  double dImpDebe            ;
  char   szFecValor      [15];
  int    iCodRespuBanco      ;
  char   szNomUsuarOra   [31];
  int	 iIndProcesado	     ;
  int    iIndCancelado       ;	
  char   szSeqPac	     [13];	 
  long   lCodCiclFact        ; 
  char   szCod_Operadora  [6];
  char   szCod_Plaza      [6]; 
  double dTot_Factura        ;
  double dIvas               ;
  double dSin_IvaIce         ;
  char   szCodTipDocu     [3]; 
  int    iClienteExiste      ; 
  char   szFec_emision   [11];
}FA_HISTDOCU;

/*---------------------------------------------------------------------------*/
/* Estructura que guarda datos para introducir en el Fichero                 */
/*---------------------------------------------------------------------------*/
typedef struct FicBancos
{
	char	 szCodZona     [3];
	char	 szcodcentral  [3];
	char	 szciclocelu   [4];
	char	 szCodBanco   [16];
	char	 szCicloBanco  [3];
    char     szPref_Plaza [26];
	char     szNewCodBanco[16];
	char     szCtaCte_Tarj[19];
	char     szCod_TipDocum[3];
    char     szFec_emision[11];
    char     szFecVencimie [9];
	long	 lCodCliente      ;
	long     lNumFolio        ;
    double   dTotFactura      ;
	double   dmontopago       ;
	double   dBIva            ;
    double   dBSinIvaIce      ;
  	int      iCodBcoi         ;
    int      iClienteProcesado; 
    BOOL	 final;			/*	El final se marca TRUE por tanto habria que inicializar a FALSE
				                el array de estructuras */
}FICBANCOS;	

/*---------------------------------------------------------------------------*/
/* Estructura que guarda datos del universo de datos                         */
/*---------------------------------------------------------------------------*/
typedef struct Universo
{
	long    lCicloFact          ;      
	char    szOperadora      [6];
	char    szRowid         [20]; 
	char    szCodBanco      [16]; 
	short   isCodBanco          ;
	long    lCodCliente         ;
	long    lNumSecuencia       ;
	char    szCodVendAgent   [7]; 
	char    szLetra          [2]; 
	short   isLetra             ;
	int     iCodCentremi        ;
	char    szCodTipDocum    [3]; 
	long    lNumFolio           ;
	char    szPrefPlaza     [26];
	char    szFecVencimie    [9]; 
	short   isFecVencimie       ;
	char    szNomUsuarOra   [31]; 
	double  dImpDebe            ;
	char    szCodOperadora   [6];
	char    szCodPlaza       [6];
	double  dTotFactura         ;
	double  dSaldo              ;
	char    szNewCodBanco   [16];
	char    szFec_Cancela    [7];
	double  dIva                ;
    double  dSinIvaIce          ;
	char    szProcedenciaReg [2];
    char    szFec_emision   [11];
}UNIVERSO;

FILE *FichBancos;

 
/*---------------------------------------------------------------------------*/
/* LISTAS DE FUNCIONES                                                       */
/*---------------------------------------------------------------------------*/
int  ifnManejaArgumentos(int argc, char * const argv[]);
BOOL bfnIniciarProcesoPac();
BOOL bfnGedParametros();
BOOL bfnDBUpdateHistDocu(FA_HISTDOCU  *pstHist);
BOOL bfnInsertFic( FICBANCOS *pstBancos, char *szCodBanco_param , char *szhOperadora);
char *cfnGetTimePac();
int  ifnAbreArchivosLog(int iTipfile);
int  ifnFormatoPac (char *szCodBancoPac, char *pszFormatoBanco, char *pszCod_Servicio, char *pszOperadora);
int  RighTrim (char *szVar);
int  ifnProcesaPAC(long , char *, char *, char *, char *);
int  ifnProcesaUniverso(UNIVERSO *pstUniverso, char *pszCicloCelu, char *pszOperadora);
int  ifnConsulta_CO_CARTERA(long plCodCliente, long plCicloFact, short psCodBanco, char *pszCodBancoPar, char *pszNewCodBanco);
int  ifnConsulta_FA_HISTDOCU(long plCodCliente, long plCicloFact, char *psLetra, char *pszOperadora, short psCodBanco, char *pszCodBancoPar, char *pszNewCodBanco);
int  ifnVerificaReg_FA_HISTDOCU(long plCodCliente, long plCicloFact, char *psLetra, char *pszOperadora );
int  ifnVerificaReproceso(long plCodCliente, char *pszCodBancoPar, long plCicloFact, char *pszLetra, char *pszOperadora);
int  ifnFormatoGUA1( long plCod_Cliente, int piCon, FICBANCOS * psBancos);
int  ifnFormatoGUA2(long plCod_Cliente, int piCon, FICBANCOS * psBancos);
int  ifnFormatoSAL1(long plCod_Cliente, int piCon, FICBANCOS * psBancos);
int  ifnFormatoSAL2(long plCod_Cliente, int piCon, FICBANCOS * psBancos);
int  ifnFormatoSAL3(long plCod_Cliente, int piCon, FICBANCOS * psBancos);
int  ifnFormatoCSR1(long plCod_Cliente, int piCon, FICBANCOS * psBancos);
int  ifnValores_Iva_Ice(long plCod_cliente, double *pdValor_Iva, double *pdValor_Ice, long plCod_Ciclfact, int piFlag);
int  ifnOrdenaArchivo(void);
access BOOL bfnProcesoGenPac ();
access BOOL bfnDBInsertAno(FA_HISTDOCU *stHistPac);
access BOOL bfnDBInsertPagosPac(FA_HISTDOCU *stHistPac);
access int  ifnLlenarStBancosPac( FA_HISTDOCU *pstHist, FICBANCOS *pstBancos, BOOL *bAumentarCont );
int  ifnVerificaRegProc(long plCodCliente, char *pszCodBancoPar, long plCicloFact, char *pszOperadora); 
int  ifnSaldoVencido(long plCod_cliente, char * psFechaEmision, double *pdSaldo);  /* Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */
/******************************************************************************************/
/** Informaci¢n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi¢n                                            : */
/**  %PR% */
/** Autor de la Revisi¢n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi¢n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci¢n de la Revisi¢n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
