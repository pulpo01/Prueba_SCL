
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
static const struct sqlcxp sqlfpn =
{
    22,
    "./pc/CO_libprocesos.pc"
};


static unsigned int sqlctx = 221174083;


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
   unsigned char  *sqhstv[16];
   unsigned long  sqhstl[16];
            int   sqhsts[16];
            short *sqindv[16];
            int   sqinds[16];
   unsigned long  sqharm[16];
   unsigned long  *sqharc[16];
   unsigned short  sqadto[16];
   unsigned short  sqtdso[16];
} sqlstm = {12,16};

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

 static const char *sq0009 = 
"select COD_PTOGEST ,NUM_DIAS ,ANT_PTOGEST ,COD_ESTADO ,COD_GESTION ,COD_CATE\
GORIA ,NVL(IND_PRORROGA,:b0) ,NUM_PROCESO  from CO_PTOSGESTION where (COD_ESTA\
DO=:b1 and COD_CATEGORIA=:b2) order by NUM_DIAS desc             ";

 static const char *sq0015 = 
"select distinct COD_CATEGORIA  from CO_PTOSGESTION where COD_ESTADO=:b0     \
      ";

 static const char *sq0018 = 
"select NUM_DIAS ,NUM_PROCESO  from CO_PTOSGESTION where (COD_CATEGORIA=:b0 a\
nd COD_ESTADO=:b1) union select :b2 NUM_DIAS ,:b2 NUM_PROCESO  from DUAL  orde\
r by NUM_DIAS desc             ";

 static const char *sq0025 = 
"select NOM_PARAMETRO ,VAL_PARAMETRO  from GED_PARAMETROS where (COD_MODULO=:\
b0 and COD_PRODUCTO=:b1)           ";

 static const char *sq0035 = 
"select distinct COD_CLIENTE  from GE_CLIENTES where (NUM_IDENT=:b0 and COD_T\
IPIDENT=:b1)           ";

 static const char *sq0071 = 
"select CR.TIP_RUTINA ,CR.COD_RUTINA ,:b0 ,:b1 ,:b1 ,:b0 ,:b4 ,CR.IND_PRORROG\
A ,NVL(CR.IND_DUPLICABLE,:b5) ,NVL(CR.MAX_DIARIO,:b4) ,NVL(CPR.COD_PARAM,:b7) \
 from CO_RUTINAS CR ,CO_PTOSRUTINAS CPR where ((((CPR.COD_PTOGEST=:b8 and CPR.\
COD_CATEGORIA=:b9) and CPR.NUM_PROCESO=:b10) and CPR.COD_RUTINA=CR.COD_RUTINA)\
 and CR.TIP_RUTINA=:b11) order by 1,2 desc             ";

 static const char *sq0072 = 
"select unique CVRP.COD_RUTINA ,CRR.NOM_RUTINA ,CVRR.TIP_RETORNO ,CVRP.VAL_RE\
TORNO ,NVL(CVRP.VAL_RANGO,:b0) ,CVRP.IND_EXCLUYE ,CVRP.DIA_PRORROGA  from CO_V\
ALRETRUT CVRR ,CO_VALRETPTO CVRP ,CO_RUTINAS CRR where ((((CVRP.COD_PTOGEST=:b\
1 and CVRP.COD_CATEGORIA=:b2) and CVRP.NUM_PROCESO=:b3) and CVRR.COD_RUTINA=CV\
RP.COD_RUTINA) and CRR.COD_RUTINA=CVRP.COD_RUTINA) order by CVRP.COD_RUTINA de\
sc             ";

 static const char *sq0074 = 
"select unique CVRP.COD_RUTINA ,CRR.NOM_RUTINA ,CVRR.TIP_RETORNO ,CVRP.VAL_RE\
TORNO ,NVL(CVRP.VAL_RANGO,:b0) ,CVRP.IND_EXCLUYE ,CVRP.DIA_PRORROGA  from CO_V\
ALRETRUT CVRR ,CO_VALRETPTO CVRP ,CO_RUTINAS CRR where ((((CVRP.COD_PTOGEST=:b\
1 and CVRP.COD_CATEGORIA=:b2) and CVRP.NUM_PROCESO=:b3) and CVRR.COD_RUTINA=CV\
RP.COD_RUTINA) and CRR.COD_RUTINA=CVRP.COD_RUTINA) order by CVRP.COD_RUTINA de\
sc             ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,78,0,4,36,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
32,0,0,2,61,0,4,57,0,0,4,3,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,2,5,0,0,
63,0,0,3,78,0,4,70,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
90,0,0,4,66,0,4,109,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
113,0,0,5,96,0,6,128,0,0,4,4,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
144,0,0,6,84,0,4,140,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
171,0,0,7,84,0,4,164,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
198,0,0,8,125,0,6,199,0,0,4,4,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
229,0,0,9,219,0,9,352,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,
256,0,0,9,0,0,13,360,0,0,8,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,3,0,0,
303,0,0,9,0,0,15,371,0,0,0,0,0,1,0,
318,0,0,10,89,0,3,471,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
341,0,0,11,226,0,5,513,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
380,0,0,12,114,0,4,551,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,97,0,0,
411,0,0,13,118,0,4,588,0,0,4,3,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
442,0,0,14,122,0,3,628,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
469,0,0,15,82,0,9,678,0,0,1,1,0,1,0,1,97,0,0,
488,0,0,15,0,0,13,686,0,0,1,0,0,1,0,2,97,0,0,
507,0,0,15,0,0,15,697,0,0,0,0,0,1,0,
522,0,0,16,103,0,6,766,0,0,4,4,0,1,0,2,3,0,0,1,5,0,0,1,97,0,0,1,97,0,0,
553,0,0,17,78,0,4,790,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,97,0,0,
580,0,0,18,185,0,9,865,0,0,4,4,0,1,0,1,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
611,0,0,18,0,0,13,872,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
634,0,0,18,0,0,15,880,0,0,0,0,0,1,0,
649,0,0,19,65,0,5,1013,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
672,0,0,20,96,0,5,1066,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
699,0,0,21,67,0,4,1123,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
722,0,0,22,184,0,4,1164,0,0,6,5,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,
761,0,0,23,88,0,4,1206,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,97,0,0,
792,0,0,24,88,0,4,1214,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,97,0,0,
823,0,0,25,111,0,9,1281,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
846,0,0,25,0,0,13,1291,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
869,0,0,25,0,0,15,1298,0,0,0,0,0,1,0,
884,0,0,26,112,0,5,1438,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
915,0,0,27,107,0,4,1500,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
946,0,0,28,89,0,4,1515,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
973,0,0,29,186,0,4,1532,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1004,0,0,30,308,0,4,1557,0,0,12,11,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1067,0,0,31,392,0,4,1597,0,0,8,6,0,1,0,2,5,0,0,2,5,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,
1114,0,0,32,80,0,5,1630,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
1137,0,0,33,77,0,5,1645,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,
1164,0,0,34,59,0,5,1657,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
1187,0,0,35,99,0,9,1810,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
1210,0,0,35,0,0,13,1822,0,0,1,0,0,1,0,2,3,0,0,
1229,0,0,36,1054,0,4,1859,0,0,16,4,0,1,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,
5,0,0,1,97,0,0,
1308,0,0,37,0,0,17,1977,0,0,1,1,0,1,0,1,5,0,0,
1327,0,0,37,0,0,45,1993,0,0,0,0,0,1,0,
1342,0,0,37,0,0,13,2017,0,0,8,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
2,5,0,0,2,5,0,0,2,3,0,0,
1389,0,0,38,99,0,4,2061,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,
1420,0,0,37,0,0,15,2157,0,0,0,0,0,1,0,
1435,0,0,35,0,0,15,2176,0,0,0,0,0,1,0,
1450,0,0,39,112,0,4,2231,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
1473,0,0,40,173,0,4,2240,0,0,6,5,0,1,0,2,5,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,
1512,0,0,41,151,0,4,2270,0,0,7,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,2,97,0,0,1,97,
0,0,1,97,0,0,1,5,0,0,
1555,0,0,42,157,0,6,2525,0,0,4,4,0,1,0,2,5,0,0,1,3,0,0,1,97,0,0,2,5,0,0,
1586,0,0,43,0,0,17,2652,0,0,1,1,0,1,0,1,97,0,0,
1605,0,0,43,0,0,21,2667,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
1632,0,0,44,78,0,4,2765,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
1659,0,0,45,112,0,4,2841,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1690,0,0,46,99,0,4,3022,0,0,4,1,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1721,0,0,47,161,0,4,3040,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,
1748,0,0,48,75,0,4,3386,0,0,2,1,0,1,0,2,4,0,0,1,3,0,0,
1771,0,0,49,272,0,4,3397,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,
1810,0,0,50,107,0,4,3467,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1841,0,0,51,89,0,4,3483,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
1868,0,0,52,186,0,4,3500,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1899,0,0,53,308,0,4,3528,0,0,12,11,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1962,0,0,54,392,0,4,3567,0,0,8,6,0,1,0,2,5,0,0,2,5,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,
2009,0,0,55,66,0,4,3632,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
2032,0,0,56,96,0,6,3654,0,0,4,4,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
2063,0,0,57,84,0,4,3668,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
2090,0,0,58,84,0,4,3693,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
2117,0,0,59,117,0,6,3730,0,0,4,4,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2148,0,0,60,106,0,4,3777,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
2179,0,0,61,119,0,6,3806,0,0,4,4,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2210,0,0,62,78,0,4,3852,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
2237,0,0,63,61,0,4,3878,0,0,4,3,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,2,5,0,0,
2268,0,0,64,78,0,4,3893,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
2295,0,0,65,97,0,6,3928,0,0,4,4,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,
2326,0,0,66,90,0,4,3974,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
2353,0,0,67,77,0,5,4007,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,
2380,0,0,68,59,0,5,4018,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
2403,0,0,69,80,0,5,4029,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
2426,0,0,70,112,0,5,4072,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2457,0,0,71,365,0,9,4181,0,0,12,12,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,97,0,0,
2520,0,0,71,0,0,13,4188,0,0,11,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
2579,0,0,71,0,0,15,4196,0,0,0,0,0,1,0,
2594,0,0,72,403,0,9,4299,0,0,4,4,0,1,0,1,97,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
2625,0,0,72,0,0,13,4306,0,0,7,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,3,0,0,
2668,0,0,72,0,0,15,4314,0,0,0,0,0,1,0,
2683,0,0,73,184,0,4,4456,0,0,6,5,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,
2722,0,0,74,403,0,9,4539,0,0,4,4,0,1,0,1,97,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
2753,0,0,74,0,0,13,4546,0,0,7,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,3,0,0,
2796,0,0,74,0,0,15,4554,0,0,0,0,0,1,0,
2811,0,0,75,66,0,4,4653,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
2834,0,0,76,96,0,6,4672,0,0,4,4,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
2865,0,0,77,84,0,4,4684,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
2892,0,0,78,84,0,4,4708,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
2919,0,0,79,125,0,6,4743,0,0,4,4,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
2950,0,0,80,84,0,5,4814,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
2977,0,0,81,135,0,5,4829,0,0,5,5,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,
3012,0,0,82,78,0,4,4884,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
3039,0,0,83,105,0,6,4898,0,0,3,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
3066,0,0,84,78,0,4,4910,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
3093,0,0,85,140,0,4,4969,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,
3132,0,0,86,484,0,4,4990,0,0,14,13,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,
3203,0,0,87,417,0,3,5057,0,0,1,1,0,1,0,1,3,0,0,
3222,0,0,88,47,0,2,5079,0,0,1,1,0,1,0,1,3,0,0,
3241,0,0,89,95,0,4,5117,0,0,3,2,0,1,0,2,9,0,0,1,97,0,0,1,97,0,0,
3268,0,0,90,709,0,3,5130,0,0,4,4,0,1,0,1,9,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
3299,0,0,91,46,0,2,5157,0,0,1,1,0,1,0,1,3,0,0,
3318,0,0,92,265,0,3,5187,0,0,1,1,0,1,0,1,3,0,0,
3337,0,0,93,46,0,2,5207,0,0,1,1,0,1,0,1,3,0,0,
3356,0,0,94,107,0,4,5268,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
3387,0,0,95,89,0,4,5283,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
3414,0,0,96,186,0,4,5300,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
3445,0,0,97,308,0,4,5325,0,0,12,11,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
3508,0,0,98,392,0,4,5365,0,0,8,6,0,1,0,2,5,0,0,2,5,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,
3555,0,0,99,80,0,5,5399,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
3578,0,0,100,63,0,5,5416,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
3601,0,0,101,77,0,5,5429,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,
3628,0,0,102,59,0,5,5442,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
3651,0,0,103,89,0,3,5480,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
3674,0,0,43,0,0,17,5566,0,0,1,1,0,1,0,1,97,0,0,
3693,0,0,43,0,0,21,5573,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
3720,0,0,104,78,0,4,5631,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
3747,0,0,105,112,0,4,5691,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
};


/* ============================================================================= 
 Tipo          :  FUNCIONES GENERALES 
 Nombre        :  CO_libprocesos.pc
 Descripcion   :  Rutinas propias de los procesos.
 Fecha         :  14-Oct-2004  GAC.
 Creada 14-10-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor
 Version 4.0.0 
 ============================================================================ */
#define _COLIBPROCESOS_PC_
#include <CO_deftypes.h>
#include "CO_stPtoRut.h"
#include "CO_libprocesos.h"
#include "CO_libgenerales.h"
#include <lstcclib.h>

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




int ifnDetFeriados( char *szFecha ) /* fmto : YYYYMMDD */
{
char modulo[]="ifnDetFeriados";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCntRows;
	char szhFecha[9];             /* EXEC SQL VAR szhFecha IS STRING (9); */ 
		  /*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
	char szhNvaFecha[9];          /* EXEC SQL VAR szhNvaFecha IS STRING (9); */ 
	  /*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
	char szhFormatoFecha[9];      /* EXEC SQL VAR szhFormatoFecha IS STRING (9); */ 
 /*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
/* EXEC SQL END DECLARE SECTION; */ 

    
   strcpy(szhFecha       ,szFecha);               
   strcpy(szhFormatoFecha,"YYYYMMDD"); /* fmto : YYYYMMDD */
  
    
	/* determina dia es feriado */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COUNT(*)  
	INTO :ihCntRows
	FROM TA_DIASFEST
	WHERE FEC_DIAFEST = TO_DATE(:szhFecha,:szhFormatoFecha); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from TA_DIASFEST where FEC_DIAFES\
T=TO_DATE(:b1,:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[2] = (unsigned long )9;
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


   if (SQLCODE)  {
      ifnTrazasLog(modulo," TA_DIASFEST(1) : %s",LOG00,SQLERRM);
      return -1;
	}
	if (ihCntRows > 0) /* es feriado */
		return 9;
    
	/* le suma un dia a la fecha */
	/*EXEC SQL EXECUTE
		BEGIN
			:szhNvaFecha:=TO_CHAR(TO_DATE(:szhFecha,:szhFormatoFecha) + 1,:szhFormatoFecha);
		END;
	END-EXEC;*/

    /*Inicio HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT TO_CHAR(TO_DATE(:szhFecha,:szhFormatoFecha) + 1,:szhFormatoFecha)
	INTO :szhNvaFecha
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR((TO_DATE(:b0,:b1)+1),:b1) into :b3  from DUAL\
 ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )32;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhNvaFecha;
 sqlstm.sqhstl[3] = (unsigned long )9;
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

	
	/*Fin */

   if (SQLCODE) 	{
   	ifnTrazasLog(modulo," DUAL : %s",LOG00,SQLERRM);
   	return -1;
	}

	/* determina dia es visperas de feriado */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL 
   SELECT COUNT(*)  
	INTO :ihCntRows
	FROM TA_DIASFEST
	WHERE FEC_DIAFEST = TO_DATE(:szhNvaFecha,:szhFormatoFecha); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(*)  into :b0  from TA_DIASFEST where FEC_DIAF\
EST=TO_DATE(:b1,:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )63;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNvaFecha;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
   sqlstm.sqhstl[2] = (unsigned long )9;
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


   if (SQLCODE)  {
       	ifnTrazasLog(modulo," TA_DIASFEST(2) : %s",LOG00,SQLERRM);
       	return -1;
	}
	if (ihCntRows > 0) /* es visperas de feriado */
		return 8;

	return 0;
}



int ifnDetFechaEjecucion( char *szCodAccion, char *szFecEjecucion) /* fmto: YYYYMMDD */
{
char modulo[]="ifnDetFechaEjecucion";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCntRows;
	int  ihCntDias;
	int  ihCodDia;
	char szhCodAccion   [6];
	char szhNvaFecha    [9];
	char szhFecEjecucion[9];
	char szhFormatoFecha[9];
	char szhDia[2];
/* EXEC SQL END DECLARE SECTION; */ 

    
   ifnTrazasLog( modulo, "Entre en %s con Accion %s  Fecha Ejec %s ", LOG06, modulo, szCodAccion, szFecEjecucion );

   strcpy(szhCodAccion,szCodAccion);
   strcpy(szhFormatoFecha,"YYYYMMDD"); /* fmto : YYYYMMDD */
	strcpy(szhDia,"D");
    
	/* ve si accion tiene restricciones */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL 
   SELECT COUNT(*)  
	INTO  :ihCntRows
	FROM  CO_DIASNOEJEC
	WHERE COD_RUTINA = :szhCodAccion; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where COD_RU\
TINA=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )90;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
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

 
   if (SQLCODE) {
        ifnTrazasLog(modulo," CO_DIASNOEJEC(1) : %s",LOG00,SQLERRM);
        return -1;
   }
	if (ihCntRows == 0) return 0; /* la accion se puede ejecutar cualquier dia */

   strcpy(szhNvaFecha,szFecEjecucion); /* fecha tentativa */

	while (1)
	{
    	strcpy(szhFecEjecucion,szhNvaFecha); /* verificando la nueva fecha */

		/* determina dia de la semana de la fecha  1:Domingo,2:lunes,...,7:sabado*/
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE
			BEGIN
				:ihCodDia:=TO_CHAR(TO_DATE(:szhFecEjecucion,:szhFormatoFecha),:szhDia);
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :ihCodDia := TO_CHAR ( TO_DATE ( :szhFecEjecucion , :\
szhFormatoFecha ) , :szhDia ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )113;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodDia;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDia;
  sqlstm.sqhstl[3] = (unsigned long )2;
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


    	if (SQLCODE)  {
        	ifnTrazasLog(modulo," DUAL(1) : %s",LOG00,SQLERRM);
        	return -1;
    	}
    
		/* ve si accion tiene restriccion para ese dia */
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
    	/* EXEC SQL 
    	SELECT COUNT(*)  
		INTO :ihCntRows
		FROM CO_DIASNOEJEC
		WHERE COD_RUTINA = :szhCodAccion 
		AND COD_DIA = :ihCodDia; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where (COD\
_RUTINA=:b1 and COD_DIA=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )144;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodDia;
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


    	if (SQLCODE)
    	{
        	ifnTrazasLog(modulo," CO_DIASNOEJEC(2) : %s",LOG00,SQLERRM);
        	return -1;
    	}
    	
		if (ihCntRows == 0)  /* la accion no tiene restriccion para ese dia */
		{
			/* valida si la fecha es feriado o visperas de feriado */
			ihCodDia = ifnDetFeriados(szhFecEjecucion); /* fmto YYYYMMDD */
			if ( ihCodDia < 0 ) 
			{
				return -1;
			}
			if ( ihCodDia > 0 ) /* es feriado o visperas de feriado */
			{
				/* valida si tiene restricciones para feriados o visperas */
				sqlca.sqlcode=0; /* XO-200508280498 rvc */
    			/* EXEC SQL 
    			SELECT COUNT(*)  
			   INTO :ihCntRows
			   FROM CO_DIASNOEJEC
			   WHERE COD_RUTINA = :szhCodAccion 
				AND COD_DIA = :ihCodDia; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 4;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where (C\
OD_RUTINA=:b1 and COD_DIA=:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )171;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
       sqlstm.sqhstl[1] = (unsigned long )6;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&ihCodDia;
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

  /* 8 o 9 */
    			if (SQLCODE)
    			{
        			ifnTrazasLog(modulo," CO_DIASNOEJEC(3) : %s",LOG00,SQLERRM);
        			return -1;
    			}
				if (ihCntRows == 0)  /* la accion no tiene restriccion para ese dia */
				{
					break; /* es una fecha valida */
				}
				else /* la accion tiene restricciones para feriados o visperas */
				{
					if ( ihCodDia == 8 ) /* visperas de feriado */
						ihCntDias = 2; /* le sumara dos dias a la fecha */
					else /* es feriado */
						ihCntDias = 1; /* le sumara un dia a la fecha */
				}
			}
			else /* no es feriado ni visperas */
			{
				break; /* es una fecha valida */
			}
		}
		else /* tiene restriccion para ese dia */
		{
			ihCntDias = 1; /* le sumara un dia a la fecha */
		}

		/* determina nueva fecha */
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE
			BEGIN
				:szhNvaFecha:=TO_CHAR((TO_DATE(:szhFecEjecucion,:szhFormatoFecha) + :ihCntDias),:szhFormatoFecha);
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :szhNvaFecha := TO_CHAR ( ( TO_DATE ( :szhFecEjecucio\
n , :szhFormatoFecha ) + :ihCntDias ) , :szhFormatoFecha ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )198;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhNvaFecha;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCntDias;
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


    	if (SQLCODE) 
    	{
       		ifnTrazasLog(modulo," DUAL(2) : %s",LOG00,SQLERRM);
       		return -1;
    	}
	} /* end while */
    
    strcpy(szFecEjecucion,szhFecEjecucion);
    return 0;
}








/* ============================================================================= */
/* Funcion que Abre archivo de log de hilos en modo append			 	            */
/* ============================================================================= */
int ifnAbreArchivoLogHil(char *szNomArch, FILE **fsArchLog)
{
char modulo[] = "ifnAbreArchivoLogHil";
char szArchivoLog[256], szComando[256]; 
static char szAux[9];
FILE *fh;

   memset( szArchivoLog, '\0', sizeof( szArchivoLog ) ); /* log */
   
   sema_wait(&semaflock);
   strcpy( szAux, (char *)szSysDate( "YYYYMMDD" ) );
   sema_post(&semaflock);
   sprintf( szComando, "/usr/bin/mkdir -p %s/%s", stStatus.szLogPathGene, szAux );
   if( system( szComando ) != 0 )    {
        fprintf( stderr, "Error al intentar crear directorio de Log\n" );
        fflush ( stderr );
        return 1;
   }
    
   sprintf( szArchivoLog, "%s/%s/%s.log", stStatus.szLogPathGene, szAux, szNomArch );
    
   if( ( fh = fopen( szArchivoLog, "a" ) ) == (FILE*)NULL )   {    
        fprintf( stderr, "Error al crear archivo de Log.\n" );
        fflush( stderr );
        return 1;    
   }
    
   fprintf( fh, "\n\n\t - APERTURA DE ARCHIVO SEGUN UNIX - < %s >\n",szGetTime(1));
   *fsArchLog=fh;
   return 0;
}/* end ifnAbreArchivoLog */

/* ============================================================================= */
/* Funcion que Abre archivo de log de hilos para ejecutor en modo append			*/
/* ============================================================================= */
int ifnAbreArchivoLogHiloEjecEx(char *szNomArch, FILE **fsArchLog, char *szSysdate)
{
char modulo[] = "ifnAbreArchivoLogHiloEjecEx";
char szArchivoLog[256], szComando[256]; 
FILE *fh;

   memset( szArchivoLog, '\0', sizeof( szArchivoLog ) ); /* log */
   sprintf( szComando, "/usr/bin/mkdir -p %s/%s", stStatus.szLogPathGene, szSysdate);
   if( system( szComando ) != 0 )    {
        fprintf( stderr, "Error al intentar crear directorio de Log\n" );
        fflush ( stderr );
        return 1;
   }
    
   sprintf( szArchivoLog, "%s/%s/%s.log", stStatus.szLogPathGene, szSysdate, szNomArch );
    
   if( ( fh = fopen( szArchivoLog, "a" ) ) == (FILE*)NULL )   {    
        fprintf( stderr, "Error al crear archivo de Log.\n" );
        fflush( stderr );
        return 1;    
   }
    
   fprintf( fh, "\n\n\t - APERTURA DE ARCHIVO SEGUN UNIX - < %s >\n",szGetTime(1));
   *fsArchLog=fh;
   return 0;
}/* end ifnAbreArchivoLogHiloEjecEx */


/* ============================================================================= */
/* Funcion que cierra los descriptores de los archivos de logs                   */
/* ============================================================================= */
void vfnCierraArchivoLogHil(FILE **fstArch)
{
char modulo[] = "vfnCierraArchivoLogHil";
FILE *fh;

    fh = *fstArch;
    fprintf( fh, "\n\n\t - CIERRE DE ARCHIVO SEGUN UNIX - < %s >\n\n",szGetTime(1) );
    if( fclose( fh ) != 0 ){    
        fprintf( stderr,"Error al cerrar archivo de Log\n" );
        fflush( stderr );
    }

    return;
} /* end vfnCierraArchivoLog */



/*======================================================================================*/
/* Carga los puntos de gestion activos													*/
/*======================================================================================*/
int ifnCargaPtosGest( lista_Pto *pPtoGestion, char *szCodCategoria  )
{ 
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	  szhCodCategoria[6] = "";
	td_PtoGestion sthPtoGestionLoc;
	char  szhLetra_H  [2];
	char  szhFiller   [2];
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnCargaPtosGest";
int  iTotalRows = 0, i = 0, sts=-1;
lista_Pto   pPtoGestionAux;
lista_Crit  LCriterios;
lista_Acc   LAcciones;
	
	ifnTrazasLog( modulo, "szCodCategoria :%s#", LOG05, szCodCategoria );
   strcpy(szhCodCategoria,szCodCategoria);
   strcpy(szhLetra_H,"H");
   strcpy(szhFiller," ");

	sqlca.sqlcode=0; /* XO-200508280498 rvc */        
	/* EXEC SQL DECLARE curPtoGestionEV CURSOR FOR
	SELECT COD_PTOGEST,
			NUM_DIAS,
			ANT_PTOGEST,
			COD_ESTADO,
			COD_GESTION,
			COD_CATEGORIA,
			NVL( IND_PRORROGA, :szhFiller ),
			NUM_PROCESO
	FROM	CO_PTOSGESTION
	WHERE	COD_ESTADO = :szhLetra_H
	AND   COD_CATEGORIA = :szhCodCategoria
	ORDER BY NUM_DIAS DESC; */ 

	
	if( SQLCODE )
	{
		ifnTrazasLog( modulo, "en DECLARE : %s", LOG00, SQLERRM );
		return -1;
	}
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL OPEN curPtoGestionEV; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0009;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )229;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodCategoria;
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


	if( SQLCODE ) 
	{
		ifnTrazasLog( modulo, "en OPEN : %s", LOG00, SQLERRM );
		return -1;
	}
   
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL FETCH curPtoGestionEV
	INTO	:sthPtoGestionLoc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )150;
 sqlstm.offset = (unsigned int  )256;
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
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		return -1;
	}
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL CLOSE curPtoGestionEV; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )303;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE )
	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}
        sts = ifnIniListPto(&pPtoGestionAux);
        if( sts == -1 )
	{
		ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
		return -1;
	}

	for( i = 0; i < iTotalRows; i++ )
	{
	        if( i>0 ){
	           sts = ifnInsertaPto(&pPtoGestionAux);
	           if( sts == -1 ){
			ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
			break;
		   }
		}
		ifnTrazasLog( modulo, "Datos obtenidos en %s\n"
					             "\t\t\tszCodPtoGest   = [%s],\n"
					             "\t\t\tiNumDias       = [%d],\n"
					             "\t\t\tszAntPtoGest   = [%s],\n"
					             "\t\t\tszCodEstado    = [%s],\n"
					             "\t\t\tszCodGestion   = [%s],\n"
					             "\t\t\tszCodCategoria = [%s],\n"
					             "\t\t\tszIndProrroga  = [%s],\n"
					             "\t\t\tNumProceso     = [%d],\n",
					             LOG05,
					             modulo,
					             sthPtoGestionLoc.szCodPtoGest[i],  
					             sthPtoGestionLoc.iNumDias[i],      
					             sthPtoGestionLoc.szAntPtoGest[i],  
					             sthPtoGestionLoc.szCodEstado[i],   
					             sthPtoGestionLoc.szCodGestion[i],  
					             sthPtoGestionLoc.szCodCategoria[i],
					             sthPtoGestionLoc.szIndProrroga[i], 
					             sthPtoGestionLoc.iNumProceso[i] );
		
		rtrim(sthPtoGestionLoc.szCodPtoGest[i]);			
		strcpy(pPtoGestionAux->szCodPtoGest, sthPtoGestionLoc.szCodPtoGest[i]);
		pPtoGestionAux->iNumDias = sthPtoGestionLoc.iNumDias[i];
		rtrim(sthPtoGestionLoc.szAntPtoGest[i]);
		strcpy(pPtoGestionAux->szAntPtoGest, sthPtoGestionLoc.szAntPtoGest[i]);
		rtrim(sthPtoGestionLoc.szCodEstado[i]);
		strcpy(pPtoGestionAux->szCodEstado, sthPtoGestionLoc.szCodEstado[i]);
		rtrim(sthPtoGestionLoc.szCodGestion[i]);
		strcpy(pPtoGestionAux->szCodGestion, sthPtoGestionLoc.szCodGestion[i]);
		rtrim(sthPtoGestionLoc.szCodCategoria[i]);
		strcpy(pPtoGestionAux->szCodCategoria, sthPtoGestionLoc.szCodCategoria[i]);
		rtrim(sthPtoGestionLoc.szIndProrroga[i]);
		strcpy(pPtoGestionAux->szIndProrroga, sthPtoGestionLoc.szIndProrroga[i]); 
		pPtoGestionAux->iNumProceso = sthPtoGestionLoc.iNumProceso[i];
		sts = ifnCargaAcciones( &LAcciones,pPtoGestionAux->szCodPtoGest,pPtoGestionAux->szCodCategoria,pPtoGestionAux->iNumProceso);
      if (sts == -1){
		    ifnTrazasLog( modulo, "Error en carga de Acciones ", LOG01 );
		    break;
		}
		pPtoGestionAux->Acc_sig = LAcciones;
	   /* XO-200509100635 Soporte RyC 29-09-2005 capc */
	   /*sts = ifnCargaCriterios( &LCriterios,pPtoGestionAux->szCodPtoGest,pPtoGestionAux->szCodCategoria,pPtoGestionAux->iNumProceso,1);*/
	   sts = ifnCargaCriterios( &LCriterios,pPtoGestionAux->szCodPtoGest,pPtoGestionAux->szCodCategoria,pPtoGestionAux->iNumProceso,0);
      if (sts == -1){
		    ifnTrazasLog( modulo, "Error en carga de Acciones ", LOG01 );
		    break;
		}
		pPtoGestionAux->Crit_sig = LCriterios;
	}

   if( sts == -1 )
	{
		ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
		vfnBorraListaPto(&pPtoGestionAux);
		return -1;
	}
	(*pPtoGestion) = pPtoGestionAux;
	return iTotalRows;
} /* FIN ifnCargaPtosGest() */

/* ============================================================================= */
/* Funcion que inserta datos estadisticos del proceso y los hilos                */
/* ============================================================================= */
int ifnInsertaEstadisticas(int piSecuencia , char *pszProceso )
{	
char modulo[] = "ifnInsertaEstadisticas";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihSecuencia;
		char 	szhProceso [6] ;
		int	ihSecProceso;
/* EXEC SQL END DECLARE SECTION; */ 

	
	ihSecuencia = piSecuencia;
	sprintf(szhProceso,"%s\0",pszProceso);
	ifnTrazasLog( modulo, "\n\tInsertando Estadistica. Proceso [%s]   Secuencia [%03d]", LOG03, szhProceso, piSecuencia );
	
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	INSERT INTO CO_ESTADISEVA_TO
			 (COD_PROCESO , FEC_INGRESO , SECUENCIA)
	VALUES (:szhProceso , SYSDATE     , :ihSecuencia); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_ESTADISEVA_TO (COD_PROCESO,FEC_INGRESO,SECUEN\
CIA) values (:b0,SYSDATE,:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )318;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[0] = (unsigned long )6;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihSecuencia;
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


	sema_post(&semaflock);
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	
	{
		ifnTrazasLog( modulo, "INSERT INTO CO_ESTADISEVA_TO  -  %s.", LOG01, SQLERRM );  
		return -1;
	}	
	ifnTrazasLog( modulo, "Fin a %s", LOG03, modulo );

	return 0;
}/* fin ifnInsertaEstadisticas */

/* ============================================================================= */
/* Funcion que actualiza datos estadisticos propios del proceso                  */
/* ============================================================================= */
int ifnUpdateEstadisticas( char *pszProceso , int iTpoTotal , long lTotalReg, int iSecuencia)
{
char modulo[] = "ifnUpdateEstadisticas";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	  long  lhTpoTotal ;
	  long  lhCliesProc;
	  int   ihSecuencia;
	  char  szhProceso [6] ;
	  int   ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 

	
	lhTpoTotal  = iTpoTotal/60;
	lhCliesProc = lTotalReg;
	ihSecuencia= iSecuencia;
	sprintf(szhProceso,"%s\0",pszProceso);
	
	ifnTrazasLog( modulo, "\n\tActualizando Estadistica. ", LOG03);
	ifnTrazasLog( modulo, "\tProceso    	[%s]", LOG05, szhProceso );
	ifnTrazasLog( modulo, "\tSecuencia   	[%03d]", LOG03, iSecuencia );
	ifnTrazasLog( modulo, "\tlhTpoTotal 	[%06d Seg]", LOG05, lhTpoTotal);
	ifnTrazasLog( modulo, "\tlhCliesProc 	[%ld]  [%ld]", LOG05, lhCliesProc ,lTotalReg);
	
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	UPDATE CO_ESTADISEVA_TO SET
			 TIEMPO_PROCESO    = nvl(TIEMPO_PROCESO, :ihValor_cero)    + :lhTpoTotal ,
			 CNT_CLIENTES_PROC = nvl(CNT_CLIENTES_PROC, :ihValor_cero) + :lhCliesProc,
			 FEC_INGRESO       = SYSDATE
	WHERE  COD_PROCESO       = :szhProceso
	AND    SECUENCIA         = :ihSecuencia
	AND    TRUNC(FEC_INGRESO)= TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_ESTADISEVA_TO  set TIEMPO_PROCESO=(nvl(TIEMPO_PROC\
ESO,:b0)+:b1),CNT_CLIENTES_PROC=(nvl(CNT_CLIENTES_PROC,:b0)+:b3),FEC_INGRESO=S\
YSDATE where ((COD_PROCESO=:b4 and SECUENCIA=:b5) and TRUNC(FEC_INGRESO)=TRUNC\
(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )341;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&lhTpoTotal;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCliesProc;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[4] = (unsigned long )6;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihSecuencia;
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


	sema_post(&semaflock);
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "UPDATE CO_ESTADISEVA_TO SET  -  %s.", LOG01, SQLERRM );  
		return -1;
	}	

	return 0;
}/* fin ifnUpdateEstadisticas */


/*================================================================*/
/* Funcion que rescata cantidad maxima de instancias en ejecucion */
/* definidas por el usuario      							   			*/
/*================================================================*/
int ifnValInstancias(char *szProceso, int *ihNUM_INSTAN)
{
char	modulo[] = "ifnValInstancias";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhProceso [6];
	char szhVigente [2];
	int  ihValor_Uno = 1;	
	int  ihNum_instancia=1;
/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhVigente,"V");
	strcpy(szhProceso,szProceso);
	ifnTrazasLog( modulo, "En funcion  %s", LOG03,modulo );
	ifnTrazasLog( modulo, "szhProceso [%s]", LOG03,szhProceso);
	ifnTrazasLog( modulo, "szhVigente [%s]", LOG03,szhVigente);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT  NVL(TO_NUMBER(CNT_INSTANCIA_USR),:ihValor_Uno)
	INTO    :ihNum_instancia
	FROM    CO_INSTANCIA_TO		 
	WHERE   COD_PROCESO = :szhProceso
	AND     ESTADO 	  = :szhVigente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(TO_NUMBER(CNT_INSTANCIA_USR),:b0) into :b1  from \
CO_INSTANCIA_TO where (COD_PROCESO=:b2 and ESTADO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )380;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihNum_instancia;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhVigente;
 sqlstm.sqhstl[3] = (unsigned long )2;
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


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Error INSTANCIAS_EVAL %s.", LOG00, SQLERRM );  
		return -1;
	}	
	
	if (ihNum_instancia==0) ihNum_instancia=1;
	*ihNUM_INSTAN=ihNum_instancia;
	ifnTrazasLog( modulo, "\n\tINSTANCIAS a EJECUTAR  [%d]\n", LOG03, *ihNUM_INSTAN);

	return 0;

}/* fin ifnValInstancias */


