/** @file loadtrafico.h
    @brief Archivo de encabezado del aplicativo loadtrafico.
    
*/

#ifndef __LOADTRAFICO_H__
#define __LOADTRAFICO_H__

#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "errores.h"
#include "trazafact.h"
#include "rutinasgen.h"

/************************************************************/
/*   Nivel de log por Default                               */
/************************************************************/
#define     iLOGNIVEL_DEF       3

#define     SQLINDEXNOEXIST     -1418
#define     SQLINDEXEXIST       -955 

#ifndef     TIPO_TASA_CLASICA
#define     TIPO_TASA_CLASICA   0
#endif      /* TIPO_TASA_CLASICA */

#ifndef     TIPO_TASA_ON_LINE
#define     TIPO_TASA_ON_LINE   1
#endif      /* TIPO_TASA_ON_LINE */


/************************************************************************/
/*  Estructura para recoger los datos por la linea de comandos.         */
/************************************************************************/

typedef struct LineaComando
{ 
     char szUser   [50]     ;        /*  Usuario Unix                        */    
     char szPass   [50]     ;        /*  Password Oracle de Usuario Unix     */
     char szUsuaOra[50]     ;        /*  Usuario Oracle                      */
     char szDirLogs[1024]   ;        /*  Directorio de Archivos Log's y Err  */
     long lCodCiclFact      ;        /*  Codigo de Ciclo a Procesar          */
     int  iDigitoCli        ;        /*  Ultimo Digito del Codigo de Cliente */
     int  iNivLog           ;        /*  Nivel de Log para Proceso           */
}LINEACOMANDO;

/************************************************************************/

LINEACOMANDO        stLineaComando              ;

TRAZAPROC           stTrazaProc                 ;

char                szExeLoadTarif           [1024] = "loadtrafico";
char                szCadenaCreateIndex      [4096];
int                 lLargoCadenaCreateIndex        ;


/************************************************************************/
char szUsage[]=
    "\nUso:   loadtrafico -u  Usuario/Password        "
    "\n                   -c  Ciclo Facturacion       "
    "\n                   -d  Digito de Cliente [0..9]"    
    "\n\tOPCIONES:                                    "
    "\n\t               -l  [LogNivel]                ";

BOOL bfnCargarTrafico(void);
BOOL bfnPrepararConsultasSQL(char *pszQueryDetalle);
BOOL bfnDropIndexPF(int iIndTasacion);
BOOL bfnCreateIndexPF(int iIndTasacion);
BOOL NoExistenProcesosActuales(void);

#undef access

#ifdef _LOADTRAFICO_PC_
#define access
#else
#define access extern
#endif

#undef access

#endif /* __LOADTRAFICO_H__ */
#undef _LOADTRAFICO_PC_


/******************************************************************************************/
/** Informaci� de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�                                            : */
/**  %PR% */
/** Autor de la Revisi�                                : */
/**  %AUTHOR% */
/** Estado de la Revisi� ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci� de la Revisi�                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

