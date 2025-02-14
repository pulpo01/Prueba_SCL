#ifndef _ImpresionScl_
#define _ImpresionScl_

/*  Version  FAC_DES_MAS ImpresionScl.h  7.000   */ 
#include <ImpSclFnc.h>
#include <shared_memory.h>

#define TABLA_MEMORIA  1
#define TABLA_CLIENTES 2
#define TABLA_NUMORDEN 3
#define TABLA_CODCLI   4

/***************************************************************************
                  Definicion de Funciones Prototipos
***************************************************************************/
/************************************************************************
                  FUNCIONES DE MEMORIA COMPARTIDA           
*************************************************************************/

extern int  separacion_de_memoria     ( int id_tabla);
extern int  unir_a_memoria            ( int max,int id_tabla);
extern int  crear_semaforo            ( int id_tabla);
extern int  get_cliente               ( int sem_id,int total_regs);
extern int  marca_cliente_facturado   ( int sem_id,int puntero);
extern int  ManejoArchImp_MC          ( ST_FACTCLIE *FactDocuClie,LINEACOMANDO *ParEntrada,ST_CICLOFACT *sthFa_CicloFact,
                                        ST_INFGENERAL *sthFa_InfGeneral,DETALLEOPER *stMascaraOper,FILE **Fd_ArchImp ,
                                        char *szNombreArchivo);
extern int  CargaInfCliente_MC        ( ST_FACTCLIE * FacCli,LINEACOMANDO * Param,ST_MENSAJES * Mensajes,
                                        ST_MENSAJES_NOCICLO * Mensajes_NoCiclo,STSALDO_ANTERIOR * Saldo,
                                        ST_CICLOFACT * CicloFact,ST_CUOTAS * pstFaCuotas,ST_INFGENERAL * pstInfGeneral,
                                        DETALLEOPER * pst_MascaraOper);
extern int  CargaFadParametrosMC      ();
extern int  CargaFadParametros_GED_MC ();
extern int  bCargaMascaraOperadora_MC ( DETALLEOPER *pst_MascaraOper);
extern int  GetCiclFact_MC            ( ST_CICLOFACT * pstCicFact,long lCodCiclFact);
extern int  bfnCargaCod_Plantarif_MC  ( PLAN_TARIFARIO **pstCodPlanTarif, int *iNumCodPlanes);
extern int  CargaMinutoAdicional_MC   ();
extern int  bfnCargaOficinas2_MC      ( OFICINA2 **pstOfici2, int *iNumOficinas);
extern int  bfnCargaOperadora_MC      ( OPERADORA **pstOper, int *iNumOperadoras);
extern int  bfnCargaTipDocum_MC       ( TIPDOC **pstTipDoc, int *iNumTipDocs);
extern int  bfnCargaCodClientes_MC    ( CODCLI **pstCodClie, int *iNumCodCientes, long lCicloFact);
extern int  bfnCargaVendedores_MC     ( VENDEDOR **pstVendedor, int *iNumVendedores);
extern int  bCargaConceptosTar_MC     ( CONCEPTOS_TAR *pstConceptos);
extern BOOL CargaNumOrden_MC          ( NUMORDEN **pstNumOrden, int *iNumRegs, int iCodFormulario );                                        
extern void muestra_registro          ();
extern void muestra_registro_mc       ();
extern void muestra_parametros        ();
extern void muestra_parametros_ged    ();
extern void muestra_plan_tarifario    ();
extern void muestra_oficina_hosts2    ();
extern void muestra_vendedor_hosts2   ();
extern void muestra_tipdoc            ();
extern void muestra_ciclofact         ();
extern void muestra_operadora_hosts   ();
extern void muestra_conceptos_tar     ();
extern void muestra_codcli_hosts      ();
extern void muestra_detalleoper       ();
extern void muestra_minutoadicional   ();
extern void muestra_tabla_comandos    ();


