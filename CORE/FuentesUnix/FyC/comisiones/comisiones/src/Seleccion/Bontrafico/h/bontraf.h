#include <stdio.h>
#include <strings.h>
#include <malloc.h>
#include <stdlib.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>

#define PATHLEN         250
#define MAXARRAY       2000

#define GLOSA_PROG     "SELECCION DE BONIFICACION POR TRAFICO"
#define PROG_VERSION   	"CUZCO 4.0.1"
#define LAST_REVIEW		"14-OCTUBRE-2003 (mwn70252)"
#define LOGNAME			"Sel_BonTraf"

#define CONCEPTO_TRAFICO "CFT"
#define CONCEPTO_CFIJO   "CCB"
#define FORMACOMIS		 "CARTERA"
#define UNIVERSO       "HABCEL"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE  * pfLog;
char    *pszEnvLog  = "";
char    szLogName[MAXARRAY] ;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   long         lSegProceso ;
   long         lCantRegistros;
}rg_estadistica;
rg_estadistica stStatusProc;
/* ------------------------------------------------------------------------- */
/* Almacenamiento de los identificadores de Registro de Detalle para factura */
/* ------------------------------------------------------------------------- */
typedef struct reg_idfactura{

	long	lCodCiclFact;
	long	lIndOrdenTotal;
	double	dImpTrafico;
	double	dImpCBasico;
	struct reg_idfactura * sgte;
} reg_idfactura;
typedef struct reg_idfactura  stIdFactura;
/*---------------------------------------------------------------------------*/
/* Almacenamiento de Abonados */
/*---------------------------------------------------------------------------*/
typedef struct reg_abonado
{
	long	lCodAgencia;
	char	szCodTipVendedor[3];
	long	lNumAbonado;
	char	szCodPlanTarif[4];
	short	iCantAbonadosPlan;
	double	dFecVenta; 
	char	cIndConsidera;
	
	struct reg_idfactura  * sgte_idfactura;
	struct reg_abonado    * sgte;
} reg_abonado;
typedef struct reg_abonado  stAbonado;
stAbonado * lstAbonado = NULL;
/*---------------------------------------------------------------------------*/
/* Almacenamiento de las facturas */
/*---------------------------------------------------------------------------*/

typedef struct reg_factura
{
    short   iCodTipDocum;
    short   iCodCentremi;
    long    lNumSecuenci;
    long    lCodVendedorAgente;
    char    cLetra[2];
    long	lCodCiclFact;
	long	lIndOrdenTotal;
	double	dFecEmision;
	char	szFaHistConc[41];
	char	cIndConsidera;
	struct reg_factura * sgte;
}reg_factura;
typedef struct reg_factura  stFactura;
/*---------------------------------------------------------------------------*/
/* Detalle de Conceptos de Facturacion asociados a los concepto comisiones.  */          
/*---------------------------------------------------------------------------*/
typedef struct reg_concfact
{
	int		iCodConcepto;
	char	szTipoConcepto[10];
	struct 	reg_concfact * sgte;
} reg_concfact;
typedef struct reg_concfact  stConcFact;
/*---------------------------------------------------------------------------*/
/* Almacenamiento de Clientes                                                */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo
{
	int		iCodTipoRed;
	char	szCodPlanComis[7];
	int		iCodConcepto;
	char	szCodTipComis[3];
	long	lCodComisonista;
	long	lCodCliente;
	char	cIndConsidera;
	struct  reg_concfact * sgte_concfact;
	struct 	reg_abonado  * sgte_abonado;
	struct 	reg_factura  * sgte_factura;
	struct 	reg_universo * sgte;
} reg_universo;
typedef struct reg_universo  stUniverso;
stUniverso * lstUniverso = NULL; 
 
/* ------------------------------------------------------------------------- */
/* Almacenamiento de Enlaces historicos */
/* ------------------------------------------------------------------------- */
typedef struct reg_enlacehist
{
	long	lCodCiclFact;
	char	szFaHistConc[41];
	struct reg_enlacehist * sgte;
} reg_enlacehist;
typedef struct reg_enlacehist  stEnlaceHist;
stEnlaceHist * lstEnlaceHist = NULL; 

/* ------------------------------------------------------------------------- */
/* Almacenamiento de tabla co_cancelados */
/* ------------------------------------------------------------------------- */
typedef struct reg_cancelados
{
	long	lCodCliente;
    short   iCodTipDocum;
    short   iCodCentremi;
    long    lNumSecuenci;
    long    lCodVendedorAgente;
    char    cLetra[2];
	struct 	reg_cancelados * sgte;
}reg_cancelados;
typedef struct reg_cancelados  stCancelados;
stCancelados * lstCancelados = NULL; 
/* ------------------------------------------------------------------------- */
/* Almacenamiento de tipos de documentos*/
/* ------------------------------------------------------------------------- */
typedef struct reg_documentos
{
	int		iCodTipDocum;
	char	szDesTipDocum[51];
	struct 	reg_documentos * sgte;
}reg_documentos;
typedef struct reg_documentos stDocumentos;
stDocumentos * lstDocumentos = NULL; 
/* ------------------------------------------------------------------------- */
/* Almacenamiento de Conceptos           */
/* ------------------------------------------------------------------------- */

typedef struct reg_conceptos
{
	long	cod_concepto[100];
    short   tip_concepto[100];
    int     nro_conceptos;
} reg_conceptos;

reg_conceptos stConceptos;

/* ------------------------------------------------------------------------- */
stUniverso * stBuscaCliente(stUniverso * , long , char * , int );
stUniverso * stBuscaClienteFactura(stUniverso * , long );
stConcFact * stCargaConcFact(int , char * , int );
stConcFact * stBuscaConcepto(stConcFact * , int );
stEnlaceHist * stBuscaEnlace(stEnlaceHist * , long );
stIdFactura * stBuscaIdFactura(stIdFactura * , long );
stAbonado * stBuscaAbonado(stAbonado * , long );

int bCargaConceptos();
int bFindTipDocum(stDocumentos * , int );

void vAsignaConceptos(stUniverso * , stFactura * , int , double , long );
void vCargaTipoDocumentos ();
void vCargaFacturas() ;
void vDeterminaCicloFactura();
void vAsignaFacturas();
void vValidaCancelados();
void vRecuperaFactura();
void vCargaEnlaceHist();
void vRecuperaMontosFactura();
void vSeleccionarUniverso();
void vLiberaCancelados(stCancelados * );
void liberar_enlaceshist(stEnlaceHist * );
void liberar_idfactura(stIdFactura * );
void liberar_abonado(stAbonado * );
void liberar_factura(stFactura * );
void liberar_memoria(stUniverso * );
void inserta_valores();


/* ------------------------------------------------------------------------- */
