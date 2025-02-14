
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
    "./pc/excluidor.pc"
};


static unsigned int sqlctx = 6912091;


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
   unsigned char  *sqhstv[31];
   unsigned long  sqhstl[31];
            int   sqhsts[31];
            short *sqindv[31];
            int   sqinds[31];
   unsigned long  sqharm[31];
   unsigned long  *sqharc[31];
   unsigned short  sqadto[31];
   unsigned short  sqtdso[31];
} sqlstm = {12,31};

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
"select COD_PTOGEST ,NUM_DIAS ,ANT_PTOGEST ,COD_ESTADO ,COD_GESTION ,COD_CATE\
GORIA ,NVL(IND_PRORROGA,:b0) ,NUM_PROCESO  from CO_PTOSGESTION where COD_ESTAD\
O=:b1 order by NUM_DIAS            ";

 static const char *sq0002 = 
"select unique :b0 ,CVRP.COD_PTOGEST ,CVRP.COD_CATEGORIA ,CVRP.NUM_DIAS ,CVRP\
.COD_RUTINA ,CVRR.TIP_RETORNO ,CVRP.VAL_RETORNO ,NVL(CVRP.VAL_RANGO,:b1) ,CVRP\
.IND_EXCLUYE ,CVRP.DIA_PRORROGA ,:b2  from CO_VALRETRUT CVRR ,CO_VALRETPTO CVR\
P where CVRR.COD_RUTINA=CVRP.COD_RUTINA order by CVRP.NUM_DIAS,CVRP.COD_PTOGES\
T,CVRP.COD_CATEGORIA            ";

 static const char *sq0004 = 
"select VAL_PARAMETRO ,DES_PARAMETRO  from GED_PARAMETROS where (NOM_PARAMETR\
O like :b0 and COD_MODULO=:b1)           ";

 static const char *sq0017 = 
") and A.NUM_POSTULACION=C.NUM_POSTULACION) and B.COD_CLIENTE=D.COD_CLIENTE) \
and C.NUM_POSTULACION>0) union all select unique M.COD_CLIENTE ,M.NUM_IDENT ,M\
.COD_TIPIDENT ,:b21 ,:b0 ,:b1  from CO_MOROSOS M ,CO_PAGOS P where ((((M.COD_C\
LIENTE=P.COD_CLIENTE and (M.TIP_MOROSO||'') in (:b7,:b8)) and P.FEC_EFECTIVIDA\
D>=TO_DATE(:b26,:b27)) and  not exists (select 1  from CO_CODIGOS C where ((C.\
NOM_TABLA='CO_PAGOS' and C.NOM_COLUMNA='COD_TIPDOCUM') and TO_NUMBER(C.COD_VAL\
OR)=P.COD_TIPDOCUM))) and  not exists (select 1  from CO_DET_DOCUMENTOS D wher\
e D.NUM_SECUENCI_PAGO=P.NUM_SECUENCI)) union all select unique P.COD_CLIENTE ,\
E.NUM_IDENT ,E.COD_TIPIDENT ,:b8 ,:b0 ,:b1  from CO_COBEXTERNA E ,CO_PAGOS P ,\
GE_CLIENTES G where ((((G.COD_CLIENTE=P.COD_CLIENTE and G.NUM_IDENT=E.NUM_IDEN\
T) and G.COD_TIPIDENT=E.COD_TIPIDENT) and P.FEC_EFECTIVIDAD>=TRUNC(SYSDATE)) a\
nd P.COD_CLIENTE not  in (select COD_CLIENTE  from CO_MOROSOS M where M.COD_CL\
IENTE=P.COD_CLIENTE))           ";

 static const char *sq0061 = 
"select ROWID ,CA.COD_RUTINA ,TO_CHAR(CA.FEC_EJECPROG,:b0)  from CO_ACCIONES \
CA where ((CA.COD_CLIENTE=:b1 and CA.NUM_SECUENCIA>:b2) and CA.NUM_SECUENCIA i\
n (select A.NUM_SECUENCIA  from CO_RUTINAS R ,CO_ACCIONES A where (((((A.COD_C\
LIENTE=:b1 and A.NUM_SECUENCIA>:b2) and A.COD_ESTADO=:b5) and R.COD_RUTINA=A.C\
OD_RUTINA) and R.TIP_RUTINA=:b6) and R.COD_RUTINA not  in (select P.COD_RUTINA\
  from CO_PTOSRUTINAS P where ((P.COD_CATEGORIA=:b7 and P.NUM_DIAS<=:b8) and P\
.COD_RUTINA=R.COD_RUTINA)))))           ";

 static const char *sq0070 = 
"select distinct A.NUM_SECUENCIA ,R.REV_RUTINA ,NVL(R.ORD_APLICACION,:b0)  fr\
om CO_RUTINAS R ,CO_ACCIONES A where (((((A.COD_CLIENTE=:b1 and A.COD_ESTADO i\
n (:b2,:b3)) and R.COD_RUTINA=A.COD_RUTINA) and R.TIP_RUTINA=:b4) and R.REV_RU\
TINA is  not null ) and R.COD_RUTINA in (select P.COD_RUTINA  from CO_PTOSRUTI\
NAS P where (P.COD_CATEGORIA=:b5 and P.NUM_DIAS<=:b6))) order by NVL(R.ORD_APL\
ICACION,:b0),R.REV_RUTINA            ";

 static const char *sq0071 = 
"select distinct A.NUM_SECUENCIA ,R.REV_RUTINA ,NVL(R.ORD_APLICACION,:b0)  fr\
om CO_RUTINAS R ,CO_ACCIONES A where (((((A.COD_CLIENTE=:b1 and A.COD_ESTADO i\
n (:b2,:b3)) and R.COD_RUTINA=A.COD_RUTINA) and R.TIP_RUTINA=:b4) and R.REV_RU\
TINA is  not null ) and R.COD_RUTINA in (select P.COD_RUTINA  from CO_PTOSRUTI\
NAS P where (P.COD_CATEGORIA=:b5 and P.NUM_DIAS>:b6))) order by NVL(R.ORD_APLI\
CACION,:b0),R.REV_RUTINA            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,189,0,9,270,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
28,0,0,1,0,0,13,277,0,0,8,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,3,0,0,
75,0,0,1,0,0,15,287,0,0,0,0,0,1,0,
90,0,0,2,342,0,9,364,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,
117,0,0,2,0,0,13,371,0,0,11,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
176,0,0,2,0,0,15,379,0,0,0,0,0,1,0,
191,0,0,3,191,0,4,714,0,0,10,9,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,2,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
246,0,0,4,117,0,9,759,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
269,0,0,4,0,0,13,769,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
292,0,0,4,0,0,15,793,0,0,0,0,0,1,0,
307,0,0,5,73,0,4,821,0,0,3,2,0,1,0,1,97,0,0,2,97,0,0,1,97,0,0,
334,0,0,6,62,0,6,890,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
357,0,0,7,110,0,4,901,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
380,0,0,0,0,0,58,966,0,0,1,1,0,1,0,3,109,0,0,
399,0,0,8,0,0,27,968,0,0,4,4,0,1,0,1,97,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
430,0,0,9,152,0,4,1018,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,3,0,0,
461,0,0,10,171,0,5,1041,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
492,0,0,11,0,0,29,1054,0,0,0,0,0,1,0,
507,0,0,12,67,0,4,1185,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
530,0,0,13,61,0,5,1206,0,0,2,2,0,1,0,1,97,0,0,1,5,0,0,
553,0,0,14,0,0,29,1217,0,0,0,0,0,1,0,
568,0,0,15,71,0,4,1414,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
591,0,0,16,60,0,4,1427,0,0,4,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,2,97,0,0,
622,0,0,17,1990,0,9,1510,0,0,31,31,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,
3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
761,0,0,17,0,0,13,1523,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,
0,2,3,0,0,
800,0,0,17,0,0,15,1555,0,0,0,0,0,1,0,
815,0,0,18,94,0,4,1568,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,97,0,0,
842,0,0,19,95,0,4,1751,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,
869,0,0,20,183,0,4,1820,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,
904,0,0,21,107,0,5,1864,0,0,7,7,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,5,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,
947,0,0,22,0,0,31,1872,0,0,0,0,0,1,0,
962,0,0,23,0,0,29,1907,0,0,0,0,0,1,0,
977,0,0,24,107,0,5,1914,0,0,7,7,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,5,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,
1020,0,0,25,0,0,29,1922,0,0,0,0,0,1,0,
1035,0,0,26,294,0,4,1937,0,0,7,5,0,1,0,1,3,0,0,1,3,0,0,2,3,0,0,2,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
1078,0,0,27,0,0,31,1955,0,0,0,0,0,1,0,
1093,0,0,28,152,0,4,1964,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,3,0,0,
1120,0,0,29,0,0,31,1975,0,0,0,0,0,1,0,
1135,0,0,30,225,0,5,2011,0,0,16,16,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,
3,0,0,1,97,0,0,1,5,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,5,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,
1214,0,0,31,0,0,31,2029,0,0,0,0,0,1,0,
1229,0,0,32,0,0,31,2038,0,0,0,0,0,1,0,
1244,0,0,33,238,0,4,2059,0,0,14,13,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,
1315,0,0,34,243,0,5,2079,0,0,14,14,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,
1386,0,0,35,258,0,4,2096,0,0,6,5,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,3,0,0,
1425,0,0,36,151,0,5,2117,0,0,5,5,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,
1460,0,0,37,0,0,29,2133,0,0,0,0,0,1,0,
1475,0,0,38,0,0,31,2141,0,0,0,0,0,1,0,
1490,0,0,39,0,0,31,2231,0,0,0,0,0,1,0,
1505,0,0,40,0,0,31,2242,0,0,0,0,0,1,0,
1520,0,0,41,0,0,31,2258,0,0,0,0,0,1,0,
1535,0,0,42,185,0,4,2299,0,0,5,4,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,
1570,0,0,43,0,0,29,2356,0,0,0,0,0,1,0,
1585,0,0,44,50,0,4,2373,0,0,1,0,0,1,0,2,3,0,0,
1604,0,0,45,327,0,3,2385,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,
1647,0,0,46,0,0,29,2403,0,0,0,0,0,1,0,
1662,0,0,47,0,0,31,2409,0,0,0,0,0,1,0,
1677,0,0,48,50,0,4,2426,0,0,1,0,0,1,0,2,3,0,0,
1696,0,0,49,72,0,3,2441,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
1719,0,0,50,327,0,3,2459,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,
1762,0,0,51,0,0,29,2477,0,0,0,0,0,1,0,
1777,0,0,52,0,0,31,2485,0,0,0,0,0,1,0,
1792,0,0,53,50,0,4,2501,0,0,1,0,0,1,0,2,3,0,0,
1811,0,0,54,72,0,3,2515,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
1834,0,0,55,327,0,3,2532,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,
1877,0,0,56,64,0,3,2553,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
1900,0,0,57,59,0,5,2558,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
1923,0,0,58,0,0,29,2571,0,0,0,0,0,1,0,
1938,0,0,59,0,0,31,2580,0,0,0,0,0,1,0,
1953,0,0,60,155,0,4,2670,0,0,6,5,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,
1992,0,0,61,506,0,9,2813,0,0,9,9,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2043,0,0,61,0,0,13,2821,0,0,3,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,
2070,0,0,61,0,0,15,2833,0,0,0,0,0,1,0,
2085,0,0,62,41,0,2,2845,0,0,1,1,0,1,0,1,97,0,0,
2104,0,0,63,148,0,5,2856,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,
2143,0,0,64,77,0,6,3178,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
2166,0,0,65,146,0,4,3191,0,0,7,4,0,1,0,1,5,0,0,1,97,0,0,1,3,0,0,2,3,0,0,2,5,0,
0,2,5,0,0,1,3,0,0,
2209,0,0,66,0,0,31,3205,0,0,0,0,0,1,0,
2224,0,0,67,0,0,31,3217,0,0,0,0,0,1,0,
2239,0,0,68,0,0,31,3239,0,0,0,0,0,1,0,
2254,0,0,69,0,0,29,3245,0,0,0,0,0,1,0,
2269,0,0,70,425,0,9,3338,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,1,3,0,0,
2316,0,0,70,0,0,13,3346,0,0,3,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,
2343,0,0,70,0,0,15,3359,0,0,0,0,0,1,0,
2358,0,0,71,424,0,9,3440,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,1,3,0,0,
2405,0,0,71,0,0,13,3448,0,0,3,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,
2432,0,0,71,0,0,15,3461,0,0,0,0,0,1,0,
2447,0,0,72,257,0,2,3510,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,
2482,0,0,73,0,0,31,3524,0,0,0,0,0,1,0,
2497,0,0,74,0,0,17,3542,0,0,1,1,0,1,0,1,97,0,0,
2516,0,0,75,0,0,31,3548,0,0,0,0,0,1,0,
2531,0,0,76,0,0,31,3562,0,0,0,0,0,1,0,
2546,0,0,74,0,0,45,3574,0,0,0,0,0,1,0,
2561,0,0,77,0,0,31,3580,0,0,0,0,0,1,0,
2576,0,0,74,0,0,13,3586,0,0,3,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,
2603,0,0,78,0,0,31,3594,0,0,0,0,0,1,0,
2618,0,0,74,0,0,15,3600,0,0,0,0,0,1,0,
2633,0,0,79,0,0,31,3606,0,0,0,0,0,1,0,
2648,0,0,80,62,0,6,3658,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
2671,0,0,81,130,0,4,3676,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
2698,0,0,82,152,0,4,3743,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,3,0,0,
2729,0,0,83,62,0,6,3762,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
2752,0,0,84,171,0,5,3773,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
2783,0,0,85,0,0,29,3784,0,0,0,0,0,1,0,
};


/* =================================================================================================
Tipo          :  COLA DE PROCESO
Nombre        :  excluidor.pc
Descripcion   :  Excluye de ejecución de las acciones de cobranza a los clientes
                 que registran pagos en el sistema en el ultimo periodo. Ya sea
                 que se informen estos vias base de datos o via archivo.
Recibe        :  Usuario/Password. ( por defecto asume los de la cuenta )
                 Nivel de Log ( por defecto asume 3 : Log Normal )
                 Nombre de la Cola (Opcional), para nombrar archivos de log
Devuelve      :  Valor entero para indicar el status de termino.
                 Interactua con la Base de Datos y el archivo de Log para registrar
                 como se desarrolla su ejecucion.
Autor         :  Roy Barrera Richards
Fecha         :  09 - Agosto - 2000

====================================================================================================*/

#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_
#include "excluidor.h"

#include <sched.h>

#define iLOGNIVEL_DEF     3       			/* Define el nivel de Log por Defecto */
#define iTamReg          55       			/* Define el tamaño del registro para el archivo repo_ctc */
#define MAX_ACCIONES     50         		/* Define maximo de acciones PND de un cliente *** CH-1283 *** */

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


LINEACOMANDO  stLineaComando;     			/* Datos con los que se invoco al proceso */
char         szUsuarioConec[20];
char         szPasswConec  [20];

char 	szgCodProceso[6] = "";
int   iSec_Padre  = 0;
long  lTotalRows  = 0, lhContTotal = 0;

PARAMETROS		stParametrosHilos[MAX_INSTANCIAS]; /* PGG 11-11-2004 Instancias de BD */

int  iNumeroHilos  = 0; /* Incorporado por PGonzalez 28-10-2004 MAS-04037 */
int  iSec_Hijo   = 0;
thread_t 	idHilo[25];


int	ihFlgError      = 1;  /* Define cola activa al inicio */
int	iSqlAuxStatus   = 0;
long  lContCliBD      = 0;
char 	szDescError[1024]="";
int	iContador = 0;  /* Incorporado por PGonzalez 25-10-2004 MAS-04037 */

struct stCliente iLB; /* PGG incorporado viernes 22-10-2004 */

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char 			szhgCodProceso[6]; 	/* EXEC SQL VAR szhgCodProceso IS STRING (6); */ 
 /* codigo de proceso */
	td_PtoGestion  	sthPtosGestion;		/* host array para los Puntos de Gestion, declarado en CO_stPtoRut.h */
	td_PtoRutina   	sthPtoCriterio;    	/* host array para los criterios, declarado en CO_stPtoRut.h */
	td_Cliente_Exclu	sthClienteExclu;   	/* host array para los clientes 		 */
	td_Accion_Inversa sthAccionInversa;  	/* host array para las acciones inversas */
	td_Parametros		stParametros;

	long	lhaNumSecuenciaAnt [MAX_REV];
   char	szhaCodRutinaAnt   [MAX_REV] [6];
   int	ihaOrdAplicaAnt    [MAX_REV];
	long	lhaNumSecuenciaPos [MAX_REV];
   char	szhaCodRutinaPos   [MAX_REV] [6];
   int	ihaOrdAplicaPos    [MAX_REV];
	char  szhProceso    [6];
	long  lhCpu            ;
	char  szhUser_Cobros[15]; /* EXEC SQL VAR szhUser_Cobros IS STRING(15); */ 

	int   iTot_Clies         [MAX_REV];

	/* Variables Bind */
	char szhCod_Modulo  [3];
	char szhEstadoEJE   [4];
	char szhEstadoRER   [4];
	char szhPND	    [4];
	char szhERR         [4];
	char szhLetra_N     [2];
	char szhLetra_R     [2];
	char szhLetra_E     [2];
	char szhLetra_A     [2];
	char szhLetra_C     [2];
	char szhLetra_M     [2];
	char szhYYYYMMDD    [9];
   char szhHH24MISS   [11];

	int  ihValor_cero  = 0;
	int  ihValor_uno   = 1;
	int  ihValor_24    = 24;
	int  ihIndProcedencia = 1; /* Incorporado por PGonzalez 25-10-2004 MAS-04037 */

	int   ihNUM_INSTAN ;
   int   ihRAN_LISTAS ;
	char  szhVigente[2];
	sql_context CtxInsBas[11];

/* EXEC SQL END DECLARE SECTION; */ 


FILE *fpFile;
char	szArchivoLog[256] = "";				/* log */
int	iTotPtosGestion   = 0;
int   iTotPtosCriterio  = 0;
long 	lAuxSeqGlobal     = 0;        		/* variable de ambito global ( Auxiliar Secuencia ) */
long  lAccionReversa    = 0;
int	  iRetExclu = 0;	       /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
int iEncuentraPto;             /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

typedef struct REG_ACCIONES
{
   char szhRowid    [MAX_ACCIONES][19];
   char szhCodRutina[MAX_ACCIONES][6];
   char szhFecha    [MAX_ACCIONES][9];
}arr_acciones;

/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
char modulo[]="ifnValidaParametros";

/* ------------------------------------------------------------------------- */
/* Definicion de variables para controlar la lista de argumentos recibidos   */
/* ------------------------------------------------------------------------- */
extern char  *optarg;
extern  int  opterr, optopt;
int  iOpt=0;
char opt[] = ":u:l:n:";
/* Variables locales 														 */
char  *psztmp = "";
/* Flags de los valores recibidos 											 */
int  Userflag = 0;
int  Logflag  = 0;

	/* ------------------------------------------------------------------------- */
	/* Seteo de Valores Iniciles y por defecto 									 */
	/* ------------------------------------------------------------------------- */
    opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;

    memset(szgCodProceso,0,sizeof(szgCodProceso));
    strcpy(szgCodProceso,"EXCLU"); /*valor por defecto es "EXCLU" por EXCLUIDOR */
    strcpy(szhProceso,szgCodProceso);

	/* ------------------------------------------------------------------------- */
	/* En caso de Invocacion sin Parametros 									 */
	/* ------------------------------------------------------------------------- */
    if(argc == 1)
    {
        return 0; /*ok asume valores por defecto */
    }

	/* ------------------------------------------------------------------------- */
	/* Analisis de los argumentos recibidos 									 */
	/* ------------------------------------------------------------------------- */
    while ((iOpt=getopt(argc, argv, opt))!=EOF)
    {
        switch(iOpt)
        {
            case 'u':  /*-- Usuario/Password --*/
                 if(!Userflag)
                {
                    strcpy(pstLC->szUsuarioOra, optarg);
                    Userflag=1;
                    if ((psztmp=(char *)strchr(pstLC->szUsuarioOra,'/'))==(char *)NULL)
                    {
                        fprintf (stderr,"\n\tError >> Usuario no valido. Requiere '/' \n");
                        fflush  (stderr);
                        return -1;
                    }
                    else
                    {
                        strncpy (pstLC->szOraAccount,pstLC->szUsuarioOra,psztmp-pstLC->szUsuarioOra);
                        strcpy  (pstLC->szOraPasswd, psztmp+1);
                    }
                }
                else
                {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;

            case 'l': /*-- Nivel de Log --*/
                if(!Logflag)
                {
                    stStatus.iLogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=1;
                }
                else
                {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;
            case 'n': /*-- Nombre de la Cola (codigo del proceso) --*/
                strcpy(szhgCodProceso,optarg);
                break;
            case '?':
                fprintf (stderr,"\n\tError >> opcion '-%c' es desconocida\n",optopt);
                fflush  (stderr);
                return -1;

            case ':':
                fprintf (stderr,"\n\tError >> falta argumento para opcion '-%c'\n",optopt);
                fflush  (stderr);
                return -1;
        }
    }
    pstLC->iLogLevel=stStatus.iLogNivel;
    return 0;

} /* bfnValidaParamatros */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB(LINEACOMANDO *pstLC)
{
char modulo[]="ifnConexionDB";

   strcpy(szUsuarioConec,pstLC->szOraAccount);
   strcpy(szPasswConec,pstLC->szOraPasswd);
	if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  )	{
		fprintf (stderr,"\nNo hay conexion a ORACLE \n");
		fflush  (stderr);
		return -1;
	}
	return 0;
}

/*======================================================================================*/
/* Funcion que Carga los puntos de gestion activos													 */
/*======================================================================================*/
int ifnCargaPtosGestion( td_PtoGestion *sthPtoGestion )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_PtoGestion sthPtoGestionLoc;
	char  szhLetra_H  [2];
	char  szhFiller   [2];
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnCargaPtosGestion";
int  iTotalRows = 0, i = 0;

	memset( &sthPtoGestionLoc, 0, sizeof(td_PtoGestion) );
	strcpy(szhLetra_H,"H");
	strcpy(szhFiller," ");

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL DECLARE curPtoGestion CURSOR FOR
	SELECT COD_PTOGEST,
			 NUM_DIAS,
			 ANT_PTOGEST,
			 COD_ESTADO,
			 COD_GESTION,
			 COD_CATEGORIA,
			 NVL( IND_PRORROGA, :szhFiller ),
			 NUM_PROCESO
	FROM	 CO_PTOSGESTION
	WHERE	 COD_ESTADO = :szhLetra_H
	ORDER BY NUM_DIAS; */ 


	if( SQLCODE )	{
		ifnTrazasLog( modulo, "en DECLARE : %s", LOG00, SQLERRM );
		return -1;
	}

	/* EXEC SQL OPEN curPtoGestion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
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
 sqlstm.sqhstv[0] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhLetra_H;
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


	if( SQLCODE ) 	{
		ifnTrazasLog( modulo, "en OPEN : %s", LOG00, SQLERRM );
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL FETCH curPtoGestion
	INTO	:sthPtoGestionLoc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )150;
 sqlstm.offset = (unsigned int  )28;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)sthPtoGestionLoc.szCodPtoGest;
 sqlstm.sqhstl[0] = (unsigned long )6;
 sqlstm.sqhsts[0] = (         int  )6;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)sthPtoGestionLoc.iNumDias;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )sizeof(int);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)sthPtoGestionLoc.szAntPtoGest;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )6;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)sthPtoGestionLoc.szCodEstado;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )2;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)sthPtoGestionLoc.szCodGestion;
 sqlstm.sqhstl[4] = (unsigned long )3;
 sqlstm.sqhsts[4] = (         int  )3;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)sthPtoGestionLoc.szCodCategoria;
 sqlstm.sqhstl[5] = (unsigned long )6;
 sqlstm.sqhsts[5] = (         int  )6;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)sthPtoGestionLoc.szIndProrroga;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )2;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)sthPtoGestionLoc.iNumProceso;
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



	iTotalRows = SQLROWS;
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL CLOSE curPtoGestion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )75;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE )	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}

	for( i = 0; i < iTotalRows; i++ )
	{
		ifnTrazasLog( modulo,	"Datos obtenidos en %s\n"
								"\t\t\tszCodPtoGest   = [%s],\n"
								"\t\t\tiNumDias       = [%d],\n"
								"\t\t\tszAntPtoGest   = [%s],\n"
								"\t\t\tszCodEstado    = [%s],\n"
								"\t\t\tszCodGestion   = [%s],\n"
								"\t\t\tszCodCategoria = [%s],\n"
								"\t\t\tszIndProrroga  = [%s],\n"
								"\t\t\tNumProceso     = [%d],\n",
								LOG08,
								modulo,
								sthPtoGestionLoc.szCodPtoGest[i],
								sthPtoGestionLoc.iNumDias[i],
								sthPtoGestionLoc.szAntPtoGest[i],
								sthPtoGestionLoc.szCodEstado[i],
								sthPtoGestionLoc.szCodGestion[i],
								sthPtoGestionLoc.szCodCategoria[i],
								sthPtoGestionLoc.szIndProrroga[i],
								sthPtoGestionLoc.iNumProceso[i] );
	}

    *sthPtoGestion = sthPtoGestionLoc;
    return iTotalRows;
}  /*FIN ifnCargaPtosGestion() */



