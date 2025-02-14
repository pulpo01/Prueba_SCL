/* ***********************************************
Nombre : PlanDcto.h
Autor  : Guido Antio Cares
*********************************************** */
#ifndef _DESCUENTOS_H_
#define _DESCUENTOS_H_

/* Librerias                        */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <GenFA.h>
#include <trazafact.h>
#include <geora.h>


#define     MAX_REGISTROS       2000
#define     UNIDADMINUTOS       "MI"
#define     MONTOFACTURA        "MT"
#define     CANTIDADABONADOS    "CA"
#define     ANTIGUEDADCLIENTE   "AN"
#define     CONCEPTOBLIGADO     "1"
#define     CONCEPTONOBLIGADO   "0"
#define     PORCONCEPTO         "C"
#define     PORFACTURA          "F"
#define     TIPOPORCENTAJE      "P"
#define     TIPOMONTO           "M"
#define     TIPOENTGRUPO        "G"
#define     TIPOENTABONA        "A"
#define     TIPOENTCLIEN        "C"

/*********************** INICIO CJG PLANDCTO DINAMICO**********************/
#define     MAX_PLANES          50
/*********************** FIN CJG PLANDCTO DINAMICO**********************/
#define     NUM_VERSION         "1.0"
#define     FECHA_VERSION       "05-04-2004"


/****************************************************************/
/* Estructuras                                                  */
/****************************************************************/
typedef struct tagPLANDCTO
{
    char   szDes_Plandesc      [31];
    char   szFec_DesdePlandesc [15];
    char   szFec_HastaPlandesc [15];
    char   szInd_Restriccion   [2] ;
    char   szFec_DesdeDetplan  [15];
    char   szFec_HastaDetplan  [15];
    char   szCod_Tipeval       [2] ;
    char   szCod_Tipapli       [2] ;
    int    iCod_Grupoeval          ;
    int    iCod_Grupoapli          ;
    int    iNum_Cuadrante          ;
    char   szTip_Unidad        [3] ;
    int    iCod_Concdesc           ;
    double dMto_Minfact            ;
    long   lNumSecuencia           ;
    int    iCodEstado              ;
}PLANDCTO;

/****************************************************************/
typedef struct tagPLANDESC
{
    char        szCod_Plandesc[6]       ;
    int         iCodEstado              ;
    char        szTipEntidad  [6]       ;
    PLANDCTO    stPD                    ;
}PLANDESC;

typedef struct tagREGPLANABO
{
    long        lNumAbonado             ;
    int         iNumPlanes              ;
    PLANDESC    stPlanDes[MAX_PLANES]   ;
}REGPLANABO;

typedef struct tagREGPLANES
{
    long         lNumAbonados            ;/*int         iNumAbonados            ;*/
    REGPLANABO  *stAbonado;
}REGPLANES;



typedef struct tagPLANDESCABO_HOSTS
{
    long     lNumSecuencia [TAM_HOSTS_PEQ];
    long     lNumAbonado   [TAM_HOSTS_PEQ];
    char     szCod_Plandesc[TAM_HOSTS_PEQ][6] ;
    char     szTipEntidad  [TAM_HOSTS_PEQ][6] ;
}PLANDESCABO_HOSTS;

typedef struct tagPLANDESCABO_NULL
{
    short     sszTipEntidad  [TAM_HOSTS_PEQ];
}PLANDESCABO_HOSTS_NULL;

/*********************** FIN CJG PLANDCTO DINAMICO**********************/



/****************************************************************/
typedef struct tagCONCEVAL
{
    int    iCod_Grupo              ;
    int    iCod_Concepto           ;
    char   szFec_DesdeConceval [15];
    char   szFec_HastaConceval [15];
    char   szInd_Obliga        [2] ;
    double dMto_MinFact            ;
}CONCEVAL;

typedef struct tagGRUPOCONCEVAL
{
    int        iNumEval ;
    CONCEVAL   stRegistro[MAX_REGISTROS];
}GRUPOCONCEVAL;


/****************************************************************/
/****************************************************************/
typedef struct tagCONCAPLI
{
    int         iCod_Grupo              ;
    int         iCod_Concepto           ;
    char        szFec_DesdeConcapli [15];
    char        szFec_HastaConcapli [15];
    int         iCod_ConRel             ;
}CONCAPLI;

/* P-MIX-09003 */
typedef struct tagCONAPLI
{
    int         iFlagExiste;
    int         iCod_ConRel;
}CONAPLI;
/* P-MIX-09003 */

typedef struct tagGRUPOCONAPLI
{
    int        iNumAplica ;
    CONCAPLI   stRegistro[MAX_REGISTROS];
}GRUPOCONAPLI;

/****************************************************************/
/****************************************************************/
typedef struct tagCUADRANDESC
{
    int    iNum_Cuadrante        ;
    double dVal_Desde            ;
    double dVal_Hasta            ;
    char   szFec_DesdeCuadra [15];
    char   szFec_HastaCuadra [15];
    char   szTip_Descuento   [2] ;
    double dVal_Descuento        ;
    char   szTip_Moneda      [3] ;
}CUADRANDESC;

