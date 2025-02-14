/****************************************************************************/
/*                                                                          */
/*    Programa    : Prototipos y estructuras para la generacion de carrier  */
/*    Modulo      : COBROS.                                                 */
/*    Fichero     : carrier.h                                               */
/*    Descripcion : Prototipos y estructuras.                               */
/*    Programador : Julia Serrano Pozo                                      */
/*    Fecha       : 24-03-1997                                              */
/*                                                                          */
/****************************************************************************/
/* 	-PGonzaleg 1-08-2002						    */
/*		Modificacion del largo del campo "Codigo de Banco"	    */
/*		de la estrucutura DATPAG				    */
/*	-PGonzalez 17-03-2004						    */
/*		Modificacion del largo del campo PREF_PLAZA		    */
/*									    */
/****************************************************************************/


#include <GenTypes.h>
#include <GenORA.h>
#include <genco.h>

/*****************************************************************************/
/* Versionamiento                                                            */
/*****************************************************************************/
/* SAAM-20030703: Se inicia el version con la incidencia MA-300620030036     */
#define szVersionActual          "3.002"
#define szUltimaModificacion __DATE__ " " __TIME__
/*****************************************************************************/

/****************************************************************************
                           ESTRUCTURAS DATOS GENERALES 
****************************************************************************/

/*********************************************
Estructura para recoger los datos por
la linea de comandos.
**********************************************/
typedef struct LineaComandoFoliacion
{
	char    szUser       [50];
    char    szUsuario    [63];
    char    szPass       [50];

    char    szDirLogs  [1024];       /*  Directorio de Archivos Log's y Err      */
    char    szDirDats  [1024];       /*  Directorio de Archivos de Datos Dat     */
    char    szDataName [1024];       /*  Nombre del Archivo de Datos de Folios   */
    FILE    *DataFile        ;       /*  Puntero de Archivo de Datos (Folios)    */
    char    szOpcion      [1];       /*  Anular, Consumir o Reporte  [A/C/R]     */
     int    iOpcion          ;
    BOOL    bOptUsuario      ;
    BOOL    bOptCiclo        ;
    BOOL    bOptHelp         ;
    long    lTipoDocumen     ;
    long    lCodCiclFact     ;
    long    lClienteIni      ;
    long    lFolioIni        ;
    long    lCantidad        ;
    char    szFecFoli     [9];
     int    iNivLog          ;
    char    szCodModGener [4];
    char    szCodDespacho [6];
}FOLIACIONLINEACOMANDO;


typedef struct tagLocalParam
{
      long    	lCodCliente   		;
      long    	lNumAbonado   		;
      long    	lNumCelular   		;       	     
      long	lCodTipdocum  		;
      long      lCodCentremi  		;
      long 	lNumSecuenci  		;
      long	lCodVendedorAgente	;
      char	szLetra[2]		;
      long 	lCodConcepto		;
      long 	lCodColumna		;
      long	lNumFolio		;
      /*char  	szPrefPlaza[3+1]	; */	/* Comentado   por PGonzalez 17-03-2004 */
      char  	szPrefPlaza[11]		; 	/* Incorporado por PGonzalez 17-03-2004 */
      double	dImporte		;
}LOCALPARAM;


typedef struct tagDATGEN
{
	 char		szPathFich[256];
	 char		szPathLog[256];
	 char		szPathProc[256];

}DATGEN;

typedef struct tagDATPRO
{
	FILE 		*pFich;
	FILE 		*pLog;
	int		iCarrier;
	char		szFecIni[9];
	char		szFecFin[9];
	long  		lNumReg;
	int  		iNumAno;
	int  		iNumPag;
	double	dImpTotal;
	double	dImpAnomalias;
	double	dImpPagos;
} DATPRO;

typedef struct tagDATDOC        /* Identificacion de un Documento */
{
   int     iCodTipDocum;
   long    lCodAgente;
   char    szLetra[2];
   int     iCodCentrEmi;
   long    lNumSecuenci;

} DATDOC;


typedef struct tagDATPAG        /* Datos de un Pago */
{
   long    lCodCliente;
   DATDOC  stDatDocPago;
   double  dImpPago;
   char    szFecValor[9];
   char    szNomUsu[31];
   int     iCodSisPago;
   int     iCodOriPago;
   int     iCodCauPago;
   char    szCodBanco[16];
   char    szCodSucursal[5];
   char    szCtaCorriente[15];
   char    szCodTipTarjeta[4];
   char    szNumTarjeta[21];
} DATPAG;

typedef struct tag_CONCEPTO_CARRIER_COBRANZA
{
   	long    lConceptoCobranza	[10];
}REG_CONCEPTO_CARRIER_COBRANZA;




FOLIACIONLINEACOMANDO       stLineaComando;

