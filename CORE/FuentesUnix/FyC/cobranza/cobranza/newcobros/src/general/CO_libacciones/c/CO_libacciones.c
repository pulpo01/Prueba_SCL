
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
    "./pc/CO_libacciones.pc"
};


static unsigned int sqlctx = 221149059;


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

 static const char *sq0002 = 
"select COD_CLIENTE  from GE_CLIENTES where (COD_TIPIDENT=:b0 and NUM_IDENT=:\
b1)           ";

 static const char *sq0007 = 
"select  /*+  AK_GE_CLIENTE_IDENTIFICACION  +*/ A.COD_CLIENTE ,C.COD_REGION  \
from GE_DIRECCIONES C ,GA_DIRECCLI B ,GE_CLIENTES A where ((((A.NUM_IDENT=:b0 \
and A.COD_TIPIDENT=:b1) and B.COD_CLIENTE=A.COD_CLIENTE) and B.COD_TIPDIRECCIO\
N=:b2) and C.COD_DIRECCION=B.COD_DIRECCION)           ";

 static const char *sq0044 = 
"select  /*+ index(ICC_PENALIZACION,PK_ICC_PENALIZACION) +*/ COD_SERVICIO ,CO\
D_NIVEL ,COD_NIVEL_REA  from ICC_PENALIZACION where ((NUM_ABONADO=:b0 and COD_\
SUSPREHA=:b1) and COD_MODULO=:b2)           ";

 static const char *sq0078 = 
"select COD_SERVSUPL ,COD_NIVEL  from GA_SERVSUPLABO where (NUM_ABONADO=:b0 a\
nd (IND_ESTADO<3 or IND_ESTADO=5))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,118,0,4,48,0,0,4,3,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
36,0,0,2,90,0,9,114,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
59,0,0,2,0,0,13,125,0,0,1,0,0,1,0,2,3,0,0,
78,0,0,2,0,0,15,156,0,0,0,0,0,1,0,
93,0,0,3,286,0,4,208,0,0,7,6,0,1,0,1,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,1,5,0,0,
136,0,0,4,271,0,4,228,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,
175,0,0,5,272,0,4,247,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,
214,0,0,6,83,0,4,293,0,0,3,1,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,
241,0,0,7,286,0,9,367,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,
268,0,0,7,0,0,13,378,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
291,0,0,7,0,0,15,405,0,0,0,0,0,1,0,
306,0,0,8,0,0,17,526,0,0,1,1,0,1,0,1,97,0,0,
325,0,0,8,0,0,21,535,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
352,0,0,9,241,0,4,551,0,0,12,11,0,1,0,1,97,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
415,0,0,10,0,0,17,589,0,0,1,1,0,1,0,1,97,0,0,
434,0,0,10,0,0,21,597,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
465,0,0,11,265,0,4,629,0,0,10,8,0,1,0,1,97,0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
520,0,0,12,267,0,4,651,0,0,10,8,0,1,0,1,97,0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
575,0,0,13,86,0,4,703,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
602,0,0,14,0,0,17,734,0,0,1,1,0,1,0,1,97,0,0,
621,0,0,14,0,0,21,743,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,
660,0,0,15,86,0,5,754,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
683,0,0,16,0,0,17,782,0,0,1,1,0,1,0,1,97,0,0,
702,0,0,16,0,0,21,792,0,0,5,5,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
737,0,0,17,431,0,4,846,0,0,6,5,0,1,0,2,97,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
776,0,0,18,59,0,5,874,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
799,0,0,19,59,0,5,915,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
822,0,0,20,197,0,4,960,0,0,4,3,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
853,0,0,21,192,0,4,1010,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
880,0,0,22,117,0,4,1075,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
911,0,0,23,132,0,4,1146,0,0,5,4,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
946,0,0,24,55,0,2,1188,0,0,1,1,0,1,0,1,3,0,0,
965,0,0,25,123,0,4,1249,0,0,4,3,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
996,0,0,26,123,0,4,1260,0,0,4,3,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1027,0,0,27,111,0,4,1317,0,0,4,3,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1058,0,0,28,174,0,4,1410,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
1093,0,0,29,278,0,4,1429,0,0,11,10,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
1152,0,0,30,256,0,4,1451,0,0,10,9,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
1207,0,0,31,221,0,3,1627,0,0,8,8,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1,3,0,0,1,5,0,0,1,5,0,0,
1254,0,0,32,87,0,6,1646,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
1281,0,0,33,201,0,3,1671,0,0,8,8,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1,3,0,0,1,5,0,0,1,5,0,0,
1328,0,0,34,61,0,5,1698,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
1351,0,0,35,79,0,4,1711,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
1374,0,0,36,51,0,4,1727,0,0,1,0,0,1,0,2,3,0,0,
1393,0,0,37,51,0,4,1740,0,0,1,0,0,1,0,2,3,0,0,
1412,0,0,38,562,0,3,1751,0,0,33,33,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1559,0,0,39,562,0,3,1783,0,0,33,33,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1706,0,0,40,546,0,3,1818,0,0,32,32,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1849,0,0,41,496,0,4,1933,0,0,11,7,0,1,0,1,97,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,
0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1908,0,0,42,50,0,4,1964,0,0,1,0,0,1,0,2,3,0,0,
1927,0,0,43,140,0,6,1974,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,4,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,
1970,0,0,44,198,0,9,2050,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
1997,0,0,44,0,0,13,2059,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
2024,0,0,45,80,0,5,2098,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
2047,0,0,44,0,0,15,2117,0,0,0,0,0,1,0,
2062,0,0,46,149,0,2,2169,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
2089,0,0,47,66,0,4,2226,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2112,0,0,48,149,0,4,2244,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,
2143,0,0,49,112,0,4,2265,0,0,1,0,0,1,0,2,5,0,0,
2162,0,0,50,0,0,17,2301,0,0,1,1,0,1,0,1,97,0,0,
2181,0,0,50,0,0,45,2317,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2212,0,0,50,0,0,13,2327,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
2,3,0,0,
2251,0,0,50,0,0,15,2357,0,0,0,0,0,1,0,
2266,0,0,51,165,0,4,2446,0,0,4,0,0,1,0,2,4,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
2297,0,0,52,0,0,17,2502,0,0,1,1,0,1,0,1,97,0,0,
2316,0,0,52,0,0,45,2518,0,0,0,0,0,1,0,
2331,0,0,52,0,0,13,2526,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,
2358,0,0,52,0,0,15,2538,0,0,0,0,0,1,0,
2373,0,0,53,334,0,4,2553,0,0,9,8,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
2424,0,0,54,329,0,4,2570,0,0,10,9,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2479,0,0,55,50,0,4,2613,0,0,1,0,0,1,0,2,3,0,0,
2498,0,0,56,117,0,4,2628,0,0,4,2,0,1,0,2,97,0,0,2,97,0,0,1,97,0,0,1,97,0,0,
2529,0,0,57,144,0,6,2651,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,4,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,
2572,0,0,58,156,0,4,2713,0,0,6,5,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,3,0,0,
2611,0,0,59,75,0,4,2764,0,0,3,2,0,1,0,1,3,0,0,2,97,0,0,1,3,0,0,
2638,0,0,60,63,0,4,2806,0,0,1,0,0,1,0,2,97,0,0,
2657,0,0,61,60,0,4,2876,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
2680,0,0,62,98,0,3,2893,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,
2707,0,0,63,80,0,5,2925,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
2730,0,0,64,157,0,4,3015,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,
2757,0,0,65,0,0,17,3092,0,0,1,1,0,1,0,1,5,0,0,
2776,0,0,65,0,0,21,3101,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
2811,0,0,66,77,0,4,3149,0,0,3,2,0,1,0,1,97,0,0,2,5,0,0,1,3,0,0,
2838,0,0,67,99,0,5,3190,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
2861,0,0,68,187,0,3,3244,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
2904,0,0,69,117,0,5,3301,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
2927,0,0,70,108,0,4,3340,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
2954,0,0,71,60,0,4,3388,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2977,0,0,72,54,0,4,3438,0,0,1,0,0,1,0,2,3,0,0,
2996,0,0,73,116,0,6,3452,0,0,4,4,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
3027,0,0,74,73,0,4,3461,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
3050,0,0,75,108,0,6,3516,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
3077,0,0,76,269,0,4,3568,0,0,5,4,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,
3112,0,0,77,62,0,6,3607,0,0,1,1,0,1,0,2,5,0,0,
3131,0,0,78,121,0,9,3663,0,0,1,1,0,1,0,1,3,0,0,
3150,0,0,78,0,0,13,3673,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
3173,0,0,78,0,0,15,3693,0,0,0,0,0,1,0,
3188,0,0,79,77,0,4,3743,0,0,3,2,0,1,0,1,97,0,0,2,5,0,0,1,3,0,0,
3215,0,0,80,62,0,5,3781,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
3238,0,0,81,257,0,6,3849,0,0,11,11,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
3297,0,0,82,247,0,6,3910,0,0,10,10,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
};


/* ============================================================================= 
 Tipo          :  FUNCIONES GENERALES 
 Nombre        :  CO_libacciones.pc
 Descripcion   :  Rutinas propias de las rutinas de acciones.
 Creada 14-10-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor
 Version 4.0.0 
 ============================================================================ */

#define _COLIBGENERALES_PC_
#define _COLIBACCIONES_PC_

#include <CO_deftypes.h>
#include "CO_libgenerales.h"
#include "CO_libacciones.h"

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


/*==================================================================================================*/
/* Funcion que Obtiene el valor de un parametro.       									 						 */
/* Se duplica com integer para usarse con context en procesos con hilos e instancias de bd propias  */
/*==================================================================================================*/
int ifnRecuperaGedParametro(FILE **ptArchLog, char *szNomParametro, char *szCodModulo , char *szValParametro, sql_context ctxCont )
{	
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhValParametro[21]; /* EXEC SQL VAR szhValParametro IS STRING(21); */ 

	char szhNomParametro[21];
	char szhCodModulo   [3];
	int  ihValor_uno = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "szfnRecuperaGedParametro";
FILE *pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
 	memset( szhValParametro, '\0', sizeof( szhValParametro ) );
	memset( szhNomParametro, '\0', sizeof( szhNomParametro ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );
	
	strcpy( szhNomParametro, szNomParametro );
	strcpy( szhCodModulo, szCodModulo );
	rtrim( szhCodModulo );
	rtrim( szhNomParametro );

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT VAL_PARAMETRO
	INTO  :szhValParametro
	FROM  GED_PARAMETROS
	WHERE NOM_PARAMETRO= :szhNomParametro
	AND   COD_MODULO   = :szhCodModulo
	AND   COD_PRODUCTO = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where ((N\
OM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{  
		ifnTrazaHilos( modulo,&pfLog, "Error al recuperar Valor de Parametro ==> [%s][%s].", LOG00, szhNomParametro, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}  

	if( sqlca.sqlcode == SQLNOTFOUND ) 
	{  
		ifnTrazaHilos( modulo,&pfLog, "Parametro no encontrado para ==> [%s].", LOG00, szhNomParametro );
		return -1;
	}  

	strcpy(szValParametro,szhValParametro);
	return 0;

} /* ifnRecuperaGedParametro */

/*==================================================================================================*/
/* Funcion que Obtiene el Saldo en la Cta. Cte. de los Clientes que asocia ese rut                  */
/*==================================================================================================*/
BOOL bfnGetSaldoPorRutAcc(FILE **ptArchLog, char *szNumIdent, char *szCodTipIdent,double *dMtoSaldoRut, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente      = 0  ;
	double dhMtoSaldo        = 0.0;  
	double dhMtoSaldoParcial = 0.0;
	double dhMtoAux          = 0.0;
	char   szhFecAux      [9]=""  ; /* EXEC SQL VAR szhFecAux IS STRING(9); */ 

	char   szhNumIdent   [21]=""  ; /* EXEC SQL VAR szhNumIdent IS STRING(21); */ 

	char   szhCodTipIdent [3]=""  ; /* EXEC SQL VAR szhCodTipIdent IS STRING(3); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="bfnGetSaldoPorRutAcc";
int iError=0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	ifnTrazaHilos( modulo,&pfLog, "En funcion %s ",LOG05,modulo);  
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


   strcpy(szhNumIdent,szNumIdent);
	strcpy(szhCodTipIdent,szCodTipIdent);
    
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	DECLARE curRuts CURSOR FOR
	SELECT COD_CLIENTE
	FROM	 GE_CLIENTES
	WHERE	 COD_TIPIDENT = :szhCodTipIdent
	AND	 NUM_IDENT = :szhNumIdent; */ 

    
   if (sqlca.sqlcode)  {   
   	ifnTrazaHilos( modulo,&pfLog, "Declare curRuts : %s ",LOG00,sqlca.sqlerrm.sqlerrmc);  
      return FALSE; 
   }

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
   /* EXEC SQL 
   OPEN curRuts ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0002;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )36;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipIdent;
   sqlstm.sqhstl[0] = (unsigned long )3;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


   if (sqlca.sqlcode)  {   
      ifnTrazaHilos( modulo,&pfLog, "Open curRuts : %s ",LOG00,sqlca.sqlerrm.sqlerrmc);  
      return FALSE;   
   }

   dhMtoSaldo=0.0;
   for (;;)  /* Ciclo infinito */
   {
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
      /* EXEC SQL 
      FETCH curRuts   INTO :lhCodCliente; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 4;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )59;
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
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


       
      if (sqlca.sqlcode == SQLNOTFOUND)  {   
          iError = 0; 
          ifnTrazaHilos( modulo,&pfLog, "Fetch curRuts : Fin Datos del Cursor ",LOG05);  
          break;  
      }  
      
      else if (sqlca.sqlcode)
      {   
          iError = 1;
          ifnTrazaHilos( modulo,&pfLog, "Fetch curRuts : %s ",LOG00,sqlca.sqlerrm.sqlerrmc);  
          break;  
      } 

      dhMtoSaldoParcial = 0.0;
      
		ifnTrazaHilos( modulo,&pfLog, "Obtiene el Saldo del Cliente",LOG05);  
      /*-Obtiene el Saldo del Cliente ---*/
      if ( !bfnGetSaldoClienteAcc (&pfLog,lhCodCliente, &dhMtoSaldoParcial, &dhMtoAux, szhFecAux, CXX ) )  {
    	   iError = 1;
    	   break;	
      }
	   else
	   {
	      dhMtoSaldo += dhMtoSaldoParcial;
	   }
   }

  	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
   /* EXEC SQL
   CLOSE curRuts ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )78;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


   if (sqlca.sqlcode) 	{   
	   iError = 1;
      ifnTrazaHilos( modulo,&pfLog, "Close curRuts : %s ",LOG00,sqlca.sqlerrm.sqlerrmc);  
   }
    
   if (iError == 1) {   
      return FALSE;   
   }
   else  
   {   
   	*dMtoSaldoRut=dhMtoSaldo;
      return TRUE;    
   }
}


/* ============================================================================= */
/* Obtiene el saldo en la cartera de un Cliente dado                             */
/* ============================================================================= */
BOOL bfnGetSaldoClienteAcc (FILE **ptArchLog, long lCliente, double *pdSaldoVenc, double *pdSaldoNoVenc, char *szFecVencimiento, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente = lCliente;
	int    ihIndFacturado = 1; 
	double dhSaldoNoVenc = 0.0;
	double dhSaldoVenc = 0.0;
	char   szhFecVencimiento[9] = ""; /* EXEC SQL VAR szhFecVencimiento IS STRING(9); */ 
 
	short  shFecVenc;
	char   szhFormatoFecha   [9]       ; /* EXEC SQL VAR szhFormatoFecha   IS STRING(9); */ 
 
	char   szhTablaCoCartera[11]       ; /* EXEC SQL VAR szhTablaCoCartera IS STRING(11); */ 
 
	char   szhColumnaTipDoc [13]       ; /* EXEC SQL VAR szhColumnaTipDoc  IS STRING(13); */ 
 
	int    iNumCero;
	int    iNumDos;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
       
char modulo[]="bfnGetSaldoClienteAcc";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	ifnTrazaHilos( modulo,&pfLog, "En funcion %s ",LOG05,modulo);  
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	strcpy(szhFormatoFecha  , "YYYYMMDD");
	strcpy(szhTablaCoCartera, "CO_CARTERA");
	strcpy(szhColumnaTipDoc , "COD_TIPDOCUM");
	iNumCero = 0;
	iNumDos  = 2;

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT TO_CHAR(MIN(FEC_VENCIMIE),:szhFormatoFecha)
	INTO  :szhFecVencimiento:shFecVenc
	FROM  CO_CARTERA
	WHERE COD_CLIENTE   = :lhCodCliente 
	AND   IND_FACTURADO = :ihIndFacturado
	AND   FEC_VENCIMIE < TRUNC(SYSDATE)
	AND   COD_CONCEPTO != :iNumDos 
	AND   COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
									    FROM	  CO_CODIGOS
									    WHERE  NOM_TABLA   = :szhTablaCoCartera
									    AND	  NOM_COLUMNA = :szhColumnaTipDoc ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(min(FEC_VENCIMIE),:b0) into :b1:b2  from CO_C\
ARTERA where ((((COD_CLIENTE=:b3 and IND_FACTURADO=:b4) and FEC_VENCIMIE<TRUNC\
(SYSDATE)) and COD_CONCEPTO<>:b5) and COD_TIPDOCUM not  in (select TO_NUMBER(C\
OD_VALOR)  from CO_CODIGOS where (NOM_TABLA=:b6 and NOM_COLUMNA=:b7)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )93;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecVencimiento;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)&shFecVenc;
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
 sqlstm.sqhstv[4] = (unsigned char  *)&iNumDos;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTablaCoCartera;
 sqlstm.sqhstl[5] = (unsigned long )11;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhColumnaTipDoc;
 sqlstm.sqhstl[6] = (unsigned long )13;
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
	    ifnTrazaHilos( modulo,&pfLog, "SELECT FROM CO_CARTERA(1) (Cliente:%ld) : %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
	    return FALSE;
	}
       
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),:iNumCero)
	INTO :dhSaldoVenc
	FROM CO_CARTERA
	WHERE COD_CLIENTE   = :lhCodCliente 
	AND IND_FACTURADO = :ihIndFacturado
	AND FEC_VENCIMIE < TRUNC(SYSDATE)
	AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA   = :szhTablaCoCartera
									AND		NOM_COLUMNA = :szhColumnaTipDoc	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),:b0) into :b1  \
from CO_CARTERA where (((COD_CLIENTE=:b2 and IND_FACTURADO=:b3) and FEC_VENCIM\
IE<TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from\
 CO_CODIGOS where (NOM_TABLA=:b4 and NOM_COLUMNA=:b5)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )136;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iNumCero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoVenc;
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
 sqlstm.sqhstv[4] = (unsigned char  *)szhTablaCoCartera;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhColumnaTipDoc;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* jlr_22.01.01 */

	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
	    ifnTrazaHilos( modulo,&pfLog, "SELECT FROM CO_CARTERA(1) (Cliente:%ld) : %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
	    return FALSE;
	}
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),:iNumCero)
	INTO :dhSaldoNoVenc
	FROM CO_CARTERA
	WHERE COD_CLIENTE   = :lhCodCliente 
	AND IND_FACTURADO = :ihIndFacturado
	AND FEC_VENCIMIE >= TRUNC(SYSDATE)
	AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA   = :szhTablaCoCartera
									AND		NOM_COLUMNA = :szhColumnaTipDoc	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),:b0) into :b1  \
from CO_CARTERA where (((COD_CLIENTE=:b2 and IND_FACTURADO=:b3) and FEC_VENCIM\
IE>=TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  fro\
m CO_CODIGOS where (NOM_TABLA=:b4 and NOM_COLUMNA=:b5)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )175;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iNumCero;
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
 sqlstm.sqhstv[4] = (unsigned char  *)szhTablaCoCartera;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhColumnaTipDoc;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* jlr_22.01.01 */

    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
        ifnTrazaHilos( modulo,&pfLog, "SELECT FROM CO_CARTERA(2) (Cliente:%ld) : %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return FALSE;
    }
    else
    {
        *pdSaldoNoVenc = dhSaldoNoVenc;
        *pdSaldoVenc = dhSaldoVenc;
		  strcpy(szFecVencimiento,szhFecVencimiento);
		  ifnTrazaHilos( modulo,&pfLog, "Fin funcion %s ",LOG05,modulo);  
        return TRUE; 
    }
}

/* ============================================================================= */
/* Retorna el rut de un cliente dado                                             */
/* ============================================================================= */
int ifnGetRutCliente(FILE **ptArchLog, long lCliente, char *szNumIdent , char *szTipIdent, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente = lCliente ;
	char szhNumIdent        [21] ="" ; /* EXEC SQL VAR szhNumIdent IS STRING(21); */ 

	char szhCodTipIdent      [3] ="" ; /* EXEC SQL VAR szhCodTipIdent IS STRING(3); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnGetRutCliente";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT NUM_IDENT, COD_TIPIDENT
	INTO :szhNumIdent, :szhCodTipIdent
	FROM GE_CLIENTES
	WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NUM_IDENT ,COD_TIPIDENT into :b0,:b1  from GE_CLIENTE\
S where COD_CLIENTE=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )214;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
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



	if( sqlca.sqlcode == SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog, "Select from GE_CLIENTES (Cliente:%ld) : %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
		return 0;  /* error controlado */
	}
	else if ( sqlca.sqlcode )
	{
		ifnTrazaHilos( modulo,&pfLog, "Select from GE_CLIENTES (Cliente:%ld) : %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
		return -1;  /* error oracle */
	}
	else
	{
		strcpy(szNumIdent,szhNumIdent);
		strcpy(szTipIdent,szhCodTipIdent);
		return 1;
	}
}/* int ifnGetRutCliente */

/* ============================================================================= */
/* Verifica si al menos uno de los abonados del rut tiene su direccion de        */
/* correspondencia  dentro de la region metropolitana                            */
/* ============================================================================= */
int ifnRutMetropolitano (FILE **ptArchLog, long lCliente, int *iRetorno, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente  = 0  ;
    char szhNumIdent           [21] ="" ; /* EXEC SQL VAR szhNumIdent IS STRING(21); */ 

    char szhCodTipIdent         [3] ="" ; /* EXEC SQL VAR szhCodTipIdent IS STRING(3); */ 

    char szhCodRegion           [4] ="" ; /* EXEC SQL VAR szhCodRegion IS STRING(4); */ 

    int  ihDirCorrespondencia  = 3 ; 
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="ifnRutMetropolitano";
int  iError = 0, iCrit = 0,  iMetropolitana = 13;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


    lhCodCliente = lCliente;
    *iRetorno=0;

    /*-Obtiene el Rut del Cliente -*/            
    iError = ifnGetRutCliente(&pfLog, lCliente,szhNumIdent,szhCodTipIdent, CXX);
    if (iError != 1)  {
        return iError; /* 0: Rut NotFound, -1:Error Oracle */
    }

    /* Obtiene todos los clientes asociados a ese Rut y la region de sus respectivas direcciones de correspondencia */ 
	 sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL 
    DECLARE curRegClientes CURSOR FOR
    SELECT /o+ AK_GE_CLIENTE_IDENTIFICACION o/
           A.COD_CLIENTE, C.COD_REGION
    FROM  GE_DIRECCIONES C, GA_DIRECCLI B, GE_CLIENTES A
    WHERE A.NUM_IDENT        = :szhNumIdent
    AND   A.COD_TIPIDENT     = :szhCodTipIdent
    AND   B.COD_CLIENTE      = A.COD_CLIENTE
    AND   B.COD_TIPDIRECCION = :ihDirCorrespondencia
    AND   C.COD_DIRECCION    = B.COD_DIRECCION; */ 

           
    if (sqlca.sqlcode)    {   
        ifnTrazaHilos( modulo,&pfLog, "Declare curRegClientes (Cliente:%ld|Rut:%s) : %s "
                           ,LOG00,lhCodCliente,szhNumIdent,sqlca.sqlerrm.sqlerrmc);  
        return -1; 
    }

	 sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL 
    OPEN curRegClientes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )241;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihDirCorrespondencia;
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


    if (sqlca.sqlcode)   {   
        ifnTrazaHilos( modulo,&pfLog, "Open (Cliente:%ld) :%s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return -1;   
    }

    iError=0;
    for (;;)  /* Ciclo infinito */
    {
		  sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
        /* EXEC SQL 
        FETCH curRegClientes
        INTO :lhCodCliente,:szhCodRegion; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )268;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodRegion;
        sqlstm.sqhstl[1] = (unsigned long )4;
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


         
        if (sqlca.sqlcode == SQLNOTFOUND)    {   
            iError = 0; 
            iCrit = 0;  /* se acabaron los datos y no encontre ningun metropolitano */
            ifnTrazaHilos( modulo,&pfLog, "Fetch (Rut:%s) : Fin Datos del Cursor ",LOG05,szhNumIdent);  
            break;  
        }  
        else if (sqlca.sqlcode)
        {   
            iError = 1; 
            iCrit = 0; /* se produjo un error y por lo tanto no se cumplio el criterio */
            ifnTrazaHilos( modulo,&pfLog, "Fetch (Rut:%s) :%s ",LOG00,szhNumIdent,sqlca.sqlerrm.sqlerrmc);  
            break;  
        } 
        
        if ( atol(szhCodRegion) == iMetropolitana )  {   
            iError = 0; 
            iCrit = 1;   /* se cumplio el criterio, este cliente es metropolitano */
            break;   
        } 

    }

  	 sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL
    CLOSE curRegClientes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )291;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)    {   
        ifnTrazaHilos( modulo,&pfLog, "Close (Rut:%s):%s ",LOG00,szhNumIdent,sqlca.sqlerrm.sqlerrmc);  
        return -1;   
    }
    
    if (iError == 1)  {   
        return -1;   
    }
    else                  /* si no hubo error */
    {   
        *iRetorno=iCrit;
        return 1;    
    }

}

/* ============================================================================= 
   Funcion que Actualiza la co_gestion para un cliente dado.                     
	Parametros	lCodCliente		Cliente dado.
					lCodCuenta		Cuenta a la que pertenece el Cliente.
					szNumIdent		Rut al que pertenece el cliente.
					szCodTipIdent	
					szCodEntidad	Entidad de cobranza del cliente.
					pszRutina		Rutina que llama:
					               A : Asignacion Transitoria (ACEXT, ASDIC).
										D : Desasignacion Transitoria (DACEX, DADIC).
										P : Proceso asignacion definitiva (DICOM, COBEX).
			   pszCodMovimiento  Codigo de movimiento involucrado: 	
					               A : Alta (DICOM, COBEX).
										B : Baja (DICOM, COBEX).
										R : Reasignado (COBEX).
										M : Modificado (DICOM, COBEX).
 ============================================================================= */
