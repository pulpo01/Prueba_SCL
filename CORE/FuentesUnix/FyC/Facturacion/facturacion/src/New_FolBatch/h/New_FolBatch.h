/* *********************************************************************** */
/* *  Fichero : foliacion.h                                              * */
/* *                                                                     * */
/* *  Autor : Mauricio Villagra V.                                       * */
/* *********************************************************************** */


/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/



#define     iLOGNIVEL_DEF               3

#define     iPROCESO_ANULAR             1
#define     iPROCESO_CONSUMIR           2
#define     iPROCESO_REPORTE            3

#define     iINDANULACION_CONSUMO       0
#define     iINDANULACION_ANULA         1

#define     lCODTIPDOCUM_BOLETAAUTO     69
#define     lCODTIPDOCUM_BOLETAAUTOEXEN 73

#define	    iPROC_AUTOFOLIACION		5500

/***************************************************************************/
/*   Codigo de retorno función PL de foliación                             */
/***************************************************************************/
#define     cSEPARADOR_COMA ';'
#define     G_NESTADO_DISPONIBLE        1  /* Folio Disponible                                   */
#define     G_NESTADO_CONSUMIDO         2  /* Folio Consumido                                    */
#define     G_NESTADO_ANULADO           3  /* Folio Anulado                                      */
#define     G_NESTADO_FOLIONOENC        4  /* Folio No encontrado                                */
#define     G_NMUCHAS_FILAS             5  /* Se encontro mas de un rango para key entregada     */
#define     G_NESTADO_INDEFINIDO        6  /* Estado Indefinido                                  */
#define     G_NRANGO_CONSUMIDO          7  /* Rango Consumido                                    */
#define     G_NFOLIO_NOCONSUMIDO        8  /* Folio No consumido                                 */
#define     G_NFALTA_PARAM              9  /* Falta Parametro                                    */
#define     G_NFOLIOS_NOCOINCIDEN       10 /* Debe Ingresar valores en los parametros de entrada */
#define     G_NFALTA_VENDOFIC           10 /* Oficina o vendedor                                 */

/************************************************/
/*Estructura para recoger los datos por      	*/
/*la linea de comandos.			     	*/
/************************************************/
typedef struct LineaComandoFoliacion
{
    char    szUser           [50];
    char    szUsuario        [63];
    char    szPass           [50];
    char    szDirLogs      [1024]; /*  Directorio de Archivos Log's y Err    */
    char    szDirDats      [1024]; /*  Directorio de Archivos de Datos Dat   */
    char    szDataName     [1024]; /*  Nombre del Archivo de Datos de Folios */
    FILE    *DataFile            ; /*  Puntero de Archivo de Datos (Folios)  */
    char    szOpcion          [1]; /*  Anular, Consumir o Reporte  [A/C/R]   */
     int    iOpcion              ;
    BOOL    bOptUsuario          ;
    BOOL    bOptCiclo            ;
    BOOL    bOptHelp             ;
    long    lTipoDocumen         ;
    long    lCodCiclFact         ;
    long    lClienteIni          ;
    long    lFolioIni            ;
    long    lCantidad            ;
    char    szFecFoli         [9];
     int    iNivLog              ;
    char    szCodModGener     [4];
    char    szCodigoOperadora [6];
    char    szPrefijoFolio   [11];
    long    lClienteFin          ;
    BOOL    bIngRngClientes      ;
    char    szHostId[25]         ;
}FOLIACIONLINEACOMANDO;


/******************************************************/
/*Estructura para almacenar datos de facturas a Foliar*/
/******************************************************/
typedef struct RegistroFacturFolio
{
    char    szhRowid        [20];
    long    lhCodCliente        ;
    long    lhIndOrdenTotal     ;
    double  dhTotFactura        ;
    char    szhFecEmision   [20];
    char    szhHorEmision   [20];    
    int     ihCodCentrEmi       ;
    long    lhCodTipDocum       ;
    long    lhNumProceso        ;
    double  dhTotCargosMe       ; 
    double  dhAcumIva           ; 
    char    szhCodIdTipDian  [3]; 
    char    szhNumIdTrib    [21]; 
}FOLIACIONREGDOCUM;

/* rao */
typedef struct tagFolios
{
    int               iNumReg     ;
    FOLIACIONREGDOCUM *stRegFolio ;
} DOCUMFOLIOS;


/************************************************************/
/*Estructura para almacenar datos de AL_CONSUMO_DOCUMENTOS  */
/************************************************************/
typedef struct RegistroAlConDocum
{
    char    szCodOficina   [3];
    long    lCodTipDocum      ;
    long    lNumFolio         ;
    char    szUsuario     [31];
    char    szFecConsumo  [21];
    char    szIndConsumo   [2];
    short   i_sIndConsumo     ;
    int     iIndAnulacion     ;
    long    lCodVendedor      ;

}FOLIACIONALCONSUDOCUM;


