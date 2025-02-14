#ifndef _ESTRUCTURAS_H_
#define _ESTRUCTURAS_H_

/* -------------------------------------------------------------------------- */
/*                     Estructuras Generales                                  */
/* -------------------------------------------------------------------------- */

typedef struct PreFactura
{
    char   szRowid         [19];      /* Rowid de la dupla                 */
    long   lNumProceso         ;      /* Numero de proceso                 */
    long   lCodCliente         ;      /* Codigo Cliente           Not Null */
    int    iCodConcepto        ;      /* Codigo Concepto          Not Null */
    long   lColumna            ;      /* Columna                  Not Null */
    short  iCodProducto        ;
    char   szCodMoneda      [4];
    char   szFecValor      [15];      /* Fecha Valor              Not Null */
    char   szFecEfectividad[15];
    double dImpConcepto        ;      /* Importe del Concepto     Not Null */
    double dImpMontoBase       ;      /* Importe Monto Base       Not Null */
    char   szCodRegion      [4];
    char   szCodProvincia   [6];
    char   szCodCiudad      [6];
    char   szCodModulo      [3];      /* Codigo del Modulo        Not Null */
    long   lCodPlanCom         ;      /* Codigo Plan Comercial        Null */
    long   iCodCatImpos        ;
    short  iIndFactur          ;
    long   lNumUnidades        ;      /* Numero de Unidades           Null */
    short  iIndEstado          ;
    int    iCodTipConce        ;
    long   lCodCiclFact        ;      /* Codigo Ciclo Facturacion     Null */
    int    iCodConceRel        ;      /* Codigo Concepto Relacionado  Null */
    long   lColumnaRel         ;      /* Codigo Columna Relacionada   Null */
    long   lNumAbonado         ;      /* Numero Abonado               Null */
    int    iCodZonaAbon        ;      /*Zona impositiva del abonado        */
    char   szNumTerminal   [16];
    long   lCapCode            ;
    char   szNumSerieMec   [26];      /* Numero de Serie ?            Null */
    char   szNumSerieLe    [26];
    short  iFlagImpues         ;
    short  iFlagDto            ;
    float  fPrcImpuesto        ;      /* Poncentaje Imp si tipconc=1  Null */
    double dValDto             ;
    short  iTipDto             ;
    long   lNumVenta           ;      /* Numero de Venta              Null */
    long   lNumTransaccion     ;      /* Informacion que arrastro de Cargos */
    char   szNumGuia       [11];
    int    iMesGarantia        ;
    short  iIndAlta            ;
    short  iIndSuperTel        ;
    int    iNumPaquete         ;
    short  iIndCuota           ;
    int    iNumCuotas          ;
    int    iOrdCuota           ;
    char   szCodCuota       [3];      /*             ''                     */
    BOOL   bOptPenaliza        ;
    BOOL   bOptCargos          ;
    BOOL   bOptServicios       ;
    BOOL   bOptAbonos          ;
    BOOL   bOptTrafico         ;
    BOOL   bOptCuotas          ;
    BOOL   bFinCargos          ; /* Campos para la gestion de los Host Array's */
    BOOL   bFinServicios       ; /*                   ''                       */
    BOOL   bFinAbonos          ; /*                   ''                       */
    BOOL   bFinTrafico         ; /*                   ''                       */
    BOOL   bFinPenaliza        ; /*                   ''                       */
} PFACTURA;

/*****************************************************************************/
/* -Esta estructura gestiona el Insert de todos los Conceptos de un Cliente a*/
/*  facturar. El MAX_CONCFACTUR se define constante en caso de desbordamiento*/
/*  aumentar.                                                                */
/*****************************************************************************/
#define MAX_CONCFACTUR 250000
#define TAM_ORIG_CONC       3000   /* Tamanio base para conceptos */
#define TAM_INCREMENTO_CONC 50     /* Incremento para conceptos   */


typedef struct tagFa_PreFactura
{
    long   lNumProceso          ;
    long   lCodCliente          ;
    int    iCodConcepto         ;
    char   szDesConcepto    [61]; 
    long   lColumna             ;
    short  iCodProducto         ;
    char   szCodMoneda       [4];
    char   szFecValor       [15];
    char   szFecEfectividad [15];
    double dImpConcepto         ;
    double dImpMontoBase        ;
    double dImpFacturable       ;/* Importe en Moneda Facturac. */
    long   lSegConsumido        ;/* En el caso de ser Trafico.  */
    char   szCodRegion       [4];
    char   szCodProvincia    [6];
    char   szCodCiudad       [6];
    char   szCodModulo       [3];
    long   lCodPlanCom          ;
    int    iCodCatImpos         ;
    int    iCodPortador         ;
    short  iIndFactur           ;
    long   lNumUnidades         ;
    short  iIndEstado           ;
    int    iCodTipConce         ;
    long   lCodCiclFact         ;
    int    iCodConceRel         ;
    long   lColumnaRel          ;
    long   lNumAbonado          ;
    int    iCodZonaAbon         ;
    char   szNumTerminal    [16];
    long   lCapCode             ;
    char   szNumSerieMec    [26];
    char   szNumSerieLe     [26];
    short  iFlagImpues          ;
    short  iFlagDto             ;
    float  fPrcImpuesto         ;
    double dValDto              ;
    short  iTipDto              ;
    long   lNumVenta            ;
    long   lNumTransaccion      ;
    long   lNumCargo            ;
    int    iMesGarantia         ;
    char   szNumGuia        [11];
    short  iIndAlta             ;
    short  iIndSuperTel         ;
    int    iNumPaquete          ;
    short  iIndCuota            ;
    long   lSeqCuotas           ;
    int    iNumCuotas           ;
    int    iOrdCuota            ;
    char   szCodCuota        [3];
    char   szFecVenta       [15];
    char   szCodPlanTarif    [4];
    char   szCodCargoBasico  [4];
    char   szTipPlanTarif    [2];
    double dImpConcDescApli     ;
    BOOL   bOptPenaliza         ;
    BOOL   bOptCargos           ;
    BOOL   bOptServicios        ;
    BOOL   bOptAbonos           ;
    BOOL   bOptTrafico          ;
    BOOL   bOptCuotas           ;
    BOOL   bOptDescuento        ;
    BOOL   bOptImpuesto         ;
    BOOL   bOptArriendo         ;
    char   szCodRegi         [3];
    long   lhCodGrupo           ;
    long   lhCodCliente         ;
    long   lhCodCiclFact        ;
    long   lhNumProceso         ;
    char   szIndExcedente    [2];
    char   szCodPlan         [6];
    char   szIndBillete      [3];
    char   szTipDcto         [6];
    char   szCodDcto         [6];
    char   szCodItem         [6];
    char   szIndUnidad       [6];
    double dhCntAux             ;
    double dhMtoReal            ;
    double dhMtoDcto            ;
    long   lhDurReal            ;
    long   lhDurDcto            ;
    char   szDesPlan        [31];
    long   lhCntLlamReal        ;
    long   lhCntLlamFact        ;
    long   lhCntLlamDcto        ;
    char   szhCodMonedaImp   [4];
    double dhImpConversion      ; 
    double dImpValunitario      ; 
    char   szhGlsDescrip   [101];
    long   lhNumPulsos          ; /* Numero de Pulsos */
    double dImpConcDescApliBolsa;
    double dImpFactConIva       ; /* P-MIX-09003 77 */
} FAPFACTURA;

typedef struct tagInd_PreFactura
{
    short  i_iIndEstado      ;
    short  i_iCodTipConce    ;
    short  i_lCodCiclFact    ;
    short  i_iCodConceRel    ;
    short  i_lColumnaRel     ;
    short  i_lNumAbonado     ;
    short  i_szNumTerminal   ;
    short  i_lCapCode        ;
    short  i_iNumUnidades    ;
    short  i_szNumSerieMec   ;
    short  i_szNumSerieLe    ;
    short  i_iFlagImpues     ;
    short  i_iFlagDto        ;
    short  i_fPrcImpuesto    ;
    short  i_dValDto         ;
    short  i_iTipDto         ;
    short  i_lNumVenta       ;
    short  i_lNumTransaccion ;
    short  i_iMesGarantia    ;
    short  i_szNumGuia       ;
    short  i_iIndAlta        ;
    short  i_iIndSuperTel    ;
    short  i_iNumPaquete     ;
    short  i_iIndCuota       ;
    short  i_iNumCuotas      ;
    short  i_iOrdCuota       ;
    short  i_szCodCuota      ;
    short  i_szFecVenta      ;
}IND_PREFACTURA;

typedef struct tagPreFactura
{
    int            iNumRegistros;
    int            iCodModVenta ;
    int            iCodZonaImpo ;
    long           lCantMaxRegs ;
    FAPFACTURA     *A_PFactura   ;
    IND_PREFACTURA *A_Ind        ;
}PREFACTURA;

typedef struct tagHistClie
{
    char   szIndOrdenTotal[13];
    long   lCodCliente        ;
    char   szNomCliente   [51];
    long   lCodPlanCom        ;
    char   szNomApeClien1 [21];
    char   szNomApeClien2 [21];
    char   szTefCliente1  [16];
    char   szTefCliente2  [16];
    char   szDesActividad [41];
    char   szNomCalle     [51];
    char   szNumCalle     [11];
    char   szNumPiso      [11];
    char   szDesComuna    [31];
    char   szDesCiudad    [31];
    char   szCodPais       [4];
    char   szIndDebito     [2];
    double dImpStopDebit      ;
    char   szCodBanco     [16];
    char   szCodSucursal   [5];
    char   szIndTipCuenta  [2];
    char   szCodTipTarjeta [4];
    char   szNumCtaCorr   [19];
    char   szNumTarjeta   [19];
    char   szFecVenciTarj [15];
    char   szCodBancoTarj [16];
    char   szCodTipIdTrib  [3];
    char   szNumIdentTrib [21];
    char   szNumFax       [16];
    char   szCodIdioma     [6];
    char   szGlsDirecClie[251];
    char   szCodPlaza     [6];
}HISTCLIE;

