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
#include <utils.h>
#include <libgen.h>

#define GLOSA_PROG     "SELECCION DE COMISIONES"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "24-SEP-2003 (mwn70192)."
#define LOGNAME        "Sel_Convenios"

#define UNIVERSO       "CONPAC"

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
char    szLogName[250] ;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   long         lSegProceso ;
   long         lCantConvenios;
}rg_estadistica;
rg_estadistica stStatusProc;
/*------------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA A GRABAR PRINCIPAL                               */
/*------------------------------------------------------------------------------*/
typedef struct reg_universo
{
        long    lCodComisionista;
        long    lCodCliente;
        char    szFecConvenio[20];
   	    int		iCodTipoRed;
	    char	szCodTipComis[3];
	    char	szCodTipVendedor[3];

        struct  reg_universo   * sgte;
}reg_universo;
typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*------------------------------------------------------------------------------*/
void vSeleccionarUniverso(int , char * , char * );
void vInsertaSeleccion();
void vLiberaUniverso();
