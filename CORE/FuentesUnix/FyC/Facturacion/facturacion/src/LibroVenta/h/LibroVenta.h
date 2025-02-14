#ifndef _LIBRO_H_
#define _LIBRO_H_
#include <memory.h>
#include <GenFA.h>
#include <trazafact.h>
#endif

#define iLOGNIVEL_DEF           3   /* Valor LOG Default                                  */
#define iDocOk                  0   /* Folio Bien Utilizado                               */
#define iDocAnulado             1   /* Folio Anulado                                      */
#define iTipFactura             1   /* Documento Tipo Factura (Afecta) 28                 */
#define iTipFacturaExen         2   /* Documento Tipo Factura (Exenta) 47                 */
#define iTipNotaCred            3   /* Documento Tipo Nota de Credito                     */
#define iTipFacturaElec         4   /* Documento Tipo Factura (Afecta) 28                 */
#define iTipFacturaElecExen     5   /* Documento Tipo Factura (Exenta) 47                 */
#define iTipBoleta              6   /* Documento Tipo Boleta (Afecta)                     */
#define iTipBoletaExen          7   /* Documento Tipo Boleta (Exenta)                     */
#define iTipBoletaAuto          8   /* Documento Tipo Boleta Autofoliada (Afecta)         */
#define iTipBoletaAutoExen      9   /* Documento Tipo Boleta Autofoliada (Exenta)         */
#define iTipBoletaAmis          10  /* Documento Tipo Boleta (Amistar)                    */
#define iTipBoletaAuto69        11  /* Documento Tipo Boleta Autofoliada (Afecta)         */
#define iTipBoletaAuto73        12  /* Documento Tipo Boleta Autofoliada (Exenta)         */
#define iTipNotaAbon            13  /* Documento Tipo Nota de Abono                       */ /* P-MIX-09003 */

#define iCodParamBoletaAuto     17  /* Codigo de parametro para Boleta autofoliada Afecta */
#define iCodParamBoletaAutoExen 18  /* Codigo de parametro para Boleta autofoliada Exenta */
#define iCodParamNotaAbono      676 /* Codigo de parametro para Nota de Abono             */ /* P-MIX-09003 */

#define SQLUNIQUE               -1
#define MAX_REGISTROS           500
#define MAX_NUMREGISTROS        52
#define MAX_LARGOREGISTRO       200
#define MAXREG_COMMIT           1000 
#define MAX_SIZEBUFFER          MAX_NUMREGISTROS * MAX_LARGOREGISTRO
#define NUM_TIPDOCUM            100
#define LINEAS_CABECERA         6
#define LINEAS_SUBTOTAL         3
#define LINEAS_TATALIZADOR      10
#define iERROR_GETCLIENTE       -1000
#define iERROR_GETOFICINA       -2000
#define NOCICLO                 "FA_FACTDOCU_NOCICLO"
#define HISTDOCU                "FA_HISTDOCU"
#define HISTO                   "H"            /*HISTORICO*/
#define CICLO                   "C"            /*CICLO    */
#define NOCIC                   "N"            /*NO CICLO */
#define CONSU                   "A"            /*CONSUMO  */
#define CATEGORIA_IMPOSITIVA    "COD_CATIMPOS"
#define ZONA_IMPOSITIVA         "COD_ZONAIMPO"
#define TIPO_IMPUESTO           "COD_TIPIMPUES"
#define GRUPO_SERVICIO          "COD_GRPSERVI"
#define FAD_NOM_REP_LEGAL       1
#define FAD_RUT_REP_LEGAL       2
#define sDELIMITADOR            ";"
#define sSALTOLINEA             "\n"

char szCodOficina [3];
char szDiaAux     [3];
long lFolioDesde     ;
long lFolioHasta     ;
long lFolioAnterior  ;
long lConRegFinal = 0 ;

/* Totalizadores Diarios de boletas*/
double dTotNetoNoGravBol =0 ;
double dTotNetoGravBol   =0 ;
double dTotIvaBol        =0 ;
double dTotIvaRetBol     =0 ;
double dTotDocumentoBol  =0 ;


/************************************************************************/
/*  Estructura para recoger los datos por la linea de comandos.         */
/************************************************************************/