typedef struct tagHistDocu
{
    char   szRowid               [19];
    long   lNumSecuenci              ;
    char   szLetra                [2];
    int    iCodTipDocum              ;
    long   lCodVendedorAgente        ;
    int    iCodCentrEmi              ;
    char   szFecValor            [15];
    double dTotCuotas                ;
    double dTotPagar                 ;
    double dTotDescuento             ;
    double dTotFactura               ;
    double dTotCargosMe              ;
    long   lCodVendedor              ;
    long   lCodCliente               ;
    char   szFecEmision          [15];
    char   szFecCambioMo         [15];
    char   szNomUsuarOra         [31];
    double dAcumIva                  ;
    double dAcumNetoNoGrav           ;
    double dAcumNetoGrav             ;
    char   szIndOrdenTotal       [13];
    char   szNumCTC              [13];
    short  iIndVisada                ;
    short  iIndLibroIva              ;
    short  iIndPasoCobro             ;
    short  iIndCredito               ;
    short  iIndAnulada               ;
    short  iIndSuperTel              ;
    short  iIndImpresa               ;
    long   lNumProceso               ;
    char   szPrefPlaza           [26];
    long   lNumFolio                 ;
    long   lCodPlanCom               ;
    int    iCodCatImpos              ;
    char   szFecVencimie         [15];
    char   szFecCaducida         [15];
    char   szFecProxVenc         [15];
    long   lCodCiclFact              ;
    long   lNumSecuRel               ;
    char   szLetraRel             [2];
    int    iCodTipDocumRel           ;
    long   lCodVendedorAgenteRel     ;
    int    iCodCentrRel              ;
    long   lNumVenta                 ;
    long   lNumTransaccion           ;
    int    iCodModVenta              ;
    int    iNumCuotas                ;
    double dImpSaldoAnt              ;
    int    iCodOpRedFija             ;
    int    iIndFactur                ;
    char   szCodOficina           [3];
    int    iCodZonaImpo              ;
    char   szCodOperadora         [6];
    char   szCodPlaza             [6];
    char   szhCodMonedaImp        [4];
    double dhImpConversion           ;
    char   szCodSegmentacion      [6];
    char   szCodDespacho          [6];
    char   szNomEmail            [71];
    char   szKeyConTecnico       [41];
    char   szContTecnico         [41];
    char   szCodTipologia       [5+1];
    char   szCodAreaImputable   [5+1];
    char   szCodAreaSolicitante [5+1];            
}HISTDOCU;

typedef struct tagHistConc
{
    char   szIndOrdenTotal [MAX_CONCFACTUR][13];
    int    iCodConcepto    [MAX_CONCFACTUR]    ;
    char   szDesConcepto   [MAX_CONCFACTUR][61];
    long   lColumna        [MAX_CONCFACTUR]    ;
    short  iCodProducto    [MAX_CONCFACTUR]    ;
    char   szCodMoneda     [MAX_CONCFACTUR] [4];
    char   szFecValor      [MAX_CONCFACTUR][15];
    char   szFecEfectividad[MAX_CONCFACTUR][15];
    double dImpConcepto    [MAX_CONCFACTUR]    ;
    double dImpMontoBase   [MAX_CONCFACTUR]    ;
    long   lSegConsumido   [MAX_CONCFACTUR]    ;
    char   szCodRegion     [MAX_CONCFACTUR] [4];
    char   szCodProvincia  [MAX_CONCFACTUR] [6];
    char   szCodCiudad     [MAX_CONCFACTUR] [6];
    short  iIndFactur      [MAX_CONCFACTUR]    ;
    double dImpFacturable  [MAX_CONCFACTUR]    ;
    long   lNumUnidades    [MAX_CONCFACTUR]    ;	
    int    iCodTipConce    [MAX_CONCFACTUR]    ;
    int    iCodConceRel    [MAX_CONCFACTUR]    ;
    long   lColumnaRel     [MAX_CONCFACTUR]    ;
    long   lNumAbonado     [MAX_CONCFACTUR]    ;
    int    iCodPortador    [MAX_CONCFACTUR]    ;
    long   lCodCliente     [MAX_CONCFACTUR]    ;
    short  iIndSuperTel    [MAX_CONCFACTUR]    ;
    char   szNumSerieMec   [MAX_CONCFACTUR][26];
    char   szNumSerieLe    [MAX_CONCFACTUR][26];
    short  iFlagImpues     [MAX_CONCFACTUR]    ;
    short  iFlagDto        [MAX_CONCFACTUR]    ;
    float  fPrcImpuesto    [MAX_CONCFACTUR]    ;
    double dValDto         [MAX_CONCFACTUR]    ;
    short  iTipDto         [MAX_CONCFACTUR]    ;
    int    iMesGarantia    [MAX_CONCFACTUR]    ;
    char   szNumGuia       [MAX_CONCFACTUR][11];
    short  iIndAlta        [MAX_CONCFACTUR]    ;
    int    iNumPaquete     [MAX_CONCFACTUR]    ;
    long   lSeqCuotas      [MAX_CONCFACTUR]    ;
    int    iNumCuotas      [MAX_CONCFACTUR]    ;
    int    iOrdCuota       [MAX_CONCFACTUR]    ;
    char   szCodPlanTarif  [MAX_CONCFACTUR] [4];
    char   szCodCargoBasico[MAX_CONCFACTUR] [4];
    char   szTipPlanTarif  [MAX_CONCFACTUR] [2];

/* TOL*/
    double  dhMtoReal      [MAX_CONCFACTUR]    ;
    double  dhMtoDcto      [MAX_CONCFACTUR]    ;
    long    lhDurReal      [MAX_CONCFACTUR]    ;
    long    lhDurDcto      [MAX_CONCFACTUR]    ;
    long    lhCntLlamReal  [MAX_CONCFACTUR]    ;
    long    lhCntLlamFact  [MAX_CONCFACTUR]    ;
    long    lhCntLlamDcto  [MAX_CONCFACTUR]    ;
/* TOL*/

    double dImpValunitario [MAX_CONCFACTUR]    ; 
    char   szhGlsDescrip   [MAX_CONCFACTUR][101];
    long   lNumVenta       [MAX_CONCFACTUR]    ;
} HISTCONC;

typedef struct tagInd_HistConc
{
    short i_iCodConcepto    [MAX_CONCFACTUR];
    short i_iCodProducto    [MAX_CONCFACTUR];
    short i_szCodMoneda     [MAX_CONCFACTUR];
    short i_szFecValor      [MAX_CONCFACTUR];
    short i_szFecEfectividad[MAX_CONCFACTUR];
    short i_dImpConcepto    [MAX_CONCFACTUR];
    short i_dImpMontoBase   [MAX_CONCFACTUR];
    short i_szCodRegion     [MAX_CONCFACTUR];
    short i_szCodProvincia  [MAX_CONCFACTUR];
    short i_szCodCiudad     [MAX_CONCFACTUR];
    short i_szCodModulo     [MAX_CONCFACTUR];
    short i_iIndFactur      [MAX_CONCFACTUR];
    short i_iNumUnidades    [MAX_CONCFACTUR];
    short i_iCodTipConce    [MAX_CONCFACTUR];
    short i_iCodConceRel    [MAX_CONCFACTUR];
    short i_lColumnaRel     [MAX_CONCFACTUR];
    short i_lNumAbonado     [MAX_CONCFACTUR];
    short i_szNumTerminal   [MAX_CONCFACTUR];
    short i_szNumSerieMec   [MAX_CONCFACTUR];
    short i_szNumSerieLe    [MAX_CONCFACTUR];
    short i_iFlagImpues     [MAX_CONCFACTUR];
    short i_iFlagDto        [MAX_CONCFACTUR];
    short i_fPrcImpuesto    [MAX_CONCFACTUR];
    short i_dValDto         [MAX_CONCFACTUR];
    short i_iTipDto         [MAX_CONCFACTUR];
    short i_iMesGarantia    [MAX_CONCFACTUR];
    short i_szNumGuia       [MAX_CONCFACTUR];
    short i_iIndAlta        [MAX_CONCFACTUR];
    short i_iNumPaquete     [MAX_CONCFACTUR];
    short i_lSeqCuotas      [MAX_CONCFACTUR];
    short i_iNumCuotas      [MAX_CONCFACTUR];
    short i_iOrdCuota       [MAX_CONCFACTUR];
    short i_dhMtoReal       [MAX_CONCFACTUR];
    short i_dhMtoDcto       [MAX_CONCFACTUR];
    short i_lhDurReal       [MAX_CONCFACTUR];
    short i_lhDurDcto       [MAX_CONCFACTUR];
    short i_lhCntLlamReal   [MAX_CONCFACTUR];
    short i_lhCntLlamFact   [MAX_CONCFACTUR];
    short i_lhCntLlamDcto   [MAX_CONCFACTUR];
    short i_lhNumVenta      [MAX_CONCFACTUR];
}IND_HISTCONC ;

