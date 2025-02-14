#ifndef _ImpSclFnc_
#define _ImpSclFnc_

/*  Version  FAC_DES_MAS ImpSclFnc.h  7.000   */
#include <ImpSclSt.h>

extern int   BuscaAbonado                 ( ST_ABONADO *,int *,long );     
extern int   CalculaDigVerif              ( double , int *  );
extern int   FillCodIdioma                ( char *);
extern int   FormatoHora                  ( long , int  , char *);
extern int   RecupParam                   ( int *, char *[], char *, int ) ;
extern int   RetPos                       ( char *, ST_TABLA  *);
extern int   bfnAcumulaMontos             ( ST_ACUMMTO *, double, double, double, double );
extern int   bfnElimina_FadCTLImpres      ( LINEACOMANDO *);
extern int   FormateaDireccion            ( char *,char *);
extern int   iMakeDir                     ( char *);
extern int   ObtieneIdiomaOperadora       ( ST_INFGENERAL *);
extern int   OpenMultiIdiomas             ( void );
extern int   CloseMultiIdiomas            ( void);
extern int   ifnCmpGrpMulti               ( const void *cad1,const void *cad2);
extern int   iGetMensajesNoCiclo          ( ST_MENSAJES_NOCICLO * ,long );
extern int   Open_MensNoCiclo             ( long );
extern int   Fetch_MensNoCiclo            ( ST_MENSAJES_NOCICLO * );
extern int   Close_MensNoCiclo            ( void);
extern int   BuscaMascara                 ( DETALLEOPER *,char *,int,int  );
extern int   BuscaCodInterfact            ( long ,long,LINEACOMANDO *);
extern int   ChequeaInterfact             ( LINEACOMANDO );
extern int   busca_arrastre               ( char *,int *,int *);
extern int   CargaArrastre                ( long );
extern int   CargaFadParametros           ( void );
extern int   GargaGedParametros           ( void );
extern int   OpenFactDocuClie             ( LINEACOMANDO *);
extern int   FetchFactDocuClie            ( int * , int * );
extern int   CloseFactDocuClie            ( void);
extern int   buscaMinutoAdicional         ( char *,char *);
extern int   CargaMinutoAdicional         ( void );
extern int   ifnGetNum_Terminales         ( int *Num_Terminales);
extern int   OpenAbonado                  ( long lCiclFact, long lIndOrden);
extern int   FetchAbonado                 ( ST_ABONADO *);
extern int   CloseAbonado                 ( void);
extern int   iTotalizaImpuestoFactura     ( void);
extern int   ifnCmpCodImptoFact           ( const void *cad1,const void *cad2);
extern int   bfnLiberarBenefPromo         ( void);
extern int   bfnCargarBenefPromo          ( long lCodCliente , long lCodCiclFact);
extern int   OpenNumOrden                 ( int iCodFormulario );
extern int   CloseNumOrden                ( void);
extern int   ifnCmpNumOrden               ( const void *cad1,const void *cad2);
extern int   ifnCmpCodImptos              ( const void *cad1,const void *cad2);
extern int   ifnCmpOrden                  ( const void *cad1,const void *cad2);
extern int   ifnLiberaDetCons             ( void);
extern int   ifnLiberaConcDescuentos      ( void);  /* RPL PROY CSR 15-06-2020 definicion de funcion de eliminacion de descuentos */
extern void  suma_errores(long cod_cliente); //RPL PROYC CSR 04-08-2020 SE AGREGA FUNCION DE DOCUMENTOS CON ERROR               
extern BOOL  bEscribeEnArchivo            ( FILE *, char * , char * );
extern BOOL  bfnInsertar_FadCTLImpres     ( ST_ACUMMTO *, LINEACOMANDO *, ST_INFGENERAL *, char *);
extern BOOL  bfnActualiza_ProcImpresion   ( LINEACOMANDO, BOOL );
extern BOOL  bfnActualiza_TrazaProceso    ( LINEACOMANDO, BOOL);
extern BOOL  bfnChequeaEstado             ( LINEACOMANDO *);
extern BOOL  bfnChequeaProcesosPrevios    ( LINEACOMANDO *);
extern BOOL  bfnActualizaRegprocImpres    ( LINEACOMANDO);
extern BOOL  bfnOrdenaImpresionRC         ( ST_TABLA_ACUM  *, ST_TABLA_ORDEN *, int);
extern BOOL  CargaMultiIdiomas            ( GRPMULTIIDIOMA **pstGrpMulti, int *iNumGrpMulti);
extern BOOL  FetchMultiIdiomas            ( GRPMULTIIDIOMAS_HOSTS *pstHost,int *piNumFilas);
extern BOOL  BuscaMultiIdiomas            ( char *szCod_Multiidioma, GRPMULTIIDIOMA *pstGrpMulti );
extern BOOL  bfnCargaGedPar_MC            ();
extern BOOL  bfnTotImptosCateg            ( int iCodConcepto,int iColumna,double *pdTotalPrimeraCategoria, 
                                            double *pdTotalSegundaCategoria );
