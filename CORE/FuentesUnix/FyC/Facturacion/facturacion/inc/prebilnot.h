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