BOOL bfnActualizaCoGestionClienteAcc(FILE **ptArchLog, long lCodCliente  , long lCodCuenta, char *szNumIdent , char *szCodTipIdent,
								           char *szCodEntidad, char *pszRutina, char *pszCodMovimiento, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	long	lhCodCuenta;
	char	szhNumIdent       [21] = ""; 
	char	szhCodTipIdent    [3] = "";
	char	szhCodGestionAct  [5] = "";
	char	szhCodGestionNew  [5] = "";
	char	szhCodAlta        [6] = "";
	char	szhCodBaja        [6] = "";
	char	szhCodAltaTran    [6] = "";
	char	szhCodBajaTran    [6] = "";
	char	szhSql         [1000] = "";
	char	szhObsGestion    [51] = "";
	char	szhCodEntidad     [6] = "";
	char	szhSituacion      [2] = "";
   int   iCountGest   =0;
   /*********************/
   char  szhLetra_X  [2];
   char  szhLetra_C  [2];
   char  szhLetra_H  [2];
   int   ihValor_dos  = 2;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnActualizaCoGestionClienteAcc";
char	szCodMovimiento[6], szRutina[6];
BOOL	bInserta = FALSE, bEncon = FALSE;
int	ilong = 0, rr;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	memset( szRutina, '\0', sizeof( szRutina ) );
	memset( szCodMovimiento, '\0', sizeof( szCodMovimiento ) );
	memset( szhCodEntidad, '\0', sizeof( szhCodEntidad ) );
	memset( szhCodTipIdent, '\0', sizeof( szhCodTipIdent ) );
	memset( szhNumIdent, '\0', sizeof( szhNumIdent ) );
	memset( szhCodGestionNew, '\0', sizeof( szhCodGestionNew ) );
	memset( szhSituacion, '\0', sizeof( szhSituacion ) );

	lhCodCliente = lCodCliente;
	lhCodCuenta  = lCodCuenta;
	strcpy( szRutina, pszRutina );
	strcpy( szCodMovimiento, pszCodMovimiento );
	strcpy( szhCodEntidad, szCodEntidad );
	strcpy( szhCodTipIdent, szCodTipIdent );
	strcpy( szhNumIdent, szNumIdent );
	strcpy( szhCodGestionNew, "X" );
	strcpy( szhSituacion, "X" );
	strcpy(szhLetra_X,"X");
	strcpy(szhLetra_C,"C");
	strcpy(szhLetra_H,"H");
	
	ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Ingreso %s - szCodEntidad = [%s] - szRutina = [%s].", 
							LOG05, lhCodCliente, modulo, szCodEntidad, szRutina );  
	
	if( strcmp( szhCodEntidad, "DICOM" ) == 0 ) /* si es para DICOM */
	{
		strcpy( szhCodAlta, "788\0" );				
		strcpy( szhCodBaja, "789\0" );				
		strcpy( szhCodAltaTran, "-788\0" );				
		strcpy( szhCodBajaTran, "-789\0" );				
	}
	else /* es Cobranza Externa */
	{
		strcpy( szhCodAlta, "778\0" );				
		strcpy( szhCodBaja, "779\0" );				
		strcpy( szhCodAltaTran, "-778\0" );				
		strcpy( szhCodBajaTran, "-779\0" );				
	}
	
	if( strcmp( szRutina, "A" ) == 0 ) /* acciones de asignacion, dar alta transitoria en la co_gestion */
	{
		/* debemos limpiar cualquier valor negativo, anterior */
		memset( szhSql, '\0', sizeof( szhSql ) );
		sprintf( szhSql, "DELETE  FROM CO_GESTION "
						      "WHERE  COD_CLIENTE = :v1 "
						      "AND    COD_GESTION IN ( :v2, :v3 )");

		ifnTrazaHilos( modulo,&pfLog, "[%s]\n", LOG05, szhSql );

		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL PREPARE deleteCoGestionTran FROM :szhSql; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )306;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	

		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
		{
			ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) PREPARE deleteCoGestionTran %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return FALSE;
		}

		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL EXECUTE deleteCoGestionTran USING :lhCodCliente, :szhCodAltaTran, :szhCodAltaTran ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )325;
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
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodAltaTran;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodAltaTran;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) EXECUTE deleteCoGestionTran %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return FALSE;
		}

		strcpy( szhCodGestionNew, szhCodAltaTran );
		bInserta = TRUE;
	}

	if( strcmp( szRutina, "D" ) == 0 ) /* acciones de desasignacion, dar baja transitoria en la co_gestion */
	{
		/* debemos averiguar si tiene un codigo de alta transitoria que aun no se ejecuta */
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		SELECT NVL( MAX( COD_GESTION ), :szhLetra_X )
		INTO	 :szhCodGestionAct
		FROM	 CO_GESTION
		WHERE	 COD_CLIENTE = :lhCodCliente
		AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION )
								     FROM	CO_GESTION
								     WHERE	COD_CLIENTE = :lhCodCliente 
								     AND    COD_GESTION IN( :szhCodAltaTran, :szhCodBajaTran, :szhCodAlta, :szhCodBaja ) )
		AND    COD_GESTION IN( :szhCodAltaTran, :szhCodBajaTran, :szhCodAlta, :szhCodBaja ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(max(COD_GESTION),:b0) into :b1  from CO_GESTION \
where ((COD_CLIENTE=:b2 and FEC_GESTION=(select max(FEC_GESTION)  from CO_GEST\
ION where (COD_CLIENTE=:b2 and COD_GESTION in (:b4,:b5,:b6,:b7)))) and COD_GES\
TION in (:b4,:b5,:b6,:b7))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )352;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_X;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionAct;
  sqlstm.sqhstl[1] = (unsigned long )5;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodAltaTran;
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodBajaTran;
  sqlstm.sqhstl[5] = (unsigned long )6;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodAlta;
  sqlstm.sqhstl[6] = (unsigned long )6;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodBaja;
  sqlstm.sqhstl[7] = (unsigned long )6;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhCodAltaTran;
  sqlstm.sqhstl[8] = (unsigned long )6;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhCodBajaTran;
  sqlstm.sqhstl[9] = (unsigned long )6;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhCodAlta;
  sqlstm.sqhstl[10] = (unsigned long )6;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhCodBaja;
  sqlstm.sqhstl[11] = (unsigned long )6;
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


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
			ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) SELECT COD_GESTION %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return FALSE;
		} 
		else if( sqlca.sqlcode != SQLNOTFOUND )
		{
			ilong = strlen( szhCodGestionAct ) - 1;
			for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhCodGestionAct[rr] != ' ') break ;
			szhCodGestionAct[rr + 1] = '\0';

			ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) szhCodGestionAct [%s].", LOG05, lhCodCliente, szhCodGestionAct );  
	
			if( strcmp( szhCodGestionAct, szhCodAltaTran ) == 0 ) /* si hay alta transitoria */
			{
				/* borramos el registro de alta transitoria, el cliente pago, antes del alta definitiva */
				memset(szhSql,'\0',sizeof(szhSql));
				sprintf( szhSql, "DELETE FROM CO_GESTION "
								     "WHERE	 COD_CLIENTE = :v1 "
								     "AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION ) "
								     "						     FROM	CO_GESTION "
								     "						     WHERE	COD_CLIENTE = :v2 "
								     "						     AND    COD_GESTION = :v3 ) "
								     "AND    COD_GESTION = :v4 ");

				ifnTrazaHilos( modulo,&pfLog, "[%s]\n", LOG05, szhSql );

				sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
				/* EXEC SQL PREPARE deleteCoGestion FROM :szhSql; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )415;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	

				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
					ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) PREPARE deleteCodGestion %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
					return FALSE;
				}

				sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
				/* EXEC SQL EXECUTE deleteCoGestion USING :lhCodCliente, :lhCodCliente, :szhCodAltaTran, :szhCodAltaTran; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )434;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodAltaTran;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
					ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) EXECUTE deleteCodGestion %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
					return FALSE;
				}

				strcpy( szhCodGestionNew, "X" ); /* no se inserta la baja transitoria */
			} /* if( strcmp( szhCodGestionAct, szhCodAltaTran ) == 0 ) */
			else
			{
				strcpy( szhCodGestionNew, szhCodBajaTran ); /* insertamos la baja transitoria */
				bInserta = TRUE;
			}	
		}
		else
		{
			strcpy( szhCodGestionNew, szhCodBajaTran ); /* insertamos la baja transitoria */
			bInserta = TRUE;
		}
	} /* if( strcmp( szRutina, "D" ) == 0 ) */

	if( strcmp( szRutina, "P" ) == 0 ) /* colas de proceso, dar alta o baja definitiva en la co_gestion o la co_hgestion*/
	{
		if( strcmp( szCodMovimiento, "A" ) == 0 ) /* es alta, nunca estara en historia */
		{
			strcpy( szhCodGestionNew, szhCodAlta );
			strcpy( szhCodGestionAct, szhCodAltaTran );
		}
		else
		{
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL
			SELECT COD_GESTION, :szhLetra_C
			INTO	 :szhCodGestionAct,
					 :szhSituacion
			FROM	 CO_GESTION
			WHERE	 COD_CLIENTE = :lhCodCliente
			AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran )
			AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION )
									     FROM	CO_GESTION
									     WHERE	COD_CLIENTE = :lhCodCliente 
									     AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran ) )
			AND     ROWNUM  	<  :ihValor_dos			/o siempre tiene preferencia la baja, ya que en una reasignacion esto	o/
			ORDER BY COD_GESTION DESC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_GESTION ,:b0 into :b1,:b2  from CO_GESTION wher\
e (((COD_CLIENTE=:b3 and COD_GESTION in (:b4,:b5)) and FEC_GESTION=(select max\
(FEC_GESTION)  from CO_GESTION where (COD_CLIENTE=:b3 and COD_GESTION in (:b4,\
:b5)))) and ROWNUM<:b9) order by COD_GESTION desc  ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )465;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_C;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionAct;
   sqlstm.sqhstl[1] = (unsigned long )5;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhSituacion;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodAltaTran;
   sqlstm.sqhstl[4] = (unsigned long )6;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodBajaTran;
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
   sqlstm.sqhstv[7] = (unsigned char  *)szhCodAltaTran;
   sqlstm.sqhstl[7] = (unsigned long )6;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhCodBajaTran;
   sqlstm.sqhstl[8] = (unsigned long )6;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_dos;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

			/* se debe ejecutar primero, para no limpiar la tabla co_cobexternadoc 	*/

			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
				ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) SELECT COD_GESTION FROM CO_GESTION%s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return FALSE;
			} 

			if( sqlca.sqlcode == SQLNOTFOUND ) /* no esta en la co_gestion, puede estar en la co_hgestion */
			{
				sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
				/* EXEC SQL
				SELECT COD_GESTION, :szhLetra_H
				INTO	 :szhCodGestionAct,
						 :szhSituacion
				FROM	 CO_HGESTION
				WHERE	 COD_CLIENTE = :lhCodCliente
				AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran )
				AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION )
										     FROM	CO_HGESTION
										     WHERE	COD_CLIENTE = :lhCodCliente 
										     AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran ) )
				AND     ROWNUM  	<  :ihValor_dos			/o siempre tiene preferencia la baja, ya que en una reasignacion esto	o/ 		
				ORDER BY COD_GESTION DESC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_GESTION ,:b0 into :b1,:b2  from CO_HGESTION wh\
ere (((COD_CLIENTE=:b3 and COD_GESTION in (:b4,:b5)) and FEC_GESTION=(select m\
ax(FEC_GESTION)  from CO_HGESTION where (COD_CLIENTE=:b3 and COD_GESTION in (:\
b4,:b5)))) and ROWNUM<:b9) order by COD_GESTION desc  ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )520;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_H;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionAct;
    sqlstm.sqhstl[1] = (unsigned long )5;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhSituacion;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodBajaTran;
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
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[7] = (unsigned long )6;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhCodBajaTran;
    sqlstm.sqhstl[8] = (unsigned long )6;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_dos;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

			/* se debe ejecutar primero, para no limpiar la tabla co_cobexternadoc 	*/
	
				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
				{
					ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) SELECT COD_GESTION FROM CO_HGESTION%s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
					return FALSE;
				} 
			}			
			
			if( strcmp( szhSituacion, "X" ) != 0 ) /* si lo encontramos en alguna de las tablas se procesa */
			{	
				if( strcmp( szCodMovimiento, "R" ) == 0 || strcmp( szCodMovimiento, "B" ) == 0 ) /* el rut del cliente fue reasignado, o se da de baja */
				{
					strcpy( szhCodGestionNew, szhCodBaja );
					strcpy( szhCodGestionAct, szhCodBajaTran );
				}
	
				if( strcmp( szCodMovimiento, "M" ) == 0 )
				{
					ilong = strlen( szhCodGestionAct ) - 1;
					for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhCodGestionAct[rr] != ' ') break ;
					szhCodGestionAct[rr + 1] = '\0';
	
					if( strcmp( szhCodGestionAct, szhCodAltaTran ) == 0 )
						strcpy( szhCodGestionNew, szhCodAlta );
					else
						if( strcmp( szhCodGestionAct, szhCodBajaTran ) == 0 )
							strcpy( szhCodGestionNew, szhCodBaja );
				} /* if( strcmp( szCodMovimiento, "M" ) == 0 ) */
			}
			else
			{
				strcpy( szhCodGestionNew, "X\0" );
			} /* if( strcmp( szhSituacion, 'X' ) != 0 ) */
		} /* if( strcmp( szCodMovimiento, "A" ) == 0 ) */
	} /* if( strcmp( szRutina, "P" ) == 0 ) */	
	
	if( bInserta ) /* se inserta al dar alta, baja transitoria o reasignacion */ 
	{
	    	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	    	/* EXEC SQL 
	    	SELECT COUNT(*)
	    	INTO  :iCountGest
	    	FROM  CO_GESTION
	    	WHERE COD_CLIENTE = :lhCodCliente
	    	AND   COD_GESTION = :szhCodGestionNew; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 12;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select count(*)  into :b0  from CO_GESTION where (COD_C\
LIENTE=:b1 and COD_GESTION=:b2)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )575;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&iCountGest;
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
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodGestionNew;
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
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
		 ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(COD_GESTION:%s) SELECT count(*) FROM CO_GESTION: %s", LOG00, lhCodCliente,szhCodGestionNew, sqlca.sqlerrm.sqlerrmc );
		 return FALSE;
		}

    	/* Si no existe el cliente + codigo de gestion se inserta*/
    	if (iCountGest == 0) {
			memset(szhSql,'\0',sizeof(szhSql));
			sprintf( szhSql,"INSERT INTO CO_GESTION ( "
						       " COD_CLIENTE , "
						       " COD_CUENTA  , "
						       " COD_TIPIDENT, "
						       " NUM_IDENT   , "
						       " COD_GESTION , "
						       " FEC_GESTION , "
						       " OBS_GESTION , "
						       " NOM_USUARIO "
						       " ) VALUES ("
						       " :v1, :v2, :v3, :v4, :v5, SYSDATE, :v6, USER ) ");

			ifnTrazaHilos( modulo,&pfLog, "[%s]\n", LOG05, szhSql );
	
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL PREPARE insertCoGestion FROM :szhSql; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )602;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	
	
			if( sqlca.sqlcode ) 
			{
				ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) PREPARE insertCoGestion %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return FALSE;
			}
	
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL EXECUTE insertCoGestion USING :lhCodCliente, :lhCodCuenta, :szhCodTipIdent, :szhNumIdent, :szhCodGestionNew, :szhLetra_X; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )621;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuenta;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[3] = (unsigned char  *)szhNumIdent;
   sqlstm.sqhstl[3] = (unsigned long )21;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodGestionNew;
   sqlstm.sqhstl[4] = (unsigned long )5;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_X;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		
			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
				ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) EXECUTE insertCoGestion %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return FALSE;
			}
	   }
      else
      {
			/* Si existe el cliente + codigo de gestion se actualiza fecha*/
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL 
			UPDATE CO_GESTION SET   
			       FEC_GESTION = SYSDATE
			WHERE  COD_CLIENTE = :lhCodCliente
			AND    COD_GESTION = :szhCodGestionNew; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_GESTION  set FEC_GESTION=SYSDATE where (COD_CLIE\
NTE=:b0 and COD_GESTION=:b1)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )660;
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
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionNew;
   sqlstm.sqhstl[1] = (unsigned long )5;
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
			   ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Actualizando CO_GESTION %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			   return FALSE;
			}
      }  /* if iCountGest = 0 */
	}
	else /* si hay que dar alta o baja definitiva actualizamos */
	{
		if( strcmp( szhCodGestionNew, "X" ) != 0 )	/* si hay que actualizar algo realmente */
		{
			sprintf( szhObsGestion, "%s %s", strcmp( szhCodGestionNew, szhCodAlta ) == 0 ? "SE ENVIO A" : "SE DESASIGNO DE", szhCodEntidad );			
			memset(szhSql,'\0',sizeof(szhSql));
			sprintf( szhSql, "UPDATE %s SET             "
			                 "       COD_GESTION = :v1, "
								  "       COD_CUENTA  = :v2, "
								  "       OBS_GESTION = :v3, "
                          "       FEC_GESTION = SYSDATE "
								  "WHERE  COD_CLIENTE = :v4 "
								  "AND    COD_GESTION = :v5",!strcmp( szhSituacion, "C" ) ? "CO_GESTION" : "CO_GESTION");

			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL PREPARE updateCoGestion FROM :szhSql; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )683;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	

			ifnTrazaHilos( modulo,&pfLog, "[%s]\n", LOG05, szhSql );

			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
				ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) PREPARE updateCodGestion %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return FALSE;
			}

			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL EXECUTE updateCoGestion USING :szhCodGestionNew, :lhCodCuenta, :szhObsGestion, :lhCodCliente, :szhCodGestionAct; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )702;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestionNew;
   sqlstm.sqhstl[0] = (unsigned long )5;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuenta;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhObsGestion;
   sqlstm.sqhstl[2] = (unsigned long )51;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodGestionAct;
   sqlstm.sqhstl[4] = (unsigned long )5;
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
				ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) EXECUTE updateCodGestion %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return FALSE;
			}
		} /* if( strcmp( szhCodGestionNew, "X" ) != 0 ) */
	} /* if( bInsert ) */		

	return TRUE;
} /* BOOL bfnActualizaCoGestionClienteAcc( long lCodCliente, char *szRutina ) */


/*==================================================================================================*/
/* Funcion que Asigna si corresponde ejecutivo de cobranza al cliente							          */
/*==================================================================================================*/
int ifnAsigEjecCliente(FILE **ptArchLog, long lCodCliente, char *szpTipEntidad, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente;
	char szhCodAgente[31];
	char szhTipEntidad[3];
	char szhAgenteNoAsignado [12];  /* EXEC SQL VAR szhAgenteNoAsignado IS STRING (12); */ 

	int  iNumDos;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
    
char modulo[] = "ifnAsigEjecCliente";
int iRet = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );

	memset( szhCodAgente, '\0', sizeof( szhCodAgente ) );
	memset( szhTipEntidad, '\0', sizeof( szhTipEntidad ) );
	
	lhCodCliente = lCodCliente;
	strcpy( szhTipEntidad, szpTipEntidad );
	rtrim( szhTipEntidad );

	strcpy (szhAgenteNoAsignado, "NO ASIGNADO");
	iNumDos = 2;

	/* debemos buscar si hay otro cliente asignado a cobranza externa y sea de la misma operadora y misma cuenta */
	ifnTrazaHilos( modulo,&pfLog,  "lhCodCliente        [%ld].", LOG05, lhCodCliente);  
	ifnTrazaHilos( modulo,&pfLog,  "szhAgenteNoAsignado [%s].", LOG05, szhAgenteNoAsignado);  
	ifnTrazaHilos( modulo,&pfLog,  "szhTipEntidad       [%s].", LOG05, szhTipEntidad);  
	ifnTrazaHilos( modulo,&pfLog,  "iNumDos             [%d].", LOG05, iNumDos);  
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT DISTINCT B.COD_AGENTE
	  INTO :szhCodAgente
	  FROM CO_ENTCOB E, CO_AGENCOB AG, GE_CLIENTES G, CO_MOROSOS B, CO_MOROSOS A
	 WHERE A.COD_CLIENTE = :lhCodCliente
	   AND A.NUM_IDENT = B.NUM_IDENT
	   AND B.COD_AGENTE NOT IN ( :szhAgenteNoAsignado )		/o todos aquellos no asignados, ni reasignados o/
	   AND B.COD_CLIENTE = G.COD_CLIENTE
	   AND G.COD_OPERADORA IN ( SELECT COD_OPERADORA
	   							  FROM GE_CLIENTES
	   							 WHERE COD_CLIENTE = :lhCodCliente )
	   AND B.COD_AGENTE = AG.COD_AGENTE
	   AND AG.COD_ENTIDAD = E.COD_ENTIDAD
	   AND E.TIP_ENTIDAD  = :szhTipEntidad			   							 
	   AND ROWNUM < :iNumDos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select distinct B.COD_AGENTE into :b0  from CO_ENTCOB E ,CO_\
AGENCOB AG ,GE_CLIENTES G ,CO_MOROSOS B ,CO_MOROSOS A where ((((((((A.COD_CLIE\
NTE=:b1 and A.NUM_IDENT=B.NUM_IDENT) and B.COD_AGENTE not  in (:b2)) and B.COD\
_CLIENTE=G.COD_CLIENTE) and G.COD_OPERADORA in (select COD_OPERADORA  from GE_\
CLIENTES where COD_CLIENTE=:b1)) and B.COD_AGENTE=AG.COD_AGENTE) and AG.COD_EN\
TIDAD=E.COD_ENTIDAD) and E.TIP_ENTIDAD=:b4) and ROWNUM<:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )737;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgente;
 sqlstm.sqhstl[0] = (unsigned long )31;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhAgenteNoAsignado;
 sqlstm.sqhstl[2] = (unsigned long )12;
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
 sqlstm.sqhstv[4] = (unsigned char  *)szhTipEntidad;
 sqlstm.sqhstl[4] = (unsigned long )3;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&iNumDos;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al buscar Agente => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return -1;
	}

	if( sqlca.sqlcode == SQLNOTFOUND )
		return 0;

	rtrim( szhCodAgente );
	
	/* encontro agente, actualizamos la CO_MOROSOS */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	UPDATE CO_MOROSOS
	   SET COD_AGENTE = :szhCodAgente
	 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )776;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgente;
 sqlstm.sqhstl[0] = (unsigned long )31;
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


	 
	if( sqlca.sqlcode )	{   
		ifnTrazaHilos( modulo,&pfLog,  "Update CO_MOROSOS Cliente => [%ld] Agente => [%s] [%s].", LOG00, lhCodCliente, szhCodAgente, sqlca.sqlerrm.sqlerrmc );  
		return -1; /* error sql */
	}

	ifnTrazaHilos( modulo,&pfLog,  "%s Cliente => [%ld] Agente => [%s] Ok!.", LOG05, modulo, lhCodCliente, szhCodAgente );  
	return 1;
} /* int ifnAsigEjecCliente() */


/* ============================================================================= */
/* Asigna a un Cliente el ejecutivo de cobranza que ya tenga asociado el rut     */
/* ============================================================================= */
int ifnAsigEjecRut (FILE **ptArchLog,long lCliente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente = lCliente;
    char szhCodAge [31] = ""; /* EXEC SQL VAR szhCodAge IS STRING (31); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
    
char modulo[] = "ifnAsigEjecRut";
int  iRet = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	        
    iRet = ifnVerifEjecRut(&pfLog, lhCodCliente, szhCodAge, CXX );
    if( iRet < 1 )
    {
        return (iRet) ; /* Error o no encontro nada */
    }
    else /* tenemos el agente, actualizamos la co_morosos */
    {
        sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
        /* EXEC SQL 
        UPDATE CO_MOROSOS
           SET COD_AGENTE  = :szhCodAge
         WHERE COD_CLIENTE = :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIEN\
TE=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )799;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodAge;
        sqlstm.sqhstl[0] = (unsigned long )31;
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


        if( sqlca.sqlcode )
        {   
            ifnTrazaHilos( modulo,&pfLog, "Update CO_MOROSOS (Cliente:%ld|Agente:%s) %s "
                         ,LOG00,lhCodCliente,szhCodAge,sqlca.sqlerrm.sqlerrmc);  
            return (-1); /* error sql */
        }
        else
        {   
            ifnTrazaHilos( modulo,&pfLog, "%s : (Cliente:%ld|Agente:%s) Ok!"
                         ,LOG05,modulo,lhCodCliente,szhCodAge);  
            return (1); /* ejecutivo asignado */
        }
    }
} /* fin ifnAsigEjecRut */

/*==================================================================================================*/
/* Funcion que verifica un rut de un cliente moroso															 */
/*==================================================================================================*/
int ifnVerifEjecRut(FILE **ptArchLog, long lCliente, char *szAgente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente = lCliente;
	char szhCodAge [31];			/* EXEC SQL VAR szhCodAge           IS STRING (31); */ 

	char szhAgenteNoAsignado [12];  /* EXEC SQL VAR szhAgenteNoAsignado IS STRING (12); */ 

	char szhAgenteR          [2] ;  /* EXEC SQL VAR szhAgenteR          IS STRING (2); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
    
char modulo[] = "ifnVerifEjecRut";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
	 	
	memset( szhCodAge, '\0', sizeof( szhCodAge ) );
	strcpy (szhAgenteNoAsignado, "NO ASIGNADO");
	strcpy (szhAgenteR         , "R" );
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT DISTINCT A.COD_AGENTE
	INTO  :szhCodAge
	FROM  CO_MOROSOS A, 
			CO_MOROSOS B
	WHERE B.COD_CLIENTE  = :lhCodCliente
	AND   A.NUM_IDENT    = B.NUM_IDENT
	AND   A.COD_TIPIDENT = B.COD_TIPIDENT
	AND   A.COD_AGENTE NOT IN ( :szhAgenteNoAsignado, :szhAgenteR ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select distinct A.COD_AGENTE into :b0  from CO_MOROSOS A ,CO\
_MOROSOS B where (((B.COD_CLIENTE=:b1 and A.NUM_IDENT=B.NUM_IDENT) and A.COD_T\
IPIDENT=B.COD_TIPIDENT) and A.COD_AGENTE not  in (:b2,:b3))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )822;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodAge;
 sqlstm.sqhstl[0] = (unsigned long )31;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhAgenteNoAsignado;
 sqlstm.sqhstl[2] = (unsigned long )12;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhAgenteR;
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

 	/* todos aquellos no asignados, ni reasignados */
	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Select from CO_MOROSOS (Cliente:%ld) %s ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return( -1 ); /* error sql */
	}
	else if( sqlca.sqlcode != SQLNOTFOUND )
	{
		strcpy( szAgente, szhCodAge );
		return 1;
	}
	else /* SQLNOTFOUND */
	{
		return 0;
	}
} /* fin ifnVerifEjecRut */

/*==================================================================================================*/
/* Funcion que verifica si un cliente tiene abonados en situacion temporal                          */
/*==================================================================================================*/
int ifnAbonadosSituacionTemporal(FILE **ptArchLog,long lCodCliente, sql_context ctxCont ) 
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	ihCntTemp;
	long	lhCodCliente;
	char  szhLetra_T [2];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnAbonadosSituacionTemporal";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

		
	ifnTrazaHilos( modulo,&pfLog,  "Ingresando Modulo %s", LOG03, modulo );
	strcpy(szhLetra_T,"T");
	lhCodCliente = lCodCliente;
	
	/* ningun abonado del cliente debe encontrarse en un situacion asociada a un estado temporal */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COUNT(*)
	INTO  :ihCntTemp
	FROM  GA_ABOCEL G
	WHERE G.COD_CLIENTE = :lhCodCliente
	AND   G.COD_SITUACION IN (SELECT COD_SITUACION
								     FROM  GA_SITUABO
								     WHERE G.COD_SITUACION = COD_SITUACION 
							        AND   TIP_SITUACION = :szhLetra_T ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL G where (G.COD_CLI\
ENTE=:b1 and G.COD_SITUACION in (select COD_SITUACION  from GA_SITUABO where (\
G.COD_SITUACION=COD_SITUACION and TIP_SITUACION=:b2)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )853;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntTemp;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_T;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	 /* marca estado temporal */
    
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error comprobando situacion temporal =>[%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return -1;
	}

	if ( ihCntTemp > 0 )	  {
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], TIENE ABONADOS CON SITUACION TEMPORAL.", LOG02, lhCodCliente );  
		return 1;
	}

	return 0;	
} /* int ifnAbonadosSituacionTemporal( long lCodCliente ) */


/*==================================================================================================*/
/* Funcion que Obtiene el tipo de plataforma de celular.       									          */
/*==================================================================================================*/
BOOL bfnGetActAbodeAccion(FILE **ptArchLog, char *szCodRutina, char *szCodTiPlan, int iCodProducto, char *szActuacionOut, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodRutina[6];
	char szhCodTiPlan[9];
	 int ihCodProducto;
	char szhCodActAbo[3]; 
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnGetActAbodeAccion";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
	memset( szhCodRutina, '\0', sizeof( szhCodRutina ) );
	memset( szhCodTiPlan, '\0', sizeof( szhCodTiPlan ) );
	memset( szhCodActAbo, '\0', sizeof( szhCodActAbo ) );

	strcpy( szhCodRutina, szCodRutina );
	strcpy( szhCodTiPlan, szCodTiPlan );
	ihCodProducto = iCodProducto;

	rtrim( szhCodRutina );
	rtrim( szhCodTiPlan );

 	ifnTrazaHilos( modulo,&pfLog,  "Parametros Entrada.\n"
							"\t\t   szhCodRutina  => [%s].\n"
							"\t\t   szhCodTiPlan  => [%s].\n"
							"\t\t   ihCodProducto => [%d].\n",
							LOG07,
							szhCodRutina,
							szhCodTiPlan,
							ihCodProducto );

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COD_ACTABO
	INTO   :szhCodActAbo
	FROM   CO_RUTINA_ACTABO_TD
	WHERE  COD_RUTINA = :szhCodRutina
	AND    COD_TIPLAN = :szhCodTiPlan
	AND    COD_PRODUCTO = :ihCodProducto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ACTABO into :b0  from CO_RUTINA_ACTABO_TD where (\
(COD_RUTINA=:b1 and COD_TIPLAN=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )880;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodActAbo;
 sqlstm.sqhstl[0] = (unsigned long )3;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodRutina;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodTiPlan;
 sqlstm.sqhstl[2] = (unsigned long )9;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "Error al recuperar COD_ACTABO => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}  

	if( sqlca.sqlcode == SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "No se encuentra definida relacion RUTINA/ACTABO.", LOG02 );
		return FALSE;
	}  

	rtrim( szhCodActAbo );
	strcpy( szActuacionOut, szhCodActAbo );
	ifnTrazaHilos( modulo,&pfLog,  "Actuacion Abonado recuperada => [%s].", LOG05, szActuacionOut );
	return TRUE;
} /* BOOL bfnGetActAbodeAccion() */


