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
#include <utils.h>
#include <libgen.h>

#define MAXARRAY       	2000
#define	LOGNAME			"Val_Documentacion"
#define GLOSA_PROG     	"PROGRAMA DE VALORACION DE COMISION POR CALIDAD DE DOCUMENTACION Y PLAZOS DE ENTREGA"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"07-OCTUBRE-2003 (mwn70192)"
#define FORMACOMIS		"DOCUMENTAC"

#define OFIC_CENTRAL    "C"
#define OFIC_REGIONAL   "R"
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG */
char    *pszEnvLog  = "";
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
   long    lSegProceso     ;
   long    lCantEHabilitaciones;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA DE PLAZOS DE ENTREGA DE DOCUMENTACION.        */
/*---------------------------------------------------------------------------*/
struct reg_plazos
{
   char    szTipoOficina[2];
   int     iDiasDesde;
   int     iDiasHasta;
   double  dImpComision;
   struct  reg_plazos              * sgte;
};
typedef struct reg_plazos stPlazos;
stPlazos * lstPlazos = NULL;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA DE TIPOS DE PLAN Y CATEGORIAS DE CLIENTE.     */
/*---------------------------------------------------------------------------*/
struct reg_plan
{
    char    szTipPlan[7];
    char    szCodCategCliente[11];
    double  dImpComision;
    struct  reg_plan                * sgte;
    struct  reg_plazos              * sgte_plazo;
}reg_plan;
typedef struct reg_plan stPlanes;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA DE EVENTOS COMISIONALES.                      */
/*---------------------------------------------------------------------------*/
typedef struct reg_eventos
{
    long    lNumGeneral;
    long	lCodComisionista;
    char    szTipPlan[7];
    char    szCodCategCliente[11];
    char    szCodOficina[4];
    int     iIndDocum;
    char    szObsIncump[151];
    double  dImporte;
    int     iCodConcepto;
    struct  reg_eventos * sgte;
}reg_eventos;
typedef struct reg_eventos stEvento;
stEvento * lstEvento = NULL;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA PINCIPAL PARA EL CALCULO DE COMISION.         */
/*---------------------------------------------------------------------------*/
typedef struct reg_principal
{
	int		iCodTipoRed;		
	char	szCodPlanComis[6];	
    char    szCodTipComis[3];
    int     iCodConcepto;
    double  dFechaDesde; 
    double  dFechaHasta; 
    char	szFecDesde[11];
    char	szFecHasta[11];
    char    szTipoEvaluacion[2];
    char    szTipConcepto[2];
    int     iContador;
    char	szCodUniverso[7];
	char	szCodTecnologia[8];    
    struct  reg_principal   * sgte;
    struct  reg_plan        * sgte_plan;
    struct  reg_eventos     * sgte_evento;
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal * lstPrincipal = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LAS HABILITACIONES DEL PERIODO                   */
/*---------------------------------------------------------------------------*/
typedef struct reg_habilitado{
	int		iCodTipoRed;		
    long    lNumGeneral;   
    char    szCodCategCliente[11];
    char    szTipPlan[7];   
    char    szCodTipComis[3];
    long    lCodComisionista;
    double  dFechaVenta;
    char	szFechaVenta[11];
    double  dFechaRecepcion;
    int     iNumDiasHabiles;
    char    szCodOficina[4];
    char    szTipoOficina[2];
    char    szObsIncump[151];
    int     iIndDocum;
	char	szCodTecnologia[8];
    struct  reg_habilitado  * sgte; 
}reg_habilitado;
typedef struct reg_habilitado stHabilitado;
stHabilitado * lstHabilitado = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE ALMACENA OFICINAS                                          */
/*---------------------------------------------------------------------------*/
typedef struct reg_oficinas{
    char    szCodOficina[4];       
    struct  reg_oficinas    * sgte; 
}reg_oficinas;
typedef struct reg_oficinas stOficinas;
stOficinas * lstOfCentrales = NULL;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE VALORACION DE COMISION DIFERENCIADA.                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_comdiferenciada
{
	int		iCodTipoRed;		
	char	szCodPlanComis[6];	
    int     iCodConcepto;
    char    szTipPlan[7];   
    char    szCodCategCliente[11];
    long    lCodComisionista;
    double  dImpDiferenciado;
    struct reg_comdiferenciada 	* sgte;
} stComDiferenciada;
stComDiferenciada * lstComDiferenciada = NULL;

/*---------------------------------------------------------------------------*/
char * szfnGetTipoOficina(char * );
stEvento * GeneraEvento(stPrincipal * , stHabilitado * , double );
stPlanes * fnCargaPlanes (int , char * , int );
stPlazos * fnCargaPlazos (int , char * , int , char * , char * );
stComDiferenciada * stCargaComDiferenciada();
stPlanes * stBuscaPlanCte(stHabilitado * , stPlanes * , char * );
stPrincipal * vLlenaTasador();
double lGetImporte(stPlazos * , int , char * );
double dImporteDiferenciada(stComDiferenciada * ,stPrincipal * , stHabilitado * );
int bfnVerificaOficina(stOficinas * , char * );
int bCargaConceptos();
int bfnCondicion(stHabilitado * , stPrincipal * );
void vLlenaHabilitaciones();
void vValoraHabilitaciones();
void vLlenaPlanes();
void vLlenaOficinasCentrales ();
void vInsertaValorizados();
void vLiberaPrincipal(stPrincipal * );
void vLiberaDatosPlanes(stPlanes * );
void vLiberaDatosEvento(stEvento * );
void vLiberaDatosHabilitado(stHabilitado * );
void vLiberaComisionDiferenciada(stComDiferenciada *);
