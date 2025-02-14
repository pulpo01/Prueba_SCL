/*****************************************************************************/
/* Fichero     : New_Interfact.h                                             */
/* Descripcion : Declaracion de tipos y funciones                            */
/*****************************************************************************/

#ifndef _INTERFACT_H_
#define _INTERFACT_H_

/****************************************************/
/*                 FA_INTPROCESOS                   */
/****************************************************/
#define     iPROCESO_INT_FACTURACION            200
#define     iPROCESO_INT_IMPRESION              300
#define     iPROCESO_INT_IMPRESION_BATCH        310
#define     iPROCESO_INT_FOLIACION              400
#define     iPROCESO_INT_FOLIACION_BATCH        410
#define     iPROCESO_INT_FOLIACION_CONSIG       420
#define     iPROCESO_INT_VISACION               500
#define     iPROCESO_INT_VISACION_BATCH         510
#define     iPROCESO_INT_PASOCOBROS             600
#define     iPROCESO_INT_PASOCOBROS_BATCH       610
#define     iPROCESO_INT_PASOHISTORICO          700
#define     iPROCESO_INT_PASOHISTORICO_BATCH    710
#define     iPROCESO_INT_CIERRE                 800 
#define     iPROCESO_INT_LIBROVENTA             900
    
/****************************************************/
/*                 FA_INTESTADOC                    */
/****************************************************/
#define     iESTADOC_PROCESO                    0
#define     iESTADOC_INGRESADA                  100
#define     iESTADOC_FACTUDADA                  200
#define     iESTADOC_IMPRESA                    300
#define     iESTADOC_FOLIADA                    400
#define     iESTADOC_VISADA                     500
#define     iESTADOC_INTERCALADA                600
#define     iESTADOC_CERRADA                    800
#define     iESTADOC_ANULADA                    900

/****************************************************/
/*                 CONSTANTES                       */
/****************************************************/
#define     iESTAPROC_SINPROCESAR               0
#define     iESTAPROC_PROCESANDO                1
#define     iESTAPROC_TERMINADO_ERROR           2
#define     iESTAPROC_TERMINADO_OK              3

#define     iESTAQUEUE_WAIT           		1
#define     iESTAQUEUE_INIT            		2
#define     iESTAQUEUE_RUNNING       		3
#define     iESTAQUEUE_ERROR          		4


#define     SNAPSHOT                            1555

#define     sPERIODOS_NOTA_ABONO                "PERIODOS_NOTA_ABONO"     
#define     sCOD_DOCUM_CCF                      "COD_DOCUM_CCF"
#define     sCOD_DOCUM_NA                       "DOCUMENTO NOTA DE ABONO"

#undef access
#ifdef _INTERFACT_PC_
#define ACCESS

#ifdef SQLNOTFOUND
#undef SQLNOTFOUND
#endif

#define     SQLNOTFOUND                         1403 	/* Ansi :100 ; Not ansi : 1403 */

#else
#define access extern

#endif  /*_INTERFACT_PC_*/
    

/******************************************************************************
 Estructura para recoger los datos de la tabla FA_INTERFACT
*******************************************************************************/

typedef struct tagFA_INTERFACT
{
        long    lNumProceso         ;        
        int     lNumVenta           ;
        char    szCodModGener   [4] ;
        int     iCodEstaDoc         ;
        int     iCodEstaProc        ;
        int     iCodTipMovimien     ;
        char    szCodCaTribut   [2] ;
        int     iTipImpositiva      ;
        int     iCodModVenta        ;
        int     iNumCuotas          ;
        int     iCodTipDocum        ;
        long    lNumFolio           ;
        long    lNumFolioRel        ;
        char    szFecIngreso    [20];
        char    szFecFacturacion[20];
        char    szFecImpresion  [20];
        char    szFecFoliacion  [20];
        char    szFecVisacion   [20];
        char    szFecPasoCobro  [20];
        char    szFecCierre     [20];
        char    szFecVencimiento[20];
        char	szCodAplic	[4] ;   
        char	szPrefPlaza	[25+1];	
        char	szPrefPlazaRel	[25+1];	
}INTERFACT;