typedef struct tagHistConcP
{
    int          iNumReg      ;
    HISTCONC     stHistConc   ;
}HISTCONCP;

/* Numero Maximo de Abonados por Cliente */
#define NUM_ABONADOS_CLIENTE 10000

typedef struct tagHistAbo
{
    int    iCodProducto         ;
    char   szIndOrdenTotal  [13];
    long   lNumAbonado          ;
    long   lCodCliente          ;
    double dTotCargosMe         ;
    double dAcumCargo           ;
    double dAcumIva             ;
    double dAcumDto             ;
    char   szNumTerminal    [16];
    long   lCapCode             ;
    short  iCodDetFact          ;
    char   szFecFinContra   [15];
    short  iIndFactur           ;
    int    iCodCredMor          ;
    long   lCodGrupo            ;
    char   szNomUsuario     [21];
    char   szNomApellido1   [21];
    char   szNomApellido2   [21];
    char   szCodPlanTarif    [4];
    double dLimCredito          ;
    short  iIndSuperTel         ;
    char   szNumTeleFija    [16];
    int    iCodZonaAbon         ;
    int    iIndCobroDetLlam     ;
}HISTABO;

typedef struct tagHistAboP
{
    int      iNumReg;
    HISTABO *pAbo   ;
} HISTABOP;

/* Numero de Productos Posibles */
    #define iNPROD 5

typedef struct tagAcumProd
{
    int    iCodProducto   [iNPROD]    ;
    char   szIndOrdenTotal[iNPROD][13];
    double dTotProducto   [iNPROD]    ;
    char   szDesTotalProd [iNPROD][61];
    double dAcumCargo     [iNPROD]    ;
    char   szDesAcumCargo [iNPROD][61];
    double dAcumDto       [iNPROD]    ;
    char   szDesAcumDto   [iNPROD][61];
    double dAcumIva       [iNPROD]    ;
    char   szDesAcumIva   [iNPROD][61];
}ACPROD;

typedef struct tagAcumuloProd
{
    int    iNumReg ;
    ACPROD stAcProd;
}ACUMPROD;


typedef struct tagNotaCD
{
    long     lNumSecuenci         ;
    char     szLetra           [2];
    int      iCodTipDocum         ;
    long     lCodVendedorAgente   ;
    int      iCodCentrEmi         ;
    char     szIndOrdenTotal  [13];
    char     szFecEmision     [15];
    long     lCodCliente          ;
    char     szPrefPlaza      [26];
    long     lNumFolio            ;
    long     lCodPlanCom          ;
    long     iCodCatImpos         ;
    int      iNumConceptos        ;
    int      iCodZonaImpo         ;
    char     szCodPlaza        [6];
    char     szCodOperadora    [6];
    char     szCodOficina      [3];
    long     lCodCiclFact	  ;
    HISTCONC A_HistConc           ;
}NOTACD;


typedef struct tagFACTURA
{
    long   lNumProceso       ;
    int    iCodTipDocum      ;
    long   lCodVendedorAgente;
    char   szLetra       [2] ;
    int    iCodCentrEmi      ;
    long   lNumSecuenci      ;
    long   lCodCliente       ;
    long   lNumAbonado       ;
    short  iCodProducto      ;
    long   lCodCiclFact      ;
    char   szFecVencimie[15] ;
    char   szFecCaducida[15] ;
    double dTotPagar         ;
}FACTURA;

typedef struct tagArriendo
{
    char   szRowid      [19];
    long   lCodCliente      ;
    long   lNumAbonado      ;
    char   szFecDesde   [15];
    char   szFecHasta   [15];
    int    iNumDiasArriendo ;
    int    iCodProducto     ;
    int    iCodConcepto     ;
    char   szDesConcepto[61];
    long   lCodArticulo     ;
    double dPrecioMes       ;
    double dImpConcepto     ;
    char   szCodMoneda   [4];
    char   szCodGrpServ  [3];
    char   szCodModulo   [3];
}ARRIENDO;

typedef struct tagFactCli
{
    short iIndPenaliza        ;
    short iIndPagare          ;
    short iIndCargos          ;
    char  szFecUltPagare  [15];
    char  szFecUltPenaliza[15];
    char  szFecUltCargos  [15];
}FACTCLI;

typedef struct tagCATIMPCLIENTES
{
    long   lCodCliente       ;
    char   szFecDesde    [15];
    char   szFecHasta    [15];
    int    iCodCatImpos      ;
} CATIMPCLIENTES          ;

typedef struct tagZonaImpositiva
{
    int    iCodZonaImpo       ;
    char   szDesZonaImpo  [41];
}ZONAIMPOSITIVA            ;

/* Definicion de estructura para solucion de multiidiomas */
/* CDescouv 27-03-2002                                    */
typedef struct tagCONCEPTO_MI
{
    int    iCodConcepto      ;
    char   szCodIdioma   [6] ;
    char   szDesConcepto [61];
} CONCEPTO_MI;

typedef struct tagCONCEPTO
{
    short  iFlagExiste	     ;
    short  iCodProducto      ;
    char   szDesConcepto [61];
    int    iCodTipConce      ;
    char   szCodModulo   [3] ;
    char   szCodMoneda   [4] ;
    short  iIndActivo        ;
    int    iCodConcOrig      ;
    char   szCodTipDescu [2] ;
    int    iCodConCobr       ;
    long   lFactor			 ;
    int    iCodGrpServi      ;
} CONCEPTO                ;

typedef struct tagRangoConcepto
{
    int iCodConcIni;
    int iCodConcFin;
    int iIndInicial;
    int iIndFinal  ;
}RANGO_CONCEPTO ;

typedef struct tagIndConcepto
{
    int             iNumRangos    ;
    RANGO_CONCEPTO *pRangoConcepto;
}IND_CONCEPTO;

/* Tamano de cada Rango en el puntero de Indices de Conceptos */
    #define iRANGO_CONCEPTO 1000

IND_CONCEPTO stIndConcepto;

IND_CONCEPTO stIndConcepto_mi;

typedef struct tagRangoTabla
{
    long  lCodCiclFact  ;
    long  lRangoIni     ;
    long  lRangoFin     ;
    int   iCodProducto  ;
    char  szNomTabla[21];
}RANGOTABLA;

typedef struct tagDesAcumulado
{
    int   iCodProducto      ;
    char  szDesTotalProd[61];
    char  szDesAcumCargo[61];
    char  szDesAcumIva  [61];
    char  szDesAcumDto  [61];
}DESACUMULADO;

/* ----- Datos Generales Ciclo de Facturacion (FA_CICLFACT) -----  */

typedef struct tagCiclo
{
    char  szRowid          [19];   /* Rowid                    NOT NULL */
    char  szRowidCiclo     [19];   /* Rowid Fa_Ciclos          NOT NULL */
    int   iCodCiclo            ;   /* Codigo Ciclo N(1)        NOT NULL */
    int   iAno                 ;   /* Ano del Ciclo     N(2)   NOT NULL */
    long  lCodCiclFact         ;   /* Ciclo Facturacion N(5)   NOT NULL */
    char  szFecEmision     [15];   /* Fecha Emision     (Date) NOT NULL */
    char  szFecVencimie    [15];   /* Fecha Vencimeinto (Date) NOT NULL */
    char  szFecCaducida    [15];   /* Fecha Caducidad   (Date) NOT NULL */
    char  szFecProxVenc    [15];   /* Fecha Prox. Venc. (Date) NOT NULL */
    char  szFecDesdeLlam   [15];   /* Fecha Desde LLamadas     NOT NULL */
    char  szFecHastaLlam   [15];   /* Fecha Hasta LLamadas     NOT NULL */
    char  szFecDesdeCFijos [15];   /* Fecha Desde Cargos Fijos NOT NULL */
    char  szFecHastaCFijos [15];   /* Fecha Hasta Cargos Fijos NOT NULL */
    char  szFecDesdeOCargos[15];   /* Fecha Desde Otros Cargos NOT NULL */
    char  szFecHastaOCargos[15];   /* Fecha Hasta Otros Cargos NOT NULL */
    char  szFecDesdeRoa    [15];   /* Fecha Desde Roaming      NOT NULL */
    char  szFecHastaRoa    [15];   /* Fecha Hasta Roaming      NOT NULL */
    char  szFecDCFijosAnt  [15];   /* Fecha Desde Cargos Fijos NOT NULL */
    char  szFecHCFijosAnt  [15];   /* Fecha Hasta Cargos Fijos NOT NULL */
    char  szFecHMenos      [15];   /* FecDesdeCFijos-1/86400            */
    short iIndFacturacion      ;   /* Indicativo de Factura    NOT NULL */
    int   iDiaPeriodo          ;
    char  szDirLogs       [101];
    char  szDirSpool      [101];
    int   iInd_Tasacion        ;
    int   iDigD                ;
    int   iDigC                ;
    int   iDigSec              ;
    int   iDiaPeriodoAnt       ;
}CICLO;


typedef struct tagGeImpuestos
{
    int   iCodCatImpos       ;
    int   iCodZonaImpo       ;
    int   iCodZonaAbon       ;
    int   iCodTipImpues      ;
    int   iCodGrpServi       ;
    int   iCodConcGene       ;
    char  szFecDesde     [15];
    char  szFecHasta     [15];
    float fPrcImpuesto       ;
    int   iTipMonto          ;
	double dImpUmbral;
	double dImpMaximo;
}IMPUESTOS                ;

