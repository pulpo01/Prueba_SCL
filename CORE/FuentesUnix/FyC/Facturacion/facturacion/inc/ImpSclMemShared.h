/* estructuras comunes de memoria compartida ImpresionScl */

#define SHMMAX 5000000
#define MAX_COD_CONCEPTOS                              20

#define COD_MASK_SERVICIO                              11
#define COD_MASK_FORMULARIO                            12
#define COD_MASK_CLIENTESXFILE                         13
#define COD_MASK_LOCAL                                 22
#define COD_MASK_ESPECIALES                            23
#define COD_MASK_INTERZONA                             24
#define COD_MASK_ROAMING                               25
#define COD_MASK_CARRIER                               26
#define COD_MASK_LDI                                   27
#define COD_MASK_INDFACTURADO                          52
#define COD_MASK_WHERE_LOCALES                         61
#define COD_MASK_WHERE_INTERZONA                       62
#define COD_MASK_WHERE_LDI                             63
#define COD_MASK_WHERE_ESPECIALES                      64
#define COD_MASK_WHERE_ESPECIALESDATA                  65
#define COD_MASK_INDAGRUPACION                         76
#define MAX_TIPOS_REGISTROS                            600
#define MAX_FAD_PARAMETROS                             1001

#define MAX_MINUTOADICIONAL                            5000

#define MAX_CONCEPTOS_TAR                              100
#define MAX_TIPOS_LD                                   10


#define COD_PROCESO        5000
#define GLS_PROCINIT       "Proceso Iniciado" 
#define szPROC_EST_RUN     "SUB PROCESO EN EJECUCION"
#define iPROC_EST_RUN      1

#define ID_MEMORIA         1
#define ID_CLIENTES        2
#define ID_NUMORDEN        3
#define ID_CODCLI          4
#define ID_CONCATENADOR    5

typedef struct{
    int  cod_parametros      ;
    char des_parametro [1024];
    char tip_parametro   [32];
    int  val_numerico        ;
    char val_caracter   [512];
    char val_fecha        [9];
    int  val_cantidad        ;
} ST_PARAMETROS_M;

typedef struct{
    char szformato_fecha         [22];
    char szformato_hora           [9];
    char szNumDecimal            [21];
    char szIdiomaOper             [6];
    int  iCodAbonoCel                ;
    char sAplica_Cod_Autorizacion [2];
    char sCod_Autorizacion       [10];
    char szFecVencimiento        [10];
} ST_PARAMETROS_GED_M;

typedef struct{
    char   szCod_Plantarif        [4];
    char   szDes_Plantarif       [31];
    long   lMinutosPlan              ;
    double dValorPlan                ;
    int    iInd_Arrastre             ;
    char   szCod_Prestacion     [5+1]; /* P-MIX-09003 130964 */
} PLAN_TARIFARIO_M;

typedef struct{
    char szCodOficina[3];
    char szDesOficina[41];
} OFICINA_HOSTS2_M;

typedef struct{
    long lCodVendedor;
    char szNomVendedor[41];
} VENDEDOR_HOSTS_M;

typedef struct{
    int  lCodTipDocum;
    char szDesTipDocum[41];
} TIPDOC_M;

typedef struct{
    int  cod_ciclo;
    char fec_desde[9];
    char fec_hasta[9];
    char szFecEmision[9];
    char szMesCiclo_0[7];
    char szMesCiclo_1[7];
    char szMesCiclo_2[7];
    char szMesCiclo_3[7];
    char szMesCiclo_4[7];
    char szMesCiclo_5[7];
    int  iIndTasador;
    char szFec_Desde[9];
    char szFec_Hasta[9];
} ST_CICLOFACT_M;

typedef struct{
    char szCodOperadora [6];
    long lCodClienteOperadora;
    char szNomOperadora[51];
    char szNumIdenTRib[21];
    char szDireccion[301];
} OPERADORA_HOSTS_M;

typedef struct{
    int iCodConcepto;
    int iIndTabla;
    int iNumConceptos;
} CONCEPTOS_TAR_M;

typedef struct{
    long lCodCliente             ;
    char szNomApoderado      [41];
    char szCodServicio        [4];
    int  iCodSisPago             ;
    char szNumIdent2       [20+1];
    char szCodCourrier     [10+1];
    char szCodZonaCourrier [10+1];       
} CODCLI_HOSTS_M;


typedef struct 
{
    int   iCodFormulario;
    int   iCtesXArchivo;
    char  szIndFacturado[2];
    int   iIndLocal;
    int   iIndInterzona;
    int   iIndRoaming;
    int   iIndCarrier;
    int   iIndEspeciales;
    int   iIndLDI;
    char  szCodRegistro   [600][6];
    int   iIndImp         [600];
    int   iCod_tipdocum   [600];
    int   iCantRegistros;
    char  szWhere_Local[513];
    char  szWhere_Interzona[513];
    char  szWhere_LDI[513];
    char  szWhere_Especiales[513];
    char  szWhere_Especiales_data[513];
    char  szServicio[3+1];
    int   iInd_Agrupacion;
} DETALLEOPER_M;