/*=======================================================================*/
/* Funcion que rescata el nombre de ususario defino en la ged_parametros */
/*=======================================================================*/
int ifnUsuarioParam(char *szUserCobros)
{
char	modulo[] = "ifnUsuarioParam";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhUser_Cobros[21]; /* EXEC SQL VAR szhUser_Cobros IS STRING(21); */ 

	char szhUSER       [15];
	char szhCO         [3] ;
	int  ihValor_Uno  = 1  ;
/* EXEC SQL END DECLARE SECTION; */ 
	
	
	strcpy(szhUSER,"USUARIO_COBROS");
	strcpy(szhCO,"CO");
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT VAL_PARAMETRO
	INTO   :szhUser_Cobros
	FROM   GED_PARAMETROS
	WHERE  NOM_PARAMETRO= :szhUSER
	AND    COD_MODULO   = :szhCO
	AND    COD_PRODUCTO = :ihValor_Uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where ((N\
OM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )411;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUser_Cobros;
 sqlstm.sqhstl[0] = (unsigned long )21;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhUSER;
 sqlstm.sqhstl[1] = (unsigned long )15;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCO;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Uno;
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


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Error SELECT VAL_PARAMETRO (USUARIO_COBROS) %s.", LOG00, SQLERRM );  
		return -1;
	}	
	
	strcpy(szUserCobros,szhUser_Cobros);
	ifnTrazasLog( modulo, "szUserCobros [%s]", LOG03, szUserCobros );  
	return 0;

}/* fin ifnUsuarioParam */

/* ============================================================================= */
/* Funcion que inserta los datos finales del proceso padre                       */
/* ============================================================================= */
int ifnInsertaParamUnix(char *szProceso, int iCantidad, long lCpu)
{
char modulo[] = "ifnInsertaParamUnix";
char szPorc[2];
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhProceso    [6]; 
     long lhCantProceso=0  ;
     long lhCpu ;
/* EXEC SQL END DECLARE SECTION; */ 


	ifnTrazasLog( modulo, "\n\tGrabando Datos en CO_PARAMETROS_UNIX_TO.", LOG03);  
	strcpy(szhProceso,szProceso);	
	lhCantProceso=iCantidad;
	lhCpu=lCpu;
	strcpy(szPorc,"%");
	ifnTrazasLog( modulo, "\tszhProceso      [%s]", LOG03,szhProceso);  
	ifnTrazasLog( modulo, "\tlhCantProceso   [%ld]", LOG03,lhCantProceso);  
	ifnTrazasLog( modulo, "\tlhCpu           [%ld%s]", LOG03,lhCpu,szPorc);  
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	INSERT INTO CO_PARAMETROS_UNIX_TO 
			 (COD_PROCESO      , FEC_INGRESO  ,
			  CARGA_CPU        , CNT_PROCESOS_EJECUTADOS )
   VALUES (:szhProceso      , SYSDATE      ,
   		  :lhCpu    	    , :lhCantProceso  ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PARAMETROS_UNIX_TO (COD_PROCESO,FEC_INGRESO,C\
ARGA_CPU,CNT_PROCESOS_EJECUTADOS) values (:b0,SYSDATE,:b1,:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )442;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[0] = (unsigned long )6;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCpu;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCantProceso;
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


	
	if( SQLCODE != SQLOK )	{
		ifnTrazasLog( modulo, "Error INSERT INTO CO_PARAMETROS_UNIX_TO - %s.", LOG01, SQLERRM );  
		return -1;
	}	
	return 0;

}/* fin ifnInsertaParamUnix */

/*==================================================================================================*/
/* Funcion que Carga los puntos de gestion por categoria															 */
/*==================================================================================================*/
int ifnPtosCateg( lista_Categ *pCategoria )
{
int 	i, sts = 0, iError= 0, iTotalRows=0 ;
lista_Categ  pCategoriaAux=NULL;
lista_Pto  pPtosAux=NULL;
lista_SecPtos pSecPtosAux=NULL;

char modulo[] = "ifnPtosCateg";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodCategoria[6] = "";
	td_CategoriaClientes	sthCategorias;
	char  szhLetra_H  [2];
/* EXEC SQL END DECLARE SECTION; */ 


    ifnTrazasLog( modulo, "\n\t **** INICIO CARGA DE CATEGORIAS, ACCIONES Y CRITERIOS ****\n", LOG03);
    strcpy(szhLetra_H,"H");
    
    /* se obtienen todos las categorias distintas existentes en los Ptos. de Gestion*/
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL DECLARE curCategorias CURSOR FOR
    SELECT DISTINCT COD_CATEGORIA  
    FROM CO_PTOSGESTION
    WHERE COD_ESTADO = :szhLetra_H; */ 

				
    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
	 	ifnTrazasLog( modulo, "DECLARE curCategorias %s ", LOG00, SQLERRM );
		return -1;
    }
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL OPEN curCategorias; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0015;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )469;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_H;
    sqlstm.sqhstl[0] = (unsigned long )2;
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


    if ( SQLCODE )
    {
		ifnTrazasLog( modulo, "OPEN curCategorias %s ", LOG00, SQLERRM );
		return -1;
    }
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL FETCH curCategorias
    INTO :sthCategorias; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )100;
    sqlstm.offset = (unsigned int  )488;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)sthCategorias.szCodCategoria;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
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


    
    iTotalRows = SQLROWS;
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) 
    {
		ifnTrazasLog( modulo, "\tError FETCH curCategorias\n\t %s", LOG01, SQLERRM );
		return -1; /*Mail*/   
    }
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL CLOSE curCategorias; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )507;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE )
    {
		ifnTrazasLog( modulo, "en CLOSE curCategorias : %s", LOG00, SQLERRM );
		return -1;
    }

    for(i = 0;i < iTotalRows ; i++ ) 
    {
		if (i == 0){
		   sts = ifnIniListCateg(&pCategoriaAux);
		   if( sts == -1 ){
			ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
			iError = 1;
			break;
		   }
		}
		else {
		   sts = ifnInsertaCateg(&pCategoriaAux);
		   if( sts == -1 ){
		      ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
		      iError = 1;
		      break;
		   }
		}
		rtrim(sthCategorias.szCodCategoria[i]);
		strcpy(pCategoriaAux->szCodCategoria, sthCategorias.szCodCategoria[i]);
		sts = ifnCargaSecPtos(&pSecPtosAux, pCategoriaAux->szCodCategoria );
		if (sts == -1){
		    ifnTrazasLog( modulo, "Error en carga de Categorias de Ptos. ", LOG01 );
		    break;
		}
		pCategoriaAux->sec_sig = pSecPtosAux;
		sts = ifnCargaPtosGest(&pPtosAux, pCategoriaAux->szCodCategoria );
		if (sts == -1){
		    ifnTrazasLog( modulo, "Error en carga de Ptos. de Gestion ", LOG01 );
		    break;
		}
		pCategoriaAux->pto_sig = pPtosAux;
    } /* for  curCategorias */
    
    (*pCategoria) = pCategoriaAux; 
    if (iError != 0)
      return -1;
    else 
      return 0;
}/* fin ifnPtosCateg */

/*==================================================================================================*/
/* Funcion que Verifica si el dia de hoy es un dia habil o si no lo es										 */
/* Esta funcion es facilmente modificable para verificar una fecha distinta a hoy	fmto: YYYYMMDD	 */		
/*==================================================================================================*/
int ifnEsDiaHabil(char *szDia, char *szFecha) 
{
int iRet = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCodDia    = 0;
	int  ihDiaFest   = 0;
	char szhFecha     [9]    = "" ;/* EXEC SQL VAR szhFecha   IS STRING(9); */ 

	char szhyyyymmdd  [9];
	char szhLetra_D   [2];
/* EXEC SQL END DECLARE SECTION; */ 

 
	strcpy(szhFecha,szFecha);
	strcpy(szhyyyymmdd,"yyyymmdd");
	strcpy(szhLetra_D,"D");
	/* determina que dia de la semana es hoy */
	/* 1:Domingo, 2:Lunes, ... , 7:Domingo   */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL EXECUTE
		BEGIN
			:ihCodDia:=TO_NUMBER(TO_CHAR(TO_DATE(:szhFecha,:szhyyyymmdd),:szhLetra_D));
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :ihCodDia := TO_NUMBER ( TO_CHAR ( TO_DATE ( :szhFecha\
 , :szhyyyymmdd ) , :szhLetra_D ) ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )522;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodDia;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_D;
 sqlstm.sqhstl[3] = (unsigned long )2;
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


   if (SQLCODE)  {
        strcpy(szDia,"Error");
        iRet = -1;
   }
   else
   {
        switch (ihCodDia)
        {
            case 1  :  strcpy(szDia,"Domingo");
                       iRet = 0;
                       break;
                       
            case 7  :   strcpy(szDia,"Sabado");
                        iRet = 0;
                        break;
                       
            default :  	/* Si hoy es dia de semana ( entre lunes y viernes ) */
                        /* Determina si es habil o festivo */
                        sqlca.sqlcode=0; /* XO-200508280498 rvc */
                        /* EXEC SQL 
                       	SELECT COUNT(*)  
                    		INTO :ihDiaFest
                    		FROM TA_DIASFEST
                    		WHERE FEC_DIAFEST = TO_DATE(:szhFecha,:szhyyyymmdd); */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 8;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.stmt = "select count(*)  into :b0  from TA_DI\
ASFEST where FEC_DIAFEST=TO_DATE(:b1,:b2)";
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )553;
                        sqlstm.selerr = (unsigned short)1;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlstm.sqhstv[0] = (unsigned char  *)&ihDiaFest;
                        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                        sqlstm.sqhsts[0] = (         int  )0;
                        sqlstm.sqindv[0] = (         short *)0;
                        sqlstm.sqinds[0] = (         int  )0;
                        sqlstm.sqharm[0] = (unsigned long )0;
                        sqlstm.sqadto[0] = (unsigned short )0;
                        sqlstm.sqtdso[0] = (unsigned short )0;
                        sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
                        sqlstm.sqhstl[1] = (unsigned long )9;
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
                        sqlstm.sqphsv = sqlstm.sqhstv;
                        sqlstm.sqphsl = sqlstm.sqhstl;
                        sqlstm.sqphss = sqlstm.sqhsts;
                        sqlstm.sqpind = sqlstm.sqindv;
                        sqlstm.sqpins = sqlstm.sqinds;
                        sqlstm.sqparm = sqlstm.sqharm;
                        sqlstm.sqparc = sqlstm.sqharc;
                        sqlstm.sqpadto = sqlstm.sqadto;
                        sqlstm.sqptdso = sqlstm.sqtdso;
                        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 /* fecha recibida */
                        if (SQLCODE)
                        {
                            strcpy(szDia,"Error");
                            iRet = -1;
                        }
                        else 
                        {
                            if ( ihDiaFest == 1 )
                            {
                                strcpy(szDia,"Festivo");
                                iRet = 0;
                            }
                            else
                            {
                                strcpy(szDia,"Habil");
                                iRet = 1;
                            }
                        }                                                    
                        break;
        }
    }    
    
    return iRet;
} /* fin ifnEsDiaHabil */




/*=========================================================== =======================================*/
/* Funcion que carga puntos de gestion por categoria en una lista enlazada									 */
/*==================================================================================================*/
int ifnCargaSecPtos( lista_SecPtos  *pSecPtos, char *Categoria)
{
char modulo[]="ifnCargaSecPtos";
int iTotalRows = 0;
int i=0, sts=0, iSec=0;
lista_SecPtos  pSecPtosAux=NULL;
    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_SecuenciaPtos  sthSecPtos;
	char  szhCodCategoria[6]; /* EXEC SQL VAR szhCodCategoria IS STRING (6); */ 

	int	ihNumDias=0;
	int	ihNumProceso=0;
	char  szhLetra_H   [2];
	int   ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 

    
	strcpy(szhCodCategoria,Categoria);
   ifnTrazasLog(modulo,"szhCodCategoria :'%s'",LOG05,szhCodCategoria);
   strcpy(szhLetra_H,"H");
   
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL DECLARE curSecPtos CURSOR FOR
	SELECT NUM_DIAS, NUM_PROCESO
	FROM   CO_PTOSGESTION
	WHERE  COD_CATEGORIA= :szhCodCategoria
	AND    COD_ESTADO   = :szhLetra_H
	UNION
	SELECT :ihValor_cero NUM_DIAS, :ihValor_cero NUM_PROCESO 
	FROM   DUAL
	ORDER BY NUM_DIAS DESC; */ 

        /* ordena por tipo_rutina y cod_rutina */

   if( SQLCODE )
   {
		ifnTrazasLog( modulo, "en DECLARE : %s", LOG00, SQLERRM );
		return -1;
   }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL OPEN curSecPtos; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0018;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )580;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodCategoria;
   sqlstm.sqhstl[0] = (unsigned long )6;
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
   sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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


   if (SQLCODE)  {
   	ifnTrazasLog(modulo,"en OPEN : %s",LOG00,SQLERRM);
      return -1;
   }
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL FETCH curSecPtos INTO sthSecPtos ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )100;
 sqlstm.offset = (unsigned int  )611;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)sthSecPtos.iNumDias;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)sthSecPtos.iNumProceso;
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


   iTotalRows = SQLROWS;
   if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)    {
   	ifnTrazasLog(modulo,"en FETCH : %s",LOG00,SQLERRM);
      return -1;
   }
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL CLOSE curSecPtos; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )634;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE)   {
        ifnTrazasLog(modulo,"en CLOSE : %s",LOG00,SQLERRM);
        return -1;
   }

	/* Inserto : informacion adicional para el log */
   for(i=0;i<iTotalRows;i++)
   {
		if( i>0 ){
		   sts = ifnInsertaSecPto(&pSecPtosAux);
		   if( sts == -1 ){
		      ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
		      break;
		   }
		}
		else{
		   sts = ifnIniListSecPto(&pSecPtosAux);
		   if( sts == -1 ){
				ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
				return -1;
		    }
      }
		pSecPtosAux->iNumDias = sthSecPtos.iNumDias[i];
		pSecPtosAux->iNumProceso = sthSecPtos.iNumProceso[i];
	 	iSec++;
   }

   if ( sts == -1 ){
       ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
       return -1;
   }
   (*pSecPtos) = pSecPtosAux;
   ifnTrazasLog(modulo,"\t %3d Nro. de Secuencias(s) ",LOG05,iSec);
   
   /*fin Inserto : informacion adicional para el log *********************************************/
   return iTotalRows;
} /* FIN ifnCargaSecPtos */



/* ============================================================================= */
/* Funcion que genera comentarios en archivo de log de hilos                     */ 
/* Parametros: szExeNameApp   Nombre de l afuncion que lo invoca                 */
/*             fArch          Nombre del puntero de archivo                      */ 
/*             szTxt          Texto a incluir el el fichero de log               */  
/*             iNivel         Nivel de log                                       */ 
/* ============================================================================= */
int ifnTrazaHilos (char* szExeNameApp, FILE **fArch, char* szTxt, int iNivel,...)
{
char szMsg[5001]="";
va_list ap;
int iAux = 0;
FILE *fh;    /* file handler generico */   
int iTrLog = 0;

    fh = *fArch;
    if ( fh == (FILE *)NULL ){
     	 printf("\t\t ERROR  No hay archivo definido \n (ifnTrazaHilos)");
       return 1;
    }
    /* Si no hay archivo definido, escribe a stderr */
    
    memset(szMsg,'\0',sizeof(szMsg));
    va_start( ap, szTxt );
    vsprintf (szMsg,szTxt,ap);
	 va_end( ap );  

    /* NUEVO CONCEPTO */
    if (iNivel == INFALL) /* si es un mensaje para todos los archivos abiertos */
    {
        iAux = fprintf (fh,"\n\t%s",szMsg);                                              /* Log */
    }        

    if (iNivel == EST00) /* si es un mensaje que va a la estadistica */
    {
        iNivel = LOG03 ; /* baja nivel de log, para que tambien vaya al Log */
    }

    if (iNivel <= stStatus.iLogNivel ) {
	    switch (iNivel) 
	    {
	      case LOG00: iAux = fprintf (fh,"\n\t%s\n\tError Oracle (%s): %s",szGetTime(1),szExeNameApp,szMsg);
	           break;
	        
	      case LOG01: iAux = fprintf (fh,"\n\t%s\tError (%s): %s",szGetTime(1),szExeNameApp,szMsg);
	           break;
	        
	      case LOG02: iAux = fprintf (fh,"\n\tAviso (%s): %s",szExeNameApp,szMsg);
	           break;
	        
	      case LOG03: iAux = fprintf (fh,"\n\t%s",szMsg);
	           break;
	        
	      default:    iAux = fprintf (fh,"\n\t%s",szMsg);
	           break;
	        
	    }/* end switch */
	}	
	
	if (iAux < 0) {
		return -1; /* fallo el fprintf del archivo de log */
	}
    
	if ( fflush(fh) != 0 )  {
		return -2; /* fallo el fflush */
	}
	
	return 0; /* todo salio bien */
}

/*==================================================================================================*/
/* Funcion que Cambia el codigo de activacion de la cola de proceso                                 */
/*==================================================================================================*/
BOOL bfnCambiaCodActivacionCola( char *szCodProceso, char *szCodActivacion )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodProceso[6];		/* EXEC SQL VAR szhCodProceso IS STRING(6); */ 
 
	char szhCodActivacion[2];	/* EXEC SQL VAR szhCodActivacion IS STRING(2); */ 
 
/* EXEC SQL END DECLARE SECTION; */ 


char modulo[] = "bfnCambiaCodActivacionCola";

	ifnTrazasLog( modulo, "Ingreso modulo => [%s].", LOG05, modulo );
	memset( szhCodProceso, '\0', sizeof( szhCodProceso ) );
	memset( szhCodActivacion, '\0', sizeof( szhCodActivacion ) );

	strcpy( szhCodProceso, szCodProceso );
	strcpy( szhCodActivacion, szCodActivacion );
	
	ifnTrazasLog( modulo, "Parametro entrada modulo => [%s], szhCodProceso => [%s], szhCodActivacion => [%s].", LOG05, modulo, szhCodProceso, szhCodActivacion );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	UPDATE CO_COLASPROC SET 
	       COD_ACTIVACION = :szhCodActivacion
	WHERE COD_PROCESO = :szhCodProceso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_COLASPROC  set COD_ACTIVACION=:b0 where COD_PROCES\
O=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )649;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodActivacion;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodProceso;
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


	 
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Proceso => [%s], Error al actualizar COD_ACTIVACION => [%s].", LOG00, szhCodProceso, SQLERRM );
		return FALSE;
	}
	if( SQLCODE == SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Proceso => [%s], No existe en CO_COLASPROC => [%s].", LOG01, szhCodProceso, SQLERRM );
		return FALSE;
	}
	
	return TRUE; 
} /* BOOL bfnCambiaCodActivacionCola( char *szCodProceso, char *szCodActivacion ) */


/*==================================================================================================*/
/* Funcion que Cambia el estado de la cola de proceso																 */
/*==================================================================================================*/
BOOL bfnCambiaEstadoCola( char *CodProceso, char *Desde, char *Hasta )
{
char modulo[]="bfnCambiaEstadoCola";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhCodProceso[6];
    char szhEstadoInicio[2];
    char szhEstadoFinal[2];
    long lhPidProceso=0;
/* EXEC SQL END DECLARE SECTION; */ 

int iIntento, iMaxIntentos;
char szError[256]="";
        
    sprintf(szhCodProceso,"%s",CodProceso);
    sprintf(szhEstadoInicio,"%s",Desde);
    sprintf(szhEstadoFinal,"%s",Hasta);
    lhPidProceso=getpid();
    
    ifnTrazasLog( modulo, "Cambiando estado de la cola [%s] : [%s] -> [%s] "
                , LOG03, szhCodProceso, szhEstadoInicio, szhEstadoFinal );

    if ( strcmp(szhEstadoFinal,"W") == 0 )    {
        iMaxIntentos = 15 ; /* 15 veces */
    }
    else
    {
        iMaxIntentos = 1;
    }
        
    for (iIntento = 1; iIntento <= iMaxIntentos; iIntento ++)
    {
    	sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL 
        UPDATE CO_COLASPROC
        SET    COD_ESTADO  = :szhEstadoFinal,
               FEC_ESTADO  = SYSDATE,
               PID_PROCESO = :lhPidProceso
        WHERE  COD_PROCESO = :szhCodProceso; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CO_COLASPROC  set COD_ESTADO=:b0,FEC_ESTADO=SY\
SDATE,PID_PROCESO=:b1 where COD_PROCESO=:b2";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )672;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhEstadoFinal;
        sqlstm.sqhstl[0] = (unsigned long )2;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhPidProceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodProceso;
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



        if (SQLCODE)   {   
            ifnTrazasLog(modulo,"[%s]:%s",LOG00,szhCodProceso,SQLERRM);
            if (iIntento == 1) {
               ifnTrazasLog(modulo,"[%s]:Fallo al cambiar la cola a [%s]",LOG01,szhCodProceso,szhEstadoFinal);
            }
            
            if ( iMaxIntentos > 1 )
            {
                sleep(120); /* duerme 2 minutos antes de volver a intentarlo */
            }
        }
        else
        {
            if ( iIntento > 1 && iIntento != iMaxIntentos )
            {
                ifnTrazasLog(modulo,"[%s]:Logro al %d intento cambiar la cola a [%s]",LOG01,szhCodProceso,iIntento,szhEstadoFinal);
            }
            return TRUE;
        }
    } /* endfor intentos */

    if ( iIntento > iMaxIntentos  && iMaxIntentos > 1 )
    {
       ifnTrazasLog(modulo,"[%s]:Nunca pudo cambiar la cola a [%s]",LOG01,szhCodProceso,iIntento,szhEstadoFinal);
    }
    
    return FALSE;
    
} /* end bfnCambiaEstadoCola */

/*==================================================================================================*/
/* Funcion que Obtiene el estado de ejecucion del proceso.														 */
/*==================================================================================================*/
BOOL bfnRecuperaEstadoCola( char *szCodProceso, char *szCodEstado )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodProceso[6];		/* EXEC SQL VAR szhCodProceso IS STRING(6); */ 
 
	char szhCodEstado[2];		/* EXEC SQL VAR szhCodEstado IS STRING(2); */ 
 
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnRecuperaEstadoCola";

	ifnTrazasLog( modulo, "Ingreso modulo => [%s].", LOG05, modulo );
	memset( szhCodProceso, '\0', sizeof( szhCodProceso ) );
	memset( szhCodEstado, '\0', sizeof( szhCodEstado ) );

	strcpy( szhCodProceso, szCodProceso );
	
	ifnTrazasLog( modulo, "Parametro entrada modulo => [%s], szhCodProceso => [%s].", LOG05, modulo, szhCodProceso );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COD_ESTADO 
	INTO   :szhCodEstado
	FROM   CO_COLASPROC 
	WHERE  COD_PROCESO = :szhCodProceso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLASPROC where COD_PROC\
ESO=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )699;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodProceso;
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


	 
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Proceso => [%s], Error al consultar estado en CO_COLASPROC => [%s].", LOG00, szhCodProceso, SQLERRM );
		return FALSE;
	}
	if( SQLCODE == SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Proceso => [%s], No existe en CO_COLASPROC => [%s].", LOG01, szhCodProceso, SQLERRM );
		return FALSE;
	}
	
	strcpy( szCodEstado, szhCodEstado );
	ifnTrazasLog( modulo, "Retorno modulo => [%s], szhCodEstado => [%s].", LOG05, modulo, szCodEstado );
	return TRUE; 
} /* BOOL bfnRecuperaEstadoCola( char *szCodProceso, char *szCodEstado ) */

/*==================================================================================================*/
/* Funcion que Valida si la cola del proceso todavia se encuentra activa									 */
/*==================================================================================================*/
BOOL bfnValidaColaActiva (char *szCodProceso, int *iFlgActiva)
{
char modulo[]="bfnValidaColaActiva";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodProceso[6]    = "";
	char szhCodActivacion[2] = "";
	char szhCodEstado    [2] = "";
	char szhFormato      [11]= "";
	int  ihFlgActiva = 0;
	int  ihValor_cero= 0;
/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhCodProceso   ,szCodProceso);
   strcpy(szhCodActivacion,"H");           /* activable (Habilitado) */
   strcpy(szhCodEstado    ,"R")    ;           /* running */
   strcpy(szhFormato      ,"HH24:MI:SS") ; /* formato de fecha */

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT NVL(count(*),:ihValor_cero)
	INTO  :ihFlgActiva
	FROM  CO_COLASPROC
	WHERE COD_PROCESO    = :szhCodProceso
	AND   COD_ACTIVACION = :szhCodActivacion    
	AND   COD_ESTADO     = :szhCodEstado
	AND   TO_CHAR( SYSDATE, :szhFormato ) BETWEEN IND_HORAINI AND IND_HORAFIN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(count(*) ,:b0) into :b1  from CO_COLASPROC where \
(((COD_PROCESO=:b2 and COD_ACTIVACION=:b3) and COD_ESTADO=:b4) and TO_CHAR(SYS\
DATE,:b5) between IND_HORAINI and IND_HORAFIN)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )722;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihFlgActiva;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodProceso;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodActivacion;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodEstado;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFormato;
 sqlstm.sqhstl[5] = (unsigned long )11;
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



   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )   {
		ifnTrazasLog( modulo, "al consultar la CO_COLASPROC, con proceso %s : %s.", LOG00, szhCodProceso, SQLERRM );
		return FALSE;
   }
   if( SQLCODE == SQLNOTFOUND )   {
		ifnTrazasLog( modulo, "proceso %s NO se encontro en CO_COLASPROC : %s", LOG00, szhCodProceso, SQLERRM );
		return FALSE;
   }

	*iFlgActiva = ihFlgActiva;
	return TRUE;
}

/*==================================================================================================*/
/* Funcion que Chequea que el proceso de Saldos este en 'W'														 */
/*==================================================================================================*/
int ifnVerFinColaAnterior(int iProc)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int   ihCount;
	char  szhSALCO   [6];
	char  szhEVACM   [6];
	char  szhLetra_W [2];
	int   ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 


   strcpy(szhSALCO,"SALCO");
   strcpy(szhEVACM,"EVACM");
   strcpy(szhLetra_W,"W");
   
   
   if (iProc==1) {
   		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT COUNT(:ihValor_uno)
		INTO   :ihCount
		FROM   CO_COLASPROC
		WHERE  COD_PROCESO = :szhSALCO
		AND    COD_ESTADO  = :szhLetra_W; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(:b0) into :b1  from CO_COLASPROC where (COD_PR\
OCESO=:b2 and COD_ESTADO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )761;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCount;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhSALCO;
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_W;
  sqlstm.sqhstl[3] = (unsigned long )2;
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


	} else {
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT COUNT(:ihValor_uno)
		INTO   :ihCount
		FROM   CO_COLASPROC
		WHERE  COD_PROCESO = :szhEVACM
		AND    COD_ESTADO  = :szhLetra_W; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(:b0) into :b1  from CO_COLASPROC where (COD_PR\
OCESO=:b2 and COD_ESTADO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )792;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCount;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhEVACM;
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_W;
  sqlstm.sqhstl[3] = (unsigned long )2;
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

	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		return -1;
	}	

	if (ihCount > 0 )
		return 0;
	else
		return 1;
}

/*==================================================================================================*/
/* Funcion que realiza llamada a funciones que obtienen datos de uso general.           */
/*==================================================================================================*/
BOOL bfnObtieneDatosGenerales( void )
{
char	modulo[] = "bfnObtieneDatosGenerales";

  	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )
	{
	    ifnTrazasLog( modulo, "Error al realizar carga de bGetParamDecimales().", LOG03 );
	    return FALSE;
	}

  	/* Carga los nombres de tablas y campos, de comunas o pueblos segun la operadora */
	/*if( !bGetParamNameZona() )
	{
	    ifnTrazasLog( modulo, "Error al realizar carga de bGetParamNameZona().", LOG03 );
	    return FALSE;
	}*/
	
	return TRUE;
}/************************** bGetParamDecimales ******************************/

/*==================================================================================================*/
/* Funcion que recupera datos generales para manejo de decimales.								 */
/*==================================================================================================*/
int bGetParamDecimales( void )
{
/* EXEC SQL BEGIN DECLARE SECTION  ; */ 

	static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro  IS STRING(21); */ 

	static char  szhModuloSiscel[3] ; /* EXEC SQL VAR szhModuloSiscel  IS STRING(3); */ 

	static int   ihCodProducto      ;
	static char  szhValParametro[7] ; /* EXEC SQL VAR szhValParametro  IS STRING(7); */ 

/* EXEC SQL END   DECLARE SECTION  ; */ 
 
char	modulo[] = "bGetParamDecimales";
	
	sprintf(szhModuloSiscel,"GE\0");
	ihCodProducto = 1;
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL DECLARE Cur_Ged_Parametros CURSOR FOR
	SELECT NOM_PARAMETRO   ,
			 VAL_PARAMETRO   
	FROM   GED_PARAMETROS   
	WHERE  COD_MODULO   = :szhModuloSiscel
	AND    COD_PRODUCTO = :ihCodProducto; */ 

	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL OPEN Cur_Ged_Parametros; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0025;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )823;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhModuloSiscel;
 sqlstm.sqhstl[0] = (unsigned long )3;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode )	{
		ifnTrazasLog( modulo, "Error al recuperar datos de decimales desde GED_PARAMETROS => [%s]", LOG00, szhValParametro, szhNomParametro, SQLERRM );
		return FALSE;
	}
	
	while( sqlca.sqlcode == 0 )
	{
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		FETCH Cur_Ged_Parametros 
		INTO    :szhNomParametro,
				:szhValParametro; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )846;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhNomParametro;
  sqlstm.sqhstl[0] = (unsigned long )21;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhValParametro;
  sqlstm.sqhstl[1] = (unsigned long )7;
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


		
		if( sqlca.sqlcode == SQLNOTFOUND )	{
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL CLOSE Cur_Ged_Parametros; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )869;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


			return TRUE;
		}

		if( sqlca.sqlcode < 0 )		{
			return FALSE;
		}	
		else	
		{
			if( strcmp( szhNomParametro, szNUM_DECIMAL ) == 0 )
			{
				pstParamGener.iNumDecimal = atoi( szhValParametro );
			}
			else if( strcmp( szhNomParametro ,szSEP_MILES_MONTOS ) == 0 )
			{
				strcpy( pstParamGener.szSepMilesMonto, szhValParametro );
			}
			else if( strcmp( szhNomParametro, szSEP_DECIMALES_MONTOS ) == 0 )
			{
				strcpy( pstParamGener.szSepDecMontos, szhValParametro );
			}
			else if( strcmp( szhNomParametro, szSEP_DECIMALES_ORACLE ) == 0 )
			{
				strcpy( pstParamGener.szSepDecOracle, szhValParametro );
			}
		}   
	} /* while( sqlca.sqlcode == 0 ) */
	
	return (1);
}/************************** bGetParamDecimales ******************************/


/*==================================================================================================*/
/* Funcion que Resta dos string en fmto hora y retorna la diferencia en fmto hora y segundos        */
/*==================================================================================================*/
int ifnRestaHoras( char *h1, char *h2, char *hh)
{
  int ih1,ih2,ih;
  div_t hmsH,hmsMS;
  if ((ih1=HoraToSegs(h1))<0) return -1;
  if ((ih2=HoraToSegs(h2))<0) return -1;
  ih=(ih2>=ih1)?(ih2-ih1):(((24*3600)-ih1)+ih2); /* restando horas en segundos , considerando cambio de dia */
  hmsH=div(ih,3600);
  hmsMS=div(hmsH.rem,60);
  sprintf(hh,"%02d:%02d:%02d\0",hmsH.quot,hmsMS.quot,hmsMS.rem);
  return ih;
}

/*==================================================================================================*/
/* Funcion que Lleva una Hora dada a un valor equivalente en segundos										 */
/*==================================================================================================*/
int HoraToSegs(char *HoraFmto)
{
  char *Hora,HH[3],MI[3],SS[3];
  int iHH,iMI,iSS;
  Hora=HoraFmto;
  Strcpysub(Hora,2,HH); Hora=Hora+3; /*HH:*/ iHH=atoi(HH); if (iHH<00||iHH>23) return -1;
  Strcpysub(Hora,2,MI); Hora=Hora+3; /*MI:*/ iMI=atoi(MI); if (iMI<00||iMI>59) return -1;
  Strcpysub(Hora,2,SS);              /*SS */ iSS=atoi(SS); if (iSS<00||iSS>59) return -1;
  return (iHH*3600+iMI*60+iSS);
}

/*==================================================================================================*/
/* Funcion que Copia un substr de un char a otro																	 */
/*==================================================================================================*/
void Strcpysub(char *str1, int Largo, char *str2)
{
   int i;
   str2[0]='\0';
   for(i=0;i<=Largo-1;str2[i]=str1[i],i++);
   str2[i]='\0';
}

/* ============================================================================= */
/* En startel2 escribe en el log ; En startel 1 ademas envia un mensaje de alerta*/
/* via E-mail al equipo de desarrollo y al encargado en produccion del sistema   */
/* ============================================================================= */
int ifnMailAlert (char* szFrom, char* szMailTo, char* szTxt, ...)
{
    char modulo[]="ifnMailAlert";
    char szMsg[TAMBUFSIZ]="";
    char szComando[512]="";
    va_list ap;
    int iAux = 0;
    FILE *fh;    /* file handler generico */   
   
    fh = stderr;  

    va_start (ap,szTxt);
    vsprintf (szMsg,szTxt,ap);  /* pasa el texto con los formatos ... a un string normal */
    va_end   (ap);  
    
    iAux = fprintf (fh,"\n -------------------------------------- "
                       "\n DE         : %s "
                       "\n ENVIADO EL : %s "
                       "\n PARA       : %s"
                       "\n ASUNTO     : ALERTA - ALERTA - ALERTA  "
                       "\n -------------------------------------- "
                       "\n %s "
                       "\n -------------------------------------- "
                       "\n"
                      ,szFrom ,szSysDate("DD-MON-YYYY  HH24:MI:SS"), szMailTo, szMsg);

    if (iAux < 0) return -1;
    if ( fflush(fh) != 0 )  return -2; 
    
    sprintf(szComando,"%s/MailAlert.sh %s \" Mensaje desde %s\" \"Error en la Cola %s de la Aplicacion de Cobranzas => %s\" " 
                     ,getenv("XPC_KSH"), szMailTo, szFrom, szFrom, szMsg);
    system(szComando);
    
    ifnTrazasLog(modulo,"comando [%s]",LOG03,szComando);
    
    return 0; 
}

/*==================================================================================================*/
/* Funcion que actualiza el val_parametro del modulo Cobranza segun parametros                      */
/*==================================================================================================*/
BOOL bfnActualizaIndiceSec( char *szValParametro, char *szNomParametro )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhValParametro[21];	 
	char	szhNomParametro[21];
	char  szhModulo      [3];
	int   ihValor_uno = 1 ;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnActualizaIndiceSec";
	
	ifnTrazasLog( modulo, "Ingresando Modulo %s", LOG05, modulo );
	memset(szhValParametro, '\0', sizeof( szhValParametro ) );
	memset(szhNomParametro, '\0', sizeof( szhNomParametro ) );
	
	strcpy(szhValParametro, szValParametro );
	strcpy(szhNomParametro, szNomParametro );
	strcpy(szhModulo,"CO");
	
	rtrim( szhValParametro );
	rtrim( szhNomParametro );
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	UPDATE GED_PARAMETROS SET 
	       VAL_PARAMETRO = :szhValParametro
	WHERE  NOM_PARAMETRO = :szhNomParametro
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update GED_PARAMETROS  set VAL_PARAMETRO=:b0 where ((NOM_PAR\
AMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )884;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_uno;
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



	if ( SQLCODE != SQLOK )
	{
		ifnTrazasLog( modulo, "ValParam => [%s], NomParam => [%s], Error al actualizar GED_PARAMETROS => [%s]", LOG00, szhValParametro, szhNomParametro, SQLERRM );
		return FALSE;
	}

	ifnTrazasLog( modulo, "ValParam => [%s], NomParam => [%s], Actualizacion Exitosa de GED_PARAMETROS.", LOG05, szhValParametro, szhNomParametro );
	return TRUE;
} /* bfnActualizaIndiceSec */