typedef struct LineaComando
{
     char szUser      [50];       /*  Usuario Unix                        */    
     char szPass      [50];       /*  Password Oracle de Usuario Unix     */
     char szDirLogs [1024];       /*  Directorio de Archivos Log's y Err  */
     char szDirDats [1024];       /*  Directorio de Archivos de Datos     */
     char szFileDat [1024];       /*  Nombre del Archivo de Datos         */
     FILE *fpDat          ;       /*  Descriptor de Archivo de Salida     */
     int  iMes            ;       /*  Mes de Libro de Iva                 */
     int  iAno            ;       /*  Ano de Libro de Iva                 */
     int  iTipDoc         ;       /*  Tipo de Documento                   */
     int  iNivLog         ;       /*  Nivel de Log para Proceso           */
     char szTabla   [32+1];       /*  tabla a consultar                   */ 
     BOOL bImprime        ;       /*  Impresion                           */ 
     char szOficina    [3];       /*  Numero de oficina                   */ 
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
    char    szPrefPlaza	    [26];
    long    lNumFolio           ;
    char    szFecEmision    [15];
    char    szMesAno         [8];
    char    szNomCliente    [60];
    char    szRut           [21];
    double  dAcumNetoNoGrav     ;
    double  dAcumNetoGrav       ;
    double  dAcumIva            ;
    double  dAcumIvaRet         ;    
    double  dTotDocumento       ;
    int     iCodtipdocumalm     ;
    char    szCodOficina     [3];
    char    szDiaEmision     [3];
    char    szRowid         [19];
    int     iIndSupertel        ;
    int     iIndFactur          ;
    long    lCodCliente         ;
    char    szFecVencimiento[15];
    
}GHISTDOCU;

/************************************************************************/
/*   Estructura para recoger los datos de la tabla FA_HISTCLIE.         */
/************************************************************************/

typedef struct tagGHistClie
{
    long    lIndOrdenTotal   ;
    long    lCodCiclFact     ;
    char    szNomCliente [60];
    char    szRut        [21];
}GHISTCLIE;

/************************************************************************/
/*   Estructura para Contabilizar Totales po Oficina por Tipo de Documento.        */
/************************************************************************/

typedef struct tagAcumladores
{
    long    lNumFacturas           ;
    long    lNumFactAnul           ;
    double  dNetoFacturas          ;
    double  dExentoFacturas        ;
    double  dIvaFacturas           ;
    double  dIvaRetFacturas        ; /* P-MIX-09003 */
    double  dTotalFacturas         ;
    long    lNumFacturasExen       ;
    long    lNumFactAnulExen       ;
    double  dNetoFacturasExen      ;
    double  dExentoFacturasExen    ;
    double  dIvaFacturasExen       ;
    double  dIvaRetFacturasExen    ; /* P-MIX-09003 */
    double  dTotalFacturasExen     ;
    long    lNumNotCredito         ;
    long    lNumNotCredAnul        ;
    double  dNetoNotCredito        ;
    double  dExentoNotCredito      ;
    double  dIvaNotCredito         ;
    double  dIvaRetNotCredito      ; /* P-MIX-09003 */
    double  dTotalNotCredito       ;
    long    lNumFacturasElec       ;
    long    lNumFactAnulElec       ;
    double  dNetoFacturasElec      ;
    double  dExentoFacturasElec    ;
    double  dIvaFacturasElec       ;
    double  dIvaRetFacturasElec    ; /* P-MIX-09003 */
    double  dTotalFacturasElec     ;
    long    lNumFacturasElecExen   ;
    long    lNumFactAnulElecExen   ;
    double  dNetoFacturasElecExen  ;
    double  dExentoFacturasElecExen;
    double  dIvaFacturasElecExen   ;
    double  dIvaRetFacturasElecExen; /* P-MIX-09003 */
    double  dTotalFacturasElecExen ;
    long    lNumBoleta      	   ;
    long    lNumBoletaAnul  	   ;
    double  dNetoBoleta     	   ;
    double  dExentoBoleta   	   ;
    double  dIvaBoleta      	   ;
    double  dIvaRetBoleta      	   ; /* P-MIX-09003 */
    double  dTotalBoleta    	   ;
    long    lNumBoletaExen         ;
    long    lNumBoletaExenAnul     ;
    double  dNetoBoletaExen        ;
    double  dExentoBoletaExen      ;
    double  dIvaBoletaExen         ;
    double  dIvaRetBoletaExen      ; /* P-MIX-09003 */
    double  dTotalBoletaExen       ;
    long    lNumBoletaAmis         ;
    long    lNumBoletaAmisAnul     ;
    double  dNetoBoletaAmis        ;
    double  dExentoBoletaAmis      ;
    double  dIvaBoletaAmis         ;
    double  dIvaRetBoletaAmis      ; /* P-MIX-09003 */    
    double  dTotalBoletaAmis       ;
    
    
}GACUMULADOR;

/************************************************************************/
/*   Estructura para Contabilizar Totales Finales por Tipo de Documento.        */
/************************************************************************/

