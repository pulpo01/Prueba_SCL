
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
           char  filnam[18];
};
static const struct sqlcxp sqlfpn =
{
    17,
    "./pc/tablasora.pc"
};


static unsigned int sqlctx = 6917091;


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
   unsigned char  *sqhstv[33];
   unsigned long  sqhstl[33];
            int   sqhsts[33];
            short *sqindv[33];
            int   sqinds[33];
   unsigned long  sqharm[33];
   unsigned long  *sqharc[33];
   unsigned short  sqadto[33];
   unsigned short  sqtdso[33];
} sqlstm = {12,33};

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

 static const char *sq0007 = 
"select ROLE  from SESSION_ROLES            ";

 static const char *sq0013 = 
"select ROWID ,COD_CLIENTE ,COD_PRODUCTO ,NUM_ABONADO ,COD_CALCLIEN ,IND_CAMB\
IO ,NOM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 ,COD_CREDMOR ,IND_DEBITO ,COD_CI\
CLONUE ,TO_CHAR(FEC_ALTA,'YYYYMMDDHH24MISS') ,nvl(TO_CHAR(FEC_ULTFACT,'YYYYMMD\
DHH24MISS'),' ')  from FA_CICLOCLI where ((((COD_CICLO=:b0 and NUM_PROCESO=0) \
and IND_MASCARA=1) and COD_CLIENTE>=:b1) and COD_CLIENTE<=:b2) order by COD_CL\
IENTE,FEC_ALTA            ";

 static const char *sq0014 = 
"select ROWID ,COD_CLIENTE ,COD_PRODUCTO ,NUM_ABONADO ,COD_CALCLIEN ,IND_CAMB\
IO ,NOM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 ,COD_CREDMOR ,IND_DEBITO ,COD_CI\
CLONUE ,TO_CHAR(FEC_ALTA,'YYYYMMDDHH24MISS') ,nvl(TO_CHAR(FEC_ULTFACT,'YYYYMMD\
DHH24MISS'),' ')  from FA_CICLOCLI where (((COD_CICLO=:b0 and NUM_PROCESO=0) a\
nd IND_MASCARA=1) and COD_CLIENTE>=:b1) order by COD_CLIENTE,FEC_ALTA         \
   ";

 static const char *sq0015 = 
"select A.rowid  ,A.NUM_CARGO ,A.COD_CLIENTE ,A.COD_PRODUCTO ,A.COD_CONCEPTO \
,TO_CHAR(A.FEC_ALTA,'YYYYMMDDHH24MISS') ,A.IMP_CARGO ,A.COD_MONEDA ,A.COD_PLAN\
COM ,A.NUM_UNIDADES ,A.NUM_ABONADO ,A.NUM_TERMINAL ,A.COD_CICLFACT ,A.NUM_SERI\
E ,A.NUM_SERIEMEC ,A.CAP_CODE ,A.MES_GARANTIA ,DECODE(trim(A.NUM_PREGUIA),'',n\
ull ,A.NUM_PREGUIA) ,DECODE(trim(A.NUM_GUIA),'',null ,A.NUM_GUIA) ,A.NUM_TRANS\
ACCION ,A.NUM_VENTA ,A.NUM_FACTURA ,A.COD_CONCEPTO_DTO ,A.VAL_DTO ,A.TIP_DTO ,\
A.IND_CUOTA ,A.NUM_PAQUETE ,A.IND_FACTUR ,A.IND_SUPERTEL  from GE_CARGOS A ,FA\
_CICLFACT B ,(select distinct cod_cliente  from fa_ciclocli where ((((num_proc\
eso=0 and ind_mascara=1) and cod_ciclo=:b0) and COD_CLIENTE>=:b1) and COD_CLIE\
NTE<=:b2)) CLI where (((((A.COD_CLIENTE=CLI.COD_CLIENTE and A.NUM_FACTURA=0) a\
nd A.NUM_TRANSACCION=0) and A.IMP_CARGO<>0) and A.COD_CICLFACT=B.COD_CICLFACT)\
 and B.IND_FACTURACION in (1,2))           ";

 static const char *sq0016 = 
"select A.rowid  ,A.NUM_CARGO ,A.COD_CLIENTE ,A.COD_PRODUCTO ,A.COD_CONCEPTO \
,TO_CHAR(A.FEC_ALTA,'YYYYMMDDHH24MISS') ,A.IMP_CARGO ,A.COD_MONEDA ,A.COD_PLAN\
COM ,A.NUM_UNIDADES ,A.NUM_ABONADO ,A.NUM_TERMINAL ,A.COD_CICLFACT ,A.NUM_SERI\
E ,A.NUM_SERIEMEC ,A.CAP_CODE ,A.MES_GARANTIA ,DECODE(trim(A.NUM_PREGUIA),'',n\
ull ,A.NUM_PREGUIA) ,DECODE(trim(A.NUM_GUIA),'',null ,A.NUM_GUIA) ,A.NUM_TRANS\
ACCION ,A.NUM_VENTA ,A.NUM_FACTURA ,A.COD_CONCEPTO_DTO ,A.VAL_DTO ,A.TIP_DTO ,\
A.IND_CUOTA ,A.NUM_PAQUETE ,A.IND_FACTUR ,A.IND_SUPERTEL  from GE_CARGOS A ,FA\
_CICLFACT B ,(select distinct COD_CLIENTE  from FA_CICLOCLI where (((NUM_PROCE\
SO=0 and IND_MASCARA=1) and COD_CICLO=:b0) and COD_CLIENTE>=:b1)) CLI where ((\
(((A.COD_CLIENTE=CLI.COD_CLIENTE and A.NUM_FACTURA=0) and A.NUM_TRANSACCION=0)\
 and A.IMP_CARGO<>0) and A.COD_CICLFACT=B.COD_CICLFACT) and B.IND_FACTURACION \
in (1,2))           ";

 static const char *sq0017 = 
"select ROWID ,SEQ_CUOTAS ,COD_CLIENTE ,COD_CONCEPTO ,COD_MONEDA ,COD_PRODUCT\
O ,NUM_CUOTAS ,IMP_TOTAL ,IND_PAGADA ,NUM_ABONADO ,COD_CUOTA ,NUM_PAGARE  from\
 FA_CABCUOTAS            ";

 static const char *sq0018 = 
"select COD_CARGO ,MONTO_IMPORTE ,COD_MONEDA  from PF_CARGOS_PRODUCTOS_TD  or\
der by COD_CARGO            ";

 static const char *sq0019 = 
"select COD_PRODUCTO ,COD_FACTURACION ,IND_TABLA ,IND_ENTSAL ,IND_DESTINO ,CO\
D_TARIFICACION ,COD_SERVICIO  from TA_CONCEPFACT            ";

 static const char *sq0020 = 
"select A.COD_CONCEPTO ,A.COD_PRODUCTO ,A.DES_CONCEPTO ,A.COD_TIPCONCE ,A.COD\
_MODULO ,A.COD_MONEDA ,A.IND_ACTIVO ,A.COD_CONCORIG ,A.COD_TIPDESCU ,B.COD_CON\
CCOBR ,C.DESCRIPCION_VALOR ,GRUP.COD_GRPSERVI  from FA_CONCEPTOS A ,FA_FACTCOB\
R B ,FA_GRPSERCONC GRUP ,FA_CICLFACT CICL ,(select FIC.COD_CONCEPTO ,FFTN.DESC\
RIPCION_VALOR  from FAD_IMPCONCEPTOS FIC ,FAD_IMPSUBGRUPOS FIS ,FAD_IMPGRUPOS \
FIG ,FAD_PARAMETROS FP ,FA_FACTOR_TIPO_UNIDAD_VW FFTN where (((((FIC.COD_SUBGR\
UPO=FIS.COD_SUBGRUPO and FIS.COD_GRUPO=FIG.COD_GRUPO) and FP.VAL_NUMERICO=FIG.\
COD_FORMULARIO) and FP.COD_MODULO=:b0) and FP.COD_PARAMETRO=:b1) and FIG.TIP_U\
NIDAD=FFTN.VALOR)) C where (((((A.COD_CONCEPTO=B.COD_CONCFACT and A.COD_CONCEP\
TO=C.COD_CONCEPTO(+)) and GRUP.COD_CONCEPTO=A.COD_CONCEPTO) and GRUP.FEC_DESDE\
<=CICL.FEC_EMISION) and GRUP.FEC_HASTA>=CICL.FEC_EMISION) and CICL.COD_CICLFAC\
T=:b2) order by A.COD_CONCEPTO            ";

 static const char *sq0021 = 
"select to_number(COD_CONCEPTO) ,COD_IDIOMA ,DES_CONCEPTO  from GE_MULTIIDIOM\
A where (NOM_TABLA='FA_CONCEPTOS' and NOM_CAMPO='COD_CONCEPTO') order by to_nu\
mber(COD_CONCEPTO)            ";

 static const char *sq0022 = 
"select COD_CICLFACT ,RANGO_INI ,RANGO_FIN ,COD_PRODUCTO ,NOM_TABLA  from FA_\
RANGO_TABLA            ";

 static const char *sq0023 = 
"select COD_CREDMOR ,COD_PRODUCTO ,COD_CALCLIEN ,IMP_MOROSIDAD  from CO_LIMCR\
EDITOS            ";

 static const char *sq0024 = 
"select COD_Actividad ,DES_Actividad  from GE_ACTIVIDADES            ";

 static const char *sq0025 = 
"select COD_REGION ,COD_PROVINCIA ,DES_PROVINCIA  from GE_PROVINCIAS         \
   ";

 static const char *sq0026 = 
"select COD_REGION ,DES_REGION  from GE_REGIONES            ";

 static const char *sq0027 = 
"select COD_CATIMPOS ,DES_CATIMPOS  from GE_CATIMPOSITIVA            ";

 static const char *sq0028 = 
"select COD_REGION ,COD_PROVINCIA ,COD_CIUDAD ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH2\
4MISS') ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS') ,COD_ZONAIMPO  from GE_ZONACIUD\
AD            ";

 static const char *sq0029 = 
"select COD_ZONAIMPO ,DES_ZONAIMPO  from GE_ZONAIMPOSITIVA            ";

 static const char *sq0030 = 
"select I.COD_CATIMPOS ,I.COD_ZONAIMPO ,I.COD_ZONAABON ,I.COD_TIPIMPUES ,I.CO\
D_GRPSERVI ,(TO_CHAR(I.FEC_DESDE,'YYYYMMDD')||'000000') ,I.COD_CONCGENE ,(TO_C\
HAR(I.FEC_HASTA,'YYYYMMDD')||'235959') ,I.PRC_IMPUESTO ,T.TIP_MONTO ,T.IMP_UMB\
RAL ,T.IMP_MAXIMO  from GE_IMPUESTOS I ,GE_TIPIMPUES T where I.COD_TIPIMPUES=T\
.COD_TIPIMPUE           ";

 static const char *sq0031 = 
"select COD_CONCEPTO ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS') ,COD_GRPSERVI ,TO\
_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS')  from FA_GRPSERCONC            ";

 static const char *sq0032 = 
"select COD_MONEDA ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HASTA,\
'YYYYMMDDHH24MISS') ,CAMBIO  from GE_CONVERSION            ";

 static const char *sq0033 = 
"select COD_OFICINA ,COD_TIPDOCUM ,COD_CENTREMI  from AL_DOCUM_SUCURSAL      \
      ";

 static const char *sq0034 = 
"select COD_TIPDOCUM ,COD_CATIMPOS ,LETRA  from GE_LETRAS            ";

 static const char *sq0035 = 
"select A.COD_GRUPO ,A.COD_PRODUCTO ,A.COD_CONCEPTO ,A.COD_CICLO ,NVL(B.TIP_C\
OBRO,0) ,A.FEC_DESDE ,A.FEC_HASTA  from FA_GRUPOCOB A ,(select COD_CONCEPTO ,m\
ax(TIP_COBRO) TIP_COBRO  from (select COD_CONCEPTO ,max(DECODE(NVL(TIP_COBRO,0\
),'A',1,0)) TIP_COBRO  from PF_CONCEPTOS_PROD_TD  group by COD_CONCEPTO union \
select COD_CONCEPTO ,max(DECODE(NVL(B.TIP_COBRO,0),'A',1,0)) TIP_COBRO  from G\
A_SERVSUPL B ,GA_ACTUASERV C where B.COD_SERVICIO=C.COD_SERVICIO group by COD_\
CONCEPTO)  group by COD_CONCEPTO) B where (A.COD_CICLO=:b0 and A.COD_CONCEPTO=\
B.COD_CONCEPTO(+)) order by A.COD_GRUPO,A.COD_CONCEPTO,A.COD_PRODUCTO,A.COD_CI\
CLO            ";

 static const char *sq0036 = 
"select COD_TIPSERV ,COD_SERVICIO ,COD_PLANSERV ,TO_CHAR(FEC_DESDE,'YYYYMMDDH\
H24MISS') ,IMP_TARIFA ,COD_MONEDA ,IND_PERIODICO ,TO_CHAR(FEC_HASTA,'YYYYMMDDH\
H24MISS')  from GA_TARIFAS where (COD_PRODUCTO=1 and COD_ACTABO='FA')         \
  ";

 static const char *sq0037 = 
"select COD_TIPSERV ,COD_SERVICIO ,COD_CONCEPTO  from GA_ACTUASERV           \
 ";

 static const char *sq0038 = 
"select ROWID ,SEQ_CUOTAS ,ORD_CUOTA ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS')\
 ,IMP_CUOTA ,IND_FACTURADO ,IND_PAGADO  from FA_CUOTAS            ";

 static const char *sq0039 = 
"select A.COD_CONCFACT ,A.COD_CONCCARRIER ,B.COD_TIPCONCE  from FA_FACTCARRIE\
RS A ,FA_CONCEPTOS B where B.COD_CONCEPTO=A.COD_CONCFACT           ";

 static const char *sq0040 = 
"select COD_CTOPLAN ,IMP_UMBDESDE ,IMP_UMBHASTA ,IMP_DESCUENTO ,COD_TIPODTO  \
from VE_CUADCTOPLAN            ";

 static const char *sq0041 = 
"select COD_CTOPLAN ,COD_PRODUCTO ,COD_TIPCTOPLAN ,COD_MONEDA ,COD_CTOFAC ,IM\
P_DESCUENTO ,COD_TIPODTO ,IND_CUADRANTE ,COD_TIPOCUAD ,IMP_UMBDESDE ,IMP_UMBHA\
STA ,NUM_DIAS  from VE_CTOPLAN            ";

 static const char *sq0042 = 
"select COD_PLANCOM ,COD_PRODUCTO ,COD_CTOPLAN ,TO_CHAR(FEC_EFECTIVIDAD,'YYYY\
MMDDHH24MISS') ,TO_CHAR(FEC_FINEFECTIVIDAD,'YYYYMMDDHH24MISS')  from VE_PLAN_C\
TOPLAN            ";

 static const char *sq0043 = 
"select ROWID ,COD_CLIENTE ,NUM_ABONADO ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS'\
) ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS') ,COD_PRODUCTO ,COD_CONCEPTO ,COD_ARTI\
CULO ,PRECIO_MES ,COD_MONEDA  from FA_ARRIENDO            ";

 static const char *sq0044 = 
"select COD_CARGOBASICO ,IMP_CARGOBASICO ,COD_MONEDA  from TA_CARGOSBASICO wh\
ere ((TO_DATE(:b0,'YYYYMMDDHH24MISS')>=FEC_DESDE and TO_DATE(:b0,'YYYYMMDDHH24\
MISS')<=NVL(FEC_HASTA,TO_DATE('30000101000000','YYYYMMDDHH24MISS'))) and COD_P\
RODUCTO=1)           ";

 static const char *sq0045 = 
"select COD_PLANTARIF ,MIN_DESDE ,MIN_HASTA ,PRC_ABONO ,PRC_NORMAL ,PRC_BAJO \
 from FA_OPTIMO            ";

 static const char *sq0046 = 
"select TO_CHAR(FEC_DIAFEST,'YYYYMMDDHH24MISS')  from TA_DIASFEST            ";

 static const char *sq0047 = 
"select COD_PLANTARIF ,TIP_TERMINAL ,COD_LIMCONSUMO ,COD_CARGOBASICO ,TIP_PLA\
NTARIF ,TIP_UNIDADES ,NUM_UNIDADES ,IND_ARRASTRE ,NUM_DIAS ,NUM_ABONADOS ,IND_\
FRANCONS ,FLG_RANGO ,TO_CHAR(NVL(IND_COMPARTIDO,0)) ,DECODE(NVL(TIP_COBRO,'V')\
,'A',1,0)  from TA_PLANTARIF where COD_PRODUCTO=1           ";

 static const char *sq0048 = 
"select ROWID ,COD_CLIENTE ,TIP_INCIDENCIA ,TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDD\
HH24MISS') ,COD_MONEDA ,IMP_PENALIZ ,COD_CICLFACT ,COD_CONCEPTO ,COD_PRODUCTO \
,NUM_ABONADO ,NUM_PROCESO  from CA_PENALIZACIONES            ";

 static const char *sq0049 = 
"select A.COD_CLIENTE ,A.COD_CATIMPOS ,TO_CHAR(FA_SEQ_IND_ORDENTOTAL.nextval \
)  from GE_CATIMPCLIENTES A ,(select distinct COD_CLIENTE  from FA_CICLOCLI wh\
ere ((((NUM_PROCESO=0 and IND_MASCARA=1) and COD_CICLO=:b0) and COD_CLIENTE>=:\
b1) and COD_CLIENTE<=:b2)) CLI where ((A.COD_CLIENTE=CLI.COD_CLIENTE and A.FEC\
_DESDE<=TO_DATE(:b3,'YYYYMMDDHH24MISS')) and A.FEC_HASTA>=TO_DATE(:b3,'YYYYMMD\
DHH24MISS'))           ";

 static const char *sq0050 = 
"select A.COD_CLIENTE ,A.COD_CATIMPOS ,TO_CHAR(FA_SEQ_IND_ORDENTOTAL.nextval \
)  from GE_CATIMPCLIENTES A ,(select distinct cod_cliente  from fa_ciclocli wh\
ere ((num_proceso=0 and ind_mascara=1) and cod_ciclo=:b0)) CLI where ((A.COD_C\
LIENTE=CLI.COD_CLIENTE and A.FEC_DESDE<=TO_DATE(:b1,'YYYYMMDDHH24MISS')) and A\
.FEC_HASTA>=TO_DATE(:b1,'YYYYMMDDHH24MISS'))           ";

 static const char *sq0051 = 
"select distinct B.COD_CLIENTE ,A.COD_REGION ,A.COD_PROVINCIA ,A.COD_CIUDAD ,\
A.COD_COMUNA ,A.NOM_CALLE ,A.NUM_CALLE ,A.NUM_PISO  from GE_DIRECCIONES A ,GA_\
DIRECCLI B ,FA_CICLOCLI C where (((((((B.COD_TIPDIRECCION=:b0 and B.COD_DIRECC\
ION=A.COD_DIRECCION) and C.COD_CLIENTE=B.COD_CLIENTE) and C.num_proceso=0) and\
 C.ind_mascara=1) and C.cod_ciclo=:b1) and C.COD_CLIENTE>=:b2) and C.COD_CLIEN\
TE<=:b3)           ";

 static const char *sq0052 = 
"select distinct B.COD_CLIENTE ,A.COD_REGION ,A.COD_PROVINCIA ,A.COD_CIUDAD ,\
A.COD_COMUNA ,A.NOM_CALLE ,A.NUM_CALLE ,A.NUM_PISO  from GE_DIRECCIONES A ,GA_\
DIRECCLI B ,FA_CICLOCLI C where (((((B.COD_CLIENTE=C.COD_CLIENTE and C.NUM_PRO\
CESO=0) and C.IND_MASCARA=1) and C.COD_CICLO=:b0) and B.COD_TIPDIRECCION=:b1) \
and B.COD_DIRECCION=A.COD_DIRECCION)           ";

 static const char *sq0053 = 
"select distinct PAC.COD_CLIENTE ,PAC.COD_BANCO  from CO_UNIPAC PAC ,FA_CICLO\
CLI CLI where (((((PAC.COD_CLIENTE=CLI.COD_CLIENTE and CLI.NUM_PROCESO=0) and \
CLI.IND_MASCARA=1) and CLI.COD_CICLO=:b0) and CLI.COD_CLIENTE>=:b1) and CLI.CO\
D_CLIENTE<=:b2)           ";

 static const char *sq0054 = 
"select distinct PAC.COD_CLIENTE ,PAC.COD_BANCO  from CO_UNIPAC PAC ,FA_CICLO\
CLI CLI where (((PAC.COD_CLIENTE=CLI.COD_CLIENTE and CLI.NUM_PROCESO=0) and CL\
I.IND_MASCARA=1) and CLI.COD_CICLO=:b0)           ";

 static const char *sq0055 = 
"select A.COD_OFICINA ,B.COD_REGION ,B.COD_PROVINCIA ,B.COD_CIUDAD ,C.COD_PLA\
ZA  from GE_OFICINAS A ,GE_DIRECCIONES B ,GE_CIUDADES C where (((A.COD_DIRECCI\
ON=B.COD_DIRECCION and B.COD_REGION=C.COD_REGION) and B.COD_PROVINCIA=C.COD_PR\
OVINCIA) and B.COD_CIUDAD=C.COD_CIUDAD)           ";

 static const char *sq0056 = 
"select COD_CONCFACT ,COD_CONCCOBR  from FA_FACTCOBR            ";

 static const char *sq0057 = 
"select B.COD_PLANDESC ,B.DES_PLANDESC ,TO_CHAR(B.FEC_DESDE,:b0) ,TO_CHAR(B.F\
EC_HASTA,:b0) ,B.IND_RESTRICCION ,TO_CHAR(C.FEC_DESDE,:b0) ,TO_CHAR(C.FEC_HAST\
A,:b0) ,C.COD_TIPEVAL ,C.COD_TIPAPLI ,C.COD_GRUPOEVAL ,C.COD_GRUPOAPLI ,C.NUM_\
CUADRANTE ,C.TIP_UNIDAD ,C.COD_CONCDESC ,C.MTO_MINFACT  from FAD_PLANDESC B ,F\
AD_DETPLANDESC C ,FA_CICLFACT A where ((B.COD_PLANDESC=C.COD_PLANDESC and A.CO\
D_CICLFACT=:b4) and A.FEC_EMISION between C.FEC_DESDE and C.FEC_HASTA)        \
   ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,2,0,0,
