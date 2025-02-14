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

