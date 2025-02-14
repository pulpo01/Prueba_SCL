
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
           char  filnam[15];
};
static const struct sqlcxp sqlfpn =
{
    14,
    "./pc/pretar.pc"
};


static unsigned int sqlctx = 866043;


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
   unsigned char  *sqhstv[32];
   unsigned long  sqhstl[32];
            int   sqhsts[32];
            short *sqindv[32];
            int   sqinds[32];
   unsigned long  sqharm[32];
   unsigned long  *sqharc[32];
   unsigned short  sqadto[32];
   unsigned short  sqtdso[32];
} sqlstm = {12,32};

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

 static const char *sq0001 = 
"select A.IND_ALQUILER ,A.COD_PERIODO ,A.COD_OPERADOR ,A.COD_TIPCONCE ,X.COD_\
CONCEPTO ,sum(IMP_CONSUMIDO) ,sum(SEG_CONSUMIDO)  from FA_ACUMFORTAS A ,FA_CIC\
LFACT B ,(select P.COD_CONCFACT COD_CONCEPTO ,P.COD_CONCCARRIER COD_OPERADOR ,\
Q.COD_TIPCONCE COD_TIPCONCE  from FA_FACTCARRIERS P ,FA_CONCEPTOS Q where P.CO\
D_CONCFACT=Q.COD_CONCEPTO) X where (((((((A.NUM_ABONADO=:b0 and A.COD_PERIODO=\
B.COD_CICLFACT) and B.FEC_EMISION<=(select max(FEC_EMISION)  from FA_CICLFACT \
where COD_CICLFACT=:b1)) and B.IND_FACTURACION>:b2) and A.COD_CLIENTE=:b3) and\
 A.NUM_PROCESO=0) and A.COD_OPERADOR=X.COD_OPERADOR) and A.COD_TIPCONCE=X.COD_\
TIPCONCE) group by A.IND_ALQUILER,A.COD_PERIODO,A.COD_OPERADOR,A.COD_TIPCONCE,\
X.COD_CONCEPTO           ";

 static const char *sq0002 = 
"select A.IND_ALQUILER ,A.COD_PERIODO ,A.COD_OPERADOR ,A.COD_TIPCONCE ,X.COD_\
CONCEPTO ,sum(IMP_CONSUMIDO)  from FA_ACUMFORADI A ,(select P.COD_CONCFACT COD\
_CONCEPTO ,P.COD_CONCCARRIER COD_OPERADOR ,Q.COD_TIPCONCE COD_TIPCONCE  from F\
A_FACTCARRIERS P ,FA_CONCEPTOS Q where P.COD_CONCFACT=Q.COD_CONCEPTO) X where \
(((((A.NUM_ABONADO=:b0 and A.COD_PERIODO>0) and A.COD_CLIENTE=:b1) and A.NUM_P\
ROCESO=0) and A.COD_OPERADOR=X.COD_OPERADOR) and A.COD_TIPCONCE=X.COD_TIPCONCE\
) group by A.IND_ALQUILER,A.COD_PERIODO,A.COD_OPERADOR,A.COD_TIPCONCE,X.COD_CO\
NCEPTO           ";

 static const char *sq0007 = 
"select  /*+  index (TA_ACUMOPERALQ PK_TA_ACUMOPERALQ)  +*/ IMP_CONSUMIDO ,SE\
G_CONSUMIDO ,NUM_PULSOS  from TA_ACUMOPERALQ where ((((NUM_ABONADO=:b0 and NUM\
_ALQUILER=:b1) and COD_OPERADOR=:b2) and COD_CLIENTE=:b3) and NUM_PROCESO=0)  \
         ";

 static const char *sq0008 = 
"select  /*+  index (TA_ACUMAIREFRASOCALQ PK_TA_ACUMAIREFRASOCALQ)  +*/ IMP_C\
ONSUMIDO ,SEG_CONSUMIDO  from TA_ACUMAIREFRASOCALQ where (((((NUM_ABONADO=:b0 \
and NUM_ALQUILER=:b1) and COD_FRANHORASOC=:b2) and IND_ENTSAL=:b3) and COD_CLI\
ENTE=:b4) and NUM_PROCESO=0)           ";

 static const char *sq0010 = 
"select IMP_CONSUMIDO ,SEG_CONSUMIDO ,IND_ENTSAL ,IND_DESTINO ,COD_FRANHORASO\
C ,COD_SERVICIO  from TA_ACUMAIREFRASOC where ((NUM_ABONADO=:b0 and COD_CLIENT\
E=:b1) and NUM_PROCESO=0)           ";

 static const char *sq0009 = 
"select ROWID ,COD_CICLFACT ,IMP_CONSUMIDO ,SEG_CONSUMIDO ,IND_ENTSAL ,IND_DE\
STINO ,COD_FRANHORASOC ,COD_SERVICIO  from TA_ACUMAIREFRASOC where (((NUM_ABON\
ADO=:b0 and COD_CICLFACT>0) and COD_CLIENTE=:b1) and NUM_PROCESO=0)           ";

 static const char *sq0013 = 
"select  /*+  index (TA_ACUMOPER PK_TA_ACUMOPER)  +*/ IMP_CONSUMIDO ,SEG_CONS\
UMIDO ,NUM_PULSOS ,COD_OPERADOR  from TA_ACUMOPER where ((NUM_ABONADO=:b0 and \
COD_CLIENTE=:b1) and NUM_PROCESO=0)           ";

 static const char *sq0012 = 
"select  /*+  index (TA_ACUMOPER PK_TA_ACUMOPER)  +*/ ROWID ,COD_CICLFACT ,IM\
P_CONSUMIDO ,SEG_CONSUMIDO ,NUM_PULSOS ,COD_OPERADOR  from TA_ACUMOPER where (\
((NUM_ABONADO=:b0 and COD_CICLFACT>0) and COD_CLIENTE=:b1) and NUM_PROCESO=0) \
          ";

 static const char *sq0016 = 
"select  /*+  index (TA_ACUMLLAMADASROA PK_TA_ACUMLLAMADASROA)  +*/ IMP_CONSU\
MIDO ,SEG_CONSUMIDO ,COD_OPERADOR ,0  from TA_ACUMLLAMADASROA where ((NUM_ABON\
ADO=:b0 and COD_CLIENTE=:b1) and NUM_PROCESO=0)           ";

 static const char *sq0015 = 
"select ROWID ,COD_CICLFACT ,IMP_CONSUMIDO ,SEG_CONSUMIDO ,COD_OPERADOR ,0  f\
rom TA_ACUMLLAMADASROA where (((NUM_ABONADO=:b0 and COD_CICLFACT>0) and COD_CL\
IENTE=:b1) and NUM_PROCESO=0)           ";

 static const char *sq0018 = 
"select  /*+  index (TA_ACUMROAMING PK_TA_ACUMROAMING)  +*/ IMP_CONSAIRE ,IMP\
_CONSOPER ,SEG_CONSAIRE ,SEG_CONSOPER  from TA_ACUMROAMING where ((NUM_ABONADO\
=:b0 and NUM_ESTADIA=:b1) and NUM_PROCESO=0)           ";

 static const char *sq0019 = 
"select  /*+  index (GA_INFACCEL PK_GA_INFACCEL)  +*/ ROWID ,NUM_ABONADO  fro\
m GA_INFACCEL where ((((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and COD_CICLFACT<\
=:b2) and IND_FACTUR=1) and ((exists (select  /*+  index (TA_ACUMAIREFRASOC PK\
_TA_ACUMAIREFRASOC) +*/ NUM_ABONADO  from TA_ACUMAIREFRASOC where (((NUM_ABONA\
DO=:b1 and COD_CICLFACT<=:b2) and COD_CLIENTE=:b0) and NUM_PROCESO=0)) or exis\
ts (select  /*+  index(TA_ACUMOPER PK_TA_ACUMOPER)  +*/ NUM_ABONADO  from TA_A\
CUMOPER where (((NUM_ABONADO=:b1 and COD_CICLFACT<=:b2) and COD_CLIENTE=:b0) a\
nd NUM_PROCESO=0))) or exists (select  /*+  index(TA_ACUMLLAMADASROA PK_TA_ACU\
MLLAMADASROA) +*/ NUM_ABONADO  from TA_ACUMLLAMADASROA where (((NUM_ABONADO=:b\
1 and COD_CICLFACT<=:b2) and COD_CLIENTE=:b0) and NUM_PROCESO=0))))           ";

 static const char *sq0020 = 
"select  /*+  index (GA_INFACCEL PK_GA_INFACCEL)  +*/ ROWID ,NUM_ABONADO  fro\
m GA_INFACCEL where ((((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and COD_CICLFACT=\
:b2) and IND_FACTUR=1) and ((exists (select  /*+  index (TA_ACUMAIREFRASOC PK_\
TA_ACUMAIREFRASOC) +*/ NUM_ABONADO  from TA_ACUMAIREFRASOC where (((NUM_ABONAD\
O=:b1 and COD_CICLFACT=:b2) and COD_CLIENTE=:b0) and NUM_PROCESO=0)) or exists\
 (select  /*+  index(TA_ACUMOPER PK_TA_ACUMOPER)  +*/ NUM_ABONADO  from TA_ACU\
MOPER where (((NUM_ABONADO=:b1 and COD_CICLFACT=:b2) and COD_CLIENTE=:b0) and \
NUM_PROCESO=0))) or exists (select  /*+  index(TA_ACUMLLAMADASROA PK_TA_ACUMLL\
AMADASROA) +*/ NUM_ABONADO  from TA_ACUMLLAMADASROA where (((COD_CICLFACT=:b2 \
and NUM_ABONADO=:b1) and COD_CLIENTE=:b0) and NUM_PROCESO=0))))           ";

 static const char *sq0021 = 
"select  /*+  index (GA_INFACCEL PK_GA_INFACCEL)  +*/ ROWID ,NUM_ABONADO  fro\
m GA_INFACCEL where ((((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and FEC_BAJA<=TO_\
DATE(:b2,'YYYYMMDDHH24MISS')) and IND_FACTUR=1) and ((exists (select  /*+  ind\
ex (TA_ACUMAIREFRASOC PK_TA_ACUMAIREFRASOC) +*/ NUM_ABONADO  from TA_ACUMAIREF\
RASOC where ((NUM_ABONADO=:b1 and COD_CLIENTE=:b0) and NUM_PROCESO=0)) or exis\
ts (select  /*+  index(TA_ACUMOPER PK_TA_ACUMOPER)  +*/ NUM_ABONADO  from TA_A\
CUMOPER where ((NUM_ABONADO=:b1 and COD_CLIENTE=:b0) and NUM_PROCESO=0))) or e\
xists (select  /*+  index(TA_ACUMLLAMADASROA PK_TA_ACUMLLAMADASROA) +*/ NUM_AB\
ONADO  from TA_ACUMLLAMADASROA where ((NUM_ABONADO=:b1 and COD_CLIENTE=:b0) an\
d NUM_PROCESO=0))))           ";

 static const char *sq0022 = 
"select  /*+  index (GA_INFACBEEP PK_GA_INFACBEEP)  +*/ ROWID ,NUM_ABONADO  f\
rom GA_INFACBEEP where ((((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and COD_CICLFA\
CT<=:b2) and IND_FACTUR=1) and exists (select  /*+  index(TA_ACUMBEEPFRASOC PK\
_TA_ACUMBEEPFRASOC) +*/ NUM_ABONADO  from TA_ACUMBEEPFRASOC where (((NUM_ABONA\
DO=:b1 and COD_CICLFACT<=:b2) and COD_CLIENTE=:b0) and NUM_PROCESO=0)))       \
    ";

 static const char *sq0023 = 
"select  /*+  index (GA_INFACBEEP PK_GA_INFACBEEP)  +*/ ROWID ,NUM_ABONADO  f\
rom GA_INFACBEEP where ((((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and COD_CICLFA\
CT=:b2) and IND_FACTUR=1) and exists (select  /*+  index(TA_ACUMBEEPFRASOC PK_\
TA_ACUMBEEPFRASOC) +*/ NUM_ABONADO  from TA_ACUMBEEPFRASOC where (((NUM_ABONAD\
O=:b1 and COD_CICLFACT=:b2) and COD_CLIENTE=:b0) and NUM_PROCESO=0)))         \
  ";

 static const char *sq0024 = 
"select  /*+  index (GA_INFACBEEP PK_GA_INFACBEEP)  +*/ ROWID ,NUM_ABONADO  f\
rom GA_INFACBEEP where (((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and IND_FACTUR=\
1) and exists (select  /*+  index(TA_ACUMBEEPFRASOC PK_TA_ACUMBEEPFRASOC) +*/ \
NUM_ABONADO  from TA_ACUMBEEPFRASOC where ((NUM_ABONADO=:b1 and COD_CLIENTE=:b\
0) and NUM_PROCESO=0)))           ";

 static const char *sq0025 = 
"select COD_PRODUCTO ,COD_CONCEPTO ,NVL(DES_CONCEPTO,'***')  from GE_MULTIIDI\
OMA where ((NOM_TABLA='TOL_DESCUENTO_TD' and NOM_CAMPO='TIP_DCTO') and COD_IDI\
OMA=:b0)           ";

 static const char *sq0026 = 
"select TIP_DCTO ,COD_DCTO ,GLS_DCTO ,IND_APLICA ,FEC_INI_VIG ,FEC_TER_VIG ,N\
OM_USUARIO ,FEC_UMOD  from TOL_DESCUENTO_TD            ";

 static const char *sq0027 = 
"select trim(UNIDAD_PROMO) ,A.COD_CONCEPTO ,A.FEC_DESDE ,A.FEC_HASTA ,NVL(tri\
m(B.DES_CONCEPTO),'***')  from FA_TOLPROMOCION_TD A ,FA_CONCEPTOS B where A.CO\
D_CONCEPTO=B.COD_CONCEPTO(+) order by A.COD_CONCEPTO            ";

 static const char *sq0028 = 
"select A.TIP_DCTO ,A.COD_CONCEPTO ,NVL(trim(B.DES_CONCEPTO),'***')  from FA_\
CONCLLAM_TD A ,FA_CONCEPTOS B where A.COD_CONCEPTO=B.COD_CONCEPTO(+) order by \
A.COD_CONCEPTO            ";

 static const char *sq0029 = 
"select ROWID ,NUM_ABONADO  from GA_INFACCEL where ((((COD_CLIENTE=:b0 and NU\
M_ABONADO=:b1) and COD_CICLFACT<=:b2) and IND_FACTUR=1) and exists (select NUM\
_ABONADO  from TOL_ACUMOPER_TO where (((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) a\
nd COD_CICLFACT=:b2) and NUM_PROCESO=0)))           ";

 static const char *sq0030 = 
"EPTOS BB ,TA_PLANTARIF C ,FA_CONCEPTRAIMP_TD D ,FA_CICLFACT E where ((((((((\
(((A.NUM_ABONADO=:b21 and A.COD_CICLFACT=E.COD_CICLFACT) and E.FEC_EMISION<=(s\
elect max(FEC_EMISION)  from FA_CICLFACT where COD_CICLFACT=:b22)) and E.IND_F\
ACTURACION>:b0) and A.COD_CLIENTE=:b24) and A.NUM_PROCESO=:b0) and D.COD_CONCD\
EST=BB.COD_CONCEPTO(+)) and A.COD_CARG=B.COD_CONCEPTO(+)) and B.COD_PRODUCTO=:\
b15) and A.COD_PLAN=C.COD_PLANTARIF(+)) and A.COD_CARG=D.COD_CONCORIG(+)) and \
A.COD_AREAA=D.COD_ZONAORIG(+)) group by COD_OPERADOR,COD_REGI,A.COD_GRUPO,COD_\
CLIENTE,NUM_ABONADO,A.COD_CICLFACT,NUM_PROCESO,IND_EXEDENTE,COD_PLAN,NVL(NVL(D\
.COD_CONCDEST,A.COD_CARG),:b0),TIP_DCTO,COD_DCTO           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,725,0,9,428,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
36,0,0,1,0,0,13,438,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,
0,0,2,3,0,0,
79,0,0,1,0,0,15,460,0,0,0,0,0,1,0,
94,0,0,2,561,0,9,518,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
117,0,0,2,0,0,13,528,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,
0,0,
156,0,0,2,0,0,15,550,0,0,0,0,0,1,0,
171,0,0,3,154,0,5,687,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
210,0,0,4,154,0,5,704,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
249,0,0,5,154,0,5,778,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
288,0,0,6,154,0,5,795,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
327,0,0,7,241,0,9,866,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
358,0,0,7,0,0,13,880,0,0,3,0,0,1,0,2,4,0,0,2,3,0,0,2,3,0,0,
385,0,0,7,0,0,15,896,0,0,0,0,0,1,0,
400,0,0,8,271,0,9,942,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
435,0,0,8,0,0,13,955,0,0,2,0,0,1,0,2,4,0,0,2,3,0,0,
458,0,0,8,0,0,15,969,0,0,0,0,0,1,0,
473,0,0,10,190,0,9,1240,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
496,0,0,9,232,0,9,1242,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
519,0,0,10,0,0,13,1266,0,0,6,0,0,1,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
5,0,0,
558,0,0,9,0,0,13,1273,0,0,8,0,0,1,0,2,97,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,5,0,0,
605,0,0,11,61,0,5,1286,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
628,0,0,10,0,0,15,1300,0,0,0,0,0,1,0,
643,0,0,9,0,0,15,1304,0,0,0,0,0,1,0,
658,0,0,13,200,0,9,1372,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
681,0,0,12,242,0,9,1376,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
704,0,0,13,0,0,13,1388,0,0,4,0,0,1,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
735,0,0,12,0,0,13,1394,0,0,6,0,0,1,0,2,97,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,
774,0,0,14,55,0,5,1405,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
797,0,0,13,0,0,15,1419,0,0,0,0,0,1,0,
812,0,0,12,0,0,15,1423,0,0,0,0,0,1,0,
827,0,0,16,212,0,9,1480,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
850,0,0,15,194,0,9,1484,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
873,0,0,16,0,0,13,1496,0,0,4,0,0,1,0,2,4,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
904,0,0,15,0,0,13,1504,0,0,6,0,0,1,0,2,97,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,
943,0,0,17,62,0,5,1531,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
966,0,0,16,0,0,15,1549,0,0,0,0,0,1,0,
981,0,0,15,0,0,15,1553,0,0,0,0,0,1,0,
996,0,0,18,209,0,9,1607,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1019,0,0,18,0,0,13,1621,0,0,4,0,0,1,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
1050,0,0,18,0,0,15,1662,0,0,0,0,0,1,0,
1065,0,0,19,778,0,9,2167,0,0,12,12,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1128,0,0,20,774,0,9,2171,0,0,12,12,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1191,0,0,21,730,0,9,2175,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1242,0,0,19,0,0,13,2199,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1265,0,0,20,0,0,13,2201,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1288,0,0,21,0,0,13,2203,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1311,0,0,19,0,0,15,2232,0,0,0,0,0,1,0,
1326,0,0,20,0,0,15,2234,0,0,0,0,0,1,0,
1341,0,0,21,0,0,15,2236,0,0,0,0,0,1,0,
1356,0,0,22,392,0,9,2338,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
1395,0,0,23,390,0,9,2342,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
1434,0,0,24,344,0,9,2346,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1465,0,0,22,0,0,13,2369,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1488,0,0,23,0,0,13,2371,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1511,0,0,24,0,0,13,2373,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1534,0,0,22,0,0,15,2402,0,0,0,0,0,1,0,
1549,0,0,23,0,0,15,2404,0,0,0,0,0,1,0,
1564,0,0,24,0,0,15,2406,0,0,0,0,0,1,0,
1579,0,0,25,173,0,9,2879,0,0,1,1,0,1,0,1,97,0,0,
1598,0,0,25,0,0,13,2890,0,0,3,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,
1625,0,0,25,0,0,15,2923,0,0,0,0,0,1,0,
1640,0,0,26,131,0,9,2954,0,0,0,0,0,1,0,
1655,0,0,26,0,0,13,2965,0,0,6,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,
1694,0,0,26,0,0,15,2996,0,0,0,0,0,1,0,
1709,0,0,27,218,0,9,3029,0,0,0,0,0,1,0,
1724,0,0,27,0,0,13,3040,0,0,5,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,
1759,0,0,27,0,0,15,3073,0,0,0,0,0,1,0,
1774,0,0,28,180,0,9,3101,0,0,0,0,0,1,0,
1789,0,0,28,0,0,13,3112,0,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,
1816,0,0,28,0,0,15,3144,0,0,0,0,0,1,0,
1831,0,0,29,284,0,9,3186,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
1870,0,0,29,0,0,13,3199,0,0,1,0,0,1,0,2,3,0,0,
1889,0,0,29,0,0,15,3227,0,0,0,0,0,1,0,
1904,0,0,30,1705,0,9,3360,0,0,28,28,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2031,0,0,30,0,0,13,3372,0,0,32,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,
0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2174,0,0,30,0,0,15,3434,0,0,0,0,0,1,0,
2189,0,0,31,617,0,5,3444,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
};


/******************************************************************************
 Fichero    : pretar.pc
 Descripcion:
 Fecha      : 23-01-97
 Autor      : Javier Garcia Paredes
*******************************************************************************/
 
#define _PRETAR_PC_

#include <pretar.h>


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




long 	gliIndicadorCarrier = 0;


/*----------------------------------------------------------------------------*/
/* Funcion de busqueda en arreglo de ciclos facturados.                       */
/*----------------------------------------------------------------------------*/
BOOL bBusca_Ciclo (int lCodCiclFact)
{
    int i=0;

    while( (lCodCiclFact != iArrCiclo[i]) && (i <= NUM_IARRCICLO) )
    {
        i++;
    }
    if( i > NUM_IARRCICLO )   /* Periodo no encontrado en arreglo */
    {
        vDTrazasLog(szExeName, "Periodo [%d] no encontrado ...", LOG05, lCodCiclFact);
        return(FALSE);
    }
    else
    {
        return(TRUE);
    }
}


/* -------------------------------------------------------------------------- */
/*   bIFTarificacion (long)                                                   */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bfnIFTarificacion (int iTipoFact)
{
    BOOL bRes  = TRUE;
    int  iCont = 0   ;
    int  iIndAlquiler;

    if( iTipoFact == FACT_CICLO )
        memset (&stPlanOptimo, 0, sizeof (EST));

    vDTrazasLog (szExeName,"\n\t\t* Cargando TARIFICACION ",LOG03);

    strncpy (stAnomProceso.szDesProceso,"PreBilling Tarificacion (Carga)",
             sizeof(stAnomProceso.szDesProceso));

    switch( iTipoFact )
    {
        case FACT_RENTAPHONE:
            if( !bfnLeeConceptosRentPhone (stCliente.pAboRent) )
                bRes = FALSE;
            break;
        case FACT_ROAMINGVIS:
            if( stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE)
            {
                if( !bfnLeeConceptosRoamingVis (stCliente.pAboRoaVis) )
                     bRes = FALSE;
            }
            else
            {
/*              <SE INCLUYE FUNCIÓN TOL PARA ROAMING>           */                
            } 

            break;
        case FACT_CICLO      :
        case FACT_BAJA       :
        case FACT_LIQUIDACION:
            if( iTipoFact == FACT_LIQUIDACION )
            {
                if( stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE)
                {
                    if( !bfnLeeAbonadosTOL(iTipoFact) )
                        return(FALSE);
                }
                else
                {
                    if( !bfnLeeAbonados (iTipoFact) )
                        return(FALSE);
                }
            }
            /*****************************************************************/
            /*  Los Abonados a Tasar, se carga en el interface's de Servicios*/
            /*****************************************************************/
            while( iCont < stCliente.iNumAbonados && bRes )
            {
                if( stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE)
                {
                    if( !bfnLee_TOL_Acumper(&(stCliente.pAbonados[iCont])) )
                        bRes = FALSE;
                }
                else
                {
                    if( !bfnLeeConceptos(&(stCliente.pAbonados[iCont])) )
                        bRes = FALSE;
                }
                if( bRes )
                {
                    iIndAlquiler = 0;

                    if( !bfnLeeConceptosCarriers (&stCliente.pAbonados[iCont],
                     stCliente.pAboRent,  iIndAlquiler) )
                        bRes = FALSE;
                    else
                        iCont++;
                }
            }

            break;
    }/* fin switch */

    if( bRes )
    {
        vfnPrintConcTarificacion ();
    }
    return(bRes);
}/************************ Final bIFTarificacion *****************************/

/*****************************************************************************/
/*                          funcion : bfnLeeAbonados                           */
/* -Funcion que carga los NumAbono de Ga_Infa% que cumplen las condiciones,de*/
/*  estar en las tablas de Ta_Acum%, dependiendo del producto iremos a unas  */
/*  tablas o a otras.                                                        */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnLeeAbonados(int iTipoFact)
{
    BOOL bRes = TRUE ;
    long lInd = 0    ;

    stCliente.pAbonados = (ABONTAR *)NULL;

    if( iTipoFact == FACT_BAJA||iTipoFact == FACT_LIQUIDACION )
    {
     /*******************************************************************/
     /* La estructura stAbonoCli solo tendra un abono-producto, que es  */
     /* el cual se da de baja o se liquida, es la unica diferencia.     */
     /*******************************************************************/
        if( !bfnCargaAbonadosCliente (&stAbonoCli.pCicloCli[0],iTipoFact) )
            return(FALSE);
    }
    else if( iTipoFact == FACT_CICLO )
    {
        while( lInd < stAbonoCli.lNumAbonados && bRes )
        {
            if( !bfnCargaAbonadosCliente(&stAbonoCli.pCicloCli[lInd],FACT_CICLO) )
                bRes = FALSE;
            else
                lInd++;
        }/* fin While lInd ... */
    }
    return(bRes);
}/*************************** Funcion bfnLeeAbonados *************************/

