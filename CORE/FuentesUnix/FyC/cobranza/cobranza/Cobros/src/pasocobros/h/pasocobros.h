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

/*#define szVERSION     "4.12"		 23-04-2004 */
/*#define szVERSION       "4.2.0"		*/
/*#define szVERSION       "4.2.1"		*XO-200507290237 Soporte RyC capc 02-08-2005*/
/*#define szVERSION       "4.2.2"		*XO-200508310542 Soporte RyC capc 05-09-2005*/
/*#define szVERSION       "4.2.3"		*XO-200509130656, 27-09-2005 rvc Soporte RyC*/
/*#define szVERSION       "4.2.4"		*RA-200512130309 14-12-2005 Soporte RyC capc */
/*#define szVERSION       "4.2.5"		*RA-200601050512 07-01-2006 Soporte RyC capc */
/*#define szVERSION       "4.2.6"		*RA-200601130570 19.01.2006 Soporte RyC */
/*#define szVERSION       "4.2.7"		* RA-200601260641 27.01.2006 Soporte RyC */
/*#define szVERSION       "4.2.8"		* RA-200602070720 Soporte RyC 09-02-2006 capc*/
/*#define szVERSION       "4.2.9"		* Soporte RyC RA-200602130762 07.03.2006 */
/*#define szVERSION       "4.2.10"	    * RA-200603080883 Soporte RyC 10.03.2006 */	
/*#define szVERSION       "4.2.11"	  * RA-200603160926 Soporte RyC 16.03.2006 */
/*#define szVERSION       "4.2.12"	  * CO-200605120125 Soporte RyC 03.07.2006 */
/*#define szVERSION       "4.2.13"	  * RA-200603160921 13-07-2006 capc Soporte RyC */
/*#define szVERSION       "4.2.14"	  * Soporte RyC MCO-200606060001 17-07-2006 capc*/
/*#define szVERSION       "4.2.15"	  * Soporte RyC CO-200607310285 03-08-2006 capc*/
/*#define szVERSION       "4.2.16"	  * Requerimiento de Soporte - #34635 12-10-2006 capc*/
/*#define szVERSION       "4.2.17"	  * Requerimiento de Soporte - 39289 - 27.04.2007 */
/*#define szVERSION       "4.2.18"	  * Requerimiento de Soporte - 41321 - 07.06.2007 */
/*#define szVERSION       "4.2.19"	  * Requerimiento de Soporte - 41321_2 - 22.06.2007 */
/*#define szVERSION       "4.2.20"	  * Requerimiento de Soporte - 41321_3 - 13.07.2007 */
/*#define szVERSION       "4.2.21"	  * Requerimiento de Soporte - 41321_4 - 13.07.2007 */
/*#define szVERSION       "4.2.22"	  * Requerimiento de Soporte - 66709 - 11.06.2008 mgg */
/*#define szVERSION       "4.2.23"	  * Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
/*#define szVERSION       "4.3.0"	  * MIX-09003 - 30.09.2009 - MQG */
/*#define szVERSION       "4.3.1"	  * Requerimiento MIX-09003 - 138560- 06.07.2010 - MQG */
/*#define szVERSION       "4.3.2"	  * Requerimiento MIX-09003 - 141547 - 28.07.2010 - MQG */
/*#define szVERSION       "4.3.3"	  * Requerimiento MIX-09003 - 138560 - 29.07.2010 - MQG */
/*#define szVERSION       "4.3.4"	  * Requerimiento de Soporte - 161883 */

/*#define szVERSION       "4.3.5"	  * Requerimiento de Soporte - 179586 - 11-01-2012 - JJPO */
#define szVERSION       "4.3.6"	  /* Requerimiento de Soporte - 198848 - 24-09-2013 - RyC */

#define iMAXHOST		    10000	
#define iMAXARRAYWORK	   300000 
#define szPREF_PLAZA_DEFAULT    "0000000000"   

#define MAX_CONCFACTUR1 10  /* Requerimiento de Soporte - 41321 - 07.06.2007 */

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
	char szRowid         [19];
	long lNumSecuenci;
	 int iCodTipDocum;
	long lCodVendedorAgente;
	char szLetra          [2];
	 int iCodCentrEmi;
	long lCodCliente;
	char szFecEmision     [9];
	char szIndOrdenTotal [13];
	 int iIndSuperTel;
	long lNumFolio;
	char szFecVencimie    [9];
	char szFecCaducida    [9];
	long lNumSecuRel;
	char szLetraRel       [2];
	 int iCodTipDocumRel;
	long lCodVendedorAgenteRel;
	 int iCodCentrRel;
	long lNumVenta;
	long lNumTransaccion;
	char szNumCTC        [13];
	 int iCodModVenta;
	double  dTotFactura;
	 int iIndFactur;
	 int iCodTipMovimie;
	long lNumProceso;
	 int iIndPasoCobro;
	 int iNumCuotas; 
	char szPrefPlaza     [26];
	char szCodOperadoraScl[6]; 
	char szCodPlaza       [6];        
	char szNomUsuarioORA [31];  
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
  BOOL bOptUsuario         ;
  BOOL bOptPassWord        ;
  BOOL bOptCodTipDocum     ;
  BOOL bOptCodCicloFact    ;
  BOOL bOptNumProceso      ;
  BOOL bOptNivelLog        ;
  BOOL bOptBatch           ;
  BOOL bOptUnico           ;
  BOOL bOptOnline          ;
  BOOL bOptCodModGener     ;
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
#define iDOCTOOK	     1      /* Documento procesado en forma exitosa */
#define iCNTDOCTOS	  5001	    
#define iTERMINAR	  	 1		
#define iNIVEL_DEF       3 		/* Nivel de Log por defecto */
#define DIR_PASOCOB "/proyectos/startel/factura/unix/tmp/tmp_pc/"

