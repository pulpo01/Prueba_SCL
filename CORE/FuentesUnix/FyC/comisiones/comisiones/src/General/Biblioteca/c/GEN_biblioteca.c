
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
           char  filnam[23];
};
static struct sqlcxp sqlfpn =
{
    22,
    "./pc/GEN_biblioteca.pc"
};


static unsigned int sqlctx = 220954099;


static struct sqlexd {
   unsigned long  sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
            short *cud;
   unsigned char  *sqlest;
            char  *stmt;
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
   unsigned char  *sqhstv[15];
   unsigned long  sqhstl[15];
            int   sqhsts[15];
            short *sqindv[15];
            int   sqinds[15];
   unsigned long  sqharm[15];
   unsigned long  *sqharc[15];
   unsigned short  sqadto[15];
   unsigned short  sqtdso[15];
} sqlstm = {12,15};

/* SQLLIB Prototypes */
extern sqlcxt (/*_ void **, unsigned int *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned int *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned int *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

 static char *sq0036 = 
"select distinct A.COD_TIPORED ,C.DES_TIPORED ,H.COD_TIPCOMIS ,G.DES_TIPCOMIS\
 ,D.COD_TIPCOMIS ,E.DES_TIPCOMIS  from CMD_CONCEPTOS F ,CM_CONCEPTOSTIPORED_TD\
 A ,CM_PLANESTIPORED_TD B ,VE_TIPORED_TD C ,VE_DETALLE_TIPORED_TD D ,VE_DETALL\
E_TIPORED_TD H ,VE_TIPCOMIS E ,VE_TIPCOMIS G where (((((((((((((((F.COD_UNIVER\
SO=:b0 and F.TIP_CICLCOMIS=:b1) and F.COD_CONCEPTO=A.COD_CONCEPTO) and A.COD_P\
LANCOMIS=B.COD_PLANCOMIS) and A.COD_TIPORED=B.COD_TIPORED) and B.FEC_DESDE<=TO\
_DATE(:b2,'DD-MM-YYYY')) and B.FEC_HASTA>=TO_DATE(:b3,'DD-MM-YYYY')) and B.COD\
_TIPORED=C.COD_TIPORED) and C.COD_CICLOCOMIS=:b4) and C.COD_TIPORED=D.COD_TIPO\
RED) and D.NUM_NIVEL=A.NIV_SELECCION) and D.COD_TIPCOMIS=E.COD_TIPCOMIS) and C\
.COD_TIPORED=H.COD_TIPORED) and A.NIV_APLICACION=H.NUM_NIVEL) and H.COD_TIPCOM\
IS=G.COD_TIPCOMIS) and (:b5=:b6 or (:b5<>:b6 and F.IND_PARCIAL=:b9)))         \
  ";

 static char *sq0037 = 
"select distinct A.COD_TIPORED ,C.DES_TIPORED ,H.COD_TIPCOMIS ,G.DES_TIPCOMIS\
 ,D.COD_TIPCOMIS ,E.DES_TIPCOMIS  from CMD_CONCEPTOS F ,CM_CONCEPTOSTIPORED_TD\
 A ,CM_PLANESTIPORED_TD B ,VE_TIPORED_TD C ,VE_DETALLE_TIPORED_TD D ,VE_DETALL\
E_TIPORED_TD H ,VE_TIPCOMIS E ,VE_TIPCOMIS G where ((((((((((((((((F.COD_UNIVE\
RSO=:b0 and F.TIP_CICLCOMIS=:b1) and F.ID_CICLCOMIS=:b2) and F.COD_CONCEPTO=A.\
COD_CONCEPTO) and A.COD_PLANCOMIS=B.COD_PLANCOMIS) and A.COD_TIPORED=B.COD_TIP\
ORED) and B.FEC_DESDE<=TO_DATE(:b3,'DD-MM-YYYY')) and B.FEC_HASTA>=TO_DATE(:b4\
,'DD-MM-YYYY')) and B.COD_TIPORED=C.COD_TIPORED) and C.COD_CICLOCOMIS=:b5) and\
 C.COD_TIPORED=D.COD_TIPORED) and D.NUM_NIVEL=A.NIV_SELECCION) and D.COD_TIPCO\
MIS=E.COD_TIPCOMIS) and C.COD_TIPORED=H.COD_TIPORED) and A.NIV_APLICACION=H.NU\
M_NIVEL) and H.COD_TIPCOMIS=G.COD_TIPCOMIS) and (:b6=:b7 or (:b6<>:b7 and F.IN\
D_PARCIAL=:b10)))           ";

 static char *sq0038 = 
"select A.COD_TIPORED ,B.COD_PLANCOMIS ,E.COD_TIPCOMIS ,C.COD_CONCEPTO ,TO_CH\
AR(B.FEC_DESDE,'DD-MM-YYYY') ,TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY') ,D.TIP_CALCULO\
 ,D.COD_TECNOLOGIA ,D.COD_UNIVERSO ,TO_CHAR(B.FEC_DESDE,'YYYYMMDDHH24MISS') ,T\
O_CHAR(B.FEC_HASTA,'YYYYMMDDHH24MISS')  from VE_TIPORED_TD A ,CM_PLANESTIPORED\
_TD B ,CM_CONCEPTOSTIPORED_TD C ,CMD_CONCEPTOS D ,VE_DETALLE_TIPORED_TD E wher\
e (((((((((((A.COD_CICLOCOMIS=:b0 and A.COD_TIPORED=B.COD_TIPORED) and B.FEC_D\
ESDE<TO_DATE(:b1,'DD-MM-YYYY')) and B.FEC_HASTA>TO_DATE(:b2,'DD-MM-YYYY')) and\
 B.COD_TIPORED=C.COD_TIPORED) and B.COD_PLANCOMIS=C.COD_PLANCOMIS) and C.COD_C\
ONCEPTO=D.COD_CONCEPTO) and D.COD_FORMA=:b3) and D.TIP_CICLCOMIS=:b4) and C.CO\
D_TIPORED=E.COD_TIPORED) and C.NIV_APLICACION=E.NUM_NIVEL) and (:b5=:b6 or (:b\
5<>:b6 and D.IND_PARCIAL=:b9)))           ";

 static char *sq0039 = 
"select A.COD_TIPORED ,B.COD_PLANCOMIS ,E.COD_TIPCOMIS ,C.COD_CONCEPTO ,TO_CH\
AR(B.FEC_DESDE,'DD-MM-YYYY') ,TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY') ,D.TIP_CALCULO\
 ,D.COD_TECNOLOGIA ,D.COD_UNIVERSO ,TO_CHAR(B.FEC_DESDE,'YYYYMMDDHH24MISS') ,T\
O_CHAR(B.FEC_HASTA,'YYYYMMDDHH24MISS')  from VE_TIPORED_TD A ,CM_PLANESTIPORED\
_TD B ,CM_CONCEPTOSTIPORED_TD C ,CMD_CONCEPTOS D ,VE_DETALLE_TIPORED_TD E wher\
e (((((((((((A.COD_CICLOCOMIS=:b0 and A.COD_TIPORED=B.COD_TIPORED) and B.FEC_D\
ESDE<TO_DATE(:b1,'DD-MM-YYYY')) and B.FEC_HASTA>TO_DATE(:b2,'DD-MM-YYYY')) and\
 B.COD_TIPORED=C.COD_TIPORED) and B.COD_PLANCOMIS=C.COD_PLANCOMIS) and C.COD_C\
ONCEPTO=D.COD_CONCEPTO) and D.COD_FORMA in ('ALTACONTRA','FONDOSCOAP','PRESENC\
IA')) and D.TIP_CICLCOMIS=:b3) and C.COD_TIPORED=E.COD_TIPORED) and C.NIV_APLI\
CACION=E.NUM_NIVEL) and (:b4=:b5 or (:b4<>:b5 and D.IND_PARCIAL=:b8)))        \
   ";

 static char *sq0040 = 
"select C.COD_TIPORED ,C.COD_PLANCOMIS ,E.COD_TIPCOMIS ,D.COD_CONCEPTO ,TO_CH\
AR(B.FEC_DESDE,'DD-MM-YYYY') ,TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY') ,D.TIP_CALCULO\
 ,D.COD_TECNOLOGIA ,D.COD_UNIVERSO  from CM_PLANESTIPORED_TD B ,CM_CONCEPTOSTI\
PORED_TD C ,CMD_CONCEPTOS D ,VE_DETALLE_TIPORED_TD E where ((((((((D.TIP_CICLC\
OMIS=:b0 and D.ID_CICLCOMIS=:b1) and D.COD_FORMA=:b2) and D.COD_CONCEPTO=C.COD\
_CONCEPTO) and C.COD_TIPORED=B.COD_TIPORED) and C.COD_PLANCOMIS=B.COD_PLANCOMI\
S) and C.COD_TIPORED=E.COD_TIPORED) and C.NIV_APLICACION=E.NUM_NIVEL) and (:b3\
=:b4 or (:b3<>:b4 and D.IND_PARCIAL=:b7)))           ";

 static char *sq0041 = 
"select C.COD_TIPORED ,C.COD_PLANCOMIS ,E.COD_TIPCOMIS ,D.COD_CONCEPTO ,TO_CH\
AR(B.FEC_DESDE,'DD-MM-YYYY') ,TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY') ,D.TIP_CALCULO\
 ,D.COD_TECNOLOGIA ,D.COD_UNIVERSO  from CM_PLANESTIPORED_TD B ,CM_CONCEPTOSTI\
PORED_TD C ,CMD_CONCEPTOS D ,VE_DETALLE_TIPORED_TD E where ((((((((D.TIP_CICLC\
OMIS=:b0 and D.ID_CICLCOMIS=:b1) and D.COD_FORMA in ('ALTACONTRA','FONDOSCOAP'\
,'PRESENCIA')) and D.COD_CONCEPTO=C.COD_CONCEPTO) and C.COD_TIPORED=B.COD_TIPO\
RED) and C.COD_PLANCOMIS=B.COD_PLANCOMIS) and C.COD_TIPORED=E.COD_TIPORED) and\
 C.NIV_APLICACION=E.NUM_NIVEL) and (:b2=:b3 or (:b2<>:b3 and D.IND_PARCIAL=:b6\
)))           ";

 static char *sq0042 = 
"select distinct D.COD_TIPCOMIS  from CM_CONCEPTOSTIPORED_TD A ,CM_PLANESTIPO\
RED_TD B ,VE_TIPORED_TD C ,VE_DETALLE_TIPORED_TD D where ((((((((A.COD_CONCEPT\
O=:b0 and A.COD_TIPORED=B.COD_TIPORED) and A.COD_PLANCOMIS=B.COD_PLANCOMIS) an\
d B.FEC_DESDE<=TO_DATE(:b1,'DD-MM-YYYY')) and B.FEC_HASTA>=TO_DATE(:b2,'DD-MM-\
YYYY')) and B.COD_TIPORED=C.COD_TIPORED) and C.COD_CICLOCOMIS=:b3) and C.COD_T\
IPORED=D.COD_TIPORED) and D.NUM_NIVEL=A.NIV_SELECCION)           ";

 static char *sq0048 = 
"select distinct COD_VENDEDOR ,COD_VENDE_PADRE ,NUM_NIVEL  from (select COD_T\
IPORED ,NUM_NIVEL ,COD_VENDEDOR ,DECODE(COD_PADRE,0,null ,COD_VENDE_PADRE) COD\
_VENDE_PADRE  from (select COD_TIPORED ,NUM_NIVEL ,COD_VENDEDOR ,(COD_VENDEDOR\
-COD_VENDE_PADRE) COD_PADRE ,COD_VENDE_PADRE  from VE_REDVENTAS_TD where (SYSD\
ATE between FEC_DESDE and FEC_HASTA or FEC_HASTA is null )) ) where COD_TIPORE\
D=:b0 start with COD_VENDEDOR=:b1  connect by prior COD_VENDEDOR=COD_VENDE_PAD\
RE  order by NUM_NIVEL,COD_VENDEDOR            ";

 static char *sq0059 = 
"select ARCH.COD_ARCHIVO ,ARCH.NOM_FISICO ,NVL(ARCH.CAR_SEPARADOR,'X') ,ARCH.\
IND_EJECUCION ,DET.NOM_CAMPO ,NVL(DET.NOM_ETIQUETA,DET.NOM_CAMPO) ,DET.NUM_ORD\
EN ,DET.LARGO_CAMPO ,DET.IND_JUSTIFICADO ,NVL(DET.CAR_RELLENO,' ') ,CAM.TIP_DA\
TO  from CM_ARCHIVOS_TD ARCH ,CM_DETALLE_ARCHIVO_TD DET ,CM_CAMPOS_UNIVERSO_TD\
 CAM where (((((ARCH.COD_UNIVERSO=DET.COD_UNIVERSO and ARCH.COD_UNIVERSO=CAM.C\
OD_UNIVERSO) and DET.NOM_CAMPO=CAM.NOM_CAMPO) and ARCH.COD_ARCHIVO=DET.COD_ARC\
HIVO) and ARCH.COD_UNIVERSO=:b0) and ARCH.IND_EJECUCION=:b1) order by ARCH.COD\
_ARCHIVO,DET.NUM_ORDEN desc             ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,85,0,4,88,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,5,0,0,
32,0,0,2,90,0,4,102,0,0,1,0,0,1,0,2,3,0,0,
51,0,0,3,132,0,4,119,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
78,0,0,4,95,0,4,138,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
101,0,0,5,115,0,4,152,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,
128,0,0,6,111,0,4,166,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
155,0,0,7,241,0,4,183,0,0,5,4,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
190,0,0,8,241,0,4,205,0,0,5,4,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
225,0,0,9,74,0,4,234,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
248,0,0,10,32,0,4,246,0,0,1,0,0,1,0,2,5,0,0,
267,0,0,11,152,0,3,257,0,0,6,6,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,1,0,0,1,
5,0,0,
306,0,0,12,0,0,31,267,0,0,0,0,0,1,0,
321,0,0,13,0,0,31,271,0,0,0,0,0,1,0,
336,0,0,14,0,0,31,275,0,0,0,0,0,1,0,
351,0,0,15,0,0,31,279,0,0,0,0,0,1,0,
366,0,0,16,0,0,29,283,0,0,0,0,0,1,0,
381,0,0,17,153,0,5,288,0,0,2,2,0,1,0,1,1,0,0,1,5,0,0,
404,0,0,18,0,0,31,298,0,0,0,0,0,1,0,
419,0,0,19,0,0,31,303,0,0,0,0,0,1,0,
434,0,0,20,0,0,31,308,0,0,0,0,0,1,0,
449,0,0,21,0,0,29,312,0,0,0,0,0,1,0,
464,0,0,22,89,0,4,379,0,0,3,1,0,1,0,2,3,0,0,2,97,0,0,1,3,0,0,
491,0,0,23,186,0,3,392,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,3,0,0,1,1,0,0,
534,0,0,24,229,0,5,402,0,0,8,8,0,1,0,1,1,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,97,0,0,1,97,0,0,
581,0,0,25,255,0,5,415,0,0,9,9,0,1,0,1,1,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
632,0,0,26,0,0,31,432,0,0,0,0,0,1,0,
647,0,0,27,0,0,29,435,0,0,0,0,0,1,0,
662,0,0,28,51,0,4,448,0,0,1,0,0,1,0,2,3,0,0,
681,0,0,29,0,0,31,467,0,0,0,0,0,1,0,
696,0,0,30,0,0,31,497,0,0,0,0,0,1,0,
711,0,0,31,0,0,31,505,0,0,0,0,0,1,0,
726,0,0,32,100,0,4,875,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
753,0,0,33,55,0,4,928,0,0,1,0,0,1,0,2,97,0,0,
772,0,0,34,556,0,4,965,0,0,15,1,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,1,0,0,2,97,0,0,2,97,
0,0,1,97,0,0,
847,0,0,35,63,0,4,1058,0,0,1,0,0,1,0,2,97,0,0,
866,0,0,36,858,0,9,1147,0,0,10,10,0,1,0,1,97,0,0,1,1,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
921,0,0,36,0,0,13,1151,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,97,0,0,
960,0,0,36,0,0,15,1179,0,0,0,0,0,1,0,
975,0,0,37,884,0,9,1266,0,0,11,11,0,1,0,1,97,0,0,1,1,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1034,0,0,37,0,0,13,1270,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,
1073,0,0,37,0,0,15,1297,0,0,0,0,0,1,0,
1088,0,0,38,820,0,9,1387,0,0,10,10,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
1,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1143,0,0,38,0,0,13,1391,0,0,11,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
1202,0,0,38,0,0,15,1429,0,0,0,0,0,1,0,
1217,0,0,39,859,0,9,1516,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,1,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1268,0,0,39,0,0,13,1520,0,0,11,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
1327,0,0,39,0,0,15,1558,0,0,0,0,0,1,0,
1342,0,0,40,597,0,9,1645,0,0,8,8,0,1,0,1,1,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1389,0,0,40,0,0,13,1649,0,0,9,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
1440,0,0,40,0,0,15,1683,0,0,0,0,0,1,0,
1455,0,0,41,636,0,9,1759,0,0,7,7,0,1,0,1,1,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,
1498,0,0,41,0,0,13,1763,0,0,9,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
1549,0,0,41,0,0,15,1797,0,0,0,0,0,1,0,
1564,0,0,42,453,0,9,1869,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
1595,0,0,42,0,0,13,1873,0,0,1,0,0,1,0,2,97,0,0,
1614,0,0,42,0,0,15,1895,0,0,0,0,0,1,0,
1629,0,0,43,162,0,4,1924,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
1656,0,0,44,32,0,4,1954,0,0,1,0,0,1,0,2,97,0,0,
1675,0,0,45,32,0,4,1969,0,0,1,0,0,1,0,2,97,0,0,
1694,0,0,46,96,0,4,1986,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
1717,0,0,47,168,0,4,2009,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
1744,0,0,48,513,0,9,2093,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1767,0,0,48,0,0,13,2097,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
1794,0,0,48,0,0,15,2116,0,0,0,0,0,1,0,
1809,0,0,49,87,0,4,2145,0,0,3,2,0,1,0,1,3,0,0,1,3,0,0,2,3,0,0,
1836,0,0,50,165,0,4,2163,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
1859,0,0,51,0,0,17,2201,0,0,1,1,0,1,0,1,97,0,0,
1878,0,0,51,0,0,21,2203,0,0,4,4,0,1,0,1,1,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1909,0,0,52,0,0,29,2206,0,0,0,0,0,1,0,
1924,0,0,51,0,0,17,2231,0,0,1,1,0,1,0,1,97,0,0,
1943,0,0,51,0,0,45,2233,0,0,1,1,0,1,0,1,3,0,0,
1962,0,0,51,0,0,13,2234,0,0,1,0,0,1,0,2,3,0,0,
1981,0,0,53,85,0,5,2257,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,
2008,0,0,54,140,0,4,2285,0,0,6,4,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,2,3,
0,0,2,3,0,0,
2047,0,0,55,151,0,4,2320,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
2074,0,0,56,272,0,4,2330,0,0,6,2,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,1,3,0,
0,1,3,0,0,
2113,0,0,57,113,0,4,2381,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2144,0,0,58,118,0,4,2397,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2175,0,0,59,584,0,9,2480,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
2198,0,0,59,0,0,13,2484,0,0,11,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2257,0,0,59,0,0,15,2529,0,0,0,0,0,1,0,
2272,0,0,60,91,0,4,2593,0,0,6,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,2,3,0,0,
2311,0,0,61,92,0,4,2633,0,0,7,6,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,1,97,0,0,2,3,0,0,
2354,0,0,62,815,0,4,2767,0,0,15,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,1,3,
0,0,1,3,0,0,
};


/*******************************************************************************/
/* Nombre       : GEN_biblioteca.pc                                            */
/* Objetivo : Biblioteca de rutinas de uso general por los programas de        */
/*            Comisiones.                                                      */
/* Autor        : Richard Troncoso C.                                          */
/* Fecha        : 30/10/2001                                                   */
/*                                                                             */
/* tabstop=4                                                                   */
/* Modificacones   fecha         Descripcion                                   */
/* Jaime Vargas    19/12/2002    Se incorpora nueva rutina que controlara los  */
/*                               blancos a la derecha                          */
/*                               de una cadema de caracteres                   */
/*******************************************************************************/
/* Incorporacion de nuevo procedimiento que carga periodos                     */
/* PGonzaleg 26-12-2002                                                        */
/*******************************************************************************/
/* 1. Se corrige funcion de carga de ciclos, para que reciba por parámetro el  */
/*    ciclo a cargar y la estructura vacía donde cargar los datos, y devuelva  */
/*    un TRUE/FALSE dependiendo del resultado de la carga.                     */
/* 2. Se incorpran funciones de carga de esdtructuras de apoyo a la selección. */
/*    Esta estructura es definida en archivo .h, y su uso se hace extensivo a  */
/*    todos los procesos de Selección de Información.                          */
/* 3. Se incorpran funciones de carga de estructura de apoyo a la valoración   */
/*    de la información, referente a los conceptos y tipos de comisionista     */
/*    sobre los que se aplican las distintas formas comisionales. Su uso se    */
/*    hace extensivo a todos los procesos de Valoración.                       */
/* Fabián Aedo R. Jul-2003 Cuzco.                                              */
/*                                                                             */
/* 4. Se incorpora funcion para validar si se deben ejecutar procesos de       */
/*    Gestor de Retensiones.                                                   */
/*******************************************************************************/

#define _Bibliotecas_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include "GEN_biblioteca.h"


/*---------------------------------------------------------------------------*/
/* Inclusion de biblioteca para manejo de interaccion con Oracle.            */
/*---------------------------------------------------------------------------*/
/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986, 1998 by Oracle Corporation. */
 
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


/******************************************************************************
 * Valida que agrega-modifica-cierra traza de bloque. CMT_TRAZAS_BLOQUES
 * Retorno: 
 *              < 0 -> Error Oracle.
 *              = 0 -> Exito.
 *              > 0 -> Error no grave.
 ******************************************************************************/

int iModifica_Traza_Bloque()
{
        char reproceso;

        /* EXEC SQL begin declare section; */ 

                short   sql_ord_bloque;
                short   sql_ord_primer_bloque;
                int             sql_veces;
                long    sql_cod_periodo;
                long    sql_sec_bloque;
                char    sql_ind_estado;
                char    sql_cod_bloque[16]; /* EXEC SQL var sql_cod_bloque is string(16); */ 

                char    sql_cod_bloque_ant[16]; /* EXEC SQL var sql_cod_bloque_ant is string(16); */ 

                char    sql_cod_linea_proc[3]; /* EXEC SQL var sql_cod_linea_proc is string(3); */ 

                char    sql_id_periodo[11]; /* EXEC SQL var sql_id_periodo is string(11); */ 

                char    sql_nom_usuario[31]; /* EXEC SQL var sql_nom_usuario is string(31); */ 

        /* EXEC SQL end declare section; */ 


        strcpy(sql_cod_bloque, bloque.cod_bloque);
        strcpy(sql_id_periodo, bloque.id_periodo);
        /*
        strcpy(sql_nom_usuario, bloque.nom_usuario);
        */
        sql_ind_estado = bloque.ind_estado;
        sql_sec_bloque = bloque.sec_bloque;

        fprintf(stderr,"\n\n >>>>>>>>>>>> BIBLIOTECA  BLOQUES <<<<<<<<<<<<<<<<\n\n");

        fprintf(stderr," BLOQUE: [%s] PERIODO: [%s] ESTADO: [%c] SECUENCIA_BLOQUE: [%d]\n",
                sql_cod_bloque, sql_id_periodo, sql_ind_estado, sql_sec_bloque);
        fprintf(stderr,"\n\n");

        /* obtencion de parametros del bloque */
        /* EXEC SQL select ord_bloque, cod_linea_proc
                         into   :sql_ord_bloque, :sql_cod_linea_proc
                         from   cmd_bloques
                         where  cod_bloque = :sql_cod_bloque; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select ord_bloque ,cod_linea_proc into :b0,:b1  from \
cmd_bloques where cod_bloque=:b2";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sql_ord_bloque;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sql_cod_linea_proc;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sql_cod_bloque;
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



        if (sqlca.sqlcode == -915)
                return EXIT__506;
        else if (sqlca.sqlcode)
                return EXIT_505;

        reproceso = sql_cod_linea_proc[0];

        /* verificacion del bloque en ejecucion */
        sql_veces = 0;
        /* EXEC SQL select count(*)
                         into   :sql_veces
                         from   cmt_trazas_bloques
                         where  sec_bloque > 0
                           and  ind_estado = 'I'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(*)  into :b0  from cmt_trazas_bloques wh\
ere (sec_bloque>0 and ind_estado='I')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )32;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sql_veces;
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



        if (sqlca.sqlcode == -1031)
                return EXIT__509;       
        else if (sqlca.sqlcode == -915)
                return EXIT__506;
        else if (sqlca.sqlcode)
                return EXIT__500;
        else if (sql_veces && sql_ind_estado == 'I') 
                return EXIT_501;

        /* verificacion de bloque cerrado */
        sql_veces = 0;
        /* EXEC SQL select count(*)
                         into   :sql_veces
                         from   cmt_trazas_bloques
                         where  sec_bloque > 0
                           and  cod_bloque = :sql_cod_bloque
                           and  id_periodo = :sql_id_periodo
                           and  ind_estado = 'T'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(*)  into :b0  from cmt_trazas_bloques wh\
ere (((sec_bloque>0 and cod_bloque=:b1) and id_periodo=:b2) and ind_estado='T'\
)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )51;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sql_veces;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sql_cod_bloque;
        sqlstm.sqhstl[1] = (unsigned long )16;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sql_id_periodo;
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



        if (sqlca.sqlcode == -1031)
                return EXIT__509;       
        else if (sqlca.sqlcode == -915)
                return EXIT__506;
        else if (sqlca.sqlcode)
                return EXIT__500;
        else if (sql_veces && reproceso != 'R') 
                return EXIT_506;

        /* obtencion del primer bloque de ejecucion */
        sql_ord_primer_bloque = 0;
        /* EXEC SQL select min(ord_bloque)
                         into   :sql_ord_primer_bloque
                         from   cmd_bloques
                         where  cod_bloque > '0' 
                           and  cod_linea_proc = :sql_cod_linea_proc; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select min(ord_bloque) into :b0  from cmd_bloques whe\
re (cod_bloque>'0' and cod_linea_proc=:b1)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )78;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sql_ord_primer_bloque;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sql_cod_linea_proc;
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



        if (sqlca.sqlcode == -915)
                return EXIT__506;
        else if (sqlca.sqlcode)
                return EXIT__500;

        if (sql_ord_primer_bloque != sql_ord_bloque)
        {
                /* ahora se debe revisar al bloque anterior */
                /* EXEC SQL select cod_bloque
                                 into   :sql_cod_bloque_ant
                                 from   cmd_bloques
                                 where  cod_bloque > '0'
                                   and  ord_bloque + 1 = :sql_ord_bloque
                                   and  cod_linea_proc = :sql_cod_linea_proc; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 3;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select cod_bloque into :b0  from cmd_bloques \
where ((cod_bloque>'0' and (ord_bloque+1)=:b1) and cod_linea_proc=:b2)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )101;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)sql_cod_bloque_ant;
                sqlstm.sqhstl[0] = (unsigned long )16;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&sql_ord_bloque;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)sql_cod_linea_proc;
                sqlstm.sqhstl[2] = (unsigned long )3;
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



                if (sqlca.sqlcode == -915)
                        return EXIT__506;
                else if (sqlca.sqlcode)
                        return EXIT__500;

                /* para bloque anterior se revisa su estado */
        sql_veces = 0;
        /* EXEC SQL select count(*)
                 into   :sql_veces
                 from   cmt_trazas_bloques
                 where  sec_bloque > 0
                                   and  id_periodo = :sql_id_periodo
                   and  cod_bloque = :sql_cod_bloque_ant; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(*)  into :b0  from cmt_trazas_bloques wh\
ere ((sec_bloque>0 and id_periodo=:b1) and cod_bloque=:b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )128;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sql_veces;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sql_id_periodo;
        sqlstm.sqhstl[1] = (unsigned long )11;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sql_cod_bloque_ant;
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



        if (sqlca.sqlcode == -1031)
            return EXIT__509;
                else if (sqlca.sqlcode == -915)
                        return EXIT__506;
        else if (sqlca.sqlcode)
            return EXIT__500;
        else if (!sql_veces)
            return EXIT_507; /* bloque anterior no ejecutado */

                sql_veces = 0;
                /* EXEC SQL select count(*)
                                 into   :sql_veces
                                 from   cmt_trazas_bloques
                                 where  sec_bloque > 0
                                   and  id_periodo  = :sql_id_periodo
                                   and  cod_bloque  = :sql_cod_bloque_ant
                                   and  sec_bloque  = (select max(sec_bloque)
                                                                           from   cmt_trazas_bloques
                                                                           where  id_periodo  = :sql_id_periodo
                                                                                 and  cod_bloque  = :sql_cod_bloque_ant)
                                   and  ind_estado  = 'I'; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 5;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select count(*)  into :b0  from cmt_trazas_bl\
oques where ((((sec_bloque>0 and id_periodo=:b1) and cod_bloque=:b2) and sec_b\
loque=(select max(sec_bloque)  from cmt_trazas_bloques where (id_periodo=:b1 a\
nd cod_bloque=:b2))) and ind_estado='I')";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )155;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&sql_veces;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)sql_id_periodo;
                sqlstm.sqhstl[1] = (unsigned long )11;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)sql_cod_bloque_ant;
                sqlstm.sqhstl[2] = (unsigned long )16;
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)sql_id_periodo;
                sqlstm.sqhstl[3] = (unsigned long )11;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)sql_cod_bloque_ant;
                sqlstm.sqhstl[4] = (unsigned long )16;
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



                if (sqlca.sqlcode == -1031)
                        return EXIT__509;
                else if (sqlca.sqlcode == -915)
                        return EXIT__506;
                else if (sqlca.sqlcode)
                        return EXIT__500;
                else if (sql_veces)
                        return EXIT_508; /* bloque anterior en ejecucion */

        sql_veces = 0;
        /* EXEC SQL select count(*)
                 into   :sql_veces
                 from   cmt_trazas_bloques
                 where  sec_bloque > 0
                                   and  id_periodo = :sql_id_periodo
                   and  cod_bloque = :sql_cod_bloque_ant
                                   and  sec_bloque  = (select max(sec_bloque)
                                                                           from   cmt_trazas_bloques
                                                                           where  id_periodo  = :sql_id_periodo
                                                                                 and  cod_bloque  = :sql_cod_bloque_ant)
                   and  ind_estado = 'F'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(*)  into :b0  from cmt_trazas_bloques wh\
ere ((((sec_bloque>0 and id_periodo=:b1) and cod_bloque=:b2) and sec_bloque=(s\
elect max(sec_bloque)  from cmt_trazas_bloques where (id_periodo=:b1 and cod_b\
loque=:b2))) and ind_estado='F')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )190;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sql_veces;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sql_id_periodo;
        sqlstm.sqhstl[1] = (unsigned long )11;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sql_cod_bloque_ant;
        sqlstm.sqhstl[2] = (unsigned long )16;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)sql_id_periodo;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)sql_cod_bloque_ant;
        sqlstm.sqhstl[4] = (unsigned long )16;
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



        if (sqlca.sqlcode == -1031)
            return EXIT__509;
                else if (sqlca.sqlcode == -915)
                        return EXIT__506;
        else if (sqlca.sqlcode)
            return EXIT__500;
        else if (sql_veces)
            return EXIT_509; /* bloque anterior termino con error */
        }

        if (sql_ind_estado == 'I')
        {
                /*EXEC SQL select cod_periodo                        */
                /*               into   :sql_cod_periodo             */
                /*               from   cmd_periodos                 */
                /*               where  id_periodo = :sql_id_periodo;*/
                                 
                /* EXEC SQL SELECT COD_CICLCOMIS                                   /o Incorporado Por PGonzaleg 3-01-2003. Modificacion de Periodos. o/ 
                                INTO    :sql_cod_periodo                        /o Incorporado Por PGonzaleg 3-01-2003. Modificacion de Periodos. o/ 
                                FROM    CM_CICLCOMIS_TD                         /o Incorporado Por PGonzaleg 3-01-2003. Modificacion de Periodos. o/ 
                                WHERE   ID_CICLCOMIS = :sql_id_periodo; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 5;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select COD_CICLCOMIS into :b0  from CM_CICLCO\
MIS_TD where ID_CICLCOMIS=:b1";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )225;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&sql_cod_periodo;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)sql_id_periodo;
                sqlstm.sqhstl[1] = (unsigned long )11;
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

         /* Incorporado Por PGonzaleg 3-01-2003. Modificacion de Periodos. */ 

                if (sqlca.sqlcode == -915)
                        return EXIT__506;
                else if (sqlca.sqlcode > 0)
                        return EXIT_514;
                else if (sqlca.sqlcode)
                        return EXIT__500;

                /* EXEC SQL select user
                                        into     :sql_nom_usuario
                                        from     dual; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 5;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select user into :b0  from dual ";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )248;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)sql_nom_usuario;
                sqlstm.sqhstl[0] = (unsigned long )31;
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



                if (sqlca.sqlcode)
                        return EXIT__500;
/*
fprintf(stderr,"[%d] [%s] [%s]\n", sql_sec_bloque, sql_cod_bloque, sql_id_periodo);
fprintf(stderr,"[%c] [%s] \n", sql_ind_estado, sql_nom_usuario);
*/

                /* EXEC SQL insert into cmt_trazas_bloques (
                                                SEC_BLOQUE, COD_BLOQUE, ID_PERIODO,
                                                COD_PERIODO, IND_ESTADO, FEC_INICIO,
                                                NOM_USUARIO)
                                 values (
                                                :sql_sec_bloque,  :sql_cod_bloque, :sql_id_periodo,
                                                :sql_cod_periodo, :sql_ind_estado, sysdate,
                                                :sql_nom_usuario); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 6;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into cmt_trazas_bloques (SEC_BLOQUE,CO\
D_BLOQUE,ID_PERIODO,COD_PERIODO,IND_ESTADO,FEC_INICIO,NOM_USUARIO) values (:b0\
,:b1,:b2,:b3,:b4,sysdate,:b5)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )267;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&sql_sec_bloque;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)sql_cod_bloque;
                sqlstm.sqhstl[1] = (unsigned long )16;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)sql_id_periodo;
                sqlstm.sqhstl[2] = (unsigned long )11;
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&sql_cod_periodo;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)&sql_ind_estado;
                sqlstm.sqhstl[4] = (unsigned long )1;
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)sql_nom_usuario;
                sqlstm.sqhstl[5] = (unsigned long )31;
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



                if ( sqlca.sqlcode == -1) {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )306;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__515;
                }
                else if (sqlca.sqlcode == -1031) {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )321;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__507;
                }
                else if (sqlca.sqlcode == -915) {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )336;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__506;
                }
                else if (sqlca.sqlcode) {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )351;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__504; 
                }

                /* EXEC SQL commit; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 6;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )366;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        }
        else if (sql_ind_estado == 'F' || sql_ind_estado == 'T')
        {

                /* EXEC SQL update cmt_trazas_bloques 
                                 set    ind_estado = :sql_ind_estado,
                                                fec_termino= sysdate
                                 where  sec_bloque > 0
                                   and  cod_bloque = :sql_cod_bloque
                                   and  ind_estado = 'I'
                                   and  fec_termino is null; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 6;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update cmt_trazas_bloques  set ind_estado=:b0\
,fec_termino=sysdate where (((sec_bloque>0 and cod_bloque=:b1) and ind_estado=\
'I') and fec_termino is null )";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )381;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&sql_ind_estado;
                sqlstm.sqhstl[0] = (unsigned long )1;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)sql_cod_bloque;
                sqlstm.sqhstl[1] = (unsigned long )16;
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



                if (sqlca.sqlcode == -1031)
                {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )404;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__508;
                }
                else if (sqlca.sqlcode == -915)
                {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )419;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__506;
                }
                else if (sqlca.sqlcode)
                {
                        /* EXEC SQL rollback; */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 6;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )434;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                        return EXIT__505;
                }

                /* EXEC SQL commit; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 6;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )449;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        }
        else
                return EXIT_517; /* indicador de estado no valido para procesar */
        return 0; /* proceso termino OK */
}

