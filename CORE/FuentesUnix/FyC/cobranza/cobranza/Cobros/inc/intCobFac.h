/****************************************************************************
Fichero         : intCobFac.h
Modulo          : cobros
Fecha           : 20-11-1997
Programador     : Julio Oviedo.
Descripcion     : Prototipos, estructuras y constantes para intCobFac.pc.

****************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

/******************************************************************************/
/* CONSTANTES */
/******************************************************************************/

#define  NCRE  25
#define  NDEB  26
#define szPREF_PLAZA_DEFAULT    "0000000000"   /* Se cambia de 3 ceros a 10 ceros segun proyecto P-TMM-03083 */

/******************************************************************************/
/* ESTRUCTURAS */
/******************************************************************************/

DATCON stDatNota, stDatFact;

struct DATGEN
{
   FILE *lFile;
   char szPathLog[384];
   long lCodCliente;
   char szUsuario[31];
   char szFecActual[9];
   int  iCodCredito;
} TiG;

/******************************************************************************/
/* FUNCIONES */
/******************************************************************************/
int ifnProcDebito();
int ifnProcNota( int iCodTipMovimie );
/**
Descripcion : Funcion principal llama a las funciones ifnDBProcCredito si la
              nota es de credito o ifnProcDebito si es de debito
Entrada     :
Salida      : Devuelve Ok si todo fue correctamente
              Devuelve ERR_xxx si hubo algun fallo.
**/

BOOL bfnInicializaLogNc( FILE * );

int ifnPasoCobNcNd(	long lNumSecuenciC, int	 iCodTipDocC, 		long  AgenteC		 ,
					char *szLetraC	  , int	 iCentremiC , 		long  lNumSecuenciF,
					int	 iCodTipDocF  , long AgenteF	, 		char  *szLetraF	 ,
					int	 iCentremiF	  , long lCodCliente, 		int   iCodTipMovimie,
					char *szPrefPlaza , char *szCodOperadoraScl,char  *szCodPlaza, /* jlr_11.01.03 */
					char *szNomUsuarioOra); /* GAC 08-08-2003 (Homolog.) */

/***************************************************************************/
int ifnDBProcCredito();
/**
Descripcion : Procesa una nota de credito cancelando o disminuyendo la deuda
              asociada a ella.
Entrada     :
Salida      : Devuelve Ok si todo fue correctamente
              Devuelve ERR_xxx si hubo algun fallo.
**/
/***************************************************************************/
BOOL bfnDBInsPagCon(DATCON stGenNota, DATCON stGenFact, double dImporte);
/**
Descripcion : Inserta en CO_PAGOSCONC la relacion nota credito/deuda
Entrada     : estructura con los datos de la nota de credito, deuda asociada
              e importe cancelado
Salida      : Devuelve TRUE si todo fue correcto
              Devuelve FALSE si hubo algun error.
**/
/***************************************************************************/
BOOL bfnDBDelCart(DATCON stGen);
/**
Descripcion : Borra de CO_CARTERA la row asociada a los datos pasados por
              parametro.
Entrada     : Estructura con los datos relativos a la row a borrar.
Salida      : Devuelve TRUE si todo fue correcto
              Devuelve FALSE si hubo algun error.
**/
/***************************************************************************/
BOOL bfnDBUpdCart(DATCON stGen, double dImporte, int iDebHab);
/**
Descripcion : Modifica en CO_CARTERA en importe debe/haber de la row asociada
              a los datos pasados por parametro.
Entrada     : Estructura con los datos relativos a la row a modificar.
Salida      : Devuelve TRUE si todo fue correcto
              Devuelve FALSE si hubo algun error.
**/
/***************************************************************************/
BOOL bfnDBInsCanc(DATCON stGen);
/**
Descripcion : Funcion que inserta en CO_CANCELADOS una deuda cancelada
Entrada     : Estructura con los datos de la deuda, fecha del pago
Salida      : Devuelve TRUE si no hay erorres.
              Devuelve FALSE si hubo algun error.
**/
/******************************************************************************/
BOOL bfnDBInsPagConc(DATCON *stDatPag, DATCON *stDatFac, double dImporte);
/**
Descripcion : Inserta en CO_PAGOSCONC la relacion pago/deuda
Entrada     : Datos del pago, datos de la deuda, importe pagado
Salida      : Devuelve TRUE si no hay erorres.
              Devuelve FALSE si hubo algun error.
**/
/***************************************************************************/
int ifnCancelacionCreditos(long lCodCliente,DATCON *stConCar,int iCodCredito,char *szFec,int iCarrier);
/**
Descripcion: Funcion encargada de cancelar los creditos para un cliente.
Entrada    : lCodCliente, codigo de cliente.
             iCodCredito, es el codigo del credito.
Salida     : OK, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/
/*****************************************************************************/
int ifnDBPagoUnAbonadoConcep(DATCON *stDatPag,DATCON *stDatFac,int iCodCredito);
/**
Descripcion: Efectua la cancelacion en cartera de un pago contra conceptos
             de consumo para uno de los Abonados de un cliente.
             Mientras queden importe para cancelar y conceptos cancelados
             genera conceptos al haber. Si despues sigue quedando importe
             genera un credito.
Entrada    : Datos del pago, de la factura, indicador credito.
Salida     : Si todo va bien devuelve 0 y en caso contrario un numero de error.
**/
/******************************************************************************/
BOOL bfnDBObtFecha(char *szDia);
/**
Descripcion : Funcion que devuelve fechas segun formato requerido.
Entrada     : variable donde deposita la fecha seleccionada.
Salida      : Devuelve TRUE si todo correcto
              Devuelve FALSE si hubo algun fallo
**/
/******************************************************************************/
BOOL bfnDBObtDatGen();
/**
Descripcion : Funcion que recoge datos generales para la ejecucion del programa.
Entrada     :
Salida      : Devuelve TRUE si todo correcto
              Devuelve FALSE si hubo algun fallo
**/

