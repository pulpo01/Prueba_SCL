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

#define GLOSA_PROG     "PASO HISTORICO RECHAZOS"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "30-SEP-2003 (mwn70192)."
#define LOGNAME        "His_Rechazos"

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
char    *pszEnvCfg  = "";

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        long    lRegInsertosRechazos;
        long    lRegInsertosDetRechazos;
}rg_estadistica;
rg_estadistica  stStatusProc;

/*---------------------------------------------------------------------------*/
void    vCargaTablasHist( void );

