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


#define MAXARRAY                 500
#define GLOSA_PROG              "PROGRAMA DE VALORACION DE COMISIONES POR VENTA CON CONVENIO Y SUSCRIPCIONES PAC "
#define PROG_VERSION            "CUZCO 4.0"
#define LOGNAME                 "Val_ConvenioPAC"
#define DATNAME                 "Val_ConvenioPAC"
#define SQLOK                   0
#define SQLNOTFOUND             100
#define LAST_REVIEW				"02-OCTUBRE-2003 (mwn70252)"
#define FORMACOMIS				"CONVENIPAC"


#define UNIPAC             		"CONPAC"
#define UNIHAB             		"HABCEL"

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG */
char  szFuncName[MAXARRAY];       /* NOMBRE DE LA FUNCION O ACCION A EJECUTAR */

char    *pszEnvLog  = "";
char    *pszEnvDat  = "";
char    szLogName[MAXARRAY] ;
char    szDatName[MAXARRAY] ;
long    lSegIni, lSegFin, lSegProceso;
int     iTotAbonados;
int     iCodErr     = 0;
int     ibiblio = 0;
int     iConceptoDescuento;
int     iCodConcepComisiones;
long    lClienteGenerico;
int     iPl;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        long   	lCantEvaluaciones;
}rg_estadistica;
rg_estadistica  stStatusProc;


/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA PINCIPAL PARA EL CALCULO DE COMISION.         */
/*---------------------------------------------------------------------------*/
typedef struct reg_principal
{
		int		iCodTipoRed;
        char    szCodTipComis[3];
        char	szCodPlanComis[6];
        int     iCodConcepto;
        char    szOrigenConvenio[2];
        char	szCodUniverso[7];
        double  dImpComision;
        char    szFec_Desde[11];
        char    szFec_Hasta[11];        
        struct  reg_principal   * sgte;
        struct  reg_eventos     * sgte_evento;
        
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal * lstPrincipal = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LAS HABILITACIONES DE VENTAS DEL PERIODO          */
/*---------------------------------------------------------------------------*/
typedef struct reg_eventos{
        long    lNum_General;
        long    lCod_Comisionista;
        char    szFec_Venta[11];
        struct  reg_eventos     * sgte;
}reg_eventos;
typedef struct reg_eventos stEventos;


/*---------------------------------------------------------------------------*/
char * alm_trim(char *);
