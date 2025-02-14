
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned int magic;
  };
  typedef struct sql_cursor sql_cursor;
  typedef struct sql_cursor SQL_CURSOR;
#endif /* SQL_CRSR */

/* Thread Safety */
typedef void * sql_context;
typedef void * SQL_CONTEXT;

/* Object support */
struct sqltvn
{
  unsigned char *tvnvsn; 
  unsigned short tvnvsnl; 
  unsigned char *tvnnm;
  unsigned short tvnnml; 
  unsigned char *tvnsnm;
  unsigned short tvnsnml;
};
typedef struct sqltvn sqltvn;

struct sqladts
{
  unsigned int adtvsn; 
  unsigned short adtmode; 
  unsigned short adtnum;  
  sqltvn adttvn[1];       
};
typedef struct sqladts sqladts;

static struct sqladts sqladt = {
  1,1,0,
};

/* Binding to PL/SQL Records */
struct sqltdss
{
  unsigned int tdsvsn; 
  unsigned short tdsnum; 
  unsigned char *tdsval[1]; 
};
typedef struct sqltdss sqltdss;
static struct sqltdss sqltds =
{
  1,
  0,
};

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[17];
};
static const struct sqlcxp sqlfpn =
{
    16,
    "./pc/ORAcarga.pc"
};


static unsigned int sqlctx = 3460371;


static struct sqlexd {
   unsigned long  sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
      const short *cud;
   unsigned char  *sqlest;
      const char  *stmt;
   sqladts *sqladtp;
   sqltdss *sqltdsp;
   unsigned char  **sqphsv;
   unsigned long  *sqphsl;
            int   *sqphss;
            short **sqpind;
            int   *sqpins;
   unsigned long  *sqparm;
   unsigned long  **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
   unsigned int   sqlcmax;
   unsigned int   sqlcmin;
   unsigned int   sqlcincr;
   unsigned int   sqlctimeout;
   unsigned int   sqlcnowait;
            int   sqfoff;
   unsigned int   sqcmod;
   unsigned int   sqfmod;
   unsigned char  *sqhstv[29];
   unsigned long  sqhstl[29];
            int   sqhsts[29];
            short *sqindv[29];
            int   sqinds[29];
   unsigned long  sqharm[29];
   unsigned long  *sqharc[29];
   unsigned short  sqadto[29];
   unsigned short  sqtdso[29];
} sqlstm = {12,29};

/* SQLLIB Prototypes */
extern void sqlcxt (void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlcx2t(void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlbuft(void **, char *);
extern void sqlgs2t(void **, char *);
extern void sqlorat(void **, unsigned int *, void *);

/* Forms Interface */
static const int IAPSUCC = 0;
static const int IAPFAIL = 1403;
static const int IAPFTL  = 535;
extern void sqliem(char *, int *);

 static const char *sq0010 = 
"select  /*+  FULL(FA_CONCEPTOS)  +*/ A.COD_CONCEPTO ,A.COD_PRODUCTO ,A.DES_C\
ONCEPTO ,A.COD_TIPCONCE ,A.COD_MODULO ,A.COD_MONEDA ,A.IND_ACTIVO ,A.COD_CONCO\
RIG ,A.COD_TIPDESCU ,B.COD_CONCCOBR ,C.DESCRIPCION_VALOR ,GRUP.COD_GRPSERVI  f\
rom FA_CONCEPTOS A ,FA_FACTCOBR B ,FA_GRPSERCONC GRUP ,FA_CICLFACT CICL ,(sele\
ct FIC.COD_CONCEPTO ,FFTN.DESCRIPCION_VALOR  from FAD_IMPCONCEPTOS FIC ,FAD_IM\
PSUBGRUPOS FIS ,FAD_IMPGRUPOS FIG ,FAD_PARAMETROS FP ,FA_FACTOR_TIPO_UNIDAD_VW\
 FFTN where (((((FIC.COD_SUBGRUPO=FIS.COD_SUBGRUPO and FIS.COD_GRUPO=FIG.COD_G\
RUPO) and FP.VAL_NUMERICO=FIG.COD_FORMULARIO) and FP.COD_MODULO=:b0) and FP.CO\
D_PARAMETRO=:b1) and FIG.TIP_UNIDAD=FFTN.VALOR)) C where (((((A.COD_CONCEPTO=B\
.COD_CONCFACT and A.COD_CONCEPTO=C.COD_CONCEPTO(+)) and GRUP.COD_CONCEPTO=A.CO\
D_CONCEPTO) and GRUP.FEC_DESDE<=CICL.FEC_EMISION) and GRUP.FEC_HASTA>=CICL.FEC\
_EMISION) and CICL.COD_CICLFACT=:b2) order by A.COD_CONCEPTO            ";

 static const char *sq0011 = 
"select  /*+  FULL(GE_MULTIIDIOMA)  +*/ to_number(COD_CONCEPTO) ,COD_IDIOMA ,\
DES_CONCEPTO  from GE_MULTIIDIOMA where (NOM_TABLA='FA_CONCEPTOS' and NOM_CAMP\
O='COD_CONCEPTO') order by to_number(COD_CONCEPTO)            ";

 static const char *sq0002 = 
"select  /*+  FULL (GE_CATIMPOSITIVA)  +*/ COD_CATIMPOS ,DES_CATIMPOS  from G\
E_CATIMPOSITIVA            ";

 static const char *sq0003 = 
"select  /*+  FULL (GE_ZONAIMPOSITIVA)  +*/ COD_ZONAIMPO ,DES_ZONAIMPO  from \
GE_ZONAIMPOSITIVA            ";

 static const char *sq0012 = 
"select  /*+  FULL(GE_CATIMPCLIENTES)  +*/ COD_CLIENTE ,TO_CHAR(FEC_DESDE,'YY\
YYMMDDHH24MISS') ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS') ,COD_CATIMPOS  from GE\
_CATIMPCLIENTES            ";

 static const char *sq0001 = 
"select  /*+  FULL (GE_TIPIMPUES)  +*/ COD_TIPIMPUE ,IMP_UMBRAL ,TIP_MONTO ,C\
OD_CATEIMP  from GE_TIPIMPUES            ";

 static const char *sq0013 = 
"select  /*+  FULL (GE_IMPUESTOS)  +*/ I.COD_CATIMPOS ,I.COD_ZONAIMPO ,I.COD_\
ZONAABON ,I.COD_TIPIMPUES ,I.COD_GRPSERVI ,(TO_CHAR(I.FEC_DESDE,'YYYYMMDD')||'\
000000') ,I.COD_CONCGENE ,(TO_CHAR(I.FEC_HASTA,'YYYYMMDD')||'235959') ,I.PRC_I\
MPUESTO ,T.TIP_MONTO  from GE_IMPUESTOS I ,GE_TIPIMPUES T where I.COD_TIPIMPUE\
S=T.COD_TIPIMPUE           ";

 static const char *sq0014 = 
"select  /*+  FULL(GE_ZONACIUDAD)  +*/ COD_REGION ,COD_PROVINCIA ,COD_CIUDAD \
,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS') \
,COD_ZONAIMPO  from GE_ZONACIUDAD            ";

 static const char *sq0004 = 
"select  /*+  FULL(FA_GRPSERCONC)  +*/ COD_CONCEPTO ,TO_CHAR(FEC_DESDE,'YYYYM\
MDDHH24MISS') ,COD_GRPSERVI ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS')  from FA_GR\
PSERCONC            ";

 static const char *sq0015 = 
"select  /*+  FULL (GE_DIRECCIONES)  +*/ COD_DIRECCION ,COD_REGION ,COD_PROVI\
NCIA ,COD_CIUDAD ,COD_COMUNA ,NOM_CALLE ,NUM_CALLE ,NUM_PISO ,NUM_CASILLA ,OBS\
_DIRECCION  from GE_DIRECCIONES            ";

 static const char *sq0005 = 
"select  /*+  FULL (GA_DIRECCLI)  +*/ COD_CLIENTE ,COD_TIPDIRECCION ,COD_DIRE\
CCION  from GA_DIRECCLI            ";

 static const char *sq0006 = 
"select  /*+  FULL (FA_CICLFACT)  +*/ ROWID ,COD_CICLO ,ANO ,COD_CICLFACT ,TO\
_CHAR(FEC_VENCIMIE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS'\
) ,TO_CHAR(FEC_CADUCIDA,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_PROXVENC,'YYYYMMDDHH2\
4MISS') ,TO_CHAR(FEC_DESDELLAM,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HASTALLAM,'YYY\
YMMDDHH24MISS') ,TO_CHAR(FEC_DESDECFIJOS,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HAST\
ACFIJOS,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_DESDEOCARGOS,'YYYYMMDDHH24MISS') ,TO_\
CHAR(FEC_HASTAOCARGOS,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_DESDEROA,'YYYYMMDDHH24M\
ISS') ,TO_CHAR(FEC_HASTAROA,'YYYYMMDDHH24MISS') ,TO_CHAR((FEC_DESDECFIJOS-(1/8\
6400)),'YYYYMMDDHH24MISS') ,IND_FACTURACION ,DIR_LOGS ,DIR_SPOOL  from FA_CICL\
FACT            ";

 static const char *sq0009 = 
"select  /*+  index (A,  AK_GE_CARGOS_CODCLIENTE)  +*/ A.rowid  ,A.NUM_CARGO \
,A.COD_CLIENTE ,A.COD_PRODUCTO ,A.COD_CONCEPTO ,TO_CHAR(A.FEC_ALTA,'YYYYMMDDHH\
24MISS') ,A.IMP_CARGO ,A.COD_MONEDA ,A.COD_PLANCOM ,A.NUM_UNIDADES ,A.NUM_ABON\
ADO ,A.NUM_TERMINAL ,A.COD_CICLFACT ,A.NUM_SERIE ,A.NUM_SERIEMEC ,A.CAP_CODE ,\
A.MES_GARANTIA ,DECODE(trim(A.NUM_PREGUIA),'',null ,A.NUM_PREGUIA) ,DECODE(tri\
m(A.NUM_GUIA),'',null ,A.NUM_GUIA) ,A.NUM_TRANSACCION ,A.NUM_VENTA ,A.NUM_FACT\
URA ,A.COD_CONCEPTO_DTO ,A.VAL_DTO ,A.TIP_DTO ,A.IND_CUOTA ,A.NUM_PAQUETE ,A.I\
ND_FACTUR ,A.IND_SUPERTEL  from GE_CARGOS A where ((((A.COD_CLIENTE=:b0 and A.\
NUM_FACTURA=0) and A.NUM_TRANSACCION=0) and A.IMP_CARGO<>0) and A.COD_CICLFACT\
 in (select B.COD_CICLFACT  from FA_CICLFACT B where (B.COD_CICLFACT=A.COD_CIC\
LFACT and B.IND_FACTURACION in (1,2))))           ";

 static const char *sq0007 = 
"select  /*+  index (AK_GA_CARGOS_TRANSACCION GE_CARGOS)  +*/ ROWID ,NUM_CARG\
O ,COD_CLIENTE ,COD_PRODUCTO ,COD_CONCEPTO ,TO_CHAR(FEC_ALTA,'YYYYMMDDHH24MISS\
') ,IMP_CARGO ,COD_MONEDA ,COD_PLANCOM ,NUM_UNIDADES ,NUM_ABONADO ,NUM_TERMINA\
L ,COD_CICLFACT ,NUM_SERIE ,NUM_SERIEMEC ,CAP_CODE ,MES_GARANTIA ,DECODE(trim(\
NUM_PREGUIA),'',null ,NUM_PREGUIA) ,DECODE(trim(NUM_GUIA),'',null ,NUM_GUIA) ,\
NUM_TRANSACCION ,NUM_VENTA ,NUM_FACTURA ,COD_CONCEPTO_DTO ,VAL_DTO ,TIP_DTO ,I\
ND_CUOTA ,NUM_PAQUETE ,IND_FACTUR ,IND_SUPERTEL  from GE_CARGOS where NUM_TRAN\
SACCION=:b0           ";

 static const char *sq0008 = 
"select  /*+  index (AK_GA_CARGOS_TRANSACCION GE_CARGOS)  +*/ ROWID ,NUM_CARG\
O ,COD_CLIENTE ,COD_PRODUCTO ,COD_CONCEPTO ,TO_CHAR(FEC_ALTA,'YYYYMMDDHH24MISS\
') ,IMP_CARGO ,COD_MONEDA ,COD_PLANCOM ,NUM_UNIDADES ,NUM_ABONADO ,NUM_TERMINA\
L ,COD_CICLFACT ,NUM_SERIE ,NUM_SERIEMEC ,CAP_CODE ,MES_GARANTIA ,DECODE(trim(\
NUM_PREGUIA),'',null ,NUM_PREGUIA) ,DECODE(trim(NUM_GUIA),'',null ,NUM_GUIA) ,\
NUM_TRANSACCION ,NUM_VENTA ,NUM_FACTURA ,COD_CONCEPTO_DTO ,VAL_DTO ,TIP_DTO ,I\
ND_CUOTA ,NUM_PAQUETE ,IND_FACTUR ,IND_SUPERTEL  from GE_CARGOS where (NUM_TRA\
NSACCION=:b0 and NUM_VENTA=:b1)           ";

 static const char *sq0016 = 
"select  /*+  FULL(CA_PENALIZACIONES)  +*/ ROWID ,COD_CLIENTE ,TIP_INCIDENCIA\
 ,TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS') ,COD_MONEDA ,IMP_PENALIZ ,COD_CI\
CLFACT ,COD_CONCEPTO ,COD_PRODUCTO ,NUM_ABONADO ,NUM_PROCESO  from CA_PENALIZA\
CIONES            ";

 static const char *sq0017 = 
"select  /*+  FULL(CA_PENALIZACIONES)  +*/ ROWID ,COD_CLIENTE ,TIP_INCIDENCIA\
 ,TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS') ,COD_MONEDA ,IMP_PENALIZ ,COD_CI\
CLFACT ,COD_CONCEPTO ,COD_PRODUCTO ,NUM_ABONADO ,NUM_PROCESO  from CA_PENALIZA\
CIONES where (COD_CLIENTE=:b0 and NUM_PROCESO=0)           ";

 static const char *sq0018 = 
"select  /*+  FULL(TA_CONCEPFACT)  +*/ COD_PRODUCTO ,COD_FACTURACION ,IND_TAB\
LA ,IND_ENTSAL ,IND_DESTINO ,COD_TARIFICACION ,COD_SERVICIO  from TA_CONCEPFAC\
T            ";

 static const char *sq0019 = 
"select  /*+  full (FA_FACTCARRIERS)  +*/ A.COD_CONCFACT ,A.COD_CONCCARRIER ,\
B.COD_TIPCONCE  from FA_FACTCARRIERS A ,FA_CONCEPTOS B where B.COD_CONCEPTO=A.\
COD_CONCFACT           ";

 static const char *sq0020 = 
"select  /*+  FULL (GE_CONVERSION)  +*/ COD_MONEDA ,TO_CHAR(FEC_DESDE,'YYYYMM\
DDHH24MISS') ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS') ,CAMBIO  from GE_CONVERSIO\
N            ";

 static const char *sq0021 = 
"select  /*+  FULL(GA_TARIFAS)  +*/ COD_TIPSERV ,COD_SERVICIO ,COD_PLANSERV ,\
TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS') ,IMP_TARIFA ,COD_MONEDA ,IND_PERIODICO ,\
TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS')  from GA_TARIFAS where (COD_PRODUCTO=1 a\
nd COD_ACTABO='FA') order by COD_TIPSERV,COD_SERVICIO,COD_PLANSERV,FEC_DESDE  \
          ";

 static const char *sq0022 = 
"select  /*+  FULL (VE_PLAN_CTOPLAN)  +*/ COD_PLANCOM ,COD_PRODUCTO ,COD_CTOP\
LAN ,TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_FINEFECTIVIDAD,'\
YYYYMMDDHH24MISS')  from VE_PLAN_CTOPLAN            ";

 static const char *sq0023 = 
"select  /*+  FULL (VE_CTOPLAN)  +*/ COD_CTOPLAN ,COD_PRODUCTO ,COD_TIPCTOPLA\
N ,COD_MONEDA ,COD_CTOFAC ,IMP_DESCUENTO ,COD_TIPODTO ,IND_CUADRANTE ,COD_TIPO\
CUAD ,IMP_UMBDESDE ,IMP_UMBHASTA ,NUM_DIAS  from VE_CTOPLAN            ";

 static const char *sq0024 = 
"select  /*+  FULL (VE_CUADCTOPLAN)  +*/ COD_CTOPLAN ,IMP_UMBDESDE ,IMP_UMBHA\
STA ,IMP_DESCUENTO ,COD_TIPODTO  from VE_CUADCTOPLAN            ";

 static const char *sq0025 = 
"select  /*+  FULL (FA_ANOMALIAS)  +*/ COD_ANOMALIA ,DES_ANOMALIA ,IND_GRAVED\
AD  from FA_ANOMALIAS            ";

 static const char *sq0026 = 
"select  /*+  FULL(GE_LETRAS)  +*/ COD_TIPDOCUM ,COD_CATIMPOS ,LETRA  from GE\
_LETRAS            ";

 static const char *sq0027 = 
"select  /*+  FULL (AL_DOCUM_SUCURSAL)  +*/ COD_OFICINA ,COD_TIPDOCUM ,COD_CE\
NTREMI  from AL_DOCUM_SUCURSAL            ";

 static const char *sq0028 = 
"select  /*+  full (GA_ACTUASERV)  +*/ COD_TIPSERV ,COD_SERVICIO ,COD_CONCEPT\
O  from GA_ACTUASERV where (COD_PRODUCTO=:b0 and COD_ACTABO=:b1)           ";

 static const char *sq0029 = 
"select  /*+  full (TA_PLANTARIF)  +*/ COD_PLANTARIF ,TIP_TERMINAL ,COD_LIMCO\
NSUMO ,COD_CARGOBASICO ,TIP_PLANTARIF ,TIP_UNIDADES ,NUM_UNIDADES ,IND_ARRASTR\
E ,NUM_DIAS ,NUM_ABONADOS ,IND_FRANCONS ,FLG_RANGO ,TO_CHAR(NVL(IND_COMPARTIDO\
,0)) ,DECODE(NVL(TIP_COBRO,'V'),'A',1,0)  from TA_PLANTARIF where COD_PRODUCTO\
=1           ";

 static const char *sq0030 = 
"select  /*+  full (TA_CARGOSBASICO)  +*/ COD_CARGOBASICO ,IMP_CARGOBASICO ,C\
OD_MONEDA  from TA_CARGOSBASICO where ((TO_DATE(:b0,'YYYYMMDDHH24MISS')>=FEC_D\
ESDE and TO_DATE(:b0,'YYYYMMDDHH24MISS')<=NVL(FEC_HASTA,TO_DATE('3000010100000\
0','YYYYMMDDHH24MISS'))) and COD_PRODUCTO=1)           ";

 static const char *sq0031 = 
"select COD_CARGO ,MONTO_IMPORTE ,COD_MONEDA  from PF_CARGOS_PRODUCTOS_TD  or\
der by COD_CARGO            ";

 static const char *sq0032 = 
"select  /*+  full (FA_GRUPOCOB) +*/ A.COD_GRUPO ,A.COD_PRODUCTO ,A.COD_CONCE\
PTO ,A.COD_CICLO ,NVL(B.TIP_COBRO,0) ,A.FEC_DESDE ,A.FEC_HASTA  from FA_GRUPOC\
OB A ,(select COD_CONCEPTO ,max(TIP_COBRO) TIP_COBRO  from (select COD_CONCEPT\
O ,max(DECODE(NVL(TIP_COBRO,0),'A',1,0)) TIP_COBRO  from PF_CONCEPTOS_PROD_TD \
 group by COD_CONCEPTO union select COD_CONCEPTO ,max(DECODE(NVL(B.TIP_COBRO,0\
),'A',1,0)) TIP_COBRO  from GA_SERVSUPL B ,GA_ACTUASERV C where B.COD_SERVICIO\
=C.COD_SERVICIO group by COD_CONCEPTO)  group by COD_CONCEPTO) B where (A.COD_\
CICLO=:b0 and A.COD_CONCEPTO=B.COD_CONCEPTO(+)) order by A.COD_GRUPO,A.COD_CON\
CEPTO,A.COD_PRODUCTO,A.COD_CICLO            ";

 static const char *sq0033 = 
"select  /*+  full (FA_CABCUOTAS)  +*/ ROWID ,SEQ_CUOTAS ,COD_CLIENTE ,COD_CO\
NCEPTO ,COD_MONEDA ,COD_PRODUCTO ,NUM_CUOTAS ,IMP_TOTAL ,IND_PAGADA ,NUM_ABONA\
DO ,COD_CUOTA ,NUM_PAGARE  from FA_CABCUOTAS            ";

 static const char *sq0034 = 
"select  /*+  index (FA_CABCUOTAS NUK_FA_CABCUOTAS_CLIENTE)  +*/ ROWID ,SEQ_C\
UOTAS ,COD_CLIENTE ,COD_CONCEPTO ,COD_MONEDA ,COD_PRODUCTO ,NUM_CUOTAS ,IMP_TO\
TAL ,IND_PAGADA ,NUM_ABONADO ,COD_CUOTA ,NUM_PAGARE  from FA_CABCUOTAS where (\
COD_CLIENTE=:b0 and NUM_ABONADO=:b1)           ";

 static const char *sq0035 = 
"select  /*+  full(FA_CUOTAS)  +*/ ROWID ,SEQ_CUOTAS ,ORD_CUOTA ,TO_CHAR(FEC_\
EMISION,'YYYYMMDDHH24MISS') ,IMP_CUOTA ,IND_FACTURADO ,IND_PAGADO  from FA_CUO\
TAS            ";

 static const char *sq0036 = 
"select  /*+  index (FA_CUOTAS PK_FA_CUOTAS)  +*/ ROWID ,SEQ_CUOTAS ,ORD_CUOT\
A ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS') ,IMP_CUOTA ,IND_FACTURADO ,IND_PAGA\
DO  from FA_CUOTAS where SEQ_CUOTAS=:b0           ";

 static const char *sq0037 = 
"select  /*+  full (FA_ARRIENDO)  +*/ ROWID ,COD_CLIENTE ,NUM_ABONADO ,TO_CHA\
R(FEC_DESDE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS') ,COD_PR\
ODUCTO ,COD_CONCEPTO ,COD_ARTICULO ,PRECIO_MES ,COD_MONEDA  from FA_ARRIENDO  \
          ";

 static const char *sq0038 = 
"select  /*+  full (GE_REGIONES)  +*/ COD_REGION ,DES_REGION  from GE_REGIONE\
S            ";

 static const char *sq0039 = 
"select  /*+  full (GE_PROVINCIAS)  +*/ COD_REGION ,COD_PROVINCIA  from GE_PR\
OVINCIAS            ";

 static const char *sq0040 = 
"select  /*+  full (GE_ACTIVIDADES)  +*/ COD_Actividad ,DES_Actividad  from G\
E_ACTIVIDADES            ";

 static const char *sq0045 = 
"select  /*+  full (FA_RANGO_TABLA)  +*/ COD_CICLFACT ,RANGO_INI ,RANGO_FIN ,\
COD_PRODUCTO ,NOM_TABLA  from FA_RANGO_TABLA            ";

 static const char *sq0046 = 
"select  /*+  full (CO_LIMCREDITOS)  +*/ COD_CREDMOR ,COD_PRODUCTO ,COD_CALCL\
IEN ,IMP_MOROSIDAD  from CO_LIMCREDITOS            ";

 static const char *sq0047 = 
"select  /*+  full (FA_DESACUMULADO)  +*/ COD_PRODUCTO ,DES_TOTALPROD ,DES_AC\
UMCARGO ,DES_ACUMIVA ,DES_ACUMDTO  from FA_DESACUMULADO            ";

 static const char *sq0048 = 
"select  /*+  full (FA_OPTIMO)  +*/ COD_PLANTARIF ,MIN_DESDE ,MIN_HASTA ,PRC_\
ABONO ,PRC_NORMAL ,PRC_BAJO  from FA_OPTIMO            ";

 static const char *sq0049 = 
"select  /*+  full (GE_ALMS)  +*/ COD_ALM ,DES_ALM  from GE_ALMS            ";

 static const char *sq0050 = 
"select  /*+  full (AL_TIPOS_TERMINALES)  +*/ COD_PRODUCTO ,TIP_TERMINAL ,DES\
_TERMINAL  from AL_TIPOS_TERMINALES            ";

 static const char *sq0051 = 
"select  /*+  full (GA_TIPCOBERTURA)  +*/ TIP_COBERTURA ,DES_TIPCOBERT ,COD_S\
ERVICIO ,COD_PRODUCTO  from GA_TIPCOBERTURA            ";

 static const char *sq0052 = 
"select TO_CHAR(FEC_DIAFEST,'YYYYMMDDHH24MISS')  from TA_DIASFEST            ";

 static const char *sq0053 = 
"select COD_CICLFACT  from FA_CICLFACT where (COD_CICLO in (select COD_CICLO \
 from FA_CICLOS where DIG_C>0) and IND_FACTURACION in (1,2)) order by FEC_DESD\
ECFIJOS desc             ";

 static const char *sq0054 = 
"select COD_CONCFACT ,COD_CONCCOBR  from FA_FACTCOBR            ";

 static const char *sq0055 = 
"select  /*+  ORDERED  +*/ A.COD_OFICINA ,B.COD_REGION ,B.COD_PROVINCIA ,B.CO\
D_CIUDAD ,C.COD_PLAZA  from GE_OFICINAS A ,GE_DIRECCIONES B ,GE_CIUDADES C whe\
re (((A.COD_DIRECCION=B.COD_DIRECCION and B.COD_REGION=C.COD_REGION) and B.COD\
_PROVINCIA=C.COD_PROVINCIA) and B.COD_CIUDAD=C.COD_CIUDAD)           ";

 static const char *sq0057 = 
"select A.COD_CONCEPTO ,A.COD_ZONACARGO ,A.COD_REGION ,A.COD_PROVINCIA ,A.TIP\
_ZONACARGO ,A.TIP_EVALUACION ,A.COD_GRPSERVI ,A.IMP_FACTURABLE ,A.TIP_VALOR ,A\
.COD_CATIMPOS ,TO_CHAR(A.FEC_DESDE,'YYYYMMDD') ,TO_CHAR(A.FEC_HASTA,'YYYYMMDD'\
)  from FA_IMPTODCTOS_TD A            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,10,928,0,9,332,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
32,0,0,10,0,0,13,351,0,0,12,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,
5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
95,0,0,10,0,0,15,402,0,0,0,0,0,1,0,
110,0,0,11,216,0,9,500,0,0,0,0,0,1,0,
125,0,0,11,0,0,13,519,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,
152,0,0,11,0,0,15,543,0,0,0,0,0,1,0,
167,0,0,2,103,0,9,696,0,0,0,0,0,1,0,
182,0,0,2,0,0,13,715,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
205,0,0,2,0,0,15,756,0,0,0,0,0,1,0,
220,0,0,3,105,0,9,821,0,0,0,0,0,1,0,
235,0,0,3,0,0,13,843,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
258,0,0,3,0,0,15,863,0,0,0,0,0,1,0,
273,0,0,12,181,0,9,959,0,0,0,0,0,1,0,
288,0,0,12,0,0,13,976,0,0,4,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
319,0,0,12,0,0,15,997,0,0,0,0,0,1,0,
334,0,0,1,117,0,9,1046,0,0,0,0,0,1,0,
349,0,0,1,0,0,13,1062,0,0,4,0,0,1,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
380,0,0,1,0,0,15,1088,0,0,0,0,0,1,0,
395,0,0,13,337,0,9,1190,0,0,0,0,0,1,0,
410,0,0,13,0,0,13,1223,0,0,10,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,3,0,0,2,5,0,0,2,4,0,0,2,3,0,0,
465,0,0,13,0,0,15,1258,0,0,0,0,0,1,0,
480,0,0,14,199,0,9,1346,0,0,0,0,0,1,0,
495,0,0,14,0,0,13,1372,0,0,6,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,
534,0,0,14,0,0,15,1393,0,0,0,0,0,1,0,
549,0,0,4,174,0,9,1445,0,0,0,0,0,1,0,
564,0,0,4,0,0,13,1462,0,0,4,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
595,0,0,4,0,0,15,1484,0,0,0,0,0,1,0,
610,0,0,15,197,0,9,1552,0,0,0,0,0,1,0,
625,0,0,15,0,0,13,1579,0,0,10,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
680,0,0,15,0,0,15,1618,0,0,0,0,0,1,0,
695,0,0,5,111,0,9,1733,0,0,0,0,0,1,0,
710,0,0,5,0,0,13,1750,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
737,0,0,5,0,0,15,1776,0,0,0,0,0,1,0,
752,0,0,6,716,0,9,1874,0,0,0,0,0,1,0,
767,0,0,6,0,0,13,1908,0,0,20,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
862,0,0,6,0,0,15,1950,0,0,0,0,0,1,0,
877,0,0,9,828,0,9,2011,0,0,1,1,0,1,0,1,3,0,0,
896,0,0,7,566,0,9,2022,0,0,1,1,0,1,0,1,3,0,0,
915,0,0,8,586,0,9,2026,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
938,0,0,7,0,0,13,2099,0,0,29,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,
0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
1069,0,0,8,0,0,13,2132,0,0,29,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,
0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
1200,0,0,9,0,0,13,2166,0,0,29,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,
0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
1331,0,0,7,0,0,15,2253,0,0,0,0,0,1,0,
1346,0,0,8,0,0,15,2255,0,0,0,0,0,1,0,
1361,0,0,9,0,0,15,2258,0,0,0,0,0,1,0,
1376,0,0,16,250,0,9,2428,0,0,0,0,0,1,0,
1391,0,0,17,291,0,9,2431,0,0,1,1,0,1,0,1,3,0,0,
1410,0,0,16,0,0,13,2456,0,0,11,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
1469,0,0,17,0,0,13,2473,0,0,11,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
1528,0,0,16,0,0,15,2515,0,0,0,0,0,1,0,
1543,0,0,17,0,0,15,2520,0,0,0,0,0,1,0,
1558,0,0,18,167,0,9,2648,0,0,0,0,0,1,0,
1573,0,0,18,0,0,13,2673,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,
1616,0,0,18,0,0,15,2703,0,0,0,0,0,1,0,
1631,0,0,19,177,0,9,2798,0,0,0,0,0,1,0,
1646,0,0,19,0,0,13,2819,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
1673,0,0,19,0,0,15,2839,0,0,0,0,0,1,0,
1688,0,0,20,167,0,9,2927,0,0,0,0,0,1,0,
1703,0,0,20,0,0,13,2948,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,
1734,0,0,20,0,0,15,2967,0,0,0,0,0,1,0,
1749,0,0,21,320,0,9,3035,0,0,0,0,0,1,0,
1764,0,0,21,0,0,13,3067,0,0,8,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,
1811,0,0,21,0,0,15,3095,0,0,0,0,0,1,0,
1826,0,0,22,206,0,9,3160,0,0,0,0,0,1,0,
1841,0,0,22,0,0,13,3184,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
1876,0,0,22,0,0,15,3207,0,0,0,0,0,1,0,
1891,0,0,23,225,0,9,3323,0,0,0,0,0,1,0,
1906,0,0,23,0,0,13,3356,0,0,12,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,
1969,0,0,23,0,0,15,3395,0,0,0,0,0,1,0,
1984,0,0,24,140,0,9,3505,0,0,0,0,0,1,0,
1999,0,0,24,0,0,13,3527,0,0,5,0,0,1,0,2,3,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,3,0,0,
2034,0,0,24,0,0,15,3553,0,0,0,0,0,1,0,
2049,0,0,25,109,0,9,3644,0,0,0,0,0,1,0,
2064,0,0,25,0,0,13,3668,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,
2091,0,0,25,0,0,15,3690,0,0,0,0,0,1,0,
2106,0,0,26,95,0,9,3753,0,0,0,0,0,1,0,
2121,0,0,26,0,0,13,3775,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,
2148,0,0,26,0,0,15,3797,0,0,0,0,0,1,0,
2163,0,0,27,118,0,9,3857,0,0,0,0,0,1,0,
2178,0,0,27,0,0,13,3879,0,0,3,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,
2205,0,0,27,0,0,15,3900,0,0,0,0,0,1,0,
2220,0,0,28,151,0,9,3968,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
2243,0,0,28,0,0,13,3991,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,
2270,0,0,28,0,0,15,4010,0,0,0,0,0,1,0,
2285,0,0,29,323,0,9,4126,0,0,0,0,0,1,0,
2300,0,0,29,0,0,13,4168,0,0,14,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2371,0,0,29,0,0,15,4206,0,0,0,0,0,1,0,
2386,0,0,30,287,0,9,4323,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
2409,0,0,30,0,0,13,4344,0,0,3,0,0,1,0,2,5,0,0,2,4,0,0,2,5,0,0,
2436,0,0,30,0,0,15,4364,0,0,0,0,0,1,0,
2451,0,0,31,104,0,9,4458,0,0,0,0,0,1,0,
2466,0,0,31,0,0,13,4481,0,0,3,0,0,1,0,2,3,0,0,2,4,0,0,2,5,0,0,
2493,0,0,31,0,0,15,4505,0,0,0,0,0,1,0,
2508,0,0,32,666,0,9,4625,0,0,1,1,0,1,0,1,3,0,0,
2527,0,0,32,0,0,13,4649,0,0,7,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,5,0,0,
2570,0,0,32,0,0,15,4677,0,0,0,0,0,1,0,
2585,0,0,33,210,0,9,4749,0,0,0,0,0,1,0,
2600,0,0,34,279,0,9,4776,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
2623,0,0,33,0,0,13,4809,0,0,12,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2686,0,0,34,0,0,13,4824,0,0,12,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2749,0,0,33,0,0,15,4868,0,0,0,0,0,1,0,
2764,0,0,34,0,0,15,4872,0,0,0,0,0,1,0,
2779,0,0,35,169,0,9,4958,0,0,0,0,0,1,0,
2794,0,0,36,204,0,9,4979,0,0,1,1,0,1,0,1,3,0,0,
2813,0,0,35,0,0,13,5005,0,0,7,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,4,0,0,
2,3,0,0,2,3,0,0,
2856,0,0,36,0,0,13,5016,0,0,7,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,4,0,0,
2,3,0,0,2,3,0,0,
2899,0,0,35,0,0,15,5047,0,0,0,0,0,1,0,
2914,0,0,36,0,0,15,5049,0,0,0,0,0,1,0,
2929,0,0,37,242,0,9,5137,0,0,0,0,0,1,0,
2944,0,0,37,0,0,13,5159,0,0,10,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,97,0,0,
2999,0,0,37,0,0,15,5196,0,0,0,0,0,1,0,
3014,0,0,38,89,0,9,5317,0,0,0,0,0,1,0,
3029,0,0,38,0,0,13,5338,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
3052,0,0,38,0,0,15,5352,0,0,0,0,0,1,0,
3067,0,0,39,96,0,9,5407,0,0,0,0,0,1,0,
3082,0,0,39,0,0,13,5424,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
3105,0,0,39,0,0,15,5438,0,0,0,0,0,1,0,
3120,0,0,40,101,0,9,5537,0,0,0,0,0,1,0,
3135,0,0,40,0,0,13,5558,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
3158,0,0,40,0,0,15,5575,0,0,0,0,0,1,0,
3173,0,0,41,241,0,4,5672,0,0,9,3,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
3224,0,0,42,156,0,4,5726,0,0,4,3,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
3255,0,0,43,204,0,4,5853,0,0,7,3,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,
3298,0,0,44,153,0,4,5905,0,0,4,3,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
3329,0,0,45,132,0,9,6022,0,0,0,0,0,1,0,
3344,0,0,45,0,0,13,6042,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
3379,0,0,45,0,0,15,6066,0,0,0,0,0,1,0,
3394,0,0,46,127,0,9,6149,0,0,0,0,0,1,0,
3409,0,0,46,0,0,13,6172,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,4,0,0,
3440,0,0,46,0,0,15,6194,0,0,0,0,0,1,0,
3455,0,0,47,143,0,9,6292,0,0,0,0,0,1,0,
3470,0,0,47,0,0,13,6317,0,0,5,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
3505,0,0,47,0,0,15,6336,0,0,0,0,0,1,0,
3520,0,0,48,131,0,9,6462,0,0,0,0,0,1,0,
3535,0,0,48,0,0,13,6484,0,0,6,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,
2,4,0,0,
3574,0,0,48,0,0,15,6511,0,0,0,0,0,1,0,
3589,0,0,49,75,0,9,6613,0,0,0,0,0,1,0,
3604,0,0,49,0,0,13,6636,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
3627,0,0,49,0,0,15,6652,0,0,0,0,0,1,0,
3642,0,0,50,123,0,9,6840,0,0,0,0,0,1,0,
3657,0,0,50,0,0,13,6862,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,
3684,0,0,50,0,0,15,6881,0,0,0,0,0,1,0,
3699,0,0,51,131,0,9,7034,0,0,0,0,0,1,0,
3714,0,0,51,0,0,13,7056,0,0,4,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
3745,0,0,51,0,0,15,7076,0,0,0,0,0,1,0,
3760,0,0,52,76,0,9,7152,0,0,0,0,0,1,0,
3775,0,0,52,0,0,13,7169,0,0,1,0,0,1,0,2,5,0,0,
3794,0,0,52,0,0,15,7182,0,0,0,0,0,1,0,
3809,0,0,53,179,0,9,7235,0,0,0,0,0,1,0,
3824,0,0,53,0,0,13,7248,0,0,1,0,0,1,0,2,3,0,0,
3843,0,0,53,0,0,15,7277,0,0,0,0,0,1,0,
3858,0,0,54,63,0,9,7360,0,0,0,0,0,1,0,
3873,0,0,54,0,0,13,7372,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
3896,0,0,54,0,0,15,7416,0,0,0,0,0,1,0,
3911,0,0,55,301,0,9,7507,0,0,0,0,0,1,0,
3926,0,0,55,0,0,13,7524,0,0,5,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
3961,0,0,55,0,0,15,7576,0,0,0,0,0,1,0,
3976,0,0,56,0,0,17,7643,0,0,1,1,0,1,0,1,97,0,0,
3995,0,0,56,0,0,45,7663,0,0,0,0,0,1,0,
4010,0,0,56,0,0,13,7673,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
4033,0,0,56,0,0,15,7715,0,0,0,0,0,1,0,
4048,0,0,57,270,0,9,7847,0,0,0,0,0,1,0,
4063,0,0,57,0,0,13,7866,0,0,12,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
4126,0,0,57,0,0,15,7899,0,0,0,0,0,1,0,
};


/*****************************************************************************/
/*    Fichero    : ORAcarga.pc                                               */
/*    Descripcion: Funciones PROC, para carga de tablas en memoria           */
/*                                                                           */
/*    Fecha      :17-OCT-96                                                  */
/*    Autor      :Javier Garcia Paredes                                      */
/*****************************************************************************/
#define _ORACARGA_PC_

#include <ORAcarga.h>

/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h 24-apr-2003.12:50:58 mkandarp Exp $ sqlca.h 
 */

/* Copyright (c) 1985, 2003, Oracle Corporation.  All rights reserved.  */
 
/*
NAME
  SQLCA : SQL Communications Area.
FUNCTION
  Contains no code. Oracle fills in the SQLCA with status info
  during the execution of a SQL stmt.
NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************

  If the symbol SQLCA_STORAGE_CLASS is defined, then the SQLCA
  will be defined to have this storage class. For example:
 
    #define SQLCA_STORAGE_CLASS extern
 
  will define the SQLCA as an extern.
 
  If the symbol SQLCA_INIT is defined, then the SQLCA will be
  statically initialized. Although this is not necessary in order
  to use the SQLCA, it is a good pgming practice not to have
  unitialized variables. However, some C compilers/OS's don't
  allow automatic variables to be init'd in this manner. Therefore,
  if you are INCLUDE'ing the SQLCA in a place where it would be
  an automatic AND your C compiler/OS doesn't allow this style
  of initialization, then SQLCA_INIT should be left undefined --
  all others can define SQLCA_INIT if they wish.

  If the symbol SQLCA_NONE is defined, then the SQLCA variable will
  not be defined at all.  The symbol SQLCA_NONE should not be defined
  in source modules that have embedded SQL.  However, source modules
  that have no embedded SQL, but need to manipulate a sqlca struct
  passed in as a parameter, can set the SQLCA_NONE symbol to avoid
  creation of an extraneous sqlca variable.
 
MODIFIED
    lvbcheng   07/31/98 -  long to int
    jbasu      12/12/94 -  Bug 217878: note this is an SOSD file
    losborne   08/11/92 -  No sqlca var if SQLCA_NONE macro set 
  Clare      12/06/84 - Ch SQLCA to not be an extern.
  Clare      10/21/85 - Add initialization.
  Bradbury   01/05/86 - Only initialize when SQLCA_INIT set
  Clare      06/12/86 - Add SQLCA_STORAGE_CLASS option.
*/
 
#ifndef SQLCA
#define SQLCA 1
 
struct   sqlca
         {
         /* ub1 */ char    sqlcaid[8];
         /* b4  */ int     sqlabc;
         /* b4  */ int     sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ int     sqlerrd[6];
         /* ub1 */ char    sqlwarn[8];
         /* ub1 */ char    sqlext[8];
         };

#ifndef SQLCA_NONE 
#ifdef   SQLCA_STORAGE_CLASS
SQLCA_STORAGE_CLASS struct sqlca sqlca
#else
         struct sqlca sqlca
#endif
 
#ifdef  SQLCA_INIT
         = {
         {'S', 'Q', 'L', 'C', 'A', ' ', ' ', ' '},
         sizeof(struct sqlca),
         0,
         { 0, {0}},
         {'N', 'O', 'T', ' ', 'S', 'E', 'T', ' '},
         {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}
         }
#endif
         ;
#endif
 
#endif
 
/* end SQLCA */
/*  */ 
/*
 * $Header: sqlca.h 24-apr-2003.12:50:58 mkandarp Exp $ sqlca.h 
 */

/* Copyright (c) 1985, 2003, Oracle Corporation.  All rights reserved.  */
 
/*
NAME
  SQLCA : SQL Communications Area.
FUNCTION
  Contains no code. Oracle fills in the SQLCA with status info
  during the execution of a SQL stmt.
NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************

  If the symbol SQLCA_STORAGE_CLASS is defined, then the SQLCA
  will be defined to have this storage class. For example:
 
    #define SQLCA_STORAGE_CLASS extern
 
  will define the SQLCA as an extern.
 
  If the symbol SQLCA_INIT is defined, then the SQLCA will be
  statically initialized. Although this is not necessary in order
  to use the SQLCA, it is a good pgming practice not to have
  unitialized variables. However, some C compilers/OS's don't
  allow automatic variables to be init'd in this manner. Therefore,
  if you are INCLUDE'ing the SQLCA in a place where it would be
  an automatic AND your C compiler/OS doesn't allow this style
  of initialization, then SQLCA_INIT should be left undefined --
  all others can define SQLCA_INIT if they wish.

  If the symbol SQLCA_NONE is defined, then the SQLCA variable will
  not be defined at all.  The symbol SQLCA_NONE should not be defined
  in source modules that have embedded SQL.  However, source modules
  that have no embedded SQL, but need to manipulate a sqlca struct
  passed in as a parameter, can set the SQLCA_NONE symbol to avoid
  creation of an extraneous sqlca variable.
 
MODIFIED
    lvbcheng   07/31/98 -  long to int
    jbasu      12/12/94 -  Bug 217878: note this is an SOSD file
    losborne   08/11/92 -  No sqlca var if SQLCA_NONE macro set 
  Clare      12/06/84 - Ch SQLCA to not be an extern.
  Clare      10/21/85 - Add initialization.
  Bradbury   01/05/86 - Only initialize when SQLCA_INIT set
  Clare      06/12/86 - Add SQLCA_STORAGE_CLASS option.
*/
 
#ifndef SQLCA
#define SQLCA 1
 
struct   sqlca
         {
         /* ub1 */ char    sqlcaid[8];
         /* b4  */ int     sqlabc;
         /* b4  */ int     sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ int     sqlerrd[6];
         /* ub1 */ char    sqlwarn[8];
         /* ub1 */ char    sqlext[8];
         };

#ifndef SQLCA_NONE 
#ifdef   SQLCA_STORAGE_CLASS
SQLCA_STORAGE_CLASS struct sqlca sqlca
#else
         struct sqlca sqlca
#endif
 
#ifdef  SQLCA_INIT
         = {
         {'S', 'Q', 'L', 'C', 'A', ' ', ' ', ' '},
         sizeof(struct sqlca),
         0,
         { 0, {0}},
         {'N', 'O', 'T', ' ', 'S', 'E', 'T', ' '},
         {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}
         }
#endif
         ;
#endif
 
#endif
 
/* end SQLCA */


/********************** Declarcion de variables Oracle  **********************/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

static char*  szhRowid         ; /* EXEC SQL VAR szhRowid         IS STRING(19); */ 

static char*  szhFecDesde      ; /* EXEC SQL VAR szhFecDesde      IS STRING(15); */ 

static char*  szhFecHasta      ; /* EXEC SQL VAR szhFecHasta      IS STRING(15); */ 

static long   lhNumProceso     ;
static short  i_shNumProceso   ;
/************************* tabla FA_CONCEPTOS ********************************/
static int    ihCodConcepto    ;
static short  shCodProducto    ;
static char*  szhDesConcepto   ; /* EXEC SQL VAR szhDesConcepto   IS STRING(61); */ 

static int    ihCodTipConce    ;
static char*  szhCodModulo     ; /* EXEC SQL VAR szhCodModulo     IS STRING(3) ; */ 

static char*  szhCodMoneda     ; /* EXEC SQL VAR szhCodMoneda     IS STRING(4) ; */ 

static short  shIndActivo      ;
static int    ihCodConcOrig    ;
static char*  szhCodTipDescu   ; /* EXEC SQL VAR szhCodTipDescu   IS STRING(2) ; */ 

static short  i_shCodConcOrig  ;
static short  i_shCodTipDescu  ;
static int    ihiCodConCobr    ;
static long   lhFactor		   ;
static short  i_shFactor  ;
/************************* tabla GE_MULTIIDIOMA  ***************************** CDescouv 27-03-2002 */
static int    ihCodConcepto_mi ;
static char*  szhCodIdioma_mi  ; /* EXEC SQL VAR szhCodIdioma_mi     IS STRING(6); */ 

static char*  szhDesConcepto_mi; /* EXEC SQL VAR szhDesConcepto_mi   IS STRING(61); */ 

/************************* tabla GE_CATIMPCLIENTES ***************************/
static long   lhCodCliente     ;
static int    ihCodCatImpos    ;

/************************* tabal GE_TIPIMPUES ********************************/
static int    ihCodTipImpue    ;
static int    ihTipMonto       ;
static int    ihCodCateImp     ;
static double dhImpUmbral      ;

/************************* tabla GE_CATIMPOSITIVA ****************************/
static char*  szhDesCatImpos   ; /* EXEC SQL VAR szhDesCatImpos     IS STRING(41); */ 


/************************* tabla FA_GRPSERCONC *******************************/
static int    ihCodGrpServi    ;

/******************************* Tabla FA_CICLFACT ***************************/
static int   ihCodCiclo        ;
static int   ihAno             ;
static long  lhCodCiclFact     ;
static char* szhFecEmision     ; /* EXEC SQL VAR szhFecEmision      IS STRING(15); */ 

static char* szhFecVencimie    ; /* EXEC SQL VAR szhFecVencimie     IS STRING(15); */ 

static char* szhFecProxVenc    ; /* EXEC SQL VAR szhFecProxVenc     IS STRING(15); */ 

static char* szhFecCaducida    ; /* EXEC SQL VAR szhFecCaducida     IS STRING(15); */ 

static char* szhFecDesdeLlan   ; /* EXEC SQL VAR szhFecDesdeLlan    IS STRING(15); */ 

static char* szhFecHastaLlam   ; /* EXEC SQL VAR szhFecHastaLlam    IS STRING(15); */ 

static char* szhFecDesdeCFijos ; /* EXEC SQL VAR szhFecDesdeCFijos  IS STRING(15); */ 

static char* szhFecHastaCFijos ; /* EXEC SQL VAR szhFecHastaCFijos  IS STRING(15); */ 

static char* szhFecDesdeOCargos; /* EXEC SQL VAR szhFecDesdeOCargos IS STRING(15); */ 

static char* szhFecHastaOCargos; /* EXEC SQL VAR szhFecHastaOCargos IS STRING(15); */ 

static char* szhFecDesdeRoa    ; /* EXEC SQL VAR szhFecDesdeRoa     IS STRING(15); */ 

static char* szhFecHastaRoa    ; /* EXEC SQL VAR szhFecHastaRoa     IS STRING(15); */ 

static char* szhFecHMenos      ; /* EXEC SQL VAR szhFecHMenos       IS STRING(15); */ 

static char* szhDirLogs        ; /* EXEC SQL VAR szhDirLogs         IS STRING(101); */ 

static char* szhDirSpool       ; /* EXEC SQL VAR szhDirSpool        IS STRING(101); */ 

static short shIndFacturacion  ;

/*****************************  Tabla GE_DIRECCIONES *************************/
static long   lhCodDireccion    ;
static char*  szhCodRegion      ; /* EXEC SQL VAR szhCodRegion      IS STRING(4) ; */ 

static char*  szhCodProvincia   ; /* EXEC SQL VAR szhCodProvincia   IS STRING(6) ; */ 

static char*  szhCodCiudad      ; /* EXEC SQL VAR szhCodCiudad      IS STRING(6) ; */ 

static char*  szhCodComuna      ; /* EXEC SQL VAR szhCodComuna      IS STRING(6) ; */ 

static char*  szhNomCalle       ; /* EXEC SQL VAR szhNomCalle       IS STRING(51); */ 

static char*  szhNumCalle       ; /* EXEC SQL VAR szhNumCalle       IS STRING(11); */ 

static char*  szhNumPiso        ; /* EXEC SQL VAR szhNumPiso        IS STRING(11); */ 

static char*  szhNumCasilla     ; /* EXEC SQL VAR szhNumCasilla     IS STRING(16); */ 

static char*  szhObsDireccion   ; /* EXEC SQL VAR szhObsDireccion   IS STRING(51); */ 

static short  i_shNumCasilla    ;
static short  i_shNumPiso       ;
static short  i_shObsDireccion  ;

/****************************** Tabla GA_DIRECCLI ****************************/
static short  ihCodTipDireccion ;

/****************************** Tabla CA_PENALIZACIONES **********************/
static int    ihTipIncidencia   ;
static char*  szhFecEfectividad ; /* EXEC SQL VAR szhFecEfectividad IS STRING(15); */ 

static double dhImpPenaliz      ;
static long   lhNumAbonado      ;
static short  i_shNumAbonado    ;

static long lhNumTransaccion;
static long lhNumVenta      ;

/* EXEC SQL END DECLARE SECTION    ; */ 



/********************* Declaracion de Cursores *******************************/
/* EXEC SQL DECLARE Cur_TipImpues CURSOR FOR
     SELECT /o+ FULL (GE_TIPIMPUES) o/
            COD_TIPIMPUE,
            IMP_UMBRAL  ,
            TIP_MONTO   ,
            COD_CATEIMP
     FROM   GE_TIPIMPUES; */ 


/* EXEC SQL DECLARE Cur_CatImpositiva CURSOR FOR
     SELECT /o+ FULL (GE_CATIMPOSITIVA) o/
            COD_CATIMPOS   ,
            DES_CATIMPOS
     FROM   GE_CATIMPOSITIVA; */ 



/* EXEC SQL DECLARE Cur_ZonaImpositiva CURSOR FOR
     SELECT /o+ FULL (GE_ZONAIMPOSITIVA) o/
            COD_ZONAIMPO,
            DES_ZONAIMPO
     FROM   GE_ZONAIMPOSITIVA; */ 

     
/* EXEC SQL DECLARE Cur_Grpserconc CURSOR FOR
     SELECT /o+ FULL(FA_GRPSERCONC) o/
            COD_CONCEPTO                          ,
            TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS'),
            COD_GRPSERVI                          ,
            TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS')
     FROM   FA_GRPSERCONC                         ; */ 


/****************************  Cursor GE_DIRECCLI ****************************/
/* EXEC SQL DECLARE Cur_Direccli CURSOR FOR
     SELECT /o+ FULL (GA_DIRECCLI) o/
            COD_CLIENTE     ,
            COD_TIPDIRECCION,
            COD_DIRECCION
     FROM   GA_DIRECCLI; */ 


/*************************** Cursor FA_CICLFACT ******************************/
/* EXEC SQL DECLARE Cur_CiclFact CURSOR FOR
     SELECT /o+ FULL (FA_CICLFACT) o/
            ROWID                                       ,
            COD_CICLO                                   ,
            ANO                                         ,
            COD_CICLFACT                                ,
            TO_CHAR(FEC_VENCIMIE,'YYYYMMDDHH24MISS')    ,
            TO_CHAR(FEC_EMISION ,'YYYYMMDDHH24MISS')    ,
            TO_CHAR(FEC_CADUCIDA,'YYYYMMDDHH24MISS')    ,
            TO_CHAR(FEC_PROXVENC,'YYYYMMDDHH24MISS')    ,
            TO_CHAR(FEC_DESDELLAM,'YYYYMMDDHH24MISS')   ,
            TO_CHAR(FEC_HASTALLAM,'YYYYMMDDHH24MISS')   ,
            TO_CHAR(FEC_DESDECFIJOS,'YYYYMMDDHH24MISS') ,
            TO_CHAR(FEC_HASTACFIJOS,'YYYYMMDDHH24MISS') ,
            TO_CHAR(FEC_DESDEOCARGOS,'YYYYMMDDHH24MISS'),
            TO_CHAR(FEC_HASTAOCARGOS,'YYYYMMDDHH24MISS'),
            TO_CHAR(FEC_DESDEROA,'YYYYMMDDHH24MISS')    ,
            TO_CHAR(FEC_HASTAROA,'YYYYMMDDHH24MISS')    ,
            TO_CHAR((FEC_DESDECFIJOS-1/86400),'YYYYMMDDHH24MISS') ,
            IND_FACTURACION                             ,
            DIR_LOGS                                    ,
            DIR_SPOOL 
      FROM  FA_CICLFACT; */ 



    /* EXEC SQL DECLARE Cur_CargosContado CURSOR FOR
       SELECT /o+ index (AK_GA_CARGOS_TRANSACCION GE_CARGOS) o/
              ROWID                                ,
              NUM_CARGO                            ,
              COD_CLIENTE                          ,
              COD_PRODUCTO                         ,
              COD_CONCEPTO                         ,
              TO_CHAR (FEC_ALTA,'YYYYMMDDHH24MISS'),
              IMP_CARGO                            ,
              COD_MONEDA                           ,
              COD_PLANCOM                          ,
              NUM_UNIDADES                         ,
              NUM_ABONADO                          ,
              NUM_TERMINAL                         ,
              COD_CICLFACT                         ,
              NUM_SERIE                            ,
              NUM_SERIEMEC                         ,
              CAP_CODE                             ,
              MES_GARANTIA                         ,
              DECODE(TRIM(NUM_PREGUIA),'',NULL,NUM_PREGUIA),
              DECODE(TRIM(NUM_GUIA),'',NULL,NUM_GUIA),
              NUM_TRANSACCION                      ,
              NUM_VENTA                            ,
              NUM_FACTURA                          ,
              COD_CONCEPTO_DTO                     ,
              VAL_DTO                              ,
              TIP_DTO                              ,
              IND_CUOTA                            ,
              NUM_PAQUETE                          ,
              IND_FACTUR                           ,
              IND_SUPERTEL
       FROM   GE_CARGOS
       WHERE  NUM_TRANSACCION = :lhNumTransaccion; */ 


    /* EXEC SQL DECLARE Cur_CargosPVenta CURSOR FOR
       SELECT /o+ index (AK_GA_CARGOS_TRANSACCION GE_CARGOS) o/
              ROWID                                ,
              NUM_CARGO                            ,
              COD_CLIENTE                          ,
              COD_PRODUCTO                         ,
              COD_CONCEPTO                         ,
              TO_CHAR (FEC_ALTA,'YYYYMMDDHH24MISS'),
              IMP_CARGO                            ,
              COD_MONEDA                           ,
              COD_PLANCOM                          ,
              NUM_UNIDADES                         ,
              NUM_ABONADO                          ,
              NUM_TERMINAL                         ,
              COD_CICLFACT                         ,
              NUM_SERIE                            ,
              NUM_SERIEMEC                         ,
              CAP_CODE                             ,
              MES_GARANTIA                         ,
              DECODE(TRIM(NUM_PREGUIA),'',NULL,NUM_PREGUIA),
              DECODE(TRIM(NUM_GUIA),'',NULL,NUM_GUIA),
              NUM_TRANSACCION                      ,
              NUM_VENTA                            ,
              NUM_FACTURA                          ,
              COD_CONCEPTO_DTO                     ,
              VAL_DTO                              ,
              TIP_DTO                              ,
              IND_CUOTA                            ,
              NUM_PAQUETE                          ,
              IND_FACTUR                           ,
              IND_SUPERTEL
       FROM   GE_CARGOS
       WHERE  NUM_TRANSACCION = :lhNumTransaccion
         AND  NUM_VENTA       = :lhNumVenta; */ 


    /* EXEC SQL DECLARE Cur_CargosCliente CURSOR FOR
       SELECT /o+ index (A,  AK_GE_CARGOS_CODCLIENTE) o/
              A.ROWID                                ,
              A.NUM_CARGO                            ,
              A.COD_CLIENTE                          ,
              A.COD_PRODUCTO                         ,
              A.COD_CONCEPTO                         ,
              TO_CHAR (A.FEC_ALTA,'YYYYMMDDHH24MISS'),
              A.IMP_CARGO                            ,
              A.COD_MONEDA                           ,
              A.COD_PLANCOM                          ,
              A.NUM_UNIDADES                         ,
              A.NUM_ABONADO                          ,
              A.NUM_TERMINAL                         ,
              A.COD_CICLFACT                         ,
              A.NUM_SERIE                            ,
              A.NUM_SERIEMEC                         ,
              A.CAP_CODE                             ,
              A.MES_GARANTIA                         ,
              DECODE(TRIM(A.NUM_PREGUIA),'',NULL,A.NUM_PREGUIA),
              DECODE(TRIM(A.NUM_GUIA),'',NULL,A.NUM_GUIA),
              A.NUM_TRANSACCION                      ,
              A.NUM_VENTA                            ,
              A.NUM_FACTURA                          ,
              A.COD_CONCEPTO_DTO                     ,
              A.VAL_DTO                              ,
              A.TIP_DTO                              ,
              A.IND_CUOTA                            ,
              A.NUM_PAQUETE                          ,
              A.IND_FACTUR                           ,
              A.IND_SUPERTEL
       FROM   GE_CARGOS A
       WHERE  A.COD_CLIENTE       = :lhCodCliente
         AND  A.NUM_FACTURA       = 0
         AND  A.NUM_TRANSACCION   = 0
         AND  A.IMP_CARGO         != 0
         AND  A.COD_CICLFACT IN (SELECT B.COD_CICLFACT
                                 FROM   FA_CICLFACT B
                                 WHERE  B.COD_CICLFACT = A.COD_CICLFACT
                                 AND B.IND_FACTURACION IN (1,2) ); */ 



/******************* Declarcion de funciones *********************************/

/*****************************************************************************/
/*                         funcion : iOpenConceptos                          */
/*****************************************************************************/
int iOpenConceptos (long lpCodCiclFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhCodCiclFact  ;
		char szCodModulo[3];
		int  iCodParametro;
	/* EXEC SQL END DECLARE SECTION  ; */ 


    lhCodCiclFact = lpCodCiclFact;
    strcpy(szCodModulo,"FA");
	iCodParametro = 12;
     
     /* EXEC SQL DECLARE Cur_Conceptos CURSOR FOR
          SELECT /o+ FULL(FA_CONCEPTOS) o/
                 A.COD_CONCEPTO,
                 A.COD_PRODUCTO,
                 A.DES_CONCEPTO,
                 A.COD_TIPCONCE,
                 A.COD_MODULO  ,
                 A.COD_MONEDA  ,
                 A.IND_ACTIVO  ,
                 A.COD_CONCORIG,
                 A.COD_TIPDESCU,
				 B.COD_CONCCOBR,
				 C.DESCRIPCION_VALOR,
				 GRUP.COD_GRPSERVI
          FROM   FA_CONCEPTOS A, FA_FACTCOBR B, FA_GRPSERCONC GRUP, FA_CICLFACT   CICL,
          		(SELECT FIC.COD_CONCEPTO, FFTN.DESCRIPCION_VALOR 
		 		   FROM FAD_IMPCONCEPTOS FIC, FAD_IMPSUBGRUPOS FIS, FAD_IMPGRUPOS FIG, FAD_PARAMETROS FP,
				   		FA_FACTOR_TIPO_UNIDAD_VW FFTN
				  WHERE FIC.COD_SUBGRUPO = FIS.COD_SUBGRUPO
				    AND FIS.COD_GRUPO = FIG.COD_GRUPO
				 	AND FP.VAL_NUMERICO = FIG.COD_FORMULARIO
					AND FP.COD_MODULO = :szCodModulo
					AND FP.COD_PARAMETRO = :iCodParametro
					AND FIG.TIP_UNIDAD = FFTN.VALOR) C
	  	  WHERE  A.COD_CONCEPTO = B.COD_CONCFACT
	  	  AND    A.COD_CONCEPTO = C.COD_CONCEPTO (+)
	  	  AND    GRUP.COD_CONCEPTO = A.COD_CONCEPTO
      	  AND    GRUP.FEC_DESDE   <= CICL.FEC_EMISION
          AND    GRUP.FEC_HASTA   >= CICL.FEC_EMISION
          AND    CICL.COD_CICLFACT = :lhCodCiclFact
		  ORDER BY A.COD_CONCEPTO; */ 


    /* EXEC SQL OPEN Cur_Conceptos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0010;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCodModulo;
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iCodParametro;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_Concepto",
                 szfnORAerror());

    return SQLCODE;
}/*********************** Final iOpenConceptos *******************************/

/*****************************************************************************/
/*                        funcion : iFetchConceptos                          */
/*****************************************************************************/
static int iFetchConceptos (CONCEPTO* pstConceptos, int *iCodConcepto )
{
    szhDesConcepto   = pstConceptos->szDesConcepto;
    szhCodModulo     = pstConceptos->szCodModulo  ;
    szhCodMoneda     = pstConceptos->szCodMoneda  ;
    szhCodTipDescu   = pstConceptos->szCodTipDescu;

    /* EXEC SQL FETCH Cur_Conceptos
             INTO :ihCodConcepto
                 ,:shCodProducto
                 ,:szhDesConcepto
                 ,:ihCodTipConce
                 ,:szhCodModulo
                 ,:szhCodMoneda
                 ,:shIndActivo
                 ,:ihCodConcOrig  :i_shCodConcOrig
                 ,:szhCodTipDescu :i_shCodTipDescu
                 ,:ihiCodConCobr
                 ,:lhFactor  :i_shFactor  
                 ,:ihCodGrpServi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )32;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&shCodProducto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhDesConcepto;
    sqlstm.sqhstl[2] = (unsigned long )61;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipConce;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodModulo;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodMoneda;
    sqlstm.sqhstl[5] = (unsigned long )4;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&shIndActivo;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcOrig;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&i_shCodConcOrig;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhCodTipDescu;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)&i_shCodTipDescu;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihiCodConCobr;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&lhFactor;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)&i_shFactor;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihCodGrpServi;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                 

    if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_Conceptos",
                 szfnORAerror());

    if (SQLCODE == 0)
    {
        pstConceptos->iFlagExiste   = 1; /* el concepto esta configurado */
        *iCodConcepto	   		    = ihCodConcepto   ;
        pstConceptos->iCodProducto	= shCodProducto   ;
        pstConceptos->iCodTipConce	= ihCodTipConce   ;
        pstConceptos->iIndActivo  	= shIndActivo     ;
        pstConceptos->iCodConCobr   = ihiCodConCobr ;
        pstConceptos->iCodGrpServi  = ihCodGrpServi ;        

        if (i_shCodConcOrig == ORA_NULL)
            pstConceptos->iCodConcOrig = -1;
        else
            pstConceptos->iCodConcOrig = ihCodConcOrig;

        if (i_shCodTipDescu == ORA_NULL)
            strcpy (pstConceptos->szCodTipDescu, "");
        
        if (i_shFactor == ORA_NULL)
            pstConceptos->lFactor = 1;
        else
        	pstConceptos->lFactor = lhFactor;

    }
    return SQLCODE;
}/*********************** Final iFetchConceptos ******************************/

/*****************************************************************************/
/*                        funcion : iCloseConceptos                          */
/*****************************************************************************/
static int iCloseConceptos (void)
{
    /* EXEC SQL CLOSE Cur_Conceptos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )95;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_Conceptos",
                 szfnORAerror());

    return SQLCODE;
}/********************** Final iCloseConceptos *******************************/

/*****************************************************************************/
/*                       funcion : bCargaConceptos                           */
/*     -NUM_CONCEPTOS numero de conceptos cargados (global al Modulo)        */
/*     -Carga de Fa_Conceptos en memoria                                     */
/*****************************************************************************/
BOOL bCargaConceptos (CONCEPTO* pConc, int* iNumConceptos)
{
 int  iNumConc = 0   ;
 int  rc       = 0   ;
 BOOL bRes     = TRUE;
 int  iCodConc = 0   ;
 CONCEPTO pConcTemp;

 if (iOpenConceptos(stCiclo.lCodCiclFact))
     return FALSE;

 while (iNumConc < MAX_CONCEPTOS && bRes)
	{
		if (iFetchConceptos (&pConcTemp, &iCodConc))
		{
			bRes = FALSE;
		}
		else 
		{
			pConc[iCodConc] = pConcTemp;
			pConc[iCodConc].iFlagExiste  = 1; /* el concepto esta configurado */
			
			iNumConc ++;
		}
	}
	
	*iNumConceptos = iNumConc;
	
	 if (rc == 0 && iNumConc == MAX_CONCEPTOS)
	 {
	     iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_Conceptos");
	     return FALSE;
	 }
	 
 return ( iCloseConceptos() )?FALSE:TRUE;
}/************************** Final bCargaConceptos ***************************/

/*****************************************************************************/
/*                           funcion : vPrintFaConceptos                     */
/*****************************************************************************/
void vPrintFaConceptos (CONCEPTO* pConc, int iNumConc)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\n\t** Tabla FA_CONCEPTOS **\n",LOG06);
        for (i=0; i<iNumConc; i++)
        {
           vDTrazasLog(szExeName,"\n\tCod.Concepto..........[%d] "
                                 "\n\tCod.Producto..........[%d] "
                                 "\n\tDes.Concepto..........[%s] "
                                 "\n\tCod.Tipo de Concepto..[%d] "
                                 "\n\tCod.Modulo............[%s] "
                                 "\n\tCood.Moneda...........[%s] "
                                 "\n\tInd.Activo............[%d] "
                                 "\n\tCod.Concepto Origen...[%ld]"
                                 "\n\tCod.Tipo Descuento....[%s]\n"
                                 ,LOG06                   ,i
                                 ,(pConc+i)->iCodProducto ,(pConc+i)->szDesConcepto
                                 ,(pConc+i)->iCodTipConce ,(pConc+i)->szCodModulo
                                 ,(pConc+i)->szCodMoneda  ,(pConc+i)->iIndActivo
                                 ,(pConc+i)->iCodConcOrig ,(pConc+i)->szCodTipDescu);
        }
    }
}/************************** Final vPrintFaConceptos *************************/

/*****************************************************************************/
/*                         funcion : iOpenConceptos_mi                       */
/*  Creado Cdescouv 27-03-2002 llenado de estructura conceptos_mi            */
/*****************************************************************************/
static int iOpenConceptos_mi (void)
{
     /* EXEC SQL DECLARE Cur_Conceptos_mi CURSOR FOR
          SELECT /o+ FULL(GE_MULTIIDIOMA) o/
       to_number(COD_CONCEPTO),
                 COD_IDIOMA  ,
                 DES_CONCEPTO
          FROM   GE_MULTIIDIOMA
         WHERE   NOM_TABLA = 'FA_CONCEPTOS'
           AND   NOM_CAMPO = 'COD_CONCEPTO'
          ORDER  BY to_number(COD_CONCEPTO); */ 



    /* EXEC SQL OPEN Cur_Conceptos_mi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0011;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )110;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Multiidioma",
                 szfnORAerror());

    return SQLCODE;
}/*********************** Final iOpenConceptos_mi *******************************/

/*****************************************************************************/
/*                        funcion : iFetchConceptos_mi                       */
/*****************************************************************************/
static int iFetchConceptos_mi (CONCEPTO_MI* pstConceptos_mi)
{
    szhDesConcepto_mi = pstConceptos_mi->szDesConcepto;
    szhCodIdioma_mi   = pstConceptos_mi->szCodIdioma;

    vDTrazasLog (szExeName,"\n\n\t** antes Fetch GE_MULTIIDIOMA **\n",LOG06);

    /* EXEC SQL FETCH Cur_Conceptos_mi
             INTO :ihCodConcepto_mi, :szhCodIdioma_mi,:szhDesConcepto_mi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )125;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto_mi;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodIdioma_mi;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhDesConcepto_mi;
    sqlstm.sqhstl[2] = (unsigned long )61;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog (szExeName,"\n\n\t** Fetch GE_MULTIIDIOMA **\n"
    					   "\n\tCod.Concepto....[%d]\n"
    					  ,LOG06,ihCodConcepto_mi);


    if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Multiidiomas",
                 szfnORAerror());

    if (SQLCODE == 0)
    {
        pstConceptos_mi->iCodConcepto = ihCodConcepto_mi;
    }
    return SQLCODE;
}/*********************** Final iFetchConceptos_mi ***************************/

/*****************************************************************************/
/*                        funcion : iCloseConceptos_mi                       */
/*****************************************************************************/
static int iCloseConceptos_mi (void)
{
    /* EXEC SQL CLOSE Cur_Conceptos_mi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )152;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_MultiIdiomas",
                 szfnORAerror());

    return SQLCODE;
}/********************** Final iCloseConceptos_mi *******************************/

/*****************************************************************************/
/*                       funcion : bCargaConceptos_mi                        */
/*     -NUM_CONCEPTOS_MI numero de conceptos cargados (global al Modulo)     */
/*     -Carga de Ge_multiIdioma en memoria  CDescouv 27-03-2002              */
/*****************************************************************************/
BOOL bCargaConceptos_mi (CONCEPTO_MI* pConc_mi, int* iNumConceptos_mi)
{
 int  iNumConc_mi = 0   ;
 int  rc          = 0   ;
 int  i           = 0   ;
 int  iRango_mi   = 0   ;
 BOOL bRes     = TRUE;

 if (iOpenConceptos_mi())
     return FALSE;

 while (iNumConc_mi < MAX_CONCEPTOS_MI && bRes)
 {
    rc = iFetchConceptos_mi (&pConc_mi[iNumConc_mi]);
    switch (rc)
    {
       case SQLOK :
         if (iRango_mi == 0)
         {
             i = stIndConcepto_mi.iNumRangos;
             vDTrazasLog (szExeName,"\t iNumrango [%d]"
                                    "\t  var => i [%d]\n",LOG06,stIndConcepto_mi.iNumRangos,i);

             if ((stIndConcepto_mi.pRangoConcepto = (RANGO_CONCEPTO *)
                 realloc((RANGO_CONCEPTO *)stIndConcepto_mi.pRangoConcepto,
                         (i+1)*sizeof(RANGO_CONCEPTO)))==(RANGO_CONCEPTO *)NULL)
             {
                 iDError (szExeName,ERR021,vInsertarIncidencia,
                          "stIndConcepto.pRangoConcepto");
                 return FALSE;
             }

             stIndConcepto_mi.pRangoConcepto[i].iCodConcIni =
                                             pConc_mi[iNumConc_mi].iCodConcepto;
             stIndConcepto_mi.pRangoConcepto[i].iIndInicial = iNumConc_mi      ;

             vDTrazasLog (szExeName,"\t codigo inicio   [%d]"
                                    "\t indice inicio   [%d]"
                                    "\t valor  inicio i [%d]\n",LOG06,
                                    stIndConcepto_mi.pRangoConcepto[i].iCodConcIni,
                                    stIndConcepto_mi.pRangoConcepto[i].iIndInicial,i);
         }
         iRango_mi++;
         vDTrazasLog (szExeName,"\t Irango [%d]\n",LOG06,iRango_mi);

         if (iRango_mi+1 == iRANGO_CONCEPTO)
         {
              vDTrazasLog (szExeName,"\t** agrego rango ** [%d]\n",LOG06,iNumConc_mi);

              i = stIndConcepto_mi.iNumRangos;

              stIndConcepto_mi.pRangoConcepto[i].iCodConcFin =
                                              pConc_mi[iNumConc_mi].iCodConcepto;
              stIndConcepto_mi.pRangoConcepto[i].iIndFinal   = iNumConc_mi      ;

              vDTrazasLog (szExeName,"\t codigo final   [%d]"
                                     "\t indice final   [%d]"
                                     "\t NConc          [%d]"
                                     "\t valor  final i [%d]\n",LOG06,
                                     stIndConcepto_mi.pRangoConcepto[i].iCodConcFin,
                                     stIndConcepto_mi.pRangoConcepto[i].iIndFinal,iNumConc_mi,i);

              stIndConcepto_mi.iNumRangos++;
              iRango_mi = 0                ;
              vDTrazasLog (szExeName,"\t Numrango [%d]\n",LOG06,stIndConcepto_mi.iNumRangos);

         }
         iNumConc_mi++;
         vDTrazasLog (szExeName,"\t INumConc [%d]\n",LOG06,iNumConc_mi);
         break     ;
       case SQLNOTFOUND:
           if (iNumConc_mi > 0 && stIndConcepto_mi.iNumRangos != iRANGO_CONCEPTO)
           {
             i = stIndConcepto_mi.iNumRangos;

             stIndConcepto_mi.pRangoConcepto[i].iCodConcFin =
                                             pConc_mi[iNumConc_mi-1].iCodConcepto;
             stIndConcepto_mi.pRangoConcepto[i].iIndFinal   = iNumConc_mi-1      ;
             stIndConcepto_mi.iNumRangos++                                    ;

             vDTrazasLog (szExeName,"\t fin codidigo final [%d]"
                                    "\t fin indice final   [%d]"
                                    "\t fin var ===> i     [%d]\n",LOG06,
                                    stIndConcepto_mi.pRangoConcepto[i].iCodConcFin,
                                    stIndConcepto_mi.pRangoConcepto[i].iIndFinal,i);

           }
       default:
           bRes = FALSE;
           break       ;
    }
 }   /* fin while */
 *iNumConceptos_mi = iNumConc_mi;

 if (rc == 0 && iNumConc_mi == MAX_CONCEPTOS_MI)
 {
     iDError (szExeName,ERR016,vInsertarIncidencia,
              "pstConceptos_mi (Ge_multiidioma)");
     return FALSE;
 }

 if (rc == SQLNOTFOUND && iNumConc_mi >= 0 && iNumConc_mi <= MAX_CONCEPTOS_MI)
 {
     qsort (pConc_mi,iNumConc_mi,sizeof(CONCEPTO_MI),iCmpConceptos_mi);
     vPrintFaConceptos_mi (pConc_mi,iNumConc_mi);
 }

 return ( iCloseConceptos_mi() )?FALSE:TRUE;
}/************************** Final bCargaConceptos_mi ************************/

/*****************************************************************************/
/*                           funcion : vPrintFaConceptos_mi                  */
/*****************************************************************************/
void vPrintFaConceptos_mi (CONCEPTO_MI* pConc_mi, int iNumConc_mi)
{
  int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\n\t** Tabla GE_MULTIIDIOMA **\n",LOG06);

	  for (i=0; i<iNumConc_mi; i++)
	  {
	     vDTrazasLog(szExeName,"\n\tCod.Concepto..[%d] "
	                           "\n\tCod.Idioma....[%s] "
	                           "\n\tDes.Concepto..[%s]\n "
	                           ,LOG06                     ,(pConc_mi+i)->iCodConcepto
	                           ,(pConc_mi+i)->szCodIdioma ,(pConc_mi+i)->szDesConcepto);

		}
	}

}/************************** Final vPrintFaConceptos_mi **********************/

/*****************************************************************************/
/*                           funcion : iOpenCatImpositiva                    */
/*****************************************************************************/
static int iOpenCatImpositiva (void)
{
    /* EXEC SQL OPEN Cur_CatImpositiva; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )167;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_CatImpositiva",
                 szfnORAerror());

    return SQLCODE;
}/************************** Final iOpenCatImpositiva ***********************/


/*****************************************************************************/
/*                           funcion : iFetchCatImpositiva                   */
/* -Entrada CATIMPOSITIVA*                                                   */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iFetchCatImpositiva (CATIMPOSITIVA* pCat)
{
  szhDesCatImpos = pCat->szDesCatImpos;

  /* EXEC SQL FETCH Cur_CatImpositiva INTO :ihCodCatImpos   ,
                                        :szhDesCatImpos  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )182;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCatImpos;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesCatImpos;
  sqlstm.sqhstl[1] = (unsigned long )41;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_CatImpositiva",
               szfnORAerror());

  if (SQLCODE)
      pCat->iCodCatImpos    = ihCodCatImpos   ;

  return SQLCODE;
}/************************** Final iFetchCatImpositiva ***********************/

/*****************************************************************************/
/*                           vPrintCatImpositiva                             */
/*****************************************************************************/
void vPrintCatImpositiva (CATIMPOSITIVA* pCatImpositiva,int iNumCatImpositiva)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\n\t** Tabla GE_CATIMPOSITIVA **\n",LOG06);

	  for (iInd=0;iInd<iNumCatImpositiva;iInd++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d] Cod.Categoria Impositiva...[%d]"
	                              "\n\t[%d] Des.Categoria Impositiva...[%s]"
	                              ,LOG06,iInd,pCatImpositiva[iInd].iCodCatImpos
	                              ,iInd,pCatImpositiva[iInd].szDesCatImpos)  ;
	  }/* fin for iInd ... */
	}
}/************************** Final vPrintCatImpositiva ***********************/


/*****************************************************************************/
/*                           funcion : iCloseCatImpositiva                   */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iCloseCatImpositiva (void)
{
  /* EXEC SQL CLOSE Cur_CatImpositiva; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )205;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_CatImpositiva",
               szfnORAerror ());

  return SQLCODE;
}/************************* Final iCloseCatImpositiva ************************/

/*****************************************************************************/
/*                          funcion : iCmpCatImpositiva                      */
/*****************************************************************************/
int iCmpCatImpositiva (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = ((CATIMPOSITIVA *)cad1)->iCodCatImpos-
           ((CATIMPOSITIVA *)cad2)->iCodCatImpos) != 0)?rc:0;
}/************************* Final iCmpCatImpositiva **************************/

/*****************************************************************************/
/*                          funcion : bCargaCatImpositiva                    */
/* -Funcion que carga en memoria la tabla Ge_CatImpositiva                   */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bCargaCatImpositiva (CATIMPOSITIVA* pCatImp, int* iNumCatImp)
{
  int rc = 0, iNumCat= 0;

  if (iOpenCatImpositiva())
      return FALSE;

  for (iNumCat=0;iNumCat<MAX_CATIMPOSITIVA;iNumCat++)
  {
       rc = iFetchCatImpositiva (&pCatImp[iNumCat]);
       if (rc == SQLNOTFOUND)
           break;
       if (rc != 0)
           return FALSE;

  }/* fin for->(;;) */

  *iNumCatImp = iNumCat;
  if (rc == 0 && iNumCat == MAX_CATIMPOSITIVA)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,
               "pstCatImpositiva (Ge_CatImpositiva)");
      return FALSE;
  }

  if (rc == SQLNOTFOUND && iNumCat >= 0 && iNumCat <= MAX_CATIMPOSITIVA)
  {
      qsort (pCatImp,iNumCat,sizeof(CATIMPOSITIVA),iCmpCatImpositiva);
      vPrintCatImpositiva (pCatImp,iNumCat);
  }
  return (iCloseCatImpositiva())?FALSE:TRUE;
}/************************* Final bCargaCatImpositiva ************************/


/*****************************************************************************/
/*                          funcion : iOpenZonaImpositiva                    */
/*****************************************************************************/
static int iOpenZonaImpositiva (void)
{
  /* EXEC SQL OPEN Cur_ZonaImpositiva; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0003;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )220;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_ZonaImpositiva",
               szfnORAerror ());

  return SQLCODE;
}/************************* Final iOpenZonaImpositiva ************************/


/*****************************************************************************/
/*                          funcion : iFetchZonaImpositiva                   */
/*****************************************************************************/
static int iFetchZonaImpositiva (ZONAIMPOSITIVA* pZonaI)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhDesZonaImpo; /* EXEC SQL VAR szhDesZonaImpo IS STRING(41); */ 

  static int    ihCodZonaImpo ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhDesZonaImpo = pZonaI->szDesZonaImpo;

  /* EXEC SQL FETCH Cur_ZonaImpositiva INTO :ihCodZonaImpo ,
                                         :szhDesZonaImpo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )235;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodZonaImpo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesZonaImpo;
  sqlstm.sqhstl[1] = (unsigned long )41;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_ZonaImpositiva",
               szfnORAerror());

  if (SQLCODE == 0)
      pZonaI->iCodZonaImpo = ihCodZonaImpo;

  return SQLCODE;

}/************************* Final iFetchZonaImpositiva ***********************/


/*****************************************************************************/
/*                          funcion : iCloseZonaImpositiva                   */
/*****************************************************************************/
static int iCloseZonaImpositiva (void)
{
  /* EXEC SQL CLOSE Cur_ZonaImpositiva; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )258;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_ZonaImpositiva",
               szfnORAerror());
  return SQLCODE;
}/************************* Final iCloseZonaImpositiva ***********************/


/*****************************************************************************/
/*                          funcion : iCmpZonaImpositiva                     */
/* -Funcion de comparacion                                                   */
/*****************************************************************************/
int iCmpZonaImpositiva (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = ((ZONAIMPOSITIVA *)cad1)->iCodZonaImpo-
           ((ZONAIMPOSITIVA *)cad2)->iCodZonaImpo) != 0)?rc:0;

}/************************* Final iCmpZonaImpositiva *************************/

/*****************************************************************************/
/*                          funcion : bCargaZonaImpositiva                   */
/* -Funcion de carga en memoria de la tabla Ge_ZonaImpositiva                */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bCargaZonaImpositiva (ZONAIMPOSITIVA* pZonaI, int* iNumZonaI)
{
  int rc = 0, iNumZona = 0;

  if (iOpenZonaImpositiva ())
      return FALSE;

  for (iNumZona=0;iNumZona<MAX_ZONAIMPOSITIVA;iNumZona++)
  {
       rc = iFetchZonaImpositiva (&pZonaI[iNumZona]);

       if (rc == SQLNOTFOUND)
           break;
       if (rc != 0)
           return FALSE;

  }/* fin for->(;;) */

  *iNumZonaI = iNumZona;
  if (rc == 0 && iNumZona == MAX_ZONAIMPOSITIVA)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,
               "Ge_ZonaImpositiva");
      return FALSE;
  }
  if (rc == SQLNOTFOUND && iNumZona >= 0 && iNumZona <= MAX_ZONAIMPOSITIVA)
  {
      qsort (pZonaI,iNumZona,sizeof(ZONAIMPOSITIVA),iCmpZonaImpositiva);
      vPrintZonaImpositiva (pZonaI,iNumZona);
  }
  return (iCloseZonaImpositiva())?FALSE:TRUE;
}/************************* Final bCargaZonaImpositiva ***********************/


/*****************************************************************************/
/*                          funcion : vPrintZonaImpositiva                   */
/*****************************************************************************/
void vPrintZonaImpositiva (ZONAIMPOSITIVA* pZonaImpositiva,int iNumZona)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\n\t** Tabla GE_ZONAIMPOSITIVA **\n",LOG06);

	  for (iInd=0;iInd<iNumZona;iInd++)
	  {
	      vDTrazasLog (szExeName,"\n\t[%d] Cod.Zona Impositiva ....[%d]"
	                             "\n\t[%d] Des.Zona Impositiva ....[%s]"
	                             ,LOG06,iInd,pZonaImpositiva[iInd].iCodZonaImpo
	                             ,iInd,pZonaImpositiva[iInd].szDesZonaImpo);
	  }
	}
}/************************* Final vPrintZonaImpositiva ***********************/

/*****************************************************************************/
/*                           funcion : iOpenCatImpClientes                   */
/*****************************************************************************/
static int iOpenCatImpClientes (void)
{
   /* EXEC SQL DECLARE Cur_CatImpClientes CURSOR FOR
        SELECT /o+ FULL(GE_CATIMPCLIENTES) o/
               COD_CLIENTE                          ,
               TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS'),
               TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS'),
               COD_CATIMPOS
        FROM   GE_CATIMPCLIENTES                    ; */ 


    /* EXEC SQL OPEN Cur_CatImpClientes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0012;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )273;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_CatImpClientes"
                ,szfnORAerror());

    return SQLCODE;
}/************************** Final iOpenCatImpClientes ***********************/

/*****************************************************************************/
/*                            funcion : iFetchCatImpClientes                 */
/*****************************************************************************/
static int iFetchCatImpClientes (CATIMPCLIENTES* pstCatimpclientes)
{
    szhFecDesde      = pstCatimpclientes->szFecDesde     ;
    szhFecHasta      = pstCatimpclientes->szFecHasta     ;

    /* EXEC SQL FETCH Cur_CatImpClientes INTO :lhCodCliente,
                                           :szhFecDesde,
                                           :szhFecHasta,
                                           :ihCodCatImpos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )288;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCatImpos;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
        iDError(szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_CatImpClientes"
               ,szfnORAerror());

    if (SQLCODE == 0)
    {
        pstCatimpclientes->lCodCliente = lhCodCliente      ;
        pstCatimpclientes->iCodCatImpos= ihCodCatImpos     ;
    }
    return SQLCODE;
}/************************** Final iFetchCatImpClientes **********************/

/*****************************************************************************/
/*                         funcion : iCloseCatImpClientes                    */
/*****************************************************************************/
static int iCloseCatImpClientes (void)
{
    /* EXEC SQL CLOSE Cur_CatImpClientes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )319;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError(szExeName,ERR000,vInsertarIncidencia,"Close->Ge_CatImpClientes",
                szfnORAerror());
    return SQLCODE;
}/************************** Final iCloseCatImpClientes **********************/

/*****************************************************************************/
/*                          funcion : bCargaCatImpClientes                   */
/*    -Funcion que carga en memoria la tabla GE_CATIMPCLIENTES               */
/*    -NUM_CATIMPCLIENTES numero de reg. de GE_CATIMPCLIENTES (global)       */
/*****************************************************************************/
BOOL bCargaCatImpClientes (CATIMPCLIENTES* pstCat, int* iNumCatImpClientes)
{
     int rc = 0, iNumCat = 0;

     if (iOpenCatImpClientes ())
         return FALSE;

     for (iNumCat=0;iNumCat<MAX_CATIMPCLIENTES;iNumCat++)
     {
          rc = iFetchCatImpClientes (&pstCat[iNumCat]);
          if (rc == SQLNOTFOUND) break;
          if (rc != 0) return FALSE;
     }/* Fin del for */
     *iNumCatImpClientes = iNumCat;
     if (rc == 0 && iNumCat == MAX_CATIMPCLIENTES)
     {
         iDError (szExeName,ERR016,vInsertarIncidencia,
                  "pstCatImpClientes (Ge_CatImpCliente)");
         return FALSE;
     }
     if (rc == SQLNOTFOUND && iNumCat >= 0 && iNumCat <= MAX_CATIMPCLIENTES)
     {
         qsort (pstCat, *iNumCatImpClientes, sizeof(CATIMPCLIENTES),
                iCmpCatImpCliente);
         vPrintCatImpCliente (pstCat,*iNumCatImpClientes);
     }
     return (iCloseCatImpClientes())?FALSE:TRUE;
}/************************* Final bCargaCatImpClientes ***********************/


/*****************************************************************************/
/*                          funcion : iOpenTipImpues                         */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iOpenTipImpues (void)
{
  /* EXEC SQL OPEN Cur_TipImpues; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0001;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )334;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_TipImpues",
               szfnORAerror());

  return SQLCODE;
}/************************* Final iOpenTipImpues *****************************/

/*****************************************************************************/
/*                          funcion : iFetchTipImpues                        */
/* -Entrada TIPIMPUES*                                                       */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iFetchTipImpues (TIPIMPUES* pTipImpues)
{

   /* EXEC SQL FETCH Cur_TipImpues INTO :ihCodTipImpue ,
                                     :dhImpUmbral   ,
                                     :ihTipMonto    ,
                                     :ihCodCateImp; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )349;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipImpue;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&dhImpUmbral;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihTipMonto;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCateImp;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_TipImpues",
               szfnORAerror());

   if (SQLCODE == 0)
   {
       pTipImpues->iCodTipImpue = ihCodTipImpue;
       pTipImpues->dImpUmbral   = dhImpUmbral  ;
       pTipImpues->iTipMonto    = ihTipMonto  ;
       pTipImpues->iCodCateImp  = ihCodCateImp  ;
   }
   return SQLCODE;

}/************************ Final iFetchTipImpues *****************************/

/*****************************************************************************/
/*                         funcion : iCloseTipImpues                         */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iCloseTipImpues (void)
{
   /* EXEC SQL CLOSE Cur_TipImpues; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )380;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_TipImpues",
                szfnORAerror());

   return SQLCODE;
}/************************ Final iCloseTipImpues *****************************/

/*****************************************************************************/
/*                         funcion : iCmpTipImpues                           */
/* -Funcion de Comparacion                                                   */
/*****************************************************************************/
int iCmpTipImpues (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = ((TIPIMPUES *)cad1)->iCodTipImpue-
           ((TIPIMPUES *)cad2)->iCodTipImpue ) != 0)?rc:0;

}/************************ Final iCmpTipImpues *******************************/

/*****************************************************************************/
/*                         funcion : bCargaTipImpues                         */
/* -Funcion que Carga en memoria la tabla Ge_TipImpues                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bCargaTipImpues (TIPIMPUES* pTipImp, int* iNumTipImp)
{
   int rc = 0, iNumTip = 0;

   if (iOpenTipImpues ())
       return FALSE;

   for (iNumTip=0;iNumTip<MAX_TIPIMPUES;iNumTip++)
   {
        rc = iFetchTipImpues (&pTipImp[iNumTip]);
        if (rc == SQLNOTFOUND)
            break;
        if (rc != 0)
            return FALSE;
   }/* fin for->(;;) */
   *iNumTipImp = iNumTip;

   if (rc == 0 && iNumTip == MAX_TIPIMPUES)
   {
       iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_TipImpues");
       return FALSE;
   }
   if (rc == SQLNOTFOUND && iNumTip >= 0 && iNumTip <= MAX_TIPIMPUES)
   {
       qsort (pTipImp,iNumTip,sizeof(TIPIMPUES),iCmpTipImpues);
       vPrintTipImpues (pTipImp,iNumTip);
   }
   return (iCloseTipImpues())?FALSE:TRUE;
}/************************ Final bCargaTipImpues *****************************/

/*****************************************************************************/
/*                         funcion : vPrintTipImpues                         */
/*****************************************************************************/
void vPrintTipImpues (TIPIMPUES* pTipImpues,int iNumTipImpues)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\n\t** Tabla GE_TIPIMPUES **\n",LOG06);
	  for (iInd=0;iInd<iNumTipImpues;iInd++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d] Cod.Tipo Impuesto...[%d]"
	                              "\n\t[%d] Imp.Umbral .........[%ld]"
	                             ,LOG06
	                             ,iInd,pTipImpues[iInd].iCodTipImpue
	                             ,iInd,pTipImpues[iInd].dImpUmbral);

		}
	}
}/************************ Final vPrintTipImpues *****************************/


/*****************************************************************************/
/*                          funcion : iOpenImpuestos                         */
/* -Funcion que abre el cursor sobre la tabla GE_IMPUESTOS                   */
/* -Salida SQLCODE                                                           */
/*****************************************************************************/
static int iOpenImpuestos (void)
{
   /* EXEC SQL DECLARE Cur_Impuestos CURSOR FOR
        SELECT /o+ FULL (GE_IMPUESTOS) o/
              I.COD_CATIMPOS                            ,
              I.COD_ZONAIMPO                            ,
              I.COD_ZONAABON                            ,
              I.COD_TIPIMPUES                           ,
              I.COD_GRPSERVI                            ,
              TO_CHAR (I.FEC_DESDE,'YYYYMMDD')||'000000',
              I.COD_CONCGENE                            ,
              TO_CHAR (I.FEC_HASTA,'YYYYMMDD')||'235959',
              I.PRC_IMPUESTO,
              T.TIP_MONTO
        FROM  GE_IMPUESTOS I,GE_TIPIMPUES T
        WHERE I.COD_TIPIMPUES=T.COD_TIPIMPUE; */ 


   /* EXEC SQL OPEN Cur_Impuestos; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0013;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )395;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Impuestos",
                szfnORAerror());

   return SQLCODE;

}/************************* Final iOpenImpuestos *****************************/

/*****************************************************************************/
/*                          funcion : iFetchImpuestos                        */
/* -Funcion Fetch sobre el cursor de la tabla Ge_Impuestos                   */
/* -Entrada un puntero a la estructura IMPUESTOS                             */
/* -Salida SQLCODE                                                           */
/*****************************************************************************/
static int iFetchImpuestos (IMPUESTOS* pImpuestos)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static int    ihCodCatImpos    ;
   static int    ihCodZonaImpo    ;
   static int    ihCodZonaAbon    ;
   static int    ihCodTipImpues   ;
   static int    ihCodGrpServi    ;
   static int    ihCodConcGene    ;
   static float  fhPrcImpuesto    ;
   static int    ihTipMonto       ;
   /* EXEC SQL END DECLARE SECTION   ; */ 



   szhFecDesde   = pImpuestos->szFecDesde;
   szhFecHasta   = pImpuestos->szFecHasta;

   /* EXEC SQL FETCH Cur_Impuestos INTO
								:ihCodCatImpos ,
                                :ihCodZonaImpo ,
                                :ihCodZonaAbon ,
                                :ihCodTipImpues,
                                :ihCodGrpServi ,
                                :szhFecDesde   ,
                                :ihCodConcGene ,
                                :szhFecHasta   ,
                                :fhPrcImpuesto ,
                                :ihTipMonto; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )410;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCatImpos;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodZonaImpo;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodZonaAbon;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipImpues;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodGrpServi;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFecDesde;
   sqlstm.sqhstl[5] = (unsigned long )15;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcGene;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhFecHasta;
   sqlstm.sqhstl[7] = (unsigned long )15;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&fhPrcImpuesto;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(float);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihTipMonto;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
	iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Impuestos",
                 szfnORAerror());
    if (SQLCODE == 0)
    {
        pImpuestos->iCodCatImpos = ihCodCatImpos ;
        pImpuestos->iCodZonaImpo = ihCodZonaImpo ;
        pImpuestos->iCodZonaAbon = ihCodZonaAbon ;
		pImpuestos->iCodTipImpues= ihCodTipImpues;
		pImpuestos->iCodGrpServi = ihCodGrpServi ;
		pImpuestos->iCodConcGene = ihCodConcGene ;
		pImpuestos->fPrcImpuesto = fhPrcImpuesto ;
		pImpuestos->iTipMonto    = ihTipMonto;
    }
    return SQLCODE;

}/************************ Final iFetchImpuestos *****************************/

/*****************************************************************************/
/*                         funcion : iCloseImpuestos                         */
/* -Funcion que cierra el cursor sobre la tabla Ge_Impuestos                 */
/*****************************************************************************/
static int iCloseImpuestos (void)
{
   /* EXEC SQL CLOSE Cur_Impuestos; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )465;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Impuestos",
                szfnORAerror());
   return SQLCODE;
}/************************ Final iCloseImpuestos *****************************/

/*****************************************************************************/
/*                         funcion : iCmpImpuestos                           */
/* -Funcion de comparacion para la tabla Ge_Impuestos                        */
/* -Salida si los campos a comparar son iguales ->0, sino != 0               */
/*****************************************************************************/
int iCmpImpuestos (const void* cad1, const void* cad2)
{
  int rc  = 0;
  return
  ( (rc = ((IMPUESTOS *)cad1)->iCodCatImpos -
          ((IMPUESTOS *)cad2)->iCodCatImpos ) != 0)?rc:
  ( (rc = ((IMPUESTOS *)cad1)->iCodZonaImpo -
          ((IMPUESTOS *)cad2)->iCodZonaImpo ) != 0)?rc:
  ( (rc = ((IMPUESTOS *)cad1)->iCodZonaAbon -
          ((IMPUESTOS *)cad2)->iCodZonaAbon ) != 0)?rc:
  ( (rc = ((IMPUESTOS *)cad1)->iCodTipImpues-
          ((IMPUESTOS *)cad2)->iCodTipImpues) != 0)?rc:
  ( (rc = ((IMPUESTOS *)cad1)->iCodGrpServi -
          ((IMPUESTOS *)cad2)->iCodGrpServi ) != 0)?rc:
  ( (rc = ((IMPUESTOS *)cad1)->iCodConcGene -
          ((IMPUESTOS *)cad2)->iCodConcGene ) != 0)?rc:
  ( (rc = strcmp ( ((IMPUESTOS *)cad1)->szFecDesde,
                   ((IMPUESTOS *)cad2)->szFecDesde) ) != 0)?rc:0;

}/************************ Final iCmpImpuestos *******************************/


/*****************************************************************************/
/*                         funcion : bCargaImpuestos                         */
/* -NUM_IMPUESTOS numero de reg. en Ge_Impuestos (global al modulo)          */
/* -Carga de Ge_Impuestos en memoria                                         */
/* -Entrada Estructura pstImpuestos                                          */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
BOOL bCargaImpuestos (IMPUESTOS* pstImpuestos, int* iNumImpuestos)
{
   int iNumImp = 0, rc = 0;

   if (iOpenImpuestos())
       return FALSE;

   for (iNumImp=0;iNumImp<MAX_IMPUESTOS;iNumImp++)
   {
        rc = iFetchImpuestos (&pstImpuestos[iNumImp]);
        if (rc == SQLNOTFOUND)
            break;
        if (rc != 0)
            return FALSE;
   }/* fin for ->(;;) */

   *iNumImpuestos = iNumImp;
   if (rc == 0 && iNumImp == MAX_IMPUESTOS)
   {
       iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Impuestos");
       return FALSE;
   }
   if (rc == SQLNOTFOUND && iNumImp >= 0 && iNumImp <= MAX_IMPUESTOS)
   {
       qsort (pstImpuestos, *iNumImpuestos, sizeof(IMPUESTOS), iCmpImpuestos);
       vPrintGeImpuestos (pstImpuestos,*iNumImpuestos);
   }
   return ( iCloseImpuestos () )?FALSE:TRUE;

}/************************* Final bCargaImpuestos ****************************/


/*****************************************************************************/
/*                          funcion : iOpenZonaCiudad                        */
/*****************************************************************************/
static int iOpenZonaCiudad (void)
{
   /* EXEC SQL DECLARE Cur_ZonaCiudad CURSOR FOR
        SELECT /o+ FULL(GE_ZONACIUDAD) o/
            COD_REGION                            ,
            COD_PROVINCIA                         ,
            COD_CIUDAD                            ,
            TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS'),
            TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS'),
            COD_ZONAIMPO
     FROM   GE_ZONACIUDAD                         ; */ 


  /* EXEC SQL OPEN Cur_ZonaCiudad; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0014;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )480;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_ZonaCiudad",
               szfnORAerror());

  return SQLCODE;
}/************************* Final iOpenZonaCiudad ****************************/

/*****************************************************************************/
/*                          funcion : iFetchZonaCiudad                       */
/* -Entrada ZONAMUNI*                                                        */
/* -Salida  SQLCODE                                                          */
/*****************************************************************************/
static int iFetchZonaCiudad (ZONACIUDAD* pZonaC)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int    ihCodZonaImpo  ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhFecDesde     = pZonaC->szFecDesde    ;
  szhFecHasta     = pZonaC->szFecHasta    ;
  szhCodRegion    = pZonaC->szCodRegion   ;
  szhCodProvincia = pZonaC->szCodProvincia;
  szhCodCiudad    = pZonaC->szCodCiudad   ;

  /* EXEC SQL FETCH Cur_ZonaCiudad INTO :szhCodRegion   ,
                                     :szhCodProvincia,
                                     :szhCodCiudad   ,
                                     :szhFecDesde    ,
                                     :szhFecHasta    ,
                                     :ihCodZonaImpo  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )495;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodProvincia;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodCiudad;
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[4] = (unsigned long )15;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodZonaImpo;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_ZonaCiudad",
               szfnORAerror ());

  if (SQLCODE == 0)
      pZonaC->iCodZonaImpo = ihCodZonaImpo;
   return SQLCODE;
}/************************* Final iFetchZonaCiudad ***************************/

/*****************************************************************************/
/*                          funcion : iCloseZonaCiudad                       */
/*****************************************************************************/
static int iCloseZonaCiudad (void)
{
  /* EXEC SQL CLOSE Cur_ZonaCiudad; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )534;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_ZonaCiudad",
               szfnORAerror());

  return SQLCODE;
}/************************* Final iCloseZonaCiudad ***************************/

/*****************************************************************************/
/*                           funcion : iCargaZonaCiudad                      */
/* -Funcion que carga en Memoria la tabla GE_ZONACIUDAD en la estructura glo-*/
/*  bal al modulo (GRPSERCONC* pstGrpserconc) y NUM_ZONAMUNI   variable glo- */
/*  bal que guarda el numero de reg. de la tabla.                            */
/*****************************************************************************/
BOOL bCargaZonaCiudad (ZONACIUDAD* pstZonaC, int* iNumZonaC)
{
  int rc = 0, iNumZona = 0;

  if (iOpenZonaCiudad())
      return FALSE;

  for (iNumZona=0;iNumZona<MAX_ZONACIUDAD;iNumZona++)
  {
      rc = iFetchZonaCiudad (&pstZonaC[iNumZona]);
      if (rc == SQLNOTFOUND)
          break;
      if (rc != 0)
          return FALSE;

  }/* fin for->(;;) */
  *iNumZonaC = iNumZona;
  if (rc == 0 && iNumZona == MAX_ZONACIUDAD)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_ZonaCiudad");
      return FALSE;
  }
  if (rc == SQLNOTFOUND && iNumZona >= 0 && iNumZona <= MAX_ZONACIUDAD)
  {
      qsort (pstZonaC,*iNumZonaC,sizeof(ZONACIUDAD),iCmpZonaCiudad);
  }
  return (iCloseZonaCiudad())?FALSE:TRUE;

}/************************* Final bCargaZonaCiudad ***************************/



/*****************************************************************************/
/*                          funcion : iOpenGrpSerConc                        */
/*****************************************************************************/
static int iOpenGrpSerConc (void)
{
  /* EXEC SQL OPEN Cur_Grpserconc; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0004;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )549;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_Grpserconc",
               szfnORAerror());

  return SQLCODE;
}/************************* Final iOpenGrpSerConc ****************************/

/*****************************************************************************/
/*                          funcion : iFetchGrpSerConc                       */
/*****************************************************************************/
static int iFetchGrpSerConc (GRPSERCONC* pGrpserconc)
{
  szhFecDesde = pGrpserconc->szFecDesde;
  szhFecHasta = pGrpserconc->szFecHasta;

  /* EXEC SQL FETCH Cur_Grpserconc INTO :ihCodConcepto,
                                     :szhFecDesde  ,
                                     :ihCodGrpServi,
                                     :szhFecHasta  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )564;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[1] = (unsigned long )15;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodGrpServi;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_Grpserconc",
               szfnORAerror());
  if (SQLCODE == 0)
  {
      pGrpserconc->iCodConcepto = ihCodConcepto;
      pGrpserconc->iCodGrpServi = ihCodGrpServi;
  }

  return SQLCODE;
}/************************* Final iFetchGrpSerConc ***************************/

/*****************************************************************************/
/*                          funcion : iCloseGrpSerConc                       */
/*****************************************************************************/
static int iCloseGrpSerConc (void)
{
  /* EXEC SQL CLOSE Cur_Grpserconc; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )595;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_Grpserconc",
               szfnORAerror());

  return SQLCODE;
}/************************ Final iCloseGrpSerConc ****************************/


/*****************************************************************************/
/*                          funcion : bCargaGrpSerConc                       */
/* -Carga en memoria la tabla FA_GRPSERCONC en estructura global al modulo   */
/*  (GRPSERCONC* pstGrpserconc) y el numero de reg. de la tabla en una varia-*/
/*  ble global (NUM_GRPSERCONC).                                             */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
BOOL bCargaGrpSerConc (GRPSERCONC* pGrpserconc, int* iNumGrpSerConc)
{
  int rc = 0, iNumGrp = 0;

  if (iOpenGrpSerConc())
       return FALSE;

  for (iNumGrp=0;iNumGrp<MAX_GRPSERCONC;iNumGrp++)
  {
       rc = iFetchGrpSerConc (&pGrpserconc[iNumGrp]);
       if (rc == SQLNOTFOUND)
           break;
       if (rc != 0)
           return FALSE;

  }/* fin for ->(;;) */
  *iNumGrpSerConc = iNumGrp;
  if (rc == 0 && iNumGrp == MAX_GRPSERCONC)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_GrpSerConc");
      return FALSE;
  }
  if (rc == SQLNOTFOUND && iNumGrp >= 0 && iNumGrp <= MAX_GRPSERCONC)
  {
      qsort (pGrpserconc, *iNumGrpSerConc, sizeof(GRPSERCONC), iCmpGrpSerConc);
      vPrintGrpSerConc (pGrpserconc,*iNumGrpSerConc);
  }
  return ( iCloseGrpSerConc() )?FALSE:TRUE;
}/************************* Final bCargaGrpSerConc ***************************/


/*****************************************************************************/
/*                        funcion : iOpenDirecciones                         */
/* -Valores Retorno SQLCODE                                                  */
/*****************************************************************************/
static int iOpenDirecciones (void)
{
  /* EXEC SQL DECLARE Cur_Direcciones CURSOR FOR
        SELECT /o+ FULL (GE_DIRECCIONES) o/
               COD_DIRECCION,
               COD_REGION   ,
               COD_PROVINCIA,
               COD_CIUDAD   ,
               COD_COMUNA   ,
               NOM_CALLE    ,
               NUM_CALLE    ,
               NUM_PISO     ,
               NUM_CASILLA  ,
               OBS_DIRECCION
        FROM   GE_DIRECCIONES; */ 


  /* EXEC SQL OPEN Cur_Direcciones; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0015;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )610;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Direcciones",
               szfnORAerror());

  return SQLCODE;
}/*********************** Final iOpenDirecciones *****************************/


/*****************************************************************************/
/*                        funcion : iFetchDirecciones                        */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iFetchDirecciones (DIRECCIONES* pDirec)
{
   szhCodRegion    = pDirec->szCodRegion   ;
   szhCodProvincia = pDirec->szCodProvincia;
   szhCodCiudad    = pDirec->szCodCiudad   ;
   szhCodComuna    = pDirec->szCodComuna   ;
   szhNomCalle     = pDirec->szNomCalle    ;
   szhNumCalle     = pDirec->szNumCalle    ;
   szhNumPiso      = pDirec->szNumPiso     ;
   szhNumCasilla   = pDirec->szNumCasilla  ;
   szhObsDireccion = pDirec->szObsDireccion;


   /* EXEC SQL FETCH Cur_Direcciones INTO :lhCodDireccion                  ,
                                       :szhCodRegion                    ,
                                       :szhCodProvincia                 ,
                                       :szhCodCiudad                    ,
                                       :szhCodComuna                    ,
                                       :szhNomCalle                     ,
                                       :szhNumCalle                     ,
                                       :szhNumPiso:i_shNumPiso          ,
                                       :szhNumCasilla:i_shNumCasilla    ,
                                       :szhObsDireccion:i_shObsDireccion; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )625;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCodDireccion;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodRegion;
   sqlstm.sqhstl[1] = (unsigned long )4;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodProvincia;
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhCodCiudad;
   sqlstm.sqhstl[3] = (unsigned long )6;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodComuna;
   sqlstm.sqhstl[4] = (unsigned long )6;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhNomCalle;
   sqlstm.sqhstl[5] = (unsigned long )51;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhNumCalle;
   sqlstm.sqhstl[6] = (unsigned long )11;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhNumPiso;
   sqlstm.sqhstl[7] = (unsigned long )11;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)&i_shNumPiso;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhNumCasilla;
   sqlstm.sqhstl[8] = (unsigned long )16;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)&i_shNumCasilla;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhObsDireccion;
   sqlstm.sqhstl[9] = (unsigned long )51;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)&i_shObsDireccion;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Direcciones",
                szfnORAerror());

   if (SQLCODE)
   {
       pDirec->lCodDireccion = lhCodDireccion;
       if (i_shNumPiso    == ORA_NULL)
           strcpy (pDirec->szNumPiso,"");

       if (i_shNumCasilla == ORA_NULL)
           strcpy (pDirec->szNumCasilla,"");

       if (i_shObsDireccion == ORA_NULL)
           strcpy (pDirec->szObsDireccion,"");

   }/* fin sqlcode */
   return SQLCODE;

}/*********************** Final iFetchDirecciones ****************************/


/*****************************************************************************/
/*                        funcion : iCloseDirecciones                        */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iCloseDirecciones (void)
{
   /* EXEC SQL CLOSE Cur_Direcciones; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )680;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Direcciones",
                szfnORAerror ());

   return SQLCODE;
}/********************** Final iCloseDirecciones *****************************/


/*****************************************************************************/
/*                       funcion : iCmpDirecciones                           */
/* -Funcion de comparacion                                                   */
/*****************************************************************************/
int iCmpDirecciones (const void* cad1, const void* cad2)
{
   int rc = 0;

   if ( ((DIRECCIONES *)cad1)->lCodDireccion <
        ((DIRECCIONES *)cad2)->lCodDireccion )
          rc = -1;
   if ( ((DIRECCIONES *)cad1)->lCodDireccion >
        ((DIRECCIONES *)cad2)->lCodDireccion )
          rc =  1;
   if ( ((DIRECCIONES *)cad1)->lCodDireccion ==
        ((DIRECCIONES *)cad2)->lCodDireccion )
          rc =  0;
   return rc;
}/********************  Final iCmpDirecciones ********************************/


/*****************************************************************************/
/*                       funcion : bCargaDirecciones                         */
/* -Funcion que carga en memoria (DIRECCIONES* pstDirecciones) la tabla      */
/*  GE_DIRECIONES y registramos el numero de reg. en NUM_DIRECCIONES         */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bCargaDirecciones (DIRECCIONES* pDir, int* iNumDirecciones)
{
  int iNumDir = 0, rc = 0;


  if (iOpenDirecciones())
       return FALSE;

  for (iNumDir=0;iNumDir<MAX_DIRECCIONES;iNumDir++)
  {
      rc = iFetchDirecciones (&pDir[iNumDir]);
      if (rc == SQLNOTFOUND)
          break;
      if (rc != 0)
          return FALSE;

  }/* fin for ->(;;) */

  *iNumDirecciones = iNumDir;
  if (rc == 0 && iNumDir == MAX_DIRECCIONES)
  {
     iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Direcciones");
     return FALSE;
  }
  if (rc == SQLNOTFOUND && iNumDir >= 0 && iNumDir <= MAX_DIRECCIONES)
  {
      qsort (pDir,*iNumDirecciones,sizeof(DIRECCIONES),iCmpDirecciones);
      vPrintDirecciones (pDir,*iNumDirecciones);
  }
  return (iCloseDirecciones())?FALSE:TRUE;
}/******************** Final bCargaDirecciones *******************************/

/*****************************************************************************/
/*                       funcion : vPrintDirecciones                         */
/*****************************************************************************/
void vPrintDirecciones (DIRECCIONES* pDir,int iNumDirec)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla GE_DIRECCIONES ***\n",LOG06);

	  for (iInd=0;iInd<iNumDirec;iInd++)
	  {
	   vDTrazasLog (szExeName,"\n\t[%d]-Cod.Direccion....[%ld]"
	                          "\n\t[%d]-Cod.Region.......[%s]"
	                          "\n\t[%d]-CodProvincia.....[%s]"
	                          "\n\t[%d]-Cod.Ciudad.......[%s]"
	                          "\n\t[%d]-Cod.Comuna.......[%s]"
	                          "\n\t[%d]-Nom.Calle........[%s]"
	                          "\n\t[%d]-Num.Calle........[%s]"
	                          "\n\t[%d]-Num.Piso.........[%s]"
	                          "\n\t[%d]-Num.Casilla......[%s]"
	                          "\n\t[%d]-Obs.Direccion....[%s]"
	                          ,LOG06,iInd,pDir->lCodDireccion
	                          ,iInd,pDir->szCodRegion
	                          ,iInd,pDir->szCodProvincia
	                          ,iInd,pDir->szCodCiudad
	                          ,iInd,pDir->szCodComuna
	                          ,iInd,pDir->szNomCalle
	                          ,iInd,pDir->szNumCalle
	                          ,iInd,pDir->szNumPiso
	                          ,iInd,pDir->szNumCasilla
	                          ,iInd,pDir->szObsDireccion);

	   pDir++;
	  }
	}
}/********************** Final vPrintDirecciones *****************************/


/*****************************************************************************/
/*                       funcion : iOpenDirecCli                             */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iOpenDirecCli (void)
{
  /* EXEC SQL OPEN Cur_Direccli; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0005;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )695;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ga_Direccli",
               szfnORAerror());

  return SQLCODE;
}/******************** Final iOpenDirecCli ***********************************/

/*****************************************************************************/
/*                      funcion : iFetchDirecCli                             */
/* -Entrada DIRECCLI*                                                        */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iFetchDirecCli (DIRECCLI* pDir)
{

  /* EXEC SQL FETCH Cur_Direccli INTO :lhCodCliente     ,
                                   :ihCodTipDireccion,
                                   :lhCodDireccion   ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )710;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDireccion;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodDireccion;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
     iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ga_Direccli",
              szfnORAerror());

 if (SQLCODE == 0)
 {
     pDir->lCodCliente      = lhCodCliente     ;
     pDir->iCodTipDireccion = ihCodTipDireccion;
     pDir->lCodDireccion    = lhCodDireccion   ;

 }/* fin == 0 */

 return SQLCODE;
}/*********************** Final iFetchDirecCli *******************************/


/*****************************************************************************/
/*                        funcion : iCloseDirecCli                           */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iCloseDirecCli (void)
{
  /* EXEC SQL CLOSE Cur_Direccli; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )737;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ga_Direccli",
               szfnORAerror());

  return SQLCODE;
}/********************** Final iCloseDirecCli ********************************/


/*****************************************************************************/
/*                       funcion : iCmpDirecCli                              */
/* -Funcion de Comparacion                                                   */
/*****************************************************************************/
int iCmpDirecCli (const void* cad1, const void* cad2)
{
   int rc = 0;

   if ( ((DIRECCLI *)cad1)->lCodCliente < ((DIRECCLI *)cad2)->lCodCliente)
          rc = -1;
   if ( ((DIRECCLI *)cad1)->lCodCliente < ((DIRECCLI *)cad2)->lCodCliente)
          rc =  1;
   if ( ((DIRECCLI *)cad1)->lCodCliente < ((DIRECCLI *)cad2)->lCodCliente)
          rc =  0;

   return rc;
}/********************* Final iCmpDirecCli ***********************************/


/*****************************************************************************/
/*                     funcion : bCargaDirecCli                              */
/* -Funcion de Carga en memoria (DIRECCLI* pDireccli) y su numero de reg. de */
/*  la tabla GA_DIRECCLI.                                                    */
/* -Valores de Retorno : Error->FALSE, !Error->TRUE                          */
/*****************************************************************************/
BOOL bCargaDirecCli (DIRECCLI* pstDireccli, int* iNumDireccli)
{
  int rc = 0, iNumDir = 0          ;

  if (iOpenDirecCli ())
       return FALSE;

  for (iNumDir=0;iNumDir<MAX_DIRECCLI;iNumDir++)
  {
      rc = iFetchDirecCli (&pstDireccli[iNumDir]);
      if (rc == SQLNOTFOUND)
          break;
      if (rc != 0)
          return FALSE;

  }/* fin for->(;;) */

  *iNumDireccli = iNumDir;
  if (rc == 0 && iNumDir == MAX_DIRECCLI)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_DirecCli");
      return FALSE;
  }
  if (rc == SQLNOTFOUND && iNumDir >= 0 && iNumDir <= MAX_DIRECCLI)
  {
      qsort (pstDireccli,*iNumDireccli,sizeof(DIRECCLI),iCmpDirecCli);
      vPrintDirecCli (pstDireccli,*iNumDireccli);
  }
  return (iCloseDirecCli())?FALSE:TRUE;
}/********************* Final bCargaDirecCli *********************************/


/*****************************************************************************/
/*                       funcion : vPrintDirecCli                            */
/*****************************************************************************/
void vPrintDirecCli (DIRECCLI* pDir,int iNumDir)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla GE_DIRECCLI ***\n",LOG06);
	  for (iInd=0;iInd<iNumDir;iInd++)
	  {
	     vDTrazasLog (szExeName,"\n\t[%d]-Cod.Cliente..........[%ld]"
	                            "\n\t[%d]-Cod.Tip.Direccion....[%d]"
	                            "\n\t[%d]-Cod.Direccion........[%ld]"
	                            ,LOG06,iInd,pDir->lCodCliente
	                            ,iInd,pDir->iCodTipDireccion
	                            ,iInd,pDir->lCodDireccion   );

	     pDir++;
	  }
	}
}/*********************** Final vPrintDirecCli *******************************/


/*****************************************************************************/
/*                     funcion : iOpenCilcFact                               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static int iOpenCiclFact (void)
{
  /* EXEC SQL OPEN Cur_CiclFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0006;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )752;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_CiclFact",
               szfnORAerror());

  return SQLCODE;
}/*********************** Final iOpenCiclFact ********************************/


/*****************************************************************************/
/*                        funcion : iFetchCiclFact                           */
/* -Entrada CICLO* pCiclo                                                    */
/* -Valores Retorno: SQLCODE                                                 */
/*****************************************************************************/
static int iFetchCiclFact(CICLO* pCiclo)
{
   szhRowid          = pCiclo->szRowid          ;
   szhFecEmision     = pCiclo->szFecEmision     ;
   szhFecVencimie    = pCiclo->szFecVencimie    ;
   szhFecCaducida    = pCiclo->szFecCaducida    ;
   szhFecProxVenc    = pCiclo->szFecProxVenc    ;
   szhFecDesdeLlan   = pCiclo->szFecDesdeLlam   ;
   szhFecHastaLlam   = pCiclo->szFecHastaLlam   ;
   szhFecDesdeCFijos = pCiclo->szFecDesdeCFijos ;
   szhFecHastaCFijos = pCiclo->szFecHastaCFijos ;
   szhFecDesdeOCargos= pCiclo->szFecDesdeOCargos;
   szhFecHastaOCargos= pCiclo->szFecHastaOCargos;
   szhFecDesdeRoa    = pCiclo->szFecDesdeRoa    ;
   szhFecHastaRoa    = pCiclo->szFecHastaRoa    ;
   szhFecHMenos      = pCiclo->szFecHMenos      ;
   szhDirLogs        = pCiclo->szDirLogs        ;
   szhDirSpool       = pCiclo->szDirSpool       ;

   /* EXEC SQL FETCH Cur_CiclFact INTO :szhRowid                  ,
                                    :ihCodCiclo                ,
                                    :ihAno                     ,
                                    :lhCodCiclFact             ,
                                    :szhFecVencimie            ,
                                    :szhFecEmision             ,
                                    :szhFecCaducida            ,
                                    :szhFecProxVenc            ,
                                    :szhFecDesdeLlan           ,
                                    :szhFecHastaLlam           ,
                                    :szhFecDesdeCFijos         ,
                                    :szhFecHastaCFijos         ,
                                    :szhFecDesdeOCargos        ,
                                    :szhFecHastaOCargos        ,
                                    :szhFecDesdeRoa            ,
                                    :szhFecHastaRoa            ,
                                    :szhFecHMenos              ,
                                    :shIndFacturacion          ,
                                    :szhDirLogs                ,
                                    :szhDirSpool; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 20;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )767;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
   sqlstm.sqhstl[0] = (unsigned long )19;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCiclo;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihAno;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhFecVencimie;
   sqlstm.sqhstl[4] = (unsigned long )15;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[5] = (unsigned long )15;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhFecCaducida;
   sqlstm.sqhstl[6] = (unsigned long )15;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhFecProxVenc;
   sqlstm.sqhstl[7] = (unsigned long )15;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhFecDesdeLlan;
   sqlstm.sqhstl[8] = (unsigned long )15;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhFecHastaLlam;
   sqlstm.sqhstl[9] = (unsigned long )15;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhFecDesdeCFijos;
   sqlstm.sqhstl[10] = (unsigned long )15;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhFecHastaCFijos;
   sqlstm.sqhstl[11] = (unsigned long )15;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhFecDesdeOCargos;
   sqlstm.sqhstl[12] = (unsigned long )15;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhFecHastaOCargos;
   sqlstm.sqhstl[13] = (unsigned long )15;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhFecDesdeRoa;
   sqlstm.sqhstl[14] = (unsigned long )15;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhFecHastaRoa;
   sqlstm.sqhstl[15] = (unsigned long )15;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhFecHMenos;
   sqlstm.sqhstl[16] = (unsigned long )15;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)0;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)&shIndFacturacion;
   sqlstm.sqhstl[17] = (unsigned long )sizeof(short);
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)0;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)szhDirLogs;
   sqlstm.sqhstl[18] = (unsigned long )101;
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)0;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)szhDirSpool;
   sqlstm.sqhstl[19] = (unsigned long )101;
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)0;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_CiclFact",
                szfnORAerror());

   if (SQLCODE == 0)
   {
       pCiclo->iAno            = ihAno           ;
       pCiclo->iCodCiclo       = ihCodCiclo      ;
       pCiclo->lCodCiclFact    = lhCodCiclFact   ;
       pCiclo->iIndFacturacion = shIndFacturacion;
   }
   return SQLCODE;

}/************************ Final iFetchCiclFact ******************************/


/*****************************************************************************/
/*                         funcion : iCloseCiclFAct                          */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iCloseCiclFact (void)
{
  /* EXEC SQL CLOSE Cur_CiclFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )862;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_CiclFact",
               szfnORAerror());

  return SQLCODE;
}/************************ Final iCloseCiclFact ******************************/


/*****************************************************************************/
/*                         funcion : bCargaCiclFact                          */
/* -Funcion que carga en memoria (CICLO* pstCiclFact) la tabal FA_CICLFACT y */
/*  el numero de registros en NUM_CICLFACT.                                  */
/* -Entrada pstCiclFact, iNumCiclFact                                        */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
BOOL bCargaCiclFact (CICLO* pCiclo, int* iNumCiclFact)
{
   int rc = 0 , iNumCiclo = 0;

   if (iOpenCiclFact ())
        return FALSE;

   for (iNumCiclo=0;iNumCiclo<MAX_CICLFACT;iNumCiclo++)
   {
        rc = iFetchCiclFact (&pCiclo[iNumCiclo]);
        if (rc == SQLNOTFOUND)
            break;
        if (rc != 0)
            return FALSE;
   }/* fin for->(;;) */
   *iNumCiclFact = iNumCiclo;
   if (rc == 0 && iNumCiclo == MAX_CICLFACT)
   {
       iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_CiclFact");
       return FALSE;
   }
   if (rc == SQLNOTFOUND && iNumCiclo >= 0 && iNumCiclo <= MAX_CICLFACT)
   {
       qsort (pCiclo,iNumCiclo,sizeof(CICLO),iCmpCiclFact);
   }
   return (iCloseCiclFact())?FALSE:TRUE;

}/************************ Final bCargaCiclFact ******************************/



/*****************************************************************************/
/*                         funcion : iOpenCargos                             */
/*****************************************************************************/
static int iOpenCargos (int iTipoFactura,long lNumTransaccion,long lNumVenta)
{
	lhCodCiclFact = stCiclo.lCodCiclFact ;

    if (iTipoFactura == FACT_CICLO || iTipoFactura == FACT_BAJA )
    {
        vDTrazasLog (szExeName, "\n\t\t* Parametro de Entrada Open Cargos "
                                "\n\t\t* Codigo de Cliente [%ld]",
                                LOG05,stCliente.lCodCliente);

        lhCodCliente = stCliente.lCodCliente;
        /* EXEC SQL OPEN Cur_CargosCliente     ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 20;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0009;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )877;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else if (iTipoFactura == FACT_CONTADO)
    {
        vDTrazasLog (szExeName, "\n\t\t* Parametro de Entrada Open Cargos "
                                "\n\t\t* Num. Transaccion [%ld]"
                                "\n\t\t* Num. Venta       [%ld]",
                                LOG06,lNumTransaccion,lNumVenta);

        lhNumTransaccion = lNumTransaccion;
        if (lNumVenta == ORA_NULL)
            /* EXEC SQL OPEN Cur_CargosContado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 20;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = sq0007;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )896;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqcmod = (unsigned int )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumTransaccion;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
            sqlstm.sqphss = sqlstm.sqhsts;
            sqlstm.sqpind = sqlstm.sqindv;
            sqlstm.sqpins = sqlstm.sqinds;
            sqlstm.sqparm = sqlstm.sqharm;
            sqlstm.sqparc = sqlstm.sqharc;
            sqlstm.sqpadto = sqlstm.sqadto;
            sqlstm.sqptdso = sqlstm.sqtdso;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        else
        {
            lhNumVenta = lNumVenta;
            /* EXEC SQL OPEN Cur_CargosPVenta; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 20;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = sq0008;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )915;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqcmod = (unsigned int )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumTransaccion;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNumVenta;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
            sqlstm.sqphss = sqlstm.sqhsts;
            sqlstm.sqpind = sqlstm.sqindv;
            sqlstm.sqpins = sqlstm.sqinds;
            sqlstm.sqparm = sqlstm.sqharm;
            sqlstm.sqparc = sqlstm.sqharc;
            sqlstm.sqpadto = sqlstm.sqadto;
            sqlstm.sqptdso = sqlstm.sqtdso;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        }
    }

    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ga_Cargos",
                szfnORAerror());

    return SQLCODE;
}/************************ Final iOpenCargos *********************************/


/*****************************************************************************/
/*                         funcion : iFetchCargos                            */
/*****************************************************************************/
static int iFetchCargos (CARGOS *pCargo,int iTipoFactura)
{
  /* EXEC SQL BEGIN DECLARE SECTION ; */ 

  static long   lhNumCargo       ;
  static long   lhNumVenta       ;
  static char*  szhNumTerminal   ; /* EXEC SQL VAR szhNumTerminal  IS STRING(16); */ 

  static char*  szhFecAlta       ; /* EXEC SQL VAR szhFecAlta      IS STRING(15); */ 

  static double dhImpCargo       ;
  static long   lhCodPlanCom     ;
  static int    ihNumUnidades    ;
  static char*  szhNumSerie      ; /* EXEC SQL VAR szhNumSerie     IS STRING(26); */ 

  static char*  szhNumSerieMec   ; /* EXEC SQL VAR szhNumSerieMec  IS STRING(26); */ 

  static long   lhCapCode        ;
  static int    ihMesGarantia    ;
  static char*  szhNumPreGuia    ; /* EXEC SQL VAR szhNumPreGuia   IS STRING(11); */ 

  static char*  szhNumGuia       ; /* EXEC SQL VAR szhNumGuia      IS STRING(11); */ 

  static long   lhNumTransaccion ;
  static long   lhNumFactura     ;
  static int    ihCodConceptoDto ;
  static double dhValDto         ;
  static short  shTipDto         ;
  static short  shIndCuota       ;
  static short  shIndFactur      ;
  static int    ihNumPaquete     ;
  static short  shIndSuperTel    ;
  static short  i_shNumVenta     ;
  static short  i_shIndSuperTel  ;
  static short  i_shIndCuota     ;
  static short  i_shNumPaquete   ;
  static short  i_shNumAbonado   ;
  static short  i_shNumTerminal  ;
  static short  i_shCodCiclFact  ;
  static short  i_shNumSerie     ;
  static short  i_shNumSerieMec  ;
  static short  i_shCapCode      ;
  static short  i_shMesGarantia  ;
  static short  i_shNumPreGuia   ;
  static short  i_shNumGuia      ;
  static short  i_shNumTransaccion;
  static short  i_shNumFactura   ;
  static short  i_shCodConceptoDto;
  static short  i_shValDto       ;
  static short  i_shTipDto       ;
  /* EXEC SQL END DECLARE SECTION   ; */ 


  szhRowid        = pCargo->szRowid      ;
  szhFecAlta      = pCargo->szFecAlta    ;
  szhNumSerieMec  = pCargo->szNumSerieMec;
  szhNumSerie     = pCargo->szNumSerie   ;
  szhNumTerminal  = pCargo->szNumTerminal;
  szhCodMoneda    = pCargo->szCodMoneda  ;
  szhNumGuia      = pCargo->szNumGuia    ;
  szhNumPreGuia   = pCargo->szNumPreGuia ;

  if (iTipoFactura == FACT_CONTADO)
  {
      if (pCargo->lNumVenta == ORA_NULL)
      {
          /* EXEC SQL FETCH Cur_CargosContado INTO
                                 :szhRowid                           ,
                                 :lhNumCargo                         ,
                                 :lhCodCliente                       ,
                                 :shCodProducto                      ,
                                 :ihCodConcepto                      ,
                                 :szhFecAlta                         ,
                                 :dhImpCargo                         ,
                                 :szhCodMoneda                       ,
                                 :lhCodPlanCom                       ,
                                 :ihNumUnidades                      ,
                                 :lhNumAbonado:i_shNumAbonado        ,
                                 :szhNumTerminal:i_shNumTerminal     ,
                                 :lhCodCiclFact:i_shCodCiclFact      ,
                                 :szhNumSerie:i_shNumSerie           ,
                                 :szhNumSerieMec:i_shNumSerieMec     ,
                                 :lhCapCode:i_shCapCode              ,
                                 :ihMesGarantia:i_shMesGarantia      ,
                                 :szhNumPreGuia:i_shNumPreGuia       ,
                                 :szhNumGuia:i_shNumGuia             ,
                                 :lhNumTransaccion:i_shNumTransaccion,
                                 :lhNumVenta:i_shNumVenta            ,
                                 :lhNumFactura:i_shNumFactura        ,
                                 :ihCodConceptoDto:i_shCodConceptoDto,
                                 :dhValDto:i_shValDto                ,
                                 :shTipDto:i_shTipDto                ,
                                 :shIndCuota:i_shIndCuota            ,
                                 :ihNumPaquete:i_shNumPaquete        ,
                                 :shIndFactur                        ,
                                 :shIndSuperTel:i_shIndSuperTel      ; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 29;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )938;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqfoff = (         int )0;
          sqlstm.sqfmod = (unsigned int )2;
          sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
          sqlstm.sqhstl[0] = (unsigned long )19;
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCargo;
          sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
          sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[2] = (         int  )0;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)&shCodProducto;
          sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[3] = (         int  )0;
          sqlstm.sqindv[3] = (         short *)0;
          sqlstm.sqinds[3] = (         int  )0;
          sqlstm.sqharm[3] = (unsigned long )0;
          sqlstm.sqadto[3] = (unsigned short )0;
          sqlstm.sqtdso[3] = (unsigned short )0;
          sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
          sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[4] = (         int  )0;
          sqlstm.sqindv[4] = (         short *)0;
          sqlstm.sqinds[4] = (         int  )0;
          sqlstm.sqharm[4] = (unsigned long )0;
          sqlstm.sqadto[4] = (unsigned short )0;
          sqlstm.sqtdso[4] = (unsigned short )0;
          sqlstm.sqhstv[5] = (unsigned char  *)szhFecAlta;
          sqlstm.sqhstl[5] = (unsigned long )15;
          sqlstm.sqhsts[5] = (         int  )0;
          sqlstm.sqindv[5] = (         short *)0;
          sqlstm.sqinds[5] = (         int  )0;
          sqlstm.sqharm[5] = (unsigned long )0;
          sqlstm.sqadto[5] = (unsigned short )0;
          sqlstm.sqtdso[5] = (unsigned short )0;
          sqlstm.sqhstv[6] = (unsigned char  *)&dhImpCargo;
          sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[6] = (         int  )0;
          sqlstm.sqindv[6] = (         short *)0;
          sqlstm.sqinds[6] = (         int  )0;
          sqlstm.sqharm[6] = (unsigned long )0;
          sqlstm.sqadto[6] = (unsigned short )0;
          sqlstm.sqtdso[6] = (unsigned short )0;
          sqlstm.sqhstv[7] = (unsigned char  *)szhCodMoneda;
          sqlstm.sqhstl[7] = (unsigned long )4;
          sqlstm.sqhsts[7] = (         int  )0;
          sqlstm.sqindv[7] = (         short *)0;
          sqlstm.sqinds[7] = (         int  )0;
          sqlstm.sqharm[7] = (unsigned long )0;
          sqlstm.sqadto[7] = (unsigned short )0;
          sqlstm.sqtdso[7] = (unsigned short )0;
          sqlstm.sqhstv[8] = (unsigned char  *)&lhCodPlanCom;
          sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[8] = (         int  )0;
          sqlstm.sqindv[8] = (         short *)0;
          sqlstm.sqinds[8] = (         int  )0;
          sqlstm.sqharm[8] = (unsigned long )0;
          sqlstm.sqadto[8] = (unsigned short )0;
          sqlstm.sqtdso[8] = (unsigned short )0;
          sqlstm.sqhstv[9] = (unsigned char  *)&ihNumUnidades;
          sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[9] = (         int  )0;
          sqlstm.sqindv[9] = (         short *)0;
          sqlstm.sqinds[9] = (         int  )0;
          sqlstm.sqharm[9] = (unsigned long )0;
          sqlstm.sqadto[9] = (unsigned short )0;
          sqlstm.sqtdso[9] = (unsigned short )0;
          sqlstm.sqhstv[10] = (unsigned char  *)&lhNumAbonado;
          sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[10] = (         int  )0;
          sqlstm.sqindv[10] = (         short *)&i_shNumAbonado;
          sqlstm.sqinds[10] = (         int  )0;
          sqlstm.sqharm[10] = (unsigned long )0;
          sqlstm.sqadto[10] = (unsigned short )0;
          sqlstm.sqtdso[10] = (unsigned short )0;
          sqlstm.sqhstv[11] = (unsigned char  *)szhNumTerminal;
          sqlstm.sqhstl[11] = (unsigned long )16;
          sqlstm.sqhsts[11] = (         int  )0;
          sqlstm.sqindv[11] = (         short *)&i_shNumTerminal;
          sqlstm.sqinds[11] = (         int  )0;
          sqlstm.sqharm[11] = (unsigned long )0;
          sqlstm.sqadto[11] = (unsigned short )0;
          sqlstm.sqtdso[11] = (unsigned short )0;
          sqlstm.sqhstv[12] = (unsigned char  *)&lhCodCiclFact;
          sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[12] = (         int  )0;
          sqlstm.sqindv[12] = (         short *)&i_shCodCiclFact;
          sqlstm.sqinds[12] = (         int  )0;
          sqlstm.sqharm[12] = (unsigned long )0;
          sqlstm.sqadto[12] = (unsigned short )0;
          sqlstm.sqtdso[12] = (unsigned short )0;
          sqlstm.sqhstv[13] = (unsigned char  *)szhNumSerie;
          sqlstm.sqhstl[13] = (unsigned long )26;
          sqlstm.sqhsts[13] = (         int  )0;
          sqlstm.sqindv[13] = (         short *)&i_shNumSerie;
          sqlstm.sqinds[13] = (         int  )0;
          sqlstm.sqharm[13] = (unsigned long )0;
          sqlstm.sqadto[13] = (unsigned short )0;
          sqlstm.sqtdso[13] = (unsigned short )0;
          sqlstm.sqhstv[14] = (unsigned char  *)szhNumSerieMec;
          sqlstm.sqhstl[14] = (unsigned long )26;
          sqlstm.sqhsts[14] = (         int  )0;
          sqlstm.sqindv[14] = (         short *)&i_shNumSerieMec;
          sqlstm.sqinds[14] = (         int  )0;
          sqlstm.sqharm[14] = (unsigned long )0;
          sqlstm.sqadto[14] = (unsigned short )0;
          sqlstm.sqtdso[14] = (unsigned short )0;
          sqlstm.sqhstv[15] = (unsigned char  *)&lhCapCode;
          sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[15] = (         int  )0;
          sqlstm.sqindv[15] = (         short *)&i_shCapCode;
          sqlstm.sqinds[15] = (         int  )0;
          sqlstm.sqharm[15] = (unsigned long )0;
          sqlstm.sqadto[15] = (unsigned short )0;
          sqlstm.sqtdso[15] = (unsigned short )0;
          sqlstm.sqhstv[16] = (unsigned char  *)&ihMesGarantia;
          sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[16] = (         int  )0;
          sqlstm.sqindv[16] = (         short *)&i_shMesGarantia;
          sqlstm.sqinds[16] = (         int  )0;
          sqlstm.sqharm[16] = (unsigned long )0;
          sqlstm.sqadto[16] = (unsigned short )0;
          sqlstm.sqtdso[16] = (unsigned short )0;
          sqlstm.sqhstv[17] = (unsigned char  *)szhNumPreGuia;
          sqlstm.sqhstl[17] = (unsigned long )11;
          sqlstm.sqhsts[17] = (         int  )0;
          sqlstm.sqindv[17] = (         short *)&i_shNumPreGuia;
          sqlstm.sqinds[17] = (         int  )0;
          sqlstm.sqharm[17] = (unsigned long )0;
          sqlstm.sqadto[17] = (unsigned short )0;
          sqlstm.sqtdso[17] = (unsigned short )0;
          sqlstm.sqhstv[18] = (unsigned char  *)szhNumGuia;
          sqlstm.sqhstl[18] = (unsigned long )11;
          sqlstm.sqhsts[18] = (         int  )0;
          sqlstm.sqindv[18] = (         short *)&i_shNumGuia;
          sqlstm.sqinds[18] = (         int  )0;
          sqlstm.sqharm[18] = (unsigned long )0;
          sqlstm.sqadto[18] = (unsigned short )0;
          sqlstm.sqtdso[18] = (unsigned short )0;
          sqlstm.sqhstv[19] = (unsigned char  *)&lhNumTransaccion;
          sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[19] = (         int  )0;
          sqlstm.sqindv[19] = (         short *)&i_shNumTransaccion;
          sqlstm.sqinds[19] = (         int  )0;
          sqlstm.sqharm[19] = (unsigned long )0;
          sqlstm.sqadto[19] = (unsigned short )0;
          sqlstm.sqtdso[19] = (unsigned short )0;
          sqlstm.sqhstv[20] = (unsigned char  *)&lhNumVenta;
          sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[20] = (         int  )0;
          sqlstm.sqindv[20] = (         short *)&i_shNumVenta;
          sqlstm.sqinds[20] = (         int  )0;
          sqlstm.sqharm[20] = (unsigned long )0;
          sqlstm.sqadto[20] = (unsigned short )0;
          sqlstm.sqtdso[20] = (unsigned short )0;
          sqlstm.sqhstv[21] = (unsigned char  *)&lhNumFactura;
          sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[21] = (         int  )0;
          sqlstm.sqindv[21] = (         short *)&i_shNumFactura;
          sqlstm.sqinds[21] = (         int  )0;
          sqlstm.sqharm[21] = (unsigned long )0;
          sqlstm.sqadto[21] = (unsigned short )0;
          sqlstm.sqtdso[21] = (unsigned short )0;
          sqlstm.sqhstv[22] = (unsigned char  *)&ihCodConceptoDto;
          sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[22] = (         int  )0;
          sqlstm.sqindv[22] = (         short *)&i_shCodConceptoDto;
          sqlstm.sqinds[22] = (         int  )0;
          sqlstm.sqharm[22] = (unsigned long )0;
          sqlstm.sqadto[22] = (unsigned short )0;
          sqlstm.sqtdso[22] = (unsigned short )0;
          sqlstm.sqhstv[23] = (unsigned char  *)&dhValDto;
          sqlstm.sqhstl[23] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[23] = (         int  )0;
          sqlstm.sqindv[23] = (         short *)&i_shValDto;
          sqlstm.sqinds[23] = (         int  )0;
          sqlstm.sqharm[23] = (unsigned long )0;
          sqlstm.sqadto[23] = (unsigned short )0;
          sqlstm.sqtdso[23] = (unsigned short )0;
          sqlstm.sqhstv[24] = (unsigned char  *)&shTipDto;
          sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[24] = (         int  )0;
          sqlstm.sqindv[24] = (         short *)&i_shTipDto;
          sqlstm.sqinds[24] = (         int  )0;
          sqlstm.sqharm[24] = (unsigned long )0;
          sqlstm.sqadto[24] = (unsigned short )0;
          sqlstm.sqtdso[24] = (unsigned short )0;
          sqlstm.sqhstv[25] = (unsigned char  *)&shIndCuota;
          sqlstm.sqhstl[25] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[25] = (         int  )0;
          sqlstm.sqindv[25] = (         short *)&i_shIndCuota;
          sqlstm.sqinds[25] = (         int  )0;
          sqlstm.sqharm[25] = (unsigned long )0;
          sqlstm.sqadto[25] = (unsigned short )0;
          sqlstm.sqtdso[25] = (unsigned short )0;
          sqlstm.sqhstv[26] = (unsigned char  *)&ihNumPaquete;
          sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[26] = (         int  )0;
          sqlstm.sqindv[26] = (         short *)&i_shNumPaquete;
          sqlstm.sqinds[26] = (         int  )0;
          sqlstm.sqharm[26] = (unsigned long )0;
          sqlstm.sqadto[26] = (unsigned short )0;
          sqlstm.sqtdso[26] = (unsigned short )0;
          sqlstm.sqhstv[27] = (unsigned char  *)&shIndFactur;
          sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[27] = (         int  )0;
          sqlstm.sqindv[27] = (         short *)0;
          sqlstm.sqinds[27] = (         int  )0;
          sqlstm.sqharm[27] = (unsigned long )0;
          sqlstm.sqadto[27] = (unsigned short )0;
          sqlstm.sqtdso[27] = (unsigned short )0;
          sqlstm.sqhstv[28] = (unsigned char  *)&shIndSuperTel;
          sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[28] = (         int  )0;
          sqlstm.sqindv[28] = (         short *)&i_shIndSuperTel;
          sqlstm.sqinds[28] = (         int  )0;
          sqlstm.sqharm[28] = (unsigned long )0;
          sqlstm.sqadto[28] = (unsigned short )0;
          sqlstm.sqtdso[28] = (unsigned short )0;
          sqlstm.sqphsv = sqlstm.sqhstv;
          sqlstm.sqphsl = sqlstm.sqhstl;
          sqlstm.sqphss = sqlstm.sqhsts;
          sqlstm.sqpind = sqlstm.sqindv;
          sqlstm.sqpins = sqlstm.sqinds;
          sqlstm.sqparm = sqlstm.sqharm;
          sqlstm.sqparc = sqlstm.sqharc;
          sqlstm.sqpadto = sqlstm.sqadto;
          sqlstm.sqptdso = sqlstm.sqtdso;
          sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


     }/* fin if lNumVenta ... */
     else
     {
          /* EXEC SQL FETCH Cur_CargosPVenta INTO
                                 :szhRowid                           ,
                                 :lhNumCargo                         ,
                                 :lhCodCliente                       ,
                                 :shCodProducto                      ,
                                 :ihCodConcepto                      ,
                                 :szhFecAlta                         ,
                                 :dhImpCargo                         ,
                                 :szhCodMoneda                       ,
                                 :lhCodPlanCom                       ,
                                 :ihNumUnidades                      ,
                                 :lhNumAbonado:i_shNumAbonado        ,
                                 :szhNumTerminal:i_shNumTerminal     ,
                                 :lhCodCiclFact:i_shCodCiclFact      ,
                                 :szhNumSerie:i_shNumSerie           ,
                                 :szhNumSerieMec:i_shNumSerieMec     ,
                                 :lhCapCode:i_shCapCode              ,
                                 :ihMesGarantia:i_shMesGarantia      ,
                                 :szhNumPreGuia:i_shNumPreGuia       ,
                                 :szhNumGuia:i_shNumGuia             ,
                                 :lhNumTransaccion:i_shNumTransaccion,
                                 :lhNumVenta:i_shNumVenta            ,
                                 :lhNumFactura:i_shNumFactura        ,
                                 :ihCodConceptoDto:i_shCodConceptoDto,
                                 :dhValDto:i_shValDto                ,
                                 :shTipDto:i_shTipDto                ,
                                 :shIndCuota:i_shIndCuota            ,
                                 :ihNumPaquete:i_shNumPaquete        ,
                                 :shIndFactur                        ,
                                 :shIndSuperTel:i_shIndSuperTel      ; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 29;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1069;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqfoff = (         int )0;
          sqlstm.sqfmod = (unsigned int )2;
          sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
          sqlstm.sqhstl[0] = (unsigned long )19;
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCargo;
          sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
          sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[2] = (         int  )0;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)&shCodProducto;
          sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[3] = (         int  )0;
          sqlstm.sqindv[3] = (         short *)0;
          sqlstm.sqinds[3] = (         int  )0;
          sqlstm.sqharm[3] = (unsigned long )0;
          sqlstm.sqadto[3] = (unsigned short )0;
          sqlstm.sqtdso[3] = (unsigned short )0;
          sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
          sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[4] = (         int  )0;
          sqlstm.sqindv[4] = (         short *)0;
          sqlstm.sqinds[4] = (         int  )0;
          sqlstm.sqharm[4] = (unsigned long )0;
          sqlstm.sqadto[4] = (unsigned short )0;
          sqlstm.sqtdso[4] = (unsigned short )0;
          sqlstm.sqhstv[5] = (unsigned char  *)szhFecAlta;
          sqlstm.sqhstl[5] = (unsigned long )15;
          sqlstm.sqhsts[5] = (         int  )0;
          sqlstm.sqindv[5] = (         short *)0;
          sqlstm.sqinds[5] = (         int  )0;
          sqlstm.sqharm[5] = (unsigned long )0;
          sqlstm.sqadto[5] = (unsigned short )0;
          sqlstm.sqtdso[5] = (unsigned short )0;
          sqlstm.sqhstv[6] = (unsigned char  *)&dhImpCargo;
          sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[6] = (         int  )0;
          sqlstm.sqindv[6] = (         short *)0;
          sqlstm.sqinds[6] = (         int  )0;
          sqlstm.sqharm[6] = (unsigned long )0;
          sqlstm.sqadto[6] = (unsigned short )0;
          sqlstm.sqtdso[6] = (unsigned short )0;
          sqlstm.sqhstv[7] = (unsigned char  *)szhCodMoneda;
          sqlstm.sqhstl[7] = (unsigned long )4;
          sqlstm.sqhsts[7] = (         int  )0;
          sqlstm.sqindv[7] = (         short *)0;
          sqlstm.sqinds[7] = (         int  )0;
          sqlstm.sqharm[7] = (unsigned long )0;
          sqlstm.sqadto[7] = (unsigned short )0;
          sqlstm.sqtdso[7] = (unsigned short )0;
          sqlstm.sqhstv[8] = (unsigned char  *)&lhCodPlanCom;
          sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[8] = (         int  )0;
          sqlstm.sqindv[8] = (         short *)0;
          sqlstm.sqinds[8] = (         int  )0;
          sqlstm.sqharm[8] = (unsigned long )0;
          sqlstm.sqadto[8] = (unsigned short )0;
          sqlstm.sqtdso[8] = (unsigned short )0;
          sqlstm.sqhstv[9] = (unsigned char  *)&ihNumUnidades;
          sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[9] = (         int  )0;
          sqlstm.sqindv[9] = (         short *)0;
          sqlstm.sqinds[9] = (         int  )0;
          sqlstm.sqharm[9] = (unsigned long )0;
          sqlstm.sqadto[9] = (unsigned short )0;
          sqlstm.sqtdso[9] = (unsigned short )0;
          sqlstm.sqhstv[10] = (unsigned char  *)&lhNumAbonado;
          sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[10] = (         int  )0;
          sqlstm.sqindv[10] = (         short *)&i_shNumAbonado;
          sqlstm.sqinds[10] = (         int  )0;
          sqlstm.sqharm[10] = (unsigned long )0;
          sqlstm.sqadto[10] = (unsigned short )0;
          sqlstm.sqtdso[10] = (unsigned short )0;
          sqlstm.sqhstv[11] = (unsigned char  *)szhNumTerminal;
          sqlstm.sqhstl[11] = (unsigned long )16;
          sqlstm.sqhsts[11] = (         int  )0;
          sqlstm.sqindv[11] = (         short *)&i_shNumTerminal;
          sqlstm.sqinds[11] = (         int  )0;
          sqlstm.sqharm[11] = (unsigned long )0;
          sqlstm.sqadto[11] = (unsigned short )0;
          sqlstm.sqtdso[11] = (unsigned short )0;
          sqlstm.sqhstv[12] = (unsigned char  *)&lhCodCiclFact;
          sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[12] = (         int  )0;
          sqlstm.sqindv[12] = (         short *)&i_shCodCiclFact;
          sqlstm.sqinds[12] = (         int  )0;
          sqlstm.sqharm[12] = (unsigned long )0;
          sqlstm.sqadto[12] = (unsigned short )0;
          sqlstm.sqtdso[12] = (unsigned short )0;
          sqlstm.sqhstv[13] = (unsigned char  *)szhNumSerie;
          sqlstm.sqhstl[13] = (unsigned long )26;
          sqlstm.sqhsts[13] = (         int  )0;
          sqlstm.sqindv[13] = (         short *)&i_shNumSerie;
          sqlstm.sqinds[13] = (         int  )0;
          sqlstm.sqharm[13] = (unsigned long )0;
          sqlstm.sqadto[13] = (unsigned short )0;
          sqlstm.sqtdso[13] = (unsigned short )0;
          sqlstm.sqhstv[14] = (unsigned char  *)szhNumSerieMec;
          sqlstm.sqhstl[14] = (unsigned long )26;
          sqlstm.sqhsts[14] = (         int  )0;
          sqlstm.sqindv[14] = (         short *)&i_shNumSerieMec;
          sqlstm.sqinds[14] = (         int  )0;
          sqlstm.sqharm[14] = (unsigned long )0;
          sqlstm.sqadto[14] = (unsigned short )0;
          sqlstm.sqtdso[14] = (unsigned short )0;
          sqlstm.sqhstv[15] = (unsigned char  *)&lhCapCode;
          sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[15] = (         int  )0;
          sqlstm.sqindv[15] = (         short *)&i_shCapCode;
          sqlstm.sqinds[15] = (         int  )0;
          sqlstm.sqharm[15] = (unsigned long )0;
          sqlstm.sqadto[15] = (unsigned short )0;
          sqlstm.sqtdso[15] = (unsigned short )0;
          sqlstm.sqhstv[16] = (unsigned char  *)&ihMesGarantia;
          sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[16] = (         int  )0;
          sqlstm.sqindv[16] = (         short *)&i_shMesGarantia;
          sqlstm.sqinds[16] = (         int  )0;
          sqlstm.sqharm[16] = (unsigned long )0;
          sqlstm.sqadto[16] = (unsigned short )0;
          sqlstm.sqtdso[16] = (unsigned short )0;
          sqlstm.sqhstv[17] = (unsigned char  *)szhNumPreGuia;
          sqlstm.sqhstl[17] = (unsigned long )11;
          sqlstm.sqhsts[17] = (         int  )0;
          sqlstm.sqindv[17] = (         short *)&i_shNumPreGuia;
          sqlstm.sqinds[17] = (         int  )0;
          sqlstm.sqharm[17] = (unsigned long )0;
          sqlstm.sqadto[17] = (unsigned short )0;
          sqlstm.sqtdso[17] = (unsigned short )0;
          sqlstm.sqhstv[18] = (unsigned char  *)szhNumGuia;
          sqlstm.sqhstl[18] = (unsigned long )11;
          sqlstm.sqhsts[18] = (         int  )0;
          sqlstm.sqindv[18] = (         short *)&i_shNumGuia;
          sqlstm.sqinds[18] = (         int  )0;
          sqlstm.sqharm[18] = (unsigned long )0;
          sqlstm.sqadto[18] = (unsigned short )0;
          sqlstm.sqtdso[18] = (unsigned short )0;
          sqlstm.sqhstv[19] = (unsigned char  *)&lhNumTransaccion;
          sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[19] = (         int  )0;
          sqlstm.sqindv[19] = (         short *)&i_shNumTransaccion;
          sqlstm.sqinds[19] = (         int  )0;
          sqlstm.sqharm[19] = (unsigned long )0;
          sqlstm.sqadto[19] = (unsigned short )0;
          sqlstm.sqtdso[19] = (unsigned short )0;
          sqlstm.sqhstv[20] = (unsigned char  *)&lhNumVenta;
          sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[20] = (         int  )0;
          sqlstm.sqindv[20] = (         short *)&i_shNumVenta;
          sqlstm.sqinds[20] = (         int  )0;
          sqlstm.sqharm[20] = (unsigned long )0;
          sqlstm.sqadto[20] = (unsigned short )0;
          sqlstm.sqtdso[20] = (unsigned short )0;
          sqlstm.sqhstv[21] = (unsigned char  *)&lhNumFactura;
          sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[21] = (         int  )0;
          sqlstm.sqindv[21] = (         short *)&i_shNumFactura;
          sqlstm.sqinds[21] = (         int  )0;
          sqlstm.sqharm[21] = (unsigned long )0;
          sqlstm.sqadto[21] = (unsigned short )0;
          sqlstm.sqtdso[21] = (unsigned short )0;
          sqlstm.sqhstv[22] = (unsigned char  *)&ihCodConceptoDto;
          sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[22] = (         int  )0;
          sqlstm.sqindv[22] = (         short *)&i_shCodConceptoDto;
          sqlstm.sqinds[22] = (         int  )0;
          sqlstm.sqharm[22] = (unsigned long )0;
          sqlstm.sqadto[22] = (unsigned short )0;
          sqlstm.sqtdso[22] = (unsigned short )0;
          sqlstm.sqhstv[23] = (unsigned char  *)&dhValDto;
          sqlstm.sqhstl[23] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[23] = (         int  )0;
          sqlstm.sqindv[23] = (         short *)&i_shValDto;
          sqlstm.sqinds[23] = (         int  )0;
          sqlstm.sqharm[23] = (unsigned long )0;
          sqlstm.sqadto[23] = (unsigned short )0;
          sqlstm.sqtdso[23] = (unsigned short )0;
          sqlstm.sqhstv[24] = (unsigned char  *)&shTipDto;
          sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[24] = (         int  )0;
          sqlstm.sqindv[24] = (         short *)&i_shTipDto;
          sqlstm.sqinds[24] = (         int  )0;
          sqlstm.sqharm[24] = (unsigned long )0;
          sqlstm.sqadto[24] = (unsigned short )0;
          sqlstm.sqtdso[24] = (unsigned short )0;
          sqlstm.sqhstv[25] = (unsigned char  *)&shIndCuota;
          sqlstm.sqhstl[25] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[25] = (         int  )0;
          sqlstm.sqindv[25] = (         short *)&i_shIndCuota;
          sqlstm.sqinds[25] = (         int  )0;
          sqlstm.sqharm[25] = (unsigned long )0;
          sqlstm.sqadto[25] = (unsigned short )0;
          sqlstm.sqtdso[25] = (unsigned short )0;
          sqlstm.sqhstv[26] = (unsigned char  *)&ihNumPaquete;
          sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[26] = (         int  )0;
          sqlstm.sqindv[26] = (         short *)&i_shNumPaquete;
          sqlstm.sqinds[26] = (         int  )0;
          sqlstm.sqharm[26] = (unsigned long )0;
          sqlstm.sqadto[26] = (unsigned short )0;
          sqlstm.sqtdso[26] = (unsigned short )0;
          sqlstm.sqhstv[27] = (unsigned char  *)&shIndFactur;
          sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[27] = (         int  )0;
          sqlstm.sqindv[27] = (         short *)0;
          sqlstm.sqinds[27] = (         int  )0;
          sqlstm.sqharm[27] = (unsigned long )0;
          sqlstm.sqadto[27] = (unsigned short )0;
          sqlstm.sqtdso[27] = (unsigned short )0;
          sqlstm.sqhstv[28] = (unsigned char  *)&shIndSuperTel;
          sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[28] = (         int  )0;
          sqlstm.sqindv[28] = (         short *)&i_shIndSuperTel;
          sqlstm.sqinds[28] = (         int  )0;
          sqlstm.sqharm[28] = (unsigned long )0;
          sqlstm.sqadto[28] = (unsigned short )0;
          sqlstm.sqtdso[28] = (unsigned short )0;
          sqlstm.sqphsv = sqlstm.sqhstv;
          sqlstm.sqphsl = sqlstm.sqhstl;
          sqlstm.sqphss = sqlstm.sqhsts;
          sqlstm.sqpind = sqlstm.sqindv;
          sqlstm.sqpins = sqlstm.sqinds;
          sqlstm.sqparm = sqlstm.sqharm;
          sqlstm.sqparc = sqlstm.sqharc;
          sqlstm.sqpadto = sqlstm.sqadto;
          sqlstm.sqptdso = sqlstm.sqtdso;
          sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


     }
  }/* fin if CONTADO ... */
  if (iTipoFactura == FACT_BAJA || iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL FETCH Cur_CargosCliente INTO
                                 :szhRowid                           ,
                                 :lhNumCargo                         ,
                                 :lhCodCliente                       ,
                                 :shCodProducto                      ,
                                 :ihCodConcepto                      ,
                                 :szhFecAlta                         ,
                                 :dhImpCargo                         ,
                                 :szhCodMoneda                       ,
                                 :lhCodPlanCom                       ,
                                 :ihNumUnidades                      ,
                                 :lhNumAbonado:i_shNumAbonado        ,
                                 :szhNumTerminal:i_shNumTerminal     ,
                                 :lhCodCiclFact:i_shCodCiclFact      ,
                                 :szhNumSerie:i_shNumSerie           ,
                                 :szhNumSerieMec:i_shNumSerieMec     ,
                                 :lhCapCode:i_shCapCode              ,
                                 :ihMesGarantia:i_shMesGarantia      ,
                                 :szhNumPreGuia:i_shNumPreGuia       ,
                                 :szhNumGuia:i_shNumGuia             ,
                                 :lhNumTransaccion:i_shNumTransaccion,
                                 :lhNumVenta:i_shNumVenta            ,
                                 :lhNumFactura:i_shNumFactura        ,
                                 :ihCodConceptoDto:i_shCodConceptoDto,
                                 :dhValDto:i_shValDto                ,
                                 :shTipDto:i_shTipDto                ,
                                 :shIndCuota:i_shIndCuota            ,
                                 :ihNumPaquete:i_shNumPaquete        ,
                                 :shIndFactur                        ,
                                 :shIndSuperTel:i_shIndSuperTel      ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1200;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCargo;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&shCodProducto;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhFecAlta;
      sqlstm.sqhstl[5] = (unsigned long )15;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&dhImpCargo;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)szhCodMoneda;
      sqlstm.sqhstl[7] = (unsigned long )4;
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&ihNumUnidades;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&lhNumAbonado;
      sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)&i_shNumAbonado;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)szhNumTerminal;
      sqlstm.sqhstl[11] = (unsigned long )16;
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)&i_shNumTerminal;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)&lhCodCiclFact;
      sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[12] = (         int  )0;
      sqlstm.sqindv[12] = (         short *)&i_shCodCiclFact;
      sqlstm.sqinds[12] = (         int  )0;
      sqlstm.sqharm[12] = (unsigned long )0;
      sqlstm.sqadto[12] = (unsigned short )0;
      sqlstm.sqtdso[12] = (unsigned short )0;
      sqlstm.sqhstv[13] = (unsigned char  *)szhNumSerie;
      sqlstm.sqhstl[13] = (unsigned long )26;
      sqlstm.sqhsts[13] = (         int  )0;
      sqlstm.sqindv[13] = (         short *)&i_shNumSerie;
      sqlstm.sqinds[13] = (         int  )0;
      sqlstm.sqharm[13] = (unsigned long )0;
      sqlstm.sqadto[13] = (unsigned short )0;
      sqlstm.sqtdso[13] = (unsigned short )0;
      sqlstm.sqhstv[14] = (unsigned char  *)szhNumSerieMec;
      sqlstm.sqhstl[14] = (unsigned long )26;
      sqlstm.sqhsts[14] = (         int  )0;
      sqlstm.sqindv[14] = (         short *)&i_shNumSerieMec;
      sqlstm.sqinds[14] = (         int  )0;
      sqlstm.sqharm[14] = (unsigned long )0;
      sqlstm.sqadto[14] = (unsigned short )0;
      sqlstm.sqtdso[14] = (unsigned short )0;
      sqlstm.sqhstv[15] = (unsigned char  *)&lhCapCode;
      sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[15] = (         int  )0;
      sqlstm.sqindv[15] = (         short *)&i_shCapCode;
      sqlstm.sqinds[15] = (         int  )0;
      sqlstm.sqharm[15] = (unsigned long )0;
      sqlstm.sqadto[15] = (unsigned short )0;
      sqlstm.sqtdso[15] = (unsigned short )0;
      sqlstm.sqhstv[16] = (unsigned char  *)&ihMesGarantia;
      sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[16] = (         int  )0;
      sqlstm.sqindv[16] = (         short *)&i_shMesGarantia;
      sqlstm.sqinds[16] = (         int  )0;
      sqlstm.sqharm[16] = (unsigned long )0;
      sqlstm.sqadto[16] = (unsigned short )0;
      sqlstm.sqtdso[16] = (unsigned short )0;
      sqlstm.sqhstv[17] = (unsigned char  *)szhNumPreGuia;
      sqlstm.sqhstl[17] = (unsigned long )11;
      sqlstm.sqhsts[17] = (         int  )0;
      sqlstm.sqindv[17] = (         short *)&i_shNumPreGuia;
      sqlstm.sqinds[17] = (         int  )0;
      sqlstm.sqharm[17] = (unsigned long )0;
      sqlstm.sqadto[17] = (unsigned short )0;
      sqlstm.sqtdso[17] = (unsigned short )0;
      sqlstm.sqhstv[18] = (unsigned char  *)szhNumGuia;
      sqlstm.sqhstl[18] = (unsigned long )11;
      sqlstm.sqhsts[18] = (         int  )0;
      sqlstm.sqindv[18] = (         short *)&i_shNumGuia;
      sqlstm.sqinds[18] = (         int  )0;
      sqlstm.sqharm[18] = (unsigned long )0;
      sqlstm.sqadto[18] = (unsigned short )0;
      sqlstm.sqtdso[18] = (unsigned short )0;
      sqlstm.sqhstv[19] = (unsigned char  *)&lhNumTransaccion;
      sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[19] = (         int  )0;
      sqlstm.sqindv[19] = (         short *)&i_shNumTransaccion;
      sqlstm.sqinds[19] = (         int  )0;
      sqlstm.sqharm[19] = (unsigned long )0;
      sqlstm.sqadto[19] = (unsigned short )0;
      sqlstm.sqtdso[19] = (unsigned short )0;
      sqlstm.sqhstv[20] = (unsigned char  *)&lhNumVenta;
      sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[20] = (         int  )0;
      sqlstm.sqindv[20] = (         short *)&i_shNumVenta;
      sqlstm.sqinds[20] = (         int  )0;
      sqlstm.sqharm[20] = (unsigned long )0;
      sqlstm.sqadto[20] = (unsigned short )0;
      sqlstm.sqtdso[20] = (unsigned short )0;
      sqlstm.sqhstv[21] = (unsigned char  *)&lhNumFactura;
      sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[21] = (         int  )0;
      sqlstm.sqindv[21] = (         short *)&i_shNumFactura;
      sqlstm.sqinds[21] = (         int  )0;
      sqlstm.sqharm[21] = (unsigned long )0;
      sqlstm.sqadto[21] = (unsigned short )0;
      sqlstm.sqtdso[21] = (unsigned short )0;
      sqlstm.sqhstv[22] = (unsigned char  *)&ihCodConceptoDto;
      sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[22] = (         int  )0;
      sqlstm.sqindv[22] = (         short *)&i_shCodConceptoDto;
      sqlstm.sqinds[22] = (         int  )0;
      sqlstm.sqharm[22] = (unsigned long )0;
      sqlstm.sqadto[22] = (unsigned short )0;
      sqlstm.sqtdso[22] = (unsigned short )0;
      sqlstm.sqhstv[23] = (unsigned char  *)&dhValDto;
      sqlstm.sqhstl[23] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[23] = (         int  )0;
      sqlstm.sqindv[23] = (         short *)&i_shValDto;
      sqlstm.sqinds[23] = (         int  )0;
      sqlstm.sqharm[23] = (unsigned long )0;
      sqlstm.sqadto[23] = (unsigned short )0;
      sqlstm.sqtdso[23] = (unsigned short )0;
      sqlstm.sqhstv[24] = (unsigned char  *)&shTipDto;
      sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[24] = (         int  )0;
      sqlstm.sqindv[24] = (         short *)&i_shTipDto;
      sqlstm.sqinds[24] = (         int  )0;
      sqlstm.sqharm[24] = (unsigned long )0;
      sqlstm.sqadto[24] = (unsigned short )0;
      sqlstm.sqtdso[24] = (unsigned short )0;
      sqlstm.sqhstv[25] = (unsigned char  *)&shIndCuota;
      sqlstm.sqhstl[25] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[25] = (         int  )0;
      sqlstm.sqindv[25] = (         short *)&i_shIndCuota;
      sqlstm.sqinds[25] = (         int  )0;
      sqlstm.sqharm[25] = (unsigned long )0;
      sqlstm.sqadto[25] = (unsigned short )0;
      sqlstm.sqtdso[25] = (unsigned short )0;
      sqlstm.sqhstv[26] = (unsigned char  *)&ihNumPaquete;
      sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[26] = (         int  )0;
      sqlstm.sqindv[26] = (         short *)&i_shNumPaquete;
      sqlstm.sqinds[26] = (         int  )0;
      sqlstm.sqharm[26] = (unsigned long )0;
      sqlstm.sqadto[26] = (unsigned short )0;
      sqlstm.sqtdso[26] = (unsigned short )0;
      sqlstm.sqhstv[27] = (unsigned char  *)&shIndFactur;
      sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[27] = (         int  )0;
      sqlstm.sqindv[27] = (         short *)0;
      sqlstm.sqinds[27] = (         int  )0;
      sqlstm.sqharm[27] = (unsigned long )0;
      sqlstm.sqadto[27] = (unsigned short )0;
      sqlstm.sqtdso[27] = (unsigned short )0;
      sqlstm.sqhstv[28] = (unsigned char  *)&shIndSuperTel;
      sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[28] = (         int  )0;
      sqlstm.sqindv[28] = (         short *)&i_shIndSuperTel;
      sqlstm.sqinds[28] = (         int  )0;
      sqlstm.sqharm[28] = (unsigned long )0;
      sqlstm.sqadto[28] = (unsigned short )0;
      sqlstm.sqtdso[28] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }

  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ga_Cargos",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pCargo->lNumCargo    = lhNumCargo   ;
      pCargo->lCodCliente  = lhCodCliente ;
      pCargo->iCodConcepto = ihCodConcepto;
      pCargo->iCodProducto = shCodProducto;
      pCargo->dImpCargo    = dhImpCargo   ;
      pCargo->lCodPlanCom  = lhCodPlanCom ;
      pCargo->lNumUnidades = ihNumUnidades;
      pCargo->iIndFactur   = shIndFactur  ;

      pCargo->lNumAbonado     = (i_shNumAbonado == ORA_NULL)?-1:lhNumAbonado ;
      pCargo->lCodCiclFact    = (i_shCodCiclFact== ORA_NULL)?-1:lhCodCiclFact;
      pCargo->lCapCode        = (i_shCapCode    == ORA_NULL)?-1:lhCapCode    ;
      pCargo->iMesGarantia    = (i_shMesGarantia== ORA_NULL)?-1:ihMesGarantia;
      pCargo->lNumTransaccion = (i_shNumTransaccion == ORA_NULL)?ORA_NULL:
                                 lhNumTransaccion                            ;
      pCargo->lNumVenta       = (i_shNumVenta   == ORA_NULL)?-1:lhNumVenta   ;
      pCargo->lNumFactura     = (i_shNumFactura == ORA_NULL)?-1:lhNumFactura ;
      pCargo->iCodConceptoDto = (i_shCodConceptoDto==ORA_NULL)?-1:
                                 ihCodConceptoDto;
      pCargo->dValDto         = (i_shValDto     == ORA_NULL)?-1:dhValDto     ;
      pCargo->iTipDto         = (i_shTipDto     == ORA_NULL)?-1:shTipDto     ;
      pCargo->iIndCuota       = (i_shIndCuota   == ORA_NULL)?-1:shIndCuota   ;
      pCargo->iNumPaquete     = (i_shNumPaquete == ORA_NULL)?-1:ihNumPaquete ;
      pCargo->iIndSuperTel    = (i_shIndSuperTel== ORA_NULL)?-1:shIndSuperTel;

      if (i_shNumPreGuia  == ORA_NULL)
          pCargo->szNumPreGuia[0] = 0;
      if (i_shNumGuia     == ORA_NULL)
          pCargo->szNumGuia   [0] = 0;
      if (i_shNumSerie    == ORA_NULL)
          pCargo->szNumSerie  [0] = 0;
      if (i_shNumTerminal == ORA_NULL)
          pCargo->szNumTerminal[0]= 0;
      if (i_shNumSerieMec == ORA_NULL)
          pCargo->szNumSerieMec[0]= 0;
  }
  return SQLCODE;

}/********************** Final iFetchCargos **********************************/


/*****************************************************************************/
/*                        funcion : iCloseCargos                             */
/*****************************************************************************/
static int iCloseCargos (int iTipoFactura,long lNumVenta)
{
  if (iTipoFactura == FACT_CONTADO)
  {
      if (lNumVenta == ORA_NULL)
          /* EXEC SQL CLOSE Cur_CargosContado; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 29;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1331;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


      else
          /* EXEC SQL CLOSE Cur_CargosPVenta; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 29;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1346;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA || iTipoFactura == FACT_CICLO)
      /* EXEC SQL CLOSE Cur_CargosCliente; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1361;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ga_Cargos",
               szfnORAerror());

  return SQLCODE;
}/**************************** Final iCloseCargos ****************************/

/*****************************************************************************/
/*                             funcion : iCmpCargos                          */
/*****************************************************************************/
int iCmpCargos (const void* cad1, const void* cad2)
{
  int rc = 0;

  if ( ((CARGOS *)cad1)->lNumCargo > ((CARGOS *)cad2)->lNumCargo )
       rc = 1;
  if ( ((CARGOS *)cad1)->lNumCargo < ((CARGOS *)cad2)->lNumCargo )
       rc = -1;
  if ( ((CARGOS *)cad1)->lNumCargo == ((CARGOS *)cad2)->lNumCargo )
       rc =  0;
  return rc;
}/*************************** Final iCmpCargos *******************************/


/*****************************************************************************/
/*                             funcion : bCargaCargos                        */
/*****************************************************************************/
BOOL bCargaCargos (CARGOS *pCargos        ,
                   /*int    *piNumCargos    , */
                   long    *piNumCargos    , /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */ 
                   int     iTipoFact      ,
                   long    lNumTransaccion,
                   long    lNumVenta)
{
  int rc = 0;
  long iCont = 0; /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */ 

  if (iOpenCargos (iTipoFact,lNumTransaccion,lNumVenta))
      return FALSE;

  for (iCont=0;iCont<MAX_CARGOS;iCont++)
  {
       pCargos[iCont].lNumVenta = lNumVenta         ;
       pCargos[iCont].iFlagFaCargo = 0;
       rc = iFetchCargos (&pCargos[iCont],iTipoFact);
       if (rc == SQLNOTFOUND)
           break;
       if (rc != 0)
           return FALSE;

  }/* fin for->(;;) */

  *piNumCargos = iCont;
  if (rc == 0 && iCont == MAX_CARGOS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Cargos");
      return FALSE;
  }

  if (rc == SQLNOTFOUND && *piNumCargos >= 0  && *piNumCargos <= MAX_CARGOS)
  {
      qsort (pCargos,*piNumCargos,sizeof(CARGOS),iCmpCargos);
      vPrintCargos (pCargos,iCont)                          ;
  }
  return (iCloseCargos (iTipoFact,lNumVenta) != 0)?FALSE:TRUE;
}/************************** Final bCargaCargos ******************************/

/*****************************************************************************/
/*                         funcion : vPrintCargos                            */
/*****************************************************************************/
/* void vPrintCargos (CARGOS *pCargo, int iNumCargo)*/
void vPrintCargos (CARGOS *pCargo, long iNumCargo) /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */ 
{
   long i = 0; /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */ 

	if (stStatus.LogNivel >= LOG06)
	{
	   vDTrazasLog (szExeName,"\n\t*** Tabla GE_CARGOS [%ld] ***\n",LOG05,iNumCargo);
	   for (i=0;i<iNumCargo;i++)
	   {
	        vDTrazasLog (szExeName,"\n\t[%ld]-Num.Cargo............[%ld]"
	                               "\n\t[%ld]-Cod.Cliente..........[%ld]"
	                               "\n\t[%ld]-Cod.Producto.........[%d] "
	                               "\n\t[%ld]-Cod.Concepto.........[%d] "
	                               "\n\t[%ld]-Fec.Alta.............[%s] "
	                               "\n\t[%ld]-Imp.Cargo............[%f] "
	                               "\n\t[%ld]-Cod.Moneda...........[%s] "
	                               "\n\t[%ld]-Cod.Plan Comercial...[%ld]"
	                               "\n\t[%ld]-Num.Unidades.........[%d] "
	                               "\n\t[%ld]-Num.Abonado..........[%ld]"
	                               "\n\t[%ld]-Num.Terminal.........[%s] "
	                               "\n\t[%ld]-Cod.CiclFact.........[%ld]"
	                               "\n\t[%ld]-NumSerie.............[%s] "
	                               "\n\t[%ld]-Num.SerieMec.........[%s] "
	                               "\n\t[%ld]-Cap.Code.............[%ld]"
	                               "\n\t[%ld]-Num.Terminal.........[%s] "
	                               "\n\t[%ld]-Mes Garantia.........[%d] "
	                               "\n\t[%ld]-Num.Preguia..........[%s] "
	                               "\n\t[%ld]-Num.Guia.............[%s] "
	                               "\n\t[%ld]-Num.Transaccion......[%ld]"
	                               "\n\t[%ld]-Num.Venta............[%ld]"
	                               "\n\t[%ld]-Num.Factura..........[%ld]"
	                               "\n\t[%ld]-Ind.Facturable.......[%d] "
	                               "\n\t[%ld]-Numero Paquete.......[%d] "
	                               "\n\t[%ld]-Ind.Cuota............[%d] "
	                               "\n\t[%ld]-Cod.Concepto Dto.....[%d] "
	                               "\n\t[%ld]-Valor Dto............[%f] "
	                               "\n\t[%ld]-Tipo Dto.............[%d] "
	                               ,LOG05                       ,i,pCargo[i].lNumCargo
	                               ,i,pCargo[i].lCodCliente     ,i,pCargo[i].iCodProducto
	                               ,i,pCargo[i].iCodConcepto    ,i,pCargo[i].szFecAlta
	                               ,i,pCargo[i].dImpCargo       ,i,pCargo[i].szCodMoneda
	                               ,i,pCargo[i].lCodPlanCom     ,i,pCargo[i].lNumUnidades
	                               ,i,pCargo[i].lNumAbonado     ,i,pCargo[i].szNumTerminal
	                               ,i,pCargo[i].lCodCiclFact    ,i,pCargo[i].szNumSerie
	                               ,i,pCargo[i].szNumSerieMec   ,i,pCargo[i].lCapCode
	                               ,i,pCargo[i].szNumTerminal   ,i,pCargo[i].iMesGarantia
	                               ,i,pCargo[i].szNumPreGuia    ,i,pCargo[i].szNumGuia
	                               ,i,pCargo[i].lNumTransaccion ,i,pCargo[i].lNumVenta
	                               ,i,pCargo[i].lNumFactura     ,i,pCargo[i].iIndFactur
	                               ,i,pCargo[i].iNumPaquete     ,i,pCargo[i].iIndCuota
	                               ,i,pCargo[i].iCodConceptoDto ,i,pCargo[i].dValDto
	                               ,i,pCargo[i].iTipDto      );

		}/* fin for */
	}
}/************************** Final vPrintCargos ******************************/

/*****************************************************************************/
/*                          funcion : iOpenPenalizaciones                    */
/* -Funcion que abre el cursor sobre Ca_Penalizaciones                       */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iOpenPenalizaciones (int iTipoFactura,long lCodCliente)
{
  /* EXEC SQL DECLARE Cur_Penalizaciones CURSOR FOR
       SELECT /o+ FULL(CA_PENALIZACIONES) o/
              ROWID                                       ,
              COD_CLIENTE                                 ,
              TIP_INCIDENCIA                              ,
              TO_CHAR (FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS'),
              COD_MONEDA                                  ,
              IMP_PENALIZ                                 ,
              COD_CICLFACT                                ,
              COD_CONCEPTO                                ,
              COD_PRODUCTO                                ,
              NUM_ABONADO                                 ,
              NUM_PROCESO
       FROM   CA_PENALIZACIONES; */ 


  /* EXEC SQL DECLARE Cur_PenaBaja CURSOR FOR
       SELECT /o+ FULL(CA_PENALIZACIONES) o/
              ROWID                                       ,
              COD_CLIENTE                                 ,
              TIP_INCIDENCIA                              ,
              TO_CHAR (FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS'),
              COD_MONEDA                                  ,
              IMP_PENALIZ                                 ,
              COD_CICLFACT                                ,
              COD_CONCEPTO                                ,
              COD_PRODUCTO                                ,
              NUM_ABONADO                                 ,
              NUM_PROCESO
       FROM   CA_PENALIZACIONES
       WHERE  COD_CLIENTE = :lCodCliente
         AND  NUM_PROCESO = 0; */ 


  if (iTipoFactura == FACT_CICLO)
      /* EXEC SQL OPEN Cur_Penalizaciones; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0016;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1376;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (iTipoFactura == FACT_BAJA      ||iTipoFactura == FACT_RENTAPHONE||
      iTipoFactura == FACT_ROAMINGVIS || iTipoFactura == FACT_LIQUIDACION)
      /* EXEC SQL OPEN Cur_PenaBaja      ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0017;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1391;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ca_Penalizaciones",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final iOpenPenalizaciones *********************/


/*****************************************************************************/
/*                            funcion : iFetchPenalizaciones                 */
/* -Valores Retorno SQLCODE                                                  */
/*****************************************************************************/
static int iFetchPenalizaciones (int iTipoFactura,PENALIZA *pPenaliza)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static short i_shCodCiclFact;
  /* EXEC SQL END DECLARE SECTION; */ 


  szhFecEfectividad = pPenaliza->szFecEfectividad;
  szhRowid          = pPenaliza->szRowid         ;
  szhCodMoneda      = pPenaliza->szCodMoneda     ;

  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL FETCH Cur_Penalizaciones INTO :szhRowid                     ,
                                             :lhCodCliente                 ,
                                             :ihTipIncidencia              ,
                                             :szhFecEfectividad            ,
                                             :szhCodMoneda                 ,
                                             :dhImpPenaliz                 ,
                                             :lhCodCiclFact:i_shCodCiclFact,
                                             :ihCodConcepto                ,
                                             :shCodProducto                ,
                                             :lhNumAbonado:i_shNumAbonado  ,
                                             :lhNumProceso; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1410;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&ihTipIncidencia;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhFecEfectividad;
      sqlstm.sqhstl[3] = (unsigned long )15;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhCodMoneda;
      sqlstm.sqhstl[4] = (unsigned long )4;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&dhImpPenaliz;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCiclFact;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)&i_shCodCiclFact;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&shCodProducto;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)&i_shNumAbonado;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&lhNumProceso;
      sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA      ||
      iTipoFactura == FACT_RENTAPHONE||
      iTipoFactura == FACT_ROAMINGVIS||
      iTipoFactura == FACT_LIQUIDACION)
  {
      /* EXEC SQL FETCH Cur_PenaBaja INTO :szhRowid                     ,
                                       :lhCodCliente                 ,
                                       :ihTipIncidencia              ,
                                       :szhFecEfectividad            ,
                                       :szhCodMoneda                 ,
                                       :dhImpPenaliz                 ,
                                       :lhCodCiclFact:i_shCodCiclFact,
                                       :ihCodConcepto                ,
                                       :shCodProducto                ,
                                       :lhNumAbonado:i_shNumAbonado  ,
                                       :lhNumProceso; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1469;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&ihTipIncidencia;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhFecEfectividad;
      sqlstm.sqhstl[3] = (unsigned long )15;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhCodMoneda;
      sqlstm.sqhstl[4] = (unsigned long )4;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&dhImpPenaliz;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCiclFact;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)&i_shCodCiclFact;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&shCodProducto;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)&i_shNumAbonado;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&lhNumProceso;
      sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }

  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ca_Penalizaciones",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pPenaliza->lCodCliente    = lhCodCliente   ;
      pPenaliza->iTipIncidencia = ihTipIncidencia;
      pPenaliza->dImpPenaliz    = dhImpPenaliz   ;
      pPenaliza->lCodCiclFact   = lhCodCiclFact  ;
      pPenaliza->iCodConcepto   = ihCodConcepto  ;
      pPenaliza->iCodProducto   = shCodProducto  ;

      pPenaliza->lNumAbonado = (i_shNumAbonado == ORA_NULL)?-1:lhNumAbonado;
      pPenaliza->lNumProceso = (i_shNumProceso == ORA_NULL)?-1:lhNumProceso;
  }
  return SQLCODE;
}/*************************** Final iFetchPenalizaciones *********************/


/*****************************************************************************/
/*                           funcion : iClosePenalizaciones                  */
/* -Funcion que cierra el cursor Cur_Penalizaciones                          */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int iClosePenalizaciones (int iTipoFactura)
{
  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL CLOSE Cur_Penalizaciones; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1528;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA      || iTipoFactura == FACT_RENTAPHONE ||
      iTipoFactura == FACT_ROAMINGVIS || iTipoFactura == FACT_LIQUIDACION)
  {
      /* EXEC SQL CLOSE Cur_PenaBaja      ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1543;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (SQLCODE != 0)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Penalizaciones",
               szfnORAerror());

  return SQLCODE;
}/*************************** Final iClosePenalizaciones *********************/

/*****************************************************************************/
/*                          funcion : iCmpPenalizaciones                     */
/* -Funcion de comparacion                                                   */
/* -Valores Retorno : resultado de las comparaciones                         */
/*****************************************************************************/
int iCmpPenalizaciones (const void* cad1, const void* cad2)
{
  int rc = 0;

  if ( ((PENALIZA *)cad1)->lCodCliente > ((PENALIZA *)cad2)->lCodCliente )
       return  1;
  if ( ((PENALIZA *)cad1)->lCodCliente < ((PENALIZA *)cad2)->lCodCliente )
       return -1;
  if ( ((PENALIZA *)cad1)->lCodCliente ==((PENALIZA *)cad2)->lCodCliente )
  {
       return
          ( (rc = ((PENALIZA *)cad1)->iTipIncidencia-
                  ((PENALIZA *)cad2)->iTipIncidencia) != 0)?rc:
          ( (rc = strcmp ( ((PENALIZA *)cad1)->szFecEfectividad,
                           ((PENALIZA *)cad2)->szFecEfectividad) ) != 0)?rc :0;
  }
}/************************** Final iCmpPenalizaciones ************************/


/*****************************************************************************/
/*                          funcion : bCargaPenalizaciones                   */
/* -Funcion que carga la tabla Ca_Penalizaciones en memoria                  */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bCargaPenalizaciones (PENALIZA *pPenaliza   ,
                           int      *iNumPen     ,
                           int       iTipoFactura,
                           long      lCodCliente)
{
   int rc = 0, iCont = 0;

   if (iOpenPenalizaciones (iTipoFactura,lCodCliente))
       return FALSE;

   for (iCont=0;iCont<MAX_PENALIZACIONES;iCont++)
   {
        rc = iFetchPenalizaciones (iTipoFactura,&pPenaliza[iCont]);
        if (rc == SQLNOTFOUND)
            break;
        if (rc != 0)
            return FALSE;
   }/* fin for */
   *iNumPen = iCont;
   if (rc == SQLNOTFOUND && iCont > 0 && iCont <= MAX_PENALIZACIONES)
   {
       qsort (pPenaliza,iCont,sizeof(PENALIZA),iCmpPenalizaciones);
       vPrintPenalizaciones (pPenaliza,iCont);
   }
   if (rc == 0 && iCont == MAX_PENALIZACIONES)
   {
       iDError (szExeName,ERR016,vInsertarIncidencia,"Ca_Penalizaciones");
       return FALSE;
   }
   return (iClosePenalizaciones (iTipoFactura) != 0)?FALSE:TRUE;
}/************************** Final bCargaPenalizaciones **********************/


/*****************************************************************************/
/*                         funcion : vPrintPenalizaciones                    */
/*****************************************************************************/
void vPrintPenalizaciones (PENALIZA *pPenaliza, int iNumPen)
{
   int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	   vDTrazasLog (szExeName,
	                "\n\t***  Tabla CA_PENALIZACIONES ***",LOG06);

	   for (i=0;i<iNumPen;i++)
	   {
	       vDTrazasLog (szExeName,"\n\t[%d]-CodCliente................[%d]"
	                              "\n\t[%d]-Tipo Incidencia...........[%d]"
	                              "\n\t[%d]-Fec.Efectividad...........[%s]"
	                              "\n\t[%d]-Importe Penaliza..........[%lf]"
	                              "\n\t[%d]-Cod.Moneda................[%s]"
	                              "\n\t[%d]-Cod.Ciclo Facturacion.....[%d]"
	                              "\n\t[%d]-Cod.Concepto..............[%d]"
	                              "\n\t[%d]-Cod.Producto..............[%d]"
	                              "\n\t[%d]-Num.Abonado...............[%d]"
	                              "\n\t[%d]-Num.Proceso (Facturacion).[%ld]"
	                              ,LOG06,i,pPenaliza[i].lCodCliente
	                              ,i,pPenaliza[i].iTipIncidencia
	                              ,i,pPenaliza[i].szFecEfectividad
	                              ,i,pPenaliza[i].dImpPenaliz
	                              ,i,pPenaliza[i].szCodMoneda
	                              ,i,pPenaliza[i].lCodCiclFact
	                              ,i,pPenaliza[i].iCodConcepto
	                              ,i,pPenaliza[i].iCodProducto
	                              ,i,pPenaliza[i].lNumAbonado
	                              ,i,pPenaliza[i].lNumProceso);

		}
	}
}/************************** Final vPrintPenalizaciones **********************/


/*****************************************************************************/
/*                          funcion : iOpenTaConcepFact                      */
/* -Funcion que abre cursor Cur_TaConcepFact                                 */
/* -Valores de Retorno : SQLCODE                                             */
/*****************************************************************************/
static int iOpenTaConcepFact (void)
{
  /* EXEC SQL DECLARE Cur_TaConcepFact CURSOR FOR
       SELECT /o+ FULL(TA_CONCEPFACT) o/
              COD_PRODUCTO      ,
              COD_FACTURACION   ,
              IND_TABLA         ,
              IND_ENTSAL        ,
              IND_DESTINO       ,
              COD_TARIFICACION  ,
              COD_SERVICIO
       FROM   TA_CONCEPFACT; */ 

  /* EXEC SQL OPEN Cur_TaConcepFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0018;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1558;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




  if (SQLCODE != 0)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ta_ConcepFact",
               szfnORAerror());

  return SQLCODE;

}/************************* Final iOpenTaConcepFact **************************/

/*****************************************************************************/
/*                         funcion : iFetchTaConcepFact                      */
/*****************************************************************************/
static int iFetchTaConcepFact (TACONCEPFACT *pTaC)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static int   ihCodFacturacion ;
   static short shIndTabla       ;
   static short shIndEntSal      ;
   static short shIndDestino     ;
   static int   ihCodTarificacion;
   char   szCodServicio[5]       ;/* EXEC SQL VAR szCodServicio          IS STRING(5); */ 

   /* EXEC SQL END DECLARE SECTION  ; */ 


   /* EXEC SQL FETCH Cur_TaConcepFact INTO :shCodProducto    ,
                                        :ihCodFacturacion ,
                                        :shIndTabla       ,
                                        :shIndEntSal      ,
                                        :shIndDestino     ,
                                        :ihCodTarificacion,
                                        :szCodServicio    ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1573;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&shCodProducto;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodFacturacion;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&shIndTabla;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&shIndEntSal;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&shIndDestino;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTarificacion;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szCodServicio;
   sqlstm.sqhstl[6] = (unsigned long )5;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ta_ConcepFact",
                szfnORAerror());
   if (SQLCODE == 0)
   {
       pTaC->iCodProducto    = shCodProducto    ;
       pTaC->iCodFacturacion = ihCodFacturacion ;
       pTaC->iIndTabla       = shIndTabla       ;
       pTaC->iIndEntSal      = shIndEntSal      ;
       pTaC->iIndDestino     = shIndDestino     ;
       pTaC->iCodTarificacion= ihCodTarificacion;
       strcpy(pTaC->szCodServicio,szCodServicio);
   }
   return SQLCODE;
}/************************* Final iFetchTaConcepFact *************************/


/*****************************************************************************/
/*                          funcion : iCloseTaConcepFact                     */
/*****************************************************************************/
static int iCloseTaConcepFact (void)
{
   /* EXEC SQL CLOSE Cur_TaConcepFact; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1616;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE != 0)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ta_ConcepFact",
                szfnORAerror());
   return SQLCODE;
}/************************* Final iCloseTaConcepFact *************************/


/*****************************************************************************/
/*                         funcion : iCmpTaConcepFact                        */
/*****************************************************************************/
int iCmpTaConcepFact (const void *cad1, const void *cad2)
{
  return ( ((TACONCEPFACT *)cad1)->iCodFacturacion -
           ((TACONCEPFACT *)cad2)->iCodFacturacion );
}/************************* Final iCmpTaConcepFact ***************************/

/*****************************************************************************/
/*                          funcion : bCargaTaConcepFact                     */
/* -Funcion que carga la tabla Ta_ConcepFact en memoria ,control de desborda-*/
/*  miento.                                                                  */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bCargaTaConcepFact (TACONCEPFACT *pTaC, int *iNumTa)
{
     int iCont = 0, rc = 0;

     if (iOpenTaConcepFact ())
         return FALSE;

     for (iCont=0;iCont<MAX_TACONCEPFACT;iCont++)
     {
          rc = iFetchTaConcepFact (&pTaC[iCont]);
          if (rc == SQLNOTFOUND)
              break;
          if (rc != 0)
              return FALSE;
     }
     *iNumTa = iCont;
     if (rc == SQLNOTFOUND && *iNumTa > 0 && *iNumTa <= MAX_TACONCEPFACT)
     {
         qsort (pTaC,*iNumTa,sizeof(TACONCEPFACT),iCmpTaConcepFact);
         vPrintTaConcepFact (pTaC, *iNumTa);
     }
     if (rc == 0 && *iNumTa == MAX_TACONCEPFACT)
     {
         iDError (szExeName,ERR016,vInsertarIncidencia,"Ta_ConcepFact");
         return FALSE;
     }
     return (iCloseTaConcepFact() != 0)?FALSE:TRUE;
}/************************* Final bCargaTaConcepFact *************************/

/*****************************************************************************/
/*                        funcion : vPrintTaConcepFact                       */
/*****************************************************************************/
void vPrintTaConcepFact (TACONCEPFACT *pTaC, int iInd)
{
   int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	   vDTrazasLog (szExeName,"\n\t\t*** Tabla TA_CONCEPFACT ****\n",LOG06);

	   for (i=0;i<iInd;i++)
	   {
	        vDTrazasLog (szExeName,"\n\t[%d]-Cod.Producto.......[%d]"
	                               "\n\t[%d]-Cod.Facturacion....[%d]"
	                               "\n\t[%d]-Ind.Tabla..........[%d]"
	                               "\n\t[%d]-Cod.Tarificacion...[%d]"
	                               ,LOG06,i,pTaC[i].iCodProducto
	                               ,i,pTaC[i].iCodFacturacion
	                               ,i,pTaC[i].iIndTabla
	                               ,i,pTaC[i].iCodTarificacion);

		}
	}
}/************************ Final vPrintTaConcepFact **************************/

/*****************************************************************************/
/*                          funcion : iOpenFactCarriers                      */
/* -Funcion que abre cursor Cur_FactCarriers                                 */
/* -Valores de Retorno : SQLCODE                                             */
/*****************************************************************************/
static int iOpenFactCarriers (void)
{
  /* EXEC SQL DECLARE Cur_FactCarriers CURSOR FOR
       SELECT /o+ full (FA_FACTCARRIERS) o/
              A.COD_CONCFACT,
              A.COD_CONCCARRIER,
              B.COD_TIPCONCE
       FROM   FA_FACTCARRIERS A,
       		  FA_CONCEPTOS B
       WHERE  B.COD_CONCEPTO = A.COD_CONCFACT; */ 


  /* EXEC SQL OPEN Cur_FactCarriers; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0019;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1631;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open=>Fa_FactCarriers",
               szfnORAerror());

  return SQLCODE;

}/************************* Final iOpenFactCarriers **************************/

/*****************************************************************************/
/*                         funcion : iFetchFactCarriers                      */
/*****************************************************************************/
static int iFetchFactCarriers (FACTCARRIERS *pstFC)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static int ihCodConcFact   ;
   static int ihCodConcCarrier;
   static int ihCodTipConce;
   /* EXEC SQL END DECLARE SECTION  ; */ 


   /* EXEC SQL FETCH Cur_FactCarriers INTO :ihCodConcFact, :ihCodConcCarrier, :ihCodTipConce; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1646;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcFact;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcCarrier;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipConce;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=>Fa_FactCarriers",
                szfnORAerror());
   if (SQLCODE == 0)
   {
       pstFC->iCodConcFact    = ihCodConcFact   ;
       pstFC->iCodConcCarrier = ihCodConcCarrier;
       pstFC->iCodTipConce    = ihCodTipConce;
   }
   return SQLCODE;
}/************************* Final iFetchFactCarriers *************************/


/*****************************************************************************/
/*                          funcion : iCloseFactCarriers                     */
/*****************************************************************************/
static int iCloseFactCarriers (void)
{
   /* EXEC SQL CLOSE Cur_FactCarriers; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1673;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE != 0)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=>Fa_FactCarriers",
                szfnORAerror());
   return SQLCODE;
}/************************* Final iCloseFactCarriers *************************/


/*****************************************************************************/
/*                         funcion : iCmpFactCarriers                        */
/*****************************************************************************/
static int iCmpFactCarriers (const void *cad1, const void *cad2)
{
  return ( ((FACTCARRIERS *)cad1)->iCodConcFact -
           ((FACTCARRIERS *)cad2)->iCodConcFact );
}/************************* Final iCmpFactCarriers ***************************/

/*****************************************************************************/
/*                          funcion : bCargaFactCarriers                     */
/*-Funcion que carga la tabla Fa_FactCarriers en memoria,control de desborda-*/
/*  miento.                                                                  */
/*-Valores Retorno : Error->FALSE, !Error->TRUE                              */
/*****************************************************************************/
BOOL bCargaFactCarriers (FACTCARRIERS *pstFC, int *iNumFC)
{
     int iCont = 0, rc = 0;

     if (iOpenFactCarriers ())
         return FALSE;

     for (iCont=0;iCont<MAX_FACTCARRIERS;iCont++)
     {
          rc = iFetchFactCarriers (&pstFC[iCont]);
          if (rc == SQLNOTFOUND)
              break;
          if (rc != 0)
              return FALSE;
     }
     *iNumFC = iCont;
     if (rc == SQLNOTFOUND && *iNumFC > 0 && *iNumFC <= MAX_FACTCARRIERS)
     {
         qsort (pstFC,*iNumFC,sizeof(FACTCARRIERS),iCmpFactCarriers);
         vPrintFactCarriers (pstFC, *iNumFC);
     }
     if (rc == 0 && *iNumFC == MAX_FACTCARRIERS)
     {
         iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_FactCarriers");
         return FALSE;
     }
     return (iCloseFactCarriers() != 0)?FALSE:TRUE;
}/************************* Final bCargaFactCarriers *************************/

/*****************************************************************************/
/*                        funcion : vPrintFactCarriers                       */
/*****************************************************************************/
void vPrintFactCarriers (FACTCARRIERS *pstFact, int iInd)
{
   int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	   vDTrazasLog (szExeName,"\n\t\t*** Tabla FA_FACTCARRIERS ****\n",LOG06);

	   for (i=0;i<iInd;i++)
	   {
	        vDTrazasLog (szExeName,"\t[%d]-Cod.Facturacion.....%d "
	                               "\t[%d]-Cod.Tarificacion....%d "
	                               ,LOG06,i,pstFact[i].iCodConcFact
	                               ,i,pstFact[i].iCodConcCarrier);
	   }
	}
}/************************ Final vPrintFactCarriers **************************/


/*****************************************************************************/
/*                        funcion : iOpenConversion                          */
/*****************************************************************************/
static int iOpenConversion (void )
{
  /* EXEC SQL DECLARE Cur_Conversion CURSOR FOR
       SELECT /o+ FULL (GE_CONVERSION) o/
              COD_MONEDA                            ,
              TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS'),
              TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS'),
              CAMBIO 
       FROM   GE_CONVERSION; */ 


  /* EXEC SQL OPEN Cur_Conversion; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0020;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1688;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Conversion",
               szfnORAerror());

  return SQLCODE;
}/*********************** Final iOpenConversion ******************************/

/*****************************************************************************/
/*                       funcion : iFetchConversion                          */
/*****************************************************************************/
static int iFetchConversion (CONVERSION *pConver)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static double  dhCambio     ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodMoneda = pConver->szCodMoneda ;
  szhFecDesde  = pConver->szFecDesde  ;
  szhFecHasta  = pConver->szFecHasta  ;

  /* EXEC SQL FETCH Cur_Conversion INTO :szhCodMoneda ,
                                     :szhFecDesde  ,
                                     :szhFecHasta  ,
                                     :dhCambio; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1703;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[1] = (unsigned long )15;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[2] = (unsigned long )15;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhCambio;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Conversion",
               szfnORAerror());

  if (SQLCODE == 0)
      pConver->dCambio = dhCambio;

  return SQLCODE;
}/*********************** Final iFetchConversion *****************************/

/*****************************************************************************/
/*                        funcion : iCloseConversion                         */
/*****************************************************************************/
static int iCloseConversion (void)
{
   /* EXEC SQL CLOSE Cur_Conversion; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1734;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Conversion",
                szfnORAerror());

   return SQLCODE;
}/*********************** Final iCloseConversion *****************************/

/*****************************************************************************/
/*                        funcion : bCargaConversion                         */
/*****************************************************************************/
BOOL bCargaConversion (CONVERSION *pConver, int *iNumConver,
                       char *szFecDesde,char *szFecHasta)
{
  BOOL bRes = TRUE;
  int rc = 0, iCont = 0;

  if (iOpenConversion ())
      bRes = FALSE;

  while (iCont<MAX_CONVERSION && bRes)
  {
         rc = iFetchConversion (&pConver[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumConver = iCont;
  if (rc == SQLNOTFOUND && *iNumConver >= 0 && *iNumConver <=MAX_CONVERSION)
  {
      qsort (pConver,*iNumConver,sizeof(CONVERSION),iCmpConversion);
      bRes = TRUE;
      vPrintConversion (pConver,*iNumConver);
  }
  if (rc == 0 && *iNumConver == MAX_CONVERSION)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Conversion");
      bRes = FALSE;
  }
  return (bRes && iCloseConversion () == 0)?TRUE:FALSE;
}/************************ Final bCargaConversion ****************************/


/*****************************************************************************/
/*                       funcion : iOpenTarifas                              */
/*****************************************************************************/
static int iOpenTarifas (void)
{

  /* EXEC SQL DECLARE Cur_Tarifas CURSOR FOR
       SELECT /o+ FULL(GA_TARIFAS) o/
              COD_TIPSERV                          ,
              COD_SERVICIO                         ,
              COD_PLANSERV                         ,
              TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS'),
              IMP_TARIFA                           ,
              COD_MONEDA                           ,
              IND_PERIODICO                        ,
              TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS')
         FROM GA_TARIFAS
        WHERE COD_PRODUCTO = 1
          AND COD_ACTABO   = 'FA'
        ORDER BY COD_TIPSERV, COD_SERVICIO, COD_PLANSERV, FEC_DESDE; */ 

  /* EXEC SQL OPEN Cur_Tarifas; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0021;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1749;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ga_Tarifas",
               szfnORAerror());

  return SQLCODE;

}/*********************** Final iOpenTarifas *********************************/

/*****************************************************************************/
/*                      funcion : iFetchTarifas                              */
/*****************************************************************************/
static int iFetchTarifas (TARIFAS *pTar)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhCodTipServ  ; /* EXEC SQL VAR szhCodTipServ   IS STRING(2) ; */ 

  static char*  szhCodServicio ; /* EXEC SQL VAR szhCodServicio  IS STRING(4) ; */ 

  static char*  szhCodPlanServ ; /* EXEC SQL VAR szhCodPlanServ  IS STRING(4) ; */ 

  static double dhImpTarifa    ;
  static char*  szhIndPeriodico; /* EXEC SQL VAR szhIndPeriodico IS STRING(2) ; */ 

  static short  i_shFecHasta   ;
  /* EXEC SQL END DECLARE SECTION ; */ 


  szhCodTipServ  = pTar->szCodTipServ  ;
  szhCodServicio = pTar->szCodServicio ;
  szhCodPlanServ = pTar->szCodPlanServ ;
  szhFecDesde    = pTar->szFecDesde    ;
  szhCodMoneda   = pTar->szCodMoneda   ;
  szhIndPeriodico= pTar->szIndPeriodico;
  szhFecHasta    = pTar->szFecHasta    ;

  /* EXEC SQL FETCH Cur_Tarifas INTO :szhCodTipServ  ,
                                  :szhCodServicio ,
                                  :szhCodPlanServ ,
                                  :szhFecDesde    ,
                                  :dhImpTarifa    ,
                                  :szhCodMoneda   ,
                                  :szhIndPeriodico,
                                  :szhFecHasta:i_shFecHasta; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1764;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipServ;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodServicio;
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanServ;
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&dhImpTarifa;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[5] = (unsigned long )4;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhIndPeriodico;
  sqlstm.sqhstl[6] = (unsigned long )2;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[7] = (unsigned long )15;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)&i_shFecHasta;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ga_Tarifas",
               szfnORAerror());
  if (SQLCODE == 0)
  {
      if (i_shFecHasta == ORA_NULL)
          strcpy (pTar->szFecHasta,"")  ;

      pTar->dImpTarifa   = dhImpTarifa  ;
  }

  return SQLCODE;
}/********************** Final iFetchTarifas *********************************/

/*****************************************************************************/
/*                      funcion : iCloseTarifas                              */
/*****************************************************************************/
static int iCloseTarifas (void)
{
  /* EXEC SQL CLOSE Cur_Tarifas; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1811;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ga_Tarifas",
               szfnORAerror());

  return SQLCODE;
}/*********************** Final iCloseTarifas ********************************/

/*****************************************************************************/
/*                      funcion : bCargaTarifas                              */
/*****************************************************************************/
BOOL bCargaTarifas (TARIFAS *pTar,int *iNumTar)
{
   int rc = 0, iCont = 0;
   BOOL bRes = TRUE;

   if (iOpenTarifas ())
       bRes = FALSE;

   while (iCont<MAX_TARIFAS && bRes)
   {
         rc = iFetchTarifas (&pTar[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumTar = iCont;
  vDTrazasLog (szExeName,"\n\t\t* Carga de Tarifas [bCargaTarifas]\n"
                         "\t\t=> Registros Cargados en Estructura [%d]\n",LOG03, iCont);
  if (rc == SQLNOTFOUND && *iNumTar >= 0 && *iNumTar <=MAX_TARIFAS)
  {
      /* XO-200606151138 FAAR ** Se elimina ordenamiento, ya que se pierden datos. */
      /* qsort (pTar,*iNumTar,sizeof(TARIFAS),iCmpTarifas);                        */
      bRes = TRUE;
      vPrintTarifas (pTar,*iNumTar);
  }
  if (rc == 0 && *iNumTar == MAX_TARIFAS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ga_Tarifas");
      bRes = FALSE;
  }
  return (bRes && iCloseTarifas () == 0)?TRUE:FALSE;

}/*********************** Final bCargaTarifas ********************************/


/*****************************************************************************/
/*                        funcion : iOpenPlanCtoPlan                         */
/*****************************************************************************/
static int iOpenPlanCtoPlan (void)
{
  /* EXEC SQL DECLARE Cur_PlanCtoPlan CURSOR FOR
       SELECT /o+ FULL (VE_PLAN_CTOPLAN) o/
                  COD_PLANCOM     ,
                  COD_PRODUCTO    ,
                  COD_CTOPLAN     ,
                  TO_CHAR (FEC_EFECTIVIDAD,   'YYYYMMDDHH24MISS'),
                  TO_CHAR (FEC_FINEFECTIVIDAD,'YYYYMMDDHH24MISS')
           FROM   VE_PLAN_CTOPLAN; */ 


 /* EXEC SQL OPEN Cur_PlanCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 29;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0022;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1826;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 if (SQLCODE)
     iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ve_Plan_CtoPlan",
              szfnORAerror());

 return SQLCODE;
}/*********************** Final iOpenPlanCtoPlan *****************************/

/*****************************************************************************/
/*                        funcion : iFetchPlanCtoPlan                        */
/*****************************************************************************/
static int iFetchPlanCtoPlan (PLANCTOPLAN *pPlan)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhCodPlanCom        ;
  static long  lhCodCtoPlan        ;
  static char* szhFecFinEfectividad;
                               /* EXEC SQL VAR szhFecFinEfectividad IS STRING(15); */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhFecEfectividad    = pPlan->szFecEfectividad   ;
  szhFecFinEfectividad = pPlan->szFecFinEfectividad;

  /* EXEC SQL FETCH Cur_PlanCtoPlan INTO :lhCodPlanCom        ,
                                      :shCodProducto       ,
                                      :lhCodCtoPlan        ,
                                      :szhFecEfectividad   ,
                                      :szhFecFinEfectividad; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1841;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&shCodProducto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCtoPlan;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecEfectividad;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecFinEfectividad;
  sqlstm.sqhstl[4] = (unsigned long )15;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ve_Plan_CtoPlan",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pPlan->lCodPlanCom = lhCodPlanCom ;
      pPlan->iCodProducto= shCodProducto;
      pPlan->lCodCtoPlan = lhCodCtoPlan ;
  }
  return SQLCODE;
}/********************** Final iFetchPlanCtoPlan *****************************/

/*****************************************************************************/
/*                       funcion : iClosePlanCtoPlan                         */
/*****************************************************************************/
static int iClosePlanCtoPlan (void)
{
  /* EXEC SQL CLOSE Cur_PlanCtoPlan; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1876;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ve_Plan_CtoPlan",
               szfnORAerror());

  return SQLCODE;
}/********************** Final iClosePlanCtoPlan *****************************/


/*****************************************************************************/
/*                       funcion : iCmpPlanCtoPlan                           */
/*****************************************************************************/
int iCmpPlanCtoPlan (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( ((PLANCTOPLAN *)cad1)->lCodPlanCom <
     ((PLANCTOPLAN *)cad2)->lCodPlanCom)?-1:
   ( ((PLANCTOPLAN *)cad1)->lCodPlanCom >
     ((PLANCTOPLAN *)cad2)->lCodPlanCom)? 1:
   ( ((PLANCTOPLAN *)cad1)->lCodCtoPlan <
     ((PLANCTOPLAN *)cad2)->lCodCtoPlan )?-1:
   ( ((PLANCTOPLAN *)cad1)->lCodCtoPlan >
     ((PLANCTOPLAN *)cad1)->lCodCtoPlan )? 1:
   ( (rc = strcmp ( ((PLANCTOPLAN *)cad1)->szFecEfectividad,
                    ((PLANCTOPLAN *)cad2)->szFecEfectividad ) ) != 0)?rc:0;
}/********************** Final iCmpPlanCtoPlan *******************************/

/*****************************************************************************/
/*                       funcion : vPrintPlanCtoPlan                         */
/*****************************************************************************/
void vPrintPlanCtoPlan (PLANCTOPLAN *pPlan,int iNumPlan)
{
  int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla VE_PLAN_CTOPLAN ***",LOG06);
	  for (i=0;i<iNumPlan;i++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d]-Cod.Plan Comercial....[%ld]"
	                              "\n\t[%d]-Cod.Producto..........[%d] "
	                              "\n\t[%d]-Cod.Cto.Plan..........[%d] "
	                              "\n\t[%d]-Fec.Efectividad.......[%s] "
	                              "\n\t[%d]-Fec.Fin Efectividad...[%s] "
	                              ,LOG06,i,pPlan[i].lCodPlanCom
	                              ,i,pPlan[i].iCodProducto
	                              ,i,pPlan[i].lCodCtoPlan
	                              ,i,pPlan[i].szFecEfectividad
	                              ,i,pPlan[i].szFecFinEfectividad);

		}
	}
}/*********************** Final vPrintPlanCtoPlan ****************************/

/*****************************************************************************/
/*                       funcion : bCargaPlanCtoPlan                         */
/*****************************************************************************/
BOOL bCargaPlanCtoPlan (PLANCTOPLAN *pPlan, int *iNumPlan)
{
  int rc = 0, iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenPlanCtoPlan ())
      bRes = FALSE;

  while (iCont<MAX_PLANCTOPLAN && bRes)
  {
         rc = iFetchPlanCtoPlan (&pPlan[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumPlan = iCont;
  if (rc == SQLNOTFOUND && *iNumPlan >= 0 && *iNumPlan <=MAX_PLANCTOPLAN)
  {
      qsort (pPlan,*iNumPlan,sizeof(PLANCTOPLAN),iCmpPlanCtoPlan);
      bRes = TRUE;
      vPrintPlanCtoPlan (pPlan,*iNumPlan);
  }
  if (rc == 0 && *iNumPlan == MAX_PLANCTOPLAN)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ve_Plan_CtoPlan");
      bRes = FALSE;
  }
 return (bRes && iClosePlanCtoPlan () == 0)?TRUE:FALSE;

}/********************* Final bCargaPlanCtoPlan ******************************/

/*****************************************************************************/
/*                      funcion : iOpenCtoPlan                               */
/*****************************************************************************/
static int iOpenCtoPlan (void)
{
  /* EXEC SQL DECLARE Cur_CtoPlan CURSOR FOR
       SELECT /o+ FULL (VE_CTOPLAN) o/
              COD_CTOPLAN    ,
              COD_PRODUCTO   ,
              COD_TIPCTOPLAN ,
              COD_MONEDA     ,
              COD_CTOFAC     ,
              IMP_DESCUENTO  ,
              COD_TIPODTO    ,
              IND_CUADRANTE  ,
              COD_TIPOCUAD   ,
              IMP_UMBDESDE   ,
              IMP_UMBHASTA   ,
              NUM_DIAS
       FROM   VE_CTOPLAN; */ 


  /* EXEC SQL OPEN Cur_CtoPlan; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0023;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1891;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ve_CtoPlan",
               szfnORAerror());

  return SQLCODE;
}/********************** Final iOpenCtoPlan **********************************/

/*****************************************************************************/
/*                         funcion : iFetchCtoPlan                           */
/*****************************************************************************/
static int iFetchCtoPlan (CTOPLAN *pCto)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhCodCtoPlan    ;
  static char*  szhCodTipCtoPlan; /* EXEC SQL VAR szhCodTipCtoPlan IS STRING (2) ; */ 

  static int    ihCodCtoFac     ;
  static double dhImpDescuento  ;
  static short  shCodTipoDto    ;
  static short  shIndCuadrante  ;
  static short  shCodTipoCuad   ;
  static double dhImpUmbDesde   ;
  static double dhImpUmbHasta   ;
  static int    ihNumDias       ;
  static short  i_shImpUmbDesde ;
  static short  i_shImpUmbHasta ;
  static short  i_shNumDias     ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodMoneda     = pCto->szCodMoneda    ;
  szhCodTipCtoPlan = pCto->szCodTipCtoPlan;

  /* EXEC SQL FETCH Cur_CtoPlan INTO :lhCodCtoPlan                 ,
                                  :shCodProducto                ,
                                  :szhCodTipCtoPlan             ,
                                  :szhCodMoneda                 ,
                                  :ihCodCtoFac                  ,
                                  :dhImpDescuento               ,
                                  :shCodTipoDto                 ,
                                  :shIndCuadrante               ,
                                  :shCodTipoCuad                ,
                                  :dhImpUmbDesde:i_shImpUmbDesde,
                                  :dhImpUmbHasta:i_shImpUmbHasta,
                                  :ihNumDias:i_shNumDias; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1906;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCtoPlan;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&shCodProducto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipCtoPlan;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[3] = (unsigned long )4;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCtoFac;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&dhImpDescuento;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&shCodTipoDto;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&shIndCuadrante;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&shCodTipoCuad;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&dhImpUmbDesde;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)&i_shImpUmbDesde;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&dhImpUmbHasta;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)&i_shImpUmbHasta;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)&ihNumDias;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)&i_shNumDias;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ve_CtoPlan",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pCto->lCodCtoPlan  = lhCodCtoPlan  ;
      pCto->iCodProducto = shCodProducto ;
      pCto->iCodCtoFac   = ihCodCtoFac   ;
      pCto->dImpDescuento= dhImpDescuento;
      pCto->iCodTipoDto  = shCodTipoDto  ;
      pCto->iIndCuadrante= shIndCuadrante;
      pCto->iCodTipoCuad = shCodTipoCuad ;

      pCto->dImpUmbDesde = (i_shImpUmbDesde == ORA_NULL)?-1:dhImpUmbDesde;
      pCto->dImpUmbHasta = (i_shImpUmbHasta == ORA_NULL)?-1:dhImpUmbHasta;
      pCto->iNumDias     = (i_shNumDias     == ORA_NULL)?-1:ihNumDias    ;
  }
  return SQLCODE;
}/************************ Final iFetchCtoPlan *******************************/

/*****************************************************************************/
/*                        funcion : iCloseCtoPlan                            */
/*****************************************************************************/
static int iCloseCtoPlan (void)
{
  /* EXEC SQL CLOSE Cur_CtoPlan; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1969;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ve_CtoPlan",
               szfnORAerror ());

  return SQLCODE;
}/************************ Final iCloseCtoPlan *******************************/

/*****************************************************************************/
/*                         funcion : iCmpCtoPlan                             */
/*****************************************************************************/
int iCmpCtoPlan (const void* cad1,const void* cad2)
{
   return
    ( ((CTOPLAN *)cad1)->lCodCtoPlan < ((CTOPLAN *)cad2)->lCodCtoPlan )?-1:
    ( ((CTOPLAN *)cad1)->lCodCtoPlan > ((CTOPLAN *)cad2)->lCodCtoPlan )? 1:0;
}/*********************** Final iCmpCtoPlan **********************************/

/*****************************************************************************/
/*                        funcion : vPrintCtoPlan                            */
/*****************************************************************************/
void vPrintCtoPlan (CTOPLAN *pCto,int iNumCto)
{
  int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla VE_CTOPLAN ***",LOG06);

	  for (i=0;i<iNumCto;i++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d]-Cod.CtoPlan........[%ld]"
	                              "\n\t[%d]-Cod.Producto.......[%d] "
	                              "\n\t[%d]-Cod.TipCtoPlan.....[%s] "
	                              "\n\t[%d]-Cod.Moneda.........[%s] "
	                              "\n\t[%d]-Cod.CtoFac.........[%d] "
	                              "\n\t[%d]-Imp.Descuento......[%f] "
	                              "\n\t[%d]-Cod.TipoDto........[%d] "
	                              "\n\t[%d]-Ind.Cuadrante......[%d] "
	                              "\n\t[%d]-Cod.TipoCuad.......[%d] "
	                              "\n\t[%d]-Imp.Umbral Desde...[%f] "
	                              "\n\t[%d]-Imp.Umbral Hasta...[%f] "
	                              "\n\t[%d]-Num.Dias...........[%d] "
	                              ,LOG06                    ,i,pCto->lCodCtoPlan
	                              ,i,pCto->iCodProducto     ,i,pCto->szCodTipCtoPlan
	                              ,i,pCto->szCodMoneda      ,i,pCto->iCodCtoFac
	                              ,i,pCto->dImpDescuento    ,i,pCto->iCodTipoDto
	                              ,i,pCto->iIndCuadrante    ,i,pCto->iCodTipoCuad
	                              ,i,pCto->dImpUmbDesde
	                              ,i,pCto->dImpUmbHasta     ,i,pCto->iNumDias);

	       pCto++;
	  }
	}
}/*********************** Final vPrintCtoPlan ********************************/

/*****************************************************************************/
/*                        funcion : bCargaCtoPlan                            */
/*****************************************************************************/
BOOL bCargaCtoPlan (CTOPLAN *pCto,int *iNumCto)
{
  int rc = 0, iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenCtoPlan ())
      bRes = FALSE;

  while (iCont<MAX_CTOPLAN && bRes)
  {
         rc = iFetchCtoPlan (&pCto[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumCto = iCont;
  if (rc == SQLNOTFOUND && *iNumCto >= 0 && *iNumCto <=MAX_CTOPLAN)
  {
      qsort (pCto,*iNumCto,sizeof(CTOPLAN),iCmpCtoPlan);
      bRes = TRUE;
      vPrintCtoPlan (pCto,*iNumCto);
  }
  if (rc == 0 && *iNumCto == MAX_CTOPLAN)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ve_CtoPlan");
      bRes = FALSE;
  }
 return (bRes && iCloseCtoPlan () == 0)?TRUE:FALSE;

}/************************ Final bCargaCtoPlan *******************************/


/*****************************************************************************/
/*                        funcion : iOpenCuadCtoPlan                         */
/*****************************************************************************/
static int iOpenCuadCtoPlan (void)
{
 /* EXEC SQL DECLARE Cur_CuadCtoPlan CURSOR FOR
      SELECT /o+ FULL (VE_CUADCTOPLAN) o/
             COD_CTOPLAN  ,
             IMP_UMBDESDE ,
             IMP_UMBHASTA ,
             IMP_DESCUENTO,
             COD_TIPODTO
      FROM   VE_CUADCTOPLAN; */ 


 /* EXEC SQL OPEN Cur_CuadCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 29;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0024;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1984;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 if (SQLCODE)
     iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ve_CuadCtoPlan",
              szfnORAerror());

 return SQLCODE;
}/*********************** Final iOpenCuadCtoPlan *****************************/

/*****************************************************************************/
/*                      funcion : iFetchCuadCtoPlan                          */
/*****************************************************************************/
static int iFetchCuadCtoPlan (CUADCTOPLAN *pCuad)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhCodCtoPlan ;
  static double dhImpUmbDesde;
  static double dhImpUmbHasta;
  static double dhImpDescuento;
  static short  shCodTipoDto ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  /* EXEC SQL FETCH Cur_CuadCtoPlan INTO :lhCodCtoPlan  ,
                                      :dhImpUmbDesde ,
                                      :dhImpUmbHasta ,
                                      :dhImpDescuento,
                                      :shCodTipoDto  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1999;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCtoPlan;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhImpUmbDesde;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&dhImpUmbHasta;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImpDescuento;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&shCodTipoDto;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ve_CuadCtoPlan",
               szfnORAerror());
  if (SQLCODE == 0)
  {
      pCuad->lCodCtoPlan  = lhCodCtoPlan  ;
      pCuad->dImpUmbDesde = dhImpUmbDesde ;
      pCuad->dImpUmbHasta = dhImpUmbHasta ;
      pCuad->dImpDescuento= dhImpDescuento;
      pCuad->iCodTipoDto  = shCodTipoDto  ;
  }

  return SQLCODE;
}/********************** Final iFetchCuadCtoPlan *****************************/

/*****************************************************************************/
/*                      funcion : iCloseCuadCtoPlan                          */
/*****************************************************************************/
static int iCloseCuadCtoPlan (void)
{
  /* EXEC SQL CLOSE Cur_CuadCtoPlan; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2034;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ve_CuadCtoPlan",
               szfnORAerror());

  return SQLCODE;
}/********************* Final iCloseCuadCtoPlan ******************************/


/*****************************************************************************/
/*                        funcion : vPrintCuadCtoPlan                        */
/*****************************************************************************/
void vPrintCuadCtoPlan (CUADCTOPLAN *pCuad,int iNum)
{
  int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla VE_CUADCTOPLAN ***\n",LOG06);

	  for (i=0;i<iNum;i++)
	  {
	      vDTrazasLog (szExeName,
	      			   "\n\t[%d]-Cod.CtoPlan..........[%ld]"
					   "\n\t[%d]-Imp.Umbral Desde.....[%f]"
					   "\n\t[%d]-Imp.Umbral Hasta.....[%f]"
					   "\n\t[%d]-Imp.Descuento........[%f]"
					   "\n\t[%d]-Cod.Tipo Descuento...[%d]"
	                   ,LOG06,i,pCuad->lCodCtoPlan
	                   ,i,pCuad->dImpUmbDesde,i,pCuad->dImpUmbHasta
	                   ,i,pCuad->dImpDescuento,i,pCuad->iCodTipoDto  );
	      pCuad++;
	  }
	}
}/********************* Final vPrintCuadCtoPlan ******************************/


/*****************************************************************************/
/*                      funcion : bCargaCuadCtoPlan                          */
/*****************************************************************************/
BOOL bCargaCuadCtoPlan (CUADCTOPLAN *pCuad,int *iNumCuad)
{
  int rc = 0, iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenCuadCtoPlan ())
      bRes = FALSE;

  while (iCont<MAX_CUADCTOPLAN && bRes)
  {
         rc = iFetchCuadCtoPlan (&pCuad[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumCuad = iCont;
  if (rc == SQLNOTFOUND && *iNumCuad >= 0 && *iNumCuad <=MAX_CUADCTOPLAN)
  {
      if (*iNumCuad != 0)
      {
          qsort (pCuad,*iNumCuad,sizeof(CUADCTOPLAN),iCmpCuadCtoPlan);
          vPrintCuadCtoPlan (pCuad,*iNumCuad);
      }
      bRes = TRUE;
  }
  if (rc == 0 && *iNumCuad == MAX_CUADCTOPLAN)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ve_CuadCtoPlan");
      bRes = FALSE;
  }
  return (bRes && iCloseCuadCtoPlan () == 0)?TRUE:FALSE;
}/************************* Final bCargaCuadCtoPlan **************************/


/*****************************************************************************/
/*                         funcion : iOpenAnomalias                          */
/*****************************************************************************/
static int iOpenAnomalias (void)
{
  /* EXEC SQL DECLARE Cur_Anomalias CURSOR FOR
       SELECT /o+ FULL (FA_ANOMALIAS) o/
              COD_ANOMALIA,
              DES_ANOMALIA,
              IND_GRAVEDAD
       FROM   FA_ANOMALIAS; */ 


  /* EXEC SQL OPEN Cur_Anomalias; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0025;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2049;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_Anomalias",
               szfnORAerror());

  return SQLCODE;

}/************************* Final iOpenAnomalias *****************************/


/*****************************************************************************/
/*                         funcion : iFetchAnomalias                         */
/*****************************************************************************/
static int iFetchAnomalias (ANOMALIAS *pAnom)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodAnomalia ;
  static char* szhDesAnomalia; /* EXEC SQL VAR szhDesAnomalia IS STRING(101); */ 

  static int   ihIndGravedad ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhDesAnomalia = pAnom->szDesAnomalia;

  /* EXEC SQL FETCH Cur_Anomalias INTO :ihCodAnomalia ,
                                    :szhDesAnomalia,
                                    :ihIndGravedad ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2064;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodAnomalia;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesAnomalia;
  sqlstm.sqhstl[1] = (unsigned long )101;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihIndGravedad;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_Anomalias",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pAnom->iCodAnomalia = ihCodAnomalia;
      pAnom->iIndGravedad = ihIndGravedad;
  }

  return SQLCODE;
}/************************* Final iFetchAnomalias ****************************/

/*****************************************************************************/
/*                        funcion : iCloseAnomalias                          */
/*****************************************************************************/
static int iCloseAnomalias (void)
{
  /* EXEC SQL CLOSE Cur_Anomalias; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2091;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_Anomalias",
               szfnORAerror());
  return SQLCODE;
}/************************ Final iCloseAnomalias *****************************/



/*****************************************************************************/
/*                        funcion : bCargaAnomalias                          */
/*****************************************************************************/
BOOL bCargaAnomalias (ANOMALIAS *pAnom, int *iNumAnom)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenAnomalias ())
      bRes = FALSE;

  while (iCont<MAX_ANOMALIAS && bRes)
  {
         rc = iFetchAnomalias (&pAnom[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumAnom = iCont;
  if (rc == SQLNOTFOUND && *iNumAnom >= 0 && *iNumAnom <=MAX_ANOMALIAS)
  {
      if (*iNumAnom != 0)
      {
          qsort (pAnom,*iNumAnom,sizeof(ANOMALIAS),iCmpAnomalias);
          /* vPrintAnomalias (pAnom,*iNumAnom); */
      }
      bRes = TRUE;
  }
  if (rc == 0 && *iNumAnom == MAX_ANOMALIAS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_Anomalias");
      bRes = FALSE;
  }
  return (bRes && iCloseAnomalias () == 0)?TRUE:FALSE;

}/*********************** Final bCargaAnomalias ******************************/

/*****************************************************************************/
/*                            funcion : bOpenLetras                          */
/*****************************************************************************/
static int iOpenLetras (void)
{
  /* EXEC SQL DECLARE Cur_Letras CURSOR FOR
       SELECT /o+ FULL(GE_LETRAS) o/
              COD_TIPDOCUM  ,
              COD_CATIMPOS  ,
              LETRA
       FROM   GE_LETRAS; */ 


 /* EXEC SQL OPEN Cur_Letras; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 29;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0026;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2106;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 if (SQLCODE)
     iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Letras",
              szfnORAerror());

 return SQLCODE;
}/************************ Final bOpenLetras *********************************/

/*****************************************************************************/
/*                          funcion : iFetchLetras                           */
/*****************************************************************************/
static int iFetchLetras (LETRAS *pLetra)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodCatImpos;
  static int   ihCodTipDocum;
  static char* szhLetra     ; /* EXEC SQL VAR szhLetra   IS STRING(2) ; */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhLetra   = pLetra->szLetra;

  /* EXEC SQL FETCH Cur_Letras INTO :ihCodTipDocum,
                                 :ihCodCatImpos,
                                 :szhLetra; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2121;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCatImpos;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Letras",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pLetra->iCodTipDocum = ihCodTipDocum;
      pLetra->iCodCatImpos = ihCodCatImpos;
  }
  return SQLCODE;
}/************************ Final iFetchLetras ********************************/


/*****************************************************************************/
/*                        funcion : iCloseLetra                              */
/*****************************************************************************/
static int iCloseLetras (void)
{
   /* EXEC SQL CLOSE Cur_Letras; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2148;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Letras",
                szfnORAerror());

   return SQLCODE;
}/*********************** Final iCloseLetra **********************************/


/*****************************************************************************/
/*                         funcion : bCargaLetras                            */
/*****************************************************************************/
BOOL bCargaLetras (LETRAS *pLet,int *iNumLetra)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenLetras ())
      bRes = FALSE;

  while (iCont<MAX_LETRAS && bRes)
  {
         rc = iFetchLetras (&pLet[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumLetra = iCont;
  if (rc == SQLNOTFOUND && *iNumLetra >= 0 && *iNumLetra <=MAX_LETRAS)
  {
      qsort (pLet,*iNumLetra,sizeof(LETRAS),iCmpLetras);
      vPrintLetras (pLet,*iNumLetra);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumLetra == MAX_LETRAS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Letras");
      bRes = FALSE;
  }
  return (bRes && iCloseLetras () == 0)?TRUE:FALSE;

}/*********************** Final bCargaLetras *********************************/

/*****************************************************************************/
/*                        funcion : iOpenDocumSucursal                       */
/*****************************************************************************/
static int iOpenDocumSucursal (void)
{
  /* EXEC SQL DECLARE Cur_DocumSucursal CURSOR FOR
       SELECT /o+ FULL (AL_DOCUM_SUCURSAL) o/
              COD_OFICINA ,
              COD_TIPDOCUM,
              COD_CENTREMI
      FROM    AL_DOCUM_SUCURSAL; */ 


  /* EXEC SQL OPEN Cur_DocumSucursal; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0027;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2163;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Al_Docum_Sucursal",
               szfnORAerror());

  return SQLCODE;
}/*********************** Final iOpenDocumSucursal ***************************/

/*****************************************************************************/
/*                       funcion : iFetchDocunSucursal                       */
/*****************************************************************************/
static int iFetchDocumSucursal (DOCUMSUCURSAL *pDoc)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhCodOficina; /* EXEC SQL VAR szhCodOficina IS STRING(3) ; */ 

  static int    ihCodTipDocum;
  static int    ihCodCentrEmi;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodOficina = pDoc->szCodOficina;

  /* EXEC SQL FETCH Cur_DocumSucursal INTO :szhCodOficina      ,
                                        :ihCodTipDocum      ,
                                        :ihCodCentrEmi      ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2178;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodOficina;
  sqlstm.sqhstl[0] = (unsigned long )3;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentrEmi;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Al_Docum_Sucursal",
               szfnORAerror());

  if (SQLCODE == 0)
  {
      pDoc->iCodTipDocum = ihCodTipDocum;
      pDoc->iCodCentrEmi = ihCodCentrEmi;
  }
  return SQLCODE;
}/********************** Final iFetchDocumSucursal ***************************/

/*****************************************************************************/
/*                        funcion : iCloseDocumSucursal                      */
/*****************************************************************************/
static int iCloseDocumSucursal (void)
{
  /* EXEC SQL CLOSE Cur_DocumSucursal; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2205;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Al_Docum_Sucursal",
               szfnORAerror());
  return SQLCODE;
}/********************* Final iCloseDocumSucursal ****************************/


/*****************************************************************************/
/*                       funcion : bCargaDocumSucursal                       */
/*****************************************************************************/
BOOL bCargaDocumSucursal (DOCUMSUCURSAL *pDoc,int *iNumDoc)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenDocumSucursal ())
      bRes = FALSE;

  while (iCont<MAX_DOCUMSUCURSAL && bRes)
  {
         rc = iFetchDocumSucursal (&pDoc[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumDoc = iCont;
  if (rc == SQLNOTFOUND && *iNumDoc >= 0 && *iNumDoc <=MAX_DOCUMSUCURSAL)
  {
      qsort (pDoc,*iNumDoc,sizeof(DOCUMSUCURSAL),iCmpDocumSucursal);
      vPrintDocumSucursal (pDoc,*iNumDoc);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumDoc == MAX_DOCUMSUCURSAL)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Al_Docum_Sucursal");
      bRes = FALSE;
  }
  return (bRes && iCloseDocumSucursal () == 0)?TRUE:FALSE;

}/*********************** Final bCargaDocumSucursal **************************/

/*****************************************************************************/
/*                        funcion : iOpenActuaServ                           */
/*****************************************************************************/
static int iOpenActuaServ (void)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhCodActabo; /* EXEC SQL VAR szhCodActabo IS STRING(3) ; */ 

  static int    ihCodProd = 1 ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


	sprintf(szhCodActabo,"FA");

  /* EXEC SQL DECLARE Cur_ActuaServ CURSOR FOR
       SELECT /o+ full (GA_ACTUASERV) o/
              COD_TIPSERV ,
              COD_SERVICIO,
              COD_CONCEPTO
         FROM GA_ACTUASERV
        WHERE COD_PRODUCTO = :ihCodProd
          AND COD_ACTABO   = :szhCodActabo; */ 


  /* EXEC SQL OPEN Cur_ActuaServ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0028;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2220;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProd;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodActabo;
  sqlstm.sqhstl[1] = (unsigned long )3;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ga_ActuaServ",
               szfnORAerror ());

  return SQLCODE;
}/*********************** Final iOpenAcutaServ *******************************/

/*****************************************************************************/
/*                         funcion : iFetchActuaServ                         */
/*****************************************************************************/
static int iFetchActuaServ (ACTUASERV *pAct)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhCodTipServ  ; /* EXEC SQL VAR szhCodTipServ  IS STRING(2) ; */ 

  static char*  szhCodServicio ; /* EXEC SQL VAR szhCodServicio IS STRING(4) ; */ 

  static short  i_shCodConcepto;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodTipServ = pAct->szCodTipServ ;
  szhCodServicio= pAct->szCodServicio;

  /* EXEC SQL FETCH Cur_ActuaServ INTO :szhCodTipServ ,
                                    :szhCodServicio,
                                    :ihCodConcepto:i_shCodConcepto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2243;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipServ;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodServicio;
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)&i_shCodConcepto;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ga_ActuaServ",
               szfnORAerror());

  if (SQLCODE == SQLOK)
  {
      pAct->iCodConcepto= (i_shCodConcepto == ORA_NULL)?ORA_NULL:ihCodConcepto;
  }
  return SQLCODE;
}/************************ Final iFetchActuaServ *****************************/

/*****************************************************************************/
/*                         funcion : iCloseActuaServ                         */
/*****************************************************************************/
static int iCloseActuaServ (void)
{
   /* EXEC SQL CLOSE Cur_ActuaServ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2270;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ga_ActuaServ",
                szfnORAerror());

   return SQLCODE;
}/************************ Final iCloseActuaServ *****************************/


/*****************************************************************************/
/*                         funcion : iCmpActuaServ                           */
/*****************************************************************************/
int iCmpActuaServ (const void* cad1, const void* cad2)
{
   int rc = 0;
   return
    ( (rc = strcmp ( ((ACTUASERV *)cad1)->szCodTipServ,
                     ((ACTUASERV *)cad2)->szCodTipServ) ) != 0)?rc:
    ( (rc = strcmp ( ((ACTUASERV *)cad1)->szCodServicio,
                     ((ACTUASERV *)cad2)->szCodServicio)) != 0)?rc:0;
}/************************* Final iCmpActuaServ ******************************/

/*****************************************************************************/
/*                         funcion : vPrintActuaServ                         */
/*****************************************************************************/
void vPrintActuaServ (ACTUASERV *pAct,int iNumAct)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla GA_ACTUASERV ***\n",LOG06);

	  for (iInd=0;iInd<iNumAct;iInd++)
	  {
	       vDTrazasLog  (szExeName, "\n\t[%d]-Cod.TipServ.....[%s]"
						 			"\n\t[%d]-Cod.Servicio....[%s]"
						 			"\n\t[%d]-Cod.Concepto....[%d]"
	                    			,LOG06, iInd,pAct->szCodTipServ
	                    			,iInd,pAct->szCodServicio
	                    			,iInd,pAct->iCodConcepto  );
	       pAct++;
	  }
	}
}/************************ Final vPrintActuaServ *****************************/

/*****************************************************************************/
/*                       funcion : bCargaActuaServ                           */
/*****************************************************************************/
BOOL bCargaActuaServ (ACTUASERV *pAct,int *iNumAct)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenActuaServ ())
      bRes = FALSE;

  while (iCont<MAX_ACTUASERV && bRes)
  {
         rc = iFetchActuaServ (&pAct[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumAct = iCont;
  if (rc == SQLNOTFOUND && *iNumAct >= 0 && *iNumAct <=MAX_ACTUASERV)
  {
      qsort (pAct,*iNumAct,sizeof(ACTUASERV),iCmpActuaServ);
      vPrintActuaServ (pAct,*iNumAct);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumAct == MAX_ACTUASERV)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ga_ActuaServ");
      bRes = FALSE;
  }
  return (bRes && iCloseActuaServ () == 0)?TRUE:FALSE;

}/*********************** Final bCargaActuaServ     **************************/

/*****************************************************************************/
/*                        funcion : iOpenTaPlanTarif                         */
/*****************************************************************************/
int iOpenPlanTarif (char *szFecEmision)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static char szhFecEmision[15];
    /* EXEC SQL END DECLARE SECTION  ; */ 


	strcpy (szhFecEmision, szFecEmision);

  	/* EXEC SQL DECLARE Cur_PlanTarif CURSOR FOR
      SELECT /o+ full (TA_PLANTARIF) o/
            COD_PLANTARIF   ,
            TIP_TERMINAL    ,
            COD_LIMCONSUMO  ,
            COD_CARGOBASICO ,
            TIP_PLANTARIF   ,
            TIP_UNIDADES    ,
            NUM_UNIDADES    ,
            IND_ARRASTRE    ,
            NUM_DIAS        ,
            NUM_ABONADOS    ,
            IND_FRANCONS    ,
            FLG_RANGO       ,
            TO_CHAR(NVL(IND_COMPARTIDO,0)),     /o P-MIX-09003 o/
            DECODE(NVL(TIP_COBRO,'V'),'A',1,0)  /o P-MIX-09003 o/
       FROM TA_PLANTARIF
	    WHERE  COD_PRODUCTO = 1; */ 


  /* EXEC SQL OPEN Cur_PlanTarif; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0029;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2285;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ta_PlanTarif",
               szfnORAerror ());

  return SQLCODE;
}/*********************** Final iOpenPlanTarif *******************************/

/*****************************************************************************/
/*                        funcion : iFetchPlanTarif                          */
/*****************************************************************************/
static int iFetchPlanTarif (PLANTARIF *pPlan)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char* szhCodPlanTarif  ;/* EXEC SQL VAR szhCodPlanTarif    IS STRING(4) ; */ 

  static char* szhTipTerminal   ;/* EXEC SQL VAR szhTipTerminal     IS STRING(2) ; */ 

  static char* szhCodLimConsumo ;/* EXEC SQL VAR szhCodLimConsumo   IS STRING(4) ; */ 

  static char* szhCodCargoBasico;/* EXEC SQL VAR szhCodCargoBasico  IS STRING(4) ; */ 

  static char* szhTipPlanTarif  ;/* EXEC SQL VAR szhTipPlanTarif    IS STRING(2) ; */ 

  static char* szhTipUnidades   ;/* EXEC SQL VAR szhTipUnidades     IS STRING(2) ; */ 

  static char* szhIndCompartido ;/* EXEC SQL VAR szhIndCompartido   IS STRING(2) ; */ 
  /* P-MIX-09003 */
  static int   ihTipCobro       ;                                                /* P-MIX-09003 */
  static long  lhNumUnidades    ;
  static short shIndArrastre    ;
  static int   ihNumDias        ;
  static char* szhInd_Francons  ;/* EXEC SQL VAR szhInd_Francons    IS STRING(2); */ 

  static short shFlgRango       ;
  static short i_shTipTerminal  ;
  static long  lhNumAbonados	;
  static short i_shNumAbonados	;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodPlanTarif  = pPlan->szCodPlanTarif  ;
  szhTipTerminal   = pPlan->szTipTerminal   ;
  szhCodLimConsumo = pPlan->szCodLimConsumo ;
  szhCodCargoBasico= pPlan->szCodCargoBasico;
  szhTipPlanTarif  = pPlan->szTipPlanTarif  ;
  szhTipUnidades   = pPlan->szTipUnidades   ;
  szhInd_Francons  = pPlan->szInd_Francons  ;
  szhIndCompartido = pPlan->szIndCompartido ;  /* P-MIX-09003 */

  /* EXEC SQL FETCH Cur_PlanTarif INTO :szhCodPlanTarif               ,
                                    :szhTipTerminal:i_shTipTerminal,
                                    :szhCodLimConsumo              ,
                                    :szhCodCargoBasico             ,
                                    :szhTipPlanTarif               ,
                                    :szhTipUnidades                ,
                                    :lhNumUnidades                 ,
                                    :shIndArrastre                 ,
                                    :ihNumDias                     ,
                                    :lhNumAbonados:i_shNumAbonados ,
                                    :szhInd_Francons               ,
                                    :shFlgRango                    ,
                                    :szhIndCompartido              ,
                                    :ihTipCobro                    ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2300;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[1] = (unsigned long )2;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)&i_shTipTerminal;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodLimConsumo;
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodCargoBasico;
  sqlstm.sqhstl[3] = (unsigned long )4;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhTipPlanTarif;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhTipUnidades;
  sqlstm.sqhstl[5] = (unsigned long )2;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumUnidades;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&shIndArrastre;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihNumDias;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonados;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)&i_shNumAbonados;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhInd_Francons;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)&shFlgRango;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhIndCompartido;
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&ihTipCobro;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ta_PlanTarif",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pPlan->lNumUnidades = lhNumUnidades;
      pPlan->iIndArrastre = shIndArrastre;
      pPlan->lNumAbonados = (i_shNumAbonados==ORA_NULL)?ORA_NULL:lhNumAbonados;
      pPlan->iFlgRango    = shFlgRango;
      if (i_shTipTerminal == ORA_NULL)
          strcpy (pPlan->szTipTerminal,"");
      pPlan->iTipCobro    = ihTipCobro;
  }
  return SQLCODE;

}/************************ Final iFetchPlanTarif *****************************/


/*****************************************************************************/
/*                        funcion : iClosePlanTarif                          */
/*****************************************************************************/
static int iClosePlanTarif (void)
{
   /* EXEC SQL CLOSE Cur_PlanTarif; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2371;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ta_PlanTarif",
                szfnORAerror());

   return SQLCODE;
}/************************* Final iClosePlanTarif ****************************/

/*****************************************************************************/
/*                         funcion : iCmpPlanTarif                           */
/*****************************************************************************/
int iCmpPlanTarif (const void* cad1,const void* cad2)
{
   int rc = 0;

   return ( (rc = strcmp ( ((PLANTARIF *)cad1)->szCodPlanTarif,
                     ((PLANTARIF *)cad2)->szCodPlanTarif) ) != 0)?rc:0;
}/************************* Final iCmpPlanTarif ******************************/


/*****************************************************************************/
/*                          funcion : vPrintPlanTarif                        */
/*****************************************************************************/
void vPrintPlanTarif (PLANTARIF *pPlan,int iNumPlan)
{
   int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	   vDTrazasLog (szExeName,"\n\t*** Tabla TA_PLANTARIF ***\n",LOG06);

	   for (iInd=0;iInd<iNumPlan;iInd++)
	   {
	        vDTrazasLog (szExeName,"\n\t[%d]-Cod.PlanTarif....[%s] "
	                               "\n\t[%d]-Tip.Terminal.....[%s] "
	                               "\n\t[%d]-Cod.LimConsumo...[%s] "
	                               "\n\t[%d]-Cod.CargoBasico..[%s] "
	                               "\n\t[%d]-Tip.PlanTarif....[%s] "
	                               "\n\t[%d]-Tip.Unidades.....[%s] "
	                               "\n\t[%d]-Num.Unidades.....[%ld]"
	                               "\n\t[%d]-Ind.Arrastre.....[%d] "
	                               "\n\t[%d]-Num.Dias.........[%d] "
	                               "\n\t[%d]-Num.Abonados.....[%ld]"
	                               "\n\t[%d]-Ind.Compartido...[%s]"	                               
	                               ,LOG06
	                               ,iInd,pPlan->szCodPlanTarif  ,iInd,pPlan->szTipTerminal
	                               ,iInd,pPlan->szCodLimConsumo ,iInd,pPlan->szCodCargoBasico
	                               ,iInd,pPlan->szTipPlanTarif  ,iInd,pPlan->szTipUnidades
	                               ,iInd,pPlan->lNumUnidades    ,iInd,pPlan->iIndArrastre
	                               ,iInd,pPlan->iNumDias        ,iInd,pPlan->lNumAbonados
	                               ,iInd,pPlan->szIndCompartido);
	        pPlan++;
	   }
	}
}/************************* Final vPrintPlanTarif ****************************/

/*****************************************************************************/
/*                       funcion : bCargaPlanTarif                           */
/*****************************************************************************/
BOOL bCargaPlanTarif (PLANTARIF *pPlan,int *iNumPlan)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenPlanTarif (stCiclo.szFecEmision))
      bRes = FALSE;

  while (iCont<MAX_PLANTARIF && bRes)
  {
         rc = iFetchPlanTarif (&pPlan[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumPlan = iCont;
  if (rc == SQLNOTFOUND && *iNumPlan >= 0 && *iNumPlan <=MAX_PLANTARIF)
  {
      qsort (pPlan,*iNumPlan,sizeof(PLANTARIF),iCmpPlanTarif);
      vPrintPlanTarif (pPlan,*iNumPlan);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumPlan == MAX_PLANTARIF)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ta_PlanTarif");
      bRes = FALSE;
  }
  return (bRes && iClosePlanTarif () == 0)?TRUE:FALSE;

}/*********************** Final bCargaPlanTarif ******************************/


/*****************************************************************************/
/*                          funcion : iOpenCargosBasico                      */
/*****************************************************************************/
static int iOpenCargosBasico (char *pszFecEmision)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static char szhFecEmision[15];
    /* EXEC SQL END DECLARE SECTION  ; */ 


  strcpy (szhFecEmision, pszFecEmision);

  /* EXEC SQL DECLARE Cur_CargosBasico CURSOR FOR
       SELECT /o+ full (TA_CARGOSBASICO) o/
              COD_CARGOBASICO,
              IMP_CARGOBASICO,
              COD_MONEDA
         FROM TA_CARGOSBASICO
	    WHERE TO_DATE (:szhFecEmision, 'YYYYMMDDHH24MISS') >= FEC_DESDE
	      AND TO_DATE (:szhFecEmision, 'YYYYMMDDHH24MISS') <= NVL(FEC_HASTA, TO_DATE ('30000101000000', 'YYYYMMDDHH24MISS'))
	      AND COD_PRODUCTO = 1; */ 

       
  /* EXEC SQL OPEN Cur_CargosBasico; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0030;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2386;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecEmision;
  sqlstm.sqhstl[0] = (unsigned long )15;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmision;
  sqlstm.sqhstl[1] = (unsigned long )15;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ta_CargosBasico",
               szfnORAerror());
  return SQLCODE;
}/************************* Final iOpenCargosBasico **************************/

/*****************************************************************************/
/*                         funcion : iFetchCargosBasico                      */
/*****************************************************************************/
static int iFetchCargosBasico (CARGOSBASICO *pCar)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhCodCargoBasico;/* EXEC SQL VAR szhCodCargoBasico IS STRING(4) ; */ 

  static double dhImpCargoBasico ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodCargoBasico = pCar->szCodCargoBasico;
  szhCodMoneda      = pCar->szCodMoneda     ;

  /* EXEC SQL FETCH Cur_CargosBasico INTO :szhCodCargoBasico       ,
                                       :dhImpCargoBasico        ,
                                       :szhCodMoneda            ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2409;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodCargoBasico;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhImpCargoBasico;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ta_CargosBasico",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pCar->dImpCargoBasico= dhImpCargoBasico;
  }
  return SQLCODE;
}/************************* Final iFetchCargosBasico *************************/


/*****************************************************************************/
/*                          funcion : iCloseCargosBasico                     */
/*****************************************************************************/
static int iCloseCargosBasico (void)
{
  /* EXEC SQL CLOSE Cur_CargosBasico; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2436;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ta_CargosBasico",
               szfnORAerror());

  return SQLCODE;
}/************************* Final iCloseCargosBasico *************************/

/*****************************************************************************/
/*                          funcion : iCmpCargosBasico                       */
/*****************************************************************************/
int iCmpCargosBasico (const void* cad1,const void* cad2)
{
  int rc = 0;

  return ( (rc = strcmp ( ((CARGOSBASICO *)cad1)->szCodCargoBasico,
                    ((CARGOSBASICO *)cad2)->szCodCargoBasico) ) != 0)?rc:0;
}/************************* Final iCmpCargosBasico ***************************/

/*****************************************************************************/
/*                          funcion : vPrintCargosBasico                     */
/*****************************************************************************/
void vPrintCargosBasico (CARGOSBASICO *pCar,int iNumCar)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla TA_CARGOSBASICO ***",LOG06);
	  for (iInd=0;iInd<iNumCar;iInd++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d]-Cod.CargoBasico....[%s] "
	                              "\n\t[%d]-Imp.CargoBasico....[%f] "
	                              "\n\t[%d]-Cod. Moneda........[%s] "
	                              ,LOG06, iInd,pCar->szCodCargoBasico 
	                              ,iInd,pCar->dImpCargoBasico ,iInd,pCar->szCodMoneda );

	       pCar++;
	  }
	}
}/************************ Final vPrintCargosBasico **************************/

/*****************************************************************************/
/*                       funcion : bCargaCargosBasico                        */
/*****************************************************************************/
BOOL bCargaCargosBasico (CARGOSBASICO *pCar,int *iNumCar)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenCargosBasico (stCiclo.szFecEmision))
      bRes = FALSE;

  while (iCont<MAX_CARGOSBASICO && bRes)
  {
         rc = iFetchCargosBasico (&pCar[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumCar = iCont;
  if (rc == SQLNOTFOUND && *iNumCar >= 0 && *iNumCar <=MAX_CARGOSBASICO)
  {
      qsort (pCar,*iNumCar,sizeof(CARGOSBASICO),iCmpCargosBasico);
      vPrintCargosBasico (pCar,*iNumCar);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumCar == MAX_CARGOSBASICO)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ta_CargosBasico");
      bRes = FALSE;
  }
  return (bRes && iCloseCargosBasico () == 0)?TRUE:FALSE;

}/*********************** Final bCargaCargosBasico ***************************/

/*****************************************************************************/
/*                          funcion : iOpenCargosRecurrentes                      */
/*****************************************************************************/
static int iOpenCargosRecurrentes (void)
{
  /* EXEC SQL DECLARE Cur_CargosRecurrentes CURSOR FOR
       SELECT 
	   COD_CARGO,
	   MONTO_IMPORTE,
	   COD_MONEDA
	FROM 
	PF_CARGOS_PRODUCTOS_TD
	ORDER BY COD_CARGO; */ 

  /* EXEC SQL OPEN Cur_CargosRecurrentes; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0031;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2451;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->PF_CARGOS_PRODUCTOS_TD",
               szfnORAerror());
  return SQLCODE;
}
/************************* Final iOpenCargosRecurrentes **************************/

/*****************************************************************************/
/*                         funcion : iFetchCargosRecurrentes                 */
/*****************************************************************************/
static int iFetchCargosRecurrentes (CARGOSRECURRENTES *pCarRec)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhCodCargo            ;
  static double dhMontoImporte        ;
  static char*  szhCodMoneda          ;/* EXEC SQL VAR szhCodMoneda      IS STRING(11) ; */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 



  szhCodMoneda      = pCarRec->szCodMoneda     ;

  /* EXEC SQL FETCH Cur_CargosRecurrentes INTO :lhCodCargo     ,
                                       	    :dhMontoImporte ,
                                       	    :szhCodMoneda   ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2466;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCargo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhMontoImporte;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[2] = (unsigned long )11;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->PF_CARGOS_PRODUCTOS_TD",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pCarRec->lCodCargo   = lhCodCargo ;
      pCarRec->dMontoImporte  = dhMontoImporte;
      strcpy(pCarRec->szCodMoneda,szhCodMoneda);
      
  }
  return SQLCODE;
}
/************************* Final iFetchCargosRecurrente *************************/

/*****************************************************************************/
/*                          funcion : iCloseCargosRecurrentes                     */
/*****************************************************************************/
static int iCloseCargosRecurrentes (void)
{
  /* EXEC SQL CLOSE Cur_CargosRecurrentes; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2493;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->PF_CARGOS_PRODUCTOS_TD",
               szfnORAerror());

  return SQLCODE;
}
/************************* Final iCloseCargosRecurrentes *************************/

/*****************************************************************************/
/*                          funcion : vPrintCargosRecurrentes                */
/*****************************************************************************/
void vPrintCargosRecurrentes (CARGOSRECURRENTES *pCar,int iNumCar)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla PF_CARGOS_PRODUCTOS_TD ***",LOG06);
	  for (iInd=0;iInd<iNumCar;iInd++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d]-Cod.Cargo.......[%d] "
	                              "\n\t[%d]-Cod.Moneda......[%s] "
	                              "\n\t[%d]-Monto Importe...[%lf] "
	                              ,LOG06
	                              ,iInd,pCar->lCodCargo
	                              ,iInd,pCar->szCodMoneda      
	                              ,iInd,pCar->dMontoImporte);

	       pCar++;
	  }
	}
}/********************** Final vPrintCargosRecurrentes ***********************/

/*****************************************************************************/
/*                       funcion : bCargaCargosRecurrentes                   */
/*****************************************************************************/
BOOL bCargaCargosRecurrentes (CARGOSRECURRENTES *pCar,int *iNumCar)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenCargosRecurrentes ())
      bRes = FALSE;

  while (iCont<MAX_CARGOSRECURRENTES && bRes)
  {
         rc = iFetchCargosRecurrentes (&pCar[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumCar = iCont;
  if (rc == SQLNOTFOUND && *iNumCar >= 0 && *iNumCar <=MAX_CARGOSRECURRENTES)
  {
      vPrintCargosRecurrentes (pCar,*iNumCar);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumCar == MAX_CARGOSRECURRENTES)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_dummy_cargos");
      bRes = FALSE;
  }
  return (bRes && iCloseCargosRecurrentes () == 0)?TRUE:FALSE;

}
/*********************** Final bCargaCargosRecurrentes **********************/

/*****************************************************************************/
/*                        funcion : iOpenGrupoCob                            */
/*****************************************************************************/
static int iOpenGrupoCob (int iCodCiclo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static int    ihCodCiclo   ;
    /* EXEC SQL END DECLARE SECTION  ; */ 


    ihCodCiclo = iCodCiclo;


      /* SELECT*/ /*+ full (FA_GRUPOCOB) */
      /*      COD_GRUPO   ,
              COD_PRODUCTO,
              COD_CONCEPTO,
              COD_CICLO   ,
              TIP_COBRO   ,
              FEC_DESDE   ,
              FEC_HASTA
         FROM FA_GRUPOCOB
        WHERE COD_CICLO = :ihCodCiclo;*/ /* P-MIX-09003 */
        
        
    /* EXEC SQL DECLARE Cur_GrupoCob CURSOR FOR        
         SELECT /o+ full (FA_GRUPOCOB)o/
                A.COD_GRUPO
               ,A.COD_PRODUCTO
               ,A.COD_CONCEPTO
               ,A.COD_CICLO
               ,NVL(B.TIP_COBRO,0)
               ,A.FEC_DESDE
               ,A.FEC_HASTA
         FROM  FA_GRUPOCOB A, 
               (SELECT COD_CONCEPTO, MAX(TIP_COBRO) TIP_COBRO 
                FROM   (SELECT COD_CONCEPTO, MAX(DECODE(NVL(TIP_COBRO,0),'A',1,0)) TIP_COBRO
                        FROM   PF_CONCEPTOS_PROD_TD
               GROUP BY COD_CONCEPTO                    
               union
               SELECT COD_CONCEPTO, MAX(DECODE(NVL(B.TIP_COBRO,0),'A',1,0)) TIP_COBRO
               FROM   GA_SERVSUPL B, GA_ACTUASERV C 
               WHERE  B.COD_SERVICIO = C.COD_SERVICIO GROUP BY COD_CONCEPTO)                                  
               GROUP BY COD_CONCEPTO) B
         WHERE A.COD_CICLO = :ihCodCiclo
         AND   A.COD_CONCEPTO = B.COD_CONCEPTO (+)
         ORDER BY A.COD_GRUPO, A.COD_CONCEPTO, A.COD_PRODUCTO, A.COD_CICLO; */ 
        
        
    /* EXEC SQL OPEN Cur_GrupoCob; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0032;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2508;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_GrupoCob",
                 szfnORAerror());

    return SQLCODE;
}/*********************** Final iOpenGrupoCob ********************************/

/*****************************************************************************/
/*                       funcion : iFetchGrupoCob                            */
/*****************************************************************************/
static int iFetchGrupoCob (GRUPOCOB *pGrp)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char*  szhCodGrupo  ; /* EXEC SQL VAR szhCodGrupo IS STRING(3) ; */ 

  static int    ihCodCiclo   ;
  static short  shTipCobro   ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhCodGrupo = pGrp->szCodGrupo;
  szhFecDesde = pGrp->szFecDesde;
  szhFecHasta = pGrp->szFecHasta;

  /* EXEC SQL FETCH Cur_GrupoCob INTO :szhCodGrupo   ,
                                   :shCodProducto ,
                                   :ihCodConcepto ,
                                   :ihCodCiclo    ,
                                   :shTipCobro    ,
                                   :szhFecDesde   ,
                                   :szhFecHasta   ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2527;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodGrupo;
  sqlstm.sqhstl[0] = (unsigned long )3;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&shCodProducto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCiclo;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&shTipCobro;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[5] = (unsigned long )15;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[6] = (unsigned long )15;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_GrupoCob",
               szfnORAerror());

  if (SQLCODE == SQLOK)
  {
      pGrp->iCodProducto = shCodProducto;
      pGrp->iCodConcepto = ihCodConcepto;
      pGrp->iCodCiclo    = ihCodCiclo   ;
      pGrp->iTipCobro    = shTipCobro   ;
  }
  return SQLCODE;
}/*********************** Final iFetchGrupoCob *******************************/

/*****************************************************************************/
/*                        funcion : iCloseGrupoCob                           */
/*****************************************************************************/
static int iCloseGrupoCob (void)
{
  /* EXEC SQL CLOSE Cur_GrupoCob; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2570;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_GrupoCob",
               szfnORAerror());

  return SQLCODE;
}/*********************** Final iCloseGrupoCob *******************************/

/*****************************************************************************/
/*                       funcion : bCargaGrupoCob                            */
/*****************************************************************************/
BOOL bCargaGrupoCob (GRUPOCOB *pGrp,int *iNumGrp, int iCodCiclo)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenGrupoCob (iCodCiclo))
      bRes = FALSE;

  while (iCont<MAX_GRUPOCOB && bRes)
  {
         rc = iFetchGrupoCob (&pGrp[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumGrp = iCont;

  if (rc == SQLNOTFOUND && *iNumGrp >= 0 && *iNumGrp <=MAX_GRUPOCOB)
  {
      qsort (pGrp,*iNumGrp,sizeof(GRUPOCOB),iCmpGrupoCob);
      vPrintGrupoCob (pGrp,*iNumGrp);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumGrp == MAX_GRUPOCOB)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_GrupoCob");
      bRes = FALSE;
  }
  return (bRes && iCloseGrupoCob () == 0)?TRUE:FALSE;

}/*********************** Final bCargaGrupoCob *******************************/

/*****************************************************************************/
/*                        funcion : iOpenCabCuotas                           */
/*****************************************************************************/
static int iOpenCabCuotas (int  iTipoFactura,
                           long lCodCliente ,
                           long lNumAbonado)
{
  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL DECLARE Cur_CabCuotas CURSOR FOR
           SELECT /o+ full (FA_CABCUOTAS) o/
                  ROWID       ,
                  SEQ_CUOTAS  ,
                  COD_CLIENTE ,
                  COD_CONCEPTO,
                  COD_MONEDA  ,
                  COD_PRODUCTO,
                  NUM_CUOTAS  ,
                  IMP_TOTAL   ,
                  IND_PAGADA  ,
                  NUM_ABONADO ,
                  COD_CUOTA   ,
                  NUM_PAGARE
            FROM  FA_CABCUOTAS; */ 

      /* EXEC SQL OPEN Cur_CabCuotas; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0033;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2585;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA)
  {
      vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Fa_CabCuotas"
                             "\n\t\t=> Cod.Cliente  [%ld]"
                             "\n\t\t=> Num.Abonado  [%ld]",LOG04,
                             lCodCliente,lNumAbonado);

      /* EXEC SQL DECLARE Cur_CabCuotasBaja CURSOR FOR
           SELECT /o+ index (FA_CABCUOTAS NUK_FA_CABCUOTAS_CLIENTE) o/
                  ROWID       ,
                  SEQ_CUOTAS  ,
                  COD_CLIENTE ,
                  COD_CONCEPTO,
                  COD_MONEDA  ,
                  COD_PRODUCTO,
                  NUM_CUOTAS  ,
                  IMP_TOTAL   ,
                  IND_PAGADA  ,
                  NUM_ABONADO ,
                  COD_CUOTA   ,
                  NUM_PAGARE
            FROM  FA_CABCUOTAS
            WHERE COD_CLIENTE = :lCodCliente
              AND NUM_ABONADO = :lNumAbonado; */ 


      /* EXEC SQL OPEN Cur_CabCuotasBaja; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0034;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2600;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lNumAbonado;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }


  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_CabCuotas",
               szfnORAerror());
  return SQLCODE;
}/************************ Final iOpenCabCuotas ******************************/


/*****************************************************************************/
/*                         funcion : iFetchCabCuotas                         */
/*****************************************************************************/
static int iFetchCabCuotas (CABCUOTAS *pCab,int iTipoFactura)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhSeqCuotas   ;
  static int    ihNumCuotas   ;
  static double dhImpTotal    ;
  static short  shIndPagada   ;
  static char*  szhCodCuota   ; /* EXEC SQL VAR szhCodCuota  IS STRING(3) ; */ 

  static long   lhNumPagare   ;
  static short  i_shCodCuota  ;
  static short  i_shNumPagare ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhRowid    = pCab->szRowid    ;
  szhCodMoneda= pCab->szCodMoneda;
  szhCodCuota = pCab->szCodCuota ;

  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL FETCH Cur_CabCuotas INTO :szhRowid                   ,
                                        :lhSeqCuotas                ,
                                        :lhCodCliente               ,
                                        :ihCodConcepto              ,
                                        :szhCodMoneda               ,
                                        :shCodProducto              ,
                                        :ihNumCuotas                ,
                                        :dhImpTotal                 ,
                                        :shIndPagada                ,
                                        :lhNumAbonado:i_shNumAbonado,
                                        :szhCodCuota:i_shCodCuota   ,
                                        :lhNumPagare:i_shNumPagare  ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2623;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhSeqCuotas;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhCodMoneda;
      sqlstm.sqhstl[4] = (unsigned long )4;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&shCodProducto;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&ihNumCuotas;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&dhImpTotal;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&shIndPagada;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)&i_shNumAbonado;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)szhCodCuota;
      sqlstm.sqhstl[10] = (unsigned long )3;
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)&i_shCodCuota;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)&lhNumPagare;
      sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)&i_shNumPagare;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA)
  {
      /* EXEC SQL FETCH Cur_CabCuotasBaja INTO
                                        :szhRowid                   ,
                                        :lhSeqCuotas                ,
                                        :lhCodCliente               ,
                                        :ihCodConcepto              ,
                                        :szhCodMoneda               ,
                                        :shCodProducto              ,
                                        :ihNumCuotas                ,
                                        :dhImpTotal                 ,
                                        :shIndPagada                ,
                                        :lhNumAbonado:i_shNumAbonado,
                                        :szhCodCuota:i_shCodCuota   ,
                                        :lhNumPagare:i_shNumPagare  ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2686;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhSeqCuotas;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhCodMoneda;
      sqlstm.sqhstl[4] = (unsigned long )4;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&shCodProducto;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&ihNumCuotas;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&dhImpTotal;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&shIndPagada;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)&i_shNumAbonado;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)szhCodCuota;
      sqlstm.sqhstl[10] = (unsigned long )3;
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)&i_shCodCuota;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)&lhNumPagare;
      sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)&i_shNumPagare;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_CabCuotas",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pCab->lSeqCuotas  = lhSeqCuotas  ;
      pCab->lCodCliente = lhCodCliente ;
      pCab->iCodConcepto= ihCodConcepto;
      pCab->iCodProducto= shCodProducto;
      pCab->iNumCuotas  = ihNumCuotas  ;
      pCab->dImpTotal   = dhImpTotal   ;
      pCab->iIndPagada  = shIndPagada  ;

      pCab->lNumAbonado = (i_shNumAbonado == ORA_NULL)?-1:lhNumAbonado;
      pCab->lNumPagare  = (i_shNumPagare  == ORA_NULL)?-1:lhNumPagare ;

      if (i_shCodCuota == ORA_NULL)
          strcpy (pCab->szCodCuota,"");
  }
  return SQLCODE;

}/************************* Final iFetchCabCuotas ****************************/

/*****************************************************************************/
/*                         funcion : iCloseCabCuotas                         */
/*****************************************************************************/
static int iCloseCabCuotas (int iTipoFactura)
{
  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL CLOSE Cur_CabCuotas; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2749;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA)
  {
      /* EXEC SQL CLOSE Cur_CabCuotasBaja; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2764;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_CabCuotas",
               szfnORAerror());

  return SQLCODE;
}/************************** Final iCloseCabCuotas ***************************/

/*****************************************************************************/
/*                           funcion : iCmpCabCuotas                         */
/*****************************************************************************/
int iCmpCabCuotas (const void* cad1,const void* cad2)
{
  int rc = 0;

  if ( ((CABCUOTAS *)cad1)->lSeqCuotas > ((CABCUOTAS *)cad2)->lSeqCuotas )
       rc =  1;
  if ( ((CABCUOTAS *)cad1)->lSeqCuotas < ((CABCUOTAS *)cad2)->lSeqCuotas )
       rc = -1;
  return rc;
}/************************** Final iCmpCabCuotas *****************************/

/*****************************************************************************/
/*                           funcion : bCargaCabCuotas                       */
/*****************************************************************************/
BOOL bCargaCabCuotas (CABCUOTAS *pCab        ,
                      int       *iNumCab     ,
                      int        iTipoFactura,
                      long       lCodCliente ,
                      long       lNumAbonado)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenCabCuotas (iTipoFactura,lCodCliente,lNumAbonado))
      bRes = FALSE;

  while (iCont<MAX_CABCUOTAS && bRes)
  {
         rc = iFetchCabCuotas (&pCab[iCont],iTipoFactura);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumCab = iCont;
  if (rc == SQLNOTFOUND && *iNumCab >= 0 && *iNumCab <=MAX_CABCUOTAS)
  {
      qsort (pCab,*iNumCab,sizeof(CABCUOTAS),iCmpCabCuotas);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumCab == MAX_CABCUOTAS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_CabCuotas");
      bRes = FALSE;
  }
  return (bRes && iCloseCabCuotas (iTipoFactura) == 0)?TRUE:FALSE;

}/*************************** Final bCargaCabCuotas **************************/

/*****************************************************************************/
/*                           funcion : iOpenCuotas                           */
/*****************************************************************************/
int iOpenCuotas (int iTipoFactura,long lSeqCuotas)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long lhSeqCuotas;
  /* EXEC SQL END DECLARE SECTION; */ 


  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL DECLARE Cur_Cuotas CURSOR FOR
           SELECT /o+ full(FA_CUOTAS) o/
                  ROWID                                   ,
                  SEQ_CUOTAS                              ,
                  ORD_CUOTA                               ,
                  TO_CHAR (FEC_EMISION,'YYYYMMDDHH24MISS'),
                  IMP_CUOTA                               ,
                  IND_FACTURADO                           ,
                  IND_PAGADO
           FROM   FA_CUOTAS; */ 


      /* EXEC SQL OPEN Cur_Cuotas; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0035;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2779;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA)
  {
      lhSeqCuotas = lSeqCuotas;

      vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Fa_Cuotas"
                             "\n\t\t=> Seq.Cuotas [%ld]\n",LOG04,lhSeqCuotas);

      /* EXEC SQL DECLARE Cur_CuotasBaja CURSOR FOR
           SELECT /o+ index (FA_CUOTAS PK_FA_CUOTAS) o/
                  ROWID                                   ,
                  SEQ_CUOTAS                              ,
                  ORD_CUOTA                               ,
                  TO_CHAR (FEC_EMISION,'YYYYMMDDHH24MISS'),
                  IMP_CUOTA                               ,
                  IND_FACTURADO                           ,
                  IND_PAGADO
           FROM   FA_CUOTAS
           WHERE  SEQ_CUOTAS = :lhSeqCuotas; */ 


     /* EXEC SQL OPEN Cur_CuotasBaja; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 29;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0036;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2794;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhSeqCuotas;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqphsv = sqlstm.sqhstv;
     sqlstm.sqphsl = sqlstm.sqhstl;
     sqlstm.sqphss = sqlstm.sqhsts;
     sqlstm.sqpind = sqlstm.sqindv;
     sqlstm.sqpins = sqlstm.sqinds;
     sqlstm.sqparm = sqlstm.sqharm;
     sqlstm.sqparc = sqlstm.sqharc;
     sqlstm.sqpadto = sqlstm.sqadto;
     sqlstm.sqptdso = sqlstm.sqtdso;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_Cuotas",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final iOpenCuotas ******************************/

/*****************************************************************************/
/*                           funcion : iFetchCuotas                          */
/*****************************************************************************/
int iFetchCuotas (CUOTAS *pCuo,int iTipoFactura)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhSeqCuotas   ;
  static int    ihOrdCuota    ;
  static double dhImpCuota    ;
  static short  shIndFacturado;
  static short  shIndPagado   ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  szhRowid      = pCuo->szRowid     ;
  szhFecEmision = pCuo->szFecEmision;

  if (iTipoFactura == FACT_CICLO)
  {
      /* EXEC SQL FETCH Cur_Cuotas INTO
                                 :szhRowid      ,
                                 :lhSeqCuotas   ,
                                 :ihOrdCuota    ,
                                 :szhFecEmision ,
                                 :dhImpCuota    ,
                                 :shIndFacturado,
                                 :shIndPagado   ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2813;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhSeqCuotas;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&ihOrdCuota;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[3] = (unsigned long )15;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&dhImpCuota;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&shIndFacturado;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&shIndPagado;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (iTipoFactura == FACT_BAJA)
  {
      /* EXEC SQL FETCH Cur_CuotasBaja INTO
                                    :szhRowid      ,
                                    :lhSeqCuotas   ,
                                    :ihOrdCuota    ,
                                    :szhFecEmision ,
                                    :dhImpCuota    ,
                                    :shIndFacturado,
                                    :shIndPagado   ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2856;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhSeqCuotas;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&ihOrdCuota;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[3] = (unsigned long )15;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&dhImpCuota;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&shIndFacturado;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&shIndPagado;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  }
  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_Cuotas",
               szfnORAerror());

  if (SQLCODE == SQLOK)
  {
      pCuo->lSeqCuotas    = lhSeqCuotas   ;
      pCuo->iOrdCuota     = ihOrdCuota    ;
      pCuo->dImpCuota     = dhImpCuota    ;
      pCuo->iIndFacturado = shIndFacturado;
      pCuo->iIndPagado    = shIndPagado   ;
  }
  return SQLCODE;
}/*************************** Final iFetchCuotas *****************************/


/*****************************************************************************/
/*                         funcion : iCloseCuotas                            */
/*****************************************************************************/
int iCloseCuotas (int iTipoFactura)
{
  if (iTipoFactura == FACT_CICLO)
      /* EXEC SQL CLOSE Cur_Cuotas    ; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2899;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (iTipoFactura == FACT_BAJA)
      /* EXEC SQL CLOSE Cur_CuotasBaja; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2914;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_Cuotas",
               szfnORAerror());

  return SQLCODE;
}/*************************** Final iCloseCuotas *****************************/

/*****************************************************************************/
/*                            funcion : iCmpCuotas                           */
/*****************************************************************************/
int iCmpCuotas (const void* cad1,const void* cad2)
{
    int rc = 0;

    if ( ((CUOTAS *)cad1)->lSeqCuotas > ((CUOTAS *)cad2)->lSeqCuotas )
         rc =  1;
    if ( ((CUOTAS *)cad1)->lSeqCuotas < ((CUOTAS *)cad2)->lSeqCuotas )
         rc = -1;
    if ( ((CUOTAS *)cad1)->lSeqCuotas == ((CUOTAS *)cad2)->lSeqCuotas)
    {
         rc = ((CUOTAS *)cad1)->iOrdCuota - ((CUOTAS *)cad2)->iOrdCuota;
    }
    return rc;
}/************************** Final iCmpCuotas ********************************/

/*****************************************************************************/
/*                            funcion : bCargaCuotas                         */
/*****************************************************************************/
BOOL bCargaCuotas (CUOTAS *pCuo        ,
                   int    *iNumCuo     ,
                   int     iTipoFactura,
                   long    lSeqCuotas)
{
  int  rc    = 0   ;
  int  iCont = 0   ;
  BOOL bRes  = TRUE;

  if (iOpenCuotas (iTipoFactura,lSeqCuotas))
      bRes = FALSE;

  iCont = *iNumCuo;

  while (iCont<MAX_CUOTAS && bRes)
  {
         rc = iFetchCuotas (&pCuo[iCont],iTipoFactura);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumCuo = iCont;
  if (rc == SQLNOTFOUND && *iNumCuo >= 0 && *iNumCuo <=MAX_CUOTAS)
  {
      qsort (pCuo,*iNumCuo,sizeof(CUOTAS),iCmpCuotas);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumCuo == MAX_CUOTAS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_Cuotas");
      bRes = FALSE;
  }
  return (bRes && iCloseCuotas (iTipoFactura) == 0)?TRUE:FALSE;

}/*************************** Final bCargaCuotas *****************************/

/*****************************************************************************/
/*                           funcion : iOpenArriendo                         */
/*****************************************************************************/
static int iOpenArriendo (void)
{
  /* EXEC SQL DECLARE Cur_Arriendo CURSOR FOR
       SELECT /o+ full (FA_ARRIENDO) o/
              ROWID          ,
              COD_CLIENTE    ,
              NUM_ABONADO    ,
              TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS'),
              TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS'),
              COD_PRODUCTO   ,
              COD_CONCEPTO   ,
              COD_ARTICULO   ,
              PRECIO_MES     ,
              COD_MONEDA
      FROM    FA_ARRIENDO; */ 


  /* EXEC SQL OPEN Cur_Arriendo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0037;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2929;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_Arriendo\n",
               szfnORAerror());
  return SQLCODE;
}/************************** Final iOpenArriendo *****************************/

/*****************************************************************************/
/*                          funcion : iFetchArriendo                         */
/*****************************************************************************/
static int iFetchArriendo (ARRIENDO *pArr)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char   szhFecDesde [15]; /* EXEC SQL VAR szhFecDesde IS STRING(15); */ 

  static char   szhFecHasta [15]; /* EXEC SQL VAR szhFecHasta IS STRING(15); */ 

  static int    ihCodProducto   ;
  static long   lhCodArticulo   ;
  static double dhPrecioMes     ;
  static char   szhCodMoneda [4];
  /* EXEC SQL END DECLARE SECTION; */ 


  /* EXEC SQL FETCH Cur_Arriendo INTO szhRowid     ,
                                   lhCodCliente ,
                                   lhNumAbonado ,
                                   szhFecDesde  ,
                                   szhFecHasta  ,
                                   ihCodProducto,
                                   ihCodConcepto,
                                   lhCodArticulo,
                                   dhPrecioMes  ,
                                   szhCodMoneda ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2944;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[4] = (unsigned long )15;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhCodArticulo;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&dhPrecioMes;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[9] = (unsigned long )4;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_Arriendo",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      strcpy (pArr->szRowid    ,szhRowid    );
      strcpy (pArr->szFecDesde ,szhFecDesde );
      strcpy (pArr->szFecHasta ,szhFecHasta );
      strcpy (pArr->szCodMoneda,szhCodMoneda);

      pArr->lCodCliente  = lhCodCliente ;
      pArr->lNumAbonado  = lhNumAbonado ;
      pArr->iCodProducto = ihCodProducto;
      pArr->iCodConcepto = ihCodConcepto;
      pArr->lCodArticulo = lhCodArticulo;
      pArr->dPrecioMes   = dhPrecioMes  ;

  }
  return SQLCODE;
}/************************** Final iFetchArriendo ****************************/

/*****************************************************************************/
/*                          funcion : iCloseArriendo                         */
/*****************************************************************************/
static int iCloseArriendo (void)
{
   /* EXEC SQL CLOSE Cur_Arriendo; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2999;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_Arriendo",
                szfnORAerror());

   return SQLCODE;
}/************************** Final iCloseArriendo ****************************/

/*****************************************************************************/
/*                          funcion : iCmpArriendo                           */
/*****************************************************************************/
static int iCmpArriendo (const void* cad1,const void* cad2)
{

  if ( ((ARRIENDO *)cad1)->lCodCliente > ((ARRIENDO *)cad2)->lCodCliente )
     return  1;
  if ( ((ARRIENDO *)cad1)->lCodCliente < ((ARRIENDO *)cad2)->lCodCliente )
     return -1;
  if ( ((ARRIENDO *)cad1)->lCodCliente ==((ARRIENDO *)cad2)->lCodCliente )
  {
      if ( ((ARRIENDO *)cad1)->lNumAbonado > ((ARRIENDO *)cad2)->lNumAbonado )
            return  1;
      if ( ((ARRIENDO *)cad1)->lNumAbonado < ((ARRIENDO *)cad2)->lNumAbonado )
            return -1;
      if ( ((ARRIENDO *)cad1)->lNumAbonado == ((ARRIENDO *)cad2)->lNumAbonado )
      {
          if (strcmp ( ((ARRIENDO *)cad1)->szFecDesde,
                       ((ARRIENDO *)cad2)->szFecDesde ) > 0 )
              return  1;
          if (strcmp ( ((ARRIENDO *)cad1)->szFecDesde,
                       ((ARRIENDO *)cad2)->szFecDesde ) < 0 )
              return -1;
          if (strcmp ( ((ARRIENDO *)cad1)->szFecDesde,
                       ((ARRIENDO *)cad2)->szFecDesde ) == 0)
              return  0;
      }
  }
}/************************** Final iCmpArriendo ******************************/

/*****************************************************************************/
/*                            funcion : bCargaArriendo                       */
/*****************************************************************************/
BOOL bCargaArriendo (ARRIENDO *pArr,int *iNumArr)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenArriendo ())
      bRes = FALSE;

  while (iCont<MAX_ARRIENDO && bRes)
  {
         rc = iFetchArriendo (&pArr[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumArr = iCont;
  if (rc == SQLNOTFOUND && *iNumArr >= 0 && *iNumArr <=MAX_ARRIENDO)
  {
      qsort (pArr,*iNumArr,sizeof(ARRIENDO),iCmpArriendo);
      vPrintArriendo (pArr,*iNumArr);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumArr == MAX_ARRIENDO)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_Arriendo");
      bRes = FALSE;
  }
  return (bRes && iCloseArriendo () == 0)?TRUE:FALSE;

}/*************************** Final bCargaArriendo ***************************/

/*****************************************************************************/
/*                          funcion : vPrintArriendo                         */
/*****************************************************************************/
static void vPrintArriendo (ARRIENDO *pArr,int iNumArr)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla FA_ARRIENDO ***",LOG06);

	  for (iInd=0;iInd<iNumArr;iInd++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d]-CodCliente ...[%ld]"
	                              "\n\t[%d]-NumAbonado ...[%ld]"
	                              "\n\t[%d]-FecDesde  ....[%s] "
	                              "\n\t[%d]-FecHasta  ....[%s] "
	                              "\n\t[%d]-CodProducto...[%d] "
	                              "\n\t[%d]-CodConcepto...[%d] "
	                              "\n\t[%d]-CodArticulo...[%ld]"
	                              "\n\t[%d]-Precio Mes....[%f] "
	                              "\n\t[%d]-CodMoneda ....[%s] "
	                              ,LOG06                  ,iInd,pArr->lCodCliente
	                              ,iInd,pArr->lNumAbonado ,iInd,pArr->szFecDesde
	                              ,iInd,pArr->szFecHasta  ,iInd,pArr->iCodProducto
	                              ,iInd,pArr->iCodConcepto,iInd,pArr->lCodArticulo
	                              ,iInd,pArr->dPrecioMes  ,iInd,pArr->szCodMoneda );

	       pArr++;
	  }
	}
}/************************** Final vPrintArriendo ****************************/

/*****************************************************************************/
/*                           funcion : iOpenRegiones                         */
/*****************************************************************************/
static int iOpenRegiones (void)
{
  /* EXEC SQL DECLARE Cur_Regiones CURSOR FOR
       SELECT /o+ full (GE_REGIONES) o/
              COD_REGION   ,
              DES_REGION
       FROM   GE_REGIONES; */ 

  /* EXEC SQL OPEN Cur_Regiones; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0038;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3014;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Regiones\n\t",
               szfnORAerror());
  return SQLCODE;
}/************************** Final iOpenRegiones *****************************/


/*****************************************************************************/
/*                          funcion : iFetchRegiones                         */
/*****************************************************************************/
static int iFetchRegiones (REGIONES *pR)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char* szhDesRegion   ; /* EXEC SQL VAR szhDesRegion    IS STRING(31); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  szhCodRegion    = pR->szCodRegion;
  szhDesRegion    = pR->szDesRegion;

  /* EXEC SQL FETCH Cur_Regiones INTO :szhCodRegion   ,
                                   :szhDesRegion   ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3029;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesRegion;
  sqlstm.sqhstl[1] = (unsigned long )31;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Regiones\n\t",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final iFetchRegiones ***************************/


/*****************************************************************************/
/*                           funcion : iCloseRegiones                        */
/*****************************************************************************/
static int iCloseRegiones (void)
{
  /* EXEC SQL CLOSE Cur_Regiones; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3052;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Regiones\n\tn\t",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final iCloseRegiones ***************************/

/*****************************************************************************/
/*                            funcion : bCargaRegiones                       */
/*****************************************************************************/
BOOL bCargaRegiones (REGIONES *pR, int *iNumR)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenRegiones())
      bRes = FALSE;

  while (iCont<MAX_REGIONES && bRes)
  {
         rc = iFetchRegiones (&pR[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumR = iCont;
  if (rc == SQLNOTFOUND && *iNumR >= 0 && *iNumR <=MAX_REGIONES)
  {
      qsort (pR,*iNumR,sizeof(REGIONES),iCmpRegiones);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumR == MAX_REGIONES)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Regiones");
      bRes = FALSE;
  }
  return (bRes && iCloseRegiones () == 0)?TRUE:FALSE;

}/*************************** Final bCargaRegiones ***************************/

/*****************************************************************************/
/*                           funcion : iOpenProvincias                       */
/*****************************************************************************/
static int iOpenProvincias (void)
{
  /* EXEC SQL DECLARE Cur_Provincias CURSOR FOR
       SELECT /o+ full (GE_PROVINCIAS) o/
              COD_REGION   ,
              COD_PROVINCIA
       FROM   GE_PROVINCIAS; */ 

  /* EXEC SQL OPEN Cur_Provincias; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0039;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3067;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Provincias\n",
               szfnORAerror());
  return SQLCODE;
}/************************** Final iOpenProvincias ****************************/


/*****************************************************************************/
/*                          funcion : iFetchProvincias                       */
/*****************************************************************************/
static int iFetchProvincias (PROVINCIAS *pP)
{
  szhCodRegion    = pP->szCodRegion   ;
  szhCodProvincia = pP->szCodProvincia;

  /* EXEC SQL FETCH Cur_Provincias INTO :szhCodRegion   ,
                                     :szhCodProvincia; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3082;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodProvincia;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Provincias",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final iFetchProvincias *************************/


/*****************************************************************************/
/*                           funcion : iCloseProvincias                      */
/*****************************************************************************/
static int iCloseProvincias (void)
{
  /* EXEC SQL CLOSE Cur_Provincias; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3105;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Provincias",
               szfnORAerror());
  return SQLCODE;
 }/*************************** Final iCloseProvincia *************************/

/*****************************************************************************/
/*                            funcion : bCargaProvincias                     */
/*****************************************************************************/
BOOL bCargaProvincias (PROVINCIAS *pP, int *iNumP)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenProvincias())
      bRes = FALSE;

  while (iCont<MAX_PROVINCIAS && bRes)
  {
         rc = iFetchProvincias (&pP[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumP = iCont;
  if (rc == SQLNOTFOUND && *iNumP >= 0 && *iNumP <=MAX_PROVINCIAS)
  {
      qsort (pP,*iNumP,sizeof(PROVINCIAS),iCmpProvincias);
      vPrintProvincias (pP,*iNumP);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumP == MAX_PROVINCIAS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Provincias");
      bRes = FALSE;
  }
  return (bRes && iCloseProvincias () == 0)?TRUE:FALSE;

}/*************************** Final bCargaProvincias *************************/


/*****************************************************************************/
/*                            funciones : vPrintProvincias                   */
/*****************************************************************************/
static void vPrintProvincias (PROVINCIAS *pP,int iNumP)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla GE_PROVINCIAS ***\n",LOG06);
	  for (iInd=0;iInd<iNumP;iInd++)
	  {
	       vDTrazasLog (szExeName,"\n\t[%d]-Cod.Region   ....[%s]"
	                              "\n\t[%d]-Cod.Provincia ...[%s]"
	                              ,LOG06,iInd,pP->szCodRegion
	                              ,iInd,pP->szCodProvincia);

	       pP++;
	  }
	}
}/**************************** Final vPrintProvincias ************************/

/*****************************************************************************/
/*                            funciones : vPrintRegiones                     */
/*****************************************************************************/
static void vPrintRegiones (REGIONES *pR,int iNumR)
{
  int iInd = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	  vDTrazasLog (szExeName,"\n\t*** Tabla GE_REGIONES ***\n",LOG06);
	  for (iInd=0;iInd<iNumR;iInd++)
	  {
	       vDTrazasLog (szExeName,"\t[%d]-Cod.Region...[%s]"
	                              "\t[%d]-Des.Region...[%s]"
	                              ,LOG06,iInd,pR->szCodRegion,iInd,pR->szDesRegion);
	       pR++;
	  }
	}
}/**************************** Final vPrintRegiones *************************/

/*****************************************************************************/
/*                           funcion : iOpenActividades                      */
/*****************************************************************************/
static int iOpenActividades (void)
{
  /* EXEC SQL DECLARE Cur_Actividades CURSOR FOR
       SELECT /o+ full (GE_ACTIVIDADES) o/
              COD_Actividad,
              DES_Actividad
       FROM   GE_ACTIVIDADES; */ 

  /* EXEC SQL OPEN Cur_Actividades; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0040;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3120;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Actividades\n",
               szfnORAerror());
  return SQLCODE;
}/************************** Final iOpenActividades **************************/


/*****************************************************************************/
/*                          funcion : iFetchActividades                      */
/*****************************************************************************/
static int iFetchActividades (ACTIVIDADES *pP)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodActividad ;
  static char* szhDesActividad; /* EXEC SQL VAR szhDesActividad IS STRING(41); */ 

  /* EXEC SQL END DECLARE SECTION ; */ 


  szhDesActividad = pP->szDesActividad;

  /* EXEC SQL FETCH Cur_Actividades INTO :ihCodActividad,
                                      :szhDesActividad; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3135;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodActividad;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesActividad;
  sqlstm.sqhstl[1] = (unsigned long )41;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Actividades",
               szfnORAerror());
  if (SQLCODE == SQLOK)
      pP->iCodActividad = ihCodActividad;

  return SQLCODE;
}/*************************** Final iFetchActividades ***********************/


/*****************************************************************************/
/*                           funcion : iCloseActividades                     */
/*****************************************************************************/
static int iCloseActividades (void)
{
  /* EXEC SQL CLOSE Cur_Actividades; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3158;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Actividades",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final iCloseActividades ***********************/

/*****************************************************************************/
/*                             funcion : iCmpActividades                     */
/*****************************************************************************/
int iCmpActividades (const void *cad1,const void *cad2)
{
  return ((ACTIVIDADES *)cad1)->iCodActividad-
         ((ACTIVIDADES *)cad2)->iCodActividad;
}/***************************** Final iCmpActividades ************************/


/*****************************************************************************/
/*                            funcion : vPrintActividades                    */
/*****************************************************************************/
static void vPrintActividades (ACTIVIDADES *pA,int iNumA)
{
   int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
	   vDTrazasLog (szExeName,"\n\t* Tabla GE_ACTIVIDADES\n",LOG06);

	   for (i=0;i<iNumA;i++)
	   {
	        vDTrazasLog (szExeName,"\n\t[%d]-CodActividad...[%d]"
	        					   "\n\t[%d]-DesActividad...[%s]"
	                    		   ,LOG06,i,pA->iCodActividad,i,pA->szDesActividad);
	        pA++;

		}
	}
}/***************************** Final vPrintActividades **********************/

/*****************************************************************************/
/*                            funcion : bCargaActividades                    */
/*****************************************************************************/
BOOL bCargaActividades (ACTIVIDADES *pP, int *iNumP)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (iOpenActividades())
      bRes = FALSE;

  while (iCont<MAX_ACTIVIDADES && bRes)
  {
         rc = iFetchActividades (&pP[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumP = iCont;
  if (rc == SQLNOTFOUND && *iNumP >= 0 && *iNumP <=MAX_ACTIVIDADES)
  {
      qsort (pP,*iNumP,sizeof(ACTIVIDADES),iCmpActividades);
      vPrintActividades (pP,*iNumP);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumP == MAX_ACTIVIDADES)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Actividades");
      bRes = FALSE;
  }
  return (bRes && iCloseActividades () == 0)?TRUE:FALSE;

}/*************************** Final bCargaActividades ************************/

/****************************************************************************/
/*                             funcion : ifnSelectCiudad                    */
/****************************************************************************/
static int ifnSelectCiudad (CIUDADES *pC)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char  szhCodRegion    [4];/* EXEC SQL VAR szhCodRegion     IS STRING(4) ; */ 

  static char  szhCodProvincia [6];/* EXEC SQL VAR szhCodProvincia  IS STRING(6) ; */ 

  static char  szhCodCiudad    [6];/* EXEC SQL VAR szhCodCiudad     IS STRING(6) ; */ 

  static char  szhDesCiudad   [31];/* EXEC SQL VAR szhDesCiudad     IS STRING(31); */ 

  static char  szhCodCelda     [8];/* EXEC SQL VAR szhCodCelda      IS STRING(8) ; */ 

  static short ihIndCiudad        ;
  static short i_shIndCiudad      ;
  /* EXEC SQL END DECLARE SECTION; */ 


  strcpy (szhCodRegion   ,pC->szCodRegion)   ;
  strcpy (szhCodProvincia,pC->szCodProvincia);
  strcpy (szhCodCiudad   ,pC->szCodCiudad)   ;

  /* EXEC SQL SELECT /o+ index (GE_CIUDADES PK_GE_CIUDADES) o/
                  COD_REGION   ,
                  COD_PROVINCIA,
                  COD_CIUDAD   ,
                  DES_CIUDAD   ,
                  COD_CELDA    ,
                  IND_CIUDAD
            INTO  :szhCodRegion   ,
                  :szhCodProvincia,
                  :szhCodCiudad   ,
                  :szhDesCiudad   ,
                  :szhCodCelda    ,
                  :ihIndCiudad:i_shIndCiudad
            FROM  GE_CIUDADES
            WHERE COD_REGION    = :szhCodRegion
              AND COD_PROVINCIA = :szhCodProvincia
              AND COD_CIUDAD    = :szhCodCiudad; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (GE_CIUDADES PK_GE_CIUDADES)  +*/ COD_RE\
GION ,COD_PROVINCIA ,COD_CIUDAD ,DES_CIUDAD ,COD_CELDA ,IND_CIUDAD into :b0,:b\
1,:b2,:b3,:b4,:b5:b6  from GE_CIUDADES where ((COD_REGION=:b0 and COD_PROVINCI\
A=:b1) and COD_CIUDAD=:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3173;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodProvincia;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodCiudad;
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDesCiudad;
  sqlstm.sqhstl[3] = (unsigned long )31;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodCelda;
  sqlstm.sqhstl[4] = (unsigned long )8;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihIndCiudad;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)&i_shIndCiudad;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[6] = (unsigned long )4;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodProvincia;
  sqlstm.sqhstl[7] = (unsigned long )6;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhCodCiudad;
  sqlstm.sqhstl[8] = (unsigned long )6;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ge_Ciudades\n",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      strcpy (pC->szDesCiudad,szhDesCiudad);
      strcpy (pC->szCodCelda ,szhCodCelda );
      pC->iIndCiudad = (i_shIndCiudad == ORA_NULL)?ORA_NULL:ihIndCiudad;
  }
  return SQLCODE;
}/*************************** Final ifnSelectCiudad *************************/

/*****************************************************************************/
/*                            funcion : bfnFindCiudad                        */
/*****************************************************************************/
BOOL bfnFindCiudad (CIUDADES *pC,int iTipoFact)
{
  int i = 0;
  BOOL bExit = FALSE;
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhDesCiudad    ;/* EXEC SQL VAR szhDesCiudad    IS STRING(31); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  if (iTipoFact != stDatosGener.iCodCiclo)
  {
      vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ge_Comunas\n"
                   "\t\t=> Cod.Region    [%s]\n"
                   "\t\t=> Cod.Provinica [%s]\n"
                   "\t\t=> Cod.Ciudad    [%s]\n",LOG04,
                   pC->szCodRegion,pC->szCodProvincia,pC->szCodCiudad);

      szhCodRegion    = pC->szCodRegion   ;
      szhCodProvincia = pC->szCodProvincia;
      szhCodCiudad    = pC->szCodCiudad   ;
      szhDesCiudad    = pC->szDesCiudad   ;

      /* EXEC SQL SELECT /o+ index (GE_CIUDADES PK_GE_CIUDADES) o/
                      DES_CIUDAD
               INTO   :szhDesCiudad
               FROM   GE_CIUDADES
               WHERE  COD_REGION   = :szhCodRegion
                 AND  COD_PROVINCIA= :szhCodProvincia
                 AND  COD_CIUDAD   = :szhCodCiudad; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (GE_CIUDADES PK_GE_CIUDADES)  +*/ DE\
S_CIUDAD into :b0  from GE_CIUDADES where ((COD_REGION=:b1 and COD_PROVINCIA=:\
b2) and COD_CIUDAD=:b3)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )3224;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhDesCiudad;
      sqlstm.sqhstl[0] = (unsigned long )31;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodRegion;
      sqlstm.sqhstl[1] = (unsigned long )4;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodProvincia;
      sqlstm.sqhstl[2] = (unsigned long )6;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhCodCiudad;
      sqlstm.sqhstl[3] = (unsigned long )6;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


      if (SQLCODE)
      {
          iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ge_Ciudades",
                   szfnORAerror());
          return FALSE;
      }
      else
         return TRUE;

  }
  if (C_stCiudades.iContador == 0)
  {
      if (!bfnCargaCiudad (pC))
           return FALSE;
  }
  else
  {
     for (i=0;i<C_stCiudades.iContador;i++)
     {
          if ( !strcmp (C_stCiudades.A_Ciudades[i].szCodRegion,
                        pC->szCodRegion)                           &&
               !strcmp (C_stCiudades.A_Ciudades[i].szCodProvincia,
                        pC->szCodProvincia)                        &&
               !strcmp (C_stCiudades.A_Ciudades[i].szCodCiudad,
                        pC->szCodCiudad) )
          {
               strcpy (pC->szDesCiudad,C_stCiudades.A_Ciudades[i].szDesCiudad);
               strcpy (pC->szCodCelda ,C_stCiudades.A_Ciudades[i].szCodCelda );

               pC->iIndCiudad = C_stCiudades.A_Ciudades[i].iIndCiudad;
               C_stCiudades.A_Ciudades[i].iAntiguedad += 1           ;
               bExit = TRUE;
               break       ;
          }
     }/* fin for i */
     if (!bExit)
     {
         if (!bfnCargaCiudad (pC))
              return FALSE;
     }
  }
  qsort (C_stCiudades.A_Ciudades,C_stCiudades.iContador,sizeof(CIUDADES),
         iCmpCiudades);
  return TRUE;
}/**************************** Final bfnFindCiudad ***************************/

/*****************************************************************************/
/*                             funcion : bfnCargaCiudad                      */
/*****************************************************************************/
static BOOL bfnCargaCiudad (CIUDADES *pC)
{
  int i = 0, j = 0, iAntg  = 0, iIndice = 0;

  if (C_stCiudades.iContador < MAX_CIUDADES)
  {
      if (ifnSelectCiudad (pC))
          return FALSE;
      j = C_stCiudades.iContador;

      strcpy (C_stCiudades.A_Ciudades[j].szCodRegion   ,pC->szCodRegion   );
      strcpy (C_stCiudades.A_Ciudades[j].szCodProvincia,pC->szCodProvincia);
      strcpy (C_stCiudades.A_Ciudades[j].szCodCiudad   ,pC->szCodCiudad)   ;
      strcpy (C_stCiudades.A_Ciudades[j].szDesCiudad   ,pC->szDesCiudad)   ;
      strcpy (C_stCiudades.A_Ciudades[j].szCodCelda    ,pC->szCodCelda )   ;
      C_stCiudades.A_Ciudades[j].iIndCiudad  = pC->iIndCiudad;
      C_stCiudades.A_Ciudades[j].iAntiguedad = 0;

      C_stCiudades.iContador += 1;
  }
  else
  {
     for (i=0;i<C_stCiudades.iContador;i++)
     {
          if (C_stCiudades.A_Ciudades[i].iAntiguedad == 0)
          {
              iIndice = i;
              break      ;
          }
          else
          {
             if (iAntg > C_stCiudades.A_Ciudades[i].iAntiguedad)
             {
                 iAntg   = C_stCiudades.A_Ciudades[i].iAntiguedad;
                 iIndice = i;
             }
          }
     }/* fin for i */
     if (ifnSelectCiudad (pC))
         return FALSE;

     memset(&C_stCiudades.A_Ciudades[iIndice],0,sizeof(CIUDADES));

     strcpy(C_stCiudades.A_Ciudades[iIndice].szCodRegion   ,pC->szCodRegion   );
     strcpy(C_stCiudades.A_Ciudades[iIndice].szCodProvincia,pC->szCodProvincia);
     strcpy(C_stCiudades.A_Ciudades[iIndice].szCodCiudad   ,pC->szCodCiudad)   ;
     strcpy(C_stCiudades.A_Ciudades[iIndice].szDesCiudad   ,pC->szDesCiudad)   ;
     strcpy(C_stCiudades.A_Ciudades[iIndice].szCodCelda    ,pC->szCodCelda )   ;
     C_stCiudades.A_Ciudades[j].iIndCiudad = pC->iIndCiudad;
     C_stCiudades.A_Ciudades[j].iAntiguedad= 0;

  }
  return TRUE;
}/**************************** Final bfnCargaCiudad **************************/

/****************************************************************************/
/*                             funcion : ifnSelectComuna                    */
/****************************************************************************/
static int ifnSelectComuna (COMUNAS *pC)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char  szhCodRegion    [4];/* EXEC SQL VAR szhCodRegion     IS STRING(4) ; */ 

  static char  szhCodProvincia [6];/* EXEC SQL VAR szhCodProvincia  IS STRING(6) ; */ 

  static char  szhCodComuna    [6];/* EXEC SQL VAR szhCodComuna     IS STRING(6) ; */ 

  static char  szhDesComuna   [31];/* EXEC SQL VAR szhDesComuna     IS STRING(31); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  strcpy (szhCodRegion   ,pC->szCodRegion)   ;
  strcpy (szhCodProvincia,pC->szCodProvincia);
  strcpy (szhCodComuna   ,pC->szCodComuna)   ;

  /* EXEC SQL SELECT /o+ index (GE_COMUNAS PK_GE_COMUNAS) o/
                  COD_REGION   ,
                  COD_PROVINCIA,
                  COD_COMUNA   ,
                  DES_COMUNA
            INTO  :szhCodRegion   ,
                  :szhCodProvincia,
                  :szhCodComuna   ,
                  :szhDesComuna
            FROM  GE_COMUNAS
            WHERE COD_REGION    = :szhCodRegion
              AND COD_PROVINCIA = :szhCodProvincia
              AND COD_COMUNA    = :szhCodComuna; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (GE_COMUNAS PK_GE_COMUNAS)  +*/ COD_REGI\
ON ,COD_PROVINCIA ,COD_COMUNA ,DES_COMUNA into :b0,:b1,:b2,:b3  from GE_COMUNA\
S where ((COD_REGION=:b0 and COD_PROVINCIA=:b1) and COD_COMUNA=:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3255;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodProvincia;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodComuna;
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDesComuna;
  sqlstm.sqhstl[3] = (unsigned long )31;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[4] = (unsigned long )4;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodProvincia;
  sqlstm.sqhstl[5] = (unsigned long )6;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodComuna;
  sqlstm.sqhstl[6] = (unsigned long )6;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ge_Comunas\n",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      strcpy (pC->szDesComuna,szhDesComuna);
  }
  return SQLCODE;
}/*************************** Final ifnSelectComuna *************************/

/*****************************************************************************/
/*                            funcion : bfnFindComuna                        */
/*****************************************************************************/
BOOL bfnFindComuna (COMUNAS *pC,int iTipoFact)
{
  int i = 0;
  BOOL bExit = FALSE;
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhCodComuna    ;/* EXEC SQL VAR szhCodComuna    IS STRING(6) ; */ 

  static char *szhDesComuna    ;/* EXEC SQL VAR szhDesComuna    IS STRING(31); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  if (iTipoFact == stDatosGener.iCodContado ||
      iTipoFact == stDatosGener.iCodNotaDeb ||
      iTipoFact == stDatosGener.iCodBaja    ||
      iTipoFact == stDatosGener.iCodNotaCre)
  {
      vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ge_Comunas\n"
                   "\t\t=> Cod.Region    [%s]\n"
                   "\t\t=> Cod.Provinica [%s]\n"
                   "\t\t=> Cod.Comuna    [%s]\n",LOG04,
                   pC->szCodRegion,pC->szCodProvincia,pC->szCodComuna);

      szhCodRegion    = pC->szCodRegion   ;
      szhCodProvincia = pC->szCodProvincia;
      szhCodComuna    = pC->szCodComuna   ;
      szhDesComuna    = pC->szDesComuna   ;

      /* EXEC SQL SELECT /o+ index (GE_COMUNAS PK_GE_COMUNAS) o/
                      DES_COMUNA
               INTO   :szhDesComuna
               FROM   GE_COMUNAS
               WHERE  COD_REGION   = :szhCodRegion
                 AND  COD_PROVINCIA= :szhCodProvincia
                 AND  COD_COMUNA   = :szhCodComuna; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (GE_COMUNAS PK_GE_COMUNAS)  +*/ DES_\
COMUNA into :b0  from GE_COMUNAS where ((COD_REGION=:b1 and COD_PROVINCIA=:b2)\
 and COD_COMUNA=:b3)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )3298;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhDesComuna;
      sqlstm.sqhstl[0] = (unsigned long )31;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodRegion;
      sqlstm.sqhstl[1] = (unsigned long )4;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodProvincia;
      sqlstm.sqhstl[2] = (unsigned long )6;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhCodComuna;
      sqlstm.sqhstl[3] = (unsigned long )6;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
      sqlstm.sqphss = sqlstm.sqhsts;
      sqlstm.sqpind = sqlstm.sqindv;
      sqlstm.sqpins = sqlstm.sqinds;
      sqlstm.sqparm = sqlstm.sqharm;
      sqlstm.sqparc = sqlstm.sqharc;
      sqlstm.sqpadto = sqlstm.sqadto;
      sqlstm.sqptdso = sqlstm.sqtdso;
      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


      if (SQLCODE)
      {
          iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_Comunas",
                   szfnORAerror());
          return FALSE;
      }
      else
         return TRUE;

  }
  if (C_stComunas.iContador == 0)
  {
      if (!bfnCargaComuna (pC))
           return FALSE;
  }
  else
  {
     for (i=0;i<C_stComunas.iContador;i++)
     {
          if ( !strcmp (C_stComunas.A_Comunas[i].szCodRegion,
                        pC->szCodRegion)                           &&
               !strcmp (C_stComunas.A_Comunas[i].szCodProvincia,
                        pC->szCodProvincia)                        &&
               !strcmp (C_stComunas.A_Comunas[i].szCodComuna,
                        pC->szCodComuna) )
          {
               strcpy (pC->szDesComuna,C_stComunas.A_Comunas[i].szDesComuna);
               C_stComunas.A_Comunas[i].iAntiguedad += 1;
               bExit = TRUE;
               break       ;
          }
     }/* fin for i */
     if (!bExit)
     {
         if (!bfnCargaComuna (pC))
              return FALSE;
     }
  }
  qsort (C_stComunas.A_Comunas,C_stComunas.iContador,sizeof(COMUNAS),
         iCmpComunas);
  return TRUE;
}/**************************** Final bfnFindComuna ***************************/

/*****************************************************************************/
/*                             funcion : bfnCargaComuna                      */
/*****************************************************************************/
static BOOL bfnCargaComuna (COMUNAS *pC)
{
  int i = 0, j = 0, iAntg  = 0, iIndice = 0;

  if (C_stComunas.iContador < MAX_COMUNAS)
  {
      if (ifnSelectComuna (pC))
          return FALSE;
      j = C_stComunas.iContador;

      strcpy (C_stComunas.A_Comunas[j].szCodRegion   ,pC->szCodRegion   );
      strcpy (C_stComunas.A_Comunas[j].szCodProvincia,pC->szCodProvincia);
      strcpy (C_stComunas.A_Comunas[j].szCodComuna   ,pC->szCodComuna)   ;
      strcpy (C_stComunas.A_Comunas[j].szDesComuna   ,pC->szDesComuna)   ;
      C_stComunas.A_Comunas[j].iAntiguedad = 0;

      C_stComunas.iContador += 1;
  }
  else
  {
     for (i=0;i<C_stComunas.iContador;i++)
     {
          if (C_stComunas.A_Comunas[i].iAntiguedad == 0)
          {
              iIndice = i;
              break      ;
          }
          else
          {
             if (iAntg > C_stComunas.A_Comunas[i].iAntiguedad)
             {
                 iAntg   = C_stComunas.A_Comunas[i].iAntiguedad;
                 iIndice = i;
             }
          }
     }/* fin for i */
     if (ifnSelectComuna (pC))
         return FALSE;

     memset(&C_stComunas.A_Comunas[iIndice],0,sizeof(COMUNAS));

     strcpy(C_stComunas.A_Comunas[iIndice].szCodRegion   ,pC->szCodRegion   );
     strcpy(C_stComunas.A_Comunas[iIndice].szCodProvincia,pC->szCodProvincia);
     strcpy(C_stComunas.A_Comunas[iIndice].szCodComuna   ,pC->szCodComuna)   ;
     strcpy(C_stComunas.A_Comunas[iIndice].szDesComuna   ,pC->szDesComuna)   ;
     C_stComunas.A_Comunas[j].iAntiguedad= 0;

  }
  return TRUE;
}/**************************** Final bfnCargaComuna **************************/

/*****************************************************************************/
/*                            funcion : bfnOpenRangoTabla                    */
/*****************************************************************************/
static int ifnOpenRangoTabla (void)
{
  /* EXEC SQL DECLARE Cur_Rango_Tabla CURSOR FOR
       SELECT /o+ full (FA_RANGO_TABLA) o/
               COD_CICLFACT,
               RANGO_INI   ,
               RANGO_FIN   ,
               COD_PRODUCTO,
               NOM_TABLA
        FROM   FA_RANGO_TABLA; */ 

  /* EXEC SQL OPEN  Cur_Rango_Tabla; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0045;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3329;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_Rango_Tabla",
               szfnORAerror());
  return SQLCODE;
}/********************************** Final ifnOpenRangoTabla *****************/

/*****************************************************************************/
/*                         funcion : ifnFetchRangoTabla                      */
/*****************************************************************************/
static int ifnFetchRangoTabla (RANGOTABLA *pR)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhRangoIni     ;
  static long  lhRangoFin     ;
  static int   ihCodProducto  ;
  static char  szhNomTabla[21]; /* EXEC SQL VAR szhNomTabla IS STRING(21); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  /* EXEC SQL FETCH Cur_Rango_Tabla INTO :lhCodCiclFact,
                                      :lhRangoIni   ,
                                      :lhRangoFin   ,
                                      :ihCodProducto,
                                      :szhNomTabla; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3344;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhRangoIni;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhRangoFin;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhNomTabla;
  sqlstm.sqhstl[4] = (unsigned long )21;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_Rango_Tabla",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pR->lCodCiclFact = lhCodCiclFact;
      pR->lRangoIni    = lhRangoIni   ;
      pR->lRangoFin    = lhRangoFin   ;
      pR->iCodProducto = ihCodProducto;
      strcpy (pR->szNomTabla,szhNomTabla);
  }
  return SQLCODE;
}/*************************** Final ifnFetchRangoTabla ***********************/

/*****************************************************************************/
/*                           funcion : ifnCloseRangoTabla                    */
/*****************************************************************************/
static int ifnCloseRangoTabla (void)
{
  /* EXEC SQL CLOSE Cur_Rango_Tabla; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3379;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_Rango_Tabla",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final ifnCloseRangoTabla ***********************/

/*****************************************************************************/
/*                            funcion : bCargaRangoTabla                     */
/*****************************************************************************/
BOOL bfnCargaRangoTabla (RANGOTABLA *pP, int *iNumP)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (ifnOpenRangoTabla())
      bRes = FALSE;

  while (iCont<MAX_RANGOTABLA && bRes)
  {
         rc = ifnFetchRangoTabla (&pP[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumP = iCont;
  if (rc == SQLNOTFOUND && *iNumP >= 0 && *iNumP <=MAX_RANGOTABLA)
  {
      qsort (pP,*iNumP,sizeof(RANGOTABLA),iCmpRangoTabla);
      vfnPrintRangoTabla (pP,*iNumP);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumP == MAX_RANGOTABLA)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_Rango_Tabla");
      bRes = FALSE;
  }
  return (bRes && ifnCloseRangoTabla () == 0)?TRUE:FALSE;

}/*************************** Final bCargaRangoTabla ************************/

/****************************************************************************/
/*                           funcion : vfnPrintRangoTabla                   */
/****************************************************************************/
void vfnPrintRangoTabla (RANGOTABLA *pR,int iR)
{
  int i = 0;

  vDTrazasLog (szExeName,"\n\t*** Tabla FA_RANGO_TABLA ***",LOG06);

  for (i=0;i<iR;i++)
  {
       vDTrazasLog (szExeName,"\t[%d]-Cod.CiclFact.....[%ld]"
                              "\n\t[%d]-Rango.Ini......[%ld]"
                              "\n\t[%d]-Rango.Fin......[%ld]"
                              "\n\t[%d]-Cod.Producto...[%ld]"
                              "\n\t[%d]-Nom.Tabla......[%s]"
                              ,LOG06               ,i,pR->lCodCiclFact
                              ,i,pR->lRangoIni     ,i,pR->lRangoFin
                              ,i,pR->iCodProducto  ,i,pR->szNomTabla);

       pR++;

  }
}/*************************** vfnPrintRangoTabla *****************************/

/*****************************************************************************/
/*                            funcion : ifnOpenLimCreditos                   */
/*****************************************************************************/
static int ifnOpenLimCreditos (void)
{
  /* EXEC SQL DECLARE Cur_LimCreditos CURSOR FOR
       SELECT /o+ full (CO_LIMCREDITOS) o/
              COD_CREDMOR  ,
              COD_PRODUCTO ,
              COD_CALCLIEN ,
              IMP_MOROSIDAD
       FROM   CO_LIMCREDITOS; */ 

  /* EXEC SQL OPEN Cur_LimCreditos; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0046;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3394;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Co_LimCreditos\n\t",
               szfnORAerror());
  return SQLCODE;
}/*************************** Final ifnOpenLimCreditos ***********************/


/*****************************************************************************/
/*                            funcion : ifnFetchLimCreditos                  */
/*****************************************************************************/
static int ifnFetchLimCreditos (LIMCREDITOS *pL)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int     ihCodCredMor  ;
  static int     ihCodProducto ;
  static char   *szhCodCalClien;/* EXEC SQL VAR szhCodCalClien IS STRING(3) ; */ 

  static double  dhImpMorosidad;
  /* EXEC SQL END DECLARE SECTION; */ 


  szhCodCalClien = pL->szCodCalClien;

  /* EXEC SQL FETCH Cur_LimCreditos INTO :ihCodCredMor  ,
                                      :ihCodProducto ,
                                      :szhCodCalClien,
                                      :dhImpMorosidad; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3409;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCredMor;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodCalClien;
  sqlstm.sqhstl[2] = (unsigned long )3;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImpMorosidad;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Co_LimCreditos\n\t",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pL->iCodCredMor   = ihCodCredMor  ;
      pL->iCodProducto  = ihCodProducto ;
      pL->dImpMorosidad = dhImpMorosidad;
  }
  return SQLCODE;
}/*************************** Final ifnFetchLimCreditos **********************/

/*****************************************************************************/
/*                            funcion : ifnCloseLimCreditos                  */
/*****************************************************************************/
static int ifnCloseLimCreditos (void)
{
   /* EXEC SQL CLOSE Cur_LimCreditos; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )3440;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE)
       iDError (szExeName,ERR000,
                vInsertarIncidencia,"Close->Co_LimCreditos\n\t",
                szfnORAerror());
   return SQLCODE;
}/**************************** Final ifnCloseLimCreditos *********************/

/*****************************************************************************/
/*                             funcion : iCmpLimCreditos                     */
/*****************************************************************************/
int iCmpLimCreditos (const void *cad1,const void *cad2)
{
   int rc = 0;

   return
    ( (rc = ((LIMCREDITOS *)cad1)->iCodCredMor -
            ((LIMCREDITOS *)cad2)->iCodCredMor ) != 0)?rc:
    ( (rc = ((LIMCREDITOS *)cad1)->iCodProducto-
            ((LIMCREDITOS *)cad2)->iCodProducto) != 0)?rc:0;
}/**************************** Final iCmpLimCreditos *************************/

/*****************************************************************************/
/*                            funcion : bfnCargaLimCreditos                  */
/*****************************************************************************/
BOOL bfnCargaLimCreditos (LIMCREDITOS *pP, int *iNumP)
{
  int rc = 0,iCont = 0;
  BOOL bRes = TRUE;

  if (ifnOpenLimCreditos())
      bRes = FALSE;

  while (iCont<MAX_LIMCREDITOS && bRes)
  {
         rc = ifnFetchLimCreditos (&pP[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumP = iCont;
  if (rc == SQLNOTFOUND && *iNumP >= 0 && *iNumP <=MAX_LIMCREDITOS)
  {
      qsort (pP,*iNumP,sizeof(LIMCREDITOS),iCmpLimCreditos);
      vfnPrintLimCreditos (pP,*iNumP);
      bRes = TRUE;
  }
  if (rc == 0 && *iNumP == MAX_LIMCREDITOS)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Co_LimCreditos");
      bRes = FALSE;
  }
  return (bRes && ifnCloseLimCreditos () == 0)?TRUE:FALSE;

}/*************************** Final bCargaLimCreditos ************************/

/*****************************************************************************/
/*                          funcion : vfnPrintLimCreditos                    */
/*****************************************************************************/
static void vfnPrintLimCreditos (LIMCREDITOS *pL,int iL)
{
   int i = 0;

   vDTrazasLog (szExeName,"\n\t*** Tabla CO_LIMCREDITOS ",LOG06);

   for (i=0;i<iL;i++)
   {
        vDTrazasLog (szExeName,
        			"\n\t[%d]-CodCredMor  .....[%d]"
					"\n\t[%d]-CodProductos.....[%d]"
					"\n\t[%d]-CodCalCliens.....[%s]"
					"\n\t[%d]-CodCredMor  .....[%d]"
					"\n\t[%d]-ImpMorosidad.....[%f]"
					,LOG06,i,pL->iCodCredMor
					,i,pL->iCodProducto,i,pL->szCodCalClien
                    ,i,pL->iCodCredMor ,i,pL->iCodCredMor  );
        pL++;
   }
}/*************************** Final vfnPrintLimCreditos **********************/

/*****************************************************************************/
/*                          funcion : ifnOpenDesAcumulado                    */
/*****************************************************************************/
static int ifnOpenDesAcumulado (void)
{
  /* EXEC SQL DECLARE Cur_DesAcumulado CURSOR FOR
       SELECT /o+ full (FA_DESACUMULADO) o/
              COD_PRODUCTO ,
              DES_TOTALPROD,
              DES_ACUMCARGO,
              DES_ACUMIVA  ,
              DES_ACUMDTO
       FROM   FA_DESACUMULADO; */ 


  /* EXEC SQL OPEN Cur_DesAcumulado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0047;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3455;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Fa_DesAcumulado",
               szfnORAerror());
  return SQLCODE;
}/************************** Final ifnOpenDesAcumulado ***********************/

/*****************************************************************************/
/*                          funcion : ifnFetchDesAcumulado                   */
/*****************************************************************************/
static int ifnFetchDesAcumulado (DESACUMULADO *pDes)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodProducto  ;
  static char *szhDesTotalProd; /* EXEC SQL VAR szhDesTotalProd IS STRING(61); */ 

  static char *szhDesAcumCargo; /* EXEC SQL VAR szhDesAcumCargo IS STRING(61); */ 

  static char *szhDesAcumIva  ; /* EXEC SQL VAR szhDesAcumIva   IS STRING(61); */ 

  static char *szhDesAcumDto  ; /* EXEC SQL VAR szhDesAcumDto   IS STRING(61); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  szhDesTotalProd = pDes->szDesTotalProd;
  szhDesAcumCargo = pDes->szDesAcumCargo;
  szhDesAcumIva   = pDes->szDesAcumIva  ;
  szhDesAcumDto   = pDes->szDesAcumDto  ;

  /* EXEC SQL FETCH Cur_DesAcumulado INTO :ihCodProducto  ,
                                       :szhDesTotalProd,
                                       :szhDesAcumCargo,
                                       :szhDesAcumIva  ,
                                       :szhDesAcumDto  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3470;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesTotalProd;
  sqlstm.sqhstl[1] = (unsigned long )61;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhDesAcumCargo;
  sqlstm.sqhstl[2] = (unsigned long )61;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDesAcumIva;
  sqlstm.sqhstl[3] = (unsigned long )61;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhDesAcumDto;
  sqlstm.sqhstl[4] = (unsigned long )61;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Fa_DesAcumulado",
               szfnORAerror());
  if (SQLCODE == SQLOK)
      pDes->iCodProducto = ihCodProducto;
  return SQLCODE;
}/************************** Final ifnFetchDesAcumulado **********************/


/*****************************************************************************/
/*                          funcion : ifnCloseDesAcumulado                   */
/*****************************************************************************/
static int ifnCloseDesAcumulado (void)
{
  /* EXEC SQL CLOSE Cur_DesAcumulado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3505;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Fa_DesAcumulado",
               szfnORAerror());
  return  SQLCODE;
}/************************** Final ifnCloseDesAcumulado **********************/


/*****************************************************************************/
/*                          funcion : bfnCargaDesAcumulado                   */
/*****************************************************************************/
BOOL bfnCargaDesAcumulado (DESACUMULADO *pDes, int *iNumDes)
{
  int  rc    = 0   ;
  int  iCont = 0   ;
  BOOL bRes  = TRUE;

  if (ifnOpenDesAcumulado())
      bRes = FALSE;

  while (iCont<MAX_DESACUMULADO && bRes)
  {
         rc = ifnFetchDesAcumulado (&pDes[iCont]);
         switch (rc)
         {
              case 0 : iCont++;
                       break  ;
              default: bRes = FALSE;
                       break;
         }
  }
  *iNumDes = iCont;
  if (rc == SQLNOTFOUND && *iNumDes >= 0 && *iNumDes <=MAX_DESACUMULADO)
  {
      qsort (pDes,*iNumDes,sizeof(DESACUMULADO),ifnCmpDesAcumulado);
      vfnPrintDesAcumulado (pDes,*iNumDes)                         ;
      bRes = TRUE                                                  ;
  }

  if (rc == 0 && *iNumDes == MAX_DESACUMULADO)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_DesAcumulado");
      bRes = FALSE;
  }
  return ((bRes && (ifnCloseDesAcumulado () == 0))?TRUE:FALSE);

}/************************* Final bfnDesAcumulado ****************************/


/*****************************************************************************/
/*                         funcion : vfnPrintDesAcumulado                    */
/*****************************************************************************/
static void vfnPrintDesAcumulado (DESACUMULADO *pDes,int iNumDes)
{
  int i = 0;

  vDTrazasLog (szExeName,"\n\t\t*** Tabla FA_DESACUMULADO ***\n",LOG06);

  for (i=0;i<iNumDes;i++)
  {
       vDTrazasLog (szExeName,
       				"\n\t\t[%d]-Cod.Producto  ....[%d]"
					"\n\t\t[%d]-Des.Total.Prod....[%s]"
					"\n\t\t[%d]-Des.Acum.Cargo....[%s]"
					"\n\t\t[%d]-Des.Acum.Iva  ....[%s]"
					"\n\t\t[%d]-Des.Acum.Dto  ....[%s]"
					,LOG06,i,pDes[i].iCodProducto
                    ,i,pDes[i].szDesTotalProd
                    ,i,pDes[i].szDesAcumCargo
                    ,i,pDes[i].szDesAcumIva
                    ,i,pDes[i].szDesAcumDto );
  }
}/************************* Final vfnPrintDesAcumulado ***********************/

/*****************************************************************************/
/*                        funcion : iCmpDesAcumulado                         */
/*****************************************************************************/
int ifnCmpDesAcumulado (const void *cad1,const void *cad2)
{
  return ((DESACUMULADO *)cad1)->iCodProducto -
         ((DESACUMULADO *)cad2)->iCodProducto;
}/************************ Final ifnCmpDesAcumulado **************************/

/*****************************************************************************/
/*                        funcion : bfnFindDesAcumulado                      */
/*****************************************************************************/
BOOL bfnFindDesAcumulado (int           iCodProducto,
                          DESACUMULADO *pDes)
{
  DESACUMULADO  stkey                      ;
  DESACUMULADO *pD   = (DESACUMULADO *)NULL;

  memset (&stkey,0,sizeof(DESACUMULADO));

  stkey.iCodProducto = iCodProducto;

  if ((pD = (DESACUMULADO *)bsearch (&stkey,pstDesAcumulado,NUM_DESACUMULADO,
             sizeof(DESACUMULADO),ifnCmpDesAcumulado)) == (DESACUMULADO *)NULL)
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstDesAcumulado");
       return  FALSE                                                   ;
  }
  else
       memcpy  (pDes,pD,sizeof(DESACUMULADO));

  return TRUE;
}/************************ Final bfnFindDesAcumulado *************************/

/*****************************************************************************/
/*                        funcion : ifnDBOpenOptimo                          */
/*****************************************************************************/
static int ifnDBOpenOptimo (void)
{
  /* EXEC SQL DECLARE Cur_Optimo CURSOR FOR
       SELECT /o+ full (FA_OPTIMO) o/
              COD_PLANTARIF,
              MIN_DESDE    ,
              MIN_HASTA    ,
              PRC_ABONO    ,
              PRC_NORMAL   ,
              PRC_BAJO
       FROM   FA_OPTIMO; */ 


  vDTrazasLog (szExeName,"\n\t\t* Entrada a Open Cursor Fa_Optimo", LOG06);

  /* EXEC SQL OPEN Cur_Optimo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0048;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3520;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLOK)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open=>Fa_Optimo",
               szfnORAerror ());
  }
  return (SQLCODE);
}/************************** Final ifnDBOpenOptimo ***************************/

/*****************************************************************************/
/*                           funcion : ifnDBFetchOptimo                      */
/*****************************************************************************/
static int ifnDBFetchOptimo (OPTIMO *pstOptimo)
{
    static short i_shMinHasta = 0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         /* EXEC SQL VAR pstOptimo->szCodPlanTarif IS STRING (4); */ 

    /* EXEC SQL END DECLARE SECTION  ; */ 


    vDTrazasLog (szExeName,"\n\t\t* Entrada a Fetch Fa_Optimo", LOG06);

    /* EXEC SQL FETCH Cur_Optimo INTO :pstOptimo->szCodPlanTarif        ,
                                   :pstOptimo->lMinDesde             ,
                                   :pstOptimo->lMinHasta:i_shMinHasta,
                                   :pstOptimo->fPrcAbono             ,
                                   :pstOptimo->fPrcNormal            ,
                                   :pstOptimo->fPrcBajo              ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3535;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstOptimo->szCodPlanTarif);
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pstOptimo->lMinDesde);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&(pstOptimo->lMinHasta);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)&i_shMinHasta;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(pstOptimo->fPrcAbono);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&(pstOptimo->fPrcNormal);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&(pstOptimo->fPrcBajo);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=>Fa_Optimo",
                 szfnORAerror ());
    }
    if (SQLCODE == SQLOK)
    {
        if (i_shMinHasta == -1)
            pstOptimo->lMinHasta = -1;
    }
    return SQLCODE;
}/************************** Final ifnDBFetchOptimo **************************/

/*****************************************************************************/
/*                          funcion : ifnDBCloseOptimo                       */
/*****************************************************************************/
static int ifnDBCloseOptimo (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Entrada a Close Fa_Optimo", LOG06);

    /* EXEC SQL CLOSE Cur_Optimo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3574;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Close=>Fa_Optimo",
                 szfnORAerror ());
    return SQLCODE;
}/************************* Final ifnDBCloseOptimo ***************************/

/*****************************************************************************/
/*                          funcion : ifnCmpOptimo                           */
/*****************************************************************************/
int ifnCmpOptimo (const void *cad1, const void *cad2)
{
   int rc = 0;

   return ( (rc = strcmp ( ((OPTIMO *)cad1)->szCodPlanTarif,
                           ((OPTIMO *)cad2)->szCodPlanTarif)) != 0)?rc:
          ( ((OPTIMO *)cad1)->lMinDesde < ((OPTIMO *)cad2)->lMinDesde )?-1:
          ( ((OPTIMO *)cad1)->lMinDesde > ((OPTIMO *)cad2)->lMinDesde )? 1:0;
}/************************* Final ifnCmpOptimo *******************************/

/*****************************************************************************/
/*                         funcion : bfnCargaOptimo                          */
/*****************************************************************************/
BOOL bfnCargaOptimo (OPTIMO *pstOpt, int *iNumOptimo)
{
  int  iNumReg = 0    ;
  int  rc      = 0    ;
  BOOL bRes    = TRUE ;

  if (ifnDBOpenOptimo ())
      return FALSE;

  while (bRes && iNumReg < MAX_OPTIMO)
  {
         rc = ifnDBFetchOptimo (&pstOpt [iNumReg]);
         switch (rc)
         {
             case SQLOK:
                  iNumReg++;
                  break    ;
             default   :
                  bRes = FALSE;
                  break       ;
         }
  }
  *iNumOptimo = iNumReg;
  if (rc == SQLNOTFOUND && *iNumOptimo >= 0 && *iNumOptimo <= MAX_OPTIMO)
  {
      qsort (pstOpt,*iNumOptimo,sizeof(OPTIMO),ifnCmpOptimo);
      bRes = TRUE                                           ;
  }
  if (rc == 0 && *iNumOptimo == MAX_OPTIMO)
  {
      iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_Optimo");
      bRes = FALSE;
  }
  return (bRes && ifnDBCloseOptimo () == 0)?TRUE:FALSE;
}/************************* Final bfnCargaOptimo *****************************/

/*****************************************************************************/
/*                         funcion : bfnFindOptimo                           */
/*****************************************************************************/
BOOL bfnFindOptimo (OPTIMO *pstOpt)
{
  BOOL    bRes    = TRUE          ;
  OPTIMO  stkey                   ;
  OPTIMO *pOptimo = (OPTIMO *)NULL;

  memset (&stkey, 0, sizeof (OPTIMO));

  strcpy (stkey.szCodPlanTarif, pstOpt->szCodPlanTarif);

  stkey.lMinDesde = pstOpt->lMinDesde;

  if ((pOptimo =
      (OPTIMO *)bsearch ((OPTIMO *)&stkey, pstOptimo, NUM_OPTIMO,
                          sizeof (OPTIMO), ifnCmpOptimo))==(OPTIMO *)NULL)
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstOptimo");
       bRes =  FALSE;
  }
  else
  {
       memcpy (pstOpt, pOptimo, sizeof (OPTIMO));
  }
  return (bRes);
}/************************ Final bfnFindOptimo *******************************/

/*****************************************************************************/
/*                         funcion : ifnDBOpenAlms                           */
/*****************************************************************************/
static int ifnDBOpenAlms (void)
{
  /* EXEC SQL DECLARE Cur_Alms CURSOR FOR
       SELECT /o+ full (GE_ALMS) o/
              COD_ALM,
              DES_ALM
       FROM   GE_ALMS; */ 


  vDTrazasLog (szExeName,"\n\t\t* Entrada Open Ge_Alms",LOG06);

  /* EXEC SQL OPEN Cur_Alms; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0049;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3589;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open=>Ge_Alms",
               szfnORAerror ());
  return (SQLCODE);
}/************************** Final ifnDBOpenAlms *****************************/

/*****************************************************************************/
/*                         funcion : ifnDBFetchAlms                          */
/*****************************************************************************/
static int ifnDBFetchAlms (ALMS *pAlm)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhCodAlm ;/* EXEC SQL VAR szhCodAlm IS STRING (4); */ 

  static char *szhDesAlm ;/* EXEC SQL VAR szhDesAlm IS STRING(31); */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Entrada Fetch Ge_Alms",LOG06);

  szhCodAlm = pAlm->szCodAlm;
  szhDesAlm = pAlm->szDesAlm;

  /* EXEC SQL FETCH Cur_Alms INTO :szhCodAlm, :szhDesAlm; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3604;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodAlm;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDesAlm;
  sqlstm.sqhstl[1] = (unsigned long )31;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=>Ge_Alms",
               szfnORAerror ());

   return (SQLCODE);
}/*************************** Final ifnDBFetchAlms ***************************/

/*****************************************************************************/
/*                            funcion : ifnDBCloseAlms                       */
/*****************************************************************************/
static int ifnDBCloseAlms (void)
{
   vDTrazasLog (szExeName,"\n\t\t* Entrada Close Ge_Alms",LOG06);

   /* EXEC SQL CLOSE Cur_Alms; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )3627;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=>Ge_Alms",
                szfnORAerror ());
   return (SQLCODE);
}/**************************** Final ifnDBCloseAlms **************************/

/*****************************************************************************/
/*                          funcion : ifnCmpAlms                             */
/*****************************************************************************/
int ifnCmpAlms (const void *cad1, const void *cad2)
{
  return strcmp ( ((ALMS *)cad1)->szCodAlm, ((ALMS *)cad2)->szCodAlm);
}/************************** Final ifnCmpAlms ********************************/

/*****************************************************************************/
/*                           funcion : bfnCargaAlms                          */
/*****************************************************************************/
BOOL bfnCargaAlms (ALMS *pAlm, int *iNumAlms)
{
   int  rc      = 0    ;
   int  iNumReg = 0    ;
   BOOL bRes    = TRUE ;

  vDTrazasLog (szExeName,"\n\t\t* Entrada Carga Ge_Alms",LOG06);

   if (ifnDBOpenAlms ())
       return FALSE;

   while (bRes && iNumReg < MAX_ALMS)
   {
          rc = ifnDBFetchAlms (&pAlm [iNumReg]);
          switch (rc)
          {
              case SQLOK:
                   iNumReg++;
                   break    ;
              default   :
                   bRes = FALSE;
                   break       ;
          }
   }
   *iNumAlms = iNumReg;

   if (rc == SQLNOTFOUND && *iNumAlms >= 0 && *iNumAlms <= MAX_OPTIMO)
   {
       qsort (pAlm,*iNumAlms,sizeof (ALMS),ifnCmpAlms);
       bRes = TRUE ;
   }
   if (rc == 0 && *iNumAlms == MAX_ALMS)
   {
       iDError (szExeName,ERR016,vInsertarIncidencia,"Ge_Alms");
       bRes = FALSE;
   }
   return (bRes && ifnDBCloseAlms () == 0)?TRUE:FALSE;
}/***************************** Final bfnCargaAlms ***************************/

/*****************************************************************************/
/*                            funcion : bfnFindAlms                          */
/*****************************************************************************/
BOOL bfnFindAlms (ALMS *pstAlm)
{
  ALMS  stkey              ;
  ALMS *pstA = (ALMS *)NULL;
  BOOL  bRes = TRUE        ;

  memset (&stkey, 0, sizeof (stkey));

  strcpy (stkey.szCodAlm, pstAlm->szCodAlm);

  if ((pstA = (ALMS *)bsearch (&stkey, pstAlms, NUM_ALMS, sizeof (ALMS),
                               ifnCmpAlms)) == (ALMS *)NULL)
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstAlms (Ge_Alms)");
       bRes = FALSE;
  }
  else
       memcpy (pstAlm, pstA, sizeof (ALMS));

  return bRes;
}/***************************** Final bfnFindAlms ****************************/

/*****************************************************************************/
/*                           funcion : vfnPrintTipTerminales                */
/*****************************************************************************/
void vfnPrintTipTerminales (GTIPOSTERMINALES stGTipTerm)
{
  int i = 0;

  vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Al_Tipos_terminales", LOG06);

  for (i=0;i<stGTipTerm.iNumReg;i++)
  {
       vDTrazasLog (szExeName,
                    "\n\t\t=> [%d]-Cod.Producto     [%d]"
                    "\n\t\t=> [%d]-Tip.Terminal     [%s]"
                    "\n\t\t=> [%d]-Des.Terminal     [%s]", LOG06  ,
                    i, stGTipTerm.pstTipTerminal [i].iCodProducto ,
                    i, stGTipTerm.pstTipTerminal [i].szTipTerminal,
                    i, stGTipTerm.pstTipTerminal [i].szDesTerminal);
  }
}/*************************** vfnPrintTipTerminales **************************/


/*****************************************************************************/
/*                           funcion : ifnCmpTipTerminales                   */
/*****************************************************************************/
int ifnCmpTipTerminales (const void* cad1, const void* cad2)
{
    int rc = 0;

    return ((rc = strcmp(((TIPOSTERMINALES *)cad1)->szTipTerminal,
                         ((TIPOSTERMINALES *)cad2)->szTipTerminal)) != 0)?rc:0;

}/**************************** Final ifnCmpTipTerminales  ********************/

/*****************************************************************************/
/*                         funcion : bfnCargaTipTerminales                   */
/*****************************************************************************/
BOOL bfnCargaTipTerminales (GTIPOSTERMINALES *pstGTipTerm)
{
     int rc = 0;

     TIPOSTERMINALES stTipTerm;

     vDTrazasLog (szExeName,"\n\t\t* Carga AL_TIPOS_TERMINALES", LOG06);

     if (ifnDBOpenTipTerminales ())
         return FALSE;


     while (rc == SQLOK)
     {
            rc = ifnDBFetchTipTerminales (&stTipTerm);

            switch (rc)
            {
              case SQLOK:
                 if ((pstGTipTerm->pstTipTerminal =
        (TIPOSTERMINALES*)realloc((TIPOSTERMINALES*)pstGTipTerm->pstTipTerminal,
                    (pstGTipTerm->iNumReg + 1) * sizeof (TIPOSTERMINALES)))
                                        ==  (TIPOSTERMINALES *)NULL)
                 {
                     iDError (szExeName,ERR005,vInsertarIncidencia,
                              "pstGTipTerm->pstTipTerminal");
                     return  (FALSE)              ;
                 }
                 memcpy (&pstGTipTerm->pstTipTerminal[pstGTipTerm->iNumReg],
                         &stTipTerm, sizeof (TIPOSTERMINALES));
                 pstGTipTerm->iNumReg++              ;
                 break;
              case SQLNOTFOUND:
                 if (ifnDBCloseTipTerminales())
                     return FALSE;
                 break;
              default   :
                 return FALSE;

            }/* fin switch ... */

     }/* fin while ... */

     if (pstGTipTerm->iNumReg > 0)
     {
         vfnPrintTipTerminales (*pstGTipTerm);
         qsort (pstGTipTerm->pstTipTerminal, pstGTipTerm->iNumReg,
                sizeof (TIPOSTERMINALES), ifnCmpTipTerminales );
     }

     return TRUE;
}/**************************** Final bfnCargaTipTerminales  ******************/


/*****************************************************************************/
/*                           funcion : ifnDBOpenTipTerminales                */
/*****************************************************************************/
static int ifnDBOpenTipTerminales (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Open=> Al_Tipos_Terminales", LOG06);

  /* EXEC SQL DECLARE Cur_TipTerminales CURSOR FOR
       SELECT /o+ full (AL_TIPOS_TERMINALES) o/
              COD_PRODUCTO     ,
              TIP_TERMINAL     ,
              DES_TERMINAL
         FROM AL_TIPOS_TERMINALES; */ 


  /* EXEC SQL OPEN Cur_TipTerminales; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0050;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3642;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
     iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Al_Tipos_Terminales",
               szfnORAerror ());

  return SQLCODE;
}/************************** Final ifnDBOpenTipTerminales ********************/


/*****************************************************************************/
/*                         funcion : ifnDBFetchTipTerminales                 */
/*****************************************************************************/
static int ifnDBFetchTipTerminales (TIPOSTERMINALES *pstTipTerminal)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  /* EXEC SQL VAR pstTipTerminal->szTipTerminal IS STRING (2) ; */ 

  /* EXEC SQL VAR pstTipTerminal->szDesTerminal IS STRING (16); */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Fetch=> Al_Tipos_Terminales", LOG06);

  /* EXEC SQL FETCH Cur_TipTerminales  INTO :pstTipTerminal->iCodProducto ,
                                         :pstTipTerminal->szTipTerminal,
                                         :pstTipTerminal->szDesTerminal; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3657;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&(pstTipTerminal->iCodProducto);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstTipTerminal->szTipTerminal);
  sqlstm.sqhstl[1] = (unsigned long )2;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstTipTerminal->szDesTerminal);
  sqlstm.sqhstl[2] = (unsigned long )16;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Al_Tipos_Terminales",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final ifnDBFetchTipTerminales ****************/


/*****************************************************************************/
/*                           funcion : ifnDBCloseTipTerminales               */
/*****************************************************************************/
static int ifnDBCloseTipTerminales (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Al_Tipos_Terminales", LOG06);

  /* EXEC SQL CLOSE Cur_TipTerminales; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3684;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Al_Tipos_Terminales",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnDBCloseTipTerminales ****************/


/*****************************************************************************/
/*                             funcion : bfnFindTipTerminales                */
/*****************************************************************************/
BOOL bfnFindTipTerminales (TIPOSTERMINALES *pstTipTerminal)
{
     TIPOSTERMINALES  stkey;
     TIPOSTERMINALES *pstAux = (TIPOSTERMINALES *)NULL;

     vDTrazasLog (szExeName,
                  "\n\t\t* Busca Tipos de Terminales (Al_Tipos_Terminales)"
                  "\n\t\t=> Tipo Terminal    [%s]", LOG06,
                  pstTipTerminal->iCodProducto, pstTipTerminal->szTipTerminal);

     strcpy (stkey.szTipTerminal, pstTipTerminal->szTipTerminal);

     if ( (pstAux =
          (TIPOSTERMINALES *)bsearch (&stkey, stGTiposTerminales.pstTipTerminal,
                                      stGTiposTerminales.iNumReg              ,
                                      sizeof (TIPOSTERMINALES)                 ,
                                      ifnCmpTipTerminales ))
                  == (TIPOSTERMINALES *)NULL)
     {
          iDError (szExeName,ERR021,vInsertarIncidencia,"stGTiposTerminales");
          return  (FALSE)                                                    ;
     }
     else
     {
        strcpy (pstTipTerminal->szDesTerminal, pstAux->szDesTerminal);
     }
     return TRUE;
}/**************************** Final bfnFindTipTerminales *******************/


/*****************************************************************************/
/*                           funcion : ifnCmpTipCobertura                    */
/*****************************************************************************/
int ifnCmpTipCobertura (const void* cad1, const void* cad2)
{
    int rc = 0;

    return ((rc = ((TIPCOBERTURA *)cad1)->iTipCobertura -
                  ((TIPCOBERTURA *)cad2)->iTipCobertura) != 0)?rc:0;

}/**************************** Final ifnCmpTipCobertura **********************/


/*****************************************************************************/
/*                           funcion : vfnPrintTipCobertura                  */
/*****************************************************************************/
void vfnPrintTipCobertura (GTIPCOBERTURA stGTipCober)
{
  int i = 0;

  vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Ga_TipCobertura", LOG06);

  for (i=0;i<stGTipCober.iNumReg;i++)
  {
       vDTrazasLog (szExeName,
                    "\n\t\t=> [%d]-Tipo Cobertura       [%d]"
                    "\n\t\t=> [%d]-Des. Tipo Cobertura  [%s]"
                    "\n\t\t=> [%d]-Cod. Servicio        [%s]"
                    "\n\t\t=> [%d]-Cod. Producto        [%d]", LOG06  ,
                    i, stGTipCober.pstTipCobertura [i].iTipCobertura  ,
                    i, stGTipCober.pstTipCobertura [i].szDesTipCobert ,
                    i, stGTipCober.pstTipCobertura [i].szCodServicio  ,
                    i, stGTipCober.pstTipCobertura [i].iCodProducto);
  }
}/*************************** vfnPrintTipCobertura **************************/



/*****************************************************************************/
/*                         funcion : bfnCargaTipCobertura                    */
/*****************************************************************************/
BOOL bfnCargaTipCobertura (GTIPCOBERTURA *pstGTipCober)
{
     int rc = 0;

     TIPCOBERTURA stTipCobert;

     vDTrazasLog (szExeName,"\n\t\t* Carga Ga_TipCobertura", LOG06);

     if (ifnDBOpenTipCobertura ())
         return FALSE;


     while (rc == SQLOK)
     {
            rc = ifnDBFetchTipCobertura (&stTipCobert);

            switch (rc)
            {
              case SQLOK:
                 if ((pstGTipCober->pstTipCobertura =
            (TIPCOBERTURA*)realloc((TIPCOBERTURA*)pstGTipCober->pstTipCobertura,
                    (pstGTipCober->iNumReg + 1) * sizeof (TIPCOBERTURA)))
                                        ==  (TIPCOBERTURA *)NULL)
                 {
                     iDError (szExeName,ERR005,vInsertarIncidencia,
                              "pstGTipCober->pstTipCobertura");
                     return  (FALSE);
                 }
                 memcpy (&pstGTipCober->pstTipCobertura[pstGTipCober->iNumReg],
                         &stTipCobert, sizeof (TIPCOBERTURA));
                 pstGTipCober->iNumReg++;
                 break;
              case SQLNOTFOUND:
                 if (ifnDBCloseTipCobertura())
                     return FALSE;
                 break;
              default   :
                 return FALSE;

            }/* fin switch ... */

     }/* fin while ... */

     if (pstGTipCober->iNumReg > 0)
     {
         vfnPrintTipCobertura (*pstGTipCober);
         qsort (pstGTipCober->pstTipCobertura, pstGTipCober->iNumReg,
                sizeof (TIPCOBERTURA), ifnCmpTipCobertura );
     }

     return TRUE;
}/**************************** Final bfnCargaTipCobertura  *******************/


/*****************************************************************************/
/*                           funcion : ifnDBOpenTipCobertura                 */
/*****************************************************************************/
static int ifnDBOpenTipCobertura (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Open=> Ga_TipCobertura", LOG06);

  /* EXEC SQL DECLARE Cur_TipCobertura CURSOR FOR
       SELECT /o+ full (GA_TIPCOBERTURA) o/
              TIP_COBERTURA     ,
              DES_TIPCOBERT     ,
              COD_SERVICIO      ,
              COD_PRODUCTO
         FROM GA_TIPCOBERTURA; */ 


  /* EXEC SQL OPEN Cur_TipCobertura; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0051;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3699;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
     iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ga_TipCobertura",
               szfnORAerror ());

  return SQLCODE;
}/************************** Final ifnDBOpenTipCobertura *********************/


/*****************************************************************************/
/*                         funcion : ifnDBFetchTipCobertura                  */
/*****************************************************************************/
static int ifnDBFetchTipCobertura (TIPCOBERTURA *pstTipCobertura)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  /* EXEC SQL VAR pstTipCobertura->szDesTipCobert IS STRING (31); */ 

  /* EXEC SQL VAR pstTipCobertura->szCodServicio  IS STRING (4) ; */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Fetch=> Ga_TipCobertura", LOG06);

  /* EXEC SQL FETCH Cur_TipCobertura   INTO :pstTipCobertura->iTipCobertura ,
                                         :pstTipCobertura->szDesTipCobert,
                                         :pstTipCobertura->szCodServicio ,
                                         :pstTipCobertura->iCodProducto  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3714;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&(pstTipCobertura->iTipCobertura);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstTipCobertura->szDesTipCobert);
  sqlstm.sqhstl[1] = (unsigned long )31;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstTipCobertura->szCodServicio);
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&(pstTipCobertura->iCodProducto);
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Ga_TipCobertura ",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final ifnDBFetchTipCobertura ****************/


/*****************************************************************************/
/*                           funcion : ifnDBCloseTipCobertura                */
/*****************************************************************************/
static int ifnDBCloseTipCobertura (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Ga_TipCobertura", LOG06);

  /* EXEC SQL CLOSE Cur_TipCobertura; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3745;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Ga_TipCobertura",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnDBCloseTipCobertura ******************/


/*****************************************************************************/
/*                             funcion : bfnFindTipCobertura                 */
/*****************************************************************************/
BOOL bfnFindTipCobertura (TIPCOBERTURA *pstTipCobertura)
{
     TIPCOBERTURA  stkey;
     TIPCOBERTURA *pstAux = (TIPCOBERTURA *)NULL;

     vDTrazasLog (szExeName,
                  "\n\t\t* Busca Coberturas (Ga_TipCobertura)"
                  "\n\t\t=> Tipo Cobertura   [%d]", LOG06,
                  pstTipCobertura->iTipCobertura );

     stkey.iTipCobertura = pstTipCobertura->iTipCobertura;

     if ( (pstAux =
          (TIPCOBERTURA *)bsearch (&stkey, stGTipCoberturas.pstTipCobertura,
                                      stGTipCoberturas.iNumReg             ,
                                      sizeof (TIPCOBERTURA)                ,
                                      ifnCmpTipCobertura ))
                  == (TIPCOBERTURA *)NULL)
     {
          iDError (szExeName,ERR021,vInsertarIncidencia,"stGTipCoberturas");
          return  (FALSE)                                                  ;
     }
     else
     {
        strcpy (pstTipCobertura->szDesTipCobert, pstAux->szDesTipCobert);
     }
     return TRUE;
}/**************************** Final bfnFindTipCobertura *******************/

BOOL bfnCargaFeriados (FERIADOS *pstFeriados, int *iNumFeriados)
{
   int iNumFer = 0, rc = 0;

   if (bfnOpenFeriados())
       return FALSE;

   for (iNumFer=0;iNumFer<MAX_FERIADOS;iNumFer++)
   {
        rc = bfnFetchFeriados (&pstFeriados[iNumFer]);
        if (rc == SQLNOTFOUND)
            break;
        if (rc != 0)
            return FALSE;
   }/* fin for ->(;;) */

   if (rc == 0 && iNumFer == MAX_FERIADOS)
   {
       iDError (szExeName,ERR016,vInsertarIncidencia,"Ta_DiasFest");
       return FALSE;
   }

   *iNumFeriados = iNumFer;
   return ( bfnCloseFeriados () )?FALSE:TRUE;
}

static BOOL bfnOpenFeriados (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ta_DiasFest", LOG06);

    /* EXEC SQL DECLARE Cur_Feriados CURSOR FOR
         SELECT TO_CHAR(FEC_DIAFEST,'YYYYMMDDHH24MISS')
           FROM TA_DIASFEST; */ 


    /* EXEC SQL OPEN Cur_Feriados; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0052;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3760;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ta_DisaFest",
                 szfnORAerror ());

    return SQLCODE;
}

static BOOL bfnFetchFeriados (FERIADOS *pstFeriados)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

      /* EXEC SQL VAR pstFeriados->szFecFeriado IS STRING (15) ; */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Fetch=> Ta_DiasFest", LOG06);

  /* EXEC SQL FETCH Cur_Feriados INTO :pstFeriados->szFecFeriado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3775;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstFeriados->szFecFeriado);
  sqlstm.sqhstl[0] = (unsigned long )15;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Ta_DiasFest",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bFetchFeriados ****************/

static BOOL bfnCloseFeriados (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Ta_DiasFest", LOG06);

  /* EXEC SQL CLOSE Cur_Feriados; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3794;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Ta_DiasFest",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnDBCloseTipCobertura ******************/


/* ************************************************************************* */
/* bfnCargaFaCiclFact: Carga los codigos de ciclo para procesar el trafico   */
/* rao20030916: Se quita del prebilling y se genera en el ORAcarga			 */
/* ************************************************************************* */
BOOL bfnCargaFaCiclFact (int *pstFaCiclFact, int *iNumFaCiclFact)
{
   	int iNumFac = 0, rc = 0;

   	if (bfnOpenFaCiclFact())
       return FALSE;

	vDTrazasLog (szExeName,"\n\t\t* Fetch=> Fa_CiclFact", LOG06);
   	for (iNumFac=0;iNumFac<MAX_CICLFACT;iNumFac++)
   	{
      	rc = bfnFetchFaCiclFact (&pstFaCiclFact[iNumFac]);
        if (rc == SQLNOTFOUND)
            break;
        if (rc != 0)
            return FALSE;
   	}/* fin for ->(;;) */

   	if (rc == 0 && iNumFac == MAX_CICLFACT)
   	{
       iDError (szExeName,ERR016,vInsertarIncidencia,"Fa_CiclFact");
       return FALSE;
   	}
   	*iNumFaCiclFact = iNumFac;
	vfnPrintFaCiclFact (pstFaCiclFact, *iNumFaCiclFact);

   	return ( bfnCloseFaCiclFact () )?FALSE:TRUE;
}/***************************** Final bfnCargaFaCiclFact *********************/

static BOOL bfnOpenFaCiclFact (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ta_DiasFest", LOG06);

    /* EXEC SQL DECLARE Cur_FaCiclFact CURSOR FOR
         SELECT COD_CICLFACT
   		   FROM FA_CICLFACT
   		  WHERE COD_CICLO IN (SELECT COD_CICLO FROM FA_CICLOS WHERE DIG_C > 0)
    		AND IND_FACTURACION IN (1, 2)
   		  ORDER BY FEC_DESDECFIJOS DESC; */ 


    /* EXEC SQL OPEN Cur_FaCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0053;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3809;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ta_DisaFest",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final bfnOpenFaCiclFact **********************/

static BOOL bfnFetchFaCiclFact (int *pstFaCiclFact)
{


  /* EXEC SQL FETCH Cur_FaCiclFact INTO :pstFaCiclFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3824;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)pstFaCiclFact;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Fa_CiclFact",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bfnFetchFaCiclFact ****************/

/*****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                    */
/*****************************************************************************/
void vfnPrintFaCiclFact (int *pstFaCiclFact, int iNumFaCiclFact)
{
  int i = 0;

  vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Fa_CiclFact [%d]", LOG06, iNumFaCiclFact);

  for (i=0;i<iNumFaCiclFact;i++)
  {
       vDTrazasLog (szExeName,"\n\t\t=> [%d]-Codigo de Ciclo  [%d]",LOG06  ,
                    		i, pstFaCiclFact[i]);
  }
}/*************************** vfnPrintFaCiclFact *****************************/

static BOOL bfnCloseFaCiclFact (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Fa_CiclFact", LOG06);

  /* EXEC SQL CLOSE Cur_FaCiclFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3843;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Fa_CiclFact",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final bfnCloseFaCiclFact ******************/


/* ************************************************************************* */
/* bfnCargaFactCobr: Carga los datos de la tabla Fa_FactCobr			     */
/* ************************************************************************* */
BOOL bfnCargaFactCobr (FACTCOBR **pstFactCobr, int *iNumFactCobr)
{
   	int 	rc = 0;
	long 	lNumFilas;
	static 	FACTCOBR_HOSTS stFactCobrHost;
	FACTCOBR *pstFactCobrTemp;
	long lCont;

	vDTrazasLog (szExeName,"\n\t* Carga Fa_FactCobr ", LOG06);

 	*iNumFactCobr = 0;
 	*pstFactCobr = NULL;

   	if (ifnOpenFactCobr())
       return FALSE;

	while (rc != SQLNOTFOUND)
	{
      	rc = bfnFetchFactCobr (&stFactCobrHost,&lNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
			return FALSE;

		if (!lNumFilas)
		break;

 		*pstFactCobr =(FACTCOBR*) realloc(*pstFactCobr,(((*iNumFactCobr)+lNumFilas)*sizeof(FACTCOBR)));

		if (!*pstFactCobr)
		{
			iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaFactCobr", "no se pudo reservar memoria");
			return FALSE;
		}

		pstFactCobrTemp = &(*pstFactCobr)[(*iNumFactCobr)];
		memset(pstFactCobrTemp, 0, sizeof(FACTCOBR)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstFactCobrTemp[lCont].iCodConcFact	= stFactCobrHost.iCodConcFact	[lCont];
			pstFactCobrTemp[lCont].iCodConCobr	= stFactCobrHost.iCodConCobr	[lCont];
		}
		(*iNumFactCobr) += lNumFilas;

   	}/* fin while */

	vDTrazasLog (szExeName,"\n\t\t* Fa_FactCobr cargadas [%d]", LOG06, *iNumFactCobr);

	rc = ifnCloseFactCobr();
	if (rc != SQLOK)
	{
		iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaOficinas", szfnORAerror ());
		return FALSE;
	}

	qsort((void*)*pstFactCobr, *iNumFactCobr, sizeof(FACTCOBR),ifnCmpFactCobr);

	vfnPrintFactCobr (*pstFactCobr, *iNumFactCobr);

	return (TRUE);
}/***************************** Final bfnCargaFactCobr *********************/


static int ifnOpenFactCobr (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ge_Oficinas;Ge_Direcciones;Ge_Ciudades", LOG06);

    /* EXEC SQL DECLARE Cur_FactCobr CURSOR FOR
        SELECT COD_CONCFACT, COD_CONCCOBR
          FROM FA_FACTCOBR; */ 


    /* EXEC SQL OPEN Cur_FactCobr; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0054;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3858;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Fa_FactCobr",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenFactCobr **********************/

static BOOL bfnFetchFactCobr (FACTCOBR_HOSTS *pstHost,long *plNumFilas)
{

  	/* EXEC SQL FETCH Cur_FactCobr
  			  INTO :pstHost->iCodConcFact	,
				   :pstHost->iCodConCobr; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )2000;
   sqlstm.offset = (unsigned int  )3873;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodConcFact);
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )sizeof(int);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodConCobr);
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )sizeof(int);
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




	if (SQLCODE==SQLOK)
		*plNumFilas = TAM_HOSTS_PEQ;
	else
		if (SQLCODE==SQLNOTFOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
		else
			iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Fa_FactCobr",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bfnFetchFactCobr ****************/

/*****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                    */
/*****************************************************************************/
void vfnPrintFactCobr (FACTCOBR *pstFactCobr, int iNumFactCobr)
{
  int i = 0;

	if (stStatus.LogNivel >= LOG06)
	{
  		vDTrazasLog (szExeName,"\n\t\t* Carga Tabla de conceptos de cobro [%d]", LOG06, iNumFactCobr);

  		for (i=0;i<iNumFactCobr;i++)
  		{
  		     vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo Conc. Facturacion  [%d]"
  		     						"\n\t\t=> [%d]: Codigo Conc. Cobros       [%d]"
  		     						,LOG06
  		     						,i, pstFactCobr[i].iCodConcFact
  		     						,i, pstFactCobr[i].iCodConCobr);

  		}
  	}
}/*************************** vfnPrintFaCiclFact *****************************/

int ifnCloseFactCobr (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Fa_FactCobr", LOG06);

  /* EXEC SQL CLOSE Cur_FactCobr; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3896;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Fa_FactCobr",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnCloseFactCobr ******************/

/* ************************************************************************* */
/* bfnCargaOficinas: Carga los datos de las oficinas					     */
/* ************************************************************************* */
BOOL bfnCargaOficinas (OFICINA **pstOficinas, int *iNumOficinas)
{
   	int 	rc = 0;
	long 	lNumFilas;
	static 	OFICINA_HOSTS stOficinasHost;
	OFICINA *pstOficinasTemp;
	long lCont;

	vDTrazasLog (szExeName,"\n\t* Carga Oficinas ", LOG06);

 	*iNumOficinas = 0;
 	*pstOficinas = NULL;

   	if (ifnOpenOficinas())
       return FALSE;

	while (rc != SQLNOTFOUND)
	{
      	rc = bfnFetchOficinas (&stOficinasHost,&lNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
			return FALSE;

		if (!lNumFilas)
		break;

 		*pstOficinas =(OFICINA*) realloc(*pstOficinas,(((*iNumOficinas)+lNumFilas)*sizeof(OFICINA)));

		if (!*pstOficinas)
		{
			iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaOficinas", "no se pudo reservar memoria");
			return FALSE;
		}

		pstOficinasTemp = &(*pstOficinas)[(*iNumOficinas)];
		memset(pstOficinasTemp, 0, sizeof(OFICINA)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstOficinasTemp[lCont].szCodOficina	,stOficinasHost.szCodOficina	[lCont]);
			strcpy(pstOficinasTemp[lCont].szCodRegion	,stOficinasHost.szCodRegion		[lCont]);
			strcpy(pstOficinasTemp[lCont].szCodProvincia,stOficinasHost.szCodProvincia 	[lCont]);
			strcpy(pstOficinasTemp[lCont].szCodCiudad 	,stOficinasHost.szCodCiudad 	[lCont]);
			strcpy(pstOficinasTemp[lCont].szCodPlaza	,stOficinasHost.szCodPlaza	    [lCont]);
		}
		(*iNumOficinas) += lNumFilas;

   	}/* fin while */

	vDTrazasLog (szExeName,"\n\t\t* Oficinas cargadas [%ld]", LOG06, *iNumOficinas);

	rc = ifnCloseOficinas();
	if (rc != SQLOK)
	{
		iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaOficinas", szfnORAerror ());
		return FALSE;
	}

	qsort((void*)*pstOficinas, *iNumOficinas, sizeof(OFICINA),ifnCmpOficinas);

	vfnPrintOficinas (*pstOficinas, *iNumOficinas);

	return (TRUE);
}/***************************** Final bfnCargaOficinas *********************/


static int ifnOpenOficinas (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ge_Oficinas;Ge_Direcciones;Ge_Ciudades", LOG06);

    /* EXEC SQL DECLARE Cur_Oficinas CURSOR FOR
         SELECT /o+ ORDERED o/
			   A.COD_OFICINA, B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, C.COD_PLAZA
              FROM GE_OFICINAS 	  A,
                   GE_DIRECCIONES B,
                   GE_CIUDADES    C
             WHERE A.COD_DIRECCION  = B.COD_DIRECCION
               AND B.COD_REGION     = C.COD_REGION
               AND B.COD_PROVINCIA  = C.COD_PROVINCIA
               AND B.COD_CIUDAD     = C.COD_CIUDAD; */ 

    /* EXEC SQL OPEN Cur_Oficinas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0055;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3911;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ge_Oficinas",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenOficinas **********************/

static BOOL bfnFetchOficinas (OFICINA_HOSTS *pstHost,long *plNumFilas)
{
	/* EXEC SQL VAR pstHost->szCodOficina	 	IS STRING(3); */ 

	/* EXEC SQL VAR pstHost->szCodRegion		IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodProvincia	IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodCiudad 	 	IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodPlaza		IS STRING(6); */ 


  	/* EXEC SQL FETCH Cur_Oficinas
  			  INTO :pstHost->szCodOficina	,
				   :pstHost->szCodRegion	,
				   :pstHost->szCodProvincia	,
				   :pstHost->szCodCiudad 	,
				   :pstHost->szCodPlaza		; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )2000;
   sqlstm.offset = (unsigned int  )3926;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodOficina);
   sqlstm.sqhstl[0] = (unsigned long )3;
   sqlstm.sqhsts[0] = (         int  )3;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodRegion);
   sqlstm.sqhstl[1] = (unsigned long )4;
   sqlstm.sqhsts[1] = (         int  )4;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodProvincia);
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )6;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodCiudad);
   sqlstm.sqhstl[3] = (unsigned long )6;
   sqlstm.sqhsts[3] = (         int  )6;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodPlaza);
   sqlstm.sqhstl[4] = (unsigned long )6;
   sqlstm.sqhsts[4] = (         int  )6;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




	if (SQLCODE==SQLOK)
		*plNumFilas = TAM_HOSTS_PEQ;
	else
		if (SQLCODE==SQLNOTFOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
		else
			iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Oficinas",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bfnFetchOficinas ****************/

/*****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                    */
/*****************************************************************************/
void vfnPrintOficinas (OFICINA *pstOficina, int iNumOficinas)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Oficinas [%d]", LOG06, iNumOficinas);

        for (i=0;i<iNumOficinas;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo Oficina  [%s]"
                                    "\n\t\t=> [%d]: Codigo Region   [%s]"
                                    "\n\t\t=> [%d]: Codigo Provincia[%s]"
                                    "\n\t\t=> [%d]: Codigo Ciudad   [%s]"
                                    "\n\t\t=> [%d]: Codigo Plaza    [%s]"
                                    ,LOG06
                                    ,i, pstOficina[i].szCodOficina
                                    ,i, pstOficina[i].szCodRegion
                                    ,i, pstOficina[i].szCodProvincia
                                    ,i, pstOficina[i].szCodCiudad
                                    ,i, pstOficina[i].szCodPlaza	);
        }
    }
}/*************************** vfnPrintOficinas *****************************/

int ifnCloseOficinas (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Oficinas", LOG06);

  /* EXEC SQL CLOSE Cur_Oficinas; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3961;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Oficinas",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnCloseOficinas ******************/


/* SAAM-20051028 se incluyen nuevas funciones de carga de grupos de conceptos, XO-200509160680 */
int ifnCmpCodConcServ (const void *cad1,const void *cad2)
{
    return ( ((CODCONCSERV *)cad1)->iCodConcepto - ((CODCONCSERV *)cad2)->iCodConcepto );
}

/* ************************************************************************* */
/* bfnCargaConcServ: Carga los conceptos asociados a un (o a unos) grupo (s) */
/*                   de servicio definido                                    */
/* ************************************************************************* */
BOOL bfnCargaConcServ (CODCONCSERV **pstConcServ, int *iNumConcServ)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szValCaracter[512];
    int  ihCodConcepto[TAM_HOSTS_PEQ];
    int  ihCodGrpServi[TAM_HOSTS_PEQ];
    char szCadena[1024];
    /* EXEC SQL END DECLARE SECTION; */ 


    char szTipParametro [33] ="";
    char szValParametro [512]="";
    int  iRes;
    int  i;
    int  iCant;

    CODCONCSERV *pstConcServTemp;

    *iNumConcServ = 0;
    *pstConcServ = NULL;


    /* Obtencion del codigo de concepto de descuento de impuesto IEPS */
    iRes = ifnGetParametro(300,szTipParametro,szValParametro ) ;

    if (iRes != SQLNOTFOUND)
    {
        if (iRes != SQLOK)
        {
            vDTrazasLog(szExeName,"\n\t** ERROR, al recuperar parametro de LISTA DE GRUPOS DE CONCEPTOS 300 error [%d] **",LOG01,iRes);
            return (FALSE);
        }
        strcpy(szValCaracter,szValParametro);
    }
    else
    {
        vDTrazasLog (szExeName,"\n\t\t=> ADVETENCIA, No existe parámetro 300 LISTA DE GRUPOS DE CONCEPTOS",LOG03);
        return (TRUE);
    }

    sprintf(szCadena,"SELECT A.COD_CONCEPTO, B.COD_GRPSERVI FROM "
                     "FA_GRPSERCONC A, GE_GRPSERVICIOS B "
                     "WHERE A.COD_GRPSERVI = B.COD_GRPSERVI"
                     "  AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA"
                     "  AND B.COD_GRPSERVI IN %s", szValCaracter);

    vDTrazasLog (szExeName,"\n\t* Query Grupos de Concepto [%s] ",LOG05,szCadena);

    /* EXEC SQL PREPARE sql_grupos_concepto FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3976;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )1024;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
        vDTrazasLog(szExeName,"\n\t**  Error en SQL-PREPARE sql_grupos_concepto **"
                              "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName, ERR000, vInsertarIncidencia,
                 "Select=> Grupos Servicios (bfnCargaConcServ) PREPARE", szfnORAerror ());
        return  (FALSE);
    }

    /* EXEC SQL DECLARE cur_grupos_concepto CURSOR FOR sql_grupos_concepto; */ 

    if (SQLCODE)
    {
        vDTrazasError(szExeName,"\n\t**  Error en SQL-DECLARE sql_grupos_concepto **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName, ERR000, vInsertarIncidencia,
                 "Select=> Grupos Servicios (bfnCargaConcServ) DECLARE", szfnORAerror ());
        return  (FALSE);
    }

    /* EXEC SQL OPEN cur_grupos_concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3995;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
        vDTrazasError(szExeName,"\n\t**  Error en SQL-OPEN CURSOR sql_grupos_concepto **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName, ERR000, vInsertarIncidencia,
                 "Select=> Grupos Servicios (bfnCargaConcServ) OPEN", szfnORAerror ());
        return  (FALSE);
    }

    /* EXEC SQL FETCH cur_grupos_concepto  INTO :ihCodConcepto, :ihCodGrpServi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )4010;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)ihCodConcepto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)ihCodGrpServi;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeName,"\n\t**  Error en SQL-FETCH sql_grupos_concepto **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName, ERR000, vInsertarIncidencia,
                 "Select=> Grupos Servicios (bfnCargaConcServ) FETCH", szfnORAerror ());
        return  (FALSE);
    }
    else
    {
        iCant=sqlca.sqlerrd[2];
    }

    if (iCant < 0)
    {
        vDTrazasLog (szExeName,"\n\t\t=> ADVETENCIA, No existe parámetro 300 LISTA DE GRUPOS DE CONCEPTOS",LOG03);
        return (TRUE);
    }
    else
    {
        *pstConcServ =(CODCONCSERV*) realloc(*pstConcServ,(int)(((*iNumConcServ)+iCant)*sizeof(CODCONCSERV)));
        if (!*pstConcServ)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                              "Error bfnCargaConcServ", "No se pudo reservar memoria");
            return (FALSE);
        }

        pstConcServTemp = &(*pstConcServ)[(*iNumConcServ)];
        memset(pstConcServTemp, 0, (int)(sizeof(CODCONCSERV)*iCant));
        for (i = 0 ; i < iCant ; i++)
        {
            pstConcServTemp[i].iCodConcepto = ihCodConcepto[i];
            pstConcServTemp[i].iCodGrpServi = ihCodGrpServi[i];

        }
        (*iNumConcServ) += iCant;

        vDTrazasLog (szExeName,"\n\t\t* Conceptos de Grupos de Servicios cargados [%ld]", LOG06, *iNumConcServ);
    }

    /* EXEC SQL CLOSE cur_grupos_concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )4033;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeName,"\n\t**  Error en SQL-CLOSE sql_grupos_concepto **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName, ERR000, vInsertarIncidencia,
                 "Select=> Grupos Servicios (bfnCargaConcServ) CLOSE", szfnORAerror ());
        return  (FALSE);
    }


    qsort((void*)*pstConcServ, *iNumConcServ, sizeof(CODCONCSERV),ifnCmpCodConcServ);
    /* vfnPrintCodConcServ (*pstConcServ, *iNumConcServ); */

    return (TRUE);
}/**************************** Final bfnCargaConcServ ******************/

/* void vfnPrintCodConcServ (CODCONCSERV *pstCodConcServ, int iNumCodConcServ)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Conceptos de Grupos de Servicios [%d]", LOG06, iNumCodConcServ);
        for (i=0;i<iNumCodConcServ;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo de Concepto      [%d]"
                                    "\n\t\t=> [%d]: Codigo de Grupo         [%d]"
                                  ,LOG06
                                  ,i, pstCodConcServ[i].iCodConcepto
                                  ,i, pstCodConcServ[i].iCodGrpServi);
        }
    }
}*//*************************** vfnPrintCodConcServ *****************************/

/* ************************************************************************* */
/* bfnCargaImptosDctos: Carga la configuracion de impuestos a documentos     */
/* ************************************************************************* */
BOOL bfnCargaImptosDctos (IMPTODCTO **pstImptoDctos, int *iNumImptoDctos)
{
   	int 	    rc = 0;
	long 	    lNumFilas;
	static 	    IMPTODCTO_HOSTS stImptoDctosHost;
	IMPTODCTO   *pstImptoDctosTemp;
	register long        lCont;

	vDTrazasLog (szExeName,"\n\t* Carga Impuestos a documentos.", LOG06);

 	*iNumImptoDctos = 0;
 	*pstImptoDctos = NULL;

   	if (ifnOpenImptosDctos())
       return FALSE;

	while (rc != SQLNOTFOUND)
	{
      	rc = bfnFetchImptosDctos (&stImptoDctosHost,&lNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
			return FALSE;

		if (!lNumFilas)
		break;

 		*pstImptoDctos =(IMPTODCTO*) realloc(*pstImptoDctos,(((*iNumImptoDctos)+lNumFilas)*sizeof(IMPTODCTO)));

		if (!*pstImptoDctos)
		{
			iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaImptosDctos", "no se pudo reservar memoria");
			return FALSE;
		}

		pstImptoDctosTemp = &(*pstImptoDctos)[(*iNumImptoDctos)];
		memset(pstImptoDctosTemp, 0, sizeof(IMPTODCTO)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstImptoDctosTemp[lCont].lCodConcepto        =   stImptoDctosHost.lCodConcepto  [lCont];
			pstImptoDctosTemp[lCont].lCodGprservi        =   stImptoDctosHost.lCodGprservi  [lCont];
			pstImptoDctosTemp[lCont].dImpfacturable      =   stImptoDctosHost.dImpfacturable[lCont];
			pstImptoDctosTemp[lCont].iTipZonacargo       =   stImptoDctosHost.iTipZonacargo [lCont];
			pstImptoDctosTemp[lCont].iTipEvaluacion      =   stImptoDctosHost.iTipEvaluacion[lCont];
			/* XO-200607241178 FAAR 20060725 */
			pstImptoDctosTemp[lCont].iCodCatImpos        =   stImptoDctosHost.iCodCatImpos  [lCont];

			strcpy(pstImptoDctosTemp[lCont].szCodZonacargo ,stImptoDctosHost.szCodZonacargo [lCont]);
			strcpy(pstImptoDctosTemp[lCont].szCodRegion    ,stImptoDctosHost.szCodRegion    [lCont]);
			strcpy(pstImptoDctosTemp[lCont].szCodProvincia ,stImptoDctosHost.szCodProvincia [lCont]);
			strcpy(pstImptoDctosTemp[lCont].szTipValor     ,stImptoDctosHost.szTipValor     [lCont]);
			strcpy(pstImptoDctosTemp[lCont].szFecDesde     ,stImptoDctosHost.szFecDesde     [lCont]);
			strcpy(pstImptoDctosTemp[lCont].szFecHasta     ,stImptoDctosHost.szFecHasta     [lCont]);
		}
		(*iNumImptoDctos) += lNumFilas;

   	}/* fin while */

	vDTrazasLog (szExeName,"\n\t\t* Impuestos a documentos cargados: [%ld]", LOG06, *iNumImptoDctos);

	rc = ifnCloseImptosDctos();
	if (rc != SQLOK)
	{
		iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaImptosDctos", szfnORAerror ());
		return FALSE;
	}

	qsort((void*)*pstImptoDctos, *iNumImptoDctos, sizeof(IMPTODCTO),ifnCmpImptosDctos);

	vfnPrintImptosDctos(*pstImptoDctos, *iNumImptoDctos);

	return (TRUE);
}/***************************** Final bfnCargaImptosDctos *********************/

static int ifnOpenImptosDctos (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ge_Oficinas;Ge_Direcciones;Ge_Ciudades", LOG06);

    /* EXEC SQL DECLARE Cur_ImptosDctos CURSOR FOR
        SELECT
            A.COD_CONCEPTO
            ,A.COD_ZONACARGO
            ,A.COD_REGION
            ,A.COD_PROVINCIA
            ,A.TIP_ZONACARGO
            ,A.TIP_EVALUACION
            ,A.COD_GRPSERVI
            ,A.IMP_FACTURABLE
            ,A.TIP_VALOR
            ,A.COD_CATIMPOS						/o XO-200607241178 FAAR 20060725 o/
            ,TO_CHAR(A.FEC_DESDE,'YYYYMMDD')
            ,TO_CHAR(A.FEC_HASTA,'YYYYMMDD')
        FROM
            FA_IMPTODCTOS_TD A; */ 


        /* EXEC SQL OPEN Cur_ImptosDctos; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 29;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0057;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )4048;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> FA_IMPTODCTOS",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenImptosDctos **********************/

static BOOL bfnFetchImptosDctos (IMPTODCTO_HOSTS *pstHost,long *plNumFilas)
{

    /* EXEC SQL VAR pstHost->szCodZonacargo  IS STRING(11); */ 

    /* EXEC SQL VAR pstHost->szCodRegion     IS STRING(6); */ 

    /* EXEC SQL VAR pstHost->szCodProvincia  IS STRING(6); */ 

    /* EXEC SQL VAR pstHost->szTipValor      IS STRING(2); */ 

    /* EXEC SQL VAR pstHost->szFecDesde      IS STRING(9); */ 

    /* EXEC SQL VAR pstHost->szFecHasta      IS STRING(9); */ 


    /* EXEC SQL FETCH
  	            Cur_ImptosDctos
  			 INTO
  			    :pstHost->lCodConcepto
               ,:pstHost->szCodZonacargo
               ,:pstHost->szCodRegion
               ,:pstHost->szCodProvincia
               ,:pstHost->iTipZonacargo
               ,:pstHost->iTipEvaluacion
               ,:pstHost->lCodGprservi
               ,:pstHost->dImpfacturable
               ,:pstHost->szTipValor
               ,:pstHost->iCodCatImpos
               ,:pstHost->szFecDesde
               ,:pstHost->szFecHasta; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )4063;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodConcepto);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodZonacargo);
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )11;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodRegion);
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )6;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodProvincia);
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )6;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iTipZonacargo);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iTipEvaluacion);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )sizeof(int);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->lCodGprservi);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )sizeof(long);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->dImpfacturable);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->szTipValor);
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )2;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->iCodCatImpos);
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )sizeof(int);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szFecDesde);
    sqlstm.sqhstl[10] = (unsigned long )9;
    sqlstm.sqhsts[10] = (         int  )9;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->szFecHasta);
    sqlstm.sqhstl[11] = (unsigned long )9;
    sqlstm.sqhsts[11] = (         int  )9;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	/* XO-200607241178 FAAR 20060725 Se agregó, en el fetch, el valor de cod_catimpos...*/
	if (SQLCODE==SQLOK)
		*plNumFilas = TAM_HOSTS_PEQ;
	else
		if (SQLCODE==SQLNOTFOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
		else
			iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> FA_IMPTODCTOS",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bfnFetchImptosDctos ****************/


static int ifnCloseImptosDctos (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> FA_IMPTODCTOS", LOG06);

  /* EXEC SQL CLOSE Cur_ImptosDctos; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4126;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Oficinas",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnCloseImptosDctos ******************/


int ifnCmpImptosDctos (const void* cad1, const void* cad2)
{
    int rc = 0;

    return ((rc = ((IMPTODCTO *)cad1)->lCodConcepto -
                  ((IMPTODCTO *)cad2)->lCodConcepto) != 0)?rc:
           ((rc = strcmp(((IMPTODCTO *)cad1)->szCodZonacargo,
                         ((IMPTODCTO *)cad2)->szCodZonacargo))!=0)?rc:
           ((rc = ((IMPTODCTO *)cad1)->iTipZonacargo -
                         ((IMPTODCTO *)cad2)->iTipZonacargo )!=0)?rc:
           ((rc = ((IMPTODCTO *)cad1)->iTipEvaluacion -
                         ((IMPTODCTO *)cad2)->iTipEvaluacion )!=0)?rc:
           ((rc = ((IMPTODCTO *)cad1)->lCodGprservi -
                  ((IMPTODCTO *)cad2)->lCodGprservi) != 0)?rc:0;

}/**************************** Final ifnCmpImptosDctos ********************/

/*****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                    */
/*****************************************************************************/
void vfnPrintImptosDctos (IMPTODCTO *pstImptoDcto, int iNumImptoDctos)
{
    register int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Impuestos a documentos: [%d]", LOG06, iNumImptoDctos);

        for (i=0;i<iNumImptoDctos;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo de Concepto       [%ld]"
                                    "\n\t\t=> [%d]: Codigo de zona cargo     [%s]"
                                    "\n\t\t=> [%d]: Codigo de region         [%s]"
                                    "\n\t\t=> [%d]: Codigo de provincia      [%s]"
                                    "\n\t\t=> [%d]: Tipo de zona cargo       [%d]"
                                    "\n\t\t=> [%d]: Tipo de evaluacion       [%d]"
                                    "\n\t\t=> [%d]: Codigo de grupo servicio [%ld]"
                                    "\n\t\t=> [%d]: Importe Facturable       [%f]"
                                    "\n\t\t=> [%d]: szTipvalor               [%s]"
                                    "\n\t\t=> [%d]: iCodCatImpos			 [%d]"
                                    "\n\t\t=> [%d]: Fecha Desde              [%s]"
                                    "\n\t\t=> [%d]: Fecha Hasta              [%s]"
                                    ,LOG06
                                    ,i, pstImptoDcto[i].lCodConcepto
                                    ,i, pstImptoDcto[i].szCodZonacargo
                                    ,i, pstImptoDcto[i].szCodRegion
                                    ,i, pstImptoDcto[i].szCodProvincia
                                    ,i, pstImptoDcto[i].iTipZonacargo
                                    ,i, pstImptoDcto[i].iTipEvaluacion
                                    ,i, pstImptoDcto[i].lCodGprservi
                                    ,i, pstImptoDcto[i].dImpfacturable
                                    ,i, pstImptoDcto[i].szTipValor
                                    ,i, pstImptoDcto[i].iCodCatImpos			/* XO-200607241178 FAAR 20060725 */
                                    ,i, pstImptoDcto[i].szFecDesde
                                    ,i, pstImptoDcto[i].szFecHasta);
        }
    }
}/*************************** vfnPrintImptosDctos *****************************/

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

