/*===================================================================================
   Nombre      :  ejecutor.h
   Descripcion :  Header para ejecutor.pc
   Autor       :  Roy Barrera Richards
   Fecha       :  09 - Agosto - 2000
===================================================================================== */
#include <CO_deftypes.h>      /* Incluye de tipos generales de cobranza                */
#include <CO_oracle.h>        /* Incluye funciones, codigos y punteros de Base de datos*/
#include <CO_stPtoRut.h>      /* Incluye estructuras de gestion de cobranza            */
#include <Acciones.h>         /* Incluye definiciones de funciones, codigos y punteros */
#include <CO_libgenerales.h>  /* Incluye nueva libreria general                        */
#include <CO_libprocesos.h>   /* Incluye nueva libreria general de procesos            */
#include <CO_libacciones.h>   /* Incluye nueva libreria general de acciones            */

#define  SIZE_HOSTARRAYREV     20
/*#define  szVERSION			   "6.0.0" * Nueva version para TMG-TMS */
/*#define szVERSION 	           "6.0.1" * Incidencia 116617 - 18.12.2009 - TMG-TMS */
#define szVERSION		       "6.0.2" /* Incidencia 125767 - 12.03.2010 - TMG-TMS */

#define	iLOGNIVEL_DEF		   3	/* Define el nivel de Log por Defecto */
#define	MAX_CLIES			1000
#define	MAX_ACC				 100
#define	MAX_INSTANCIAS		  11
/* ============================================================================= */
/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
/* ============================================================================= */
#ifdef SQLNOTFOUND
	#undef SQLNOTFOUND
#endif
#define  SQLNOTFOUND    1403


typedef struct ACCION_REVERSA
{
    char szCodRutina[SIZE_HOSTARRAYREV][6];
}td_Acciones;

/* ============================================================================= */
/* Estructura general para instancias                                            */
/* ============================================================================= */
typedef struct PARAMETERS
{ 
	BOOL bDisponibilidad;
	sql_context *CtxInsBas;
	int idThread;
	Lista_Clie pListaCli;
	char szUserOracle[32];
	char szPassOracle[32];
	long lIdInstancia;
	long lCorrInstancia;
} PARAMETROS;



/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int  ifnValidaParametros();
int  ifnConexionDB();
int  ifnPreparaArchivoLog();
int  ifnAbreArchivoLog();
void vfnCierraArchivoLog();
int  ifnEjecutaCola();
int  ifnEjecutor();
int  ifnGatillaHilos( PARAMETROS pstParametros, long *lIdInstanciaLanzada );
void *vProcesaAccionesCliente( void *pstParam );
BOOL bfnEsAccionReversa( FILE **ptArchLog, td_Acciones *stAccionesRev, char *szhCodAcc, sql_context ctxCont );
BOOL bfnCargaAccionesReversas( td_Acciones *stAccionesRev );
int  ifnValInstancias();
int  ifnUsuarioParam();
int  ifnMemoriaUsada();
int  ifnInsertaParamUnix();
int  ifnInsertaClie( Lista_Clie *ant );
void vfnBorraListaClie( Lista_Clie *list );
int  ifnInsertaClieHilo( Lista_Hilo *ant );
int  ifnRegistraClientesHilo( int iIDHilo, Lista_Clie pListaClie );
int  ifnEliminaClientesHilo( int iIDHilo );
BOOL bfnGetSaldoVencidoCXX(FILE **ptArchLog, long lCodCliente, double *pdSaldoVenc, sql_context ctxCont  );

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

