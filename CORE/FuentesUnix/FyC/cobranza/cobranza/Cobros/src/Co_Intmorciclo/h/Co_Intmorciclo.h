/*==================================================================================
   Nombre      : Co_Intmorciclo.pc                                               
   Programa    : Libreria del proceso Co_Intmorciclo.pc                          
   Autor       : G.A.C.  
   Creado      : 22-Abril-2005 (COL)
   =================================================================================*/
#define SQLERRM		sqlca.sqlerrm.sqlerrmc
#define SQLROWS		sqlca.sqlerrd[2]
/*#define MAX_ARRAY    20000*/
#define MAX_ARRAY   40000
#define iNIVEL_DEF   3
#define iPROC_INTERMORO  2200  /* Proceso Previo a Generacion de Beneficios(2700)    */

/*char szhVersion[] = "v.2.0.0";   * P-MIX-09003 MAC todos moriran..*/ 
/*char szhVersion[] = "v.2.0.1";   * P-MIX-09003 Incidencia 140028 */ 
char szhVersion[] = "v.2.0.2";   /* Requerimiento de Soporte 159515 */ 

/* ============================================================================= */
/* Estructura tipo lista para numeros de pasocobros                              */
/* ============================================================================= */
struct INTERMORO
{
    long   lCod_cliente     ;
    long   lNum_secuenci    ;
    int    iCod_tipdocum    ;
    long   lNum_folio       ;
    int    iSec_cuota       ;
    double dMonto_pagar     ;
    char   szPref_plaza [26];
    char   szFec_Sydate [11];
    int    iCod_vendedor    ;
    int    iCod_centremi    ;
    int    iNum_cuota       ;
    char   szLetra       [2];

    struct INTERMORO *sig;
}; 
   
typedef struct INTERMORO *Lista_Pasoc;	

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
    char szFechaIniProc[15]  ;   
    long lClienteInicial     ;   
    long lClienteFinal       ;   
    BOOL bOptClienteInicial  ;   
    BOOL bOptClienteFinal    ;   
    int  iCodEstadoProc      ;   
}CONFIG;

CONFIG  stConfig;
STATUS  stStatus;

/*===================================================*/
/*Prototipos de funciones                            */
/*===================================================*/
int  ifnValidaProceso();
int  ifnValidaParametros( int argc, char *argv[], CONFIG *pstLC );
int  ifnConexionDB( CONFIG pstLC);
int  ifnInicio (CONFIG pstConfig);
int  ifnPreparaArchivoLog();
int  ifnAbreArchivoLog();
int  ifnExitIntmorciclo (void);
int  ifnInsertaPasoc(Lista_Pasoc *ant);
void vfnBorraListaPasoc(Lista_Pasoc *list);
int  ifnBorraPasoc(Lista_Pasoc *ant);
int  ifnRestaHoras( char *h1, char *h2, char *hh);
int  HoraToSegs(char *HoraFmto);
int  ifnCarga_Portadoras();
int  ifnValidaCicloFact();
int  ifnCargaListaQuery();
int  ifnIntmorciclo();
int  ifnGeneraCargos(long lSecuencia);
int  ifnObtieneMoneda();
int  ifnTrazaFacturacion();
int  ifnFinTrazaFacturacion();
BOOL bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza); 

long lgCodClienteIni;
long lgCodClienteFin;
int  igOpcionRango;
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