typedef struct tagTotAcumuladores
{
    long    lNumFacturas           ;
    long    lNumFactAnul           ;
    double  dNetoFacturas          ;
    double  dExentoFacturas        ;
    double  dIvaFacturas           ;
    double  dIvaRetFacturas        ; /* P-MIX-09003 */
    double  dTotalFacturas         ;
    long    lNumFacturasExen       ;
    long    lNumFactAnulExen       ;
    double  dNetoFacturasExen      ;
    double  dExentoFacturasExen    ;
    double  dIvaFacturasExen       ;
    double  dIvaRetFacturasExen    ; /* P-MIX-09003 */
    double  dTotalFacturasExen     ;
    long    lNumNotCredito         ;
    long    lNumNotCredAnul        ;
    double  dNetoNotCredito        ;
    double  dExentoNotCredito      ;
    double  dIvaNotCredito         ;
    double  dIvaRetNotCredito      ; /* P-MIX-09003 */    
    double  dTotalNotCredito       ;
    long    lNumFacturasElec       ;
    long    lNumFactAnulElec       ;
    double  dNetoFacturasElec      ;
    double  dExentoFacturasElec    ;
    double  dIvaFacturasElec       ;
    double  dIvaRetFacturasElec    ; /* P-MIX-09003 */
    double  dTotalFacturasElec     ;
    long    lNumFacturasElecExen   ;
    long    lNumFactAnulElecExen   ;
    double  dNetoFacturasElecExen  ;
    double  dExentoFacturasElecExen;
    double  dIvaFacturasElecExen   ;
    double  dIvaRetFacturasElecExen; /* P-MIX-09003 */    
    double  dTotalFacturasElecExen ;
    long    lNumBoleta       	   ;
    long    lNumBoletaAnul  	   ;
    double  dNetoBoleta            ;
    double  dExentoBoleta   	   ;
    double  dIvaBoleta      	   ;
    double  dIvaRetBoleta      	   ; /* P-MIX-09003 */
    double  dTotalBoleta    	   ;
    long    lNumBoletaExen         ;
    long    lNumBoletaExenAnul     ;
    double  dNetoBoletaExen        ;
    double  dExentoBoletaExen      ;
    double  dIvaBoletaExen         ;
    double  dIvaRetBoletaExen      ; /* P-MIX-09003 */
    double  dTotalBoletaExen       ;
    long    lNumBoletaAmis         ;
    long    lNumBoletaAmisAnul     ;
    double  dNetoBoletaAmis        ;
    double  dExentoBoletaAmis      ;
    double  dIvaBoletaAmis         ;
    double  dIvaRetBoletaAmis      ; /* P-MIX-09003 */    
    double  dTotalBoletaAmis       ;
}GACUMULADORFINAL;


/************************************************************************/
/*   Estructura para Contabilizar Totales por Tipo de Facturas          */
/************************************************************************/

typedef struct tagTotTipDocum
{
    long    lNumDocumentosOk  ;
    long    lNumDocumentosAnul;
    double  dNetoDocumentos   ;
    double  dExentoDocumentos ;
    double  dIvaDocumentos    ;
    double  dIvaRetDocumentos ; /* P-MIX-09003 */    
    double  dTotalDocumentos  ;
}GTOTTIPDOCUM;

typedef struct tagTotTipDocumFinal
{
    long    lNumDocumentosOkFinal  ;
    long    lNumDocumentosAnulFinal;
    double  dNetoDocumentosFinal   ;
    double  dExentoDocumentosFinal ;
    double  dIvaDocumentosFinal    ;
    double  dIvaRetDocumentosFinal ; /* P-MIX-09003 */
    double  dTotalDocumentosFinal  ;
}GTOTTIPDOCUMFINAL;

/************************************************************************/
/*   Definiendo Variables y Estructuras Globales                        */
/************************************************************************/

char              szExeLibro             [1024];
char              szNomRepLegal           [131];
char              szRutRepLegal            [21];
char              szTipParametro           [33];
char              szValParametro          [512]; 
int               iCodBoletaAuto               ;
int               iCodBoletaAutoExen           ;  
int               iCodNotaAbono                ; /* P-MIX-09003 */
int		  iIndPrefFolio                ;
int               iCodFacturaOLD           = 28;  
LINEACOMANDO      stLineaComando               ;
GACUMULADOR       stAcumulador                 ;
GACUMULADORFINAL  stAcumuladorFinal            ;
GTOTTIPDOCUM      stTotTipDoc    [NUM_TIPDOCUM];
GTOTTIPDOCUMFINAL stTotTipDocFin [NUM_TIPDOCUM];

/************************************************************************/

#undef access

#ifdef _LIBROC_C_
#define access

int     ifnGetParametro2                  ( int iCodParametro, char *szTipParametro, char *szValParametro );

#else
#define access extern
#endif

static  BOOL bfnOraGenLibro               ( LINEACOMANDO stLineaComando);
static  BOOL bfnGetHistClie               ( GHISTCLIE *pstGHistClie, LINEACOMANDO stLineaComando);
static  int  ifnOpenDocumentos            ( int iTipDocumento, char *szFecInicio,
                                            char *szFecFin,LINEACOMANDO stLineaComando);
