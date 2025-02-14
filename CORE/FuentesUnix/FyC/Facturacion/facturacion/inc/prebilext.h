/*****************************************************************************/
/*  Funcion     : prebilext.h                                                */
/*  Descripcion : funciones y prototipos para facturacion de Conceptos Exter-*/
/*                ternos (Factura Miscelanea y Factura Compra)               */
/*  Autor       : Javier Garcia Paredes                                      */
/*  Fecha       : 17-04-97                                                   */
/*****************************************************************************/

#ifndef _PREBILEXT_H_
#define _PREBILEXT_H_

#include <GenFA.h>
#include <preext.h>
#include <compos.h>
#include <imptoiva.h>

#undef access
#ifdef _PREBILEXT_PC_
#define access
#else
#define access extern
access BOOL bPreBillingExt (int);
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

