#ifndef _LIBRO_H_
#define _LIBRO_H_
#include <memory.h>
#include <GenFA.h>
#include <trazafact.h>
#endif    

#define iLOGNIVEL_DEF       3

#define iDocOk              0   /*  Folio Bien Utilizado    */
#define iDocAnulado         1   /*  Folio Anulado           */

#define iCodParBolAuto      17  /* Codigo de parametro de boletas autofoliadas */
#define iCodParBolAutoExen  18  /* Codigo de parametro de boletas exentas autofoliadas */

#define SQLUNIQUE            -1

#define MAX_REGISTROS        500
#define MAX_NUMREGISTROS      52
#define MAX_LARGOREGISTRO    200
#define MAXREG_COMMIT       1000 

#define MAX_SIZEBUFFER      MAX_NUMREGISTROS * MAX_LARGOREGISTRO

#define NUM_TIPDOCUM        100

#define LINEAS_CABECERA       6
#define LINEAS_SUBTOTAL       3
#define LINEAS_TATALIZADOR   10

#define iERROR_GETCLIENTE   -1000
#define iERROR_GETOFICINA   -2000

#define NOCICLO             "FA_FACTDOCU_NOCICLO"
#define HISTDOCU            "FA_HISTDOCU"

#define HISTO               "H"            /*HISTORICO*/
#define CICLO               "C"            /*CICLO    */
#define NOCIC               "N"            /*NO CICLO */
#define CONSU               "A"            /*CONSUMO  */

/************************************************************************/
/*  Codigos para rescatar registros desde tabla de Parametros           */
/*  FAD_PARAMETROS                                                      */
/************************************************************************/
#define     FAD_NOM_REP_LEGAL     1
#define     FAD_RUT_REP_LEGAL     2

char szCod_Oficina [3];
char szDia_Aux     [3];
long lFolio_Desde     ;
long lFolio_Hasta     ;
long lFolio_Anterior  ;
long lConRegFinal = 0 ;

/* Totalizadores Diarios de boletas*/
double dTotNetoNoGravBol =0 ;
double dTotNetoGravBol   =0 ;
double dTotIvaBol        =0 ;
double dTotDocumentoBol  =0 ;

int    iIndPrefFolio	   	;


/************************************************************************/
/*  Estructura para recoger los datos por la linea de comandos.         */
/************************************************************************/

typedef struct LineaComando
{
     char szUser   [50]     ;       /*  Usuario Unix                        */    
     char szPass   [50]     ;       /*  Password Oracle de Usuario Unix     */
     char szDirLogs[1024]   ;       /*  Directorio de Archivos Log's y Err  */
     char szDirDats[1024]   ;       /*  Directorio de Archivos de Datos     */
     char szFileDat[1024]   ;       /*  Nombre del Archivo de Datos         */
     FILE *fpDat            ;       /*  Descriptor de Archivo de Salida     */
     int  iMes              ;       /*  Mes de Libro de Iva                 */
     int  iAno              ;       /*  Ano de Libro de Iva                 */
     int  iTipDoc           ;       /*  Tipo de Documento                   */
     int  iNivLog           ;       /*  Nivel de Log para Proceso           */
     char szTabla  [20]     ;       /*  tabla a consultar                   */ 
     BOOL bImprime          ;       /*  Impresion                           */ 
     char szOficina[3]      ;       /*  Numero de oficina                   */ 
}LINEACOMANDO;


/************************************************************************/
/*   Estructura para recoger los datos de la tabla FA_HISTDOCU.         */
/************************************************************************/

