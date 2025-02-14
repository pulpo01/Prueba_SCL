/*******************************************************************************
Fichero    :  composi.h
Descripcion:  Declaracion de tipos y prototipos de commain.c 
Fecha      :  23-02-1997 
Autor      :  Javier Garcia Paredes
*******************************************************************************/

#ifndef _COMPOSI_H_
#define _COMPOSI_H_

#include <comora.h>
#include <compos.h>
/* #include <pasar.h> */
#include <prebilling.h>

#undef access
#ifdef _COMPOSI_C_
#define access
static BOOL bfnCargaComposicion (long, long, VENTAS *, TRANSCONTADO *);
#else
#define access extern
#endif /*_COMPOSI_C_*/
access int bComposicion(long,long,int);
access int ifnComposicion(long lNumProceso,long lCodCliente,int iTipFact) ;
#undef access
#endif /*_COMPOSI_H_*/


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

