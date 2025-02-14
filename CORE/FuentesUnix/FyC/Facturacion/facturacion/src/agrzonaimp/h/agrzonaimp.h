#ifndef __AGRZONAIMP_H__
#define __AGRZONAIMP_H__
/************************************************************************************************
* MODULO		: agrzonaimp.h
* Descripción		: Libreria de agrzonaimp.pc 
* Analista responsable	: 
* Programador		: cgf
* Fecha Programación	: 05-Mayo-2005.
************************************************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sqlca.h>
#include <sqlda.h>
#include <signal.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <ctype.h>

#include "deftypes.h"
#include "trazafact.h"
#include "rutinasgen.h"
#include "GenFA.h"

/*************************************
 Declaracion de Constantes
*************************************/
#define      debug1           0
#define      debug            0
#define      true             1
#define      false            0
#define      SqlNotFound      1403
#define      SqlNull          1405
#define      SqlORADUP        1
#define      SqlOk            0
#define      SQLORA_NULL      -1
#define      SQLMANYROWS      2112
#define      and              &&
#define      or               ||
#define      NE               !=
#define      EQ               ==
#define      blanco           32
#define      MaxReg           500
#define      Maxprefespe      500
#define      MaxReg           500
#define      MAXFILE 215
#define      MAX_TIEMPO 2000
#define      KEYCOLASCH     000002
#define      MSGSZ    500

/*****************************************************************************/
/* IDENTIFICACION DEL PROGRAMA                                               */
/*****************************************************************************/
#define NOM_PROGRAMA	"agrzonaimp"   
#define PROG_VERSIONDES "1.0.0"
#define PROG_VERSIONSOP "0.0.0"
#define FEC_VERSIONSOP  "xx-xxx-xxxx"
#define FEC_VERSIONDES  "05-May-2005"
#define GLS_PROGRAMA	"Agrupacion por zona impositiva de la tabla TOL_ACUMOPER_TO."
#define RAYA            "------------------------------------------------------------"

/*****************************************************************************/
/* CONSTANTES DEL PROGRAMA                                                   */
/*****************************************************************************/
#define FLG_DEBUG             0
#define EXISTE               -1 
#define OK                    0
#define ERROR                -1
#define SqlTableNotExists  -942

/*--- TOL_RECOVERY-------------*/
#define PROC_ACTZONAI "ACTZONAI"
#define PROC_PROCESAN "PROCESAN"
#define PROC_TRASPASA "TRASPASA"
#define PROC_ACUMOPER "ACUMOPER"
#define PROC_TRUNCATE "TRUNCATE"
#define ESTADO_INI    "INI"
#define ESTADO_TER    "TER"
#define ESTADO_PRO    "PRO"
#define VALOR_100     "100"
#define ESTADO_VI     "VI"
#define ESTADO_CL     "CL"
#define ESTADO_PCIER  "PCIER"
#define PROCESO       "TOL"
#define VALOR_0       "0"
#define VALOR_N       "N"
#define VACIO         " "
#define REG_CURSOR    100000
#define SUBPROCESO_0  0
#define SUBPROCESO_1  1

#define PROC_AGRZONAIMP "AGRZIMPO"
#define PROC_RESPALDO   "RESPATOT"

#define PROC_RZOIM   "RZOIM"
#define PROC_ZOIMP   "ZOIMP"

/* Macros utilizadas en TRUNCATE */
#define FA_ACUMOPER_RESP_TH      1
#define FA_ACUMOPER_RESP_CICL_TH 2
#define FA_AGRZONAIMP_TO         3
#define TOL_ACUMOPER_TO          4

/* Maximo de ciclos a soportar */
#define MAX_CICLOS               1000

#ifndef iPROC_AGRZONAIMP
#define iPROC_AGRZONAIMP		 2900
#endif


FILE *p;

time_t now;
char curtime[40];

typedef struct TagCiclo
{
    int     ihCodCiclo;
    long    lhCodCiclFact;
    char    szhFechaEmision[20];    
}DATOSCICLO;


typedef struct TagCiclos
{
    int iCantCiclos;
    DATOSCICLO stCiclo[MAX_CICLOS];        
}ST_CICLOS;

/* Estructura para cargar ciclos */
ST_CICLOS stCiclos;

typedef struct TagDatosHost
{
    char    szHostId[25];
    BOOL     bExisteHostId;    
}DATOSHOST;



/*****************************************************************************/
/* LISTAS DE FUNCIONES                                                       */
/*****************************************************************************/
extern void sigTermHandler(int p);
void   vfnMsgError(char *, int  , int  );
void   vEncabezado(void);
int    ifnVerificarAperturaCiclo (long lCodCiclFact);
int    ifnTruncateTable(int iIdTabla, int iIngRngCli, long lClienteIni, long lClienteFin);
int    ifnExisteFa_recovery( char* pProceso, char* pEstado, int iModulo, long lCanReg, DATOSHOST stDatosHost);
int    ifnCargaFa_recovery_to( char* , char* , long, long, char* );
void   vfnLeeFa_recovery( char *pTabla, char* pProceso, char* pEstado1, int iCursor, int iModulo, DATOSHOST stDatosHost);
void   vfnGetEstado(char* pProceso, int iModulo, DATOSHOST stDatosHost);
int    ifnUpdateRecovery(char* pProceso, int iModulo, char* pEstado, DATOSHOST stDatosHost);
int    ifnValidaZonaimp (DATOSHOST stDatosHost, int iIngRngCli, long lClienteIni, long lClienteFin);
void   vfnDeleteRecovery( char* pProceso, long lModulo, DATOSHOST stDatosHost);
int    ifnCuentaAbiertos(void);
int    ifnEsNumerico(char *pszCad);
int    ifnExisteProcCiclo(long lCodCicloFact, DATOSHOST stDatosHost);
int    ifnObtenerCiclosParaAgrupar(long lCodCiclFact, int iExistRngClientes, long lClieIni, long lClieFin);
char   *ltrim(char *s);
char   *rtrim(char *s);
char   *alltrim(char *s);
BOOL   bfnAbreArchivosLog(long lCodCiclFact, int iLogLevel);
BOOL   bfnWrapperValidaTrazaProc(long lCodCiclFact,int iCodProceso, int iIndFacturacion);
BOOL   bfnWrapperSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza);
BOOL   bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza);
void   vfnSalidaExit(void);

#endif