typedef  struct
{
    char   szCodPlan              [6];
    char   szLlaveMinutoAdicional [7];
    double dMtoAdicional          ;
} ST_MINUTOADICIONAL_M;

typedef struct {
    char            szUser          [50];   /*  Usuario Unix                        */
    char            szPass          [50];   /*  Password Oracle de Usuario Unix     */
    char            szUsuaOra       [50];   /*  Usuario Oracle                       */
    char            szDirLogs     [1024];   /*  Directorio de Archivos Log's y Err  */
    char            szDirDats     [1024];   /*  Directorio de Archivos Log's y Err  */
    char            szFDetLlam    [1024];   /*  Archivo de Detalle de Llamadas      */
    char            szFormato      [255];   /*  Formato Nombre Archivo              */
    long            lCodCiclFact        ;   /*  Codigo de Ciclo a Procesar          */
    long            lNumProceso         ;   /*  Numero de Proceso de Facturacion    */
    double          dValDolar           ;   /*  Valor de Dolar a Fecah de Emision   */
    int             iNivLog             ;   /*  Nivel de Log para Proceso           */
    int             szFecEmision    [20];   /*  Fecha de Emison de la Factura       */
    int             szFecDesdeLlam  [20];   /*  Fecha Inicio del Periodo Tasacion   */
    int             szFecHastaLlam  [20];   /*  Fecha Termino del Periodo Tasacion  */
    char            szCodIdioma      [6];   /*  Directorio de Archivos Log's y Err  */
    int             iCodTipDocum        ;
    char            szCodDespacho    [6];
    int             iReproceso          ;
    long            cod_clienteinic     ;
    long            cod_clientefina     ;
    long            lProceso            ;
    long            lNum_SecuInfo       ;
    char            szFecIngBegin    [9];
    char            szFecIngEnd      [9];
    int             iTipoCiclo          ;
    int             iCodSalida          ;
    int             iCodEntrada         ;
    char            szHostId        [20];
} LINEACOMANDO_M;



typedef struct{
  int  itip_docum;
  char zcod_despacho[6];
  char zpath[512];
} DIRECTORIO ;

typedef struct{
  char szupdate[1024];
  char sznomarchivo[512];
  int  itipdocum;
  char szCod_Despacho[6];
  int  marcador;
  int  bueno;
} CONCATENADOR;

typedef struct
{
  int iCodConcepto;
} ST_CONCIMPTOFACT_MC;

typedef struct
{
  int    iCodConcepto;
  int    iCodCategoria;
  double dPrcImpuesto;
  char   szFlagImpto [2];
  int    iCodTipImpto;
}CATIMPUES_M;


typedef struct
{
   char szTol_Cod_Llam[21];
   char szTol_Cod_TDir[21];
   char szTol_Cod_THor[21];
   char szTol_Cod_THor_Alta[21];
   char szTol_Cod_THor_Baja[21];
   char szTol_Con_Cliente[21];
   char szTol_Cod_Operador[21];
   char szTol_Cod_TDia[21];
   char szTol_Cod_SFran[21];
}ST_GEDPARAMETROS_ENV;


typedef struct
{
   int                  iNumReg;
   ST_GEDPARAMETROS_ENV St_Par_Env;
}ST_PARAM_ENV;


typedef struct
{
   char   szCod_Plan[6];
   char   szCod_Thor[6];
   long   lSeg_Inic;
   long   lSeg_Adic;
   double dMto_Inic;
   double dMto_Adic;
}ST_DATOSDOMINIO_M;

typedef struct
{
    char    szCodTipoTraficoLD[20];
    char    szNomTipoTraficoLD[20];
    char    szDesTipoTraficoLD[50];
}ST_TIPO_TRAFICO_LD;

typedef struct tagOper
{
    int     iCodOperador;
    char    szDesOperador[31];
}CODOPER;


