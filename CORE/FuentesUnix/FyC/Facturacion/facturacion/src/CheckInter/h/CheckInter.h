#include <deftypes.h>
#include <GenFA.h>


/************************************************************************/
/*  Nivel de Log por Default                                            */
/************************************************************************/

#define     iLOGNIVEL_DEF               3

/***************************************************************************/
/*   Codigo de retorno función PL de foliación                             */
/***************************************************************************/
#define     cSEPARADOR_COMA ';'
#define     G_NESTADO_CONSUMIDO         2  /* Folio Consumido  */


/*********************************************
Estructura para recoger los datos por
la linea de comandos.
**********************************************/
typedef struct LineaComandoCheck
{
    char    szUsuarioOra [64] ;
    char    szOraAccount [32] ;
    char    szOraPasswd  [32] ;

     int    iNivLog         ;

    char    szDirLogs[1024] ;       /*  Directorio de Archivos Log's y Err */
}LINEACOMANDOCHECK;

/*****************************************************
Estructura para almacenar datos de facturas a Foliar
*****************************************************/
typedef struct tagRegInterfaz
{
	 int	iCodEstProc;
	long 	lNumProceso;
	long	lIndOrdenTotal;
	 int	iCodTipDocum;
	 int	iCodTipDocumAlm;
	/*char 	szPrefPlaza [4]; */ 	/* Comentado   por PGonzalez 15-03-2004 */
	char 	szPrefPlaza [11];	/* incorporado por PGonzalez 15-03-2004 */
	long 	lNumFolio;
	long	lCodVendedor;
	char	szCodOficina [3];
	int 	iCodModVenta;
	double 	dTotFactura;
}REGINTER ;

typedef struct tagInter
{
    int          iNumReg	;
    REGINTER     *stDocum   ;
}REGDOCUM;

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

LINEACOMANDOCHECK	stLineaComandoCheck;
REGDOCUM 		stRegDocum;

/************************************************************************/

#undef access

#ifdef _CHECKINTER_PC_
#define access
access BOOL bfnValidaParametros( int argc, char *argv[], LINEACOMANDOCHECK *pstLineaCom );
access BOOL bfnAbreArchivos(LINEACOMANDOCHECK *pstLineaCom, char *szDate);
access BOOL bfnRevisaInterfaz ( LINEACOMANDOCHECK *pstLineaCom );
access BOOL bfnCheck800 ( void );
access BOOL bfnCheck900 ( void );
access BOOL bfnCheck920 ( void );
access BOOL bfnCheck600 ( void );

access BOOL bfnOpenInterfaz(int iCodEstProc);
access int ifnFetchInterfaz(void);
access BOOL bfnCloseInterfaz();
access BOOL bfnValidaFolio(int i);
access BOOL bfnValidaOperadora(void);
access BOOL bfnDBPasarHistDetalle(long lIndOrdenTotal);
access BOOL bfnBorrarHistDetalle (long lIndOrdenTotal);
access void vfnInitCadenaInsertDetalle  ();
access void vfnInitCadenaDeleteDetalle  ();
access BOOL bfnDBPasarHistCliente       ();
access void vfnInitCadenaInsertCliente  ();
access void vfnInitCadenaDeleteCliente  ();
access BOOL bfnDBPasarHistAbonado       ();
access void vfnInitCadenaInsertAbonado  ();
access void vfnInitCadenaDeleteAbonado  ();
access BOOL bfnDBPasarHistFactura       ();
access void vfnInitCadenaInsertFactura  ();
access void vfnInitCadenaDeleteFactura  ();
access BOOL bfnPasHisValInd             ();
access BOOL bfnDBPasarHistInterfact		();
access void vfnInitCadenaInsertInterfaz	();
access void vfnInitCadenaDeleteInterfaz ();
access BOOL bfnDBPasarHistTecno(long lIndOrdenTotal);
access void vfnInitCadenaInsertTecno(char *szCadena);
access void vfnInitCadenaDeleteTecno (char *szCadena );
access BOOL bfnDBEliminarFactura(long lIndOrdenTotal);

#else
#define access extern
#endif

#undef access
#undef _CHECKINTER_PC_

static char szUsageCheck[]=
"\n\tUso: CheckInter Opciones"
"\n											 "
"\n\tOpciones:								 "
"\n											 "
"\n\t\t-u 'Usuario/Password' o '/' (Opcional)"
"\n\t\t-l  Nivel Log (Opcional)				 "
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

