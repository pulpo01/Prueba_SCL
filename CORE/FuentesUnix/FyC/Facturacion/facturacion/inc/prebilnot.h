#ifndef _PREBILNOT_H_
#define _PREBILNOT_H_

#include <GenFA.h>
#include <predefs.h>
#include <prenot.h>
#include <imptoiva.h>
#include <compos.h>

#undef access
#ifdef _PREBILNOT_PC_
#define access 
#else
#define access extern
#endif /* _PREBILCLI_PC_ */

/* -------------------------------------------------------------------------- */
/*     Prototipos de Funciones locales del prebilling notas                   */
/* -------------------------------------------------------------------------- */
access BOOL bfnPreBillingClienteNotas(long,int);
#endif /* _PREBILNOT_H_ */


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

