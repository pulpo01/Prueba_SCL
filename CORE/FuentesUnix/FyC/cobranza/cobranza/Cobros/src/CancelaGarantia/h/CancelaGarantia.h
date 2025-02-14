/*==================================================================================
   Nombre      : CancelaGarantia.h
   Programa    : Libreria de Cancelacion de Garantia.
   Autor       : G.A.C.  
   Modificado  : 10-Julio-2003 (TMM)
   v.1.3.0
  ==================================================================================*/

#define  MAXREG	  30000
#define  SQLERRM    sqlca.sqlerrm.sqlerrmc
#define  szVersion  "v.4.0.0"

typedef struct pstLineaComando
{
  char szUsuario       [31];
  char szPassWord      [31];
  int  iNivelLog           ;
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptNivelLog        ;
}LINEACOMANDO;


/* ============================================================================= */
/* declaracion de prototipos de funciones                                        */
/* ============================================================================= */
int ifnInicio ( LINEACOMANDO *stLineaComando, STATUS *pstStatus );
int ifnExitAplicapago (void);
int ifnAbreArchivosLog();
int LeftTrim (char *szVar);
int RighTrim (char *szVar);
int ifnGetCobros();
int ifnCarga_Garantias ();



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

