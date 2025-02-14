/* ============================================================================= */
/*
	Tipo			:	ESTRUCTURAS DE USO GENERAL 
	Nombre			:	RevBaja.h 
	Descripcion		:	Header de estructuras para RevBaja.pc
	Autor			: 
	Fecha			:	Mayo 2001.
	Modificaciones	:
	06-11-2002		Se cambia declaracion de tamaño a la variable que contiene el campo NUM_SERIE ( GA_ABOCEL ),
					por la constante iLENNUMSERIE.
*/ 
/* ============================================================================= */

/* ============================================================================= */
#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza       */
#include <CO_libgenerales.h> /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CO_libacciones.h"  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
/* ============================================================================= */

#define		SZSEPARADOR       "/"
#define     CAUSABAJA		   "90"
#define     ACTUACIONALTAPLS	"AB"
#define     ACTUACIONALTAPOST	"AF"
#define     ACTUACIONALTAPREP	"AP"
#define     ACCIONBAJA			"BAJA"
#define     CTASEGURACTC	   15
#define     USOAMISTAR		    3
#define     INDAUTENTICACION  "IND_AUTENTICACION"
#define     szCODRUTINA	      "RBAJA"
/*#define     szVersion "2.0.0"   *Nueva version para RAN*/
/*#define     szVersion "2.0.1"   * XO-200508260480 Soporte RyC 26-08-2005 */
/*#define     szVersion "2.0.2"    Soporte RyC RA-200512190339 07-02-2006 capc */
/*#define     szVersion "2.0.3"    Soporte RyC CO-200607210247 25-07-2006 CPF */
#define     szVersion "2.0.3"   /* Proyecto P-COL-08022  MAC */

typedef struct TABONADO 
{
	int		ihCodProducto;        
	long	lhNumAbonado;      
	char	szhCodSituacion[4];   
	char	szhCodCausaBaja[3];
	int		ihIndPlexsys;    
	int		ihCodCentral;      
	int		ihCodCentralPlex;  
	long	lhNumCelularBeeper;
	long	lhNumCelularPlex;  
	char	szhNumSerieHex[9];    
	char	szhTipTerminal[2];  
	int		ihCodModventa;     
	char	szhIndProcequi[3];  
	int		ihCodCiclo;        
	char	szhCodPlanserv[4];    

    /*Inicio HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503100256 CAMBIOS EN ANEXO Y NUMERO DE CONTRATO */	
	/*char	szhNumContrato[20];  
	char	szhNumAnexo[20];*/
	char	szhNumContrato[22];
	char	szhNumAnexo[22];
	/*Fin */

	char	szhFecFincontra[9];   
	long	lhCodCuenta;
	int		ihCodUso;          
	char	szhCodPlanTarif[4];
	int		ihIndSupertel;     
	char	szhNumTeleFija[16];
	char	szhPerfilAbonado[256];
	char	szhFecAlta[9];
	char	szhIndEqPrestado[2];
	char	szhFecProrroga[9];
	char	szhCodTecnologia[iLENCODTECNO];
	char	szhNumSerie[iLENNUMSERIE];
	char	szhNumImei[iLENNUMIMEI];
	char	szhNumImsi[iLENNUMIMSI];

} td_Abonado;

typedef struct TALSERIES 
{
	int		ihCodBodega;
	int		ihTipStock;
	long	lhCodArticulo;
	int		ihCodUso;
	int		ihCodEstado;
	long	lhCapCode;
	char	szhNumSerieMec[iLENNUMSERIE];
} td_AlSeries;

typedef struct 
{
	char	szNumFrecuente[11];
} td_NumFrec;      

td_NumFrec	astNumFijosFrec[20];
td_NumFrec	astNumMovilFrec[20];

