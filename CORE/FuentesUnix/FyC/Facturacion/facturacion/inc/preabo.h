/*******************************************************************************

Fichero:      preabo.h
Descripcion:  Declaracion de tipos y prototipos de preabo.pc 

Fecha:        12/01/96
Autor:        Javier Garcia Paredes 

*******************************************************************************/

#ifndef _PREABO_H_
#define _PREABO_H_

#include <GenFA.h>
#include <geora.h>

typedef struct tagVtaDto
{
  long   lNumVenta   ;
  long   lNumItem    ;
  int    iCodProducto;
  double dImpVenta   ;
  long   lNumUnidades; /* Incorporado por PGonzaleg 4-03-2002 */
  short  iIndDto     ;
  double dValDto     ;
  short  iIndAcepta  ;
  int    iCodCtoDto  ;
}VTADTO              ;

typedef struct tagVentaDto
{
  int     iNumReg;
  VTADTO *pVtaDto;
}VENTADTO        ;

#undef access
#ifdef _PREABO_PC_
#define access 
static BOOL bfnCargaCargosCliente (VENTAS stVenta,TRANSCONTADO,long,int,int ) ;
static BOOL bfnCargaCargosPVentaContado (VENTAS stVenta,TRANSCONTADO stTransC); 
static BOOL bfnCargaCargosCiclo (long lNumAbonado)                            ;
static BOOL bfnCargaCargosRentORoa(long  lNumAbonado, int   iCodProducto,
                                   char *szFecBaja  , char *szFecAlta   ,
                                   int   iTipoFact)                           ;

static BOOL bfnCargaCargosBajaAbo  (long lNumAbonado, int iCodProducto)       ;
static BOOL bfnCargaCargosOcasionales ( long  lNumAbonado );
static void vPrintRegCargo  (int)        ; 
static BOOL bUpdateCargos (char *szRowid);
static BOOL bUpdateCargosOcacionales (char *szRowid);

static BOOL bfnInsertVentaDtos (VENTADTO *    );
static void vfnPrintVentaDtos  (VTADTO   ,BOOL);
static void vfnFreeVentaDtos   (VENTADTO *    );
BOOL bValidacionCargo (int )        ;
#else
#define access extern
access BOOL bIFCargos (VENTAS stVenta,TRANSCONTADO stTransC,long lNumAbonado,
                       int iCodProducto,int iTipoFact);

access BOOL bEMCargos (void)                ;
access BOOL bEMCargosContado (int iTipoFact);
access BOOL bValidacionCargo (int )        ;

#endif /*_PREABO_PC_*/
#endif /*_PREABO_H*/





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