/******************************************************************************
 * Valida que agrega-modifica-cierra traza de proceso.
 * Retorno:
 *              < 0 -> Error Oracle.
 *              = 0 -> Exito.
 *              > 0 -> Error no grave.
 ******************************************************************************/

/*******************************************************************************/
/* Valida que agrega-modifica-cierra traza de proceso.                         */
/* Retorno:                                                                    */
/*              < 0 -> Error Oracle.                                           */
/*              = 0 -> Exito.                                                  */
/*              > 0 -> Error no grave.                                         */
/*******************************************************************************/
int iModifica_Traza_Proceso()
{
	/* EXEC SQL begin declare section; */ 

		int 	sql_veces;
		long	sql_cod_periodo;
		long	sql_ord_proceso;
		long	sql_ord_primer_proceso;
		long	sql_sec_bloque;
		long	sql_num_segundos;
		long	sql_num_registros;
		long	sql_sec_proceso;
		short	sql_cod_error;
		    	
		char	sql_cod_bloque[16];
		char	sql_cod_proceso[16];
		    	
		char	sql_ind_estado;
		char	sql_des_error[101]; 
		char	sql_cod_proceso_ant[16]; /* EXEC SQL var sql_cod_proceso_ant is string(16); */ 

		char	sql_cod_bloque_ant[16]; /* EXEC SQL var sql_cod_bloque_ant is string(16); */ 

		char	sql_cod_linea_proc[3]; /* EXEC SQL var sql_cod_linea_proc is string(3); */ 

		char	sql_id_periodo[11]; 
		char	sql_nom_usuario[31]; /* EXEC SQL var sql_nom_usuario is string(31); */ 

		char	sql_fec_inicio[20];
		char	sql_fec_termino[20];
	/* EXEC SQL end declare section; */ 


    strcpy(sql_cod_bloque   , proceso.cod_bloque);
    strcpy(sql_des_error    , proceso.des_error);
    strcpy(sql_cod_proceso  , proceso.cod_proceso);
    sql_sec_bloque          = proceso.sec_bloque;
    sql_sec_proceso         = proceso.sec_proceso;
    sql_num_segundos        = proceso.num_segundos;
    sql_cod_error           = proceso.cod_error;
    sql_num_registros       = proceso.num_registros;
    sql_ind_estado          = proceso.ind_estado;

    fprintf(stderr,"\n\n >>>>>>>>>>>> BIBLIOTECA PROCESOS <<<<<<<<<<<<<<<<\n\n");
    fprintf(stderr, "BLOQUE:[%s] SEC_BLOQUE:[%d] PROCESO:[%s] SEC_PROCESO:[%d] SEGUNDOS:[%d]\n", 
                    sql_cod_bloque, sql_sec_bloque, sql_cod_proceso, 
                    sql_sec_proceso, sql_num_segundos);
    fprintf(stderr,"ERROR:[%d] REGISTROS:[%d] DES_ERROR:[%s] ESTADO:[%c]\n", 
                    sql_cod_error, sql_num_registros, sql_des_error, sql_ind_estado);
    fprintf(stderr,"\n\n");

    /* EXEC SQL SELECT COD_PERIODO,ID_PERIODO
            INTO :sql_cod_periodo,:sql_id_periodo
            FROM CMT_TRAZAS_BLOQUES
            WHERE SEC_BLOQUE = :sql_sec_bloque; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PERIODO ,ID_PERIODO into :b0,:b1  from CMT_TRA\
ZAS_BLOQUES where SEC_BLOQUE=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )464;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&sql_cod_periodo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)sql_id_periodo;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&sql_sec_bloque;
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



    if (sqlca.sqlcode != 0) 
    {
		fprintf(stderr, "\n[BIBLIOTECA] Error recuperando Ciclo de Comisiones.   [%d][%s]\n",sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc); 
		return EXIT__500;
	}
	switch(sql_ind_estado)
    {
		case 'I':
            /* EXEC SQL insert into cmt_trazas_procesos(
            	SEC_PROCESO, SEC_BLOQUE, COD_BLOQUE, 
                COD_PROCESO, ID_PERIODO, COD_PERIODO, 
                IND_ESTADO, FEC_INICIO, NOM_USUARIO)
                VALUES (
                :sql_sec_proceso, :sql_sec_bloque, :sql_cod_bloque,
                :sql_cod_proceso, :sql_id_periodo, :sql_cod_periodo,
                :sql_ind_estado , SYSDATE,USER); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into cmt_trazas_procesos (SEC_PROCESO,SEC_\
BLOQUE,COD_BLOQUE,COD_PROCESO,ID_PERIODO,COD_PERIODO,IND_ESTADO,FEC_INICIO,NOM\
_USUARIO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,SYSDATE,USER)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )491;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&sql_sec_proceso;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&sql_sec_bloque;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)sql_cod_bloque;
            sqlstm.sqhstl[2] = (unsigned long )16;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)sql_cod_proceso;
            sqlstm.sqhstl[3] = (unsigned long )16;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)sql_id_periodo;
            sqlstm.sqhstl[4] = (unsigned long )11;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&sql_cod_periodo;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&sql_ind_estado;
            sqlstm.sqhstl[6] = (unsigned long )1;
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


        	break; 
        case 'T':
			/* EXEC SQL update cmt_trazas_procesos
				SET    ind_estado = :sql_ind_estado,
                fec_termino= sysdate, 
                num_segundos = :sql_num_segundos,
                num_registros= :sql_num_registros
                WHERE  sec_proceso= :sql_sec_proceso
                AND  sec_bloque = :sql_sec_bloque
                AND  cod_proceso= :sql_cod_proceso
                AND  cod_bloque = :sql_cod_bloque
                AND  id_periodo = :sql_id_periodo
                AND  ind_estado = 'I'; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update cmt_trazas_procesos  set ind_estado=:b0,fec_termino\
=sysdate,num_segundos=:b1,num_registros=:b2 where (((((sec_proceso=:b3 and sec\
_bloque=:b4) and cod_proceso=:b5) and cod_bloque=:b6) and id_periodo=:b7) and \
ind_estado='I')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )534;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&sql_ind_estado;
   sqlstm.sqhstl[0] = (unsigned long )1;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&sql_num_segundos;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&sql_num_registros;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&sql_sec_proceso;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&sql_sec_bloque;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)sql_cod_proceso;
   sqlstm.sqhstl[5] = (unsigned long )16;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)sql_cod_bloque;
   sqlstm.sqhstl[6] = (unsigned long )16;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)sql_id_periodo;
   sqlstm.sqhstl[7] = (unsigned long )11;
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


			break;
		case 'F':
        	/* EXEC SQL UPDATE CMT_TRAZAS_PROCESOS
            	SET IND_ESTADO 		= :sql_ind_estado,
                	FEC_TERMINO		= sysdate, 
                	NUM_SEGUNDOS 	= :sql_num_segundos,
                	NUM_REGISTROS	= 0,
                	COD_ERROR  		= :sql_cod_error,
                	DES_ERROR  		= :sql_des_error
                WHERE  SEC_PROCESO	= :sql_sec_proceso
                AND  SEC_BLOQUE 	= :sql_sec_bloque
                AND  COD_PROCESO	= :sql_cod_proceso
                AND  COD_BLOQUE 	= :sql_cod_bloque
                AND  ID_PERIODO 	= :sql_id_periodo
                AND  IND_ESTADO 	= 'I'; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 9;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "update CMT_TRAZAS_PROCESOS  set IND_ESTADO=:b0,FEC_T\
ERMINO=sysdate,NUM_SEGUNDOS=:b1,NUM_REGISTROS=0,COD_ERROR=:b2,DES_ERROR=:b3 wh\
ere (((((SEC_PROCESO=:b4 and SEC_BLOQUE=:b5) and COD_PROCESO=:b6) and COD_BLOQ\
UE=:b7) and ID_PERIODO=:b8) and IND_ESTADO='I')";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )581;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&sql_ind_estado;
         sqlstm.sqhstl[0] = (unsigned long )1;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&sql_num_segundos;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&sql_cod_error;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)sql_des_error;
         sqlstm.sqhstl[3] = (unsigned long )101;
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&sql_sec_proceso;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)&sql_sec_bloque;
         sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)sql_cod_proceso;
         sqlstm.sqhstl[6] = (unsigned long )16;
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)sql_cod_bloque;
         sqlstm.sqhstl[7] = (unsigned long )16;
         sqlstm.sqhsts[7] = (         int  )0;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)sql_id_periodo;
         sqlstm.sqhstl[8] = (unsigned long )11;
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
    if (sqlca.sqlcode != 0) 
    {
		fprintf(stderr, "\n[BIBLIOTECA] Error Actualizando Trazas de Procesos.   [%d][%s]\n",sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc); 
    	/* EXEC SQL rollback; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )632;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        return EXIT__500;
    }
    /* EXEC SQL commit; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )647;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 
    return 0;
}

/*****************************************************************/
/* Funcion encargada de buscar un secuencial de bloque-proceso   */
/*****************************************************************/
long   lDBGetSequenceNextVal ()
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long sqlSEQ_BLOQUE;
   /* EXEC SQL END DECLARE SECTION; */ 


   /* EXEC SQL
        SELECT CMS_IND_TRAZAS.NEXTVAL
      INTO   :sqlSEQ_BLOQUE
      FROM   DUAL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select CMS_IND_TRAZAS.nextval  into :b0  from DUAL ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )662;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&sqlSEQ_BLOQUE;
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


   return(sqlSEQ_BLOQUE);
}

/********************************************************************************/
/* Se inicia estructura "proceso" que se maneja en los programas.               */
/* ******************************************************************************/
int iAccesa_Traza_Procesos(char estado, short cod_error, char * des_error,long num_segundos, long num_registros)
{
    proceso.ind_estado = estado;

    /* se obtiene secuencia de proceso */
    if (estado == ABRIR_TRAZA)
        proceso.sec_proceso = lDBGetSequenceNextVal();
    else if (estado == CERRAR_TRAZA_NOK)
    {
        /* EXEC SQL rollback work; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )681;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        proceso.cod_error = cod_error;
        strcpy(proceso.des_error, des_error);
    }
    else if (estado == CERRAR_TRAZA_OK)
    {
        proceso.num_segundos = num_segundos;
        proceso.num_registros= num_registros;
    }
    return iModifica_Traza_Proceso();
}

/******************************************************************************
 * Se inicia estructura "proceso" que se maneja en los programas.
 ******************************************************************************/

void vInicia_Estructura_Procesos(char * bloque, char * proces,char * usuario  , int sec_bloque)
{
   strcpy(proceso.cod_bloque, bloque);
   proceso.sec_bloque = sec_bloque;
   strcpy(proceso.cod_proceso, proces);
   strcpy(proceso.nom_usuario, usuario);
}

/*---------------------------------------------------------------------------*/
/* Rutina para manejo de mensajes de errores Oracle.                         */
/*---------------------------------------------------------------------------*/

void vSqlError()
{
	/* EXEC SQL ROLLBACK WORK; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )696;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    fprintf(stderr,"\n\nERROR. Se Cierra Traza de Procesos.");
    fprintf(stderr,"[%d] [%s]\n\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
   	exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,0,sqlca.sqlerrm.sqlerrmc,0,0));
}
void vSqlError_EXT()
{
	/* EXEC SQL ROLLBACK WORK; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )711;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    fprintf(stderr,"\n\nError. Proceso se Cancela.");
    fprintf(stderr,"[%d] [%s]\n\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
	ifnActualizaTrazasExtractores(0, "", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc, iCIERRATRAZAERROR);
   	exit(EXIT_111);
}

/*---------------------------------------------------------------------------*/
/* Rutina para manejo y validacion de argumentos ingresados como parametros  */
/* externos.                                                                 */
/*---------------------------------------------------------------------------*/
void  vManejaArgs (int argc, char * const argv[])
{
   int         iOpt = 0;
   extern char *optarg;
   char        opstring[] = ":u:p:c:b:s:a:t:";
   char        *szUserid_Aux;
   char        userid[70];

   while((iOpt=getopt(argc, argv, opstring)) != EOF)
   {
      switch(iOpt)
      {
      case 'u':
         if(stArgs.bFlagUser == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUso);
               exit(EXIT_104);
            }
            strcpy(userid, optarg);
            if((szUserid_Aux=(char *)strstr(userid,"/")) == (char *)NULL)
            {
               fprintf(stderr, "\nUsuario Oracle no es valido\n");
               fprintf(stderr, "%s\n\n", szUso);
               exit(EXIT_104);
            }
            else
            {
               strncpy(stArgs.szUser, userid, szUserid_Aux-userid);
               strcpy(stArgs.szPass, szUserid_Aux+1);
            }
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUso);
            exit(EXIT_104);
         }
         stArgs.bFlagUser=TRUE;
         break;

      case 'p':
         if(stArgs.bFlagPeriodo == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUso);
               exit(EXIT_101);
            }
            strcpy(stArgs.szIdPeriodo, optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUso);
            exit(EXIT_101);
         }
         stArgs.bFlagPeriodo = TRUE;
         break;
      case 'c':
         if(stArgs.bFlagProceso == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUso);
               exit(EXIT_105);
            }
            strcpy(stArgs.szProceso,optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUso);
            exit(EXIT_105);
         }
         stArgs.bFlagProceso = TRUE;
         break;

      case 'b':
         if(stArgs.bFlagBloque == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUso);
               exit(EXIT_106);
            }
            strcpy(stArgs.szBloque,optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUso);
            exit(EXIT_106);
         }
         stArgs.bFlagBloque = TRUE;
         break;

      case 's':
         if(stArgs.bFlagSecuencia == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUso);
               exit(EXIT_107);
            }
            stArgs.izSecuencia = atoi(optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUso);
            exit(EXIT_107);
         }
         stArgs.bFlagSecuencia = TRUE;
         break;
               
      case '?':
         fprintf(stderr, "Opcion -%c no reconocida. Se cancela.\n", optopt);
         fprintf(stderr, "%s\n\n", szUso);
         exit(EXIT_100);
      }  /* Fin switch */
   }     /* Fin while  */
   /* *********************************************************************** */
   /* ****************************** VALIDACIONES *************************** */
   /* *********************************************************************** */
   if(stArgs.bFlagPeriodo == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -p[Periodo(<YYYYMM><A><M><1>)]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUso);
      exit(EXIT_104);
   }
   if(stArgs.bFlagProceso == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -c[Proceso]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUso);
      exit(EXIT_105);
   }
   if(stArgs.bFlagBloque == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -b[Bloque]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUso);
      exit(EXIT_106);
   }
   if(stArgs.bFlagSecuencia == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -s[Secuencia Bloque]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUso);
      exit(EXIT_107);
   }
}
/*---------------------------------------------------------------------------*/
/* Rutina para manejo y validacion de argumentos ingresados como parametros  */
/* externos.   SOLO PARA EXTRACTORES                                         */
/*---------------------------------------------------------------------------*/
void  vManejaArgsExt (int argc, char * const argv[])
{
   int         iOpt = 0;
   extern char *optarg;
   char        opstring[] = ":u:d:h:s:";
   char        *szUserid_Aux;
   char        userid[70];

   while((iOpt=getopt(argc, argv, opstring)) != EOF)
   {
       
      switch(iOpt)
      {
      case 'u':
         if(stArgsExt.bFlagUser == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUsoExt);
               exit(EXIT_104);
            }
            strcpy(userid, optarg);
            if((szUserid_Aux=(char *)strstr(userid,"/")) == (char *)NULL)
            {
               fprintf(stderr, "\nUsuario Oracle no es valido\n");
               fprintf(stderr, "%s\n\n", szUsoExt);
               exit(EXIT_104);
            }
            else
            {
               strncpy(stArgsExt.szUser, userid, szUserid_Aux-userid);
               strcpy(stArgsExt.szPass, szUserid_Aux+1);
            }
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUsoExt);
            exit(EXIT_104);
         }
         stArgsExt.bFlagUser=TRUE;
         break;

     case 's':
         if(stArgsExt.bFlagSecuencia == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUsoExt);
               exit(EXIT_104);
            }
            stArgsExt.lNumSecuencia = atol(optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUsoExt);
            exit(EXIT_104);
         }
         stArgsExt.bFlagSecuencia=TRUE;
         break;

      case 'd':
         if(stArgsExt.bFlagFecDesde == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUsoExt);
               exit(EXIT_105);
            }
            strcpy(stArgsExt.szFecDesde,optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUsoExt);
            exit(EXIT_105);
         }
         stArgsExt.bFlagFecDesde = TRUE;
         break;

      case 'h':
         if(stArgsExt.bFlagFecHasta == FALSE)
         {
            if(optarg[0]=='-')
            {
               fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
               fprintf(stderr, "%s\n\n", szUsoExt);
               exit(EXIT_105);
            }
            strcpy(stArgsExt.szFecHasta,optarg);
         }
         else
         {
            fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
            fprintf(stderr, "%s\n\n", szUsoExt);
            exit(EXIT_105);
         }
         stArgsExt.bFlagFecHasta = TRUE;
         break;


               
      case '?':
         fprintf(stderr, "Opcion -%c no reconocida. Se cancela.\n", optopt);
         fprintf(stderr, "%s\n\n", szUsoExt);
         exit(EXIT_100);
      }  /* Fin switch */
   }     /* Fin while  */
   /* *********************************************************************** */
   /* ****************************** VALIDACIONES *************************** */
   /* *********************************************************************** */
   if(stArgsExt.bFlagUser == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -u[User/Pass]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUsoExt);
      exit(EXIT_104);
   }
   if(stArgsExt.bFlagSecuencia == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -s[Secuencia Ejecucion]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUsoExt);
      exit(EXIT_104);
   }   
   if(stArgsExt.bFlagFecDesde == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -c[Fecha Desde <YYYYMMDD>]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUsoExt);
      exit(EXIT_105);
   }
   if(stArgsExt.bFlagFecHasta == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -c[Fecha Hasta <YYYYMMDD>]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUsoExt);
      exit(EXIT_105);
   }
}
/******************************************************************************
 * Abre archivo de log standar.
 ******************************************************************************/

