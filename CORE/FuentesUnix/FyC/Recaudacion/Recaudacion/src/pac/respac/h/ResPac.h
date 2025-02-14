/*=============================================================================
   Nombre     : ResPac.h
   Programa   : Libreria del Actualizador del Pac 
   Autor      : G.A.C  
	Creado     : 02 - Febrero - 2003 
  ============================================================================= */

#define  LARGOREG   1020
#define  SQLERRM    sqlca.sqlerrm.sqlerrmc

#define  TMM1       "TMM1"
#define  TMM2       "TMM2"
#define  TMM3       "TMM3"
#define  TMM4       "TMM4"
#define  GUA1       "GUA1"
#define  GUA2       "GUA2"
#define  SAL1       "SAL1"
#define  SAL2       "SAL2"
#define  SAL3       "SAL3"
#define  CSR1       "CSR1" 
#define MAXFETCH    500 /* Incidencia 120541 - 06.01.2010 */

/*---------------------------------------------------------------------------*/
/* INFORMACION DEL PROGRAMA                                                  */
/*---------------------------------------------------------------------------*/
#define LOGNAME				"RESPAC"
#define GLOSA_PROG     		"RESPUESTA DEL BANCO POR PAGOS AUTOMATICOS DE CUENTAS"
#define LAST_REVIEW			"15-Diciembre-2010"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
/*char   szhVersion[]   = "6.0.0";   * Nueva version para TMG-TMS*/
/*char   szhVersion[]   = "6.0.1";   * Incidencia 120541 - 06.01.2010 */
/*char   szhVersion[]   = "6.0.2";   * Incidencia 132780 - 04.05.2010 */
/*char   szhVersion[]   = "6.0.3";   * Incidencia 159135 - 15.12.2010 */
char   szhVersion[]   = "7.0.0";     /* Nueva version */
char   szNulo    []   = " ";
static char modulo [1024];

FILE	*fpDat;

char   szFileName  [1024];
int    iCan_Reg  = 0 ;
int    iReg_Act  = 0 ;
double dImp_Reg  = 0 ;
char   szPath       [128] ="" ;
static char szUsage []    =
   "\n\tUso : ResPac"
   "\n\t\t -u [Usuario]/[Password]"
   "\n\t\t -l [NivelLog]"
   "\n\t\t -c [Codigo Banco]"
   "\n\t\t -f [Nombre Archivo]\n\n";

static char szRaya[] = "================================================================";

/*---------------------------------------------------------------------------*/
/* Estructura de datos para los parametros de entrada                        */
/*---------------------------------------------------------------------------*/
typedef struct tagResPac
{
  char szUsuario       [31];
  char szPassWord      [31];
  int  iNivelLog           ;
  char szCod_Banco     [16];
  char szFec_Valor     [9] ;
  char szFile        [1024];
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
  BOOL bOptBanco           ;  
  BOOL bOptFecha           ; 
  BOOL bOptFile            ; 
}RESPAC;

/*---------------------------------------------------------------------------*/
/* LISTAS DE FUNCIONES                                                       */
/*---------------------------------------------------------------------------*/
int 	ifnManejaArgumentos(int argc, char * const argv[]);
int 	ifnInicio ( RESPAC *stResPac, STATUS *pstStatus );
int 	ifnAbreArchivosLog();
int 	ifnProcesoGen ();
int 	ifnValParametrosPAC();
int 	ifnOpenFileDat ();
int 	ifnRescataDatosTMM1 (char *szParam, char *szAux, int iInicio, int iFinal);
int 	ifnRescataDatosArchivo(char *szParam, char *szAux, int iPosComa, int Q);
int 	ifnUpdatePAC (long lCod_Cliente, int iRespuesta);
int 	ifnDesconexionOracle (void);
int 	RighTrim (char *szVar);
int 	ifnValidaCodRechazo(char *szCod_Aproba);
int     ifnValidaString (char *szCod_Aproba);
/* Inicio Incidencia 120541 - 06.01.2010 */
int     ifnReemplazaItem (char *szTexto, char *szItem, char *szDetalle, char *szTextoAct);
int     ifnReplace(char *szpPalabra, char* szpFind, char* szpReplace, char *szpMensajeCompleto);
int     ifnEnviaMensajes (long plCodCliente);
int     ifnEnviaEmail (char *szTexto, char *szEmail);
int     ifnEnviaSMS (long plCodCliente, char *szCodIdioma, double pdImporte);
BOOL    bfnSelectDescripcionMensaje(char *szCodMensaje, char *szCodIdioma, char *szpDescMensaje );
BOOL    bfnGetActAbodeAccion(char *szCodRutina, char *szCodTiPlan, int iCodProducto, char *szActuacionOut);
int     ifnGetActuacionCentralCelularAcc(char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia);
int     ifnBuscaCliente(int Inicio1, int Fin1, char *pszRegistro, char *szhCodCliente, int IndOperadora);
/* Fin Incidencia 120541 - 06.01.2010 */
void vfnSubString(char* target, char* strn, int index, int size);

/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

