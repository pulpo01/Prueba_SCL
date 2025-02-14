/* *********************************************************************** */
/* *  Fichero : PHistorico.h                                             * */
/* *                                                                     * */
/* *  Autor : Roy Barrera R.                                             * */
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
#define		EXEC_BATCH				   1
#define     EXEC_ONLINE				   2

#define     VENTA               1
#define     CICLO               2
#define     MISCELANEA         18
#define     NOTACRED           25

/* Modificación Proyecto Ecu-05002 Codigo de Autorización. Se agregan variables para rescatar valor de campo 
val_parametro de tabla ged_parametros para saber si aplica el codigo de autorizacion y otra para guradar el 
valor del codigo de autorizacion.
*/

char 	szCod_Autorizacion[11];

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
    long    lNumProceso		;
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
    long    lNumRegInterfaz ;
}ESTADISTICASPASHIS;

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/
PASOHISTLINEACOMANDO    stLineaComando          ;
ESTADISTICASPASHIS      stEstPasoHist           ;

/************************************************************************/

#undef access

#ifdef _PASOHIST_PC_
#define access
#else
#define access extern
#endif

int     ifnPasoHistOnline  (char *szAccount, char *szPasswd, char *szCodModGener, int iModExec);
int     ifnValidaParametros( int argc, char *argv[], char *szOraAccount, char *szOraPasswd,
						        int *iLogLevel, char *szCodModGener, int *iModExec  );
int     ifnAbreArchivosLog (int iLogLevel);
BOOL    bfnPasoHistPuntual ( long lNumProceso, int iCodTipMovimiento);
BOOL    bfnDBPasarCargosConProceso( long lNumProceso, long lCodCliente );
void    vfnInitCadenaInsertCargos (char * szCadena, long lpNumProc);
void    vfnInitCadenaDeleteCargos (char * szCadena, long lpNumProc);
BOOL    bfnDBPasarHistDetalle(long lIndOrdenTotal,long lCodCiclFact);
void    vfnInitCadenaInsertDetalle(char *szCadena, long lCodCiclFact);
void    vfnInitCadenaDeleteDetalle (char *szCadena);
BOOL    bfnDBPasarHistCliente(long lIndOrdenTotal,long lCodCiclFact);
void    vfnInitCadenaInsertCliente(char *szCadena, long lCodCiclFact);
void    vfnInitCadenaDeleteCliente (char *szCadena);
BOOL    bfnDBPasarHistAbonado(long lIndOrdenTotal,long lCodCiclFact);
void    vfnInitCadenaInsertAbonado(char *szCadena, long lCodCiclFact);
void    vfnInitCadenaDeleteAbonado (char *szCadena);
BOOL    bfnDBPasarHistFactura(long lIndOrdenTotal,long lCodCiclFact);
void    vfnInitCadenaInsertFactura(char *szCadena);
void    vfnInitCadenaDeleteFactura  (char *szCadena);
BOOL    bfnPasHisValInd (  long lIndAnulada, long lIndImpresa, long lIndPasoCobro, long lNumFolio);
BOOL    bfnDBPasarHistInterfact(long lNumProceso);
void    vfnInitCadenaInsertInterfaz(char *szCadena);
void    vfnInitCadenaDeleteInterfaz  (char *szCadena);
BOOL    bfnUpdateInterfazHist(long lEstaDoc, long lEstProc, long lNumProceso);
void    vfnInitCadenaUpdateNCNoCiclo(char * szCadena);
void    vfnInitCadenaInsertNCNoCiclo(char * szCadena);
void    vfnInitCadenaUpdateNCCiclo  (char * szCadena);
void    vfnInitCadenaInsertNCCiclo  (char * szCadena);
void    vfnInitCadenaUpdateCiclo    (char * szCadena);
void    vfnInitCadenaInsertCiclo    (char * szCadena);
void    vfnInitCadenaDeleteSeries   (char *szCadena);
BOOL    bfnEstadConsumNC            (long   lCodCliente
                                    ,int    iNumMes
                                    ,long   lNumSecuRel
                                    ,char   *szLetraRel     
                                    ,int    iCodTipDocumRel
                                    ,int    iCodVendedorAgenteRel
                                    ,int    iCodCentrRel
                                    ,double dTotOriginalDocto);
BOOL bfnUpdateConsMensClie  (long   lCodCliente
                            ,int    iCodTipMovimiento
                            ,int    iNumMes
                            ,long   lNumSecuRel
                            ,char   *szLetraRel     
                            ,int    iCodTipDocumRel
                            ,int    iCodVendedorAgenteRel
                            ,int    iCodCentrRel  
                            ,double dTotFactura);
BOOL bfnDBEliminarFactura(long lIndOrdenTotal,long lCodCiclFact);
BOOL bfnInsertEstadist   (char *szCadenaInsert,long lCodCliente,int iNumMes,double dTotEstad);
BOOL bfnUpdateEstadist (char *szCadenaUpdate,long lCodCliente,int iNumMes,double dTotEstad);
BOOL bfnDBPasarHistTecno(long lIndOrdenTotal,long lCodCiclFact);
void vfnInitCadenaInsertTecno(char *szCadena, long lCodCiclFact);
void vfnInitCadenaDeleteTecno (char *szCadena );

int GargaGedParametros( void );
int szfnObtieneCod_autorizacion (long lIOrdenTotal);




#undef access
#undef _PASOHIST_PC_

static char szUsage[]=
   "\n\t Uso:  PHistorico Opciones\n"
   "\n\t OPCIONES:\n"
   "\n\t\t -u Usuario/Password  - Opcional  -    Default : -u/ "
   "\n\t\t -l Nivel Log         - Opcional  -    Default : -l3 "
   "\n\t\t -e cod_Modgener      - Necesario -      Ejs. : -e101 ; -e000; etc."
   "\n\n\t Se debe agregar SOLO UNO de los sgtes modos de ejecucion : \n"
   "\n\t\t       -Online  (via colas)"
   "\n\t\t       -Batch   (batch)"
   "\n";

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
