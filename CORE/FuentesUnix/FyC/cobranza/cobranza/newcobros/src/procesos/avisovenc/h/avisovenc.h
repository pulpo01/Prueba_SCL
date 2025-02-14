/* ============================================================================================= 
    Tipo        :  COLA DE PROCESO
    Nombre      :  avisovenc.h
    Descripcion :  Header para avisovenc.pc    
    Autor       :  Modesto Aranda Contreras
    Fecha       :  10 - Diciembre - 2002
	Version     : Cuzco
   ============================================================================================= */

#include <CO_deftypes.h>      /* Incluye de tipos generales de cobranza                */
#include <CO_oracle.h>        /* Incluye funciones, codigos y punteros de Base de datos*/
#include <CO_stPtoRut.h>      /* Incluye estructuras de gestion de cobranza            */
#include <Acciones.h>         /* Incluye definiciones de funciones, codigos y punteros */
#include <CO_libacciones.h>   /* Incluye nueva libreria general de acciones            */
#include <CO_libgenerales.h>  /* Incluye nueva libreria general                        */
#include <CO_libprocesos.h>   /* Incluye nueva libreria general de procesos            */

#define SIZE_HOSTARRAYACCIONES 	100		/* # Acciones en cada Cursor */
#define HOSTARRAY_CLIENT       	20000	   /* # Clientes en cada Cursor */
#define ARRAY_CLIENT       		400000	/* # Clientes en cada Cursor */
#define ACCIONMENSAJERIA		   "MENSJ"  /* # Codigo de Accion de Mensajeria */
#define szVERSION			         "5.0.0"	/* Nueva version para RAN*/
#define iLOGNIVEL_DEF	         3			/* Define el nivel de Log por Defecto 				*/

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
	long	lCodCliente  [HOSTARRAY_CLIENT];
}td_hCliente ;

typedef struct TCLIENTE
{
	long	lCodCliente;
}td_Cliente ;

typedef struct ACCION_APLICABLE
{
	char	szCodRutina[SIZE_HOSTARRAYACCIONES][6];
}td_AccionesAplicables;


/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int  ifnValidaParametros();
int  ifnConexionDB();
int  ifnPreparaArchivoLog();
int  ifnAbreArchivoLog();
void vfnCierraArchivoLog();
int  ifnEvaluaCola();
int  ifnProcesoEvaluador();
int  ifnGeneraMorosos();
int  ifnCargaCriterios();
int  ifnEvaluaCliente();
BOOL bfnInsertaCoMensajes();
int  ifnDiaProc();
void vfnFechasCicl();
int  ifnEjecutaAccion ( );
int  Inicializar_lista(stLista *list);
int  Insertar_orden (stLista ant, struct stCliente e);
void Destruir_lista(stLista *list);
void vfnBorraListaCrit(lista_Crit *list);

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

