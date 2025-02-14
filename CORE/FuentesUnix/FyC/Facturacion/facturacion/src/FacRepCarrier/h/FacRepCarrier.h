/* *********************************************************************** */
/* *  Fichero : fortas.h                                                 * */
/* *  Proceso de "Trafico Internacional"                                 * */
/* *  Autor : Marcos Martinez Garcia                                     * */
/* *  Ultimas modificaciones : Roy Barrera R.  10-Nov-1999               * */
/* *********************************************************************** */

#ifndef _REPCARRIER_H_
    #define _REPCARRIER_H_

    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <memory.h>
    #include <malloc.h>
    #include <stdarg.h>

	#include <strings.h>
	#include <fcntl.h>
	#include <math.h>
	#include <time.h>
	#include <ctype.h>

    #include "GenFA.h"
    #include "predefs.h"

    #include "imptoiva.h"
    #include "ORAcarga.h"



	#define SQLOK 0         /* Termino OK */
	#undef  SQLNOTFOUND
	#define SQLNOTFOUND 1403 /* no encontro el dato  (modo Ansi = 100 ; modo SQL = 1403) */
	#define SQLDUPLIC -1     /* la clave primaria esta duplicada */


#endif

#undef access

#ifdef _REPCARRIER_C_
    #define access
#else
    #define access extern
#endif

/* */


typedef struct TRep
{
    char    szNumServicio[16+1];
    double  dTotFacturado;
    double  dFacturadoLDN;
    double  dFacturadoLDI;
    double  dFacturadoImpto;
    char    szFecFacturacion[11+1];
    char    szFecVencimiento[11+1];
    struct TRep *sgte;
}TReporte;


TReporte *pstLista = NULL;

access char szfecproceso[9];  /* YYYYMMDD [7] */
access const char *szPathReporte = "carrier/reporte";

/* Caracteres no permitidos en las cadenas de entrada */
access const char *szCadValidacion = ":\\%";

/* Definicion de valores para Carrier LDN y LDI */
access const char *szCarrierLDN = "03";
access const char *szCarrierLDI = "04";

/* Tamanio maximo para Cod. de ciclo y Cod. Carrier */
access const int iMaxLargoCiclo   =6; /* NUMBER(6) */
access const int iMaxLargoCarrier =5; /* NUMBER(5)*/

#undef access

#ifdef _REPCARRIER_PC_
    #define access
#else
    #define access extern
#endif

access BOOL bfnObtenerDatosProceso(long lCodCiclFact,long *lNumProceso, char *szFecEmision);
access BOOL bfnDetectarTablaVencimientos(long lCodCiclFact, char *pszTablaVenc);
access long lfnCargarReporte(char *pszTablaVenc,long lCodCiclFact,char *pszCarrier, long lNumProceso, char *pszFecEmi);
access long lfnImprimirReporte(long lCodCiclFact, char *pszCarrier, char *pszDelim);
access BOOL bfnLiberarReporte(void);
access int  ifnEsNumerico(char *pszCad);

#undef _REPCARRIER_C_
#undef _REPCARRIER_PC_

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