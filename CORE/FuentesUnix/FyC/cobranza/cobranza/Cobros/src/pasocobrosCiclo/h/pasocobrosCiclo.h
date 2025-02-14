#ifndef NO_INDENT
#ident "@(#)$RCSfile: pasocobrosCiclo.h,v $ $Revision: 1.4 $ $Date: 2008/06/30 20:30:38 $"
#endif

/****************************************************************************/
/* Funcion    : pasocobros.h                                                */
/* Descripcion: libreria para la declaracion de estructuras, variables y    */
/*              funciones para la ejecucion del paso a Cobros.              */
/* Autor      : Javier Garcia Paredes                                       */
/* Fecha      : 15-07-97                                                    */
/****************************************************************************
23-12-2004 : Modificado por proyecto Mejoras Cancelacion de Credito
*****************************************************************************/

#ifndef _PASOC_H_
#define _PASOC_H_

/*#define szVERSION       "1.0.0"	  * Proyecto P-COL-08011 */
/*#define szVERSION       "1.0.1"	  * Requerimiento de Soporte - 69137 - 18.08.2008 */
#define szVERSION       "1.0.2"	  /* Requerimiento de Soporte - 72818 - 17.11.2008 */

#define iMAXHOST		    	10000	
#define iMAXARRAYWORK	   		300000 
#define szPREF_PLAZA_DEFAULT    "0000000000"   
#define CLEAR(x) memset(x,0x0,sizeof(x))

#define MAX_CONCFACTUR1 10  /* Requerimiento de Soporte - 41321 - 07.06.2007 */

#ifndef PROC
#include "ClassDbProc.h"
#include "memoryCob.h"
#include "CicloCobro.h"
#endif

using namespace std;

vector <estClientes> _vec_dcto_clientes;

NewtagAcumAbo _acumabo;

ClassDbProc _mydbProc;

modVenta _mod_Venta;
memoryCob _mymemCob;

vector <sec_cartera_s> _vec_sec_cartera;

typedef struct tagDATDOC		/* Identificacion de un Documento */
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
   int     iCodTipDocum      ; 
} DATPAG;

typedef struct tagDatosFact
{
	char szRowid[19];
	long lNumSecuenci;
	 int iCodTipDocum;
	long lCodVendedorAgente;
	char szLetra[2];
	 int iCodCentrEmi;
	long lCodCliente;
	char szFecEmision[9];
	char szIndOrdenTotal[13];
	 int iIndSuperTel;
	long lNumFolio;
	char szFecVencimie[9];
	char szFecCaducida[9];
	long lNumSecuRel;
	char szLetraRel[2];
	 int iCodTipDocumRel;
	long lCodVendedorAgenteRel;
	 int iCodCentrRel;
	long lNumVenta;
	long lNumTransaccion;
	char szNumCTC[13];
	 int iCodModVenta;
	double  dTotFactura;
	 int iIndFactur;
	 int iCodTipMovimie;
	long lNumProceso;
	 int iIndPasoCobro;
	 int iNumCuotas; 
	char szPrefPlaza[26];
	char szCodOperadoraScl[6]; 
	char szCodPlaza[6];        
	char szNomUsuarioORA[31];  
}DATOS_FACT;

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

typedef struct tagParam
{
  char szUsuario       [31];
  char szPassWord      [31];
  int  iCodTipDocum        ;
  long lCodCicloFact       ;
  int  iNivelLog           ;
  char szNumProceso    [13];
  char szCodModGener    [4];
  long lMaxArray           ;
  long lClienteIni         ;
  long lClienteFin         ;     
  bool bOptUsuario         ;
  bool bOptPassWord        ;
  bool bOptCodTipDocum     ;
  bool bOptCodCicloFact    ;
  bool bOptNumProceso      ;
  bool bOptNivelLog        ;
  bool bOptBatch           ;
  bool bOptUnico           ;
  bool bOptOnline          ;
  bool bOptCodModGener     ;
  bool bMaxArray           ;
  bool bClienteIni         ;
  bool bClienteFin         ;
}CONFIG;

typedef struct tagRegFactCobr
{
  int  iCodConcFact;
  int  iCodConcCobr;
}REGFACTCOBR;


