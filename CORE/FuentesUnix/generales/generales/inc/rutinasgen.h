/*****************************************************************************/
/* Fichero     : rutinasgen.h                                                  */
/* Descripcion : Declaracion de tipos y funciones                            */
/* Autor       : Mauricio Villagra Villalobos                                */
/* Fecha       : 20-05-1999                                                  */
/*****************************************************************************/

#ifndef _RUTINAGEN_H_
#define _RUTINAGEN_H_

#include "deftypes.h"
#include "FaORA.h"

/******************************************************************************
Estructura para recoger los datos de la tabla FA_ENLACEHIST 
*******************************************************************************/


#undef access
#ifdef _RUTINAGEN_PC_
#define access
#else
#define access extern

#endif  /*_RUTINAGEN_PC_*/

typedef struct tagFA_ENLACEHIST
{
    long    lCodCiclFact        ;
    int     iCodTipAlmac        ;    
    char    szDetCelular    [40];
    char    szDetRoaming    [40];
    char    szDetFortas     [40];
    char    szDetAcumLlam   [40];
    char    szDetCliente    [40];
    char    szDetAboCel     [40];
    char    szDetAboBep     [40];
    char    szDetDocumento  [40];
    char    szDetConceptos  [40];
}ENLACEHIST;



access  char*       szGetEnv            (char*)         ;
access  BOOL        bfnSelectSysDate    (char*)         ;
access  BOOL        bSumaDias           (char *
                                        ,char *
                                        ,int )          ; 
access  BOOL        bGetEnlaceHist      (ENLACEHIST *)  ;
access  BOOL        bKillProc           (long lPidProc) ;
access  char*       cfnGetTime          (int fmto)      ;

#endif  /*_RUTINAGEN_H_*/


/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

