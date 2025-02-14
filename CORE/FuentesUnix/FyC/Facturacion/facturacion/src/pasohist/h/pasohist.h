/* *********************************************************************** */
/* *  Fichero : pasohist.h                                               * */
/* *                                                                     * */
/* *  Autor : Mauricio Villagra V.                                       * */
/* *********************************************************************** */

#ifndef _PASOHIST_H_
#define _PASOHIST_H_
#include <GenFA.h>
#include <rutinasgen.h>
#endif

/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF              3
#define     lMAXREG                10000
#define     lTIPO_PROCESO_CICLO        1
#define     lTIPO_PROCESO_NOCICLO      2


/*********************************************
Estructura para recoger los datos por
la linea de comandos.     
**********************************************/
typedef struct LineaComandoPasoHist
{
    char    szUser   [50]   ;
    char    szPass   [50]   ;
    char    szDirLogs[1024] ;       /*  Directorio de Archivos Log's y Err      */
    long    lTipoDocumen    ;
    long    lCodCiclFact    ;
    char    szTipoPasoHis[2];       /*  Paso de Acumuladores o Facturas [A/F]   */  
    long    lIndOrdenTotal  ;
    int     iNivLog         ;
    int     ihIndTasador    ;       /*  SAAM-22021230  */
}PASOHISTLINEACOMANDO;


/*********************************************
Estructura de estadisticas de Proceso 
**********************************************/
typedef struct sTagEstadistidas
{
    long    lNumFacturas    ;
    long    lNumConceptos   ;
    long    lNumClientes    ;
    long    lNumAbonados    ;
}ESTADISTICASPASHIS;


/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/
PASOHISTLINEACOMANDO    stLineaComando          ;
ESTADISTICASPASHIS      stEstPasoHist           ;

/* P-COL-07041 */
int ihCantCiclFact = 0;

char szPasar[1024];
/* Modificación Proyecto Ecu-05002 Codigo de Autorización. Se agregan variables para rescatar valor de campo 
val_parametro de tabla ged_parametros para saber si aplica el codigo de autorizacion y otra para guradar el 
valor del codigo de autorizacion.
*/
char 	szAplica_Cod_Autorizacion[2];
char 	szCod_Autorizacion[11];

long lTotClientesRoa            = 0l;
long lTotLlamadasRoa            = 0l;
long lLlamadasOKRoa             = 0l;
long lLlamadasErrRoa            = 0l;

/*****************************************************************************/
/* Versionamiento 															 */
/*****************************************************************************/
/* RAO20030628: Se inicia el versionamiento con la incidencia TM-260620030157*/
#define szVersionActual 	 "1.00"
#define szUltimaModificacion "28.06.2003"
/*****************************************************************************/
#undef access

#ifdef _PASOHIST_PC_
#define access
access  BOOL    bfnPasoHistCiclo                    ( long lCodCiclFact, char * szTipo    );
access  BOOL    bfnDBPasarPenalizacionesConProceso  ( long lNumProceso    );
access  void    vfnInitCadenaInsertPenali           ( char * szCadena, 	long lpNumProc     );
access  void    vfnInitCadenaDeletePenali           ( char * szCadena, 	long lpNumProc     );
access  BOOL    bfnDBPasarAllCuotas                 ( void	);
access  BOOL    bfnDBPasarCuotas                    ( long lSeqCuotas     );
access  BOOL    bfnDBPasarArriendo                  ( void                );
access  BOOL    bfnDBPasarAireFraSocConProceso      ( int iProducto ,  	long lNumProceso   );
access  void    vfnInitCadenaInsertAireFrasoc       ( char *szCadena,  	int iProducto,	long lpNumProc      );
access  void    vfnInitCadenaDeleteAireFrasoc       ( char *szCadena, 	long lpNumProc      );
/* SAAM-20021230 Inclusion de nuevas funciones */
access  BOOL    bfnDBPasarTolAcumOper               ( int iProducto ,  	long lNumProceso   );
access  void    vfnInitCadenaInsertTolAcumOper      ( char *szCadena );
access  void    vfnInitCadenaDeleteTolAcumOper      ( char *szCadena );
access  BOOL    bObtieneIndicadorTasador            ( long lCodCicloFact);
/* SAAM-20021230 Fin de inclusion */
access  BOOL    bfnDBPasarOperConProceso            ( int iProducto , 	long lNumProceso    );
access  void    vfnInitCadenaInsertOper             ( char *szCadena, 	int iProducto,     long lpNumProc      );
access  void    vfnInitCadenaDeleteOper             ( char *szCadena, 	long lpNumProc      );
access  BOOL    bfnDBPasarRoamingConProceso         ( int  iProducto, 	long lNumProceso,
access                                                long lCiclParam,	char * spzFecha     );
access  BOOL    bfnPasaDetalleRoaming               ( long lCodCliente,	long lNumAbonado,
                                                      long lCodCiclFact,long lCodOperador, long lCicloReal     );
