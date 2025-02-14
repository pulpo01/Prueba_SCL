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
#include <utils.h>

#define MAXARRAY     		500
#define GLOSA_PROG          "PROGRAMA DE CIERRE DE PERIODO DE COMISIONES"
#define LOG_NAME            "Cie_Comisiones"
#define LAST_REVIEW			"28-OCT-2003 MWT00100"
#define PROG_VERSION    	"CUSCO 4.0"

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE  * pfLog;
char    *pszEnvLog  = "";
char    szLogName[MAXARRAY] ;
long    lSegIni, lSegFin, lSegProceso;
int     ibiblio = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
	long    lSegProceso;
	long	lCantAjustes;
	long	lCantFacturasCoap;
	long	lCantAnticipos;
}rg_estadistica;
rg_estadistica  stStatusProc;