/***********************************************************/
/*Estructura Auxiliar para almacenar datos                 */
/***********************************************************/
typedef struct RegistroAuxiliar
{
    char    szCodOficina  [3];
    long    lCodTipDocum     ;
    long    lRanDesde        ;
    long    lCodVendedor     ;

}FOLIACIONAUXILIAR;


/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

FOLIACIONLINEACOMANDO stLineaComando    ;

DOCUMFOLIOS           stRegDocumFoli    ;

FOLIACIONALCONSUDOCUM stRegAlConDoc     ;

FOLIACIONAUXILIAR     stRegAuxiliar     ;

char                  szFoliacion [1024];

/************************************************************************/

#undef access

#ifdef _FOLIACION_PC_
#define access
#else
#define access extern
#endif

BOOL bfnAnularFolio                 (long   lTipDocum
                                    ,long   lFolIni
                                    ,long   lCant
                                    ,long   lCodCiclFact
                                    ,char   *szCodigoOperadora
                                    ,char   *szPrefijoFolio
                                    );

BOOL bfnFoliacion                   (long   lTipDocum
                                    ,long   lClieIni
                                    ,long   lFolIni
                                    ,long   lCant
                                    ,int    iOpcion
                                    ,char   *szCodModGener
                                    ,BOOL   bpOptCiclo
                                    ,long   lCodCiclFact
                                    ,char   *szCodigoOperadora
                                    ,char   *szPrefijoFolio
                                    ,long   lClieFin);
BOOL bfnValidaParams                (FOLIACIONLINEACOMANDO *pstLineaCom);
BOOL bfnOpenDocumFoli               (long   lTipoDocumen
                                    ,long   lCodClieIni
                                    ,int    iCodEstaDocEnt
                                    ,int    iCodEstProc
                                    ,char   *szModGen
                                    ,BOOL   bpOptCiclo
                                    ,long   lCodCiclFact
                                    ,char *psTipoFoliacion
                                    ,long   lCodClieFin);
BOOL bfnFetchDocumFoli              (FOLIACIONREGDOCUM *pstRegDocumFoli)    ;
BOOL bfnCloseDocumFoli              ();
BOOL bfnUpdateFolio                 (FOLIACIONREGDOCUM *pstRegDocumFoli
                                    ,long   lFolUpd
                                    ,BOOL   bpOptCiclo
                                    ,int    iNumFoli
                                    ,char   *sCod_oper
                                    ,char   *szPrefijo_in
                                    );
BOOL bfnPrintFolio                  (FOLIACIONREGDOCUM *pstRegDocumFoli,long   lFolUpd);
BOOL bfnCargaOficinaAlAsigDocumento (long lFolio, long lTip_Docum, char *szCodOficina, char *szPrefPlaza);
BOOL bfnUpdateInterfaz              (long   lEstaDoc,long   lEstProc,char   *szRowid);
BOOL bfbFinFoliacion                (long   lhCodCiclFact, int iExisteRango, long lClieIni, long lClieFin);
BOOL bfnValidaFolioIngreso          (FOLIACIONLINEACOMANDO stLineaComando
                                    ,FOLIACIONAUXILIAR *pstRegAuxiliar);
BOOL bfnGetTipoFoliacion            (int lCod_Tipodocumen,char *szinTIpoFoliacion );
int ifnObtieneParam                 ();
char * bfnObtOficEmis               (long  lCodCliente,  char *Operadora, char *Cod_OficinaEmis);

#undef access
#undef _FOLIACION_PC_

/* Definicion de los mensajes de la Ayuda */

static char szUsage[] =     "\n\t Uso: New_FolBatch Opciones"
                            "\n\n\t OPCIONES :"
                            "\n\t\t -a Accion a Realizar [A/C/R]    - Necesario - "
                            "\n\t\t    Ejemplos:   -aA : Anular folios  "
                            "\n\t\t                -aC : Consumir folios "
                            "\n\t\t                -aR : generar Reporte sin consumir folios "
                            "\n\n\t EL RESTO DE LAS OPCIONES SON DEPENDIENTES DE LA ACCION "
                            "\n\n\t PARA OBTENER MAS AYUDA => 'New_FolBatch -hh -a[A/C/R]'"
                            "\n" ;

