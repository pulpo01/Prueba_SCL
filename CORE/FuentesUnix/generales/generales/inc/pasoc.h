/****************************************************************************/
/* Funcion    : pasoc.h                                                     */
/* Descripcion: libreria para la declaracion de estructuras, variables y    */
/*              funciones para la ejecucion del paso a Cobros.              */
/* Autor      : Javier Garcia Paredes                                       */
/* Fecha      : 15-07-97                                                    */
/****************************************************************************/

#ifndef _PASOC_H_
#define _PASOC_H_

#include <GenFA.h>
#include <genco.h>

typedef struct tagDATDOC        /* Identificacion de un Documento */
{
   int     iCodTipDocum    ;
   long    lCodAgente      ;
   char    szLetra      [2];
   int     iCodCentrEmi    ;
   long    lNumSecuenci    ;
   char    szDesPago   [41];
} DATDOC;

typedef struct tagDATPAG        /* Datos de un Pago */
{
   long    lCodCliente       ;
   double  dImpPago          ;
   char    szFecValor     [9];
   char    szNomUsu      [31];
   int     iCodForPago       ;
   int     iCodSisPago       ;
   int     iCodOriPago       ;
   int     iCodCauPago       ;
   char    szCodBanco     [4];
   char    szCodSucursal  [5];
   char    szCtaCorriente[15];
   char    szCodTipTarjeta[4];
   char    szNumTarjeta  [21];
} DATPAG;

typedef struct tagCobros 
{
   int     iCodTipDocum       ;
   long    lCodAgente         ;
   char    szLetra         [2];
   int     iCodCentremi       ;
   long    lNumSecuenci       ;
   int     iCodConcepto       ;
   int     iColumna           ;
   int     iCodProducto       ;
   double  dImporteDebe       ;
   double  dImporteHaber      ;
   int     iIndContado        ;
   int     iIndFacturado      ;
   char    szFecEfectividad[9];
   char    szFecVencimie   [9];
   char    szFecCaducida   [9];
   char    szFecAntiguedad [9];
   char    szFecPago       [9];
   int     iDiasVencimiento   ;
   long    lNumAbonado        ;
   long    lNumFolio          ;
   long    lNumCuota          ;
   int     iSecCuota          ;
   long    lNumTransa         ;
   long    lNumVenta          ;
}COBROS; 

typedef struct tagConfig
{
  char szUsuario       [31];
  char szPassWord      [31];
  int  iCodTipDocum        ;
  int  iNivelLog           ;
  char szIndOrdenTotal [13];
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptCodTipDocum     ;
  BOOL bOptIndOrdenTotal   ;
  BOOL bOptNivelLog        ;
  BOOL bOptMaxivo          ;
  BOOL bOptUnico           ;
}CONFIG;

typedef struct tagRegFactCobr
{
  int  iCodConcFact;
  int  iCodConcCobr;
}REGFACTCOBR;

/*
typedef struct tagFactCobr
{
  int          iNumReg;
  REGFACTCOBR *pFacCob;
}FACTCOBR;
*/

void vfnTonta(FACTCOBR *);

typedef struct tagConcCobr
{
  int    iCodConcCobr;
  int    iIndFactur  ;
  double dImpConcCobr;
  long   lSeqCuotas  ; 
  int    iOrdCuota   ;
}CONCCOBR;

typedef struct tagAboCobr
{
  long      lNumAbonado  ;
  int       iCodProducto ;
  int       iNumConceptos;
  CONCCOBR *pConcCobr    ;
}ABOCOBR;

typedef struct tagAcumAbo
{
  int       iNumReg ;
  ABOCOBR  *pAboCobr;
}ACUMABO;

#define iNIVEL_DEF    3 /* Nivel de Log por defecto */
#define DIR_PASOCOB "/proyectos/startel/factura/unix/tmp/tmp_pc/"

#undef access

#ifdef _PASOC_PC_
#define access
static BOOL bfnInitPasoCobros  (CONFIG     stConfig,
                                STATUS    *stStatus)   ;
static BOOL bfnExitPasoCobros  (void)                  ;
static BOOL bfnPasoCobros      (CONFIG)                ;

static BOOL bfnDBCargaFactCobr (FACTCOBR  *pstFactCobr);
static int  ifnDBOpenHistDocu  (CONFIG     stConfig)   ;
static int  ifnDBFetchHistDocu (CONFIG     stConfig,
                                HISTDOCU  *pstHistDocu);
static int  ifnDBCloseHistDocu (CONFIG     stConfig)   ;


static int  ifnDBOpenHistConc  (char      *szIndOrdenTotal);
static int  ifnDBFetchHistConc (HISTCONC  *pstHistConc,int);
static int  ifnDBCloseHistConc (void)                      ;

static BOOL bfnAcumulaAboProd  (int        iNumRef        ,
                                HISTCONC  *stHistConc     ,
                                ACUMABO   *pstAcumAbo     ,
                                FACTCOBR  *) ;

static BOOL bfnDBCargaHistConc (char      *szIndOrdenTotal,
                                HISTCONCP *pstHistConcP   ,
                                ACUMABO   *pstAcumAbo     ,
                                FACTCOBR  *);

static BOOL bfnGetCobros       (DATCON    *pstCobros ,
                                int        iCodAbono ,
                                ABOCOBR    stAboCobr ,
                                CONCCOBR   stConcCobr,
                                HISTDOCU   stHistDocu) ;
static BOOL bfnDBUpdateHistDocu (HISTDOCU  stHistDocu) ;

static BOOL vfnPrintAcumAbo     (ACUMABO  *pstAcumAbo) ;
static void vfnFreeAcumAbo      (ACUMABO  *pstAcumAbo) ;
static BOOL bfnPagado (DATDOC *, DATPAG *, DATCON *)   ;
static BOOL bfnDBInsertPagos (DATDOC *, DATPAG *,char*);
static BOOL bfnDBInsertPagosConc (DATDOC, DATCON)      ;
static BOOL bfnDBInsertCancelados(DATCON, long)        ;
#else
#endif

#endif /* _PASOC_H_ */


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

