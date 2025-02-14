/* ============================================================================= */
/*  Tipo        :  COLA DE PROCESO
    Nombre      :  saldocons.h
    Descripcion :  Header para saldocons.pc
    Autor       :  GAC
    Fecha       :  09-Diciembre-2003
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
#define SQLNOTFOUND 1403 /*  100:Ansi    1403:Oracle */

/*===========================================================================================
						Definiciones de Uso general
===========================================================================================*/	
#define   szVERSION			"6.0.0"	   /* Nueva version para TMG-TMS*/

#define 	 iLOGNIVEL_DEF     3       	/* Define el nivel de Log por Defecto */
#define   MAX_REG         	 30000
 	
/* #Defines para variables bind */
#define SALCO              "SALCO"
#define W                  "W"
#define CO_CARTERA         "CO_CARTERA"
#define COD_TIPDOCUM       "COD_TIPDOCUM"


/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnConexionDB(LINEACOMANDO *pstLC);
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog(int iCrearDir);
void vfnCierraArchivoLog(void);
int ifnEjecutaCola(void);
int ifnSaldoCliente();
int ifnDeleteSaldosCons();
int ifnUpdateSaldoNoven();

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
