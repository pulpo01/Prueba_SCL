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