/*****************************************************************************/
/* -Funcion que carga los conceptos para un abonado (Ta_ConcepFact)          */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
static BOOL bfnLeeConceptos(ABONTAR* pAbon)
{
    int  iCont1= 0     ;

    int  iCodProducto=0;
    long lNumAbonado =0;

    CONCEPTO stConcepto;
    EST      stEstProc ;

    vDTrazasLog (szExeName,"\n\t\t* Entrada en bfnLeeConceptos", LOG05);

    memset (&stConcep  ,0,sizeof(CONCEP)) ;
    memset (&stConcepto,0,sizeof(CONCEPTO));
    memset (&stEstProc ,0,sizeof(EST))     ;

    lNumAbonado = pAbon->lNumAbonado ;
    iCodProducto= pAbon->iCodProducto;

    if( !bfnLeeAcumFraSoc(&stConcep, lNumAbonado, iCodProducto) )
    {
        iDError (szExeName,ERR005,vInsertarIncidencia,"bfnLeeAcumFraSoc");
        return(FALSE);

    }
    if( !bfnLeeAcumOper (&stConcep, lNumAbonado, iCodProducto) )
    {
        iDError (szExeName,ERR005,vInsertarIncidencia,"bfnLeeAcumOper");
        return(FALSE);

    }
    if( !bfnLeeAcumLlamadasRoa(&stConcep, lNumAbonado, iCodProducto) )
    {
        iDError (szExeName,ERR005,vInsertarIncidencia,"bfnLeeAcumLlamadasRoa");
        return(FALSE);

    }

    iCont1= 0;
    while( iCont1<NUM_TACONCEPFACT )
    {
        if( stConcep.stConcTar[iCont1].iCodProducto == pAbon->iCodProducto &&
            (stConcep.stConcTar[iCont1].iIndTabla == ROAMING  ||
             stConcep.stConcTar[iCont1].iIndTabla == ACUMOPER ||
             stConcep.stConcTar[iCont1].iIndTabla == FRASOC) )
        {
            if( (stConcep.stConcTar[iCont1].dImpConsumido >= 0.01) ||
                (pstParamGener.iConsConcTrafico == 1) )
            {
                if( !bfnValidacionConcTar (&stConcep.stConcTar[iCont1]) ) return(FALSE);
                if( (pAbon->pConcTar=
                     (CONCTAR *)realloc ( (CONCTAR *)pAbon->pConcTar,
                                          sizeof(CONCTAR)*(pAbon->iNumConcTar+1) ))==(CONCTAR *)NULL )
                {
                    iDError (szExeName,ERR005,vInsertarIncidencia,
                             "pAbon->pConcTar");
                    return(FALSE);
                }

                memcpy (&pAbon->pConcTar[pAbon->iNumConcTar],&stConcep.stConcTar[iCont1],
                        sizeof (CONCTAR));

                switch( stConcep.stConcTar[iCont1].iIndTabla )
                {
                    case FRASOC   : if( stConcep.stConcTar[iCont1].iIndEntSal == iENTRANTE )
                        {
                            stEstProc.iNumConcLocalEnt++     ;
                            stEstProc.dTotImpLocalEnt +=
                            stConcep.stConcTar[iCont1].dImpConsumido;
                        }
                        if( stConcep.stConcTar[iCont1].iIndEntSal == iSALIENTE )
                        {
                            stEstProc.iNumConcLocalSal++     ;
                            stEstProc.dTotImpLocalSal +=
                            stConcep.stConcTar[iCont1].dImpConsumido;
                        }
                        stEstProc.lSegTotLocal +=
                        stConcep.stConcTar[iCont1].lSegConsumido;
                        break;
                    case ACUMOPER : stEstProc.iNumConcOper++         ;
                        stEstProc.dTotImpOper   +=
                        stConcep.stConcTar[iCont1].dImpConsumido;
                        break                            ;
                    case ROAMING  : stEstProc.iNumConcRoaming++      ;
                        stEstProc.dTotImpRoaming+=
                        stConcep.stConcTar[iCont1].dImpConsumido;
                        break                            ;
                }/* fin switch */
                pAbon->iNumConcTar++;
            }/* fin if >= 0.0 .. */
        }/* if CodProducto ... */
        iCont1++;

    }/* fin while */
    vDTrazasLog (szExeName,
                 "\n\t\t* Estadisticas de Trafico para el Abonado :   [%ld]"
                 "\n\t\t=>Conceptos Trafico Local Entrante            [%d]"
                 "\n\t\t=>Importe Total Trafico Local Entrante (Pesos)[%.f]"
                 "\n\t\t=>Conceptos Trafico Local Saliente            [%d]"
                 "\n\t\t=>Importe Total Trafico Local Saliente (Pesos)[%.f]"
                 "\n\t\t=>Conceptos Trafico Larga Distancia           [%d]"
                 "\n\t\t=>Importe Total Trafico Larga Distancia(Pesos)[%.f]"
                 "\n\t\t=>Conceptos Trafico Roaming                   [%d]"
                 "\n\t\t=>Importe Total Trafico Roaming (Dolares)     [%.f]"
                 ,LOG03,pAbon->lNumAbonado, stEstProc.iNumConcLocalEnt,
                 stEstProc.dTotImpLocalEnt, stEstProc.iNumConcLocalSal,
                 stEstProc.dTotImpLocalSal, stEstProc.iNumConcOper    ,
                 stEstProc.dTotImpOper    , stEstProc.iNumConcRoaming ,
                 stEstProc.dTotImpRoaming);

    if( stProceso.iCodTipDocum == stDatosGener.iCodCiclo )
    {
        stPlanOptimo.lSegTotLocal += stEstProc.lSegTotLocal;
    }

    return(TRUE);
}/************************** Final bfnLeeConceptos ***************************/


/*****************************************************************************/
/*                          funcion : bfnValidacionCarrierTOL                */
/*****************************************************************************/
static BOOL bfnValidacionCarrierTOL (CONCTOL *pConcTol, CONCEPTO stConcepto)
{
	
    int iRes = 0;

	strcpy (pConcTol->szCodMoneda  ,stConcepto.szCodMoneda  );
	strcpy (pConcTol->szDesConcepto,stConcepto.szDesConcepto);
    
	pConcTol->ihCodCarg = pConcTol->iCodFacturacion;
    pConcTol->iIndCarrier = 1;
    pConcTol->iCodTipConce = stConcepto.iCodTipConce;

   	if( stConcepto.iCodTipConce == DESCUENTO )
   	{
   		 vDTrazasLog (szExeName,"\n\t\t* PGG - bfnValidacionCarrierTOL -  stConcepto.iCodTipConce	[%d]\n"
    	 			"\n\t\t* PGG - bfnValidacionCarrierTOL -  DESCUENTO	[%d]\n"	
					, LOG04 , stConcepto.iCodTipConce ,DESCUENTO);

        sprintf (stAnomProceso.szObsAnomalia,"Tipo de Concepto erroneo %d",
                 stConcepto.iCodTipConce);
        iRes = ERR001;
   	}
    if( iRes == 0 && stConcepto.iIndActivo == 0 )
    {
		vDTrazasLog (szExeName, "\n\t\t* PGG - bfnValidacionCarrierTOL -  stConcepto.iIndActivo	[%d]\n"    	 			
					, LOG04
					, stConcepto.iIndActivo);

		strcpy (stAnomProceso.szObsAnomalia,"Indice Activo = 0");
		iRes = ERR001;
	}
	if( iRes == 0 && pConcTol->dhMtoReal <= 0 )
	{
		vDTrazasLog (szExeName, "\n\t\t* PGG - bfnValidacionCarrierTOL -  pConcTol->dhMtoFact	[%f]\n"
					, LOG04
					, pConcTol->dhMtoFact);

		sprintf (stAnomProceso.szObsAnomalia,"Importe del concepto = %f",
		         pConcTol->dhMtoFact);
		iRes = ERR001;
	}
	if( iRes )
	{
	        stAnomProceso.lNumProceso  = stStatus.IdPro           ;
	        stAnomProceso.lCodCliente  = stCliente.lCodCliente    ;
	        stAnomProceso.iCodConcepto = pConcTol->iCodFacturacion;
	        stAnomProceso.iCodProducto = pConcTol->iCodProducto   ;
	        stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact     ;
	
	        strncpy (stAnomProceso.szDesProceso,"Tasacion-Carrier",
	                 sizeof (stAnomProceso.szDesProceso));

		if( iRes == ERR001 )
		{
		    iDError (szExeName,ERR001,vInsertarIncidencia,
		             stAnomProceso.iCodConcepto,
		             stConcepto.iIndActivo     ,
		             stConcepto.iCodTipConce   ,
		             pConcTol->dhMtoFact);
		}
   	}
    	return(iRes == 0)?TRUE:FALSE;
}/*************************** Final bfnValidacionCarrierTOL *********************/


