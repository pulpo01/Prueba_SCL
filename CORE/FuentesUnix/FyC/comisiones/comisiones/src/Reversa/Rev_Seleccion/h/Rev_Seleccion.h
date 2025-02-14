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
#define GLOSA_PROG                      "REVERSA DE PROCESO DE SELECCION DE INFORMACION"
#define PROG_VERSION                    "CUZCO 4.0"
#define LAST_REVIEW                     "01-OCT-2003 (mwn70192)."
#define LOGNAME                         "Rev_Seleccion"
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
char    *pszEnvLog      = "";
FILE    *pfLog;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        long    lCantHabCel;
        long    lCantHabPre;
        long    lCantBonTraf;
        long    lCantBajas;
        long    lCantRecha;
        long    lCantVtasPend;
        long    lCantCartera;
        long    lCantEvalua;
        long    lCantChurn;
        long    lCantConvenios;
        long    lCantEnlaces;
        long	lCantRetenciones;
}rg_estadistica;
rg_estadistica          stStatusProc;
/*---------------------------------------------------------------------------*/


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