/*==================================================================================================*/
/* Funcion que Busca el codigo de Activacion en Central para la actuacion de abonado                */
/*==================================================================================================*/
int ifnGetActuacionCentralCelularAcc(FILE **ptArchLog, char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int ihCodActCen   = 0;
	int ihCodProducto = 0;
	char szhActAbo    [3];	/* EXEC SQL VAR szhActAbo IS STRING(3); */ 

	char szhCodModulo [3];  /* EXEC SQL VAR szhCodModulo IS STRING(3); */ 

	char szhCodTecnologia[iLENCODTECNO];	/* EXEC SQL VAR szhCodTecnologia IS STRING(iLENCODTECNO); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnGetActuacionCentralCelularAcc";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo => [%s].", LOG05, modulo );
 	ifnTrazaHilos( modulo,&pfLog,  	"Parametros entrada.\n"
							"\t\t   szhActAbo        => [%s],\n"
							"\t\t   ihCodProducto    => [%d],\n"
							"\t\t   szhCodModulo     => [%s],\n"
							"\t\t   szhCodTecnologia => [%s],\n",
							LOG05,
							szActAbo,
							iCodProducto,
							szCodModulo,
							szCodTecnologia );

	memset( szhActAbo, '\0', sizeof( szhActAbo ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	
	strcpy( szhActAbo, szActAbo );
	strcpy( szhCodModulo, szCodModulo );
	strcpy( szhCodTecnologia, szCodTecnologia );
	ihCodProducto = iCodProducto;
	
	rtrim( szhActAbo );
	rtrim( szhCodModulo );
	rtrim( szhCodTecnologia );
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COD_ACTCEN
	INTO  :ihCodActCen
	FROM  GA_ACTABO
	WHERE COD_ACTABO = :szhActAbo
	AND   COD_PRODUCTO = :ihCodProducto
	AND   COD_MODULO = :szhCodModulo
	AND   COD_TECNOLOGIA = :szhCodTecnologia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ACTCEN into :b0  from GA_ACTABO where (((COD_ACTA\
BO=:b1 and COD_PRODUCTO=:b2) and COD_MODULO=:b3) and COD_TECNOLOGIA=:b4)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )911;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodActCen;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhActAbo;
 sqlstm.sqhstl[1] = (unsigned long )3;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodModulo;
 sqlstm.sqhstl[3] = (unsigned long )3;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodTecnologia;
 sqlstm.sqhstl[4] = (unsigned long )9;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {  
		ifnTrazaHilos( modulo,&pfLog,  "ACTABO => [%s], TECNOLOGIA => [%s], Recuperando Actuacion Central => [%s].", LOG00, szhActAbo, szhCodTecnologia, sqlca.sqlerrm.sqlerrmc );
		return -1;
	} 

	if( sqlca.sqlcode == SQLNOTFOUND )	 {  
		ifnTrazaHilos( modulo,&pfLog,  "ACTABO => [%s], TECNOLOGIA => [%s], No se encuentra definida en Actuaciones Abonado.", LOG01, szhActAbo, szhCodTecnologia );
		return -1;
	} 

	ifnTrazaHilos( modulo,&pfLog,  "ACTABO => [%s], TECNOLOGIA => [%s], Actuacion Central => [%d].", LOG05, szhActAbo, szhCodTecnologia, ihCodActCen );
	return ihCodActCen;
} /* int ifnGetActuacionCentralCelularAcc( char *szActAbo ) */

/*==================================================================================================*/
/* Funcion que deleta la co_param_acciones por secuencia															 */
/*==================================================================================================*/
BOOL bfnBorrarCoParamAcc(FILE **ptArchLog, long lNumSecuencia, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumSecuencia;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnBorrarCoParamAcc";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

		
	lhNumSecuencia = lNumSecuencia;
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	DELETE FROM CO_PARAM_ACCIONES WHERE NUM_SECUENCIA = :lhNumSecuencia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_PARAM_ACCIONES  where NUM_SECUENCIA=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )946;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
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


	
	if( sqlca.sqlcode != SQLOK )	{   
		ifnTrazaHilos( modulo,&pfLog,  "( Secuencia = %ld ) DELETE CO_PARAM_ACCIONES => [%s].", LOG00, lhNumSecuencia, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;   
	}
	
	ifnTrazaHilos( modulo,&pfLog,  "( Secuencia = %ld ) Se borro de CO_PARAM_ACCIONES.", LOG05, lhNumSecuencia );  

	return TRUE;
} /* BOOL bfnBorrarCoParamAcc */


/*====================================================================================================*/
/* Funcion que recupera los codigos de suspension/rehabilitacion de acuerdo a la actuacion de entrada */
/*====================================================================================================*/
BOOL bfnGetCodSuspReha(FILE **ptArchLog, int iCodActuacion, char *szCodAccion, int iCodProducto, char *szCodModulo, char *szCodSuspReha, sql_context ctxCont )
{
struct sqlca sqlca;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int ihCodActuacionCen  ;
	int ihCodProducto      ;	
	char szhCodModulo   [3]; /* EXEC SQL VAR szhCodModulo IS STRING(3); */ 
 
	char szhCodSuspReha [4]; /* EXEC SQL VAR szhCodSuspReha IS STRING(4); */ 
 
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnGetCodSuspReha";
char szAccion[2];
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

		
	ifnTrazaHilos( modulo,&pfLog,  "Ingreso a modulo => [%s].", LOG05, modulo );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );
	memset( szhCodSuspReha, '\0', sizeof( szhCodSuspReha ) );
	memset( szAccion, '\0', sizeof( szAccion ) );
	
	ihCodActuacionCen = iCodActuacion;
	ihCodProducto = iCodProducto;
	strcpy( szhCodModulo, szCodModulo );
	strcpy( szAccion, szCodAccion );
	
	rtrim( szhCodModulo );
	rtrim( szAccion );
	
	ifnTrazaHilos( modulo,&pfLog,  "Parametros de Entrada.\n"
							"\t\t   ihCodProducto     => [%d],\n"
							"\t\t   ihCodActuacionCen => [%d],\n"
							"\t\t   szhCodModulo      => [%s],\n"
							"\t\t   szAccion          => [%s],\n",
							LOG05,
							ihCodProducto,
							ihCodActuacionCen,
							szhCodModulo,
							szAccion );
	
	/* buscamos el codigo de actuacion, segun corresponda */
	if( !strcmp( szAccion, szACCIONSUSP ) )	{
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		SELECT COD_SUSPREHA
		INTO   :szhCodSuspReha
		FROM   ICG_SUSPREHAMOD
		WHERE  COD_PRODUCTO = :ihCodProducto
		AND    COD_ACTUACION_SUSP = :ihCodActuacionCen
		AND    COD_MODULO   = :szhCodModulo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_SUSPREHA into :b0  from ICG_SUSPREHAMOD where ((\
COD_PRODUCTO=:b1 and COD_ACTUACION_SUSP=:b2) and COD_MODULO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )965;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodSuspReha;
  sqlstm.sqhstl[0] = (unsigned long )4;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodActuacionCen;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodModulo;
  sqlstm.sqhstl[3] = (unsigned long )3;
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


	}
	else
	{
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		SELECT COD_SUSPREHA
		INTO   :szhCodSuspReha
		FROM   ICG_SUSPREHAMOD
		WHERE  COD_PRODUCTO = :ihCodProducto
		AND    COD_ACTUACION_REHA = :ihCodActuacionCen
		AND    COD_MODULO   = :szhCodModulo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_SUSPREHA into :b0  from ICG_SUSPREHAMOD where ((\
COD_PRODUCTO=:b1 and COD_ACTUACION_REHA=:b2) and COD_MODULO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )996;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodSuspReha;
  sqlstm.sqhstl[0] = (unsigned long )4;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodActuacionCen;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodModulo;
  sqlstm.sqhstl[3] = (unsigned long )3;
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


	}
	   
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog,  "ACTUACION => [%d], Error al recuperar Codigo SuspReha desde ICG_SUSPREHAMOD => [%s].", LOG00, ihCodActuacionCen, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	else if( sqlca.sqlcode == SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "ACTUACION => [%d], No existe en ICG_SUSPREHAMOD.", LOG01, ihCodActuacionCen );
		return FALSE;
	}

	strcpy( szCodSuspReha, szhCodSuspReha );
	ifnTrazaHilos( modulo,&pfLog,  "ACTUACION => [%d], Valor Retorno COD_SUSPREHA=> [%s].", LOG05, ihCodActuacionCen, szCodSuspReha );

	return TRUE;
} /* BOOL bfnGetCodSuspReha () */


/*==================================================================================================*/
/* Funcion que Recupera la causa de suspension de acuerdo al codigo suspreha de entrada             */
/*==================================================================================================*/
BOOL bfnGetCodCausaSusp(FILE **ptArchLog, char *szCodSuspReha, char *szCausaSuspension, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodSuspReha [4];	/* EXEC SQL VAR szhCodSuspReha  IS STRING(4); */ 
 
	char szhCodCausaSusp[4];	/* EXEC SQL VAR szhCodCausaSusp IS STRING(4); */ 
 
	char szhCodModuloCO [3];	/* EXEC SQL VAR szhCodModuloCO  IS STRING(3); */ 

	int  iNumUno;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnGetCodCausaSusp";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

		
	memset( szhCodSuspReha, '\0', sizeof( szhCodSuspReha ) );
	memset( szhCodCausaSusp, '\0', sizeof( szhCodCausaSusp ) );
	
	ifnTrazaHilos( modulo,&pfLog,  "Ingreso a funcion => [%s].", LOG05, modulo );
	
	sprintf( szhCodSuspReha, "%s\0", szCodSuspReha );

	iNumUno = 1;
	strcpy( szhCodModuloCO, "CO" );

	/* recuperamos causa de suspension */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COD_CAUSUSP
	INTO   :szhCodCausaSusp
	FROM   GA_CAUSUSP
	WHERE  COD_PRODUCTO = :iNumUno
	AND    COD_MODULO   = :szhCodModuloCO
	AND    COD_SUSPREHA = :szhCodSuspReha; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CAUSUSP into :b0  from GA_CAUSUSP where ((COD_PRO\
DUCTO=:b1 and COD_MODULO=:b2) and COD_SUSPREHA=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1027;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodCausaSusp;
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iNumUno;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodModuloCO;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodSuspReha;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	   
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog,  "Error al recuperar codigo causa suspension desde GA_CAUSUSP => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	else if( sqlca.sqlcode == SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Falta definir relacion para codigo => [%s] en GA_CAUSUSP.", LOG01, szhCodSuspReha );
		return FALSE;
	}

	rtrim( szhCodCausaSusp );
	strcpy( szCausaSuspension, szhCodCausaSusp );
	ifnTrazaHilos( modulo,&pfLog,  "Valor de Retorno => [%s], Causa Suspension => [%s].", LOG05, modulo, szCausaSuspension );

	return TRUE;	
} /* BOOL bfnGetCodCausaSusp( char *szCodSuspReha, char *szCausaSuspension ) */


/*==================================================================================================*/
/* Funcion que Valida si el abonado tiene otras suspensiones del mismo nivel, 						    */
/* ya sea del modulo de cobros u otro.                                                              */
/*==================================================================================================*/
int ifnValidaOtrasSuspensiones(FILE **ptArchLog, long lNumAbonado, int iNivelSusp, char *szCodSuspReha, char *szCodTecnologia, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodSuspReha             [4];	/* EXEC SQL VAR szhCodSuspReha        IS STRING (4); */ 

	char szhCodTecnologia           [9];	/* EXEC SQL VAR szhCodTecnologia      IS STRING (9); */ 

	char szhCodModuloCO             [3];	/* EXEC SQL VAR szhCodModuloCO        IS STRING (3); */ 

	char szhTablaGA_SUSPREHABO     [14];	/* EXEC SQL VAR szhTablaGA_SUSPREHABO IS STRING (14); */ 

	char szhTecnoGSM                [4];	/* EXEC SQL VAR szhTecnoGSM           IS STRING (4); */ 

	char szhTecnoSUSPUNIDIRGSM     [16];	/* EXEC SQL VAR szhTecnoSUSPUNIDIRGSM IS STRING (16); */ 

	char szhTecnoSUSPUNIDIRTDMA    [17];	/* EXEC SQL VAR szhTecnoSUSPUNIDIRTDMA IS STRING (17); */ 

	char szhTecnoSUSPBIDIRGSM      [15];	/* EXEC SQL VAR szhTecnoSUSPBIDIRGSM  IS STRING (15); */ 

	char szhTecnoSUSPBIDIRTDMA     [16];	/* EXEC SQL VAR szhTecnoSUSPBIDIRTDMA IS STRING (16); */ 

	long lhNumAbonado;
	int  ihCntSuspActual;
	int  ihCntOtrasSusp;
	int  iTipRegistroTres;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnValidaOtrasSuspensiones";
int iCntSuspActual = 0, iCntOtrasSusp = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

		 
	ifnTrazaHilos( modulo,&pfLog,  "Ingreso a modulo => [%s].", LOG05, modulo );
	
   memset(szhCodSuspReha,'\0',sizeof(szhCodSuspReha));
   memset(szhCodTecnologia,'\0',sizeof(szhCodTecnologia));
   memset(szhCodModuloCO,'\0',sizeof(szhCodModuloCO));
   memset(szhTablaGA_SUSPREHABO,'\0',sizeof(szhTablaGA_SUSPREHABO));
   memset(szhTecnoGSM,'\0',sizeof(szhTecnoGSM));
   memset(szhTecnoSUSPUNIDIRGSM,'\0',sizeof(szhTecnoSUSPUNIDIRGSM));
   memset(szhTecnoSUSPUNIDIRTDMA,'\0',sizeof(szhTecnoSUSPUNIDIRTDMA));
   memset(szhTecnoSUSPBIDIRGSM,'\0',sizeof(szhTecnoSUSPBIDIRGSM));
	memset(szhTecnoSUSPBIDIRTDMA,'\0',sizeof(szhTecnoSUSPBIDIRTDMA));
	strcpy( szhCodSuspReha        , szCodSuspReha );
	strcpy( szhCodTecnologia      , szCodTecnologia );
	strcpy( szhCodModuloCO        , "CO" );
	strcpy( szhTablaGA_SUSPREHABO , "GA_SUSPREHABO" );
	strcpy( szhTecnoGSM           , "GSM" );
	strcpy( szhTecnoSUSPUNIDIRGSM , "SUSP_UNIDIR_GSM" );
	strcpy( szhTecnoSUSPUNIDIRTDMA, "SUSP_UNIDIR_TDMA");
	strcpy( szhTecnoSUSPBIDIRGSM  , "SUSP_BIDIR_GSM" );
	strcpy( szhTecnoSUSPBIDIRTDMA , "SUSP_BIDIR_TDMA");
	
	lhNumAbonado = lNumAbonado;
	iTipRegistroTres = 3;

	ifnTrazaHilos( modulo,&pfLog,  "Parametros de Entrada.\n"
						  "\t\t   lhNumAbonado     => [%ld]\n"
						  "\t\t   iNivelSusp       => [%d]\n"
						  "\t\t   szhCodSuspReha   => [%s]\n"
						  "\t\t   szhCodTecnologia => [%s]\n",
						  LOG05,
						  lhNumAbonado,
						  iNivelSusp,
						  szhCodSuspReha,
						  szhCodTecnologia );

    /* verificamos si ya tiene la suspension a aplicar */
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL
    SELECT  /o+ index (t, pk_ga_susprehabo) o/ 
     		COUNT(1)
	 INTO  :ihCntSuspActual
    FROM  GA_SUSPREHABO t
    WHERE NUM_ABONADO  = :lhNumAbonado
    AND   COD_SERVICIO = :szhCodSuspReha
    AND   COD_MODULO   = :szhCodModuloCO
    AND   TIP_REGISTRO < :iTipRegistroTres; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select  /*+  index (t, pk_ga_susprehabo)  +*/ count(1) in\
to :b0  from GA_SUSPREHABO t where (((NUM_ABONADO=:b1 and COD_SERVICIO=:b2) an\
d COD_MODULO=:b3) and TIP_REGISTRO<:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1058;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCntSuspActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodSuspReha;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodModuloCO;
    sqlstm.sqhstl[3] = (unsigned long )3;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&iTipRegistroTres;
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

	/*2: suspension en Central */

    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )    {
		ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld], Verificando Suspension Actual => [%s].", LOG05, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return -1; 
    }                                 
	ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld], Suspension Actual  => [%d].", LOG05, lhNumAbonado, ihCntSuspActual );  

	if( iNivelSusp == 1 ) /* verificamos otras suspensiones unidireccionales */
	{
	    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	    /* EXEC SQL
	    SELECT COUNT(*)
		 INTO :ihCntOtrasSusp
	    FROM GA_SUSPREHABO
	    WHERE NUM_ABONADO = :lhNumAbonado
	    AND COD_SERVICIO IN (SELECT COD_VALOR
	       						 FROM  GED_CODIGOS
	       						 WHERE NOM_TABLA = :szhTablaGA_SUSPREHABO
	       						 AND   NOM_COLUMNA = DECODE( :szhCodTecnologia, :szhTecnoGSM ,:szhTecnoSUSPUNIDIRGSM, :szhTecnoSUSPUNIDIRTDMA) 
	       						 AND   COD_MODULO  = :szhCodModuloCO ) /o Requerimiento de Soporte - #43432 28-08-2007 capc o/
	    AND ( COD_SERVICIO != :szhCodSuspReha OR COD_MODULO != :szhCodModuloCO )
	    AND TIP_REGISTRO < :iTipRegistroTres; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 12;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  into :b0  from GA_SUSPREHABO where (((N\
UM_ABONADO=:b1 and COD_SERVICIO in (select COD_VALOR  from GED_CODIGOS where (\
(NOM_TABLA=:b2 and NOM_COLUMNA=DECODE(:b3,:b4,:b5,:b6)) and COD_MODULO=:b7))) \
and (COD_SERVICIO<>:b8 or COD_MODULO<>:b7)) and TIP_REGISTRO<:b10)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1093;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCntOtrasSusp;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
     sqlstm.sqhstv[2] = (unsigned char  *)szhTablaGA_SUSPREHABO;
     sqlstm.sqhstl[2] = (unsigned long )14;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[3] = (unsigned long )9;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhTecnoGSM;
     sqlstm.sqhstl[4] = (unsigned long )4;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhTecnoSUSPUNIDIRGSM;
     sqlstm.sqhstl[5] = (unsigned long )16;
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)szhTecnoSUSPUNIDIRTDMA;
     sqlstm.sqhstl[6] = (unsigned long )17;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhCodModuloCO;
     sqlstm.sqhstl[7] = (unsigned long )3;
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCodSuspReha;
     sqlstm.sqhstl[8] = (unsigned long )4;
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)szhCodModuloCO;
     sqlstm.sqhstl[9] = (unsigned long )3;
     sqlstm.sqhsts[9] = (         int  )0;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)&iTipRegistroTres;
     sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	/*2: suspension en Central */

	    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	    {
			ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld], Verificando otras Suspensiones => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
			return -1; 
	    }                                 
	}
	else 
	{
	    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	    /* EXEC SQL
	    SELECT COUNT(*)
		 INTO :ihCntOtrasSusp
	    FROM GA_SUSPREHABO
	    WHERE NUM_ABONADO = :lhNumAbonado
	    AND COD_SERVICIO IN ( SELECT COD_VALOR
	       						  FROM  GED_CODIGOS
	       						  WHERE NOM_TABLA = :szhTablaGA_SUSPREHABO 
	       						  AND   NOM_COLUMNA = DECODE( :szhCodTecnologia, :szhTecnoGSM, :szhTecnoSUSPBIDIRGSM  , :szhTecnoSUSPBIDIRTDMA) 
	       						 AND   COD_MODULO  = :szhCodModuloCO ) /o Requerimiento de Soporte - #43432 28-08-2007 capc o/
	    AND COD_SERVICIO != :szhCodSuspReha
	    AND TIP_REGISTRO < :iTipRegistroTres; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 12;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  into :b0  from GA_SUSPREHABO where (((N\
UM_ABONADO=:b1 and COD_SERVICIO in (select COD_VALOR  from GED_CODIGOS where (\
(NOM_TABLA=:b2 and NOM_COLUMNA=DECODE(:b3,:b4,:b5,:b6)) and COD_MODULO=:b7))) \
and COD_SERVICIO<>:b8) and TIP_REGISTRO<:b9)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1152;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCntOtrasSusp;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
     sqlstm.sqhstv[2] = (unsigned char  *)szhTablaGA_SUSPREHABO;
     sqlstm.sqhstl[2] = (unsigned long )14;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[3] = (unsigned long )9;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhTecnoGSM;
     sqlstm.sqhstl[4] = (unsigned long )4;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhTecnoSUSPBIDIRGSM;
     sqlstm.sqhstl[5] = (unsigned long )15;
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)szhTecnoSUSPBIDIRTDMA;
     sqlstm.sqhstl[6] = (unsigned long )16;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhCodModuloCO;
     sqlstm.sqhstl[7] = (unsigned long )3;
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCodSuspReha;
     sqlstm.sqhstl[8] = (unsigned long )4;
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&iTipRegistroTres;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

		/*2: suspension en Central */

	    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	    {
			ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld], Verificando otras Suspensiones => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
			return -1; 
	    }                                 
	} /* if( iNivelSusp == 1 ) */
	
	ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld], Otras Suspensiones => [%d].", LOG05, lhNumAbonado, ihCntOtrasSusp );  

	iCntSuspActual = 0, iCntOtrasSusp = 0;
	
	iCntSuspActual = ( ihCntSuspActual > 0 ) ? 1: 0;
	iCntOtrasSusp = ( ihCntOtrasSusp > 0 ) ? 2: 0;

	ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld], Total Suspensiones => [%d].", LOG05, lhNumAbonado, iCntSuspActual + iCntOtrasSusp );  
   return ( iCntSuspActual + iCntOtrasSusp );
} /* int ifnValidaOtrasSuspensiones() */