typedef struct tagCoFactCobr
{
  /*int          iNumReg;   *//*Requerimiento de Soporte - 41321 - 07.06.2007 */
  long        iNumReg;
  REGFACTCOBR *pFacCob;
}COFACTCOBR;

void vfnTonta(COFACTCOBR *);

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
/***  int          iNumReg;   Requerimiento de Soporte - 41321 - 07.06.2007 */
  long      iNumReg;
  ABOCOBR  *pAboCobr;
}ACUMABO;

typedef struct ACUMDOCTOPASO
{
  char szRowid[19];
   int iIndPasoCobro;
  long lNumProcPasoCobro;
   int iCodEstaDocSal;
  long lNumProceso;
} TAcumDoctoPaso;

/* Inicio Requerimiento de Soporte - 41321 - 07.06.2007 */
typedef struct tagHistConcAux
{
    char   szIndOrdenTotal [MAX_CONCFACTUR1][13];
    int    iCodConcepto    [MAX_CONCFACTUR1]    ;
    char   szDesConcepto   [MAX_CONCFACTUR1][61];
    long   lColumna        [MAX_CONCFACTUR1]    ;
    short  iCodProducto    [MAX_CONCFACTUR1]    ;
    char   szCodMoneda     [MAX_CONCFACTUR1] [4];
    char   szFecValor      [MAX_CONCFACTUR1][15];
    char   szFecEfectividad[MAX_CONCFACTUR1][15];
    double dImpConcepto    [MAX_CONCFACTUR1]    ;
    double dImpMontoBase   [MAX_CONCFACTUR1]    ;
    long   lSegConsumido   [MAX_CONCFACTUR1]    ;
    char   szCodRegion     [MAX_CONCFACTUR1] [4];
    char   szCodProvincia  [MAX_CONCFACTUR1] [6];
    char   szCodCiudad     [MAX_CONCFACTUR1] [6];
    short  iIndFactur      [MAX_CONCFACTUR1]    ;
    double dImpFacturable  [MAX_CONCFACTUR1]    ;
    long   lNumUnidades    [MAX_CONCFACTUR1]    ;
    int    iCodTipConce    [MAX_CONCFACTUR1]    ;
    int    iCodConceRel    [MAX_CONCFACTUR1]    ;
    long   lColumnaRel     [MAX_CONCFACTUR1]    ;
    long   lNumAbonado     [MAX_CONCFACTUR1]    ;
    int    iCodPortador    [MAX_CONCFACTUR1]    ;
    long   lCodCliente     [MAX_CONCFACTUR1]    ;
    short  iIndSuperTel    [MAX_CONCFACTUR1]    ;
    char   szNumSerieMec   [MAX_CONCFACTUR1][26];
    char   szNumSerieLe    [MAX_CONCFACTUR1][26];
    short  iFlagImpues     [MAX_CONCFACTUR1]    ;
    short  iFlagDto        [MAX_CONCFACTUR1]    ;
    float  fPrcImpuesto    [MAX_CONCFACTUR1]    ;
    double dValDto         [MAX_CONCFACTUR1]    ;
    short  iTipDto         [MAX_CONCFACTUR1]    ;
    int    iMesGarantia    [MAX_CONCFACTUR1]    ;
    char   szNumGuia       [MAX_CONCFACTUR1][11];
    short  iIndAlta        [MAX_CONCFACTUR1]    ;
    int    iNumPaquete     [MAX_CONCFACTUR1]    ;
    long   lSeqCuotas      [MAX_CONCFACTUR1]    ;
    int    iNumCuotas      [MAX_CONCFACTUR1]    ;
    int    iOrdCuota       [MAX_CONCFACTUR1]    ;
    char   szCodPlanTarif  [MAX_CONCFACTUR1] [4];
    char   szCodCargoBasico[MAX_CONCFACTUR1] [4];
    char   szTipPlanTarif  [MAX_CONCFACTUR1] [2];
    double dhMtoReal       [MAX_CONCFACTUR1]    ;
    double dhMtoDcto       [MAX_CONCFACTUR1]    ;
    long   lhDurReal       [MAX_CONCFACTUR1]    ;
    long   lhDurDcto       [MAX_CONCFACTUR1]    ;
    long   lhCntLlamReal   [MAX_CONCFACTUR1]    ;
    long   lhCntLlamFact   [MAX_CONCFACTUR1]    ;
    long   lhCntLlamDcto   [MAX_CONCFACTUR1]    ;
    double dImpValunitario [MAX_CONCFACTUR1]    ; 
    char   szhGlsDescrip   [MAX_CONCFACTUR1][101];
    long   lNumVenta       [MAX_CONCFACTUR1]    ;
} HISTCONCAUX;

