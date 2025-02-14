/****************************************************************************
	Fichero         : fac.h
	Modulo          : cobros
	Fecha           : 30-01-1997
	Programador     : Julia Serrano.
	Descripcion     : Prototipos, estructuras y constantes para  funcion de 
					      interfaz Facturacion Cobros.
	Modificacion    : 30-01-1997

****************************************************************************/

/***************************************************************************
								CONSTANTES
****************************************************************************/


#ifndef _FAC_H_
#define _FAC_H_

#define iTIPDOCPAGO         3
#define szLETRAPAGO        "X"
#define lAGENTEPAGO         1

#define IMPORTEMINIMO    0.01
#define IMPORTEMAXIMO     1e8
#define INVMIN            100

#define ORA_FETCHNULL   -1405

#define iLOG             1

#define ABOCLI           0
#define PRODGEN          5

/***************************************************************************
								ESTRUCTURAS
****************************************************************************/

typedef struct tagDATDOC        /* Identificacion de un Documento */
{
   int     iCodTipDocum;
   long    lCodAgente;
   char    szLetra[2];
   int     iCodCentrEmi;
   long    lNumSecuenci;

} DATDOC;

typedef struct tagDATFAC        /* Identificacion de un Documento Factura */
{
   DATDOC  stDatDocFac;
   long    lCodCliente;
   long    lNumAbonado;
   int     iCodProducto;
   int     iCodConcepto;
   long    lNumFolio;
   long    lNumCuota;
   int     iSecCuota;
   long    lNumTransa;
   long    lNumVenta;
} DATFAC;

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
   char    szCodBanco[4];
   char    szCodSucursal[5];
   char    szCtaCorriente[15];
   char    szCodTipTarjeta[4];
   char    szNumTarjeta[21];
} DATPAG;

/* Datos de Concepto de Cartera */
typedef struct tagDATCON
{
   int     iCodTipDocum;
   long    lCodAgente;
   char    szLetra[2];
   int     iCodCentremi;
   long    lNumSecuenci;
   int     iCodConcepto;
   int     iColumna;
   int     iCodProducto;
   double  dImporteDebe;
   double  dImporteHaber;
   int     iIndContado;
   int     iIndFacturado;
   char    szFecEfectividad[9];
   char    szFecVencimie[9];
   char    szFecCaducida[9];
   char    szFecAntiguedad[9];
   char    szFecPago[9];
   int     iDiasVencimiento;
   long    lNumAbonado;
   long    lNumFolio;
   long    lNumCuota;
   int     iSecCuota;
   long    lNumTransa;
   long    lNumVenta;
   char    szFolioCTC[12];
   char    szPrefPlaza[26];
   char    szCodOperadoraScl[6];/* jlr_11.02.03 */
   char    szCodPlaza[6];		/* jlr_11.02.03 */
}DATCON;

/****************************************************************************/

BOOL bfnInicializaLogFac( FILE * );

/****************************************************************************/

int ifnDBPasoCob( long lCodCliente   ,
                  int  iCodTipDocum  , long lCodAgente  , char *szLetra   ,
                  int  iCodCentremi  , long lNumSecuenci, int  iCodProducto,
                  long lNumTransa    , long lNumVenta   , char *szFecValor,
                  char *szFecPriCuota, long lNumProceso , long lNumAbonado, 
				  int iCodTipMovimiento, 
				  char *pszPrefPlaza , char *pszCodOperadora, char *pszCodPlaza ); /* XC-200411020352 03-11-2004 RyC PRM. Corrección de parámetros */
/**
Descripcion: Funcion del interfaz Facturacion Cobros en primera venta
Salida     : OK si todo va bien
             ERR_xxx si hay algun error
**/
/*****************************************************************************/
int ifnDBInsCuota0( long lCodCliente, DATCON stConF, int iIndAbono, double dImporteAbono, char *szFecVenta, 
                    char *szFecPrimeraCuota, long lNroProceso, char *szFecValor, long lNumAbonado,
                    char *pszPrefPlaza, char *pszCodOperadoraScl, char *pszCodPlaza );  /* XC-200411020352 03-11-2004 RyC PRM. Corrección de parámetros */
/**
Descripcion: Funcion que recupera los datos para crear el registro en co_cartera
			 de la cuota 0.
Salida     : TRUE  si todo va bien
			 FALSE si no termina bien
**/
/*****************************************************************************/
int ifnDBCanVentaMenor(long lCodCliente,DATCON *stCon,char *szFecValor,
                           double dImp);
/**
Descripcion: Funcion que cancela la venta cuando el importe es igual
             Importe en carteventa menor que importe en cartera
Salida     : OK si todo va bien
             ERR_xxx si falla algo
**/
/*****************************************************************************/
int ifnDBCanVentaMayor(long lCodCliente,DATCON *stCon,char *szFecValor,
                        double dImp,int iCodCredito);
