/*******************************************************************************
 __DEFINES__
*******************************************************************************/
#define TAM_HOST       30000
#define ORA_NOTNULL    0
#define ORA_NULL       -1

#define SQL_OK         0
#define NOT_FOUND      1403

#ifndef _BOOL_
#define _BOOL_

#define  FALSE  	0
#define  TRUE   	!FALSE

typedef int BOOL;

#endif


void vfnLog( int iCode,        /* Error o Log */ char *szformat,...);

/* bloqueo para evitar colisión de conexiones */
pthread_mutex_t     mutexIO;

/*******************************************************************************
 __STRUCT__
*******************************************************************************/
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
    char   szCodCiudad    [6];
    char   szCodCuota     [3];
    int    iCodModVenta      ;
    char   szCodModulo    [3];
    short  iFlagFaCargo	     ;
}CARGOS;

typedef struct tagCargosRecurrentes
{
    long   lCodCargo       ;
    double dMontoImporte   ;
    char   szCodMoneda [11];
}CARGOSRECURRENTES;

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

typedef struct tagCargos_HOST
{
    char   szRowid	  [TAM_HOST][19];
    long   lNumProceso	  [TAM_HOST]    ;
    long   lNumCargo	  [TAM_HOST]    ;
    long   lNumVenta	  [TAM_HOST]    ;
    long   lCodCliente	  [TAM_HOST]    ;
    short  iCodProducto	  [TAM_HOST]    ;
    int    iCodConcepto   [TAM_HOST]    ;
    char   szDesConcepto  [TAM_HOST][61];
    long   lColumna	  [TAM_HOST]    ;
    char   szFecAlta	  [TAM_HOST][15];
    double dImpCargo	  [TAM_HOST]    ;
    char   szCodMoneda	  [TAM_HOST] [4];
    long   lCodPlanCom	  [TAM_HOST]    ;
    long   lNumUnidades	  [TAM_HOST]    ;
    long   lNumAbonado	  [TAM_HOST]    ;
    char   szNumTerminal  [TAM_HOST][16];
    long   lCodCiclFact	  [TAM_HOST]    ;
    char   szNumSerie	  [TAM_HOST][26];
    char   szNumSerieMec  [TAM_HOST][26];
    long   lCapCode	  [TAM_HOST]    ;
    int    iIndCuota	  [TAM_HOST]    ;
    int    iMesGarantia	  [TAM_HOST]    ;
    char   szNumPreGuia	  [TAM_HOST][11];
    char   szNumGuia	  [TAM_HOST][11];
    long   lNumTransaccion[TAM_HOST]    ;
    long   lNumFactura	  [TAM_HOST]    ;
    int    iCodConceptoDto[TAM_HOST]    ;
    double dValDto	  [TAM_HOST]    ;
    int    iTipDto	  [TAM_HOST]    ;
    short  iIndFactur	  [TAM_HOST]    ;
    int    iNumPaquete	  [TAM_HOST]    ;
    short  iIndSuperTel	  [TAM_HOST]    ;
    char   szCodRegion	  [TAM_HOST] [4];
    char   szCodProvincia [TAM_HOST] [6];
    char   szCodCiudad	  [TAM_HOST] [6];
    char   szCodCuota	  [TAM_HOST] [3];
    int    iCodModVenta	  [TAM_HOST]    ;
    char   szCodModulo	  [TAM_HOST] [3];
}CARGOS_HOST;

typedef struct tagCargosRecurrentes_HOST
{
    long   lCodCargo     [TAM_HOST]    ;
    double dMontoImporte [TAM_HOST]    ;
    char   szCodMoneda   [TAM_HOST][11];
}CARGOSRECURRENTES_HOST;

typedef struct tagCargosRecurrentes_HOST_NULL
{
    short    sdImpCargo [TAM_HOST];
    short    siIndCargo [TAM_HOST];
}CARGOSRECURRENTES_HOST_NULL;

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

typedef struct tagCabCuotas_HOST
{
    char    szRowid	  [TAM_HOST][19];
    long    lSeqCuotas	  [TAM_HOST]    ;
    long    lCodCliente	  [TAM_HOST]    ;
    int     iCodConcepto  [TAM_HOST]    ;
    char    szDesConcepto [TAM_HOST][61];
    char    szCodMoneda	  [TAM_HOST] [4];
    char    szCodModulo	  [TAM_HOST] [3];
    short   iCodProducto  [TAM_HOST]    ;
    int     iNumCuotas	  [TAM_HOST]    ;
    double  dImpTotal	  [TAM_HOST]    ;
    short   iIndPagada	  [TAM_HOST]    ;
    long    lNumAbonado	  [TAM_HOST]    ;
    char    szCodCuota	  [TAM_HOST] [3];
    long    lNumPagare	  [TAM_HOST]    ;
    int     iNCuotas	  [TAM_HOST]    ;
    CUOTAS *pCuotas	  [TAM_HOST]    ;
}CABCUOTAS_HOST;

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

typedef struct tagTaConcepFact_HOST
{
    short  iCodProducto	    [TAM_HOST]   ;
    int    iCodFacturacion  [TAM_HOST]   ;
    short  iIndTabla	    [TAM_HOST]   ;
    short  iIndEntSal	    [TAM_HOST]   ;
    int    iCodTarificacion [TAM_HOST]   ;
    int    iIndDestino	    [TAM_HOST]   ;
    char   szCodServicio    [TAM_HOST][6];
}TACONCEPFACT_HOST;

typedef struct tagCuotas_HOST
{
    char   szRowid	[TAM_HOST][19];
    long   lSeqCuotas   [TAM_HOST]    ;
    int    iOrdCuota	[TAM_HOST]    ;
    char   szFecEmision	[TAM_HOST][15];
    double dImpCuota	[TAM_HOST]    ;
    short  iIndFacturado[TAM_HOST]    ;
    short  iIndFactur	[TAM_HOST]    ;
    short  iIndPagado	[TAM_HOST]    ;
}CUOTAS_HOST;

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
    long   lFactor           ;
    int    iCodGrpServi      ;
} CONCEPTO;

typedef struct tagCONCEPTO_MI
{
    int	   iCodConcepto;
    char   szCodIdioma    [6];
    char   szDesConcepto [61];
} CONCEPTO_MI;

typedef struct tagRangoTabla
{
    long  lCodCiclFact   ;
    long  lRangoIni      ;
    long  lRangoFin      ;
    int   iCodProducto   ;
    char  szNomTabla [21];
}RANGOTABLA;

typedef struct tagLimCreditos
{
    int   iCodCredMor       ;
    int   iCodProducto      ;
    char  szCodCalClien  [3];
    double dImpMorosidad    ;
}LIMCREDITOS;

typedef struct tagActividades
{
    int   iCodActividad     ;
    char  szDesActividad[51];
}ACTIVIDADES;

typedef struct tagProvincias
{
    char  szCodRegion    [4];
    char  szCodProvincia [6];
}PROVINCIAS;

typedef struct tagRegiones
{
    char szCodRegion  [4];
    char szDesRegion [31];
}REGIONES;

typedef struct tagCatImpositiva
{
    int    iCodCatImpos       ;
    char   szDesCatImpos  [41];
}CATIMPOSITIVA;