extern BOOL  bfnCargaCodImptoFact         ( CODIMPTOSFACT *stImp_Fact);
extern BOOL  bfnCargaCodImptoCateg        ( CATIMPUESTOS *st_catImpuestos);
extern BOOL  bfnFindCodImptoFact          ( int iCodConcepto);
extern BOOL  bfnPorcenImptosCateg         ( double *pdTotalPorcenPrimeraCateg, double *pdTotalPorcenSegundaCateg );
extern BOOL  bfnTipoImpuesto              ( int iCodConcepto, int *,double dPrcImpto);
extern BOOL  bfnLimpiaFlag                ( CATIMPUESTOS *st_catImpuestos);
extern BOOL  bfnCargaUltsPagos            ( PAGO **pstPago, int *iNumRegs, long lCodCliente, long lCodCicloFact);
extern BOOL  bfnCargaMinutosPlanes        ( MINPLAN **pstMinPlan, int *iNumRegs);
extern BOOL  bfnCargaTiposImpuestos       ( TIPOIMPUESTO **pstTipoImpuesto, int *iNumRegs); /* P-MIX-09003 77 */
extern BOOL  bfnFindMinPlan               ( char *szCodPlanTarif, char *szCodThor, MINPLAN *pstMinPlan);
extern BOOL  bfnCargaPrimCateg            ( void);
extern BOOL  bfnFindCod_Operador          ( int iCodOperador, CODOPER *pstOper);
extern BOOL  bfnCargaOperadores           ( CODOPER **pstOper, int *iNumOperadores);
extern BOOL  bfnCargarDocsPeriodo         ( DOCPERIODO **pstDocPeriodo, int *iNumRegs, long lCodCliente, 
                                            char *pszFecDesde,char *pszFecHasta);
extern BOOL  bfnCargarTipoDirLlamada      ( void);
extern BOOL  bfnGetPlanTarifAbo           ( long lNumAbonado, long lCodcliente, char *szCodPlanTarifAbo);
extern BOOL  fnGrabaAnoProceso            ( long lCod_Cliente, long lCod_CiclFact, int iCod_Anomalia, 
                                            char *szObs_Anomalia);
extern BOOL  CargaNumOrden                ( NUMORDEN **pstNumOrden, int *iNumRegs, int iCodFormulario );
extern BOOL  FetchNumOrden                ( NUMORDENES_HOSTS *pstHost,int *piNumFilas);
extern BOOL  BuscaNumOrden                ( int iCodConcepto, NUMORDEN *pstNumOrden );
extern BOOL  CargaEstructuraInicial       ( NUMORDEN *pstNumOrden, int iCantOrdenes);
extern BOOL  bfnCategImpto                ( int iCodConcepto, int *,double dPrcImpto);
extern BOOL  bfnBuscaNotaPedido           ( long lNumProceso, char *szNumGuia, long *lNumDocPedido);
extern void  vfnPrintGrpMulti             ( GRPMULTIIDIOMA *pstEstruc, int iNumRegs);
extern void  vfnPrintNumOrden             ( NUMORDEN *pstEstruc, int iNumRegs);
extern void  vfnCargarDesOperador         ( int iCodOperador, char *pszCodTdir, char *pszDesOperador);
extern long  lObtieneNumProcAnomalias     ( void);
static int   ifnOpenRegistrosTipoD        ( void); /* P-MIX-09003 */
static BOOL  bfnFetchRegistrosTipoD       ( REGTIP_D_HOST *,int * ); /* P-MIX-09003 */
static int   ifnCloseRegistrosTipoD       ( void ); /* P-MIX-09003 */
extern BOOL  bfnCargaRegistrosTipoD       ( REGTIP_D **, int * ); /* P-MIX-09003 */
extern BOOL  bfnSumarImpuestos            ( int  iCodTipoImpuesto, long   lIndOrdenTotal,
                                            long lCodCiclFact,     double *dTotalImpuesto);
extern BOOL  bfnFindCodPrestacionAbon     ( long lNumAbonado, char *szCodPrestacionAbon);
extern BOOL  bfnFindMotivo                ( char *szCodTipologia, char *szCodAreaImputable, char *szCodAreaSolicitante,                    
                                            char *szTipologia   , char *szAreaImputable   , char *szAreaSolicitante);

