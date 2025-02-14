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