typedef struct tagGRUPOCUADRANTE
{
    int          iNumCuadrantes ;
    CUADRANDESC  stRegistro[MAX_REGISTROS];
}GRUPOCUADRANTE;


typedef struct tagVALORDESCUENTO
{
    int    iNum_Cuadrante        ;
    int    iCod_Concepto         ;
    char   szDescConcepto    [61];
    double dVal_Desde            ;
    double dVal_Hasta            ;
    char   szFec_DesdeCuadra [15];
    char   szFec_HastaCuadra [15];
    char   szTip_Descuento   [2] ;
    double dVal_Descuento        ;
    char   szTip_Moneda      [3] ;
    double dValor_Monto          ;
    long   lNumAbonado           ;
    long   lNumSecuencia         ;
    int    iPosPrefac            ;
}VALORDESCUENTO;

typedef struct tagVALORESDCTOS
{
    int             iNumDescuentos ;
    /*VALORDESCUENTO  stDescuentos[MAX_PLANES*NUM_ABONADOS_CLIENTE];*/ /* P-MIX-09003 */
    VALORDESCUENTO  *stDescuentos; /* P-MIX-09003 */
}DESCUENTOS;


/****************************************************************/
/****************************************************************/
typedef struct tagABONADOSGRUPO
{
    long         lNumAbonado ;
    long         lNumSecuencia ; /* CH-151020031403 - EL numero de Secuencia DEBE IR a nivel de GRUPO abonado... */
}ABONADOSGRUPO;

typedef struct tagPLANGRUPO
{
    char            szCod_Plandesc [6];
    PLANDCTO        stPD;
    long            lTotUnidad;
    double          dTotMonto ;
    int             iNumAbonados;
    ABONADOSGRUPO   stAbonadosGrupo[NUM_ABONADOS_CLIENTE];
}PLANGRUPO;

typedef struct tagPLANESGRUPALES
{
    int             iNumPlanesGrupo;
    PLANGRUPO       stPlanGrupo[MAX_PLANES];
}PLANESGRUPALES;

typedef struct tagPLANDCTOLOC
{
    char   szCodPlandesc   [6];
    int    iCodGrupoapli      ;
    int    iNumCuadrante      ;
    double dValorDcto         ;
    char   szTipDescuento  [3];
    long   lNumSecuencia      ;
    char   szTipEntidad    [6];
    int    iCodEstado         ;
}PLANDCTOLOC;

typedef struct tagPLANESLOCUTORIOS
{
    long            lNumRegs;
    PLANDCTOLOC     *stPlanLocutorio;
}PLANESLOCUTORIOS;

typedef struct tagPLANDCTOLOC_HOST
{
    char   szCodPlandesc   [TAM_HOSTS_PEQ][6];
    int    iCodGrupoapli   [TAM_HOSTS_PEQ]   ;
    int    iNumCuadrante   [TAM_HOSTS_PEQ]   ;
    double dValorDcto      [TAM_HOSTS_PEQ]   ;
    char   szTipDescuento  [TAM_HOSTS_PEQ][3];
    long   lNumSecuencia   [TAM_HOSTS_PEQ]   ;
    int    iCodEstado      [TAM_HOSTS_PEQ]   ;
    char   szTipEntidad    [TAM_HOSTS_PEQ][6];
}PLANDCTOLOC_HOST;

/****************************************************************/
/* declaracion de funciones */
#undef access
#ifdef _DESCUENTOS_PC_

/****************************************************************/
/*   Definiendo Variables y Estructuras Globales                */
/****************************************************************/
int             idxDesc ; /* Contador de descuentos generados   */
double          dAjuste= 0.0 ; /* Acumula el ajuste de monto    */
int             indGrupo; /* Indicador de Planes de Grupo       */

double          dTotalMontoPrefacDesc= 0.0;

DESCUENTOS      stValDesc;
REGPLANES       stPlanesDesc;
PLANESGRUPALES  stPlanesGrupo;

PLANESLOCUTORIOS stPlanesLoc;
CONAPLI          stApli[10000];

/****************************************************************/

/***************** Declaracion de Prototipos ********************/
#define access


#ifdef SQLNOTFOUND 
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND   1403    /* Ansi :100 ; Not ansi : 1403 */

static BOOL bfnCargaPlanDesc                   ( long lCliente);
static BOOL bfnCargaDatosPlan                  ( char *szFecParam,
                                                 PLANDCTO *pstPD,
                                                 char *szCod_Plandesc );
static BOOL bCargaConceptoEvalua               ( int iCod_Grupo,
                                                 char *szFecParam,
                                                 GRUPOCONCEVAL  *pstEval);
static BOOL bCargaConceptoAplica               ( int iCod_Grupo,
                                                 char *szFecParam,
                                                 GRUPOCONAPLI   *pstApli);
static BOOL bCargaCuadrante                    ( int iNum_Cuadrante,
                                                 char *szFecParam,
                                                 GRUPOCUADRANTE *pstCuadra);
