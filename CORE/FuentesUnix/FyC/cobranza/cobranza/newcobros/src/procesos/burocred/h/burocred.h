/* ============================================================================= */
/*
    Tipo        :  COLA DE PROCESO

    Nombre      :  evaluador.h

    Descripcion :  Header para evaluador.pc
    
    Autor       :  Roy Barrera Richards
    Fecha       :  09 - Agosto - 2000
*/ 
/* ============================================================================= */

#include <CO_deftypes.h>    /* Inclusion de tipos generales de cobranza   		*/
#include <CO_oracle.h>
#include <CO_stPtoRut.h>
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

#define SIZE_HOSTARRAYACCIONES 	100		/* # Acciones en cada Cursor */
#define HOSTARRAY_CLIENT       	30000	/* # Clientes en cada Cursor */
#define ARRAY_CLIENT            10000
#define ACCIONMENSAJERIA		"MENSJ" /* # Codigo de Accion de Mensajeria */

#define szVERSION			"5.0.0"		/* Nueva version para RAN*/

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
	#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403

/* ============================================================================= */
/* estructuras de datos para los host arrays                                     */
/* ============================================================================= */
typedef struct CLIENTE
{
	long	lCodCliente    [HOSTARRAY_CLIENT];
	double  dSaldoClie     [HOSTARRAY_CLIENT];
	double  dSaldoVenc 	   [HOSTARRAY_CLIENT];
	char    szNombre       [HOSTARRAY_CLIENT][200];
	char    szNumIdent     [HOSTARRAY_CLIENT][iLENNUMIDENT];
	long    lCuenta        [HOSTARRAY_CLIENT];
	char    szFecUltPago   [HOSTARRAY_CLIENT][9];
	double  dMonUltPago    [HOSTARRAY_CLIENT];
	char    szDirClie	   [HOSTARRAY_CLIENT][250];
	char    szCajon        [HOSTARRAY_CLIENT][1000];
}td_hCliente ;

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int  ifnValidaParametros();
int  ifnConexionDB();
int  ifnPreparaArchivoLog();
int  ifnAbreArchivoLog();
void  vfnCierraArchivoLog();
int  ifnEvaluaCola();
int  ifnProcesoEvaluador();









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