/*==================================================================================================*/
/* Funcion que Tiene por finalidad determinar que COD_GESTION, le corresponde al cliente examinado. */
/* Esta habilitada para el proceso ejecutor y excluidor								                      */
/*==================================================================================================*/
BOOL bfnFindNewCodGestion( FILE **ptArchLog, long lCodCliente, int iIndExcluye )
{
char modulo[] = "bfnFindNewCodGestion";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	char	szhCodGestion[3] = "";		/* EXEC SQL VAR szhCodGestion IS STRING(3); */ 

	char	szhCodRutina[6] = "";		/* EXEC SQL VAR szhCodRutina IS STRING(6); */ 

	int	ihCntAboCelu = 0;
	int	ihCntAboBeep = 0;
	int	ihCntSumAbo  = 0;
	char  szhBAA       [4];
   char  szhLetra_A   [2];
	char  szhEJE       [4];
	char  szhRER       [4];
	char  szhNum90     [3];
	char  szhNum43     [3];
	char  szhNum44     [3];
	int   ihValor_cero = 0;
	int   ihValor_tres = 3;
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog;	
pfLog = *ptArchLog;

	ifnTrazaHilos( modulo,&pfLog,"Ingresando modulo %s.", LOG05, modulo );
    
   memset( szhCodGestion, '\0', sizeof( szhCodGestion ) );
   strcpy( szhCodGestion, "NN" );
   strcpy(szhBAA,"BAA");
   strcpy(szhLetra_A,"A");
   strcpy(szhEJE,"EJE");
   strcpy(szhRER,"RER"); 
   strcpy(szhNum90,"90");
   strcpy(szhNum43,"43");
   strcpy(szhNum44,"44");

	lhCodCliente = lCodCliente;
   ifnTrazaHilos( modulo,&pfLog,"Parametros entrada modulo %s.\tlCliente     = [%ld].",LOG05, modulo, lhCodCliente );
    
   /*-Obtiene la Cantidad de Abonados Celulares del Cliente-*/            
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	:ihCntAboCelu
	FROM	GA_ABOCEL
	WHERE	COD_CLIENTE    = :lhCodCliente
	AND	COD_SITUACION != :szhBAA
	AND	COD_USO       != :ihValor_tres; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL where ((COD_CLIENT\
E=:b1 and COD_SITUACION<>:b2) and COD_USO<>:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )915;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAboCelu;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_tres;
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



	if( SQLCODE ) {
		ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) GA_ABOCEL : %s",LOG00,lhCodCliente,SQLERRM);  
      return FALSE;
	}

	/*-Obtiene la Cantidad de Abonados Beeper del Cliente-*/            
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	 :ihCntAboBeep
	FROM	 GA_ABOBEEP
	WHERE	 COD_CLIENTE    = :lhCodCliente
	AND	 COD_SITUACION != :szhBAA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOBEEP where (COD_CLIENT\
E=:b1 and COD_SITUACION<>:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )946;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAboBeep;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
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


	
	if( SQLCODE ) {
		ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) GA_ABOBEEP : %s",LOG00,lhCodCliente,SQLERRM);  
      return FALSE;
	}

	/*-Obtiene el codigo de gestion a asignar al cliente-*/            
	if( ihCntAboCelu + ihCntAboBeep == 0 ) 
	{ 	    
		/*-Si el cliente no tiene abonados celulares o beeper asigna cod_gestion = 'SA'-*/ 
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT SUM(CUENTA)
		INTO	 :ihCntSumAbo
		FROM  (SELECT COUNT(*) AS CUENTA
				 FROM   GA_ABOCEL
				 WHERE  COD_CLIENTE = :lhCodCliente
				 AND 	  COD_USO != :ihValor_tres
				 UNION
				 SELECT COUNT(*) AS CUENTA
				 FROM   GA_ABOBEEP
				 WHERE  COD_CLIENTE = :lhCodCliente ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select sum(CUENTA) into :b0  from (select count(*)  CUENTA \
 from GA_ABOCEL where (COD_CLIENTE=:b1 and COD_USO<>:b2) union select count(*)\
  CUENTA  from GA_ABOBEEP where COD_CLIENTE=:b1) ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )973;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSumAbo;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_tres;
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
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) ERROR, Contando abonados y beepers del Cliente : %s",LOG00,lhCodCliente,SQLERRM);  
	      return FALSE;
		}

      if ( ihCntSumAbo == 0 )   {
	    	strcpy( szhCodGestion, "SA" );
		}
		else
		{
			/*-Si el cliente solo tiene abonados celulares o beeper de baja y alguno -*/
			/*-en cod_causabaja in( '90','43','44') asigna cod_gestion = 'CF'-*/ 
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT	SUM(CUENTA)
			INTO	:ihCntSumAbo
			FROM  ( 	SELECT COUNT(*) AS CUENTA
						FROM   GA_ABOCEL
						WHERE  COD_CLIENTE   = :lhCodCliente
						AND 	 COD_SITUACION = :szhBAA
						AND 	 COD_USO      != :ihValor_tres
						AND    COD_CAUSABAJA IN ( :szhNum90,:szhNum43,:szhNum44) 
						UNION
						SELECT COUNT(*) AS CUENTA
						FROM 	 GA_ABOBEEP
						WHERE  COD_CLIENTE   = :lhCodCliente
						AND 	 COD_SITUACION = :szhBAA
						AND    COD_CAUSABAJA IN ( :szhNum90,:szhNum43,:szhNum44)); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select sum(CUENTA) into :b0  from (select count(*)  CUENTA\
  from GA_ABOCEL where (((COD_CLIENTE=:b1 and COD_SITUACION=:b2) and COD_USO<>\
:b3) and COD_CAUSABAJA in (:b4,:b5,:b6)) union select count(*)  CUENTA  from G\
A_ABOBEEP where ((COD_CLIENTE=:b1 and COD_SITUACION=:b2) and COD_CAUSABAJA in \
(:b4,:b5,:b6))) ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1004;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSumAbo;
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
   sqlstm.sqhstl[2] = (unsigned long )4;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_tres;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNum90;
   sqlstm.sqhstl[4] = (unsigned long )3;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhNum43;
   sqlstm.sqhstl[5] = (unsigned long )3;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhNum44;
   sqlstm.sqhstl[6] = (unsigned long )3;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhBAA;
   sqlstm.sqhstl[8] = (unsigned long )4;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhNum90;
   sqlstm.sqhstl[9] = (unsigned long )3;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhNum43;
   sqlstm.sqhstl[10] = (unsigned long )3;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhNum44;
   sqlstm.sqhstl[11] = (unsigned long )3;
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

 
					   							
			if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
			{
				ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) ERROR, Contando abonados y beepers en Baja del Cliente : %s",LOG00,lhCodCliente,SQLERRM);  
		      return FALSE;
			}
    
			if ( ihCntSumAbo > 0 ) 
				strcpy( szhCodGestion, "CF" );
			else 
				/*-Si el cliente no cumple ninguna de las condiciones anteriores asigna cod_gestion = 'BA'-*/ 
				strcpy( szhCodGestion, "BA" );
	    } 
	} /* if ( ihCntAboCelu + ihCntAboBeep > 0 ) */
	
	/* si no cumplio criterios anteriores */
	if( !strcmp( szhCodGestion, "NN" ) ) 
	{
		if( iIndExcluye )	/* LO ESTOY EXCLUYENDO, Esta pasando a historico y saliendo de morosos */
		{
			strcpy( szhCodGestion, "MR" );
		}
		else	
		{
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT R.COD_RUTINA, R.COD_GESTION
			INTO	 :szhCodRutina,
					 :szhCodGestion
			FROM	 CO_RUTINAS R
			WHERE	 R.TIP_RUTINA = :szhLetra_A
			AND	 R.COD_GESTION IS NOT NULL
			AND	 R.ORD_APLICACION = (SELECT	MIN( RR.ORD_APLICACION )
											   FROM	CO_RUTINAS RR, CO_ACCIONES CO
											   WHERE	CO.COD_CLIENTE = :lhCodCliente
											   AND		CO.NUM_SECUENCIA > :ihValor_tres
											   AND		CO.COD_ESTADO IN ( :szhEJE, :szhRER )		
											   AND		CO.COD_RUTINA = RR.COD_RUTINA
											   AND		RR.TIP_RUTINA = :szhLetra_A
											   AND		RR.COD_GESTION IS NOT NULL ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select R.COD_RUTINA ,R.COD_GESTION into :b0,:b1  from CO_R\
UTINAS R where ((R.TIP_RUTINA=:b2 and R.COD_GESTION is  not null ) and R.ORD_A\
PLICACION=(select min(RR.ORD_APLICACION)  from CO_RUTINAS RR ,CO_ACCIONES CO w\
here (((((CO.COD_CLIENTE=:b3 and CO.NUM_SECUENCIA>:b4) and CO.COD_ESTADO in (:\
b5,:b6)) and CO.COD_RUTINA=RR.COD_RUTINA) and RR.TIP_RUTINA=:b2) and RR.COD_GE\
STION is  not null )))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1067;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodRutina;
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestion;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_A;
   sqlstm.sqhstl[2] = (unsigned long )2;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_tres;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhEJE;
   sqlstm.sqhstl[5] = (unsigned long )4;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhRER;
   sqlstm.sqhstl[6] = (unsigned long )4;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_A;
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


		
		    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
		    {
		        ifnTrazaHilos( modulo,&pfLog, "Cliente: [%ld] Al recuperar Codigo de Gestion (2) %s.", LOG00, lhCodCliente, SQLERRM );
		        return FALSE;
		    }
		 
		    if( !strcmp( szhCodGestion, "NN" ) ) 
		    {
       		  strcpy( szhCodGestion, "MR" );
		        ifnTrazaHilos( modulo,&pfLog, "Cliente [%ld]. No se encontro Codigo de Gestion NN, se asigna 'MR'.", LOG05, lhCodCliente );
		    }
		} /* if( iIndExcluye ) */ 
	} /* if( strcmp( szhCodGestion, "NN" ) ) */

    ifnTrazaHilos( modulo,&pfLog, "Cliente:'%ld' Nuevo Cod_Gestion = [%s]", LOG03, lhCodCliente, szhCodGestion );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE CO_MOROSOS  SET		
           COD_GESTION = :szhCodGestion,
			  FEC_GESTION = SYSDATE 
    WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_MOROSOS  set COD_GESTION=:b0,FEC_GESTION=SYSDAT\
E where COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1114;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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


    
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de CO_MOROSOS del Cliente:'%ld' Cod_estado:'%s' > %s",LOG00,lhCodCliente,szhCodGestion,SQLERRM);
        return FALSE;
    }

    strcpy( szhCodGestion,( ( !strcmp( szhCodGestion, "MR" ) ) ? "CO" : szhCodGestion ) );	/* en la Morosos no va CO, va MR */

    /* Aqui actualizar el COD_ESTADO de la GA_ABOCEL y la GA_ABOBEEP con el COD_GESTION de la CO_PTOSGESTION */
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE GA_ABOCEL  SET		
           COD_ESTADO  = :szhCodGestion
    WHERE  COD_CLIENTE = :lhCodCliente
    AND	  COD_USO    != :ihValor_tres; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GA_ABOCEL  set COD_ESTADO=:b0 where (COD_CLIENTE=:\
b1 and COD_USO<>:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1137;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_tres;
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


    
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de GA_ABOCEL del Cliente:'%ld' Cod_estado:'%s' > %s" ,LOG00,lhCodCliente,szhCodGestion,SQLERRM);
        return FALSE;
    }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE	GA_ABOBEEP
    SET		COD_ESTADO = :szhCodGestion
    WHERE	COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GA_ABOBEEP  set COD_ESTADO=:b0 where COD_CLIENTE=:\
b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1164;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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


    
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de GA_ABOBEEP del Cliente:'%ld' Cod_estado:'%s' > %s",LOG00,lhCodCliente,szhCodGestion,SQLERRM);
        return FALSE;
    }

    return TRUE;
} /* BOOL bfnFindNewCodGestion( long lCodCliente, int iIndExcluye ) */


/*==================================================================================================*/
/* Funcion que Genera e imprime el archivo de salida para las empresas de cobranza externas         */
/*==================================================================================================*/
BOOL bfnGenArchCobExterna( char *szCodProceso,     long lProceso,       char *szEntidad,     char *szEnvio, 
                           char *szIdent,          char *szTipIdent,     int iRutStgo,
                           long *lRegsEscritos,  double *dMontoEscrito, char *szNombreArchivo )
{
char modulo[]="bfnGenArchCobExterna";
FILE *fa = (FILE *)NULL;

char szPathArchivo[255];
char szArchivo[512];
long lClienteAnterior = -9999;
int iRutMetro=0, iError=0, iCantAbon=0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhDirCorrespondencia[2]="" ; /* EXEC SQL VAR szhDirCorrespondencia IS STRING(2); */ 

	long lhNumProceso           = 0  ;
	char szhCodEntidad   [6]    = "" ; /* EXEC SQL VAR szhCodEntidad  IS STRING(6); */ 

	char szhCodEnvio     [2]    = "" ; /* EXEC SQL VAR szhCodEnvio    IS STRING(2); */ 

	char szhNumIdent     [iLENNUMIDENT]   = "" ; /* EXEC SQL VAR szhNumIdent    IS STRING(iLENNUMIDENT); */ 

	char szhCodTipIdent  [3]    = "" ; /* EXEC SQL VAR szhCodTipIdent IS STRING(3); */ 

	long lhCodCliente           = 0  ;
	long lhNumAbonado           = 0  ;
	long lhAbonadoAnterior      = 0  ;
	long lhNumCelular           = 0  ;
	int ihCodTipDocum           = 0  ;
	long lhNumFolio             = 0  ;
	int ihNumCuota              = 0  ;
	int ihSecCuota              = 0  ;
	double dhImpDeuda           = 0.0;
	char szhFecEmision   [9]    = "" ;/* EXEC SQL VAR szhFecEmision   IS STRING(9); */ 

	char szhFecVencimie  [9]    = "" ;/* EXEC SQL VAR szhFecVencimie  IS STRING(9); */ 

	char szhNomCliente   [51]   = "" ;/* EXEC SQL VAR szhNomCliente   IS STRING(51); */ 

	char szhDesCalle     [51]   = "" ;/* EXEC SQL VAR szhDesCalle     IS STRING(51); */ 

	char szhNroPiso      [11]   = "" ;/* EXEC SQL VAR szhNroPiso      IS STRING(11); */ 

	char szhNumCalle     [11]   = "" ;/* EXEC SQL VAR szhNumCalle     IS STRING(11); */ 

	char szhCodComuna    [6]    = "" ;/* EXEC SQL VAR szhCodComuna    IS STRING(6); */ 

	char szhDesComuna    [31]   = "" ;/* EXEC SQL VAR szhDesComuna    IS STRING(31); */ 

	char szhCodCiudad    [6]    = "" ;/* EXEC SQL VAR szhCodCiudad    IS STRING(6); */ 

	char szhDesCiudad    [31]   = "" ;/* EXEC SQL VAR szhDesCiudad    IS STRING(31); */ 

	char szhDesProvincia [31]   = "" ;/* EXEC SQL VAR szhDesProvincia IS STRING(31); */ 

	char szhCodOficina   [3]    = "" ;/* EXEC SQL VAR szhCodOficina   IS STRING(3); */ 

	char szhDesOficina   [41]   = "" ;/* EXEC SQL VAR szhDesOficina   IS STRING(41); */ 

	char szhTelContacto  [13]   = "" ;/* EXEC SQL VAR szhTelContacto  IS STRING(13); */ 

	char szhCodCatCuenta [6]    = "" ;/* EXEC SQL VAR szhCodCatCuenta IS STRING(6); */ 

	int  ihCodRegion            = 0   ;
	char szhCodCliente   [9]    = "" ;/* EXEC SQL VAR szhCodCliente   IS STRING(9); */ 

	static char szhQuery [1024]      ;/* EXEC SQL VAR szhQuery IS STRING(1024); */ 

	char szhZeros        [9];
	char szhNumeroVeinte [3];
	char szhBAA          [4];
	int  ihValor_cero  = 0;
/* EXEC SQL END DECLARE SECTION; */ 


    ifnTrazasLog(modulo,"Iniciando %s",LOG05,modulo);
    lhNumProceso = lProceso;

    sprintf(szhDirCorrespondencia,"3\0");
    ihCodRegion=iRutStgo; /* 1:STGO ; 2:REGION */
    
    *lRegsEscritos = 0;
    *dMontoEscrito = 0.0;
    strcpy(szNombreArchivo,"");
    
    strcpy(szhCodEntidad,szEntidad);
    strcpy(szhNumIdent,szIdent);
    strcpy(szhCodTipIdent,szTipIdent);
    strcpy(szhCodEnvio,szEnvio);
    strcpy(szhZeros,"00000000");
    strcpy(szhNumeroVeinte,"20");
    strcpy(szhBAA,"BAA");

    /* definir el nombre del archivo a escribir */
    sprintf(szPathArchivo,"%s/COBEX/%s",getenv("XPC_DAT"),szEntidad);
    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"mkdir -p %s",szPathArchivo);
    if (system (szArchivo)!=0) 
    {
        ifnTrazasLog(modulo,"Fallo la creacion del directorio del archivo de salida '%s'",LOG01,szPathArchivo);
        return FALSE; /* termina el proceso */
    }

    sprintf(szNombreArchivo,"%s_%s_%ld.txt",szCodProceso,szEntidad,lProceso);
    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"%s/%s",szPathArchivo,szNombreArchivo);
            
    if ( (fa=fopen(szArchivo,"a")) == (FILE *)NULL ) /* append */
    {
        ifnTrazasLog(modulo,"Fallo la apertura del archivo '%s'",LOG01,szArchivo);
        return FALSE; /* termina el proceso */
    }
 
    ifnTrazasLog(modulo,"szArchivo : %s",LOG05,szArchivo);
    ifnTrazasLog(modulo,"NumIdent  : %s",LOG05,szhNumIdent);

	if( strcmp( szhCodEnvio, "B" ) == 0 || strcmp( szhCodEnvio, "R" ) == 0 ) 
	{
            /* Aqui insertar en el archivo */
            if (fprintf(fa ,"%08ld"    
                            "%-5s"     
                            "%.1s"       
                            "%-11s"    
                            "%-350s\n" 		/* 2 para el Tip.Ident, 348 en blanco */         
                            ,lhNumProceso    
                            ,szhCodEntidad   
                            ,"B"			/* szhCodEnvio mgg 03.08.2001 */
                            ,szhNumIdent     
                            ,szhCodTipIdent  
                          ) != 376 )  /* Si escribio X caracteres distinto de lo que se esperaba */
            {
                ifnTrazasLog(modulo,"Fallo escritura del archivo(2)",LOG01);
        		return FALSE; /* termina el proceso */
            }
            fflush (fa);
			*lRegsEscritos = 1;
    		if ( fclose(fa) )
    		{
        		ifnTrazasLog(modulo,"Fallo el cierre del archivo '%s'",LOG01,szArchivo);
        		iError = 1; /* termina el proceso */
    		}
			return TRUE;
	}

    /* llenado de la estructura de datos a escribir */
    /* Para un mismo rut puede haber mas de un cliente */
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL 
    DECLARE curDatosCli CURSOR FOR
    SELECT distinct COD_CLIENTE 
    FROM GE_CLIENTES
    WHERE NUM_IDENT = :szhNumIdent
    AND   COD_TIPIDENT = :szhCodTipIdent ; */ 

    if ( SQLCODE ) 
    {
        ifnTrazasLog(modulo,"Declare curDatosCli (Rut:%s) %s",LOG00,szhNumIdent,SQLERRM);
        return FALSE; /* termina el proceso */
    }
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    OPEN curDatosCli ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0035;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1187;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
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


    if( SQLCODE )
    {
        ifnTrazasLog(modulo,"Open curDatosCli (Rut:%s) %s",LOG00,szhNumIdent,SQLERRM);
        return FALSE; /* termina el proceso */
    }

    iCantAbon=0; /* total de abonados asociados al rut (cualquier cliente) */
    while (1)
    {
    	sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL 
        FETCH curDatosCli
        INTO :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1210;
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
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

        
        if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
            ifnTrazasLog(modulo,"Fetch curDatosCli (Rut:%s) %s",LOG00,szhNumIdent,SQLERRM);
            iError = 1; /* termina el proceso */
            break;
        }
        else if ( SQLCODE == SQLNOTFOUND )
        {
            ifnTrazasLog(modulo,"Alcanzado fin de datos curDatosCli",LOG05);
            iError = 0;
            break;
        }

        if (lClienteAnterior != lhCodCliente) /* Solo si es un cliente nuevo */
        {
            ifnTrazasLog(modulo,"Cliente (%ld)!= Anterior",LOG05,lhCodCliente);

            lClienteAnterior = lhCodCliente ;
    		   sprintf(szhCodCliente,"%ld\0",lhCodCliente);

            memset(szhNomCliente    ,'\0'   ,sizeof(szhNomCliente));
            memset(szhDesCalle      ,'\0'   ,sizeof(szhDesCalle));
            memset(szhNroPiso       ,'\0'   ,sizeof(szhNroPiso));
            memset(szhNumCalle      ,'\0'   ,sizeof(szhNumCalle));
            memset(szhCodComuna     ,'\0'   ,sizeof(szhCodComuna));
            memset(szhDesComuna     ,'\0'   ,sizeof(szhDesComuna));
            memset(szhCodCiudad     ,'\0'   ,sizeof(szhCodCiudad));
            memset(szhDesCiudad     ,'\0'   ,sizeof(szhDesCiudad));
            memset(szhDesProvincia  ,'\0'   ,sizeof(szhDesProvincia));
            memset(szhCodOficina    ,'\0'   ,sizeof(szhCodOficina));
            memset(szhDesOficina    ,'\0'   ,sizeof(szhDesOficina));
            memset(szhTelContacto   ,'\0'   ,sizeof(szhTelContacto));
            
            sqlca.sqlcode=0; /* XO-200508280498 rvc */
            /* EXEC SQL
            SELECT RTRIM(GC.NOM_CLIENTE)||' '||NVL(RTRIM(GC.NOM_APECLIEN1),' ')||' '||NVL(RTRIM(GC.NOM_APECLIEN2),' ')
                 , RTRIM(G1.NOM_CALLE)
                 , NVL(RTRIM(G1.NUM_PISO),' ')
                 , NVL(RTRIM(G1.NUM_CALLE),' ')
                 , G1.COD_COMUNA
                 , RTRIM(G5.DES_COMUNA)
                 , G1.COD_CIUDAD
                 , RTRIM(G4.DES_CIUDAD)
                 , RTRIM(G3.DES_PROVINCIA)
                 , G6.COD_OFICINA
                 , RTRIM(G6.DES_OFICINA)
                 , NVL(GC.TEF_CLIENTE1,:szhZeros)
            INTO   :szhNomCliente   
                 , :szhDesCalle     
                 , :szhNroPiso      
                 , :szhNumCalle     
                 , :szhCodComuna    
                 , :szhDesComuna    
                 , :szhCodCiudad    
                 , :szhDesCiudad    
                 , :szhDesProvincia 
                 , :szhCodOficina   
                 , :szhDesOficina   
                 , :szhTelContacto  
            FROM   GE_OFICINAS     G6
                 , GE_COMUNAS      G5
                 , GE_CIUDADES     G4
                 , GE_PROVINCIAS   G3
                 , GE_REGIONES     G2
                 , GE_DIRECCIONES  G1
                 , GA_DIRECCLI     G0
                 , GE_CLIENTES     GC
            WHERE  GC.COD_CLIENTE = :lhCodCliente 
            AND    G0.COD_CLIENTE =  GC.COD_CLIENTE
            AND    G0.COD_TIPDIRECCION = :szhDirCorrespondencia 
            AND    G1.COD_DIRECCION = G0.COD_DIRECCION
            AND    G2.COD_REGION    = G1.COD_REGION 
            AND    G3.COD_REGION    = G1.COD_REGION
            AND    G3.COD_PROVINCIA = G1.COD_PROVINCIA 
            AND    G4.COD_REGION    = G1.COD_REGION 
            AND    G4.COD_PROVINCIA = G1.COD_PROVINCIA 
            AND    G4.COD_CIUDAD    = G1.COD_CIUDAD 
            AND    G5.COD_REGION    = G1.COD_REGION 
            AND    G5.COD_PROVINCIA = G1.COD_PROVINCIA 
            AND    G5.COD_COMUNA    = G1.COD_COMUNA 
            AND    G6.COD_OFICINA   = NVL(GC.COD_OFICINA, :szhNumeroVeinte); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 16;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlbuft((void **)0, 
              "select ((((RTRIM(GC.NOM_CLIENTE)||' ')||NVL(RTRIM(GC.NOM_APEC\
LIEN1),' '))||' ')||NVL(RTRIM(GC.NOM_APECLIEN2),' ')) ,RTRIM(G1.NOM_CALLE) ,\
NVL(RTRIM(G1.NUM_PISO),' ') ,NVL(RTRIM(G1.NUM_CALLE),' ') ,G1.COD_COMUNA ,RT\
RIM(G5.DES_COMUNA) ,G1.COD_CIUDAD ,RTRIM(G4.DES_CIUDAD) ,RTRIM(G3.DES_PROVIN\
CIA) ,G6.COD_OFICINA ,RTRIM(G6.DES_OFICINA) ,NVL(GC.TEF_CLIENTE1,:b0) into :\
b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12  from GE_OFICINAS G6 ,GE_C\
OMUNAS G5 ,GE_CIUDADES G4 ,GE_PROVINCIAS G3 ,GE_REGIONES G2 ,GE_DIRECCIONES \
G1 ,GA_DIRECCLI G0 ,GE_CLIENTES GC where (((((((((((((GC.COD_CLIENTE=:b13 an\
d G0.COD_CLIENTE=GC.COD_CLIENTE) and G0.COD_TIPDIRECCION=:b14) and G1.COD_DI\
RECCION=G0.COD_DIRECCION) and G2.COD_REGION=G1.COD_REGION) and G3.COD_REGION\
=G1.COD_REGION) and G3.COD_PROVINCIA=G1.COD_PROVINCIA) and G4.COD_REGION=G1.\
COD_REGION) and G4.COD_PROVINCIA=G1.COD_PROVINCIA) and G4.COD_CIUDAD=G1.COD_\
CIUDAD) and G5.COD_REGION=G1.COD_REGION) and G5.COD_PROVINCIA=G1.COD_PROVINC\
IA) and G5.COD_COMUNA=G1.COD_COMUNA) and G6.COD_OFI");
            sqlstm.stmt = "CINA=NVL(GC.COD_OFICINA,:b15))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1229;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhZeros;
            sqlstm.sqhstl[0] = (unsigned long )9;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhNomCliente;
            sqlstm.sqhstl[1] = (unsigned long )51;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhDesCalle;
            sqlstm.sqhstl[2] = (unsigned long )51;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhNroPiso;
            sqlstm.sqhstl[3] = (unsigned long )11;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhNumCalle;
            sqlstm.sqhstl[4] = (unsigned long )11;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhCodComuna;
            sqlstm.sqhstl[5] = (unsigned long )6;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhDesComuna;
            sqlstm.sqhstl[6] = (unsigned long )31;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhCodCiudad;
            sqlstm.sqhstl[7] = (unsigned long )6;
            sqlstm.sqhsts[7] = (         int  )0;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)szhDesCiudad;
            sqlstm.sqhstl[8] = (unsigned long )31;
            sqlstm.sqhsts[8] = (         int  )0;
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)szhDesProvincia;
            sqlstm.sqhstl[9] = (unsigned long )31;
            sqlstm.sqhsts[9] = (         int  )0;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)szhCodOficina;
            sqlstm.sqhstl[10] = (unsigned long )3;
            sqlstm.sqhsts[10] = (         int  )0;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szhDesOficina;
            sqlstm.sqhstl[11] = (unsigned long )41;
            sqlstm.sqhsts[11] = (         int  )0;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)szhTelContacto;
            sqlstm.sqhstl[12] = (unsigned long )13;
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
            sqlstm.sqhstv[14] = (unsigned char  *)szhDirCorrespondencia;
            sqlstm.sqhstl[14] = (unsigned long )2;
            sqlstm.sqhsts[14] = (         int  )0;
            sqlstm.sqindv[14] = (         short *)0;
            sqlstm.sqinds[14] = (         int  )0;
            sqlstm.sqharm[14] = (unsigned long )0;
            sqlstm.sqadto[14] = (unsigned short )0;
            sqlstm.sqtdso[14] = (unsigned short )0;
            sqlstm.sqhstv[15] = (unsigned char  *)szhNumeroVeinte;
            sqlstm.sqhstl[15] = (unsigned long )3;
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
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 /* oficina central si no tiene jlr_26.03.01 */
            if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
            {
                ifnTrazasLog(modulo,"Select Datos Direccion del Cliente %ld %s",LOG00, lhCodCliente, SQLERRM);
                iError = 1; /* termina el proceso */
                break;
            }
            else if ( SQLCODE == SQLNOTFOUND )
            {
                ifnTrazasLog(modulo,"Select Datos del Cliente %ld NO ENCONTRO LA DIRECCION ",LOG01, lhCodCliente);
                continue; /* Si tuvo problemas Siga con el proximo cliente del rut */
            }

            ifnTrazasLog(modulo,"szhNomCliente    [%s]",LOG05,szhNomCliente);
            ifnTrazasLog(modulo,"szhDesCalle      [%s]",LOG05,szhDesCalle);
            ifnTrazasLog(modulo,"szhNroPiso       [%s]",LOG05,szhNroPiso);
            ifnTrazasLog(modulo,"szhNumCalle      [%s]",LOG05,szhNumCalle);
            ifnTrazasLog(modulo,"szhCodComuna     [%s]",LOG05,szhCodComuna);
            ifnTrazasLog(modulo,"szhDesComuna     [%s]",LOG05,szhDesComuna);
            ifnTrazasLog(modulo,"szhCodCiudad     [%s]",LOG05,szhCodCiudad);
            ifnTrazasLog(modulo,"szhDesCiudad     [%s]",LOG05,szhDesCiudad);
            ifnTrazasLog(modulo,"szhDesProvincia  [%s]",LOG05,szhDesProvincia);
            ifnTrazasLog(modulo,"szhCodOficina    [%s]",LOG05,szhCodOficina);
            ifnTrazasLog(modulo,"szhDesOficina    [%s]",LOG05,szhDesOficina);
            ifnTrazasLog(modulo,"szhTelContacto   [%s]",LOG05,szhTelContacto);
            
            memset(szhCodCatCuenta  ,'\0'   ,sizeof(szhCodCatCuenta));
    
            if( !bfnGetPerfil( lhCodCliente, szhCodCatCuenta ) ) /*envia mensaje de error al log */
            {   
                /*iError = 1;*/ /* termina el proceso */
                /*break;*/
                continue; /* Si tuvo problemas Siga con el proximo cliente del rut */
            }           

            ifnTrazasLog(modulo,"szhCodCatCuenta  [%s]",LOG05,szhCodCatCuenta);
 
        } /* endif (lClienteAnterior != lhCodCliente) */

		  strcpy(szhQuery, "	SELECT NUM_ABONADO"
        	                ", COD_TIPDOCUM"
        	                ", NUM_FOLIO"
       	                ", NVL(SEC_CUOTA,0)"
        	                ", NVL((IMPORTE_DEBE - IMPORTE_HABER), 0)"
        	                ", TO_CHAR (FEC_EFECTIVIDAD , 'DDMMYYYY')"
        	                ", TO_CHAR (FEC_VENCIMIE    , 'DDMMYYYY')" );

		if (!strcmp(szCodProceso,"COBEX")) /* si es el proceso Normal de Cobranza Externa */
		{
        	strcat(szhQuery," , NVL(NUM_CUOTAS,0) ");
			strcat(szhQuery,"FROM CO_COBEXTERNADOC WHERE COD_CLIENTE = ");
			strcat(szhQuery,szhCodCliente);
		}
		else /* proceso Masivo de Cob. Externa */
		{
        	strcat(szhQuery," , NVL(NUM_CUOTA,0) ");
			strcat(szhQuery,"FROM CO_CARTERA WHERE COD_CLIENTE = ");
			strcat(szhQuery,szhCodCliente);
			strcat(szhQuery," AND COD_TIPDOCUM NOT IN ( SELECT  TO_NUMBER(COD_VALOR) " /* para que no tome los cheques y pagares */
														" FROM    CO_CODIGOS "
														" WHERE   NOM_TABLA = 'CO_CARTERA' "
														" AND     NOM_COLUMNA = 'COD_TIPDOCUM'    ) "
							" AND NUM_FOLIO NOT IN ( " /* para que no tome los castigos y las factiras asociadas */
							" SELECT NUM_FOLIO "
							" FROM CO_CARTERA "
							" WHERE COD_CLIENTE = ");
			strcat(szhQuery,szhCodCliente);
			strcat(szhQuery," AND COD_TIPDOCUM = 39	) ");
		}
		strcat(szhQuery," ORDER BY NUM_ABONADO ");

		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL PREPARE query_curDocs FROM :szhQuery; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1308;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
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


       	if ( SQLCODE )
       	{
            ifnTrazasLog(modulo,"PREPARE curDocs (Cliente:%ld) %s",LOG00,lhCodCliente,SQLERRM);
            iError = 1; /* termina el proceso */
            break;
       	}
       	sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL DECLARE curDocs CURSOR FOR query_curDocs; */ 

        if ( SQLCODE )
        {
           	ifnTrazasLog(modulo,"DECLARE curDocs (Cliente:%ld) %s",LOG00,lhCodCliente,SQLERRM);
           	iError = 1; /* termina el proceso */
           	break;
        }
        sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL 
        OPEN curDocs ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1327;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if ( SQLCODE )
        {
            ifnTrazasLog(modulo,"OPEN curDocs (Cliente:%ld) %s",LOG00,lhCodCliente,SQLERRM);
            iError = 1;
            break;
        }

        iError = 0;
        lhAbonadoAnterior=-1;   
             
        while (1)
        {
            lhNumAbonado    = 0 ;
            ihCodTipDocum   = 0 ;
            lhNumFolio      = 0 ;
            ihNumCuota      = 0 ;
            ihSecCuota      = 0 ;
            dhImpDeuda      = 0.0 ;
            memset(szhFecEmision    ,'\0'   ,sizeof(szhFecEmision));
            memset(szhFecVencimie   ,'\0'   ,sizeof(szhFecEmision));

			sqlca.sqlcode=0; /* XO-200508280498 rvc */
            /* EXEC SQL 
            FETCH curDocs
            INTO   :lhNumAbonado
                 , :ihCodTipDocum
                 , :lhNumFolio
                 , :ihSecCuota
                 , :dhImpDeuda
                 , :szhFecEmision
                 , :szhFecVencimie
                 , :ihNumCuota ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 16;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1342;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
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
            sqlstm.sqhstv[3] = (unsigned char  *)&ihSecCuota;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&dhImpDeuda;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhFecEmision;
            sqlstm.sqhstl[5] = (unsigned long )9;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhFecVencimie;
            sqlstm.sqhstl[6] = (unsigned long )9;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)&ihNumCuota;
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
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



            if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
            {
                ifnTrazasLog(modulo,"Fetch curDocs (Cliente:%ld):%s",LOG00,lhCodCliente,SQLERRM);
                iError=1; /* termina el proceso */
                break;
            }
            else if ( SQLCODE == SQLNOTFOUND )
            {
                ifnTrazasLog(modulo,"Fin de Datos Documentos de Abonados (curDocs)",LOG05);
                iError=0;
                break;
            }
            
            iCantAbon++;
            
            ifnTrazasLog(modulo,"-------------------------------------------\n",LOG05);
            ifnTrazasLog(modulo,"lhNumAbonado     [%ld]",LOG05,lhNumAbonado   );
            ifnTrazasLog(modulo,"ihCodTipDocum    [%d]" ,LOG05,ihCodTipDocum  );
            ifnTrazasLog(modulo,"lhNumFolio       [%ld]",LOG05,lhNumFolio     );
            ifnTrazasLog(modulo,"ihNumCuota       [%d]" ,LOG05,ihNumCuota     );
            ifnTrazasLog(modulo,"ihSecCuota       [%d]" ,LOG05,ihSecCuota     );
            ifnTrazasLog(modulo,"dhImpDeuda       [%.f]",LOG05,dhImpDeuda     );
            ifnTrazasLog(modulo,"szhFecEmision    [%s]" ,LOG05,szhFecEmision  );
            ifnTrazasLog(modulo,"szhFecVencimie   [%s]" ,LOG05,szhFecVencimie );

            if ( lhAbonadoAnterior != lhNumAbonado )
            {
                lhAbonadoAnterior = lhNumAbonado;

                lhNumCelular    = 0 ;
                if ( lhNumAbonado != 0 )
                {
                	sqlca.sqlcode=0; /* XO-200508280498 rvc */
                    /* EXEC SQL
                    SELECT NVL(NUM_CELULAR,:ihValor_cero)
                    INTO   :lhNumCelular
                    FROM   GA_ABOCEL
                    WHERE  NUM_ABONADO    = :lhNumAbonado
                    AND    COD_SITUACION != :szhBAA ; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 16;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select NVL(NUM_CELULAR,:b0) into :b1  fro\
m GA_ABOCEL where (NUM_ABONADO=:b2 and COD_SITUACION<>:b3)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )1389;
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
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCelular;
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
                    sqlstm.sqhstv[3] = (unsigned char  *)szhBAA;
                    sqlstm.sqhstl[3] = (unsigned long )4;
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

	/* MGG_02.04.01 */
        
                    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
                    {
                        ifnTrazasLog(modulo,"Select NUM_CELULAR de GA_ABOCEL (Abonado:%ld) : %s",LOG00,lhNumAbonado,SQLERRM);
                        iError = 1; /* termina el proceso */
                        break;
                    }
                    else if ( SQLCODE == SQLNOTFOUND )	/* MGG_02.04.01 */
                    {
                        lhNumCelular    = 0 ;
                    }
                }
            }

            ifnTrazasLog(modulo,"lhNumCelular     [%ld]" ,LOG05,lhNumCelular );

            /* Aqui insertar en el archivo */
            if (fprintf(fa ,"%08ld"    
                            "%-5s"     
                            "%.1s"       
                            "%-11s"    
                            "%-2s"     
                            "%08ld"    
                            "%08ld"  
                            "%08ld"    
                            "%02d"     
                            "%08ld"    
                            "%02d"     
                            "%02d"     
                            "%014.f"   
                            "%8s"      
                            "%8s"      
                            "%-50s"    
                            "%-50s"    
                            "%-10s"    
                            "%-10s"    
                            "%-5s"     
                            "%-30s"    
                            "%-5s"     
                            "%-30s"    
                            "%-30s"    
                            "%-2s"     
                            "%-40s"    
                            "%-12s"    
                            "%-5s"     
                            "%d\n"         
                            ,lhNumProceso    
                            ,szhCodEntidad   
                            ,szhCodEnvio     
                            ,szhNumIdent     
                            ,szhCodTipIdent  
                            ,lhCodCliente    
                            ,lhNumAbonado    
                            ,lhNumCelular    
                            ,ihCodTipDocum   
                            ,lhNumFolio      
                            ,ihNumCuota      
                            ,ihSecCuota      
                            ,dhImpDeuda      
                            ,szhFecEmision   
                            ,szhFecVencimie  
                            ,szhNomCliente   
                            ,szhDesCalle     
                            ,szhNroPiso      
                            ,szhNumCalle     
                            ,szhCodComuna    
                            ,szhDesComuna    
                            ,szhCodCiudad    
                            ,szhDesCiudad    
                            ,szhDesProvincia 
                            ,szhCodOficina   
                            ,szhDesOficina   
                            ,szhTelContacto  
                            ,szhCodCatCuenta 
                            ,ihCodRegion      
                          ) != 376 )  /* Si escribio X caracteres distinto de lo que se esperaba */
            {
                ifnTrazasLog(modulo,"Fallo escritura del archivo ",LOG01);
                iError = 1; /* termina el proceso */
                break;
            }
                  
            fflush (fa);

            *lRegsEscritos = *lRegsEscritos + 1;
            *dMontoEscrito = *dMontoEscrito + dhImpDeuda;
            
        } /* end while (documentos de un cliente) */            
        
        sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL 
        CLOSE curDocs ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1420;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if ( SQLCODE )
        {
            ifnTrazasLog(modulo,"Close curDocs (Cliente:%ld) %s",LOG00,lhCodCliente,SQLERRM);
            iError = 1; /* termina el proceso */
        }
        
        if (iError == 1)
            break; /* termina el proceso */
        
    } /* end while (clientes del rut dado) */

    if (iCantAbon == 0) /* no encontro ningun movimiento asociado al rut ( cualquier cliente ) */
    {
        ifnTrazasLog(modulo,"-WARNING- Para el Rut (%s) no hay documentos ",LOG01,szhNumIdent);
    }
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    CLOSE curDatosCli; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1435;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if ( SQLCODE )
    {
        ifnTrazasLog(modulo,"Close curDatosCli (rut:%s) %s",LOG00,szhNumIdent,SQLERRM);
        iError = 1; /* termina el proceso */
    }

    if ( fclose(fa) )
    {
        ifnTrazasLog(modulo,"Fallo el cierre del archivo '%s'",LOG01,szArchivo);
        iError = 1; /* termina el proceso */
    }
    
    if ( iError ) /* si ocurrio un error */
        return FALSE; 
    else
        return TRUE; 
}


