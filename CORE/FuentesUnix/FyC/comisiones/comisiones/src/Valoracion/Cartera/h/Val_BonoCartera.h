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


#define MAXARRAY         250
#define GLOSA_PROG     "VALORACIÓN DE BONOS POR CARTERA DE ABONADOS"
#define PROG_VERSION   	"CUZCO 4.0"
#define LOGNAME        "Val_BonoCartera"
#define DATNAME        "Val_BonoCartera"
#define SQLNOTFOUND    100
#define FORMACOMIS	   "CARTERA"
#define SQLOK          0
#define LAST_REVIEW		"02-OCTUBRE-2003 (mwn70252)"

/*---------------------------------------------------------------------------*/
/* Valores constantes propios del proceso de valoración Bono Cartera.        */
/*---------------------------------------------------------------------------*/
#define CONCEPTO          5
#define UNIVERSO          "CARTER"
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* PARAMETROS GENERALES LEIDOS DESDE CMD_PARAMETROS                          */
/*---------------------------------------------------------------------------*/
int     iValPorcen    = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG */

char    *pszEnvLog      = "";
char    szLogName[MAXARRAY] ;
long    lSegIni, lSegFin, lSegProceso;
int     iTotAbonados;
int     ibiblio         = 0;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        long    lCantRegistros;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* estructura para recoger estados de resultado del proceso                  */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
        long    lNumGeneral;
        int     ihCodComisionista;
        double  dImpFactura;
        double  dImpComision;
        struct  reg_universo * sgte;
        
}reg_universo;
typedef struct reg_universo stUniverso;

/*---------------------------------------------------------------------------*/
typedef struct reg_resumen{
		int		iCodTipoRed;
		char    szCodTipComis[3];
		char	szCodPlanComis[6];
		char	szCodUniverso[7];
		int		iCod_Concepto;
		long    lCantAbonados;
        double  dTotFactura;
        double  dImpComision;
        int		iVal_Porcentaje;
        struct  reg_resumen * sgte;
        struct  reg_universo * sgte_dato;
}reg_resumen;
typedef struct reg_resumen stResumen;
stResumen * lstResumen = NULL;  
/*---------------------------------------------------------------------------*/

