/***************************************************************************/
/* Definicion de constantes, tipos y estructuras necesarias para utilizar  */
/* las rutinas que manejan las tablas de trazas de facturacion de ciclo.   */
/*                                                                         */
/* Por William Sepulveda V.                                                */
/*-------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                */
/* Miercoles 17 de mayo del 2000.                                          */
/***************************************************************************/

#include <strings.h>
#ifndef _CHECKTRAZA_H_
#define _CHECKTRAZA_H_

/*-------------------------------------------------------------------------*/
/* Definiciones basicas de constantes.                                     */
/*-------------------------------------------------------------------------*/
#define SQLOK				  0
#define SQLNOTFOUND		1403			/* ANSI */
#define MAX_PRECEDENTES	 30
#define RET_OK				  0
#define FAILURE			 -1

/*-------------------------------------------------------------------------*/
/* Definicion de constantes para los codigos de proceso usados en la tabla */
/* de trazas de facturacion de ciclo, FA_TRAZAPROC.                        */
/*-------------------------------------------------------------------------*/
#define iPROC_PREANOMALIAS      1000        /* Pre-Anomalias                         */
#define iPROC_PREFACTURACION    2000        /* Pre-Facturacion                       */
#define iPROC_FACTURACION       3000        /* Facturacion de Ciclo                  */
#define iPROC_LOADTARIF         4000        /* Carga de trafico en PF_TARIFICADAS    */
#define iPROC_GENCUOTAS         4100        /* Generacion de Cuotas para Ciclo       */
#define iPROC_IMPRESION         5000        /* Impresion de Facturas / Boletas       */
#define iPROC_IMPDETALLE        5100        /* Impresion de Resumenes                */
#define iPROC_IMPDETLLAM        5200        /* Impresion de Detalle Llamadas         */
#define iPROC_FOLIACION         6000        /* Foliacion de Facturas                 */
#define iPROC_PASOHISTO         7000        /* Paso Historico de Trafico y Conceptos */
#define iPROC_CIERREFACT        8000        /* Cierre de Ciclo de Facturacion        */
#define iPROC_PASOCOBROS        9000        /* Paso a Cobros de Factutas             */
#define iPROC_HISTCUOTAS        9010        /* Paso a historicos de Cuotas           */
#define iPROC_PASOHISTO_FACT    9100        /* Paso Historico de Facturas            */

/*-------------------------------------------------------------------------*/
/* Definicion de constantes para los codigos de estado de termino de       */
/* procesos usados en la tabla FA_TRAZAPROC.                               */
/*-------------------------------------------------------------------------*/
#define iPROC_EST_RUN           1       /* Procesando            */
#define iPROC_EST_ERR           2       /* Terminado con error   */
#define iPROC_EST_OK            3       /* Terminado OK          */

/*-------------------------------------------------------------------------*/
/* Definicion de constantes para los codigos de error de las distintas     */
/* rutinas usadas para manejar la traza de facturacion.                    */
/*-------------------------------------------------------------------------*/
#define FAIL_GETIND_REPROCESO		-2
#define FAIL_GETPROC_PREC			-3
#define FAIL_GETESTADO_PROC		-4
#define FAIL_VALIDA_ESTPROC		-5
#define FAIL_INSERT_TRAZAPROC		-6
#define FAIL_PROC_EJECUCION		-7
#define FAIL_PROC_REPROCESO		-8
#define FAIL_DELETE_TRAZAPROC		-9

/*-------------------------------------------------------------------------*/
/* Definicion de constante para indicar posibilidad de reprocesos.         */
/*-------------------------------------------------------------------------*/
#define IND_REPROCESO		1


/*-------------------------------------------------------------------------*/
/* Estructura para representacion de tabla FA_TRAZAPROC.                   */
/*-------------------------------------------------------------------------*/
typedef struct REG_FA_TRAZAPROC
{
	int  	iCodCiclFact;
	int		iCodProceso;
	int		iCodEstaProc;
	char 	szFecInicio[15];
	char 	szFecTermino[15];
	char 	szGlsProceso[51];
	int 	iCodCliente;
	int 	iNumAbonado;
	int		iNumRegistros;
}rg_trazaproc;


#undef access

#ifdef _CHECKTRAZA_PC_
#define access
#else
#define access extern
#endif  /* _CHECKTRAZA_PC_ */


/*-------------------------------------------------------------------------*/
/* Definicion de prototipos de funciones locales de checktraza.            */
/*-------------------------------------------------------------------------*/
access  int		iGetIndReproceso (int, int *)      ;
access  int		iGetProcPrecedentes (int)          ;
access  int		iGetEstadoProc (int, int, int *)   ;
access  int		iInsertTrazaProc ( void )          ;
access  int		iValidaTrazaProc (int *)           ;
access  int		iDeleteTrazaProc (int, int)        ;
access  int		iUpdateTrazaProc ()                ;
access  int		iGetTrazaProc (int, int)           ;

/*-------------------------------------------------------------------------*/
/* Definicion de variables globales, que podrian ser usadas por otros      */
/* modulos.                                                                */
/*-------------------------------------------------------------------------*/
access rg_trazaproc	stTrazaProcCheck;

#undef access
#endif  /* _CHECKTRAZA_H_ */                                        


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

