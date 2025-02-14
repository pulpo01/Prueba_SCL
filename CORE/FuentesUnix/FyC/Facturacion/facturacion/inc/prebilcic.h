/*****************************************************************************/
/* Fichero    :  prebilcic.h                                                 */
/* Descripcion:  Declaracion de tipos y prototipos de prebilcic.pc           */ 
/* Autor      :  Javier Garcia Paredes                                       */
/* Fecha      :  22-03-1997                                                  */ 
/*****************************************************************************/

#ifndef _PREBILCIC_H_
#define _PREBILCIC_H_

#include <GenFA.h>
#include <compos.h>
#include <pretar.h>
#include <presac.h>
#include <preser.h>
#include <preabo.h>
#include <precuo.h>
#include <precar.h>
#include <imptoiva.h>
#include <MtoMinFact.h>
#include <PlanDcto.h>

#define lRANGO_CICLOCLI 15000

#undef access
#ifdef _PREBILCIC_PC_


typedef struct tagHostArray
{
  char  szRowid      [lRANGO_CICLOCLI][19];
  int   iCodCicloNue [lRANGO_CICLOCLI]    ;
  long  lNumProceso  [lRANGO_CICLOCLI]    ;
  char szFecUltFact  [lRANGO_CICLOCLI][15];
}HA_CICLOCLI;

typedef struct TagGHostArray
{
  long        lNumReg;
  HA_CICLOCLI stHA   ;
}GHA_CICLOCLI;

#define access 
#else
#define access extern
#endif /* _PREBILCIC_PC_ */
/* -------------------------------------------------------------------------- */
/*             Prototipos de Funciones PreBilling Ciclo                       */
/* -------------------------------------------------------------------------- */
access BOOL bPreBillingClienteCiclo(long,int)     ;
access BOOL bPreEmisionModulos (int)              ;
access BOOL bInterfazModulos (int)                ;
access void vFreeFactCli (void)                   ;
access BOOL bfnUpdateCicloCli (ABONOCLI,long,long);


#endif /* _PREBILCIC_H_ */


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

