#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>

#define GLOSA_PROG     "SELECCION DE VENTAS CONTRATOS CELULARES"
#define PROG_VERSION   "CUSCO 4.0"
#define LAST_REVIEW    "30-JUL-2003 (mwt00100)."
#define LOGNAME        "Sel_Ventas"

#define PATHLEN         250
#define UNIVERSO       "HABCEL"
/*---------------------------------------------------------------------------*/
/* Definicion de dia habil.                                                  */
/*---------------------------------------------------------------------------*/
#define HABIL           1

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;
char *pszEnvLog           = "";
char szLogName [250]  = "";

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   long         lSegProceso ;
   long         lCantRegistros;
}rg_estadistica;
rg_estadistica stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE VENTAS SELECCIONADAS                                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
	int		iCodTipoRed;
	char	szCodTipComis[3];
	long	lCodComisonista;
	char	szCodTipVendedor[3];
	long	lCodVendedor;
	long	lCodVendDealer;

	char  	szNumContrato[20];      
	int		iCodModVenta;
	long  	lNumVenta;
	int   	iIndDocComp;
	int   	iIndConvenio; 
	char 	szObsIncump[151];
	char  	szCodOficina[3];
	char  	szFecVenta[20];
	char  	szFecRecepcion[20];
	char  	szFecAceptacion[20];

	long  	lCodCliente;
	char  	szNumIdent[20];
	char	szCodCategoria[11];

	char  	cIndConsidera;  
	int		iDiasHabiles;
	int  	iDiasReales;

	struct 	reg_universo * sgte;
	struct 	reg_abonado  * abonado_sgte;
}reg_universo;

typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE ABONADOS DE LA VENTA.                                       */
/*---------------------------------------------------------------------------*/
struct reg_abonado{
	long  	lNumCelular;
	char  	szCodPlanTarif[4];
	char  	szNumSerie[26];
	long  	lNumAbonado;
	int	 	iCodAfinidad;
	char  	szCodTecnologia[8]; 
	char  	cIndProcequi;
	long  	lCodArticulo;
	char  	cIndConsidera;  
	struct 	reg_abonado * sgte;
};
typedef struct reg_abonado stAbonado;
/*------------------------------------------------------------------------------*/
int  iGetNumDias(char *, char * );
int iCalculaDiasHabiles (char * , char * );
void vFiltraGlosa(char *,char * );
void vSeleccionarUniverso(int , char * , char * );
void vNoConsidera();
void vGetAbonados();
void vGetClientes();
void vGetEquipos();
void vValidaDupConvenio();
void vInsertaSeleccion();
void vLiberaUniverso();


