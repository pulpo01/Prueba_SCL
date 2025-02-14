#ifndef NO_INDENT
#ident "@(#)$RCSfile: CicloCobro.h,v $ $Revision: 1.47 $ $Date: 2008/06/19 19:02:00 $"
#endif

#ifndef _CICLCOBRO_H_
#define _CICLCOBRO_H_

#ifndef PROC
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <strings.h>
#include <sys/times.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/fcntl.h>
#include <utmp.h>
#include <errno.h>
#include <ctype.h>
#endif


#define iCAUPAGOSUPERTEL 4
#define iIND_FACT_ENPROCESO 1
#define iPROC_PASOCOBROS 9000

#define ORA_NOTNULL    0
#define ORA_NULL       -1
#define NOT_FOUND      1403
#define SQLNOTFOUND    1403
#define SQLOK          0
#define SQLERRM     sqlca.sqlerrm.sqlerrmc
#define SQLROWS     sqlca.sqlerrd[2]

#define FALSE  0
#define TRUE   !FALSE
#define USOFACT        1
#define szGED_CODCONSIGNACION 1
#define szGED_CODCONSIGNACION_NC 2

#define MAX_CONVERSION     2000
#define MAX_DOCUMSUCURSAL  85000
#define MAX_CONCEPTOS      50000

#define iPROC_EST_OK  3
#define iPROC_EST_RUN 1
#define SQLUKCONSTRAINT 1

#define GRV0  0
#define GRV1  1
#define GRV2  2
#define GRV3  3

#define LOG00  0
#define LOG01  1
#define LOG02  2
#define LOG03  3
#define LOG04  4
#define LOG05  5
#define LOG06  6
#define LOG07  7
#define LOG08  8
#define LOG09  9
#define LOG010 10
#define SQLCODE sqlca.sqlcode

#define iESTAPROC_TERMINADO_ERROR       2
#define iESTAPROC_TERMINADO_OK          3

/*ESTRUCTURA SACA DE GENCO*/
typedef struct tagDATCON
{
   int     iCodTipDocum;
   long    lCodAgente;
   char    szLetra[2];
   int     iCodCentremi;
   long    lNumSecuenci;
   int     iCodConcepto;
   int     iColumna;
   int     iCodProducto;
   double  dImporteDebe;
   double  dImporteHaber;
   int     iIndContado;
   int     iIndFacturado;
   char    szFecEfectividad[9];
   char    szFecVencimie[9];
   char    szFecCaducida[9];
   char    szFecAntiguedad[9];
   char    szFecPago[9];
   int     iDiasVencimiento;
   long    lNumAbonado;
   long    lNumFolio;
   long    lNumCuota;
   int     iSecCuota;
   long    lNumTransa;
   long    lNumVenta;
   char    szFolioCTC[12];
   char    szPrefPlaza[26];
   char    szCodOperadoraScl[6];
   char    szCodPlaza[6];
}DATCON;

/*#ifndef _BOOL_
#define _BOOL_
typedef enum {FALSE,TRUE} BOOL;
#endif*/

/*ESTRUCTURAS DE geora*/
typedef struct tagORACLE 
{
    bool Connected;
}ORADB;

typedef struct TagGenParam
{
    int  iNumDecimal;
    char szSepMilesMonto[2];
    char szSepDecMontos[2];
    char szSepDecOracle[2];
    int  iNumDecimalFact;
    int  iTipoFoliacion;
    char szCodIdioma[6];
    int  iConsConcTrafico;
    int  iIndZonaImpCic;
    int  iMtoMinAjuste;
    int  iZonaImpoDefec;
    
    char sDocumentoCero;
}GENPARAM;

/*ESTRUCTURA FaORA*/

typedef struct tagFaProcesos
{
    long  lNumProceso;
    int   iCodTipDocum;
    long  lCodVendedorAgente;
    int   iCodCentrEmi;
    char  szFecEfectividad [15];
    char  szNomUsuarOra[31];
    char  szLetraAg[2];
    long  lNumSecuAg;
    int   iCodTipDocNot;
    long  lCodVendedorAgenteNot;
    char  szLetraNot[2];
    int   iCodCentrNot;
    long  lNumSecuNot;
    short iIndEstado;
    int   iIndNotaCredC;
    long  lCodCiclFact;
    char  szCodOficina[3];
}PROCESO;