/***************************************************************************
                prototipos de ImpSclA
***************************************************************************/
extern int  iUpdateFatBalance   ( long , ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *,ST_BALANCE *);
extern int  PutCaratula         ( ST_FACTCLIE *,FILE *,ST_MENSAJES *,ST_MENSAJES_NOCICLO *,
                                  STSALDO_ANTERIOR *,ST_CUOTAS *,ST_CICLOFACT *,DETALLEOPER *,
                                  char *,ST_BALANCE *, TIPOSIMPUESTOS *,long);
extern int  iGetMensajesCliente ( long , char *, ST_MENSAJES * , int *, int , char * );
extern int  iUpdateFactDocu     ( long , ST_FACTCLIE *, STSALDO_ANTERIOR *, ST_CUOTAS *, ST_BALANCE *,ST_ACUMMTO * );
/* RPL 07-04-2020 SE CAMBIA DEFINICION DE FUNCION */
/* extern int  iUpdateFactDocu_MC  ( long lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, 
                                  ST_CUOTAS *pstFaCuotas, ST_BALANCE *stBalance ,char * szArchivoFinal,
                                  int sema,int indicador);  */
extern int  iUpdateFactDocu_MC  ( long lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, 
                                  ST_CUOTAS *pstFaCuotas, ST_BALANCE *stBalance ,char * szArchivoFinal,
                                  int indicador);                                  
extern int  UnloadMensajes      ( char * , char * , int  , LINEACOMANDO * );
extern int  GetDireccion        ( ST_FACTCLIE *);
extern int  SaldoAntConcepto    ( STSALDO_ANTERIOR  * , long , ST_CICLOFACT *);

/***************************************************************************
                prototipos de ImpSclB
***************************************************************************/
extern int  CargaAbonadosdelCliente  ( ST_FACTCLIE *, ST_ABONADO *,LINEACOMANDO * );
extern int  CargaConceptosDelCliente ( ST_FACTCLIE *, LINEACOMANDO *, ST_INFGENERAL  *, DETALLEOPER * );
extern int  CargaFolioCtc            ( ST_FACTCLIE *, ST_CUOTAS *, STSALDO_ANTERIOR *);
extern int  CloseAbonado             ( void);
extern int  CloseConceptos           ( void);
extern int  CloseConceptosDescuento  ( void);  /*RPL 19-05-2020 PROYECTO CSR */
extern int  FetchAbonado             ( ST_ABONADO *);
extern int  GetCiclFact              ( ST_CICLOFACT * ,long );
extern int  GetCuotas                ( ST_CUOTAS * pstFaCuotas,long lCicloFact,long lCodCliente, char *szFec_Vencimi);
extern int  hay_b2000_b3000          ( FILE *,int ,int ,int, int,int *,int *,char *);
extern int  OpenAbonado              ( long lCiclFact, long lIndOrden);
extern int  OpenConceptos            ( long ,long ,char *, int ,DETALLEOPER *, int );    
extern int  OpenConceptosDescuentos  ( long ,long ,char *, int ,DETALLEOPER *, int );       /*RPL 19-05-2020 PROYECTO CSR */                                                                                                                           
extern int  Update_CuotaCredito      ( ST_FACTCLIE * ,ST_CUOTAS *);
extern int  GetNumProcesoCiclo       ( LINEACOMANDO *);
extern int  CargaCodigoServicio      ( ST_FACTCLIE *pstFactDocuClie, ST_INFGENERAL * pstInfGeneral,char * pstCodServicio);
extern int  PutDetConsu               ( ST_ABONADO *, FILE *, ST_CUOTAS *, STSALDO_ANTERIOR *,
                                        ST_FACTCLIE *, char *, DETALLEOPER *,PLAN_TARIFARIO *,
                                        int,long lCodCiclFact, BOOL Flag_ExisCarrier ); /* P-MIX-09003 */
extern BOOL bfnTrataFactTrafico      ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente,FILE *fArchImp, 
                                       int iCont, char *szBuffer,DETALLEOPER *pstMascaraOper,
                                       int iTasador, long, BOOL Flag_ExisCarrier); /* P-MIX-09003 */                                       

/***************************************************************************
                prototipos de ImpSclD
***************************************************************************/