typedef struct tagGHistDocu
{
    long    lIndOrdenTotal      ;
    int     iIndAnulada         ;
    int     iCodTipDocum        ;
    long    lCodCiclFact        ;
    long    lNumFolio           ;
    char    szFecEmision    [15];
    char    szMesAno        [8] ;
    char    szNomCliente    [60];
    char    szRut           [21];
    double  dAcumNetoNoGrav     ;
    double  dAcumNetoGrav       ;
    double  dAcumIva            ;
    double  dTotDocumento       ;
    int     iCod_tipdocumalm    ;
    char    szCod_Oficina   [3] ;
    char    szDia_Emision   [3] ;
    char    szRowid         [19];
    int     iInd_Supertel       ;
    int     iInd_Factur         ;
    long    lCodCliente         ;
    char    szFecVencimiento[15];
    char 	szPrefPlaza		 [4];
}GHISTDOCU;

/************************************************************************/
/*   Estructura para recoger los datos de la tabla FA_HISTCLIE.         */
/************************************************************************/

typedef struct tagGHistClie
{
    long    lIndOrdenTotal      ;
    long    lCodCiclFact        ;
    char    szNomCliente    [60];
    char    szRut           [21];
}GHISTCLIE;




/************************************************************************/
/*   Estructura para Contabilizar Totales po Oficina por Tipo de Documento.        */
/************************************************************************/

typedef struct tagAcumladores
{
    long    lNumBoleta      	;
    long    lNumBoletaAnul  	;
    double  dNetoBoleta     	;
    double  dExentoBoleta   	;
    double  dIvaBoleta      	;
    double  dTotalBoleta    	;

    long    lNumBoletaExen      ;
    long    lNumBoletaExenAnul  ;
	double  dNetoBoletaExen     ;
    double  dExentoBoletaExen   ;
	double  dIvaBoletaExen      ;
    double  dTotalBoletaExen    ;

    long    lNumBoletaAfec69    ;
    long    lNumBoletaAnulAfec69;
	double  dNetoBoletaAfec69   ;
    double  dExentoBoletaAfec69 ;
	double  dIvaBoletaAfec69    ;
    double  dTotalBoletaAfec69  ;

    long    lNumBoletaExen73    ;
    long    lNumBoletaExenAnul73;
	double  dNetoBoletaExen73   ;
    double  dExentoBoletaExen73 ;
	double  dIvaBoletaExen73    ;
    double  dTotalBoletaExen73  ;
   
}GACUMULADOR;



/************************************************************************/
/*   Estructura para Contabilizar Totales Finales por Tipo de Documento.        */
/************************************************************************/

typedef struct tagTotAcumuladores
{
    long    lNumBoleta       	;
    long    lNumBoletaAnul  	;
    double  dNetoBoleta     	;
    double  dExentoBoleta   	;
    double  dIvaBoleta      	;
    double  dTotalBoleta    	;

    long    lNumBoletaExen      ;
    long    lNumBoletaExenAnul  ;
	double  dNetoBoletaExen     ;
    double  dExentoBoletaExen   ;
	double  dIvaBoletaExen      ;
    double  dTotalBoletaExen    ;
    
    long    lNumBoletaAfec69    ;
    long    lNumBoletaAnulAfec69;
	double  dNetoBoletaAfec69   ;
    double  dExentoBoletaAfec69 ;
	double  dIvaBoletaAfec69    ;
    double  dTotalBoletaAfec69  ;
    
    long    lNumBoletaExen73    ;
    long    lNumBoletaExenAnul73;
	double  dNetoBoletaExen73   ;
    double  dExentoBoletaExen73 ;
	double  dIvaBoletaExen73    ;
    double  dTotalBoletaExen73  ;
}GACUMULADORFINAL;


/************************************************************************/
/*   Estructura para Contabilizar Totales por Tipo de Facturas          */
/************************************************************************/

typedef struct tagTotTipDocum
{
    long    lNumDocumentosOk    ;
    long    lNumDocumentosAnul  ;
    double  dNetoDocumentos     ;
    double  dExentoDocumentos   ;
    double  dIvaDocumentos      ;
    double  dTotalDocumentos    ;
}GTOTTIPDOCUM;


typedef struct tagTotTipDocumFinal
{
    long    lNumDocumentosOkFinal    ;
    long    lNumDocumentosAnulFinal  ;
    double  dNetoDocumentosFinal     ;
    double  dExentoDocumentosFinal   ;
    double  dIvaDocumentosFinal      ;
    double  dTotalDocumentosFinal    ;
}GTOTTIPDOCUMFINAL;