typedef struct tagGeZonaCiudad
{
    char  szFecDesde     [15];
    char  szFecHasta     [15];
    char  szCodRegion     [4];
    char  szCodProvincia  [6];
    char  szCodCiudad     [6];
    int   iCodZonaImpo       ;
}ZONACIUDAD;

typedef struct tagZonaImpositiva
{
    int    iCodZonaImpo       ;
    char   szDesZonaImpo  [41];
}ZONAIMPOSITIVA;

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
    float  fPrcImpuesto      ;
    int    iTipMonto         ;
    double dImpUmbral        ;
    double dImpMaximo        ;
}IMPUESTOS;

typedef struct tagTipImpues
{
    int    iCodTipImpue       ;
    double dImpUmbral         ;
    int    iTipMonto          ;
    int    iCodCateImp        ;
}TIPIMPUES                    ;

typedef struct tagFaGrpserconc
{
    int   iCodConcepto       ;
    char  szFecDesde     [15];
    int   iCodGrpServi       ;
    char  szFecHasta     [15];
}GRPSERCONC;

typedef struct tagConversion
{
    char   szCodMoneda   [4];
    char   szFecDesde   [15];
    char   szFecHasta   [15];
    double dCambio          ;
}CONVERSION;

typedef struct tagAlDocumSucursal
{
    char  szCodOficina [3];
    int   iCodTipDocum    ;
    int   iCodCentrEmi    ;
}DOCUMSUCURSAL;

typedef struct tagLetras
{
    int   iCodTipDocum     ;
    int   iCodCatImpos     ;
    char  szLetra       [2];
}LETRAS;

typedef struct tagGrupoCob
{
    char   szCodGrupo   [3];
    short  iCodProducto    ;
    int    iCodConcepto    ;
    int    iCodCiclo       ;
    char   szFecDesde  [15];
    char   szFecHasta  [15];
    short  iTipCobro       ;
}GRUPOCOB;

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

typedef struct tagActuaServ
{
    char   szCodTipServ [2] ;
    char   szCodServicio[4] ;
    int    iCodConcepto     ;
}ACTUASERV;

typedef struct tagFactCarriers
{
    int    iCodConcFact   ;
    int    iCodConcCarrier;
    int	   iCodTipConce   ;
}FACTCARRIERS;

typedef struct tagCuadCtoPlan
{
    long   lCodCtoPlan      ;
    double dImpUmbDesde     ;
    double dImpUmbHasta     ;
    double dImpDescuento    ;
    short  iCodTipoDto      ;
}CUADCTOPLAN;

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

typedef struct tagPlanCtoPlan
{
    long  lCodPlanCom            ;
    short iCodProducto           ;
    long  lCodCtoPlan            ;
    char  szFecEfectividad   [15];
    char  szFecFinEfectividad[15];
}PLANCTOPLAN;

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

typedef struct tagCargosBasico
{
    char   szCodCargoBasico [4];
    double dImpCargoBasico     ;
    char   szCodMoneda      [4];
}CARGOSBASICO;

typedef struct tagOptimo
{
    char   szCodPlanTarif [4];
    long   lMinDesde         ;
    long   lMinHasta         ;
    float  fPrcAbono         ;
    float  fPrcNormal        ;
    float  fPrcBajo          ;
}OPTIMO;

typedef struct tagFeriados
{
    char szFecFeriado  [15];
}FERIADOS;

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
}PENALIZA;

typedef struct tag_FAC_CLIENTES
{
    long   lRowNum               ;
    long   lCargos               ;
    long   lCodCliente           ;
    int    iCodEstado            ;
    pthread_mutex_t mMutexLock   ;
    char   szNomCliente      [51];
    char   szNomApeClien1    [21];
    char   szNomApeClien2    [21];
    char   szTefCliente1     [16];
    char   szTefCliente2     [16];
    char   szCodPais          [4];
    char   szIndDebito        [2];
    double dImpStopDebit         ;
    char   szCodBanco        [16];
    char   szCodSucursal      [5];
    char   szIndTipCuenta     [2];
    char   szCodTipTarjeta    [4];
    char   szNumCtaCorr      [19];
    char   szNumTarjeta      [19];
    char   szFecVenciTarj    [15];
    char   szCodBancoTarj    [16];
    char   szCodTipIdTrib     [3];
    char   szNumIdentTrib    [21];
    int    iCodActividad         ;
    char   szCodOficina       [3];
    int    iIndFactur            ;
    char   szNumFax          [16];
    char   szFecAlta         [15];
    long   lCodCuenta            ;
    char   szCodIdioma        [6];
    char   szCodOperadora     [6];
    int    iCodCatImpos		 ;
    char   szIndOrdenTotal   [13];
    char   szCodRegion_1      [4];
    char   szCodProvincia_1   [6];
    char   szCodCiudad_1      [6];
    char   szCodComuna_1      [6];
    char   szNomCalle_1      [51];
    char   szNumCalle_1      [11];
    char   szNumPiso_1       [11];
    char   szCodRegion_3      [4];
    char   szCodProvincia_3   [6];
    char   szCodCiudad_3      [6];
    char   szCodComuna_3      [6];
    char   szNomCalle_3      [51];
    char   szNumCalle_3      [11];
    char   szNumPiso_3       [11];
    char   szCodBancoUniPac  [16];
    char   szCodSegmentacion  [6];
    char   szCodDespacho      [6];
    char   szNomEmail        [71];
    char   szCodIdTipDian     [3];  
    int    iIndClieLoc           ;  
}FAC_CLIENTES;

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

typedef struct tag_GE_CATIMPCLIENTES
{
    long   lCodCliente 	 	;
    int    iCodCatImpos		;
    char   szIndOrdenTotal[13]	;
}CAT_IMPCLIENTES;

typedef struct tag_GE_DIRECCIONES
{
    long   lCodCliente 	 	;
    char   szCodRegion [4]   	;
    char   szCodProvincia [6]	;
    char   szCodCiudad [6]  	;
    char   szCodComuna [6]  	;
    char   szNomCalle  [51]  	;
    char   szNumCalle  [11]  	;
    char   szNumPiso   [11] 	;
}DIRECCIONES;

typedef struct tag_GE_DIRECCIONES2
{
    long   lCodCliente 	 	;
    char   szCodRegion [4]   	;
    char   szCodProvincia [6]	;
    char   szCodCiudad [6]  	;
    char   szCodComuna [6]  	;
    char   szNomCalle  [51]  	;
    char   szNumCalle  [11]  	;
    char   szNumPiso   [11] 	;
}DIRECCIONES2;

typedef struct tag_CO_UNIPAC
{
    long   lCodCliente 	 ;
    char   szCodBanco[16];
}UNIPAC;

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

typedef struct tagOficina
{
    char szCodOficina	[3];
    char szCodRegion	[4];
    char szCodProvincia	[6];
    char szCodCiudad 	[6];
    char szCodPlaza	    [6];
}OFICINA;

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

typedef struct tagFactCobros
{
    int         iNumFactCobros;
    FACTCOBR  	*stFactCobr;
}FACTCOBROS;