/* Cabeceras de Funciones */
char *szRevisaAlSeries(FILE **ptArchLog, td_Abonado sthAbo, td_AlSeries *sthAlSeries, BOOL *bExiste, sql_context ctxCont );
BOOL bfnActualizaEquipAbo(FILE **ptArchLog, td_Abonado sthAbo, td_AlSeries *sthAlSeries, sql_context ctxCont );
char *szfnSerieBodega (FILE **ptArchLog, td_Abonado sthAbo, td_AlSeries *sthAlSeries, BOOL *bReservado, sql_context ctxCont )   ;
char *szfnDescCadena(FILE **ptArchLog, char *szDesCadena, char *szSep, sql_context ctxCont );
char *szfnDesReservaEquipo (FILE **ptArchLog, td_Abonado sthAbo, td_AlSeries sthAlSeries, sql_context ctxCont )   ;
char *szfnInsICMovim (FILE **ptArchLog, td_Abonado sthAbo, int iCodCelular, long	*plNumMovimiento1, char *szCodTiPlan, sql_context ctxCont );
BOOL bRegMovCControlada(FILE **ptArchLog, td_Abonado sthAbo, long lNumMovimiento, sql_context ctxCont );
BOOL bInsertaMovtoSTM(FILE **ptArchLog, td_Abonado sthAbo, sql_context ctxCont) ;
char *szfnActivaFF(FILE **ptArchLog, td_Abonado sthAbo, long lCodCliente, sql_context ctxCont );
char *szfnProcesaPlanFrecuente(FILE **ptArchLog, td_Abonado sthAbo, long lCodCliente, sql_context ctxCont );
BOOL bfnBuscNumFrecExist(FILE **ptArchLog, td_Abonado sthAbo, long lCodCliente, int *iTotalFijos, int *iTotalMovil, sql_context ctxCont );
BOOL bfnEliminaFrec(FILE **ptArchLog, long lNumAbonado, sql_context ctxCont );
BOOL bfnIngresaFrecuentes(FILE **ptArchLog, long lCodCliente, long lNumAbonado, long lNumCelular, int iCntFrecFijo, int iCntFrecMovil, char *sTipPlantarif, long lNumDiasNum, sql_context ctxCont );
BOOL bfnAgrFrecEmp(FILE **ptArchLog, long lNumAbonado, long lCodCliente, long lNumCelular, long lSecuencia, sql_context ctxCont ) ;
BOOL bfnAboEmpServ(FILE **ptArchLog, long lNumAbonado, long lNumCelular, int iCodProducto, long lCodCliente, long *lNumSecAboNue, sql_context ctxCont );
BOOL bfnbAgrFrecInd(FILE **ptArchLog, long lCodCliente, long lNumAbonado, long lSecuencia, sql_context ctxCont );
char *szGetCadenaServNivel(FILE **ptArchLog, long lNumAbonado, char *szCadena, sql_context ctxCont );
char *szGetCadenaServNivel1(FILE **ptArchLog, int iCodProducto, char *szCadena, sql_context ctxCont );
BOOL bfnInsGaNumEspAbo(FILE **ptArchLog, long lNumAbonado, char *szNumTeleEsp, long lNumDiasNum, sql_context ctxCont );
char *szBorraCargosIndem(FILE **ptArchLog, long lCliente, td_Abonado *sthAbo,   sql_context ctxCont );
BOOL bfnBorrarCargos(FILE **ptArchLog, long lCodCliente, long lNumAbonado, int iCodProducto, long lCodCuenta, char *szNumContrato, char *szNumAnexo, int iComodato, char *szTipIndem, sql_context ctxCont);
BOOL bfnDesHibernaEquipo(FILE **ptArchLog, long lNumEquipo, int iTipoEquip, sql_context ctxCont );
BOOL bfnExtraerServSuplString(FILE **ptArchLog, char *szpCadenaFind, char *szpCadenaServicios, sql_context ctxCont );
BOOL bfnGetServicio(FILE **ptArchLog,  char *szNomParametro, int iCodProducto, GENSERVICIO *stServicios, sql_context ctxCont );

BOOL bfnLimpiaStruct( td_Abonado *sthAbo );
int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);

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