/*==================================================================================================*/
/* Funcion que carga todos los criterios en una estructur general	excluidor (de paso)   			    */
/*==================================================================================================*/
int ifnCargaCriteriosPtos( td_PtoRutina *sthPtoGestion )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_PtoRutina sthPtoGestionLoc;
	char  szhNULO    [5];
	char  szhLetra_C [2];
	char  szhLetra_X [2];
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnCargaCriteriosPtos";
int  iTotalRows = 0;

	memset( &sthPtoGestionLoc, 0, sizeof(td_PtoGestion) );
	strcpy(szhNULO,"NULO");
	strcpy(szhLetra_C,"C");
	strcpy(szhLetra_X,"X");

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL DECLARE curCriPtoGestion CURSOR FOR
	SELECT UNIQUE :szhLetra_C,
			 CVRP.COD_PTOGEST,
			 CVRP.COD_CATEGORIA,
			 CVRP.NUM_DIAS,
			 CVRP.COD_RUTINA,
			 CVRR.TIP_RETORNO,
			 CVRP.VAL_RETORNO,
			 NVL(CVRP.VAL_RANGO,:szhNULO),
			 CVRP.IND_EXCLUYE,
			 CVRP.DIA_PRORROGA,
			 :szhLetra_X
	FROM   CO_VALRETRUT CVRR, CO_VALRETPTO CVRP
	WHERE  CVRR.COD_RUTINA  = CVRP.COD_RUTINA
	ORDER BY CVRP.NUM_DIAS, CVRP.COD_PTOGEST, CVRP.COD_CATEGORIA; */ 


	if( SQLCODE ) 	{
		ifnTrazasLog(modulo,"en DECLARE curCriPtoGestion: %s",LOG00,SQLERRM);
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL OPEN curCriPtoGestion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0002;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )90;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_C;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhNULO;
 sqlstm.sqhstl[1] = (unsigned long )5;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_X;
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


	if (SQLCODE) 	{
		ifnTrazasLog(modulo,"en OPEN curCriPtoGestion: %s",LOG00,SQLERRM);
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL FETCH curCriPtoGestion INTO :sthPtoGestionLoc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )500;
 sqlstm.offset = (unsigned int  )117;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)sthPtoGestionLoc.szTipRutina;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )2;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)sthPtoGestionLoc.szCodPtoGest;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)sthPtoGestionLoc.szCodCategoria;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )6;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)sthPtoGestionLoc.iNumDias;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )sizeof(int);
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)sthPtoGestionLoc.szCodRutina;
 sqlstm.sqhstl[4] = (unsigned long )6;
 sqlstm.sqhsts[4] = (         int  )6;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)sthPtoGestionLoc.szTipRetorno;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )2;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)sthPtoGestionLoc.szValRetorno;
 sqlstm.sqhstl[6] = (unsigned long )11;
 sqlstm.sqhsts[6] = (         int  )11;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)sthPtoGestionLoc.szValRango;
 sqlstm.sqhstl[7] = (unsigned long )11;
 sqlstm.sqhsts[7] = (         int  )11;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)sthPtoGestionLoc.szIndExcluye;
 sqlstm.sqhstl[8] = (unsigned long )2;
 sqlstm.sqhsts[8] = (         int  )2;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)sthPtoGestionLoc.iDiasProrroga;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )sizeof(int);
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)sthPtoGestionLoc.szIndProrroga;
 sqlstm.sqhstl[10] = (unsigned long )2;
 sqlstm.sqhsts[10] = (         int  )2;
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


	iTotalRows = SQLROWS;
	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)	{
		ifnTrazasLog(modulo,"en FETCH curCriPtoGestion : %s",LOG00,SQLERRM);
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL CLOSE curCriPtoGestion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )176;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE )	{
		ifnTrazasLog(modulo,"en CLOSE curCriPtoGestion : %s",LOG00,SQLERRM);
		return -1;
	}

	*sthPtoGestion = sthPtoGestionLoc;
	return iTotalRows;
}  /*FIN ifnCargaCriteriosPtos() */



/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
char	modulo[] = "ifnPreparaArchivoLog";
int	sts = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhPathLogSched[256];		/* EXEC SQL VAR szhPathLogSched IS STRING (256); */ 

/* EXEC SQL END DECLARE SECTION; */ 


	memset(szhPathLogSched,'\0',sizeof(szhPathLogSched));
	sprintf( stStatus.szFileName	, "%s", szhgCodProceso ); /* nombre 'propio' del archivo de log */
	sprintf( szhPathLogSched		, "%s/CO_SCHEDULER", getenv("XPC_LOG") );
	sprintf( stStatus.szLogPathGene	,"%s",szhPathLogSched );

	sts = ifnAbreArchivoLog(1); /* 1:crear directorio antes que el archivo */

	return sts;
} /* end ifnPreparaArchivoLog */



/***************************************************************/
/* Reserva memoria para el inicio de la lista*/
/* Devuelve -1 en caso de ERROR. */
int ifnIniListRev(Lista_Rev *list)
{
	if (( (*list) = (struct ACCIONREV *) malloc(sizeof(struct ACCIONREV))) == NULL)
		return -1;
	(*list)->sgte=NULL;

	return 0;
}

/***************************************************************/
/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraRev(Lista_Rev *ant)
{
	Lista_Rev aux ;
	if ((*ant) == NULL)
		return -1; /* Lista Vacia */
	else
	{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sgte;
		free(aux);
		return 0;
	} /* end if */
}


/* Funcion ifnCargaLista nueva e incorporada por PGonzalez 22-10-2004 */
int ifnCargaLista (int iFilas)
{
	char modulo[] = "ifnCargaLista";
	int i;

	for (i=0; i<iFilas ;i++)
	{
		iLB.lCod_Cliente  = sthClienteExclu.lCodCliente[i];
		iLB.dImportePago = sthClienteExclu.dImportePago[i];
		iLB.iProcedencia = sthClienteExclu.iProcedencia[i];
		sprintf(iLB.szNum_Ident   , "%s\0", sthClienteExclu.szNumIdent[i]);
		sprintf(iLB.szCod_Tipident, "%s\0", sthClienteExclu.szCodTipIdent[i]);
		sprintf(iLB.szCodTipClie , "%s\0", sthClienteExclu.szCodTipClie[i]);

		rtrim(iLB.szNum_Ident   );
		rtrim(iLB.szCod_Tipident);
		rtrim(iLB.szCodTipClie  );

		stListaClientes->Accion_sgte=NULL;

		if (Insertar_pos(stListaClientes, iLB, 1))
		{
			/*puts("\n\aERROR: No existe memoria suficiente.");*/
			ifnTrazasLog(modulo, "No existe memoria suficiente.", LOG01);
			return -1;
		}
	}
	return 0;
}

/*======================================================================================*/



/* ================================================================================ */
/* Funcion que segmenta en n partes la lista de acuerdo al valor obtenido entre     */
/* el total de clientes y la cantidad de instancias ingresadas por el usuario       */
/* cuyo resultado se guarda en la variable ihRAN_LISTAS con la cual se podra tener  */
/* la cantidad de hilos	a ejecutar 																	*/
/* ================================================================================ */
int ifnSeccionaLista(long lTotalReg)
{
char modulo[] = "ifnSeccionaLista";
int  i, j;
stLista pf;

	iNumeroHilos=0;
	if (((pInicio)=(stLista *) malloc(ihNUM_INSTAN * sizeof(stLista))) == NULL)	exit(STATUS_ERR);
	if (((pFinal) =(stLista *) malloc(ihNUM_INSTAN * sizeof(stLista))) == NULL)	exit(STATUS_ERR);

	ifnTrazasLog( modulo, "Comienza segmentacion a lista...lTotalReg [%ld]", LOG03,lTotalReg);
	for(i = 0, j = 0, pf = stListaClientes->sgte; pf && i < lTotalReg; i++ )
	{

		if (i == 0)
		{
			pInicio[j] = stListaClientes;
			iNumeroHilos++;
		}
		else if (i >= ihRAN_LISTAS)
		{
			if ((i % ihRAN_LISTAS) == 0)
			{
				iNumeroHilos++;
				pFinal[j++]->sgte = NULL;
				Inicializar_lista(&pInicio[j]);
				pInicio[j]->sgte = pf;
			}
		}
		pFinal[j] = pf;
		pf = pf->sgte;
	}


	ifnTrazasLog( modulo, "NumeroHilos a Ejecutar [%d]\n\n", LOG03,iNumeroHilos);

	return 0;
}


/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* if iCreaDir != 0 : crear directorio antes que el archivo                      */
/* ============================================================================= */
int ifnAbreArchivoLog(int iCrearDir)
{
char modulo[]="ifnAbreArchivoLog";
char szArchivoErr[256]="";                   /* errores      */
char szArchivoEst[256]=""; 					 /* estadisticas */
char szComando[256]="";
static char szAux[9];

	memset(szArchivoLog,0,sizeof(szArchivoLog)); /* log 		 */
	memset(szArchivoErr,0,sizeof(szArchivoErr)); /* errores 	 */
	memset(szArchivoEst,0,sizeof(szArchivoEst)); /* estadisticas */
	memset(szComando,0,sizeof(szComando)); /* estadisticas */

	strcpy (szAux,(char *)szSysDate("YYYYMMDD"));
	sprintf(szComando,"mkdir -p %s/%s",stStatus.szLogPathGene,szAux);
	if (system (szComando)!=0)
	{
		fprintf (stderr,"Error al intentar crear directorio de Log\n");
		fflush  (stderr);
		return -1;
	}
	sprintf(szArchivoLog,"%s/%s/%s.log",stStatus.szLogPathGene,szAux,stStatus.szFileName);
	sprintf(szArchivoErr,"%s/%s/%s.err",stStatus.szLogPathGene,szAux,stStatus.szFileName);
	sprintf(szArchivoEst,"%s/%s/%s.est",stStatus.szLogPathGene,szAux,stStatus.szFileName);

	if((stStatus.LogFile = fopen(szArchivoLog,"a")) == (FILE*)NULL )
	{
		fprintf (stderr,"Error al crear archivo de Log\n");
		fflush  (stderr);
		return -1;
	}

	if((stStatus.ErrFile = fopen(szArchivoErr,"a")) == (FILE*)NULL )
	{
		fprintf (stderr,"Error al crear archivo de Errores\n");
		fflush  (stderr);
		return -1;
	}

	if((stStatus.EstFile = fopen(szArchivoEst,"a")) == (FILE*)NULL )
	{
		fprintf (stderr,"Error al crear archivo de Estadisticas\n");
		fflush  (stderr);
		return -1;
	}
	fpFile=stStatus.LogFile;
	ifnTrazasLog(modulo, "%s - APERTURA DE ARCHIVO <%ld> -\n", INFALL,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

	return 0;
}/* end ifnAbreArchivoLog */

/* ================================================================================================ */
/*	Efectua un corte control entre las acciones anterior y posterior al pto de gestion               */
/* ================================================================================================ */
int ifnReversasValidas(FILE **ptArchLog, int iFilaAnt , int iFilaPos)
{
char  modulo[] = "ifnReversasValidas";
int i, j, iFlag=0;
char szCod_Rutina [6];
long lNum_Secuencia;

FILE *pfLog;

	pfLog = *ptArchLog;
	ifnTrazaHilos( modulo, &pfLog, "En modulo [%s]",LOG03,modulo);
	lAccionReversa=0;

	strcpy(szCod_Rutina,szhaCodRutinaPos[0]);
	for (i=0;i<iFilaPos;i++)
	{
		for (j=0;j<iFilaAnt;j++)
		{
			iFlag=TRUE;
			if (strcmp(szCod_Rutina,szhaCodRutinaAnt[i])==0)
			{
				pRevaux=list_inicio;
				while (pRevaux != NULL )
				{
					ifnTrazaHilos( modulo, &pfLog, "pRevaux->szCod_accion [%s]", LOG07, pRevaux->szCod_accion);
					ifnTrazaHilos( modulo, &pfLog, "pRevaux->szDes_accion [%s]", LOG07, pRevaux->szDes_accion);

				   	if (strcmp(pRevaux->szCod_accion,szCod_Rutina)==0) iFlag=FALSE;
				   	pRevaux=pRevaux->sgte;
			   	}

				ifnTrazaHilos( modulo, &pfLog, "Rutina [%s] esta antes y despues del Pto de Gestion. No Aplica..",LOG05,szCod_Rutina);
		   	}
		   	else
		   	{
		   		iFlag=FALSE;
			}

		}
		if (!iFlag)
		{
			ifnTrazaHilos( modulo, &pfLog, "szhaCodRutinaPos   [i]  [%s]",LOG05,szhaCodRutinaPos[i]);
			ifnTrazaHilos( modulo, &pfLog, "lhaNumSecuenciaPos [i]  [%ld]",LOG05,lhaNumSecuenciaPos[i]);
			ifnTrazaHilos( modulo, &pfLog, "ihaOrdAplicaPos    [i]  [%d]",LOG05,ihaOrdAplicaPos[i]);
			strcpy(sthAccionInversa.szCodRutinaInv[i],szhaCodRutinaPos[i]);
			sthAccionInversa.lNumSecuencia [i]=lhaNumSecuenciaPos[i];
			sthAccionInversa.iOrdAplicacion[i]=ihaOrdAplicaPos[i];
			ifnTrazaHilos( modulo, &pfLog, "\tsthAccionInversa.szCodRutinaInv[i]  [%s] ",LOG05,sthAccionInversa.szCodRutinaInv[i]);
			ifnTrazaHilos( modulo, &pfLog, "\tsthAccionInversa.lNumSecuencia [i]  [%ld]",LOG05,sthAccionInversa.lNumSecuencia[i]);
			ifnTrazaHilos( modulo, &pfLog, "\tsthAccionInversa.iOrdAplicacion[i]  [%d] ",LOG05,sthAccionInversa.iOrdAplicacion[i]);

			lAccionReversa++;
		}
		strcpy(szCod_Rutina,szhaCodRutinaPos[i]);
	}

	lNum_Secuencia=lhaNumSecuenciaAnt[0];
	for (j=0;j<iFilaAnt;j++)
	{
		if (strcmp(szhaCodRutinaAnt[j],"CANUM")==0)
		{
			if (lNum_Secuencia>lhaNumSecuenciaAnt[j])
			{
				lNum_Secuencia=lhaNumSecuenciaAnt[j];
			}
		}
	}

	return 0;
}

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs        */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
char modulo[]="vfnCierraArchivoLog";

	ifnTrazasLog(modulo, "%s -  CIERRE  DE ARCHIVO <%ld> -\n", INFALL,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

	if( fclose(stStatus.LogFile) != 0 )	{
		fprintf (stderr,"Error al cerrar archivo de Log\n");
		fflush  (stderr);
	}

	if( fclose(stStatus.ErrFile) != 0 )	{
		fprintf (stderr,"Error al cerrar archivo de Errores\n");
		fflush  (stderr);
	}

	if( fclose(stStatus.EstFile) != 0 )	{
		fprintf (stderr,"Error al cerrar archivo de Estadisticas\n");
		fflush  (stderr);
	}

	return;
} /* end vfnCierraArchivoLog */


/*======================================================================================*/
/*======================================================================================*/
BOOL bfnBuscaFadParametros( long lCodParam, char *szTipCampo, char *szCodModulo, char *szRetorno )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodModulo  [3];
	long	lhCodParam;
	char  szhValor    [100];
	char	szhTipParam  [20];
	char  szhDATE       [5];
	char  szhyyyymmdd   [9];
	char  szhNUMBER     [7];
	char  szh9999999999[11];
	char  szhVARCHAR2   [9];
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnBuscaFadParametros";

	lhCodParam = lCodParam;
	memset( szhTipParam, '\0', sizeof( szhTipParam ));
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ));
	memset( szhValor, '\0', sizeof( szhValor ));

	strcpy(szhTipParam, szTipCampo );
	strcpy(szhCodModulo, szCodModulo );
	strcpy(szhDATE,"DATE");
	strcpy(szhyyyymmdd,"yyyymmdd");
	strcpy(szhNUMBER,"NUMBER");
	strcpy(szh9999999999,"9999999999");
	strcpy(szhVARCHAR2,"VARCHAR2");

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT DECODE(:szhTipParam,:szhDATE,TO_CHAR(VAL_FECHA,:szhyyyymmdd),:szhNUMBER,TO_CHAR(VAL_NUMERICO,:szh9999999999),:szhVARCHAR2,VAL_CARACTER)
	INTO    :szhValor
	FROM    FAD_PARAMETROS
	WHERE   COD_PARAMETRO = :lhCodParam
	AND     TIP_PARAMETRO = :szhTipParam
	AND     COD_MODULO    = :szhCodModulo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select DECODE(:b0,:b1,TO_CHAR(VAL_FECHA,:b2),:b3,TO_CHAR(VAL\
_NUMERICO,:b4),:b5,VAL_CARACTER) into :b6  from FAD_PARAMETROS where ((COD_PAR\
AMETRO=:b7 and TIP_PARAMETRO=:b0) and COD_MODULO=:b9)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )191;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhTipParam;
 sqlstm.sqhstl[0] = (unsigned long )20;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhDATE;
 sqlstm.sqhstl[1] = (unsigned long )5;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhNUMBER;
 sqlstm.sqhstl[3] = (unsigned long )7;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szh9999999999;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhVARCHAR2;
 sqlstm.sqhstl[5] = (unsigned long )9;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhValor;
 sqlstm.sqhstl[6] = (unsigned long )100;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&lhCodParam;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhTipParam;
 sqlstm.sqhstl[8] = (unsigned long )20;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhCodModulo;
 sqlstm.sqhstl[9] = (unsigned long )3;
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



	if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "Select FAD_PARAMETROS %s ", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	strcpy( szRetorno, szhValor);
	return TRUE;
} /* BOOL bfnBuscaFadParametros( long lCodParam, char *szTipCampo, char *szCodModulo, char *szRetorno ) */



/* ================================================================================================ */
/*	Carga las acciones de reversa de la tabla ged_parametros   										          */
/* ================================================================================================ */
int ifnCargaReversa()
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCod_Accion  [6] ; /* EXEC SQL VAR szhCod_Accion IS STRING(6); */ 

	char szhDes_Accion  [51]; /* EXEC SQL VAR szhDes_Accion IS STRING(51); */ 

	char szhACCREVERS  [12];
/* EXEC SQL END DECLARE SECTION; */ 

char  modulo[] = "ifnCargaReversa";

	strcpy(szhACCREVERS,"%ACCREVERS%");
	list_inicio=NULL;
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL DECLARE CurReversa CURSOR FOR
	SELECT VAL_PARAMETRO , DES_PARAMETRO
	FROM  GED_PARAMETROS
	WHERE NOM_PARAMETRO LIKE :szhACCREVERS
	AND   COD_MODULO  = :szhCod_Modulo; */ 

	if( sqlca.sqlcode != SQLOK) 	{
	   ifnTrazasLog( modulo, "DECLARE CurReversa => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
	   return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL OPEN CurReversa ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0004;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )246;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhACCREVERS;
 sqlstm.sqhstl[0] = (unsigned long )12;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Modulo;
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


	if( sqlca.sqlcode != SQLOK) 	{
	   ifnTrazasLog( modulo, "OPEN CurReversa => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
	   return -1;
	}

	while (1)
	{

	   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		FETCH CurReversa
		INTO  :szhCod_Accion , :szhDes_Accion; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )269;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Accion;
  sqlstm.sqhstl[0] = (unsigned long )6;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhDes_Accion;
  sqlstm.sqhstl[1] = (unsigned long )51;
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


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		   ifnTrazasLog(modulo,"en FETCH %s",LOG00, sqlca.sqlerrm.sqlerrmc);
		   return -1;
		}

		if (sqlca.sqlcode == SQLNOTFOUND) break;

		if (ifnIniListRev(&Lista_aux) !=0) {
			ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
			return -1;
		}
		strcpy(Lista_aux->szCod_accion,szhCod_Accion);
		strcpy(Lista_aux->szDes_accion,szhDes_Accion);
		Lista_aux->sgte=list_inicio;
		list_inicio=Lista_aux;
		ifnTrazasLog(modulo,"\tLista_aux->szCod_accion [%s]", LOG03,Lista_aux->szCod_accion);
		ifnTrazasLog(modulo,"\tLista_aux->szDes_accion [%s]\n", LOG03,Lista_aux->szDes_accion);

	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL CLOSE CurReversa; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )292;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK) 	{
	    ifnTrazasLog(modulo,"CLOSE CurReversa :%s", LOG00,sqlca.sqlerrm.sqlerrmc);
	    return -1;
	}

	return 0;

} /*fin a ifnCargaReversa*/

/* ================================================================================================ */
/*	Obtiene parametros referentes a Reversa de Baja													*/
/* ================================================================================================ */
int ifnCargaParametrosRBaja( td_Parametros *stParam )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodReversa	[6];
	char	szhBAJA        [5];
	char  szhSINRE       [6];
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnCargaParametrosRBaja";
char	szRetorno[100];

	strcpy(szhBAJA ,"BAJA");
	strcpy(szhSINRE,"SINRE");

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* recuperamos el nombre de la accion reversa de baja */
	/* EXEC SQL
	SELECT NVL( REV_RUTINA, :szhSINRE )
	INTO	:szhCodReversa
	FROM	CO_RUTINAS
	WHERE	COD_RUTINA	= :szhBAJA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(REV_RUTINA,:b0) into :b1  from CO_RUTINAS where C\
OD_RUTINA=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )307;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhSINRE;
 sqlstm.sqhstl[0] = (unsigned long )6;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodReversa;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAJA;
 sqlstm.sqhstl[2] = (unsigned long )5;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "Buscando Reversa de Baja %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return 1;
	}

	strcpy( stParam->szCodReversaBaja, szhCodReversa );
	ifnTrazasLog( modulo, "Reversa de Baja %s.", LOG03, ( char* )stParam->szCodReversaBaja );

	memset( szRetorno, '\0', sizeof( szRetorno ) );
	if( !bfnBuscaFadParametros( 1, "NUMBER", "CO", szRetorno ) )
		return 1;

	stParam->dSaldo = atof(szRetorno);
	ifnTrazasLog( modulo, "Saldo permitido para ejecutar Reversa %.0f.", LOG03, stParam->dSaldo );

	memset( szRetorno, '\0', sizeof( szRetorno ));
	if( !bfnBuscaFadParametros( 2, "NUMBER", "CO", szRetorno ) )
		return 1;

	stParam->iDiasBaja = atoi(szRetorno);
	ifnTrazasLog( modulo, "Dias permitidos para reversar baja [%d].", LOG03, stParam->iDiasBaja );

	return 0;
} /* int	ifnCargaParametrosRBaja( td_Parametros *stParam ) */



/* ============================================================================= */
/*  ifnExcluidor() : Ejecuta las acciones que correspondan                       */
/* ============================================================================= */
int ifnExcluidor(void)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhUserPass[65];
	char 	szSesuserOra[50];	/* EXEC SQL VAR szSesuserOra    IS STRING(50); */ 

/* EXEC SQL END DECLARE SECTION; */ 


/* ------------------------------------------------------------------------- */
/* Inicializacion de Variables                                               */
/* ------------------------------------------------------------------------- */
char modulo []    ="ifnExcluidor";
int i;
char szIniProc2[9], szFinProc2[9], szTmpProc2[9];
int  iDifSegs = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  iDiffSeg     = 0;
	char szIniProc[9]    ; /* EXEC SQL VAR szIniProc IS STRING(9); */ 

	char szFinProc[9]    ; /* EXEC SQL VAR szFinProc IS STRING(9); */ 

   char szTmpProc[9];
	int  ihCountEstadis  ;
	int  ihTotalClies=0  ;
