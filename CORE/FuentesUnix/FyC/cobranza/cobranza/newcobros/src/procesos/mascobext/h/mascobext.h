/* ============================================================================= */
/*
    Tipo        :  COLA DE PROCESO

    Nombre      :  mascobext.h

    Descripcion :  Header para mascobext.pc
    
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
#define SQLNOTFOUND 1403  /*  100:Ansi    1403:Oracle */


#define ARRAY_DOCS       10000
#define ARRAY_AUX        10000
#define HOSTARRAY_MOVTOS 30000

typedef struct MOVTOS_CLIENTES
{
    char szNumIdent    [HOSTARRAY_MOVTOS][12];
    char szCodTipIdent [HOSTARRAY_MOVTOS][3];
    char szRutSantiago [HOSTARRAY_MOVTOS][2]; 
    char szCodEntidad  [HOSTARRAY_MOVTOS][6]; 
}td_Movtos_Clientes ;

typedef struct MASTER_CLIENTES
{
    char szNumIdent    [12];
    char szCodTipIdent [3];
    char szRutSantiago [2]; 
    char szCodEntidad  [6]; 
}td_Master_Clientes ;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros();
int ifnConexionDB();
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog();
void vfnCierraArchivoLog();
int ifnEjecutaProceso();
int ifnMasCobExt();
int ifnProcesaClienteSM();


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

