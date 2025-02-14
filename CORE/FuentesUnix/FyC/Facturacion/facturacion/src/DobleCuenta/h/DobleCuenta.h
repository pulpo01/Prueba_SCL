#ifndef __DOBLECUENTA_H__
#define __DOBLECUENTA_H__


/*** inclusion de archivos ***/
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <fcntl.h>
#include <math.h>
#include <time.h>
#include <unistd.h>

#include <sys/timeb.h>
#include <sys/stat.h>

#include <GenFA.h>
#include <ORAcarga.h> /* P-MIX-09003 */
#include <trazafact.h>
#include <New_Interfact.h>
#include <FaORA.h>
#include <errores.h>
#include <checktraza.h>

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

#define     SQLNOTFOUND   1403   /* Ansi :100 ; Not ansi : 1403 */

#define     ERROR_PARAMETROS        -2
#define     ERROR_ARCHIVOSLOG       -3
#define     ERROR_ACCESSORA         -4
#define     ERROR_SQLCODE           -5
/* #define	    MAX_RECORDS             2000 */ /* PGG - 7-09-2010 - 145054 - CORE */
#define	    MAX_RECORDS             1500000 /* PGG - 7-09-2010 - 145054 - CORE */

/*** Valores asociados a TIP_OPERACION ***/
#define	    DOBLECUENTA_FD          0
#define	    TRASPASO_FD	            1

/*** Valores asociados a TIP_MODALIDAD ***/
#define	    CF                      0 /*** Concepto Facturable ***/
#define	    TF                      1 /*** Total Facturado ***/

/*** Valores asociados a TIP_VALOR ***/
#define	    MONTO                   0
#define	    PORCENTAJE              1

/*** Se declara el tipo de Direccion Factura ***/
#define	    iTIPDIRECCION           1

/*** Define tipo de Categoria Trib. Exentos para Facturar Cliente Asociado ***/
#define	    iCODCATRIBUT_EXENTO	    0

/*** Define valores inicialies para los indices y contadores ***/
#define	    iINI_INDICE		    0
#define	    iINI_COUNTCLIENTES	    -1

/****************************************************************************/

#ifdef _DOBLECUENTAFNC_C_

char szUsage[]=
"\n\tUso : DobleCuenta Opciones \n"
"\n\tOpciones :"
"\n\t\t-u usuario/password o '/'"
"\n\t\t-c Cod. Ciclo Facturacion "
"\n\t\t-i Cod. Cliente Inicial (Opcional)"
"\n\t\t-f Cod. Cliente Final (Opcional)"
"\n\t\t-l nivel de Log"
"\n";

#endif /*** _FACTURAUX_C_ ***/
/****************************************************************************/

/*** Declaracion de Estructuras ***/
typedef struct tagPARAMETROSENTRADA
{
	long	lCodCicloFact;
	int	iCodCiclo;
	long	lCodClienteIni;
	long	lCodClienteFin;
	int	iRngClientes; /*** 0=No, 1=Si ***/
}PARAMETROSENTRADA;

typedef struct tagDATOSDOBLECUENTA
{
	int	iNumSecDetalle;
	long	lCodCliContra;
	long	lCodCliAsoc;
	long	lCodAbonAsoc;
	long	lCodConcepto;
	double	lMontoConcAsoc;	
	long	lCodConcDesc;
	long	lCodConcDest;
	long	lIndOrdenTotal;
	long	lIndOrdenTotalAsoc;
	double	lImpFactConcep;
	int	iTipOperacion;
	int	iTipModalidad;
	int	iTipValor;
	long    lColumna;
	char	szCodMoneda[4];
}DATOSDOBLECUENTA;

typedef struct tagCLIENTESIND
{
	long	lCodCliente;
	int	iIndIni;
	int	iIndFin;
	int	iTotAbonados;
	int	iTotAbonFD;
	int	iTotAbonErr;
}CLIENTESIND;