/*==================================================================================================*/
/* Funcion que envia la suspension a la icc_movimientos para que las tome centrales                 */
/*==================================================================================================*/ 
int ifnSuspende( FILE **ptArchLog, long lAbonado,  char *szCodSituacionAbo, long lNumCelular, int iPlexsys, int iCentral, 
				 char *szNumSerieHex,  int iNumMin, char *szCauSusp, int iCodActCen, char *szTipTerm, 
				 char *szCodSuspReha, char *szCodActAbo, char *szCodTecnologia, char *szNumSerie, 
				 char *szNumImei, char *szNumImsi, int iFlagCentral, char *szCodTiPlan, char *szCodPlanTarif,
				 char *szCod_Enrut, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNumAbonado = lAbonado;			/* PARAMETRO */
	long lhNumTerminal= lNumCelular;	   /* PARAMETRO */
	int ihCodCentral  = iCentral;			/* PARAMETRO */
	int ihNumMin = iNumMin;			   	/* PARAMETRO */
	int ihCodActCen = iCodActCen;			/* PARAMETRO */
	long lhNumMovimiento = 0;
	long lhNumMovimiento2 = 0;
	char szhCodCauSusp[3];					/* EXEC SQL VAR szhCodCauSusp IS STRING(3); */ 
 
	char szhNumSerieHex[9];					/* EXEC SQL VAR szhNumSerieHex IS STRING(9); */ 

	char szhTipTerminal[2];					/* EXEC SQL VAR szhTipTerminal IS STRING(2); */ 

	char szhCodSuspReha[4];					/* EXEC SQL VAR szhCodSuspReha IS STRING(4); */ 
 
	char szhNumTerminal[16];				/* EXEC SQL VAR szhNumTerminal IS STRING(16); */ 

	char szhConServRoaming[4];				/* EXEC SQL VAR szhConServRoaming IS STRING (4); */ 

	char szhSinServRoaming[4];				/* EXEC SQL VAR szhSinServRoaming IS STRING (4); */ 

	char szhCodServicios[256];				/* EXEC SQL VAR szhCodServicios IS STRING (256); */ 

	char szhCodEstadoNeo[4];				/* EXEC SQL VAR szhCodEstadoNeo IS STRING (4); */ 

	char szhCodActAbo[4];					/* EXEC SQL VAR szhCodActAbo IS STRING (4); */ 

	char szhCodTecnologia[iLENCODTECNO];/* EXEC SQL VAR szhCodTecnologia IS STRING (iLENCODTECNO); */ 

	char szhNumSerie[iLENNUMSERIE];		/* EXEC SQL VAR szhNumSerie IS STRING (iLENNUMSERIE); */ 

	char szhNumImei[iLENNUMIMEI];			/* EXEC SQL VAR szhNumImei IS STRING (iLENNUMIMEI); */ 

	char szhNumImsi[iLENNUMIMSI];			/* EXEC SQL VAR szhNumImsi IS STRING (iLENNUMIMSI); */ 

	char szhCodTiPlan[9];					/* EXEC SQL VAR szhCodTiPlan IS STRING (9); */ 
    /* Homol.a TMM-0747 17.08.2004 GAC */	
	char szhCodPlanTarif[4];				/* EXEC SQL VAR szhCodPlanTarif IS STRING (4); */ 
 /* Homol.a TMM-0747 17.08.2004 GAC */	
	int  ihCod_Enrut      ;
	char szhModuloCO   [3];					/* EXEC SQL VAR szhModuloCO     IS STRING (3); */ 

	char szhTipSuspT   [2];					/* EXEC SQL VAR szhTipSuspT     IS STRING (2); */ 

	char szhStaS       [2];					/* EXEC SQL VAR szhStaS         IS STRING (2); */ 

	char szhRespPend   [10];				/* EXEC SQL VAR szhRespPend     IS STRING (10); */ 

	char szhEstado_ERP [4]; 				/* EXEC SQL VAR szhEstado_ERP   IS STRING (4); */ 

	char szhBlanco     [2]; 				/* EXEC SQL VAR szhBlanco       IS STRING (2); */ 

   int  iNumCero;
   int  iNumUno;
   int  iNumDos;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnSuspende";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	memset( szhCodCauSusp, '\0', sizeof( szhCodCauSusp ) );
	memset( szhNumSerieHex, '\0', sizeof( szhNumSerieHex ) );
	memset( szhTipTerminal, '\0', sizeof( szhTipTerminal ) );
	memset( szhCodSuspReha, '\0', sizeof( szhCodSuspReha ) );
	memset( szhNumTerminal, '\0', sizeof( szhNumTerminal ) );
	memset( szhConServRoaming, '\0', sizeof( szhConServRoaming ) );
	memset( szhSinServRoaming, '\0', sizeof( szhSinServRoaming ) );
	memset( szhCodServicios, '\0', sizeof( szhCodServicios ) );
	memset( szhCodEstadoNeo, '\0', sizeof( szhCodEstadoNeo ) );
	memset( szhCodActAbo, '\0', sizeof( szhCodActAbo ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	memset( szhNumSerie, '\0', sizeof( szhNumSerie ) );
	memset( szhNumImei, '\0', sizeof( szhNumImei ) );
	memset( szhNumImsi, '\0', sizeof( szhNumImsi ) );

	strcpy( szhNumSerieHex, szNumSerieHex );		/* PARAMETRO */
   strcpy( szhCodCauSusp, szCauSusp );				/* PARAMETRO */   
   strcpy( szhTipTerminal, szTipTerm );			/* PARAMETRO */   
   strcpy( szhCodSuspReha, szCodSuspReha );		/* PARAMETRO */
   strcpy( szhCodTiPlan, szCodTiPlan );		   /* PARAMETRO  Homol.a TMM-0747 17.08.2004 GAC */
   strcpy( szhCodPlanTarif, szCodPlanTarif );	/* PARAMETRO  Homol.a TMM-0747 17.08.2004 GAC */
   strcpy( szhCodTecnologia, szCodTecnologia );
	strcpy( szhNumSerie, szNumSerie );
	strcpy( szhNumImei, szNumImei );
	strcpy( szhNumImsi, szNumImsi );
	ihCod_Enrut = atoi(szCod_Enrut);

	strcpy( szhModuloCO  , "CO");    
	strcpy( szhTipSuspT  , "T");
	strcpy( szhStaS      , "S");
	strcpy( szhRespPend  , "PENDIENTE");
	strcpy( szhEstado_ERP, "ERP");
	strcpy( szhBlanco    , " ");

	iNumCero= 0;
   iNumUno = 1;
	iNumDos = 2; 

   /*printf("pasando suspension total....\n");	*/ /*HM-200505160045 Se agrega mensaje para ruteo*/

   sprintf( szhNumTerminal, "%ld", lNumCelular );
   sprintf( szhCodActAbo, "%s\0", szCodActAbo );
	ifnTrazaHilos( modulo,&pfLog,  	"Ingreso modulo => [%s]\n"
							"\t\t   lAbonado            => [%ld],\n" 
							"\t\t   szCodSituacionAbo   => [%s],\n"
							"\t\t   lNumCelular         => [%ld],\n"
							"\t\t   iPlexsys            => [%d],\n"
							"\t\t   iCentral            => [%d],\n"
							"\t\t   szNumSerieHex       => [%s],\n"
							"\t\t   iNumMin             => [%d],\n"
							"\t\t   szCauSusp           => [%s],\n"
							"\t\t   iCodActCen          => [%d],\n"
							"\t\t   szTipTerm           => [%s],\n"
							"\t\t   szCodSuspReha       => [%s],\n"
							"\t\t   szhCodActAbo        => [%s],\n"
							"\t\t   szhCodTecnologia    => [%s],\n"
							"\t\t   szhNumSerie         => [%s],\n"
							"\t\t   szhNumImei          => [%s],\n"
							"\t\t   szhNumImsi          => [%s],\n"
							"\t\t   szhCodTiPlan        => [%s],\n" /* Homol.a TMM-0747 17.08.2004 GAC */
							"\t\t   szhCodPlanTarif     => [%s],\n" /* Homol.a TMM-0747 17.08.2004 GAC */
							"\t\t   ihCod_Enrut         => [%d],\n"
							"\t\t   Inserta registro IC => [%s].\n",
							LOG05,
							modulo,
							lAbonado, 
							szCodSituacionAbo, 
							lNumCelular, 
							iPlexsys,
							iCentral, 
							szNumSerieHex, 
							iNumMin, 
							szCauSusp,
							iCodActCen,
							szTipTerm, 
							szCodSuspReha,
							szhCodActAbo,  
							szhCodTecnologia,
							szhNumSerie,
							szhNumImei,
							szhNumImsi,
							szhCodTiPlan,
							szhCodPlanTarif,
							ihCod_Enrut ,
							( iFlagCentral ) ? "SI" : "NO" );  
    
    if( !strcmp( szCodSituacionAbo, "AAA" ) || !strcmp( szCodSituacionAbo, "SAA" ) )  /* PARAMETRO */
    {

        if( !iFlagCentral ) /* No se inserta en la central ( se simula que ya paso por ahi ) */
        {
            sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
            /* EXEC SQL
            INSERT INTO GA_SUSPREHABO  
                   (NUM_ABONADO  ,	COD_SERVICIO,   FEC_SUSPBD,
                    COD_PRODUCTO ,	NUM_TERMINAL,   NOM_USUARORA,
                    COD_MODULO   ,	TIP_REGISTRO,   COD_CAUSUSP,
                    TIP_SUSP     ,	FEC_SUSPCEN )
            VALUES (:lhNumAbonado,	:szhCodSuspReha, SYSDATE,
                    :iNumUno     ,	:szhNumTerminal, USER   ,
                    :szhModuloCO ,	:iNumDos       , :szhCodCauSusp, 
                    :szhTipSuspT,	SYSDATE        ); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into GA_SUSPREHABO (NUM_ABONADO,COD_SERVIC\
IO,FEC_SUSPBD,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,COD_MODULO,TIP_REGISTRO,C\
OD_CAUSUSP,TIP_SUSP,FEC_SUSPCEN) values (:b0,:b1,SYSDATE,:b2,:b3,USER,:b4,:b5,\
:b6,:b7,SYSDATE)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1207;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhCodSuspReha;
            sqlstm.sqhstl[1] = (unsigned long )4;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&iNumUno;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhNumTerminal;
            sqlstm.sqhstl[3] = (unsigned long )16;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhModuloCO;
            sqlstm.sqhstl[4] = (unsigned long )3;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&iNumDos;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhCodCauSusp;
            sqlstm.sqhstl[6] = (unsigned long )3;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhTipSuspT;
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


            
            if( sqlca.sqlcode ) {   
                ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] C.SuspReha => [%s] => [%s].", LOG00, lhNumAbonado, szhCodSuspReha, sqlca.sqlerrm.sqlerrmc );
                return -1;   
            } 
            ifnTrazaHilos( modulo,&pfLog,  "Registro Insertado en GA_SUSPREHABO.", LOG05 ); 


		      sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		      /* EXEC SQL EXECUTE
		      BEGIN
			      /oIC_PR_PENALIZACION(:lhNumAbonado, :szhModuloCO, :szhCodSuspReha);o/
			      IC_PR_PENALIZACION(:lhNumAbonado, :szhModuloCO, :szhCodSuspReha, 1); /oHM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia TM-200503071296 o/
		      END;
		      END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin IC_PR_PENALIZACION ( :lhNumAbonado , :szhModulo\
CO , :szhCodSuspReha , 1 ) ; END ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1254;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhModuloCO;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodSuspReha;
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


			
		      if( sqlca.sqlcode != SQLOK )  {
 			    /*  ifnTrazaHilos( modulo,&pfLog,  "Abonado = %ld, Ejecucion de IC_PR_PENALIZACION, no fue exitosa.", LOG03, lhNumAbonado );*/
 			      ifnTrazaHilos( modulo,&pfLog,  "Abonado = %ld, Ejecucion de IC_PR_PENALIZACION, no fue exitosa. ERROR [%s] ", LOG03, lhNumAbonado,sqlca.sqlerrm.sqlerrmc ); /*HM-200505160045 18-05-2005 Soporte RyC PRM. Se agrega error en mensaje*/
 			      return -1; 
		      }
		      else  {
			     ifnTrazaHilos( modulo,&pfLog,  "IC_PR_PENALIZACION OK (Abonado:%ld) ", LOG03, lhNumAbonado);
		      }
        } 
        else /* si se inserta en la central */
        { 
			  /* Homol.a TMM-0747 17.08.2004 GAC */	
			  /* Los comandos CDMA/HIBRIDOS deben llevar el campo PLAN de la ICC_MOVIMIENTO */            
			  if ( strcmp(szhCodTecnologia,"CDMA")!= 0 || strcmp(szhCodTiPlan,"HIBRIDO") != 0 ) {
			  	sprintf( szhCodPlanTarif, "%s\0", szhCodPlanTarif );
			  }

           sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
           /* EXEC SQL
           INSERT INTO GA_SUSPREHABO 
                   (NUM_ABONADO  ,	COD_SERVICIO,   FEC_SUSPBD,
                    COD_PRODUCTO ,	NUM_TERMINAL,   NOM_USUARORA,
                    COD_MODULO   ,	TIP_REGISTRO,   COD_CAUSUSP,
                    TIP_SUSP     )
           VALUES (:lhNumAbonado,	:szhCodSuspReha, SYSDATE,
                   :iNumUno     ,	:szhNumTerminal, USER   ,
                   :szhModuloCO ,	:iNumUno       , :szhCodCauSusp,
                   :szhTipSuspT  ); */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 12;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "insert into GA_SUSPREHABO (NUM_ABONADO,COD_SERVICI\
O,FEC_SUSPBD,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,COD_MODULO,TIP_REGISTRO,CO\
D_CAUSUSP,TIP_SUSP) values (:b0,:b1,SYSDATE,:b2,:b3,USER,:b4,:b2,:b6,:b7)";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )1281;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
           sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[0] = (         int  )0;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqinds[0] = (         int  )0;
           sqlstm.sqharm[0] = (unsigned long )0;
           sqlstm.sqadto[0] = (unsigned short )0;
           sqlstm.sqtdso[0] = (unsigned short )0;
           sqlstm.sqhstv[1] = (unsigned char  *)szhCodSuspReha;
           sqlstm.sqhstl[1] = (unsigned long )4;
           sqlstm.sqhsts[1] = (         int  )0;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqinds[1] = (         int  )0;
           sqlstm.sqharm[1] = (unsigned long )0;
           sqlstm.sqadto[1] = (unsigned short )0;
           sqlstm.sqtdso[1] = (unsigned short )0;
           sqlstm.sqhstv[2] = (unsigned char  *)&iNumUno;
           sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
           sqlstm.sqhsts[2] = (         int  )0;
           sqlstm.sqindv[2] = (         short *)0;
           sqlstm.sqinds[2] = (         int  )0;
           sqlstm.sqharm[2] = (unsigned long )0;
           sqlstm.sqadto[2] = (unsigned short )0;
           sqlstm.sqtdso[2] = (unsigned short )0;
           sqlstm.sqhstv[3] = (unsigned char  *)szhNumTerminal;
           sqlstm.sqhstl[3] = (unsigned long )16;
           sqlstm.sqhsts[3] = (         int  )0;
           sqlstm.sqindv[3] = (         short *)0;
           sqlstm.sqinds[3] = (         int  )0;
           sqlstm.sqharm[3] = (unsigned long )0;
           sqlstm.sqadto[3] = (unsigned short )0;
           sqlstm.sqtdso[3] = (unsigned short )0;
           sqlstm.sqhstv[4] = (unsigned char  *)szhModuloCO;
           sqlstm.sqhstl[4] = (unsigned long )3;
           sqlstm.sqhsts[4] = (         int  )0;
           sqlstm.sqindv[4] = (         short *)0;
           sqlstm.sqinds[4] = (         int  )0;
           sqlstm.sqharm[4] = (unsigned long )0;
           sqlstm.sqadto[4] = (unsigned short )0;
           sqlstm.sqtdso[4] = (unsigned short )0;
           sqlstm.sqhstv[5] = (unsigned char  *)&iNumUno;
           sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
           sqlstm.sqhsts[5] = (         int  )0;
           sqlstm.sqindv[5] = (         short *)0;
           sqlstm.sqinds[5] = (         int  )0;
           sqlstm.sqharm[5] = (unsigned long )0;
           sqlstm.sqadto[5] = (unsigned short )0;
           sqlstm.sqtdso[5] = (unsigned short )0;
           sqlstm.sqhstv[6] = (unsigned char  *)szhCodCauSusp;
           sqlstm.sqhstl[6] = (unsigned long )3;
           sqlstm.sqhsts[6] = (         int  )0;
           sqlstm.sqindv[6] = (         short *)0;
           sqlstm.sqinds[6] = (         int  )0;
           sqlstm.sqharm[6] = (unsigned long )0;
           sqlstm.sqadto[6] = (unsigned short )0;
           sqlstm.sqtdso[6] = (unsigned short )0;
           sqlstm.sqhstv[7] = (unsigned char  *)szhTipSuspT;
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



           if( sqlca.sqlcode )  {   
                ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] C.SuspReha => [%s] => [%s].", LOG00, lhNumAbonado, szhCodSuspReha, sqlca.sqlerrm.sqlerrmc );
                return -1;   
           } 

            ifnTrazaHilos( modulo,&pfLog,  "Insercion GA_SUSPREHABO OK.", LOG05 ); 

        	   /* definimos que estado temporal corresponde en tabla ga_abocel */
        	   if( !strcmp( szhCodActAbo, "EN" ) )
        		   sprintf( szhCodEstadoNeo, "ERP\0" );
        	   else 
        	      sprintf( szhCodEstadoNeo, "STP\0" );

            ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] Situacion => [%s].", LOG05, lhNumAbonado, szhCodEstadoNeo );  
            /* Actualizamos la situacion en la GA_ABOCEL */
			   sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			   /* EXEC SQL 
			   UPDATE GA_ABOCEL SET 
			          COD_SITUACION = :szhCodEstadoNeo
			   WHERE  NUM_ABONADO   = :lhNumAbonado; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 12;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "update GA_ABOCEL  set COD_SITUACION=:b0 where NUM_ABONA\
DO=:b1";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1328;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstadoNeo;
      sqlstm.sqhstl[0] = (unsigned long )4;
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
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



            if( sqlca.sqlcode ) {   
                ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] UPDATE GA_ABOCEL => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
                return (-1);  
            } 


            /*- Obtiene los Codigos de Servicio Roaming de GA_DATOSGENER -----------------------*/
            sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
            /* EXEC SQL
            SELECT COD_CONSERVROAMING,COD_SINSERVROAMING
            INTO   :szhConServRoaming, :szhSinServRoaming  /o '108' '109' o/
            FROM  GA_DATOSGENER; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select COD_CONSERVROAMING ,COD_SINSERVROAMING int\
o :b0,:b1  from GA_DATOSGENER ";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1351;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhConServRoaming;
            sqlstm.sqhstl[0] = (unsigned long )4;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhSinServRoaming;
            sqlstm.sqhstl[1] = (unsigned long )4;
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
                ifnTrazaHilos( modulo,&pfLog, "SELECT COD_CONSERVROAMING FROM GA_DATOSGENER\n"
                                    "(Abonado:%ld|CodSRMor:%s|NumTerminal:%s|CausaSusp:%s)\n"
                                    "%s"
                                   ,LOG00,lhNumAbonado,szhCodSuspReha,szhNumTerminal,szhCodCauSusp,sqlca.sqlerrm.sqlerrmc);  
                return (-1);   
            }

            memset(szhCodServicios,'\0',sizeof(szhCodServicios));
            
            /* bfnDBInsMovCentral ----------------------------------------------------*/
			   sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			   /* EXEC SQL
			   SELECT ICC_SEQ_NUMMOV.NEXTVAL
			   INTO  :lhNumMovimiento
			   FROM  DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 12;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1374;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
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



            if( sqlca.sqlcode )  {   
                ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] ICC_SEQ_NUMMOV.NEXTVAL 1 => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
                return (-1);   
            } 

            if( iPlexsys == 1 ) /* Es un Plexsys */ /* PARAMETRO */
            {
				   sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
				   /* EXEC SQL
				   SELECT ICC_SEQ_NUMMOV.NEXTVAL
				   INTO :lhNumMovimiento2
				   FROM DUAL; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 12;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )1393;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento2;
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


                
               if( sqlca.sqlcode ) {   
					   ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] ICC_SEQ_NUMMOV.NEXTVAL 2 => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
                  return (-1);  
               } 
    
               sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
               /* EXEC SQL
               INSERT  INTO ICC_MOVIMIENTO
                      (NUM_MOVIMIENTO  ,	NUM_ABONADO   ,  COD_ESTADO,
                       COD_MODULO      ,	NUM_INTENTOS  ,  DES_RESPUESTA,
                       COD_ACTUACION   , 	COD_ACTABO    ,  NOM_USUARORA,
                       FEC_INGRESO     ,	COD_CENTRAL   ,  NUM_CELULAR,
                       NUM_SERIE       ,	TIP_TERMINAL  ,  COD_SUSPREHA,
                       IND_BLOQUEO     ,	NUM_MOVPOS    ,  NUM_MIN,
                       STA             ,	COD_SERVICIOS ,  TIP_ENRUTAMIENTO,
                       COD_ENRUTAMIENTO,	TIP_TECNOLOGIA,  IMEI,				
                       IMSI            ,	ICC           ,  PLAN)
               VALUES (:lhNumMovimiento,	:lhNumAbonado    , :iNumUno	 ,
                       :szhModuloCO    ,	:iNumCero        , :szhRespPend,
                       :ihCodActCen    ,	:szhCodActAbo    , USER,
                       SYSDATE         ,	:ihCodCentral    , :lhNumTerminal,
                       :szhNumSerieHex ,  :szhTipTerminal  , :szhCodSuspReha,
                       :iNumCero       ,  :lhNumMovimiento2,:ihNumMin,
                       :szhStaS        ,	:szhCodServicios ,   
                       DECODE( :szhCodEstadoNeo, :szhEstado_ERP, :iNumUno , NULL ),
                       :ihCod_Enrut    ,
   					     :szhCodTecnologia,	
   					     DECODE( :szhNumImei,  :szhBlanco, NULL, :szhNumImei  ),
   					     DECODE( :szhNumImsi,  :szhBlanco, NULL, :szhNumImsi  ),
					        DECODE( :szhNumSerie, :szhBlanco, NULL, :szhNumSerie ),
					        :szhCodPlanTarif ); */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 33;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM\
_ABONADO,COD_ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_AC\
TABO,NOM_USUARORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,C\
OD_SUSPREHA,IND_BLOQUEO,NUM_MOVPOS,NUM_MIN,STA,COD_SERVICIOS,TIP_ENRUTAMIENTO,\
COD_ENRUTAMIENTO,TIP_TECNOLOGIA,IMEI,IMSI,ICC,PLAN) values (:b0,:b1,:b2,:b3,:b\
4,:b5,:b6,:b7,USER,SYSDATE,:b8,:b9,:b10,:b11,:b12,:b4,:b14,:b15,:b16,:b17,DECO\
DE(:b18,:b19,:b2,null ),:b21,:b22,DECODE(:b23,:b24,null ,:b23),DECODE(:b26,:b2\
4,null ,:b26),DECODE(:b29,:b24,null ,:b29),:b32)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )1412;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
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
               sqlstm.sqhstv[2] = (unsigned char  *)&iNumUno;
               sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)szhModuloCO;
               sqlstm.sqhstl[3] = (unsigned long )3;
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)&iNumCero;
               sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[4] = (         int  )0;
               sqlstm.sqindv[4] = (         short *)0;
               sqlstm.sqinds[4] = (         int  )0;
               sqlstm.sqharm[4] = (unsigned long )0;
               sqlstm.sqadto[4] = (unsigned short )0;
               sqlstm.sqtdso[4] = (unsigned short )0;
               sqlstm.sqhstv[5] = (unsigned char  *)szhRespPend;
               sqlstm.sqhstl[5] = (unsigned long )10;
               sqlstm.sqhsts[5] = (         int  )0;
               sqlstm.sqindv[5] = (         short *)0;
               sqlstm.sqinds[5] = (         int  )0;
               sqlstm.sqharm[5] = (unsigned long )0;
               sqlstm.sqadto[5] = (unsigned short )0;
               sqlstm.sqtdso[5] = (unsigned short )0;
               sqlstm.sqhstv[6] = (unsigned char  *)&ihCodActCen;
               sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[6] = (         int  )0;
               sqlstm.sqindv[6] = (         short *)0;
               sqlstm.sqinds[6] = (         int  )0;
               sqlstm.sqharm[6] = (unsigned long )0;
               sqlstm.sqadto[6] = (unsigned short )0;
               sqlstm.sqtdso[6] = (unsigned short )0;
               sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
               sqlstm.sqhstl[7] = (unsigned long )4;
               sqlstm.sqhsts[7] = (         int  )0;
               sqlstm.sqindv[7] = (         short *)0;
               sqlstm.sqinds[7] = (         int  )0;
               sqlstm.sqharm[7] = (unsigned long )0;
               sqlstm.sqadto[7] = (unsigned short )0;
               sqlstm.sqtdso[7] = (unsigned short )0;
               sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentral;
               sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[8] = (         int  )0;
               sqlstm.sqindv[8] = (         short *)0;
               sqlstm.sqinds[8] = (         int  )0;
               sqlstm.sqharm[8] = (unsigned long )0;
               sqlstm.sqadto[8] = (unsigned short )0;
               sqlstm.sqtdso[8] = (unsigned short )0;
               sqlstm.sqhstv[9] = (unsigned char  *)&lhNumTerminal;
               sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[9] = (         int  )0;
               sqlstm.sqindv[9] = (         short *)0;
               sqlstm.sqinds[9] = (         int  )0;
               sqlstm.sqharm[9] = (unsigned long )0;
               sqlstm.sqadto[9] = (unsigned short )0;
               sqlstm.sqtdso[9] = (unsigned short )0;
               sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerieHex;
               sqlstm.sqhstl[10] = (unsigned long )9;
               sqlstm.sqhsts[10] = (         int  )0;
               sqlstm.sqindv[10] = (         short *)0;
               sqlstm.sqinds[10] = (         int  )0;
               sqlstm.sqharm[10] = (unsigned long )0;
               sqlstm.sqadto[10] = (unsigned short )0;
               sqlstm.sqtdso[10] = (unsigned short )0;
               sqlstm.sqhstv[11] = (unsigned char  *)szhTipTerminal;
               sqlstm.sqhstl[11] = (unsigned long )2;
               sqlstm.sqhsts[11] = (         int  )0;
               sqlstm.sqindv[11] = (         short *)0;
               sqlstm.sqinds[11] = (         int  )0;
               sqlstm.sqharm[11] = (unsigned long )0;
               sqlstm.sqadto[11] = (unsigned short )0;
               sqlstm.sqtdso[11] = (unsigned short )0;
               sqlstm.sqhstv[12] = (unsigned char  *)szhCodSuspReha;
               sqlstm.sqhstl[12] = (unsigned long )4;
               sqlstm.sqhsts[12] = (         int  )0;
               sqlstm.sqindv[12] = (         short *)0;
               sqlstm.sqinds[12] = (         int  )0;
               sqlstm.sqharm[12] = (unsigned long )0;
               sqlstm.sqadto[12] = (unsigned short )0;
               sqlstm.sqtdso[12] = (unsigned short )0;
               sqlstm.sqhstv[13] = (unsigned char  *)&iNumCero;
               sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[13] = (         int  )0;
               sqlstm.sqindv[13] = (         short *)0;
               sqlstm.sqinds[13] = (         int  )0;
               sqlstm.sqharm[13] = (unsigned long )0;
               sqlstm.sqadto[13] = (unsigned short )0;
               sqlstm.sqtdso[13] = (unsigned short )0;
               sqlstm.sqhstv[14] = (unsigned char  *)&lhNumMovimiento2;
               sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[14] = (         int  )0;
               sqlstm.sqindv[14] = (         short *)0;
               sqlstm.sqinds[14] = (         int  )0;
               sqlstm.sqharm[14] = (unsigned long )0;
               sqlstm.sqadto[14] = (unsigned short )0;
               sqlstm.sqtdso[14] = (unsigned short )0;
               sqlstm.sqhstv[15] = (unsigned char  *)&ihNumMin;
               sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[15] = (         int  )0;
               sqlstm.sqindv[15] = (         short *)0;
               sqlstm.sqinds[15] = (         int  )0;
               sqlstm.sqharm[15] = (unsigned long )0;
               sqlstm.sqadto[15] = (unsigned short )0;
               sqlstm.sqtdso[15] = (unsigned short )0;
               sqlstm.sqhstv[16] = (unsigned char  *)szhStaS;
               sqlstm.sqhstl[16] = (unsigned long )2;
               sqlstm.sqhsts[16] = (         int  )0;
               sqlstm.sqindv[16] = (         short *)0;
               sqlstm.sqinds[16] = (         int  )0;
               sqlstm.sqharm[16] = (unsigned long )0;
               sqlstm.sqadto[16] = (unsigned short )0;
               sqlstm.sqtdso[16] = (unsigned short )0;
               sqlstm.sqhstv[17] = (unsigned char  *)szhCodServicios;
               sqlstm.sqhstl[17] = (unsigned long )256;
               sqlstm.sqhsts[17] = (         int  )0;
               sqlstm.sqindv[17] = (         short *)0;
               sqlstm.sqinds[17] = (         int  )0;
               sqlstm.sqharm[17] = (unsigned long )0;
               sqlstm.sqadto[17] = (unsigned short )0;
               sqlstm.sqtdso[17] = (unsigned short )0;
               sqlstm.sqhstv[18] = (unsigned char  *)szhCodEstadoNeo;
               sqlstm.sqhstl[18] = (unsigned long )4;
               sqlstm.sqhsts[18] = (         int  )0;
               sqlstm.sqindv[18] = (         short *)0;
               sqlstm.sqinds[18] = (         int  )0;
               sqlstm.sqharm[18] = (unsigned long )0;
               sqlstm.sqadto[18] = (unsigned short )0;
               sqlstm.sqtdso[18] = (unsigned short )0;
               sqlstm.sqhstv[19] = (unsigned char  *)szhEstado_ERP;
               sqlstm.sqhstl[19] = (unsigned long )4;
               sqlstm.sqhsts[19] = (         int  )0;
               sqlstm.sqindv[19] = (         short *)0;
               sqlstm.sqinds[19] = (         int  )0;
               sqlstm.sqharm[19] = (unsigned long )0;
               sqlstm.sqadto[19] = (unsigned short )0;
               sqlstm.sqtdso[19] = (unsigned short )0;
               sqlstm.sqhstv[20] = (unsigned char  *)&iNumUno;
               sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[20] = (         int  )0;
               sqlstm.sqindv[20] = (         short *)0;
               sqlstm.sqinds[20] = (         int  )0;
               sqlstm.sqharm[20] = (unsigned long )0;
               sqlstm.sqadto[20] = (unsigned short )0;
               sqlstm.sqtdso[20] = (unsigned short )0;
               sqlstm.sqhstv[21] = (unsigned char  *)&ihCod_Enrut;
               sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[21] = (         int  )0;
               sqlstm.sqindv[21] = (         short *)0;
               sqlstm.sqinds[21] = (         int  )0;
               sqlstm.sqharm[21] = (unsigned long )0;
               sqlstm.sqadto[21] = (unsigned short )0;
               sqlstm.sqtdso[21] = (unsigned short )0;
               sqlstm.sqhstv[22] = (unsigned char  *)szhCodTecnologia;
               sqlstm.sqhstl[22] = (unsigned long )9;
               sqlstm.sqhsts[22] = (         int  )0;
               sqlstm.sqindv[22] = (         short *)0;
               sqlstm.sqinds[22] = (         int  )0;
               sqlstm.sqharm[22] = (unsigned long )0;
               sqlstm.sqadto[22] = (unsigned short )0;
               sqlstm.sqtdso[22] = (unsigned short )0;
               sqlstm.sqhstv[23] = (unsigned char  *)szhNumImei;
               sqlstm.sqhstl[23] = (unsigned long )26;
               sqlstm.sqhsts[23] = (         int  )0;
               sqlstm.sqindv[23] = (         short *)0;
               sqlstm.sqinds[23] = (         int  )0;
               sqlstm.sqharm[23] = (unsigned long )0;
               sqlstm.sqadto[23] = (unsigned short )0;
               sqlstm.sqtdso[23] = (unsigned short )0;
               sqlstm.sqhstv[24] = (unsigned char  *)szhBlanco;
               sqlstm.sqhstl[24] = (unsigned long )2;
               sqlstm.sqhsts[24] = (         int  )0;
               sqlstm.sqindv[24] = (         short *)0;
               sqlstm.sqinds[24] = (         int  )0;
               sqlstm.sqharm[24] = (unsigned long )0;
               sqlstm.sqadto[24] = (unsigned short )0;
               sqlstm.sqtdso[24] = (unsigned short )0;
               sqlstm.sqhstv[25] = (unsigned char  *)szhNumImei;
               sqlstm.sqhstl[25] = (unsigned long )26;
               sqlstm.sqhsts[25] = (         int  )0;
               sqlstm.sqindv[25] = (         short *)0;
               sqlstm.sqinds[25] = (         int  )0;
               sqlstm.sqharm[25] = (unsigned long )0;
               sqlstm.sqadto[25] = (unsigned short )0;
               sqlstm.sqtdso[25] = (unsigned short )0;
               sqlstm.sqhstv[26] = (unsigned char  *)szhNumImsi;
               sqlstm.sqhstl[26] = (unsigned long )51;
               sqlstm.sqhsts[26] = (         int  )0;
               sqlstm.sqindv[26] = (         short *)0;
               sqlstm.sqinds[26] = (         int  )0;
               sqlstm.sqharm[26] = (unsigned long )0;
               sqlstm.sqadto[26] = (unsigned short )0;
               sqlstm.sqtdso[26] = (unsigned short )0;
               sqlstm.sqhstv[27] = (unsigned char  *)szhBlanco;
               sqlstm.sqhstl[27] = (unsigned long )2;
               sqlstm.sqhsts[27] = (         int  )0;
               sqlstm.sqindv[27] = (         short *)0;
               sqlstm.sqinds[27] = (         int  )0;
               sqlstm.sqharm[27] = (unsigned long )0;
               sqlstm.sqadto[27] = (unsigned short )0;
               sqlstm.sqtdso[27] = (unsigned short )0;
               sqlstm.sqhstv[28] = (unsigned char  *)szhNumImsi;
               sqlstm.sqhstl[28] = (unsigned long )51;
               sqlstm.sqhsts[28] = (         int  )0;
               sqlstm.sqindv[28] = (         short *)0;
               sqlstm.sqinds[28] = (         int  )0;
               sqlstm.sqharm[28] = (unsigned long )0;
               sqlstm.sqadto[28] = (unsigned short )0;
               sqlstm.sqtdso[28] = (unsigned short )0;
               sqlstm.sqhstv[29] = (unsigned char  *)szhNumSerie;
               sqlstm.sqhstl[29] = (unsigned long )26;
               sqlstm.sqhsts[29] = (         int  )0;
               sqlstm.sqindv[29] = (         short *)0;
               sqlstm.sqinds[29] = (         int  )0;
               sqlstm.sqharm[29] = (unsigned long )0;
               sqlstm.sqadto[29] = (unsigned short )0;
               sqlstm.sqtdso[29] = (unsigned short )0;
               sqlstm.sqhstv[30] = (unsigned char  *)szhBlanco;
               sqlstm.sqhstl[30] = (unsigned long )2;
               sqlstm.sqhsts[30] = (         int  )0;
               sqlstm.sqindv[30] = (         short *)0;
               sqlstm.sqinds[30] = (         int  )0;
               sqlstm.sqharm[30] = (unsigned long )0;
               sqlstm.sqadto[30] = (unsigned short )0;
               sqlstm.sqtdso[30] = (unsigned short )0;
               sqlstm.sqhstv[31] = (unsigned char  *)szhNumSerie;
               sqlstm.sqhstl[31] = (unsigned long )26;
               sqlstm.sqhsts[31] = (         int  )0;
               sqlstm.sqindv[31] = (         short *)0;
               sqlstm.sqinds[31] = (         int  )0;
               sqlstm.sqharm[31] = (unsigned long )0;
               sqlstm.sqadto[31] = (unsigned short )0;
               sqlstm.sqtdso[31] = (unsigned short )0;
               sqlstm.sqhstv[32] = (unsigned char  *)szhCodPlanTarif;
               sqlstm.sqhstl[32] = (unsigned long )4;
               sqlstm.sqhsts[32] = (         int  )0;
               sqlstm.sqindv[32] = (         short *)0;
               sqlstm.sqinds[32] = (         int  )0;
               sqlstm.sqharm[32] = (unsigned long )0;
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
               sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



                if( sqlca.sqlcode ) {   
					    ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] INSERT ICC_MOVIMIENTO 1 => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
                   return (-1);   
                }
                
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
                /* EXEC SQL
                INSERT  INTO ICC_MOVIMIENTO
                       (NUM_MOVIMIENTO    ,   NUM_ABONADO       ,   COD_ESTADO      ,
                        COD_MODULO        ,   NUM_INTENTOS      ,   DES_RESPUESTA   ,
                        COD_ACTUACION     ,   COD_ACTABO        ,   NOM_USUARORA    ,               
                        FEC_INGRESO       ,   COD_CENTRAL       ,   NUM_CELULAR     ,
                        NUM_SERIE         ,   TIP_TERMINAL      ,   COD_SUSPREHA    ,               
                        IND_BLOQUEO       ,   NUM_MOVANT        ,   NUM_MIN         ,           
                        STA               ,   COD_SERVICIOS		 ,   TIP_ENRUTAMIENTO,
                        COD_ENRUTAMIENTO  ,	 TIP_TECNOLOGIA    ,   IMEI,				
                        IMSI              ,   ICC               ,   PLAN)
                VALUES (:lhNumMovimiento2 ,   :lhNumAbonado     ,   :iNumUno	    ,
                        :szhModuloCO      ,   :iNumCero         ,   :szhRespPend    ,
                        :ihCodActCen      ,   :szhCodActAbo     ,   USER            ,
                        SYSDATE           ,   :ihCodCentral     ,   :lhNumTerminal  ,
                        :szhNumSerieHex   ,   :szhTipTerminal   ,   :szhCodSuspReha ,
                        :iNumCero         ,   :lhNumMovimiento  ,   :ihNumMin       ,
                        :szhStaS          ,   :szhCodServicios  ,
                        DECODE( :szhCodEstadoNeo, :szhEstado_ERP, :iNumUno, NULL),
                        :ihCod_Enrut      ,
   					      :szhCodTecnologia ,	  
   					      DECODE( :szhNumImei , :szhBlanco, NULL, :szhNumImei ),
   					      DECODE( :szhNumImsi , :szhBlanco, NULL, :szhNumImsi ),
					         DECODE( :szhNumSerie, :szhBlanco, NULL, :szhNumSerie ),
						      :szhCodPlanTarif ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 33;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NU\
M_ABONADO,COD_ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_A\
CTABO,NOM_USUARORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,\
COD_SUSPREHA,IND_BLOQUEO,NUM_MOVANT,NUM_MIN,STA,COD_SERVICIOS,TIP_ENRUTAMIENTO\
,COD_ENRUTAMIENTO,TIP_TECNOLOGIA,IMEI,IMSI,ICC,PLAN) values (:b0,:b1,:b2,:b3,:\
b4,:b5,:b6,:b7,USER,SYSDATE,:b8,:b9,:b10,:b11,:b12,:b4,:b14,:b15,:b16,:b17,DEC\
ODE(:b18,:b19,:b2,null ),:b21,:b22,DECODE(:b23,:b24,null ,:b23),DECODE(:b26,:b\
24,null ,:b26),DECODE(:b29,:b24,null ,:b29),:b32)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )1559;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento2;
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
                sqlstm.sqhstv[2] = (unsigned char  *)&iNumUno;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhModuloCO;
                sqlstm.sqhstl[3] = (unsigned long )3;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)&iNumCero;
                sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)szhRespPend;
                sqlstm.sqhstl[5] = (unsigned long )10;
                sqlstm.sqhsts[5] = (         int  )0;
                sqlstm.sqindv[5] = (         short *)0;
                sqlstm.sqinds[5] = (         int  )0;
                sqlstm.sqharm[5] = (unsigned long )0;
                sqlstm.sqadto[5] = (unsigned short )0;
                sqlstm.sqtdso[5] = (unsigned short )0;
                sqlstm.sqhstv[6] = (unsigned char  *)&ihCodActCen;
                sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[6] = (         int  )0;
                sqlstm.sqindv[6] = (         short *)0;
                sqlstm.sqinds[6] = (         int  )0;
                sqlstm.sqharm[6] = (unsigned long )0;
                sqlstm.sqadto[6] = (unsigned short )0;
                sqlstm.sqtdso[6] = (unsigned short )0;
                sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
                sqlstm.sqhstl[7] = (unsigned long )4;
                sqlstm.sqhsts[7] = (         int  )0;
                sqlstm.sqindv[7] = (         short *)0;
                sqlstm.sqinds[7] = (         int  )0;
                sqlstm.sqharm[7] = (unsigned long )0;
                sqlstm.sqadto[7] = (unsigned short )0;
                sqlstm.sqtdso[7] = (unsigned short )0;
                sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentral;
                sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[8] = (         int  )0;
                sqlstm.sqindv[8] = (         short *)0;
                sqlstm.sqinds[8] = (         int  )0;
                sqlstm.sqharm[8] = (unsigned long )0;
                sqlstm.sqadto[8] = (unsigned short )0;
                sqlstm.sqtdso[8] = (unsigned short )0;
                sqlstm.sqhstv[9] = (unsigned char  *)&lhNumTerminal;
                sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[9] = (         int  )0;
                sqlstm.sqindv[9] = (         short *)0;
                sqlstm.sqinds[9] = (         int  )0;
                sqlstm.sqharm[9] = (unsigned long )0;
                sqlstm.sqadto[9] = (unsigned short )0;
                sqlstm.sqtdso[9] = (unsigned short )0;
                sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerieHex;
                sqlstm.sqhstl[10] = (unsigned long )9;
                sqlstm.sqhsts[10] = (         int  )0;
                sqlstm.sqindv[10] = (         short *)0;
                sqlstm.sqinds[10] = (         int  )0;
                sqlstm.sqharm[10] = (unsigned long )0;
                sqlstm.sqadto[10] = (unsigned short )0;
                sqlstm.sqtdso[10] = (unsigned short )0;
                sqlstm.sqhstv[11] = (unsigned char  *)szhTipTerminal;
                sqlstm.sqhstl[11] = (unsigned long )2;
                sqlstm.sqhsts[11] = (         int  )0;
                sqlstm.sqindv[11] = (         short *)0;
                sqlstm.sqinds[11] = (         int  )0;
                sqlstm.sqharm[11] = (unsigned long )0;
                sqlstm.sqadto[11] = (unsigned short )0;
                sqlstm.sqtdso[11] = (unsigned short )0;
                sqlstm.sqhstv[12] = (unsigned char  *)szhCodSuspReha;
                sqlstm.sqhstl[12] = (unsigned long )4;
                sqlstm.sqhsts[12] = (         int  )0;
                sqlstm.sqindv[12] = (         short *)0;
                sqlstm.sqinds[12] = (         int  )0;
                sqlstm.sqharm[12] = (unsigned long )0;
                sqlstm.sqadto[12] = (unsigned short )0;
                sqlstm.sqtdso[12] = (unsigned short )0;
                sqlstm.sqhstv[13] = (unsigned char  *)&iNumCero;
                sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[13] = (         int  )0;
                sqlstm.sqindv[13] = (         short *)0;
                sqlstm.sqinds[13] = (         int  )0;
                sqlstm.sqharm[13] = (unsigned long )0;
                sqlstm.sqadto[13] = (unsigned short )0;
                sqlstm.sqtdso[13] = (unsigned short )0;
                sqlstm.sqhstv[14] = (unsigned char  *)&lhNumMovimiento;
                sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[14] = (         int  )0;
                sqlstm.sqindv[14] = (         short *)0;
                sqlstm.sqinds[14] = (         int  )0;
                sqlstm.sqharm[14] = (unsigned long )0;
                sqlstm.sqadto[14] = (unsigned short )0;
                sqlstm.sqtdso[14] = (unsigned short )0;
                sqlstm.sqhstv[15] = (unsigned char  *)&ihNumMin;
                sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[15] = (         int  )0;
                sqlstm.sqindv[15] = (         short *)0;
                sqlstm.sqinds[15] = (         int  )0;
                sqlstm.sqharm[15] = (unsigned long )0;
                sqlstm.sqadto[15] = (unsigned short )0;
                sqlstm.sqtdso[15] = (unsigned short )0;
                sqlstm.sqhstv[16] = (unsigned char  *)szhStaS;
                sqlstm.sqhstl[16] = (unsigned long )2;
                sqlstm.sqhsts[16] = (         int  )0;
                sqlstm.sqindv[16] = (         short *)0;
                sqlstm.sqinds[16] = (         int  )0;
                sqlstm.sqharm[16] = (unsigned long )0;
                sqlstm.sqadto[16] = (unsigned short )0;
                sqlstm.sqtdso[16] = (unsigned short )0;
                sqlstm.sqhstv[17] = (unsigned char  *)szhCodServicios;
                sqlstm.sqhstl[17] = (unsigned long )256;
                sqlstm.sqhsts[17] = (         int  )0;
                sqlstm.sqindv[17] = (         short *)0;
                sqlstm.sqinds[17] = (         int  )0;
                sqlstm.sqharm[17] = (unsigned long )0;
                sqlstm.sqadto[17] = (unsigned short )0;
                sqlstm.sqtdso[17] = (unsigned short )0;
                sqlstm.sqhstv[18] = (unsigned char  *)szhCodEstadoNeo;
                sqlstm.sqhstl[18] = (unsigned long )4;
                sqlstm.sqhsts[18] = (         int  )0;
                sqlstm.sqindv[18] = (         short *)0;
                sqlstm.sqinds[18] = (         int  )0;
                sqlstm.sqharm[18] = (unsigned long )0;
                sqlstm.sqadto[18] = (unsigned short )0;
                sqlstm.sqtdso[18] = (unsigned short )0;
                sqlstm.sqhstv[19] = (unsigned char  *)szhEstado_ERP;
                sqlstm.sqhstl[19] = (unsigned long )4;
                sqlstm.sqhsts[19] = (         int  )0;
                sqlstm.sqindv[19] = (         short *)0;
                sqlstm.sqinds[19] = (         int  )0;
                sqlstm.sqharm[19] = (unsigned long )0;
                sqlstm.sqadto[19] = (unsigned short )0;
                sqlstm.sqtdso[19] = (unsigned short )0;
                sqlstm.sqhstv[20] = (unsigned char  *)&iNumUno;
                sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[20] = (         int  )0;
                sqlstm.sqindv[20] = (         short *)0;
                sqlstm.sqinds[20] = (         int  )0;
                sqlstm.sqharm[20] = (unsigned long )0;
                sqlstm.sqadto[20] = (unsigned short )0;
                sqlstm.sqtdso[20] = (unsigned short )0;
                sqlstm.sqhstv[21] = (unsigned char  *)&ihCod_Enrut;
                sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[21] = (         int  )0;
                sqlstm.sqindv[21] = (         short *)0;
                sqlstm.sqinds[21] = (         int  )0;
                sqlstm.sqharm[21] = (unsigned long )0;
                sqlstm.sqadto[21] = (unsigned short )0;
                sqlstm.sqtdso[21] = (unsigned short )0;
                sqlstm.sqhstv[22] = (unsigned char  *)szhCodTecnologia;
                sqlstm.sqhstl[22] = (unsigned long )9;
                sqlstm.sqhsts[22] = (         int  )0;
                sqlstm.sqindv[22] = (         short *)0;
                sqlstm.sqinds[22] = (         int  )0;
                sqlstm.sqharm[22] = (unsigned long )0;
                sqlstm.sqadto[22] = (unsigned short )0;
                sqlstm.sqtdso[22] = (unsigned short )0;
                sqlstm.sqhstv[23] = (unsigned char  *)szhNumImei;
                sqlstm.sqhstl[23] = (unsigned long )26;
                sqlstm.sqhsts[23] = (         int  )0;
                sqlstm.sqindv[23] = (         short *)0;
                sqlstm.sqinds[23] = (         int  )0;
                sqlstm.sqharm[23] = (unsigned long )0;
                sqlstm.sqadto[23] = (unsigned short )0;
                sqlstm.sqtdso[23] = (unsigned short )0;
                sqlstm.sqhstv[24] = (unsigned char  *)szhBlanco;
                sqlstm.sqhstl[24] = (unsigned long )2;
                sqlstm.sqhsts[24] = (         int  )0;
                sqlstm.sqindv[24] = (         short *)0;
                sqlstm.sqinds[24] = (         int  )0;
                sqlstm.sqharm[24] = (unsigned long )0;
                sqlstm.sqadto[24] = (unsigned short )0;
                sqlstm.sqtdso[24] = (unsigned short )0;
                sqlstm.sqhstv[25] = (unsigned char  *)szhNumImei;
                sqlstm.sqhstl[25] = (unsigned long )26;
                sqlstm.sqhsts[25] = (         int  )0;
                sqlstm.sqindv[25] = (         short *)0;
                sqlstm.sqinds[25] = (         int  )0;
                sqlstm.sqharm[25] = (unsigned long )0;
                sqlstm.sqadto[25] = (unsigned short )0;
                sqlstm.sqtdso[25] = (unsigned short )0;
                sqlstm.sqhstv[26] = (unsigned char  *)szhNumImsi;
                sqlstm.sqhstl[26] = (unsigned long )51;
                sqlstm.sqhsts[26] = (         int  )0;
                sqlstm.sqindv[26] = (         short *)0;
                sqlstm.sqinds[26] = (         int  )0;
                sqlstm.sqharm[26] = (unsigned long )0;
                sqlstm.sqadto[26] = (unsigned short )0;
                sqlstm.sqtdso[26] = (unsigned short )0;
                sqlstm.sqhstv[27] = (unsigned char  *)szhBlanco;
                sqlstm.sqhstl[27] = (unsigned long )2;
                sqlstm.sqhsts[27] = (         int  )0;
                sqlstm.sqindv[27] = (         short *)0;
                sqlstm.sqinds[27] = (         int  )0;
                sqlstm.sqharm[27] = (unsigned long )0;
                sqlstm.sqadto[27] = (unsigned short )0;
                sqlstm.sqtdso[27] = (unsigned short )0;
                sqlstm.sqhstv[28] = (unsigned char  *)szhNumImsi;
                sqlstm.sqhstl[28] = (unsigned long )51;
                sqlstm.sqhsts[28] = (         int  )0;
                sqlstm.sqindv[28] = (         short *)0;
                sqlstm.sqinds[28] = (         int  )0;
                sqlstm.sqharm[28] = (unsigned long )0;
                sqlstm.sqadto[28] = (unsigned short )0;
                sqlstm.sqtdso[28] = (unsigned short )0;
                sqlstm.sqhstv[29] = (unsigned char  *)szhNumSerie;
                sqlstm.sqhstl[29] = (unsigned long )26;
                sqlstm.sqhsts[29] = (         int  )0;
                sqlstm.sqindv[29] = (         short *)0;
                sqlstm.sqinds[29] = (         int  )0;
                sqlstm.sqharm[29] = (unsigned long )0;
                sqlstm.sqadto[29] = (unsigned short )0;
                sqlstm.sqtdso[29] = (unsigned short )0;
                sqlstm.sqhstv[30] = (unsigned char  *)szhBlanco;
                sqlstm.sqhstl[30] = (unsigned long )2;
                sqlstm.sqhsts[30] = (         int  )0;
                sqlstm.sqindv[30] = (         short *)0;
                sqlstm.sqinds[30] = (         int  )0;
                sqlstm.sqharm[30] = (unsigned long )0;
                sqlstm.sqadto[30] = (unsigned short )0;
                sqlstm.sqtdso[30] = (unsigned short )0;
                sqlstm.sqhstv[31] = (unsigned char  *)szhNumSerie;
                sqlstm.sqhstl[31] = (unsigned long )26;
                sqlstm.sqhsts[31] = (         int  )0;
                sqlstm.sqindv[31] = (         short *)0;
                sqlstm.sqinds[31] = (         int  )0;
                sqlstm.sqharm[31] = (unsigned long )0;
                sqlstm.sqadto[31] = (unsigned short )0;
                sqlstm.sqtdso[31] = (unsigned short )0;
                sqlstm.sqhstv[32] = (unsigned char  *)szhCodPlanTarif;
                sqlstm.sqhstl[32] = (unsigned long )4;
                sqlstm.sqhsts[32] = (         int  )0;
                sqlstm.sqindv[32] = (         short *)0;
                sqlstm.sqinds[32] = (         int  )0;
                sqlstm.sqharm[32] = (unsigned long )0;
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
                sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	    
                if (sqlca.sqlcode) {   
					    ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] INSERT ICC_MOVIMIENTO 2 => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
                   return (-1);   
                }
            }
            else /* No es Plexsys */
            {
                
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
                /* EXEC SQL
                INSERT  INTO ICC_MOVIMIENTO
                       (NUM_MOVIMIENTO    ,   NUM_ABONADO       ,   COD_ESTADO      ,
                        COD_MODULO        ,   NUM_INTENTOS      ,   DES_RESPUESTA   ,
                        COD_ACTUACION     ,   COD_ACTABO        ,   NOM_USUARORA    ,
                        FEC_INGRESO       ,   COD_CENTRAL       ,   NUM_CELULAR     ,
                        NUM_SERIE         ,   TIP_TERMINAL      ,   COD_SUSPREHA    ,   
                        IND_BLOQUEO       ,   NUM_MIN           ,   STA             ,
                        COD_SERVICIOS     ,   TIP_ENRUTAMIENTO  ,   COD_ENRUTAMIENTO,	  
                        TIP_TECNOLOGIA    ,	 IMEI              ,   IMSI            ,   
                        ICC	            ,   PLAN )
                VALUES (:lhNumMovimiento  ,   :lhNumAbonado     ,   :iNumUno        ,
                        :szhModuloCO      ,   :iNumCero         ,   :szhRespPend    ,
                        :ihCodActCen      ,   :szhCodActAbo     ,   USER            ,
                        SYSDATE           ,   :ihCodCentral     ,   :lhNumTerminal  ,
                        :szhNumSerieHex   ,   :szhTipTerminal   ,   :szhCodSuspReha ,
                        :iNumCero         ,   :ihNumMin         ,   :szhStaS        ,
                        :szhCodServicios  ,   
                        DECODE( :szhCodEstadoNeo, :szhEstado_ERP, :iNumUno, NULL ),
                        :ihCod_Enrut      ,
					         :szhCodTecnologia ,
   					      DECODE( :szhNumImei , :szhBlanco, NULL, :szhNumImei  ),
   					      DECODE( :szhNumImsi , :szhBlanco, NULL, :szhNumImsi  ),
					         DECODE( :szhNumSerie, :szhBlanco, NULL, :szhNumSerie ),
					         :szhCodPlanTarif ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 33;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NU\
M_ABONADO,COD_ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_A\
CTABO,NOM_USUARORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,\
COD_SUSPREHA,IND_BLOQUEO,NUM_MIN,STA,COD_SERVICIOS,TIP_ENRUTAMIENTO,COD_ENRUTA\
MIENTO,TIP_TECNOLOGIA,IMEI,IMSI,ICC,PLAN) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,\
:b7,USER,SYSDATE,:b8,:b9,:b10,:b11,:b12,:b4,:b14,:b15,:b16,DECODE(:b17,:b18,:b\
2,null ),:b20,:b21,DECODE(:b22,:b23,null ,:b22),DECODE(:b25,:b23,null ,:b25),D\
ECODE(:b28,:b23,null ,:b28),:b31)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )1706;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
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
                sqlstm.sqhstv[2] = (unsigned char  *)&iNumUno;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhModuloCO;
                sqlstm.sqhstl[3] = (unsigned long )3;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)&iNumCero;
                sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)szhRespPend;
                sqlstm.sqhstl[5] = (unsigned long )10;
                sqlstm.sqhsts[5] = (         int  )0;
                sqlstm.sqindv[5] = (         short *)0;
                sqlstm.sqinds[5] = (         int  )0;
                sqlstm.sqharm[5] = (unsigned long )0;
                sqlstm.sqadto[5] = (unsigned short )0;
                sqlstm.sqtdso[5] = (unsigned short )0;
                sqlstm.sqhstv[6] = (unsigned char  *)&ihCodActCen;
                sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[6] = (         int  )0;
                sqlstm.sqindv[6] = (         short *)0;
                sqlstm.sqinds[6] = (         int  )0;
                sqlstm.sqharm[6] = (unsigned long )0;
                sqlstm.sqadto[6] = (unsigned short )0;
                sqlstm.sqtdso[6] = (unsigned short )0;
                sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
                sqlstm.sqhstl[7] = (unsigned long )4;
                sqlstm.sqhsts[7] = (         int  )0;
                sqlstm.sqindv[7] = (         short *)0;
                sqlstm.sqinds[7] = (         int  )0;
                sqlstm.sqharm[7] = (unsigned long )0;
                sqlstm.sqadto[7] = (unsigned short )0;
                sqlstm.sqtdso[7] = (unsigned short )0;
                sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentral;
                sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[8] = (         int  )0;
                sqlstm.sqindv[8] = (         short *)0;
                sqlstm.sqinds[8] = (         int  )0;
                sqlstm.sqharm[8] = (unsigned long )0;
                sqlstm.sqadto[8] = (unsigned short )0;
                sqlstm.sqtdso[8] = (unsigned short )0;
                sqlstm.sqhstv[9] = (unsigned char  *)&lhNumTerminal;
                sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[9] = (         int  )0;
                sqlstm.sqindv[9] = (         short *)0;
                sqlstm.sqinds[9] = (         int  )0;
                sqlstm.sqharm[9] = (unsigned long )0;
                sqlstm.sqadto[9] = (unsigned short )0;
                sqlstm.sqtdso[9] = (unsigned short )0;
                sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerieHex;
                sqlstm.sqhstl[10] = (unsigned long )9;
                sqlstm.sqhsts[10] = (         int  )0;
                sqlstm.sqindv[10] = (         short *)0;
                sqlstm.sqinds[10] = (         int  )0;
                sqlstm.sqharm[10] = (unsigned long )0;
                sqlstm.sqadto[10] = (unsigned short )0;
                sqlstm.sqtdso[10] = (unsigned short )0;
                sqlstm.sqhstv[11] = (unsigned char  *)szhTipTerminal;
                sqlstm.sqhstl[11] = (unsigned long )2;
                sqlstm.sqhsts[11] = (         int  )0;
                sqlstm.sqindv[11] = (         short *)0;
                sqlstm.sqinds[11] = (         int  )0;
                sqlstm.sqharm[11] = (unsigned long )0;
                sqlstm.sqadto[11] = (unsigned short )0;
                sqlstm.sqtdso[11] = (unsigned short )0;
                sqlstm.sqhstv[12] = (unsigned char  *)szhCodSuspReha;
                sqlstm.sqhstl[12] = (unsigned long )4;
                sqlstm.sqhsts[12] = (         int  )0;
                sqlstm.sqindv[12] = (         short *)0;
                sqlstm.sqinds[12] = (         int  )0;
                sqlstm.sqharm[12] = (unsigned long )0;
                sqlstm.sqadto[12] = (unsigned short )0;
                sqlstm.sqtdso[12] = (unsigned short )0;
                sqlstm.sqhstv[13] = (unsigned char  *)&iNumCero;
                sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[13] = (         int  )0;
                sqlstm.sqindv[13] = (         short *)0;
                sqlstm.sqinds[13] = (         int  )0;
                sqlstm.sqharm[13] = (unsigned long )0;
                sqlstm.sqadto[13] = (unsigned short )0;
                sqlstm.sqtdso[13] = (unsigned short )0;
                sqlstm.sqhstv[14] = (unsigned char  *)&ihNumMin;
                sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[14] = (         int  )0;
                sqlstm.sqindv[14] = (         short *)0;
                sqlstm.sqinds[14] = (         int  )0;
                sqlstm.sqharm[14] = (unsigned long )0;
                sqlstm.sqadto[14] = (unsigned short )0;
                sqlstm.sqtdso[14] = (unsigned short )0;
                sqlstm.sqhstv[15] = (unsigned char  *)szhStaS;
                sqlstm.sqhstl[15] = (unsigned long )2;
                sqlstm.sqhsts[15] = (         int  )0;
                sqlstm.sqindv[15] = (         short *)0;
                sqlstm.sqinds[15] = (         int  )0;
                sqlstm.sqharm[15] = (unsigned long )0;
                sqlstm.sqadto[15] = (unsigned short )0;
                sqlstm.sqtdso[15] = (unsigned short )0;
                sqlstm.sqhstv[16] = (unsigned char  *)szhCodServicios;
                sqlstm.sqhstl[16] = (unsigned long )256;
                sqlstm.sqhsts[16] = (         int  )0;
                sqlstm.sqindv[16] = (         short *)0;
                sqlstm.sqinds[16] = (         int  )0;
                sqlstm.sqharm[16] = (unsigned long )0;
                sqlstm.sqadto[16] = (unsigned short )0;
                sqlstm.sqtdso[16] = (unsigned short )0;
                sqlstm.sqhstv[17] = (unsigned char  *)szhCodEstadoNeo;
                sqlstm.sqhstl[17] = (unsigned long )4;
                sqlstm.sqhsts[17] = (         int  )0;
                sqlstm.sqindv[17] = (         short *)0;
                sqlstm.sqinds[17] = (         int  )0;
                sqlstm.sqharm[17] = (unsigned long )0;
                sqlstm.sqadto[17] = (unsigned short )0;
                sqlstm.sqtdso[17] = (unsigned short )0;
                sqlstm.sqhstv[18] = (unsigned char  *)szhEstado_ERP;
                sqlstm.sqhstl[18] = (unsigned long )4;
                sqlstm.sqhsts[18] = (         int  )0;
                sqlstm.sqindv[18] = (         short *)0;
                sqlstm.sqinds[18] = (         int  )0;
                sqlstm.sqharm[18] = (unsigned long )0;
                sqlstm.sqadto[18] = (unsigned short )0;
                sqlstm.sqtdso[18] = (unsigned short )0;
                sqlstm.sqhstv[19] = (unsigned char  *)&iNumUno;
                sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[19] = (         int  )0;
                sqlstm.sqindv[19] = (         short *)0;
                sqlstm.sqinds[19] = (         int  )0;
                sqlstm.sqharm[19] = (unsigned long )0;
                sqlstm.sqadto[19] = (unsigned short )0;
                sqlstm.sqtdso[19] = (unsigned short )0;
                sqlstm.sqhstv[20] = (unsigned char  *)&ihCod_Enrut;
                sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[20] = (         int  )0;
                sqlstm.sqindv[20] = (         short *)0;
                sqlstm.sqinds[20] = (         int  )0;
                sqlstm.sqharm[20] = (unsigned long )0;
                sqlstm.sqadto[20] = (unsigned short )0;
                sqlstm.sqtdso[20] = (unsigned short )0;
                sqlstm.sqhstv[21] = (unsigned char  *)szhCodTecnologia;
                sqlstm.sqhstl[21] = (unsigned long )9;
                sqlstm.sqhsts[21] = (         int  )0;
                sqlstm.sqindv[21] = (         short *)0;
                sqlstm.sqinds[21] = (         int  )0;
                sqlstm.sqharm[21] = (unsigned long )0;
                sqlstm.sqadto[21] = (unsigned short )0;
                sqlstm.sqtdso[21] = (unsigned short )0;
                sqlstm.sqhstv[22] = (unsigned char  *)szhNumImei;
                sqlstm.sqhstl[22] = (unsigned long )26;
                sqlstm.sqhsts[22] = (         int  )0;
                sqlstm.sqindv[22] = (         short *)0;
                sqlstm.sqinds[22] = (         int  )0;
                sqlstm.sqharm[22] = (unsigned long )0;
                sqlstm.sqadto[22] = (unsigned short )0;
                sqlstm.sqtdso[22] = (unsigned short )0;
                sqlstm.sqhstv[23] = (unsigned char  *)szhBlanco;
                sqlstm.sqhstl[23] = (unsigned long )2;
                sqlstm.sqhsts[23] = (         int  )0;
                sqlstm.sqindv[23] = (         short *)0;
                sqlstm.sqinds[23] = (         int  )0;
                sqlstm.sqharm[23] = (unsigned long )0;
                sqlstm.sqadto[23] = (unsigned short )0;
                sqlstm.sqtdso[23] = (unsigned short )0;
                sqlstm.sqhstv[24] = (unsigned char  *)szhNumImei;
                sqlstm.sqhstl[24] = (unsigned long )26;
                sqlstm.sqhsts[24] = (         int  )0;
                sqlstm.sqindv[24] = (         short *)0;
                sqlstm.sqinds[24] = (         int  )0;
                sqlstm.sqharm[24] = (unsigned long )0;
                sqlstm.sqadto[24] = (unsigned short )0;
                sqlstm.sqtdso[24] = (unsigned short )0;
                sqlstm.sqhstv[25] = (unsigned char  *)szhNumImsi;
                sqlstm.sqhstl[25] = (unsigned long )51;
                sqlstm.sqhsts[25] = (         int  )0;
                sqlstm.sqindv[25] = (         short *)0;
                sqlstm.sqinds[25] = (         int  )0;
                sqlstm.sqharm[25] = (unsigned long )0;
                sqlstm.sqadto[25] = (unsigned short )0;
                sqlstm.sqtdso[25] = (unsigned short )0;
                sqlstm.sqhstv[26] = (unsigned char  *)szhBlanco;
                sqlstm.sqhstl[26] = (unsigned long )2;
                sqlstm.sqhsts[26] = (         int  )0;
                sqlstm.sqindv[26] = (         short *)0;
                sqlstm.sqinds[26] = (         int  )0;
                sqlstm.sqharm[26] = (unsigned long )0;
                sqlstm.sqadto[26] = (unsigned short )0;
                sqlstm.sqtdso[26] = (unsigned short )0;
                sqlstm.sqhstv[27] = (unsigned char  *)szhNumImsi;
                sqlstm.sqhstl[27] = (unsigned long )51;
                sqlstm.sqhsts[27] = (         int  )0;
                sqlstm.sqindv[27] = (         short *)0;
                sqlstm.sqinds[27] = (         int  )0;
                sqlstm.sqharm[27] = (unsigned long )0;
                sqlstm.sqadto[27] = (unsigned short )0;
                sqlstm.sqtdso[27] = (unsigned short )0;
                sqlstm.sqhstv[28] = (unsigned char  *)szhNumSerie;
                sqlstm.sqhstl[28] = (unsigned long )26;
                sqlstm.sqhsts[28] = (         int  )0;
                sqlstm.sqindv[28] = (         short *)0;
                sqlstm.sqinds[28] = (         int  )0;
                sqlstm.sqharm[28] = (unsigned long )0;
                sqlstm.sqadto[28] = (unsigned short )0;
                sqlstm.sqtdso[28] = (unsigned short )0;
                sqlstm.sqhstv[29] = (unsigned char  *)szhBlanco;
                sqlstm.sqhstl[29] = (unsigned long )2;
                sqlstm.sqhsts[29] = (         int  )0;
                sqlstm.sqindv[29] = (         short *)0;
                sqlstm.sqinds[29] = (         int  )0;
                sqlstm.sqharm[29] = (unsigned long )0;
                sqlstm.sqadto[29] = (unsigned short )0;
                sqlstm.sqtdso[29] = (unsigned short )0;
                sqlstm.sqhstv[30] = (unsigned char  *)szhNumSerie;
                sqlstm.sqhstl[30] = (unsigned long )26;
                sqlstm.sqhsts[30] = (         int  )0;
                sqlstm.sqindv[30] = (         short *)0;
                sqlstm.sqinds[30] = (         int  )0;
                sqlstm.sqharm[30] = (unsigned long )0;
                sqlstm.sqadto[30] = (unsigned short )0;
                sqlstm.sqtdso[30] = (unsigned short )0;
                sqlstm.sqhstv[31] = (unsigned char  *)szhCodPlanTarif;
                sqlstm.sqhstl[31] = (unsigned long )4;
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
                sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


					         
                if (sqlca.sqlcode) {   
					    ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld] INSERT ICC_MOVIMIENTO 3 => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
                   return (-1);  
                }
            }

            ifnTrazaHilos( modulo,&pfLog,  "Registro Insertado en ICC_MOVIMIENTO.", LOG05 );  
        } /* endif iFlagCentral */
    }
    else     /* ( !strcmp( szCodSituacionAbo,"AAA") || !strcmp( szCodSituacionAbo,"SAA") ) */
    {
        return (1); /* no se suspende, pero no hay error, sigue con el sgte abonado si lo hay */
    }    

    iAboCeluGlobal ++; /* incrementa en 1 la cantidad de abonados Celular suspendidos */
    return (0);    /* termina en 0 si el abonado se suspendio ok */
} /* end ifnSuspende */


