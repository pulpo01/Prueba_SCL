/*******************************************************************************

Fichero:      prebilbaj.h
Descripcion:  Declaracion de tipos y prototipos de prebilbaj.pc 

Fecha:        17/06/96

*******************************************************************************/

#ifndef _PREBILBAJ_H_
#define _PREBILBAJ_H_ 

#include <GenFA.h>
#include <pretar.h>
#include <presac.h>
#include <preser.h>
#include <preabo.h>
#include <precuo.h>
#include <imptoiva.h>
#include <compos.h>
/* #include <pasar.h> */

#undef access
#ifdef _PREBILBAJ_PC_
#define access 
/* -------------------------------------------------------------------------- */
/*               Prototipos de Funciones locales del prebilling               */
/* -------------------------------------------------------------------------- */
static BOOL bfnInterfazModulosBaja   (long,int,int)   ;
static BOOL bfnPreEmisionModulosBaja (int )           ;
static BOOL bfnCargaCicloCli (long,int,long,short,int);
static BOOL bfnUltimoAbono (long,int,long,int*)       ;
static BOOL bfnGetDatosGaInfac (CICLOCLI *)           ;
static BOOL bfnGetDatosGaIntar (long,long,int,long *) ;
static BOOL bfnCargaCuotasBaja (void)                 ;

static BOOL bfnGetInfacRent    (long   lCodCliente , long lNumAbonado,
                                long   lNumAlquiler, ABORENT **pAboRent);
static BOOL bfnGetInfacRoaVis  (long   lCodCliente , long lNumAbonado,
                                long   lNumEstaDia , ABOROAVIS **pAboRV);
static BOOL bfnGetIntaRent     (long   lCodCliente , long lNumAbonado,
                                long   lNumAlquiler, long  *lCodPlanCom);
#else
#define access extern
#endif /* _PREBILBAJ_PC_ */

access BOOL bfnPreBillingClienteBajaAbo (long lCodCliente , int  iCodCiclo   ,
                                         long lNumAbonado , int  iCodProducto,
                                         long lNumAlquiler, long lNumEstaDia ,
                                         int  iTipoFact);
access void vfnFreeAboRent   (void);
access void vfnFreeAboRoaVis (void);
/* -------------------------------------------------------------------------- */
/*                  Variables Globales                                        */
/* -------------------------------------------------------------------------- */

#endif /* _PREBILBAJ_H_ */






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

