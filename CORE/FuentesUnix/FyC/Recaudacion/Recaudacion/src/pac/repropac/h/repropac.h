/*=============================================================================
   Nombre         : repropac.h
   Programa       : Libreria del repropac
   Autor          : L.B.H Indra
   Fecha Creacion : 06 - Mayo - 2005
   Modificado     : 03-10-2005 Proyecto ECU-05012 Modificacion Reportes PAC  G.A.C.
  ============================================================================= */
#define SQLERRM		sqlca.sqlerrm.sqlerrmc
#define SQLROWS		sqlca.sqlerrd[2]
#define MAX_ARRAY    20000
#define iNIVEL_DEF   3

char szhVersion[] = "v.1.1.0";
static char szRaya[] = "----------------------------------------------------------------";
/*---------------------------------------------------------------------------*/
/* INFORMACION DEL PROGRAMA                                                  */
/*---------------------------------------------------------------------------*/
#define	LOGNAME			"REPROPAC"
#define GLOSA_PROG     	"PROGRAMA DE REPROCESO PAGOS AUTOMATICOS DE CUENTAS"
#define LAST_REVIEW		"17-MAYO-2005"


/* ============================================================================= */
/* Estructura tipo lista para numeros de pasocobros                              */
/* ============================================================================= */
struct REPROCESO
{
	long   lCod_cliente      ;		
	long   lNum_folio        ;	
	double dMonto_pagar      ;    		
	int    iRespubanco       ;
	char   szCod_TipDocum [3];
	char   szCodBanco    [16];	
	char   szFec_Emision [11];
	double dTot_Factura      ;
		
	struct REPROCESO *sig;
}; 
   
typedef struct REPROCESO *Lista_Pasoc;	

typedef struct tagParam
{
  char szUsuario       [31];
  char szPassWord      [31];
  long lCodCicloFact       ;
  int  iNivelLog           ;
  BOOL bOptUsuario         ;
  BOOL bOptPassWord        ;
  BOOL bOptCodCicloFact    ;
  BOOL bOptNivelLog        ;
  char szLogPathGene[128]  ;
  char szFileName[32]      ;
}CONFIGLOCAL;

CONFIGLOCAL  stConfig;
FILE *FichBancos;

/* Para Formato Unico */
long lCuentaRegUnico    ;
long lNumOperaciones     ;
long lContRegPac      ;

char szFilePac      [60]  = "" ;
char szTime   	    [256] = "" ;
char szhResultado   []    = " ";
char szArchivo      [32]  = "" ;
char CtrlName       [128]      ; 
char szPathDat      [128] = "" ;
char szPac          [1024]     ;
char szFormatoBanco [7] ;
char szFiller     [] = " " ;
long lContRegPac      ;
long lCon             ;

/*---------------------------------------------------------------------------*/
/* PROTOTIPOS DE FUNCIONES                                                   */
/*---------------------------------------------------------------------------*/
int ifnValidaParametros( int argc, char *argv[], CONFIGLOCAL *pstLC );
int ifnConexionDB( CONFIGLOCAL pstLC);
int ifnInicio (CONFIGLOCAL pstConfig);
int ifnAbreArchivosLog(int iTipfile);
int ifnValidaCicloFact();
int ifnExitReproceso (void);
int ifnInsertaPasoc(Lista_Pasoc *ant);
void vfnBorraListaPasoc(Lista_Pasoc *list);
int ifnBorraPasoc(Lista_Pasoc *ant);
int ifnReproceso();
int ifnCargaListaQuery() ;
int ifnFormatoUnico();
int ifnOrdenaArchivo(void);
int RighTrim (char *szVar);
void Strcpysub(char *str1, int Largo, char *str2);
int HoraToSegs(char *HoraFmto);
int ifnRestaHoras( char *h1, char *h2, char *hh);
char *cfnGetTimePac();
BOOL bfnDBUpdatePagospac(void);
int ifnValores_Iva_Ice(long plCod_cliente, double *pdValor_Iva, double *pdValor_Ice, long plCod_Ciclfact, int piFlag);

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

