/*============================================================================= 
   Tipo        : Libreria propia de archcobman.pc
   Nombre      : archcobman.h
   Autor       : Manuel Garcia G
   Fecha       : Enero 2003.
   *******************************************
   Modificado  : 01-04-2004 Proyecto TMM-03069
   A/P			: GAC
============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403  

#define szVERSION			 "5.0.0"		/* Nueva version para RAN*/
#define szCODPROCESO		 "ARMAN"		/* Define codigo por defecto de la cola */
#define szNOMARCHIVO		 "COBEX"		/* Define nombre de archivos de cobranza */

#define iLOGNIVELDEFAULT	3			/* Define el nivel de Log por Defecto */
#define OK						0
#define ERROR					-1
#define FATAL					-2
#define COLASTOP				1

#define MAXCLIEHOST    		25000
#define MAXCLIE				200000
#define HOSTARRAY_DETALLES  25000

#define BAJA				"B"
#define REASIGNADO		"R"
#define MODIFICADO		"M"
#define ALTA				"A"
#define SI					"S"

/*DEFINICION DE VALORES PARA VARIABLES BIND  */
#define NOM_TABLA       "CO_ENTCOB"
#define NOM_COLUMNA     "COD_ENTIDAD"
#define COD_MODULO      "CO"
#define VALOR_NULL      "NULL"
#define SIN_ENTIDADES   "SIN ENTIDADES"
#define MOVTO_SM   		"SM"
#define INFORMA_N			"N"
#define UNIVERSO_INF    "UNIVERSO_INFORMAR"
#define ESTADO_PND      "PND"
#define ESTADO_EPR      "EPR"
#define ESTADO_EJE      "EJE"
#define LETRA_C			"C"

typedef struct DatosGen
{
	  char szEntGestion[21];
	   int iCntDoctosCli;
	   int iCntDoctosNoCli;
	  char szDoctosInformar[21];
	  char szRefreshInformar[21];
	  char szIndFacturado[21];
	   int iCntConceptosDef;
	  char szBorrarCastCont[21]; 
} DATOSGEN;

typedef struct hClientesCob
{
	  char szNumIdent		 [MAXCLIEHOST][iLENNUMIDENT];
	  char szCodTipIdent	 [MAXCLIEHOST] [3];
	  long lCodCliente	 [MAXCLIEHOST]    ;
	  char szCodEntidad	 [MAXCLIEHOST] [6];
	  long lCodCuenta		 [MAXCLIEHOST]    ;
	  char szCodMovimiento[MAXCLIEHOST] [6];
	  char szCodEnvio		 [MAXCLIEHOST] [3];
	  char szRowid			 [MAXCLIEHOST][19];
	  char szTipEntidad	 [MAXCLIEHOST] [2];
	double dMtoEnvioAnt	 [MAXCLIEHOST]    ;
	  long lNumProceso	 [MAXCLIEHOST]    ;
} HCLIENTESCOB;

typedef struct ClientesCob
{
	  char szNumIdent		 [iLENNUMIDENT];
	  char szCodTipIdent	 [3];
	  long lCodCliente		 ;
	  char szCodEntidad	 [6];
	  long lCodCuenta			 ;
	  char szCodMovimiento[6];
	  char szCodEnvio		 [3];
	  char szRowid			[19];
	  char szTipEntidad	 [2];
	  double dMtoEnvioAnt	 ;
	  long lNumProceso		 ;
} CLIENTESCOB;

typedef	struct RG_CODETARCH
{
	char szCodEntidad	[HOSTARRAY_DETALLES][6];	/* N VARCHAR2	6	 */
	char szTxtReg		[HOSTARRAY_DETALLES][1025];	/* N VARCHAR2	1024 */
}rg_codetarch;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnConexionDB( LINEACOMANDO *pstLC );
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog( int iCrearDir );
void vfnCierraArchivoLog(void);
int ifnEjecutaCola( void );
int ifnArchManuales( char *szDescError );
BOOL bfnGetDatosGenerales();
int ifnCreaDetalleDocumentos(char *szpUniverso);
int ifnCreaArchivos();
BOOL bfnBorraCoDetArchivos();
int ifnTraspasaHistoricoCobranza();
int ifnGeneraUniversoFiltros();
int ifnUpdateaFiltros(char *szpNvoEstado, char *szpEmpresa, char *szpFec_Ingreso, char *szpEstado);

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
