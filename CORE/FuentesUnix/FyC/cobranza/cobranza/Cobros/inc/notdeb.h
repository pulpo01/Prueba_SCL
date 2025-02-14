/****************************************************************************
	Fichero         : notdeb.h
	Modulo          : cobros
	Fecha           : 18-03-1997
	Programador     : Julia Serrano.
	Descripcion     : Prototipos, estructuras y constantes para  funcion de 
					      cancelacion de notas.
	Modificacion    : 18-03-1997

****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <geora.h>
#include <GenTypes.h>   /* Declaracion de tipos generales.     */
#include <GenORA.h>     /* Libreria general ORACLE.            */
#include <coerr.h>      /* Declaracion de constantes de error. */
#include <genco.h>

/***************************************************************************
								CONSTANTES
****************************************************************************/
#define iTIPDOCPAGO         3
#define szLETRAPAGO        "X"
#define lAGENTEPAGO         1

#define IMPORTEMINIMO    0.01
#define IMPORTEMAXIMO     1e10
#define INVMIN            100

#define ORA_FETCHNULL   -1405

#define iLOG             1

#define ABOCLI           0
#define PRODGEN          5


/***************************************************************************
								ESTRUCTURAS
****************************************************************************/
struct TiGeneral
{
   FILE *lFile;
   char  szPathLog[256];
} TiG;

int ifnCanNotas(long lCodCli  , double dImporte , char *szFecValor,
            int iCodTipDocum  , long lCodAgente , char *szLetra,
            int  iCodCenEmi   , long lNumSecu   , int iCodCredito,
            int  iCodConcepto , int iNC         , char *szFecVenci);
int ifnDBContraDocum(long lCodCliente ,DATCON *stCre,int iCodCredito, char *szFecValor);
int ifnCancelacionCreditos( long lCodCliente, char *szFecValor, int k);
BOOL bfnDBSumImporte(DATCON *stCon,long lCodCliente,double *dImporte);
BOOL bfnDBSumImporteAbo(DATCON *stCon,long lCodCliente,double *dImporte);
int ifnDBAjusteNC(DATCON *stCreN,DATCON *stConCre,int iCodCredito, long lCodCliente, char *szFecValor);
int ifnTratConcepNotas(DATCON *stCre,DATCON *stConCre,long lCodCliente, char *szFecValor,int *iEncCarr);
BOOL bfnDBInsCreCon(DATCON *stDoc,DATCON *stHab);
BOOL bfnDBCompConcepto(int iCodConcepto, int *iEncon);
BOOL bfnDBObtDatGen();
void rtrim( char *szCadena );
int ifnCancelacionParcialCreditos(long lCodCliente , DATCON *stConCre, long lNumSecuenci, int  iCodTipDocum, long lCodAgente , char * szLetra   , int  iCodCentremi, int  iCuota     , char * szFecPago, long lNumAbonado );
int ifnCancelacionTotalCreditos(long lCodCliente , DATCON *stConCre, long lNumSecuenci, int  iCodTipDocum, long lCodAgente , char * szLetra   , int  iCodCentremi, int  iCuota     , char * szFecPago , long lNumAbonado );
int ifnCancelaConceptos(long lCodCliente , int  iCodTipDocum, int  iCodCentremi, long lNumSecuenci, long lCodAgente  , char * szLetra   , DATCON *stCon    , char *szFecPago );


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

