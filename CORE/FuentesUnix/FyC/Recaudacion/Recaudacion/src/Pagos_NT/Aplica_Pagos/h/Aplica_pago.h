/*=============================================================================
   Nombre     : Aplica_Pago.h
   Programa   : Libreria del Aplicador de Pagos en Linea 
   Autor      : G.A.C  
   Modificado : 15 - Enero - 2003
   
  ============================================================================= */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


/*#define szVERSION    "4.1"  * Nueva version para TMG-TMS*/
#define szVERSION    "4.2."    /* Mantencion Limite de Consumo 159946 */

#define  DOCTO    8
#define  AGENTE   100001
#define  CENTRO   1
#define  MOTIVO   2 
#define  VALOR    1
#define  MONEDA   "001"
#define  LETRA    "X"

#define  MAX_REG    5000
#define  SQLERRM    sqlca.sqlerrm.sqlerrmc

typedef struct tagAplicaPago
{
  char szUsuario       [31];
  char szPassWord      [31];
  long lNum_Compago        ;
  int  iNivelLog           ;
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
  BOOL bOptNumComPago      ;
}APLICAPAGO;



static BOOL bfnInicio ( APLICAPAGO *stAplicaPago, STATUS *pstStatus );
static BOOL bfnAplica_Pagos (int i);
static BOOL bfnDesaplica_Pagos (int i);
static BOOL bfnExitAplicapago  ();
static void vfnMemsetVariables();
static BOOL bfnUpdateColasProc (char *szEstado);
static BOOL bfnGrabaArchivoPlano();
int    ifnAbreArchivosLog();
int    ifnAbreArchivosDat();
static int ifnVerificaPeriodo ();
static BOOL bfnSelectNum_Compago();
static int ifnSelecTipo_Pagos();
int ifnMailAlert (char* szFrom, char* szMailTo, char* szTxt, ...);
static int bfnSeleccionaOperadora();
static BOOL bfnAplica_Pagos_LimiteConsumo (int i);
void rtrim( char *szCadena );

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
