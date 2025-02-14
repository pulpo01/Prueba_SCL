/* ***********************************************
		  "CargaBalance.h"
		  Abril, 08, 2002
		  Nelson Contreras Helena
			 					
*********************************************** */

/* inclusion de archivos */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <GenFA.h>
#include <predefs.h>
#include <New_Interfact.h>
#include <unistd.h>

/* Definicion de contantes */
#define   MAXCLIENTES 	1000
#define   MAXPAGOS  	1000
#define   iLOGNIVEL_DEF  3

/* ITEMS de FAT_BALANCE */
#define   iBALANCE_ANTERIOR 1
#define   iPAGOS_RECIBIDOS  2 
#define   iPAGOS_REVERTIDOS 3 
#define   iAJUSTE_CREDITO   4
#define   iMISCELANEA       5
#define   iCARGOS_MES       6
#define   iTOTAL_FACTURA    7
#define   iTOTAL_PAGAR      8

#define   FACTCICLAFEC 2

/* Definicion de estructuras */
typedef struct FACICLOFACT
{
    char szhFecDesdeLLam[15];
    char szhFecHastaLLam[15];
    int  iCodCiclo;
	
}REG_FACICLOFACT;

typedef struct COPAGOS
{
    int 	ihCodItem;
    int		ihCodDocum;
    double	fhImpPago;
    int 	iContDocum;
}REG_COBROS;

typedef struct LINEACOMANDO
{
    char    szUser       [50];
    char    szUsuario    [63];
    char    szPass       [50];
    char    szDirLogs  [1024];       /*  Directorio de Archivos Log's y Err      */
    int     iCodCiclFact;
    long    lCodClienteIni;
    long    lCodClienteFin;
    int     iNivLog;
    int     iExisteRango;
   
}CARGABALANCELINEACOMANDO;

/* Declaracion de variables y estructuras globales */

int 		iContInsert;
int			iContLeidos = 0;
int			iContTotal  = 0;
BOOL		bIndPrimera = TRUE;
char		szFecUltFact[15];		
char		szFecActual[15];	

CARGABALANCELINEACOMANDO  stLineaComando;
REG_FACICLOFACT	sthFaCicloFact;
REG_COBROS		sthCoPagos 	    [MAXPAGOS];
REG_COBROS		sthBalDocum 	[MAXPAGOS];
REG_COBROS		sthCoAjustes    [MAXPAGOS];


/* Definicion de prototipos de funciones */

int ifnAbreArchivosLog	(void);
int ifnInsertaFatBalance(long lCod_Cliente
			,int iCod_Item
			,int iCod_Docum
			,int iCod_CiclFact
			,int iCant_Docum
			,double fImp_Docum);
BOOL bCargaCoPagos	(long lCodCliente, char *szFecHasta, int *iIndBalance);
BOOL bCargaBalanceDocu (long lCodCliente, char *szFecHasta, int *iIndBalance);
BOOL bCargaCoAjustes  (long lCodCliente, char *szFecHasta, int *iIndBalance);

BOOL bUpdateCoPagos(long lCodCliente, char *szFecHasta);
BOOL bUpdateBalanceDocu(long lCodCliente, char *szFecHasta, int iIndBalance);
BOOL bUpdateCoAjustes(long lCodCliente, char *szFecHasta);

BOOL bObtieneFechasCiclo(int iCodCiclFact);
BOOL bProcesaClientes (const char *szpHostId, int iExisteHostId);
BOOL bCargaItemesCero	(long lCodCliente, int iCodItem, int iCodTipDocum);
BOOL bCargaBalanceAnterior(long lCodCliente);

BOOL iUpdateIndBalance( char *szRowid, int iIndBalance);


BOOL bfnWrapperValidaTrazaProc(long lCodCiclFact,int iCodProceso, int iIndFacturacion);
BOOL bfnWrapperSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza);
BOOL bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza);


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

