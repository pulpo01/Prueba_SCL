/*=============================================================================
   Nombre     : universo.h
   Programa   : Libreria del Universo Pac
   Autor      : G.A.C
   Modificado : 02 - Febrero - 2004
   Version    : Cuzco
   Modificado : 10-Mayo-2005  (Proyecto Ecuador ECU-05002-E10) G.A.C.
  ============================================================================= */

#define  SQLERRM    sqlca.sqlerrm.sqlerrmc
#define  MAXFETCH   500
#define  STR_HUGE  8192   
#define  STR_LONG   256
#define  ZONA         9
#define  CENTRAL      0
#define  BCOI         0
#define  TMC1      "TMC1"

/*---------------------------------------------------------------------------*/
/* INFORMACION DEL PROGRAMA                                                  */
/*---------------------------------------------------------------------------*/
#define	LOGNAME				"UNIVERSO"
#define GLOSA_PROG     		"GENERACION DE UNIVERSO DE PAGOS AUTOMATICOS DE CUENTAS"
/*#define LAST_REVIEW			"10-MAYO-2005" */
/* #define LAST_REVIEW			"14-SEPTIEMBRE-2005" *XO-200509140664 Soporte RyC 14-09-2005 capc*/
#define LAST_REVIEW			"05-OCTUBRE-2005"    /* XO-200509300773 Soporte RyC 04.10.2005 mfqg*/ 
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
static char szUsage [] =
   "\n\tUso : new_universo"
   "\n\t -u Usuario/Password"
   "\n\t -l Nivel de Log (Opcional.Por default 3)"
   "\n\t -f Fecha(yyyymmdd)"
   "\n\t -b Banco (9999=Todos los Bancos)"
   "\n\t -n Nombre Archivo (Solo si Clientes PAC son informados por archivo)\n\n";

static char szRaya[] = "===================================================================";
static char modulo [1024];

FILE	 *fpDat;

/*char   szVersion       [] = "5.0.0"; * 4 = incremento de versionado ; .0 = incremento segun proyecto ; .0 = incremento segun incidencia/homolog. */
/*char   szVersion       [] = "5.0.1"; *XO-200509140664 Soporte RyC 14-09-2005 capc*/
/*char   szVersion       [] = "5.0.2"; *XO-200509300773 Soporte RyC 04.10.2005 mfqg*/
char   szVersion       [] = "5.0.3"; /* RA-200511170144 17.11.2005 Soporte RyC */

char   szFileName      [1024];                

int    iFile;
long   lCan_Reg        ;
long   lReg_Aceptados  ;
long   lReg_Rechazados ;
int    iContCli        ;
/* char   szCausa          [15];  XO-200509300773 Soporte RyC 04.10.2005 mfqg*/
char   szCliente        [15];
char   szFecha_Pac      [20];
char   szCodZona         [2];
char   szCodCentral      [2];
char   szCodNueve        [1];
char   szCodZonaUni      [3];
char   szCodCentralUni   [3];
char   szBcoiUni         [3];

/*---------------------------------------------------------------------------*/
/* Estructura para datos externos (parametros) 				                 */
/*---------------------------------------------------------------------------*/
typedef struct tagUni_pac
{
  char szUsuario       [31];
  char szPassWord      [31];
  char szFecha_Pac     [20];
  char szCod_Banco     [16];
  int  iNivelLog           ;
  char szFile        [1024];
  BOOL bOptUsuario         ;
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
  BOOL bOptFecha           ;
  BOOL bOptBanco           ;
  BOOL bOptFile            ;
}UNIV_PAC;

/*---------------------------------------------------------------------------*/
/* Estructura para cargar datos desde archivo plano a tabla                  */
/*---------------------------------------------------------------------------*/
typedef struct tagDATUNI
{
	char	szCodZona   [2];
	char	szCodCentral[2];
	char	szCodNueve  [1];
	char	szCliente   [7];
	char	szNull     [12];
	char	szCodBanco  [1];
	char	szRetorno   [4];
} DATUNI;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE CLIENTES                                                    */
/*---------------------------------------------------------------------------*/
typedef struct reg_gecliente{
    long    lCodCliente       ;
    char    szCodBanco    [16];
    char    szCodBancoTarj[16];
    char    szCodZona     [3] ;
    char    szCodCentral  [3] ;
    int     lCodBcoi          ;
	struct 	reg_gecliente * sgte;
}reg_gecliente;
typedef struct reg_gecliente stGeCliente;
stGeCliente * lstGeCliente = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE UNIVERSO PAC                                                */
/*---------------------------------------------------------------------------*/
typedef struct reg_counipac{
    char   szCodCliente    [15] ;
    char   szCodBanco      [16];
    char   szFecInicioPac  [20];
	struct reg_counipac * sgte;
}reg_counipac;
typedef struct reg_counipac stCoUniPac;
stCoUniPac  * lstCoUniPac  = NULL;

/*---------------------------------------------------------------------------*/
/* LISTAS DE FUNCIONES                                                       */
/*---------------------------------------------------------------------------*/
int 	ifnManejaArgumentos(int argc, char * const argv[]);
int 	ifnInicio (UNIV_PAC *stUni_Pac, STATUS *pstStatus );
int 	ifnAbreArchivosLog();
int 	iCambiaPermisos (char *pszDir);
int 	ifnGed_ParametrosPac();
int 	ifnProceso_Unipac();
int 	ifnCargaGe_Clientes();
int	ifnCargaClientesTodoslosBancos();
int	ifnCargaClienteConTarjetaTMM();
int	ifnCargaClienteSoloTarjetaMPR();
int 	ifnRecorreStrucClie();
int 	ifnDBObtDescBanco();
int 	ifnCargaUniPac();
int 	ifnTratarFichero();
int 	ifnModCliente();
int 	ifnDBInsHistCabUniPac();
int 	ifnDBDelCabUniPac();
int 	ifnDBInsHistUniPac();
int 	ifnDBDelUniPac();
int 	ifnDBInsCabUniPac();
int 	ifnLeerFich();
int 	ifnDBInsUniPac();
int 	ifnDBGetCliente();
int 	ifnDBUpdCliente();
int 	ifnDBInsUniverso();
char  * szfnTrim(char *);
void 	vLiberaGeCliente(stGeCliente * );
void 	vLiberaCoUniPac(stCoUniPac * );

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