/* ============================================================================= */
/* Invoca a la Pl que genera cargos por reposicion                               */
/* ============================================================================= */
int ifnGeneraCargo(FILE **ptArchLog, long lCliente, long lAbonado, int iProducto, char* szCodActabo, sql_context ctxCont)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente  = lCliente   ;
	long lhNumAbonado  = lAbonado   ;
	int ihCodProducto = iProducto   ;
         
	char szhCodConcepto[5]=""       ; /* EXEC SQL VAR szhCodConcepto IS STRING (5); */ 

	double fhImpTarifa = 0.0        ;
	char szhCodMoneda[4]=""         ; /* EXEC SQL VAR szhCodMoneda IS STRING (4); */ 

	char szhFecDesde[15]=""         ; /* EXEC SQL VAR szhFecDesde IS STRING (15); */ 

	long lhNumCargo = 0             ;
	char szhCodServicio[4]=""       ; /* EXEC SQL VAR szhCodServicio IS STRING (4); */ 

	char szhCodActabo[3]=""         ; /* EXEC SQL VAR szhCodActabo IS STRING (3); */ 

	char szhYYYYMMDDHH24MISS [17];
	char szhNumeroUno  [2];
	int  ihValor_uno  = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[]="ifnGeneraCargo";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	strcpy(szhCodActabo,szCodActabo);
	strcpy(szhYYYYMMDDHH24MISS,"YYYYMMDDHH24MISS");
	strcpy(szhNumeroUno,"1");

	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo => [%s].", LOG05, modulo ); /*39747 Colombia 23-04-2007 Soporte RyC. */
	if ( !strcmp(szhCodActabo,"RT") )	/* Reposicion de servicio Cobranza */
	{
		sprintf(szhCodActabo,"RC\0");	
	}

	if ( !strcmp(szhCodActabo,"RC") )	/*XC-66 13.08.2004 capc *//* CH-200408232102 Homologado por PGonzalez 24-11-2004 */
	{	
		if ( ihCodProducto == 1 )
    		sprintf(szhCodServicio,"39\0");
		else
    		sprintf(szhCodServicio,"16\0");
	}

	/*39747 Colombia 23-04-2007 Soporte RyC. */
	if ( !strcmp(szhCodActabo,"RU") )	/* Reposicion de servicio Cobranza Suspensión unidireccional para Hibridos */
	{	
		if ( ihCodProducto == 1 )
    		sprintf(szhCodServicio,"39\0");
		else
    		sprintf(szhCodServicio,"16\0");
	}
	/*FIN 39747 Colombia */
	
	if ( !strcmp(szhCodActabo,"AF") )	/* Anulacion de baja Final */
		if ( ihCodProducto == 1 )
    		sprintf(szhCodServicio,"44\0");
		else	
    		sprintf(szhCodServicio,"17\0");

	if( !strcmp( szhCodActabo, "EN" ) )	/* Enrutamiento de cliente */
	{
		if( ihCodProducto == 1 )
			sprintf( szhCodServicio, "301\0" );
	}
	
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL
    SELECT A.COD_CONCEPTO
         , B.IMP_TARIFA
         , B.COD_MONEDA
         , TO_CHAR(B.FEC_DESDE,:szhYYYYMMDDHH24MISS)
    INTO   :szhCodConcepto
         , :fhImpTarifa
         , :szhCodMoneda
         , :szhFecDesde
    FROM   GA_TARIFAS B
         , GA_ACTUASERV A
    WHERE  A.COD_PRODUCTO = :ihCodProducto
    AND    A.COD_SERVICIO = :szhCodServicio
    AND    B.COD_PRODUCTO = A.COD_PRODUCTO
    AND    A.COD_ACTABO   = :szhCodActabo
    AND    B.COD_ACTABO   = A.COD_ACTABO
    AND    A.COD_TIPSERV  = :szhNumeroUno
    AND    B.COD_TIPSERV  = A.COD_TIPSERV
    AND    SYSDATE BETWEEN B.FEC_DESDE AND NVL(B.FEC_HASTA, SYSDATE + :ihValor_uno )
    AND    EXISTS ( SELECT 1 FROM GA_ABOCEL WHERE COD_PLANSERV = B.COD_PLANSERV AND NUM_ABONADO = :lhNumAbonado); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_CONCEPTO ,B.IMP_TARIFA ,B.COD_MONEDA ,TO_CHA\
