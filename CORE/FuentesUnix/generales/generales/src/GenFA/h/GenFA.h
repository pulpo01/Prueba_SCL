/*******************************************************************************
Fichero:      GenFA.h
Descripcion:  Declaracion de tipos y prototipos de GenFA.pc
Fecha:        30/01/96
Autor:        Javier Garcia Paredes
*******************************************************************************/

#ifndef _GENFA_H_
#define _GENFA_H_

#define SIZE_HOSTARRAY	    10000
#define iCOD_DISPLAY		3
#define cSEPARADOR_DOSPUNTOS  ':'

#include <deftypes.h>
#include <StFactur.h>
#include <predefs.h>
#include <errores.h>
#include <trazafact.h>
#include <rutinasgen.h>
#include <geora.h>
#include <New_Interfact.h>


/* ----- Datos Generales Facturacion (FA_DATOSGENER) ----- */

typedef struct TagDatosGener {
    char  szCodDollar        [4];
    char  szCodUf            [4];
    char  szCodPeso          [4];
    int   iCodIva               ;
    float fPctIva               ;
    char  szCodMoneFact      [4];
    char  szIndOrdenTotal   [13];
    int   iCodAbonoCel          ;
    int   iCodAbonoBeep         ;
    int   iCodAbonoTrek         ;
    int   iCodAbonoTrunk        ;
    int   iCodAbonoFinCel       ;
    int   iCodAbonoFinBeep      ;
    int   iCodAbonoFinTrek      ;
    int   iCodAbonoFinTrunk     ;
    int   iCodRecargo           ;
    int   iCodContado           ;
    int   iCodCiclo             ;
    int   iCodBaja              ;
    int   iCodNotaCre           ;
    int   iCodNotaDeb           ;
    int   iCodMiscela           ;
    int   iCodCompra            ;
    int   iCodLiquidacion       ;
    int   iCodRentaPhone        ;
    int   iCodRoamingVis        ;
    char  szPathBin        [256];
    char  szDirReports      [51];
    char  szDirSpool       [101];
    char  szDirLogs        [256];
    char  szCodPlanTarif     [4];
    char  szCodCodelco       [4];
    short iCodEmpresa           ;/* Ge_DatosGener */
    long  lCodClienteStartel    ;
    char  szDesEmpresa      [21];
    long  lCodAgenteStartel     ;
    int   iCodCatImpos          ;
    int   iCodConcIva           ;
    char  szRut             [21];
    short iProdCelular          ;
    short iProdBeeper           ;
    short iProdTrek             ;
    short iProdTrunk            ;
    short iProdGeneral          ;
    int   iCodCatImposDef       ;
    char  szNomUsuaDBA      [31];/* Ge_DatosGener */
    char  szMonedaCobros    [4] ;/* Co_DatGen     */
    int   iCodFactura           ;
    char  szOficinaPago      [3];
    int   iDocRegalo            ;
    int   iDocStaff             ;
    char  szLetraCobros      [2];
    long  lAgenteInterno        ;
    int   iSisPagoRegalo        ;
    int   iCauPagoRegalo        ;
    int   iOriPagoRegalo        ;
    char  szCodOficCentral   [3];
    int   iNumDiasBaja          ;
    long  lCodCicloDocPuntual   ;
    int   iCodFacturaExen       ;
    int   iCodBoleta	        ;
    int   iCodBoletaExen	;
    int   iCodConsignacion      ;
    int   iNCredConsignacion    ;
    long  lIndValImporte        ;
    long  lMontoImporte         ;
    long  lInfoCiclo            ;
    long  lInfoMes              ;
    long  lCantCiclos           ;
    char  szNitOperadora    [16];
    char  szClaConTecnico   [41];
    int   iCodNotaAbo           ; /* P-MIX-09003 */
} DATOSGENER;

typedef struct tagEstTotal
{
    int    iNumClientes  ;
    int    iRegProcesados;
    int    iRegCorrectos ;
    int    iRegAnomalos  ;
    int    iNumErrores   ;
    double dImpProcesados;
    double dImpCorrectos ;
    double dImpAnomalos  ;
}ESTTOTAL;

typedef struct tagEstadist
{
    int    iNumProcesad ;
    double dImpProcesad ;
    int    iNumCorrectos;
    double dImpCorrectos;
    int    iNumAnomalias;
    double dImpAnomalias;
}ESTADIST;

typedef struct tagDireccion
{
    char    szCampo[SIZE_HOSTARRAY][254];

} rg_direcciones;



#define iPRECISION  0
#define iPRECISION0 0
#define iPRECISION1 1
#define iPRECISION2 2
#define iPRECISION3 3