/*ESTRUCTURAS FAC*/
/*typedef struct tagDATDOC
{
   int     iCodTipDocum;
   long    lCodAgente;
   char    szLetra[2];
   int     iCodCentrEmi;
   long    lNumSecuenci;
} DATDOC;

typedef struct tagDATFAC
{
   DATDOC  stDatDocFac;
   long    lCodCliente;
   long    lNumAbonado;
   int     iCodProducto;
   int     iCodConcepto;
   long    lNumFolio;
   long    lNumCuota;
   int     iSecCuota;
   long    lNumTransa;
   long    lNumVenta;
} DATFAC;

typedef struct tagDATPAG
{
   long    lCodCliente;
   DATDOC  stDatDocPago;
   double  dImpPago;
   char    szFecValor[9];
   char    szNomUsu[31];
   int     iCodSisPago;
   int     iCodOriPago;
   int     iCodCauPago;
   char    szCodBanco[4];
   char    szCodSucursal[5];
   char    szCtaCorriente[15];
   char    szCodTipTarjeta[4];
   char    szNumTarjeta[21];
} DATPAG;*/

/*Estructuras GenFA*/

typedef struct TagDatosGener
{
   char  szCodDollar[4];
   char  szCodUf[4];
   char  szCodPeso[4];
   int   iCodIva;
   float fPctIva;
   char  szCodMoneFact[4];
   char  szIndOrdenTotal[13];
   int   iCodAbonoCel;
   int   iCodAbonoBeep;
   int   iCodAbonoTrek;
   int   iCodAbonoTrunk;
   int   iCodAbonoFinCel;
   int   iCodAbonoFinBeep;
   int   iCodAbonoFinTrek;
   int   iCodAbonoFinTrunk;
   int   iCodRecargo;
   int   iCodContado;
   int   iCodCiclo;
   int   iCodBaja;
   int   iCodNotaCre;
   int   iCodNotaDeb;
   int   iCodMiscela;
   int   iCodCompra;
   int   iCodLiquidacion;
   int   iCodRentaPhone;
   int   iCodRoamingVis;
   char  szPathBin[256];
   char  szDirReports[51];
   char  szDirSpool[101];
   char  szDirLogs[256];
   char  szCodPlanTarif[4];
   char  szCodCodelco[4];
   short iCodEmpresa;
   long  lCodClienteStartel;
   char  szDesEmpresa[21];
   long  lCodAgenteStartel;
   int   iCodCatImpos;
   int   iCodConcIva;
   char  szRut[21];
   short iProdCelular;
   short iProdBeeper;
   short iProdTrek;
   short iProdTrunk;
   short iProdGeneral;
   int   iCodCatImposDef;
   char  szNomUsuaDBA[31];
   char  szMonedaCobros[4];
   int   iCodFactura;
   char  szOficinaPago[3];
   int   iDocRegalo;
   int   iDocStaff;
   char  szLetraCobros[2];
   long  lAgenteInterno;
   int   iSisPagoRegalo;
   int   iCauPagoRegalo;
   int   iOriPagoRegalo;
   char  szCodOficCentral[3];
   int   iNumDiasBaja;
   long  lCodCicloDocPuntual;
   int   iCodFacturaExen;
   int   iCodBoleta;
   int   iCodBoletaExen;
   int   iCodConsignacion;
   int   iNCredConsignacion;
   long	 lIndValImporte;
   long  lMontoImporte;
   long  lInfoCiclo;
   long  lInfoMes;
   long  lCantCiclos;
} DATOSGENER;


/*Estructuras de Errorres*/

enum {ERR000,  
      ERR001, 
      ERR002, 
      ERR003,  
      ERR004, 
      ERR005,
      ERR006,
      ERR007,
      ERR008,
      ERR009,
      ERR010,
      ERR011,
      ERR012,
      ERR013,
      ERR014,
      ERR015,
      ERR016,
      ERR017,
      ERR018,
      ERR019,
      ERR020,
      ERR021,
      ERR022,
      ERR023,
      ERR024,
      ERR025,
      ERR026,
      ERR027,
      ERR028,
      ERR029,
      ERR030,
      ERR031,
      ERR032,
      ERR033,
      ERR034,
      ERR035,
      ERR036,
      ERR037,
      ERR038,
      ERR039,
      ERR040,
      ERR041,
      ERR042,
      ERR043,
      ERR044,
      ERR045,
      ERR046,
      ERR047,
      ERR048,
      ERR049,
      ERR050,
      ERR051,
      ERR052,
      ERR053,
      ERR054,
      ERR055,
      ERR056,
      ERR057,
      ERR058,
      ERR059,
      ERR060,
      ERR061,
      ERR062
};

