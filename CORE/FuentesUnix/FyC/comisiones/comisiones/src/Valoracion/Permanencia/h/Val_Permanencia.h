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

#define MAXARRAY       	250
#define GLOSA_PROG     	"PROGRAMA DE COMISION POR PERMANENCIA"
#define PROG_VERSION  	"CUZCO 4.0"
#define LOGNAME        	"Val_Permanencia"
#define SQLNOTFOUND    	100
#define SQLOK          	0
#define LAST_REVIEW		"07-OCTUBRE-2003 (mwn70252)"
#define FORMACOMIS		"PERMANENCI"

/*---------------------------------------------------------------------------*/
/* Valores constantes propios del proceso de valoración Bono Cartera.        */
/*---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG */

char    *pszEnvLog      = "";
char    *pszEnvDat      = "";
char    szLogName[MAXARRAY] ;

int     ibiblio         = 0;
long    lSegIni, lSegFin, lSegProceso;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso         ;
        long    lCantRegistros  ;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LOS EVENTOS                                       */
/*---------------------------------------------------------------------------*/
typedef struct reg_evento{
        long            lNum_General;       
        char            szCod_Tipcomis[2];  
        int             iCod_Comisionista;  
        long			lNumAbonado;
        int             iCod_Cliente;       
        char            szTip_Plan[6];      
        char            szCod_Categcliente[11];  
        char            szCod_Estado[3];         
        char            szCod_Situacion[4];
        double          dImp_Comision;
        char			szCod_Oficina[3];
        struct  reg_evento      * sgte;         
}reg_evento;
typedef struct reg_evento stEvento;
stEvento * lstEvento = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE EL TASADOR DE CONCEPTOS COMISIONALES              */
/*---------------------------------------------------------------------------*/
typedef struct reg_principal{  
		int		iCodTipoRed;		
		char	szCodPlanComis[6];  
		int     iCod_Concepto;
        char    szCod_Tipcomis[3];
        char    szTip_Plan[5];
        char    szFec_Desde[11];
        char    szFec_Hasta[11];
        int     iNum_Periodos;
        char    szIdCiclComis[11];
        char    szInd_Saldo[2];
        char    szTip_Bonificacion[2];
        int     iCod_Concepto_Asoc;
        double  dImp_Bonificacion;
        char	szCodUniverso[7];
        struct  reg_principal   * sgte;
        struct  reg_evento      * sgte_evento;
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal * lstPrincipal = NULL;
/*---------------------------------------------------------------------------*/