/* rao */
typedef struct tagDetPlanDesc
{
	char 	szCodPlan 			[6] ;
	char 	szDesPlandesc     	[31];
    char 	szFecDesdePlandesc	[15];
    char 	szFecHastaPlandesc	[15];
    char 	szIndRestriccion  	[2] ;
    char 	szFecDesdeDetplan 	[15];
    char 	szFecHastaDetplan 	[15];
    char 	szCodTipeval      	[2] ;
    char 	szCodTipapli      	[2] ;
    int  	iCodGrupoeval 		;
    int  	iCodGrupoapli 		;
    int  	iNumCuadrante 		;
    char 	szTipUnidad      	[3] ;
    int  	iCodConcdesc 			;
    double 	dMtoMinfact  			;

}DETPLANDESC;

/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/*************************  HOST**************************/

typedef struct tagCONCEPTO_HOST
{
    int    iCodConcepto  [TAM_HOST];
    short  iCodProducto [TAM_HOST]     ;
    char   szDesConcepto [TAM_HOST][61];
    int    iCodTipConce [TAM_HOST]     ;
    char   szCodModulo [TAM_HOST][3] ;
    char   szCodMoneda [TAM_HOST][4] ;
    short  iIndActivo [TAM_HOST]       ;
    int    iCodConcOrig [TAM_HOST]     ;
    char   szCodTipDescu [TAM_HOST][2] ;
    int    iCodConCobr  [TAM_HOST]     ;
    long   lFactor		[TAM_HOST]	 ;
    int    iCodGrpServi     [TAM_HOST];
} CONCEPTO_HOST;

typedef struct tagCONCEPTO_MI_HOST
{
	int    iCodConcepto  [TAM_HOST];
/*  char   szCodConcepto [TAM_HOST][12]    ;	*/
    char   szCodIdioma  [TAM_HOST][6] ;
    char   szDesConcepto [TAM_HOST][61];
} CONCEPTO_MI_HOST;

typedef struct tagRangoTabla_HOST
{
    long  lCodCiclFact [TAM_HOST];
    long  lRangoIni [TAM_HOST];
    long  lRangoFin [TAM_HOST];
    int   iCodProducto [TAM_HOST];
    char  szNomTabla [TAM_HOST][21];
}RANGOTABLA_HOST;

typedef struct tagLimCreditos_HOST
{
    int   iCodCredMor [TAM_HOST];
    int   iCodProducto [TAM_HOST] ;
    char  szCodCalClien  [TAM_HOST][3];
    double dImpMorosidad [TAM_HOST];
}LIMCREDITOS_HOST;

typedef struct tagActividades_HOST
{
    int   iCodActividad [TAM_HOST];
    char  szDesActividad [TAM_HOST][51];
}ACTIVIDADES_HOST;

typedef struct tagProvincias_HOST
{
    char  szCodRegion    [TAM_HOST][4];
    char  szCodProvincia [TAM_HOST][6];
}PROVINCIAS_HOST;

typedef struct tagRegiones_HOST
{
    char szCodRegion  [TAM_HOST][4];
    char szDesRegion [TAM_HOST][31];
}REGIONES_HOST;

typedef struct tagCatImpositiva_HOST
{
    int    iCodCatImpos [TAM_HOST];
    char   szDesCatImpos  [TAM_HOST][41];
}CATIMPOSITIVA_HOST;

typedef struct tagGeZonaCiudad_HOST
{
    char  szFecDesde     [TAM_HOST][15];
    char  szFecHasta     [TAM_HOST][15];
    char  szCodRegion     [TAM_HOST][4];
    char  szCodProvincia  [TAM_HOST][6];
    char  szCodCiudad     [TAM_HOST][6];
    int   iCodZonaImpo [TAM_HOST]      ;
}ZONACIUDAD_HOST;

typedef struct tagZonaImpositiva_HOST
{
    int    iCodZonaImpo   [TAM_HOST];
    char   szDesZonaImpo  [TAM_HOST][41];
}ZONAIMPOSITIVA_HOST;

typedef struct tagGeImpuestos_HOST
{
    int   iCodCatImpos   [TAM_HOST]    ;
    int   iCodZonaImpo   [TAM_HOST]    ;
    int   iCodZonaAbon   [TAM_HOST]    ;
    int   iCodTipImpues  [TAM_HOST]    ;
    int   iCodGrpServi   [TAM_HOST]    ;
    int   iCodConcGene   [TAM_HOST]    ;
    char  szFecDesde     [TAM_HOST][15];
    char  szFecHasta     [TAM_HOST][15];
    float fPrcImpuesto   [TAM_HOST]    ;
    int   iTipMonto      [TAM_HOST]    ;
    double dImpUmbral    [TAM_HOST]    ;
    double dImpMaximo    [TAM_HOST]    ;
}IMPUESTOS_HOST;

typedef struct tagFaGrpserconc_HOST
{
    int   iCodConcepto   [TAM_HOST]    ;
    char  szFecDesde     [TAM_HOST][15];
    int   iCodGrpServi   [TAM_HOST]    ;
    char  szFecHasta     [TAM_HOST][15];
}GRPSERCONC_HOST;

typedef struct tagConversion_HOST
{
    char   szCodMoneda   [TAM_HOST][4];
    char   szFecDesde   [TAM_HOST][15];
    char   szFecHasta   [TAM_HOST][15];
    double dCambio      [TAM_HOST]    ;
}CONVERSION_HOST;

typedef struct tagAlDocumSucursal_HOST
{
    char  szCodOficina [TAM_HOST][3];
    int   iCodTipDocum [TAM_HOST]   ;
    int   iCodCentrEmi [TAM_HOST]   ;
}DOCUMSUCURSAL_HOST;

typedef struct tagLetras_HOST
{
    int   iCodTipDocum  [TAM_HOST]   ;
    int   iCodCatImpos  [TAM_HOST]   ;
    char  szLetra       [TAM_HOST][2];
}LETRAS_HOST;

typedef struct tagGrupoCob_HOST
{
    char   szCodGrupo  [TAM_HOST][3] ;
    short  iCodProducto [TAM_HOST]   ;
    int    iCodConcepto [TAM_HOST]   ;
    int    iCodCiclo    [TAM_HOST]   ;
    char   szFecDesde  [TAM_HOST][15];
    char   szFecHasta  [TAM_HOST][15];
    short  iTipCobro   [TAM_HOST]    ;
}GRUPOCOB_HOST;

typedef struct tagTarifas_HOST
{
    char   szCodTipServ  [TAM_HOST][2];
    char   szCodServicio [TAM_HOST][4];
    char   szCodPlanServ [TAM_HOST][4];
    char   szFecDesde   [TAM_HOST][15];
    double dImpTarifa   [TAM_HOST]    ;
    char   szCodMoneda   [TAM_HOST][4];
    char   szIndPeriodico [TAM_HOST][2];
    char   szFecHasta   [TAM_HOST][15];
}TARIFAS_HOST;

typedef struct tagActuaServ_HOST
{
    char   szCodTipServ [TAM_HOST][2] ;
    char   szCodServicio [TAM_HOST][4] ;
    int    iCodConcepto  [TAM_HOST]   ;
}ACTUASERV_HOST;

typedef struct tagFactCarriers_HOST
{
    int    iCodConcFact    [TAM_HOST];
    int    iCodConcCarrier [TAM_HOST];
    int	   iCodTipConce    [TAM_HOST];

}FACTCARRIERS_HOST;

typedef struct tagCuadCtoPlan_HOST
{
    long   lCodCtoPlan  [TAM_HOST]    ;
    double dImpUmbDesde [TAM_HOST]    ;
    double dImpUmbHasta [TAM_HOST]    ;
    double dImpDescuento  [TAM_HOST]  ;
    short  iCodTipoDto    [TAM_HOST]  ;
}CUADCTOPLAN_HOST;