5,0,0,1,0,0,27,38,0,0,4,4,0,1,0,1,97,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
36,0,0,2,111,0,4,48,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,
63,0,0,3,72,0,4,66,0,0,1,0,0,1,0,2,5,0,0,
82,0,0,0,0,0,60,74,0,0,0,0,0,1,0,
97,0,0,4,0,0,30,89,0,0,0,0,0,1,0,
112,0,0,0,0,0,58,106,0,0,1,1,0,1,0,3,109,0,0,
131,0,0,5,0,0,27,113,0,0,4,4,0,1,0,1,97,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
162,0,0,6,54,0,1,118,0,0,0,0,0,1,0,
177,0,0,7,43,0,9,153,0,0,0,0,0,1,0,
192,0,0,7,0,0,13,164,0,0,1,0,0,1,0,2,5,0,0,
211,0,0,7,0,0,15,180,0,0,0,0,0,1,0,
226,0,0,8,99,0,4,194,0,0,3,2,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,
253,0,0,9,0,0,24,224,0,0,1,1,0,1,0,1,5,0,0,
272,0,0,10,73,0,4,261,0,0,1,0,0,1,0,2,3,0,0,
291,0,0,11,0,0,17,362,0,0,1,1,0,1,0,1,97,0,0,
310,0,0,11,0,0,45,376,0,0,22,22,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
413,0,0,12,0,0,17,481,0,0,1,1,0,1,0,1,97,0,0,
432,0,0,12,0,0,45,495,0,0,20,20,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
527,0,0,13,414,0,9,558,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
554,0,0,14,391,0,9,584,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
577,0,0,15,899,0,9,650,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
604,0,0,16,876,0,9,693,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
627,0,0,17,179,0,9,725,0,0,0,0,0,1,0,
642,0,0,18,104,0,9,748,0,0,0,0,0,1,0,
657,0,0,19,136,0,9,774,0,0,0,0,0,1,0,
672,0,0,20,898,0,9,830,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
699,0,0,21,184,0,9,855,0,0,0,0,0,1,0,
714,0,0,22,99,0,9,879,0,0,0,0,0,1,0,
729,0,0,23,94,0,9,900,0,0,0,0,0,1,0,
744,0,0,24,68,0,9,919,0,0,0,0,0,1,0,
759,0,0,25,79,0,9,939,0,0,0,0,0,1,0,
774,0,0,26,59,0,9,958,0,0,0,0,0,1,0,
789,0,0,27,68,0,9,977,0,0,0,0,0,1,0,
804,0,0,28,168,0,9,1001,0,0,0,0,0,1,0,
819,0,0,29,69,0,9,1021,0,0,0,0,0,1,0,
834,0,0,30,334,0,9,1052,0,0,0,0,0,1,0,
849,0,0,31,143,0,9,1095,0,0,0,0,0,1,0,
864,0,0,32,135,0,9,1116,0,0,0,0,0,1,0,
879,0,0,33,82,0,9,1137,0,0,0,0,0,1,0,
894,0,0,34,68,0,9,1157,0,0,0,0,0,1,0,
909,0,0,35,637,0,9,1203,0,0,1,1,0,1,0,1,3,0,0,
928,0,0,36,234,0,9,1230,0,0,0,0,0,1,0,
943,0,0,37,77,0,9,1250,0,0,0,0,0,1,0,
958,0,0,38,142,0,9,1276,0,0,0,0,0,1,0,
973,0,0,39,143,0,9,1299,0,0,0,0,0,1,0,
988,0,0,40,107,0,9,1322,0,0,0,0,0,1,0,
1003,0,0,41,196,0,9,1352,0,0,0,0,0,1,0,
1018,0,0,42,172,0,9,1375,0,0,0,0,0,1,0,
1033,0,0,43,212,0,9,1404,0,0,0,0,0,1,0,
1048,0,0,44,253,0,9,1433,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
1071,0,0,45,103,0,9,1458,0,0,0,0,0,1,0,
1086,0,0,46,76,0,9,1477,0,0,0,0,0,1,0,
1101,0,0,47,292,0,9,1516,0,0,0,0,0,1,0,
1116,0,0,48,215,0,9,1545,0,0,0,0,0,1,0,
1131,0,0,49,411,0,9,1583,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1166,0,0,50,365,0,9,1597,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
1193,0,0,51,407,0,9,1646,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1224,0,0,52,357,0,9,1669,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1247,0,0,53,258,0,9,1707,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1274,0,0,54,204,0,9,1721,0,0,1,1,0,1,0,1,3,0,0,
1293,0,0,55,282,0,9,1773,0,0,0,0,0,1,0,
1308,0,0,56,63,0,9,1795,0,0,0,0,0,1,0,
1323,0,0,57,469,0,9,1837,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
1358,0,0,11,0,0,13,1894,0,0,33,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,
0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
1505,0,0,12,0,0,13,1933,0,0,33,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,
0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
1652,0,0,13,0,0,13,2000,0,0,14,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
1723,0,0,14,0,0,13,2019,0,0,14,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
1794,0,0,15,0,0,13,2072,0,0,29,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,
0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
1925,0,0,16,0,0,13,2106,0,0,29,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,
0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2056,0,0,18,0,0,13,2167,0,0,3,0,0,1,0,2,3,0,0,2,4,0,0,2,5,0,0,
2083,0,0,17,0,0,13,2195,0,0,12,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2146,0,0,19,0,0,13,2231,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,
2189,0,0,20,0,0,13,2266,0,0,12,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2252,0,0,21,0,0,13,2304,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,
2279,0,0,22,0,0,13,2331,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2314,0,0,23,0,0,13,2361,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,4,0,0,
2345,0,0,24,0,0,13,2389,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
2368,0,0,25,0,0,13,2414,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
2391,0,0,26,0,0,13,2439,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
2414,0,0,27,0,0,13,2463,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
2437,0,0,28,0,0,13,2491,0,0,6,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,
2476,0,0,29,0,0,13,2520,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
2499,0,0,30,0,0,13,2546,0,0,12,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,3,0,0,2,5,0,0,2,4,0,0,2,3,0,0,2,4,0,0,2,4,0,0,
2562,0,0,31,0,0,13,2608,0,0,4,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
2593,0,0,32,0,0,13,2637,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,
2624,0,0,33,0,0,13,2663,0,0,3,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,
2651,0,0,34,0,0,13,2688,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,
2678,0,0,35,0,0,13,2715,0,0,7,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,5,0,0,
2721,0,0,36,0,0,13,2750,0,0,8,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,
2768,0,0,37,0,0,13,2781,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,
2795,0,0,38,0,0,13,2807,0,0,7,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,4,0,0,
2,3,0,0,2,3,0,0,
2838,0,0,39,0,0,13,2835,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
2865,0,0,40,0,0,13,2859,0,0,5,0,0,1,0,2,3,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,3,0,0,
2900,0,0,41,0,0,13,2888,0,0,12,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,
2963,0,0,42,0,0,13,2923,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2998,0,0,43,0,0,13,2954,0,0,10,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,5,0,0,
3053,0,0,44,0,0,13,2989,0,0,3,0,0,1,0,2,5,0,0,2,4,0,0,2,5,0,0,
3080,0,0,45,0,0,13,3014,0,0,6,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,
2,4,0,0,
3119,0,0,46,0,0,13,3044,0,0,1,0,0,1,0,2,5,0,0,
3138,0,0,47,0,0,13,3076,0,0,14,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
3209,0,0,48,0,0,13,3114,0,0,11,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
3268,0,0,49,0,0,13,3151,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,
3295,0,0,50,0,0,13,3159,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,
3322,0,0,51,0,0,13,3195,0,0,8,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,
3369,0,0,52,0,0,13,3208,0,0,8,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,
3416,0,0,51,0,0,13,3249,0,0,8,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,
3463,0,0,52,0,0,13,3262,0,0,8,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,
3510,0,0,53,0,0,13,3294,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
3533,0,0,54,0,0,13,3301,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
3556,0,0,55,0,0,13,3335,0,0,5,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
3591,0,0,56,0,0,13,3361,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
3614,0,0,57,0,0,13,3394,0,0,15,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,4,0,
0,
3689,0,0,11,0,0,15,3435,0,0,0,0,0,1,0,
3704,0,0,12,0,0,15,3439,0,0,0,0,0,1,0,
3719,0,0,13,0,0,15,3456,0,0,0,0,0,1,0,
3734,0,0,14,0,0,15,3460,0,0,0,0,0,1,0,
3749,0,0,15,0,0,15,3477,0,0,0,0,0,1,0,
3764,0,0,16,0,0,15,3481,0,0,0,0,0,1,0,
3779,0,0,18,0,0,15,3496,0,0,0,0,0,1,0,
3794,0,0,17,0,0,15,3510,0,0,0,0,0,1,0,
3809,0,0,19,0,0,15,3524,0,0,0,0,0,1,0,
3824,0,0,20,0,0,15,3538,0,0,0,0,0,1,0,
3839,0,0,21,0,0,15,3552,0,0,0,0,0,1,0,
3854,0,0,22,0,0,15,3566,0,0,0,0,0,1,0,
3869,0,0,23,0,0,15,3580,0,0,0,0,0,1,0,
3884,0,0,24,0,0,15,3594,0,0,0,0,0,1,0,
3899,0,0,25,0,0,15,3608,0,0,0,0,0,1,0,
3914,0,0,26,0,0,15,3622,0,0,0,0,0,1,0,
3929,0,0,27,0,0,15,3636,0,0,0,0,0,1,0,
3944,0,0,28,0,0,15,3650,0,0,0,0,0,1,0,
3959,0,0,29,0,0,15,3664,0,0,0,0,0,1,0,
3974,0,0,30,0,0,15,3678,0,0,0,0,0,1,0,
3989,0,0,31,0,0,15,3706,0,0,0,0,0,1,0,
4004,0,0,32,0,0,15,3720,0,0,0,0,0,1,0,
4019,0,0,33,0,0,15,3734,0,0,0,0,0,1,0,
4034,0,0,34,0,0,15,3748,0,0,0,0,0,1,0,
4049,0,0,35,0,0,15,3762,0,0,0,0,0,1,0,
4064,0,0,36,0,0,15,3776,0,0,0,0,0,1,0,
4079,0,0,37,0,0,15,3790,0,0,0,0,0,1,0,
4094,0,0,38,0,0,15,3804,0,0,0,0,0,1,0,
4109,0,0,39,0,0,15,3818,0,0,0,0,0,1,0,
4124,0,0,40,0,0,15,3832,0,0,0,0,0,1,0,
4139,0,0,41,0,0,15,3846,0,0,0,0,0,1,0,
4154,0,0,42,0,0,15,3860,0,0,0,0,0,1,0,
4169,0,0,43,0,0,15,3874,0,0,0,0,0,1,0,
4184,0,0,44,0,0,15,3888,0,0,0,0,0,1,0,
4199,0,0,45,0,0,15,3902,0,0,0,0,0,1,0,
4214,0,0,46,0,0,15,3916,0,0,0,0,0,1,0,
4229,0,0,47,0,0,15,3930,0,0,0,0,0,1,0,
4244,0,0,48,0,0,15,3944,0,0,0,0,0,1,0,
4259,0,0,49,0,0,15,3961,0,0,0,0,0,1,0,
4274,0,0,50,0,0,15,3965,0,0,0,0,0,1,0,
4289,0,0,51,0,0,15,3982,0,0,0,0,0,1,0,
4304,0,0,52,0,0,15,3986,0,0,0,0,0,1,0,
4319,0,0,53,0,0,15,4003,0,0,0,0,0,1,0,
4334,0,0,54,0,0,15,4007,0,0,0,0,0,1,0,
4349,0,0,55,0,0,15,4026,0,0,0,0,0,1,0,
4364,0,0,56,0,0,15,4040,0,0,0,0,0,1,0,
4379,0,0,57,0,0,15,4054,0,0,0,0,0,1,0,
};


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sqlca.h>
#include <sqlcpr.h>

#include "GenORA.h"
#include "tipos.h"
#include "tablas.h"

/******************************************************************************
Funcion         :       ifnInitORATh
*******************************************************************************/

