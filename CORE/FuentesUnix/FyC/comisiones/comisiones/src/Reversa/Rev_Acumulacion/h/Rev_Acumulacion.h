/************************************************************************/
/* Definicion de constantes, tipos y estructuras usadas por el programa */
/* de calculo de comisiones por concepto de BONO POR CARTERA            */
/*                                                                      */
/* Por Fabian Aedo Ramirez                                              */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00  ("BonoCartera.pc")                          */
/* Inicio: Lunes 13 de Agosto del 2001                                  */
/* Fin   :                                                              */
/*                                                                      */
/************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <strings.h>
#include <errno.h>
#include <sys/timeb.h>
#include <sys/stat.h>
#include <time.h>
#include <locale.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>
/*---------------------------------------------------------------------------*/
/* Definiciones de caracter general para el programa.                        */
/*---------------------------------------------------------------------------*/
#define GLOSA_PROG                      "REVERSA DE PROCESOSO DE ACUMULACION"
#define PROG_VERSION                    "CUZCO 4.0"
#define LAST_REVIEW                     "30-SEP-2003 (mwn70192)."
#define LOGNAME                         "Rev_Acumulacion"
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
char    *pszEnvLog  = "";
FILE    *pfLog;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar fechas que definen periodo de     */
/* comisiones.                                                               */
/*---------------------------------------------------------------------------*/
typedef struct REG_FECHAS
{
        char    szFecAcepAnt[22];
        char    szFecAcepAct[22];
        long    lCodPeriodo;
        char    szIdPeriodo[10];
}rg_fechas;
rg_fechas               stFechas;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso;
        long    lCantAcumula;
        long    lCantFondosCoap;
        long    lCantConsumosCoap;
        long    lCantLogroMetas;
}rg_estadistica;
rg_estadistica          stStatusProc;
/*---------------------------------------------------------------------------*/