#undef access

#ifdef _PASOC_PC_
#define access
static BOOL bfnInitPasoCobros (CONFIG *pstConfig, STATUS *pstStatus);
static BOOL bfnInsFaRepPasocobros (CONFIG *pstConfig, char* szUsuario);
static BOOL bfnExitPasoCobros (void);
static int ifnFactIntercalada(DATOS_FACT *pstHistDocu);
static BOOL bfnPasoCobros( CONFIG stConfig, STATUS *pstStatus );
static int ifnTipDevolucionCliente( DATOS_FACT *pstHistDocu );
static BOOL ifnDBOpenHistDocu (CONFIG stConfig);
/*static ifnDBFetchHistDocu (CONFIG    stConfig, DATOS_FACT *pstHistDocu);*/
static int ifnDBCloseHistDocu (CONFIG stConfig);
static BOOL bfnDBCargaFactCobr (COFACTCOBR *pstFactCobr);
/*static BOOL bfnDBCargaHistConc(	char *szIndOrdenTotal, HISTCONCP *pstHistConcP, ACUMABO *pstAcumAbo, COFACTCOBR *pstFactCobr, BOOL *bConcepNegativos );*/
static BOOL bfnDBCargaHistConc(	char *szIndOrdenTotal, HISTCONCPAUX *pstHistConcP, ACUMABO *pstAcumAbo, COFACTCOBR *pstFactCobr, BOOL *bConcepNegativos );
static BOOL vfnPrintAcumAbo( ACUMABO *pstAcumAbo, int *iErrorNeg );
static int ifnDBOpenHistConc (char *szIndOrdenTotal);
/* static int ifnDBFetchHistConc (HISTCONC *pstHistConc, int iNumReg);Requerimiento de Soporte - 41321 - 07.06.2007 */
static int ifnDBFetchHistConc (HISTCONCAUX *pstHistConc, long iNumReg); 
static int ifnDBCloseHistConc (void);
/* static BOOL bfnAcumulaAboProd (int iInd, HISTCONC *pstHistConc, ACUMABO  *pstAcumAbo, COFACTCOBR *pstFactCobr); Requerimiento de Soporte - 41321 - 07.06.2007 */
static BOOL bfnAcumulaAboProd (long iInd, HISTCONCAUX *pstHistConc, ACUMABO  *pstAcumAbo, COFACTCOBR *pstFactCobr);
static BOOL bfnGetCobros( DATCON *pstCobros, int iCodAbono, ABOCOBR stAboCobr, CONCCOBR stConcCobr, DATOS_FACT stHistDocu );
static BOOL bfnDBUpdateHistDocu (DATOS_FACT stHDocu);
static void vfnFreeAcumAbo (ACUMABO *pstAcumAbo);
static BOOL bfnPagado (DATDOC *pstDatDoc, DATPAG *pstDatPag, DATCON *pstConc);
static BOOL bfnDBInsertPagos (DATDOC *pstDatDoc, DATPAG *pstDatPag, char *szOficina);
static BOOL bfnDBInsertPagosConc (DATDOC stPago, DATCON stPagConc);
static BOOL bfnDBInsertCancelados (DATCON stConc, long lCodCliente);
static BOOL bfbFinPasocobros(long lhCodCiclFact);
int ifnDBPasoCob(	long lCodCliente,		 int iCodTipDocum,		long lCodAgente,
					char *szLetra,			 int iCodCentremi,		long lNumSecuenci,
					 int iCodProducto,		long lNumTransa,		long lNumVenta,
					char *szFecValor,		char *szFecPriCuota,	long lNumProceso,
					long lNumAbonado,		 int iCodTipMovimiento,	char *pszPrefPlaza,
					char *pszCodOperadora,	char *pszCodPlaza );

BOOL bfnInicializaLogFac( FILE * );
static BOOL bfnDescargaDoctosInter();
static BOOL bfnCargaEstructuraWork( int lRow, DATOS_FACT *pstHistDocu );
void rtrim( char *szCadena );

BOOL bfnDBObtConCreFA( int *iCodConcepto );
static BOOL bfnGrabaRegistrosError( CONFIG stConfig );
static BOOL bfnDBUpdateHistDocuError( char *szRowid, int iIndPasoCobro, long lNumProcPasoCobro );
static BOOL bfnLimpiaEstructura();
BOOL   bProcesaPagoLimiteConsumo( long lCodCliente );
int    ifnLlamaCancelacion( long lCodCliente, char *szFec_pago, int k);

/* Inicio Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
static BOOL bfnDBCargaAcumulaConceptos(	DATOS_FACT stFactDocu, ACUMABO *pstAcumAbo , COFACTCOBR *pstFactCobr, BOOL *bConcepNegativos, ACUMABO *pstAcumCon );
static int ifnDBFetchConceptos (ACUMABO *pstAcumAbo, COFACTCOBR *pstFactCobr, char *szIndOrdenTotal, ACUMABO *pstAcumCon);
BOOL bfnDBVerificaConceptos(CONFIG stConfig);
/* Fin Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
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

