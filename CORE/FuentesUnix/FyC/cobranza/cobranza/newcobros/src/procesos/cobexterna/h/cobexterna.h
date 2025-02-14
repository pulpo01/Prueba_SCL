/*============================================================================= 
   Tipo        :  Libreria propia de cobexterna.pc
   Nombre      :  cobexterna.h
   Autor       :  Roy Barrera Richards
   Fecha       :  09 - Agosto - 2000
   *****************Ya **************************
   Modificado  : 01-04-2004 Proyecto TMM-03069
   A/P			: GAC
============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h> 	/* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  	/* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>  	/* Inclusion de nueva libreria general de procesos       */


/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403  /*  100:Ansi    1403:Oracle */

#define szVERSION			"5.0.0"     /* Nueva version para RAN*/
#define szCODPROCESO		"COBEX"		/* Define codigo por defecto de la cola */

#define iLOGNIVELDEFAULT	3			/* Define el nivel de Log por Defecto */
#define OK					   0
#define ERROR				  -1
#define RESTCLIENTE			1
#define PROXCLIENTE			2
#define COLASTOP			   1 

#define TIPONOCLIENTE	  "N"
#define BAJA				  "B"
#define REASIGNADO		  "R"
#define MODIFICADO		  "M"
#define ALTA			     "A"

#define DOCTOS_CARTERA     5000
#define DOCTOS_COBRANZA    5000
#define MAXCLIEHOST    		25000
#define MAXCLIE				200000
#define HOSTARRAY_DETALLES 25000

#define DOCTOSVENCIDOS		"V"
#define DEUDAINFORMADA		"1"
#define DOCTOINFORMADO		"S"
#define DOCTONOINFORMADO	"N"
#define SI					   "S"
#define ARCHIVOMANUAL		"M"
#define ARCHIVOAUTOMATICO	"A"

/*DEFINICION DE VALORES PARA VARIABLES BIND  */
#define DOCU_CLIENTES      "DOCU_CLIENTES"
#define COD_TIPDOCUM       "COD_TIPDOCUM"
#define COD_MODULO         "CO"
#define CO_COBEXTERNADOC   "CO_COBEXTERNADOC"
#define COD_CONCEPTO       "COD_CONCEPTO"
#define CASTIG_CONTABLE    "CASTIG_CONTABLE"
#define MOVTO_EP   		   "EP"
#define MOVTO_SM   		   "SM"
#define COD_RUTINA			"ACEXT"
#define ACCION_EJE         "EJE"
#define INFORMA_N			   "N"
#define INFORMA_S			   "S"
#define ESTADO_EJE         "6EJEC"
#define ESTADO_VISA        "5VISA"
#define ESTADO_RECH        "7RECH"
#define SDOCU              "SDOCU"
#define LETRA_C			   "C"
#define UNIVERSO_INF       "UNIVERSO_INFORMAR"


typedef struct DatosGen
{
	  char szEntGestion     [21];
	  int  iCntDoctosCli        ;
	  int  iCntDoctosNoCli      ;
	  char szDoctosInformar [21];
	  char szRefreshInformar[21];
	  char szIndFacturado   [21];
	  int  iCntConceptosDef     ;
	  char szBorrarCastCont [21]; 
	  char szTipGenArchivo  [21]; 
} DATOSGEN;

typedef struct hClientesCob
{
	  char szNumIdent    [MAXCLIEHOST][iLENNUMIDENT];
	  char szCodTipIdent [MAXCLIEHOST][3];
	  long lCodCliente	[MAXCLIEHOST];
	  char szCodEntidad	[MAXCLIEHOST][6];
	  long lCodCuenta		[MAXCLIEHOST];
	  char szCodMovimiento[MAXCLIEHOST][6];
	  char szCodEnvio		[MAXCLIEHOST][3];
	  char szRowid			[MAXCLIEHOST][19];
	  char szTipEntidad	[MAXCLIEHOST][2];
	double dMtoEnvioAnt	[MAXCLIEHOST];
	  long lNumProceso	[MAXCLIEHOST];
} HCLIENTESCOB;

typedef struct ClientesCob
{
	  char szNumIdent[iLENNUMIDENT];
	  char szCodTipIdent  [3];
	  long lCodCliente       ;
	  char szCodEntidad   [6];
	  long lCodCuenta        ;
	  char szCodMovimiento[6];
	  char szCodEnvio     [3];
	  char szRowid       [19];
	  char szTipEntidad   [2];
	double dMtoEnvioAnt      ;
	  long lNumProceso       ;
} CLIENTESCOB;

typedef struct Documentos
{
	  char szNumIdent   [iLENNUMIDENT];
	  char szCodTipIdent   [3];
	  long lCodCliente        ;
	  long lNumAbonado        ;
	  long lNumFolio          ;
	  int  iNumCuota          ;
	  int  iSecCuota          ;
	  char szFecVencimie   [9];
	  int  iCodTipDocum       ;
	  char szIndInformado  [2];
	double dImporteDebe       ;
	double dImporteHaber      ;      
	  char szFecEfectividad[9];
	  char szCodEntidad    [6];
	  char szPrefijoPlaza [11]; 
	  int  iCodConcepto       ;
	  int  iPasarHistoria     ;
} DOCUMENTOS;

typedef struct hNoClientes
{
	long lCuentaoCliente[MAXCLIEHOST];
	char szRowid        [MAXCLIEHOST][19];
} HNOCLIENTES;

typedef struct NoClientes
{
	long lCuentaoCliente ;
	char szRowid     [19];
	int  iCumpleCriterios;
	char szCodRechazo [6];
} NOCLIENTES;

typedef	struct RG_CODETARCH
{
	char szCodEntidad[HOSTARRAY_DETALLES][6];	/* N VARCHAR2	6	 */
	char szTxtReg    [HOSTARRAY_DETALLES][1025];	/* N VARCHAR2	1024 */
}rg_codetarch;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnConexionDB( LINEACOMANDO *pstLC );
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog( int iCrearDir );
void vfnCierraArchivoLog(void);
int ifnEjecutaCola( void );
int ifnCobExterna( char *szDescError );
BOOL bfnGetDatosGenerales();
BOOL bfnCntDoctosCli( int *giTotalDoctosCli );
BOOL bfnCntDoctosNoCli( int *giTotalDoctosNoCli );
BOOL bfnCntConcInfor( int *giTotalConcepInfor );
BOOL bfnProcesosGenerales();
BOOL bfnRegularizaEP( char *szpEntGestion );
int  ifnTraspasaHistoricoCobranza();
BOOL bfnBorraDoctosCobranza( char *szpEntGestion );
int ifnProcesaUniverso();
BOOL bfnCambiaEstadoProcNoClientes();
int ifnProcesaClienteSM( char *szNumIdent, char *szCodTipIdent, long lCodCliente, char *szCodEntidad, long lCodCuenta,
						 char *szCodMovimiento, char *szCodEnvio, char *szRowid, char *szTipEntidad, long lNumProceso );
BOOL bfnTratarCastigCont( char *szpNumIdent, char *szpCodTipIdent, long lCodCliente );
BOOL bfnBorraCastigosContables( char *szpNumIdent, char *szpCodTipIdent, long lCodCliente );
int ifnCreaDetalleDocumentos();
int ifnCreaArchivos();
BOOL bfnBorraCoDetArchivos();
int ifnRevisaNoClientes();
int ifnValidaSituacionAbonadosCuenta( long lCodCuenta, char *szCodSituacion );


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