/*****************************************************************************/
BOOL bfnCargaFaAcumFortas(long lNumAbonado)
{
    stACUMFORTAS	* paux = NULL;
    long    	iCantidad    = 0;
	int                        i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAX_FACTCARRIERS;
	int         iRetrievRows = MAX_FACTCARRIERS;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch ;
	    long	lhNumAbonado;
		int		ihIndAlquiler	[MAX_FACTCARRIERS];
		long	lhCodPeriodo	[MAX_FACTCARRIERS];
		int		ihCodOperador	[MAX_FACTCARRIERS];
		int		ihCodTipConce	[MAX_FACTCARRIERS];
		double	dhImpConsumido	[MAX_FACTCARRIERS];
		long	lhSegConsumido	[MAX_FACTCARRIERS];
		long	lhCodConcepto   [MAX_FACTCARRIERS];
/*INICIO 35499 CJG*/
		long  lhCodCiclFact      ; 
		static int ihzero;
/*FIN 35499 CJG*/
	/* EXEC SQL END DECLARE SECTION; */ 

	

	lhNumAbonado = lNumAbonado;
	lMaxFetch    = MAX_FACTCARRIERS;
/*INICIO 35499 CJG*/	
	lhCodCiclFact= stCiclo.lCodCiclFact;
	ihzero=0;
	vDTrazasLog(szExeName, "\n\t\t* Acumulados de trafico Carriers del Ciclo <= [%ld]\n",LOG03, stCiclo.lCodCiclFact);    
/*FIN 35499 CJG*/
	
    /* EXEC SQL DECLARE Cur_DinAcumFortas CURSOR FOR
		SELECT 
	    	   A.IND_ALQUILER,
	    	   A.COD_PERIODO,  
	    	   A.COD_OPERADOR,
	    	   A.COD_TIPCONCE,
			   X.COD_CONCEPTO,
	    	   SUM(IMP_CONSUMIDO), 
	    	   SUM(SEG_CONSUMIDO)
/o	    FROM   FA_ACUMFORTAS A, 35499 CJG o/
	     FROM   FA_ACUMFORTAS A, FA_CICLFACT B, /o35499 CJG o/
			   (SELECT P.COD_CONCFACT     COD_CONCEPTO, 
					   P.COD_CONCCARRIER  COD_OPERADOR, 
					   Q.COD_TIPCONCE     COD_TIPCONCE
				FROM   FA_FACTCARRIERS P, 
					   FA_CONCEPTOS Q
				WHERE  P.COD_CONCFACT = Q.COD_CONCEPTO) X
		WHERE  A.NUM_ABONADO  = :lhNumAbonado
/oINICIO 35499 CJG
          AND  A.COD_PERIODO  > 0o/
          AND  A.COD_PERIODO  = B.COD_CICLFACT
          AND B.FEC_EMISION <= (SELECT MAX(FEC_EMISION) FROM FA_CICLFACT WHERE COD_CICLFACT = :lhCodCiclFact)
          AND  B.IND_FACTURACION >:ihzero
/oFIN 35499 CJGo/
          AND  A.COD_CLIENTE  = :stCliente.lCodCliente
          AND  A.NUM_PROCESO  = 0
		  AND  A.COD_OPERADOR = X.COD_OPERADOR
		  AND  A.COD_TIPCONCE = X.COD_TIPCONCE
		GROUP BY A.IND_ALQUILER,
	    	     A.COD_PERIODO,  
	    	     A.COD_OPERADOR,
	    	     A.COD_TIPCONCE,
			     X.COD_CONCEPTO; */ 


    /* EXEC SQL OPEN Cur_DinAcumFortas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(stCliente.lCodCliente);
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


    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnCargaFaAcumFortas]OPEN Cur_DinAcumFortas", szfnORAerror ());
        return(FALSE);
    }	

    while (iFetchedRows == iRetrievRows)
    {

   		/* EXEC SQL for :lMaxFetch FETCH Cur_DinAcumFortas INTO
			:ihIndAlquiler, :lhCodPeriodo, :ihCodOperador, :ihCodTipConce, :lhCodConcepto, :dhImpConsumido, :lhSegConsumido; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )36;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihIndAlquiler;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)lhCodPeriodo;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )sizeof(long);
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)ihCodOperador;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )sizeof(int);
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)ihCodTipConce;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )sizeof(int);
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)lhCodConcepto;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[4] = (         int  )sizeof(long);
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)dhImpConsumido;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[5] = (         int  )sizeof(double);
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqharc[5] = (unsigned long  *)0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)lhSegConsumido;
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

 

		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {                
            paux = (stACUMFORTAS *) malloc(sizeof(stACUMFORTAS));
			paux->iIndAlquiler  = ihIndAlquiler	[i];
			paux->lCodPeriodo   = lhCodPeriodo	[i];
			paux->iCodOperador  = ihCodOperador	[i];
			paux->iCodTipConce  = ihCodTipConce	[i];
			paux->dImpConsumido = dhImpConsumido[i];
			paux->lSegConsumido = lhSegConsumido[i];
			paux->lCodConcepto  = lhCodConcepto [i];
			paux->iNomOrigen    = origFORTAS;
			paux->sgte          = lstACUMFORTAS;
			lstACUMFORTAS       = paux;
			iCantidad++;
		}
	}
	/* EXEC SQL CLOSE Cur_DinAcumFortas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )79;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	vDTrazasLog (szExeName,"\n\t\t* bfnCargaFaAcumFortas Abonado:[%ld] Registros:[%d]", LOG05, lNumAbonado, iCantidad);
	return TRUE;
}/************************* Final bfnCargaFaAcumFortas *************************/


/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
BOOL bfnCargaFaAcumForadi(long lNumAbonado)
{
    stACUMFORTAS	* paux = NULL;
    long    	iCantidad    = 0;
	int                        i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAX_FACTCARRIERS;
	int         iRetrievRows = MAX_FACTCARRIERS;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch ;
	    long	lhNumAbonado;
		int		ihIndAlquiler	[MAX_FACTCARRIERS];
		long	lhCodPeriodo	[MAX_FACTCARRIERS];
		int		ihCodOperador	[MAX_FACTCARRIERS];
		int		ihCodTipConce	[MAX_FACTCARRIERS];
		double	dhImpConsumido	[MAX_FACTCARRIERS];
		long	lhCodConcepto   [MAX_FACTCARRIERS];
	/* EXEC SQL END DECLARE SECTION; */ 


	lhNumAbonado = lNumAbonado;
	lMaxFetch    = MAX_FACTCARRIERS;
	
    /* EXEC SQL DECLARE Cur_DinAcumForadi CURSOR FOR
	    SELECT 
	    	   A.IND_ALQUILER,
	    	   A.COD_PERIODO,  
	    	   A.COD_OPERADOR,
	    	   A.COD_TIPCONCE,
			   X.COD_CONCEPTO,
	    	   SUM(IMP_CONSUMIDO)
	    FROM   FA_ACUMFORADI A,
			   (SELECT P.COD_CONCFACT     COD_CONCEPTO, 
					   P.COD_CONCCARRIER  COD_OPERADOR, 
					   Q.COD_TIPCONCE     COD_TIPCONCE
				FROM   FA_FACTCARRIERS P, 
					   FA_CONCEPTOS Q
				WHERE  P.COD_CONCFACT = Q.COD_CONCEPTO) X
		WHERE  A.NUM_ABONADO  = :lhNumAbonado
          AND  A.COD_PERIODO  > 0
          AND  A.COD_CLIENTE  = :stCliente.lCodCliente
          AND  A.NUM_PROCESO  = 0
		  AND  A.COD_OPERADOR = X.COD_OPERADOR
		  AND  A.COD_TIPCONCE = X.COD_TIPCONCE
		GROUP BY A.IND_ALQUILER,
	    	     A.COD_PERIODO,  
	    	     A.COD_OPERADOR,
	    	     A.COD_TIPCONCE,
			     X.COD_CONCEPTO; */ 


    /* EXEC SQL OPEN Cur_DinAcumForadi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )94;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&(stCliente.lCodCliente);
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


    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnCargaFaAcumForadi]OPEN Cur_DinAcumForadi", szfnORAerror ());
        return(FALSE);
    }	

    while (iFetchedRows == iRetrievRows)
    {

   		/* EXEC SQL for :lMaxFetch FETCH Cur_DinAcumForadi INTO
			:ihIndAlquiler, :lhCodPeriodo, :ihCodOperador, :ihCodTipConce, :lhCodConcepto, :dhImpConsumido; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )117;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihIndAlquiler;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)lhCodPeriodo;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )sizeof(long);
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)ihCodOperador;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )sizeof(int);
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)ihCodTipConce;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )sizeof(int);
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)lhCodConcepto;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[4] = (         int  )sizeof(long);
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)dhImpConsumido;
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

 

		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {                
            paux = (stACUMFORTAS *) malloc(sizeof(stACUMFORTAS));
			paux->iIndAlquiler  = ihIndAlquiler	[i];
			paux->lCodPeriodo   = lhCodPeriodo	[i];
			paux->iCodOperador  = ihCodOperador	[i];
			paux->iCodTipConce  = ihCodTipConce	[i];
			paux->dImpConsumido = dhImpConsumido[i];
			paux->lSegConsumido = 0;
			paux->lCodConcepto  = lhCodConcepto [i];
			paux->iNomOrigen    = origFORADI;
			paux->sgte          = lstACUMFORTAS;
			lstACUMFORTAS       = paux;
			iCantidad++;
		}
	}
	/* EXEC SQL CLOSE Cur_DinAcumForadi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )156;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	vDTrazasLog (szExeName,"\n\t\t* bfnCargaFaAcumForadi Abonado:[%ld] Registros:[%d]", LOG05, lNumAbonado, iCantidad);
	return TRUE;
}/************************* Final bfnCargaFaAcumForadi *************************/


/*****************************************************************************/
/*                          funcion : bfnLeeConceptosCarriers                */
/* -Funcion que carga los conceptos para un abonado (Fa_FactCarriers)        */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/* 20060420 FAR Se optimiza para evitar ir siempre a preguntar n-veces a la  */
/*              tabla de carrier, ahora sólo irá una vez por abonado.        */
/*              Sería Ideal cargar esto en MC, pero por la premura sólo se   */
/*              trabajará disminuyendo los ciclos.                           */
/*****************************************************************************/
static BOOL bfnLeeConceptosCarriers (ABONTAR* pAbon ,
                                     ABORENT* pARent,
                                     int      iIndAlquiler)
{
    CONCTAR  		stConcTar    ;
    CONCTOL  		stConcTol    ;	
    EST      		stEstProc    ;
	stACUMFORTAS 	* paux       ;
	CONCEPTO		stConcepto;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhNumAbonado;
		int	 ihCodProducto;
		long lhCodPeriodo;
		int	 ihCodOperador;
		int	 ihCodTipConce;
	/* EXEC SQL END DECLARE SECTION; */ 


    memset (&stConcTar ,0,sizeof(CONCTAR)) ;
    memset (&stConcTol ,0,sizeof(CONCTOL)) ;	
    memset (&stEstProc ,0,sizeof(EST))     ;
    memset (&stConcepto,0,sizeof(CONCEPTO));

    lstACUMFORTAS = NULL; /* PGG SOPORTE ITG 33968 7-09-2006 */

    stEstProc.dTotImpCarriers  = 0.00 ;
    stEstProc.iNumConcCarriers = 0    ;

	if( iIndAlquiler == 1 )
	{
		lhNumAbonado  = pARent->lNumAbonado      ;
		ihCodProducto = stDatosGener.iProdCelular;
	}
	else
	{
		lhNumAbonado  = pAbon->lNumAbonado ;
		ihCodProducto = pAbon->iCodProducto;
	}

    /* Se cargan los tráficos desde la tabla FA_ACUMFOTAS */
	if (!bfnCargaFaAcumFortas(lhNumAbonado))
	{
		vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Error Cargando tráficos desde Fa_Acumfortas abonado:[%ld] ", LOG05, lhNumAbonado);
		iDError(szExeName, ERR000, vInsertarIncidencia, "Error en Carga de Conceptos Carrier  bfnCargaFaAcumFortas", szfnORAerror());
		return FALSE;
	}

	if (!bfnCargaFaAcumForadi(lhNumAbonado))
	{
		vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Error Cargando tráficos desde Fa_Acumforadi abonado:[%ld] ", LOG05, lhNumAbonado);
		iDError(szExeName, ERR000, vInsertarIncidencia, "Error en Carga de Conceptos Carrier  bfnCargaFaAcumForadi", szfnORAerror());
		return FALSE;
	}		

	for(paux=lstACUMFORTAS; paux!=NULL; paux = paux->sgte)
	{

		/* valida tráfico de alquiler o contrato */
		if (iIndAlquiler != paux->iIndAlquiler)
		{
			vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Registro Abonado:[%ld] con distinto IndAlquiler (traf):[%d] (param):[%d] ", LOG05, lhNumAbonado, paux->iIndAlquiler, iIndAlquiler);
			continue;
		}	
		/* Se genera la estructura de facturación */
		if(stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE)
		{
			gliIndicadorCarrier = 1;
			memset (&stConcTol ,0,sizeof(CONCTOL)) ;
        
	        stConcTol.iCodFacturacion 	= paux->lCodConcepto;
	        stConcTol.dhMtoReal		    = paux->dImpConsumido;
	        stConcTol.dhMtoFact		    = paux->dImpConsumido; 
	        stConcTol.lhDurFact		    = paux->lSegConsumido; 
	        stConcTol.dhCntInicial		= 1;
	        stConcTol.lhNumProceso		= stStatus.IdPro ;
	        stConcTol.iCodOperador		= paux->iCodOperador;
	        stConcTol.lhNumAbonado      = lhNumAbonado;
	        stConcTol.iCodProducto      = ihCodProducto;
	        
			if( stConcTol.dhMtoReal >= 0.01 )		            
		    {
		    	if( !bFindConcepto (stConcTol.iCodFacturacion, &stConcepto) )
		            return(FALSE);
		    	
		    	if( !bfnValidacionCarrierTOL (&stConcTol, stConcepto) )
				{
					vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Validando Concepto Carrier Abonado:[%ld]", LOG05, lhNumAbonado);
					iDError(szExeName, ERR000, vInsertarIncidencia, "Validando Concepto Carrier", szfnORAerror());
		        	return(FALSE);
		        }
				if( iIndAlquiler == 0 )
		        {
		        	if( (pAbon->pConcTOL=(CONCTOL *)realloc((CONCTOL *)pAbon->pConcTOL, sizeof(CONCTOL)*(pAbon->iNumConcTOL+1) )) ==(CONCTOL *)NULL )
					{
						vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Reservando Memoria pAbon->pConcTOL", LOG05);
		            	iDError (szExeName,ERR005,vInsertarIncidencia, "Reservando Memoria para pAbon->pConcTOL");
		                return(FALSE);
					}
		                    
					memcpy (&pAbon->pConcTOL[pAbon->iNumConcTOL], &stConcTol, sizeof (CONCTOL));
					pAbon->iNumConcTOL++;
				}
		        else
		        {
                    if( (pARent->pConcTOL = (CONCTOL *)realloc ((CONCTOL *)pARent->pConcTOL, sizeof(CONCTOL)*(pARent->iNumConcTOL+1)))==(CONCTOL*)NULL )
                    {
						vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Reservando Memoria pARent->pConcTOL", LOG05);
                        iDError (szExeName,ERR005,vInsertarIncidencia, "Reservando Memoria para pARent->pConcTOL");
                        return(FALSE                );
                    }
					memcpy (&pARent->pConcTOL[pARent->iNumConcTOL], &stConcTol,sizeof(CONCTOL));
		            pARent->iNumConcTOL++;
				}
	            stEstProc.dTotImpCarriers  += stConcTol.dhMtoFact;
	            stEstProc.iNumConcCarriers += 1                  ;
	            ihCodTipConce               = paux->iCodTipConce ;
	            ihCodOperador 				= paux->iCodOperador ;
	            lhCodPeriodo  				= paux->lCodPeriodo  ;
	            /* Marca los registros procesados... */
                switch(paux->iNomOrigen)
				{
					case origFORTAS:
			            /* EXEC SQL UPDATE FA_ACUMFORTAS
		                SET NUM_PROCESO    = :stStatus.IdPro
		                WHERE NUM_ABONADO  = :lhNumAbonado
		                AND   IND_ALQUILER = :iIndAlquiler
		                AND   COD_PERIODO  = :lhCodPeriodo
		                AND   COD_OPERADOR = :ihCodOperador
		                AND   COD_TIPCONCE = :ihCodTipConce; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 7;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "update FA_ACUMFORTAS  set NUM_PROCESO=:b0 wher\
e ((((NUM_ABONADO=:b1 and IND_ALQUILER=:b2) and COD_PERIODO=:b3) and COD_OPERA\
DOR=:b4) and COD_TIPCONCE=:b5)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )171;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
               sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
               sqlstm.sqhstv[2] = (unsigned char  *)&iIndAlquiler;
               sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)&ihCodOperador;
               sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[4] = (         int  )0;
               sqlstm.sqindv[4] = (         short *)0;
               sqlstm.sqinds[4] = (         int  )0;
               sqlstm.sqharm[4] = (unsigned long )0;
               sqlstm.sqadto[4] = (unsigned short )0;
               sqlstm.sqtdso[4] = (unsigned short )0;
               sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipConce;
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


					
					    if( SQLCODE )
					    {
							vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Marca Conceptos de Trafico Procesados(FORTAS).\n\t%s", LOG05, szfnORAerror ());
					        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnLeeConceptosCarriers]Marca Conceptos de Trafico Procesados.", szfnORAerror ());
					        return(FALSE);
					    }
					    break;
					case origFORADI:
				
			            /* EXEC SQL UPDATE FA_ACUMFORADI
		                SET NUM_PROCESO    = :stStatus.IdPro
		                WHERE NUM_ABONADO  = :lhNumAbonado
		                AND   IND_ALQUILER = :iIndAlquiler
		                AND   COD_PERIODO  = :lhCodPeriodo
		                AND   COD_OPERADOR = :ihCodOperador
		                AND   COD_TIPCONCE = :ihCodTipConce; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 7;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "update FA_ACUMFORADI  set NUM_PROCESO=:b0 wher\
e ((((NUM_ABONADO=:b1 and IND_ALQUILER=:b2) and COD_PERIODO=:b3) and COD_OPERA\
DOR=:b4) and COD_TIPCONCE=:b5)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )210;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
               sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
               sqlstm.sqhstv[2] = (unsigned char  *)&iIndAlquiler;
               sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)&ihCodOperador;
               sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[4] = (         int  )0;
               sqlstm.sqindv[4] = (         short *)0;
               sqlstm.sqinds[4] = (         int  )0;
               sqlstm.sqharm[4] = (unsigned long )0;
               sqlstm.sqadto[4] = (unsigned short )0;
               sqlstm.sqtdso[4] = (unsigned short )0;
               sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipConce;
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


					
					    if( SQLCODE )
					    {
							vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Marca Conceptos de Trafico Procesados(FORADI).\n\t%s", LOG05, szfnORAerror ());
					        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnLeeConceptosCarriers]Marca Conceptos de Trafico Procesados.", szfnORAerror ());
					        return(FALSE);
					    }
						break;
					default:
						vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Origen de los registros no reconocido:[%d]", LOG05, paux->iNomOrigen);
				        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnLeeConceptosCarriers]Origen de los registros no reconocido[%d].", paux->iNomOrigen);
				        return(FALSE);
				}/* switch*/
			}/*( stConcTol.dhMtoReal >= 0.01 )*/	
		}
		else /* (stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE) */
		{
			stConcTar.lNumAbonado = lhNumAbonado      ;
			stConcTar.iCodProducto= ihCodProducto;

	        stConcTar.iCodFacturacion = paux->lCodConcepto     ;
	        stConcTar.dImpConsumido   = paux->dImpConsumido    ;
	        stConcTar.lSegConsumido   = paux->lSegConsumido    ;
	        stConcTar.lNumPulsos      = 0                      ;
	        stConcTar.lNumProceso     = stStatus.IdPro         ;
	        stConcTar.iCodOperador    = paux->iCodOperador     ;
	        stConcTar.iCodFranHoraSoc = 0                      ;
	        stConcTar.iIndEntSal      = 0                      ;
	        stConcTar.iIndTabla       = 0                      ;
	        stConcTar.iCarrier        = 0                      ;

			if( stConcTar.dImpConsumido >= 0.01 )
			{
		    	if( !bFindConcepto (stConcTar.iCodFacturacion, &stConcepto) )
		            return(FALSE);
		    	
		    	if( !bfnValidacionCarrier (&stConcTar, stConcepto) )
		        	return(FALSE);
				if( iIndAlquiler == 0 )
		        {
		        	if( (pAbon->pConcTar = (CONCTAR *)realloc((CONCTAR *)pAbon->pConcTar, sizeof(CONCTAR)*(pAbon->iNumConcTar+1) )) ==(CONCTAR *)NULL )
					{
		            	iDError (szExeName,ERR005,vInsertarIncidencia, "Reservando Memporia para pAbon->pConcTar");
						return(FALSE);
		            }
		            memcpy (&pAbon->pConcTar[pAbon->iNumConcTar],&stConcTar, sizeof (CONCTAR));
		            pAbon->iNumConcTar++;
				}
		        else
		        {
		        	if( (pARent->pConcTar = (CONCTAR *)realloc ((CONCTAR *)pARent->pConcTar, sizeof(CONCTAR)*(pARent->iNumConcTar+1))) ==(CONCTAR*)NULL )
					{
		            	iDError (szExeName,ERR005,vInsertarIncidencia,"Reservando Memoria para pARent->pConcTar");
						return(FALSE                );
					}
		            memcpy (&pARent->pConcTar[pARent->iNumConcTar],&stConcTar,sizeof(CONCTAR));
		            pARent->iNumConcTar++;
				}
                stEstProc.dTotImpCarriers  += stConcTar.dImpConsumido;
                stEstProc.iNumConcCarriers += 1                      ;
	            ihCodTipConce               = paux->iCodTipConce     ;
	            ihCodOperador 				= paux->iCodOperador     ;
	            lhCodPeriodo  				= paux->lCodPeriodo      ;
	            /* Marca los registros procesados... */
                switch(paux->iNomOrigen)
				{
					case origFORTAS:
			            /* EXEC SQL UPDATE FA_ACUMFORTAS
		                SET NUM_PROCESO    = :stStatus.IdPro
		                WHERE NUM_ABONADO  = :lhNumAbonado
		                AND   IND_ALQUILER = :iIndAlquiler
		                AND   COD_PERIODO  = :lhCodPeriodo
		                AND   COD_OPERADOR = :ihCodOperador
		                AND   COD_TIPCONCE = :ihCodTipConce; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 7;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "update FA_ACUMFORTAS  set NUM_PROCESO=:b0 wher\
e ((((NUM_ABONADO=:b1 and IND_ALQUILER=:b2) and COD_PERIODO=:b3) and COD_OPERA\
DOR=:b4) and COD_TIPCONCE=:b5)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )249;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
               sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
               sqlstm.sqhstv[2] = (unsigned char  *)&iIndAlquiler;
               sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)&ihCodOperador;
               sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[4] = (         int  )0;
               sqlstm.sqindv[4] = (         short *)0;
               sqlstm.sqinds[4] = (         int  )0;
               sqlstm.sqharm[4] = (unsigned long )0;
               sqlstm.sqadto[4] = (unsigned short )0;
               sqlstm.sqtdso[4] = (unsigned short )0;
               sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipConce;
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


					
					    if( SQLCODE )
					    {
							vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Marca Conceptos de Trafico Procesados(FORTAS).\n\t%s", LOG05, szfnORAerror ());
					        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnLeeConceptosCarriers]Marca Conceptos de Trafico Procesados.", szfnORAerror ());
					        return(FALSE);
					    }
					    break;
					case origFORADI:
				
			            /* EXEC SQL UPDATE FA_ACUMFORADI
		                SET NUM_PROCESO    = :stStatus.IdPro
		                WHERE NUM_ABONADO  = :lhNumAbonado
		                AND   IND_ALQUILER = :iIndAlquiler
		                AND   COD_PERIODO  = :lhCodPeriodo
		                AND   COD_OPERADOR = :ihCodOperador
		                AND   COD_TIPCONCE = :ihCodTipConce; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 7;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "update FA_ACUMFORADI  set NUM_PROCESO=:b0 wher\
e ((((NUM_ABONADO=:b1 and IND_ALQUILER=:b2) and COD_PERIODO=:b3) and COD_OPERA\
DOR=:b4) and COD_TIPCONCE=:b5)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )288;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
               sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
               sqlstm.sqhstv[2] = (unsigned char  *)&iIndAlquiler;
               sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)&ihCodOperador;
               sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[4] = (         int  )0;
               sqlstm.sqindv[4] = (         short *)0;
               sqlstm.sqinds[4] = (         int  )0;
               sqlstm.sqharm[4] = (unsigned long )0;
               sqlstm.sqadto[4] = (unsigned short )0;
               sqlstm.sqtdso[4] = (unsigned short )0;
               sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipConce;
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


					
					    if( SQLCODE )
					    {
							vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Marca Conceptos de Trafico Procesados(FORADI).\n\t%s", LOG05, szfnORAerror ());
					        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnLeeConceptosCarriers]Marca Conceptos de Trafico Procesados.", szfnORAerror ());
					        return(FALSE);
					    }
						break;
					default:
						vDTrazasLog (szExeName,"\n\t\t[bfnLeeConceptosCarriers] Origen de los registros no reconocido:[%d]", LOG05, paux->iNomOrigen);
				        iDError (szExeName,ERR000,vInsertarIncidencia,"[bfnLeeConceptosCarriers]Origen de los registros no reconocido[%d].", paux->iNomOrigen);
				        return(FALSE);
				}/* switch*/
	        }/* fin if dImpConsumido >= 0.01 */
		}/* (stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE) */

	}/* for()*/
    vDTrazasLog (szExeName,
                 "\n\t\t=>Conceptos Trafico Carriers                  [%d]"
                 "\n\t\t=>Importe Total Trafico Carriers              [%f]",LOG03,
                 stEstProc.iNumConcCarriers, stEstProc.dTotImpCarriers);

    return(TRUE);
	
}/************************** Final bfnLeeConceptosCarriers *******************/


/*****************************************************************************/
/*                        funcion : bfnLeeAcumOperAlq                        */
/* -Funcion que carga la informacion de consumos del Abonado y periodo en la */
/*  la tabla Ta_AcumOperAlq      .                                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnLeeAcumOperAlq (CONCTAR *pConcTar,
                               int      iCodTarificacion)
{
    static double dImpConsumido = 0.0;
    static long   lSegConsumido = 0  ;
    static long   lNumPulsos    = 0  ;

    /* EXEC SQL DECLARE Cur_AcumOperAlq CURSOR FOR
    SELECT /o+ index (TA_ACUMOPERALQ PK_TA_ACUMOPERALQ) o/
    IMP_CONSUMIDO,
    SEG_CONSUMIDO,
    NUM_PULSOS
    FROM   TA_ACUMOPERALQ
    WHERE  NUM_ABONADO     = :pConcTar->lNumAbonado
                             AND  NUM_ALQUILER    = :pConcTar->lNumAlquiler
                             AND  COD_OPERADOR    = :iCodTarificacion
                             AND  COD_CLIENTE     = :stCliente.lCodCliente
                             AND  NUM_PROCESO     = 0; */ 


    vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ta_AcumOperAlq\n"
                 "\t\t=> Num.Abonado      [%ld]\n"
                 "\t\t=> Cod.Cliente      [%ld]\n"
                 "\t\t=> Num.Alquiler     [%ld]\n"
                 "\t\t=> Cod.Tarificacion [%d] \n",LOG04,
                 pConcTar->lNumAbonado ,
                 stCliente.lCodCliente ,
                 pConcTar->lNumAlquiler,
                 iCodTarificacion);

    pConcTar->iCodOperador = iCodTarificacion;

    /* EXEC SQL OPEN Cur_AcumOperAlq; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )327;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(pConcTar->lNumAbonado);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pConcTar->lNumAlquiler);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iCodTarificacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(stCliente.lCodCliente);
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



    if( SQLCODE != SQLOK )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Open->Ta_AcumOperAlq",szfnORAerror());
        return(FALSE);
    }
    while( SQLCODE == SQLOK )
    {
        dImpConsumido = 0.0;
        lSegConsumido = 0  ;
        lNumPulsos    = 0  ;

        /* EXEC SQL FETCH Cur_AcumOperAlq INTO :dImpConsumido,
        :lSegConsumido,
        :lNumPulsos; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )358;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&dImpConsumido;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lSegConsumido;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lNumPulsos;
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


        if( SQLCODE == SQLOK )
        {
            pConcTar->dImpConsumido += dImpConsumido;
            pConcTar->lSegConsumido += lSegConsumido;
            pConcTar->lNumPulsos    += lNumPulsos   ;
        }
    }
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Fetch->Ta_AcumOperAlq",szfnORAerror());
        return(FALSE);
    }
    /* EXEC SQL CLOSE Cur_AcumOperAlq; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )385;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK )
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Close->Ta_AcumOperAlq",szfnORAerror());

    return(SQLCODE != SQLOK)?FALSE:TRUE;
}/************************** Final bfnAcumOperAlq ***************************/

/*****************************************************************************/
/*                    funcion : bfnLeeAcumAireFraSocAlq                      */
/* -Funcion que carga la informacion de consumos del Abonado y periodo en la */
/*  la tabla Ta_AcumAireFraSocAlq.                                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnLeeAcumAireFraSocAlq (CONCTAR *pConcTar,
                                     int      iCodTarificacion)
{
    static double dImpConsumido = 0.0;
    static long   lSegConsumido = 0  ;

    /* EXEC SQL DECLARE Cur_AcumAireAlq CURSOR FOR
    SELECT /o+ index (TA_ACUMAIREFRASOCALQ PK_TA_ACUMAIREFRASOCALQ) o/
    IMP_CONSUMIDO,
    SEG_CONSUMIDO
    FROM   TA_ACUMAIREFRASOCALQ
    WHERE  NUM_ABONADO     = :pConcTar->lNumAbonado
                             AND  NUM_ALQUILER    = :pConcTar->lNumAlquiler
                             AND  COD_FRANHORASOC = :iCodTarificacion
                             AND  IND_ENTSAL      = :pConcTar->iIndEntSal
                             AND  COD_CLIENTE     = :stCliente.lCodCliente
                             AND  NUM_PROCESO     = 0; */ 


    vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ta_AcumAireFraSocAlq\n"
                 "\t\t=> Num.Abonado      [%ld]\n"
                 "\t\t=> Cod.Cliente      [%ld]\n"
                 "\t\t=> Num.Alquiler     [%ld]\n"
                 "\t\t=> Ind.EntSal       [%d] \n"
                 "\t\t=> Cod.Tarificacion [%d] \n",LOG04,
                 pConcTar->lNumAbonado ,
                 stCliente.lCodCliente ,
                 pConcTar->lNumAlquiler,
                 pConcTar->iIndEntSal  ,
                 iCodTarificacion);

    pConcTar->iCodFranHoraSoc = iCodTarificacion;

    /* EXEC SQL OPEN Cur_AcumAireAlq; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0008;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )400;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(pConcTar->lNumAbonado);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pConcTar->lNumAlquiler);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iCodTarificacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(pConcTar->iIndEntSal);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&(stCliente.lCodCliente);
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



    if( SQLCODE != SQLOK )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Open->Ta_AcumAireFraSocAlq",szfnORAerror());
        return(FALSE);
    }
    while( SQLCODE == SQLOK )
    {
        dImpConsumido = 0.0;
        lSegConsumido = 0  ;

        /* EXEC SQL FETCH Cur_AcumAireAlq INTO :dImpConsumido,
        :lSegConsumido; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )435;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&dImpConsumido;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lSegConsumido;
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


        if( SQLCODE == SQLOK )
        {
            pConcTar->dImpConsumido += dImpConsumido;
            pConcTar->lSegConsumido += lSegConsumido;
        }
    }
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Fetch->Ta_AcumAireFraSocAlq",szfnORAerror());
        return(FALSE);
    }
    /* EXEC SQL CLOSE Cur_AcumAireAlq; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )458;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK )
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Close->Ta_AcumAireFraSocAlq",szfnORAerror());

    return(SQLCODE != SQLOK)?FALSE:TRUE;
}/************************** Final bfnAcumAireFraSocAlq **********************/

/*****************************************************************************/
/*                        funcion : bfnLeeConceptoRentPhone                  */
/* -Funcion que carga los Conceptos de Tarificacion para un Abonado          */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnLeeConceptosRentPhone (ABORENT *pAboRent)
{
    int  iCont = 0    ;

    BOOL bRes  = TRUE ;

    CONCTAR stConcTar ;
    CONCTAR stConcTar2;
    EST     stEstProc ;

    memset (&stEstProc ,0,sizeof(EST))    ;

    while( iCont<NUM_TACONCEPFACT && bRes )
    {
        if( pstTaConcepFact[iCont].iCodProducto==stDatosGener.iProdCelular &&
            (pstTaConcepFact[iCont].iIndTabla   == FRASOC                   ||
             pstTaConcepFact[iCont].iIndTabla   == ACUMOPER) )
        {
            memset (&stConcTar2,0,sizeof(CONCTAR));
            memset (&stConcTar ,0,sizeof(CONCTAR));

            stConcTar.iCodProducto    = stDatosGener.iProdCelular             ;
            stConcTar.lNumAbonado     = pAboRent->lNumAbonado                 ;
            stConcTar.lNumAlquiler    = pAboRent->lNumAlquiler                ;
            stConcTar.iCodFacturacion = pstTaConcepFact[iCont].iCodFacturacion;
            stConcTar.lNumProceso     = stStatus.IdPro                        ;
            stConcTar.iIndTabla       = pstTaConcepFact[iCont].iIndTabla      ;
            stConcTar.iIndEntSal      = pstTaConcepFact[iCont].iIndEntSal     ;

            switch( pstTaConcepFact [iCont].iIndTabla )
            {
                case FRASOC  :
                    bRes = bfnLeeAcumAireFraSocAlq (&stConcTar,
                                                    pstTaConcepFact[iCont].iCodTarificacion);
                    break;
                case ACUMOPER:
                    bRes = bfnLeeAcumOperAlq   (&stConcTar,
                                                pstTaConcepFact[iCont].iCodTarificacion);
                    break;
                default :
                    iDError (szExeName,ERR030,vInsertarIncidencia,
                             pstTaConcepFact [iCont].iIndTabla);
                    bRes = FALSE;
                    break       ;
            }
            if( bRes && stConcTar.dImpConsumido >= 0.01 )
            {
                if( !bfnValidacionConcTar (&stConcTar) )
                    bRes = FALSE;
                else
                {
                    if( (pAboRent->pConcTar =
                         (CONCTAR *)realloc ( (CONCTAR *)pAboRent->pConcTar,
                                              sizeof(CONCTAR)*(pAboRent->iNumConcTar+1) ))
                        == (CONCTAR *)NULL )
                    {
                        iDError (szExeName,ERR005,vInsertarIncidencia,
                                 "pAboRent->pConcTar");
                        return(FALSE                  );
                    }
                    memcpy (&pAboRent->pConcTar[pAboRent->iNumConcTar],
                            &stConcTar,sizeof(CONCTAR));
                    switch( pstTaConcepFact [iCont].iIndTabla )
                    {
                        case FRASOC  :
                            if( stConcTar.iIndEntSal == iENTRANTE )
                            {
                                stEstProc.iNumConcLocalEnt++     ;
                                stEstProc.dTotImpLocalEnt +=
                                stConcTar.dImpConsumido;
                            }
                            else if( stConcTar.iIndEntSal == iSALIENTE )
                            {
                                stEstProc.iNumConcLocalSal++     ;
                                stEstProc.dTotImpLocalSal +=
                                stConcTar.dImpConsumido;
                            }
                            break;
                        case ACUMOPER:
                            stEstProc.iNumConcOper++         ;
                            stEstProc.dTotImpOper +=
                            stConcTar.dImpConsumido;
                            break;
                    }
                    pAboRent->iNumConcTar++;

                }/* fin else Validacion ... */

            }/* fin if bRes ... */

        }/* fin if Producto ... */
        iCont++;

    }/* fin While ... */
    vDTrazasLog (szExeName,
                 "\n\t\t* Estadisticas de Trafico para el Abonado :   [%ld]"
                 "\n\t\t=>Conceptos Trafico Local Entrante            [%d]"
                 "\n\t\t=>Importe Total Trafico Local Entrante(Pesos) [%f]"
                 "\n\t\t=>Conceptos Trafico Local Saliente            [%d]"
                 "\n\t\t=>Importe Total Trafico Local Saliente(Pesos) [%f]"
                 "\n\t\t=>Conceptos Trafico Larga Distancia           [%d]"
                 "\n\t\t=>Importe Total Trafico Larga Distancia(Pesos)[%f]",LOG03,
                 pAboRent->lNumAbonado    , stEstProc.iNumConcLocalEnt,
                 stEstProc.dTotImpLocalEnt, stEstProc.iNumConcLocalSal,
                 stEstProc.dTotImpLocalSal, stEstProc.iNumConcOper    ,
                 stEstProc.dTotImpOper);

    return(bRes);
}/*********************** Final bfnLeeConceptosRentPhone *********************/

/*****************************************************************************/
/*                       funcion : bfnLeeConceptsRoamingVis                  */
/*****************************************************************************/
static BOOL bfnLeeConceptosRoamingVis (ABOROAVIS *pRoa)
{
    CONCTAR stConcTar;
    EST     stEstProc;

    BOOL bRes = TRUE ;
    int  iCont= 0    ;

    memset (&stEstProc,0,sizeof(EST));

    while( iCont<NUM_TACONCEPFACT && bRes )
    {
        if( pstTaConcepFact[iCont].iCodProducto     ==
            stDatosGener.iProdCelular                     &&
            pstTaConcepFact[iCont].iIndTabla        == 4  &&
            (pstTaConcepFact[iCont].iCodTarificacion == 0  ||
             pstTaConcepFact[iCont].iCodTarificacion == 1) )
        {
            memset (&stConcTar,0,sizeof(CONCTAR));

            stConcTar.iCodProducto    = stDatosGener.iProdCelular             ;
            stConcTar.lNumAbonado     = pRoa->lNumAbonado                     ;
            stConcTar.lNumEstaDia     = pRoa->lNumEstaDia                     ;
            stConcTar.iCodFacturacion = pstTaConcepFact[iCont].iCodFacturacion;
            stConcTar.lNumProceso     = stStatus.IdPro                        ;
            stConcTar.iIndTabla       = pstTaConcepFact[iCont].iIndTabla      ;

            bRes = bfnLeeAcumRoaming (&stConcTar,
                                      pstTaConcepFact[iCont].iCodTarificacion);

            if( bRes && stConcTar.dImpConsumido >= 0.01 )
            {
                if( !bfnValidacionConcTar (&stConcTar) )
                    bRes = FALSE;
                else
                {
                    if( (pRoa->pConcTar =
                         (CONCTAR *)realloc ( (CONCTAR *)pRoa->pConcTar,
                                              sizeof(CONCTAR)*(pRoa->iNumConcTar+1) ))
                        == (CONCTAR *)NULL )
                    {
                        iDError (szExeName,ERR005,vInsertarIncidencia,
                                 "pAboRent->pConcTar");
                        return(FALSE                  );
                    }
                    memcpy (&pRoa->pConcTar[pRoa->iNumConcTar],
                            &stConcTar,sizeof(CONCTAR));
                    stEstProc.iNumConcRoaming++        ;
                    stEstProc.dTotImpRoaming +=
                    stConcTar.dImpConsumido  ;
                    pRoa->iNumConcTar++                ;
                }

            }/* fin if bRes ... */

        }/* fin if Producto ... */
        iCont++;

    }/* fin While ... */
    vDTrazasLog (szExeName,
                 "\n\t\t* Estadisticas de Trafico para el Abonado :  [%ld]"
                 "\n\t\t=>Conceptos Trafico Roaming                  [%d] "
                 "\n\t\t=>Importe Total Trafico Roaming              [%f] ",LOG03,
                 pRoa->lNumAbonado     ,stEstProc.iNumConcRoaming  ,
                 stEstProc.dTotImpRoaming);
    if( stEstProc.dTotImpRoaming <= 0.0 )
    {
        bRes = FALSE;

        vDTrazasLog (szExeName,"\n\t* No Hay Conceptos a Facturar\n",LOG03);
        iDError (szExeName,ERR039,vInsertarIncidencia);
    }
    return(bRes);
}/************************ Final bfnLeeConceptosRoamingVis *******************/


/*****************************************************************************/
/*                         funcion : bLeeAcumFraSoc                          */
/* -Funcion que carga la informacion de consumo de la tabla Ta_Acum%FraSoc   */
/*  (Tarifas Locales).                                                       */
/* -Valores Retorno: Error->FALSE, !Error->TRUE                              */
/*****************************************************************************/
static BOOL bfnLeeAcumFraSoc( CONCEP *pstConcep, long lNumAbonado,int iCodProducto)
{
    BOOL   bRes           = FALSE;
    char   szNomTabla [30]= ""   ;
    char   szOperaOra [40]= ""   ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhRowid[19];
    static long   lhCodCliente     ;
    static long   lhNumAbonado     ;
    static long   lhCodCiclFact    ;
    static int    ihCodTarificacion;
    static double dhImpConsumido   ;
    static long   lhSegConsumido   ;
    static short  shIndEntSal      ;
    static short  shIndDestino     ;
    char   szCodServicio[6]          ;/* EXEC SQL VAR szCodServicio          IS STRING(5); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


   /*- Cursor para la suma de importes y segundos con las mismas condiciones -*/
   /*  nuevo campo a leer COD_SERVICIO NCONTRER 26-04-2002            */
    /* EXEC SQL DECLARE Cur_AcumAire CURSOR FOR
    SELECT ROWID            ,
    COD_CICLFACT     ,
    IMP_CONSUMIDO    ,
    SEG_CONSUMIDO    ,
    IND_ENTSAL       ,
    IND_DESTINO      ,
    COD_FRANHORASOC  ,
    COD_SERVICIO
    FROM   TA_ACUMAIREFRASOC
    WHERE  NUM_ABONADO     = :lhNumAbonado
                             AND  COD_CICLFACT    > 0
                             AND  COD_CLIENTE     = :lhCodCliente
                             AND  NUM_PROCESO     = 0; */ 


    /* EXEC SQL DECLARE Cur_AcumAireLiq CURSOR FOR
    SELECT IMP_CONSUMIDO    ,
    SEG_CONSUMIDO    ,
    IND_ENTSAL       ,
    IND_DESTINO      ,
    COD_FRANHORASOC  ,
    COD_SERVICIO
    FROM  TA_ACUMAIREFRASOC
    WHERE  NUM_ABONADO     = :lhNumAbonado
                             AND  COD_CLIENTE     = :lhCodCliente
                             AND  NUM_PROCESO     = 0; */ 


    lhCodCliente      = stCliente.lCodCliente;
    lhNumAbonado      = lNumAbonado          ;
    lhCodCiclFact     = 0                    ;
    dhImpConsumido    = 0.0                  ;
    lhSegConsumido    = 0                    ;

    vDTrazasLog (szExeName,
                 "\n\t\t* Parametros de Entrada Acumulados Trafico Local\n"
                 "\n\t\t=> Cod.Cliente     [%ld]"
                 "\n\t\t=> Num.Abonado     [%ld]"
                 , LOG05, stCliente.lCodCliente, lhNumAbonado);

    strcpy (szOperaOra,"Open->");

    if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
        /* EXEC SQL OPEN Cur_AcumAireLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0010;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )473;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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


    else
        /* EXEC SQL OPEN Cur_AcumAire; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0009;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )496;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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



    strcpy (szNomTabla,"Ta_AcumAireFraSoc");
    bRes = TRUE;

    if( !bRes )
    {
        iDError (szExeName,ERR003,vInsertarIncidencia,
                 iCodProducto);
        return(FALSE);
    }
    if( SQLCODE )
    {
        strcat (szOperaOra,szNomTabla);
        iDError (szExeName,ERR000,vInsertarIncidencia,szOperaOra,
                 szfnORAerror());
        return(FALSE);
    }
    strcpy (szOperaOra,"Fetch->") ;
    strcat (szOperaOra,szNomTabla);

    while( SQLCODE == SQLOK )
    {
        if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
            /* EXEC SQL FETCH Cur_AcumAireLiq INTO :dhImpConsumido ,
            :lhSegConsumido ,
            :shIndEntSal    ,
            :shIndDestino   ,
            :ihCodTarificacion,
            :szCodServicio; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )519;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&dhImpConsumido;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhSegConsumido;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&shIndEntSal;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&shIndDestino;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTarificacion;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szCodServicio;
            sqlstm.sqhstl[5] = (unsigned long )5;
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


        else
            /* EXEC SQL FETCH Cur_AcumAire INTO :szhRowid      ,    :lhCodCiclFact,
            :dhImpConsumido,    :lhSegConsumido,
            :shIndEntSal   ,    :shIndDestino,
            :ihCodTarificacion, :szCodServicio; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 8;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )558;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&dhImpConsumido;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhSegConsumido;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&shIndEntSal;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&shIndDestino;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&ihCodTarificacion;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szCodServicio;
            sqlstm.sqhstl[7] = (unsigned long )5;
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


        if( SQLCODE == SQLOK )
        {
            if( bBusca_Ciclo(lhCodCiclFact) == TRUE )
            {
                /* Busca codigo de tarificacion */
                if( bfnBuscaAcumCodTarif(pstConcep, lNumAbonado, ihCodTarificacion,
                                         lhSegConsumido, dhImpConsumido, 0, shIndEntSal,shIndDestino, 1,
                                         szCodServicio) )
                {
                    /* EXEC SQL UPDATE TA_ACUMAIREFRASOC
                    SET NUM_PROCESO = :stStatus.IdPro
                                      WHERE ROWID = :szhRowid; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 8;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "update TA_ACUMAIREFRASOC  set NUM_PROCESO\
=:b0 where ROWID=:b1";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )605;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
                    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
                    sqlstm.sqhstl[1] = (unsigned long )19;
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
        }
    }/* fin while */
    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,szOperaOra,szfnORAerror());
        return(FALSE);
    }
    if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
    {
        /* EXEC SQL CLOSE Cur_AcumAireLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )628;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {
        /* EXEC SQL CLOSE Cur_AcumAire; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )643;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    strcpy (szOperaOra,"Close->") ;
    strcpy (szOperaOra,szNomTabla);

    if( SQLCODE != 0 )
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 szOperaOra,szfnORAerror());
    return(SQLCODE != 0)?FALSE:TRUE;
}/************************* Final bLeeAcumFraSoc *****************************/

/*****************************************************************************/
/*                        funcion : bLeeAcumOper                             */
/* -Funcion que carga los importes , segundos y pulsos de las llamadas de    */
/*  larga distancia (Ta_AcumOper).                                           */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
static BOOL bfnLeeAcumOper (CONCEP *pstConcep, long lNumAbonado, int iCodProducto)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhRowid[19];
    static long   lhCodCliente     ;
    static long   lhNumAbonado     ;
    static long   lhCodCiclFact    ;
    static double dhImpConsumido   ;
    static long   lhSegConsumido   ;
    static long   lhNumPulsos      ;
    static int    ihCodOperador    ;
    char          szCodServicio[6] ;/* EXEC SQL VAR szCodServicio          IS STRING(5); */ 


    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName,
                 "\n\t\t* Parametros de Entrada Acumulados Larga Distancia"
                 "\n\t\t=> Cod.Cliente     [%ld]"
                 "\n\t\t=> Num.Abonado     [%ld]"
                 ,LOG05,stCliente.lCodCliente, lNumAbonado);

    strcpy(szCodServicio, " ");

    /*- Cursor para la suma de importes,segundos y pulsos -*/
    /* EXEC SQL DECLARE Cur_AcumOper CURSOR FOR
    SELECT /o+ index (TA_ACUMOPER PK_TA_ACUMOPER) o/
    ROWID, COD_CICLFACT, IMP_CONSUMIDO, SEG_CONSUMIDO,
    NUM_PULSOS, COD_OPERADOR
    FROM TA_ACUMOPER
    WHERE NUM_ABONADO   = :lhNumAbonado
                          AND COD_CICLFACT  > 0
                          AND COD_CLIENTE   = :lhCodCliente
                          AND NUM_PROCESO   = 0; */ 


    /* EXEC SQL DECLARE Cur_AcumOperLiq CURSOR FOR
    SELECT /o+ index (TA_ACUMOPER PK_TA_ACUMOPER) o/
    IMP_CONSUMIDO,SEG_CONSUMIDO,NUM_PULSOS,COD_OPERADOR
    FROM TA_ACUMOPER
    WHERE NUM_ABONADO   = :lhNumAbonado
                          AND COD_CLIENTE   = :lhCodCliente
                          AND NUM_PROCESO   = 0; */ 



    lhCodCliente      = stCliente.lCodCliente;
    lhNumAbonado      = lNumAbonado          ;
    dhImpConsumido    = 0.0                  ;
    lhSegConsumido    = 0                    ;
    lhNumPulsos       = 0                    ;

    if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
    {
        /* EXEC SQL OPEN Cur_AcumOperLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0013;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )658;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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
    else
    {
        /* EXEC SQL OPEN Cur_AcumOper   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0012;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )681;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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
    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ta_AcumOper",
                 szfnORAerror());
        return(FALSE);
    }
    while( SQLCODE == 0 )
    {
        if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
        {
            /* EXEC SQL FETCH Cur_AcumOperLiq
            INTO :dhImpConsumido, :lhSegConsumido,
            :lhNumPulsos   , :ihCodOperador; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 8;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )704;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&dhImpConsumido;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhSegConsumido;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhNumPulsos;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&ihCodOperador;
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


        }
        else
        {
            /* EXEC SQL FETCH Cur_AcumOper
            INTO :szhRowid,       :lhCodCiclFact, :dhImpConsumido,
            :lhSegConsumido, :lhNumPulsos  , :ihCodOperador; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 8;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )735;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&dhImpConsumido;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhSegConsumido;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&lhNumPulsos;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&ihCodOperador;
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
        if( SQLCODE == 0 )
        {
            if( bBusca_Ciclo(lhCodCiclFact) == TRUE )
            {
                bfnBuscaAcumCodTarif (pstConcep, lNumAbonado, ihCodOperador
                                      ,lhSegConsumido, dhImpConsumido
                                      ,lhNumPulsos, 0, 0, 2, szCodServicio);
                /* EXEC SQL UPDATE TA_ACUMOPER
                SET NUM_PROCESO = :stStatus.IdPro
                                  WHERE ROWID       = :szhRowid; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 8;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update TA_ACUMOPER  set NUM_PROCESO=:b0 where\
 ROWID=:b1";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )774;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
                sqlstm.sqhstl[1] = (unsigned long )19;
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
    }/* fin while */
    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ta_AcumOper",
                 szfnORAerror());
        return(FALSE);
    }
    if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
    {
        /* EXEC SQL CLOSE Cur_AcumOperLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )797;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {
        /* EXEC SQL CLOSE Cur_AcumOper   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )812;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    if( SQLCODE != 0 )
        iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ta_AcumOper",
                 szfnORAerror());
    return(SQLCODE != 0)?FALSE:TRUE;
}/*********************** Final bLeeAcumOper *********************************/

/*****************************************************************************/
/*                      funcion : bLeeAcumLlamadasRoa                        */
/* -Funcion que carga importes y segundos de la tabla Ta_AcumLlamadasRoa     */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
static BOOL bfnLeeAcumLlamadasRoa (CONCEP *pstConcep, long lNumAbonado, int iCodProducto )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhRowid[19];
    static long   lhCodCliente     ;
    static long   lhNumAbonado     ;
    static long   lhCodCiclFact    ;
    static int    ihCodTarificacion;
    static double dhImpConsumido   ;
    static long   lhSegConsumido   ;
    char    szCodServicio[6]         ;/* EXEC SQL VAR szCodServicio          IS STRING(5); */ 

    /* EXEC SQL END DECLARE SECTION; */ 



    vDTrazasLog (szExeName,
                 "\n\t\t* Parametros de Entrada Ta_AcumLlamadasRoa\n"
                 "\n\t\t=> Cod.Cliente [%ld]"
                 "\n\t\t=> Num.Abonado [%ld]",LOG05,
                 stCliente.lCodCliente, lNumAbonado);

   /*- Cursor para la suma de importes,segundos y pulsos -*/
    /* EXEC SQL DECLARE Cur_AcumLlamadas CURSOR FOR
    SELECT ROWID, COD_CICLFACT, IMP_CONSUMIDO, SEG_CONSUMIDO, COD_OPERADOR,0
    FROM TA_ACUMLLAMADASROA
    WHERE NUM_ABONADO   = :lhNumAbonado
                          AND COD_CICLFACT  > 0
                          AND COD_CLIENTE   = :lhCodCliente
                          AND NUM_PROCESO   = 0; */ 


    /* EXEC SQL DECLARE Cur_AcumLlamadasLiq CURSOR FOR
    SELECT /o+ index (TA_ACUMLLAMADASROA PK_TA_ACUMLLAMADASROA) o/
    IMP_CONSUMIDO,SEG_CONSUMIDO, COD_OPERADOR,0
    FROM TA_ACUMLLAMADASROA
    WHERE NUM_ABONADO   = :lhNumAbonado
                          AND COD_CLIENTE   = :lhCodCliente
                          AND NUM_PROCESO   = 0; */ 


    lhCodCliente      = stCliente.lCodCliente;
    lhNumAbonado      = lNumAbonado;
    dhImpConsumido    = 0.0                  ;
    lhSegConsumido    = 0                    ;

    if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
    {
        /* EXEC SQL OPEN Cur_AcumLlamadasLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0016;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )827;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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
    else
    {
        /* EXEC SQL OPEN Cur_AcumLlamadas   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0015;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )850;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
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
    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ta_AcumLlamadasRoa",
                 szfnORAerror());
        return(FALSE);
    }
    while( SQLCODE == 0 )
    {
        if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
        {
            /* EXEC SQL FETCH Cur_AcumLlamadasLiq
            INTO :dhImpConsumido,
            :lhSegConsumido,
            :ihCodTarificacion,
            :szCodServicio; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 8;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )873;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&dhImpConsumido;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhSegConsumido;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTarificacion;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szCodServicio;
            sqlstm.sqhstl[3] = (unsigned long )5;
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
        else
        {
            /* EXEC SQL FETCH Cur_AcumLlamadas
            INTO :szhRowid, :lhCodCiclFact,
            :dhImpConsumido, :lhSegConsumido,
            :ihCodTarificacion,
            :szCodServicio; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 8;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )904;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&dhImpConsumido;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhSegConsumido;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTarificacion;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szCodServicio;
            sqlstm.sqhstl[5] = (unsigned long )5;
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
        if( SQLCODE == 0 )
        {
            /*  Conversion de Dolar a Peso de Llamadas Roaming */
            /***************************************************/
            if( dhImpConsumido > 0.0 )                /*  Tiene Trafico Roaming  */
            {
                if( !bConversionMoneda (stCliente.lCodCliente      ,
                                        stDatosGener.szCodDollar   ,
                                        stDatosGener.szCodMoneFact ,
                                        stCiclo.szFecEmision       ,
                                       &dhImpConsumido             ))

                    return(FALSE); /* P-MIX-09003 4 */
            }
            if( bBusca_Ciclo(lhCodCiclFact) == TRUE )
            {
                strcpy(szCodServicio, " "); /* RAO12082002: se fuerza el codigo de servicio = " "*/
                if( bfnBuscaAcumCodTarif(pstConcep, lNumAbonado,
                                         ihCodTarificacion, lhSegConsumido,
                                         dhImpConsumido, 0, 0, 0,3,szCodServicio) )
                {
                    /* EXEC SQL UPDATE TA_ACUMLLAMADASROA
                    SET NUM_PROCESO = :stStatus.IdPro
                                      WHERE ROWID = :szhRowid; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 8;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "update TA_ACUMLLAMADASROA  set NUM_PROCES\
O=:b0 where ROWID=:b1";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )943;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
                    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
                    sqlstm.sqhstl[1] = (unsigned long )19;
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
        }
    }/* fin while */

    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Fetch->Ta_AcumLlamadasRoa",szfnORAerror());
        return(FALSE);
    }


    if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion )
    {
        /* EXEC SQL CLOSE Cur_AcumLlamadasLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )966;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {
        /* EXEC SQL CLOSE Cur_AcumLlamadas   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )981;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    if( SQLCODE != 0 )
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Close->Ta_AcumLlamadasRoa",szfnORAerror());

    vDTrazasLog (szExeName,
                 "\n\t\t* Salida de bfnLeeAcumLlamadasRoa\n"
                 "\n\t\t=> Cod.Cliente [%ld]"
                 "\n\t\t=> Cod.CiclFact[%ld]"
                 "\n\t\t=> Num.Abonado [%ld]"
                 ,LOG05, stCliente.lCodCliente
                 ,stCiclo.lCodCiclFact, lNumAbonado );

    return(SQLCODE != 0)?FALSE:TRUE;
}/**************************** bfnLeeAcumLlamadasRoa *************************/

/*****************************************************************************/
/*                      funcion : bfnLeeAcumRoaming                          */
/* -Funcion que acumula los Importes (Local y Larga Distancia) y segundos de */
/*  Roaming Visitante.                                                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnLeeAcumRoaming (CONCTAR *pConcTar,
                          int      iCodTarificacion)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static long   lhNumAbonado ;
    static long   lhNumEstaDia ;
    static long   lhSegConsAire;
    static long   lhSegConsOper;
    static double dhImpConsAire;
    static double dhImpConsOper;
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL DECLARE Cur_Roa CURSOR FOR
    SELECT /o+ index (TA_ACUMROAMING PK_TA_ACUMROAMING) o/
    IMP_CONSAIRE,
    IMP_CONSOPER,
    SEG_CONSAIRE,
    SEG_CONSOPER
    FROM   TA_ACUMROAMING
    WHERE  NUM_ABONADO = :lhNumAbonado
                         AND  NUM_ESTADIA = :lhNumEstaDia
                         AND  NUM_PROCESO = 0; */ 


    vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Ta_AcumRoaming"
                 "\n\t\t=> Num.Abonado      [%ld]"
                 "\n\t\t=> Num.EstaDia      [%ld]",LOG05,
                 pConcTar->lNumAbonado,pConcTar->lNumEstaDia);

    lhNumAbonado = pConcTar->lNumAbonado;
    lhNumEstaDia = pConcTar->lNumEstaDia;

    /* EXEC SQL OPEN Cur_Roa; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0018;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )996;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumEstaDia;
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


    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ta_AcumRoaming",
                 szfnORAerror());
        return(FALSE          );
    }
    while( SQLCODE == SQLOK )
    {
        dhImpConsAire = 0.0;
        dhImpConsOper = 0.0;
        lhSegConsAire = 0  ;
        lhSegConsOper = 0  ;

        /* EXEC SQL FETCH Cur_Roa INTO :dhImpConsAire,
        :dhImpConsOper,
        :lhSegConsAire,
        :lhSegConsOper; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1019;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhImpConsAire;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhImpConsOper;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhSegConsAire;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhSegConsOper;
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


        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                     "Fetch->Ta_AcumRoaming",szfnORAerror());
            return(FALSE                                   );
        }
        else
        {
            if( SQLCODE == SQLOK )
            {
                /* Llamadas Locales */
                if( iCodTarificacion == 0 )
                {
                    pConcTar->dImpConsumido += dhImpConsAire;
                    pConcTar->lSegConsumido += lhSegConsAire;
                }
                /* Llamadas Larga Distancia */
                else if( iCodTarificacion == 1 )
                {
                    pConcTar->dImpConsumido += dhImpConsOper;
                    pConcTar->lSegConsumido += lhSegConsOper;
                }

            }
        }
    }/* fin while */

    if( SQLCODE == SQLNOTFOUND )
    {
        if( !bConversionMoneda (stCliente.lCodCliente     ,
                                stDatosGener.szCodDollar  ,
                                stDatosGener.szCodMoneFact,
                                stCiclo.szFecEmision      ,
                               &pConcTar->dImpConsumido   ))
            return(FALSE); /* P-MIX-09003 4 */

        pConcTar->dImpConsumido = fnCnvDouble( pConcTar->dImpConsumido,USOFACT);
        /* EXEC SQL CLOSE Cur_Roa; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1050;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if( SQLCODE )
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                     "Close->Fa_AcumRoaming",szfnORAerror());
            return(FALSE                                  );
        }
    }
    return(TRUE);
}/************************ Final bfnLeeAcumRoaming ***************************/

/*****************************************************************************/
/*                        funcion : bEscribeAnoTar                           */
/*****************************************************************************/
static BOOL bfnEscribeAnoTar(CONCTAR *pReg)
{
    stAnomProceso.lNumProceso  = stStatus.IdPro        ;
    stAnomProceso.lCodCliente  = stCliente.lCodCliente ;
    stAnomProceso.iCodConcepto =  pReg->iCodFacturacion;
    stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact  ;
    stAnomProceso.iCodProducto = pReg->iCodProducto    ;

    strcpy (stAnomProceso.szDesProceso,"PreBilling de Tarificacion");

    return(TRUE);
}/************************* Final bEscribeAnoTar ****************************/

/*-------------------------------------------------------------------------- */
/*  bEMTarificacion (void)                                                   */
/*     Observacion    : La aplicacion de Plan Optimo solo ocurre en la Factu-*/
/*         racion de Ciclo y solo si el Plan Tarifario del Abonado coincide  */
/*         con el Plan Tarifario (Optimo) de Fa_DatosGener, ademas de depen- */
/*         de los minutos  Consumidos.                                       */
/*     Valores Retorno: FALSE - Error                                        */
/*                      TRUE  - Ningun Error                                 */
/*-------------------------------------------------------------------------- */
BOOL bfnEMTarificacion (int iTipoFact)
{
    int    iInd1         = 0    ;
    int    iInd2         = 0    ;
    int    i             = 0    ;
    int    iCarrier      = 0    ;
    int    iNumAbonados  = 0    ;
    int    iNumConcTar   = 0    ;
    BOOL   bError        = FALSE;
    double dTotMinLocales= 0    ; /* Minutos Consumidos en Llamadas Locales */

    ABORENT   *pTmpAboRent   = (ABORENT   *)NULL;
    ABONTAR   *pTmpAbon      = (ABONTAR   *)NULL;
    ABOROAVIS *pTmpAboRoaVis = (ABOROAVIS *)NULL;
    CONCTAR   *pTmpConcTar   = (CONCTAR   *)NULL;

    if( iTipoFact != FACT_ROAMINGVIS && iTipoFact != FACT_RENTAPHONE )
    {
        vDTrazasLog (szExeName,
                     "\n\t\t* Paso a Prefactura TARIFICACION \n"
                     "\t\t=> Cliente        [%ld]\n"
                     "\t\t=> Ciclo Factura  [%ld]\n"
                     "\t\t=> Numero Abonados[%d] \n",LOG05,stCliente.lCodCliente,
                     stCiclo.lCodCiclFact,stCliente.iNumAbonados);
        iNumAbonados = stCliente.iNumAbonados;

        if( iTipoFact == FACT_CICLO && (!strcmp (stCliente.szTipPlanTarif,"E") ||
                                        !strcmp (stCliente.szTipPlanTarif,"H") ) )
            dTotMinLocales = (double)stPlanOptimo.lSegTotLocal/60;
    }
    else if( iTipoFact == FACT_RENTAPHONE )
    {
        vDTrazasLog (szExeName,
                     "\n\t\t* Paso a PreFactura TRAFICO Local y Larga Distancia"
                     "\n\t\t=> Cod.Cliente [%ld]"
                     "\n\t\t=> Num.Abonado [%ld]"
                     "\n\t\t=> Num.Alquiler[%ld]",LOG05,
                     stCliente.lCodCliente             ,
                     stCliente.pAboRent[0].lNumAbonado ,
                     stCliente.pAboRent[0].lNumAlquiler);
        iNumAbonados = 1;
    }
    else if( iTipoFact == FACT_ROAMINGVIS )
    {
        vDTrazasLog (szExeName,
                     "\n\t\t* Paso a PreFactura TRAFICO Roaming Visitante"
                     "\n\t\t=> Cod.Cliente [%ld]"
                     "\n\t\t=> Num.Abonado [%ld]"
                     "\n\t\t=> Num.EstaDia [%ld]",LOG05,
                     stCliente.lCodCliente             ,
                     stCliente.pAboRoaVis->lNumAbonado ,
                     stCliente.pAboRoaVis->lNumEstaDia);
        iNumAbonados = 1;
    }
    
    for( iInd1=0;iInd1<iNumAbonados;iInd1++ )
    {
        if( iTipoFact != FACT_ROAMINGVIS && iTipoFact != FACT_RENTAPHONE )
        {
            pTmpAbon    = (ABONTAR *)&stCliente.pAbonados[iInd1];
            iNumConcTar = stCliente.pAbonados[iInd1].iNumConcTar;

            if( !strcmp (stCliente.szTipPlanTarif, "I") )
                dTotMinLocales =
                (double)dfnTotMinutosLocales (&stCliente.pAbonados[iInd1]);

            vDTrazasLog (szExeName,"\t\t* Abonado          : [%ld]\n"
                         "\t\t* Conceptos Tarif. : [%d] \n",LOG04,
                         pTmpAbon->lNumAbonado,pTmpAbon->iNumConcTar);
        }
        else if( iTipoFact == FACT_RENTAPHONE )
        {
            pTmpAboRent = (ABORENT *)stCliente.pAboRent     ;
            iNumConcTar =  stCliente.pAboRent[0].iNumConcTar;
            vDTrazasLog (szExeName,"\n\t\t* Abonado          : [%ld]"
		                           "\n\t\t* Conceptos Tarif. : [%d] ",LOG04,
		                           stCliente.pAboRent[0].lNumAbonado ,
		                           iNumConcTar);
        }
        else if( iTipoFact == FACT_ROAMINGVIS )
        {
            pTmpAboRoaVis = (ABOROAVIS *)stCliente.pAboRoaVis;
            iNumConcTar   = stCliente.pAboRoaVis->iNumConcTar;

            vDTrazasLog (szExeName,"\n\t\t* Abonado          : [%ld]"
		                           "\n\t\t* Conceptos Tarif. : [%d] ",LOG04,
		                           stCliente.pAboRoaVis->lNumAbonado ,
		                           iNumConcTar);

        }

        for( iInd2=0;iInd2<iNumConcTar;iInd2++ )
        {
            pTmpConcTar =
	            (iTipoFact == FACT_RENTAPHONE)?
	            (CONCTAR *)&pTmpAboRent->pConcTar  [iInd2]:
	            (iTipoFact == FACT_ROAMINGVIS)?
	            (CONCTAR *)&pTmpAboRoaVis->pConcTar[iInd2]:
	            (CONCTAR *)&pTmpAbon->pConcTar[iInd2]     ;

            vDTrazasLog (szExeName,"\t\t* Concepto  [%d]\n",LOG06,
                         pTmpConcTar->iCodFacturacion);

            if( (pTmpConcTar->dImpConsumido >= 0.01) || (pstParamGener.iConsConcTrafico == 1) )
            {
                /*if( stPreFactura.iNumRegistros >= MAX_CONCFACTUR )
                {
                    iDError (szExeName,ERR035,vInsertarIncidencia);
                    return(FALSE);
                }*/
                i = stPreFactura.iNumRegistros;
                
                
                stPreFactura.A_PFactura[i].bOptTrafico  = TRUE                 ;
                stPreFactura.A_PFactura[i].lNumProceso  = stStatus.IdPro       ;
                stPreFactura.A_PFactura[i].lCodCliente  = stCliente.lCodCliente;
                stPreFactura.A_PFactura[i].iCodConcepto = pTmpConcTar->iCodFacturacion;

                strcpy (stPreFactura.A_PFactura[i].szDesConcepto , pTmpConcTar->szDesConcepto);

                if( !bGetMaxColPreFa (stPreFactura.A_PFactura[i].iCodConcepto, &stPreFactura.A_PFactura[i].lColumna) )
                    return(FALSE);

                stPreFactura.A_PFactura[i].iCodProducto = pTmpConcTar->iCodProducto   ;

                strcpy (stPreFactura.A_PFactura[i].szFecEfectividad , szSysDate);

                if( stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion||
                    stProceso.iCodTipDocum == stDatosGener.iCodRentaPhone ||
                    stProceso.iCodTipDocum == stDatosGener.iCodRoamingVis )
                    strcpy (stPreFactura.A_PFactura[i].szFecValor , szSysDate);
                else
                    strcpy (stPreFactura.A_PFactura[i].szFecValor , stCiclo.szFecHastaLlam);
                            /* stCiclo.szFecEmision); */

                if( iTipoFact == FACT_CICLO && pTmpConcTar->iIndTabla == FRASOC )
                {
                    vfnAplicaPlanOptimo (pTmpConcTar, dTotMinLocales);
                }

                stPreFactura.A_PFactura[i].dImpConcepto   = pTmpConcTar->dImpConsumido;

                /* inc 43878 PPV 22/10/2007 */
                /*stPreFactura.A_PFactura.dImpFacturable[i] =
                fnCnvDouble(stPreFactura.A_PFactura.dImpConcepto [i], USOFACT) ; */

                stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble(stPreFactura.A_PFactura[i].dImpConcepto , 0) ;                
                                          
                stPreFactura.A_PFactura[i].dImpMontoBase  = 0.0       ;
                stPreFactura.A_PFactura[i].lSegConsumido  = pTmpConcTar->lSegConsumido;
                                          
                stPreFactura.A_PFactura[i].lCodPlanCom    = stCliente.lCodPlanCom  ;
                stPreFactura.A_PFactura[i].iIndFactur     = pTmpAbon->iIndFactur   ;
                stPreFactura.A_PFactura[i].iCodCatImpos   = stCliente.iCodCatImpos ;
                stPreFactura.A_PFactura[i].iCodPortador   = pTmpConcTar->iCodOperador;
                stPreFactura.A_PFactura[i].iIndEstado     = EST_NORMAL;
                stPreFactura.A_PFactura[i].lNumUnidades   = 1         ;
                stPreFactura.A_PFactura[i].iCodTipConce   = pTmpConcTar->iCodTipConce;
                                          
                stPreFactura.A_PFactura[i].lCodCiclFact   = stCiclo.lCodCiclFact   ;
                stPreFactura.A_PFactura[i].iCodConceRel   = 0         ;
                stPreFactura.A_PFactura[i].lColumnaRel    = 0         ;
                stPreFactura.A_PFactura[i].lNumAbonado    = pTmpConcTar->lNumAbonado;

                strcpy (stPreFactura.A_PFactura[i].szCodRegion   , stCliente.szCodRegion   );
                strcpy (stPreFactura.A_PFactura[i].szCodProvincia, stCliente.szCodProvincia);
                strcpy (stPreFactura.A_PFactura[i].szCodCiudad   , stCliente.szCodCiudad   );
                strcpy (stPreFactura.A_PFactura[i].szCodModulo   , "TA");
                strcpy (stPreFactura.A_PFactura[i].szCodMoneda   , pTmpConcTar->szCodMoneda);

                stPreFactura.A_PFactura[i].szNumTerminal[0] = 0;
                stPreFactura.A_PFactura[i].szNumSerieMec[0] = 0;
                stPreFactura.A_PFactura[i].szNumSerieLe [0] = 0;

                stPreFactura.A_PFactura[i].lCapCode        = ORA_NULL;
                stPreFactura.A_PFactura[i].iFlagImpues     = 0       ;
                stPreFactura.A_PFactura[i].iFlagDto        =  (stPreFactura.A_PFactura[i].iCodTipConce ==CARRIER)?0:1;

                if( !iCarrier && stPreFactura.A_PFactura[i].iCodTipConce  == CARRIER )
                    iCarrier = 1;

                stPreFactura.A_PFactura[i].fPrcImpuesto    = (stPreFactura.A_PFactura[i].iCodTipConce ==IMPUESTO)?stDatosGener.fPctIva:0.0;
                                          
                stPreFactura.A_PFactura[i].dValDto         = 0.0     ;
                stPreFactura.A_PFactura[i].iTipDto         = 0       ;
                stPreFactura.A_PFactura[i].lNumVenta       = 0       ;
                stPreFactura.A_PFactura[i].lNumTransaccion = 0       ;
                stPreFactura.A_PFactura[i].iMesGarantia    = 0       ;
                stPreFactura.A_PFactura[i].iIndAlta        = 0       ;
                stPreFactura.A_PFactura[i].iIndSuperTel    = 0       ;
                stPreFactura.A_PFactura[i].iNumPaquete     = 0       ;
                stPreFactura.A_PFactura[i].iIndCuota       = 0       ;
                stPreFactura.A_PFactura[i].iNumCuotas      = 0       ;
                stPreFactura.A_PFactura[i].iOrdCuota       = 0       ;

                vPrintRegInsert (i,"Trafico",bError);
                if(bfnIncrementarIndicePreFactura()==FALSE)
                {
                    vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                    vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                    return FALSE;
                }


            }/* fin if CodAnomalia ... */
            else
            {
                if( !bfnEscribeAnoTar (pTmpConcTar) )
                    return(FALSE);
            }

        }/* fin for iInd2 ... */

    }/* fin for iInd1 ... */

    

    if( iCarrier )
    	vfnRelacionCarrier ();

    return(TRUE);
}/*********************** Final bEMTarificacion ******************************/

/*****************************************************************************/
/*                            funcion : vfnRelacionCarrier                   */
/*****************************************************************************/
static void vfnRelacionCarrier ()
{
    int i = 0, j = 0;

    for( i=0;i<stPreFactura.iNumRegistros;i++ )
    {
        if( stPreFactura.A_PFactura[i].iFlagImpues  == 0     &&
            stPreFactura.A_PFactura[i].iCodTipConce == CARRIER )
        {
            for( j=0;j<stPreFactura.iNumRegistros;j++ )
            {
                if( stPreFactura.A_PFactura[j].iCodTipConce == IMPUESTO &&
                    stPreFactura.A_PFactura[i].lNumAbonado  ==
                    stPreFactura.A_PFactura[j].lNumAbonado              &&
                    stPreFactura.A_PFactura[i].iCodPortador ==
                    stPreFactura.A_PFactura[j].iCodPortador )
                {
                    stPreFactura.A_PFactura[i].iFlagImpues  =          1;
                    stPreFactura.A_PFactura[j].iCodConceRel =
                    stPreFactura.A_PFactura[i].iCodConcepto;
                    stPreFactura.A_PFactura[j].lColumnaRel  =
                    stPreFactura.A_PFactura[i].lColumna    ;
                    break;
                }
            }
        }
    }
}/***************************** Final vfnRelacionCarrier *********************/

/*****************************************************************************/
/*                            funcion : vFreeTarificacion                    */
/* -Funcion que libera la memoria de stCliente.pAbonados                     */
/*****************************************************************************/
void vfnFreeTarificacion(int iTipoFact)
{
    long lCont;

    if( iTipoFact == FACT_RENTAPHONE )
    {
        if( stCliente.pAboRent             != (ABORENT *)NULL &&
            stCliente.pAboRent[0].pConcTar != (CONCTAR *)NULL )
        {
            free (stCliente.pAboRent[0].pConcTar)              ;
            stCliente.pAboRent[0].pConcTar    = (CONCTAR *)NULL;
            stCliente.pAboRent[0].iNumConcTar = 0              ;
        }
        free (stCliente.pAboRent);
    }
    if( stCliente.pAbonados != (ABONTAR *)NULL )
    {
        for( lCont = 0;lCont < stCliente.iNumAbonados;lCont++ )
        {
            if( stCliente.pAbonados[lCont].pConcTar != (CONCTAR *)NULL )
            {
                free (stCliente.pAbonados[lCont].pConcTar)              ;
                stCliente.pAbonados[lCont].pConcTar    = (CONCTAR *)NULL;
                stCliente.pAbonados[lCont].iNumConcTar = 0              ;
            }
        }
        free(stCliente.pAbonados);
        stCliente.pAbonados = (ABONTAR *)NULL;
    }
    stCliente.iNumAbonados = 0;
}/************************ Final vFreeTarificacion ***************************/


/*****************************************************************************/
/*                        funcion : bfnCargaAbonadosCliente                    */
/* -Funcion que carga los abonados que estan en la tabla Ga_Infa%    que es- */
/*  tan en las distintas tablas de tarificacion .                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnCargaAbonadosCliente (CICLOCLI *pCicloCli,int iTipoFact)
{
    BOOL bRes = TRUE;

    vDTrazasLog (szExeName,"\n\t\t* Carga de Abonados con Trafico",LOG04);

    if( pCicloCli->iCodProducto == stDatosGener.iProdCelular )
        bRes =bfnCargaAbonadosCelular(pCicloCli,iTipoFact) ;
    else if( pCicloCli->iCodProducto == stDatosGener.iProdBeeper )
        bRes =bfnCargaAbonadosBeeper (pCicloCli,iTipoFact) ;
    else if( pCicloCli->iCodProducto != stDatosGener.iProdCelular &&
        	 pCicloCli->iCodProducto != stDatosGener.iProdBeeper  &&
        	 pCicloCli->iCodProducto != stDatosGener.iProdTrek    &&
        	 pCicloCli->iCodProducto != stDatosGener.iProdTrunk )
    {
        vDTrazasLog (szExeName,
                     "\n\t\t* Productos en Proceso[%d] "
                     "\n\t\t* Productos Celular   [%d] "
                     "\n\t\t* Productos Beeper    [%d] "
                     "\n\t\t* Productos Trek      [%d] " ,LOG04,
                     pCicloCli->iCodProducto , stDatosGener.iProdCelular,
                     stDatosGener.iProdBeeper, stDatosGener.iProdTrek);

        iDError (szExeName,ERR003,vInsertarIncidencia,
                 pCicloCli->iCodProducto);
        bRes = FALSE;
    }
    return(bRes);
}/*********************** Final bfnCargaAbonadosCliente **********************/


/*****************************************************************************/
/*                        funcion : bfnCargaAbonadosCelular                  */
/* -Funcion que carga los abonados de Ga_InfacCel que esten en Ta_Acum% y que*/
/*  verifican las restricciones.                                             */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static BOOL bfnCargaAbonadosCelular (CICLOCLI *pCicloCli,int iTipoFact)
{
    BOOL bRes = TRUE;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static char* szhRowid         ; /* EXEC SQL VAR szhRowid          IS STRING(19); */ 

    static long  lhCodCliente     ;
    static long  lhNumAbonado     ;
    static long  lhCodCiclFact    ;
    /* EXEC SQL END DECLARE SECTION; */ 


    if( iTipoFact == FACT_CICLO )
    {
        /* EXEC SQL DECLARE Cur_InfacCel CURSOR FOR
        SELECT /o+ index (GA_INFACCEL PK_GA_INFACCEL) o/
        ROWID, NUM_ABONADO
        FROM   GA_INFACCEL
        WHERE COD_CLIENTE   = :lhCodCliente
        AND NUM_ABONADO   = :lhNumAbonado
        AND COD_CICLFACT <= :lhCodCiclFact
        AND IND_FACTUR    = 1
        AND (EXISTS
           (SELECT /o+ index (TA_ACUMAIREFRASOC PK_TA_ACUMAIREFRASOC)o/
            NUM_ABONADO
            FROM   TA_ACUMAIREFRASOC
            WHERE  NUM_ABONADO   = :lhNumAbonado
            AND  COD_CICLFACT <= :lhCodCiclFact
            AND  COD_CLIENTE   = :lhCodCliente
            AND  NUM_PROCESO   = 0)
           OR
           EXISTS
           (SELECT /o+ index(TA_ACUMOPER PK_TA_ACUMOPER) o/
            NUM_ABONADO
            FROM   TA_ACUMOPER
            WHERE  NUM_ABONADO   = :lhNumAbonado
            AND  COD_CICLFACT <= :lhCodCiclFact
            AND  COD_CLIENTE   = :lhCodCliente
            AND  NUM_PROCESO   = 0)
           OR
           EXISTS
           (SELECT /o+ index(TA_ACUMLLAMADASROA PK_TA_ACUMLLAMADASROA)o/
            NUM_ABONADO
            FROM   TA_ACUMLLAMADASROA
            WHERE  NUM_ABONADO   = :lhNumAbonado
            AND  COD_CICLFACT <= :lhCodCiclFact
            AND  COD_CLIENTE   = :lhCodCliente
            AND  NUM_PROCESO   = 0) ); */ 

    }
    else if( iTipoFact == FACT_BAJA )
    {
        /* EXEC SQL DECLARE Cur_InfacCelBaja CURSOR FOR
        SELECT /o+ index (GA_INFACCEL PK_GA_INFACCEL) o/
        ROWID, NUM_ABONADO
        FROM   GA_INFACCEL
        WHERE COD_CLIENTE = :lhCodCliente
        AND NUM_ABONADO = :lhNumAbonado
        AND COD_CICLFACT= :lhCodCiclFact
        AND IND_FACTUR  = 1
        AND (EXISTS
             (SELECT /o+ index (TA_ACUMAIREFRASOC PK_TA_ACUMAIREFRASOC)o/
              NUM_ABONADO
              FROM   TA_ACUMAIREFRASOC
              WHERE  NUM_ABONADO   = :lhNumAbonado
              AND  COD_CICLFACT  = :lhCodCiclFact
              AND  COD_CLIENTE   = :lhCodCliente
              AND  NUM_PROCESO   = 0)
             OR
             EXISTS
             (SELECT /o+ index(TA_ACUMOPER PK_TA_ACUMOPER) o/
              NUM_ABONADO
              FROM   TA_ACUMOPER
              WHERE  NUM_ABONADO   = :lhNumAbonado
              AND  COD_CICLFACT  = :lhCodCiclFact
              AND  COD_CLIENTE   = :lhCodCliente
              AND  NUM_PROCESO   = 0)
             OR
             EXISTS
             (SELECT /o+ index(TA_ACUMLLAMADASROA PK_TA_ACUMLLAMADASROA)o/
              NUM_ABONADO
              FROM   TA_ACUMLLAMADASROA
              WHERE  COD_CICLFACT  = :lhCodCiclFact
              AND  NUM_ABONADO   = :lhNumAbonado
              AND  COD_CLIENTE   = :lhCodCliente
              AND  NUM_PROCESO   = 0) ); */ 

    }
    else if( iTipoFact == FACT_LIQUIDACION )
    {
        /* EXEC SQL DECLARE Cur_InfacCelLiq CURSOR FOR
        SELECT /o+ index (GA_INFACCEL PK_GA_INFACCEL) o/
        ROWID, NUM_ABONADO
        FROM   GA_INFACCEL
        WHERE COD_CLIENTE = :lhCodCliente
        AND NUM_ABONADO = :lhNumAbonado
        AND FEC_BAJA   <= TO_DATE (:szSysDate,'YYYYMMDDHH24MISS')
        AND IND_FACTUR  = 1
        AND (EXISTS
           (SELECT /o+ index (TA_ACUMAIREFRASOC PK_TA_ACUMAIREFRASOC)o/
            NUM_ABONADO
            FROM   TA_ACUMAIREFRASOC
            WHERE  NUM_ABONADO   = :lhNumAbonado
            AND  COD_CLIENTE   = :lhCodCliente
            AND  NUM_PROCESO   = 0)
           OR
           EXISTS
           (SELECT /o+ index(TA_ACUMOPER PK_TA_ACUMOPER) o/
            NUM_ABONADO
            FROM   TA_ACUMOPER
            WHERE  NUM_ABONADO  = :lhNumAbonado
            AND  COD_CLIENTE  = :lhCodCliente
            AND  NUM_PROCESO  = 0)
           OR
           EXISTS
           (SELECT /o+ index(TA_ACUMLLAMADASROA PK_TA_ACUMLLAMADASROA)o/
            NUM_ABONADO
            FROM   TA_ACUMLLAMADASROA
            WHERE  NUM_ABONADO  = :lhNumAbonado
            AND  COD_CLIENTE  = :lhCodCliente
            AND  NUM_PROCESO  = 0) ); */ 

    }

    vDTrazasLog (szExeName,
                 "\n\t\t* Parametros de Entrada Carga Abonados Celular con Trafico "
                 "\n\t\t=> Cliente     [%ld]"
                 "\n\t\t=> Num.Abonado [%ld]"
                 "\n\t\t=> Cod.CiclFact[%ld]",LOG04,
                 stCliente.lCodCliente,pCicloCli->lNumAbonado,
                 stCiclo.lCodCiclFact);

    lhCodCiclFact = stCiclo.lCodCiclFact  ;
    lhCodCliente  = stCliente.lCodCliente ;
    lhNumAbonado  = pCicloCli->lNumAbonado;

    if( iTipoFact == FACT_CICLO )
    {
        /* EXEC SQL OPEN Cur_InfacCel; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0019;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1065;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
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


    }
    else if( iTipoFact == FACT_BAJA )
    {
        /* EXEC SQL OPEN Cur_InfacCelBaja; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0020;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1128;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
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


    }
    else if( iTipoFact == FACT_LIQUIDACION )
    {
        /* EXEC SQL OPEN Cur_InfacCelLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0021;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1191;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szSysDate;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[5] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
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


    }
    
    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ga_InfacCel",
                 szfnORAerror());
        return(FALSE);
    }
    while( bRes )
    {
        if( (stCliente.pAbonados =
             (ABONTAR *)realloc ((ABONTAR *)stCliente.pAbonados,
                                 sizeof(ABONTAR)*(stCliente.iNumAbonados+1)))==(ABONTAR *)NULL )
        {
            iDError (szExeName,ERR005,vInsertarIncidencia,
                     "stCliente.pAbonados",szfnORAerror());
            return(FALSE);
        }
        memset(&stCliente.pAbonados[stCliente.iNumAbonados],0,sizeof(ABONTAR));

        szhRowid = stCliente.pAbonados[stCliente.iNumAbonados].szRowid;

        if( iTipoFact == FACT_CICLO )
            /* EXEC SQL FETCH Cur_InfacCel INTO :szhRowid, :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1242;
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


        else if( iTipoFact == FACT_BAJA )
            /* EXEC SQL FETCH Cur_InfacCelBaja INTO :szhRowid, :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1265;
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


        else if( iTipoFact == FACT_LIQUIDACION )
            /* EXEC SQL FETCH Cur_InfacCelLiq INTO :szhRowid, :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1288;
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



        switch( SQLCODE )
        {
            case SQLOK :
                stCliente.pAbonados[stCliente.iNumAbonados].lNumAbonado =
                lhNumAbonado   ;
                stCliente.pAbonados[stCliente.iNumAbonados].iCodProducto=
                pCicloCli->iCodProducto;
                stCliente.pAbonados[stCliente.iNumAbonados].iNumConcTar = 0;

                stCliente.pAbonados[stCliente.iNumAbonados].pConcTar =
                (CONCTAR *)NULL;
                stCliente.iNumAbonados++;

                break;
            case SQLNOTFOUND:
                bRes = FALSE;
                break;
            default:
                iDError (szExeName,ERR000,vInsertarIncidencia,
                         "Fetch->Ga_InfacCel",szfnORAerror());
                bRes = FALSE;
                break;
        }
    }/* fin while */
    if( SQLCODE == SQLNOTFOUND )
    {
        if( iTipoFact == FACT_CICLO )
            /* EXEC SQL CLOSE Cur_InfacCel; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1311;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        else if( iTipoFact == FACT_BAJA )
            /* EXEC SQL CLOSE Cur_InfacCelBaja; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1326;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        else if( iTipoFact == FACT_LIQUIDACION )
            /* EXEC SQL CLOSE Cur_InfacCelLiq; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1341;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if( SQLCODE )
            iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ga_InfacCel",
                     szfnORAerror());
    }
    vDTrazasLog (szExeName,"\n\t\t* Abonados Cargados Celular [%d]",LOG04,
                 stCliente.iNumAbonados);
    return(SQLCODE == SQLOK)?TRUE:FALSE;
}/************************ Final bfnCargaAbonadosCelular *********************/


/*****************************************************************************/
/*                          funcion : iCargaAbonadosBeeper                   */
/* -Funcion que carga el NumAbonado de la tabla Ga_InfaBeeper si verifica las*/
/*  las restricciones.                                                       */
/* -Valores Retorno :SQLCODE                                                 */
/*****************************************************************************/
static BOOL bfnCargaAbonadosBeeper (CICLOCLI *pCicloCli,int iTipoFact)
{
    BOOL bRes = TRUE;


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static char* szhRowid         ; /* EXEC SQL VAR szhRowid          IS STRING(19); */ 

    static long  lhCodCliente     ;
    static long  lhNumAbonado     ;
    static long  lhCodCiclFact    ;
    /* EXEC SQL END   DECLARE SECTION; */ 



    if( iTipoFact == FACT_CICLO )
    {
        /* EXEC SQL DECLARE Cur_InfacBeep CURSOR FOR
        SELECT /o+ index (GA_INFACBEEP PK_GA_INFACBEEP) o/
        ROWID, NUM_ABONADO
        FROM   GA_INFACBEEP
        WHERE COD_CLIENTE  = :lhCodCliente
                             AND NUM_ABONADO  = :lhNumAbonado
                             AND COD_CICLFACT<= :lhCodCiclFact
                             AND IND_FACTUR   = 1
                             AND (EXISTS
                                  (SELECT /o+ index(TA_ACUMBEEPFRASOC PK_TA_ACUMBEEPFRASOC)o/
                                   NUM_ABONADO
                                   FROM   TA_ACUMBEEPFRASOC
                                   WHERE  NUM_ABONADO  = :lhNumAbonado
                                   AND  COD_CICLFACT<= :lhCodCiclFact
                                   AND  COD_CLIENTE  = :lhCodCliente
                                   AND  NUM_PROCESO  = 0) ); */ 

    }
    else if( iTipoFact == FACT_BAJA )
    {
        /* EXEC SQL DECLARE Cur_InfacBeepBaja CURSOR FOR
        SELECT /o+ index (GA_INFACBEEP PK_GA_INFACBEEP) o/
        ROWID, NUM_ABONADO
        FROM   GA_INFACBEEP
        WHERE COD_CLIENTE  = :lhCodCliente
                             AND NUM_ABONADO  = :lhNumAbonado
                             AND COD_CICLFACT = :lhCodCiclFact
                             AND IND_FACTUR   = 1
                             AND (EXISTS
                                  (SELECT /o+ index(TA_ACUMBEEPFRASOC PK_TA_ACUMBEEPFRASOC)o/
                                   NUM_ABONADO
                                   FROM   TA_ACUMBEEPFRASOC
                                   WHERE  NUM_ABONADO  = :lhNumAbonado
                                   AND  COD_CICLFACT = :lhCodCiclFact
                                   AND  COD_CLIENTE  = :lhCodCliente
                                   AND  NUM_PROCESO  = 0) ); */ 


    }
    else if( iTipoFact == FACT_LIQUIDACION )
    {
        /* EXEC SQL DECLARE Cur_InfacBeepLiq CURSOR FOR
        SELECT /o+ index (GA_INFACBEEP PK_GA_INFACBEEP) o/
        ROWID, NUM_ABONADO
        FROM   GA_INFACBEEP
        WHERE COD_CLIENTE  = :lhCodCliente
                             AND NUM_ABONADO  = :lhNumAbonado
                             AND IND_FACTUR   = 1
                             AND (EXISTS
                                  (SELECT /o+ index(TA_ACUMBEEPFRASOC PK_TA_ACUMBEEPFRASOC)o/
                                   NUM_ABONADO
                                   FROM   TA_ACUMBEEPFRASOC
                                   WHERE  NUM_ABONADO  = :lhNumAbonado
                                   AND  COD_CLIENTE  = :lhCodCliente
                                   AND  NUM_PROCESO  = 0) ); */ 

    }
    vDTrazasLog (szExeName,
                 "\n\t\t* Parametros de Entrada Carga Abonados Beeper con Trafico"
                 "\n\t\t=> Cliente     [%ld]\n"
                 "\n\t\t=> Num.Abonado [%ld]\n"
                 "\n\t\t=> Cod.CiclFact[%ld]\n",LOG04,
                 stCliente.lCodCliente,pCicloCli->lNumAbonado,
                 stCiclo.lCodCiclFact);


    lhCodCliente  = stCliente.lCodCliente ;
    lhNumAbonado  = pCicloCli->lNumAbonado;
    lhCodCiclFact = stCiclo.lCodCiclFact  ;

    if( iTipoFact == FACT_CICLO )
    {
        /* EXEC SQL OPEN Cur_InfacBeep; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0022;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1356;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
    else if( iTipoFact == FACT_BAJA )
    {
        /* EXEC SQL OPEN Cur_InfacBeepBaja; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0023;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1395;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
    else if( iTipoFact == FACT_LIQUIDACION )
    {
        /* EXEC SQL OPEN Cur_InfacBeepLiq; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0024;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1434;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
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

    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ga_InfacBeep",
                 szfnORAerror());
        return(FALSE);
    }
    while( bRes )
    {
        if( (stCliente.pAbonados =
             (ABONTAR *)realloc ((ABONTAR *)stCliente.pAbonados,
                                 sizeof(ABONTAR)*(stCliente.iNumAbonados+1)))==(ABONTAR *)NULL )
        {
            iDError (szExeName,ERR005,vInsertarIncidencia,
                     "stCliente.pAbonados",szfnORAerror());
            return(FALSE);
        }
        memset (&stCliente.pAbonados[stCliente.iNumAbonados],0,sizeof(ABONTAR));

        szhRowid = stCliente.pAbonados[stCliente.iNumAbonados].szRowid;
        if( iTipoFact == FACT_CICLO )
            /* EXEC SQL FETCH Cur_InfacBeep INTO :szhRowid,:lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1465;
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


        else if( iTipoFact == FACT_BAJA )
            /* EXEC SQL FETCH Cur_InfacBeepBaja INTO :szhRowid, :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1488;
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


        else if( iTipoFact == FACT_LIQUIDACION )
            /* EXEC SQL FETCH Cur_InfacBeepLiq  INTO :szhRowid, :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1511;
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



        switch( SQLCODE )
        {
            case SQLOK:
                stCliente.pAbonados[stCliente.iNumAbonados].lNumAbonado =
                lhNumAbonado   ;
                stCliente.pAbonados[stCliente.iNumAbonados].iCodProducto=
                pCicloCli->iCodProducto;
                stCliente.pAbonados[stCliente.iNumAbonados].iNumConcTar = 0;

                stCliente.pAbonados[stCliente.iNumAbonados].pConcTar =
                (CONCTAR *)NULL;
                stCliente.iNumAbonados++;

                break;
            case SQLNOTFOUND:
                bRes = FALSE;
                break;
            default :
                iDError (szExeName,ERR000,vInsertarIncidencia,
                         "Fetch->Ga_InfacBeep",szfnORAerror());
                bRes = FALSE;
                break;
        }
    }/* fin while*/
    if( SQLCODE == SQLNOTFOUND )
    {
        if( iTipoFact == FACT_CICLO )
            /* EXEC SQL CLOSE Cur_InfacBeep; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1534;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        else if( iTipoFact == FACT_BAJA )
            /* EXEC SQL CLOSE Cur_InfacBeepBaja; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1549;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        else if( iTipoFact == FACT_LIQUIDACION )
            /* EXEC SQL CLOSE Cur_InfacBeepLiq; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1564;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if( SQLCODE )
            iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ga_InfacBeep",
                     szfnORAerror());
    }
    return(SQLCODE == SQLOK)?TRUE:FALSE;

}/************************* Final bfnCargaAbonadosBeeper *********************/



/*****************************************************************************/
/*                           funcion : vPrintConcTar                         */
/*****************************************************************************/
static void vfnPrintConcTarificacion (void)
{
    int  iCon1 = 0;
    int  iCon2 = 0;
    int  iNumConcTar  = 0;

    if (stStatus.LogNivel >= LOG05)
    {

	    vDTrazasLog (szExeName,"\n\t\t* Conceptos de Tarificacion Cargados ",
	                 LOG05);
	    for( iCon1=0;iCon1<stCliente.iNumAbonados;iCon1++ )
	    {
	       iNumConcTar = stCliente.pAbonados[iCon1].iNumConcTar;
	       vDTrazasLog (szExeName, "\t\t=>Abonado [%ld] Numero Conceptos Tarif.[%d]",LOG05,
	                               stCliente.pAbonados[iCon1].lNumAbonado,
	                               stCliente.pAbonados[iCon1].iNumConcTar);
	        for( iCon2=0;iCon2<iNumConcTar;iCon2++ )
	        {
	            vDTrazasLog (szExeName,"\n\t\t[%d]-Cod.Facturacion.......[%d] "
	            					   "\n\t\t[%d]-Ind.Tabla.............[%d] "
	            					   "\n\t\t[%d]-Imp.Consumido.........[%lf]"
	            					   "\n\t\t[%d]-Segundos Consumidos...[%ld]"
	            					   "\n\t\t[%d]-Numero de Pulsos......[%ld]"
	            					   "\n\t\t[%d]-Cod.FranHoraSoc.......[%d] "
	            					   "\n\t\t[%d]-Cod.Operador..........[%d] "
	            					   ,LOG05
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].iCodFacturacion
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].iIndTabla
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].dImpConsumido
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].lSegConsumido
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].lNumPulsos
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].iCodFranHoraSoc
	            					   ,iCon2,stCliente.pAbonados[iCon1].pConcTar[iCon2].iCodOperador)   ;
	        }/* fin for iCon2 */
	    }/* fin for iCon1 */
	}
}
/*************************** Final vPrintConcTar ****************************/


/*****************************************************************************/
/*                          funcion : bValidacionConcTar                     */
/*****************************************************************************/
static BOOL bfnValidacionConcTar (CONCTAR *pConcTar)
{
    int iRes = 0;

    CONCEPTO stConcepto;

    memset (&stConcepto,0,sizeof(CONCEPTO));

    if( !bFindConcepto (pConcTar->iCodFacturacion, &stConcepto) )
    {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstConcepto");
        iRes = ERR021;
    }
    if( iRes == 0 )
    {
        strcpy (pConcTar->szCodMoneda  ,stConcepto.szCodMoneda  );
        strcpy (pConcTar->szDesConcepto,stConcepto.szDesConcepto);
        pConcTar->iCodTipConce  = stConcepto.iCodTipConce        ;

		if( stConcepto.iCodTipConce == IMPUESTO ||
		    stConcepto.iCodTipConce == DESCUENTO )
		{
		    sprintf (stAnomProceso.szObsAnomalia,"Tipo de Concepto erroneo %d",
		             stConcepto.iCodTipConce);
		    iRes = ERR001;
		}

    }
    if( iRes == 0 && stConcepto.iIndActivo == 0 )
    {
        strcpy (stAnomProceso.szObsAnomalia,"Indice Activo = 0");
        iRes = ERR001;
    }
    if( iRes == 0 && pConcTar->dImpConsumido < 0 )
    {
        sprintf (stAnomProceso.szObsAnomalia,"Importe del concepto = %f",
                 pConcTar->dImpConsumido);
        iRes = ERR001;
    }
    if( iRes )
    {
        stAnomProceso.lNumProceso  = stStatus.IdPro           ;
        stAnomProceso.lCodCliente  = stCliente.lCodCliente    ;
        stAnomProceso.iCodConcepto = pConcTar->iCodFacturacion;
        stAnomProceso.iCodProducto = pConcTar->iCodProducto   ;
        stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact     ;

        strncpy (stAnomProceso.szDesProceso,"PreBilling-Tarificacion",
                 sizeof (stAnomProceso.szDesProceso));

        if( iRes == ERR001 )
        {
            iDError (szExeName,ERR001,vInsertarIncidencia,
                     stAnomProceso.iCodConcepto,
                     stConcepto.iIndActivo     ,
                     stConcepto.iCodTipConce   ,
                     pConcTar->dImpConsumido);
        }
    }
    return(iRes == 0)?TRUE:FALSE;
}/*************************** Final bValidacionConcTar ***********************/

/*****************************************************************************/
/*                          funcion : bfnValidacionCarrier                   */
/*****************************************************************************/
static BOOL bfnValidacionCarrier (CONCTAR *pConcTar, CONCEPTO stConcepto)
{
    int iRes = 0;

    strcpy (pConcTar->szCodMoneda  ,stConcepto.szCodMoneda  );
    strcpy (pConcTar->szDesConcepto,stConcepto.szDesConcepto);

    pConcTar->iCodTipConce = stConcepto.iCodTipConce;

    if( stConcepto.iCodTipConce == DESCUENTO )
    {
        sprintf (stAnomProceso.szObsAnomalia,"Tipo de Concepto erroneo %d",
                 stConcepto.iCodTipConce);
        iRes = ERR001;
    }
    else if( stConcepto.iIndActivo == 0 )
    {
        strcpy (stAnomProceso.szObsAnomalia,"Indice Activo = 0");
        iRes = ERR001;
    }
    else if( pConcTar->dImpConsumido <= 0 )
    {
        sprintf (stAnomProceso.szObsAnomalia,"Importe del concepto = %f",
                 pConcTar->dImpConsumido);
        iRes = ERR001;
    }
    
    if( iRes )
    {
        stAnomProceso.lNumProceso  = stStatus.IdPro           ;
        stAnomProceso.lCodCliente  = stCliente.lCodCliente    ;
        stAnomProceso.iCodConcepto = pConcTar->iCodFacturacion;
        stAnomProceso.iCodProducto = pConcTar->iCodProducto   ;
        stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact     ;

        strncpy (stAnomProceso.szDesProceso,"Tasacion-Carrier",
                 sizeof (stAnomProceso.szDesProceso));

        if( iRes == ERR001 )
        {
            iDError (szExeName,ERR001,vInsertarIncidencia,
                     stAnomProceso.iCodConcepto,
                     stConcepto.iIndActivo     ,
                     stConcepto.iCodTipConce   ,
                     pConcTar->dImpConsumido);
        }
    }
    return(iRes == 0)?TRUE:FALSE;
}/*************************** Final bfnValidacionCarrier *********************/

/*****************************************************************************/
/*                           funcion : vfnAplicaPlanOptimo                   */
/*****************************************************************************/
static void vfnAplicaPlanOptimo (CONCTAR *pConcTar   ,
                                 double   dMinTotal)
{
    int  i           = 0    ;
    int  j           = 0    ;
    int  k           = 0    ;

  /*********************************************************************/
  /* En caso de ser H o E, el cargo basico, estara asociado al cliente */
  /* y por tanto el NumAbonado sera 0.                                 */
  /*********************************************************************/

    vDTrazasLog (szExeName,"\n\t\t* Aplicacion Plan Optimo"
                 "\n\t\t=> Tip.PlanTarif     [%s]"
                 "\n\t\t=> Tot.Minutos Local [%f]", LOG05,
                 stCliente.szTipPlanTarif, dMinTotal);

    while( i<NUM_OPTIMO )
    {
        j = 0;

        while( j<stCliente.iNumAbonos )
        {
      /******************************************************************/
      /*  El Abonado 0 identifica los Cargos Basicos a Nivel de Cliente */
      /* de los Clientes Holding o Empresa.                             */
      /******************************************************************/

            if( stCliente.pAbonos [j].lNumAbonado == pConcTar->lNumAbonado ||
                ( stCliente.pAbonos [j].lNumAbonado == 0 &&
                  !stCliente.pAbonos [j].bPlanOptimo ) )
            {

                for( k=0;k<stCliente.pAbonos[j].iNumCBasicos;k++ )
                {
                    if( !strcmp(stCliente.pAbonos[j].pstCBasico[k].szCodPlanTarif,
                                pstOptimo [i].szCodPlanTarif) &&
                        pstOptimo [i].lMinDesde <= dMinTotal &&
                        ( pstOptimo [i].lMinHasta >= dMinTotal ||
                          pstOptimo [i].lMinHasta == -1) )
                    {
                        vDTrazasLog (szExeName,
                                     "\n\t\t* Importes Antes del Descuento"
                                     "\n\t\t=> Cod.FranHoraSoc   [%d]"
                                     "\n\t\t=> Prc.Bajo          [%f]"
                                     "\n\t\t=> Prc.Normal        [%f]"
                                     "\n\t\t=> Prc.Abono         [%f]"
                                     "\n\t\t=> Importe Consumido [%f]"
                                     "\n\t\t=> Importe CBasico   [%f]", LOG05,
                                     pConcTar->iCodFranHoraSoc,
                                     pstOptimo [i].fPrcBajo   ,
                                     pstOptimo [i].fPrcNormal ,
                                     pstOptimo [i].fPrcAbono  ,
                                     pConcTar->dImpConsumido  ,
                                     stCliente.pAbonos[j].pstCBasico[k].dImpConcepto);

                        if( pConcTar->iCodFranHoraSoc == iFRANBAJA )
                            pConcTar->dImpConsumido   -=
                            (double)(pConcTar->dImpConsumido *
                                     pstOptimo [i].fPrcBajo)/100  ;
                        else if( pConcTar->iCodFranHoraSoc == iFRANNORMAL )
                            pConcTar->dImpConsumido   -=
                            (double)(pConcTar->dImpConsumido *
                                     pstOptimo [i].fPrcNormal)/100;
                                     
                        if( !stCliente.pAbonos[j].bPlanOptimo )
                        {
                            stCliente.pAbonos[j].pstCBasico[k].dImpConcepto -=
                            (double)(stCliente.pAbonos[j].pstCBasico[k].dImpConcepto *
                                     pstOptimo [i].fPrcAbono)/100       ;
                            stCliente.pAbonos[j].bPlanOptimo = TRUE;
                        }
                        vDTrazasLog (szExeName,
                                     "\n\t\t* Importes Despues del Descuento"
                                     "\n\t\t=> Importe Consumido [%f]"
                                     "\n\t\t=> Importe CBasico   [%f]", LOG05,
                                     pConcTar->dImpConsumido,
                                     stCliente.pAbonos[j].pstCBasico[k].dImpConcepto);
                    }

                }/* fin for k ... */
            }
            j++;

        }/* fin while bPlan ... */
        i++;

    }/* fin iNumOptimo */

}/************************** Final vfnAplicaPlanOptimo ***********************/

/*****************************************************************************/
/*                         funcion : dfnTotMinutosLocales                    */
/*****************************************************************************/
static double dfnTotMinutosLocales (ABONTAR *stAbonTar)
{
    int    i      = 0;
    double dTotal = 0;

    for( i=0;i<stAbonTar->iNumConcTar;i++ )
    {
        if( stAbonTar->pConcTar [i].iIndTabla == FRASOC )
            dTotal += stAbonTar->pConcTar [i].lSegConsumido;

        vDTrazasLog (szExeName,
                     "\n\t\t* Cconcepto de Trafico [%d]"
                     "\n\t\t=> Ind Tabla      [%d]"
                     "\n\t\t=> lSegConsumido  [%ld]"
                     "\n\t\t=> Acumulado      [%f]"
                     ,LOG05, i,stAbonTar->pConcTar [i].iIndTabla,stAbonTar->pConcTar [i].lSegConsumido, dTotal);
    }
    vDTrazasLog (szExeName,"\n\t\t* Total Trafico Local Adicional [%ld]",LOG05, dTotal);
    return(double)dTotal/60;
}/*************************** Final dfnTotMinutosLocales *********************/


/*****************************************************************************/
/*                          funcion : bfnBuscaAcumCodTarif                   */
/* - Busca el codigo de tarificacion en pstTaConcepFact y acumula en pConcTar*/
/*   los segundos e importe                                                  */
/*****************************************************************************/

static BOOL bfnBuscaAcumCodTarif(CONCEP *pstConcep   , long lNumAbonado
                                 ,int iCodTarificacion, long lSegConsumido
                                 ,double dImpConsumido, long lNumPulsos
                                 ,int sIndEntSal      , int  sIndDestino
                                 ,int iIndTabla       , char *szCodServicio)
{
    int i=0;
    BOOL bFound=FALSE;

    vDTrazasLog (szExeName,
                 "\n\t\t* Parametros de Entrada bfnBuscaAcumCodTarif"
                 "\n\t\t=> Codigo Tarificacion      :[%d]"
                 "\n\t\t=> Cant. Segundos consumidos:[%ld]"
                 "\n\t\t=> Importe                  :[%f]"
                 "\n\t\t=> Numero de Pulsos         :[%ld]"
                 "\n\t\t=> Indicador de Tabla       :[%d]"
                 "\n\t\t=> Codigo Servicio          :[%s]", LOG05,
                 iCodTarificacion,lSegConsumido, dImpConsumido,lNumPulsos,iIndTabla,
                 szCodServicio);

    for( i=0;i<=NUM_TACONCEPFACT;i++ )
    {
        if( pstTaConcepFact[i].iCodTarificacion== iCodTarificacion )
        {
            if( iIndTabla!=1 ) /* Ta_AcumOper */
            {
                if( !strcmp(pstTaConcepFact[i].szCodServicio,szCodServicio) )
                {
                    bFound=TRUE;
                    break;
                }
            }
            else if( pstTaConcepFact[i].iIndDestino== sIndDestino &&
                     pstTaConcepFact[i].iIndEntSal== sIndEntSal   &&
                     !strcmp(pstTaConcepFact[i].szCodServicio,szCodServicio) )
            {
                bFound=TRUE;
                break;
            }
        }
    }

    if( bFound )
    {
        pstConcep->stConcTar[i].lNumAbonado     = lNumAbonado                       ;
        pstConcep->stConcTar[i].iCodProducto    = pstTaConcepFact[i].iCodProducto   ;
        pstConcep->stConcTar[i].iCodFacturacion = pstTaConcepFact[i].iCodFacturacion;
        pstConcep->stConcTar[i].iIndTabla       = pstTaConcepFact[i].iIndTabla      ;
        pstConcep->stConcTar[i].iIndDestino     = pstTaConcepFact[i].iIndDestino    ;

        if( pstConcep->stConcTar[i].iIndTabla == FRASOC )
            pstConcep->stConcTar[i].iCodFranHoraSoc = iCodTarificacion;
        else
            pstConcep->stConcTar[i].iCodOperador    = iCodTarificacion;

        pstConcep->stConcTar[i].lNumPulsos      = lNumPulsos                        ;
        pstConcep->stConcTar[i].lNumProceso     = stStatus.IdPro                    ;
        pstConcep->stConcTar[i].iIndEntSal      = sIndEntSal                        ;
        pstConcep->stConcTar[i].iCarrier        = 0                                 ;

        pstConcep->stConcTar[i].lSegConsumido  += lSegConsumido                     ;
        pstConcep->stConcTar[i].dImpConsumido  += dImpConsumido                     ;

    }
    return(bFound);
}/************************* Final bfnBuscaAcumCodTarif ***********************/


/****************************************************************************
        TOL functions
 Descripcion: Funciones cargas del Nuevo Tarificador Online
 Fecha : 20-12-2002 - 16-01-2003
 Autor : Mauricio Labra C.
****************************************************************************/


#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) ) return(s);
    while( *p<=32 && *p>1 ) p++;
    strcpy(s,p);
    return(s);
}

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) ) return(s);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )  p--;
    *(++p)=0;
    return(s);
}

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
}


