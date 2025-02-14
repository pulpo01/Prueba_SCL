#ifndef _LOADTARIF_H_
#define _LOADTARIF_H_
#include <memory.h>  
#include <GenFA.h>
#include <trazafact.h>
#include <rutinasgen.h>
#endif /* _LOADTARIF_H_ */


/************************************************************/
/*   Nivel de log por Default                               */
/************************************************************/
#define     iLOGNIVEL_DEF   3

#define     SQLINDEXNOEXIST     -1418
/* SAAM-20041019 se incluye nueva variable segun HD-200408301790, P-MAS-04042 */
#define     SQLINDEXEXIST       -955



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

char                szExeLoadTarif[1024]        ;
char                szCadenaCreateIndex[4096];
int                 lLargoCadenaCreateIndex;
/************************************************************************/

#undef access

#ifdef _LOADTARIF_PC_
#define access
#else
#define access extern
#endif

#undef access

#undef _LOADTARIF_PC_




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

