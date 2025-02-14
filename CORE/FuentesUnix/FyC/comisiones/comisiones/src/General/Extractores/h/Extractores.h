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


#define DEC(c)  (((c) - ' ') & 077)             

/*---------------------------------------------------------------------------*/
/* Definiciones de caracter general para el programa.                        */
/*---------------------------------------------------------------------------*/
#define MAXARRAY     		500
#define GLOSA_PROG          "EJECUTA PROCESO DE EXTRACCION DE DATOS PARA COMISIONES EXTERNAS (SADECOM)"
#define LOGNAME             "Extractores"
/*#define LAST_REVIEW			"28-ABR-2005 MWT00100"*/
#define LAST_REVIEW         "07-10-2005 (mwt00100)."  /*XO-200510070817 Se incluye detalle de error en generación de nueva secuencia*/
#define PROG_VERSION    	"CUSCO 5.1"

#define SQLNOTFOUND     	100
#define SQLOK             	0
#define SQLUNIQUE           -1
#define FAILURE          	-1
#define RET_OK              0
#define MAXFETCH            500
/*---------------------------------------------------------------------------*/
/* Definicion de codigos de retorno del programa ejecutable (exit's code)    */
/*---------------------------------------------------------------------------*/
#define EXIT_01         1               /* Error en argumentos externos */
#define EXIT_03         3               /* Error en apertura de archivo de log */
#define EXIT_04         4               /* Error en apertura de archivo de datos de entrada */
#define EXIT_06         6               /* Usuario/Password Oracle son incorrectos */
/*---------------------------------------------------------------------------*/
/* Nombres de Procesos...                                                    */
/*---------------------------------------------------------------------------*/
#define prcLISTOPACK		"Ext_ListoPack"
#define prcVENTAS			"Ext_Ventas"
#define prcBAJAS			"Ext_Bajas"
#define prcREDVEN			"Ext_RedVentas"


#define uniLISTOPACK		"LISPAC"
#define uniVENTAS			"VENTAS"
#define uniBAJAS			"BAJAS"
#define uniREDVEN			"REDVEN"

/*---------------------------------------------------------------------------*/
FILE  * pfLog;

char *pszEnvLog           = "";
char *pszEnvExe           = "";
char szLogName [250]  = "";
/*---------------------------------------------------------------------------*/
static char szUsonew[] =
  "\nUso: "
  "Extractores -uUser/Pass -dDesde[<YYYYMMDD>] -hHasta[<YYYYMMDD>]";

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar argumentos externos.              */
/*---------------------------------------------------------------------------*/
typedef struct REG_ARGUMENTOS
{
   int   bFlagUser;
   int   bFlagFecDesde;
   int   bFlagFecHasta;
   char  szUser[30];
   char  szPass[30];
   char  szFecDesde[9];
   char  szFecHasta[9];
}rg_argumentosnew;
rg_argumentosnew  stArgsNew;
/*-----------------------------------------------------------------*/
/* Definicion de estructura para almacenar los bloques a ejecutar  */
/*-----------------------------------------------------------------*/
typedef struct reg_procesos
{
	char	szCodUniverso[16];
	char	szDesUniverso[51];
	char	szNomExe[20];
	int		bFlgExisteProceso;
	struct reg_procesos * sgte;
}reg_procesos;
typedef struct reg_procesos stProcesos;
stProcesos * lstProcesos = NULL;

/*-----------------------------------------------------------------*/
void    vSqlErrorNew ();
void    vManejaArgsnew (int argc, char * const argv[]);
stProcesos * stfnCargaProcesos();
int 	bGetNomProceso(char *, char * );
int 	bfnGetStatusExtractor(char * , int *);
int 	bfnEjecutaExtractores();
int 	bfnControlaEjecucion(int );
int 	bfnMarcaEstadoExtractor(int , char );
int		bfnValidaInicioProceso(int , char * );
char 	cfnValidaEjecucionProceso(int , char * );
void 	vMuestraProcesos();
int 	bLanzaProceso(int , char * , char * );
int		bfnInsertaNuevaSecuencia(int );
/*-----------------------------------------------------------------*/