FILE *fAbreArchivoLog()
{
	char szNomFile[300];
	char szComando[100];

	sprintf(szComando,"mkdir -p %s",stArgsLog.szPath);
	system (szComando);
	if (stArgsLog.szExtension[0] = 0)
		strcpy(stArgsLog.szExtension, LOG);
		
    sprintf(szNomFile,"%s/%s_%s.%s" ,stArgsLog.szPath
                                     ,stArgsLog.szProceso
                                     ,stArgsLog.szSysDate
                                     ,stArgsLog.szExtension);    
        
	fprintf(stderr,"Path    de log : [%s]\n",stArgsLog.szPath);  
    fprintf(stderr,"Archivo de log : [%s]\n",szNomFile);   
                                               
    return(fopen(szNomFile,"w"));
}

/******************************************************************************
 * Funcion que busca el nombre de tabla fisica asociada a tabla logica 
   (Gestion de Enlace ).
   Retorno TRUE->EXITO FALSE->ERROR
 ******************************************************************************/

int iBuscaTablaFisica(char *szTablaLogica, char * szIdPeriodo,char *szTablaFisica)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
    
        char szhTablaLogica[31];
        char szhTablaFisica[31];
        char szhIdCiclComis[11];
	/* EXEC SQL END DECLARE SECTION; */ 
    
    
    strcpy(szhIdCiclComis	, szIdPeriodo);
    strcpy(szhTablaLogica	, szTablaLogica);
        
    /* EXEC SQL SELECT NVL(NOM_FISICO, '0')                              
                INTO :szhTablaFisica                                  
                FROM CM_ENLACEHIST_TO                                 
                WHERE ID_PERIODO = :szhIdCiclComis
                AND NOM_LOGICO = :szhTablaLogica; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(NOM_FISICO,'0') into :b0  from CM_ENLACEHIST_T\
O where (ID_PERIODO=:b1 and NOM_LOGICO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )726;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhTablaFisica;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhIdCiclComis;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhTablaLogica;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if (sqlca.sqlcode != SQLOK)
        {
            strcpy(szTablaFisica,"0");
            return FALSE;
        }
        else
        {
        	strcpy(szTablaFisica,szhTablaFisica);
        }
        return TRUE;
}

/*---------------------------------------------------------------------------*/
/* QUITA LOS ESPACIOS EN BLANCO AL INICIO Y AL FINAL DE UNA CADENA DE        */
/* CARACTERES                                                                */
/*---------------------------------------------------------------------------*/
char * szfnTrim(char * strin)
{
        int  i= 0,l=0;
        char strtmps[STR_HUGE];
  
        memset(strtmps, 0, STR_LONG);
        
        while (*(strin + i) == ' ') 
                i++;
         
        strcpy(strtmps,(strin + i));    
         
        
        l = strlen(strtmps) - 1;
        while ((l >= 0) && ((*(strtmps + l ) == ' ')||(*(strtmps + l ) == '\n')))
        {        
                *(strtmps + l ) = '\0';l--;
        }
        
        strcpy(strin,strtmps);
        return(strin);
}
/*---------------------------------------------------------------------------*/
/* Función que retorna fecha en formato para creación de logs.               */
/*---------------------------------------------------------------------------*/
char * szfnObtieneFecYYYYMMDD()
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                char    szhFecLog[9];   
        /* EXEC SQL END DECLARE SECTION; */ 

        
    /* EXEC SQL
            SELECT  TO_CHAR(SYSDATE,'YYYYMMDD') INTO
                :szhFecLog 
            FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(SYSDATE,'YYYYMMDD') into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )753;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecLog;
    sqlstm.sqhstl[0] = (unsigned long )9;
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



        return (szhFecLog);
}
/*---------------------------------------------------------------------------*/
/* Rutina para recuperar fechas que definen Ciclo a procesar.                */
/*---------------------------------------------------------------------------*/
int vCargaCiclo(char * pszIdCiclComis,reg_ciclo * stMiCiclo)
{
    int		bRet = FALSE; 
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    char    szhIdCiclComisAnt[11];
	    long    lhCodCiclComis;
	    long    lhCiclo;
	    char    szhIdCiclComis[11];             
	    char	szhTipCiclComis;
	    char	szhDesCiclcomis[61];                
	    char    szhFecDesdeNormal[11];
	    char    szhFecHastaNormal[11];
	    char    szhFecDesdePrepago[11];
	    char    szhFecHastaPrepago[11];
	    char    szhFecDesdeAceptacion[11];
	    char    szhFecHastaAceptacion[11];
	    char    szhFecDesdeRecepcion[11];
	    char    szhFecHastaRecepcion[11];
	    char    szhCodEstado[4];
	    char    szhFecHastaAceptacionAnt[11];
	    char    szhFecHastaRecepcionAnt[11];      
	    char	szhTipPeriodo[2];      
    /* EXEC SQL END DECLARE SECTION; */ 

                
	strcpy(szhIdCiclComis, pszIdCiclComis);
        
        
	/* EXEC SQL SELECT  	TO_CHAR(FEC_DESDE_NORMAL        ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_HASTA_NORMAL        ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_DESDE_PREPAGO       ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_HASTA_PREPAGO       ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_DESDE_ACEPTACION    ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_HASTA_ACEPTACION    ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_DESDE_RECEPCION     ,'DD-MM-YYYY'),
                        TO_CHAR(FEC_HASTA_RECEPCION     ,'DD-MM-YYYY'),
                        COD_CICLCOMIS,
                        COD_CICLO,
                        COD_ESTADO,
                        TIP_CICLCOMIS,
                        NVL(DES_CICLCOMIS,'CICLO PERIODICO'),
                        TIP_PERIODO
                INTO    :szhFecDesdeNormal  ,
                        :szhFecHastaNormal  ,
                        :szhFecDesdePrepago ,
                        :szhFecHastaPrepago ,
                        :szhFecDesdeAceptacion,
                        :szhFecHastaAceptacion,
                        :szhFecDesdeRecepcion,
                        :szhFecHastaRecepcion,
                        :lhCodCiclComis,
                        :lhCiclo,
                        :szhCodEstado,
                        :szhTipCiclComis,
                        :szhDesCiclcomis,
                        :szhTipPeriodo
                FROM    CM_CICLCOMIS_TD
                WHERE   ID_CICLCOMIS = :szhIdCiclComis; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(FEC_DESDE_NORMAL,'DD-MM-YYYY') ,TO_CHAR(FEC_H\
ASTA_NORMAL,'DD-MM-YYYY') ,TO_CHAR(FEC_DESDE_PREPAGO,'DD-MM-YYYY') ,TO_CHAR(FE\
C_HASTA_PREPAGO,'DD-MM-YYYY') ,TO_CHAR(FEC_DESDE_ACEPTACION,'DD-MM-YYYY') ,TO_\
CHAR(FEC_HASTA_ACEPTACION,'DD-MM-YYYY') ,TO_CHAR(FEC_DESDE_RECEPCION,'DD-MM-YY\
YY') ,TO_CHAR(FEC_HASTA_RECEPCION,'DD-MM-YYYY') ,COD_CICLCOMIS ,COD_CICLO ,COD\
_ESTADO ,TIP_CICLCOMIS ,NVL(DES_CICLCOMIS,'CICLO PERIODICO') ,TIP_PERIODO into\
 :b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13  from CM_CICLCOMI\
S_TD where ID_CICLCOMIS=:b14";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )772;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecDesdeNormal;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecHastaNormal;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesdePrepago;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHastaPrepago;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesdeAceptacion;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecHastaAceptacion;
 sqlstm.sqhstl[5] = (unsigned long )11;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhFecDesdeRecepcion;
 sqlstm.sqhstl[6] = (unsigned long )11;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhFecHastaRecepcion;
 sqlstm.sqhstl[7] = (unsigned long )11;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCiclComis;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&lhCiclo;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhCodEstado;
 sqlstm.sqhstl[10] = (unsigned long )4;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&szhTipCiclComis;
 sqlstm.sqhstl[11] = (unsigned long )1;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhDesCiclcomis;
 sqlstm.sqhstl[12] = (unsigned long )61;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[13] = (unsigned long )2;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhIdCiclComis;
 sqlstm.sqhstl[14] = (unsigned long )11;
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



    if (sqlca.sqlcode==0)
    {
    	bRet = TRUE;
        stMiCiclo->lCodCiclComis           			= lhCodCiclComis;
        stMiCiclo->lCodCiclo               			= lhCiclo;
        stMiCiclo->cTipCiclComis           			=szhTipCiclComis;
        strcpy(stMiCiclo->szIdCiclComis            	,szfnTrim(szhIdCiclComis        ));
        strcpy(stMiCiclo->szFecDesdeNormal         	,szfnTrim(szhFecDesdeNormal     ));
        strcpy(stMiCiclo->szFecHastaNormal         	,szfnTrim(szhFecHastaNormal     ));
        strcpy(stMiCiclo->szFecDesdePrepago        	,szfnTrim(szhFecDesdePrepago    ));
        strcpy(stMiCiclo->szFecHastaPrepago        	,szfnTrim(szhFecHastaPrepago    ));
        strcpy(stMiCiclo->szFecDesdeAceptacion     	,szfnTrim(szhFecDesdeAceptacion ));
        strcpy(stMiCiclo->szFecHastaAceptacion     	,szfnTrim(szhFecHastaAceptacion ));
        strcpy(stMiCiclo->szFecDesdeRecepcion      	,szfnTrim(szhFecDesdeRecepcion  ));
        strcpy(stMiCiclo->szFecHastaRecepcion      	,szfnTrim(szhFecHastaRecepcion  ));      
        strcpy(stMiCiclo->szCodEstado              	,szfnTrim(szhCodEstado          ));
        strcpy(stMiCiclo->szDesCiclcomis           	,szfnTrim(szhDesCiclcomis       ));
        strcpy(stMiCiclo->szTipPeriodo             	,szfnTrim(szhTipPeriodo));

        fprintf (stderr, "--------------------Carga de Ciclos--------------------\n");
        fprintf (stderr, "[CargaCiclo]Ciclo                         [%ld]\n", stMiCiclo->lCodCiclo             );
        fprintf (stderr, "[CargaCiclo]Ciclo de Comision             [%ld]\n", stMiCiclo->lCodCiclComis         );
        fprintf (stderr, "[CargaCiclo]Id Ciclo de Comision          [%s]\n" , stMiCiclo->szIdCiclComis         );
        fprintf (stderr, "[CargaCiclo]Descripcion Ciclo             [%s]\n" , stMiCiclo->szDesCiclcomis        );
        fprintf (stderr, "[CargaCiclo]Tipo de Ciclo de Comisiones   [%c]\n" , stMiCiclo->cTipCiclComis         );
        fprintf (stderr, "[CargaCiclo]Fecha Inicio Normal           [%s]\n" , stMiCiclo->szFecDesdeNormal      );
        fprintf (stderr, "[CargaCiclo]Fecha Termino Mornal          [%s]\n" , stMiCiclo->szFecHastaNormal      );
        fprintf (stderr, "[CargaCiclo]Fecha Inicio Prepago          [%s]\n" , stMiCiclo->szFecDesdePrepago     );
        fprintf (stderr, "[CargaCiclo]Fecha Termino Prepago         [%s]\n" , stMiCiclo->szFecHastaPrepago     );
        fprintf (stderr, "[CargaCiclo]Fecha Inicio Aceptacion       [%s]\n" , stMiCiclo->szFecDesdeAceptacion  );
        fprintf (stderr, "[CargaCiclo]Fecha Termino Aceptacion      [%s]\n" , stMiCiclo->szFecHastaAceptacion  );
        fprintf (stderr, "[CargaCiclo]Fecha Inicio Recepcion        [%s]\n" , stMiCiclo->szFecDesdeRecepcion   );
        fprintf (stderr, "[CargaCiclo]Fecha Termino Recepcion       [%s]\n" , stMiCiclo->szFecHastaRecepcion   );
        fprintf (stderr, "[CargaCiclo]Estado del Ciclo              [%s]\n" , stMiCiclo->szCodEstado           );
        fprintf (stderr, "[CargaCiclo]Tipo de Periodo               [%s]\n" , stMiCiclo->szTipPeriodo         );
        fprintf (stderr, "-------------------------------------------------------\n");
    }
	return bRet;
}

/*---------------------------------------------------------------------------*/
/* RUT sin guion y digito verificador (como numero)                          */
/*---------------------------------------------------------------------------*/
long lfnGetIntRut(char * s)
{
        int i,indice=0;
        for (i=0; s[i]!='-' && s[i]!='\0';i++)
                        indice = i;
        s[indice+1] = '\0';
        return atol(s);
}
/*---------------------------------------------------------------------------*/
/* OBTENCION DE LA CATEGORIA ASOCIADA AL CLIENTE                             */
/*---------------------------------------------------------------------------*/

char * szfnGetCategCliente(char catribut, char * rut)
{
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            char    szhCodOperadora[6];
    /* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL SELECT COD_OPERADORA_SCL
        INTO :szhCodOperadora
        FROM GE_OPERADORA_SCL_LOCAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_OPERADORA_SCL into :b0  from GE_OPERADORA_SCL_LOC\
AL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )847;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodOperadora;
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


        
	if (catribut == 'B')
		return INDIVIDUAL;
	else
		return PYME;

}
/*---------------------------------------------------------------------------*/
/* OBTIENE LA LISTA DE TIPOS DE COMISIONISTAS / TIPOS DE RED CONFIGURADOS    */
/* PARA EL CONCEPTO ESPECIFICO, EN EL CICLO DE COMISIONES ESPECIFICO.        */
/* FUNCIONALIDAD UNICA DE CICLOS DE COMISIONES PERIODICOS.                   */
/*---------------------------------------------------------------------------*/
stTiposComis * stGetTipComisSelecPer(char *pszCodUniverso, reg_ciclo stCiclo)
{
	stTiposComis * paux;
	stTiposComis * qaux;
	
	int				i;                                                         
	short          	iLastRows    = 0;                                              
	int            	iFetchedRows = MAXFETCH;                                       
	int            	iRetrievRows = MAXFETCH;  
	int				iCuentaRegs  = 0; 	
		
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		char	szhTipPeriodo[2];
		char	szhTIPOPERIODO[2];
		char	szhCodUniverso[7];
		int		ihCodCiclo;
		char    szhFecHastaNormal[11];
		char    szhFecDesdeNormal[11];
		char	chTipCiclComis;
		long 	lMaxFetch;
		int		ihCodTipoRed[MAXFETCH];
		char	szhDesTipoRed[MAXFETCH][31];
		char	szhCodTipComisS[MAXFETCH][3];
		char	szhDesTipComisS[MAXFETCH][31];
		char	szhCodTipComisA[MAXFETCH][3];
		char	szhDesTipComisA[MAXFETCH][31];
		char	szhINDPARCIAL[2];
	/* EXEC SQL END DECLARE SECTION; */ 


	paux = NULL;
	qaux = NULL;
	ihCodCiclo    				= stCiclo.lCodCiclo;
	chTipCiclComis				= PERIODICO;
	strcpy(szhCodUniverso 		, pszCodUniverso);
	strcpy(szhFecHastaNormal 	, stCiclo.szFecHastaNormal);
	strcpy(szhFecDesdeNormal 	, stCiclo.szFecDesdeNormal);
	strcpy(szhTipPeriodo	 	, stCiclo.szTipPeriodo);
	strcpy(szhTIPOPERIODO	 	, TIPPERIODO_M);
	strcpy(szhINDPARCIAL	 	, INDPARCIAL_S);
	
	/* EXEC SQL DECLARE CUR_TiposComis 
		CURSOR FOR SELECT DISTINCT
				A.COD_TIPORED,
				C.DES_TIPORED,
				H.COD_TIPCOMIS,
				G.DES_TIPCOMIS,
				D.COD_TIPCOMIS,
				E.DES_TIPCOMIS
		FROM 	CMD_CONCEPTOS F,
			 	CM_CONCEPTOSTIPORED_TD A,
			 	CM_PLANESTIPORED_TD B,
			 	VE_TIPORED_TD C,
			 	VE_DETALLE_TIPORED_TD D,
			 	VE_DETALLE_TIPORED_TD H,
			 	VE_TIPCOMIS E,
			 	VE_TIPCOMIS G
		WHERE F.COD_UNIVERSO   	=  :szhCodUniverso
		AND F.TIP_CICLCOMIS     =  :chTipCiclComis
		AND F.COD_CONCEPTO		=  A.COD_CONCEPTO
		AND A.COD_PLANCOMIS		=  B.COD_PLANCOMIS
		AND A.COD_TIPORED 		=  B.COD_TIPORED
		AND B.FEC_DESDE 		<= TO_DATE(:szhFecHastaNormal, 'DD-MM-YYYY')
		AND B.FEC_HASTA 		>= TO_DATE(:szhFecDesdeNormal, 'DD-MM-YYYY')
		AND B.COD_TIPORED 		=  C.COD_TIPORED
		AND C.COD_CICLOCOMIS	=  :ihCodCiclo
		AND C.COD_TIPORED 		=  D.COD_TIPORED
		AND D.NUM_NIVEL 		=  A.NIV_SELECCION
		AND D.COD_TIPCOMIS 		=  E.COD_TIPCOMIS
		AND C.COD_TIPORED 		=  H.COD_TIPORED
		AND A.NIV_APLICACION	=  H.NUM_NIVEL
		AND H.COD_TIPCOMIS		=  G.COD_TIPCOMIS
		AND((:szhTipPeriodo		=  :szhTIPOPERIODO) OR
		    (:szhTipPeriodo		!= :szhTIPOPERIODO AND F.IND_PARCIAL = :szhINDPARCIAL)); */ 

		
	/* EXEC SQL OPEN CUR_TiposComis; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0036;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )866;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodUniverso;
 sqlstm.sqhstl[0] = (unsigned long )7;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&chTipCiclComis;
 sqlstm.sqhstl[1] = (unsigned long )1;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecHastaNormal;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesdeNormal;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCiclo;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[7] = (unsigned long )2;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[8] = (unsigned long )2;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhINDPARCIAL;
 sqlstm.sqhstl[9] = (unsigned long )2;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {
	    /* EXEC SQL for :lMaxFetch FETCH CUR_TiposComis INTO
	    	:ihCodTipoRed,
	    	:szhDesTipoRed,
	    	:szhCodTipComisA, 
	    	:szhDesTipComisA,
	    	:szhCodTipComisS, 
	    	:szhDesTipComisS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )921;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhDesTipoRed;
     sqlstm.sqhstl[1] = (unsigned long )31;
     sqlstm.sqhsts[1] = (         int  )31;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComisA;
     sqlstm.sqhstl[2] = (unsigned long )3;
     sqlstm.sqhsts[2] = (         int  )3;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhDesTipComisA;
     sqlstm.sqhstl[3] = (unsigned long )31;
     sqlstm.sqhsts[3] = (         int  )31;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComisS;
     sqlstm.sqhstl[4] = (unsigned long )3;
     sqlstm.sqhsts[4] = (         int  )3;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhDesTipComisS;
     sqlstm.sqhstl[5] = (unsigned long )31;
     sqlstm.sqhsts[5] = (         int  )31;
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
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stTiposComis *) malloc(sizeof(stTiposComis));
	        
	        paux->iCodTipoRed				= ihCodTipoRed[i];

	        strcpy(paux->szDesTipoRed		, szfnTrim(szhDesTipoRed[i]));
	        strcpy(paux->szCodTipVendedor	, szfnTrim(szhCodTipComisS[i]));
	        strcpy(paux->szDesTipVendedor	, szfnTrim(szhDesTipComisS[i]));
	        strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComisA[i]));
	        strcpy(paux->szDesTipComis		, szfnTrim(szhDesTipComisA[i]));

	        paux->sgte 						= qaux;
	        qaux 							= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_TiposComis; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )960;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Tipos de Comisionistas para Universo:[%s] Ciclo[%d] =>[%d]\n",szhCodUniverso, ihCodCiclo ,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
/* OBTIENE LA LISTA DE TIPOS DE COMISIONISTAS / TIPOS DE RED CONFIGURADOS    */
/* PARA EL CONCEPTO ESPECIFICO, EN EL CICLO DE COMISIONES ESPECIFICO.        */
/* FUNCIONALIDAD UNICA DE CICLOS DE COMISIONES PROMOCIONALES.                */
/*---------------------------------------------------------------------------*/
stTiposComis * stGetTipComisSelecProm(char *pszCodUniverso, reg_ciclo stCiclo)
{
	stTiposComis * paux;
	stTiposComis * qaux;
	
	int				i;                                                         
	short          	iLastRows    = 0;                                              
	int            	iFetchedRows = MAXFETCH;                                       
	int            	iRetrievRows = MAXFETCH;  
	int				iCuentaRegs  = 0; 
		
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		char	szhTipPeriodo[2];
		char	szhTIPOPERIODO[2];
		char	szhCodUniverso[7];
		int		ihCodCiclo;
		char	szhIdCiclComis[11];
		char    szhFecHastaNormal[11];
		char    szhFecDesdeNormal[11];
		char	chTipCiclComis;
		int		ihCodTipoRed[MAXFETCH];
		char	szhDesTipoRed[MAXFETCH][31];		
		char	szhCodTipComisA[MAXFETCH][3];
		char	szhDesTipComisA[MAXFETCH][31];
		char	szhCodTipComisS[MAXFETCH][3];
		char	szhDesTipComisS[MAXFETCH][31];
		char	szhINDPARCIAL[2];
		long 	lMaxFetch;

	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;

	ihCodCiclo    				= stCiclo.lCodCiclo;
	chTipCiclComis				= ESPORADICO;
	strcpy(szhIdCiclComis		, stCiclo.szIdCiclComis);
	strcpy(szhCodUniverso 		, pszCodUniverso);
	strcpy(szhFecHastaNormal 	, stCiclo.szFecHastaNormal);
	strcpy(szhFecDesdeNormal 	, stCiclo.szFecDesdeNormal);	
	strcpy(szhTipPeriodo	 	, stCiclo.szTipPeriodo);
	strcpy(szhTIPOPERIODO	 	, TIPPERIODO_M);
	strcpy(szhINDPARCIAL	 	, INDPARCIAL_S);
	
	/* EXEC SQL DECLARE CUR_TiposComisProm 
		CURSOR FOR SELECT DISTINCT
				A.COD_TIPORED,
				C.DES_TIPORED,
				H.COD_TIPCOMIS,
				G.DES_TIPCOMIS,
				D.COD_TIPCOMIS,
				E.DES_TIPCOMIS
		FROM 	CMD_CONCEPTOS F,
			 	CM_CONCEPTOSTIPORED_TD A,
			 	CM_PLANESTIPORED_TD B,
			 	VE_TIPORED_TD C,
			 	VE_DETALLE_TIPORED_TD D,
			 	VE_DETALLE_TIPORED_TD H,
			 	VE_TIPCOMIS E,
			 	VE_TIPCOMIS G
		WHERE F.COD_UNIVERSO   	=  :szhCodUniverso
		AND F.TIP_CICLCOMIS     =  :chTipCiclComis
		AND F.ID_CICLCOMIS		=  :szhIdCiclComis
		AND F.COD_CONCEPTO		=  A.COD_CONCEPTO
		AND A.COD_PLANCOMIS     =  B.COD_PLANCOMIS
		AND A.COD_TIPORED 		=  B.COD_TIPORED
		AND B.FEC_DESDE 		<= TO_DATE(:szhFecHastaNormal, 'DD-MM-YYYY')
		AND B.FEC_HASTA 		>= TO_DATE(:szhFecDesdeNormal, 'DD-MM-YYYY')
		AND B.COD_TIPORED 		=  C.COD_TIPORED
		AND C.COD_CICLOCOMIS	=  :ihCodCiclo
		AND C.COD_TIPORED 		=  D.COD_TIPORED
		AND D.NUM_NIVEL 		=  A.NIV_SELECCION
		AND D.COD_TIPCOMIS 		=  E.COD_TIPCOMIS
		AND C.COD_TIPORED 		=  H.COD_TIPORED
		AND A.NIV_APLICACION	=  H.NUM_NIVEL
		AND H.COD_TIPCOMIS		=  G.COD_TIPCOMIS
		AND((:szhTipPeriodo		=  :szhTIPOPERIODO) OR
		     (:szhTipPeriodo		!= :szhTIPOPERIODO AND F.IND_PARCIAL = :szhINDPARCIAL)); */ 


	/* EXEC SQL OPEN CUR_TiposComisProm; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0037;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )975;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodUniverso;
 sqlstm.sqhstl[0] = (unsigned long )7;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&chTipCiclComis;
 sqlstm.sqhstl[1] = (unsigned long )1;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhIdCiclComis;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHastaNormal;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesdeNormal;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCiclo;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[7] = (unsigned long )2;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[8] = (unsigned long )2;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[9] = (unsigned long )2;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhINDPARCIAL;
 sqlstm.sqhstl[10] = (unsigned long )2;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {                                                                              
	    /* EXEC SQL for :lMaxFetch FETCH CUR_TiposComisProm INTO
	    	:ihCodTipoRed,
	    	:szhDesTipoRed,
	    	:szhCodTipComisA, 
	    	:szhDesTipComisA,
	    	:szhCodTipComisS, 
	    	:szhDesTipComisS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1034;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhDesTipoRed;
     sqlstm.sqhstl[1] = (unsigned long )31;
     sqlstm.sqhsts[1] = (         int  )31;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComisA;
     sqlstm.sqhstl[2] = (unsigned long )3;
     sqlstm.sqhsts[2] = (         int  )3;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhDesTipComisA;
     sqlstm.sqhstl[3] = (unsigned long )31;
     sqlstm.sqhsts[3] = (         int  )31;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComisS;
     sqlstm.sqhstl[4] = (unsigned long )3;
     sqlstm.sqhsts[4] = (         int  )3;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhDesTipComisS;
     sqlstm.sqhstl[5] = (unsigned long )31;
     sqlstm.sqhsts[5] = (         int  )31;
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
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stTiposComis *) malloc(sizeof(stTiposComis));

	        paux->iCodTipoRed 				= ihCodTipoRed[i];
	        strcpy(paux->szDesTipoRed		, szfnTrim(szhDesTipoRed[i]));
	        strcpy(paux->szCodTipVendedor	, szfnTrim(szhCodTipComisS[i]));
	        strcpy(paux->szDesTipVendedor	, szfnTrim(szhDesTipComisS[i]));
	        strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComisA[i]));
	        strcpy(paux->szDesTipComis		, szfnTrim(szhDesTipComisA[i]));
	        paux->sgte 						= qaux;
	        qaux 							= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_TiposComisProm; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1073;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Tipos de Comisionistas para Universo:[%s] Ciclo[%d] =>[%d]\n",szhCodUniverso, ihCodCiclo ,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
/* OBTIENE LISTA DE CONCEPTOS/TIPO DE RED VIGENTES A SER EVALUADOS PARA UNA  */
/* FORMA COMISIONAL DADA, Y UN CICLO DE COMISIONES PERIODICO.                */
/*---------------------------------------------------------------------------*/
stConceptosProc * stGetConceptosPer_Normal(char *pszCodForma, reg_ciclo stCiclo)
{
	stConceptosProc * paux;
	stConceptosProc * qaux;
	
	int				i;                                                         
	short          	iLastRows    = 0;                                              
	int            	iFetchedRows = MAXFETCH;                                       
	int            	iRetrievRows = MAXFETCH;  
	int				iCuentaRegs  = 0; 
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		int		ihCodCiclo;
		char	szhIdCiclComis[11];
		char    szhFecHastaNormal[11];
		char    szhFecDesdeNormal[11];
		char	chTipCiclComis;
		char	szhCodForma[11];
		char	szhTipPeriodo[2];
		char	szhTIPOPERIODO[2];
		
		int		ihCodTipoRed[MAXFETCH];
		char	szhCodPlanComis[MAXFETCH][6];  
		char	szhCodTipComis[MAXFETCH][3];  
		int		ihCodConcepto[MAXFETCH];
		char	szhFecDesde[MAXFETCH][11];     
		char	szhFecHasta[MAXFETCH][11];     
		char	chCodTipCalulo[MAXFETCH][2];      
		char	szhCodTecnologia[MAXFETCH][8]; 
		char	szhCodUniverso[MAXFETCH][7];   
		char	dhFecDesde[MAXFETCH][15];     
		char	dhFecHasta[MAXFETCH][15];
		char	szhINDPARCIAL[2];

		long 	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;

	ihCodCiclo    				= stCiclo.lCodCiclo;
	chTipCiclComis				= PERIODICO;
	strcpy(szhIdCiclComis		, stCiclo.szIdCiclComis);
	strcpy(szhFecHastaNormal 	, stCiclo.szFecHastaNormal);
	strcpy(szhFecDesdeNormal 	, stCiclo.szFecDesdeNormal);
	strcpy(szhTipPeriodo	 	, stCiclo.szTipPeriodo);
	strcpy(szhCodForma 			, pszCodForma);
	strcpy(szhTIPOPERIODO	 	, TIPPERIODO_M);
	strcpy(szhINDPARCIAL	 	, INDPARCIAL_S);
	
	
	/* EXEC SQL DECLARE CUR_ConceptosPer_Normal
		CURSOR FOR SELECT 
			   A.COD_TIPORED,
			   B.COD_PLANCOMIS,
			   E.COD_TIPCOMIS,
			   C.COD_CONCEPTO,
			   TO_CHAR(B.FEC_DESDE,'DD-MM-YYYY'),
			   TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY'),
			   D.TIP_CALCULO,
			   D.COD_TECNOLOGIA,
			   D.COD_UNIVERSO,
			   TO_CHAR(B.FEC_DESDE,'YYYYMMDDHH24MISS'),
			   TO_CHAR(B.FEC_HASTA,'YYYYMMDDHH24MISS')
		FROM VE_TIPORED_TD A,
			 CM_PLANESTIPORED_TD B,
			 CM_CONCEPTOSTIPORED_TD C,
			 CMD_CONCEPTOS D,
			 VE_DETALLE_TIPORED_TD E
		WHERE A.COD_CICLOCOMIS 	= :ihCodCiclo
		  AND A.COD_TIPORED 	= B.COD_TIPORED
		  AND B.FEC_DESDE 		< TO_DATE(:szhFecHastaNormal,'DD-MM-YYYY')
		  AND B.FEC_HASTA 		> TO_DATE(:szhFecDesdeNormal,'DD-MM-YYYY')
		  AND B.COD_TIPORED 	= C.COD_TIPORED
		  AND B.COD_PLANCOMIS 	= C.COD_PLANCOMIS
		  AND C.COD_CONCEPTO 	= D.COD_CONCEPTO
		  AND D.COD_FORMA 		= :szhCodForma
		  AND D.TIP_CICLCOMIS 	= :chTipCiclComis
		  AND C.COD_TIPORED		= E.COD_TIPORED
		  AND C.NIV_APLICACION	= E.NUM_NIVEL
		  AND((:szhTipPeriodo		=  :szhTIPOPERIODO) OR
		     (:szhTipPeriodo		!= :szhTIPOPERIODO AND D.IND_PARCIAL = :szhINDPARCIAL)); */ 

		
	/* EXEC SQL OPEN CUR_ConceptosPer_Normal; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0038;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1088;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecHastaNormal;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesdeNormal;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodForma;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&chTipCiclComis;
 sqlstm.sqhstl[4] = (unsigned long )1;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[7] = (unsigned long )2;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[8] = (unsigned long )2;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhINDPARCIAL;
 sqlstm.sqhstl[9] = (unsigned long )2;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {
	    /* EXEC SQL for :lMaxFetch FETCH CUR_ConceptosPer_Normal INTO
	    	:ihCodTipoRed, 
	    	:szhCodPlanComis, 
	    	:szhCodTipComis, 
	    	:ihCodConcepto, 
	    	:szhFecDesde, 
	    	:szhFecHasta, 
	    	:chCodTipCalulo, 
	    	:szhCodTecnologia, 
	    	:szhCodUniverso, 
	    	:dhFecDesde, 
	    	:dhFecHasta; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1143;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )6;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[2] = (unsigned long )3;
     sqlstm.sqhsts[2] = (         int  )3;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)ihCodConcepto;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )sizeof(int);
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
     sqlstm.sqhstl[4] = (unsigned long )11;
     sqlstm.sqhsts[4] = (         int  )11;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhFecHasta;
     sqlstm.sqhstl[5] = (unsigned long )11;
     sqlstm.sqhsts[5] = (         int  )11;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqharc[5] = (unsigned long  *)0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)chCodTipCalulo;
     sqlstm.sqhstl[6] = (unsigned long )2;
     sqlstm.sqhsts[6] = (         int  )2;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqharc[6] = (unsigned long  *)0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[7] = (unsigned long )8;
     sqlstm.sqhsts[7] = (         int  )8;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqharc[7] = (unsigned long  *)0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCodUniverso;
     sqlstm.sqhstl[8] = (unsigned long )7;
     sqlstm.sqhsts[8] = (         int  )7;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqharc[8] = (unsigned long  *)0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)dhFecDesde;
     sqlstm.sqhstl[9] = (unsigned long )15;
     sqlstm.sqhsts[9] = (         int  )15;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqharc[9] = (unsigned long  *)0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)dhFecHasta;
     sqlstm.sqhstl[10] = (unsigned long )15;
     sqlstm.sqhsts[10] = (         int  )15;
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



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stConceptosProc *) malloc(sizeof(stConceptosProc));

			paux->iCodTipoRed         		= ihCodTipoRed[i];
			strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComis[i]));
			strcpy(paux->szCodPlanComis		, szfnTrim(szhCodPlanComis[i]));
			paux->iCodConcepto        		= ihCodConcepto[i];
			strcpy(paux->szFecDesde        	, szfnTrim(szhFecDesde[i]));
			strcpy(paux->szFecHasta        	, szfnTrim(szhFecHasta[i]));
			strcpy(paux->cCodTipCalculo     , szfnTrim(chCodTipCalulo[i]));
			strcpy(paux->szCodTecnologia   	, szfnTrim(szhCodTecnologia[i]));
			strcpy(paux->szCodUniverso     	, szfnTrim(szhCodUniverso[i]));
			strcpy(paux->szCodForma        	, szhCodForma);
			paux->dFecDesde        			= atof(szfnTrim(dhFecDesde[i]));
			paux->dFecHasta        			= atof(szfnTrim(dhFecHasta[i]));
			
	        paux->sgte 						= qaux;
	        qaux 							= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_ConceptosPer_Normal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1202;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Conceptos [PERIODICOS] Vigentes Para Forma Comisional:[%s] Ciclo[%d] =>[%d]\n",szhCodForma, ihCodCiclo ,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
stConceptosProc * stGetConceptosPer_AltaContra(char *pszCodForma, reg_ciclo stCiclo)
{
	stConceptosProc * paux;
	stConceptosProc * qaux;
	
	int				i;                                                         
	short          	iLastRows    = 0;                                              
	int            	iFetchedRows = MAXFETCH;                                       
	int            	iRetrievRows = MAXFETCH;  
	int				iCuentaRegs  = 0; 
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		int		ihCodCiclo;
		char	szhIdCiclComis[11];
		char    szhFecHastaNormal[11];
		char    szhFecDesdeNormal[11];
		char	chTipCiclComis;
		char	szhCodForma[11];
		char	szhTipPeriodo[2];
		char	szhTIPOPERIODO[2];
		
		int		ihCodTipoRed[MAXFETCH];
		char	szhCodPlanComis[MAXFETCH][6];  
		char	szhCodTipComis[MAXFETCH][3];  
		int		ihCodConcepto[MAXFETCH];
		char	szhFecDesde[MAXFETCH][11];     
		char	szhFecHasta[MAXFETCH][11];     
		char	chCodTipCalulo[MAXFETCH][2];      
		char	szhCodTecnologia[MAXFETCH][8]; 
		char	szhCodUniverso[MAXFETCH][7];   
		char	dhFecDesde[MAXFETCH][15];     
		char	dhFecHasta[MAXFETCH][15];
		char	szhINDPARCIAL[2];
		

		long 	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;

	ihCodCiclo    				= stCiclo.lCodCiclo;
	chTipCiclComis				= PERIODICO;
	strcpy(szhIdCiclComis		, stCiclo.szIdCiclComis);
	strcpy(szhFecHastaNormal 	, stCiclo.szFecHastaNormal);
	strcpy(szhFecDesdeNormal 	, stCiclo.szFecDesdeNormal);
	strcpy(szhTipPeriodo	 	, stCiclo.szTipPeriodo);
	strcpy(szhCodForma 			, pszCodForma);
	strcpy(szhTIPOPERIODO	 	, TIPPERIODO_M);
	strcpy(szhINDPARCIAL	 	, INDPARCIAL_S);
	
	/* EXEC SQL DECLARE CUR_ConceptosPer_ALTACONTRA
		CURSOR FOR SELECT 
			   A.COD_TIPORED,
			   B.COD_PLANCOMIS,
			   E.COD_TIPCOMIS,
			   C.COD_CONCEPTO,
			   TO_CHAR(B.FEC_DESDE,'DD-MM-YYYY'),
			   TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY'),
			   D.TIP_CALCULO,
			   D.COD_TECNOLOGIA,
			   D.COD_UNIVERSO,
			   TO_CHAR(B.FEC_DESDE,'YYYYMMDDHH24MISS'),
			   TO_CHAR(B.FEC_HASTA,'YYYYMMDDHH24MISS')
		FROM VE_TIPORED_TD A,
			 CM_PLANESTIPORED_TD B,
			 CM_CONCEPTOSTIPORED_TD C,
			 CMD_CONCEPTOS D,
			 VE_DETALLE_TIPORED_TD E
		WHERE A.COD_CICLOCOMIS 	= :ihCodCiclo
		  AND A.COD_TIPORED 	= B.COD_TIPORED
		  AND B.FEC_DESDE 		< TO_DATE(:szhFecHastaNormal,'DD-MM-YYYY')
		  AND B.FEC_HASTA 		> TO_DATE(:szhFecDesdeNormal,'DD-MM-YYYY')
		  AND B.COD_TIPORED 	= C.COD_TIPORED
		  AND B.COD_PLANCOMIS 	= C.COD_PLANCOMIS
		  AND C.COD_CONCEPTO 	= D.COD_CONCEPTO
		  AND D.COD_FORMA 		IN ('ALTACONTRA','FONDOSCOAP','PRESENCIA')
		  AND D.TIP_CICLCOMIS 	= :chTipCiclComis
		  AND C.COD_TIPORED		= E.COD_TIPORED
		  AND C.NIV_APLICACION	= E.NUM_NIVEL
		  AND((:szhTipPeriodo		=  :szhTIPOPERIODO) OR
		     (:szhTipPeriodo		!= :szhTIPOPERIODO AND D.IND_PARCIAL = :szhINDPARCIAL)); */ 

		
	/* EXEC SQL OPEN CUR_ConceptosPer_ALTACONTRA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0039;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1217;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecHastaNormal;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesdeNormal;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&chTipCiclComis;
 sqlstm.sqhstl[3] = (unsigned long )1;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[7] = (unsigned long )2;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhINDPARCIAL;
 sqlstm.sqhstl[8] = (unsigned long )2;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {
	    /* EXEC SQL for :lMaxFetch FETCH CUR_ConceptosPer_ALTACONTRA INTO
	    	:ihCodTipoRed, 
	    	:szhCodPlanComis, 
	    	:szhCodTipComis, 
	    	:ihCodConcepto, 
	    	:szhFecDesde, 
	    	:szhFecHasta, 
	    	:chCodTipCalulo, 
	    	:szhCodTecnologia, 
	    	:szhCodUniverso, 
	    	:dhFecDesde, 
	    	:dhFecHasta; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1268;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )6;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[2] = (unsigned long )3;
     sqlstm.sqhsts[2] = (         int  )3;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)ihCodConcepto;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )sizeof(int);
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
     sqlstm.sqhstl[4] = (unsigned long )11;
     sqlstm.sqhsts[4] = (         int  )11;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhFecHasta;
     sqlstm.sqhstl[5] = (unsigned long )11;
     sqlstm.sqhsts[5] = (         int  )11;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqharc[5] = (unsigned long  *)0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)chCodTipCalulo;
     sqlstm.sqhstl[6] = (unsigned long )2;
     sqlstm.sqhsts[6] = (         int  )2;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqharc[6] = (unsigned long  *)0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[7] = (unsigned long )8;
     sqlstm.sqhsts[7] = (         int  )8;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqharc[7] = (unsigned long  *)0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCodUniverso;
     sqlstm.sqhstl[8] = (unsigned long )7;
     sqlstm.sqhsts[8] = (         int  )7;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqharc[8] = (unsigned long  *)0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)dhFecDesde;
     sqlstm.sqhstl[9] = (unsigned long )15;
     sqlstm.sqhsts[9] = (         int  )15;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqharc[9] = (unsigned long  *)0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)dhFecHasta;
     sqlstm.sqhstl[10] = (unsigned long )15;
     sqlstm.sqhsts[10] = (         int  )15;
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



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stConceptosProc *) malloc(sizeof(stConceptosProc));

			paux->iCodTipoRed         		= ihCodTipoRed[i];
			strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComis[i]));
			strcpy(paux->szCodPlanComis		, szfnTrim(szhCodPlanComis[i]));
			paux->iCodConcepto        		= ihCodConcepto[i];
			strcpy(paux->szFecDesde        	, szfnTrim(szhFecDesde[i]));
			strcpy(paux->szFecHasta        	, szfnTrim(szhFecHasta[i]));
			strcpy(paux->cCodTipCalculo     , szfnTrim(chCodTipCalulo[i]));
			strcpy(paux->szCodTecnologia   	, szfnTrim(szhCodTecnologia[i]));
			strcpy(paux->szCodUniverso     	, szfnTrim(szhCodUniverso[i]));
			strcpy(paux->szCodForma        	, szhCodForma);
			paux->dFecDesde        			= atof(szfnTrim(dhFecDesde[i]));
			paux->dFecHasta        			= atof(szfnTrim(dhFecHasta[i]));
			
	        paux->sgte 						= qaux;
	        qaux 							= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_ConceptosPer_ALTACONTRA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1327;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Conceptos [PERIODICOS] Vigentes Para Forma Comisional:[%s] Ciclo[%d] =>[%d]\n",szhCodForma, ihCodCiclo ,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
stConceptosProc * stGetConceptosPer(char *pszCodForma, reg_ciclo stCiclo)
{
	if (strcmp(pszCodForma, "ALTACONTRA")==0)
		return stGetConceptosPer_AltaContra(pszCodForma, stCiclo);
	else
		return stGetConceptosPer_Normal(pszCodForma, stCiclo);
}
/*---------------------------------------------------------------------------*/
/* OBTIENE LISTA DE CONCEPTOS/TIPO DE RED VIGENTES A SER EVALUADOS PARA UNA  */
/* FORMA COMISIONAL DADA, Y EL IDENTIFICADOR DE LA PROMOCIÓN EN PROCESO.     */
/*---------------------------------------------------------------------------*/
stConceptosProc * stGetConceptosProm_Normal(char *pszCodForma, reg_ciclo stCiclo)
{
	stConceptosProc * paux;
	stConceptosProc * qaux;
	
	int				i;
	short          	iLastRows    = 0;
	int            	iFetchedRows = MAXFETCH;
	int            	iRetrievRows = MAXFETCH;
	int				iCuentaRegs  = 0;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		int		ihCodCiclo;
		char	szhIdCiclComis[11];
		char	chTipCiclComis;
		char	szhCodForma[11];
		char	szhDesCiclComis[61];		
		char	szhTipPeriodo[2];
		char	szhTIPOPERIODO[2];
		
		int		ihCodTipoRed[MAXFETCH];
		char	szhCodPlanComis[MAXFETCH][6];  
		char	szhCodTipComis[MAXFETCH][3];  
		int		ihCodConcepto[MAXFETCH];       
		char	szhFecDesde[MAXFETCH][11];     
		char	szhFecHasta[MAXFETCH][11];     
		char	chCodTipCalulo[MAXFETCH][2];      
		char	szhCodTecnologia[MAXFETCH][8]; 
		char	szhCodUniverso[MAXFETCH][7];   
		char	szhINDPARCIAL[2];

		long 	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;

	ihCodCiclo    				= stCiclo.lCodCiclo;
	chTipCiclComis				= ESPORADICO;
	strcpy(szhIdCiclComis		, stCiclo.szIdCiclComis);
	strcpy(szhCodForma 			, pszCodForma);
	strcpy(szhDesCiclComis		, stCiclo.szDesCiclcomis);
	strcpy(szhTipPeriodo	 	, stCiclo.szTipPeriodo);
	strcpy(szhTIPOPERIODO	 	, TIPPERIODO_M);
	strcpy(szhINDPARCIAL	 	, INDPARCIAL_S);
	
	/* EXEC SQL DECLARE CUR_ConceptosProm_NORMAL
		CURSOR FOR SELECT 
			   C.COD_TIPORED,
			   C.COD_PLANCOMIS,
			   E.COD_TIPCOMIS,
			   D.COD_CONCEPTO,
			   TO_CHAR(B.FEC_DESDE,'DD-MM-YYYY'),
			   TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY'),
			   D.TIP_CALCULO,
			   D.COD_TECNOLOGIA,
			   D.COD_UNIVERSO
		FROM CM_PLANESTIPORED_TD B,
			 CM_CONCEPTOSTIPORED_TD C,
			 CMD_CONCEPTOS D,
			 VE_DETALLE_TIPORED_TD E
		WHERE D.TIP_CICLCOMIS 	= :chTipCiclComis
		  AND D.ID_CICLCOMIS 	= :szhIdCiclComis
		  AND D.COD_FORMA 		= :szhCodForma
		  AND D.COD_CONCEPTO 	= C.COD_CONCEPTO
		  AND C.COD_TIPORED		= B.COD_TIPORED
		  AND C.COD_PLANCOMIS	= B.COD_PLANCOMIS
		  AND C.COD_TIPORED		= E.COD_TIPORED
		  AND C.NIV_APLICACION	= E.NUM_NIVEL
		  AND((:szhTipPeriodo		=  :szhTIPOPERIODO) OR
		     (:szhTipPeriodo		!= :szhTIPOPERIODO AND D.IND_PARCIAL = :szhINDPARCIAL)); */ 

		
	/* EXEC SQL OPEN CUR_ConceptosProm_NORMAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0040;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1342;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&chTipCiclComis;
 sqlstm.sqhstl[0] = (unsigned long )1;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhIdCiclComis;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodForma;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhINDPARCIAL;
 sqlstm.sqhstl[7] = (unsigned long )2;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {
	    /* EXEC SQL for :lMaxFetch FETCH CUR_ConceptosProm_NORMAL INTO
	    	:ihCodTipoRed, 
	    	:szhCodPlanComis, 
	    	:szhCodTipComis, 
	    	:ihCodConcepto, 
	    	:szhFecDesde, 
	    	:szhFecHasta, 
	    	:chCodTipCalulo, 
	    	:szhCodTecnologia, 
	    	:szhCodUniverso; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1389;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )6;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[2] = (unsigned long )3;
     sqlstm.sqhsts[2] = (         int  )3;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)ihCodConcepto;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )sizeof(int);
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
     sqlstm.sqhstl[4] = (unsigned long )11;
     sqlstm.sqhsts[4] = (         int  )11;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhFecHasta;
     sqlstm.sqhstl[5] = (unsigned long )11;
     sqlstm.sqhsts[5] = (         int  )11;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqharc[5] = (unsigned long  *)0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)chCodTipCalulo;
     sqlstm.sqhstl[6] = (unsigned long )2;
     sqlstm.sqhsts[6] = (         int  )2;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqharc[6] = (unsigned long  *)0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[7] = (unsigned long )8;
     sqlstm.sqhsts[7] = (         int  )8;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqharc[7] = (unsigned long  *)0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCodUniverso;
     sqlstm.sqhstl[8] = (unsigned long )7;
     sqlstm.sqhsts[8] = (         int  )7;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqharc[8] = (unsigned long  *)0;
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



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stConceptosProc *) malloc(sizeof(stConceptosProc));

			paux->iCodTipoRed         		= ihCodTipoRed[i];
			strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComis[i]));
			strcpy(paux->szCodPlanComis		, szfnTrim(szhCodPlanComis[i]));
			paux->iCodConcepto        		= ihCodConcepto[i];
			strcpy(paux->szFecDesde        	, szfnTrim(szhFecDesde[i]));
			strcpy(paux->szFecHasta         , szfnTrim(szhFecHasta[i]));
			strcpy(paux->cCodTipCalculo     , szfnTrim(chCodTipCalulo[i]));
			strcpy(paux->szCodTecnologia   	, szfnTrim(szhCodTecnologia[i]));
			strcpy(paux->szCodUniverso     	, szfnTrim(szhCodUniverso[i]));
			strcpy(paux->szCodForma        	, szhCodForma);

	        paux->sgte 						= qaux;
	        qaux 							= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_ConceptosProm_NORMAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1440;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Conceptos [ESPORADICOS] Vigentes Para Forma Comisional:[%s] Promoción[%s] =>[%d]\n",szhCodForma, szhDesCiclComis,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
stConceptosProc * stGetConceptosProm_AltaContra(char *pszCodForma, reg_ciclo stCiclo)
{
	stConceptosProc * paux;
	stConceptosProc * qaux;
	
	int				i;
	short          	iLastRows    = 0;
	int            	iFetchedRows = MAXFETCH;
	int            	iRetrievRows = MAXFETCH;
	int				iCuentaRegs  = 0;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		int		ihCodCiclo;
		char	szhIdCiclComis[11];
		char	chTipCiclComis;
		char	szhCodForma[11];
		char	szhDesCiclComis[61];
		char	szhTipPeriodo[2];
		char	szhTIPOPERIODO[2];
		
		int		ihCodTipoRed[MAXFETCH];
		char	szhCodPlanComis[MAXFETCH][6];  
		char	szhCodTipComis[MAXFETCH][3];  
		int		ihCodConcepto[MAXFETCH];       
		char	szhFecDesde[MAXFETCH][11];     
		char	szhFecHasta[MAXFETCH][11];     
		char	chCodTipCalulo[MAXFETCH][2];      
		char	szhCodTecnologia[MAXFETCH][8]; 
		char	szhCodUniverso[MAXFETCH][7];
		char	szhINDPARCIAL[2];

		long 	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;

	ihCodCiclo    				= stCiclo.lCodCiclo;
	chTipCiclComis				= ESPORADICO;
	strcpy(szhIdCiclComis		, stCiclo.szIdCiclComis);
	strcpy(szhCodForma 			, pszCodForma);
	strcpy(szhDesCiclComis		, stCiclo.szDesCiclcomis);
	strcpy(szhTipPeriodo	 	, stCiclo.szTipPeriodo);
	strcpy(szhTIPOPERIODO	 	, TIPPERIODO_M);
	strcpy(szhINDPARCIAL	 	, INDPARCIAL_S);
	
	/* EXEC SQL DECLARE CUR_ConceptosProm_ALTACONTRA
		CURSOR FOR SELECT 
			   C.COD_TIPORED,
			   C.COD_PLANCOMIS,
			   E.COD_TIPCOMIS,
			   D.COD_CONCEPTO,
			   TO_CHAR(B.FEC_DESDE,'DD-MM-YYYY'),
			   TO_CHAR(B.FEC_HASTA,'DD-MM-YYYY'),
			   D.TIP_CALCULO,
			   D.COD_TECNOLOGIA,
			   D.COD_UNIVERSO
		FROM CM_PLANESTIPORED_TD B,
			 CM_CONCEPTOSTIPORED_TD C,
			 CMD_CONCEPTOS D,
			 VE_DETALLE_TIPORED_TD E
		WHERE D.TIP_CICLCOMIS 	= :chTipCiclComis
		  AND D.ID_CICLCOMIS 	= :szhIdCiclComis
		  AND D.COD_FORMA 		IN ('ALTACONTRA','FONDOSCOAP','PRESENCIA')
		  AND D.COD_CONCEPTO 	= C.COD_CONCEPTO
		  AND C.COD_TIPORED		= B.COD_TIPORED
		  AND C.COD_PLANCOMIS	= B.COD_PLANCOMIS
		  AND C.COD_TIPORED		= E.COD_TIPORED
		  AND C.NIV_APLICACION	= E.NUM_NIVEL
		  AND((:szhTipPeriodo		=  :szhTIPOPERIODO) OR
		     (:szhTipPeriodo		!= :szhTIPOPERIODO AND D.IND_PARCIAL = :szhINDPARCIAL)); */ 

		
	/* EXEC SQL OPEN CUR_ConceptosProm_ALTACONTRA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0041;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1455;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&chTipCiclComis;
 sqlstm.sqhstl[0] = (unsigned long )1;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhIdCiclComis;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[2] = (unsigned long )2;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTipPeriodo;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTIPOPERIODO;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhINDPARCIAL;
 sqlstm.sqhstl[6] = (unsigned long )2;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {
	    /* EXEC SQL for :lMaxFetch FETCH CUR_ConceptosProm_ALTACONTRA INTO
	    	:ihCodTipoRed, 
	    	:szhCodPlanComis, 
	    	:szhCodTipComis, 
	    	:ihCodConcepto, 
	    	:szhFecDesde, 
	    	:szhFecHasta, 
	    	:chCodTipCalulo, 
	    	:szhCodTecnologia, 
	    	:szhCodUniverso; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1498;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )sizeof(int);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )6;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[2] = (unsigned long )3;
     sqlstm.sqhsts[2] = (         int  )3;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)ihCodConcepto;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )sizeof(int);
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
     sqlstm.sqhstl[4] = (unsigned long )11;
     sqlstm.sqhsts[4] = (         int  )11;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhFecHasta;
     sqlstm.sqhstl[5] = (unsigned long )11;
     sqlstm.sqhsts[5] = (         int  )11;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqharc[5] = (unsigned long  *)0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)chCodTipCalulo;
     sqlstm.sqhstl[6] = (unsigned long )2;
     sqlstm.sqhsts[6] = (         int  )2;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqharc[6] = (unsigned long  *)0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[7] = (unsigned long )8;
     sqlstm.sqhsts[7] = (         int  )8;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqharc[7] = (unsigned long  *)0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCodUniverso;
     sqlstm.sqhstl[8] = (unsigned long )7;
     sqlstm.sqhsts[8] = (         int  )7;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqharc[8] = (unsigned long  *)0;
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



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stConceptosProc *) malloc(sizeof(stConceptosProc));

			paux->iCodTipoRed         		= ihCodTipoRed[i];
			strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComis[i]));
			strcpy(paux->szCodPlanComis		, szfnTrim(szhCodPlanComis[i]));
			paux->iCodConcepto        		= ihCodConcepto[i];
			strcpy(paux->szFecDesde        	, szfnTrim(szhFecDesde[i]));
			strcpy(paux->szFecHasta         , szfnTrim(szhFecHasta[i]));
			strcpy(paux->cCodTipCalculo     , szfnTrim(chCodTipCalulo[i]));
			strcpy(paux->szCodTecnologia   	, szfnTrim(szhCodTecnologia[i]));
			strcpy(paux->szCodUniverso     	, szfnTrim(szhCodUniverso[i]));
			strcpy(paux->szCodForma        	, szhCodForma);

	        paux->sgte 						= qaux;
	        qaux 							= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_ConceptosProm_ALTACONTRA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
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


    fprintf(stderr,"\nCantidad de Conceptos [ESPORADICOS] Vigentes Para Forma Comisional:[%s] Promoción[%s] =>[%d]\n",szhCodForma, szhDesCiclComis,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
stConceptosProc * stGetConceptosProm(char *pszCodForma, reg_ciclo stCiclo)
{
	if (strcmp(pszCodForma, "ALTACONTRA")==0)
		return stGetConceptosProm_AltaContra(pszCodForma, stCiclo);
	else
		return stGetConceptosProm_Normal(pszCodForma, stCiclo);
}
/*---------------------------------------------------------------------------*/
/* LIBERA LA MEMORIA UTILIZADA POR LA LISTA DE CONCEPTOS DE VALORACIÓN.      */
/*---------------------------------------------------------------------------*/
void vLiberaConceptosVal(stConceptosProc * paux)
{
	if (paux!= NULL)
	{
		vLiberaConceptosVal(paux->sgte);
		free (paux);
	}
}
/*---------------------------------------------------------------------------*/
/* OBTIENE LA LISTA DE TIPOS DE COMISIONISTAS DE LA FORMA ('10','11','12')   */
/* PARA EL CONCEPTO ESPECIFICO, EN EL CICLO DE COMISIONES ESPECIFICO.        */
/* FUNCIONALIDAD UNICA DE CICLOS DE COMISIONES PERIODICOS.                   */
/* FUNCIONALIDAD POCO FUNCIONAL  +++QUEDA EN DUDA SU USO+++++                */
/*---------------------------------------------------------------------------*/
char * szfnGetTiposComisConc(int piCodConcepto, reg_ciclo stCiclo)
{
	int				i;                                                         
	short          	iLastRows    = 0;                                              
	int            	iFetchedRows = MAXFETCH;                                       
	int            	iRetrievRows = MAXFETCH;  
	int				iCuentaRegs  = 0; 
	char		    szSentencia[STR_LONG] = "";
	char		   	szTipos[STR_LONG] = "";
	char		   	szPaso[STR_LONG] = "";
		
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		char	szhTipPeriodo[2];
		int		ihCodConcepto;
		int		ihCodCiclo;
		char    szhFecHastaNormal[11];
		char    szhFecDesdeNormal[11];
		char	szhCodTipComis[MAXFETCH][3];
		long 	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 


	ihCodConcepto = piCodConcepto;
	ihCodCiclo    = stCiclo.lCodCiclo;
	strcpy(szhFecHastaNormal , stCiclo.szFecHastaNormal);
	strcpy(szhFecDesdeNormal , stCiclo.szFecDesdeNormal);
	strcpy(szhTipPeriodo	 , stCiclo.szTipPeriodo);

	/* EXEC SQL DECLARE CUR_szTiposComis CURSOR FOR SELECT 
			  DISTINCT D.COD_TIPCOMIS
		FROM CM_CONCEPTOSTIPORED_TD A,
			 CM_PLANESTIPORED_TD B,
			 VE_TIPORED_TD C,
			 VE_DETALLE_TIPORED_TD D
		WHERE A.COD_CONCEPTO 	=  :ihCodConcepto
		AND A.COD_TIPORED 		=  B.COD_TIPORED
		AND A.COD_PLANCOMIS		=  B.COD_PLANCOMIS
		AND B.FEC_DESDE 		<= TO_DATE(:szhFecHastaNormal, 'DD-MM-YYYY')
		AND B.FEC_HASTA 		>= TO_DATE(:szhFecDesdeNormal, 'DD-MM-YYYY')
		AND B.COD_TIPORED 		=  C.COD_TIPORED
		AND C.COD_CICLOCOMIS	=  :ihCodCiclo
		AND C.COD_TIPORED 		=  D.COD_TIPORED
		AND D.NUM_NIVEL 		=  A.NIV_SELECCION; */ 

		
	/* EXEC SQL OPEN CUR_szTiposComis; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0042;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1564;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecHastaNormal;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesdeNormal;
 sqlstm.sqhstl[2] = (unsigned long )11;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {                                                                              
	    /* EXEC SQL for :lMaxFetch FETCH CUR_szTiposComis INTO :szhCodTipComis; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1595;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[0] = (unsigned long )3;
     sqlstm.sqhsts[0] = (         int  )3;
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


 
        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {
	        strcpy(szPaso,"");
	        sprintf(szPaso,"'%s',",szfnTrim(szhCodTipComis[i]));
	        strcat(szTipos, szPaso);

	        iCuentaRegs++;
        }
    }
    if (iCuentaRegs>0)
    {
		szTipos[strlen(szTipos)]='\0';
		sprintf(szSentencia," (%s) ",szTipos);
    }
    else
    	strcpy(szSentencia , "('')");	
	fprintf(stderr,"<%s>\n",szSentencia);
    /* EXEC SQL CLOSE CUR_szTiposComis; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1614;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Tipos de Comisionistas para Concepto:[%d] Ciclo[%d] =>[%d]\n",ihCodConcepto, ihCodCiclo ,iCuentaRegs);
    return szSentencia;
}
/*---------------------------------------------------------------------------*/
/* LIBERA LA LISTA DONDE SE CARGARON LOS TIPOS DE COMISIONISTA.              */
/*---------------------------------------------------------------------------*/
void vLiberaTiposComis(stTiposComis * paux)
{
	if (paux != NULL)
	{
		vLiberaTiposComis(paux->sgte);
		free(paux);
	}
}
/*---------------------------------------------------------------------------*/
/* OBTIENE NIVEL DE UN VENDEDOR DENTRO DE UN TIPO DE RED.                    */
/*---------------------------------------------------------------------------*/
int iGetNivelVendedor(int piCodTipoRed,long plCodVendedor)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;
		long	lhCodVendedor;
		int		ihNumNivel;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihCodTipoRed 	= piCodTipoRed;
	lhCodVendedor	= plCodVendedor;
	
	/* EXEC SQL SELECT NUM_NIVEL
		INTO :ihNumNivel
		FROM VE_REDVENTAS_TD
		WHERE COD_TIPORED 	= :ihCodTipoRed
		AND COD_VENDEDOR 	= :lhCodVendedor
		AND (SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA
		  OR FEC_HASTA IS NULL); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NUM_NIVEL into :b0  from VE_REDVENTAS_TD where ((COD_\
TIPORED=:b1 and COD_VENDEDOR=:b2) and (SYSDATE between FEC_DESDE and FEC_HASTA\
 or FEC_HASTA is null ))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1629;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumNivel;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedor;
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


		
	if (!sqlca.sqlcode)
		return ihNumNivel;	
	return 0;
}
/*---------------------------------------------------------------------------*/
/* OBTIENE EL NOMBRE DE LA BASE DE DATOS SOBRE A LA QUE SE ESTÁ CONECTADO.   */
/*---------------------------------------------------------------------------*/
char * sysGetDBName()
{
/*	EXEC SQL BEGIN DECLARE SECTION;	*/
/*		char	szhDBName[10];      */
/*	EXEC SQL END DECLARE SECTION;   */
/*	                                */
/*	EXEC SQL SELECT NAME            */
/*	INTO :szhDBName FROM V$DATABASE;*/
/*	                                */
/*	return(szhDBName);              */

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhUserName[10]; 
	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL SELECT USER
	INTO :szhUserName FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select USER into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1656;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUserName;
 sqlstm.sqhstl[0] = (unsigned long )10;
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


	
	return(szhUserName);

}
/*---------------------------------------------------------------------------*/
/* OBTIENE EL NOMBRE DEL USUARIO CONECTADO A LA BASE DE DATOS.               */
/*---------------------------------------------------------------------------*/
char * sysGetUserName()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhUserName[10]; 
	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL SELECT USER
	INTO :szhUserName FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select USER into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1675;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUserName;
 sqlstm.sqhstl[0] = (unsigned long )10;
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


	
	return(szhUserName);
}
/*---------------------------------------------------------------------------*/
/* DAFO UN TIPO DE RED, OBTIENE LA CATEGORIA DE VENTAS DEL PADRE (N-1).      */
/*---------------------------------------------------------------------------*/
char * szGetTipComisRed(int piTipoRed)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhTipComis[3];
		int		ihTipoRed; 
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihTipoRed = piTipoRed;
	strcpy(szhTipComis, "");
	/* EXEC SQL SELECT 
			COD_TIPCOMIS
		INTO :szhTipComis 
		FROM VE_DETALLE_TIPORED_TD
		WHERE COD_TIPORED = :ihTipoRed
		AND NUM_NIVEL = 1; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_TIPCOMIS into :b0  from VE_DETALLE_TIPORED_TD whe\
re (COD_TIPORED=:b1 and NUM_NIVEL=1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1694;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhTipComis;
 sqlstm.sqhstl[0] = (unsigned long )3;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihTipoRed;
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


	
	return szfnTrim(szhTipComis);
}
/*---------------------------------------------------------------------------*/
/* OBTIENE EL VENDEDOR RAIZ DE UN VENDEDOR, DADO EL TIPO DE RED.             */
/*---------------------------------------------------------------------------*/
long lGetVendedorRaiz(int piCodTipoRed,long plCodVendedor)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;
		long	lhCodVendedor;
		long	lhCodVendedorRaiz;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihCodTipoRed 	= piCodTipoRed;
	lhCodVendedor	= plCodVendedor;

	/* EXEC SQL SELECT COD_VENDE_PADRE
		INTO :lhCodVendedorRaiz
		FROM VE_REDVENTAS_TD
		WHERE COD_TIPORED 	= :ihCodTipoRed
		AND COD_VENDEDOR 	= :lhCodVendedor
		AND (SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA OR FEC_HASTA IS NULL); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_VENDE_PADRE into :b0  from VE_REDVENTAS_TD where \
((COD_TIPORED=:b1 and COD_VENDEDOR=:b2) and (SYSDATE between FEC_DESDE and FEC\
_HASTA or FEC_HASTA is null ))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1717;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodVendedorRaiz;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedor;
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



	if (!sqlca.sqlcode)
		return lhCodVendedorRaiz;	
	return 0;
}	
/*---------------------------------------------------------------------------*/
/* OBTIENE VENDEDOR PADRE DE UN TIPO DE RED, DADO UN VENDEDOR HIJO (N-NIVEL) */
/*---------------------------------------------------------------------------*/
long lGetVendedorPadre(int iCodTipoRed,long lCodVendedor)
{
	
	int		iNumNivel;
	long	lCodVendedorRaiz;
	
	iNumNivel = iGetNivelVendedor(iCodTipoRed, lCodVendedor);
	if (iNumNivel == 0)
		return 0;
	
	if (iNumNivel == 1)
		return lCodVendedor;

	lCodVendedorRaiz = lGetVendedorRaiz(iCodTipoRed, lCodVendedor);
	if (lCodVendedorRaiz > 0)
		return lGetVendedorPadre(iCodTipoRed , lCodVendedorRaiz);
	else
		return 0;
}
/*---------------------------------------------------------------------------*/
/* A PARTIR DE UN VENDEDOR PADRE, Y DEL TIPO DE RED, GENERA UNA LISTA CON    */
/* TODOS LOS INTEGRANTES DE LA ESTRUCTURA DE VENTAS, DESCENDIENTES DEL PADRE */
/* INCLUYÉNDOLO A ÉL MISMO.                                                  */
/*---------------------------------------------------------------------------*/
stRedVentas * stCreaRedVentas(int iCodTipoRed, long lCodVendedor)
{
	stRedVentas * paux;
	stRedVentas * qaux;

	int				i;
	short          	iLastRows    = 0;
	int            	iFetchedRows = MAXFETCH;
	int            	iRetrievRows = MAXFETCH;
	int				iCuentaRegs  = 0;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		int		ihCodTipoRed;
		long	lhCodPadre;
		long	lhCodVendedor[MAXFETCH];
		long	lhCodVendePadre[MAXFETCH];
		int		ihNumNivel[MAXFETCH];
		long 	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;
	ihCodTipoRed  	= iCodTipoRed;
	lhCodPadre 		= lCodVendedor;
	/* EXEC SQL DECLARE CUR_RedDeVentas
		CURSOR FOR SELECT DISTINCT 
					COD_VENDEDOR, 
					COD_VENDE_PADRE,
					NUM_NIVEL
			FROM (SELECT COD_TIPORED,
				 		 NUM_NIVEL,
						 COD_VENDEDOR,
						 DECODE(COD_PADRE,0,NULL,COD_VENDE_PADRE) COD_VENDE_PADRE
				  FROM (SELECT COD_TIPORED, 
				   	   		   NUM_NIVEL, 
				   			   COD_VENDEDOR, 
				   			   COD_VENDEDOR - COD_VENDE_PADRE COD_PADRE,
				   			   COD_VENDE_PADRE
					    FROM VE_REDVENTAS_TD
						WHERE (SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA) 
						   OR (FEC_HASTA IS NULL)
					   )
				)
			WHERE COD_TIPORED = :ihCodTipoRed
			START WITH COD_VENDEDOR  = :lhCodPadre
			CONNECT BY PRIOR COD_VENDEDOR = COD_VENDE_PADRE
			ORDER BY NUM_NIVEL,COD_VENDEDOR; */ 

		
	/* EXEC SQL OPEN CUR_RedDeVentas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0048;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1744;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodPadre;
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


	lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)                                            
    {
	    /* EXEC SQL for :lMaxFetch FETCH CUR_RedDeVentas INTO
	    	:lhCodVendedor, :lhCodVendePadre, :ihNumNivel; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )1767;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)lhCodVendedor;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )sizeof(long);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)lhCodVendePadre;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )sizeof(long);
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)ihNumNivel;
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
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
	        paux = (stRedVentas *) malloc(sizeof(stRedVentas));

			paux->iCodTipoRed       = ihCodTipoRed;
			paux->lCodVendedor		= lhCodVendedor[i];
			paux->lCodVendePadre	= lhCodVendePadre[i];
			paux->iNumNivel			= ihNumNivel[i];
	        paux->sgte 				= qaux;
	        qaux 					= paux;
	        iCuentaRegs++;
        }
    }
    /* EXEC SQL CLOSE CUR_RedDeVentas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1794;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de Ingtegrantes Red de Ventas TipoRed:[%d] VendedorPadre:[%d]=>[%d]\n",ihCodTipoRed, lhCodPadre,iCuentaRegs);
    return qaux; 
}
/*---------------------------------------------------------------------------*/
/* Libera la lista de Red de Ventas                                          */
/*---------------------------------------------------------------------------*/
void vLiberaRedVentas(stRedVentas * paux)
{
	if (paux != NULL)
	{
		vLiberaRedVentas(paux->sgte);
		free (paux);
	}
}
/*---------------------------------------------------------------------------*/
/*   Calcula el dasface de un periodo mensual, dado un periodo inicial       */
/*---------------------------------------------------------------------------*/
long lNewCiclComis(long plCodCiclComis, int piNumSalto)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhCodCiclComis;
	    long    lhNewCodCiclComis;
	    int     ihNumPeriodos;
	/* EXEC SQL END DECLARE SECTION; */ 

        
	lhCodCiclComis = plCodCiclComis;
	ihNumPeriodos  = piNumSalto;

	/* EXEC SQL SELECT 
		TO_CHAR(ADD_MONTHS(TO_DATE(:lhCodCiclComis,'YYYYMMDD'), :piNumSalto), 'YYYYMMDD')
	INTO :lhNewCodCiclComis
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(ADD_MONTHS(TO_DATE(:b0,'YYYYMMDD'),:b1),'YYYY\
MMDD') into :b2  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1809;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclComis;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&piNumSalto;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNewCodCiclComis;
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


	return(lhNewCodCiclComis);
}
/*---------------------------------------------------------------------------*/
/*   Determina el Id_CiclComis Mensual dado un CodCiclComis                  */
/*---------------------------------------------------------------------------*/
char * szNewCiclComis(long plCodCiclComis)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhCodCiclComis;
	    char    szhNewIdCiclComis[11];
	/* EXEC SQL END DECLARE SECTION; */ 

        
	lhCodCiclComis = plCodCiclComis;

	/* EXEC SQL SELECT ID_CICLCOMIS
	INTO :szhNewIdCiclComis
	FROM CM_CICLCOMIS_TD
	WHERE COD_CICLCOMIS = :lhCodCiclComis
	AND ((TIP_CICLCOMIS = 'E') OR
		 (TIP_CICLCOMIS = 'P' AND
		  TIP_PERIODO   = 'M' AND
		  NUM_SECUENCIA = 1)); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select ID_CICLCOMIS into :b0  from CM_CICLCOMIS_TD where (CO\
D_CICLCOMIS=:b1 and (TIP_CICLCOMIS='E' or ((TIP_CICLCOMIS='P' and TIP_PERIODO=\
'M') and NUM_SECUENCIA=1)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1836;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNewIdCiclComis;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclComis;
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


	
	return(szhNewIdCiclComis);
}

/*---------------------------------------------------------------------------*/
/* MARCA LA SECUENCIA EN ESTADO DE INICIO.                                   */
/*---------------------------------------------------------------------------*/
int vMarcaSecuencia(int iNumSecuencia, char * szNomCampo, char cEstado, int iCodError, char * szDesError)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihNumSecuencia;
		char	szhNomCampo[30];
		char	szSentenciaSql[500];
		char	chEstado;
		int		ihCodError;
		char	szhDesError[121];
	/* EXEC SQL END DECLARE SECTION; */ 

	ihNumSecuencia 		= iNumSecuencia;
	chEstado 			= cEstado;
	ihCodError			= iCodError;
	strcpy(szhDesError	, szDesError);
	strcpy(szhNomCampo 	, szNomCampo);
	
	sprintf(szSentenciaSql, "UPDATE CM_REGMIGRACION_TD "
							" SET %s = :v1, "
							" COD_ERROR = :v2, "
							" DES_ERROR = :v3 "
							" WHERE NUM_SECUENCIA = :v4 ",
							szhNomCampo);
							
	/* EXEC SQL PREPARE Pre_Exec FROM :szSentenciaSql; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1859;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szSentenciaSql;
 sqlstm.sqhstl[0] = (unsigned long )500;
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


	
	/* EXEC SQL EXECUTE Pre_Exec USING :chEstado, :ihCodError, :szhDesError, :ihNumSecuencia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1878;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&chEstado;
 sqlstm.sqhstl[0] = (unsigned long )1;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodError;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhDesError;
 sqlstm.sqhstl[2] = (unsigned long )121;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihNumSecuencia;
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


	if (sqlca.sqlcode == 0)
	{
		/* EXEC SQL COMMIT; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 15;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1909;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		return TRUE;
	}
	return FALSE;
}
/*---------------------------------------------------------------------------*/
/* MARCA LA SECUENCIA EN ESTADO DE INICIO.                                   */
/*---------------------------------------------------------------------------*/
int vGetEstadoSecuencia(int iNumSecuencia, char * szNomCampo)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihNumSecuencia;
		char	szhNomCampo[30];
		char	szSentenciaSql[500];
		int  	ihEstado;
	/* EXEC SQL END DECLARE SECTION; */ 

	ihNumSecuencia 	= iNumSecuencia;

    strcpy(szhNomCampo, szNomCampo);

	sprintf(szSentenciaSql, "SELECT DECODE(%s, 'N', 0, 'I', 1, 'F', 2,'T', 3, -1) "
 							" FROM CM_REGMIGRACION_TD "
							" WHERE NUM_SECUENCIA = :v2 ",
							szhNomCampo);
							
	/* EXEC SQL PREPARE Pre_Exec FROM :szSentenciaSql; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1924;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szSentenciaSql;
 sqlstm.sqhstl[0] = (unsigned long )500;
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


	/* EXEC SQL DECLARE CUR_ESTADO CURSOR FOR Pre_Exec; */ 

	/* EXEC SQL OPEN CUR_ESTADO USING :ihNumSecuencia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1943;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumSecuencia;
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


	/* EXEC SQL FETCH CUR_ESTADO INTO :ihEstado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1962;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihEstado;
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


	if (sqlca.sqlcode == SQLNOTFOUND)
	{
		return -1;
	}
	return ihEstado;
}

/*---------------------------------------------------------------------------*/
/* ACTUALIZA NOMBRE FISICO EN TABLA CM_ENLACEHIST_TO                         */
/*---------------------------------------------------------------------------*/
void vCierraEnlace(char * szNomLogico, char * szNomFisico, char * szIdPeriodo)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhNomLogico[30];
        char szhNomFisico[30];
		char szhIdPeriodo[11];
	/* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhNomFisico,szNomFisico);
    strcpy(szhNomLogico,szNomLogico);
    strcpy(szhIdPeriodo,szIdPeriodo);
                                           
    /* EXEC SQL UPDATE CM_ENLACEHIST_TO 
         SET NOM_FISICO = :szhNomFisico
       WHERE NOM_LOGICO = :szhNomLogico
       AND   ID_PERIODO = :szhIdPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CM_ENLACEHIST_TO  set NOM_FISICO=:b0 where (NOM_LO\
GICO=:b1 and ID_PERIODO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1981;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNomFisico;
    sqlstm.sqhstl[0] = (unsigned long )30;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNomLogico;
    sqlstm.sqhstl[1] = (unsigned long )30;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
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


                
    if ( sqlca.sqlcode != SQLOK )
    {
       fprintf(stderr, "Error en UPDATE CM_ENLACEHIST_TO en CIERRE : ORACLE-> %d ",sqlca.sqlcode);  
       exit(EXIT_203);                 
    }
}
/*---------------------------------------------------------------------------*/
/* VERIFICA EVENTO EN VIGENCIA DE FECHA                                      */
/*---------------------------------------------------------------------------*/
int bValidaFechaEvento(char * szFec_Desde, char * szFec_Hasta, char * szFec_Evento) 
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhFec_Desde[11];
        char szhFec_Hasta[11];
		char szhFec_Evento[11];
		int	 ihDif_Desde;
		int	 ihDif_Hasta;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szFec_Desde	,	szhFec_Desde);	
	strcpy(szFec_Hasta	,	szhFec_Hasta);
	strcpy(szhFec_Evento,	szhFec_Evento);
	
	/* EXEC SQL SELECT
			TO_DATE(:szhFec_Evento	, 'DD-MM-YYYY') - TO_DATE(:szFec_Desde	, 'DD-MM-YYYY'),
       		TO_DATE(:szFec_Hasta	, 'DD-MM-YYYY') - TO_DATE(:szhFec_Evento, 'DD-MM-YYYY')
       		INTO
       		:ihDif_Desde,
			:ihDif_Hasta
       		FROM dual; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select (TO_DATE(:b0,'DD-MM-YYYY')-TO_DATE(:b1,'DD-MM-YYYY'))\
 ,(TO_DATE(:b2,'DD-MM-YYYY')-TO_DATE(:b0,'DD-MM-YYYY')) into :b4,:b5  from dua\
l ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2008;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFec_Evento;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szFec_Desde;
 sqlstm.sqhstl[1] = (unsigned long )0;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szFec_Hasta;
 sqlstm.sqhstl[2] = (unsigned long )0;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFec_Evento;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihDif_Desde;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihDif_Hasta;
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


    
    if ((ihDif_Desde >= 0) && (ihDif_Hasta >= 0))
   			return (TRUE);
    
    return(FALSE);
}
/*---------------------------------------------------------------------------*/
/* OBTIENE CODIGO DE PADRE DE VENDEDOR                                       */
/*---------------------------------------------------------------------------*/
long lObtieneVendedorPadre(long  plCodVendedor, int piCodTipoRed, char * pszCodTipComis) 
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;
		char	szhCodTipcomis[3];
		int  	ihRegistros;
		long 	lhCodVendedor;
		long 	lhCodVendePadre;
		char 	szhTipComis[3];
		int  	ihNumNivel;
		char	szhCodTipVendedor[3];
	/* EXEC SQL END DECLARE SECTION; */ 

 	
	lhCodVendedor 			= plCodVendedor;
	ihCodTipoRed 			= piCodTipoRed; 
	strcpy(szhCodTipcomis 	, pszCodTipComis);

	while(1) 
	{
		/* EXEC SQL SELECT COUNT(*)
				INTO :ihRegistros  
			FROM 	VE_REDVENTAS_TD A, 
					VE_VENDEDORES B
			WHERE A.COD_TIPORED = :ihCodTipoRed
			AND A.COD_VENDEDOR 	= :lhCodVendedor
			AND A.COD_VENDEDOR 	= B.COD_VENDEDOR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 15;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(*)  into :b0  from VE_REDVENTAS_TD A ,VE_VENDE\
DORES B where ((A.COD_TIPORED=:b1 and A.COD_VENDEDOR=:b2) and A.COD_VENDEDOR=B\
.COD_VENDEDOR)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2047;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihRegistros;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedor;
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



		if (ihRegistros > 0) 
		{
			/* EXEC SQL SELECT 
			  		A.COD_VENDE_PADRE,
			  		B.COD_TIPCOMIS,
			  		A.NUM_NIVEL,
			  		C.COD_TIPCOMIS
			INTO  	:lhCodVendePadre,
		  			:szhTipComis,
		  			:ihNumNivel,
		  			:szhCodTipVendedor
			FROM	VE_REDVENTAS_TD A, 
					VE_VENDEDORES B,
					VE_VENDEDORES C
			WHERE A.COD_TIPORED 	= :ihCodTipoRed
			AND A.COD_VENDEDOR 		= :lhCodVendedor
			AND A.COD_VENDE_PADRE   = B.COD_VENDEDOR
			AND A.COD_VENDEDOR	    = C.COD_VENDEDOR; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 15;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.COD_VENDE_PADRE ,B.COD_TIPCOMIS ,A.NUM_NIVEL ,C.C\
OD_TIPCOMIS into :b0,:b1,:b2,:b3  from VE_REDVENTAS_TD A ,VE_VENDEDORES B ,VE_\
VENDEDORES C where (((A.COD_TIPORED=:b4 and A.COD_VENDEDOR=:b5) and A.COD_VEND\
E_PADRE=B.COD_VENDEDOR) and A.COD_VENDEDOR=C.COD_VENDEDOR)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2074;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCodVendePadre;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhTipComis;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihNumNivel;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipVendedor;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipoRed;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedor;
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


		
			if (strcmp(szhCodTipcomis , szfnTrim(szhCodTipVendedor))==0)
				return lhCodVendedor;
							
			if (strcmp(szhCodTipcomis , szfnTrim(szhTipComis))==0)
				return lhCodVendePadre;

			if (ihNumNivel = 1) 
				return -1;

			lhCodVendedor = lhCodVendePadre;
		}
		else
			return -1;
	}
}
/*---------------------------------------------------------------------------*/
/* VALIDA SI APLICA GESTOR DE RETENCIONES                                    */
/*---------------------------------------------------------------------------*/
int ifnValidaGestorRetenciones() 
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhNomParametro[21];
		char	szhCodModulo[3];
		int		ihCodProducto;
		char	szhValParam[21];
		int		ihRegistros;
	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy( szhNomParametro, "IND_GR" );
	strcpy( szhCodModulo, "GR" );
	ihCodProducto = 1;

	strcpy( szhValParam, INDNEGACION );

	/* EXEC SQL 
	SELECT COUNT(1)
	  INTO :ihRegistros
	  FROM GED_PARAMETROS
	 WHERE NOM_PARAMETRO = :szhNomParametro
	   AND COD_MODULO = :szhCodModulo
	   AND COD_PRODUCTO = :ihCodProducto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from GED_PARAMETROS where ((NOM_PA\
RAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2113;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihRegistros;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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



	if ( sqlca.sqlcode != SQLOK )
	{
		fprintf(stderr, "Error al Validar Parametro de IND_GR( Gestor Retenciones) : ORACLE-> %d ",sqlca.sqlcode);  
		return FALSE;
	}

	if( ihRegistros )
	{
		/* EXEC SQL 
		SELECT VAL_PARAMETRO
		  INTO :szhValParam
		  FROM GED_PARAMETROS
		 WHERE NOM_PARAMETRO = :szhNomParametro
		   AND COD_MODULO = :szhCodModulo
		   AND COD_PRODUCTO = :ihCodProducto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 15;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where ((\
NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2144;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhValParam;
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



		if ( sqlca.sqlcode != SQLOK )
		{
			fprintf(stderr, "Error al Leer Parametro de IND_GR( Gestor Retenciones) : ORACLE-> %d ",sqlca.sqlcode);  
			return FALSE;
		}
	}
	
	fprintf(stderr, "\nGestor de Retenciones Instalado? [%s].\n", szfnTrim(szhValParam));  

	if(strcmp( szfnTrim(szhValParam), INDAFIRMACION )!=0 )
		return FALSE;
	return TRUE;
}
/*---------------------------------------------------------------------------*/
/* CARGA DETALLE DE ARCHIVOS A GENERAR EN FUNCIÓN DEL UNIVERSO DE DATOS      */
/*---------------------------------------------------------------------------*/
stArchivo * stCargaDefArchivo(char * pszUniverso)
{
	long    	    iCantidad = 0;
	int             i;
	long            iLastRows    = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;
	stArchivo 	    * paux = NULL;
	stArchivo 	    * qaux = NULL;
	stDetArchivo 	* raux = NULL;
	char    		szCodArchivo_Ant[11];
			
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;
		char	szhUniverso[16];
		char 	szhIndAfirmacion	[2];
		char 	szhCodArchivo		[MAXFETCH][11];
		char 	szhNomFisico		[MAXFETCH][21];
		char 	szhCarSeparador		[MAXFETCH][2];
		char 	szhIndEjecucion		[MAXFETCH][2];
		char 	szhNomCampo			[MAXFETCH][31];
		char 	szhNomEtiqueta		[MAXFETCH][31];
		int  	ihNumOrden			[MAXFETCH];
		int  	ihLargoCampo		[MAXFETCH];
		char 	szhIndJustificado	[MAXFETCH][2];
		char 	szhCarRelleno		[MAXFETCH][2];
        char    szhTipoDato			[MAXFETCH][21];
        char	szhFormato			[MAXFETCH][81];
	/* EXEC SQL END DECLARE SECTION; */ 

    
	strcpy(szhUniverso, pszUniverso);
	strcpy(szCodArchivo_Ant, " ");
	strcpy(szhIndAfirmacion,"S");
	lMaxFetch = MAXFETCH;
	
	/* EXEC SQL DECLARE CUR_ARCHIVO CURSOR FOR 
	SELECT
		ARCH.COD_ARCHIVO,
		ARCH.NOM_FISICO ,
		NVL(ARCH.CAR_SEPARADOR,'X'),
		ARCH.IND_EJECUCION ,
		DET.NOM_CAMPO ,
		NVL(DET.NOM_ETIQUETA,DET.NOM_CAMPO),
		DET.NUM_ORDEN ,
		DET.LARGO_CAMPO ,
		DET.IND_JUSTIFICADO ,
		NVL(DET.CAR_RELLENO, ' '),
          	CAM.TIP_DATO     
	FROM 	CM_ARCHIVOS_TD ARCH, 
		CM_DETALLE_ARCHIVO_TD DET , 
		CM_CAMPOS_UNIVERSO_TD CAM
	WHERE ARCH.COD_UNIVERSO = DET.COD_UNIVERSO
          	AND ARCH.COD_UNIVERSO = CAM.COD_UNIVERSO 
          	AND DET.NOM_CAMPO     = CAM.NOM_CAMPO  
		AND ARCH.COD_ARCHIVO  = DET.COD_ARCHIVO
		AND ARCH.COD_UNIVERSO = :szhUniverso 
		AND ARCH.IND_EJECUCION = :szhIndAfirmacion
	ORDER BY ARCH.COD_ARCHIVO, DET.NUM_ORDEN  DESC; */ 
 

	/* EXEC SQL OPEN CUR_ARCHIVO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0059;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2175;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUniverso;
 sqlstm.sqhstl[0] = (unsigned long )16;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhIndAfirmacion;
 sqlstm.sqhstl[1] = (unsigned long )2;
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


        
    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch
		FETCH CUR_ARCHIVO INTO
			:szhCodArchivo,
			:szhNomFisico,
			:szhCarSeparador,
			:szhIndEjecucion,
			:szhNomCampo,
			:szhNomEtiqueta,
			:ihNumOrden,
			:ihLargoCampo,
			:szhIndJustificado,
			:szhCarRelleno,
            :szhTipoDato; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 15;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )2198;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodArchivo;
  sqlstm.sqhstl[0] = (unsigned long )11;
  sqlstm.sqhsts[0] = (         int  )11;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhNomFisico;
  sqlstm.sqhstl[1] = (unsigned long )21;
  sqlstm.sqhsts[1] = (         int  )21;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCarSeparador;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )2;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhIndEjecucion;
  sqlstm.sqhstl[3] = (unsigned long )2;
  sqlstm.sqhsts[3] = (         int  )2;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhNomCampo;
  sqlstm.sqhstl[4] = (unsigned long )31;
  sqlstm.sqhsts[4] = (         int  )31;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhNomEtiqueta;
  sqlstm.sqhstl[5] = (unsigned long )31;
  sqlstm.sqhsts[5] = (         int  )31;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)ihNumOrden;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )sizeof(int);
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)ihLargoCampo;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )sizeof(int);
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhIndJustificado;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )2;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhCarRelleno;
  sqlstm.sqhstl[9] = (unsigned long )2;
  sqlstm.sqhsts[9] = (         int  )2;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhTipoDato;
  sqlstm.sqhstl[10] = (unsigned long )21;
  sqlstm.sqhsts[10] = (         int  )21;
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


                            
		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
		iLastRows = sqlca.sqlerrd[2];
		for (i=0; i < iRetrievRows; i++)
		{            
			if(strcmp(szCodArchivo_Ant, szfnTrim(szhCodArchivo[i]))!=0)
			{
				paux = (stArchivo *) malloc(sizeof(stArchivo)); 
				                
				strcpy(paux->szCodArchivo      	, szfnTrim(szhCodArchivo[i]));
				strcpy(paux->szNomFisico   		, szfnTrim(szhNomFisico[i]));
				strcpy(paux->szCarSeparador  	, szfnTrim(szhCarSeparador[i]));
				strcpy(paux->szIndEjecucion  	, szfnTrim(szhIndEjecucion[i]));				
				paux->sgte_detalle 				= NULL;
				paux->sgte 						= qaux;
				qaux							= paux;
				strcpy(szCodArchivo_Ant         , paux->szCodArchivo);
			}
			raux = (stDetArchivo *) malloc(sizeof(stDetArchivo));		
				
			strcpy(raux->szNomCampo  		, szfnTrim(szhNomCampo[i]));
			strcpy(raux->szNomEtiqueta  	, szfnTrim(szhNomEtiqueta[i]));
			raux->iNumOrden 				= ihNumOrden[i];
			raux->iLargoCampo 				= ihLargoCampo[i];
			strcpy(raux->szIndJustificado	, szfnTrim(szhIndJustificado[i]));
			strcpy(raux->szCarRelleno  		, szfnTrim(szhCarRelleno[i]));
            strcpy(raux->szTipoDato        	, szfnTrim(szhTipoDato[i]));
			strcpy(raux->szFormato			, szRescataFormatoCampo(raux));
			raux->sgte 						= qaux->sgte_detalle;
			qaux->sgte_detalle				= raux;
		}
    }
    /* EXEC SQL close CUR_ARCHIVO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2257;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    return(qaux);
        
}
/*---------------------------------------------------------------------------*/
/* ABRE EL ARCHIVO CON NOMBRE Y PATH INDICADOS                               */
/* iTipoArchivo: 1 => LOG / 2 => DATOS / 3 => LIST(detalle de la ejecución)  */
/*---------------------------------------------------------------------------*/
void bGeneraArchivoExtractores(FILE **pfFile,
                                 char * szFileName,
                                 char * pszEnvArch,
                                 char * szDateLog,
                                 char * szExtension,
                                 char * pszNomArchivo) 
{
	char    szFechaYYYYMMDD[9]="";
    char    szComando[400];
    char    szNomFile[400];
	char    szPath[200];
	
    strcpy(szFechaYYYYMMDD, szfnObtieneFecYYYYMMDD());
	sprintf(szPath,"%s%s/%s",pszEnvArch,szFileName,szFechaYYYYMMDD);
	sprintf(pszNomArchivo,"%s_%s.%s", szFileName, szDateLog, szExtension); 
	
	fprintf(stderr, "\n[bGeneraArchivoExtractores] Datos Cargados para Crear Archivo:" );
	fprintf(stderr, "\n[bGeneraArchivoExtractores] Path                 :[%s]"  , szPath );
	fprintf(stderr, "\n[bGeneraArchivoExtractores] Archivo              :[%s]"  , pszNomArchivo );
    
    sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);
		
    sprintf(szNomFile,"%s/%s" ,szPath, pszNomArchivo);
                                             
    *pfFile = fopen(szNomFile,"w");

	if((*pfFile) == (FILE *)NULL)
	    fprintf(stderr, "\n[bGeneraArchivoExtractores]Error abriendo archivo: [%s]\n" ,szNomFile );
	else
		fprintf(stderr, "\n[bGeneraArchivoExtractores] Archivo Creado       :[%s]\n\n", szNomFile );
}

/*---------------------------------------------------------------------------*/
/* Maneja Trazas de Extractores                                              */
/*---------------------------------------------------------------------------*/
int ifnActualizaTrazasExtractores(int piSecuencia, char * pszProceso, 
                                  int piError, char * pszGlsError, int piAccion)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihNumSecuencia;
		char 	szhCodProceso[16];
		char	szhEstaEjec[2];
		int		ihIndError;
		char	szhGlsError[101];
		int	    bRes;
		int	    ihAccion;
	/* EXEC SQL END DECLARE SECTION; */ 

	ihAccion     = piAccion;

	ihNumSecuencia = piSecuencia;
	strcpy(szhCodProceso, pszProceso);
	strcpy(szhGlsError, pszGlsError);
	ihIndError = piError;
	ihAccion   = piAccion;

	/* EXEC SQL SELECT 
		CM_EXTRACTORES_PG.CM_ActTrazExtractores_FN(:ihNumSecuencia, :szhCodProceso, :ihIndError,  :szhGlsError, :ihAccion)
	INTO :bRes
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select CM_EXTRACTORES_PG.CM_ActTrazExtractores_FN(:b0,:b1,:b\
2,:b3,:b4) into :b5  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2272;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumSecuencia;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodProceso;
 sqlstm.sqhstl[1] = (unsigned long )16;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihIndError;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhGlsError;
 sqlstm.sqhstl[3] = (unsigned long )101;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihAccion;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&bRes;
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


	if (sqlca.sqlcode != SQLOK)
	{
		fprintf(stderr, "\n[ifnActualizaTrazasExtractores] Error en Package:[%s]", sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	if (bRes == 0)
		return TRUE;
	return FALSE;
}
/*---------------------------------------------------------------------------*/
/* Actualiza Información de Archivos Procesados                              */
/*---------------------------------------------------------------------------*/
int ifnActualizaTrazasArchivos(char * pszArchivo, char * pszUniverso,
                               int piSecuencia, char * pszUbicacion, 
                               int piNumReg, char * pszNomUsuario)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihSeqProceso;
		char 	szhCodUniverso[7];
		char 	szhCodArchivo[11];
		char 	szhUbicacion[101];
		int		ihNumReg;
		char	szhNomUsuario[31];
		int	    bRes;
	/* EXEC SQL END DECLARE SECTION; */ 



	ihSeqProceso = piSecuencia;
	ihNumReg     = piNumReg;
	strcpy(szhCodUniverso , pszUniverso);
	strcpy(szhCodArchivo  , pszArchivo);
	strcpy(szhUbicacion   , pszUbicacion);
	strcpy(szhNomUsuario  , pszNomUsuario);


	/* EXEC SQL SELECT 
		CM_EXTRACTORES_PG.CM_ActTrazArchivos_FN(:szhCodArchivo, :szhCodUniverso, :ihSeqProceso, :szhUbicacion, :ihNumReg, :szhNomUsuario )
	INTO :bRes
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select CM_EXTRACTORES_PG.CM_ActTrazArchivos_FN(:b0,:b1,:b2,:\
b3,:b4,:b5) into :b6  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2311;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodArchivo;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodUniverso;
 sqlstm.sqhstl[1] = (unsigned long )7;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihSeqProceso;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhUbicacion;
 sqlstm.sqhstl[3] = (unsigned long )101;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihNumReg;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhNomUsuario;
 sqlstm.sqhstl[5] = (unsigned long )31;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&bRes;
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



	if (bRes == 0)
		return TRUE;
	return FALSE;
}
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
void vMuestraDetArchivo(stDetArchivo * paux)
{
	if (paux == NULL)
		return;

	fprintf(stderr, "\n\t Nombre del Campo     : %s", paux->szNomCampo);
	fprintf(stderr, "\n\t Etiqueta del Campo   : %s", paux->szNomEtiqueta);
	fprintf(stderr, "\n\t Orden del Campo      : %d", paux->iNumOrden);
	fprintf(stderr, "\n\t Largo del Campo      : %d", paux->iLargoCampo);
	fprintf(stderr, "\n\t Justificacion        : %s", paux->szIndJustificado);
	fprintf(stderr, "\n\t Caracter de Relleno  : %s", paux->szCarRelleno);
	fprintf(stderr, "\n\t Tipo de Dato         : %s", paux->szTipoDato);
	fprintf(stderr, "\n\t Formato Impresion    : [%s]", paux->szFormato);
	
	fprintf(stderr, "\n\t ----------------------------------------------");
	vMuestraDetArchivo(paux->sgte);
}
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
void vMuestraArchivo(stArchivo * paux)
{
	if (paux == NULL)
		return;
	fprintf(stderr, "\n\n Código de Archivo : %s", paux->szCodArchivo);
	fprintf(stderr, "\n Nombre Físico     : %s", paux->szNomFisico);
	fprintf(stderr, "\n Caracter Separador: %s", paux->szCarSeparador);
	fprintf(stderr, "\n\t Detalle de Campos: %s");
	fprintf(stderr, "\n\t ==============================================");
	vMuestraDetArchivo(paux->sgte_detalle);
	vMuestraArchivo(paux->sgte);
}
/*---------------------------------------------------------------------------*/
/* Rutina que construye el string de formateo de los campos a listar         */
/*---------------------------------------------------------------------------*/
char *szRescataFormatoCampo(stDetArchivo  *paux_det_archivo)
{    
    char   szCodCampo[31];
    int    iLargoCampo = paux_det_archivo->iLargoCampo;
    char   szIndJustificado[2];
    char   szCarRelleno[2];  
    char   szFormato[81];
    char   pszTipoDato[15];

    if (iLargoCampo == 0) iLargoCampo=8; /* para fechas, por si no vienen con largo */
    
    strcpy(szCodCampo      , paux_det_archivo->szNomCampo);
    strcpy(pszTipoDato     , paux_det_archivo->szTipoDato);
    strcpy(szIndJustificado, paux_det_archivo->szIndJustificado);
    strcpy(szCarRelleno    , paux_det_archivo->szCarRelleno);

	/*fprintf(stderr, "[szRescataFormatoCampo] szCodCampo:[%s] pszTipoDato:[%s] szIndJustificado:[%s] szCarRelleno:[%s]", szCodCampo, pszTipoDato, szIndJustificado, szCarRelleno); */
	if ( pszTipoDato[0] == 'N')
	{ 
    	if(strcmp(szfnTrim(szIndJustificado),"I")==0)
    	{
        	if (szCarRelleno[0] != NULL)         
                sprintf(szFormato,"%%-%c%dd",szCarRelleno[0], iLargoCampo);
            else  
                sprintf(szFormato,"%%-%dd", iLargoCampo);
       }
       else 
       { 
              if (szCarRelleno[0] != NULL)         
                 sprintf(szFormato, "%%%c%dd",szCarRelleno[0], iLargoCampo);
              else
                sprintf(szFormato,"%%%dd", iLargoCampo);
       }
	} 
	else
	{
		if (strncmp( "BLANCO" ,szfnTrim(szCodCampo),6 ) == 0)
	   		sprintf(szFormato,"%%%c%d.%ds",CARACBLANCO[0], iLargoCampo,iLargoCampo);
		else
		{
	    	if(strcmp(szfnTrim(szIndJustificado),"I")==0)
	    	{
	        	if (szCarRelleno[0] != NULL)  
	                  sprintf(szFormato,"%%-%c%d.%ds",szCarRelleno[0], iLargoCampo,iLargoCampo);
	              else
	                  sprintf(szFormato,"%%-%d.%ds", iLargoCampo,iLargoCampo);
	       	}
	       	else  
	       	{  
	       		if (szCarRelleno[0] != NULL)  
	                sprintf(szFormato,"%%%c%d.%ds",szCarRelleno[0], iLargoCampo,iLargoCampo);
	        	else
	                sprintf(szFormato,"%%%d.%ds", iLargoCampo,iLargoCampo);
			}
		}
	}
	/*fprintf(stderr, "\tszFormato:[%s]\n", szFormato); */
	return (szFormato);
}
/*---------------------------------------------------------------------------*/
/* Rutina para recuperar fechas que definen Ciclo a procesar.                */
/*---------------------------------------------------------------------------*/
int ifnCargaDireccion(long plCodCliente, int piTipDireccion, rg_direccion * stMiDireccion)
{
    int		bRet = FALSE; 
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhCodCliente;
		int		ihTipDireccion;
		char	szhCodProvincia[6];
		char	szhDesProvincia[31];
		char	szhCodRegion[4];
		char	szhDesRegion[31];
		char	szhCodCiudad[6];
		char	szhDesCiudad[31];
		char	szhCodFranquicia[6];
		char	szhDesFranquicia[31];
		char	szhDireccion[801];
		
		int	ihTipSujeto;
		int	ihCodTipDireccion;
		int	ihCodDisplay;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhCodCliente 	= plCodCliente;
	ihTipDireccion 	= piTipDireccion;        
	ihTipSujeto 		= 1;
	ihCodTipDireccion 	= 1;
	ihCodDisplay 		= 1;
	
	/* EXEC SQL SELECT 
			   GE_FN_OBTIENE_DIRCLIE(:lhCodCliente, :ihTipSujeto, :ihCodTipDireccion, :ihCodDisplay) Direccion,
			   B.COD_PROVINCIA		cod_provincia,
			   C.DES_PROVINCIA		des_provincia,
			   B.COD_REGION			cod_region, 
			   D.DES_REGION			des_region,
			   B.COD_COMUNA			cod_ciudad,
			   E.DES_COMUNA			des_ciudad,
			   B.COD_CIUDAD			cod_franquicia,
			   F.DES_CIUDAD			des_franquicia
		INTO	:szhDireccion,
			 :szhCodProvincia,
			 :szhDesProvincia,
			 :szhCodRegion,
			 :szhDesRegion,
			 :szhCodCiudad,
			 :szhDesCiudad,
			 :szhCodFranquicia,
			 :szhDesFranquicia
		FROM GA_DIRECCLI A,
		     GE_DIRECCIONES B,
			 GE_PROVINCIAS  C,
			 GE_REGIONES    D,
			 GE_COMUNAS     E,
			 GE_CIUDADES    F
		WHERE A.COD_CLIENTE = :lhCodCliente
		AND   A.COD_TIPDIRECCION = :ihCodTipDireccion
		AND   A.COD_DIRECCION = B.COD_DIRECCION
		AND   B.COD_REGION    = D.COD_REGION
		AND   B.COD_PROVINCIA = C.COD_PROVINCIA
		AND   B.COD_REGION    = C.COD_REGION
		AND   B.COD_REGION    = E.COD_REGION
		AND   B.COD_PROVINCIA = E.COD_PROVINCIA
		AND   B.COD_COMUNA    = E.COD_COMUNA
		AND	  B.COD_REGION    = F.COD_REGION
		AND   B.COD_PROVINCIA = F.COD_PROVINCIA
		AND   B.COD_CIUDAD    = F.COD_CIUDAD; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GE_FN_OBTIENE_DIRCLIE(:b0,:b1,:b2,:b3) Direccion ,B.C\
OD_PROVINCIA cod_provincia ,C.DES_PROVINCIA des_provincia ,B.COD_REGION cod_re\
gion ,D.DES_REGION des_region ,B.COD_COMUNA cod_ciudad ,E.DES_COMUNA des_ciuda\
d ,B.COD_CIUDAD cod_franquicia ,F.DES_CIUDAD des_franquicia into :b4,:b5,:b6,:\
b7,:b8,:b9,:b10,:b11,:b12  from GA_DIRECCLI A ,GE_DIRECCIONES B ,GE_PROVINCIAS\
 C ,GE_REGIONES D ,GE_COMUNAS E ,GE_CIUDADES F where (((((((((((A.COD_CLIENTE=\
:b0 and A.COD_TIPDIRECCION=:b2) and A.COD_DIRECCION=B.COD_DIRECCION) and B.COD\
_REGION=D.COD_REGION) and B.COD_PROVINCIA=C.COD_PROVINCIA) and B.COD_REGION=C.\
COD_REGION) and B.COD_REGION=E.COD_REGION) and B.COD_PROVINCIA=E.COD_PROVINCIA\
) and B.COD_COMUNA=E.COD_COMUNA) and B.COD_REGION=F.COD_REGION) and B.COD_PROV\
INCIA=F.COD_PROVINCIA) and B.COD_CIUDAD=F.COD_CIUDAD)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2354;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihTipSujeto;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDireccion;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodDisplay;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhDireccion;
 sqlstm.sqhstl[4] = (unsigned long )801;
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
 sqlstm.sqhstv[6] = (unsigned char  *)szhDesProvincia;
 sqlstm.sqhstl[6] = (unsigned long )31;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCodRegion;
 sqlstm.sqhstl[7] = (unsigned long )4;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhDesRegion;
 sqlstm.sqhstl[8] = (unsigned long )31;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhCodCiudad;
 sqlstm.sqhstl[9] = (unsigned long )6;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhDesCiudad;
 sqlstm.sqhstl[10] = (unsigned long )31;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhCodFranquicia;
 sqlstm.sqhstl[11] = (unsigned long )6;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhDesFranquicia;
 sqlstm.sqhstl[12] = (unsigned long )31;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&ihCodTipDireccion;
 sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
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

		

    if (sqlca.sqlcode==0)
    {
    	bRet = TRUE;
    	
    	strcpy(stMiDireccion->szDireccion      	  , szfnTrim(szhDireccion));
    	strcpy(stMiDireccion->szCodProvincia      , szfnTrim(szhCodProvincia));
    	strcpy(stMiDireccion->szDesProvincia      , szfnTrim(szhDesProvincia));
    	strcpy(stMiDireccion->szCodRegion         , szfnTrim(szhCodRegion));
    	strcpy(stMiDireccion->szDesRegion         , szfnTrim(szhDesRegion));
    	strcpy(stMiDireccion->szCodCiudad         , szfnTrim(szhCodCiudad));
    	strcpy(stMiDireccion->szDesCiudad         , szfnTrim(szhDesCiudad));
    	strcpy(stMiDireccion->szCodFranquicia     , szfnTrim(szhCodFranquicia));
    	strcpy(stMiDireccion->szDesFranquicia     , szfnTrim(szhDesFranquicia));
    	
    }
	return bRet;
}
/*****************************************************************************/
/*****************************************************************************/
char *szFormatEtiqueta(stDetArchivo  *paux_det_archivo)
{
    char   *szResp;
    int    iLargoCampo = paux_det_archivo->iLargoCampo;
    char   szFormato[81];

    if (iLargoCampo == 0) iLargoCampo=8; /* para fechas, por si no vienen con largo */
    szResp = (char *) malloc(sizeof(iLargoCampo +1));
    if (!szResp) 
       fprintf(stderr, "[szFormatEtiqueta] No se pudo asignar memoria a szResp        [%s]\n",paux_det_archivo->szNomCampo);
    memset(szResp,0,(iLargoCampo ));

	sprintf(szFormato,"%%-%c%d.%ds",CARACBLANCO[0], paux_det_archivo->iLargoCampo,paux_det_archivo->iLargoCampo);
    sprintf(szResp,szFormato, paux_det_archivo->szNomEtiqueta);
	return (szResp);
}

/*---------------------------------------------------------------------------*/
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