#define iUSO0 0
#define iUSO1 1
#define iUSO2 2
#define iUSO3 3

#undef access
#ifdef _GENFA_PC_
#define access
#else
#define access extern
#endif /*_GENFA_PC_*/

/****************************************/
/* Incorporado por PGonzaleg 20-05-2002 */
/*	-Eliminacion de Warnings-       */
/*		Desde aqui		*/
/****************************************/

access BOOL   bfnFindComuna (COMUNAS  *,int);
access BOOL   bfnFindCiudad (CIUDADES *,int);

/****************************************/
/* Incorporado por PGonzaleg 20-05-2002 */
/*	-Eliminacion de Warnings-       */
/*		Hasta aqui		*/
/****************************************/

access void   vInitEstructuras             ( void );
access BOOL   bfnDBGetCiclFact             ( CICLO * );
access BOOL   bfnDBGetCiclo                ( CICLO * );
access BOOL   bfnDBUpdateCiclo             ( char *, int );
access BOOL   bfnGetProceso                ( PROCESO * );
access BOOL   bGetSysDate                  ( char* );
access void   vPrintRegInsert              ( int iIndice,char *szFuncion,BOOL );
access BOOL   bfnGetDir_Formato            ( long lCodCliente, int iCodTipSujeto, int iCodTipDireccion, 
                                             int iCodDisplay, char * Imprime );
access char   *fnQuitaBlancos              ( char s[] );
access BOOL   bGetNumProceso               ( long* );
access int    iGetLocalizacionVenta        ( long,char*,char*,char* );
access BOOL   bGetVenta                    ( VENTAS * );
access BOOL   bGetTransContado             ( TRANSCONTADO * );
access void   vGetFecCFAnt                 ( CICLO* );
access int    iCmpCiclFact                 ( const void*,const void* );
access BOOL   bFindCiclFact                ( CICLO * );
access void   vPrintCiclFact               ( CICLO* ,int );
access int    iCmpCiudades                 ( const void*,const void* );
access int    iCmpComunas                  ( const void*,const void* );
access int    iCmpRegiones                 ( const void*,const void* );
access int    iCmpProvincias               ( const void*,const void* );
access BOOL   bFindRegiones                ( REGIONES * );
access BOOL   bFindProvincias              ( PROVINCIAS * );
access int    iCmpCargoRecurrente          ( const void*,const void* ) ;
access BOOL   bFindCargoRecurrente         ( CARGOSRECURRENTES * );
access BOOL   bFindOverrideSS              ( long lCodCliente, long lNumAbonado, char *szCodServicio, 
                                             double *dImporteOverride ); /* P-MIX-09003 XX */
access BOOL   bFindOverridePA              ( long lCodCliente, long lNumAbonado, long lCodCargoContratado, double *dImporteOverride,  long lCodProductoContratado);  /* PGG - 144781 | 144241 - 03-09-2010 - SE AGREGA NUEVA PARAMETRO PARA OVERRIDE */
access BOOL   bFindOverrideCB              ( long lCodCliente, long lNumAbonado, char *szCodCargoBasico, 
                                             double *dImporteOverride); /* P-MIX-09003 XX */
access BOOL   bFindGrupoCob                ( GRUPOCOB * );
access void   vPrintGeImpuestos            ( IMPUESTOS *,int );
access BOOL   bfnGetIndCliente             ( FACTCLI *pFactCli );
access BOOL   bGetDatosGener               ( DATOSGENER *,char * );
access void   vPrintDatosGener             ( void );
access BOOL   bGetCodPlanCom               ( long ,int ,long * );
access BOOL   bfnCargaParamError           ( void );
/****************************************************************/
/* access BOOL   bActualizaIndFacCiclo (long,int,int)    ;      */
/* Solo necesita Codigo de Ciclo de Facturacion COD_CICLFACT    */
/* Para Validar Traza del Proceso                               */
/* Ya no actualiza IND_FACTURACION FA_CICLFACT                  */
/****************************************************************/

access BOOL   bActualizaIndFacCiclo        ( long lCodCiclFact,int iIndicador, char *szHostId, 
                                             int iExisteRngClie, long lClieIni, long lClieFin );
