/* ********************************************************************** */
/* *  Fichero : infctlciclo.h                                           * */
/* *  Autor : Mauricio Villagra                                         * */
/* *  Comentarios :                                                     * */
/* *  28-07-2000:   Informe de Facturación de Ciclo/Periodo             * */
/* *                                                                    * */
/* ********************************************************************** */

#ifndef _INFCTLFACTUR_H_
    #define _INFCTLFACTUR_H_
#endif /* _INFCTLFACTUR_H_ */



/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF                   3
#define     COD_INFORME_FAD_CTLINFOPARAM    1


/************************************************************************/
/*  Estados de Informes                                                 */
/************************************************************************/

#define     COD_INFORME_CONTROL_ACTIVO      1
#define     COD_INFORME_CONTROL_INACTIVO    0


/************************************************************************/
/*  VALORES MAXIMOS DE ESTRUCTURAS DE MEMORIA                           */
/************************************************************************/

#define     MAX_DOCUMENTOS_CONTROL      200000
#define     MAX_DOCTOS_CONTROL_FETCH      1000

#define     MAX_ABONADOS_CONTROL         10000
#define     MAX_ABONADOS_CONTROL_FETCH    1000

#define     MAX_CONCEPTOS_CONTROL        50000
#define     MAX_CONCEPTOS_CONTROL_FETCH   1000

#define     MAX_STATCLIENTES_CONTROL       200
#define     MAX_STATABONADOS_CONTROL       400
#define     MAX_STATCONCEPTOS_CONTROL      800

#define     MAX_REGPLAN_FAMILIAR          1000



/*********************************************
Estructura para recoger los datos por
la linea de comandos.     
**********************************************/
typedef struct PosConcFacLineaComando
{ 
    char    szUser   [50]   ;
    char    szPass   [50]   ;
    char    szDirLogs[256]  ;
    BOOL    bOptCiclico     ;
    BOOL    bOptNoCiclico   ;
    long    lCodCiclFact    ;
    long    lMesEmision     ;
    long    lAnoEmision     ;     
    int     iNivLog         ;
    int     iIndFacturacion ;
}PCF_LINEACOMANDO;


/*************************************************************
Estructura para Guardar Informacion de Un Documento 
**************************************************************/
typedef struct stDocumentos
{ 
    long    lIndOrdentotal  ;
    long    lCodCliente     ;
    long    lCodTipdocum    ;
    int     iIndFactur      ;
    int     iIndSupertel    ;
    long    lCodEmpresa     ;
    double  dTotFactura     ;
    char    szCodTipClie[3] ;
    char    szCodDespacho[6];
}FACTLDOC;

/***************************************************************************
Estructura para Guardar Informacion del Universo de Documentos a Analizar
***************************************************************************/
typedef struct stUnivDocumentos
{ 
    long        lNumDocumentos  ;
    FACTLDOC    stUnivDoctos [MAX_DOCUMENTOS_CONTROL];
}FADETDOCTOS;



/***********************************************
Estructura de Estadisticas a Nivel de Cliente 
************************************************/
typedef struct stEstatNivClie
{   
    int     iIndFactur      ;
    int     iIndSupertel    ;
    char    szCodTipClie[3] ;
    long    lCodTipdocum    ;
    char    szCodDespacho[6];
    double  dTotFactura     ;
    long    lNumClientes    ;
    long    lNumDoctos      ;
}STATCTLCLIE;



/***************************************************************************
Estructura para Guardar Informacion del Universo de Clientes a Analizar
***************************************************************************/
typedef struct stUnivClientes
{ 
    long        lNumStadisticas;
    STATCTLCLIE stUnivClie  [MAX_STATCLIENTES_CONTROL];
}FACTLINFCLIENTES;



/***********************************************
Estructura de Abonado Facturado 
************************************************/
typedef struct stAbonados
{   
    long    lNumAbonados    ;
    int     iCodProducto    ;
    double  dTotCargosMes   ;
}FACTLABON;


/***************************************************************************
Estructura de Informacion de Abonados Facturados por Documento
***************************************************************************/
typedef struct stUnivAbonados
{ 
    long        lNumAbonados;
    FACTLABON   stUnivAbon [MAX_ABONADOS_CONTROL];
}FADETABONADOS;


