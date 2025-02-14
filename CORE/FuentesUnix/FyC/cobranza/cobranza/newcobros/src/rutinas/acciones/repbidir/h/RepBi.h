/* ============================================================================= */
/*
    Tipo        :  ACCION

    Nombre      :  Repone.h

    Descripcion :  Header de Repone.pc

    Autor       :  Roy Barrera Richards           
    Fecha       :  10 - Agosto - 2000 
*/ 
/* ============================================================================= */
#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza       */
#include <CO_libgenerales.h> /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CO_libacciones.h"  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
/* ============================================================================= */

#define  szCODRUTINA	 "REPBI"
#define  CAUSABAJA	 "90"
#define  BAJABONADO   "BAA"
/*#define  szVersion "2.0.0"   *Nueva version para RAN*/
/*#define  szVersion "2.0.1"	* Soporte RyC RA-200512190339 07-02-2006 capc */
/*#define  szVersion "2.0.2"	* Requerimiento de Soporte - #34615 05-10-2006 capc */
/*#define  szVersion "2.0.3"	* Requerimiento de Soporte - #43432 28-08-2007 capc */
#define  szVersion "2.0.4"	/* Requerimiento de Soporte - #69015 08-08-2008 mgg */

int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...);

/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