typedef struct tagCtoPlan_HOST
{
    long   lCodCtoPlan   [TAM_HOST]    ;
    short  iCodProducto  [TAM_HOST]    ;
    char   szCodTipCtoPlan [TAM_HOST][2];
    char   szCodMoneda    [TAM_HOST][4];
    int    iCodCtoFac     [TAM_HOST]   ;
    double dImpDescuento  [TAM_HOST]   ;
    short  iCodTipoDto    [TAM_HOST]   ;
    short  iIndCuadrante  [TAM_HOST]   ;
    short  iCodTipoCuad   [TAM_HOST]   ;
    double dImpUmbDesde  [TAM_HOST]    ;
    double dImpUmbHasta  [TAM_HOST]    ;
    int    iNumDias      [TAM_HOST]    ;
}CTOPLAN_HOST;

typedef struct tagPlanCtoPlan_HOST
{
    long  lCodPlanCom        [TAM_HOST]    ;
    short iCodProducto       [TAM_HOST]    ;
    long  lCodCtoPlan        [TAM_HOST]    ;
    char  szFecEfectividad   [TAM_HOST][15];
    char  szFecFinEfectividad [TAM_HOST][15];
}PLANCTOPLAN_HOST;

typedef struct tagArriendo_HOST
{
    char   szRowid      [TAM_HOST][19];
    long   lCodCliente  [TAM_HOST]    ;
    long   lNumAbonado  [TAM_HOST]    ;
    char   szFecDesde   [TAM_HOST][15];
    char   szFecHasta   [TAM_HOST][15];
    int    iNumDiasArriendo [TAM_HOST];
    int    iCodProducto  [TAM_HOST]   ;
    int    iCodConcepto  [TAM_HOST]   ;
    char   szDesConcepto [TAM_HOST][61];
    long   lCodArticulo  [TAM_HOST]   ;
    double dPrecioMes    [TAM_HOST]   ;
    double dImpConcepto  [TAM_HOST]   ;
    char   szCodMoneda   [TAM_HOST][4];
    char   szCodGrpServ  [TAM_HOST][3];
    char   szCodModulo   [TAM_HOST][3];
}ARRIENDO_HOST;

typedef struct tagCargosBasico_HOST
{
    char   szCodCargoBasico [TAM_HOST][4];
    double dImpCargoBasico  [TAM_HOST]   ;
    char   szCodMoneda      [TAM_HOST][4];
}CARGOSBASICO_HOST;

typedef struct tagOptimo_HOST
{
    char   szCodPlanTarif [TAM_HOST][4];
    long   lMinDesde      [TAM_HOST]   ;
    long   lMinHasta      [TAM_HOST]   ;
    float  fPrcAbono      [TAM_HOST]   ;
    float  fPrcNormal     [TAM_HOST]   ;
    float  fPrcBajo       [TAM_HOST]   ;
}OPTIMO_HOST;

typedef struct tagFeriados_HOST
{
    char szFecFeriado  [TAM_HOST][15];
}FERIADOS_HOST;

typedef struct tagPlanTarif_HOST
{
    char  szCodPlanTarif  [TAM_HOST][4]  ;
    char  szTipTerminal   [TAM_HOST][2]  ;
    char  szCodLimConsumo [TAM_HOST][4]  ;
    char  szCodCargoBasico[TAM_HOST][4]  ;
    char  szTipPlanTarif  [TAM_HOST][2]  ;
    char  szTipUnidades   [TAM_HOST][2]  ;
    long  lNumUnidades    [TAM_HOST]     ;
    short iIndArrastre    [TAM_HOST]     ;
    int   iNumDias        [TAM_HOST]     ;
    long  lNumAbonados    [TAM_HOST]     ;
    char  szInd_Francons  [TAM_HOST][3]  ;
    short iFlgRango       [TAM_HOST]     ;
    char  szIndCompartido [TAM_HOST][1+1];    
    int   iTipCobro       [TAM_HOST]     ;    
}PLANTARIF_HOST;

typedef struct tagPenaliza_HOST
{
    char   szRowid          [TAM_HOST][19];
    long   lCodCliente      [TAM_HOST]    ;
    int    iTipIncidencia   [TAM_HOST]    ;
    char   szFecEfectividad [TAM_HOST][15];
    char   szCodMoneda      [TAM_HOST][4];
    char   szCodModulo      [TAM_HOST][3];
    double dImpPenaliz      [TAM_HOST]   ;
    long   lCodCiclFact     [TAM_HOST]   ;
    int    iCodConcepto     [TAM_HOST]   ;
    char   szDesConcepto    [TAM_HOST][61];
    int    iCodTipConce     [TAM_HOST]   ;
    short  iIndActivo       [TAM_HOST]   ;
    short  iIndFactur       [TAM_HOST]   ;
    int    iCodProducto     [TAM_HOST]   ;
    long   lNumAbonado      [TAM_HOST]   ;
    long   lNumProceso      [TAM_HOST]   ;
} PENALIZA_HOST                   ;
/*
typedef struct tagTipImpues_HOST
{
    int    iCodTipImpue   [TAM_HOST]    ;
    double dImpUmbral     [TAM_HOST]    ;
    int    iTipMonto      [TAM_HOST]    ;
    int    iCodCateImp    [TAM_HOST]    ;
}TIPIMPUES_HOST;
*/
typedef struct tag_FAC_CLIENTES_HOST
{
    long   lRowNum           [TAM_HOST]    ;
    long   lCodCliente       [TAM_HOST]    ;
    char   szNomCliente      [TAM_HOST][51];
    char   szNomApeClien1    [TAM_HOST][21];
    char   szNomApeClien2    [TAM_HOST][21];
    char   szTefCliente1     [TAM_HOST][16];
    char   szTefCliente2     [TAM_HOST][16];
    char   szCodPais         [TAM_HOST] [4];
    char   szIndDebito       [TAM_HOST] [2];
    double dImpStopDebit     [TAM_HOST]    ;
    char   szCodBanco        [TAM_HOST][16];
    char   szCodSucursal     [TAM_HOST] [5];
    char   szIndTipCuenta    [TAM_HOST] [2];
    char   szCodTipTarjeta   [TAM_HOST] [4];
    char   szNumCtaCorr      [TAM_HOST][19];
    char   szNumTarjeta      [TAM_HOST][19];
    char   szFecVenciTarj    [TAM_HOST][15];
    char   szCodBancoTarj    [TAM_HOST][16];
    char   szCodTipIdTrib    [TAM_HOST] [3];
    char   szNumIdentTrib    [TAM_HOST][21];
    int    iCodActividad     [TAM_HOST]    ;
    char   szCodOficina      [TAM_HOST] [3];
    int    iIndFactur        [TAM_HOST]    ;
    char   szNumFax          [TAM_HOST][16];
    char   szFecAlta         [TAM_HOST][15];
    long   lCodCuenta        [TAM_HOST]    ;
    char   szCodIdioma       [TAM_HOST] [6];
    char   szCodOperadora    [TAM_HOST] [6];
    char   szCodSegmentacion [TAM_HOST] [6];
    char   szCodDespacho     [TAM_HOST] [6];
    char   szNomEmail        [TAM_HOST][71];
    char   szCodIdTipDian    [TAM_HOST] [3];
    int    iIndClieLoc       [TAM_HOST]    ;
}FAC_CLIENTES_HOST;

