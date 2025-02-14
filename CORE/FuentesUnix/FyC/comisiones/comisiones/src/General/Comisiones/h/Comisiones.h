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
#define GLOSA_PROG          "EJECUTA PROCESO DE COMISIONES (CORRELACION DE PROCESOS)"
#define LOG_NAME            "Comisiones"
#define LAST_REVIEW			"28-OCT-2003 MWT00100"
#define PROG_VERSION    	"CUSCO 4.0"

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
/* Definicion de estados de Proceso */
/*---------------------------------------------------------------------------*/
#define ELog          400   /* Error al generar archivo de log*/
#define ELineaProceso 450   /* Error en codigo de linea de proceso*/
#define EIdProceso    460   /* Error en Id Periodo de proceso*/
#define EConnect      500   /* Error al Conectarse a la Base de Datos*/
#define EOK           300   /* Proceso ok*/
/*---------------------------------------------------------------------------*/
/* Definicion de estados de cuenta procesada */
/*---------------------------------------------------------------------------*/
#define estInicial     "INI"  /*  Periodo inicial    */
#define estEnProceso   "PRC"  /*  Periodo en proceso */
#define estCerrado     "CER"  /*  Periodo cerrado   */
#define estTerminado   "TER"  /*  Periodo Terminado */
#define estTermError   "FAL"  /*  Periodo terminado con error ... Falla */
#define estNoIniciado  "NIN"  /*  Periodo NO iniciado */
/*---------------------------------------------------------------------------*/
#define estTrazaFAL  'F'        /*  Proceso o Bloque terminado con error */
#define estTrazaPRC  'I'        /*  Proceso o Bloque Iniciado            */
#define estTrazaTER  'T'        /*  Proceso o Bloque Terminado con Exito */
#define estTrazaNIN  'N'        /*  Proceso o Bloque No Iniciado         */
/*---------------------------------------------------------------------------*/
#define PERIODICO	'P'			/* Tipo de periodo normal o periodico    	 */
#define ESPORADICO  'E'			/* Tipo de periodo esporádico o promocion	 */
/*---------------------------------------------------------------------------*/
/* Otras variables...                                                        */
/*---------------------------------------------------------------------------*/
int      iFlgReproceso;

int  EstadoLimpieza=0;
int  EstadoProceso = 300;
int  salidaCarga = 0;
int  salidaProcesos = 0;
int  salidaMarcaEstadoPeriodo = 0;
int  salidaProcesoPuntual;
int  numProceso;
char sglosa[25];

int  cantProcesos=0;

int  RegOk=0;

FILE  * pfLog;

char *pszEnvLog           = "";
char szLogName [250]  = "";

/*---------------------------------------------------------------------------*/


static char szUsonew[] =
  "\nUso: "
  "Comisiones <-u[User/Pass]> -l[LP] -i[YYYYMMDD<M|Q|S><1..4>] -f[S|N]";


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
        char    szUser[30];
        char    szPass[30];
        long    lCodPeriodo;
        char    szIdPeriodo[11];
        char    szIndSeleccion;
        char    szCodLineaProc[3];

        int    	bFlagUser;
        int    	bFlagCodPeriodo;
        int    	bFlagIdPeriodo;
        int    	bFlagIndSeleccion;
        int    	bFlagCodLineaProc;
}rg_argumentosnew;
rg_argumentosnew  stArgsNew;
/*-----------------------------------------------------------------*/
/* Definicion de estructura para almacenar los bloques a ejecutar  */
/*-----------------------------------------------------------------*/
typedef struct reg_bloques
{
        char    szCodBloque[16];
        int     iOrdBloque;
        char    cIndEjecucion;
        struct reg_procesos * sgte_proceso;
        struct reg_bloques * sgte;
}reg_bloques;
typedef struct reg_bloques stBloques;
stBloques  * lstBloques = NULL;
/*-----------------------------------------------------------------*/
/* Definicion de estructura para almacenar los procesos a ejecutar */
/*-----------------------------------------------------------------*/
typedef struct reg_procesos
{
        char    szCodProceso[16];
        char    szDirProceso[51];
        char    szNomExe[31];
        char    szIndArchivo[2];
        int     iOrdProceso;
        char    szEstado[2];
        char    szTipPeriodo[2];
        char    szIndEjecucion[2];
        struct reg_procesos * sgte;
}reg_procesos;
typedef struct reg_procesos stProcesos;
/*-----------------------------------------------------------------*/
void    vSqlErrorNew ();
void    szMidChar(char *, char * , int , int );
int     ifnExistePeriodo (char * );
void    vManejaArgsnew (int argc, char * const argv[]);
int     bValidaPeriodos();
int     iMarcaEstadoPeriodo(char * , char * );
char    cGetEstadoProceso(long , long );
long    lValidaInicioProceso(long , char * , char * );
void    vCargaBloques();
stProcesos * stCargaProcesos (char * );
void    vCargaEstructuraProcesos();
char    * szFnGetSysDate();
char    cFndBloque(char * , char * );
char    cFndProceso(char * , char * , char * );
int     iActualizaEstadosEjecucion();
void    vActEstadoPeriodo (char *);
long    lCreaTrazaBloque(char *);
void    vActTrazaBloque(long , char);
void    vEjecutaCorrelacion();
int     bLanzaProceso(long,char *,stProcesos *);
int     bEjecutaProcesosCorrelacion();