/***************************************************************************/
/***************************************************************************/
int ifnInitInstance(int argc, char *argv[]);
/**
Descripcion: Inicializar Variables Globales, comprobar linea de comandos,
             apertura de ficheros, recogida de datos generales...
Salida     : En caso de Error devuelve ERR_XXX y si todo va bien OK.
**/
/***************************************************************************/
BOOL bfnDBCargaDatGen();
/**
Recupera datos de la tabla CO_DATGEN en la variable globla stDatGen.
En caso de Error devuelve FALSE.
**/
/***************************************************************************/
void TRAZA (const char* szCad);
/**
Imprime la cadena el el fichero de log.
Usa la variable general stDatPro.
**/
/***************************************************************************/
void vfnExitInstance(BOOL bBien);
/**
Funcion final del proceso.
Libera memoria de estructuras en memoria.
Cierra ficheros.
Desconecta de Oracle.
**/
/****************************************************************************/
int ifnDBTratCartera(char *szUsuario);
/**
Descripcion: Funcion que cancela la deuda del carrier en cartera
**/
/****************************************************************************/
int ifnDBTratCarteCelular(long lCodCliente,char *szUsuario);
/**
Descripcion: Funcion que se encarga de cancelar la deuda de los carrier en la
             cartera del cliente
Salida     : OK si todo va bien o ERR_xxx si falla algo
**/
/****************************************************************************/
int ifnDBTratAbonados(void);
/**
Descripcion: Funcion que se encarga de insertar el importe por abonado en el
             fichero de carrier.
Salida     : OK si todo va bien,
             ERR_xxx si falla algo
**/
/****************************************************************************/
int ifnDBTratCelular(LOCALPARAM pstlocalparam);
/**
Descripcion: Funcion que obtiene los importes carrier cancelados
Salida     : OK si todo esta bien
             ERR_xxx si hay algun error.
**/
/****************************************************************************/
/*BOOL bfnDBObtImp(long lFolio,long lCodCliente,long lNumAbonado,
                  double *dImporte, int *iEnc); */
/**
Descripcion: Funcion que obtiene la suma de los importes de un concepto al haber
             o al debe.
Salida :     TRUE, si todo ha ido bien.
             FALSE, si falla algo.
**/
/***************************************************************************/
BOOL bfnDBFechaSys(char *szFecha);
/**
Descripcion: Funcion que obtiene la fecha del sistema
**/
/***************************************************************************/
BOOL bfnDBUpdProcesado(long lCodCliente, long lNumAbonado, long lNumFolio);
/**
Descripcion: Funcion que indica que el concepto ya ha sido enviado al carrier
**/
/***************************************************************************/
BOOL bDBTomarSecuencia(int *iCodTipDocum,int *iCodCentrEmi,long *lCodAgente,
                        char *szLetra, long *lNumSecuenci,int *iSisPago,
                        int *iOriPago, int *iCauPago );
/**
Descripcion: Recupera los datos del pago.
Salida     : Si todo va bien devuelve TRUE.
**/

/****************************************************************************/
BOOL bfnDBInsDatosPago(DATPAG *stDatPag);
/**
Inserta registro en co_pagos  con los datos de la estructura.
En caso de error devuelve FALSE.
**/
/****************************************************************************/
int ifnDBPagoUnAbonado(DATPAG *stDatPag,long lCodCliente, int iCodConcepto);
/**
Descripcion: Efectua la cancelacion en cartera de un pago contra conceptos
             de consumo para uno de los Abonados de un cliente.
             Mientras queden importe para cancelar y conceptos cancelados
             genera conceptos al haber. Si despues sigue quedando importe
             genera un credito.
Salida     : Si todo va bien devuelve 0 y en caso contrario un numero de error.
**/

/****************************************************************************/
BOOL bfnDBInsPagCon(DATDOC *stDoc,DATCON *stHab);
/**
Descripcion: Lleva la relacion del pago con el concepto a pagosconc.
Salida     : En caso de error devuelve FALSE.
**/
/****************************************************************************/
BOOL bfnDBLlevarACanCarrier(DATCON *stCon,long lCodCliente,char *szFecHis);
/**
Descripcion: Mueve el concepto de argumento y todos sus relacionados de
             cartera a cancelados.
Salida     : En caso de error devuelve FALSE.
**/
/*****************************************************************************/

char *cfnGetTime(int fmto);
/**
Descripcion : Recupera la fecha en el formato deseado (pudiendo ser fecha y hora)
Salida      : Fecha segun formato deseado
**/
/*****************************************************************************/



BOOL bGetCausaPago(int  ihCodTipDocumPago,
                   int  ihCodCentrEmiPago,
                   long lhNumSecuenciPago,
                   long lhCodVendedorPago,
                   char *szhLetraPago,
                   char *szhCodCauPago);


BOOL bfnDBFechaTotalSys(char *szFecha);

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