BOOL bfnDBInsCancNC( DATCON stGen, int iDebeHaber );
BOOL bfnDBObtFechaFA( char *szDia );
BOOL bfnDBInsPagConNC( DATCON stGenNota, DATCON stGenFact, double dImporte );
int  ifnLlamaCancelacionCred( long lCodCliente, char *szFec_pago);
int  ifnDBInsDatosPago(long lCodCliente, DATCON *stDatNota, double dImpPago);
BOOL bfnDBDelCartNC( DATCON stGen );
BOOL bfnDBUpdCastigoNC( long lCodCliente, long lNumFolio, double dMtoPago );
BOOL bfnDBUpdCartNC(DATCON stGen, double dImporte, int iDebHab);

int ifnCancelacionParcialCreditos(long lCodCliente , long lNumSecuenciF, int iCodTipDocumF, 
								  long lCodAgenteF , char * szLetraF   , int  iCodCentremiF, 
								  int  iCuotaF     , double dImporteF,   long lNumSecuenciP, 
								  int iCodTipDocumP, long lCodAgenteP,   char * szLetraP,
								  int  iCodCentremiP,char * szFecP );
/**
Se crea funcion por Incidencia XO-200509130656, 27-09-2005 rvc Soporte RyC
Descripcion: Funcion encargada de cancelar parcialmente los creditos para un cliente.
Entrada    : lCodCliente 
             stConCre 
             lNumSecuenci 
             iCodTipDocum
             lCodAgente 
             szLetra    
             iCodCentremi
             iCuota 
             szFecPago			 
Salida     : TRUE, si todo ha ido bien.
			 ERR_xxx, si falla algo.
**/

int ifnCancelaConceptosNC(long lCodCliente , int  iCodTipDocum, int  iCodCentremi, 
						long lNumSecuenci, long lCodAgente  , char * szLetra   , 
 						DATCON stCon    , char *szFecPago );
/**
Se crea funcion por Incidencia XO-200509130656, 27-09-2005 rvc Soporte RyC
Descripcion: Funcion encargada de cancelar los conceptos de un documento.
Entrada    : 

Salida     : TRUE, si todo ha ido bien.
			 ERR_xxx, si falla algo.
**/


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

