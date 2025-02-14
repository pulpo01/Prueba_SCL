#ifndef __FPCARGAULTPAGO_H__
#define __FPCARGAULTPAGO_H__

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <unistd.h>

#include "deftypes.h"
#include "trazafact.h"
#include "FaORA.h"
#include "GenFA.h"

#include "errores.h"

#define      SqlNotFound      1403
#define      SqlNull          1405
#define      SqlORADUP        1
#define      SqlOk            0

#define     RET_ERROR_PARAMETROS        -1
#define     RET_ERROR_ARCHIVOSLOG       -2
#define     RET_ERROR_ACCESSORA         -3
#define     RET_ERROR_PROCESO           -4
#define     RET_ERROR_OTROS2         -5

char szhVersion[] = "v.1.0.1";

typedef struct tagArgsEntrada
{
    long    lCodCiclFact;
    char    szOraAccount[32];
    char    szOraPasswd [32];
    int     iLogLevel   ;
    long    lClienteIni ;
    long    lClienteFin ;
}ARGSENTRADA;

/*** Declaracion de Funciones ***/

BOOL bfnProcesaUltPago (ARGSENTRADA stArgs);

BOOL bfnValidaParametros(int argc, char **argv, ARGSENTRADA * stArgs);
BOOL ifnAcessoOracle(char *szOraAccount , char *szOraPasswd);
BOOL bfnAbreArchivosLog( long lCodCiclFact, int iLogLevel);
BOOL bfnBorraUltPago (ARGSENTRADA stArgs);
BOOL bfnProcesaAjustes (ARGSENTRADA stArgs);
/* Funciones "wrapper" */
BOOL bfnWrapperSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza);
BOOL bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza);
BOOL bfnWrapperValidaTrazaProc(TRAZAPROC pstTraza);

char szUsage[]=
"\n\tUso : FPCargaUltPago\n"
"\n\tOpciones :"
"\n\t\t-u usuario/password o '/'(Opcional)"
"\n\t\t-c Cod_CiclFact (Codigo de Ciclo de Facturacion)"
"\n\t\t-i Rango inicial de clientes a procesar (Opcional)"
"\n\t\t-f Rango final de clientes a procesar (Opcional)"
"\n\t\t-l nivel de Log de la cola(Opcional)"
"\n";

#endif

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