R(B.FEC_DESDE,:b0) into :b1,:b2,:b3,:b4  from GA_TARIFAS B ,GA_ACTUASERV A whe\
re ((((((((A.COD_PRODUCTO=:b5 and A.COD_SERVICIO=:b6) and B.COD_PRODUCTO=A.COD\
_PRODUCTO) and A.COD_ACTABO=:b7) and B.COD_ACTABO=A.COD_ACTABO) and A.COD_TIPS\
ERV=:b8) and B.COD_TIPSERV=A.COD_TIPSERV) and SYSDATE between B.FEC_DESDE and \
NVL(B.FEC_HASTA,(SYSDATE+:b9))) and exists (select 1  from GA_ABOCEL where (CO\
D_PLANSERV=B.COD_PLANSERV and NUM_ABONADO=:b10)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1849;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDDHH24MISS;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodConcepto;
    sqlstm.sqhstl[1] = (unsigned long )5;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&fhImpTarifa;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
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
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodServicio;
    sqlstm.sqhstl[6] = (unsigned long )4;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodActabo;
    sqlstm.sqhstl[7] = (unsigned long )3;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNumeroUno;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_uno;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /*39747 Colombia 23-04-2007 Soporte RyC. */

    if (sqlca.sqlcode && sqlca.sqlcode != SQLNOTFOUND)  
    {
        ifnTrazaHilos( modulo,&pfLog, "Select GA_TARIFAS, GA_ACTUASERV\n(Cliente:%ld|Abonado:%ld|Producto:%d|CodServicio:[%s]): %s"
                           ,LOG00,lCliente,lAbonado,ihCodProducto,szhCodServicio,sqlca.sqlerrm.sqlerrmc);  
        return 0;
    }

	if ( fhImpTarifa > 0 )	{

    	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    	/* EXEC SQL
    	SELECT GE_SEQ_CARGOS.NEXTVAL
   	INTO :lhNumCargo
   	FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 33;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select GE_SEQ_CARGOS.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1908;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCargo;
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


    	if (sqlca.sqlcode)  {
        	ifnTrazaHilos( modulo,&pfLog, "Select GE_SEQ_CARGOS : %s",LOG00, sqlca.sqlerrm.sqlerrmc);  
        	return 0;
    	}

    	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    	/* EXEC SQL EXECUTE
    	BEGIN
        	CO_GEN_CARGO(	:lhCodCliente, :lhNumAbonado, :szhCodConcepto, :fhImpTarifa,
							:szhCodMoneda, :ihCodProducto, :lhNumCargo );
    	END;
    	END-EXEC; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 33;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "begin CO_GEN_CARGO ( :lhCodCliente , :lhNumAbonado , :sz\
hCodConcepto , :fhImpTarifa , :szhCodMoneda , :ihCodProducto , :lhNumCargo ) ;\
 END ;";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1927;
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
     sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodConcepto;
     sqlstm.sqhstl[2] = (unsigned long )5;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&fhImpTarifa;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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
     sqlstm.sqhstv[5] = (unsigned char  *)&ihCodProducto;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCargo;
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



    	if( sqlca.sqlcode ) {    
        	ifnTrazaHilos( modulo,&pfLog, "Fallo Generacion de Cargo\n"
                            "(Cliente:%ld|Abonado:%ld|Concepto:%s|Importe:%f|Moneda:%s|Producto:%d|NumCargo:%ld)\n"
                            "%s"
                           ,LOG00,lhCodCliente,lhNumAbonado,szhCodConcepto,fhImpTarifa
                           ,szhCodMoneda,ihCodProducto,lhNumCargo,sqlca.sqlerrm.sqlerrmc);
        	return 0;
    	}
    	else
    	{    
        	ifnTrazaHilos( modulo,&pfLog, "Generacion de Cargo Correcta",LOG05);  
    	}
    }
    return 1;
} /* int ifnGeneraCargo */


/*==================================================================================================
  Funcion que Simula la rehabilitacion de servicio unidireccional/bidireccional del abonado
  cuando este aun se encuentra de baja, para lo cual inserta desde la tabla icc_penalizacion el 
  codigo de rehabilitacion del servicio correspondiente y luego elimina el registro.																			 
 ==================================================================================================*/
BOOL bfnSimulaReposicionCentral(FILE **ptArchLog, long lNumAbonado, char *szCodRepos, char *szCodModulo, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado        ;
	char	szhCodRepos      [4];	/* EXEC SQL VAR szhCodRepos IS STRING(4); */ 

	char	szhCodModulo     [3];	/* EXEC SQL VAR szhCodModulo IS STRING(3); */ 

	int	ihCodServicio       ;
	int	ihNivelServicio     ;
	int	ihNivelServicioReha ;
	char	szhCadenaServReha[7];	/* EXEC SQL VAR szhCadenaServReha IS STRING(7); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION ; */ 

char	modulo[] = "bfnSimulaReposicionCentral";
int	iError = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingresando modulo : [%s].", LOG05, modulo, sqlca.sqlerrm.sqlerrmc );
	memset( szhCodRepos, '\0', sizeof( szhCodRepos ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );
	memset( szhCadenaServReha, '\0', sizeof( szhCadenaServReha ) );
	
	strcpy( szhCodRepos, szCodRepos );
	strcpy( szhCodModulo, szCodModulo );
	lhNumAbonado = lNumAbonado;

	/* simulamos la insercion del perfil abonado con los datos de la icc_penalizacion */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL DECLARE CurServSusp CURSOR FOR
	SELECT /o+index(ICC_PENALIZACION,PK_ICC_PENALIZACION)o/
			COD_SERVICIO,
			COD_NIVEL,
			COD_NIVEL_REA
	FROM	ICC_PENALIZACION
	WHERE	NUM_ABONADO  = :lhNumAbonado
	AND	COD_SUSPREHA = :szhCodRepos
	AND	COD_MODULO = :szhCodModulo; */ 

	
	if( sqlca.sqlcode != SQLOK ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "(Abonado: %ld ). Declare CurServSusp ICC_PENALIZACION %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}  

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL OPEN CurServSusp; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0044;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1970;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodRepos;
 sqlstm.sqhstl[1] = (unsigned long )4;
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


	if( sqlca.sqlcode != SQLOK )	{
		ifnTrazaHilos( modulo,&pfLog,"(Abonado:%ld) Open CurServSusp %s ",LOG00,lhNumAbonado,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	
	for( ; ; )
	{  
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL FETCH CurServSusp
	   INTO	:ihCodServicio,			/o servicio suspendido o/
				:ihNivelServicio,		/o nivel en que se encuentra el servicio o/
				:ihNivelServicioReha; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1997;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodServicio;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihNivelServicio;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihNivelServicioReha;
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

	/* nivel al que se rehabilita el servicio */
				
      if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
      {
            ifnTrazaHilos( modulo,&pfLog,  "(Abonado:%ld) Fetch CurServSusp %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		  	iError=1;
		  	break;
      }
      else if( sqlca.sqlcode == SQLNOTFOUND ) 
      {
         ifnTrazaHilos( modulo,&pfLog,  "(Abonado:%ld) Fin cursor CurServSusp", LOG03, lhNumAbonado );
		  	iError=0;
		  	break;
      }
				
		/* extraemos la cadena de servicios de suspension desde el perfil del abonado */
		if( !bfnExtraerCadenaPerfilAbo(&pfLog, lhNumAbonado, ihCodServicio, ihNivelServicio, CXX ) )		{
		  	iError=1;
		  	break;
		}
		
		/* solo si es un servicio activo lo insertamos en el perfil del abonado */
		if( ihNivelServicioReha > 0 )		{
			/* nos aseguramos que la nueva cadena no exista, si es asi la borramos */
			ifnTrazaHilos( modulo,&pfLog, "AQUI VA LA FUNCION REBELDE..!!", LOG03);
			if( !bfnExtraerCadenaPerfilAbo(&pfLog, lhNumAbonado, ihCodServicio, ihNivelServicioReha, CXX ) ) {
			  	iError=1;
			  	break;
			}
		
			/* armamos la nueva cadena a insertar */
			sprintf( szhCadenaServReha, "%02d%04d\0", ihCodServicio, ihNivelServicioReha );
			ifnTrazaHilos( modulo,&pfLog,  "(Abonado: %ld ). Cadena a insertar Perfil Abonado %s.", LOG05, lhNumAbonado, szhCadenaServReha );
			
			/* Actualizamos la cadena de perfil de servicios contratados */
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL 
			UPDATE GA_ABOCEL  SET		
			       PERFIL_ABONADO = PERFIL_ABONADO || :szhCadenaServReha
			WHERE	 NUM_ABONADO = :lhNumAbonado; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 33;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update GA_ABOCEL  set PERFIL_ABONADO=(PERFIL_ABONADO||:b0)\
 where NUM_ABONADO=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2024;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaServReha;
   sqlstm.sqhstl[0] = (unsigned long )7;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			
			if( sqlca.sqlcode != SQLOK )  {  
				ifnTrazaHilos( modulo,&pfLog,  "(Abonado: %ld ). Actualizando Perfil Abonado %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			  	iError=1;
			  	break;
			}  
		} /* if( ihNivelServicio > 0 ) */	

		if( !bfnBorraIccPenalizacion(&pfLog, lhNumAbonado, szhCodRepos, szhCodModulo, CXX ) )		{
		  	iError=1;
		  	break;
		}
	} /* for( ; ; ) */

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL CLOSE CurServSusp ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2047;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode )	{
		ifnTrazaHilos( modulo,&pfLog,"(Abonado: %ld) Close CurServSusp %s ",LOG00,lhNumAbonado,sqlca.sqlerrm.sqlerrmc);  
		return FALSE;
	}

	if ( iError )	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado : %ld ).", LOG01, lhNumAbonado );  
		return FALSE;
	}

	return TRUE;
} /* BOOL bfnSimulaReposicionCentral */


/*==================================================================================================*/
/* Funcion que Borra desde la ICC_PENALIZACION, segun parametros.       									 */
/*==================================================================================================*/
BOOL bfnBorraIccPenalizacion(FILE **ptArchLog, long lNumAbonado, char *szCodRepos, char *szCodModulo, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado   ;
	char	szhCodRepos [4];		/* EXEC SQL VAR szhCodRepos IS STRING(4); */ 

	char	szhCodModulo[3];		/* EXEC SQL VAR szhCodModulo IS STRING(3); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnBorraIccPenalizacion";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingresando modulo : [%s].", LOG05, modulo, sqlca.sqlerrm.sqlerrmc );
	memset( szhCodRepos, '\0', sizeof( szhCodRepos ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );

	strcpy( szhCodRepos, szCodRepos );
	strcpy( szhCodModulo, szCodModulo );
	lhNumAbonado = lNumAbonado;

	rtrim( szhCodRepos );
	rtrim( szhCodModulo );

	ifnTrazaHilos( modulo,&pfLog, 	"Datos entrada %s.\n"
							"\t\t   lhNumAbonado    [%ld],\n"
							"\t\t   szhCodRepos     [%s],\n"
							"\t\t   szhCodModulo    [%s].\n",
							LOG05, modulo, lhNumAbonado, szhCodRepos, szhCodModulo );

	/* se borra el registro de la icc_penalizacion, para evitar inconsistencias futuras */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	DELETE /o+index(ICC_PENALIZACION,PK_ICC_PENALIZACION)o/  /o Requerimiento de Soporte - #43432 28-08-2007 capc o/ 
	 FROM ICC_PENALIZACION
	WHERE  NUM_ABONADO  = :lhNumAbonado
	AND    COD_SUSPREHA = :szhCodRepos
	AND    COD_MODULO = :szhCodModulo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  /*+ index(ICC_PENALIZACION,PK_ICC_PENALIZACION) +*/ \
 from ICC_PENALIZACION  where ((NUM_ABONADO=:b0 and COD_SUSPREHA=:b1) and COD_\
MODULO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2062;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodRepos;
 sqlstm.sqhstl[1] = (unsigned long )4;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "(Abonado: %ld ). Delete ICC_PENALIZA %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}  

	return TRUE;
} /* BOOL bfnBorraIccPenalizacion( long lNumAbonado, char *szCodRepos, char *szCodModulo ) */	


/*==================================================================================================*/
/* Funcion que selecciona documentos para generar intereses												       */
/*==================================================================================================*/
BOOL bfnGenInteresesBaja(FILE **ptArchLog, long lCodCliente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	ihCnt;
	long	lhCodCliente;
	char	szhIndFecCobro[2]; /* EXEC SQL VAR szhIndFecCobro IS STRING(2); */ 

	long	lhNumSecuenci;      
	int	ihCodTipDocum;      
	long	lhCodVendedorAgente;
	char	szhLetra[2];           
	int	ihCodCentremi;
	int	ihSecCuota;         
	char	szhCadena[1001];           
	char  szhSINTE   [6];
	int   ihValor_cero = 0;
	int   ihValor_uno  = 1;
	int   ihValor_tres = 3;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnGenInteresesBaja";
BOOL	bSinError = TRUE;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ifnTrazaHilos( modulo,&pfLog,  "Ingresando Modulo %s", LOG03, modulo );

	memset( szhIndFecCobro, '\0', sizeof( szhIndFecCobro ) );
	memset( szhLetra, '\0', sizeof( szhLetra ) );
	memset( szhCadena, '\0', sizeof( szhCadena ) );
	
	lhCodCliente = lCodCliente;
	strcpy(szhSINTE,"SINTE");
	
	/* ve si el cliente es inmune */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COUNT(*)
	INTO	 :ihCnt
	FROM	 CO_INMUNIDAD
	WHERE	 COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_INMUNIDAD where COD_CLIEN\
TE=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2089;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCnt;
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


	
	if( sqlca.sqlcode != SQLOK )	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al comprobar inmunidad => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	if( ihCnt ) 	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Es Inmune => [%s].", LOG03, lhCodCliente );
		return TRUE;
	}
	
	/* ve si el cliente es exento */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT NVL(COUNT(*),:ihValor_cero)
	INTO	 :ihCnt
	FROM	 CO_CLIESINTER
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 FEC_DESDE <= SYSDATE
	AND	 FEC_HASTA >= SYSDATE
	AND	 COD_EXENCION = :szhSINTE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(count(*) ,:b0) into :b1  from CO_CLIESINTER where\
 (((COD_CLIENTE=:b2 and FEC_DESDE<=SYSDATE) and FEC_HASTA>=SYSDATE) and COD_EX\
ENCION=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2112;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCnt;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhSINTE;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK )	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al consultar CO_CLIESINTER => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	if( ihCnt )	 {
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Es Exento => [%s].", LOG03, lhCodCliente );
		return TRUE;
	}
	
	/* recuperamos datos para cobro de intereses */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT IND_FEC_COBRO			
	INTO	 :szhIndFecCobro
	FROM	 CO_INTERESES
	WHERE	 SYSDATE BETWEEN FEC_VIGENCIA_DD_DH AND FEC_VIGENCIA_HH_DH; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select IND_FEC_COBRO into :b0  from CO_INTERESES where SYSDA\
TE between FEC_VIGENCIA_DD_DH and FEC_VIGENCIA_HH_DH";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2143;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhIndFecCobro;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al recuperar factores de cobro desde CO_INTERESES => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	if( sqlca.sqlcode == SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog,  "No hay factores definidos para Cobro de Intereses.", LOG03 );
		return TRUE;
	}

	/* recuperamos los documentos sobre los cuales se generaran intereses */
	sprintf( szhCadena, "SELECT	NUM_SECUENCI, \n"
						"		COD_TIPDOCUM, \n"
						"		COD_VENDEDOR_AGENTE, \n"
						"		LETRA, \n"
						"		COD_CENTREMI, \n"
						"		NVL( SEC_CUOTA, -1 ) \n"
						"FROM	CO_CARTERA \n"
						"WHERE	COD_CLIENTE = :v1 \n"
						"AND    IND_FACTURADO = :v2 \n"
						"AND    COD_CONCEPTO IN ( :v3, :v4 ) \n");
					
	if( !strcmp( szhIndFecCobro,"V" ) ) /* calcula los intereses a partir de la fecha de Vencimiento */
		sprintf( szhCadena, "%sGROUP BY NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI, SEC_CUOTA, NUM_FOLIO, FEC_VENCIMIE\n", szhCadena );
	else
		sprintf( szhCadena, "%sGROUP BY NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA, COD_CENTREMI, SEC_CUOTA, NUM_FOLIO, FEC_EFECTIVIDAD\n", szhCadena );

	ifnTrazaHilos( modulo,&pfLog,  "\n[%s]", LOG05, szhCadena );

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL PREPARE SQL_CARTERA FROM :szhCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2162;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCadena;
    sqlstm.sqhstl[0] = (unsigned long )1001;
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
		ifnTrazaHilos( modulo,&pfLog,  "Error PREPARE SQL_CARTERA.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL DECLARE CurCartera CURSOR FOR SQL_CARTERA; */ 

    if( sqlca.sqlcode ) 
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error DECLARE CurCartera.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL OPEN CurCartera USING :lhCodCliente, :ihValor_uno, :ihValor_uno, :ihValor_tres; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2181;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_uno;
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


    if( sqlca.sqlcode ) 
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error OPEN CurCartera.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

	while( bSinError )
    {
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL FETCH CurCartera 
		INTO 	:lhNumSecuenci,
				:ihCodTipDocum,
				:lhCodVendedorAgente,
				:szhLetra,
				:ihCodCentremi,
				:ihSecCuota; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2212;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedorAgente;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[3] = (unsigned long )2;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentremi;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihSecCuota;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	    {
			ifnTrazaHilos( modulo,&pfLog,  "Error FETCH CurCartera.", LOG00, sqlca.sqlerrm.sqlerrmc );
			bSinError = FALSE;
	    }
		else if( sqlca.sqlcode == SQLNOTFOUND )
	    {
			ifnTrazaHilos( modulo,&pfLog,  "Fin datos FETCH CurCartera.", LOG03 );
			break;
	    }
	    else
	    {
			/* llamamos a la funcion que calcula los intereses */
			if( !bfnCalculaIntereses(&pfLog,	lhCodCliente, lhNumSecuenci, ihCodTipDocum, lhCodVendedorAgente, 
										szhLetra, ihCodCentremi, ihSecCuota , CXX) )
			{
				bSinError = FALSE;
			}	
		}
    } /* while( 1 ) */
    
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL CLOSE CurCartera; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2251;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if( sqlca.sqlcode ) 
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error CLOSE CurCartera.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }
	    
	if( !bSinError )
		return FALSE;
		
	return TRUE;	
} /* BOOL bfnGenInteresesBaja( long lCodCliente ) */

/*==================================================================================================*/
/* Funcion que genera interes por cada documento del cliente a dar de baja									 */
/*==================================================================================================*/
BOOL bfnCalculaIntereses(FILE **ptArchLog, long lCodCliente, long lNumSecuenci, int iCodTipDocum, long lCodVendedorAgente, 
						  char *szLetra  , int  iCodCentremi, int iSecCuota, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long 	lhCodCliente;
	long 	lhNumSecuenci;
	int	ihCodTipDocum;
	long	lhCodVendedorAgente;
	char	szhLetra[2];
	int	ihCodCentremi;
	int 	ihSecCuota;
	double	dhFactorInt;
	int	ihFactorDia;
	char	szhIndFecCobro[2];
	int	ihDiasLibres;
	long	lhNumFolio;
	int	ihDiasAtraso;
	double	dhMtoDeuda;
	double	dhMtoCarrier;
	double	dhPctjeDia;
	double	dhMtoIntereses;
	long	lhNumCargo;
	char	szhCodIntereses[5];
	char	szhCodMoneda[4];
	int	ihCodProducto;
	long	lhNumAbonado;
	char	szhCadena[1001];           
	char  szhRE        [3];
	char  szhCONC_MORA [14];
	int   ihValor_cero   = 0;
   int   ihValor_cuatro = 4;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnCalculaIntereses";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	memset( szhLetra, '\0', sizeof( szhLetra ) );
	
	ifnTrazaHilos( modulo,&pfLog,  "Ingresando Modulo %s", LOG03, modulo );

	lhCodCliente	= lCodCliente;        
	lhNumSecuenci	= lNumSecuenci;       
	ihCodTipDocum	= iCodTipDocum;       
	lhCodVendedorAgente = lCodVendedorAgente; 
	ihCodCentremi	= iCodCentremi;       
	ihSecCuota		= iSecCuota;          
	strcpy( szhLetra, szLetra );         
	strcpy(szhRE       ,"RE");
	strcpy(szhCONC_MORA,"CONCEPTO_MORA");

	ifnTrazaHilos( modulo,&pfLog,  	"Datos de entrada \n"
							"\t   lhCodCliente        => [%ld],\n "
							"\t   lhNumSecuenci       => [%ld],\n "
							"\t   ihCodTipDocum       => [%d],\n "
							"\t   lhCodVendedorAgente => [%ld],\n "
							"\t   ihCodCentremi       => [%d],\n "
							"\t   ihSecCuota          => [%d],\n "
							"\t   szhLetra            => [%s],\n ",
							LOG05,
							lhCodCliente,
							lhNumSecuenci,
							ihCodTipDocum,
							lhCodVendedorAgente,
							ihCodCentremi,
							ihSecCuota,
							szhLetra );

	/* recuperamos datos para cobro de intereses */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT FACTOR_INT,
			FACTOR_DIA,
			IND_FEC_COBRO,
			DIAS_APLICACION
	INTO	:dhFactorInt,
			:ihFactorDia,
			:szhIndFecCobro,
			:ihDiasLibres
	FROM	CO_INTERESES
	WHERE	SYSDATE BETWEEN FEC_VIGENCIA_DD_DH AND FEC_VIGENCIA_HH_DH; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select FACTOR_INT ,FACTOR_DIA ,IND_FEC_COBRO ,DIAS_APLICACIO\
N into :b0,:b1,:b2,:b3  from CO_INTERESES where SYSDATE between FEC_VIGENCIA_D\
D_DH and FEC_VIGENCIA_HH_DH";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2266;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhFactorInt;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihFactorDia;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhIndFecCobro;
 sqlstm.sqhstl[2] = (unsigned long )2;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihDiasLibres;
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


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al recuperar factores de cobro desde CO_INTERESES => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	if( sqlca.sqlcode == SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "No hay factores definidos para cobro de intereses.", LOG03 );
		return TRUE;
	}

	sprintf( szhCadena, "SELECT	NUM_FOLIO, \n" );

	if( !strcmp( szhIndFecCobro, "V" ) ) /* calcula los intereses a partir de la fecha de Vencimiento */
		sprintf( szhCadena, "%s        SYSDATE - ( FEC_VENCIMIE + %d ), \n", szhCadena, ihDiasLibres );
	else
		sprintf( szhCadena, "%s        SYSDATE - ( FEC_EFECTIVIDAD + %d ), \n", szhCadena, ihDiasLibres );

	sprintf( szhCadena, "%s        SUM(IMPORTE_DEBE - IMPORTE_HABER) \n"
						"FROM   CO_CARTERA  \n"
						"WHERE  COD_CLIENTE   = %ld \n"
						"AND    NUM_SECUENCI  = %ld \n"
						"AND    COD_TIPDOCUM  = %d \n"
						"AND    COD_VENDEDOR_AGENTE = %d \n"
						"AND    LETRA         = '%s' \n"
						"AND    COD_CENTREMI  = %d \n"
						"AND    IND_FACTURADO = 1 \n",
						szhCadena, lhCodCliente, lhNumSecuenci, 
						ihCodTipDocum, lhCodVendedorAgente, szhLetra, ihCodCentremi );			

	if( ihSecCuota == -1 ) /* Valor Null */
		sprintf( szhCadena, "%sAND    SEC_CUOTA IS NULL \n", szhCadena ); 
	else
		sprintf( szhCadena, "%sAND    SEC_CUOTA = %d \n", szhCadena, ihSecCuota ); 
		
	if( !strcmp( szhIndFecCobro, "V" ) ) /* calcula los intereses a partir de la fecha de Vencimiento */
		sprintf( szhCadena, "%sGROUP BY NUM_FOLIO, FEC_VENCIMIE \n", szhCadena );
	else
		sprintf( szhCadena, "%sGROUP BY NUM_FOLIO, FEC_EFECTIVIDAD \n", szhCadena );

	ifnTrazaHilos( modulo,&pfLog,  "\n[%s]", LOG06, szhCadena );

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL PREPARE SQL_DOCTOS FROM :szhCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2297;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCadena;
    sqlstm.sqhstl[0] = (unsigned long )1001;
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
		ifnTrazaHilos( modulo,&pfLog,  "Error PREPARE SQL_DOCTOS.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL DECLARE CurDoctos CURSOR FOR SQL_DOCTOS; */ 

    if( sqlca.sqlcode ) 
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error DECLARE CurDoctos.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    /* EXEC SQL OPEN CurDoctos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2316;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if( sqlca.sqlcode ) 
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error OPEN CurDoctos.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL FETCH CurDoctos
	INTO	:lhNumFolio,
			:ihDiasAtraso,
			:dhMtoDeuda; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2331;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihDiasAtraso;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&dhMtoDeuda;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error FETCH CurDoctos.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }
		
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL CLOSE CurDoctos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2358;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
		ifnTrazaHilos( modulo,&pfLog,  "Error CLOSE CurDoctos.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
    }

	ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Folio => [%ld], Deuda => [%f], Atraso => [%d]\n", 
							lhCodCliente, lhNumFolio, dhMtoDeuda, ihDiasAtraso );
	
	if( ihDiasAtraso > 0 )	/* si el documento esta vencido */
	{
		if( iSecCuota == -1 ) /* Valor Null */
		{
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL /o ve si tiene conceptos carrier o/
			SELECT NVL( SUM ( C.IMPORTE_DEBE - C.IMPORTE_HABER ), :ihValor_cuatro )
			INTO	 :dhMtoCarrier
			FROM	 CO_CONCEPTOS P, CO_CARTERA C 
			WHERE	 C.COD_CLIENTE  = :lhCodCliente
			AND	 C.NUM_SECUENCI = :lhNumSecuenci
			AND	 C.COD_TIPDOCUM = :ihCodTipDocum
			AND	 C.COD_VENDEDOR_AGENTE = :lhCodVendedorAgente
			AND	 C.LETRA = :szhLetra
			AND	 C.COD_CENTREMI = :ihCodCentremi
			AND	 C.COD_CONCEPTO = P.COD_CONCEPTO
			AND	 P.COD_TIPCONCE = :ihValor_cuatro /o carrier o/
			AND 	 C.SEC_CUOTA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 33;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(sum((C.IMPORTE_DEBE-C.IMPORTE_HABER)),:b0) into\
 :b1  from CO_CONCEPTOS P ,CO_CARTERA C where ((((((((C.COD_CLIENTE=:b2 and C.\
NUM_SECUENCI=:b3) and C.COD_TIPDOCUM=:b4) and C.COD_VENDEDOR_AGENTE=:b5) and C\
.LETRA=:b6) and C.COD_CENTREMI=:b7) and C.COD_CONCEPTO=P.COD_CONCEPTO) and P.C\
OD_TIPCONCE=:b0) and C.SEC_CUOTA is null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2373;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cuatro;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&dhMtoCarrier;
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
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedorAgente;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[6] = (unsigned long )2;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCentremi;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&ihValor_cuatro;
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


		}
		else /* Valor No Null */
		{
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
			/* EXEC SQL /o ve si tiene conceptos carrier o/
			SELECT NVL( SUM( C.IMPORTE_DEBE - C.IMPORTE_HABER ), :ihValor_cero )
			INTO	:dhMtoCarrier
			FROM	 CO_CONCEPTOS P, CO_CARTERA C 
			WHERE	 C.COD_CLIENTE  = :lhCodCliente
			AND	 C.NUM_SECUENCI = :lhNumSecuenci
			AND	 C.COD_TIPDOCUM = :ihCodTipDocum
			AND	 C.COD_VENDEDOR_AGENTE = :lhCodVendedorAgente
			AND	 C.LETRA = :szhLetra
			AND	 C.COD_CENTREMI = :ihCodCentremi
			AND	 C.COD_CONCEPTO = P.COD_CONCEPTO
			AND	 P.COD_TIPCONCE = :ihValor_cuatro /o carrier o/
			AND 	 C.SEC_CUOTA = :ihSecCuota; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 33;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(sum((C.IMPORTE_DEBE-C.IMPORTE_HABER)),:b0) into\
 :b1  from CO_CONCEPTOS P ,CO_CARTERA C where ((((((((C.COD_CLIENTE=:b2 and C.\
NUM_SECUENCI=:b3) and C.COD_TIPDOCUM=:b4) and C.COD_VENDEDOR_AGENTE=:b5) and C\
.LETRA=:b6) and C.COD_CENTREMI=:b7) and C.COD_CONCEPTO=P.COD_CONCEPTO) and P.C\
OD_TIPCONCE=:b8) and C.SEC_CUOTA=:b9)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2424;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&dhMtoCarrier;
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
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedorAgente;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[6] = (unsigned long )2;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCentremi;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&ihValor_cuatro;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihSecCuota;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		} /* if( iSecCuota == -1 ) */
		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al recuperar datos de documento CARRIER => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}
		
		/* calcula factor diario */
		dhPctjeDia = ( dhFactorInt / 100 ) / ihFactorDia;
		
		/* los intereses no deben considerar conceptos carrier */
		dhMtoDeuda -= dhMtoCarrier;
		
		/* calcula monto */
		dhMtoIntereses = dhPctjeDia * ihDiasAtraso * dhMtoDeuda;
		
		ifnTrazaHilos( modulo,&pfLog,  "Cliente      => [%ld],\n" 
							  "\t   Interes      => [%.4f],\n"
							  "\t   FactorInt    => [%.4f],\n"
							  "\t   FactorDia    => [%d],\n"
							  "\t   MtoCarrier   => [%.4f],\n"
							  "\t   MtoDeuda     => [%.4f],\n"
							  "\t   DiasAtraso   => [%d]\n",
							  LOG05, lhCodCliente, dhMtoIntereses, dhFactorInt, ihFactorDia, dhMtoCarrier, dhMtoDeuda, ihDiasAtraso );
				
		if( dhMtoIntereses <= 0 )
			return TRUE;
		
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		SELECT GE_SEQ_CARGOS.NEXTVAL
		INTO	 :lhNumCargo
		FROM	 DUAL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select GE_SEQ_CARGOS.nextval  into :b0  from DUAL ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2479;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCargo;
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


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al recuperar secuencia GE_SEQ_CARGOS.NEXTVAL => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}

		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], SECUENCIA CARGO OK \n", lhCodCliente );
		
		/* Codigos de intereses y moneda */
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		SELECT VAL_PARAMETRO, FA_FN_CODMONFACT
		INTO  :szhCodIntereses,
		      :szhCodMoneda
		FROM  GED_PARAMETROS
		WHERE COD_MODULO   = :szhRE
		AND   NOM_PARAMETRO= :szhCONC_MORA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select VAL_PARAMETRO ,FA_FN_CODMONFACT into :b0,:b1  from G\
ED_PARAMETROS where (COD_MODULO=:b2 and NOM_PARAMETRO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2498;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodIntereses;
  sqlstm.sqhstl[0] = (unsigned long )5;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodMoneda;
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhRE;
  sqlstm.sqhstl[2] = (unsigned long )3;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCONC_MORA;
  sqlstm.sqhstl[3] = (unsigned long )14;
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



		if( sqlca.sqlcode != SQLOK || sqlca.sqlcode == SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error al recuperar szhCodIntereses,szhCodMoneda GED_PARAMETROS => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}
		   
		rtrim(szhCodIntereses);
		rtrim(szhCodMoneda);  
		ihCodProducto = 5; 					/* General */
		lhNumAbonado = 0;
		
		/* transformacion de decimales */
		dhMtoIntereses = fnCnvDouble( dhMtoIntereses, 0 );

		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL EXECUTE
			BEGIN
				CO_GEN_CARGO( :lhCodCliente, :lhNumAbonado, :szhCodIntereses, :dhMtoIntereses, :szhCodMoneda, :ihCodProducto, :lhNumCargo );
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin CO_GEN_CARGO ( :lhCodCliente , :lhNumAbonado , :szhCo\
dIntereses , :dhMtoIntereses , :szhCodMoneda , :ihCodProducto , :lhNumCargo ) \
; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2529;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodIntereses;
  sqlstm.sqhstl[2] = (unsigned long )5;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhMtoIntereses;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCargo;
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


		
		if( sqlca.sqlcode ) 		{    
			ifnTrazaHilos( modulo,&pfLog,  "Fallo Generacion de Cargo Cliente => %ld, Error => [%s].\n", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}
		else
		{    
			ifnTrazaHilos( modulo,&pfLog,  "Generacion de Cargo Correcta", LOG05 );  
		}

	} /* if (ihDiasAtraso > 0) */
	
	ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Calculo de intereses OK.", LOG03, lhCodCliente );
	return TRUE;
} /* BOOL bfnCalculaIntereses () */

/*==================================================================================================*/
/* Funcion que Selecciona el texto del mensaje a enviar al cliente y central de envio               */
/*==================================================================================================*/
BOOL bfnSelectDescripcionMensaje(FILE **ptArchLog, char *szCodMensaje, char *szCodIdioma, char *szpDescMensaje, sql_context ctxCont  )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodConcepto[13];
	char	szhCodIdioma[6];
	long	lhSecuenciaMensaje = -1;
	char	szhDescMensaje[257];
	char  szhICG_MENSA  [12];
	char  szhCOD_MENSA  [12];
   int   ihValor_uno  = 1;	
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char 	modulo[] = "bfnSelectDescripcionMensaje";
int	rr, ilong = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	memset(szhCodConcepto, '\0', sizeof( szhCodConcepto ) );
	memset(szhCodIdioma, '\0', sizeof( szhCodIdioma ) );
	memset(szhDescMensaje, '\0', sizeof( szhDescMensaje ) );
	
	strcpy(szhCodConcepto, szCodMensaje );
	strcpy(szhCodIdioma, szCodIdioma );
	strcpy(szhICG_MENSA,"ICG_MENSAJE");
	strcpy(szhCOD_MENSA,"COD_MENSAJE");
	
	ilong = strlen( szhCodConcepto ) - 1;
	for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhCodConcepto[rr] != ' ') break ;
	szhCodConcepto[rr + 1] = '\0';

	ilong = strlen( szhCodIdioma ) - 1;
	for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhCodIdioma[rr] != ' ') break ;
	szhCodIdioma[rr + 1] = '\0';

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT DES_CONCEPTO
	INTO	 :szhDescMensaje	
	FROM	 GE_MULTIIDIOMA
	WHERE	 NOM_TABLA	 = :szhICG_MENSA
	AND	 NOM_CAMPO	 = :szhCOD_MENSA
	AND	 COD_CONCEPTO= :szhCodConcepto
	AND	 COD_IDIOMA	 = :szhCodIdioma
	AND 	 COD_PRODUCTO= :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select DES_CONCEPTO into :b0  from GE_MULTIIDIOMA where ((((\
NOM_TABLA=:b1 and NOM_CAMPO=:b2) and COD_CONCEPTO=:b3) and COD_IDIOMA=:b4) and\
 COD_PRODUCTO=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2572;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDescMensaje;
 sqlstm.sqhstl[0] = (unsigned long )257;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhICG_MENSA;
 sqlstm.sqhstl[1] = (unsigned long )12;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCOD_MENSA;
 sqlstm.sqhstl[2] = (unsigned long )12;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodConcepto;
 sqlstm.sqhstl[3] = (unsigned long )13;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodIdioma;
 sqlstm.sqhstl[4] = (unsigned long )6;
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
		ifnTrazaHilos( modulo,&pfLog,  "Codigo => [%s], Idioma => [%s], error al Texto del Mensaje ==> [%s].", LOG00, szhCodConcepto, szhCodIdioma, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;		
	}

	if( sqlca.sqlcode == SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Codigo => [%s], Idioma => [%s], , no existe Texto de Mensaje asociado.", LOG01, szhCodConcepto, szhCodIdioma );  
		strcpy( szpDescMensaje, "X" );
		return FALSE;		
	}

	strcpy( szpDescMensaje, szhDescMensaje );
	return TRUE;

}/* fin bfnSelectDescripcionMensaje */


/*==================================================================================================*/
/* Funcion que Selecciona el idioma del cliente																		 */
/*==================================================================================================*/
BOOL bfnSelectIdiomaCliente(FILE **ptArchLog, long lCodCliente, char *szCodIdioma, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	char	szhCodIdioma[6];
	int   ihUno_Negat = -1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char 	modulo[] = "bfnSelectIdiomaCliente";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	memset( szhCodIdioma, '\0', sizeof( szhCodIdioma ) );
	lhCodCliente = lCodCliente;
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT NVL( COD_IDIOMA, :ihUno_Negat )
	INTO	 :szhCodIdioma
	FROM	 GE_CLIENTES
	WHERE	 COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(COD_IDIOMA,:b0) into :b1  from GE_CLIENTES where \
COD_CLIENTE=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2611;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihUno_Negat;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodIdioma;
 sqlstm.sqhstl[1] = (unsigned long )6;
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
		ifnTrazaHilos( modulo,&pfLog,  "Error al recuperar idioma cliente ==> [%ld].", LOG00, lhCodCliente );  
		return FALSE;		
	}

	if( sqlca.sqlcode == SQLNOTFOUND )	{
		ifnTrazaHilos( modulo,&pfLog,  "Cliente ==> [%ld], no existe en SISCEL.", LOG01, lhCodCliente );  
		return FALSE;		
	}

	strcpy( szCodIdioma, szhCodIdioma );
	return TRUE;

} /* fin bfnSelectIdiomaCliente */


/*==================================================================================================*/
/* Funcion que Obtiene el codigo de operadora local																 */
/*==================================================================================================*/
char *szfnRecuperaOperadora(FILE **ptArchLog, sql_context ctxCont)
{	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodOperadora[6];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "szfnRecuperaOperadora";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
	memset( szhCodOperadora, '\0', sizeof( szhCodOperadora ) );
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COD_OPERADORA_SCL
	INTO   :szhCodOperadora
	FROM   GE_OPERADORA_SCL_LOCAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_OPERADORA_SCL into :b0  from GE_OPERADORA_SCL_LOC\
AL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2638;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "Error al recuperar Codigo Operadora Local ==> [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return "ERROR";
	}  

	rtrim( szhCodOperadora );
	ifnTrazaHilos( modulo,&pfLog,  "Valor de Operadora recuperado ==> [%s].", LOG07, szhCodOperadora );

	return szhCodOperadora;

} /* fin szfnRecuperaOperadora */


/****************************************************************************************************/
/* Funcion que verifica Autenticacion del celular de un abonado  											    */
/****************************************************************************************************/
BOOL bfnAutenticacion(FILE **ptArchLog, long lNumAbonado, long lNumCelular, int iCodProducto, char *szNumSerie, 
                      char *szIndProc, GENSERVICIO *stServicios, char *szCadenaServOut, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhNumSerie[iLENNUMSERIE];		/* EXEC SQL VAR szhNumSerie IS STRING(iLENNUMSERIE); */ 

	int	ihCodEstado;
	int   ihUno_Negat = -1;
	int   ihValor_uno = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnAutenticacion";
char	szIndProcequi[3];
int	iRet = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG03, modulo );

	memset( szhNumSerie, '\0', sizeof( szhNumSerie ) );
	memset( szIndProcequi, '\0', sizeof( szIndProcequi ) );
	
	strcpy( szhNumSerie, szNumSerie );
	strcpy( szIndProcequi, szIndProc );

	ifnTrazaHilos( modulo,&pfLog,  "Datos entrada modulo => [%s].\n"
						"\t\t   lNumAbonado           => [%ld],\n"
						"\t\t   lNumCelular           => [%ld],\n"
						"\t\t   iCodProducto          => [%d],\n"
						"\t\t   szNumSerie            => [%s],\n"
						"\t\t   szIndProc             => [%s],\n"
						"\t\t   stServ->szCodServicio => [%s],\n"
						"\t\t   stServ->iCodServSupl  => [%d],\n"
						"\t\t   szCadenaServOut       => [%s]\n",
						LOG05,
						modulo,
						lNumAbonado,
						lNumCelular,
						iCodProducto,
						szNumSerie,
						szIndProc,
						stServicios->szCodServicio,
						stServicios->iCodServSupl,
						szCadenaServOut );

	/* se busca si existe el registro en akeys */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COD_ESTADO
	INTO	 :ihCodEstado
	FROM	 ICT_AKEYS
	WHERE	 NUM_ESN = :szhNumSerie; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ESTADO into :b0  from ICT_AKEYS where NUM_ESN=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2657;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhNumSerie;
 sqlstm.sqhstl[1] = (unsigned long )26;
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


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{  
		ifnTrazaHilos( modulo,&pfLog,  "Serie = [%s], SELECT ICT_AKEYS ==> %s.", LOG00, szhNumSerie, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}  

	if( sqlca.sqlcode == SQLNOTFOUND && !strcmp( szIndProcequi, "I" ) ) /* si no existe en akeys y es interno, se crea el registro */
	{  
		ifnTrazaHilos( modulo,&pfLog,  "Abonado = [%ld], Se inserta en ICT_AKEYS.", LOG05, lNumAbonado );

		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		INSERT  INTO ICT_AKEYS ( 
		        NUM_ESN     , FEC_ACTUALIZACION, ID_CARGA    , COD_ESTADO )
		VALUES (:szhNumSerie, SYSDATE          , :ihUno_Negat, :ihUno_Negat ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into ICT_AKEYS (NUM_ESN,FEC_ACTUALIZACION,ID_CARGA,C\
OD_ESTADO) values (:b0,SYSDATE,:b1,:b1)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2680;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[0] = (unsigned long )26;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihUno_Negat;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihUno_Negat;
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


		
		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
		{  
			ifnTrazaHilos( modulo,&pfLog,  "Serie = [%s], INSERT ICT_AKEYS ==> %s.", LOG00, szhNumSerie, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}  
	
		if( ( iRet = ifnVerifServicioActivo(&pfLog, lNumAbonado, stServicios->szCodServicio, CXX ) ) < 0 )
			return FALSE;

		if( iRet != 0 ) /* existe servicio,debemos desactivar en la tabla ga_servsuplabo */
		{
			ifnTrazaHilos( modulo,&pfLog,  "Vamos a desactivar servicio en tabla GA_SERVSUPLABO.", LOG05 );
			/* desactivamos el servicio en la tabla ga_servsuplabo */
			if( !bfnUpdateServicioSupl(&pfLog, lNumAbonado, iSERVDESBD, iSERVDESACT, stServicios, CXX ) )
				return FALSE;
		
			/* sacamos de la matriz el servicio suplementario */
			if( !bfnExtraerCadenaClaseServicio(&pfLog, lNumAbonado, stServicios->iCodServSupl, iSERVACTIVO, CXX ) )
				return FALSE;
		} /* if( iRet != 0 ) */

		/* no se agregara el servicio suplementario */	
		sprintf( szCadenaServOut, "000000\0", stServicios->iCodServSupl, iSERVACTIVO );	
	}  
	else if( ihCodEstado == 0 || ihCodEstado == 2 ) /* solo si ya se a dado de alta el servicio */
	{
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
		/* EXEC SQL
		UPDATE ICT_AKEYS SET		
		       FEC_ACTUALIZACION = SYSDATE,
				 COD_ESTADO		  = :ihValor_uno
		WHERE	 NUM_ESN = :szhNumSerie; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 33;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update ICT_AKEYS  set FEC_ACTUALIZACION=SYSDATE,COD_ESTADO=\
:b0 where NUM_ESN=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2707;
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
  sqlstm.sqhstv[1] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[1] = (unsigned long )26;
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

	

		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
		{  
			ifnTrazaHilos( modulo,&pfLog,  "Serie => [%s], UPDATE ICT_AKEYS => [%s].", LOG00, szhNumSerie, sqlca.sqlerrm.sqlerrmc );
			return FALSE;
		}  

		if( ( iRet = ifnVerifServicioActivo(&pfLog, lNumAbonado, stServicios->szCodServicio, CXX ) ) < 0 )
			return FALSE;

		if( iRet == 0 ) /* existe servicio,debemos desactivar en la tabla ga_servsuplabo */
		{
			ifnTrazaHilos( modulo,&pfLog,  "Vamos a crear servicio en tabla GA_SERVSUPLABO.", LOG05 );
			/* creamos el servicio suplementario en la ga_servsuplabo */
			if( !bfnInsertaServSupl(&pfLog, lNumAbonado, lNumCelular, stServicios, iCodProducto, iSERVACTBD, iSERVACTIVO, CXX ) ) /* desactivamos el servicio en la tabla ga_servsuplabo */
				return FALSE;
		}

		/* sacamos de la matriz el servicio suplementario, si esta activo */
		if( !bfnExtraerCadenaClaseServicio(&pfLog, lNumAbonado, stServicios->iCodServSupl, iSERVACTIVO, CXX ) )
			return FALSE;

		/* sacamos de la matriz el servicio suplementario, si esta desactivado */
		if( !bfnExtraerCadenaClaseServicio(&pfLog, lNumAbonado, stServicios->iCodServSupl, iSERVDESACT, CXX ) )
			return FALSE;
			
		if( !bfnConcatenaClaseServicio(&pfLog, lNumAbonado, stServicios->iCodServSupl, iSERVACTIVO, CXX ) )
			return FALSE;

		/* se agrega a la cadena de salida el servicio suplementario activado */
		sprintf( szCadenaServOut, "%02d%04d\0", stServicios->iCodServSupl, iSERVACTIVO );
	}
	else if( ihCodEstado == -1 ) /* en proceso de autenticacion */
	{
		if( ( iRet = ifnVerifServicioActivo(&pfLog, lNumAbonado, stServicios->szCodServicio, CXX ) ) < 0 )
			return FALSE;

		if( iRet != 0 ) /* existe servicio,debemos desactivar en la tabla ga_servsuplabo */
		{
			ifnTrazaHilos( modulo,&pfLog,  "Vamos a desactivar servicio en tabla GA_SERVSUPLABO.", LOG05 );
			/* desactivamos el servicio en la tabla ga_servsuplabo */
			if( !bfnUpdateServicioSupl(&pfLog, lNumAbonado, iSERVDESBD, iSERVDESACT, stServicios, CXX ) )
				return FALSE;
		
			/* sacamos de la matriz el servicio suplementario */
			if( !bfnExtraerCadenaClaseServicio(&pfLog, lNumAbonado, stServicios->iCodServSupl, iSERVACTIVO, CXX ) )
				return FALSE;
		} /* if( iRet != 0 ) */

		/* no se agregara el servicio suplementario */	
		sprintf( szCadenaServOut, "000000\0", stServicios->iCodServSupl, iSERVACTIVO );	

	} /* if( sqlca.sqlcode == SQLNOTFOUND && !strcmp( szIndProcequi, 'I' ) ) */
		
	ifnTrazaHilos( modulo,&pfLog,  "Retorno modulo => [%s], szCadenaServOut => [%s].", LOG05, modulo, szCadenaServOut );
	return TRUE;
} /* BOOL bfnAutenticacion( char *szNumSerie, char *szServicio ) */


/****************************************************************************************************/
/* ifnVerifServicioActivo	
   Definicion		:	Verifica si un servicio en particular se encuentra activo.                     */
/****************************************************************************************************/
int ifnVerifServicioActivo(FILE **ptArchLog, long lNumAbonado, char *szCodServicio, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNumAbonado;
	char szhCodServicio[4];		/* EXEC SQL VAR szhCodServicio IS STRING(4); */ 
	
	int	 ihCnt;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnVerifServicioActivo";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );

	memset( szhCodServicio, '\0', sizeof( szhCodServicio ) );
	sprintf( szhCodServicio, "%s\0", szCodServicio );
	lhNumAbonado = lNumAbonado;
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT COUNT(*)  
	  INTO :ihCnt
	  FROM GA_SERVSUPLABO
	 WHERE NUM_ABONADO  = :lhNumAbonado
	   AND COD_SERVICIO = :szhCodServicio
	   AND TRUNC( FEC_ALTABD ) <= TRUNC( SYSDATE )
	   AND FEC_BAJABD IS NULL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_SERVSUPLABO where (((NUM_\
ABONADO=:b1 and COD_SERVICIO=:b2) and TRUNC(FEC_ALTABD)<=TRUNC(SYSDATE)) and F\
EC_BAJABD is null )";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2730;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCnt;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodServicio;
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


        
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{  
		ifnTrazaHilos( modulo,&pfLog,  "COD_SERVICIO => [%s], Error al Verificar Servicio Suplementario => [%s].", LOG00, szhCodServicio, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}  
	if( ihCnt > 0 )
		ifnTrazaHilos( modulo,&pfLog,  "COD_SERVICIO => [%s], Se encuentra activo.", LOG05, szhCodServicio );
	else
		ifnTrazaHilos( modulo,&pfLog,  "COD_SERVICIO => [%s], No se encuentra activo.", LOG05, szhCodServicio );
	
	return ihCnt;
} /* int	ifnVerifServicioActivo( long lNumAbonado, char *szCodServicio ) */


/****************************************************************************************************/
/* bfnUpdateServicioSupl																			
	Definicion		:	Actualiza un servicio suplementario del abonado.                               */
/****************************************************************************************************/
BOOL bfnUpdateServicioSupl(FILE **ptArchLog, long lNumAbonado, int iCodEstado, int iCodNivel, GENSERVICIO *stServicios, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNumAbonado;
	int	 ihCodEstado;
	int	 ihCodNivel;
	char szhCodServicio[4];		/* EXEC SQL VAR szhCodServicio IS STRING(4); */ 
	
	int	 ihCodServSupl;
	char szhCadenaSql[1001];		/* EXEC SQL VAR szhCadenaSql IS STRING(1001); */ 
	
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnUpdateServicioSupl";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );

	memset( szhCodServicio, '\0', sizeof( szhCodServicio ) );
	memset( szhCadenaSql, '\0', sizeof( szhCadenaSql ) );

	lhNumAbonado= lNumAbonado;
	ihCodEstado = iCodEstado;
	ihCodNivel  = iCodNivel;
	sprintf( szhCodServicio, "%s\0", stServicios->szCodServicio );
	ihCodServSupl = stServicios->iCodServSupl;
	
	sprintf( szhCadenaSql, "UPDATE GA_SERVSUPLABO" ); 
	sprintf( szhCadenaSql, "%s  SET IND_ESTADO   = :v1 , ", szhCadenaSql );
	sprintf( szhCadenaSql, "%s	    NOM_USUARORA = USER, ", szhCadenaSql );

	if( ihCodEstado == iSERVDESBD )
		sprintf( szhCadenaSql, "%s      FEC_BAJABD   = SYSDATE, ", szhCadenaSql ); /* baja de servicio */
	else
		sprintf( szhCadenaSql, "%s      FEC_ALTABD   = SYSDATE, ", szhCadenaSql ); /* alta de servicio */
			
	sprintf( szhCadenaSql, "%s	    COD_NIVEL    = :v2 ", szhCadenaSql );
	sprintf( szhCadenaSql, "%sWHERE NUM_ABONADO  = :v3 ", szhCadenaSql );
	sprintf( szhCadenaSql, "%s  AND COD_SERVICIO = :v4 ", szhCadenaSql );
	sprintf( szhCadenaSql, "%s  AND COD_SERVSUPL = :v5 ", szhCadenaSql );

	if( ihCodEstado == iSERVDESBD )
		sprintf( szhCadenaSql, "%s  AND FEC_BAJABD IS NULL ", szhCadenaSql ); /* baja de servicio */
    else
		sprintf( szhCadenaSql, "%s  AND FEC_ALTABD IS NULL ", szhCadenaSql ); /* alta de servicio */
		
	ifnTrazaHilos( modulo,&pfLog,  "[%s]\n", LOG05, szhCadenaSql );
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL PREPARE UpdateServSupl FROM :szhCadenaSql; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2757;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaSql;
 sqlstm.sqhstl[0] = (unsigned long )1001;
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
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Error en PREPARE UpdateServSupl => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;
	}
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL EXECUTE UpdateServSupl USING :ihCodEstado, :ihCodEstado, :lhNumAbonado, :szhCodServicio, :ihCodServSupl ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2776;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodEstado;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodServicio;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodServSupl;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Error en EXECUTE UpdateServSupl => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;
	}

	return TRUE;
} /* BOOL bfnUpdateServicioSupl( long lNumAbonado, int iCodEstado, int iCodNivel, GENSERVICIO *stServicios ) */


/******************************************************************************************************/
/* bfnExtraerCadenaClaseServicio																	
	Definicion	:Extrae desde la cadena clase de servicio, el servicio y nivel pasado como parametro   */
/******************************************************************************************************/
BOOL bfnExtraerCadenaClaseServicio(FILE **ptArchLog, long lNumAbonado, int iCodServicio, int iNivel, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	char	szhClaseServicio   [257];	/* EXEC SQL VAR szhClaseServicio IS STRING(257); */ 

	char	szhClaseServicioNew[257];	/* EXEC SQL VAR szhClaseServicioNew IS STRING(257); */ 

	char  szhLetra_X           [2];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
       
char 	modulo[] = "bfnExtraerCadenaClaseServicio";
char	szCadenaFind[7];
char	szCadenaAux[7];
int	iPos = 0, iLen = 0;
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
	strcpy(szhLetra_X,"X");
	lhNumAbonado = lNumAbonado;
 	
	memset ( szhClaseServicio, 0, sizeof( szhClaseServicio ) );
	memset ( szhClaseServicioNew, 0, sizeof( szhClaseServicioNew ) );
	memset ( szCadenaFind, 0, sizeof( szCadenaFind ) );
	memset ( szCadenaAux, 0, sizeof( szCadenaAux ) );
	
	sprintf ( szCadenaFind, "%02d%04d", iCodServicio, iNivel );
	ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Cadena Buscada %s.", LOG05, lhNumAbonado, szCadenaFind );
	
	/* recuperamos la cadena clase de servicio del abonado */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT NVL( CLASE_SERVICIO, :szhLetra_X )
	INTO	 :szhClaseServicio
	FROM 	 GA_ABOCEL
	WHERE  NUM_ABONADO	= :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(CLASE_SERVICIO,:b0) into :b1  from GA_ABOCEL wher\
e NUM_ABONADO=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2811;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_X;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhClaseServicio;
 sqlstm.sqhstl[1] = (unsigned long )257;
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
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Recuperando Clase Servicio del Abonado %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	iLen = strlen( szhClaseServicio );
	ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Clase Servicio => [%s], Len Cadena => [%d].", LOG05, lhNumAbonado, szhClaseServicio, iLen );  

	if( ( iLen % 6 ) != 0 && strcmp( szhClaseServicio, "X" ) != 0 )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Clase Servicio del Abonado esta Inconsistente.", LOG01, lhNumAbonado );
		return FALSE;
	}
	else if( strcmp( szhClaseServicio, "X" ) == 0 )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], No tiene Clase Servicio.", LOG03, lhNumAbonado );
		return TRUE;
	}
	
	do {
		strncpy( szCadenaAux, &szhClaseServicio[iPos], 6 );
	
		ifnTrazaHilos( modulo,&pfLog,  "CadenaAux = [%s]. iPos = [%d].", LOG05, szCadenaAux, iPos );  

		if( strcmp( szCadenaAux, szCadenaFind ) != 0 )
		{
			sprintf( szhClaseServicioNew, "%s%s", szhClaseServicioNew, szCadenaAux );
			ifnTrazaHilos( modulo,&pfLog,  "szhClaseServicioNew = [%s].", LOG05, szhClaseServicioNew );  
		}
		
		iPos += 6;	
	} while( iPos < iLen ); 
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	UPDATE GA_ABOCEL SET 
	       CLASE_SERVICIO = :szhClaseServicioNew,
	       FEC_ULTMOD   = SYSDATE,
	       NOM_USUARORA = USER
	 WHERE NUM_ABONADO	= :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update GA_ABOCEL  set CLASE_SERVICIO=:b0,FEC_ULTMOD=SYSDATE,\
NOM_USUARORA=USER where NUM_ABONADO=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2838;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhClaseServicioNew;
 sqlstm.sqhstl[0] = (unsigned long )257;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Actualizando Clase Servicio => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	return TRUE;
} /* BOOL bfnExtraerCadenaClaseServicio( long lNumAbonado, int iCodServicio, int iNivel ) */


