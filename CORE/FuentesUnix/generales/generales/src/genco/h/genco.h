/****************************************************************************/
/*                                                                          */
/*    Descripcion : Funciones generales del modulo de Cobros                */
/*                                                                          */
/*    Modulo      : COBROS.                                                 */
/*                                                                          */
/*    Fichero     : genco.pc                                                */
/*                                                                          */
/*    Programador : Julia Serrano Pozo.                                     */
/*                                                                          */
/*    Fecha       : 21-01-1997                                              */
/*                                                                          */
/*    Modificacion: 21-01-1997                                              */
/*                                                                          */
/****************************************************************************/

#define IMPORTEMINIMO     0.01
#define IMPORTEMAXIMO     1e10
#define INVMIN            100

#define ORA_FETCHNULL     -1405

#define iDOCPAGO          8
#define iDOCNCI           9
#define iDOCNDI           10
#define iDOCCARTAPAGO     17
#define iDOCPAGOCUOTA     16
#define iDOCPAGOCARRIER   20
#define iDOCRESPALDO      32
#define iDOCPAGARE        5
#define iDOCRECEXT        33
#define iDOCCCONTA        39

/****************************************************************************/
/*			ESTRUCTURAS					    */
/****************************************************************************/

/* Datos de Concepto de Cartera */
typedef struct tagDATCON				
{                                       
   int     iCodTipDocum         ;                
   long    lCodAgente           ;                  
   char    szLetra           [2];                  
   int     iCodCentremi         ;                
   long    lNumSecuenci         ;                
   int     iCodConcepto         ;                
   int     iColumna             ;                    
   int     iCodProducto         ;                
   double  dImporteDebe         ;                
   double  dImporteHaber        ;               
   int     iIndContado          ;                 
   int     iIndFacturado        ;               
   char    szFecEfectividad  [9];         
   char    szFecVencimie     [9];            
   char    szFecCaducida     [9];            
   char    szFecAntiguedad   [9];          
   char    szFecPago[9]         ;                
   int     iDiasVencimiento     ;            
   long    lNumAbonado          ;                 
   long    lNumFolio            ;                   
   long    lNumCuota            ;                   
   int     iSecCuota            ;                   
   long    lNumTransa           ;                  
   long    lNumVenta            ;                   
   char    szFolioCTC       [12];	
   char    szPrefPlaza      [26];
   char    szCodOperadoraScl [6];
   char    szCodPlaza        [6];	
}DATCON;



/*****************************************************************************/
BOOL bfnDBValFecValor(char *szFecValor);
/**
Valida si la fecha pasada por argumento es menor o igual que SYSDATE.
Si en mayor devuelve FALSE.
**/
/*****************************************************************************/
BOOL bfnDBSecCol(DATCON *stCon);
/**
Descripcion: Funcion que obtiene la secuencia de la proxima columna.
Entrada:     stCon, estructura de datos de concepto generado.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
/*****************************************************************************/
extern BOOL bfnDBIntCartera(DATCON *stConGen,long lCodCliente);
/**
Descripcion: Funcion que introduce en cartera el concepto generado.
Entrada:     stConGen, estructura de concepto generado.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
/*****************************************************************************/
BOOL bfnDBInsCreCon(DATCON *stDoc,DATCON *stHab);
/**
Lleva la relacion del pago con el concepto a pagosconc.
En caso de error devuelve FALSE.
**/
/*****************************************************************************/
BOOL bfnDBUpdCartera(DATCON *stCon,long lCodCliente);
/**
Descripcion: Modifica el importe del concepto
Salida     : True, si todo va ok
             False, si se genera algun error
**/
/*****************************************************************************/
BOOL bfnDBLlevarACanCtos(DATCON *stCon,long lCodCliente,char *szFecHis);
/**
Descripcion: Mueve el concepto de argumento y todos sus relacionados de
             cartera a cancelados.
Salida     : En caso de error devuelve FALSE.
**/
/*****************************************************************************/
BOOL bfnDBObtConCre(int *iCodConcepto);
/**
Descripcion: Obtener el codigo de concepto credito
Salida     : True, si todo va ok
             False, si se genera algun error
**/
/*****************************************************************************/

double fnRedondea(double dMonto,int iCntDecimales);
BOOL   bfnDBUpdCastigo(long lCodCliente,long lNumFolio,double dMtoPago);
extern BOOL   bfnDBCreaDirPath(char *szColumnName, char *szRetPath);
int    iDBTomarSecuencia(int iCodTipDocum,int iCodCentrEmi,char *szLetra, long* lNumSec);
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

