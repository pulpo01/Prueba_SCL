/* ============================================================================= */
/*
    Tipo        :  APLICACION DE APOYO

    Nombre      :  regucola.h

    Descripcion :  Header para correccion.pc

    Autor       :  Roy Barrera Richards
    Fecha       :  21 - Agosto - 2000
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>     /* Inclusion de tipos generales de cobranza         */
#include <CO_oracle.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

#undef SQLNOTFOUND
#define SQLNOTFOUND 1403

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros();
int ifnConexionDB();
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog();
void vfnCierraArchivoLog();


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