typedef struct tag_CICLOCLI_HOST
{
    char   szRowid        [TAM_HOST][19];
    long   lCodCliente    [TAM_HOST]    ;
    short  iCodProducto   [TAM_HOST]    ;
    long   lNumAbonado    [TAM_HOST]    ;
    char   szCodCalClien  [TAM_HOST] [3];
    short  iIndCambio     [TAM_HOST]    ;
    char   szNomUsuario   [TAM_HOST][21];
    char   szNomApellido1 [TAM_HOST][21];
    char   szNomApellido2 [TAM_HOST][21];
    int    iCodCredMor    [TAM_HOST]    ;
    char   szIndDebito    [TAM_HOST] [2];
    int    iCodCicloNue   [TAM_HOST]    ;
    char   szFecAlta      [TAM_HOST][15];
    char   szFecUltFact   [TAM_HOST][15];
}CICLOCLI_HOST;

typedef struct tag_GE_CATIMPCLIENTES_HOST
{
    long   lCodCliente 	  [TAM_HOST] 	;
    int    iCodCatImpos	  [TAM_HOST]	;
    char   szIndOrdenTotal[TAM_HOST][13];
}CAT_IMPCLIENTES_HOST;

typedef struct tag_GE_DIRECCIONES_HOST
{
    long   lCodCliente [TAM_HOST]	;
    char   szCodRegion [TAM_HOST][4]   	;
    char   szCodProvincia [TAM_HOST][6]	;
    char   szCodCiudad [TAM_HOST][6]  	;
    char   szCodComuna [TAM_HOST][6]  	;
    char   szNomCalle  [TAM_HOST][51]  	;
    char   szNumCalle  [TAM_HOST][11]  	;
    char   szNumPiso   [TAM_HOST][11] 	;
}DIRECCIONES_HOST;

typedef struct tag_GE_DIRECCIONES_HOST2
{
    long   lCodCliente [TAM_HOST]	;
    char   szCodRegion [TAM_HOST][4]   	;
    char   szCodProvincia [TAM_HOST][6]	;
    char   szCodCiudad [TAM_HOST][6]  	;
    char   szCodComuna [TAM_HOST][6]  	;
    char   szNomCalle  [TAM_HOST][51]  	;
    char   szNumCalle  [TAM_HOST][11]  	;
    char   szNumPiso   [TAM_HOST][11] 	;
}DIRECCIONES_HOST2;

typedef struct tag_CO_UNIPAC_HOST
{
    long   lCodCliente [TAM_HOST]  ;
    char   szCodBanco[TAM_HOST][16];
}UNIPAC_HOST;

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

typedef struct tagOficina_Hosts
{
    char szCodOficina	[TAM_HOST][3];
    char szCodRegion	[TAM_HOST][4];
    char szCodProvincia	[TAM_HOST][6];
    char szCodCiudad 	[TAM_HOST][6];
    char szCodPlaza	    [TAM_HOST][6];
}OFICINA_HOST;

typedef struct tagFactCobr_Hosts
{
    int iCodConcFact [TAM_HOST];
    int iCodConCobr  [TAM_HOST];
}FACTCOBR_HOST;

typedef struct tagDetPlanDesc_Hosts
{
	char 	szCodPlan			[TAM_HOST][6] ;
	char 	szDesPlandesc     	[TAM_HOST][31];
    char 	szFecDesdePlandesc	[TAM_HOST][15];
    char 	szFecHastaPlandesc	[TAM_HOST][15];
    char 	szIndRestriccion  	[TAM_HOST][2] ;
    char 	szFecDesdeDetplan 	[TAM_HOST][15];
    char 	szFecHastaDetplan 	[TAM_HOST][15];
    char 	szCodTipeval      	[TAM_HOST][2] ;
    char 	szCodTipapli      	[TAM_HOST][2] ;
    int  	iCodGrupoeval 		[TAM_HOST]	;
    int  	iCodGrupoapli 		[TAM_HOST]	;
    int  	iNumCuadrante 		[TAM_HOST]	;
    char 	szTipUnidad      	[TAM_HOST][3] ;
    int  	iCodConcdesc 		[TAM_HOST]	;
    double 	dMtoMinfact  		[TAM_HOST]	;
}DETPLANDESC_HOST;



/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/************************ FIN HOST ************************/

/****************** STRUCT HOST_NULL **********************/

typedef struct tagCargos_HOST_NULL
{

    short    slNumAbonado   [TAM_HOST]    ;
    short    sszNumTerminal [TAM_HOST];
    short    slCodCiclFact  [TAM_HOST]    ;
    short    sszNumSerie    [TAM_HOST];
    short    sszNumSerieMec [TAM_HOST];
    short    slCapCode      [TAM_HOST]    ;
    short    siIndCuota     [TAM_HOST]    ;
    short    siMesGarantia  [TAM_HOST]    ;
    short    sszNumPreGuia  [TAM_HOST];
    short    sszNumGuia     [TAM_HOST];
    short    siCodConceptoDto  [TAM_HOST] ;
    short    sdValDto       [TAM_HOST]    ;
    short    siTipDto       [TAM_HOST]    ;
    short    siNumPaquete   [TAM_HOST]    ;
    short    siIndSuperTel  [TAM_HOST]    ;
    short    slNumTransaccion [TAM_HOST];
    short    slNumVenta       [TAM_HOST];
    short    slNumFactura     [TAM_HOST];
}CARGOS_HOST_NULL;

typedef struct tagCabCuotas_HOST_NULL
{
    short    sszCodCuota	[TAM_HOST];
}CABCUOTAS_HOST_NULL;

typedef struct tagCONCEPTO_HOST_NULL
{
    short    siCodConcOrig [TAM_HOST]     ;
    short    sszCodTipDescu [TAM_HOST];
    short	 slFactor[TAM_HOST];
} CONCEPTO_HOST_NULL;

typedef struct tagTarifas_HOST_NULL
{
    short    sszFecHasta   [TAM_HOST];
}TARIFAS_HOST_NULL;

typedef struct tagActuaServ_HOST_NULL
{
    short    siCodConcepto  [TAM_HOST];
}ACTUASERV_HOST_NULL;

typedef struct tagCtoPlan_HOST_NULL
{
    short    sdImpUmbDesde  [TAM_HOST];
    short    sdImpUmbHasta  [TAM_HOST];
    short    siNumDias       [TAM_HOST];
}CTOPLAN_HOST_NULL;

typedef struct tagCargosBasico_HOST_NULL
{
    short    sszFecHasta    [TAM_HOST];
}CARGOSBASICO_HOST_NULL;

typedef struct tagOptimo_HOST_NULL
{
    short    slMinHasta     [TAM_HOST];
}OPTIMO_HOST_NULL;

typedef struct tagPlanTarif_HOST_NULL
{
    short    sszTipTerminal [TAM_HOST];
    short    slNumAbonados  [TAM_HOST];
    short    sszFecHasta    [TAM_HOST];
}PLANTARIF_HOST_NULL;

typedef struct tagPenaliza_HOST_NULL
{
    short    slCodCiclFact  [TAM_HOST];
    short    slNumAbonado   [TAM_HOST];
}PENALIZA_HOST_NULL;