static double dValidaMontoMinimo               ();
static double dActualizaDescuentos             ();
void   vPrintPlanDcto                          ( PLANDCTO *stPD);
static BOOL bEvaluaciondeConceptos             ( PLANDCTO *stPD,
                                                 GRUPOCONCEVAL *stEval,
                                                 double *dTotalfac,
                                                 char *szFecParam,
                                                 double dTotalMontoPrefactura);
static BOOL bAplicacionConceptos               ( long lNumAbonado,
                                                 PLANDCTO *stPD,
                                                 GRUPOCONAPLI *stApli,
                                                 VALORDESCUENTO *pstDescPaso,
                                                 char *szFecParam);
static BOOL bfnDescporConceptoAbonado          ( long lNumAbonado,
                                                 PLANDCTO *stPD,
                                                 char *szFecParam,
                                                 double dTotalMontoPrefactura);
static BOOL bfnDescporConceptoCliente          ( long lNumAbonado,
                                                 PLANDCTO *stPD,
                                                 char *szFecParam,
                                                 double dTotalMontoPrefactura );
static BOOL bfnDescporFacturaCliente           ( long lNumAbonado,
                                                 PLANDCTO *stPD,
                                                 char *szFecParam,
                                                 double dTotalMontoPrefactura);
static BOOL bAplicacionConceptosCliente        ( long lNumAbonado, long lNumAbonadoOrig,
                                                 PLANDCTO *stPD, GRUPOCONAPLI *stApli, 
                                                 VALORDESCUENTO *stDescuentos);
static BOOL bAplicacionConceptosFacturaCliente ( long lNumAbonado, PLANDCTO *stPD,
                                                 VALORDESCUENTO *stDescuentos, double dTotalMontoPrefactura );
static BOOL bValidacionDto                     ( VALORDESCUENTO *stValDesc);
static BOOL bCargaPreFactura                   ( int iNumConceptos, VALORDESCUENTO *pstDesc);
static BOOL bfnMarcaDcto                       ( long          lNumSecuencia);
static BOOL bModifBeneficios                   ( long          lNumSecuencia);
void   vfnPrintCuadrante                       ( VALORDESCUENTO *stDescuentos);
static BOOL bCalculaDescuento                  ( long          lNumAbonado, VALORDESCUENTO *pstValDesc,
                                                 GRUPOCUADRANTE *stCuadra, double        dTotalfac);
static BOOL bfnCargaPlanesGrupo                ( );
static BOOL bfnDescporGrupo                    ( char      *szFecParam, double    dTotalMontoPrefactura );
static BOOL bfnDescporConceptoGrupo            ( PLANDCTO  *stPD, PLANGRUPO *pstPlanGrupo, char *szFecParam, 
                                                 double dTotalMontoPrefactura);
static BOOL bfnEvaluaciondeConceptosGrupo      ( PLANDCTO  *stPD, GRUPOCONCEVAL *stEval, 
                                                 PLANGRUPO *pstPlanGrupo, char *szFecParam,
                                                 double    dTotalMontoPrefactura);                                          
static int ifnOraDeclararGatPlanDescAbo        ( long lCodCliente);
static int  ifnOraLeerGatPlanDescAbo           ( PLANDESCABO_HOSTS *pstGatPanDescAbo,
                                                 PLANDESCABO_HOSTS_NULL *pstGatPanDescAbo_Null,
                                                 long *plNumFilas);
static int ifnOraCerrarGatPlanDescAbo          ();

/* P-MIX-09003 */
static BOOL bfnCargaPlanDescLocutorio          ( long lCliente);
static int ifnOraDeclararFaDetDctoClieLoc      ( long lCodCliente);
static int  ifnOraLeerGatPlanDescClieLoc       ( PLANDCTOLOC_HOST *stDescLocHosts, long *plNumFilas);
static int ifnOraCerrarGatPlanDescClieLoc      ();
static BOOL bfnDescBolsasClieLoc               ( char *szFecParam);
static BOOL bfnDescporConceptoClieLoc          ( char *szFecParam);
static BOOL bGetConcAplicacion		       ( int iCod_Grupo, char *szFecParam);
static BOOL bValidaConcAplicacion              ( int piCodConcepto, int *piCodConcRel);
static BOOL bAplicacionConceptosClienteLoc     ( int iIndBolsa, long iIndPref, int iCodConcRel , PLANDCTOLOC *stPlanLocutorio);
/* P-MIX-09003 */
                                    
#else
#define access extern

extern BOOL bfnDescuentos (long lCliente,  char *szFecParam);

#endif /* _DESCUENTOS_PC_ */
#endif /* _DESCUENTOS_H_  */



/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FUENTES_UNIX/FyC/Facturacion/facturacion/inc/PlanDcto.h */
/** Identificador en PVCS                               : */
/**  SCL:A34.A-UNIX;des#2.3 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  des#2.3 */
/** Autor de la Revisión                                : */
/**  MWN70299 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  16-MAY-2004 20:47:40 */
/** Worksets ******************************************************************************/
/******************************************************************************************/