typedef struct tagHistConcPAux
{
    long           iNumReg     ;
    HISTCONCAUX    stHistConc  ;
}HISTCONCPAUX;
/* Fin Requerimiento de Soporte - 41321 - 07.06.2007 */

#define iTOTALFACTURA0	-3		/* Total factura igual a cero */
#define iNOEXISTECLIE	-4		/* Cliente no existe */
#define iDOCTOCONCEPNEG -5		/* Documento presenta conceptos negativos */
#define iDOCTOCONERROR	-6		/* Documento con error */
#define iDOCTOABONADOS	-7		/* Documento con error mas de 10000 abonados */
#define iDOCTOOK	     1      /* Documento procesado en forma exitosa */
#define iCNTDOCTOS	  5001	    
#define iTERMINAR	  	 1		
#define iNIVEL_DEF       3 		/* Nivel de Log por defecto */
#define DIR_PASOCOB "/proyectos/startel/factura/unix/tmp/tmp_pc/"

#undef access

#ifdef _PASOC_PC_
#define access
static bool bfnInitPasoCobros (CONFIG *pstConfig, STATUS *pstStatus);
static bool bfnInsFaRepPasocobros (CONFIG *pstConfig, char* szUsuario);
static bool bfnExitPasoCobros (CONFIG *pstConfig);
static bool bfnPasoCobros( CONFIG stConfig, STATUS *pstStatus );
static bool vfnPrintAcumAbo( int *iErrorNeg );
static bool bfnGetCobros( DATCON *pstCobros, int iCodAbono,  NewtagAboCobr &stAboCobr, NewtagConcCobr &stConcCobr, DATOS_FACT stHistDocu );
static bool bfnPagado (DATDOC *pstDatDoc, DATPAG *pstDatPag, DATCON *pstConc);
static bool bfnDBInsertPagos (DATDOC *pstDatDoc, DATPAG *pstDatPag, char *szOficina);
static bool bfnDBInsertPagosConc (DATDOC stPago, DATCON stPagConc);
static bool bfnDBInsertCancelados (DATCON stConc, long lCodCliente);

/* Inicio Requerimiento de Soporte - 69137 - 18.08.2008 */
/*static bool bfbFinPasocobros(long lhCodCiclFact);*/
static bool bfbFinPasocobros(long lhCodCiclFact, long lhClienteInicial, long lhClienteFinal);
/* Fin Requerimiento de Soporte - 69137 - 18.08.2008 */

bool bfnInicializaLogFac( FILE * );
static bool bfnCargaEstructuraWork( int lRow, DATOS_FACT *pstHistDocu);
void rtrim( char *szCadena );
bool   bProcesaPagoLimiteConsumo( long lCodCliente );
int    ifnLlamaCancelacion( long lCodCliente, char *szFec_pago, int k);
static bool bfnDBCargaAcumulaConceptos(	DATOS_FACT *stFactDocu, bool *bConcepNegativos );
bool bfnDBVerificaConceptos(CONFIG stConfig);
static bool bAcumulaSecCartera(DATCON *stCon);
static bool bAcumulaCartera(DATCON *stConGen,long lCodCliente);
static bool bUpdateDocumento(int iIndPasoCobro, long lNumProcPasoCobro, char *szIndOrdenTotal);

#endif
#endif /* _PASOC_H_ */

/******************************************************************************************/
/** Informacin de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisin                                            : */
/**  %PR% */
/** Autor de la Revisin                                : */
/**  %AUTHOR% */
/** Estado de la Revisin ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creacin de la Revisin                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