access BOOL   bGetMaxColPreFa 		   ( int Conc,long *Columna );
access void   vFreeMaxColPreFa 		   ( void );
access BOOL   bFindConcepto 		   ( int,CONCEPTO* );
access int    iCmpConceptos_mi 		   ( const void*, const void* );
access BOOL   bFindConcepto_mi 		   ( int,char*,CONCEPTO_MI* );
access int    iCmpCuadCtoPlan 		   ( const void*, const void* );
access int    bFindCuadCtoPlan 		   ( long lCodCtoPlan,double dImp,CUADCTOPLAN * );
access int    iCmpGrpSerConc 		   ( const void*,const void* );
access BOOL   bFindGrpSerConc 		   ( int ,GRPSERCONC * );
access void   vPrintGrpSerConc		   ( GRPSERCONC *,int );
access int    iCmpZonaCiudadFec		   ( const void*, const void* );
access int    iCmpZonaCiudad  		   ( const void*, const void* );
access BOOL   bFindZonaCiudad 		   ( char*,char*,char*,char*,int* );
access BOOL   bConverMoneda		   ( char *MonedaO,char *MonedaD,char *Fecha,
                            		     double *Imp,int iTipoFact );
access BOOL   bConversionMoneda		   ( long lCodCliente, char *MonedaO,char *MonedaD,char *Fecha,
                            		     double *Imp);                            		     
access BOOL   bRedondeoMoneda		   ( char *MonedaO,char *Fecha,double *Imp,
                              		     int iTipoFact );
access int    iCmpConversion 		   ( const void*, const void* );
access BOOL   bFindConversion 		   ( char *,char *,double * );
access void   vPrintConversion 		   ( CONVERSION*, int );
access int    iCmpTarifas 		   ( const void* ,const void* );
access void   vPrintTarifas 		   ( TARIFAS *,int );
access int    iCmpGrupoCob 		   ( const void*,const void* );
access void   vPrintGrupoCob 		   ( GRUPOCOB *,int );
access int    iCmpCatImpCliente            ( const void*,const void* );
access void   vPrintCatImpCliente          ( CATIMPCLIENTES *, int ) ;
access BOOL   bGetCatImpCliente            ( long,int*,char*,int );
access BOOL   bChangeIndEstadoPro          ( long lNumProceso,int, int );
access BOOL   bSetNumFactura               ( int   iTipoFact,
                                             TRANSCONTADO *, VENTAS * );
access BOOL   bGenNumSecuenciasEmi         ( int, char*, int, long* );
access BOOL   bInsertaProceso              ( PROCESO stProceso );
access int    iCmpLetras                   ( const void*,const void* );
access void   vPrintLetras                 ( LETRAS *,int );
access BOOL   bGetLetra                    ( int,int,char* );
access int    iCmpDocumSucursal            ( const void*,const void* );
access void   vPrintDocumSucursal          ( DOCUMSUCURSAL *,int );
access BOOL   bGetCentrEmi                 ( char *,int,int * );
access BOOL   bGetConcOrig                 ( int ,char*,char*,int * );
access void   vInitAnomProceso             ( ANOMPROCESO * );
access BOOL   bGenProcesoII                ( void );
access BOOL   bRestaFechas                 ( char* ,char* ,int * );
access void   vEligeDirLogs                ( char* szLog, char* szErr,int iTipoFact );
access BOOL   bGetUltimoCliPro             ( int, long, int, long *,long * );
access int    iCmpRangoTabla               ( const void*,const void* );
access BOOL   bfnGetDirecCli               ( long lCodCliente, int );
access BOOL   bfnGetDatosCliente           ( long lCodCliente );
access void   vDatosFinTiempo              ( void );
access void   vDatosInicialesTiempo        ( void );
access void   vPreparacionSenales          ( void );
access BOOL   bfnGetDatosUsuario           ( long, char*, char*, char* );
access BOOL   bfnGetDatosAbo               ( CICLOCLI *, ENLACEHIST, BOOL );
access BOOL   bfnTotCargosMe               ( long, long, double * );
access BOOL   bfnEncAbonadoCicloCli        ( long );
access BOOL   bfnCargaAbonoCli             ( ENLACEHIST, BOOL );
access void   vfnFreeCicloCli              ( void );
access BOOL   bfnDBUpdateIndImpresa        ( HISTDOCU, int);
access BOOL   bfnConsumeFolio 	           ( char *szCodOficina	, int iCodTipDocum, char *szCodOperadora, 
                                             long lNumProceso, char *szFechaFol, long *plNumFolio, char *szPrefPlaza );