int bfnBusca_Promo(char *szTipDcto, char *szCodDcto)
{
    int i;

    for( i=0; i<stTOL_DCTO.iNumTolDcto; i++ )
    {
        if( !strcmp(szTipDcto,stTOL_DCTO.asTolDcto[i].szTipDcto)
            && (!strcmp(szCodDcto,stTOL_DCTO.asTolDcto[i].szCodDcto)) )
        {
            return(i+1);
        }
    }
    return(FALSE);
}


int bfnBusca_UnidadPromo(char *szUnidad)
{
    int i;

    for( i=0; i<stTOL_PROMO.iNumTolPromo; i++ )
    {
        if( !strcmp(szUnidad,stTOL_PROMO.asTolPromo[i].szUnidadPromo) )
        {
            return(i+1);
        }
    }
    return(FALSE);
}



int bfnBusca_Desc(char *szTipDcto)
{
    int i;

    for( i=0; i<stTOL_DESC.iNumTolDesc; i++ )
    {
        if( !strcmp(szTipDcto,stTOL_DESC.asTolDesc[i].szTipDcto) )
        {
            return(i+1);
        }
    }
    return(FALSE);
}

/* MultiIdioma  */
BOOL bCarga_TOLDescuentosMI()
{
    int i,j;
    int iCodProducto;
    char szCodConcepto[13];
    char szDesConcepto[256];

    if( strcmp(stCliente.szCodIdioma,pstParamGener.szCodIdioma) )
    {
        /* EXEC SQL DECLARE Cur_TOL_Descuentos_MI CURSOR FOR
        SELECT  COD_PRODUCTO,
        COD_CONCEPTO,
        NVL(DES_CONCEPTO,'***')
        FROM GE_MULTIIDIOMA
        WHERE NOM_TABLA = 'TOL_DESCUENTO_TD'
        AND NOM_CAMPO = 'TIP_DCTO'
        AND COD_IDIOMA = :stCliente.szCodIdioma
        ; */ 


        /* EXEC SQL OPEN Cur_TOL_Descuentos_MI; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0025;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1579;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)(stCliente.szCodIdioma);
        sqlstm.sqhstl[0] = (unsigned long )6;
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



        if( SQLCODE )
        {
            iDError(szExeName,ERR000,vInsertarIncidencia,"Open->GE_MULTIIDIOMA",szfnORAerror());
            return(FALSE);
        }

        i=j=0;
        while( SQLCODE == 0 )
        {
            /* EXEC SQL FETCH Cur_TOL_Descuentos_MI
            INTO :iCodProducto,
            	 :szCodConcepto,
            	 :szDesConcepto ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1598;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&iCodProducto;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szCodConcepto;
            sqlstm.sqhstl[1] = (unsigned long )13;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szDesConcepto;
            sqlstm.sqhstl[2] = (unsigned long )256;
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



            alltrim(szCodConcepto);
            alltrim(szDesConcepto);

            for( i=0; i<stTOL_DCTO.iNumTolDcto; i++ )
            {
                if( stTOL_DCTO.asTolDcto[i].iNTipDcto == iCodProducto
                    && !strcmp( stTOL_DCTO.asTolDcto[i].szTipDcto,szCodConcepto) )
                {
                    strcpy(stTOL_DCTO.asTolDcto[i].szGlsDcto, szDesConcepto);
                }
            }
            stTOL_PROMODCTO_MI.asTolPromoDcto_MI[j].iCodProducto=iCodProducto;
            strcpy(stTOL_PROMODCTO_MI.asTolPromoDcto_MI[j].szCodConcepto,szCodConcepto);
            strcpy(stTOL_PROMODCTO_MI.asTolPromoDcto_MI[j].szCodIdioma,stCliente.szCodIdioma);
            strcpy(stTOL_PROMODCTO_MI.asTolPromoDcto_MI[j].szDesConcepto,szDesConcepto);

            j++;
        }/* fin while */

        stTOL_PROMODCTO_MI.iNumTolPromoDcto=j-1;
        vDTrazasLog(szExeName, "\n\t\t*  bCarga_TOLDescuentosMI leidos [%d]\n",LOG05, stTOL_PROMODCTO_MI.iNumTolPromoDcto);

        if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
        {
            iDError(szExeName,ERR000,vInsertarIncidencia,"Fetch->GE_MULTIIDIOMA", szfnORAerror());
            return(FALSE);
        }

        /* EXEC SQL CLOSE Cur_TOL_Descuentos_MI; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1625;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if( SQLCODE )
        {
            iDError(szExeName,ERR000,vInsertarIncidencia,"Close->GE_MULTIIDIOMA", szfnORAerror());
        }
    }
    return(TRUE);
}



/*****************************************************************************/
/*                       funcion : bCargaTOL_Descuentos                           */
/*****************************************************************************/
BOOL bCarga_TOLDescuentos()
{
    int  i        = 0   ;

    /* EXEC SQL DECLARE Cur_TOL_Descuentos CURSOR FOR
    SELECT   TIP_DCTO      ,
	    COD_DCTO      ,
	    GLS_DCTO      ,
	    IND_APLICA    ,
	    FEC_INI_VIG   ,
	    FEC_TER_VIG   ,
	    NOM_USUARIO   , /o SAAM-20030325 Cambia nombre de campo o/
	    FEC_UMOD      
    FROM TOL_DESCUENTO_TD
    ; */ 


    /* EXEC SQL OPEN Cur_TOL_Descuentos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0026;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1640;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Open->TOL_DESCUENTO_TD",szfnORAerror());
        return(FALSE);
    }

    i=0;
    while( SQLCODE == 0 )
    {
        /* EXEC SQL FETCH Cur_TOL_Descuentos
        INTO    :stTOL_DCTO.asTolDcto[i].szTipDcto   ,
                :stTOL_DCTO.asTolDcto[i].szCodDcto   ,
                :stTOL_DCTO.asTolDcto[i].szGlsDcto   ,
                :stTOL_DCTO.asTolDcto[i].szIndAplica ,
                :stTOL_DCTO.asTolDcto[i].szFecIniVig ,
                :stTOL_DCTO.asTolDcto[i].szFecTerVig 
            /o  :stTOL_DCTO.asTolDcto[i].iNTipDcto o/
        ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1655;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)((stTOL_DCTO.asTolDcto)[i].szTipDcto);
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)((stTOL_DCTO.asTolDcto)[i].szCodDcto);
        sqlstm.sqhstl[1] = (unsigned long )6;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)((stTOL_DCTO.asTolDcto)[i].szGlsDcto);
        sqlstm.sqhstl[2] = (unsigned long )41;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)((stTOL_DCTO.asTolDcto)[i].szIndAplica);
        sqlstm.sqhstl[3] = (unsigned long )5;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)((stTOL_DCTO.asTolDcto)[i].szFecIniVig);
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)((stTOL_DCTO.asTolDcto)[i].szFecTerVig);
        sqlstm.sqhstl[5] = (unsigned long )15;
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



        alltrim(stTOL_DCTO.asTolDcto[i].szTipDcto);
        alltrim(stTOL_DCTO.asTolDcto[i].szCodDcto);
        alltrim(stTOL_DCTO.asTolDcto[i].szGlsDcto);
        alltrim(stTOL_DCTO.asTolDcto[i].szIndAplica);
        alltrim(stTOL_DCTO.asTolDcto[i].szFecIniVig);
        alltrim(stTOL_DCTO.asTolDcto[i].szFecTerVig);

/* MultiIdioma  */

        i++;
    }/* fin while */

    stTOL_DCTO.iNumTolDcto=i-1;
    vDTrazasLog(szExeName, "\n\t\t*  bCarga_TOLDescuentos leidos [%d]\n",LOG05, stTOL_DCTO.iNumTolDcto);

    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Fetch->TOL_DESCUENTO_TD", szfnORAerror());
        return(FALSE);
    }

    /* EXEC SQL CLOSE Cur_TOL_Descuentos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1694;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Close->TOL_DESCUENTO_TD", szfnORAerror());
    }

/*  bCarga_TOLDescuentosMI();*/

    return(TRUE);
}


