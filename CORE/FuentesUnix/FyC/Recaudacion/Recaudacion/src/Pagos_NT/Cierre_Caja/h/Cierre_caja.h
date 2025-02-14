#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define  DOCTO    8
#define  AGENTE   100001
#define  LETRA    "X"
#define  CENTRO   1
#define  MOTIVO   2
#define  VALOR    1
#define  MONEDA   "001"
#define  SERVICIO  8 

#define  MAX_REG    5000
#define  SQLERRM          sqlca.sqlerrm.sqlerrmc

typedef struct tagCierre
{
  char szUsuario       [31];
  char szPassWord      [31];
  long lNum_Compago        ;
  int  iNivelLog           ;
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
  BOOL bOptNumComPago      ;
}CIERRE;


static BOOL bfnInicio ( CIERRE *stCierreCaja, STATUS *pstStatus );
static BOOL bfnCierre_Caja (CIERRE stCierreCaja);
static BOOL bfnExitCierre_Caja  ();
static BOOL ifnDBOpenInterfaz ();
static BOOL ifnDBFetchInterfaz ();
static BOOL ifnDBCloseInterfaz ();
static int  bfnDBValidaRegistros (char *szNum_Ejercicio);
static void vfnMemsetVariables();
static BOOL bfnUpdateColasProc (char *szEstado);
int ifnAbreArchivosLog();
int ifnMailAlert (char* szFrom, char* szMailTo, char* szTxt, ...);














