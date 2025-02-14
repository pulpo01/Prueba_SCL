#ifndef _HABLIMCRED_H_
	#define _HABLIMCRED_H_
	#include <stdarg.h>
	#include <GenFA.h>
	#include <math.h>
#endif

#define iLOGNIVEL_DEF 	3

typedef struct LineaComando
{
    char    szUsuarioOra [64] ;
    char    szOraAccount [32] ;
    char    szOraPasswd  [32] ;
     int    iLogLevel         ;
    char    szCicloFact  [7]  ;
    long    lCicloFact        ;
}LINEACOMANDO;

#undef access 
#define access extern

access BOOL bfnInitInstance();
access BOOL bfnHabLimCred();
access BOOL bfnExitInstance();

char *szGetTime(int fmto);


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

