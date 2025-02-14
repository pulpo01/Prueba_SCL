/* ============================================================================= */
/*
    Tipo        :  ACCION

    Nombre      :  NewMensCorta.h

    Descripcion :  Header de NewMensCorta.pc

    Autor       :  Modesto Aranda Contreras 
    Fecha       :  01 - Diciembre - 2002 
*/ 
/* ============================================================================= */
#include <CO_deftypes.h>       /* Inclusion de tipos generales de cobranza       */
#include <CO_libgenerales.h> /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CO_libacciones.h"  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
/*#define szVersion "2.0.0"   *Nueva version para RAN*/
#define szVersion "2.0.1"   /* Soporte RyC RA-200512190339 07-02-2006 capc */	

BOOL bfnSelectIdiomaClienteAviso( long lCodCliente, char *szCodIdioma);
BOOL bfnSelectDescripcionMensajeAviso( char *szCodMensaje, char *szCodIdioma, char *szpDescMensaje);

/* ============================================================================= */

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