/* EXEC SQL END DECLARE SECTION; */ 


	/* ------------------------------------------------------------------------- */
	/* Inicio del Proceso Principal                                              */
	/* ------------------------------------------------------------------------- */
	memset(szhUserPass,'\0',sizeof(szhUserPass));
	memset(szSesuserOra,'\0',sizeof(szSesuserOra));
	ifnTrazasLog(modulo,"Corriendo la cola lanzada ",LOG05);
  	ifnTrazasLog(modulo, "PROCESO => %s - PID => %ld - VERSION => %s.\n", LOG03, szhProceso, getpid(), szVERSION );

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			:szIniProc := TO_CHAR(SYSDATE,:szhHH24MISS );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szIniProc := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; END\
 ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )334;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szIniProc;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "TO_CHAR(SYSDATE,:szhHH24MISS )(1) - %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT count(*)
	INTO   :ihCountEstadis
	FROM   CO_ESTADISEVA_TO
	WHERE  COD_PROCESO = :szhProceso
	AND    TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_ESTADISEVA_TO where (COD_\
PROCESO=:b1 and TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )357;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCountEstadis;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhProceso;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "SELECT count(*) CO_ESTADISEVA_TO - %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	if ((ihCountEstadis == 0) || (sqlca.sqlcode == SQLNOTFOUND )) {
		/* Insertando estadisticas del proceso padre. Secuencia de este corresponde a 0 */
		if (ifnInsertaEstadisticas(iSec_Padre, szhProceso) != 0 )  return -1;
	}

	/* ------------------------------------------------------------------------- */
	/* Cambia Estado de la Cola                                                  */
	/* ------------------------------------------------------------------------- */
	if( !bfnCambiaEstadoCola( szhProceso, "L", "R" ) )  /*'Launched->Running'*/
	{
		if( !bfnOraRollBack() ) ifnTrazasLog(modulo,"En Rollback 'L->R' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		return -1;
	}
	else
	{
		if( !bfnOraCommit() )
		{
			ifnTrazasLog(modulo,"En Commit 'L->R' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
			if( !bfnOraRollBack() ) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,sqlca.sqlerrm.sqlerrmc);
				return -1;
		}
	}

	sprintf( szIniProc2, "%s", szSysDate( "HH24:MI:SS" ) );
	/* ------------------------------------------------------------------------- */
   	/* Carga de datos de uso general 											 */
	/* ------------------------------------------------------------------------- */
	if( !bfnObtieneDatosGenerales() )
	{
	    ifnTrazasLog( modulo, "Error al realizar carga de bfnObtieneDatosGenerales().", LOG03 );
	    return -1;
	}

	/* Calcula porcentaje de memoria libre y usada */
	if (ifnMemoriaUsada(&lhCpu)!=0) return -1;

	/* Selecciona cantidad  de instancias */
	if (ifnValInstancias(szhProceso, &ihNUM_INSTAN)!=0) return -1;

	memset(szhUser_Cobros,'\0',sizeof(szhUser_Cobros));
	/* Selecciona usuario de la ged_parametro
	if (ifnUsuarioParam(szhUser_Cobros)!=0) return -1;*/

	memset( szhUserPass, '\0', sizeof( szhUserPass ) );
	strcpy( szhUserPass, szUsuarioConec);
	strcat( szhUserPass, "/" );
	strcat( szhUserPass, szPasswConec);
	ifnTrazasLog( modulo, "Abriendo Conexiones a BD segun instancias definidas.  szhUserPass [%s]", LOG03,szhUserPass);


	/*Abrimos las instancias de Base de Datos */
	/*for( i = 0; i < MAX_INSTANCIAS; i++ ) Requerimiento de Soporte 77756 */
	for( i = 0; i < ihNUM_INSTAN; i++ )
	{
		/* EXEC SQL CONTEXT ALLOCATE :CtxInsBas[i]; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )380;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&CtxInsBas[i];
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


		/* EXEC SQL CONTEXT USE :CtxInsBas[i]; */ 

		/* EXEC SQL CONNECT :szhUserPass; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )10;
  sqlstm.offset = (unsigned int  )399;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhUserPass;
  sqlstm.sqhstl[0] = (unsigned long )65;
  sqlstm.sqhsts[0] = (         int  )65;
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
  sqlcxt(&CtxInsBas[i], &sqlctx, &sqlstm, &sqlfpn);
}


	}

	/* seteamos la instancia de base de datos por defecto */
	/* EXEC SQL CONTEXT USE DEFAULT; */ 


/* PGG 11-11-2004 Instancias de BD */

	ifnTrazasLog( modulo, "Inicializando datos de estructura de instancias.\n", LOG05 );
	/*for( i = 0; i < MAX_INSTANCIAS; i++ ) Requerimiento de Soporte 77756 */
	for( i = 0; i < ihNUM_INSTAN; i++ )
	{
		stParametrosHilos[i].bDisponibilidad = TRUE;
		stParametrosHilos[i].idThread = i;
		stParametrosHilos[i].CtxInsBas = CtxInsBas[i]; 	/* PGG 11-11-2004 Almaceno la instancia de BD correspondiente */
		memset( stParametrosHilos[i].szUserOracle, '\0', sizeof( stParametrosHilos[i].szUserOracle ) );
		memset( stParametrosHilos[i].szPassOracle, '\0', sizeof( stParametrosHilos[i].szPassOracle ) );
		strcpy(stParametrosHilos[i].szUserOracle, stLineaComando.szOraAccount);
		strcpy(stParametrosHilos[i].szPassOracle, stLineaComando.szOraPasswd);
		stParametrosHilos[i].lIdInstancia = 0;
		stParametrosHilos[i].lCorrInstancia = 0;
	}

	/* ------------------------------------------------------------------------- */
  	/* Proceso Excluye Cliente      					*/
	/* ------------------------------------------------------------------------- */
	/* if( ifnExcluyeClientes(szError ) < 0 )   */
	if( ifnExcluyeClientes(szDescError) < 0 )
	{	/*ifnMailAlert(szhgCodProceso,"TODOS","%s",szError);*/
		ifnMailAlert(szhgCodProceso,"TODOS","%s",szDescError);
	}

	/****************************************************************************************/
/* Requerimiento de Soporte - #71598 17-10-2008 mgg */	
/*
	EXEC SQL EXECUTE
		BEGIN
			:szFinProc := TO_CHAR(SYSDATE,:szhHH24MISS);
		END;
	END-EXEC;
*/	

	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
	sprintf(szFinProc,"%s",szSysDate("HH24:MI:SS"));

	iDiffSeg = ifnRestaHoras(szIniProc,szFinProc,szTmpProc);
	ifnTrazasLog( modulo, "\n\tActualizar CO_ESTADISEVA_TO con :\n\t\tiDiffSeg  [%d]\n\t\tszIniProc [%s]\n\t\tszFinProc [%s]\n", LOG03,iDiffSeg,szIniProc,szFinProc);

	/* Informacion Estadistica */
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT NVL(SUM(CNT_CLIENTES_PROC),:ihValor_cero)
	  INTO :ihCountEstadis
	  FROM CO_ESTADISEVA_TO
	 WHERE COD_PROCESO = :szhProceso
	   AND SECUENCIA   = :ihValor_cero
	   AND TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum(CNT_CLIENTES_PROC),:b0) into :b1  from CO_EST\
ADISEVA_TO where ((COD_PROCESO=:b2 and SECUENCIA=:b0) and TRUNC(FEC_INGRESO)=T\
RUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )430;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCountEstadis;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "SELECT count(*) CO_ESTADISEVA_TO Padre - %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
	}
	else if (sqlca.sqlcode == SQLNOTFOUND)
	{
		ifnTrazasLog(modulo, "Registro deberia existir..!!.", LOG02);
	}
	else
	{
		if (ihCountEstadis < lTotalRows)
		{
			ihTotalClies=lTotalRows;
			/* actualizando estadisticas del proceso padre. Secuencia corresponde a 0*/
			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			UPDATE CO_ESTADISEVA_TO SET
			       TIEMPO_PROCESO     = :iDiffSeg ,
			       CNT_CLIENTES_PROC  = :ihTotalClies,
			       FEC_INGRESO        = SYSDATE
			 WHERE COD_PROCESO        = :szhProceso
			   AND SECUENCIA          = :ihValor_cero
			   AND TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_ESTADISEVA_TO  set TIEMPO_PROCESO=:b0,CNT_CLIENT\
ES_PROC=:b1,FEC_INGRESO=SYSDATE where ((COD_PROCESO=:b2 and SECUENCIA=:b3) and\
 TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )461;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&iDiffSeg;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihTotalClies;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhProceso;
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
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



			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
			{
			   ifnTrazasLog(modulo, "Error al actualizar estadistica del Padre. - %s", LOG00,sqlca.sqlerrm.sqlerrmc);
			}
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )492;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		}

	}

	if (ifnInsertaParamUnix(szhProceso, ihNUM_INSTAN, lhCpu)!=0)  return -1;

	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
	ifnTrazasLog( modulo, "\n\t RESUMEN GENERAL DEL PROCESO.", EST00 );
	
	ifnTrazasLog(modulo,"\n\t       HORA INICIO  : %s "
						"\n\t       HORA TERMINO : %s "
						"\n\t       TIEMPO TOTAL : %s  (%d segs) \n", LOG03, szIniProc, szFinProc, szTmpProc, iDiffSeg );


	/* ------------------------------------------------------------------------- */
	/* ultima accion : cambiar estado de la cola de proceso de Running a Wait    */
	/* ------------------------------------------------------------------------- */
	ifnTrazasLog(modulo,"Volviendo la cola a espera ",LOG05);
	if (!bfnCambiaEstadoCola(szhgCodProceso,"R","W")) /*'Running->Wait'*/
	{
		if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'R->W' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		return -1;
	}
	else
	{
		if (!bfnOraCommit())
		{
			ifnTrazasLog(modulo,"En Commit 'R->W' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
			if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,sqlca.sqlerrm.sqlerrmc);
				return -1;
		}
	}

	ifnTrazasLog(modulo,"saliendo de %s ( Cola Wait )",LOG02,szhgCodProceso);
	return 0;
}

/* ============================================================================= */
/* main                                                                          */
/* ============================================================================= */
int main(int argc,char *argv[])
{
/* ------------------------------------------------------------------------- */
/* Definicion de variables 												     */
/* ------------------------------------------------------------------------- */
char modulo[]="main";
int iResult  = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodEstado[2]; /* EXEC SQL VAR szhCodEstado IS STRING (2); */ 

	char szhWAIT        [2];
/* EXEC SQL END DECLARE SECTION; */ 


	/* ------------------------------------------------------------------------- */
	/* Inicializacion de variables 									     		 */
	/* ------------------------------------------------------------------------- */
	memset( szhgCodProceso, '\0', sizeof( szhgCodProceso ) );
   memset(&stParametros,0,sizeof(td_Parametros));
	memset(&stLineaComando,0,sizeof(LINEACOMANDO));
	memset(&sthPtosGestion,0,sizeof(td_PtoGestion));
	memset(&sthPtoCriterio,0,sizeof(td_PtoRutina));
	memset(&sthClienteExclu,0,sizeof(td_Cliente_Exclu));
	memset(&sthAccionInversa,0,sizeof(td_Accion_Inversa));

	strcpy( szhgCodProceso, szCODPROCESO );
	strcpy(szhCod_Modulo,"CO");
	strcpy(szhEstadoEJE,"EJE");
	strcpy(szhEstadoRER,"RER");
	strcpy(szhPND,"PND");
	strcpy(szhERR,"ERR");
	strcpy(szhLetra_N,"N");
	strcpy(szhLetra_R,"R");
	strcpy(szhLetra_E,"E");
	strcpy(szhLetra_A,"A");
	strcpy(szhLetra_C,"C");
	strcpy(szhLetra_M,"M");
	strcpy(szhWAIT,"W");
	strcpy(szhYYYYMMDD,"YYYYMMDD");
   strcpy(szhHH24MISS,"HH24:MI:SS");

	/* ------------------------------------------------------------------------- */
	/* Identificacion del Proceso 									     		 */
	/* ------------------------------------------------------------------------- */
  	fprintf( stdout, "\n%s PROCESO => %s - PID => %ld - VERSION => %s.\n", szGetTime(1), szhgCodProceso, getpid(), szVERSION );
	fflush ( stdout );

	/*- Validacion de parametros de entrada -*/
	memset(&stLineaComando,0,sizeof(LINEACOMANDO));
	if (ifnValidaParametros(argc,argv,&stLineaComando) != 0)
	{
		fprintf (stdout,"\n\tError >> Fallo la Validacion de Parametros \n");
		ifnMailAlert(szhgCodProceso,"TODOS","FALLO VALIDACION DE PARAMETROS.");
		fflush  (stdout);
		iResult = 1; /* Fallo validacion */
	}
	else
	{
		/*- Conexion a la Base de Datos -*/
		if (ifnConexionDB(&stLineaComando) != 0 )
		{
			fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
			fflush  (stdout);
			ifnMailAlert( szhgCodProceso, "TODOS", "FALLO CONEXION A LA BASE." );
			iResult = 2; /* Fallo conexion */
		}
		else
		{
			/*- Prepara Archivo de Log -*/
			if (ifnPreparaArchivoLog() != 0)
			{
				fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
				fflush  (stdout);
				ifnMailAlert(szhgCodProceso,"TODOS","FALLO DE ARCHIVO DE LOG.");
				iResult = 3;  /* Fallo Log */
			}
			else
			{
				sema_init (&semaflock , 1, NULL, NULL );
				/*- Ejecuta el proceso propiamente tal -*/
				if (ifnExcluidor() != 0)
				{
					sema_destroy(&semaflock);
					fprintf (stdout,"\n\tError >> Fallo el proceso \n");
					fflush  (stdout);
					ifnMailAlert(szhgCodProceso,"TODOS","FALLO DEL PROCESO.");
					iResult = 4; /* Fallo Proceso */

				}
				else /* excluidor salio con 0 ( supuestamente cola de vuelta en wait ) */
				{
					sema_destroy(&semaflock);
					/* EXEC SQL
					SELECT COD_ESTADO
					INTO   :szhCodEstado
					FROM   CO_COLASPROC
					WHERE  COD_PROCESO=:szhgCodProceso; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 11;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLASPROC where COD_\
PROCESO=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )507;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstado;
     sqlstm.sqhstl[0] = (unsigned long )2;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhgCodProceso;
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




					if( sqlca.sqlcode )
					{
						fprintf (stdout,"\n\tError >> Fallo el proceso ( Validacion Cola Wait ) \n");
						fflush  (stdout);
						ifnMailAlert(szhgCodProceso,"TODOS","FALLO LA VALIDACION FINAL DE LA COLA.");
						iResult = 5; /* Fallo Proceso */
					}
					else
					{
						if ( strcmp(szhCodEstado,"W")!=0 )
						{
							/* LA COLA ESTA EN UN ESTADO DISTINTO DE WAIT */
							/* SEÑALAR ESTO COMO ERROR E INTENTAR FORZARLA A WAIT */
							ifnTrazasLog(modulo,"Regresando la Cola a Espera (%s)",LOG02,szhCodEstado);
							/* EXEC SQL
							UPDATE CO_COLASPROC SET
							       COD_ESTADO = :szhWAIT
							WHERE  COD_PROCESO = :szhgCodProceso ; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 11;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update CO_COLASPROC  set COD_ESTADO=:b0 where COD_PROC\
ESO=:b1";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )530;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhWAIT;
       sqlstm.sqhstl[0] = (unsigned long )2;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhgCodProceso;
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


							if (sqlca.sqlcode)
							{
								fprintf (stdout,"\n\tError >> Fallo el proceso ( Update Cola Wait ) %s\n",sqlca.sqlerrm.sqlerrmc );
								fflush  (stdout);
								ifnMailAlert(szhgCodProceso,"TODOS","FALLO AL ACTUALIZAR LA COLA A 'WAIT'.");
								iResult = 6; /* Fallo Proceso */
							}
							/* EXEC SQL COMMIT; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 11;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )553;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


							if (sqlca.sqlcode)
							{
								fprintf (stdout,"\n\tError >> Fallo el proceso ( Commit Cola Wait ) %s\n", sqlca.sqlerrm.sqlerrmc );
								fflush  (stdout);
								ifnMailAlert(szhgCodProceso,"TODOS","FALLO EL COMMIT DE LA COLA 'WAIT'.");
								iResult = 7; /* Fallo Proceso */
							}
							ifnTrazasLog(modulo,"OK. Cola forzada a espera",LOG02);
						} /* if ( strcmp(szhCodEstado,"W")!=0 ) */
					}
				} /* if (ifnExcluidor() != 0) */
				vfnCierraArchivoLog();
			} /* if (ifnPreparaArchivoLog() != 0) */
		} /* if (ifnConexionDB(&stLineaComando) != 0 ) */
	} /* if (ifnValidaParametros(argc,argv,&stLineaComando) != 0) */

	return iResult;
}  /* end main */

/* ============================================================================= */
/* ifnExcluyeClientes                                                            */
/* ============================================================================= */
int ifnExcluyeClientes(char* szDescError)
{
/* ------------------------------------------------------------------------- */
/* Inicializacion de Variables                                               */
/* ------------------------------------------------------------------------- */
int	j               = 0;
int	iDifSegs        = 0;
/*long	lTotalRows      = 0;*/
long  lRowsThisLoop   = 0;
long  lRowsProcessed  = 0;
long  lContClientesRev= 0;
long  lhClientesError = 0;
long  lCantTotal 	= 0; /* Incorporado por PGonzalez 28-10-2004 MAS-04037 */
char	modulo   []="ifnExcluyeClientes";
char	szIniProc[9];
char  szFinProc[9];
char  szTmpProc[9];
char	szArchReposCtc[256]="";
char	szRecord[iTamReg+1]="";
char  szAuxCliente[9]    ="";
char  szAuxImporte[13]   ="";
char  szComando   [512]  ="";

FILE	*pArchReposCtc = (FILE*) NULL;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	ihNumDeltaHoras;
	char	szhIniUltPeriodo[15];
	char  szhYYYYMMDDHH24MISS[17];
	char  szhMC      [3];
	char  szhNC      [3];
/* EXEC SQL END DECLARE SECTION; */ 


stLista paux;	/* Incorporado por PGonzalez 25-10-2004 MAS-04037 */

	memset(szArchReposCtc,'\0',sizeof(szArchReposCtc));
	memset(szComando,'\0',sizeof(szComando));
	/* ------------------------------------------------------------------------- */
	/* Señala Inicio del procesamiento real                                      */
	/* ------------------------------------------------------------------------- */
	sprintf( szIniProc, "%s", szSysDate( "HH24:MI:SS" ) );
	strcpy(szhYYYYMMDDHH24MISS,"YYYYMMDDHH24MISS");
	strcpy(szhMC,"MC");
	strcpy(szhNC,"NC");
	/* ------------------------------------------------------------------------- */
	/* Carga parametros generales para validar ejecucion de reversas de baja     */
	/* ------------------------------------------------------------------------- */
	if( ifnCargaParametrosRBaja( &stParametros ) )	{
		sprintf( szDescError, "Fallo la carga de parametros Generales" );
		return -1; /*Mail*/
	}

	/* ------------------------------------------------------------------------- */
	/* Carga Categoria, Puntos de Gestion, Criterios y Acciones                  */
	/* ------------------------------------------------------------------------- */
	ifnTrazasLog( modulo, "Cargando todos los Puntos de Gestion 'Activables'", LOG03 );
	if( (iTotPtosGestion = ifnCargaPtosGestion( &sthPtosGestion ) ) < 0 ) 	{
		sprintf( szDescError, "Fallo la Carga de Puntos de Gestion" );
		return -1;
	}
   	ifnTrazasLog( modulo, "Cargados %d Puntos de Gestion ", LOG03, iTotPtosGestion );

	ifnTrazasLog( modulo, "Cargando todos los Criterios de los Puntos de Gestion 'Activables'", LOG03 );
	if( (iTotPtosCriterio = ifnCargaCriteriosPtos( &sthPtoCriterio ) ) < 0 ) 	{
		sprintf( szDescError, "Fallo la Carga de Criterios" );
		return -1;
	}
	ifnTrazasLog( modulo, "Cargados %d Criterios\n ", LOG03, iTotPtosCriterio );

	ifnTrazasLog( modulo, "Cargando Acciones Reversibles", LOG03 );
	if (ifnCargaReversa() !=0) {
		sprintf( szDescError, "Fallo la Carga de Acciones de Reversa" );
		return -1;
	}

	/* ------------------------------------------------------------------------- */
	/* Inicializacion de Variable de Ambiente                                    */
	/* ------------------------------------------------------------------------- */
	/*sprintf( szArchReposCtc, "%s/SUPERTEL/REHA_CTC/NuevosPagos.dat", getenv("XPC_DAT") );*/
	/* ------------------------------------------------------------------------- */
	/* Procesamiento de Archivo de Reposiciones                                  */
	/* ------------------------------------------------------------------------- */
	/*ifnTrazasLog(modulo,"*******PROCESA ARCHIVO DE REPOSICIONES*******\n",LOG03);

	sprintf(szComando,"%s/GetArchReposCtc.sh %d >>%s",getenv("XPC_KSH"),stStatus.iLogNivel,szArchivoLog);
	ifnTrazasLog(modulo,"%s",LOG05,szComando);
	j = system(szComando);*/ j=-1;

	if (Inicializar_lista(&stListaClientes)== -1) 				/* PGG incorporado 25-10-2004 */
		ifnTrazasLog(modulo,"Error en Inicializar_lista" ,LOG02);  	/* PGG incorporado 25-10-2004 */

	if( j == 0 ) /* si la shell se ejecuto correctamente */
	{
		if( ( pArchReposCtc = fopen(szArchReposCtc,"r") ) == (FILE*)NULL )
		{
			ifnTrazasLog(modulo,"No hay archivo de Reposiciones" ,LOG02);
		}
		else
		{
			ifnTrazasLog(modulo,"Llenando la estructura a partir del Archivo",LOG05);
			lTotalRows = 0;
			while(1)
			{
				memset(szRecord,'\0',sizeof(szRecord));
				if( (char *)NULL == fgets(szRecord,iTamReg*2,pArchReposCtc) )
				{
					if (feof(pArchReposCtc))
					{
						ifnTrazasLog(modulo,"Alcanzado Fin de Archivo",LOG05);
						break;
					}
					else
					{
						ifnTrazasLog(modulo,"en la lectura del Archivo",LOG01);
						break;
					}
				}
				else
				{
					j = strlen(szRecord);
					ifnTrazasLog(modulo,"Largo del Registro Leido [%d]",LOG05,j);
					if ( j < iTamReg - 1 )
					{
						ifnTrazasLog(modulo,"Registro con menos caracteres de lo esperado [%s]",LOG05,szRecord);
					}
					else if ( j > iTamReg )
					{
						ifnTrazasLog(modulo,"Registro con mas caracteres de lo esperado [%s]",LOG05,szRecord);
					}
					else
					{
						rtrim( szRecord );
						ifnTrazasLog(modulo,"szRecord => [%s]", LOG05, szRecord );
						memset(szAuxCliente,'\0',sizeof(szAuxCliente));
						memset(szAuxImporte,'\0',sizeof(szAuxImporte));

						strncpy(szAuxCliente,&szRecord[0],8);
						ifnTrazasLog(modulo,"szAuxCliente => [%s]", LOG06, szAuxCliente );

						strncpy(szAuxImporte,&szRecord[42],12);
						ifnTrazasLog(modulo,"szAuxImporte => [%s]", LOG06, szAuxImporte );

						sthClienteExclu.lCodCliente[lTotalRows]  = atol(szAuxCliente);
						sthClienteExclu.dImportePago[lTotalRows] = atof(szAuxImporte);
						sthClienteExclu.iProcedencia[lTotalRows] = 0; /* Incorporado por PGonzalez 25-10-2004 MAS-04037 */

						sthClienteExclu.szNumIdent[lTotalRows][0] = '\0' ;
						sthClienteExclu.szCodTipIdent[lTotalRows][0] = '\0' ;
						sthClienteExclu.szCodTipClie[lTotalRows][0] = 'M' ;
						sthClienteExclu.szCodTipClie[lTotalRows][1] = '\0' ;
						lTotalRows++;
					}
				}
			}/*endwhile*/

			/* En este punto tenemos la estructura cargada */
			lCantTotal = lTotalRows; /* Incorporado por PGonzalez 28-10-2004 MAS-04037 */
			if(ifnCargaLista(lTotalRows)!= 0) return -1; /* PGG incorporado el 22-10-2004 */

			memset(&sthClienteExclu,0,sizeof(td_Cliente_Exclu));
			/* PGG aqui estaba el for con llamada a Procesa Pagos.*/

			/* endfor*/
		} /* if( ( pArchReposCtc = fopen(szArchReposCtc,"r") ) == (FILE*)NULL ) */
		ifnTrazasLog( modulo, "Procesados => [%ld] Clientes de Archivo.", LOG03, lContClientesRev );
	} /* if( j == 0 ) */

	/* ------------------------------------------------------------------------- */
	/* Procesa pagos recientes de la base de datos, si la cola sigue activa      */
	/* ------------------------------------------------------------------------- */
   if( ihFlgError == 1 )               /* continua solo si la cola sigue activa */
   {
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		ifnTrazasLog(modulo,"*******PROCESA PAGOS RECIENTES DE LA BASE DE DATOS*******\n",LOG03);
		/* Obtener delta horas para determinar el ultimo periodo */
		/* EXEC SQL SELECT NUM_DELTAHORAS
		INTO	:ihNumDeltaHoras /o horas o/
		FROM	CO_COLASPROC
		WHERE	COD_PROCESO = :szhgCodProceso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NUM_DELTAHORAS into :b0  from CO_COLASPROC where COD\
_PROCESO=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )568;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihNumDeltaHoras;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhgCodProceso;
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

  /* szhgCodProceso deberia ser variable host */
		if( sqlca.sqlcode ) /* No pudo obtener DeltaHoras */
		{
			ifnTrazasLog(modulo,"en SELECT NUM_DELTAHORAS : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
			sprintf(szDescError,"Fallo al obtener delta horas %s",sqlca.sqlerrm.sqlerrmc);
			return -1; /*Mail*/
		}

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* Determinar el ultimo periodo */
		/* EXEC SQL
		SELECT	TO_CHAR((SYSDATE-(:ihNumDeltaHoras/:ihValor_24)),:szhYYYYMMDDHH24MISS)
		INTO	:szhIniUltPeriodo
		FROM	dual; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select TO_CHAR((SYSDATE-(:b0/:b1)),:b2) into :b3  from dual\
 ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )591;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihNumDeltaHoras;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_24;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDDHH24MISS;
  sqlstm.sqhstl[2] = (unsigned long )17;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhIniUltPeriodo;
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


		if( sqlca.sqlcode ) /* No pudo obtener fecha tope del ultimo periodo */
		{
			ifnTrazasLog(modulo,"en SELECT Fecha Inicio Ultimo Periodo : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
			sprintf(szDescError,"Fallo al obtener Fecha de Inicio del Ultimo Periodo %s",sqlca.sqlerrm.sqlerrmc);
			return -1; /*Mail*/
		}

		ifnTrazasLog( modulo, "szhIniUltPeriodo = [%s]\n", LOG05, szhIniUltPeriodo );

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL DECLARE curClientes_EXCLU CURSOR FOR
		/oSELECT UNIQUE M.COD_CLIENTE, M.NUM_IDENT, M.COD_TIPIDENT, :szhLetra_R, :ihValor_cero, :ihIndProcedencia   * Cliente es Reprocesado Homolog. PR-0330 (GAC 12-05-2004) *
		FROM   CO_MOROSOS M
		WHERE  M.TIP_MOROSO = :szhLetra_R
		o/
		/oInicio HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia TM-200503291318 o/
		SELECT UNIQUE M.COD_CLIENTE, M.NUM_IDENT, M.COD_TIPIDENT, M.TIP_MOROSO, :ihValor_cero, :ihIndProcedencia   /o Cliente es Reprocesado Homolog. PR-0330 (GAC 12-05-2004) o/
		FROM   CO_MOROSOS M
		WHERE  M.TIP_MOROSO IN ( :szhLetra_R, :szhLetra_C )
        /oFin HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia TM-200503291318 o/
		union ALL	/o Requerimento de Soporte 77756 o/
		SELECT UNIQUE M.COD_CLIENTE, M.NUM_IDENT, M.COD_TIPIDENT, :szhLetra_C, :ihValor_cero, :ihIndProcedencia	/o Cliente CAMBIO CATEGORIA - Pago de $0 jlr_15.12.00 o/
		FROM   CO_MOROSOS M, GA_MODCLI G
		WHERE  M.COD_CLIENTE = G.COD_CLIENTE
		AND    M.TIP_MOROSO ||'' in (:szhLetra_N, :szhLetra_E)	/o Requerimiento de Soporte - #43432 28-08-2007 capc ** Moroso 'Normal' :  No es puntual y no esta en proceso de rehabilitacion. E=Para pasar a historico rvc 22.07.03o/
		AND    G.COD_TIPMODI = :szhNC					/o Nueva Categoria o/
		AND    G.FEC_MODIFICA > TRUNC( SYSDATE )		/o y que se haya modificado hoy o/
		AND    G.COD_CATEGORIA IS NULL					/o Nueva Categoria jlr_30.01.01 o/
		AND    G.COD_CLIENTE > 0						/o Soporte RyC 39582 mgg o/
		union ALL	/o Requerimento de Soporte 77756 o/
		SELECT UNIQUE M.COD_CLIENTE, M.NUM_IDENT, M.COD_TIPIDENT, :szhLetra_C, :ihValor_cero, :ihIndProcedencia	/o Cliente CAMBIO CATEGORIA - Pago de $0 jlr_15.12.00 o/
		FROM   CO_MOROSOS M, GA_MODCLI G
		WHERE  M.COD_CLIENTE = G.COD_CLIENTE
		AND    M.TIP_MOROSO ||'' in (:szhLetra_N,:szhLetra_E)	/o Requerimiento de Soporte - #43432 28-08-2007 capc ** Moroso 'Normal' :  No es puntual y no esta en proceso de rehabilitacion . E=Para pasar a historico rvc 22.07.03o/
		AND    G.COD_TIPMODI = :szhMC					/o Modifica Categoria o/
		AND    G.FEC_MODIFICA > TRUNC(SYSDATE)			/o y que se haya modificado hoy o/
		AND    G.COD_CATEGORIA IS NOT NULL				/o Antigua Categoria jlr_30.01.01 o/
		AND    G.COD_CLIENTE > 0						/o Soporte RyC 39582 mgg o/
		union ALL	/o Requerimento de Soporte 77756 o/
		SELECT B.COD_CLIENTE, B.NUM_IDENT, B.COD_TIPIDENT, :szhLetra_C, :ihValor_cero, :ihIndProcedencia
		FROM   GAH_CATEG_DETPOSTULACION A, GE_CLIENTES B, GAH_CATEG_POSTULACION C, CO_MOROSOS D
		WHERE  C.COD_ESTADO = :szhLetra_A
		AND    A.TIP_POSTULANTE = :ihValor_uno
		AND    C.FEC_RESPUESTA > TRUNC( SYSDATE )
		AND    A.COD_POSTULANTE = B.COD_CUENTA
		AND    A.NUM_POSTULACION = C.NUM_POSTULACION
		AND    B.COD_CLIENTE = D.COD_CLIENTE
		AND    C.NUM_POSTULACION > 0					/o Soporte RyC 39582 mgg o/
		union all	/o Requerimento de Soporte 77756 o/
		SELECT UNIQUE M.COD_CLIENTE, M.NUM_IDENT, M.COD_TIPIDENT, :szhLetra_M, :ihValor_cero, :ihIndProcedencia	/o Cliente MOROSO - Pago de $0 o/
		FROM   CO_MOROSOS M, CO_PAGOS P
		WHERE  M.COD_CLIENTE = P.COD_CLIENTE
		AND    M.TIP_MOROSO ||'' in (:szhLetra_N,:szhLetra_E)	/o Requerimiento de Soporte - #43432 28-08-2007 capc ** Moroso 'Normal' :  No es puntual y no esta en proceso de rehabilitacion. E=Para pasar a historico rvc 22.07.03o/
		AND    P.FEC_EFECTIVIDAD >= TO_DATE( :szhIniUltPeriodo, :szhYYYYMMDDHH24MISS )	/o Esta dentro del ultimo periodo o/
		AND NOT EXISTS (SELECT 1 FROM CO_CODIGOS C		/o Soporte RyC RA-200603010852 03-03-2006 capc o/
                         WHERE C.NOM_TABLA = 'CO_PAGOS'
                           AND     C.NOM_COLUMNA = 'COD_TIPDOCUM'
                           AND     TO_NUMBER(C.COD_VALOR) = P.COD_TIPDOCUM)
      AND NOT EXISTS (SELECT 1 FROM CO_DET_DOCUMENTOS D
                 WHERE D.NUM_SECUENCI_PAGO = P.NUM_SECUENCI)
		union all	/o Requerimento de Soporte 77756 o/
		SELECT UNIQUE P.COD_CLIENTE, E.NUM_IDENT, E.COD_TIPIDENT, :szhLetra_E, :ihValor_cero, :ihIndProcedencia	/o Cliente COB. EXTERNA - Pago de $0 o/
		FROM   CO_COBEXTERNA E, CO_PAGOS P, GE_CLIENTES G
		WHERE  G.COD_CLIENTE = P.COD_CLIENTE
		AND    G.NUM_IDENT = E.NUM_IDENT
		AND    G.COD_TIPIDENT = E.COD_TIPIDENT
		AND    P.FEC_EFECTIVIDAD >= TRUNC(SYSDATE)							/o solo considera los del dia actual o/
		AND    P.COD_CLIENTE NOT IN (	SELECT COD_CLIENTE		         /o y que no esten como morosos o/
		                              FROM   CO_MOROSOS M
		                              WHERE  M.COD_CLIENTE = P.COD_CLIENTE ); */ 


		if( sqlca.sqlcode ) /* Fallo el Declare del Cursor */
		{
			ifnTrazasLog(modulo,"en DECLARE : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
			sprintf(szDescError,"en DECLARE cursor clientes exclusion %s",sqlca.sqlerrm.sqlerrmc);
			return -1; /*Mail*/
		}

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL OPEN curClientes_EXCLU ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlbuft((void **)0, 
    "select unique M.COD_CLIENTE ,M.NUM_IDENT ,M.COD_TIPIDENT ,M.TIP_MOROSO \
,:b0 ,:b1  from CO_MOROSOS M where M.TIP_MOROSO in (:b2,:b3) union all selec\
t unique M.COD_CLIENTE ,M.NUM_IDENT ,M.COD_TIPIDENT ,:b3 ,:b0 ,:b1  from CO_\
MOROSOS M ,GA_MODCLI G where (((((M.COD_CLIENTE=G.COD_CLIENTE and (M.TIP_MOR\
OSO||'') in (:b7,:b8)) and G.COD_TIPMODI=:b9) and G.FEC_MODIFICA>TRUNC(SYSDA\
TE)) and G.COD_CATEGORIA is null ) and G.COD_CLIENTE>0) union all select uni\
que M.COD_CLIENTE ,M.NUM_IDENT ,M.COD_TIPIDENT ,:b3 ,:b0 ,:b1  from CO_MOROS\
OS M ,GA_MODCLI G where (((((M.COD_CLIENTE=G.COD_CLIENTE and (M.TIP_MOROSO||\
'') in (:b7,:b8)) and G.COD_TIPMODI=:b15) and G.FEC_MODIFICA>TRUNC(SYSDATE))\
 and G.COD_CATEGORIA is  not null ) and G.COD_CLIENTE>0) union all select B.\
COD_CLIENTE ,B.NUM_IDENT ,B.COD_TIPIDENT ,:b3 ,:b0 ,:b1  from GAH_CATEG_DETP\
OSTULACION A ,GE_CLIENTES B ,GAH_CATEG_POSTULACION C ,CO_MOROSOS D where (((\
(((C.COD_ESTADO=:b19 and A.TIP_POSTULANTE=:b20) and C.FEC_RESPUESTA>TRUNC(SY\
SDATE)) and A.COD_POSTULANTE=B.COD_CUENTA");
  sqlstm.stmt = sq0017;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )622;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihIndProcedencia;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_C;
  sqlstm.sqhstl[3] = (unsigned long )2;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_C;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihIndProcedencia;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[7] = (unsigned long )2;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhNC;
  sqlstm.sqhstl[9] = (unsigned long )3;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_C;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihIndProcedencia;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[13] = (unsigned long )2;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[14] = (unsigned long )2;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhMC;
  sqlstm.sqhstl[15] = (unsigned long )3;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhLetra_C;
  sqlstm.sqhstl[16] = (unsigned long )2;
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)&ihIndProcedencia;
  sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhLetra_A;
  sqlstm.sqhstl[19] = (unsigned long )2;
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhLetra_M;
  sqlstm.sqhstl[21] = (unsigned long )2;
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)&ihIndProcedencia;
  sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[24] = (unsigned long )2;
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[25] = (unsigned long )2;
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)szhIniUltPeriodo;
  sqlstm.sqhstl[26] = (unsigned long )15;
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)szhYYYYMMDDHH24MISS;
  sqlstm.sqhstl[27] = (unsigned long )17;
  sqlstm.sqhsts[27] = (         int  )0;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[28] = (unsigned long )2;
  sqlstm.sqhsts[28] = (         int  )0;
  sqlstm.sqindv[28] = (         short *)0;
  sqlstm.sqinds[28] = (         int  )0;
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[29] = (         int  )0;
  sqlstm.sqindv[29] = (         short *)0;
  sqlstm.sqinds[29] = (         int  )0;
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
  sqlstm.sqhstv[30] = (unsigned char  *)&ihIndProcedencia;
  sqlstm.sqhstl[30] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[30] = (         int  )0;
  sqlstm.sqindv[30] = (         short *)0;
  sqlstm.sqinds[30] = (         int  )0;
  sqlstm.sqharm[30] = (unsigned long )0;
  sqlstm.sqadto[30] = (unsigned short )0;
  sqlstm.sqtdso[30] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode ) /* Error al Abrir el Cursor */
		{
			ifnTrazasLog(modulo,"en OPEN : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
			sprintf(szDescError,"Fallo en OPEN cursor clientes exclusion %s",sqlca.sqlerrm.sqlerrmc);
			return -1; /*Mail*/
		}

		lTotalRows = 0;

		while(1)
		{
		   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL FETCH curClientes_EXCLU INTO :sthClienteExclu; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )30000;
   sqlstm.offset = (unsigned int  )761;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)sthClienteExclu.lCodCliente;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )sizeof(long);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)sthClienteExclu.szNumIdent;
   sqlstm.sqhstl[1] = (unsigned long )21;
   sqlstm.sqhsts[1] = (         int  )21;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)sthClienteExclu.szCodTipIdent;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )3;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)sthClienteExclu.szCodTipClie;
   sqlstm.sqhstl[3] = (unsigned long )2;
   sqlstm.sqhsts[3] = (         int  )2;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)sthClienteExclu.dImportePago;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[4] = (         int  )sizeof(double);
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)sthClienteExclu.iProcedencia;
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
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



			iSqlAuxStatus = sqlca.sqlcode;

			if( iSqlAuxStatus != SQLOK && iSqlAuxStatus != SQLNOTFOUND )
			{
				ifnTrazasLog(modulo,"en FETCH :[%d] %s",LOG00, iSqlAuxStatus, sqlca.sqlerrm.sqlerrmc);
				sprintf(szDescError,"en FETCH cursor clientes exclusion ");
				ihFlgError = 1;/*NoMail*/
				break;
			}

			lTotalRows=SQLROWS;    /* Total de filas recuperadas */
			lRowsThisLoop = ( lTotalRows - lRowsProcessed );    /* filas recuperadas en esta iteracion (Total-Procesadas) */

			lCantTotal = lCantTotal + lTotalRows; /* Incorporado por PGonzalez 28-10-2004 MAS-04037 */
			if(ifnCargaLista(lTotalRows)!= 0) return -1; /* PGG incorporado el 25-10-2004 MAS-04037 */

			/* procesa solo los clientes recuperados en este fetch */
			ifnTrazasLog( modulo, "lTotalRows : %ld lRowsThisLoop : %ld", LOG05, lTotalRows, lRowsThisLoop );

			/* Se elimino el for...*/
			lRowsProcessed = lTotalRows-lhClientesError; /* Resetea Contador, Total las filas recuperadas se han procesado menos
			                                                los clientes que tuvieron error */
			if(iSqlAuxStatus == SQLNOTFOUND) {
				ifnTrazasLog( modulo, "Procesados => [%ld] Clientes de BD.", LOG03, lContCliBD );
				ihFlgError = 0;
				break; /* se terminaron los clientes de este punto de Gestion */
			}
		} /* endwhile */

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL CLOSE curClientes_EXCLU; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )800;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



		paux = stListaClientes->sgte;

	/*	Muestra_Lista(stListaClientes); */

