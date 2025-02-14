/****************************************************************************/
/*                                                                          */
/*    Programa    : Prototipos y estructuras de calidad de cliente ,        */
/*                  porcentajes , Recargos.                                 */
/*    Modulo      : COBROS.                                                 */
/*    Fichero     : recargos.h                                              */
/*    Descripcion : Prototipos y estructuras.                               */
/*    Programador : Julia Serrano Pozo.                                     */
/*    Fecha       : 13-11-1995                                              */
/*                                                                          */
/****************************************************************************/
#include <genco.h>

#define IMPORTEMINIMO    0.01
#define IMPORTEMAXIMO     1e10
#define INVMIN            100

#define ORA_FETCHNULL   -1405


/****************************************************************************/
/******************         ESTRUCTURAS          ****************************/
/****************************************************************************/
/* Datos de Concepto de Cartera 
Estructura definida en genco.h
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
}DATCON;*/

/* Datos necesarios de un cliente */
typedef struct tagDATCLI
{
   long       lCodCliente       ;
   char       szCodCalCli[3]    ;
   char       szCodEstado[3]    ;
   int        iNumAboCli        ;
   int        iIndPagos         ;
   double     dImpMorosidad     ;
   char       szIndDebito[2]    ;
   int        iCodSispago       ;
   char       szNomCliente[21]  ;
   char       szNomApeClien1[21];
   char       szNomApeClien2[21];
   char       szCodTipIdent[3]  ;
   char       szNumIdent[16]    ;
   int        iCodCiclo         ;
   int        iDiasGracia       ;
}DATCLI;

/****************************************************************************/
/****************** ESTRUCTURAS PARA CANTIDADES  ****************************/
/****************************************************************************/
typedef struct tagDATCAN
{
	int    iCodRngCanti;
	char   szFecDesde[9];
	char   szFecHasta[9];
	int    iCodTipCanti;
	int    iCodProducto;
	char   szDesTipCanti[41];
	char   szCodCalClien[3];
	double dCantiRecargo;
}DATCAN;

typedef struct tagARRCAN
{
	DATCAN *stDatCanCli;
	int    iCont;
}ARRCAN;

/****************************************************************************/
/****************** ESTRUCTURAS PARA PORCENTAJES ****************************/
/****************************************************************************/

typedef struct tagDATPOR
{
	int    iCodRngPorcen;
	char   szFecDesde[9];
	char   szFecHasta[9];
	int    iCodTipPorcen;
	int    iCodProducto;
	char   szDesTipPorcen[41];
	char   szCodCalClien[3];
	double dPrcRecargo;
}DATPOR;

typedef struct tagARRPOR
{
	DATPOR *stDatPorCli;
	int    iCont;
}ARRPOR;

/****************************************************************************/
/****************** ESTRUCTURAS PARA RECARGOS *******************************/
/****************************************************************************/

typedef struct tagDATREC
{
	int     iCodRngConcep;
	int     iCodCon;
	char    szFecDesde[9];
	char    szFecHasta[9];
	int     iCodConGen;
	int     iIndPorcen;
	double  dImpUmbral;
	double  dValor;
	int     iCodTipPorcen;
	int     iCodTipCanti;
}DATREC;

typedef struct tagARRREC
{
	DATREC  *stDatRec;
	int     iCont;
}ARRREC;

/****************************************************************************/
/****************************************************************************/
/*                                 PROTOTIPOS                               */
/****************************************************************************/
/****************************************************************************/
int ifnDBCreateDatCantidades(ARRCAN *stArrCan);
/**
Descripcion: Funcion que crea un array que contiene todas las cantidades
             del sistema.
Entrada:     stArrCan, puntero a la estructura array que contiene el
             tipo Cantidad.
Salida:      OK, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/
/***************************************************************************/
int iCmpArrayCan( const void *vpCad1, const void *vpCad2 );
/* int iCmpArrayCan( void *vpCad1, void *vpCad2 ); */
/**
Descripcion: Funcion que compara dos cadenas pasadas como parametro.
            El array de porcentajes esta ordenado por codigo de calidad de
            cliente, codigo de tipo de cantidad y fecha.
Entrada:    vpCad1, Cadena 1 a ser comparada.
            vpCad2, Cadena 2 a ser comparada.
Salida:     Entero que indica si dichas cadena son o no iguales.
            Si son iguales devuelve 0.
            Se comporta igual que strcmp().
**/