typedef struct tag_CICLOCLI_HOST_NULL
{
    short    sszNomApellido2  [TAM_HOST];
    short    siCodCredMor    [TAM_HOST];
    short    sszIndDebito    [TAM_HOST];
    short    siCodCicloNue   [TAM_HOST];
}CICLOCLI_HOST_NULL;

typedef struct tag_FAC_CLIENTES_HOST_NULL
{
    short   sszNomApeClien1 [TAM_HOST];
    short   sszNomApeClien2 [TAM_HOST];
    short   sszTefCliente1  [TAM_HOST];
    short   sszTefCliente2  [TAM_HOST];
    short   sszCodPais      [TAM_HOST];
    short   sszIndDebito    [TAM_HOST];
    short   sdImpStopDebit  [TAM_HOST];
    short   sszCodBanco     [TAM_HOST];
    short   sszCodSucursal  [TAM_HOST];
    short   sszIndTipCuenta [TAM_HOST];
    short   sszCodTipTarjeta[TAM_HOST];
    short   sszNumCtaCorr   [TAM_HOST];
    short   sszNumTarjeta   [TAM_HOST];
    short   sszFecVenciTarj [TAM_HOST];
    short   sszCodBancoTarj [TAM_HOST];
    short   sszCodTipIdTrib [TAM_HOST];
    short   sszNumIdentTrib [TAM_HOST];
    short   siCodActividad  [TAM_HOST];
    short   sszCodOficina   [TAM_HOST];
    short   sszNumFax       [TAM_HOST];
    short   sszCodOperadora [TAM_HOST];
    short   sszCodDespacho  [TAM_HOST];
    short   sszNomEmail     [TAM_HOST];    
}FAC_CLIENTES_HOST_NULL;

typedef struct tag_GE_DIRECCIONES_HOST_NULL
{
    short 	sszCodRegion [TAM_HOST];   
	short 	sszCodProvincia[TAM_HOST];
	short 	sszCodCiudad [TAM_HOST];
	short 	sszCodComuna [TAM_HOST];
	short   sszNomCalle  [TAM_HOST];
    short   sszNumCalle  [TAM_HOST];
    short   sszNumPiso   [TAM_HOST];
}DIRECCIONES_HOST_NULL;

typedef struct tag_GE_DIRECCIONES_HOST_NULL2
{
    short 	sszCodRegion [TAM_HOST];   
	short 	sszCodProvincia[TAM_HOST];
	short 	sszCodCiudad [TAM_HOST];
	short 	sszCodComuna [TAM_HOST];
	short   sszNomCalle  [TAM_HOST];
    short   sszNumCalle  [TAM_HOST];
    short   sszNumPiso   [TAM_HOST];
}DIRECCIONES_HOST_NULL2;

typedef struct tagDetPlanDesc_HOST_NULL
{
    short  	i_shCodGrupoeval   [TAM_HOST]	;
    short 	i_shCodGrupoapli   [TAM_HOST]	;
    short 	i_shNumCuadrante   [TAM_HOST]	;
    short 	i_shCodConcdesc    [TAM_HOST]	;
    short 	i_shMtoMinfact     [TAM_HOST]	;
}DETPLANDESC_HOST_NULL;


/************************ FIN STRUCT HOST NULL************************/

/*******************************************************************************
 __C-PROTOTIPE__
*******************************************************************************/
BOOL 	bfnObtGeCargosRecurrentes ( long *lGeCargosRecurrentes,CARGOSRECURRENTES **pstlGeCargosRecurrentes,void* ctx);
BOOL	bfnObtGeCargos(long *lGeCargos,CARGOS **pstlGeCargos,void* ctx, long ciclo, long ci, long cf);
BOOL    bfnObtGeCabCuotas(long *lGeCabCuotas,CABCUOTAS **pstlGeCabCuotas, void* ctx);
BOOL    bfnObtGeTaConcepFact(long *lGeTaConcepFact,TACONCEPFACT **pstlGeTaConcepFact, void* ctx);
BOOL    bfnObtGeConceptos(long *lGeConceptos,CONCEPTO **pstlGeConceptos, void* ctx, long ciclo);
BOOL    bfnObtGeConceptos_Mi(long *lGeConceptos_Mi,CONCEPTO_MI **pstlGeConceptos_Mi, void* ctx);
BOOL    bfnObtGeRangoTabla(long *lGeRangoTabla,RANGOTABLA **pstlGeRangoTabla, void* ctx);
BOOL    bfnObtGeLimCreditos(long *lGeLimCreditos,LIMCREDITOS **pstlGeLimCreditos, void* ctx);
BOOL    bfnObtGeActividades(long *lGeActividades,ACTIVIDADES **pstlGeActividades, void* ctx);
BOOL    bfnObtGeProvincias(long *lGeProvincias,PROVINCIAS **pstlGeProvincias, void* ctx);
BOOL    bfnObtGeRegiones(long *lGeRegiones,REGIONES **pstlGeRegiones, void* ctx);
BOOL    bfnObtGeCatImpositiva(long *lGeCatImpositiva,CATIMPOSITIVA **pstlGeCatImpositiva, void* ctx);
BOOL    bfnObtGeZonaCiudad(long *lGeZonaCiudad,ZONACIUDAD **pstlGeZonaCiudad, void* ctx);
BOOL    bfnObtGeZonaImpositiva(long *lGeZonaImpositiva,ZONAIMPOSITIVA **pstlGeZonaImpositiva, void* ctx);
BOOL    bfnObtGeImpuestos(long *lGeImpuestos,IMPUESTOS **pstlGeImpuestos, void* ctx);
//BOOL    bfnObtGeTipImpues(long *lGeTipImpues,TIPIMPUES **pstlGeTipImpues, void* ctx);
BOOL    bfnObtGeGrpSerConc(long *lGeGrpSerConc,GRPSERCONC **pstlGeGrpSerConc, void* ctx);
BOOL    bfnObtGeConversion(long *lGeConversion,CONVERSION **pstlGeConversion, void* ctx);
BOOL    bfnObtGeDocumSucursal(long *lGeDocumSucursal,DOCUMSUCURSAL **pstlGeDocumSucursal, void* ctx);
BOOL    bfnObtGeLetras(long *lGeLetras,LETRAS **pstlGeLetras, void* ctx);
BOOL    bfnObtGeGrupoCob(long *lGeGrupoCob,GRUPOCOB **pstlGeGrupoCob, void* ctx, int ciclo);
BOOL    bfnObtGeTarifas(long *lGeTarifas,TARIFAS **pstlGeTarifas, void* ctx);
BOOL    bfnObtGeActuaServ(long *lGeActuaServ,ACTUASERV **pstlGeActuaServ, void* ctx);
BOOL    bfnObtGeCuotas(long *lGeCuotas,CUOTAS **pstlGeCuotas, void* ctx);
BOOL    bfnObtGeFactCarriers(long *lGeFactCarriers,FACTCARRIERS **pstlGeFactCarriers, void* ctx);
BOOL    bfnObtGeCuadCtoPlan(long *lGeCuadCtoPlan,CUADCTOPLAN **pstlGeCuadCtoPlan, void* ctx);
BOOL    bfnObtGeCtoPlan(long *lGeCtoPlan,CTOPLAN **pstlGeCtoPlan, void* ctx);
BOOL    bfnObtGePlanCtoPlan(long *lGePlanCtoPlan,PLANCTOPLAN **pstlGePlanCtoPlan, void* ctx);
BOOL    bfnObtGeArriendo(long *lGeArriendo,ARRIENDO **pstlGeArriendo, void* ctx);
BOOL    bfnObtGeCargosBasico(long *lGeCargosBasico,CARGOSBASICO **pstlGeCargosBasico, void* ctx, char * pszFecEmision);
BOOL    bfnObtGeOptimo(long *lGeOptimo,OPTIMO **pstlGeOptimo, void* ctx);
BOOL    bfnObtGeFeriados(long *lGeFeriados,FERIADOS **pstlGeFeriados, void* ctx);
BOOL    bfnObtGePlanTarif(long *lGePlanTarif,PLANTARIF **pstlGePlanTarif, void* ctx, char * pszFecEmision);
BOOL    bfnObtGePenalizaciones(long *lGePenalizaciones,PENALIZA **pstlGePenalizaciones, void* ctx);
BOOL	bfnObtFacClientes(long *lFacClientes, FAC_CLIENTES **pstFacClientes,void* ctx, int ciclo, long clieini, long cliefin, char *szFecEmision);
BOOL	bfnObtFacCiclo(long *lFacCiclo, CICLOCLI **pstFacCiclo,void* ctx, int ciclo, long clieini, long cliefin);
BOOL 	bfnObtCatImpClientes( long *lGeCatImpClientes,CAT_IMPCLIENTES **pstlGeCatImpClientes,void* ctx,long clieini,long cliefin,char *szFecha,long ciclo);
BOOL 	bfnObtDirecciones( long *lGeDirecciones,DIRECCIONES **pstlGeDirecciones,void* ctx,long clieini, long cliefin,long iTipDireccion, long ciclo);
BOOL 	bfnObtDirecciones2( long *lGeDirecciones,DIRECCIONES2 **pstlGeDirecciones,void* ctx,long clieini, long cliefin,long iTipDireccion, long ciclo);
BOOL 	bfnObtCoUnipac(long *lGeUnipac,UNIPAC **pstlGeUnipac,void* ctx,long clieini, long cliefin, long ciclo);
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
BOOL bfnObtGeOficina ( long *lGeOficina,OFICINA **pstlGeOficina,void* ctx);
BOOL bfnObtGeFactCobr ( long *lGeFactCobr,FACTCOBR **pstlGeFactCobr,void* ctx);
BOOL bfnObtDetPlanDesc ( long *lNumRegs,DETPLANDESC **pstlDetPlanDesc,void* ctx, long lCodCiclFact);
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/