typedef struct tagFECHASPROCESO
{
	long    lNumProceso;
	char    szFecVencimie [15];
	char    szFecEmision  [15];
	char    szFecCaducida [15];
	char    szFecProxVenc [15];
}FECHASPROCESO;

typedef struct tagFACONCEPTO
{
	char    szIndOrdenTotal[13];
	long    lCodConcepto;
	long    lColumna;
	char    szCodMoneda[4];
	short   iCodProducto;
	int     iCodTipConce;
	char    szFecValor[15];
	char    szFecEfectividad[15];
	double  dImpConcepto;
	char    szCodRegion[4];
	char    szCodProvincia[6];
	char    szCodCiudad[6];
	double  dImpMontoBase;
	short   iIndFactur;
	double  dImpFacturable;
	short   iIndSuperTel;
	long    lNumAbonado;
	int     iCodPortador;
	char    szDesConcepto[61];
	long    lSegConsumido;
	long    lSeqCuotas;
	int     iNumCuotas;
	int     iOrdCuota;
	long    lNumUnidades;
	char    szNumSerieMec[26];
	char    szNumSerieLe[26];
	float   fPrcImpuesto;
	double  dValDto;
	short   iTipDto;
	int     iMesGarantia;
	char    szNumGuia[11];
	short   iIndAlta;
	int     iNumPaquete;
	short   iFlagImpues;
	short   iFlagDto;
	int     iCodConceRel;
	long    lColumnaRel;
	char    szCodPlanTarif[4];
	char    szCodCargoBasico[4];
	char    szTipPlanTarif[2];
	double  dMtoReal;
	double  dMtoDcto;
	long    lDurReal;
	long    lDurDcto;
	long    lCntLlamReal;
	long    lCntLlamFact;
	long    lCntLlamDcto;
	double  dImpValunitario;
	char    szGlsDescrip[101];
	long    lNumVenta;
}FACONCEPTO;

typedef struct tagIMPABONADO
{
	double  dTotCargosMe;
	double	dAcumCargo;
	double	dAcumDto;
	double	dAcumIva;
}IMPABONADO;

typedef struct tagFACICLOCLI
{
	long	lCodCliente;            
	int	iCodCiclo;        
	int	iCodProducto;     
	long	lNumAbonado;      
	long	lNumProceso;      
	char	szCodCalClien [4];     
	int	iIndCambio;       
	char	szNomUsuario  [20];    
	char	szNomApellido1[20];   
	char	szNomApellido2[20];
	int	iCodCredMor;    
	char	szIndDebito   [3];  
	int	iCodCicloNue;   
	char	szFecAlta     [15];         
	long	lNumTerminal;   
	char	szFecUltFact  [15];    
	int	iIndMascara;    
	char	szCodDespacho [7];   
	int	iCodPrioridad;  
}FACICLOCLI;

DATOSDOBLECUENTA stDatosDobleCuenta[MAX_RECORDS];
CLIENTESIND	 stClientesInd[MAX_RECORDS];
FECHASPROCESO	 stFecProceso;
FACONCEPTO	 stFaConcepto;
char             szFecSysDate[15];
double 	         dMaxImpFacturable;
long	         lGCodConceRel;
long	         lGCodColumnaRel;	
double           dMontoAjuste_Glob;	


/*********************** ****************************/
/*** Funciones DobleCuenta ***/

BOOL bfnValidaParametrosIn (int     argc,
                            char    *argv[],
                            char    *szOraAccount,
                            char    *szOraPasswd,
                            PARAMETROSENTRADA *stParametrosIn,
                            int     *iLogLevel);

BOOL bfnAbreArchivosLog (int);
BOOL ifnAcessoOracle (char    *szOraAccount, char    *szOraPasswd);
BOOL bfnFacturacionDiferenciada(PARAMETROSENTRADA *stParametrosIn);
BOOL bfnAjusteporAbonado(long, int, double *); 

