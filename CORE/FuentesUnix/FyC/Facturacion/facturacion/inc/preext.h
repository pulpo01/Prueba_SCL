/*****************************************************************************/
/*  Funcion     : preext.h                                                   */
/*  Descripcion : funciones y prototipos para facturacion de Conceptos de Fa-*/
/*                turas de Compra o Miscelanea.                              */
/*  Autor       : Javier Garcia Paredes                                      */
/*  Fecha       : 17-04-97                                                   */
/*****************************************************************************/
#ifndef _PREEXT_H_
#define _PREEXT_H_

#include <GenFA.h>
#include <geora.h>

#undef access
#ifdef _PREEXT_PC_
#define access
#else
#define access extern
access BOOL bfnDBIFCompraMiscela (long lNumProceso);
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