/*==================================================================================================*/
/* Funcion que Obtiene el Perfil del Cliente   Retorna FALSE si no puede determinarlo               */
/*==================================================================================================*/
BOOL bfnGetPerfil( long lCli, char *szPerfil )
{
char modulo[]="bfnGetPerfil";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long 	lhCodCliente = lCli;
   int  	ihCount = 0        ;
	char	szhPerfil[6];
   char 	szhCodCategoria[6] ; /* EXEC SQL VAR szhCodCategoria IS STRING (6); */ 

   char  szhPymes        [6];
   char  szhGrcli        [6];
   char  szh31123000     [9];
   char  szhDDMMYYYY     [9];
   char  szhGE_CLIENTES  [12];
   char  szhCOD_CATEGORIA[14];
   char  szhFiller       [2];
   int   ihValor_uno   = 1;
   int   ihValor_cinco = 5;
/* EXEC SQL END DECLARE SECTION; */ 

 
	memset( szhPerfil, '\0', sizeof( szhPerfil ) );
	ifnTrazasLog(modulo,"Seleccionando Categoria del Cliente [%ld]",LOG05,lCli);
	/* Asignacion de variables bind */
	strcpy(szhPymes        ,"PYMES");
	strcpy(szhGrcli        ,"GRCLI");
	strcpy(szh31123000     ,"31123000");
	strcpy(szhDDMMYYYY     ,"DDMMYYYY");
	strcpy(szhGE_CLIENTES  ,"GE_CLIENTES");
	strcpy(szhCOD_CATEGORIA,"COD_CATEGORIA");
	strcpy(szhFiller, " ");

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT TO_CHAR( COD_CATEGORIA )
	INTO   :szhCodCategoria
	FROM   GE_CLIENTES
	WHERE  COD_CLIENTE = :lhCodCliente
	AND    COD_CATEGORIA IS NOT NULL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(COD_CATEGORIA) into :b0  from GE_CLIENTES whe\
re (COD_CLIENTE=:b1 and COD_CATEGORIA is  not null )";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1450;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodCategoria;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
	if( SQLCODE == SQLNOTFOUND )	{
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL
		SELECT COD_CATCUENTA
		INTO 	:szhCodCategoria
		FROM 	CO_CATCUENTAS
		WHERE COD_CLIENTE = :lhCodCliente
		AND   ( FEC_HASTA IS NULL OR 	( TRUNC(FEC_HASTA) = TO_DATE(:szh31123000,:szhDDMMYYYY) ) )
		AND 	COD_CATCUENTA NOT IN (:szhPymes,:szhGrcli); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_CATCUENTA into :b0  from CO_CATCUENTAS where ((C\
OD_CLIENTE=:b1 and (FEC_HASTA is null  or TRUNC(FEC_HASTA)=TO_DATE(:b2,:b3))) \
and COD_CATCUENTA not  in (:b4,:b5))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1473;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodCategoria;
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
  sqlstm.sqhstv[2] = (unsigned char  *)szh31123000;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDDMMYYYY;
  sqlstm.sqhstl[3] = (unsigned long )9;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhPymes;
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhGrcli;
  sqlstm.sqhstl[5] = (unsigned long )6;
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


    	
    	if ( SQLCODE == SQLNOTFOUND )	 {
           	strcpy(szPerfil,"ENA\0");
     	} else {

        	if ( SQLCODE ) {
				ifnTrazasLog(modulo,"Seleccionando Perfil Cliente %ld segun CO_CATCUENTAS : %s",LOG00,lhCodCliente,SQLERRM);
    			return FALSE;
    		
    		} else  {
	        	strcpy( szPerfil, szhCodCategoria );
	    	}
    	}
	
	} else {

      if( SQLCODE )  {
			ifnTrazasLog( modulo, "Cliente => [%d], Seleccionando Perfil desde GE_CLIENTES => [%s].", LOG00, lhCodCliente, SQLERRM );
    		return FALSE;
    	
    	} else  {

			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL 
			SELECT NVL( SUBSTR( DES_VALOR, :ihValor_uno, :ihValor_cinco ), :szhFiller )
			INTO	 :szhPerfil
			FROM	 CO_CODIGOS
			WHERE  NOM_TABLA	= :szhGE_CLIENTES
			AND	 NOM_COLUMNA = :szhCOD_CATEGORIA
			AND    TO_NUMBER( COD_VALOR )  = TO_NUMBER( :szhCodCategoria ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(SUBSTR(DES_VALOR,:b0,:b1),:b2) into :b3  from C\
O_CODIGOS where ((NOM_TABLA=:b4 and NOM_COLUMNA=:b5) and TO_NUMBER(COD_VALOR)=\
TO_NUMBER(:b6))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1512;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cinco;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFiller;
   sqlstm.sqhstl[2] = (unsigned long )2;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhPerfil;
   sqlstm.sqhstl[3] = (unsigned long )6;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhGE_CLIENTES;
   sqlstm.sqhstl[4] = (unsigned long )12;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCOD_CATEGORIA;
   sqlstm.sqhstl[5] = (unsigned long )14;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhCodCategoria;
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



			if( SQLCODE )	{
				ifnTrazasLog( modulo, "Cliente => [%d], Error al recuperar codigo asociado a Perfil desde CO_CODIGOS => [%s].", LOG00, lhCodCliente, SQLERRM );
	    		return FALSE;
	    	}

   		strcpy( szPerfil, szhPerfil );
	    }
   }
	ifnTrazasLog(modulo,"Categoria Seleccionada [%s]",LOG05,szPerfil);
   return TRUE;
}

/*************************************************************************************************/
/* Funciones utilizadas para el uso de hilos y listas enlazadas                                  */
/*************************************************************************************************/
/*************************************************************************************************/
/* Funcion que cede la cpu a otro hilo																				 */
/*************************************************************************************************/
void yield2(void)
{
   if (rand()%2)
      yield();

   return;
}

/*************************************************************************************************/
/* Funcion vfnEvaluaMO 																									 */
/* Utilizada como inicio del PTHREAD de MOROSOS									 								 */
/*************************************************************************************************/
void *vfnEvaluaMO( void *x)
{
char 	modulo[] = "vfnEvaluaMO";
int  	k, ierror, iPrimero, iCumple, ists;
long 	j, istatus;
char  szCategoriaPto[6];
char  szNomArchLog[30];				/* Nombre Log Hilo */
FILE  *fstArchLog;						
lista_Categ pCateg;
lista_SecPtos pSecPto;
lista_Pto pPtoGest, pPtoGestAux;
struct stCliente stMR;
stLista lstCli;
stLista lstAux;
lstAccCM  lstAcc_aux=NULL ;

   /*cast a la variable x */
   k = *(int *)x;
   pCateg = lsCat;

	/* Tratamiento para archivo de log por hilo */
	sprintf(szNomArchLog,"%s_%02ld\0",szPROCESO,k);
	istatus=ifnAbreArchivoLogHil(szNomArchLog, &fstArchLog);
	ifnTrazaHilos( modulo,&fstArchLog, "=============================================================", LOG03);
	ifnTrazaHilos( modulo,&fstArchLog, "*** INICIO ARCHIVO LOG HIJO  MOROSOS --->  [%s]\n\n", LOG02,szNomArchLog);

   strcpy(szCategoriaPto," ");      /*inicializa categoria del Pto*/
   pPtoGestAux = NULL;
   pPtoGest = NULL;
   pSecPto = NULL;	

	for(j = 1, lstCli = pInicio[k] ; lstCli ;) {	
   	
   		iCumpleCriterio = 0; /**** XO-200510100830 12.10.2005 *****/
	   lstAux=lstCli->sgte;
	   yield2();	
		ierror=Leer_element(pInicio[k] ,j,&stMR);
		if (ierror == 0) {
			iPrimero = 0;
			iCumple = 1; 
			ifnTrazaHilos( modulo, &fstArchLog, "=========================================================================================", LOG03);
			ifnTrazaHilos( modulo, &fstArchLog, "stMR.lCod_Cliente.....[%ld]", LOG03,stMR.lCod_Cliente);
			ifnTrazaHilos( modulo, &fstArchLog, "stMR.lSec_Moroso  	  [%ld]", LOG03, stMR.lSec_Moroso);
			ifnTrazaHilos( modulo, &fstArchLog, "stMR.szCod_Categoria  [%s]\n", LOG03, stMR.szCod_Categoria);
			if (strcmp(szCategoriaPto, stMR.szCod_Categoria) !=  0){
			    if (ifnBuscaPtoCategClte(pCateg, &pPtoGest, &pSecPto, stMR.szCod_Categoria)){
			    	pPtoGestAux = pPtoGest; 
			    }
			    else{
			        iCumple = 0;
			    }
			}	else  {
			    pPtoGest = pPtoGestAux;
			}
			ifnTrazaHilos( modulo, &fstArchLog, "\tiCumple Categoria 	  [%d]\n", LOG05, iCumple);
			while (pPtoGest != NULL && iCumple ){

			   if (ifnPtoProrr( pPtoGest, stMR.szFec_Vencimiento)){ /* Pto. de gestion Prorrogable*/
			   	if (pPtoGest->iNumProceso != stMR.lSec_Moroso){
						ifnTrazaHilos( modulo, &fstArchLog, "\t** pPtoGest->iNumProceso  [%d]\n", LOG03, pPtoGest->iNumProceso);
			    		if (ifnBuscaSecAnt( pSecPto, stMR.lSec_Moroso, pPtoGest->iNumProceso)){
			    	    	ifnTrazaHilos( modulo, &fstArchLog, "\t Pasamos a la funcion ifnClienteEvaluar()\n", LOG07);
			    	    	ists = ifnClienteEvaluar(&fstArchLog, pPtoGest, 1, &lstAux);
							if ( ists < 0 ){
								/* Aqui el Flag de cliente ya viene en -1 por lo que al grabar no hace nada*/
			    	    		iCumple = 0;
			    	    	}
			    	   }   
			    	}   
			    	pPtoGest = pPtoGest->sig;

			   } else {
					if (iPrimero == 0) { 
			        	if (ifnBuscaPtoCategClte(pCateg, &pPtoGest, &pSecPto,stMR.szCod_Categoria)) {
			    	      pPtoGestAux = pPtoGest; 
			         } else 
			         	iCumple = 0;
			            
			      } else  
			      	iCumple = 0; 
				}
			   iPrimero = 1;
			
			} /* end while */
			lCliesxHilo[k]++;
		}

		mutex_lock(&bufferlock);
		j++;
		lstCli = lstCli->sgte;
		mutex_unlock(&bufferlock);
   }
   
	ifnTrazaHilos( modulo,&fstArchLog, "*** FIN ARCHIVO LOG HIJO  MOROSOS --->  [%s]\n\n", LOG02,szNomArchLog);
	ifnTrazaHilos( modulo,&fstArchLog, "=============================================================", LOG03);
   if (istatus == 0 )	vfnCierraArchivoLogHil(&fstArchLog);
   
   return 0;
}

/*************************************************************************************************/
/* Funcion vfnEvaluaCM 																								    */
/* Utilizada como inicio del PTHREAD de CANDIDATO A MOROSO 												    */
/*************************************************************************************************/
void *vfnEvaluaCM (void *x)
{
char modulo[] = "ifnEvaluaCM";
char szNomArchLog[30];				/* Nombre Log Hilo */
FILE *fstArchLog;						
int  ierror, iRet, istatus;
int j, k, h;
lista_Categ lsCateg;
lista_Pto lsPtoGest;
struct stCliente lsCMGral;
stLista lstCli;
stLista lstAux;

	/*cast a la variable x */
   k = *((int *)x);
	
	lsCateg = lsCat;
	sprintf(szNomArchLog,"%s_%02ld\0",szPROCESO,k);
	istatus=ifnAbreArchivoLogHil(szNomArchLog, &fstArchLog);
	ifnTrazaHilos( modulo,&fstArchLog, "=============================================================", LOG03);
	ifnTrazaHilos( modulo,&fstArchLog, "*** INICIO ARCHIVO LOG HIJO CANDIDATO A MOROSO --->  [%s]\n\n", LOG02,szNomArchLog);

	while (lsCateg != NULL) {		

		ifnTrazaHilos( modulo, &fstArchLog, "lsCateg->szCodCategoria  [%s]", LOG03, lsCateg->szCodCategoria);
		if (strcmp(lsCateg->szCodCategoria,"NATUR")==0) {
			lsPtoGest=lsCateg->pto_sig;
		
			while (1) {

				ifnTrazaHilos( modulo, &fstArchLog, "\tlsPtoGest->szCodPtoGest  [%s]\n", LOG03, lsPtoGest->szCodPtoGest);
				/***********************************/
				/*  punto de gestion MOROS         */
				/***********************************/
				if (strcmp(lsPtoGest->szCodPtoGest,"MOROS")==0) {

					   
					   for(j = 1, lstCli = pInicio[k] ; lstCli ;) {
							
							iCumpleCriterio = 0; /**** XO-200510100830 12.10.2005 *****/
							lstAux=lstCli->sgte;
							yield2();
							iRet=0;
							ierror=Leer_element(pInicio[k] ,j,&lsCMGral);
						   if (ierror == 0) {
								
								ifnTrazaHilos( modulo, &fstArchLog, "****************************************************************************************", LOG03);
								ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsCMGral.lCod_Cliente.....[%ld]", LOG03,j,lsCMGral.lCod_Cliente);
								ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsCMGral.lSec_Moroso  	  [%ld]", LOG03,j, lsCMGral.lSec_Moroso);
								ifnTrazaHilos( modulo, &fstArchLog, "[%d]==> lsCMGral.szCod_Categoria  [%s]\n", LOG03,j, lsCMGral.szCod_Categoria);
								iRet = ifnClienteEvaluar(&fstArchLog, lsPtoGest, 0, &lstAux);
								if (iRet == -1) {
									ifnTrazaHilos( modulo,&fstArchLog, "Error en la funcion ifnClienteEvaluar con Cliente [%ld].. \n", LOG02,lsCMGral.lCod_Cliente);
									/* Aqui el Flag de cliente ya viene en -1 por lo que al grabar no hace nada*/
								}
								lCliesxHilo[k]++;

							}

							mutex_lock(&bufferlock);
							j++;
							lstCli = lstCli->sgte;
							mutex_unlock(&bufferlock);
						
						}
						break;
				}
				lsPtoGest=lsPtoGest->sig;
			}
			break;
		}	else {
		   ifnTrazaHilos( modulo, &fstArchLog, "Continua con la siguiente categoria\n", LOG03);
		}

		lsCateg=lsCateg->sig;
	}
	ifnTrazaHilos( modulo,&fstArchLog, "*** FIN ARCHIVO LOG HIJO CANDIDATO A MOROSO --->  [%s]\n\n", LOG02,szNomArchLog);
	ifnTrazaHilos( modulo,&fstArchLog, "=============================================================", LOG03);
	if (istatus == 0 )	vfnCierraArchivoLogHil(&fstArchLog);

	return 0;

}

/*==================================================================================================*/
/* Funcion que genera o actualiza los morosos de un cliente segun los puntos de gestion				 */
/*==================================================================================================*/
int ifnClienteEvaluar(FILE **ptArchLog , lista_Pto lsPtoGest, int igGenMoroso, stLista *lstCli)
{
char modulo[] = "ifnClienteEvaluar";	
int  iRet=0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char 	szhFecAccion[9] = ""; /* EXEC SQL VAR szhFecAccion IS STRING(9); */ 
       	/* Fecha Definitiva de Ejecucion de la Accion */
	char 	szhFecHoy[9]    = ""; /* EXEC SQL VAR szhFecHoy    IS STRING(9); */ 
      	/* Fecha Tentativa de Ejecucion de la Accion */
	int  	ihMaxProrroga = 0;
	char  szhYYYYMMDD  [9];
/* EXEC SQL END DECLARE SECTION; */ 

stLista lstCli_aux;
FILE *pfLog;	
pfLog = *ptArchLog;

	strcpy(szhYYYYMMDD,"YYYYMMDD");
	lstCli_aux = *lstCli;
	sema_wait(&semaflock);
	iRet=ifnEjecutaCriteriosEv ( &pfLog, lsPtoGest->Crit_sig, lstCli_aux->Campo, &ihMaxProrroga, 0 );
	sema_post(&semaflock);     /* XO-200508090319  09-08-2005. Soporte RyC PRM.*/
	/*if (iRet != 1) {*/
	if (iRet != -99) {   /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
		return iRet;
	}

	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL EXECUTE
		BEGIN
			:szhFecAccion:=TO_CHAR((TRUNC(SYSDATE) + :ihMaxProrroga),:szhYYYYMMDD);
			:szhFecHoy	 :=TO_CHAR(TRUNC(SYSDATE),:szhYYYYMMDD);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szhFecAccion := TO_CHAR ( ( TRUNC ( SYSDATE ) + :ihMa\
xProrroga ) , :szhYYYYMMDD ) ; :szhFecHoy := TO_CHAR ( TRUNC ( SYSDATE ) , :sz\
hYYYYMMDD ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1555;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecAccion;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihMaxProrroga;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHoy;
 sqlstm.sqhstl[3] = (unsigned long )9;
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


	sema_post(&semaflock);
	if( SQLCODE != SQLOK )	{
		ifnTrazaHilos( modulo, &pfLog, "Error en FecAccion y FecHoy  - %s", LOG01, SQLERRM);
		lstCli_aux->Campo.iFlagGraba = -1;
		return -1;
	}
	
	ifnTrazaHilos( modulo, &pfLog, "\t\tszhFecAccion    [%s]", LOG04, szhFecAccion);
	ifnTrazaHilos( modulo, &pfLog, "\t\tszhFecHoy       [%s]", LOG04, szhFecHoy);
	ifnTrazaHilos( modulo, &pfLog, "\t\tszCod_Gestion   [%s]", LOG04, lstCli_aux->Campo.szCod_Gestion);
	ifnTrazaHilos( modulo, &pfLog, "\t\tigGenMoroso     [%d]", LOG04, igGenMoroso);
	
	lstCli_aux->Campo.iFlagGraba = 0;
	if( !igGenMoroso ) { /* != 0 si Corresponde Generar Morosos */

		if( !strcmp( lstCli_aux->Campo.szCod_Gestion, "MR" ) ) {
			ifnTrazaHilos( modulo, &pfLog, "\t**Generando Moroso....", LOG03);
			lstCli_aux->Campo.iFlagGraba = 1;
			if( ifnGeneraMorosos( &pfLog, lsPtoGest , &lstCli_aux) != 0 ) { 
				ifnTrazaHilos( modulo, &pfLog, "Error en ifnGeneraMorosos. Continua con el sigte cliente...", LOG01);
				lstCli_aux->Campo.iFlagGraba = -1;
				return -1;
			}
			
		} else {

			ifnTrazaHilos( modulo, &pfLog, "\t**Actualizando Moroso....", LOG03);
			if( ifnActualizaMorosos( &pfLog, &lstCli_aux) != 0 ) {
				ifnTrazaHilos( modulo, &pfLog, "Error en ifnActualizaMorosos. Continua con el sigte cliente...", LOG01);
				lstCli_aux->Campo.iFlagGraba = -1;
				return -1;
			}
		}
	}
	
	if (ifnAccionACliente(&pfLog, lsPtoGest->Acc_sig, &lstCli_aux , szhFecAccion , szhFecHoy, lsPtoGest)!=0) {
		lstCli_aux->Campo.iFlagGraba = -1;
		return -1;	
	}
	
	return 0;

}/* fin ifnClienteEvaluar */

/*==================================================================================================*/
/* Funcion que Ejecuta criterios para determinar si el cliente debe ser considerado dentro de un    
   punto de gestion dado. 																									 
   Parametros :	pRutina  		Puntero a lista con criterios a evaluar.
					   lCodCliente 	Codigo de cliente a ser evaluado.
					   iMaxDiasPro		Numero maximo de dias prorroga.									          */
/*==================================================================================================*/
int ifnEjecutaCriteriosEv ( FILE **ptArchLog, lista_Crit pRutina, struct stCliente stMR, int *iMaxDiasPro , int iFlagLog)
{
int	k, iSigCrit = 0, l, iRetornoEvaluado, ilong = 0;
int 	ihMaxProrroga = 0;             /* Maximo Dias de Prorroga */
char 	szCriterio[6] = "", szCriterioAnterior[6] = ""; 
char  modulo[] = "ifnEjecutaCriteriosEv";
lista_Crit pRutinaAux=NULL, pRutinaRango=NULL;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int     ihOkFecha=0;  
	/* VARCHAR vRET[6]; */ 
struct { unsigned short len; unsigned char arr[6]; } vRET;

	char    szhRet[6] = "";
	/* VARCHAR vRETORNO[11]; */ 
struct { unsigned short len; unsigned char arr[11]; } vRETORNO;
 
/*	char    szhRetorno[11]       = "";  Requerimiento Soporte RyC. - 27.07.2007 - Ticket 42058 - COL */
	char    szhRetorno[18]       = ""; 
	char    szStringRango[11]   = "";
/*	char    szStringRetorno[11] = "";   Requerimiento Soporte RyC. - 27.07.2007 - Ticket 42058 - COL */
    char    szStringRetorno[18] = "";
	long    lhCodCliente   = 0;
	long    nCOD_CLIENTE;
	char    szhQuery[201] = "";
	char    szhNomRutina [31];
/* EXEC SQL END DECLARE SECTION; */ 

char szGlosa [1990];       /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */
char cc[3];
FILE *pfLog;	

	pRutinaAux = pRutina;
	lhCodCliente = stMR.lCod_Cliente;

	/* XO-200510100830 11.10.2005 Soporte RyC PRM.*/
    /* iCumpleCriterio = 0;   XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

	/*- revisa 1 a 1 los Criterios del Punto de Gestion -*/
   if (!iFlagLog) {
		pfLog = *ptArchLog;
      ifnTrazaHilos(modulo, &pfLog, "Entrando a funcion [%s]",LOG05,modulo);
      ifnTrazaHilos(modulo, &pfLog, "iFlagLog  [%d]",LOG05,iFlagLog);
      ifnTrazaHilos(modulo, &pfLog, "iCumpleCriterio  [%d]",LOG05,iCumpleCriterio);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
   } else {
      ifnTrazasLog( modulo,"Entrando a funcion [%s]",LOG05,modulo);
      ifnTrazasLog( modulo,"iFlagLog  [%d]",LOG05,iFlagLog);
      ifnTrazasLog( modulo,"iCumpleCriterio  [%d]",LOG05,iCumpleCriterio);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
   }
      
	while( pRutinaAux != NULL ){
		memset(szCriterio, 0, sizeof(szCriterio));
		strcpy(szCriterio, pRutinaAux->szCodRutina);
		strcpy(szhNomRutina,pRutinaAux->szNomRutina);
		
	   if (!iFlagLog)
			ifnTrazaHilos(modulo, &pfLog, "k:[%d]-Criterio:[%s]",LOG06,k,szCriterio);
	   else
	      ifnTrazasLog( modulo,"k:[%d]-Criterio:[%s]",LOG06,k,szCriterio);
	
		/* Si es el mismo criterio anterior */
		if (strcmp(szCriterio, szCriterioAnterior) != 0){/* Lo Saltamos, porque la vuelta anterior ya lo evaluamos */

		   /* Seteamos el Criterio anterior para la siguiente vuelta */
		   strcpy(szCriterioAnterior, szCriterio);
	      /* Inicio Ejecucion del criterio */
		   if (pRutinaAux->iTipFuncion == 0){
				sprintf( szhQuery," BEGIN :vRET := CO_CRITERIOS_PG.%s(:nCOD_CLIENTE,:vRETORNO); END;\0" ,szhNomRutina);
   			if (!iFlagLog)
					ifnTrazaHilos(modulo, &pfLog, "Query:\n%s",LOG05,szhQuery);
			   else
			      ifnTrazasLog( modulo,"Query:\n%s",LOG05,szhQuery);

				/*if (!iFlagLog) sema_wait(&semaflock);*/  /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */
				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL PREPARE S FROM :szhQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1586;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
    sqlstm.sqhstl[0] = (unsigned long )201;
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


				/*if (!iFlagLog) sema_post(&semaflock);*/  /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */
				if (SQLCODE){   
	   			if (!iFlagLog)
						ifnTrazaHilos( modulo, &pfLog, " en PREPARE : %s", LOG00, SQLERRM );
				   else
				      ifnTrazasLog( modulo," en PREPARE : %s", LOG00, SQLERRM );
			   	 
			    	return -1; /*Mail*/   
				}
				/*if (!iFlagLog) sema_wait(&semaflock);*/       /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */
				memset(szhRetorno,'\0',sizeof(szhRetorno));     /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */
				memset(szhRet,'\0',sizeof(szhRet));             /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */			
				
				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL EXECUTE S USING :szhRet, :lhCodCliente, :szhRetorno; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1605;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhRetorno;
    sqlstm.sqhstl[2] = (unsigned long )18;
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



				/*********** XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 *******************/
				strcpy(szGlosa,"<< Imprimiendo Valor de retorno inmediato >>\n");  
				sprintf(szGlosa,"%s1.- Resultado del criterio %s :[%s]\n",szGlosa,szCriterio, szhRet); 
				sprintf(szGlosa,"%s1.- Crit:[%s]  ValRet :[%s] \n", szGlosa,szCriterio, szhRetorno);  
				sprintf(szGlosa,"%s<< Fin a valor inmediato. >>\n",szGlosa);   
				/***********  FIN  ************************/
								
				/*if (!iFlagLog) sema_post(&semaflock);*/    /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */

   			    /***** XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 ********/
   			    if (!iFlagLog)       
					ifnTrazaHilos( modulo, &pfLog, "szGlosa\n%s", LOG07, szGlosa);     
			    else
			      ifnTrazasLog( modulo,"szGlosa\n%s", LOG07, szGlosa);      
   			    /****** FIN *******/
			
				if (SQLCODE){   
	   				if (!iFlagLog)
						ifnTrazaHilos( modulo, &pfLog, " en EXECUTE : %s", LOG00, SQLERRM );
				   	else
				      ifnTrazasLog( modulo," en EXECUTE : %s", LOG00, SQLERRM );
			    
			    return -1; /*Mail*/   
				}
			
			} else {
				strcpy(szhRet,"OK");
				sprintf( szhRetorno, "%.f", stMR.dSaldo_Vencido); /* sin decimales */
			}	
		   rtrim(szhRet);
		   rtrim(szhRetorno);
  			if (!iFlagLog)
				ifnTrazaHilos(modulo, &pfLog, "Resultado del criterio %s :[%s]",LOG05, szCriterio, szhRet);
		   else
		      ifnTrazasLog( modulo,"Resultado del criterio %s :[%s]",LOG05, szCriterio, szhRet);
		   
	      /* Fin Ejecucion del criterio */
		   if ( strcmp(szhRet,"OK") != 0 ){   
				return 0; /* No evalua mas. SE EXCLUYE EL CLIENTE */
		   }
		   else { /* El criterio se ejecuto con exito */ /*ifnEvaluaRespuestaCriterio*/
				pRutinaRango = pRutinaAux; /* guarda la posicion de la lista de rutinas donde estoy evaluando el criterio */
				iRetornoEvaluado=0; /* aun no lo evaluo */
	  			if (!iFlagLog)
					ifnTrazaHilos(modulo, &pfLog, "Crit:'%s'  TipRet:'%s'  ValRet :'%s' ", LOG05, szCriterio, pRutinaRango->szTipRetorno, szhRetorno );
			   else
			      ifnTrazasLog( modulo, "Crit:'%s'  TipRet:'%s'  ValRet :'%s' ", LOG05, szCriterio, pRutinaRango->szTipRetorno, szhRetorno );
				
				iSigCrit = 0;
				while ( ( pRutinaRango != NULL ) && (iSigCrit == 0) &&
				( !strcmp(pRutinaRango->szCodRutina,szCriterio) ) ) /* mientras sea el mismo criterio */
				{
					/* limpia las variables */
					memset(szStringRango,'\0',sizeof(szStringRango));
					memset(szStringRetorno,'\0',sizeof(szStringRetorno));
				
					strcpy( szStringRetorno, pRutinaRango->szValRetorno );
					strcpy( szStringRango, pRutinaRango->szValRango );
					
		  			if (!iFlagLog)
						ifnTrazaHilos( modulo, &pfLog, "\t\tRetorno:[%s]-Rango:[%s]", LOG06, szStringRetorno, szStringRango );
				   else
				      ifnTrazasLog( modulo, "\t\tRetorno:[%s]-Rango:[%s]", LOG06, szStringRetorno, szStringRango );
					
					
					if ( !strcmp(szStringRango,"NULO") ) /* Si no hay rango */
					{
						if ( !strcmp(pRutinaRango->szTipRetorno,"N") ) /* Si los valores esperados son de tipo numerico */
						{
							if (atof(szhRetorno) == atof(szStringRetorno))
							{ 
					  			if (!iFlagLog)
									ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] Ok Cumple con el valor esperado "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
							   else
							      ifnTrazasLog( modulo, "[%s],[%s],[%s],[%d] Ok Cumple con el valor esperado "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
								
								iRetornoEvaluado = 1;
							}
							else
							{
					  			if (!iFlagLog)
									ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] NO Cumple con el valor esperado "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
							   else
							      ifnTrazasLog( modulo, "[%s],[%s],[%s],[%d] NO Cumple con el valor esperado "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 0;
							}
						}
						else if ( !strcmp(pRutinaRango->szTipRetorno,"D") )
						{
							/*if (!iFlagLog) sema_wait(&semaflock);*/ /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */			
							sqlca.sqlcode=0; /* XO-200508280498 rvc */
							/* EXEC SQL 
							SELECT 1  INTO :ihOkFecha
							FROM   DUAL 
							WHERE  TO_DATE(:szhRetorno,'DDMMYY') = TO_DATE(:szStringRetorno,'DDMMYY'); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 16;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select 1 into :b0  from DUAL where TO_DATE(:b1,'DDMMYY\
')=TO_DATE(:b2,'DDMMYY')";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )1632;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihOkFecha;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhRetorno;
       sqlstm.sqhstl[1] = (unsigned long )18;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szStringRetorno;
       sqlstm.sqhstl[2] = (unsigned long )18;
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


							/*if (!iFlagLog) sema_post(&semaflock);*/ /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */			
							if (SQLCODE == SQLNOTFOUND) 
								ihOkFecha = 0; /* No se cumplio la condicion, la fecha es incorrecta */
							else if (SQLCODE)                    
								ihOkFecha = 0; /* Hubo un error, asumo que la fecha es incorrecta */
						
							if ( ihOkFecha == 1 ) /* Si retorno el valor esperado */
							{ 
					  			if (!iFlagLog)
									ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] OK es la fecha esperada "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
							   else
							      ifnTrazasLog( modulo, "[%s],[%s],[%s],[%d] OK es la fecha esperada "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 1;
							}
							else
							{
					  			if (!iFlagLog)
									ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] NO es la fecha esperada "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
							   else
							      ifnTrazasLog( modulo, "[%s],[%s],[%s],[%d] NO es la fecha esperada "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
							
								
								iRetornoEvaluado = 0;
							}
						}
						else /* SON STRING(CARACTERES) */
						{   
							if ( strcmp(szhRetorno,szStringRetorno)==0 ) /* Si retorno el valor esperado */
							{ 
								iRetornoEvaluado = 1;
							}
							else
							{
								iRetornoEvaluado = 0;
							}
						}
					}
					else /*Si hay rango, comparar between */
					{
						if ( !strcmp(pRutinaRango->szTipRetorno,"N") ) /* Si los valores esperados son de tipo numerico */
						{
							if ( ( atof(szhRetorno) >= atof(szStringRetorno) )
							&& ( atof(szhRetorno) <= atof(szStringRango) ) ) /* Si retorno un valor between el rango */
							{ 
					  			if (!iFlagLog)
									ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] OK esta dentro del rango.",
									LOG05, szStringRetorno, szStringRango, pRutinaRango->szIndExcluye, pRutinaRango->iDiasProrroga );
							   else
							      ifnTrazasLog( modulo, "[%s],[%s],[%s],[%d] OK esta dentro del rango.",
									LOG05, szStringRetorno, szStringRango, pRutinaRango->szIndExcluye, pRutinaRango->iDiasProrroga );
								iRetornoEvaluado = 1;
							}
							else
							{
					  			if (!iFlagLog)
									ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] NO esta dentro del rango "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
							   else
							      ifnTrazasLog( modulo, "[%s],[%s],[%s],[%d] NO esta dentro del rango "
									,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);
								iRetornoEvaluado = 0;
							}
						}
						else if ( !strcmp(pRutinaRango->szTipRetorno,"D") ) /* si los valores esperados son de tipo date */
						{
							/*if (!iFlagLog) sema_wait(&semaflock);*/ /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */			
							sqlca.sqlcode=0; /* XO-200508280498 rvc */
							/* EXEC SQL 
							SELECT 1 INTO :ihOkFecha
							FROM   DUAL 
							WHERE  TO_DATE(:szhRetorno,'DDMMYY') BETWEEN TO_DATE(:szStringRetorno,'DDMMYY')
							AND    TO_DATE(:szStringRango,'DDMMYY'); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 16;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select 1 into :b0  from DUAL where TO_DATE(:b1,'DDMMYY\
') between TO_DATE(:b2,'DDMMYY') and TO_DATE(:b3,'DDMMYY')";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )1659;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihOkFecha;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhRetorno;
       sqlstm.sqhstl[1] = (unsigned long )18;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szStringRetorno;
       sqlstm.sqhstl[2] = (unsigned long )18;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)szStringRango;
       sqlstm.sqhstl[3] = (unsigned long )11;
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


							/*if (!iFlagLog) sema_post(&semaflock);*/ /*XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia XM-200412200216 */			
							
							if (SQLCODE == SQLNOTFOUND) 
								ihOkFecha = 0; /* No se cumplio la condicion, la fecha esta en el rango */
							else if (SQLCODE)                    
								ihOkFecha = 0; /* Hubo un error, asumo que la fecha no esta en el rango */
							
							if ( ihOkFecha == 1 ) /* Si retorno el valor esperado */
							{ 
								iRetornoEvaluado = 1;
							}
							else
							{
								iRetornoEvaluado = 0;
							}
						}
						else /* si los valores esperados son de tipo STRING (CARACTERES) */
						{
				  			if (!iFlagLog)
								ifnTrazaHilos(modulo, &pfLog, "ERROR : para 'String' no puede estar definido un rango de valores",LOG05);
						   else
						      ifnTrazasLog( modulo, "ERROR : para 'String' no puede estar definido un rango de valores",LOG05);
							
							iRetornoEvaluado = 0;
						} 
					}
					
					if (iRetornoEvaluado == 1) /* valor de retorno coincide con lo que se esperaba */
					{
						if (!strcmp(pRutinaRango->szIndExcluye,"S")) /* Si debe excluirse */
						{
						    iCumpleCriterio++;  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
				  			if (!iFlagLog)
				  			{
								ifnTrazaHilos(modulo, &pfLog, "SE EXCLUYE EL CLIENTE",LOG05);
								ifnTrazaHilos(modulo, &pfLog, "iCumpleCriterio [%d]\n",LOG05, iCumpleCriterio); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
							}
						    else
							{
						        ifnTrazasLog( modulo, "SE EXCLUYE EL CLIENTE",LOG05);
								ifnTrazasLog( modulo, "iCumpleCriterio [%d]\n",LOG05, iCumpleCriterio); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
						    }
							
							return 0; /* No evalua mas. SE EXCLUYE EL CLIENTE */
						}
						else 
						{
				  			if (!iFlagLog)
								ifnTrazaHilos(modulo, &pfLog, "SE PRORROGA LA ACCION",LOG05);
						   else
						      ifnTrazasLog( modulo, "SE PRORROGA LA ACCION",LOG05);
							
							if (pRutinaRango->iDiasProrroga > ihMaxProrroga) /* No se excluye, verifica dias de prorroga */
							{
								ihMaxProrroga = pRutinaRango->iDiasProrroga; /* Guarda la Maxima Prorroga */ 
								iSigCrit = 1;  /* sale de este ciclo , pero continua evaluando el siguiente criterio */
							}
							else
							{
								iSigCrit = 1;  /* sale de este ciclo , pero continua evaluando el siguiente criterio */
							}
						}
					}
					else /* valor de retorno no coincide con lo que se esperaba */
					{
			  			if (!iFlagLog)
							ifnTrazaHilos(modulo, &pfLog, "Verificar el sgte valor esperado... ",LOG05);
					   else
					      ifnTrazasLog( modulo, "Verificar el sgte valor esperado... ",LOG05);
						
					}
					pRutinaRango= pRutinaRango->sig; /* verifica el valor de la siguiente rutina */
				
				}/*end while pRutinaRango*/
				
	  			if (!iFlagLog)
					ifnTrazaHilos(modulo, &pfLog, "No hay mas valores que verificar ",LOG05);
			   else
			      ifnTrazasLog( modulo, "No hay mas valores que verificar ",LOG05);
				
				if (iRetornoEvaluado == 0) 
				{
		  			if (!iFlagLog)
						ifnTrazaHilos(modulo, &pfLog, "No se cumplio este criterio ",LOG05);
				   else
				      ifnTrazasLog( modulo, "No se cumplio este criterio ",LOG05);
					
					/* Prorroga == 0 y ejecuta accion */            
				}    
		   }
		} /*if (strcmp(szCriterio, szCriterioAnterior) != 0)*/	

		/* Evalua el Siguiente Criterio */
		if (!iFlagLog)
			ifnTrazaHilos(modulo, &pfLog, "Evalua el sgte criterio ",LOG05);
		else
		   ifnTrazasLog( modulo, "Evalua el sgte criterio ",LOG05);
		
		pRutinaAux = pRutinaAux->sig;
    } /*fin while Verificacion de Criterios*/

		if (!iFlagLog)
		{
			ifnTrazaHilos(modulo, &pfLog, "[Log Hilos]No hay mas Criterios.",LOG05);
			ifnTrazaHilos(modulo, &pfLog, "iCumpleCriterio [%d]\n",LOG05, iCumpleCriterio); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
		}
		else
		{
		    ifnTrazasLog( modulo, "[Log Normal] No hay mas Criterios.",LOG05);
			ifnTrazasLog( modulo, "iCumpleCriterio [%d]\n",LOG05, iCumpleCriterio); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
        }
    
    *iMaxDiasPro = ihMaxProrroga; 
    /*return 1;*/
    /*return -99;  * XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
    
     /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
     if (iCumpleCriterio == 0)
         return -99;
     else
         return 1;
     /* FIN XO-200508090319*/    
     
} /* FIN ifnEjecutaCriteriosEv() */