typedef struct tagPlanCtoPlan
{
    long  lCodPlanCom            ;
    short iCodProducto           ;
    long  lCodCtoPlan            ;
    char  szFecEfectividad   [15];
    char  szFecFinEfectividad[15];
}PLANCTOPLAN;

typedef struct tagCtoPlan
{
    long   lCodCtoPlan       ;
    short  iCodProducto      ;
    char   szCodTipCtoPlan[2];
    char   szCodMoneda    [4];
    int    iCodCtoFac        ;
    double dImpDescuento     ;
    short  iCodTipoDto       ;
    short  iIndCuadrante     ;
    short  iCodTipoCuad      ;
    double dImpUmbDesde      ;
    double dImpUmbHasta      ;
    int    iNumDias          ;
}CTOPLAN;


typedef struct tagCuadCtoPlan
{
    long   lCodCtoPlan      ;
    double dImpUmbDesde     ;
    double dImpUmbHasta     ;
    double dImpDescuento    ;
    short  iCodTipoDto      ;
}CUADCTOPLAN;

typedef struct tagGeZonaCiudad
{
    char  szFecDesde     [15];
    char  szFecHasta     [15];
    char  szCodRegion     [4];
    char  szCodProvincia  [6];
    char  szCodCiudad     [6];
    int   iCodZonaImpo       ;
}ZONACIUDAD                 ;

typedef struct tagFaGrpserconc
{
    int   iCodConcepto       ;
    char  szFecDesde     [15];
    int   iCodGrpServi       ;
    char  szFecHasta     [15];
}GRPSERCONC               ;

typedef struct tagDIRECCIONES
{
    long   lCodDireccion      ;
    char   szCodRegion    [4] ;
    char   szCodProvincia [6] ;
    char   szCodCiudad    [6] ;
    char   szCodComuna    [6] ;
    char   szNomCalle     [51];
    char   szNumCalle     [11];
    char   szNumPiso      [11];
    char   szNumCasilla   [16];
    char   szObsDireccion [51];
    char   szGls_DirecClie[250];
}DIRECCIONES               ;

typedef struct tagDIRECCLI
{
    long   lCodCliente        ;
    short  iCodTipDireccion   ;
    long   lCodDireccion      ;
}DIRECCLI                  ;

typedef struct tagComunas
{
    char   szCodRegion     [4];
    char   szCodProvincia  [6];
    char   szCodComuna     [6];
    char   szDesComuna    [31];
    int    iAntiguedad        ;
}COMUNAS;

/* Numero Max. de Registros de la Cache de Comunas */
    #define MAX_COMUNAS 100

typedef struct tagCacheComunas
{
    COMUNAS A_Comunas [MAX_COMUNAS];
    int     iContador              ;
}C_COMUNAS;

typedef struct tagProvincias
{
    char  szCodRegion    [4];
    char  szCodProvincia [6];
}PROVINCIAS;

typedef struct tagCiudades
{
    char  szCodRegion    [4];
    char  szCodProvincia [6];
    char  szCodCiudad    [6];
    char  szDesCiudad   [31];
    char  szCodCelda     [8];
    short iIndCiudad        ;
    int   iAntiguedad       ;
    char   szCodPlaza [6] ;
}CIUDADES;

typedef struct tagCorreo
{
    char szCodRegion     [4];
    char szCodProvincia  [6];
    char szCodCiudad     [6];
    char szDesCiudad    [31];
    char szCodComuna     [6];
    char szDesComuna    [31];
    char szNomCalle     [51];
    char szNumCalle     [11];
    char szNumPiso      [11];
    char szGls_DirecClie[250];
}CORREO;

typedef struct tagAlms
{
    char szCodAlm  [4];
    char szDesAlm [31];
}ALMS;

/* Numero Max. de Registros de la Cache de Ciudades */
    #define MAX_CIUDADES 100

typedef struct tagCacheCiudad
{
    CIUDADES A_Ciudades [MAX_CIUDADES];
    int      iContador                ;
}C_CIUDADES;


typedef struct tagRegiones
{
    char szCodRegion  [4];
    char szDesRegion [31];
}REGIONES;

typedef struct tagTipImpues
{
    int    iCodTipImpue       ;
    double dImpUmbral         ;
    int    iTipMonto          ;
    int    iCodCateImp        ;
}TIPIMPUES                 ;

typedef struct tagActividades
{
    int   iCodActividad     ;
    char  szDesActividad[51];
}ACTIVIDADES;

typedef struct tagCatImpositiva
{
    int    iCodCatImpos       ;
    char   szDesCatImpos  [41];
}CATIMPOSITIVA             ;

typedef struct tagLimCreditos
{
    int   iCodCredMor       ;
    int   iCodProducto      ;
    char  szCodCalClien  [3];
    double dImpMorosidad    ;
}LIMCREDITOS;

typedef struct tagCargos
{
    char   szRowid       [19];
    long   lNumProceso       ;
    long   lNumCargo         ;
    long   lNumVenta         ;
    long   lCodCliente       ;
    short  iCodProducto      ;
    int    iCodConcepto      ;
    char   szDesConcepto [61];
    long   lColumna          ;
    char   szFecAlta     [15];
    double dImpCargo         ;
    char   szCodMoneda    [4];
    long   lCodPlanCom       ;
    long   lNumUnidades      ;
    long   lNumAbonado       ;
    char   szNumTerminal [16];
    long   lCodCiclFact      ;
    char   szNumSerie    [26];
    char   szNumSerieMec [26];
    long   lCapCode          ;
    int    iIndCuota         ;
    int    iMesGarantia      ;
    char   szNumPreGuia  [11];
    char   szNumGuia     [11];
    long   lNumTransaccion   ;
    long   lNumFactura       ;
    int    iCodConceptoDto   ;
    double dValDto           ;
    int    iTipDto           ;
    short  iIndFactur        ;
    int    iNumPaquete       ;
    short  iIndSuperTel      ;
    char   szCodRegion    [4];
    char   szCodProvincia [6];
    char   szCodCiudad    [6]; /* Informacion de Ga_Ventas o de Cliente */
    char   szCodCuota     [3]; /* Informacion de Ga_Ventas              */
    int    iCodModVenta      ; /* Informacion de Ga_Ventas              */
    char   szCodModulo    [3]; /* Informacion a nivel del Concepto      */
    short  iFlagFaCargo      ;
}CARGOS;

typedef struct tagCargosRecurrentes
{
    long   lCodCargo       ;
    double dMontoImporte   ;
    char   szCodMoneda [11];
}CARGOSRECURRENTES;

typedef struct tagVentas
{
    char   szRowid        [19];
    long   lNumVenta          ;
    short  iCodProducto       ;
    char   szCodOficina    [3];
    long   lCodVendedor       ;
    long   lCodVendedorAgente ;
    int    iNumUnidades       ;
    char   szFecVenta     [15];
    char   szCodRegion     [4];
    char   szCodProvincia  [6];
    char   szCodCiudad     [6];
    char   szIndEstVenta   [2];
    char   szCodTipContrato[4];
    short  iIndTipVenta       ;
    long   lNumTransaccion    ;
    long   lCodCliente        ;
    int    iCodModVenta       ;
    int    iTipValor          ;
    char   szCodTipTarjeta [4];
    char   szNumTarjeta   [19];
    char   szCodAutTarj   [20];
    char   szFecVenciTarj [15];
    char   szCodBancoTarj [16];
    char   szNumCtaCorr   [19];
    char   szNumCheque    [21];
    char   szCodBanco     [16];
    char   szCodSucursal   [5];
    char   szCodCuota      [3];
}VENTAS;

typedef struct tagTransContado
{
    char   szRowid         [19];
    long   lNumTransaccion     ;
    short  iCodProducto        ;
    char   szCodOficina     [3];
    long   lCodVendedorAgente  ;
    int    iNumUnidades        ;
    char   szFecTransaccion[15];
    char   szCodRegion      [4];
    char   szCodProvincia   [6];
    char   szCodCiudad      [6];
    double dImpVenta           ;
    char   szCodMoneda      [4];
    short  iIndPasoCob         ;
    char   szNomUsuarOra   [31];
    long   lCodCliente         ;
    int    iTipValor           ;
    char   szCodCuota       [3];
    char   szCodTipTarjeta  [4];
    char   szNumTarjeta    [19];
    char   szCodAutTarj    [20];
    char   szFecVenciTarj  [15];
    char   szCodBancoTarj  [16];
    char   szNumCtaCorr    [19];
    char   szNumCheque     [21];
    char   szCodBanco      [16];
    char   szCodSucursal    [5];
}TRANSCONTADO;

typedef struct tagLetras
{
    int   iCodTipDocum     ;
    int   iCodCatImpos     ;
    char  szLetra       [2];
}LETRAS;

typedef struct tagSecuenciasEmi
{
    int  iCodTipDocum    ;
    int  iCodCentrEmi    ;
    char szLetra      [2];
    long lNumSecuenci    ;
}SECUENCIASEMI;

typedef struct tagFeriados
{
    char szFecFeriado  [15];
}FERIADOS;

/* -------------------------------------------------------------------------- */
/*  Estructuras Imagen TOL_Acumoper                                           */
/* -------------------------------------------------------------------------- */

#define MAX_ACUMTOL             5000
#define MAX_TOLPROMO            3000
#define MAX_TOLDCTO             3000
#define MAX_TOLPROMODCTO_MI     3000
#define MAX_TOLDESCRIPCIONES	3000


