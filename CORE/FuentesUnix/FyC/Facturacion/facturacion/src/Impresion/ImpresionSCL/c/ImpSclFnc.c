
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
    "./pc/ImpSclFnc.pc"
};


static unsigned int sqlctx = 6915283;


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
   unsigned char  *sqhstv[53];
   unsigned long  sqhstl[53];
            int   sqhsts[53];
            short *sqindv[53];
            int   sqinds[53];
   unsigned long  sqharm[53];
   unsigned long  *sqharc[53];
   unsigned short  sqadto[53];
   unsigned short  sqtdso[53];
} sqlstm = {12,53};

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

 static const char *sq0024 = 
"select PROC.COD_ESTAPREC ,NVL(TRAZ.COD_ESTAPROC,:b0)  from FA_TRAZAPROC TRAZ\
 ,(select A.COD_PROCESO COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A.COD_PROCPREC\
 COD_PROCPREC ,C.DES_PROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_ESTAPREC  from F\
A_PROCFACTPREC A ,FA_PROCFACT B ,FA_PROCFACT C where ((A.COD_PROCESO=:b1 and A\
.COD_PROCESO=B.COD_PROCESO) and A.COD_PROCPREC=C.COD_PROCESO)) PROC where ((TR\
AZ.COD_CICLFACT(+)=:b2 and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) and (TRAZ.HO\
ST_ID=:b3 or 1<>:b4)) order by PROC.COD_PROCESO            ";

 static const char *sq0025 = 
"select PROC.COD_ESTAPREC ,NVL(TRAZ.COD_ESTAPROC,:b0)  from FA_TRAZAPROC TRAZ\
 ,(select A.COD_PROCESO COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A.COD_PROCPREC\
 COD_PROCPREC ,C.DES_PROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_ESTAPREC  from F\
A_PROCFACTPREC A ,FA_PROCFACT B ,FA_PROCFACT C where ((A.COD_PROCESO=:b1 and A\
.COD_PROCESO=B.COD_PROCESO) and A.COD_PROCPREC=C.COD_PROCESO)) PROC where (TRA\
Z.COD_CICLFACT(+)=:b2 and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) order by PROC\
.COD_PROCESO            ";

 static const char *sq0002 = 
"select DESC_MENSLIN  from FA_MENSPROCESO A ,FA_MENSAJES B where (A.NUM_PROCE\
SO=:b0 and A.CORR_MENSAJE=B.CORR_MENSAJE) order by A.CORR_MENSAJE,B.NUM_LINEA \
           ";

 static const char *sq0003 = 
"select COD_CLIENTE ,COD_ABONADO ,COD_BOLSA ,VAL_BOLSA ,IND_UNIDAD ,VAL_ARRAS\
TRE ,VAL_EXPIRADO ,VAL_DISPONIBLE ,VAL_CONSUMO ,VAL_RESTO ,(SUBSTR(TO_CHAR(COD\
_CLIENTE,:b0),2)||SUBSTR(TO_CHAR(COD_ABONADO,:b0),2))  from TOL_HDARRASTRE_TH \
where COD_CICLFACT=:b2 order by COD_CLIENTE,COD_ABONADO            ";

 static const char *sq0040 = 
"select A.COD_PLAN ,((B.CON_CLIENTE||B.COD_THOR)||B.COD_TDIR) ,A.MTO_ADIC  fr\
om TOL_ESTCOBRO A ,TOL_AGRULLAM B where ((((((((A.COD_OPERADOR>' ' and A.COD_P\
LAN>' ') and A.COD_AGRULLAM=B.COD_AGRULLAM) and B.COD_LLAM='LOC') and B.COD_SE\
NTIDO='S') and A.COD_TDIA='1') and B.CON_CLIENTE in ('HM','VI')) and B.COD_THO\
R in ('O','N')) and B.COD_TDIR in ('PP','PPR')) order by A.COD_PLAN,B.CON_CLIE\
NTE,B.COD_THOR,B.COD_TDIR            ";

 static const char *sq0041 = 
"select distinct A.COD_CLIENTE ,NVL(A.NOM_APODERADO,'.') ,NVL(D.COD_SERVICIO,\
'1') ,NVL(A.COD_SISPAGO,1) ,NVL(B.COD_COURRIER,' ') ,NVL(B.COD_ZONACOURRIER,' \
')  from GE_CLIENTES A ,(select distinct COD_CLIENTE ,COD_CICLO ,COD_COURRIER \
,COD_ZONACOURRIER  from FA_CICLOCLI where (COD_COURRIER is  not null  or COD_Z\
ONACOURRIER is  not null )) B ,FA_CICLFACT C ,FAD_IMPSERVCLIE D where (((C.COD\
_CICLFACT=:b0 and C.COD_CICLO=B.COD_CICLO) and B.COD_CLIENTE=A.COD_CLIENTE) an\
d A.COD_CLIENTE=D.COD_CLIENTE(+))           ";

 static const char *sq0049 = 
"select POSICION ,COD_REGISTRO ,TIP_REGISTRO ,VALOR  from FA_REGDETLLAM_TD  o\
rder by POSICION asc             ";

 static const char *sq0050 = 
"select COD_PLANTARIF ,DES_PLANTARIF ,NUM_UNIDADES ,IMP_CARGOBASICO ,IND_ARRA\
STRE ,COD_PRESTACION  from TA_PLANTARIF A ,TA_CARGOSBASICO B where (((A.COD_PR\
ODUCTO=1 and A.COD_CARGOBASICO=B.COD_CARGOBASICO) and A.COD_PRODUCTO=B.COD_PRO\
DUCTO) and (B.FEC_HASTA is null  or B.FEC_HASTA>TRUNC(SYSDATE)))           ";

 static const char *sq0051 = 
"select (substr(TO_CHAR(TO_NUMBER(substr(C.COD_CONCEPTO,1,4)),'0009'),2)||C.C\
OD_IDIOMA) CONCEPTO ,substr(B.DES_CONCEPTO,1,50) ,substr(C.DES_CONCEPTO,1,50) \
 from FAD_IMPSUBGRUPOS A ,GE_MULTIIDIOMA B ,GE_MULTIIDIOMA C where ((((((TO_CH\
AR(A.COD_GRUPO)=B.COD_CONCEPTO and B.NOM_TABLA='FAD_IMPGRUPOS') and B.NOM_CAMP\
O='COD_GRUPOS') and TO_CHAR(A.COD_SUBGRUPO)=C.COD_CONCEPTO) and C.NOM_TABLA='F\
AD_IMPSUBGRUPOS') and C.NOM_CAMPO='COD_SUBGRUPO') and B.COD_IDIOMA=C.COD_IDIOM\
A) order by CONCEPTO            ";

 static const char *sq0052 = 
"select C.NUM_ORDEN GRP ,B.NUM_ORDEN SGRP ,A.NUM_ORDEN CONC ,C.COD_GRUPO ,B.C\
OD_SUBGRUPO ,A.COD_CONCEPTO ,NVL(B.COD_REGISTRO,'D3001') ,NVL(B.CRIT_ORDEN,0) \
,NVL(B.COD_TIPLLAMADA,0) ,B.COD_TIPSUBGRUPO  from FAD_IMPCONCEPTOS A ,FAD_IMPS\
UBGRUPOS B ,FAD_IMPGRUPOS C where (((A.COD_CONCEPTO>0 and A.COD_SUBGRUPO=B.COD\
_SUBGRUPO) and B.COD_GRUPO=C.COD_GRUPO) and C.COD_FORMULARIO=:b0) order by A.C\
OD_CONCEPTO            ";

 static const char *sq0055 = 
"select val_numerico  from FAD_PARAMETROS where COD_PARAMETRO=:b0           ";

 static const char *sq0057 = 
"select distinct A.COD_CONCGENE ,B.COD_CATEIMP ,A.PRC_IMPUESTO ,A.COD_TIPIMPU\
ES  from GE_IMPUESTOS A ,GE_TIPIMPUES B where A.COD_TIPIMPUES=B.COD_TIPIMPUE o\
rder by A.COD_CONCGENE asc             ";

 static const char *sq0001 = 
"select MONTO ,TO_CHAR(FECHA,'YYYYMMDD') ,DESCRIPCION ,NVL(DES_TIPVALOR,'NO R\
EGISTRADO') ,NVL(A.TIP_PAGO,0) ,NVL(COD_OPERADORA,' ') ,NVL(COD_TIPDOCUM,0)  f\
rom CO_ULTPAGO_TT A ,CO_TIPVALOR B where ((B.TIP_VALOR(+)=A.COD_MODPAGO and CO\
D_CLIENTE=:b0) and COD_CICLFACT=:b1)           ";

 static const char *sq0058 = 
"select COD_TIPIMPUE ,DES_TIPIMPUE  from GE_TIPIMPUES  order by COD_TIPIMPUE \
asc             ";

 static const char *sq0060 = 
"select B.COD_PLAN ,A.COD_THOR ,B.SEG_INIC ,B.SEG_ADIC ,B.MTO_MIN ,B.MTO_ADIC\
  from TOL_AGRULLAM A ,TOL_ESTCOBRO B where (((((((((((((A.COD_SENTIDO='S' and\
 A.COD_LLAM=:b0) and A.COD_TDIR=:b1) and A.COD_THOR in (:b2,:b3,:b4)) and A.CO\
N_CLIENTE=:b5) and A.FEC_INI_VIG<=SYSDATE) and A.FEC_TER_VIG>=SYSDATE) and B.C\
OD_OPERADOR=:b6) and B.COD_PLAN<>' ') and B.COD_AGRULLAM=A.COD_AGRULLAM) and B\
.COD_TDIA=:b7) and B.COD_SFRAN=:b8) and B.FEC_INI_VIG<=SYSDATE) and B.FEC_TER_\
VIG>=SYSDATE)           ";

 static const char *sq0062 = 
"select COD_OPERADOR ,DES_OPERADOR  from TA_OPERADORES            ";

 static const char *sq0004 = 
"select A.COD_OPERADORA ,A.COD_OFICINA ,A.COD_TIPDOCUM ,B.DES_TIPDOCUM ,A.PRE\
F_PLAZA ,A.NUM_FOLIO ,TO_CHAR(A.FEC_EMISION,'YYYYMMDD') ,A.TOT_FACTURA  from F\
A_HISTDOCU A ,GE_TIPDOCUMEN B where (((A.COD_TIPDOCUM=B.COD_TIPDOCUM and A.COD\
_CLIENTE=:b0) and A.FEC_EMISION>=TO_DATE(:b1,'YYYYMMDD')) and A.FEC_EMISION<=(\
TO_DATE(:b2,'YYYYMMDD')+1))           ";

 static const char *sq0065 = 
"select A.NUM_SERIE ,A.NUM_ABONADO ,A.COD_CONCEPTO ,B.DES_CONCEPTO  from GE_C\
ARGOS A ,FA_CONCEPTOS B where ((A.NUM_VENTA=:b0 and A.COD_CLIENTE=:b1) and A.C\
OD_CONCEPTO=B.COD_CONCEPTO)           ";

 static const char *sq0067 = 
"select A.NUM_KIT ,D.NUM_ABONADO ,B.COD_CONCEPTO ,B.DES_CONCEPTO ,NVL(A.NUM_T\
ELEFONO,0)  from AL_COMPONENTE_KIT A ,FA_CONCEPTOS B ,AL_ARTICULOS C ,GA_EQUIP\
ABOSER D where (((((C.COD_ARTICULO=A.COD_KIT and A.NUM_SERIE=D.NUM_SERIE) and \
D.TIP_TERMINAL in (select E.VAL_PARAMETRO  from GED_PARAMETROS E where E.NOM_P\
ARAMETRO in ('TIP_DIGITAL','COD_SIMCARD_GSM'))) and D.NUM_ABONADO in (select F\
.NUM_ABONADO  from GA_ABOAMIST F where ((F.NUM_VENTA=:b0 and F.COD_CLIENTE=:b1\
) and TRUNC(F.FEC_ALTA) in (select TRUNC(G.FEC_VENTA)  from GA_VENTAS G where \
(G.NUM_VENTA=:b0 and G.COD_CLIENTE=:b1))))) and C.COD_CONCEPTOART=B.COD_CONCEP\
TO) and D.IND_PROCEQUI=:b4)           ";

 static const char *sq0068 = 
"select A.NUM_SERIE ,A.NUM_ABONADO ,B.COD_CONCEPTO ,B.DES_CONCEPTO ,D.NUM_CEL\
ULAR  from GA_EQUIPABOSER A ,FA_CONCEPTOS B ,AL_ARTICULOS C ,GA_ABOAMIST D whe\
re ((((A.NUM_ABONADO in (select D.NUM_ABONADO  from GA_ABOAMIST D where ((D.NU\
M_VENTA=:b0 and D.COD_CLIENTE=:b1) and TRUNC(D.FEC_ALTA) in (select TRUNC(E.FE\
C_VENTA)  from GA_VENTAS E where (E.NUM_VENTA=:b0 and E.COD_CLIENTE=:b1)))) an\
d C.COD_ARTICULO=A.COD_ARTICULO) and C.COD_CONCEPTOART=B.COD_CONCEPTO) and A.N\
UM_ABONADO=D.NUM_ABONADO) and A.IND_PROCEQUI=:b4)           ";

 static const char *sq0069 = 
"select A.NUM_SERIE ,A.NUM_ABONADO ,B.COD_CONCEPTO ,B.DES_CONCEPTO ,D.NUM_CEL\
ULAR  from GA_EQUIPABOSER A ,FA_CONCEPTOS B ,AL_ARTICULOS C ,GA_ABOCEL D where\
 ((((A.NUM_ABONADO in (select D.NUM_ABONADO  from GA_ABOCEL D where ((D.NUM_VE\
NTA=:b0 and D.COD_CLIENTE=:b1) and TRUNC(D.FEC_ALTA) in (select TRUNC(E.FEC_VE\
NTA)  from GA_VENTAS E where (E.NUM_VENTA=:b0 and E.COD_CLIENTE=:b1)))) and C.\
COD_ARTICULO=A.COD_ARTICULO) and C.COD_CONCEPTOART=B.COD_CONCEPTO) and A.NUM_A\
BONADO=D.NUM_ABONADO) and A.IND_PROCEQUI=:b4)           ";

 static const char *sq0070 = 
"select A.NUM_SERIE ,A.NUM_PROCESO ,A.COD_CONCEPTO ,A.COLUMNA  from FA_SERIES\
_TO A where ((A.NUM_PROCESO=:b0 and A.COD_CONCEPTO=:b1) and A.COLUMNA=:b2)    \
       ";

 static const char *sq0077 = 
"select A.NUM_ABONADO ,C.COD_ESTADO ,B.COD_PLAN ,NVL(B.DES_PLAN,' ') ,NVL(A.N\
UM_PERIODOS,:b0) ,max(C.SEC_PERIODO) ,(A.NUM_PERIODOS-max(C.SEC_PERIODO)) ,NVL\
(B.CNT_MINADIC,:b0) ,NVL(B.MTO_CARGADIC,:b0) ,NVL(A.NOM_USUARIO,' ') ,TO_CHAR(\
A.FEC_INGRESO,'YYYY-MM-DD HH24:MI:SS') ,NVL(A.VAL_ACUMULADO,:b0) ,A.COD_ESTADO\
 ,B.IND_REEVALUA ,B.TIP_BENEFICIO  from BPT_BENEFICIOS C ,BPT_BENEFICIARIOS A \
,BPD_PLANES B where (((((((((C.COD_CLIENTE=:b4 and C.COD_PLAN=B.COD_PLAN) and \
C.FEC_DESDEAPLI=B.FEC_DESDEAPLI) and A.FEC_INGRESO=C.FEC_INGRESO) and C.COD_ES\
TADO in (:b5,:b6)) and C.COD_CICLFACT=:b7) and A.COD_CLIENTE=C.COD_CLIENTE) an\
d A.NUM_ABONADO=C.NUM_ABONADO) and A.COD_PLAN=B.COD_PLAN) and A.FEC_DESDEAPLI=\
B.FEC_DESDEAPLI) group by A.NUM_ABONADO,C.COD_ESTADO,B.COD_PLAN,B.DES_PLAN,A.N\
UM_PERIODOS,B.CNT_MINADIC,B.MTO_CARGADIC,A.NOM_USUARIO,A.FEC_INGRESO,A.VAL_ACU\
MULADO,A.COD_ESTADO,B.IND_REEVALUA,B.TIP_BENEFICIO           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,5,212,0,4,98,0,0,3,1,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,
32,0,0,6,306,0,3,463,0,0,11,11,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,
91,0,0,7,0,0,29,505,0,0,0,0,0,1,0,
106,0,0,8,96,0,2,522,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
133,0,0,9,0,0,29,534,0,0,0,0,0,1,0,
148,0,0,10,122,0,4,572,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
183,0,0,11,176,0,3,583,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
218,0,0,12,0,0,29,611,0,0,0,0,0,1,0,
233,0,0,13,169,0,5,630,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
272,0,0,14,0,0,29,645,0,0,0,0,0,1,0,
287,0,0,15,184,0,5,695,0,0,7,7,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,
330,0,0,16,0,0,29,712,0,0,0,0,0,1,0,
345,0,0,17,107,0,4,754,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
376,0,0,18,152,0,5,797,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
415,0,0,19,122,0,5,808,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
446,0,0,20,0,0,29,822,0,0,0,0,0,1,0,
461,0,0,21,78,0,5,842,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
488,0,0,22,0,0,29,855,0,0,0,0,0,1,0,
503,0,0,23,153,0,4,887,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
542,0,0,24,525,0,9,982,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
577,0,0,25,490,0,9,986,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
604,0,0,24,0,0,13,1009,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
627,0,0,25,0,0,13,1013,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
650,0,0,24,0,0,15,1042,0,0,0,0,0,1,0,
665,0,0,25,0,0,15,1046,0,0,0,0,0,1,0,
680,0,0,26,153,0,4,1075,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,3,0,0,
719,0,0,27,183,0,5,1099,0,0,7,7,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,
762,0,0,28,0,0,29,1116,0,0,0,0,0,1,0,
777,0,0,2,165,0,9,1187,0,0,1,1,0,1,0,1,3,0,0,
796,0,0,2,0,0,13,1208,0,0,1,0,0,1,0,2,97,0,0,
815,0,0,2,0,0,15,1231,0,0,0,0,0,1,0,
830,0,0,29,84,0,4,1295,0,0,3,1,0,1,0,2,9,0,0,2,9,0,0,1,3,0,0,
857,0,0,30,165,0,4,1308,0,0,3,1,0,1,0,2,9,0,0,2,9,0,0,1,3,0,0,
884,0,0,31,139,0,4,1324,0,0,5,3,0,1,0,2,3,0,0,2,3,0,0,1,9,0,0,1,3,0,0,1,9,0,0,
919,0,0,32,109,0,4,1366,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
950,0,0,33,78,0,5,1381,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
977,0,0,34,0,0,29,1389,0,0,0,0,0,1,0,
992,0,0,3,299,0,9,1406,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,
1019,0,0,3,0,0,13,1427,0,0,11,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,97,0,
0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,97,0,0,
1078,0,0,3,0,0,15,1458,0,0,0,0,0,1,0,
1093,0,0,35,280,0,4,1629,0,0,7,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,
0,0,2,97,0,0,2,3,0,0,
1136,0,0,36,717,0,4,1676,0,0,6,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,
0,0,2,97,0,0,
1175,0,0,37,329,0,4,1730,0,0,3,1,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,
1202,0,0,38,167,0,4,1761,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
1225,0,0,39,0,0,17,1994,0,0,1,1,0,1,0,1,97,0,0,
1244,0,0,39,0,0,45,2024,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1279,0,0,39,0,0,45,2035,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1306,0,0,39,0,0,13,2166,0,0,53,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,4,0,0,2,97,0,
0,2,97,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,97,0,0,2,4,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,4,0,0,
2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,
1533,0,0,39,0,0,15,2302,0,0,0,0,0,1,0,
1548,0,0,40,425,0,9,2334,0,0,0,0,0,1,0,
1563,0,0,40,0,0,13,2359,0,0,3,0,0,1,0,2,9,0,0,2,9,0,0,2,4,0,0,
1590,0,0,40,0,0,15,2393,0,0,0,0,0,1,0,
1605,0,0,41,510,0,9,2685,0,0,1,1,0,1,0,1,3,0,0,
1624,0,0,41,0,0,13,2698,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,
0,2,97,0,0,
1663,0,0,41,0,0,15,2722,0,0,0,0,0,1,0,
1678,0,0,42,564,0,4,2810,0,0,9,2,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,5,0,
0,2,5,0,0,2,5,0,0,1,3,0,0,1,97,0,0,
1729,0,0,43,134,0,4,2896,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
1752,0,0,44,138,0,4,2918,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
1775,0,0,45,140,0,4,2940,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
1798,0,0,46,83,0,4,2984,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
1821,0,0,47,0,0,17,3079,0,0,1,1,0,1,0,1,97,0,0,
1840,0,0,47,0,0,45,3102,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,
1867,0,0,47,0,0,45,3106,0,0,4,4,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1898,0,0,47,0,0,13,3118,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
1921,0,0,48,251,0,4,3178,0,0,7,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,1,3,0,0,
1964,0,0,49,109,0,9,3304,0,0,0,0,0,1,0,
1979,0,0,49,0,0,13,3323,0,0,4,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2010,0,0,49,0,0,15,3357,0,0,0,0,0,1,0,
2025,0,0,50,307,0,9,3387,0,0,0,0,0,1,0,
2040,0,0,50,0,0,13,3399,0,0,6,0,0,1,0,2,97,0,0,2,97,0,0,2,3,0,0,2,4,0,0,2,3,0,
0,2,97,0,0,
2079,0,0,50,0,0,15,3421,0,0,0,0,0,1,0,
2094,0,0,51,498,0,9,3692,0,0,0,0,0,1,0,
2109,0,0,51,0,0,13,3713,0,0,3,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,
2136,0,0,51,0,0,15,3742,0,0,0,0,0,1,0,
2151,0,0,52,411,0,9,3933,0,0,1,1,0,1,0,1,3,0,0,
2170,0,0,52,0,0,13,3954,0,0,10,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2225,0,0,52,0,0,15,3990,0,0,0,0,0,1,0,
2240,0,0,53,0,0,17,4140,0,0,1,1,0,1,0,1,97,0,0,
2259,0,0,53,0,0,45,4164,0,0,1,1,0,1,0,1,3,0,0,
2278,0,0,53,0,0,13,4186,0,0,8,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,3,0,0,
2325,0,0,53,0,0,15,4216,0,0,0,0,0,1,0,
2340,0,0,54,148,0,6,4243,0,0,3,3,0,1,0,2,97,0,0,1,3,0,0,1,97,0,0,
2367,0,0,55,75,0,9,4277,0,0,1,1,0,1,0,1,3,0,0,
2386,0,0,55,0,0,13,4286,0,0,1,0,0,1,0,2,3,0,0,
2405,0,0,56,118,0,4,4409,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2436,0,0,57,193,0,9,4452,0,0,0,0,0,1,0,
2451,0,0,57,0,0,13,4462,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,
2482,0,0,1,279,0,9,4841,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
2505,0,0,1,0,0,13,4853,0,0,7,0,0,1,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,
0,2,97,0,0,2,3,0,0,
2548,0,0,1,0,0,15,4877,0,0,0,0,0,1,0,
2563,0,0,58,92,0,9,4995,0,0,0,0,0,1,0,
2578,0,0,58,0,0,13,5010,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
2601,0,0,58,0,0,15,5063,0,0,0,0,0,1,0,
2616,0,0,59,0,0,17,5126,0,0,1,1,0,1,0,1,97,0,0,
2635,0,0,59,0,0,45,5145,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
2658,0,0,59,0,0,13,5154,0,0,1,0,0,1,0,2,4,0,0,
2677,0,0,60,490,0,9,5296,0,0,9,9,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
2728,0,0,60,0,0,13,5308,0,0,6,0,0,1,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,4,0,
0,2,4,0,0,
2767,0,0,60,0,0,15,5332,0,0,0,0,0,1,0,
2782,0,0,61,52,0,4,5423,0,0,1,0,0,1,0,2,3,0,0,
2801,0,0,62,65,0,9,5522,0,0,0,0,0,1,0,
2816,0,0,62,0,0,13,5536,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
2839,0,0,62,0,0,15,5555,0,0,0,0,0,1,0,
2854,0,0,4,348,0,9,5704,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
2881,0,0,4,0,0,13,5716,0,0,8,0,0,1,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,2,4,0,0,
2928,0,0,4,0,0,15,5748,0,0,0,0,0,1,0,
2943,0,0,63,119,0,4,5765,0,0,1,0,0,1,0,2,5,0,0,
2962,0,0,64,124,0,4,5844,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
2993,0,0,65,192,0,9,5870,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
3016,0,0,65,0,0,13,5875,0,0,4,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
3047,0,0,65,0,0,15,5909,0,0,0,0,0,1,0,
3062,0,0,66,303,0,4,5914,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,
3101,0,0,67,660,0,9,5965,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
3136,0,0,67,0,0,13,5970,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
3171,0,0,67,0,0,15,6008,0,0,0,0,0,1,0,
3186,0,0,68,526,0,9,6040,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
3221,0,0,68,0,0,13,6045,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
3256,0,0,68,0,0,15,6084,0,0,0,0,0,1,0,
3271,0,0,69,522,0,9,6119,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
3306,0,0,69,0,0,13,6123,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
3341,0,0,69,0,0,15,6159,0,0,0,0,0,1,0,
3356,0,0,70,161,0,9,6219,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
3383,0,0,70,0,0,13,6224,0,0,4,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
3414,0,0,70,0,0,15,6263,0,0,0,0,0,1,0,
3429,0,0,71,373,0,4,6307,0,0,4,2,0,1,0,2,4,0,0,2,4,0,0,1,3,0,0,1,3,0,0,
3460,0,0,72,413,0,4,6332,0,0,5,3,0,1,0,2,4,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
3495,0,0,73,139,0,4,6376,0,0,3,2,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,
3522,0,0,74,179,0,4,6393,0,0,4,3,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
3553,0,0,75,209,0,4,6455,0,0,5,4,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
3588,0,0,76,50,0,4,6552,0,0,1,0,0,1,0,2,3,0,0,
3607,0,0,77,917,0,9,6660,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,5,0,0,1,3,0,0,
3654,0,0,77,0,0,13,6669,0,0,15,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,
3729,0,0,77,0,0,15,6733,0,0,0,0,0,1,0,
};


/*  Version  FAC_DES_MAS ImpSclFnc.pc  7.000   */

#include <ImpSclFnc.h>
#include <math.h>

/*     EXEC SQL INCLUDE sqlca;
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

    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhNumAbonado       ;
         long lhCodCilclFact     ;
         long lhIndOrdentotal    ;
         char szhStrCodCliente[9];
         long lhCodCliente       ;
         char szhFecDesde    [10];
         char szhFecHasta    [10];
    /* EXEC SQL END DECLARE SECTION ; */ 


    /* EXEC SQL
        DECLARE curPagos CURSOR FOR
            SELECT
                MONTO,
                TO_CHAR(FECHA, 'YYYYMMDD'),
                DESCRIPCION,
                NVL(DES_TIPVALOR, 'NO REGISTRADO'),
                NVL(A.TIP_PAGO,0),
                NVL(COD_OPERADORA,' '),
                NVL(COD_TIPDOCUM,0)    
            FROM
                CO_ULTPAGO_TT A,
                CO_TIPVALOR B
            WHERE
                B.TIP_VALOR (+)=  A.COD_MODPAGO
                AND COD_CLIENTE = :lhCodCliente
                AND COD_CICLFACT = :lhCodCilclFact; */ 


    /* EXEC SQL DECLARE curMensNoCiclo CURSOR FOR
                SELECT DESC_MENSLIN
                  FROM FA_MENSPROCESO A,
                       FA_MENSAJES B
                 WHERE A.NUM_PROCESO = :lhNumAbonado
                   AND A.CORR_MENSAJE = B.CORR_MENSAJE
                 ORDER BY A.CORR_MENSAJE,B.NUM_LINEA; */ 


    /* EXEC SQL DECLARE curArrastre CURSOR FOR
                SELECT  COD_CLIENTE ,
                        COD_ABONADO ,
                        COD_BOLSA  ,
                        VAL_BOLSA,
                        IND_UNIDAD,
                        VAL_ARRASTRE,
                        VAL_EXPIRADO,
                        VAL_DISPONIBLE,
                        VAL_CONSUMO,
                        VAL_RESTO,
                        SUBSTR(TO_CHAR(COD_CLIENTE, :szhStrCodCliente),2)||SUBSTR(TO_CHAR(COD_ABONADO, :szhStrCodCliente),2)
                        FROM  TOL_HDARRASTRE_TH
                        WHERE COD_CICLFACT = :lhCodCilclFact
                        ORDER BY COD_CLIENTE,COD_ABONADO ; */ 


    /* EXEC SQL DECLARE curDocsPeriodo CURSOR FOR
            SELECT
                A.COD_OPERADORA,
                A.COD_OFICINA,
                A.COD_TIPDOCUM,
                B.DES_TIPDOCUM,
                A.PREF_PLAZA,
                A.NUM_FOLIO,
                TO_CHAR(A.FEC_EMISION,'YYYYMMDD'),
                A.TOT_FACTURA
            FROM
                FA_HISTDOCU A, GE_TIPDOCUMEN B
            WHERE
                A.COD_TIPDOCUM = B.COD_TIPDOCUM
                AND A.COD_CLIENTE = :lhCodCliente
                AND A.FEC_EMISION >= TO_DATE(:szhFecDesde,'YYYYMMDD')
                AND A.FEC_EMISION <= TO_DATE(:szhFecHasta,'YYYYMMDD') + 1; */ 


/*****************************************************************************************************/
/* FUNCION     : bfnBuscaNotaPedido                                                                  */
/* DESCRIPCION : Recuperar Numero de Guia y Numero Documento Pedido para impresión de Registro A1130 */
/*****************************************************************************************************/
BOOL bfnBuscaNotaPedido (long lNumProceso, char *szNumGuia, long *lNumDocPedido)
{
    char modulo[]   ="bfnBuscaNotaPedido";	
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNumProceso             ;
         char    szhNumGuia     [25+1]= ""; /* EXEC SQL VAR szhNumGuia IS STRING(25+1); */ 

         long    lhNumDocPedido       = 0L;                
    /* EXEC SQL END DECLARE SECTION; */ 

    
    vDTrazasLog(szModulo,"\n\t Entrando a Función [%s]",LOG06,szModulo);
    
    memset(szhNumGuia,0,sizeof(szhNumGuia));

    lhNumProceso = lNumProceso;
    
    /* EXEC SQL
         SELECT NVL(B.NUM_GUIA,' '),
                NVL(TO_CHAR(B.NUM_DOC_PEDIDO),' ')
         INTO   :szhNumGuia,
                :lhNumDocPedido
         FROM   GA_VENTAS A ,
                NPT_PEDIDO B,
                FA_INTERFACT C
         WHERE  A.NUM_VENTA = C.NUM_VENTA
         AND    A.NUM_VENTA = B.NUM_DOC_PEDIDO
         AND    C.NUM_PROCESO = :lhNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(B.NUM_GUIA,' ') ,NVL(TO_CHAR(B.NUM_DOC_PEDIDO)\
,' ') into :b0,:b1  from GA_VENTAS A ,NPT_PEDIDO B ,FA_INTERFACT C where ((A.N\
UM_VENTA=C.NUM_VENTA and A.NUM_VENTA=B.NUM_DOC_PEDIDO) and C.NUM_PROCESO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNumGuia;
    sqlstm.sqhstl[0] = (unsigned long )26;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumDocPedido;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProceso;
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


         
    if(SQLCODE == SQLOK)
    {
    	strcpy(szNumGuia,szhNumGuia);
    	*lNumDocPedido = lhNumDocPedido;
        return(TRUE);
    }
    else
    {
        if(SQLCODE == SQLNOTFOUND)
        {
    	    strcpy(szNumGuia,szhNumGuia);
    	    *lNumDocPedido = lhNumDocPedido;
            return(TRUE);
        }
        else
        {
            vDTrazasLog (modulo,"\n\t\t* En sentencia SELECT, Codigo: [%d]", LOG01,sqlca.sqlcode);
            return(FALSE);
        }
    }                 
}/*********************************** FIN bfnBuscaNotaPedido ***********************************/

BOOL bfnOrdenaImpresionRC (ST_TABLA_ACUM  *pstTablaAcum, ST_TABLA_ORDEN *pstTablaOrden, int iUltimaPosicion)
{
    register int i,j,x;
    char        szKeyAux[50];
    int         iSocaloAux;

    vDTrazasLog(szModulo,"bfnOrdenaImpresionRC iUltimaPosicion[%d]",LOG06,iUltimaPosicion);

    for (i=0; i<iUltimaPosicion; i++)
    {
        strcpy(pstTablaOrden->szKey[i],pstTablaAcum->szKey[i]);
        vDTrazasLog(szModulo,"bfnOrdenaImpresionRC 1[%d] 2[%s] 3[%s]"
                             ,LOG06,i,pstTablaAcum->szKey[i],pstTablaOrden->szKey[i]);
        pstTablaOrden->iSocalo[i]       = i;
    }
    x = 0;
    for (j = iUltimaPosicion; j > 0; j--)
    {
        for (i=0; i < j-1; i++)
        {
            vDTrazasLog(szModulo,"bfnOrdenaImpresionRC COMPARA1[%s] COMPARA2[%s]"
                                ,LOG06,pstTablaOrden->szKey[i],pstTablaOrden->szKey[i+1]);
            if(strcmp(pstTablaOrden->szKey[i],pstTablaOrden->szKey[i+1])>0)
            {
                strcpy(szKeyAux,pstTablaOrden->szKey[i+1]);
                iSocaloAux  = pstTablaOrden->iSocalo[i+1];
                strcpy(pstTablaOrden->szKey[i+1],pstTablaOrden->szKey[i]);
                vDTrazasLog(szModulo,"bfnOrdenaImpresionRC SOCALO2[%d]\n"
                					 "bfnOrdenaImpresionRC SOCALO3[%s]"
                					 ,LOG06,pstTablaOrden->iSocalo[i+1]
                					 ,pstTablaOrden->szKey[i+1]);

                pstTablaOrden->iSocalo[i+1]    = pstTablaOrden->iSocalo[i];
                vDTrazasLog(szModulo,"bfnOrdenaImpresionRC SOCALO4[%d]",LOG06,pstTablaOrden->iSocalo[i+1]);

                strcpy(pstTablaOrden->szKey[i],szKeyAux);
                vDTrazasLog(szModulo,"bfnOrdenaImpresionRC SOCALO5[%s]",LOG06,pstTablaOrden->szKey[i]);
                pstTablaOrden->iSocalo[i]      = iSocaloAux;
            }
        }
        x++;
    }

    return (1);
}

int CalculaDigVerif (double Inumero, int * DigVerif )
{
    int i       = 0;
    int j       = 2;
    int iDigito = 0;

    char szAux[2]   = "";
    char szNum[100] = "";
    long IValor;

    div_t stRes         ;

	if ((long)Inumero != Inumero){
    	IValor = (long)Inumero*pow(10,atoi(szNumDecimal));
        if(IValor<0){
        	IValor*=-1;
        }
        sprintf (szNum ,"%ld",IValor );
 	}
    else{
    	sprintf (szNum,"%.0f",Inumero);
	}

    i = strlen(szNum)-1;

    while (i >= 0)
    {
    	if (j <= 0)
        	j  = 2;
		strncpy (szAux, &szNum [i], 1);
        iDigito += (atoi (szAux) * j);
        j--;
        i--;
	}

    stRes = div (iDigito, 10);
	if (stRes.rem == 0)
    	*DigVerif = 0;
	else
    	*DigVerif = 10 - stRes.rem;

return (1);

}/**************************** Final CalculaDigVerif **********************/

BOOL bEscribeEnArchivo(FILE *Fd_ArchImp, char * zsBuffImpArch, char * buffer_local)
{
    int rc = 0;

    strcpy (szModulo, "bEscribeEnArchivo");
    
    vDTrazasLog(szModulo,"\n\t Entrando a Función [%s]"
                             ,LOG06,szModulo);

    if(strncmp(buffer_local,FLUSH,strlen(FLUSH))==0)
    {
        if(strlen(zsBuffImpArch)>0)
        {
            rc = fputs(zsBuffImpArch,Fd_ArchImp);
            fflush(Fd_ArchImp);
            if(rc<=0)
            {
                vDTrazasLog(szModulo,"\n\t Error en fputs() Archivo Salida [%s]",LOG06,szModulo);            	
                return(FALSE);
            }
            memset(zsBuffImpArch,0,sizeof(zsBuffImpArch));
        }
    }
    else
    {
        if((strlen(buffer_local) + strlen(zsBuffImpArch)) < MAX_BYTES_BUFFER_IMP)
        {
            strcat(zsBuffImpArch,buffer_local);
        }
        else
        {
            rc = fputs(zsBuffImpArch,Fd_ArchImp);
            fflush(Fd_ArchImp);
            if(rc<=0){
                vDTrazasLog(szModulo,"\n\t bEscribeEnArchivo RETORNO ERROR",LOG02);
                return(FALSE);
            }
            memset(zsBuffImpArch,0,sizeof(zsBuffImpArch));
            strcpy(zsBuffImpArch,buffer_local);
        }
    }

    if (stStatus.LogNivel >= LOG06)
    {
        fflush(stStatus.LogFile);
    	fflush(stStatus.ErrFile);
	}
	
	return (1);
}
/****************** Final bEscribeEnArchivo *******************/

int FillCodIdioma(char *dat)
{
    int i;
    char aux[5+1];
    sprintf(aux,"%-5.5s\0",dat);
    for(i=0;i<strlen(aux);i++)
    {
    	if(aux[i]==' ')
    	{
        	aux[i]='0';
        }
    }
    sprintf(dat,"%5.5s\0",aux);
    return(0);
}

int RetPos(char *Cadena, ST_TABLA  *Tabla)
{
    int i;

    for(i=0; i<Tabla->iLastPosition; i++)
    {
        if (!strcmp (Tabla->szDes[i], Cadena))
                        return (Tabla->iPosition[i]);
    }
    strcpy(Tabla->szDes[i],Cadena);
    Tabla->iPosition[i]  = i;
    Tabla->iLastPosition = i + 1;

    return(i);

}/**************************** Final RetPos **********************/

int FormatoHora(long lNumero, int iLargoNum , char *szFormato)
{
        ldiv_t  division;
        long    lDivisor=60;
        long    lMinutos;
        long    lSegundos;

        if (lNumero < 0) lNumero = 0;
        division = ldiv (lNumero,lDivisor);
        lMinutos = division.quot;
        lSegundos= division.rem;

        sprintf (szFormato, "%*.*ld:%2.2ld",iLargoNum, iLargoNum,lMinutos, lSegundos);

        return(0);
}

int BuscaAbonado(ST_ABONADO *Abonado,int *pos,long NumAbo)
{
   	int i;

	if (Abonado->CantidadAbonados==1)
	{ 
            if(NumAbo==Abonado->lNumAbonado[0])
            {
               *pos=0;
               return(0);
            }
	}
	else 
	{	
	    for(i=0;i< Abonado->CantidadAbonados;i++)
	    {
	        if(NumAbo==Abonado->lNumAbonado[i])
	        {
	            *pos=i;
	            return(0);
	        }
	    }
	}
    *pos=-1;
    return(0);
}

int FormateaDireccion(char *Direccion,char *dir_noformateada)
{
   int  rc,CmpPos,Pos,ARGC_DIR01,ARGC_DIR02;
   char *ARGV_DIR01[20],*ARGV_DIR02[20],CampoFormateado[1000];

   rc=TRUE;
   strcpy (szModulo, "FormateaDireccion");

   dir_noformateada[0]=0;

   RecupParam(&ARGC_DIR01,ARGV_DIR01,Direccion,SEPARADOR_01);

   vDTrazasLog(szModulo,"\tFormateaDireccion:Direccion:(%s)",LOG04,Direccion);
   for(Pos=0;Pos<ARGC_DIR01;Pos++)
   {
      RecupParam(&ARGC_DIR02,ARGV_DIR02,ARGV_DIR01[Pos],SEPARADOR_02);
      if(ARGC_DIR02 <2)
      {
            vDTrazasLog(szModulo, "\tFormateaDireccion:error numero regitros (%d):campo(%s)"
                                , LOG04, ARGC_DIR02,ARGV_DIR01[Pos]);
            rc=FALSE;
      }
      else
      {
            sprintf(CampoFormateado,"%-*.*s" ,atoi(ARGV_DIR02[1]),atoi(ARGV_DIR02[1]),((ARGC_DIR02<3)? "":ARGV_DIR02[2]));
            vDTrazasLog(szModulo,"\tFormateaDireccion:campo:(%s)",LOG06,CampoFormateado);
            strcat(dir_noformateada,CampoFormateado);
      }
      for(CmpPos=0;CmpPos<ARGC_DIR02;CmpPos++){ free(ARGV_DIR02[CmpPos]);}
   }
   for(Pos=0;Pos<ARGC_DIR01;Pos++){
        free(ARGV_DIR01[Pos]);
   }

   vDTrazasLog(szModulo,"\tFormateaDireccion:dir_noformateada:(%s)",LOG04,dir_noformateada);

   return(rc);
}

int bfnAcumulaMontos(   ST_ACUMMTO      *AcumMto,
            double          dTotFactura,
            double          dTotalCuotas,
            double          dTotalAPagar,
            double          dTotalSaldo)
{
    strcpy (szModulo, "bfnAcumulaMontos");

    AcumMto->dTotFactura    =  AcumMto->dTotFactura  + dTotFactura;
    AcumMto->dTotCuotas     =  AcumMto->dTotCuotas   + dTotalCuotas;
    AcumMto->dTotPagar      =  AcumMto->dTotPagar    + dTotalAPagar;
    AcumMto->dTotSaldoAnt   =  AcumMto->dTotSaldoAnt + dTotalSaldo;

    vDTrazasLog (szModulo,"AcumMto->dTotFactura [%.4f] "
                          "AcumMto->dTotCuotas  [%.4f] "
                          "AcumMto->dTotPagar   [%.4f] "
                          "AcumMto->dTotSaldoAnt[%.4f] "
                          ,LOG04, AcumMto->dTotFactura
                          , AcumMto->dTotCuotas, AcumMto->dTotPagar
                          , AcumMto->dTotSaldoAnt);

    return (1);
}/*********************** Final bfnAcumulaMontos **********************/

BOOL bfnInsertar_FadCTLImpres( ST_ACUMMTO    *AcumMto,
                               LINEACOMANDO  *ParEntrada,
                               ST_INFGENERAL *sthFa_InfGeneral,
                               char          *szNomArch)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char   szhCodInforme   [7]  ;
         long   lhNumSecuInfo        ;
         int    ihCodTipImpres       ;
         int    ihCodTipDocum        ;
         char   szhCodDespacho  [6]  ;
         char   szhNomArchivo   [255];
         long   lhNumClientes        ;
         double dhTot_Factura        ;
         double dhTot_Cuotas         ;
         double dhTot_Pagar          ;
         double dhTot_SaldoAnt       ;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy (szModulo, "bfnInsertar_FadCTLImpres");

    sprintf(szhCodInforme,"%s",szCODINFORME_GENERAR);
    lhNumSecuInfo  = ParEntrada->lNum_SecuInfo;
    ihCodTipImpres = COD_TIP_IMPRE;
    ihCodTipDocum  = ParEntrada->iCodTipDocum;
    sprintf(szhCodDespacho,"%s",ParEntrada->szCodDespacho);
    sprintf(szhNomArchivo,"%s",szNomArch);
    lhNumClientes  = (long) sthFa_InfGeneral->iContClientesProcesados;
    dhTot_Factura   = AcumMto->dTotFactura ;
    dhTot_Cuotas    = AcumMto->dTotCuotas  ;
    dhTot_Pagar     = AcumMto->dTotPagar   ;
    dhTot_SaldoAnt  = AcumMto->dTotSaldoAnt;

    vDTrazasLog(szModulo,"Proceso de Insercion en la FAD_CTLIMPRES(%s|%ld|%d|%d|%s|%s|%ld|%.4f|%.4f|%.4f|%.4f|)\n",
        LOG04,
        szhCodInforme,
        lhNumSecuInfo,
        ihCodTipImpres,
        ihCodTipDocum,
        szhCodDespacho,
        szhNomArchivo,
        lhNumClientes,
        dhTot_Factura,
        dhTot_Cuotas,
        dhTot_Pagar,
        dhTot_SaldoAnt
    );

    /* EXEC SQL INSERT
               INTO  FAD_CTLIMPRES (COD_INFORME,
                                    NUM_SECUINFO,
                                    COD_TIPIMPRES,
                                    COD_TIPDOCUM,
                                    COD_DESPACHO,
                                    NOM_ARCHIVO,
                                    NUM_CLIENTES,
                                    TOT_FACTURAS,
                                    TOT_CUOTAS,
                                    TOT_PAGAR,
                                    TOT_SALDOANT,
                                    TOT_LOCALES,
                                    TOT_INTERZONA,
                                    TOT_ESPECIALES,
                                    TOT_CARRIER,
                                    TOT_ROAMING,
                                    COD_ESTADO)
               VALUES ( :szhCodInforme,
                        :lhNumSecuInfo,
                        :ihCodTipImpres,
                        :ihCodTipDocum,
                        :szhCodDespacho,
                        :szhNomArchivo,
                        :lhNumClientes,
                        :dhTot_Factura,
                        :dhTot_Cuotas,
                        :dhTot_Pagar,
                        :dhTot_SaldoAnt,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAD_CTLIMPRES (COD_INFORME,NUM_SECUINFO,COD_T\
IPIMPRES,COD_TIPDOCUM,COD_DESPACHO,NOM_ARCHIVO,NUM_CLIENTES,TOT_FACTURAS,TOT_C\
UOTAS,TOT_PAGAR,TOT_SALDOANT,TOT_LOCALES,TOT_INTERZONA,TOT_ESPECIALES,TOT_CARR\
IER,TOT_ROAMING,COD_ESTADO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b\
10,0,0,0,0,0,0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )32;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipImpres;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhNomArchivo;
    sqlstm.sqhstl[5] = (unsigned long )255;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumClientes;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&dhTot_Factura;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&dhTot_Cuotas;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&dhTot_Pagar;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhTot_SaldoAnt;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
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



    if(sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog(szModulo, "\tError en INSERT de FAD_CTLIMPRES : %s ", LOG02,  sqlca.sqlerrm.sqlerrmc);
        return (FALSE);
    }

    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )91;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog(szModulo, "\tError en COMMIT al INSERT de FAD_CTLIMPRES : %s ", LOG02, sqlca.sqlerrm.sqlerrmc);
        return (FALSE);
    }

    memset(AcumMto,0,sizeof(ST_ACUMMTO));
    return (1);
}/********************* Final bfnInsertar_FadCTLImpres ***********************/

int bfnElimina_FadCTLImpres(LINEACOMANDO *ParEntrada)
{

    strcpy (szModulo, "bfnElimina_FadCTLImpres");

    /* EXEC SQL DELETE FROM FAD_CTLIMPRES
        WHERE
        NUM_SECUINFO = :ParEntrada->lNum_SecuInfo AND
        COD_TIPDOCUM = :ParEntrada->iCodTipDocum  AND
        COD_DESPACHO = :ParEntrada->szCodDespacho; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from FAD_CTLIMPRES  where ((NUM_SECUINFO=:b0 and \
COD_TIPDOCUM=:b1) and COD_DESPACHO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )106;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(ParEntrada->lNum_SecuInfo);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(ParEntrada->iCodTipDocum);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(ParEntrada->szCodDespacho);
    sqlstm.sqhstl[2] = (unsigned long )6;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "\tError en DELETE de FAD_CTLIMPRES : %s ", LOG02,  sqlca.sqlerrm.sqlerrmc);
        return (FALSE);
    }

    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )133;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog(szModulo, "\tError en COMMIT al DELETE de FAD_CTLIMPRES : %s ", LOG02, sqlca.sqlerrm.sqlerrmc);
        return (FALSE);
    }

    return(1);
}/***************** Final bfnElimina_FadCTLImpres ********************/

BOOL bfnReg_Padre(LINEACOMANDO *ParEntrada)
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        long    lhCodProceso        ;
        long    lhCodCiclo          ;
        int     ihCodEstado         ;
        char    szhGlsProceso   [50];
        char    szhHostId[11]       ;
        int     ihOpcionRango       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    strcpy (szModulo, "bfnReg_Padre");

    strcpy(szhHostId,szgHostId);
    ihOpcionRango=igOpcionRango;

    lhCodProceso = COD_PROCESO;
    lhCodCiclo   = ParEntrada->lCodCiclFact;

    strcpy(szhGlsProceso, GLS_PROCINIT);

    if (!bfnElimina_FadCTLImpres(ParEntrada))
    {
        vDTrazasLog(szModulo,"Error en ejecucion de bfnElimina_FadCTLImpres ",LOG02);
        return(FALSE);
    }

    /* EXEC SQL
    SELECT COD_ESTAPROC
     INTO :ihCodEstado
    FROM FA_TRAZAPROC
    WHERE COD_PROCESO = :lhCodProceso
      AND COD_CICLFACT = :lhCodCiclo
      AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTAPROC into :b0  from FA_TRAZAPROC where ((C\
OD_PROCESO=:b1 and COD_CICLFACT=:b2) and (HOST_ID=:b3 or 1<>:b4))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )148;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstado;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodProceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihOpcionRango;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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



    if (sqlca.sqlcode == SQLNOTFOUND)
    { 	
        ihCodEstado=iPROC_EST_RUN;
        /* EXEC SQL
        INSERT INTO FA_TRAZAPROC (
            COD_CICLFACT,
            COD_PROCESO,
            COD_ESTAPROC,
            FEC_INICIO,
            GLS_PROCESO,
            COD_CLIENTE,
            NUM_ABONADO,
            NUM_REGISTROS,
            HOST_ID)
        VALUES(
           :lhCodCiclo,
           :lhCodProceso,
           :ihCodEstado,
           SYSDATE,
           :szhGlsProceso,
           0,
           0,
           0,
           :szhHostId); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FA_TRAZAPROC (COD_CICLFACT,COD_PROCESO,CO\
D_ESTAPROC,FEC_INICIO,GLS_PROCESO,COD_CLIENTE,NUM_ABONADO,NUM_REGISTROS,HOST_I\
D) values (:b0,:b1,:b2,SYSDATE,:b3,0,0,0,:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )183;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodProceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodEstado;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhGlsProceso;
        sqlstm.sqhstl[3] = (unsigned long )50;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[4] = (unsigned long )11;
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



        if (sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de INSERT de bfnReg_Padre ",LOG01);
            return(FALSE);
        }

        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )218;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de bfnReg_Padre ",LOG01);
            return(FALSE);
        }

        return (TRUE);
    }

    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        vDTrazasLog (szModulo,"Error en ejecucion de SELECT de bfnReg_Padre ",LOG01);
        return(FALSE);
    }

    if (ihCodEstado != iPROC_EST_RUN)
    {
        ihCodEstado=iPROC_EST_RUN;
        /* EXEC SQL
            UPDATE FA_TRAZAPROC
               SET COD_ESTAPROC = :ihCodEstado ,
                   GLS_PROCESO =  :szhGlsProceso,
                   FEC_INICIO =  SYSDATE,
                   FEC_TERMINO =  NULL
             WHERE COD_PROCESO = :lhCodProceso
               AND COD_CICLFACT = :lhCodCiclo
               AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update FA_TRAZAPROC  set COD_ESTAPROC=:b0,GLS_PROCESO\
=:b1,FEC_INICIO=SYSDATE,FEC_TERMINO=null  where ((COD_PROCESO=:b2 and COD_CICL\
FACT=:b3) and (HOST_ID=:b4 or 1<>:b5))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )233;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstado;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhGlsProceso;
        sqlstm.sqhstl[1] = (unsigned long )50;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodProceso;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclo;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[4] = (unsigned long )11;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihOpcionRango;
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



        if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de UPDATE de bfnReg_Padre ",LOG01);
            return(FALSE);
        }
        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )272;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if (sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de bfnReg_Padre ",LOG01);
            return(FALSE);
        }

    }
    else
    {
        if (!bfnChequeaEstado(ParEntrada))
        {
            vDTrazasLog(szModulo,"Falla en la ejecucion de  bfnChequeaEstado ",LOG01);
            return (FALSE);
        }
    }
    return(1);
}/********************* Final bfnReg_Padre ************************/

BOOL bfnActualiza_ProcImpresion(LINEACOMANDO ParEntrada, BOOL bLlave)
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        int     ihCodTipDocum       ;
        long    lhCodCiclo          ;
        int     ihCodEstado         ;
        char    szhglosa    [51]    ;
        char    szhCodDespacho [6];
        char    szhHostId[11]       ;
        int     ihOpcionRango       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    strcpy (szModulo, "bfnActualiza_ProcImpresion");

    ihCodTipDocum   = ParEntrada.iCodTipDocum;
    lhCodCiclo      = ParEntrada.lCodCiclFact;
    strcpy(szhCodDespacho, ParEntrada.szCodDespacho);

    strcpy(szhHostId,szgHostId);
    ihOpcionRango=igOpcionRango;


    if (bLlave){
        ihCodEstado = iPROC_EST_OK;
        strcpy(szhglosa,szPROC_EST_OK);
    }
    else{
        ihCodEstado = iPROC_EST_ERR;
        strcpy(szhglosa,szPROC_EST_ERR);
    }
    /* EXEC SQL
        UPDATE FA_PROCIMPRESION_TD 
           SET COD_ESTAPROC = :ihCodEstado ,
               FEC_TERMINO  = SYSDATE,
               GLS_ESTAPROC = :szhglosa
         WHERE COD_CICLFACT = :lhCodCiclo
           AND COD_TIPDOCUM = :ihCodTipDocum
           AND COD_DESPACHO = :szhCodDespacho
           AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_PROCIMPRESION_TD  set COD_ESTAPROC=:b0,FEC_TERM\
INO=SYSDATE,GLS_ESTAPROC=:b1 where (((COD_CICLFACT=:b2 and COD_TIPDOCUM=:b3) a\
nd COD_DESPACHO=:b4) and (HOST_ID=:b5 or 1<>:b6))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )287;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstado;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhglosa;
    sqlstm.sqhstl[1] = (unsigned long )51;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[5] = (unsigned long )11;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihOpcionRango;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
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



    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo,"Error en ejecucion de UPDATE de bfnActualiza_ProcImpresion ",LOG01);
        return(FALSE);
    }
    else
    {
        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )330;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de bfnActualiza_ProcImpresion ",LOG01);
            return(FALSE);
        }

    }
    return(1);
}/******************** Final bfnActualiza_ProcImpresion ***********************/

BOOL bfnActualiza_TrazaProceso(LINEACOMANDO ParEntrada,BOOL bLlave)
{
    int     NroRegsProcImp;
    int     i;
    int     TotalEstados=5;

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        int     ihCod_Estaproc  [MAX_TRAZAPROC]     ;
        int     ihCod_Estado  ;
        char    szhCodDespacho[6];
        long    lhCodCiclo;
        long    lhCodProceso;
        char    szhGlsProceso[50];
        char    szhHostId[11]       ;
        int     ihOpcionRango       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    int contador_estados[5];
    strcpy (szModulo, "bfnActualiza_TrazaProceso");

    vDTrazasLog(szModulo, "\tEntro a %s", LOG04,szModulo);

    strcpy(szhHostId,szgHostId);
    ihOpcionRango=igOpcionRango;

    lhCodCiclo      = ParEntrada.lCodCiclFact;
    lhCodProceso    = COD_PROCESO;
    strcpy(szhCodDespacho, ParEntrada.szCodDespacho);

    if(lhCodCiclo)
    {
        /* EXEC SQL
            SELECT COD_ESTAPROC
              INTO :ihCod_Estaproc
              FROM FA_PROCIMPRESION_TD
             WHERE COD_CICLFACT = :lhCodCiclo
               AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_ESTAPROC into :b0  from FA_PROCIMPRESION_T\
D where (COD_CICLFACT=:b1 and (HOST_ID=:b2 or 1<>:b3))";
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )345;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)ihCod_Estaproc;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(int);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[2] = (unsigned long )11;
        sqlstm.sqhsts[2] = (         int  )11;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihOpcionRango;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )sizeof(int);
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



        NroRegsProcImp = sqlca.sqlerrd[2];
        vDTrazasLog(szModulo, "query retorno registros sqlca.sqlcode(%d)NroRegsProcImp(%d)", LOG04,sqlca.sqlcode,NroRegsProcImp);

        if(sqlca.sqlcode < SQLOK && NroRegsProcImp<=0)
        {
           vDTrazasLog(szModulo, "Error en ejecucion del SELECT [%i]", LOG00, sqlca.sqlcode);
           return(FALSE);
        }

        for(i=0;i<TotalEstados;i++){
            contador_estados[i]=0;
        }

        for(i=0; i < NroRegsProcImp; i++)
        {
            contador_estados[ihCod_Estaproc[i]]++;
        }

  
        if(!(contador_estados[0]>0 || contador_estados[iPROC_EST_RUN]>0))
        {
            if(contador_estados[iPROC_EST_ERR]>0)
            {
                  ihCod_Estado=iPROC_EST_ERR;
                strcpy(szhGlsProceso, GLS_PROCFINNOOK);
                vDTrazasLog (szModulo,"Existen subproceso terminados con error\n",LOG04);
            }
            else
            {
                  ihCod_Estado=iPROC_EST_OK;
                strcpy(szhGlsProceso, GLS_PROCFINOK);
                vDTrazasLog (szModulo,"todos los subprocesos terminaron y bien\n",LOG04);
            }

            if (igOpcionRango)
            {
                /* EXEC SQL
                    UPDATE FA_TRAZAPROC
                       SET COD_ESTAPROC = :ihCod_Estado
                         , FEC_TERMINO  = SYSDATE
                         , GLS_PROCESO  = :szhGlsProceso
                     WHERE COD_CICLFACT = :lhCodCiclo
                       AND COD_PROCESO  = :lhCodProceso
                       AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 11;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update FA_TRAZAPROC  set COD_ESTAPROC=:b0,FEC\
_TERMINO=SYSDATE,GLS_PROCESO=:b1 where ((COD_CICLFACT=:b2 and COD_PROCESO=:b3)\
 and (HOST_ID=:b4 or 1<>:b5))";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )376;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Estado;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szhGlsProceso;
                sqlstm.sqhstl[1] = (unsigned long )50;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&lhCodProceso;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
                sqlstm.sqhstl[4] = (unsigned long )11;
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)&ihOpcionRango;
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


            }
            else
            {
                /* EXEC SQL
                    UPDATE FA_TRAZAPROC
                       SET COD_ESTAPROC = :ihCod_Estado
                         , FEC_TERMINO  = SYSDATE
                         , GLS_PROCESO  = :szhGlsProceso
                     WHERE COD_CICLFACT = :lhCodCiclo
                       AND COD_PROCESO  = :lhCodProceso; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 11;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update FA_TRAZAPROC  set COD_ESTAPROC=:b0,FEC\
_TERMINO=SYSDATE,GLS_PROCESO=:b1 where (COD_CICLFACT=:b2 and COD_PROCESO=:b3)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )415;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Estado;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szhGlsProceso;
                sqlstm.sqhstl[1] = (unsigned long )50;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&lhCodProceso;
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
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            }
            if (sqlca.sqlcode != SQLOK)
            {
                vDTrazasLog (szModulo,"Error en ejecucion de UPDATE de bfnActualiza_TrazaProceso ",LOG01);
                return(FALSE);
            }

            /* EXEC SQL COMMIT; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 11;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )446;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



            if (sqlca.sqlcode != SQLOK)
            {
                vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de bfnActualiza_TrazaProceso ",LOG01);
                return(FALSE);
            }
        }
        else
        {
            vDTrazasLog (szModulo,"Existe subproceso corriendo o por correr\n",LOG03);
        }
    }
    else
    {
        if (!bLlave)
        {
            ihCod_Estado=iPROC_EST_ERR;

            vDTrazasLog (szModulo,"ejecucion de UPDATE de FA_INTERFACT por num_proceso",LOG04);
            /* EXEC SQL UPDATE FA_INTERFACT SET COD_ESTADOC=:ParEntrada.iCodSalida, COD_ESTPROC = :ihCod_Estado
                     WHERE NUM_PROCESO = :ParEntrada.lProceso; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 11;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_INTERFACT  set COD_ESTADOC=:b0,COD_ESTP\
ROC=:b1 where NUM_PROCESO=:b2";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )461;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(ParEntrada.iCodSalida);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCod_Estado;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&(ParEntrada.lProceso);
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



            if (sqlca.sqlcode != SQLOK)
            {
                vDTrazasLog (szModulo,"Error en ejecucion de UPDATE de FA_INTERFACT ",LOG01);
                return(FALSE);
            }
        }
        else
        {
            ihCod_Estado=iPROC_EST_OK;
        }
        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )488;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if (sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de FA_INTERFACT ",LOG01);
            return(FALSE);
        }
    }
    return(1);

}/********************* Final bfnActualiza_TrazaProceso ***********************/

BOOL bfnChequeaEstado (LINEACOMANDO *ParEntrada)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int     ihCod_Estaproc  ;
        char    szhCodDespacho[6];
        int     ihCodTipDocum   ;
        long    lhCodCiclo      ;
        char    szhHostId[11]   ;
        int     ihOpcionRango   ;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "bfnChequeaEstado");

    lhCodCiclo      = ParEntrada->lCodCiclFact;
    strcpy(szhCodDespacho, ParEntrada->szCodDespacho);
    ihCodTipDocum   = ParEntrada->iCodTipDocum;

    strcpy(szhHostId,szgHostId);
    ihOpcionRango=igOpcionRango;

    /* EXEC SQL 
    	SELECT COD_ESTAPROC
          INTO :ihCod_Estaproc
          FROM FA_PROCIMPRESION_TD
         WHERE COD_CICLFACT  = :lhCodCiclo
           AND COD_DESPACHO  = :szhCodDespacho
           AND COD_TIPDOCUM  = :ihCodTipDocum
           AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTAPROC into :b0  from FA_PROCIMPRESION_TD wh\
ere (((COD_CICLFACT=:b1 and COD_DESPACHO=:b2) and COD_TIPDOCUM=:b3) and (HOST_\
ID=:b4 or 1<>:b5))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )503;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Estaproc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihOpcionRango;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "Error en SELECT de bfnChequeaEstado [%i]", LOG02, sqlca.sqlcode);
        return (FALSE);
    }
    if (ihCod_Estaproc == 1)
    {
        vDTrazasLog(szModulo, "Estado del proceso : En Proceso. El proceso actual se aborta", LOG01);
        return (FALSE);
    }

    return (1);

}
/********************* Final bfnChequeaProcesosPrevios ***************************/

BOOL bfnChequeaProcesosPrevios(LINEACOMANDO *ParEntrada)
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        long    lhCodCiclo          ;
        int     ihCodEstaPrec       ;
        int     ihTrazCodEstaProc   ;
        int     lhCod_Proceso       ;
        int     iValorCero=0        ;
        char    szhHostId[11]       ;
        int     ihOpcionRango       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 

    BOOL bFinCursor_cFaProcTraza=FALSE;

    strcpy (szModulo, "bfnChequeaProcesosPrevios");

    strcpy(szhHostId,szgHostId);
    ihOpcionRango=igOpcionRango;

    lhCodCiclo = ParEntrada->lCodCiclFact;
    lhCod_Proceso = COD_PROCESO;

    if (igOpcionRango)
    {	
        /* EXEC SQL DECLARE cFaProcTraza_Host CURSOR FOR
            SELECT
                    PROC.COD_ESTAPREC,
                    NVL(TRAZ.COD_ESTAPROC,:iValorCero)
            FROM    FA_TRAZAPROC  TRAZ,
                    (SELECT A.COD_PROCESO   COD_PROCESO,
                            B.DES_PROCESO   DES_PROCESO,
                            A.COD_PROCPREC  COD_PROCPREC,
                            C.DES_PROCESO   DES_PROCPREC,
                            A.COD_ESTAPREC  COD_ESTAPREC
                    FROM    FA_PROCFACTPREC A ,
                            FA_PROCFACT B ,
                            FA_PROCFACT C
                    WHERE   A.COD_PROCESO  = :lhCod_Proceso
                    AND     A.COD_PROCESO  = B.COD_PROCESO
                    AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
            WHERE   TRAZ.COD_CICLFACT (+)  = :lhCodCiclo
            AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
            AND     ((TRAZ.HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango))
            ORDER BY PROC.COD_PROCESO; */ 

    }
    else
    {	
        /* EXEC SQL DECLARE cFaProcTraza CURSOR FOR
            SELECT
                    PROC.COD_ESTAPREC,
                    NVL(TRAZ.COD_ESTAPROC,:iValorCero)
            FROM    FA_TRAZAPROC  TRAZ,
                    (SELECT A.COD_PROCESO   COD_PROCESO,
                            B.DES_PROCESO   DES_PROCESO,
                            A.COD_PROCPREC  COD_PROCPREC,
                            C.DES_PROCESO   DES_PROCPREC,
                            A.COD_ESTAPREC  COD_ESTAPREC
                    FROM    FA_PROCFACTPREC A ,
                            FA_PROCFACT B ,
                            FA_PROCFACT C
                    WHERE   A.COD_PROCESO  = :lhCod_Proceso
                    AND     A.COD_PROCESO  = B.COD_PROCESO
                    AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
            WHERE   TRAZ.COD_CICLFACT (+)  = :lhCodCiclo
            AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
            ORDER BY PROC.COD_PROCESO; */ 


    }

    if (igOpcionRango)
    {
        /* EXEC SQL OPEN cFaProcTraza_Host; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0024;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )542;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&iValorCero;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Proceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihOpcionRango;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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


    }
    else
    {    	  	
        /* EXEC SQL OPEN cFaProcTraza; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0025;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )577;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&iValorCero;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Proceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
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


    }


    if(SQLCODE != SQLOK)
    {    	    	
        vDTrazasLog  (szModulo, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,lhCod_Proceso,lhCodCiclo,SQLERRM);
        vDTrazasError(szModulo, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,lhCod_Proceso,lhCodCiclo,SQLERRM);
        return (FALSE);
    }

    bFinCursor_cFaProcTraza = FALSE ;
    do
    {
        if (igOpcionRango)        
            /* EXEC SQL FETCH cFaProcTraza_Host INTO
                        :ihCodEstaPrec          ,
                        :ihTrazCodEstaProc      ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 11;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )604;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaPrec;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihTrazCodEstaProc;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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


        else  
            /* EXEC SQL FETCH cFaProcTraza INTO
                        :ihCodEstaPrec          ,
                        :ihTrazCodEstaProc      ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 11;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )627;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaPrec;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihTrazCodEstaProc;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szModulo, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            vDTrazasError(szModulo, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor_cFaProcTraza = TRUE;
        }
        else
        {
            if(ihCodEstaPrec != ihTrazCodEstaProc)
            {
                vDTrazasLog  (szModulo, "\n\t* Error: No ha Terminado Proceso Precedente **\n",LOG01);
                vDTrazasError(szModulo, "\n\t* Error: No ha Terminado Proceso Precedente **\n",LOG01);
                return(FALSE);
            }
        }
    } while(!bFinCursor_cFaProcTraza);

    if (igOpcionRango)
    {
        /* EXEC SQL CLOSE cFaProcTraza_Host; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )650;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {
        /* EXEC SQL CLOSE cFaProcTraza; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )665;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }

    return (1);

}
/********************* Final bfnChequeaProcesosPrevios ************************/

BOOL bfnActualizaRegprocImpres (LINEACOMANDO ParEntrada)
{
    /* EXEC SQL BEGIN DECLARE SECTION      ; */ 

        int     ihCod_Estaproc      ;
        char    szhCodDespacho  [6] ;
        char    szhglosa    [51]    ;
        int     ihCodTipDocum       ;
        long    lhCodCiclo          ;
        char    szhHostId[11]   ;
        int     ihOpcionRango   ;
    /* EXEC SQL END DECLARE SECTION        ; */ 


    strcpy (szModulo, "bfnActualizaRegprocImpres");

    lhCodCiclo = ParEntrada.lCodCiclFact;
    strcpy(szhCodDespacho, ParEntrada.szCodDespacho);
    ihCodTipDocum   = ParEntrada.iCodTipDocum;

    strcpy(szhHostId,szgHostId);
    ihOpcionRango=igOpcionRango;

    /* EXEC SQL 
    	SELECT COD_ESTAPROC
          INTO :ihCod_Estaproc
          FROM FA_PROCIMPRESION_TD
         WHERE COD_CICLFACT = :lhCodCiclo
           AND COD_TIPDOCUM = :ihCodTipDocum
           AND COD_DESPACHO = :szhCodDespacho
           AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTAPROC into :b0  from FA_PROCIMPRESION_TD wh\
ere (((COD_CICLFACT=:b1 and COD_TIPDOCUM=:b2) and COD_DESPACHO=:b3) and (HOST_\
ID=:b4 or 1<>:b5))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )680;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Estaproc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihOpcionRango;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "Error en SELECT de bfnActualizaRegprocImpres [%d]", LOG02, sqlca.sqlcode);
        return (FALSE);
    }

    if (ihCod_Estaproc == 1)
    {
        vDTrazasLog (szModulo, "Estado del proceso : En Proceso. Proceso nuevo se aborta", LOG01);
        return(FALSE);
    }

    ihCod_Estaproc=iPROC_EST_RUN;
    strcpy(szhglosa,szPROC_EST_RUN);

    /* EXEC SQL 
    	UPDATE FA_PROCIMPRESION_TD
           SET COD_ESTAPROC = :ihCod_Estaproc ,
        	   GLS_ESTAPROC = :szhglosa ,
        	   FEC_INICIO   = SYSDATE
         WHERE COD_CICLFACT = :lhCodCiclo
           AND COD_TIPDOCUM = :ihCodTipDocum
           AND COD_DESPACHO = :szhCodDespacho
           AND ((HOST_ID =:szhHostId) OR (1 <> :ihOpcionRango)); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_PROCIMPRESION_TD  set COD_ESTAPROC=:b0,GLS_ESTA\
PROC=:b1,FEC_INICIO=SYSDATE where (((COD_CICLFACT=:b2 and COD_TIPDOCUM=:b3) an\
d COD_DESPACHO=:b4) and (HOST_ID=:b5 or 1<>:b6))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )719;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Estaproc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhglosa;
    sqlstm.sqhstl[1] = (unsigned long )51;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[5] = (unsigned long )11;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihOpcionRango;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
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



    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo,"Error en ejecucion de UPDATE de bfnActualizaRegprocImpres ",LOG01);
        return(FALSE);
    }
    else
    {
        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )762;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de bfnActualizaRegprocImpres ",LOG01);
            return(FALSE);
        }
    }

    return (1);
}
/********************Final bfnActualizaRegprocImpres ************************/

/****************************************************************************/
/*  Funcion: int ObtieneIdiomaOperadora                                     */
/*  Funcion que Obtiene el Idioma de la Operadora                           */
/****************************************************************************/

int ObtieneIdiomaOperadora(ST_INFGENERAL *sthFa_InfGeneral)
{
    sprintf(sthFa_InfGeneral->szIdiomaOper ,"%-1.1s\0",szhIdiomaOper);

    return(1);
}
/****************Final de ObtieneIdiomaOperadora *******************/

/****************************************************************************/
/*  Funcion: int iGetMensajesNoCiclo                                        */
/*  Funcion que Obtiene los mensajes para documentos no ciclicos            */
/****************************************************************************/

int iGetMensajesNoCiclo(ST_MENSAJES_NOCICLO * stFaMensajes_NoCiclo,long lNumProceso)
{
    int  iSqlMensNoCiclo ;

    strcpy (szModulo, "iGetMensajesNoCiclo");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    iSqlMensNoCiclo = Open_MensNoCiclo(lNumProceso);

    if(iSqlMensNoCiclo == SQLOK)
    {
        iSqlMensNoCiclo = Fetch_MensNoCiclo( stFaMensajes_NoCiclo );

        if(iSqlMensNoCiclo == SQLOK && stFaMensajes_NoCiclo->iCantLineas >= MAX_LINEAS_MENSAJES)
        {
            vDTrazasLog  (szModulo,"\t\tMensajes No Ciclo Sobrepaso Maximo Posible" ,LOG01);
            vDTrazasError(szModulo,"\t\tMensajes No Ciclo Sobrepaso Maximo Posible" ,LOG01);
            return (FALSE);
        }
    }
    if((iSqlMensNoCiclo != SQLOK) && (iSqlMensNoCiclo != SQLNOTFOUND))
    {
        vDTrazasError(szModulo, "\t\t Error Oracle   [%s]",LOG01, SQLERRM);
        vDTrazasLog(szModulo,   "\t\t Error Oracle   [%s]",LOG01, SQLERRM);
        return (FALSE);
    }
    if (!Close_MensNoCiclo()) return (FALSE);

    vDTrazasLog(szModulo,"\t====> Cantidad de Mensajes no ciclo [%d]",LOG04,stFaMensajes_NoCiclo->iCantLineas);

    return (1);
}
/************************* Fin GetMensajesNoCiclo *************************/

int Open_MensNoCiclo ( long lNumeroProc )
{
    strcpy (szModulo, "Open_MensNoCiclo");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    lhNumAbonado= lNumeroProc;

    /* EXEC SQL OPEN curMensNoCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )777;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-OPEN CURSOR curMensNoCiclo **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-OPEN CURSOR curMensNoCiclo **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }
    return (SQLCODE);
}/*********************** Final de Open_MensNoCiclo ***********************/

/****************************************************************************/
/* Funcion: int Fetch_MensNoCiclo                      */
/* Funcion que realiza Fetch en el cursor de curMensNoCiclo                 */
/****************************************************************************/

int Fetch_MensNoCiclo (ST_MENSAJES_NOCICLO * pstFaMensajes_NoCiclo)
{
    strcpy (szModulo, "Fetch_MensNoCiclo");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL
    FETCH curMensNoCiclo
    INTO :pstFaMensajes_NoCiclo->szMensajes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )50;
    sqlstm.offset = (unsigned int  )796;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstFaMensajes_NoCiclo->szMensajes);
    sqlstm.sqhstl[0] = (unsigned long )201;
    sqlstm.sqhsts[0] = (         int  )201;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if((SQLCODE == SQLOK) && (SQLCODE != SQLNOTFOUND))
        vDTrazasError(szModulo,"\t\tError en Fetch %s : %s", LOG01, szModulo, SQLERRM);
    else
        pstFaMensajes_NoCiclo->iCantLineas = sqlca.sqlerrd[2];

    return(SQLCODE);
}
/*************************** Final de Fetch_MensNoCiclo ***************************/

/****************************************************************************/
/*  Funcion: int Close_MensNoCiclo(void)                                    */
/*  Funcion que cierra el cursor de curMensNoCiclo                          */
/****************************************************************************/

int Close_MensNoCiclo(void)
{
     strcpy (szModulo, "Close_MensNoCiclo");
        vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

     /* EXEC SQL CLOSE curMensNoCiclo; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 11;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )815;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


     if(SQLCODE != SQLOK)
     {
        vDTrazasError(szModulo,"\tError al cerrar el Cursor curMensNoCiclo: %s",LOG01, SQLERRM);
        return FALSE;
     }
     return 1;
}
/****************Final de Close_MensNoCiclo *******************/

int BuscaMascara(DETALLEOPER *pst_MascaraOper,char *szCod_Registro,int derecha,int tipdocum)
{
   int izquierda;

    strcpy (szModulo, "BuscaMascara");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    vDTrazasLog(szModulo,"=> CODIGO[%s] Num_Registros [%d] Tipo Documento [%d] Tipo Ciclo [%d]", LOG06,szCod_Registro,derecha,tipdocum,igTipoCiclo);
    izquierda = 0;

    while( izquierda <= derecha )
    {
        if (!igTipoCiclo)
        {
            if ((tipdocum == pst_MascaraOper->iCod_tipdocum[izquierda]) &&
               ( strcmp(szCod_Registro,pst_MascaraOper->szCodRegistro[izquierda]) == 0))
            {
                vDTrazasLog(szModulo,"=> CODIGO ENCONTRADO Posicion [%d] ", LOG06,izquierda);
                return(izquierda);
            }
            izquierda++;
        }
        else
        {
            if (strcmp(szCod_Registro,pst_MascaraOper->szCodRegistro[izquierda]) == 0)
            {
                vDTrazasLog(szModulo,"=> CODIGO ENCONTRADO Posicion [%d] ", LOG06,izquierda);
                return(izquierda);
            }
            izquierda++;
        }
   }
   vDTrazasLog(szModulo,"NO ENCONTRADO ", LOG06);
   return(-1);
}
/****************Final de BuscaMascara *******************/

int BuscaCodInterfact(long lNumProceso,long lNumSecuencia,LINEACOMANDO *pst_ParamEntrada)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        /* varchar szCodAplic[4]; */ 
struct { unsigned short len; unsigned char arr[4]; } szCodAplic;

        /* varchar szCodModGener[4]; */ 
struct { unsigned short len; unsigned char arr[4]; } szCodModGener;

    /* EXEC SQL END DECLARE SECTION; */ 


    int  iCodEstadoSal;
    int  iCodEstadoEnt;
    int  iCodInterfact;

    strcpy (szModulo, "BuscaCodInterfact");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    iCodInterfact = COD_INTERFACT;
    if(lNumProceso)
    {
       /* EXEC SQL SELECT COD_MODGENER,COD_APLIC
            INTO :szCodModGener,:szCodAplic
            FROM FA_INTERFACT
            WHERE NUM_PROCESO =:lNumProceso; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 11;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select COD_MODGENER ,COD_APLIC into :b0,:b1  from FA_I\
NTERFACT where NUM_PROCESO=:b2";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )830;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&szCodModGener;
       sqlstm.sqhstl[0] = (unsigned long )6;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&szCodAplic;
       sqlstm.sqhstl[1] = (unsigned long )6;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&lNumProceso;
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



       if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
       {
           vDTrazasLog(szModulo, "Error en SELECT de FA_INTERFACT [%d]", LOG02, sqlca.sqlcode);
           return (FALSE);
       }
    }
    else
    {
       /* EXEC SQL SELECT DISTINCT COD_MODGENER,COD_APLIC
            INTO :szCodModGener,:szCodAplic
            FROM FA_INTERFACT
            WHERE NUM_PROCESO IN (
                SELECT NUM_PROCESO
                FROM FA_PROCIMPRESLOTE_TD
                WHERE NUM_SECUENCIAL = :lNumSecuencia
            ); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 11;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select distinct COD_MODGENER ,COD_APLIC into :b0,:b1  \
from FA_INTERFACT where NUM_PROCESO in (select NUM_PROCESO  from FA_PROCIMPRES\
LOTE_TD where NUM_SECUENCIAL=:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )857;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&szCodModGener;
       sqlstm.sqhstl[0] = (unsigned long )6;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&szCodAplic;
       sqlstm.sqhstl[1] = (unsigned long )6;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&lNumSecuencia;
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


       if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
       {
           vDTrazasLog(szModulo, "Error en SELECT de FA_PROCIMPRESLOTE_TD [%d", LOG02, sqlca.sqlcode);
           return (FALSE);
       }
    }


    /* EXEC SQL SELECT COD_ESTADOC_ENT,COD_ESTADOC_SAL
         INTO :iCodEstadoEnt,:iCodEstadoSal
         FROM FA_INTQUEUEPROC
         WHERE COD_MODGENER=:szCodModGener
         AND COD_PROCESO = :iCodInterfact
         AND COD_APLIC = :szCodAplic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTADOC_ENT ,COD_ESTADOC_SAL into :b0,:b1  fro\
m FA_INTQUEUEPROC where ((COD_MODGENER=:b2 and COD_PROCESO=:b3) and COD_APLIC=\
:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )884;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCodEstadoEnt;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iCodEstadoSal;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&szCodModGener;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iCodInterfact;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&szCodAplic;
    sqlstm.sqhstl[4] = (unsigned long )6;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
    {
       vDTrazasLog(szModulo, "Error en SELECT de FA_INTQUEUEPROC [%d]", LOG02, sqlca.sqlcode);
       return (FALSE);
    }

    pst_ParamEntrada->iCodEntrada = iCodEstadoEnt;
    pst_ParamEntrada->iCodSalida  = iCodEstadoSal;

    return(1);
}
/****************Final de BuscaCodInterfact *******************/

int ChequeaInterfact(LINEACOMANDO pst_ParamEntrada)
{
    int  iCodEstaRun;
    int  iCodEstaOk;
    int  iCantProc;

    iCodEstaRun = iPROC_EST_RUN;
    iCodEstaOk  = iPROC_EST_OK;

    strcpy (szModulo, "ChequeaInterfact");
    vDTrazasLog(szModulo, "** Entrando a %s \n"
                          "\t\tNum. Proceso => [%ld]\n"
                          "\t\tCod. Estado  => [%d]\n"
                          "\t\tCod. OK      => [%d]\n"                          
                        , LOG04
                        , szModulo
                        , pst_ParamEntrada.lProceso
                        , pst_ParamEntrada.iCodEntrada
                        , iCodEstaOk);


    
    /* EXEC SQL SELECT COUNT(1)
               INTO :iCantProc
               FROM FA_INTERFACT
              WHERE NUM_PROCESO = :pst_ParamEntrada.lProceso
                AND COD_ESTADOC =:pst_ParamEntrada.iCodEntrada
                AND COD_ESTPROC = :iCodEstaOk; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from FA_INTERFACT where ((NUM_P\
ROCESO=:b1 and COD_ESTADOC=:b2) and COD_ESTPROC=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )919;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCantProc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pst_ParamEntrada.lProceso);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&(pst_ParamEntrada.iCodEntrada);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iCodEstaOk;
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



    if (!iCantProc)
    {
        vDTrazasLog (szModulo,"\n\tnumero de proceso [%d] No esta en el estado correcto de ejecucion\n",LOG04,pst_ParamEntrada.lProceso);
        return(FALSE);
    }

    vDTrazasLog (szModulo,"\n\tEntro por numero de proceso [%d]\n",LOG04,pst_ParamEntrada.lProceso);
    
    /* EXEC SQL UPDATE FA_INTERFACT SET COD_ESTADOC=:pst_ParamEntrada.iCodSalida, COD_ESTPROC = :iCodEstaRun
              WHERE NUM_PROCESO = :pst_ParamEntrada.lProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_INTERFACT  set COD_ESTADOC=:b0,COD_ESTPROC=:b1 \
where NUM_PROCESO=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )950;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(pst_ParamEntrada.iCodSalida);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iCodEstaRun;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&(pst_ParamEntrada.lProceso);
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



    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo,"Error en ejecucion de UPDATE de FA_INTERFACT [%d][%s]",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )977;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo,"Error en ejecucion de COMMIT de FA_INTERFACT [%d][%s]",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    return(1);
}

int OpenDetArrastre ( long lCodCiclFact )
{
    strcpy (szModulo, "OpenDetArrastre");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    lhCodCilclFact= lCodCiclFact;
    strcpy (szhStrCodCliente, "09999999");

    /* EXEC SQL OPEN curArrastre; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )992;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhStrCodCliente;
    sqlstm.sqhstl[0] = (unsigned long )9;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhStrCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCilclFact;
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


    if(SQLCODE != SQLOK)
    {
      vDTrazasLog  (szModulo,"\t\tError en SQL-OPEN CURSOR curArrastre **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
      vDTrazasError(szModulo,"\t\tError en SQL-OPEN CURSOR curArrastre **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }
    return (SQLCODE);
}
/*********************** Final de OpenDetArrastre ***********************/

/****************************************************************************/
/* FUNCION : FetchDetArrastre                                               */
/****************************************************************************/

int FetchDetArrastre ( void )
{
    strcpy (szModulo, "FetchDetArrastre");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL
    FETCH curArrastre
    INTO :sthCurArrastre.lCodCliente,
         :sthCurArrastre.lNumAbonado,
         :sthCurArrastre.szCodBolsa,
         :sthCurArrastre.dValBolsa,
         :sthCurArrastre.szIndUnidad,
         :sthCurArrastre.dValArrastre,
         :sthCurArrastre.dValExpirado,
         :sthCurArrastre.dValDisponible,
         :sthCurArrastre.dValConsumo,
         :sthCurArrastre.dValResto,
         :sthCurArrastre.szLlaveArrastre; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )30000;
    sqlstm.offset = (unsigned int  )1019;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(sthCurArrastre.lCodCliente);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(sthCurArrastre.lNumAbonado);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(sthCurArrastre.szCodBolsa);
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )6;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(sthCurArrastre.dValBolsa);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )sizeof(double);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(sthCurArrastre.szIndUnidad);
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )6;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(sthCurArrastre.dValArrastre);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )sizeof(double);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(sthCurArrastre.dValExpirado);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )sizeof(double);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(sthCurArrastre.dValDisponible);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(sthCurArrastre.dValConsumo);
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )sizeof(double);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(sthCurArrastre.dValResto);
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )sizeof(double);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(sthCurArrastre.szLlaveArrastre);
    sqlstm.sqhstl[10] = (unsigned long )17;
    sqlstm.sqhsts[10] = (         int  )17;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
        vDTrazasError(szModulo,"\t\tError en Fetch FetchDetArrastre : %s", LOG01, SQLERRM);
        return(SQLCODE);
    }
    sthCurArrastre.iCantidadArrastre = sqlca.sqlerrd[2];
    return(SQLCODE);
}
/*************************** Final de FetchDetArrastre ***************************/

/****************************************************************************/

int CloseDetArrastre(void)
{
    strcpy (szModulo, "CloseDetArrastre");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL CLOSE curArrastre; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1078;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szModulo,"\tError al cerrar el Cursor Arrastre: %s",LOG01, SQLERRM);
        return FALSE;
    }
    return 1;
}
/****************Final de CloseDetArrastre *******************/

/****************************************************************************/

int CargaArrastre( long lhCodCiclFact )
{
    int  iSqlDetArrastre;
    register int i,j;
    int   rows_to_fetch  = MAX_ARRASTRE_CURSOR;
    int   rows_before    =  0;  
    int   rows_this_time = MAX_ARRASTRE_CURSOR;

    strcpy (szModulo, "CargaArrastre");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    iSqlDetArrastre = OpenDetArrastre(lhCodCiclFact);

    if(iSqlDetArrastre == SQLOK)
    {
        while(rows_this_time == rows_to_fetch)
        {
            iSqlDetArrastre = FetchDetArrastre();
            if((iSqlDetArrastre != SQLOK)&&(iSqlDetArrastre != SQLNOTFOUND))
            {
                vDTrazasError(szModulo,"\t\tError en Fetch FetchDetArrastre : %s", LOG01, SQLERRM);
                return(SQLCODE);
            }

            j=0;
            for(i=rows_before;i<sthCurArrastre.iCantidadArrastre ;i++)
            {
                sthDetArrastre.lCodCliente[i]           = sthCurArrastre.lCodCliente[j];
                sthDetArrastre.lNumAbonado[i]           = sthCurArrastre.lNumAbonado[j];
                strcpy(sthDetArrastre.szCodBolsa[i]     , sthCurArrastre.szCodBolsa[j]);
                sthDetArrastre.dValBolsa[i]             = sthCurArrastre.dValBolsa[j];
                strcpy(sthDetArrastre.szIndUnidad[i]    , sthCurArrastre.szIndUnidad[j]);
                sthDetArrastre.dValArrastre[i]          = sthCurArrastre.dValArrastre[j];
                sthDetArrastre.dValExpirado[i]          = sthCurArrastre.dValExpirado[j];
                sthDetArrastre.dValDisponible[i]        = sthCurArrastre.dValDisponible[j];
                sthDetArrastre.dValConsumo[i]           = sthCurArrastre.dValConsumo[j];
                sthDetArrastre.dValResto[i]             = sthCurArrastre.dValResto[j];
                strcpy(sthDetArrastre.szLlaveArrastre[i], sthCurArrastre.szLlaveArrastre[j]);
                j++;
            }
            sthDetArrastre.iCantidadArrastre = i;
            if(sthDetArrastre.iCantidadArrastre > MAX_ARRASTRE_ESTRUCTURA)
            {
               vDTrazasLog  (szModulo,"\t\tDetArrastre Sobrepaso Maximo Posible" ,LOG01);
               vDTrazasError(szModulo,"\t\tDetArrastre Sobrepaso Maximo Posible" ,LOG01);
               return (FALSE);
            }
            rows_this_time = sthCurArrastre.iCantidadArrastre - rows_before;
            rows_before = sthCurArrastre.iCantidadArrastre;
            vDTrazasLog(szModulo,"\t[%d]-[%d]-[%d]",LOG05,rows_this_time,rows_before,rows_to_fetch);
        }
    }
    if((iSqlDetArrastre != SQLOK) && (iSqlDetArrastre != SQLNOTFOUND))
    {
        vDTrazasError(szModulo, "\t\t Error Oracle   [%s]",LOG01, SQLERRM);
        vDTrazasLog(szModulo,   "\t\t Error Oracle   [%s]",LOG01, SQLERRM);
      return (FALSE);
    }
    if (!CloseDetArrastre()) return (FALSE);
    return (TRUE);
}
/************************* Fin CargaArrastre *************************/

int Busca_RangoCliente(int iPosicion,int *iInicio,int *iTermino,int iFin)
{
    int iIndice;
    char szllave[17];

    iIndice = iPosicion;
    sprintf(szllave,"%s",sthDetArrastre.szLlaveArrastre[iPosicion]);
    vDTrazasLog("","Busca_RangoCliente ENTRADA \t iIndice(%d) >= 0 && *iInicio(%d) == 0  Termino=%d Fin=%d llave=[%s]\n",LOG06,iIndice, *iInicio, *iTermino,iFin,szllave);
    while(iIndice >= 0 && *iInicio == 0)
    {
        if(strcmp(szllave,sthDetArrastre.szLlaveArrastre[iIndice])==0)
        {
            sprintf(szllave,"%s",sthDetArrastre.szLlaveArrastre[iIndice]);
            iIndice --;
        }
        else   { *iInicio = iIndice+1; break; }
    }
    if(iIndice < 0) *iInicio = 0;

    iIndice = iPosicion;
    sprintf(szllave,"%s",sthDetArrastre.szLlaveArrastre[iPosicion]);
    vDTrazasLog("","Busca_RangoCliente 2\tindice=%d Inicio=%d Termino=%d Fin=%d llave=[%s]\n",LOG06,iIndice,*iInicio,*iTermino,iFin,szllave);
    while(iIndice < iFin && *iTermino == 0)
    {
        if(strcmp(szllave,sthDetArrastre.szLlaveArrastre[iIndice])==0)
        {
            sprintf(szllave,"%s",sthDetArrastre.szLlaveArrastre[iIndice]);
            iIndice ++;
        }
        else { *iTermino = iIndice-1; break; } 
    }
    if(iIndice >= iFin) *iTermino = iFin-1;

    vDTrazasLog("","Busca_RangoCliente SALIDA \tindice=%d Inicio=%d Termino=%d\n",LOG06,iIndice,iInicio,iTermino);

    return(TRUE);
}
/****************Final de Busca_RangoCliente ******************************************/

int BuscaCliente(char *szllave,int derecha)
{  int centro;
   int izquierda;

   izquierda = 0;
   while(izquierda <= derecha)
   {
        centro = (izquierda + derecha) / 2;
        if(strcmp(szllave,sthDetArrastre.szLlaveArrastre[centro])<0) {derecha = centro - 1;}
        else {
           if(strcmp(szllave,sthDetArrastre.szLlaveArrastre[centro])>0) {izquierda = centro + 1;}
           else { return(centro); }
        }
   }
   return(-1);
}
/****************Final de BuscaCliente *******************/

int busca_arrastre(char *szllave,int *iInicio,int *iTermino)
{
    int iPosicionCliente;
    int iderecha;

    iderecha = sthDetArrastre.iCantidadArrastre;
    vDTrazasLog("","busca_arrastre ENTRADA \tLlave [%s] derecha=%ld",LOG06,szllave,iderecha);
    iPosicionCliente = BuscaCliente(szllave,iderecha);

    if(iPosicionCliente != -1)
    {
        vDTrazasLog("","busca_arrastre 1\tPosicion de llave [%s] es [%d]",LOG06,szllave,iPosicionCliente);
        *iInicio=0;
        *iTermino=0;
        if(!Busca_RangoCliente(iPosicionCliente,iInicio,iTermino,iderecha))
        {
            vDTrazasLog("","busca_arrastre\tCliente [%s] sin Arrastre ",LOG03,szllave);
            return(FALSE);
        }
        vDTrazasLog("","busca_arrastre 2\tPosicion del Cliente [%s] es [%d]  Inicio=%d Termino=%d"
                      ,LOG06,szllave,iPosicionCliente, *iInicio, *iTermino);
    }
    else
    {
        vDTrazasLog("","busca_arrastre\tLlave [%s] sin Arrastre ",LOG06,szllave);
        return(FALSE);
    }
    vDTrazasLog("","busca_arrastre SALIDA \tInicio=%d Termino=%d\n",LOG06,*iInicio, *iTermino);
    return(TRUE);
}
/****************Final de busca_arrastre *******************/

int CargaFadParametros( void )
{
    register int i,j;

    strcpy (szModulo, "CargaFadParametros");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL
        SELECT COD_PARAMETRO,
               DES_PARAMETRO,
               NVL(TIP_PARAMETRO,'NUMBER'),
               NVL(VAL_NUMERICO,0),
               NVL(VAL_CARACTER,'0'),
               NVL(VAL_FECHA,SYSDATE),
               vsize(NVL(VAL_CARACTER,'0'))
         INTO :sthFadParametros
         FROM FAD_PARAMETROS
        WHERE COD_MODULO='FA'
        ORDER BY COD_MODULO,COD_PARAMETRO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PARAMETRO ,DES_PARAMETRO ,NVL(TIP_PARAMETRO,'N\
UMBER') ,NVL(VAL_NUMERICO,0) ,NVL(VAL_CARACTER,'0') ,NVL(VAL_FECHA,SYSDATE) ,v\
size(NVL(VAL_CARACTER,'0')) into :s1 ,:s2 ,:s3 ,:s4 ,:s5 ,:s6 ,:s7   from FAD_\
PARAMETROS where COD_MODULO='FA' order by COD_MODULO,COD_PARAMETRO ";
    sqlstm.iters = (unsigned int  )1001;
    sqlstm.offset = (unsigned int  )1093;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)sthFadParametros.cod_parametro;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)sthFadParametros.des_parametro;
    sqlstm.sqhstl[1] = (unsigned long )1024;
    sqlstm.sqhsts[1] = (         int  )1024;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)sthFadParametros.tip_parametro;
    sqlstm.sqhstl[2] = (unsigned long )32;
    sqlstm.sqhsts[2] = (         int  )32;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)sthFadParametros.val_numerico;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)sthFadParametros.val_caracter;
    sqlstm.sqhstl[4] = (unsigned long )512;
    sqlstm.sqhsts[4] = (         int  )512;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)sthFadParametros.val_fecha;
    sqlstm.sqhstl[5] = (unsigned long )9;
    sqlstm.sqhsts[5] = (         int  )9;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)sthFadParametros.val_cantidad;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(((sqlca.sqlcode != SQLOK) && (sqlca.sqlcode != SQLNOTFOUND)) || (sqlca.sqlerrd[2]==0))
    {
       vDTrazasLog(szModulo, "Error en SELECT de FAD_PARAMETROS [%d]", LOG02, sqlca.sqlcode);
       return (FALSE);
    }

    for( i = 1;i <= sqlca.sqlerrd[2];i++)
    {
      j = sthFadParametros.cod_parametro[sqlca.sqlerrd[2]-i];
      sthFadParametros.cod_parametro[j] = sthFadParametros.cod_parametro[sqlca.sqlerrd[2]-i];
      strcpy(sthFadParametros.des_parametro[j], sthFadParametros.des_parametro[sqlca.sqlerrd[2]-i]);
      strcpy(sthFadParametros.tip_parametro[j], sthFadParametros.tip_parametro[sqlca.sqlerrd[2]-i]);
      sthFadParametros.val_numerico[j] = sthFadParametros.val_numerico[sqlca.sqlerrd[2]-i];
      strcpy(sthFadParametros.val_caracter[j], sthFadParametros.val_caracter[sqlca.sqlerrd[2]-i]);
      strcpy(sthFadParametros.val_fecha[j], sthFadParametros.val_fecha[sqlca.sqlerrd[2]-i]);
      sthFadParametros.val_cantidad[j] = sthFadParametros.val_cantidad[sqlca.sqlerrd[2]-i];

      sthFadParametros.cod_parametro[sqlca.sqlerrd[2]-i] = 0;
      memset(sthFadParametros.des_parametro[sqlca.sqlerrd[2]-i],0,sizeof(sthFadParametros.des_parametro[sqlca.sqlerrd[2]-i]));
      memset(sthFadParametros.tip_parametro[sqlca.sqlerrd[2]-i],0,sizeof(sthFadParametros.tip_parametro[sqlca.sqlerrd[2]-i]));
      sthFadParametros.val_numerico[sqlca.sqlerrd[2]-i] = 0;
      memset(sthFadParametros.val_caracter[sqlca.sqlerrd[2]-i],0,sizeof(sthFadParametros.val_caracter[sqlca.sqlerrd[2]-i]));
      memset(sthFadParametros.val_fecha[sqlca.sqlerrd[2]-i],0,sizeof(sthFadParametros.val_fecha[sqlca.sqlerrd[2]-i]));
      sthFadParametros.val_cantidad[sqlca.sqlerrd[2]-i] = 0;
    }
    return(TRUE);
}

int GargaGedParametros( void )
{
 
    strcpy (szModulo, "GargaGedParametros");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL
    SELECT NVL(A.VAL_PARAMETRO,'HH24MISS'),
           NVL(B.VAL_PARAMETRO,'DDMMYYYY'),
           SUBSTR(C.VAL_PARAMETRO,1,5) ,
           D.VAL_PARAMETRO,
           E.COD_ABONOCEL,
           F.VAL_PARAMETRO
      INTO :szformato_hora,:szformato_fecha,:szhIdiomaOper,:szNumDecimal,:iCodAbonoCel,
           :szAplica_Cod_Autorizacion
      FROM GED_PARAMETROS A,GED_PARAMETROS B,GED_PARAMETROS C,GED_PARAMETROS D, FA_DATOSGENER E,
           GED_PARAMETROS F
     WHERE A.COD_MODULO = 'GE'   AND A.COD_PRODUCTO=1
       AND A.NOM_PARAMETRO ='FORMATO_SEL20'
       AND B.COD_MODULO= 'GE'   AND B.COD_PRODUCTO=1
       AND B.NOM_PARAMETRO ='FORMATO_SEL6'
       AND C.COD_MODULO= 'GE'   AND C.COD_PRODUCTO=1
       AND C.NOM_PARAMETRO ='IDIOMA_LOCAL'
       AND D.COD_MODULO= 'GE'   AND D.COD_PRODUCTO=1
       AND D.NOM_PARAMETRO ='NUM_DECIMAL'
       AND F.NOM_PARAMETRO = 'APLICA_CODAUTORIZA'
       AND F.COD_MODULO = 'FA'
       AND F.COD_PRODUCTO = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(A.VAL_PARAMETRO,'HH24MISS') ,NVL(B.VAL_PARAMET\
RO,'DDMMYYYY') ,SUBSTR(C.VAL_PARAMETRO,1,5) ,D.VAL_PARAMETRO ,E.COD_ABONOCEL ,\
F.VAL_PARAMETRO into :b0,:b1,:b2,:b3,:b4,:b5  from GED_PARAMETROS A ,GED_PARAM\
ETROS B ,GED_PARAMETROS C ,GED_PARAMETROS D ,FA_DATOSGENER E ,GED_PARAMETROS F\
 where ((((((((((((((A.COD_MODULO='GE' and A.COD_PRODUCTO=1) and A.NOM_PARAMET\
RO='FORMATO_SEL20') and B.COD_MODULO='GE') and B.COD_PRODUCTO=1) and B.NOM_PAR\
AMETRO='FORMATO_SEL6') and C.COD_MODULO='GE') and C.COD_PRODUCTO=1) and C.NOM_\
PARAMETRO='IDIOMA_LOCAL') and D.COD_MODULO='GE') and D.COD_PRODUCTO=1) and D.N\
OM_PARAMETRO='NUM_DECIMAL') and F.NOM_PARAMETRO='APLICA_CODAUTORIZA') and F.CO\
D_MODULO='FA') and F.COD_PRODUCTO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1136;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szformato_hora;
    sqlstm.sqhstl[0] = (unsigned long )9;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szformato_fecha;
    sqlstm.sqhstl[1] = (unsigned long )22;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdiomaOper;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szNumDecimal;
    sqlstm.sqhstl[3] = (unsigned long )21;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&iCodAbonoCel;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szAplica_Cod_Autorizacion;
    sqlstm.sqhstl[5] = (unsigned long )2;
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




    if (sqlca.sqlcode != SQLOK )
    {
        vDTrazasLog(szModulo, "Error en SELECT de GED_PARAMETROS [%d]", LOG02, sqlca.sqlcode);
        return (FALSE);
    }
    return (TRUE);
}

/*Modificacisn Proyecto Ecu-05002 Codigo de Autorizacisn.
  Se crea funcion szfnObtieneCod_autorizacion que es llamada cuando aplica Codigo Autorizaicon. Esta funcion
  rescata el valor del codigo de autorizacion y dejarlo disponible para imprimirlo en el documento.
  Se debe diferenciar entre los documentos ciclicos y los no ciclicos
*/

int szfnObtieneCod_autorizacion (LINEACOMANDO * ParametrosEntrada)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodCiclFact;
        char    szhCodAutorizacion[11];/* EXEC SQL VAR szhCodAutorizacion IS STRING(11); */ 

        char    szhFecVencimiento [10];/* EXEC SQL VAR szhFecVencimiento  IS STRING(10); */ 

    /* EXEC SQL END DECLARE SECTION; */ 



    strcpy (szModulo, "ObtieneCod_autorizacion");
    vDTrazasLog(szModulo,"\tEntrando a [%s] ",LOG04,szModulo);

    if (ParametrosEntrada->lCodCiclFact)
    {
        lhCodCiclFact = ParametrosEntrada->lCodCiclFact;

        /* EXEC SQL
            SELECT
                A.COD_AUTORIZACION,
                NVL((TO_CHAR(A.FEC_TERMINO,'YYYYMMDD')),' ')
            INTO
                :szhCodAutorizacion,
                :szhFecVencimiento
            FROM
                AL_AUTORIZACION_FOLIO_TD A,
                FA_CICLFACT B,
                GED_CODIGOS C
            WHERE
                B.COD_CICLFACT = :lhCodCiclFact
                AND B.FEC_EMISION BETWEEN A.FEC_DESDE AND A.FEC_TERMINO
                AND C.COD_MODULO= 'AL'
                AND C.NOM_TABLA = 'AL_AUTORIZACION_FOLIO_TD'
                AND A.COD_SISTEMA = C.COD_VALOR; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select A.COD_AUTORIZACION ,NVL(TO_CHAR(A.FEC_TERMINO,\
'YYYYMMDD'),' ') into :b0,:b1  from AL_AUTORIZACION_FOLIO_TD A ,FA_CICLFACT B \
,GED_CODIGOS C where ((((B.COD_CICLFACT=:b2 and B.FEC_EMISION between A.FEC_DE\
SDE and A.FEC_TERMINO) and C.COD_MODULO='AL') and C.NOM_TABLA='AL_AUTORIZACION\
_FOLIO_TD') and A.COD_SISTEMA=C.COD_VALOR)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1175;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodAutorizacion;
        sqlstm.sqhstl[0] = (unsigned long )11;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecVencimiento;
        sqlstm.sqhstl[1] = (unsigned long )10;
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



        if (sqlca.sqlcode != SQLOK )
        {
            vDTrazasLog(szModulo, "Error en SELECT de ObtieneCod_autorizacion [%d]", LOG02, sqlca.sqlcode);
            return (FALSE);
        }

        strcpy(stAutorizFolio.szCodAutorizacion,szhCodAutorizacion);
        strcpy(stAutorizFolio.szFechaVencimiento,szhFecVencimiento);

        return (TRUE);
    }
    else
    {
        /* EXEC SQL
            SELECT
                A.COD_AUTORIZACION,
                NVL((TO_CHAR(A.FEC_TERMINO,'YYYYMMDD')),' ')
            INTO
                :szhCodAutorizacion,
                :szhFecVencimiento
            FROM
                AL_AUTORIZACION_FOLIO_TD A
            WHERE
                SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_TERMINO; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select A.COD_AUTORIZACION ,NVL(TO_CHAR(A.FEC_TERMINO,\
'YYYYMMDD'),' ') into :b0,:b1  from AL_AUTORIZACION_FOLIO_TD A where SYSDATE b\
etween A.FEC_DESDE and A.FEC_TERMINO";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1202;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodAutorizacion;
        sqlstm.sqhstl[0] = (unsigned long )11;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecVencimiento;
        sqlstm.sqhstl[1] = (unsigned long )10;
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



        if (sqlca.sqlcode != SQLOK )
        {
            vDTrazasLog(szModulo, "Else: Error en SELECT de ObtieneCod_autorizacion [%d]", LOG02, sqlca.sqlcode);
            return (FALSE);
        }

        strcpy(stAutorizFolio.szCodAutorizacion,szhCodAutorizacion);
        strcpy(stAutorizFolio.szFechaVencimiento,szhFecVencimiento);

        return (TRUE);

    }
}

/****************************************************************************************/
/* FUNCION : OpenFactDocuClie                                                           */
/* DESCRIPCION : Prepara consulta sobre Tabla FA_FACTDOCU con los documentos a Imprimir */
/****************************************************************************************/
int OpenFactDocuClie (LINEACOMANDO *ParEnt)
{
    char  szTabla1    [50]    ="";
    char  szTabla2    [50]    ="";
    char  szTabla3    [350]   ="";  
    char  szCadenaSQL [2500]  ="";  

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int   ihCodTipDocum;
        char  *szhCodDespacho;  
        int   ihCodSalida;
        long  lhProceso;        
        int   ihCodEstProc;
        int   ihOpcionRango;
        long  lhCodClienteIni;
        long  lhCodClienteFin;
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCodTipDocum=ParEnt->iCodTipDocum ;    
    szhCodDespacho=ParEnt->szCodDespacho;   
    ihCodSalida = ParEnt->iCodSalida;       
    lhProceso = ParEnt->lProceso;           

    strcpy (szModulo, "OpenFactDocuClie");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    if (!ParEnt->iTipoCiclo)
    {
        sprintf(szTabla1,"FA_FACTDOCU_%ld",ParEnt->lCodCiclFact);
        sprintf(szTabla2,"FA_FACTCLIE_%ld",ParEnt->lCodCiclFact);

        sprintf(szCadenaSQL,"SELECT A.ROWID,"
                        "\n A.IND_ORDENTOTAL,"
                        "\n A.COD_CLIENTE,"
                        "\n NVL(A.NUM_CTC,0),"
                        "\n TO_CHAR(A.FEC_EMISION,'YYYYMMDD'),"
                        "\n TO_CHAR(NVL(A.FEC_VENCIMIE,SYSDATE),'YYYYMMDDHH24MISS'),"
                        "\n NVL(A.COD_DESPACHO,'DESNO'),"
                        "\n NVL(D.NOM_HEADER,' '),"
                        "\n A.COD_TIPDOCUM,"
                        "\n A.NUM_FOLIO,"
                        "\n C.COD_GENARCH,"
                        "\n C.COD_PRIORIDAD,"
                        "\n A.TOT_FACTURA,"
                        "\n NVL(B.NUM_IDENTTRIB,''),"
                        "\n B.NOM_CLIENTE||' '||B.NOM_APECLIEN1||' '||B.NOM_APECLIEN2,"
                        "\n A.TOT_CARGOSME,"
                        "\n NVL(A.IMP_SALDOANT,0),"
                        "\n A.TOT_PAGAR,"
                        "\n DECODE(B.IND_DEBITO,'A','1','0'),"
                        "\n A.TOT_CUOTAS,"
                        "\n NVL(TRIM(B.COD_IDIOMA),'1'),"  
                        "\n A.NUM_PROCESO,"
                        "\n A.PREF_PLAZA," 
                        "\n A.COD_OPERADORA,"
                        "\n A.COD_PLAZA,"
                        "\n A.COD_OFICINA,"
                        "\n A.COD_VENDEDOR,"
                        "\n A.NOM_USUARORA,"
                        "\n E.COD_OPERPLAZA,"
                        "\n A.PREF_PLAZA, "  
                        "\n A.COD_MONEDAIMP, "  
                        "\n NVL(A.IMP_CONVERSION,1), " 
                        "\n NVL(A.NUM_SECUREL,0), "   
                        "\n NVL(A.LETRAREL,' '), "              
                        "\n NVL(A.COD_TIPDOCUMREL,0), "
                        "\n NVL(A.COD_VENDEDOR_AGENTEREL,0), "
                        "\n NVL(A.COD_CENTRREL,0), "          
                        "\n NVL(A.NUM_VENTA,0), "             
                        "\n NVL(A.COD_SEGMENTACION,' '), "    
                        "\n A.NOM_EMAIL, "                    
                        "\n NVL(B.COD_TIPIDTRIB,'00'), "      
                        "\n TO_CHAR(FEC_EMISION,'DD-MM-YYYY HH24:MI:SS'), " 
                        "\n TO_CHAR(A.FEC_ULTMOD,'DD-MM-YYYY HH24:MI:SS'), "
                        "\n A.CONT_TECNICO, "                               
                        "\n A.RESOLUCION, "                          
                        "\n A.FEC_RESOLUCION, "                      
                        "\n A.SERIE, "                               
                        "\n NVL(A.ETIQUETA,' '), "                            
                        "\n NVL(A.RAN_DESDE,0), "                           
                        "\n NVL(A.RAN_HASTA,0), "
                        "\n NVL(A.COD_TIPOLOGIA,' '), "       /* P-MIX-09003 141767 */
                        "\n NVL(A.COD_AREAIMPUTABLE,' '), "   /* P-MIX-09003 141767 */
                        "\n NVL(A.COD_AREASOLICITANTE,' ') "  /* P-MIX-09003 141767 */                        
                    "\nFROM %s A,"
                        "\n %s B,"
                        "\n FA_CODESPACHO C,"
                        "\n FA_PARGENARCH D,"
                        "\n GE_OPERPLAZA_TD E " 
                   "\nWHERE A.TOT_FACTURA         >= 0"
                    "\n AND A.COD_CLIENTE   >= 0"
                    "\n AND A.NUM_FOLIO     >= 0"
                    "\n AND A.IND_SUPERTEL   = 0"
                    "\n AND A.IND_ANULADA    = 0"
                    "\n AND A.IND_FACTUR     = 1"
                    "\n AND A.IND_IMPRESA    = 0"
                    "\n AND A.COD_TIPDOCUM   = :ihCodTipDocum"
                    "\n AND A.COD_DESPACHO   = :szhCodDespacho"
                    "\n AND B.IND_ORDENTOTAL = A.IND_ORDENTOTAL"
                    "\n AND C.COD_DESPACHO   = NVL(A.COD_DESPACHO,'DESNO')"
                    "\n AND D.COD_GENARCH(+) = C.COD_GENARCH"
                    "\n AND A.COD_OPERADORA  = E.COD_OPERADORA_SCL" 
                    "\n AND A.COD_PLAZA      = E.COD_PLAZA"
                    "\n AND ((A.COD_CLIENTE BETWEEN :lhCodClienteIni AND :lhCodClienteFin) OR (1 <> :ihOpcionRango))"
                "\nORDER BY"
                        "\n A.COD_TIPDOCUM,"
                        "\n C.COD_GENARCH,"
                        "\n A.COD_DESPACHO,"
                        "\n A.COD_CLIENTE,"
                        "\n A.IND_ORDENTOTAL"
            ,szTabla1
            ,szTabla2);
    }
    else
    {
        sprintf(szTabla1,"FA_FACTDOCU_NOCICLO");
        sprintf(szTabla2,"FA_FACTCLIE_NOCICLO");
        sprintf(szTabla3,"(SELECT NUM_PROCESO FROM FA_INTERFACT "
                            "\n WHERE COD_ESTADOC=:ihCodSalida AND COD_ESTPROC=:ihCodEstProd "
                            "\n AND NUM_PROCESO = :lhProceso )"
                            ); 

        sprintf(szCadenaSQL,"SELECT"
                         "\n A.ROWID,"
                         "\n A.IND_ORDENTOTAL,"
                         "\n A.COD_CLIENTE,"
                         "\n NVL(A.NUM_CTC,0),"
                         "\n TO_CHAR(A.FEC_EMISION,'YYYYMMDD'),"
                         "\n TO_CHAR(NVL(A.FEC_VENCIMIE,SYSDATE),'YYYYMMDDHH24MISS'),"
                         "\n NVL(A.COD_DESPACHO,'DESNO'),"
                         "\n NVL(D.NOM_HEADER,' '),"
                         "\n A.COD_TIPDOCUM,"
                         "\n A.NUM_FOLIO,"
                         "\n C.COD_GENARCH,"
                         "\n C.COD_PRIORIDAD,"
                         "\n A.TOT_FACTURA,"                         
                         "\n NVL(B.NUM_IDENTTRIB,''),"
                         "\n B.NOM_CLIENTE||' '||B.NOM_APECLIEN1||' '||B.NOM_APECLIEN2,"
                         "\n A.TOT_CARGOSME,"
                         "\n NVL(A.IMP_SALDOANT,0),"
                         "\n A.TOT_PAGAR,"
                         "\n DECODE(B.IND_DEBITO,'A','1','0'),"
                         "\n A.TOT_CUOTAS,"
                         "\n NVL(B.COD_IDIOMA,'1'),"
                         "\n A.NUM_PROCESO,"
                         "\n A.PREF_PLAZA, " 
                         "\n A.COD_OPERADORA,"
                         "\n A.COD_PLAZA,"
                         "\n A.COD_OFICINA,"
                         "\n A.COD_VENDEDOR,"
                         "\n A.NOM_USUARORA,"
                         "\n F.COD_OPERPLAZA,"
                         "\n A.PREF_PLAZA, "                           
                         "\n A.COD_MONEDAIMP, "
                         "\n NVL(A.IMP_CONVERSION,1), " 
                         "\n NVL(A.NUM_SECUREL,0), "    
                         "\n NVL(A.LETRAREL,' '), "      
                         "\n NVL(A.COD_TIPDOCUMREL,0), " 
                         "\n NVL(A.COD_VENDEDOR_AGENTEREL,0), "
                         "\n NVL(A.COD_CENTRREL,0), "          
                         "\n NVL(A.NUM_VENTA,0), "             
                         "\n NVL(A.COD_SEGMENTACION,' '), "    
                         "\n A.NOM_EMAIL, "                    
                         "\n NVL(B.COD_TIPIDTRIB,'00'), "      
                         "\n TO_CHAR(FEC_EMISION,'DD-MM-YYYY HH24:MI:SS'), "
                         "\n TO_CHAR(A.FEC_ULTMOD,'DD-MM-YYYY HH24:MI:SS'), "
                         "\n A.CONT_TECNICO, "                               
                         "\n A.RESOLUCION, "                            
                         "\n A.FEC_RESOLUCION, "                        
                         "\n A.SERIE, "                                 
                         "\n NVL(A.ETIQUETA,' '), "
                         "\n NVL(A.RAN_DESDE,0), "                             
                         "\n NVL(A.RAN_HASTA,0), "
                         "\n NVL(A.COD_TIPOLOGIA,' '), "       /* P-MIX-09003 141767 */
                         "\n NVL(A.COD_AREAIMPUTABLE,' '), "   /* P-MIX-09003 141767 */
                         "\n NVL(A.COD_AREASOLICITANTE,' ') "  /* P-MIX-09003 141767 */
                 "\nFROM"
                         "\n %s A,"
                         "\n %s B,"
                         "\n FA_CODESPACHO C,"
                         "\n FA_PARGENARCH D,"
                         "\n %s E,"
                         "\n GE_OPERPLAZA_TD F "
                "\nWHERE"
                         "\n A.NUM_PROCESO = E.NUM_PROCESO"
                         "\n AND   B.IND_ORDENTOTAL = A.IND_ORDENTOTAL"
                         "\n AND   C.COD_DESPACHO   = NVL(A.COD_DESPACHO,'DESNO')"
                         "\n AND   D.COD_GENARCH(+) = C.COD_GENARCH"
                         "\n AND   A.COD_OPERADORA  = F.COD_OPERADORA_SCL"
                         "\n AND   A.COD_PLAZA      = F.COD_PLAZA"
                 "\nORDER BY"
                         "\n A.COD_TIPDOCUM,"
                         "\n C.COD_GENARCH,"
                         "\n A.COD_DESPACHO,"
                         "\n A.COD_CLIENTE,"
                         "\n A.IND_ORDENTOTAL"
             ,szTabla1
             ,szTabla2
             ,szTabla3);

    }
    vDTrazasLog( szModulo,"=> query curFactDocu2 (\n%s\n)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Facturas_DetLlam FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1225;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2500;
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


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo, "Error en PREPARE sql_Facturas_DetLlam. Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE curFactDocu2 CURSOR FOR sql_Facturas_DetLlam; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en DECLARE. curFactDocu2. Error [%d][%s]"
                             , LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    if (!ParEnt->iTipoCiclo)
    {
        ihOpcionRango=igOpcionRango;
        lhCodClienteIni=lgCodClienteIni;
        lhCodClienteFin=lgCodClienteFin;

        vDTrazasLog (szModulo, "** ihCodTipDocum   [%d]"
                               "** szhCodDespacho  [%s]"
                               "** lhCodClienteIni [%ld]"
                               "** lhCodClienteFin [%ld]"
                               "** ihOpcionRango   [%d]"
                               ,LOG03,ihCodTipDocum,szhCodDespacho
                               ,lhCodClienteIni,lhCodClienteFin,ihOpcionRango);

        /* EXEC SQL OPEN curFactDocu2 USING :ihCodTipDocum, :szhCodDespacho, :lhCodClienteIni, :lhCodClienteFin, :ihOpcionRango ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1244;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodDespacho;
        sqlstm.sqhstl[1] = (unsigned long )0;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodClienteIni;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodClienteFin;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihOpcionRango;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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


    }
    else
    {
        ihCodEstProc=iPROC_EST_RUN;
        
        vDTrazasLog( szModulo,"\n\n\t CodSalida : [%d] "
                              "\n\t   EstProd   : [%d] "
                              "\n\t   Proceso   : [%ld] "
                             ,LOG05,ihCodSalida,ihCodEstProc,lhProceso);        
        
        /* EXEC SQL OPEN curFactDocu2 USING :ihCodSalida, :ihCodEstProc, :lhProceso; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1279;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodSalida;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodEstProc;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhProceso;
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


    }
    if(sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en OPEN curFactDocu2. Error [%i][%s]",LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    return (TRUE);

}
/**************************** Final iOpenFactDocuClie ****************************/

int FetchFactDocuClie( int * iPaso, int * iLeidos)
{
    register int i;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char    szhRowid              [BUFF_CLIENTE] [19];
         static long    lhIndOrdenTotal       [BUFF_CLIENTE]     ;
         static long    lhCodCliente          [BUFF_CLIENTE]     ;
         static char    szhNumCtc             [BUFF_CLIENTE] [13];
         static char    szhFecEmision         [BUFF_CLIENTE] [9] ;
         static char    szhFecVencimie        [BUFF_CLIENTE] [15];
         static char    szhCodDespacho        [BUFF_CLIENTE] [6] ;
         static char    szhNomHeader          [BUFF_CLIENTE] [6] ;
         static int     ihCodTipDocum         [BUFF_CLIENTE]     ;
         static long    lhNum_Folio           [BUFF_CLIENTE]     ;
         static char    szhCodGenArch         [BUFF_CLIENTE] [3] ;
         static int     ihCodPrioridad        [BUFF_CLIENTE]     ;
         static double  dhTotFactura          [BUFF_CLIENTE]     ;
         static char    szhRut_Cliente        [BUFF_CLIENTE] [21];
         static char    szhNom_Cliente        [BUFF_CLIENTE] [93];
         static double  dhTotCargosMes        [BUFF_CLIENTE]     ;
         static double  dhImpSaldoAnt         [BUFF_CLIENTE]     ;
         static double  dhTotPagar            [BUFF_CLIENTE]     ;
         static char    szhIndDebito          [BUFF_CLIENTE] [20];
         static double  dhTotCuotas           [BUFF_CLIENTE]     ;
         static char    szhCodIdioma          [BUFF_CLIENTE] [6] ;
         static long    lhNumProceso          [BUFF_CLIENTE]     ;
         static char    szhPrefPlaza          [BUFF_CLIENTE][25+1];
         static char    szhCodOperadora       [BUFF_CLIENTE] [6] ;
         static char    szhCodPlaza           [BUFF_CLIENTE] [6] ;
         static char    szhCodOficina         [BUFF_CLIENTE] [3] ;
         static long    lhCodVendedor         [BUFF_CLIENTE]     ;
         static char    szhNomUsuarora        [BUFF_CLIENTE] [31];
         static int     ihCodOperPlaza        [BUFF_CLIENTE]     ;
         static char    szhPrefPlaza_l10      [BUFF_CLIENTE][25+1];
         static char    szhCodMonedaImp       [BUFF_CLIENTE] [4] ; 
         static double  dhImpConversion       [BUFF_CLIENTE]     ; 
         static long    lhNumSecuRel          [BUFF_CLIENTE]     ;    
         static char    szhLetraRel           [BUFF_CLIENTE] [2] ; 
         static int     ihCodTipDocumRel      [BUFF_CLIENTE]     ;    
         static long    lhCodVendedorAgRel    [BUFF_CLIENTE]     ;    
         static long    lhCodCentrRel         [BUFF_CLIENTE]     ;    
         static long    lhNumVenta            [BUFF_CLIENTE]     ;    
         static char    szhCodSegmentacion    [BUFF_CLIENTE] [6] ; 
         static char    szhNomEmail           [BUFF_CLIENTE] [71]; 
         static char    szhCodIdent           [BUFF_CLIENTE] [3] ;  
         static char    szhFecEmi             [BUFF_CLIENTE] [20]; 
         static char    szhFecUltMod          [BUFF_CLIENTE] [20]; 
         static char    szhContTecnico        [BUFF_CLIENTE] [41];    
         static char    szhResolucion         [BUFF_CLIENTE] [25+1];
         static char    szhFecResolucion      [BUFF_CLIENTE] [10+1];
         static char    szhSerie              [BUFF_CLIENTE] [10+1];
         static char    szhEtiqueta           [BUFF_CLIENTE] [10+1];
         static char    szhCodTipologia       [BUFF_CLIENTE]  [5+1]; /* P-MIX-09003 141767 */
         static char    szhCodAreaImputable   [BUFF_CLIENTE]  [5+1]; /* P-MIX-09003 141767 */
         static char    szhCodAreaSolicitante [BUFF_CLIENTE]  [5+1]; /* P-MIX-09003 141767 */
         static long    lhRanDesde            [BUFF_CLIENTE]       ;
         static long    lhRanHasta            [BUFF_CLIENTE]       ;
         short          i_hIndLetraRel        [BUFF_CLIENTE]       ;
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhRowid             ,0,sizeof( szhRowid             ));
    memset(lhIndOrdenTotal      ,0,sizeof( lhIndOrdenTotal      ));
    memset(lhCodCliente         ,0,sizeof( lhCodCliente         ));
    memset(szhNumCtc            ,0,sizeof( szhNumCtc            ));
    memset(szhFecEmision        ,0,sizeof( szhFecEmision        ));
    memset(szhFecVencimie       ,0,sizeof( szhFecVencimie       ));
    memset(szhCodDespacho       ,0,sizeof( szhCodDespacho       ));
    memset(szhNomHeader         ,0,sizeof( szhNomHeader         ));
    memset(ihCodTipDocum        ,0,sizeof( ihCodTipDocum        ));
    memset(lhNum_Folio          ,0,sizeof( lhNum_Folio          ));
    memset(szhCodGenArch        ,0,sizeof( szhCodGenArch        ));
    memset(ihCodPrioridad       ,0,sizeof( ihCodPrioridad       ));
    memset(dhTotFactura         ,0,sizeof( dhTotFactura         ));
    memset(szhRut_Cliente       ,0,sizeof( szhRut_Cliente       ));
    memset(szhNom_Cliente       ,0,sizeof( szhNom_Cliente       ));
    memset(dhTotCargosMes       ,0,sizeof( dhTotCargosMes       ));
    memset(dhImpSaldoAnt        ,0,sizeof( dhImpSaldoAnt        ));
    memset(dhTotPagar           ,0,sizeof( dhTotPagar           ));
    memset(szhIndDebito         ,0,sizeof( szhIndDebito         ));
    memset(dhTotCuotas          ,0,sizeof( dhTotCuotas          ));
    memset(szhCodIdioma         ,0,sizeof( szhCodIdioma         ));
    memset(lhNumProceso         ,0,sizeof( lhNumProceso         ));
    memset(szhPrefPlaza         ,0,sizeof( szhPrefPlaza         ));
    memset(szhCodOperadora      ,0,sizeof( szhCodOperadora      ));
    memset(szhCodPlaza          ,0,sizeof( szhCodPlaza          ));
    memset(szhCodOficina        ,0,sizeof( szhCodOficina        ));
    memset(lhCodVendedor        ,0,sizeof( lhCodVendedor        ));
    memset(szhNomUsuarora       ,0,sizeof( szhNomUsuarora       ));
    memset(ihCodOperPlaza       ,0,sizeof( ihCodOperPlaza       ));
    memset(szhPrefPlaza_l10     ,0,sizeof( szhPrefPlaza_l10     ));
    memset(szhCodMonedaImp      ,0,sizeof( szhCodMonedaImp      ));
    memset(dhImpConversion      ,0,sizeof( dhImpConversion      ));
    memset(lhNumSecuRel         ,0,sizeof( lhNumSecuRel       ));
    memset(szhLetraRel          ,0,sizeof( szhLetraRel        ));
    memset(ihCodTipDocumRel     ,0,sizeof( ihCodTipDocumRel   ));
    memset(lhCodVendedorAgRel   ,0,sizeof( lhCodVendedorAgRel ));
    memset(lhCodCentrRel        ,0,sizeof( lhCodCentrRel      ));
    memset(lhNumVenta           ,0,sizeof( lhNumVenta         ));
    memset(szhCodSegmentacion   ,0,sizeof( szhCodSegmentacion ));
    memset(szhNomEmail          ,0,sizeof( szhNomEmail        ));
    memset(szhCodIdent          ,0,sizeof( szhCodIdent        ));
    memset(szhFecEmi            ,0,sizeof( szhFecEmi          ));
    memset(szhFecUltMod         ,0,sizeof( szhFecUltMod       ));
    memset(szhContTecnico       ,0,sizeof( szhContTecnico     ));
    memset(szhResolucion        ,0,sizeof( szhResolucion      )); 
    memset(szhFecResolucion     ,0,sizeof( szhFecResolucion   )); 
    memset(szhSerie             ,0,sizeof( szhSerie           )); 
    memset(szhEtiqueta          ,0,sizeof( szhEtiqueta        )); 
    memset(szhCodTipologia      ,0,sizeof( szhCodTipologia      )); /* P-MIX-09003 141767 */
    memset(szhCodAreaImputable  ,0,sizeof( szhCodAreaImputable  )); /* P-MIX-09003 141767 */
    memset(szhCodAreaSolicitante,0,sizeof( szhCodAreaSolicitante)); /* P-MIX-09003 141767 */    
    memset(lhRanDesde           ,0,sizeof( lhRanDesde         )); 
    memset(lhRanHasta           ,0,sizeof( lhRanHasta         )); 

    strcpy (szModulo, "FetchFactDocuClie");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);
    vDTrazasLog (szModulo, "[JQH] A lanzar el FETCH...",LOG05);

    /* EXEC SQL FETCH curFactDocu2
    INTO    :szhRowid        ,
            :lhIndOrdenTotal ,
            :lhCodCliente    ,
            :szhNumCtc       ,            
            :szhFecEmision   ,
            :szhFecVencimie  ,
            :szhCodDespacho  ,
            :szhNomHeader    ,
            :ihCodTipDocum   ,
            :lhNum_Folio     ,
            :szhCodGenArch   ,
            :ihCodPrioridad  ,
            :dhTotFactura    ,
            :szhRut_Cliente  ,
            :szhNom_Cliente  ,
            :dhTotCargosMes  ,
            :dhImpSaldoAnt   ,
            :dhTotPagar      ,
            :szhIndDebito    ,
            :dhTotCuotas     ,
            :szhCodIdioma    ,
            :lhNumProceso    ,            
            :szhPrefPlaza    ,              
            :szhCodOperadora ,
            :szhCodPlaza     ,            
            :szhCodOficina   ,
            :lhCodVendedor   ,            
            :szhNomUsuarora  ,
            :ihCodOperPlaza  , 
            :szhPrefPlaza_l10, 
            :szhCodMonedaImp , 
            :dhImpConversion ,            
            :lhNumSecuRel    ,            
            :szhLetraRel :i_hIndLetraRel ,
            :ihCodTipDocumRel,    
            :lhCodVendedorAgRel,  
            :lhCodCentrRel   ,            
            :lhNumVenta      ,          
            :szhCodSegmentacion,  
            :szhNomEmail     ,         
            :szhCodIdent     ,     
            :szhFecEmi       ,                       
            :szhFecUltMod    ,            
            :szhContTecnico,  
            :szhResolucion,       
            :szhFecResolucion,            
            :szhSerie,          
            :szhEtiqueta,                   
            :lhRanDesde,        
            :lhRanHasta,
            :szhCodTipologia,        /o P-MIX-09003 141767 o/
            :szhCodAreaImputable,    /o P-MIX-09003 141767 o/
            :szhCodAreaSolicitante; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )1306;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[0] = (unsigned long )19;
    sqlstm.sqhsts[0] = (         int  )19;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)lhIndOrdenTotal;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)lhCodCliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhNumCtc;
    sqlstm.sqhstl[3] = (unsigned long )13;
    sqlstm.sqhsts[3] = (         int  )13;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[4] = (unsigned long )9;
    sqlstm.sqhsts[4] = (         int  )9;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFecVencimie;
    sqlstm.sqhstl[5] = (unsigned long )15;
    sqlstm.sqhsts[5] = (         int  )15;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[6] = (unsigned long )6;
    sqlstm.sqhsts[6] = (         int  )6;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhNomHeader;
    sqlstm.sqhstl[7] = (unsigned long )6;
    sqlstm.sqhsts[7] = (         int  )6;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)ihCodTipDocum;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )sizeof(int);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)lhNum_Folio;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )sizeof(long);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhCodGenArch;
    sqlstm.sqhstl[10] = (unsigned long )3;
    sqlstm.sqhsts[10] = (         int  )3;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)ihCodPrioridad;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )sizeof(int);
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)dhTotFactura;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[12] = (         int  )sizeof(double);
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhRut_Cliente;
    sqlstm.sqhstl[13] = (unsigned long )21;
    sqlstm.sqhsts[13] = (         int  )21;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhNom_Cliente;
    sqlstm.sqhstl[14] = (unsigned long )93;
    sqlstm.sqhsts[14] = (         int  )93;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqharc[14] = (unsigned long  *)0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)dhTotCargosMes;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[15] = (         int  )sizeof(double);
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqharc[15] = (unsigned long  *)0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)dhImpSaldoAnt;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[16] = (         int  )sizeof(double);
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqharc[16] = (unsigned long  *)0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)dhTotPagar;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[17] = (         int  )sizeof(double);
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqharc[17] = (unsigned long  *)0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhIndDebito;
    sqlstm.sqhstl[18] = (unsigned long )20;
    sqlstm.sqhsts[18] = (         int  )20;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqharc[18] = (unsigned long  *)0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)dhTotCuotas;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[19] = (         int  )sizeof(double);
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqharc[19] = (unsigned long  *)0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhCodIdioma;
    sqlstm.sqhstl[20] = (unsigned long )6;
    sqlstm.sqhsts[20] = (         int  )6;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqharc[20] = (unsigned long  *)0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)lhNumProceso;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[21] = (         int  )sizeof(long);
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqharc[21] = (unsigned long  *)0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[22] = (unsigned long )26;
    sqlstm.sqhsts[22] = (         int  )26;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqharc[22] = (unsigned long  *)0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[23] = (unsigned long )6;
    sqlstm.sqhsts[23] = (         int  )6;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqharc[23] = (unsigned long  *)0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)szhCodPlaza;
    sqlstm.sqhstl[24] = (unsigned long )6;
    sqlstm.sqhsts[24] = (         int  )6;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqharc[24] = (unsigned long  *)0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[25] = (unsigned long )3;
    sqlstm.sqhsts[25] = (         int  )3;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqharc[25] = (unsigned long  *)0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)lhCodVendedor;
    sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[26] = (         int  )sizeof(long);
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqharc[26] = (unsigned long  *)0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)szhNomUsuarora;
    sqlstm.sqhstl[27] = (unsigned long )31;
    sqlstm.sqhsts[27] = (         int  )31;
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqharc[27] = (unsigned long  *)0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
    sqlstm.sqhstv[28] = (unsigned char  *)ihCodOperPlaza;
    sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[28] = (         int  )sizeof(int);
    sqlstm.sqindv[28] = (         short *)0;
    sqlstm.sqinds[28] = (         int  )0;
    sqlstm.sqharm[28] = (unsigned long )0;
    sqlstm.sqharc[28] = (unsigned long  *)0;
    sqlstm.sqadto[28] = (unsigned short )0;
    sqlstm.sqtdso[28] = (unsigned short )0;
    sqlstm.sqhstv[29] = (unsigned char  *)szhPrefPlaza_l10;
    sqlstm.sqhstl[29] = (unsigned long )26;
    sqlstm.sqhsts[29] = (         int  )26;
    sqlstm.sqindv[29] = (         short *)0;
    sqlstm.sqinds[29] = (         int  )0;
    sqlstm.sqharm[29] = (unsigned long )0;
    sqlstm.sqharc[29] = (unsigned long  *)0;
    sqlstm.sqadto[29] = (unsigned short )0;
    sqlstm.sqtdso[29] = (unsigned short )0;
    sqlstm.sqhstv[30] = (unsigned char  *)szhCodMonedaImp;
    sqlstm.sqhstl[30] = (unsigned long )4;
    sqlstm.sqhsts[30] = (         int  )4;
    sqlstm.sqindv[30] = (         short *)0;
    sqlstm.sqinds[30] = (         int  )0;
    sqlstm.sqharm[30] = (unsigned long )0;
    sqlstm.sqharc[30] = (unsigned long  *)0;
    sqlstm.sqadto[30] = (unsigned short )0;
    sqlstm.sqtdso[30] = (unsigned short )0;
    sqlstm.sqhstv[31] = (unsigned char  *)dhImpConversion;
    sqlstm.sqhstl[31] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[31] = (         int  )sizeof(double);
    sqlstm.sqindv[31] = (         short *)0;
    sqlstm.sqinds[31] = (         int  )0;
    sqlstm.sqharm[31] = (unsigned long )0;
    sqlstm.sqharc[31] = (unsigned long  *)0;
    sqlstm.sqadto[31] = (unsigned short )0;
    sqlstm.sqtdso[31] = (unsigned short )0;
    sqlstm.sqhstv[32] = (unsigned char  *)lhNumSecuRel;
    sqlstm.sqhstl[32] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[32] = (         int  )sizeof(long);
    sqlstm.sqindv[32] = (         short *)0;
    sqlstm.sqinds[32] = (         int  )0;
    sqlstm.sqharm[32] = (unsigned long )0;
    sqlstm.sqharc[32] = (unsigned long  *)0;
    sqlstm.sqadto[32] = (unsigned short )0;
    sqlstm.sqtdso[32] = (unsigned short )0;
    sqlstm.sqhstv[33] = (unsigned char  *)szhLetraRel;
    sqlstm.sqhstl[33] = (unsigned long )2;
    sqlstm.sqhsts[33] = (         int  )2;
    sqlstm.sqindv[33] = (         short *)i_hIndLetraRel;
    sqlstm.sqinds[33] = (         int  )sizeof(short);
    sqlstm.sqharm[33] = (unsigned long )0;
    sqlstm.sqharc[33] = (unsigned long  *)0;
    sqlstm.sqadto[33] = (unsigned short )0;
    sqlstm.sqtdso[33] = (unsigned short )0;
    sqlstm.sqhstv[34] = (unsigned char  *)ihCodTipDocumRel;
    sqlstm.sqhstl[34] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[34] = (         int  )sizeof(int);
    sqlstm.sqindv[34] = (         short *)0;
    sqlstm.sqinds[34] = (         int  )0;
    sqlstm.sqharm[34] = (unsigned long )0;
    sqlstm.sqharc[34] = (unsigned long  *)0;
    sqlstm.sqadto[34] = (unsigned short )0;
    sqlstm.sqtdso[34] = (unsigned short )0;
    sqlstm.sqhstv[35] = (unsigned char  *)lhCodVendedorAgRel;
    sqlstm.sqhstl[35] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[35] = (         int  )sizeof(long);
    sqlstm.sqindv[35] = (         short *)0;
    sqlstm.sqinds[35] = (         int  )0;
    sqlstm.sqharm[35] = (unsigned long )0;
    sqlstm.sqharc[35] = (unsigned long  *)0;
    sqlstm.sqadto[35] = (unsigned short )0;
    sqlstm.sqtdso[35] = (unsigned short )0;
    sqlstm.sqhstv[36] = (unsigned char  *)lhCodCentrRel;
    sqlstm.sqhstl[36] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[36] = (         int  )sizeof(long);
    sqlstm.sqindv[36] = (         short *)0;
    sqlstm.sqinds[36] = (         int  )0;
    sqlstm.sqharm[36] = (unsigned long )0;
    sqlstm.sqharc[36] = (unsigned long  *)0;
    sqlstm.sqadto[36] = (unsigned short )0;
    sqlstm.sqtdso[36] = (unsigned short )0;
    sqlstm.sqhstv[37] = (unsigned char  *)lhNumVenta;
    sqlstm.sqhstl[37] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[37] = (         int  )sizeof(long);
    sqlstm.sqindv[37] = (         short *)0;
    sqlstm.sqinds[37] = (         int  )0;
    sqlstm.sqharm[37] = (unsigned long )0;
    sqlstm.sqharc[37] = (unsigned long  *)0;
    sqlstm.sqadto[37] = (unsigned short )0;
    sqlstm.sqtdso[37] = (unsigned short )0;
    sqlstm.sqhstv[38] = (unsigned char  *)szhCodSegmentacion;
    sqlstm.sqhstl[38] = (unsigned long )6;
    sqlstm.sqhsts[38] = (         int  )6;
    sqlstm.sqindv[38] = (         short *)0;
    sqlstm.sqinds[38] = (         int  )0;
    sqlstm.sqharm[38] = (unsigned long )0;
    sqlstm.sqharc[38] = (unsigned long  *)0;
    sqlstm.sqadto[38] = (unsigned short )0;
    sqlstm.sqtdso[38] = (unsigned short )0;
    sqlstm.sqhstv[39] = (unsigned char  *)szhNomEmail;
    sqlstm.sqhstl[39] = (unsigned long )71;
    sqlstm.sqhsts[39] = (         int  )71;
    sqlstm.sqindv[39] = (         short *)0;
    sqlstm.sqinds[39] = (         int  )0;
    sqlstm.sqharm[39] = (unsigned long )0;
    sqlstm.sqharc[39] = (unsigned long  *)0;
    sqlstm.sqadto[39] = (unsigned short )0;
    sqlstm.sqtdso[39] = (unsigned short )0;
    sqlstm.sqhstv[40] = (unsigned char  *)szhCodIdent;
    sqlstm.sqhstl[40] = (unsigned long )3;
    sqlstm.sqhsts[40] = (         int  )3;
    sqlstm.sqindv[40] = (         short *)0;
    sqlstm.sqinds[40] = (         int  )0;
    sqlstm.sqharm[40] = (unsigned long )0;
    sqlstm.sqharc[40] = (unsigned long  *)0;
    sqlstm.sqadto[40] = (unsigned short )0;
    sqlstm.sqtdso[40] = (unsigned short )0;
    sqlstm.sqhstv[41] = (unsigned char  *)szhFecEmi;
    sqlstm.sqhstl[41] = (unsigned long )20;
    sqlstm.sqhsts[41] = (         int  )20;
    sqlstm.sqindv[41] = (         short *)0;
    sqlstm.sqinds[41] = (         int  )0;
    sqlstm.sqharm[41] = (unsigned long )0;
    sqlstm.sqharc[41] = (unsigned long  *)0;
    sqlstm.sqadto[41] = (unsigned short )0;
    sqlstm.sqtdso[41] = (unsigned short )0;
    sqlstm.sqhstv[42] = (unsigned char  *)szhFecUltMod;
    sqlstm.sqhstl[42] = (unsigned long )20;
    sqlstm.sqhsts[42] = (         int  )20;
    sqlstm.sqindv[42] = (         short *)0;
    sqlstm.sqinds[42] = (         int  )0;
    sqlstm.sqharm[42] = (unsigned long )0;
    sqlstm.sqharc[42] = (unsigned long  *)0;
    sqlstm.sqadto[42] = (unsigned short )0;
    sqlstm.sqtdso[42] = (unsigned short )0;
    sqlstm.sqhstv[43] = (unsigned char  *)szhContTecnico;
    sqlstm.sqhstl[43] = (unsigned long )41;
    sqlstm.sqhsts[43] = (         int  )41;
    sqlstm.sqindv[43] = (         short *)0;
    sqlstm.sqinds[43] = (         int  )0;
    sqlstm.sqharm[43] = (unsigned long )0;
    sqlstm.sqharc[43] = (unsigned long  *)0;
    sqlstm.sqadto[43] = (unsigned short )0;
    sqlstm.sqtdso[43] = (unsigned short )0;
    sqlstm.sqhstv[44] = (unsigned char  *)szhResolucion;
    sqlstm.sqhstl[44] = (unsigned long )26;
    sqlstm.sqhsts[44] = (         int  )26;
    sqlstm.sqindv[44] = (         short *)0;
    sqlstm.sqinds[44] = (         int  )0;
    sqlstm.sqharm[44] = (unsigned long )0;
    sqlstm.sqharc[44] = (unsigned long  *)0;
    sqlstm.sqadto[44] = (unsigned short )0;
    sqlstm.sqtdso[44] = (unsigned short )0;
    sqlstm.sqhstv[45] = (unsigned char  *)szhFecResolucion;
    sqlstm.sqhstl[45] = (unsigned long )11;
    sqlstm.sqhsts[45] = (         int  )11;
    sqlstm.sqindv[45] = (         short *)0;
    sqlstm.sqinds[45] = (         int  )0;
    sqlstm.sqharm[45] = (unsigned long )0;
    sqlstm.sqharc[45] = (unsigned long  *)0;
    sqlstm.sqadto[45] = (unsigned short )0;
    sqlstm.sqtdso[45] = (unsigned short )0;
    sqlstm.sqhstv[46] = (unsigned char  *)szhSerie;
    sqlstm.sqhstl[46] = (unsigned long )11;
    sqlstm.sqhsts[46] = (         int  )11;
    sqlstm.sqindv[46] = (         short *)0;
    sqlstm.sqinds[46] = (         int  )0;
    sqlstm.sqharm[46] = (unsigned long )0;
    sqlstm.sqharc[46] = (unsigned long  *)0;
    sqlstm.sqadto[46] = (unsigned short )0;
    sqlstm.sqtdso[46] = (unsigned short )0;
    sqlstm.sqhstv[47] = (unsigned char  *)szhEtiqueta;
    sqlstm.sqhstl[47] = (unsigned long )11;
    sqlstm.sqhsts[47] = (         int  )11;
    sqlstm.sqindv[47] = (         short *)0;
    sqlstm.sqinds[47] = (         int  )0;
    sqlstm.sqharm[47] = (unsigned long )0;
    sqlstm.sqharc[47] = (unsigned long  *)0;
    sqlstm.sqadto[47] = (unsigned short )0;
    sqlstm.sqtdso[47] = (unsigned short )0;
    sqlstm.sqhstv[48] = (unsigned char  *)lhRanDesde;
    sqlstm.sqhstl[48] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[48] = (         int  )sizeof(long);
    sqlstm.sqindv[48] = (         short *)0;
    sqlstm.sqinds[48] = (         int  )0;
    sqlstm.sqharm[48] = (unsigned long )0;
    sqlstm.sqharc[48] = (unsigned long  *)0;
    sqlstm.sqadto[48] = (unsigned short )0;
    sqlstm.sqtdso[48] = (unsigned short )0;
    sqlstm.sqhstv[49] = (unsigned char  *)lhRanHasta;
    sqlstm.sqhstl[49] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[49] = (         int  )sizeof(long);
    sqlstm.sqindv[49] = (         short *)0;
    sqlstm.sqinds[49] = (         int  )0;
    sqlstm.sqharm[49] = (unsigned long )0;
    sqlstm.sqharc[49] = (unsigned long  *)0;
    sqlstm.sqadto[49] = (unsigned short )0;
    sqlstm.sqtdso[49] = (unsigned short )0;
    sqlstm.sqhstv[50] = (unsigned char  *)szhCodTipologia;
    sqlstm.sqhstl[50] = (unsigned long )6;
    sqlstm.sqhsts[50] = (         int  )6;
    sqlstm.sqindv[50] = (         short *)0;
    sqlstm.sqinds[50] = (         int  )0;
    sqlstm.sqharm[50] = (unsigned long )0;
    sqlstm.sqharc[50] = (unsigned long  *)0;
    sqlstm.sqadto[50] = (unsigned short )0;
    sqlstm.sqtdso[50] = (unsigned short )0;
    sqlstm.sqhstv[51] = (unsigned char  *)szhCodAreaImputable;
    sqlstm.sqhstl[51] = (unsigned long )6;
    sqlstm.sqhsts[51] = (         int  )6;
    sqlstm.sqindv[51] = (         short *)0;
    sqlstm.sqinds[51] = (         int  )0;
    sqlstm.sqharm[51] = (unsigned long )0;
    sqlstm.sqharc[51] = (unsigned long  *)0;
    sqlstm.sqadto[51] = (unsigned short )0;
    sqlstm.sqtdso[51] = (unsigned short )0;
    sqlstm.sqhstv[52] = (unsigned char  *)szhCodAreaSolicitante;
    sqlstm.sqhstl[52] = (unsigned long )6;
    sqlstm.sqhsts[52] = (         int  )6;
    sqlstm.sqindv[52] = (         short *)0;
    sqlstm.sqinds[52] = (         int  )0;
    sqlstm.sqharm[52] = (unsigned long )0;
    sqlstm.sqharc[52] = (unsigned long  *)0;
    sqlstm.sqadto[52] = (unsigned short )0;
    sqlstm.sqtdso[52] = (unsigned short )0;
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

  /* P-MIX-09003 141767 */
            
    if((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
        vDTrazasError(szModulo,"\t\tError en Fetch FetchFactDocuClie : %s", LOG01, SQLERRM);
        vDTrazasLog  (szModulo,"\t\tError en Fetch FetchFactDocuClie : %s", LOG01, SQLERRM);
        return(SQLCODE);
    }

    vDTrazasLog (szModulo, "Datos traidos: [%d]",LOG05,sqlca.sqlerrd[2]);

    if (*iLeidos == 0)
        *iLeidos = sqlca.sqlerrd[2];
    else
        *iLeidos = sqlca.sqlerrd[2] - *iPaso;

    *iPaso = sqlca.sqlerrd[2];

    for (i =0 ; i < *iLeidos; i++)
    {
        FacturaCliente[i].lIndOrdenTotal     = lhIndOrdenTotal[i];
        FacturaCliente[i].lCodCliente        = lhCodCliente[i];
        FacturaCliente[i].iCodTipDocum       = ihCodTipDocum[i];
        FacturaCliente[i].lNum_Folio         = lhNum_Folio[i];
        FacturaCliente[i].iCodPrioridad      = ihCodPrioridad[i];
        FacturaCliente[i].dTotFactura        = dhTotFactura[i];
        FacturaCliente[i].dTotCargosMes      = dhTotCargosMes[i];
        FacturaCliente[i].dImpSaldoAnt       = dhImpSaldoAnt[i];
        FacturaCliente[i].dTotPagar          = dhTotPagar[i];
        FacturaCliente[i].dTotCuotas         = dhTotCuotas[i];
        FacturaCliente[i].lNumProceso        = lhNumProceso[i];
        FacturaCliente[i].lCodVendedor       = lhCodVendedor[i];
        FacturaCliente[i].iCodOperPlaza      = ihCodOperPlaza[i];
        FacturaCliente[i].lNumSecuRel        = lhNumSecuRel[i];       
        FacturaCliente[i].iCodTipDocumRel    = ihCodTipDocumRel[i];   
        FacturaCliente[i].lCodVendedorAgRel  = lhCodVendedorAgRel[i]; 
        FacturaCliente[i].lCodCentrRel       = lhCodCentrRel[i];      
        FacturaCliente[i].lNumVenta          = lhNumVenta[i];         
        FacturaCliente[i].dImpConversion  = ((dhImpConversion[i] == 0)? 1:dhImpConversion[i]);        
        FacturaCliente[i].lRanDesde          = lhRanDesde[i];         
        FacturaCliente[i].lRanHasta          = lhRanHasta[i];                 

        strcpy(FacturaCliente[i].szIndDebito      , alltrim(szhIndDebito[i]));
        strcpy(FacturaCliente[i].szRowid          , alltrim(szhRowid[i]));
        strcpy(FacturaCliente[i].szRut_Cliente    , alltrim(szhRut_Cliente[i]));
        strcpy(FacturaCliente[i].szNombre_Clie    , alltrim(szhNom_Cliente[i]));
        strcpy(FacturaCliente[i].szNumCtc         , alltrim(szhNumCtc[i]));
        strcpy(FacturaCliente[i].szCodDespacho    , alltrim(szhCodDespacho[i]));
        strcpy(FacturaCliente[i].szNomHeader      , alltrim(szhNomHeader[i]));
        strcpy(FacturaCliente[i].szCodGenArch     , alltrim(szhCodGenArch[i]));
        strcpy(FacturaCliente[i].szCod_Idioma     , alltrim(szhCodIdioma[i]));
        strcpy(FacturaCliente[i].szFecEmision     , alltrim(szhFecEmision[i]));
        strcpy(FacturaCliente[i].szFecVencimie    , alltrim(szhFecVencimie[i]));
        strcpy(FacturaCliente[i].szPrefPlaza      , alltrim(szhPrefPlaza[i]));
        strcpy(FacturaCliente[i].szCodOperadora   , alltrim(szhCodOperadora[i]));
        strcpy(FacturaCliente[i].szCodPlaza       , alltrim(szhCodPlaza[i]));
        strcpy(FacturaCliente[i].szCod_Oficina    , alltrim(szhCodOficina[i]));
        strcpy(FacturaCliente[i].szNomUsuarora    , alltrim(szhNomUsuarora[i]));
        strcpy(FacturaCliente[i].szCodMonedaImp   , alltrim(szhCodMonedaImp[i]));
        strcpy(FacturaCliente[i].szCodSegmentacion, alltrim(szhCodSegmentacion[i]));
        strcpy(FacturaCliente[i].szNomEmail       , alltrim(szhNomEmail[i]));       
        strcpy(FacturaCliente[i].szCodIdent       , alltrim(szhCodIdent[i])); 
        strcpy(FacturaCliente[i].szFecEmi         , alltrim(szhFecEmi[i]));   
        strcpy(FacturaCliente[i].szFecUltMod      , alltrim(szhFecUltMod[i]));
        strcpy(FacturaCliente[i].szContTecnico    , alltrim(szhContTecnico[i]));
        strcpy(FacturaCliente[i].szResolucion     , alltrim(szhResolucion[i]));     
        strcpy(FacturaCliente[i].szFecResolucion  , alltrim(szhFecResolucion[i]));  
        strcpy(FacturaCliente[i].szSerie          , alltrim(szhSerie[i]));          
        strcpy(FacturaCliente[i].szEtiqueta       , alltrim(szhEtiqueta[i]));       
        strcpy(FacturaCliente[i].szCodTipologia   , alltrim(szhCodTipologia[i]));         /* P-MIX-09003 141767 */
        strcpy(FacturaCliente[i].szCodAreaImputable  , alltrim(szhCodAreaImputable[i]));  /* P-MIX-09003 141767 */
        strcpy(FacturaCliente[i].szCodAreaSolicitante, alltrim(szhCodAreaSolicitante[i]));/* P-MIX-09003 141767 */              

        if(i_hIndLetraRel[i]!=ORA_NULL)
            strcpy(FacturaCliente[i].szLetraRel   , alltrim(szhLetraRel[i]));   
    }
    return(TRUE);
}
/**************************** Final FetchFactDocuClie ****************************/

int CloseFactDocuClie (void)
{
    vDTrazasLog("", "Entro a iCloseFactDocuClie ", LOG05);
    /* EXEC SQL CLOSE curFactDocu2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1533;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog ("CloseFactDocuClie", "Error en CLOSE curFactDocu2. Error [%i][%s]"
                                        , LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }
    return (1);
}
/************************ Final iCloseFactDocuClie ******************************/

int OpenMinutoAdicional( void )
{
    strcpy (szModulo, "OpenMinutoAdicional");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL DECLARE curMinAdicional CURSOR FOR
                SELECT  A.COD_PLAN,
                        B.CON_CLIENTE||B.COD_THOR||B.COD_TDIR,
                        A.MTO_ADIC
                  FROM  TOL_ESTCOBRO A, TOL_AGRULLAM B
                 WHERE  A.COD_OPERADOR > ' '
                   AND  A.COD_PLAN > ' '
                   AND  A.COD_AGRULLAM = B.COD_AGRULLAM
                   AND  B.COD_LLAM = 'LOC'
                   AND  B.COD_SENTIDO= 'S'
                   AND  A.COD_TDIA = '1'
                   AND  B.CON_CLIENTE in ('HM','VI')
                   AND  B.COD_THOR in ('O','N')
                   AND  B.COD_TDIR in ('PP','PPR')
              ORDER BY  A.COD_PLAN,B.CON_CLIENTE,B.COD_THOR,B.COD_TDIR; */ 


    /* EXEC SQL OPEN curMinAdicional; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0040;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1548;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-OPEN CURSOR curMinAdicional **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-OPEN CURSOR curMinAdicional **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }
    return (SQLCODE);
}
/*********************** Final de OpenMinutoAdicional***********************/
/****************************************************************************/

int FetchMinutoAdicional ( void )
{
    int i;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    /* VARCHAR szhCodPlan              [MAX_MINUTOADICIONAL][6] ; */ 
struct { unsigned short len; unsigned char arr[6]; } szhCodPlan[5000];

        /* VARCHAR szhLlaveMinutoAdicional [MAX_MINUTOADICIONAL][7] ; */ 
struct { unsigned short len; unsigned char arr[10]; } szhLlaveMinutoAdicional[5000];

        double  dhMtoAdicional          [MAX_MINUTOADICIONAL]    ;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "FetchMinutoAdicional");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL
    FETCH curMinAdicional
    INTO :szhCodPlan,
         :szhLlaveMinutoAdicional,
         :dhMtoAdicional; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )1563;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlan;
    sqlstm.sqhstl[0] = (unsigned long )8;
    sqlstm.sqhsts[0] = (         int  )8;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhLlaveMinutoAdicional;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )12;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)dhMtoAdicional;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[2] = (         int  )sizeof(double);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
        vDTrazasError(szModulo,"\t\tError en Fetch FetchMinutoAdicional : %s", LOG01, SQLERRM);
        return(SQLCODE);
    }

    sthMinutoAdicional.iCantidadMinutoAdicional = sqlca.sqlerrd[2];

    for (i =0 ; i < sthMinutoAdicional.iCantidadMinutoAdicional; i++)
    {
         sthMinutoAdicional.dMtoAdicional[i] = dhMtoAdicional[i];

         sprintf(sthMinutoAdicional.szCodPlan[i]             ,"%.*s\0",
                 szhCodPlan[i].len,szhCodPlan[i].arr);
         sprintf(sthMinutoAdicional.szLlaveMinutoAdicional[i],"%.*s\0",
                 szhLlaveMinutoAdicional[i].len,szhLlaveMinutoAdicional[i].arr);
    }
    return(SQLCODE);
}

/*************************** Final de FetchMinutoAdicional ***************************/
/****************************************************************************/

int CloseMinutoAdicional(void)
{
    strcpy (szModulo, "CloseMinutoAdicional");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL CLOSE curMinAdicional; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1590;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szModulo,"\tError al cerrar el Cursor Minuto Adicional: %s",LOG01, SQLERRM);
        return FALSE;
    }
    return TRUE;
}
/****************Final de CloseMinutoAdicional *******************/

int CargaMinutoAdicional( void )
{
     int  iSqlDetMinutoAdicional;
     int  rows_to_fetch  = MAX_MINUTOADICIONAL;
     int  rows_before    =  0;
    int  rows_this_time = MAX_MINUTOADICIONAL;

    strcpy (szModulo, "CargaMinutoAdicional");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    iSqlDetMinutoAdicional = OpenMinutoAdicional();

    if(iSqlDetMinutoAdicional == SQLOK)
    {
      while(rows_this_time == rows_to_fetch)
      {
            iSqlDetMinutoAdicional = FetchMinutoAdicional();
            if((iSqlDetMinutoAdicional != SQLOK)&&(iSqlDetMinutoAdicional != SQLNOTFOUND))
            {
                vDTrazasError(szModulo,"\t\tError en Fetch FetchMinutoAdicional : %s", LOG01, SQLERRM);
                return(SQLCODE);
            }

            sthMinutoAdicional.iCantidadMinutoAdicional = sqlca.sqlerrd[2];
            if(sthMinutoAdicional.iCantidadMinutoAdicional > MAX_MINUTOADICIONAL)
            {
               vDTrazasLog  (szModulo,"\tsthMinutoAdicional Sobrepaso Maximo Posible" ,LOG01);
               vDTrazasError(szModulo,"\tsthMinutoAdicional Sobrepaso Maximo Posible" ,LOG01);
               return (FALSE);
            }
            rows_this_time = sthMinutoAdicional.iCantidadMinutoAdicional - rows_before;
            rows_before = sthMinutoAdicional.iCantidadMinutoAdicional;
            vDTrazasLog(szModulo,"\t[%d]-[%d]-[%d]",LOG05,rows_this_time,rows_before,rows_to_fetch);
      }
    }
    if((iSqlDetMinutoAdicional != SQLOK) && (iSqlDetMinutoAdicional != SQLNOTFOUND))
    {
        vDTrazasError(szModulo,  "\t\t Error Oracle   [%s]",LOG01, SQLERRM);
        vDTrazasLog(szModulo,    "\t\t Error Oracle   [%s]",LOG01, SQLERRM);
        return (FALSE);
    }
    if (!CloseMinutoAdicional()) return (FALSE);
    return (TRUE);
}
/************************* Fin CargaMinutoAdicional *************************/

int Busca_RangoPlanes(int iPosicion,int *ihInicio,int *ihTermino,int iFin)
{
   int iIndice;
   int iInicio;
   int iTermino;
   char szllave[6];

   iIndice = iPosicion;
   iInicio = *ihInicio;
   iTermino = *ihTermino;

   sprintf(szllave,"%s",sthMinutoAdicional.szCodPlan[iPosicion]);
   while(iIndice >= 0 && iInicio == 0)
   {
        if(strcmp(szllave,sthMinutoAdicional.szCodPlan[iIndice])==0)
        {
            sprintf(szllave,"%s",sthMinutoAdicional.szCodPlan[iIndice]);
            iIndice--;
        }
        else
        {
            iInicio = iIndice+1;
        }
   }
   if(iIndice < 0) iInicio = 0;

   iIndice = iPosicion;
   sprintf(szllave,"%s",sthMinutoAdicional.szCodPlan[iPosicion]);
   while(iIndice < iFin && iTermino == 0 && iIndice > 0)
   {
       if(strcmp(szllave,sthMinutoAdicional.szCodPlan[iIndice])==0)
       {
           sprintf(szllave,"%s",sthMinutoAdicional.szCodPlan[iIndice]);
           iIndice ++;
       }
       else
       {
           iTermino = iIndice-1;
       }
   }
   if(iIndice >= iFin) iTermino = iFin-1;

   *ihInicio = iInicio;
   *ihTermino = iTermino;

   return(TRUE);
}
/****************Final de Busca_RangoPlanes ******************************************/

int BuscaEstrucPlanes(char *szllave,int iderecha)
{  int centro;
   int izquierda;

   izquierda = 0;
   while(izquierda <= iderecha)
   {
        centro = (izquierda + iderecha) / 2;
        vDTrazasLog("","\tPlan [%s]-[%s]",LOG06,szllave,sthMinutoAdicional.szCodPlan[centro]);
        if(strcmp(szllave,sthMinutoAdicional.szCodPlan[centro])<0) {iderecha = centro - 1;}
        else {
           if(strcmp(szllave,sthMinutoAdicional.szCodPlan[centro])>0) {izquierda = centro + 1;}
           else { return(centro); }
        }
   }
   return(-1);
}
/****************Final de BuscaEstrucPlanes *******************/

int BuscaValorMinuto(char *szllave,int izquierda, int derecha)
{  int centro;

   while(izquierda <= derecha)
   {
        centro = (izquierda + derecha) / 2;
        vDTrazasLog("","\tPlan [%s]-[%s]",LOG06,szllave,sthMinutoAdicional.szLlaveMinutoAdicional[centro]);
        if(strcmp(szllave,sthMinutoAdicional.szLlaveMinutoAdicional[centro])<0) {derecha = centro - 1;}
        else {
           if(strcmp(szllave,sthMinutoAdicional.szLlaveMinutoAdicional[centro])>0) {izquierda = centro + 1;}
           else { return(centro); }
        }
   }
   return(-1);
}/****************Final de BuscaValorMinuto *******************/

int buscaMinutoAdicional(char *szCodPlan,char *szllave)
{
    int iPosicionEstrucPlanes;
    int iPosicionValorMinutos;
    int derecha;
    int iInicio;
    int iTermino;

    strcpy (szModulo, "buscaMinutoAdicional");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    derecha = sthMinutoAdicional.iCantidadMinutoAdicional;
    vDTrazasLog(szModulo,"\tPlan [%s] es [%s]",LOG05,szCodPlan,szllave);
    iPosicionEstrucPlanes = BuscaEstrucPlanes(szCodPlan,derecha);
    if(iPosicionEstrucPlanes != -1)
    {
       vDTrazasLog(szModulo,"\tPlan [%s] es [%d]",LOG06,szCodPlan,iPosicionEstrucPlanes);
       iInicio=0;
       iTermino=0;
       if(!Busca_RangoPlanes(iPosicionEstrucPlanes,&iInicio,&iTermino,derecha))
       {
          return(FALSE);
       }
       vDTrazasLog(szModulo,"\tPlan [%s] Inicio [%d] Termino [%d] ", LOG06,szCodPlan,iInicio,iTermino);
       iPosicionValorMinutos = BuscaValorMinuto(szllave,iInicio,iTermino);
       if(iPosicionValorMinutos != -1)
       {
          return(iPosicionValorMinutos);
       }
    }
    return(TRUE);
}
/****************Final de busca_arrastre *******************/

int ifnCmpCodCliente(const void *cad1,const void *cad2)
{
    int rc = 0;

    return
        ( (rc = ((CODCLI *)cad1)->lCodCliente-
                ((CODCLI *)cad2)->lCodCliente) != 0)?rc:0;

}

int ifnCmpNumAbonado(const void *cad1,const void *cad2)
{
    int rc = 0;

    return
        ( (rc = ((STDETCONSUMO *)cad1)->lNumAbonado -((STDETCONSUMO *)cad2)->lNumAbonado) != 0)?rc:0;

}

/**********************************************************************************/
/*                            FUNCION : bfnCargaCodClientes                       */
/**********************************************************************************/

BOOL bfnCargaCodClientes (CODCLI **pstCodClie, int *iNumCodCientes, long lCicloFact)
{
    int          rc =0          ;
    int          iNumFilas      ;
    CODCLI_HOSTS stCodClieHost  ;
    CODCLI       *pstCodClieTemp;
    register int iCont          ;

    vDTrazasLog (szExeName,"\n\t* Carga Codigos de Clientes y sus Descripciones ", LOG06);

    *iNumCodCientes = 0;
    *pstCodClie = NULL;

    if (ifnOpenCodClientes(lCicloFact))
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchCodClientes(&stCodClieHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstCodClie =(CODCLI*) realloc(*pstCodClie,(int)(((*iNumCodCientes)+iNumFilas)*sizeof(CODCLI)));

        if (!*pstCodClie)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaCodClientes", "no se pudo reservar memoria");
            return FALSE;
        }

        pstCodClieTemp = &(*pstCodClie)[(*iNumCodCientes)];
        memset(pstCodClieTemp, 0, (int)(sizeof(CODCLI)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy( pstCodClieTemp[iCont].szNomApoderado    ,stCodClieHost.szNomApoderado[iCont]);
            pstCodClieTemp[iCont].lCodCliente               = stCodClieHost.lCodCliente[iCont];
            strcpy( pstCodClieTemp[iCont].szCodServicio     ,stCodClieHost.szCodServicio[iCont]);
            pstCodClieTemp[iCont].iCodSisPago               = stCodClieHost.iCodSisPago[iCont];
            strcpy( pstCodClieTemp[iCont].szCodCourrier     ,stCodClieHost.szCodCourrier[iCont]);    /* P-MIX-09003 */
            strcpy( pstCodClieTemp[iCont].szCodZonaCourrier ,stCodClieHost.szCodZonaCourrier[iCont]);/* P-MIX-09003 */
        }
        (*iNumCodCientes) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* Codigos de Clientes cargados [%ld]", LOG06, *iNumCodCientes);

    rc = ifnCloseCodClientes();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaCodClientes", szfnORAerror ());
        return FALSE;
    }

    qsort((void*)*pstCodClie, *iNumCodCientes, sizeof(CODCLI),ifnCmpCodCliente);

    return (TRUE);
}
/***************************** Final bfnCargaCodClientes *********************/

int ifnOpenCodClientes(long lCicloFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCicloFact;
    /* EXEC SQL END DECLARE SECTION; */ 



    lhCicloFact = lCicloFact;

    vDTrazasLog (szExeName,"\n\t\t* Open=> GE_CLIENTES", LOG06);

    /* EXEC SQL DECLARE Cur_CodCliente CURSOR for
        SELECT DISTINCT A.COD_CLIENTE,
                NVL(A.NOM_APODERADO ,'.'),
                NVL(D.COD_SERVICIO  ,'1'),
                NVL(A.COD_SISPAGO, 1),
                NVL(B.COD_COURRIER,' '),
                NVL(B.COD_ZONACOURRIER,' ')
        /oFROM  GE_CLIENTES A, FA_CICLOCLI B, FA_CICLFACT C, FAD_IMPSERVCLIE Do/ /o P-MIX-09003 o/
        FROM  GE_CLIENTES A, 
              (SELECT DISTINCT COD_CLIENTE,COD_CICLO,COD_COURRIER,COD_ZONACOURRIER
               FROM   FA_CICLOCLI
               WHERE  COD_COURRIER IS NOT NULL
               OR     COD_ZONACOURRIER IS NOT NULL) B, /o P-MIX-09003 o/ 
              FA_CICLFACT C, 
              FAD_IMPSERVCLIE D        
        WHERE C.COD_CICLFACT = :lhCicloFact
        AND C.COD_CICLO = B.COD_CICLO
        AND B.COD_CLIENTE = A.COD_CLIENTE
        AND A.COD_CLIENTE = D.COD_CLIENTE(+); */ 


    /* EXEC SQL OPEN Cur_CodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0041;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1605;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCicloFact;
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




    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> GE_CLIENTES",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenCodClientes **********************/

BOOL bfnFetchCodClientes (CODCLI_HOSTS *pstHost,int *piNumFilas)
{ 
    /* EXEC SQL FETCH Cur_CodCliente
              INTO  :pstHost->lCodCliente   ,
                    :pstHost->szNomApoderado,
                    :pstHost->szCodServicio ,
                    :pstHost->iCodSisPago,
                    :pstHost->szCodCourrier,                    
                    :pstHost->szCodZonaCourrier; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )1624;
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
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szNomApoderado);
    sqlstm.sqhstl[1] = (unsigned long )41;
    sqlstm.sqhsts[1] = (         int  )41;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodServicio);
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodSisPago);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCodCourrier);
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )11;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szCodZonaCourrier);
    sqlstm.sqhstl[5] = (unsigned long )11;
    sqlstm.sqhsts[5] = (         int  )11;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> GE_CLIENTES", szfnORAerror ());
    return SQLCODE;
}
/***************************** Final bfnFetchCodClientes ****************/


int ifnCloseCodClientes(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> GE_CLIENTES", LOG06);

    /* EXEC SQL CLOSE Cur_CodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1663;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> GE_CLIENTES",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnCloseCodClientes **********************/

void vfnPrintCodClientes (CODCLI *pstCodClie, int iNumCodCientes)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Codigos de Clientes [%d]", LOG06, iNumCodCientes);

        for (i=0;i<iNumCodCientes;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Nombre de Apoderado  [%s]"
                                    "\n\t\t=> [%d]: Codigo de Cliente    [%ld]"
                                    "\n\t\t=> [%d]: Codigo de Servicio   [%s]"
                                    "\n\t\t=> [%d]: Codigo Pago          [%s]"
                                    ,LOG06
                                    ,i, pstCodClie[i].szNomApoderado
                                    ,i, pstCodClie[i].lCodCliente
                                    ,i, pstCodClie[i].szCodServicio
                                    ,i, pstCodClie[i].iCodSisPago);
        }

    }
}
/*************************** vfnPrintCodClientes *****************************/

/*****************************************************************************************************/
/* FUNCION : bfnFindCodCliente                                                                       */
/*****************************************************************************************************/
BOOL bfnFindCodCliente (long lCodigoCliente, CODCLI *pstCodClie, long lCodCiclFact, char *szFecEmision)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodCliente;
        char    szhNomApoderado      [40];
        char    szhCodServicio        [4];
        char    szhFecEmi            [15];
        int     ihCodSisPago             ; 
        char    szhNumIdent2       [20+1]; /* EXEC SQL VAR szhNumIdent2       IS STRING(20+1); */ 

        char    szhCodCourrier     [10+1]; /* EXEC SQL VAR szhCodCourrier     IS STRING(10+1); */ 

        char    szhCodZonaCourrier [10+1]; /* EXEC SQL VAR szhCodZonaCourrier IS STRING(10+1); */ 
                
    /* EXEC SQL END DECLARE SECTION; */ 


    CODCLI  stkey;
    CODCLI  *pstAux = (CODCLI *)NULL;
    
    memset(szhNumIdent2,'\0',sizeof(szhNumIdent2));
    memset(szhCodCourrier,'\0',sizeof(szhCodCourrier));
    memset(szhCodZonaCourrier,'\0',sizeof(szhCodZonaCourrier));    

    vDTrazasLog (szExeName, "\n\t\t* Busca Codigo de Cliente "
                    "\n\t\t=> Cod.Cliente   [%ld]"
                    "\n\t\t=> Cod.CiclFact  [%ld]"
                    "\n\t\t=> Fec.Emision   [%s]"
                    , LOG05,lCodigoCliente, lCodCiclFact, szFecEmision );

    stkey.lCodCliente   = lCodigoCliente;

    if (lCodCiclFact)
    {
        if (pstCodCliente.iNumCodClientes > 0)
        { 	        	            
            if ( (pstAux = (CODCLI *)bsearch (&stkey, pstCodCliente.stTipDocum , pstCodCliente.iNumCodClientes,
                sizeof (CODCLI),ifnCmpCodCliente ))== (CODCLI *)NULL)
            {

                vDTrazasLog(szExeName, "Codigo de Cliente [%ld] no encontrado ...", LOG01, lCodigoCliente);
                return  (FALSE);
            }
            memcpy (pstCodClie, pstAux, sizeof(CODCLI));                        
        }
        else
        {
            vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Clientes ...", LOG03);
        }
    }
    else
    {
        strcpy(szhFecEmi, szFecEmision);

        /* EXEC SQL 
             SELECT DISTINCT A.COD_CLIENTE,
                    NVL(A.NOM_APODERADO ,'.'),
                    NVL(D.COD_SERVICIO  ,'1'),
                    NVL(A.COD_SISPAGO, 1),
                    NVL(A.NUM_IDENT2,' '),      /o P-MIX-09003 o/
                    NVL(E.COD_COURRIER,' '),    /o P-MIX-09003 o/
                    NVL(E.COD_ZONACOURRIER,' ') /o P-MIX-09003 o/
             INTO  :lhCodCliente, :szhNomApoderado, :szhCodServicio, :ihCodSisPago,
                   :szhNumIdent2, :szhCodCourrier,  :szhCodZonaCourrier 
             FROM  GE_CLIENTES A, FAD_IMPSERVCLIE D,
                   (SELECT COD_CLIENTE,COD_COURRIER,COD_ZONACOURRIER 
                    FROM FA_CICLOCLI
                    WHERE  COD_COURRIER IS NOT NULL
                    OR     COD_ZONACOURRIER IS NOT NULL) E /o P-MIX-09003 140556 o/
             WHERE A.COD_CLIENTE = :lCodigoCliente
             AND   A.COD_CLIENTE = D.COD_CLIENTE(+)
             AND   TO_DATE(:szhFecEmi ,'YYYYMMDD') BETWEEN FECHA_DESDE(+) AND FECHA_HASTA(+)
             AND   A.COD_CLIENTE = E.COD_CLIENTE(+); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select distinct A.COD_CLIENTE ,NVL(A.NOM_APODERADO,'.\
') ,NVL(D.COD_SERVICIO,'1') ,NVL(A.COD_SISPAGO,1) ,NVL(A.NUM_IDENT2,' ') ,NVL(\
E.COD_COURRIER,' ') ,NVL(E.COD_ZONACOURRIER,' ') into :b0,:b1,:b2,:b3,:b4,:b5,\
:b6  from GE_CLIENTES A ,FAD_IMPSERVCLIE D ,(select COD_CLIENTE ,COD_COURRIER \
,COD_ZONACOURRIER  from FA_CICLOCLI where (COD_COURRIER is  not null  or COD_Z\
ONACOURRIER is  not null )) E where (((A.COD_CLIENTE=:b7 and A.COD_CLIENTE=D.C\
OD_CLIENTE(+)) and TO_DATE(:b8,'YYYYMMDD') between FECHA_DESDE(+) and FECHA_HA\
STA(+)) and A.COD_CLIENTE=E.COD_CLIENTE(+))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1678;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhNomApoderado;
        sqlstm.sqhstl[1] = (unsigned long )40;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodServicio;
        sqlstm.sqhstl[2] = (unsigned long )4;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodSisPago;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhNumIdent2;
        sqlstm.sqhstl[4] = (unsigned long )21;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodCourrier;
        sqlstm.sqhstl[5] = (unsigned long )11;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCodZonaCourrier;
        sqlstm.sqhstl[6] = (unsigned long )11;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lCodigoCliente;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhFecEmi;
        sqlstm.sqhstl[8] = (unsigned long )15;
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

 /* P-MIX-09003 */       

        if (SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeName, "\n\tSelect => Clientes (bfnFindCodCliente) Cliente [%ld] no encontrado ...", LOG01, lCodigoCliente);
            iDError (szExeName,ERR000,vInsertarIncidencia,"Select => Clientes (bfnFindCodCliente)",szfnORAerror ());
            return FALSE;
        }
        else
        {                                    
            pstCodClie->lCodCliente = lhCodCliente;
            strcpy (pstCodClie->szNomApoderado, szhNomApoderado);
            strcpy (pstCodClie->szCodServicio, szhCodServicio);
            pstCodClie->iCodSisPago = ihCodSisPago;
            strcpy (pstCodClie->szNumIdent2, szhNumIdent2);
            strcpy (pstCodClie->szCodCourrier, szhCodCourrier);
            strcpy (pstCodClie->szCodZonaCourrier, szhCodZonaCourrier);                                
                
        }
    }    
    
    return (TRUE);
}
/***************************** Final bfnFindCodCliente **********************/

/* P-MIX-09003 */
/***********************************************************************************************/
/* FUNCION : bfnFindMotivo                                                                     */
/***********************************************************************************************/
BOOL bfnFindMotivo (char *szCodTipologia, char *szCodAreaImputable, char *szCodAreaSolicitante,                    
                    char *szTipologia   , char *szAreaImputable   , char *szAreaSolicitante)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhCodTipologia        [5+1]; /* EXEC SQL VAR szhCodTipologia       IS STRING(5+1); */ 

         char    szhCodAreaImputable    [5+1]; /* EXEC SQL VAR szhCodAreaImputable   IS STRING(5+1); */ 

         char    szhCodAreaSolicitante  [5+1]; /* EXEC SQL VAR szhCodAreaSolicitante IS STRING(5+1); */ 

         char    szhTipologia          [30+1]; /* EXEC SQL VAR szhTipologia          IS STRING(30+1); */ 

         char    szhAreaImputable      [30+1]; /* EXEC SQL VAR szhAreaImputable      IS STRING(30+1); */ 

         char    szhAreaSolicitante    [30+1]; /* EXEC SQL VAR szhAreaSolicitante    IS STRING(30+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
    vDTrazasLog (szExeName, "\n\t\t* Parámetros entrada Motivo Documento"
                            "\n\t\t=> Cod.Tipologia        [%s]"
                            "\n\t\t=> Cod.Area Solicitante [%s]"
                            "\n\t\t=> Cod.Area Imputable   [%s]"                            
                          , LOG05
                          , szCodTipologia
                          , szCodAreaImputable
                          , szCodAreaSolicitante);    

    memset(szhCodTipologia,'\0',sizeof(szhCodTipologia));
    strcpy(szhCodTipologia,szCodTipologia);
    
    memset(szhCodAreaImputable,'\0',sizeof(szhCodAreaImputable));
    strcpy(szhCodAreaImputable,szCodAreaImputable);
    
    memset(szhCodAreaSolicitante,'\0',sizeof(szhCodAreaSolicitante));
    strcpy(szhCodAreaSolicitante,szCodAreaSolicitante);    

    vDTrazasLog (szExeName, "\n\t\t* Busca Motivo Documento"
                            "\n\t\t=> Cod.Tipologia        [%s]"
                            "\n\t\t=> Cod.Area Solicitante [%s]"
                            "\n\t\t=> Cod.Area Imputable   [%s]"                            
                          , LOG05
                          , szhCodTipologia
                          , szhCodAreaImputable
                          , szhCodAreaImputable);

    /* EXEC SQL            
           SELECT NVL(DES_VALOR,' ')
           INTO  :szhTipologia
           FROM   CO_CODIGOS 
           WHERE  NOM_TABLA   = 'CO_AJUSTES' 
           AND    NOM_COLUMNA = 'COD_TIPOLOGIA'
           AND    COD_VALOR   = :szhCodTipologia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(DES_VALOR,' ') into :b0  from CO_CODIGOS where\
 ((NOM_TABLA='CO_AJUSTES' and NOM_COLUMNA='COD_TIPOLOGIA') and COD_VALOR=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1729;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhTipologia;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipologia;
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



    if ( SQLCODE != SQLOK)
    {
         vDTrazasLog(szExeName, "\n\tSelect => CO_CODIGOS (bfnFindMotivo) Cod.Tipologia [%s] no encontrado ..."
                              , LOG03, szhCodTipologia);
         strcpy(szTipologia," ");
    }
    else
    {    
         vDTrazasLog (szExeName, "\n\t\t* Busca Motivo Tipologia "
                                 "\n\t\t=> Tipologia [%s]"
                               , LOG05, szhTipologia );                        	                                
         strcpy (szTipologia, szhTipologia);         
    }
    
    /* EXEC SQL            
           SELECT NVL(DES_VALOR,' ')
           INTO  :szhAreaImputable
           FROM   CO_CODIGOS 
           WHERE  NOM_TABLA   = 'CO_AJUSTES' 
           AND    NOM_COLUMNA = 'COD_AREAIMPUTABLE'
           AND    COD_VALOR   = :szhCodAreaImputable; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(DES_VALOR,' ') into :b0  from CO_CODIGOS where\
 ((NOM_TABLA='CO_AJUSTES' and NOM_COLUMNA='COD_AREAIMPUTABLE') and COD_VALOR=:\
b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1752;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhAreaImputable;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAreaImputable;
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



    if ( SQLCODE != SQLOK)
    {
         vDTrazasLog(szExeName, "\n\tSelect => CO_CODIGOS (bfnFindMotivo) Cod.Area Imputable [%s] no encontrado ..."
                              , LOG03, szhCodAreaImputable);
         strcpy(szAreaImputable," ");
    }
    else
    {    
         vDTrazasLog (szExeName, "\n\t\t* Busca Motivo Area Imputable "
                                 "\n\t\t=> Area Imputable [%s]"
                               , LOG05, szhAreaImputable );                        	                                
         strcpy (szAreaImputable, szhAreaImputable);         
    }    
    
    /* EXEC SQL            
           SELECT NVL(DES_VALOR,' ')
           INTO  :szhAreaSolicitante
           FROM   CO_CODIGOS 
           WHERE  NOM_TABLA   = 'CO_AJUSTES' 
           AND    NOM_COLUMNA = 'COD_AREASOLICITANTE'
           AND    COD_VALOR   = :szhCodAreaSolicitante; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(DES_VALOR,' ') into :b0  from CO_CODIGOS where\
 ((NOM_TABLA='CO_AJUSTES' and NOM_COLUMNA='COD_AREASOLICITANTE') and COD_VALOR\
=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1775;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhAreaSolicitante;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAreaSolicitante;
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



    if ( SQLCODE != SQLOK)
    {
         vDTrazasLog(szExeName, "\n\tSelect => CO_CODIGOS (bfnFindMotivo) Cod.Area Solicitante [%s] no encontrado ..."
                              , LOG03, szhCodAreaSolicitante);
         strcpy(szAreaSolicitante," ");
    }
    else
    {    
         vDTrazasLog (szExeName, "\n\t\t* Busca Motivo Area Solicitante "
                                 "\n\t\t=> Area Solicitante [%s]"
                               , LOG05, szhAreaSolicitante );                        	                                
         strcpy (szAreaSolicitante, szhAreaSolicitante);         
    }    
    
    return (TRUE);
}
/******************************** Final bfnFindMotivo *************************/

/*****************************************************************************************************/
/* FUNCION : bfnFindCodPrestacionAbon                                                                */
/*****************************************************************************************************/
BOOL bfnFindCodPrestacionAbon (long lNumAbonado, char *szCodPrestacionAbon)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNumAbonado;
         char    szhCodPrestacionAbon [5+1]; /* EXEC SQL VAR szhCodPrestacionAbon IS STRING(5+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
    memset(szhCodPrestacionAbon,'\0',sizeof(szhCodPrestacionAbon));    

    vDTrazasLog (szExeName, "\n\t\t* Busca Codigo Prestacion Abonado "
                    "\n\t\t=> Num. Abonado   [%ld]"
                    , LOG05,lNumAbonado );

    lhNumAbonado = lNumAbonado;

    /* EXEC SQL 
           SELECT NVL(A.COD_PRESTACION ,' ')
           INTO   :szhCodPrestacionAbon
           FROM   GA_ABOCEL A
           WHERE  A.NUM_ABONADO = :lhNumAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(A.COD_PRESTACION,' ') into :b0  from GA_ABOCEL\
 A where A.NUM_ABONADO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1798;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPrestacionAbon;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
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



    if ( SQLCODE != SQLOK)
    {
         vDTrazasLog(szExeName, "\n\tSelect => Abonados (bfnFindCodPrestacionAbon) Abonado [%ld] no encontrado ..."
                              , LOG01
                              , lNumAbonado);
         iDError (szExeName,ERR000,vInsertarIncidencia,"Select => Abonados (bfnFindCodPrestacionAbon)",szfnORAerror ());
         return FALSE;
    }
    else
    {    
         vDTrazasLog (szExeName, "\n\t\t* Busca Codigo Prestacion Abonado : [%ld]"
                                 "\n\t\t=> Cod. Prestacion [%s]"
                               , LOG05, lhNumAbonado, szhCodPrestacionAbon );
                        	                                
         strcpy (szCodPrestacionAbon, szhCodPrestacionAbon);
         
    }
    
    return (TRUE);
}
/******************************** Final bfnFindCodPrestacionAbon *************************/

/**********************************************************************************/
/* FUNCION : bfnFindFactura                                                       */
/**********************************************************************************/
BOOL bfnFindFactura ( long lCodigoCliente, 
                      char *szNombreCliente, 
                      long lCodCiclFact, 
                      char *szFecEmision,
                      char *szNumIdent,
                      long lNumVenta)
{
	
    char szAnd [40]    ="";
    char szQry [1000]  ="";	
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhTipoFactura     [1+1]; /* EXEC SQL VAR szhTipoFactura   IS STRING(1+1); */ 

         char szhNombreCliente [110+1]; /* EXEC SQL VAR szhNombreCliente IS STRING(110+1); */ 

         char szhNumIdent       [20+1]; /* EXEC SQL VAR szhNumIdent      IS STRING(20+1); */ 
         
         long lhCodCliente;
         long lhCodCicloFact;
         long lhNumVenta;       /* P-MIX-09003 */
         char szhFecEmision     [10+1]; /* EXEC SQL VAR szhFecEmision IS STRING(10+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szNombreCliente,'\0',sizeof(szNombreCliente));
    memset(szhNombreCliente,'\0',sizeof(szhNombreCliente));
    memset(szhNumIdent,'\0',sizeof(szhNumIdent));    
    memset(szhTipoFactura,'\0',sizeof(szhTipoFactura));
    memset(szhFecEmision,'\0',sizeof(szhFecEmision));    
    
    lhCodCliente   = lCodigoCliente;
    lhCodCicloFact = lCodCiclFact;
    lhNumVenta     = lNumVenta;           /* P-MIX-09003 */
    strcpy(szhFecEmision,szFecEmision);    
    
/* P-MIX-09003 */    
    if (lhCodCicloFact)
    {
        strcpy(szhTipoFactura,"C"); /* Factura Ciclica */
        sprintf(szAnd,"");
    }
    else
    {
        strcpy(szhTipoFactura,"I"); /* Factura Inmediata */
        sprintf(szAnd,"\n AND NUM_VENTA = :lhNumVenta ");        
    } 
    
    vDTrazasLog (szExeName, "\n\t\t* Busca Factura "
                            "\n\t\t=> Cod.Cliente   [%ld]"
                            "\n\t\t=> Cod.CiclFact  [%ld]"
                            "\n\t\t=> Tipo Factura   [%s]"                                        
                            "\n\t\t=> Fec.Emision    [%s]"
                            "\n\t\t=> Num.Venta     [%ld]"                    
                          , LOG05,lhCodCliente, lhCodCicloFact
                          , szhTipoFactura, szhFecEmision,lhNumVenta );

    sprintf(szQry,
          "\n SELECT NVL(NOMBRE || ' ' || NOM_APELLIDO1 || ' ' || NOM_APELLIDO2,' ') , "
          "\n        NVL(NUM_IDENT,' ') "
          "\n FROM   GE_DATCLIFACTURA_TO "
          "\n WHERE  TIPO_FACTURA = :szhTipoFactura "
          "\n AND    COD_CLIENTE = :lhCodCliente "
          "\n AND    TO_DATE(:szhFecEmision ,'YYYYMMDD') BETWEEN TRUNC(FEC_DESDE) AND TRUNC(FEC_HASTA) "
          "%s" , szAnd);

    vDTrazasLog(szModulo,"\t\tQRY:[ %s ]",LOG06,szQry);
    
    /* EXEC SQL PREPARE sql_Cur_Factura FROM :szQry; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1821;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szQry;
    sqlstm.sqhstl[0] = (unsigned long )1000;
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-PREPARE sql_Cur_Factura **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-PREPARE sql_Cur_Factura **"
                                      "\t\tError : [%s] [%d]  [%s] ",LOG01,szQry,SQLCODE,SQLERRM);
        return (SQLCODE);
    }   
    
    /* EXEC SQL DECLARE curFactura CURSOR FOR sql_Cur_Factura; */ 


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-DECLARE curFactura **"
                        "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-DECLARE curFactura **"
                        "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (SQLCODE);
    }
    
    if (lhCodCicloFact)
    {
        /* EXEC SQL OPEN curFactura USING :szhTipoFactura, :lhCodCliente, :szhFecEmision; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1840;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhTipoFactura;
        sqlstm.sqhstl[0] = (unsigned long )2;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
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

    	
    }
    else
    {
        /* EXEC SQL OPEN curFactura USING :szhTipoFactura, :lhCodCliente, :szhFecEmision, :lhNumVenta; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1867;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhTipoFactura;
        sqlstm.sqhstl[0] = (unsigned long )2;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
        sqlstm.sqhstl[2] = (unsigned long )11;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumVenta;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

    	
    }         
    

    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t\tError en SQL-OPEN CURSOR curFactura **"
                               "\n\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t\tError en SQL-OPEN CURSOR curFactura **"
                               "\n\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }    
    
    /* EXEC SQL
         FETCH curFactura INTO :szhNombreCliente, :szhNumIdent; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1898;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNombreCliente;
    sqlstm.sqhstl[0] = (unsigned long )111;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[1] = (unsigned long )21;
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
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select=> GE_DATCLIFACTURA_TO", szfnORAerror ());
        return FALSE;
    }
    else
    {
    	if (SQLCODE == SQLNOTFOUND)
    	{
            vDTrazasLog(szModulo, "\n\tNo encontre Nombre Cliente.. ", LOG05);
    	    strcpy (szNombreCliente, " ");
    	    strcpy (szNumIdent, " ");    	    
    	}
    	else
    	{
            vDTrazasLog(szModulo, "\n\tEncontre Nombre Cliente.. ", LOG05);    		
    	    strcpy(szNombreCliente, szhNombreCliente);
    	    strcpy(szNumIdent, szhNumIdent);    	    
        }
    }    
/* P-MIX-09003 */    
    return TRUE;
}
/***************************** Final bfnFindFacturaCiclo **********************/

/* P-MIX-09003 */
/**********************************************************************************/
/* FUNCION : bfnFindPrefoliados                                                       */
/**********************************************************************************/
BOOL bfnFindPrefoliados ( long lIndOrdenTotal, 
                          char *szPrefoliados,
                          char *szResolucionPre,
                          char *szSeriePre,
                          int  *iCodTipDocumPre,
                          char *szEtiquetaPre,
                          long *lNumFolioPre )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhIndOrdenTotal;    
         char szhPrefoliados  [100+1]; /* EXEC SQL VAR szhPrefoliados    IS STRING(100+1); */ 

         char szhResolucionPre [25+1]; /* EXEC SQL VAR szhResolucionPre  IS STRING(25+1); */ 

         char szhSeriePre      [10+1]; /* EXEC SQL VAR szhSeriePre       IS STRING(10+1); */ 

         int  ihCodTipDocumPre       ; 
         char szhEtiquetaPre   [10+1]; /* EXEC SQL VAR szhEtiquetaPre    IS STRING(10+1); */ 

         long lhNumFolioPre          ; 
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhPrefoliados    ,'\0',sizeof(szhPrefoliados));
    memset(szhResolucionPre  ,'\0',sizeof(szhResolucionPre));
    memset(szhSeriePre       ,'\0',sizeof(szhSeriePre));
    
    lhIndOrdenTotal = lIndOrdenTotal;
    
    vDTrazasLog (szExeName, "\n\t\t* Busca PreFoliados *"
                    "\n\t\t=> Ind. Orden Total   [%ld]"
                    , LOG05,lhIndOrdenTotal);

    /* EXEC SQL 
             SELECT RESOLUCION|| ' ' ||SERIE|| ' ' ||TO_CHAR(COD_TIPDOCUM)|| ' ' ||ETIQUETA|| ' ' ||TO_CHAR(NUM_FOLIO),
                    RESOLUCION, SERIE, COD_TIPDOCUM, NVL(ETIQUETA,' '), NUM_FOLIO
             INTO   :szhPrefoliados,
                    :szhResolucionPre, :szhSeriePre, :ihCodTipDocumPre, :szhEtiquetaPre, :lhNumFolioPre
             FROM   FA_PREFOLIADOS
             WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ((((((((RESOLUCION||' ')||SERIE)||' ')||TO_CHAR(CO\
D_TIPDOCUM))||' ')||ETIQUETA)||' ')||TO_CHAR(NUM_FOLIO)) ,RESOLUCION ,SERIE ,C\
OD_TIPDOCUM ,NVL(ETIQUETA,' ') ,NUM_FOLIO into :b0,:b1,:b2,:b3,:b4,:b5  from F\
A_PREFOLIADOS where IND_ORDENTOTAL=:b6";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1921;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhPrefoliados;
    sqlstm.sqhstl[0] = (unsigned long )101;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhResolucionPre;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhSeriePre;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocumPre;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhEtiquetaPre;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolioPre;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhIndOrdenTotal;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select=> FA_PREFOLIADOS", szfnORAerror ());
        vDTrazasLog(szModulo, "\n\tNo hay Prefoliados ", LOG01);        
        return FALSE;
        
    }
    else
    {
    	if (SQLCODE == SQLNOTFOUND)
    	{
            vDTrazasLog(szModulo, "\n\tNo hay Prefoliados ", LOG06);                      
            return FALSE;
    	}
    	else
    	{
            vDTrazasLog(szModulo, "\n\tEncontre Prefoliados ", LOG06);    		
    	    strcpy(szPrefoliados, szhPrefoliados);
    	    
            strcpy(szResolucionPre,szhResolucionPre);
            strcpy(szSeriePre,szhSeriePre);
            *iCodTipDocumPre = ihCodTipDocumPre;
            strcpy(szEtiquetaPre,szhEtiquetaPre);
            *lNumFolioPre   = lhNumFolioPre;
        }
    }    
    
    return TRUE;
}
/***************************** Final bfnFindPrefoliados **********************/

/* P-MIX-09003 */
BOOL bfnCargaRegistrosTipoD (REGTIP_D **stRegTipD, int *iNumRegD)
{
    int      rc = 0;
    int      iNumFilas;
    static   REGTIP_D_HOST stRegTipDHost;
    REGTIP_D *stRegTipDTemp;
    int      iCont;
    char     *szModulo="bfnCargaRegistrosTipoD";

    vDTrazasLog (szModulo,"\n\t* Carga Configuracion Registro D ", LOG03);

    *iNumRegD  = 0;
    *stRegTipD = NULL;

    if ( ifnOpenRegistrosTipoD() )
    {
        return (FALSE);
    }

    while ( rc != SQLNOTFOUND )
    {
        rc = bfnFetchRegistrosTipoD(&stRegTipDHost,&iNumFilas);
        
        if ( rc != SQLOK  && rc != SQLNOTFOUND )
        {
            return (FALSE);
        }

        if ( !iNumFilas )
        {
            break;
        }

        *stRegTipD =(REGTIP_D*) realloc(*stRegTipD,(int)(((*iNumRegD)+iNumFilas)*sizeof(REGTIP_D)));

        if ( !*stRegTipD )
        {
            iDError (szModulo,ERR000,vInsertarIncidencia,
                     "Error bfnCargaRegistrosTipoD", "no se pudo reservar memoria");
            return (FALSE);
        }

        stRegTipDTemp = &(*stRegTipD)[(*iNumRegD)];
        memset(stRegTipDTemp, 0, (int)(sizeof(REGTIP_D)*iNumFilas));
        
        for ( iCont = 0 ; iCont < iNumFilas ; iCont++ )
        {
              stRegTipDTemp[iCont].iPosicion              = stRegTipDHost.iPosicion[iCont];
              strcpy( stRegTipDTemp[iCont].szCodRegistro  , alltrim(stRegTipDHost.szCodRegistro[iCont]));
              strcpy( stRegTipDTemp[iCont].szCodTipLlam   , alltrim(stRegTipDHost.szCodTipLlam[iCont]));
              strcpy( stRegTipDTemp[iCont].szCodValor     , alltrim(stRegTipDHost.szCodValor[iCont]));
        }
        
        (*iNumRegD) += iNumFilas;

    }/* fin while */

    vDTrazasLog (szModulo,"\n\t\t* Configuracion de Registros D cargados :[%d]", LOG03, *iNumRegD);

    rc = ifnCloseRegistrosTipoD();
    
    if ( rc != SQLOK )
    {
        iDError (szModulo,ERR000,vInsertarIncidencia,"Error bfnCargaRegistrosTipoD", szfnORAerror ());
        return (FALSE);
    }

    vDTrazasLog (szModulo,"\n\t\t* (bfnCargaRegistrosTipoD) Saliendo de la funcion...", LOG06);

    return(TRUE);
}/***************************** Final bfnCargaRegistrosTipoD *********************/

/*********************************************************************************/
/* FUNCION : ifnOpenRegistrosTipoD                                               */
/*********************************************************************************/
static int ifnOpenRegistrosTipoD(void)
{
    char *szModulo="ifnOpenRegistrosTipoD";
    
    vDTrazasLog (szModulo,"\n\t\t* En la funcion ifnOpenRegistrosTipoD", LOG03);
	
    /* EXEC SQL DECLARE Cur_ConfRegTipD CURSOR FOR
         SELECT POSICION, COD_REGISTRO, TIP_REGISTRO, VALOR
         FROM   FA_REGDETLLAM_TD
         ORDER  BY POSICION ASC; */ 


    /* EXEC SQL OPEN Cur_ConfRegTipD; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0049;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1964;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        iDError (szModulo,ERR000,vInsertarIncidencia,"Open=> Cur_ConfRegTipD",szfnORAerror ());
    }

    return (SQLCODE);
}/***************************** Fin ifnOpenRegistrosTipoD  **********************/

/*********************************************************************************/
/* FUNCION : bfnFetchRegistrosTipoD                                              */
/*********************************************************************************/
static BOOL bfnFetchRegistrosTipoD (REGTIP_D_HOST *pstHost,int *piNumFilas)
{
    char *szModulo="bfnFetchRegistrosTipoD";

    vDTrazasLog (szModulo,"\n\t\t* En la funcion bfnFetchRegistrosTipoD", LOG06);

    /* EXEC SQL FETCH Cur_ConfRegTipD
             INTO :pstHost->iPosicion ,
    	          :pstHost->szCodRegistro,
    	          :pstHost->szCodTipLlam,
    	          :pstHost->szCodValor; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )1979;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iPosicion);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodRegistro);
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )6;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCodTipLlam);
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szCodValor);
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )6;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE==SQLOK )
    {
        *piNumFilas = TAM_HOSTS_PEQ;
    }
    else
    {
        if ( SQLCODE==SQLNOTFOUND )
        {
             *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        }
        else
        {
             iDError (szModulo,ERR000,vInsertarIncidencia,"Fetch=> Cur_ConfRegTipD", szfnORAerror ());
        }
    }
    
    return (SQLCODE);
}/***************************** Final bfnFetchRegistrosTipoD ****************/

/*********************************************************************************/
/* FUNCION : ifnCloseRegistrosTipoD                                              */
/*********************************************************************************/
static int ifnCloseRegistrosTipoD(void)
{
    char *szModulo="ifnCloseRegistrosTipoD";

    vDTrazasLog (szModulo,"\n\t\t* En la funcion ifnCloseRegistrosTipoD", LOG06);

    /* EXEC SQL CLOSE Cur_ConfRegTipD; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2010;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        iDError (szModulo,ERR000,vInsertarIncidencia,"Close=> Cur_ConfRegTipD",szfnORAerror ());
    }

    return (SQLCODE);
}/***************************** Final ifnCloseRegistrosTipoD **********************/

/* P-MIX-09003 */

int ifnOpenCod_Plantarif()
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> TA_PLANTARIF, TA_CARGOSBASICO", LOG06);

    /* EXEC SQL DECLARE Cur_Cod_Plantarif CURSOR for
            SELECT COD_PLANTARIF   ,
                   DES_PLANTARIF   ,
                   NUM_UNIDADES    ,
                   IMP_CARGOBASICO ,
                   IND_ARRASTRE    ,
                   COD_PRESTACION    /o P-MIX-09003 130964 o/
              FROM TA_PLANTARIF    A,
                   TA_CARGOSBASICO B
             WHERE A.COD_PRODUCTO      = 1
               AND A.COD_CARGOBASICO   = B.COD_CARGOBASICO
               AND A.COD_PRODUCTO      = B.COD_PRODUCTO
               AND (B.FEC_HASTA IS NULL OR B.FEC_HASTA > TRUNC(SYSDATE)) ; */ 


    /* EXEC SQL OPEN Cur_Cod_Plantarif; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0050;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2025;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> TA_PLANTARIF, TA_CARGOSBASICO",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenCod_Plantarif **********************/

BOOL bfnFetchCod_Plantarif(PLAN_TARIFARIO_HOSTS * pst_PlanTarifario, int *iCantPlanes)
{
    /* EXEC SQL FETCH Cur_Cod_Plantarif
        INTO :pst_PlanTarifario->szCod_Plantarif    ,
             :pst_PlanTarifario->szDes_Plantarif    ,
             :pst_PlanTarifario->lMinutosPlan       ,
             :pst_PlanTarifario->dValorPlan         ,
             :pst_PlanTarifario->iInd_Arrastre      ,
             :pst_PlanTarifario->szCod_Prestacion   ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )2040;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pst_PlanTarifario->szCod_Plantarif);
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pst_PlanTarifario->szDes_Plantarif);
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )31;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pst_PlanTarifario->lMinutosPlan);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pst_PlanTarifario->dValorPlan);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )sizeof(double);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pst_PlanTarifario->iInd_Arrastre);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pst_PlanTarifario->szCod_Prestacion);
    sqlstm.sqhstl[5] = (unsigned long )6;
    sqlstm.sqhsts[5] = (         int  )6;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 /* P-MIX-09003 130964 */

    if((SQLCODE == SQLOK) && (SQLCODE != SQLNOTFOUND))
        vDTrazasError(szModulo,"\t\tError en Fetch %s : %s", LOG01, szModulo, SQLERRM);
    else
    {
        *iCantPlanes = sqlca.sqlerrd[2];
    }
    return SQLCODE;
}
/***************************** Final bfnFetchCod_Plantarif ****************/

int ifnCloseCod_Plantarif(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> TA_PLANTARIF, TA_CARGOSBASICO", LOG06);

    /* EXEC SQL CLOSE Cur_Cod_Plantarif; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2079;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> TA_PLANTARIF, TA_CARGOSBASICO",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnCloseFetchCod_Plantarif **********************/


BOOL bfnCargaCod_Plantarif (PLAN_TARIFARIO **pstCodPlanTarif, int *iNumCodPlanes)
{
    int     rc = 0;
    int    iNumFilas;
    PLAN_TARIFARIO_HOSTS stCodPlanTarifHost;
    PLAN_TARIFARIO  *pstCodPlanTarifTemp;
    int iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Planes tarifarios ", LOG06);

    *iNumCodPlanes = 0;
    *pstCodPlanTarif = NULL;

    if (ifnOpenCod_Plantarif())
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchCod_Plantarif(&stCodPlanTarifHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstCodPlanTarif =(PLAN_TARIFARIO*) realloc(*pstCodPlanTarif,(int)(((*iNumCodPlanes)+iNumFilas)*sizeof(PLAN_TARIFARIO)));

        if (!*pstCodPlanTarif)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaCod_Plantarif", "No se pudo reservar memoria");
            return FALSE;
        }

        pstCodPlanTarifTemp = &(*pstCodPlanTarif)[(*iNumCodPlanes)];
        memset(pstCodPlanTarifTemp, 0, (int)(sizeof(PLAN_TARIFARIO)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy( pstCodPlanTarifTemp[iCont].szCod_Plantarif,alltrim(stCodPlanTarifHost.szCod_Plantarif[iCont]));
            strcpy( pstCodPlanTarifTemp[iCont].szDes_Plantarif,stCodPlanTarifHost.szDes_Plantarif[iCont]);
            pstCodPlanTarifTemp[iCont].lMinutosPlan   = stCodPlanTarifHost.lMinutosPlan   [iCont];
            pstCodPlanTarifTemp[iCont].dValorPlan     = stCodPlanTarifHost.dValorPlan     [iCont];
            pstCodPlanTarifTemp[iCont].iInd_Arrastre  = stCodPlanTarifHost.iInd_Arrastre  [iCont];
            strcpy( pstCodPlanTarifTemp[iCont].szCod_Prestacion,stCodPlanTarifHost.szCod_Prestacion[iCont]); /* P-MIX-09003 130964 */

        }
        (*iNumCodPlanes) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* Codigos de Planes Tarifarios cargados [%ld]", LOG06, *iNumCodPlanes);

    rc = ifnCloseCod_Plantarif();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaCod_Plantarif", szfnORAerror ());
        return FALSE;
    }

    qsort((void*)*pstCodPlanTarif, *iNumCodPlanes, sizeof(PLAN_TARIFARIO),ifnCmpCod_PlanTarif);

    vfnPrintCod_PlanTarif (*pstCodPlanTarif, *iNumCodPlanes);

    return (TRUE);
}
/***************************** Final bfnCargaCod_Plantarif *********************/

void vfnPrintCod_PlanTarif (PLAN_TARIFARIO *pstCodPlanTarif, int iNumCodPlanes)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Planes Tarifarios [%d]", LOG06, iNumCodPlanes);

        for (i=0;i<iNumCodPlanes;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo de Plan   [%s]"
                                    "\n\t\t=> [%d]: Desc. del Plan   [%s]"
                                    "\n\t\t=> [%d]: Minutos del Plan [%ld]  Valor Plan [%f]  Ind. de Arrastre [%ld]"
                                    ,LOG06
                                    ,i, pstCodPlanTarif[i].szCod_Plantarif
                                    ,i, pstCodPlanTarif[i].szDes_Plantarif
                                    ,i, pstCodPlanTarif[i].lMinutosPlan , pstCodPlanTarif[i].dValorPlan , pstCodPlanTarif[i].iInd_Arrastre);
        }

    }
}
/*************************** vfnPrintCod_PlanTarif *****************************/


int ifnCmpCod_PlanTarif(const void *cad1,const void *cad2)
{
    return ( strcmp (((PLAN_TARIFARIO  *)cad1)->szCod_Plantarif,((PLAN_TARIFARIO  *)cad2)->szCod_Plantarif) );

}
/*************************** ifnCmpCod_PlanTarif *****************************/


BOOL bfnFindCod_PlanTarif (char *szCodPlanTarif, PLAN_TARIFARIO *pstCodPlanTarif)
{
    PLAN_TARIFARIO  stkey;
    PLAN_TARIFARIO  *pstAux = (PLAN_TARIFARIO *)NULL;

    strcpy (szModulo, "bfnFindCod_PlanTarif");


    vDTrazasLog (szModulo, "\n\t\t* Busca Codigo de Plan Tarifario "
                            "\n\t\t=> Cod. Plan Tarifario   [%s]"
                            , LOG05,szCodPlanTarif );

    strcpy(stkey.szCod_Plantarif, szCodPlanTarif);

    if (pstPlanes.iNumRegPlanTarif > 0)
    {
        if ( (pstAux = (PLAN_TARIFARIO *)bsearch (&stkey, pstPlanes.stPlanesTarifarios , pstPlanes.iNumRegPlanTarif,
            sizeof (PLAN_TARIFARIO),ifnCmpCod_PlanTarif ))== (PLAN_TARIFARIO *)NULL)
        {

            vDTrazasLog(szModulo, "Codigo de Plan Tarifario [%s] no encontrado ...", LOG01, szCodPlanTarif);
            return  (FALSE);
        }
        memcpy (pstCodPlanTarif, pstAux, sizeof(PLAN_TARIFARIO));
    }
    else
    {
        vDTrazasLog(szModulo, "No existen datos para buscar en estructura de Planes tarifarios ...", LOG01);
    }
    return (TRUE);
}



#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif


char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) )
        return(s); 
    while( *p<=32 && *p>1 ) p++;
    strcpy(s,p);
    return(s);
}

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) )
        return(s); 
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )  p--;
    *(++p)=0;
    return(s);
}

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
}

/****************************************************************************/
/*                             funcion : CargaMultiIdiomas                  */
/****************************************************************************/

BOOL CargaMultiIdiomas (GRPMULTIIDIOMA **pstGrpMulti, int *iNumGrpMulti)
{
    int     rc = 0;
    int    iNumFilas;
    GRPMULTIIDIOMAS_HOSTS stGrpMultiHost;
    GRPMULTIIDIOMA *pstGrpMultiTemp;
    int  iCont;

    strcpy (szModulo, "CargaMultiIdiomas");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG06,szModulo);

    *iNumGrpMulti = 0;
    *pstGrpMulti = NULL;

    if (OpenMultiIdiomas())
        return (FALSE);

    while (rc != SQLNOTFOUND)
    {
        rc = FetchMultiIdiomas (&stGrpMultiHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
            return (FALSE);

        if (!iNumFilas)
        break;

        *pstGrpMulti =(GRPMULTIIDIOMA*) realloc(*pstGrpMulti,(int)(((*iNumGrpMulti)+iNumFilas)*sizeof(GRPMULTIIDIOMA)));

        if (!*pstGrpMulti)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error CargaMultiIdiomas", "no se pudo reservar memoria");
            return (FALSE);
        }

        pstGrpMultiTemp = &(*pstGrpMulti)[(*iNumGrpMulti)];
        memset(pstGrpMultiTemp, 0, (int)(sizeof(GRPMULTIIDIOMA)*iNumFilas));

        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy(pstGrpMultiTemp[iCont].szCod_Idioma_Grupos   ,alltrim(stGrpMultiHost.szCod_Idioma_Grupos [iCont]));
            strcpy(pstGrpMultiTemp[iCont].szGlosa_Grupo         ,stGrpMultiHost.szGlosa_Grupo   [iCont]);
            strcpy(pstGrpMultiTemp[iCont].szGlosa_Subgrp        ,alltrim(stGrpMultiHost.szGlosa_Subgrp  [iCont]));
        }
        (*iNumGrpMulti) += iNumFilas;

    }

    rc = CloseMultiIdiomas();
    if (rc == SQLNOTFOUND)
        return TRUE;

    if (rc != SQLOK )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error CargaMultiIdiomas", szfnORAerror ());
        return (FALSE);
    }
    if (*iNumGrpMulti > 0)
    {
        qsort((void*)*pstGrpMulti, *iNumGrpMulti, sizeof(GRPMULTIIDIOMA),ifnCmpGrpMulti);
        vfnPrintGrpMulti (*pstGrpMulti, *iNumGrpMulti);
    }
    return (TRUE);
}
/***************************** Final CargaMultiIdiomas *********************/

/****************************************************************************/
/*                             funcion : OpenMultiIdiomas                   */
/****************************************************************************/

int OpenMultiIdiomas ( void )
{
    strcpy (szModulo, "OpenMultiIdiomas");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL DECLARE curMultiIdiomas CURSOR FOR
            SELECT substr(TO_CHAR(TO_NUMBER(substr(C.COD_CONCEPTO,1,4)),'0009'),2) || C.COD_IDIOMA CONCEPTO,
                   substr(B.DES_CONCEPTO,1,50),
                   substr(C.DES_CONCEPTO,1,50)
              FROM FAD_IMPSUBGRUPOS A,
                   GE_MULTIIDIOMA B,
                   GE_MULTIIDIOMA C
             WHERE TO_CHAR(A.COD_GRUPO)=B.COD_CONCEPTO
               AND B.NOM_TABLA='FAD_IMPGRUPOS' AND B.NOM_CAMPO='COD_GRUPOS'
               AND TO_CHAR(A.COD_SUBGRUPO)=C.COD_CONCEPTO
               AND C.NOM_TABLA='FAD_IMPSUBGRUPOS' AND C.NOM_CAMPO='COD_SUBGRUPO'
               AND B.COD_IDIOMA=C.COD_IDIOMA
          ORDER BY CONCEPTO; */ 


    /* EXEC SQL OPEN curMultiIdiomas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0051;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2094;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-OPEN CURSOR curMultiIdiomas **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-OPEN CURSOR curMultiIdiomas **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (SQLCODE);
    }
    return (SQLCODE);
}
/*********************** Final de OpenMultiIdiomas ***********************/

/****************************************************************************/
/* Funcion: int FetchMultiIdiomas                                           */
/* Funcion que realiza Fetch en el cursor de curMultiIdiomas                     */
/****************************************************************************/

BOOL FetchMultiIdiomas (GRPMULTIIDIOMAS_HOSTS *pstHost,int  *piNumFilas)
{
    /* EXEC SQL FETCH curMultiIdiomas
            INTO    :pstHost->szCod_Idioma_Grupos,
                    :pstHost->szGlosa_Grupo ,
                    :pstHost->szGlosa_Subgrp; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2109;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCod_Idioma_Grupos);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szGlosa_Grupo);
    sqlstm.sqhstl[1] = (unsigned long )51;
    sqlstm.sqhsts[1] = (         int  )51;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szGlosa_Subgrp);
    sqlstm.sqhstl[2] = (unsigned long )51;
    sqlstm.sqhsts[2] = (         int  )51;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Oficinas",
               szfnORAerror ());

  return SQLCODE;
}
/***************************** Final FetchMultiIdiomas ****************/


/****************************************************************************/
/*  Funcion: int CloseMultiIdiomas(void)                                   */
/*  Funcion que cierra el cursor de curMultiIdiomas                           */
/****************************************************************************/

int CloseMultiIdiomas(void)
{
    strcpy (szModulo, "CloseMultiIdiomas");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL CLOSE curMultiIdiomas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2136;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szModulo,"\tError al cerrar el Cursor curMultiIdiomas: %s",LOG01, SQLERRM);
    }
    return (SQLCODE);
}
/****************Final de CloseMultiIdiomas *******************/


/****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                   */
/****************************************************************************/

void vfnPrintGrpMulti (GRPMULTIIDIOMA *pstEstruc, int iNumRegs)
{
  int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Grupos Multiidiomas [%d]", LOG06, iNumRegs);

        for (i=0;i<iNumRegs;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo Idioma   [%s]"
                                    "\n\t\t=> [%d]: Glosa Grupo     [%s]"
                                    "\n\t\t=> [%d]: Glosa SubGrupo  [%s]"
                                    ,LOG06
                                    ,i, pstEstruc[i].szCod_Idioma_Grupos
                                    ,i, pstEstruc[i].szGlosa_Grupo
                                    ,i, pstEstruc[i].szGlosa_Subgrp);
        }
    }
}
/*************************** vfnPrintOperadoras *****************************/

/****************************************************************************/
/*                             funcion : ifnCmpGrpMulti                     */
/****************************************************************************/

int ifnCmpGrpMulti (const void *cad1,const void *cad2)
{
    return ( strcmp (((GRPMULTIIDIOMA *)cad1)->szCod_Idioma_Grupos
                    ,((GRPMULTIIDIOMA *)cad2)->szCod_Idioma_Grupos) );

}
/*********************** Final de ifnCmpGrpMulti ***************************/

/****************************************************************************/
/*  Funcion: int BuscaMultiIdiomas                                          */
/*  Funcion que busca un Concepto                                           */
/****************************************************************************/

BOOL BuscaMultiIdiomas (char *szCod_Multiidioma, GRPMULTIIDIOMA *pstGrpMulti )
{
    GRPMULTIIDIOMA  stkey;
    GRPMULTIIDIOMA  *pstAux = (GRPMULTIIDIOMA *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Grupo Multiidioma "
                            "\n\t\t=> Codigo      [%s]"
                            "\n\t\t=> Num.Grupos  [%d]"
                            , LOG05,szCod_Multiidioma, stGrpMultiidiomas.iNumRegs);

    strcpy (stkey.szCod_Idioma_Grupos,szCod_Multiidioma);

    if (stGrpMultiidiomas.iNumRegs > 0)
    {
        if ( (pstAux = (GRPMULTIIDIOMA *)bsearch (&stkey, stGrpMultiidiomas.stGrpIdiomas, stGrpMultiidiomas.iNumRegs,
                                   sizeof (GRPMULTIIDIOMA),ifnCmpGrpMulti ))== (GRPMULTIIDIOMA *)NULL)
        {
            vDTrazasLog(szExeName, "Codigo [%s] no encontrado ", LOG01, szCod_Multiidioma);
            return  (FALSE);
        }
        memcpy (pstGrpMulti, pstAux, sizeof(GRPMULTIIDIOMA));
    }
    else
    {
        vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Multiidiomas ...", LOG01);
    }


    return TRUE;
}
/**************************** Final BuscaMultiIdiomas *********************/

/****************************************************************************/
/*                     funcion : CargaNumOrden                              */
/*  recupera los Numero de Orden de los Grupos, SubGrupos y Conceptos       */
/****************************************************************************/

BOOL CargaNumOrden (NUMORDEN **pstNumOrden, int *iNumRegs, int iCodFormulario )
{
    int     rc = 0;
    int    iNumFilas;
    NUMORDENES_HOSTS stNumOrdenHost;
    NUMORDEN *pstNumOrdenTemp;
    int  iCont;

    strcpy (szModulo, "CargaNumOrden");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG06,szModulo);

    *iNumRegs = 0;
    *pstNumOrden = NULL;

    if (OpenNumOrden(iCodFormulario))
        return (FALSE);

    while (rc != SQLNOTFOUND)
    {
        rc = FetchNumOrden (&stNumOrdenHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
            return (FALSE);

        if (!iNumFilas)
        break;

        *pstNumOrden =(NUMORDEN*) realloc(*pstNumOrden,(int)(((*iNumRegs)+iNumFilas)*sizeof(NUMORDEN)));

        if (!*pstNumOrden)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error CargaNumOrden", "no se pudo reservar memoria");
            return (FALSE);
        }

        pstNumOrdenTemp = &(*pstNumOrden)[(*iNumRegs)];
        memset(pstNumOrdenTemp, 0, (int)(sizeof(NUMORDEN)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            pstNumOrdenTemp[iCont].iNum_OrdenGr     = stNumOrdenHost.iNum_OrdenGr[iCont];
            pstNumOrdenTemp[iCont].iNum_OrdenSubGr  = stNumOrdenHost.iNum_OrdenSubGr[iCont];
            pstNumOrdenTemp[iCont].iNum_OrdenConc   = stNumOrdenHost.iNum_OrdenConc[iCont];
            pstNumOrdenTemp[iCont].iCodGrupo        = stNumOrdenHost.iCodGrupo[iCont];
            pstNumOrdenTemp[iCont].iCodSubGrupo     = stNumOrdenHost.iCodSubGrupo[iCont];
            pstNumOrdenTemp[iCont].iCodConcepto     = stNumOrdenHost.iCodConcepto[iCont];
            strcpy(pstNumOrdenTemp[iCont].szCodRegistro ,alltrim(stNumOrdenHost.szCodRegistro[iCont]));
            pstNumOrdenTemp[iCont].iCodCriterio = stNumOrdenHost.iCodCriterio[iCont];
            pstNumOrdenTemp[iCont].iTipo_Llamada    = stNumOrdenHost.iTipo_Llamada[iCont];
            pstNumOrdenTemp[iCont].iTipo_SubGrupo   = stNumOrdenHost.iTipo_SubGrupo[iCont];
        }
        (*iNumRegs) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* Numeros de Orden cargados [%ld]", LOG06, *iNumRegs);

    rc = CloseNumOrden();

    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error CargaNumOrden", szfnORAerror ());
        return (FALSE);
    }

    qsort((void*)*pstNumOrden, *iNumRegs, sizeof(NUMORDEN),ifnCmpNumOrden);

    vfnPrintNumOrden (*pstNumOrden, *iNumRegs);

    return (TRUE);
}
/***************************** Final CargaNumOrden *************************/

/****************************************************************************/
/*                             funcion : OpenNumOrden                   */
/****************************************************************************/

int OpenNumOrden ( int iCodFormulario )
{
    strcpy (szModulo, "OpenNumOrden");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL DECLARE curNumOrden CURSOR FOR
            SELECT  C.NUM_ORDEN GRP     ,
                B.NUM_ORDEN SGRP    ,
                A.NUM_ORDEN CONC    ,
                C.COD_GRUPO     ,
                B.COD_SUBGRUPO      ,
                A.COD_CONCEPTO      ,
                NVL(B.COD_REGISTRO,'D3001') ,
                NVL(B.CRIT_ORDEN,0) ,
                NVL(B.COD_TIPLLAMADA,0) ,
                B.COD_TIPSUBGRUPO
        FROM    FAD_IMPCONCEPTOS A  ,
            FAD_IMPSUBGRUPOS B  ,
            FAD_IMPGRUPOS C
        WHERE   A.COD_CONCEPTO  > 0
        AND     A.COD_SUBGRUPO  = B.COD_SUBGRUPO
        AND     B.COD_GRUPO     = C.COD_GRUPO
        AND     C.COD_FORMULARIO= :iCodFormulario
        ORDER BY A.COD_CONCEPTO; */ 


    /* EXEC SQL OPEN curNumOrden; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0052;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2151;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCodFormulario;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-OPEN CURSOR curNumOrden **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-OPEN CURSOR curNumOrden **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (SQLCODE);
    }
    return (SQLCODE);
}
/*********************** Final de OpenNumOrden ***********************/

/****************************************************************************/
/* Funcion: int FetchNumOrden                                               */
/* Funcion que realiza Fetch en el cursor de curNumOrden                    */
/****************************************************************************/

BOOL FetchNumOrden (NUMORDENES_HOSTS *pstHost,int *piNumFilas)
{
    /* EXEC SQL FETCH curNumOrden
            INTO    :pstHost->iNum_OrdenGr      ,
                    :pstHost->iNum_OrdenSubGr   ,
                    :pstHost->iNum_OrdenConc    ,
                    :pstHost->iCodGrupo     ,
                    :pstHost->iCodSubGrupo      ,
                    :pstHost->iCodConcepto      ,
                    :pstHost->szCodRegistro     ,
                    :pstHost->iCodCriterio      ,
                    :pstHost->iTipo_Llamada     ,
                    :pstHost->iTipo_SubGrupo    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2170;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iNum_OrdenGr);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->iNum_OrdenSubGr);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iNum_OrdenConc);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->iCodGrupo);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->iCodSubGrupo);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->iCodConcepto);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )sizeof(int);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szCodRegistro);
    sqlstm.sqhstl[6] = (unsigned long )6;
    sqlstm.sqhsts[6] = (         int  )6;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->iCodCriterio);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )sizeof(int);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->iTipo_Llamada);
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )sizeof(int);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->iTipo_SubGrupo);
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )sizeof(int);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Num.Orden", szfnORAerror ());

    return SQLCODE;
}
/***************************** Final FetchNumOrden *********************/


/****************************************************************************/
/*  Funcion: int CloseNumOrden(void)                                        */
/*  Funcion que cierra el cursor de CloseNumOrden                           */
/****************************************************************************/

int CloseNumOrden(void)
{
    strcpy (szModulo, "CloseNumOrden");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL CLOSE curNumOrden; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2225;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szModulo,"\tError al cerrar el Cursor curNumOrden: %s",LOG01, SQLERRM);
    }
    return (SQLCODE);
}
/****************Final de CloseNumOrden *******************/


/****************************************************************************/
/*                             funcion : ifnCmpNumOrden                     */
/****************************************************************************/

int ifnCmpNumOrden (const void *cad1,const void *cad2)
{
    return ( ((NUMORDEN *)cad1)->iCodConcepto -((NUMORDEN *)cad2)->iCodConcepto) ;

}
/*********************** Final de ifnCmpNumOrden ***************************/

/****************************************************************************/
/*  Funcion: int BuscaNumOrden                                              */
/*  Funcion que busca para un Concepto el orden de impresion                */
/****************************************************************************/

BOOL BuscaNumOrden (int iCodConcepto, NUMORDEN *pstNumOrden )
{
    NUMORDEN  stkey;
    NUMORDEN  *pstAux = (NUMORDEN *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Num. Orden "
                            "\n\t\t=> Concepto  [%d]"
                            "\n\t\t=> Registros     [%d]"
                            , LOG05,iCodConcepto, stNumOrdenes.iNumRegs);

    stkey.iCodConcepto=iCodConcepto;
    if (stNumOrdenes.iNumRegs)
    {
        if ( (pstAux = (NUMORDEN *)bsearch (&stkey, stNumOrdenes.stNumOrden, stNumOrdenes.iNumRegs,
                                   sizeof (NUMORDEN),ifnCmpNumOrden ))== (NUMORDEN *)NULL)
        {
            vDTrazasLog(szExeName, "Codigo [%d] no encontrado ", LOG01, iCodConcepto);
            return  (FALSE);
        }
        memcpy (pstNumOrden, pstAux, sizeof(NUMORDEN));
    }
    else
    {
        vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Orden ...", LOG01);
    }


    return TRUE;
}
/**************************** Final BuscaNumOrden  *************************/


/****************************************************************************/
/*                           funcion : vfnPrintNumOrden                     */
/****************************************************************************/

void vfnPrintNumOrden (NUMORDEN *pstEstruc, int iNumRegs)
{
  int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Numeros de Orden [%d]", LOG06, iNumRegs);

        for (i=0;i<iNumRegs;i++)
        {
             vDTrazasLog (szExeName,
                         "\n\t\t=> [%d]: Ord. Grupo    [%d] Ord. subGrupo [%d] Ord. Concepto [%d]"
                         "\n\t\t=> [%d]: Cod. Grupo    [%d] Cod. SubGrupo [%d] Cod. Concepto [%d]"
                         "\n\t\t=> [%d]: Cod. Registro [%s] Cod. Criterio [%d]"
                         ,LOG06
                         ,i, pstEstruc[i].iNum_OrdenGr, pstEstruc[i].iNum_OrdenSubGr, pstEstruc[i].iNum_OrdenConc
                         ,i, pstEstruc[i].iCodGrupo   , pstEstruc[i].iCodSubGrupo , pstEstruc[i].iCodConcepto
                         ,i, pstEstruc[i].szCodRegistro , pstEstruc[i].iCodCriterio);
        }
    }
}
/*************************** vfnPrintNumOrden *****************************/


extern BOOL CargaEstructuraInicial(NUMORDEN *pstNumOrden, int iCantOrdenes)
{
    int i;
    DETCELULAR_AGRUP  *stDetCelularTemp;

    for (i=0; i < iCantOrdenes; i++)
    {
        if (pstNumOrden[i].iTipo_SubGrupo == 3)
        {
            stDetCelular.stAgrupacion = (DETCELULAR_AGRUP*) realloc(stDetCelular.stAgrupacion, (int) (sizeof(DETCELULAR_AGRUP) * (stDetCelular.iCantEstructuras + 1)) );
            stDetCelularTemp = &(stDetCelular.stAgrupacion)[(stDetCelular.iCantEstructuras)];
            memset(stDetCelularTemp, 0, sizeof(DETCELULAR_AGRUP));

            stDetCelularTemp->iNum_OrdenGr      =  pstNumOrden[i].iNum_OrdenGr;
            stDetCelularTemp->iNum_OrdenSubGr   =  pstNumOrden[i].iNum_OrdenSubGr;
            stDetCelularTemp->iCodGrupo         =  pstNumOrden[i].iCodGrupo;
            stDetCelularTemp->iCodSubGrupo      =  pstNumOrden[i].iCodSubGrupo;
            stDetCelularTemp->iCriterio         =  pstNumOrden[i].iCodCriterio;
            stDetCelularTemp->iTipo_Llamada     =  pstNumOrden[i].iTipo_Llamada;
            strcpy(stDetCelularTemp->szCodRegistro,pstNumOrden[i].szCodRegistro);

            stDetCelular.iCantEstructuras++;
        }
    }
    return (TRUE);
}

/****************************************************************************/
/* Funcion     : int OpenAbonado (long lCiclFact, long lIndOrden)           */
/* Descripcion : Realiza open del cursor sql_Cur_Abonado                    */
/****************************************************************************/

int OpenAbonado (long lCiclFact, long lIndOrden)
{
    char szTablaAbon [40]    ="";
    char szQry       [1000]  ="";

    strcpy (szModulo, "OpenAbonado");
    vDTrazasLog(szModulo,"\t**Entrando a %s "
                         "\n\t=> Ind.Ordentotal [%ld]"
                        , LOG04, szModulo,lIndOrden);

    if ( !lCiclFact ) {
        sprintf(szTablaAbon,"FA_FACTABON_NOCICLO");  }
    else {
        sprintf(szTablaAbon,"FA_FACTABON_%ld",lCiclFact); }

    sprintf(szQry,
        "\n SELECT NUM_ABONADO ,"
               "\n NUM_CELULAR ,"
               "\n COD_DETFACT ,"
               "\n COD_PRODUCTO,"
               "\n NVL(replace(NOM_USUARIO,'%%','N'),' '),"
               "\n NVL(NOM_APELLIDO1,' '),"
               "\n NVL(NOM_APELLIDO2,' '),"
               "\n NVL(IND_COBRODETLLAM,0)"
          "\n FROM %s"
         "\n WHERE IND_ORDENTOTAL = :lhIndOrdentotal"
           "\n AND NUM_ABONADO    >= 0"
           "\n AND NUM_CELULAR  IS NOT NULL"
         "\n ORDER BY NUM_CELULAR" , szTablaAbon);

    vDTrazasLog(szModulo,"\t\tQRY:[ %s ]",LOG06,szQry);

    /* EXEC SQL PREPARE sql_Cur_Abonado FROM :szQry; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2240;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szQry;
    sqlstm.sqhstl[0] = (unsigned long )1000;
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-PREPARE sql_Abonados_DetLlam **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-PREPARE sql_Abonados_DetLlam **"
                                      "\t\tError : [%s] [%d]  [%s] ",LOG01,szQry,SQLCODE,SQLERRM);
        return (SQLCODE);
    }

    /* EXEC SQL DECLARE curAbonadoFact CURSOR FOR sql_Cur_Abonado; */ 


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-DECLARE curAbonadoFact **"
                        "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-DECLARE curAbonadoFact **"
                        "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (SQLCODE);
    }


    lhIndOrdentotal=lIndOrden;

    /* EXEC SQL OPEN curAbonadoFact USING :lhIndOrdentotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2259;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdentotal;
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t\tError en SQL-OPEN CURSOR curAbonadoFact **"
                               "\n\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t\tError en SQL-OPEN CURSOR curAbonadoFact **"
                               "\n\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }

    return (SQLCODE);
}
/*********************** Final de OpenAbonado ***********************/

/****************************************************************************/
/* Funcion: int FetchAbonado(ST_ABONADO *)                              */
/* Funcion que realiza Fetch en el cursor de curFactDoc                     */
/****************************************************************************/

int FetchAbonado (ST_ABONADO *pstAbonadoFact)
{
    strcpy (szModulo, "FetchAbonado");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);
    /* EXEC SQL
    FETCH curAbonadoFact
    INTO :pstAbonadoFact->lNumAbonado    ,
         :pstAbonadoFact->lNumCelular    ,
         :pstAbonadoFact->iIndDetFact    ,
         :pstAbonadoFact->iCodProducto   ,
         :pstAbonadoFact->sznom_usuario  ,
         :pstAbonadoFact->sznom_apellido1,
         :pstAbonadoFact->sznom_apellido2,
         :pstAbonadoFact->iIndCobroDetLlam; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )40000;
    sqlstm.offset = (unsigned int  )2278;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstAbonadoFact->lNumAbonado);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstAbonadoFact->lNumCelular);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstAbonadoFact->iIndDetFact);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstAbonadoFact->iCodProducto);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstAbonadoFact->sznom_usuario);
    sqlstm.sqhstl[4] = (unsigned long )21;
    sqlstm.sqhsts[4] = (         int  )21;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstAbonadoFact->sznom_apellido1);
    sqlstm.sqhstl[5] = (unsigned long )21;
    sqlstm.sqhsts[5] = (         int  )21;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstAbonadoFact->sznom_apellido2);
    sqlstm.sqhstl[6] = (unsigned long )21;
    sqlstm.sqhsts[6] = (         int  )21;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstAbonadoFact->iIndCobroDetLlam);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )sizeof(int);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

         

    if((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
      vDTrazasError(szModulo,"\t\tError en Fetch FetchAbonado : %s", LOG01, SQLERRM);
    }
    else
        pstAbonadoFact->CantidadAbonados = sqlca.sqlerrd[2];

    return(SQLCODE);
}
/*************************** Final de FetchAbonado ***************************/

/****************************************************************************/
/*  Funcion: int CloseAbonado(void)                                      */
/*  Funcion que cierra el cursor de AbonadoFact                             */
/****************************************************************************/
int CloseAbonado(void)
{
    strcpy (szModulo, "CloseAbonado");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);
    /* EXEC SQL CLOSE curAbonadoFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2325;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
      vDTrazasError(szModulo,"\tError al cerrar el Cursor FA_FACTABON_CICLO: %s",LOG01, SQLERRM);
      return (FALSE);
    }
    return (TRUE);
}
/****************Final de bfnCloseFactTrafico *******************/

/*
Se agrega funcion iCargaFechaSuspension para rescatar la fecha de suspension de un cliente; este dato sera
imprimido en registro A1000.
*/

int iCargaFechaSuspension(long lCodCliente, char *sFVencim, char *sFecSuspen)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lCod_Cli;
    char sF_Venci[12];
    char sFSuspension[12];
    /* EXEC SQL END DECLARE SECTION; */ 


    lCod_Cli=lCodCliente;
    strncpy(sF_Venci,sFVencim,8);
    sF_Venci[8] = '\0';

    /* EXEC SQL EXECUTE
        BEGIN
          :sFSuspension := TO_CHAR (TO_DATE (CO_FECSUSP_FN (:lCod_Cli, TO_DATE(:sF_Venci,'YYYYMMDD')), 'DD-MON-YYYY'), 'DDMMYYYY');
        END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :sFSuspension := TO_CHAR ( TO_DATE ( CO_FECSUSP_FN \
( :lCod_Cli , TO_DATE ( :sF_Venci , 'YYYYMMDD' ) ) , 'DD-MON-YYYY' ) , 'DDMMYY\
YY' ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2340;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)sFSuspension;
    sqlstm.sqhstl[0] = (unsigned long )12;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCod_Cli;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)sF_Venci;
    sqlstm.sqhstl[2] = (unsigned long )12;
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



    if (SQLCODE != SQLOK)
    {
       vDTrazasLog("iCargaFechaSuspension", "Error en SELECT iCargaFechaSuspension:(%s)", LOG05,SQLERRM);
       return(FALSE);
    }

    strcpy(sFecSuspen,sFSuspension);
    return(TRUE);
}

/* Se agrega funcion bfnCargaCodImptoFact para rescatar rescatar y poner estructura los datos 
   de codigos de concepto */

BOOL bfnCargaCodImptoFact(CODIMPTOSFACT *stImp_Fact)
{
    COD_IMPTOFACT *stImp_FactTemp;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lCod_Imp_fact;
    int  ihCodParametro = 207;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szModulo,"bfnCargaCodImptoFact");
    /* EXEC SQL DECLARE cImpFactura CURSOR FOR
      SELECT val_numerico
        FROM FAD_PARAMETROS
       WHERE COD_PARAMETRO = :ihCodParametro; */ 


    /* EXEC SQL OPEN cImpFactura; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0055;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2367;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodParametro;
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


    if(SQLCODE != SQLOK)
    {
       vDTrazasLog  (szModulo, "\n\t**  Error : En Open Cursor cImpFactura \n%s\n",LOG01,SQLERRM);
       return (FALSE);
    }
    memset(stImp_Fact,0,sizeof(stImp_Fact));
    while (SQLCODE != SQLNOTFOUND)
    {
        /* EXEC SQL FETCH cImpFactura INTO :lCod_Imp_fact; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2386;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lCod_Imp_fact;
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



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szModulo, "Error en Fetch de Cursor cImpFactura[%d]: %s",LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        if (SQLCODE == SQLOK)
        {
            stImp_Fact->stCodImptosFact =(COD_IMPTOFACT *) realloc(stImp_Fact->stCodImptosFact,(int)((stImp_Fact->iNumReg + 1) * sizeof(COD_IMPTOFACT)));
            if (stImp_Fact->stCodImptosFact == NULL)
            {
                iDError (szExeName,ERR000,vInsertarIncidencia,
                              "Error bfnCargaCodImptoFact", "no se pudo reservar memoria");
                return FALSE;
            }

            stImp_FactTemp = &(stImp_Fact->stCodImptosFact)[(stImp_Fact->iNumReg )];
            memset(stImp_FactTemp, 0, (int)(sizeof(COD_IMPTOFACT)));
            stImp_FactTemp->lCodImptoFact = lCod_Imp_fact;
            stImp_Fact->iNumReg ++ ;
        }
    }

    stImp_Fact->iNumReg= sqlca.sqlerrd[2];

    return(TRUE);
}

BOOL bfnCargaGedPar()
{
    char szNomParam [21];
    char szValParam [21];
    char szCodModulo[3];

    strcpy(szModulo,"bfnCargaGedPar");

    memset(&stGedParametros,'\0',sizeof(stGedParametros));

    strcpy(szCodModulo, "FA");

    sprintf(szNomParam, "%20.20s\0", "TOL_COD_TDIA");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodTDia,szValParam);


    sprintf(szNomParam, "%20.20s\0", "TOL_COD_LLAM");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodLlam    ,szValParam    );


    sprintf(szNomParam, "%20.20s\0", "TOL_COD_TDIR");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodTDir    ,szValParam    );

    sprintf(szNomParam, "%20.20s\0", "TOL_COD_THOR");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodTHor    ,szValParam);

    sprintf(szNomParam, "%20.20s\0", "TOL_COD_THOR_ALTA");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodTHorAlta,szValParam);

    sprintf(szNomParam, "%20.20s\0", "TOL_COD_THOR_BAJA");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodTHorBaja,szValParam);

    sprintf(szNomParam, "%20.20s\0", "TOL_CON_CLIENTE");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolConCliente ,szValParam );

    sprintf(szNomParam, "%20.20s\0", "TOL_COD_OPERADOR");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodOperador,szValParam);

    sprintf(szNomParam, "%20.20s\0", "TOL_COD_SFRAN");
    if (!bfnGetGedParam(szNomParam, szCodModulo, szValParam))
    {
         return (FALSE);
    }
    strcpy (stGedParametros.szTolCodSFran   ,szValParam   );

    return(TRUE);
}

BOOL bfnGetGedParam(char * pszNomParam, char *pszCodModulo, char *pszValParam)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

      char szhNomParametro[21];
      char szhValParametro[21];
      char szhCodModulo[3];
      int  ihCodProducto;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhNomParametro, alltrim(pszNomParam));
    strcpy(szhCodModulo, alltrim(pszCodModulo));
    ihCodProducto = 1;

    /* EXEC SQL
        SELECT VAL_PARAMETRO
          INTO :szhValParametro
          FROM GED_PARAMETROS
         WHERE NOM_PARAMETRO = :szhNomParametro
           AND COD_MODULO    = :szhCodModulo
           AND COD_PRODUCTO  = :ihCodProducto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2405;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhValParametro;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNomParametro;
    sqlstm.sqhstl[1] = (unsigned long )21;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodModulo;
    sqlstm.sqhstl[2] = (unsigned long )3;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo, "\n\t**Error : En consulta parametro %s \n%s\n",LOG01,pszNomParam,SQLERRM);
        return (FALSE);
    }

    strcpy (pszValParam, szhValParametro);
    return (TRUE);

}

/***************************************************************************/
/* FUNCION : bfnCargaCodImptoCateg                                         */
/***************************************************************************/
BOOL bfnCargaCodImptoCateg(CATIMPUESTOS *st_catImpuestos)
{
    register int j;
    CATIMPUES *stCatImpuestosTemp;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int  icod_conc;
        int  icod_cat;
        int  iCodTipImpto;
        double dprc_imp;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szModulo,"bfnCargaCodImptoCateg");
    /* EXEC SQL DECLARE cCodImpCateg CURSOR FOR
         SELECT  distinct (A.COD_CONCGENE), 
                 B.COD_CATEIMP, 
                 A.PRC_IMPUESTO, 
                 A.COD_TIPIMPUES
         FROM    GE_IMPUESTOS A, GE_TIPIMPUES B
         WHERE   A.COD_TIPIMPUES = B.COD_TIPIMPUE 
         ORDER   BY A.COD_CONCGENE ASC; */ 


    /* EXEC SQL OPEN cCodImpCateg; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0057;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2436;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo, "\n\t**  Error : En Open Cursor cCodImpCateg \n%s\n",LOG01,SQLERRM);
        return (FALSE);
    }
    memset(st_catImpuestos,0,sizeof(st_catImpuestos));
    st_catImpuestos->iNumRegs= sqlca.sqlerrd[2];
    while (SQLCODE != SQLNOTFOUND)
    {
        /* EXEC SQL FETCH cCodImpCateg INTO
                :icod_conc,:icod_cat,:dprc_imp,:iCodTipImpto; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2451;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&icod_conc;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&icod_cat;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&dprc_imp;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&iCodTipImpto;
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



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szModulo, "Error en Fetch de Cursor cCodImpCateg[%ld]: %s",LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }

        st_catImpuestos->stCatImpuesto =(CATIMPUES *) realloc(st_catImpuestos->stCatImpuesto,((st_catImpuestos->iNumRegs + 1 ) * sizeof(CATIMPUES) ));

        if (st_catImpuestos->stCatImpuesto == NULL)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                      "Error bfnCargaCodImptoCateg", "no se pudo reservar memoria");
            return FALSE;
        }
        stCatImpuestosTemp = &(st_catImpuestos->stCatImpuesto)[(st_catImpuestos->iNumRegs )];
        memset(stCatImpuestosTemp, 0, (int)(sizeof(CATIMPUES)));
        stCatImpuestosTemp->iCodConcepto    =icod_conc;
        stCatImpuestosTemp->iCodCategoria   =icod_cat;
        stCatImpuestosTemp->dPrcImpuesto    =dprc_imp;
        stCatImpuestosTemp->iCodTipImpto    =iCodTipImpto;
        strcpy(stCatImpuestosTemp->szFlagImpto,"");
        st_catImpuestos->iNumRegs++;
    }

    vDTrazasLog(szModulo,"\n\tConjunto de Categorias Impositivas"
                         "\t\tCONCEPTO|CATEGORIA|PORCENTAJE|TIPO IMPUESTO|FLAG",LOG05);
    for (j=0;j<st_catImpuestos->iNumRegs;j++)
    {
        vDTrazasLog(szModulo,"\t\t[%d] %ld|%d|%f|%d|%s|",LOG05,j
                            ,st_catImpuestos->stCatImpuesto[j].iCodConcepto
                            ,st_catImpuestos->stCatImpuesto[j].iCodCategoria
                            ,st_catImpuestos->stCatImpuesto[j].dPrcImpuesto
                            ,st_catImpuestos->stCatImpuesto[j].iCodTipImpto
                            ,st_catImpuestos->stCatImpuesto[j].szFlagImpto);
    }
    return(TRUE);
}
/****************************** Fin bfnCargaCodImptoCateg **********************************/

int iTotalizaImpuestoFactura(void)
{
    int i;

    stFaDetCons.dGravFactura=0;

    strcpy (szModulo, "iTotalizaImpuestoFactura");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    for(i=0;i<stFaDetCons.iNumReg;i++)
    {
        if(  bfnFindCodImptoFact(stFaDetCons.stDetConsumo[i].iCodConcepto))
        {
            stFaDetCons.dGravFactura  += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
        }
    }

    return(TRUE);
}

BOOL bfnFindCodImptoFact(int iCodConcepto)
{
    COD_IMPTOFACT  stkey;
    COD_IMPTOFACT *elementoPtr = (COD_IMPTOFACT *)NULL;

    vDTrazasLog (szExeName, "\n*Ingresa a bfnFindCodImptoFact... ", LOG05);

    if (pstImptosFact.iNumReg > 0)
    {
        vDTrazasLog (szExeName, "\n*Busca Codigo de Impuesto Factura Cod. Concepto [%d]", LOG05,iCodConcepto);
        stkey.lCodImptoFact=iCodConcepto;
        if ( (elementoPtr = (COD_IMPTOFACT *)bsearch (&stkey, pstImptosFact.stCodImptosFact , pstImptosFact.iNumReg,
            sizeof (COD_IMPTOFACT),ifnCmpCodImptoFact )) == (COD_IMPTOFACT *)NULL)
        {
            vDTrazasLog(szExeName, "Cod. Concepto [%i] no encontrado ...", LOG06, iCodConcepto);
            return  (FALSE);
        }
    }
    else
    {
        vDTrazasLog (szExeName, "\n Estructura pstImptosFact no tiene datos.", LOG05);
    }

    return (TRUE);
}


int ifnCmpCodImptoFact (const void *cad1,const void *cad2)
{
    return ( ((COD_IMPTOFACT *)cad1)->lCodImptoFact - ((COD_IMPTOFACT *)cad2)->lCodImptoFact );
}

BOOL bfnTotImptosCateg(int iCodConcepto,int iColumna,double *pdTotalPrimeraCategoria, double *pdTotalSegundaCategoria )
{
    register int i;
    int iCategoria;
    double dAcumPrimeraCategoria=0.0;
    double dAcumSegundaCategoria=0.0;
    strcpy (szModulo, "bfnTotImptosCateg");

    vDTrazasLog(szModulo, "\tEntro a %s "
                          "\n\t\tBusqueda Concepto  [%d] Columna [%d] "
                          , LOG05, szModulo, iCodConcepto, iColumna );

    if (iCodConcepto == 0 )
        return TRUE;

    for (i=0; i < stFaDetCons.iNumReg; i++ )
    {
        if ( stFaDetCons.stDetConsumo[i].iCodConcerel == iCodConcepto &&
             stFaDetCons.stDetConsumo[i].iColumnaRel  == iColumna     &&
             stFaDetCons.stDetConsumo[i].iCodTipConce == 1)
        {
            if(!bfnCategImpto(stFaDetCons.stDetConsumo[i].iCodConcepto,&iCategoria,stFaDetCons.stDetConsumo[i].dPrcImpuesto))
            {
                vDTrazasLog("bfnCategImpto","No pudo encontrar el concepto con su categoria [%d][%f]"
                                           ,LOG05,stFaDetCons.stDetConsumo[i].iCodConcepto
                                           ,stFaDetCons.stDetConsumo[i].dPrcImpuesto);
            }
            else
            {
                vDTrazasLog("bfnCategImpto","\tConcepto         [%d]"
                                            "\tPorcentaje       [%f]"
                                            "\tCategoria Actual [%d] Primera categoria [%d]"
                                            ,LOG05,stFaDetCons.stDetConsumo[i].iCodConcepto
                                            ,stFaDetCons.stDetConsumo[i].dPrcImpuesto
                                            ,iCategoria,iGPrimCateg);
                if (iCategoria == iGPrimCateg)
                {
                    dAcumPrimeraCategoria +=stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                }
                else
                {
                    dAcumSegundaCategoria +=stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                }
            }
        }
    }
    *pdTotalPrimeraCategoria=dAcumPrimeraCategoria;
    *pdTotalSegundaCategoria=dAcumSegundaCategoria;

    return(TRUE);
}

BOOL bfnCategImpto(int iCodConcepto, int *iCodCategoria,double dPrcImpto)
{

    CATIMPUES  stkey;
    CATIMPUES *elementoPtr = (CATIMPUES *)NULL;

    vDTrazasLog (szExeName, "\n\t* Busca Categoria del Impuesto"
                            "\n\t\tCod. Concepto [%d]"
                            "\n\t\tPorcentaje [%f]", LOG05,iCodConcepto,dPrcImpto);
    stkey.iCodConcepto=iCodConcepto;
    stkey.dPrcImpuesto=dPrcImpto;

    if (pstCatImpues.iNumRegs > 0)
    {
        if ( (elementoPtr = (CATIMPUES *)bsearch (&stkey, pstCatImpues.stCatImpuesto , pstCatImpues.iNumRegs,
            sizeof (CATIMPUES),ifnCmpCodImptos )) == (CATIMPUES *)NULL)
        {
            return  (FALSE);
        }
    }
    else
    {
        vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Categorias de impuestos ...", LOG01);
    }

    *iCodCategoria=elementoPtr->iCodCategoria;
    strcpy(elementoPtr->szFlagImpto,"S");           

    return (TRUE);
}

int ifnCmpCodImptos (const void *cad1,const void *cad2)
{
    if  ( ((CATIMPUES *)cad1)->iCodConcepto < ((CATIMPUES *)cad2)->iCodConcepto ) return -1;
    else if ( ((CATIMPUES  *)cad1)->iCodConcepto > ((CATIMPUES  *)cad2)->iCodConcepto ) return 1;
    else if ( ((CATIMPUES  *)cad1)->dPrcImpuesto < ((CATIMPUES  *)cad2)->dPrcImpuesto ) return -1;
    else if ( ((CATIMPUES  *)cad1)->dPrcImpuesto > ((CATIMPUES  *)cad2)->dPrcImpuesto ) return 1;
        return 0;

}

BOOL bfnPorcenImptosCateg(double *pdTotalPorcenPrimeraCateg, double *pdTotalPorcenSegundaCateg )
{
     int i;
     double dPorcenPrimeraCategoria=0.0; 
     double dPorcenSegundaCategoria=0.0; 

    strcpy (szModulo, "bfnPorcenImptosCateg");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);
    for (i=0; i < pstCatImpues.iNumRegs; i++ )
    {
        if(strcmp(pstCatImpues.stCatImpuesto[i].szFlagImpto,"S")==0)
        {
            if (pstCatImpues.stCatImpuesto[i].iCodCategoria == iGPrimCateg)
            {
                dPorcenPrimeraCategoria +=pstCatImpues.stCatImpuesto[i].dPrcImpuesto;
            }
            else
            {
                dPorcenSegundaCategoria +=pstCatImpues.stCatImpuesto[i].dPrcImpuesto;
            }
            strcpy(pstCatImpues.stCatImpuesto[i].szFlagImpto," ");
        }
    }
    *pdTotalPorcenPrimeraCateg=dPorcenPrimeraCategoria;
    *pdTotalPorcenSegundaCateg=dPorcenSegundaCategoria;
    return(TRUE);
}

BOOL bfnTipoImpuesto(int iCodConcepto, int *iCodTipoImpuesto,double dPrcImpto)
{

    CATIMPUES  stkey;
    CATIMPUES *elementoPtr = (CATIMPUES *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Tipo Impuesto \n\t Cod. Concepto [%d]", LOG05,iCodConcepto);
    stkey.iCodConcepto=iCodConcepto;
    stkey.dPrcImpuesto=dPrcImpto;

    if (pstCatImpues.iNumRegs > 0)
    {
        if ( (elementoPtr = (CATIMPUES *)bsearch (&stkey, pstCatImpues.stCatImpuesto , pstCatImpues.iNumRegs,sizeof (CATIMPUES),ifnCmpCodImptos )) == (CATIMPUES *)NULL)
        {
            return  (FALSE);
        }
    }
    else
    {
        vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Tipos de impuestos ...", LOG01);
    }


    *iCodTipoImpuesto=elementoPtr->iCodTipImpto;

    return (TRUE);
}

BOOL bfnBuscaCategImpto(int iCodConcepto, int *iCodCategoria, double dPrcImpto)
{

    CATIMPUES  stkey;
    CATIMPUES *elementoPtr = (CATIMPUES *)NULL;

    vDTrazasLog (szExeName, "Funcion bfnBuscaCategImpto * Busca Categoria del Impuesto \n\t Cod. Concepto [%d]"
                          , LOG05,iCodConcepto);
    stkey.iCodConcepto=iCodConcepto;
    stkey.dPrcImpuesto=dPrcImpto;

    if (pstCatImpues.iNumRegs > 0)
    {
        if ( (elementoPtr = (CATIMPUES *)bsearch (&stkey, pstCatImpues.stCatImpuesto , pstCatImpues.iNumRegs,
            sizeof (CATIMPUES),ifnCmpCodImptos )) == (CATIMPUES *)NULL)
        {
            vDTrazasLog ("bfnBuscaCategImpto", "No encuentra categoria para  [%d]", LOG05,iCodConcepto);
            return  (FALSE);
        }
    }
    else
    {
        vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Categ. de impuestos ...", LOG01);
    }


    *iCodCategoria=elementoPtr->iCodCategoria;
    return (TRUE);
}

int ifnGetNum_Terminales(int *Num_Terminales)
{
    int Numero_Reg;
    register int i;
    int NTerminales;
    long lNumAboAnte= 0L;

   NTerminales = 0;
   Numero_Reg = stFaDetCons.iNumReg;
   for (i=0;i<Numero_Reg;i++)
   {
        if ( stFaDetCons.stDetConsumo[i].lNumAbonado > 0 && 
             stFaDetCons.stDetConsumo[i].iCodConcepto == iCodAbonoCel && 
             stFaDetCons.stDetConsumo[i].lNumAbonado  != lNumAboAnte )
     {
        lNumAboAnte = stFaDetCons.stDetConsumo[i].lNumAbonado ;
        NTerminales++;
     }
   }
   *Num_Terminales = NTerminales;
   vDTrazasLog ("ifnGetNum_Terminales", "Numero de terminales [%i]", LOG05,*Num_Terminales);
   return(TRUE);
}

BOOL bfnLimpiaFlag(CATIMPUESTOS *st_catImpuestos)
{
   int i;
   for (i=0; i < st_catImpuestos->iNumRegs; i++ )
    {
     strcpy(st_catImpuestos->stCatImpuesto[i].szFlagImpto," ");
    }
    return(TRUE);
}

BOOL bfnCargaUltsPagos (PAGO **pstPago, int *iNumRegs, long lCodCliente, long lCodCicloFact)
{
    int         rc = 0;
    int         iNumFilas;
    PAGO_HOSTS  stPagoHost;
    PAGO        *pstPagoTemp;
    int         iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Pagos ", LOG06);

    *iNumRegs = 0;
    *pstPago = (PAGO *)NULL;

    if (ifnOpenPagos(lCodCliente, lCodCicloFact))
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchPagos(&stPagoHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstPago =(PAGO*) realloc(*pstPago,(int)(((*iNumRegs)+iNumFilas)*sizeof(PAGO)));

        if (!*pstPago)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaUltsPagos", "no se pudo reservar memoria");
            return FALSE;
        }

        pstPagoTemp = &(*pstPago)[(*iNumRegs)];
        memset(pstPagoTemp, 0, (int)(sizeof(PAGO)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            pstPagoTemp[iCont].dMonto       = stPagoHost.dMonto[iCont];
            strcpy( pstPagoTemp[iCont].szFecha     , stPagoHost.szFecha[iCont]);
            strcpy( pstPagoTemp[iCont].szDecrip    , stPagoHost.szDecrip[iCont]);
            strcpy( pstPagoTemp[iCont].szModPago, stPagoHost.szModPago[iCont]);
            pstPagoTemp[iCont].lTipPago    =  stPagoHost.lTipPago[iCont];        
            strcpy( pstPagoTemp[iCont].szCodOperadora,  stPagoHost.szCodOperadora[iCont]); 
            pstPagoTemp[iCont].lCodTipDocum = stPagoHost.lCodTipDocum[iCont];              
        }
        (*iNumRegs) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* Pagos del cliente cargados [%ld]", LOG06, *iNumRegs);

    rc = ifnClosePagos();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaCodClientes", szfnORAerror ());
        return FALSE;
    }

    vfnPrintPagos (*pstPago, *iNumRegs);

    return (TRUE);
}
/***************************** Final bfnCargaUltsPagos *********************/

static int ifnOpenPagos(long lCodCliente, long lCodCicloFact)
{
    lhCodCliente   = lCodCliente;
    lhCodCilclFact = lCodCicloFact;

    vDTrazasLog (szExeName,"\n\t\t* Open=> CO_ULTPAGO_TT", LOG06);

    /* EXEC SQL OPEN curPagos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2482;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCilclFact;
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



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> CO_ULTPAGO_TT",szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenPagos **********************/

static BOOL bfnFetchPagos (PAGO_HOSTS *pstHost,int *piNumFilas)
{

    /* EXEC SQL FETCH curPagos
              INTO  :pstHost->dMonto     ,
                    :pstHost->szFecha    ,
                    :pstHost->szDecrip   ,
                    :pstHost->szModPago  ,
                    :pstHost->lTipPago       ,
                    :pstHost->szCodOperadora ,
                    :pstHost->lCodTipDocum    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2505;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->dMonto);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )sizeof(double);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szFecha);
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )9;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szDecrip);
    sqlstm.sqhstl[2] = (unsigned long )41;
    sqlstm.sqhsts[2] = (         int  )41;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szModPago);
    sqlstm.sqhstl[3] = (unsigned long )21;
    sqlstm.sqhsts[3] = (         int  )21;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->lTipPago);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )sizeof(long);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szCodOperadora);
    sqlstm.sqhstl[5] = (unsigned long )6;
    sqlstm.sqhsts[5] = (         int  )6;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->lCodTipDocum);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )sizeof(long);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> CO_ULTPAGO_TT", szfnORAerror ());
    return SQLCODE;
}
/***************************** Final bfnFetchPagos ****************/

static int ifnClosePagos(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> CO_ULTPAGO_TT", LOG06);

    /* EXEC SQL CLOSE curPagos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2548;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> CO_ULTPAGO_TT",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnClosePagos **********************/

void vfnPrintPagos (PAGO *pstPago, int iNumRegs)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Pagos [%d]", LOG06, iNumRegs);

        for (i=0;i<iNumRegs;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Monto Pago          [%f]"
                                    "\n\t\t=> [%d]: Fecha Pago          [%s]"
                                    "\n\t\t=> [%d]: Descripcion         [%s]"
                                    "\n\t\t=> [%d]: Cod. Modalidad Pago [%s]"
                                    "\n\t\t=> [%d]: Tipo de Pago        [%ld]"
                                    ,LOG06
                                    ,i, pstPago[i].dMonto
                                    ,i, pstPago[i].szFecha
                                    ,i, pstPago[i].szDecrip
                                    ,i, pstPago[i].szModPago
                                    ,i, pstPago[i].lTipPago  );
        }
    }
}
/*************************** vfnPrintPagos *****************************/

/** P-MIX-09003 77 **/
/***********************************************************************/
/* FUNCION : bfnCargaTipoImpuestos                                     */
/***********************************************************************/
BOOL bfnCargaTiposImpuestos (TIPOIMPUESTO **pstTipoImpuesto, int *iNumRegs)
{
    int                  rc = 0;
    int                  iNumFilas;
    TIPOSIMPUESTOS_HOSTS stTipoImpuestoHost;
    TIPOIMPUESTO        *pstTipoImpuestoTemp;
    int  iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Tipos Impuestos ", LOG06);

    *iNumRegs = 0;
    *pstTipoImpuesto = (TIPOIMPUESTO *)NULL;

    if (ifnOpenTiposImpuestos())
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchTiposImpuestos(&stTipoImpuestoHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstTipoImpuesto =(TIPOIMPUESTO*) realloc(*pstTipoImpuesto,((*iNumRegs)+iNumFilas)*sizeof(TIPOIMPUESTO));

        if (!*pstTipoImpuesto)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaTiposImpuestos", "no se pudo reservar memoria");
            return FALSE;
        }

        pstTipoImpuestoTemp = &(*pstTipoImpuesto)[(*iNumRegs)];
        memset(pstTipoImpuestoTemp, 0, (int)(sizeof(TIPOIMPUESTO)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy( pstTipoImpuestoTemp[iCont].szDesTipImpue, alltrim(stTipoImpuestoHost.szDesTipImpue[iCont]));

            pstTipoImpuestoTemp[iCont].iCodTipImpue       = stTipoImpuestoHost.iCodTipImpue[iCont];

        }
        (*iNumRegs) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* Tipos Impuestos  [%d]", LOG06, *iNumRegs);

    rc = ifnCloseTiposImpuestos();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaTiposImpuestos", szfnORAerror ());
        return FALSE;
    }

    if (*iNumRegs >0)
    {
        qsort((void*)*pstTipoImpuesto, *iNumRegs, sizeof(TIPOIMPUESTO),ifnCmpTiposImpuestos);
        vfnPrintTiposImpuestos (*pstTipoImpuesto, *iNumRegs);
    }

    return (TRUE);
}
/***************************** Final bfnCargaTiposImpuestos *********************/

/********************************************************************************/
/* FUNCION: ifnOpenTiposImpuestos                                               */
/********************************************************************************/
int ifnOpenTiposImpuestos( void )
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> GE_TIPIMPUES", LOG06);

    /* EXEC SQL DECLARE cCurTiposImpuestos CURSOR FOR
         SELECT COD_TIPIMPUE, DES_TIPIMPUE 
         FROM GE_TIPIMPUES
         ORDER BY COD_TIPIMPUE ASC; */ 


    /* EXEC SQL OPEN cCurTiposImpuestos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0058;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2563;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> GE_TIPIMPUES",szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenTiposImpuestos **********************/

/********************************************************************************/
/* FUNCION : bfnFetchTiposImpuestos                                             */
/********************************************************************************/
BOOL bfnFetchTiposImpuestos(TIPOSIMPUESTOS_HOSTS *pstHost,int *piNumFilas)
{

    /* EXEC SQL FETCH cCurTiposImpuestos
              INTO  :pstHost->iCodTipImpue,                   
                    :pstHost->szDesTipImpue; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2578;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodTipImpue);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesTipImpue);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> GE_TIPIMPUES", szfnORAerror ());
    return SQLCODE;
}
/***************************** Final bfnFetchTiposImpuestos ****************/

void vfnPrintTiposImpuestos (TIPOIMPUESTO *pstTipoImpuesto, int iNumRegs)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tipos Impuestos [%d]", LOG06, iNumRegs);

        for (i=0;i<iNumRegs;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Cod TipImpue    [%d]"
                                    "\n\t\t=> [%d]: Descripcion     [%s]"
                                    ,LOG06
                                    ,i, pstTipoImpuesto[i].iCodTipImpue
                                    ,i, pstTipoImpuesto[i].szDesTipImpue );
        }
    }
}
/*************************** vfnPrintTiposImpuestos *****************************/

/********************************************************************************/
/* FUNCION : ifnCmpTiposImpuestos */
/********************************************************************************/
int ifnCmpTiposImpuestos(const void *cad1,const void *cad2)
{
    int rc = 0;

    return
        ( (rc = ((TIPOIMPUESTO *)cad1)->iCodTipImpue-
                ((TIPOIMPUESTO *)cad2)->iCodTipImpue) != 0)?rc:0;

}
/*************************** ifnCmpTiposImpuestos *****************************/

int ifnCloseTiposImpuestos(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Close => GE_TIPIMPUES", LOG06);

    /* EXEC SQL CLOSE cCurTiposImpuestos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2601;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> cCurTiposImpuestos",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnCloseTiposImpuestos **********************/

/*********************************************************************************/
/* FUNCION : bfnSumarImpuestos */
/*********************************************************************************/
BOOL bfnSumarImpuestos (int    iCodTipoImpuesto,
                        long   lIndOrdenTotal,
                        long   lCodCiclFact,
                        double *dTotalImpuesto)
{
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int  ihCodTipoImpuesto;
         long lhIndOrdenTotal;
         long lhCodCiclFact;
         double dhTotalImpuesto = 0.0;
    /* EXEC SQL END DECLARE SECTION; */ 

    	
    char szTablaConc [40]    ="";
    char szQry       [1000]  ="";
    
    ihCodTipoImpuesto = iCodTipoImpuesto;
    lhIndOrdenTotal   = lIndOrdenTotal;
    lhCodCiclFact     = lCodCiclFact;
    
    strcpy (szModulo, "bfnSumarImpuestos");
    vDTrazasLog(szModulo, "\t\t**Entrando a %s "
                          "\n\t========================="
                          "\n\t=> Tipo Impuesto   [%d]"
                          "\n\t=> Ind.Ordentotal  [%ld]"
                          "\n\t=> Cod. Ciclo Fact [%ld]"
                        , LOG06
                        , szModulo
                        , ihCodTipoImpuesto
                        , lhIndOrdenTotal
                        , lhCodCiclFact);

    if ( !lhCodCiclFact ) {
        sprintf(szTablaConc,"FA_FACTCONC_NOCICLO");  }
    else {
        sprintf(szTablaConc,"FA_FACTCONC_%ld",lhCodCiclFact); }	
	
    sprintf(szQry, "\n SELECT NVL(SUM(C.IMP_FACTURABLE),0)"
                   "\n FROM %s C, "
                   "\n     (SELECT  distinct (A.COD_CONCGENE), A.COD_TIPIMPUES "
                   "\n      FROM GE_IMPUESTOS A, GE_TIPIMPUES B "
                   "\n      WHERE A.COD_TIPIMPUES = B.COD_TIPIMPUE "
                   "\n      ORDER BY A.COD_CONCGENE ASC) D "
                   "\n WHERE C.COD_CONCEPTO = D.COD_CONCGENE "
                   "\n AND   C.IND_ORDENTOTAL = :lhIndOrdenTotal "
                   "\n AND   D.COD_TIPIMPUES =  :ihCodTipoImpuesto"         
                 , szTablaConc);

    vDTrazasLog(szModulo,"\t\tQRY:[ %s ]",LOG06,szQry);

    /* EXEC SQL PREPARE sql_Cur_TipImpuesto FROM :szQry; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2616;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szQry;
    sqlstm.sqhstl[0] = (unsigned long )1000;
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-PREPARE sql_Abonados_DetLlam **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-PREPARE sql_Abonados_DetLlam **"
                                      "\t\tError : [%s] [%d]  [%s] ",LOG01,szQry,SQLCODE,SQLERRM);
    }

    /* EXEC SQL DECLARE curTipImpuesto CURSOR FOR sql_Cur_TipImpuesto; */ 


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\t\tError en SQL-DECLARE curTipImpuesto **"
                        "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\t\tError en SQL-DECLARE curTipImpuesto **"
                        "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }

    /* EXEC SQL OPEN curTipImpuesto USING :lhIndOrdentotal, :ihCodTipoImpuesto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2635;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdentotal;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoImpuesto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t\tError en SQL-OPEN CURSOR curTipImpuesto **"
                               "\n\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t\tError en SQL-OPEN CURSOR curTipImpuesto **"
                               "\n\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }	
    
    /* EXEC SQL FETCH curTipImpuesto INTO :dhTotalImpuesto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2658;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTotalImpuesto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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

   

    if ((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
      vDTrazasError(szModulo,"\t\tError en Fetch curTipImpuesto : %s", LOG01, SQLERRM);
      dhTotalImpuesto = 0;      
    }
    
    *dTotalImpuesto = dhTotalImpuesto;
        
    return (TRUE);
}
/***************************** Fin bfnSumarImpuestos *****************************/
/** P-MIX-09003 77 **/

BOOL bfnCargaMinutosPlanes (MINPLAN **pstMinPlan, int *iNumRegs)
{
    int     rc = 0;
    int     iNumFilas;
    MINPLAN_HOSTS stMinPlanHost;
    MINPLAN     *pstMinPlanTemp;
    int  iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Valor de minutos por plan ", LOG06);

    *iNumRegs = 0;
    *pstMinPlan = (MINPLAN *)NULL;

    if (ifnOpenMinPlanes())
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchMinPlanes(&stMinPlanHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstMinPlan =(MINPLAN*) realloc(*pstMinPlan,((*iNumRegs)+iNumFilas)*sizeof(MINPLAN));

        if (!*pstMinPlan)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaMinutosPlanes", "no se pudo reservar memoria");
            return FALSE;
        }

        pstMinPlanTemp = &(*pstMinPlan)[(*iNumRegs)];
        memset(pstMinPlanTemp, 0, (int)(sizeof(MINPLAN)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy( pstMinPlanTemp[iCont].szCod_Plan       , alltrim(stMinPlanHost.szCod_Plan[iCont]));
            strcpy( pstMinPlanTemp[iCont].szCod_Thor       , alltrim(stMinPlanHost.szCod_Thor[iCont]));
            pstMinPlanTemp[iCont].lSeg_Inic       = stMinPlanHost.lSeg_Inic[iCont];
            pstMinPlanTemp[iCont].lSeg_Adic       = stMinPlanHost.lSeg_Adic[iCont];
            pstMinPlanTemp[iCont].dMto_Inic       = stMinPlanHost.dMto_Inic[iCont];
            pstMinPlanTemp[iCont].dMto_Adic       = stMinPlanHost.dMto_Adic[iCont];
        }
        (*iNumRegs) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* minutos por planes  [%d]", LOG06, *iNumRegs);

    rc = ifnCloseMinPlanes();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaMinutosPlanes", szfnORAerror ());
        return FALSE;
    }

    if (*iNumRegs >0)
    {
        qsort((void*)*pstMinPlan, *iNumRegs, sizeof(MINPLAN),ifnCmpMinPlanes);
        vfnPrintMinPlanes (*pstMinPlan, *iNumRegs);
    }

    return (TRUE);
}
/***************************** Final bfnCargaMinutosPlanes *********************/

int ifnOpenMinPlanes( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        char szhTolCodLlam  [21];
        char szhTolCodTDir  [21];
        char szhTolCodTHor  [21];
        char szhTolCodTHorAlta  [21];
        char szhTolCodTHorBaja  [21];
        char szhTolConCliente[21];
        char szhTolCodOperador[21];
        char szhTolCodTDia  [21];
        char szhTolCodSFran [21];
    /* EXEC SQL END DECLARE SECTION  ; */ 


    vDTrazasLog (szExeName,"\n\t\t* Open=> TOL_AGRULLAM / TOL_ESTCOBRO", LOG06);

    strcpy (szhTolCodLlam       ,alltrim(stGedParametros.szTolCodLlam)    );
    strcpy (szhTolCodTDir       ,alltrim(stGedParametros.szTolCodTDir)    );
    strcpy (szhTolCodTHor       ,alltrim(stGedParametros.szTolCodTHor)    );
    strcpy (szhTolCodTHorAlta   ,alltrim(stGedParametros.szTolCodTHorAlta) );
    strcpy (szhTolCodTHorBaja   ,alltrim(stGedParametros.szTolCodTHorBaja) );
    strcpy (szhTolConCliente    ,alltrim(stGedParametros.szTolConCliente ) );
    strcpy (szhTolCodOperador   ,alltrim(stGedParametros.szTolCodOperador) );
    strcpy (szhTolCodTDia       ,alltrim(stGedParametros.szTolCodTDia    ) );
    strcpy (szhTolCodSFran      ,alltrim(stGedParametros.szTolCodSFran   ) );

    vDTrazasLog (szExeName, "\n\t\t* Open "
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            "\n\t\t\t* => [%s]"
                            , LOG06, szhTolCodLlam, szhTolCodTDir, szhTolCodTHor
                            , szhTolCodTHorAlta, szhTolCodTHorBaja, szhTolConCliente
                            , szhTolCodOperador, szhTolCodOperador, szhTolCodSFran);

    /* EXEC SQL DECLARE cCurMinPlan CURSOR FOR
        SELECT B.COD_PLAN, A.COD_THOR, B.SEG_INIC, B.SEG_ADIC, B.MTO_MIN, B.MTO_ADIC
          FROM TOL_AGRULLAM A, TOL_ESTCOBRO B
         WHERE A.COD_SENTIDO = 'S'
           AND A.COD_LLAM = :szhTolCodLlam
           AND A.COD_TDIR = :szhTolCodTDir
           AND A.COD_THOR IN (:szhTolCodTHor, :szhTolCodTHorAlta, :szhTolCodTHorBaja)
           AND A.CON_CLIENTE = :szhTolConCliente
           AND A.FEC_INI_VIG <= SYSDATE
           AND A.FEC_TER_VIG >= SYSDATE
           AND B.COD_OPERADOR = :szhTolCodOperador
           AND B.COD_PLAN <> ' '
           AND B.COD_AGRULLAM = A.COD_AGRULLAM
           AND B.COD_TDIA = :szhTolCodTDia
           AND B.COD_SFRAN = :szhTolCodSFran
           AND B.FEC_INI_VIG <= SYSDATE
           AND B.FEC_TER_VIG >= SYSDATE; */ 



    /* EXEC SQL OPEN cCurMinPlan; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0060;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2677;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhTolCodLlam;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhTolCodTDir;
    sqlstm.sqhstl[1] = (unsigned long )21;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhTolCodTHor;
    sqlstm.sqhstl[2] = (unsigned long )21;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhTolCodTHorAlta;
    sqlstm.sqhstl[3] = (unsigned long )21;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhTolCodTHorBaja;
    sqlstm.sqhstl[4] = (unsigned long )21;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhTolConCliente;
    sqlstm.sqhstl[5] = (unsigned long )21;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhTolCodOperador;
    sqlstm.sqhstl[6] = (unsigned long )21;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhTolCodTDia;
    sqlstm.sqhstl[7] = (unsigned long )21;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhTolCodSFran;
    sqlstm.sqhstl[8] = (unsigned long )21;
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



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> TOL_AGRULLAM/ TOL_ESTCOBRO",szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenMinPlanes **********************/

BOOL bfnFetchMinPlanes(MINPLAN_HOSTS *pstHost,int *piNumFilas)
{

    /* EXEC SQL FETCH cCurMinPlan
              INTO  :pstHost->szCod_Plan,
                    :pstHost->szCod_Thor,
                    :pstHost->lSeg_Inic ,
                    :pstHost->lSeg_Adic ,
                    :pstHost->dMto_Inic ,
                    :pstHost->dMto_Adic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2728;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCod_Plan);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCod_Thor);
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )6;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lSeg_Inic);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->lSeg_Adic);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )sizeof(long);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->dMto_Inic);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )sizeof(double);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->dMto_Adic);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )sizeof(double);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> TOL_AGRULLAM / TOL_ESTCOBRO", szfnORAerror ());
    return SQLCODE;
}
/***************************** Final bfnFetchMinPlanes ****************/

int ifnCloseMinPlanes(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Close => TOL_AGRULLAM / TOL_ESTCOBRO", LOG06);

    /* EXEC SQL CLOSE cCurMinPlan; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2767;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> TOL_AGRULLAM / TOL_ESTCOBRO",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnCloseMinPlanes **********************/

void vfnPrintMinPlanes (MINPLAN *pstMinPlan, int iNumRegs)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Minutos Planes [%d]", LOG06, iNumRegs);

        for (i=0;i<iNumRegs;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Cod Plan    [%s]"
                                    "\n\t\t=> [%d]: Cod THor    [%s]"
                                    "\n\t\t=> [%d]: Seg Inic    [%ld]"
                                    "\n\t\t=> [%d]: Seg Adic    [%ld]"
                                    "\n\t\t=> [%d]: Mto Inic    [%f]"
                                    "\n\t\t=> [%d]: Mto Adic    [%f]"
                                    ,LOG06
                                    ,i, pstMinPlan[i].szCod_Plan
                                    ,i, pstMinPlan[i].szCod_Thor
                                    ,i, pstMinPlan[i].lSeg_Inic
                                    ,i, pstMinPlan[i].lSeg_Adic
                                    ,i, pstMinPlan[i].dMto_Inic
                                    ,i, pstMinPlan[i].dMto_Adic );
        }
    }
}
/*************************** vfnPrintMinPlanes *****************************/

int ifnCmpMinPlanes(const void *cad1,const void *cad2)
{
    int rc;
    return ( (rc = strcmp  (((MINPLAN *)cad1)->szCod_Plan,
                            ((MINPLAN *)cad2)->szCod_Plan)) != 0)?rc:
           ( (rc = strcmp  (((MINPLAN *)cad1)->szCod_Thor,
                            ((MINPLAN *)cad2)->szCod_Thor)) != 0)?rc:0;
}
/*************************** ifnCmpCod_PlanTarif *****************************/

BOOL bfnFindMinPlan (char *szCodPlanTarif, char *szCodThor, MINPLAN *pstMinPlan)
{
    MINPLAN  stkey;
    MINPLAN  *pstAux = (MINPLAN *)NULL;

    strcpy (szModulo, "bfnFindMinPlan");

    vDTrazasLog (szModulo, "\n\t\t* Busca Minutos de Plan Tarifario "
                           "\n\t\t=> Cod. Plan Tarifario [%s]"
                           "\n\t\t=> Cod. T Hor          [%s]"
                           , LOG05,szCodPlanTarif
                           , szCodThor);

    strcpy(stkey.szCod_Plan, szCodPlanTarif);
    strcpy(stkey.szCod_Thor, szCodThor);

    if (stMinutosPlanes.iNumRegs > 0)
    {
        if ( (pstAux = (MINPLAN *)bsearch (&stkey, stMinutosPlanes.stMinPlan , stMinutosPlanes.iNumRegs,
            sizeof (MINPLAN), ifnCmpMinPlanes ))== (MINPLAN *)NULL)
        {

            vDTrazasLog(szModulo, "Codigo de Plan Tarifario [%s] no encontrado ...", LOG01, szCodPlanTarif);
            return  (FALSE);
        }
        memcpy (pstMinPlan, pstAux, sizeof(MINPLAN));
    }
    else
    {
        vDTrazasLog(szModulo, "No existen datos para buscar en estructura de Minutos Planes ...", LOG01);
    }

    return (TRUE);
}

BOOL bfnCargaPrimCateg (void)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int     ihCodCateg =0 ;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "bfnCargaPrimCateg");

    /* EXEC SQL
        SELECT MIN(COD_CATEIMP)
          INTO :ihCodCateg
          FROM GE_TIPIMPUES; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select min(COD_CATEIMP) into :b0  from GE_TIPIMPUES ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2782;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCateg;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode == SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "Error en SELECT de bfnCargaPrimCateg [%d]", LOG02, sqlca.sqlcode);
        return (FALSE);
    }

    iGPrimCateg=ihCodCateg;
    vDTrazasLog(szModulo, "Primera Categoria [%d]", LOG05, iGPrimCateg);

    return (TRUE);

}
/************************************ Final bfnChequeaProcesosPrevios **********************************************/

int ifnCmpOperadores(const void *cad1,const void *cad2)
{
    int rc = 0;

    return
        ( (rc = ((CODOPER *)cad1)->iCodOperador-
                ((CODOPER *)cad2)->iCodOperador) != 0)?rc:0;

}

BOOL bfnCargaOperadores (CODOPER **pstOper, int *iNumOperadores)
{
    int     rc = 0;
    int     iNumFilas;
    CODOPER_HOSTS stOperHost;
    CODOPER *pstOperTemp;
    int     iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Operadores ", LOG06);

    *iNumOperadores = 0;
    *pstOper = NULL;

    if (ifnOpenOperadores())
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchOperadores(&stOperHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstOper =(CODOPER*) realloc(*pstOper,(int)(((*iNumOperadores)+iNumFilas)*sizeof(CODOPER)));

        if (!*pstOper)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaOperadores", "no se pudo reservar memoria");
            return FALSE;
        }

        pstOperTemp = &(*pstOper)[(*iNumOperadores)];
        memset(pstOperTemp, 0, (int)(sizeof(CODOPER)*iNumFilas));
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            pstOperTemp[iCont].iCodOperador       = stOperHost.iCodOperador[iCont];
            strcpy( pstOperTemp[iCont].szDesOperador    ,stOperHost.szDesOperador[iCont]);
        }
        (*iNumOperadores) += iNumFilas;

    }

    vDTrazasLog (szExeName,"\n\t\t* Codigos de Operadores cargados [%d]", LOG06, *iNumOperadores);

    rc = ifnCloseOperadores();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaOperadores", szfnORAerror ());
        return FALSE;
    }

    qsort((void*)*pstOper, *iNumOperadores, sizeof(CODOPER),ifnCmpOperadores);

    vDTrazasLog (szExeName,"\n\t\t* (bfnCargaOperadores) Saliendo de la funcion...", LOG06);

    return (TRUE);
}
/***************************** Final bfnCargaOperadores *********************/

int ifnOpenOperadores(void)
{
    vDTrazasLog (szExeName,"\n\t\t* En la funcion ifnOpenOperadores", LOG06);

    /* EXEC SQL DECLARE Cur_Operadores CURSOR for
        SELECT COD_OPERADOR, DES_OPERADOR
        FROM  TA_OPERADORES; */ 


    /* EXEC SQL OPEN Cur_Operadores; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0062;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2801;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> TA_OPERADORES",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenOperadores **********************/

BOOL bfnFetchOperadores (CODOPER_HOSTS *pstHost,int *piNumFilas)
{
    vDTrazasLog (szExeName,"\n\t\t* En la funcion bfnFetchOperadores", LOG06);

    /* EXEC SQL FETCH Cur_Operadores
              INTO :pstHost->iCodOperador ,
                   :pstHost->szDesOperador; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2816;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodOperador);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesOperador);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> TA_OPERADORES", szfnORAerror ());
    return SQLCODE;
}
/***************************** Final bfnFetchOperadores ****************/

int ifnCloseOperadores(void)
{
    vDTrazasLog (szExeName,"\n\t\t* En la funcion ifnCloseOperadores", LOG06);

    /* EXEC SQL CLOSE Cur_Operadores; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2839;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> TA_OPERADORES",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnCloseCodClientes **********************/

void vfnPrintOperadores (CODOPER *pstCodOper, int iNumFilas)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Operadores [%d]", LOG06, iNumFilas);

        for (i=0;i<iNumFilas;i++)
        {
             vDTrazasLog (szExeName,"\t\t=> [%d]: Cod. Operador [%d] Desc. Operador [%s]"
                                    ,LOG06, i, pstCodOper[i].iCodOperador, pstCodOper[i].szDesOperador);
        }

    }
}
/*************************** vfnPrintOperadores *****************************/

BOOL bfnFindCod_Operador (int iCodOperador, CODOPER *pstOper)
{
    CODOPER  stkey;
    CODOPER  *pstAux = (CODOPER *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Operador "
                            "\n\t\t=> Cod. Operador   [%d]"
                            , LOG05,iCodOperador );

    stkey.iCodOperador = iCodOperador;

    vDTrazasLog (szExeName, "\n\t\t* Cantidad de Operadores [%d]",LOG05,stOperadores.iNumRegs);

    if (stOperadores.iNumRegs > 0)
    {
        if ( (pstAux = (CODOPER *)bsearch (&stkey, stOperadores.stOper , stOperadores.iNumRegs,
            sizeof (CODOPER),ifnCmpOperadores ))== (CODOPER *)NULL)
        {

            vDTrazasLog(szExeName, "Codigo Operador [%d] no encontrado ...", LOG01, iCodOperador);
            return  (FALSE);
        }
        memcpy (pstOper, pstAux, sizeof(CODOPER));
    }
    else
    {
        vDTrazasLog(szExeName, "No existen datos para buscar en estructura de Operadores...", LOG01);
    }

    return (TRUE);
}

BOOL bfnCargarDocsPeriodo ( DOCPERIODO **pstDocPeriodo, 
                            int        *iNumRegs, 
                            long       lCodCliente, 
                            char       *pszFecDesde, 
                            char       *pszFecHasta)
{
    int    rc = 0;
    int    iNumFilas = 0;
    DOCPERIODO_HOSTS stDocPeriodoHost;
    DOCPERIODO      *pstDocPeriodoTemp;
    int    iCont = 0;

    vDTrazasLog (szExeName,"\n\t* Carga Pagos ", LOG06);

    memset (&stDocPeriodoHost, 0 ,sizeof(DOCPERIODO_HOSTS));

    *iNumRegs = 0;
    *pstDocPeriodo = NULL;

    if (ifnOpenDocsPeriodo(lCodCliente,pszFecDesde,pszFecHasta))
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchDocsPeriodo(&stDocPeriodoHost,&iNumFilas);

        if (rc != SQLOK  && rc != SQLNOTFOUND)
            return FALSE;

        if (!iNumFilas)
            break;

        vDTrazasLog (szExeName,"\n\t\t* 60894 - CONTINUA iNumFilas[%d]", LOG03,iNumFilas);


        *pstDocPeriodo =(DOCPERIODO*) realloc(*pstDocPeriodo,(((*iNumRegs)+iNumFilas)*sizeof(DOCPERIODO)));

        if (!*pstDocPeriodo)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargarDocsPeriodo()", "no se pudo reservar memoria");
            return FALSE;
        }

        pstDocPeriodoTemp = &(*pstDocPeriodo)[(*iNumRegs)];

        memset(pstDocPeriodoTemp, 0, (int)(sizeof(DOCPERIODO)*iNumFilas));

        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            pstDocPeriodoTemp[iCont].iCodTipDocum = stDocPeriodoHost.iCodTipDocum[iCont];
            pstDocPeriodoTemp[iCont].lNumFolio    = stDocPeriodoHost.lNumFolio[iCont];
            pstDocPeriodoTemp[iCont].dTotFactura  = stDocPeriodoHost.dTotFactura[iCont];

            strcpy( pstDocPeriodoTemp[iCont].szCodOperadora  , stDocPeriodoHost.szCodOperadora[iCont]);
            strcpy( pstDocPeriodoTemp[iCont].szCodOficina    , stDocPeriodoHost.szCodOficina[iCont]);
            strcpy( pstDocPeriodoTemp[iCont].szDesTipDocum   , stDocPeriodoHost.szDesTipDocum[iCont]);
            strcpy( pstDocPeriodoTemp[iCont].szPrefPlaza     , stDocPeriodoHost.szPrefPlaza[iCont]);
            strcpy( pstDocPeriodoTemp[iCont].szFecEmision    , stDocPeriodoHost.szFecEmision[iCont]);
        }
        vDTrazasLog (szExeName,"\n\t\t* 60894 - 2.- iCont: [%d]", LOG03, iCont);
        (*iNumRegs) += iNumFilas;
        vDTrazasLog (szExeName,"\n\t\t* 60894 - 2.- iNumFilas: [%d]"
                               "\n\t\t* 60894 - *iNumRegs: [%d]"
                               , LOG03, iNumFilas, *iNumRegs);

    }

    vDTrazasLog (szExeName,"\n\t\t* Documentos del periodo cargados: [%d]", LOG05, *iNumRegs);

    rc = ifnCloseDocsPeriodo();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargarDocsPeriodo", szfnORAerror ());
        return FALSE;
    }

    return (TRUE);
}
/***************************** Final bfnCargarDocsPeriodo *********************/

int ifnOpenDocsPeriodo(long lCodCliente, char *pszFecDesde, char *pszFecHasta)
{
    lhCodCliente = lCodCliente;
    strcpy(szhFecDesde,pszFecDesde);
    strcpy(szhFecHasta,pszFecHasta);

    vDTrazasLog (szExeName,"\n\t\t* Open=> FA_HISTDOCU, GE_TIPDOCUMEN", LOG06);

    /* EXEC SQL OPEN curDocsPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2854;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
    sqlstm.sqhstl[1] = (unsigned long )10;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
    sqlstm.sqhstl[2] = (unsigned long )10;
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



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> FA_HISTDOCU, GE_TIPDOCUMEN",szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnOpenPagos **********************/

BOOL bfnFetchDocsPeriodo(DOCPERIODO_HOSTS *pstHost,int *piNumFilas)
{

    /* EXEC SQL FETCH curDocsPeriodo
        INTO  :pstHost->szCodOperadora  ,
              :pstHost->szCodOficina    ,
              :pstHost->iCodTipDocum    ,
              :pstHost->szDesTipDocum   ,
              :pstHost->szPrefPlaza     ,
              :pstHost->lNumFolio       ,
              :pstHost->szFecEmision    ,
              :pstHost->dTotFactura    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )2881;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodOperadora);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCodOficina);
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )3;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->iCodTipDocum);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szDesTipDocum);
    sqlstm.sqhstl[3] = (unsigned long )41;
    sqlstm.sqhsts[3] = (         int  )41;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szPrefPlaza);
    sqlstm.sqhstl[4] = (unsigned long )26;
    sqlstm.sqhsts[4] = (         int  )26;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->lNumFolio);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )sizeof(long);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szFecEmision);
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )11;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->dTotFactura);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE == SQLOK){
        *piNumFilas = TAM_HOSTS_PEQ;
      }
    else{
        if (SQLCODE == SQLNOTFOUND){
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
            vDTrazasLog (szExeName,"\n\t\t* 60894 - bfnFetchDocsPeriodo / sqlca.sqlerrd[2][%d]", LOG03,sqlca.sqlerrd[2]);
          }
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> FA_HISTDOCU, GE_TIPDOCUMEN", szfnORAerror ());
        }

    vDTrazasLog (szExeName,"\n\t\t* 60894 - bfnFetchDocsPeriodo / piNumFilas[%d]", LOG03,*piNumFilas);

    return SQLCODE;
}
/***************************** Final bfnFetchPagos ****************/

int ifnCloseDocsPeriodo(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Close=> FA_HISTDOCU, GE_TIPDOCUMEN", LOG06);

    /* EXEC SQL CLOSE curDocsPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2928;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> FA_HISTDOCU, GE_TIPDOCUMEN",
                 szfnORAerror ());

    return SQLCODE;
}
/***************************** Final ifnClosePagos **********************/

BOOL bfnCargarTipoDirLlamada(void)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhCodTdir [11];  /* EXEC SQL VAR szhCodTdir IS STRING(11); */ 

    /* EXEC SQL END   DECLARE SECTION; */ 



    /* EXEC SQL
        SELECT A.COD_TOPE || A.COD_TOPE
        INTO
            :szhCodTdir
        FROM TA_OPERADORES A,
             TOL_PAISOPERADORA B
        WHERE A.COD_OPERADOR = B.COD_OPERADOR; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select (A.COD_TOPE||A.COD_TOPE) into :b0  from TA_OPERADO\
RES A ,TOL_PAISOPERADORA B where A.COD_OPERADOR=B.COD_OPERADOR";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2943;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodTdir;
    sqlstm.sqhstl[0] = (unsigned long )11;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog ("bfnCargarTipoDirLlamada","\n\t\t* En sentenia SELECT, Codigo: [%d]", LOG01,sqlca.sqlcode);
        return FALSE;
    }
    alltrim(szhCodTdir);
    strcpy(gszCodTdir,szhCodTdir);

    return TRUE;
}

void vfnCargarDesOperador(int iCodOperador, char *pszCodTdir, char *pszDesOperador)
{

    CODOPER stOper;

    memset(&stOper,'\0',sizeof(CODOPER));
    alltrim(pszCodTdir);

    if(!strcmp(pszCodTdir,gszCodTdir))
    {
        if(!bfnFindCod_Operador(iCodOperador,&stOper))
        {
            vDTrazasLog ("vfnCargarDesOperador","\n\t\t* No se Encuentra Codigo de Operador", LOG01);
            return;
        }
        else
        {
            vDTrazasLog ("vfnCargarDesOperador","\n\t\t* Codigo de Operador Encontrado."
                                                "\n\t\t* stOper.szDesOperador: [%s].", LOG06,stOper.szDesOperador);
            strcpy(pszDesOperador,"");
            strcpy(pszDesOperador, stOper.szDesOperador);
        }
    }
    else
        vDTrazasLog ("vfnCargarDesOperador","\n\t\t(vfnCargarDesOperador)* Codigos de Operador distintos.", LOG05);
}

/* FUNCION QUE RESCATA DATOS PARA EL REGISTRO A2600 (VENTAS) */
/*---------------------------------------------------------------------------*/
/* Funcion: ifnLlenarSeriesDeVenta                                            */
/*---------------------------------------------------------------------------*/

int ifnLlenarSeriesDeVenta ( reg_entrada *pstEntrada )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhNum_venta         ;
        long lhCod_cliente       ;
        int  ihTipoVenta         ;
        char szhNumSerie   [25+1]; /* EXEC SQL VAR szhNumSerie    IS STRING(25+1); */ 

        long lhNumAbonado        ;
        long lhCodConcepto       ;
        char szhDesConcepto[60+1]; /* EXEC SQL VAR szhDesConcepto IS STRING(60+1); */ 

        char chString1      [1+1]; /* EXEC SQL VAR chString1      IS STRING (1+1); */ 

        char szFecVenta       [9]; /* EXEC SQL VAR szFecVenta     IS STRING (9); */ 

        char szIndVenta       [2]; /* EXEC SQL VAR szIndVenta     IS STRING (2); */ 

        long lhNumCelular    = 0L;
    /* EXEC SQL END DECLARE SECTION; */ 


    char modulo[]="ifnLlenarSeriesDeVenta";
    stSalida * paux;
    long lContador;

    paux = NULL;
    strcpy(chString1,"I");

    lhNum_venta   = pstEntrada->lNumVenta;
    lhCod_cliente = pstEntrada->lCodCliente;
  
    ihTipoVenta = 0;

    /* EXEC SQL
    SELECT TO_CHAR (FEC_VENTA, 'DDMMYYYY'), IND_VENTA
      INTO :szFecVenta, :szIndVenta
      FROM GA_VENTAS C
     WHERE C.NUM_VENTA   = :lhNum_venta
       AND C.COD_CLIENTE = :lhCod_cliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(FEC_VENTA,'DDMMYYYY') ,IND_VENTA into :b0,\
:b1  from GA_VENTAS C where (C.NUM_VENTA=:b2 and C.COD_CLIENTE=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2962;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szFecVenta;
    sqlstm.sqhstl[0] = (unsigned long )9;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szIndVenta;
    sqlstm.sqhstl[1] = (unsigned long )2;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_venta;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (modulo,"\n\tERROR, al obtener procedencia de la venta. Sqlca.sqlcode [%d]", LOG01,sqlca.sqlcode);
        return FALSE;
    }

    if (strcmp (szIndVenta,"E")==0)
    {
        /* EXEC SQL DECLARE cursorCargosOOSS CURSOR FOR
            SELECT  A.NUM_SERIE,
              A.NUM_ABONADO,
              A.COD_CONCEPTO,
              B.DES_CONCEPTO
            FROM GE_CARGOS A,
                 FA_CONCEPTOS B
           WHERE A.NUM_VENTA = :lhNum_venta
             AND A.COD_CLIENTE = :lhCod_cliente
             AND A.COD_CONCEPTO=B.COD_CONCEPTO; */ 


        /* EXEC SQL OPEN cursorCargosOOSS; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0065;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2993;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_venta;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
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


        lContador = 0;

        while (1)
        {
            /* EXEC SQL
                FETCH cursorCargosOOSS
                 INTO :szhNumSerie,
                      :lhNumAbonado,
                      :lhCodConcepto,
                      :szhDesConcepto; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 53;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3016;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNumSerie;
            sqlstm.sqhstl[0] = (unsigned long )26;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhDesConcepto;
            sqlstm.sqhstl[3] = (unsigned long )61;
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



            if (sqlca.sqlcode == SQLNOTFOUND)
                break;
            else if (sqlca.sqlcode != SQLOK)
            {
                vDTrazasLog (modulo,"\n\tERROR, al leer cursor CARGOS OOSS .Sqlca.sqlcode [%d]", LOG01,sqlca.sqlcode);
                return FALSE;
            }

            paux = (stSalida *) malloc(sizeof(stSalida));
            if(paux == NULL)
            {
                vDTrazasLog (modulo,"\n\nERROR:1:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                vDTrazasError (modulo,"\n\nERROR:1:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                return (FALSE);
            }

            strcpy(paux->szNumSerie,szhNumSerie);
            paux->lNumAbonado = lhNumAbonado;
            paux->iCodConcepto = lhCodConcepto;
            strcpy(paux->szDesConcepto,szhDesConcepto);

            paux->sgte  = lstSalida;
            lstSalida   = paux;
            lContador++;

        }

        /* EXEC SQL CLOSE cursorCargosOOSS; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3047;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {

         /* EXEC SQL
           SELECT COUNT(1)
            INTO :ihTipoVenta
            FROM GA_EQUIPABOSER A
            WHERE A.NUM_ABONADO IN (  SELECT B.NUM_ABONADO
                                        FROM GA_ABOAMIST B
                                       WHERE B.NUM_VENTA   = :lhNum_venta
                                         AND B.COD_CLIENTE = :lhCod_cliente
                                         AND TRUNC(B.FEC_ALTA) IN ( SELECT TRUNC(C.FEC_VENTA)
                                                                      FROM GA_VENTAS C
                                                                     WHERE C.NUM_VENTA   = :lhNum_venta
                                                                       AND C.COD_CLIENTE = :lhCod_cliente))
                AND A.IND_PROCEQUI = :chString1; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 53;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "select count(1) into :b0  from GA_EQUIPABOSER A wher\
e (A.NUM_ABONADO in (select B.NUM_ABONADO  from GA_ABOAMIST B where ((B.NUM_VE\
NTA=:b1 and B.COD_CLIENTE=:b2) and TRUNC(B.FEC_ALTA) in (select TRUNC(C.FEC_VE\
NTA)  from GA_VENTAS C where (C.NUM_VENTA=:b1 and C.COD_CLIENTE=:b2)))) and A.\
IND_PROCEQUI=:b5)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )3062;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&ihTipoVenta;
         sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_venta;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_cliente;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&lhNum_venta;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lhCod_cliente;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)chString1;
         sqlstm.sqhstl[5] = (unsigned long )2;
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



        if (sqlca.sqlcode != SQLOK) {
            vDTrazasLog (modulo,"\n\tERROR, al obtener procedencia de la venta. Sqlca.sqlcode [%d]", LOG01,sqlca.sqlcode);
            return FALSE;
        }

        if (ihTipoVenta > 0)
        {
            vDTrazasLog (modulo,"\n\tProcedencia es prepago KIT...", LOG05);

            /* EXEC SQL DECLARE cursorAbonadoPrePagoKIT CURSOR FOR
                SELECT
                    A.NUM_KIT,
                    D.NUM_ABONADO,
                    B.COD_CONCEPTO,
                    B.DES_CONCEPTO,
                    NVL(A.NUM_TELEFONO,0)
                FROM
                      AL_COMPONENTE_KIT A,
                      FA_CONCEPTOS B,
                      AL_ARTICULOS C,
                      GA_EQUIPABOSER D
                WHERE C.COD_ARTICULO  = A.COD_KIT
                  AND A.NUM_SERIE = D.NUM_SERIE
                  AND D.TIP_TERMINAL IN ( SELECT E.VAL_PARAMETRO
                                          FROM   GED_PARAMETROS E
                                          WHERE  E.NOM_PARAMETRO IN ('TIP_DIGITAL', 'COD_SIMCARD_GSM'))
                  AND D.NUM_ABONADO IN  ( SELECT F.NUM_ABONADO
                                          FROM   GA_ABOAMIST F
                                          WHERE  F.NUM_VENTA       = :lhNum_venta
                                            AND  F.COD_CLIENTE     = :lhCod_cliente
                                            AND  TRUNC(F.FEC_ALTA) IN ( SELECT TRUNC(G.FEC_VENTA)
                                                                        FROM   GA_VENTAS G
                                                                        WHERE  G.NUM_VENTA   = :lhNum_venta
                                                                          AND  G.COD_CLIENTE = :lhCod_cliente))
                    AND C.COD_CONCEPTOART = B.COD_CONCEPTO
                    AND D.IND_PROCEQUI    = :chString1; */ 


            /* EXEC SQL OPEN cursorAbonadoPrePagoKIT; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 53;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = sq0067;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3101;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqcmod = (unsigned int )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_venta;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_venta;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)chString1;
            sqlstm.sqhstl[4] = (unsigned long )2;
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


            lContador = 0;

            while (1)
            {
                /* EXEC SQL
                    FETCH cursorAbonadoPrePagoKIT
                     INTO :szhNumSerie,
                          :lhNumAbonado,
                          :lhCodConcepto,
                          :szhDesConcepto,
                          :lhNumCelular; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 53;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3136;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqfoff = (         int )0;
                sqlstm.sqfmod = (unsigned int )2;
                sqlstm.sqhstv[0] = (unsigned char  *)szhNumSerie;
                sqlstm.sqhstl[0] = (unsigned long )26;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhDesConcepto;
                sqlstm.sqhstl[3] = (unsigned long )61;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)&lhNumCelular;
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
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



                if (sqlca.sqlcode == SQLNOTFOUND)
                    break;
                else if (sqlca.sqlcode != SQLOK)
                {
                    vDTrazasLog (modulo,"\n\tERROR, al leer cursor Abonado PrePago KIT.Sqlca.sqlcode [%d]"
                                       , LOG01,sqlca.sqlcode);
                    return FALSE;
                }

                paux = (stSalida *) malloc(sizeof(stSalida));
                if(paux == NULL)
                {
                    vDTrazasLog (modulo,"\n\nERROR:1:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                    vDTrazasError (modulo,"\n\nERROR:1:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                    return (FALSE);
                }


                strcpy(paux->szNumSerie,szhNumSerie);
                paux->lNumAbonado = lhNumAbonado;
                paux->iCodConcepto = lhCodConcepto;
                strcpy(paux->szDesConcepto,szhDesConcepto);
                paux->lNumCelular  = lhNumCelular;

                paux->sgte  = lstSalida;
                lstSalida   = paux;
                lContador++;

            }

            /* EXEC SQL CLOSE cursorAbonadoPrePagoKIT; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 53;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3171;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



            if (lContador == 0)
            {
                vDTrazasLog (modulo,"\n\tProcedencia es prepago...", LOG05);

                /* EXEC SQL DECLARE cursorAbonadoPrePago CURSOR FOR
                SELECT
                    A.NUM_SERIE,
                    A.NUM_ABONADO,
                    B.COD_CONCEPTO,
                    B.DES_CONCEPTO,
                    D.NUM_CELULAR     
                FROM
                    GA_EQUIPABOSER A,
                    FA_CONCEPTOS   B,
                    AL_ARTICULOS   C,
                    GA_ABOAMIST    D
                WHERE
                    A.NUM_ABONADO IN (SELECT D.NUM_ABONADO
                                      FROM   GA_ABOAMIST D
                                      WHERE  D.NUM_VENTA       = :lhNum_venta
                                        AND  D.COD_CLIENTE     = :lhCod_cliente
                                        AND  TRUNC(D.FEC_ALTA) IN (SELECT TRUNC(E.FEC_VENTA)
                                                                   FROM   GA_VENTAS E
                                                                   WHERE  E.NUM_VENTA   = :lhNum_venta
                                                                     AND  E.COD_CLIENTE = :lhCod_cliente))
                    AND C.COD_ARTICULO    = A.COD_ARTICULO
                    AND C.COD_CONCEPTOART = B.COD_CONCEPTO
                    AND A.NUM_ABONADO     = D.NUM_ABONADO
                    AND A.IND_PROCEQUI    = :chString1; */ 


                /* EXEC SQL OPEN cursorAbonadoPrePago; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 53;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = sq0068;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3186;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqcmod = (unsigned int )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_venta;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_venta;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)chString1;
                sqlstm.sqhstl[4] = (unsigned long )2;
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




                while (1)
                {
                    /* EXEC SQL
                        FETCH cursorAbonadoPrePago
                         INTO :szhNumSerie,
                              :lhNumAbonado,
                              :lhCodConcepto,
                              :szhDesConcepto,
                              :lhNumCelular; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 53;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )3221;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqfoff = (         int )0;
                    sqlstm.sqfmod = (unsigned int )2;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhNumSerie;
                    sqlstm.sqhstl[0] = (unsigned long )26;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
                    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhDesConcepto;
                    sqlstm.sqhstl[3] = (unsigned long )61;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumCelular;
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
                    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



                    if (sqlca.sqlcode == SQLNOTFOUND)
                        break;
                    else if (sqlca.sqlcode != SQLOK)
                    {
                        vDTrazasLog (modulo,"\n\tERROR, Al leer cursor Abonado PrePago. sqlca.sqlcode [%d]"
                                           , LOG01,sqlca.sqlcode);
                        return FALSE;
                    }

                    paux = (stSalida *) malloc(sizeof(stSalida));
                    if(paux == NULL)
                    {
                        vDTrazasLog (modulo,"\n\nERROR:2:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                        vDTrazasError (modulo,"\n\nERROR:2:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                        return (FALSE);
                    }


                    strcpy(paux->szNumSerie,szhNumSerie);
                    paux->lNumAbonado = lhNumAbonado;
                    paux->iCodConcepto = lhCodConcepto;
                    strcpy(paux->szDesConcepto,szhDesConcepto);
                    paux->lNumCelular  = lhNumCelular;

                    paux->sgte  = lstSalida;
                    lstSalida   = paux;


                }


                /* EXEC SQL CLOSE cursorAbonadoPrePago; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 53;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3256;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            }
        }
        else
        {
            vDTrazasLog (modulo,"\n\tProcedencia es postpago...", LOG05);


                /* EXEC SQL DECLARE cursorAbonadoPostPago CURSOR FOR
                SELECT
                    A.NUM_SERIE
                    ,A.NUM_ABONADO
                    ,B.COD_CONCEPTO
                    ,B.DES_CONCEPTO
                    ,D.NUM_CELULAR  
                FROM
                    GA_EQUIPABOSER A
                    ,FA_CONCEPTOS B
                    ,AL_ARTICULOS C
                    ,GA_ABOCEL     D
                WHERE
                    A.NUM_ABONADO IN (SELECT D.NUM_ABONADO
                                      FROM   GA_ABOCEL D
                                      WHERE  D.NUM_VENTA       = :lhNum_venta
                                        AND  D.COD_CLIENTE     = :lhCod_cliente
                                        AND  TRUNC(D.FEC_ALTA) IN (SELECT TRUNC(E.FEC_VENTA)
                                                                   FROM   GA_VENTAS E
                                                                   WHERE  E.NUM_VENTA       = :lhNum_venta
                                                                     AND  E.COD_CLIENTE = :lhCod_cliente))
                  AND C.COD_ARTICULO    = A.COD_ARTICULO
                  AND C.COD_CONCEPTOART = B.COD_CONCEPTO
                  AND A.NUM_ABONADO     = D.NUM_ABONADO
                  AND A.IND_PROCEQUI    = :chString1; */ 



                /* EXEC SQL OPEN cursorAbonadoPostPago; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 53;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = sq0069;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3271;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqcmod = (unsigned int )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_venta;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_venta;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)chString1;
                sqlstm.sqhstl[4] = (unsigned long )2;
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



            while (1)
            {
                /* EXEC SQL
                    FETCH cursorAbonadoPostPago
                      INTO :szhNumSerie
                          ,:lhNumAbonado
                          ,:lhCodConcepto
                          ,:szhDesConcepto
                          ,:lhNumCelular; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 53;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3306;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqfoff = (         int )0;
                sqlstm.sqfmod = (unsigned int )2;
                sqlstm.sqhstv[0] = (unsigned char  *)szhNumSerie;
                sqlstm.sqhstl[0] = (unsigned long )26;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhDesConcepto;
                sqlstm.sqhstl[3] = (unsigned long )61;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)&lhNumCelular;
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
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



                if (sqlca.sqlcode == SQLNOTFOUND)
                    break;
                else if(sqlca.sqlcode != SQLOK)
                {
                    vDTrazasLog (modulo,"\n\tERROR, al leer cursor Abonado PostPago. Sqlca.sqlcode[%d]"
                                       , LOG01,sqlca.sqlcode);
                    return FALSE;
                }

                paux = (stSalida *) malloc(sizeof(stSalida));
                if(paux == NULL)
                {
                    vDTrazasLog (modulo,"\n\nERROR:3:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                    vDTrazasError (modulo,"\n\nERROR:3:(%s): En asignacion de memoria a paux.", LOG05,modulo );
                    return (FALSE);
                }

                strcpy(paux->szNumSerie,szhNumSerie);
                paux->lNumAbonado = lhNumAbonado;
                paux->iCodConcepto = lhCodConcepto;
                strcpy(paux->szDesConcepto,szhDesConcepto);
                paux->lNumCelular  = lhNumCelular;

                paux->sgte  = lstSalida;
                lstSalida   = paux;

            }

            /* EXEC SQL CLOSE cursorAbonadoPostPago; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 53;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3341;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        }
    }
    return TRUE;

} 
/* ifnLlenarSeriesDeVenta */

int ifnObtenerSeriesFactMiscela(reg_entrada *pstEntrada)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhNumProceso     = 0L;
    long    lhCodConcepto    = 0L;
    long    lhColumna        = 0L;
    char    szhNumSerieResp  [30];   /* EXEC SQL VAR szhNumSerieResp IS STRING(30); */ 

    long    lhNumProcesoResp = 0L;
    long    lhCodConceptoResp= 0L;
    long    lhColumnaResp    = 0L;
    /* EXEC SQL END   DECLARE SECTION; */ 


    char    szhDesConcepto[60+1];

    char *pszModulo="ifnObtenerSeriesFactMiscela";

    stSalida *paux;

    lhNumProceso     = pstEntrada->lNumProceso;
    lhCodConcepto    = pstEntrada->iCodConcepto;
    lhColumna        = pstEntrada->iColumna;
    strcpy(szhDesConcepto,pstEntrada->szDesConcepto);

    paux = NULL;

    vDTrazasLog (pszModulo, "\n\tProceso: [%ld]"
                            "\n\tConcepto: [%ld]"
                            "\n\tColumna: [%ld]"
                            , LOG05,lhNumProceso,lhCodConcepto,lhColumna);

    /* EXEC SQL DECLARE curSeriesMiscelaneas CURSOR FOR
        SELECT
            A.NUM_SERIE,
            A.NUM_PROCESO,
            A.COD_CONCEPTO,
            A.COLUMNA
       FROM
            FA_SERIES_TO A
        WHERE
            A.NUM_PROCESO      = :lhNumProceso
            AND A.COD_CONCEPTO = :lhCodConcepto
            AND A.COLUMNA      = :lhColumna; */ 


        if(SQLCODE != SQLOK)
        {
            vDTrazasLog (pszModulo,"\n\tERROR, En DECLARE de cursor curSeriesMiscelaneas, sqlcode: [%d]"
                                  , LOG01,sqlca.sqlcode);
            return FALSE;
        }

        /* EXEC SQL OPEN curSeriesMiscelaneas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0070;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3356;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodConcepto;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhColumna;
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



        for(;;)
        {

            /* EXEC SQL
            FETCH
                curSeriesMiscelaneas
                    INTO
                        :szhNumSerieResp,
                        :lhNumProcesoResp,
                        :lhCodConceptoResp,
                        :lhColumnaResp; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 53;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3383;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNumSerieResp;
            sqlstm.sqhstl[0] = (unsigned long )30;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProcesoResp;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConceptoResp;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhColumnaResp;
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
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



            if (SQLCODE == SQLNOTFOUND)
                break;

            if(SQLCODE !=SQLOK)
            {
                vDTrazasLog (pszModulo,"\n\tERROR, En FETCH de cursor curSeriesMiscelaneas, sqlcode: [%d]"
                                      , LOG01,sqlca.sqlcode);
                return FALSE;
            }


            paux = (stSalida *) malloc(sizeof(stSalida));
            if(paux == NULL)
            {
                vDTrazasLog (pszModulo,"\n\nERROR:(%s): En asignacion de memoria a paux.", LOG05,pszModulo );
                vDTrazasError (pszModulo,"\n\nERROR:(%s): En asignacion de memoria a paux.", LOG05,pszModulo );
                return (FALSE);
            }

            strcpy(paux->szNumSerie,szhNumSerieResp);
            paux->lNumAbonado  = 0L;
            paux->iCodConcepto = lhCodConceptoResp;
            strcpy(paux->szDesConcepto,szhDesConcepto);
            paux->lNumCelular  = 0L;

            paux->sgte  = lstSalida;
            lstSalida   = paux;

        }

        /* EXEC SQL CLOSE curSeriesMiscelaneas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3414;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    return TRUE;
}
/*
 * Obtener Valor total de la deuda financiada y saldo pendiente para la cuota ingresada
 * por parametro.
 */

int ifnObtenerMontosTotalesCuota( rg_cuotas pstCuota, double *pdMtoTotDeuda, double *pdMtoSaldoPend, int record)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int    ihCodCliente        = 0;
    long   lhCodConcepto       = 0L;
    long   lhNumFolio          = 0L;
    double dhMtoDeudaCartera   = 0.0;
    double dhMtoPagadoCartera  = 0.0;
    double dhTotalCancelado    = 0.0;
    int    ihSecCuota          = 0; 

    /* EXEC SQL END   DECLARE SECTION; */ 


    double dMontoTotalDeuda = 0.0;
    double dSaldoPendiente  = 0.0;
    int    ihRecord = 0;

    char *pszModulo="ifnObtenerMontosTotalesCuota";

    vDTrazasLog (pszModulo,"\tDentro de la funcion(%s):  \n"
                           "\t\tCodigo de Cliente : [%d] \n"
                           "\t\tCodigo de Concepto: [%ld]\n"
                           "\t\tNumero de folio   : [%ld]"
                          ,LOG05,pszModulo,pstCuota.iCodCliente, pstCuota.iCod_Concepto, pstCuota.lNum_Folio);


    ihCodCliente  = pstCuota.iCodCliente;
    lhCodConcepto = pstCuota.iCod_Concepto;
    lhNumFolio    = pstCuota.lNum_Folio;
    ihSecCuota    = pstCuota.iSecCuota;
    ihRecord      = record;

    if (ihRecord == 1)
    {
        /* EXEC SQL
            SELECT
                SUM(A.IMPORTE_DEBE),
                SUM(A.IMPORTE_HABER)
            INTO
                :dhMtoDeudaCartera,
                :dhMtoPagadoCartera
            FROM
                CO_CARTERA A
            WHERE
                A.COD_CLIENTE      = :ihCodCliente
                AND A.NUM_FOLIO    = :lhNumFolio
                AND NOT EXISTS (SELECT 1 FROM FA_CUOTCREDITO B        
                                WHERE A.COD_CLIENTE = B.COD_CLIENTE   
                                AND   A.COD_CONCEPTO = B.COD_CONCEPTO 
                                AND   A.NUM_FOLIO = B.NUM_FOLIO       
                                AND   A.NUM_CUOTA = B.NUM_CUOTA       
                                AND   A.SEC_CUOTA = B.SEC_CUOTA)      
            GROUP BY
                A.COD_CLIENTE,
                A.NUM_FOLIO; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select sum(A.IMPORTE_DEBE) ,sum(A.IMPORTE_HABER) into\
 :b0,:b1  from CO_CARTERA A where ((A.COD_CLIENTE=:b2 and A.NUM_FOLIO=:b3) and\
  not exists (select 1  from FA_CUOTCREDITO B where ((((A.COD_CLIENTE=B.COD_CL\
IENTE and A.COD_CONCEPTO=B.COD_CONCEPTO) and A.NUM_FOLIO=B.NUM_FOLIO) and A.NU\
M_CUOTA=B.NUM_CUOTA) and A.SEC_CUOTA=B.SEC_CUOTA))) group by A.COD_CLIENTE,A.N\
UM_FOLIO";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3429;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhMtoDeudaCartera;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhMtoPagadoCartera;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCliente;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFolio;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else if (ihRecord == 2) 
    {

        /* EXEC SQL
            SELECT
                SUM(A.IMPORTE_DEBE),
                SUM(A.IMPORTE_HABER)
            INTO
                :dhMtoDeudaCartera,
                :dhMtoPagadoCartera
            FROM
                CO_CARTERA A
            WHERE
                A.COD_CLIENTE      = :ihCodCliente
                AND A.COD_CONCEPTO = :lhCodConcepto
                AND A.NUM_FOLIO    = :lhNumFolio
                AND NOT EXISTS (SELECT 1 FROM FA_CUOTCREDITO B       
                                WHERE A.COD_CLIENTE = B.COD_CLIENTE  
                                AND   A.COD_CONCEPTO = B.COD_CONCEPTO
                                AND   A.NUM_FOLIO = B.NUM_FOLIO     
                                AND   A.NUM_CUOTA = B.NUM_CUOTA     
                                AND   A.SEC_CUOTA = B.SEC_CUOTA)    
            GROUP BY
                A.COD_CLIENTE,
                A.COD_CONCEPTO,
                A.NUM_FOLIO; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select sum(A.IMPORTE_DEBE) ,sum(A.IMPORTE_HABER) into\
 :b0,:b1  from CO_CARTERA A where (((A.COD_CLIENTE=:b2 and A.COD_CONCEPTO=:b3)\
 and A.NUM_FOLIO=:b4) and  not exists (select 1  from FA_CUOTCREDITO B where (\
(((A.COD_CLIENTE=B.COD_CLIENTE and A.COD_CONCEPTO=B.COD_CONCEPTO) and A.NUM_FO\
LIO=B.NUM_FOLIO) and A.NUM_CUOTA=B.NUM_CUOTA) and A.SEC_CUOTA=B.SEC_CUOTA))) g\
roup by A.COD_CLIENTE,A.COD_CONCEPTO,A.NUM_FOLIO";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3460;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhMtoDeudaCartera;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhMtoPagadoCartera;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCliente;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodConcepto;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhNumFolio;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }


    if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
    {
        vDTrazasLog (pszModulo,"\n\nERROR:(%s): En SELECT A CO_CARTERA, SQLCODE: [%d].", LOG01,pszModulo,sqlca.sqlcode);
        return FALSE;
    }

    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog (pszModulo,"\n\nATENCION:(%s): No se encuentran datos en CO_CARTERA, Numero de registros: [%d]."
                              , LOG05,pszModulo,sqlca.sqlerrd[2]);

        dhMtoDeudaCartera  = 0.0;
        dhMtoPagadoCartera = 0.0;
    }

    if (ihSecCuota == 0)
    {

        /* EXEC SQL
        SELECT
            SUM(A.IMPORTE_HABER)
        INTO
            :dhTotalCancelado
        FROM
            CO_CANCELADOS A
        WHERE
            A.COD_CLIENTE      = :ihCodCliente
            AND A.NUM_FOLIO    = :lhNumFolio
        GROUP BY
            A.COD_CLIENTE,
            A.NUM_FOLIO; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select sum(A.IMPORTE_HABER) into :b0  from CO_CANCELA\
DOS A where (A.COD_CLIENTE=:b1 and A.NUM_FOLIO=:b2) group by A.COD_CLIENTE,A.N\
UM_FOLIO";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3495;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhTotalCancelado;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCliente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
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


    }
    else
    {

        /* EXEC SQL
        SELECT
            SUM(A.IMPORTE_HABER)
        INTO
            :dhTotalCancelado
        FROM
            CO_CANCELADOS A
        WHERE
            A.COD_CLIENTE      = :ihCodCliente
            AND A.COD_CONCEPTO = :lhCodConcepto
            AND A.NUM_FOLIO    = :lhNumFolio
        GROUP BY
            A.COD_CLIENTE,
            A.COD_CONCEPTO,
            A.NUM_FOLIO; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select sum(A.IMPORTE_HABER) into :b0  from CO_CANCELA\
DOS A where ((A.COD_CLIENTE=:b1 and A.COD_CONCEPTO=:b2) and A.NUM_FOLIO=:b3) g\
roup by A.COD_CLIENTE,A.COD_CONCEPTO,A.NUM_FOLIO";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3522;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhTotalCancelado;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCliente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFolio;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }

    if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
    {
        vDTrazasLog (pszModulo,"\n\nERROR:(%s): En SELECT A CO_CANCELADOS, SQLCODE: [%d].", LOG01,pszModulo,sqlca.sqlcode);
        return FALSE;
    }

    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog (pszModulo,"\n\nATENCION:(%s): No se encuentran datos en CO_CANCELADOS, Numero de registros: [%d].", LOG05,pszModulo,sqlca.sqlerrd[2]);
        dhTotalCancelado = 0.0;
    }


    dMontoTotalDeuda = dhMtoDeudaCartera + dhTotalCancelado;
    dSaldoPendiente  = dMontoTotalDeuda - (dhMtoPagadoCartera + dhTotalCancelado);

    vDTrazasLog("ifnObtenerMontosTotalesCuota", "\t(ifnObtenerMontosTotalesCuota): Monto Total deuda : [%015.4f]\n"
                                                "\t(ifnObtenerMontosTotalesCuota): Saldo Pendiente   : [%015.4f]"
                                                , LOG06, dMontoTotalDeuda, dSaldoPendiente);



    *pdMtoTotDeuda = dMontoTotalDeuda;
    *pdMtoSaldoPend= dSaldoPendiente;

    return TRUE;
}

/* FUNCION QUE RESCATA EL PLAN TARIFARIO DEL ABONADO DE LA GA_INFACCEL*/
/*---------------------------------------------------------------------------*/
/* Funcion: bfnGetPlanTarifAbo                                            */
/*---------------------------------------------------------------------------*/

BOOL bfnGetPlanTarifAbo(long lNumAbonado, long lCodcliente, char *szCodPlanTarifAbo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhCodPlanTarif [4]; /* EXEC SQL VAR szhCodPlanTarif IS STRING(4); */ 

         long lhCodCliente       ;
         long lhNumAbonado       ;
    /* EXEC SQL END   DECLARE SECTION; */ 



    lhCodCliente = lCodcliente;
    lhNumAbonado = lNumAbonado;

    /* EXEC SQL
           SELECT COD_PLANTARIF 
           INTO   :szhCodPlanTarif
           FROM   GA_INTARCEL A
           WHERE  A.COD_CLIENTE = :lhCodCliente 
           AND    A.NUM_ABONADO   = :lhNumAbonado
           AND    A.FEC_DESDE     =( SELECT MAX(C.FEC_DESDE)  
                                       FROM   GA_INTARCEL C
                                       WHERE  C.COD_CLIENTE   = :lhCodCliente
                                       AND    C.NUM_ABONADO   = :lhNumAbonado); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PLANTARIF into :b0  from GA_INTARCEL A where (\
(A.COD_CLIENTE=:b1 and A.NUM_ABONADO=:b2) and A.FEC_DESDE=(select max(C.FEC_DE\
SDE)  from GA_INTARCEL C where (C.COD_CLIENTE=:b1 and C.NUM_ABONADO=:b2)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3553;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[0] = (unsigned long )4;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog ("bfnGetPlanTarifAbo","\n\t\t* En sentenia SELECT, Codigo: [%d]", LOG01,sqlca.sqlcode);
        return FALSE;
    }

    strcpy (szCodPlanTarifAbo, szhCodPlanTarif);

    return (TRUE);
}

int ifnCmpOrden(const void *cad1,const void *cad2)
{
    return ( strcmp (((ST_ORDEN  *)cad1)->szKey,((ST_ORDEN  *)cad2)->szKey) );

}

int ifnLiberaDetCons (void)
{
    free(stFaDetCons.stDetConsumo);
    memset (&stFaDetCons,0,sizeof(stFaDetCons));

  
    free(stOrden2DetConsumo.stOrden);
    memset(&stOrden2DetConsumo, 0, sizeof (stOrden2DetConsumo));

    return 1;
}

BOOL fnGrabaAnoProceso (long lCod_Cliente, long lCod_CiclFact, int iCod_Anomalia, char *szObs_Anomalia)
{
    static int  iTitulo;
    static long lsCod_Cliente;
    char modulo[]   ="fnGrabaAnomaliaImpresion";

    char    szhDes_Proceso  [41];
    char    szhObs_Anomalia[101];

    strncpy(szhDes_Proceso,"ImpresionScl",40);
    strncpy(szhObs_Anomalia,szObs_Anomalia,100);

    vDTrazasLog (modulo,"\tDentro de la funcion(%s):  ",LOG03,modulo);
    vDTrazasLog (modulo,"\n\t\t* Valores de Anomalia:"
                        "\t\t* Proceso        [%ld]"
                        "\t\t* Cliente        [%ld]"
                        "\t\t* Ciclo de Fact. [%ld]"
                        "\t\t* Desc. Proceso  [%s]"
                        "\t\t* Cod. Anomalia  [%d]"
                        "\t\t* Desc. Anomalia [%s]"
                        , LOG06,lgNum_Proceso
                        , lCod_Cliente
                        , lCod_CiclFact
                        , szhDes_Proceso
                        , iCod_Anomalia
                        , szhObs_Anomalia);

    if (iTitulo != 1)
    {
        fprintf(fpAnomalias,"PROCESO ANOMALIA|CLIENTE|CICLO DE FACT|DESC PROCESO|COD ANOMALIA|DESC ANOMALIA|\n");
        fprintf(fpAnomalias,"----------------|-------|-------------|------------|------------|-------------|\n");
        iTitulo = 1;
    }

    if (lsCod_Cliente != lCod_Cliente)
    {
        fprintf(fpAnomalias,"%ld|%ld|%ld|%s|%d|%s|\n"
                           ,lgNum_Proceso
                           ,lCod_Cliente
                           ,lCod_CiclFact
                           ,szhDes_Proceso
                           ,iCod_Anomalia
                           ,szhObs_Anomalia);
        lsCod_Cliente = lCod_Cliente;
    }
    return(TRUE);
}

long lObtieneNumProcAnomalias(void)
{
    char modulo[]   ="bObtieneNumProcAnomalias";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNum_Proceso ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\tDentro de la funcion(%s):  ",LOG03,modulo);

    /* EXEC SQL
    SELECT FA_SEQ_NUMPRO.NEXTVAL
      INTO :lhNum_Proceso
    FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_SEQ_NUMPRO.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3588;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_Proceso;
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



    if(SQLCODE == SQLOK)
        return(lhNum_Proceso);
    else
    {
        vDTrazasLog (modulo,"\n\t\t* En sentencia SELECT, Codigo: [%d]", LOG01,sqlca.sqlcode);
        return(-1);
    }
}

int bfnLiberarBenefPromo(void)
{
    if (stBenefPromo.stNodo)
    {
        free(stBenefPromo.stNodo);
    }

    stBenefPromo.lNumBenef = 0;

    return TRUE;
}

int bfnCargarBenefPromo(long lCodCliente , long lCodCiclFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long   lhNumAbonado;
    char   szhCodEstadoBenef[6]; /* EXEC SQL VAR szhCodEstadoBenef IS STRING(6); */ 

    char   szhCodPlan       [6]; /* EXEC SQL VAR szhCodPlan        IS STRING(6); */ 

    char   szhDesPlan      [31]; /* EXEC SQL VAR szhDesPlan        IS STRING(31); */ 

    int    ihNumPeriodos       ;
    int    ihPeriodosOtor      ;
    int    ihPeriodosRest      ;
    int    ihMinAdicionales    ;
    double dhMontCargaAdic     ;
    char   szhNomUsuario   [31]; /* EXEC SQL VAR szhNomUsuario     IS STRING(31); */ 

    char   szhFecIngreso   [20]; /* EXEC SQL VAR szhFecIngreso     IS STRING(20); */ 

    double dhValAcumulado      ;
    char   szhCodEstado     [6]; /* EXEC SQL VAR szhCodEstado      IS STRING(6); */ 

    char   szhIndReevalua   [2]; /* EXEC SQL VAR szhIndReevalua    IS STRING(2); */ 

    char   szhTipBeneficio  [6]; /* EXEC SQL VAR szhTipBeneficio   IS STRING(6); */ 

    long   lhCodCiclFact       ;
    long   lhCodCliente        ;
    int    ihValorCero         ;
    char  szhCod_Estado1    [4]; /* EXEC SQL VAR szhCod_Estado1    IS STRING(4); */ 

    char  szhCod_Estado2    [4]; /* EXEC SQL VAR szhCod_Estado2    IS STRING(4); */ 

    int   iCont;
    /* EXEC SQL END   DECLARE SECTION; */ 


    BENEF_NODO *stBenefNodoTemp;

    vDTrazasLog("bfnCargarBenefPromo", "[INFO] Entrando en bfnCargarBenefPromo \n"
                                       "                   Cod. Cliente:[%ld] \n"
                                       "                   lCodCiclFact:[%ld] \n"
                                     , LOG05, lCodCliente,lCodCiclFact);

    iCont = 0;
    lhCodCiclFact = lCodCiclFact;
    lhCodCliente = lCodCliente;
    strcpy(szhCod_Estado1,"EJE");
    strcpy(szhCod_Estado2,"EPR");
    ihValorCero = 0;
    stBenefPromo.lNumBenef = 0;

    stBenefPromo.stNodo = NULL;

    /* EXEC SQL DECLARE cursor_benef_promo CURSOR FOR
    SELECT
           A.NUM_ABONADO,
           C.COD_ESTADO,
           B.COD_PLAN,
           NVL(B.DES_PLAN,' '),
           NVL(A.NUM_PERIODOS,:ihValorCero),
           MAX(C.SEC_PERIODO),
           A.NUM_PERIODOS - MAX(C.SEC_PERIODO),
           NVL(B.CNT_MINADIC,:ihValorCero),
           NVL(B.MTO_CARGADIC,:ihValorCero),
           NVL(A.NOM_USUARIO,' '),
           TO_CHAR(A.FEC_INGRESO,'YYYY-MM-DD HH24:MI:SS'),
           NVL(A.VAL_ACUMULADO,:ihValorCero),
           A.COD_ESTADO,
           B.IND_REEVALUA,
           B.TIP_BENEFICIO
    FROM BPT_BENEFICIOS C,BPT_BENEFICIARIOS A, BPD_PLANES B
    WHERE  C.COD_CLIENTE   = :lhCodCliente
    AND    C.COD_PLAN      = B.COD_PLAN
    AND    C.FEC_DESDEAPLI = B.FEC_DESDEAPLI
    AND    A.FEC_INGRESO   = C.FEC_INGRESO
    AND    C.COD_ESTADO   IN (:szhCod_Estado1,:szhCod_Estado2)
    AND    C.COD_CICLFACT  = :lhCodCiclFact
    AND    A.COD_CLIENTE   = C.COD_CLIENTE
    AND    A.NUM_ABONADO   = C.NUM_ABONADO
    AND    A.COD_PLAN      = B.COD_PLAN
    AND    A.FEC_DESDEAPLI = B.FEC_DESDEAPLI
    GROUP BY  A.NUM_ABONADO,C.COD_ESTADO,B.COD_PLAN,B.DES_PLAN,
              A.NUM_PERIODOS,B.CNT_MINADIC,B.MTO_CARGADIC,
              A.NOM_USUARIO,A.FEC_INGRESO,A.VAL_ACUMULADO,
              A.COD_ESTADO,B.IND_REEVALUA,B.TIP_BENEFICIO; */ 


    if (SQLCODE != SQLOK)
    {
        vDTrazasLog("bfnCargarBenefPromo", "[ERROR] (bfnCargarBenefPromo): Error en ejecucion de EXEC SQL DECLARE cursor_benef_promo, SQLCODE: [%d]", LOG01, SQLCODE);
        return(FALSE);
    }

    /* EXEC SQL OPEN cursor_benef_promo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0077;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3607;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCod_Estado1;
    sqlstm.sqhstl[5] = (unsigned long )4;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCod_Estado2;
    sqlstm.sqhstl[6] = (unsigned long )4;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
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


    if (SQLCODE != SQLOK)
    {
        vDTrazasLog("bfnCargarBenefPromo", "[ERROR] (bfnCargarBenefPromo): Error en ejecucion de EXEC SQL OPEN cursor_benef_prom, SQLCODE: [%d]", LOG01, SQLCODE);
        return(FALSE);
    }

    for(iCont = 0;;iCont++)
    {
        /* EXEC SQL FETCH cursor_benef_promo
        INTO :lhNumAbonado,
             :szhCodEstadoBenef,
             :szhCodPlan,
             :szhDesPlan,
             :ihNumPeriodos,
             :ihPeriodosOtor,
             :ihPeriodosRest,
             :ihMinAdicionales,
             :dhMontCargaAdic,
             :szhNomUsuario,
             :szhFecIngreso,
             :dhValAcumulado,
             :szhCodEstado,
             :szhIndReevalua,
             :szhTipBeneficio; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 53;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3654;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodEstadoBenef;
        sqlstm.sqhstl[1] = (unsigned long )6;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlan;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhDesPlan;
        sqlstm.sqhstl[3] = (unsigned long )31;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihNumPeriodos;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihPeriodosOtor;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihPeriodosRest;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&ihMinAdicionales;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&dhMontCargaAdic;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhNomUsuario;
        sqlstm.sqhstl[9] = (unsigned long )31;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szhFecIngreso;
        sqlstm.sqhstl[10] = (unsigned long )20;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&dhValAcumulado;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szhCodEstado;
        sqlstm.sqhstl[12] = (unsigned long )6;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szhIndReevalua;
        sqlstm.sqhstl[13] = (unsigned long )2;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szhTipBeneficio;
        sqlstm.sqhstl[14] = (unsigned long )6;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasLog("bfnCargarBenefPromo", "[ERROR] (bfnCargarBenefPromo): Error en ejecucion de EXEC SQL FETCH cursor_benef_promo, SQLCODE: [%d]", LOG01, SQLCODE);
            return(FALSE);
        }

        if(SQLCODE == SQLNOTFOUND)
            break;

        if(!stBenefPromo.stNodo)
        {
            stBenefPromo.stNodo = (BENEF_NODO*)malloc(sizeof(BENEF_NODO) );
        }
        else
        {
            stBenefPromo.stNodo = (BENEF_NODO*)realloc(stBenefPromo.stNodo, (int) sizeof(BENEF_NODO) * (iCont+1));
        }

        if(!stBenefPromo.stNodo)
        {
            vDTrazasLog("bfnCargarBenefPromo", "[ERROR] (bfnCargarBenefPromo): Error en Alocacion de memoria dinamica"
                                             , LOG01);
            return(FALSE);
        }

        stBenefNodoTemp = &(stBenefPromo.stNodo)[iCont];
        memset(stBenefNodoTemp, 0, sizeof(BENEF_NODO));

        stBenefNodoTemp->lNumAbonado = lhNumAbonado;
        strcpy(stBenefNodoTemp->szCodEstadoBenef,szhCodEstadoBenef);
        strcpy(stBenefNodoTemp->szCodPlan,szhCodPlan);
        strcpy(stBenefNodoTemp->szDesPlan,szhDesPlan);
        stBenefNodoTemp->iNumPeriodos = ihNumPeriodos;
        stBenefNodoTemp->iPeriodosOtor = ihPeriodosOtor;
        stBenefNodoTemp->iPeriodosRest = ihPeriodosRest;
        stBenefNodoTemp->iMinAdicionales = ihMinAdicionales;
        stBenefNodoTemp->dMontCargaAdic = dhMontCargaAdic;
        strcpy(stBenefNodoTemp->szNomUsuario,szhNomUsuario);
        strcpy(stBenefNodoTemp->szFecIngreso,szhFecIngreso);
        stBenefNodoTemp->dValAcumulado = dhValAcumulado;
        strcpy(stBenefNodoTemp->szCodEstado,szhCodEstado);
        strcpy(stBenefNodoTemp->szIndReevalua,szhIndReevalua);
        strcpy(stBenefNodoTemp->szTipBeneficio,szhTipBeneficio);

        stBenefPromo.lNumBenef++;
    }

    /* EXEC SQL CLOSE cursor_benef_promo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 53;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3729;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog("bfnCargarBenefPromo", "bfnCargarBenefPromo(): Cantidad de registros rescatados : [%d]"
                                     , LOG05, stBenefPromo.lNumBenef);

    return TRUE;
}

/******************************************************************************************/
/** Informacisn de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisisn                                            : */
/**  %PR% */
/** Autor de la Revisisn                                : */
/**  %AUTHOR% */
/** Estado de la Revisisn ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creacisn de la Revisisn                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
