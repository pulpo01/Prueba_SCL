/*****************************************************************************/
/* Fichero    : precuota.h                                                   */
/* Descripcion: Declaracion de funciones y tipos de precuota.pc              */
/* Autor      : Javier Garcia Paredes                                        */
/* Fecha      : 08-04-1997                                                   */
/*****************************************************************************/

#ifndef _PRECUOTA_H_
#define _PRECUOTA_H_

#include <GenFA.h>
#include <geora.h>

#undef access
#ifdef _PRECUOTA_PC_
#define access
static BOOL bValidacionCuota (CABCUOTAS *,CUOTAS *);
static void vInitEstCuotas (void)                  ;
static BOOL bUpdateCuotas (char*)                  ;
static BOOL bUpdateIndPagare (long lCodCliente)    ;
static BOOL bUpdateCabCuotas (char*)               ;
static BOOL bUpdateEquipaBoser (long lNumAbonado)  ;
static BOOL bUpdateIndCuotasInfa (long lCodCliente,long lNumAbonado,
                                  int Producto);
#else
#define access extern
access BOOL bIFPagares(long lCodCliente,long lNumAbonado,int, int iTipoFact);
access BOOL bIFCuotas (long lCodCliente,long lNumAbonado,int, int iTipoFact);
access BOOL bEMCuotas (void)    ;
access void vfnFreeCuotas (void);
#endif /* _PRECUOTA_PC_ */

access ESTADIST stEstCuotas;

#endif /* _PRECUOTA_H_ */


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

