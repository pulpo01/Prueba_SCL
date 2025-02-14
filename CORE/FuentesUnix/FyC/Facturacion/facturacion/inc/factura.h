/*******************************************************************************
Fichero    :  factura.h
Descripcion:  Declaracion de tipos y prototipos de factura.h

Fecha      :  19-02-1997  
Autor      :  Javier Garcia Paredes 
*******************************************************************************/
#ifndef _FACTURA_H_
#define _FACTURA_H_

#include <GenFA.h>
#include <prebilling.h>
#include <composi.h>

/*****************************************************************************/
/* Versionamiento                                                            */
/*****************************************************************************/
/* RAO20030628: Se inicia el versionamiento con la incidencia TM-260620030157*/
#define szVersionActual        "3.003"
#define szUltimaModificacion   "08.07.2004"
/*****************************************************************************/


typedef struct tagConfig
{
 long   lNumProceso       ;
 char   szUsuario     [31];
 char   szPassWord    [31];
 long   lCodCliente       ;
 long   lNumAbonado       ;
 int    iCodProducto      ;
 long   lNumAlquiler      ;
 long   lNumEstaDia       ;
 long   lCodCiclFact      ;
 long   lNumTransaccion   ;
 long   lNumVenta         ;
 int    iTipoFactura      ;
 int    iNivelLog         ;
 int    iCaso             ;
 long   lClienteIni       ; 
 long   lClienteFin       ;
 BOOL   bOptPreBilling    ;
 BOOL   bOptComposicion   ;
 BOOL   bOptBaja          ;
 BOOL   bOptCompra        ;
 BOOL   bOptMiscelanea    ;
 BOOL   bOptLiquidacion   ;
 BOOL   bOptRentPhone     ;
 BOOL   bOptRoamingVis    ;
 BOOL   bOptCliente       ;
 BOOL   bOptTransaccion   ;
 BOOL   bOptNumVenta      ;
 BOOL   bOptNumProceso    ;
 BOOL   bOptContado       ;
 BOOL   bOptCiclo         ;

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

 BOOL   bOptMemShared     ;

/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

 BOOL   bOptSizeLog       ;
 BOOL   bOptUsuario       ;
 BOOL   bOptCiclFact      ;
 BOOL   bOptAbonado       ;
 BOOL   bOptProducto      ;
 BOOL   bOptNumAlquiler   ;
 BOOL   bOptNumEstaDia    ;
 BOOL   bOptNota          ;
 BOOL   bOptClienteIni    ;
 BOOL   bOptClienteFin    ;
}CONFIG;

#define iLOGNIVEL_DEF 3

#undef access
#ifdef _FACTURAUX_C_
#define access
access void vDatosFinTiempo (void)       ;                                     
access void vInitProceso(PROCESO*)       ;                                     

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

/*access BOOL bInitInstance (int iTipoFact);          */

access BOOL bInitInstance (int iTipoFact, BOOL MemShared);

/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

access BOOL bExitInstance(void)          ;                                     
access void vInitConfig (void)           ;                                     

access void vfnLiberarPreFactura(void)	;
access BOOL bfnDimensionarPreFactura(long lTam);

#else
#define access extern

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

/*access BOOL bInitInstance (int iTipoFact);          */

access BOOL bInitInstance (int iTipoFact, BOOL MemShared);

/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

access BOOL bExitInstance(void)          ;                                     
access BOOL bEntradaFactura (void)       ;                                     
access void vInitConfig (void)           ;                                     
access void vInitProceso(PROCESO*)       ;                                     

#endif /*_FACTURAUX_C_*/

access CONFIG stConfig;

#undef access
#endif /* _FACTURA_H_ */


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

