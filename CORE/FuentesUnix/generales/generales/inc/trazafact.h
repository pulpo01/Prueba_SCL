/*****************************************************************************/
/* Fichero     : trazafac.h                                                  */
/* Descripcion : Declaracion de tipos y funciones                            */
/* Autor       : Mauricio Villagra Villalobos                                */
/* Fecha       : 20-05-1999                                                  */
/*****************************************************************************/
#ifndef _TRAZAFACT_H_
#define _TRAZAFACT_H_

/********************************************************************************/
/* Definición de Constantes para Procesos de Facturacion                        */
/* Estados de los Procesos de Facturacion  FA_TRAZAPROC  COD_ESTADO             */
/* Estados de los Ciclo de la tabla FA_CICLFACT IND_FACTURACION                 */
/********************************************************************************/

/* Codigo de Proceso en Tabla de Procesos de Facturacion FA_TRAZAPROC           */

#define iPROC_PREFACT             900        /* Pre_Ciclo Facturacion                 */
#define iPROC_ANOMALIAS          1000        /* Deteccion de Anolamias                */
#define iPROC_TASACION           1500        /* tasaciones                            */
#define iPROC_FAMASCARA          2000        /* Generacion de Mascara de Facturacion  */
#define iPROC_CREATETABLE        2500        /* Creacion de Tables                    */
#define iPROC_BENEFICIO          2700        /* Generacion de Beneficios y Promocion  */
#define iPROC_FACTURACION        3000        /* Carga de Trafico de Ciclo             */
#define iPROC_BALANCE            3200        /* Carga de tablas Balance 13-05-2002    */
#define iPROC_DOBLECUENTA        3500        /* Proceso de Doble Cuenta               */
#define iPROC_LOADTARIF          4000        /* Facturacion de Ciclo                  */
#define iPROC_GENCUOTAS          4100        /* Generacion de Cuotas para Ciclo       */
#define iPROC_CARGAULTPAGO       4150        /* Carga de ultimos pagos                */
#define iPROC_CRITERIOS          4200        /* Criterios de Asignacion de Despacho   */
#define iPROC_MONTOMINIMOFACT    4300        /* Validación Monto Minimo Facturable    */
#define iPROC_ASIGNACIONCOURRIER 4500        /* Asignacion de Courrier de Despacho    */
#define iPROC_IMPRESION          5000        /* Impresion de Factura                  */
#define iPROC_IMPRESION_DETPAG   5100        /* Impresion de Detalle Pago             */
#define iPROC_IMPRESION_DETLLA   5200        /* Impresion de Detalle Llamadas         */
#define iPROC_POSTFACT           5800        /* Post_ciclo Facturacion                */
#define iPROC_FOLIACION          6000        /* Foliacion de Facturas                 */

#define iPROC_PASOHISTO          7000        /* Paso Historico de Trafico y Conceptos */
#define iPROC_ACTUALIZA_ESTAD    7500        /* registro de estadisticas de consumo   */
#define iPROC_CIERREFACT         8000        /* Cierre de Ciclo de Facturacion        */
#define iPROC_PASOCOBROS         9000        /* Paso a Cobros de Facturas             */
#define iPROC_HISTCUOTAS         9010        /* Actualización de Cuotas               */
#define iPROC_LIBROIVA           9020        /* Libro de Ventas                       */
#define iPROC_PASOHISTO_FACT     9100        /* Paso Historico de Facturas            */
#define iPROC_PASOCONSUMO_FACT   9300        /* Paso Consumo Ciclo Facturacion        */

/* Estados de Procesos de facturacion en Tabla  FA_TRAZAPROC                         */

#define iPROC_EST_RUN           1           /* Procesando                            */
#define iPROC_EST_ERR           2           /* Terminado con error                   */
#define iPROC_EST_OK            3           /* Terminado OK                          */


/* Estados de IND_FACTURACION de tabla FA_CICLFACT                                   */

#define iIND_FACT_NOPROCESADO   0           /* Ciclo NO Procesado                    */
#define iIND_FACT_ENPROCESO     1           /* Ciclo EN Proceso                      */
#define iIND_FACT_TERMINADO     2           /* Ciclo Terminado                       */

/* Control de error por inserción en TRAZA Procesos Concurrentes                     */

#define SQLUKCONSTRAINT 1                   /* Ansi Code                             */

typedef struct tagTRAZAPROC
{
    long lCodCiclFact       ;
    int  iCodProceso        ;
    int  iCodEstaProc       ;
    char szFecInicio[15]    ;
    char szFecTermino[15]   ;
    char szGlsProceso[51]   ;
    long lCodCliente        ;
    long lNumAbonado        ;
    long lNumRegistros      ;
} TRAZAPROC                 ;


#undef access
#ifdef _TRAZAFACT_PC_
#define access
/* -------------------------------------------------------------------------- */
/*               Prototipos de Funciones locales de trazafact                 */
/* -------------------------------------------------------------------------- */

#else
#define access extern
#endif  /*_TRAZAFACT_PC_*/

access  BOOL bfnValidaTrazaProc          (long ,int , int);
access  BOOL bfnSelectTrazaProc          (long ,int , TRAZAPROC * );
access  BOOL bfnUpdateTrazaProc          (TRAZAPROC );
access  void bPrintTrazaProc             (TRAZAPROC );

access  BOOL bfnValidaTrazaProcHost      (long lCiclParam,int iCodProceso, int iIndFacturacion, char *szHostId);
access  int ifnGetHostId                 (char *szHostID);
access  int iGetRangosHost               (char *szHostID, int iCodCiclFact, long *lCodClienteIni, long *lCodClienteFin);
access  BOOL bfnSelectTrazaProcHost      (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza, char *szHostId);
access  BOOL bfnUpdateTrazaProcHost      (TRAZAPROC pstTraza, char *szHostId);
access  int ifnBuscarRangosClientesBD    (long lCodCiclFact,long *lpClieIni, long *lpClieFin, int *ipExisteRango);

access  BOOL bfnValidaTrazaProcHostFirst (long lCiclParam,int iCodProceso, int iIndFacturacion, char *szHostId);

/* Variables Globales de Traza */

access TRAZAPROC    stTrazaProc    ;
#undef access
#endif  /*_TRAZAFACT_H_*/

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

