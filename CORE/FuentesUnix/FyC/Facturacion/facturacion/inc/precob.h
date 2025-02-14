/****************************************************************************/
/* Fichero    : precob.h                                                    */
/* Descripcion: Declaracion de Funciones y Tipos para precob.pc             */
/* Autor      : Javier Garcia Paredes                                       */
/* Fecha      : 6-05-1997                                                   */
/****************************************************************************/

#ifndef _PRECOB_H_
#define _PRECOB_H_

#include <GenFA.h>
#include <coerr.h>
#include <recargos.h>
#include <geora.h>

#undef access
#ifdef _PRECOB_PC_
#define access
#else
#define access extern
access BOOL bIFCobros (void);
#endif 
access ARRREC stArrRec;
access ARRPOR stArrPor;
access ARRCAN stArrCan;
#endif 



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