typedef struct stConcTOL
{
    char    szhRowid[19];
    char    szCodRegi[3];
    long    lhCodGrupo;
    long    lhCodCliente;
    long    lhNumAbonado;
    long    lhCodCiclFact;
    long    lhNumProceso;
    char    szIndExcedente[2];
    char    szCodPlan[6];
    char    szIndBillete[3];
    int     ihCodCarg;
    char    szTipDcto[6];
    char    szCodDcto[6];
    char    szCodItem[6];
    char    szIndUnidad[6];
    double  dhCntInicial;
    double  dhCntAux;
    double  dhMtoReal;
    double  dhMtoFact;
    double  dhMtoDcto;
    long    lhDurReal;
    long    lhDurFact;
    long    lhDurDcto;
    char    szDesConcepto[61];
    int     iCodTipConce;
    char    szCodMoneda[4];
    int     iCodProducto;
    int     iCodOperador;
    char    szDesPlan[31];
    long    lCntLlamReal;
    long    lCntLlamFact;
    long    lCntLlamDcto;
    int	    iCodFacturacion;
    int	    iIndCarrier;
}CONCTOL;

typedef struct tagACUMTOL
{
    int iNumATOL;
    CONCTOL asATOL[MAX_ACUMTOL];
} tagACUMTOL;

typedef struct TOLPROMO
{
    char   szUnidadPromo [6] ;
    int    iCodConcepto      ;
    char   szFecDesde    [15];
    char   szFecHasta    [15];
    char   szDesPromo    [61];
}TOLPROMO              ;

typedef struct tagTOLPROMO
{
    int iNumTolPromo;
    TOLPROMO asTolPromo[MAX_TOLPROMO];
}tagTOLPROMO;

typedef struct TOLPROMODCTO_MI
{
    int     iCodProducto;
    char    szCodConcepto [13];
    char    szCodIdioma   [6] ;
    char    szDesConcepto [256];
} TOLPROMODCTO_MI;

typedef struct tagTOLPROMODCTO_MI
{
    int iNumTolPromoDcto;
    TOLPROMODCTO_MI asTolPromoDcto_MI[MAX_TOLPROMODCTO_MI];
}tagTOLPROMODCTO_MI;


typedef struct TOLDCTO
{
    char  szTipDcto   [6]  ;
    char  szCodDcto   [6]  ;
    char  szGlsDcto   [41] ;
    char  szIndAplica [5]  ;
    char  szFecIniVig [15] ;
    char  szFecTerVig [15] ;
    int   iNTipDcto        ;
}TOLDCTO;

typedef struct tagTOLDCTO
{
    int iNumTolDcto;
    TOLDCTO asTolDcto[MAX_TOLDCTO];
}tagTOLDCTO;


typedef struct TOLDescripcion
{
    char  szTipDcto		[6] ;
    int   iCodConcepto		;
    char  szDescripcion	[61];
}TOLDescripcion;

typedef struct tagTOLDescripcion
{
    int iNumTolDesc;
    TOLDescripcion asTolDesc[MAX_TOLDESCRIPCIONES];
}tagTOLDescripcion;


/*------------------------ Estructura del Modulo de Tarificaion -------------*/
typedef struct tagTaConcepFact
{
    short  iCodProducto    ;
    int    iCodFacturacion ;
    short  iIndTabla       ;
    short  iIndEntSal      ;
    int    iCodTarificacion;
    int    iIndDestino     ;
    char   szCodServicio[6];
}TACONCEPFACT;

typedef struct tagFactCarriers
{
    int    iCodConcFact   ;
    int    iCodConcCarrier;
    int	   iCodTipConce   ;
}FACTCARRIERS;

typedef struct tagConcTar
{
    char   szRowid       [19]; /* Tabla Ta_ConcepFact */
    long   lNumAbonado       ;
    short  iCodProducto      ;
    int    iCodFacturacion   ;
    char   szDesConcepto [61];
    int    iCodTipConce      ;
    char   szCodMoneda    [4];
    short  iIndTabla         ;
    short  iIndEntSal        ;
    double dImpConsumido     ;
    long   lSegConsumido     ;
    long   lNumPulsos        ;
    long   lNumProceso       ;
    int    iCodOperador      ;
    int    iCodFranHoraSoc   ;
    long   lNumAlquiler      ; /* Ga_InfacRent   */
    long   lNumEstaDia       ; /* Ga_InfacRoaVis */
    int    iCarrier          ; /* 1: Fortas 2 : Foradi */
    int    iIndDestino       ;
} CONCTAR;

typedef struct tagAbonTar
{
    char     szRowid [19]; /* Rowid del reg. de la tablas Ga_Infa% */
    long     lNumAbonado ;
    short    iCodProducto;
    int      iIndFactur  ;
    int      iNumConcTar ;
    int      iNumConcTOL ;
    CONCTAR* pConcTar    ;
    CONCTOL* pConcTOL    ;
}ABONTAR;


/*--------------- Estructura de Penalizaciones del SAC ---------------------*/
typedef struct tagPenaliza
{
    char   szRowid         [19];
    long   lCodCliente         ;
    int    iTipIncidencia      ;
    char   szFecEfectividad[15];
    char   szCodMoneda      [4];
    char   szCodModulo      [3];
    double dImpPenaliz         ;
    long   lCodCiclFact        ;
    int    iCodConcepto        ;
    char   szDesConcepto   [61];
    int    iCodTipConce        ;
    short  iIndActivo          ;
    short  iIndFactur          ;
    int    iCodProducto        ;
    long   lNumAbonado         ;
    long   lNumProceso         ;
} PENALIZA                   ;

/*-------------------------- Estructuras Servicios -------------------------*/
typedef struct TagServicios
{
    int    iCodConcepto     ;
    char   szDesConcepto[61];
    char   szCodMoneda   [4];
    double dImpConcepto     ;
    double dImpPeriodo      ;
    int    iNumDiasPro      ;
    int    iNumPeriodos     ;
    BOOL   bIndCargo        ;
    char   szFecAltaCen [15];
    char   szFecBajaBD  [15];
    long   lColumna         ;
    int    iIndCobRetr      ;    
}SERVICIOS;

typedef struct TagSERVABO
{
    char       szRowid      [19];
    long       lNumAbonado      ;
    int        iCodProducto     ;
    char       szFecDesde   [15];
    char       szFecHasta   [15];
    char       szCodPlanServ[4] ;
    char       szCodGrpServ [3] ;
    char       szNumTerminal[16];
    short      iIndAlta         ;
    short      iIndFactur       ;
    char       szFecValor   [15];
    long       lCapCode         ;
    long       lCodPlanCom      ;
    SERVICIOS* pServicios       ;
    int        iNumServicios    ;
}SERVABO;

typedef struct tagCBasico
{
    char   szRowid         [19];/* Rowid de Ga_Intar%                          */
    int    iCodAbono           ;/* Codigo de Concepto del Abono (Ge_DatosGener)*/
    char   szDesAbono      [61];/* Descripcion del Concepto Abono              */
    int    iCodAbonoFin        ;/* Codigo de Concepto de Fin Abono "     "     */
    char   szDesAbonoFin   [61];/* Descripcion del Concepto AbonoFin           */
    char   szCodMoneda      [4];
    char   szCodMonedaFin   [4];
    char   szCodModulo      [3];
    int    iNumDiasAbono       ;/* Dias Prorratebles del Abono                 */
    int    iNumPerAbono        ;/* Numero de Periodos a factura del Abono      */
    int    iNumDiasFin         ;/* Dias Hasta Fin de Contrato                  */
    double dImpPeriodo         ;/* Importe de Cargo Basico                     */
    double dImpConcepto        ;/* ImpDiasAbono + dImpPeriodo * iNumPerAbono   */
    double dImpFinContrato     ;
    char   szFecDesde      [15];/* Ga_Infac% */
    char   szFecHasta      [15];/* Ga_Infac% */
    char   szCodCargoBasico[4] ;
    char   szTipPlanTarif  [2] ;/* I: Individual, H: Holding, E: Empresa       */
    char   szCodPlanTarif  [4] ;
    long   lCodGrupo           ;
    char   szCodPlanServ   [4] ;
    char   szCodGrpServ    [3] ;
    long   lCodPlanCom         ;
    char   szNumTerminal   [16];
    long   lCapCode            ;
    double dImpMontoBase       ; /* P-MIX-09003 134206 */    
}CARGOFIJO;

typedef struct tagAbonos
{
    char   szRowid         [19];/* Rowid de Ga_Infac% (% =>iCodProducto)       */
    long   lNumAbonado         ;
    short  iCodProducto        ;
    short  iIndAlta            ;
    int    iIndActuacOld       ;
    int    iIndActuacNew       ;
    short  iIndFactur          ;
    short  iIndCargos          ;/* Indicativo de Cargos                        */
    short  iIndPenaliza        ;/* Indicativo de Penalizaciones a Nivel Abono  */
    short  iIndCuotas          ;
    short  iIndArriendo        ;/* Indicativo de Arriendo a Nivel Abono        */
    int    iIndCargoPro        ;
    int    iIndBloqueo         ;
    char   szFecAlta       [15];/* Ga_Intar% */
    char   szFecBaja       [15];
    char   szFecFinContrato[15];
    char   szNumTerminal   [16];
    char   szCodGrpServ    [3] ;
    char   szTipPlanTarif  [2] ;/* I: Individual, H: Holding, E: Empresa       */
    char   szCodPlanTarif  [4] ;/* Plan Tarifario en vigencia                  */
    long   lCodGrupo           ;
    long   lCodPlanCom         ;
    BOOL   bPlanOptimo         ;/* True al Abonado se le Aplicado Plan Optimo */
    long   lColumna            ;
    int    iIndCuenControlada  ;
    int    iNumCBasicos        ;
    CARGOFIJO *pstCBasico      ;
}ABONOS;