access  BOOL    bfnPasaAcumRoaming                  ( char szRowId[20], char * szFechaHoy );
access  BOOL    bfnCreateFacturasHist               ( long lCiclParam, 	char * szFecha   	);
access  BOOL    bfnCreateFaDetCelular               ( long lCiclParam, 	char * szFecha	);
access  BOOL    bfnInsertFaEnlaceHist               ( long lCiclParam     	);
access  BOOL    bfnDBPasarAvisoPago                 ( long lCodCiclfact   	);
access  BOOL 	bfnDBDropFacturaNCiclo		    ( long lIndOrdenTotal,long lCodCiclFact );
access  BOOL 	bfnEstadFactCta 		    ( long lCodCiclFact,int iNumMes		);
access  BOOL 	bfnUpdateConsMensClie               ( void					);
access  BOOL 	bfnEstadAireFrasoc                  ( long lCodCiclFact,int iNumMes);
access  BOOL 	bfnEstadAire                        ( long lCodCiclFact,int iNumMes);
access  BOOL 	bfnInsertEstadistSimple             ( char *szCadenaInsert,long lCodCliente,
                                                      int iNumMes,long lTotEstad);
access  BOOL 	bfnUpdateEstadistSimple             ( char *szCadenaUpdate,long lCodCliente,
                                                      int iNumMes,long lTotEstad);
access  BOOL 	bfnInsertEstadistDoble              ( char *szCadenaInsert,long lCodCliente,
                                                      int iNumMes,long lTotSegGratis, long lTotSegAdicio);
access  BOOL 	bfnUpdateEstadistDoble              ( char *szCadenaUpdate,long lCodCliente,
                                                      int iNumMes,long lTotSegGratis, long lTotSegAdicio);
access  void 	vfnInitCadenaFactCta                ( char * szCadena,	long lCodCiclFact );
access  void 	vfnInitCadenaAcumAireFrasoc         ( char * szCadena);
access  void 	vfnInitCadenaAcumAire               ( char * szCadena);
access  void 	vfnInitCadenaInsertFactCta          ( char * szCadena);
access  void 	vfnInitCadenaUpdateFactCta          ( char * szCadena);
access  void 	vfnInitCadenaInsertMinTmovil        ( char * szCadena);
access  void 	vfnInitCadenaUpdateMinTmovil        ( char * szCadena);
access  void 	vfnInitCadenaInsertRFija            ( char * szCadena);
access  void 	vfnInitCadenaUpdateRFija            ( char * szCadena);
access  void 	vfnInitCadenaInsertOpera            ( char * szCadena);
access  void 	vfnInitCadenaUpdateOpera            ( char * szCadena);
access  void 	vfnInitCadenaInsertFrecu            ( char * szCadena);
access  void 	vfnInitCadenaUpdateFrecu            ( char * szCadena);
access  void 	vfnInitCadenaInsertAire             ( char * szCadena);
access  void 	vfnInitCadenaUpdateAire             ( char * szCadena);
access  BOOL 	bfnValidaTrazaEstad 		    ( long lCodCiclFact, BOOL * bIndEjecutado);
access  BOOL 	bfnUpdateTrazaEstad 		    ( long lCodCiclFact);
access  BOOL    bfnInsertFahBalance                 ( long lCodCiclFact);
access  BOOL 	bfnDBPasarCargosConProceso	    ( long lNumProceso );
access  BOOL 	bfnDBPasarFacturas 		    ( long lCodCiclfact);
access  void 	vfnInitCadenaInsertCargos 	    ( char * szCadena, long lpNumProc);
access  void 	vfnInitCadenaDeleteCargos 	    ( char * szCadena, long lpNumProc);
/* P-COL-07041 */
access  BOOL 	bfnPrincipalPasoConsumoCiclo        ( long lCodCiclFact);
access  BOOL    bObtieneCantidadCiclos              ();
access  BOOL 	bfnDBPasarConsumoCiclo    	    ( long lCodCiclFact );
access  BOOL 	bfnDBPasarHistoricoConsumoCiclo     ( long lCodCiclFact );
access  BOOL 	bfnDBBorrarNAntiguosConsumoCiclo    ( int ihCantCiclFact);

int GargaGedParametros( void );
int iUpdate_fa_factdocu_ciclo ();

int szfnObtieneCod_autorizacion (long	lCodCiclo);

#else
#define access extern
#endif


#undef access
#undef _PASOHIST_PC_


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
