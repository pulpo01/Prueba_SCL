/*==================================================================================
   Nombre      : Co_EvalMO.h
   Programa    : Libreria de Co_EvalMO.pc
   Autor       : GAC
   Creado      : Diciembre 2003
==================================================================================*/
#include <CO_deftypes.h>	/* Inclusion de tipos generales de cobranza        */
#include <CO_oracle.h> 		/* Inclusion de definiciones para manejar oracle   */
#include <CO_libacciones.h>   /* Inclusion de nueva libreria general de procesos       */
#include <CO_libgenerales.h>  /* Inclusion de nueva libreria general                   */
#include <CO_libprocesos.h>   /* Inclusion de nueva libreria general de procesos       */

/* Re-definicion LOCAL de sqlnotfound: Valor del modo Oracle */
#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif
#define SQLNOTFOUND 1403			/*  100:Ansi    1403:Oracle */

/*#define szVERSION		"6.0.0"   / Nueva version por TMG-TMS */
#define szVERSION		"6.0.1"   /* Incidencia 149754 */

#define iLOGDEFAULT		3			/* Define el nivel de Log por Defecto */

#define iNUMLISTA	   10

#define ESCRIBIR		0
#define LEER			1

#define STATUS_OK		0
#define STATUS_ERR	   -1
#define STATUS_NFO	    1
#define BUFFER_SIZE	10000

/* #Defines para variables bind */
#define WAIT            "W"
#define VIGENTE         "V"
#define NULLXX          "XX"
#define NULLXXXXX       "XXXXX"
#define MOROS           "MOROS"
#define GE_CLIENTES     "GE_CLIENTES"
#define CATEGORIA       "COD_CATEGORIA"
#define ERR             "ERR"
#define PND             "PND"
#define EJE             "EJE"
#define CO              "CO"
#define USUARIO_COBROS  "USUARIO_COBROS"
#define LETRA_C         "C"
#define LETRA_E			"E"
#define MR              "MR"
#define FECHA20000101   "20000101"	
#define CO_CARTERA      "CO_CARTERA"
#define COD_TIPDOCUM    "COD_TIPDOCUM"
#define BAJA            "BAJA"  /* Requerimiento Soporte RyC. - 08.10.2007 - Ticket 44656 - COL */
#define BAA             "BAA"   /* Requerimiento Soporte RyC. - 08.10.2007 - Ticket 44656 - COL */

/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC );
int ifnConexionDB( LINEACOMANDO *pstLC );
int ifnPreparaArchivoLog();
int ifnAbreArchivoLog();
void vfnCierraArchivoLog(void);
int ifnEjecutaCola();
int ifnCargaLista(int iFilas) ;
int ifnSeccionaLista(int lTotalReg);
int ifnEjecutaHilos();
int ifnClientesMorosos();
int ifnNuevosMorosos();
int ifnGrabaDatosLista (stLista lstClientes);
int ifnInsertaCategoria(int x) ;
int ifnInsertaEstadisticas(int piSecuencia , char *pszProceso );
int ifnUpdateEstadisticas( char *pszProceso , int iTpoTotal , long lTotalReg, int iSecuencia);
int ifnInsertaParamUnix();
int ifnMemoriaUsada();
void *vfnEvaluaMO (void *x);
int  Leer_element (stLista list, long pos, struct stCliente *e);
void vfnEliminaNodoAccion(lstAccCM *list);
void vfnBorraListaCateg(lista_Categ *list);
int  Inicializar_lista(stLista *list);
int  Insertar_orden (stLista ant, struct stCliente e);
int Insertar_pos (stLista ant, struct stCliente e, long pos);
void Destruir_lista(stLista *list);
int ifnUpdateExcluidosAcciones(int cod_cliente);

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
