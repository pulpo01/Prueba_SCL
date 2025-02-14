/*******************************************************************************

Fichero:      deftypes.h
Descripcion:  Declaracion de general de tipos.

Fecha:        
Autor:        Facturacion Boy's 

*******************************************************************************/


#ifndef _DEFTYPES_H_
#define _DEFTYPES_H_

#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <stdarg.h>
/* #include <varargs.h> */
#include <stdlib.h>
#include <sys/times.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/fcntl.h>
#include <utmp.h>
#include <errno.h>

typedef unsigned char        BYTE;   /*  8-bit sin signo */
typedef unsigned short int   WORD;   /* 16-bit sin signo */ 
typedef unsigned long int    LONG;   /* 32-bit sin signo */

#ifndef _BOOL_
#define _BOOL_
#define  FALSE  0
#define  TRUE   !FALSE 

typedef int BOOL;         /* Tipo Booleano */
#endif /* _BOOL_ */

/* Status de ejecucion */
typedef struct tagSTATUS
{
 long   IdPro        ;     /* Identificador proceso asignado al programa                   */
 long   IdPro2       ;     /* Para Venta con Contado y Credito                             */
 BOOL   ExitApp      ;     /* Salida de la aplicacion                                      */
 LONG   ExitCode     ;     /* Codigo de salida de la aplicacion                            */ 
 BOOL   SkipRec      ;     /* Salto                                                        */
 LONG   SkipCode     ;     /* Codigo de salto                                              */ 
 int    LogNivel     ;     /* Nivel en el fichero de log                                   */
 char   LogName[256] ;     /* Nombre del fichero de log                                    */
 FILE*  LogFile      ;     /* Fichero de log                                               */
 char   ErrName[256] ;     /* Nombre del Fichero de Errores                                */
 FILE*  ErrFile      ;     /* Fichero de Error                                             */
 BOOL   Config       ;     /* Configuracion                                                */ 
 BOOL   OraConnected ;     /* Conexion con Oracle                                          */
 BOOL   bOpenCursor  ;     /* Cursor Fa_CicloCli Abierto = TRUE                            */
 BOOL   bCursorCiclo ;     /* Indica cual de los dos cursores Abre                         */ 
 int    iSizeFileLog ;     /* Tamano de Fichero de Log                                     */
 long   lNumReg      ;     /* Numero de Clientes Procesados                                */
 long   lNumRegOk    ;     /* Numero de Clientes Procesados Correctamente                  */
 long   lNumRegErr   ;     /* Numero de Clientes Erroneos                                  */
 /*Proyecto de Optimizacion del Facturador                                                 */
 long	lCodCliErr      ;  /* Registro de Codigo Cliente con Error, parte en -1            */
 short  hTasaExitoMinReq;  /* Tasa de exito minimo requerido                               */
 long   lCantCliMinEval ;  /* Cantidad minima de Clientes para evaluación de tasa de exito */
 long   lMaxCliConsError;  /* Maximo de clientes consecutivos con error                    */
 short  hTasaObservada  ;  /* Registro de la tasa observada                                */
 long   lConCliCons     ;  /* Contador de Clientes consecutivos                            */
 long   lCodCliActual   ;  /* Cliente Actual                                               */
 long   lErrorReg	    ;  /* Variable que guarda el número de registro que tuvo el último */
 			               /* error,de tal manera de identificar si el error es consecutivo*/
 /* BUFFEREO del archivo de log... si funciona, se hará lo mismo con el arcbhivo de errores*/
 char   szBuffLog[10000];  /* Buffer de Archivo de Log                                     */
 /******************************************************************************************/
}STATUS;

/* Maximo Valor que puede tomar NumSecuenci en Ge_SecuenciasEmi */
#define MAXIMO_SECUENCIASEMI 99999999

/* Numero de Registros de los Host Array's */
#define NREG 9999 /* SAAM-20040910 Homologacion HD-200407151124 */
#endif /* _DEFTYPES_H_ */


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