/*==================================================================================================*/
/* Funcion que actualiza una lista de acciones por cliente														 */
/*==================================================================================================*/
int ifnGeneraMorosos( FILE **ptArchLog,  lista_Pto lsPtoG, stLista *lstCli)
{
char modulo[]="ifnGeneraMorosos";
double dpaso1 = 0, dpaso2 = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente     = 0;
	long   lhCodCuenta      = 0;
	double dhSaldoVencido   = 0;
	double dhSaldoNoVencido = 0;
	char   szhNumIdent[iLENNUMIDENT]="";/* EXEC SQL VAR szhNumIdent IS STRING (iLENNUMIDENT); */ 
 
	char   szhFecVencimiento[9]=""; 		/* EXEC SQL VAR szhFecVencimiento IS STRING (9); */ 

	char   szhCodTipIdent   [3]=""; 		/* EXEC SQL VAR szhCodTipIdent IS STRING (3); */ 

	char   szhCodCategoria  [6]=""; 		/* EXEC SQL VAR szhCodCategoria IS STRING (6); */ 

	char   szhCodComuna     [6]=""; 		/* EXEC SQL VAR szhCodComuna IS STRING (6); */ 

	char   szhCodGestion    [3]="" ; 	/* EXEC SQL VAR szhCodGestion IS STRING(3); */ 

	char   szhDirCorrespondencia[2]="" ;/* EXEC SQL VAR szhDirCorrespondencia IS STRING(2); */ 

	int    ihCntAboCelu = 0;
	int    ihCntAboBeep = 0;
	int    ihCntSumAbo  = 0;
	
	char	 szhgPtoGestionActual[6] = "";	
	long	 lhgSecMoroso;
/* EXEC SQL END DECLARE SECTION; */ 

lista_Pto lsPtoGAux=lsPtoG ;
stLista stCl_Aux;
FILE *pfLog;	
	pfLog = *ptArchLog;

	stCl_Aux = *lstCli;
	ifnTrazaHilos( modulo, &pfLog, "Ingreso modulo [%s]", LOG05, modulo );
	mutex_lock(&bufferlock);
	memset( szhCodGestion		 , '\0', sizeof( szhCodGestion ) );
	memset( szhFecVencimiento    , '\0', sizeof( szhFecVencimiento     ) );
	memset( szhNumIdent          , '\0', sizeof( szhNumIdent           ) );
	memset( szhCodTipIdent       , '\0', sizeof( szhCodTipIdent        ) );
	memset( szhCodCategoria      , '\0', sizeof( szhCodCategoria       ) );
	memset( szhCodComuna         , '\0', sizeof( szhCodComuna          ) );
	memset( szhDirCorrespondencia, '\0', sizeof( szhDirCorrespondencia ) );
	memset( szhCodGestion        , '\0', sizeof( szhCodGestion         ) );
	mutex_unlock(&bufferlock);
	strcpy(szhgPtoGestionActual,lsPtoGAux->szCodPtoGest);
	sprintf( szhDirCorrespondencia, "3\0" );
	lhCodCliente = stCl_Aux->Campo.lCod_Cliente;
	/*-Obtiene la Cuenta del Cliente-*/            
   sema_wait(&semaflock);
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COD_CUENTA,
			 NUM_IDENT,
			 COD_TIPIDENT 
	INTO  :lhCodCuenta,
			:szhNumIdent,
			:szhCodTipIdent
	FROM  GE_CLIENTES
	WHERE COD_CLIENTE = :lhCodCliente ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CUENTA ,NUM_IDENT ,COD_TIPIDENT into :b0,:b1,:b2 \
 from GE_CLIENTES where COD_CLIENTE=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1690;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCuenta;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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


   sema_post(&semaflock);
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
        ifnTrazaHilos(modulo, &pfLog, "(Cli:%ld) SELECT COD_CUENTA GE_CLIENTES : %s",LOG00,lhCodCliente,SQLERRM);  
        return -1;    
	}

	/*-Obtiene la Comuna del Cliente-*/            
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COD_COMUNA
	INTO  :szhCodComuna
	FROM  GE_DIRECCIONES  G1,
	      GA_DIRECCLI     G0
	WHERE G0.COD_CLIENTE      = :lhCodCliente
	AND   G0.COD_TIPDIRECCION = :szhDirCorrespondencia
	AND   G1.COD_DIRECCION = G0.COD_DIRECCION; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_COMUNA into :b0  from GE_DIRECCIONES G1 ,GA_DIREC\
CLI G0 where ((G0.COD_CLIENTE=:b1 and G0.COD_TIPDIRECCION=:b2) and G1.COD_DIRE\
CCION=G0.COD_DIRECCION)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1721;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodComuna;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhDirCorrespondencia;
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


	sema_post(&semaflock);
	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)  {
		ifnTrazaHilos(modulo, &pfLog, "(Cli:%ld) SELECT COD_COMUNA GE_DIRECCIONES : %s",LOG00,lhCodCliente,SQLERRM);  
		return -1;    
	}
	if (SQLCODE == SQLNOTFOUND)  {
		sprintf(szhCodComuna,"13112\0"); /* si no tiene direccion se le asigna Santiago jlr_26.03.01 */
	}
	
	ifnTrazaHilos( modulo, &pfLog, "Obtiene el Saldo del Cliente", LOG03);  
	/*-Obtiene el Saldo del Cliente-  */
	if ( !bfnGetSaldoClienteEv(&pfLog, lhCodCliente, &dhSaldoNoVencido) ) 
	    return -1;    
	
	/* transformamos decimales segun definicion para la operadora tratada */
	ifnTrazaHilos( modulo, &pfLog, "Valores antes de transformer   dhSaldoNoVencido = [%.4f].", LOG05, dhSaldoNoVencido );  
	dhSaldoNoVencido = fnCnvDouble( dhSaldoNoVencido, 0 );
	ifnTrazaHilos( modulo, &pfLog, "Valores despues de transformer dhSaldoNoVencido = [%.4f].", LOG05, dhSaldoNoVencido );  
	
	strcpy(szhCodGestion, "XX");
	
	/* debemos actualizar el codigo de gestion del cliente */
	if( !bfnFindNewCodGestionEv( &pfLog, lhCodCliente, 0, szhCodGestion ) )	{
	    return -1;
	}

	/* Actualizamos datos de la lista Gral.   */
	/******************************************/
	
	stCl_Aux->Campo.iCnt_Abocelu  = 0;   
	stCl_Aux->Campo.iCnt_Abobeep  = 0;   
	stCl_Aux->Campo.lCod_Cuenta	 = lhCodCuenta;
	stCl_Aux->Campo.dSaldo_NoVencido  = dhSaldoNoVencido;
	strcpy(stCl_Aux->Campo.szNum_Ident   ,szhNumIdent);
	strcpy(stCl_Aux->Campo.szCod_Tipident,szhCodTipIdent);
	strcpy(stCl_Aux->Campo.szCod_Comuna  ,szhCodComuna);
	strcpy(stCl_Aux->Campo.szCod_Gestion ,szhCodGestion);
	strcpy(stCl_Aux->Campo.szCod_Ptogest ,szhgPtoGestionActual);

	ifnTrazaHilos(modulo, &pfLog, "\t** Actualizacion de la Lista de Acciones por Clientes **",LOG03);  
	ifnTrazaHilos(modulo, &pfLog, "\tlCod_Cliente       [%ld]",LOG03,stCl_Aux->Campo.lCod_Cliente);  
	ifnTrazaHilos(modulo, &pfLog, "\tdhSaldoNoVencido   [%0f]",LOG05,stCl_Aux->Campo.dSaldo_NoVencido);  
	ifnTrazaHilos(modulo, &pfLog, "\tszhNumIdent        [%s]",LOG05,stCl_Aux->Campo.szNum_Ident);  
	ifnTrazaHilos(modulo, &pfLog, "\tszhCodTipIdent     [%s]",LOG05,stCl_Aux->Campo.szCod_Tipident);  
	ifnTrazaHilos(modulo, &pfLog, "\tszhCodComuna       [%s]",LOG05,stCl_Aux->Campo.szCod_Comuna);  
	ifnTrazaHilos(modulo, &pfLog, "\tszhCodGestion      [%s]",LOG03,stCl_Aux->Campo.szCod_Gestion);  
	ifnTrazaHilos(modulo, &pfLog, "\tszCod_Ptogest      [%s]",LOG03,stCl_Aux->Campo.szCod_Ptogest);  

	return 0;
} /* fin ifnGeneraMorosos */

/*==================================================================================================*/
/* Funcion que Actualiza campos, para simular el ingreso del cliente a morosos, cuando ya existe.   */
/*==================================================================================================*/
int ifnActualizaMorosos( FILE **ptArchLog, stLista *lstCli )
{
char modulo[] = "ifnActualizaMorosos";
int iError = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int    lhCodCliente;
	double dhSaldoNoVencido = 0;
/* EXEC SQL END DECLARE SECTION; */ 
       
stLista stCl_Aux;
FILE *pfLog;	
pfLog = *ptArchLog;

	stCl_Aux = *lstCli;
	ifnTrazaHilos( modulo, &pfLog, "Ingreso modulo [%s]", LOG03, modulo );
	lhCodCliente = stCl_Aux->Campo.lCod_Cliente;

	/* Obtiene el Saldo del Cliente */
	if( !bfnGetSaldoClienteEv( &pfLog, lhCodCliente, &dhSaldoNoVencido) ) 	{
		ifnTrazaHilos( modulo, &pfLog, "Error al obtener saldo del Cliente.", LOG01 );
		return -1;
	}

	/* Actualizamos datos de la lista Gral.   */
	/******************************************/
	stCl_Aux->Campo.dSaldo_NoVencido  = dhSaldoNoVencido;
	
	ifnTrazaHilos(modulo, &pfLog, "\tdhSaldoNoVencido   [%0f]",LOG03,stCl_Aux->Campo.dSaldo_NoVencido);  

	return 0;
} /* fin ifnActualizaMorosos */

/*==================================================================================================*/
/* Funcion que carga las acciones correspondientes a una lista enlazada por cliente                 */
/*==================================================================================================*/
int ifnAccionACliente(FILE **ptArchLog , lista_Acc list, stLista *lstCli , char *szpFecAccion , char *szpFecHoy, lista_Pto lsPtoG)
{
char modulo[] = "ifnAccionACliente";
int	i, k, iInsertarAccion, rr, iFechaOk, ierror, x;
long	ilong = 0, lMaxAccionesDiario = 0;            
char	szAccionAnterior[6] = "", szAccionComp[6] = "", szCodGestion[6];
struct ACCIONES   stNodoAccion;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long 	lhNumSeq  ;
	long 	lhCodCli  ;
	int 	ihNumProceso ;
	char 	szhFecAccion  [9];     /* Fecha Definitiva de Ejecucion de la Accion */
	char 	szhFecHoy     [9];     /* Fecha Tentativa de Ejecucion de la Accion */
	char 	szhFecProrroga[9];     /* Fecha de Prorroga del Cliente */
	char 	szhAccion     [6];
	char 	szhIndProrroga[2];
	char 	szhIndDuplicable[2];
	int 	ihNumDias;
	char  szhgUsuarioOracle   [31];
	char	szhgPtoGestionActual[6];	
	char	szhgCodParam[16];
/* EXEC SQL END DECLARE SECTION; */ 

lista_Acc lstAccionAux = list;
lista_Pto lsPtoGAux=lsPtoG ;
lstAccCM  lstAccCM_aux;
lstAccCM lstsgte;
stLista   lstCli_aux=*lstCli;
lstAccCM  lstAcc_aux=NULL ;
 
FILE *pfLog;	
pfLog = *ptArchLog;

	ifnTrazaHilos( modulo, &pfLog, "\n\t\tFuncion %s\n", LOG03,modulo);

	lhCodCli = lstCli_aux->Campo.lCod_Cliente;
	ihNumProceso = lsPtoGAux->iNumProceso;
	strcpy(szhFecAccion,szpFecAccion);
	strcpy(szhFecHoy   ,szpFecHoy);
	sprintf(szhFecProrroga,"%8s\0",lstCli_aux->Campo.szFec_Prorroga);
	strcpy(szhgPtoGestionActual,lsPtoGAux->szCodPtoGest);
	
	ifnTrazaHilos( modulo, &pfLog, "\t\t ihNumProceso        [%d]", LOG07,ihNumProceso);
	ifnTrazaHilos( modulo, &pfLog, "\t\t szhFecAccion        [%s]", LOG07,szhFecAccion);
	ifnTrazaHilos( modulo, &pfLog, "\t\t szpFecHoy           [%s]", LOG07,szpFecHoy);
	ifnTrazaHilos( modulo, &pfLog, "\t\t szhFecProrroga      [%s]", LOG07,szhFecProrroga);
	ifnTrazaHilos( modulo, &pfLog, "\t\t szhgPtoGestionActual[%s]\n", LOG07,szhgPtoGestionActual);

	while (lstAccionAux != NULL) 	{ /* Recorre lista de acciones del Pto. de gestion*/
		/*Limpia estructura  */
		memset(stNodoAccion.szCod_Accion ,'\0', sizeof(stNodoAccion.szCod_Accion) );
		memset(stNodoAccion.szFec_Accion ,'\0', sizeof(stNodoAccion.szFec_Accion) );
		memset(stNodoAccion.szIndDuplicable ,'\0', sizeof(stNodoAccion.szIndDuplicable) );
		stNodoAccion.iFlagWrite = 0;
		stNodoAccion.iFlagRutinas = 0;
		memset(stNodoAccion.szCodParam ,'\0', sizeof(stNodoAccion.szCodParam) );
		stNodoAccion.iNumProceso = 0;
			
		/* Carga de estructura con datos de acción*/
		strcpy( szhAccion, lstAccionAux->szCodRutina);
		strcpy( szhIndProrroga, lstAccionAux->szIndProrroga);
		strcpy( szhIndDuplicable, lstAccionAux->szIndDuplicable);
		lMaxAccionesDiario = lstAccionAux->lMaxDiario;
			
		ifnTrazaHilos( modulo, &pfLog, "\t\t szhAccion          [%s]", LOG07,szhAccion);
		ifnTrazaHilos( modulo, &pfLog, "\t\t szAccionAnterior   [%s]", LOG07,szAccionAnterior);
		ifnTrazaHilos( modulo, &pfLog, "\t\t szhIndProrroga     [%s]", LOG07,szhIndProrroga);
		ifnTrazaHilos( modulo, &pfLog, "\t\t szhIndDuplicable   [%s]", LOG07,szhIndDuplicable);
		ifnTrazaHilos( modulo, &pfLog, "\t\t lMaxAccionesDiario [%ld]\n", LOG07,lMaxAccionesDiario);

		/* Si es la misma anterior */
		if( strcmp( szhAccion, szAccionAnterior ) == 0 ) {
			ifnTrazaHilos( modulo, &pfLog, "szhAccion y szAccionAnterior son iguales", LOG06);
			lstAccionAux = lstAccionAux->sig;
			continue; /* Lo Saltamos, porque la vuelta anterior ya lo evaluamos */
		}
		
		/* Seteamos el Criterio anterior para la siguiente vuelta */
		strcpy( szAccionAnterior,szhAccion );
		
		/* compara szhFecAccion con szhFecProrroga para ver cual es mayor */
		if( atol( szhFecAccion ) < atol( szhFecProrroga ) )  {
			strcpy( szhFecAccion, szhFecProrroga ); /* deja la prorroga como definitiva */
		}

		stNodoAccion.iFlagRutinas=-1;
		iFechaOk = 0;
		/* mientras no se encuentre una fecha valida */
		while( !iFechaOk )	{ 
			
			ifnTrazaHilos( modulo, &pfLog, "\tACCION***** Busca Fecha Valida para Insertar en Co_Rutinas.", LOG04);
			ifnTrazaHilos( modulo, &pfLog, "Se busca fecha para insertar accion [%s] ", LOG06, szhAccion );
			iFechaOk = 1;	/* siempre se debe salir, a no ser que se deba buscar otra fecha valida */
			
			/* buscar una fecha valida para la ejecucion de la accion */
		   ifnTrazaHilos( modulo, &pfLog, "fecha que entra a ifnDetFechaEjecucionEv => [%s].", LOG06, szhFecAccion );
		   ifnTrazaHilos( modulo, &pfLog, "accion que entra a ifnDetFechaEjecucionEv => [%s].", LOG06, szhAccion );
			/* fmto: YYYYMMDD */
			if( ifnDetFechaEjecucionEv( &pfLog, szhAccion, szhFecAccion ) != 0 )  {
	            	   ifnTrazaHilos( modulo, &pfLog, "al obtener fecha definitiva para la accion (%ld) %s : %s",LOG01, lhCodCli, szhAccion, SQLERRM );
	            	   return -1; /* Pasar al siguiente Cliente de este mismo punto de Gestion, deshacer cambios */
			}
		
			/* si la accion tiene restriccion por limite maximo de ejecuciones por dia */
			if( lMaxAccionesDiario > 0 )  { 
									
				/* buscar una fecha valida (segun maximo de acciones por dia/fecha valida de ejecucion ) */
				ifnTrazaHilos( modulo, &pfLog, "fecha ingreso accion => [%s].", LOG06, szhFecAccion );
				ifnTrazaHilos( modulo, &pfLog, "lMaxAccionesDiario=> [%ld].", LOG06, lMaxAccionesDiario );
				/* fmto: YYYYMMDD */
				/* inserta en co_rutinas */
				if( ( iFechaOk = ifnValidaMaxAccionesDiaEv( &pfLog, szhAccion, szhFecAccion, lMaxAccionesDiario, &stNodoAccion ) ) < 0 )  {
					ifnTrazaHilos( modulo, &pfLog, "Al revisar maximo de acciones para la accion => [%s]. iFechaOk : [%d]", LOG06, szhAccion, iFechaOk );
					ifnTrazaHilos( modulo, &pfLog, "Al revisar maximo de acciones para la accion => [%s].", LOG01, szhAccion );
					return -1; /* Pasar al siguiente Cliente de este mismo punto de Gestion, deshacer cambios */
				}
			}
		} /* while( bFechaOk ) */

      ifnTrazaHilos( modulo, &pfLog, "Fec.Definitiva Accion : (%s)", LOG05, szhFecAccion );
		strcpy(stNodoAccion.szCod_Accion,szhAccion);
		strcpy(stNodoAccion.szFec_Accion,szhFecAccion);
		strcpy(lstCli_aux->Campo.szCod_Ptogest,szhgPtoGestionActual);	
		stNodoAccion.iNumProceso=ihNumProceso;
		rtrim(szhIndDuplicable);
		strcpy(stNodoAccion.szIndDuplicable,szhIndDuplicable);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** En este momento cargamos los datos de una Accion del cliente.", LOG04);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAccion.szCod_Accion  [%s]", LOG04,stNodoAccion.szCod_Accion);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAccion.szFec_Accion  [%s]", LOG04,stNodoAccion.szFec_Accion);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAccion.iNumProceso   [%d]", LOG04,stNodoAccion.iNumProceso);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAccion.iFlagRutinas  [%d]", LOG04,stNodoAccion.iFlagRutinas);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAccion.szIndDuplicable [%s]", LOG04,stNodoAccion.szIndDuplicable);
		ifnTrazaHilos( modulo, &pfLog, "\t*********** szhIndProrroga    [%s]", LOG07,szhIndProrroga);
		ifnTrazaHilos( modulo, &pfLog, "\t*********** szhFecAccion      [%s]", LOG07,szhFecAccion);
		ifnTrazaHilos( modulo, &pfLog, "\t*********** szhFecHoy         [%s]", LOG07,szhFecHoy);
  		/* si la accion NO es prorrogable, compara szhFecAccion con szhFecHoy para ver que sean iguales */
		if( !strcmp( szhIndProrroga, "N" ) && strcmp( szhFecAccion, szhFecHoy ) )  {
          ifnTrazaHilos(modulo, &pfLog, "La accion no es prorrogable por lo que no se generara",LOG05);
          lstAccionAux = lstAccionAux->sig;
          continue; /* si son distintas, No se genera la accion y se ve la siguiente rutina */
		}

		/* right trim del szhAccion (para evitar problemas de comparacion ) */
		memset( szAccionComp, 0, sizeof( szAccionComp ) );
		ilong = strlen( szhAccion ) - 1;
		for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhAccion[rr] != ' ' ) break ;
		strcpy( szAccionComp, szhAccion );
		szAccionComp[rr + 1] = '\0';

		memset( szhgCodParam, 0, sizeof( szhgCodParam ) );
		strcpy( szhgCodParam, lstAccionAux->szCodParam);
		rtrim(szhgCodParam);

		/* insertamos en la tabla de parametros CO_PARAM_ACCIONES, solo si la accion necesita de parametros*/
		ifnTrazaHilos( modulo, &pfLog, "Accion Guardada en Lista => [%s]", LOG03, szAccionComp);

		strcpy(stNodoAccion.szCodParam,szhgCodParam);
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAccion.szCodParam [%s]", LOG06,stNodoAccion.szCodParam);
  		/* Se inserta accion en la lista*/
  		if ((lstAccCM_aux=(struct ACCIONES *) malloc(sizeof(struct ACCIONES))) == NULL) {
			ifnTrazaHilos( modulo, &pfLog, "Error Falta memoria para insertar acción en lista", LOG01);
  			return -1;
  		}		
		strcpy(lstAccCM_aux->szCod_Accion, stNodoAccion.szCod_Accion);
		strcpy(lstAccCM_aux->szFec_Accion, stNodoAccion.szFec_Accion);
		strcpy(lstAccCM_aux->szIndDuplicable, stNodoAccion.szIndDuplicable);
		lstAccCM_aux->iFlagWrite = stNodoAccion.iFlagWrite;
		lstAccCM_aux->iFlagRutinas = stNodoAccion.iFlagRutinas;
		strcpy(lstAccCM_aux->szCodParam, stNodoAccion.szCodParam);
		lstAccCM_aux->iNumProceso = stNodoAccion.iNumProceso;  
		lstAccCM_aux->sgte=NULL;		

  		
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** Se insertara una accion.", LOG04);
		if(lstCli_aux->Accion_sgte == NULL){

			ierror=ifnIniListAccion(lstCli_aux, lstAccCM_aux);
			if (ierror != 0) {
				ifnTrazaHilos( modulo, &pfLog, "Error al inicializar lista", LOG01);
				return -1;
			}

			ifnTrazaHilos( modulo, &pfLog, "\tACCION***** Inicializamos Lista de accion.", LOG06);
		} else {
			/*printf("\n ******Antes de Insertar [%ld]", lstCli_aux->Campo.lCod_Cliente );				*/
			ierror=ifnInsertaNodoAcc(lstCli_aux, lstAccCM_aux);
			if (ierror != 0) {
				ifnTrazaHilos( modulo, &pfLog, "Error al insertar en lista", LOG01);			
				return -1;
			}
			if(stListaClientes->sgte == NULL)
			ifnTrazaHilos( modulo, &pfLog, "\tACCION***** Insertamos nodo en Lista de accion.", LOG06);
		}

		lstAccionAux = lstAccionAux->sig;

	} /* fin while */
	
	ifnTrazaHilos( modulo, &pfLog, "Se Termino de Evaluar el Cliente [%ld].\n", LOG03,lhCodCli );
	ifnTrazaHilos( modulo, &pfLog, "========================================================================================\n\n", LOG03,lhCodCli );
	 
	return 0; 

} /* fin ifnAccionACliente */

/* ============================================================================= */
/* Funcion que Busca el primer Pto. de Gestion segun la categoria del cliente  	*/
/* ============================================================================= */
int ifnBuscaPtoCategClte(lista_Categ pCategorias, lista_Pto *pPtogest, lista_SecPtos *pSecPtos,char *szCateg)
{
lista_Categ pCategoriasAux=pCategorias;
int iExiste = 0;

	while(pCategoriasAux != NULL && !iExiste){
	    if(strcmp(pCategoriasAux->szCodCategoria,szCateg)==0){
	    	 (*pPtogest) = pCategoriasAux->pto_sig;
	    	 (*pSecPtos) = pCategoriasAux->sec_sig;
	    	 iExiste = 1;
	    }
	    pCategoriasAux = pCategoriasAux->sig;
	}
	return iExiste;
}/* fin ifnBuscaPtoCategClte */

/*==================================================================================================*/
/* Funcion que Obtiene el saldo en la CO_MOROSOS dado el Cliente                                    */
/* Esta habilitada para los procesos que trabajan con hilos   													 */
/*==================================================================================================*/
BOOL bfnGetSaldoClienteEv( FILE **ptArchLog, long lCliente, double *pdSaldoNoVenc)
{
char modulo[]="bfnGetSaldoClienteEv";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente = lCliente;
	int    ihIndFacturado = 1; 
	double dhSaldoNoVenc  = 0;
	char   szhCARTERA  [11];
	char   szhTIPDOCUM [13];
	int    ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 
    
FILE *pfLog;	
pfLog = *ptArchLog;

	ifnTrazaHilos( modulo, &pfLog, "Ingresando modulo %s.", LOG03, modulo );
	ifnTrazaHilos( modulo, &pfLog, "iFec_Saldo [%d].", LOG03, iFec_Saldo);
	strcpy(szhCARTERA ,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");

	if (iFec_Saldo == 0 )  {	

		sema_wait(&semaflock);
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL
		SELECT SALDO_NOVENCIDO
		INTO   :dhSaldoNoVenc
		FROM   CO_SALDOCONS_TO
		WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select SALDO_NOVENCIDO into :b0  from CO_SALDOCONS_TO where\
 COD_CLIENTE=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1748;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhSaldoNoVenc;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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


		sema_post(&semaflock);
	
	} else {
				
		sema_wait(&semaflock);
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),:ihValor_cero)
		INTO  :dhSaldoNoVenc
		FROM  CO_CARTERA
		WHERE COD_CLIENTE   = :lhCodCliente 
		AND   IND_FACTURADO = :ihIndFacturado
		AND   FEC_VENCIMIE >= TRUNC(SYSDATE)
		AND   COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
											FROM	 CO_CODIGOS
											WHERE	 NOM_TABLA  = :szhCARTERA
											AND	 NOM_COLUMNA= :szhTIPDOCUM); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),:b0) into :b1 \
 from CO_CARTERA where (((COD_CLIENTE=:b2 and IND_FACTURADO=:b3) and FEC_VENCI\
MIE>=TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  fr\
om CO_CODIGOS where (NOM_TABLA=:b4 and NOM_COLUMNA=:b5)))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1771;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoNoVenc;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
  sqlstm.sqhstv[3] = (unsigned char  *)&ihIndFacturado;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCARTERA;
  sqlstm.sqhstl[4] = (unsigned long )11;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhTIPDOCUM;
  sqlstm.sqhstl[5] = (unsigned long )13;
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


		sema_post(&semaflock);
	}	

	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
		ifnTrazaHilos(modulo, &pfLog, "SELECT FROM CO_CARTERA(2) (Cliente:%ld) : %s ",LOG00,lhCodCliente,SQLERRM);  
      return FALSE;
	
	} else   {
		*pdSaldoNoVenc = dhSaldoNoVenc;
      return TRUE; 
   }

} /* fin bfnGetSaldoClienteEv */

