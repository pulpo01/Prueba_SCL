/*******************************************************************************

Fichero:      prebilcon.h
Descripcion:  Declaracion de tipos y prototipos de prebilcon.pc 

Fecha:        12/01/96

*******************************************************************************/

#ifndef _PREBILCON_H_
#define _PREBILCON_H_

#include <predefs.h>
#include <ORAcarga.h>
#include <preabo.h>
#include <imptoiva.h>
#include <GenFA.h>

#undef access
#define access extern
#ifdef _PREBILCON_PC_
/* -------------------------------------------------------------------------- */
/*               Prototipos de Funciones locales del prebilling               */
/* -------------------------------------------------------------------------- */

access void vFreeCargos (void);
access void vInitEstructurasCargos(void); 
access BOOL bFindDirecciones (long lCodDireccion, char* szCodMunicipio);
access BOOL bFindDirecCli (long lCodCliente, long *lCodDireccion);
#else
access BOOL bPrintErrorEst(void);
access BOOL bPreBillingClienteContado(long,VENTAS stVenta,TRANSCONTADO,int);
access BOOL bGetCategoriaImpositiva (long,int*,char*)                      ;

access BOOL bGetCodMunicipio (long,char*);
access void vInitAnomProceso (ANOMPROCESO*);
access void vInitEstructurasCargos(void); 
access void vFreeCargos (void);
access BOOL bFindDirecCli (long lCodCliente, long *lCodDireccion);
access BOOL bFindDirecciones (long lCodDireccion, char* szCodMunicipio);

#endif /* _PREBILCON_H_ */
#endif /* _PREBILCON_PC_ */


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

