/*=============================================================================
   Nombre     : Pago_Externo.h
   Programa   : Libreria del Aplicador de Pagos Externos 

  ============================================================================= */

#define  MAX_REG    5000  
#define  SQLERRM    sqlca.sqlerrm.sqlerrmc

/*#define szVERSION             "v.3.0.0"          * MIX-09003 17.02.2010  MQG */
#define szVERSION             "v.3.0.1"          /* Incidencia 129515 - 09.04.2010  MQG*/

typedef struct tagPago_Ext
{
  char szUsuario       [31];
  char szPassWord      [31];
  long lNum_Compago        ;
  int  iNivelLog           ;
  char szFile        [1024];
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
  BOOL bOptNumComPago      ;
  BOOL bOptFile            ; 
}PAGO_EXT;


static int ifnInicio ( PAGO_EXT *stPago_Ext, STATUS *pstStatus );
static int ifnExitAplicapago (void);
static int ifnSelecTipo_Pagos();
static int ifnAplica_Pagos (int i);
int ifnInsert_Co_Recaudaext ();
int ifnDelete_Co_TransacExt();
static void vfnMemsetVariables();
int ifnAbreArchivosLog();
int ifnInsert_Co_Hinterfaz ();
int RighTrim (char *szVar);

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