/*==================================================================================================*/
/* Funcion que Tiene por finalidad determinar que COD_GESTION, le corresponde al cliente examinado. */
/* Esta habilitada para los procesos que trabajan con hilos   													 */
/*==================================================================================================*/
BOOL bfnFindNewCodGestionEv( FILE **ptArchLog,long lCodCliente, int iIndExcluye, char *szCod_Gestion )
{
char modulo[] = "bfnFindNewCodGestionEv";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	char	szhCodGestion[3] = "";		/* EXEC SQL VAR szhCodGestion IS STRING(3); */ 

	char	szhCodRutina[6] = "";		/* EXEC SQL VAR szhCodRutina IS STRING(6); */ 

	int	ihCntAboCelu = 0;
	int	ihCntAboBeep = 0;
	int	ihCntSumAbo = 0;
	char  szhBAA       [4];
   char  szhLetra_A   [2];
	char  szhEJE       [4];
	char  szhRER       [4];
	char  szhNum90     [3];
	char  szhNum43     [3];
	char  szhNum44     [3];
	int   ihValor_cero = 0;
	int   ihValor_tres = 3;
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog;	
	pfLog = *ptArchLog;
     
	ifnTrazaHilos( modulo, &pfLog, "Ingresando modulo %s.", LOG05, modulo );
    
   memset( szhCodGestion, '\0', sizeof( szhCodGestion ) );
   strcpy( szhCodGestion, "NN" );
   strcpy(szhBAA,"BAA");
   strcpy(szhLetra_A,"A");
   strcpy(szhEJE,"EJE");
   strcpy(szhRER,"RER"); 
   strcpy(szhNum90,"90");
   strcpy(szhNum43,"43");
   strcpy(szhNum44,"44");
    
	lhCodCliente = lCodCliente;
	ifnTrazaHilos( modulo, &pfLog, "Parametros entrada modulo %s.\tlCliente     = [%ld].",LOG05, modulo, lhCodCliente );

	/*-Obtiene la Cantidad de Abonados Celulares del Cliente-*/            
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	 :ihCntAboCelu
	FROM	 GA_ABOCEL
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_SITUACION != :szhBAA
	AND 	 COD_USO != :ihValor_tres; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL where ((COD_CLIENT\
E=:b1 and COD_SITUACION<>:b2) and COD_USO<>:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1810;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAboCelu;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_tres;
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


	sema_post(&semaflock);
	if( SQLCODE )	{
		ifnTrazaHilos(modulo, &pfLog, "(Cli:%ld) GA_ABOCEL : %s",LOG00,lhCodCliente,SQLERRM);  
      return FALSE;
	}
	
	/*-Obtiene la Cantidad de Abonados Beeper del Cliente-*/            
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	 :ihCntAboBeep
	FROM	 GA_ABOBEEP
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_SITUACION != :szhBAA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOBEEP where (COD_CLIENT\
E=:b1 and COD_SITUACION<>:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1841;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAboBeep;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
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


	sema_post(&semaflock);
	if( SQLCODE )	{
		ifnTrazaHilos(modulo, &pfLog, "(Cli:%ld) GA_ABOBEEP : %s",LOG00,lhCodCliente,SQLERRM);  
        return FALSE;
	}

	/*-Obtiene el codigo de gestion a asignar al cliente-*/            
	if( ihCntAboCelu + ihCntAboBeep == 0 ) { 	    
		/*-Si el cliente no tiene abonados celulares o beeper asigna cod_gestion = 'SA'-*/ 
		sema_wait(&semaflock);
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT SUM(cuenta)
		INTO	 :ihCntSumAbo
		FROM  (SELECT 	count(*) as cuenta
				FROM   	ga_abocel
				WHERE  	cod_cliente = :lhCodCliente
				AND 	   cod_uso != :ihValor_tres
				UNION
				SELECT 	count(*) as cuenta
				FROM 	   ga_abobeep
				WHERE 	cod_cliente = :lhCodCliente ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select sum(cuenta) into :b0  from (select count(*)  cuenta \
 from ga_abocel where (cod_cliente=:b1 and cod_uso<>:b2) union select count(*)\
  cuenta  from ga_abobeep where cod_cliente=:b1) ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1868;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSumAbo;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_tres;
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
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		
		sema_post(&semaflock);
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) 	{
			ifnTrazaHilos(modulo, &pfLog, "(Cli:%ld) ERROR, Contando abonados y beepers del Cliente : %s",LOG00,lhCodCliente,SQLERRM);  
	        return FALSE;
		}
		

		if ( ihCntSumAbo == 0 )   {
	    	strcpy( szhCodGestion, "SA" );
		}
		else
		{
			/*-Si el cliente solo tiene abonados celulares o beeper de baja y alguno -*/
			/*-en cod_causabaja in( '90','43','44') asigna cod_gestion = 'CF'-*/ 
			sema_wait(&semaflock);
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT	sum(cuenta)
			INTO	:ihCntSumAbo
			FROM  ( 	SELECT COUNT(*) AS CUENTA
						FROM   GA_ABOCEL
						WHERE  COD_CLIENTE = :lhCodCliente
						AND 	 COD_SITUACION = :szhBAA
						AND 	 COD_USO != :ihValor_tres
						AND    COD_CAUSABAJA In ( :szhNum90,:szhNum43,:szhNum44) 
						UNION
						SELECT COUNT(*) AS CUENTA
						FROM 	 GA_ABOBEEP
						WHERE  COD_CLIENTE = :lhCodCliente
						AND 	 COD_SITUACION = :szhBAA
						AND    COD_CAUSABAJA IN ( :szhNum90,:szhNum43,:szhNum44)); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select sum(cuenta) into :b0  from (select count(*)  CUENTA\
  from GA_ABOCEL where (((COD_CLIENTE=:b1 and COD_SITUACION=:b2) and COD_USO<>\
:b3) and COD_CAUSABAJA in (:b4,:b5,:b6)) union select count(*)  CUENTA  from G\
A_ABOBEEP where ((COD_CLIENTE=:b1 and COD_SITUACION=:b2) and COD_CAUSABAJA in \
(:b4,:b5,:b6))) ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1899;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSumAbo;
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
   sqlstm.sqhstl[2] = (unsigned long )4;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_tres;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNum90;
   sqlstm.sqhstl[4] = (unsigned long )3;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhNum43;
   sqlstm.sqhstl[5] = (unsigned long )3;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhNum44;
   sqlstm.sqhstl[6] = (unsigned long )3;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhBAA;
   sqlstm.sqhstl[8] = (unsigned long )4;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhNum90;
   sqlstm.sqhstl[9] = (unsigned long )3;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhNum43;
   sqlstm.sqhstl[10] = (unsigned long )3;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhNum44;
   sqlstm.sqhstl[11] = (unsigned long )3;
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

 
			sema_post(&semaflock);		   							
			if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) {
				ifnTrazaHilos(modulo, &pfLog, "(Cli:%ld) ERROR, Contando abonados y beepers en Baja del Cliente : %s",LOG00,lhCodCliente,SQLERRM);  
		        return FALSE;
			}
			
    
			if ( ihCntSumAbo > 0 ) 
				strcpy( szhCodGestion, "CF" );
			else 
				/*-Si el cliente no cumple ninguna de las condiciones anteriores asigna cod_gestion = 'BA'-*/ 
				strcpy( szhCodGestion, "BA" );
	    } 
	} /* if ( ihCntAboCelu + ihCntAboBeep > 0 ) */
	
	/* si no cumplio criterios anteriores */
	if( !strcmp( szhCodGestion, "NN" ) ) 	{
		if( iIndExcluye )	/* LO ESTOY EXCLUYENDO, Esta pasando a historico y saliendo de morosos */		{
			strcpy( szhCodGestion, "MR" );
		}
		else	
		{
			sema_wait(&semaflock);
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT R.COD_RUTINA, R.COD_GESTION
			INTO	 :szhCodRutina,
					 :szhCodGestion
			FROM	 CO_RUTINAS R
			WHERE	 R.TIP_RUTINA = :szhLetra_A
			AND	 R.COD_GESTION IS NOT NULL
			AND  	 R.ORD_APLICACION = (SELECT MIN( RR.ORD_APLICACION )
												FROM	CO_RUTINAS RR, CO_ACCIONES CO
												WHERE	CO.COD_CLIENTE = :lhCodCliente
												AND	CO.NUM_SECUENCIA > :ihValor_cero
												AND	CO.COD_ESTADO IN ( :szhEJE, :szhRER )		
												AND	CO.COD_RUTINA = RR.COD_RUTINA
												AND	RR.TIP_RUTINA = :szhLetra_A
												AND	RR.COD_GESTION IS NOT NULL ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select R.COD_RUTINA ,R.COD_GESTION into :b0,:b1  from CO_R\
UTINAS R where ((R.TIP_RUTINA=:b2 and R.COD_GESTION is  not null ) and R.ORD_A\
PLICACION=(select min(RR.ORD_APLICACION)  from CO_RUTINAS RR ,CO_ACCIONES CO w\
here (((((CO.COD_CLIENTE=:b3 and CO.NUM_SECUENCIA>:b4) and CO.COD_ESTADO in (:\
b5,:b6)) and CO.COD_RUTINA=RR.COD_RUTINA) and RR.TIP_RUTINA=:b2) and RR.COD_GE\
STION is  not null )))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1962;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodRutina;
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestion;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_A;
   sqlstm.sqhstl[2] = (unsigned long )2;
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
   sqlstm.sqhstv[5] = (unsigned char  *)szhEJE;
   sqlstm.sqhstl[5] = (unsigned long )4;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhRER;
   sqlstm.sqhstl[6] = (unsigned long )4;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_A;
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


		
		    sema_post(&semaflock);
		    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )   {
		        ifnTrazaHilos( modulo, &pfLog, "Cliente: [%ld] Al recuperar Codigo de Gestion (3)  %s.", LOG00, lhCodCliente, SQLERRM );
		        return FALSE;
		    }
		 	 
		    if( !strcmp( szhCodGestion, "NN" ) )    {
       			strcpy( szhCodGestion, "MR" );
			        ifnTrazaHilos( modulo, &pfLog, "Cliente [%ld]. No se encontro Codigo de Gestion NN (2), se asigna 'MR'.", LOG05, lhCodCliente );
		    }
		} /* if( iIndExcluye ) */ 
	} /* if( strcmp( szhCodGestion, "NN" ) ) */

	ifnTrazaHilos( modulo, &pfLog, "Cliente:'%ld' Nuevo Cod_Gestion = [%s]", LOG03, lhCodCliente, szhCodGestion );
   /*strcpy( szhCodGestion,( ( !strcmp( szhCodGestion, "MR" ) ) ? "CO" : szhCodGestion ) );	 en la Morosos no va CO, va MR */
	strcpy(szCod_Gestion,szhCodGestion);
   return TRUE;
   
} /* BOOL bfnFindNewCodGestion( long lCodCliente, int iIndExcluye ) */

/*==================================================================================================*/
/* Funcion que determina la fecha de ejecucion de una rutina (accion) fmto: YYYYMMDD					 */
/* Esta habilitada para los procesos que trabajan con hilos   													 */
/*==================================================================================================*/
int ifnDetFechaEjecucionEv( FILE **ptArchLog , char *szCodAccion, char *szFecEjecucion)  
{
char modulo[]="ifnDetFechaEjecucionEv";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCntRows;
	int  ihCntDias;
	int  ihCodDia;
	char szhCodAccion   [6];
	char szhNvaFecha    [9];
	char szhFecEjecucion[9];
	char szhYYYYMMDD    [9];
	char szhLetra_D     [2];
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog;	
pfLog = *ptArchLog;
    
   ifnTrazaHilos( modulo, &pfLog ,"Entre en %s con Accion %s  Fecha Ejec %s ", LOG06, modulo, szCodAccion, szFecEjecucion );
	strcpy(szhCodAccion,szCodAccion);
	strcpy(szhYYYYMMDD,"YYYYMMDD");
	strcpy(szhLetra_D,"D");

    
	/* ve si accion tiene restricciones */
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COUNT(*)  
	INTO   :ihCntRows
	FROM   CO_DIASNOEJEC
	WHERE  COD_RUTINA = :szhCodAccion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where COD_RUTI\
NA=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2009;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
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

 
	sema_post(&semaflock);
   if (SQLCODE) {
		ifnTrazaHilos(modulo, &pfLog ," CO_DIASNOEJEC(1) : %s",LOG00,SQLERRM);
      return -1;
   }
   
	if (ihCntRows == 0) return 0; /* la accion se puede ejecutar cualquier dia */

   strcpy(szhNvaFecha,szFecEjecucion); /* fecha tentativa */

	while (1)
	{
    	strcpy(szhFecEjecucion,szhNvaFecha); /* verificando la nueva fecha */

		/* determina dia de la semana de la fecha  1:Domingo,2:lunes,...,7:sabado*/
		sema_wait(&semaflock);
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE
			BEGIN
				:ihCodDia:=TO_CHAR(TO_DATE(:szhFecEjecucion,:szhYYYYMMDD),:szhLetra_D);
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :ihCodDia := TO_CHAR ( TO_DATE ( :szhFecEjecucion , :\
szhYYYYMMDD ) , :szhLetra_D ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2032;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodDia;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_D;
  sqlstm.sqhstl[3] = (unsigned long )2;
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


		sema_post(&semaflock);
    	if (SQLCODE) {
        	ifnTrazaHilos(modulo, &pfLog ," DUAL(1) dia de la semana : %s",LOG00,SQLERRM);
        	return -1;
    	}
    
		/* ve si accion tiene restriccion para ese dia */
    	sema_wait(&semaflock);
    	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    	/* EXEC SQL 
    	SELECT COUNT(*)  
		INTO   :ihCntRows
		FROM   CO_DIASNOEJEC
		WHERE  COD_RUTINA = :szhCodAccion 
		AND    COD_DIA = :ihCodDia; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 16;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where (COD\
_RUTINA=:b1 and COD_DIA=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2063;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodDia;
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


		sema_post(&semaflock);
    	if (SQLCODE)  	{
        	ifnTrazaHilos(modulo, &pfLog ," CO_DIASNOEJEC(2) : %s",LOG00,SQLERRM);
        	return -1;
    	}

    	
		if (ihCntRows == 0)  /* la accion no tiene restriccion para ese dia */
		{
			/* valida si la fecha es feriado o visperas de feriado */
			ihCodDia = ifnDetFeriadosEv(&pfLog, szhFecEjecucion); /* fmto YYYYMMDD */
			if ( ihCodDia < 0 ) {
				return -1;
			}
			if ( ihCodDia > 0 ) /* es feriado o visperas de feriado */
			{
				/* valida si tiene restricciones para feriados o visperas */
    			sema_wait(&semaflock);
    			sqlca.sqlcode=0; /* XO-200508280498 rvc */
    			/* EXEC SQL 
    			SELECT COUNT(*)  
			   INTO   :ihCntRows
			   FROM   CO_DIASNOEJEC
			   WHERE  COD_RUTINA = :szhCodAccion 
				AND    COD_DIA = :ihCodDia; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 16;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where (C\
OD_RUTINA=:b1 and COD_DIA=:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )2090;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
       sqlstm.sqhstl[1] = (unsigned long )6;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&ihCodDia;
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

  /* 8 o 9 */
				sema_post(&semaflock);
    			if (SQLCODE)
    			{
        			ifnTrazaHilos(modulo, &pfLog ," CO_DIASNOEJEC(3) : %s",LOG00,SQLERRM);
        			return -1;
    			}
				if (ihCntRows == 0)  /* la accion no tiene restriccion para ese dia */
				{
					break; /* es una fecha valida */
				}
				else /* la accion tiene restricciones para feriados o visperas */
				{
					if ( ihCodDia == 8 ) /* visperas de feriado */
						ihCntDias = 2; /* le sumara dos dias a la fecha */
					else /* es feriado */
						ihCntDias = 1; /* le sumara un dia a la fecha */
				}
			}
			else /* no es feriado ni visperas */
			{
				break; /* es una fecha valida */
			}
		}
		else /* tiene restriccion para ese dia */
		{
			ihCntDias = 1; /* le sumara un dia a la fecha */
		}

		/* determina nueva fecha */
		sema_wait(&semaflock);
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE
			BEGIN
				:szhNvaFecha:=TO_CHAR((TO_DATE(:szhFecEjecucion,:szhYYYYMMDD) + :ihCntDias),:szhYYYYMMDD);
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :szhNvaFecha := TO_CHAR ( ( TO_DATE ( :szhFecEjecucio\
n , :szhYYYYMMDD ) + :ihCntDias ) , :szhYYYYMMDD ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2117;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhNvaFecha;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCntDias;
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


		sema_post(&semaflock);
		if( SQLCODE != SQLOK )	{
			ifnTrazaHilos( modulo, &pfLog, "Error en szhFecEjecucion  - %s", LOG01, SQLERRM);
			return -1;
		}

	} /* end while */
    
    strcpy(szFecEjecucion,szhFecEjecucion);
    return 0;
} /* fin ifnDetFechaEjecucionEv */

/*==================================================================================================*/
/* Funcion que valida el maximo de acciones por dia															    */
/*==================================================================================================*/
int ifnValidaMaxAccionesDiaEv( FILE **ptArchLog , char *szCodAccion, char *szFecEjecucion, long lMaxAccDia, struct ACCIONES *stNodoAcc ) /* fmto: YYYYMMDD */
{
char	modulo[] = "ifnValidaMaxAccionesDiaEv";
int		iFechaInvalida = 1;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhFecEjecucion[9];
	char	szhCodAccion[6];
	char	szhNvaFecha[9];
	long	lhNumEjecutadas;
	char  szhYYYYMMDD  [9];
	int   ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog;	
pfLog = *ptArchLog;

	ifnTrazaHilos( modulo, &pfLog, "Entre en %s con Accion => [%s]  Fecha Ejec => [%s], MaxAcc => [%d].", LOG06, modulo, szCodAccion, szFecEjecucion, lMaxAccDia );

	memset( szhFecEjecucion, '\0', sizeof( szhFecEjecucion ) );
	memset( szhCodAccion, '\0', sizeof( szhCodAccion ) );
	memset( szhNvaFecha, '\0', sizeof( szhNvaFecha ) );
	strcpy( szhFecEjecucion, szFecEjecucion );
	strcpy( szhCodAccion, szCodAccion );
	strcpy(szhYYYYMMDD,"YYYYMMDD");
    
	/* revisa cuantas acciones se han generado para la fecha tentativa */
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT NUM_EJECUTADAS
	INTO	 :lhNumEjecutadas
	FROM	 CO_RUTINAS_DIA
	WHERE	 COD_RUTINA	= :szhCodAccion
	AND	 FEC_RUTINA	= TO_DATE( :szhFecEjecucion, :szhYYYYMMDD); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NUM_EJECUTADAS into :b0  from CO_RUTINAS_DIA where (C\
OD_RUTINA=:b1 and FEC_RUTINA=TO_DATE(:b2,:b3))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2148;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumEjecutadas;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecEjecucion;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[3] = (unsigned long )9;
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


	sema_post(&semaflock);

   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo, &pfLog, "Error al verificar numero ejecutadas => [%s].", LOG00, SQLERRM );
        return -1;
   }
   else if( SQLCODE == SQLNOTFOUND )	/* si no existe el registro para la fecha buscada lo creamos */	{

		stNodoAcc->iFlagRutinas=0;
		ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAcc->iFlagRutinas  [%d] (Insertar)", LOG03,stNodoAcc->iFlagRutinas);
	} 
   else	/* hemos creado acciones para el dia consultado */
   {
    	/* si todavia podemos generar acciones para el dia */
    	if( lhNumEjecutadas < lMaxAccDia )    	{
			stNodoAcc->iFlagRutinas=1;
			ifnTrazaHilos( modulo, &pfLog, "\tACCION***** stNodoAcc->iFlagRutinas  [%d] (Updatear)", LOG03,stNodoAcc->iFlagRutinas);
		}
		else	/* se cumplio la cota de acciones para el dia, se debe buscar otra fecha valida */
		{		    
			/* determina nueva fecha */
			sema_wait(&semaflock);
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL EXECUTE
				BEGIN
					:szhNvaFecha:=TO_CHAR( ( TO_DATE( :szhFecEjecucion, :szhYYYYMMDD ) + :ihValor_uno ), :szhYYYYMMDD );
				END;
			END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin :szhNvaFecha := TO_CHAR ( ( TO_DATE ( :szhFecEjecuci\
on , :szhYYYYMMDD ) + :ihValor_uno ) , :szhYYYYMMDD ) ; END ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2179;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhNvaFecha;
   sqlstm.sqhstl[0] = (unsigned long )9;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
   sqlstm.sqhstl[2] = (unsigned long )9;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_uno;
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


			sema_post(&semaflock);
			
			if( SQLCODE ) 	{
				ifnTrazaHilos( modulo, &pfLog, "Error al obtener nueva fecha => [%s].", LOG00, SQLERRM );
				return -1;
			}
			
		    strcpy( szFecEjecucion, szhNvaFecha );
			iFechaInvalida = 0;
		}

	} /* end while */

   ifnTrazaHilos( modulo, &pfLog, "\tValor de retorno funcion iFechaInvalida : [%d] .", LOG06, iFechaInvalida );     
  	return iFechaInvalida;

} /* int ifnValidaMaxAccionesDiaEv() */

/*==================================================================================================*/
/* Funcion que determina los dias feriados																			 */
/* Esta habilitada para los procesos que trabajan con hilos   													 */
/*==================================================================================================*/
int ifnDetFeriadosEv( FILE **ptArchLog , char *szFecha ) 
{
char modulo[]="ifnDetFeriados";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCntRows;
	char szhFecha[9];             /* EXEC SQL VAR szhFecha IS STRING (9); */ 
		/*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
	char szhNvaFecha[9];          /* EXEC SQL VAR szhNvaFecha IS STRING (9); */ 
	/*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
    char szhYYYYMMDD [9];         /* EXEC SQL VAR szhYYYYMMDD IS STRING (9); */ 
   /*HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog;	
	pfLog = *ptArchLog;
    
	strcpy(szhFecha,szFecha); /* fmto : YYYYMMDD */
	strcpy(szhYYYYMMDD,"YYYYMMDD");
    
	/* determina dia es feriado */
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COUNT(*)  
	INTO   :ihCntRows
	FROM   TA_DIASFEST
	WHERE  FEC_DIAFEST = TO_DATE(:szhFecha,:szhYYYYMMDD); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from TA_DIASFEST where FEC_DIAFES\
T=TO_DATE(:b1,:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2210;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[2] = (unsigned long )9;
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


	sema_post(&semaflock);
	if (SQLCODE) 	{
		ifnTrazaHilos(modulo, &pfLog, " TA_DIASFEST(1) : %s",LOG00,SQLERRM);
		return -1;
	}

	if (ihCntRows > 0) /* es feriado */
		return 9;
    
	/* le suma un dia a la fecha */
	/*sema_wait(&semaflock);
	EXEC SQL EXECUTE
		BEGIN
			:szhNvaFecha:=TO_CHAR(TO_DATE(:szhFecha,:szhYYYYMMDD) + 1,:szhYYYYMMDD);
		END;
	END-EXEC;
	sema_post(&semaflock);*/
	
    /*Inicio HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia XM-200503170289*/	
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT TO_CHAR(TO_DATE(:szhFecha,:szhYYYYMMDD) + 1,:szhYYYYMMDD)
	INTO :szhNvaFecha
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR((TO_DATE(:b0,:b1)+1),:b1) into :b3  from DUAL\
 ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2237;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhNvaFecha;
 sqlstm.sqhstl[3] = (unsigned long )9;
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

		
	sema_post(&semaflock);
	/*Fin */
	
  	if (SQLCODE) {
  		ifnTrazaHilos(modulo, &pfLog, " DUAL : %s",LOG00,SQLERRM);
  		return -1;
  	}

	/* determina dia es visperas de feriado */
	sema_wait(&semaflock);
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COUNT(*)  
	INTO   :ihCntRows
	FROM   TA_DIASFEST
	WHERE  FEC_DIAFEST = TO_DATE(:szhNvaFecha,:szhYYYYMMDD); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from TA_DIASFEST where FEC_DIAFES\
T=TO_DATE(:b1,:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2268;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhNvaFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[2] = (unsigned long )9;
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


	sema_post(&semaflock);
	if (SQLCODE) 	{
	  	ifnTrazaHilos(modulo, &pfLog, " TA_DIASFEST(2) : %s",LOG00,SQLERRM);
	  	return -1;
	}
	if (ihCntRows > 0) /* es visperas de feriado */
		return 8;

	return 0;
} /* fin ifnDetFeriadosEv */

/* ============================================================================= */
/* Funcion que rescata la diferencia de dias para optar a la prorroga            */
/* ============================================================================= */
int ifnPtoProrr( lista_Pto pPtoGest, char *szFecVencClte)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char 	szhFecVenc[9] = ""; /* EXEC SQL VAR szhFecVenc IS STRING(9); */ 
/* Fecha Definitiva de Ejecucion de la Accion */
	long 	lhDifDias = 0;
	long 	lhNumDias = 0;
	char  szhYYYYMMDD [9];
/* EXEC SQL END DECLARE SECTION; */ 


   lhNumDias = pPtoGest->iNumDias;
   strcpy(szhFecVenc,szFecVencClte);
   strcpy(szhYYYYMMDD,"YYYYMMDD");

   
   sema_wait(&semaflock);
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL EXECUTE
   BEGIN
     :lhDifDias := TRUNC(SYSDATE - :lhNumDias) -TO_DATE(:szhFecVenc,:szhYYYYMMDD);
   END;
   END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin :lhDifDias := TRUNC ( SYSDATE -:lhNumDias ) -TO_DATE\
 ( :szhFecVenc , :szhYYYYMMDD ) ; END ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2295;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhDifDias;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumDias;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenc;
   sqlstm.sqhstl[2] = (unsigned long )9;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDD;
   sqlstm.sqhstl[3] = (unsigned long )9;
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


   sema_post(&semaflock);


   if (strcmp(pPtoGest->szIndProrroga, "S") == 0 ){
       if (lhDifDias >= 0)
	   return  1; /* la fecha es < =   cumple*/
       else 
           return  0;/*  la fecha es >   No cumple*/ 
   }
   else{
       if (lhDifDias == 0)
	   return  1; /* la fecha es ==   cumple*/
       else 
           return  0;/*  la fecha es !=   No cumple*/
   } 

}



/*==================================================================================================*/
/* Funcion que actualzia el codigo de gestion de un abonado                                         */
/*==================================================================================================*/
BOOL bfnUpdateEstadoGaABO( long lCliente, int iIndExcluye, long lNumSecuAccion )
{
char modulo[]="bfnUpdateEstadoGaABO";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     long lhCodCliente    = lCliente;
     long lhNumSecuAccion = lNumSecuAccion;
     char szhCodAccion   [6]=""; /* EXEC SQL VAR szhCodAccion IS STRING(6); */ 

     char szhCodGestion  [3]=""; /* EXEC SQL VAR szhCodGestion IS STRING(3); */ 

     int ihUsoAmistar   = 3;
/* EXEC SQL END DECLARE SECTION; */ 

     
    memset(szhCodAccion,'\0',sizeof(szhCodAccion));
    sprintf(szhCodGestion,"NN\0");

    if ( iIndExcluye == 0 ) /* NO LO ESTOY EXCLUYENDO */
    {
        /* Verificar que Accion se le esta ejecutando al cliente  */
        sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL
        SELECT COD_RUTINA
        INTO :szhCodAccion
        FROM CO_ACCIONES
        WHERE COD_CLIENTE = :lhCodCliente
		  AND NUM_SECUENCIA = :lhNumSecuAccion; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_RUTINA into :b0  from CO_ACCIONES where (C\
OD_CLIENTE=:b1 and NUM_SECUENCIA=:b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2326;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodAccion;
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
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuAccion;
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


        if (SQLCODE != SQLOK)
        {
            ifnTrazasLog(modulo,"Select CO_ACCIONES. Cliente:'%ld'  %s" ,LOG00,lhCodCliente,SQLERRM);
            return FALSE; 
        }

	     /* Determina la Gestisn asociada a la Accion */
	     if (!strcmp(szhCodAccion,"SUSUN")) sprintf(szhCodGestion,"SU\0");
	     if (!strcmp(szhCodAccion,"SUSBI")) sprintf(szhCodGestion,"SS\0");
	     if (!strcmp(szhCodAccion,"BLOQU")) sprintf(szhCodGestion,"BF\0");
	     if (!strcmp(szhCodAccion,"BAJA"))  sprintf(szhCodGestion,"CF\0");
	     if (!strcmp(szhCodAccion,"DESBL")) sprintf(szhCodGestion,"SU\0");
	     if (!strcmp(szhCodAccion,"REPOS")) sprintf(szhCodGestion,"CO\0");
    }
    else /* SE ESTA EXCLUYENDO */
    {
        sprintf(szhCodGestion,"CO\0");
    }
 
    if (!strcmp(szhCodGestion,"NN")) /* la Accion no esta dentro de las que cambian el estado de la gestion */
    {
        ifnTrazasLog(modulo,"La Accion %s NO actualizo la gestion del Cliente %ld",LOG05,szhCodAccion,lhCodCliente);
        return TRUE;
    }

    /* Aqui actualizar el COD_ESTADO de la GA_ABOCEL y la GA_ABOBEEP con el COD_GESTION de la CO_PTOSGESTION */
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE GA_ABOCEL
    SET COD_ESTADO = :szhCodGestion
    WHERE COD_CLIENTE = :lhCodCliente
    AND COD_USO != :ihUsoAmistar; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GA_ABOCEL  set COD_ESTADO=:b0 where (COD_CLIENTE=:\
b1 and COD_USO<>:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2353;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihUsoAmistar;
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

 /* 3 */
    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )   {
        ifnTrazasLog(modulo,"Update de GA_ABOCEL del Cliente:'%ld' Cod_estado:'%s' > %s" ,LOG00,lhCodCliente,szhCodGestion,SQLERRM);
        return FALSE;
    }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE GA_ABOBEEP
    SET COD_ESTADO = :szhCodGestion
    WHERE COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GA_ABOBEEP  set COD_ESTADO=:b0 where COD_CLIENTE=:\
b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2380;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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


    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog(modulo,"Update de GA_ABOBEEP del Cliente:'%ld' Cod_estado:'%s' > %s",LOG00,lhCodCliente,szhCodGestion,SQLERRM);
        return FALSE;
    }

    strcpy(szhCodGestion,((!strcmp(szhCodGestion,"CO"))?"MR":szhCodGestion)); /* en la Morosos no va CO, va MR */
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE	CO_MOROSOS
    SET		COD_GESTION	= :szhCodGestion,
			   FEC_GESTION	= SYSDATE 
    WHERE	COD_CLIENTE	= :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_MOROSOS  set COD_GESTION=:b0,FEC_GESTION=SYSDAT\
E where COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2403;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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


    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog(modulo,"Update de CO_MOROSOS del Cliente:'%ld' Cod_estado:'%s' > %s",LOG00,lhCodCliente,szhCodGestion,SQLERRM);
        return FALSE;
    }

    return TRUE;
    
}

/*==================================================================================================*/
/* Funcion que actualiza el valor de un parametro																   */
/*==================================================================================================*/
BOOL bfnUpdateGedParametro( char *szNomParametro, char *szCodModulo, char *szValParametro )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhValParametro[21];
	char szhNomParametro[21];
	char szhCodModulo[iLENCODMODULO];
	int  ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnUpdateGedParametro";

	ifnTrazasLog( modulo, "Ingreso modulo : [%s].", LOG05, modulo );

	memset( szhValParametro, '\0', sizeof( szhValParametro ) );
	memset( szhNomParametro, '\0', sizeof( szhNomParametro ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );

	strcpy( szhNomParametro, szNomParametro );
	strcpy( szhCodModulo, szCodModulo );
	strcpy( szhValParametro, szValParametro );
	rtrim( szhCodModulo );
	rtrim( szhNomParametro );
	rtrim( szhValParametro );

	ifnTrazasLog( modulo, "Parametro => [%s] Nuevo Valor => [%s].", LOG06, szhNomParametro, szhValParametro );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	UPDATE GED_PARAMETROS SET 
	      VAL_PARAMETRO= :szhValParametro
	WHERE NOM_PARAMETRO= :szhNomParametro
	AND   COD_MODULO   = :szhCodModulo
	AND   COD_PRODUCTO = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update GED_PARAMETROS  set VAL_PARAMETRO=:b0 where ((NOM_PAR\
AMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2426;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_uno;
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



	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "Error al actualizar Valor de Parametro ==> [%s][%s].", LOG00, szhNomParametro, SQLERRM );
		return FALSE;
	}

	if( SQLCODE == SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "No se encuentra parametro => [%s], en tabla.", LOG00, szhNomParametro );
		return FALSE;
	}

	return TRUE;
} /* bfnUpdateGedParametro */


/* ============================================================================= */
/* Funcion que busca secuencia dentro de una lista                               */
/* ============================================================================= */
int ifnBuscaSecAnt( lista_SecPtos pSecCateg, int iSecClte, int iSecPto)
{
lista_SecPtos pSecaux = pSecCateg;
int iExiste = 0;
	
	while (pSecaux != NULL && pSecaux->iNumProceso != iSecPto && !iExiste ){
		iExiste = iSecClte == pSecaux->iNumProceso ? 1 : 0;
	   pSecaux = pSecaux->sig;
	}

   return iExiste;
   
}/* fin ifnBuscaSecAnt */


/* ============================================================================= */
/* Funcion que carga acciones en una lista enlazada                              */
/* ============================================================================= */
int ifnCargaAcciones( lista_Acc  *pAcciones, char *PtoGest, char *Categoria, int Proceso)
{
char modulo[]="ifnCargaAcciones";
int iTotalRows = 0;
int i=0, sts=0;
int iAcc=0;
lista_Acc  pAccionesAux=NULL;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_Rutina  sthAccion;
	char  szhCodPtoGest[6]; /* EXEC SQL VAR szhCodPtoGest IS STRING (6); */ 

	char  szhCodCategoria[6]; /* EXEC SQL VAR szhCodCategoria IS STRING (6); */ 

	int   ihNumProceso=0;
	char  szhNULO      [5];
	char  szhLetra_X   [2];
	char  szhLetra_S   [2];
	char  szhLetra_N   [2];
	char  szhLetra_A   [2];
	int   ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 

    
	strcpy(szhCodPtoGest,PtoGest);
   strcpy(szhCodCategoria,Categoria);
	ihNumProceso = Proceso;
	strcpy(szhNULO,"NULO");
	strcpy(szhLetra_X,"X");
	strcpy(szhLetra_S,"S");
	strcpy(szhLetra_N,"N");
	strcpy(szhLetra_A,"A");
    
   memset(&sthAccion,0,sizeof(td_Rutina));

   ifnTrazasLog(modulo,"szhCodPtoGest :'%s'",LOG05,szhCodPtoGest);
   ifnTrazasLog(modulo,"szhCodCategoria :'%s'",LOG05,szhCodCategoria);
   ifnTrazasLog(modulo,"ihNumProceso :'%d'",LOG05,ihNumProceso);
   
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL DECLARE curAcciones CURSOR FOR
	SELECT CR.TIP_RUTINA,
		   CR.COD_RUTINA,
		   :szhLetra_X,
		   :szhNULO,
		   :szhNULO,
		   :szhLetra_X,
		   :ihValor_cero,
		   CR.IND_PRORROGA,
		   NVL( CR.IND_DUPLICABLE, :szhLetra_S), 
		   NVL( CR.MAX_DIARIO, :ihValor_cero ),
		   NVL( CPR.COD_PARAM, :szhLetra_N ) 
	FROM	CO_RUTINAS CR, CO_PTOSRUTINAS CPR
	WHERE	CPR.COD_PTOGEST  = :szhCodPtoGest
	AND	CPR.COD_CATEGORIA= :szhCodCategoria
	AND	CPR.NUM_PROCESO  = :ihNumProceso
	AND	CPR.COD_RUTINA   = CR.COD_RUTINA
	AND	CR.TIP_RUTINA    = :szhLetra_A  /o recupera las acciones='A' o/
	ORDER BY 1, 2 DESC; */ 

   /* ordena por tipo_rutina y cod_rutina */

   if( SQLCODE )
   {
		ifnTrazasLog( modulo, "en DECLARE : %s", LOG00, SQLERRM );
		return -1;
	}

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL OPEN curAcciones; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0071;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2457;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_X;
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhNULO;
   sqlstm.sqhstl[2] = (unsigned long )5;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_X;
   sqlstm.sqhstl[3] = (unsigned long )2;
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
   sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_S;
   sqlstm.sqhstl[5] = (unsigned long )2;
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
   sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_N;
   sqlstm.sqhstl[7] = (unsigned long )2;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhCodPtoGest;
   sqlstm.sqhstl[8] = (unsigned long )6;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhCodCategoria;
   sqlstm.sqhstl[9] = (unsigned long )6;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&ihNumProceso;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_A;
   sqlstm.sqhstl[11] = (unsigned long )2;
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


   if (SQLCODE) 
   {
        ifnTrazasLog(modulo,"en OPEN : %s",LOG00,SQLERRM);
        return -1;
   }
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL FETCH curAcciones INTO sthAccion ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )150;
    sqlstm.offset = (unsigned int  )2520;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)sthAccion.szTipRutina;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )2;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)sthAccion.szCodRutina;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )6;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)sthAccion.szTipRetorno;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )2;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)sthAccion.szValRetorno;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )11;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)sthAccion.szValRango;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )11;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)sthAccion.szIndExcluye;
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )2;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)sthAccion.iDiasProrroga;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)sthAccion.szIndProrroga;
    sqlstm.sqhstl[7] = (unsigned long )2;
    sqlstm.sqhsts[7] = (         int  )2;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)sthAccion.szIndDuplicable;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )2;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)sthAccion.lMaxDiario;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )sizeof(long);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)sthAccion.szCodParam;
    sqlstm.sqhstl[10] = (unsigned long )16;
    sqlstm.sqhsts[10] = (         int  )16;
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
    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        ifnTrazasLog(modulo,"en FETCH : %s",LOG00,SQLERRM);
        return -1;
    }
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL CLOSE curAcciones; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2579;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
        ifnTrazasLog(modulo,"en CLOSE : %s",LOG00,SQLERRM);
        return -1;
    }

    /* Inserto : informacion adicional para el log */
    for(i=0;i<iTotalRows;i++)
    {
		if( i>0 ){
		   sts = ifnInsertaAcc(&pAccionesAux);
		   if( sts == -1 ){
		      ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
		      break;
		   }
		}
		else{
		   sts = ifnIniListAcc(&pAccionesAux);
		   if( sts == -1 ){
				ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
				return -1;
		   }
      		}
		rtrim(sthAccion.szCodRutina[i]);
	   strcpy(pAccionesAux->szCodRutina, sthAccion.szCodRutina[i]);
	   rtrim(sthAccion.szIndProrroga[i]);
		strcpy(pAccionesAux->szIndProrroga, sthAccion.szIndProrroga[i]);
		rtrim( sthAccion.szIndDuplicable[i]);
		strcpy(pAccionesAux->szIndDuplicable, sthAccion.szIndDuplicable[i]);
		pAccionesAux->lMaxDiario = sthAccion.lMaxDiario[i];
		rtrim(sthAccion.szCodParam[i]);
		strcpy(pAccionesAux->szCodParam, sthAccion.szCodParam[i]);
	 	iAcc++;
    }

    if ( sts == -1 ){
       ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
       return -1;
    }
    (*pAcciones) = pAccionesAux;
    ifnTrazasLog(modulo,"\t %3d Instancia(s) de Acciones(s) ",LOG05,iAcc);
    /*fin Inserto : informacion adicional para el log *********************************************/
    return iTotalRows;
} /* fin ifnCargaAcciones */

