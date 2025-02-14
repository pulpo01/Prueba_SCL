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
#define	LOGNAME			"Val_Churn"
#define GLOSA_PROG     	"PROGRAMA DE VALORACION SEGUN INDICADOR CHURN"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"06-OCTUBRE-2003 (mwn70192)"
#define FORMACOMIS		"COMISCHURN"
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
        long    lCantEvaluaciones;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LOS EVENTOS GENERADOS MEDIANTE EL PROCESO         */
/*---------------------------------------------------------------------------*/
typedef struct reg_evento
{
        long    lNumGeneral;
        long    lCodConcepto;
        long    lCodComisionista;      
        double  dImpComision;
        struct  reg_evento      * sgte;
}reg_evento;
typedef struct reg_evento stEvento;
stEvento * lstEvento = NULL;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA PRINCIPAL PARA EL CALCULO DE COMISION.        */
/*---------------------------------------------------------------------------*/
typedef struct reg_habilitado
{
    	int	   	iCodTipoRed;
        long    lNumGeneral;   
        char    szCodTipComis[3];
        long    lCodComisionista; 
        long    lCodCiclComis;    
        char    szIdCiclComis[11];
        long    lNumAltas;
        long    lNumBajas;
        double  dNumChurn;
        struct  reg_habilitado  * sgte;         
}reg_habilitado;
typedef struct reg_habilitado stHabilitado;
stHabilitado * lstHabilitado = NULL;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LA MATRIZ CON LAS VALORACIONES CORRESPONDIENTES   */
/*---------------------------------------------------------------------------*/
typedef struct reg_matriz
{
        double  dNumDesde;
        double  dNumHasta;
        double  dImpComision;
        struct  reg_matriz      * sgte;
}reg_matriz;
typedef struct reg_matriz stMatriz;
stMatriz * lstMatriz = NULL;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA PRINCIPAL PARA EL CALCULO DE COMISION.        */
/*---------------------------------------------------------------------------*/
typedef struct reg_principal
{
    	int	   	iCodTipoRed;
		char	szCodPlanComis[6];
        long    lCodConcepto;
        char    szCodTipComis[3];
        long    lCodComisionista;
        char    szCodUniverso[7];
        long    lPeriodoDesde;
        long    lPeriodoHasta;
        struct  reg_principal   * sgte;
        struct  reg_matriz      * sgte_matriz;
        struct  reg_evento      * sgte_evento;  
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal * lstPrincipal = NULL;
/*---------------------------------------------------------------------------*/
int bCargaConceptos();
void vLlenaTasador();
void vLlenaMatriz();
stMatriz * Carga_Matriz(int , char * , int );
void vLlenaHabilitados();
void vAplicaComision();
double lGetImporte(stMatriz * , float );
void vCarga_Eventos (stPrincipal * , stHabilitado * , double );
void vInsertaValorizados();                                                                                     
void vLiberaPrincipal(stPrincipal * );
void vLiberaDatosHabilitado(stHabilitado *);                  
void vLiberaDatosMatriz(stMatriz *);
void vLiberaDatosEvento(stEvento *);
