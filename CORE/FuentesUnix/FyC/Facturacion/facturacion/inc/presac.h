/*****************************************************************************/
/*  Fichero    : presac.h                                                    */
/*  Descripcion: Declaracion de tipos y prototipos de presac.pc y presac_c.c */
/*                                                                           */
/*  Fecha      : 29-Oct-96                                                   */
/*  Autor      : Javier Garcia Paredes                                       */
/*****************************************************************************/
#ifndef _PRESAC_H_
#define _PRESAC_H_

#include <GenFA.h>
#include <geora.h>

/************************** Declaracion de Estructuturas *********************/

typedef struct tagEstPenaliza
{
  long   lCodCliente         ;
  int    iAbonados           ;
  double dImporte            ;
  int    iAnomalia           ;
}EST_PENALIZA                ;

typedef struct tagEstSac
{
  int           iNumEst      ;
  EST_PENALIZA* pEst         ;
}ESTSAC                      ;


#undef acces
#define access extern
#ifdef _PRESAC_PC_

/*****************************************************************************/
/*                       Declaracion de prototipos de presac                 */
/*****************************************************************************/
static BOOL bCargaPenalizaCli (long lNumAbonado,int iProd,int iTipoFact,int); 

static BOOL bEscribePreFactura (PENALIZA* ,int)             ;
static BOOL bfnDeletePenalizacion(PENALIZA* )               ;
static int  ifnCheckPenaliza (PENALIZA*)                    ;
static BOOL bfnGenEstaPen (ESTSAC *)                        ;
/* static BOOL bfnGrabarEstaPen (ESTSAC *)                     ; */
static BOOL bfnEscribeAnomalia (PENALIZA *,int,int)         ;
static BOOL bUpdatePenalizaciones (PENALIZA *)              ;
access void vFreeSac (void)        ;
static BOOL bValidacionPenaliza (PENALIZA *)                ;
#else
access BOOL bIFSac (int iTipoFact,int iIndFactur,long lNumAbonado,int iProd);   
                    
access BOOL bEMSac (void)            ;
access BOOL bESSac (void)            ;
access void vSalidaEstSac (ESTSAC *);
access void vFreeSac (void)        ;

#endif /* _PRESAC_PC_ */

#endif /* _PRESAC_H_ */



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