/* ============================================================================= */
/* Funcion que carga criterios en una lista enlazada                             */
/* ============================================================================= */
int ifnCargaCriterios( lista_Crit  *pCriterios, char *PtoGest, char *Categoria, int Proceso, int TipProc)
{
char modulo[]="ifnCargaCriterios";
int iTotalRows = 0;
int i=0, sts=0;
int iCrit=0;
int iCritDist=0;
char szRutinaAnterior[6] = "";
lista_Crit  pCriteriosAux=NULL;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_Criterio  sthCrit;
	char   szhCodPtoGest[6]; /* EXEC SQL VAR szhCodPtoGest IS STRING (6); */ 

	char   szhCodCategoria[6]; /* EXEC SQL VAR szhCodCategoria IS STRING (6); */ 

	int    ihNumProceso=0;
	char   szhNULO    [5];
/* EXEC SQL END DECLARE SECTION; */ 

    
	strcpy(szhCodPtoGest,PtoGest);
   strcpy(szhCodCategoria,Categoria);
	ihNumProceso = Proceso;
	strcpy(szhNULO,"NULO");
    
    memset(&sthCrit,0,sizeof(td_Criterio));

   ifnTrazasLog( modulo, "\n\tIngreso a funcion : [%s].", LOG03, modulo ); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
   ifnTrazasLog(modulo,"szhCodPtoGest :'%s'",LOG05,szhCodPtoGest);
   ifnTrazasLog(modulo,"szhCodCategoria :'%s'",LOG05,szhCodCategoria);
   ifnTrazasLog(modulo,"ihNumProceso :'%d'",LOG05,ihNumProceso);
   
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL DECLARE curCriterio CURSOR FOR
	SELECT UNIQUE CVRP.COD_RUTINA,
		    CRR.NOM_RUTINA,
		    CVRR.TIP_RETORNO,
		    CVRP.VAL_RETORNO,
		    NVL(CVRP.VAL_RANGO, :szhNULO),
		    CVRP.IND_EXCLUYE,
		    CVRP.DIA_PRORROGA
	FROM	 CO_VALRETRUT CVRR, CO_VALRETPTO CVRP, CO_RUTINAS CRR
	WHERE	 CVRP.COD_PTOGEST  = :szhCodPtoGest
	AND	 CVRP.COD_CATEGORIA= :szhCodCategoria
	AND	 CVRP.NUM_PROCESO  = :ihNumProceso
	AND	 CVRR.COD_RUTINA   = CVRP.COD_RUTINA
	AND    CRR.COD_RUTINA    = CVRP.COD_RUTINA
	ORDER BY CVRP.COD_RUTINA DESC; */ 
 /* ordena por cod_rutina */

	if( SQLCODE )
	{
		ifnTrazasLog( modulo, "en DECLARE : %s", LOG00, SQLERRM );
		return -1;
	}

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL OPEN curCriterio; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0072;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2594;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNULO;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPtoGest;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCategoria;
    sqlstm.sqhstl[2] = (unsigned long )6;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        ifnTrazasLog(modulo,"en OPEN : %s",LOG00,SQLERRM);
        return -1;
    }
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL FETCH curCriterio INTO sthCrit ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )150;
    sqlstm.offset = (unsigned int  )2625;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)sthCrit.szCodRutina;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)sthCrit.szNomRutina;
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )31;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)sthCrit.szTipRetorno;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )2;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)sthCrit.szValRetorno;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )11;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)sthCrit.szValRango;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )11;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)sthCrit.szIndExcluye;
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )2;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)sthCrit.iDiasProrroga;
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


    iTotalRows = SQLROWS;
    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        ifnTrazasLog(modulo,"en FETCH : %s",LOG00,SQLERRM);
        return -1;
    }
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL CLOSE curCriterio; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2668;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
        ifnTrazasLog(modulo,"en CLOSE : %s",LOG00,SQLERRM);
        return -1;
    }
    /* Inserto : informacion adicional para el log */
    strcpy(szRutinaAnterior,sthCrit.szCodRutina[0]);
    ifnTrazasLog(modulo,"iTotalRows [%d]",LOG03,iTotalRows);
    for(i=0;i<iTotalRows;i++)
    {
			if( i>0 ){
			   sts = ifnInsertaCrit(&pCriteriosAux);
			   if( sts == -1 ){
			      ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
			      break;
			   }
			}
			else{
				sts = ifnIniListCrit(&pCriteriosAux);
		      if( sts == -1 ){
			     ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
			     return -1;
			   }
		   }
			rtrim(sthCrit.szCodRutina[i]);
         strcpy(pCriteriosAux->szCodRutina, sthCrit.szCodRutina[i]);
         rtrim(sthCrit.szNomRutina[i]);
         strcpy(pCriteriosAux->szNomRutina, sthCrit.szNomRutina[i]);
         rtrim(sthCrit.szTipRetorno[i]);
			strcpy(pCriteriosAux->szTipRetorno, sthCrit.szTipRetorno[i]);
			rtrim(sthCrit.szValRetorno[i]);
			strcpy(pCriteriosAux->szValRetorno, sthCrit.szValRetorno[i]);
			rtrim(sthCrit.szValRango[i]);
			strcpy(pCriteriosAux->szValRango, sthCrit.szValRango[i]);
			rtrim(sthCrit.szIndExcluye[i]);
			strcpy(pCriteriosAux->szIndExcluye, sthCrit.szIndExcluye[i]);
			pCriteriosAux->iDiasProrroga = sthCrit.iDiasProrroga[i];
			
			/*if (TipProc == 1 && strcmp("SDCLI",pCriteriosAux->szCodRutina) == 0)*/
			/* Inicio XO-200509100635 Soporte RyC 29-09-2005 capc */
			/*if (TipProc == 1){                   * XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 *
			    pCriteriosAux->iTipFuncion = 1;
			}
			else pCriteriosAux->iTipFuncion = 0;
			 Fin ***** XO-200509100635 */
			pCriteriosAux->iTipFuncion = 0;
			
			if (strcmp(sthCrit.szCodRutina[i],szRutinaAnterior)) /* es distinta a la rutina anterior */
			{
			iCritDist++;
			strcpy(szRutinaAnterior,sthCrit.szCodRutina[i]);
			}
		 	iCrit++;
    }

    if ( sts == -1 ){
       ifnTrazasLog( modulo, "No hay memoria suficiente ", LOG01 );
       return -1;
    }
    (*pCriterios) = pCriteriosAux;
    ifnTrazasLog(modulo,"Cargo %d Instancias",LOG05,iTotalRows);
    ifnTrazasLog(modulo,"\t %3d Instancia(s) de Criterio(s) ",LOG05,iCrit);
    ifnTrazasLog(modulo,"\t %3d Criterio(s) Distinto(s) \n",LOG05,iCritDist);
    /*fin Inserto : informacion adicional para el log *********************************************/
    return iTotalRows;
} /* fin ifnCargaCriterios */

/* ============================================================================= */
/* Funcion que calcula el porcentaje de memoria disponible del servidor				*/
/* ============================================================================= */
int ifnMemoriaUsada(long *lCpu)
{
char modulo[] = "ifnMemoriaUsada";
double phys_pg, aphys_pg,pcpu;
long phys_mem, aphys_mem, pg_size ;
float fmem_usada, fhPorcentajeMem  ;
char szSystem [255], szPorc[2]; 
char szBuffer[BUFFER_SIZE];
char szSalida[BUFFER_SIZE];
FILE * pipe = NULL;

	ifnTrazasLog( modulo, "\n\tDatos de la Maquina.", LOG03);  
	phys_pg  = sysconf(_SC_PHYS_PAGES);
	aphys_pg = sysconf(_SC_AVPHYS_PAGES);
	pg_size  = sysconf(_SC_PAGESIZE);
	phys_mem =(phys_pg / 1048576) * pg_size;
	aphys_mem=((aphys_pg / 1024) * pg_size) / 1024;
	printf("Memoria utilizada: [%ld]  [%ld]  [%ld]\n",phys_mem, aphys_mem, pg_size);
	fmem_usada=100-((aphys_mem*100)/phys_mem);
	fhPorcentajeMem=fmem_usada/100;
	strcpy(szPorc,"%");

	*lCpu=0;
	sprintf(szSystem,"vmstat 1 2 |grep -v id |grep -v cpu | awk '{print$22}' |tail -1\0");
	memset(szBuffer,0x00,BUFFER_SIZE);
	if ( (pipe=popen(szSystem,"r")) == NULL ) return -1; 
	for(;;)	{
		if ( fgets(szBuffer,BUFFER_SIZE, pipe) == NULL ) break;
	} 
	pclose(pipe);
	strcat(szSalida,szBuffer);
	*lCpu=atol(szSalida);
	printf("Cpu Utilizada  [%ld]\n",*lCpu);
	ifnTrazasLog( modulo, "\tPorcentaje CPU usada      :  [%ld%s]", LOG03, *lCpu,szPorc);  
	ifnTrazasLog( modulo, "\tPorcentaje CPU libre      :  [%ld%s]\n", LOG03, 100-*lCpu,szPorc);  
	
	return 0;
}/* fin ifnMemoriaUsada */


/*==================================================================================================*/
/*==================================================================================================*/
/*  USO EXCLUSIVO  DE FUNCIONES CON SQL_CONTEXT                                                     */
/*==================================================================================================*/
/*==================================================================================================*/
/* Funcion que Valida si la cola del proceso todavia se encuentra activa									 */
/*==================================================================================================*/
BOOL bfnValidaColaActivaContex (FILE **ptArchLog, char *szCodProceso, int *iFlgActiva, sql_context ctxCont)
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodProceso[6]    = "";
	char szhCodActivacion[2] = "";
	char szhCodEstado    [2] = "";
	char szhFormato      [11]= "";
	int  ihFlgActiva = 0;
	int  ihValor_cero= 0;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="bfnValidaColaActivaContex";
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	strcpy(szhCodProceso   ,szCodProceso);
   strcpy(szhCodActivacion,"H");           /* activable (Habilitado) */
   strcpy(szhCodEstado    ,"R")    ;           /* running */
   strcpy(szhFormato      ,"HH24:MI:SS") ; /* formato de fecha */

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT NVL(count(*),:ihValor_cero)
	INTO  :ihFlgActiva
	FROM  CO_COLASPROC
	WHERE COD_PROCESO    = :szhCodProceso
	AND   COD_ACTIVACION = :szhCodActivacion    
	AND   COD_ESTADO     = :szhCodEstado
	AND   TO_CHAR( SYSDATE, :szhFormato ) BETWEEN IND_HORAINI AND IND_HORAFIN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(count(*) ,:b0) into :b1  from CO_COLASPROC where \
(((COD_PROCESO=:b2 and COD_ACTIVACION=:b3) and COD_ESTADO=:b4) and TO_CHAR(SYS\
DATE,:b5) between IND_HORAINI and IND_HORAFIN)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2683;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihFlgActiva;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodProceso;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodActivacion;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodEstado;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFormato;
 sqlstm.sqhstl[5] = (unsigned long )11;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )   {
		ifnTrazaHilos( modulo,&pfLog,  "al consultar la CO_COLASPROC, con proceso %s : %s.", LOG00, szhCodProceso, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	if( sqlca.sqlcode == SQLNOTFOUND )   {
		ifnTrazaHilos( modulo,&pfLog,  "proceso %s NO se encontro en CO_COLASPROC : %s", LOG00, szhCodProceso, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	*iFlgActiva = ihFlgActiva;
	return TRUE;
}

/* ============================================================================= */
/* Funcion que carga criterios en una lista enlazada                             */
/* ============================================================================= */
int ifnCargaCriteriosAcc(FILE **ptArchLog,  lista_Crit  *pCriterios, char *PtoGest, char *Categoria, int Proceso, int TipProc, sql_context ctxCont )
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	td_Criterio  sthCrit;
	char   szhCodPtoGest[6]; /* EXEC SQL VAR szhCodPtoGest IS STRING (6); */ 

	char   szhCodCategoria[6]; /* EXEC SQL VAR szhCodCategoria IS STRING (6); */ 

	int    ihNumProceso=0;
	char   szhNULO    [5];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="ifnCargaCriteriosAcc";
int iTotalRows = 0;
int i=0, sts=0;
int iCrit=0;
int iCritDist=0;
char szRutinaAnterior[6] = "";
lista_Crit  pCriteriosAux=NULL;
FILE *pfLog=*ptArchLog;
    
  	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	strcpy(szhCodPtoGest,PtoGest);
   strcpy(szhCodCategoria,Categoria);
	ihNumProceso = Proceso;
	strcpy(szhNULO,"NULO");
    
   memset(&sthCrit,0,sizeof(td_Criterio));

   ifnTrazaHilos( modulo,&pfLog, "szhCodPtoGest :'%s'",LOG05,szhCodPtoGest);
   ifnTrazaHilos( modulo,&pfLog, "szhCodCategoria :'%s'",LOG05,szhCodCategoria);
   ifnTrazaHilos( modulo,&pfLog, "ihNumProceso :'%d'",LOG05,ihNumProceso);
   
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL DECLARE curCriterioAcc CURSOR FOR
	SELECT UNIQUE CVRP.COD_RUTINA,
		    CRR.NOM_RUTINA,
		    CVRR.TIP_RETORNO,
		    CVRP.VAL_RETORNO,
		    NVL(CVRP.VAL_RANGO, :szhNULO),
		    CVRP.IND_EXCLUYE,
		    CVRP.DIA_PRORROGA
	FROM	 CO_VALRETRUT CVRR, CO_VALRETPTO CVRP, CO_RUTINAS CRR
	WHERE	 CVRP.COD_PTOGEST  = :szhCodPtoGest
	AND	 CVRP.COD_CATEGORIA= :szhCodCategoria
	AND	 CVRP.NUM_PROCESO  = :ihNumProceso
	AND	 CVRR.COD_RUTINA   = CVRP.COD_RUTINA
	AND    CRR.COD_RUTINA    = CVRP.COD_RUTINA
	ORDER BY CVRP.COD_RUTINA DESC; */ 
 /* ordena por cod_rutina */

	if( sqlca.sqlcode )
	{
		ifnTrazaHilos( modulo,&pfLog,  "en DECLARE : %s", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL OPEN curCriterioAcc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0074;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2722;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNULO;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPtoGest;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCategoria;
    sqlstm.sqhstl[2] = (unsigned long )6;
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
        ifnTrazaHilos( modulo,&pfLog, "en OPEN : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        return -1;
    }
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL FETCH curCriterioAcc INTO sthCrit ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )150;
    sqlstm.offset = (unsigned int  )2753;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)sthCrit.szCodRutina;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)sthCrit.szNomRutina;
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )31;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)sthCrit.szTipRetorno;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )2;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)sthCrit.szValRetorno;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )11;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)sthCrit.szValRango;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )11;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)sthCrit.szIndExcluye;
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )2;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)sthCrit.iDiasProrroga;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    iTotalRows = SQLROWS;
    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        ifnTrazaHilos( modulo,&pfLog, "en FETCH : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        return -1;
    }
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL CLOSE curCriterioAcc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2796;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {
        ifnTrazaHilos( modulo,&pfLog, "en CLOSE : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        return -1;
    }
    /* Inserto : informacion adicional para el log */
    strcpy(szRutinaAnterior,sthCrit.szCodRutina[0]);
    ifnTrazaHilos( modulo,&pfLog, "iTotalRows [%d]",LOG03,iTotalRows);
    for(i=0;i<iTotalRows;i++)
    {
			if( i>0 ){
			   sts = ifnInsertaCrit(&pCriteriosAux);
			   if( sts == -1 ){
			      ifnTrazaHilos( modulo,&pfLog,  "No hay memoria suficiente ", LOG01 );
			      break;
			   }
			}
			else{
				sts = ifnIniListCrit(&pCriteriosAux);
		      if( sts == -1 ){
			     ifnTrazaHilos( modulo,&pfLog,  "No hay memoria suficiente ", LOG01 );
			     return -1;
			   }
		   }
			rtrim(sthCrit.szCodRutina[i]);
			strcpy(pCriteriosAux->szCodRutina, sthCrit.szCodRutina[i]);
			rtrim(sthCrit.szNomRutina[i]);
			strcpy(pCriteriosAux->szNomRutina, sthCrit.szNomRutina[i]);
			rtrim(sthCrit.szTipRetorno[i]);
			strcpy(pCriteriosAux->szTipRetorno, sthCrit.szTipRetorno[i]);
			rtrim(sthCrit.szValRetorno[i]);
			strcpy(pCriteriosAux->szValRetorno, sthCrit.szValRetorno[i]);
			rtrim(sthCrit.szValRango[i]);
			strcpy(pCriteriosAux->szValRango, sthCrit.szValRango[i]);
			rtrim(sthCrit.szIndExcluye[i]);
			strcpy(pCriteriosAux->szIndExcluye, sthCrit.szIndExcluye[i]);
			pCriteriosAux->iDiasProrroga = sthCrit.iDiasProrroga[i];

            /* 10-10-2005 Soporte RyC PRM. Se comenta if, por Homologación de incidencia XM-200509130416  */
			/*if (TipProc == 1 && strcmp("SDCLI",pCriteriosAux->szCodRutina) == 0){
			    pCriteriosAux->iTipFuncion = 1;
			}
			else pCriteriosAux->iTipFuncion = 0;
			*/
            /****** FIN ******/
			
			
			if (strcmp(sthCrit.szCodRutina[i],szRutinaAnterior)) /* es distinta a la rutina anterior */
			{
			iCritDist++;
			strcpy(szRutinaAnterior,sthCrit.szCodRutina[i]);
			}
		 	iCrit++;
    }

    if ( sts == -1 ){
       ifnTrazaHilos( modulo,&pfLog,  "No hay memoria suficiente ", LOG01 );
       return -1;
    }
    (*pCriterios) = pCriteriosAux;
    ifnTrazaHilos( modulo,&pfLog, "Cargo %d Instancias",LOG05,iTotalRows);
    ifnTrazaHilos( modulo,&pfLog, "\t %3d Instancia(s) de Criterio(s) ",LOG05,iCrit);
    ifnTrazaHilos( modulo,&pfLog, "\t %3d Criterio(s) Distinto(s) \n",LOG05,iCritDist);
    /*fin Inserto : informacion adicional para el log *********************************************/
    return iTotalRows;
} /* fin ifnCargaCriteriosAcc */