access BOOL   bfnDBInsertConsumoDocumentos ( char *,int,long,char*,char* );
access BOOL   bfnDBGetFolio                ( char *, int, char *,long* );
access BOOL   bfnDBUpdateFolio             ( char * )                   ;
access BOOL   bfnAsigNumFolio              ( char *, int, char *,long* );
access void   vfnHandlerFile               ( int )                      ;
access char   *szfnDigVerificador          ( char * );
access BOOL   bfnGetBcoUniPac              ( long lCodCliente, char *szCodBanco );
access BOOL bGetParamGener                 ( DATOSGENER* pstDatosGener );
access BOOL bGetParamImporte               ( DATOSGENER* pstDatosGener );
access BOOL bGetParamConsumo               ( DATOSGENER* pstDatosGener );
access BOOL bGetNitOperadora               ( DATOSGENER* pstDatosGener );
access BOOL bGetClaConTecnico              ( DATOSGENER* pstDatosGener );
access BOOL bGetTipDocNotaAbo              ( DATOSGENER* pstDatosGener ); /* P-MIX-09003 */
access BOOL bGetCatTribCliente             ( long  lCodCliente, char *szCodCatTribut, char *szFecha );
access BOOL bInsertPreFactura 	           ( void );
access BOOL RecupParam		           ( int  *iNumParam, char *argv[], char *szCadena, int  chr );
access int ifnCmpOficinas	           ( const void *cad1, const void *cad2 );
access BOOL bfnFindOficina 	           ( char *szCodOficina, OFICINA *pstOficina );
access int ifnCmpFactCobr	           ( const void *cad1,const void *cad2 );
access BOOL bfnFindFactCobr 	           ( int iCodConcFact, int iFactCobr );/* Inc. 192437 18-02-2013 PPQL  se cambia *iFactCobr por  iFactCobr*/
access BOOL bfnGetFadParam 	           ( void );
access BOOL bFindPlanTarif 	           ( int   iCodProducto, char *pszCodPlanTarif, PLANTARIF  *lstPlanTarif );

/*---------------- Estructuras Globales al Modulo de Facturacion ------------*/
access DATOSGENER   stDatosGener   ;
access MAXCOLPREFA  stMaxColPreFa  ;
access CODCONCSERVS pstConcServ    ; 
access CLIENTE      stCliente      ;
access FACTCLI      stFactCli      ;
access CICLO        stCiclo        ;
access ABONOCLI     stAbonoCli     ;
access PREFACTURA   stPreFactura   ;
access NOTACD       stNota         ;
access IND_HISTCONC IndHistConc    ;
access VENTAS       stVenta        ;
access TRANSCONTADO stTransContado ;

access INTERFACT    stInterFact    ; /*  Estructura de Registro de FA_INTERFACT     */
access INTPROCESOS  stInterProc    ; /*  Estructura de Registro de FA_INTPROCESOS   */
access INTQUEUEPROC stIntQueueProc ; /*  Estructura de Registro de FA_INTQUEUEPROC  */

access HISTABOP     stHistAboCel   ;

access ACUMPROD     stAcumProd     ;


/* ************************************* */

access HISTCLIE     stHistClie     ;
access HISTDOCU     stHistDocu     ;

access C_CIUDADES   C_stCiudades   ;
access C_COMUNAS    C_stComunas    ;
access CORREO       stCorreo       ;

access ESTTOTAL     stEstTotCar    ;
access ESTTOTAL     stEstTotSac    ;
access ESTTOTAL     stEstTotTar    ;

access ESTADIST     stEstCargos    ;
access ESTADIST     stEstAbonos    ;

access rg_direcciones   Direcciones ;


/* TOL  */

access tagACUMTOL		stTOL_Acumoper;
access tagTOLPROMO		stTOL_PROMO;
access tagTOLDCTO		stTOL_DCTO;
access tagTOLPROMODCTO_MI	stTOL_PROMODCTO_MI;
access tagTOLDescripcion	stTOL_DESC;


/* Identificador de proceso para estadisticas */
access pid_t IdSta;

access long lCodClienteIni;
access long lCodClienteFin;

/* Datos Estadisticos de tiempo */
access clock_t cpu_ini ,cpu_fin                ;
access time_t  real_ini,real_fin               ;
access struct  tms tms                         ;
access float   cpu, real                       ;
access void    vfnLimpiarRegs                  ( long lRegIni, long lRegFin );
access BOOL    bfnIncrementarIndicePreFactura  ( void );
access BOOL    bFindCargoBasico                ( char *szCodCargoBasico, CARGOSBASICO * pstCargoBasico );
access char    *szGetFecZonaImp	               ( int iTipoFact );

/* access BOOL bInsertaAnomProceso (ANOMPROCESO* pAnomProc); */
/************************************************************/
/*   Definicion de Constante de Tipo de Tasacion            */
/*   SAAM-20021230                                          */
/************************************************************/
#ifndef TIPO_TASA_CLASICA
#define TIPO_TASA_CLASICA 0
#endif

#ifndef TIPO_TASA_ON_LINE
#define TIPO_TASA_ON_LINE 1
#endif

#undef access

#endif /*_GENFA_H_*/