static  int  ifnFetchDocumentos           ( int iTipDocumento,GHISTDOCU *pstGHistDocu,
                                            LINEACOMANDO stLineaComando);
static  BOOL bfnCloseDocumentos           ();
static  BOOL bfnInsertaLibroIva           ( GHISTDOCU pstGHistDocu,BOOL *bInsert,char *szOrigen);
static  BOOL bfnOficinaVendedor           ( long lCodVendedor);
static  int  ifnOpenConsumos              ( int iTipDocumento, char *szFecInicio,char *szFecFin);
static  int  ifnFetchConsumos             ( int iTipDocumento,GHISTDOCU *pstGHistDocu);
static  BOOL bfnCloseConsumos             ();
static  BOOL bfnInsertaConsumosenLibroIva ( GHISTDOCU pstGHistDocu, BOOL *bInsert);
static  BOOL bfnUpdateIndLibro            ( char *szNomTabla, GHISTDOCU stGHistDocu,
                                            BOOL OptInsert, BOOL BIndica);
static  BOOL bfnLlenaArchivoImpresion     ( char *szFecInicio, char *szFecFin);
static  int  bfnFetchLibroIva             ( GHISTDOCU *stGHistDocu);
static  void bfnEscribeBuffer             ( int iDoc, GHISTDOCU  pstGHistDocu, int *iCargaFile, long lNumReg);
static  BOOL bfnEscribeLibro              ( char *szBuf, int iPag, int iTipDoc,int iMesAux,
                                            int iAnoAux, char *szCodOficina, char *szhDesOficina);
static  BOOL bfnEscribeCab                ( int iPag, int iTipDoc, int iMesAux,
                                            int iAnoAux, char *szCodOficina,char *szhDesOficina);
static  void bfnAcumulaDocumento          ( int iTipDocumento, GHISTDOCU pstGHistDocu );
static  void bfnAcumulaDocumentoFinal     ( int iTipDocumento, GHISTDOCU pstGHistDocu );
static  BOOL bfnEscribeTotDocum           ( int iTipDocumento);
static  BOOL bfnUpdateIndConsumosLibroIva ( GHISTDOCU stGHistDocu, BOOL OptInsert);
static  BOOL bfnEscribeTotLibro           ( int iMesAux, int iAnoAux);
static  BOOL bfnCloseFatDetLibroIva       ();
static  BOOL bfnInsertaDuplicados         ( GHISTDOCU pstGHistDocu, char *szOrigen);
static  BOOL bfnUpdateaIndDuplicado       ( int , char *,long , char *);
static  BOOL bfnConsumos                  ( int iDoc, char *szFecInicio, char *szFecFin);
static  BOOL bfnLeeCodLibroVta            ( int iCodTipDocMov, int *iCodLibroVta );
int	     ifnGetParametro2             ( int iCodParametro, char *szTipParametro, char *szValParametro ); 
BOOL         bfnRecuperaImpuesto          ( int *, int *, int *, int *);
BOOL         bfnValidaTrazaProc2          ( long lCiclParam,int iCodProceso, int iIndFacturacion);
BOOL         bfnRegistroInsertado         ( GHISTDOCU pstGHistDocu);
BOOL bGetParamCodConceptoImpRet           ( char *szValor);
#undef access

#undef _LIBRO_C_

static char *szNombreDocs[]={"0:NONE"
                            ,"FACTURAS AFECTAS "
                            ,"FACTURAS EXENTAS"
                            ,"NOTAS DE CREDITO"
                            ,"FACTURAS ELEC.AFECTA"
                            ,"FACTURAS ELEC.EXENTA"
                            ,"BOLETAS AFECTAS"
                            ,"BOLETAS EXENTAS"
                            ,"BOLETAS AUTO AFECTA"
                            ,"BOLETAS AUTO EXENTA"
                            ,"FACTURA OLD"
                            ,"BOLETA CICLO AFECTA FA"
                            ,"BOLETA CICLO EXENTA FA"
                            ,"NOTAS DE ABONO"
                            ,"14","15","16","17","18","19","20"
                            };

static char *szNombreMes[]={"ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO",
                            "JUNIO", "JULIO","AGOSTO", "SEPTIEMBRE", "OCTUBRE",
                            "NOVIEMBRE", "DICIEMBRE" };
static char szUsage[]=
    "\nUso:  LibroVenta   -u Usuario/PassWord Opciones  "
    "\n\t\t -l Nivel de Log                             "
    "\n\t\t Opciones :                                  "
    "\n\t\t -c Ciclo de Facturacion                     "
    "\n\t\t -n No Ciclo                                 "
    "\n\t\t\t -m Mes(2) -a Ano(4) -d Tipo Documento     " 
    "\n\t\t -h Historico                                "
    "\n\t\t\t -m Mes(2) -a Ano(4)                       "
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