/***************************************************************************/
int ifnGetCantidad(char *szFec,int iCodTip,char *szCalClien,int iCodProducto,
                   double *dCantiRec,ARRCAN *stArrCan);
/**
Descripcion: Funcion que devuelve la cantidad del recargo.
Entrada:    szFec, Fecha .
            iCodTip, el el codigo del tipo de cantidad.
            szCalCliente, es el codigo de calidad de cliente.
            dCantiRec, es el valor devuelto de la cantidad del recargo.
            stArrCan, es la estructura array de tipo cantidad.
				iCodProducto, codigo de producto.		
Salida:     OK, si todo va bien.
            ERR_xxx, si no lo encuentra.
**/
/***************************************************************************/
void vfnLiberarCan(ARRCAN *stArrCan);
/**
Descripcion: Funcion que libera la memoria del array de cantidades.
Entrada:     stArrCan, puntero al array de cantidades.
Salida:      Ninguna.
**/

int ifnDBCreateDatPorcentajes(ARRPOR *stArrPor);
/**
Descripcion: Funcion que crea un array que contiene todos los porcentajes
             del sistema.
Entrada:     stArrPor, puntero a la estructura array que contiene el
             tipo Porcentaje.
Salida:      OK, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/

/*****************************************************************************/
int iCmpArrayPor(const void* vpCad1,const void* vpCad2);
/**
Descripcion: Funcion que compara dos cadenas pasadas como parametro.
Entrada:     vpCad1, Cadena 1 a ser comparada.
             vpCad2, Cadena 2 a ser comparada.
Salida:      Entero que indica si dichas cadena son o no iguales.
**/

/*****************************************************************************/
int ifnGetPorcentaje(char *szFec,int iCodTip,char *szCalClien,int iCodProducto,
                     double *dPrcRec,ARRPOR *stArrPor);
/**
Descripcion: Funcion que devuelve el porcentaje del recargo.
Entrada:     szFec, Fecha .
             iCodTip, el el codigo del tipo de porcentaje.
             szCalCliente, es el codigo de calidad de cliente.
             dPrcRec, es el valor devuelto del porcentaje del recargo.
             stArrPor, es la estructura array de tipo porcentaje.
				 iCodProducto, codigo de producto.
Salida:      OK, si todo va bien.
             ERR_xxx, si no lo encuentra.
**/

/*****************************************************************************/
void vfnLiberarPor(ARRPOR *stArrPor);
/**
Descripcion: Funcion que libera la memoria del array de porcentajes.
Entrada:     stArrPor, puntero al array de porcentajes.
Salida:      Ninguna.
**/

/*****************************************************************************/
int ifnDBCreateDatRec(ARRREC *stArrRec);
/**
Descripcion: Funcion que crea el array de datos de Recargos.
Entrada:     stArrRec, puntero a la estructura array de datos de Recargos.
Salida:      OK, si todo va bien.
             ERR_xxx, si falla algo.
**/

/*****************************************************************************/
int iCmpArrayRec(const void* vpCad1,const void* vpCad2);
/**
Descripcion: Funcion de comparacion.
Entrada:     vpCad1, Cadena 1 a ser comparada.
             vpCad2, Cadena 2 a ser comparada.
Salida:      Entero que indica si la comparacion es correcta o no.
**/

/*****************************************************************************/
int ifnGetRecargos(char *szFec,int iCodCon,DATREC *stRec,ARRREC stArrRec);
/**
Descripcion: Funcion que devuelve una estructura con el recargo.
Entrada:     szFec, Fecha .
             iCodTip, el el codigo del concepto.
             stRec, es la estructura que se devuelve.
             stArrRec, es la estructura array de tipo Recargo.
Salida:      OK, si todo va bien.
             ERR_xxx, si no lo encuentra.
**/

/*****************************************************************************/
void vfnLiberarRec(ARRREC *stArrRec);
/**
Descripcion: Funcion que libera la memoria del array de Recargos.
Entrada:     stArrRec, puntero al array de recargos.
Salida:      Ninguna.
**/
/****************************************************************************/
int ifnDBCompCliente(long lCodCliente, char *szFecValor,int iCodCredito);
/**
Descripcion: Comprueba primero si el cliente tiene pago mediante PAC.
             En caso negativo llama a la funcion que genera recargos.
Salida     : Si todo va bien devuelve OK y en caso contrario ERR_XXXX.
**/