/***********************************************
Estructura de Estadisticas a Nivel de Abonado
************************************************/
typedef struct stEstatNivAbon
{   
    int     iIndFactur      ;
    int     iIndSupertel    ;
    char    szCodTipClie[3] ;
    long    lCodTipdocum    ;
    char    szCodDespacho[6];
    int     iCodProducto    ;
    double  dTotCargosMes   ;
    long    lNumAbonados    ;
}STATCTLABON;



/***************************************************************************
Estructura para Guardar Informacion de Estadisticas de Abonados 
***************************************************************************/
typedef struct stStatAbonados
{ 
    long        lNumStadisticas;
    STATCTLABON stUnivStatAbon  [MAX_STATABONADOS_CONTROL];
}FACTLINFABONADOS;




/***********************************************
Estructura de Conceptos Facturados
************************************************/
typedef struct stConceptos
{   
    int     iCodConcepto    ;
    int     iCodProducto    ;
    long    lCodCiclFact    ;
    long    lNumConceptos   ;
    double  dImpFacturable  ;
    long    lSegConsumido   ;
}FACTLCONC;




/***************************************************************************
Estructura de Informacion de Conceptos Facturados por Documento
***************************************************************************/
typedef struct stUnivConceptos
{ 
    long        lNumConceptos;
    FACTLCONC   stUnivConc      [MAX_CONCEPTOS_CONTROL];
}FADETCONCEPTOS;




/***********************************************
Estructura de Estadisticas a Nivel de Concepto
************************************************/
typedef struct stEstatNivConc
{   
    int     iIndFactur      ;
    int     iIndSupertel    ;
    char    szCodTipClie[3] ;
    long    lCodTipdocum    ;
    char    szCodDespacho[6];
    long    lCodCiclFact    ;
    int     iCodProducto    ;
    int     iCodConcepto    ;
    long    lNumConceptos   ;
    double  dImpFacturable  ;
    long    lSegConsumido   ;
}STATCTLCONC;



/***************************************************************************
Estructura para Guardar Informacion de Estadisticas de Conceptos
***************************************************************************/
typedef struct stStatConceptos
{ 
    long        lNumStadisticas;
    STATCTLCONC stUnivStatConc  [MAX_STATCONCEPTOS_CONTROL];
}FACTLINFCONCEPTOS;



/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

PCF_LINEACOMANDO        stLineaComando          ;

FADETDOCTOS             stDetCtlInfDoctos       ;
FADETABONADOS           stDetCtlInfAbon         ;
FADETCONCEPTOS          stDetCtlInfConc         ;

FACTLINFCLIENTES        stCtlInfCliente         ;
FACTLINFABONADOS        stCtlInfAbonados        ;
FACTLINFCONCEPTOS       stCtlInfConceptos       ;

char                    szExeInfCtlFactur[1024] ;

char                    szCodPlanTarifFamiliar[MAX_REGPLAN_FAMILIAR][4];

int                     iNumRegPlanFamiliar     ;

char                    szCodInformeGenerar  [7];
long                    lhNumSecuenciaInforme   ;

int                     igPagina;

CICLO                   pstCiclo;


#undef access

#ifdef _INFCTLFACTUR_PC_
    #define access
#else
    #define access extern
#endif
/****************************************************************************/
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/

access BOOL bMainReporte           ();

access BOOL bfnGetSecuInfo         ();

access BOOL bfnCargaDoctos         (); 

access BOOL bfnCargaPlanFamiliar   ();

access BOOL bfnEstadoProcCiclo     (int* );

access BOOL bfnStatClientes        ();

access BOOL bfnInsertStatClientes  ();

access BOOL bfnValTipClie          (long , char * );

access void vPrintStClientes       ();

access BOOL bfnStatAbonados        ();

access BOOL bfnCargaAbonados       (FACTLDOC , FADETABONADOS *);

access BOOL bfnInsertStatAbonados  ();

access void vPrintStAbonados       ();

access BOOL bfnStatConceptos       ();

access BOOL bfnCargaConceptos      (FACTLDOC , FADETCONCEPTOS *);

access void vPrintStConceptos      ();

access BOOL bfnInsertStatConceptos ();

access BOOL bfnGetScuInfo          ();

access BOOL bfnInsertHeaderInfCtl  ();
    
#undef access
#undef _INFCTLFACTUR_PC_


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

