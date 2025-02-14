/* ============================================================================= */
/*
    Tipo        :  CABECERA.

    Nombre      :  oratrer.h.

    Descripcion :  cabecera oratrer.pc.
    
    Autor       :  Manuel Garcia G.
    Fecha       :  Agosto 2001.
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>    /* Inclusion de tipos generales de cobranza   		*/
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

#define szVERSION			"5.0.0"	/* Nueva version para RAN*/
										
#define iLOGNIVEL_DEF	     3	/* Define el nivel de Log por Defecto */
#define SIZE_HATRER		 10000	/* Dimension Host Array */
#define SIZE_ATRER		900000	/* Dimension Array de Trabajo */
#define SIZE_HABON		   200 	/* Dimension Host Array */

#define RUT_NATURAL	  50000000 	/* Dimension Host Array */

#ifdef SQLNOTFOUND
	#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403

typedef	struct Atrer
{
	char	szNumIdent[iLENNUMIDENT];
	char	szNumIdentAux[iLENNUMIDENT];
	char	szCodTipIdent[3];
	char	szTipEnvio[2];
	char	szCntFacturas[11];
	int		iCntFacturas;
	double	dMontoDeuda;
	char	szTipDeuda[2];
	char	szFecVencimie[9];
	char	szFecBajaCliente[9];
	long	lFecBajaCliente;
	char	szOrigen[2];
	char	szTipoCliente[2];
} reg_Atrer;

typedef struct hAtrer
{
	char	szNumIdent[SIZE_HATRER][iLENNUMIDENT];
	char	szNumIdentAux[SIZE_HATRER][iLENNUMIDENT];
	char	szCodTipIdent[SIZE_HATRER][3];
	char	szOrigen[SIZE_HATRER][2];
	double  dMontoDeuda[SIZE_HATRER];
} reg_hAtrer;

typedef struct hAbonados
{
	char szCodSituacion[SIZE_HABON][4];
	char szCodCausaBaja[SIZE_HABON][3];
	long lFechaBaja[SIZE_HABON];
	char szFecBaja[SIZE_HABON][9];
	 int iCodProducto[SIZE_HABON];
} reg_hAbonados;

int  ifnValidaParametros();
int  ifnConexionDB();
int  ifnPreparaArchivoLog();
int  ifnAbreArchivoLog();
void vfnCierraArchivoLog();
BOOL bfnEjecutaAtrer();
BOOL bfnDeleteErdAtrer();
BOOL bfnObtenerMorosos( long *lCntTotalRows );
BOOL bfnProcesarMorosos( long lTotalRows, long *lCntRows );
BOOL bfnRevisaAbonados( char *szNumIdent, char *szCodTipIdent, char *szCodSit, char *szTipEnv, long *lFechaBaja );
BOOL bfnBuscaSaldoRut( char *szNumIdent, char *szCodTipIdent, double *dDeuVenc, int *iCntFacturas, char *szFecVencimie );
BOOL bfnInsertaErdAtrer( long lTotalRows, char *szFechaHoy );
BOOL bfnCargaArchivo( long lTotalRows, char *szFechaHoy, char *szFechaHoyCorta );
BOOL bfnUpdateFaIntqueproc();


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