/* ---------------------------------------------------------------------------------------- */
/* Inicio Hilos by PGG */

		strcpy(szhVigente, VIGENTE);
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* Rescatamos cantidad maxima de instancias en ejecucion */
		/* definidas por el usuario      			 */
		/* EXEC SQL
		SELECT  CNT_INSTANCIA_USR
		INTO    :ihNUM_INSTAN
		FROM    CO_INSTANCIA_TO
		WHERE   COD_PROCESO = :szhgCodProceso
		AND     ESTADO 	  = :szhVigente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select CNT_INSTANCIA_USR into :b0  from CO_INSTANCIA_TO whe\
re (COD_PROCESO=:b1 and ESTADO=:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )815;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihNUM_INSTAN;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhgCodProceso;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhVigente;
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



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
			ifnTrazasLog( modulo, "Error obteniendo INSTANCIAS %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
			return STATUS_ERR;
		}

		if (ihNUM_INSTAN==0) ihNUM_INSTAN=1;
		ifnTrazasLog( modulo, "\n\tINSTANCIAS  [%d].", LOG03, ihNUM_INSTAN);


		if (lCantTotal > 0 )
		{
			/****************************************************************************************/
			/*Calculamos la cantidad de nodos a pasar por cada hilo*/
			if ( (lCantTotal % ihNUM_INSTAN) ==0 )
				ihRAN_LISTAS=(lCantTotal/ihNUM_INSTAN);
			else
				ihRAN_LISTAS=(lCantTotal/ihNUM_INSTAN)+1;

			ifnTrazasLog( modulo, "Cantidad Clientes a Evaluar por Hilo [%d]\n", LOG03,ihRAN_LISTAS);
			/****************************************************************************************/
			/* De acuerdo al rango se segmenta la lista 	*/
			if (ifnSeccionaLista(lCantTotal) !=0 ) return STATUS_ERR;

			/****************************************************************************************/
			/* ejecutamos los hilos de acuerdo a la vble ihNUM_INSTAN*/
			if (ifnEjecutaHilos() != 0)
			{
				sprintf(szDescError,"en ifnEjecutaHilos\n");
				return STATUS_ERR;
			}
		}
		else
		{
			ifnTrazasLog( modulo, "No existen clientes por procesar.", LOG02);
		}

		/* vfnEliminaNodoAccion(&stListaAcCM); */
		/* Destruir_lista(&stListaClientes);   */
		Destruir_lista(&stListaClientes);

		/* ---------------------------------------------------------------------------------------- */
		/* Fin Hilos by PGG */
    } /* if( ihFlgError == 1 ) */

	/* ------------------------------------------------------------------------- */
	/* Señala Termino del procesamiento real                                     */
	/* ------------------------------------------------------------------------- */
	sprintf(szFinProc,"%s",szSysDate("HH24:MI:SS"));

	/* ------------------------------------------------------------------------- */
	/* Informacion Estadistica                                                   */
	/* ------------------------------------------------------------------------- */
	if ( lContCliBD > 0 )	{
		/* Requerimiento de Soporte - #71598 17-10-2008 mgg */		
		ifnTrazasLog( modulo, "\n\t RESUMEN PROCESO EXCLUSION DE CLIENTES"
							  "\n\t TOTAL CLIENTES REVISADOS = %ld (%ld)"
							  , EST00, lContClientesRev + lContCliBD, lContCliBD );

		if( ( iDifSegs = ifnRestaHoras( szIniProc, szFinProc, szTmpProc ) ) >= 0 )		
		{
			ifnTrazasLog( modulo, "\n\t HORA INICIO  : %s "
								  "\n\t HORA TERMINO : %s "
								  "\n\t TIEMPO TOTAL : %s  (%d segs)"
								  "\n\t PROMEDIO x CLIENTE : %.5f segs \n"
								  , EST00, szIniProc, szFinProc, szTmpProc, iDifSegs,
								  (float)( (float) iDifSegs / (float)(lContClientesRev + lContCliBD ) ) );
		}
	}

	/* ------------------------------------------------------------------------- */
  	/* Finzaliza Funcion ifnExcluyeClientes							 		           */
	/* ------------------------------------------------------------------------- */
	ifnTrazasLog( modulo, "Saliendo de %s", LOG05, modulo );

	ifnBorraRev(&Lista_aux);

	if( ihFlgError ) /* !=0 ocurrio un error */
		return ihFlgError;

	Destruir_lista(&stListaClientes); /* Incorporado por PGonzalez 27-10-2004 */

	return 0;
} /* fin de  ifnExcluyeClientes  */

/*******************************************************************************/
void Muestra_Lista(stLista lstListaCli)
{
	stLista paux;

	paux = lstListaCli->sgte;

	while (paux != NULL)
	{
		printf ("paux->Campo.lCod_Cliente  [%ld]\n", paux->Campo.lCod_Cliente  );
		printf ("paux->Campo.szNum_Ident   [%s] \n", paux->Campo.szNum_Ident   );
		printf ("paux->Campo.szCod_Tipident[%s] \n", paux->Campo.szCod_Tipident);
		printf ("paux->Campo.szCodTipClie  [%s] \n", paux->Campo.szCodTipClie  );
		printf ("paux->Campo.dImportePago  [%f] \n", paux->Campo.dImportePago  );
		printf ("paux->Campo.iProcedencia  [%ld]\n", paux->Campo.iProcedencia  );
		printf ("-------------------------------\n", paux->Campo.iProcedencia  );
		paux = paux->sgte;
	}
}


/* ============================================================================= */
/* ifnProcesaPago() : Procesa la informacion del arreglo de clientes y pagos     */
/* ============================================================================= */
int ifnProcesaPago(FILE **ptArchLog ,int iPos, long lCliente, char *szIdent, char *szTipIdent, char *szTipClie, double dPago, int *iSqlAuxStatus, long *lCont, char *szDescError, int iProcedencia, sql_context ctxCont)
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente = lCliente ;
	char	szhNumIdent[iLENNUMIDENT]="";
	char	szhCodTipIdent[3]="";
	char	szhCodTipClie[2]="";
	double	dhImpDeudaVenc = 0.0 ;
	double	dhImpDeudaNoVenc = 0.0 ;
	char	szhFecVencimie[9]="";		/* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 

	char	szhCodMovimiento[5]="";
	int	ihReversasPend = 0;
	int	ihTipExclusion = 0;
	int	ihSecMoroso = 0;
	int	ihNumProceso = 0;
	int	ihNumDias = 0;
	int ihValor_cero = 0;
	int ihValor_uno = 1;
	char	szh_UsuarioCobros[31];		/* EXEC SQL VAR szh_UsuarioCobros IS STRING(31); */ 

	char  szhUsuario[15];
	char  szhMovimSM     [3];
	char  szhLetra_I     [2];
	char  szhLetra_G     [2];
	char  szhLetra_V     [2];
	char  szhLetra_B     [2];
	char  szhLetra_P     [2];
	char  szhLetra_C     [2];
	char  szhLetra_N     [2];
	char  szhLetra_E     [2];
	char  szhLetra_R     [2];
	char  szhLetra_M     [2];
    char  szhEPR         [4];
	char  szhCodPtoGest[6]="";	/* CH-200408232102 Homologado por PGonzalez 23-11-2004  */
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnProcesaPago";
int	ihFlgActiva = 0, iLong, rr;
long	sts = 0;
int	iNumDias = 0;
sql_context CXX;
struct sqlca sqlca;