typedef struct tagAboRent
{
    long     lNumAbonado     ;
    long     lNumAlquiler    ;
    char     szFecAlta   [15];
    char     szFecBaja   [15];
    long     lNumCelular     ;
    short    iIndActuac      ;
    short    iIndDetalle     ;
    short    iIndPenaliza    ;
    int      iNumConcTar     ;
    int      iNumConcTOL     ;
    CONCTAR *pConcTar        ;
    CONCTOL *pConcTOL        ;
}ABORENT;

typedef struct tagAboRoaV
{
    long     lNumAbonado     ;
    long     lNumEstaDia     ;
    char     szFecAlta   [15];
    char     szFecBaja   [15];
    long     lNumCelular     ;
    long     lNumCelularOrig ;
    short    iIndActuac      ;
    short    iIndFactur      ;
    short    iIndPenaliza    ;
    short    iIndCargos      ;
    int      iNumConcTar     ;
    CONCTAR *pConcTar        ;
}ABOROAVIS;

typedef struct tagCuotas
{
    char   szRowid     [19];
    long   lSeqCuotas      ;
    int    iOrdCuota       ;
    char   szFecEmision[15];
    double dImpCuota       ;
    short  iIndFacturado   ;
    short  iIndFactur      ;
    short  iIndPagado      ;
}CUOTAS;

typedef struct tagCabCuotas
{
    char    szRowid      [19];
    long    lSeqCuotas       ;
    long    lCodCliente      ;
    int     iCodConcepto     ;
    char    szDesConcepto[61];
    char    szCodMoneda   [4];
    char    szCodModulo   [3];
    short   iCodProducto     ;
    int     iNumCuotas       ;
    double  dImpTotal        ;
    short   iIndPagada       ;
    long    lNumAbonado      ;
    char    szCodCuota    [3];
    long    lNumPagare       ;
    int     iNCuotas         ;
    CUOTAS *pCuotas          ;
}CABCUOTAS;


typedef struct tagCicloCli
{
    char   szRowid       [19];
    long   lCodCliente       ;
    int    iCodCiclo         ;
    short  iCodProducto      ;
    long   lNumAbonado       ;
    char   szCodCalClien  [3];
    char   szNumTerminal [16];
    short  iIndCambio        ;
    short  iIndFactur        ;
    short  iIndDetalle       ;
    char   szIndDebito    [2];
    short  iIndSuperTel      ;
    int    iCodCredMor       ;
    char   szNomUsuario  [21];
    char   szNomApellido1[21];
    char   szNomApellido2[21];
    char   szFecFinContra[15];
    char   szNumTeleFija [16];
    char   szFecAlta     [15];
    char   szCodPlanTarif [4];
    int    iCodCicloNue      ;
    long   lCapCode          ;
    long   lCodGrupo         ;
    double dTotCargosMe      ;
    char   szFecUltFact  [15];
    int    iIndCobroDetLlam  ;
}CICLOCLI;

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
typedef struct tag_FAC_CLIENTES
{
    long   lRowNum           ;
    long   lCargos           ;
    long   lCodCliente       ;
    int    iCodEstado        ;
    pthread_mutex_t mMutexLock;
    char   szNomCliente   [51];
    char   szNomApeClien1 [21];
    char   szNomApeClien2 [21];
    char   szTefCliente1  [16];
    char   szTefCliente2  [16];
    char   szCodPais       [4];
    char   szIndDebito     [2];
    double dImpStopDebit      ;
    char   szCodBanco     [16];
    char   szCodSucursal   [5];
    char   szIndTipCuenta  [2];
    char   szCodTipTarjeta [4];
    char   szNumCtaCorr   [19];
    char   szNumTarjeta   [19];
    char   szFecVenciTarj [15];
    char   szCodBancoTarj [16];
    char   szCodTipIdTrib  [3];
    char   szNumIdentTrib [21];
    int    iCodActividad      ;
    char   szCodOficina    [3];
    int    iIndFactur         ;
    char   szNumFax       [16];
    char   szFecAlta      [15];
    long   lCodCuenta         ;
    char   szCodIdioma    [6] ;
    char   szCodOperadora  [6];
    int    iCodCatImpos		;
    char   szIndOrdenTotal[13]	;
    char   szCodRegion_1 [4]   	;
    char   szCodProvincia_1 [6]	;
    char   szCodCiudad_1 [6]  	;
    char   szCodComuna_1 [6]  	;
    char   szNomCalle_1  [51]  	;
    char   szNumCalle_1  [11]  	;
    char   szNumPiso_1   [11] 	;
    char   szCodRegion_3 [4]   	;
    char   szCodProvincia_3 [6]	;
    char   szCodCiudad_3 [6]  	;
    char   szCodComuna_3 [6]  	;
    char   szNomCalle_3  [51]  	;
    char   szNumCalle_3  [11]  	;
    char   szNumPiso_3   [11] 	;
    char   szCodBancoUniPac[16] ;
    char   szCodSegmentacion[6] ;
    char   szCodDespacho[6]     ;
    char   szNomEmail   [71]    ;
    char   szCodIdTipDian  [3]  ;
    int    iIndClieLoc           ;  
}FAC_CLIENTES;

typedef struct tag_FAC_PID
{
    int    iPID;
}FAC_PID;
/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

typedef struct tagAbonoCli
{
    long      lNumAbonados;
    CICLOCLI *pCicloCli   ;
}ABONOCLI;

typedef struct tagGAbonoCli
{
    long      lNumReg    ;
    ABONOCLI *pstAbonoCli;
}GABONOCLI;

/* ----- Datos Generales Cliente ----- */
typedef struct tagCliente
{
    long          lCodCliente        ; /* Codigo Cliente                       */
    char          szFecAlta      [15];
    int           iCodCatImpos       ; /* Categoria impositiva cliente         */
    long          lCodPlanCom        ;
    short         iIndFactur         ;
    char          szCodCalClien   [3]; /* Calidad Cliente                      */
    char          szCodOficina    [3];
    char          szIndDebito     [2];
    double        dImpStopDebit      ;
    char          szNomCliente   [51];
    char          szNomApeClien1 [21];
    char          szNomApeClien2 [21];
    char          szTefCliente1  [13];
    char          szTefCliente2  [13];
    char          szCodPais       [4];
    char          szCodRegion     [4];
    char          szDesRegion    [31];
    char          szCodProvincia  [6];
    char          szCodCiudad     [6];
    char          szDesCiudad    [31];
    char          szCodComuna     [6];
    char          szDesComuna    [31];
    char          szNomCalle     [51];
    char          szNumCalle     [11];
    char          szNumPiso      [11];
    char          szCodBanco     [16];
    char          szCodSucursal   [5];
    char          szIndTipCuenta  [2];
    char          szCodTipTarjeta [4];
    char          szNumCtaCorr   [19];
    char          szNumTarjeta   [19];
    char          szFecVenciTarj [15];
    char          szCodBancoTarj [16];
    char          szCodTipIdTrib  [3];
    char          szNumIdentTrib [21];
    int           iCodActividad      ;
    double        dImpRecargo        ; /* Importe de Recargos -> Cobros        */
    double        dImpSaldoAnt       ; /* Haber-Debe en Co_Cartera (MonedaCobr)*/
    char          szNumFax       [16];
    int           iCodOpRedFija      ;
    char          szTipPlanTarif  [2];
    char          szTableCelular [21];
    char          szTableBeeper  [21];
    char          szTableTrunk   [21];
    char          szTableTrek    [21];
    char          szTableGene    [21];
    short         iIndCredito        ;
    short         iIndSuperTel       ;
    ABOROAVIS*    pAboRoaVis         ;
    ABORENT*      pAboRent           ;/* Abonado de Rent Phone                */
    int           iNumAbonados       ;
    ABONTAR*      pAbonados          ;/* Modulo Tarificacion                  */
    int           iNumPenaliza       ;
    PENALIZA*     pPenaliza          ;/* Modulo S.A.C                         */
    int           iNumServAbo        ;
    SERVABO*      pServAbo           ;/* Servicios suplementarios del abonado */
    int           iNumAbonos         ;
    ABONOS*       pAbonos            ;/* Modulo Abonados                      */
    int           iNumCargos         ;
    CARGOS*       pCargos            ;/* Modulo Cargos                        */
    int           iNumCabCuotas      ;
    CABCUOTAS*    pCabCuotas         ;/* Cuotas de Cliente y Abonado          */
    int           iNumArriendos      ;
    ARRIENDO*     pArriendo          ;
    short         iModVenta          ;/* Valores Posibles 1 y 2 :             */
    long          lCodCuenta         ; /* Codigo de Cuenta                    */
    char          szCodIdioma    [6] ; /* Incorporado por PGonzaleg 13-03-2002*/
    char          szGls_DirecClie[250];/* Incorporado por PGonzaleg  9-04-2002*/
    char          szCodOperadora [6] ; /* Codigo de la operadora del Cliente  */
    char          szCodSegmentacion[6];
    char          szCodDespacho[6]    ;
    char          szNomEmail   [71]   ;
    char          szCodIdTipDian  [3] ;
    int           iIndClieLoc         ;
} CLIENTE                           ;/*   1 =>Unica modalidad de Venta en    */
                                     /*       PVenta (Contado o Credito)     */
                                     /*   2 =>Contado y Credito en una Venta */