/*****************************************************************************/
/*                       funcion : bCarga_TOLPromociones                           */
/*****************************************************************************/
BOOL bCarga_TOLPromociones()
{
    int  i        = 0   ;
    CONCEPTO_MI stConcepto_mi;

    memset (&stConcepto_mi,0,sizeof(CONCEPTO_MI));

    /* EXEC SQL DECLARE Cur_TOLPromociones CURSOR FOR
    SELECT TRIM(UNIDAD_PROMO)      ,
		   A.COD_CONCEPTO          ,
		   A.FEC_DESDE             ,
		   A.FEC_HASTA             ,
		   NVL(TRIM(B.DES_CONCEPTO),'***')
    FROM FA_TOLPROMOCION_TD A, FA_CONCEPTOS B
    WHERE A.COD_CONCEPTO = B.COD_CONCEPTO(+)
    ORDER BY A.COD_CONCEPTO; */ 


    /* EXEC SQL OPEN Cur_TOLPromociones; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0027;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1709;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Open->FA_TOLPROMOCION_TD",szfnORAerror());
        return(FALSE);
    }

    i=0;
    while( SQLCODE == 0 )
    {
        /* EXEC SQL FETCH Cur_TOLPromociones
        INTO    :stTOL_PROMO.asTolPromo[i].szUnidadPromo    ,
                :stTOL_PROMO.asTolPromo[i].iCodConcepto     ,
                :stTOL_PROMO.asTolPromo[i].szFecDesde       ,
                :stTOL_PROMO.asTolPromo[i].szFecHasta       ,
                :stTOL_PROMO.asTolPromo[i].szDesPromo
        ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1724;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)((stTOL_PROMO.asTolPromo)[i].szUnidadPromo);
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&((stTOL_PROMO.asTolPromo)[i].iCodConcepto);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)((stTOL_PROMO.asTolPromo)[i].szFecDesde);
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)((stTOL_PROMO.asTolPromo)[i].szFecHasta);
        sqlstm.sqhstl[3] = (unsigned long )15;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)((stTOL_PROMO.asTolPromo)[i].szDesPromo);
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



/* MultiIdioma  */
        if( strcmp(stCliente.szCodIdioma,pstParamGener.szCodIdioma) )
        {
            if( bFindConcepto_mi(stTOL_PROMO.asTolPromo[i].iCodConcepto,stCliente.szCodIdioma,&stConcepto_mi) )
            {
                alltrim(stConcepto_mi.szDesConcepto);
                strcpy(stTOL_PROMO.asTolPromo[i].szDesPromo,stConcepto_mi.szDesConcepto);
            }
        }

        alltrim(stTOL_PROMO.asTolPromo[i].szUnidadPromo);
        alltrim(stTOL_PROMO.asTolPromo[i].szDesPromo);

        i++;
    }/* fin while */

    stTOL_PROMO.iNumTolPromo=i-1;
    vDTrazasLog(szExeName, "\n\t\t*  bCarga_TOLPromociones leidos [%d]\n",LOG05, stTOL_PROMO.iNumTolPromo);

    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Fetch->FA_TOLPROMOCION_TD", szfnORAerror());
        return(FALSE);
    }

    /* EXEC SQL CLOSE Cur_TOLPromociones; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1759;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Close->FA_TOLPROMOCION_TD", szfnORAerror());
    }

    return((SQLCODE == SQLOK)?TRUE:FALSE);
}


/*****************************************************************************/
/*                       funcion : bCarga_TOLDescripciones                   */
/*****************************************************************************/
BOOL bCarga_TOLDescripciones()
{
    int  i        = 0   ;
    CONCEPTO_MI stConcepto_mi;
    memset (&stConcepto_mi,0,sizeof(CONCEPTO_MI));


    /* EXEC SQL DECLARE Cur_TOLDescripcion CURSOR FOR
    SELECT A.TIP_DCTO, A.COD_CONCEPTO,
    NVL(TRIM(B.DES_CONCEPTO),'***')
    FROM FA_CONCLLAM_TD A, FA_CONCEPTOS B
    WHERE A.COD_CONCEPTO = B.COD_CONCEPTO(+)
    ORDER BY A.COD_CONCEPTO; */ 


    /* EXEC SQL OPEN Cur_TOLDescripcion; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0028;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1774;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"bCarga_TOLDescripciones Open->FA_TOLDESCRIPCION_TD",szfnORAerror());
        return(FALSE);
    }

    i=0;
    while( SQLCODE == 0 )
    {
        /* EXEC SQL FETCH Cur_TOLDescripcion
        INTO
                :stTOL_DESC.asTolDesc[i].szTipDcto      ,
                :stTOL_DESC.asTolDesc[i].iCodConcepto   ,
                :stTOL_DESC.asTolDesc[i].szDescripcion
        ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1789;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)((stTOL_DESC.asTolDesc)[i].szTipDcto);
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&((stTOL_DESC.asTolDesc)[i].iCodConcepto);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)((stTOL_DESC.asTolDesc)[i].szDescripcion);
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



/* MultiIdioma  */
        if( strcmp(stCliente.szCodIdioma,pstParamGener.szCodIdioma) )
        {
            if( bFindConcepto_mi(stTOL_DESC.asTolDesc[i].iCodConcepto,stCliente.szCodIdioma,&stConcepto_mi) )
            {
                alltrim(stConcepto_mi.szDesConcepto);
                strcpy(stTOL_DESC.asTolDesc[i].szDescripcion,stConcepto_mi.szDesConcepto);
            }
        }

        alltrim(stTOL_DESC.asTolDesc[i].szTipDcto);
        alltrim(stTOL_DESC.asTolDesc[i].szDescripcion);

        i++;
    }/* fin while */

    stTOL_DESC.iNumTolDesc=i-1;
    vDTrazasLog(szExeName, "\n\t\t*  bCarga_TOLDescripcion leidos [%d]\n",LOG05, stTOL_DESC.iNumTolDesc);

    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Fetch->FA_TOLDESCRIPCION_TD", szfnORAerror());
        return(FALSE);
    }

    /* EXEC SQL CLOSE Cur_TOLDescripcion; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1816;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"Close->FA_TOLDESCRIPCION_TD", szfnORAerror());
    }

    return((SQLCODE == SQLOK)?TRUE:FALSE);
}


BOOL bfnLeeAbonadosClienteTOL(CICLOCLI *pCicloCli, int iTipoFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    static long  lhCodCliente     ;
	    static long  lhNumAbonado     ;
	    static long  lhCodCiclFact    ;
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL DECLARE Cur_CargaAbonados CURSOR FOR

    SELECT
    ROWID, NUM_ABONADO
    FROM   GA_INFACCEL
    WHERE COD_CLIENTE = :lhCodCliente
    AND NUM_ABONADO   = :lhNumAbonado
    AND COD_CICLFACT <= :lhCodCiclFact
    AND IND_FACTUR    = 1
    AND (EXISTS(    SELECT NUM_ABONADO
                    FROM TOL_ACUMOPER_TO
                    WHERE COD_CLIENTE   = :lhCodCliente
                    AND   NUM_ABONADO   = :lhNumAbonado
                    AND   COD_CICLFACT  = :lhCodCiclFact
                    AND   NUM_PROCESO   = 0)
    ); */ 


    lhCodCiclFact = stCiclo.lCodCiclFact  ;
    lhCodCliente  = stCliente.lCodCliente ;
    lhNumAbonado  = pCicloCli->lNumAbonado;

    vDTrazasLog(szExeName,  "\t\t* bfnLeeAbonadosClienteTOL Abonado : [%ld]\n" ,LOG04,lhNumAbonado);

    /* EXEC SQL OPEN Cur_CargaAbonados; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0029;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1831;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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




    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"bfnLeeAbonadosClienteTOL Open->Ga_CargaAbonados",szfnORAerror());
        return(FALSE);
    }

    stCliente.iNumAbonados=0;

    while( SQLCODE == 0 )
    {
        /* EXEC SQL FETCH Cur_CargaAbonados INTO :lhNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1870;
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



        if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
        {
            break;
        }
        if( (stCliente.pAbonados = (ABONTAR *)realloc ((ABONTAR *)stCliente.pAbonados,sizeof(ABONTAR)*(stCliente.iNumAbonados+1)))==(ABONTAR *)NULL )
        {
            iDError(szExeName,ERR005,vInsertarIncidencia,"bfnLeeAbonadosClienteTOL stCliente.pAbonados",szfnORAerror());
            return(FALSE);
        }
        memset(&stCliente.pAbonados[stCliente.iNumAbonados],0,sizeof(ABONTAR));
        stCliente.pAbonados[stCliente.iNumAbonados].lNumAbonado = lhNumAbonado   ;
        stCliente.pAbonados[stCliente.iNumAbonados].iCodProducto= 0;
        stCliente.pAbonados[stCliente.iNumAbonados].iNumConcTar = 0;
        stCliente.pAbonados[stCliente.iNumAbonados].iNumConcTOL = 0;

        stCliente.pAbonados[stCliente.iNumAbonados].pConcTar = (CONCTAR *)NULL;
        stCliente.pAbonados[stCliente.iNumAbonados].pConcTOL = (CONCTOL *)NULL;
        stCliente.iNumAbonados++;

    }/* fin while */

    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"bfnLeeAbonadosClienteTOL Fetch->Ga_CargaAbonados",szfnORAerror());
        return(FALSE);
    }
    /* EXEC SQL CLOSE Cur_CargaAbonados; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1889;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != 0 )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"bfnLeeAbonadosClienteTOL Close->CargaAbonados_TOL", szfnORAerror());
    }
    stCliente.iNumAbonados--;

    vDTrazasLog(szExeName,  "\t\t* bfnLeeAbonadosClienteTOL stCliente.iNumAbonados : [%d]\n" ,LOG04,stCliente.iNumAbonados);

    return((SQLCODE == SQLOK)?TRUE:FALSE);
}



/*************************** Funcion bfnLeeAbonadosTOL *************************/
BOOL bfnLeeAbonadosTOL(int iTipoFact)
{
    BOOL bRes = TRUE ;
    long lInd = 0    ;

    stCliente.pAbonados = (ABONTAR *)NULL;

    vDTrazasLog(szExeName,  "\t\t* bfnLeeAbonadosTOL stAbonoCli.lNumAbonados : [%d]\n" ,LOG04,stAbonoCli.lNumAbonados);

    if( iTipoFact == FACT_CICLO )
    {
        while( lInd < stAbonoCli.lNumAbonados && bRes )
        {
            if( !bfnCargaAbonadosCliente(&stAbonoCli.pCicloCli[lInd],iTipoFact) )
                bRes = FALSE;
            else
                lInd++;
        }/* fin While lInd ... */
    }
    return(bRes);
}
/*************************** Funcion bfnLeeAbonadosTOL *************************/