int         ifnOraCerrarTraficoTolTarifica ();
int         iNumOperadores_Imp             ;
int         bfnCloseDetCarrier             ();
BOOL        bfnImprimeEstruc               ( DETCELULAR * pstDetCelular);
BOOL        bfnOrdenaEstructuras           ( DETCELULAR * pstDetCelular);
extern BOOL bCargaConceptosTar             ( CONCEPTOS_TAR *stConceptosTar);
extern BOOL bCargaMascaraOperadora         ( DETALLEOPER *pst_MascaraOper,int);
extern BOOL bEscribeBuffer                 ( char *szBuffer,char *szRegistro,int iTipoLlamada,FILE *);

extern BOOL bfnCloseDetRoaming             ( int iTasador);
extern BOOL bfnDetLlamCarrier              ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente,int iIndice, 
                                             int iTipoLlamada,FILE *fArchImp, char *szBuffer, int *);
extern BOOL bfnDetLlamCelularTOL           ( ST_ABONADO *pst_Abonados,ST_FACTCLIE *pst_Cliente, int iIndice, 
                                             FILE *fArchImp, char *szBuffer, int *bImprimioD1000, 
                                             DETALLEOPER *pst_MascaraOper);
extern BOOL bfnDetLlamCelular              ( ST_ABONADO *pst_Abonados, ST_FACTCLIE *pst_Cliente, int iIndice, 
                                             int iTipoLlamada, FILE *fArchImp, char *szBuffer, 
                                             DETALLEOPER *pstMascara, int *bImprimioD1000, int iTasador, 
                                             long lCodCiclFact);
extern BOOL bfnDetLlamRoaming              ( ST_ABONADO *pst_Abonados, ST_FACTCLIE *pst_Cliente, int iIndice, 
                                             int iTipoLlamada, FILE *fArchImp, char *szBuffer, 
                                             int *bImprimioD1000, int iTasador,long lCodCiclFact);
extern BOOL bObtieneMascara                ( ST_ABONADO *pst_Abonados,CONCEPTOS_TAR *stConceptosTar,
                                             DETALLEOPER *pst_MascaraOper);
extern BOOL bfnDeterminaGrupo              ( int iCodCargoHost,  DETCELULAR * pstDetCelular, long *lPosicion, 
                                             NUMORDEN *pstNumOrden) ;
extern BOOL bfnCargaTipoTraficoLD          ();
extern BOOL PF_TARIFICADAS                 ( char *szBuffer,char *szRegistro,int iTipoLlamada,FILE *fArchImp);
extern BOOL ifnFindOperadores              ( OPERADORES *pbstOper);


extern int  ifnOpenDetCarrier              ( long lCodCliente, long lNumAbonado,long lNumProceso);
extern int  ifnOpenDetCelular              ( long lCodCliente, long lNumAbonado, int iTipLlam, int iTasador, 
                                             DETALLEOPER *st_Mascara);
extern int  ifnOpenDetRoaming              ( long lCodCliente, long lNumAbonado,long lNumProceso,int,long lCodCiclFact);
extern int  ifnOraLeerTolTarifica          ( DETLLAMADAS_HOSTS  * pstLlamadasHost, int * piNumFilas);
extern int  ManejoArchImp                  ( LINEACOMANDO *, ST_INFGENERAL *, DETALLEOPER *, 
                                             FILE **,ST_ACUMMTO *,char *);
extern int  ifnDeclaraCursores             ( long lCodCiclFact);
extern int  bfnCloseDetCelular             ( int iTasador);
extern void vFormatHora                    ( char [],char  * );

/*extern int      ifnFetchDetCarrier(DETCARRIER * stDetCarrier);
extern int      ifnFetchDetCelular(DETCELULAR * pstDetCelular);
extern int      ifnFetchDetRoaming(DETROAMING *stDetRoaming);*/
/*extern BOOL     bfnCloseDetCarrier(void); */