typedef struct tagConcColumna
{
    short  iFlagExiste;
    long   lColumna   ;
}CONCOLUMNA;

typedef struct tagMaxColPreFa
{
    CONCOLUMNA pConcCol [10000]; /* SE ASUME UN TAMAÑO FIJO MAX_CONCEPTOS */
}MAXCOLPREFA;

typedef struct tagCodConcServ
{
    int  iCodConcepto;
    int  iCodGrpServi;
}CODCONCSERV;

typedef struct tagCodConcServS
{
    int         iNumConcServ;
    CODCONCSERV *stConcServ;
}CODCONCSERVS;

typedef struct tagConversion
{
    char   szCodMoneda   [4];
    char   szFecDesde   [15];
    char   szFecHasta   [15];
    double dCambio          ;
}CONVERSION               ;

typedef struct tagTarifas
{
    char   szCodTipServ  [2];
    char   szCodServicio [4];
    char   szCodPlanServ [4];
    char   szFecDesde   [15];
    double dImpTarifa       ;
    char   szCodMoneda   [4];
    char   szIndPeriodico[2];
    char   szFecHasta   [15];
}TARIFAS;

typedef struct tagAlDocumSucursal
{
    char  szCodOficina [3];
    int   iCodTipDocum    ;
    int   iCodCentrEmi    ;
}DOCUMSUCURSAL;

typedef struct tagPlanTarif
{
    char  szCodPlanTarif  [4] ;
    char  szTipTerminal   [2] ;
    char  szCodLimConsumo [4] ;
    char  szCodCargoBasico[4] ;
    char  szTipPlanTarif  [2] ;
    char  szTipUnidades   [2] ;
    char  szCod_Unidad    [6] ;
    long  lNumUnidades        ;
    short iIndArrastre        ;
    int   iNumDias            ;
    long  lNumAbonados        ;
    char  szInd_Francons  [3] ;
    short iFlgRango           ;
    char  szIndCompartido[1+1]; /* P-MIX-09003 */
    int   iTipCobro           ; /* P-MIX-09003 */    
}PLANTARIF;

typedef struct tagCargosBasico
{
    char   szCodCargoBasico[4];
    double dImpCargoBasico    ;
    char   szCodMoneda     [4];
}CARGOSBASICO;

typedef struct tagActuaServ
{
    char   szCodTipServ [2] ;
    char   szCodServicio[4] ;
    int    iCodConcepto     ;
}ACTUASERV;

typedef struct tagGrupoCob
{
    char   szCodGrupo  [3] ;
    short  iCodProducto    ;
    int    iCodConcepto    ;
    int    iCodCiclo       ;
    char   szFecDesde  [15];
    char   szFecHasta  [15];
    short  iTipCobro       ;
}GRUPOCOB;

typedef struct tagOptimo
{
    char   szCodPlanTarif [4];
    long   lMinDesde         ;
    long   lMinHasta         ;
    float  fPrcAbono         ;
    float  fPrcNormal        ;
    float  fPrcBajo          ;
}OPTIMO;

typedef struct tagOperador
{
    int  iCodOperador      ;
    char szDesOperador [31];
}OPERADORES;

typedef struct tagGOperador
{
    int         iNumReg    ;
    OPERADORES *pstOperador;
}GOPERADORES;


typedef struct tagTiposTerminales
{
    int    iCodProducto       ;
    char  szTipTerminal    [2];
    char  szDesTerminal   [16];
}TIPOSTERMINALES;

typedef struct tagGTiposTerminales
{
    int                        iNumReg;
    TIPOSTERMINALES    *pstTipTerminal;
}GTIPOSTERMINALES;

typedef struct tagTipCobertura
{
    int  iTipCobertura      ;
    char szDesTipCobert [31];
    char szCodServicio   [4];
    int  iCodProducto       ;
}TIPCOBERTURA;

typedef struct tagGTipCobertura
{
    int                    iNumReg;
    TIPCOBERTURA  *pstTipCobertura;
}GTIPCOBERTURA;

/*****************************************************************************/
/* rao20040505:																 */
/*****************************************************************************/
#define TAM_HOSTS_PEQ 2000

typedef struct tagOficina
{
	char szCodOficina	[3];
	char szCodRegion	[4];
	char szCodProvincia	[6];
	char szCodCiudad 	[6];
	char szCodPlaza		[6];
}OFICINA;

typedef struct tagOficina_Hosts
{
	char szCodOficina	[TAM_HOSTS_PEQ][3];
	char szCodRegion	[TAM_HOSTS_PEQ][4];
	char szCodProvincia	[TAM_HOSTS_PEQ][6];
	char szCodCiudad 	[TAM_HOSTS_PEQ][6];
	char szCodPlaza		[TAM_HOSTS_PEQ][6];
}OFICINA_HOSTS;

typedef struct tagOficinas
{
    int         iNumOficinas;
    OFICINA  	*stOficina;
}OFICINAS;


typedef struct tagFactCobr
{
	int iCodConcFact;
	int	iCodConCobr;
}FACTCOBR;

typedef struct tagFactCobr_Hosts
{
	int 	iCodConcFact[TAM_HOSTS_PEQ];
	int 	iCodConCobr	[TAM_HOSTS_PEQ];
}FACTCOBR_HOSTS;

typedef struct tagFactCobros
{
    int         iNumFactCobros;
    FACTCOBR  	*stFactCobr;
}FACTCOBROS;


typedef struct tagImptoDcto
{
    long    lCodConcepto       ;
    char    szCodZonacargo [11];
    char    szCodRegion     [6];
    char    szCodProvincia  [6];
    int     iTipZonacargo      ;
    int     iTipEvaluacion     ;
    long    lCodGprservi       ;
    double  dImpfacturable     ;
    char    szTipValor      [2];
    char    szFecDesde      [9];
    char    szFecHasta      [9];
    int	    iCodCatImpos       ;

}IMPTODCTO;

typedef struct tagImptoDcto_Hosts
{
    long    lCodConcepto   [TAM_HOSTS_PEQ]    ;
    char    szCodZonacargo [TAM_HOSTS_PEQ][11];
    char    szCodRegion    [TAM_HOSTS_PEQ][6];
    char    szCodProvincia [TAM_HOSTS_PEQ][6];
    int     iTipZonacargo  [TAM_HOSTS_PEQ];
    int     iTipEvaluacion [TAM_HOSTS_PEQ];
    long    lCodGprservi   [TAM_HOSTS_PEQ]   ;
    double  dImpfacturable [TAM_HOSTS_PEQ]   ;
    char    szTipValor     [TAM_HOSTS_PEQ][2];
    char    szFecDesde     [TAM_HOSTS_PEQ][9];
    char    szFecHasta     [TAM_HOSTS_PEQ][9];
    int     iCodCatImpos   [TAM_HOSTS_PEQ];
}IMPTODCTO_HOSTS;

typedef struct tagImptoDctos
{
    int         iNumImptosDctos;
    IMPTODCTO  	*stImptoDcto;
}IMPTODCTOS;


typedef struct tagCodImptoDctos
{
    int     iCodZonaImpCliente;
    int     iCodZonaImpAbon;
    char    szCodProvCliente  [6];
    char    szCodProvAbon     [6];
    char    szCodRegionCliente[4];
    char    szCodRegionAbon   [4];
    char    szCodCiudadCliente[6];
    char    szCodCiudadAbon   [6];
    char    szCodComunaCliente[6];
    char    szCodComunaAbon   [6];

}COD_IMPTODCTOS;

/***************************************************************/
/* Estructura para registrar las Zonas impositivas por abonado */
/***************************************************************/
typedef struct tagTZAbon
{
        long      lNumAbonado;
        int       iCodZonaAbon;
}TZABON                  ;


typedef struct tagTotZAbon
{
  int       iNumAbonados;
  TZABON        stAbon [NUM_ABONADOS_CLIENTE];
}TOTZABON       ;

/***************************************************************/
/* Estructura para registrar valor de parametros de facturacion*/
/***************************************************************/
typedef struct TagFadParam
{
	int  iConcIEPS    ;
	int  iConcDctoIEPS;
	int  iConcCargImptoDcto;
	char szAreaImptoDcto	  [513];
	char szCodMonedaImptoDcto [4]  ;
	double dImpImptoDcto;
	int iCodTipImptoDocto;
}FADPARAM;

