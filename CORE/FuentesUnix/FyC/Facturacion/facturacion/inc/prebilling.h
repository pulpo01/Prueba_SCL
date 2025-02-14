/*****************************************************************************/
/* Fichero    : prebilling.pc                                                */
/* Descripcion:                                                              */
/* Fecha      : 14-Ene-97                                                    */
/* Autor      : Javier Garcia Paredes                                        */
/*****************************************************************************/

#ifndef _PREBILLING_H_
#define _PREBILLING_H_

#include <geora.h>
#include <predefs.h>
#include <GenFA.h>
#include <ORAcarga.h>
#include <presac.h>
#include <preser.h>
#include <prebilco.h>
#include <prebilnot.h>
#include <prebilcic.h>
#include <prebilext.h>
#include <prebilbaj.h>
#include <trazafact.h>
#include <rutinasgen.h>

#undef access
#ifdef _PREBILLING_PC_

#define access
static BOOL bGetFecEmFactNotas (PROCESO,char*);
static BOOL bGetFecCategoria (int ,char*)     ;

static BOOL bGestionLog (void)          ;
static void vInitRegCliente (void)      ;
static char *szMenorFecDesdeCiclo (void);

static BOOL bfnFinOkCliente    (void);
static void vfnFinErrorCliente (int   , TRANSCONTADO *, VENTAS *);
static BOOL bfnInicioCiclo     (char *, int, ABONOCLI) ;
static void vfnPrintFin        (void);
static int  ifnRangoClientes   (GABONOCLI *, long, long, int, long, long);

static void vfnFreeGAbonoCli   (GABONOCLI *);
access void vfnPrintRangoCliente (GABONOCLI)                   ;
static BOOL bfnSkipBadRecord(int iTipoFact, TRANSCONTADO *, VENTAS *  );
access BOOL bCargaGeneralPreBilling (int  iTipoFact,  long lNumAbonado);

static int ifnRangoClientes_MC (GABONOCLI *pstGAbo);
BOOL bfnProcesarClientes(FAC_CLIENTES **pstCliente,CICLOCLI *, long *,long, int);
int   bfnCreaSemaforo(void);
BOOL attach_shared_ciclo(
//	TIPIMPUES *,int *,
	IMPUESTOS *,int *,
	CABCUOTAS *,int *,
	TACONCEPFACT *,int *,
	CONCEPTO *,int *,
	CONCEPTO_MI *,int *,
	ACTIVIDADES *,int *,
	RANGOTABLA *,int *,
	LIMCREDITOS *,int *,
	PROVINCIAS *,int *,
	REGIONES *,int *,
	CATIMPOSITIVA *,int *,
	ZONACIUDAD *,int *,
	ZONAIMPOSITIVA *,int *,
	GRPSERCONC *,int *,
	CONVERSION *,int *,
	DOCUMSUCURSAL *,int *,
	LETRAS *,int *,
	GRUPOCOB *,int *,
	TARIFAS *,int *,
	ACTUASERV *,int *,
	CUOTAS *,int *,
	FACTCARRIERS *,int *,
	CUADCTOPLAN *,int *,
	CTOPLAN *,int *,
	PLANCTOPLAN *,int *,
	ARRIENDO *,int *,
	CARGOSBASICO *,int *,
	OPTIMO *,int *,
	FERIADOS *,int *,
	PLANTARIF *, int *,
	PENALIZA *, int *,
	OFICINA **, int *,
	FACTCOBR **, int *,
	CARGOSRECURRENTES *, int *, 
	long *
);

BOOL bCargaGeneralPreBilling_MC (void);
BOOL bCargaCargos_MC (CARGOS * ,long*,int,long,long,long,long);
static BOOL bfnInicioCiclo_MC (char *, int, ABONOCLI) ;

BOOL bfnObtieneParamGenerales( void );

access BOOL bCargaPreBillingContado(int iTipoFact,long lNumTransaccion,long lNumVenta);
void vFreeModulos (void);
#else
#define access extern
access BOOL bfnPreBilling(int  iTipoFact   , long lCodCliente ,
                          long lNumAbonado , int  iCodProducto,
                          long lNumAlquiler, long lNumEstaDia ,
                          long lCodCiclFact, long lNumProceso ,
                          long lNumVenta   , long lNumTrans   ,
/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

			  /*long lClienteIni , long lClienteFin );*/

			  long lClienteIni , long lClienteFin, BOOL MemSharedL );

/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

access BOOL bCargaPrebillingContado (int iTipoFact,long ,long );
access void vFreeModulos (void);

#endif /*_PREBILLING_PC_*/
#undef access
#endif /* _PREBILLING_H_ */


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