/*****************************************************************************/
/*****************************************************************************/
int ifnRecargos(long lCodCliente,char *szFecValor,int iCodCredito);
/**
Descripcion: Funcion encargada de generar los recargos.
Entrada:     lCodCliente, codigo de cliente.
             szFecValor, fecha del sistema.
             iCodCredito, codigo de credito.
Salida:      OK, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/

/*****************************************************************************/
int ifnDBGenerarRecargos(DATCLI stCli,ARRREC *stArrRec, ARRPOR *stArrPor,
			ARRCAN *stArrCan, char *szFecValor,int iCodCredito);
/**
Descripcion: Funcion que para un cliente obtiene sus conceptos  y los
             conceptos generados actualizando la CARTERA.
Entrada:     stCli, estructura de datos de Cliente.
             stArrRec, puntero al array de estructura de recargos.
             stArrPor, puntero al array de estructura de porcentaje.
             stArrCan, puntero al array de estructura de cantidades.
             szFecValor, Fecha del sistema.
             iCodCredito, codigo de credito.
Salida:      OK, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/
/*****************************************************************************/
BOOL bfnDBUpdImpRecargo(long lCodCliente);
/**
Descripcion: Funcion que modifica el indicado de facturado de los recargos
Salida     : TRUE si todo va bien
             FALSE si falla algo
**/
/*****************************************************************************/
BOOL bfnDBGetImpRecargo(long lCodCliente,double *dImporteRecar);
/**
Descripcion: Funcion que obtiene el importe de los recargos para un cliente
Salida     : TRUE si todo va bien
             FALSE si falla algo
**/

/*****************************************************************************/
int ifnIntGenerado(DATCLI stCli,DATCON *stCon,char *szFecValor,
              ARRREC *stArrRec, ARRPOR *stArrPor,ARRCAN * stArrCan,int *iModi);
/**
Descripcion: Funcion que obtiene los conceptos generados.

Entrada    : stCli, estructura de cliente.
             stCon, estructura del concepto origen.
             szFecValor, fecha del sistema.
             stArrRec, estructura de array de recargos.
             stArrPor, estructura de array de porcentaje.
             stArrCan, estructura de array de cantidades.
             iModi,variable que indica si se ha de modificar fecvencimie.
Salida:      OK, si todo va bien.
             ERR_xxx, si falla algo.
**/
/*****************************************************************************/
BOOL bfnDBModConcepto(char *szFecValor,DATCON *stCon,long lCodCliente);
/**
Descripcion: Funcion que modifica la fecha de vencimiento del concepto origen
             por la fecha valor.
Entrada:     szFecValor, es la fecha valor.
             stCon, estructura de concepto origen.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
/*****************************************************************************/
BOOL bfnDBIntRecarConc(long lCodCliente,DATCON *stCon,DATCON *stConGen,
                     int iIndPorcen,int iCodTip);
/**
Descripcion: Funcion que inserta el concepto con el concepto generado
Salida     : TRUE si todo ha ido correctamente.
**/

/*****************************************************************************/
BOOL bfnDBGetDiaGracia(DATCLI *stCli, char *szFec, int iProducto);
/**
Descripcion: Funcion que obtiene los dias de gracia.
Entrada:     szCodCalCli, codigo de calidad de cliente.
             szFec, fecha del sistema.
             iDiasGracia, dias de gracia.
             iProducto, producto.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
/*****************************************************************************/
BOOL bfnDBGetCalCliente(DATCLI *stCli);
/**
Descripcion: Funcion que obtiene la calidad de cliente.
Entrada:     stCli, estructura de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/

/*****************************************************************************/

BOOL bfnDBProxCol(long lCodCliente,DATCON *stCon);
/**
Descripcion: Funcion que obtiene la proxima columna.
Entrada:     lCodcliente, codigo de cliente.
             stCon, estructura de datos de concepto generado.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
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
/****************************************************************************/
int ifnDBCompRecargos(long lCodCliente,ARRREC *stArrRec,ARRPOR *stArrPor,
                        ARRCAN *stArrCan,char *szFecValor,int iCodCredito,
                        char *szCodCalCli, double *dImporteRecar);
/**
Descripcion: Comprueba primero si ha vencido algun concepto.
             En caso afirmativo llama a la funcion que genera recargos.
Salida     : Si todo va bien devuelve OK y en caso contrario ERR_XXXX.
**/
/****************************************************************************/
BOOL bfnDBObtConCre(int *iCodConcepto);
/**
Descripcion: Obtener el codigo de concepto credito
Salida     : True, si todo va ok
             False, si se genera algun error
**/
/*****************************************************************************/



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