int ifnInitORATh (char * szUser,char * szPass,int *iCodCiclo,int iFactura, char *szFecSysDate, char *szFecEmision)
{
  	struct sqlca sqlca;
  	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int icod_ciclo=0;
		int icod_factura=0;
		static char* szhSysDate           ; /* EXEC SQL VAR szhSysDate       IS STRING(15); */ 

		static char* szhFecEmi            ; /* EXEC SQL VAR szhFecEmi        IS STRING(15); */ 

    	/* EXEC SQL END DECLARE SECTION; */ 


  	char szConnect[255];
  	memset(szConnect,0x00,sizeof(szConnect));
	fprintf(stdout,"\n (ifnInitORATh ).\n");
	fprintf(stdout,"\n (ifnInitORATh ) szUser==>[%s] \n",szUser);
	fprintf(stdout,"\n (ifnInitORATh ) szPass==>[%s] \n",szPass);

  	sprintf(szConnect,"%s/%s", szUser, szPass);

	szhSysDate=szFecSysDate;
	szhFecEmi =szFecEmision;

    	icod_factura=iFactura;
  	/* EXEC SQL CONNECT :szConnect; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )10;
   sqlstm.offset = (unsigned int  )5;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szConnect;
   sqlstm.sqhstl[0] = (unsigned long )255;
   sqlstm.sqhsts[0] = (         int  )255;
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
   sqlstm.sqlcmax = (unsigned int )100;
   sqlstm.sqlcmin = (unsigned int )2;
   sqlstm.sqlcincr = (unsigned int )1;
   sqlstm.sqlctimeout = (unsigned int )0;
   sqlstm.sqlcnowait = (unsigned int )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if(sqlca.sqlcode)
	{
		icod_ciclo=-1;
                *iCodCiclo=icod_ciclo;
		return sqlca.sqlcode;
	}

	fprintf(stdout,"\n[CARGA INICIAL] - COD_CICLFACT ==>[%d] ).\n",icod_factura);

  	/* EXEC SQL 
  		SELECT COD_CICLO, TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS')  
  			 INTO :icod_ciclo,
  			 	  :szhFecEmi
  		FROM FA_CICLFACT 
  		WHERE COD_CICLFACT=:icod_factura; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_CICLO ,TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS') \
into :b0,:b1  from FA_CICLFACT where COD_CICLFACT=:b2";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )36;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&icod_ciclo;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmi;
   sqlstm.sqhstl[1] = (unsigned long )15;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&icod_factura;
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


  			 
 	fprintf(stdout,"\n[CARGA INICIAL] - COD_CICLO   ==>[%d] ).\n",icod_ciclo);
 	fprintf(stdout,"\n[CARGA INICIAL] - FEC_EMISION ==>[%s] ).\n",szhFecEmi);
 	fprintf(stdout,"\n sqlca.sqlcode 2 ==>[%d] \n",sqlca.sqlcode);
    if(sqlca.sqlcode)
	{
		icod_ciclo=-1;
                *iCodCiclo=icod_ciclo;
		return sqlca.sqlcode;
	}
  	*iCodCiclo=icod_ciclo;

	/* EXEC SQL SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') INTO :szhSysDate FROM FA_DATOSGENER; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') into :b0  from FA\
_DATOSGENER ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )63;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhSysDate;
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


	if(sqlca.sqlcode)
	{
		icod_ciclo=-1;
                *iCodCiclo=icod_ciclo;
		return sqlca.sqlcode;
	}

  	/* EXEC SQL ENABLE THREADS; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )82;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnCommitReleaseTh
*******************************************************************************/

int ifnCommitReleaseTh(sql_context ctx)
{
  	struct sqlca sqlca;

  	/* EXEC SQL CONTEXT USE :ctx; */ 


  	/* EXEC SQL COMMIT RELEASE; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )97;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



  	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnConnectORATh
*******************************************************************************/

int ifnConnectORATh(char * szUser,char * szPass,sql_context *ctx)
{
	sql_context p;
  	struct sqlca sqlca;
  	char szConnect[255];
  	memset(szConnect,0x00,sizeof(szConnect));
  	sprintf(szConnect,"%s/%s", szUser, szPass);

  	/* EXEC SQL CONTEXT ALLOCATE :p; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )112;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&p;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(void *);
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



  	if(sqlca.sqlcode)
    	return sqlca.sqlcode;

  	/* EXEC SQL CONTEXT USE :p; */ 


  	/* EXEC SQL CONNECT :szConnect; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )10;
   sqlstm.offset = (unsigned int  )131;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szConnect;
   sqlstm.sqhstl[0] = (unsigned long )255;
   sqlstm.sqhsts[0] = (         int  )255;
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
   sqlstm.sqlcmax = (unsigned int )100;
   sqlstm.sqlcmin = (unsigned int )2;
   sqlstm.sqlcincr = (unsigned int )1;
   sqlstm.sqlctimeout = (unsigned int )0;
   sqlstm.sqlcnowait = (unsigned int )0;
   sqlcxt(&p, &sqlctx, &sqlstm, &sqlfpn);
}



  	if (sqlca.sqlcode)
    		return sqlca.sqlcode;

    	/* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT = 'YYYYMMDDHH24MISS'; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'YYYYMMDDHH24MISS'";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )162;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt(&p, &sqlctx, &sqlstm, &sqlfpn);
}



  	vfnActivateRoleTh(szUser,&p);

  	*ctx = p;
  	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       vfnActivateRoleTh
*******************************************************************************/
void vfnActivateRoleTh (char *szUser,sql_context ctx)
{
  	struct sqlca sqlca;
  	/* EXEC SQL CONTEXT USE :ctx; */ 


    /* EXEC SQL BEGIN DECLARE SECTION; */ 


        char szhCad[20]         ; /* EXEC SQL VAR szhCad           IS STRING(20) ; */ 

        char szhStm[512]        ; /* EXEC SQL VAR szhStm           IS STRING(255); */ 

        char *szhUser           ; /* EXEC SQL VAR szhUser          IS STRING(31) ; */ 

        char szhRA[512]         ; /* EXEC SQL VAR szhRA            IS STRING(512); */ 

        char szhGrantedRole[31] ; /* EXEC SQL VAR szhGrantedRole   IS STRING(31); */ 


    /* EXEC SQL END DECLARE SECTION; */ 


    char szPass[10] = "";
    char szRolesActivos[502];

    szhUser = szUser;

    /* EXEC SQL DECLARE C_RA CURSOR FOR
        SELECT ROLE
          FROM SESSION_ROLES; */ 


    /* EXEC SQL OPEN C_RA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )177;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode)
    {
        return;
    }

    strcpy(szRolesActivos,"");

    while (1)
    {
        /* EXEC SQL FETCH C_RA
                 INTO :szhRA; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )192;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRA;
        sqlstm.sqhstl[0] = (unsigned long )512;
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
        sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        if (sqlca.sqlcode == NOT_FOUND)
            break;

        if (sqlca.sqlcode <0)
        {
            fprintf(stderr,"* Error FETCH C_RA %s\n",szfnORAerror());
            strcpy(szRolesActivos,"");
            return;
        }

        sprintf(szRolesActivos,"%s %s,",szRolesActivos,szhRA);

    }

    /* EXEC SQL CLOSE C_RA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )211;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode)
    {
        fprintf(stderr,"vfnActivateRole() Close Code:%s\n", szfnORAerror());
        return;
    }

    if ((char*) strstr(szRolesActivos,"TCP_IUD") != (char*) NULL)
    {
        return;
    }

    strcpy (szhCad,"TCP_IUD");
    /* EXEC SQL
    SELECT GRANTED_ROLE
      INTO :szhGrantedRole
      FROM USER_ROLE_PRIVS
      WHERE GRANTED_ROLE = :szhCad
        AND USERNAME     = UPPER(:szhUser); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select GRANTED_ROLE into :b0  from USER_ROLE_PRIVS where \
(GRANTED_ROLE=:b1 and USERNAME=UPPER(:b2))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )226;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhGrantedRole;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCad;
    sqlstm.sqhstl[1] = (unsigned long )20;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhUser;
    sqlstm.sqhstl[2] = (unsigned long )31;
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode == NOT_FOUND)
    {
        return;
    }

    if (sqlca.sqlcode)
    {
        fprintf(stderr,"* Error G_RO %s\n",szfnORAerror());
        return;
    }

    szPass[0] = szhCad[0];
    szPass[1] = szhCad[4];
    szPass[2] = szhCad[2];
    szPass[3] = szhCad[5];
    szPass[4] = szhCad[1];
    szPass[5] = szhCad[3];
    szPass[6] = '6';
    szPass[7] = 'C';
    szPass[8] = '\0';

    sprintf(szhStm,"SET ROLE %s TCP_IUD IDENTIFIED BY %s\n",szRolesActivos,szPass);

    /* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )253;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
    sqlstm.sqhstl[0] = (unsigned long )255;
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



    return;
}

/******************************************************************************
Funcion         :       ifnOraDeclararFacClientes
*******************************************************************************/

int ifnOraDeclararFacClientes(sql_context ctx, int iCodCiclo, long ci, long cf, char *szFecEmision)
{
    struct sqlca sqlca;
    /* EXEC SQL CONTEXT USE :ctx; */ 


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 static int  ihCodCiclo  ;
	 static long  lhClieIni  ;
	 static long  lhClieFin  ;
 	 static int  ihCero  ;
	 static int  ihUno  ;
	 int	iExist;
	 static char szCadenaSQL[2200];
	 static char* szhFecEmision   ; /* EXEC SQL VAR szhFecEmision   IS STRING(15); */ 

         char szhFmtFecha[17] ; /* EXEC SQL VAR szhFmtFecha   IS STRING(17); */ 

    /* EXEC SQL END DECLARE SECTION  ; */ 


    ihCodCiclo = iCodCiclo  ;
    lhClieIni=ci;
    lhClieFin=cf;
    szhFecEmision=szFecEmision;

    ihCero = 0 ;
    ihUno  = 1 ;
    iExist = 0 ;
	
    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

    /* EXEC SQL
	 SELECT COUNT(1)
	 INTO   :iExist
	 FROM   ALL_TABLES
	 WHERE  TABLE_NAME = 'GA_VALOR_CLI'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from ALL_TABLES where TABLE_NAM\
E='GA_VALOR_CLI'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )272;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iExist;
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	
    if (sqlca.sqlcode)  
    {
        fprintf(stdout,"\n[CARGA INICIAL] - Error en ejecucion de la validacion de la tabla GA_VALOR_CLI [%d]\n",sqlca.sqlcode);
        return(sqlca.sqlcode);
    }
	
	
    if(lhClieFin!=0)
    {
       sprintf(szCadenaSQL, " SELECT DISTINCT :ihCero , \n"
      			    " CLI.COD_CLIENTE         , \n"
			    " CLI.NOM_CLIENTE         , \n"
			    " CLI.NOM_APECLIEN1       , \n"
			    " CLI.NOM_APECLIEN2       , \n"
			    " CLI.TEF_CLIENTE1        , \n"
			    " CLI.TEF_CLIENTE2        , \n"
			    " CLI.COD_PAIS            , \n"
			    " CLI.IND_DEBITO          , \n"
			    " CLI.IMP_STOPDEBIT       , \n"
			    " CLI.COD_BANCO           , \n"
			    " CLI.COD_SUCURSAL        , \n"
			    " CLI.IND_TIPCUENTA       , \n"
			    " CLI.COD_TIPTARJETA      , \n"
			    " CLI.NUM_CTACORR         , \n"
			    " CLI.NUM_TARJETA         , \n"
			    " TO_CHAR (CLI.FEC_VENCITARJ,:szhFmtFecha), \n"
			    " CLI.COD_BANCOTARJ       , \n"
			    " CLI.COD_TIPIDTRIB       , \n"
			    " CLI.NUM_IDENT           , \n"
			    " CLI.COD_ACTIVIDAD       , \n"
			    " CLI.COD_OFICINA         , \n"
			    " CLI.IND_FACTUR          , \n"
			    " CLI.NUM_FAX             , \n"
			    " TO_CHAR (CLI.FEC_ALTA,:szhFmtFecha), \n"
			    " CLI.COD_CUENTA          , \n"
			    " CLI.COD_IDIOMA          , \n"
			    " CLI.COD_OPERADORA       , \n"
			    " NVL(FCT.COD_DESPACHO,'FISIC') , \n"
			    " NVL(FCT.NOM_EMAIL,NVL(CLI.NOM_EMAIL,'SIN INFORMACION')), \n"
			    " NVL(GTI.COD_TIPIDENTDIAN,'01'), \n"
                            " DECODE(NVL(CLILOC.COD_CLIENTE, 0),CLILOC.COD_CLIENTE,1,0,0), \n");
       if (iExist == 0)
       {
	   fprintf(stdout,"\n[CARGA INICIAL] - La Tabla GA_VALOR_CLI NO existe por lo tanto todos los clientes tendra codigo de segmencacion igual a 0\n");
			   	
           sprintf(szCadenaSQL,"%s 0 \n"
		               " FROM GE_CLIENTES CLI, FA_CICLOCLI AL1, GE_CLILOCPADREHIJO_TO CLILOC, \n"
		   	       "      (SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA,\n"
		   	       "              NOM_EMAIL, COD_DESPACHO \n"
		   	       "       FROM   FA_CLIENTE_TO \n"
		   	       "       WHERE  COD_CLIENTE >= :lhClieIni \n"
			       "       AND    COD_CLIENTE <= :lhClieFin  \n"		   								
	                       "       AND  ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                               "       AND    NVL(FEC_HASTA,TO_DATE(:szhFecEmision,:szhFmtFecha)) >= TO_DATE(:szhFecEmision,:szhFmtFecha)) \n"
                               "       OR   ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                               "       AND    FEC_HASTA IS NULL)))) FCT,\n"										
			       "      GE_TIPIDENT GTI \n"
			       " WHERE CLI.COD_CLIENTE = AL1.COD_CLIENTE \n"
			       " AND AL1.COD_CICLO     = :ihCodCiclo \n"
			       " AND AL1.NUM_PROCESO   = :ihCero \n"
			       " AND AL1.IND_MASCARA   = :ihUno \n"
			       " AND AL1.COD_CLIENTE  >= :lhClieIni \n"
			       " AND AL1.COD_CLIENTE  <= :lhClieFin  \n"
                               " AND CLI.COD_CLIENTE   = CLILOC.COD_CLIENTE(+) \n"
			       " AND CLI.COD_TIPIDTRIB = GTI.COD_TIPIDENT (+)  \n"
			       " AND FCT.COD_CLIENTE(+)= AL1.COD_CLIENTE \n"			       
			      ,szCadenaSQL);
	}
	else
	{
	    sprintf(szCadenaSQL,"%s NVL(GVC.COD_VALOR,0) \n"
			        "FROM GE_CLIENTES CLI, FA_CICLOCLI AL1, GA_VALOR_CLI GVC, GE_CLILOCPADREHIJO_TO CLILOC, \n"
		   		"      (SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA,\n"
		   		"              NOM_EMAIL, COD_DESPACHO \n"
		   		"       FROM   FA_CLIENTE_TO \n"
		   		"       WHERE  COD_CLIENTE >= :lhClieIni \n"
                                "       AND    COD_CLIENTE <= :lhClieFin \n"
	                        "       AND  ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                                "       AND    NVL(FEC_HASTA,TO_DATE(:szhFecEmision,:szhFmtFecha)) >= TO_DATE(:szhFecEmision,:szhFmtFecha)) \n"
                                "       OR   ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                                "       AND    FEC_HASTA IS NULL)))) FCT,\n"
		   		"      GE_TIPIDENT GTI \n"
				" WHERE CLI.COD_CLIENTE  = AL1.COD_CLIENTE \n"
				" AND AL1.COD_CICLO      = :ihCodCiclo \n"
				" AND AL1.NUM_PROCESO    = :ihCero \n"
				" AND AL1.IND_MASCARA    = :ihUno \n"
				" AND AL1.COD_CLIENTE   >= :lhClieIni \n"
				" AND AL1.COD_CLIENTE   <= :lhClieFin \n"
                                " AND CLI.COD_CLIENTE    = CLILOC.COD_CLIENTE(+) \n"				
				" AND GVC.COD_CLIENTE(+) = AL1.COD_CLIENTE \n"
				" AND CLI.COD_TIPIDTRIB  = GTI.COD_TIPIDENT (+) \n"
				" AND FCT.COD_CLIENTE(+) = AL1.COD_CLIENTE \n"
		   	       ,szCadenaSQL);
           }
		   		
	   /* EXEC SQL PREPARE sql_FacClientes_R FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )291;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2200;
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	   if (sqlca.sqlcode)  
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - PREPARE sql_FacClientes_R [%d][%s]\n",sqlca.sqlcode,szCadenaSQL);
	       return(sqlca.sqlcode);
	   }
		        
	   /* EXEC SQL DECLARE CFacClientesR CURSOR FOR sql_FacClientes_R; */ 

	   if (sqlca.sqlcode)  
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - DECLARE CFacClientesR [%d]\n",sqlca.sqlcode);
	       return(sqlca.sqlcode);
	   }

	   /* EXEC SQL OPEN CFacClientesR USING :ihCero, :szhFmtFecha,:szhFmtFecha,
	                                     :lhClieIni,:lhClieFin,
				             :szhFecEmision,:szhFmtFecha,
				             :szhFecEmision,:szhFmtFecha,
				             :szhFecEmision,:szhFmtFecha,
				             :szhFecEmision,:szhFmtFecha,
				             :szhFecEmision,:szhFmtFecha,
				             :szhFecEmision,:szhFmtFecha,
				             :ihCodCiclo,:ihCero,:ihUno,:lhClieIni,:lhClieFin; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )310;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[2] = (unsigned long )17;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhClieIni;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhClieFin;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[6] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[6] = (unsigned long )17;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[7] = (unsigned long )15;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[8] = (unsigned long )17;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[9] = (unsigned long )15;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[10] = (unsigned long )17;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[11] = (unsigned long )15;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[12] = (unsigned long )17;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[13] = (unsigned long )15;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[14] = (unsigned long )17;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[15] = (unsigned long )15;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[16] = (unsigned long )17;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihCodCiclo;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)&lhClieIni;
    sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&lhClieFin;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	   if (sqlca.sqlcode)  
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - OPEN CFacClientesR [%d]\n",sqlca.sqlcode);
	       return(sqlca.sqlcode);
	   }
	}
	else
	{
	   sprintf(szCadenaSQL, " SELECT DISTINCT             \n"
       			        " :ihCero                   , \n"
       			  	" CLI.COD_CLIENTE           , \n"
				" CLI.NOM_CLIENTE           , \n"
				" CLI.NOM_APECLIEN1         , \n"
				" CLI.NOM_APECLIEN2         , \n"
				" CLI.TEF_CLIENTE1          , \n"
				" CLI.TEF_CLIENTE2          , \n"
				" CLI.COD_PAIS              , \n"
				" CLI.IND_DEBITO            , \n"
				" CLI.IMP_STOPDEBIT         , \n"
				" CLI.COD_BANCO             , \n"
				" CLI.COD_SUCURSAL          , \n"
				" CLI.IND_TIPCUENTA         , \n"
				" CLI.COD_TIPTARJETA        , \n"
				" CLI.NUM_CTACORR           , \n"
				" CLI.NUM_TARJETA           , \n"
				" TO_CHAR (CLI.FEC_VENCITARJ,:szhFmtFecha), \n"
				" CLI.COD_BANCOTARJ         , \n"
				" CLI.COD_TIPIDTRIB         , \n"
			        " CLI.NUM_IDENT             , \n"
				" CLI.COD_ACTIVIDAD         , \n"
				" CLI.COD_OFICINA           , \n"
				" CLI.IND_FACTUR            , \n"
				" CLI.NUM_FAX               , \n"
				" TO_CHAR (CLI.FEC_ALTA,:szhFmtFecha), \n"
				" CLI.COD_CUENTA            , \n"
				" CLI.COD_IDIOMA            , \n"
				" CLI.COD_OPERADORA         , \n"
				" NVL(FCT.COD_DESPACHO,'FISIC')      , \n"
				" NVL(FCT.NOM_EMAIL,NVL(CLI.NOM_EMAIL,'SIN INFORMACION')), \n"
				" NVL(GTI.COD_TIPIDENTDIAN,'01'), \n"
                                " DECODE(NVL(CLILOC.COD_CLIENTE, 0),CLILOC.COD_CLIENTE,1,0,0), \n");
	   if (iExist == 0)
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - La Tabla GA_VALOR_CLI NO existe por lo tanto todos los clientes tendra codigo de segmencacion igual a 0\n");
	
	       sprintf(szCadenaSQL,"%s 0 \n"
				   " FROM GE_CLIENTES CLI, FA_CICLOCLI AL1, GE_CLILOCPADREHIJO_TO CLILOC, \n"
		   		   "      (SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA,\n"
		   		   "              NOM_EMAIL, COD_DESPACHO \n"
		   		   "       FROM   FA_CLIENTE_TO \n"
		   		   "       WHERE  COD_CLIENTE <= :lhClieIni \n"
	                           "       AND  ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                                   "       AND    NVL(FEC_HASTA,TO_DATE(:szhFecEmision,:szhFmtFecha)) >= TO_DATE(:szhFecEmision,:szhFmtFecha)) \n"
                                   "       OR   ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                                   "       AND    FEC_HASTA IS NULL)))) FCT,\n"				
                                   "      GE_TIPIDENT GTI \n"
				   " WHERE CLI.COD_CLIENTE  = AL1.COD_CLIENTE \n"
				   " AND AL1.COD_CICLO      = :ihCodCiclo \n"
				   " AND AL1.NUM_PROCESO    = :ihCero \n"
				   " AND AL1.IND_MASCARA    = :ihUno \n"
				   " AND AL1.COD_CLIENTE   <= :lhClieIni  \n"
                                   " AND CLI.COD_CLIENTE    =  CLILOC.COD_CLIENTE(+) \n"
				   " AND CLI.COD_TIPIDTRIB  = GTI.COD_TIPIDENT (+)  \n"
				   " AND FCT.COD_CLIENTE(+) = AL1.COD_CLIENTE \n"
				  ,szCadenaSQL);
	   }
	   else
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - La Tabla GA_VALOR_CLI existe por lo tanto todos los clientes tendra codigo de segmentacion \n");	   	
	   	
	       sprintf(szCadenaSQL,"%s NVL(GVC.COD_VALOR,0) \n"
		                   " FROM GE_CLIENTES CLI, FA_CICLOCLI AL1, GA_VALOR_CLI GVC, GE_CLILOCPADREHIJO_TO CLILOC, \n"
		   		   "      (SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA,\n"
		   		   "              NOM_EMAIL, COD_DESPACHO \n"
		   		   "       FROM   FA_CLIENTE_TO \n"
		   		   "       WHERE  COD_CLIENTE >= :lhClieIni \n"
	                           "       AND  ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                                   "       AND    NVL(FEC_HASTA,TO_DATE(:szhFecEmision,:szhFmtFecha)) >= TO_DATE(:szhFecEmision,:szhFmtFecha)) \n"
                                   "       OR   ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) \n"
                                   "       AND    FEC_HASTA IS NULL)))) FCT,\n"		   									
		   		   "      GE_TIPIDENT GTI \n"
    		                   " WHERE CLI.COD_CLIENTE  = AL1.COD_CLIENTE  \n"
				   " AND AL1.COD_CICLO      = :ihCodCiclo  \n"
				   " AND AL1.NUM_PROCESO    = :ihCero  \n"
				   " AND AL1.IND_MASCARA    = :ihUno  \n"
				   " AND AL1.COD_CLIENTE   >= :lhClieIni  \n"
                                   " AND CLI.COD_CLIENTE    =  CLILOC.COD_CLIENTE(+) \n"				   
				   " AND GVC.COD_CLIENTE(+) = AL1.COD_CLIENTE  \n"
				   " AND CLI.COD_TIPIDTRIB  = GTI.COD_TIPIDENT (+)  \n"
				   " AND FCT.COD_CLIENTE(+) = AL1.COD_CLIENTE \n"
		   		  ,szCadenaSQL);
		   		  
	       fprintf(stdout,"\n[CARGA INICIAL] - Query [%s]\n",szCadenaSQL);
		   		  
	   }
		   		
	   /* EXEC SQL PREPARE sql_FacClientes FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )413;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2200;
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	   if (sqlca.sqlcode)  
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - PREPARE sql_FacClientes [%d][%s]\n",sqlca.sqlcode,szCadenaSQL);
	       return(sqlca.sqlcode);
	   }
		        
	   /* EXEC SQL DECLARE CFacClientes CURSOR FOR sql_FacClientes; */ 

	   if (sqlca.sqlcode)  
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - DECLARE CFacClientesR [%d]\n",sqlca.sqlcode);
	       return(sqlca.sqlcode);
	   }

	   /* EXEC SQL OPEN CFacClientes USING :ihCero, :szhFmtFecha,:szhFmtFecha,:lhClieIni,
                                            :szhFecEmision,:szhFmtFecha,
                                            :szhFecEmision,:szhFmtFecha,
                                            :szhFecEmision,:szhFmtFecha,
                                            :szhFecEmision,:szhFmtFecha,
                                            :szhFecEmision,:szhFmtFecha,
                                            :szhFecEmision,:szhFmtFecha,				
				            :ihCodCiclo,:ihCero,:ihUno,:lhClieIni; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )432;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[2] = (unsigned long )17;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhClieIni;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[5] = (unsigned long )17;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[7] = (unsigned long )17;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[8] = (unsigned long )15;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[9] = (unsigned long )17;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[10] = (unsigned long )15;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[11] = (unsigned long )17;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[12] = (unsigned long )15;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[13] = (unsigned long )17;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[14] = (unsigned long )15;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[15] = (unsigned long )17;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&ihCodCiclo;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&lhClieIni;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


				                                 
	   if (sqlca.sqlcode)  
	   {
	       fprintf(stdout,"\n[CARGA INICIAL] - OPEN CFacClientesR [%d]\n",sqlca.sqlcode);
	       return(sqlca.sqlcode);
	   }
	}

    return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararFacCiclo
*******************************************************************************/

int ifnOraDeclararFacCiclo(sql_context ctx, int iCodCiclo, long ci, long cf)
{
        struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		static int  ihCodCiclo  ;
		static long  lhClieIni  ;
		static long  lhClieFin  ;
	/* EXEC SQL END DECLARE SECTION  ; */ 


	ihCodCiclo = iCodCiclo  ;
	lhClieIni=ci;
	lhClieFin=cf;

	if(lhClieFin!=0)
	{
	  	/* EXEC SQL DECLARE CFacCicloR CURSOR FOR
			SELECT
				ROWID        ,
			        COD_CLIENTE  ,
			        COD_PRODUCTO ,
			        NUM_ABONADO  ,
			        COD_CALCLIEN ,
			        IND_CAMBIO   ,
			        NOM_USUARIO  ,
			        NOM_APELLIDO1,
			        NOM_APELLIDO2,
			        COD_CREDMOR  ,
			        IND_DEBITO   ,
			        COD_CICLONUE ,
			        TO_CHAR (FEC_ALTA, 'YYYYMMDDHH24MISS'),
			        nvl(TO_CHAR (FEC_ULTFACT, 'YYYYMMDDHH24MISS'), ' ')
			FROM FA_CICLOCLI
			      	WHERE COD_CICLO    = :ihCodCiclo
			        AND NUM_PROCESO  = 0
			    	AND IND_MASCARA  = 1
			    	AND COD_CLIENTE >= :lhClieIni
			    	AND COD_CLIENTE <= :lhClieFin
			ORDER BY COD_CLIENTE,FEC_ALTA; */ 
 /* P-MIX-09003 */
		/* EXEC SQL OPEN CFacCicloR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0013;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )527;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhClieIni;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhClieFin;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
			/* EXEC SQL DECLARE CFacCiclo CURSOR FOR
			SELECT
				ROWID        ,
			        COD_CLIENTE  ,
			        COD_PRODUCTO ,
			        NUM_ABONADO  ,
			        COD_CALCLIEN ,
			        IND_CAMBIO   ,
			        NOM_USUARIO  ,
			        NOM_APELLIDO1,
			        NOM_APELLIDO2,
			        COD_CREDMOR  ,
			        IND_DEBITO   ,
			        COD_CICLONUE ,
			        TO_CHAR (FEC_ALTA, 'YYYYMMDDHH24MISS'),
			        nvl(TO_CHAR (FEC_ULTFACT, 'YYYYMMDDHH24MISS'), ' ')
			FROM FA_CICLOCLI
			      	WHERE COD_CICLO    = :ihCodCiclo
			        AND NUM_PROCESO  = 0
			    	AND IND_MASCARA  = 1
			    	AND COD_CLIENTE >= :lhClieIni
			ORDER BY COD_CLIENTE, FEC_ALTA; */ 
 /* P-MIX-09003 */
		/* EXEC SQL OPEN CFacCiclo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0014;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )554;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhClieIni;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

        return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCargos
*******************************************************************************/

int ifnOraDeclararGeCargos (sql_context ctx, long ciclo, long ci, long cf)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		static int  lCodCiclo  ;
		static long  lhClieIni  ;
		static long  lhClieFin  ;
	/* EXEC SQL END DECLARE SECTION  ; */ 


        lCodCiclo=ciclo;
	lhClieIni=ci;
	lhClieFin=cf;

	if(lhClieFin!=0)
	{
		/* EXEC SQL DECLARE CGeCargosR CURSOR FOR
		SELECT /o + index (A,  AK_GE_CARGOS_CODCLIENTE) o/
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
		FROM   GE_CARGOS A, FA_CICLFACT B, (select distinct cod_cliente from fa_ciclocli where num_proceso=0 and ind_mascara=1 and cod_ciclo=:lCodCiclo AND COD_CLIENTE >=  :lhClieIni	AND COD_CLIENTE <= :lhClieFin) CLI
		WHERE  A.COD_CLIENTE     = CLI.COD_CLIENTE
		  AND  A.NUM_FACTURA     = 0
		  AND  A.NUM_TRANSACCION = 0
		  AND  A.IMP_CARGO      != 0
		  AND  A.COD_CICLFACT = B.COD_CICLFACT
		  AND B.IND_FACTURACION IN (1,2); */ 


		/* EXEC SQL OPEN CGeCargosR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0015;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )577;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhClieIni;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhClieFin;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
        			/* EXEC SQL DECLARE CGeCargos CURSOR FOR
		SELECT /o + index (A,  AK_GE_CARGOS_CODCLIENTE) o/
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
		FROM  GE_CARGOS A, FA_CICLFACT B, (SELECT DISTINCT COD_CLIENTE FROM FA_CICLOCLI WHERE NUM_PROCESO=0 AND IND_MASCARA=1 AND COD_CICLO=:lCodCiclo AND COD_CLIENTE >= :lhClieIni) CLI
		WHERE A.COD_CLIENTE      = CLI.COD_CLIENTE 
		  AND A.NUM_FACTURA      = 0
		  AND A.NUM_TRANSACCION  = 0
		  AND A.IMP_CARGO       != 0
		  AND A.COD_CICLFACT     = B.COD_CICLFACT
		  AND B.IND_FACTURACION IN (1,2); */ 


		/* EXEC SQL OPEN CGeCargos; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0016;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )604;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhClieIni;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCabCuotas
*******************************************************************************/

int ifnOraDeclararGeCabCuotas (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeCabCuotas CURSOR FOR
	SELECT
		ROWID
		,SEQ_CUOTAS
		,COD_CLIENTE
		,COD_CONCEPTO
		,COD_MONEDA
		,COD_PRODUCTO
		,NUM_CUOTAS
		,IMP_TOTAL
		,IND_PAGADA
		,NUM_ABONADO
		,COD_CUOTA
		,NUM_PAGARE
	FROM
	FA_CABCUOTAS; */ 


	/* EXEC SQL OPEN CGeCabCuotas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0017;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )627;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCargosRecurrentes
*******************************************************************************/

int ifnOraDeclararGeCargosRecurrentes (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeCargosRecurrentes CURSOR FOR
       SELECT 
	   COD_CARGO,
	   MONTO_IMPORTE,
	   COD_MONEDA
	FROM 
	PF_CARGOS_PRODUCTOS_TD
	ORDER BY COD_CARGO; */ 


	/* EXEC SQL OPEN CGeCargosRecurrentes; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0018;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )642;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeTaConcepFact
*******************************************************************************/

int ifnOraDeclararGeTaConcepFact (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeTaConcepFact CURSOR FOR
	SELECT
		COD_PRODUCTO
		,COD_FACTURACION
		,IND_TABLA
		,IND_ENTSAL
		,IND_DESTINO
		,COD_TARIFICACION
		,COD_SERVICIO
	FROM
	TA_CONCEPFACT; */ 


	/* EXEC SQL OPEN CGeTaConcepFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0019;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )657;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeConceptos
*******************************************************************************/

int ifnOraDeclararGeConceptos (sql_context ctx, long lCodCiclFact)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 

        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static long lhCodCiclFact  ;
        static char szCodModulo[3];
		static int  iCodParametro;
    /* EXEC SQL END DECLARE SECTION  ; */ 


    lhCodCiclFact = lCodCiclFact;
    strcpy(szCodModulo,"FA");
	iCodParametro = 12;

	/* EXEC SQL DECLARE CGeConceptos CURSOR FOR
	SELECT /o + FULL(FA_CONCEPTOS) o/
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


	/* EXEC SQL OPEN CGeConceptos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0020;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )672;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeConceptos_Mi
*******************************************************************************/

int ifnOraDeclararGeConceptos_Mi (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeConceptos_Mi CURSOR FOR

	SELECT /o + FULL(GE_MULTIIDIOMA) o/
              	 to_number(COD_CONCEPTO),
                 COD_IDIOMA  ,
                 DES_CONCEPTO
          FROM   GE_MULTIIDIOMA
          WHERE   NOM_TABLA = 'FA_CONCEPTOS'
            AND   NOM_CAMPO = 'COD_CONCEPTO'
            ORDER  BY to_number(COD_CONCEPTO); */ 


	/* EXEC SQL OPEN CGeConceptos_Mi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0021;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )699;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeRangoTabla
*******************************************************************************/

int ifnOraDeclararGeRangoTabla (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeRangoTabla CURSOR FOR
	SELECT
		 COD_CICLFACT
		,RANGO_INI
		,RANGO_FIN
		,COD_PRODUCTO
		,NOM_TABLA
	FROM
	FA_RANGO_TABLA; */ 


	/* EXEC SQL OPEN CGeRangoTabla; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0022;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )714;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeLimCreditos
*******************************************************************************/

int ifnOraDeclararGeLimCreditos (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeLimCreditos CURSOR FOR
	SELECT COD_CREDMOR
		  ,COD_PRODUCTO
		  ,COD_CALCLIEN
		  ,IMP_MOROSIDAD
	FROM CO_LIMCREDITOS; */ 


	/* EXEC SQL OPEN CGeLimCreditos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0023;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )729;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeActividades
*******************************************************************************/

int ifnOraDeclararGeActividades (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeActividades CURSOR FOR
	SELECT COD_Actividad
		  ,DES_Actividad
	  FROM GE_ACTIVIDADES; */ 


	/* EXEC SQL OPEN CGeActividades; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0024;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )744;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeProvincias
*******************************************************************************/

int ifnOraDeclararGeProvincias (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeProvincias CURSOR FOR
	SELECT COD_REGION
		  ,COD_PROVINCIA
		  ,DES_PROVINCIA
	FROM GE_PROVINCIAS; */ 


	/* EXEC SQL OPEN CGeProvincias; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0025;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )759;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeRegiones
*******************************************************************************/

int ifnOraDeclararGeRegiones (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeRegiones CURSOR FOR
	SELECT COD_REGION
		  ,DES_REGION
	FROM GE_REGIONES; */ 


	/* EXEC SQL OPEN CGeRegiones; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0026;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )774;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCatImpositiva
*******************************************************************************/

int ifnOraDeclararGeCatImpositiva (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeCatImpositiva CURSOR FOR
	SELECT COD_CATIMPOS
		  ,DES_CATIMPOS
	FROM GE_CATIMPOSITIVA; */ 


	/* EXEC SQL OPEN CGeCatImpositiva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0027;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )789;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeZonaCiudad
*******************************************************************************/

int ifnOraDeclararGeZonaCiudad (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeZonaCiudad CURSOR FOR
	SELECT COD_REGION
		,COD_PROVINCIA
		,COD_CIUDAD
		,TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS')
		,TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS')
		,COD_ZONAIMPO
	FROM
	GE_ZONACIUDAD; */ 


	/* EXEC SQL OPEN CGeZonaCiudad; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0028;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )804;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeZonaImpositiva
*******************************************************************************/

int ifnOraDeclararGeZonaImpositiva (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeZonaImpositiva CURSOR FOR
	SELECT COD_ZONAIMPO
		  ,DES_ZONAIMPO
	FROM
	GE_ZONAIMPOSITIVA; */ 


	/* EXEC SQL OPEN CGeZonaImpositiva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0029;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )819;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeImpuestos
*******************************************************************************/

int ifnOraDeclararGeImpuestos (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeImpuestos CURSOR FOR
	SELECT I.COD_CATIMPOS
		,I.COD_ZONAIMPO
		,I.COD_ZONAABON
		,I.COD_TIPIMPUES
		,I.COD_GRPSERVI
		,TO_CHAR (I.FEC_DESDE,'YYYYMMDD')||'000000'
		,I.COD_CONCGENE
		,TO_CHAR (I.FEC_HASTA,'YYYYMMDD')||'235959'
		,I.PRC_IMPUESTO
		,T.TIP_MONTO
		,T.IMP_UMBRAL
        ,T.IMP_MAXIMO
	FROM
	GE_IMPUESTOS I,GE_TIPIMPUES T
	WHERE I.COD_TIPIMPUES=T.COD_TIPIMPUE; */ 


	/* EXEC SQL OPEN CGeImpuestos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0030;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )834;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeTipImpues
*******************************************************************************/
/*
int ifnOraDeclararGeTipImpues (sql_context ctx)
{
	struct sqlca sqlca;
        EXEC SQL CONTEXT USE :ctx;

	EXEC SQL DECLARE CGeTipImpues CURSOR FOR
	SELECT COD_TIPIMPUE
		  ,IMP_UMBRAL
		  ,TIP_MONTO
		  ,COD_CATEIMP
	FROM GE_TIPIMPUES;

	EXEC SQL OPEN CGeTipImpues;

	return sqlca.sqlcode;
}
*/
/******************************************************************************
Funcion         :       ifnOraDeclararGeGrpSerConc
*******************************************************************************/

int ifnOraDeclararGeGrpSerConc (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeGrpSerConc CURSOR FOR
	SELECT COD_CONCEPTO
		  ,TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS')
		  ,COD_GRPSERVI
		  ,TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS')
	FROM
	FA_GRPSERCONC; */ 


	/* EXEC SQL OPEN CGeGrpSerConc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0031;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )849;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeConversion
*******************************************************************************/

int ifnOraDeclararGeConversion (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeConversion CURSOR FOR
	SELECT COD_MONEDA
		  ,TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS')
		  ,TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS')
		  ,CAMBIO
	FROM GE_CONVERSION; */ 


	/* EXEC SQL OPEN CGeConversion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0032;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )864;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeDocumSucursal
*******************************************************************************/

int ifnOraDeclararGeDocumSucursal (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeDocumSucursal CURSOR FOR
	SELECT COD_OFICINA
		,COD_TIPDOCUM
		,COD_CENTREMI
	FROM
	AL_DOCUM_SUCURSAL; */ 


	/* EXEC SQL OPEN CGeDocumSucursal; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0033;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )879;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeLetras
*******************************************************************************/

int ifnOraDeclararGeLetras (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeLetras CURSOR FOR
	SELECT COD_TIPDOCUM
		  ,COD_CATIMPOS
		  ,LETRA
	FROM GE_LETRAS; */ 


	/* EXEC SQL OPEN CGeLetras; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0034;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )894;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeGrupoCob
*******************************************************************************/

int ifnOraDeclararGeGrupoCob (sql_context ctx, int iCodCiclo)
{
    struct sqlca sqlca;
    /* EXEC SQL CONTEXT USE :ctx; */ 


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static int    ihCodCiclo   ;
    /* EXEC SQL END DECLARE SECTION  ; */ 


    ihCodCiclo = iCodCiclo;

/* P-MIX-09003 */	

    /* EXEC SQL DECLARE CGeGrupoCob CURSOR FOR             
             SELECT A.COD_GRUPO
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
                    UNION
                    SELECT COD_CONCEPTO, MAX(DECODE(NVL(B.TIP_COBRO,0),'A',1,0)) TIP_COBRO
                    FROM   GA_SERVSUPL B, GA_ACTUASERV C 
                    WHERE  B.COD_SERVICIO = C.COD_SERVICIO GROUP BY COD_CONCEPTO)                                  
                    GROUP BY COD_CONCEPTO) B
             WHERE A.COD_CICLO = :ihCodCiclo
             AND   A.COD_CONCEPTO = B.COD_CONCEPTO (+)
             ORDER BY A.COD_GRUPO, A.COD_CONCEPTO, A.COD_PRODUCTO, A.COD_CICLO; */ 
             
             
/* P-MIX-09003 */             

    /* EXEC SQL OPEN CGeGrupoCob; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0035;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )909;
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
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



    return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeTarifas
*******************************************************************************/

int ifnOraDeclararGeTarifas (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeTarifas CURSOR FOR
	SELECT  COD_TIPSERV
		   ,COD_SERVICIO
		   ,COD_PLANSERV
		   ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS')
		   ,IMP_TARIFA
		   ,COD_MONEDA
		   ,IND_PERIODICO
		   ,TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS')
	 FROM GA_TARIFAS
    WHERE COD_PRODUCTO= 1
      AND COD_ACTABO  = 'FA'; */ 


	/* EXEC SQL OPEN CGeTarifas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0036;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )928;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeActuaServ
*******************************************************************************/

int ifnOraDeclararGeActuaServ (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeActuaServ CURSOR FOR
	SELECT COD_TIPSERV
		  ,COD_SERVICIO
		  ,COD_CONCEPTO
	FROM GA_ACTUASERV; */ 


	/* EXEC SQL OPEN CGeActuaServ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0037;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )943;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCuotas
*******************************************************************************/

int ifnOraDeclararGeCuotas (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeCuotas CURSOR FOR
	SELECT
		ROWID
		,SEQ_CUOTAS
		,ORD_CUOTA
		,TO_CHAR (FEC_EMISION,'YYYYMMDDHH24MISS')
		,IMP_CUOTA
		,IND_FACTURADO
		,IND_PAGADO
	FROM
	FA_CUOTAS; */ 


	/* EXEC SQL OPEN CGeCuotas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0038;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )958;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeFactCarriers
*******************************************************************************/

int ifnOraDeclararGeFactCarriers (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeFactCarriers CURSOR FOR
       SELECT /o + full (FA_FACTCARRIERS) o/
              A.COD_CONCFACT,
              A.COD_CONCCARRIER,
              B.COD_TIPCONCE
       FROM   FA_FACTCARRIERS A,
       		  FA_CONCEPTOS B
       WHERE  B.COD_CONCEPTO = A.COD_CONCFACT; */ 


	/* EXEC SQL OPEN CGeFactCarriers; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0039;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )973;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCuadCtoPlan
*******************************************************************************/

int ifnOraDeclararGeCuadCtoPlan (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeCuadCtoPlan CURSOR FOR
	SELECT COD_CTOPLAN
		,IMP_UMBDESDE
		,IMP_UMBHASTA
		,IMP_DESCUENTO
		,COD_TIPODTO
	FROM
	VE_CUADCTOPLAN; */ 


	/* EXEC SQL OPEN CGeCuadCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0040;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )988;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCtoPlan
*******************************************************************************/

int ifnOraDeclararGeCtoPlan (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeCtoPlan CURSOR FOR
	SELECT COD_CTOPLAN
		,COD_PRODUCTO
		,COD_TIPCTOPLAN
		,COD_MONEDA
		,COD_CTOFAC
		,IMP_DESCUENTO
		,COD_TIPODTO
		,IND_CUADRANTE
		,COD_TIPOCUAD
		,IMP_UMBDESDE
		,IMP_UMBHASTA
		,NUM_DIAS
	FROM
	VE_CTOPLAN; */ 


	/* EXEC SQL OPEN CGeCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0041;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1003;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGePlanCtoPlan
*******************************************************************************/

int ifnOraDeclararGePlanCtoPlan (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGePlanCtoPlan CURSOR FOR
	SELECT COD_PLANCOM
		,COD_PRODUCTO
		,COD_CTOPLAN
		,TO_CHAR (FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS')
		,TO_CHAR (FEC_FINEFECTIVIDAD,'YYYYMMDDHH24MISS')
	FROM
	VE_PLAN_CTOPLAN; */ 


	/* EXEC SQL OPEN CGePlanCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0042;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1018;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeArriendo
*******************************************************************************/

int ifnOraDeclararGeArriendo (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeArriendo CURSOR FOR
	SELECT
		ROWID
		,COD_CLIENTE
		,NUM_ABONADO
		,TO_CHAR (FEC_DESDE,'YYYYMMDDHH24MISS')
		,TO_CHAR (FEC_HASTA,'YYYYMMDDHH24MISS')
		,COD_PRODUCTO
		,COD_CONCEPTO
		,COD_ARTICULO
		,PRECIO_MES
		,COD_MONEDA
	FROM
	FA_ARRIENDO; */ 


	/* EXEC SQL OPEN CGeArriendo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0043;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1033;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCargosBasico
*******************************************************************************/

int ifnOraDeclararGeCargosBasico (sql_context ctx, char *pszFecEmision)
{
	struct sqlca sqlca;
	/* EXEC SQL CONTEXT USE :ctx; */ 


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static char szhFecEmision[15];
    /* EXEC SQL END DECLARE SECTION  ; */ 


	strcpy (szhFecEmision, pszFecEmision);
	
	/* EXEC SQL DECLARE CGeCargosBasico CURSOR FOR
	SELECT COD_CARGOBASICO
		  ,IMP_CARGOBASICO
		  ,COD_MONEDA
	 FROM TA_CARGOSBASICO
	WHERE TO_DATE (:szhFecEmision, 'YYYYMMDDHH24MISS') >= FEC_DESDE
	  AND TO_DATE (:szhFecEmision, 'YYYYMMDDHH24MISS') <= NVL(FEC_HASTA, TO_DATE ('30000101000000', 'YYYYMMDDHH24MISS'))
	  AND COD_PRODUCTO = 1; */ 


	/* EXEC SQL OPEN CGeCargosBasico; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0044;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1048;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeOptimo
*******************************************************************************/

int ifnOraDeclararGeOptimo (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeOptimo CURSOR FOR
	SELECT
		COD_PLANTARIF
		,MIN_DESDE
		,MIN_HASTA
		,PRC_ABONO
		,PRC_NORMAL
		,PRC_BAJO
	FROM
	FA_OPTIMO; */ 


	/* EXEC SQL OPEN CGeOptimo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0045;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1071;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}
/******************************************************************************
Funcion         :       ifnOraDeclararGeFeriados
*******************************************************************************/

int ifnOraDeclararGeFeriados (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeFeriados CURSOR FOR
	SELECT
		TO_CHAR(FEC_DIAFEST,'YYYYMMDDHH24MISS')
	FROM
	TA_DIASFEST; */ 


	/* EXEC SQL OPEN CGeFeriados; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0046;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1086;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGePlanTarif
*******************************************************************************/

int ifnOraDeclararGePlanTarif (sql_context ctx,char *pszFecEmision)
{
    struct sqlca sqlca;
    /* EXEC SQL CONTEXT USE :ctx; */ 


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char szhFecEmision[15];
    /* EXEC SQL END DECLARE SECTION  ; */ 


    strcpy (szhFecEmision, pszFecEmision);

    /* EXEC SQL DECLARE CGePlanTarif CURSOR FOR
	 SELECT /o + full (TA_PLANTARIF) o/
		    COD_PLANTARIF,
		    TIP_TERMINAL,
		    COD_LIMCONSUMO,
		    COD_CARGOBASICO,
		    TIP_PLANTARIF,
		    TIP_UNIDADES,
		    NUM_UNIDADES,
		    IND_ARRASTRE,
		    NUM_DIAS,
		    NUM_ABONADOS,
		    IND_FRANCONS,
		    FLG_RANGO,
		    TO_CHAR(NVL(IND_COMPARTIDO,0)),     /o P-MIX-09003 o/
		    DECODE(NVL(TIP_COBRO,'V'),'A',1,0)  /o P-MIX-09003 o/		    
         FROM TA_PLANTARIF
	 WHERE COD_PRODUCTO = 1; */ 


    /* EXEC SQL OPEN CGePlanTarif; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0047;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1101;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



    return sqlca.sqlcode;
}
/******************************************************************************
Funcion         :       ifnOraDeclararGePenalizaciones
*******************************************************************************/

int ifnOraDeclararGePenalizaciones (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGePenalizaciones CURSOR FOR
	SELECT
		ROWID
		,COD_CLIENTE
		,TIP_INCIDENCIA
		,TO_CHAR (FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS')
		,COD_MONEDA
		,IMP_PENALIZ
		,COD_CICLFACT
		,COD_CONCEPTO
		,COD_PRODUCTO
		,NUM_ABONADO
		,NUM_PROCESO
	FROM
	CA_PENALIZACIONES; */ 


	/* EXEC SQL OPEN CGePenalizaciones; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0048;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1116;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion         :       ifnOraDeclararGeCatImpClientes
*******************************************************************************/

int ifnOraDeclararGeCatImpClientes (sql_context ctx,char *szFecha,long ciclo, long ci, long cf)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


        /* EXEC SQL BEGIN DECLARE SECTION; */ 

 	static char* szhFecha   ; /* EXEC SQL VAR szhFecha         IS STRING(15); */ 

 	static long  lCodCiclo  ;
	static long  lhClieIni  ;
	static long  lhClieFin  ;
 	/* EXEC SQL END DECLARE SECTION; */ 


        szhFecha        = szFecha       ;
        lCodCiclo	= ciclo		;
        lhClieIni	= ci		;
        lhClieFin	= cf		;

        if (lhClieFin!=0)
        {
			/* EXEC SQL DECLARE CGeCatImpClientesR CURSOR FOR
			SELECT /o + index (GE_CATIMPCLIENTES PK_GE_CATIMPCLIENTES) o/
		      	  A.COD_CLIENTE   ,
	          	  A.COD_CATIMPOS  ,
	          	  TO_CHAR (FA_SEQ_IND_ORDENTOTAL.NEXTVAL)
	         FROM GE_CATIMPCLIENTES A, (SELECT DISTINCT COD_CLIENTE FROM FA_CICLOCLI WHERE NUM_PROCESO=0 AND IND_MASCARA=1 AND COD_CICLO=:lCodCiclo AND COD_CLIENTE >=:lhClieIni AND COD_CLIENTE <= :lhClieFin) CLI
	        WHERE A.COD_CLIENTE = CLI.COD_CLIENTE 
	          AND A.FEC_DESDE <= TO_DATE (:szhFecha,'YYYYMMDDHH24MISS')
	          AND A.FEC_HASTA >= TO_DATE (:szhFecha,'YYYYMMDDHH24MISS'); */ 


		/* EXEC SQL OPEN CGeCatImpClientesR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0049;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1131;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhClieIni;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhClieFin;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecha;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL DECLARE CGeCatImpClientes CURSOR FOR
		SELECT /o + index (GE_CATIMPCLIENTES PK_GE_CATIMPCLIENTES) o/
	        	A.COD_CLIENTE   ,
	                A.COD_CATIMPOS  ,
	                TO_CHAR (FA_SEQ_IND_ORDENTOTAL.NEXTVAL)
	         FROM GE_CATIMPCLIENTES A, (select distinct cod_cliente from fa_ciclocli where num_proceso=0 and ind_mascara=1 and cod_ciclo=:lCodCiclo) CLI
	        WHERE A.COD_CLIENTE = CLI.COD_CLIENTE
	          AND A.FEC_DESDE <= TO_DATE (:szhFecha,'YYYYMMDDHH24MISS')
	          AND A.FEC_HASTA >= TO_DATE (:szhFecha,'YYYYMMDDHH24MISS'); */ 


		/* EXEC SQL OPEN CGeCatImpClientes; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0050;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1166;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[1] = (unsigned long )15;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFecha;
  sqlstm.sqhstl[2] = (unsigned long )15;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraDeclararGeDirecciones
*******************************************************************************/

int ifnOraDeclararGeDirecciones (sql_context ctx,int iTipDireccion,long ciclo, long ci, long cf)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	static short ihCodTipDireccion;
	static long  lCodCiclo  ;
	static long  lhClieIni  ;
	static long  lhClieFin  ;
	/* EXEC SQL END DECLARE SECTION  ; */ 


        lCodCiclo	= ciclo		;
        lhClieIni	= ci		;
        lhClieFin	= cf		;
	ihCodTipDireccion  = iTipDireccion;

        if (lhClieFin!=0)
        {
		/* EXEC SQL DECLARE CGeDireccionesR CURSOR FOR
	        SELECT /o + index (GA_DIRECCLI PK_GA_DIRECCLI) o/
	        DISTINCT 
	               B.COD_CLIENTE  ,
	               A.COD_REGION   ,
	               A.COD_PROVINCIA,
	               A.COD_CIUDAD   ,
	               A.COD_COMUNA   ,
	               A.NOM_CALLE    ,
	               A.NUM_CALLE    ,
	               A.NUM_PISO
	        FROM  GE_DIRECCIONES A, GA_DIRECCLI B, FA_CICLOCLI C 
	        WHERE B.COD_TIPDIRECCION = :ihCodTipDireccion
	        AND   B.COD_DIRECCION    = A.COD_DIRECCION
	        AND   C.COD_CLIENTE 	  = B.COD_CLIENTE 
		AND   C.num_proceso	  = 0 
		AND   C.ind_mascara	  = 1 
		AND   C.cod_ciclo 	  = :lCodCiclo 
		AND   C.COD_CLIENTE 	 >= :lhClieIni 
		AND   C.COD_CLIENTE 	 <= :lhClieFin; */ 


	        /* EXEC SQL OPEN CGeDireccionesR; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 22;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = sq0051;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1193;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqcmod = (unsigned int )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDireccion;
         sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&lCodCiclo;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&lhClieIni;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&lhClieFin;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
         sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL DECLARE CGeDirecciones CURSOR FOR
	        SELECT /o + index (GA_DIRECCLI PK_GA_DIRECCLI) o/
	        DISTINCT 
	               B.COD_CLIENTE  ,
	               A.COD_REGION   ,
	               A.COD_PROVINCIA,
	               A.COD_CIUDAD   ,
	               A.COD_COMUNA   ,
	               A.NOM_CALLE    ,
	               A.NUM_CALLE    ,
	               A.NUM_PISO
	        FROM   GE_DIRECCIONES A, GA_DIRECCLI B, FA_CICLOCLI C
	        WHERE  B.COD_CLIENTE = C.COD_CLIENTE 
	          AND  C.NUM_PROCESO=0 
	          AND  C.IND_MASCARA=1 
	          AND  C.COD_CICLO=:lCodCiclo
	          AND  B.COD_TIPDIRECCION = :ihCodTipDireccion
	          AND  B.COD_DIRECCION    = A.COD_DIRECCION; */ 


		/* EXEC SQL OPEN CGeDirecciones; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 22;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0052;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1224;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
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
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	return sqlca.sqlcode;

}

/******************************************************************************
Funcion		:     	ifnOraDeclararGeCoUnipac
*******************************************************************************/

int ifnOraDeclararGeCoUnipac (sql_context ctx,long ciclo, long ci, long cf)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	static long  lCodCiclo  ;
	static long  lhClieIni  ;
	static long  lhClieFin  ;
	/* EXEC SQL END DECLARE SECTION  ; */ 


	lCodCiclo	= ciclo		;
	lhClieIni	= ci		;
	lhClieFin	= cf		;
	
	if (lhClieFin!=0)
	{
		/* EXEC SQL DECLARE CGeCoUnipacR CURSOR FOR
		SELECT DISTINCT 
			PAC.COD_CLIENTE,
			PAC.COD_BANCO
          	FROM CO_UNIPAC PAC, FA_CICLOCLI CLI
         	WHERE PAC.COD_CLIENTE = CLI.COD_CLIENTE 
		   AND CLI.NUM_PROCESO = 0 
		   AND CLI.IND_MASCARA = 1 
		   AND CLI.COD_CICLO   = :lCodCiclo 
		   AND CLI.COD_CLIENTE>= :lhClieIni AND CLI.COD_CLIENTE<=:lhClieFin; */ 


         	/* EXEC SQL OPEN CGeCoUnipacR; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 22;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = sq0053;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1247;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqcmod = (unsigned int )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
          sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)&lhClieIni;
          sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)&lhClieFin;
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
          sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL DECLARE CGeCoUnipac CURSOR FOR
		SELECT DISTINCT 
			PAC.COD_CLIENTE,
			PAC.COD_BANCO
          	FROM CO_UNIPAC PAC,  FA_CICLOCLI CLI
         	WHERE PAC.COD_CLIENTE = CLI.COD_CLIENTE 
		   AND CLI.NUM_PROCESO = 0 
		   AND CLI.IND_MASCARA = 1 
		   AND CLI.COD_CICLO   = :lCodCiclo; */ 


         	/* EXEC SQL OPEN CGeCoUnipac; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 22;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = sq0054;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1274;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqcmod = (unsigned int )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclo;
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
          sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	return sqlca.sqlcode;

}

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion         :       ifnOraDeclararGeOficina
*******************************************************************************/

int ifnOraDeclararGeOficina (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeOficina CURSOR FOR
     /oinc 37160 PPV 27/01/2006 se cambia query a peticion de la operadorao/
     
     /o   SELECT /o+ FULL (GE_OFICINAS) 
	   	A.COD_OFICINA,
	   	B.COD_REGION,
	   	B.COD_PROVINCIA,
	   	B.COD_CIUDAD,
	   	C.COD_PLAZA
        FROM
        GE_OFICINAS    A,
        GE_DIRECCIONES B,
        GE_CIUDADES    C
             WHERE A.COD_DIRECCION  = B.COD_DIRECCION
               AND B.COD_REGION     = C.COD_REGION
               AND B.COD_PROVINCIA  = C.COD_PROVINCIA
               AND B.COD_CIUDAD     = C.COD_CIUDAD; o/
               
        SELECT /o + ORDERED o/
	   	A.COD_OFICINA,
	   	B.COD_REGION,
	   	B.COD_PROVINCIA,
	   	B.COD_CIUDAD,
	   	C.COD_PLAZA
        FROM
        GE_OFICINAS    A,
        GE_DIRECCIONES B,
        GE_CIUDADES    C
             WHERE A.COD_DIRECCION  = B.COD_DIRECCION
               AND B.COD_REGION     = C.COD_REGION
               AND B.COD_PROVINCIA  = C.COD_PROVINCIA
               AND B.COD_CIUDAD     = C.COD_CIUDAD; */ 
                

    	/* EXEC SQL OPEN CGeOficina; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 22;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0055;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1293;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}


/******************************************************************************
Funcion         :       ifnOraDeclararGeFactCobr
*******************************************************************************/

int ifnOraDeclararGeFactCobr (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL DECLARE CGeFactCobr CURSOR FOR

        SELECT
        	COD_CONCFACT, COD_CONCCOBR
        FROM
        FA_FACTCOBR; */ 


    	/* EXEC SQL OPEN CGeFactCobr; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 22;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0056;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1308;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}
/******************************************************************************
Funcion         :       ifnOraDeclararDetPlanDesc
*******************************************************************************/

int ifnOraDeclararDetPlanDesc (sql_context ctx, long plCodCiclfact)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char  szhFmtFecha    [17];/* EXEC SQL VAR szhFmtFecha IS STRING(17); */ 

    	long  lhCodCiclFact  = 0L;
	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy (szhFmtFecha, "yyyymmddhh24miss");
	lhCodCiclFact = plCodCiclfact;

	/* EXEC SQL DECLARE Cur_DetPlanDesc CURSOR FOR
		SELECT B.COD_PLANDESC	  ,
			   B.DES_PLANDESC     ,
			   TO_CHAR(B.FEC_DESDE,:szhFmtFecha),
			   TO_CHAR(B.FEC_HASTA,:szhFmtFecha),
			   B.IND_RESTRICCION  ,
			   TO_CHAR(C.FEC_DESDE,:szhFmtFecha),
			   TO_CHAR(C.FEC_HASTA,:szhFmtFecha),
			   C.COD_TIPEVAL      ,
			   C.COD_TIPAPLI      ,
			   C.COD_GRUPOEVAL    ,
			   C.COD_GRUPOAPLI    ,
			   C.NUM_CUADRANTE    ,
			   C.TIP_UNIDAD       ,
			   C.COD_CONCDESC     ,
			   C.MTO_MINFACT
		  FROM FAD_PLANDESC B,  FAD_DETPLANDESC C, FA_CICLFACT A
		 WHERE B.COD_PLANDESC = C.COD_PLANDESC
		   AND A.COD_CICLFACT = :lhCodCiclFact
		   AND A.FEC_EMISION BETWEEN C.FEC_DESDE AND C.FEC_HASTA; */ 


    	/* EXEC SQL OPEN Cur_DetPlanDesc; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 22;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0057;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1323;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[0] = (unsigned long )17;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[1] = (unsigned long )17;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[2] = (unsigned long )17;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[3] = (unsigned long )17;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCiclFact;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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
     sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion		:     	vfnImpErrorORACLE
*******************************************************************************/

void vfnImpErrorORACLE(sql_context ctx)
{

  	fprintf(stderr,"\n\t%s\n", sqlca.sqlerrm.sqlerrmc);
}

/******************************************************************************
Funcion		:     	ifnOraLeerFacClientes
*******************************************************************************/

int ifnOraLeerFacClientes(FAC_CLIENTES_HOST *pstHost,long *plNumFilas,
        		  sql_context ctx,long clieini,long cliefin,FAC_CLIENTES_HOST_NULL *pstHostNull)
{
        struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


        /* EXEC SQL VAR pstHost->szNomCliente 	IS STRING (51); */ 

        /* EXEC SQL VAR pstHost->szNomApeClien1 	IS STRING (21); */ 

        /* EXEC SQL VAR pstHost->szNomApeClien2 	IS STRING (21); */ 

        /* EXEC SQL VAR pstHost->szTefCliente1 	IS STRING (16); */ 

        /* EXEC SQL VAR pstHost->szTefCliente2 	IS STRING (16); */ 

        /* EXEC SQL VAR pstHost->szCodPais 	IS STRING (4); */ 

        /* EXEC SQL VAR pstHost->szIndDebito 	IS STRING (2); */ 

        /* EXEC SQL VAR pstHost->szCodBanco 	IS STRING (16); */ 

        /* EXEC SQL VAR pstHost->szCodSucursal 	IS STRING (5); */ 

        /* EXEC SQL VAR pstHost->szIndTipCuenta 	IS STRING (2); */ 

        /* EXEC SQL VAR pstHost->szCodTipTarjeta 	IS STRING (4); */ 

        /* EXEC SQL VAR pstHost->szNumCtaCorr 	IS STRING (19); */ 

        /* EXEC SQL VAR pstHost->szNumTarjeta 	IS STRING (19); */ 

        /* EXEC SQL VAR pstHost->szFecVenciTarj 	IS STRING (15); */ 

        /* EXEC SQL VAR pstHost->szCodBancoTarj 	IS STRING (16); */ 

        /* EXEC SQL VAR pstHost->szCodTipIdTrib 	IS STRING (3); */ 

        /* EXEC SQL VAR pstHost->szNumIdentTrib 	IS STRING (21); */ 

        /* EXEC SQL VAR pstHost->szCodOficina 	IS STRING (3); */ 

        /* EXEC SQL VAR pstHost->szNumFax 		IS STRING (16); */ 

        /* EXEC SQL VAR pstHost->szFecAlta 	IS STRING (15); */ 

        /* EXEC SQL VAR pstHost->szCodIdioma 	IS STRING (6); */ 

        /* EXEC SQL VAR pstHost->szCodOperadora 	IS STRING (6); */ 

        /* EXEC SQL VAR pstHost->szCodSegmentacion IS STRING (6); */ 

        /* EXEC SQL VAR pstHost->szCodDespacho 	IS STRING (6); */ 

        /* EXEC SQL VAR pstHost->szNomEmail        IS STRING (71); */ 

        /* EXEC SQL VAR pstHost->szCodIdTipDian    IS STRING (3); */ 


	if(cliefin!=0)
	{
		/* EXEC SQL FETCH CFacClientesR
	 	       	INTO
				:pstHost->lRowNum					,
		                :pstHost->lCodCliente					,
		                :pstHost->szNomCliente       				,
		                :pstHost->szNomApeClien1:pstHostNull->sszNomApeClien1   ,
		                :pstHost->szNomApeClien2:pstHostNull->sszNomApeClien2   ,
		                :pstHost->szTefCliente1:pstHostNull->sszTefCliente1     ,
		                :pstHost->szTefCliente2:pstHostNull->sszTefCliente2     ,
		                :pstHost->szCodPais:pstHostNull->sszCodPais             ,
		                :pstHost->szIndDebito:pstHostNull->sszIndDebito         ,
		                :pstHost->dImpStopDebit:pstHostNull->sdImpStopDebit     ,
		                :pstHost->szCodBanco:pstHostNull->sszCodBanco           ,
		                :pstHost->szCodSucursal:pstHostNull->sszCodSucursal     ,
		                :pstHost->szIndTipCuenta:pstHostNull->sszIndTipCuenta   ,
		                :pstHost->szCodTipTarjeta:pstHostNull->sszCodTipTarjeta ,
		                :pstHost->szNumCtaCorr:pstHostNull->sszNumCtaCorr       ,
		                :pstHost->szNumTarjeta:pstHostNull->sszNumTarjeta       ,
		                :pstHost->szFecVenciTarj:pstHostNull->sszFecVenciTarj   ,
		                :pstHost->szCodBancoTarj:pstHostNull->sszCodBancoTarj   ,
		                :pstHost->szCodTipIdTrib:pstHostNull->sszCodTipIdTrib   ,
		                :pstHost->szNumIdentTrib:pstHostNull->sszNumIdentTrib   ,
		                :pstHost->iCodActividad:pstHostNull->siCodActividad     ,
		                :pstHost->szCodOficina:pstHostNull->sszCodOficina       ,
		                :pstHost->iIndFactur                         		,
		                :pstHost->szNumFax:pstHostNull->sszNumFax               ,
		                :pstHost->szFecAlta                          		,
		                :pstHost->lCodCuenta                         		,
		                :pstHost->szCodIdioma                        		,
		                :pstHost->szCodOperadora:pstHostNull->sszCodOperadora   ,
		                :pstHost->szCodDespacho:pstHostNull->sszCodDespacho     ,
		                :pstHost->szNomEmail:pstHostNull->sszNomEmail           ,
		                :pstHost->szCodIdTipDian                                ,
		                :pstHost->iIndClieLoc                                   ,
		                :pstHost->szCodSegmentacion; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )1358;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lRowNum);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szNomCliente);
  sqlstm.sqhstl[2] = (unsigned long )51;
  sqlstm.sqhsts[2] = (         int  )51;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szNomApeClien1);
  sqlstm.sqhstl[3] = (unsigned long )21;
  sqlstm.sqhsts[3] = (         int  )21;
  sqlstm.sqindv[3] = (         short *)(pstHostNull->sszNomApeClien1);
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szNomApeClien2);
  sqlstm.sqhstl[4] = (unsigned long )21;
  sqlstm.sqhsts[4] = (         int  )21;
  sqlstm.sqindv[4] = (         short *)(pstHostNull->sszNomApeClien2);
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szTefCliente1);
  sqlstm.sqhstl[5] = (unsigned long )16;
  sqlstm.sqhsts[5] = (         int  )16;
  sqlstm.sqindv[5] = (         short *)(pstHostNull->sszTefCliente1);
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szTefCliente2);
  sqlstm.sqhstl[6] = (unsigned long )16;
  sqlstm.sqhsts[6] = (         int  )16;
  sqlstm.sqindv[6] = (         short *)(pstHostNull->sszTefCliente2);
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szCodPais);
  sqlstm.sqhstl[7] = (unsigned long )4;
  sqlstm.sqhsts[7] = (         int  )4;
  sqlstm.sqindv[7] = (         short *)(pstHostNull->sszCodPais);
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->szIndDebito);
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )2;
  sqlstm.sqindv[8] = (         short *)(pstHostNull->sszIndDebito);
  sqlstm.sqinds[8] = (         int  )sizeof(short);
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->dImpStopDebit);
  sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[9] = (         int  )sizeof(double);
  sqlstm.sqindv[9] = (         short *)(pstHostNull->sdImpStopDebit);
  sqlstm.sqinds[9] = (         int  )sizeof(short);
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szCodBanco);
  sqlstm.sqhstl[10] = (unsigned long )16;
  sqlstm.sqhsts[10] = (         int  )16;
  sqlstm.sqindv[10] = (         short *)(pstHostNull->sszCodBanco);
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->szCodSucursal);
  sqlstm.sqhstl[11] = (unsigned long )5;
  sqlstm.sqhsts[11] = (         int  )5;
  sqlstm.sqindv[11] = (         short *)(pstHostNull->sszCodSucursal);
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->szIndTipCuenta);
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )2;
  sqlstm.sqindv[12] = (         short *)(pstHostNull->sszIndTipCuenta);
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->szCodTipTarjeta);
  sqlstm.sqhstl[13] = (unsigned long )4;
  sqlstm.sqhsts[13] = (         int  )4;
  sqlstm.sqindv[13] = (         short *)(pstHostNull->sszCodTipTarjeta);
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->szNumCtaCorr);
  sqlstm.sqhstl[14] = (unsigned long )19;
  sqlstm.sqhsts[14] = (         int  )19;
  sqlstm.sqindv[14] = (         short *)(pstHostNull->sszNumCtaCorr);
  sqlstm.sqinds[14] = (         int  )sizeof(short);
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)(pstHost->szNumTarjeta);
  sqlstm.sqhstl[15] = (unsigned long )19;
  sqlstm.sqhsts[15] = (         int  )19;
  sqlstm.sqindv[15] = (         short *)(pstHostNull->sszNumTarjeta);
  sqlstm.sqinds[15] = (         int  )sizeof(short);
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)(pstHost->szFecVenciTarj);
  sqlstm.sqhstl[16] = (unsigned long )15;
  sqlstm.sqhsts[16] = (         int  )15;
  sqlstm.sqindv[16] = (         short *)(pstHostNull->sszFecVenciTarj);
  sqlstm.sqinds[16] = (         int  )sizeof(short);
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)(pstHost->szCodBancoTarj);
  sqlstm.sqhstl[17] = (unsigned long )16;
  sqlstm.sqhsts[17] = (         int  )16;
  sqlstm.sqindv[17] = (         short *)(pstHostNull->sszCodBancoTarj);
  sqlstm.sqinds[17] = (         int  )sizeof(short);
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)(pstHost->szCodTipIdTrib);
  sqlstm.sqhstl[18] = (unsigned long )3;
  sqlstm.sqhsts[18] = (         int  )3;
  sqlstm.sqindv[18] = (         short *)(pstHostNull->sszCodTipIdTrib);
  sqlstm.sqinds[18] = (         int  )sizeof(short);
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)(pstHost->szNumIdentTrib);
  sqlstm.sqhstl[19] = (unsigned long )21;
  sqlstm.sqhsts[19] = (         int  )21;
  sqlstm.sqindv[19] = (         short *)(pstHostNull->sszNumIdentTrib);
  sqlstm.sqinds[19] = (         int  )sizeof(short);
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)(pstHost->iCodActividad);
  sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[20] = (         int  )sizeof(int);
  sqlstm.sqindv[20] = (         short *)(pstHostNull->siCodActividad);
  sqlstm.sqinds[20] = (         int  )sizeof(short);
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)(pstHost->szCodOficina);
  sqlstm.sqhstl[21] = (unsigned long )3;
  sqlstm.sqhsts[21] = (         int  )3;
  sqlstm.sqindv[21] = (         short *)(pstHostNull->sszCodOficina);
  sqlstm.sqinds[21] = (         int  )sizeof(short);
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)(pstHost->iIndFactur);
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )sizeof(int);
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)(pstHost->szNumFax);
  sqlstm.sqhstl[23] = (unsigned long )16;
  sqlstm.sqhsts[23] = (         int  )16;
  sqlstm.sqindv[23] = (         short *)(pstHostNull->sszNumFax);
  sqlstm.sqinds[23] = (         int  )sizeof(short);
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)(pstHost->szFecAlta);
  sqlstm.sqhstl[24] = (unsigned long )15;
  sqlstm.sqhsts[24] = (         int  )15;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqharc[24] = (unsigned long  *)0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)(pstHost->lCodCuenta);
  sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[25] = (         int  )sizeof(long);
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqharc[25] = (unsigned long  *)0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)(pstHost->szCodIdioma);
  sqlstm.sqhstl[26] = (unsigned long )6;
  sqlstm.sqhsts[26] = (         int  )6;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqharc[26] = (unsigned long  *)0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)(pstHost->szCodOperadora);
  sqlstm.sqhstl[27] = (unsigned long )6;
  sqlstm.sqhsts[27] = (         int  )6;
  sqlstm.sqindv[27] = (         short *)(pstHostNull->sszCodOperadora);
  sqlstm.sqinds[27] = (         int  )sizeof(short);
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqharc[27] = (unsigned long  *)0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)(pstHost->szCodDespacho);
  sqlstm.sqhstl[28] = (unsigned long )6;
  sqlstm.sqhsts[28] = (         int  )6;
  sqlstm.sqindv[28] = (         short *)(pstHostNull->sszCodDespacho);
  sqlstm.sqinds[28] = (         int  )sizeof(short);
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqharc[28] = (unsigned long  *)0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)(pstHost->szNomEmail);
  sqlstm.sqhstl[29] = (unsigned long )71;
  sqlstm.sqhsts[29] = (         int  )71;
  sqlstm.sqindv[29] = (         short *)(pstHostNull->sszNomEmail);
  sqlstm.sqinds[29] = (         int  )sizeof(short);
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqharc[29] = (unsigned long  *)0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
  sqlstm.sqhstv[30] = (unsigned char  *)(pstHost->szCodIdTipDian);
  sqlstm.sqhstl[30] = (unsigned long )3;
  sqlstm.sqhsts[30] = (         int  )3;
  sqlstm.sqindv[30] = (         short *)0;
  sqlstm.sqinds[30] = (         int  )0;
  sqlstm.sqharm[30] = (unsigned long )0;
  sqlstm.sqharc[30] = (unsigned long  *)0;
  sqlstm.sqadto[30] = (unsigned short )0;
  sqlstm.sqtdso[30] = (unsigned short )0;
  sqlstm.sqhstv[31] = (unsigned char  *)(pstHost->iIndClieLoc);
  sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[31] = (         int  )sizeof(int);
  sqlstm.sqindv[31] = (         short *)0;
  sqlstm.sqinds[31] = (         int  )0;
  sqlstm.sqharm[31] = (unsigned long )0;
  sqlstm.sqharc[31] = (unsigned long  *)0;
  sqlstm.sqadto[31] = (unsigned short )0;
  sqlstm.sqtdso[31] = (unsigned short )0;
  sqlstm.sqhstv[32] = (unsigned char  *)(pstHost->szCodSegmentacion);
  sqlstm.sqhstl[32] = (unsigned long )6;
  sqlstm.sqhsts[32] = (         int  )6;
  sqlstm.sqindv[32] = (         short *)0;
  sqlstm.sqinds[32] = (         int  )0;
  sqlstm.sqharm[32] = (unsigned long )0;
  sqlstm.sqharc[32] = (unsigned long  *)0;
  sqlstm.sqadto[32] = (unsigned short )0;
  sqlstm.sqtdso[32] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	}
	else
	{
		/* EXEC SQL FETCH CFacClientes
	 	       	INTO
				:pstHost->lRowNum					,
		                :pstHost->lCodCliente					,
		                :pstHost->szNomCliente       				,
		                :pstHost->szNomApeClien1:pstHostNull->sszNomApeClien1   ,
		                :pstHost->szNomApeClien2:pstHostNull->sszNomApeClien2   ,
		                :pstHost->szTefCliente1:pstHostNull->sszTefCliente1     ,
		                :pstHost->szTefCliente2:pstHostNull->sszTefCliente2     ,
		                :pstHost->szCodPais:pstHostNull->sszCodPais             ,
		                :pstHost->szIndDebito:pstHostNull->sszIndDebito         ,
		                :pstHost->dImpStopDebit:pstHostNull->sdImpStopDebit     ,
		                :pstHost->szCodBanco:pstHostNull->sszCodBanco           ,
		                :pstHost->szCodSucursal:pstHostNull->sszCodSucursal     ,
		                :pstHost->szIndTipCuenta:pstHostNull->sszIndTipCuenta   ,
		                :pstHost->szCodTipTarjeta:pstHostNull->sszCodTipTarjeta ,
		                :pstHost->szNumCtaCorr:pstHostNull->sszNumCtaCorr       ,
		                :pstHost->szNumTarjeta:pstHostNull->sszNumTarjeta       ,
		                :pstHost->szFecVenciTarj:pstHostNull->sszFecVenciTarj   ,
		                :pstHost->szCodBancoTarj:pstHostNull->sszCodBancoTarj   ,
		                :pstHost->szCodTipIdTrib:pstHostNull->sszCodTipIdTrib   ,
		                :pstHost->szNumIdentTrib:pstHostNull->sszNumIdentTrib   ,
		                :pstHost->iCodActividad:pstHostNull->siCodActividad     ,
		                :pstHost->szCodOficina:pstHostNull->sszCodOficina       ,
		                :pstHost->iIndFactur                         		,
		                :pstHost->szNumFax:pstHostNull->sszNumFax               ,
		                :pstHost->szFecAlta                          		,
		                :pstHost->lCodCuenta                         		,
		                :pstHost->szCodIdioma                        		,
		                :pstHost->szCodOperadora:pstHostNull->sszCodOperadora   ,
		                :pstHost->szCodDespacho:pstHostNull->sszCodDespacho     ,
		                :pstHost->szNomEmail:pstHostNull->sszNomEmail           ,
		                :pstHost->szCodIdTipDian                                ,
		                :pstHost->iIndClieLoc                                   ,		                
		                :pstHost->szCodSegmentacion; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )1505;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lRowNum);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szNomCliente);
  sqlstm.sqhstl[2] = (unsigned long )51;
  sqlstm.sqhsts[2] = (         int  )51;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szNomApeClien1);
  sqlstm.sqhstl[3] = (unsigned long )21;
  sqlstm.sqhsts[3] = (         int  )21;
  sqlstm.sqindv[3] = (         short *)(pstHostNull->sszNomApeClien1);
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szNomApeClien2);
  sqlstm.sqhstl[4] = (unsigned long )21;
  sqlstm.sqhsts[4] = (         int  )21;
  sqlstm.sqindv[4] = (         short *)(pstHostNull->sszNomApeClien2);
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szTefCliente1);
  sqlstm.sqhstl[5] = (unsigned long )16;
  sqlstm.sqhsts[5] = (         int  )16;
  sqlstm.sqindv[5] = (         short *)(pstHostNull->sszTefCliente1);
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szTefCliente2);
  sqlstm.sqhstl[6] = (unsigned long )16;
  sqlstm.sqhsts[6] = (         int  )16;
  sqlstm.sqindv[6] = (         short *)(pstHostNull->sszTefCliente2);
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szCodPais);
  sqlstm.sqhstl[7] = (unsigned long )4;
  sqlstm.sqhsts[7] = (         int  )4;
  sqlstm.sqindv[7] = (         short *)(pstHostNull->sszCodPais);
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->szIndDebito);
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )2;
  sqlstm.sqindv[8] = (         short *)(pstHostNull->sszIndDebito);
  sqlstm.sqinds[8] = (         int  )sizeof(short);
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->dImpStopDebit);
  sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[9] = (         int  )sizeof(double);
  sqlstm.sqindv[9] = (         short *)(pstHostNull->sdImpStopDebit);
  sqlstm.sqinds[9] = (         int  )sizeof(short);
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szCodBanco);
  sqlstm.sqhstl[10] = (unsigned long )16;
  sqlstm.sqhsts[10] = (         int  )16;
  sqlstm.sqindv[10] = (         short *)(pstHostNull->sszCodBanco);
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->szCodSucursal);
  sqlstm.sqhstl[11] = (unsigned long )5;
  sqlstm.sqhsts[11] = (         int  )5;
  sqlstm.sqindv[11] = (         short *)(pstHostNull->sszCodSucursal);
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->szIndTipCuenta);
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )2;
  sqlstm.sqindv[12] = (         short *)(pstHostNull->sszIndTipCuenta);
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->szCodTipTarjeta);
  sqlstm.sqhstl[13] = (unsigned long )4;
  sqlstm.sqhsts[13] = (         int  )4;
  sqlstm.sqindv[13] = (         short *)(pstHostNull->sszCodTipTarjeta);
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->szNumCtaCorr);
  sqlstm.sqhstl[14] = (unsigned long )19;
  sqlstm.sqhsts[14] = (         int  )19;
  sqlstm.sqindv[14] = (         short *)(pstHostNull->sszNumCtaCorr);
  sqlstm.sqinds[14] = (         int  )sizeof(short);
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)(pstHost->szNumTarjeta);
  sqlstm.sqhstl[15] = (unsigned long )19;
  sqlstm.sqhsts[15] = (         int  )19;
  sqlstm.sqindv[15] = (         short *)(pstHostNull->sszNumTarjeta);
  sqlstm.sqinds[15] = (         int  )sizeof(short);
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)(pstHost->szFecVenciTarj);
  sqlstm.sqhstl[16] = (unsigned long )15;
  sqlstm.sqhsts[16] = (         int  )15;
  sqlstm.sqindv[16] = (         short *)(pstHostNull->sszFecVenciTarj);
  sqlstm.sqinds[16] = (         int  )sizeof(short);
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)(pstHost->szCodBancoTarj);
  sqlstm.sqhstl[17] = (unsigned long )16;
  sqlstm.sqhsts[17] = (         int  )16;
  sqlstm.sqindv[17] = (         short *)(pstHostNull->sszCodBancoTarj);
  sqlstm.sqinds[17] = (         int  )sizeof(short);
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)(pstHost->szCodTipIdTrib);
  sqlstm.sqhstl[18] = (unsigned long )3;
  sqlstm.sqhsts[18] = (         int  )3;
  sqlstm.sqindv[18] = (         short *)(pstHostNull->sszCodTipIdTrib);
  sqlstm.sqinds[18] = (         int  )sizeof(short);
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)(pstHost->szNumIdentTrib);
  sqlstm.sqhstl[19] = (unsigned long )21;
  sqlstm.sqhsts[19] = (         int  )21;
  sqlstm.sqindv[19] = (         short *)(pstHostNull->sszNumIdentTrib);
  sqlstm.sqinds[19] = (         int  )sizeof(short);
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)(pstHost->iCodActividad);
  sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[20] = (         int  )sizeof(int);
  sqlstm.sqindv[20] = (         short *)(pstHostNull->siCodActividad);
  sqlstm.sqinds[20] = (         int  )sizeof(short);
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)(pstHost->szCodOficina);
  sqlstm.sqhstl[21] = (unsigned long )3;
  sqlstm.sqhsts[21] = (         int  )3;
  sqlstm.sqindv[21] = (         short *)(pstHostNull->sszCodOficina);
  sqlstm.sqinds[21] = (         int  )sizeof(short);
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)(pstHost->iIndFactur);
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )sizeof(int);
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)(pstHost->szNumFax);
  sqlstm.sqhstl[23] = (unsigned long )16;
  sqlstm.sqhsts[23] = (         int  )16;
  sqlstm.sqindv[23] = (         short *)(pstHostNull->sszNumFax);
  sqlstm.sqinds[23] = (         int  )sizeof(short);
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)(pstHost->szFecAlta);
  sqlstm.sqhstl[24] = (unsigned long )15;
  sqlstm.sqhsts[24] = (         int  )15;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqharc[24] = (unsigned long  *)0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)(pstHost->lCodCuenta);
  sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[25] = (         int  )sizeof(long);
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqharc[25] = (unsigned long  *)0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)(pstHost->szCodIdioma);
  sqlstm.sqhstl[26] = (unsigned long )6;
  sqlstm.sqhsts[26] = (         int  )6;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqharc[26] = (unsigned long  *)0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)(pstHost->szCodOperadora);
  sqlstm.sqhstl[27] = (unsigned long )6;
  sqlstm.sqhsts[27] = (         int  )6;
  sqlstm.sqindv[27] = (         short *)(pstHostNull->sszCodOperadora);
  sqlstm.sqinds[27] = (         int  )sizeof(short);
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqharc[27] = (unsigned long  *)0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)(pstHost->szCodDespacho);
  sqlstm.sqhstl[28] = (unsigned long )6;
  sqlstm.sqhsts[28] = (         int  )6;
  sqlstm.sqindv[28] = (         short *)(pstHostNull->sszCodDespacho);
  sqlstm.sqinds[28] = (         int  )sizeof(short);
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqharc[28] = (unsigned long  *)0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)(pstHost->szNomEmail);
  sqlstm.sqhstl[29] = (unsigned long )71;
  sqlstm.sqhsts[29] = (         int  )71;
  sqlstm.sqindv[29] = (         short *)(pstHostNull->sszNomEmail);
  sqlstm.sqinds[29] = (         int  )sizeof(short);
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqharc[29] = (unsigned long  *)0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
  sqlstm.sqhstv[30] = (unsigned char  *)(pstHost->szCodIdTipDian);
  sqlstm.sqhstl[30] = (unsigned long )3;
  sqlstm.sqhsts[30] = (         int  )3;
  sqlstm.sqindv[30] = (         short *)0;
  sqlstm.sqinds[30] = (         int  )0;
  sqlstm.sqharm[30] = (unsigned long )0;
  sqlstm.sqharc[30] = (unsigned long  *)0;
  sqlstm.sqadto[30] = (unsigned short )0;
  sqlstm.sqtdso[30] = (unsigned short )0;
  sqlstm.sqhstv[31] = (unsigned char  *)(pstHost->iIndClieLoc);
  sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[31] = (         int  )sizeof(int);
  sqlstm.sqindv[31] = (         short *)0;
  sqlstm.sqinds[31] = (         int  )0;
  sqlstm.sqharm[31] = (unsigned long )0;
  sqlstm.sqharc[31] = (unsigned long  *)0;
  sqlstm.sqadto[31] = (unsigned short )0;
  sqlstm.sqtdso[31] = (unsigned short )0;
  sqlstm.sqhstv[32] = (unsigned char  *)(pstHost->szCodSegmentacion);
  sqlstm.sqhstl[32] = (unsigned long )6;
  sqlstm.sqhsts[32] = (         int  )6;
  sqlstm.sqindv[32] = (         short *)0;
  sqlstm.sqinds[32] = (         int  )0;
  sqlstm.sqharm[32] = (unsigned long )0;
  sqlstm.sqharc[32] = (unsigned long  *)0;
  sqlstm.sqadto[32] = (unsigned short )0;
  sqlstm.sqtdso[32] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

	if (sqlca.sqlcode==SQL_OK)
                *plNumFilas = TAM_HOST;
        else
                if (sqlca.sqlcode==NOT_FOUND)
                        *plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

        return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerFacCiclo
*******************************************************************************/

int ifnOraLeerFacCiclo(CICLOCLI_HOST *pstHostCiclo,CICLOCLI_HOST_NULL *pstHostCicloNull,
        	       long *plNumFilasCiclo,sql_context ctx,long clieini,long cliefin)
{
        struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


        /* EXEC SQL VAR pstHostCiclo->szRowid IS STRING(19); */ 

        /* EXEC SQL VAR pstHostCiclo->szCodCalClien IS STRING(3); */ 

        /* EXEC SQL VAR pstHostCiclo->szNomUsuario IS STRING(21); */ 

        /* EXEC SQL VAR pstHostCiclo->szNomApellido1 IS STRING(21); */ 

        /* EXEC SQL VAR pstHostCiclo->szNomApellido2 IS STRING(21); */ 

        /* EXEC SQL VAR pstHostCiclo->szIndDebito IS STRING(2); */ 

        /* EXEC SQL VAR pstHostCiclo->szFecAlta IS STRING(15); */ 

        /* EXEC SQL VAR pstHostCiclo->szFecUltFact IS STRING(15); */ 


	if(cliefin!=0)
	{
		/* EXEC SQL FETCH CFacCicloR
			INTO
		        	:pstHostCiclo->szRowid,
		                :pstHostCiclo->lCodCliente,
				:pstHostCiclo->iCodProducto,
		    		:pstHostCiclo->lNumAbonado,
				:pstHostCiclo->szCodCalClien,
				:pstHostCiclo->iIndCambio,
				:pstHostCiclo->szNomUsuario,
				:pstHostCiclo->szNomApellido1,
				:pstHostCiclo->szNomApellido2:pstHostCicloNull->sszNomApellido2,
				:pstHostCiclo->iCodCredMor:pstHostCicloNull->siCodCredMor,
				:pstHostCiclo->szIndDebito:pstHostCicloNull->sszIndDebito,
				:pstHostCiclo->iCodCicloNue:pstHostCicloNull->siCodCicloNue,
				:pstHostCiclo->szFecAlta,
				:pstHostCiclo->szFecUltFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )1652;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHostCiclo->szRowid);
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )19;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHostCiclo->lCodCliente);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHostCiclo->iCodProducto);
  sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[2] = (         int  )sizeof(short);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHostCiclo->lNumAbonado);
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHostCiclo->szCodCalClien);
  sqlstm.sqhstl[4] = (unsigned long )3;
  sqlstm.sqhsts[4] = (         int  )3;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHostCiclo->iIndCambio);
  sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[5] = (         int  )sizeof(short);
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHostCiclo->szNomUsuario);
  sqlstm.sqhstl[6] = (unsigned long )21;
  sqlstm.sqhsts[6] = (         int  )21;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHostCiclo->szNomApellido1);
  sqlstm.sqhstl[7] = (unsigned long )21;
  sqlstm.sqhsts[7] = (         int  )21;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(pstHostCiclo->szNomApellido2);
  sqlstm.sqhstl[8] = (unsigned long )21;
  sqlstm.sqhsts[8] = (         int  )21;
  sqlstm.sqindv[8] = (         short *)(pstHostCicloNull->sszNomApellido2);
  sqlstm.sqinds[8] = (         int  )sizeof(short);
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(pstHostCiclo->iCodCredMor);
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[9] = (         int  )sizeof(int);
  sqlstm.sqindv[9] = (         short *)(pstHostCicloNull->siCodCredMor);
  sqlstm.sqinds[9] = (         int  )sizeof(short);
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)(pstHostCiclo->szIndDebito);
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )2;
  sqlstm.sqindv[10] = (         short *)(pstHostCicloNull->sszIndDebito);
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)(pstHostCiclo->iCodCicloNue);
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )sizeof(int);
  sqlstm.sqindv[11] = (         short *)(pstHostCicloNull->siCodCicloNue);
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)(pstHostCiclo->szFecAlta);
  sqlstm.sqhstl[12] = (unsigned long )15;
  sqlstm.sqhsts[12] = (         int  )15;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)(pstHostCiclo->szFecUltFact);
  sqlstm.sqhstl[13] = (unsigned long )15;
  sqlstm.sqhsts[13] = (         int  )15;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL FETCH CFacCiclo
			INTO
		        	:pstHostCiclo->szRowid,
		                :pstHostCiclo->lCodCliente,
				:pstHostCiclo->iCodProducto,
		    		:pstHostCiclo->lNumAbonado,
				:pstHostCiclo->szCodCalClien,
				:pstHostCiclo->iIndCambio,
				:pstHostCiclo->szNomUsuario,
				:pstHostCiclo->szNomApellido1,
				:pstHostCiclo->szNomApellido2:pstHostCicloNull->sszNomApellido2,
				:pstHostCiclo->iCodCredMor:pstHostCicloNull->siCodCredMor,
				:pstHostCiclo->szIndDebito:pstHostCicloNull->sszIndDebito,
				:pstHostCiclo->iCodCicloNue:pstHostCicloNull->siCodCicloNue,
				:pstHostCiclo->szFecAlta,
				:pstHostCiclo->szFecUltFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )1723;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHostCiclo->szRowid);
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )19;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHostCiclo->lCodCliente);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHostCiclo->iCodProducto);
  sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[2] = (         int  )sizeof(short);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHostCiclo->lNumAbonado);
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHostCiclo->szCodCalClien);
  sqlstm.sqhstl[4] = (unsigned long )3;
  sqlstm.sqhsts[4] = (         int  )3;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHostCiclo->iIndCambio);
  sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[5] = (         int  )sizeof(short);
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHostCiclo->szNomUsuario);
  sqlstm.sqhstl[6] = (unsigned long )21;
  sqlstm.sqhsts[6] = (         int  )21;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHostCiclo->szNomApellido1);
  sqlstm.sqhstl[7] = (unsigned long )21;
  sqlstm.sqhsts[7] = (         int  )21;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(pstHostCiclo->szNomApellido2);
  sqlstm.sqhstl[8] = (unsigned long )21;
  sqlstm.sqhsts[8] = (         int  )21;
  sqlstm.sqindv[8] = (         short *)(pstHostCicloNull->sszNomApellido2);
  sqlstm.sqinds[8] = (         int  )sizeof(short);
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(pstHostCiclo->iCodCredMor);
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[9] = (         int  )sizeof(int);
  sqlstm.sqindv[9] = (         short *)(pstHostCicloNull->siCodCredMor);
  sqlstm.sqinds[9] = (         int  )sizeof(short);
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)(pstHostCiclo->szIndDebito);
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )2;
  sqlstm.sqindv[10] = (         short *)(pstHostCicloNull->sszIndDebito);
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)(pstHostCiclo->iCodCicloNue);
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )sizeof(int);
  sqlstm.sqindv[11] = (         short *)(pstHostCicloNull->siCodCicloNue);
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)(pstHostCiclo->szFecAlta);
  sqlstm.sqhstl[12] = (unsigned long )15;
  sqlstm.sqhsts[12] = (         int  )15;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)(pstHostCiclo->szFecUltFact);
  sqlstm.sqhstl[13] = (unsigned long )15;
  sqlstm.sqhsts[13] = (         int  )15;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

        if (sqlca.sqlcode==SQL_OK)
                *plNumFilasCiclo = TAM_HOST;
        else
                if (sqlca.sqlcode==NOT_FOUND)
                        *plNumFilasCiclo = sqlca.sqlerrd[2] % TAM_HOST;

        return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCargos
*******************************************************************************/

int  ifnOraLeerGeCargos(CARGOS_HOST *pstHost,CARGOS_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx,long ci, long cf)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szRowid 		IS STRING(19); */ 

	/* EXEC SQL VAR pstHost->szDesConcepto 	IS STRING(61); */ 

	/* EXEC SQL VAR pstHost->szFecAlta 	IS STRING(15); */ 

	/* EXEC SQL VAR pstHost->szCodMoneda 	IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szNumTerminal  IS STRING(16); */ 

	/* EXEC SQL VAR pstHost->szNumSerie     IS STRING(26); */ 

	/* EXEC SQL VAR pstHost->szNumSerieMec  IS STRING(26); */ 

	/* EXEC SQL VAR pstHost->szNumPreGuia   IS STRING(11); */ 

	/* EXEC SQL VAR pstHost->szNumGuia      IS STRING(11); */ 

	/* EXEC SQL VAR pstHost->szCodRegion 	IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodProvincia 	IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodCiudad 	IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodCuota 	IS STRING(3); */ 

	/* EXEC SQL VAR pstHost->szCodModulo 	IS STRING(3); */ 


	if(cf!=0)
	{
		/* EXEC SQL FETCH CGeCargosR
			INTO
			:pstHost->szRowid                      ,
			:pstHost->lNumCargo                    ,
			:pstHost->lCodCliente                  ,
			:pstHost->iCodProducto                 ,
			:pstHost->iCodConcepto                 ,
			:pstHost->szFecAlta                    ,
			:pstHost->dImpCargo                    ,
			:pstHost->szCodMoneda                  ,
			:pstHost->lCodPlanCom                  ,
			:pstHost->lNumUnidades                 ,
			:pstHost->lNumAbonado:pstHostNull->slNumAbonado	,
			:pstHost->szNumTerminal:pstHostNull->sszNumTerminal	,
			:pstHost->lCodCiclFact:pstHostNull->slCodCiclFact    ,
			:pstHost->szNumSerie:pstHostNull->sszNumSerie	,
			:pstHost->szNumSerieMec:pstHostNull->sszNumSerieMec ,
			:pstHost->lCapCode:pstHostNull->slCapCode          	,
			:pstHost->iMesGarantia:pstHostNull->siMesGarantia		,
			:pstHost->szNumPreGuia:pstHostNull->sszNumPreGuia		,
			:pstHost->szNumGuia:pstHostNull->sszNumGuia        		,
			:pstHost->lNumTransaccion:pstHostNull->slNumTransaccion		,
			:pstHost->lNumVenta:pstHostNull->slNumTransaccion            	,
			:pstHost->lNumFactura:pstHostNull->slNumTransaccion       		,
			:pstHost->iCodConceptoDto:pstHostNull->siCodConceptoDto	,
			:pstHost->dValDto:pstHostNull->sdValDto             	,
			:pstHost->iTipDto:pstHostNull->siTipDto               	,
			:pstHost->iIndCuota:pstHostNull->siIndCuota            	,
			:pstHost->iNumPaquete:pstHostNull->siNumPaquete     		,
			:pstHost->iIndFactur                   ,
			:pstHost->iIndSuperTel:pstHostNull->siIndSuperTel		; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )1794;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )19;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lNumCargo);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodProducto);
  sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[3] = (         int  )sizeof(short);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iCodConcepto);
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )sizeof(int);
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szFecAlta);
  sqlstm.sqhstl[5] = (unsigned long )15;
  sqlstm.sqhsts[5] = (         int  )15;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->dImpCargo);
  sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[6] = (         int  )sizeof(double);
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szCodMoneda);
  sqlstm.sqhstl[7] = (unsigned long )4;
  sqlstm.sqhsts[7] = (         int  )4;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->lCodPlanCom);
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )sizeof(long);
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->lNumUnidades);
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )sizeof(long);
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->lNumAbonado);
  sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[10] = (         int  )sizeof(long);
  sqlstm.sqindv[10] = (         short *)(pstHostNull->slNumAbonado);
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->szNumTerminal);
  sqlstm.sqhstl[11] = (unsigned long )16;
  sqlstm.sqhsts[11] = (         int  )16;
  sqlstm.sqindv[11] = (         short *)(pstHostNull->sszNumTerminal);
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->lCodCiclFact);
  sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[12] = (         int  )sizeof(long);
  sqlstm.sqindv[12] = (         short *)(pstHostNull->slCodCiclFact);
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->szNumSerie);
  sqlstm.sqhstl[13] = (unsigned long )26;
  sqlstm.sqhsts[13] = (         int  )26;
  sqlstm.sqindv[13] = (         short *)(pstHostNull->sszNumSerie);
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->szNumSerieMec);
  sqlstm.sqhstl[14] = (unsigned long )26;
  sqlstm.sqhsts[14] = (         int  )26;
  sqlstm.sqindv[14] = (         short *)(pstHostNull->sszNumSerieMec);
  sqlstm.sqinds[14] = (         int  )sizeof(short);
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)(pstHost->lCapCode);
  sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[15] = (         int  )sizeof(long);
  sqlstm.sqindv[15] = (         short *)(pstHostNull->slCapCode);
  sqlstm.sqinds[15] = (         int  )sizeof(short);
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)(pstHost->iMesGarantia);
  sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[16] = (         int  )sizeof(int);
  sqlstm.sqindv[16] = (         short *)(pstHostNull->siMesGarantia);
  sqlstm.sqinds[16] = (         int  )sizeof(short);
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)(pstHost->szNumPreGuia);
  sqlstm.sqhstl[17] = (unsigned long )11;
  sqlstm.sqhsts[17] = (         int  )11;
  sqlstm.sqindv[17] = (         short *)(pstHostNull->sszNumPreGuia);
  sqlstm.sqinds[17] = (         int  )sizeof(short);
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)(pstHost->szNumGuia);
  sqlstm.sqhstl[18] = (unsigned long )11;
  sqlstm.sqhsts[18] = (         int  )11;
  sqlstm.sqindv[18] = (         short *)(pstHostNull->sszNumGuia);
  sqlstm.sqinds[18] = (         int  )sizeof(short);
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)(pstHost->lNumTransaccion);
  sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[19] = (         int  )sizeof(long);
  sqlstm.sqindv[19] = (         short *)(pstHostNull->slNumTransaccion);
  sqlstm.sqinds[19] = (         int  )sizeof(short);
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)(pstHost->lNumVenta);
  sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[20] = (         int  )sizeof(long);
  sqlstm.sqindv[20] = (         short *)(pstHostNull->slNumTransaccion);
  sqlstm.sqinds[20] = (         int  )sizeof(short);
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)(pstHost->lNumFactura);
  sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[21] = (         int  )sizeof(long);
  sqlstm.sqindv[21] = (         short *)(pstHostNull->slNumTransaccion);
  sqlstm.sqinds[21] = (         int  )sizeof(short);
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)(pstHost->iCodConceptoDto);
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )sizeof(int);
  sqlstm.sqindv[22] = (         short *)(pstHostNull->siCodConceptoDto);
  sqlstm.sqinds[22] = (         int  )sizeof(short);
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)(pstHost->dValDto);
  sqlstm.sqhstl[23] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[23] = (         int  )sizeof(double);
  sqlstm.sqindv[23] = (         short *)(pstHostNull->sdValDto);
  sqlstm.sqinds[23] = (         int  )sizeof(short);
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)(pstHost->iTipDto);
  sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[24] = (         int  )sizeof(int);
  sqlstm.sqindv[24] = (         short *)(pstHostNull->siTipDto);
  sqlstm.sqinds[24] = (         int  )sizeof(short);
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqharc[24] = (unsigned long  *)0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)(pstHost->iIndCuota);
  sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[25] = (         int  )sizeof(int);
  sqlstm.sqindv[25] = (         short *)(pstHostNull->siIndCuota);
  sqlstm.sqinds[25] = (         int  )sizeof(short);
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqharc[25] = (unsigned long  *)0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)(pstHost->iNumPaquete);
  sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[26] = (         int  )sizeof(int);
  sqlstm.sqindv[26] = (         short *)(pstHostNull->siNumPaquete);
  sqlstm.sqinds[26] = (         int  )sizeof(short);
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqharc[26] = (unsigned long  *)0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)(pstHost->iIndFactur);
  sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[27] = (         int  )sizeof(short);
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqharc[27] = (unsigned long  *)0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)(pstHost->iIndSuperTel);
  sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[28] = (         int  )sizeof(short);
  sqlstm.sqindv[28] = (         short *)(pstHostNull->siIndSuperTel);
  sqlstm.sqinds[28] = (         int  )sizeof(short);
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqharc[28] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL FETCH CGeCargos
			INTO
			:pstHost->szRowid                      ,
			:pstHost->lNumCargo                    ,
			:pstHost->lCodCliente                  ,
			:pstHost->iCodProducto                 ,
			:pstHost->iCodConcepto                 ,
			:pstHost->szFecAlta                    ,
			:pstHost->dImpCargo                    ,
			:pstHost->szCodMoneda                  ,
			:pstHost->lCodPlanCom                  ,
			:pstHost->lNumUnidades                 ,
			:pstHost->lNumAbonado:pstHostNull->slNumAbonado	,
			:pstHost->szNumTerminal:pstHostNull->sszNumTerminal	,
			:pstHost->lCodCiclFact:pstHostNull->slCodCiclFact    ,
			:pstHost->szNumSerie:pstHostNull->sszNumSerie	,
			:pstHost->szNumSerieMec:pstHostNull->sszNumSerieMec ,
			:pstHost->lCapCode:pstHostNull->slCapCode          	,
			:pstHost->iMesGarantia:pstHostNull->siMesGarantia		,
			:pstHost->szNumPreGuia:pstHostNull->sszNumPreGuia		,
			:pstHost->szNumGuia:pstHostNull->sszNumGuia        		,
			:pstHost->lNumTransaccion:pstHostNull->slNumTransaccion		,
			:pstHost->lNumVenta:pstHostNull->slNumTransaccion            	,
			:pstHost->lNumFactura:pstHostNull->slNumTransaccion       		,
			:pstHost->iCodConceptoDto:pstHostNull->siCodConceptoDto	,
			:pstHost->dValDto:pstHostNull->sdValDto             	,
			:pstHost->iTipDto:pstHostNull->siTipDto               	,
			:pstHost->iIndCuota:pstHostNull->siIndCuota            	,
			:pstHost->iNumPaquete:pstHostNull->siNumPaquete     		,
			:pstHost->iIndFactur                   ,
			:pstHost->iIndSuperTel:pstHostNull->siIndSuperTel		; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )1925;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )19;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lNumCargo);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodProducto);
  sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[3] = (         int  )sizeof(short);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iCodConcepto);
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )sizeof(int);
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szFecAlta);
  sqlstm.sqhstl[5] = (unsigned long )15;
  sqlstm.sqhsts[5] = (         int  )15;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->dImpCargo);
  sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[6] = (         int  )sizeof(double);
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szCodMoneda);
  sqlstm.sqhstl[7] = (unsigned long )4;
  sqlstm.sqhsts[7] = (         int  )4;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->lCodPlanCom);
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )sizeof(long);
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->lNumUnidades);
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )sizeof(long);
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->lNumAbonado);
  sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[10] = (         int  )sizeof(long);
  sqlstm.sqindv[10] = (         short *)(pstHostNull->slNumAbonado);
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->szNumTerminal);
  sqlstm.sqhstl[11] = (unsigned long )16;
  sqlstm.sqhsts[11] = (         int  )16;
  sqlstm.sqindv[11] = (         short *)(pstHostNull->sszNumTerminal);
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->lCodCiclFact);
  sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[12] = (         int  )sizeof(long);
  sqlstm.sqindv[12] = (         short *)(pstHostNull->slCodCiclFact);
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->szNumSerie);
  sqlstm.sqhstl[13] = (unsigned long )26;
  sqlstm.sqhsts[13] = (         int  )26;
  sqlstm.sqindv[13] = (         short *)(pstHostNull->sszNumSerie);
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->szNumSerieMec);
  sqlstm.sqhstl[14] = (unsigned long )26;
  sqlstm.sqhsts[14] = (         int  )26;
  sqlstm.sqindv[14] = (         short *)(pstHostNull->sszNumSerieMec);
  sqlstm.sqinds[14] = (         int  )sizeof(short);
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)(pstHost->lCapCode);
  sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[15] = (         int  )sizeof(long);
  sqlstm.sqindv[15] = (         short *)(pstHostNull->slCapCode);
  sqlstm.sqinds[15] = (         int  )sizeof(short);
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)(pstHost->iMesGarantia);
  sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[16] = (         int  )sizeof(int);
  sqlstm.sqindv[16] = (         short *)(pstHostNull->siMesGarantia);
  sqlstm.sqinds[16] = (         int  )sizeof(short);
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)(pstHost->szNumPreGuia);
  sqlstm.sqhstl[17] = (unsigned long )11;
  sqlstm.sqhsts[17] = (         int  )11;
  sqlstm.sqindv[17] = (         short *)(pstHostNull->sszNumPreGuia);
  sqlstm.sqinds[17] = (         int  )sizeof(short);
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)(pstHost->szNumGuia);
  sqlstm.sqhstl[18] = (unsigned long )11;
  sqlstm.sqhsts[18] = (         int  )11;
  sqlstm.sqindv[18] = (         short *)(pstHostNull->sszNumGuia);
  sqlstm.sqinds[18] = (         int  )sizeof(short);
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)(pstHost->lNumTransaccion);
  sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[19] = (         int  )sizeof(long);
  sqlstm.sqindv[19] = (         short *)(pstHostNull->slNumTransaccion);
  sqlstm.sqinds[19] = (         int  )sizeof(short);
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)(pstHost->lNumVenta);
  sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[20] = (         int  )sizeof(long);
  sqlstm.sqindv[20] = (         short *)(pstHostNull->slNumTransaccion);
  sqlstm.sqinds[20] = (         int  )sizeof(short);
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)(pstHost->lNumFactura);
  sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[21] = (         int  )sizeof(long);
  sqlstm.sqindv[21] = (         short *)(pstHostNull->slNumTransaccion);
  sqlstm.sqinds[21] = (         int  )sizeof(short);
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)(pstHost->iCodConceptoDto);
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )sizeof(int);
  sqlstm.sqindv[22] = (         short *)(pstHostNull->siCodConceptoDto);
  sqlstm.sqinds[22] = (         int  )sizeof(short);
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)(pstHost->dValDto);
  sqlstm.sqhstl[23] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[23] = (         int  )sizeof(double);
  sqlstm.sqindv[23] = (         short *)(pstHostNull->sdValDto);
  sqlstm.sqinds[23] = (         int  )sizeof(short);
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)(pstHost->iTipDto);
  sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[24] = (         int  )sizeof(int);
  sqlstm.sqindv[24] = (         short *)(pstHostNull->siTipDto);
  sqlstm.sqinds[24] = (         int  )sizeof(short);
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqharc[24] = (unsigned long  *)0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)(pstHost->iIndCuota);
  sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[25] = (         int  )sizeof(int);
  sqlstm.sqindv[25] = (         short *)(pstHostNull->siIndCuota);
  sqlstm.sqinds[25] = (         int  )sizeof(short);
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqharc[25] = (unsigned long  *)0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)(pstHost->iNumPaquete);
  sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[26] = (         int  )sizeof(int);
  sqlstm.sqindv[26] = (         short *)(pstHostNull->siNumPaquete);
  sqlstm.sqinds[26] = (         int  )sizeof(short);
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqharc[26] = (unsigned long  *)0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)(pstHost->iIndFactur);
  sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[27] = (         int  )sizeof(short);
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqharc[27] = (unsigned long  *)0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)(pstHost->iIndSuperTel);
  sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[28] = (         int  )sizeof(short);
  sqlstm.sqindv[28] = (         short *)(pstHostNull->siIndSuperTel);
  sqlstm.sqinds[28] = (         int  )sizeof(short);
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqharc[28] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}


	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCabCuotas
*******************************************************************************/

/******************************************************************************
Funcion		:     	ifnOraLeerGeCargosRecurrentes
*******************************************************************************/

int  ifnOraLeerGeCargosRecurrentes(CARGOSRECURRENTES_HOST *pstHost,
                                   CARGOSRECURRENTES_HOST_NULL *pstHostNull,
                                   long *plNumFilas,
                                   sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodMoneda 	IS STRING(11); */ 

	
	/* EXEC SQL FETCH CGeCargosRecurrentes
		INTO
		:pstHost->lCodCargo     ,
        :pstHost->dMontoImporte ,
        :pstHost->szCodMoneda   ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2056;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCargo);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->dMontoImporte);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )sizeof(double);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )11;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

int  ifnOraLeerGeCabCuotas(CABCUOTAS_HOST *pstHost,CABCUOTAS_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szRowid 		IS STRING(19); */ 

	/* EXEC SQL VAR pstHost->szDesConcepto 	IS STRING(61); */ 

	/* EXEC SQL VAR pstHost->szCodMoneda 	IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodCuota 	IS STRING(3); */ 

	/* EXEC SQL VAR pstHost->szCodModulo 	IS STRING(3); */ 



	/* EXEC SQL FETCH CGeCabCuotas
		INTO
		:pstHost->szRowid                   ,
		:pstHost->lSeqCuotas                ,
                :pstHost->lCodCliente               ,
                :pstHost->iCodConcepto              ,
                :pstHost->szCodMoneda               ,
                :pstHost->iCodProducto              ,
                :pstHost->iNumCuotas                ,
                :pstHost->dImpTotal                 ,
                :pstHost->iIndPagada                ,
                :pstHost->lNumAbonado		    ,
                :pstHost->szCodCuota:pstHostNull->sszCodCuota	    ,
                :pstHost->lNumPagare; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2083;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )19;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lSeqCuotas);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lCodCliente);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )sizeof(long);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )sizeof(int);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[4] = (unsigned long )4;
 sqlstm.sqhsts[4] = (         int  )4;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[5] = (         int  )sizeof(short);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->iNumCuotas);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )sizeof(int);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->dImpTotal);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[7] = (         int  )sizeof(double);
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->iIndPagada);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[8] = (         int  )sizeof(short);
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->lNumAbonado);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )sizeof(long);
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szCodCuota);
 sqlstm.sqhstl[10] = (unsigned long )3;
 sqlstm.sqhsts[10] = (         int  )3;
 sqlstm.sqindv[10] = (         short *)(pstHostNull->sszCodCuota);
 sqlstm.sqinds[10] = (         int  )sizeof(short);
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->lNumPagare);
 sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[11] = (         int  )sizeof(long);
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeTaConcepFact
*******************************************************************************/

int  ifnOraLeerGeTaConcepFact(TACONCEPFACT_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodServicio 	IS STRING(6); */ 


	/* EXEC SQL FETCH CGeTaConcepFact
		INTO
		:pstHost->iCodProducto    ,
                :pstHost->iCodFacturacion ,
                :pstHost->iIndTabla       ,
                :pstHost->iIndEntSal      ,
                :pstHost->iIndDestino     ,
                :pstHost->iCodTarificacion,
                :pstHost->szCodServicio    ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2146;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[0] = (         int  )sizeof(short);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodFacturacion);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iIndTabla);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[2] = (         int  )sizeof(short);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iIndEntSal);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[3] = (         int  )sizeof(short);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iIndDestino);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )sizeof(int);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iCodTarificacion);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )sizeof(int);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szCodServicio);
 sqlstm.sqhstl[6] = (unsigned long )6;
 sqlstm.sqhsts[6] = (         int  )6;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeConceptos
*******************************************************************************/

int  ifnOraLeerGeConceptos(CONCEPTO_HOST *pstHost,CONCEPTO_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szDesConcepto IS STRING(61); */ 

	/* EXEC SQL VAR pstHost->szCodModulo 	IS STRING(3); */ 

	/* EXEC SQL VAR pstHost->szCodMoneda 	IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodTipDescu IS STRING(2); */ 



	/* EXEC SQL FETCH CGeConceptos
		INTO  :pstHost->iCodConcepto,
              :pstHost->iCodProducto,
              :pstHost->szDesConcepto,
              :pstHost->iCodTipConce,
              :pstHost->szCodModulo,
              :pstHost->szCodMoneda,
              :pstHost->iIndActivo,
              :pstHost->iCodConcOrig:pstHostNull->siCodConcOrig,
              :pstHost->szCodTipDescu:pstHostNull->sszCodTipDescu,
              :pstHost->iCodConCobr,
              :pstHost->lFactor:pstHostNull->slFactor,
              :pstHost->iCodGrpServi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2189;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[1] = (         int  )sizeof(short);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szDesConcepto);
 sqlstm.sqhstl[2] = (unsigned long )61;
 sqlstm.sqhsts[2] = (         int  )61;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodTipConce);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )sizeof(int);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodModulo);
 sqlstm.sqhstl[4] = (unsigned long )3;
 sqlstm.sqhsts[4] = (         int  )3;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[5] = (unsigned long )4;
 sqlstm.sqhsts[5] = (         int  )4;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->iIndActivo);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[6] = (         int  )sizeof(short);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->iCodConcOrig);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )sizeof(int);
 sqlstm.sqindv[7] = (         short *)(pstHostNull->siCodConcOrig);
 sqlstm.sqinds[7] = (         int  )sizeof(short);
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->szCodTipDescu);
 sqlstm.sqhstl[8] = (unsigned long )2;
 sqlstm.sqhsts[8] = (         int  )2;
 sqlstm.sqindv[8] = (         short *)(pstHostNull->sszCodTipDescu);
 sqlstm.sqinds[8] = (         int  )sizeof(short);
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->iCodConCobr);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )sizeof(int);
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->lFactor);
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )sizeof(long);
 sqlstm.sqindv[10] = (         short *)(pstHostNull->slFactor);
 sqlstm.sqinds[10] = (         int  )sizeof(short);
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->iCodGrpServi);
 sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[11] = (         int  )sizeof(int);
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeConceptos_Mi
*******************************************************************************/

int  ifnOraLeerGeConceptos_Mi(CONCEPTO_MI_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


/*	EXEC SQL VAR pstHost->szCodConcepto 	IS STRING(12);	*/
	/* EXEC SQL VAR pstHost->szCodIdioma 	IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szDesConcepto 	IS STRING(61); */ 



	/* EXEC SQL FETCH CGeConceptos_Mi
		INTO
		 :pstHost->iCodConcepto,
		 :pstHost->szCodIdioma,
		 :pstHost->szDesConcepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2252;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodIdioma);
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szDesConcepto);
 sqlstm.sqhstl[2] = (unsigned long )61;
 sqlstm.sqhsts[2] = (         int  )61;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeRangoTabla
*******************************************************************************/

int  ifnOraLeerGeRangoTabla(RANGOTABLA_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szNomTabla 	IS STRING(21); */ 



	/* EXEC SQL FETCH CGeRangoTabla
		INTO
		 :pstHost->lCodCiclFact,
		 :pstHost->lRangoIni   ,
                 :pstHost->lRangoFin   ,
                 :pstHost->iCodProducto,
                 :pstHost->szNomTabla; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2279;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCiclFact);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lRangoIni);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lRangoFin);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )sizeof(long);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )sizeof(int);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szNomTabla);
 sqlstm.sqhstl[4] = (unsigned long )21;
 sqlstm.sqhsts[4] = (         int  )21;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeLimCreditos
*******************************************************************************/

int  ifnOraLeerGeLimCreditos(LIMCREDITOS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodCalClien IS STRING(3) ; */ 



	/* EXEC SQL FETCH CGeLimCreditos
		INTO :pstHost->iCodCredMor  ,
             :pstHost->iCodProducto ,
             :pstHost->szCodCalClien,
             :pstHost->dImpMorosidad; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2314;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodCredMor);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodCalClien);
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )3;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->dImpMorosidad);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[3] = (         int  )sizeof(double);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeActividades
*******************************************************************************/

int  ifnOraLeerGeActividades(ACTIVIDADES_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szDesActividad IS STRING(41); */ 



	/* EXEC SQL FETCH CGeActividades
		INTO :pstHost->iCodActividad,
             :pstHost->szDesActividad; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2345;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodActividad);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesActividad);
 sqlstm.sqhstl[1] = (unsigned long )41;
 sqlstm.sqhsts[1] = (         int  )41;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeProvincias
*******************************************************************************/

int  ifnOraLeerGeProvincias(PROVINCIAS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodRegion IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodProvincia IS STRING(6); */ 


	/* EXEC SQL FETCH CGeProvincias
		INTO :pstHost->szCodRegion   ,
             :pstHost->szCodProvincia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2368;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodRegion);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodProvincia);
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeRegiones
*******************************************************************************/

int  ifnOraLeerGeRegiones(REGIONES_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodRegion IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szDesRegion IS STRING(31); */ 


	/* EXEC SQL FETCH CGeRegiones
		INTO    :pstHost->szCodRegion   ,
                :pstHost->szDesRegion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2391;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodRegion);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesRegion);
 sqlstm.sqhstl[1] = (unsigned long )31;
 sqlstm.sqhsts[1] = (         int  )31;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCatImpositiva
*******************************************************************************/

int  ifnOraLeerGeCatImpositiva(CATIMPOSITIVA_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szDesCatImpos IS STRING(41); */ 


	/* EXEC SQL FETCH CGeCatImpositiva
		INTO :pstHost->iCodCatImpos   ,
             :pstHost->szDesCatImpos  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2414;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodCatImpos);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesCatImpos);
 sqlstm.sqhstl[1] = (unsigned long )41;
 sqlstm.sqhsts[1] = (         int  )41;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeZonaCiudad
*******************************************************************************/

int  ifnOraLeerGeZonaCiudad(ZONACIUDAD_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodRegion     IS STRING(4) ; */ 

	/* EXEC SQL VAR pstHost->szCodProvincia  IS STRING(6) ; */ 

	/* EXEC SQL VAR pstHost->szCodCiudad     IS STRING(6) ; */ 

	/* EXEC SQL VAR pstHost->szFecDesde      IS STRING(15); */ 

	/* EXEC SQL VAR pstHost->szFecHasta      IS STRING(15); */ 


	/* EXEC SQL FETCH CGeZonaCiudad
		INTO :pstHost->szCodRegion   ,
                :pstHost->szCodProvincia,
                :pstHost->szCodCiudad   ,
                :pstHost->szFecDesde    ,
                :pstHost->szFecHasta    ,
                :pstHost->iCodZonaImpo  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2437;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodRegion);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodProvincia);
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodCiudad);
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )6;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[4] = (unsigned long )15;
 sqlstm.sqhsts[4] = (         int  )15;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iCodZonaImpo);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )sizeof(int);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeZonaImpositiva
*******************************************************************************/

int  ifnOraLeerGeZonaImpositiva(ZONAIMPOSITIVA_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szDesZonaImpo     IS STRING(41) ; */ 


	/* EXEC SQL FETCH CGeZonaImpositiva
		INTO :pstHost->iCodZonaImpo ,
             :pstHost->szDesZonaImpo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2476;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodZonaImpo);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesZonaImpo);
 sqlstm.sqhstl[1] = (unsigned long )41;
 sqlstm.sqhsts[1] = (         int  )41;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeImpuestos
*******************************************************************************/

int  ifnOraLeerGeImpuestos(IMPUESTOS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szFecDesde     IS STRING(15) ; */ 

	/* EXEC SQL VAR pstHost->szFecHasta     IS STRING(15) ; */ 


	/* EXEC SQL FETCH CGeImpuestos
		INTO :pstHost->iCodCatImpos ,
             :pstHost->iCodZonaImpo ,
             :pstHost->iCodZonaAbon ,
             :pstHost->iCodTipImpues,
             :pstHost->iCodGrpServi ,
             :pstHost->szFecDesde   ,
             :pstHost->iCodConcGene ,
             :pstHost->szFecHasta   ,
             :pstHost->fPrcImpuesto ,
             :pstHost->iTipMonto    ,
             :pstHost->dImpUmbral   ,
             :pstHost->dImpMaximo   ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2499;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodCatImpos);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodZonaImpo);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodZonaAbon);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodTipImpues);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )sizeof(int);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iCodGrpServi);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )sizeof(int);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[5] = (unsigned long )15;
 sqlstm.sqhsts[5] = (         int  )15;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->iCodConcGene);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )sizeof(int);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[7] = (unsigned long )15;
 sqlstm.sqhsts[7] = (         int  )15;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->fPrcImpuesto);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(float);
 sqlstm.sqhsts[8] = (         int  )sizeof(float);
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->iTipMonto);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )sizeof(int);
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->dImpUmbral);
 sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[10] = (         int  )sizeof(double);
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->dImpMaximo);
 sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[11] = (         int  )sizeof(double);
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeTipImpues
*******************************************************************************/
/*
int  ifnOraLeerGeTipImpues(TIPIMPUES_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        EXEC SQL CONTEXT USE :ctx;


	EXEC SQL FETCH CGeTipImpues
		INTO  :pstHost->iCodTipImpue ,
              :pstHost->dImpUmbral   ,
              :pstHost->iTipMonto    ,
              :pstHost->iCodCateImp  ;


	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}
*/
/******************************************************************************
Funcion		:     	ifnOraLeerGeGrpSerConc
*******************************************************************************/

int  ifnOraLeerGeGrpSerConc(GRPSERCONC_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szFecDesde    IS STRING(15) ; */ 

	/* EXEC SQL VAR pstHost->szFecHasta    IS STRING(15) ; */ 


	/* EXEC SQL FETCH CGeGrpSerConc
		INTO :pstHost->iCodConcepto,
             :pstHost->szFecDesde  ,
             :pstHost->iCodGrpServi,
             :pstHost->szFecHasta  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2562;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[1] = (unsigned long )15;
 sqlstm.sqhsts[1] = (         int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodGrpServi);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeConversion
*******************************************************************************/

int  ifnOraLeerGeConversion(CONVERSION_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodMoneda   IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szFecDesde    IS STRING(15) ; */ 

	/* EXEC SQL VAR pstHost->szFecHasta    IS STRING(15) ; */ 


	/* EXEC SQL FETCH CGeConversion
		INTO :pstHost->szCodMoneda,
             :pstHost->szFecDesde  ,
             :pstHost->szFecHasta ,
             :pstHost->dCambio; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2593;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[1] = (unsigned long )15;
 sqlstm.sqhsts[1] = (         int  )15;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[2] = (unsigned long )15;
 sqlstm.sqhsts[2] = (         int  )15;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->dCambio);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[3] = (         int  )sizeof(double);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeDocumSucursal
*******************************************************************************/

int  ifnOraLeerGeDocumSucursal(DOCUMSUCURSAL_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodOficina  IS STRING(3); */ 


	/* EXEC SQL FETCH CGeDocumSucursal
		INTO :pstHost->szCodOficina,
             :pstHost->iCodTipDocum  ,
             :pstHost->iCodCentrEmi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2624;
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
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodTipDocum);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodCentrEmi);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeLetras
*******************************************************************************/

int  ifnOraLeerGeLetras(LETRAS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szLetra  IS STRING(2); */ 


	/* EXEC SQL FETCH CGeLetras
		INTO :pstHost->iCodTipDocum,
             :pstHost->iCodCatImpos  ,
             :pstHost->szLetra; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2651;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodTipDocum);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodCatImpos);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szLetra);
 sqlstm.sqhstl[2] = (unsigned long )2;
 sqlstm.sqhsts[2] = (         int  )2;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeGrupoCob
*******************************************************************************/

int  ifnOraLeerGeGrupoCob(GRUPOCOB_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodGrupo  IS STRING(3); */ 

	/* EXEC SQL VAR pstHost->szFecDesde  IS STRING(15) ; */ 

	/* EXEC SQL VAR pstHost->szFecHasta  IS STRING(15) ; */ 


	/* EXEC SQL FETCH CGeGrupoCob
		INTO :pstHost->szCodGrupo,
		 	 :pstHost->iCodProducto  ,
  		 	 :pstHost->iCodConcepto  ,
		 	 :pstHost->iCodCiclo  ,
             :pstHost->iTipCobro  ,
             :pstHost->szFecDesde  ,
             :pstHost->szFecHasta  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2678;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodGrupo);
 sqlstm.sqhstl[0] = (unsigned long )3;
 sqlstm.sqhsts[0] = (         int  )3;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[1] = (         int  )sizeof(short);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodCiclo);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )sizeof(int);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iTipCobro);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[4] = (         int  )sizeof(short);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[5] = (unsigned long )15;
 sqlstm.sqhsts[5] = (         int  )15;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[6] = (unsigned long )15;
 sqlstm.sqhsts[6] = (         int  )15;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeTarifas
*******************************************************************************/

int  ifnOraLeerGeTarifas(TARIFAS_HOST *pstHost,TARIFAS_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodTipServ   IS STRING(2) ; */ 

	/* EXEC SQL VAR pstHost->szCodServicio  IS STRING(4) ; */ 

	/* EXEC SQL VAR pstHost->szCodPlanServ  IS STRING(4) ; */ 

	/* EXEC SQL VAR pstHost->szFecDesde    IS STRING(15) ; */ 

	/* EXEC SQL VAR pstHost->szCodMoneda    IS STRING(4) ; */ 

	/* EXEC SQL VAR pstHost->szIndPeriodico IS STRING(2) ; */ 

	/* EXEC SQL VAR pstHost->szFecHasta     IS STRING(15); */ 


	/* EXEC SQL FETCH CGeTarifas
		INTO :pstHost->szCodTipServ  ,
		 	 :pstHost->szCodServicio  ,
             :pstHost->szCodPlanServ  ,
             :pstHost->szFecDesde  ,
             :pstHost->dImpTarifa  ,
             :pstHost->szCodMoneda  ,
             :pstHost->szIndPeriodico  ,
             :pstHost->szFecHasta:pstHostNull->sszFecHasta; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2721;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodTipServ);
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )2;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodServicio);
 sqlstm.sqhstl[1] = (unsigned long )4;
 sqlstm.sqhsts[1] = (         int  )4;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodPlanServ);
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )4;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->dImpTarifa);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[4] = (         int  )sizeof(double);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[5] = (unsigned long )4;
 sqlstm.sqhsts[5] = (         int  )4;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szIndPeriodico);
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )2;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[7] = (unsigned long )15;
 sqlstm.sqhsts[7] = (         int  )15;
 sqlstm.sqindv[7] = (         short *)(pstHostNull->sszFecHasta);
 sqlstm.sqinds[7] = (         int  )sizeof(short);
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeActuaServ
*******************************************************************************/

int  ifnOraLeerGeActuaServ(ACTUASERV_HOST *pstHost,ACTUASERV_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodTipServ   IS STRING(2) ; */ 

	/* EXEC SQL VAR pstHost->szCodServicio  IS STRING(4) ; */ 


	/* EXEC SQL FETCH CGeActuaServ
		INTO :pstHost->szCodTipServ  ,
		 	 :pstHost->szCodServicio,
         	 :pstHost->iCodConcepto:pstHostNull->siCodConcepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2768;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodTipServ);
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )2;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodServicio);
 sqlstm.sqhstl[1] = (unsigned long )4;
 sqlstm.sqhsts[1] = (         int  )4;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)(pstHostNull->siCodConcepto);
 sqlstm.sqinds[2] = (         int  )sizeof(short);
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCuotas
*******************************************************************************/

int  ifnOraLeerGeCuotas(CUOTAS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szRowid  IS STRING(19); */ 

	/* EXEC SQL VAR pstHost->szFecEmision    IS STRING(15) ; */ 


	/* EXEC SQL FETCH CGeCuotas
		INTO
		 :pstHost->szRowid     ,
                 :pstHost->lSeqCuotas,
		 :pstHost->iOrdCuota  ,
  		 :pstHost->szFecEmision  ,
		 :pstHost->dImpCuota,
                 :pstHost->iIndFacturado,
               	 :pstHost->iIndPagado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2795;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )19;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lSeqCuotas);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iOrdCuota);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecEmision);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->dImpCuota);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[4] = (         int  )sizeof(double);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iIndFacturado);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[5] = (         int  )sizeof(short);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->iIndPagado);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[6] = (         int  )sizeof(short);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeFactCarriers
*******************************************************************************/

int  ifnOraLeerGeFactCarriers(FACTCARRIERS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL FETCH CGeFactCarriers
		INTO
		 :pstHost->iCodConcFact   ,
         :pstHost->iCodConcCarrier,
         :pstHost->iCodTipConce; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2838;
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
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodConcCarrier);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodTipConce);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCuadCtoPlan
*******************************************************************************/

int  ifnOraLeerGeCuadCtoPlan(CUADCTOPLAN_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL FETCH CGeCuadCtoPlan
		INTO :pstHost->lCodCtoPlan	,	
		 	 :pstHost->dImpUmbDesde ,
             :pstHost->dImpUmbHasta	,
		 	 :pstHost->dImpDescuento,
             :pstHost->iCodTipoDto  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2865;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCtoPlan);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->dImpUmbDesde);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )sizeof(double);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->dImpUmbHasta);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[2] = (         int  )sizeof(double);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->dImpDescuento);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[3] = (         int  )sizeof(double);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iCodTipoDto);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[4] = (         int  )sizeof(short);
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCtoPlan
*******************************************************************************/

int  ifnOraLeerGeCtoPlan(CTOPLAN_HOST *pstHost,CTOPLAN_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodTipCtoPlan IS STRING (2) ; */ 

	/* EXEC SQL VAR pstHost->szCodMoneda     IS STRING (4) ; */ 


	/* EXEC SQL FETCH CGeCtoPlan
		INTO :pstHost->lCodCtoPlan,
		     :pstHost->iCodProducto   ,
             :pstHost->szCodTipCtoPlan,
		     :pstHost->szCodMoneda   ,
             :pstHost->iCodCtoFac   ,
             :pstHost->dImpDescuento,
		     :pstHost->iCodTipoDto   ,
             :pstHost->iIndCuadrante,
		     :pstHost->iCodTipoCuad   ,
             :pstHost->dImpUmbDesde:pstHostNull->sdImpUmbDesde,
             :pstHost->dImpUmbHasta:pstHostNull->sdImpUmbHasta,
             :pstHost->iNumDias:pstHostNull->siNumDias; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2900;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCtoPlan);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[1] = (         int  )sizeof(short);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodTipCtoPlan);
 sqlstm.sqhstl[2] = (unsigned long )2;
 sqlstm.sqhsts[2] = (         int  )2;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )4;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iCodCtoFac);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )sizeof(int);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->dImpDescuento);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[5] = (         int  )sizeof(double);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->iCodTipoDto);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[6] = (         int  )sizeof(short);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->iIndCuadrante);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[7] = (         int  )sizeof(short);
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->iCodTipoCuad);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[8] = (         int  )sizeof(short);
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->dImpUmbDesde);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[9] = (         int  )sizeof(double);
 sqlstm.sqindv[9] = (         short *)(pstHostNull->sdImpUmbDesde);
 sqlstm.sqinds[9] = (         int  )sizeof(short);
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->dImpUmbHasta);
 sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[10] = (         int  )sizeof(double);
 sqlstm.sqindv[10] = (         short *)(pstHostNull->sdImpUmbHasta);
 sqlstm.sqinds[10] = (         int  )sizeof(short);
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->iNumDias);
 sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[11] = (         int  )sizeof(int);
 sqlstm.sqindv[11] = (         short *)(pstHostNull->siNumDias);
 sqlstm.sqinds[11] = (         int  )sizeof(short);
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGePlanCtoPlan
*******************************************************************************/

int  ifnOraLeerGePlanCtoPlan(PLANCTOPLAN_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szFecEfectividad IS STRING (15) ; */ 

	/* EXEC SQL VAR pstHost->szFecFinEfectividad IS STRING (15) ; */ 


	/* EXEC SQL FETCH CGePlanCtoPlan
		INTO :pstHost->lCodPlanCom,
		 	 :pstHost->iCodProducto   ,
             :pstHost->lCodCtoPlan,
		 	 :pstHost->szFecEfectividad   ,
             :pstHost->szFecFinEfectividad; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2963;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodPlanCom);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[1] = (         int  )sizeof(short);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lCodCtoPlan);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )sizeof(long);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecEfectividad);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szFecFinEfectividad);
 sqlstm.sqhstl[4] = (unsigned long )15;
 sqlstm.sqhsts[4] = (         int  )15;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeArriendo
*******************************************************************************/

int  ifnOraLeerGeArriendo(ARRIENDO_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szRowid  IS STRING(19); */ 

	/* EXEC SQL VAR pstHost->szFecDesde IS STRING (15) ; */ 

	/* EXEC SQL VAR pstHost->szFecHasta IS STRING (15) ; */ 

	/* EXEC SQL VAR pstHost->szCodMoneda IS STRING (4) ; */ 



	/* EXEC SQL FETCH CGeArriendo
		INTO
		 :pstHost->szRowid   ,
                 :pstHost->lCodCliente,
		 :pstHost->lNumAbonado   ,
                 :pstHost->szFecDesde,
		 :pstHost->szFecHasta  ,
                 :pstHost->iCodProducto   ,
                 :pstHost->iCodConcepto   ,
                 :pstHost->lCodArticulo   ,
                 :pstHost->dPrecioMes   ,
                 :pstHost->szCodMoneda; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )2998;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )19;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lCodCliente);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lNumAbonado);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )sizeof(long);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecDesde);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szFecHasta);
 sqlstm.sqhstl[4] = (unsigned long )15;
 sqlstm.sqhsts[4] = (         int  )15;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )sizeof(int);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )sizeof(int);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->lCodArticulo);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )sizeof(long);
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->dPrecioMes);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[8] = (         int  )sizeof(double);
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[9] = (unsigned long )4;
 sqlstm.sqhsts[9] = (         int  )4;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCargosBasico
*******************************************************************************/

int  ifnOraLeerGeCargosBasico(CARGOSBASICO_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodCargoBasico IS STRING(4) ; */ 

	/* EXEC SQL VAR pstHost->szCodMoneda      IS STRING(4) ; */ 


	/* EXEC SQL FETCH CGeCargosBasico
	INTO :pstHost->szCodCargoBasico ,
		 :pstHost->dImpCargoBasico  ,
		 :pstHost->szCodMoneda		; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3053;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodCargoBasico);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->dImpCargoBasico);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )sizeof(double);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )4;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


		 
	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeOptimo
*******************************************************************************/

int  ifnOraLeerGeOptimo(OPTIMO_HOST *pstHost,OPTIMO_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodPlanTarif  IS STRING(4); */ 


	/* EXEC SQL FETCH CGeOptimo
		INTO
		 :pstHost->szCodPlanTarif   ,
         :pstHost->lMinDesde,
		 :pstHost->lMinHasta:pstHostNull->slMinHasta   ,
         :pstHost->fPrcAbono,
		 :pstHost->fPrcNormal  ,
         :pstHost->fPrcBajo ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3080;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodPlanTarif);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lMinDesde);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lMinHasta);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )sizeof(long);
 sqlstm.sqindv[2] = (         short *)(pstHostNull->slMinHasta);
 sqlstm.sqinds[2] = (         int  )sizeof(short);
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->fPrcAbono);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
 sqlstm.sqhsts[3] = (         int  )sizeof(float);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->fPrcNormal);
 sqlstm.sqhstl[4] = (unsigned long )sizeof(float);
 sqlstm.sqhsts[4] = (         int  )sizeof(float);
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->fPrcBajo);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(float);
 sqlstm.sqhsts[5] = (         int  )sizeof(float);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeFeriados
*******************************************************************************/

int  ifnOraLeerGeFeriados(FERIADOS_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szFecFeriado  IS STRING(15); */ 


	/* EXEC SQL FETCH CGeFeriados
		INTO
		 :pstHost->szFecFeriado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3119;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szFecFeriado);
 sqlstm.sqhstl[0] = (unsigned long )15;
 sqlstm.sqhsts[0] = (         int  )15;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGePlanTarif
*******************************************************************************/

int  ifnOraLeerGePlanTarif(PLANTARIF_HOST *pstHost,PLANTARIF_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodPlanTarif   IS STRING(4)  ; */ 

	/* EXEC SQL VAR pstHost->szTipTerminal    IS STRING(2)  ; */ 

	/* EXEC SQL VAR pstHost->szCodLimConsumo  IS STRING(4)  ; */ 

	/* EXEC SQL VAR pstHost->szCodCargoBasico IS STRING(4)  ; */ 
 
	/* EXEC SQL VAR pstHost->szTipPlanTarif   IS STRING(2)  ; */ 

	/* EXEC SQL VAR pstHost->szTipUnidades    IS STRING(2)  ; */ 

	/* EXEC SQL VAR pstHost->szInd_Francons   IS STRING(3)  ; */ 

	/* EXEC SQL VAR pstHost->szIndCompartido  IS STRING(1+1); */ 
	/* P-MIX-09003 */

	/* EXEC SQL FETCH CGePlanTarif
		 INTO  :pstHost->szCodPlanTarif,
        	       :pstHost->szTipTerminal:pstHostNull->sszTipTerminal,
		       :pstHost->szCodLimConsumo,
		       :pstHost->szCodCargoBasico,
	               :pstHost->szTipPlanTarif,
                       :pstHost->szTipUnidades,
                       :pstHost->lNumUnidades,
                       :pstHost->iIndArrastre,
                       :pstHost->iNumDias,
                       :pstHost->lNumAbonados:pstHostNull->slNumAbonados,
                       :pstHost->szInd_Francons,
                       :pstHost->iFlgRango,
                       :pstHost->szIndCompartido, /o P-MIX-09003 o/
                       :pstHost->iTipCobro; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3138;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodPlanTarif);
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szTipTerminal);
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )2;
 sqlstm.sqindv[1] = (         short *)(pstHostNull->sszTipTerminal);
 sqlstm.sqinds[1] = (         int  )sizeof(short);
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodLimConsumo);
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )4;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodCargoBasico);
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )4;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szTipPlanTarif);
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )2;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szTipUnidades);
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )2;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->lNumUnidades);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )sizeof(long);
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->iIndArrastre);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[7] = (         int  )sizeof(short);
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->iNumDias);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )sizeof(int);
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->lNumAbonados);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )sizeof(long);
 sqlstm.sqindv[9] = (         short *)(pstHostNull->slNumAbonados);
 sqlstm.sqinds[9] = (         int  )sizeof(short);
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szInd_Francons);
 sqlstm.sqhstl[10] = (unsigned long )3;
 sqlstm.sqhsts[10] = (         int  )3;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->iFlgRango);
 sqlstm.sqhstl[11] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[11] = (         int  )sizeof(short);
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqharc[11] = (unsigned long  *)0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->szIndCompartido);
 sqlstm.sqhstl[12] = (unsigned long )2;
 sqlstm.sqhsts[12] = (         int  )2;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqharc[12] = (unsigned long  *)0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->iTipCobro);
 sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[13] = (         int  )sizeof(int);
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqharc[13] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}

       /* P-MIX-09003 */

	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGePenalizaciones
*******************************************************************************/

int  ifnOraLeerGePenalizaciones(PENALIZA_HOST *pstHost,PENALIZA_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szRowid  IS STRING(19); */ 

	/* EXEC SQL VAR pstHost->szFecEfectividad  IS STRING(15); */ 

	/* EXEC SQL VAR pstHost->szCodMoneda  IS STRING(4); */ 


	/* EXEC SQL FETCH CGePenalizaciones
		INTO
		 :pstHost->szRowid,
                 :pstHost->lCodCliente,
                 :pstHost->iTipIncidencia,
                 :pstHost->szFecEfectividad,
                 :pstHost->szCodMoneda,
                 :pstHost->dImpPenaliz,
                 :pstHost->lCodCiclFact:pstHostNull->slCodCiclFact,
                 :pstHost->iCodConcepto,
                 :pstHost->iCodProducto,
                 :pstHost->lNumAbonado:pstHostNull->slNumAbonado,
                 :pstHost->lNumProceso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3209;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )19;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lCodCliente);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iTipIncidencia);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )sizeof(int);
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecEfectividad);
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )15;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodMoneda);
 sqlstm.sqhstl[4] = (unsigned long )4;
 sqlstm.sqhsts[4] = (         int  )4;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->dImpPenaliz);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[5] = (         int  )sizeof(double);
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->lCodCiclFact);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )sizeof(long);
 sqlstm.sqindv[6] = (         short *)(pstHostNull->slCodCiclFact);
 sqlstm.sqinds[6] = (         int  )sizeof(short);
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->iCodConcepto);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )sizeof(int);
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->iCodProducto);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )sizeof(int);
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->lNumAbonado);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )sizeof(long);
 sqlstm.sqindv[9] = (         short *)(pstHostNull->slNumAbonado);
 sqlstm.sqinds[9] = (         int  )sizeof(short);
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->lNumProceso);
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )sizeof(long);
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}




	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCatImpClientes
*******************************************************************************/

int  ifnOraLeerGeCatImpClientes(CAT_IMPCLIENTES_HOST *pstHost,long *plNumFilas,sql_context ctx,long clieini,long cliefin)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szIndOrdenTotal IS STRING(13); */ 


	if (cliefin !=0)
	{
		/* EXEC SQL FETCH CGeCatImpClientesR
		INTO
			 :pstHost->lCodCliente,
			 :pstHost->iCodCatImpos,
	                 :pstHost->szIndOrdenTotal; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3268;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodCatImpos);
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szIndOrdenTotal);
  sqlstm.sqhstl[2] = (unsigned long )13;
  sqlstm.sqhsts[2] = (         int  )13;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }
        else
        {
        	/* EXEC SQL FETCH CGeCatImpClientes
		INTO
			 :pstHost->lCodCliente,
			 :pstHost->iCodCatImpos,
                         :pstHost->szIndOrdenTotal; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 33;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )30000;
         sqlstm.offset = (unsigned int  )3295;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
         sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[0] = (         int  )sizeof(long);
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqharc[0] = (unsigned long  *)0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iCodCatImpos);
         sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[1] = (         int  )sizeof(int);
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqharc[1] = (unsigned long  *)0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szIndOrdenTotal);
         sqlstm.sqhstl[2] = (unsigned long )13;
         sqlstm.sqhsts[2] = (         int  )13;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqharc[2] = (unsigned long  *)0;
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
         sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }

	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeDirecciones
*******************************************************************************/

int  ifnOraLeerGeDirecciones(DIRECCIONES_HOST *pstHost,DIRECCIONES_HOST_NULL *pstHostNull,long *plNumFilas,sql_context ctx,
			    long clieini,long cliefin)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodRegion IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodProvincia IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodCiudad IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodComuna IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szNomCalle IS STRING(51); */ 

	/* EXEC SQL VAR pstHost->szNumCalle IS STRING(11); */ 

	/* EXEC SQL VAR pstHost->szNumPiso IS STRING(11); */ 


        if (cliefin !=0)
	{
		/* EXEC SQL FETCH CGeDireccionesR
		INTO
		 	:pstHost->lCodCliente,
			:pstHost->szCodRegion    :pstHostNull->sszCodRegion,
			:pstHost->szCodProvincia :pstHostNull->sszCodProvincia,
			:pstHost->szCodCiudad    :pstHostNull->sszCodCiudad,
			:pstHost->szCodComuna    :pstHostNull->sszCodComuna,
			:pstHost->szNomCalle     :pstHostNull->sszNomCalle,
			:pstHost->szNumCalle     :pstHostNull->sszNumCalle,
			:pstHost->szNumPiso      :pstHostNull->sszNumPiso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3322;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodRegion);
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )4;
  sqlstm.sqindv[1] = (         short *)(pstHostNull->sszCodRegion);
  sqlstm.sqinds[1] = (         int  )sizeof(short);
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodProvincia);
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )6;
  sqlstm.sqindv[2] = (         short *)(pstHostNull->sszCodProvincia);
  sqlstm.sqinds[2] = (         int  )sizeof(short);
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodCiudad);
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )6;
  sqlstm.sqindv[3] = (         short *)(pstHostNull->sszCodCiudad);
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodComuna);
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )6;
  sqlstm.sqindv[4] = (         short *)(pstHostNull->sszCodComuna);
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szNomCalle);
  sqlstm.sqhstl[5] = (unsigned long )51;
  sqlstm.sqhsts[5] = (         int  )51;
  sqlstm.sqindv[5] = (         short *)(pstHostNull->sszNomCalle);
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szNumCalle);
  sqlstm.sqhstl[6] = (unsigned long )11;
  sqlstm.sqhsts[6] = (         int  )11;
  sqlstm.sqindv[6] = (         short *)(pstHostNull->sszNumCalle);
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szNumPiso);
  sqlstm.sqhstl[7] = (unsigned long )11;
  sqlstm.sqhsts[7] = (         int  )11;
  sqlstm.sqindv[7] = (         short *)(pstHostNull->sszNumPiso);
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }
        else
        {
		/* EXEC SQL FETCH CGeDirecciones
		INTO
		 	:pstHost->lCodCliente,
			:pstHost->szCodRegion     :pstHostNull->sszCodRegion,    
			:pstHost->szCodProvincia  :pstHostNull->sszCodProvincia, 
			:pstHost->szCodCiudad     :pstHostNull->sszCodCiudad,    
			:pstHost->szCodComuna     :pstHostNull->sszCodComuna,    
			:pstHost->szNomCalle      :pstHostNull->sszNomCalle,
			:pstHost->szNumCalle      :pstHostNull->sszNumCalle,
			:pstHost->szNumPiso       :pstHostNull->sszNumPiso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3369;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodRegion);
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )4;
  sqlstm.sqindv[1] = (         short *)(pstHostNull->sszCodRegion);
  sqlstm.sqinds[1] = (         int  )sizeof(short);
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodProvincia);
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )6;
  sqlstm.sqindv[2] = (         short *)(pstHostNull->sszCodProvincia);
  sqlstm.sqinds[2] = (         int  )sizeof(short);
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodCiudad);
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )6;
  sqlstm.sqindv[3] = (         short *)(pstHostNull->sszCodCiudad);
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodComuna);
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )6;
  sqlstm.sqindv[4] = (         short *)(pstHostNull->sszCodComuna);
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szNomCalle);
  sqlstm.sqhstl[5] = (unsigned long )51;
  sqlstm.sqhsts[5] = (         int  )51;
  sqlstm.sqindv[5] = (         short *)(pstHostNull->sszNomCalle);
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szNumCalle);
  sqlstm.sqhstl[6] = (unsigned long )11;
  sqlstm.sqhsts[6] = (         int  )11;
  sqlstm.sqindv[6] = (         short *)(pstHostNull->sszNumCalle);
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szNumPiso);
  sqlstm.sqhstl[7] = (unsigned long )11;
  sqlstm.sqhsts[7] = (         int  )11;
  sqlstm.sqindv[7] = (         short *)(pstHostNull->sszNumPiso);
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }

	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeDirecciones2
*******************************************************************************/

int  ifnOraLeerGeDirecciones2(DIRECCIONES_HOST2 *pstHost,DIRECCIONES_HOST_NULL2 *pstHostNull,long *plNumFilas,sql_context ctx,
			    long clieini,long cliefin)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodRegion IS STRING(4); */ 

	/* EXEC SQL VAR pstHost->szCodProvincia IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodCiudad IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szCodComuna IS STRING(6); */ 

	/* EXEC SQL VAR pstHost->szNomCalle IS STRING(51); */ 

	/* EXEC SQL VAR pstHost->szNumCalle IS STRING(11); */ 

	/* EXEC SQL VAR pstHost->szNumPiso IS STRING(11); */ 


        if (cliefin !=0)
	{
		/* EXEC SQL FETCH CGeDireccionesR
		INTO
		 	        :pstHost->lCodCliente,
			        :pstHost->szCodRegion     :pstHostNull->sszCodRegion,    
                  	:pstHost->szCodProvincia  :pstHostNull->sszCodProvincia, 
                  	:pstHost->szCodCiudad     :pstHostNull->sszCodCiudad,    
                  	:pstHost->szCodComuna     :pstHostNull->sszCodComuna,    
                  	:pstHost->szNomCalle      :pstHostNull->sszNomCalle,
                  	:pstHost->szNumCalle      :pstHostNull->sszNumCalle,
                  	:pstHost->szNumPiso       :pstHostNull->sszNumPiso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3416;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodRegion);
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )4;
  sqlstm.sqindv[1] = (         short *)(pstHostNull->sszCodRegion);
  sqlstm.sqinds[1] = (         int  )sizeof(short);
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodProvincia);
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )6;
  sqlstm.sqindv[2] = (         short *)(pstHostNull->sszCodProvincia);
  sqlstm.sqinds[2] = (         int  )sizeof(short);
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodCiudad);
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )6;
  sqlstm.sqindv[3] = (         short *)(pstHostNull->sszCodCiudad);
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodComuna);
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )6;
  sqlstm.sqindv[4] = (         short *)(pstHostNull->sszCodComuna);
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szNomCalle);
  sqlstm.sqhstl[5] = (unsigned long )51;
  sqlstm.sqhsts[5] = (         int  )51;
  sqlstm.sqindv[5] = (         short *)(pstHostNull->sszNomCalle);
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szNumCalle);
  sqlstm.sqhstl[6] = (unsigned long )11;
  sqlstm.sqhsts[6] = (         int  )11;
  sqlstm.sqindv[6] = (         short *)(pstHostNull->sszNumCalle);
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szNumPiso);
  sqlstm.sqhstl[7] = (unsigned long )11;
  sqlstm.sqhsts[7] = (         int  )11;
  sqlstm.sqindv[7] = (         short *)(pstHostNull->sszNumPiso);
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }
        else
        {
		/* EXEC SQL FETCH CGeDirecciones
		INTO
		 	        :pstHost->lCodCliente,
			        :pstHost->szCodRegion     :pstHostNull->sszCodRegion,    
                  	:pstHost->szCodProvincia  :pstHostNull->sszCodProvincia, 
                  	:pstHost->szCodCiudad     :pstHostNull->sszCodCiudad,    
                  	:pstHost->szCodComuna     :pstHostNull->sszCodComuna,    
                  	:pstHost->szNomCalle      :pstHostNull->sszNomCalle,
                  	:pstHost->szNumCalle      :pstHostNull->sszNumCalle,
                  	:pstHost->szNumPiso       :pstHostNull->sszNumPiso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3463;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodRegion);
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )4;
  sqlstm.sqindv[1] = (         short *)(pstHostNull->sszCodRegion);
  sqlstm.sqinds[1] = (         int  )sizeof(short);
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodProvincia);
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )6;
  sqlstm.sqindv[2] = (         short *)(pstHostNull->sszCodProvincia);
  sqlstm.sqinds[2] = (         int  )sizeof(short);
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodCiudad);
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )6;
  sqlstm.sqindv[3] = (         short *)(pstHostNull->sszCodCiudad);
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodComuna);
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )6;
  sqlstm.sqindv[4] = (         short *)(pstHostNull->sszCodComuna);
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szNomCalle);
  sqlstm.sqhstl[5] = (unsigned long )51;
  sqlstm.sqhsts[5] = (         int  )51;
  sqlstm.sqindv[5] = (         short *)(pstHostNull->sszNomCalle);
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szNumCalle);
  sqlstm.sqhstl[6] = (unsigned long )11;
  sqlstm.sqhsts[6] = (         int  )11;
  sqlstm.sqindv[6] = (         short *)(pstHostNull->sszNumCalle);
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szNumPiso);
  sqlstm.sqhstl[7] = (unsigned long )11;
  sqlstm.sqhsts[7] = (         int  )11;
  sqlstm.sqindv[7] = (         short *)(pstHostNull->sszNumPiso);
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }

	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeCoUnipac
*******************************************************************************/

int  ifnOraLeerGeCoUnipac(UNIPAC_HOST *pstHost,long *plNumFilas,sql_context ctx,long clieini,long cliefin)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if (cliefin !=0)
	{
		/* EXEC SQL FETCH CGeCoUnipacR
		INTO
			:pstHost->lCodCliente,
			:pstHost->szCodBanco; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3510;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodBanco);
  sqlstm.sqhstl[1] = (unsigned long )16;
  sqlstm.sqhsts[1] = (         int  )16;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }
        else
        {
		/* EXEC SQL FETCH CGeCoUnipac
		INTO
			:pstHost->lCodCliente,
			:pstHost->szCodBanco; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )3533;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodCliente);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodBanco);
  sqlstm.sqhstl[1] = (unsigned long )16;
  sqlstm.sqhsts[1] = (         int  )16;
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
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


        }

	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion		:     	ifnOraLeerGeOficina
*******************************************************************************/

int  ifnOraLeerGeOficina(OFICINA_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodOficina  	IS STRING (3) ; */ 

	/* EXEC SQL VAR pstHost->szCodRegion 	IS STRING (4) ; */ 

	/* EXEC SQL VAR pstHost->szCodProvincia 	IS STRING (6) ; */ 

	/* EXEC SQL VAR pstHost->szCodCiudad     	IS STRING (6) ; */ 

	/* EXEC SQL VAR pstHost->szCodPlaza     	IS STRING (6) ; */ 


	/* EXEC SQL FETCH CGeOficina
		INTO
		:pstHost->szCodOficina	,
		:pstHost->szCodRegion	,
		:pstHost->szCodProvincia,
		:pstHost->szCodCiudad 	,
		:pstHost->szCodPlaza	; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3556;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraLeerGeFactCobr
*******************************************************************************/

int  ifnOraLeerGeFactCobr(FACTCOBR_HOST *pstHost,long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL FETCH CGeFactCobr
  		INTO
  		:pstHost->iCodConcFact,
		:pstHost->iCodConCobr; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )30000;
 sqlstm.offset = (unsigned int  )3591;
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
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}
/******************************************************************************
Funcion		:     	ifnOraLeerDetPlanDesc
*******************************************************************************/

int  ifnOraLeerDetPlanDesc(DETPLANDESC_HOST *pstHost,DETPLANDESC_HOST_NULL *pstHostNull, long *plNumFilas,sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL VAR pstHost->szCodPlan 			IS STRING (6) ; */ 

	/* EXEC SQL VAR pstHost->szDesPlandesc     	IS STRING (31); */ 

    /* EXEC SQL VAR pstHost->szFecDesdePlandesc	IS STRING (15); */ 

    /* EXEC SQL VAR pstHost->szFecHastaPlandesc	IS STRING (15); */ 

    /* EXEC SQL VAR pstHost->szIndRestriccion  	IS STRING (2) ; */ 

    /* EXEC SQL VAR pstHost->szFecDesdeDetplan 	IS STRING (15); */ 

    /* EXEC SQL VAR pstHost->szFecHastaDetplan 	IS STRING (15); */ 

    /* EXEC SQL VAR pstHost->szCodTipeval      	IS STRING (2) ; */ 

    /* EXEC SQL VAR pstHost->szCodTipapli      	IS STRING (2) ; */ 

    /* EXEC SQL VAR pstHost->szTipUnidad      		IS STRING (3) ; */ 


  	/* EXEC SQL FETCH Cur_DetPlanDesc
  			  INTO :pstHost->szCodPlan ,
				   :pstHost->szDesPlandesc     	,
    			   :pstHost->szFecDesdePlandesc	,
    			   :pstHost->szFecHastaPlandesc	,
    			   :pstHost->szIndRestriccion  	,
    			   :pstHost->szFecDesdeDetplan 	,
    			   :pstHost->szFecHastaDetplan 	,
    			   :pstHost->szCodTipeval      	,
    			   :pstHost->szCodTipapli      	,
    			   :pstHost->iCodGrupoeval :pstHostNull->i_shCodGrupoeval ,
    			   :pstHost->iCodGrupoapli :pstHostNull->i_shCodGrupoapli  ,
    			   :pstHost->iNumCuadrante :pstHostNull->i_shNumCuadrante ,
    			   :pstHost->szTipUnidad   		,
    			   :pstHost->iCodConcdesc 	:pstHostNull->i_shCodConcdesc ,
    			   :pstHost->dMtoMinfact  	:pstHostNull->i_shMtoMinfact ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 33;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )30000;
   sqlstm.offset = (unsigned int  )3614;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodPlan);
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )6;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesPlandesc);
   sqlstm.sqhstl[1] = (unsigned long )31;
   sqlstm.sqhsts[1] = (         int  )31;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szFecDesdePlandesc);
   sqlstm.sqhstl[2] = (unsigned long )15;
   sqlstm.sqhsts[2] = (         int  )15;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szFecHastaPlandesc);
   sqlstm.sqhstl[3] = (unsigned long )15;
   sqlstm.sqhsts[3] = (         int  )15;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szIndRestriccion);
   sqlstm.sqhstl[4] = (unsigned long )2;
   sqlstm.sqhsts[4] = (         int  )2;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szFecDesdeDetplan);
   sqlstm.sqhstl[5] = (unsigned long )15;
   sqlstm.sqhsts[5] = (         int  )15;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqharc[5] = (unsigned long  *)0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szFecHastaDetplan);
   sqlstm.sqhstl[6] = (unsigned long )15;
   sqlstm.sqhsts[6] = (         int  )15;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqharc[6] = (unsigned long  *)0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szCodTipeval);
   sqlstm.sqhstl[7] = (unsigned long )2;
   sqlstm.sqhsts[7] = (         int  )2;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqharc[7] = (unsigned long  *)0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->szCodTipapli);
   sqlstm.sqhstl[8] = (unsigned long )2;
   sqlstm.sqhsts[8] = (         int  )2;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqharc[8] = (unsigned long  *)0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->iCodGrupoeval);
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )sizeof(int);
   sqlstm.sqindv[9] = (         short *)(pstHostNull->i_shCodGrupoeval);
   sqlstm.sqinds[9] = (         int  )sizeof(short);
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqharc[9] = (unsigned long  *)0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->iCodGrupoapli);
   sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[10] = (         int  )sizeof(int);
   sqlstm.sqindv[10] = (         short *)(pstHostNull->i_shCodGrupoapli);
   sqlstm.sqinds[10] = (         int  )sizeof(short);
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqharc[10] = (unsigned long  *)0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->iNumCuadrante);
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )sizeof(int);
   sqlstm.sqindv[11] = (         short *)(pstHostNull->i_shNumCuadrante);
   sqlstm.sqinds[11] = (         int  )sizeof(short);
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqharc[11] = (unsigned long  *)0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->szTipUnidad);
   sqlstm.sqhstl[12] = (unsigned long )3;
   sqlstm.sqhsts[12] = (         int  )3;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqharc[12] = (unsigned long  *)0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->iCodConcdesc);
   sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[13] = (         int  )sizeof(int);
   sqlstm.sqindv[13] = (         short *)(pstHostNull->i_shCodConcdesc);
   sqlstm.sqinds[13] = (         int  )sizeof(short);
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqharc[13] = (unsigned long  *)0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->dMtoMinfact);
   sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[14] = (         int  )sizeof(double);
   sqlstm.sqindv[14] = (         short *)(pstHostNull->i_shMtoMinfact);
   sqlstm.sqinds[14] = (         int  )sizeof(short);
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqharc[14] = (unsigned long  *)0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode==SQL_OK)
		*plNumFilas = TAM_HOST;
	else
		if (sqlca.sqlcode==NOT_FOUND)
			*plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

	return sqlca.sqlcode;
}

/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion		:     	ifnOraCerrarFacClientes
*******************************************************************************/

int ifnOraCerrarFacClientes(sql_context ctx, long clieini, long cliefin)
{
        struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if(cliefin!=0)
	{
		/* EXEC SQL CLOSE CFacClientesR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3689;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL CLOSE CFacClientes; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3704;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

        return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarFacCiclo
*******************************************************************************/

int ifnOraCerrarFacCiclo(sql_context ctx, long clieini, long cliefin)
{
        struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if(cliefin!=0)
	{
		/* EXEC SQL CLOSE CFacCicloR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3719;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL CLOSE CFacCiclo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3734;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

        return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCargos
*******************************************************************************/

int ifnOraCerrarGeCargos(sql_context ctx,long ci,long cf)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if(cf!=0)
	{
		/* EXEC SQL CLOSE CGeCargosR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3749;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL CLOSE CGeCargos; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3764;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCargosRecurrentes
*******************************************************************************/

int ifnOraCerrarGeCargosRecurrentes(sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


		/* EXEC SQL CLOSE CGeCargosRecurrentes; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3779;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	
	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCabCuotas
*******************************************************************************/

int ifnOraCerrarGeCabCuotas (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeCabCuotas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3794;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeTaConcepFact
*******************************************************************************/

int ifnOraCerrarGeTaConcepFact (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeTaConcepFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3809;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeConceptos
*******************************************************************************/

int ifnOraCerrarGeConceptos (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeConceptos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3824;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeConceptos_Mi
*******************************************************************************/

int ifnOraCerrarGeConceptos_Mi (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeConceptos_Mi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3839;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeRangoTabla
*******************************************************************************/

int ifnOraCerrarGeRangoTabla (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeRangoTabla; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3854;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeLimCreditos
*******************************************************************************/

int ifnOraCerrarGeLimCreditos (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeLimCreditos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3869;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeActividades
*******************************************************************************/

int ifnOraCerrarGeActividades (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeActividades; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3884;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeProvincias
*******************************************************************************/

int ifnOraCerrarGeProvincias (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeProvincias; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3899;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeRegiones
*******************************************************************************/

int ifnOraCerrarGeRegiones (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeRegiones; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3914;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCatImpositiva
*******************************************************************************/

int ifnOraCerrarGeCatImpositiva (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeCatImpositiva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3929;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeZonaCiudad
*******************************************************************************/

int ifnOraCerrarGeZonaCiudad (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeZonaCiudad; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3944;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeZonaImpositiva
*******************************************************************************/

int ifnOraCerrarGeZonaImpositiva (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeZonaImpositiva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3959;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeImpuestos
*******************************************************************************/

int ifnOraCerrarGeImpuestos (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeImpuestos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3974;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeTipImpues
*******************************************************************************/
/*
int ifnOraCerrarGeTipImpues (sql_context ctx)
{
	struct sqlca sqlca;
        EXEC SQL CONTEXT USE :ctx;

	EXEC SQL CLOSE CGeTipImpues;

	return sqlca.sqlcode;
}
*/
/******************************************************************************
Funcion		:     	ifnOraCerrarGeGrpSerConc
*******************************************************************************/

int ifnOraCerrarGeGrpSerConc (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeGrpSerConc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3989;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeConversion
*******************************************************************************/

int ifnOraCerrarGeConversion (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeConversion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4004;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeDocumSucursal
*******************************************************************************/

int ifnOraCerrarGeDocumSucursal (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeDocumSucursal; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4019;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeLetras
*******************************************************************************/

int ifnOraCerrarGeLetras (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeLetras; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4034;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeGrupoCob
*******************************************************************************/

int ifnOraCerrarGeGrupoCob (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeGrupoCob; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4049;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeTarifas
*******************************************************************************/

int ifnOraCerrarGeTarifas (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeTarifas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4064;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeActuaServ
*******************************************************************************/

int ifnOraCerrarGeActuaServ (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeActuaServ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4079;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCuotas
*******************************************************************************/

int ifnOraCerrarGeCuotas (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeCuotas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4094;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeFactCarriers
*******************************************************************************/

int ifnOraCerrarGeFactCarriers (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeFactCarriers; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4109;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCuadCtoPlan
*******************************************************************************/

int ifnOraCerrarGeCuadCtoPlan (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeCuadCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4124;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCtoPlan
*******************************************************************************/

int ifnOraCerrarGeCtoPlan (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4139;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGePlanCtoPlan
*******************************************************************************/

int ifnOraCerrarGePlanCtoPlan (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGePlanCtoPlan; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4154;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeArriendo
*******************************************************************************/

int ifnOraCerrarGeArriendo (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeArriendo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4169;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCargosBasico
*******************************************************************************/

int ifnOraCerrarGeCargosBasico (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeCargosBasico; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4184;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeOptimo
*******************************************************************************/

int ifnOraCerrarGeOptimo (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeOptimo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4199;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeFeriados
*******************************************************************************/

int ifnOraCerrarGeFeriados (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeFeriados; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4214;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGePlanTarif
*******************************************************************************/

int ifnOraCerrarGePlanTarif (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGePlanTarif; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4229;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGePenalizaciones
*******************************************************************************/

int ifnOraCerrarGePenalizaciones (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGePenalizaciones; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4244;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCatImpClientes
*******************************************************************************/

int  ifnOraCerrarGeCatImpClientes(sql_context ctx,long clieini,long cliefin)

{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if(cliefin!=0)
	{
		/* EXEC SQL CLOSE CGeCatImpClientesR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4259;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL CLOSE CGeCatImpClientes; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4274;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeDirecciones
*******************************************************************************/

int ifnOraCerrarGeDirecciones (sql_context ctx,long clieini,long cliefin)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if(cliefin!=0)
	{
		/* EXEC SQL CLOSE CGeDireccionesR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4289;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL CLOSE CGeDirecciones; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4304;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeCoUnipac
*******************************************************************************/

int ifnOraCerrarGeCoUnipac (sql_context ctx,long clieini,long cliefin)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	if(cliefin!=0)
	{
		/* EXEC SQL CLOSE CGeCoUnipacR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4319;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
		/* EXEC SQL CLOSE CGeCoUnipac; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )4334;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}


	}

	return sqlca.sqlcode;
}

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion		:     	ifnOraCerrarGeOficina
*******************************************************************************/

int ifnOraCerrarGeOficina (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeOficina; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4349;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarGeFactCobr
*******************************************************************************/

int ifnOraCerrarGeFactCobr (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE CGeFactCobr; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4364;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}

/******************************************************************************
Funcion		:     	ifnOraCerrarDetPlanDesc
*******************************************************************************/

int ifnOraCerrarDetPlanDesc (sql_context ctx)
{
	struct sqlca sqlca;
        /* EXEC SQL CONTEXT USE :ctx; */ 


	/* EXEC SQL CLOSE Cur_DetPlanDesc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )4379;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&ctx, &sqlctx, &sqlstm, &sqlfpn);
}



	return sqlca.sqlcode;
}
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/