/*********************** ****************************/
/*** Funciones DobleCuentaFnc ***/

BOOL bFindZonaImpo                          ( char *szCodRegion, 
                                              char *szCodProvincia, 
                                              char *szCodCiudad, 
                                              char *szFecZonaImpo, 
                                              int  *piCodZonaImpo);
BOOL bfnCargaDatosGenerales                 ( long lCodCicloFact); 
BOOL bfnGetCicloFact                        ( PARAMETROSENTRADA *stParametrosIn);
int ifnOpenClientesFactuDif                 ( PARAMETROSENTRADA *stParametrosIn);
int ifnFetchClientesFactuDif                ( int *iInd, int *iCountClientes);
BOOL bfnCloseClientesFactuDif               ();
BOOL bfnProcesaClientesFactuDif             ( long lCodCicloFact, int iInd, int iCountClientes);
BOOL bfnGetImpFactuConceptoAbon             ( long lCodCicloFact, int iInd);
BOOL bfnBuscaInfConceptoFacturado           ( long lCodCicloFact, int iInd);
BOOL bfnAplicaCargosFactDif                 ( int iTipConcepto, /*** 0 = DESCUENTO, 1 = CARGO ***/
                        	              double dDifImpFactConcep,
                        	              long lCodCicloFact,
                        	              int iInd);
BOOL bfnUpdateFactAbon                      ( int iTipAbonado, double dImpFacturado, long lCodCicloFact, int iInd);
BOOL bfnInsertaRegFactConc                  ( long lCodCicloFact);
BOOL bfnBuscaFacturaCliAsoc                 ( long lCodCicloFact, int iInd);
BOOL bfnRecalculaDocuCicloCli               ( int iTipoCli, long lCodCicloFact, int iInd);
BOOL bfnUpdateIndOrdenTotalFD               ( int iInd);

/*********************** ****************************/
/*** Funciones Proceso Facturacion CLiente Asociado ***/

BOOL bfnFacturaCliAsoc                      ( long lCodCicloFact, int iInd);
BOOL bfnGetNewIndOrdenTotal                 ( int iInd);
BOOL bfnGetDatosClieAsoc                    ( long lCodCicloFact, int  iInd);
BOOL bfnInsertClieAsocFactDocu              ( long lCodCicloFact, int  iInd);
BOOL bfnInsertaRegFactDocu                  ( long lCodCicloFact, HISTDOCU *pstHD);
BOOL bfnInsertClieAsocFactClie              ( long lCodCicloFact, int  iInd);
BOOL bfnInsertaRegFactClie                  ( long lCodCicloFact, CLIENTE *pstCLI, int iInd, char *szDesActividad);
BOOL bfnInsertClieAsocFactAbon              ( long lCodCicloFact, int  iInd, double dImpFacturado);
BOOL bfnInsertaRegFactAbon                  ( long lCodCicloFact, HISTABO *pstHA);
BOOL bfnInsertClieAsocFaCicloCli            ( long lCodCicloFact, int  iInd);
BOOL bfnInsertaRegFaCicloCli                ( FACICLOCLI *pstCiCli);

/*********************** ****************************/

/*** Manejo de Strings ***/
char    *ltrim(char *);
char    *rtrim(char *);
char    *alltrim(char *);

/*********************** ****************************/

/*** Obtener Numero CTC ***/
static void vfnComposicionNumCTC            ( long lInd_OrdenTotal, char *szNumCTC);

/*** Obtener Descripcion de Actividad del cliente ***/
static BOOL bfnFindActividad                ( int iCodActividad, char *szDesActividad);

/*** Obtener la Oficina Emisora ***/
char * bfnObtieneOficinaEmisora             ( char *Oficina, char *Operadora);

/*** Obtener Dir Oficina Vendedor ***/
BOOL bfnGetDirOfiVend                       ( long lCodVendedor, char *szCodOficina );

