/* ============================================================================= 
    Nombre      :  Co_PagosConsolidados.h
    Descripcion :  Header para Co_PagosConsolidados.pc
     
   ============================================================================= */

#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza   		   */
#include <CO_oracle.h>
#include <CO_stPtoRut.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

#ifdef SQLNOTFOUND
	#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403
												    
/*===========================================================================================
						Definiciones de Uso general
 ===========================================================================================*/	
#define      szVERSION			"1.0.0"	        /* Version Inicial para TMG-TMS       */
#define	     iLOGNIVEL_DEF	    3		        /* Define el nivel de Log por Defecto */
#define      MORA               "M"             /* Tipo de gestion [M] MORA           */
#define      NULO               "NULO"
#define      MAX_ARRAY          100 	
#define      PAGCO              "PAGCO"

/* Status Archivos  */
typedef struct tagSTATUSARCH
{
char   NomArchPag[256];     /* Nombre del archivo de Pagos Consolidados      */
}STATUSARCH;

access STATUSARCH stStatusArch;

char szPipe       [] = "|";
FILE *ArchPag;

/* ============================================================================= */
/* estructuras de datos para los host arrays                                     */
/* ============================================================================= */
typedef struct ENTIDAD
{
   char   sCodAgente     [MAX_ARRAY] [6]; /* Codigo de Empresa Recaudadora                                */
   char   sDesAgente     [MAX_ARRAY][31]; /* Descripcion de Empresa Recaudadora                           */
   double dMonto         [MAX_ARRAY]    ; /* Monto utilizado de morosidad por la entidad                  */
} td_Entidad;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int   ifnValidaParametros();
void  vfnInicializacionParametros(void);
int   ifnConexionDB();
int   ifnAbreArchivoLog();
void  vfnCierraArchivoLog();
int   ifnEjecutaProceso();
int   ifnGeneraUniverso();
char* szGetEnv(char * VarHost);
int   ifnGeneraPagosEntidad(char *sEntidad);
int   ifnMontoPago(long lCodCliente, char *sRango1, char *sRango2);
int   ifnConsultaFechaTermino(long lCodCliente, char *sFecIngreso, char *sFecTermino, char *sCodEntidad);
int   ifnFecHistoricoMoroso(long lCodCliente, char *sFechaInicio, char *sFechaFinal, char *sFechaHistorico, char *sCodEntidad);
int   ifnFecMorosidad(long lCodCliente, char *sCodEntidad);
int   ifnGeneraArchivos();
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