typedef struct tagAnomalias
{
  char  szRowid      [19];
  int   iCodAnomalia     ;
  char  szDesAnomalia[101];
  int   iIndGravedad     ;
}ANOMALIAS;

typedef struct TagAnomProceso 
{
  long  lNumProceso       ;
  long  lCodCliente       ;
  long  lNumAbonado       ;
  int   iCodConcepto      ;
  short iCodProducto      ;
  long  lCodCiclFact      ;
  char  szDesProceso  [41];
  int   iCodAnomalia      ;
  char  szObsAnomalia [101];
} ANOMPROCESO;

typedef struct tagSTATUS
{
    long   IdPro;
    long   IdPro2;
    bool   ExitApp;
    unsigned long int ExitCode;
    bool   SkipRec;
    unsigned long int   SkipCode;
    int    LogNivel;
    char   LogName[256];
    FILE*  LogFile;
    char   ErrName[256];
    FILE*  ErrFile;
    bool   Config;
    bool   OraConnected;
    bool   bOpenCursor;
    bool   bCursorCiclo;
    int    iSizeFileLog;
    long   lNumReg;
    long   lNumRegOk;
    long   lNumRegErr;
    long   lCodCliErr;
    short  hTasaExitoMinReq;
    long   lCantCliMinEval;
    long   lMaxCliConsError;
    short  hTasaObservada;
    long   lConCliCons;
    long   lCodCliActual;
    long   lErrorReg;
    char   szBuffLog[10000];
}STATUS;

/*Estructura StFactur*/
typedef struct tagConversion
{
    char   szCodMoneda[4];
    char   szFecDesde[15];
    char   szFecHasta[15];
    double dCambio;
}CONVERSION;

typedef struct tagAlDocumSucursal
{
    char  szCodOficina[3];
    int   iCodTipDocum;
    int   iCodCentrEmi;
}DOCUMSUCURSAL;

typedef struct tagCONCEPTO
{
    short  iFlagExiste;
    short  iCodProducto;
    char   szDesConcepto[61];
    int    iCodTipConce;
    char   szCodModulo[3];
    char   szCodMoneda[4];
    short  iIndActivo;
    int    iCodConcOrig;
    char   szCodTipDescu[2];
    int    iCodConCobr;
    long   lFactor;
}CONCEPTO;


/*Estructuras trazafact*/
typedef struct tagTRAZAPROC
{
    long lCodCiclFact;
    int  iCodProceso;
    int  iCodEstaProc;
    char szFecInicio[15];
    char szFecTermino[15];
    char szGlsProceso[51];
    long lCodCliente;
    long lNumAbonado;
    long lNumRegistros;
} TRAZAPROC;

/*FUNCIONES SACADAS DE GENCO*/
bool bfnDBSecCol(DATCON *stCon);
extern bool bfnDBIntCartera(DATCON *stConGen,long lCodCliente);
extern bool bfnDBUpdCartera(DATCON *stCon,long lCodCliente);
extern bool bfnDBLlevarACanCtos(DATCON *stCon,long lCodCliente,char *szFecHis);
bool bfnDBObtConCre(int *iCodConcepto);
bool bfnDBUpdCastigo(long lCodCliente,long lNumFolio,double dMtoPago);

/*FUNCIONES SACADAS DE geora*/
ORADB      Ora;
GENPARAM pstParamGener;
extern bool    fnOraConnect( char *szUser, char *szPasw );
extern bool    fnOraDisconnect(int iOraErr);
extern bool    fnOraRollBackRelease(void);
extern bool    fnOraCommitRelease(void);
extern bool    fnOraRollBack(void);
extern bool    fnOraCommit(void);
extern double  fnCnvDouble(double d,int uso);

