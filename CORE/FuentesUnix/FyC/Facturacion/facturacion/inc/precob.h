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