/******************************************************************************
 Estructura para recoger los datos de la tabla FA_INTPROCESOS
*******************************************************************************/
typedef struct tagFA_INTPROCESOS
{
        long    lCodProceso         ;
        char    szDesProceso    [31];
        int     iPrioridad          ;
        char    szNomEjecutable [31];
        char	szCodAplic	 [4];  
}INTPROCESOS;

/******************************************************************************
 Estructura para recoger los datos de la tabla FA_INTQUEUEPROC
*******************************************************************************/
#ifdef INTQUEUEPROC
#undef INTQUEUEPROC
#endif
    
typedef struct tagFA_INTQUEUEPROC
{
        char    szCodModGener   [4] ;
        long    lCodProceso         ;
        char    szCodTipProc    [2] ;
        char    szCodActivacion [2] ;
        int     iCodPrioridad       ;
        int     iCodEstado          ;
        char    szFecEstado     [15];
        long    lPidProceso         ;
        char    szNomUsuario    [31];
        char    szPasUsuario    [31];
        int     iCodNivelLog        ;
        int     iTipIntervalo       ;
        long    lNumSegundos        ;
        char    szCodHoraDia    [9] ;
        char    szCodHoraFecha  [15];
        char    szCodHoraIniVig [9] ;
        char    szCodHoraFinVig [9] ;
        int     iNumDeltaHoras      ;
        int     iCodTipUnInter      ;
        int     iCodEstaDocEnt      ;
        int     iCodEstaDocSal      ;
	char	szCodAplic	[4] ;
}INTQUEUEPROC;


access  BOOL bfnInitInterFact           ( int          iCodProcInt,
                                          long         lNumProcInt,
                                          int          iTipoFact        );
access  BOOL bfnGetInterProc            ( INTPROCESOS  *stpIntProcesos  );
access  BOOL bfnGetInterFact            ( INTERFACT    *stpInterFact    );
access  BOOL bfnUpdInterFact            ( INTERFACT    stpInterFact     );
access  BOOL bfnDelInterFact            ( long         lNumProceso,
    					  char         *szCodAplic      );
access  BOOL bChangeCodEstaProcInterfaz ( long         lNumProceso,
                                          int          iTo              );
access  BOOL bfnGetIntQueueProc         ( INTQUEUEPROC *stpIntQueueProc );
access  BOOL bfnGetCodTipDocum          ( INTERFACT    *pstpInterFact,
                                          int          ipTipImpositiva  );
access  BOOL bfnDocCCF                  ( int          iCodTipoDocRel, 
                                          char         *szParamCodTipoDocRel,
                                          int          *iOcurrencias);
access  BOOL bfnCambiaEstCola           ( char         *MGener,
                                          int          CProc,
                                          int          iDesde,
                                          int          iHasta,
                                          char	       *CodAplic	);
access  BOOL bfnGetDifUltEjec           ( char         *szhUltimaVez,
                                          double       *pDiff           );
access  BOOL bfnGetDocumentoRel         ( long         lNumSecuenciRel,
                                          char         *szPrefPlazaRel,
                                          int          *iCodTipoDocRel,
                                          char         *szFecDocRel,
                                          int          *iCantidadMeses  );                                          
access  void vfnPrintQueueProc          ( INTQUEUEPROC stpIntQueueProc  );
access  void vfnPrintInterFact          ( INTERFACT    stpIntFact       );
access  void fnGrabaAnomalia            ( long         lNumProceso,
                                          long         lCod_Cliente, 
                                          char         *szDescrip,
                                          char         *szObsAnomalia   );
access  char *cfnGetTime                ( int          fmto             );
access  int  ifnGetParametro            ( int          iCodParametro,
                                          char         *szTipParametro,
                                          char         *szValParametro  );
access  int  ifnGetCodigosTipDocum      ( int          iCodTipDocumRel);                                          
access  int ifnGetParam                 ( char         *szDesParametro, 
                                          char         *szTipParametro, 
                                          char         *szValParametro );                                                                                   


#endif  /*_INTERFACT_H_*/



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

