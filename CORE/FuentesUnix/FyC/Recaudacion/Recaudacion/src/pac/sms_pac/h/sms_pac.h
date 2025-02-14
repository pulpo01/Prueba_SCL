/*=============================================================================
   Nombre     : sms_pac.h
   Programa   : Libreria para generación de SMS del PAC 
   Autor      : H.Q.R.  
   Creado     : 19-Mayo-2009 (Proyecto MIX-09003 Guatemala - El Salvador)
   Version    : 1.0
   Modificado : <>
  ============================================================================= */
#define iNum	   25000 	   /* Numero de Registros que escribiremos a la vez */
#define access     extern
#define MAXFETCH   500

/*---------------------------------------------------------------------------*/
/* INFORMACION DEL PROGRAMA                                                  */
/*---------------------------------------------------------------------------*/
#define	LOGNAME			"SMS_PAC"
#define GLOSA_PROG     	"PROGRAMA DE SMS DE PAGOS AUTOMATICOS DE CUENTAS"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
static char szUsage[] = "\nUso:   sms_pac -u Usuario/Password          "
						"\n\tParametros:                                       "
						"\n\t-c [CodBanco]                                     "
						"\n\t-l [LogNivel] (Opcional. Por Default 3)\n\n";

static char szRaya[] = "----------------------------------------------------------------";

/*char szhVersion     []    = "1.0.0";  MIX-09003 */
char szhVersion     []    = "1.0.1"; /* Requerimiento MIX-09003 - 135020 - 08.07.2010 - MQG*/


char szFiller     [] = " " ;
char szCero       [] = "0" ;

char szFilePac      [60]  = "" ;
char szTime   	    [256] = "" ;
char szArchivo      [32]  = "" ;
char szPathDat      [128] = "" ;

long lContRegPac      ;
long lRegAnomalo      ;
long lCon             ;

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
  char 	szCodBanco   [16];          			     /* Codigo Banco Interno */
}LINEACOMANDO;

/*---------------------------------------------------------------------------*/
/* LISTAS DE FUNCIONES                                                       */
/*---------------------------------------------------------------------------*/
int  ifnManejaArgumentos(int argc, char * const argv[]);
BOOL bfnIniciarProcesoSmsPac();
BOOL bfnGedParametros();
BOOL bfnActualizaCoPagosPac(int ipIndSMS, char *szpFecValor, char *szpCodBanco, long lpCodCliente, int ipCodTipDocum, char *szpFormatoFecha, int ipIndSMSAnt);
BOOL bfnSelectDescripcionMensaje(char *szCodMensaje, char *szCodIdioma, char *szpDescMensaje );
BOOL bfnGetActAbodeAccion(char *szCodRutina, char *szCodTiPlan, int iCodProducto, char *szActuacionOut);
int ifnGetActuacionCentralCelularAcc(char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia);
char *cfnGetTimePac();
int  ifnAbreArchivosLog(int iTipfile);
int  RighTrim (char *szVar);
access BOOL bfnProcesoGenSMSPac ();
BOOL ifnProcesaSMS(char *szpCodBanco); /* Requerimiento MIX-09003 - 135020 - 08.07.2010 - MQG*/

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