/***************************************************************************
               PROTOTIPOS COMUNES
***************************************************************************/
BOOL        bfnOrdenaImpresionRC       ( ST_TABLA_ACUM  *, ST_TABLA_ORDEN *, int);
BOOL        bfnActualizaRegprocImpres  ( LINEACOMANDO);
BOOL        bfnChequeaEstado           ( LINEACOMANDO *);
BOOL        bfnActualiza_TrazaProceso  ( LINEACOMANDO, BOOL);
BOOL        bfnActualiza_ProcImpresion ( LINEACOMANDO, BOOL );
BOOL        bfnReg_Padre               ( LINEACOMANDO *);
BOOL        bfnInsertar_FadCTLImpres   ( ST_ACUMMTO *, LINEACOMANDO *, ST_INFGENERAL *, char *);
BOOL        bEscribeEnArchivo          ( FILE *, char * , char * );
BOOL        bfnCargaTipDocum           ( TIPDOC **pstTipDoc, int *iNumTipDocum);
BOOL        bfnCargaCodClientes        ( CODCLI **pstCodClie, int *iNumCodCientes, long );
BOOL        bfnCargaOficinas2          ( OFICINA2 **pstOfici2, int *iNumOficinas);
BOOL        bfnCargaOperadora          ( OPERADORA **pstOper, int *iNumOperadoras);
BOOL        bfnCargaVendedores         ( VENDEDOR **pstVendedor, int *iNumVendedores);
BOOL        bfnCargaCod_Plantarif      ( PLAN_TARIFARIO **pstCodPlanTarif, int *iNumCodPlanes);
BOOL        bfnFindCodCliente          ( long lCodigoCliente, CODCLI *pstCodClie, long lCodCiclFact, char *szFecEmision);
BOOL        Modulo_DetLLam             ( ST_ABONADO           *,
                                         ST_FACTCLIE          *,
                                         CONCEPTOS_TAR        *,
                                         DETALLEOPER          *,
                                         FILE                 *);
int         CargInfGenComun            ( ST_INFGENERAL *pstInformGeneral,
    		                         ST_CICLOFACT  *pstCicloFact,
    		                         LINEACOMANDO  *pstLineaComando,
    		                         int           Cod_Formulario);
int         Modulo_AVIPAG              ( ST_ABONADO           *, ST_FACTCLIE          *,
                                         LINEACOMANDO         *, ST_CICLOFACT         *,
                                         ST_INFGENERAL        *, ST_CUOTAS            *,
                                         FILE                 *, ST_MENSAJES          *,
                                         ST_MENSAJES_NOCICLO  *, STSALDO_ANTERIOR     *,
                                         DETALLEOPER          *, CONCEPTOS_TAR        *,
                                         char                 *, ST_BALANCE           *,
                                         PLAN_TARIFARIO       *, TIPOSIMPUESTOS       *);
int         Procesa_AviPag             ( ST_FACTCLIE          *, FILE                 *,
                                         ST_MENSAJES          *, ST_MENSAJES_NOCICLO  *,
                                         STSALDO_ANTERIOR     *, ST_CUOTAS            *,
                                         ST_CICLOFACT         *, ST_ABONADO           *,
                                         DETALLEOPER          *, char 		      *,
                                         ST_BALANCE           *, PLAN_TARIFARIO       *,
                                         long		       , BOOL                  ,
                                         TIPOSIMPUESTOS       *);
BOOL        ValidaCarrier              ();                                         
int         iMakeDir                   ( char *);
int         InsertHeaderInfCtl         ( ST_CICLOFACT *,LINEACOMANDO *);
int         CargInfGenAviPag           ( LINEACOMANDO *, ST_INFGENERAL *, DETALLEOPER *);   
int         CargaAbonadosdelCliente    ( ST_FACTCLIE * ,ST_ABONADO * ,LINEACOMANDO *  );
int         FormateaDireccion          ( char *,char *);
int         GetCiclFact                ( ST_CICLOFACT * ,long );                                      
extern BOOL bfnCargaCodImptoFact_MC    ( CODIMPTOSFACT *stImp_Fact);
extern BOOL bfnCargaCodImptoCateg_MC   ( CATIMPUESTOS *st_catImpuestos);
extern BOOL bfnFindCod_Operador        ( int iCodOperador, CODOPER *pstOper);
extern BOOL bfnCargaOperadores         ( CODOPER **pstOper, int *iNumOperadores);
extern BOOL bfnCargaOperadores_MC      ( CODOPER **pstOper, int *iNumOperadores);

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




