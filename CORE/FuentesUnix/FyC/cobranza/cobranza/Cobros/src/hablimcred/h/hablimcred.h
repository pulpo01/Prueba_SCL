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