BOOL bfnLeeAcumTOL(long lNumAbonado)
{
    int i=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static long lhCodCliente ;
    static long lhNumAbonado ;
    long  lhCodCiclFact      ; 
    static int ihzero;
    static int ihuno;
    static int ihtres;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(szExeName,  "\n\t\t* Parametros de Entrada Acumuladores TOL"
                "\n\t\t=> Cod.Cliente [%ld]"
                "\n\t\t=> Num.Abonado [%ld]"
                , LOG05,stCliente.lCodCliente, lNumAbonado);

    lhCodCiclFact= stCiclo.lCodCiclFact;
    lhCodCliente = stCliente.lCodCliente;
    lhNumAbonado = lNumAbonado ;
    ihzero=0;
    ihuno=1;
    ihtres=3;

    vDTrazasLog(szExeName, "\n\t\t* Detalle de trafico del Ciclo <= [%ld]\n",LOG03, stCiclo.lCodCiclFact);    

    /* EXEC SQL DECLARE Cur_AcumOperTOL CURSOR FOR

	    SELECT NVL(TRIM(A.COD_REGI),'*'),
                   NVL(A.COD_GRUPO, :ihzero ),
                   NVL(A.COD_CLIENTE, :ihzero ),
                   NVL(A.NUM_ABONADO, :ihzero ),
                   NVL(A.COD_CICLFACT, :ihzero ),
                   NVL(A.NUM_PROCESO, :ihzero ),
                   NVL(TRIM(A.IND_EXEDENTE),'*'),
                   NVL(TRIM(A.COD_PLAN),'*'),
                   NVL(MAX(TRIM(A.IND_BILLETE)),'*'),
                   NVL(NVL(D.COD_CONCDEST,A.COD_CARG), :ihzero ),
                   NVL(TRIM(A.TIP_DCTO),'AD'),
                   NVL(TRIM(A.COD_DCTO),'*'),
                   NVL(MAX(TRIM(A.COD_ITEM)),'*'),
                   NVL(MAX(TRIM(A.IND_UNIDAD)),'*'),
                   NVL(MAX(A.CNT_INICIAL), :ihzero ),
                   NVL(MAX(A.CNT_AUX), :ihzero),
                   NVL(SUM(A.MTO_REAL), :ihzero ),
                   NVL(SUM(A.MTO_FACT), :ihzero ),
                   NVL(SUM(A.MTO_DCTO), :ihzero ),
                   NVL(SUM(A.DUR_REAL), :ihzero ),
                   NVL(SUM(A.DUR_FACT), :ihzero ),
                   NVL(SUM(A.DUR_DCTO), :ihzero ),
                   NVL(MAX(TRIM(NVL(BB.DES_CONCEPTO,B.DES_CONCEPTO))),'***'),
                   NVL(MAX(NVL(BB.COD_TIPCONCE,B.COD_TIPCONCE)), :ihtres),
                   NVL(MAX(TRIM(NVL(BB.COD_MONEDA,B.COD_MONEDA))),'001'),
                   NVL(MAX(C.COD_PRODUCTO), :ihuno ),
                   NVL(MAX(TRIM(C.DES_PLANTARIF)),'***'),
                   NVL(A.COD_OPERADOR, :ihzero ),
                   NVL(SUM(A.CNT_LLAM_REAL), :ihzero ),
                   NVL(SUM(A.CNT_LLAM_DCTO), :ihzero ),
                   NVL(SUM(A.CNT_LLAM_FACT), :ihzero ),
                   :ihzero					/o Indicador de Carrier 0=No carrier 1=Carrier o/
            FROM   TOL_ACUMOPER_TO    A
                 , FA_CONCEPTOS       B
                 , FA_CONCEPTOS       BB
                 , TA_PLANTARIF       C
                 , FA_CONCEPTRAIMP_TD D
                 , FA_CICLFACT E 
						WHERE  A.NUM_ABONADO = :lhNumAbonado
						/oAND  A.COD_CICLFACT > E.COD_CICLFACT CJGo/
						AND  A.COD_CICLFACT = E.COD_CICLFACT /oCJGo/
						AND E.FEC_EMISION <= (SELECT MAX(FEC_EMISION) FROM FA_CICLFACT WHERE COD_CICLFACT = :lhCodCiclFact)/oCJGo/
						AND  E.IND_FACTURACION >:ihzero
						AND  A.COD_CLIENTE = :lhCodCliente
						AND  A.NUM_PROCESO = :ihzero
						AND  D.COD_CONCDEST = BB.COD_CONCEPTO(+)
						AND  A.COD_CARG = B.COD_CONCEPTO(+)
						AND  B.COD_PRODUCTO = :ihuno
						AND  A.COD_PLAN = C.COD_PLANTARIF(+)
						AND  A.COD_CARG   = D.COD_CONCORIG(+)
						AND  A.COD_AREAA  = D.COD_ZONAORIG(+)
           GROUP BY COD_OPERADOR
                  , COD_REGI
                  , A.COD_GRUPO
                  , COD_CLIENTE
                  , NUM_ABONADO
                  , A.COD_CICLFACT
                  , NUM_PROCESO
                  , IND_EXEDENTE
                  , COD_PLAN
                  , NVL(NVL(D.COD_CONCDEST,A.COD_CARG),:ihzero)
                  , TIP_DCTO
                  , COD_DCTO; */ 


    /* EXEC SQL OPEN Cur_AcumOperTOL ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 28;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlbuft((void **)0, 
      "select NVL(trim(A.COD_REGI),'*') ,NVL(A.COD_GRUPO,:b0) ,NVL(A.COD_CLI\
ENTE,:b0) ,NVL(A.NUM_ABONADO,:b0) ,NVL(A.COD_CICLFACT,:b0) ,NVL(A.NUM_PROCES\
O,:b0) ,NVL(trim(A.IND_EXEDENTE),'*') ,NVL(trim(A.COD_PLAN),'*') ,NVL(max(tr\
im(A.IND_BILLETE)),'*') ,NVL(NVL(D.COD_CONCDEST,A.COD_CARG),:b0) ,NVL(trim(A\
.TIP_DCTO),'AD') ,NVL(trim(A.COD_DCTO),'*') ,NVL(max(trim(A.COD_ITEM)),'*') \
,NVL(max(trim(A.IND_UNIDAD)),'*') ,NVL(max(A.CNT_INICIAL),:b0) ,NVL(max(A.CN\
T_AUX),:b0) ,NVL(sum(A.MTO_REAL),:b0) ,NVL(sum(A.MTO_FACT),:b0) ,NVL(sum(A.M\
TO_DCTO),:b0) ,NVL(sum(A.DUR_REAL),:b0) ,NVL(sum(A.DUR_FACT),:b0) ,NVL(sum(A\
.DUR_DCTO),:b0) ,NVL(max(trim(NVL(BB.DES_CONCEPTO,B.DES_CONCEPTO))),'***') ,\
NVL(max(NVL(BB.COD_TIPCONCE,B.COD_TIPCONCE)),:b14) ,NVL(max(trim(NVL(BB.COD_\
MONEDA,B.COD_MONEDA))),'001') ,NVL(max(C.COD_PRODUCTO),:b15) ,NVL(max(trim(C\
.DES_PLANTARIF)),'***') ,NVL(A.COD_OPERADOR,:b0) ,NVL(sum(A.CNT_LLAM_REAL),:\
b0) ,NVL(sum(A.CNT_LLAM_DCTO),:b0) ,NVL(sum(A.CNT_LLAM_FACT),:b0) ,:b0  from\
 TOL_ACUMOPER_TO A ,FA_CONCEPTOS B ,FA_CONC");
    sqlstm.stmt = sq0030;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1904;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&ihtres;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&ihuno;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[25] = (         int  )0;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)&ihuno;
    sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[26] = (         int  )0;
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)&ihzero;
    sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[27] = (         int  )0;
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
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



    if( SQLCODE )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"bfnLeeAcumTOL Open->Tol_AcumOper", szfnORAerror());
        return(FALSE);
    }
    i=0;
    while( SQLCODE == 0 )
    {
        memset(&stTOL_Acumoper.asATOL[i],0, sizeof(CONCTOL));

        /* EXEC SQL FETCH Cur_AcumOperTOL
        INTO
                :stTOL_Acumoper.asATOL[i].szCodRegi,
                :stTOL_Acumoper.asATOL[i].lhCodGrupo,
                :stTOL_Acumoper.asATOL[i].lhCodCliente,
                :stTOL_Acumoper.asATOL[i].lhNumAbonado,
                :stTOL_Acumoper.asATOL[i].lhCodCiclFact,
                :stTOL_Acumoper.asATOL[i].lhNumProceso,
                :stTOL_Acumoper.asATOL[i].szIndExcedente,
                :stTOL_Acumoper.asATOL[i].szCodPlan,
                :stTOL_Acumoper.asATOL[i].szIndBillete,
                :stTOL_Acumoper.asATOL[i].ihCodCarg,
                :stTOL_Acumoper.asATOL[i].szTipDcto,
                :stTOL_Acumoper.asATOL[i].szCodDcto,
                :stTOL_Acumoper.asATOL[i].szCodItem,
                :stTOL_Acumoper.asATOL[i].szIndUnidad,
                :stTOL_Acumoper.asATOL[i].dhCntInicial,
                :stTOL_Acumoper.asATOL[i].dhCntAux,
                :stTOL_Acumoper.asATOL[i].dhMtoReal,
                :stTOL_Acumoper.asATOL[i].dhMtoFact,
                :stTOL_Acumoper.asATOL[i].dhMtoDcto,
                :stTOL_Acumoper.asATOL[i].lhDurReal,
                :stTOL_Acumoper.asATOL[i].lhDurFact,
                :stTOL_Acumoper.asATOL[i].lhDurDcto,
                :stTOL_Acumoper.asATOL[i].szDesConcepto,
                :stTOL_Acumoper.asATOL[i].iCodTipConce,
                :stTOL_Acumoper.asATOL[i].szCodMoneda,
                :stTOL_Acumoper.asATOL[i].iCodProducto,
                :stTOL_Acumoper.asATOL[i].szDesPlan,
                :stTOL_Acumoper.asATOL[i].iCodOperador,
                :stTOL_Acumoper.asATOL[i].lCntLlamReal,
                :stTOL_Acumoper.asATOL[i].lCntLlamFact,
                :stTOL_Acumoper.asATOL[i].lCntLlamDcto,
                :stTOL_Acumoper.asATOL[i].iIndCarrier
        ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 32;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2031;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szCodRegi);
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhCodGrupo);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhCodCliente);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhNumAbonado);
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhCodCiclFact);
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhNumProceso);
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szIndExcedente);
        sqlstm.sqhstl[6] = (unsigned long )2;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szCodPlan);
        sqlstm.sqhstl[7] = (unsigned long )6;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szIndBillete);
        sqlstm.sqhstl[8] = (unsigned long )3;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].ihCodCarg);
        sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szTipDcto);
        sqlstm.sqhstl[10] = (unsigned long )6;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szCodDcto);
        sqlstm.sqhstl[11] = (unsigned long )6;
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szCodItem);
        sqlstm.sqhstl[12] = (unsigned long )6;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szIndUnidad);
        sqlstm.sqhstl[13] = (unsigned long )6;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].dhCntInicial);
        sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].dhCntAux);
        sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].dhMtoReal);
        sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].dhMtoFact);
        sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].dhMtoDcto);
        sqlstm.sqhstl[18] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhDurReal);
        sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhDurFact);
        sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lhDurDcto);
        sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[21] = (         int  )0;
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szDesConcepto);
        sqlstm.sqhstl[22] = (unsigned long )61;
        sqlstm.sqhsts[22] = (         int  )0;
        sqlstm.sqindv[22] = (         short *)0;
        sqlstm.sqinds[22] = (         int  )0;
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].iCodTipConce);
        sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[23] = (         int  )0;
        sqlstm.sqindv[23] = (         short *)0;
        sqlstm.sqinds[23] = (         int  )0;
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
        sqlstm.sqhstv[24] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szCodMoneda);
        sqlstm.sqhstl[24] = (unsigned long )4;
        sqlstm.sqhsts[24] = (         int  )0;
        sqlstm.sqindv[24] = (         short *)0;
        sqlstm.sqinds[24] = (         int  )0;
        sqlstm.sqharm[24] = (unsigned long )0;
        sqlstm.sqadto[24] = (unsigned short )0;
        sqlstm.sqtdso[24] = (unsigned short )0;
        sqlstm.sqhstv[25] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].iCodProducto);
        sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[25] = (         int  )0;
        sqlstm.sqindv[25] = (         short *)0;
        sqlstm.sqinds[25] = (         int  )0;
        sqlstm.sqharm[25] = (unsigned long )0;
        sqlstm.sqadto[25] = (unsigned short )0;
        sqlstm.sqtdso[25] = (unsigned short )0;
        sqlstm.sqhstv[26] = (unsigned char  *)((stTOL_Acumoper.asATOL)[i].szDesPlan);
        sqlstm.sqhstl[26] = (unsigned long )31;
        sqlstm.sqhsts[26] = (         int  )0;
        sqlstm.sqindv[26] = (         short *)0;
        sqlstm.sqinds[26] = (         int  )0;
        sqlstm.sqharm[26] = (unsigned long )0;
        sqlstm.sqadto[26] = (unsigned short )0;
        sqlstm.sqtdso[26] = (unsigned short )0;
        sqlstm.sqhstv[27] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].iCodOperador);
        sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[27] = (         int  )0;
        sqlstm.sqindv[27] = (         short *)0;
        sqlstm.sqinds[27] = (         int  )0;
        sqlstm.sqharm[27] = (unsigned long )0;
        sqlstm.sqadto[27] = (unsigned short )0;
        sqlstm.sqtdso[27] = (unsigned short )0;
        sqlstm.sqhstv[28] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lCntLlamReal);
        sqlstm.sqhstl[28] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[28] = (         int  )0;
        sqlstm.sqindv[28] = (         short *)0;
        sqlstm.sqinds[28] = (         int  )0;
        sqlstm.sqharm[28] = (unsigned long )0;
        sqlstm.sqadto[28] = (unsigned short )0;
        sqlstm.sqtdso[28] = (unsigned short )0;
        sqlstm.sqhstv[29] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lCntLlamFact);
        sqlstm.sqhstl[29] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[29] = (         int  )0;
        sqlstm.sqindv[29] = (         short *)0;
        sqlstm.sqinds[29] = (         int  )0;
        sqlstm.sqharm[29] = (unsigned long )0;
        sqlstm.sqadto[29] = (unsigned short )0;
        sqlstm.sqtdso[29] = (unsigned short )0;
        sqlstm.sqhstv[30] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].lCntLlamDcto);
        sqlstm.sqhstl[30] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[30] = (         int  )0;
        sqlstm.sqindv[30] = (         short *)0;
        sqlstm.sqinds[30] = (         int  )0;
        sqlstm.sqharm[30] = (unsigned long )0;
        sqlstm.sqadto[30] = (unsigned short )0;
        sqlstm.sqtdso[30] = (unsigned short )0;
        sqlstm.sqhstv[31] = (unsigned char  *)&((stTOL_Acumoper.asATOL)[i].iIndCarrier);
        sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[31] = (         int  )0;
        sqlstm.sqindv[31] = (         short *)0;
        sqlstm.sqinds[31] = (         int  )0;
        sqlstm.sqharm[31] = (unsigned long )0;
        sqlstm.sqadto[31] = (unsigned short )0;
        sqlstm.sqtdso[31] = (unsigned short )0;
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



        alltrim(stTOL_Acumoper.asATOL[i].szCodRegi);
        alltrim(stTOL_Acumoper.asATOL[i].szIndExcedente);
        alltrim(stTOL_Acumoper.asATOL[i].szCodPlan);
        alltrim(stTOL_Acumoper.asATOL[i].szIndBillete);
        alltrim(stTOL_Acumoper.asATOL[i].szTipDcto);
        alltrim(stTOL_Acumoper.asATOL[i].szCodDcto);
        alltrim(stTOL_Acumoper.asATOL[i].szCodItem);
        alltrim(stTOL_Acumoper.asATOL[i].szIndUnidad);
        alltrim(stTOL_Acumoper.asATOL[i].szDesConcepto);
        alltrim(stTOL_Acumoper.asATOL[i].szCodMoneda);
        alltrim(stTOL_Acumoper.asATOL[i].szDesPlan);


        i++;

    }/* fin while */

    stTOL_Acumoper.iNumATOL=i-1;

    if( SQLCODE != 0 && SQLCODE != SQLNOTFOUND )
    {

        iDError(szExeName,ERR000,vInsertarIncidencia,"bfnLeeAcumTOL Fetch->TOL_AcumOper",szfnORAerror());
        return(FALSE);
    }

    /* EXEC SQL CLOSE Cur_AcumOperTOL ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 32;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2174;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != 0 )
    {
        iDError(szExeName,ERR000,vInsertarIncidencia,"bfnLeeAcumTOL Close->TOL_AcumOper", szfnORAerror());
        return(FALSE);
    }

    if( SQLCODE == 0 )
    {
            /* EXEC SQL 
            	UPDATE TOL_ACUMOPER_TO
            	   SET NUM_PROCESO = :stStatus.IdPro
            	 WHERE rowid in 
            	 ( SELECT A.rowid
                   FROM   TOL_ACUMOPER_TO       A
                           , FA_CONCEPTOS       B
                 	   , FA_CONCEPTOS       BB
                	   , TA_PLANTARIF       C
                	   , FA_CONCEPTRAIMP_TD D
                 	   , FA_CICLFACT E 
						WHERE  A.NUM_ABONADO = :lhNumAbonado
						/oAND  A.COD_CICLFACT > E.COD_CICLFACT CJGo/
						AND  A.COD_CICLFACT = E.COD_CICLFACT /oCJGo/
						AND E.FEC_EMISION <= (SELECT MAX(FEC_EMISION) FROM FA_CICLFACT WHERE COD_CICLFACT = :lhCodCiclFact)/oCJGo/
						AND  E.IND_FACTURACION >:ihzero
						AND  A.COD_CLIENTE = :lhCodCliente
						AND  A.NUM_PROCESO = :ihzero
						AND  D.COD_CONCDEST = BB.COD_CONCEPTO(+)
						AND  A.COD_CARG = B.COD_CONCEPTO(+)
						AND  B.COD_PRODUCTO = :ihuno
						AND  A.COD_PLAN = C.COD_PLANTARIF(+)
						AND  A.COD_CARG   = D.COD_CONCORIG(+)
						AND  A.COD_AREAA  = D.COD_ZONAORIG(+)); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 32;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update TOL_ACUMOPER_TO  set NUM_PROCESO=:b0 where\
 rowid in (select A.rowid   from TOL_ACUMOPER_TO A ,FA_CONCEPTOS B ,FA_CONCEPT\
OS BB ,TA_PLANTARIF C ,FA_CONCEPTRAIMP_TD D ,FA_CICLFACT E where (((((((((((A.\
NUM_ABONADO=:b1 and A.COD_CICLFACT=E.COD_CICLFACT) and E.FEC_EMISION<=(select \
max(FEC_EMISION)  from FA_CICLFACT where COD_CICLFACT=:b2)) and E.IND_FACTURAC\
ION>:b3) and A.COD_CLIENTE=:b4) and A.NUM_PROCESO=:b3) and D.COD_CONCDEST=BB.C\
OD_CONCEPTO(+)) and A.COD_CARG=B.COD_CONCEPTO(+)) and B.COD_PRODUCTO=:b6) and \
A.COD_PLAN=C.COD_PLANTARIF(+)) and A.COD_CARG=D.COD_CONCORIG(+)) and A.COD_ARE\
AA=D.COD_ZONAORIG(+)))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )2189;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(stStatus.IdPro);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&ihzero;
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
            sqlstm.sqhstv[5] = (unsigned char  *)&ihzero;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&ihuno;
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

     
                
    }

    return(TRUE);
}



BOOL bfnLee_TOL_Acumper(ABONTAR* pAbon)
{
    long lNumAbonado =0;

    lNumAbonado = pAbon->lNumAbonado ;

    vDTrazasLog(szExeName, "\n\t\t* Lee_TOL_Acumper TARIFICACION TOL\n"
                "\t\t=> Cliente [%ld]\n"
                "\t\t=> Abonado [%d] \n",LOG05,stCliente.lCodCliente, lNumAbonado);

/* AQUI agregar mas parametros  */
    if( !bfnLeeAcumTOL(lNumAbonado) )
    {
        iDError(szExeName,ERR005,vInsertarIncidencia,"bfnLee_TOL_Acumper","bfnLeeAcumTOL NO leyo Acumoper_TOL");
        return(FALSE);
    }
    pAbon->iNumConcTOL=stTOL_Acumoper.iNumATOL;
    vDTrazasLog(szExeName, "\n\t\t* Acumuladores TARIFICACION TOL leidos [%d]\n",LOG05, pAbon->iNumConcTOL);

    if( (pAbon->pConcTOL=(CONCTOL *)calloc(pAbon->iNumConcTOL,sizeof(CONCTOL)))==(CONCTOL *)NULL )
    {
        iDError(szExeName,ERR005,vInsertarIncidencia,"bfnLee_TOL_Acumper","pAbon->pConcTOL Error con Calloc");
        return(FALSE);
    }

    memcpy(pAbon->pConcTOL, stTOL_Acumoper.asATOL, sizeof(CONCTOL)*pAbon->iNumConcTOL);

/*  aqui estadistica  */

    return(TRUE);
}



