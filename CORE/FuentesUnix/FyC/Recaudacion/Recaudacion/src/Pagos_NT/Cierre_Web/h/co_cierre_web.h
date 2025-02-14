/*=============================================================================
   Nombre         : co_cierre_web.h
   Programa       : Libreria del co_cierre_web.pc
   Autor          : G.A.C.
   Fecha Creacion : 07 - Septiembre - 2005
   Proyecto       : P-CO-05018 Pago de Saldo Potspago a través de WEB
  ============================================================================= */
#define SQLERRM		sqlca.sqlerrm.sqlerrmc
#define SQLROWS		sqlca.sqlerrd[2]
#define MAX_ARRAY    30000
#define iNIVEL_DEF   3

char szhVersion[] = "v.1.0.0";

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

char szFilePac      [60]  = "" ;
char szArchivo      [32]  = "" ;
char szPathDat      [128] = "" ;

/*---------------------------------------------------------------------------*/
/* PROTOTIPOS DE FUNCIONES                                                   */
/*---------------------------------------------------------------------------*/
int ifnValidaParametros( int argc, char *argv[], CONFIGLOCAL *pstLC );
int ifnConexionDB( CONFIGLOCAL pstLC);
int ifnInicio (CONFIGLOCAL pstConfig);
int ifnAbreArchivosLog();
int ifnExitcierreWeb (void);
int ifnGeneraCierreWeb();
int ifnUpdateColasProc(char *pszEstado);
int RighTrim (char *szVar);
void Strcpysub(char *str1, int Largo, char *str2);
int HoraToSegs(char *HoraFmto);
int ifnRestaHoras( char *h1, char *h2, char *hh);

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