/****************************************************************************************************/
/* bfnInsertaServSupl																				
	Definicion		:	Actualiza un servicio suplementario del abonado.                               */
/****************************************************************************************************/
BOOL bfnInsertaServSupl(FILE **ptArchLog, long lNumAbonado, long lNumCelular, GENSERVICIO *stServicios, int iCodProducto, int iCodEstado, int iCodNivel, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNumAbonado;
	long lhNumCelular;
	int	 ihCodEstado;
	int	 ihCodNivel;
	int	 ihCodProducto;
	char szhCodServicio[4];		/* EXEC SQL VAR szhCodServicio IS STRING(4); */ 
	
	int	 ihCodServSupl;
	char szhCadenaSql[1001];	/* EXEC SQL VAR szhCadenaSql IS STRING(1001); */ 
	
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnInsertaServSupl";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );

	memset( szhCodServicio, '\0', sizeof( szhCodServicio ) );

	lhNumAbonado = lNumAbonado;
	lhNumCelular = lNumCelular;
	ihCodEstado = iCodEstado;
	ihCodNivel = iCodNivel;
	ihCodProducto = iCodProducto;
	sprintf( szhCodServicio, "%s\0", stServicios->szCodServicio );
	ihCodServSupl = stServicios->iCodServSupl;

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	INSERT INTO GA_SERVSUPLABO( NUM_ABONADO,
								NUM_TERMINAL,
								COD_SERVICIO,
								COD_SERVSUPL,
								COD_NIVEL,
								COD_PRODUCTO,
								IND_ESTADO,
								FEC_ALTABD,
								NOM_USUARORA )
				VALUES 		  ( :lhNumAbonado,
								:lhNumCelular,
								:szhCodServicio,
								:ihCodServSupl,
								:ihCodNivel,
								:ihCodProducto,
								:ihCodEstado,
								SYSDATE,
								USER ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into GA_SERVSUPLABO (NUM_ABONADO,NUM_TERMINAL,COD_SER\
VICIO,COD_SERVSUPL,COD_NIVEL,COD_PRODUCTO,IND_ESTADO,FEC_ALTABD,NOM_USUARORA) \
values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,SYSDATE,USER)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2861;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodServicio;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodServSupl;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodNivel;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodEstado;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Error al insertar en GA_SERVSUPLABO => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;
	}
	return TRUE;
} /* BOOL bfnInsertaServSupl( long lNumAbonado, int iCodEstado, int iCodNivel, GENSERVICIO *stServicios ) */


/****************************************************************************************************/
/* bfnConcatenaClaseServicio																		
	Definicion	:Concatena a la cadena clase de servicio, el servicio y nivel pasado como parametro. */
/****************************************************************************************************/
BOOL bfnConcatenaClaseServicio(FILE **ptArchLog, long lNumAbonado, int iCodServicio, int iNivel, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
 	char	szhServSupl[7];	/* EXEC SQL VAR szhServSupl IS STRING(7); */ 

	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
       
char 	modulo[] = "bfnConcatenaClaseServicio";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
	
	memset ( szhServSupl, 0, sizeof( szhServSupl ) );

	lhNumAbonado = lNumAbonado;
	
	sprintf ( szhServSupl, "%02d%04d", iCodServicio, iNivel );
	ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Cadena a concatenar => [%s].", LOG05, lhNumAbonado, szhServSupl );
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	UPDATE GA_ABOCEL
	   SET CLASE_SERVICIO = CLASE_SERVICIO || :szhServSupl,
	       FEC_ULTMOD   = SYSDATE,
	       NOM_USUARORA = USER
	 WHERE NUM_ABONADO	= :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update GA_ABOCEL  set CLASE_SERVICIO=(CLASE_SERVICIO||:b0),F\
EC_ULTMOD=SYSDATE,NOM_USUARORA=USER where NUM_ABONADO=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2904;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhServSupl;
 sqlstm.sqhstl[0] = (unsigned long )7;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK )
	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado => [%ld], Actualizando Clase Servicio => [%s].", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	return TRUE;
} /* BOOL bfnConcatenaClaseServicio( long lNumAbonado, int iCodServicio, int iNivel ) */

/****************************************************************************************************/		
/* ifnAplicarAutenticacion																	
	Definicion		:Valida si se debe aplicar funcionalidad de Autenticacion.                        */
/****************************************************************************************************/
int ifnAplicarAutenticacion(FILE **ptArchLog, sql_context ctxCont)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  iAplicarAutenticacion;
	int  ihValor_uno = 1;
	char szhAUTENTICACION [19];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnAplicarAutenticacion";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
 	strcpy(szhAUTENTICACION,"OPER_AUTENTICACION");

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT TO_NUMBER( VAL_PARAMETRO ) 
	INTO  :iAplicarAutenticacion
	FROM  GED_PARAMETROS
	WHERE COD_PRODUCTO  = :ihValor_uno
	AND   NOM_PARAMETRO = :szhAUTENTICACION; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_NUMBER(VAL_PARAMETRO) into :b0  from GED_PARAMETRO\