/*****************************************************************************/
/*                        funcion : bEscribeAnoTOL                           */
/*****************************************************************************/
static BOOL bfnEscribeAnoTOL(CONCTOL *pReg)
{
    stAnomProceso.lNumProceso  = stStatus.IdPro        ;
    stAnomProceso.lCodCliente  = stCliente.lCodCliente ;
    stAnomProceso.iCodConcepto =  pReg->ihCodCarg;
    stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact  ;
    stAnomProceso.iCodProducto = pReg->iCodProducto    ;

    strcpy (stAnomProceso.szDesProceso,"PreBilling de Tarificacion TOL");

    return(TRUE);
}/************************* Final bEscribeAnoTar ****************************/



#define zero(m) memset(m,0,sizeof(m))


/*--------------------------------------------------------------------------
  bfn_EMTOLTarificacion(void)
-------------------------------------------------------------------------- */
BOOL bfn_EMTOLTarificacion(int iTipoFact)
{
    int    iInd1         = 0    ;
    int    iInd2         = 0    ;
    int    i             = 0    ;
    int    iCarrier      = 0    ;
    int    iNumAbonados  = 0    ;
    int    iNumConcTOL   = 0    ;
    BOOL   bError        = FALSE;
    int promo, unidad, desc, iCodCarg;
    char szDesPromo[41];
    char szDesUnidadPromo[61];
    char szDesConcepto[110];
    CONCEPTO stConcepto;

    CONCTOL   *pTmpConcTOL   =(CONCTOL   *)NULL;
    ABONTAR   *pTmpAbon      =(ABONTAR   *)NULL;

    iNumAbonados = stCliente.iNumAbonados;
    

    vDTrazasLog(szExeName,  "\n\t\t* Paso a Prefactura TARIFICACION TOL"
                            "\n\t\t=> Cliente        [%ld]\n"
                            "\n\t\t=> Ciclo Factura  [%ld]\n"
                            "\n\t\t=> Numero Abonados[%d] \n",LOG05,stCliente.lCodCliente,
                            stCiclo.lCodCiclFact,stCliente.iNumAbonados);

    for( iInd1=0;iInd1<iNumAbonados;iInd1++ )
    {
        pTmpAbon    =(ABONTAR *)&stCliente.pAbonados[iInd1];
        iNumConcTOL = stCliente.pAbonados[iInd1].iNumConcTOL;
        vDTrazasLog(szExeName,"\t\t* Abonado          : [%ld]\n"
		                    "\n\t\t* Conceptos Tarif. : [%d] \n",LOG04,
		                    pTmpAbon->lNumAbonado,pTmpAbon->iNumConcTOL);

        for( iInd2=0;iInd2<iNumConcTOL;iInd2++ )
        {
            pTmpConcTOL =(CONCTOL *)&pTmpAbon->pConcTOL[iInd2]     ;

            iCodCarg= pTmpConcTOL->ihCodCarg;
            
            if(pTmpConcTOL->iIndCarrier == 0)
			{	
				if(iCodCarg == 0)
				{
					continue;
				}

				vDTrazasLog(szExeName,"\t\t* Concepto  [%d]\n",LOG05, pTmpConcTOL->ihCodCarg);

				/* Descripcion de Promociones */
		        if( !strcmp(pTmpConcTOL->szTipDcto,PROMOCION_TAG)  )
		        {
		        	zero(szDesUnidadPromo);  zero(szDesPromo);
		
		            if( !( unidad=bfnBusca_UnidadPromo(pTmpConcTOL->szIndUnidad) ) )
		            {
		                iDError(szExeName,ERR000,vInsertarIncidencia,"Busca UnidadPromo No encontrada->_LeeDescTOLPromo", pTmpConcTOL->szIndUnidad);
		                return(FALSE);
		            }
		            unidad--;
		            strcpy(szDesUnidadPromo,stTOL_PROMO.asTolPromo[unidad].szDesPromo);
		
		            if( !( promo = bfnBusca_Promo(pTmpConcTOL->szTipDcto, pTmpConcTOL->szCodDcto) ) )
		            {
		                iDError(szExeName,ERR000,vInsertarIncidencia,"Busca Promo->_LeeDescTOLPromo NO ENCONTRADO", pTmpConcTOL->szCodDcto);
		                return(FALSE);
		            }
		            promo--;
		
		            strcpy(szDesPromo,stTOL_DCTO.asTolDcto[promo].szGlsDcto);
		
		            alltrim(szDesUnidadPromo);  alltrim(szDesPromo);
		            sprintf(szDesConcepto,"%s %s",szDesUnidadPromo,szDesPromo);
		            sprintf(pTmpConcTOL->szDesConcepto,"%.*s",(sizeof(pTmpConcTOL->szDesConcepto)-1),szDesConcepto);
		        }
				else if(strcmp(pTmpConcTOL->szTipDcto,ADICIONAL_TAG))
		        {
		            if( !( desc=bfnBusca_Desc(pTmpConcTOL->szTipDcto) ) )
		            {
		                iDError(szExeName,ERR000,vInsertarIncidencia,"Descripcion No encontrada->bfnBusca_Desc", pTmpConcTOL->szTipDcto);
		                return(FALSE);
		            }
		            desc--;
		
		
		            if(pTmpConcTOL->ihCodCarg > 0 )
		            {
		                strcpy(pTmpConcTOL->szDesConcepto,szDesUnidadPromo);
		                sprintf(szDesConcepto,"%s %s",szDesUnidadPromo, stTOL_DESC.asTolDesc[desc].szDescripcion);
		            }
		            else
		            {
		                strcpy(szDesConcepto, stTOL_DESC.asTolDesc[desc].szDescripcion);
		            }
		            sprintf(pTmpConcTOL->szDesConcepto,"%.*s",(sizeof(pTmpConcTOL->szDesConcepto)-1),szDesConcepto);
		        }
			}
	
	        if( (pTmpConcTOL->dhMtoReal >= 0.01) || (pstParamGener.iConsConcTrafico == 1) )
	        {
	            /*if( stPreFactura.iNumRegistros >= MAX_CONCFACTUR )
	            {
	                iDError(szExeName,ERR035,vInsertarIncidencia,"Out of Range stPrefactura","se paso de la raya");
	                return(FALSE);
	            }*/
	            
	            i = stPreFactura.iNumRegistros;
	            
	            stPreFactura.A_PFactura[i].bOptTrafico      = TRUE                 ;
	            stPreFactura.A_PFactura[i].lNumProceso      = stStatus.IdPro       ;
	            stPreFactura.A_PFactura[i].lCodCliente      = stCliente.lCodCliente;
	            stPreFactura.A_PFactura[i].iCodConcepto     = iCodCarg;
	
		        if( !bFindConcepto (iCodCarg, &stConcepto) )
		            return(FALSE);
	
	            strcpy(stPreFactura.A_PFactura[i].szDesConcepto , stConcepto.szDesConcepto);
	            vDTrazasLog(szExeName,"\t\t* Calculo Num_Pulso\n"
	            					  "\t\t* lhDurReal [%ld]\n"
	            					  "\t\t* lFactor   [%ld]\n"
	            					  "\t\t* Num_pulso [%ld]\n"        					  
	            					  ,LOG05
	            					  ,pTmpConcTOL->lhDurReal
	            					  ,stConcepto.lFactor
	            					  ,pTmpConcTOL->lhDurReal / stConcepto.lFactor);
	            
	            stPreFactura.A_PFactura[i].lhNumPulsos  = pTmpConcTOL->lhDurReal / stConcepto.lFactor; /*Numero de Pulsos*/
	            
	            if( !bGetMaxColPreFa(stPreFactura.A_PFactura[i].iCodConcepto, &stPreFactura.A_PFactura[i].lColumna) )
	                return(FALSE);
	            stPreFactura.A_PFactura[i].iCodProducto = pTmpConcTOL->iCodProducto   ;
	            strcpy(stPreFactura.A_PFactura[i].szFecEfectividad , szSysDate);
	            strcpy(stPreFactura.A_PFactura[i].szFecValor , stCiclo.szFecEmision);
	            stPreFactura.A_PFactura[i].dImpConcepto     = pTmpConcTOL->dhMtoFact;
	            /* inc 43878 PPV 22/10/2007 */
	            /*stPreFactura.A_PFactura.dImpFacturable  [i] = fnCnvDouble(pTmpConcTOL->dhMtoFact, USOFACT);*/
	            stPreFactura.A_PFactura[i].dImpFacturable   = fnCnvDouble(pTmpConcTOL->dhMtoFact, 0);
	            stPreFactura.A_PFactura[i].dImpMontoBase    = 0.0       ;
	            stPreFactura.A_PFactura[i].lSegConsumido    = pTmpConcTOL->lhDurFact;
	            stPreFactura.A_PFactura[i].lCodPlanCom      = stCliente.lCodPlanCom  ;
	            stPreFactura.A_PFactura[i].iIndFactur       = pTmpAbon->iIndFactur   ;
	            stPreFactura.A_PFactura[i].iCodCatImpos     = stCliente.iCodCatImpos ;
	            stPreFactura.A_PFactura[i].iCodPortador     = pTmpConcTOL->iCodOperador;
	            stPreFactura.A_PFactura[i].iIndEstado       = EST_NORMAL;
	            stPreFactura.A_PFactura[i].lNumUnidades     = pTmpConcTOL->dhCntInicial ;
	            stPreFactura.A_PFactura[i].iCodTipConce     = pTmpConcTOL->iCodTipConce;
	            stPreFactura.A_PFactura[i].lCodCiclFact     = stCiclo.lCodCiclFact   ;
	            stPreFactura.A_PFactura[i].iCodConceRel     = 0         ;
	            stPreFactura.A_PFactura[i].lColumnaRel      = 0         ;
	            stPreFactura.A_PFactura[i].lNumAbonado      = pTmpConcTOL->lhNumAbonado;
	            strcpy(stPreFactura.A_PFactura[i].szCodRegion   , stCliente.szCodRegion   );
	            strcpy(stPreFactura.A_PFactura[i].szCodProvincia, stCliente.szCodProvincia);
	            strcpy(stPreFactura.A_PFactura[i].szCodCiudad   , stCliente.szCodCiudad   );
	            strcpy(stPreFactura.A_PFactura[i].szCodModulo   , "TA");
	            strcpy(stPreFactura.A_PFactura[i].szCodMoneda   , pTmpConcTOL->szCodMoneda);
	            stPreFactura.A_PFactura[i].szNumTerminal   [0] = 0;
	            stPreFactura.A_PFactura[i].szNumSerieMec   [0] = 0;
	            stPreFactura.A_PFactura[i].szNumSerieLe    [0] = 0;
	            stPreFactura.A_PFactura[i].lCapCode         = ORA_NULL;
	            stPreFactura.A_PFactura[i].iFlagImpues      = 0       ;
	            stPreFactura.A_PFactura[i].iFlagDto         =(stPreFactura.A_PFactura[i].iCodTipConce == CARRIER)?0:1;
	            if( !iCarrier && stPreFactura.A_PFactura[i].iCodTipConce  == CARRIER )    iCarrier = 1;
	            stPreFactura.A_PFactura[i].fPrcImpuesto     =(stPreFactura.A_PFactura[i].iCodTipConce==IMPUESTO)? stDatosGener.fPctIva:0.0;
	            stPreFactura.A_PFactura[i].dValDto          = 0.0     ;
	            stPreFactura.A_PFactura[i].iTipDto          = 0       ;
	            stPreFactura.A_PFactura[i].lNumVenta        = 0       ;
	            stPreFactura.A_PFactura[i].lNumTransaccion  = 0       ;
	            stPreFactura.A_PFactura[i].iMesGarantia     = 0       ;
	            stPreFactura.A_PFactura[i].iIndAlta         = 0       ;
	            stPreFactura.A_PFactura[i].iIndSuperTel     = 0       ;
	            stPreFactura.A_PFactura[i].iNumPaquete      = 0       ;
	            stPreFactura.A_PFactura[i].iIndCuota        = 0       ;
	            stPreFactura.A_PFactura[i].iNumCuotas       = 0       ;
	            stPreFactura.A_PFactura[i].iOrdCuota        = 0       ;
	
	            strcpy( stPreFactura.A_PFactura[i].szCodRegi        ,   pTmpConcTOL->szCodRegi      );
	            stPreFactura.A_PFactura[i].lhCodGrupo       =   pTmpConcTOL->lhCodGrupo     ;
	            stPreFactura.A_PFactura[i].lhCodCliente     =   pTmpConcTOL->lhCodCliente   ;
	            stPreFactura.A_PFactura[i].lhCodCiclFact    =   pTmpConcTOL->lhCodCiclFact  ;
	            stPreFactura.A_PFactura[i].lhNumProceso     =   pTmpConcTOL->lhNumProceso   ;
	            strcpy( stPreFactura.A_PFactura[i].szIndExcedente   ,   pTmpConcTOL->szIndExcedente);
	            strcpy( stPreFactura.A_PFactura[i].szCodPlan        ,   pTmpConcTOL->szCodPlan      );
	            strcpy( stPreFactura.A_PFactura[i].szIndBillete     ,   pTmpConcTOL->szIndBillete   );
	            strcpy( stPreFactura.A_PFactura[i].szTipDcto        ,   pTmpConcTOL->szTipDcto      );
	            strcpy( stPreFactura.A_PFactura[i].szCodDcto        ,   pTmpConcTOL->szCodDcto      );
	            strcpy( stPreFactura.A_PFactura[i].szCodItem        ,   pTmpConcTOL->szCodItem      );
	            strcpy( stPreFactura.A_PFactura[i].szIndUnidad      ,   pTmpConcTOL->szIndUnidad    );
	            stPreFactura.A_PFactura[i].dhCntAux         =   pTmpConcTOL->dhCntAux       ;
	            stPreFactura.A_PFactura[i].dhMtoReal        =   pTmpConcTOL->dhMtoReal      ;
	            stPreFactura.A_PFactura[i].dhMtoDcto        =   pTmpConcTOL->dhMtoDcto      ;
	            stPreFactura.A_PFactura[i].lhDurReal        =   pTmpConcTOL->lhDurReal      ;
	            stPreFactura.A_PFactura[i].lhDurDcto        =   pTmpConcTOL->lhDurDcto      ;
	            strcpy( stPreFactura.A_PFactura[i].szDesPlan        ,   pTmpConcTOL->szDesPlan      );
	
	            stPreFactura.A_PFactura[i].lhCntLlamReal    =   pTmpConcTOL->lCntLlamReal   ;
	            stPreFactura.A_PFactura[i].lhCntLlamFact    =   pTmpConcTOL->lCntLlamFact   ;
	            stPreFactura.A_PFactura[i].lhCntLlamDcto    =   pTmpConcTOL->lCntLlamDcto   ;
	
	            vDTrazasLog(szExeName,  "\t\t* bfn_EMTOLTarificacion stPreFactura.A_PFactura[%d] \n"
	                                    "\t\t\t\tlNumAbonado   = [%ld]\n"
	                                    "\t\t\t\tiCodConcepto  = [%d]\n"
	                                    "\t\t\t\tlColumna	   = [%ld]\n"
	                                    "\t\t\t\tszDesConcepto = [%s]\n"
	                                    "\t\t\t\tszTipDcto     = [%s]\n"
	                                    "\t\t\t\tszCodDcto     = [%s]\n"
	                                    "\t\t\t\tdImpConcepto  = [%.2f]\n"
	                                    "\t\t\t\tdImpFacturable= [%.2f]\n"
	                                    "\t\t\t\tdImpMontoBase = [%.2f]\n"
	                                    "\t\t\t\tlSegConsumido = [%ld]\n"
	                                    "\t\t\t\tdhMtoReal     = [%.2f]\n"
	                                    "\t\t\t\tdhMtoDcto     = [%.2f]\n"
	                                    "\t\t\t\tlhDurReal     = [%ld]\n"
	                                    "\t\t\t\tlhDurDcto     = [%ld]\n"
	                        ,LOG04,  i,
	                        stPreFactura.A_PFactura[i].lNumAbonado   ,
	                        stPreFactura.A_PFactura[i].iCodConcepto  ,
						    stPreFactura.A_PFactura[i].lColumna	     ,
	                        stPreFactura.A_PFactura[i].szDesConcepto ,
	                        stPreFactura.A_PFactura[i].szTipDcto     ,
	                        stPreFactura.A_PFactura[i].szCodDcto     ,
	                        stPreFactura.A_PFactura[i].dImpConcepto  ,
	                        stPreFactura.A_PFactura[i].dImpFacturable,
	                        stPreFactura.A_PFactura[i].dImpMontoBase ,
	                        stPreFactura.A_PFactura[i].lSegConsumido ,
	                        stPreFactura.A_PFactura[i].dhMtoReal     ,
	                        stPreFactura.A_PFactura[i].dhMtoDcto     ,
	                        stPreFactura.A_PFactura[i].lhDurReal     ,
	                        stPreFactura.A_PFactura[i].lhDurDcto     
	
	                    );
	
	            vPrintRegInsert(i,"Trafico TOL",bError);
	            if(bfnIncrementarIndicePreFactura()==FALSE)
	            {
	                vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	                vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	                return FALSE;
	            }
	
	        }
         	else
         	{
            	if(!bfnEscribeAnoTOL(pTmpConcTOL))
                	return(FALSE);
         	}
        }/* fin for iInd2 ... */
    }/* fin for iInd1 ... */

     if(iCarrier)
		 vfnRelacionCarrier();

    return(TRUE);
}
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

