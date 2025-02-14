/*****************************************************************************/
/* Funcion    : prenot.h                                                     */
/* Descripcion: Declaracion de Tipos y Funciones                             */
/* Fecha      : 23-04-1997                                                   */
/* Autor      : Javier Garcia Paredes                                        */
/*****************************************************************************/

#ifndef _PRENOT_H_
#define _PRENOT_H_

#include <GenFA.h>
#include <geora.h>

#undef access

#ifdef _PRENOT_PC_
#define access
static BOOL bfnDBCargaHistConc(char *, NOTACD *, ENLACEHIST, BOOL);
access BOOL bfnCargaConceptosNotas (ENLACEHIST, BOOL, char *);
#else
#define access extern
access BOOL bfnIFNotas (void)            ;
access BOOL bfnCargaConceptosNotas (ENLACEHIST, BOOL);
access BOOL bfnDBUpdateAjustes (void)    ;
#endif
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

