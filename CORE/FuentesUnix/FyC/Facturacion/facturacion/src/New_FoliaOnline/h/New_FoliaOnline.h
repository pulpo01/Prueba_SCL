/* *********************************************************************** */
/* *  Fichero  : foliacion.h                                             * */
/* *  					                        	 * */
/* *                                                                     * */
/* *********************************************************************** */

/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF                     3
#define     iINDANULACION_CONSUMO             0
#define     iINDANULACION_ANULA               1
#define     iPROCESO_INT_FOLIACION_ONLINE   430
#define     MAX_FOLIOS_LOCAL              30000

/*********************************************
Estructura para recoger los datos por 
la linea de comandos.     
**********************************************/
typedef struct LineaComandoFoliacion
{
    char    szUsuarioOra    [64]    ;
    char    szOraAccount    [32]    ;
    char    szOraPasswd     [32]    ;

    char    szCodModGener   [4]     ;		/* Cod_ModGener de la Cola */
     int    iNivLog                 ;

    char    szDirLogs       [1024]  ;       /*  Directorio de Archivos Log's y Err      */
    char    szDirDats       [1024]  ;       /*  Directorio de Archivos de Datos Dat     */
    char    szDataName      [1024]  ;       /*  Nombre del Archivo de Datos de Folios   */
    FILE    *DataFile               ;       /*  Puntero de Archivo de Datos (Folios)    */
}FOLIACIONLINEACOMANDO;

/*****************************************************
Estructura para almacenar datos de facturas a Foliar
*****************************************************/
typedef struct RegistroFacturFolio
{                            
        long  lNumFolio    [MAX_FOLIOS_LOCAL];
	long  lNumProceso  [MAX_FOLIOS_LOCAL];
	char  szPrefPlaza  [MAX_FOLIOS_LOCAL] [25+1];
	int   iCodTipDocum [MAX_FOLIOS_LOCAL];
	long  lNumVenta    [MAX_FOLIOS_LOCAL];
	int   CantidadConceptos;
}FOLIACIONREGINTERFAZ;    

/***********************************************************
Estructura para almacenar datos de AL_CONSUMO_DOCUMENTOS 
***********************************************************/
typedef struct RegistroAlConDocum
{   
    char    szCodOficina  [2]   ;
    long    lCodTipDocum        ;
    long    lNumFolio           ;
    char    szUsuario     [30]  ;
    char    szFecConsumo  [20]  ;
    char    szIndConsumo  [1]   ;
    short   i_sIndConsumo       ;
    int     iIndAnulacion       ;
}FOLIACIONALCONSUDOCUM;    

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

FOLIACIONLINEACOMANDO     stLineaComando      ;

FOLIACIONREGINTERFAZ      stRegDocumFoli      ;
 
FOLIACIONALCONSUDOCUM     stRegAlConDoc       ;

/************************************************************************/

#undef access

#ifdef _FOLIACION_PC_
#define access
access BOOL bfnValidaParametros             ( int argc, char *argv[], FOLIACIONLINEACOMANDO *pstLineaCom );
access BOOL bfnAbreArchivos                 ( FOLIACIONLINEACOMANDO *pstLineaCom, char *szDate);
access BOOL bfnFoliacionOnline              ( FOLIACIONLINEACOMANDO *pstLineaCom, FOLIACIONREGINTERFAZ *stRegDocumFoli, 
                                              char *szOperadora);
access BOOL bfnOpenInterfaz                 ( INTQUEUEPROC stIntQueueProc, int iCodEstProc,
                                              char *szOperadora);
access int ifnFetchInterfaz                 ( FOLIACIONREGINTERFAZ *pstRegDocumFoli, int i, char *szOperadora);
access BOOL bfnUpdateFolios                 ( FOLIACIONREGINTERFAZ *pstRegDocumFoli,char *szOraUser, int *iFol, int i);
access BOOL bfnConsumeFolios                ( FOLIACIONREGINTERFAZ *pstRegDocumFoli,char *szOraUser, int *iFol, int i);
access int iObtienefolio                    ( char *pszPrefPlaza , long *pszlFolio, 
                                              char *pszFolio     , int  iCodTipDocum, 
                                              char *szCodOficina , char *szCodOperadora, 
                                              long lNumVenta     , long lNumProceso,
                                              char *pszResolucion, char *pszSerie,
                                              char *pszEtiqueta  , char *pszFecResolucion,
                                              long *pszlRanDesde , long *pszlRanHasta);                                                                                
access BOOL bfnUpdateDocuNoCiclo            ( int iCodTipDocum, long lNumVenta	, long lNumProceso);
access BOOL bfnUpdateFactDocuNoCiclo        ( long lNumFolio, char *szPrefPlaza, long lNumProceso);
access BOOL bfnCargaOficinaAlAsigDocumento  ( long lFolio, long lTipDocum,
                                              char *szCodOperadora,
                                              char *szPrefPlaza,
                                              char *szCodOficina,
                                              char *szResolucion,
                                              char *szFecResolucion,
                                              char *szSerie,
                                              char *szEtiqueta,
                                              long *lRanDesde,
                                              long *lRanHasta);
access BOOL bfnCloseInterfaz                ( char *szOperadora );
access BOOL bfnObtieneOperadora             ( char *szOperadora ); /* P-MIX-09003 */
extern BOOL bfnEncriptaContTec              ( char *, char *, long, char *, char *, double, double, char *, char *, char *, char * );
extern BOOL EncriptarSHA1                   ( char *, char *);

#else
#define access extern
#endif


#undef access
#undef _FOLIACION_PC_

/* RBR here */

static char szUsage[]= "\n\tUso: New_FoliaOnline Opciones           "
                       "\n                                          "
                       "\n\tOpciones:                               "
                       "\n                                          "
                       "\n\t\t-e  Cod_ModGener                      "
                       "\n\t\t-u 'Usuario/Password' o '/' (Opcional)"
                       "\n\t\t-l  Nivel Log (Opcional)              "
                       "\n                                          ";

