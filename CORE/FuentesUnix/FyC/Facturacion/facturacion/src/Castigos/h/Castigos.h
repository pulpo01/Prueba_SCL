/* ***********************************************
		  "Castigos.h"
		  Diciembre, 20, 2001
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

#define szVERSION         "v.1.0.0"	/* RA-200511080074 Soporte RyC 18-11-2005 capc */
#define   MAXROWS	50
#define   iLOGNIVEL_DEF  3

typedef struct REG_FA_CASTIGOS
{
	long	lCodCuenta;
	long	lCodCliente;
	long	lTipoDoc;
	long	lFolioDoc;
	int	iFecEmi	;
	double	lDebe	;  /* RA-200511080074 Soporte RyC 18-11-2005 capc */
	double  lHaber	;  /* RA-200511080074 Soporte RyC 18-11-2005 capc */
	double  lSaldo  ;  /* RA-200511080074 Soporte RyC 18-11-2005 capc */
	double	lMonto	;  /* RA-200511080074 Soporte RyC 18-11-2005 capc */
}reg_fa_castigo;

typedef struct REG_INSERT_CO_CARTERA
{
	
	long	lCodCliente	[MAXROWS];
	int     iTipDoc         [MAXROWS];
	long	lNumSec		[MAXROWS];
	long	lCodVendedor	[MAXROWS];
	char	szLetra		[MAXROWS][2];
	long	lCodCentremi	[MAXROWS];
	int	iColumna	[MAXROWS];
	long	lCodProducto	[MAXROWS];
	double	lHaber		[MAXROWS]; 	/* RA-200511080074 Soporte RyC 18-11-2005 capc */
	int	iIndContado	[MAXROWS];
	long	iIndFacturado	[MAXROWS];
	char	szFecVencimiento[MAXROWS][15];
	char	szFecCaducida	[MAXROWS][15];
	char	szFecAntiguedad	[MAXROWS][15];
	long	lNumAbonado	[MAXROWS];
	long	lNumFolio	[MAXROWS];
	char	szFecPago	[MAXROWS][15];
	long	lNumCuota	[MAXROWS];
	long	lSecCuota	[MAXROWS];
	long	lNumTrx		[MAXROWS];
	long	lNumVenta	[MAXROWS];
	char	szFolioCtc	[MAXROWS][12];
	char	szCodOperadoraScl	[MAXROWS][6];	/* RA-200511080074 Soporte RyC 18-11-2005 capc */
	char	szCodPlaza		[MAXROWS][6];		/* RA-200511080074 Soporte RyC 18-11-2005 capc */
	char	szPrefPlaza		[MAXROWS][11];		/* RA-200511080074 Soporte RyC 18-11-2005 capc */
	
}reg_co_cartera;


typedef struct LINEACOMANDO
{
    char    szUser       [50];
    char    szUsuario    [63];
    char    szPass       [50];
    char    szDirLogs  [1024];       /*  Directorio de Archivos Log's y Err      */
    int     iNivLog;  	
}CASTIGOSLINEACOMANDO;


CASTIGOSLINEACOMANDO stLineaComando;

reg_fa_castigo       sthFaCastigo;
reg_co_cartera	     sthCoCartera;


int bProcesaCuenta();
int bCastigaCuenta(long );
int bRechazaCuenta(long,int );
int ifnAbreArchivosLog();
int bProcesaCastigos();
int VerificaCtaCte(reg_fa_castigo sthFaCastigo);
  



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

