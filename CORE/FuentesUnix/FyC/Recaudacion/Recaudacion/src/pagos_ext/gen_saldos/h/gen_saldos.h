/*=============================================================================
   Nombre         : gen_saldos.h
   Programa       : Libreria del gen_saldos.pc
   Autor          : G.A.C.
   Fecha Creacion : 09 - Mayo - 2005
   Proyecto       : Ecuador
  ============================================================================= */
#define SQLERRM		sqlca.sqlerrm.sqlerrmc
#define SQLROWS		sqlca.sqlerrd[2]
#define MAX_ARRAY    30000
#define iNIVEL_DEF   3

/*char szhVersion[] = "v.1.0.0";*/
/*char szhVersion[] = "v.1.0.1"; *XO-200508030274 Soporte RyC 09-08-2005 capc*/
/*char szhVersion[] = "v.1.0.2"; * XO-200508240446 Soporte RyC 26-08-2005 capc*/
/*char szhVersion[] = "v.1.0.3"; * XO-200508260488 Soporte RyC 01-09-2005 capc*/
char szhVersion[] = "v.1.0.4"; /* RA-200511160113 Soporte RyC 18.11.2005 */
/* ============================================================================= */
/* Estructura tipo lista para saldos                                             */
/* ============================================================================= */
struct SALDOS
{
	long   lCod_cliente     ;
	int    iCod_tipdocum    ;
	long   lNum_folio       ;
	double dValor_ICE       ;
	double dValor_IVA       ;
   double dTot_pagar_fa    ;
	double dTot_pagar_ca    ;
	double dValor_Iva       ;
	double dValor_Ice       ;
	double dBase_Imponible  ;
   long   lNum_celular     ;
   char   szNum_contrato[22];
	char   szCod_banco	[16];
	char   szInd_pertrib [2] ;
	char   szNom_cliente [51];
	char   szDirec_clie  [61];
	char   szCod_Operadora[6];
	char   szNum_Ident   [21];
	char   szCod_Tipident [3];
	struct SALDOS *sig;
}; 
   
typedef struct SALDOS *Lista_Pasoc;	

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

char szFilePac      [60]  = "" ;
char szArchivo      [32]  = "" ;
char szPathDat      [128] = "" ;

/*---------------------------------------------------------------------------*/
/* PROTOTIPOS DE FUNCIONES                                                   */
/*---------------------------------------------------------------------------*/
int ifnValidaParametros( int argc, char *argv[], CONFIGLOCAL *pstLC );
int ifnConexionDB( CONFIGLOCAL pstLC);
int ifnInicio (CONFIGLOCAL pstConfig);
int ifnAbreArchivosLog(int iTipfile);
int ifnValidaCicloFact();
int ifnExitSaldos (void);
int ifnInsertaPasoc(Lista_Pasoc *ant);
void vfnBorraListaPasoc(Lista_Pasoc *list);
int ifnBorraPasoc(Lista_Pasoc *ant);
int ifnSaldos();
int ifnCargaListaQuery() ;
int ifnGeneraArchivo();
int RighTrim (char *szVar);
void Strcpysub(char *str1, int Largo, char *str2);
int HoraToSegs(char *HoraFmto);
int ifnRestaHoras( char *h1, char *h2, char *hh);
int ifnDatosFa_Histdocu(long plCod_cliente, int *piCod_tipdocum , long *plNum_folio , double *pdTot_pagar);
/*int ifnDatosGa_Abocel(long plCod_cliente, long *plNum_celular, char *pszNum_contrato); RA-200511160113 Soporte RyC 18.11.2005 */
int ifnDatosGe_Clientes(long plCod_cliente, char *pszCod_banco, char *pszInd_pertrib, char *pszNom_cliente, char *pszDirec_clie, char *pszOperadora, char *pszNum_Ident , char *pszCod_Tipident);
int ifnValores_Iva_Ice(long plCod_cliente, double *dValor_Iva, double *dValor_Ice);
int ifnOrdenaArchivo(void);

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
