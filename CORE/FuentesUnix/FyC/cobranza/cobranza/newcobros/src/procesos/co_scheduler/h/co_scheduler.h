/* ============================================================================= */
/*
    Tipo        :  LANZADOR DE COLAS DE PROCESO

    Nombre      :  co_scheduler.h

    Descripcion :  Header para co_scheduler.pc
    
    Autor       :  Roy Barrera Richards
    Fecha       :  09 - Agosto - 2000
*/ 
/* ============================================================================= */

/* ============================================================================= */
/* inclusion de archivos                                                         */
/* ============================================================================= */
#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */


#ifdef SQLNOTFOUND
	#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403
#define szVERSION			"6.0.0"		/* Nueva version para TMG-TMS*/
/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */

char *szDateOra(char *szFmtoOracle);
int	 ifnValidaParametros();
int ifnConexionDB( LINEACOMANDO *pstLC );
int  ifnPreparaArchivoLog();
int  ifnAbreArchivoLog();
void vfnCierraArchivoLog();
int  ifnRunCOScheduler();
int  ifnEstadoScheduler();
BOOL bfnEjecucionActual();
int  ifnCargaColasDeProceso();
int  ifnActivaColas();
int  ifnCOScheduler();
long lfnLeePID();


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