/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

char                szExeLibro [1024]           ;

char                szNomRepLegal[131]          ;
char                szRutRepLegal[21]           ;

char                szTipParametro [33]         ;
char                szValParametro [512]        ; 

int                 iCodBoletaAuto              ;
int                 iCodBoletaAutoExen          ; 

LINEACOMANDO        stLineaComando              ;

GACUMULADOR         stAcumulador                ;
GACUMULADORFINAL    stAcumuladorFinal           ;

GTOTTIPDOCUM        stTotTipDoc[NUM_TIPDOCUM]   ;
GTOTTIPDOCUMFINAL   stTotTipDocFin[NUM_TIPDOCUM];

/************************************************************************/

#undef access

#ifdef _LIBROC_C_
#define access
#else
#define access extern
#endif

static BOOL bfnOraGenLibro          (LINEACOMANDO stLineaComando);
static BOOL bfnGetHistClie          (GHISTCLIE *pstGHistClie, LINEACOMANDO stLineaComando);
static BOOL bfnInsertaConsumosenLibroIva(GHISTDOCU pstGHistDocu, BOOL *bInsert);
static BOOL bfnUpdateIndLibro       (char *szNomTabla, GHISTDOCU stGHistDocu,
                                     BOOL OptInsert, BOOL BIndica);
static BOOL bfnLlenaArchivoImpresion(char *szFecInicio, char *szFecFin);
static int  bfnFetchLibroIva        ( GHISTDOCU *stGHistDocu);
static void bfnEscribeBuffer        (int iDoc, GHISTDOCU  pstGHistDocu, int *iCargaFile);
static BOOL bfnEscribeLibro         (char *szBuf, int iPag, int iTipDoc,int iMesAux,
                                     int iAnoAux, char *szCodOficina, char *szhDesOficina);
static void bfnCargaBoletas         (int iDoc, GHISTDOCU  pstGHistDocu);
static BOOL bfnEscribeCab           (int iPag, int iTipDoc, int iMesAux,
                                     int iAnoAux, char *szCodOficina,char *szhDesOficina);
static void bfnAcumulaDocumento     (int iTipDocumento, GHISTDOCU pstGHistDocu );
static void bfnAcumulaDocumentoFinal(int iTipDocumento, GHISTDOCU pstGHistDocu );
static BOOL bfnEscribeTotDocum      (int iTipDocumento);
static BOOL bfnUpdateIndConsumosLibroIva( GHISTDOCU stGHistDocu, BOOL OptInsert);
static BOOL bfnEscribeTotLibro      (int iMesAux, int iAnoAux);
static void vfnEscribeEstadisticas  (void);
static BOOL bfnCloseFat_DetLibroIva ();
static BOOL bfnLeeCodLibroVta       (int iCodTipDocMov, int *iCodLibroVta );
int	ifnGetParametro2 (int iCodParametro, char *szTipParametro, char *szValParametro );
 
#undef access

#undef _LIBRO_C_

static char *szNombreDocs[]={"0:NONE", "FACTURAS AFECTAS ", "FACTURAS EXENTAS",
                             "NOTAS DE CREDITO", "BOLETAS AFECTAS",
                             "BOLETAS EXENTAS", "BOLETAS AMISTAR" };

static char *szNombreMes[]={"ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO",
                            "JUNIO", "JULIO","AGOSTO", "SEPTIEMBRE", "OCTUBRE",
                            "NOVIEMBRE", "DICIEMBRE" };
static char szUsage[]=
    "\nUso:  LibroVentaAux  -u Usuario/PassWord Opciones  "
    "\n\t\t -l Nivel de Log                             "
    "\n\t\t Opciones :                                  "
    "\n\t\t -i Impresion                                "
    "\n\t\t\t -m Mes(2) -a Ano(4)                       ";
    


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