/*****************************************************************************/
/* Defincion de constantes simbolicas, que estiman de manera aproximada siem-*/
/* al alza, del numero de reg. que tienen las distintas tablas que se van a  */
/* cargar en memoria . En caso de desbordamiento, al efectuar la carga de una*/
/* tabla, la ejecucion se aborta y se debe modificar la constante correspon- */
/* diente (con una estimacion sensiblemente mayor al count(*) sobre la tabla)*/
/* y volver a makear los fuentes.                                            */
/*****************************************************************************/
#define MAX_PROVINCIAS     10000        /* Ge_Provincias     */
#define MAX_REGIONES       1000         /* Ge_Regiones       */
#define MAX_CATIMPCLIENTES 3000         /* Ge_CatImpClientes */
#define MAX_CATIMPOSITIVA  1000         /* Ge_CatImpositiva  */
#define MAX_ZONAIMPOSITIVA 100          /* Ge_ZonaImpositiva */
#define MAX_ACTIVIDADES    2000         /* Ge_Actividades    */
#define MAX_IMPUESTOS      10000        /* Ge_Impuestos      */
#define MAX_CONVERSION     2000         /* Ge_Conversion     */
#define MAX_LETRAS         100          /* Ge_Letras         */
#define MAX_DIRECCIONES    1            /* Ge_Direcciones    */
#define MAX_ZONACIUDAD     20000        /* Ge_ZonaCiudad     */
#define MAX_TIPIMPUES      50           /* Ge_TipImpues      */
#define MAX_CARGOS         50000       /* Ge_Cargos         */ 
#define MAX_DIRECCLI       6000         /* Ga_DirecCli       */
#define MAX_DOCUMSUCURSAL  85000        /* Al_Docum_Sucursal */
#define MAX_GRPSERCONC     50000        /* Fa_GrpSerConc     */
#define MAX_CONCEPTOS      50000        /* Fa_Conceptos      */
#define MAX_CONCEPTOS_MI   50000        /* Ge_MultiIdiomas   */
#define MAX_CICLFACT       2000         /* Fa_CiclFact       */
#define MAX_CABCUOTAS      15000        /* Fa_CabCuotas      */
#define MAX_CUOTAS         50000        /* Fa_Cuotas         */
#define MAX_ARRIENDO       10000        /* Fa_Arriendo       */
#define MAX_RANGOTABLA     500          /* Fa_Rango_Tabla    */
#define MAX_DESACUMULADO   10           /* Fa_DesAcumulado   */
#define MAX_PENALIZACIONES 5000         /* Ca_Penalizaciones */
#define MAX_TARIFAS        2000         /* Ga_Tarifas        */
#define MAX_ACTUASERV      5000         /* Ga_ActuaServ      */
#define MAX_PLANCTOPLAN    5000         /* Ve_Plan_CtoPlan   */
#define MAX_CTOPLAN        5000         /* Ve_CtoPlan        */
#define MAX_CUADCTOPLAN    5000         /* Ve_CuadCtoPlan    */
#define MAX_TACONCEPFACT   3000         /* Ta_ConcepFact     */
#define MAX_FACTCARRIERS   500          /* Fa_FactCarriers   */
#define MAX_PLANTARIF      5000         /* Ta_PlanTarif      */
#define MAX_CARGOSBASICO   3000         /* Ta_CargosBasico   */
#define MAX_GRUPOCOB       60000        /* Fa_GrupoCob       */
#define MAX_LIMCREDITOS    100          /* Co_LimCreditos    */
#define MAX_OPTIMO         1000         /* Fa_Optimo         */
#define MAX_ALMS           50           /* Ge_Alms           */
#define MAX_OPERADORES     500          /* Ta_Operadores     */
#define MAX_FERIADOS       100          /* Ta_DiasFest       */
#define MAX_CARGOSRECURRENTES 15000     /* Fa_Cargos_rec_to  */

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
#define MAX_ABONADOS	   65000         /* Fa_CicloCli       */
/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

/*****************************************************************************/
/*    Declaracion de Array's globales para la carga de tablas en memoria     */
/*****************************************************************************/
#undef access
#ifdef _GENFA_PC_
    #define access
#else
    #define access extern
#endif /* fin _GENFA_PC_      */

access PROVINCIAS     pstProvincias     [MAX_PROVINCIAS]    ;
access REGIONES       pstRegiones       [MAX_REGIONES]      ;
access ALMS           pstAlms           [MAX_ALMS]          ;
access CATIMPCLIENTES pstCatImpClientes [MAX_CATIMPCLIENTES];
access ACTIVIDADES    pstActividades    [MAX_ACTIVIDADES]   ;
access CARGOS         pstCargos         [MAX_CARGOS]        ;
access LIMCREDITOS    pstLimCreditos    [MAX_LIMCREDITOS]   ;
access CICLO          pstCiclFact       [MAX_CICLFACT]      ;
access ZONAIMPOSITIVA pstZonaImpositiva [MAX_ZONAIMPOSITIVA];
access CATIMPOSITIVA  pstCatImpositiva  [MAX_CATIMPOSITIVA] ;
access TIPIMPUES      pstTipImpues      [MAX_TIPIMPUES]     ;
access DIRECCLI       pstDirecCli       [MAX_DIRECCLI]      ;
access DIRECCIONES    pstDirecciones    [MAX_DIRECCIONES]   ;
access GRPSERCONC     pstGrpSerConc     [MAX_GRPSERCONC]    ;
access ZONACIUDAD     pstZonaCiudad     [MAX_ZONACIUDAD]    ;
access IMPUESTOS      pstImpuestos      [MAX_IMPUESTOS]     ;
access CONCEPTO       pstConceptos      [MAX_CONCEPTOS]     ;
access CONCEPTO_MI    pstConceptos_mi   [MAX_CONCEPTOS_MI]  ;
access ARRIENDO       pstArriendo       [MAX_ARRIENDO]      ;
access RANGOTABLA     pstRangoTabla     [MAX_RANGOTABLA]    ;
access DESACUMULADO   pstDesAcumulado   [MAX_DESACUMULADO]  ;
access PENALIZA       pstPenalizaciones [MAX_PENALIZACIONES];
access TACONCEPFACT   pstTaConcepFact   [MAX_TACONCEPFACT  ];
access FACTCARRIERS   pstFactCarriers   [MAX_FACTCARRIERS]  ;
access CONVERSION     pstConversion     [MAX_CONVERSION]    ;
access TARIFAS        pstTarifas        [MAX_TARIFAS]       ;
access PLANCTOPLAN    pstPlanCtoPlan    [MAX_PLANCTOPLAN]   ;
access CTOPLAN        pstCtoPlan        [MAX_CTOPLAN]       ;
access CUADCTOPLAN    pstCuadCtoPlan    [MAX_CUADCTOPLAN]   ;
access LETRAS         pstLetras         [MAX_LETRAS]        ;
access DOCUMSUCURSAL  pstDocumSucursal  [MAX_DOCUMSUCURSAL] ;
access CABCUOTAS      pstCabCuotas      [MAX_CABCUOTAS]     ;
access CUOTAS         pstCuotas         [MAX_CUOTAS]        ;

access ACTUASERV      pstActuaServ      [MAX_ACTUASERV]     ;
access CARGOSBASICO   pstCargosBasico   [MAX_CARGOSBASICO]  ;
access PLANTARIF      pstPlanTarif      [MAX_PLANTARIF]     ;
access GRUPOCOB       pstGrupoCob       [MAX_GRUPOCOB]      ;
access OPTIMO         pstOptimo         [MAX_OPTIMO]        ;
access OPERADORES     pstOperadores     [MAX_OPERADORES]    ;
access FERIADOS       pstFeriados       [MAX_FERIADOS]      ;
access CARGOSRECURRENTES   pstCargosRecurrentes   [MAX_CARGOSRECURRENTES]  ;

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
access CICLOCLI      pstAbonados	[MAX_ABONADOS]      ;
/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
access TOTZABON stZonaAbon; /* Para Impuestos Colombia */

access int            iArrCiclo         [MAX_CICLFACT]      ;

access GTIPOSTERMINALES  stGTiposTerminales;
access GTIPCOBERTURA     stGTipCoberturas  ;
access OFICINAS		 pstOficinas	   ;
access FACTCOBROS	 pstFactCobros	   ;
access IMPTODCTOS        pstImptoDctos     ;

access FADPARAM		 pstFadParam       ;
/*****************************************************************************/
/* Variables globales que indican el numero de registros que contiene cada   */
/* tabla carga en memoria en el momento de la ejecucion.                     */
/*****************************************************************************/
access int  NUM_PROVINCIAS    ;
access int  NUM_REGIONES      ;
access int  NUM_ALMS          ;
access int  NUM_CATIMPCLIENTES;
access int  NUM_SOLICITUD     ;
access long  NUM_CARGOS        ;
access int  NUM_CICLFACT      ;
access int  NUM_ZONAIMPOSITIVA;
access int  NUM_CATIMPOSITIVA ;
access int  NUM_ACTIVIDADES   ;
access int  NUM_TIPIMPUES     ;
access int  NUM_DIRECCLI      ;
access int  NUM_DIRECCIONES   ;
access int  NUM_GRPSERCONC    ;
access int  NUM_ZONACIUDAD    ;
access int  NUM_IMPUESTOS     ;
access int  NUM_CONCEPTOS     ;
access int  NUM_CONCEPTOS_MI  ;
access int  NUM_RANGOTABLA    ;
access int  NUM_DESACUMULADO  ;
access int  NUM_ARRIENDOS     ;
access int  NUM_PENALIZACIONES;
access int  NUM_TACONCEPFACT  ;
access int  NUM_FACTCARRIERS  ;
access int  NUM_CONVERSION    ;
access int  NUM_TARIFAS       ;
access int  NUM_PLANCTOPLAN   ;
access int  NUM_CTOPLAN       ;
access int  NUM_CUADCTOPLAN   ;
access int  NUM_LETRAS        ;
access int  NUM_DOCUMSUCURSAL ;
access int  NUM_ACTUASERV     ;
access int  NUM_PLANTARIF     ;
access int  NUM_CARGOSBASICO  ;
access int  NUM_GRUPOCOB      ;
access int  NUM_CABCUOTAS     ;
access int  NUM_CUOTAS        ;
access int  NUM_LIMCREDITOS   ;
access int  NUM_OPTIMO        ;
access int  NUM_OPERADORES    ;
access int  NUM_FERIADOS      ;
access int  NUM_CARGOSRECURRENTES;
access int  NUM_IARRCICLO     ;

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
access long  NUM_CICLOCLI     ;
access long  NUM_ABONADOS      ;
/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

#endif /* fin _ESTRUCTURAS_H_ */

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