int ifnOraDeclararGeCargos (void* ctx, long ciclo, long ci, long cf);
int ifnOraDeclararGeCargosRecurrentes (void* ctx);
int ifnOraDeclararGeCabCuotas (void* ctx);
int ifnOraDeclararGeTaConcepFact (void* ctx);
int ifnOraDeclararGeConceptos (void* ctx, long ciclo);
int ifnOraDeclararGeConceptos_Mi (void* ctx);
int ifnOraDeclararGeRangoTabla (void* ctx);
int ifnOraDeclararGeLimCreditos (void* ctx);
int ifnOraDeclararGeActividades (void* ctx);
int ifnOraDeclararGeProvincias (void* ctx);
int ifnOraDeclararGeRegiones (void* ctx);
int ifnOraDeclararGeCatImpositiva (void* ctx);
int ifnOraDeclararGeZonaCiudad (void* ctx);
int ifnOraDeclararGeZonaImpositiva (void* ctx);
int ifnOraDeclararGeImpuestos (void* ctx);
//int ifnOraDeclararGeTipImpues (void* ctx);
int ifnOraDeclararGeGrpSerConc (void* ctx);
int ifnOraDeclararGeConversion (void* ctx);
int ifnOraDeclararGeDocumSucursal (void* ctx);
int ifnOraDeclararGeLetras (void* ctx);
int ifnOraDeclararGeGrupoCob (void* ctx, int iCodCiclo);
int ifnOraDeclararGeTarifas (void* ctx);
int ifnOraDeclararGeActuaServ (void* ctx);
int ifnOraDeclararGeCuotas (void* ctx);
int ifnOraDeclararGeFactCarriers (void* ctx);
int ifnOraDeclararGeCuadCtoPlan (void* ctx);
int ifnOraDeclararGeCtoPlan (void* ctx);
int ifnOraDeclararGePlanCtoPlan (void* ctx);
int ifnOraDeclararGeArriendo (void* ctx);
int ifnOraDeclararGeCargosBasico (void* ctx,char *pszFecEmision);
int ifnOraDeclararGeOptimo (void* ctx);
int ifnOraDeclararGeFeriados (void* ctx);
int ifnOraDeclararGePlanTarif (void* ctx,char *pszFecEmision);
int ifnOraDeclararGePenalizaciones (void* ctx);
int ifnOraDeclararFacClientes(void *ctx, int ciclo, long clieini, long cliefin, char *szFecEmision);
int ifnOraDeclararFacCiclo(void *ctx, int ciclo, long clieini, long cliefin);
int ifnOraDeclararGeCatImpClientes (void* ctx,char *szFecha,long ciclo, long clieini, long cliefin);
int ifnOraDeclararGeDirecciones (void* ctx,int iTipDireccion,long ciclo, long clieini, long cliefin);
int ifnOraDeclararGeCoUnipac (void* ctx,long ciclo, long clieini, long cliefin);
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
int ifnOraDeclararGeOficina (void* ctx);
int ifnOraDeclararGeFactCobr (void* ctx);
int ifnOraDeclararDetPlanDesc (void* ctx, long plCodCiclfact);
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

