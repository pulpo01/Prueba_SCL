/* ============================================================================= */
/*
    Tipo        :  COLA DE PROCESO

    Nombre      :  cobexterna.h

    Descripcion :  Header para cobexterna.pc
    
    Autor       :  Roy Barrera Richards
    Fecha       :  09 - Agosto - 2000
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403	/*  100:Ansi    1403:Oracle */

#define szVERSION			"5.0.0"		/* Nueva version para RAN*/

#define iLOGNIVELDEFAULT	3			/* Define el nivel de Log por Defecto */
#define szCODPROCESO		"NOCLI"		/* Define codigo por defecto de la cola */
#define OK					0
#define ERROR				-1

#define MAXPROCESO          100 
#define MAXRUTHOST			10000 
#define MAXRUT				300000 
#define MAXENTDEST			100
#define MAXDOCTOS			100

#define CODTIPNOCLI			"N"

typedef struct hGenEntDest
{
	char szEntidadDestino[6];
	 int iPorcentaje;
	long lNumClientesAsignados;
} DATENTDEST;

typedef struct GenDatosProceso
{
	  long lNumProceso;
	  char szCodEstado[6];
	  char szTipOrigen[2];
	double dMontoDesde;
	double dMontoHasta;
	  long lFechaDesde;
	  long lFechaHasta;
	  char szFiltroCategoria[1001];
	  long lTotalProcesados;	
	  long lCumplenCriterios;	
	   int iCntEntDest;
	DATENTDEST stDatEntDestino[MAXENTDEST];
} DATOSPROCESO;

typedef struct hGenDatosProceso
{
	  long lNumProceso[MAXPROCESO];
	  char szCodEstado[MAXPROCESO][6];
	  char szTipOrigen[MAXPROCESO][2];
	double dMontoDesde[MAXPROCESO];
	double dMontoHasta[MAXPROCESO];
	  long lFechaDesde[MAXPROCESO];
	  long lFechaHasta[MAXPROCESO];
} HDATOSPROCESO;

typedef struct hGenDatosRut
{
	  char szNumIdent[MAXRUTHOST][iLENNUMIDENT];
	  char szTipIdent[MAXRUTHOST][3];
	  long lCuentaoCliente[MAXRUTHOST];
	  char szCodEntidad[MAXRUTHOST][6];
	double dMontoDeuda[MAXRUTHOST];
	  long lFechaVencimie[MAXRUTHOST];
	  char szRowid[MAXRUTHOST][19];
} HDATOSRUT;

typedef struct GenDatosRut
{
	  char szNumIdent[iLENNUMIDENT];
	  char szTipIdent[3];
	  long lCuentaoCliente;
	  char szCodEntidadOrigen[6];
	  char szCodEntidadDestino[6];
	double dMontoDeuda;	  
	  long lFechaVencimie;
	   int iCumpleCriterios;
	  char szRowid[19];
	  char szCodRechazo[6]; 
} DATOSRUT;

typedef struct GenDoctosNCli
{
	  char iCodTipDocum;
} DOCTOSNCLI;

int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnConexionDB( LINEACOMANDO *pstLC );
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog( int iCrearDir );
void vfnCierraArchivoLog(void);
int ifnEjecutaCola( void );
int ifnNoClientes( char *szDescError );
BOOL bfnCntDoctosNoCli( int *iTotalRowsLeidas );
int ifnVerifDoctosNoCli( long lCodCuenta );
BOOL bfnGetDatosProcesos( int *iTotalRowsLeidas );
int ifnValidaSituacionAbonadosCuenta( long lCodCuenta, char *szOperador,  char *szCodSituacion );
BOOL bfnCambiaEstadoProceso( long lNumProceso, char *szCodEstado );
BOOL bfnCambiaUniversoProceso( long lNumProceso, long lCntUniverso );
BOOL bfnAsignaPorcentajes( int iIndProc );
BOOL bfnUpdateEstadoCobExterna( int iIndProc );
BOOL bfnInsertaProcesadosCobExterna( int iIndProc );


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