int          ifnCmpCodCliente             ( const void *cad1,const void *cad2);
int          ifnCmpNumAbonado             ( const void *cad1,const void *cad2);
int          ifnOpenCodClientes           ( long lCicloFact);
int          ifnCloseCodClientes          ( void);
int          ifnCmpCod_PlanTarif          ( const void *cad1,const void *cad2);
int          ifnOpenCod_Plantarif         ( void);
int          ifnCloseCod_Plantarif        ( void);
int          ifnCloseDocsPeriodo          ( void);
int          ifnOpenDocsPeriodo           ( long lCodCliente,char *pszFecDesde, char *pszFecHasta);
int          ifnLlenarSeriesDeVenta       ( reg_entrada *pstEntrada );
int          ifnObtenerMontosTotalesCuota ( rg_cuotas pstCuota, double *pdMtoTotDeuda, double *pdMtoSaldoPend, 
                                            int record);
int          ifnObtenerSeriesFactMiscela  ( reg_entrada *pstEntrada);
int          ifnOpenMinPlanes             ( void );
int          ifnOpenTiposImpuestos        ( void ); /* P-MIX-09003 77 */
int          ifnCmpTiposImpuestos         ( const void *cad1,const void *cad2);
int          ifnCmpOperadores             ( const void *cad1,const void *cad2);
int          ifnOpenOperadores            ( void);
int          ifnCloseOperadores           ( void);
int          szfnObtieneCod_autorizacion  ( LINEACOMANDO * ParametrosEntrada);
int          ifnCloseMinPlanes            ( void);
int          ifnCloseTiposImpuestos       ( void); /* P-MIX-09003 77 */
int          ifnCmpMinPlanes              ( const void *cad1,const void *cad2);
BOOL         bfnCargaCodClientes          ( CODCLI **pstCodClie, int *iNumCodCientes, long lCicloFact);
BOOL         bfnFetchCodClientes          ( CODCLI_HOSTS *pstHost,int *piNumFilas);
BOOL         bfnFindCodCliente            ( long lCodigoCliente, CODCLI *pstCodClie, long lCodCiclFact, 
                                            char *szFecEmision);
BOOL         bfnCargaGedPar               ();
BOOL         bfnCargaMinutosPlanes_MC     ( MINPLAN **pstMinPlan, int *iNumRegs);
BOOL         bfnCargaCod_Plantarif        ( PLAN_TARIFARIO **pstCodPlanTarif, int *iNumCodPlanes);
BOOL         bfnFetchCod_Plantarif        ( PLAN_TARIFARIO_HOSTS * pst_PlanTarifario, int *iCantPlanes);
BOOL         bfnFindCod_PlanTarif         ( char *szCodPlanTarif, PLAN_TARIFARIO *pstCodPlanTarif);
BOOL         bfnFetchDocsPeriodo          ( DOCPERIODO_HOSTS *pstHost,int *piNumFilas);
BOOL         bfnFetchMinPlanes            ( MINPLAN_HOSTS *pstHost,int *piNumFilas);
BOOL         bfnFetchTiposImpuestos       ( TIPOSIMPUESTOS_HOSTS *pstHost,int *piNumFilas); /* P-MIX-09003 77 */
BOOL         bfnFetchOperadores           ( CODOPER_HOSTS *pstHost,int *piNumFilas);
BOOL         bfnGetGedParam               ( char * pszNomParam, char *pszCodModulo, char *pszValParam);
BOOL         bfnFindFactura               ( long lCodigoCliente, char *szNombreCliente, long lCodCiclFact, 
                                            char *szFecEmision, char *szNumIdent, long lNumVenta);
void         vfnPrintCodClientes          ( CODCLI *pstCodClie, int iNumCodCientes);
void         vfnPrintCod_PlanTarif        ( PLAN_TARIFARIO *pstCodPlanTarif, int iNumCodPlanes);
void         vfnPrintPagos                ( PAGO *pstPago, int iNumRegs);
void         vfnPrintOperadores           ( CODOPER *pstCodClie, int iNumFilas);
void         vfnPrintMinPlanes            ( MINPLAN *pstMinPlan, int iNumRegs);
void         vfnPrintTiposImpuestos       ( TIPOIMPUESTO *pstTipoImpuesto, int iNumRegs);

char         *ltrim                       ( char *s);
char         *rtrim                       ( char *s);
char         *alltrim                     ( char *s);

static int   ifnClosePagos                ( void);
static BOOL  bfnFetchPagos                ( PAGO_HOSTS *pstHost,int *piNumFilas);
static int   ifnOpenPagos                 ( long lCodCliente, long lCodCicloFact);

BOOL         bfnFindPrefoliados           ( long lIndOrdenTotal, char *szPrefoliados,
                                            char *szResolucionPre, char *szSerie,
                                            int  *iCodTipDocumPre, char *szEtiquetaPre,
                                            long *lNumFolioPre);

#endif

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