/*Funciones FaORA*/
extern bool   bfnConnectORA(char*,char*);
extern bool   bfnDisconnectORA(int);
extern bool   bfnOraRollBackRelease(void);
extern bool   bfnOraCommitRelease(void);
extern bool   bfnOraRollBack(void);
extern bool   bfnOraCommit(void);
extern char*  szfnORAerror(void);

char szExeName [3072];
PROCESO stProceso;
char szSysDate[15];

long glCicloFact; /* Requerimiento de Soporte - 69137 - 18.08.2008 */

/*Funciones FAC*/
static FILE *fArchLog = stdout;
bool bfnInicializaLogFac( FILE * );
/*bool bfnDBIntCartera(DATCON *stConGen,long lCodCliente);*/
/*bool bfnDBUpdCartera(DATCON *stCon,long lCodCliente);*/
int ifnLlamaCancelacionCredito( long lCodCliente, char *szFec_pago);

/*Funciones GenFA*/
extern bool bGetDatosGener(DATOSGENER *,char *);
extern bool bGetParamConsumo(DATOSGENER* pstDatosGener);
extern bool bGetParamImporte(DATOSGENER* pstDatosGener);
extern bool bGetParamGener(DATOSGENER* pstDatosGener);
extern bool bConverMoneda(char *MonedaO,char *MonedaD,char *Fecha,double *Imp,int iTipoFact) ;
extern bool bFindConversion(char *,char *,double *);
extern void vPrintConversion(CONVERSION*, int);
extern bool bGetCentrEmi(char *,int,int *);
extern bool bGenNumSecuenciasEmi(int, char*, int, long*);
DATOSGENER stDatosGener;
extern CONCEPTO       pstConceptos[MAX_CONCEPTOS];
CONVERSION     pstConversion[MAX_CONVERSION];
DOCUMSUCURSAL  pstDocumSucursal[MAX_DOCUMSUCURSAL];
extern int  NUM_CONCEPTOS     ;
int  NUM_DOCUMSUCURSAL ;
int  NUM_CONVERSION    ;

clock_t cpu_ini ,cpu_fin ;
time_t  real_ini,real_fin;
struct  tms tms;
float   cpu, real;

/*Variables y Funciones de Errores*/

extern int  iDError(char*,int,void(*fnInserAnom)(void),...);
extern void vDTrazasLog(char*,char*,int,...);
extern void vDTrazasError (char*,char*,int,...);
extern bool bOpenError (char*);
extern bool bOpenLog (char*)  ;
extern bool bFindAnomalias (int iCodAnomalia, ANOMALIAS *pAnomalias);
extern void vInsertarIncidencia(void);
extern bool   bInsertaAnomProceso (ANOMPROCESO *)     ;
STATUS        stStatus;
ANOMPROCESO stAnomProceso;

/*Variables y Funciones de RutinasGen*/
extern char* szGetEnv(char*);
extern  bool bfnSelectSysDate(char*);

/*Funiones OraCarga*/
extern bool bCargaConversion(CONVERSION *pConver, int *iNumConver,char *szFecDesde,char *szFecHasta);
static int iOpenConversion(void );
static int iFetchConversion (CONVERSION *pConver);
static int iCloseConversion (void);

/*Funciones y Variables trazafact*/
extern  bool bfnValidaTrazaProc          (long ,int , int);
extern  bool bfnSelectTrazaProc          (long ,int , TRAZAPROC * );
extern  bool bfnUpdateTrazaProc          (TRAZAPROC );
extern  void bPrintTrazaProc             (TRAZAPROC );
extern  int ifnGetHostId                 (char *szHostID);
extern  int iGetRangosHost               (char *szHostID, int iCodCiclFact, long *lCodClienteIni, long *lCodClienteFin);
extern  int ifnBuscarRangosClientesBD    (long lCodCiclFact,long *lpClieIni, long *lpClieFin, int *ipExisteRango);
extern  bool bfnValidaTrazaProcHost      (long lCiclParam,int iCodProceso, int iIndFacturacion, char *szHostId);
extern  bool bfnSelectTrazaProcHost      (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza, char *szHostId);
extern  bool bfnUpdateTrazaProcHost      (TRAZAPROC pstTraza, char *szHostId);
extern  bool bfnValidaTrazaProcHostFirst (long lCiclParam,int iCodProceso, int iIndFacturacion, char *szHostId);

TRAZAPROC stTrazaProc;

#endif

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