/*** Obtener Fechas de Vencimientos de Procesos **/
BOOL bfnGetFechasProceso                    ( long lCodCicloFact);

/*** Obtener Detalle de concepto a Facturar ***/
BOOL bfnGetDetalleConcepto                  ( long lCodConcepto);

/*** Obtener Maxima Columna de Concepto facturado ***/
BOOL bfnMaxColumnConcepto                   ( long lCodCicloFact, long *lColumna);

/*** Obtener el CodPlanCom de un cliente ***/
BOOL bfnGetCodPlanCom                       ( CLIENTE *pstCliente);

/*** Obtiene Importe Totales del Abonado ***/
BOOL bfnGetImpAbonado                       ( long lCodCicloFact, 
                                              long lNumAbonado, 
                                              long lIndOrdenTotal, 
                                              IMPABONADO *pImpA);

/*** Valida si existe Abonado 0 para el cliente asociado ***/
BOOL bfnExisteAbonado0                      ( long lCodCicloFact, int iInd, int *iExistAbon0);

/*** Inserta Abonado 0 para el cliente asociado ***/
BOOL bfnInsertaAbonado0                     ( long lCodCicloFact, int iInd, double dImpFacturado);

/*** Obtiene el valor del campo Letra ***/
BOOL bfnGetLetra                            ( int iCodTipDocum,int iCodCatImpos,char *szLetra);

/*** Obtiene Categoria Impositiva del Cliente ***/
BOOL bfnGetCatImpos                         ( CLIENTE *pstCli);

/*** Obtiene informacion sobre la Oficina ***/
BOOL bfnGetDataOficina                      ( char *szCodOficina, OFICINA *pstOficina );

/*** Obtiene Datos del cliente asociado , desde GE_CLIENTES ***/
BOOL bfngetDataCliAsocGeClientes            ( long lCodCliente, FACICLOCLI *pstCiCli);

/*********************** ****************************/

/*** Imprime los registros a ingresar en la FA_FACTCLIE_<ciclo> ***/
static void vPrintCliente                   ( CLIENTE *pClie);
/*** Imprime los registros a ingresar en la FA_FACTDOCU_<ciclo> ***/
static void vfnPrintHistDocu                ( HISTDOCU *pHis);
/*** Imprime los registros del arreglo de Procesos ***/
static void vfnPrintProcesos                ( PROCESO *pP);
/*** Imprime los registros del arreglo de Abonado 0 ***/
static void vfnPrintAbonado0                ( HISTABO *pHa);
/*** Imprime los registros del arreglo sTDatosDobleCuenta ***/
static void vfnPrintDatosDobleCuenta        ( int iInd);
/*** Imprime los registros del arreglo de Concepto ***/
static void vfnPrintFaConcepto              ();
/*** Imprime los Importes obtenidos para el Abonado ***/
static void vfnPrintImpAbonado              ( IMPABONADO *pImpA);
/*** Imprime los registros a ingresar en la FA_CICLOCLI ***/
static void vfnPrintCliCicloCli             ( FACICLOCLI *pstCCli);

/*********************** ****************************/

/*** Execute una Query Inmediate ***/
BOOL bfnExecuteQuery                        ( char *szCadenaSQL);
/*** Abre un cursor Dinamico ***/
BOOL bfnOpenCursorQuery                     ( char *szCadenaSQL);
/*** Cierra un cursor Abierto ***/
BOOL bfnCloseCursorQuery                    ();
BOOL bfnGetTotImpFactConceptoAbon           ( long, int);
BOOL bfnOpenConceptosAbon                   ( long, int);
BOOL bfnFetchConceptosAbon                  ( long *, long *, double *, long *, long *, long *);
BOOL bfnCloseConceptosAbon                  ();
BOOL bfnVerficaEstadoClie                   ( long lNumProceso, long lCodCliente, long lNumAbonado);


#endif