typedef struct{
    int                  st_parametros_reg;
    ST_PARAMETROS_M      st_parametros[MAX_FAD_PARAMETROS];
    int                  st_parametros_ged_reg;
    ST_PARAMETROS_GED_M  st_parametros_ged;
    int                  plan_tarifario_reg;
    PLAN_TARIFARIO_M     plan_tarifario[5000];
    int                  oficina_hosts2_reg;
    OFICINA_HOSTS2_M     oficina_hosts2[1000];
    int                  vendedor_hosts_reg;
    VENDEDOR_HOSTS_M     vendedor_hosts[150000];
    int                  tipdoc_reg;
    TIPDOC_M             tipdoc[100];
    int                  st_ciclo_fact_reg;
    ST_CICLOFACT_M       st_ciclofact;
    int                  operadora_hosts_reg;
    OPERADORA_HOSTS_M    operadora_hosts[100]; 
    int                  conceptos_tar_reg;
    CONCEPTOS_TAR_M      conceptos_tar[MAX_CONCEPTOS_TAR];
    long                 codcli_hosts_reg ;
    int                  detalleoper_reg;
    DETALLEOPER_M        detalleoper;
    int                  st_minutoadicional_reg;
    ST_MINUTOADICIONAL_M st_minutoadicional[MAX_MINUTOADICIONAL];
    long                 cantidad_clientes;
    LINEACOMANDO_M       StParametrosEntrada;
    int                  flag_proceso;
    int                  iregs_numorden;
    int                  num_directorios;
    DIRECTORIO           directorio[100];
    CONCATENADOR         concatenador[2000];
    long                 lNumConceptos;
    char                 sAplica_Cod_Autorizacion[2];
    char                 sCod_Autorizacion[10];
    ST_CONCIMPTOFACT_MC  st_concimptosfact[MAX_COD_CONCEPTOS];
    long                 lCantCocImpos;
    CATIMPUES_M          stCocImptos[200];
    ST_PARAM_ENV         Parametros_Env;
    ST_DATOSDOMINIO_M    stDat_Domin[5000];
    int                  iNumReg_DatDomin;
    CODOPER              st_CodOper[5000];
    long                 lCantOper;
    int                  iCantTipoTrafico;
    ST_TIPO_TRAFICO_LD   stTipoTrafico[MAX_TIPOS_LD];
} MEMORIA;


typedef struct
{
   char     szRowid            [19];
   long     lIndOrdenTotal         ;
   long     lCodCliente            ;
   long     lNum_Folio             ;
   char     szNumCtc           [13];
   char     szFecEmision       [12];
   char     szFecVencimie      [15]; /* Formato YYYYMMDDHH24MISS */
   int      iCodTipDocum           ;
   long     lNumProceso            ;
   char     szCodGenArch        [3];
   char     szNomHeader         [6];
   int      iCodPrioridad          ;
   char     szCodDespacho       [6];
   double   dTotFactura            ;
   char     szRut_Cliente      [21];
   char     szNombre_Clie      [91];
   int      iNumAbonados           ;
   int      iIndImprime            ;
   char     szCod_Idioma        [6];
   char     szDireccion    [9][665+1];
   char     szIndDebito         [2];
   char     szNumCtcPago       [13];
   char     szPrefPlaza      [25+1];
   char     szCodOperadora      [6];
   char     szCodPlaza          [6];
   double   dTotCargosMes          ;
   double   dImpSaldoAnt           ;
   double   dTotPagar              ;
   double   dTotCuotas             ;
   char     szNumIdentTrib     [12];
   char     szPlanTarif         [4];
   char     szCod_Oficina       [3];
   long     lCodVendedor           ;
   char     szNomUsuarora      [31];
   int      iCodOperPlaza          ;
   char     szCodMonedaImp      [4]; 
   double   dImpConversion         ;    
   long     lNumSecuRel            ;    
   char     szLetraRel          [2]; 
   int      iCodTipDocumRel        ;    
   long     lCodVendedorAgRel      ;    
   long     lCodCentrRel           ;    
   long     lNumVenta              ;    
   char     szFecMinAlta       [10];
   char     szCod_Servicio      [4]; 
   int      iestado		   ;
   char     szCodSegmentacion   [6];
   char     szNomEmail         [71];
   char     szCodIdent          [3]; 
   char     szFecEmi           [20];
   char     szFecUltMod        [20];
   char     szContTecnico    [40+1];
   char     szResolucion     [25+1];
   char     szFecResolucion  [10+1];/* Formato DD-MM-YYYY */
   char     szSerie          [10+1];
   char     szEtiqueta       [10+1]; 
   long     lRanDesde              ;
   long     lRanHasta              ;
   char     szCodTipologia       [5+1]; /* P-MIX-09003 141767 */
   char     szCodAreaImputable   [5+1]; /* P-MIX-09003 141767 */
   char     szCodAreaSolicitante [5+1]; /* P-MIX-09003 141767 */                     
} ST_FACTCLIE;

typedef struct
{
    int  iNum_OrdenGr    ;
    int  iNum_OrdenSubGr ;
    int  iNum_OrdenConc  ;
    int  iCodGrupo       ;
    int  iCodSubGrupo    ;
    int  iCodConcepto    ;
    char szCodRegistro[6];
    int  iCodCriterio     ;
    int  iTipo_Llamada    ;
    int  iTipo_SubGrupo   ;
    
} NUMORDEN;