FILE *pfLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	pfLog = *ptArchLog;
	ifnTrazaHilos( modulo, &pfLog, "\n\tIngreso modulo : [%s].", LOG03, modulo );

	strcpy(szhNumIdent, szIdent );
	strcpy(szhUsuario,"USUARIO_COBROS");
	strcpy(szhMovimSM,"SM");
	strcpy(szhEPR,"EPR");
	strcpy(szhLetra_I,"I");
	strcpy(szhLetra_G,"G");
	strcpy(szhLetra_V,"V");
	strcpy(szhLetra_B,"B");
	strcpy(szhLetra_P,"P");
	strcpy(szhLetra_C,"C");
	strcpy(szhLetra_N,"N");
	strcpy(szhLetra_E,"E");
	strcpy(szhLetra_R,"R");
	strcpy(szhLetra_M,"M");

	iCumpleCriterio = 0; /**** XO-200510100830 12.10.2005 *****/

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT VAL_PARAMETRO
	INTO  :szh_UsuarioCobros
	FROM  GED_PARAMETROS
	WHERE NOM_PARAMETRO = :szhUsuario
	AND   COD_MODULO = :szhCod_Modulo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where (NO\
M_PARAMETRO=:b1 and COD_MODULO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )842;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szh_UsuarioCobros;
 sqlstm.sqhstl[0] = (unsigned long )31;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhUsuario;
 sqlstm.sqhstl[1] = (unsigned long )15;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Modulo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode)
	{
		ifnTrazaHilos( modulo, &pfLog, "Al recuperar parametro USUARIO_COBROS (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	/* right trim  de los valores de retorno esperado y valor de rango definido */
	iLong = strlen( szhNumIdent ) - 1;
	for( rr = iLong; rr >= 0; rr = rr - 1 ) if( szhNumIdent[rr] != ' ' ) break ;
	szhNumIdent[rr + 1] = '\0';

	strcpy( szhCodTipIdent, szTipIdent );
	strcpy( szhCodTipClie, szTipClie );

	ifnTrazaHilos( modulo, &pfLog, "Evaluo el Cliente j=[%d]:[%ld]:[%s]:[$%.f]:[%s]:[%s]", LOG03, iPos, lhCodCliente, szhCodTipClie, dPago, szhNumIdent, szhCodTipIdent );

	/*-Si el cliente es procesado por cambio de categoria, se marca bGeneraCargos a falso -*/
	/*-para evitar que se le genere cargo por reposicion, en la funcion lfnExcluyeAcciones-*/
	/*-cuando se procesen las acciones, en caso contrario es TRUE. MGG 27-02-2001		  -*/

	if(( strcmp ( szhCodTipClie, "C" ) == 0 ) || ( strcmp ( szhCodTipClie, "R" ) == 0 )) /* es cambio Categoria o Reprocesado Homolog. PR-0330 (GAC 12-05-2204)*/
	{
		bGeneraCargos = FALSE;
		ifnTrazaHilos( modulo, &pfLog, "CLIENTE => [%ld], PROCESADO POR CAMBIO DE CATEGORIA.", LOG05, lhCodCliente );
	}
	else
	{
		bGeneraCargos = TRUE;
	}


	if( !bfnValidaColaActivaContex(&pfLog, szhgCodProceso, &ihFlgActiva, CXX ) )      /* valida si cola esta activa */
	{
		ifnTrazaHilos( modulo, &pfLog, "Fallo la Verificacion de la cola", LOG05 );
		sprintf( szDescError, "Fallo la Verificacion de la cola" );
		*iSqlAuxStatus = SQLNOTFOUND; /* no ver mas clientes */

		return -1; /* termina anormal */
	}
   	else
   	{

		if( !ihFlgActiva )/* Si se pudo verificar la Cola, pero esta No está Activa */
		{
			ifnTrazaHilos( modulo, &pfLog,  "Se Verifico que la Cola esta Inactiva", LOG05 );
			*iSqlAuxStatus = SQLNOTFOUND; /* no ver mas clientes */
			return 0; /* termina normal */
		}
		else /* Se pudo verificar la Cola y esta se encuentra activa*/
		{
			ifnTrazaHilos( modulo, &pfLog, "Se Verifico que la Cola aun esta Activa", LOG05 );
			/* sigue adelante */
		}
   	}

	*lCont = *lCont + 1 ; /* aumenta el contador de clientes revisados */

/*	strcpy(szhCodTipClie, "M"); * Eliminar luego PGG */ /*38400 08-03-2007 Soporte RyC se comenta línea*/
	if( !strcmp( szhCodTipClie, "M" ) || !strcmp( szhCodTipClie,"C" ) || !strcmp( szhCodTipClie,"R" ))	/* Moroso o Categoria o Reprocesado Homolog. PR-0330 (GAC 12-05-2204)*/
	{
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* valida si tiene acciones REVERSAS pendientes de Ejecucion jlr_01.12.00 */
		/* EXEC SQL
		SELECT	COUNT(*)							/o Busca la secuencia de las o/
		INTO	:ihReversasPend
		FROM	CO_RUTINAS R,CO_ACCIONES A
		WHERE	A.COD_CLIENTE = :lhCodCliente		/o Acciones asociadas al cliente o/
		AND	(A.COD_ESTADO  = :szhPND					/o que esten pendientes o/
		 OR	A.COD_ESTADO   = :szhEPR)					/o que esten en proceso o/
		AND	R.COD_RUTINA   = A.COD_RUTINA			/o join o/
		AND	R.TIP_RUTINA   = :szhLetra_R; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(*)  into :b0  from CO_RUTINAS R ,CO_ACCIONES A\
 where (((A.COD_CLIENTE=:b1 and (A.COD_ESTADO=:b2 or A.COD_ESTADO=:b3)) and R.\
COD_RUTINA=A.COD_RUTINA) and R.TIP_RUTINA=:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )869;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihReversasPend;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[2] = (unsigned char  *)szhPND;
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhEPR;
  sqlstm.sqhstl[3] = (unsigned long )4;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_R;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

					/* y que sean Reversa */
		if( sqlca.sqlcode != SQLOK )
		{
			ifnTrazaHilos( modulo, &pfLog, "al revisar acciones pendientes del cliente %ld : %s", LOG00, lCliente, sqlca.sqlerrm.sqlerrmc );
			return 1; /* continuar con el sgte cliente */
		}
		else if( ihReversasPend > 0 )
		{
			ifnTrazaHilos( modulo, &pfLog, "El cliente %ld tiene acciones Reversas pendientes de ejecucion.", LOG03, lCliente );
			return 1; /* continuar con el sgte cliente */
		}

		if( !bfnGetSaldoClienteAcc( &pfLog, lCliente, &dhImpDeudaVenc, &dhImpDeudaNoVenc, szhFecVencimie, CXX) )	/* Obtiene los Saldos del Cliente */
		{

			return 1;  /* Error, continuar con el sgte cliente */
		}

		ifnTrazaHilos( modulo, &pfLog, "Importe Deuda Vencida $%.f.- ", LOG05, dhImpDeudaVenc );

		ifnTrazaHilos( modulo, &pfLog, "dPago [%ld] \n", LOG05, dPago );
		ifnTrazaHilos( modulo, &pfLog, "szhCodTipClie	[%s]\n", LOG05, szhCodTipClie);

		if( ( dhImpDeudaVenc - dPago <= 0.0 ) || !strcmp( szhCodTipClie, "C" ) ) /* No tiene Deuda Vencida o es Cambio de Categoria */
		{
			ihTipExclusion = 1; 	/* se excluye totalmente */
		}
		else
		{
			if( dPago > 0.0 )		  /* Si se trata de un pago por archivo y no paga toda la deuda */
				return 1; 			  /* no se procesa (eossando 14.12.00), continuar alegremente con el sgte cliente */
			else					     /* pago de la co_pagos */
				ihTipExclusion = 0; /* se excluye parcialmente */
		} /* endif MtoDeuda */

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		UPDATE CO_MOROSOS  SET
			TIP_MOROSO = DECODE( :szhCodTipClie, :szhLetra_C, :szhCodTipClie, DECODE(NOM_USUARIO, :szh_UsuarioCobros, :szhLetra_N, :szhLetra_P) )
		WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_MOROSOS  set TIP_MOROSO=DECODE(:b0,:b1,:b0,DECODE\
(NOM_USUARIO,:b3,:b4,:b5)) where COD_CLIENTE=:b6";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )904;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipClie;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhLetra_C;
  sqlstm.sqhstl[1] = (unsigned long )2;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipClie;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szh_UsuarioCobros;
  sqlstm.sqhstl[3] = (unsigned long )31;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_P;
  sqlstm.sqhstl[5] = (unsigned long )2;
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
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "en UPDATE TIP_MOROSO del cliente %ld : %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
			/* EXEC SQL ROLLBACK; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )947;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* deshacer el update */
			return 1; /* continuar con el sgte cliente */
		}
		else if( sqlca.sqlcode == SQLNOTFOUND )
		{
			if( dPago > 0.0 ) /* Si se trata de un pago por archivo */
				ifnTrazaHilos( modulo, &pfLog, "Cliente %ld de archivo CTC No encontrado en CO_MOROSOS.", LOG05, lhCodCliente );
			else
				ifnTrazaHilos( modulo, &pfLog, "Cliente %ld ya fue excluido.", LOG05, lhCodCliente );

			return 1; /* continuar con el sgte cliente */
		}

		/* llamada a la funcion que excluye al cliente */
		sts = ifnExcluyeAcciones( &pfLog, ihTipExclusion, lCliente, szhFecVencimie, &iNumDias, CXX );  /* PGG ACTIVA DESPUES */
	    ifnTrazaHilos( modulo, &pfLog, "iNumDias despues ExcluyeAcciones  <%d> ",LOG05,iNumDias); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

		/* 38400 08-03-2007 rvr Soporte RyC */
		if( strcmp ( szhCodTipClie, "C" ) == 0 )
		{
			/*ifnTrazasLog(modulo,"Se hace exclusion Total del cliente %ld, pq es un cambio de categoria.",LOG02,lhCodCliente); Requerimiento de Soporte 77546 */
			ifnTrazaHilos( modulo, &pfLog, "Se hace exclusion Total del cliente %ld, pq es un cambio de categoria.",LOG02,lhCodCliente);
                        sts = 0;
		}

	       /* ifnTrazasLog(modulo,"Resultado de ExcluyeAcciones sts <%d> ",LOG05,sts); Requerimiento de Soporte 77546 */
	       ifnTrazaHilos( modulo, &pfLog, "Resultado de ExcluyeAcciones sts <%d> ",LOG05,sts);
               /*FIN 38400 08-03-2007 rvr Soporte RyC */


		/*if( sts < 0 )*/
		if( sts == -99 )   /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
		{
			/*ifnTrazasLog(modulo,"No se Excluye el cliente %ld. Se continua con el siguiente cliente.",LOG01,lhCodCliente);*/
			ifnTrazaHilos( modulo, &pfLog, "No se Excluye el cliente %ld. Se continua con el siguiente cliente.",LOG02,lhCodCliente);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )962;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			return 1; /* continuar con el sgte cliente */
		} /* endif resultado Accion */
		else if( sts < 0 )  /*Fin XO-200508090319  09-08-2005. Soporte RyC PRM. */
		{
			ifnTrazaHilos( modulo, &pfLog, "No se realizo la Exclusion del cliente %ld",LOG02,lhCodCliente);
		   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			UPDATE CO_MOROSOS  SET
			       TIP_MOROSO = DECODE( :szhCodTipClie, :szhLetra_C, :szhCodTipClie, DECODE(NOM_USUARIO, :szh_UsuarioCobros, :szhLetra_N, :szhLetra_P) )
			WHERE COD_CLIENTE = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_MOROSOS  set TIP_MOROSO=DECODE(:b0,:b1,:b0,DECOD\
E(NOM_USUARIO,:b3,:b4,:b5)) where COD_CLIENTE=:b6";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )977;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipClie;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhLetra_C;
   sqlstm.sqhstl[1] = (unsigned long )2;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipClie;
   sqlstm.sqhstl[2] = (unsigned long )2;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szh_UsuarioCobros;
   sqlstm.sqhstl[3] = (unsigned long )31;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_N;
   sqlstm.sqhstl[4] = (unsigned long )2;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_P;
   sqlstm.sqhstl[5] = (unsigned long )2;
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
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( sqlca.sqlcode )
				ifnTrazaHilos( modulo, &pfLog, "En UPDATE TIP_MOROSO a 'N' del cliente %ld : %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );

			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1020;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			return 1; /* continuar con el sgte cliente */
		} /* endif resultado Accion */

		if( ihTipExclusion == 0 || sts > 0 )	/* exclusion parcial o una de las Reversas fallo */
		{
			ifnTrazaHilos( modulo, &pfLog, "Se Excluye parcialmente Cliente [%ld]", LOG03,lhCodCliente);
			ifnTrazaHilos( modulo, &pfLog, "iNumDias [%d]", LOG03,iNumDias);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
			ihNumDias = iNumDias;

			/* recalcula Sec. Moroso a partir de los dias de deuda */
			/* y lo compara con el Sec.Moroso actual, dejando el MENOR */

	      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			SELECT NVL( MIN( M.SEC_MOROSO ), :ihValor_cero ), NVL( MAX( P.NUM_PROCESO ) ,:ihValor_cero )
			INTO :ihSecMoroso, :ihNumProceso
			/oFROM CO_PTOSRUTINAS P, CO_MOROSOS Mo/
			FROM CO_PTOSRUTINAS P, CO_MOROSOS M, CO_PTOSGESTION G /o XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 o/
			WHERE M.COD_CLIENTE = :lhCodCliente
			AND P.COD_CATEGORIA = M.COD_CATEGORIA
			AND P.NUM_DIAS <= :ihNumDias
			AND M.SEC_MOROSO > :ihValor_cero
			AND G.COD_PTOGEST = P.COD_PTOGEST     /o XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 o/
			AND G.COD_ESTADO = 'H' ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(min(M.SEC_MOROSO),:b0) ,NVL(max(P.NUM_PROCESO),\
:b0) into :b2,:b3  from CO_PTOSRUTINAS P ,CO_MOROSOS M ,CO_PTOSGESTION G where\
 (((((M.COD_CLIENTE=:b4 and P.COD_CATEGORIA=M.COD_CATEGORIA) and P.NUM_DIAS<=:\
b5) and M.SEC_MOROSO>:b0) and G.COD_PTOGEST=P.COD_PTOGEST) and G.COD_ESTADO='H\
')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1035;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihSecMoroso;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihNumProceso;
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
   sqlstm.sqhstv[5] = (unsigned char  *)&ihNumDias;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_cero;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

			  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

			ifnTrazaHilos( modulo, &pfLog, "ihSecMoroso [%d]", LOG03,ihSecMoroso);   /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
			ifnTrazaHilos( modulo, &pfLog, "ihNumProceso [%d]", LOG03,ihNumProceso); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
			{
				ifnTrazaHilos( modulo, &pfLog, "Calculando SEC_MOROSO : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
				/* EXEC SQL ROLLBACK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1078;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* deshacer el update */
				return 1;
			}

			if (ihSecMoroso < ihNumProceso) ihNumProceso = ihSecMoroso;

			/* Se extrae COD_PTOGEST para actualizar tabla CO_MOROSOS 17.08.2004 TM-885 CAPC*/
			/* CH-200408232102 Homologado por PGonzalez 23-11-2004 query completa */
	      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			SELECT P.COD_PTOGEST
			  INTO :szhCodPtoGest
			  FROM CO_PTOSGESTION P, CO_MOROSOS M
			 WHERE M.COD_CLIENTE = :lhCodCliente
			   AND P.NUM_PROCESO = :ihNumProceso
			   AND P.COD_CATEGORIA = M.COD_CATEGORIA; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select P.COD_PTOGEST into :b0  from CO_PTOSGESTION P ,CO_M\
OROSOS M where ((M.COD_CLIENTE=:b1 and P.NUM_PROCESO=:b2) and P.COD_CATEGORIA=\
M.COD_CATEGORIA)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1093;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodPtoGest;
   sqlstm.sqhstl[0] = (unsigned long )6;
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
   sqlstm.sqhstv[2] = (unsigned char  *)&ihNumProceso;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
			{
			   ifnTrazaHilos( modulo, &pfLog, "Sacando COD_PTOGEST : %s",LOG00, sqlca.sqlerrm.sqlerrmc);
			   /* EXEC SQL ROLLBACK; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 31;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1120;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* deshacer el update */
			   return 1;
			}

			/*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia TM-200503291318 */
			if( SQLCODE == SQLNOTFOUND )
			{
				strcpy(szhCodPtoGest,"MOROS");
			}

			/* actualiza Sec.Moroso, Saldos y Fecha de Vencimiento del Cliente */

			/*ifnTrazaHilos( modulo, &pfLog, "Update CO_MOROSOS : SecMoroso [%d] NumProceso [%d] deu.vencida[%.f] deu.novenc[%.f] fec.Vencimie[%s] szhCodPtoGest[%s]",LOG04,
			ihSecMoroso, ihNumProceso, dhImpDeudaVenc, dhImpDeudaNoVenc, szhFecVencimie, szhCodPtoGest); * CH-200408232102 Homologado por PGonzalez 23-11-2004  */

			/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200505201419 y TM-200507181494
			Se Imprimen en orden y se agrega el punto de gestion a actualizar*/
			ifnTrazaHilos( modulo, &pfLog, "<<<<< ======================================================================================= >>>>>", LOG03);
			ifnTrazaHilos( modulo, &pfLog, "\tActualizando CO_MOROSOS (Pto de Gestion     [%s])",  LOG03,szhCodPtoGest);
			ifnTrazaHilos( modulo, &pfLog, "\tActualizando CO_MOROSOS (Sec Moroso anterior[%d])", LOG03, ihSecMoroso);
			ifnTrazaHilos( modulo, &pfLog, "\tActualizando CO_MOROSOS (Sec Moroso actual  [%d])", LOG03, ihNumProceso);
			ifnTrazaHilos( modulo, &pfLog, "\tActualizando CO_MOROSOS (Deuda Vencida      [%.f])", LOG03, dhImpDeudaVenc);
			ifnTrazaHilos( modulo, &pfLog, "\tActualizando CO_MOROSOS (Deuda no Vencida   [%.f])", LOG03, dhImpDeudaNoVenc);
			ifnTrazaHilos( modulo, &pfLog, "\tActualizando CO_MOROSOS (Fecha Vencimiento  [%s])\n",LOG03, szhFecVencimie);
			/*FIN XO-200508090319  09-08-2005. Soporte RyC PRM. */

			/* transformamos decimales segun definicion para la operadora tratada */

			ifnTrazaHilos( modulo, &pfLog, "Valores antes de transformer dhImpDeudaVenc = [%.4f], dhImpDeudaNoVenc = [%.4f].", LOG05, dhImpDeudaVenc, dhImpDeudaNoVenc );

			dhImpDeudaVenc = fnCnvDouble( dhImpDeudaVenc, 0 );
			dhImpDeudaNoVenc = fnCnvDouble( dhImpDeudaNoVenc, 0 );

			ifnTrazaHilos( modulo, &pfLog, "Valores despues de transformer dhImpDeudaVenc = [%.4f], dhImpDeudaNoVenc = [%.4f].", LOG05, dhImpDeudaVenc, dhImpDeudaNoVenc );

	      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			UPDATE CO_MOROSOS SET
			      TIP_MOROSO = DECODE( :szhCodTipClie, :szhLetra_C, :szhCodTipClie,	/o Conserva cambio de categoria o/
  				   /o Homolog. PR-0330 (GAC 12-05-2204) o/
  				   DECODE( :ihTipExclusion, :ihValor_uno, :szhLetra_E, DECODE(NOM_USUARIO, :szh_UsuarioCobros, :szhLetra_N, :szhLetra_P)) ),
				   SEC_MOROSO = :ihNumProceso,
				   DEU_VENCIDA = :dhImpDeudaVenc,
				   DEU_NOVENC = :dhImpDeudaNoVenc,
				   /oFEC_DEUDVENC = TO_DATE( :szhFecVencimie, 'YYYYMMDD' )o/
				   FEC_DEUDVENC = TO_DATE( :szhFecVencimie, :szhYYYYMMDD ),  	/o CH-200408232102  Homologado por PGonzalez 23-11-2004 o/
				   COD_PTOGEST  = :szhCodPtoGest                                /o CH-200408232102  Homologado por PGonzalez 23-11-2004 o/
			WHERE COD_CLIENTE = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_MOROSOS  set TIP_MOROSO=DECODE(:b0,:b1,:b0,DECOD\
E(:b3,:b4,:b5,DECODE(NOM_USUARIO,:b6,:b7,:b8))),SEC_MOROSO=:b9,DEU_VENCIDA=:b1\
0,DEU_NOVENC=:b11,FEC_DEUDVENC=TO_DATE(:b12,:b13),COD_PTOGEST=:b14 where COD_C\
LIENTE=:b15";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1135;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipClie;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhLetra_C;
   sqlstm.sqhstl[1] = (unsigned long )2;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipClie;
   sqlstm.sqhstl[2] = (unsigned long )2;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihTipExclusion;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_uno;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_E;
   sqlstm.sqhstl[5] = (unsigned long )2;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szh_UsuarioCobros;
   sqlstm.sqhstl[6] = (unsigned long )31;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_N;
   sqlstm.sqhstl[7] = (unsigned long )2;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_P;
   sqlstm.sqhstl[8] = (unsigned long )2;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihNumProceso;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&dhImpDeudaVenc;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&dhImpDeudaNoVenc;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhFecVencimie;
   sqlstm.sqhstl[12] = (unsigned long )9;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhYYYYMMDD;
   sqlstm.sqhstl[13] = (unsigned long )9;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhCodPtoGest;
   sqlstm.sqhstl[14] = (unsigned long )6;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
			{
				ifnTrazaHilos( modulo, &pfLog, "En Update CO_MOROSOS [%ld] : %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );

				/* EXEC SQL ROLLBACK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1214;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* deshacer TODO */

				return 1;
			}

			/* debemos actualizar el codigo de gestion del cliente */
			if( !bfnFindNewCodGestionContex(&pfLog, lhCodCliente, 0, CXX) )
			{

				/* EXEC SQL ROLLBACK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1229;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* deshacer TODO */

				return 1;
			}
		}
		else /* si es una exclusion total y No hay errores en las Reversas */
		{
			ifnTrazaHilos( modulo, &pfLog, "Se Excluye totalmente Cliente [%ld]", LOG03,lhCodCliente);

			/* verificamos si el cliente debe pasar a historicos y si es asi lo pasamos */
			if( !bfnPasoHistoricoGeneralContex( &pfLog, lhCodCliente, ihTipExclusion, CXX ) )
				return -1;		 /*NoMail */

		} /* ihTipExclusion */
	}


	if( iProcedencia == 1 ) /* Si el pago procesado viene de la base de datos, sea Moroso o Cob. Externa o Dicom */
	{

	   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		SELECT COD_MOVIMIENTO
		INTO  :szhCodMovimiento
		FROM  CO_COBEXTERNA
		WHERE NUM_IDENT     = :szhNumIdent
		AND   COD_TIPIDENT  = :szhCodTipIdent
		AND   COD_CLIENTE   = DECODE( COD_CLIENTE, :ihValor_cero, :ihValor_cero, :lhCodCliente ) /oGAC 29-05-03. Sale COD_CLIENTE , entra  :lhCodCliente o/
		AND   COD_MOVIMIENTO= :szhMovimSM
		AND   COD_ENVIO NOT IN ( :szhLetra_B, :szhLetra_R, :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_E, :szhLetra_N ) /o Baja:Reasignado:Ingresado:Generado:Visado o/
		FOR UPDATE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_MOVIMIENTO into :b0  from CO_COBEXTERNA where ((\
((NUM_IDENT=:b1 and COD_TIPIDENT=:b2) and COD_CLIENTE=DECODE(COD_CLIENTE,:b3,:\
b3,:b5)) and COD_MOVIMIENTO=:b6) and COD_ENVIO not  in (:b7,:b8,:b9,:b10,:b11,\
:b12,:b13)) for update ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1244;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodMovimiento;
  sqlstm.sqhstl[0] = (unsigned long )5;
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
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
  sqlstm.sqhstl[2] = (unsigned long )3;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[6] = (unsigned char  *)szhMovimSM;
  sqlstm.sqhstl[6] = (unsigned long )3;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_B;
  sqlstm.sqhstl[7] = (unsigned long )2;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhLetra_I;
  sqlstm.sqhstl[9] = (unsigned long )2;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_G;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_V;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[13] = (unsigned long )2;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "Select CO_COBEXTERNA : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		}
		else if( sqlca.sqlcode != SQLNOTFOUND )
		{

	      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			UPDATE CO_COBEXTERNA SET
			      COD_MOVIMIENTO = :szhLetra_M ,
			      FEC_MOVIMIENTO = SYSDATE
			WHERE NUM_IDENT     = :szhNumIdent
			AND   COD_TIPIDENT  = :szhCodTipIdent
		   	AND   COD_CLIENTE   = DECODE( COD_CLIENTE, :ihValor_cero, :ihValor_cero, :lhCodCliente ) /oGAC 29-05-03. Sale COD_CLIENTE , entra  :lhCodCliente o/
			AND   COD_MOVIMIENTO= :szhMovimSM
			AND   COD_ENVIO NOT IN ( :szhLetra_B, :szhLetra_R, :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_E, :szhLetra_N ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_COBEXTERNA  set COD_MOVIMIENTO=:b0,FEC_MOVIMIENT\
O=SYSDATE where ((((NUM_IDENT=:b1 and COD_TIPIDENT=:b2) and COD_CLIENTE=DECODE\
(COD_CLIENTE,:b3,:b3,:b5)) and COD_MOVIMIENTO=:b6) and COD_ENVIO not  in (:b7,\
:b8,:b9,:b10,:b11,:b12,:b13))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1315;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_M;
   sqlstm.sqhstl[0] = (unsigned long )2;
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
   sqlstm.sqhstv[6] = (unsigned char  *)szhMovimSM;
   sqlstm.sqhstl[6] = (unsigned long )3;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_B;
   sqlstm.sqhstl[7] = (unsigned long )2;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_R;
   sqlstm.sqhstl[8] = (unsigned long )2;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhLetra_I;
   sqlstm.sqhstl[9] = (unsigned long )2;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_G;
   sqlstm.sqhstl[10] = (unsigned long )2;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_V;
   sqlstm.sqhstl[11] = (unsigned long )2;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhLetra_E;
   sqlstm.sqhstl[12] = (unsigned long )2;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_N;
   sqlstm.sqhstl[13] = (unsigned long )2;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* Baja:Reasignado:Ingresado:Generado:Visado */


			if( sqlca.sqlcode )
				ifnTrazaHilos( modulo, &pfLog, "Update CO_COBEXTERNA : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		}


	   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		SELECT UNIQUE C.COD_MOVIMIENTO
		INTO  :szhCodMovimiento
		FROM  CO_DICOMDOC D, CO_DICOM C
		WHERE C.NUM_IDENT = :szhNumIdent
		AND   C.COD_TIPIDENT = :szhCodTipIdent
		AND   C.COD_MOVIMIENTO = :szhMovimSM
		AND   C.COD_ENVIO <> :szhLetra_B
		AND	C.NUM_IDENT = D.NUM_IDENT
		AND   C.COD_TIPIDENT = D.COD_TIPIDENT
		AND   D.COD_CLIENTE = :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select unique C.COD_MOVIMIENTO into :b0  from CO_DICOMDOC D\
 ,CO_DICOM C where ((((((C.NUM_IDENT=:b1 and C.COD_TIPIDENT=:b2) and C.COD_MOV\
IMIENTO=:b3) and C.COD_ENVIO<>:b4) and C.NUM_IDENT=D.NUM_IDENT) and C.COD_TIPI\
DENT=D.COD_TIPIDENT) and D.COD_CLIENTE=:b5)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1386;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodMovimiento;
  sqlstm.sqhstl[0] = (unsigned long )5;
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
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
  sqlstm.sqhstl[2] = (unsigned long )3;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhMovimSM;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_B;
  sqlstm.sqhstl[4] = (unsigned long )2;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "Select CO_DICOM : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		}
		else if ( sqlca.sqlcode != SQLNOTFOUND )
		{

	      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			UPDATE CO_DICOM SET
			       COD_MOVIMIENTO = :szhLetra_M ,
			       FEC_MOVIMIENTO = SYSDATE
			WHERE	 NUM_IDENT = :szhNumIdent
			AND	 COD_TIPIDENT = :szhCodTipIdent
			AND	 COD_MOVIMIENTO = :szhMovimSM
			AND	 COD_ENVIO <> :szhLetra_B; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_DICOM  set COD_MOVIMIENTO=:b0,FEC_MOVIMIENTO=SYS\
DATE where (((NUM_IDENT=:b1 and COD_TIPIDENT=:b2) and COD_MOVIMIENTO=:b3) and \
COD_ENVIO<>:b4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1425;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_M;
   sqlstm.sqhstl[0] = (unsigned long )2;
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhMovimSM;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_B;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




			if( sqlca.sqlcode )
				ifnTrazaHilos( modulo, &pfLog, "Update CO_DICOM : %s",LOG00,sqlca.sqlerrm.sqlerrmc);

		}
	} /* endif pagos procedencia interna */

	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1460;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




	if( sqlca.sqlcode )
	{
		ifnTrazaHilos( modulo, &pfLog, "en Commit del cliente evaluado : %s", LOG00, sqlca.sqlerrm.sqlerrmc );
		sprintf( szDescError, "en Commit del cliente %ld evaluado", lCliente );

		/* EXEC SQL ROLLBACK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1475;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		*iSqlAuxStatus = SQLNOTFOUND; /* no ver mas clientes */
		return -1;
	}

	ifnTrazaHilos( modulo, &pfLog, "La Exclusion del cliente %ld fue exitosa", LOG05, lhCodCliente );

	return 1; /* continuar con el sgte cliente */
} /* fin de ifnProcesaPago() */


/* ============================================================================= */
/* ifnExcluyeAcciones                                                            */
/* ============================================================================= */
int ifnExcluyeAcciones( FILE **ptArchLog, int iExclTotal, long lCodCli, char *szFecDeudVenc, int *iNumeroDias, sql_context ctxCont )
/*--------------------------------------------------------------------------------------------
Parametros
iExclTotal        	1
Exclusion Parcial.   0
lCodCli				Codigo de cliente procesado.
*szFecDeudVenc		Fecha deuda vencida.
*iNumeroDias		Guarda el valor del nuevo numero de días
para aplicar nuevo Pto Gestion al cliente
en la seccion principal del Proceso.
--------------------------------------------------------------------------------------------*/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodAcc [6];				/* EXEC SQL VAR szhCodAcc IS STRING(6); */ 

	long	lhCodCliente = lCodCli;
	long	lhNumSeq = 0;
	char	szhRet[6] = "";				/* EXEC SQL VAR szhRet IS STRING(6); */ 
   /* Valor de Retorno de la Accion */

	char	szhQuery[2000] = "";
	int	ihAboCeluGlobal=0;
	int	ihAboBeepGlobal=0;

	char  szhCodParam [16];
	char  szhCodCateg [16];
	char  szhENRUT  [6];
	char  szhCANUM  [6];
	int   ihNumerodias ;

/* EXEC SQL END DECLARE SECTION; */ 

char  modulo[] = "ifnExcluyeAcciones";
int	i, k, iAccionEjecutada, iTotAcciones = 0, iError = 0, iErrRev = 0, iNumDias=0;
char	*pszRet;
char	szRevAnterior[6] = "";
char	szEstado[6] = "";
struct sqlca sqlca;
sql_context CXX;

FILE *pfLog;

	pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	memset( szhQuery, 0, sizeof( szhQuery ) );

	/* se setea variable global */
	/* gbExclusionTotal = FALSE; Requerimiento de Soporte #83233 mgg 18-03-2009 */
	iNumDias=*iNumeroDias;
	ifnTrazaHilos( modulo, &pfLog, "iNumDias [%d].", LOG03, iNumDias);
	strcpy(szhENRUT,"ENRUT");
	strcpy(szhCANUM,"CANUM");
	iRetExclu=0;	/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */

	/*ifnTrazaHilos( modulo, &pfLog, "Entro a ifnExcluyeAcciones", LOG02);*/
	ifnTrazaHilos( modulo, &pfLog, "\n\tIngreso modulo : [%s].", LOG02, modulo); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

	if( !iExclTotal )	/* si NO es una exclusion total */
	{
        ifnTrazaHilos( modulo, &pfLog, "Va entrar a ExclusionParcial.\n", LOG02);
        /*if (ifnExclusionParcial( &pfLog, &sthAccionInversa, szFecDeudVenc, lhCodCliente, &iNumDias, szhCodCateg, CXX) !=0){
            ifnTrazaHilos( modulo, &pfLog, "Cliente [%ld] no es excluido parcialmente.", LOG02, lhCodCliente );
            return -1;
        }*/

		/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
		iRetExclu=ifnExclusionParcial( &pfLog, &sthAccionInversa, szFecDeudVenc, lhCodCliente, &iNumDias, szhCodCateg, CXX);
		if (iRetExclu == -99)
		{
	        ifnTrazaHilos( modulo, &pfLog, "Cliente [%ld] no es excluido parcialmente.", LOG02, lhCodCliente );
			return -99;
		}
		else if (iRetExclu == -1)
		{
	        ifnTrazaHilos( modulo, &pfLog, "Cliente [%ld] no es excluido parcialmente.", LOG02, lhCodCliente );
	        /* EXEC SQL ROLLBACK; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 31;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1490;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			return -1;
		}

		iTotAcciones=lAccionReversa;
	}
	else /* exclusion total */
	{
		ifnTrazaHilos( modulo, &pfLog, "Va entrar a ExclusionTotal.\n", LOG02);
		if (ifnExclusionTotal(&pfLog, &sthAccionInversa, lhCodCliente, &iNumDias, &iTotAcciones, CXX) !=0) {
			ifnTrazaHilos( modulo, &pfLog, "Cliente [%ld] no puede ser excluido totalmente.", LOG02, lhCodCliente );
	        /* EXEC SQL ROLLBACK; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 31;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1505;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			return -1;
		}

	} /* tipo de exclusion */

	ifnTrazaHilos( modulo, &pfLog, "iTotAcciones [%ld].", LOG03, iTotAcciones );
	/*ifnTrazaHilos( modulo, &pfLog, "ihNumerodias [%d]. ", LOG03, iNumDias );*/
	ifnTrazaHilos( modulo, &pfLog, "iNumDias [%d].", LOG03, iNumDias ); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

	ihNumerodias=iNumDias;
	*iNumeroDias=ihNumerodias; /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

	/* la funcion manda mensajes, en caso de error */
	if( !bfnVerifExclRBaja(&pfLog, lhCodCliente, &sthAccionInversa, &iTotAcciones, &stParametros, CXX ) )
	{
      /* EXEC SQL ROLLBACK; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 31;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1520;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


      return -1;
	}

	strcpy( szEstado, "REV" );
	strcpy( szRevAnterior, "" );
	ifnTrazaHilos( modulo, &pfLog, "iTotAcciones [%i]\n", LOG03, iTotAcciones);

	for( i = 0; i < iTotAcciones; i++ )
	{
		strcpy( szhCodAcc, sthAccionInversa.szCodRutinaInv[i] );
		lhNumSeq = sthAccionInversa.lNumSecuencia[i];
		lAuxSeqGlobal = lhNumSeq;

		ifnTrazaHilos( modulo, &pfLog, "szhCodAcc [%s], lhNumSeq [%ld], iTotAcciones [%d].", LOG03, szhCodAcc, lhNumSeq, iTotAcciones );

		if( strcmp( szhCodAcc, szRevAnterior ) == 0 ) /* si la accion (reversa) es la misma que la ejecuta anteriormente */
		{
			if( !ifnUpdateEstadoAccionH(&pfLog, lhCodCliente, lhNumSeq, szEstado, iAboCeluGlobal, iAboBeepGlobal, iMRAboCeluGlobal, iMRAboBeepGlobal, CXX ) )
			{
				/* fallo cambiando estado de la accion reversa */
				iError = 1; /*marca que hubo un error */
				break;  /* sale del ciclo */
			}
		}
		else /* si es una reversa distinta de la vista anteriormente */
		{
			strcpy( szRevAnterior, szhCodAcc ); /* La nueva accion es la anterior para la proxima vuelta */
			ifnTrazaHilos( modulo, &pfLog, "Verificando Acciones ", LOG05 );

			memset( szhRet, '\0', sizeof( szhRet ) );
			iAccionEjecutada = 0;
			iAboCeluGlobal = 0;
			iAboBeepGlobal = 0;
			iMRAboCeluGlobal = 0;
			iMRAboBeepGlobal = 0;

			/*Solo para Cambio de Numero (CANUM)*/
			if (strcmp(szhCodAcc,szhCANUM)==0)
			{
	         sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL
				SELECT COD_PARAM
				INTO   :szhCodParam
				FROM (SELECT COD_PARAM
					   FROM CO_PTOSRUTINAS
					   WHERE COD_CATEGORIA = :szhCodCateg
				      AND COD_RUTINA IN ( :szhENRUT, :szhCANUM )
				      AND NUM_DIAS <= :ihNumerodias
					   ORDER BY NUM_DIAS DESC )
				WHERE ROWNUM < 2 ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PARAM into :b0  from (select COD_PARAM  from C\
O_PTOSRUTINAS where ((COD_CATEGORIA=:b1 and COD_RUTINA in (:b2,:b3)) and NUM_D\
IAS<=:b4) order by NUM_DIAS desc  ) where ROWNUM<2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1535;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodParam;
    sqlstm.sqhstl[0] = (unsigned long )16;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodCateg;
    sqlstm.sqhstl[1] = (unsigned long )16;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhENRUT;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCANUM;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihNumerodias;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				ifnTrazaHilos( modulo, &pfLog, "szhCodCateg 	: [%s]\n", LOG00, szhCodCateg);
				ifnTrazaHilos( modulo, &pfLog, "szhENRUT 	: [%s]\n", LOG00, szhENRUT);
				ifnTrazaHilos( modulo, &pfLog, "szhCANUM	: [%s]\n", LOG00, szhCANUM);
				ifnTrazaHilos( modulo, &pfLog, "ihNumerodias	: [%ld]\n", LOG00, ihNumerodias);

				if( sqlca.sqlcode )
				{
					ifnTrazaHilos( modulo, &pfLog, "al seleccionar cod_param de Co_PtosRutinas : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
					iAccionEjecutada = 0;
				}
				else
				{
					strcpy(szParamExclu,szhCodParam);
				}
			}
				/**/

			for( k = 0; k < MAXACC ; k++ )
			{
				if( !strcmp( stAccion[k].szCodigo, szhCodAcc ) )
				{
					/*pszRet = (* stAccion[k].szNombre)(lhCodCliente);  ejecuta la accion */
				   	sema_wait(&semaflock);
					pszRet = (* stAccion[k].szNombre)(&pfLog, lhCodCliente, CXX);  /*  ejecuta la accion */
					sema_post(&semaflock);

					sprintf(szhRet,"%s\0",pszRet);
					ifnTrazaHilos( modulo, &pfLog,"Cliente [%ld] iMRAboCeluGlobal = [%d]  iMRAboBeepGlobal = [%d]",
							        			      LOG05, lhCodCliente, iMRAboCeluGlobal, iMRAboBeepGlobal );
					iAccionEjecutada = 1;
					ifnTrazaHilos( modulo, &pfLog, "Resultado de la accion => [%s]", LOG05, szhRet );
					break; /*para que deje de buscar acciones */
				}
			}

			if( iAccionEjecutada == 0 )	/* No se ejecuto accion alguna */
			{
				ifnTrazaHilos( modulo, &pfLog, "No Encontro la Accion [%s] en la lista , NO EJECUTO NADA ", LOG01, szhCodAcc );
				strcpy( szEstado, "RER\0" );
				if( !ifnUpdateEstadoAccionH(&pfLog, lhCodCliente, lhNumSeq, szEstado, 0, 0, 0, 0, CXX) ) /* Marca Reversa ERRor */
				{
				/* fallo cambiando estado de la accion reversa */
					iError = 1;  /* marca que hubo un error */
					break;  /* sale del ciclo */
				}

				/* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1570;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				iErrRev = 1;
			}

     		if( strcmp( szhRet, "OK" ) == 0 ) /* Se ejecuto la accion y la respuesta fue OK */
     		{
				strcpy( szEstado, "REV" );
				if (!ifnUpdateEstadoAccionH(&pfLog, lhCodCliente, lhNumSeq, szEstado, iAboCeluGlobal, iAboBeepGlobal, iMRAboCeluGlobal,iMRAboBeepGlobal, CXX ) ) /* REVERSADA */
            {
					/* fallo cambiando estado de la accion reversa */
					iError = 1;  /* marca que hubo un error */
					break;  /* sale del ciclo */
     			}

				/* registra la accion inversa como ejecutada jlr_06.10.00 */

				/* EXEC SQL SELECT CO_SEQ_ACCION.NEXTVAL INTO :lhNumSeq FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CO_SEQ_ACCION.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1585;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				if (sqlca.sqlcode)
				{
					ifnTrazaHilos( modulo, &pfLog, "al obtener secuencia para la accion (%ld) : %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
               iError = 1; /* marca que hubo un error */
               break;  /* sale del ciclo */
				}

            ihAboCeluGlobal = iAboCeluGlobal;
				ihAboBeepGlobal = iAboBeepGlobal;

		      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL
				INSERT INTO CO_ACCIONES (
					 COD_CLIENTE     , NUM_SECUENCIA , COD_RUTINA   , COD_ESTADO ,
					 FEC_ESTADO      , FEC_EJECPROG  , NOM_USUARIO  , CNT_ABOCELU,
					 CNT_ABOBEEP     , NUM_IDENT     , COD_TIPIDENT , DEU_VENCIDA, DEU_NOVENC )
				SELECT :lhCodCliente   , :lhNumSeq     , :szhCodAcc   , :szhEstadoEJE,
					SYSDATE         , SYSDATE       , USER         , :ihAboCeluGlobal,
					:ihAboBeepGlobal, NUM_IDENT     , COD_TIPIDENT , DEU_VENCIDA, DEU_NOVENC
				FROM   CO_MOROSOS
				WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_ACCIONES (COD_CLIENTE,NUM_SECUENCIA,COD_RU\
TINA,COD_ESTADO,FEC_ESTADO,FEC_EJECPROG,NOM_USUARIO,CNT_ABOCELU,CNT_ABOBEEP,NU\
M_IDENT,COD_TIPIDENT,DEU_VENCIDA,DEU_NOVENC)select :b0 ,:b1 ,:b2 ,:b3 ,SYSDATE\
 ,SYSDATE ,USER ,:b4 ,:b5 ,NUM_IDENT ,COD_TIPIDENT ,DEU_VENCIDA ,DEU_NOVENC  f\
rom CO_MOROSOS where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1604;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeq;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAcc;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhEstadoEJE;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihAboCeluGlobal;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihAboBeepGlobal;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode )
				{
					ifnTrazaHilos( modulo, &pfLog, "al insertar accion ejecutada al Cliente %ld : %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
               iError = 1; /* marca que hubo un error */
               break;  /* sale del ciclo */
				}

				/* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1647;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



        	}
        	else if( strcmp( szhRet, "PND" ) == 0 )  /* si la respuesta fue 'PND' */
        	{

				/* EXEC SQL ROLLBACK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1662;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				ifnTrazaHilos( modulo, &pfLog,"La Reversa de la accion %ld termino con Estado => [%s]", LOG02, lhNumSeq, szhRet );

				/* reversamos la accion, antes de insertar la reversa */
				strcpy( szEstado, "REV" );
				/* PGG luego incorporar nuevamente */
			   if( !ifnUpdateEstadoAccionH(&pfLog, lhCodCliente, lhNumSeq, szEstado, 0, 0, 0, 0, CXX ) ) /* Marca Reversa ERRor */
				{
				 	/* fallo cambiando estado de la accion reversa */
				 	iError = 1;  /* marca que hubo un error */
				 	break;   /* sale del ciclo */
				}

				/* se registra la reversa, pero con error */

		      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL SELECT CO_SEQ_ACCION.NEXTVAL INTO :lhNumSeq FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CO_SEQ_ACCION.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1677;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




 				if( sqlca.sqlcode )
 				{
					ifnTrazaHilos( modulo, &pfLog, "Recuperando secuencia para CO_ACCIONES => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					iError = 1; /* marca que hubo un error */
					break;  /* sale del ciclo */
				}

				if (strcmp(szhCodAcc,"CANUM")==0)
				{
					strcpy(szhCodParam,szParamExclu);

	            sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
					/* EXEC SQL
					INSERT INTO CO_PARAM_ACCIONES
						    (NUM_SECUENCIA, COD_PARAM )
					VALUES (:lhNumSeq    , :szhCodParam ); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CO_PARAM_ACCIONES (NUM_SECUENCIA,COD_PARAM) \
values (:b0,:b1)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1696;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodParam;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




					if( sqlca.sqlcode != SQLOK )
					{
						ifnTrazaHilos( modulo, &pfLog, "Error al insertar en tabla CO_PARAM_ACCIONES, Secuencia ==> [%ld]. - %s", LOG00, lhNumSeq,sqlca.sqlerrm.sqlerrmc);
						return FALSE;
					}

				}

     			ihAboCeluGlobal = iAboCeluGlobal;
				ihAboBeepGlobal = iAboBeepGlobal;

		      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL
				INSERT INTO CO_ACCIONES (
				       COD_CLIENTE     , NUM_SECUENCIA , COD_RUTINA  , COD_ESTADO,
				       FEC_ESTADO      , FEC_EJECPROG  , NOM_USUARIO , CNT_ABOCELU,
				       CNT_ABOBEEP     , NUM_IDENT     , COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC	)
				SELECT :lhCodCliente   , :lhNumSeq     , :szhCodAcc  , :szhPND,
					    SYSDATE         , SYSDATE       , USER        , :ihAboCeluGlobal,
					    :ihAboBeepGlobal, NUM_IDENT     , COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC
				FROM   CO_MOROSOS
				WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_ACCIONES (COD_CLIENTE,NUM_SECUENCIA,COD_RU\
TINA,COD_ESTADO,FEC_ESTADO,FEC_EJECPROG,NOM_USUARIO,CNT_ABOCELU,CNT_ABOBEEP,NU\
M_IDENT,COD_TIPIDENT,DEU_VENCIDA,DEU_NOVENC)select :b0 ,:b1 ,:b2 ,:b3 ,SYSDATE\
 ,SYSDATE ,USER ,:b4 ,:b5 ,NUM_IDENT ,COD_TIPIDENT ,DEU_VENCIDA ,DEU_NOVENC  f\
rom CO_MOROSOS where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1719;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeq;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAcc;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhPND;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihAboCeluGlobal;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihAboBeepGlobal;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode )
				{
					ifnTrazaHilos( modulo, &pfLog, "Insertando Reversa PENDIENTE => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					iError = 1; /* marca que hubo un error */
					break;  /* sale del ciclo */
				}

				/* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1762;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




				iErrRev = 1;
         }
         else /* Se ejecuto la accion y hubo Error */
         {

				/* EXEC SQL ROLLBACK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1777;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				ifnTrazaHilos( modulo, &pfLog, "La Reversa de la accion %ld termino con Error => [%s]", LOG02, lhNumSeq, szhRet );

				/* reversamos la accion, antes de insertar la reversa */
				strcpy( szEstado, "REV" );
				if( !ifnUpdateEstadoAccionH(&pfLog, lhCodCliente, lhNumSeq, szEstado, 0, 0, 0, 0, CXX ) )  /* Marca Reversa ERRor */
				{
				/* fallo cambiando estado de la accion reversa */
					iError = 1;  /* marca que hubo un error */
					break;   /* sale del ciclo */
				}

				/* se registra la reversa, pero con error */

		      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL SELECT CO_SEQ_ACCION.NEXTVAL INTO :lhNumSeq FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CO_SEQ_ACCION.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1792;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode )
				{
					ifnTrazaHilos( modulo, &pfLog, "Recuperando secuencia para CO_ACCIONES => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					iError = 1; /* marca que hubo un error */
					break;  /* sale del ciclo */
				}

				if (strcmp(szhCodAcc,"CANUM")==0)
				{
					strcpy(szhCodParam,szParamExclu);

	            sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
					/* EXEC SQL
					INSERT  INTO CO_PARAM_ACCIONES
					       (NUM_SECUENCIA, COD_PARAM )
					VALUES (:lhNumSeq    , :szhCodParam ); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CO_PARAM_ACCIONES (NUM_SECUENCIA,COD_PARAM) \
values (:b0,:b1)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1811;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodParam;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



					if( sqlca.sqlcode != SQLOK )
					{
						ifnTrazaHilos( modulo, &pfLog, "Error al insertar en tabla CO_PARAM_ACCIONES, Secuencia ==> [%ld].", LOG00, lhNumSeq);
						return FALSE;
					}

				}

     			ihAboCeluGlobal = iAboCeluGlobal;
				ihAboBeepGlobal = iAboBeepGlobal;

		      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL
				INSERT INTO CO_ACCIONES (
				       COD_CLIENTE     , NUM_SECUENCIA, COD_RUTINA  , COD_ESTADO,
				       FEC_ESTADO      , FEC_EJECPROG , NOM_USUARIO , CNT_ABOCELU,
				       CNT_ABOBEEP     , NUM_IDENT    , COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC	)
				SELECT :lhCodCliente   , :lhNumSeq    , :szhCodAcc  , :szhERR,
					    SYSDATE         , SYSDATE      , USER        , :ihAboCeluGlobal,
					    :ihAboBeepGlobal, NUM_IDENT    , COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC
				FROM  CO_MOROSOS
				WHERE COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_ACCIONES (COD_CLIENTE,NUM_SECUENCIA,COD_RU\
TINA,COD_ESTADO,FEC_ESTADO,FEC_EJECPROG,NOM_USUARIO,CNT_ABOCELU,CNT_ABOBEEP,NU\
M_IDENT,COD_TIPIDENT,DEU_VENCIDA,DEU_NOVENC)select :b0 ,:b1 ,:b2 ,:b3 ,SYSDATE\
 ,SYSDATE ,USER ,:b4 ,:b5 ,NUM_IDENT ,COD_TIPIDENT ,DEU_VENCIDA ,DEU_NOVENC  f\
rom CO_MOROSOS where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1834;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeq;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAcc;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhERR;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihAboCeluGlobal;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihAboBeepGlobal;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode )
				{
					ifnTrazaHilos( modulo, &pfLog, "Insertando Reversa con ERROR => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					iError = 1; /* marca que hubo un error */
					break;  /* sale del ciclo */
				}

				/* insertamos el detalle de error de la reversa */

		      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL INSERT INTO CO_ACCERR( NUM_SECUENCIA, COD_ERROR ) VALUES( :lhNumSeq, :szhRet ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_ACCERR (NUM_SECUENCIA,COD_ERROR) values (:\
b0,:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1877;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhRet;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				if( sqlca.sqlcode )
				{

	            sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
					/* EXEC SQL
					UPDATE CO_ACCERR SET
					       COD_ERROR = :szhRet
					WHERE NUM_SECUENCIA = :lhNumSeq; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update CO_ACCERR  set COD_ERROR=:b0 where NUM_SECUENCIA=\
:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1900;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhRet;
     sqlstm.sqhstl[0] = (unsigned long )6;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeq;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



					if( sqlca.sqlcode )
					{
						ifnTrazaHilos( modulo, &pfLog, "UPDATE CO_ACCERR %s", LOG00, sqlca.sqlerrm.sqlerrmc );
						iError = 1; /* marca que hubo un error */
						break;  /* sale del ciclo */
					}
				}

				/* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1923;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				iErrRev = 1;
			}
		} /* endif reversa anterior*/
	}/*endfor  verifica siguiente accion inversa */

	if( iError )  /* Error Grave, seguir con el otro cliente */
   {
   	/* EXEC SQL ROLLBACK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1938;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		return -1;
	}

   if( iErrRev )   /* Error en una Reversa, no Excluir Total */
		return 1;

	return 0; /* Todas las Reversa se ejecutaron Ok */
}

/* ================================================================================================ */
/*	Revisa si el cliente tiene accion de Reversa de Baja, y toma las acciones del caso				*/
/* ================================================================================================ */
BOOL bfnVerifExclRBaja(FILE **ptArchLog, long lCodCliente, td_Accion_Inversa *sthAccionInversa, int *iTotAcciones, td_Parametros *stParam, sql_context ctxCont)
/*
Descripcion	La funcion es la encargada de verificar si el cliente tiene accion
				Reversa de baja a aplicar, en tal caso valida saldo y antiguedad de
				la Baja, si no es posible reversar al cliente por estos dos criterios
				solo deja aplicar las acciones reversas restantes.
Parametros  lCodCliente			Cliente dado.
				sthAccionInversa    Estructura con las Reversas de Baja a aplicar.
				iTotAcciones        Total de Reversas a aplicar.
				stParam				Parametros de validacion.
Retorno		TRUE				Todo OK.
				FALSO				Error.
*/
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_Accion_Inversa   sthAccionInversaPaso;  	/* host array para las acciones inversas */
	long	lhCodCliente = lCodCliente;
	int		ihDiasDesdeBaja;
	char  	szhBAJA        [5];
	int		ihValor_cero = 0;
	char	szhEstadoEJE[4];
	char	szhEstadoRER[4];
/* EXEC SQL END DECLARE SECTION; */ 


char	 modulo[] = "bfnVerifExclRBaja";
int 	 i, j;
BOOL	 bExisteRBaja = FALSE, bCumpleCond = TRUE;
char	 szhFecAux[9] = "";
double dhDeuVencida = 0, dhMtoAux = 0;
sql_context CXX;
struct sqlca sqlca;

FILE *pfLog;

   pfLog = *ptArchLog;

   CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	strcpy(szhEstadoEJE ,"EJE");
	strcpy(szhEstadoRER ,"RER");

	strcpy(szhBAJA ,"BAJA");

	/* mostramos las acciones del cliente dado */
	for( i = 0; i < *iTotAcciones; i++ )
		ifnTrazaHilos( modulo, &pfLog, "Entrada (Cliente:%ld) Accion Cargada [%s] [%ld] [%d].",
							  LOG05, lhCodCliente, sthAccionInversa->szCodRutinaInv[i], sthAccionInversa->lNumSecuencia[i], sthAccionInversa->iOrdAplicacion[i] );

	/* revisamos si existe una reversa de baja para el cliente dado */
	for( i = 0; i < *iTotAcciones; i++ )
	{
		if( strcmp( sthAccionInversa->szCodRutinaInv[i], stParam->szCodReversaBaja ) == 0 )
		{
			bExisteRBaja = TRUE;
			break;
		}
	}

	if( bExisteRBaja )
		ifnTrazaHilos( modulo, &pfLog,  "Accion Reversa de Baja encontrada.", LOG03 );

	if( bExisteRBaja )
	{
		/* si existe la baja debemos validar que se cumplam los criterios de saldo y dias desde la baja */
		if( !bfnGetSaldoClienteAcc(&pfLog, lhCodCliente, &dhDeuVencida, &dhMtoAux, szhFecAux, CXX ) )
		{
			ifnTrazaHilos( modulo, &pfLog,  "( Cliente:%ld ) Fallo bfnGetSaldoCliente......", LOG03, lhCodCliente );
			return FALSE;
		}
		ifnTrazaHilos( modulo, &pfLog, "Deuda Vencida Cliente [%.0f].", LOG03, dhDeuVencida );

		/* No cumple esta condicion de la Reversa de Baja */
		if ( ( dhDeuVencida - stParam->dSaldo ) > 0 )
			bCumpleCond = FALSE;

		/* EXEC SQL
		SELECT NVL( TRUNC(SYSDATE) - TRUNC(MAX(FEC_ESTADO)), :ihValor_cero )
		INTO	  :ihDiasDesdeBaja
		FROM   CO_ACCIONES
		WHERE  COD_CLIENTE  = :lhCodCliente
		AND    COD_RUTINA   = :szhBAJA
		AND    COD_ESTADO   IN (:szhEstadoEJE, :szhEstadoRER); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL((TRUNC(SYSDATE)-TRUNC(max(FEC_ESTADO))),:b0) int\
o :b1  from CO_ACCIONES where ((COD_CLIENTE=:b2 and COD_RUTINA=:b3) and COD_ES\
TADO in (:b4,:b5))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1953;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihDiasDesdeBaja;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[3] = (unsigned char  *)szhBAJA;
  sqlstm.sqhstl[3] = (unsigned long )5;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhEstadoEJE;
  sqlstm.sqhstl[4] = (unsigned long )4;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhEstadoRER;
  sqlstm.sqhstl[5] = (unsigned long )4;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "(Cliente:%ld) Select FEC_BAJA CO_ACCIONES %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
	        	return FALSE;
		}

		if ( sqlca.sqlcode == SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "(Cliente:%ld) No tiene Accion de Baja en CO_ACCIONES.", LOG03, lhCodCliente );
        	return FALSE;
   	}

		ifnTrazaHilos( modulo, &pfLog, "(Cliente:%ld) Dias desde que se dio la baja [%d].", LOG03, lhCodCliente, ihDiasDesdeBaja );

		/* No se realiza la baja el cliente tiene mas dias de los permitidos para la reposicion */
		if ( ihDiasDesdeBaja > stParam->iDiasBaja )
			bCumpleCond = FALSE;

		/* si no cumple las condiciones para que se ejecute la reversa de baja	*/
		/* se restringen las acciones inversas a ejecutar						*/
		if( !bCumpleCond )
		{
			/* traspasamos las inversas a aplicar a una estructura auxiliar */
			j = 0;
			for( i = 0; i < *iTotAcciones; i++ )
			{
				if( strcmp( sthAccionInversa->szCodRutinaInv[i], stParam->szCodReversaBaja ) != 0 )
				{
					strcpy( sthAccionInversaPaso.szCodRutinaInv[j], sthAccionInversa->szCodRutinaInv[i] );
					sthAccionInversaPaso.lNumSecuencia[j] = sthAccionInversa->lNumSecuencia[i];
					sthAccionInversaPaso.iOrdAplicacion[j] = sthAccionInversa->iOrdAplicacion[i];
					j++;
				}
			}

			/* cargamos las acciones reversas que se ejecutaran */
			memset( sthAccionInversa, 0, sizeof( td_Accion_Inversa ) );
			*iTotAcciones = 0;

			for( i = 0; i < j; i++ )
			{
				strcpy( sthAccionInversa->szCodRutinaInv[i], sthAccionInversaPaso.szCodRutinaInv[i] );
				sthAccionInversa->lNumSecuencia[i] = sthAccionInversaPaso.lNumSecuencia[i];
				sthAccionInversa->iOrdAplicacion[i] = sthAccionInversaPaso.iOrdAplicacion[i];
			}

			for( i = 0; i < j; i++ )
				ifnTrazaHilos( modulo, &pfLog, "Salida  (Cliente:%ld) Accion Cargada [%s] [%ld] [%d].",
									  LOG05, lhCodCliente, sthAccionInversa->szCodRutinaInv[i], sthAccionInversa->lNumSecuencia[i], sthAccionInversa->iOrdAplicacion[i] );

        		*iTotAcciones = j;
     			bGeneraCargos = FALSE;
		} /* if( bCumpleCond ) */
	} /* if( bExisteRBaja ) */

	return TRUE;
} /* BOOL bfnVerifExclRBaja( long lCodCliente, td_Accion_Inversa *sthAccionInversa, int *iTotAcciones, td_Parametros *stParam, int *iNumeroDias ) */


/* ================================================================================================ */
/*	Borra las acciones desde la tabla de acciones por dia    										*/
/* ================================================================================================ */
BOOL bfnBorraCoRutinasDia(FILE **ptArchLog, long lCodCliente, char *szCodCategoria, int iNumDias, char *szAccion, sql_context ctxCont )
{
/**
Descripcion : Borra las acciones desde la tabla de acciones por dia
Parametros	: lCodCliente		Codigo de Cliente.
			     szCodCategoria	Categoria del Cliente.( si szAccion=T, viene en blanco )
			     iNumDias		Numero de dias a considerar como filtro( si szAccion=T, valor 0 )
			     szAccion		P	Parcial
				  T	Total
Salida      : True 	si todo va ok
			     False 	si se genera algun error
* */

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long 		lhCodCliente;
	char 		szhCodCategoria [6];
	char		szhPND[4];
	char		szhLetra_A[2];
	int  		ihNumDias;
	arr_acciones 	sthAcciones;
	int  		igTotAcciones   = 0;
	char 		szhDDMMYYYY     [9];
	int			ihValor_cero = 0;
	int			ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnBorraCoRutinasDia";
int  i=0;
sql_context CXX;
struct sqlca sqlca;

FILE *pfLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


   pfLog = *ptArchLog;
 	ifnTrazaHilos( modulo, &pfLog, "Ingreso modulo : %s", LOG05, modulo );

	memset( szhCodCategoria, '\0', sizeof( szhCodCategoria ) );
  	memset(&sthAcciones,0,sizeof(arr_acciones));

	lhCodCliente = lCodCliente;
	strcpy(szhCodCategoria,szCodCategoria);
	strcpy(szhDDMMYYYY,"DDMMYYYY");
	strcpy(szhPND,"PND");
	strcpy(szhLetra_A,"A");
	ihNumDias = iNumDias;

   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL DECLARE curACCIONES CURSOR for
	SELECT ROWID, CA.COD_RUTINA, TO_CHAR(CA.FEC_EJECPROG,:szhDDMMYYYY)
	FROM   CO_ACCIONES CA
	WHERE  CA.COD_CLIENTE = :lhCodCliente
	AND  CA.NUM_SECUENCIA > :ihValor_cero
	AND  CA.NUM_SECUENCIA IN (SELECT A.NUM_SECUENCIA
                             FROM CO_RUTINAS R,CO_ACCIONES A
                             WHERE A.COD_CLIENTE = :lhCodCliente
				                 AND A.NUM_SECUENCIA > :ihValor_cero
                             AND A.COD_ESTADO   = :szhPND
                             AND R.COD_RUTINA   = A.COD_RUTINA
                             AND R.TIP_RUTINA   = :szhLetra_A
                             AND R.COD_RUTINA NOT IN (SELECT P.COD_RUTINA
                                                      FROM CO_PTOSRUTINAS P
                                                      WHERE P.COD_CATEGORIA = :szhCodCategoria
                                                      AND P.NUM_DIAS <= :ihNumDias
                                                      AND P.COD_RUTINA = R.COD_RUTINA ) ); */ 

	if( sqlca.sqlcode ) /* Fallo el Declare del Cursor */
	{
		ifnTrazaHilos( modulo, &pfLog, "Error DECLARE => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL OPEN curACCIONES ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0061;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1992;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDDMMYYYY;
 sqlstm.sqhstl[0] = (unsigned long )9;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhPND;
 sqlstm.sqhstl[5] = (unsigned long )4;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhLetra_A;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCodCategoria;
 sqlstm.sqhstl[7] = (unsigned long )6;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode ) /* Error al Abrir el Cursor */
	{
		ifnTrazaHilos( modulo, &pfLog, "en OPEN : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL FETCH curACCIONES INTO :sthAcciones; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )50;
 sqlstm.offset = (unsigned int  )2043;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)sthAcciones.szhRowid;
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )19;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)sthAcciones.szhCodRutina;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)sthAcciones.szhFecha;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )9;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	igTotAcciones = sqlca.sqlerrd[2];

	ifnTrazaHilos( modulo, &pfLog, "igTotAcciones a Borrar: %d",LOG05,igTotAcciones);

	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo, &pfLog, "en FETCH %s",LOG00, sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL CLOSE curACCIONES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2070;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if (sqlca.sqlcode)
	{
		ifnTrazaHilos( modulo, &pfLog, "CLOSE cur_CO_COLASPROC :%s", LOG00,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

    	for (i=0; i < igTotAcciones; i++)
	{
		ifnTrazaHilos( modulo, &pfLog, "Borrando accion  %s para dia %s", LOG05,sthAcciones.szhCodRutina[i], sthAcciones.szhFecha[i]);

      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		DELETE CO_ACCIONES
		WHERE ROWID = :sthAcciones.szhRowid[i]; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "delete  from CO_ACCIONES  where ROWID=:b0";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2085;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)(sthAcciones.szhRowid)[i];
  sqlstm.sqhstl[0] = (unsigned long )19;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "en UPDATE CO_RUTINAS_DIA: %s",LOG00, sqlca.sqlerrm.sqlerrmc);
			break;
		}

      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		UPDATE CO_RUTINAS_DIA
	   SET NUM_EJECUTADAS = NUM_EJECUTADAS - DECODE( NUM_EJECUTADAS, :ihValor_cero, :ihValor_cero, :ihValor_uno )
		WHERE  COD_RUTINA = :sthAcciones.szhCodRutina[i]
		AND  FEC_RUTINA = TO_DATE(:sthAcciones.szhFecha[i],:szhDDMMYYYY); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_RUTINAS_DIA  set NUM_EJECUTADAS=(NUM_EJECUTADAS-D\
ECODE(NUM_EJECUTADAS,:b0,:b0,:b2)) where (COD_RUTINA=:b3 and FEC_RUTINA=TO_DAT\
E(:b4,:b5))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2104;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(sthAcciones.szhCodRutina)[i];
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(sthAcciones.szhFecha)[i];
  sqlstm.sqhstl[4] = (unsigned long )9;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhDDMMYYYY;
  sqlstm.sqhstl[5] = (unsigned long )9;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "en UPDATE CO_RUTINAS_DIA: %s",LOG00, sqlca.sqlerrm.sqlerrmc);
			break;
		}
	}

	return TRUE;
} /* BOOL bfnBorraCoRutinasDia */


/*======================================================================================*/
/*	ifnRevisaCriterios()								*/
/*======================================================================================*/
int ifnRevisaCriteriosE2 (FILE **ptArchLog,  td_PtoGestion *sthPtoGestion, td_PtoRutina *sthRutinas, int iTotPtoGest, int iTotRutinas,long lCodCliente, char *szCodPtoGest, char *szCodCategoria, int iNumDias,  sql_context ctxCont )
/*--------------------------------------------------------------------------------------
Calcula el nuevo tramo en que debera quedar el cliente examinado, considerando
como punto inicial su antiguedad de deuda, sucesivamente aplicara los criterios
del Pto de Gestion inferior al que se encuentra, para validar si corresponde
fijarlo un  tramo mas abajo del que se encuentra, El saldo del cliente es el factor
principal para estas bajas de tramo.
Si corresponde fijarlo en un nuevo tramo, entregara el numero de dias de antiguedad
nuevo, para que se apliquen las reversas correspondientes.

Parametros :	sthPtoGestion  	estructura con Puntos de Gestion.
				sthRutinas  	estructura con Criterios.
				iTotPtoGest		cantidad total de registros cargados de PtoGestion.
				iTotRutinas		cantidad total de registros cargados de Rutinas.
				lCodCliente 	codigo de cliente a ser evaluado.
				szCodPtoGest	codigo punto de gestion inicial.
				szCodCategoria  codigo de categoria inicial.
				iNumDias        Dia inicial desde el cual se aplicaran reversas.

Retorno		:	-1				Error.
				 iNeoDias		.
----------------------------------------------------------------------------------------*/
{
/*char		modulo[] = "ifnRevisaCriterios";*/
char		modulo[] = "ifnRevisaCriteriosE2";    /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
char       	szhPtoGestAct[6];
char       	szhCodCateAct[6];
char       	szhPtoGestPto[6];
char       	szhCodCatePto[6];
char       	szhPtoGestRut[6];
char       	szhCodCateRut[6];
int        	iRecorre 		= 0;
int 		ihNumDiasPtoAct = 0;
int	 		ihNumProceso    = 0;
int 		iRet  = 0;
int         sts   = 0;
int 		i;
BOOL       	bExistePG = FALSE;

lista_Crit   	LCriterio1 = NULL;			    /* Lista para universo de Criterios */
lista_Crit   	LCriterio2 = NULL;			    /* Lista para universo de Criterios */
lista_Crit   	paux       = NULL;			    /* Lista para universo de Criterios */
struct stCliente stMR;			/* Estructura que contiene los datos del cliente */
FILE *pfLog;
sql_context CXX;
struct sqlca sqlca;


	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


        pfLog = *ptArchLog;

	    ifnTrazaHilos( modulo, &pfLog, "\n\tIngreso modulo : [%s].", LOG03, modulo );  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
        ifnTrazaHilos( modulo, &pfLog, "Entrada Parametros\n"
					"\t\t\tPtoGest     = [%s],\n"
					"\t\t\tCategoria   = [%s],\n "
					"\t\t\tiTotPtoGest = [%d],\n"
					"\t\t\tiTotRutinas = [%d],\n"
					"\t\t\tlCodCliente = [%ld],\n"
					"\t\t\tiNumDias    = [%d]\n",
					LOG05,
					szCodPtoGest,
					szCodCategoria,
					iTotPtoGest,
					iTotRutinas,
					lCodCliente,
					iNumDias );



	memset( szhPtoGestAct, '\0', sizeof( szhPtoGestAct ) );
	memset( szhCodCateAct, '\0', sizeof( szhCodCateAct ) );
	memset( szhPtoGestPto, '\0', sizeof( szhPtoGestPto ) );
	memset( szhCodCatePto, '\0', sizeof( szhCodCatePto ) );
	memset( szhPtoGestRut, '\0', sizeof( szhPtoGestRut ) );
	memset( szhCodCateRut, '\0', sizeof( szhCodCateRut ) );

	strcpy( szhPtoGestAct, szCodPtoGest );
	strcpy( szhCodCateAct, szCodCategoria );
	ihNumDiasPtoAct 	 = iNumDias;

	rtrim( szhPtoGestAct );
	rtrim( szhCodCateAct );
	stMR.lCod_Cliente = lCodCliente; /* traspaco codigo del cliente a la estructura */

	ifnTrazaHilos( modulo, &pfLog, "Valores Actuales PtoGest = [%s], Categoria = [%s], iNumDias = [%d] ",
						LOG05, szhPtoGestAct, szhCodCateAct, ihNumDiasPtoAct );



	iRecorre = iTotPtoGest - 1;
	iEncuentraPto   = 0;  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-2005071801494 */
	ifnTrazaHilos( modulo, &pfLog, "iEncuentraPto = [%d] ", LOG05, iEncuentraPto);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

	do {

		bExistePG = FALSE;

		/* Busca el siguiente Punto de Gestion a evaluar de acuerdo a sus criterios */
		while ( iRecorre >= 0 )
		{
			ifnTrazaHilos( modulo, &pfLog, "iRecorre = [%d] ", LOG05, iRecorre );

			/* paso a auxiliares para comparacion y elimino los espacios en blanco a la derecha */
			memset( szhPtoGestPto, '\0', sizeof( szhPtoGestPto ) );
			memset( szhCodCatePto, '\0', sizeof( szhCodCatePto ) );

			strcpy( szhPtoGestPto, sthPtoGestion->szCodPtoGest[iRecorre] );
			strcpy( szhCodCatePto, sthPtoGestion->szCodCategoria[iRecorre] );

			rtrim( szhPtoGestPto );
			rtrim( szhCodCatePto );
/*****
			ifnTrazaHilos( modulo, &pfLog, "Comparo con Pto PtoGest = [%s], Categoria = [%s], Dias = [%d] ",
						LOG05, szhPtoGestPto, szhCodCatePto, sthPtoGestion->iNumDias[iRecorre] );

			ifnTrazaHilos( modulo, &pfLog, "szhCodCatePto = [%s] ", LOG05, szhCodCatePto);
			ifnTrazaHilos( modulo, &pfLog, "szhCodCateAct = [%s] ", LOG05, szhCodCateAct );
			ifnTrazaHilos( modulo, &pfLog, "sthPtoGestion->iNumDias[iRecorre] = [%d] ", LOG05, sthPtoGestion->iNumDias[iRecorre]);
			ifnTrazaHilos( modulo, &pfLog, "ihNumDiasPtoAct                   = [%d] ", LOG05, ihNumDiasPtoAct);

			if ( ( strcmp( szhCodCatePto, szhCodCateAct ) == 0 ) &&
				 ( sthPtoGestion->iNumDias[iRecorre] <= ihNumDiasPtoAct ) )
			{
				ihNumDiasPtoAct = sthPtoGestion->iNumDias[iRecorre];
				bExistePG 		= TRUE;
				ihNumProceso    = sthPtoGestion->iNumProceso[iRecorre];
				ifnTrazaHilos( modulo, &pfLog, "Encontre Pto Gestion Dias = [%d], voy a ver si se excluye.", LOG05, ihNumDiasPtoAct );
				break; * se guarda la posicion del punto de gestion que cumple con la condicion *
			}
			else
				iRecorre--;
*****/

/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
			if (  strcmp( szhCodCatePto, szhCodCateAct ) == 0 )
			{
				ifnTrazaHilos( modulo, &pfLog, "Comparo con Pto PtoGest = [%s], Categoria = [%s], Dias = [%d] ",
						LOG05, szhPtoGestPto, szhCodCatePto, sthPtoGestion->iNumDias[iRecorre] );

				ifnTrazaHilos( modulo, &pfLog, "szhCodCatePto = [%s] ", LOG05, szhCodCatePto);
				ifnTrazaHilos( modulo, &pfLog, "szhCodCateAct = [%s] ", LOG05, szhCodCateAct );
				ifnTrazaHilos( modulo, &pfLog, "sthPtoGestion->iNumDias[iRecorre] = [%d] ", LOG05, sthPtoGestion->iNumDias[iRecorre]);
				ifnTrazaHilos( modulo, &pfLog, "ihNumDiasPtoAct                   = [%d] ", LOG05, ihNumDiasPtoAct);

 				if	( sthPtoGestion->iNumDias[iRecorre] <= ihNumDiasPtoAct )
				{
					ihNumDiasPtoAct = sthPtoGestion->iNumDias[iRecorre];
					bExistePG 		= TRUE;
					ihNumProceso    = sthPtoGestion->iNumProceso[iRecorre];
					iEncuentraPto   = 1;
					ifnTrazaHilos( modulo, &pfLog, "Encontre Pto Gestion Dias = [%d], voy a ver si se excluye.", LOG05, ihNumDiasPtoAct );
					break; /* se guarda la posicion del punto de gestion que cumple con la condicion */
				}
			}
			iRecorre--;
/** FIN **/

		} /* while ( iRecorre >= 0 ) */

		ifnTrazaHilos( modulo, &pfLog, "iEncuentraPto = [%d] ", LOG05, iEncuentraPto ); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
		ifnTrazaHilos( modulo, &pfLog, "Salida While iRecorre = [%d] ", LOG05, iRecorre );

		if( bExistePG ) /* si se encontro un Pto de Gestion con Num Dias menor */
      		{
			i 	= 0;
			iRet	= 0;

	      		/* Carga los criterios del Punto de Gestion a la lista para evaluacion */
			ifnTrazaHilos( modulo, &pfLog, "Carga los criterios del Punto de Gestion ", LOG05);
			sts = ifnCargaCriteriosAcc(&pfLog, &LCriterio1, szhPtoGestPto, szhCodCatePto, ihNumProceso,0, CXX);
			if( sts == -1 )
			{
				ifnTrazaHilos( modulo, &pfLog, "No hay memoria suficiente [ifnRevisaCriteriosE - ifnCargaCriterios]", LOG01 );
				return -1;
			}
			ifnTrazaHilos( modulo, &pfLog, "Termino carga de los criterios del Punto de Gestion ", LOG05);

			i = 0;
			/* Elimina de la lista cod_rutina = CONTD  - no considerar CONTD jlr_05.07.01 */
			for (paux = LCriterio1; paux != NULL; paux = paux->sig)
			{

				if (strcmp(paux->szCodRutina,"CONTD"))
				{
					if (i>0)
					{
			   			sts = ifnInsertaCrit(&LCriterio2);
			    			if( sts == -1 )
						{
					     		ifnTrazaHilos( modulo, &pfLog, "No hay memoria suficiente [ifnRevisaCriteriosE - ifnInsertaCrit]", LOG01 );
					     		return -1;
						}
					}
					else
					{
						sts = ifnIniListCrit(&LCriterio2);
		    				if( sts == -1 )
						{
			     				ifnTrazaHilos( modulo, &pfLog, "No hay memoria suficiente [ifnRevisaCriteriosE - ifnIniListCrit]", LOG01 );
			     				return -1;
						}
						i = 1;
					}
					strcpy(LCriterio2->szCodRutina  , paux->szCodRutina  );
					strcpy(LCriterio2->szNomRutina  , paux->szNomRutina  );
					strcpy(LCriterio2->szTipRetorno , paux->szTipRetorno );
					strcpy(LCriterio2->szValRetorno , paux->szValRetorno );
					strcpy(LCriterio2->szValRango   , paux->szValRango   );
					strcpy(LCriterio2->szIndExcluye , paux->szIndExcluye );
					LCriterio2->iDiasProrroga       = paux->iDiasProrroga ;
				}

			}

		   	ifnTrazaHilos( modulo, &pfLog, "Saliendo del for (paux = LCriterio1)", LOG05);
			/* Invocacion a la funcion que evalua criterios */
			iRet = ifnEjecutaCriteriosEvContex( &pfLog, LCriterio2, stMR, &i , CXX );
			vfnBorraListaCrit(&LCriterio1);
			vfnBorraListaCrit(&LCriterio2);
			/*if( iRet < 0 )        		* -1 Error grave. PASAR AL SGTE PTO DE GESTION *
				return iRet;			*  0 No evalua mas. SE EXCLUYE EL CLIENTE 		*/

			/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
			if( iRet == -1 )        		/* -1 Error grave. PASAR AL SGTE PTO DE GESTION */
				return iRet;			/*  0 No evalua mas. SE EXCLUYE EL CLIENTE 		*/


    		} /* if( bExistePG ) */

		if( iRecorre < 0 )   /* termino de recorrer el arreglo de Ptos de Gestion */
		{
			if( iNumDias != ihNumDiasPtoAct )	/* recorrio  todos los criterios de los Ptos de Gestion */
				ihNumDiasPtoAct = 0;

			iRet = 1; 			   				/* salgo del ciclo */
		}
		else
		{
			if( bExistePG ) 	/* se evaluaron criterios */
			{
				if( iRet == 0 )	/* se excluyo el cliente, hay que evaluar si hay mas Ptos de Gestion y Criterios */
				{
					ihNumDiasPtoAct--;
				}
			} /* if( bExistePG ) */
		} /* if( iRecorre < 0 ) */

	} while ( iRet == 0 );

	/* Se sale del ciclo si el cliente cumple con un criterio dado */
	ifnTrazaHilos( modulo, &pfLog, "ihNumDiasPtoAct = [%d].", LOG05, ihNumDiasPtoAct );

	return ihNumDiasPtoAct;
} /* fin ifnRevisaCriterios */

/* ================================================================================================ */
/*	Selecciona los clientes a ser excluidos parcialmente     										          */
/* ================================================================================================ */
int ifnExclusionParcial (FILE **ptArchLog, td_Accion_Inversa *sthAccionInversa, char *szFecDeudVenc, long lCodCliente, int *iNumero_Dias, char *szCodCateg, sql_context ctxCont)
{


/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhFecDeudVenc  [9];	/* EXEC SQL VAR szhFecDeudVenc IS STRING(9); */ 

	char	szhCodPtoGest   [6];	/* EXEC SQL VAR szhCodPtoGest IS STRING(6); */ 

	char	szhCodCategoria [6];	/* EXEC SQL VAR szhCodCategoria IS STRING(6); */ 

	char	szhQuery[2000] = "";
	long	lhCodCliente  ;
	int		ihNumDias = 0 ;
	long	lhaNumSecuenciaAnt [MAX_REV];
	char	szhaCodRutinaAnt   [MAX_REV] [6];
	int		ihaOrdAplicaAnt    [MAX_REV];
	long	lhaNumSecuenciaPos [MAX_REV];
	char	szhaCodRutinaPos   [MAX_REV] [6];
	int		ihaOrdAplicaPos    [MAX_REV];
	int		ihValor_cero = 0;
	char	szhYYYYMMDD[9];
/* EXEC SQL END DECLARE SECTION; */ 


char  modulo[] = "ifnExclusionParcial";
int iNumDiasAux, iFilaAnt, iFilaPos;
sql_context CXX;
struct sqlca sqlca;
FILE *pfLog;

	pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	strcpy(szhYYYYMMDD,"YYYYMMDD");
	ifnTrazaHilos( modulo, &pfLog, "\n\tIngreso modulo : [%s].", LOG03, modulo);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
	ifnTrazaHilos( modulo, &pfLog, "EXCLUSION PARCIAL",LOG03);
	/* Calcula la nueva cantidad de dias de Vencido del cliente ( por fecha de vencimiento mas antigua ) */
	strcpy( szhFecDeudVenc, szFecDeudVenc );
	lhCodCliente=lCodCliente;

	if( strlen( szhFecDeudVenc ) == 0  )
	{
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL EXECUTE
			BEGIN
				:szhFecDeudVenc:=TO_CHAR( TRUNC( SYSDATE ), :szhYYYYMMDD );
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :szhFecDeudVenc := TO_CHAR ( TRUNC ( SYSDATE ) , :szh\
YYYYMMDD ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2143;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecDeudVenc;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDD;
  sqlstm.sqhstl[1] = (unsigned long )9;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode != SQLOK )
		{
			ifnTrazaHilos( modulo, &pfLog, "al recuperar Fecha del Sistema => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			return -1; /* rollback */
      		}
   	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT NVL( TRUNC(SYSDATE) - TO_DATE( NVL( :szhFecDeudVenc, SYSDATE ), :szhYYYYMMDD ), :ihValor_cero ),
		COD_PTOGEST,
		COD_CATEGORIA
	INTO	:ihNumDias,
		:szhCodPtoGest,
		:szhCodCategoria
	FROM	CO_MOROSOS
	WHERE	COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL((TRUNC(SYSDATE)-TO_DATE(NVL(:b0,SYSDATE),:b1)),:b\
2) ,COD_PTOGEST ,COD_CATEGORIA into :b3,:b4,:b5  from CO_MOROSOS where COD_CLI\
ENTE=:b6";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2166;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecDeudVenc;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihNumDias;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodPtoGest;
 sqlstm.sqhstl[4] = (unsigned long )6;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodCategoria;
 sqlstm.sqhstl[5] = (unsigned long )6;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}




	if( sqlca.sqlcode != SQLOK )
	{
		ifnTrazaHilos( modulo, &pfLog, "al calcular Dias de Vencimiento : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
		/* EXEC SQL ROLLBACK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2209;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		return -1; /* rollback */
	}

	/*- Verifica hasta que punto se le deben aplicar reversas al cliente en proceso -*/

	ifnTrazaHilos( modulo, &pfLog, "XXXXXXXXXXXXXXXXXXXXXXX", LOG03 );
	iNumDiasAux = ifnRevisaCriteriosE2(&pfLog, &sthPtosGestion, &sthPtoCriterio, iTotPtosGestion, iTotPtosCriterio, lhCodCliente, szhCodPtoGest, szhCodCategoria, ihNumDias, CXX );
	ifnTrazaHilos( modulo, &pfLog, "Numero de dias segun criterios [%d]", LOG03 ,iNumDiasAux);
	/*if( iNumDiasAux < 0 )	*/
	if( iNumDiasAux == -1 )   /*ERROR.  XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
	{
		/* EXEC SQL ROLLBACK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2224;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		return -1; /* rollback */
	}
	/*else if (iNumDiasAux == -99)  * No cumplio ningun criterio, NO se excluye. XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 *
	{
		ifnTrazasLog( modulo, "No Se cumple ningun criterio. No se excluye el cliente.", LOG05 );
		iRetExclu = -99;
		return iRetExclu;
	}*/
	/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
	else if ((iEncuentraPto == 0) && (iCumpleCriterio == 0)) /* No encontro pto de gestion, Ni se cumple ningun criterio. NO se excluye. */
	{
		ifnTrazaHilos( modulo, &pfLog, "No se encontro pto de gestion, Ni se cumple ningun criterio. No se excluye el cliente.", LOG05 );
		iRetExclu = -99;
		return iRetExclu;
	}/*** Fin ***/
	else if (iNumDiasAux >= 0)  /* Se cumplio criterio, SE EXCLUYE. XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
	{
		/* se borran las acciones pendientes que se encuentren inscritas en la tabla de acciones por dia */
		if( !bfnBorraCoRutinasDia( &pfLog, lhCodCliente, szhCodCategoria, iNumDiasAux, "P", CXX ) )
		{
      		ifnTrazaHilos( modulo, &pfLog, "En funcion bfnBorraCoRutinasDia.", LOG01 );
		/* EXEC SQL ROLLBACK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2239;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	   	return -1;
		}
		else
		{
	  		ifnTrazaHilos( modulo, &pfLog, "Se Borraron Acciones Pendientes",LOG05);
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2254;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		}

		if (ifnMenorPtoGestion(&pfLog, &iFilaAnt, lhCodCliente, szhCodCategoria, &iNumDiasAux, CXX) !=0) return -1;
		if (ifnMayorPtoGestion(&pfLog, &iFilaPos, lhCodCliente, szhCodCategoria, &iNumDiasAux, CXX) !=0) return -1;

		ifnTrazaHilos( modulo, &pfLog, "iFilaAnt  [%d]",LOG05,iFilaAnt);
		ifnTrazaHilos( modulo, &pfLog, "iFilaPos  [%d]",LOG05,iFilaPos);

		if (iFilaPos==0)
		{
			ifnTrazaHilos( modulo, &pfLog, "Cliente No tiene reversas para ejecutar segun Pto de Gestion",LOG02);
			/*return 1; */
			return -99;  	/* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
		}

		if (ifnReversasValidas(&pfLog, iFilaAnt , iFilaPos) != 0) return -1;

		strcpy(szCodCateg,szhCodCategoria);

		ifnTrazaHilos( modulo, &pfLog, "al final de la f(x) ifnExclusionParcial - szCodCateg	[%s]\n",LOG02, szCodCateg);

		*iNumero_Dias = iNumDiasAux;

		return 0;
	}/*if (iNumDiasAux >= 0)   Se cumplio criterio, SE EXCLUYE. XO-200508090319  09-08-2005.*/

} /* fin ifnExclusionParcial */


/* ================================================================================================ */
/*	Selecciona los reversas anterior o igual al pto de gestion  									          */
/* ================================================================================================ */
int ifnMenorPtoGestion(FILE **ptArchLog, int *iFilas, long lCodCliente, char *szCodCategoria, int *iNumDiasAux, sql_context ctxCont)
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long  lhCodCliente      ;
	char  szhCodCategoria[6];
	int   ihNumDias         ;
	char  szhLetra_A[2];	
	char  szhEstadoEJE[4];
	char  szhEstadoRER[4];
	int   ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 

char  modulo[] = "ifnMenorPtoGestion";
int iRows, i;
sql_context CXX;
struct sqlca sqlca;
FILE *pfLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	strcpy(szhLetra_A,"A");
	strcpy(szhEstadoEJE,"EJE");
	strcpy(szhEstadoRER,"RER");
	
	pfLog = *ptArchLog;
   ifnTrazaHilos( modulo, &pfLog, "En modulo [%s]",LOG03,modulo);
   lhCodCliente= lCodCliente;
   ihNumDias   = *iNumDiasAux;
   strcpy(szhCodCategoria,szCodCategoria);

   ifnTrazaHilos( modulo, &pfLog, "\tlhCodCliente    => [%ld].", LOG05,lhCodCliente);
   ifnTrazaHilos( modulo, &pfLog, "\tihNumDias       => [%d].", LOG05,ihNumDias);
   ifnTrazaHilos( modulo, &pfLog, "\tszhCodCategoria => [%s].", LOG05,szhCodCategoria);



	/*************************************************************************************/
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* Selecciona acciones del cliente menores al numero de dias */
	/* EXEC SQL DECLARE CurAntPtoGes CURSOR FOR
	SELECT DISTINCT  A.NUM_SECUENCIA, R.REV_RUTINA, NVL( R.ORD_APLICACION, :ihValor_cero )
	FROM  CO_RUTINAS R, CO_ACCIONES A
	WHERE A.COD_CLIENTE =  :lhCodCliente
	AND   A.COD_ESTADO IN (:szhEstadoEJE, :szhEstadoRER )
	AND   R.COD_RUTINA  =  A.COD_RUTINA
	AND   R.TIP_RUTINA  = :szhLetra_A
	AND   R.REV_RUTINA IS NOT NULL
	AND   R.COD_RUTINA IN ( SELECT P.COD_RUTINA
							      FROM   CO_PTOSRUTINAS P
							      WHERE  P.COD_CATEGORIA = :szhCodCategoria
							      AND    P.NUM_DIAS     <= :ihNumDias)
	ORDER BY NVL( R.ORD_APLICACION, :ihValor_cero ), R.REV_RUTINA; */ 

	if( sqlca.sqlcode != SQLOK)
	{
		ifnTrazaHilos( modulo, &pfLog, "DECLARE CurAntPtoGes => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
	   	return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL OPEN CurAntPtoGes ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0070;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2269;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhEstadoEJE;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhEstadoRER;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_A;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodCategoria;
 sqlstm.sqhstl[5] = (unsigned long )6;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihNumDias;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK)
	{
		ifnTrazaHilos( modulo, &pfLog, "OPEN CurAntPtoGes => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
	   	return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	FETCH CurAntPtoGes
	INTO  :lhaNumSecuenciaAnt, :szhaCodRutinaAnt  , :ihaOrdAplicaAnt  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1000;
 sqlstm.offset = (unsigned int  )2316;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)lhaNumSecuenciaAnt;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhaCodRutinaAnt;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)ihaOrdAplicaAnt;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo, &pfLog, "en FETCH CurAntPtoGes - %s",LOG00, sqlca.sqlerrm.sqlerrmc);
	   	return FALSE;
	}

	iRows=SQLROWS;
	if (iRows == 0 ) ifnTrazaHilos( modulo, &pfLog, "No existen acciones menores o igual al Pto de Gestion.",LOG02);
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL CLOSE CurAntPtoGes; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2343;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK)
	{
		ifnTrazaHilos( modulo, &pfLog, "CLOSE CurAntPtoGes - %s", LOG00,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	for (i=0;i<iRows;i++)
	{
		ifnTrazaHilos( modulo, &pfLog, "\t\tlhaNumSecuenciaAnt [%ld]", LOG06,lhaNumSecuenciaAnt[i]);
		ifnTrazaHilos( modulo, &pfLog, "\t\tszhaCodRutinaAnt   [%s]", LOG06,szhaCodRutinaAnt[i]);
		ifnTrazaHilos( modulo, &pfLog, "\t\tihaOrdAplicaAnt    [%d]", LOG06,ihaOrdAplicaAnt[i]);
	}

	*iFilas=iRows;
	return 0;

}

/* ================================================================================================ */
/*	Selecciona los reversas posterior al pto de gestion  									                   */
/* ================================================================================================ */
int ifnMayorPtoGestion (FILE **ptArchLog, int *iFilas, long lCodCliente, char *szCodCategoria, int *iNumDiasAux, sql_context ctxCont)
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long  lhCodCliente      ;
	char  szhCodCategoria[6];
	int   ihNumDias         ;
	char  szhLetra_A[2];	
	char  szhEstadoEJE[4];
	char  szhEstadoRER[4];
	int   ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 

char  modulo[] = "ifnMayorPtoGestion";
int iRows, i;
sql_context CXX;
struct sqlca sqlca;
FILE *pfLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	strcpy(szhLetra_A,"A");
	strcpy(szhEstadoEJE,"EJE");
	strcpy(szhEstadoRER,"RER");

	pfLog = *ptArchLog;
	ifnTrazaHilos( modulo, &pfLog, "En modulo [%s]",LOG03,modulo);
	lhCodCliente= lCodCliente;
	ihNumDias   = *iNumDiasAux;
	strcpy(szhCodCategoria,szCodCategoria);

	ifnTrazaHilos( modulo, &pfLog, "\tlhCodCliente    => [%ld].", LOG05, lhCodCliente);
	ifnTrazaHilos( modulo, &pfLog, "\tihNumDias       => [%d]. ", LOG05, ihNumDias);
	ifnTrazaHilos( modulo, &pfLog, "\tszhCodCategoria => [%s]. ", LOG05, szhCodCategoria);

	/***********************************************************************************/
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* Selecciona acciones del cliente mayores al numero de dias */
	/* EXEC SQL DECLARE CurPostPtoGes CURSOR FOR
	SELECT DISTINCT  A.NUM_SECUENCIA, R.REV_RUTINA, NVL( R.ORD_APLICACION, :ihValor_cero )
	FROM  CO_RUTINAS R, CO_ACCIONES A
	WHERE A.COD_CLIENTE =  :lhCodCliente
	AND   A.COD_ESTADO IN (:szhEstadoEJE, :szhEstadoRER )
	AND   R.COD_RUTINA  =  A.COD_RUTINA
	AND   R.TIP_RUTINA  = :szhLetra_A
	AND   R.REV_RUTINA IS NOT NULL
	AND   R.COD_RUTINA IN (	SELECT P.COD_RUTINA
				FROM CO_PTOSRUTINAS P
				WHERE P.COD_CATEGORIA = :szhCodCategoria
				AND P.NUM_DIAS > :ihNumDias)
   	ORDER BY NVL( R.ORD_APLICACION, :ihValor_cero ), R.REV_RUTINA; */ 


	if( sqlca.sqlcode != SQLOK)
	{
	   ifnTrazaHilos( modulo, &pfLog, "DECLARE CurPostPtoGes => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
	   return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL OPEN CurPostPtoGes ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0071;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2358;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhEstadoEJE;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhEstadoRER;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_A;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodCategoria;
 sqlstm.sqhstl[5] = (unsigned long )6;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihNumDias;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK)
	{
		ifnTrazaHilos( modulo, &pfLog, "OPEN CurPostPtoGes => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	FETCH CurPostPtoGes
	INTO  :lhaNumSecuenciaPos, :szhaCodRutinaPos  , :ihaOrdAplicaPos  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1000;
 sqlstm.offset = (unsigned int  )2405;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)lhaNumSecuenciaPos;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhaCodRutinaPos;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )6;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)ihaOrdAplicaPos;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo, &pfLog, "en FETCH CurPostPtoGes - %s",LOG00, sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	iRows=SQLROWS;
	if (iRows == 0 ) ifnTrazaHilos( modulo, &pfLog, "No existen acciones mayores al Pto de Gestion.",LOG02);
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL CLOSE CurPostPtoGes; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2432;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK)
	{
		ifnTrazaHilos( modulo, &pfLog, "CLOSE CurPostPtoGes - %s", LOG00,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	for (i=0;i<iRows;i++)
	{
		ifnTrazaHilos( modulo, &pfLog, "\t\tlhaNumSecuenciaPos [%ld]", LOG04,lhaNumSecuenciaPos[i]);
		ifnTrazaHilos( modulo, &pfLog, "\t\tszhaCodRutinaPos   [%s]", LOG04,szhaCodRutinaPos[i]);
		ifnTrazaHilos( modulo, &pfLog, "\t\tihaOrdAplicaPos    [%d]", LOG04,ihaOrdAplicaPos[i]);
	}
	*iFilas=iRows;
	return 0;
}

/* ================================================================================================ */
/*	Selecciona los clientes a ser excluidos totalmente    	   										          */
/* ================================================================================================ */
int ifnExclusionTotal (FILE **ptArchLog, td_Accion_Inversa *sthAccionInversa, long lCodCliente, int *iNumero_Dias, int *iTotAcciones, sql_context ctxCont)
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente ;
	char	szhQuery[2000] = "";
	int		ihValor_cero = 0;
	char	szhLetra_A[2];
	char	szhPND[4];

/* EXEC SQL END DECLARE SECTION; */ 

char  modulo[] = "ifnExclusionTotal";
sql_context CXX;
struct sqlca sqlca;
FILE *pfLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	strcpy(szhLetra_A,"A");
	strcpy(szhPND,"PND");
	
	pfLog = *ptArchLog;
	ifnTrazaHilos( modulo, &pfLog, "EXCLUSION TOTAL", LOG03 );
	lhCodCliente=lCodCliente;

	/* borra acciones pendientes que no sean reversas */

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	DELETE CO_ACCIONES
	WHERE COD_CLIENTE = :lhCodCliente
	AND   NUM_SECUENCIA IN (SELECT A.NUM_SECUENCIA
				FROM  CO_RUTINAS R,CO_ACCIONES A
				WHERE A.COD_CLIENTE = :lhCodCliente
				AND   A.NUM_SECUENCIA > :ihValor_cero
				AND   A.COD_ESTADO   = :szhPND
				AND   R.COD_RUTINA   = A.COD_RUTINA
				AND   R.TIP_RUTINA   = :szhLetra_A ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_ACCIONES  where (COD_CLIENTE=:b0 and NUM_SEC\
UENCIA in (select A.NUM_SECUENCIA  from CO_RUTINAS R ,CO_ACCIONES A where ((((\
A.COD_CLIENTE=:b0 and A.NUM_SECUENCIA>:b2) and A.COD_ESTADO=:b3) and R.COD_RUT\
INA=A.COD_RUTINA) and R.TIP_RUTINA=:b4)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2447;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhPND;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_A;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo, &pfLog, "en DELETE de CO_ACCIONES(2) : %s", LOG00, sqlca.sqlerrm.sqlerrmc );
	   	/* EXEC SQL ROLLBACK; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2482;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	   	return -1;
	}

	if( sqlca.sqlcode != SQLNOTFOUND )
		ifnTrazaHilos( modulo, &pfLog, "Se Borraron Acciones Pendientes",LOG05);

	/* define query para ver las acciones inversas a aplicar  */
	sprintf(szhQuery,	" SELECT DISTINCT A.NUM_SECUENCIA, R.REV_RUTINA, NVL( R.ORD_APLICACION, 0 ) "
				" FROM  CO_RUTINAS R, CO_ACCIONES A "
				" WHERE A.COD_CLIENTE  = %ld "
				" AND   A.COD_ESTADO IN ('EJE','RER') "
				" AND   R.COD_RUTINA = A.COD_RUTINA "
				" AND   R.TIP_RUTINA = 'A' "
				" AND   R.REV_RUTINA  IS NOT NULL "
				" ORDER BY NVL( R.ORD_APLICACION, 0 ), R.REV_RUTINA",lhCodCliente);

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL PREPARE SqlDinamico FROM :szhQuery; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2497;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
 sqlstm.sqhstl[0] = (unsigned long )2000;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if(sqlca.sqlcode != SQLOK)
	{
		ifnTrazaHilos( modulo, &pfLog, "en PREPARE : %s\nQuery:[%s]",LOG00,sqlca.sqlerrm.sqlerrmc, szhQuery);

	   	/* EXEC SQL ROLLBACK; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2516;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		return -1;  /*rollback */
	}


	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL DECLARE curAccionesInversas CURSOR FOR SqlDinamico; */ 



	if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
	{
		ifnTrazaHilos( modulo, &pfLog, "en DECLARE : %s",LOG00,sqlca.sqlerrm.sqlerrmc);

	   	/* EXEC SQL ROLLBACK; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2531;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	    	return -1; /* rollback */
	}
	else if (sqlca.sqlcode == SQLNOTFOUND)
	{
		ifnTrazaHilos( modulo, &pfLog, "No existen acciones reversas",LOG05);
	}
	else if (sqlca.sqlcode == SQLOK)
	{

			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
   		/* EXEC SQL OPEN curAccionesInversas; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2546;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



      		if(sqlca.sqlcode)
      		{
         		ifnTrazaHilos( modulo, &pfLog, "en OPEN : %s",LOG00,sqlca.sqlerrm.sqlerrmc);

	   		/* EXEC SQL ROLLBACK; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 31;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2561;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



         		return -1;  /* rollback */
      		}

     			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
      		/* EXEC SQL FETCH curAccionesInversas INTO :sthAccionInversa; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 31;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )50;
        sqlstm.offset = (unsigned int  )2576;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)sthAccionInversa->lNumSecuencia;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sthAccionInversa->szCodRutinaInv;
        sqlstm.sqhstl[1] = (unsigned long )6;
        sqlstm.sqhsts[1] = (         int  )6;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sthAccionInversa->iOrdAplicacion;
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
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* leerlas todas de una sola vez */


      		*iTotAcciones=SQLROWS;
      		if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
      		{
         		ifnTrazaHilos( modulo, &pfLog, "en FETCH : %s",LOG00,sqlca.sqlerrm.sqlerrmc);

	   		/* EXEC SQL ROLLBACK; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 31;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2603;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



         		return -1;  /* rollback */
		}

	         sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
      		/* EXEC SQL CLOSE curAccionesInversas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 31;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2618;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



      		if(sqlca.sqlcode)
      		{
         		ifnTrazaHilos( modulo, &pfLog, "en CLOSE : %s",LOG00,sqlca.sqlerrm.sqlerrmc);

	   		/* EXEC SQL ROLLBACK; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 31;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2633;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



         		return -1;  /*rollback */
      		}
	}

	ifnTrazaHilos( modulo, &pfLog, "Fin de cursor  curAccionesInversas",LOG03);
	*iNumero_Dias = 0;
	/*gbExclusionTotal = TRUE; Requerimiento de Soporte #83233 mgg 18-03-2009 */
	return 0;

} /*fin a ifnExclusionTotal*/



/****************************************************************/
/* Funcion vfnExcluidor 					*/
/* Utilizada como inicio del PTHREAD de EXCLUIDOR 	 	*/
/****************************************************************/
/* void *vfnExcluidor (void *x) */
void *vfnExcluidor (void *pstParam)
{
char modulo[] = "vfnExcluidor";
char szNomArchLog[30];				/* Nombre Log Hilo */
FILE *fstArchLog;
int  ierror, iRet, istatus;
int j, k, h;
sql_context CXX;
struct stCliente lsListaGral;
stLista lstCli;
struct sqlca sqlca;	/* Incorporado por PGonzalez 11-11-2004 Instancias BD */
PARAMETROS *stParametrosHilo = (PARAMETROS*) pstParam;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int   ihCountHilo         ;
   long  iDiffSeg = 0        ;
   char  szIniHilo        [9]; /* EXEC SQL VAR szIniHilo IS STRING(9); */ 

   char  szFinHilo        [9]; /* EXEC SQL VAR szFinHilo IS STRING(9); */ 

   char  szTmpHilo        [9];
   char  szPROCESO        [6];
   int   idhInsTrabajo       ;
/* EXEC SQL END DECLARE SECTION; */ 


	CXX = stParametrosHilo->CtxInsBas;
	/* EXEC SQL CONTEXT USE :CXX; */ 


  	k = stParametrosHilo->idThread;
   idhInsTrabajo = stParametrosHilo->idThread+1;

	memset( szIniHilo, '\0', sizeof( szIniHilo ) );
	memset( szFinHilo, '\0', sizeof( szFinHilo ) );
	memset( szTmpHilo, '\0', sizeof( szTmpHilo ) );
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			:szIniHilo := TO_CHAR(SYSDATE,:szhHH24MISS);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szIniHilo := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; END\
 ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2648;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szIniHilo;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	sprintf(szPROCESO,"EXCLU\0");
	rtrim(szPROCESO);

	sprintf(szNomArchLog,"%s_%02ld\0",szPROCESO,idhInsTrabajo);
	istatus=ifnAbreArchivoLogHil(szNomArchLog, &fstArchLog);

	ifnTrazaHilos( modulo,&fstArchLog, "=============================================================", LOG03);
	ifnTrazaHilos( modulo,&fstArchLog, "*** INICIO ARCHIVO LOG HIJO EXCLUIDOR  --->  [%s]\n\n", LOG02,szNomArchLog);

	/*************************************************************************************************/
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	ifnTrazaHilos( modulo, &fstArchLog, "Revisando Estadistica Hilo [%d]\n", LOG03, idhInsTrabajo);
	/* EXEC SQL
	SELECT COUNT(*)
	INTO   :ihCountHilo
	FROM   CO_ESTADISEVA_TO
	WHERE  COD_PROCESO = :szPROCESO
	AND    SECUENCIA   = :idhInsTrabajo
	AND    TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_ESTADISEVA_TO where ((COD\
_PROCESO=:b1 and SECUENCIA=:b2) and TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2671;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCountHilo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szPROCESO;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&idhInsTrabajo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo, &fstArchLog, "SELECT count(*) CO_ESTADISEVA_TO idhInsTrabajo [%d] - %s.", LOG00, idhInsTrabajo, sqlca.sqlerrm.sqlerrmc );
		thr_exit(NULL);
	}

	if ((ihCountHilo == 0) || (sqlca.sqlcode == SQLNOTFOUND)) {
		/* Insertando estadisticas del proceso hijo.  */
		if (ifnInsertaEstadisticasContex( &fstArchLog, idhInsTrabajo, szPROCESO, CXX) != 0 ) thr_exit(NULL);
	}
	/*************************************************************************************************/

	for(j = 1, lstCli = pInicio[k] ; lstCli ;)
	{
		yield2();
		iRet=0;
		iTot_Clies[idhInsTrabajo]++;
		ierror=Leer_element(pInicio[k] ,j,&lsListaGral);
   	if (ierror == 0)
   	{

			ifnTrazaHilos( modulo, &fstArchLog, "****************************************************************************************", LOG03);
			ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsListaGral.lCod_Cliente  [%ld]", LOG03, j, lsListaGral.lCod_Cliente  );
			ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsListaGral.szNum_Ident   [%s]", LOG03, j, lsListaGral.szNum_Ident   );
			ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsListaGral.szCod_Tipident[%s]", LOG03, j, lsListaGral.szCod_Tipident);
			ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsListaGral.szCodTipClie  [%s]", LOG03, j, lsListaGral.szCodTipClie  );
			ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsListaGral.dImportePago  [%f]", LOG03, j, lsListaGral.dImportePago  );
			ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsListaGral.iProcedencia  [%i]", LOG03, j, lsListaGral.iProcedencia  );


			iRet = ifnProcesaPago(  &fstArchLog
					, iContador
					, lsListaGral.lCod_Cliente
					, lsListaGral.szNum_Ident
					, lsListaGral.szCod_Tipident
					, lsListaGral.szCodTipClie
					, lsListaGral.dImportePago
					, &iSqlAuxStatus
					, &lContCliBD
					, szDescError
					, lsListaGral.iProcedencia
					, CXX
					);

			iContador++;
			if (iRet == -1)
			{
				ifnTrazaHilos( modulo,&fstArchLog, "Error en la funcion ifnClienteEvaluar con Cliente [%ld].. \n", LOG02,lsListaGral.lCod_Cliente);
				/* Aqui el Flag de cliente ya viene en -1 por lo que al grabar no hace nada*/
			}
			lCliesxHilo[k]++;
		}

		j++;
		lstCli = lstCli->sgte;
	}/* fin for(j = 1, lstCli = pInicio[k] ; lstCli ;) */

	ifnTrazaHilos( modulo, &fstArchLog, "\n\tConsultando Hijo en CO_ESTADISEVA_TO.   (idhInsTrabajo :[%d])", LOG03,idhInsTrabajo);
	/**********************************************************************************************/

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT NVL(SUM(CNT_CLIENTES_PROC),:ihValor_cero)
	INTO   :ihCountHilo
	FROM   CO_ESTADISEVA_TO
	WHERE  COD_PROCESO = :szPROCESO
	AND    SECUENCIA   = :idhInsTrabajo
	AND    TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum(CNT_CLIENTES_PROC),:b0) into :b1  from CO_EST\
ADISEVA_TO where ((COD_PROCESO=:b2 and SECUENCIA=:b3) and TRUNC(FEC_INGRESO)=T\
RUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2698;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCountHilo;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szPROCESO;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&idhInsTrabajo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo, &fstArchLog, "SELECT count(*) CO_ESTADISEVA_TO idhInsTrabajo [%d] - %s.", LOG00, idhInsTrabajo, sqlca.sqlerrm.sqlerrmc );

	} else if (sqlca.sqlcode == SQLNOTFOUND)  {
		ifnTrazaHilos( modulo, &fstArchLog, "Registro deberia existir..!!.", LOG02);

	} else  {

		ifnTrazaHilos( modulo, &fstArchLog, "\tihCountHilo  [%d]   iTot_Clies[idhInsTrabajo] [%d]", LOG03,ihCountHilo,iTot_Clies[idhInsTrabajo]);
		if (ihCountHilo < iTot_Clies[idhInsTrabajo]) {

	      sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL EXECUTE
				BEGIN
					:szFinHilo := TO_CHAR(SYSDATE,:szhHH24MISS);
				END;
			END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin :szFinHilo := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; E\
ND ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2729;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szFinHilo;
   sqlstm.sqhstl[0] = (unsigned long )9;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			iDiffSeg = ifnRestaHoras( szIniHilo, szFinHilo, szTmpHilo );
			ifnTrazaHilos( modulo, &fstArchLog, "Actualizar CO_ESTADISEVA_TO con :\n\t\tiDiffSeg  [%d]\n\t\tszIniHilo [%s]\n\t\tszFinHilo [%s]", LOG03,iDiffSeg,szIniHilo,szFinHilo);

			/* actualizando estadisticas del proceso hijo. Secuencia corresponde a la del thread */
			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			ifnTrazaHilos( modulo, &fstArchLog, "\tiTot_Clies   [%d]\n\t\tszPROCESO   [%s]\n\t\tidhInsTrabajo[%d]", LOG03,iTot_Clies[idhInsTrabajo],szPROCESO,idhInsTrabajo);
			/* EXEC SQL
			UPDATE CO_ESTADISEVA_TO SET
					 TIEMPO_PROCESO    = :iDiffSeg ,
					 CNT_CLIENTES_PROC = :iTot_Clies[idhInsTrabajo],
					 FEC_INGRESO       = SYSDATE
			WHERE  COD_PROCESO       = :szPROCESO
			AND    SECUENCIA         = :idhInsTrabajo
			AND    TRUNC(FEC_INGRESO)= TRUNC(SYSDATE); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_ESTADISEVA_TO  set TIEMPO_PROCESO=:b0,CNT_CLIENT\
ES_PROC=:b1,FEC_INGRESO=SYSDATE where ((COD_PROCESO=:b2 and SECUENCIA=:b3) and\
 TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2752;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&iDiffSeg;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&iTot_Clies[idhInsTrabajo];
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szPROCESO;
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&idhInsTrabajo;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
			   ifnTrazaHilos( modulo, &fstArchLog, "Error al actualizar estadistica del Hilo [%d]", LOG03,idhInsTrabajo );
			}
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2783;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		}
	}
	/**********************************************************************************************/
	iTot_Clies[idhInsTrabajo]=0;


	ifnTrazaHilos( modulo,&fstArchLog, "*** FIN ARCHIVO LOG HIJO EXCLUIDOR --->  [%s]\n\n", LOG02,szNomArchLog);
	ifnTrazaHilos( modulo,&fstArchLog, "=============================================================", LOG03);
	if (istatus == 0 )
		vfnCierraArchivoLogHil(&fstArchLog);

	thr_exit((void *)stParametrosHilo->idThread);
	return 0;
}




/* ============================================================================= */
/* Funcion que ejecuta los hilos que se hayan generado de acuerdo al tamaño de   */
/*	la lista que guarda los clientes a procesar                          	 */
/* ============================================================================= */
int ifnEjecutaHilos()
{
char modulo[] = "ifnEjecutaHilos";
int  i, error=0;

	thr_setconcurrency(iNumeroHilos+1);

	for(i = 0, iSec_Hijo = 0; i < iNumeroHilos; i++)
	{
		iSec_Hijo++;
		lCliesxHilo[i]=0;

		/* EXEC SQL CONTEXT USE DEFAULT; */ 

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/

		error = thr_create (NULL, NULL, vfnExcluidor, (void*) (&stParametrosHilos[i]), NULL, &idHilo[i] );

		if (error != 0)
		{
		/* Comprobamos el error al arrancar el thread */
		ifnTrazasLog( modulo, "No puedo crear thread", LOG01);
		exit (STATUS_ERR);
		}
		sleep(1);
	}

	for(i = 0; i < iNumeroHilos; i++) {
		thr_join(idHilo[i], NULL, NULL );
	}

	/* EXEC SQL CONTEXT USE DEFAULT; */ 


	return 0;
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
