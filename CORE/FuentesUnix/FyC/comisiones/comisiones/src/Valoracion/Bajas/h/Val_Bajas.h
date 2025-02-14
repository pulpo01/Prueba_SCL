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
#include <utils.h>
#include <libgen.h>
#include <geora.h>

#define MAXARRAY       	2000

#define	LOGNAME			"Val_Bajas"
#define GLOSA_PROG     	"PROGRAMA DE VALORACION DE BAJAS CELULARES"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"02-OCTUBRE-2003 (mwn70192)"
#define FORMACOMIS		"BAJASRECHA"

#define ITIPOCODIGO     7  /* FAMILIA DE PARAMETROS PENAÑLIZACION POR BAJA Y RECHAZO */
/* Definicion de Universos Utilizados */
#define UNIBAJAS        "BAJAS"
#define UNIRECHAZO      "RECHAZ"

#define iDIASVENTA              1
#define iDIASRECEP              2
#define iDIASCUMPL              3
#define iDIASACEPT              4

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG */
char  *pszEnvLog      = "";
/*---------------------------------------------------------------------------*/
/* DEFINICION DE ESTRUCTURA PARA MANEJAR ESTADISTICAS DEL PROCESO.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso             ;
        long    lCantBajasRead          ;
        long    lCantRechaRead          ;
        long    lCantBajasWrit          ;
        long    lCantRechaWrit          ;
}rg_estadistica;
rg_estadistica  stStatusProc;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LAS BAJAS O RECHAZOS                              */
/*---------------------------------------------------------------------------*/
typedef struct reg_evento{
    int	    	iCodTipoRed;
    long        lNumGeneral;     
    char        szCodUniverso[7];     
    char        szCodTipComis[3];       
    long        lCodComisionista;
    long        lNumCelular;
    char        szCodCategCliente[11];
    char        szCodPlanTarif[4];      
    char        szFechaEvento[11];  
    char        szCodCausaBaja[3];         
    char        szNomUsuario[31];       
    char        szIndProcequi[2];      
    char        szCodCategoria[4];
    char        szTipPlan[6];          
    int         iDiasVenta;      
    int         iDiasRecepcion;       
    int         iDiasAceptacion;
    double      dImporteTotal;
    double      dImporteBase;
    double      dImporteEquipo;
    double      dImporteTrafico;
    long        lCantMinutos;
    double      dImporteTarifa;
    struct  	reg_evento      * sgte;
}reg_evento;
typedef struct reg_evento stEvento;
stEvento * lstBajas    = NULL;
stEvento * lstRechazos = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LAS CAUSAS DE BAJA/RECHAZO                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_param{       
    char    szValParametro1[11];
    struct  reg_param       * sgte;
}reg_param;
typedef struct reg_param stParam;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE EL DETALLE DE PLAZOS                              */
/*---------------------------------------------------------------------------*/
typedef struct reg_tiempos{
    int     iDiasDesde;
    int     iDiasHasta;
    double  dImpPenaliza;
    struct  reg_tiempos     * sgte;
}reg_tiempos;
typedef struct reg_tiempos stTiempos;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LOS DETALLES DE POLAN/CATEG. CLIENTE              */
/*---------------------------------------------------------------------------*/
typedef struct reg_plan{
    char    szTipPlan[6];
    char    szCodCategCliente[11];
    double  dImporteBase;
    double  dImporteEquipo;
    struct  reg_plan        * sgte; 
    struct  reg_tiempos     * sgte_tiempo;
}reg_plan;
typedef struct reg_plan stPlan;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LOS CONCEPTOS COMISIONALES                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_principal{
    int	    iCodTipoRed;
    char    szCodPlanComis[6];
    int     iCodConcepto;            
    char    szCodTipComis[3];        
    char    szCodUniverso[7];       
    char    szIndTrafico[2];  
    char    szIndProcequi[2];
    char    szCodTipCalculo[2];    
    
    int     iNomFechaDesde;    
    int     iNumListaCausa;       
    int     iNumListaUsuaExcep;   
    int     iNum_FechaDesde;  
    char	szFecDesde[11];
    char	szFecHasta[11];  
    struct  reg_principal   * sgte;
    struct  reg_plan        * sgte_plan;
    struct  reg_param       * sgte_causa;
    struct  reg_param       * sgte_usuar;
    struct  reg_evento      * sgte_evento;
               
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal *   lstPrincipal = NULL;
/*---------------------------------------------------------------------------*/
int bCargaConceptos();
void vCargaPrincipal();
stPrincipal * stfnCreaPrincipal();
stPlan * stCargaPlan(int , char * , int );
stTiempos *stCargaTiempo(int ,char *,int, char *,char *);
stParam * stCargaParam( int );
stEvento * stCargaEventosBaja();
char * szfnCategoriaPlan(char * ,char * );
stEvento * stCargaEventosRechazo();
void vCalculaComision(stEvento *);
int bValidaEvento(stPrincipal * , stEvento * );
BOOL bBuscaParametro(stParam * ,char * );
void vAsignaImporteBase(stPlan *, stEvento * ,char * , int );
int iGetDiasDesde(stEvento * , int );
double dGetImportePlazos(stTiempos * ,int );
void vAsignaImporteTrafico(stEvento * );
void vEvaluaUsuarioExepcion(stParam * ,stEvento * );
void vGrabaPrincipal();
void vLiberaPrincipal(stPrincipal * );
void vLiberaDatosPlan(stPlan * );
void vLiberaDatosTiempo(stTiempos * );
void vLiberaDatosParam(stParam * );
void vLiberaDatosEvento(stEvento * );