/*==================================================================================================*/
/* Funcion que determina la fecha de ejecucion de una rutina (accion) fmto: YYYYMMDD 				    */
/*==================================================================================================*/
int ifnDetFechaEjecucionContex(FILE **ptArchLog, char *szCodAccion, char *szFecEjecucion, sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCntRows;
	int  ihCntDias;
	int  ihCodDia;
	char szhCodAccion   [6];
	char szhNvaFecha    [9];
	char szhFecEjecucion[9];
	char szhFormatoFecha[9];
	char szhDia[2];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="ifnDetFechaEjecucionContex";
struct sqlca sqlca;
FILE *pfLog = *ptArchLog;
    
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


   ifnTrazaHilos( modulo,&pfLog, "Entre en %s con Accion %s  Fecha Ejec %s ", LOG06, modulo, szCodAccion, szFecEjecucion );

   strcpy(szhCodAccion,szCodAccion);
   strcpy(szhFormatoFecha,"YYYYMMDD"); /* fmto : YYYYMMDD */
	strcpy(szhDia,"D");                            
    
	/* ve si accion tiene restricciones */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL 
   SELECT COUNT(*)  
	INTO  :ihCntRows
	FROM  CO_DIASNOEJEC
	WHERE COD_RUTINA = :szhCodAccion; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where COD_RU\
TINA=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2811;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
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

 
   if (sqlca.sqlcode) {
        ifnTrazaHilos( modulo,&pfLog, "ihCntRows en CO_DIASNOEJEC(1) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        return -1;
   }
	if (ihCntRows == 0) return 0; /* la accion se puede ejecutar cualquier dia */

   strcpy(szhNvaFecha,szFecEjecucion); /* fecha tentativa */

	while (1)
	{
    	strcpy(szhFecEjecucion,szhNvaFecha); /* verificando la nueva fecha */

		/* determina dia de la semana de la fecha  1:Domingo,2:lunes,...,7:sabado*/
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE
			BEGIN
				:ihCodDia:=TO_CHAR(TO_DATE(:szhFecEjecucion,:szhFormatoFecha),:szhDia);
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :ihCodDia := TO_CHAR ( TO_DATE ( :szhFecEjecucion , :\
szhFormatoFecha ) , :szhDia ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2834;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodDia;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDia;
  sqlstm.sqhstl[3] = (unsigned long )2;
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


    	if (sqlca.sqlcode)  {
        	ifnTrazaHilos( modulo,&pfLog, "ihCodDia en DUAL(1) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        	return -1;
    	}
    
		/* ve si accion tiene restriccion para ese dia */
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
    	/* EXEC SQL 
    	SELECT COUNT(*)  
		INTO :ihCntRows
		FROM CO_DIASNOEJEC
		WHERE COD_RUTINA = :szhCodAccion 
		AND COD_DIA = :ihCodDia; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 16;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where (COD\
_RUTINA=:b1 and COD_DIA=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2865;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
     sqlstm.sqhstl[1] = (unsigned long )6;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodDia;
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


    	if (sqlca.sqlcode)
    	{
        	ifnTrazaHilos( modulo,&pfLog, "ihCntRows en CO_DIASNOEJEC(2) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        	return -1;
    	}
    	
		if (ihCntRows == 0)  /* la accion no tiene restriccion para ese dia */
		{
			/* valida si la fecha es feriado o visperas de feriado */
			ihCodDia = ifnDetFeriadosContex(&pfLog, szhFecEjecucion, CXX); /* fmto YYYYMMDD */
			if ( ihCodDia < 0 ) 
			{
				return -1;
			}
			if ( ihCodDia > 0 ) /* es feriado o visperas de feriado */
			{
				/* valida si tiene restricciones para feriados o visperas */
				sqlca.sqlcode=0; /* XO-200508280498 rvc */
    			/* EXEC SQL 
    			SELECT COUNT(*)  
			   INTO :ihCntRows
			   FROM CO_DIASNOEJEC
			   WHERE COD_RUTINA = :szhCodAccion 
				AND COD_DIA = :ihCodDia; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 16;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select count(*)  into :b0  from CO_DIASNOEJEC where (C\
OD_RUTINA=:b1 and COD_DIA=:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )2892;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
       sqlstm.sqhstl[1] = (unsigned long )6;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&ihCodDia;
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

  /* 8 o 9 */
    			if (sqlca.sqlcode)
    			{
        			ifnTrazaHilos( modulo,&pfLog, " ihCntRows en CO_DIASNOEJEC(3) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        			return -1;
    			}
				if (ihCntRows == 0)  /* la accion no tiene restriccion para ese dia */
				{
					break; /* es una fecha valida */
				}
				else /* la accion tiene restricciones para feriados o visperas */
				{
					if ( ihCodDia == 8 ) /* visperas de feriado */
						ihCntDias = 2; /* le sumara dos dias a la fecha */
					else /* es feriado */
						ihCntDias = 1; /* le sumara un dia a la fecha */
				}
			}
			else /* no es feriado ni visperas */
			{
				break; /* es una fecha valida */
			}
		}
		else /* tiene restriccion para ese dia */
		{
			ihCntDias = 1; /* le sumara un dia a la fecha */
		}

		/* determina nueva fecha */
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE
			BEGIN
				:szhNvaFecha:=TO_CHAR((TO_DATE(:szhFecEjecucion,:szhFormatoFecha) + :ihCntDias),:szhFormatoFecha);
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :szhNvaFecha := TO_CHAR ( ( TO_DATE ( :szhFecEjecucio\
n , :szhFormatoFecha ) + :ihCntDias ) , :szhFormatoFecha ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2919;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhNvaFecha;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecEjecucion;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
  sqlstm.sqhstl[2] = (unsigned long )9;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCntDias;
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


    	if (sqlca.sqlcode)     	{
       		ifnTrazaHilos( modulo,&pfLog, " szhNvaFecha en DUAL(2) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
       		return -1;
    	}
	} /* end while */
    
    strcpy(szFecEjecucion,szhFecEjecucion);
    return 0;
} /* fin ifnDetFechaEjecucionContex */


/*==================================================================================================*/
/* Funcion que Actualiza el Estado de la accion en la Tabla														 */
/*==================================================================================================*/
int ifnUpdateEstadoAccionH(FILE **ptArchLog, long lCli, long lNSeq, char *szEst, int iAboCelu, int iAboBeep, int iMRAboCelu, int iMRAboBeep, sql_context ctxCont)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodEst[4];  
	long lhCodCli;
	long lhNumSeq;
	char szhFecDefinitiva[15]; /* EXEC SQL VAR szhFecDefinitiva IS STRING(15); */ 

	char szhFecTentativa[15] ; /* EXEC SQL VAR szhFecTentativa IS STRING(15); */ 

	int  ihAboCelu = 0;
	int  ihAboBeep = 0;
	int  ihMRAboCelu = 0;
	int  ihMRAboBeep = 0;
	char szhAccion[6]         ; /* EXEC SQL VAR szhAccion IS STRING(6); */ 

	int  ihFlgMorosos = 0;
	char szhRutina_Susun   [6]; 
	char szhRutina_Susbi   [6]; 
	char szhRutina_Bloqu   [6]; 
	char szhRutina_Desbl   [6]; 
	char szhRutina_Baja    [5]; 
	char szhFormatoFecha  [17]; 
	char szhCodProcesoEjec [5]; 
	int  iNumSesenta ;
	int  iNumVeinticuatro;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="ifnUpdateEstadoAccionH";
struct sqlca sqlca;
FILE *pfLog= *ptArchLog;

	sema_wait(&semaflock);
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "En funcion %s con estado en [%s] Cliente [%ld]",LOG05,modulo,szEst,lCli);
	
	memset(szhCodEst,'\0',sizeof(szhCodEst));
	strcpy(szhCodEst,szEst);
	strcpy(szhRutina_Susun  , "SUSUN");
	strcpy(szhRutina_Susbi  , "SUSBI");
	strcpy(szhRutina_Bloqu  , "BLOQU");
	strcpy(szhRutina_Desbl  , "DESBL");
	strcpy(szhRutina_Baja   , "BAJA");
	strcpy(szhFormatoFecha  , "YYYYMMDDHH24MISS");
	strcpy(szhCodProcesoEjec, "EJEC");
	iNumSesenta     = 60;
	iNumVeinticuatro= 24;

	lhCodCli=lCli;
	lhNumSeq=lNSeq;

	if ( !strcmp(szhCodEst,"REV") || !strcmp(szhCodEst,"RER") )   
	{
    	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
    	/* EXEC SQL 
    	UPDATE CO_ACCIONES
    	SET    COD_ESTADO    = :szhCodEst
    	WHERE  COD_CLIENTE   = :lhCodCli
    	AND    NUM_SECUENCIA = :lhNumSeq; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 16;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update CO_ACCIONES  set COD_ESTADO=:b0 where (COD_CLIENT\
E=:b1 and NUM_SECUENCIA=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2950;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodEst;
     sqlstm.sqhstl[0] = (unsigned long )4;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCli;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSeq;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	else
	{
    	ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCIONES 'EPR','EJE' :szhCodEst [%s]  cliente [%ld]",LOG05,szhCodEst,lhCodCli);  
    	
		ihAboCelu = iAboCelu;
		ihAboBeep = iAboBeep;
		ihMRAboCelu = iMRAboCelu;
		ihMRAboBeep = iMRAboBeep;
    	sqlca.sqlcode=0;
    	/* EXEC SQL 
    	UPDATE CO_ACCIONES
    	   SET COD_ESTADO   = :szhCodEst,
           	   FEC_ESTADO   = SYSDATE,
	   		   CNT_ABOCELU	= :ihAboCelu, 
	   		   CNT_ABOBEEP	= :ihAboBeep
    	 WHERE COD_CLIENTE  = :lhCodCli
    	   AND NUM_SECUENCIA = :lhNumSeq; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 16;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update CO_ACCIONES  set COD_ESTADO=:b0,FEC_ESTADO=SYSDAT\
E,CNT_ABOCELU=:b1,CNT_ABOBEEP=:b2 where (COD_CLIENTE=:b3 and NUM_SECUENCIA=:b4\
)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )2977;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodEst;
     sqlstm.sqhstl[0] = (unsigned long )4;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihAboCelu;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihAboBeep;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCli;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSeq;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	}
	
  	ifnTrazaHilos( modulo,&pfLog, "--- cliente [%ld]  sqlca.sqlcode [%d]",LOG05,lhCodCli,sqlca.sqlcode);  
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
		ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCIONES [%ld] * [%ld] - %s",LOG00,lhCodCli,lhNumSeq,sqlca.sqlerrm.sqlerrmc);  
		sema_post(&semaflock);
		return FALSE; /*==0*/
	} 
	else if( sqlca.sqlcode == SQLNOTFOUND ) {
		ifnTrazaHilos( modulo,&pfLog, "(1.-) No encontro CO_ACCIONES [%ld] [%ld] [%s].",LOG03,lhCodCli,lhNumSeq,szhCodEst);  
		sema_post(&semaflock);
		return TRUE; /*==1*/
	}


 
	ifnTrazaHilos( modulo,&pfLog, "Fin a funcion %s",LOG05, modulo);
	sema_post(&semaflock);
	return TRUE; /* !=0 */
  
}/* ============================================================================= */

/*==================================================================================================*/
/* Funcion que determina dias feriados	fmto : YYYYMMDD														    */
/*==================================================================================================*/
int ifnDetFeriadosContex(FILE **ptArchLog, char *szFecha , sql_context ctxCont) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCntRows;
	char szhFecha[9];
	char szhNvaFecha[9];
	char szhFormatoFecha[9];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="ifnDetFeriadosContex";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;
    
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

    
   strcpy(szhFecha       ,szFecha);               
   strcpy(szhFormatoFecha,"YYYYMMDD"); /* fmto : YYYYMMDD */
   ifnTrazaHilos( modulo,&pfLog, "En funcion [%s] con fecha [%s] ",LOG05,modulo,szhFecha);
    
	/* determina dia es feriado */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT COUNT(*)  
	INTO :ihCntRows
	FROM TA_DIASFEST
	WHERE FEC_DIAFEST = TO_DATE(:szhFecha,:szhFormatoFecha); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from TA_DIASFEST where FEC_DIAFES\
T=TO_DATE(:b1,:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3012;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[2] = (unsigned long )9;
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


   if (sqlca.sqlcode)  {
   	ifnTrazaHilos( modulo,&pfLog, " TA_DIASFEST(1) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
      return -1;
	}
	if (ihCntRows > 0) /* es feriado */
		return 9;
    
	/* le suma un dia a la fecha */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL EXECUTE
		BEGIN
			:szhNvaFecha:=TO_CHAR(TO_DATE(:szhFecha,:szhFormatoFecha) + 1,:szhFormatoFecha);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szhNvaFecha := TO_CHAR ( TO_DATE ( :szhFecha , :szhFo\
rmatoFecha ) + 1 , :szhFormatoFecha ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3039;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNvaFecha;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[2] = (unsigned long )9;
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


   if (sqlca.sqlcode) 	{
   	ifnTrazaHilos( modulo,&pfLog, " DUAL : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
   	return -1;
	}

	/* determina dia es visperas de feriado */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL 
   SELECT COUNT(*)  
	INTO :ihCntRows
	FROM TA_DIASFEST
	WHERE FEC_DIAFEST = TO_DATE(:szhNvaFecha,:szhFormatoFecha); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(*)  into :b0  from TA_DIASFEST where FEC_DIAF\
EST=TO_DATE(:b1,:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )3066;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntRows;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNvaFecha;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
   sqlstm.sqhstl[2] = (unsigned long )9;
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


   if (sqlca.sqlcode)  {
       	ifnTrazaHilos( modulo,&pfLog, " TA_DIASFEST(2) : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
       	return -1;
	}
	if (ihCntRows > 0) /* es visperas de feriado */
		return 8;

	return 0;
} 
/* ============================================================================= */
/*==================================================================================================*/
/* Funcion que pasa a historico a un cliente puntual parcial o totalmente									 */
/*==================================================================================================*/
BOOL bfnPasoHistoricoGeneralContex( FILE **ptArchLog, long lCodCliente, int iExclusionTotal, sql_context ctxCont )
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;                     
	int	ihCntAccPnd = 0;
	int	ihCntAccPndBaja = 0;
	char  szhBAJA    [5];
	char  szhCANUM   [6];
	char  szhEJE     [4];
	char  szhRER     [4];
	char  szhPND     [4];
	char  szhERR     [4];
	char  szhFiller  [2];
	char  szhLetra_A [2];
	char  szhLetra_R [2];
	int   ihValor_cero  = 0;
	int   ihValor_uno   = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnPasoHistoricoGeneralContex";
FILE *pfLog= *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	ifnTrazaHilos( modulo,&pfLog,"En funcion %s", LOG03, modulo);
	lhCodCliente = lCodCliente;
	strcpy(szhFiller," ");
	strcpy(szhLetra_A,"A");
	strcpy(szhLetra_R,"R");
	strcpy(szhBAJA,"BAJA");
	strcpy(szhCANUM,"CANUM");
   strcpy(szhEJE ,"EJE");
   strcpy(szhRER ,"RER");
   strcpy(szhPND ,"PND");
   strcpy(szhERR ,"ERR");
   
	if( iExclusionTotal )
	{
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT COUNT(*)
		INTO  :ihCntAccPndBaja
		FROM  CO_ACCIONES
		WHERE COD_CLIENTE = :lhCodCliente
		AND   NUM_SECUENCIA > :ihValor_cero
		AND   COD_RUTINA IN (:szhBAJA,:szhCANUM)
		AND   COD_ESTADO = :szhEJE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(*)  into :b0  from CO_ACCIONES where (((COD_CL\
IENTE=:b1 and NUM_SECUENCIA>:b2) and COD_RUTINA in (:b3,:b4)) and COD_ESTADO=:\
b5)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3093;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAccPndBaja;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[4] = (unsigned char  *)szhCANUM;
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhEJE;
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



	    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	    {
	        ifnTrazaHilos( modulo,&pfLog,"(Cliente:%ld) Contando Acciones Pendientes %s ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
	        return FALSE;
	    }

	    if( ihCntAccPndBaja != 0 )
	    	ihCntAccPndBaja = 1;

	} /* if( iExclusionTotal ) */

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT SUM( CUENTA ) 
	INTO :ihCntAccPnd
	FROM (SELECT COUNT(*) CUENTA					/o exclusion por parte del excluidor o/
	      FROM CO_RUTINAS R, CO_ACCIONES A
	      WHERE A.COD_CLIENTE = :lhCodCliente
   	   AND A.COD_ESTADO IN ( :szhEJE, :szhRER )
	      AND A.COD_RUTINA != DECODE( :ihCntAccPndBaja, :ihValor_uno, :szhBAJA, :szhFiller ) 
	      AND A.COD_RUTINA != :szhCANUM 
		   AND   A.COD_RUTINA = R.COD_RUTINA
			AND   R.TIP_RUTINA = :szhLetra_A
			AND   R.REV_RUTINA IS NOT NULL
			UNION
			SELECT COUNT(*) CUENTA					/o exclusion por parte del ejecutor o/
			FROM  CO_RUTINAS R, CO_ACCIONES A
			WHERE A.COD_CLIENTE = :lhCodCliente
			AND   A.COD_ESTADO IN ( :szhPND, :szhERR )
			AND   A.COD_RUTINA = R.COD_RUTINA
			AND   R.TIP_RUTINA = :szhLetra_R ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select sum(CUENTA) into :b0  from (select count(*)  CUENTA  \
from CO_RUTINAS R ,CO_ACCIONES A where ((((((A.COD_CLIENTE=:b1 and A.COD_ESTAD\
O in (:b2,:b3)) and A.COD_RUTINA<>DECODE(:b4,:b5,:b6,:b7)) and A.COD_RUTINA<>:\
b8) and A.COD_RUTINA=R.COD_RUTINA) and R.TIP_RUTINA=:b9) and R.REV_RUTINA is  \
not null ) union select count(*)  CUENTA  from CO_RUTINAS R ,CO_ACCIONES A whe\
re (((A.COD_CLIENTE=:b1 and A.COD_ESTADO in (:b11,:b12)) and A.COD_RUTINA=R.CO\
D_RUTINA) and R.TIP_RUTINA=:b13)) ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3132;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAccPnd;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhEJE;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhRER;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCntAccPndBaja;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhBAJA;
 sqlstm.sqhstl[6] = (unsigned long )5;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[7] = (unsigned long )2;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhCANUM;
 sqlstm.sqhstl[8] = (unsigned long )6;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhLetra_A;
 sqlstm.sqhstl[9] = (unsigned long )2;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhPND;
 sqlstm.sqhstl[11] = (unsigned long )4;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhERR;
 sqlstm.sqhstl[12] = (unsigned long )4;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_R;
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
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Contando Acciones Pendientes => [%s]. ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return FALSE;
   }

   ifnTrazaHilos( modulo,&pfLog,"Cliente => [%ld] Numero Acciones PND => [%d].", LOG03, lhCodCliente, ihCntAccPnd );

	if( ihCntAccPnd == 0 )	/* se excluye el cliente y se pasa a historicos */
	{	
	    ifnTrazaHilos( modulo,&pfLog, "Pasando Historico Acciones Cliente(%ld).", LOG03, lhCodCliente );
	    if ( !bfnPasoHistoricoAccionesContex( &pfLog, lhCodCliente ,CXX) ) 
	        return FALSE;

	    ifnTrazaHilos( modulo,&pfLog,"Pasando Historico Moroso Cliente(%ld).", LOG03, lhCodCliente );
	    if ( !bfnPasoHistoricoMorososContex( &pfLog, lhCodCliente, CXX ) ) 
	        return FALSE;

	    ifnTrazaHilos( modulo,&pfLog,"Pasando Historico Gestion Cliente(%ld).", LOG03, lhCodCliente );
	    if ( !bfnPasoHistoricoGestionContex( &pfLog, lhCodCliente, CXX ) ) 
	        return FALSE;
	} 
	else
	{
		ifnTrazaHilos( modulo,&pfLog,"Cliente [%ld], Tiene acciones pendientes o con error. No se excluye totalmente ( no paso a historicos ).\n", LOG03, lhCodCliente );
	}	/* if( iCntAccPnd == 0 ) */	
	
	return TRUE;
} /* BOOL bfnPasoHistoricoGeneralContex( long lCodCliente ) */

/*==================================================================================================*/
/* Funcion que realiza el paso a historico de las acciones														 */
/*==================================================================================================*/
BOOL bfnPasoHistoricoAccionesContex (FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente = lCliente;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="bfnPasoHistoricoAccionesContex";
FILE *pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL 
    INSERT INTO CO_HACCIONES (
           COD_CLIENTE, NUM_SECUENCIA,  COD_RUTINA,  COD_ESTADO,
           FEC_ESTADO,  FEC_EJECPROG,   NOM_USUARIO, CNT_ABOCELU,	CNT_ABOBEEP,
		     NUM_IDENT, COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC, FEC_INGRESO    )
    SELECT COD_CLIENTE, NUM_SECUENCIA,  COD_RUTINA,  COD_ESTADO,
           FEC_ESTADO,  FEC_EJECPROG,   NOM_USUARIO, CNT_ABOCELU,  CNT_ABOBEEP,
		     NUM_IDENT, COD_TIPIDENT, DEU_VENCIDA, DEU_NOVENC, FEC_INGRESO
    FROM   CO_ACCIONES 
    WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_HACCIONES (COD_CLIENTE,NUM_SECUENCIA,COD_R\
UTINA,COD_ESTADO,FEC_ESTADO,FEC_EJECPROG,NOM_USUARIO,CNT_ABOCELU,CNT_ABOBEEP,N\
UM_IDENT,COD_TIPIDENT,DEU_VENCIDA,DEU_NOVENC,FEC_INGRESO)select COD_CLIENTE ,N\
UM_SECUENCIA ,COD_RUTINA ,COD_ESTADO ,FEC_ESTADO ,FEC_EJECPROG ,NOM_USUARIO ,C\
NT_ABOCELU ,CNT_ABOBEEP ,NUM_IDENT ,COD_TIPIDENT ,DEU_VENCIDA ,DEU_NOVENC ,FEC\
_INGRESO  from CO_ACCIONES where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3203;
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


    if (sqlca.sqlcode == SQLNOTFOUND)
    {   
        ifnTrazaHilos( modulo,&pfLog,"SQLNOTFOUND al inserta en Historico de Acciones (Cliente:%ld)",LOG02,lCliente);
    }    
    else if (sqlca.sqlcode != SQLOK)
    {   
        ifnTrazaHilos( modulo,&pfLog,"al inserta en Historico de Acciones (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
        return FALSE;  
    }
    else
    {
    	sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL DELETE CO_ACCIONES 
        WHERE COD_CLIENTE = :lhCodCliente ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CO_ACCIONES  where COD_CLIENTE=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3222;
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


        if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {   
            ifnTrazaHilos( modulo,&pfLog,"al Eliminar Acciones pasadas a historico (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
            return FALSE;  
        }
    }
    return TRUE;
}

/*==================================================================================================*/
/* Funcion que ejecuta el paso a historico de un cliente moroso												 */
/*==================================================================================================*/
BOOL bfnPasoHistoricoMorososContex (FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	/* varchar szh_UsuarioCobros[31]; */ 
struct { unsigned short len; unsigned char arr[31]; } szh_UsuarioCobros;
  
 	long  lhCodCliente = lCliente;
 	char  szhUSUARIO   [15];
 	char  szhModulo     [3];
 	char  szhLetra_N    [2];
 	char  szhLetra_P    [2];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="bfnPasoHistoricoMorososContex";
FILE *pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


    strcpy(szhUSUARIO,"USUARIO_COBROS");
    strcpy(szhModulo ,"CO");
    strcpy(szhLetra_N,"N");
    strcpy(szhLetra_P,"P");
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL 
    SELECT VAL_PARAMETRO
	 INTO   :szh_UsuarioCobros
	 FROM   GED_PARAMETROS
	 WHERE  NOM_PARAMETRO = :szhUSUARIO
	 AND    COD_MODULO    = :szhModulo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3241;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&szh_UsuarioCobros;
    sqlstm.sqhstl[0] = (unsigned long )33;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhUSUARIO;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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


	
    if (sqlca.sqlcode)   {
    	ifnTrazaHilos( modulo,&pfLog,"Al recuperar parametro USUARIO_COBROS (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
    	return FALSE;    
    }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL 
    INSERT INTO CO_HMOROSOS    ( 
			  COD_CLIENTE  ,  TIP_MOROSO  ,  COD_CUENTA,
			  COD_TIPIDENT ,  NUM_IDENT   ,  FEC_INGRESO,
			  FEC_HISTORICO,  DEU_INICIAL ,  COD_AGENTE,
			  COD_PTOGEST  ,  FEC_PRORROGA,  FEC_PTOGEST,
			  ULT_PROCESO  ,  SEC_MOROSO  ,  COD_CATEGORIA,
			  COD_COMUNA   ,  FEC_DEUDVENC,  DEU_VENCIDA,
			  DEU_NOVENC   ,  COD_GESTION ,  FEC_GESTION,
			  CNT_ABOCELU  ,  CNT_ABOBEEP ,  NOM_USUARIO,	SEC_ANALISIS  )
    SELECT COD_CLIENTE  ,  DECODE(NOM_USUARIO, :szh_UsuarioCobros, :szhLetra_N, :szhLetra_P),    COD_CUENTA, 
           COD_TIPIDENT ,  NUM_IDENT   ,  FEC_INGRESO,
           SYSDATE      ,  DEU_INICIAL ,  COD_AGENTE,
           COD_PTOGEST  ,  FEC_PRORROGA,  FEC_PTOGEST,
		     ULT_PROCESO  ,  SEC_MOROSO  ,  COD_CATEGORIA,
		     COD_COMUNA   ,  FEC_DEUDVENC,  DEU_VENCIDA,
		     DEU_NOVENC   ,  COD_GESTION ,  FEC_GESTION,
		     CNT_ABOCELU  ,  CNT_ABOBEEP ,  NOM_USUARIO,	SEC_ANALISIS
    FROM   CO_MOROSOS 
    WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_HMOROSOS (COD_CLIENTE,TIP_MOROSO,COD_CUENT\
A,COD_TIPIDENT,NUM_IDENT,FEC_INGRESO,FEC_HISTORICO,DEU_INICIAL,COD_AGENTE,COD_\
PTOGEST,FEC_PRORROGA,FEC_PTOGEST,ULT_PROCESO,SEC_MOROSO,COD_CATEGORIA,COD_COMU\
NA,FEC_DEUDVENC,DEU_VENCIDA,DEU_NOVENC,COD_GESTION,FEC_GESTION,CNT_ABOCELU,CNT\
_ABOBEEP,NOM_USUARIO,SEC_ANALISIS)select COD_CLIENTE ,DECODE(NOM_USUARIO,:b0,:\
b1,:b2) ,COD_CUENTA ,COD_TIPIDENT ,NUM_IDENT ,FEC_INGRESO ,SYSDATE ,DEU_INICIA\
L ,COD_AGENTE ,COD_PTOGEST ,FEC_PRORROGA ,FEC_PTOGEST ,ULT_PROCESO ,SEC_MOROSO\
 ,COD_CATEGORIA ,COD_COMUNA ,FEC_DEUDVENC ,DEU_VENCIDA ,DEU_NOVENC ,COD_GESTIO\
N ,FEC_GESTION ,CNT_ABOCELU ,CNT_ABOBEEP ,NOM_USUARIO ,SEC_ANALISIS  from CO_M\
OROSOS where COD_CLIENTE=:b3";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3268;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&szh_UsuarioCobros;
    sqlstm.sqhstl[0] = (unsigned long )33;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhLetra_N;
    sqlstm.sqhstl[1] = (unsigned long )2;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_P;
    sqlstm.sqhstl[2] = (unsigned long )2;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode)    {   
        ifnTrazaHilos( modulo,&pfLog,"al inserta en Historico de Morosos (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
        return FALSE;   
    }
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL DELETE CO_MOROSOS 
    WHERE COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from CO_MOROSOS  where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3299;
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

 
    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )    {   
        ifnTrazaHilos( modulo,&pfLog,"al Eliminar Morosos pasados a historico (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
        return FALSE ; 
    }
  
	 if( !bfnFindNewCodGestionContex( &pfLog, lCliente, 1 , CXX) )	/* intenta dejar cliente como "CO" en Abocel y Abobeep */
        return FALSE;

    return TRUE;
}

/*==================================================================================================*/
/* Funcion que ejecuta el paso a historico la gestion de un cliente 										    */
/*==================================================================================================*/
BOOL bfnPasoHistoricoGestionContex (FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente = lCliente;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="bfnPasoHistoricoGestion";
FILE *pfLog= *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL 
    INSERT INTO CO_HGESTION  (
           COD_CLIENTE, COD_CUENTA,  COD_TIPIDENT, NUM_IDENT,
           COD_GESTION, FEC_GESTION, OBS_GESTION,  NOM_USUARIO    )
    SELECT COD_CLIENTE, COD_CUENTA,  COD_TIPIDENT, NUM_IDENT,
           COD_GESTION, FEC_GESTION, OBS_GESTION,  NOM_USUARIO
    FROM   CO_GESTION
    WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_HGESTION (COD_CLIENTE,COD_CUENTA,COD_TIPID\
ENT,NUM_IDENT,COD_GESTION,FEC_GESTION,OBS_GESTION,NOM_USUARIO)select COD_CLIEN\
TE ,COD_CUENTA ,COD_TIPIDENT ,NUM_IDENT ,COD_GESTION ,FEC_GESTION ,OBS_GESTION\
 ,NOM_USUARIO  from CO_GESTION where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3318;
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


    
    if (sqlca.sqlcode == SQLNOTFOUND)  {
        ifnTrazaHilos( modulo,&pfLog,"SQLNOTFOUND al inserta en Historico de Gestion (Cliente:%ld)",LOG02,lCliente);
    }
    else if ( sqlca.sqlcode != SQLOK )
    {   
        ifnTrazaHilos( modulo,&pfLog,"al inserta en Historico de Gestion (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
        return FALSE;   
    }
    else
    {
    	sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL DELETE CO_GESTION 
        WHERE COD_CLIENTE = :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CO_GESTION  where COD_CLIENTE=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3337;
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

 
        
        if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {   
            ifnTrazaHilos( modulo,&pfLog,"al Eliminar Gestiones pasadas a historico (Cliente:%ld) %s",LOG00,lCliente,sqlca.sqlerrm.sqlerrmc);
            return FALSE;  
        }
    }
    
    return TRUE;
}

/*==================================================================================================*/
/* Funcion que Tiene por finalidad determinar que COD_GESTION, le corresponde al cliente examinado. */
/* Esta habilitada para el proceso ejecutor y excluidor								                      */
/*==================================================================================================*/
BOOL bfnFindNewCodGestionContex( FILE **ptArchLog, long lCodCliente, int iIndExcluye, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	char	szhCodGestion[3] = "";		/* EXEC SQL VAR szhCodGestion IS STRING(3); */ 

	char	szhCodRutina[6] = "";		/* EXEC SQL VAR szhCodRutina IS STRING(6); */ 

	int	ihCntAboCelu = 0;
	int	ihCntAboBeep = 0;
	int	ihCntSumAbo  = 0;
	char  szhBAA       [4];
   char  szhLetra_A   [2];
	char  szhEJE       [4];
	char  szhRER       [4];
	char  szhNum90     [3];
	char  szhNum43     [3];
	char  szhNum44     [3];
	int   ihValor_cero = 0;
	int   ihValor_tres = 3;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnFindNewCodGestionContex";
struct sqlca sqlca;
FILE *pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	ifnTrazaHilos( modulo,&pfLog,"Ingresando modulo %s.", LOG05, modulo );
    
   memset( szhCodGestion, '\0', sizeof( szhCodGestion ) );
   strcpy( szhCodGestion, "NN" );
   strcpy(szhBAA,"BAA");
   strcpy(szhLetra_A,"A");
   strcpy(szhEJE,"EJE");
   strcpy(szhRER,"RER"); 
   strcpy(szhNum90,"90");
   strcpy(szhNum43,"43");
   strcpy(szhNum44,"44");

	lhCodCliente = lCodCliente;
   ifnTrazaHilos( modulo,&pfLog,"Parametros entrada modulo %s.\tlCliente     = [%ld].",LOG05, modulo, lhCodCliente );
    
   /*-Obtiene la Cantidad de Abonados Celulares del Cliente-*/            
   sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	:ihCntAboCelu
	FROM	GA_ABOCEL
	WHERE	COD_CLIENTE    = :lhCodCliente
	AND	COD_SITUACION != :szhBAA
	AND	COD_USO       != :ihValor_tres; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL where ((COD_CLIENT\
E=:b1 and COD_SITUACION<>:b2) and COD_USO<>:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3356;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAboCelu;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_tres;
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



	if( sqlca.sqlcode ) {
		ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) GA_ABOCEL : %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
      return FALSE;
	}

	/*-Obtiene la Cantidad de Abonados Beeper del Cliente-*/            
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	 :ihCntAboBeep
	FROM	 GA_ABOBEEP
	WHERE	 COD_CLIENTE    = :lhCodCliente
	AND	 COD_SITUACION != :szhBAA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOBEEP where (COD_CLIENT\
E=:b1 and COD_SITUACION<>:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3387;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntAboBeep;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode ) {
		ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) GA_ABOBEEP : %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
      return FALSE;
	}

	/*-Obtiene el codigo de gestion a asignar al cliente-*/            
	if( ihCntAboCelu + ihCntAboBeep == 0 ) 
	{ 	    
		/*-Si el cliente no tiene abonados celulares o beeper asigna cod_gestion = 'SA'-*/ 
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL 
		SELECT SUM(CUENTA)
		INTO	 :ihCntSumAbo
		FROM  (SELECT COUNT(*) AS CUENTA
				 FROM   GA_ABOCEL
				 WHERE  COD_CLIENTE = :lhCodCliente
				 AND 	  COD_USO != :ihValor_tres
				 UNION
				 SELECT COUNT(*) AS CUENTA
				 FROM   GA_ABOBEEP
				 WHERE  COD_CLIENTE = :lhCodCliente ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select sum(CUENTA) into :b0  from (select count(*)  CUENTA \
 from GA_ABOCEL where (COD_CLIENTE=:b1 and COD_USO<>:b2) union select count(*)\
  CUENTA  from GA_ABOBEEP where COD_CLIENTE=:b1) ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )3414;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSumAbo;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_tres;
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


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) ERROR, Contando abonados y beepers del Cliente : %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
	      return FALSE;
		}

      if ( ihCntSumAbo == 0 )   {
	    	strcpy( szhCodGestion, "SA" );
		}
		else
		{
			/*-Si el cliente solo tiene abonados celulares o beeper de baja y alguno -*/
			/*-en cod_causabaja in( '90','43','44') asigna cod_gestion = 'CF'-*/ 
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT	SUM(CUENTA)
			INTO	:ihCntSumAbo
			FROM  ( 	SELECT COUNT(*) AS CUENTA
						FROM   GA_ABOCEL
						WHERE  COD_CLIENTE   = :lhCodCliente
						AND 	 COD_SITUACION = :szhBAA
						AND 	 COD_USO      != :ihValor_tres
						AND    COD_CAUSABAJA IN ( :szhNum90,:szhNum43,:szhNum44) 
						UNION
						SELECT COUNT(*) AS CUENTA
						FROM 	 GA_ABOBEEP
						WHERE  COD_CLIENTE   = :lhCodCliente
						AND 	 COD_SITUACION = :szhBAA
						AND    COD_CAUSABAJA IN ( :szhNum90,:szhNum43,:szhNum44)); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select sum(CUENTA) into :b0  from (select count(*)  CUENTA\
  from GA_ABOCEL where (((COD_CLIENTE=:b1 and COD_SITUACION=:b2) and COD_USO<>\
:b3) and COD_CAUSABAJA in (:b4,:b5,:b6)) union select count(*)  CUENTA  from G\
A_ABOBEEP where ((COD_CLIENTE=:b1 and COD_SITUACION=:b2) and COD_CAUSABAJA in \
(:b4,:b5,:b6))) ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )3445;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSumAbo;
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
   sqlstm.sqhstl[2] = (unsigned long )4;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_tres;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNum90;
   sqlstm.sqhstl[4] = (unsigned long )3;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhNum43;
   sqlstm.sqhstl[5] = (unsigned long )3;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhNum44;
   sqlstm.sqhstl[6] = (unsigned long )3;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhBAA;
   sqlstm.sqhstl[8] = (unsigned long )4;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhNum90;
   sqlstm.sqhstl[9] = (unsigned long )3;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhNum43;
   sqlstm.sqhstl[10] = (unsigned long )3;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhNum44;
   sqlstm.sqhstl[11] = (unsigned long )3;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
					   							
			if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND) 
			{
				ifnTrazaHilos( modulo,&pfLog,"(Cli:%ld) ERROR, Contando abonados y beepers en Baja del Cliente : %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
		      return FALSE;
			}
    
			if ( ihCntSumAbo > 0 ) 
				strcpy( szhCodGestion, "CF" );
			else 
				/*-Si el cliente no cumple ninguna de las condiciones anteriores asigna cod_gestion = 'BA'-*/ 
				strcpy( szhCodGestion, "BA" );
	    } 
	} /* if ( ihCntAboCelu + ihCntAboBeep > 0 ) */
	
	/* si no cumplio criterios anteriores */
	if( !strcmp( szhCodGestion, "NN" ) ) 
	{
		if( iIndExcluye )	/* LO ESTOY EXCLUYENDO, Esta pasando a historico y saliendo de morosos */
		{
			strcpy( szhCodGestion, "MR" );
		}
		else	
		{
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT R.COD_RUTINA, R.COD_GESTION
			INTO	 :szhCodRutina,
					 :szhCodGestion
			FROM	 CO_RUTINAS R
			WHERE	 R.TIP_RUTINA = :szhLetra_A
			AND	 R.COD_GESTION IS NOT NULL
			AND	 R.ORD_APLICACION = (SELECT	MIN( RR.ORD_APLICACION )
											   FROM	CO_RUTINAS RR, CO_ACCIONES CO
											   WHERE	CO.COD_CLIENTE = :lhCodCliente
											   AND		CO.NUM_SECUENCIA > :ihValor_tres
											   AND		CO.COD_ESTADO IN ( :szhEJE, :szhRER )		
											   AND		CO.COD_RUTINA = RR.COD_RUTINA
											   AND		RR.TIP_RUTINA = :szhLetra_A
											   AND		RR.COD_GESTION IS NOT NULL ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select R.COD_RUTINA ,R.COD_GESTION into :b0,:b1  from CO_R\
UTINAS R where ((R.TIP_RUTINA=:b2 and R.COD_GESTION is  not null ) and R.ORD_A\
PLICACION=(select min(RR.ORD_APLICACION)  from CO_RUTINAS RR ,CO_ACCIONES CO w\
here (((((CO.COD_CLIENTE=:b3 and CO.NUM_SECUENCIA>:b4) and CO.COD_ESTADO in (:\
b5,:b6)) and CO.COD_RUTINA=RR.COD_RUTINA) and RR.TIP_RUTINA=:b2) and RR.COD_GE\
STION is  not null )))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )3508;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodRutina;
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestion;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_A;
   sqlstm.sqhstl[2] = (unsigned long )2;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_tres;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhEJE;
   sqlstm.sqhstl[5] = (unsigned long )4;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhRER;
   sqlstm.sqhstl[6] = (unsigned long )4;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_A;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
		    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		    {
		        ifnTrazaHilos( modulo,&pfLog, "Cliente: [%ld] Al recuperar Codigo de Gestion (1) %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		        return FALSE;
		    }
		 
		    if( !strcmp( szhCodGestion, "NN" ) ) 
		    {
       		  strcpy( szhCodGestion, "MR" );
		        ifnTrazaHilos( modulo,&pfLog, "Cliente [%ld]. No se encontro Codigo de Gestion NN. , se asigna 'MR'.", LOG05, lhCodCliente );
		    }
		} /* if( iIndExcluye ) */ 
	} /* if( strcmp( szhCodGestion, "NN" ) ) */

    ifnTrazaHilos( modulo,&pfLog, "1. Cliente:'%ld' Nuevo Cod_Gestion = [%s]", LOG03, lhCodCliente, szhCodGestion );
	 /* EXEC SQL CONTEXT USE :CXX; */ 


	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE CO_MOROSOS  SET		
           COD_GESTION = :szhCodGestion,
			  FEC_GESTION = SYSDATE 
    WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_MOROSOS  set COD_GESTION=:b0,FEC_GESTION=SYSDAT\
E where COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3555;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de CO_MOROSOS del Cliente:'%ld' Cod_estado:'%s' > %s",LOG00,lhCodCliente,szhCodGestion,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }

    strcpy( szhCodGestion,( ( !strcmp( szhCodGestion, "MR" ) ) ? "CO" : szhCodGestion ) );	/* en la Morosos no va CO, va MR */

    /* Aqui actualizar el IND_SITUACION de la GE_CLIENTES con el COD_GESTION de la CO_PTOSGESTION */
    /* XO-200508260480 Soporte RyC 26-08-2005 */
	 /* EXEC SQL CONTEXT USE :CXX; */ 

	 sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE GE_CLIENTES  SET		
           IND_SITUACION = :szhCodGestion
    WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GE_CLIENTES  set IND_SITUACION=:b0 where COD_CLIEN\
TE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3578;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de GE_CLIENTES del Cliente:'%ld' Ind_situacion:'%s' > %s" ,LOG00,lhCodCliente,szhCodGestion,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }

    /* Aqui actualizar el COD_ESTADO de la GA_ABOCEL y la GA_ABOBEEP con el COD_GESTION de la CO_PTOSGESTION */
	 /* EXEC SQL CONTEXT USE :CXX; */ 

	 sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE GA_ABOCEL  SET		
           COD_ESTADO  = :szhCodGestion
    WHERE  COD_CLIENTE = :lhCodCliente
    AND	  COD_USO    != :ihValor_tres; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GA_ABOCEL  set COD_ESTADO=:b0 where (COD_CLIENTE=:\
b1 and COD_USO<>:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3601;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_tres;
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


    
    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de GA_ABOCEL del Cliente:'%ld' Cod_estado:'%s' > %s" ,LOG00,lhCodCliente,szhCodGestion,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }

	 /* EXEC SQL CONTEXT USE :CXX; */ 

	 sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL
    UPDATE	GA_ABOBEEP
    SET		COD_ESTADO = :szhCodGestion
    WHERE	COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GA_ABOBEEP  set COD_ESTADO=:b0 where COD_CLIENTE=:\
b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3628;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )    {
        ifnTrazaHilos( modulo,&pfLog, "Update de GA_ABOBEEP del Cliente:'%ld' Cod_estado:'%s' > %s",LOG00,lhCodCliente,szhCodGestion,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }

    ifnTrazaHilos( modulo,&pfLog, "Fin a funcion [%s]", LOG05, modulo);
    return TRUE;
} /* BOOL bfnFindNewCodGestion( long lCodCliente, int iIndExcluye ) */

/* ============================================================================= */
/* Funcion que inserta datos estadisticos del proceso y los hilos                */
/* ============================================================================= */
int ifnInsertaEstadisticasContex( FILE **ptArchLog, int piSecuencia , char *pszProceso, sql_context ctxCont )
{	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihSecuencia;
		char 	szhProceso [6] ;
		int	ihSecProceso;
		sql_context CXX;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	char modulo[] = "ifnInsertaEstadisticasContex";
	struct sqlca sqlca;
	FILE *pfLog = *ptArchLog;
	
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ihSecuencia = piSecuencia;
	sprintf(szhProceso,"%s\0",pszProceso);
	ifnTrazaHilos( modulo,&pfLog, "\n\tInsertando Estadistica. Proceso [%s]   Secuencia [%03d]", LOG03, szhProceso, piSecuencia );
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	INSERT INTO CO_ESTADISEVA_TO
			 (COD_PROCESO , FEC_INGRESO , SECUENCIA)
	VALUES (:szhProceso , SYSDATE     , :ihSecuencia); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_ESTADISEVA_TO (COD_PROCESO,FEC_INGRESO,SECUEN\
CIA) values (:b0,SYSDATE,:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3651;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[0] = (unsigned long )6;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihSecuencia;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	
	{
		ifnTrazaHilos( modulo,&pfLog, "INSERT INTO CO_ESTADISEVA_TO  -  %s.", LOG01, SQLERRM );  
		return -1;
	}	
	ifnTrazaHilos( modulo,&pfLog, "Fin a %s", LOG03, modulo );

	return 0;
}/* fin ifnInsertaEstadisticas */

/*==================================================================================================*/
/* Funcion que Ejecuta criterios para determinar si el cliente debe ser considerado dentro de un    
   punto de gestion dado. 																									 
   Parametros :	pRutina  		Puntero a lista con criterios a evaluar.
				lCodCliente 	Codigo de cliente a ser evaluado.
				iMaxDiasPro		Numero maximo de dias prorroga.									          */
/*==================================================================================================*/
int ifnEjecutaCriteriosEvContex ( FILE **ptArchLog, lista_Crit pRutina, struct stCliente stMR, int *iMaxDiasPro , sql_context ctxCont )
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int     ihOkFecha=0;  
		/* VARCHAR vRET[6]; */ 
struct { unsigned short len; unsigned char arr[6]; } vRET;

		char    szhRet[6] = "";
		/* VARCHAR vRETORNO[11]; */ 
struct { unsigned short len; unsigned char arr[11]; } vRETORNO;
 
/*		char    szhRetorno[11] = "";    Requerimiento Soporte RyC. - 27.07.2007 - Ticket 42058 - COL */
		char    szhRetorno[18] = ""; 
		char    szStringRango[11] = "";
/*		char    szStringRetorno[11] = "";   Requerimiento Soporte RyC. - 27.07.2007 - Ticket 42058 - COL */
		char    szStringRetorno[18] = "";  
		long    lhCodCliente = 0;
		long    nCOD_CLIENTE;
		char    szhQuery[201] = "";
		char    szhNomRutina [31];
		sql_context CXX;
	/* EXEC SQL END DECLARE SECTION; */ 


	char	modulo[] = "ifnEjecutaCriteriosEvContex";
	int		k, iSigCrit = 0, l, iRetornoEvaluado, ilong = 0;
	int 	ihMaxProrroga = 0;             /* Maximo Dias de Prorroga */
	char	szCriterio[6] = "", szCriterioAnterior[6] = ""; 
	lista_Crit pRutinaAux = NULL, pRutinaRango = NULL;
	struct sqlca sqlca;
	FILE *pfLog = *ptArchLog;
	
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	pRutinaAux = pRutina;
	lhCodCliente = stMR.lCod_Cliente;

    /* XO-200510100830 11.10.2005 Soporte RyC PRM.*/
	/* iCumpleCriterio = 0;  XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
	
	/*- revisa 1 a 1 los Criterios del Punto de Gestion -*/
	ifnTrazaHilos(modulo, &pfLog, "Entrando a funcion [%s]",LOG05,modulo);
    ifnTrazaHilos(modulo, &pfLog, "iCumpleCriterio  [%d]",LOG05,iCumpleCriterio);  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
      
	while( pRutinaAux != NULL ){
		memset(szCriterio, 0, sizeof(szCriterio));
		strcpy(szCriterio, pRutinaAux->szCodRutina);
		strcpy(szhNomRutina,pRutinaAux->szNomRutina);
		
		ifnTrazaHilos(modulo, &pfLog, "k:[%d]-Criterio:[%s]",LOG06,k,szCriterio);
	
		/* Si es el mismo criterio anterior */
		if (strcmp(szCriterio, szCriterioAnterior) != 0){/* Lo Saltamos, porque la vuelta anterior ya lo evaluamos */

		   /* Seteamos el Criterio anterior para la siguiente vuelta */
		   strcpy(szCriterioAnterior, szCriterio);
	      /* Inicio Ejecucion del criterio */

          /*10-10-2005 Soporte RyC PRM. Homologación de incidencia XM-200509130416 */
          pRutinaAux->iTipFuncion = 0;
    	  ifnTrazaHilos(modulo, &pfLog, "*******  pRutinaAux->iTipFuncion [%d]",LOG05,pRutinaAux->iTipFuncion);
          /***** FIN *****/
          
		   if (pRutinaAux->iTipFuncion == 0){
				sprintf( szhQuery," BEGIN :vRET := CO_CRITERIOS_PG.%s(:nCOD_CLIENTE,:vRETORNO); END;\0" ,szhNomRutina);
				ifnTrazaHilos(modulo, &pfLog, "Query:\n%s",LOG05,szhQuery);
				
				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL PREPARE S FROM :szhQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3674;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
    sqlstm.sqhstl[0] = (unsigned long )201;
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


				if (SQLCODE){   
					ifnTrazaHilos( modulo, &pfLog, " en PREPARE : %s", LOG00, SQLERRM );
			    	return -1; /*Mail*/   
				}

				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL EXECUTE S USING :szhRet, :lhCodCliente, :szhRetorno; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3693;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhRetorno;
    sqlstm.sqhstl[2] = (unsigned long )18;
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


				if (SQLCODE){   
					ifnTrazaHilos( modulo, &pfLog, " en EXECUTE : %s", LOG00, SQLERRM );
				    return -1; /*Mail*/   
				}
			
			} else {
				strcpy(szhRet,"OK");
				sprintf( szhRetorno, "%.f", stMR.dSaldo_Vencido); /* sin decimales */
			}	
		   	rtrim(szhRet);
		   	rtrim(szhRetorno);
			ifnTrazaHilos(modulo, &pfLog, "Resultado del criterio %s :[%s]",LOG05, szCriterio, szhRet);
		   
	      /* Fin Ejecucion del criterio */
		   if ( strcmp(szhRet,"OK") != 0 ){   
				return 0; /* No evalua mas. SE EXCLUYE EL CLIENTE */
		   }
		   else { /* El criterio se ejecuto con exito */ /*ifnEvaluaRespuestaCriterio*/
				pRutinaRango = pRutinaAux; /* guarda la posicion de la lista de rutinas donde estoy evaluando el criterio */
				iRetornoEvaluado=0; /* aun no lo evaluo */
				ifnTrazaHilos(modulo, &pfLog, "Crit:'%s'  TipRet:'%s'  ValRet :'%s' ", LOG05, szCriterio, pRutinaRango->szTipRetorno, szhRetorno );
				
				iSigCrit = 0;
				while ( ( pRutinaRango != NULL ) && (iSigCrit == 0) &&
				( !strcmp(pRutinaRango->szCodRutina,szCriterio) ) ) /* mientras sea el mismo criterio */
				{
					/* limpia las variables */
					memset(szStringRango,'\0',sizeof(szStringRango));
					memset(szStringRetorno,'\0',sizeof(szStringRetorno));
				
					strcpy( szStringRetorno, pRutinaRango->szValRetorno );
					strcpy( szStringRango, pRutinaRango->szValRango );
					
					ifnTrazaHilos( modulo, &pfLog, "\t\tRetorno:[%s]-Rango:[%s]", LOG06, szStringRetorno, szStringRango );
					
					if ( !strcmp(szStringRango,"NULO") ) /* Si no hay rango */
					{
						if ( !strcmp(pRutinaRango->szTipRetorno,"N") ) /* Si los valores esperados son de tipo numerico */
						{
							if (atof(szhRetorno) == atof(szStringRetorno))
							{ 
								ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] Ok Cumple con el valor esperado "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 1;
							}
							else
							{
								ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] NO Cumple con el valor esperado "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 0;
							}
						}
						else if ( !strcmp(pRutinaRango->szTipRetorno,"D") )
						{
							sqlca.sqlcode=0; /* XO-200508280498 rvc */
							/* EXEC SQL 
							SELECT 1  INTO :ihOkFecha
							FROM   DUAL 
							WHERE  TO_DATE(:szhRetorno,'DDMMYY') = TO_DATE(:szStringRetorno,'DDMMYY'); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 16;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select 1 into :b0  from DUAL where TO_DATE(:b1,'DDMMYY\
')=TO_DATE(:b2,'DDMMYY')";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )3720;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihOkFecha;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhRetorno;
       sqlstm.sqhstl[1] = (unsigned long )18;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szStringRetorno;
       sqlstm.sqhstl[2] = (unsigned long )18;
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



							if (SQLCODE == SQLNOTFOUND) 
								ihOkFecha = 0; /* No se cumplio la condicion, la fecha es incorrecta */
							else if (SQLCODE)                    
								ihOkFecha = 0; /* Hubo un error, asumo que la fecha es incorrecta */
						
							if ( ihOkFecha == 1 ) /* Si retorno el valor esperado */
							{ 
								ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] OK es la fecha esperada "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 1;
							}
							else
							{
								ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] NO es la fecha esperada "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 0;
							}
						}
						else /* SON STRING(CARACTERES) */
						{   
							if ( strcmp(szhRetorno,szStringRetorno)==0 ) /* Si retorno el valor esperado */
							{ 
								iRetornoEvaluado = 1;
							}
							else
							{
								iRetornoEvaluado = 0;
							}
						}
					}
					else /*Si hay rango, comparar between */
					{
						if ( !strcmp(pRutinaRango->szTipRetorno,"N") ) /* Si los valores esperados son de tipo numerico */
						{
							if ( ( atof(szhRetorno) >= atof(szStringRetorno) )
							&& ( atof(szhRetorno) <= atof(szStringRango) ) ) /* Si retorno un valor between el rango */
							{ 
								ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] OK esta dentro del rango.",
								LOG05, szStringRetorno, szStringRango, pRutinaRango->szIndExcluye, pRutinaRango->iDiasProrroga );

								iRetornoEvaluado = 1;
							}
							else
							{
								ifnTrazaHilos(modulo, &pfLog, "[%s],[%s],[%s],[%d] NO esta dentro del rango "
								,LOG05,szStringRetorno,szStringRango,pRutinaRango->szIndExcluye,pRutinaRango->iDiasProrroga);

								iRetornoEvaluado = 0;
							}
						}
						else if ( !strcmp(pRutinaRango->szTipRetorno,"D") ) /* si los valores esperados son de tipo date */
						{
							sqlca.sqlcode=0; /* XO-200508280498 rvc */
							/* EXEC SQL 
							SELECT 1 INTO :ihOkFecha
							FROM   DUAL 
							WHERE  TO_DATE(:szhRetorno,'DDMMYY') BETWEEN TO_DATE(:szStringRetorno,'DDMMYY')
							AND    TO_DATE(:szStringRango,'DDMMYY'); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 16;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select 1 into :b0  from DUAL where TO_DATE(:b1,'DDMMYY\
') between TO_DATE(:b2,'DDMMYY') and TO_DATE(:b3,'DDMMYY')";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )3747;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihOkFecha;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhRetorno;
       sqlstm.sqhstl[1] = (unsigned long )18;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szStringRetorno;
       sqlstm.sqhstl[2] = (unsigned long )18;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)szStringRango;
       sqlstm.sqhstl[3] = (unsigned long )11;
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


							
							if (SQLCODE == SQLNOTFOUND) 
								ihOkFecha = 0; /* No se cumplio la condicion, la fecha esta en el rango */
							else if (SQLCODE)                    
								ihOkFecha = 0; /* Hubo un error, asumo que la fecha no esta en el rango */
							
							if ( ihOkFecha == 1 ) /* Si retorno el valor esperado */
							{ 
								iRetornoEvaluado = 1;
							}
							else
							{
								iRetornoEvaluado = 0;
							}
						}
						else /* si los valores esperados son de tipo STRING (CARACTERES) */
						{
							ifnTrazaHilos(modulo, &pfLog, "ERROR : para 'String' no puede estar definido un rango de valores",LOG05);

							iRetornoEvaluado = 0;
						} 
					}
					
					if (iRetornoEvaluado == 1) /* valor de retorno coincide con lo que se esperaba */
					{
						if (!strcmp(pRutinaRango->szIndExcluye,"S")) /* Si debe excluirse */
						{
							iCumpleCriterio++;  /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
							ifnTrazaHilos(modulo, &pfLog, "SE EXCLUYE EL CLIENTE",LOG05);
							ifnTrazaHilos(modulo, &pfLog, "iCumpleCriterio [%d]\n",LOG05, iCumpleCriterio); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */

							return 0; /* No evalua mas. SE EXCLUYE EL CLIENTE */
						}
						else 
						{
							ifnTrazaHilos(modulo, &pfLog, "SE PRORROGA LA ACCION",LOG05);

							if (pRutinaRango->iDiasProrroga > ihMaxProrroga) /* No se excluye, verifica dias de prorroga */
							{
								ihMaxProrroga = pRutinaRango->iDiasProrroga; /* Guarda la Maxima Prorroga */ 
								iSigCrit = 1;  /* sale de este ciclo , pero continua evaluando el siguiente criterio */
							}
							else
							{
								iSigCrit = 1;  /* sale de este ciclo , pero continua evaluando el siguiente criterio */
							}
						}
					}
					else /* valor de retorno no coincide con lo que se esperaba */
					{
						ifnTrazaHilos(modulo, &pfLog, "Verificar el sgte valor esperado... ",LOG05);
					}
					pRutinaRango= pRutinaRango->sig; /* verifica el valor de la siguiente rutina */
				
				}/*end while pRutinaRango*/
				
				ifnTrazaHilos(modulo, &pfLog, "No hay mas valores que verificar ",LOG05);
				
				if (iRetornoEvaluado == 0) 
				{
					ifnTrazaHilos(modulo, &pfLog, "No se cumplio este criterio ",LOG05);
					
					/* Prorroga == 0 y ejecuta accion */            
				}    
		   }
		} /*if (strcmp(szCriterio, szCriterioAnterior) != 0)*/	

		/* Evalua el Siguiente Criterio */
		ifnTrazaHilos(modulo, &pfLog, "Evalua el sgte criterio ",LOG05);
		
		pRutinaAux = pRutinaAux->sig;
    } /*fin while Verificacion de Criterios*/

		ifnTrazaHilos(modulo, &pfLog, "[Log Hilos]No hay mas Criterios.",LOG05);
		ifnTrazaHilos(modulo, &pfLog, "iCumpleCriterio [%d]\n",LOG05, iCumpleCriterio); /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
    
    *iMaxDiasPro = ihMaxProrroga; 
    /*return 1;*/
    /*return -99;  * XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200506101454 */
    
     /* XO-200508090319  09-08-2005. Soporte RyC PRM. Homologación de incidencia TM-200507181494 */
     if (iCumpleCriterio == 0)
         return -99;
     else
         return 1;
     /* FIN XO-200508090319 */    
    
} /* FIN ifnEjecutaCriteriosEvContex() */

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