/**
Descripcion: Funcion que cancela la venta cuando el importe es igual
             Importe en carteventa mayor que importe en cartera
Salida     : OK si todo va bien
             ERR_xxx si falla algo
**/
/*****************************************************************************/
int ifnDBCanVentaIgual( long lCodCliente, DATCON *stCon, char *szFecValor, long lNumSecuenciaCIC );
/**
Descripcion: Funcion que cancela la venta cuando el importe es igual
Salida     : OK si todo va bien
             ERR_xxx si falla algo
**/
/*****************************************************************************/
int ifnDBDelPagCon( DATDOC *stDoc, DATCON *stCon, int iCont, long lCodCliente, 
					long lNumTransa, int iVeces, long lNumSecuenciaCIC );
/**
Descripcion: Funcion que se encarga de borrar el pagconc de la primera venta
             e insertar el relacionado correcto
Salida     : TRUE si se efectua correctamente
             FALSE si se produce algun error
**/
/*****************************************************************************/

int ifnDBObtImpFa(long lCodCliente, DATCON *stCon, double *dImporte);
/**
Descripcion: Funcion que obtiene el importe de co_cartera
Salida     : TRUE si todo va bien
             FALSE si hay algun error
**/
/*****************************************************************************/
int ifnDBObtImpCo(long lCodCliente, DATCON *stCon,double *dImporte,int *iEncon);
/**
Descripcion: Funcion que obtiene el importe de co_carteventa
Salida     : TRUE si todo va bien
             FALSE si hay algun error
**/
/*****************************************************************************/
BOOL bfnDBObtFecha(char *szFecha);
/**
Descripcion: Obtiene la fecha del sistema.
Entrada    : szFecha, fecha del sistema.
Salida     : szFecha, fecha del sistema.
**/
/***************************************************************************/
BOOL bfnDBIntCancelados (DATCON *stConGen, long lCodCliente,char *szFecHis);
/**
Descripcion: Introduce en cancelados el concepto de la estructura poniendo
             fecha historico igual a la fecha valor.
             En caso de Error devuelve FALSE.
**/
/*****************************************************************************/
BOOL bfnDBUpdateVenta(long lCodCliente, int iCodProducto,long lNumTransa,
                      long lNumVenta);
/**
Descripcion : Funcion que inserta un importe de primera venta en co_carteventa.
Entrada     : stDatPag, estructura de pago
              stDatFac, estructura de factura
Salida      : TRUE, si todo ha ido bien.
              FALSE, si falla algo.
**/
/***************************************************************************/
BOOL bfnDBUpdateCarVenta(long lCodCliente, int iCodProducto,long lNumTransa);
/**
Descripcion : Funcion que al updatear el indicador de cancelado indica que si
              facturacion vuelve a incorporar la factura de primeraventa no se
              le va a permitir.
Entrada     : stDatPag, estructura de pago
              stDatFac, estructura de factura
Salida      : TRUE, si todo ha ido bien.
              FALSE, si falla algo.
**/
/***************************************************************************/
BOOL bfnDBIntCarteraFac(DATCON *stConGen,long lCodCliente,char *szCodMoneda);
/**
Descripcion: Funcion que introduce en cartera el concepto generado.
Entrada:     stConGen, estructura de concepto generado.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
/*****************************************************************************/
BOOL bfnDBConversionMon(char *szMonedaOrigen, char *szMonedaDestino,
                     double dImpOrigen, double *dImpDest);
/**
Descripcion: Funcion que realiza la convesion
Salida     : TRUE si todo va bien
             FALSE si falla algo
**/
/*****************************************************************************/
BOOL bfnDBInsPagCon(DATDOC *stDoc,DATCON *stHab);
/**
Descripcion: Lleva la relacion del pago con el concepto a pagosconc.
Salida     : En caso de error devuelve FALSE.
**/
/*****************************************************************************/
BOOL bfnDBValFecValor(char *szFecValor);
/**
Valida si la fecha pasada por argumento es menor o igual que SYSDATE.
Si en mayor devuelve FALSE.
**/

/*****************************************************************************/
BOOL bfnDBSecCol(DATCON *stCon);
/**
Descripcion: Funcion que obtiene la secuencia de la proxima columna.
Entrada:     stCon, estructura de datos de concepto generado.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/

/*****************************************************************************/
BOOL bfnDBIntCartera(DATCON *stConGen,long lCodCliente);
/**
Descripcion: Funcion que introduce en cartera el concepto generado.
Entrada:     stConGen, estructura de concepto generado.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/

/*****************************************************************************/
BOOL bfnDBUpdCartera(DATCON *stCon,long lCodCliente);
/**
Descripcion: Modifica el importe del concepto
Salida     : True, si todo va ok
             False, si se genera algun error
**/

/*****************************************************************************/
int ifnLlamaCancelacionCredito( long lCodCliente, char *szFec_pago);
BOOL bfnDBObtConCreFA( int *iCodConcepto );
BOOL bfnDBLlevarACanCtosFA(DATCON *stCon,long lCodCliente,char *szFecHis);
BOOL bfnDBSecColFA(DATCON *stCon);
BOOL bfnDBIntCarteraFA(DATCON *stConGen,long lCodCliente);

#endif /* _FAC_H_ */


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

