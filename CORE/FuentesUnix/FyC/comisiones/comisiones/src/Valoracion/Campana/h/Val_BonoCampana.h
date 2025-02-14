#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <strings.h>
#include <sys/timeb.h>
#include <sys/stat.h>
#include <time.h>
#include <locale.h>
#include <geora.h>
#include <libgen.h>


#define GLOSA_PROG              "PROGRAMA DE VALORACION BONO POR CAMPANA IND - PYME"
#define PROG_VERSION            "CUSCO 4.0"
#define LOGNAME                 "Val_BonoCampana"
#define LAST_REVIEW				"04-SEP-2003 mwt00100/Cuzco"
#define FORMACOMIS				"APOCAMPANA"
#define SQLOK                   0
#define SQLNOTFOUND             100
#define CODUNIVERSO             "HABCEL"
#define NOCATEG					"##$$##$$"
#define PATHLEN					500
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG                */

char    *pszEnvLog  = "";
char    szLogName[PATHLEN] ;
long    lSegIni, lSegFin, lSegProceso;
int     ibiblio = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        long    lCantVentas     ;
        long    lCantNOCATEG    ;
        long	lCantDIFEREN	;
        long	lCantRegistros	;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar detalle de ventas.                  */
/*---------------------------------------------------------------------------*/
struct reg_catventas
{
        char    szCodCategVenta[11];
        char    szTipPlan[6];
        char    szCodCategCliente[11];
        struct  reg_catventas * sgte;
};
typedef struct reg_catventas stCategVentas;
stCategVentas * lstCategVentas = NULL;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura de conceptos de valoración.                      */
/*---------------------------------------------------------------------------*/
struct reg_conceptos
{
	int		iCodTipoRed;		/* Tipo de Red al que pertenece el concepto     */
	char	szCodPlanComis[7];	/* Plan de Comisiones, Sólo Informativo         */
	int		iCodConcepto;		/* Código del Concepto de Comisiones            */
	char	szCodTipComis[3];	/* Se comisiona al nivel de aplicacion dela Red */
	long	lCodComisionista;	/* Comisionista sobre el que se aplica el bono  */
	char	szCodTecnologia[8];	/* Tecnología sobre la que aplica el concepto.  */
	double	dFecDesde; 			/* Fecha desde en formato numérico              */
	double	dFecHasta; 			/* Fecha hasta en formato numérico              */
	char    szCodCategVenta[11];/* Categoria de venta a considerar              */
	char	cIndFechaCorte[2];		/* Indicador de Fecha de Corte                  */
	char	szFecDesde[11];
    char	szFecHasta[11];  
	double	dFechaCorte;		/* Fecha de corte en formato numérico.          */
	long	lCantVentasCorte;	/* Cantidad de Ventas a la fecha de corte       */
	long	lCantVentasTotal;	/* Cantidad total de ventas                     */
	double	dImpConcepto;		/* Importe de comisión logrado por el concepto. */
	char	szCodUniverso[7];	/* Universo sobre el que aplica el concepto     */	
	struct	reg_ventas	  		* sgte_venta;
	struct	reg_detconceptos	* sgte_detalle;
	struct  reg_conceptos 		* sgte;
};
typedef struct reg_conceptos stConceptos;
stConceptos * lstConceptos = NULL;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar detalle de ventas.                  */
/*---------------------------------------------------------------------------*/
struct reg_ventas
{
    long    lNumGeneral;
	int		iCodTipoRed;		
	char	szCodTipComis[3];
	long	lCodComisionista;
	long	lCodVendedor;	
    long    lNumVenta;
    long    lNumAbonado;
    char    szFecVenta[11]; 
    double	dFecVenta;
    char    szTipPlan[6];
    char    szCodCategCliente[11];
    char	szCodCategVenta[11];
    char	szCodTecnologia[8];
    double  dImpComision;
    struct  reg_ventas * sgte;
};
typedef struct reg_ventas stVentas;
stVentas	* lstVentas = NULL;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura de Detalle de Valoración por Campana.            */
/*---------------------------------------------------------------------------*/
struct reg_detconceptos
{
	long	lValUmbral;
	double	dImpComision;
	struct  reg_detconceptos 	* sgte;
};
typedef struct reg_detconceptos stDetConceptos;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura de valoración DIFERENCIADA.                      */
/*---------------------------------------------------------------------------*/
struct reg_diferenciada
{
	int		iCodTipoRed;
	char	szCodPlanComis[6];
	int		iCodConcepto;
	long	lCodVendedor;
	struct 	reg_diferenciada	* sgte;
};
typedef struct reg_diferenciada stDiferenciada;
stDiferenciada	* lstDiferenciada = NULL;
/*---------------------------------------------------------------------------*/
stCategVentas *  stCargaCategVentas();
stDetConceptos * stCargaDetConceptos(int , char * ,int , long , long );
stConceptos * stCargaConceptosLocal();
stDiferenciada * stCargaDiferenciada();
stVentas * stCreaNodoVenta(stVentas * );
stVentas * stCargaVentas();
char * szObtieneCatVenta(stCategVentas * , char * , char * );
int bValidaVenta(stConceptos * , stVentas * );
int bCargaConceptos();
int bComisDiferenciada(long , int , char * , int , stDiferenciada * );
double dObtieneImporte(stDetConceptos * , long );
double dAsignaImporte(stVentas * , double );
void vAsignaVentas();
void vEjecutaValoracion();
void vInsertaValorizados();
void vMuestraConceptos(stConceptos * );
void vLiberaDiferenciada(stDiferenciada * );
void vLiberaCategVenta(stCategVentas * );
void vLiberaVentas(stVentas * );
void vLiebraDetalle(stDetConceptos * );
void vLiberaConceptosLocal(stConceptos * );
void vFechaHora ( void );
char *pszFechaHora ( void );
char *pszEnviron (char *pszVarAmb, char *pszAmbiente);
char *pszGetDateLog ( void );
long lGetTimer ( void );