static char szUsAnular[] =  "\n\t Uso: New_FolBatch -aA Opciones"
                            "\n\n\t OPCIONES :"
                            "\n\t\t -aA : Anular folios"
                            "\n\t\t       -f Numero de Folio Inicial         Ej. : -f10000 "
                            "\n\t\t       -g Cantidad de Folios a Anular     Ej. : -g14"
                            "\n\t\t       -t Cod_TipDocum                    Ej. : -t2, -t36, etc."
                            "\n\t\t       -d Fecha Anulacion (YYYYMMDD)      Ej. : -d20000118 (*)"
                            "\n\t\t       -p Prefijo de folio Inicial        Ej. : -pMTY "
                            "\n\t\t       -o Codigo de Operadora             Ej. : -oTMC "
                            "\n"
                            "\n\t\t       -u Usuario/password  - Opcional -  Default: -u/ "
                            "\n\t\t       -l nivel de Log      - Opcional -  Default: -l3 "
                            "\n"
                            "\n\t NOTA : La opcion '-d' va seguida de una fecha posterior a 01/01/1999 en formato 19990101 "
                            "\n" ;

static char szUsConsumo[] = "\n\t Uso: New_FolBatch -aC Opciones"
                            "\n\n\t OPCIONES :"
                            "\n\t\t -aC : Consumir folios"
                            "\n\t\t       -f Numero de Folio Inicial         Ej. : -f10000 "
                            "\n\t\t       -g Cantidad de Folios Consumir     Ej. : -g14"
                            "\n\t\t       -t Cod_TipDocum                    Ej. : -t2 , -t36 , etc."
                            "\n\t\t       -i Cod. Cliente Inicial            Ej. : -i21554 "
                            "\n\t\t       -p Prefijo de folio Inicial        Ej. : -pMTY "
                            "\n\t\t       -o Codigo de Operadora             Ej. : -oTMC "
                            "\n"
                            "\n\t\t       -c Cod_CiclFact      - Opcional -  Ej. : -c50100"
                            "\n\t\t       -e Cod_ModGener      - Opcional -  Ej. : -e101"
                            "\n"
                            "\n\t\t       -u Usuario/password  - Opcional -  Default: -u/ "
                            "\n\t\t       -l nivel de Log      - Opcional -  Default: -l3 "
                            "\n"
                            "\n\t\t       -z Cliente_Final     - Opcional -  Ej. : -z2"
                            "\n"
                            "\n\t NOTAS: Las opciones '-c' y '-e' son mutuamente excluyentes. "
                            "\n\t        Es obligatorio incluir una (dependiendo si es o no ciclo)."
                            "\n\t        Si es un caso ciclico (-c) no se ingresa -f ni -p. "
                            "\n\t        Si es un caso no ciclico se ingresan las opciones -f y -p. "
                            "\n" ;

static char szUsReporte[] = "\n\tUso: New_FolBatch -aR Opciones"
                            "\n\n\t OPCIONES :"
                            "\n\t\t -aR : generar Reporte sin consumir folios"
                            "\n\t\t       -f Numero de Folio Inicial         Ej. : -f10000 "
                            "\n\t\t       -g Cantidad de Folios              Ej. : -g14"
                            "\n\t\t       -t Cod_TipDocum                    Ej. : -t2 , -t36 , etc."
                            "\n\t\t       -i Cod. Cliente Inicial            Ej. : -i21554 "
                            "\n\t\t       -p Prefijo de folio Inicial        Ej. : -pMTY "
                            "\n\t\t       -o Codigo de Operadora             Ej. : -oTMC "
                            "\n"
                            "\n\t\t       -c Cod_CiclFact      - Opcional -  Ej. : -c50100"
                            "\n\t\t       -e Cod_ModGener      - Opcional -  Ej. : -e101"
                            "\n"
                            "\n\t\t       -u Usuario/password  - Opcional -  Default: -u/ "
                            "\n\t\t       -l nivel de Log      - Opcional -  Default: -l3 "
                            "\n"
                            "\n\t NOTAS: Las opciones '-c' y '-e' son mutuamente excluyentes. "
                            "\n\t        Es obligatorio incluir una (dependiendo si es o no ciclo)."
                            "\n\t        Si se incluye '-c' es obligatorio incluir '-r', excepto para los Docum. autofoliados (69 y 73)."
                            "\n\t        Si es un caso ciclico (-c) no se ingresa -f ni -p. "
                            "\n\t        Si es un caso no ciclico se ingresan las opciones -f y -p. "
                            "\n" ;

extern int   RecupParam         ( int *, char *[], char *, int );
void         trim               ( const char *c, char *result );
extern BOOL  bfnEncriptaContTec ( char *, char *, long, char *, char *, double, double, char *, char *, char *, char * );
extern BOOL  EncriptarSHA1      ( char *, char * );

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
