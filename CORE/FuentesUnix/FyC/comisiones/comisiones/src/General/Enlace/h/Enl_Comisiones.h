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

#define GLOSA_PROG     "ENLACE DE COMISIONES"
#define PROG_VERSION   "CUZCO 4.0.1"
#define LAST_REVIEW    "26-SEP-2003 (mwn70192)."
#define LOGNAME        "Enl_Comisiones"

#define SQLOK                   0
#define SQLNOTFOUND             100
#define PATHLEN                 500
#define MAX_TABLAS              13


/*--------------------------------------------------------*/
/* Definicion de acciones                                 */
/*--------------------------------------------------------*/

#define INICIO              1
#define PROCESO             2
#define CERRADO             3
#define REVERSA_SELECCION   4
#define REVERSA_LIQUIDACION 5

/*--------------------------------------------------------*/
/* Definicion de Universos                                */
/*--------------------------------------------------------*/

#define HABCEL              "HABCEL"
#define HABPRE              "HABPRE"
#define RECHAZ              "RECHAZ"
#define BAJAS               "BAJAS"
#define CARTER              "CARTER"
#define EVALUA              "EVALUA"   
#define CONPAC              "CONPAC"   
 

/*--------------------------------------------------------*/
/* Definicion de Bloques de proceso                       */
/*--------------------------------------------------------*/
#define SEL_MENSUAL         "SEL_MENSUAL"
#define LIQ_MENSUAL         "LIQ_MENSUAL"
#define CIE_MENSUAL         "CIE_MENSUAL"
#define REV_SELECCION       "REV_SELECCION"
#define REV_LIQUIDACION     "REV_LIQ_MENSUAL"

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
char    szLogName[PATHLEN] ;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
}rg_estadistica;
rg_estadistica  stStatusProc;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar nombres de tablas                 */
/*---------------------------------------------------------------------------*/
typedef struct REG_TABLAS               
{
        char szTablasLogicas[MAX_TABLAS][30];
        char szTablasFisicas[MAX_TABLAS][30];
}rg_tablas;
rg_tablas       stTablas;

/*---------------------------------------------------------------------------*/
char    *pszEnviron (char *pszVarAmb, char *pszAmbiente);
char    *pszGetDateLog ( void );
long    lGetTimer ( void );
void    vFechaHora ( void );
void    vWriteLog (FILE *Args,...);
char    *pszFechaHora ( void );
int     iGeneraEnlace(int iAccion);
int     iExisteRegistro();
