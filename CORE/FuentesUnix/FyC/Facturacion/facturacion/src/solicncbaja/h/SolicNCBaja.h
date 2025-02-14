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
#include <fcntl.h>
#include <math.h>
#include <time.h>
#include <GenFA.h>
#include <predefs.h>
#include <New_Interfact.h>
#include <unistd.h>

#define PATHLEN         250
#define MAXFETCH       2000
#define MAXINSERT      1000
#define GLOSA_PROG     "MANTENCION SOBRE LAS SOLICITUDES DE NC. PENDIENTES"
#define PROG_VERSION   "1.0"
#define LOGNAME        "SolicNCBajas"
#define	ERRNAME        "SolicNCBajas"

#define iLOGNIVEL_DEF       3	   /* NIVEL DE LOG POR DEFAULT.*/ 
#define EXIT_0              0      /* TERMINO DE PROCESO SIN ERROR */ 
#define LOG01				1
#define LOG02				2
#define LOG03				3
#define LOG04				4
#define LOG05				5
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define	LC_TIME_SPANISH	"es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/


char  szFuncName[PATHLEN];         /* NOMBRE DE LA FUNCION O ACCION A EJECUTAR */

static char szRaya[] = "----------------------------------------------------------------";

static char szUso[] =
  "\nUso: "
  "SolicNCBajas -u User/Pass -cCiclFact[<DDMMYY>] -lLogLevel[3]";

char	szLogName[PATHLEN] ;
char	szErrName[PATHLEN] ;
char *  pszEnvLog;
long	lSegIni, lSegFin, lSegProceso;
int		iCodErr     = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar argumentos externos.              */
/*---------------------------------------------------------------------------*/
typedef  struct reg_argumentos
{
   int   bFlagUser;
   int   bFlagPeriodo;
   int   bFlagLogLevel;
   char  szUser[30];
   char  szPass[30];
   long  lCodPeriodo;
   int	 iLogLevel;
}rg_argumentos;
rg_argumentos  stArgs;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef	struct REG_ESTADIST		
{
	long	lSegProceso		;
	int		iSolProc    	;
	int		iSolRechazadas	;
	int		iSolEmitidas	;
}rg_estadistica;
rg_estadistica	stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA PARA ALMACENAT LISTA DE ABONADOS CON VENTASPENDIENTES          */
/*---------------------------------------------------------------------------*/
struct reg_universo
{
	char	szRowId[20];	
	long	lCodCliente;
	long	lNumAbonado;
	int		iCodCiclFact;
	char	szFecSolicitud[22];
	char	szFecBaja[9];
	long	lNumProceso;
	char	szFecProceso[22];
	short	iFecProceso;
	int		iFlagEmision;
	char	szGlsEmision[61];
	short	iGlsEmision;
	char	szNomUsuarioSolic[31];
	char	szFecUltMod[22];
	struct  reg_universo * sgte;
};
typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;


/*---------------------------------------------------------------------------*/
char * alm_trim(char *);


/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

