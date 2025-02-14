/* ============================================================================= 
    Tipo        :  Aplicacion
    Nombre      :  Gen_Ajustes.h
    Descripcion :  Header para Gen_Ajustes.pc
    		          Declaracion de estructuras, variables y funciones. 
    		          Basado en ajustes.h (JLR 01-06-99)
    Autor       :  Roy Barrera Richards
    Fecha       :  25 - Julio - 2001
 ============================================================================= */

#define szPREF_PLAZA_DEFAULT  "000"   
#define szVersion             "v.4.0.0"

typedef struct tagAjuste
{
  char szUsuario       [31];
  char szPassWord      [31];
  long lDiferencia         ;
  int  iNivelLog           ;
  BOOL bOptUsuario         ; 
  BOOL bOptPassWord        ;
  BOOL bOptCodTipDocum     ;
  BOOL bOptNivelLog        ;
  BOOL bOptMonto           ;
}AJUSTE;

typedef struct tagCartera
{
  long	lCodCliente;
  double	dMtoSaldo;
}CARTERA;

static BOOL bfnInitAjustes (	AJUSTE	*stAjuste,STATUS *stStatus	);
static BOOL bfnExitAjustes (void);
static BOOL bfnGenAjustes ( AJUSTE stAjuste);
static int  ifnDBOpenCartera (AJUSTE stAjuste);
static int  ifnDBFetchCartera (	AJUSTE	 stAjuste,CARTERA	*stCartera	);
static int  ifnDBCloseCartera (void);
static BOOL bfnAjuCobros (	DATCON    *pstCobros , int        iCodAbono , CARTERA    stCartera );
static BOOL bfnPagoAjuste (DATDOC *pstDatDoc, DATPAG *pstDatPag, DATCON *pstCobros);
static BOOL bfnDBInsertAjustes (DATCON pstCobros, DATPAG pstDatPag);
static BOOL bfnDBInsertAjusteConc (DATCON pstCobros);
BOOL bfnDBObtConCreFA( int *iCodConcepto );
void rtrim( char *szCadena );
int ifnValidaConceptos( long lCodCliente );

/* fin */


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