int  ifnOraLeerGeCargos(CARGOS_HOST *pstHost,CARGOS_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx, long ci, long cf);
int  ifnOraLeerGeCargosRecurrentes(CARGOSRECURRENTES_HOST *pstHost,CARGOSRECURRENTES_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGeCabCuotas(CABCUOTAS_HOST *pstHost,CABCUOTAS_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGeTaConcepFact(TACONCEPFACT_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeConceptos(CONCEPTO_HOST *pstHost,CONCEPTO_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGeConceptos_Mi(CONCEPTO_MI_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeRangoTabla(RANGOTABLA_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeLimCreditos(LIMCREDITOS_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeActividades(ACTIVIDADES_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeProvincias(PROVINCIAS_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeRegiones(REGIONES_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeCatImpositiva(CATIMPOSITIVA_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeZonaCiudad(ZONACIUDAD_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeZonaImpositiva(ZONAIMPOSITIVA_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeImpuestos(IMPUESTOS_HOST *pstHost,long *plNumFilas, void* ctx);
//int  ifnOraLeerGeTipImpues(TIPIMPUES_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeGrpSerConc(GRPSERCONC_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeConversion(CONVERSION_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeDocumSucursal(DOCUMSUCURSAL_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeLetras(LETRAS_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeGrupoCob(GRUPOCOB_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeTarifas(TARIFAS_HOST *pstHost,TARIFAS_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGeActuaServ(ACTUASERV_HOST *pstHost,ACTUASERV_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGeCuotas(CUOTAS_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeFactCarriers(FACTCARRIERS_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeCuadCtoPlan(CUADCTOPLAN_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeCtoPlan(CTOPLAN_HOST *pstHost,CTOPLAN_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGePlanCtoPlan(PLANCTOPLAN_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeArriendo(ARRIENDO_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeCargosBasico(CARGOSBASICO_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGeOptimo(OPTIMO_HOST *pstHost,OPTIMO_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGeFeriados(FERIADOS_HOST *pstHost,long *plNumFilas, void* ctx);
int  ifnOraLeerGePlanTarif(PLANTARIF_HOST *pstHost,PLANTARIF_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerGePenalizaciones(PENALIZA_HOST *pstHost,PENALIZA_HOST_NULL *pstHostNull,long *plNumFilas, void* ctx);
int  ifnOraLeerFacClientes(FAC_CLIENTES_HOST *pstHost,long *plNumFilas,void* ctx,long ci,long cf,FAC_CLIENTES_HOST_NULL *pstHostNull);
int  ifnOraLeerFacCiclo(CICLOCLI_HOST *pstHost,CICLOCLI_HOST_NULL *pstHostNull,long *plNumFilas,void * ctx,long ci, long cf);
int  ifnOraLeerGeCatImpClientes(CAT_IMPCLIENTES_HOST *pstHost,long *plNumFilas,void* ctx,long ci,long cf);
int  ifnOraLeerGeDirecciones(DIRECCIONES_HOST *pstHost,DIRECCIONES_HOST_NULL *pstHostNull,long *plNumFilas,void* ctx,long ci,long cf);
int  ifnOraLeerGeDirecciones2(DIRECCIONES_HOST2 *pstHost,DIRECCIONES_HOST_NULL2 *pstHostNull,long *plNumFilas,void* ctx,long ci,long cf);
int  ifnOraLeerGeCoUnipac(UNIPAC_HOST *pstHost,long *plNumFilas,void* ctx,long ci,long cf);
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
int  ifnOraLeerGeOficina(OFICINA_HOST *pstHost,long *plNumFilas,void* ctx);
int  ifnOraLeerGeFactCobr(FACTCOBR_HOST *pstHost,long *plNumFilas,void* ctx);
int  ifnOraLeerDetPlanDesc(DETPLANDESC_HOST *pstHost,DETPLANDESC_HOST_NULL *pstHostNull, long *plNumFilas,void* ctx);
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

int ifnOraCerrarGeCargos (void* ctx, long ci, long cf);
int ifnOraCerrarGeCargosRecurrentes (void* ctx);
int ifnOraCerrarGeCabCuotas (void* ctx);
int ifnOraCerrarGeTaConcepFact (void* ctx);
int ifnOraCerrarGeConceptos (void* ctx);
int ifnOraCerrarGeConceptos_Mi (void* ctx);
int ifnOraCerrarGeRangoTabla (void* ctx);
int ifnOraCerrarGeLimCreditos (void* ctx);
int ifnOraCerrarGeActividades (void* ctx);
int ifnOraCerrarGeProvincias (void* ctx);
int ifnOraCerrarGeRegiones (void* ctx);
int ifnOraCerrarGeCatImpositiva (void* ctx);
int ifnOraCerrarGeZonaCiudad (void* ctx);
int ifnOraCerrarGeZonaImpositiva (void* ctx);
int ifnOraCerrarGeImpuestos (void* ctx);
//int ifnOraCerrarGeTipImpues (void* ctx);
int ifnOraCerrarGeGrpSerConc (void* ctx);
int ifnOraCerrarGeConversion (void* ctx);
int ifnOraCerrarGeDocumSucursal (void* ctx);
int ifnOraCerrarGeLetras (void* ctx);
int ifnOraCerrarGeGrupoCob (void* ctx);
int ifnOraCerrarGeTarifas (void* ctx);
int ifnOraCerrarGeActuaServ (void* ctx);
int ifnOraCerrarGeCuotas (void* ctx);
int ifnOraCerrarGeFactCarriers (void* ctx);
int ifnOraCerrarGeCuadCtoPlan (void* ctx);
int ifnOraCerrarGeCtoPlan (void* ctx);
int ifnOraCerrarGePlanCtoPlan (void* ctx);
int ifnOraCerrarGeArriendo (void* ctx);
int ifnOraCerrarGeCargosBasico (void* ctx);
int ifnOraCerrarGeOptimo (void* ctx);
int ifnOraCerrarGeFeriados (void* ctx);
int ifnOraCerrarGePlanTarif (void* ctx);
int ifnOraCerrarGePenalizaciones (void* ctx);
int ifnOraCerrarFacClientes(void * ctx, long ci, long cf);
int ifnOraCerrarFacCiclo(void * ctx, long ci, long cf);
int ifnOraCerrarGeCatImpClientes(void * ctx, long ci, long cf);
int ifnOraCerrarGeDirecciones (void * ctx, long ci, long cf);
int ifnOraCerrarGeCoUnipac (void * ctx, long ci, long cf);
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
int ifnOraCerrarGeOficina (void* ctx);
int ifnOraCerrarGeFactCobr (void* ctx);
int ifnOraCerrarDetPlanDesc (void* ctx);
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

static int ifnCompareGeCargos(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeCabCuotas(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeTaConcepFact(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeConceptos(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeConceptos_Mi(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeRangoTabla(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeLimCreditos(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeActividades(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeProvincias(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeRegiones(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeCatImpositiva(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeZonaCiudad(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeZonaImpositiva(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeImpuestos(const void *pvstKey,const void *pvstItem);
//static int ifnCompareGeTipImpues(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeGrpSerConc(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeConversion(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeDocumSucursal(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeLetras(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeGrupoCob(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeTarifas(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeActuaServ(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeCuotas(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeFactCarriers(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeCuadCtoPlan(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeCtoPlan(const void *pvstKey,const void *pvstItem);
static int ifnCompareGePlanCtoPlan(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeArriendo(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeCargosBasico(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeOptimo(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeFeriados(const void *pvstKey,const void *pvstItem);
static int ifnCompareGePlanTarif(const void *pvstKey,const void *pvstItem);
static int ifnCompareGePenalizaciones(const void *pvstKey,const void *pvstItem);
static int ifnCompareFacClientes(const void	*pvstKey,const void	*pvstItem);
static int ifnCompareGeDirecciones(const void	*pvstKey,const void	*pvstItem);
static int ifnCompareGeDirecciones2(const void	*pvstKey,const void	*pvstItem);
static int ifnCompareGeCoUnipac(const void	*pvstKey,const void	*pvstItem);
static int ifnCompareGeCatImpClientes(const void	*pvstKey,const void	*pvstItem);
static int ifnCompareGeClientes(const void	*pvstKey,const void	*pvstItem);
static int ifnCompareGeCiclo(const void	*pvstKey,const void	*pvstItem);
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
static int ifnCompareGeOficina(const void *pvstKey,const void *pvstItem);
static int ifnCompareGeFactCobr(const void *pvstKey,const void *pvstItem);
static int ifnCmpDetPlanDesc(const void *cad1,const void *cad2);
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

int ifnInitORATh (char * szUser, char *szPass,int *iCodCiclo,int iFactura, char *szFecSysDate, char *szFecEmision);
int ifnConnectORATh( char * szUser, char * szPass,  void * *ctx);
int ifnCommitReleaseTh( void * ctx);
void vfnActivateRoleTh (char *szUser,  void * ctx);