S where (COD_PRODUCTO=:b1 and NOM_PARAMETRO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2927;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iAplicarAutenticacion;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhAUTENTICACION;
 sqlstm.sqhstl[2] = (unsigned long )19;
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


	   
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 
	{  
		ifnTrazaHilos( modulo,&pfLog,  "Error al Validar Aplicacion Autenticacion => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}  
	
	if( sqlca.sqlcode == SQLNOTFOUND ) 
	{  
		ifnTrazaHilos( modulo,&pfLog,  "No se encuentra disponible Autenticacion.", LOG03 );
		iAplicarAutenticacion = 0;
	}  
		
	ifnTrazaHilos( modulo,&pfLog,  "Se encuentra disponible Autenticacion.", LOG03 );
	return iAplicarAutenticacion;
} /* int ifnAplicarAutenticacion() */

/*==================================================================================================*/
/* Funcion que Recupera el uso de Venta asociado al CodUso.          									    */
/*==================================================================================================*/
int ifnObtieneUsoVenta(FILE **ptArchLog, int iCodUso, char *szCodTecnologia, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCodUso;	
	int  ihIndUsoVenta;	
	char szhCodTecnologia[iLENCODTECNO];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "ifnObtieneUsoVenta";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog,  "Ingreso modulo : [%s].", LOG05, modulo );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	strcpy( szhCodTecnologia, szCodTecnologia );
	
	ihCodUso = iCodUso;
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT IND_USOVENTA 
	INTO   :ihIndUsoVenta
	FROM   AL_USOS
	WHERE  COD_USO = :ihCodUso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select IND_USOVENTA into :b0  from AL_USOS where COD_USO=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2954;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIndUsoVenta;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodUso;
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


	   
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "COD_USO => [%d] - TECNOLOGIA => [%s], Error al Recuperar IND_USOVENTA desde AL_USOS => [%s].", LOG00, ihCodUso, szhCodTecnologia, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}  
	
	if( sqlca.sqlcode == SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "COD_USO => [%d] - TECNOLOGIA => [%s], No se encuentra definido en AL_USOS.", LOG01, ihCodUso, szhCodTecnologia );
		return 0;
	}  
	
	ifnTrazaHilos( modulo,&pfLog,  "Valores retorno modulo => [%s], ihIndUsoVenta => [%d].", LOG03, modulo, ihIndUsoVenta );
						  
	return ihIndUsoVenta;
} /* int ifnObtieneUsoVenta( int iCodUso ) */


/*==================================================================================================*/
/* Funcion que ejecuta PL P_INTERFASES_ABONADOS.       									                   */      
/*==================================================================================================*/
BOOL bfnEjecutaPLInterfasesAbonados(FILE **ptArchLog, long lNumAbonado, int iCodProducto, char *szAccion, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	char	szhAccion[5];		/* EXEC SQL VAR szhAccion IS STRING(5); */ 

	long	lhNumSecuencia;
	int	ihRetornoPL = 0;
	int	ihCodProducto;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnEjecutaPLInterfasesAbonados";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	ifnTrazaHilos( modulo,&pfLog,  "Ingreso Modulo %s", LOG05, modulo );
	memset( szhAccion, '\0', sizeof( szhAccion ) );
	
	lhNumAbonado = lNumAbonado;
	ihCodProducto = iCodProducto;
	strcpy( szhAccion, szAccion );
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL
	SELECT	GA_SEQ_TRANSACABO.NEXTVAL
	INTO	:lhNumSecuencia
	FROM	DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2977;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
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


	
	if( sqlca.sqlcode )	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado = %ld, SELECT GA_SEQ_TRANSACABO.NEXTVAL %s", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	
	ifnTrazaHilos( modulo,&pfLog,  "P_INTERFASES_ABONADOS( %ld, %s, %d, %ld, '', '', '' )",
						  LOG05, lhNumSecuencia, szhAccion, ihCodProducto, lhNumAbonado );

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			P_INTERFASES_ABONADOS( :lhNumSecuencia, :szhAccion, :ihCodProducto, :lhNumAbonado, '', '', '' );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin P_INTERFASES_ABONADOS ( :lhNumSecuencia , :szhAccion ,\
 :ihCodProducto , :lhNumAbonado , '' , '' , '' ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2996;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhAccion;
 sqlstm.sqhstl[1] = (unsigned long )5;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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

 
	
	ifnTrazaHilos( modulo,&pfLog,  "Retorno sqlca.sqlcode de P_INTERFASES_ABONADOS => [%d].", LOG03, sqlca.sqlcode );

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 
	SELECT COD_RETORNO
	INTO	 :ihRetornoPL
	FROM	 GA_TRANSACABO
	WHERE	 NUM_TRANSACCION = :lhNumSecuencia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_RETORNO into :b0  from GA_TRANSACABO where NUM_TR\
ANSACCION=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3027;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihRetornoPL;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
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


	
	if( sqlca.sqlcode ) 	{
		ifnTrazaHilos( modulo,&pfLog,  "Abonado = %ld, SELECT COD_RETORNO GA_TRANSACABO %s", LOG01, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;	
	}
	else if( ihRetornoPL == 4 )
	{
		ifnTrazaHilos( modulo,&pfLog,  "En P_INTERFASES_ABONADOS (Transaccion:%ld)(Abonado:%ld)(Accion:'BA')",
								LOG00, lhNumSecuencia, lhNumAbonado, szhAccion );
		return FALSE;
	}
	
	return TRUE;
} /* BOOL bfnEjecutaPLInterfasesAbonados( long lNumAbonado, int iCodProducto, char *szAccion ) */
	
/*==================================================================================================*/
/* Funcion que Habilita y deshabilita Tarjetas Club de los abonados.      									 */
/*==================================================================================================*/
BOOL bfnEjecutaPLAlInterfazClub(FILE **ptArchLog, long lNumAbonado, char *szCodCausaBaja, char *szAccion, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	char	szhCodCausaBaja[3];
	char	szhAccion[3];
	int	ihRetornoPL = 0;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

int	iError = 0;
char	modulo[] = "bfnEjecutaPLAlInterfazClub";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	ifnTrazaHilos( modulo,&pfLog,  "Ingreso Modulo %s", LOG05, modulo );
	memset( szhCodCausaBaja, '\0', sizeof( szhCodCausaBaja ) );
	memset( szhAccion, '\0', sizeof( szhAccion ) );
	
	lhNumAbonado = lNumAbonado;
	strcpy( szhCodCausaBaja, szCodCausaBaja );
	strcpy( szhAccion, szAccion );
	
	ifnTrazaHilos( modulo,&pfLog, 	"Datos entrada %s.\n"
							"\t\t   lhNumAbonado    [%ld],\n"
							"\t\t   szhCodCausaBaja [%s],\n"
							"\t\t   szhAccion       [%s],\n",
							LOG05, modulo, lhNumAbonado, szhCodCausaBaja, szhAccion );

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			P_AL_INTERFAZ_CLUB( TO_CHAR(:lhNumAbonado), NULL, NULL, :szhCodCausaBaja, :szhAccion );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin P_AL_INTERFAZ_CLUB ( TO_CHAR ( :lhNumAbonado ) , NULL \
, NULL , :szhCodCausaBaja , :szhAccion ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3050;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodCausaBaja;
 sqlstm.sqhstl[1] = (unsigned long )3;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhAccion;
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

 
	
	if( sqlca.sqlcode != SQLOK ) 	{
		if( sqlca.sqlcode == -20164 )		{
			ifnTrazaHilos( modulo,&pfLog,  "Abonado = %ld, Error P_AL_INTERFAZ_CLUB %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
			return FALSE;	
		}
		else	
		{
			ifnTrazaHilos( modulo,&pfLog,  "Abonado = %ld, Ejecucion de TARJETA CLUB, no fue exitosa.", LOG03, lhNumAbonado );
		}
	}
	else
	{
		ifnTrazaHilos( modulo,&pfLog,  "Tarjeta Club OK (Abonado:%ld) (Accion:'%s') ",
								LOG03, lhNumAbonado, szhAccion );
	}
	
	return TRUE;
} /* BOOL bfnEjecutaPLAlInterfazClub( long lNumAbonado, char *szCodCausaBaja, char *szAccion ) */


/*==================================================================================================*/
/* Funcion que Obtiene el saldo vencido de un cliente.                  									 */
/*==================================================================================================*/
int ifnGetSaldoVencidoAcc(FILE **ptArchLog, long lCodCliente, double *pdSaldoVenc, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long   lhCodCliente;
	double dhSaldoVenc  = 0.0;
	char   szhCARTERA    [11];
	char   szhTIPDOCUM   [13];
	int    ihValor_uno  = 1  ;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
    
char modulo[] = "ifnGetSaldoVencidoAcc";
struct sqlca sqlca;
FILE *pfLog = *ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo : [%s].", LOG05, modulo );
	lhCodCliente = lCodCliente;
	strcpy(szhCARTERA ,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL 	
	SELECT NVL( SUM( IMPORTE_DEBE - IMPORTE_HABER ), 0 )
	INTO  :dhSaldoVenc
	FROM  CO_CARTERA
	WHERE COD_CLIENTE  = :lhCodCliente 
	AND   IND_FACTURADO= :ihValor_uno
	AND   FEC_VENCIMIE < TRUNC( SYSDATE )
	AND   COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
								      FROM	 CO_CODIGOS
								      WHERE	 NOM_TABLA  = :szhCARTERA
								      AND    NOM_COLUMNA= :szhTIPDOCUM); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),0) into :b0  fr\
om CO_CARTERA where (((COD_CLIENTE=:b1 and IND_FACTURADO=:b2) and FEC_VENCIMIE\
<TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from C\
O_CODIGOS where (NOM_TABLA=:b3 and NOM_COLUMNA=:b4)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3077;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhSaldoVenc;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[4] = (unsigned long )13;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
        ifnTrazaHilos( modulo,&pfLog, "En Obtener Saldo Vencido => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );  
        return -1;
   }

	*pdSaldoVenc = dhSaldoVenc;
 	ifnTrazaHilos( modulo,&pfLog, "Saldo Vencido : [%2.f].", LOG05, *pdSaldoVenc);
   return 0; 
} /* ifnGetSaldoVencidoAcc */

/* ============================================================================= */
/* Recibe el formato en el que desea retornar SYSDATE                            */
/* Asume que se encuentra conectado a Oracle                                     */
/* ============================================================================= */
int ifnSysDateYYYYMMDD( char *pszFecha, sql_context pctxCTX )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char  szhDateTime[9];	/* EXEC SQL VAR szhDateTime IS STRING(9); */ 

/* EXEC SQL END DECLARE SECTION; */ 

sql_context CXXXX;
struct sqlca sqlca;

	CXXXX = pctxCTX;
	/* EXEC SQL CONTEXT USE :CXXXX; */ 


   memset(szhDateTime,'\0',sizeof(szhDateTime));
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
	/* EXEC SQL EXECUTE
		BEGIN
			:szhDateTime := TO_CHAR( SYSDATE, 'YYYYMMDD' );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szhDateTime := TO_CHAR ( SYSDATE , 'YYYYMMDD' ) ; END\
 ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3112;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDateTime;
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
 sqlcxt(&CXXXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK )	
	{
		fprintf( stderr, "Error al recuperar fecha => [%s].\n", sqlca.sqlerrm.sqlerrmc );
		return -1;
	}	

	strcpy( pszFecha, szhDateTime ); 
   return 0;
}

/* CH-200408232102 Homologado por PGonzalez Funcion incorporada 22-11-2004 */
/*****************************************************************************************************
******************************************************************************************************/
char *szGetCadenaServNivel(FILE **ptArchLog, long lNumAbonado, char *szCadena, sql_context ctxCont ) /*CH-200408232102 27-08-2004 PRM */
{
   /* Obtiene una Cadena formada por la concatenacion de todos los Servicios Suplementarios
          Que tenemos para un Nº de Abonado en la tabla GA_SERVSUPLABO                                                   */

/* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumAbonado;
        int     ihCodServSupl;
        int     ihCodNivel;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
               
char    modulo[] = "szGetCadenaServNivel";
char    szCadenaAux[256];
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
        lhNumAbonado = lNumAbonado;            
        memset ( szCadenaAux, 0, sizeof( szCadenaAux ) );
        
        sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
        /* EXEC SQL DECLARE curGaSurp CURSOR FOR
        SELECT  COD_SERVSUPL, 
                        COD_NIVEL 
        FROM    GA_SERVSUPLABO
        WHERE   NUM_ABONADO = :lhNumAbonado
        AND     ( IND_ESTADO < 3 or IND_ESTADO = 5 ); */ 
 

        if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {
                ifnTrazaHilos( modulo, &pfLog, "lhNumAbonado:[%ld] DECLARE curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
                return "PND";
        }

        sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
        /* EXEC SQL OPEN curGaSurp; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0078;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3131;
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
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


        if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {
                ifnTrazaHilos( modulo, &pfLog, "lhNumAbonado:[%ld] OPEN curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc);
                return "PND";
        }
        
        for ( ; ; )
        {               
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
                /* EXEC SQL FETCH curGaSurp INTO
                                        :ihCodServSupl,
                                        :ihCodNivel; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 33;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3150;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqfoff = (         int )0;
                sqlstm.sqfmod = (unsigned int )2;
                sqlstm.sqhstv[0] = (unsigned char  *)&ihCodServSupl;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&ihCodNivel;
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



                if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
                {
                        ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] FETCH curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
                        return "PND";
                }

                if ( sqlca.sqlcode == SQLNOTFOUND )
                {
                        ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] Fin Datos Cursor curGaSurp.", LOG03, lhNumAbonado );
                        break;
                }
                
                sprintf ( szCadenaAux, "%s%02d%04d", szCadenaAux, ihCodServSupl, ihCodNivel );
        }

        sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
        /* EXEC SQL CLOSE curGaSurp; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3173;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


        if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {
                ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] CLOSE curGaSurp. %s ", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
                return "PND";
        }

        sprintf( szCadena, "%s", szCadenaAux );
        ifnTrazaHilos( modulo,&pfLog, "lhNumAbonado:[%ld] szGetCadenaServNivel, Retorno Cadena. %s.", LOG03, lhNumAbonado, szCadena );

        return "OK";
} /* char *szGetCadenaServNivel( long lNumAbonado, char *szCadena ) */

/*==================================================================================================*/
/* Funcion que Extrae desde la cadena perfil abonado el servicio y nivel pasado como parametro      */
/*==================================================================================================*/
BOOL bfnExtraerCadenaPerfilAbo( FILE **ptArchLog, long lNumAbonado, int iCodServicio, int iNivel, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhNumAbonado;
	char	szhPerfilAbonado[257];		/* EXEC SQL VAR szhPerfilAbonado IS STRING(257); */ 

	char	szhPerfilNew[257];			/* EXEC SQL VAR szhPerfilNew IS STRING(257); */ 

	char  szhLetra_X  [2];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 
       
char 	modulo[] = "bfnExtraerCadenaPerfilAbo";
char	szCadenaFind[7];
char	szCadenaAux[7];
int	iPos = 0, iLen = 0;
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;
 	
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG05, modulo );
 	ifnTrazaHilos( modulo,&pfLog, "Esto debe aparecer en el log.", LOG05 );
	lhNumAbonado = lNumAbonado;
	strcpy(szhLetra_X,"X");
 	
	memset ( szhPerfilAbonado, 0, sizeof( szhPerfilAbonado ) );
	memset ( szhPerfilNew, 0, sizeof( szhPerfilNew ) );
	memset ( szCadenaFind, 0, sizeof( szCadenaFind ) );
	memset ( szCadenaAux, 0, sizeof( szCadenaAux ) );
	
	sprintf ( szCadenaFind, "%02d%04d", iCodServicio, iNivel );
	ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, Cadena Buscada %s.", LOG05, lhNumAbonado, szCadenaFind );
	
	/* recuperamos la cadena del perfil del abonado */
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT NVL( PERFIL_ABONADO, :szhLetra_X )
	INTO	 :szhPerfilAbonado
	FROM 	 GA_ABOCEL
	WHERE  NUM_ABONADO	= :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(PERFIL_ABONADO,:b0) into :b1  from GA_ABOCEL wher\
e NUM_ABONADO=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3188;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_X;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhPerfilAbonado;
 sqlstm.sqhstl[1] = (unsigned long )257;
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
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, Recuperando Perfil del Abonado %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	iLen = strlen( szhPerfilAbonado );
	ifnTrazaHilos( modulo,&pfLog, "Abonado %ld, Perfil = [%s], Len Cadena %d.", LOG05, lhNumAbonado, szhPerfilAbonado, iLen );  

	if( ( iLen % 6 ) != 0 && strcmp( szhPerfilAbonado, "X" ) != 0 )	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, Perfil del Abonado es incorrecto.", LOG00, lhNumAbonado );
		return FALSE;
	}
	else if( strcmp( szhPerfilAbonado, "X" ) == 0 )
	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, No tiene Perfil Abonado.", LOG03, lhNumAbonado );
		return TRUE;
	}
	
	do {
		strncpy( szCadenaAux, &szhPerfilAbonado[iPos], 6 );
	
		ifnTrazaHilos( modulo,&pfLog, "CadenaAux = [%s]. iPos = [%d].", LOG05, szCadenaAux, iPos );  

		if( strcmp( szCadenaAux, szCadenaFind ) != 0 )
		{
			sprintf( szhPerfilNew, "%s%s", szhPerfilNew, szCadenaAux );
			ifnTrazaHilos( modulo,&pfLog, "szhPerfilNew = [%s].", LOG05, szhPerfilNew );  
		}
		
		iPos += 6;	
	} while( iPos < iLen ); 
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	UPDATE	GA_ABOCEL
	SET		PERFIL_ABONADO = :szhPerfilNew
	WHERE 	NUM_ABONADO	= :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 33;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update GA_ABOCEL  set PERFIL_ABONADO=:b0 where NUM_ABONADO=:\
b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )3215;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhPerfilNew;
 sqlstm.sqhstl[0] = (unsigned long )257;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK )	{
		ifnTrazaHilos( modulo,&pfLog, "Abonado = %ld, Actualizando Perfil Abonado. %s.", LOG00, lhNumAbonado, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}
	ifnTrazaHilos( modulo,&pfLog, "Saliendo de  modulo => [%s].", LOG05, modulo );
	return TRUE;
} /* BOOL bfnExtraerCadenaPerfilAbo( long lNumAbonado, int iCodServicio, int iNivel ) */


/*==================================================================================================*/
/* Funcion que Valida si el abonado tiene cambio de Plan Tarifario, 						    */
/* si lo tiene, Anula el cambio de Plan.                                                              */
/*==================================================================================================*/
BOOL ifnValidaCambioPlanTarifario(FILE **ptArchLog, long lCodCliente, long lNumAbonado, char *szCodPlanTarifario, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char sz_cod_retorno[100];  /* EXEC SQL var sz_cod_retorno is string(100); */ 

	char sz_glosa_retorno[3010];   /* EXEC SQL var sz_glosa_retorno is string(3010); */ 
	
	char sz_plan_NUEVO[100];   /* EXEC SQL var sz_plan_NUEVO is string(100); */ 

	long lNUM_OOSS;
	long lcod_retorno;
      	char sz_mens_retorno[3010];   /* EXEC SQL var sz_mens_retorno is string(3010); */ 
	
	int  i_num_evento;
	char szhValor_0 [2];
	char szhValor_1 [2];
	char szhValor_4 [2];
	long lhCodCliente;	
	long lhNumAbonado;
	char szhCodPlanTarifario     [100];	/* EXEC SQL VAR szCodPlanTarifario IS STRING (100); */ 
		
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnValidaCambioPlanTarifario";

struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

		 
	ifnTrazaHilos( modulo,&pfLog,  "Ingreso a modulo => [%s].", LOG05, modulo );
	/*memset(szhCodPlanTarifario,'\0',sizeof(szhCodPlanTarifario));*/
	memset(szhValor_0, 0x00, sizeof(szhValor_0));
	memset(szhValor_1, 0x00, sizeof(szhValor_1));
	memset(szhValor_4, 0x00, sizeof(szhValor_4));
	
	strcpy(szhValor_0,"0");
	strcpy(szhValor_1,"1");
	strcpy(szhValor_4,"4");
	strcpy( szhCodPlanTarifario        , szCodPlanTarifario );
	
	lhCodCliente = lCodCliente;	
	lhNumAbonado = lNumAbonado;

	ifnTrazaHilos( modulo,&pfLog,  "Parametros de Entrada.\n"
						  "\t\t   lhCodCliente        => [%ld]\n"
						  "\t\t   lhNumAbonado        => [%ld]\n"						  
						  "\t\t   szhCodPlanTarifario => [%s]\n",
						  LOG05,
						  lhCodCliente,
						  lhNumAbonado,
						  szhCodPlanTarifario);
   
    	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
    	/* EXEC SQL EXECUTE
    	BEGIN
        	PV_VAL_CAMPLAN_A_CICLO_PG.PV_VAL_CAMPLAN_A_CICLO_PR(:lhCodCliente, :lhNumAbonado, :szhValor_0, :szhCodPlanTarifario,
							:sz_cod_retorno, :sz_glosa_retorno, :sz_plan_NUEVO, :lNUM_OOSS, :lcod_retorno, :sz_mens_retorno, :i_num_evento );
    	END;
    	END-EXEC; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 33;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "begin PV_VAL_CAMPLAN_A_CICLO_PG . PV_VAL_CAMPLAN_A_CICLO\
_PR ( :lhCodCliente , :lhNumAbonado , :szhValor_0 , :szhCodPlanTarifario , :sz\
_cod_retorno , :sz_glosa_retorno , :sz_plan_NUEVO , :lNUM_OOSS , :lcod_retorno\
 , :sz_mens_retorno , :i_num_evento ) ; END ;";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )3238;
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
     sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhValor_0;
     sqlstm.sqhstl[2] = (unsigned long )2;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlanTarifario;
     sqlstm.sqhstl[3] = (unsigned long )100;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)sz_cod_retorno;
     sqlstm.sqhstl[4] = (unsigned long )100;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)sz_glosa_retorno;
     sqlstm.sqhstl[5] = (unsigned long )3010;
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)sz_plan_NUEVO;
     sqlstm.sqhstl[6] = (unsigned long )100;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&lNUM_OOSS;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&lcod_retorno;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)sz_mens_retorno;
     sqlstm.sqhstl[9] = (unsigned long )3010;
     sqlstm.sqhsts[9] = (         int  )0;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)&i_num_evento;
     sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    	
	if( sqlca.sqlcode ) {    
        	ifnTrazaHilos( modulo,&pfLog, "Fallo en Validacion Cambio Plan Tarifario\n"
                            "(Cliente:%ld|Abonado:%ld|Plan Tarifario:%s)\n"
                            "%s"
                           ,LOG00,lhCodCliente,lhNumAbonado,szhCodPlanTarifario,sqlca.sqlerrm.sqlerrmc);
		return FALSE; 
    	}
    	else
    	{   
    	
    		/*
		ifnTrazaHilos( modulo,&pfLog,  "Parametros de Salida.\n"
						  "\t\t   lhCodCliente        => [%ld]\n"
						  "\t\t   lhNumAbonado        => [%ld]\n"						  
						  "\t\t   szhCodPlanTarifario => [%s]\n"
						  "\t\t   sz_cod_retorno      => [%s]\n"
						  "\t\t   sz_glosa_retorno      => [%s]\n"
						  "\t\t   sz_plan_NUEVO      => [%s]\n"	
						  "\t\t   lNUM_OOSS        => [%ld]\n"						  					  
						  "\t\t   lcod_retorno        => [%ld]\n"						  
						  "\t\t   sz_mens_retorno      => [%s]\n"	
						  "\t\t   i_num_evento      => [%d]\n",
						  LOG05,
						  lhCodCliente,
						  lhNumAbonado,
						  szhCodPlanTarifario,
						  sz_cod_retorno,
						  sz_glosa_retorno,
						  sz_plan_NUEVO,
						  lNUM_OOSS,
						  lcod_retorno,
						  sz_mens_retorno,
						  i_num_evento);
		*/				      	 
		if( !strcmp(sz_cod_retorno,szhValor_0 ) ) /* ValRetorno = "0" */    	
		{
			ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld] Sin Cambio de Plan Tarifario (Retorno 0).", LOG05, lhNumAbonado);       	
		}
		else
		{
			if( !strcmp( sz_cod_retorno, szhValor_4 ) ) /* ValRetorno = "4" Retorno con Error */    	
			{
	        		ifnTrazaHilos( modulo,&pfLog, "Retorno con Error en Validacion Cambio Plan Tarifario\n"
	                            "(Cliente:%ld|Abonado:%ld|Plan Tarifario:%s|Cod. Retorno:%s|Glosa Retorno:%s|Mensaje Retorno:%s|Numero Evento:%d)\n"
	                            "%s"
	                           ,LOG00,lhCodCliente,lhNumAbonado,szhCodPlanTarifario,sz_cod_retorno,sz_glosa_retorno,sz_mens_retorno,i_num_evento, sqlca.sqlerrm.sqlerrmc);
				return FALSE;        			
        		}
        		else
        		{
        		
        			if( !strcmp( sz_cod_retorno, szhValor_1 ) ) /* ValRetorno = "1" Se debe anular cambio de plan tarifario */    	
        			{
				    	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
				    	/* EXEC SQL EXECUTE
				    	BEGIN
				        	PV_ANULA_CAMPLAN_A_CICLO_PG.PV_ANULA_CAMPLAN_A_CICLO_PR(:lhCodCliente, :lhNumAbonado, :szhCodPlanTarifario,
											:sz_cod_retorno, :sz_glosa_retorno, :sz_plan_NUEVO, :lNUM_OOSS, :lcod_retorno, :sz_mens_retorno, :i_num_evento );
				    	END;
				    	END-EXEC; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 33;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "begin PV_ANULA_CAMPLAN_A_CICLO_PG . PV_ANULA_CAMPLAN\
_A_CICLO_PR ( :lhCodCliente , :lhNumAbonado , :szhCodPlanTarifario , :sz_cod_r\
etorno , :sz_glosa_retorno , :sz_plan_NUEVO , :lNUM_OOSS , :lcod_retorno , :sz\
_mens_retorno , :i_num_evento ) ; END ;";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )3297;
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
         sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanTarifario;
         sqlstm.sqhstl[2] = (unsigned long )100;
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)sz_cod_retorno;
         sqlstm.sqhstl[3] = (unsigned long )100;
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)sz_glosa_retorno;
         sqlstm.sqhstl[4] = (unsigned long )3010;
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)sz_plan_NUEVO;
         sqlstm.sqhstl[5] = (unsigned long )100;
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)&lNUM_OOSS;
         sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)&lcod_retorno;
         sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[7] = (         int  )0;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)sz_mens_retorno;
         sqlstm.sqhstl[8] = (unsigned long )3010;
         sqlstm.sqhsts[8] = (         int  )0;
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)&i_num_evento;
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
         sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

        			
				    	if( sqlca.sqlcode ) {    
				        	ifnTrazaHilos( modulo,&pfLog, "Fallo en Anulacion de Cambio Plan Tarifario\n"
				                            "(Cliente:%ld|Abonado:%ld|Plan Tarifario:%s)\n"
				                            "%s"
				                           ,LOG00,lhCodCliente,lhNumAbonado,szhCodPlanTarifario,sqlca.sqlerrm.sqlerrmc);
						return FALSE; 
				    	}
				    	else
				    	{    
						if( !strcmp( sz_cod_retorno, szhValor_0 ) ) /* ValRetorno = "0" Ejecutado Ok */    	
						{
							ifnTrazaHilos( modulo,&pfLog,  "Cambio de Plan Tarifario Anulado ABONADO => [%ld]", LOG05, lhNumAbonado);  
						}
						else
						{
					        		ifnTrazaHilos( modulo,&pfLog, "Retorno con Error en Anulacion Cambio Plan Tarifario\n"
					                            "(Cliente:%ld|Abonado:%ld|Plan Tarifario:%s|Cod. Retorno:%s|Glosa Retorno:%s|Mensaje Retorno:%s|Numero Evento:%d)\n"
					                            "%s"
					                           ,LOG00,lhCodCliente,lhNumAbonado,szhCodPlanTarifario,sz_cod_retorno,sz_glosa_retorno,sz_mens_retorno,i_num_evento,sqlca.sqlerrm.sqlerrmc);
								return FALSE; 
				        	}	        			
        				}
				    	sqlca.sqlcode=0; /* se resetea la vble sql en caso de brain damage*/
				    	/*  Modificado por JLR  20080311
				    	EXEC SQL EXECUTE
				    	BEGIN
				        	MAS_PRODUCT_DML.PR_CONTRATAR_PRODUCT_ADIC_PG.PR_ANULA_CPA_PR(:lhCodCliente, :lhNumAbonado, TRUE, :lcod_retorno, :sz_mens_retorno, :i_num_evento );
				    	END;
				    	END-EXEC;        		
				    	if( sqlca.sqlcode ) {    
				        	ifnTrazaHilos( modulo,&pfLog, "Fallo en Anulacion de Cambio Plan Adicional\n"
				                            "(Cliente:%ld|Abonado:%ld|Ind_Anula:%s)\n"
				                            "%s"
				                           ,LOG00,lhCodCliente,lhNumAbonado,"TRUE",sqlca.sqlerrm.sqlerrmc);
						return FALSE; 
				    	}
				    	else
				    	{    
						if( !strcmp( sz_cod_retorno, szhValor_0 ) ) 
						{
							ifnTrazaHilos( modulo,&pfLog,  "Cambio de Plan Tarifario Anulado ABONADO => [%ld]", LOG05, lhNumAbonado);  
						}
						else
						{
					        		ifnTrazaHilos( modulo,&pfLog, "Retorno con Error en Anulacion Cambio Plan Adicional\n"
					                            "(Cliente:%ld|Abonado:%ld|Plan Tarifario:%s|Cod. Retorno:%s|Glosa Retorno:%s|Mensaje Retorno:%s|Numero Evento:%d)\n"
					                            "%s"
					                           ,LOG00,lhCodCliente,lhNumAbonado,"TRUE",sqlca.sqlerrm.sqlerrmc);
								return FALSE; 
				        	}	        			
        				}
                                        Fin Modificado por JLR  20080311     */
        				
        			}
        			else
        			{
        				ifnTrazaHilos( modulo,&pfLog,  "ABONADO => [%ld] Sin Cambio de Plan Tarifario.", LOG05, lhNumAbonado);  
        			}
        		}
        	}
    	}        
   return TRUE;
} /* int ifnValidaCambioPlanTarifario(FILE() */

/*****************************************************************************************************/		
/*****************************************************************************************************/		
/*****************************************************************************************************/		

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
