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

#define MAXARRAY        250
#define GLOSA_PROG     	"PROGRAMA DE RECARGAS"
#define PROG_VERSION   	"CUZCO 4.0"
#define LOGNAME        	"Val_Recargas"
#define SQLNOTFOUND    	100
#define SQLOK          	0
#define LAST_REVIEW		"08-OCTUBRE-2003 (mwn70252)"
#define FORMACOMIS		"RECARGAS"

/*---------------------------------------------------------------------------*/
/* Valores constantes propios del proceso de valoración Bono Cartera.        */
/*---------------------------------------------------------------------------*/
#define UNIVERSO          "HABPRE"
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
    long    lNum_General;
    char    szCod_Tipcomis[3];
    long    lCod_Comisionista;
    char    szCod_Universo[7];
    char    szFechaHabilitacion [11];
    double  dImp_Concepto;
    long    lNum_Abonado ;
    long    lNum_Celular ;
    long    lImp_Comision;
    struct  reg_evento * sgte;             
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
    char    szCod_TipComis[3];
    char    szCod_Origen[6];
    double  dMto_Recarga;
    int     iCod_Concepto_Asoc;
    long    iNum_Periodos;
    long    lImp_Comision;
    char	szFecDesde[11];
    char	szFecHasta[11];
    struct  reg_principal  * sgte;
    struct  reg_evento     * sgte_evento;
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal * lstPrincipal = NULL;
/*---------------------------------------------------------------------------*/
