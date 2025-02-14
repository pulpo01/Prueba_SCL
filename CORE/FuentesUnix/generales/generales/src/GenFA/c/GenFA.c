
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
           char  filnam[14];
};
static const struct sqlcxp sqlfpn =
{
    13,
    "./pc/GenFA.pc"
};


static unsigned int sqlctx = 430979;


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
   unsigned char  *sqhstv[48];
   unsigned long  sqhstl[48];
            int   sqhsts[48];
            short *sqindv[48];
            int   sqinds[48];
   unsigned long  sqharm[48];
   unsigned long  *sqharc[48];
   unsigned short  sqadto[48];
   unsigned short  sqtdso[48];
} sqlstm = {12,48};

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

 static const char *sq0017 = 
"select NOM_PARAMETRO ,COD_MODULO ,COD_PRODUCTO ,VAL_PARAMETRO  from GED_PARA\
METROS where COD_MODULO=:b0           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,66,0,4,79,0,0,5,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,97,0,0,
40,0,0,2,48,0,4,117,0,0,2,1,0,1,0,1,5,0,0,2,5,0,0,
63,0,0,3,50,0,4,143,0,0,1,0,0,1,0,2,3,0,0,
82,0,0,4,683,0,4,242,0,0,31,3,0,1,0,1,5,0,0,1,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
221,0,0,5,665,0,4,431,0,0,29,3,0,1,0,1,5,0,0,1,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,
5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
352,0,0,6,139,0,4,548,0,0,4,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
383,0,0,7,134,0,4,597,0,0,5,1,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,1,3,0,0,
418,0,0,8,78,0,5,643,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
441,0,0,9,631,0,4,714,0,0,34,14,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,2,5,0,0,2,3,0,
0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,1,3,0,0,
592,0,0,10,743,0,4,967,0,0,39,1,0,1,0,1,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,
3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
763,0,0,11,528,0,4,1094,0,0,23,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
870,0,0,12,85,0,4,1203,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
893,0,0,13,85,0,4,1224,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
916,0,0,14,85,0,4,1244,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
939,0,0,15,85,0,4,1280,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
962,0,0,16,85,0,4,1299,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
985,0,0,17,114,0,9,1342,0,0,1,1,0,1,0,1,5,0,0,
1004,0,0,17,0,0,13,1352,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
1035,0,0,17,0,0,15,1381,0,0,0,0,0,1,0,
1050,0,0,18,95,0,4,1409,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
1073,0,0,19,95,0,4,1446,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
1096,0,0,20,73,0,4,1485,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
1119,0,0,21,200,0,4,1686,0,0,9,8,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1170,0,0,22,0,0,17,1722,0,0,1,1,0,1,0,1,97,0,0,
1189,0,0,22,0,0,45,1744,0,0,0,0,0,1,0,
1204,0,0,22,0,0,13,1754,0,0,1,0,0,1,0,2,3,0,0,
1223,0,0,22,0,0,15,1764,0,0,0,0,0,1,0,
1238,0,0,23,425,0,4,2003,0,0,12,4,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,
0,2,5,0,0,2,3,0,0,2,5,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,3,0,0,
1301,0,0,24,181,0,4,2115,0,0,6,5,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,
1340,0,0,25,181,0,4,2124,0,0,6,5,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,
1379,0,0,26,40,0,1,2197,0,0,0,0,0,1,0,
1394,0,0,27,294,0,6,2206,0,0,7,7,0,1,0,1,3,0,0,1,4,0,0,1,97,0,0,2,4,0,0,2,3,0,
0,2,5,0,0,2,3,0,0,
1437,0,0,28,245,0,4,2624,0,0,7,5,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,
1480,0,0,29,140,0,4,2674,0,0,6,5,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,
1519,0,0,30,106,0,5,2754,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1542,0,0,31,127,0,5,2763,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1569,0,0,32,450,0,4,2937,0,0,17,2,0,1,0,1,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,
0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,3,0,0,1,3,0,0,
1652,0,0,33,366,0,3,3115,0,0,16,16,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,
1731,0,0,34,125,0,4,3236,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
1758,0,0,35,155,0,4,3342,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,
1785,0,0,36,49,0,4,3503,0,0,1,0,0,1,0,2,3,0,0,
1804,0,0,37,51,0,4,3508,0,0,1,0,0,1,0,2,3,0,0,
1823,0,0,38,54,0,4,3513,0,0,1,0,0,1,0,2,3,0,0,
1842,0,0,39,48,0,4,3518,0,0,1,0,0,1,0,2,3,0,0,
1861,0,0,40,51,0,4,3523,0,0,1,0,0,1,0,2,3,0,0,
1880,0,0,41,50,0,4,3528,0,0,1,0,0,1,0,2,3,0,0,
1899,0,0,42,55,0,4,3533,0,0,1,0,0,1,0,2,3,0,0,
1918,0,0,43,54,0,4,3538,0,0,1,0,0,1,0,2,3,0,0,
1937,0,0,44,48,0,4,3543,0,0,1,0,0,1,0,2,3,0,0,
1956,0,0,45,178,0,4,3922,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
1983,0,0,46,158,0,4,3944,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
2010,0,0,47,923,0,3,4194,0,0,45,45,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,
2205,0,0,48,128,0,4,4340,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2228,0,0,49,130,0,4,4349,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2251,0,0,50,132,0,4,4358,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2274,0,0,51,130,0,4,4367,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2297,0,0,52,286,0,4,4416,0,0,7,1,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,1,3,0,0,
2340,0,0,53,153,0,4,4595,0,0,5,3,0,1,0,2,4,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
2375,0,0,54,142,0,4,4652,0,0,4,3,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2406,0,0,55,134,0,4,4709,0,0,4,3,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
2437,0,0,56,147,0,4,4786,0,0,6,4,0,1,0,2,3,0,0,2,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
2476,0,0,57,73,0,4,4943,0,0,1,0,0,1,0,2,3,0,0,
2495,0,0,58,1462,0,4,4959,0,0,48,17,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,
0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
2702,0,0,59,1536,0,4,5041,0,0,47,16,0,1,0,1,5,0,0,1,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,1,3,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,3,0,0,
2905,0,0,60,321,0,4,5315,0,0,9,2,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
2956,0,0,61,184,0,4,5604,0,0,8,2,0,1,0,1,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,1,3,0,0,
3003,0,0,62,185,0,4,5618,0,0,8,2,0,1,0,1,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,1,3,0,0,
3050,0,0,63,125,0,4,5631,0,0,7,1,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,1,3,0,0,
3093,0,0,64,158,0,4,5651,0,0,7,2,0,1,0,1,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,1,3,0,0,
3136,0,0,65,0,0,17,5747,0,0,1,1,0,1,0,1,9,0,0,
3155,0,0,65,0,0,45,5761,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
3178,0,0,65,0,0,13,5771,0,0,8,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,3,0,0,2,5,0,0,
3225,0,0,65,0,0,13,5783,0,0,6,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,
3264,0,0,65,0,0,15,5829,0,0,0,0,0,1,0,
3279,0,0,66,154,0,4,5857,0,0,4,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
3310,0,0,67,0,0,17,5937,0,0,1,1,0,1,0,1,97,0,0,
3329,0,0,67,0,0,21,5944,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
3364,0,0,68,160,0,5,5954,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,
3399,0,0,69,636,0,4,6037,0,0,37,17,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,1,3,0,0,1,3,0,0,
3562,0,0,70,253,0,4,6098,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
3597,0,0,71,138,0,4,6177,0,0,6,5,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
2,5,0,0,
3636,0,0,72,63,0,4,6300,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
3659,0,0,73,69,0,4,6433,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
3682,0,0,74,301,0,4,6502,0,0,5,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,0,
};


/*****************************************************************************/
/* Fichero:      GenFa.pc                                                    */
/* Descripcion:  Funciones generales del Modulo de Facturacion.              */
/* Fecha:        30/01/96                                                    */
/* Autor:        Javier Garcia Paredes                                       */

/******************************************************************************/
/*****************************************************************************/
/*  -PGonzaleg 26-02-2002                                                    */
/*      Modificacion referente al cambio en el tipo de dato                  */
/*      del campo NumUnidades.   int ---> long                               */
/*****************************************************************************/
/*  -PGonzaleg 14-03-2002                                                    */
/*      Incorporacion del campo szhCodIdioma para el                         */
/*      manejo de multi idiomas                                              */
/*****************************************************************************/
/*  -PGonzaleg 8-04-2002                                                     */
/*      Incorporacion de una nueva funcion (bfnGetDir_Formato) para          */
/*      el manejo del formato de direcciones ademas de la funcion            */
/*      fnQuitaBlancos para la eliminacion de caracteres blancos             */
/*****************************************************************************/
/*  -PGonzaleg 1-08-2002                                                     */
/*      Modificacion del largo del los campos "Codigo de Banco"              */
/*****************************************************************************/
#define _GENFA_PC_

#include <GenFA.h>

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


/*****************************************************************************/
/* Se quitan los blancos de la derecha                                       */
/*****************************************************************************/

char * fnQuitaBlancos(char s[])
{
        int i,indice=0;

        for (i=0;i<strlen(s) && s[i]!='\0';i++)
        {
                if (s[i] != ' ')
                        indice = i;
        }
        s[indice+1] = '\0';
        return s;
}/************************* Final  alm_trim **********************************/

/* ------------------------------------------------------------------------------------ */
/*   bfnGetDir_Formato (char*)                                                      */
/*      Valor Entrada (P/E): "4:PALACIO ;5:RIESCO::4005;6:.;3:;2:13339;1:1312;0:131;"   */
/*      Valor Retorno:(P/E): "PALACIO ;RIESCO 4005;.;;13339;1312;131;"              */
/*      Llamada            : strcpy(prueba, (char *)bfnGetDir_Formato(2003,1,1,2)); */
/* ------------------------------------------------------------------------------------ */
BOOL bfnGetDir_Formato (long  lCodCliente, int iCodTipSujeto, int iCodTipDireccion, int iCodDisplay, char * Imprime)
{
    char    modulo[20];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodCliente;       /* Cod Cliente */
        int     ihCodTipSujeto;     /* Tipo del sujeto (cliente o usuario) En erste caso = 1 */
        int     ihCodTipDireccion;  /* Tipo de direccion - de Facturacion, de Correspondencia, de ...*/
        int     ihCodDisplay;       /* 1 o 2   En este caso = 2*/
        char    szhRetorno[250];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  ( modulo , "\n\t\t* -----------------------------------------------"
                            "\n\t\t* bfnGetDir_Formato  "
                            "\n\t\t* Cliente         :  [%d]"
                            "\n\t\t* Tip sujeto      :  [%d]"
                            "\n\t\t* Tip direccion   :  [%d]"
                            "\n\t\t* Cod Display     :  [%d]"
                            ,LOG05,lCodCliente,iCodTipSujeto,iCodTipDireccion,iCodDisplay);

    lhCodCliente = lCodCliente;
    ihCodTipSujeto = iCodTipSujeto;
    ihCodTipDireccion = iCodTipDireccion;
    ihCodDisplay = iCodDisplay;

    /* EXEC SQL SELECT GE_FN_OBTIENE_DIRCLIE (:lhCodCliente,:ihCodTipSujeto,:ihCodTipDireccion,:ihCodDisplay)
         INTO :szhRetorno
         FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select GE_FN_OBTIENE_DIRCLIE(:b0,:b1,:b2,:b3) into :b4  f\
rom DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipSujeto;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhRetorno;
    sqlstm.sqhstl[4] = (unsigned long )250;
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




    vDTrazasLog  ( modulo , "\n\t\t* Retorno Query  :  [%d]\n",LOG05,sqlca.sqlcode);

    if (SQLCODE)
    {
        vDTrazasLog  ( modulo , "\n\t\t* Error Query    :  [%d]\n",LOG03,sqlca.sqlcode);
        fprintf ( stderr, "Error al ejecutar Procedimiento almacenado [%d]\n", sqlca.sqlcode);
        strcpy(Imprime, "\0");
        return (FALSE);
    }
    else
    {
     	strcpy(Imprime,szhRetorno);
    }

	return TRUE;
}/************************* Final  bfnGetDir_Formato********************************/


/* -------------------------------------------------------------------------- */
/*   bGetSysDate (char*)                                                      */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetSysDate (char* szFecSysDate)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char* pszhFecSysDate; /* EXEC SQL VAR pszhFecSysDate IS STRING (15); */ 

    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


    pszhFecSysDate = szFecSysDate;
    sprintf (szhFmtFecha, "yyyymmddhh24miss");

  /* EXEC SQL SELECT TO_CHAR(SYSDATE,:szhFmtFecha)
           INTO :pszhFecSysDate
           FROM DUAL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select TO_CHAR(SYSDATE,:b0) into :b1  from DUAL ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )40;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
  sqlstm.sqhstl[0] = (unsigned long )17;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)pszhFecSysDate;
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
  {
     iDError(szExeName,ERR000,vInsertarIncidencia,
             "SysDate-Dual",szfnORAerror());
     return FALSE;
  }
  return TRUE;
}/************************* Final bGetSysDate ********************************/

/* -------------------------------------------------------------------------- */
/*   bGetNumProceso (long*)                                                   */
/*      Devuelve en iNumPresupuesto el numero de presupuesto tomado           */
/*      de la secuencia FA_NUMPRESUPUESTO                                     */
/*      Valores retorno: FALSE  Error Oracle                                  */
/*                       TRUE   Ningun error                                  */
/* -------------------------------------------------------------------------- */
BOOL bGetNumProceso (long* lNumProceso)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

       static long lhNumProceso;
  /* EXEC SQL END DECLARE SECTION; */ 



  /* EXEC SQL SELECT FA_SEQ_NUMPRO.NEXTVAL INTO :lhNumProceso
          FROM DUAL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select FA_SEQ_NUMPRO.nextval  into :b0  from DUAL ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )63;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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


  if (SQLCODE)
  {
     iDError (szExeName,ERR000,vInsertarIncidencia,
          "Secuencia->Fa_Seq_NumPro",szfnORAerror());
     return FALSE;
  }
  vDTrazasLog (szExeName,"\n\t\t* Valor de numero de proceso......[%ld]",
           LOG06,lhNumProceso);
  *lNumProceso = lhNumProceso;
  return TRUE;
}/************************** Final bGetNumProceso ****************************/


/*****************************************************************************/
/*                         funcion : bGetVenta                               */
/* -Funcion que recupera un reg. de la table Ga_Ventas con lNumVenta         */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bGetVenta (VENTAS *pVenta)
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

 static char* szhRowid           ;/* EXEC SQL VAR szhRowid          IS STRING(19); */ 

 static long  lhNumVenta         ;
 static short shCodProducto      ;
 static char* szhCodOficina      ;/* EXEC SQL VAR szhCodOficina     IS STRING(3) ; */ 

 static long  lhCodVendedor      ;
 static long  lhCodVendedorAgente;
 static int   ihNumUnidades      ;
 static char* szhFecVenta        ;/* EXEC SQL VAR szhFecVenta       IS STRING(15); */ 

 static char* szhCodRegion       ;/* EXEC SQL VAR szhCodRegion      IS STRING(4) ; */ 

 static char* szhCodProvincia    ;/* EXEC SQL VAR szhCodProvincia   IS STRING(6) ; */ 

 static char* szhCodCiudad       ;/* EXEC SQL VAR szhCodCiudad      IS STRING(6) ; */ 

 static char* szhIndEstVenta     ;/* EXEC SQL VAR szhIndEstVenta    IS STRING(2) ; */ 

 static char* szhCodTipContrato  ;/* EXEC SQL VAR szhCodTipContrato IS STRING(4) ; */ 

 static short shIndTipVenta      ;
 static long  lhCodCliente       ;
 static int   ihCodModVenta      ;
 static int   ihTipValor         ;
 static long  lhNumTransaccion   ;
 static char* szhCodCuota        ;/* EXEC SQL VAR szhCodCuota       IS STRING(3) ; */ 

 static char* szhCodTipTarjeta   ;/* EXEC SQL VAR szhCodTipTarjeta  IS STRING(4) ; */ 

 static char* szhNumTarjeta      ;/* EXEC SQL VAR szhNumTarjeta     IS STRING(19); */ 

 static char* szhCodAutTarj      ;/* EXEC SQL VAR szhCodAutTarj     IS STRING(21); */ 

 static char* szhFecVenciTarj    ;/* EXEC SQL VAR szhFecVenciTarj   IS STRING(15); */ 


 static char* szhCodBancoTarj    ;/* EXEC SQL VAR szhCodBancoTarj   IS STRING(16) ; */ 


 static char* szhNumCtaCorr      ;/* EXEC SQL VAR szhNumCtaCorr     IS STRING(19); */ 

 static char* szhNumCheque       ;/* EXEC SQL VAR szhNumCheque      IS STRING(21); */ 


 static char* szhCodBanco        ;/* EXEC SQL VAR szhCodBanco       IS STRING(16) ; */ 


 static char* szhCodSucursal     ;/* EXEC SQL VAR szhCodSucursal    IS STRING(5) ; */ 

 static short i_shCodTipContrato ;
 static short i_shIndTipVenta    ;
 static short i_shCodCliente     ;
 static short i_shCodModVenta    ;
 static short i_shTipValor       ;
 static short i_shCodCuota       ;
 static short i_shCodTipTarjeta  ;
 static short i_shCodAutTarj     ;
 static short i_shNumTarjeta     ;
 static short i_shFecVenciTarj   ;
 static short i_shCodBancoTarj   ;
 static short i_shNumCtaCorr     ;
 static short i_shNumCheque      ;
 static short i_shCodBanco       ;
 static short i_shCodSucursal    ;

    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

 /* EXEC SQL END DECLARE SECTION    ; */ 


 lhNumVenta       = pVenta->lNumVenta       ;
 szhRowid         = pVenta->szRowid         ;
 szhCodOficina    = pVenta->szCodOficina    ;
 szhFecVenta      = pVenta->szFecVenta      ;
 szhCodRegion     = pVenta->szCodRegion     ;
 szhCodProvincia  = pVenta->szCodProvincia  ;
 szhCodCiudad     = pVenta->szCodCiudad     ;
 szhIndEstVenta   = pVenta->szIndEstVenta   ;
 szhCodTipContrato= pVenta->szCodTipContrato;
 szhCodCuota      = pVenta->szCodCuota      ;
 szhCodTipTarjeta = pVenta->szCodTipTarjeta ;
 szhNumTarjeta    = pVenta->szNumTarjeta    ;
 szhCodAutTarj    = pVenta->szCodAutTarj    ;
 szhFecVenciTarj  = pVenta->szFecVenciTarj  ;
 szhCodBancoTarj  = pVenta->szCodBancoTarj  ;
 szhNumCtaCorr    = pVenta->szNumCtaCorr    ;
 szhNumCheque     = pVenta->szNumCheque     ;
 szhCodBanco      = pVenta->szCodBanco      ;
 szhCodSucursal   = pVenta->szCodSucursal   ;

 vDTrazasLog (szExeName,"\n\t\t* Parametro Ga_Ventas\n"
                        "\t\t* NumVenta [%ld]\n",LOG05,lhNumVenta);

    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

 /* EXEC SQL SELECT /o+ index (GA_VENTAS PK_GA_VENTAS) o/
                 ROWID                                     ,
                 NUM_VENTA                                 ,
                 NUM_TRANSACCION                           ,
                 COD_PRODUCTO                              ,
                 COD_OFICINA                               ,
                 COD_VENDEDOR                              ,
                 COD_VENDEDOR_AGENTE                       ,
                 NUM_UNIDADES                              ,
                 TO_CHAR (FEC_VENTA,:szhFmtFecha)    ,
                 COD_REGION                                ,
                 COD_PROVINCIA                             ,
                 COD_CIUDAD                                ,
                 IND_ESTVENTA                              ,
                 COD_TIPCONTRATO                           ,
                 IND_TIPVENTA                              ,
                 COD_CLIENTE                               ,
                 COD_MODVENTA                              ,
                 TIP_VALOR                                 ,
                 COD_CUOTA                                 ,
                 COD_TIPTARJETA                            ,
                 NUM_TARJETA                               ,
                 COD_AUTTARJ                               ,
                 TO_CHAR (FEC_VENCITARJ,:szhFmtFecha),
                 COD_BANCOTARJ                             ,
                 NUM_CTACORR                               ,
                 NUM_CHEQUE                                ,
                 COD_BANCO                                 ,
                 COD_SUCURSAL
           INTO  :szhRowid                                 ,
                 :lhNumVenta                               ,
                 :lhNumTransaccion                         ,
                 :shCodProducto                            ,
                 :szhCodOficina                            ,
                 :lhCodVendedor                            ,
                 :lhCodVendedorAgente                      ,
                 :ihNumUnidades                            ,
                 :szhFecVenta                              ,
                 :szhCodRegion                             ,
                 :szhCodProvincia                          ,
                 :szhCodCiudad                             ,
                 :szhIndEstVenta                           ,
                 :szhCodTipContrato:i_shCodTipContrato     ,
                 :shIndTipVenta:i_shIndTipVenta            ,
                 :lhCodCliente:i_shCodCliente              ,
                 :ihCodModVenta:i_shCodModVenta            ,
                 :ihTipValor:i_shTipValor                  ,
                 :szhCodCuota:i_shCodCuota                 ,
                 :szhCodTipTarjeta:i_shCodTipTarjeta       ,
                 :szhNumTarjeta:i_shNumTarjeta             ,
                 :szhCodAutTarj:i_shCodAutTarj             ,
                 :szhFecVenciTarj:i_shFecVenciTarj         ,
                 :szhCodBancoTarj:i_shCodBancoTarj         ,
                 :szhNumCtaCorr:i_shNumCtaCorr             ,
                 :szhNumCheque:i_shNumCheque               ,
                 :szhCodBanco:i_shCodBanco                 ,
                 :szhCodSucursal:i_shCodSucursal
           FROM  GA_VENTAS
           WHERE NUM_VENTA = :lhNumVenta; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (GA_VENTAS PK_GA_VENTAS)  +*/ ROWID ,NUM_\
VENTA ,NUM_TRANSACCION ,COD_PRODUCTO ,COD_OFICINA ,COD_VENDEDOR ,COD_VENDEDOR_\
AGENTE ,NUM_UNIDADES ,TO_CHAR(FEC_VENTA,:b0) ,COD_REGION ,COD_PROVINCIA ,COD_C\
IUDAD ,IND_ESTVENTA ,COD_TIPCONTRATO ,IND_TIPVENTA ,COD_CLIENTE ,COD_MODVENTA \
,TIP_VALOR ,COD_CUOTA ,COD_TIPTARJETA ,NUM_TARJETA ,COD_AUTTARJ ,TO_CHAR(FEC_V\
ENCITARJ,:b0) ,COD_BANCOTARJ ,NUM_CTACORR ,NUM_CHEQUE ,COD_BANCO ,COD_SUCURSAL\
 into :b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15:b16,:b17:b\
18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28,:b29:b30,:b31:b32,:b33:b34,:b3\
5:b36,:b37:b38,:b39:b40,:b41:b42,:b43:b44  from GA_VENTAS where NUM_VENTA=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )82;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[2] = (unsigned long )19;
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
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumTransaccion;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[6] = (unsigned char  *)szhCodOficina;
 sqlstm.sqhstl[6] = (unsigned long )3;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&lhCodVendedor;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhCodVendedorAgente;
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
 sqlstm.sqhstv[10] = (unsigned char  *)szhFecVenta;
 sqlstm.sqhstl[10] = (unsigned long )15;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhCodRegion;
 sqlstm.sqhstl[11] = (unsigned long )4;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhCodProvincia;
 sqlstm.sqhstl[12] = (unsigned long )6;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhCodCiudad;
 sqlstm.sqhstl[13] = (unsigned long )6;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhIndEstVenta;
 sqlstm.sqhstl[14] = (unsigned long )2;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhCodTipContrato;
 sqlstm.sqhstl[15] = (unsigned long )4;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)&i_shCodTipContrato;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&shIndTipVenta;
 sqlstm.sqhstl[16] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)&i_shIndTipVenta;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)&i_shCodCliente;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&ihCodModVenta;
 sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)&i_shCodModVenta;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)&ihTipValor;
 sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)&i_shTipValor;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)szhCodCuota;
 sqlstm.sqhstl[20] = (unsigned long )3;
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)&i_shCodCuota;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)szhCodTipTarjeta;
 sqlstm.sqhstl[21] = (unsigned long )4;
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)&i_shCodTipTarjeta;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)szhNumTarjeta;
 sqlstm.sqhstl[22] = (unsigned long )19;
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)&i_shNumTarjeta;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)szhCodAutTarj;
 sqlstm.sqhstl[23] = (unsigned long )21;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)&i_shCodAutTarj;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)szhFecVenciTarj;
 sqlstm.sqhstl[24] = (unsigned long )15;
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)&i_shFecVenciTarj;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)szhCodBancoTarj;
 sqlstm.sqhstl[25] = (unsigned long )16;
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)&i_shCodBancoTarj;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)szhNumCtaCorr;
 sqlstm.sqhstl[26] = (unsigned long )19;
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)&i_shNumCtaCorr;
 sqlstm.sqinds[26] = (         int  )0;
 sqlstm.sqharm[26] = (unsigned long )0;
 sqlstm.sqadto[26] = (unsigned short )0;
 sqlstm.sqtdso[26] = (unsigned short )0;
 sqlstm.sqhstv[27] = (unsigned char  *)szhNumCheque;
 sqlstm.sqhstl[27] = (unsigned long )21;
 sqlstm.sqhsts[27] = (         int  )0;
 sqlstm.sqindv[27] = (         short *)&i_shNumCheque;
 sqlstm.sqinds[27] = (         int  )0;
 sqlstm.sqharm[27] = (unsigned long )0;
 sqlstm.sqadto[27] = (unsigned short )0;
 sqlstm.sqtdso[27] = (unsigned short )0;
 sqlstm.sqhstv[28] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[28] = (unsigned long )16;
 sqlstm.sqhsts[28] = (         int  )0;
 sqlstm.sqindv[28] = (         short *)&i_shCodBanco;
 sqlstm.sqinds[28] = (         int  )0;
 sqlstm.sqharm[28] = (unsigned long )0;
 sqlstm.sqadto[28] = (unsigned short )0;
 sqlstm.sqtdso[28] = (unsigned short )0;
 sqlstm.sqhstv[29] = (unsigned char  *)szhCodSucursal;
 sqlstm.sqhstl[29] = (unsigned long )5;
 sqlstm.sqhsts[29] = (         int  )0;
 sqlstm.sqindv[29] = (         short *)&i_shCodSucursal;
 sqlstm.sqinds[29] = (         int  )0;
 sqlstm.sqharm[29] = (unsigned long )0;
 sqlstm.sqadto[29] = (unsigned short )0;
 sqlstm.sqtdso[29] = (unsigned short )0;
 sqlstm.sqhstv[30] = (unsigned char  *)&lhNumVenta;
 sqlstm.sqhstl[30] = (unsigned long )sizeof(long);
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


    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_Ventas",
                 szfnORAerror());

    if (SQLCODE == 0)
    {
        pVenta->lNumVenta         = lhNumVenta         ;
        pVenta->lNumTransaccion   = lhNumTransaccion   ;
        pVenta->iCodProducto      = shCodProducto      ;
        pVenta->lCodVendedor      = lhCodVendedor      ;
        pVenta->lCodVendedorAgente= lhCodVendedorAgente;
        pVenta->iNumUnidades      = ihNumUnidades      ;
        if (i_shCodTipContrato == ORA_NULL)
            pVenta->szCodTipContrato[0] = 0;
        pVenta->iIndTipVenta = (i_shIndTipVenta == ORA_NULL)?-1:shIndTipVenta;
        pVenta->lCodCliente  = (i_shCodCliente  == ORA_NULL)?-1:lhCodCliente ;
        pVenta->iCodModVenta = (i_shCodModVenta == ORA_NULL)?-1:ihCodModVenta;
        pVenta->iTipValor    = (i_shTipValor    == ORA_NULL)?-1:ihTipValor   ;
        if (i_shCodCuota == ORA_NULL)
            pVenta->szCodCuota[0] = 0;
        if (i_shCodTipTarjeta== ORA_NULL)
            pVenta->szCodTipTarjeta[0] = 0;
        if (i_shNumTarjeta == ORA_NULL)
            pVenta->szNumTarjeta[0] = 0;
        if (i_shCodAutTarj == ORA_NULL)
            pVenta->szCodAutTarj[0] = 0;
        if (i_shFecVenciTarj== ORA_NULL)
            pVenta->szFecVenciTarj[0] = 0;
        if (i_shCodBancoTarj == ORA_NULL)
            pVenta->szCodBancoTarj[0] = 0;
        if (i_shNumCtaCorr == ORA_NULL)
            pVenta->szNumCtaCorr[0] = 0;
        if (i_shNumCheque == ORA_NULL)
            pVenta->szNumCheque[0] = 0;
        if (i_shCodBanco == ORA_NULL)
            pVenta->szCodBanco[0] = 0;
        if (i_shCodSucursal == ORA_NULL)
            pVenta->szCodSucursal[0] = 0;

    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/************************* Final vGetVenta **********************************/


/*****************************************************************************/
/*                         funcion : bGetTransContado                        */
/* -Funcion que recupera un reg. de la table Ga_TransContado con lNumTrans   */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bGetTransContado (TRANSCONTADO *pTranC)
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

 static char*  szhRowid           ;/* EXEC SQL VAR szhRowid          IS STRING(19); */ 

 static long   lhNumTransaccion   ;
 static long   lhCodVendedorAgente;
 static short  shCodProducto      ;
 static char*  szhCodOficina      ;/* EXEC SQL VAR szhCodOficina     IS STRING(3) ; */ 

 static int    ihNumUnidades      ;
 static char*  szhFecTransaccion  ;/* EXEC SQL VAR szhFecTransaccion IS STRING(15); */ 

 static char*  szhCodRegion       ;/* EXEC SQL VAR szhCodRegion      IS STRING(4) ; */ 

 static char*  szhCodProvincia    ;/* EXEC SQL VAR szhCodProvincia   IS STRING(6) ; */ 

 static char*  szhCodCiudad       ;/* EXEC SQL VAR szhCodCiudad      IS STRING(6) ; */ 

 static double dhImpVenta         ;
 static char*  szhCodMoneda       ;/* EXEC SQL VAR szhCodMoneda      IS STRING(4) ; */ 

 static short  shIndPasoCob       ;
 static char*  szhNomUsuarOra     ;/* EXEC SQL VAR szhNomUsuarOra    IS STRING(31); */ 

 static long   lhCodCliente       ;
 static int    ihTipValor         ;
 static char*  szhCodCuota        ;/* EXEC SQL VAR szhCodCuota       IS STRING(3) ; */ 

 static char*  szhCodTipTarjeta   ;/* EXEC SQL VAR szhCodTipTarjeta  IS STRING(4) ; */ 

 static char*  szhNumTarjeta      ;/* EXEC SQL VAR szhNumTarjeta     IS STRING(19); */ 

 static char*  szhCodAutTarj      ;/* EXEC SQL VAR szhCodAutTarj     IS STRING(21); */ 

 static char*  szhFecVenciTarj    ;/* EXEC SQL VAR szhFecVenciTarj   IS STRING(15); */ 


 /* Desde Aqui. Modificacion Incorporada por PGonzaleg 1-08-2002    */
 /*static char*  szhCodBancoTarj    ;EXEC SQL VAR szhCodBancoTarj   IS STRING(4) ;*/
 static char*  szhCodBancoTarj    ;/* EXEC SQL VAR szhCodBancoTarj   IS STRING(16) ; */ 

 /* Hasta Aqui. Modificacion Incorporada por PGonzaleg 1-08-2002    */

 static char*  szhNumCtaCorr      ;/* EXEC SQL VAR szhNumCtaCorr     IS STRING(19); */ 

 static char*  szhNumCheque       ;/* EXEC SQL VAR szhNumCheque      IS STRING(21); */ 


 /* Desde Aqui. Modificacion Incorporada por PGonzaleg 1-08-2002    */
 /*static char*  szhCodBanco        ;EXEC SQL VAR szhCodBanco       IS STRING(4) ;*/
 static char*  szhCodBanco        ;/* EXEC SQL VAR szhCodBanco       IS STRING(16) ; */ 

 /* Hasta Aqui. Modificacion Incorporada por PGonzaleg 1-08-2002    */

 static char*  szhCodSucursal     ;/* EXEC SQL VAR szhCodSucursal    IS STRING(5) ; */ 

 static short  i_shCodCliente     ;
 static short  i_shTipValor       ;
 static short  i_shCodCuota       ;
 static short  i_shCodTipTarjeta  ;
 static short  i_shCodAutTarj     ;
 static short  i_shNumTarjeta     ;
 static short  i_shFecVenciTarj   ;
 static short  i_shCodBancoTarj   ;
 static short  i_shNumCtaCorr     ;
 static short  i_shNumCheque      ;
 static short  i_shCodBanco       ;
 static short  i_shCodSucursal    ;
 static short  i_shImpVenta       ;
 static short  i_shCodMoneda      ;
    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 


 /* EXEC SQL END DECLARE SECTION    ; */ 


 lhNumTransaccion = pTranC->lNumTransaccion ;
 szhRowid         = pTranC->szRowid         ;
 szhCodOficina    = pTranC->szCodOficina    ;
 szhFecTransaccion= pTranC->szFecTransaccion;
 szhCodRegion     = pTranC->szCodRegion     ;
 szhCodProvincia  = pTranC->szCodProvincia  ;
 szhCodCiudad     = pTranC->szCodCiudad     ;
 szhCodCuota      = pTranC->szCodCuota      ;
 szhCodTipTarjeta = pTranC->szCodTipTarjeta ;
 szhNumTarjeta    = pTranC->szNumTarjeta    ;
 szhCodAutTarj    = pTranC->szCodAutTarj    ;
 szhFecVenciTarj  = pTranC->szFecVenciTarj  ;
 szhCodBancoTarj  = pTranC->szCodBancoTarj  ;
 szhNumCtaCorr    = pTranC->szNumCtaCorr    ;
 szhNumCheque     = pTranC->szNumCheque     ;
 szhCodBanco      = pTranC->szCodBanco      ;
 szhCodSucursal   = pTranC->szCodSucursal   ;
 szhCodMoneda     = pTranC->szCodMoneda     ;

 vDTrazasLog (szExeName,"\n\t\t* Parametro Ga_TransContado\n"
                        "\t\t* NumTransaccion [%ld]\n",LOG05,lhNumTransaccion);

 sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

 /* EXEC SQL SELECT /o+ index (GA_TRANSCONTADO PK_GA_TRANSCONTADO) o/
                 ROWID                                       ,
                 NUM_TRANSACCION                             ,
                 COD_PRODUCTO                                ,
                 COD_OFICINA                                 ,
                 COD_VENDEDOR_AGENTE                         ,
                 NUM_UNIDADES                                ,
                 TO_CHAR (FEC_TRANSACCION,:szhFmtFecha),
                 COD_REGION                                  ,
                 COD_PROVINCIA                               ,
                 COD_CIUDAD                                  ,
                 IMP_VENTA                                   ,
                 COD_MONEDA                                  ,
                 IND_PASOCOB                                 ,
                 NOM_USUARORA                                ,
                 COD_CLIENTE                                 ,
                 TIP_VALOR                                   ,
                 COD_CUOTA                                   ,
                 COD_TIPTARJETA                              ,
                 NUM_TARJETA                                 ,
                 COD_AUTTARJ                                 ,
                 TO_CHAR (FEC_VENCITARJ,:szhFmtFecha)  ,
                 COD_BANCOTARJ                               ,
                 NUM_CTACORR                                 ,
                 NUM_CHEQUE                                  ,
                 COD_BANCO                                   ,
                 COD_SUCURSAL
           INTO  :szhRowid                                 ,
                 :lhNumTransaccion                         ,
                 :shCodProducto                            ,
                 :szhCodOficina                            ,
                 :lhCodVendedorAgente                      ,
                 :ihNumUnidades                            ,
                 :szhFecTransaccion                        ,
                 :szhCodRegion                             ,
                 :szhCodProvincia                          ,
                 :szhCodCiudad                             ,
                 :dhImpVenta:i_shImpVenta                  ,
                 :szhCodMoneda:i_shCodMoneda               ,
                 :shIndPasoCob                             ,
                 :szhNomUsuarOra                           ,
                 :lhCodCliente:i_shCodCliente              ,
                 :ihTipValor:i_shTipValor                  ,
                 :szhCodCuota:i_shCodCuota                 ,
                 :szhCodTipTarjeta:i_shCodTipTarjeta       ,
                 :szhNumTarjeta:i_shNumTarjeta             ,
                 :szhCodAutTarj:i_shCodAutTarj             ,
                 :szhFecVenciTarj:i_shFecVenciTarj         ,
                 :szhCodBancoTarj:i_shCodBancoTarj         ,
                 :szhNumCtaCorr:i_shNumCtaCorr             ,
                 :szhNumCheque:i_shNumCheque               ,
                 :szhCodBanco:i_shCodBanco                 ,
                 :szhCodSucursal:i_shCodSucursal
           FROM  GA_TRANSCONTADO
           WHERE NUM_TRANSACCION = :lhNumTransaccion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (GA_TRANSCONTADO PK_GA_TRANSCONTADO)  +*/\
 ROWID ,NUM_TRANSACCION ,COD_PRODUCTO ,COD_OFICINA ,COD_VENDEDOR_AGENTE ,NUM_U\
NIDADES ,TO_CHAR(FEC_TRANSACCION,:b0) ,COD_REGION ,COD_PROVINCIA ,COD_CIUDAD ,\
IMP_VENTA ,COD_MONEDA ,IND_PASOCOB ,NOM_USUARORA ,COD_CLIENTE ,TIP_VALOR ,COD_\
CUOTA ,COD_TIPTARJETA ,NUM_TARJETA ,COD_AUTTARJ ,TO_CHAR(FEC_VENCITARJ,:b0) ,C\
OD_BANCOTARJ ,NUM_CTACORR ,NUM_CHEQUE ,COD_BANCO ,COD_SUCURSAL into :b2,:b3,:b\
4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12:b13,:b14:b15,:b16,:b17,:b18:b19,:b20:b21,\
:b22:b23,:b24:b25,:b26:b27,:b28:b29,:b30:b31,:b32:b33,:b34:b35,:b36:b37,:b38:b\
39,:b40:b41  from GA_TRANSCONTADO where NUM_TRANSACCION=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )221;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[2] = (unsigned long )19;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhNumTransaccion;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&shCodProducto;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodOficina;
 sqlstm.sqhstl[5] = (unsigned long )3;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhCodVendedorAgente;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihNumUnidades;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhFecTransaccion;
 sqlstm.sqhstl[8] = (unsigned long )15;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhCodRegion;
 sqlstm.sqhstl[9] = (unsigned long )4;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhCodProvincia;
 sqlstm.sqhstl[10] = (unsigned long )6;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhCodCiudad;
 sqlstm.sqhstl[11] = (unsigned long )6;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&dhImpVenta;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)&i_shImpVenta;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhCodMoneda;
 sqlstm.sqhstl[13] = (unsigned long )4;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)&i_shCodMoneda;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&shIndPasoCob;
 sqlstm.sqhstl[14] = (unsigned long )sizeof(short);
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhNomUsuarOra;
 sqlstm.sqhstl[15] = (unsigned long )31;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)&i_shCodCliente;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&ihTipValor;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)&i_shTipValor;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)szhCodCuota;
 sqlstm.sqhstl[18] = (unsigned long )3;
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)&i_shCodCuota;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)szhCodTipTarjeta;
 sqlstm.sqhstl[19] = (unsigned long )4;
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)&i_shCodTipTarjeta;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)szhNumTarjeta;
 sqlstm.sqhstl[20] = (unsigned long )19;
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)&i_shNumTarjeta;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)szhCodAutTarj;
 sqlstm.sqhstl[21] = (unsigned long )21;
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)&i_shCodAutTarj;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)szhFecVenciTarj;
 sqlstm.sqhstl[22] = (unsigned long )15;
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)&i_shFecVenciTarj;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)szhCodBancoTarj;
 sqlstm.sqhstl[23] = (unsigned long )16;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)&i_shCodBancoTarj;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)szhNumCtaCorr;
 sqlstm.sqhstl[24] = (unsigned long )19;
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)&i_shNumCtaCorr;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)szhNumCheque;
 sqlstm.sqhstl[25] = (unsigned long )21;
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)&i_shNumCheque;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[26] = (unsigned long )16;
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)&i_shCodBanco;
 sqlstm.sqinds[26] = (         int  )0;
 sqlstm.sqharm[26] = (unsigned long )0;
 sqlstm.sqadto[26] = (unsigned short )0;
 sqlstm.sqtdso[26] = (unsigned short )0;
 sqlstm.sqhstv[27] = (unsigned char  *)szhCodSucursal;
 sqlstm.sqhstl[27] = (unsigned long )5;
 sqlstm.sqhsts[27] = (         int  )0;
 sqlstm.sqindv[27] = (         short *)&i_shCodSucursal;
 sqlstm.sqinds[27] = (         int  )0;
 sqlstm.sqharm[27] = (unsigned long )0;
 sqlstm.sqadto[27] = (unsigned short )0;
 sqlstm.sqtdso[27] = (unsigned short )0;
 sqlstm.sqhstv[28] = (unsigned char  *)&lhNumTransaccion;
 sqlstm.sqhstl[28] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[28] = (         int  )0;
 sqlstm.sqindv[28] = (         short *)0;
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


    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_TransContado",
                 szfnORAerror());

    if (SQLCODE == 0)
    {
        pTranC->iCodProducto      = shCodProducto      ;
        pTranC->lCodVendedorAgente= lhCodVendedorAgente;
        pTranC->iNumUnidades      = ihNumUnidades      ;
        pTranC->lCodCliente  = (i_shCodCliente  == ORA_NULL)?-1:lhCodCliente ;
        pTranC->iTipValor    = (i_shTipValor    == ORA_NULL)?-1:ihTipValor   ;

        if (i_shCodCuota == ORA_NULL)
            pTranC->szCodCuota[0] = 0;
        if (i_shCodTipTarjeta== ORA_NULL)
            pTranC->szCodTipTarjeta[0] = 0;
        if (i_shNumTarjeta == ORA_NULL)
            pTranC->szNumTarjeta[0] = 0;
        if (i_shCodAutTarj == ORA_NULL)
            pTranC->szCodAutTarj[0] = 0;
        if (i_shFecVenciTarj== ORA_NULL)
            pTranC->szFecVenciTarj[0] = 0;
        if (i_shCodBancoTarj == ORA_NULL)
            pTranC->szCodBancoTarj[0] = 0;
        if (i_shNumCtaCorr == ORA_NULL)
            pTranC->szNumCtaCorr[0] = 0;
        if (i_shNumCheque == ORA_NULL)
            pTranC->szNumCheque[0] = 0;
        if (i_shCodBanco == ORA_NULL)
            pTranC->szCodBanco[0] = 0;
        if (i_shCodSucursal == ORA_NULL)
            pTranC->szCodSucursal[0] = 0;
        if (i_shCodMoneda   == ORA_NULL)
            pTranC->szCodMoneda[0] = 0;
        if (i_shImpVenta    == ORA_NULL)
           pTranC->dImpVenta = -1;

    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/************************* Final vGetTransContado ***************************/


/*****************************************************************************/
/*                        funcion : iGetLocalizacionVentas                   */
/* -Funcion que carga la localizacion de NumVenta (Ga_Ventas)                */
/* -Valores Retorno :Error->FALSE, !Error->TRUE                              */
/*****************************************************************************/
int iGetLocalizacionVenta (long lNumVenta, char *szCodCiudad,
                           char *szCodRegion, char *szCodProvincia)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhNumVenta     ;
  static char* szhCodCiudad   ; /* EXEC SQL VAR szhCodCiudad    IS STRING(6); */ 

  static char* szhCodRegion   ; /* EXEC SQL VAR szhCodRegion    IS STRING(4); */ 

  static char* szhCodProvincia; /* EXEC SQL VAR szhCodProvincia IS STRING(6); */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  lhNumVenta      = lNumVenta     ;
  szhCodCiudad    = szCodCiudad   ;
  szhCodRegion    = szCodRegion   ;
  szhCodProvincia = szCodProvincia;

  /* EXEC SQL SELECT /o+ index (GA_VENTAS PK_GA_VENTAS) o/
                  COD_CIUDAD,COD_REGION,COD_PROVINCIA
           INTO   :szhCodCiudad, :szhCodRegion, :szhCodProvincia
           FROM   GA_VENTAS
           WHERE  NUM_VENTA = :lhNumVenta; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (GA_VENTAS PK_GA_VENTAS)  +*/ COD_CIUDAD\
 ,COD_REGION ,COD_PROVINCIA into :b0,:b1,:b2  from GA_VENTAS where NUM_VENTA=:\
b3";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )352;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodCiudad;
  sqlstm.sqhstl[0] = (unsigned long )6;
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


  if (SQLCODE != 0)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_Ventas",
               szfnORAerror());

  return SQLCODE;
}/************************** Final iGetLocalizacionVenta *********************/

/*****************************************************************************/
/*                         funcion : iCmpCiclFact                            */
/* -Funcion de comparcion                                                    */
/*****************************************************************************/
int iCmpCiclFact (const void* cad1, const void* cad2)
{
  int rc = 0;

  if ( ((CICLO *)cad1)->lCodCiclFact < ((CICLO *)cad2)->lCodCiclFact)
         rc = -1;
  else if ( ((CICLO *)cad1)->lCodCiclFact > ((CICLO *)cad2)->lCodCiclFact)
         rc =  1;
  else if ( ((CICLO *)cad1)->lCodCiclFact ==((CICLO *)cad2)->lCodCiclFact)
         rc =  0;
  return rc;
}/************************ Final iCmpCiclFact ********************************/

/*****************************************************************************/
/*                          funcion : bfnDBGetCiclo                          */
/*****************************************************************************/
BOOL bfnDBGetCiclo (CICLO *pstCiclo)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhRowid  ; /* EXEC SQL VAR szhRowid IS STRING (19); */ 

  static int   ihCodCiclo;
  static int   ihDigC    ;
  static int   ihDigD    ;
  static int   ihDigSec  ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName, "\n\t\t* Select => Fa_Ciclo"
                          "\n\t\t=> Cod.Ciclo [%d]   ", LOG05,
                          pstCiclo->iCodCiclo);

  szhRowid   = pstCiclo->szRowidCiclo;
  ihCodCiclo = pstCiclo->iCodCiclo   ;

  /* EXEC SQL SELECT /o+ index (FA_CICLOS PK_FA_CICLOS) o/
                  ROWID  ,
                  DIG_C  ,
                  DIG_D  ,
                  DIG_SEC
             INTO :szhRowid,
                  :ihDigC  ,
                  :ihDigD  ,
                  :ihDigSec
             FROM FA_CICLOS
            WHERE COD_CICLO = :ihCodCiclo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (FA_CICLOS PK_FA_CICLOS)  +*/ ROWID ,DIG\
_C ,DIG_D ,DIG_SEC into :b0,:b1,:b2,:b3  from FA_CICLOS where COD_CICLO=:b4";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )383;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihDigC;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihDigD;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihDigSec;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
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
     iDError (szExeName,ERR000,vInsertarIncidencia,"Select=> Fa_Ciclos",
              szfnORAerror ());
     return  (FALSE)          ;
 }
 else
 {
    pstCiclo->iDigC   = ihDigC     ;
    pstCiclo->iDigD   = ihDigD     ;
    pstCiclo->iDigSec = ihDigSec +1;
 }
 return TRUE;
}/************************* Final bfnDBGetCiclo ******************************/

/*****************************************************************************/
/*                         funcion : bfnDBUpdateCiclo                        */
/* - Update de la Secuencia de Num.CTC                                       */
/*****************************************************************************/
BOOL bfnDBUpdateCiclo (char *szRowid, int iDigSec)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char szhRowid [19];/* EXEC SQL VAR szhRowid IS STRING (19); */ 

   static int  ihDigSec     ;
   /* EXEC SQL END DECLARE SECTION  ; */ 


   strcpy (szhRowid, szRowid);

   ihDigSec = iDigSec        ;

   vDTrazasLog (szExeName, "\n\t\t* Update Fa_Ciclos (Secuencia NumCTC)"
                           "\n\t\t=> Digito Secuencia : [%d]", LOG05,
                           iDigSec);

   /* EXEC SQL UPDATE /o+ Rowid (FA_CICLOS) o/
                   FA_CICLOS SET DIG_SEC = :ihDigSec
             WHERE ROWID = :szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 31;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update  /*+  Rowid (FA_CICLOS)  +*/ FA_CICLOS  set DIG_SEC\
=:b0 where ROWID=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )418;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihDigSec;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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



   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Update=> Fa_Ciclos",
                szfnORAerror ());

   return (SQLCODE)?FALSE:TRUE;
}/************************* Final bfnDBUpdateCiclo ***************************/

/*****************************************************************************/
/*                          funcion : bFindCiclFact                          */
/* -Funcion que busca en pstCiclFact un reg.                                 */
/* -Valores de Retorno : Error->FALSE, !Error->TRUE                          */
/*****************************************************************************/
BOOL bFindCiclFact (CICLO* pCiclo)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

static char* szhRowid          ;/* EXEC SQL VAR szhRowid           IS STRING(15) ; */ 

static int   ihCodCiclo        ;
static int   ihAno             ;
static long  lhCodCiclFact     ;
static char* szhFecEmision     ;/* EXEC SQL VAR szhFecEmision      IS STRING(15) ; */ 

static char* szhFecVencimie    ;/* EXEC SQL VAR szhFecVencimie     IS STRING(15) ; */ 

static char* szhFecProxVenc    ;/* EXEC SQL VAR szhFecProxVenc     IS STRING(15) ; */ 

static char* szhFecCaducida    ;/* EXEC SQL VAR szhFecCaducida     IS STRING(15) ; */ 

static char* szhFecDesdeLlan   ;/* EXEC SQL VAR szhFecDesdeLlan    IS STRING(15) ; */ 

static char* szhFecHastaLlam   ;/* EXEC SQL VAR szhFecHastaLlam    IS STRING(15) ; */ 

static char* szhFecDesdeCFijos ;/* EXEC SQL VAR szhFecDesdeCFijos  IS STRING(15) ; */ 

static char* szhFecHastaCFijos ;/* EXEC SQL VAR szhFecHastaCFijos  IS STRING(15) ; */ 

static char* szhFecDesdeOCargos;/* EXEC SQL VAR szhFecDesdeOCargos IS STRING(15) ; */ 

static char* szhFecHastaOCargos;/* EXEC SQL VAR szhFecHastaOCargos IS STRING(15) ; */ 

static char* szhFecDesdeRoa    ;/* EXEC SQL VAR szhFecDesdeRoa     IS STRING(15) ; */ 

static char* szhFecHastaRoa    ;/* EXEC SQL VAR szhFecHastaRoa     IS STRING(15) ; */ 

static char* szhFecHMenos      ;/* EXEC SQL VAR szhFecHMenos       IS STRING(15) ; */ 

static char* szhDirLogs        ;/* EXEC SQL VAR szhDirLogs         IS STRING(101); */ 

static char* szhDirSpool       ;/* EXEC SQL VAR szhDirSpool        IS STRING(101); */ 

static short shIndFacturacion  ;
static int   ihDiaPeriodo      ;
    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

/* EXEC SQL END DECLARE SECTION; */ 


  if (pCiclo->lCodCiclFact == -1)
  {
      memset (pCiclo,ORA_NULL,sizeof(CICLO));
  }
  else
  {
     vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada a Fa_CiclFact\n"
                            "\t\t=> Cod.CiclFact [%ld]\n",LOG06,
                            pCiclo->lCodCiclFact);
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
     lhCodCiclFact     = pCiclo->lCodCiclFact     ;
     sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

     /* EXEC SQL SELECT
            ROWID                                          ,
            COD_CICLO                                      ,
            ANO                                            ,
            TO_CHAR(FEC_VENCIMIE,:szhFmtFecha)             ,
            TO_CHAR(FEC_EMISION ,:szhFmtFecha)             ,
            TO_CHAR(FEC_CADUCIDA,:szhFmtFecha)             ,
            TO_CHAR(FEC_PROXVENC,:szhFmtFecha)             ,
            TO_CHAR(FEC_DESDELLAM,:szhFmtFecha)            ,
            TO_CHAR(FEC_HASTALLAM,:szhFmtFecha)            ,
            TO_CHAR(FEC_DESDECFIJOS,:szhFmtFecha)          ,
            TO_CHAR(FEC_HASTACFIJOS,:szhFmtFecha)          ,
            TO_CHAR(FEC_DESDEOCARGOS,:szhFmtFecha)         ,
            TO_CHAR(FEC_HASTAOCARGOS,:szhFmtFecha)         ,
            TO_CHAR(FEC_DESDEROA,:szhFmtFecha)             ,
            TO_CHAR(FEC_HASTAROA,:szhFmtFecha)             ,
            TO_CHAR((FEC_DESDECFIJOS-1/86400),:szhFmtFecha),
            IND_FACTURACION                                ,
            DIR_LOGS                                       ,
            DIR_SPOOL                                      ,
            DIA_PERIODO
       INTO :szhRowid                  ,
            :ihCodCiclo                ,
            :ihAno                     ,
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
            :szhDirSpool               ,
            :ihDiaPeriodo 
      FROM  FA_CICLFACT
      WHERE COD_CICLFACT    = :lhCodCiclFact
        AND IND_FACTURACION < 2; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 34;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select ROWID ,COD_CICLO ,ANO ,TO_CHAR(FEC_VENCIMIE,:b0) \
,TO_CHAR(FEC_EMISION,:b0) ,TO_CHAR(FEC_CADUCIDA,:b0) ,TO_CHAR(FEC_PROXVENC,:b0\
) ,TO_CHAR(FEC_DESDELLAM,:b0) ,TO_CHAR(FEC_HASTALLAM,:b0) ,TO_CHAR(FEC_DESDECF\
IJOS,:b0) ,TO_CHAR(FEC_HASTACFIJOS,:b0) ,TO_CHAR(FEC_DESDEOCARGOS,:b0) ,TO_CHA\
R(FEC_HASTAOCARGOS,:b0) ,TO_CHAR(FEC_DESDEROA,:b0) ,TO_CHAR(FEC_HASTAROA,:b0) \
,TO_CHAR((FEC_DESDECFIJOS-(1/86400)),:b0) ,IND_FACTURACION ,DIR_LOGS ,DIR_SPOO\
L ,DIA_PERIODO into :b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22,:b23,:b2\
4,:b25,:b26,:b27,:b28,:b29,:b30,:b31,:b32  from FA_CICLFACT where (COD_CICLFAC\
T=:b33 and IND_FACTURACION<2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )441;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
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
     sqlstm.sqhstv[4] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[4] = (unsigned long )17;
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
     sqlstm.sqhstv[6] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[6] = (unsigned long )17;
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
     sqlstm.sqhstv[8] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[8] = (unsigned long )17;
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
     sqlstm.sqhstv[10] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[10] = (unsigned long )17;
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
     sqlstm.sqhstv[12] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[12] = (unsigned long )17;
     sqlstm.sqhsts[12] = (         int  )0;
     sqlstm.sqindv[12] = (         short *)0;
     sqlstm.sqinds[12] = (         int  )0;
     sqlstm.sqharm[12] = (unsigned long )0;
     sqlstm.sqadto[12] = (unsigned short )0;
     sqlstm.sqtdso[12] = (unsigned short )0;
     sqlstm.sqhstv[13] = (unsigned char  *)szhRowid;
     sqlstm.sqhstl[13] = (unsigned long )15;
     sqlstm.sqhsts[13] = (         int  )0;
     sqlstm.sqindv[13] = (         short *)0;
     sqlstm.sqinds[13] = (         int  )0;
     sqlstm.sqharm[13] = (unsigned long )0;
     sqlstm.sqadto[13] = (unsigned short )0;
     sqlstm.sqtdso[13] = (unsigned short )0;
     sqlstm.sqhstv[14] = (unsigned char  *)&ihCodCiclo;
     sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[14] = (         int  )0;
     sqlstm.sqindv[14] = (         short *)0;
     sqlstm.sqinds[14] = (         int  )0;
     sqlstm.sqharm[14] = (unsigned long )0;
     sqlstm.sqadto[14] = (unsigned short )0;
     sqlstm.sqtdso[14] = (unsigned short )0;
     sqlstm.sqhstv[15] = (unsigned char  *)&ihAno;
     sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[15] = (         int  )0;
     sqlstm.sqindv[15] = (         short *)0;
     sqlstm.sqinds[15] = (         int  )0;
     sqlstm.sqharm[15] = (unsigned long )0;
     sqlstm.sqadto[15] = (unsigned short )0;
     sqlstm.sqtdso[15] = (unsigned short )0;
     sqlstm.sqhstv[16] = (unsigned char  *)szhFecVencimie;
     sqlstm.sqhstl[16] = (unsigned long )15;
     sqlstm.sqhsts[16] = (         int  )0;
     sqlstm.sqindv[16] = (         short *)0;
     sqlstm.sqinds[16] = (         int  )0;
     sqlstm.sqharm[16] = (unsigned long )0;
     sqlstm.sqadto[16] = (unsigned short )0;
     sqlstm.sqtdso[16] = (unsigned short )0;
     sqlstm.sqhstv[17] = (unsigned char  *)szhFecEmision;
     sqlstm.sqhstl[17] = (unsigned long )15;
     sqlstm.sqhsts[17] = (         int  )0;
     sqlstm.sqindv[17] = (         short *)0;
     sqlstm.sqinds[17] = (         int  )0;
     sqlstm.sqharm[17] = (unsigned long )0;
     sqlstm.sqadto[17] = (unsigned short )0;
     sqlstm.sqtdso[17] = (unsigned short )0;
     sqlstm.sqhstv[18] = (unsigned char  *)szhFecCaducida;
     sqlstm.sqhstl[18] = (unsigned long )15;
     sqlstm.sqhsts[18] = (         int  )0;
     sqlstm.sqindv[18] = (         short *)0;
     sqlstm.sqinds[18] = (         int  )0;
     sqlstm.sqharm[18] = (unsigned long )0;
     sqlstm.sqadto[18] = (unsigned short )0;
     sqlstm.sqtdso[18] = (unsigned short )0;
     sqlstm.sqhstv[19] = (unsigned char  *)szhFecProxVenc;
     sqlstm.sqhstl[19] = (unsigned long )15;
     sqlstm.sqhsts[19] = (         int  )0;
     sqlstm.sqindv[19] = (         short *)0;
     sqlstm.sqinds[19] = (         int  )0;
     sqlstm.sqharm[19] = (unsigned long )0;
     sqlstm.sqadto[19] = (unsigned short )0;
     sqlstm.sqtdso[19] = (unsigned short )0;
     sqlstm.sqhstv[20] = (unsigned char  *)szhFecDesdeLlan;
     sqlstm.sqhstl[20] = (unsigned long )15;
     sqlstm.sqhsts[20] = (         int  )0;
     sqlstm.sqindv[20] = (         short *)0;
     sqlstm.sqinds[20] = (         int  )0;
     sqlstm.sqharm[20] = (unsigned long )0;
     sqlstm.sqadto[20] = (unsigned short )0;
     sqlstm.sqtdso[20] = (unsigned short )0;
     sqlstm.sqhstv[21] = (unsigned char  *)szhFecHastaLlam;
     sqlstm.sqhstl[21] = (unsigned long )15;
     sqlstm.sqhsts[21] = (         int  )0;
     sqlstm.sqindv[21] = (         short *)0;
     sqlstm.sqinds[21] = (         int  )0;
     sqlstm.sqharm[21] = (unsigned long )0;
     sqlstm.sqadto[21] = (unsigned short )0;
     sqlstm.sqtdso[21] = (unsigned short )0;
     sqlstm.sqhstv[22] = (unsigned char  *)szhFecDesdeCFijos;
     sqlstm.sqhstl[22] = (unsigned long )15;
     sqlstm.sqhsts[22] = (         int  )0;
     sqlstm.sqindv[22] = (         short *)0;
     sqlstm.sqinds[22] = (         int  )0;
     sqlstm.sqharm[22] = (unsigned long )0;
     sqlstm.sqadto[22] = (unsigned short )0;
     sqlstm.sqtdso[22] = (unsigned short )0;
     sqlstm.sqhstv[23] = (unsigned char  *)szhFecHastaCFijos;
     sqlstm.sqhstl[23] = (unsigned long )15;
     sqlstm.sqhsts[23] = (         int  )0;
     sqlstm.sqindv[23] = (         short *)0;
     sqlstm.sqinds[23] = (         int  )0;
     sqlstm.sqharm[23] = (unsigned long )0;
     sqlstm.sqadto[23] = (unsigned short )0;
     sqlstm.sqtdso[23] = (unsigned short )0;
     sqlstm.sqhstv[24] = (unsigned char  *)szhFecDesdeOCargos;
     sqlstm.sqhstl[24] = (unsigned long )15;
     sqlstm.sqhsts[24] = (         int  )0;
     sqlstm.sqindv[24] = (         short *)0;
     sqlstm.sqinds[24] = (         int  )0;
     sqlstm.sqharm[24] = (unsigned long )0;
     sqlstm.sqadto[24] = (unsigned short )0;
     sqlstm.sqtdso[24] = (unsigned short )0;
     sqlstm.sqhstv[25] = (unsigned char  *)szhFecHastaOCargos;
     sqlstm.sqhstl[25] = (unsigned long )15;
     sqlstm.sqhsts[25] = (         int  )0;
     sqlstm.sqindv[25] = (         short *)0;
     sqlstm.sqinds[25] = (         int  )0;
     sqlstm.sqharm[25] = (unsigned long )0;
     sqlstm.sqadto[25] = (unsigned short )0;
     sqlstm.sqtdso[25] = (unsigned short )0;
     sqlstm.sqhstv[26] = (unsigned char  *)szhFecDesdeRoa;
     sqlstm.sqhstl[26] = (unsigned long )15;
     sqlstm.sqhsts[26] = (         int  )0;
     sqlstm.sqindv[26] = (         short *)0;
     sqlstm.sqinds[26] = (         int  )0;
     sqlstm.sqharm[26] = (unsigned long )0;
     sqlstm.sqadto[26] = (unsigned short )0;
     sqlstm.sqtdso[26] = (unsigned short )0;
     sqlstm.sqhstv[27] = (unsigned char  *)szhFecHastaRoa;
     sqlstm.sqhstl[27] = (unsigned long )15;
     sqlstm.sqhsts[27] = (         int  )0;
     sqlstm.sqindv[27] = (         short *)0;
     sqlstm.sqinds[27] = (         int  )0;
     sqlstm.sqharm[27] = (unsigned long )0;
     sqlstm.sqadto[27] = (unsigned short )0;
     sqlstm.sqtdso[27] = (unsigned short )0;
     sqlstm.sqhstv[28] = (unsigned char  *)szhFecHMenos;
     sqlstm.sqhstl[28] = (unsigned long )15;
     sqlstm.sqhsts[28] = (         int  )0;
     sqlstm.sqindv[28] = (         short *)0;
     sqlstm.sqinds[28] = (         int  )0;
     sqlstm.sqharm[28] = (unsigned long )0;
     sqlstm.sqadto[28] = (unsigned short )0;
     sqlstm.sqtdso[28] = (unsigned short )0;
     sqlstm.sqhstv[29] = (unsigned char  *)&shIndFacturacion;
     sqlstm.sqhstl[29] = (unsigned long )sizeof(short);
     sqlstm.sqhsts[29] = (         int  )0;
     sqlstm.sqindv[29] = (         short *)0;
     sqlstm.sqinds[29] = (         int  )0;
     sqlstm.sqharm[29] = (unsigned long )0;
     sqlstm.sqadto[29] = (unsigned short )0;
     sqlstm.sqtdso[29] = (unsigned short )0;
     sqlstm.sqhstv[30] = (unsigned char  *)szhDirLogs;
     sqlstm.sqhstl[30] = (unsigned long )101;
     sqlstm.sqhsts[30] = (         int  )0;
     sqlstm.sqindv[30] = (         short *)0;
     sqlstm.sqinds[30] = (         int  )0;
     sqlstm.sqharm[30] = (unsigned long )0;
     sqlstm.sqadto[30] = (unsigned short )0;
     sqlstm.sqtdso[30] = (unsigned short )0;
     sqlstm.sqhstv[31] = (unsigned char  *)szhDirSpool;
     sqlstm.sqhstl[31] = (unsigned long )101;
     sqlstm.sqhsts[31] = (         int  )0;
     sqlstm.sqindv[31] = (         short *)0;
     sqlstm.sqinds[31] = (         int  )0;
     sqlstm.sqharm[31] = (unsigned long )0;
     sqlstm.sqadto[31] = (unsigned short )0;
     sqlstm.sqtdso[31] = (unsigned short )0;
     sqlstm.sqhstv[32] = (unsigned char  *)&ihDiaPeriodo;
     sqlstm.sqhstl[32] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[32] = (         int  )0;
     sqlstm.sqindv[32] = (         short *)0;
     sqlstm.sqinds[32] = (         int  )0;
     sqlstm.sqharm[32] = (unsigned long )0;
     sqlstm.sqadto[32] = (unsigned short )0;
     sqlstm.sqtdso[32] = (unsigned short )0;
     sqlstm.sqhstv[33] = (unsigned char  *)&lhCodCiclFact;
     sqlstm.sqhstl[33] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[33] = (         int  )0;
     sqlstm.sqindv[33] = (         short *)0;
     sqlstm.sqinds[33] = (         int  )0;
     sqlstm.sqharm[33] = (unsigned long )0;
     sqlstm.sqadto[33] = (unsigned short )0;
     sqlstm.sqtdso[33] = (unsigned short )0;
     sqlstm.sqphsv = sqlstm.sqhstv;
     sqlstm.sqphsl = sqlstm.sqhstl;
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
   if (SQLCODE != SQLOK)
   {
       iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_CiclFact",
                szfnORAerror());
       return FALSE;
   }
   if (SQLCODE == 0)
   {
       pCiclo->iAno            = ihAno           ;
       pCiclo->iCodCiclo       = ihCodCiclo      ;
       pCiclo->lCodCiclFact    = lhCodCiclFact   ;
       pCiclo->iIndFacturacion = shIndFacturacion;
       pCiclo->iDiaPeriodo     = ihDiaPeriodo    ;

       if (!bfnDBGetCiclo (pCiclo))
            return FALSE;
   }
   return TRUE;
}/************************* bFindCiclFact ************************************/


/*****************************************************************************/
/*                         funcion : vPrintCiclFact                          */
/*****************************************************************************/
void vPrintCiclFact (CICLO* pCiclo,int iNumCiclFact)
{
    int iInd = 0;
    if (stStatus.LogNivel >= LOG06)
    {
        for (iInd=0;iInd<NUM_CICLFACT;iInd++)
        {
            vDTrazasLog (szExeName, "\n\t-------------------------------------------"
                              "\n\t\t\t   - Datos Ciclo Facturacion -     "
                              "\n\t- Ciclo Facturacion:............. %ld"
                              "\n\t- Ciclo.......................... %d"
                              "\n\t- Fecha Emision.................. '%s'"
                              "\n\t- Fecha Caducidad................ '%s'"
                              "\n\t- Fecha Desde LLamadas........... '%s'"
                              "\n\t- Fecha Hasta LLamadas........... '%s'"
                              "\n\t- Fecha Desde Cargos Fijos....... '%s'"
                              "\n\t- Fecha Hasta Cargos Fijos....... '%s'"
                              "\n\t- Fecha Desde Roaming............ '%s'"
                              "\n\t- Fecha Hasta Roaming............ '%s'"
                              "\n\t- Fecha Desde Otros Cargos....... '%s'"
                              "\n\t- Fecha Hasta Otros Cargos....... '%s'\n"
                              ,LOG06,pCiclo->lCodCiclFact
                              ,pCiclo->iCodCiclo
                              ,pCiclo->szFecEmision
                              ,pCiclo->szFecCaducida
                              ,pCiclo->szFecDesdeLlam
                              ,pCiclo->szFecHastaLlam
                              ,pCiclo->szFecDesdeCFijos
                              ,pCiclo->szFecHastaCFijos
                              ,pCiclo->szFecDesdeRoa
                              ,pCiclo->szFecHastaRoa
                              ,pCiclo->szFecDesdeOCargos
                              ,pCiclo->szFecHastaOCargos);

            vDTrazasLog (szExeName, "\n\t-------------------------------------------"
                              "\n\t- Fecha Desde Cargos Fijos Ant... '%s'"
                              "\n\t- Fecha Hasta Cargos Fijos Ant... '%s'"
                              "\n\t- Indicativo de Facturacion ..... '%d'"
                              "\n\t- Path de Logs .................. '%s'"
                              "\n\t- Path de Spool ................. '%s'"
                              ,LOG06,pCiclo->szFecDCFijosAnt
                              ,pCiclo->szFecHCFijosAnt
                              ,pCiclo->iIndFacturacion
                              ,pCiclo->szDirLogs
                              ,pCiclo->szDirSpool);

            pCiclo++;
        }
    }

}/*********************** Final vPrintCiclFact *******************************/


/*****************************************************************************/
/*                          funcion : bGetFecCFAnt                           */
/* -Funcion que recupera el max de la FecCFAnteriores                        */
/*****************************************************************************/
void vGetFecCFAnt (CICLO* pCiclo)
{
  int iInd = 0;
  char szFecDesde [15]="";
  char szFecHasta [15]="";



  for (iInd=0;iInd<NUM_CICLFACT;iInd++)
  {
       if (pstCiclFact[iInd].iCodCiclo    == pCiclo->iCodCiclo &&
           pstCiclFact[iInd].lCodCiclFact <  pCiclo->lCodCiclFact)
       {
           if (iInd == 0)
           {
               strcpy (szFecDesde,pstCiclFact[iInd].szFecDesdeCFijos);
               strcpy (szFecHasta,pstCiclFact[iInd].szFecHastaCFijos);
           }
           if (strcmp (szFecDesde,pstCiclFact[iInd].szFecDesdeCFijos)<0)
               strcpy (szFecDesde,pstCiclFact[iInd].szFecDesdeCFijos);

           if (strcmp (szFecHasta,pstCiclFact[iInd].szFecHastaCFijos)<0)
               strcpy (szFecHasta,pstCiclFact[iInd].szFecHastaCFijos);
       }/* if iCodCiclo ... */
  }
  if (!strlen (szFecDesde))
  {
       strcpy (pCiclo->szFecDCFijosAnt,"19800101235959")   ;
       strcpy (pCiclo->szFecHCFijosAnt,pCiclo->szFecHMenos);
  }
  else
  {
      strcpy (pCiclo->szFecDCFijosAnt,szFecDesde);
      strcpy (pCiclo->szFecHCFijosAnt,szFecHasta);
  }
}/************************* Final bGetFecCFAnt *******************************/

/* -------------------------------------------------------------------------- */
/*   bGetDatosGener (DATOSGENER*)                                             */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetDatosGener (DATOSGENER* pDatosGener,char *szFecSysDate)
{
  /* EXEC SQL BEGIN DECLARE SECTION    ; */ 

  static long  lhCodAgenteStartel   ;
  static char* szhCodDollar         ; /* EXEC SQL VAR szhCodDollar     IS STRING(4)  ; */ 

  static char* szhCodUf             ; /* EXEC SQL VAR szhCodUf         IS STRING(4)  ; */ 

  static char* szhCodPeso           ; /* EXEC SQL VAR szhCodPeso       IS STRING(4)  ; */ 

  static long  lhCodClienteStartel  ;
  static int   ihCodIva             ;
  static float fhPctIva             ;
  static char* szhCodMoneFact       ; /* EXEC SQL VAR szhCodMoneFact   IS STRING(4)  ; */ 

  static char* szhPathBin           ; /* EXEC SQL VAR szhPathBin       IS STRING(256); */ 

  static char* szhDirReports        ; /* EXEC SQL VAR szhDirReports    IS STRING(51) ; */ 

  static char* szhDirLogs           ; /* EXEC SQL VAR szhDirLogs       IS STRING(256); */ 

  static char* szhDirSpool          ; /* EXEC SQL VAR szhDirSpool      IS STRING(101); */ 

  static short shCodEmpresa         ;
  static char* szhDesEmpresa        ; /* EXEC SQL VAR szhDesEmpresa    IS STRING(31) ; */ 

  static int   ihCodCatImpos        ;
  static char* szhRut               ;
  static short shProdCelular        ;
  static short shProdBeeper         ;
  static short shProdTrek           ;
  static short shProdTrunk          ;
  static short shProdGeneral        ;
  static int   ihCodCatImposDef     ;
  static char* szhNomUsuaDBA        ; /* EXEC SQL VAR szhNomUsuaDBA    IS STRING(31) ; */ 

  static char* szhSysDate           ; /* EXEC SQL VAR szhSysDate       IS STRING(15) ; */ 

  static char* szhCodOficCentral    ; /* EXEC SQL VAR szhCodOficCentral IS STRING(3) ; */ 

  static int   ihCodAbonoCel        ;
  static int   ihCodAbonoBeep       ;
  static int   ihCodAbonoTrek       ;
  static int   ihCodAbonoTrunk      ;
  static int   ihCodAbonoFinCel     ;
  static int   ihCodAbonoFinBeep    ;
  static int   ihCodAbonoFinTrek    ;
  static int   ihCodAbonoFinTrunk   ;
  static int   ihCodRecargo         ;
  static int   ihCodContado         ;
  static int   ihCodCiclo           ;
  static int   ihCodNotaCre         ;
  static int   ihCodNotaDeb         ;
  static int   ihCodMiscela         ;
  static int   ihCodCompra          ;
  static int   ihCodBaja            ;
  static int   ihCodLiquidacion     ;
  static int   ihCodFactura         ;
  static int   ihCodConcIva         ;
  static int   ihCodRoamingVis      ;
  static int   ihCodRentaPhone      ;
  static char *szhMonedaCobros      ; /* EXEC SQL VAR szhMonedaCobros   IS STRING(4) ; */ 

  static char *szhOficinaPago       ; /* EXEC SQL VAR szhOficinaPago    IS STRING(3) ; */ 

  static char *szhCodPlanTarif      ; /* EXEC SQL VAR szhCodPlanTarif   IS STRING(4) ; */ 

  static char *szhLetraCobros       ; /* EXEC SQL VAR szhLetraCobros    IS STRING(2) ; */ 

  static long  lhAgenteInterno      ;
  static int   ihDocRegalo          ;
  static int   ihDocStaff           ;
  static int   ihSisPagoRegalo      ;
  static int   ihCauPagoRegalo      ;
  static int   ihOriPagoRegalo      ;
  static short i_shCodPlanTarif     ;
  static int   ihNumDiasBaja        ;
  static long  lhCodCicloDocPuntual ;
  static int   ihCodFacturaExen     ;
  static int   ihCodBoleta          ;
  static int   ihCodBoletaExen      ;

  static char  szhFmtFecha [17]; /* EXEC SQL VAR szhFmtFecha    IS STRING(17) ; */ 

  /* EXEC SQL END DECLARE SECTION      ; */ 


  szhCodDollar     = pDatosGener->szCodDollar     ;
  szhCodUf         = pDatosGener->szCodUf         ;
  szhCodPeso       = pDatosGener->szCodPeso       ;
  szhPathBin       = pDatosGener->szPathBin       ;
  szhDirReports    = pDatosGener->szDirReports    ;
  szhDirSpool      = pDatosGener->szDirSpool      ;
  szhDirLogs       = pDatosGener->szDirLogs       ;
  szhCodMoneFact   = pDatosGener->szCodMoneFact   ;
  szhSysDate       = szFecSysDate                 ;
  szhMonedaCobros  = pDatosGener->szMonedaCobros  ;
  szhCodOficCentral= pDatosGener->szCodOficCentral;
  szhCodPlanTarif  = pDatosGener->szCodPlanTarif  ;
  szhOficinaPago   = pDatosGener->szOficinaPago   ;
  szhLetraCobros   = pDatosGener->szLetraCobros   ;

  sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");
  /* EXEC SQL SELECT
                  COD_DOLLAR        ,
                  COD_UF            ,
                  COD_PESO          ,
                  COD_IVA           ,
                  PCT_IVA           ,
                  COD_MONEFACT      ,
                  PATHBIN           ,
                  DIR_REPORTS       ,
                  DIR_SPOOL         ,
                  DIR_LOGS          ,
                  COD_ABONOCEL      ,
                  COD_ABONOBEEP     ,
                  COD_ABONOTREK     ,
                  COD_ABONOTRUNK    ,
                  COD_ABONOFINCEL   ,
                  COD_ABONOFINBEEP  ,
                  COD_ABONOFINTREK  ,
                  COD_ABONOFINTRUNK ,
                  COD_RECARGO       ,
                  COD_CONTADO       ,
                  COD_CICLO         ,
                  COD_BAJA          ,
                  COD_NOTACRE       ,
                  COD_NOTADEB       ,
                  COD_MISCELA       ,
                  COD_COMPRA        ,
                  COD_LIQUIDACION   ,
                  COD_RENTAPHONE    ,
                  COD_ROAMINGVIS    ,
                  COD_FACTURA       ,
                  COD_CONCIVA       ,
                  COD_PLANTARIF     ,
                  NUM_DIASBAJA      ,
                  COD_CICLODOCPUNTUAL,
                  TO_CHAR(SYSDATE,:szhFmtFecha),
                  COD_FACTURAEXEN   ,
                  COD_BOLETA        ,
                  COD_BOLETAEXEN
           INTO
                  :szhCodDollar      ,
                  :szhCodUf          ,
                  :szhCodPeso        ,
                  :ihCodIva          ,
                  :fhPctIva          ,
                  :szhCodMoneFact    ,
                  :szhPathBin        ,
                  :szhDirReports     ,
                  :szhDirSpool       ,
                  :szhDirLogs        ,
                  :ihCodAbonoCel     ,
                  :ihCodAbonoBeep    ,
                  :ihCodAbonoTrek    ,
                  :ihCodAbonoTrunk   ,
                  :ihCodAbonoFinCel  ,
                  :ihCodAbonoFinBeep ,
                  :ihCodAbonoFinTrek ,
                  :ihCodAbonoFinTrunk,
                  :ihCodRecargo      ,
                  :ihCodContado      ,
                  :ihCodCiclo        ,
                  :ihCodBaja         ,
                  :ihCodNotaCre      ,
                  :ihCodNotaDeb      ,
                  :ihCodMiscela      ,
                  :ihCodCompra       ,
                  :ihCodLiquidacion  ,
                  :ihCodRentaPhone   ,
                  :ihCodRoamingVis   ,
                  :ihCodFactura      ,
                  :ihCodConcIva      ,
                  :szhCodPlanTarif:i_shCodPlanTarif ,
                  :ihNumDiasBaja     ,
                  :lhCodCicloDocPuntual,
                  :szhSysDate,
                  :ihCodFacturaExen,
                  :ihCodBoleta,
                  :ihCodBoletaExen
           FROM   FA_DATOSGENER; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 39;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_DOLLAR ,COD_UF ,COD_PESO ,COD_IVA ,PCT_IVA ,COD_\
MONEFACT ,PATHBIN ,DIR_REPORTS ,DIR_SPOOL ,DIR_LOGS ,COD_ABONOCEL ,COD_ABONOBE\
EP ,COD_ABONOTREK ,COD_ABONOTRUNK ,COD_ABONOFINCEL ,COD_ABONOFINBEEP ,COD_ABON\
OFINTREK ,COD_ABONOFINTRUNK ,COD_RECARGO ,COD_CONTADO ,COD_CICLO ,COD_BAJA ,CO\
D_NOTACRE ,COD_NOTADEB ,COD_MISCELA ,COD_COMPRA ,COD_LIQUIDACION ,COD_RENTAPHO\
NE ,COD_ROAMINGVIS ,COD_FACTURA ,COD_CONCIVA ,COD_PLANTARIF ,NUM_DIASBAJA ,COD\
_CICLODOCPUNTUAL ,TO_CHAR(SYSDATE,:b0) ,COD_FACTURAEXEN ,COD_BOLETA ,COD_BOLET\
AEXEN into :b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:\
b16,:b17,:b18,:b19,:b20,:b21,:b22,:b23,:b24,:b25,:b26,:b27,:b28,:b29,:b30,:b31\
,:b32:b33,:b34,:b35,:b36,:b37,:b38,:b39  from FA_DATOSGENER ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )592;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
  sqlstm.sqhstl[0] = (unsigned long )17;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodDollar;
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodUf;
  sqlstm.sqhstl[2] = (unsigned long )4;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodPeso;
  sqlstm.sqhstl[3] = (unsigned long )4;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodIva;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&fhPctIva;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(float);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodMoneFact;
  sqlstm.sqhstl[6] = (unsigned long )4;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhPathBin;
  sqlstm.sqhstl[7] = (unsigned long )256;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhDirReports;
  sqlstm.sqhstl[8] = (unsigned long )51;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhDirSpool;
  sqlstm.sqhstl[9] = (unsigned long )101;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhDirLogs;
  sqlstm.sqhstl[10] = (unsigned long )256;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)&ihCodAbonoCel;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihCodAbonoBeep;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&ihCodAbonoTrek;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)&ihCodAbonoTrunk;
  sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)&ihCodAbonoFinCel;
  sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)&ihCodAbonoFinBeep;
  sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)&ihCodAbonoFinTrek;
  sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)&ihCodAbonoFinTrunk;
  sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)&ihCodRecargo;
  sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)&ihCodContado;
  sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)&ihCodCiclo;
  sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)&ihCodBaja;
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)&ihCodNotaCre;
  sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)&ihCodNotaDeb;
  sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)&ihCodMiscela;
  sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)&ihCodCompra;
  sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)&ihCodLiquidacion;
  sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[27] = (         int  )0;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)&ihCodRentaPhone;
  sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[28] = (         int  )0;
  sqlstm.sqindv[28] = (         short *)0;
  sqlstm.sqinds[28] = (         int  )0;
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)&ihCodRoamingVis;
  sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[29] = (         int  )0;
  sqlstm.sqindv[29] = (         short *)0;
  sqlstm.sqinds[29] = (         int  )0;
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
  sqlstm.sqhstv[30] = (unsigned char  *)&ihCodFactura;
  sqlstm.sqhstl[30] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[30] = (         int  )0;
  sqlstm.sqindv[30] = (         short *)0;
  sqlstm.sqinds[30] = (         int  )0;
  sqlstm.sqharm[30] = (unsigned long )0;
  sqlstm.sqadto[30] = (unsigned short )0;
  sqlstm.sqtdso[30] = (unsigned short )0;
  sqlstm.sqhstv[31] = (unsigned char  *)&ihCodConcIva;
  sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[31] = (         int  )0;
  sqlstm.sqindv[31] = (         short *)0;
  sqlstm.sqinds[31] = (         int  )0;
  sqlstm.sqharm[31] = (unsigned long )0;
  sqlstm.sqadto[31] = (unsigned short )0;
  sqlstm.sqtdso[31] = (unsigned short )0;
  sqlstm.sqhstv[32] = (unsigned char  *)szhCodPlanTarif;
  sqlstm.sqhstl[32] = (unsigned long )4;
  sqlstm.sqhsts[32] = (         int  )0;
  sqlstm.sqindv[32] = (         short *)&i_shCodPlanTarif;
  sqlstm.sqinds[32] = (         int  )0;
  sqlstm.sqharm[32] = (unsigned long )0;
  sqlstm.sqadto[32] = (unsigned short )0;
  sqlstm.sqtdso[32] = (unsigned short )0;
  sqlstm.sqhstv[33] = (unsigned char  *)&ihNumDiasBaja;
  sqlstm.sqhstl[33] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[33] = (         int  )0;
  sqlstm.sqindv[33] = (         short *)0;
  sqlstm.sqinds[33] = (         int  )0;
  sqlstm.sqharm[33] = (unsigned long )0;
  sqlstm.sqadto[33] = (unsigned short )0;
  sqlstm.sqtdso[33] = (unsigned short )0;
  sqlstm.sqhstv[34] = (unsigned char  *)&lhCodCicloDocPuntual;
  sqlstm.sqhstl[34] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[34] = (         int  )0;
  sqlstm.sqindv[34] = (         short *)0;
  sqlstm.sqinds[34] = (         int  )0;
  sqlstm.sqharm[34] = (unsigned long )0;
  sqlstm.sqadto[34] = (unsigned short )0;
  sqlstm.sqtdso[34] = (unsigned short )0;
  sqlstm.sqhstv[35] = (unsigned char  *)szhSysDate;
  sqlstm.sqhstl[35] = (unsigned long )15;
  sqlstm.sqhsts[35] = (         int  )0;
  sqlstm.sqindv[35] = (         short *)0;
  sqlstm.sqinds[35] = (         int  )0;
  sqlstm.sqharm[35] = (unsigned long )0;
  sqlstm.sqadto[35] = (unsigned short )0;
  sqlstm.sqtdso[35] = (unsigned short )0;
  sqlstm.sqhstv[36] = (unsigned char  *)&ihCodFacturaExen;
  sqlstm.sqhstl[36] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[36] = (         int  )0;
  sqlstm.sqindv[36] = (         short *)0;
  sqlstm.sqinds[36] = (         int  )0;
  sqlstm.sqharm[36] = (unsigned long )0;
  sqlstm.sqadto[36] = (unsigned short )0;
  sqlstm.sqtdso[36] = (unsigned short )0;
  sqlstm.sqhstv[37] = (unsigned char  *)&ihCodBoleta;
  sqlstm.sqhstl[37] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[37] = (         int  )0;
  sqlstm.sqindv[37] = (         short *)0;
  sqlstm.sqinds[37] = (         int  )0;
  sqlstm.sqharm[37] = (unsigned long )0;
  sqlstm.sqadto[37] = (unsigned short )0;
  sqlstm.sqtdso[37] = (unsigned short )0;
  sqlstm.sqhstv[38] = (unsigned char  *)&ihCodBoletaExen;
  sqlstm.sqhstl[38] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[38] = (         int  )0;
  sqlstm.sqindv[38] = (         short *)0;
  sqlstm.sqinds[38] = (         int  )0;
  sqlstm.sqharm[38] = (unsigned long )0;
  sqlstm.sqadto[38] = (unsigned short )0;
  sqlstm.sqtdso[38] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
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
      printf ("\nError Oracle (Fa_DatosGener) : %s\n",szfnORAerror());
      return FALSE;
  }
  if (SQLCODE == 0)
  {
      pDatosGener->iCodIva        = ihCodIva       ;
      pDatosGener->iCodConcIva    = ihCodConcIva   ;
      pDatosGener->fPctIva        = fhPctIva       ;

      pDatosGener->iCodAbonoCel   = ihCodAbonoCel  ;
      pDatosGener->iCodAbonoBeep  = ihCodAbonoBeep ;
      pDatosGener->iCodAbonoTrek  = ihCodAbonoTrek ;
      pDatosGener->iCodAbonoTrunk = ihCodAbonoTrunk;

      pDatosGener->iCodAbonoFinCel   = ihCodAbonoFinCel  ;
      pDatosGener->iCodAbonoFinBeep  = ihCodAbonoFinBeep ;
      pDatosGener->iCodAbonoFinTrek  = ihCodAbonoFinTrek ;
      pDatosGener->iCodAbonoFinTrunk = ihCodAbonoFinTrunk;

      pDatosGener->iCodRecargo    = ihCodRecargo    ;
      pDatosGener->iCodContado    = ihCodContado    ;
      pDatosGener->iCodCiclo      = ihCodCiclo      ;
      pDatosGener->iCodBaja       = ihCodBaja       ;
      pDatosGener->iCodNotaCre    = ihCodNotaCre    ;
      pDatosGener->iCodNotaDeb    = ihCodNotaDeb    ;
      pDatosGener->iCodMiscela    = ihCodMiscela    ;
      pDatosGener->iCodCompra     = ihCodCompra     ;
      pDatosGener->iCodLiquidacion= ihCodLiquidacion;
      pDatosGener->iCodRentaPhone = ihCodRentaPhone ;
      pDatosGener->iCodRoamingVis = ihCodRoamingVis ;
      pDatosGener->iCodFactura    = ihCodFactura    ;

      pDatosGener->iCodFacturaExen = ihCodFacturaExen ;
      pDatosGener->iCodBoleta      = ihCodBoleta      ;
      pDatosGener->iCodBoletaExen  = ihCodBoletaExen  ;

      pDatosGener->iNumDiasBaja       = ihNumDiasBaja       ;
      pDatosGener->lCodCicloDocPuntual=lhCodCicloDocPuntual ;

      if (i_shCodPlanTarif == -1)
          pDatosGener->szCodPlanTarif [0] = '\0'   ;

      szhDesEmpresa = pDatosGener->szDesEmpresa    ;
      szhRut        = pDatosGener->szRut           ;
      szhNomUsuaDBA = pDatosGener->szNomUsuaDBA    ;

      /* EXEC SQL SELECT A.COD_EMPRESA       ,
                      A.COD_CLIENTESTARTEL,
                      A.DES_EMPRESA       ,
                      A.COD_AGENTESTARTEL ,
                      A.COD_CATIMPOS      ,
                      A.NUM_IDENT          ,
                      A.PROD_CELULAR      ,
                      A.PROD_BEEPER       ,
                      A.PROD_TREK         ,
                      A.PROD_TRUNK        ,
                      A.PROD_GENERAL      ,
                      A.COD_CATIMPOSDEF   ,
                      A.NOM_USUADBA       ,
                      A.COD_OFICCENTRAL   ,
                      B.OFICINA_PAG       ,
                      B.DOC_VREGALO       ,
                      B.DOC_STAFF         ,
                      B.LETRA_COBROS      ,
                      B.AGENTE_INTERNO    ,
                      B.SISPAGO_REGALO    ,
                      B.CAUPAGO_REGALO    ,
                      B.ORIPAGO_REGALO    ,
                      B.MONEDA_COBROS
               INTO   :shCodEmpresa       ,
                      :lhCodClienteStartel,
                      :szhDesEmpresa      ,
                      :lhCodAgenteStartel ,
                      :ihCodCatImpos      ,
                      :szhRut             ,
                      :shProdCelular      ,
                      :shProdBeeper       ,
                      :shProdTrek         ,
                      :shProdTrunk        ,
                      :shProdGeneral      ,
                      :ihCodCatImposDef   ,
                      :szhNomUsuaDBA      ,
                      :szhCodOficCentral  ,
                      :szhOficinaPago     ,
                      :ihDocRegalo        ,
                      :ihDocStaff         ,
                      :szhLetraCobros     ,
                      :lhAgenteInterno    ,
                      :ihSisPagoRegalo    ,
                      :ihCauPagoRegalo    ,
                      :ihOriPagoRegalo    ,
                      :szhMonedaCobros
               FROM   GE_DATOSGENER A, CO_DATGEN B; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select A.COD_EMPRESA ,A.COD_CLIENTESTARTEL ,A.DES_EMPRE\
SA ,A.COD_AGENTESTARTEL ,A.COD_CATIMPOS ,A.NUM_IDENT ,A.PROD_CELULAR ,A.PROD_B\
EEPER ,A.PROD_TREK ,A.PROD_TRUNK ,A.PROD_GENERAL ,A.COD_CATIMPOSDEF ,A.NOM_USU\
ADBA ,A.COD_OFICCENTRAL ,B.OFICINA_PAG ,B.DOC_VREGALO ,B.DOC_STAFF ,B.LETRA_CO\
BROS ,B.AGENTE_INTERNO ,B.SISPAGO_REGALO ,B.CAUPAGO_REGALO ,B.ORIPAGO_REGALO ,\
B.MONEDA_COBROS into :b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b\
13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22  from GE_DATOSGENER A ,CO_DATG\
EN B ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )763;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&shCodEmpresa;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lhCodClienteStartel;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhDesEmpresa;
      sqlstm.sqhstl[2] = (unsigned long )31;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgenteStartel;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCatImpos;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhRut;
      sqlstm.sqhstl[5] = (unsigned long )0;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&shProdCelular;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&shProdBeeper;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&shProdTrek;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&shProdTrunk;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&shProdGeneral;
      sqlstm.sqhstl[10] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)&ihCodCatImposDef;
      sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)0;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)szhNomUsuaDBA;
      sqlstm.sqhstl[12] = (unsigned long )31;
      sqlstm.sqhsts[12] = (         int  )0;
      sqlstm.sqindv[12] = (         short *)0;
      sqlstm.sqinds[12] = (         int  )0;
      sqlstm.sqharm[12] = (unsigned long )0;
      sqlstm.sqadto[12] = (unsigned short )0;
      sqlstm.sqtdso[12] = (unsigned short )0;
      sqlstm.sqhstv[13] = (unsigned char  *)szhCodOficCentral;
      sqlstm.sqhstl[13] = (unsigned long )3;
      sqlstm.sqhsts[13] = (         int  )0;
      sqlstm.sqindv[13] = (         short *)0;
      sqlstm.sqinds[13] = (         int  )0;
      sqlstm.sqharm[13] = (unsigned long )0;
      sqlstm.sqadto[13] = (unsigned short )0;
      sqlstm.sqtdso[13] = (unsigned short )0;
      sqlstm.sqhstv[14] = (unsigned char  *)szhOficinaPago;
      sqlstm.sqhstl[14] = (unsigned long )3;
      sqlstm.sqhsts[14] = (         int  )0;
      sqlstm.sqindv[14] = (         short *)0;
      sqlstm.sqinds[14] = (         int  )0;
      sqlstm.sqharm[14] = (unsigned long )0;
      sqlstm.sqadto[14] = (unsigned short )0;
      sqlstm.sqtdso[14] = (unsigned short )0;
      sqlstm.sqhstv[15] = (unsigned char  *)&ihDocRegalo;
      sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[15] = (         int  )0;
      sqlstm.sqindv[15] = (         short *)0;
      sqlstm.sqinds[15] = (         int  )0;
      sqlstm.sqharm[15] = (unsigned long )0;
      sqlstm.sqadto[15] = (unsigned short )0;
      sqlstm.sqtdso[15] = (unsigned short )0;
      sqlstm.sqhstv[16] = (unsigned char  *)&ihDocStaff;
      sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[16] = (         int  )0;
      sqlstm.sqindv[16] = (         short *)0;
      sqlstm.sqinds[16] = (         int  )0;
      sqlstm.sqharm[16] = (unsigned long )0;
      sqlstm.sqadto[16] = (unsigned short )0;
      sqlstm.sqtdso[16] = (unsigned short )0;
      sqlstm.sqhstv[17] = (unsigned char  *)szhLetraCobros;
      sqlstm.sqhstl[17] = (unsigned long )2;
      sqlstm.sqhsts[17] = (         int  )0;
      sqlstm.sqindv[17] = (         short *)0;
      sqlstm.sqinds[17] = (         int  )0;
      sqlstm.sqharm[17] = (unsigned long )0;
      sqlstm.sqadto[17] = (unsigned short )0;
      sqlstm.sqtdso[17] = (unsigned short )0;
      sqlstm.sqhstv[18] = (unsigned char  *)&lhAgenteInterno;
      sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[18] = (         int  )0;
      sqlstm.sqindv[18] = (         short *)0;
      sqlstm.sqinds[18] = (         int  )0;
      sqlstm.sqharm[18] = (unsigned long )0;
      sqlstm.sqadto[18] = (unsigned short )0;
      sqlstm.sqtdso[18] = (unsigned short )0;
      sqlstm.sqhstv[19] = (unsigned char  *)&ihSisPagoRegalo;
      sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[19] = (         int  )0;
      sqlstm.sqindv[19] = (         short *)0;
      sqlstm.sqinds[19] = (         int  )0;
      sqlstm.sqharm[19] = (unsigned long )0;
      sqlstm.sqadto[19] = (unsigned short )0;
      sqlstm.sqtdso[19] = (unsigned short )0;
      sqlstm.sqhstv[20] = (unsigned char  *)&ihCauPagoRegalo;
      sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[20] = (         int  )0;
      sqlstm.sqindv[20] = (         short *)0;
      sqlstm.sqinds[20] = (         int  )0;
      sqlstm.sqharm[20] = (unsigned long )0;
      sqlstm.sqadto[20] = (unsigned short )0;
      sqlstm.sqtdso[20] = (unsigned short )0;
      sqlstm.sqhstv[21] = (unsigned char  *)&ihOriPagoRegalo;
      sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[21] = (         int  )0;
      sqlstm.sqindv[21] = (         short *)0;
      sqlstm.sqinds[21] = (         int  )0;
      sqlstm.sqharm[21] = (unsigned long )0;
      sqlstm.sqadto[21] = (unsigned short )0;
      sqlstm.sqtdso[21] = (unsigned short )0;
      sqlstm.sqhstv[22] = (unsigned char  *)szhMonedaCobros;
      sqlstm.sqhstl[22] = (unsigned long )4;
      sqlstm.sqhsts[22] = (         int  )0;
      sqlstm.sqindv[22] = (         short *)0;
      sqlstm.sqinds[22] = (         int  )0;
      sqlstm.sqharm[22] = (unsigned long )0;
      sqlstm.sqadto[22] = (unsigned short )0;
      sqlstm.sqtdso[22] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
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
      {
          printf ("\nError Oracle (Ge_DatosGener, Co_DatGen) : %s\n",
                  szfnORAerror());
          return FALSE;
      }
      if (SQLCODE == 0)
      {
          pDatosGener->lCodClienteStartel = lhCodClienteStartel;
          pDatosGener->lCodAgenteStartel  = lhCodAgenteStartel ;
          pDatosGener->iCodEmpresa        = shCodEmpresa       ;
          pDatosGener->iProdCelular       = shProdCelular      ;
          pDatosGener->iProdBeeper        = shProdBeeper       ;
          pDatosGener->iProdTrek          = shProdTrek         ;
          pDatosGener->iProdTrunk         = shProdTrunk        ;
          pDatosGener->iProdGeneral       = shProdGeneral      ;
          pDatosGener->iCodCatImposDef    = ihCodCatImposDef   ;
          pDatosGener->iDocRegalo         = ihDocRegalo        ;
          pDatosGener->iDocStaff          = ihDocStaff         ;
          pDatosGener->lAgenteInterno     = lhAgenteInterno    ;
          pDatosGener->iSisPagoRegalo     = ihSisPagoRegalo    ;
          pDatosGener->iCauPagoRegalo     = ihCauPagoRegalo    ;
          pDatosGener->iOriPagoRegalo     = ihOriPagoRegalo    ;
      }
      if (!bGetParamGener (pDatosGener))
        return (FALSE);
        
      if (!bGetParamImporte(pDatosGener))
      	return (FALSE);
      	
      if (!bGetParamConsumo(pDatosGener))
      	return (FALSE);
      	
      if (!bGetNitOperadora(pDatosGener))
      	return (FALSE);      
      	
      if (!bGetClaConTecnico(pDatosGener))
      	return (FALSE);      	
      	
      if (!bGetTipDocNotaAbo(pDatosGener))
      	return (FALSE);      	
  }
  return TRUE;
}/**************************** bGetDatosGener ********************************/

/* -------------------------------------------------------------------------- */
/*   bGetParamConsumo (DATOSGENER*)                                             */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetParamConsumo (DATOSGENER* pstDatosGener)
{
    char    szmodulo[256] = "bGetParamConsumo";
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro  IS STRING(21); */ 

    static long  lhValNumerico      ;
    /* EXEC SQL END   DECLARE SECTION  ; */ 

    
    /*INDICADOR CICLO*/
    strcpy(szhNomParametro,"IND_INFO_CICLO");
    lhValNumerico = 0;

    /* EXEC SQL 
    SELECT VALOR_NUMERICO 
      INTO :lhValNumerico
      FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VALOR_NUMERICO into :b0  from FA_PARAMETROS_SIMPLE\
S_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )870;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhValNumerico;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametro Indicador de Informacion por Ciclo:[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametros de Indicador de Informacion por Ciclo",szfnORAerror ());
        return  (FALSE)                              ;
    }
    pstDatosGener->lInfoCiclo = lhValNumerico;
    
    
    
    /*  INDICADOR MES   */
    strcpy(szhNomParametro,"IND_INFO_MENSUAL");
    lhValNumerico = 0;

    /* EXEC SQL 
    SELECT VALOR_NUMERICO 
      INTO :lhValNumerico
      FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VALOR_NUMERICO into :b0  from FA_PARAMETROS_SIMPLE\
S_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )893;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhValNumerico;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametros Indicador de Informacion Mensual:[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametros de Indicador de Informacion Mensual",szfnORAerror ());
        return  (FALSE)                              ;
    }
    pstDatosGener->lInfoMes = lhValNumerico;
    
    
    /*  CANTIDAD DE CICLO   */
    strcpy(szhNomParametro,"CANT_CICLOS_INFORMAR");
    lhValNumerico = 0;

    /* EXEC SQL 
    SELECT VALOR_NUMERICO 
      INTO :lhValNumerico
      FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VALOR_NUMERICO into :b0  from FA_PARAMETROS_SIMPLE\
S_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )916;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhValNumerico;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametro de cantidad de ciclos:[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametros cantidad de ciclos",szfnORAerror ());
        return  (FALSE)                              ;
    }
    pstDatosGener->lCantCiclos = lhValNumerico;
    
    
    return (TRUE);
}/**************************** bGetParamConsumo ********************************/


/* -------------------------------------------------------------------------- */
/*   bGetParamImporte (DATOSGENER*)                                             */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetParamImporte (DATOSGENER* pstDatosGener)
{
    char    szmodulo[256] = "bGetParamImporte";
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro  IS STRING(21); */ 

    static long  lhValNumerico      ;
    /* EXEC SQL END   DECLARE SECTION  ; */ 

    
    /*  INDICADOR DE IMPORTE   */
    strcpy(szhNomParametro,"IND_VAL_IMPORTE_CONC");
	lhValNumerico = 0;
    /* EXEC SQL 
    SELECT VALOR_NUMERICO 
      INTO :lhValNumerico
      FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VALOR_NUMERICO into :b0  from FA_PARAMETROS_SIMPLE\
S_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )939;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhValNumerico;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametros de Importe:[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametros de Importe",szfnORAerror ());
        return  (FALSE)                              ;
    }
    pstDatosGener->lIndValImporte = lhValNumerico;
    
    
    /*  MONTO IMPORTE   */
    strcpy(szhNomParametro,"MONTO_VAL_IMPORTE");
	lhValNumerico = 0;
    /* EXEC SQL 
    SELECT VALOR_NUMERICO 
      INTO :lhValNumerico
      FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VALOR_NUMERICO into :b0  from FA_PARAMETROS_SIMPLE\
S_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )962;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhValNumerico;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametros de Importe:[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametros de Importe",szfnORAerror ());
        return  (FALSE)                              ;
    }
    pstDatosGener->lMontoImporte = lhValNumerico;
    
    
    return (TRUE);
}/**************************** bGetParamImporte ********************************/

/* -------------------------------------------------------------------------- */
/*   bGetParamGener (DATOSGENER*)                                             */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetParamGener (DATOSGENER* pstDatosGener)
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro  IS STRING(3); */ 

    static char  szhModuloSiscel[3] ; /* EXEC SQL VAR szhModuloSiscel  IS STRING(3); */ 

    static int   ihCodProducto      ;
    static char  szhValParametro[7] ; /* EXEC SQL VAR szhValParametro  IS STRING(3); */ 

    /* EXEC SQL END   DECLARE SECTION  ; */ 


    sprintf(szhModuloSiscel,"FA\0");

    /* EXEC SQL DECLARE Cur_Ger_Parametros CURSOR FOR
        SELECT  NOM_PARAMETRO   ,
                COD_MODULO      ,
                COD_PRODUCTO    ,
                VAL_PARAMETRO
        FROM   GED_PARAMETROS
        WHERE  COD_MODULO = :szhModuloSiscel; */ 


   /* EXEC SQL OPEN Cur_Ger_Parametros; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 39;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0017;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )985;
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
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
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
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ged_Parametros",
                szfnORAerror());
       return  (FALSE)         ;
   }
   while (SQLCODE == SQLOK)
   {

        /* EXEC SQL
            FETCH Cur_Ger_Parametros
            INTO    :szhNomParametro    ,
                    :szhModuloSiscel    ,
                    :ihCodProducto      ,
                    :szhValParametro    ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 39;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1004;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhNomParametro;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhModuloSiscel;
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
        sqlstm.sqhstv[3] = (unsigned char  *)szhValParametro;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                       "Fetch->Ged_Parametros",szfnORAerror ());
            return  (FALSE)                              ;
        }
        if (SQLCODE == SQLOK)
        {
            switch(atoi(szhNomParametro))
            {
                case    szGED_CODCONSIGNACION   :
                        pstDatosGener->iCodConsignacion = atoi(szhValParametro);
                    break;
                case    szGED_CODCONSIGNACION_NC:
                        pstDatosGener->iNCredConsignacion = atoi(szhValParametro);
                    break;
                default                         :
                    break;
            }
        }
    }
    if (SQLCODE == SQLNOTFOUND)
    {
        /* EXEC SQL CLOSE Cur_Ger_Parametros; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 39;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1035;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (SQLCODE)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ged_Parametros",
                     szfnORAerror());
            return (FALSE);
        }
    }
    return (TRUE);
}/**************************** bGetParamGener ********************************/

/* -------------------------------------------------------------------------- */
/*   bGetNitOperadora (DATOSGENER*)                                           */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetNitOperadora (DATOSGENER* pstDatosGener)
{
    char    szmodulo[256] = "bGetNitOperadora";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro IS STRING(21); */ 

         static char  szhValTexto    [16]=""; /* EXEC SQL VAR szhValTexto IS STRING(16); */ 

    /* EXEC SQL END   DECLARE SECTION       ; */ 

    
    /*  INDICADOR NIT OPERADORA   */
    strcpy(szhNomParametro,"NIT_OPERADORA");
	
    /* EXEC SQL 
         SELECT SUBSTR(VALOR_TEXTO,1,15)
         INTO :szhValTexto
         FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select SUBSTR(VALOR_TEXTO,1,15) into :b0  from FA_PARAMET\
ROS_SIMPLES_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1050;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhValTexto;
    sqlstm.sqhstl[0] = (unsigned long )16;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametro de Nit Operadora:[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametro de Nit Operadora",szfnORAerror ());
        return  (FALSE);
    }
    
    strcpy(pstDatosGener->szNitOperadora,szhValTexto);
    
    return (TRUE);
    
}/**************************** bGetNitOperadora ********************************/

/* -------------------------------------------------------------------------- */
/*   bGetClaConTecnico (DATOSGENER*)                                       */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetClaConTecnico (DATOSGENER* pstDatosGener)
{
    char    szmodulo[256] = "bGetClaConTecnico";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro IS STRING(21); */ 

         static char  szhValTexto [41]=""; /* EXEC SQL VAR szhValTexto IS STRING(41); */ 

    /* EXEC SQL END   DECLARE SECTION       ; */ 

    
    /*  INDICADOR CLAVE CONTENIDO TECNICO   */
    strcpy(szhNomParametro,"CLA_CONT_TECNICO");
	
    /* EXEC SQL 
         SELECT SUBSTR(VALOR_TEXTO,1,40)
         INTO :szhValTexto
         FROM FA_PARAMETROS_SIMPLES_VW
	 WHERE NOM_PARAMETRO = :szhNomParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select SUBSTR(VALOR_TEXTO,1,40) into :b0  from FA_PARAMET\
ROS_SIMPLES_VW where NOM_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1073;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhValTexto;
    sqlstm.sqhstl[0] = (unsigned long )41;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog(szmodulo, "\nError al obtener Parametro de Clave Contenido Técnico :[%s]\n", LOG02, szhNomParametro );
        iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Error al obtener Parametro de Clave Contenido Técnico",szfnORAerror ());
        return  (FALSE);
    }
    
    strcpy(pstDatosGener->szClaConTecnico,szhValTexto);
    
    return (TRUE);
    
}/**************************** bGetClaConTecnico ********************************/

/* -------------------------------------------------------------------------- */
/*   bGetTipDocNotaAbo (DATOSGENER*)                                             */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetTipDocNotaAbo (DATOSGENER* pstDatosGener)
{
	
    char    szmodulo[256] = "bGetTipDocNotaAbo";	
	
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

         char szhDesParametro[1025]; /* EXEC SQL VAR szhDesParametro  IS STRING(1025); */ 

         int  ihValParametro;
    /* EXEC SQL END   DECLARE SECTION  ; */ 


    memset(szhDesParametro,'\0',sizeof(szhDesParametro));
    
    strcpy(szhDesParametro,"DOCUMENTO NOTA DE ABONO");

    /* EXEC SQL 
         SELECT VAL_NUMERICO
         INTO   :ihValParametro
         FROM   FAD_PARAMETROS
         WHERE  DES_PARAMETRO = :szhDesParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_NUMERICO into :b0  from FAD_PARAMETROS where D\
ES_PARAMETRO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1096;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValParametro;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesParametro;
    sqlstm.sqhstl[1] = (unsigned long )1025;
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
    {
        vDTrazasLog(szmodulo, "\nError al obtener Parametro :[%s]\n", LOG02, szhDesParametro );    	
        iDError (szExeName,ERR000,vInsertarIncidencia,
                       "Open -> Fad_Parametros",szfnORAerror ());
        return  (FALSE)                              ;
    }
    
    pstDatosGener->iCodNotaAbo = ihValParametro;
    
    return (TRUE);
}/**************************** bGetTipDocNotaAbo ********************************/

/*****************************************************************************/
/*                          funcion : vPrintDatosGener                       */
/*****************************************************************************/
void vPrintDatosGener (void)
{
  vDTrazasLog (szExeName,"\n\t *** Datos Generales ***\n"
              "\n\t-- Agente Startel...... %ld"
              "\n\t-- Codigo Dollar........ %s"
              "\n\t-- Codigo UF............ %s"
              "\n\t-- Codigo Peso.......... %s"
              "\n\t-- Cliente Startel..... %ld"
              "\n\t-- Codigo Iva........... %d"
              "\n\t-- Path Bin ............ %s"
              "\n\t-- Direc.Reports ....... %s"
              "\n\t-- Directorio Log ...... %s"
              "\n\t-- Cod.Abono Celular.... %d"
              "\n\t-- Cod.Abono Beeper..... %d"
              "\n\t-- Cod.Abono Trek....... %d"
              "\n\t-- Cod.Abono Trunk...... %d"
              "\n\t-- Cod.Moneda Facturac.. %s"
              "\n\t-- Cod.Moneda Cobros.... %s"
              "\n\t-- Prod.Celular......... %d"
              "\n\t-- Prod.Beeper ......... %d"
              "\n\t-- Prod.Trek   ......... %d"
              "\n\t-- Prod.Trunk  ......... %d"
              "\n\t-- SisPago.Regalo ...... %d"
              "\n\t-- CauPago.Regalo ...... %d"
              "\n\t-- OriPago.Regalo ...... %d"
              ,LOG06,stDatosGener.lCodAgenteStartel
              ,stDatosGener.szCodDollar         ,stDatosGener.szCodUf
              ,stDatosGener.szCodPeso           ,stDatosGener.lCodClienteStartel
              ,stDatosGener.iCodIva             ,stDatosGener.szPathBin
              ,stDatosGener.szDirReports        ,stDatosGener.szDirLogs
              ,stDatosGener.iCodAbonoCel        ,stDatosGener.iCodAbonoBeep
              ,stDatosGener.iCodAbonoTrek       ,stDatosGener.iCodAbonoTrunk
              ,stDatosGener.szCodMoneFact       ,stDatosGener.szMonedaCobros
              ,stDatosGener.iProdCelular        ,stDatosGener.iProdBeeper
              ,stDatosGener.iProdTrek           ,stDatosGener.iProdTrunk
              ,stDatosGener.iSisPagoRegalo      ,stDatosGener.iCauPagoRegalo
              ,stDatosGener.iOriPagoRegalo);


}/*********************** Final vPrintDatosGener *****************************/

/* ---------------------------------------------------------------------------------*/
/* Nombre : bfnCargaParamError (Void)                                               */
/* Fecha Creación : 22-12-2005 - Fabián Aedo R.                                     */
/* Parametros:                                                  */
/* Descripción: Función que carga valores inciales a la estructura stStatus.        */
/*                                                                                  */
/* Modificación :                                                                   */
/* ---------------------------------------------------------------------------------*/
BOOL bfnCargaParamError(void)
{
int     iRes;
char    szTipParametro [33] ="";
char    szValParametro [512]="";
char    szmodulo[256] = "bfnCargaParamError";

    /*Carga de Tasa de exito minimo requerido*/

    iRes = ifnGetParametro(291,szTipParametro,szValParametro ) ;

    if (iRes != SQLNOTFOUND && iRes != SQLOK)
    {
        vDTrazasError(szmodulo,"\n\t** ERROR, al recuperar Tasa de exito minimo req. iRes [%d] SQLNOTFOUND [%d]**",LOG01,iRes, SQLNOTFOUND);
        return (FALSE);
    }

    stStatus.hTasaExitoMinReq = atoi (szValParametro);
    vDTrazasLog(szmodulo, "\nTasa de Exito Mínima Requerida:[%d]\n", LOG02, stStatus.hTasaExitoMinReq );


    /*Cantidad minima de Clientes para evaluación de tasa de exito*/

    iRes = ifnGetParametro(292,szTipParametro,szValParametro ) ;

    if (iRes != SQLNOTFOUND && iRes != SQLOK)
    {
        vDTrazasError(szmodulo,"\n\t** ERROR, Al recuperar Cant. minima de Clientes para eval. de tasa de exito iRes [%d] SQLNOTFOUND [%d]**",LOG01,iRes, SQLNOTFOUND);
        return (FALSE);
    }

    stStatus.lCantCliMinEval = atol (szValParametro);
    vDTrazasLog(szmodulo, "\nUniverso Mínimo para evaluación de Tasa de Exito Requerida:[%d]\n", LOG02, stStatus.lCantCliMinEval );


    /*Maximo de clientes consecutivos con error*/

    iRes = ifnGetParametro(293,szTipParametro,szValParametro ) ;

    if (iRes != SQLNOTFOUND && iRes != SQLOK)
    {
        vDTrazasError(szmodulo,"\n\t** ERROR, Al recuperar Cant. minima de Clientes para eval. de tasa de exito iRes [%d] SQLNOTFOUND [%d]**",LOG01,iRes, SQLNOTFOUND);
        return (FALSE);
    }

    stStatus.lMaxCliConsError = atol (szValParametro);
    vDTrazasLog(szmodulo, "\nCantidad máxima de Errores Consecutivos Permitada:[%d]\n", LOG02, stStatus.lMaxCliConsError );

    /*Seteo de Variable de registro*/
    stStatus.lCodCliErr = -1;
    stStatus.hTasaObservada = 0;
    stStatus.lConCliCons = 0;
    stStatus.lErrorReg = 0;

    return(TRUE);
}
/* -------------------------------------------------------------------------- */
/*   bActualizaIndFacCiclo ()                                                 */
/*   BOOL bActualizaIndFacCiclo(long lCodCiclFact,int iFrom, int iTo)         */
/* -------------------------------------------------------------------------- */

BOOL bActualizaIndFacCiclo(long lCodCiclFact,int iIndicador, char *szHostId, int iExisteRngClie, long lClieIni, long lClieFin)
{
    char szSysDate[20]="";
    char    szCadena [512]="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCiclFact = lCodCiclFact;
    long lhNumFacturas      ;
    long lhCodCliente = 0   ;
    int  ihCero = 0;
    int  ihUno = 1;
    int  ihNega = -9999 ;
    int  ihExisteRngClie = iExisteRngClie;
    long lhClieIni = lClieIni;
    long lhClieFin  = lClieFin;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName	,"\n\t* bActualizaIndFacCiclo: Parametros de entrada:"
                             "\n\t  lCodCiclFact		:[%ld]"
                             "\n\t  iIndicador			:[%d]"
                             "\n\t  szHostId			:[%s]"
                             "\n\t  iExisteRngClie		:[%d]"
                             "\n\t  lClieIni			:[%ld]"
                             "\n\t  lClieFin			:[%ld]"
    						,LOG06
    						,lCodCiclFact
    						,iIndicador
    						,szHostId
    						,iExisteRngClie
    						,lClieIni
    						,lClieFin);
    
    if (lCodCiclFact == -1) 
    	return TRUE;

    if (iIndicador == 1)
    {
        if (strcmp (szHostId, ""))
        {
            if (!bfnValidaTrazaProcHost(stCiclo.lCodCiclFact,iPROC_FACTURACION,iIND_FACT_ENPROCESO, szHostId))
            {
                iDError (szExeName,ERR000,vInsertarIncidencia,
                        "bfnValidaTrazaProcHost","Proceso no se puede lanzar");
                return  (FALSE);
            }
        }
        else
        {
            if (!bfnValidaTrazaProc(stCiclo.lCodCiclFact,iPROC_FACTURACION,iIND_FACT_ENPROCESO))
            {
                iDError (szExeName,ERR000,vInsertarIncidencia,
                        "bfnValidaTrazaProc","Proceso no se puede lanzar");
                return  (FALSE);
            }
        }
        return (TRUE);

    }

    memset(&stTrazaProc     ,0,sizeof(TRAZAPROC));
    bfnSelectTrazaProc ( stCiclo.lCodCiclFact,iPROC_FACTURACION,&stTrazaProc);
    bPrintTrazaProc(stTrazaProc);

    vDTrazasLog (szExeName,"\n\t* Verifica Actualizacion Indice de Facturacion",LOG03);

    ihCero = 0;
    ihUno = 1;
    ihNega = -9999 ;

    /* EXEC SQL    SELECT  COD_CLIENTE
                INTO    :lhCodCliente
                FROM    FA_CICLOCLI
                WHERE   COD_CICLO    = :stCiclo.iCodCiclo
                AND     IND_MASCARA  = :ihUno
                AND     NUM_PROCESO <= :ihCero
                AND     NUM_PROCESO >= :ihNega
                AND     ROWNUM       = :ihUno
                AND     ( (COD_CLIENTE BETWEEN :lhClieIni AND :lhClieFin) OR (1 <> :ihExisteRngClie) ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 39;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CLIENTE into :b0  from FA_CICLOCLI where (((((\
COD_CICLO=:b1 and IND_MASCARA=:b2) and NUM_PROCESO<=:b3) and NUM_PROCESO>=:b4)\
 and ROWNUM=:b2) and (COD_CLIENTE between :b6 and :b7 or 1<>:b8))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1119;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&(stCiclo.iCodCiclo);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihNega;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhClieIni;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhClieFin;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihExisteRngClie;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
          iDError ("bActualizaIndFacCiclo", ERR000, vInsertarIncidencia,
                   "Select=> Fa_CicloCli (bValidaFinCiclo)", szfnORAerror ());
          return  (FALSE);
    }

  /*if (SQLCODE == SQLOK && SQLROWS > 0 && lhCodCliente > 0) */
    if (SQLCODE == SQLOK)
    {
        vDTrazasLog (szExeName,"\n\t* (%s), Linea (%d) bActualizaIndFacCiclo(): SQLCODE == SQLOK",LOG03, __FILE__, __LINE__);
        return TRUE;
    }
    
    if (!bfnSelectSysDate(szSysDate))
    {
        vDTrazasLog(szExeName,"\n\t*** Error en bfnSelectSysDate (bActualizaIndFacCiclo) ***\n",LOG01);
        iDError ("bActualizaIndFacCiclo",ERR000,vInsertarIncidencia,"bfnSelectSysDate",szfnORAerror ());
        return FALSE;
    }
    else
    {
        sprintf(szCadena,"SELECT COUNT(COD_CLIENTE) FROM FA_FACTDOCU_%ld ",lhCodCiclFact);

        vDTrazasLog (szExeName,"\n\t* Query Cuenta [%s] ",LOG03,szCadena);

        /* EXEC SQL PREPARE sql_count_facturas FROM :szCadena; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 39;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1170;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (SQLCODE)
        {
            vDTrazasError(szExeName,"\n\t**  Error en SQL-PREPARE sql_count_facturas **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            iDError ("bActualizaIndFacCiclo", ERR000, vInsertarIncidencia,
                     "Select=> Count Fa_FactDocu (bValidaFinCiclo)", szfnORAerror ());
            return  (FALSE);

        }

        /* EXEC SQL DECLARE cur_count_facturas CURSOR FOR sql_count_facturas; */ 

        if (SQLCODE)
        {
            vDTrazasError(szExeName,"\n\t**  Error en SQL-DECLARE sql_count_facturas **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            iDError ("bActualizaIndFacCiclo", ERR000, vInsertarIncidencia,
                     "Select=> Count Fa_FactDocu (bValidaFinCiclo)", szfnORAerror ());
            return  (FALSE);

        }

        /* EXEC SQL OPEN cur_count_facturas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 39;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1189;
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
            vDTrazasError(szExeName,"\n\t**  Error en SQL-OPEN CURSOR sql_count_facturas **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            iDError ("bActualizaIndFacCiclo", ERR000, vInsertarIncidencia,
                     "Select=> Count Fa_FactDocu (bValidaFinCiclo)", szfnORAerror ());
            return  (FALSE);
        }

        /* EXEC SQL FETCH cur_count_facturas  INTO :lhNumFacturas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 39;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1204;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFacturas;
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


        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasError(szExeName,"\n\t**  Error en SQL-FETCH sql_count_facturas **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            iDError ("bActualizaIndFacCiclo", ERR000, vInsertarIncidencia,
                     "Select=> Count Fa_FactDocu (bValidaFinCiclo)", szfnORAerror ());
            return  (FALSE);
        }

        /* EXEC SQL CLOSE cur_count_facturas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 39;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1223;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        vDTrazasLog (szExeName,"\n\t* Actualiza Traza de Proceco ",LOG03);

        stTrazaProc.lCodCiclFact       = lCodCiclFact                           ;
        stTrazaProc.iCodProceso        = iPROC_FACTURACION                      ;
        stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
        strcpy(stTrazaProc.szFecTermino,szSysDate)                              ;
        strcpy(stTrazaProc.szGlsProceso,"Proceso de Facturacion de Ciclo Terminado OK");
        stTrazaProc.lCodCliente        = 0                                      ;
        stTrazaProc.lNumAbonado        = 0                                      ;
        stTrazaProc.lNumRegistros      = lhNumFacturas                          ;
        bPrintTrazaProc(stTrazaProc)                                            ;


    	if (strcmp (szHostId, ""))
    	{
        	if (!bfnUpdateTrazaProcHost(stTrazaProc, szHostId))
        	{
        	    iDError ("bActualizaIndFacCiclo",ERR000,vInsertarIncidencia,
        	        "bfnUpdateTrazaProcHost",szfnORAerror ());
        	    return FALSE;
        	}
    	}
    	else
    	{
        	if (!bfnUpdateTrazaProc(stTrazaProc))
        	{
        	    iDError ("bActualizaIndFacCiclo",ERR000,vInsertarIncidencia,
        	        "bfnUpdateTrazaProc",szfnORAerror ());
        	    return FALSE;
        	}
    	}

    }
    return TRUE;
}/**************************** Final bActualizaIndFacCiclo *******************/


/*****************************************************************************/
/*                          funcion : iCmpConceptos                          */
/*     -Funcion de Comparacion                           */
/*****************************************************************************/
/*int iCmpConceptos (const void* cad1, const void* cad2)
{
    int rc = 0;

    return
    ( (rc = ((CONCEPTO *)cad1)->iCodConcepto-
            ((CONCEPTO *)cad2)->iCodConcepto) != 0)?rc:0;
}*//************************** Final iCmpConceptos *****************************/

/*****************************************************************************/
/*                          funcion : iCmpConceptos_mi                       */
/*     -Funcion de Comparacion                                               */
/*     CDescouv 27-03-2002                                                   */
/*****************************************************************************/
int iCmpConceptos_mi (const void* cad1, const void* cad2)
{
    int rc = 0;

    return
    ( (rc = ((CONCEPTO_MI *)cad1)->iCodConcepto-
            ((CONCEPTO_MI *)cad2)->iCodConcepto) != 0)?rc:0;
}/************************** Final iCmpConceptos_mi **************************/

/*****************************************************************************/
/*                           funcion : bFindConcepto_mi                      */
/* -Funcion que busca en memoria                                             */
/* (CONCEPTO_MI* pstConceptos_mi->global) un reg.                            */
/* -Entrada iCodConcepto_mi,  CONCEPTO_MI*                                         */
/* -Salida  Error->FALSE, !Error->TRUE                                       */
/*  Creado para soportar la funcionalidad del Multiidioma                    */
/*  CDescouv 28-03-2002                                                      */
/*****************************************************************************/
BOOL bFindConcepto_mi (int iCodConcepto_mi,char* szCodIdioma_mi,CONCEPTO_MI *pstConcepto_mi)
{
  int  j    = 0    ;
  int  i    = 0    ;
  BOOL bEnc = FALSE;

  vDTrazasLog (szExeName,"\n\t\t* Parametro de Entrada Fa_Conceptos_mi"
                         "\n\t\t=>Cod.Concepto [%d]", LOG05, iCodConcepto_mi);

  while (!bEnc && j<stIndConcepto_mi.iNumRangos)
  {
    vDTrazasLog(szExeName,"\n\tRango inicial........[%d] "
                          "\n\tRango Final..........[%d] "
                          "\n\tIndice Inicial.......[%d] "
                          "\n\tIndice Final..........[%d] "
                          "\n\tNum Rangos...........[%d]\n "
                           ,LOG06, stIndConcepto_mi.pRangoConcepto [j].iCodConcIni,
                                   stIndConcepto_mi.pRangoConcepto [j].iCodConcFin,
                                   stIndConcepto_mi.pRangoConcepto [j].iIndInicial,
                                   stIndConcepto_mi.pRangoConcepto [j].iIndFinal,
                                   stIndConcepto_mi.iNumRangos);


    if (stIndConcepto_mi.pRangoConcepto [j].iCodConcIni <= iCodConcepto_mi &&
        stIndConcepto_mi.pRangoConcepto [j].iCodConcFin >= iCodConcepto_mi)
    {
        bEnc = TRUE;
        vDTrazasLog (szExeName,"\n\n\t** Encontro rango GE_MULTIIDIOMA **\n",LOG06);

    }
    else
    {
       j++;
       vDTrazasLog (szExeName,"\n\n\t** No Encontro rango GE_MULTIIDIOMA **\n",LOG06);

    }
  }
  if (bEnc)
  {
      bEnc = FALSE;

      for (i = stIndConcepto_mi.pRangoConcepto [j].iIndInicial;
           i<= stIndConcepto_mi.pRangoConcepto [j].iIndFinal  ;i++)
      {
          vDTrazasLog(szExeName,"\n\tConcepto i.......[%d] "
                                "\n\tConcepto.........[%d] "
                                "\n\tIdioma i ........[%s] "
                                "\n\tIdioma...........[%s]\n "
                                ,LOG09,pstConceptos_mi [i].iCodConcepto,iCodConcepto_mi,
                                 pstConceptos_mi [i].szCodIdioma,szCodIdioma_mi );

          if (pstConceptos_mi [i].iCodConcepto == iCodConcepto_mi &&
              strcmp(pstConceptos_mi [i].szCodIdioma,szCodIdioma_mi) == 0)
          {
              memcpy (pstConcepto_mi,&pstConceptos_mi [i],sizeof(CONCEPTO_MI));
              bEnc = TRUE;
              break;
          }
      }
  }
  vDTrazasLog (szExeName,"\n\t Finalizo bFindConcepto_mi ",LOG05);
  return(bEnc);
}/************************* Final bFindConcepto_mi ***************************/

/*****************************************************************************/
/*                           funcion : bFindConcepto                         */
/* -Funcion que busca en memoria (CONCEPTO* pstConceptos->global) un reg.    */
/* -Entrada iCodConcepto, iCodProducto, CONCEPTO*                            */
/* -Salida  Error->FALSE, !Error->TRUE                                       */
/* Modificacion de Funcion agregando funcionalidad de Multiidioma            */
/* se agrega funcion bFindConcepto_mi para las glosas multiidioma            */
/* CDescouv 28-08-2002                                                       */
/*****************************************************************************/
BOOL bFindConcepto (int iCodConcepto,CONCEPTO *pstConcepto)
{
  BOOL bEnc = FALSE;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  int   ihCodProducto   ;
  int   ihCodTipConce   ;
  int   ihIndActivo     ;
  char *pszhCodMoneda   ;/* EXEC SQL VAR pszhCodMoneda   IS STRING (4) ; */ 

  int   ihCodConcOrig   ;
  char *pszhDesConcepto ;/* EXEC SQL VAR pszhDesConcepto IS STRING (61); */ 

  char *pszhCodModulo   ;/* EXEC SQL VAR pszhCodModulo   IS STRING (3) ; */ 

  char *pszhCodTipDescu ;/* EXEC SQL VAR pszhCodTipDescu IS STRING (2) ; */ 

  int   ihCodConcepto   ;
  short i_shCodConcOrig ;
  short i_shCodTipDescu ;
  char pszhNomTabla [31];/* EXEC SQL VAR pszhNomTabla IS STRING (31) ; */ 

  char pszhNomCampo [21];/* EXEC SQL VAR pszhNomCampo IS STRING (21) ; */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


   CONCEPTO_MI stConceptoTemp;
  memset (&stConceptoTemp,0,sizeof(CONCEPTO_MI));
  

  	vDTrazasLog (szExeName,"\n\t\t* Parametro de Entrada Fa_Conceptos"
                           "\n\t\t=>Cod.Concepto [%d]"
                           "\n\t\t=>Cod.Idioma   [%s]"
                           , LOG05, iCodConcepto,stCliente.szCodIdioma);

	vDTrazasLog(szExeName,"\n\t\tFlag Existe ..........[%d]"
					      "\n\t\tCod.Concepto..........[%d]"
	                      "\n\t\tCod.Producto..........[%d]"
	                      "\n\t\tDes.Concepto..........[%s]"
	                      "\n\t\tCod.Tipo de Concepto..[%d]"
	                      "\n\t\tCod.Modulo............[%s]"
	                      "\n\t\tCod.Moneda..... ......[%s]"
	                      "\n\t\tInd.Activo............[%d]"
	                      "\n\t\tiCodConCobr...........[%d]"
	                      "\n\t\tlFactor..............[%ld]"
	                      ,LOG06
	                      ,pstConceptos[iCodConcepto].iFlagExiste
	                      ,iCodConcepto
	                      ,pstConceptos[iCodConcepto].iCodProducto
	                      ,pstConceptos[iCodConcepto].szDesConcepto
	                      ,pstConceptos[iCodConcepto].iCodTipConce
	                      ,pstConceptos[iCodConcepto].szCodModulo
	                      ,pstConceptos[iCodConcepto].szCodMoneda
	                      ,pstConceptos[iCodConcepto].iIndActivo
	                      ,pstConceptos[iCodConcepto].iCodConCobr
	                      ,pstConceptos[iCodConcepto].lFactor
	                      );
    
    bEnc = FALSE;

  if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
  {
      if (pstConceptos[iCodConcepto].iFlagExiste ==  1)
      	{
			memcpy (pstConcepto,&pstConceptos[iCodConcepto],sizeof(CONCEPTO));
			if (strcmp(stCliente.szCodIdioma,pstParamGener.szCodIdioma)!=0)
           	{
		    	vDTrazasLog (szExeName,"\n\t distintos idiomas ",LOG06);
		              	
		        if (bFindConcepto_mi (iCodConcepto,stCliente.szCodIdioma,&stConceptoTemp))
		        {
		            strcpy(pstConcepto->szDesConcepto, stConceptoTemp.szDesConcepto);
		            bEnc = TRUE;
		        }
		        else
		        {
                	iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos_mi");
                	bEnc =FALSE;
              	}
	        }
	        else
	        {
           	 	bEnc = TRUE;
           	}
      	}
  }
  else
  {
      ihCodConcepto     = iCodConcepto              ;
      pszhDesConcepto   = pstConcepto->szDesConcepto;
      pszhCodModulo     = pstConcepto->szCodModulo  ;
      pszhCodTipDescu   = pstConcepto->szCodTipDescu;
      pszhCodMoneda     = pstConcepto->szCodMoneda  ;

      sprintf (pszhNomTabla, "FA_CONCEPTOS");
      sprintf (pszhNomCampo, "COD_CONCEPTO");

      /* EXEC SQL SELECT /o+ index (FA_CONCEPTOS PK_FA_CONCEPTOS) o/
                      A.COD_PRODUCTO,
                      B.DES_CONCEPTO,
                      A.COD_TIPCONCE,
                      A.COD_MODULO  ,
                      A.IND_ACTIVO  ,
                      A.COD_MONEDA  ,
                      A.COD_CONCORIG,
                      A.COD_TIPDESCU
                 INTO :ihCodProducto  ,
                      :pszhDesConcepto,
                      :ihCodTipConce  ,
                      :pszhCodModulo  ,
                      :ihIndActivo    ,
                      :pszhCodMoneda  ,
                      :ihCodConcOrig  :i_shCodConcOrig,
                      :pszhCodTipDescu:i_shCodTipDescu
                  FROM FA_CONCEPTOS a,GE_MULTIIDIOMA b
                 WHERE b.NOM_TABLA = :pszhNomTabla
                   AND b.NOM_CAMPO = :pszhNomCampo
                   AND a.COD_CONCEPTO = b.COD_CONCEPTO
                   AND a.COD_PRODUCTO = b.COD_PRODUCTO
                   AND b.COD_IDIOMA   = :stCliente.szCodIdioma
                   AND a.COD_CONCEPTO = :ihCodConcepto; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (FA_CONCEPTOS PK_FA_CONCEPTOS)  +*/ \
A.COD_PRODUCTO ,B.DES_CONCEPTO ,A.COD_TIPCONCE ,A.COD_MODULO ,A.IND_ACTIVO ,A.\
COD_MONEDA ,A.COD_CONCORIG ,A.COD_TIPDESCU into :b0,:b1,:b2,:b3,:b4,:b5,:b6:b7\
,:b8:b9  from FA_CONCEPTOS a ,GE_MULTIIDIOMA b where (((((b.NOM_TABLA=:b10 and\
 b.NOM_CAMPO=:b11) and a.COD_CONCEPTO=b.COD_CONCEPTO) and a.COD_PRODUCTO=b.COD\
_PRODUCTO) and b.COD_IDIOMA=:b12) and a.COD_CONCEPTO=:b13)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1238;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProducto;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)pszhDesConcepto;
      sqlstm.sqhstl[1] = (unsigned long )61;
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
      sqlstm.sqhstv[3] = (unsigned char  *)pszhCodModulo;
      sqlstm.sqhstl[3] = (unsigned long )3;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&ihIndActivo;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)pszhCodMoneda;
      sqlstm.sqhstl[5] = (unsigned long )4;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcOrig;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)&i_shCodConcOrig;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)pszhCodTipDescu;
      sqlstm.sqhstl[7] = (unsigned long )2;
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)&i_shCodTipDescu;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)pszhNomTabla;
      sqlstm.sqhstl[8] = (unsigned long )31;
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)pszhNomCampo;
      sqlstm.sqhstl[9] = (unsigned long )21;
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)(stCliente.szCodIdioma);
      sqlstm.sqhstl[10] = (unsigned long )6;
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)&ihCodConcepto;
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


      if (SQLCODE)
      {
          bEnc = FALSE;
      }
      else
      {
          bEnc = TRUE ;

          pstConcepto->iCodProducto = ihCodProducto ;
          pstConcepto->iCodTipConce = ihCodTipConce ;
          pstConcepto->iIndActivo   = ihIndActivo   ;

          pstConcepto->iCodConcOrig =(i_shCodConcOrig == -1)?-1:ihCodConcOrig ;

          if ( i_shCodTipDescu  == -1)
               pstConcepto->szCodTipDescu [0] = 0;
      }
  }
  if (!bEnc)
  {
      stAnomProceso.iCodConcepto = iCodConcepto;

      if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
          iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
      else
          iDError (szExeName,ERR000,vInsertarIncidencia,"Select=> Fa_Conceptos",
                   szfnORAerror ());
  }
  vDTrazasLog (szExeName,"\n\t Finalizo bFindConcepto ",LOG05);
  return (bEnc);
}/************************* Final bFindConcepto ******************************/

/*****************************************************************************/
/*                       funcion : bConverMoneda                             */
/* -Funcion que aplica el cambio vigente segun max(fec_valor) sobre el cod.  */
/*  moneda que pasa por parametro                                            */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bConverMoneda (char   *szCodMonedaO,
                    char   *szCodMonedaD,
                    char   *szFecha     ,
                    double *dImporte    ,
                    int    iCodTipDocum)
{
  BOOL bRes = TRUE;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char   *szhFecha     ;/* EXEC SQL VAR szhFecha      IS STRING(15); */ 

  static char   *szhCodMonedaO;/* EXEC SQL VAR szhCodMonedaO IS STRING(4) ; */ 

  static char   *szhCodMonedaD;/* EXEC SQL VAR szhCodMonedaD IS STRING(4) ; */ 

  static double  dhCambioO    ;
  static double  dhCambioD    ;

  char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 


  /* EXEC SQL END DECLARE SECTION; */ 


  dhCambioD = 0.0;
  dhCambioO = 0.0;
  
  
  vDTrazasLog (szExeName, "\n\t\t* Parametros para Conversion Moneda\n"
                          "\t\t* Moneda Origen  [%s]\n"
                          "\t\t* Moneda Destino [%s]\n"
                          "\t\t* Fecha Valor    [%s]\n"
                          "\t\t* Valor Origen   [%10.4f]\n"
                          "\t\t* Tipo Documento [%d]\n"
                        , LOG04
                        , szCodMonedaO,szCodMonedaD,szFecha,*dImporte,iCodTipDocum);
  

  if (strcmp (szCodMonedaO,szCodMonedaD)!= 0)
  {
      if (iCodTipDocum == stDatosGener.iCodCiclo)
      {
          if (!bFindConversion (szCodMonedaO,szFecha,&dhCambioO))
               bRes = FALSE;
          if (!bFindConversion (szCodMonedaD,szFecha,&dhCambioD))
               bRes = FALSE;
      }
      else
      {
         szhFecha      = szFecha     ;
         szhCodMonedaO = szCodMonedaO;
         szhCodMonedaD = szCodMonedaD;

        sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

         /* EXEC SQL SELECT /o+ index (GE_CONVERSION PK_GE_CONVERSION) o/
                         CAMBIO
                  INTO   :dhCambioO
                  FROM   GE_CONVERSION
                  WHERE  COD_MONEDA = :szhCodMonedaO
                    AND  FEC_DESDE <= TO_DATE (:szhFecha,:szhFmtFecha)
                    AND  FEC_HASTA >= TO_DATE (:szhFecha,:szhFmtFecha); */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 39;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "select  /*+  index (GE_CONVERSION PK_GE_CONVERSION) \
 +*/ CAMBIO into :b0  from GE_CONVERSION where ((COD_MONEDA=:b1 and FEC_DESDE<\
=TO_DATE(:b2,:b3)) and FEC_HASTA>=TO_DATE(:b2,:b3))";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1301;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&dhCambioO;
         sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)szhCodMonedaO;
         sqlstm.sqhstl[1] = (unsigned long )4;
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
         sqlstm.sqhstv[3] = (unsigned char  *)szhFmtFecha;
         sqlstm.sqhstl[3] = (unsigned long )17;
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
         sqlstm.sqhstv[5] = (unsigned char  *)szhFmtFecha;
         sqlstm.sqhstl[5] = (unsigned long )17;
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


         if (SQLCODE == SQLOK)
         {
             /* EXEC SQL SELECT /o+ index (GE_CONVERSION PK_GE_CONVERSION) o/
                             CAMBIO
                      INTO   :dhCambioD
                      FROM   GE_CONVERSION
                      WHERE  COD_MONEDA = :szhCodMonedaD
                        AND  FEC_DESDE <= TO_DATE(:szhFecha,:szhFmtFecha)
                        AND  FEC_HASTA >= TO_DATE(:szhFecha,:szhFmtFecha); */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 39;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.stmt = "select  /*+  index (GE_CONVERSION PK_GE_CONVERSI\
ON)  +*/ CAMBIO into :b0  from GE_CONVERSION where ((COD_MONEDA=:b1 and FEC_DE\
SDE<=TO_DATE(:b2,:b3)) and FEC_HASTA>=TO_DATE(:b2,:b3))";
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )1340;
             sqlstm.selerr = (unsigned short)1;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqhstv[0] = (unsigned char  *)&dhCambioD;
             sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
             sqlstm.sqhsts[0] = (         int  )0;
             sqlstm.sqindv[0] = (         short *)0;
             sqlstm.sqinds[0] = (         int  )0;
             sqlstm.sqharm[0] = (unsigned long )0;
             sqlstm.sqadto[0] = (unsigned short )0;
             sqlstm.sqtdso[0] = (unsigned short )0;
             sqlstm.sqhstv[1] = (unsigned char  *)szhCodMonedaD;
             sqlstm.sqhstl[1] = (unsigned long )4;
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
             sqlstm.sqhstv[3] = (unsigned char  *)szhFmtFecha;
             sqlstm.sqhstl[3] = (unsigned long )17;
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
             sqlstm.sqhstv[5] = (unsigned char  *)szhFmtFecha;
             sqlstm.sqhstl[5] = (unsigned long )17;
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
         if (SQLCODE != SQLOK)
             bRes = FALSE;
      }

      if (bRes)
          *dImporte *= (double)dhCambioO/dhCambioD;
      else
      {
          if (SQLCODE != SQLOK)
              iDError (szExeName,ERR000,vInsertarIncidencia,
                       "Select->(Ge_Conversion)",szfnORAerror());
      }
  }
  vDTrazasLog (szExeName,"\n\t\t* Valor Convertido en bConverMoneda  [%10.4f]\n", LOG04,*dImporte);
  return (bRes);
}/********************** Final bConverMoneda *********************************/

/*****************************************************************************/
/* FUNCION     : bfnConversionMonetaria                                      */
/* DESCRIPCION : Aplica el cambio de acuerdo a Cod. Categoria del Cliente    */
/*               (Tabla GE_CLIENTE_TASA_TO)  y la Tabla FA_TASA_CAMBIO_TD    */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bConversionMoneda (long   lCodCliente    ,
                        char   *szCodMonedaO  ,
                        char   *szCodMonedaD  ,
                        char   *szFecha       ,
                        double *dImporte)                       
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long          lhCodCliente          ;
         double        dhImporteOrigen       ;
         double        dhImporteConver       ;         
         char          szhFmtFecha     [17]  ; /* EXEC SQL VAR szhFmtFecha   IS STRING(17); */ 

         long          lhCodMsgError         ;/* Recibe el codigo de error de la PL */         
         char          szhDetMsgError [200+1];/* EXEC SQL VAR szhDetMsgError IS STRING(200+1); */ 
/* Recibe mensaje error */
         long          lhNumEvento           ;/* Recibe numero del evento del error */     
    /* EXEC SQL END DECLARE SECTION; */ 

    
    dhImporteConver = 0.0;  
    lhCodMsgError   = 0;
    lhNumEvento     = 0;   
    memset(szhDetMsgError,'\0',sizeof(szhDetMsgError));
    
    lhCodCliente    = lCodCliente;
    dhImporteOrigen = *dImporte;
    
    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");
    
       
  
    vDTrazasLog (szExeName, "\n\t* Parametros para Conversion Monetaria *\n"
                            "\t========================================\n"
                          "\t\t=> Codigo Cliente [%ld]\n"
                          "\t\t=> Moneda Origen  [%s]\n"
                          "\t\t=> Moneda Destino [%s]\n"
                          "\t\t=> Fecha Valor    [%s]\n"
                          "\t\t=> Valor Origen   [%10.4f]\n"
                        , LOG04
                        , lhCodCliente, szCodMonedaO, szCodMonedaD, szFecha, *dImporte);
  

    if ( strcmp (szCodMonedaO,szCodMonedaD)!= 0)
    {
         /* Seteando Lenguaje Base de Datos (temporal)*/    
         /* EXEC SQL
              ALTER SESSION SET NLS_LANGUAGE=SPANISH; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 39;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "alter SESSION SET NLS_LANGUAGE = SPANISH";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1379;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


              
         if(SQLCODE != SQLOK)
         {
            vDTrazasLog    (szExeName, "\n**  Error en ALTER SESSION SET NLS_LANGUAGE=SPANISH **", LOG01);
         }
         
         /* Llamada package de Conversion Monetaria */     
         /* EXEC SQL EXECUTE
          BEGIN
              GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR ( :lhCodCliente,
                                                                 :dhImporteOrigen,
                                                                 :szFecha,
                                                                 :dhImporteConver,
                                                                 :lhCodMsgError,
                                                                 :szhDetMsgError,
                                                                 :lhNumEvento);
              EXCEPTION
                      WHEN OTHERS THEN
                           :lhCodMsgError := -1;
                           :szhDetMsgError:= 'Se ha producido un Error en la llamada.';
          END;
         END-EXEC; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 39;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "begin GA_CONVERSION_MONETARIA_PG . GA_CONVIERTE_MONT\
O_PR ( :lhCodCliente , :dhImporteOrigen , :szFecha , :dhImporteConver , :lhCod\
MsgError , :szhDetMsgError , :lhNumEvento ) ; EXCEPTION WHEN OTHERS THEN :lhCo\
dMsgError := -1 ; :szhDetMsgError := 'Se ha producido un Error en la llamada.'\
 ; END ;";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1394;
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
         sqlstm.sqhstv[1] = (unsigned char  *)&dhImporteOrigen;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)szFecha;
         sqlstm.sqhstl[2] = (unsigned long )0;
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&dhImporteConver;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lhCodMsgError;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)szhDetMsgError;
         sqlstm.sqhstl[5] = (unsigned long )201;
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)&lhNumEvento;
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

                                     

         if(lhCodMsgError != 0)
         {
              vDTrazasError  ( szExeName ,"\n**  Error en Package GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR( ) **"
                                 " [%d]  [%s]",LOG01,SQLCODE,SQLERRM);

              vDTrazasLog    (szExeName, "\n**  Error en Package GA_CONVERSION_MONETARIA_PG.GA_CONVIERTE_MONTO_PR( ) **"
                                       "\n\t\t\t=> lhCodCliente.............[%ld]"
                                       "\n\t\t\t=> Monto Convertido..........[%f]"
                                       "\n\t\t\t=> lhCodMsgError............[%ld]"
                                       "\n\t\t\t=> szhDetMsgError............[%s]"
                                       "\n\t\t\t=> lhNumEvento..............[%ld]"
                                       "\n\t\t\t=> SQLCODE...................[%d]"                                       
                                       ,LOG01,lhCodCliente, dhImporteConver, lhCodMsgError,szhDetMsgError
                                       ,lhNumEvento, SQLCODE);

              return(FALSE);
         }        	        	      	        	
         
         *dImporte = dhImporteConver;
    
         vDTrazasLog (szExeName,"\n\t\t*** Valor Convertido en Conversion Monetaria  [%10.4f] ***\n", LOG04,*dImporte);         
    }
    else
    {
         vDTrazasLog (szExeName,"\n\t\t* No aplica Conversion Monetaria (monedas iguales) \n", LOG06);             	
    }
    
    return (TRUE);
    
}/********************** Final bConversionMoneda *********************************/

/*****************************************************************************/
/*                          funcion : iCmpZonaCiudadFec                      */
/* -Funcion de Comparacion                                                   */
/*****************************************************************************/
int iCmpZonaCiudadFec (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szCodRegion,
                    ((ZONACIUDAD *)cad2)->szCodRegion ))    != 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szCodProvincia,
                    ((ZONACIUDAD *)cad2)->szCodProvincia )) != 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szCodCiudad,
                    ((ZONACIUDAD *)cad2)->szCodCiudad ))    != 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szFecDesde,
                    ((ZONACIUDAD *)cad2)->szFecDesde ))      < 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szFecHasta,
                    ((ZONACIUDAD *)cad2)->szFecHasta ))      >= 0)?rc:0;

}/************************* Final iCmpZonaCiudadFec **************************/

/*****************************************************************************/
/*                          funcion : iCmpZonaCiudad                         */
/* -Funcion de Comparacion                                                   */
/*****************************************************************************/
int iCmpZonaCiudad (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szCodRegion,
                    ((ZONACIUDAD *)cad2)->szCodRegion ))    != 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szCodProvincia,
                    ((ZONACIUDAD *)cad2)->szCodProvincia )) != 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szCodCiudad,
                    ((ZONACIUDAD *)cad2)->szCodCiudad ))    != 0)?rc:
   ( (rc = strcmp ( ((ZONACIUDAD *)cad1)->szFecDesde,
                    ((ZONACIUDAD *)cad2)->szFecDesde )) < 0)?rc:0;

}/************************* Final iCmpZonaCiudad *****************************/

/*****************************************************************************/
/*                        funcion : bFindZonaCiudad                          */
/*****************************************************************************/
BOOL bFindZonaCiudad(char *szCodRegion  ,char *szCodProvincia,char *szCodCiudad,
                     char *szFecZonaImpo,int  *piCodZonaImpo)
{
  ZONACIUDAD stkey;
  ZONACIUDAD *pZona = (ZONACIUDAD *)NULL;
  BOOL bRes = TRUE;

  strcpy (stkey.szCodRegion   ,szCodRegion   );
  strcpy (stkey.szCodProvincia,szCodProvincia);
  strcpy (stkey.szCodCiudad   ,szCodCiudad   );
  strcpy (stkey.szFecDesde    ,szFecZonaImpo );
  strcpy (stkey.szFecHasta    ,szFecZonaImpo );

  if ( (pZona = (ZONACIUDAD *)bsearch(&stkey,pstZonaCiudad,NUM_ZONACIUDAD,
                 sizeof(ZONACIUDAD),iCmpZonaCiudadFec) )==(ZONACIUDAD *)NULL)
  {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstZonaCiudad");
        bRes = FALSE;
  }
  else
     *piCodZonaImpo = pZona->iCodZonaImpo;

  return (bRes);

}/************************ Final bFindZonaCiudad *****************************/

/*****************************************************************************/
/*                         funcion : iCmpGrpSerConc                          */
/* -Funcion de Comparacion                                                   */
/*****************************************************************************/
int iCmpGrpSerConc (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
       ( (rc = ((GRPSERCONC *)cad1)->iCodConcepto-
               ((GRPSERCONC *)cad2)->iCodConcepto) != 0)?rc:
       ( (rc = strcmp (((GRPSERCONC *)cad1)->szFecDesde,
                       ((GRPSERCONC *)cad2)->szFecDesde)) < 0)?rc:
       ( (rc = strcmp (((GRPSERCONC *)cad1)->szFecHasta,
                       ((GRPSERCONC *)cad2)->szFecHasta)) > 0)?rc:0;
}/*********************** Final iCmpGrpSerConc *******************************/

/*****************************************************************************/
/*                        funcion : vPrintGrpSerConc                         */
/*****************************************************************************/
void vPrintGrpSerConc (GRPSERCONC *pGrp,int iNumGrp)
{
    int iInd = 0;
    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t*** Tabla FA_GRPSERCONC ***",LOG06);
        for (iInd=0;iInd<NUM_GRPSERCONC;iInd++)
        {
            vDTrazasLog (szExeName,"\t[%d]-Cod.Concepto..........[%d]"
                                   "\t[%d]-Fec.Desde.............[%s]"
                                   "\t[%d]-Cod.Grupo Servicio....[%d]"
                                   "\t[%d]-Fec.Hasta.............[%s]"
                                   ,LOG06,iInd,pGrp->iCodConcepto
                                   ,iInd,pGrp->szFecDesde       ,iInd,pGrp->iCodGrpServi
                                   ,iInd,pGrp->szFecHasta);

            pGrp++;
        }
    }
}/************************ Final vPrintGrpSerConc ****************************/


/*****************************************************************************/
/*                         funcion : bFindGrpSerConc                         */
/*****************************************************************************/
BOOL bFindGrpSerConc (int iCodConcepto, GRPSERCONC *pGrpS)
{

    if ( pstConceptos[iCodConcepto].iFlagExiste == 1 )
    {  	
        pGrpS->iCodGrpServi = pstConceptos[iCodConcepto].iCodGrpServi;
        vDTrazasLog(szExeName, "\t\tGrupo de servicio [%d] encontrado", LOG04, pGrpS->iCodGrpServi);
    }else{
        vDTrazasLog(szExeName, "Grupo de servicio para el concepto [%d] no encontrado ", LOG01, iCodConcepto);
        return FALSE;
    }

  return (TRUE);
}/************************* bFindGrpSerConc **********************************/

/*****************************************************************************/
/*                          funcion : iCmpConversion                         */
/*****************************************************************************/
int iCmpConversion (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = strcmp ( ((CONVERSION *)cad1)->szCodMoneda,
                    ((CONVERSION *)cad2)->szCodMoneda) )!= 0)?rc:
   ( (rc = strcmp ( ((CONVERSION *)cad1)->szFecDesde,
                    ((CONVERSION *)cad2)->szFecDesde ) ) < 0)?rc:
   ( (rc = strcmp ( ((CONVERSION *)cad1)->szFecHasta ,
                    ((CONVERSION *)cad2)->szFecHasta ) ) > 0)?rc:0;
}/************************ iCmpConversion ************************************/

/*****************************************************************************/
/*                         funcion : bFindConversion                         */
/*****************************************************************************/
BOOL bFindConversion (char *szCodMoneda,char *szFecha,double *dCambio)
{
  CONVERSION stkey;
  CONVERSION *pConv = (CONVERSION *)NULL;


  memset (&stkey,0,sizeof(CONVERSION));

  strcpy (stkey.szCodMoneda,szCodMoneda);
  strcpy (stkey.szFecDesde ,szFecha    );
  strcpy (stkey.szFecHasta ,szFecha    );

  if ((pConv = (CONVERSION *)bsearch (&stkey,pstConversion,NUM_CONVERSION,
                sizeof(CONVERSION),iCmpConversion))==(CONVERSION *)NULL)
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstConversion");
       return FALSE;
  }
  *dCambio = pConv->dCambio;
  return TRUE;

}/************************* bFindConversion **********************************/

/*****************************************************************************/
/*                        funcion : vPrintConversion                         */
/*****************************************************************************/
void vPrintConversion (CONVERSION *pConver,int iInd)
{
    int i = 0;
    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t*** Tabla GE_CONVERSION ***\n",LOG06);

        for (i=0;i<iInd;i++)
        {
            vDTrazasLog (szExeName, "\t[%d]-Cod.Moneda....[%s] "
                                    "\t[%d]-Fec.Desde.....[%s] "
                                    "\t[%d]-Fec.Hasta.....[%s] "
                                    "\t[%d]-Cambio........[%lf]"
                                    ,LOG06,i,pConver->szCodMoneda
                                    ,i,pConver->szFecDesde
                                    ,i,pConver->szFecHasta
                                    ,i,pConver->dCambio);

        }
    }
}/************************ Final vPrintConversion ****************************/


/*****************************************************************************/
/*                        funcion : iCmpTarifas                              */
/*****************************************************************************/
int iCmpTarifas (const void* cad1, const void* cad2)
{
   int rc = 0;

   return
    ( (rc = strcmp ( ((TARIFAS *)cad1)->szCodTipServ,
                     ((TARIFAS *)cad2)->szCodTipServ) )!= 0)?rc:
    ( (rc = strcmp ( ((TARIFAS *)cad1)->szCodServicio,
                     ((TARIFAS *)cad2)->szCodServicio))!= 0)?rc:
    ( (rc = strcmp ( ((TARIFAS *)cad1)->szCodPlanServ,
                     ((TARIFAS *)cad2)->szCodPlanServ))!= 0)?rc:
    ( (rc = strcmp ( ((TARIFAS *)cad1)->szFecDesde,
                     ((TARIFAS *)cad2)->szFecDesde)  ) < 0 )?rc:0;
}/*********************** Final iCmpTarifas **********************************/

/*****************************************************************************/
/*                       funcion : vPrintTarifas                             */
/*****************************************************************************/
void vPrintTarifas (TARIFAS *pTar,int iNumTar)
{
    int i = 0;
    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t*** Carga de GA_TARIFAS ***",LOG06);

        for (i=0;i<iNumTar;i++)
        {
            vDTrazasLog (szExeName,"\n\t[%d]-Cod.TipServ.....[%s] "
                                   "\n\t[%d]-Cod.Servicio....[%s] "
                                   "\n\t[%d]-Fec.Desde.......[%s] "
                                   "\n\t[%d]-Imp.Tarifa......[%f] "
                                   "\n\t[%d]-Cod.Moneda......[%s] "
                                   "\n\t[%d]-Ind.Periodico...[%s] "
                                   "\n\t[%d]-Fec.Hasta.......[%s] "
                                   ,LOG06
                                   ,i,pTar[i].szCodTipServ
                                   ,i,pTar[i].szCodPlanServ
                                   ,i,pTar[i].szFecDesde
                                   ,i,pTar[i].dImpTarifa
                                   ,i,pTar[i].szCodMoneda
                                   ,i,pTar[i].szIndPeriodico
                                   ,i,pTar[i].szFecHasta);

        }
    }
}/********************** Final vPrintTarifas *********************************/

/*****************************************************************************/
/*                      funcion : iCmpCuadCtoPlan                            */
/*****************************************************************************/
int iCmpCuadCtoPlan (const void* cad1,const void* cad2)
{
  return
   ( ((CUADCTOPLAN *)cad1)->lCodCtoPlan <
     ((CUADCTOPLAN *)cad2)->lCodCtoPlan )?-1:
   ( ((CUADCTOPLAN *)cad1)->lCodCtoPlan >
     ((CUADCTOPLAN *)cad2)->lCodCtoPlan )? 1:
   ( ((CUADCTOPLAN *)cad1)->dImpUmbDesde<
     ((CUADCTOPLAN *)cad2)->dImpUmbDesde)?-1:0;

}/*********************** iCmpCuadCtoPlan ************************************/

/*****************************************************************************/
/*                       funcion : bFindCuadCtoPlan                          */
/* -Funcion que busca un registro en pstCuadCtoPlan (Ve_CuadCtoPlan) con el  */
/*  el parametro de busqueda lCodCtoPlan                                     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bFindCuadCtoPlan (long lCodCtoPlan, double dImporte,CUADCTOPLAN *pCuad)
{
  CUADCTOPLAN stkey;
  BOOL bRes = TRUE;
  CUADCTOPLAN *pCuad_Aux = (CUADCTOPLAN *)NULL;


  stkey.lCodCtoPlan = lCodCtoPlan;
  stkey.dImpUmbDesde= dImporte   ;

  vDTrazasLog (szExeName, "\n\t *  Busca Registro en pstCuadCtoPlan "
                          "\n\t\t=>  Cod_CtoPlan          [%d]"
                          "\n\t\t=>  Umbral Desde         [%.f]"
                          "\n\t\t=>  Total de Registros   [%d]",
                          LOG05,
                          stkey.lCodCtoPlan,
                          stkey.dImpUmbDesde,
                          NUM_CUADCTOPLAN);

  if ( (pCuad_Aux = (CUADCTOPLAN *)bsearch(&stkey,pstCuadCtoPlan,NUM_CUADCTOPLAN,
                 sizeof(CUADCTOPLAN),iCmpCuadCtoPlan))==(CUADCTOPLAN *)NULL)
  {
        iDError (szExeName,ERR021,vInsertarIncidencia,
                 "pstCuadCtoPlan=>(Ve_CuadCtoPlan)");
        bRes = FALSE;
  }
  pCuad->lCodCtoPlan  = pCuad_Aux->lCodCtoPlan  ;
  pCuad->dImpUmbDesde = pCuad_Aux->dImpUmbDesde ;
  pCuad->dImpUmbHasta = pCuad_Aux->dImpUmbHasta ;
  pCuad->dImpDescuento= pCuad_Aux->dImpDescuento;
  pCuad->iCodTipoDto  = pCuad_Aux->iCodTipoDto  ;

  return bRes;
}/************************** Final bFinaCuadCtoPlan **************************/


/*****************************************************************************/
/*                          funcion : bGetMaxColPreFa                        */
/* -Funcion que gestiona Max(Columna) en memoria, es a nivel de cliente, si  */
/*  el concepto no esta en memoria, se inserta y Columna = 1, si esta se le  */
/*  suma uno a la columna.                                                   */
/*****************************************************************************/
BOOL bGetMaxColPreFa (int iCodConcepto,long *lColumna)
{
	/* Se asume que el maximo de conceptos es el tamaño de la estructura*/
	if (stMaxColPreFa.pConcCol[iCodConcepto].iFlagExiste)
    {
       	stMaxColPreFa.pConcCol[iCodConcepto].lColumna   += 1;
    }
	else 
  	{
		stMaxColPreFa.pConcCol[iCodConcepto].iFlagExiste = 1;
	    stMaxColPreFa.pConcCol[iCodConcepto].lColumna    = 1;
  	}

    *lColumna = stMaxColPreFa.pConcCol[iCodConcepto].lColumna;
    return TRUE;
}/************************ Final bGetMaxColPreFa *****************************/

/*****************************************************************************/
/*                         funcion : vFreeMaxColPreFa                        */
/*****************************************************************************/
void vFreeMaxColPreFa (void)
{
  
	memset (&stMaxColPreFa,0, sizeof (stMaxColPreFa));

}/*********************** Final vFreeMaxColPreFa *****************************/

/*****************************************************************************/
/*                      funcion : bGetCatImpCliente                          */
/* -Funcion que devuelve la categoria impositiva del cliente,dependiendo de  */
/*  la fecha.                                                                */
/* -Fecha: CONTADO=>Sysdate                                                  */
/*         CREDITO=>Fecha de Emision del mes en curso al generar el cargo    */
/* -Valores Retorno: Error->FALSE,!Error->TRUE                               */
/*****************************************************************************/
BOOL bGetCatImpCliente (long  lCodCliente,
                        int  *iCodCatImp ,
                        char *szFecha    ,
                        int   iTipFact)
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

 static long  lhCodCliente    ;
 static char* szhFecha        ; /* EXEC SQL VAR szhFecha         IS STRING(15); */ 

 static int   ihCodCatImpos   ;
 static char* szhIndOrdenTotal; /* EXEC SQL VAR szhIndOrdenTotal IS STRING(13); */ 

  char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

 /* EXEC SQL END DECLARE SECTION; */ 



 lhCodCliente     = lCodCliente                 ;
 szhFecha         = szFecha                     ;
 szhIndOrdenTotal = stDatosGener.szIndOrdenTotal;

 vDTrazasLog (szExeName,"\n\t\t* Entrada Categoria Impositiva"
                        "\n\t\t=> Cliente   [%ld]"
                        "\n\t\t=> Fecha     [%s] ",LOG05,lCodCliente,szFecha);

 sprintf (szhFmtFecha ,"YYYYMMDDHH24MISS");

 /* EXEC SQL SELECT /o+ index (GE_CATIMPCLIENTES PK_GE_CATIMPCLIENTES) o/
                 COD_CATIMPOS  ,
                 TO_CHAR (FA_SEQ_IND_ORDENTOTAL.NEXTVAL)
          INTO   :ihCodCatImpos,
                 :szhIndOrdenTotal
          FROM   GE_CATIMPCLIENTES
          WHERE  COD_CLIENTE = :lhCodCliente
            AND  FEC_DESDE <= TO_DATE (:szhFecha,:szhFmtFecha)
            AND  FEC_HASTA >= TO_DATE (:szhFecha,:szhFmtFecha); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 39;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (GE_CATIMPCLIENTES PK_GE_CATIMPCLIENTES) \
 +*/ COD_CATIMPOS ,TO_CHAR(FA_SEQ_IND_ORDENTOTAL.nextval ) into :b0,:b1  from \
GE_CATIMPCLIENTES where ((COD_CLIENTE=:b2 and FEC_DESDE<=TO_DATE(:b3,:b4)) and\
 FEC_HASTA>=TO_DATE(:b3,:b4))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1437;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCatImpos;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhIndOrdenTotal;
 sqlstm.sqhstl[1] = (unsigned long )13;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhFmtFecha;
 sqlstm.sqhstl[4] = (unsigned long )17;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecha;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
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
     iDError (szExeName,ERR000,vInsertarIncidencia,
              "Select->Ge_CatImpClientes (Fa_Seq_Ind_OrdenTotal)",
              szfnORAerror());
     return FALSE;
 }
 *iCodCatImp = ihCodCatImpos;

 return TRUE;
}/************************** bGetCatImpCliente ******************************/


/*****************************************************************************/
/*                      funcion : bGetCatTribCliente                         */
/* -Funcion que devuelve la categoria tributaria del cliente,dependiendo de  */
/*  la fecha.                                                                */
/* -Fecha: CONTADO=>Sysdate                                                  */
/*         CICLO  =>Fecha Emision                                            */
/* -Valores Retorno: Error->FALSE,!Error->TRUE                               */
/*****************************************************************************/
BOOL bGetCatTribCliente(long  lCodCliente,
                        char *szCodCatTribut,
                        char *szFecha    )
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

 static long  lhCodCliente       ;
 static char  szhFecha       [20]; /* EXEC SQL VAR szhFecha         IS STRING(20); */ 

 static char  szhCodCatTribut[2] ; /* EXEC SQL VAR szhCodCatTribut  IS STRING(2); */ 

  char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

 /* EXEC SQL END DECLARE SECTION; */ 


 lhCodCliente = lCodCliente;
 strcpy(szhFecha,szFecha);

 vDTrazasLog (szExeName,"\n\t\t* Entrada Categoria Tributaria"
                        "\n\t\t=> Cliente   [%ld]"
                        "\n\t\t=> Fecha     [%s] ",LOG05,lCodCliente,szFecha);

 sprintf (szhFmtFecha ,"YYYYMMDDHH24MISS");
 /* EXEC SQL SELECT COD_CATRIBUT
          INTO   :szhCodCatTribut
          FROM   GA_CATRIBUTCLIE
          WHERE  COD_CLIENTE = :lhCodCliente
            AND  FEC_DESDE <= TO_DATE (:szhFecha,:szhFmtFecha)
            AND  FEC_HASTA >= TO_DATE (:szhFecha,:szhFmtFecha); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 39;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CATRIBUT into :b0  from GA_CATRIBUTCLIE where ((C\
OD_CLIENTE=:b1 and FEC_DESDE<=TO_DATE(:b2,:b3)) and FEC_HASTA>=TO_DATE(:b2,:b3\
))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1480;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodCatTribut;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[2] = (unsigned long )20;
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
 sqlstm.sqhstv[4] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[4] = (unsigned long )20;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
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
     iDError (szExeName,ERR021,vInsertarIncidencia, "Ga_CaTributClie (Factura/Boleta)");
     return FALSE;
 }
 strcpy(szCodCatTribut,szhCodCatTribut);

 return TRUE;
}/************************** bGetCatTribClientes ******************************/



/*****************************************************************************/
/*                         funcion : iCmpCatImpCliente                       */
/*****************************************************************************/
int iCmpCatImpCliente (const void* cad1, const void* cad2)
{
    int rc = 0;

    if ( ((CATIMPCLIENTES *)cad1)->lCodCliente <
         ((CATIMPCLIENTES *)cad2)->lCodCliente )
           return -1;
    if ( ((CATIMPCLIENTES *)cad1)->lCodCliente >
         ((CATIMPCLIENTES *)cad2)->lCodCliente )
           return  1;
    if ( ((CATIMPCLIENTES *)cad1)->lCodCliente ==
         ((CATIMPCLIENTES *)cad2)->lCodCliente )
    {
           return
            ( (rc = strcmp (((CATIMPCLIENTES *)cad1)->szFecDesde,
                            ((CATIMPCLIENTES *)cad2)->szFecDesde) )<0)?rc:
            ( (rc = strcmp (((CATIMPCLIENTES *)cad1)->szFecHasta,
                            ((CATIMPCLIENTES *)cad2)->szFecHasta) )>0)?rc:0;
    }
}/************************* Final iCmpCatImpCliente **************************/

/*****************************************************************************/
/*                         funcion : vPrintCatImpCliente                     */
/*****************************************************************************/
void vPrintCatImpCliente (CATIMPCLIENTES *pCat,int iNumCat)
{
    int iInd = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t*** Tabla GE_CATIMPCLIENTES ***\n",LOG06);

        for (iInd=0;iInd<NUM_CATIMPCLIENTES;iInd++)
        {
            vDTrazasLog (szExeName,"\t[%d]-Cod.Cliente.....................[%ld]"
                                   "\t[%d]-Fec.Desde.......................[%s] "
                                   "\t[%d]-Fec.Hasta.......................[%s] "
                                   "\t[%d]-Cod.Categoria Impositiva........[%d]\n"
                                   ,LOG06
                                   ,iInd,pCat->lCodCliente
                                   ,iInd,pCat->szFecDesde
                                   ,iInd,pCat->szFecHasta
                                   ,iInd,pCat->iCodCatImpos);

            pCat++;
        }
    }
}/************************ Final vPrintCatImpCliente *************************/

/* --------------------------------------------------------------------------*/
/*   bChangeIndEstadoPro (long,int,int)                                      */
/*      Cambia el estado del proceso de iFrom a iTo                          */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* --------------------------------------------------------------------------*/
BOOL bChangeIndEstadoPro (long lNumProceso,int iFrom, int iTo)
{

  /* EXEC SQL UPDATE /o+ index (FA_PROCESOS PK_FA_PROCESOS) o/
                  FA_PROCESOS
              SET IND_ESTADO   = :iTo
            WHERE NUM_PROCESO  = :lNumProceso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 39;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update  /*+  index (FA_PROCESOS PK_FA_PROCESOS)  +*/ FA_PRO\
CESOS  set IND_ESTADO=:b0 where NUM_PROCESO=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1519;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&iTo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lNumProceso;
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


/*              AND IND_ESTADO   = :iFrom;    */

  if (SQLCODE == SQLOK && stCliente.iModVenta == 2)
  {

       /* EXEC SQL UPDATE /o+ index (FA_PROCESOS PK_FA_PROCESOS) o/
                       FA_PROCESOS
                   SET IND_ESTADO   = :iTo
                 WHERE NUM_PROCESO  = :stStatus.IdPro2
                   AND IND_ESTADO   = :iFrom; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 39;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update  /*+  index (FA_PROCESOS PK_FA_PROCESOS)  +*/ F\
A_PROCESOS  set IND_ESTADO=:b0 where (NUM_PROCESO=:b1 and IND_ESTADO=:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )1542;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&iTo;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&(stStatus.IdPro2);
       sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&iFrom;
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



  }
  if (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "Update->Fa_Procesos",szfnORAerror());


  return (SQLCODE != 0 && SQLCODE != SQLNOTFOUND)?FALSE:TRUE;

}/*----------------------- Final bChangeIndEstadoPro -------------------------*/

/*****************************************************************************/
/*                          funcion : bSetNumFactura                         */
/* -Funcion que inserta un reg. en Fa_Procesos .                             */
/*  La estructura stProceso se inicializa en factura.c con parametros de en- */
/*  trada (Usuario,Proceso,TipoFact)                                         */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bSetNumFactura (int   iTipoFact     ,
                     TRANSCONTADO *pTranC, VENTAS *pVenta)
{

 vDTrazasLog (szExeName,
              "\n\t\t* Num Proceso [%ld]\n",LOG03,stStatus.IdPro);

 stProceso.lNumProceso  = stStatus.IdPro;

 switch (iTipoFact)
 {
     case FACT_CONTADO:
          stProceso.iCodTipDocum = stDatosGener.iCodContado;
          stProceso.lCodCiclFact = ORA_NULL                ;

          if (pVenta->lNumVenta       != ORA_NULL &&
              pTranC->lNumTransaccion != ORA_NULL)
          {
              if (!bGetVenta (pVenta))
                   return FALSE;
              strcpy (stProceso.szCodOficina,pVenta->szCodOficina)     ;
              stProceso.lCodVendedorAgente = pVenta->lCodVendedorAgente;
          }
          if (pVenta->lNumVenta       == ORA_NULL &&
              pTranC->lNumTransaccion != ORA_NULL)
          {
              if (!bGetTransContado (pTranC))
                   return FALSE;
              strcpy (stProceso.szCodOficina,pTranC->szCodOficina)     ;
              stProceso.lCodVendedorAgente = pTranC->lCodVendedorAgente;
          }
          if (!bGetCentrEmi (stProceso.szCodOficina ,
                             stProceso.iCodTipDocum ,
                             &stProceso.iCodCentrEmi))
               return FALSE;
          if (!bGetLetra (stProceso.iCodTipDocum,
                          stCliente.iCodCatImpos,
                          stProceso.szLetraAg   ))
               return FALSE;
          if (!bGenNumSecuenciasEmi (stProceso.iCodTipDocum,
                                     stProceso.szLetraAg   ,
                                     stProceso.iCodCentrEmi,
                                     &stProceso.lNumSecuAg))
               return FALSE;
          break;
     case FACT_CICLO:
          stProceso.iCodTipDocum = stDatosGener.iCodCiclo              ;
          stProceso.lCodCiclFact = stCiclo.lCodCiclFact                ;
          stProceso.lCodVendedorAgente = stDatosGener.lCodAgenteStartel;
          if (!bGetCentrEmi (stProceso.szCodOficina ,
                             stProceso.iCodTipDocum ,
                             &stProceso.iCodCentrEmi))
               return FALSE;
          break;
     case FACT_BAJA       :
     case FACT_LIQUIDACION:
     case FACT_RENTAPHONE :
     case FACT_ROAMINGVIS :
          switch (iTipoFact)
          {
              case FACT_BAJA       :
                   stProceso.iCodTipDocum = stDatosGener.iCodBaja       ;
                   break                                                ;
              case FACT_RENTAPHONE :
                   stProceso.iCodTipDocum = stDatosGener.iCodRentaPhone ;
                   break                                                ;
              case FACT_LIQUIDACION:
                   stProceso.iCodTipDocum = stDatosGener.iCodLiquidacion;
                   break                                                ;
              case FACT_ROAMINGVIS :
                   stProceso.iCodTipDocum = stDatosGener.iCodRoamingVis ;
                   break                                                ;
          }
          stProceso.lCodCiclFact = stCiclo.lCodCiclFact;

          stProceso.lCodVendedorAgente = stDatosGener.lCodAgenteStartel;

          strcpy (stProceso.szCodOficina,stCliente.szCodOficina);

          if (!bGetCentrEmi (stProceso.szCodOficina ,
                             stProceso.iCodTipDocum ,
                             &stProceso.iCodCentrEmi))
               return FALSE;

          if (!bGetLetra (stProceso.iCodTipDocum,
                          stCliente.iCodCatImpos,
                          stProceso.szLetraAg   ))
               return FALSE;
          if (!bGenNumSecuenciasEmi (stProceso.iCodTipDocum,
                                     stProceso.szLetraAg   ,
                                     stProceso.iCodCentrEmi,
                                     &stProceso.lNumSecuAg))
               return FALSE;
          break;
      default: break;
 }/* fin del switch */
 if (iTipoFact != FACT_NOTACRED && iTipoFact != FACT_NOTADEBI)
 {
     strcpy (stProceso.szFecEfectividad,szSysDate);
     if (!bInsertaProceso (stProceso))
          return FALSE;
 }
 return TRUE;
}/************************* Final bSetNumFactura *****************************/

/*****************************************************************************/
/*                        funcion : bfnGetProceso                            */
/*****************************************************************************/
BOOL bfnGetProceso (PROCESO *pP)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodTipDocum            ;
  static long  lhCodVendedorAgente      ;
  static int   ihCodCentrEmi            ;
  static char  szhFecEfectividad    [15];
                                 /* EXEC SQL VAR szhFecEfectividad IS STRING(15); */ 

  static char  szhNomUsuarOra       [31];
                                 /* EXEC SQL VAR szhNomUsuarOra    IS STRING(31); */ 

  static char  szhLetraAg            [2];
                                 /* EXEC SQL VAR szhLetraAg        IS STRING(2) ; */ 

  static long  lhNumSecuAg              ;
  static int   ihCodTipDocNot           ;
  static long  lhCodVendedorAgenteNot   ;
  static char  szhLetraNot           [2];
                                 /* EXEC SQL VAR szhLetraNot       IS STRING(2) ; */ 

  static int   ihCodCentrNot            ;
  static long  lhNumSecuNot             ;
  static int   ihIndEstado              ;
  static long  lhCodCiclFact            ;
  static int   ihIndNotaCredC           ;
  static short i_shCodTipDocum          ;
  static short i_shCodVendedorAgente    ;
  static short i_shCodCentrEmi          ;
  static short i_shFecEfectividad       ;
  static short i_shNomUsuarOra          ;
  static short i_shLetraAg              ;
  static short i_shNumSecuAg            ;
  static short i_shCodTipDocNot         ;
  static short i_shCodVendedorAgenteNot ;
  static short i_shLetraNot             ;
  static short i_shCodCentrNot          ;
  static short i_shNumSecuNot           ;
  static short i_shIndEstado            ;
  static short i_shCodCiclFact          ;
  char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametro de Proceso a Select Fa_Procesos"
                         "\n\t\t=>Num.Proceso [%ld]", LOG04, pP->lNumProceso);

 sprintf (szhFmtFecha ,"YYYYMMDDHH24MISS");
  /* EXEC SQL SELECT /o+ index (FA_PROCESOS PK_FA_PROCESOS) o/
                  COD_TIPDOCUM          ,
                  COD_VENDEDOR_AGENTE   ,
                  COD_CENTREMI          ,
                  TO_CHAR (FEC_EFECTIVIDAD,:szhFmtFecha),
                  NOM_USUARORA          ,
                  LETRAAG               ,
                  NUM_SECUAG            ,
                  COD_TIPDOCNOT         ,
                  COD_VENDEDOR_AGENTENOT,
                  LETRANOT              ,
                  COD_CENTRNOT          ,
                  NUM_SECUNOT           ,
                  IND_ESTADO            ,
                  IND_NOTACREDC         ,
                  COD_CICLFACT
            INTO  :ihCodTipDocum         :i_shCodTipDocum         ,
                  :lhCodVendedorAgente   :i_shCodVendedorAgente   ,
                  :ihCodCentrEmi         :i_shCodCentrEmi         ,
                  :szhFecEfectividad     :i_shFecEfectividad      ,
                  :szhNomUsuarOra        :i_shNomUsuarOra         ,
                  :szhLetraAg            :i_shLetraAg             ,
                  :lhNumSecuAg           :i_shNumSecuAg           ,
                  :ihCodTipDocNot        :i_shCodTipDocNot        ,
                  :lhCodVendedorAgenteNot:i_shCodVendedorAgenteNot,
                  :szhLetraNot           :i_shLetraNot            ,
                  :ihCodCentrNot         :i_shCodCentrNot         ,
                  :lhNumSecuNot          :i_shNumSecuNot          ,
                  :ihIndEstado           :i_shIndEstado           ,
                  :ihIndNotaCredC                                 ,
                  :lhCodCiclFact         :i_shCodCiclFact
           FROM   FA_PROCESOS
           WHERE  NUM_PROCESO = :pP->lNumProceso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 39;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (FA_PROCESOS PK_FA_PROCESOS)  +*/ COD_TI\
PDOCUM ,COD_VENDEDOR_AGENTE ,COD_CENTREMI ,TO_CHAR(FEC_EFECTIVIDAD,:b0) ,NOM_U\
SUARORA ,LETRAAG ,NUM_SECUAG ,COD_TIPDOCNOT ,COD_VENDEDOR_AGENTENOT ,LETRANOT \
,COD_CENTRNOT ,NUM_SECUNOT ,IND_ESTADO ,IND_NOTACREDC ,COD_CICLFACT into :b1:b\
2,:b3:b4,:b5:b6,:b7:b8,:b9:b10,:b11:b12,:b13:b14,:b15:b16,:b17:b18,:b19:b20,:b\
21:b22,:b23:b24,:b25:b26,:b27,:b28:b29  from FA_PROCESOS where NUM_PROCESO=:b3\
0";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1569;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
  sqlstm.sqhstl[0] = (unsigned long )17;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)&i_shCodTipDocum;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedorAgente;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)&i_shCodVendedorAgente;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentrEmi;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)&i_shCodCentrEmi;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecEfectividad;
  sqlstm.sqhstl[4] = (unsigned long )15;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)&i_shFecEfectividad;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhNomUsuarOra;
  sqlstm.sqhstl[5] = (unsigned long )31;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)&i_shNomUsuarOra;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhLetraAg;
  sqlstm.sqhstl[6] = (unsigned long )2;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)&i_shLetraAg;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhNumSecuAg;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)&i_shNumSecuAg;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodTipDocNot;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)&i_shCodTipDocNot;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhCodVendedorAgenteNot;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)&i_shCodVendedorAgenteNot;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhLetraNot;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)&i_shLetraNot;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)&ihCodCentrNot;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)&i_shCodCentrNot;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&lhNumSecuNot;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)&i_shNumSecuNot;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&ihIndEstado;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)&i_shIndEstado;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)&ihIndNotaCredC;
  sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)&lhCodCiclFact;
  sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)&i_shCodCiclFact;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)&(pP->lNumProceso);
  sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
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
       iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_Procesos",
                szfnORAerror());
       return FALSE;
   }
   if (SQLCODE == SQLOK)
   {
       pP->iCodTipDocum      = (i_shCodTipDocum          == ORA_NULL)?ORA_NULL:
                                ihCodTipDocum         ;
       pP->lCodVendedorAgente= (i_shCodVendedorAgente    == ORA_NULL)?ORA_NULL:
                                lhCodVendedorAgente   ;
       pP->iCodCentrEmi      = (i_shCodCentrEmi          == ORA_NULL)?ORA_NULL:
                                ihCodCentrEmi         ;
       pP->lNumSecuAg        = (i_shNumSecuAg            == ORA_NULL)?ORA_NULL:
                                lhNumSecuAg           ;
       pP->iCodTipDocNot     = (i_shCodTipDocNot         == ORA_NULL)?ORA_NULL:
                                ihCodTipDocNot        ;
       pP->lCodVendedorAgenteNot
                             = (i_shCodVendedorAgenteNot == ORA_NULL)?ORA_NULL:
                                lhCodVendedorAgenteNot;
       pP->iCodCentrNot      = (i_shCodCentrNot          == ORA_NULL)?ORA_NULL:
                                ihCodCentrNot         ;
       pP->lNumSecuNot       = (i_shNumSecuNot           == ORA_NULL)?ORA_NULL:
                                lhNumSecuNot          ;
       pP->iIndEstado        = (i_shIndEstado            == ORA_NULL)?ORA_NULL:
                                ihIndEstado           ;
       pP->lCodCiclFact      = (i_shCodCiclFact          == ORA_NULL)?ORA_NULL:
                                lhCodCiclFact         ;

       pP->iIndNotaCredC     = ihIndNotaCredC         ;

       if (i_shFecEfectividad != ORA_NULL)
           strcpy (pP->szFecEfectividad,szhFecEfectividad);
       else
           pP->szFecEfectividad[0] = 0;

       if (i_shNomUsuarOra    != ORA_NULL)
           strcpy (pP->szNomUsuarOra,szhNomUsuarOra);
       else
           pP->szNomUsuarOra[0] = 0;

       if (i_shLetraAg != ORA_NULL)
           strcpy (pP->szLetraAg,szhLetraAg);
       else
           pP->szLetraAg[0] = 0;

       if (i_shLetraNot != ORA_NULL)
           strcpy (pP->szLetraNot,szhLetraNot);
       else
           pP->szLetraNot[0] = 0;
   }
   return TRUE;
}/************************* Final bfnGetProceso ******************************/

/*****************************************************************************/
/*                             funcion : bInsertaProceso                     */
/*****************************************************************************/
BOOL bInsertaProceso (PROCESO stProc)
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

 static long  lhNumProceso       ;
 static int   ihCodTipDocum      ;
 static long  lhCodVendedorAgente;
 static int   ihCodCentrEmi      ;
 static char* szhFecEfectividad  ;/* EXEC SQL VAR szhFecEfectividad IS STRING(15); */ 

 static char* szhNomUsuarOra     ;/* EXEC SQL VAR szhNomUsuarOra    IS STRING(31); */ 

 static char* szhLetraAg         ;/* EXEC SQL VAR szhLetraAg        IS STRING(2) ; */ 

 static long  lhNumSecuAg        ;
 static int   ihCodTipDocNot     ;
 static long  lhCodVendedorAgenteNot;
 static char* szhLetraNot        ;/* EXEC SQL VAR szhLetraNot       IS STRING(2) ; */ 

 static int   ihCodCentrNot      ;
 static long  lhNumSecuNot       ;
 static short shIndEstado        ;
 static long  lhCodCiclFact      ;
 static short i_shCodTipDocum    ;
 static short i_shCodVendedorAgente;
 static short i_shCodCentrEmi    ;
 static short i_shNomUsuarOra    ;
 static short i_shLetraAg        ;
 static short i_shNumSecuAg      ;
 static short i_shCodTipDocNot   ;
 static short i_shCodVendedorAgenteNot;
 static short i_shLetraNot       ;
 static short i_shNumSecuNot     ;
 static short i_shIndEstado      ;
 static short i_shCodCiclFact    ;
   char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

 /* EXEC SQL END DECLARE SECTION; */ 


 lhNumProceso           = stProc.lNumProceso          ;
 ihCodTipDocum          = stProc.iCodTipDocum         ;
 lhCodVendedorAgente    = stProc.lCodVendedorAgente   ;
 ihCodCentrEmi          = stProc.iCodCentrEmi         ;
 szhFecEfectividad      = stProc.szFecEfectividad     ;
 szhNomUsuarOra         = stProc.szNomUsuarOra        ;
 szhLetraAg             = stProc.szLetraAg            ;
 lhNumSecuAg            = stProc.lNumSecuAg           ;
 ihCodTipDocNot         = stProc.iCodTipDocNot        ;
 lhCodVendedorAgenteNot = stProc.lCodVendedorAgenteNot;
 szhLetraNot            = stProc.szLetraNot           ;
 ihCodCentrNot          = stProc.iCodCentrNot         ;
 lhNumSecuNot           = stProc.lNumSecuNot          ;
 shIndEstado            = stProc.iIndEstado           ;
 lhCodCiclFact          = stProc.lCodCiclFact         ;

 i_shCodTipDocum       = (ihCodTipDocum       == ORA_NULL)?ORA_NULL:0;
 i_shCodVendedorAgente = (lhCodVendedorAgente == ORA_NULL)?ORA_NULL:0;
 i_shCodCentrEmi       = (ihCodCentrEmi       == ORA_NULL)?ORA_NULL:0;
 i_shNumSecuAg         = (lhNumSecuAg         == ORA_NULL)?ORA_NULL:0;
 i_shCodTipDocNot      = (ihCodTipDocNot      == ORA_NULL)?ORA_NULL:0;
 i_shNumSecuNot        = (lhNumSecuNot        == ORA_NULL)?ORA_NULL:0;
 i_shIndEstado         = (shIndEstado         == ORA_NULL)?ORA_NULL:0;
 i_shCodCiclFact       = (lhCodCiclFact       == ORA_NULL)?ORA_NULL:0;

 i_shNomUsuarOra    = ( strlen (szhNomUsuarOra   ) == 0)?ORA_NULL:0;
 i_shLetraAg        = ( strlen (szhLetraAg       ) == 0)?ORA_NULL:0;
 i_shLetraNot       = ( strlen (szhLetraNot      ) == 0)?ORA_NULL:0;

 i_shCodVendedorAgenteNot = (lhCodVendedorAgente == ORA_NULL)?ORA_NULL:0;

 vDTrazasLog (szExeName,"\n\t\t* Inserta en Fa_Procesos"
                        "\n\t\t=>Num.Proceso    [%ld]"
                        "\n\t\t=>Cod.TipDocum   [%d] "
                        "\n\t\t=>Cod.VendedorAg.[%ld]"
                        "\n\t\t=>Cod.CentrEmi   [%d] "
                        "\n\t\t=>Num.SecuAg     [%ld]"
                        "\n\t\t=>Cod.TipDocNot  [%d] "
                        "\n\t\t=>Cod.CentrNot   [%d] "
                        "\n\t\t=>Num.SecuNot    [%ld]"
                        "\n\t\t=>Ind.Estado     [%d] "
                        "\n\t\t=>Cod.CiclFact   [%ld]"
                        "\n\t\t=>Fec.Efectivid. [%s] "
                        "\n\t\t=>Nom.UsuarOra   [%s] "
                        "\n\t\t=>LetraNot       [%s] "
                        "\n\t\t=>Cod.VendAgNot  [%ld]",LOG05,
                        lhNumProceso , ihCodTipDocum    , lhCodVendedorAgente,
                        ihCodCentrEmi, lhNumSecuAg      , ihCodTipDocNot     ,
                        ihCodCentrNot, lhNumSecuNot     , shIndEstado        ,
                        lhCodCiclFact, szhFecEfectividad, szhNomUsuarOra     ,
                        szhLetraNot  , lhCodVendedorAgenteNot);

 sprintf (szhFmtFecha ,"YYYYMMDDHH24MISS");

/* EXEC SQL INSERT INTO FA_PROCESOS
                 (NUM_PROCESO           ,
                  COD_TIPDOCUM          ,
                  COD_VENDEDOR_AGENTE   ,
                  COD_CENTREMI          ,
                  FEC_EFECTIVIDAD       ,
                  NOM_USUARORA          ,
                  LETRAAG               ,
                  NUM_SECUAG            ,
                  COD_TIPDOCNOT         ,
                  COD_VENDEDOR_AGENTENOT,
                  LETRANOT              ,
                  COD_CENTRNOT          ,
                  NUM_SECUNOT           ,
                  IND_ESTADO            ,
                  COD_CICLFACT)
          VALUES (:lhNumProceso                                   ,
                  :ihCodTipDocum:i_shCodTipDocum                  ,
                  :lhCodVendedorAgente:i_shCodVendedorAgente      ,
                  :ihCodCentrEmi:i_shCodCentrEmi                  ,
                  TO_DATE(:szhFecEfectividad,:szhFmtFecha)  ,
                  :szhNomUsuarOra:i_shNomUsuarOra                 ,
                  :szhLetraAg:i_shLetraAg                         ,
                  :lhNumSecuAg:i_shNumSecuAg                      ,
                  :ihCodTipDocNot:i_shCodTipDocNot                ,
                  :lhCodVendedorAgenteNot:i_shCodVendedorAgenteNot,
                  :szhLetraNot:i_shLetraNot                       ,
                  :ihCodCentrNot:i_shCodCentrEmi                  ,
                  :lhNumSecuNot:i_shNumSecuNot                    ,
                  :shIndEstado:i_shIndEstado                      ,
                  :lhCodCiclFact:i_shCodCiclFact); */ 

{
struct sqlexd sqlstm;
sqlstm.sqlvsn = 12;
sqlstm.arrsiz = 39;
sqlstm.sqladtp = &sqladt;
sqlstm.sqltdsp = &sqltds;
sqlstm.stmt = "insert into FA_PROCESOS (NUM_PROCESO,COD_TIPDOCUM,COD_VENDEDO\
R_AGENTE,COD_CENTREMI,FEC_EFECTIVIDAD,NOM_USUARORA,LETRAAG,NUM_SECUAG,COD_TIPD\
OCNOT,COD_VENDEDOR_AGENTENOT,LETRANOT,COD_CENTRNOT,NUM_SECUNOT,IND_ESTADO,COD_\
CICLFACT) values (:b0,:b1:b2,:b3:b4,:b5:b6,TO_DATE(:b7,:b8),:b9:b10,:b11:b12,:\
b13:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28)";
sqlstm.iters = (unsigned int  )1;
sqlstm.offset = (unsigned int  )1652;
sqlstm.cud = sqlcud0;
sqlstm.sqlest = (unsigned char  *)&sqlca;
sqlstm.sqlety = (unsigned short)256;
sqlstm.occurs = (unsigned int  )0;
sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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
sqlstm.sqindv[1] = (         short *)&i_shCodTipDocum;
sqlstm.sqinds[1] = (         int  )0;
sqlstm.sqharm[1] = (unsigned long )0;
sqlstm.sqadto[1] = (unsigned short )0;
sqlstm.sqtdso[1] = (unsigned short )0;
sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedorAgente;
sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
sqlstm.sqhsts[2] = (         int  )0;
sqlstm.sqindv[2] = (         short *)&i_shCodVendedorAgente;
sqlstm.sqinds[2] = (         int  )0;
sqlstm.sqharm[2] = (unsigned long )0;
sqlstm.sqadto[2] = (unsigned short )0;
sqlstm.sqtdso[2] = (unsigned short )0;
sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentrEmi;
sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
sqlstm.sqhsts[3] = (         int  )0;
sqlstm.sqindv[3] = (         short *)&i_shCodCentrEmi;
sqlstm.sqinds[3] = (         int  )0;
sqlstm.sqharm[3] = (unsigned long )0;
sqlstm.sqadto[3] = (unsigned short )0;
sqlstm.sqtdso[3] = (unsigned short )0;
sqlstm.sqhstv[4] = (unsigned char  *)szhFecEfectividad;
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
sqlstm.sqhstv[6] = (unsigned char  *)szhNomUsuarOra;
sqlstm.sqhstl[6] = (unsigned long )31;
sqlstm.sqhsts[6] = (         int  )0;
sqlstm.sqindv[6] = (         short *)&i_shNomUsuarOra;
sqlstm.sqinds[6] = (         int  )0;
sqlstm.sqharm[6] = (unsigned long )0;
sqlstm.sqadto[6] = (unsigned short )0;
sqlstm.sqtdso[6] = (unsigned short )0;
sqlstm.sqhstv[7] = (unsigned char  *)szhLetraAg;
sqlstm.sqhstl[7] = (unsigned long )2;
sqlstm.sqhsts[7] = (         int  )0;
sqlstm.sqindv[7] = (         short *)&i_shLetraAg;
sqlstm.sqinds[7] = (         int  )0;
sqlstm.sqharm[7] = (unsigned long )0;
sqlstm.sqadto[7] = (unsigned short )0;
sqlstm.sqtdso[7] = (unsigned short )0;
sqlstm.sqhstv[8] = (unsigned char  *)&lhNumSecuAg;
sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
sqlstm.sqhsts[8] = (         int  )0;
sqlstm.sqindv[8] = (         short *)&i_shNumSecuAg;
sqlstm.sqinds[8] = (         int  )0;
sqlstm.sqharm[8] = (unsigned long )0;
sqlstm.sqadto[8] = (unsigned short )0;
sqlstm.sqtdso[8] = (unsigned short )0;
sqlstm.sqhstv[9] = (unsigned char  *)&ihCodTipDocNot;
sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
sqlstm.sqhsts[9] = (         int  )0;
sqlstm.sqindv[9] = (         short *)&i_shCodTipDocNot;
sqlstm.sqinds[9] = (         int  )0;
sqlstm.sqharm[9] = (unsigned long )0;
sqlstm.sqadto[9] = (unsigned short )0;
sqlstm.sqtdso[9] = (unsigned short )0;
sqlstm.sqhstv[10] = (unsigned char  *)&lhCodVendedorAgenteNot;
sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
sqlstm.sqhsts[10] = (         int  )0;
sqlstm.sqindv[10] = (         short *)&i_shCodVendedorAgenteNot;
sqlstm.sqinds[10] = (         int  )0;
sqlstm.sqharm[10] = (unsigned long )0;
sqlstm.sqadto[10] = (unsigned short )0;
sqlstm.sqtdso[10] = (unsigned short )0;
sqlstm.sqhstv[11] = (unsigned char  *)szhLetraNot;
sqlstm.sqhstl[11] = (unsigned long )2;
sqlstm.sqhsts[11] = (         int  )0;
sqlstm.sqindv[11] = (         short *)&i_shLetraNot;
sqlstm.sqinds[11] = (         int  )0;
sqlstm.sqharm[11] = (unsigned long )0;
sqlstm.sqadto[11] = (unsigned short )0;
sqlstm.sqtdso[11] = (unsigned short )0;
sqlstm.sqhstv[12] = (unsigned char  *)&ihCodCentrNot;
sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
sqlstm.sqhsts[12] = (         int  )0;
sqlstm.sqindv[12] = (         short *)&i_shCodCentrEmi;
sqlstm.sqinds[12] = (         int  )0;
sqlstm.sqharm[12] = (unsigned long )0;
sqlstm.sqadto[12] = (unsigned short )0;
sqlstm.sqtdso[12] = (unsigned short )0;
sqlstm.sqhstv[13] = (unsigned char  *)&lhNumSecuNot;
sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
sqlstm.sqhsts[13] = (         int  )0;
sqlstm.sqindv[13] = (         short *)&i_shNumSecuNot;
sqlstm.sqinds[13] = (         int  )0;
sqlstm.sqharm[13] = (unsigned long )0;
sqlstm.sqadto[13] = (unsigned short )0;
sqlstm.sqtdso[13] = (unsigned short )0;
sqlstm.sqhstv[14] = (unsigned char  *)&shIndEstado;
sqlstm.sqhstl[14] = (unsigned long )sizeof(short);
sqlstm.sqhsts[14] = (         int  )0;
sqlstm.sqindv[14] = (         short *)&i_shIndEstado;
sqlstm.sqinds[14] = (         int  )0;
sqlstm.sqharm[14] = (unsigned long )0;
sqlstm.sqadto[14] = (unsigned short )0;
sqlstm.sqtdso[14] = (unsigned short )0;
sqlstm.sqhstv[15] = (unsigned char  *)&lhCodCiclFact;
sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
sqlstm.sqhsts[15] = (         int  )0;
sqlstm.sqindv[15] = (         short *)&i_shCodCiclFact;
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



   if (SQLCODE != SQLOK && SQLCODE != ORA_NULL)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Insert->Fa_Procesos",
                szfnORAerror());

   return (SQLCODE != SQLOK && SQLCODE != ORA_NULL)?FALSE:TRUE;
}/************************* Final bInsertaProceso ***************************/

/****************************************************************************/
/*                          funcion : iCmpLetras                            */
/****************************************************************************/
int iCmpLetras (const void* cad1, const void* cad2)
{
  int rc = 0;

  return
   ( (rc = ((LETRAS *)cad1)->iCodTipDocum-
           ((LETRAS *)cad2)->iCodTipDocum ) != 0)?rc:
   ( (rc = ((LETRAS *)cad1)->iCodCatImpos-
           ((LETRAS *)cad2)->iCodCatImpos ) != 0)?rc:0;

}/************************* Final iCmpLetras ********************************/

/*****************************************************************************/
/*                          funcion : vPrintLetras                           */
/*****************************************************************************/
void vPrintLetras (LETRAS *pLetras,int iNumLetra)
{
  int iInd = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t*** Tabla GE_LETRAS ***\n",LOG06);

        for (iInd=0;iInd<iNumLetra;iInd++)
        {
            vDTrazasLog (szExeName,
                        "\t[%d]-Cod.Tipo Documento..............[%d]\n"
                        "\t[%d]-Cod.Categoria Impositiva........[%d]\n"
                        "\t[%d]-Letra...........................[%s]\n"
                        ,LOG06
                        ,iInd,pLetras->iCodTipDocum
                        ,iInd,pLetras->iCodCatImpos
                        ,iInd,pLetras->szLetra);
            pLetras++;
        }
    }
}/************************ Final iPrintLetras ********************************/

/*****************************************************************************/
/*                         funcion : bFindLetras                             */
/*****************************************************************************/
BOOL bGetLetra (int iCodTipDocum,int iCodCatImpos,char *szLetra)

{
  LETRAS  stkey                  ;
  LETRAS *pLetra = (LETRAS *)NULL;
  BOOL    bRes   = TRUE          ;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodTipDocum;
  static int   ihCodCatImpos;
  static char* szhLetra     ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Ge_Letras\n"
                         "\t\t* CodTipDocum [%d]\n"
                         "\t\t* CodCatImpos [%d]\n",LOG05,
                         iCodTipDocum,iCodCatImpos);

  if (iCodTipDocum == stDatosGener.iCodCiclo)
  {
      stkey.iCodTipDocum = iCodTipDocum;
      stkey.iCodCatImpos = iCodCatImpos;

      if ( (pLetra = (LETRAS *)bsearch (&stkey,pstLetras,NUM_LETRAS,
            sizeof(LETRAS),iCmpLetras)) == (LETRAS *)NULL)
      {
            iDError (szExeName,ERR021,vInsertarIncidencia,
                     "pstLetras (Ge_Letras)");
            bRes = FALSE;
      }
      if (bRes)
          strcpy (szLetra,pLetra->szLetra);
  }
  else
  {
     ihCodTipDocum = iCodTipDocum;
     ihCodCatImpos = iCodCatImpos;
     szhLetra      = szLetra     ;
     /* EXEC SQL SELECT /o+ index (GE_LETRAS PK_GE_LETRAS) o/
                     LETRA
              INTO   :szhLetra
              FROM   GE_LETRAS
              WHERE  COD_TIPDOCUM = :ihCodTipDocum
                AND  COD_CATIMPOS = :ihCodCatImpos; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 39;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select  /*+  index (GE_LETRAS PK_GE_LETRAS)  +*/ LETRA i\
nto :b0  from GE_LETRAS where (COD_TIPDOCUM=:b1 and COD_CATIMPOS=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1731;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhLetra;
     sqlstm.sqhstl[0] = (unsigned long )2;
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
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCatImpos;
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


     if (SQLCODE != SQLOK)
     {
         iDError (szExeName,ERR000,vInsertarIncidencia,
                  "Select->Ge_Letras",szfnORAerror());
         return FALSE;
     }
  }

  return (bRes);
}/*********************** Final bGetLetra ************************************/

/*****************************************************************************/
/*                         funcion : iCmpDocumSucursal                       */
/*****************************************************************************/
int iCmpDocumSucursal (const void *cad1,const void *cad2)
{
   int rc = 0;

   return
    ( (rc = strcmp ( ((DOCUMSUCURSAL *)cad1)->szCodOficina,
                     ((DOCUMSUCURSAL *)cad2)->szCodOficina) ) != 0)?rc:
    ( (rc = ((DOCUMSUCURSAL *)cad1)->iCodTipDocum-
            ((DOCUMSUCURSAL *)cad2)->iCodTipDocum) != 0)?rc:0;

}/************************ Final iCmpDocumSucursal **************************/

/****************************************************************************/
/*                         funcion : vPrintDocumSucursal                    */
/****************************************************************************/
void vPrintDocumSucursal (DOCUMSUCURSAL *pDoc,int iNumDoc)
{
    int iInd = 0;

    vDTrazasLog (szExeName,"\n\t*** Tabla AL_DOCUM_SUCURSAL ***\n",LOG06);
    if (stStatus.LogNivel >= LOG06)
    {

        for (iInd=0;iInd<iNumDoc;iInd++)
        {
            vDTrazasLog (szExeName,
                        "\t[%d]-Cod.Oficina.....................[%s]\n"
                        "\t[%d]-Cod.Tipo Documento..............[%d]\n"
                        "\t[%d]-Cod.Centro Emisor...............[%d]\n"
                        ,LOG06
                        ,iInd,pDoc->szCodOficina
                        ,iInd,pDoc->iCodTipDocum
                        ,iInd,pDoc->iCodCentrEmi);
            pDoc++;
        }
    }
}/************************ Final vPrintDocumSucursal ************************/

/****************************************************************************/
/*                         funcion : bGetCentrEmi                           */
/****************************************************************************/
BOOL bGetCentrEmi (char *szCodOficina,
                   int   iCodTipDocum,
                   int  *iCodCentrEmi)
{
  BOOL bRes = FALSE;
  int  iInd = 0    ;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char* szhCodOficina ; /* EXEC SQL VAR szhCodOficina IS STRING(3); */ 

  static int   ihCodTipDocum ;
  static int   ihCodCentrEmi ;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  if (iCodTipDocum == stDatosGener.iCodCiclo)
  {
      vDTrazasLog (szExeName,"\n\t\t* Parametros entra Al_Docum_Sucursal\n"
                             "\t\t=> Cod.TipDocum [%d]\n",LOG05,iCodTipDocum);

      while (!bRes && iInd<NUM_DOCUMSUCURSAL)
      {
             if (pstDocumSucursal[iInd].iCodTipDocum == iCodTipDocum)
                 bRes = TRUE;
             else
                iInd++;
      }

      if (bRes)
      {
          *iCodCentrEmi = pstDocumSucursal[iInd].iCodCentrEmi      ;
          strcpy (szCodOficina,pstDocumSucursal[iInd].szCodOficina);
      }
      else
      {
         iDError (szExeName,ERR021,vInsertarIncidencia,"pstDocumSucursal");
      }
  }
  else
  {
     vDTrazasLog (szExeName,"\n\t\t* Parametros entra Al_Docum_Sucursal\n"
                            "\t\t=> Cod.Oficina  [%s]\n"
                            "\t\t=> Cod.TipDocum [%d]\n",LOG05,
                            szCodOficina,iCodTipDocum);

     szhCodOficina = szCodOficina;
     ihCodTipDocum = iCodTipDocum;
     /* EXEC SQL SELECT /o+ index (AL_DOCUM_SUCURSAL PK_AL_DOCUM_SUCURSAL) o/
                     COD_CENTREMI
              INTO   :ihCodCentrEmi
              FROM   AL_DOCUM_SUCURSAL
              WHERE  COD_OFICINA = :szhCodOficina
                AND  COD_TIPDOCUM= :ihCodTipDocum; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 39;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select  /*+  index (AL_DOCUM_SUCURSAL PK_AL_DOCUM_SUCURS\
AL)  +*/ COD_CENTREMI into :b0  from AL_DOCUM_SUCURSAL where (COD_OFICINA=:b1 \
and COD_TIPDOCUM=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1758;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCentrEmi;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodOficina;
     sqlstm.sqhstl[1] = (unsigned long )3;
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
     sqlstm.sqphsv = sqlstm.sqhstv;
     sqlstm.sqphsl = sqlstm.sqhstl;
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
         iDError (szExeName,ERR000,vInsertarIncidencia,
                  "Select->Al_Docum_Sucursal",szfnORAerror());
         bRes = FALSE;
     }
     else
     {
         *iCodCentrEmi = ihCodCentrEmi;
         bRes = TRUE;
     }
  }
  return (bRes);

}/************************ Final bGetCentrEmi *******************************/


/*****************************************************************************/
/*                       funcion : bGetConcOrig                              */
/* -Entrada CodConcepto, CodConcorig (->salida)                              */
/* -Salida  Error->FALSE, !Error->TRUE                                       */
/*****************************************************************************/
BOOL bGetConcOrig (int   iCodConcepto ,
                   char *szCodMoneda  ,
                   char *szDesConcepto,
                   int  *iCodConcOrig)
{
   CONCEPTO pConc;
   int       iRes  = 0               ;

    vDTrazasLog (szExeName,
                "\n\t* Busqueda de Concepto Origen en Tabla Dinamica pstConceptos "
                "\n\t\t\t  ==> Numero de Conceptos  : [ %d ]  "
                "\n\t\t\t  ==> Concepto             : [ %d ]  ",
                LOG03,
                NUM_CONCEPTOS,
                iCodConcepto ) ;


   if (!bFindConcepto (iCodConcepto,&pConc))
   {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
        iRes  = ERR021;
   }

   if ( iRes == 0 && pConc.iCodConcOrig == ORA_NULL)
   {
        iDError (szExeName,ERR005,vInsertarIncidencia,iCodConcepto);
        stAnomProceso.iCodConcepto = iCodConcepto                  ;
        iRes = ERR005                                              ;
   }
   if ( iRes == 0 && strcmp (szCodMoneda,pConc.szCodMoneda) != 0)
   {
        iDError (szExeName,ERR004,vInsertarIncidencia,iCodConcepto,
                 pConc.iCodConcOrig);
        iRes = ERR004                ;
   }
   if ( iRes == 0 && (pConc.iIndActivo   == 0 ||
                      pConc.iCodTipConce != DESCUENTO) )
   {
        iDError (szExeName,ERR001,vInsertarIncidencia,
                 pConc.iIndActivo  ,
                 pConc.iCodTipConce,0);
        iRes = ERR001;
   }
   else
   {
        strcpy (szDesConcepto,pConc.szDesConcepto);
        *iCodConcOrig = pConc.iCodConcOrig        ;
   }
   if (iRes == 0)
   {
    vDTrazasLog (szExeName,
                "\n\t* Concepto Origen [%d] Para el Concepto con Descuento [%d]\n",
                LOG05,
                pConc.iCodConcOrig,
                iCodConcepto ) ;
    }
    return (iRes == 0)?TRUE:FALSE;
}/************************** Final bGetConcOrig ******************************/

/* ------------------------------------------------------------------------- */
/*                         funcion vInitAnomProceso                          */
/* ------------------------------------------------------------------------- */
void vInitAnomProceso (ANOMPROCESO *pAnomProceso)
{
  pAnomProceso->lNumProceso  = 0;
  pAnomProceso->lCodCliente  = 0;
  pAnomProceso->lNumAbonado  = 0;
  pAnomProceso->iCodConcepto = 0;
  pAnomProceso->iCodProducto = 0;
  pAnomProceso->lCodCiclFact = 0;
  strcpy (pAnomProceso->szDesProceso,"") ;
  strcpy (pAnomProceso->szObsAnomalia,"");
}/************************ Final vInitAnomProceso ****************************/

/*****************************************************************************/
/*                         funcion : vPrintGeImpuestos                       */
/*****************************************************************************/
void vPrintGeImpuestos (IMPUESTOS *pImp,int iNumImp)
{
    int iInd = 0;
    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t*** Tabla GE_IMPUESTOS ***\n",LOG06);
        for (iInd=0;iInd<NUM_IMPUESTOS;iInd++)
        {
            vDTrazasLog (szExeName, "\n\t[%d]-Cod.CatImpos.......................[%d]"
                                   "\n\t[%d]-Cod.ZonaImpos......................[%d]"
                                   "\n\t[%d]-Cod.Tipo Impuesto..................[%d]"
                                   "\n\t[%d]-Cod.GrupServi......................[%d]"
                                   "\n\t[%d]-Fec.Desde..........................[%s]"
                                   "\n\t[%d]-Cod.ConcGene.......................[%d]"
                                   "\n\t[%d]-Fec.Hasta..........................[%s]"
                                   "\n\t[%d]-Porcentaje Impuesto................[%f]"
                                   ,LOG06,iInd,pImp->iCodCatImpos
                                   ,iInd,pImp->iCodZonaImpo ,iInd,pImp->iCodTipImpues
                                   ,iInd,pImp->iCodGrpServi ,iInd,pImp->szFecDesde
                                   ,iInd,pImp->iCodConcGene ,iInd,pImp->szFecHasta
                                   ,iInd,pImp->fPrcImpuesto );

            pImp++;
        }
    }
}/************************ Final vPrintImpuestos *****************************/

/* ------------------------------------------------------------------------- */
/*   bGetNumSecuenciaEmi (int,char*,int,long*)                               */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
BOOL bGenNumSecuenciasEmi (int iCodTipDocum, char* szLetra,
                           int iCodCentrEmi, long* lNumSecuEmi)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int   ihCodTipDocum    ;
  static int   ihCodCentrEmi    ;
  static char* szhLetra         ; /* EXEC SQL VAR szhLetra IS STRING (2) ; */ 

  static long  lhNumSecuenci    ;
  /* EXEC SQL END DECLARE SECTION; */ 


  szhLetra      = szLetra     ;
  ihCodTipDocum = iCodTipDocum;
  ihCodCentrEmi = iCodCentrEmi;

  vDTrazasLog (szExeName,"\n\t\t* Parametros entrada Ge_SecuenciasEmi\n"
                         "\t\t=> Tipo De Documento [%d]\n"
                         "\t\t=> Cod. CentrEmi     [%d]\n"
                         "\t\t=> Letra             [%s]\n",LOG05,
                         ihCodTipDocum,ihCodCentrEmi,szhLetra);

  vDTrazasLog (szExeName,"\n\t\t* Tipo Documento stProceso [%d]\n", LOG05,stProceso.iCodTipDocum );

  if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
  {
      /* EXEC SQL SELECT FA_SEQ_CICLO.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_CICLO.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1785;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodContado)
  {
      /* EXEC SQL SELECT FA_SEQ_CONTADO.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_CONTADO.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1804;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodMiscela)
  {
      /* EXEC SQL SELECT FA_SEQ_MISCELANEA.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_MISCELANEA.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1823;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodBaja)
  {
      /* EXEC SQL SELECT FA_SEQ_BAJA.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_BAJA.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1842;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodNotaCre)
  {
      /* EXEC SQL SELECT FA_SEQ_CREDITO.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_CREDITO.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1861;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodNotaDeb)
  {
      /* EXEC SQL SELECT FA_SEQ_DEBITO.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_DEBITO.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1880;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodLiquidacion)
  {
      /* EXEC SQL SELECT FA_SEQ_LIQUIDACION.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_LIQUIDACION.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1899;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (stProceso.iCodTipDocum == stDatosGener.iCodRoamingVis)
  {
      /* EXEC SQL SELECT FA_SEQ_ROAMINGVIS.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_SEQ_ROAMINGVIS.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1918;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  else if (iCodTipDocum == stDatosGener.iDocStaff)
  {
      /* EXEC SQL SELECT CO_SEQ_PAGO.NEXTVAL INTO :lhNumSecuenci
                 FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 39;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select CO_SEQ_PAGO.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1937;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
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
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "=> Secuencias Emision", szfnORAerror ());
      return FALSE;
  }
  *lNumSecuEmi = lhNumSecuenci;

  return TRUE;
}/*********************** Final bGenSecuenciasEmi ****************************/


/*****************************************************************************/
/*                       funcion : bGenProcesoII                             */
/* -Funcion que genera nuevo registro en Fa_Procesos para el caso de una ven-*/
/*  ta contado tenga dos modalidades una de Contado y otra de Credito        */
/* -Utilizamos variables globales como :                                     */
/*      * stCliente.iModVenta si es 2 => Contado y Credito                   */
/*      * si stCliente.iModVenta = 2  => Abremos recuperado stStatus.IdPro2  */
/*        el nuevo proceso a insertar.                                       */
/*      * stProceso que estara rellena por la informacion introducida en la  */
/*        tabla Fa_Procesos (solo cambia NumProceso y NumSecuAg              */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bGenProcesoII (void)
{
  if (stCliente.iModVenta == 2)
  {
      if (!bGenNumSecuenciasEmi (stProceso.iCodTipDocum,stProceso.szLetraAg,
                                 stProceso.iCodCentrEmi,&stProceso.lNumSecuAg))
           return FALSE;

      stProceso.lNumProceso = stStatus.IdPro2;
      if (!bInsertaProceso (stProceso))
          return FALSE;
  }
  return TRUE;
}/************************** Final bGenProcesoII *****************************/

long gregorianoajuliano(int dia, int mes, int anno)
{
   /* dada una fecha del calendario gregoriano, obtiene */
   /*un entero que la representa */
   long tmes, tanno;
   long jdia;
   /* marzo es el mes 0 del año */
   if (mes > 2)
   {
      tmes = mes - 3;
      tanno = anno;
   }
   else
   /* febrero es el mes 11 del año anterior. */
   {
      tmes = mes + 9;
      tanno = anno - 1;
   }
   jdia = (tanno / 4000) * 1460969;
   tanno = (tanno % 4000);
   jdia = jdia +
      (((tanno / 100) * 146097) / 4) +
      (((tanno % 100) * 1461) / 4) +
      (((153 * tmes) + 2) / 5) +
      dia +
      1721119;
   return jdia;
}


/*****************************************************************************/
/*                      funcion : bRestaFechas                               */
/* -Funcion que resta Fecha1 y Fecha2                                        */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bRestaFechas (char *szFecha1,char *szFecha2,int *iNumDias)
{
    char szDia1 [3];
    char szMes1 [3];
    char szAno1 [5];
    char szDia2 [3];
    char szMes2 [3];
    char szAno2 [5];
    long lValjul ;

    vDTrazasLog (szExeName,"\n\t\t* Resta Fechas : %s - %s \n"
                          ,LOG06,szFecha1,szFecha2);

        sprintf ( szDia1, "%c%c", szFecha1[6],szFecha1[7]);
        sprintf ( szMes1, "%c%c", szFecha1[4],szFecha1[5]);
        sprintf ( szAno1, "%c%c%c%c", szFecha1[0],szFecha1[1],szFecha1[2],szFecha1[3]);

        sprintf ( szDia2, "%c%c", szFecha2[6],szFecha2[7]);
        sprintf ( szMes2, "%c%c", szFecha2[4],szFecha2[5]);
        sprintf ( szAno2, "%c%c%c%c", szFecha2[0],szFecha2[1],szFecha2[2],szFecha2[3]);

        lValjul = gregorianoajuliano(atoi(szDia1),atoi(szMes1),atoi(szAno1)) - gregorianoajuliano(atoi(szDia2),atoi(szMes2),atoi(szAno2));

        lValjul = (lValjul <= 0)?(-1*(lValjul)):(lValjul+1);

    *iNumDias =(int)lValjul;

    vDTrazasLog (szExeName,"\t\t* Resta Fechas : Dias Calculados [%d]"
                          ,LOG06,*iNumDias);
    return (TRUE);

}



/*****************************************************************************/
/*                        funcion : vRestaFechas                             */
/*****************************************************************************/
void vRestaFechas (char *szFecha1, char *szFecha2, int *iNumDias)
{
   char szAnoI [5] = "";
   char szAnoF [5] = "";
   char szMesI [3] = "";
   char szMesF [3] = "";
   char szDiaI [3] = "";
   char szDiaF [3] = "";

   if (strncmp (szFecha1,szFecha2,8) > 0)
   {
       strncpy (szAnoI,szFecha2,4);
       strncpy (szAnoF,szFecha1,4);
       strncpy (szMesI,szFecha2+4,2);
       strncpy (szMesF,szFecha1+4,2);
       strncpy (szDiaI,szFecha2+6,2);
       strncpy (szDiaF,szFecha1+6,2);

   }
   else
   {
       strncpy (szAnoI,szFecha1,4);
       strncpy (szAnoF,szFecha2,4);
       strncpy (szMesI,szFecha1+4,2);
       strncpy (szMesF,szFecha2+4,2);
       strncpy (szDiaI,szFecha1+6,2);
       strncpy (szDiaF,szFecha2+6,2);
   }

   szAnoI [4] = '\0';
   szAnoF [4] = '\0';
   szMesI [2] = '\0';
   szMesF [2] = '\0';
   szDiaI [2] = '\0';
   szDiaF [2] = '\0';

/* rao: no hace nada ????? validar su eliminacion */


}/********************** Final vRestaFechas **********************************/

/*****************************************************************************/
/*                       funcion : bAnoBisiesto                              */
/* -Funcion que comprueba que un ano es bisiesto o no.                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bAnoBisiesto (int iAno)
{
   if (iAno % 400 == 0)
       return TRUE;
   if (iAno % 100 == 0)
       return FALSE;
   if (iAno % 4   == 0)
       return TRUE;
}/****************************** Final bAnoBisiesto **************************/

/*****************************************************************************/
/*                               funcion : vDiasMes                          */
/* -Funcion que calcula los Dias del Mes de un Ano determinado               */
/*****************************************************************************/
void vDiasMes (int iAno, int iMes, int *iDiasMes)
{
   switch (iMes)
   {
       case 1 : /* Enero */
                *iDiasMes = 31;
                break;
       case 2 : /* Febrero */
/*
                *iDiasMes = (bBisiesto (iAno))?29:28; */
                break;
       case 3 : /* Marzo */
                *iDiasMes = 31;
                break;
       case 4 : /* Abril */
                *iDiasMes = 30;
                break;
       case 5 : /* Mayo */
                *iDiasMes = 31;
                break;
       case 6 : /* Junio */
                *iDiasMes = 30;
                break;
       case 7 : /* Julio */
                *iDiasMes = 31;
                break;
       case 8 : /* Agosto */
                *iDiasMes = 31;
                break;
       case 9 : /* Septiembre */
                *iDiasMes = 30;
                break;
       case 10: /* Octubre */
                *iDiasMes = 31;
                break;
       case 11: /* Noviembre */
                *iDiasMes = 30;
                break;
       case 12: /* Diciembre */
                *iDiasMes = 31;
                break;
   }

}/****************************** Final vDiasMes ******************************/

/*****************************************************************************/
/*                        funcion : iCmpGrupoCob                             */
/*****************************************************************************/
int iCmpGrupoCob (const void* cad1,const void* cad2)
{
  int rc = 0;

  return
   ( (rc = strcmp ( ((GRUPOCOB *)cad1)->szCodGrupo,
                    ((GRUPOCOB *)cad2)->szCodGrupo ) ) != 0)?rc:
   ( (rc = ((GRUPOCOB *)cad1)->iCodConcepto-
           ((GRUPOCOB *)cad2)->iCodConcepto) != 0)?rc:
   ( (rc = ((GRUPOCOB *)cad1)->iCodProducto-
           ((GRUPOCOB *)cad2)->iCodProducto) != 0)?rc:
   ( (rc = ((GRUPOCOB *)cad1)->iCodCiclo-
           ((GRUPOCOB *)cad2)->iCodCiclo) != 0)?rc:0;

}/********************** Final iCmpGrupoCob **********************************/


/*****************************************************************************/
/*                       funcion : vPrintGrupoCob                            */
/*****************************************************************************/
void vPrintGrupoCob (GRUPOCOB *pGrp,int iNumGrp)
{
    int iInd = 0;
    if (stStatus.LogNivel >= LOG06)
    {

        vDTrazasLog (szExeName,"\n\t*** Tabla FA_GRUPOCOB ***\n",LOG06);

        for (iInd=0;iInd<iNumGrp;iInd++)
        {
            vDTrazasLog (szExeName,"\n\t[%d]-Cod.Producto......................[%d]"
                                  "\n\t[%d]-Cod.Concepto......................[%d]"
                                  "\n\t[%d]-Cod.Grupo.........................[%s]"
                                  "\n\t[%d]-Cod.Ciclo.........................[%d]"
                                  "\n\t[%d]-Tip.Cobro.........................[%d]"
                                  "\n\t[%d]-Fec.Desde.........................[%s]"
                                  "\n\t[%d]-Fec.Hasta.........................[%s]"
                                  ,LOG06,iInd,pGrp->iCodProducto
                                  ,iInd,pGrp->iCodConcepto ,iInd,pGrp->szCodGrupo
                                  ,iInd,pGrp->iCodCiclo    ,iInd,pGrp->iTipCobro
                                  ,iInd,pGrp->szFecDesde   ,iInd,pGrp->szFecHasta);
            pGrp++;
        }
    }
}/********************** Final vPrintGrupoCob ********************************/

/*****************************************************************************/
/*                           funcion : vEligeDirLogs                         */
/*****************************************************************************/
void vEligeDirLogs (char* szLog, char* szErr,int iTipoFact)
{
  char szName [15] = "";

  switch (iTipoFact)
  {
      case FACT_CONTADO    :
           strcpy (szName,"Contado")    ;
           break                        ;
      case FACT_LIQUIDACION:
           strcpy (szName,"Liquidacion");
           break                        ;
      case FACT_RENTAPHONE :
           strcpy (szName,"RentPhone")  ;
           break                        ;
      case FACT_BAJA       :
           strcpy (szName,"Baja")       ;
           break                        ;
      case FACT_ROAMINGVIS :
           strcpy (szName,"Roaming")    ;
           break                        ;
      case FACT_CICLO      :
           strcpy (szName,"Ciclo")      ;
           break                        ;
      case FACT_NOTADEBI   :
           strcpy (szName,"Nota_Debito") ;
           break                         ;
      case FACT_NOTACRED   :
           strcpy (szName,"Nota_Credito");
           break                         ;
      case FACT_COMPRA     :
           strcpy (szName,"Compra")      ;
            break                        ;
      case FACT_MISCELAN    :
           strcpy (szName,"Miscela")     ;
            break                        ;
      default:
           break;
  }
  if (iTipoFact == FACT_CONTADO   || iTipoFact == FACT_LIQUIDACION ||
      iTipoFact == FACT_RENTAPHONE|| iTipoFact == FACT_BAJA        ||
      iTipoFact == FACT_ROAMINGVIS|| iTipoFact == FACT_NOTADEBI    ||
      iTipoFact == FACT_NOTACRED  || iTipoFact == FACT_COMPRA      ||
      iTipoFact == FACT_MISCELAN)
  {
/* Sete para ejecución Produccion */  	
      sprintf (szLog,"%s%8.8s/Factura_%s_%ld_%6.6s.log",stDatosGener.szDirLogs,
               szSysDate,szName,stStatus.IdPro, (szSysDate+7));
      sprintf (szErr,"%s%8.8s/Factura_%s_%ld_%6.6s.err",stDatosGener.szDirLogs,
               szSysDate, szName,stStatus.IdPro, (szSysDate+7));

/* Seteo para ejecución desde Desarrollo a Pre-producción */               
      /*sprintf (szLog,"/desarrollo/proyectos/sclgte/facturacion/log/factura/ciclo/20100421/Factura_%s_%ld_%6.6s.log",
               szName,stStatus.IdPro, (szSysDate+7));
      sprintf (szErr,"/desarrollo/proyectos/sclgte/facturacion/log/factura/ciclo/20100421/Factura_%s_%ld_%6.6s.err",
               szName,stStatus.IdPro, (szSysDate+7));*/
               
  }
  else
  {
      if (stCliente.lCodCliente == ORA_NULL)
          sprintf (szLog,"%s%8.8s/Factura_%s_%ld_%d_%s.log",
                   stCiclo.szDirLogs,szSysDate, szName,
                   stCiclo.lCodCiclFact,0, szSysDate);

      sprintf (szLog,"%s%8.8s/Factura_%s_%ld_%ld_%s.log",stCiclo.szDirLogs,
               szSysDate, szName,
               stCiclo.lCodCiclFact,stCliente.lCodCliente, szSysDate)   ;
      sprintf (szErr,"%s%8.8s/Factura_%s_%ld_%s.err",
               stCiclo.szDirLogs, szSysDate, szName,stCiclo.lCodCiclFact,
               szSysDate);
  }
}/************************ Final vEligeDirLogs *******************************/


/*****************************************************************************/
/*                         funcion : bGetUltimoCliPro                        */
/* -Funcion que recupera el ultimo Cliente procesado en caso de haber y sino */
/*  devuelve 0 a stCliente.lCodCliente.                                      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bGetUltimoCliPro (int iCodCiclo, long lCodCiclFact, int iTipoFactura, long *lCodCliente, long *lNumProceso)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int  ihCodTipDocum;
  static int  ihCodCiclo  ;
  static long lhCodCiclFact;

  static long lhCodCliente;
  static short i_hCodCliente;
  static long lhNumProceso;

  /* EXEC SQL END DECLARE SECTION  ; */ 


  ihCodCiclo    = iCodCiclo;
  lhCodCiclFact = lCodCiclFact;
  ihCodTipDocum = iTipoFactura ;

  lhNumProceso = 0;

  vDTrazasLog (szExeName, "\n\t**   InitInstance   **"
                          "\n\t\t   Codigo de Ciclo         [%d]"
                          "\n\t\t   Codigo de Ciclo Fact    [%ld]"
                          "\n\t\t   Tipo de Factura         [%d]",
                          LOG03,iCodCiclo,lCodCiclFact,iTipoFactura);

  /* EXEC SQL SELECT /o+ index_desc (FA_PROCESOS PK_FA_PROCESOS ) o/
                    NUM_PROCESO
           INTO     :lhNumProceso
           FROM     FA_PROCESOS
           WHERE    NUM_PROCESO > 0
           AND      COD_TIPDOCUM   = :ihCodTipDocum
           AND      COD_CICLFACT   = :lhCodCiclFact
           AND      ROWNUM      = 1; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 39;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index_desc (FA_PROCESOS PK_FA_PROCESOS )  +*/ \
NUM_PROCESO into :b0  from FA_PROCESOS where (((NUM_PROCESO>0 and COD_TIPDOCUM\
=:b1) and COD_CICLFACT=:b2) and ROWNUM=1)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1956;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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


  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select Num_Proceso para Factura de Ciclo",
               szfnORAerror());
      return FALSE;
  }

  if (lhNumProceso == 0)
  {
      *lCodCliente = 0;
      *lNumProceso = 0;
      return (TRUE);
  }

  /* EXEC SQL SELECT /o+ index_desc (FA_CICLOCLI UK_FA_CICLOCLI_CICL_CICLOO) o/
                  max(COD_CLIENTE)
           INTO   :lhCodCliente:i_hCodCliente
           FROM   FA_CICLOCLI
           WHERE  COD_CICLO   = :ihCodCiclo
             AND  NUM_PROCESO = :lhNumProceso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 39;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index_desc (FA_CICLOCLI UK_FA_CICLOCLI_CICL_CI\
CLOO)  +*/ max(COD_CLIENTE) into :b0:b1  from FA_CICLOCLI where (COD_CICLO=:b2\
 and NUM_PROCESO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1983;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)&i_hCodCliente;
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



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND && i_hCodCliente != ORA_NULL)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select Ultimo Cliente del Ciclo de Fa_CicloCli",
               szfnORAerror());
      return FALSE;
  }
  if (SQLCODE == SQLOK)
  {
      *lCodCliente = lhCodCliente;
      *lNumProceso = lhNumProceso;
  }
  if (SQLCODE == SQLNOTFOUND || i_hCodCliente == ORA_NULL)
  {
      *lCodCliente = 0;
      *lNumProceso = lhNumProceso;
  }
  return (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)?FALSE:TRUE;
}/************************ Final bGetUltimoCliPro ****************************/


/*****************************************************************************/
/*                        funcion : vPrintRegInsert                          */
/*****************************************************************************/
void vPrintRegInsert (int i,char *szFuncion,BOOL bError)
{
    char szFunc [20] = "";

    strcpy (szFunc,szFuncion);
    if (!bError)
    {
        vDTrazasLog (szExeName,
                    "\n\t\t==>Insertando Registro en FA_PRESUPUESTO (%s):\n\n"
                    "\t\tNumProceso   [%ld]\n"
                    "\t\tCliente      [%ld]\n"
                    "\t\tCod.Concepto [%d] \n"
                    "\t\tColumna      [%ld]\n"
                    "\t\tProducto     [%d] \n"
                    "\t\tCod.Moneda   [%s] \n"
                    "\t\tFec.Valor    [%s] \n"
                    "\t\tFec.Efectiv. [%s] \n"
                    "\t\tImp.Concepto [%lf]\n"
                    "\t\tImp.Factura  [%lf]\n"
                    "\t\tImp.MontoBase[%lf]\n"
                    "\t\tRegion       [%s] \n"
                    "\t\tProvincia    [%s] \n"
                    "\t\tCiudad       [%s] \n"
                    "\t\tModulo       [%s] \n"
                    "\t\tPlan.Comerc. [%d] \n"
                    "\t\tInd. Factur  [%d] \n"
                    "\t\tCod.CatImpos [%d] \n"
                    "\t\tInd.Estado   [%d] \n"
                    "\t\tTipo Concep. [%d] \n"
                    "\t\tNum.Unidades [%d] \n"
                    "\t\tCiclo Fact.  [%ld]\n"
                    "\t\tConcepto Rel.[%d] \n"
                    "\t\tColumna Rel. [%ld]\n"
                    "\t\tNum. Abonado [%ld]\n"
                    "\t\tNum. Terminal[%s] \n"
                    "\t\tCap. Code    [%ld]\n"
                    "\t\tNum. SerieMec[%s] \n"
                    "\t\tNum. SerieLe [%s] \n"
                    "\t\tFla. Impues  [%d] \n"
                    "\t\tFla. Dto.    [%d] \n"
                    "\t\tPrc. Impues. [%f] \n"
                    "\t\tVal. Dto.    [%f] \n"
                    "\t\tTip. Dto.    [%d] \n"
                    "\t\tNum. Venta   [%ld]\n"
                    "\t\tNum. Transac.[%ld]\n"
                    "\t\tMes  Garantia[%d] \n"
                    "\t\tNum. Guia    [%s] \n"
                    "\t\tInd. Alta    [%d] \n"
                    "\t\tInd. SuperTel[%d] \n"
                    "\t\tNum. Paquete [%d] \n"
                    "\t\tInd. Cuota   [%d] \n"
                    "\t\tNum. Cuotas  [%d] \n"
                    "\t\tOrd. Cuota   [%d] \n",LOG06,szFunc    ,
                    stPreFactura.A_PFactura[i].lNumProceso     ,
                    stPreFactura.A_PFactura[i].lCodCliente     ,
                    stPreFactura.A_PFactura[i].iCodConcepto    ,
                    stPreFactura.A_PFactura[i].lColumna        ,
                    stPreFactura.A_PFactura[i].iCodProducto    ,
                    stPreFactura.A_PFactura[i].szCodMoneda     ,
                    stPreFactura.A_PFactura[i].szFecValor      ,
                    stPreFactura.A_PFactura[i].szFecEfectividad,
                    stPreFactura.A_PFactura[i].dImpConcepto    ,
                    stPreFactura.A_PFactura[i].dImpFacturable  ,
                    stPreFactura.A_PFactura[i].dImpMontoBase   ,
                    stPreFactura.A_PFactura[i].szCodRegion     ,
                    stPreFactura.A_PFactura[i].szCodProvincia  ,
                    stPreFactura.A_PFactura[i].szCodCiudad     ,
                    stPreFactura.A_PFactura[i].szCodModulo     ,
                    stPreFactura.A_PFactura[i].lCodPlanCom     ,
                    stPreFactura.A_PFactura[i].iIndFactur      ,
                    stPreFactura.A_PFactura[i].iCodCatImpos    ,
                    stPreFactura.A_PFactura[i].iIndEstado      ,
                    stPreFactura.A_PFactura[i].iCodTipConce    ,
                    stPreFactura.A_PFactura[i].lNumUnidades    ,       /* Incorporado por PGonzaleg 26-02-2002 */
                    stPreFactura.A_PFactura[i].lCodCiclFact    ,
                    stPreFactura.A_PFactura[i].iCodConceRel    ,
                    stPreFactura.A_PFactura[i].lColumnaRel     ,
                    stPreFactura.A_PFactura[i].lNumAbonado     ,
                    stPreFactura.A_PFactura[i].szNumTerminal   ,
                    stPreFactura.A_PFactura[i].lCapCode        ,
                    stPreFactura.A_PFactura[i].szNumSerieMec   ,
                    stPreFactura.A_PFactura[i].szNumSerieLe    ,
                    stPreFactura.A_PFactura[i].iFlagImpues     ,
                    stPreFactura.A_PFactura[i].iFlagDto        ,
                    stPreFactura.A_PFactura[i].fPrcImpuesto    ,
                    stPreFactura.A_PFactura[i].dValDto         ,
                    stPreFactura.A_PFactura[i].iTipDto         ,
                    stPreFactura.A_PFactura[i].lNumVenta       ,
                    stPreFactura.A_PFactura[i].lNumTransaccion ,
                    stPreFactura.A_PFactura[i].iMesGarantia    ,
                    stPreFactura.A_PFactura[i].szNumGuia       ,
                    stPreFactura.A_PFactura[i].iIndAlta        ,
                    stPreFactura.A_PFactura[i].iIndSuperTel    ,
                    stPreFactura.A_PFactura[i].iNumPaquete     ,
                    stPreFactura.A_PFactura[i].iIndCuota       ,
                    stPreFactura.A_PFactura[i].iNumCuotas      ,
                    stPreFactura.A_PFactura[i].iOrdCuota       );
    }
    else
    {
        vDTrazasError (szExeName,
                        "\n\t\t==>Insertando Registro en FA_PRESUPUESTO (%s):\n\n"
                        "\t\tNumProceso   [%ld]\n"
                        "\t\tCliente      [%ld]\n"
                        "\t\tCod.Concepto [%d] \n"
                        "\t\tColumna      [%ld]\n"
                        "\t\tProducto     [%d] \n"
                        "\t\tCod.Moneda   [%s] \n"
                        "\t\tFec.Valor    [%s] \n"
                        "\t\tFec.Efectiv. [%s] \n"
                        "\t\tImp.Concepto [%lf]\n"
                        "\t\tImp.Factura  [%lf]\n"
                        "\t\tImp.MontoBase[%lf]\n"
                        "\t\tRegion       [%s] \n"
                        "\t\tProvincia    [%s] \n"
                        "\t\tCiudad       [%s] \n"
                        "\t\tModulo       [%s] \n"
                        "\t\tPlan.Comerc. [%d] \n"
                        "\t\tInd. Factur  [%d] \n"
                        "\t\tCod.CatImpos [%d] \n"
                        "\t\tInd.Estado   [%d] \n"
                        "\t\tTipo Concep. [%d] \n"
                        "\t\tNum.Unidades [%d] \n"
                        "\t\tCiclo Fact.  [%ld]\n"
                        "\t\tConcepto Rel.[%d] \n"
                        "\t\tColumna Rel. [%ld]\n"
                        "\t\tNum. Abonado [%ld]\n"
                        "\t\tNum. Terminal[%s] \n"
                        "\t\tCap. Code    [%ld]\n"
                        "\t\tNum. SerieMec[%s] \n"
                        "\t\tNum. SerieLe [%s] \n"
                        "\t\tFla. Impues  [%d] \n"
                        "\t\tFla. Dto.    [%d] \n"
                        "\t\tPrc. Impues. [%f] \n"
                        "\t\tVal. Dto.    [%f] \n"
                        "\t\tTip. Dto.    [%d] \n"
                        "\t\tNum. Venta   [%ld]\n"
                        "\t\tNum. Transac.[%ld]\n"
                        "\t\tMes  Garantia[%d] \n"
                        "\t\tNum. Guia    [%s] \n"
                        "\t\tInd. Alta    [%d] \n"
                        "\t\tInd. SuperTel[%d] \n"
                        "\t\tNum. Paquete [%d] \n"
                        "\t\tInd. Cuota   [%d] \n"
                        "\t\tNum. Cuotas  [%d] \n"
                        "\t\tOrd. Cuota   [%d] \n",LOG03,szFunc    ,
                        stPreFactura.A_PFactura[i].lNumProceso     ,
                        stPreFactura.A_PFactura[i].lCodCliente     ,
                        stPreFactura.A_PFactura[i].iCodConcepto    ,
                        stPreFactura.A_PFactura[i].lColumna        ,
                        stPreFactura.A_PFactura[i].iCodProducto    ,
                        stPreFactura.A_PFactura[i].szCodMoneda     ,
                        stPreFactura.A_PFactura[i].szFecValor      ,
                        stPreFactura.A_PFactura[i].szFecEfectividad,
                        stPreFactura.A_PFactura[i].dImpConcepto    ,
                        stPreFactura.A_PFactura[i].dImpFacturable  ,
                        stPreFactura.A_PFactura[i].dImpMontoBase   ,
                        stPreFactura.A_PFactura[i].szCodRegion     ,
                        stPreFactura.A_PFactura[i].szCodProvincia  ,
                        stPreFactura.A_PFactura[i].szCodCiudad     ,
                        stPreFactura.A_PFactura[i].szCodModulo     ,
                        stPreFactura.A_PFactura[i].lCodPlanCom     ,
                        stPreFactura.A_PFactura[i].iIndFactur      ,
                        stPreFactura.A_PFactura[i].iCodCatImpos    ,
                        stPreFactura.A_PFactura[i].iIndEstado      ,
                        stPreFactura.A_PFactura[i].iCodTipConce    ,
                        stPreFactura.A_PFactura[i].lNumUnidades    , /* Incorporado por PGonzaleg 26-02-2002 */
                        stPreFactura.A_PFactura[i].lCodCiclFact    ,
                        stPreFactura.A_PFactura[i].iCodConceRel    ,
                        stPreFactura.A_PFactura[i].lColumnaRel     ,
                        stPreFactura.A_PFactura[i].lNumAbonado     ,
                        stPreFactura.A_PFactura[i].szNumTerminal   ,
                        stPreFactura.A_PFactura[i].lCapCode        ,
                        stPreFactura.A_PFactura[i].szNumSerieMec   ,
                        stPreFactura.A_PFactura[i].szNumSerieLe    ,
                        stPreFactura.A_PFactura[i].iFlagImpues     ,
                        stPreFactura.A_PFactura[i].iFlagDto        ,
                        stPreFactura.A_PFactura[i].fPrcImpuesto    ,
                        stPreFactura.A_PFactura[i].dValDto         ,
                        stPreFactura.A_PFactura[i].iTipDto         ,
                        stPreFactura.A_PFactura[i].lNumVenta       ,
                        stPreFactura.A_PFactura[i].lNumTransaccion ,
                        stPreFactura.A_PFactura[i].iMesGarantia    ,
                        stPreFactura.A_PFactura[i].szNumGuia       ,
                        stPreFactura.A_PFactura[i].iIndAlta        ,
                        stPreFactura.A_PFactura[i].iIndSuperTel    ,
                        stPreFactura.A_PFactura[i].iNumPaquete     ,
                        stPreFactura.A_PFactura[i].iIndCuota       ,
                        stPreFactura.A_PFactura[i].iNumCuotas      ,
                        stPreFactura.A_PFactura[i].iOrdCuota       );
    }
}/************************* Final vPrintRegInsert ****************************/


/*****************************************************************************/
/*                         funcion : bInsertPreFactura                       */
/* -Funcion que inserta en Fa_PreFactura todos los Conceptos Facturables a un*/
/*  Cliente ,sus Descuentos e Impuestos todos ellos guardados en la estruc-  */
/*  tura stPreFactura.                                                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bInsertPreFactura (void)
{
   int  iInd    = 0   ;
   register int  i       = 0   ;
   BOOL bError = FALSE;

   char szFuncion [20]="";

 for (i=0;i<stPreFactura.iNumRegistros;i++)
 {
      stPreFactura.A_PFactura[i].dImpFacturable  = fnCnvDouble (stPreFactura.A_PFactura[i].dImpFacturable , USOFACT);
      stPreFactura.A_PFactura[i].dValDto         = fnCnvDouble (stPreFactura.A_PFactura[i].dValDto        , USOFACT);
      stPreFactura.A_PFactura[i].fPrcImpuesto    = fnCnvDouble (stPreFactura.A_PFactura[i].fPrcImpuesto   , USOFACT);
 }
 
 for(i=0;i<stPreFactura.iNumRegistros;i++)
 {
     if (stPreFactura.iNumRegistros > 0)
     {
         /* EXEC SQL /oFOR :stPreFactura.iNumRegistroso/ /o P-COL-07041 o/
         INSERT INTO FA_PRESUPUESTO
                 (NUM_PROCESO      ,
                  COD_CLIENTE      ,
                  COD_CONCEPTO     ,
                  COLUMNA          ,
                  COD_PRODUCTO     ,
                  COD_MONEDA       ,
                  FEC_VALOR        ,
                  FEC_EFECTIVIDAD  ,
                  IMP_CONCEPTO     ,
                  IMP_MONTOBASE    ,
                  IMP_FACTURABLE   ,
                  COD_REGION       ,
                  COD_PROVINCIA    ,
                  COD_CIUDAD       ,
                  COD_MODULO       ,
                  COD_PLANCOM      ,
                  IND_FACTUR       ,
                  FEC_VENTA        ,
                  COD_CATIMPOS     ,
                  COD_PORTADOR     ,
                  IND_ESTADO       ,
                  COD_TIPCONCE     ,
                  NUM_UNIDADES     ,
                  COD_CICLFACT     ,
                  COD_CONCEREL     ,
                  COLUMNA_REL      ,
                  NUM_ABONADO      ,
                  NUM_TERMINAL     ,
                  CAP_CODE         ,
                  NUM_SERIEMEC     ,
                  NUM_SERIELE      ,
                  FLAG_IMPUES      ,
                  FLAG_DTO         ,
                  PRC_IMPUESTO     ,
                  VAL_DTO          ,
                  TIP_DTO          ,
                  NUM_VENTA        ,
                  NUM_TRANSACCION  ,
                  MES_GARANTIA     ,
                  NUM_GUIA         ,
                  IND_ALTA         ,
                  IND_SUPERTEL     ,
                  NUM_PAQUETE      ,
                  IND_CUOTA        ,
                  NUM_CUOTAS       ,
                  ORD_CUOTA)
    VALUES(
      :stPreFactura.A_PFactura[i].lNumProceso         ,
      :stPreFactura.A_PFactura[i].lCodCliente         ,
      :stPreFactura.A_PFactura[i].iCodConcepto        ,
      :stPreFactura.A_PFactura[i].lColumna            ,
      :stPreFactura.A_PFactura[i].iCodProducto        ,
      :stPreFactura.A_PFactura[i].szCodMoneda         ,
      TO_DATE (:stPreFactura.A_PFactura[i].szFecValor ,
               'YYYYMMDDHH24MISS')                 ,
      TO_DATE (:stPreFactura.A_PFactura[i].szFecEfectividad,
               'YYYYMMDDHH24MISS')                 ,
      :stPreFactura.A_PFactura[i].dImpConcepto        ,
      :stPreFactura.A_PFactura[i].dImpMontoBase       ,
      :stPreFactura.A_PFactura[i].dImpFacturable      ,
      :stPreFactura.A_PFactura[i].szCodRegion         ,
      :stPreFactura.A_PFactura[i].szCodProvincia      ,
      :stPreFactura.A_PFactura[i].szCodCiudad         ,
      :stPreFactura.A_PFactura[i].szCodModulo         ,
      :stPreFactura.A_PFactura[i].lCodPlanCom         ,
      :stPreFactura.A_PFactura[i].iIndFactur          ,
      SYSDATE                                      ,
      :stPreFactura.A_PFactura[i].iCodCatImpos        ,
      :stPreFactura.A_PFactura[i].iCodPortador        ,
      :stPreFactura.A_PFactura[i].iIndEstado          ,
      :stPreFactura.A_PFactura[i].iCodTipConce        ,
      :stPreFactura.A_PFactura[i].lNumUnidades        ,                /o Incorporado por PGonzaleg 26-02-2002 o/
      :stPreFactura.A_PFactura[i].lCodCiclFact:stPreFactura.A_Ind[i].i_lCodCiclFact  ,
      :stPreFactura.A_PFactura[i].iCodConceRel                                    ,
      :stPreFactura.A_PFactura[i].lColumnaRel                                     ,
      :stPreFactura.A_PFactura[i].lNumAbonado:stPreFactura.A_Ind[i].i_lNumAbonado    ,
      :stPreFactura.A_PFactura[i].szNumTerminal:stPreFactura.A_Ind[i].i_szNumTerminal,
      :stPreFactura.A_PFactura[i].lCapCode:stPreFactura.A_Ind[i].i_lCapCode          ,
      :stPreFactura.A_PFactura[i].szNumSerieMec:stPreFactura.A_Ind[i].i_szNumSerieMec,
      :stPreFactura.A_PFactura[i].szNumSerieLe:stPreFactura.A_Ind[i].i_szNumSerieLe  ,
      :stPreFactura.A_PFactura[i].iFlagImpues                                     ,
      :stPreFactura.A_PFactura[i].iFlagDto                                        ,
      :stPreFactura.A_PFactura[i].fPrcImpuesto:stPreFactura.A_Ind[i].i_fPrcImpuesto  ,
      :stPreFactura.A_PFactura[i].dValDto:stPreFactura.A_Ind[i].i_dValDto            ,
      :stPreFactura.A_PFactura[i].iTipDto:stPreFactura.A_Ind[i].i_iTipDto            ,
      :stPreFactura.A_PFactura[i].lNumVenta:stPreFactura.A_Ind[i].i_lNumVenta        ,
      :stPreFactura.A_PFactura[i].lNumTransaccion:stPreFactura.A_Ind[i].i_lNumTransaccion,
      :stPreFactura.A_PFactura[i].iMesGarantia:stPreFactura.A_Ind[i].i_iMesGarantia  ,
      TO_NUMBER(:stPreFactura.A_PFactura[i].szNumGuia:stPreFactura.A_Ind[i].i_szNumGuia) ,
      :stPreFactura.A_PFactura[i].iIndAlta                                        ,
      :stPreFactura.A_PFactura[i].iIndSuperTel                                    ,
      :stPreFactura.A_PFactura[i].iNumPaquete:stPreFactura.A_Ind[i].i_iNumPaquete    ,
      :stPreFactura.A_PFactura[i].iIndCuota                                       ,
      :stPreFactura.A_PFactura[i].iNumCuotas                                      ,
      :stPreFactura.A_PFactura[i].iOrdCuota); */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 45;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "insert into FA_PRESUPUESTO (NUM_PROCESO,COD_CLIENTE,\
COD_CONCEPTO,COLUMNA,COD_PRODUCTO,COD_MONEDA,FEC_VALOR,FEC_EFECTIVIDAD,IMP_CON\
CEPTO,IMP_MONTOBASE,IMP_FACTURABLE,COD_REGION,COD_PROVINCIA,COD_CIUDAD,COD_MOD\
ULO,COD_PLANCOM,IND_FACTUR,FEC_VENTA,COD_CATIMPOS,COD_PORTADOR,IND_ESTADO,COD_\
TIPCONCE,NUM_UNIDADES,COD_CICLFACT,COD_CONCEREL,COLUMNA_REL,NUM_ABONADO,NUM_TE\
RMINAL,CAP_CODE,NUM_SERIEMEC,NUM_SERIELE,FLAG_IMPUES,FLAG_DTO,PRC_IMPUESTO,VAL\
_DTO,TIP_DTO,NUM_VENTA,NUM_TRANSACCION,MES_GARANTIA,NUM_GUIA,IND_ALTA,IND_SUPE\
RTEL,NUM_PAQUETE,IND_CUOTA,NUM_CUOTAS,ORD_CUOTA) values (:b0,:b1,:b2,:b3,:b4,:\
b5,TO_DATE(:b6,'YYYYMMDDHH24MISS'),TO_DATE(:b7,'YYYYMMDDHH24MISS'),:b8,:b9,:b1\
0,:b11,:b12,:b13,:b14,:b15,:b16,SYSDATE,:b17,:b18,:b19,:b20,:b21,:b22:b23,:b24\
,:b25,:b26:b27,:b28:b29,:b30:b31,:b32:b33,:b34:b35,:b36,:b37,:b38:b39,:b40:b41\
,:b42:b43,:b44:b45,:b46:b47,:b48:b49,TO_NUMBER(:b50:b51),:b52,:b53,:b54:b55,:b\
56,:b57,:b58)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )2010;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lNumProceso);
         sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lCodCliente);
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iCodConcepto);
         sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lColumna);
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iCodProducto);
         sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szCodMoneda);
         sqlstm.sqhstl[5] = (unsigned long )4;
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szFecValor);
         sqlstm.sqhstl[6] = (unsigned long )15;
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szFecEfectividad);
         sqlstm.sqhstl[7] = (unsigned long )15;
         sqlstm.sqhsts[7] = (         int  )0;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].dImpConcepto);
         sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[8] = (         int  )0;
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].dImpMontoBase);
         sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[9] = (         int  )0;
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].dImpFacturable);
         sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[10] = (         int  )0;
         sqlstm.sqindv[10] = (         short *)0;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szCodRegion);
         sqlstm.sqhstl[11] = (unsigned long )4;
         sqlstm.sqhsts[11] = (         int  )0;
         sqlstm.sqindv[11] = (         short *)0;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szCodProvincia);
         sqlstm.sqhstl[12] = (unsigned long )6;
         sqlstm.sqhsts[12] = (         int  )0;
         sqlstm.sqindv[12] = (         short *)0;
         sqlstm.sqinds[12] = (         int  )0;
         sqlstm.sqharm[12] = (unsigned long )0;
         sqlstm.sqadto[12] = (unsigned short )0;
         sqlstm.sqtdso[12] = (unsigned short )0;
         sqlstm.sqhstv[13] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szCodCiudad);
         sqlstm.sqhstl[13] = (unsigned long )6;
         sqlstm.sqhsts[13] = (         int  )0;
         sqlstm.sqindv[13] = (         short *)0;
         sqlstm.sqinds[13] = (         int  )0;
         sqlstm.sqharm[13] = (unsigned long )0;
         sqlstm.sqadto[13] = (unsigned short )0;
         sqlstm.sqtdso[13] = (unsigned short )0;
         sqlstm.sqhstv[14] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szCodModulo);
         sqlstm.sqhstl[14] = (unsigned long )3;
         sqlstm.sqhsts[14] = (         int  )0;
         sqlstm.sqindv[14] = (         short *)0;
         sqlstm.sqinds[14] = (         int  )0;
         sqlstm.sqharm[14] = (unsigned long )0;
         sqlstm.sqadto[14] = (unsigned short )0;
         sqlstm.sqtdso[14] = (unsigned short )0;
         sqlstm.sqhstv[15] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lCodPlanCom);
         sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[15] = (         int  )0;
         sqlstm.sqindv[15] = (         short *)0;
         sqlstm.sqinds[15] = (         int  )0;
         sqlstm.sqharm[15] = (unsigned long )0;
         sqlstm.sqadto[15] = (unsigned short )0;
         sqlstm.sqtdso[15] = (unsigned short )0;
         sqlstm.sqhstv[16] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iIndFactur);
         sqlstm.sqhstl[16] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[16] = (         int  )0;
         sqlstm.sqindv[16] = (         short *)0;
         sqlstm.sqinds[16] = (         int  )0;
         sqlstm.sqharm[16] = (unsigned long )0;
         sqlstm.sqadto[16] = (unsigned short )0;
         sqlstm.sqtdso[16] = (unsigned short )0;
         sqlstm.sqhstv[17] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iCodCatImpos);
         sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[17] = (         int  )0;
         sqlstm.sqindv[17] = (         short *)0;
         sqlstm.sqinds[17] = (         int  )0;
         sqlstm.sqharm[17] = (unsigned long )0;
         sqlstm.sqadto[17] = (unsigned short )0;
         sqlstm.sqtdso[17] = (unsigned short )0;
         sqlstm.sqhstv[18] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iCodPortador);
         sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[18] = (         int  )0;
         sqlstm.sqindv[18] = (         short *)0;
         sqlstm.sqinds[18] = (         int  )0;
         sqlstm.sqharm[18] = (unsigned long )0;
         sqlstm.sqadto[18] = (unsigned short )0;
         sqlstm.sqtdso[18] = (unsigned short )0;
         sqlstm.sqhstv[19] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iIndEstado);
         sqlstm.sqhstl[19] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[19] = (         int  )0;
         sqlstm.sqindv[19] = (         short *)0;
         sqlstm.sqinds[19] = (         int  )0;
         sqlstm.sqharm[19] = (unsigned long )0;
         sqlstm.sqadto[19] = (unsigned short )0;
         sqlstm.sqtdso[19] = (unsigned short )0;
         sqlstm.sqhstv[20] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iCodTipConce);
         sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[20] = (         int  )0;
         sqlstm.sqindv[20] = (         short *)0;
         sqlstm.sqinds[20] = (         int  )0;
         sqlstm.sqharm[20] = (unsigned long )0;
         sqlstm.sqadto[20] = (unsigned short )0;
         sqlstm.sqtdso[20] = (unsigned short )0;
         sqlstm.sqhstv[21] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lNumUnidades);
         sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[21] = (         int  )0;
         sqlstm.sqindv[21] = (         short *)0;
         sqlstm.sqinds[21] = (         int  )0;
         sqlstm.sqharm[21] = (unsigned long )0;
         sqlstm.sqadto[21] = (unsigned short )0;
         sqlstm.sqtdso[21] = (unsigned short )0;
         sqlstm.sqhstv[22] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lCodCiclFact);
         sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[22] = (         int  )0;
         sqlstm.sqindv[22] = (         short *)&((stPreFactura.A_Ind)[i].i_lCodCiclFact);
         sqlstm.sqinds[22] = (         int  )0;
         sqlstm.sqharm[22] = (unsigned long )0;
         sqlstm.sqadto[22] = (unsigned short )0;
         sqlstm.sqtdso[22] = (unsigned short )0;
         sqlstm.sqhstv[23] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iCodConceRel);
         sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[23] = (         int  )0;
         sqlstm.sqindv[23] = (         short *)0;
         sqlstm.sqinds[23] = (         int  )0;
         sqlstm.sqharm[23] = (unsigned long )0;
         sqlstm.sqadto[23] = (unsigned short )0;
         sqlstm.sqtdso[23] = (unsigned short )0;
         sqlstm.sqhstv[24] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lColumnaRel);
         sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[24] = (         int  )0;
         sqlstm.sqindv[24] = (         short *)0;
         sqlstm.sqinds[24] = (         int  )0;
         sqlstm.sqharm[24] = (unsigned long )0;
         sqlstm.sqadto[24] = (unsigned short )0;
         sqlstm.sqtdso[24] = (unsigned short )0;
         sqlstm.sqhstv[25] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lNumAbonado);
         sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[25] = (         int  )0;
         sqlstm.sqindv[25] = (         short *)&((stPreFactura.A_Ind)[i].i_lNumAbonado);
         sqlstm.sqinds[25] = (         int  )0;
         sqlstm.sqharm[25] = (unsigned long )0;
         sqlstm.sqadto[25] = (unsigned short )0;
         sqlstm.sqtdso[25] = (unsigned short )0;
         sqlstm.sqhstv[26] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szNumTerminal);
         sqlstm.sqhstl[26] = (unsigned long )16;
         sqlstm.sqhsts[26] = (         int  )0;
         sqlstm.sqindv[26] = (         short *)&((stPreFactura.A_Ind)[i].i_szNumTerminal);
         sqlstm.sqinds[26] = (         int  )0;
         sqlstm.sqharm[26] = (unsigned long )0;
         sqlstm.sqadto[26] = (unsigned short )0;
         sqlstm.sqtdso[26] = (unsigned short )0;
         sqlstm.sqhstv[27] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lCapCode);
         sqlstm.sqhstl[27] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[27] = (         int  )0;
         sqlstm.sqindv[27] = (         short *)&((stPreFactura.A_Ind)[i].i_lCapCode);
         sqlstm.sqinds[27] = (         int  )0;
         sqlstm.sqharm[27] = (unsigned long )0;
         sqlstm.sqadto[27] = (unsigned short )0;
         sqlstm.sqtdso[27] = (unsigned short )0;
         sqlstm.sqhstv[28] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szNumSerieMec);
         sqlstm.sqhstl[28] = (unsigned long )26;
         sqlstm.sqhsts[28] = (         int  )0;
         sqlstm.sqindv[28] = (         short *)&((stPreFactura.A_Ind)[i].i_szNumSerieMec);
         sqlstm.sqinds[28] = (         int  )0;
         sqlstm.sqharm[28] = (unsigned long )0;
         sqlstm.sqadto[28] = (unsigned short )0;
         sqlstm.sqtdso[28] = (unsigned short )0;
         sqlstm.sqhstv[29] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szNumSerieLe);
         sqlstm.sqhstl[29] = (unsigned long )26;
         sqlstm.sqhsts[29] = (         int  )0;
         sqlstm.sqindv[29] = (         short *)&((stPreFactura.A_Ind)[i].i_szNumSerieLe);
         sqlstm.sqinds[29] = (         int  )0;
         sqlstm.sqharm[29] = (unsigned long )0;
         sqlstm.sqadto[29] = (unsigned short )0;
         sqlstm.sqtdso[29] = (unsigned short )0;
         sqlstm.sqhstv[30] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iFlagImpues);
         sqlstm.sqhstl[30] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[30] = (         int  )0;
         sqlstm.sqindv[30] = (         short *)0;
         sqlstm.sqinds[30] = (         int  )0;
         sqlstm.sqharm[30] = (unsigned long )0;
         sqlstm.sqadto[30] = (unsigned short )0;
         sqlstm.sqtdso[30] = (unsigned short )0;
         sqlstm.sqhstv[31] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iFlagDto);
         sqlstm.sqhstl[31] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[31] = (         int  )0;
         sqlstm.sqindv[31] = (         short *)0;
         sqlstm.sqinds[31] = (         int  )0;
         sqlstm.sqharm[31] = (unsigned long )0;
         sqlstm.sqadto[31] = (unsigned short )0;
         sqlstm.sqtdso[31] = (unsigned short )0;
         sqlstm.sqhstv[32] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].fPrcImpuesto);
         sqlstm.sqhstl[32] = (unsigned long )sizeof(float);
         sqlstm.sqhsts[32] = (         int  )0;
         sqlstm.sqindv[32] = (         short *)&((stPreFactura.A_Ind)[i].i_fPrcImpuesto);
         sqlstm.sqinds[32] = (         int  )0;
         sqlstm.sqharm[32] = (unsigned long )0;
         sqlstm.sqadto[32] = (unsigned short )0;
         sqlstm.sqtdso[32] = (unsigned short )0;
         sqlstm.sqhstv[33] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].dValDto);
         sqlstm.sqhstl[33] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[33] = (         int  )0;
         sqlstm.sqindv[33] = (         short *)&((stPreFactura.A_Ind)[i].i_dValDto);
         sqlstm.sqinds[33] = (         int  )0;
         sqlstm.sqharm[33] = (unsigned long )0;
         sqlstm.sqadto[33] = (unsigned short )0;
         sqlstm.sqtdso[33] = (unsigned short )0;
         sqlstm.sqhstv[34] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iTipDto);
         sqlstm.sqhstl[34] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[34] = (         int  )0;
         sqlstm.sqindv[34] = (         short *)&((stPreFactura.A_Ind)[i].i_iTipDto);
         sqlstm.sqinds[34] = (         int  )0;
         sqlstm.sqharm[34] = (unsigned long )0;
         sqlstm.sqadto[34] = (unsigned short )0;
         sqlstm.sqtdso[34] = (unsigned short )0;
         sqlstm.sqhstv[35] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lNumVenta);
         sqlstm.sqhstl[35] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[35] = (         int  )0;
         sqlstm.sqindv[35] = (         short *)&((stPreFactura.A_Ind)[i].i_lNumVenta);
         sqlstm.sqinds[35] = (         int  )0;
         sqlstm.sqharm[35] = (unsigned long )0;
         sqlstm.sqadto[35] = (unsigned short )0;
         sqlstm.sqtdso[35] = (unsigned short )0;
         sqlstm.sqhstv[36] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].lNumTransaccion);
         sqlstm.sqhstl[36] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[36] = (         int  )0;
         sqlstm.sqindv[36] = (         short *)&((stPreFactura.A_Ind)[i].i_lNumTransaccion);
         sqlstm.sqinds[36] = (         int  )0;
         sqlstm.sqharm[36] = (unsigned long )0;
         sqlstm.sqadto[36] = (unsigned short )0;
         sqlstm.sqtdso[36] = (unsigned short )0;
         sqlstm.sqhstv[37] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iMesGarantia);
         sqlstm.sqhstl[37] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[37] = (         int  )0;
         sqlstm.sqindv[37] = (         short *)&((stPreFactura.A_Ind)[i].i_iMesGarantia);
         sqlstm.sqinds[37] = (         int  )0;
         sqlstm.sqharm[37] = (unsigned long )0;
         sqlstm.sqadto[37] = (unsigned short )0;
         sqlstm.sqtdso[37] = (unsigned short )0;
         sqlstm.sqhstv[38] = (unsigned char  *)((stPreFactura.A_PFactura)[i].szNumGuia);
         sqlstm.sqhstl[38] = (unsigned long )11;
         sqlstm.sqhsts[38] = (         int  )0;
         sqlstm.sqindv[38] = (         short *)&((stPreFactura.A_Ind)[i].i_szNumGuia);
         sqlstm.sqinds[38] = (         int  )0;
         sqlstm.sqharm[38] = (unsigned long )0;
         sqlstm.sqadto[38] = (unsigned short )0;
         sqlstm.sqtdso[38] = (unsigned short )0;
         sqlstm.sqhstv[39] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iIndAlta);
         sqlstm.sqhstl[39] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[39] = (         int  )0;
         sqlstm.sqindv[39] = (         short *)0;
         sqlstm.sqinds[39] = (         int  )0;
         sqlstm.sqharm[39] = (unsigned long )0;
         sqlstm.sqadto[39] = (unsigned short )0;
         sqlstm.sqtdso[39] = (unsigned short )0;
         sqlstm.sqhstv[40] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iIndSuperTel);
         sqlstm.sqhstl[40] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[40] = (         int  )0;
         sqlstm.sqindv[40] = (         short *)0;
         sqlstm.sqinds[40] = (         int  )0;
         sqlstm.sqharm[40] = (unsigned long )0;
         sqlstm.sqadto[40] = (unsigned short )0;
         sqlstm.sqtdso[40] = (unsigned short )0;
         sqlstm.sqhstv[41] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iNumPaquete);
         sqlstm.sqhstl[41] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[41] = (         int  )0;
         sqlstm.sqindv[41] = (         short *)&((stPreFactura.A_Ind)[i].i_iNumPaquete);
         sqlstm.sqinds[41] = (         int  )0;
         sqlstm.sqharm[41] = (unsigned long )0;
         sqlstm.sqadto[41] = (unsigned short )0;
         sqlstm.sqtdso[41] = (unsigned short )0;
         sqlstm.sqhstv[42] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iIndCuota);
         sqlstm.sqhstl[42] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[42] = (         int  )0;
         sqlstm.sqindv[42] = (         short *)0;
         sqlstm.sqinds[42] = (         int  )0;
         sqlstm.sqharm[42] = (unsigned long )0;
         sqlstm.sqadto[42] = (unsigned short )0;
         sqlstm.sqtdso[42] = (unsigned short )0;
         sqlstm.sqhstv[43] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iNumCuotas);
         sqlstm.sqhstl[43] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[43] = (         int  )0;
         sqlstm.sqindv[43] = (         short *)0;
         sqlstm.sqinds[43] = (         int  )0;
         sqlstm.sqharm[43] = (unsigned long )0;
         sqlstm.sqadto[43] = (unsigned short )0;
         sqlstm.sqtdso[43] = (unsigned short )0;
         sqlstm.sqhstv[44] = (unsigned char  *)&((stPreFactura.A_PFactura)[i].iOrdCuota);
         sqlstm.sqhstl[44] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[44] = (         int  )0;
         sqlstm.sqindv[44] = (         short *)0;
         sqlstm.sqinds[44] = (         int  )0;
         sqlstm.sqharm[44] = (unsigned long )0;
         sqlstm.sqadto[44] = (unsigned short )0;
         sqlstm.sqtdso[44] = (unsigned short )0;
         sqlstm.sqphsv = sqlstm.sqhstv;
         sqlstm.sqphsl = sqlstm.sqhstl;
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
          iInd = (sqlca.sqlerrd[2] == SQLOK)?0:sqlca.sqlerrd[2]-1;
          if (stPreFactura.A_PFactura[iInd].bOptCargos)
              strcpy (szFuncion,"Cargos");
          if (stPreFactura.A_PFactura[iInd].bOptPenaliza)
              strcpy (szFuncion,"Penalizaciones");
          if (stPreFactura.A_PFactura[iInd].bOptServicios)
              strcpy (szFuncion,"Servicios");
          if (stPreFactura.A_PFactura[iInd].bOptAbonos)
              strcpy (szFuncion,"Abonos");
          if (stPreFactura.A_PFactura[iInd].bOptTrafico)
              strcpy (szFuncion,"Trafico");
          if (stPreFactura.A_PFactura[iInd].bOptCuotas)
              strcpy (szFuncion,"Cuotas");
          if (stPreFactura.A_PFactura[iInd].bOptDescuento)
              strcpy (szFuncion,"Descuentos");
          if (stPreFactura.A_PFactura[iInd].bOptImpuesto)
              strcpy (szFuncion,"Impuestos");
          if (stPreFactura.A_PFactura[iInd].bOptArriendo)
              strcpy (szFuncion,"Arriendos");
    
          vDTrazasLog (szExeName,"Insert de FA_PRESUPUESTO Registro %d\n\t",
                       LOG01, sqlca.sqlerrd[2])  ;
          bError = TRUE                          ;
          vPrintRegInsert (iInd,szFuncion,bError);
          iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Insert->Fa_PreSupuesto",szfnORAerror());
          return FALSE;
       }
    
     }
 }
 vDTrazasLog (szExeName,
              "\n\t\t* Conceptos Procesados [%d] del Cliente [%ld]\n",LOG03,
              stPreFactura.iNumRegistros,stCliente.lCodCliente);
 return TRUE;
}/****************************** Final bInsertPreFactura *********************/

/*****************************************************************************/
/*                             funcion : bGetCodPlanCom                      */
/*****************************************************************************/
BOOL bGetCodPlanCom (long lCodCliente,int iCodProducto,long *lCodPlanCom)
{
  static long lhCodPlanCom;

  if (stDatosGener.iProdCelular == iCodProducto)
  {
      /* EXEC SQL SELECT /o+ index (GA_INTARCEL PK_GA_INTARCEL) o/
                      COD_PLANCOM
               INTO   :lhCodPlanCom
               FROM   GA_INTARCEL
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  ROWNUM      = 1; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 45;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (GA_INTARCEL PK_GA_INTARCEL)  +*/ CO\
D_PLANCOM into :b0  from GA_INTARCEL where (COD_CLIENTE=:b1 and ROWNUM=1)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2205;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
  else if (stDatosGener.iProdBeeper == iCodProducto)
  {
      /* EXEC SQL SELECT /o+ index (GA_INTARBEEP PK_GA_INTARBEEP) o/
                      COD_PLANCOM
               INTO   :lhCodPlanCom
               FROM   GA_INTARCEL
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  ROWNUM      = 1; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 45;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (GA_INTARBEEP PK_GA_INTARBEEP)  +*/ \
COD_PLANCOM into :b0  from GA_INTARCEL where (COD_CLIENTE=:b1 and ROWNUM=1)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2228;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
  else if (stDatosGener.iProdTrunk == iCodProducto)
  {
      /* EXEC SQL SELECT /o+ index (GA_INTARTRUNK PK_GA_INTARTRUNK) o/
                      COD_PLANCOM
               INTO   :lhCodPlanCom
               FROM   GA_INTARCEL
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  ROWNUM      = 1; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 45;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (GA_INTARTRUNK PK_GA_INTARTRUNK)  +*\
/ COD_PLANCOM into :b0  from GA_INTARCEL where (COD_CLIENTE=:b1 and ROWNUM=1)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2251;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
  else if (stDatosGener.iProdTrek == iCodProducto)
  {
      /* EXEC SQL SELECT /o+ index (GA_INTARTREK PK_GA_INTARTREK) o/
                      COD_PLANCOM
               INTO   :lhCodPlanCom
               FROM   GA_INTARCEL
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  ROWNUM      = 1; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 45;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (GA_INTARTREK PK_GA_INTARTREK)  +*/ \
COD_PLANCOM into :b0  from GA_INTARCEL where (COD_CLIENTE=:b1 and ROWNUM=1)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2274;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->CodPlanCom\n",
               szfnORAerror());
      return FALSE;
  }
  if (SQLCODE == SQLOK)
  {
      *lCodPlanCom = lhCodPlanCom;
  }
  return TRUE;
}/******************** bGetCodPlanCom ***************************************/

/*****************************************************************************/
/*                          funcion : bGetIndCliente                         */
/* -Funcion que recupera reg. de la tabla Fa_FactCli que nos informa sobre : */
/*      * Si Existe Penalizaciones a nivel de Cliente                        */
/*      * Si Existe Cargos a nivel de Cliente                                */
/*      * Si Existe Pagares a nivel de Cliente                               */
/*****************************************************************************/
BOOL bfnGetIndCliente (FACTCLI *pFactCli)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static short  shIndPenaliza    ;
  static short  shIndPagare      ;
  static short  shIndCargos      ;
  static long   lhCodCliente     ;
  static char*  szhFecUltPagare  ;/* EXEC SQL VAR szhFecUltPagare   IS STRING(15); */ 

  static char*  szhFecUltCargos  ;/* EXEC SQL VAR szhFecUltCargos   IS STRING(15); */ 

  static char*  szhFecUltPenaliza;/* EXEC SQL VAR szhFecUltPenaliza IS STRING(15); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  lhCodCliente = stCliente.lCodCliente;

  vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada a Fa_FactCli\n"
                         "\t\t=> Cliente [%ld]\n",LOG04,lhCodCliente);

  szhFecUltPagare   = pFactCli->szFecUltPagare  ;
  szhFecUltCargos   = pFactCli->szFecUltCargos  ;
  szhFecUltPenaliza = pFactCli->szFecUltPenaliza;

  /* EXEC SQL SELECT /o+ index (FA_FACTCLI PK_FA_FACTCLI) o/
                  IND_PENALIZA,
                  IND_PAGARE  ,
                  IND_CARGOS  ,
                  TO_CHAR (FEC_ULTPAGARE  ,'YYYYMMDDHH24MISS'),
                  TO_CHAR (FEC_ULTPENALIZA,'YYYYMMDDHH24MISS'),
                  TO_CHAR (FEC_ULTCARGOS  ,'YYYYMMDDHH24MISS')
            INTO  :shIndPenaliza    ,
                  :shIndPagare      ,
                  :shIndCargos      ,
                  :szhFecUltPagare  ,
                  :szhFecUltPenaliza,
                  :szhFecUltCargos
            FROM  FA_FACTCLI
            WHERE COD_CLIENTE = :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 45;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (FA_FACTCLI PK_FA_FACTCLI)  +*/ IND_PENA\
LIZA ,IND_PAGARE ,IND_CARGOS ,TO_CHAR(FEC_ULTPAGARE,'YYYYMMDDHH24MISS') ,TO_CH\
AR(FEC_ULTPENALIZA,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_ULTCARGOS,'YYYYMMDDHH24MIS\
S') into :b0,:b1,:b2,:b3,:b4,:b5  from FA_FACTCLI where COD_CLIENTE=:b6";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2297;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&shIndPenaliza;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&shIndPagare;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&shIndCargos;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecUltPagare;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecUltPenaliza;
  sqlstm.sqhstl[4] = (unsigned long )15;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecUltCargos;
  sqlstm.sqhstl[5] = (unsigned long )15;
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
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_FactCli",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      pFactCli->iIndPagare   = shIndPagare  ;
      pFactCli->iIndPenaliza = shIndPenaliza;
      pFactCli->iIndCargos   = shIndCargos  ;
  }
  return (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)?FALSE:TRUE;
}/*************************** Final bGetIndCliente ***************************/

/*****************************************************************************/
/*                           funcion : bRedondeoMoneda                       */
/* -Funcion que redondea un importe en la moneda de facturacion y luego la   */
/*  pasa a la moneda Origen.                                                 */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bRedondeoMoneda (char *szMonedaO,char *szFecha,double *dImporte,
                      int iTipoFact)
{
  if (!bConverMoneda (szMonedaO,stDatosGener.szCodMoneFact,szFecha,dImporte,
                      iTipoFact))
       return FALSE;
  /* rao031008 : se elimina ya que no se redondea a menor prescision
    *dImporte = fnCnvDouble (*dImporte,USOFACT);
  */

  if (!bConverMoneda (stDatosGener.szCodMoneFact,szMonedaO,szFecha,dImporte,
                      iTipoFact))
       return FALSE;
       
  *dImporte = fnCnvDouble (*dImporte,USOFACT);

 return TRUE;
}/************************* Final vRedondeoMoneda ****************************/

/*****************************************************************************/
/*                         funcion : iCmpCiudades                            */
/*****************************************************************************/
int iCmpCiudades (const void* cad1,const void* cad2)
{

  return ( ((CIUDADES *)cad1)->iAntiguedad-((CIUDADES *)cad2)->iAntiguedad );
}/************************* Final iCmpCiudades *******************************/

/*****************************************************************************/
/*                         funcion : iCmpComunas                             */
/*****************************************************************************/
int iCmpComunas  (const void* cad1,const void* cad2)
{

  return ( ((COMUNAS  *)cad1)->iAntiguedad-((COMUNAS  *)cad2)->iAntiguedad );
}/************************* Final iCmpComunas  *******************************/

/*****************************************************************************/
/*                          funcion : iCmpProvincias                         */
/*****************************************************************************/
int iCmpProvincias (const void* cad1,const void* cad2)
{
  int rc = 0;

  return
   ( (rc = strcmp ( ((PROVINCIAS *)cad1)->szCodRegion,
                    ((PROVINCIAS *)cad2)->szCodRegion    ) )!= 0 )?rc:
   ( (rc = strcmp ( ((PROVINCIAS *)cad1)->szCodProvincia,
                    ((PROVINCIAS *)cad2)->szCodProvincia ) )!= 0 )?rc:0;

}/************************** Final iCmpProvincias ****************************/

/*****************************************************************************/
/*                          funcion : bFindProvincias                        */
/*****************************************************************************/
BOOL bFindProvincias (PROVINCIAS *pPr)
{
   PROVINCIAS stkey;
   PROVINCIAS *pP = (PROVINCIAS *)NULL;

   memset (&stkey,0,sizeof(PROVINCIAS));

   strcpy (stkey.szCodRegion   ,pPr->szCodRegion   );
   strcpy (stkey.szCodProvincia,pPr->szCodProvincia);
   if ((pP = (PROVINCIAS *)bsearch (&stkey,pstProvincias,NUM_PROVINCIAS,
             sizeof(PROVINCIAS),iCmpProvincias))==(PROVINCIAS *)NULL)
   {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstProvincias");
        return FALSE;
   }

   return TRUE;
}/**************************** Funcion : bFindProvincia ***********************/

/*****************************************************************************/
/*                          funcion : iCmpCargoRecurrente                    */
/*****************************************************************************/
int iCmpCargoRecurrente (const void* cad1,const void* cad2)
{
  int rc = 0;

  return
   ( (rc =         ((CARGOSRECURRENTES *)cad1)->lCodCargo-
                   ((CARGOSRECURRENTES *)cad2)->lCodCargo) != 0)?rc:0;
   
}/************************* Final iCmpCargoRecurrente *************************/

/*****************************************************************************/
/*                          funcion : bFindCargoRecurrente                   */
/*****************************************************************************/
BOOL bFindCargoRecurrente (CARGOSRECURRENTES *pPr)
{
   CARGOSRECURRENTES stkey;
   CARGOSRECURRENTES *pP = (CARGOSRECURRENTES *)NULL;

   memset (&stkey,0,sizeof(CARGOSRECURRENTES));

   stkey.lCodCargo=pPr->lCodCargo;
   if ((pP = (CARGOSRECURRENTES *)bsearch (&stkey,pstCargosRecurrentes,NUM_CARGOSRECURRENTES,
             sizeof(CARGOSRECURRENTES),iCmpCargoRecurrente))==(CARGOSRECURRENTES *)NULL)
   {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstCargosRecurrentes");
        return FALSE;
   }else{
        pPr->dMontoImporte = pP->dMontoImporte;
        strcpy(pPr->szCodMoneda, pP->szCodMoneda);
   }

   return TRUE;
}/************************* Funcion : bFindCargoRecurrente *********************/

/****************************************************************************************/
/* FUNCION     : bFindOverrideCB                                                        */
/* DESCRIPCION : Busca reg. en GE_CARGOS_SOBREESCRITOS_TO para Cargos Basicos           */
/*               el criterio de busqueda es la PK                                       */
/****************************************************************************************/
BOOL bFindOverrideCB (long   lCodCliente, 
                      long   lNumAbonado, 
                      char   *szCodCargoBasico, 
                      double *dImporteOverride)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long   lhCodCliente;
         long   lhNumAbonado;             
         char   szhCodCargoBasico[4]; /* EXEC SQL VAR szhCodCargoBasico   IS STRING(4); */ 

         char   szhCodMoneda     [4]; /* EXEC SQL VAR szhCodMoneda        IS STRING(4); */ 

         double dhImporteOverride;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName, "\n\t\t* Parametros de Entrada para Override Cargos Basicos"
                            "\n\t\t=> Cod.Cliente      [%ld]"
                            "\n\t\t=> Num.Abonado      [%ld]"                                
                            "\n\t\t=> Cod.Cargo Basico [%s]"
                          , LOG05
                          , lCodCliente
                          , lNumAbonado
                          , szCodCargoBasico);
    memset(szhCodCargoBasico,'\0',sizeof(szhCodCargoBasico));
    memset(szhCodMoneda,'\0',sizeof(szhCodMoneda));    

    lhCodCliente      = lCodCliente;
    lhNumAbonado      = lNumAbonado;
    strcpy(szhCodCargoBasico,szCodCargoBasico);
    dhImporteOverride = 0.0;
    
    /* EXEC SQL 
         SELECT IMPORTE_SOBRESCRITO, COD_MONEDA
         INTO   :dhImporteOverride, :szhCodMoneda
         FROM   GE_CARGOS_SOBRESCRITOS_TO
         WHERE  COD_CLIENTE        = :lhCodCliente
         AND    NUM_ABONADO        = :lhNumAbonado
         AND    COD_CARGOBASICO    = :szhCodCargoBasico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IMPORTE_SOBRESCRITO ,COD_MONEDA into :b0,:b1  from\
 GE_CARGOS_SOBRESCRITOS_TO where ((COD_CLIENTE=:b2 and NUM_ABONADO=:b3) and CO\
D_CARGOBASICO=:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2340;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteOverride;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodCargoBasico;
    sqlstm.sqhstl[4] = (unsigned long )4;
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


         
    if (SQLCODE != SQLOK  &&  SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog (szExeName, "\n\t\t* Error Select -> GE_CARGOS_SOBREESCRITOS_TO en CB" , LOG05);    	
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select -> GE_CARGOS_SOBREESCRITOS_TO ", szfnORAerror());
        return FALSE;
    }
    else
    {
    	
        if (SQLCODE == SQLNOTFOUND )
    	{
    	    return FALSE;
    	}
    	
        *dImporteOverride    = dhImporteOverride   ;
        
    }

  return TRUE;
}/************************ Final bFindOverrideCB *******************************/

/****************************************************************************************/
/* FUNCION     : bFindOverridePA                                                        */
/* DESCRIPCION : Busca reg. en GE_CARGOS_SOBREESCRITOS_TO para Planes Adicionales       */
/*               el criterio de busqueda es la PK                                       */
/****************************************************************************************/
BOOL bFindOverridePA (long lCodCliente, long lNumAbonado, long lCodCargoContratado, double *dImporteOverride)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long   lhCodCliente;
         long   lhNumAbonado;             
         long   lhCodCargoContratado;
         double dhImporteOverride;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName, "\n\t\t* Parametros de Entrada para Override Planes Adicionales"
                            "\n\t\t=> Cod.Cliente          [%ld]"
                            "\n\t\t=> Num.Abonado          [%ld]"                                
                            "\n\t\t=> Cod.Cargo Contratado [%ld]"
                          , LOG04
                          , lCodCliente
                          , lNumAbonado
                          , lCodCargoContratado);

    lhCodCliente         = lCodCliente;
    lhNumAbonado         = lNumAbonado;
    lhCodCargoContratado = lCodCargoContratado;        
    dhImporteOverride = 0.0;
    
    /* EXEC SQL 
         SELECT IMPORTE_SOBRESCRITO
         INTO   :dhImporteOverride
         FROM   GE_CARGOS_SOBRESCRITOS_TO
         WHERE  COD_CLIENTE          = :lhCodCliente
         AND    NUM_ABONADO          = :lhNumAbonado
         AND    COD_CARGO_CONTRATADO = :lhCodCargoContratado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IMPORTE_SOBRESCRITO into :b0  from GE_CARGOS_SOBRE\
SCRITOS_TO where ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CARGO_CONTRATA\
DO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2375;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteOverride;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCargoContratado;
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


         
    if (SQLCODE != SQLOK  &&  SQLCODE != SQLNOTFOUND)
    {
    	vDTrazasLog (szExeName, "\n\t\t* Error Select -> GE_CARGOS_SOBREESCRITOS_TO en PA" , LOG05);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select -> GE_CARGOS_SOBREESCRITOS_TO ", szfnORAerror());
        return FALSE;
    }
    else
    {
        if (SQLCODE == SQLNOTFOUND )
    	{
    	    return FALSE;
    	}
    	
        *dImporteOverride    = dhImporteOverride   ;
    }

  return TRUE;
}/************************ Final bFindOverridePA *******************************/

/****************************************************************************************/
/* FUNCION     : bFindOverrideSS                                                        */
/* DESCRIPCION : Busca reg. en GE_CARGOS_SOBREESCRITOS_TO para Servicios Suplementarios */
/*               el criterio de busqueda es la PK                                       */
/****************************************************************************************/
BOOL bFindOverrideSS (long lCodCliente, long lNumAbonado, char *szCodServicio, double *dImporteOverride)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long   lhCodCliente;
         long   lhNumAbonado;
         char   szhCodServicio [4];/* EXEC SQL VAR szhCodServicio IS STRING(4); */ 

         double dhImporteOverride;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName, "\n\t\t* Parametros de Entrada para Override Servicios Suplementarios"
                            "\n\t\t=> Cod.Cliente  [%ld]"
                            "\n\t\t=> Num.Abonado  [%ld]"      
                            "\n\t\t=> Cod.Servicio  [%s]"
                          , LOG04
                          , lCodCliente
                          , lNumAbonado                          
                          , szCodServicio);

    memset(szhCodServicio,'\0',sizeof(szhCodServicio));
    
    lhCodCliente = lCodCliente;
    lhNumAbonado = lNumAbonado;
    strcpy (szhCodServicio,szCodServicio);
    dhImporteOverride = 0.0;  
    
    /* EXEC SQL 
         SELECT IMPORTE_SOBRESCRITO
         INTO   :dhImporteOverride
         FROM   GE_CARGOS_SOBRESCRITOS_TO
         WHERE  COD_CLIENTE  = :lhCodCliente
         AND    NUM_ABONADO  = :lhNumAbonado
         AND    COD_SERVICIO = :szhCodServicio; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IMPORTE_SOBRESCRITO into :b0  from GE_CARGOS_SOBRE\
SCRITOS_TO where ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_SERVICIO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2406;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteOverride;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


         
    if (SQLCODE != SQLOK  &&  SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog (szExeName, "\n\t\t* Error Select -> GE_CARGOS_SOBREESCRITOS_TO en SS" , LOG05);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select -> GE_CARGOS_SOBREESCRITOS_TO ", szfnORAerror());
        return FALSE;
    }
    else
    {
    	if (SQLCODE == SQLNOTFOUND )
    	{    		
    	    return FALSE;
    	}
    	
        *dImporteOverride    = dhImporteOverride   ;
    }

  return TRUE;
}/************************ Final bFindOverrideSS *******************************/

/*****************************************************************************/
/*                         funcion : bFindGrupoCob                           */
/* -Funcion que busca reg. en Fa_GrupoCob (pstGrupoCob array global), el cri-*/
/*  terio de busqueda es la PK (CodGrupo,CodProducto,CodConcepto,CodCiclo) . */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bFindGrupoCob (GRUPOCOB *pGrpCob)
{
  GRUPOCOB stkey;
  GRUPOCOB *pGrp = (GRUPOCOB *)NULL;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char  szhCodGrupo [3];/* EXEC SQL VAR szhCodGrupo IS STRING(3); */ 

  static int   ihCodProducto  ;
  static int   ihCodConcepto  ;
  static int   ihCodCiclo     ;
  static int   ihTipCobro     ;
  static int   ihTipCobroAnt  ;
  /* EXEC SQL END DECLARE SECTION; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada para Grupo Cobros"
                         "\n\t\t=> Cod.Grupo     [%s]"
                         "\n\t\t=> Cod.Producto  [%d]"
                         "\n\t\t=> Cod.Concepto  [%d]"
                         "\n\t\t=> Cod.Ciclo     [%d]",LOG04,
              pGrpCob->szCodGrupo,pGrpCob->iCodProducto,pGrpCob->iCodConcepto,
              pGrpCob->iCodCiclo);

  if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
  {
      strcpy (stkey.szCodGrupo,pGrpCob->szCodGrupo);
      stkey.iCodProducto = pGrpCob->iCodProducto   ;
      stkey.iCodConcepto = pGrpCob->iCodConcepto   ;
      stkey.iCodCiclo    = pGrpCob->iCodCiclo      ;

      if ( (pGrp = (GRUPOCOB *)bsearch (&stkey,pstGrupoCob,NUM_GRUPOCOB,
                    sizeof(GRUPOCOB),iCmpGrupoCob)) == (GRUPOCOB *)NULL)
      {
            iDError (szExeName,ERR021,vInsertarIncidencia,"pstGrupoCob");
            return FALSE;
      }
      pGrpCob->iTipCobro    = pGrp->iTipCobro   ;
  }
  if (stProceso.iCodTipDocum == stDatosGener.iCodBaja)
  {
      strcpy (szhCodGrupo,pGrpCob->szCodGrupo);
      ihCodProducto = pGrpCob->iCodProducto   ;
      ihCodConcepto = pGrpCob->iCodConcepto   ;
      ihCodCiclo    = pGrpCob->iCodCiclo      ;

      /* EXEC SQL SELECT
                      TIP_COBRO   ,
                      TIP_COBROANT
               INTO   :ihTipCobro   ,
                      :ihTipCobroAnt
               FROM   FA_GRUPOCOB
               WHERE  COD_GRUPO    = :szhCodGrupo
                 AND  COD_PRODUCTO = :ihCodProducto
                 AND  COD_CONCEPTO = :ihCodConcepto
                 AND  COD_CICLO    = :ihCodCiclo; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 45;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select TIP_COBRO ,TIP_COBROANT into :b0,:b1  from FA_GR\
UPOCOB where (((COD_GRUPO=:b2 and COD_PRODUCTO=:b3) and COD_CONCEPTO=:b4) and \
COD_CICLO=:b5)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2437;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&ihTipCobro;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&ihTipCobroAnt;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodGrupo;
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
      sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
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
          iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_GrupoCob",
                   szfnORAerror())            ;
          return FALSE;
      }
      else
      {
         pGrpCob->iTipCobro    = ihTipCobro   ;
      }
  }
  return TRUE;
}/************************ Final bFindGrupoCob *******************************/


/*****************************************************************************/
/*                          funcion : bFindRegiones                          */
/*****************************************************************************/
BOOL bFindRegiones (REGIONES *pReg)
{
   REGIONES stkey;
   REGIONES *pR = (REGIONES *)NULL;

   strcpy (stkey.szCodRegion   ,pR->szCodRegion);

   if ((pReg = (REGIONES *)bsearch (&stkey,pstRegiones,NUM_REGIONES,
                           sizeof(REGIONES),iCmpRegiones))==(REGIONES *)NULL)
   {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstRegiones");
        return FALSE;
   }

   strcpy (pReg->szDesRegion,pR->szDesRegion);
   return TRUE;
}/**************************** Funcion : bFindRegiones ***********************/


/*****************************************************************************/
/*                          funcion : iCmpRegiones                           */
/*****************************************************************************/
int iCmpRegiones (const void* cad1,const void* cad2)
{
  int rc = 0;

  return
   ( (rc = strcmp ( ((REGIONES *)cad1)->szCodRegion,
                    ((REGIONES *)cad2)->szCodRegion) )  != 0 )?rc:0;

}/************************** Final iCmpRegiones   ****************************/

/*****************************************************************************/
/*                          funcion : iCmpRangoTabla                         */
/*****************************************************************************/
int iCmpRangoTabla (const void* cad1,const void* cad2)
{
  int rc = 0;

  return
   ( (rc =  ((RANGOTABLA *)cad1)->lCodCiclFact-
            ((RANGOTABLA *)cad2)->lCodCiclFact )!= 0)?rc:
   ( (rc =  ((RANGOTABLA *)cad1)->lRangoIni-
            ((RANGOTABLA *)cad1)->lRangoIni    )!= 0)?rc:
   ( (rc =  strcmp ( ((RANGOTABLA *)cad1)->szNomTabla,
                      ((RANGOTABLA *)cad2)->szNomTabla )) != 0)?rc:0 ;
}/************************** Final iCmpRangoTabla ****************************/

/*****************************************************************************/
/*                          funcion : bfnGetDatosCliente                     */
/*****************************************************************************/
BOOL bfnGetDatosCliente (long lCodCliente)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int iExist;
         static long   lhCodCliente          ;
         static long   lhCodCuenta           ;
         static char   szhNomCliente     [51];/* EXEC SQL VAR szhNomCliente    IS STRING(51); */ 

         static char   szhNomApeClien1   [21];/* EXEC SQL VAR szhNomApeClien1  IS STRING(21); */ 

         static char   szhNomApeClien2   [21];/* EXEC SQL VAR szhNomApeClien2  IS STRING(21); */ 

         static char   szhTefCliente1    [13];/* EXEC SQL VAR szhTefCliente1   IS STRING(13); */ 

         static char   szhTefCliente2    [13];/* EXEC SQL VAR szhTefCliente2   IS STRING(13); */ 

         static char   szhCodPais         [4];/* EXEC SQL VAR szhCodPais       IS STRING(4) ; */ 

         static char   szhIndDebito       [2];/* EXEC SQL VAR szhIndDebito     IS STRING(2) ; */ 

         static double dhImpStopDebit        ;
         static char   szhCodBanco       [16];/* EXEC SQL VAR szhCodBanco      IS STRING(16) ; */ 

         static char   szhCodSucursal     [5];/* EXEC SQL VAR szhCodSucursal   IS STRING(5) ; */ 

         static char   szhIndTipCuenta    [2];/* EXEC SQL VAR szhIndTipCuenta  IS STRING(2) ; */ 

         static char   szhNumCtaCorr     [19];/* EXEC SQL VAR szhNumCtaCorr    IS STRING(19); */ 

         static char   szhNumTarjeta     [19];/* EXEC SQL VAR szhNumTarjeta    IS STRING(19); */ 

         static char   szhFecVenciTarj   [15];/* EXEC SQL VAR szhFecVenciTarj  IS STRING(15); */ 

         static char   szhCodBancoTarj   [16];/* EXEC SQL VAR szhCodBancoTarj  IS STRING(16) ; */ 

         static char   szhCodTipIdTrib    [3];/* EXEC SQL VAR szhCodTipIdTrib  IS STRING(3) ; */ 

         static char   szhNumIdentTrib   [21];/* EXEC SQL VAR szhNumIdentTrib  IS STRING(21); */ 

         static char   szhCodTipTarjeta   [4];/* EXEC SQL VAR szhCodTipTarjeta IS STRING(4) ; */ 

         static char   szhCodOficina      [3];/* EXEC SQL VAR szhCodOficina    IS STRING(3) ; */ 

         static char   szhNumFax         [16];/* EXEC SQL VAR szhNumFax        IS STRING(16); */ 

         static char   szhFecAlta        [15];/* EXEC SQL VAR szhFecAlta       IS STRING(15); */ 

         static char   szhCodIdioma       [6];/* EXEC SQL VAR szhCodIdioma     IS STRING(6); */ 

         static char   szhCodSegmentacion [6];/* EXEC SQL VAR szhCodSegmentacion IS STRING(6); */ 

         static char   szhCodDespacho     [6];/* EXEC SQL VAR szhCodDespacho   IS STRING(6); */ 

         static char   szhNomEmail       [71];/* EXEC SQL VAR szhNomEmail      IS STRING(71); */ 

         static char   szhCodIdTipDian    [3]; /* EXEC SQL VAR szhCodIdTipDian  IS STRING(3); */ 

         static int    ihCodActividad        ;
         static int    ihIndFactur           ;
         static int    ihIndClieLoc          ;         
         static char   szhCodOperadora    [6];/* EXEC SQL VAR szhCodOperadora     IS STRING(6); */ 

         static short  i_shCodOficina        ;
         static short  i_shNomApeClien1      ;
         static short  i_shNomApeClien2      ;
         static short  i_shTefCliente1       ;
         static short  i_shTefCliente2       ;
         static short  i_shCodPais           ;
         static short  i_shIndDebito         ;
         static short  i_shCodTipTarjeta     ;
         static short  i_shImpStopDebit      ;
         static short  i_shCodBanco          ;
         static short  i_shCodSucursal       ;
         static short  i_shIndTipCuenta      ;
         static short  i_shNumCtaCorr        ;
         static short  i_shNumTarjeta        ;
         static short  i_shFecVenciTarj      ;
         static short  i_shCodBancoTarj      ;
         static short  i_shCodTipIdTrib      ;
         static short  i_shNumIdentTrib      ;
         static short  i_shCodActividad      ;
         static short  i_shNumFax            ;
         static short  i_shCodOperadora      ;
         static short  i_shCodDespacho       ;
         static short  i_shNomEmail          ;
         static char   szhFmtFecha       [17];/* EXEC SQL VAR szhFmtFecha     IS STRING(17); */ 

         static char   szhFecEmision     [15];/* EXEC SQL VAR szhFecEmision   IS STRING(15); */ 

         static int    ihZero                ;
    /* EXEC SQL END DECLARE SECTION; */ 


                        
    lhCodCliente = lCodCliente;

    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");
    
    strcpy (szhFecEmision, szGetFecZonaImp(stProceso.iCodTipDocum));    
    /*sprintf (szhFecEmision,stCiclo.szFecEmision);*/ /* P-COL-08012 */
 
    vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ge_Clientes\n"
                           "\t\t=> Cod.Cliente  [%ld]\n"
                           "\t\t=> Fec.Emision  [%s]\n"
                          ,LOG05,lhCodCliente,szhFecEmision);
    ihZero = 0;
 
    /* EXEC SQL 
         SELECT count(1)
	 INTO   :iExist
	 FROM   ALL_TABLES
	 WHERE  TABLE_NAME = 'GA_VALOR_CLI'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from ALL_TABLES where TABLE_NAM\
E='GA_VALOR_CLI'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2476;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
    if ( SQLCODE )
    {
         iDError (szExeName,ERR000,vInsertarIncidencia,"Error validacion de tabla GA_VALOR_CLI",szfnORAerror());
         return FALSE;
    }
	
    if ( iExist == 0)
    {
 	 vDTrazasLog (szExeName,"\n\t\t* La Tabla GA_VALOR_CLI NO existe por lo tanto todos los clientes tendra codigo de segmencacion igual a 0\n",LOG03);
 		
 	 /* EXEC SQL SELECT /o+ index (GE_CLIENTES PK_GE_CLIENTES) o/
                    GC.NOM_CLIENTE           ,
                    GC.NOM_APECLIEN1         ,
                    GC.NOM_APECLIEN2         ,
                    GC.TEF_CLIENTE1          ,
                    GC.TEF_CLIENTE2          ,
                    GC.COD_PAIS              ,
                    GC.IND_DEBITO            ,
                    GC.IMP_STOPDEBIT         ,
                    GC.COD_BANCO             ,
                    GC.COD_SUCURSAL          ,
                    GC.IND_TIPCUENTA         ,
                    GC.COD_TIPTARJETA        ,
                    GC.NUM_CTACORR           ,
                    GC.NUM_TARJETA           ,
                    TO_CHAR (GC.FEC_VENCITARJ,:szhFmtFecha),
                    GC.COD_BANCOTARJ         ,
                    GC.COD_TIPIDTRIB         ,
                    GC.NUM_IDENT             ,
                    GC.COD_ACTIVIDAD         ,
                    GC.COD_OFICINA           ,
                    GC.IND_FACTUR            ,
                    GC.NUM_FAX               ,
                    TO_CHAR (GC.FEC_ALTA,:szhFmtFecha),
                    GC.COD_CUENTA            ,
                    GC.COD_IDIOMA            ,
                    GC.COD_OPERADORA         ,
                    NVL(FCT.COD_DESPACHO,'FISIC')       ,
		    NVL(FCT.NOM_EMAIL,NVL(GC.NOM_EMAIL,'SIN INFORMACION')),
		    NVL(GTI.COD_TIPIDENTDIAN,'01'),
                    DECODE(NVL(CLILOC.COD_CLIENTE, 0),CLILOC.COD_CLIENTE,1,0,0),
                    :ihZero
                  INTO
                    :szhNomCliente       ,
                    :szhNomApeClien1:i_shNomApeClien1    ,
                    :szhNomApeClien2:i_shNomApeClien2    ,
                    :szhTefCliente1:i_shTefCliente1      ,
                    :szhTefCliente2:i_shTefCliente2      ,
                    :szhCodPais:i_shCodPais              ,
                    :szhIndDebito:i_shIndDebito          ,
                    :dhImpStopDebit:i_shImpStopDebit     ,
                    :szhCodBanco:i_shCodBanco            ,
                    :szhCodSucursal:i_shCodSucursal      ,
                    :szhIndTipCuenta:i_shIndTipCuenta    ,
                    :szhCodTipTarjeta:i_shCodTipTarjeta  ,
                    :szhNumCtaCorr:i_shNumCtaCorr        ,
                    :szhNumTarjeta:i_shNumTarjeta        ,
                    :szhFecVenciTarj:i_shFecVenciTarj    ,
                    :szhCodBancoTarj:i_shCodBancoTarj    ,
                    :szhCodTipIdTrib:i_shCodTipIdTrib    ,
                    :szhNumIdentTrib:i_shNumIdentTrib    ,
                    :ihCodActividad:i_shCodActividad     ,
                    :szhCodOficina:i_shCodOficina        ,
                    :ihIndFactur                         ,
                    :szhNumFax:i_shNumFax                ,
                    :szhFecAlta                          ,
                    :lhCodCuenta                         ,
                    :szhCodIdioma                        ,
                    :szhCodOperadora:i_shCodOperadora    ,
                    :szhCodDespacho:i_shCodDespacho      ,
		    :szhNomEmail:i_shNomEmail            ,
		    :szhCodIdTipDian                     ,
		    :ihIndClieLoc                         ,
                    :szhCodSegmentacion
                  FROM   GE_CLIENTES GC , GE_CLILOCPADREHIJO_TO CLILOC,
                         (SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA,
                                 NOM_EMAIL, COD_DESPACHO 
                          FROM   FA_CLIENTE_TO
                          WHERE  COD_CLIENTE = :lhCodCliente
                          AND    ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha)
                          AND     NVL(FEC_HASTA,TO_DATE(:szhFecEmision,:szhFmtFecha)) >= TO_DATE(:szhFecEmision,:szhFmtFecha))                          
                          OR     ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) 
                          AND    FEC_HASTA IS NULL)))
                          ) FCT, 
                         GE_TIPIDENT GTI
                  WHERE  GC.COD_CLIENTE      = :lhCodCliente
                  AND    GC.COD_CLIENTE      = CLILOC.COD_CLIENTE(+)
                  AND    GC.COD_TIPIDTRIB    = GTI.COD_TIPIDENT(+)
                  AND    FCT.COD_CLIENTE(+)  = GC.COD_CLIENTE; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 48;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlbuft((void **)0, 
     "select  /*+  index (GE_CLIENTES PK_GE_CLIENTES)  +*/ GC.NOM_CLIENTE ,G\
C.NOM_APECLIEN1 ,GC.NOM_APECLIEN2 ,GC.TEF_CLIENTE1 ,GC.TEF_CLIENTE2 ,GC.COD_\
PAIS ,GC.IND_DEBITO ,GC.IMP_STOPDEBIT ,GC.COD_BANCO ,GC.COD_SUCURSAL ,GC.IND\
_TIPCUENTA ,GC.COD_TIPTARJETA ,GC.NUM_CTACORR ,GC.NUM_TARJETA ,TO_CHAR(GC.FE\
C_VENCITARJ,:b0) ,GC.COD_BANCOTARJ ,GC.COD_TIPIDTRIB ,GC.NUM_IDENT ,GC.COD_A\
CTIVIDAD ,GC.COD_OFICINA ,GC.IND_FACTUR ,GC.NUM_FAX ,TO_CHAR(GC.FEC_ALTA,:b0\
) ,GC.COD_CUENTA ,GC.COD_IDIOMA ,GC.COD_OPERADORA ,NVL(FCT.COD_DESPACHO,'FIS\
IC') ,NVL(FCT.NOM_EMAIL,NVL(GC.NOM_EMAIL,'SIN INFORMACION')) ,NVL(GTI.COD_TI\
PIDENTDIAN,'01') ,DECODE(NVL(CLILOC.COD_CLIENTE,0),CLILOC.COD_CLIENTE,1,0,0)\
 ,:b2 into :b3,:b4:b5,:b6:b7,:b8:b9,:b10:b11,:b12:b13,:b14:b15,:b16:b17,:b18\
:b19,:b20:b21,:b22:b23,:b24:b25,:b26:b27,:b28:b29,:b30:b31,:b32:b33,:b34:b35\
,:b36:b37,:b38:b39,:b40:b41,:b42,:b43:b44,:b45,:b46,:b47,:b48:b49,:b50:b51,:\
b52:b53,:b54,:b55,:b56  from GE_CLIENTES GC ,GE_CLILOCPADREHIJO_TO CLILOC ,(\
select COD_CLIENTE ,FEC_DESDE ,FEC_HASTA ,");
   sqlstm.stmt = "NOM_EMAIL ,COD_DESPACHO  from FA_CLIENTE_TO where (COD_CLI\
ENTE=:b57 and ((NVL(FEC_DESDE,TO_DATE(:b58,:b0))<=TO_DATE(:b58,:b0) and NVL(FE\
C_HASTA,TO_DATE(:b58,:b0))>=TO_DATE(:b58,:b0)) or (NVL(FEC_DESDE,TO_DATE(:b58,\
:b0))<=TO_DATE(:b58,:b0) and FEC_HASTA is null )))) FCT ,GE_TIPIDENT GTI where\
 (((GC.COD_CLIENTE=:b57 and GC.COD_CLIENTE=CLILOC.COD_CLIENTE(+)) and GC.COD_T\
IPIDTRIB=GTI.COD_TIPIDENT(+)) and FCT.COD_CLIENTE(+)=GC.COD_CLIENTE)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )2495;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
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
   sqlstm.sqhstv[2] = (unsigned char  *)&ihZero;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNomCliente;
   sqlstm.sqhstl[3] = (unsigned long )51;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNomApeClien1;
   sqlstm.sqhstl[4] = (unsigned long )21;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)&i_shNomApeClien1;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhNomApeClien2;
   sqlstm.sqhstl[5] = (unsigned long )21;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)&i_shNomApeClien2;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhTefCliente1;
   sqlstm.sqhstl[6] = (unsigned long )13;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)&i_shTefCliente1;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhTefCliente2;
   sqlstm.sqhstl[7] = (unsigned long )13;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)&i_shTefCliente2;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhCodPais;
   sqlstm.sqhstl[8] = (unsigned long )4;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)&i_shCodPais;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhIndDebito;
   sqlstm.sqhstl[9] = (unsigned long )2;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)&i_shIndDebito;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&dhImpStopDebit;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)&i_shImpStopDebit;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhCodBanco;
   sqlstm.sqhstl[11] = (unsigned long )16;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)&i_shCodBanco;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhCodSucursal;
   sqlstm.sqhstl[12] = (unsigned long )5;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)&i_shCodSucursal;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhIndTipCuenta;
   sqlstm.sqhstl[13] = (unsigned long )2;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)&i_shIndTipCuenta;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhCodTipTarjeta;
   sqlstm.sqhstl[14] = (unsigned long )4;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)&i_shCodTipTarjeta;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhNumCtaCorr;
   sqlstm.sqhstl[15] = (unsigned long )19;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)&i_shNumCtaCorr;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhNumTarjeta;
   sqlstm.sqhstl[16] = (unsigned long )19;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)&i_shNumTarjeta;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhFecVenciTarj;
   sqlstm.sqhstl[17] = (unsigned long )15;
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)&i_shFecVenciTarj;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)szhCodBancoTarj;
   sqlstm.sqhstl[18] = (unsigned long )16;
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)&i_shCodBancoTarj;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)szhCodTipIdTrib;
   sqlstm.sqhstl[19] = (unsigned long )3;
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)&i_shCodTipIdTrib;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)szhNumIdentTrib;
   sqlstm.sqhstl[20] = (unsigned long )21;
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)&i_shNumIdentTrib;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
   sqlstm.sqhstv[21] = (unsigned char  *)&ihCodActividad;
   sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[21] = (         int  )0;
   sqlstm.sqindv[21] = (         short *)&i_shCodActividad;
   sqlstm.sqinds[21] = (         int  )0;
   sqlstm.sqharm[21] = (unsigned long )0;
   sqlstm.sqadto[21] = (unsigned short )0;
   sqlstm.sqtdso[21] = (unsigned short )0;
   sqlstm.sqhstv[22] = (unsigned char  *)szhCodOficina;
   sqlstm.sqhstl[22] = (unsigned long )3;
   sqlstm.sqhsts[22] = (         int  )0;
   sqlstm.sqindv[22] = (         short *)&i_shCodOficina;
   sqlstm.sqinds[22] = (         int  )0;
   sqlstm.sqharm[22] = (unsigned long )0;
   sqlstm.sqadto[22] = (unsigned short )0;
   sqlstm.sqtdso[22] = (unsigned short )0;
   sqlstm.sqhstv[23] = (unsigned char  *)&ihIndFactur;
   sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[23] = (         int  )0;
   sqlstm.sqindv[23] = (         short *)0;
   sqlstm.sqinds[23] = (         int  )0;
   sqlstm.sqharm[23] = (unsigned long )0;
   sqlstm.sqadto[23] = (unsigned short )0;
   sqlstm.sqtdso[23] = (unsigned short )0;
   sqlstm.sqhstv[24] = (unsigned char  *)szhNumFax;
   sqlstm.sqhstl[24] = (unsigned long )16;
   sqlstm.sqhsts[24] = (         int  )0;
   sqlstm.sqindv[24] = (         short *)&i_shNumFax;
   sqlstm.sqinds[24] = (         int  )0;
   sqlstm.sqharm[24] = (unsigned long )0;
   sqlstm.sqadto[24] = (unsigned short )0;
   sqlstm.sqtdso[24] = (unsigned short )0;
   sqlstm.sqhstv[25] = (unsigned char  *)szhFecAlta;
   sqlstm.sqhstl[25] = (unsigned long )15;
   sqlstm.sqhsts[25] = (         int  )0;
   sqlstm.sqindv[25] = (         short *)0;
   sqlstm.sqinds[25] = (         int  )0;
   sqlstm.sqharm[25] = (unsigned long )0;
   sqlstm.sqadto[25] = (unsigned short )0;
   sqlstm.sqtdso[25] = (unsigned short )0;
   sqlstm.sqhstv[26] = (unsigned char  *)&lhCodCuenta;
   sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[26] = (         int  )0;
   sqlstm.sqindv[26] = (         short *)0;
   sqlstm.sqinds[26] = (         int  )0;
   sqlstm.sqharm[26] = (unsigned long )0;
   sqlstm.sqadto[26] = (unsigned short )0;
   sqlstm.sqtdso[26] = (unsigned short )0;
   sqlstm.sqhstv[27] = (unsigned char  *)szhCodIdioma;
   sqlstm.sqhstl[27] = (unsigned long )6;
   sqlstm.sqhsts[27] = (         int  )0;
   sqlstm.sqindv[27] = (         short *)0;
   sqlstm.sqinds[27] = (         int  )0;
   sqlstm.sqharm[27] = (unsigned long )0;
   sqlstm.sqadto[27] = (unsigned short )0;
   sqlstm.sqtdso[27] = (unsigned short )0;
   sqlstm.sqhstv[28] = (unsigned char  *)szhCodOperadora;
   sqlstm.sqhstl[28] = (unsigned long )6;
   sqlstm.sqhsts[28] = (         int  )0;
   sqlstm.sqindv[28] = (         short *)&i_shCodOperadora;
   sqlstm.sqinds[28] = (         int  )0;
   sqlstm.sqharm[28] = (unsigned long )0;
   sqlstm.sqadto[28] = (unsigned short )0;
   sqlstm.sqtdso[28] = (unsigned short )0;
   sqlstm.sqhstv[29] = (unsigned char  *)szhCodDespacho;
   sqlstm.sqhstl[29] = (unsigned long )6;
   sqlstm.sqhsts[29] = (         int  )0;
   sqlstm.sqindv[29] = (         short *)&i_shCodDespacho;
   sqlstm.sqinds[29] = (         int  )0;
   sqlstm.sqharm[29] = (unsigned long )0;
   sqlstm.sqadto[29] = (unsigned short )0;
   sqlstm.sqtdso[29] = (unsigned short )0;
   sqlstm.sqhstv[30] = (unsigned char  *)szhNomEmail;
   sqlstm.sqhstl[30] = (unsigned long )71;
   sqlstm.sqhsts[30] = (         int  )0;
   sqlstm.sqindv[30] = (         short *)&i_shNomEmail;
   sqlstm.sqinds[30] = (         int  )0;
   sqlstm.sqharm[30] = (unsigned long )0;
   sqlstm.sqadto[30] = (unsigned short )0;
   sqlstm.sqtdso[30] = (unsigned short )0;
   sqlstm.sqhstv[31] = (unsigned char  *)szhCodIdTipDian;
   sqlstm.sqhstl[31] = (unsigned long )3;
   sqlstm.sqhsts[31] = (         int  )0;
   sqlstm.sqindv[31] = (         short *)0;
   sqlstm.sqinds[31] = (         int  )0;
   sqlstm.sqharm[31] = (unsigned long )0;
   sqlstm.sqadto[31] = (unsigned short )0;
   sqlstm.sqtdso[31] = (unsigned short )0;
   sqlstm.sqhstv[32] = (unsigned char  *)&ihIndClieLoc;
   sqlstm.sqhstl[32] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[32] = (         int  )0;
   sqlstm.sqindv[32] = (         short *)0;
   sqlstm.sqinds[32] = (         int  )0;
   sqlstm.sqharm[32] = (unsigned long )0;
   sqlstm.sqadto[32] = (unsigned short )0;
   sqlstm.sqtdso[32] = (unsigned short )0;
   sqlstm.sqhstv[33] = (unsigned char  *)szhCodSegmentacion;
   sqlstm.sqhstl[33] = (unsigned long )6;
   sqlstm.sqhsts[33] = (         int  )0;
   sqlstm.sqindv[33] = (         short *)0;
   sqlstm.sqinds[33] = (         int  )0;
   sqlstm.sqharm[33] = (unsigned long )0;
   sqlstm.sqadto[33] = (unsigned short )0;
   sqlstm.sqtdso[33] = (unsigned short )0;
   sqlstm.sqhstv[34] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[34] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[34] = (         int  )0;
   sqlstm.sqindv[34] = (         short *)0;
   sqlstm.sqinds[34] = (         int  )0;
   sqlstm.sqharm[34] = (unsigned long )0;
   sqlstm.sqadto[34] = (unsigned short )0;
   sqlstm.sqtdso[34] = (unsigned short )0;
   sqlstm.sqhstv[35] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[35] = (unsigned long )15;
   sqlstm.sqhsts[35] = (         int  )0;
   sqlstm.sqindv[35] = (         short *)0;
   sqlstm.sqinds[35] = (         int  )0;
   sqlstm.sqharm[35] = (unsigned long )0;
   sqlstm.sqadto[35] = (unsigned short )0;
   sqlstm.sqtdso[35] = (unsigned short )0;
   sqlstm.sqhstv[36] = (unsigned char  *)szhFmtFecha;
   sqlstm.sqhstl[36] = (unsigned long )17;
   sqlstm.sqhsts[36] = (         int  )0;
   sqlstm.sqindv[36] = (         short *)0;
   sqlstm.sqinds[36] = (         int  )0;
   sqlstm.sqharm[36] = (unsigned long )0;
   sqlstm.sqadto[36] = (unsigned short )0;
   sqlstm.sqtdso[36] = (unsigned short )0;
   sqlstm.sqhstv[37] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[37] = (unsigned long )15;
   sqlstm.sqhsts[37] = (         int  )0;
   sqlstm.sqindv[37] = (         short *)0;
   sqlstm.sqinds[37] = (         int  )0;
   sqlstm.sqharm[37] = (unsigned long )0;
   sqlstm.sqadto[37] = (unsigned short )0;
   sqlstm.sqtdso[37] = (unsigned short )0;
   sqlstm.sqhstv[38] = (unsigned char  *)szhFmtFecha;
   sqlstm.sqhstl[38] = (unsigned long )17;
   sqlstm.sqhsts[38] = (         int  )0;
   sqlstm.sqindv[38] = (         short *)0;
   sqlstm.sqinds[38] = (         int  )0;
   sqlstm.sqharm[38] = (unsigned long )0;
   sqlstm.sqadto[38] = (unsigned short )0;
   sqlstm.sqtdso[38] = (unsigned short )0;
   sqlstm.sqhstv[39] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[39] = (unsigned long )15;
   sqlstm.sqhsts[39] = (         int  )0;
   sqlstm.sqindv[39] = (         short *)0;
   sqlstm.sqinds[39] = (         int  )0;
   sqlstm.sqharm[39] = (unsigned long )0;
   sqlstm.sqadto[39] = (unsigned short )0;
   sqlstm.sqtdso[39] = (unsigned short )0;
   sqlstm.sqhstv[40] = (unsigned char  *)szhFmtFecha;
   sqlstm.sqhstl[40] = (unsigned long )17;
   sqlstm.sqhsts[40] = (         int  )0;
   sqlstm.sqindv[40] = (         short *)0;
   sqlstm.sqinds[40] = (         int  )0;
   sqlstm.sqharm[40] = (unsigned long )0;
   sqlstm.sqadto[40] = (unsigned short )0;
   sqlstm.sqtdso[40] = (unsigned short )0;
   sqlstm.sqhstv[41] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[41] = (unsigned long )15;
   sqlstm.sqhsts[41] = (         int  )0;
   sqlstm.sqindv[41] = (         short *)0;
   sqlstm.sqinds[41] = (         int  )0;
   sqlstm.sqharm[41] = (unsigned long )0;
   sqlstm.sqadto[41] = (unsigned short )0;
   sqlstm.sqtdso[41] = (unsigned short )0;
   sqlstm.sqhstv[42] = (unsigned char  *)szhFmtFecha;
   sqlstm.sqhstl[42] = (unsigned long )17;
   sqlstm.sqhsts[42] = (         int  )0;
   sqlstm.sqindv[42] = (         short *)0;
   sqlstm.sqinds[42] = (         int  )0;
   sqlstm.sqharm[42] = (unsigned long )0;
   sqlstm.sqadto[42] = (unsigned short )0;
   sqlstm.sqtdso[42] = (unsigned short )0;
   sqlstm.sqhstv[43] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[43] = (unsigned long )15;
   sqlstm.sqhsts[43] = (         int  )0;
   sqlstm.sqindv[43] = (         short *)0;
   sqlstm.sqinds[43] = (         int  )0;
   sqlstm.sqharm[43] = (unsigned long )0;
   sqlstm.sqadto[43] = (unsigned short )0;
   sqlstm.sqtdso[43] = (unsigned short )0;
   sqlstm.sqhstv[44] = (unsigned char  *)szhFmtFecha;
   sqlstm.sqhstl[44] = (unsigned long )17;
   sqlstm.sqhsts[44] = (         int  )0;
   sqlstm.sqindv[44] = (         short *)0;
   sqlstm.sqinds[44] = (         int  )0;
   sqlstm.sqharm[44] = (unsigned long )0;
   sqlstm.sqadto[44] = (unsigned short )0;
   sqlstm.sqtdso[44] = (unsigned short )0;
   sqlstm.sqhstv[45] = (unsigned char  *)szhFecEmision;
   sqlstm.sqhstl[45] = (unsigned long )15;
   sqlstm.sqhsts[45] = (         int  )0;
   sqlstm.sqindv[45] = (         short *)0;
   sqlstm.sqinds[45] = (         int  )0;
   sqlstm.sqharm[45] = (unsigned long )0;
   sqlstm.sqadto[45] = (unsigned short )0;
   sqlstm.sqtdso[45] = (unsigned short )0;
   sqlstm.sqhstv[46] = (unsigned char  *)szhFmtFecha;
   sqlstm.sqhstl[46] = (unsigned long )17;
   sqlstm.sqhsts[46] = (         int  )0;
   sqlstm.sqindv[46] = (         short *)0;
   sqlstm.sqinds[46] = (         int  )0;
   sqlstm.sqharm[46] = (unsigned long )0;
   sqlstm.sqadto[46] = (unsigned short )0;
   sqlstm.sqtdso[46] = (unsigned short )0;
   sqlstm.sqhstv[47] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[47] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[47] = (         int  )0;
   sqlstm.sqindv[47] = (         short *)0;
   sqlstm.sqinds[47] = (         int  )0;
   sqlstm.sqharm[47] = (unsigned long )0;
   sqlstm.sqadto[47] = (unsigned short )0;
   sqlstm.sqtdso[47] = (unsigned short )0;
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
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
    	 /* EXEC SQL SELECT /o+ index (GE_CLIENTES PK_GE_CLIENTES) o/
            	    GC.NOM_CLIENTE           ,
                    GC.NOM_APECLIEN1         ,
                    GC.NOM_APECLIEN2         ,
                    GC.TEF_CLIENTE1          ,
                    GC.TEF_CLIENTE2          ,
                    GC.COD_PAIS              ,
                    GC.IND_DEBITO            ,
                    GC.IMP_STOPDEBIT         ,
                    GC.COD_BANCO             ,
                    GC.COD_SUCURSAL          ,
                    GC.IND_TIPCUENTA         ,
                    GC.COD_TIPTARJETA        ,
                    GC.NUM_CTACORR           ,
                    GC.NUM_TARJETA           ,
                    TO_CHAR (GC.FEC_VENCITARJ,:szhFmtFecha),
                    GC.COD_BANCOTARJ         ,
                    GC.COD_TIPIDTRIB         ,
                    GC.NUM_IDENT             ,
                    GC.COD_ACTIVIDAD         ,
                    GC.COD_OFICINA           ,
                    GC.IND_FACTUR            ,
                    GC.NUM_FAX               ,
                    TO_CHAR (GC.FEC_ALTA,:szhFmtFecha),
                    GC.COD_CUENTA            ,
                    GC.COD_IDIOMA            ,
                    GC.COD_OPERADORA         ,
                    NVL(FCT.COD_DESPACHO,'FISIC') ,
		    NVL(FCT.NOM_EMAIL,NVL(GC.NOM_EMAIL,'SIN INFORMACION')),
		    NVL(GTI.COD_TIPIDENTDIAN,'01'),
                    DECODE(NVL(CLILOC.COD_CLIENTE, 0),CLILOC.COD_CLIENTE,1,0,0),		    
                    NVL(GVC.COD_VALOR,0)
                  INTO
                    :szhNomCliente       ,
                    :szhNomApeClien1:i_shNomApeClien1    ,
                    :szhNomApeClien2:i_shNomApeClien2    ,
                    :szhTefCliente1:i_shTefCliente1      ,
                    :szhTefCliente2:i_shTefCliente2      ,
                    :szhCodPais:i_shCodPais              ,
                    :szhIndDebito:i_shIndDebito          ,
                    :dhImpStopDebit:i_shImpStopDebit     ,
                    :szhCodBanco:i_shCodBanco            ,
                    :szhCodSucursal:i_shCodSucursal      ,
                    :szhIndTipCuenta:i_shIndTipCuenta    ,
                    :szhCodTipTarjeta:i_shCodTipTarjeta  ,
                    :szhNumCtaCorr:i_shNumCtaCorr        ,
                    :szhNumTarjeta:i_shNumTarjeta        ,
                    :szhFecVenciTarj:i_shFecVenciTarj    ,
                    :szhCodBancoTarj:i_shCodBancoTarj    ,
                    :szhCodTipIdTrib:i_shCodTipIdTrib    ,
                    :szhNumIdentTrib:i_shNumIdentTrib    ,
                    :ihCodActividad:i_shCodActividad     ,
                    :szhCodOficina:i_shCodOficina        ,
                    :ihIndFactur                         ,
                    :szhNumFax:i_shNumFax                ,
                    :szhFecAlta                          ,
                    :lhCodCuenta                         ,
                    :szhCodIdioma                        ,
                    :szhCodOperadora:i_shCodOperadora    ,
                    :szhCodDespacho:i_shCodDespacho      ,
		    :szhNomEmail:i_shNomEmail            ,
		    :szhCodIdTipDian                     ,
		    :ihIndClieLoc                         ,		    
                    :szhCodSegmentacion
                  FROM   GE_CLIENTES GC, GA_VALOR_CLI GVC, GE_CLILOCPADREHIJO_TO CLILOC,
                         (SELECT COD_CLIENTE, FEC_DESDE, FEC_HASTA,
                                 NOM_EMAIL, COD_DESPACHO 
                          FROM   FA_CLIENTE_TO
                          WHERE  COD_CLIENTE = :lhCodCliente
                          AND    ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha)
                          AND     NVL(FEC_HASTA,TO_DATE(:szhFecEmision,:szhFmtFecha)) >= TO_DATE(:szhFecEmision,:szhFmtFecha))                          
                          OR     ((NVL(FEC_DESDE,TO_DATE(:szhFecEmision,:szhFmtFecha)) <= TO_DATE(:szhFecEmision,:szhFmtFecha) 
                          AND   FEC_HASTA IS NULL)))) FCT, 
                          GE_TIPIDENT GTI
                  WHERE  GC.COD_CLIENTE     = :lhCodCliente
                  AND    GC.COD_CLIENTE     = CLILOC.COD_CLIENTE(+)
                  AND    GVC.COD_CLIENTE(+) = GC.COD_CLIENTE
                  AND    GC.COD_TIPIDTRIB   = GTI.COD_TIPIDENT(+)
                  AND    FCT.COD_CLIENTE(+) = GC.COD_CLIENTE; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 48;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlbuft((void **)0, 
        "select  /*+  index (GE_CLIENTES PK_GE_CLIENTES)  +*/ GC.NOM_CLIENTE\
 ,GC.NOM_APECLIEN1 ,GC.NOM_APECLIEN2 ,GC.TEF_CLIENTE1 ,GC.TEF_CLIENTE2 ,GC.C\
OD_PAIS ,GC.IND_DEBITO ,GC.IMP_STOPDEBIT ,GC.COD_BANCO ,GC.COD_SUCURSAL ,GC.\
IND_TIPCUENTA ,GC.COD_TIPTARJETA ,GC.NUM_CTACORR ,GC.NUM_TARJETA ,TO_CHAR(GC\
.FEC_VENCITARJ,:b0) ,GC.COD_BANCOTARJ ,GC.COD_TIPIDTRIB ,GC.NUM_IDENT ,GC.CO\
D_ACTIVIDAD ,GC.COD_OFICINA ,GC.IND_FACTUR ,GC.NUM_FAX ,TO_CHAR(GC.FEC_ALTA,\
:b0) ,GC.COD_CUENTA ,GC.COD_IDIOMA ,GC.COD_OPERADORA ,NVL(FCT.COD_DESPACHO,'\
FISIC') ,NVL(FCT.NOM_EMAIL,NVL(GC.NOM_EMAIL,'SIN INFORMACION')) ,NVL(GTI.COD\
_TIPIDENTDIAN,'01') ,DECODE(NVL(CLILOC.COD_CLIENTE,0),CLILOC.COD_CLIENTE,1,0\
,0) ,NVL(GVC.COD_VALOR,0) into :b2,:b3:b4,:b5:b6,:b7:b8,:b9:b10,:b11:b12,:b1\
3:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28,:b29:b3\
0,:b31:b32,:b33:b34,:b35:b36,:b37:b38,:b39:b40,:b41,:b42:b43,:b44,:b45,:b46,\
:b47:b48,:b49:b50,:b51:b52,:b53,:b54,:b55  from GE_CLIENTES GC ,GA_VALOR_CLI\
 GVC ,GE_CLILOCPADREHIJO_TO CLILOC ,(select C");
      sqlstm.stmt = "OD_CLIENTE ,FEC_DESDE ,FEC_HASTA ,NOM_EMAIL ,COD_DESPAC\
HO  from FA_CLIENTE_TO where (COD_CLIENTE=:b56 and ((NVL(FEC_DESDE,TO_DATE(:b5\
7,:b0))<=TO_DATE(:b57,:b0) and NVL(FEC_HASTA,TO_DATE(:b57,:b0))>=TO_DATE(:b57,\
:b0)) or (NVL(FEC_DESDE,TO_DATE(:b57,:b0))<=TO_DATE(:b57,:b0) and FEC_HASTA is\
 null )))) FCT ,GE_TIPIDENT GTI where ((((GC.COD_CLIENTE=:b56 and GC.COD_CLIEN\
TE=CLILOC.COD_CLIENTE(+)) and GVC.COD_CLIENTE(+)=GC.COD_CLIENTE) and GC.COD_TI\
PIDTRIB=GTI.COD_TIPIDENT(+)) and FCT.COD_CLIENTE(+)=GC.COD_CLIENTE)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )2702;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
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
      sqlstm.sqhstv[2] = (unsigned char  *)szhNomCliente;
      sqlstm.sqhstl[2] = (unsigned long )51;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhNomApeClien1;
      sqlstm.sqhstl[3] = (unsigned long )21;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)&i_shNomApeClien1;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhNomApeClien2;
      sqlstm.sqhstl[4] = (unsigned long )21;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)&i_shNomApeClien2;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhTefCliente1;
      sqlstm.sqhstl[5] = (unsigned long )13;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)&i_shTefCliente1;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)szhTefCliente2;
      sqlstm.sqhstl[6] = (unsigned long )13;
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)&i_shTefCliente2;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)szhCodPais;
      sqlstm.sqhstl[7] = (unsigned long )4;
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)&i_shCodPais;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)szhIndDebito;
      sqlstm.sqhstl[8] = (unsigned long )2;
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)&i_shIndDebito;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&dhImpStopDebit;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)&i_shImpStopDebit;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)szhCodBanco;
      sqlstm.sqhstl[10] = (unsigned long )16;
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)&i_shCodBanco;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)szhCodSucursal;
      sqlstm.sqhstl[11] = (unsigned long )5;
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)&i_shCodSucursal;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)szhIndTipCuenta;
      sqlstm.sqhstl[12] = (unsigned long )2;
      sqlstm.sqhsts[12] = (         int  )0;
      sqlstm.sqindv[12] = (         short *)&i_shIndTipCuenta;
      sqlstm.sqinds[12] = (         int  )0;
      sqlstm.sqharm[12] = (unsigned long )0;
      sqlstm.sqadto[12] = (unsigned short )0;
      sqlstm.sqtdso[12] = (unsigned short )0;
      sqlstm.sqhstv[13] = (unsigned char  *)szhCodTipTarjeta;
      sqlstm.sqhstl[13] = (unsigned long )4;
      sqlstm.sqhsts[13] = (         int  )0;
      sqlstm.sqindv[13] = (         short *)&i_shCodTipTarjeta;
      sqlstm.sqinds[13] = (         int  )0;
      sqlstm.sqharm[13] = (unsigned long )0;
      sqlstm.sqadto[13] = (unsigned short )0;
      sqlstm.sqtdso[13] = (unsigned short )0;
      sqlstm.sqhstv[14] = (unsigned char  *)szhNumCtaCorr;
      sqlstm.sqhstl[14] = (unsigned long )19;
      sqlstm.sqhsts[14] = (         int  )0;
      sqlstm.sqindv[14] = (         short *)&i_shNumCtaCorr;
      sqlstm.sqinds[14] = (         int  )0;
      sqlstm.sqharm[14] = (unsigned long )0;
      sqlstm.sqadto[14] = (unsigned short )0;
      sqlstm.sqtdso[14] = (unsigned short )0;
      sqlstm.sqhstv[15] = (unsigned char  *)szhNumTarjeta;
      sqlstm.sqhstl[15] = (unsigned long )19;
      sqlstm.sqhsts[15] = (         int  )0;
      sqlstm.sqindv[15] = (         short *)&i_shNumTarjeta;
      sqlstm.sqinds[15] = (         int  )0;
      sqlstm.sqharm[15] = (unsigned long )0;
      sqlstm.sqadto[15] = (unsigned short )0;
      sqlstm.sqtdso[15] = (unsigned short )0;
      sqlstm.sqhstv[16] = (unsigned char  *)szhFecVenciTarj;
      sqlstm.sqhstl[16] = (unsigned long )15;
      sqlstm.sqhsts[16] = (         int  )0;
      sqlstm.sqindv[16] = (         short *)&i_shFecVenciTarj;
      sqlstm.sqinds[16] = (         int  )0;
      sqlstm.sqharm[16] = (unsigned long )0;
      sqlstm.sqadto[16] = (unsigned short )0;
      sqlstm.sqtdso[16] = (unsigned short )0;
      sqlstm.sqhstv[17] = (unsigned char  *)szhCodBancoTarj;
      sqlstm.sqhstl[17] = (unsigned long )16;
      sqlstm.sqhsts[17] = (         int  )0;
      sqlstm.sqindv[17] = (         short *)&i_shCodBancoTarj;
      sqlstm.sqinds[17] = (         int  )0;
      sqlstm.sqharm[17] = (unsigned long )0;
      sqlstm.sqadto[17] = (unsigned short )0;
      sqlstm.sqtdso[17] = (unsigned short )0;
      sqlstm.sqhstv[18] = (unsigned char  *)szhCodTipIdTrib;
      sqlstm.sqhstl[18] = (unsigned long )3;
      sqlstm.sqhsts[18] = (         int  )0;
      sqlstm.sqindv[18] = (         short *)&i_shCodTipIdTrib;
      sqlstm.sqinds[18] = (         int  )0;
      sqlstm.sqharm[18] = (unsigned long )0;
      sqlstm.sqadto[18] = (unsigned short )0;
      sqlstm.sqtdso[18] = (unsigned short )0;
      sqlstm.sqhstv[19] = (unsigned char  *)szhNumIdentTrib;
      sqlstm.sqhstl[19] = (unsigned long )21;
      sqlstm.sqhsts[19] = (         int  )0;
      sqlstm.sqindv[19] = (         short *)&i_shNumIdentTrib;
      sqlstm.sqinds[19] = (         int  )0;
      sqlstm.sqharm[19] = (unsigned long )0;
      sqlstm.sqadto[19] = (unsigned short )0;
      sqlstm.sqtdso[19] = (unsigned short )0;
      sqlstm.sqhstv[20] = (unsigned char  *)&ihCodActividad;
      sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[20] = (         int  )0;
      sqlstm.sqindv[20] = (         short *)&i_shCodActividad;
      sqlstm.sqinds[20] = (         int  )0;
      sqlstm.sqharm[20] = (unsigned long )0;
      sqlstm.sqadto[20] = (unsigned short )0;
      sqlstm.sqtdso[20] = (unsigned short )0;
      sqlstm.sqhstv[21] = (unsigned char  *)szhCodOficina;
      sqlstm.sqhstl[21] = (unsigned long )3;
      sqlstm.sqhsts[21] = (         int  )0;
      sqlstm.sqindv[21] = (         short *)&i_shCodOficina;
      sqlstm.sqinds[21] = (         int  )0;
      sqlstm.sqharm[21] = (unsigned long )0;
      sqlstm.sqadto[21] = (unsigned short )0;
      sqlstm.sqtdso[21] = (unsigned short )0;
      sqlstm.sqhstv[22] = (unsigned char  *)&ihIndFactur;
      sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[22] = (         int  )0;
      sqlstm.sqindv[22] = (         short *)0;
      sqlstm.sqinds[22] = (         int  )0;
      sqlstm.sqharm[22] = (unsigned long )0;
      sqlstm.sqadto[22] = (unsigned short )0;
      sqlstm.sqtdso[22] = (unsigned short )0;
      sqlstm.sqhstv[23] = (unsigned char  *)szhNumFax;
      sqlstm.sqhstl[23] = (unsigned long )16;
      sqlstm.sqhsts[23] = (         int  )0;
      sqlstm.sqindv[23] = (         short *)&i_shNumFax;
      sqlstm.sqinds[23] = (         int  )0;
      sqlstm.sqharm[23] = (unsigned long )0;
      sqlstm.sqadto[23] = (unsigned short )0;
      sqlstm.sqtdso[23] = (unsigned short )0;
      sqlstm.sqhstv[24] = (unsigned char  *)szhFecAlta;
      sqlstm.sqhstl[24] = (unsigned long )15;
      sqlstm.sqhsts[24] = (         int  )0;
      sqlstm.sqindv[24] = (         short *)0;
      sqlstm.sqinds[24] = (         int  )0;
      sqlstm.sqharm[24] = (unsigned long )0;
      sqlstm.sqadto[24] = (unsigned short )0;
      sqlstm.sqtdso[24] = (unsigned short )0;
      sqlstm.sqhstv[25] = (unsigned char  *)&lhCodCuenta;
      sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[25] = (         int  )0;
      sqlstm.sqindv[25] = (         short *)0;
      sqlstm.sqinds[25] = (         int  )0;
      sqlstm.sqharm[25] = (unsigned long )0;
      sqlstm.sqadto[25] = (unsigned short )0;
      sqlstm.sqtdso[25] = (unsigned short )0;
      sqlstm.sqhstv[26] = (unsigned char  *)szhCodIdioma;
      sqlstm.sqhstl[26] = (unsigned long )6;
      sqlstm.sqhsts[26] = (         int  )0;
      sqlstm.sqindv[26] = (         short *)0;
      sqlstm.sqinds[26] = (         int  )0;
      sqlstm.sqharm[26] = (unsigned long )0;
      sqlstm.sqadto[26] = (unsigned short )0;
      sqlstm.sqtdso[26] = (unsigned short )0;
      sqlstm.sqhstv[27] = (unsigned char  *)szhCodOperadora;
      sqlstm.sqhstl[27] = (unsigned long )6;
      sqlstm.sqhsts[27] = (         int  )0;
      sqlstm.sqindv[27] = (         short *)&i_shCodOperadora;
      sqlstm.sqinds[27] = (         int  )0;
      sqlstm.sqharm[27] = (unsigned long )0;
      sqlstm.sqadto[27] = (unsigned short )0;
      sqlstm.sqtdso[27] = (unsigned short )0;
      sqlstm.sqhstv[28] = (unsigned char  *)szhCodDespacho;
      sqlstm.sqhstl[28] = (unsigned long )6;
      sqlstm.sqhsts[28] = (         int  )0;
      sqlstm.sqindv[28] = (         short *)&i_shCodDespacho;
      sqlstm.sqinds[28] = (         int  )0;
      sqlstm.sqharm[28] = (unsigned long )0;
      sqlstm.sqadto[28] = (unsigned short )0;
      sqlstm.sqtdso[28] = (unsigned short )0;
      sqlstm.sqhstv[29] = (unsigned char  *)szhNomEmail;
      sqlstm.sqhstl[29] = (unsigned long )71;
      sqlstm.sqhsts[29] = (         int  )0;
      sqlstm.sqindv[29] = (         short *)&i_shNomEmail;
      sqlstm.sqinds[29] = (         int  )0;
      sqlstm.sqharm[29] = (unsigned long )0;
      sqlstm.sqadto[29] = (unsigned short )0;
      sqlstm.sqtdso[29] = (unsigned short )0;
      sqlstm.sqhstv[30] = (unsigned char  *)szhCodIdTipDian;
      sqlstm.sqhstl[30] = (unsigned long )3;
      sqlstm.sqhsts[30] = (         int  )0;
      sqlstm.sqindv[30] = (         short *)0;
      sqlstm.sqinds[30] = (         int  )0;
      sqlstm.sqharm[30] = (unsigned long )0;
      sqlstm.sqadto[30] = (unsigned short )0;
      sqlstm.sqtdso[30] = (unsigned short )0;
      sqlstm.sqhstv[31] = (unsigned char  *)&ihIndClieLoc;
      sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[31] = (         int  )0;
      sqlstm.sqindv[31] = (         short *)0;
      sqlstm.sqinds[31] = (         int  )0;
      sqlstm.sqharm[31] = (unsigned long )0;
      sqlstm.sqadto[31] = (unsigned short )0;
      sqlstm.sqtdso[31] = (unsigned short )0;
      sqlstm.sqhstv[32] = (unsigned char  *)szhCodSegmentacion;
      sqlstm.sqhstl[32] = (unsigned long )6;
      sqlstm.sqhsts[32] = (         int  )0;
      sqlstm.sqindv[32] = (         short *)0;
      sqlstm.sqinds[32] = (         int  )0;
      sqlstm.sqharm[32] = (unsigned long )0;
      sqlstm.sqadto[32] = (unsigned short )0;
      sqlstm.sqtdso[32] = (unsigned short )0;
      sqlstm.sqhstv[33] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[33] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[33] = (         int  )0;
      sqlstm.sqindv[33] = (         short *)0;
      sqlstm.sqinds[33] = (         int  )0;
      sqlstm.sqharm[33] = (unsigned long )0;
      sqlstm.sqadto[33] = (unsigned short )0;
      sqlstm.sqtdso[33] = (unsigned short )0;
      sqlstm.sqhstv[34] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[34] = (unsigned long )15;
      sqlstm.sqhsts[34] = (         int  )0;
      sqlstm.sqindv[34] = (         short *)0;
      sqlstm.sqinds[34] = (         int  )0;
      sqlstm.sqharm[34] = (unsigned long )0;
      sqlstm.sqadto[34] = (unsigned short )0;
      sqlstm.sqtdso[34] = (unsigned short )0;
      sqlstm.sqhstv[35] = (unsigned char  *)szhFmtFecha;
      sqlstm.sqhstl[35] = (unsigned long )17;
      sqlstm.sqhsts[35] = (         int  )0;
      sqlstm.sqindv[35] = (         short *)0;
      sqlstm.sqinds[35] = (         int  )0;
      sqlstm.sqharm[35] = (unsigned long )0;
      sqlstm.sqadto[35] = (unsigned short )0;
      sqlstm.sqtdso[35] = (unsigned short )0;
      sqlstm.sqhstv[36] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[36] = (unsigned long )15;
      sqlstm.sqhsts[36] = (         int  )0;
      sqlstm.sqindv[36] = (         short *)0;
      sqlstm.sqinds[36] = (         int  )0;
      sqlstm.sqharm[36] = (unsigned long )0;
      sqlstm.sqadto[36] = (unsigned short )0;
      sqlstm.sqtdso[36] = (unsigned short )0;
      sqlstm.sqhstv[37] = (unsigned char  *)szhFmtFecha;
      sqlstm.sqhstl[37] = (unsigned long )17;
      sqlstm.sqhsts[37] = (         int  )0;
      sqlstm.sqindv[37] = (         short *)0;
      sqlstm.sqinds[37] = (         int  )0;
      sqlstm.sqharm[37] = (unsigned long )0;
      sqlstm.sqadto[37] = (unsigned short )0;
      sqlstm.sqtdso[37] = (unsigned short )0;
      sqlstm.sqhstv[38] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[38] = (unsigned long )15;
      sqlstm.sqhsts[38] = (         int  )0;
      sqlstm.sqindv[38] = (         short *)0;
      sqlstm.sqinds[38] = (         int  )0;
      sqlstm.sqharm[38] = (unsigned long )0;
      sqlstm.sqadto[38] = (unsigned short )0;
      sqlstm.sqtdso[38] = (unsigned short )0;
      sqlstm.sqhstv[39] = (unsigned char  *)szhFmtFecha;
      sqlstm.sqhstl[39] = (unsigned long )17;
      sqlstm.sqhsts[39] = (         int  )0;
      sqlstm.sqindv[39] = (         short *)0;
      sqlstm.sqinds[39] = (         int  )0;
      sqlstm.sqharm[39] = (unsigned long )0;
      sqlstm.sqadto[39] = (unsigned short )0;
      sqlstm.sqtdso[39] = (unsigned short )0;
      sqlstm.sqhstv[40] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[40] = (unsigned long )15;
      sqlstm.sqhsts[40] = (         int  )0;
      sqlstm.sqindv[40] = (         short *)0;
      sqlstm.sqinds[40] = (         int  )0;
      sqlstm.sqharm[40] = (unsigned long )0;
      sqlstm.sqadto[40] = (unsigned short )0;
      sqlstm.sqtdso[40] = (unsigned short )0;
      sqlstm.sqhstv[41] = (unsigned char  *)szhFmtFecha;
      sqlstm.sqhstl[41] = (unsigned long )17;
      sqlstm.sqhsts[41] = (         int  )0;
      sqlstm.sqindv[41] = (         short *)0;
      sqlstm.sqinds[41] = (         int  )0;
      sqlstm.sqharm[41] = (unsigned long )0;
      sqlstm.sqadto[41] = (unsigned short )0;
      sqlstm.sqtdso[41] = (unsigned short )0;
      sqlstm.sqhstv[42] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[42] = (unsigned long )15;
      sqlstm.sqhsts[42] = (         int  )0;
      sqlstm.sqindv[42] = (         short *)0;
      sqlstm.sqinds[42] = (         int  )0;
      sqlstm.sqharm[42] = (unsigned long )0;
      sqlstm.sqadto[42] = (unsigned short )0;
      sqlstm.sqtdso[42] = (unsigned short )0;
      sqlstm.sqhstv[43] = (unsigned char  *)szhFmtFecha;
      sqlstm.sqhstl[43] = (unsigned long )17;
      sqlstm.sqhsts[43] = (         int  )0;
      sqlstm.sqindv[43] = (         short *)0;
      sqlstm.sqinds[43] = (         int  )0;
      sqlstm.sqharm[43] = (unsigned long )0;
      sqlstm.sqadto[43] = (unsigned short )0;
      sqlstm.sqtdso[43] = (unsigned short )0;
      sqlstm.sqhstv[44] = (unsigned char  *)szhFecEmision;
      sqlstm.sqhstl[44] = (unsigned long )15;
      sqlstm.sqhsts[44] = (         int  )0;
      sqlstm.sqindv[44] = (         short *)0;
      sqlstm.sqinds[44] = (         int  )0;
      sqlstm.sqharm[44] = (unsigned long )0;
      sqlstm.sqadto[44] = (unsigned short )0;
      sqlstm.sqtdso[44] = (unsigned short )0;
      sqlstm.sqhstv[45] = (unsigned char  *)szhFmtFecha;
      sqlstm.sqhstl[45] = (unsigned long )17;
      sqlstm.sqhsts[45] = (         int  )0;
      sqlstm.sqindv[45] = (         short *)0;
      sqlstm.sqinds[45] = (         int  )0;
      sqlstm.sqharm[45] = (unsigned long )0;
      sqlstm.sqadto[45] = (unsigned short )0;
      sqlstm.sqtdso[45] = (unsigned short )0;
      sqlstm.sqhstv[46] = (unsigned char  *)&lhCodCliente;
      sqlstm.sqhstl[46] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[46] = (         int  )0;
      sqlstm.sqindv[46] = (         short *)0;
      sqlstm.sqinds[46] = (         int  )0;
      sqlstm.sqharm[46] = (unsigned long )0;
      sqlstm.sqadto[46] = (unsigned short )0;
      sqlstm.sqtdso[46] = (unsigned short )0;
      sqlstm.sqphsv = sqlstm.sqhstv;
      sqlstm.sqphsl = sqlstm.sqhstl;
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

    if ( SQLCODE )
    {
         iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ge_Clientes",szfnORAerror());
         return FALSE;
    }
    
    if ( SQLCODE == SQLOK )
    {
         strcpy (stCliente.szCodIdioma, szhCodIdioma);
         strcpy (stCliente.szNomCliente,szhNomCliente);

         if (i_shNomApeClien1 == ORA_NULL)
             stCliente.szNomApeClien1 [0] = 0;
         else
             strcpy (stCliente.szNomApeClien1,szhNomApeClien1);
         if (i_shNomApeClien2 == ORA_NULL)
             stCliente.szNomApeClien2 [0] = 0;
         else
             strcpy (stCliente.szNomApeClien2,szhNomApeClien2);
         if (i_shTefCliente1 == ORA_NULL)
             stCliente.szTefCliente1 [0] = 0;
         else
             strcpy (stCliente.szTefCliente1,szhTefCliente1);
         if (i_shTefCliente2 == ORA_NULL)
             stCliente.szTefCliente1 [0] = 0;
         else
             strcpy (stCliente.szTefCliente1,szhTefCliente2);

         if (i_shCodPais == ORA_NULL)
             stCliente.szCodPais [0] = 0;
         else
             strcpy (stCliente.szCodPais,szhCodPais);

         if (i_shIndDebito == ORA_NULL)
             stCliente.szIndDebito [0] = 0;
         else
             strcpy (stCliente.szIndDebito,szhIndDebito);

         stCliente.dImpStopDebit = (i_shImpStopDebit== ORA_NULL)?0.0:dhImpStopDebit;
         if (i_shCodBanco == ORA_NULL)
             stCliente.szCodBanco [0] = 0;
         else
             strcpy (stCliente.szCodBanco,szhCodBanco);
            
         if (i_shCodSucursal == ORA_NULL)
             stCliente.szCodSucursal [0] = 0;
         else
             strcpy (stCliente.szCodSucursal,szhCodSucursal);

         if (i_shIndTipCuenta == ORA_NULL)
             stCliente.szIndTipCuenta [0] = 0;
         else
             strcpy (stCliente.szIndTipCuenta,szhIndTipCuenta);

         if (i_shCodTipTarjeta == ORA_NULL)
             stCliente.szCodTipTarjeta [0] = 0;
         else
             strcpy (stCliente.szCodTipTarjeta,szhCodTipTarjeta);

         if (i_shNumCtaCorr == ORA_NULL)
             stCliente.szNumCtaCorr [0] = 0;
         else
             strcpy (stCliente.szNumCtaCorr,szhNumCtaCorr);

         if (i_shNumTarjeta == ORA_NULL)
             stCliente.szNumTarjeta [0] = 0;
         else
             strcpy (stCliente.szNumTarjeta,szhNumTarjeta);

         if (i_shFecVenciTarj == ORA_NULL)
             stCliente.szFecVenciTarj [0] = 0;
         else
             strcpy (stCliente.szFecVenciTarj,szhFecVenciTarj);

         if (i_shCodBancoTarj == ORA_NULL)
             stCliente.szCodBancoTarj [0] = 0;
         else
             strcpy (stCliente.szCodBancoTarj,szhCodBancoTarj);

         if (i_shCodTipIdTrib == ORA_NULL)
             stCliente.szCodTipIdTrib [0] = 0;
         else
             strcpy (stCliente.szCodTipIdTrib,szhCodTipIdTrib);

         if (i_shNumIdentTrib == ORA_NULL)
             stCliente.szNumIdentTrib [0] = 0;
         else
             strcpy (stCliente.szNumIdentTrib,szhNumIdentTrib);

         stCliente.iCodActividad = (i_shCodActividad == ORA_NULL)?ORA_NULL:
                                 ihCodActividad;

         if (i_shCodOficina == ORA_NULL)
             stCliente.szCodOficina [0] = 0;
         else
             strcpy (stCliente.szCodOficina,szhCodOficina);

         if (i_shNumFax == ORA_NULL)
             stCliente.szNumFax [0] = 0;
         else
             strcpy (stCliente.szNumFax,szhNumFax);

         strcpy (stCliente.szFecAlta, szhFecAlta);
         stCliente.iIndFactur = ihIndFactur;
         stCliente.lCodCuenta = lhCodCuenta;

         if (i_shCodOperadora == ORA_NULL)
             stCliente.szCodOperadora [0] = 0;
         else
             strcpy (stCliente.szCodOperadora,szhCodOperadora);
          
         if (i_shCodDespacho == ORA_NULL)
             stCliente.szCodDespacho [0] = 0;
         else
             strcpy (stCliente.szCodDespacho,szhCodDespacho);
          
         if (i_shNomEmail == ORA_NULL)
             stCliente.szNomEmail [0] = 0;
         else
             strcpy (stCliente.szNomEmail,szhNomEmail);
      
         strcpy (stCliente.szCodIdTipDian, szhCodIdTipDian);
         
         stCliente.iIndClieLoc = ihIndClieLoc;         

         strcpy (stCliente.szCodSegmentacion, szhCodSegmentacion);               
   }
   return TRUE;
}/************************* Final bfnGetDatosCliente *************************/

/*****************************************************************************/
/*                            funcion bGetDirecCli                           */
/* -Funcion que recupera la Direccion de un Cliente                          */
/* -Valores Entrada : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bfnGetDirecCli (long lCodCliente, int iTipDireccion)
{
  COMUNAS  stComuna;
  CIUDADES stCiudad;
/* COL00000 VERIFICAR SI SE USA DIRECCION CON GLOSA O NO...*/
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhCodCliente     ;
  static char* szhCodRegion     ; /* EXEC SQL VAR szhCodRegion     IS STRING(4) ; */ 

  static char* szhCodProvincia  ; /* EXEC SQL VAR szhCodProvincia  IS STRING(6) ; */ 

  static char* szhCodCiudad     ; /* EXEC SQL VAR szhCodCiudad     IS STRING(6) ; */ 

  static char* szhCodComuna     ; /* EXEC SQL VAR szhCodComuna     IS STRING(6) ; */ 

  static char* szhNomCalle      ; /* EXEC SQL VAR szhNomCalle      IS STRING(51); */ 

  static char* szhNumCalle      ; /* EXEC SQL VAR szhNumCalle      IS STRING(11); */ 

  static char* szhNumPiso       ; /* EXEC SQL VAR szhNumPiso       IS STRING(11); */ 

  static short ihCodTipDireccion;
  static short i_shNomCalle     ;
  static short i_shNumPiso      ;
  static short i_shNumCalle     ;

  /* EXEC SQL END DECLARE SECTION  ; */ 


  lhCodCliente  = lCodCliente   ;

  if (iTipDireccion == TIPDIRECCION_FACTURA)
  {
      ihCodTipDireccion = TIPDIRECCION_FACTURA    ;
      szhCodRegion      = stCliente.szCodRegion   ;
      szhCodProvincia   = stCliente.szCodProvincia;
      szhCodCiudad      = stCliente.szCodCiudad   ;
      szhCodComuna      = stCliente.szCodComuna   ;
      szhNomCalle       = stCliente.szNomCalle    ;
      szhNumCalle       = stCliente.szNumCalle    ;
      szhNumPiso        = stCliente.szNumPiso     ;

      strcpy(stCliente.szGls_DirecClie," ");
  }
  else
  {
      memset (&stComuna, 0, sizeof (COMUNAS) );
      memset (&stCiudad, 0, sizeof (CIUDADES));

      ihCodTipDireccion = iTIP_CORRESPONDENCIA   ;
      szhCodRegion      = stCorreo.szCodRegion   ;
      szhCodProvincia   = stCorreo.szCodProvincia;
      szhCodCiudad      = stCorreo.szCodCiudad   ;
      szhCodComuna      = stCorreo.szCodComuna   ;
      szhNomCalle       = stCorreo.szNomCalle    ;
      szhNumCalle       = stCorreo.szNumCalle    ;
      szhNumPiso        = stCorreo.szNumPiso     ;

      strcpy(stCorreo.szGls_DirecClie," ");

  }


  vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ga_DirecCli\n"
                         "\t\t=> Cod.Cliente  [%ld]\n",LOG05,lCodCliente);

  /* EXEC SQL SELECT /o+ index (GA_DIRECCLI PK_GA_DIRECCLI) o/
                  A.COD_REGION   ,
                  A.COD_PROVINCIA,
                  A.COD_CIUDAD   ,
                  A.COD_COMUNA   ,
                  A.NOM_CALLE    ,
                  A.NUM_CALLE    ,
                  A.NUM_PISO
           INTO   :szhCodRegion             ,
                  :szhCodProvincia          ,
                  :szhCodCiudad             ,
                  :szhCodComuna             ,
                  :szhNomCalle :i_shNomCalle,
                  :szhNumCalle :i_shNumCalle,
                  :szhNumPiso  :i_shNumPiso
           FROM   GE_DIRECCIONES A, GA_DIRECCLI B
           WHERE  B.COD_CLIENTE      = :lhCodCliente
             AND  B.COD_TIPDIRECCION = :ihCodTipDireccion
             AND  B.COD_DIRECCION    = A.COD_DIRECCION; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 48;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (GA_DIRECCLI PK_GA_DIRECCLI)  +*/ A.COD_\
REGION ,A.COD_PROVINCIA ,A.COD_CIUDAD ,A.COD_COMUNA ,A.NOM_CALLE ,A.NUM_CALLE \
,A.NUM_PISO into :b0,:b1,:b2,:b3,:b4:b5,:b6:b7,:b8:b9  from GE_DIRECCIONES A ,\
GA_DIRECCLI B where ((B.COD_CLIENTE=:b10 and B.COD_TIPDIRECCION=:b11) and B.CO\
D_DIRECCION=A.COD_DIRECCION)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )2905;
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
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodComuna;
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhNomCalle;
  sqlstm.sqhstl[4] = (unsigned long )51;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)&i_shNomCalle;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhNumCalle;
  sqlstm.sqhstl[5] = (unsigned long )11;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)&i_shNumCalle;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhNumPiso;
  sqlstm.sqhstl[6] = (unsigned long )11;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)&i_shNumPiso;
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
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodTipDireccion;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
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
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_DirecCli\n\t",
               szfnORAerror());
  if (SQLCODE == SQLOK)
  {
      if (TIPDIRECCION_FACTURA == ihCodTipDireccion)
      {
          if (i_shNumPiso == ORA_NULL)
              stCliente.szNumPiso [0] = 0;
          if (i_shNumCalle== ORA_NULL)
              stCliente.szNumCalle[0] = 0;
          if (i_shNomCalle== ORA_NULL)
              stCliente.szNomCalle[0] = 0;
      }
      vDTrazasLog (szExeName,"\n\t\t * Direccion del Cliente [%ld]\n"
                             "\t\t=> Cod.Region       [%s]\n"
                             "\t\t=> Cod.Provincia    [%s]\n"
                             "\t\t=> Cod.Ciudad       [%s]\n",LOG05,
                   stCliente.lCodCliente   ,stCliente.szCodRegion,
                   stCliente.szCodProvincia,stCliente.szCodCiudad);

      if (ihCodTipDireccion == iTIP_CORRESPONDENCIA)
      {
          strcpy (stComuna.szCodRegion   ,stCorreo.szCodRegion)   ;
          strcpy (stComuna.szCodProvincia,stCorreo.szCodProvincia);
          strcpy (stComuna.szCodComuna   ,stCorreo.szCodComuna)   ;

          if (i_shNumCalle == -1)
              stCorreo.szNumCalle [0] = 0;
          if (i_shNumPiso  == -1)
              stCorreo.szNumPiso  [0] = 0;
          if (i_shNumPiso  == -1)
              stCorreo.szNomCalle [0] = 0;

          if (!bfnFindComuna (&stComuna,stProceso.iCodTipDocum))
               return FALSE;

          strcpy (stCorreo.szDesComuna,stComuna.szDesComuna);

          strcpy (stCiudad.szCodRegion   ,stCorreo.szCodRegion)   ;
          strcpy (stCiudad.szCodProvincia,stCorreo.szCodProvincia);
          strcpy (stCiudad.szCodCiudad   ,stCorreo.szCodCiudad)   ;

          if (!bfnFindCiudad (&stCiudad,stProceso.iCodTipDocum))
               return FALSE;

          strcpy (stCorreo.szDesCiudad,stCiudad.szDesCiudad);

      }
  }
  return (SQLCODE != SQLOK)?FALSE:TRUE;

}/************************* Final bGetDirecCli *******************************/


/* -------------------------------------------------------------------------- */
/*   vInitEstructuras (void)                                                  */
/* -------------------------------------------------------------------------- */
void vInitEstructuras (void)
{
   stCliente.pAbonados    = (ABONTAR*)NULL   ;
   stCliente.iNumAbonados = 0;
   stCliente.pPenaliza    = (PENALIZA*)NULL  ;
   stCliente.iNumPenaliza = 0;
   stCliente.pServAbo     = (SERVABO*)NULL   ;
   stCliente.iNumServAbo  = 0;
   stCliente.pAbonos      = (ABONOS*)NULL    ;
   stCliente.iNumAbonos   = 0;
   stCliente.pCargos      = (CARGOS*)NULL    ;
   stCliente.iNumCargos   = 0;
   stCliente.pCabCuotas   = (CABCUOTAS *)NULL;
   stCliente.iNumCabCuotas= 0;
   stCliente.pAboRent     = (ABORENT *)NULL  ;
   stCliente.pAboRoaVis   = (ABOROAVIS *)NULL;
}/****************************** vInitEstructuras ****************************/

/* -------------------------------------------------------------------------- */
/*   vPreparacionSenales (void)                                               */
/* -------------------------------------------------------------------------- */
void vPreparacionSenales (void)
{
   /* Ignora la terminacion del proceso por liberacion de terminal */
   if(signal(SIGHUP,SIG_IGN)==SIG_ERR)
   {
      fprintf(stderr,"signal SIGUP SIG_IGN");
      exit(-1);
   }
   /* Procesa la senal de fin de maquina activa y pre shutdown     */
   if(signal(SIGTERM,SIG_IGN)==SIG_ERR)
   {
      fprintf(stderr,"signal SIGTERM SIG_IGN");
      exit(-1);
   }
}/************************* Final vPreparacionSenales   **********************/

/* -------------------------------------------------------------------------- */
/*   vfDatosInicialesTiempo (void)                                             */
/* -------------------------------------------------------------------------- */
void vDatosInicialesTiempo (void)
{
   cpu_ini=clock(); /* Tiempo inicial de cpu */
   time(&real_ini); /* Tiempo inicial real   */
}

/* ------------------------------------------------------------------------- */
/*   vDatosFinTiempo (void)                                                  */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
void vDatosFinTiempo (void)
{
   times(&tms)    ;
   cpu_fin=clock();
   time(&real_fin);

   real=(real_fin-real_ini)                 ;
   cpu =(float)cpu_fin/(float)CLOCKS_PER_SEC;

}/**************************** Final vDatosFinTiempo *************************/

/*****************************************************************************/
/*                            funcion : bfnCargaAbonoCli                     */
/* -Funcion que Carga en la estructura stAbonoCli los Abonados a Facturar ,  */
/*  esta funcion se utiliza en Notas y Contado sin hacer acceso a la Tabla   */
/*  Fa_CicloCli.                                                             */
/*****************************************************************************/
BOOL bfnCargaAbonoCli (ENLACEHIST stEnlaceHist, BOOL bOptProc)
{
   int  i = 0;
   long j = 0;
	
   vDTrazasLog (szExeName,"\n\t\t* Entra a bfnCargaAbonoCli",LOG03);
	
   for (i=0;i<stPreFactura.iNumRegistros;i++)
   {
        if((!bfnEncAbonadoCicloCli (stPreFactura.A_PFactura[i].lNumAbonado ))&&
              stPreFactura.A_PFactura[i].lNumAbonado  > 0 )
        {
            if ((stAbonoCli.pCicloCli =
                (CICLOCLI *)realloc ( (CICLOCLI *)stAbonoCli.pCicloCli,
                sizeof (CICLOCLI) * (stAbonoCli.lNumAbonados+1) ))
                == (CICLOCLI *)NULL)
            {
                iDError (szExeName,ERR005,vInsertarIncidencia,
                         "stAbonoCli.pCicloCli");
                return FALSE;
            }

            j = stAbonoCli.lNumAbonados;
            memset (&stAbonoCli.pCicloCli [j],0,sizeof(CICLOCLI));

            stAbonoCli.pCicloCli [j].lCodCliente = stCliente.lCodCliente;
            stAbonoCli.pCicloCli [j].lNumAbonado =
                                 stPreFactura.A_PFactura[i].lNumAbonado ;
            stAbonoCli.pCicloCli [j].iCodProducto=
                                 stPreFactura.A_PFactura[i].iCodProducto;
            strcpy (stAbonoCli.pCicloCli [j].szNumTerminal,
                    stPreFactura.A_PFactura[i].szNumTerminal);

            stAbonoCli.pCicloCli [j].iIndDetalle = 0;
            if (!bfnTotCargosMe (stAbonoCli.pCicloCli [j].lCodCliente,
                                 stAbonoCli.pCicloCli [j].lNumAbonado,
                                 &stAbonoCli.pCicloCli[j].dTotCargosMe))
                 return FALSE;
            if (stAbonoCli.pCicloCli[j].iCodProducto !=
                stDatosGener.iProdGeneral)
            {
                if (!bfnGetDatosAbo(&stAbonoCli.pCicloCli[j], stEnlaceHist, bOptProc))
                     return FALSE;
            }
            
            stAbonoCli.pCicloCli [j].iIndCobroDetLlam=0;
            
            stAbonoCli.lNumAbonados++;
        }
   }/* fin for i ... */
   return TRUE;
}/*************************** Final bfnCargaAbonoCli *************************/

/*****************************************************************************/
/*                          funcion : bfnEncAbonadoCicloCli                  */
/*****************************************************************************/
BOOL bfnEncAbonadoCicloCli (long lNumAbonado)
{
  static long j = 0;

  for (j=0;j<stAbonoCli.lNumAbonados;j++)
  {
       if (stAbonoCli.pCicloCli [j].lNumAbonado == lNumAbonado)
           return TRUE;
  }
  return FALSE;
}/*************************** Final bfnEncAbonadoCicloCli ********************/

/*****************************************************************************/
/*                          funcion : bfnTotCargosMe                         */
/*****************************************************************************/
BOOL bfnTotCargosMe (long    lCodCliente,
                     long    lNumAbonado,
                     double *dTotCargosMe)
{
  int i = 0;
  double dImporte = 0.0;

  for (i=0;i<stPreFactura.iNumRegistros;i++)
  {
       if (stPreFactura.A_PFactura[i].lCodCliente  == lCodCliente &&
           stPreFactura.A_PFactura[i].lNumAbonado  == lNumAbonado)
       {
           dImporte = stPreFactura.A_PFactura[i].dImpConcepto;

           if (!bConverMoneda (stPreFactura.A_PFactura[i].szCodMoneda ,
                               stDatosGener.szCodMoneFact             ,
                               stPreFactura.A_PFactura[i].szFecValor  ,
                               &dImporte,stProceso.iCodTipDocum))
                 return FALSE;
           *dTotCargosMe += dImporte;
       }
  }
  return TRUE;
}/************************* Final bfnTotCargosMe *****************************/

/*****************************************************************************/
/*                          funcion : bfnGetDatosAbo                         */
/*****************************************************************************/
BOOL bfnGetDatosAbo (CICLOCLI *pCicloCli, ENLACEHIST stEnlace, BOOL bOpt)
{
   static char szFuncion [25] = "";
   static char szNomTabla[30] = "";

   char *pszAux;

   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   long  lhNumAbonado;
   long  lhIndOrdenTotal;
   static long  lhCodUsuario       ;
   char  szhNomUsuario  [21];/* EXEC SQL VAR szhNomUsuario   IS STRING(21); */ 

   char  szhNomApellido1[21];/* EXEC SQL VAR szhNomApellido1 IS STRING(21); */ 

   char  szhNomApellido2[21];/* EXEC SQL VAR szhNomApellido2 IS STRING(21); */ 

   short i_shNomUsuario   ;
   short i_shNomApellido1   ;
   short i_shNomApellido2   ;
   static char  szhFecFinContra[15];/* EXEC SQL VAR szhFecFinContra IS STRING(15); */ 

   static short shIndFactur        ;
   static int   ihCodCredMor       ;
   static short shIndSuperTel      ;
   static char  szhNumTeleFija [16];/* EXEC SQL VAR szhNumTeleFija  IS STRING(16); */ 

   static long  lhCapCode          ;
   short i_shIndFactur   ;
   static short i_shCodCredMor     ;
   short i_shIndSuperTel = ORA_NULL   ;
   static short i_shNumTeleFija = ORA_NULL   ;
   static short i_shFecFinContra   ;
   static short i_shCapCode        ;
   /* VARCHAR sqlstmt[512]; */ 
struct { unsigned short len; unsigned char arr[512]; } sqlstmt;

   static char  szhFmtFecha [17];/* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


    pszAux = (char *)sqlstmt.arr;
    lhIndOrdenTotal = atol(stNota.szIndOrdenTotal);
    lhNumAbonado = pCicloCli->lNumAbonado;

    vDTrazasLog(szExeName,"\n\t\t* Entrada a funcion bfnGetDatosAbo"
                          "\n\t\t=> Num_Abonado:    [%d]", LOG03, lhNumAbonado);

    sprintf(szhFmtFecha, "YYYYMMDDHH24MISS");
    if(stDatosGener.iProdCelular == pCicloCli->iCodProducto)
    {
        strcpy (szFuncion,"Select=>Ga_AboCel");
        /* EXEC SQL SELECT COD_USUARIO, TO_CHAR(FEC_FINCONTRA,:szhFmtFecha),
                         IND_FACTUR, COD_CREDMOR, IND_SUPERTEL, NUM_TELEFIJA
                   INTO  :lhCodUsuario                    ,
                         :szhFecFinContra:i_shFecFinContra,
                         :shIndFactur:i_shIndFactur       ,
                         :ihCodCredMor:i_shCodCredMor     ,
                         :shIndSuperTel:i_shIndSuperTel   ,
                         :szhNumTeleFija:i_shNumTeleFija
                   FROM  GA_ABOCEL
                  WHERE  NUM_ABONADO = :lhNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_USUARIO ,TO_CHAR(FEC_FINCONTRA,:b0) ,IND_F\
ACTUR ,COD_CREDMOR ,IND_SUPERTEL ,NUM_TELEFIJA into :b1,:b2:b3,:b4:b5,:b6:b7,:\
b8:b9,:b10:b11  from GA_ABOCEL where NUM_ABONADO=:b12";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )2956;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
        sqlstm.sqhstl[0] = (unsigned long )17;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodUsuario;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecFinContra;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)&i_shFecFinContra;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&shIndFactur;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)&i_shIndFactur;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCredMor;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)&i_shCodCredMor;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&shIndSuperTel;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)&i_shIndSuperTel;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhNumTeleFija;
        sqlstm.sqhstl[6] = (unsigned long )16;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)&i_shNumTeleFija;
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
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if(SQLCODE)
        {
            strcpy (szFuncion,"Select=>Ga_HaboCel");
            /* EXEC SQL SELECT COD_USUARIO, TO_CHAR(FEC_FINCONTRA,:szhFmtFecha),
                            IND_FACTUR, COD_CREDMOR, IND_SUPERTEL, NUM_TELEFIJA
                    INTO    :lhCodUsuario                    ,
                            :szhFecFinContra:i_shFecFinContra,
                            :shIndFactur:i_shIndFactur       ,
                            :ihCodCredMor:i_shCodCredMor     ,
                            :shIndSuperTel:i_shIndSuperTel   ,
                            :szhNumTeleFija:i_shNumTeleFija
                    FROM    GA_HABOCEL
                    WHERE   NUM_ABONADO = :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 48;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select COD_USUARIO ,TO_CHAR(FEC_FINCONTRA,:b0) ,I\
ND_FACTUR ,COD_CREDMOR ,IND_SUPERTEL ,NUM_TELEFIJA into :b1,:b2:b3,:b4:b5,:b6:\
b7,:b8:b9,:b10:b11  from GA_HABOCEL where NUM_ABONADO=:b12";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3003;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
            sqlstm.sqhstl[0] = (unsigned long )17;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodUsuario;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhFecFinContra;
            sqlstm.sqhstl[2] = (unsigned long )15;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)&i_shFecFinContra;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&shIndFactur;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)&i_shIndFactur;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCredMor;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)&i_shCodCredMor;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&shIndSuperTel;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)&i_shIndSuperTel;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhNumTeleFija;
            sqlstm.sqhstl[6] = (unsigned long )16;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)&i_shNumTeleFija;
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
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
            sqlstm.sqphss = sqlstm.sqhsts;
            sqlstm.sqpind = sqlstm.sqindv;
            sqlstm.sqpins = sqlstm.sqinds;
            sqlstm.sqparm = sqlstm.sqharm;
            sqlstm.sqparc = sqlstm.sqharc;
            sqlstm.sqpadto = sqlstm.sqadto;
            sqlstm.sqptdso = sqlstm.sqtdso;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            if(SQLCODE)
            {
                strcpy (szFuncion,"Select=>Ga_AboAmist");
                /* EXEC SQL SELECT 0   ,
                                NULL,
                                1   ,
                                NULL,
                                NULL,
                                NULL
                    INTO        :lhCodUsuario                    ,
                                :szhFecFinContra:i_shFecFinContra,
                                :shIndFactur:i_shIndFactur       ,
                                :ihCodCredMor:i_shCodCredMor     ,
                                :shIndSuperTel:i_shIndSuperTel   ,
                                :szhNumTeleFija:i_shNumTeleFija
                    FROM   GA_ABOAMIST
                    WHERE  NUM_ABONADO = :lhNumAbonado; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 48;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select 0 ,null  ,1 ,null  ,null  ,null  into \
:b0,:b1:b2,:b3:b4,:b5:b6,:b7:b8,:b9:b10  from GA_ABOAMIST where NUM_ABONADO=:b\
11";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )3050;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhCodUsuario;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szhFecFinContra;
                sqlstm.sqhstl[1] = (unsigned long )15;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)&i_shFecFinContra;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&shIndFactur;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)&i_shIndFactur;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCredMor;
                sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)&i_shCodCredMor;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)&shIndSuperTel;
                sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)&i_shIndSuperTel;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)szhNumTeleFija;
                sqlstm.sqhstl[5] = (unsigned long )16;
                sqlstm.sqhsts[5] = (         int  )0;
                sqlstm.sqindv[5] = (         short *)&i_shNumTeleFija;
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
                sqlstm.sqphsv = sqlstm.sqhstv;
                sqlstm.sqphsl = sqlstm.sqhstl;
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
    else if(stDatosGener.iProdBeeper == pCicloCli->iCodProducto)
    {
        strcpy (szFuncion,"Select=>Ga_AboBeep");
        /* EXEC SQL SELECT COD_USUARIO, TO_CHAR(FEC_FINCONTRA, :szhFmtFecha),
                        IND_FACTUR, COD_CREDMOR, CAP_CODE
                  INTO  :lhCodUsuario                    ,
                        :szhFecFinContra:i_shFecFinContra,
                        :shIndFactur:i_shIndFactur       ,
                        :ihCodCredMor:i_shCodCredMor     ,
                        :lhCapCode:i_shCapCode
                 FROM   GA_ABOBEEP
                 WHERE  NUM_ABONADO = :lhNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_USUARIO ,TO_CHAR(FEC_FINCONTRA,:b0) ,IND_F\
ACTUR ,COD_CREDMOR ,CAP_CODE into :b1,:b2:b3,:b4:b5,:b6:b7,:b8:b9  from GA_ABO\
BEEP where NUM_ABONADO=:b10";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3093;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
        sqlstm.sqhstl[0] = (unsigned long )17;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodUsuario;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecFinContra;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)&i_shFecFinContra;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&shIndFactur;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)&i_shIndFactur;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCredMor;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)&i_shCodCredMor;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCapCode;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)&i_shCapCode;
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
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
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

    if(sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        iDError(szExeName, ERR000, vInsertarIncidencia, "bfnGetDatosAbo", szfnORAerror());
        return(FALSE);
    }

    if(sqlca.sqlcode == SQLOK)
    {
        if(i_shFecFinContra == ORA_NULL)
            strcpy(pCicloCli->szFecFinContra,"");
        else
            strcpy(pCicloCli->szFecFinContra,szhFecFinContra);

        pCicloCli->iCodCredMor  = (i_shCodCredMor == ORA_NULL)?ORA_NULL:ihCodCredMor ;
        pCicloCli->iIndSuperTel = (i_shIndSuperTel== ORA_NULL)?ORA_NULL:shIndSuperTel;

        if(i_shNumTeleFija == ORA_NULL)
            strcpy(pCicloCli->szNumTeleFija,"");
        else
            strcpy(pCicloCli->szNumTeleFija, szhNumTeleFija);

        pCicloCli->lCapCode = (i_shCapCode == ORA_NULL)?ORA_NULL:lhCapCode;

        if( (lhCodUsuario > 0) &&
            (!bfnGetDatosUsuario( lhCodUsuario,
                                  pCicloCli->szNomUsuario,
                                  pCicloCli->szNomApellido1,
                                  pCicloCli->szNomApellido2)))
        {
            return(FALSE);
        }
        return(TRUE);
    }
    else
    {
        vDTrazasLog(szExeName,"\n\t\t* Entrada a funcion bfnGetDatosAbo"
                          "\n\t\t=> bOptProceso:    [%s]"
                          "\n\t\t=> szDetAbocel:    [%s]"
                          "\n\t\t=> szDetAbobep:    [%s]"
                          "\n\t\t=> Ind_OrdenTotal: [%s]", LOG05,
                          (bOpt?"En Proceso":"En Historicas"), stEnlace.szDetAboCel,
                          stEnlace.szDetAboBep, stNota.szIndOrdenTotal);

        if(bOpt == TRUE)
        {
            strcpy(szNomTabla, "FA_FACTABON_NOCICLO");
            if(pCicloCli->iCodProducto == stDatosGener.iProdCelular)
            {
                sprintf(pszAux, "SELECT NOM_USUARIO, NOM_APELLIDO1, NOM_APELLIDO2, IND_FACTUR, COD_CREDMOR, ");
                sprintf(&pszAux[strlen(pszAux)], "TO_CHAR(FEC_FINCONTRA, 'YYYYMMDDHH24MISS'), ");
                sprintf(&pszAux[strlen(pszAux)], "IND_SUPERTEL, NUM_TELEFIJA ");
            }
            else if(pCicloCli->iCodProducto == stDatosGener.iProdBeeper)
            {
                sprintf(pszAux, "SELECT NOM_USUARIO, NOM_APELLIDO1, NOM_APELLIDO2, IND_FACTUR, COD_CREDMOR, ");
                sprintf(&pszAux[strlen(pszAux)], "TO_CHAR(FEC_FINCONTRA, 'YYYYMMDDHH24MISS') ");
            }
        }
        else
        {
            if(pCicloCli->iCodProducto == stDatosGener.iProdCelular)
            {
                strcpy(szNomTabla, stEnlace.szDetAboCel);
                sprintf(pszAux, "SELECT NOM_USUARIO, NOM_APELLIDO1, NOM_APELLIDO2, IND_FACTUR, COD_CREDMOR, ");
                    sprintf(&pszAux[strlen(pszAux)], "TO_CHAR(FEC_FINCONTRA, 'YYYYMMDDHH24MISS'), ");
                    sprintf(&pszAux[strlen(pszAux)], "IND_SUPERTEL, NUM_TELEFIJA ");
            }
            else if(pCicloCli->iCodProducto == stDatosGener.iProdBeeper)
            {
                strcpy(szNomTabla, stEnlace.szDetAboBep);
                sprintf(pszAux, "SELECT NOM_USUARIO, NOM_APELLIDO1, NOM_APELLIDO2, IND_FACTUR, COD_CREDMOR, ");
                    sprintf(&pszAux[strlen(pszAux)], "TO_CHAR(FEC_FINCONTRA, 'YYYYMMDDHH24MISS') ");
            }
        }

        vDTrazasLog (szExeName,"\n\t\t*  Parametros de entrada a %s"
                               "\n\t\t=> Num.Abonado    [%ld]"
                               "\n\t\t=> Ind_OrdenTotal [%s]", LOG04, szNomTabla,
                               pCicloCli->lNumAbonado, stNota.szIndOrdenTotal);

        sprintf(&pszAux[strlen(pszAux)], "FROM %s ", szNomTabla);
        sprintf(&pszAux[strlen(pszAux)], "WHERE IND_ORDENTOTAL = :v1 AND NUM_ABONADO = :v2");

        sqlstmt.len = (short)strlen((char *)sqlstmt.arr);

        /* EXEC SQL PREPARE q_factabo FROM :sqlstmt; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3136;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&sqlstmt;
        sqlstm.sqhstl[0] = (unsigned long )514;
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


        if(sqlca.sqlcode != 0)
        {
            vDTrazasError(szExeName,"\n\t\t**  Error en SQL-PREPARE **"
                                    "\n\t\t=> Error : [%d]  [%s] ", LOG01, SQLCODE, SQLERRM);
            return(FALSE);
        }
        /* EXEC SQL DECLARE CurAbon CURSOR FOR q_factabo; */ 

        if(sqlca.sqlcode != 0)
        {
            vDTrazasError(szExeName,"\n\t\t**  Error en SQL-DECLARE **"
                                    "\n\t\t=> Error : [%d]  [%s] ", LOG01, SQLCODE, SQLERRM);
            return(FALSE);
        }
        /* EXEC SQL OPEN CurAbon USING :lhIndOrdenTotal, :lhNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3155;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(sqlca.sqlcode != 0)
        {
            vDTrazasError(szExeName,"\n\t\t**  Error en SQL-OPEN **"
                                    "\n\t\t=> Error : [%d]  [%s] ", LOG01, SQLCODE, SQLERRM);
            return(FALSE);
        }

        if(pCicloCli->iCodProducto == stDatosGener.iProdCelular)
        {
            /* EXEC SQL FETCH CurAbon
                INTO :szhNomUsuario:i_shNomUsuario,
                     :szhNomApellido1:i_shNomApellido1,
                     :szhNomApellido2:i_shNomApellido2,
                     :shIndFactur:i_shIndFactur,
                     :ihCodCredMor:i_shCodCredMor,
                     :szhFecFinContra:i_shFecFinContra,
                     :shIndSuperTel:i_shIndSuperTel,
                     :szhNumTeleFija:i_shNumTeleFija; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 48;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3178;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNomUsuario;
            sqlstm.sqhstl[0] = (unsigned long )21;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)&i_shNomUsuario;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhNomApellido1;
            sqlstm.sqhstl[1] = (unsigned long )21;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)&i_shNomApellido1;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhNomApellido2;
            sqlstm.sqhstl[2] = (unsigned long )21;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)&i_shNomApellido2;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&shIndFactur;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)&i_shIndFactur;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCredMor;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)&i_shCodCredMor;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhFecFinContra;
            sqlstm.sqhstl[5] = (unsigned long )15;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)&i_shFecFinContra;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&shIndSuperTel;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)&i_shIndSuperTel;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhNumTeleFija;
            sqlstm.sqhstl[7] = (unsigned long )16;
            sqlstm.sqhsts[7] = (         int  )0;
            sqlstm.sqindv[7] = (         short *)&i_shNumTeleFija;
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


        }
        else if(pCicloCli->iCodProducto == stDatosGener.iProdBeeper)
        {
            /* EXEC SQL FETCH CurAbon
                INTO :szhNomUsuario:i_shNomUsuario,
                     :szhNomApellido1:i_shNomApellido1,
                     :szhNomApellido2:i_shNomApellido2,
                     :shIndFactur:i_shIndFactur,
                     :ihCodCredMor:i_shCodCredMor,
                     :szhFecFinContra:i_shFecFinContra; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 48;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3225;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNomUsuario;
            sqlstm.sqhstl[0] = (unsigned long )21;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)&i_shNomUsuario;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhNomApellido1;
            sqlstm.sqhstl[1] = (unsigned long )21;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)&i_shNomApellido1;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhNomApellido2;
            sqlstm.sqhstl[2] = (unsigned long )21;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)&i_shNomApellido2;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&shIndFactur;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)&i_shIndFactur;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCredMor;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)&i_shCodCredMor;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhFecFinContra;
            sqlstm.sqhstl[5] = (unsigned long )15;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)&i_shFecFinContra;
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

        if(sqlca.sqlcode != SQLOK)
        {
            iDError(szExeName, ERR000, vInsertarIncidencia, "bfnGetDatosAbo", szfnORAerror());
            return(FALSE);
        }

        if(sqlca.sqlcode == SQLOK)
        {
            if(i_shFecFinContra == ORA_NULL)
                strcpy(pCicloCli->szFecFinContra, "");
            else
                strcpy(pCicloCli->szFecFinContra, szhFecFinContra);

            pCicloCli->iCodCredMor  = (i_shCodCredMor == ORA_NULL)?ORA_NULL:ihCodCredMor ;
            pCicloCli->iIndSuperTel = (i_shIndSuperTel== ORA_NULL)?ORA_NULL:shIndSuperTel;
            pCicloCli->lCapCode = ORA_NULL;

            if(i_shNomUsuario == ORA_NULL)
                pCicloCli->szNomUsuario[0] = 0;
            else
                strcpy(pCicloCli->szNomUsuario, szhNomUsuario);

            if(i_shNumTeleFija == ORA_NULL)
                pCicloCli->szNumTeleFija[0] = 0;
            else
                strcpy (pCicloCli->szNumTeleFija,szhNumTeleFija);

            if(i_shNomApellido1 == ORA_NULL)
                pCicloCli->szNomApellido1[0] = 0;
            else
                strcpy(pCicloCli->szNomApellido1, szhNomApellido1);

            if(i_shNomApellido2 == ORA_NULL)
                pCicloCli->szNomApellido2[0] = 0;
            else
                strcpy(pCicloCli->szNomApellido2, szhNomApellido2);

            /* EXEC SQL CLOSE CurAbon; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 48;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3264;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



            return(TRUE);
        }
    }
   return(TRUE);
}/************************** Final bfnGetDatosAbo ****************************/

/*****************************************************************************/
/*                          funcion : bfnGetDatosUsuario                     */
/*****************************************************************************/
BOOL bfnGetDatosUsuario (long  lCodUsuario   ,
                         char *szNomUsuario  ,
                         char *szNomApellido1,
                         char *szNomApellido2)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char  szhNomUsuario  [21];/* EXEC SQL VAR szhNomUsuario   IS STRING(21); */ 

   static char  szhNomApellido1[21];/* EXEC SQL VAR szhNomApellido1 IS STRING(21); */ 

   static char  szhNomApellido2[21];/* EXEC SQL VAR szhNomApellido2 IS STRING(21); */ 

   static short i_shNomApellido2   ;
   /* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Ga_Usuarios"
                          "\n\t\t=> Cod.Usuario  [%ld]",LOG04,lCodUsuario);

    if (stProceso.iCodTipDocum != stDatosGener.iCodNotaCre)
    {
       /* EXEC SQL SELECT /o+ index (GA_USUARIOS PK_GA_USUARIOS) o/
                   NOM_USUARIO  ,
                   NOM_APELLIDO1,
                   NOM_APELLIDO2
            INTO   :szhNomUsuario                   ,
                   :szhNomApellido1                 ,
                   :szhNomApellido2:i_shNomApellido2
            FROM   GA_USUARIOS
            WHERE  COD_USUARIO = :lCodUsuario; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 48;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select  /*+  index (GA_USUARIOS PK_GA_USUARIOS)  +*/ N\
OM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 into :b0,:b1,:b2:b3  from GA_USUARIOS\
 where COD_USUARIO=:b4";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )3279;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhNomUsuario;
       sqlstm.sqhstl[0] = (unsigned long )21;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhNomApellido1;
       sqlstm.sqhstl[1] = (unsigned long )21;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szhNomApellido2;
       sqlstm.sqhstl[2] = (unsigned long )21;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)&i_shNomApellido2;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)&lCodUsuario;
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


       if (SQLCODE)
       {
           iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_Usuarios",
                    szfnORAerror());
           return FALSE;
       }
    }
    else
    {
        SQLCODE = SQLOK ;
    }

    if (SQLCODE == SQLOK)
    {
       strcpy (szNomUsuario  ,szhNomUsuario  );
       strcpy (szNomApellido1,szhNomApellido1);

       if (i_shNomApellido2 == ORA_NULL)
           strcpy (szNomApellido2,"");
       else
           strcpy (szNomApellido1,szhNomApellido2);
   }
   return TRUE;
}/************************* Final bfnGetDatosUsuario *************************/

/*****************************************************************************/
/*                          funcion : vfnFreeCicloCli                        */
/*****************************************************************************/
void vfnFreeCicloCli (void)
{
  if (stAbonoCli.pCicloCli != (CICLOCLI *)NULL)
  {
      free (stAbonoCli.pCicloCli)            ;
      stAbonoCli.pCicloCli = (CICLOCLI *)NULL;
  }
  stAbonoCli.lNumAbonados = 0;
}/************************** Final vfnFreeCicloCli ***************************/

/*****************************************************************************/
/*                         funcion : bfnDBUpdateIndImpresa                   */
/* -Funcion que Updatea el Ind_Impresa = 0 en el caso que la Impresion haya  */
/*  sido Erronea, por defecto el valor del campo es 1.                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE.                            */
/*****************************************************************************/
BOOL bfnDBUpdateIndImpresa (HISTDOCU stHis,
                            int      iTipoFact)
{
    char szFuncion [40]    ="";
    char    szCadena [1024]="";

    vDTrazasLog (szExeName, "\n\t\t* Entrada a Update Ind_Impresa a 0"
                            "\n\t\t=>Num.Secuenci        [%ld]"
                            "\n\t\t=>Cod.TipDocum        [%d] "
                            "\n\t\t=>Cod.Vendedor Agente [%ld]"
                            "\n\t\t=>Letra               [%s] "
                            "\n\t\t=>Cod.CentrEmi        [%d] ",LOG05,
                            stHis.lNumSecuenci      , stHis.iCodTipDocum,
                            stHis.lCodVendedorAgente, stHis.szLetra     ,
                            stHis.iCodCentrEmi);

    if (iTipoFact == FACT_CICLO)
    {
        strcpy (szFuncion,"Update=>Fa_FactDocu_Ciclo");
        sprintf(szCadena, "UPDATE FA_FACTDOCU_%ld"
                          "SET    IND_IMPRESA = 0 "
                          "WHERE  NUM_SECUENCI        = :stHis.lNumSecuenci "
                          "AND    COD_TIPDOCUM        = :stHis.iCodTipDocum  "
                          "AND    COD_VENDEDOR_AGENTE = :stHis.lCodVendedorAgente "
                          "AND    LETRA               = :stHis.szLetra "
                          "AND    COD_CENTREMI        = :stHis.iCodCentrEmi ",stCiclo.lCodCiclFact);

        /* EXEC SQL PREPARE sql_update_facturas FROM :szCadena; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3310;
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
            vDTrazasError(szExeName,"\n\t**  Error en SQL-PREPARE sql_update_facturas **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);

        }
        /* EXEC SQL EXECUTE sql_update_facturas USING  :stHis.lNumSecuenci         ,
                                                    :stHis.iCodTipDocum         ,
                                                    :stHis.lCodVendedorAgente   ,
                                                    :stHis.szLetra              ,
                                                    :stHis.iCodCentrEmi; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3329;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&(stHis.lNumSecuenci);
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(stHis.iCodTipDocum);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(stHis.lCodVendedorAgente);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)(stHis.szLetra);
        sqlstm.sqhstl[3] = (unsigned long )2;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&(stHis.iCodCentrEmi);
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
        strcpy (szFuncion, "Update=>Fa_HistDocu_NoCiclo");
            /* EXEC SQL
                UPDATE  FA_FACTDOCU_NOCICLO
                SET     IND_IMPRESA = 0
                WHERE   NUM_SECUENCI        = :stHis.lNumSecuenci
                AND     COD_TIPDOCUM        = :stHis.iCodTipDocum
                AND     COD_VENDEDOR_AGENTE = :stHis.lCodVendedorAgente
                AND     LETRA               = :stHis.szLetra
                AND     COD_CENTREMI        = :stHis.iCodCentrEmi; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 48;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set IND_IMPRESA=0 whe\
re ((((NUM_SECUENCI=:b0 and COD_TIPDOCUM=:b1) and COD_VENDEDOR_AGENTE=:b2) and\
 LETRA=:b3) and COD_CENTREMI=:b4)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )3364;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(stHis.lNumSecuenci);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&(stHis.iCodTipDocum);
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&(stHis.lCodVendedorAgente);
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)(stHis.szLetra);
            sqlstm.sqhstl[3] = (unsigned long )2;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&(stHis.iCodCentrEmi);
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
    if (SQLCODE)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia, szFuncion,szfnORAerror());
    }
    return (SQLCODE != SQLOK)?FALSE:TRUE;
}/************************** Final bfnDBUpdateIndImpresa *********************/

/*****************************************************************************/
/*                          funcion : bfnDBGetCiclFact                       */
/*****************************************************************************/
BOOL bfnDBGetCiclFact (CICLO *pCiclo)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

static char* szhRowid          ;/* EXEC SQL VAR szhRowid           IS STRING(15) ; */ 

static int   ihCodCiclo        ;
static int   ihAno             ;
static long  lhCodCiclFact     ;
static char* szhFecEmision     ;/* EXEC SQL VAR szhFecEmision      IS STRING(15) ; */ 

static char* szhFecVencimie    ;/* EXEC SQL VAR szhFecVencimie     IS STRING(15) ; */ 

static char* szhFecProxVenc    ;/* EXEC SQL VAR szhFecProxVenc     IS STRING(15) ; */ 

static char* szhFecCaducida    ;/* EXEC SQL VAR szhFecCaducida     IS STRING(15) ; */ 

static char* szhFecDesdeLlan   ;/* EXEC SQL VAR szhFecDesdeLlan    IS STRING(15) ; */ 

static char* szhFecHastaLlam   ;/* EXEC SQL VAR szhFecHastaLlam    IS STRING(15) ; */ 

static char* szhFecDesdeCFijos ;/* EXEC SQL VAR szhFecDesdeCFijos  IS STRING(15) ; */ 

static char* szhFecHastaCFijos ;/* EXEC SQL VAR szhFecHastaCFijos  IS STRING(15) ; */ 

static char* szhFecDesdeOCargos;/* EXEC SQL VAR szhFecDesdeOCargos IS STRING(15) ; */ 

static char* szhFecHastaOCargos;/* EXEC SQL VAR szhFecHastaOCargos IS STRING(15) ; */ 

static char* szhFecDesdeRoa    ;/* EXEC SQL VAR szhFecDesdeRoa     IS STRING(15) ; */ 

static char* szhFecHastaRoa    ;/* EXEC SQL VAR szhFecHastaRoa     IS STRING(15) ; */ 

static char* szhFecHMenos      ;/* EXEC SQL VAR szhFecHMenos       IS STRING(15) ; */ 

static char* szhDirLogs        ;/* EXEC SQL VAR szhDirLogs         IS STRING(101); */ 

static char* szhDirSpool       ;/* EXEC SQL VAR szhDirSpool        IS STRING(101); */ 

static short shIndFacturacion  ;
static int   ihDiaPeriodo      ;
static  int ihDiasPeriodoAnt;   /* PGG SOPORTE: 15-09-2005 Prorrateo*/

  static char   szhFmtFecha  [17];/* EXEC SQL VAR szhFmtFecha     IS STRING(17); */ 


  static int ihUno ;
  static int ihSegDia;
/* EXEC SQL END DECLARE SECTION; */ 


  if (pCiclo->lCodCiclFact == -1)
  {
      memset (pCiclo,ORA_NULL,sizeof(CICLO));
  }
  else
  {
     vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada a Fa_CiclFact\n"
                            "\t\t=> Cod.CiclFact [%ld]\n",LOG06,
                            pCiclo->lCodCiclFact);
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

     shIndFacturacion  = pCiclo->iIndFacturacion  ;
     lhCodCiclFact     = pCiclo->lCodCiclFact     ;

     sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");
     ihUno    = 1 ;
     ihSegDia = 86400 ;
     /* EXEC SQL SELECT
            ROWID                                    ,
            COD_CICLO                                ,
            ANO                                      ,
            TO_CHAR(FEC_VENCIMIE,:szhFmtFecha)       ,
            TO_CHAR(FEC_EMISION ,:szhFmtFecha)       ,
            TO_CHAR(FEC_CADUCIDA,:szhFmtFecha)       ,
            TO_CHAR(FEC_PROXVENC,:szhFmtFecha)       ,
            TO_CHAR(FEC_DESDELLAM,:szhFmtFecha)      ,
            TO_CHAR(FEC_HASTALLAM,:szhFmtFecha)      ,
            TO_CHAR(FEC_DESDECFIJOS,:szhFmtFecha)    ,
            TO_CHAR(FEC_HASTACFIJOS,:szhFmtFecha)    ,
            TO_CHAR(FEC_DESDEOCARGOS,:szhFmtFecha)   ,
            TO_CHAR(FEC_HASTAOCARGOS,:szhFmtFecha)   ,
            TO_CHAR(FEC_DESDEROA,:szhFmtFecha)       ,
            TO_CHAR(FEC_HASTAROA,:szhFmtFecha)       ,
            TO_CHAR(FEC_DESDECFIJOS - ( :ihUno/:ihSegDia),:szhFmtFecha),
            IND_FACTURACION                          ,
            DIR_LOGS                                 ,
            DIR_SPOOL                                ,
            DIA_PERIODO
       INTO :szhRowid                  ,
            :ihCodCiclo                ,
            :ihAno                     ,
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
            :szhDirSpool               ,
            :ihDiaPeriodo
      FROM  FA_CICLFACT
      WHERE COD_CICLFACT    = :lhCodCiclFact
        AND IND_FACTURACION = :shIndFacturacion; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 48;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select ROWID ,COD_CICLO ,ANO ,TO_CHAR(FEC_VENCIMIE,:b0) \
,TO_CHAR(FEC_EMISION,:b0) ,TO_CHAR(FEC_CADUCIDA,:b0) ,TO_CHAR(FEC_PROXVENC,:b0\
) ,TO_CHAR(FEC_DESDELLAM,:b0) ,TO_CHAR(FEC_HASTALLAM,:b0) ,TO_CHAR(FEC_DESDECF\
IJOS,:b0) ,TO_CHAR(FEC_HASTACFIJOS,:b0) ,TO_CHAR(FEC_DESDEOCARGOS,:b0) ,TO_CHA\
R(FEC_HASTAOCARGOS,:b0) ,TO_CHAR(FEC_DESDEROA,:b0) ,TO_CHAR(FEC_HASTAROA,:b0) \
,TO_CHAR((FEC_DESDECFIJOS-(:b12/:b13)),:b0) ,IND_FACTURACION ,DIR_LOGS ,DIR_SP\
OOL ,DIA_PERIODO into :b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22,:b23,:b24,:b25,:\
b26,:b27,:b28,:b29,:b30,:b31,:b32,:b33,:b34  from FA_CICLFACT where (COD_CICLF\
ACT=:b35 and IND_FACTURACION=:b31)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )3399;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
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
     sqlstm.sqhstv[4] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[4] = (unsigned long )17;
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
     sqlstm.sqhstv[6] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[6] = (unsigned long )17;
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
     sqlstm.sqhstv[8] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[8] = (unsigned long )17;
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
     sqlstm.sqhstv[10] = (unsigned char  *)szhFmtFecha;
     sqlstm.sqhstl[10] = (unsigned long )17;
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
     sqlstm.sqhstv[12] = (unsigned char  *)&ihUno;
     sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[12] = (         int  )0;
     sqlstm.sqindv[12] = (         short *)0;
     sqlstm.sqinds[12] = (         int  )0;
     sqlstm.sqharm[12] = (unsigned long )0;
     sqlstm.sqadto[12] = (unsigned short )0;
     sqlstm.sqtdso[12] = (unsigned short )0;
     sqlstm.sqhstv[13] = (unsigned char  *)&ihSegDia;
     sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
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
     sqlstm.sqhstv[15] = (unsigned char  *)szhRowid;
     sqlstm.sqhstl[15] = (unsigned long )15;
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
     sqlstm.sqhstv[17] = (unsigned char  *)&ihAno;
     sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[17] = (         int  )0;
     sqlstm.sqindv[17] = (         short *)0;
     sqlstm.sqinds[17] = (         int  )0;
     sqlstm.sqharm[17] = (unsigned long )0;
     sqlstm.sqadto[17] = (unsigned short )0;
     sqlstm.sqtdso[17] = (unsigned short )0;
     sqlstm.sqhstv[18] = (unsigned char  *)szhFecVencimie;
     sqlstm.sqhstl[18] = (unsigned long )15;
     sqlstm.sqhsts[18] = (         int  )0;
     sqlstm.sqindv[18] = (         short *)0;
     sqlstm.sqinds[18] = (         int  )0;
     sqlstm.sqharm[18] = (unsigned long )0;
     sqlstm.sqadto[18] = (unsigned short )0;
     sqlstm.sqtdso[18] = (unsigned short )0;
     sqlstm.sqhstv[19] = (unsigned char  *)szhFecEmision;
     sqlstm.sqhstl[19] = (unsigned long )15;
     sqlstm.sqhsts[19] = (         int  )0;
     sqlstm.sqindv[19] = (         short *)0;
     sqlstm.sqinds[19] = (         int  )0;
     sqlstm.sqharm[19] = (unsigned long )0;
     sqlstm.sqadto[19] = (unsigned short )0;
     sqlstm.sqtdso[19] = (unsigned short )0;
     sqlstm.sqhstv[20] = (unsigned char  *)szhFecCaducida;
     sqlstm.sqhstl[20] = (unsigned long )15;
     sqlstm.sqhsts[20] = (         int  )0;
     sqlstm.sqindv[20] = (         short *)0;
     sqlstm.sqinds[20] = (         int  )0;
     sqlstm.sqharm[20] = (unsigned long )0;
     sqlstm.sqadto[20] = (unsigned short )0;
     sqlstm.sqtdso[20] = (unsigned short )0;
     sqlstm.sqhstv[21] = (unsigned char  *)szhFecProxVenc;
     sqlstm.sqhstl[21] = (unsigned long )15;
     sqlstm.sqhsts[21] = (         int  )0;
     sqlstm.sqindv[21] = (         short *)0;
     sqlstm.sqinds[21] = (         int  )0;
     sqlstm.sqharm[21] = (unsigned long )0;
     sqlstm.sqadto[21] = (unsigned short )0;
     sqlstm.sqtdso[21] = (unsigned short )0;
     sqlstm.sqhstv[22] = (unsigned char  *)szhFecDesdeLlan;
     sqlstm.sqhstl[22] = (unsigned long )15;
     sqlstm.sqhsts[22] = (         int  )0;
     sqlstm.sqindv[22] = (         short *)0;
     sqlstm.sqinds[22] = (         int  )0;
     sqlstm.sqharm[22] = (unsigned long )0;
     sqlstm.sqadto[22] = (unsigned short )0;
     sqlstm.sqtdso[22] = (unsigned short )0;
     sqlstm.sqhstv[23] = (unsigned char  *)szhFecHastaLlam;
     sqlstm.sqhstl[23] = (unsigned long )15;
     sqlstm.sqhsts[23] = (         int  )0;
     sqlstm.sqindv[23] = (         short *)0;
     sqlstm.sqinds[23] = (         int  )0;
     sqlstm.sqharm[23] = (unsigned long )0;
     sqlstm.sqadto[23] = (unsigned short )0;
     sqlstm.sqtdso[23] = (unsigned short )0;
     sqlstm.sqhstv[24] = (unsigned char  *)szhFecDesdeCFijos;
     sqlstm.sqhstl[24] = (unsigned long )15;
     sqlstm.sqhsts[24] = (         int  )0;
     sqlstm.sqindv[24] = (         short *)0;
     sqlstm.sqinds[24] = (         int  )0;
     sqlstm.sqharm[24] = (unsigned long )0;
     sqlstm.sqadto[24] = (unsigned short )0;
     sqlstm.sqtdso[24] = (unsigned short )0;
     sqlstm.sqhstv[25] = (unsigned char  *)szhFecHastaCFijos;
     sqlstm.sqhstl[25] = (unsigned long )15;
     sqlstm.sqhsts[25] = (         int  )0;
     sqlstm.sqindv[25] = (         short *)0;
     sqlstm.sqinds[25] = (         int  )0;
     sqlstm.sqharm[25] = (unsigned long )0;
     sqlstm.sqadto[25] = (unsigned short )0;
     sqlstm.sqtdso[25] = (unsigned short )0;
     sqlstm.sqhstv[26] = (unsigned char  *)szhFecDesdeOCargos;
     sqlstm.sqhstl[26] = (unsigned long )15;
     sqlstm.sqhsts[26] = (         int  )0;
     sqlstm.sqindv[26] = (         short *)0;
     sqlstm.sqinds[26] = (         int  )0;
     sqlstm.sqharm[26] = (unsigned long )0;
     sqlstm.sqadto[26] = (unsigned short )0;
     sqlstm.sqtdso[26] = (unsigned short )0;
     sqlstm.sqhstv[27] = (unsigned char  *)szhFecHastaOCargos;
     sqlstm.sqhstl[27] = (unsigned long )15;
     sqlstm.sqhsts[27] = (         int  )0;
     sqlstm.sqindv[27] = (         short *)0;
     sqlstm.sqinds[27] = (         int  )0;
     sqlstm.sqharm[27] = (unsigned long )0;
     sqlstm.sqadto[27] = (unsigned short )0;
     sqlstm.sqtdso[27] = (unsigned short )0;
     sqlstm.sqhstv[28] = (unsigned char  *)szhFecDesdeRoa;
     sqlstm.sqhstl[28] = (unsigned long )15;
     sqlstm.sqhsts[28] = (         int  )0;
     sqlstm.sqindv[28] = (         short *)0;
     sqlstm.sqinds[28] = (         int  )0;
     sqlstm.sqharm[28] = (unsigned long )0;
     sqlstm.sqadto[28] = (unsigned short )0;
     sqlstm.sqtdso[28] = (unsigned short )0;
     sqlstm.sqhstv[29] = (unsigned char  *)szhFecHastaRoa;
     sqlstm.sqhstl[29] = (unsigned long )15;
     sqlstm.sqhsts[29] = (         int  )0;
     sqlstm.sqindv[29] = (         short *)0;
     sqlstm.sqinds[29] = (         int  )0;
     sqlstm.sqharm[29] = (unsigned long )0;
     sqlstm.sqadto[29] = (unsigned short )0;
     sqlstm.sqtdso[29] = (unsigned short )0;
     sqlstm.sqhstv[30] = (unsigned char  *)szhFecHMenos;
     sqlstm.sqhstl[30] = (unsigned long )15;
     sqlstm.sqhsts[30] = (         int  )0;
     sqlstm.sqindv[30] = (         short *)0;
     sqlstm.sqinds[30] = (         int  )0;
     sqlstm.sqharm[30] = (unsigned long )0;
     sqlstm.sqadto[30] = (unsigned short )0;
     sqlstm.sqtdso[30] = (unsigned short )0;
     sqlstm.sqhstv[31] = (unsigned char  *)&shIndFacturacion;
     sqlstm.sqhstl[31] = (unsigned long )sizeof(short);
     sqlstm.sqhsts[31] = (         int  )0;
     sqlstm.sqindv[31] = (         short *)0;
     sqlstm.sqinds[31] = (         int  )0;
     sqlstm.sqharm[31] = (unsigned long )0;
     sqlstm.sqadto[31] = (unsigned short )0;
     sqlstm.sqtdso[31] = (unsigned short )0;
     sqlstm.sqhstv[32] = (unsigned char  *)szhDirLogs;
     sqlstm.sqhstl[32] = (unsigned long )101;
     sqlstm.sqhsts[32] = (         int  )0;
     sqlstm.sqindv[32] = (         short *)0;
     sqlstm.sqinds[32] = (         int  )0;
     sqlstm.sqharm[32] = (unsigned long )0;
     sqlstm.sqadto[32] = (unsigned short )0;
     sqlstm.sqtdso[32] = (unsigned short )0;
     sqlstm.sqhstv[33] = (unsigned char  *)szhDirSpool;
     sqlstm.sqhstl[33] = (unsigned long )101;
     sqlstm.sqhsts[33] = (         int  )0;
     sqlstm.sqindv[33] = (         short *)0;
     sqlstm.sqinds[33] = (         int  )0;
     sqlstm.sqharm[33] = (unsigned long )0;
     sqlstm.sqadto[33] = (unsigned short )0;
     sqlstm.sqtdso[33] = (unsigned short )0;
     sqlstm.sqhstv[34] = (unsigned char  *)&ihDiaPeriodo;
     sqlstm.sqhstl[34] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[34] = (         int  )0;
     sqlstm.sqindv[34] = (         short *)0;
     sqlstm.sqinds[34] = (         int  )0;
     sqlstm.sqharm[34] = (unsigned long )0;
     sqlstm.sqadto[34] = (unsigned short )0;
     sqlstm.sqtdso[34] = (unsigned short )0;
     sqlstm.sqhstv[35] = (unsigned char  *)&lhCodCiclFact;
     sqlstm.sqhstl[35] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[35] = (         int  )0;
     sqlstm.sqindv[35] = (         short *)0;
     sqlstm.sqinds[35] = (         int  )0;
     sqlstm.sqharm[35] = (unsigned long )0;
     sqlstm.sqadto[35] = (unsigned short )0;
     sqlstm.sqtdso[35] = (unsigned short )0;
     sqlstm.sqhstv[36] = (unsigned char  *)&shIndFacturacion;
     sqlstm.sqhstl[36] = (unsigned long )sizeof(short);
     sqlstm.sqhsts[36] = (         int  )0;
     sqlstm.sqindv[36] = (         short *)0;
     sqlstm.sqinds[36] = (         int  )0;
     sqlstm.sqharm[36] = (unsigned long )0;
     sqlstm.sqadto[36] = (unsigned short )0;
     sqlstm.sqtdso[36] = (unsigned short )0;
     sqlstm.sqphsv = sqlstm.sqhstv;
     sqlstm.sqphsl = sqlstm.sqhstl;
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
   if (SQLCODE != SQLOK)
   {
       iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_CiclFact",
                szfnORAerror());
       return FALSE;
   }
   if (SQLCODE == 0)
   {
       pCiclo->iAno            = ihAno           ;
       pCiclo->iCodCiclo       = ihCodCiclo      ;
       pCiclo->lCodCiclFact    = lhCodCiclFact   ;
       pCiclo->iIndFacturacion = shIndFacturacion;
       pCiclo->iDiaPeriodo     = ihDiaPeriodo    ;

/* PGG SOPORTE: 15-09-2005 OBTENCION DE CANTIDAD DE DIAS DEL PERIODO ANTERIOR */

    /* EXEC SQL
        SELECT DIA_PERIODO
          INTO :ihDiasPeriodoAnt
          FROM FA_CICLFACT
         WHERE FEC_EMISION = ( SELECT MAX(FEC_EMISION)
                                 FROM FA_CICLFACT
                                WHERE FEC_EMISION < (SELECT FEC_EMISION
                                                       FROM FA_CICLFACT
                                                      WHERE COD_CICLFACT  = :lhCodCiclFact
                                                        AND IND_FACTURACION = :shIndFacturacion)
                                  AND COD_CICLO = :ihCodCiclo)
        AND COD_CICLO = :ihCodCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 48;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DIA_PERIODO into :b0  from FA_CICLFACT where (FEC_\
EMISION=(select max(FEC_EMISION)  from FA_CICLFACT where (FEC_EMISION<(select \
FEC_EMISION  from FA_CICLFACT where (COD_CICLFACT=:b1 and IND_FACTURACION=:b2)\
) and COD_CICLO=:b3)) and COD_CICLO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3562;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihDiasPeriodoAnt;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&shIndFacturacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
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
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCiclo;
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



    if (SQLCODE != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Obtencion de cantidad de dias del periodo anterior -Prorrateo-", szfnORAerror ());
        return  (FALSE);
    }


    pCiclo->iDiaPeriodoAnt = ihDiasPeriodoAnt;

    vDTrazasLog(szExeName,"\n\t\t* bfnDBGetCiclFact==>"
                          "\n\t\t*** ihDiasPeriodoAnt==>(%ld)"
                          "\n\t\t*** ihCodCiclo==>(%ld)"
                          "\n\t\t*** shIndFacturacion==>(%ld)"
                          "\n\t\t*** lhCodCiclFact==>(%ld)"
                          , LOG03, pCiclo->iDiaPeriodoAnt
                          , ihCodCiclo,shIndFacturacion,lhCodCiclFact );
/* PGG SOPORTE: 15-09-2005 Hasta aqui */


       if (!bfnDBGetCiclo (pCiclo))
            return FALSE;
   }
   return TRUE;
}/*************************** Final bfnDBGetCiclFact ************************/


/*****************************************************************************/
/*                        funcion : bfnConsumeFolio                          */
/*****************************************************************************/
BOOL bfnConsumeFolio (char *szCodOficina,
                      int   iCodTipDocum,
                      char *szCodOperadora ,
                      long lNumProceso,
                      char *szFechaFol,
                      long *plNumFolio,
                      char *szPrefPlaza)
{
  char  modulo[] = "bfnConsumeFolio";
  /*char  cSeparador      =';';*/ /* P-MIX-09003 136835 */
  int   iNumParametros  = 0 ;
  char  *szArregloParametros[5];

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int    ihCodTipDocum    ;
  static char   szhResultado [256] ; /* EXEC SQL VAR szhResultado IS STRING (256); */ 

  static char   szhCodOficina   [3]  ; /* EXEC SQL VAR szhCodOficina IS STRING (3); */ 

  static char   szhCodOperadora [6]; /* EXEC SQL VAR szhCodOperadora IS STRING (6); */ 

  static char   szhFecha       [15]; /* EXEC SQL VAR szhFecha IS STRING (15); */ 

  static long   lhNumProceso   ;
  /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName,"\n\t\t* Entrada en %s"
                           "\n\t\t=>Cod.Oficina     [%s]"
                           "\n\t\t=>Cod.Tip.Docum   [%d]"
                           "\n\t\t=>Cod.Operadora   [%s]"
                           "\n\t\t=>Num.Proceso     [%ld]"
                           "\n\t\t=>Fec.Foliacion   [%s]"
                           , LOG05, modulo, szCodOficina, iCodTipDocum
                           , szCodOperadora, lNumProceso, szFechaFol );

    strcpy (szhCodOficina,szCodOficina);
    strcpy (szhCodOperadora,szCodOperadora);
    ihCodTipDocum = iCodTipDocum;
    lhNumProceso = lNumProceso;
    strcpy(szhFecha, szFechaFol);

    /* EXEC SQL
        SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_CICLO_FN( :ihCodTipDocum
                                                    ,NULL
                                                    ,:szhCodOficina
                                                    ,:szhCodOperadora
                                                    ,NULL
                                                    ,NULL
                                                    ,:lhNumProceso
                                                    ,TO_DATE(:szhFecha,'YYYYMMDDHH24MISS')
                                                    ,1)
        INTO :szhResultado
        FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 48;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_FOLIACION_PG.FA_CONSUME_FOLIO_CICLO_FN(:b0,null\
 ,:b1,:b2,null ,null ,:b3,TO_DATE(:b4,'YYYYMMDDHH24MISS'),1) into :b5  from DU\
AL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3597;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[5] = (unsigned char  *)szhResultado;
    sqlstm.sqhstl[5] = (unsigned long )256;
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



    if (SQLCODE)
    {
        vDTrazasLog  (modulo,"\n\t**  Error en ejecucion de FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en ejecucion de FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError(szExeName, ERR000, vInsertarIncidencia, "Error en ejecucion de FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN", szfnORAerror());
        return  FALSE;
    }

    iNumParametros = 4; /* P-MIX-09003 136835 */
    RecupParam(&iNumParametros,szArregloParametros,szhResultado,cSEPARADOR_DOSPUNTOS); /* P-MIX-09003 136835 */

    if(iNumParametros!=4)/* P-MIX-09003 136835 */
    {
        vDTrazasLog  (modulo,"\n\t** Numero de parametros retornados incorrecto para  FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN **"
                            ,LOG01);
        vDTrazasError(modulo,"\n\t** Numero de parametros retornados incorrecto para  FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN **"
                            ,LOG01);
        return  FALSE;
    }

    if (strcmp(szArregloParametros[0],"2") != 0 )
    {
        vDTrazasLog  (modulo,"\n\t** Error, retorno de la funcion FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN **"
                             "\n\t=> Error : [%d]  [%s] "
                            ,LOG01, szArregloParametros[0],SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t** Error, retorno de la funcion FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN **"
                             "\n\t=> Retorno proceso = [%s]"
                             "\n\t=> Error : [%d]  [%s] "
                            ,LOG01, szArregloParametros[0],SQLCODE,SQLERRM);
        return (FALSE);
    }

    *plNumFolio = atol(szArregloParametros[2]);
    strcpy(szPrefPlaza, szArregloParametros[1]);

  return TRUE;
}/*************************** Final bfnConsumeFolio **************************/

/*****************************************************************************/
/*                          funcion : vfnHandlerFile                         */
/*****************************************************************************/
void vfnHandlerFile (int iSig)
{
  if (stStatus.LogFile != (FILE *)NULL)
  {
       fclose (stStatus.LogFile);
       fclose (stStatus.ErrFile);
       exit   (-1)              ;
 }
}/************************* Final vfnHandlerFile *****************************/


/*****************************************************************************/
/*                            funcion : szfnDigVerificador                   */
/* Parametro : La cadena a Tratar                                            */
/* Return    : El Caracter de control                                        */
/*****************************************************************************/
char *szfnDigVerificador (char *szNum)
{
    int i       = 0;
    int j       = 2; /* j tomara los valores de 2 a 7 inclusives */
    int iDigito = 0;

    char szAux[2]   = "";
    char szNumSal[2]= "";

    div_t stRes         ;


        i = strlen(szNum)-1;

        while (i >= 0)
        {
          if (j >= 8)
              j  = 2;

          strncpy (szAux, &szNum [i], 1);

          iDigito += (atoi (szAux) * j);

          j++;
          i--;
        }

        stRes = div (iDigito, 11);

        if ( (11-stRes.rem) == 10)
            sprintf (szNumSal, "%s", szDIG10);
        else
            sprintf (szNumSal, "%d", ((11-stRes.rem)==11)?0:11-stRes.rem);


return (char *)szNumSal;
}/**************************** Final szfnDigVerificador **********************/

BOOL bfnGetBcoUniPac (long lCodCliente, char *szCodBanco )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long  lhCodCliente    ;
        char  szhCodBco   [16] ;/* EXEC SQL VAR szhCodBco IS STRING (16); */ 

    /* EXEC SQL END DECLARE SECTION  ; */ 


    vDTrazasLog (szExeName,
               "\n\t\t* Recuperacion Codigo de Banco de cliente Pac (bfnGetBcoUniPac)"
               "\n\t\t=> Cod.Cliente [%ld]", LOG05,lCodCliente);

    lhCodCliente = lCodCliente;

    /* EXEC SQL
        SELECT COD_BANCO
          INTO :szhCodBco
          FROM CO_UNIPAC
         WHERE COD_CLIENTE = :lhCodCliente ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 48;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_BANCO into :b0  from CO_UNIPAC where COD_CLIEN\
TE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )3636;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodBco;
    sqlstm.sqhstl[0] = (unsigned long )16;
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



    if (SQLCODE != SQLNOTFOUND)
    {
        if (SQLCODE)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                       "Select=>CO_UNIPAC",szfnORAerror ());
            return  (FALSE)                                       ;
        }
        else
        {
            strcpy(szCodBanco,szhCodBco);
       }
    }
    return TRUE;

}/************************ Final bfnGetBcoUniPac ***************************/

/*****************************************************************************/
/*                          Funcion   RecupParam                             */
/* funcion que entrega en el arreglo los distintos parametros de la cadena   */
/* que se encuentran se parados por el delimitador                           */
/*****************************************************************************/
BOOL RecupParam( int *iNumParam, char *argv[], char *szCadena,int chr)
{
    char    modulo[] = "RecupParam";
    char    *p, *pant, c;
    int     cont;

    cont = 0;
    *iNumParam = 0;
    pant = p = szCadena;

    while(1)
    {
      p=strchr(pant,chr);
      if(p==NULL)
      {
        break;
      }
      else
      {
           c = *p;
           *p = 0;
           if ( ( argv[cont]  = malloc(strlen(pant)+1) ) == NULL )
           {
                vDTrazasError(modulo,"\n\t\t*** Error, No se puede reservar memoria ",LOG01);
                return (FALSE);
           }
           strcpy(argv[cont],pant) ;
           pant = p  + 1;
           *p = c;
           cont++;
        }
   }
   if(p==NULL)
   {
      if(strlen(pant)>0){
           if ( ( argv[cont]  = malloc(strlen(pant)+1) ) == NULL ){
                vDTrazasError(modulo,"\n\t\t*** Error, No se puede reservar memoria ",LOG01);
                return (FALSE);
           }
           strcpy(argv[cont],pant) ;
           cont++;
      }

   }

   *iNumParam=cont;
   return (TRUE);
}/************************ Final RecupParam ***************************/


/******************************************************************************
Funcion         :       ifnCmpFactCobr
*******************************************************************************/
int ifnCmpFactCobr(const void *cad1,const void *cad2)
{
    return ((FACTCOBR *)cad1)->iCodConcFact -
         ((FACTCOBR *)cad2)->iCodConcFact;

}

/*****************************************************************************/
/*                             funcion : bfnFindFactCobr                   */
/*****************************************************************************/
BOOL bfnFindFactCobr (int iCodConcFact, int * iFactCobr )
{
    /*FACTCOBR  stkey;*/
    /*FACTCOBR  *pstAux = (FACTCOBR *)NULL;*/

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static int   ihCodConcFact;
        static int   ihCodConCobr ;
    /* EXEC SQL END DECLARE SECTION; */ 


    /*memset (&stkey,0, sizeof(FACTCOBR));*/
    vDTrazasLog (szExeName,"\n\t\t* Busca Concepto Cobro "
                            "\n\t\t=> Concepto Fact.   [%d]"
                            , LOG05,iCodConcFact);


    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        if ( pstConceptos[iCodConcFact].iFlagExiste == 1 )
        {
            *iFactCobr = pstConceptos[iCodConcFact].iCodConCobr;
            vDTrazasLog(szExeName, "Concepto Cobr. [%d] encontrado", LOG04, iFactCobr);
		}else{
	    	vDTrazasLog(szExeName, "Concepto Fact. [%d] no encontrada ...", LOG01, iCodConcFact);
			return FALSE;
		}

        /*stkey.iCodConcFact=iCodConcFact;

        if ( (pstAux = (FACTCOBR *)bsearch (&stkey, pstFactCobros.stFactCobr, pstFactCobros.iNumFactCobros,
                                       sizeof (FACTCOBR),ifnCmpFactCobr ))== (FACTCOBR *)NULL)
        {

            vDTrazasLog(szExeName, "Concepto Fact. [%d] no encontrada ...", LOG01, iCodConcFact);
            return  (FALSE)                                                   ;
        }
        iFactCobr = pstAux->iCodConCobr;*/
    }
    else
    {
        ihCodConcFact= iCodConcFact;

        /* EXEC SQL
            SELECT COD_CONCCOBR
              INTO :ihCodConCobr
              FROM FA_FACTCOBR
             WHERE COD_CONCFACT = :ihCodConcFact; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_CONCCOBR into :b0  from FA_FACTCOBR where \
COD_CONCFACT=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3659;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConCobr;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcFact;
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



        if (SQLCODE)
        {
           iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Fa_FactCobr",
                     szfnORAerror ());
           return FALSE;
        }
        else
        {
            *iFactCobr = ihCodConCobr;
        }
    }
    return TRUE;
}/**************************** Final bfnFindFactCobr *********************/

/******************************************************************************
Funcion         :       ifnCmpOficinas
*******************************************************************************/
int ifnCmpOficinas(const void *cad1,const void *cad2)
{
    return ( strcmp (((OFICINA  *)cad1)->szCodOficina,((OFICINA  *)cad2)->szCodOficina) );

}

/*****************************************************************************/
/*                             funcion : bfnFindOficina                   */
/*****************************************************************************/
BOOL bfnFindOficina (char *szCodOficina, OFICINA *pstOficina )
{
    OFICINA  stkey;
    OFICINA  *pstAux = (OFICINA *)NULL;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhCodOficina  [3];/* EXEC SQL VAR szhCodOficina   IS STRING(3); */ 

        char szhCodRegion   [4];/* EXEC SQL VAR szhCodRegion    IS STRING(4); */ 

        char szhCodProvincia[6];/* EXEC SQL VAR szhCodProvincia IS STRING(6); */ 

        char szhCodCiudad   [6];/* EXEC SQL VAR szhCodCiudad    IS STRING(6); */ 

        char szhCodPlaza    [6];/* EXEC SQL VAR szhCodPlaza     IS STRING(6); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName,"\n\t\t* Busca Oficina "
                            "\n\t\t=> Cod.Oficina   [%s]"
                            "\n\t\t=> Num.Oficina   [%d]"
                            "\n\t\t=> Tipo Documento[%d]"
                            "\n\t\t=> stDatosGener.iCodCiclo [%d]"
                            , LOG05,szCodOficina, pstOficinas.iNumOficinas, stProceso.iCodTipDocum,stDatosGener.iCodCiclo);

    if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        strcpy (stkey.szCodOficina,szCodOficina);

        if ( (pstAux = (OFICINA *)bsearch (&stkey, pstOficinas.stOficina, pstOficinas.iNumOficinas,
                                       sizeof (OFICINA),ifnCmpOficinas ))== (OFICINA *)NULL)
        {

            vDTrazasLog(szExeName, "Oficina [%s] no encontrada ...", LOG01, szCodOficina);
            return  (FALSE)                                                   ;
        }
        memcpy (pstOficina, pstAux, sizeof(OFICINA));
    }
    else
    {
        strcpy (szhCodOficina, szCodOficina);

        /* EXEC SQL
            SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, C.COD_PLAZA
              INTO :szhCodRegion, :szhCodProvincia,:szhCodCiudad,:szhCodPlaza
              FROM GE_OFICINAS    A,
                   GE_DIRECCIONES B,
                   GE_CIUDADES    C
             WHERE A.COD_OFICINA    = :szhCodOficina
               AND A.COD_DIRECCION  = B.COD_DIRECCION
               AND B.COD_REGION     = C.COD_REGION
               AND B.COD_PROVINCIA  = C.COD_PROVINCIA
               AND B.COD_CIUDAD     = C.COD_CIUDAD; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 48;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select B.COD_REGION ,B.COD_PROVINCIA ,B.COD_CIUDAD ,C\
.COD_PLAZA into :b0,:b1,:b2,:b3  from GE_OFICINAS A ,GE_DIRECCIONES B ,GE_CIUD\
ADES C where ((((A.COD_OFICINA=:b4 and A.COD_DIRECCION=B.COD_DIRECCION) and B.\
COD_REGION=C.COD_REGION) and B.COD_PROVINCIA=C.COD_PROVINCIA) and B.COD_CIUDAD\
=C.COD_CIUDAD)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )3682;
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
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlaza;
        sqlstm.sqhstl[3] = (unsigned long )6;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[4] = (unsigned long )3;
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



        if (SQLCODE)
        {
           iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Oficinas",
                     szfnORAerror ());
           return FALSE;
        }
        else
        {
            strcpy (pstOficina->szCodOficina    , szhCodOficina );
            strcpy (pstOficina->szCodRegion     , szhCodRegion  );
            strcpy (pstOficina->szCodProvincia  , szhCodProvincia);
            strcpy (pstOficina->szCodCiudad     , szhCodCiudad  );
            strcpy (pstOficina->szCodPlaza      , szhCodPlaza   );
        }

    }
    return TRUE;
}/**************************** Final bfnFindFaCiclFact *********************/


/*****************************************************************************/
/*                           funcion : bfnGetParamImptos                     */
/*****************************************************************************/
BOOL bfnGetFadParam (char *pszFecha)
{
    char  modulo[] = "bfnGetFadParam";
    char  szTipParametro [33] ="";
    char  szValParametro [512]="";
    int   iRes;

    vDTrazasLog (modulo,"\n\t\t* Carga parametros de facturacion ", LOG05);

    memset (&pstFadParam     ,0,sizeof(pstFadParam));

    /* Obtencion del codigo de concepto de impuesto IEPS */
    iRes = ifnGetParametro(102,szTipParametro,szValParametro ) ;
    if (iRes != SQLNOTFOUND )
    {
        if (iRes != SQLOK)
        {
            vDTrazasError(modulo,"\n\t** ERROR, al recuperar parametro de IEPS 102 error [%d] **",LOG01,iRes);
            return (FALSE);
        }

        pstFadParam.iConcIEPS=atoi (szValParametro);
    }

    /* Obtencion del codigo de concepto de descuento de impuesto IEPS */
    iRes = ifnGetParametro(103,szTipParametro,szValParametro ) ;

    if (iRes != SQLNOTFOUND )
    {
        if (iRes != SQLOK)
        {
            vDTrazasError(modulo,"\n\t** ERROR, al recuperar parametro de IEPS 103 error [%d] **",LOG01,iRes);
            return (FALSE);
        }

        pstFadParam.iConcDctoIEPS=atoi (szValParametro);
    }


   return (TRUE);
}/**************************** Final bfnGetParamImptos *********************/
/*****************************************************************************/
/*                         funcion : iCmpPlanTarif                           */
/*****************************************************************************/
int iCmpPlanTarif2 (const void* cad1,const void* cad2)
{
   int rc = 0;

   return ( (rc = strcmp ( ((PLANTARIF *)cad1)->szCodPlanTarif,
                     ((PLANTARIF *)cad2)->szCodPlanTarif) ) != 0)?rc:0;
}/************************* Final iCmpPlanTarif ******************************/


/*****************************************************************************/
/*                        funcion : bFindPlanTarif                          */
/*****************************************************************************/
BOOL bFindPlanTarif (int   iCodProducto, char *pszCodPlanTarif, PLANTARIF  *lstPlanTarif)
{
  PLANTARIF stkey;
  PLANTARIF *pPlanT = (PLANTARIF *)NULL;
  BOOL bRes = 1;

  strcpy (stkey.szCodPlanTarif ,pszCodPlanTarif);

  if ( (pPlanT = (PLANTARIF *)bsearch(&stkey,pstPlanTarif,NUM_PLANTARIF,
                 sizeof(PLANTARIF),iCmpPlanTarif2) )==(PLANTARIF *)NULL)
  {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstPlanTarif");
        bRes = FALSE;
  }
  else
     *lstPlanTarif = *pPlanT;

    vDTrazasLog (szExeName,"GENFA:lstPlanTarif.szCod_Unidad [%s]"
                           "GENFA:lstPlanTarif.lNumUnidades [%ld]"
                           , LOG05,lstPlanTarif->szCod_Unidad,lstPlanTarif->lNumUnidades);

  return (bRes);

}/************************ Final bFindPlanTarif *****************************/

/* Funcion para incrementar indice de stPreFactura */
BOOL bfnIncrementarIndicePreFactura(void)
{

    BOOL FlagKillImporte; 
    int iCodConcepto =0;
    long lNuevoTam=0L;  
    FAPFACTURA     *A_PFacturaTemp = NULL ;
    IND_PREFACTURA *A_IndTemp      = NULL ;

    
    vDTrazasLog (szExeName,"\n\t *** [JQH] bfnIncrementarIndicePreFactura: Inicio: stDatosGener.lIndValImporte : [%ld]", LOG03, stDatosGener.lIndValImporte);
    
    if (stDatosGener.lIndValImporte == 1L )
    { 
    	FlagKillImporte = FALSE;
    	
    	vDTrazasLog (szExeName,"\n\t *** bfnIncrementarIndicePreFactura: Indicador de Validacion de Importe Activado"
                                "\n\t    stPreFactura.A_PFactura.dImpConcepto[%d][%f] <= (double)stDatosGener.lMontoImporte[%f]"
                                ,LOG05, stPreFactura.iNumRegistros
                                ,stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpConcepto
                                ,(double)(stDatosGener.lMontoImporte));
    	
    	if (stDatosGener.lMontoImporte == 0)
    	{
    		if(stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable == (double)(stDatosGener.lMontoImporte))
    		{
    			FlagKillImporte = TRUE;
    		}
    	}
    	else
    	{
    		if(stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable == 0)
    		{
    			if (stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable == (double)(stDatosGener.lMontoImporte))
    			{
    				FlagKillImporte = TRUE;
    			}
    		}
    		else if(stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable < 0)
    		{
    			if (stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable > (double)(stDatosGener.lMontoImporte))
    			{
    				FlagKillImporte = TRUE;
    			}
    		}
    		else if (stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable > 0)
    		{
    			if (stPreFactura.A_PFactura[stPreFactura.iNumRegistros].dImpFacturable < (double)(stDatosGener.lMontoImporte))
    			{
    				FlagKillImporte = TRUE;
    			}
    		}
    	}
    
    	
    	
    	if(FlagKillImporte)
    	{
    		vDTrazasLog (szExeName,"\n\t *** bfnIncrementarIndicePreFactura: Dentro de abs()", LOG06);
            iCodConcepto = stPreFactura.A_PFactura[stPreFactura.iNumRegistros].iCodConcepto;
    		
    		if (stMaxColPreFa.pConcCol[iCodConcepto].iFlagExiste)
    		{	
    			stMaxColPreFa.pConcCol[iCodConcepto].lColumna   -= 1;
    			
    			if (stMaxColPreFa.pConcCol[iCodConcepto].lColumna   == 0 )
    				stMaxColPreFa.pConcCol[iCodConcepto].iFlagExiste = 0;
    		}
    		else 
    		{
  				stMaxColPreFa.pConcCol[iCodConcepto].lColumna    = 0;
  			}
			
			vfnLimpiarRegs(stPreFactura.iNumRegistros, stPreFactura.iNumRegistros+1); /* JQH */
    		
    		vDTrazasLog (szExeName,"\n\t *** bfnIncrementarIndicePreFactura: Importe Concepto menor o igual al minimo configurado",LOG03);
    		return TRUE;
    	}
    }
    
    if((stPreFactura.iNumRegistros+1) <=  stPreFactura.lCantMaxRegs-1)
    {
        stPreFactura.iNumRegistros++;
        vDTrazasLog (szExeName,"\n\t *** bfnIncrementarIndicePreFactura: Incrementando contador sin realloc()",LOG03);
        return TRUE;            
    }
    
    /* Aumentar Tamanio de Estructura */
    vDTrazasLog (szExeName,"\n\t *** bfnIncrementarIndicePreFactura: Incrementando contador utilizando realloc()",LOG03);
    
    lNuevoTam = stPreFactura.lCantMaxRegs + TAM_INCREMENTO_CONC;
    
    if((A_PFacturaTemp  = (FAPFACTURA*)realloc(stPreFactura.A_PFactura,lNuevoTam * sizeof(FAPFACTURA)))==NULL) 
        return FALSE;
    stPreFactura.A_PFactura = A_PFacturaTemp;
    
    if((A_IndTemp     = (IND_PREFACTURA*)realloc(stPreFactura.A_Ind,lNuevoTam * sizeof(IND_PREFACTURA)))==NULL) 
        return FALSE;
    stPreFactura.A_Ind  = A_IndTemp;
    
    stPreFactura.iNumRegistros++;
    
    stPreFactura.lCantMaxRegs = lNuevoTam;
    
    vfnLimpiarRegs(stPreFactura.iNumRegistros, stPreFactura.lCantMaxRegs);
    
    return TRUE;    
    
    
}


/* Limpiar los registros de la estructura stPreFactura para un rango dado */
void vfnLimpiarRegs(long lRegIni, long lRegFin)
{

   long i = 0;
   
   vDTrazasLog (szExeName,"\n\t *** vfnLimpiarRegs(): lRegIni: [%ld] -  lRegFin: [%ld]",LOG03, lRegIni, lRegFin);
   
   for (i=lRegIni;i<lRegFin;i++)
   {
   
        memset(&stPreFactura.A_PFactura[i],'\0',sizeof(FAPFACTURA));
        memset(&stPreFactura.A_Ind     [i],'\0',sizeof(IND_PREFACTURA));
   
   }

    return;

}


/* -------------------------------------------------------------------------- */
/*   bInsertaAnomProceso (ANOMPROCESO*)                                       */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
/* BOOL bInsertaAnomProceso (ANOMPROCESO* pAnomProc)
{
   EXEC SQL BEGIN DECLARE SECTION;
   static int   ihCodConcepto      ;
   static short shCodProducto      ;
   static long  lhNumAbonado       ;
   static long  lhNumProceso       ;
   static long  lhCodCliente       ;
   static long  lhCodCiclFact      ;
   static int   ihCodAnomalia      ;
   static char  szhDesProceso  [41]; EXEC SQL VAR szhDesProceso  IS STRING (41);
   static char  szhObsAnomalia [61]; EXEC SQL VAR szhObsAnomalia IS STRING (61);
   EXEC SQL END DECLARE SECTION;

   ihCodConcepto  = pAnomProc->iCodConcepto;
   lhNumProceso   = pAnomProc->lNumProceso ;
   lhCodCliente   = pAnomProc->lCodCliente ;
   lhCodCiclFact  = pAnomProc->lCodCiclFact;
   lhNumAbonado   = pAnomProc->lNumAbonado ;
   shCodProducto  = pAnomProc->iCodProducto;
   ihCodAnomalia  = pAnomProc->iCodAnomalia;

   strncpy (szhDesProceso,pAnomProc->szDesProceso,sizeof (szhDesProceso)-1);
   szhDesProceso [strlen (szhDesProceso)] = '\0';

   strncpy (szhObsAnomalia,pAnomProc->szObsAnomalia,sizeof(szhObsAnomalia)-1);
   szhObsAnomalia [strlen (szhObsAnomalia)] = '\0';

   lhNumProceso   = stStatus.IdPro;
   lhCodCliente   = stCliente.lCodCliente;

   vDTrazasLog (szExeName,"\n\t*** Registro insertado en FA_ANOPROCESO ***"
                           "\n\tNumero de Proceso.............. [%ld]"
                           "\n\tCodigo de Cliente.............. [%d] "
                           "\n\tCodigo de Concepto............. [%d] "
                           "\n\tCodigo de Producto............. [%d] "
                           "\n\tCodigo de Ciclo Facturacion.... [%ld]"
                           "\n\tDescripcion del Proceso........ [%s] "
                           "\n\tObservaciones Anomalia......... [%s] "
                           "\n\tNumero de Abonado.............. [%ld]"
                           "\n\tCodigo de Anomalia............. [%d] "
                           ,LOG04,lhNumProceso
                           ,lhCodCliente        ,ihCodConcepto
                           ,shCodProducto       ,lhCodCiclFact
                           ,szhDesProceso       ,szhObsAnomalia
                           ,lhNumAbonado        ,ihCodAnomalia);

   EXEC SQL INSERT INTO FA_ANOPROCESO
                    (NUM_PROCESO ,
                     COD_CLIENTE ,
                     COD_CONCEPTO,
                     COD_PRODUCTO,
                     NUM_ABONADO ,
                     COD_CICLFACT,
                     DES_PROCESO ,
                     OBS_ANOMALIA,
                     COD_ANOMALIA)
         VALUES (:lhNumProceso  ,
                 :lhCodCliente  ,
                 :ihCodConcepto ,
                 :shCodProducto ,
                 :lhNumAbonado  ,
                 :lhCodCiclFact ,
                 :szhDesProceso ,
                 :szhObsAnomalia,
                 :ihCodAnomalia);
    vDTrazasLog ( "" , "Despues del insert." , LOG06 ) ;
    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,
             "Fa_AnoProceso",szfnORAerror ());

    return (SQLCODE != 0)?FALSE:TRUE;
}*//************************** Final bInsertaAnoProceso ************************/

/******************************************************************************
Funcion         :       ifnCompareGeCargosBasico
*******************************************************************************/

static int ifnCompareGeCargosBasico(const void *pvstKey,const void *pvstItem)
{
	CARGOSBASICO *pstKey	= (CARGOSBASICO *) pvstKey;
	CARGOSBASICO *pstItem 	= (CARGOSBASICO *) pvstItem;
	int rc = 0;

  	return ( (rc = strcmp ( pstKey->szCodCargoBasico,
                    	   pstItem->szCodCargoBasico) ) != 0)?rc:0;

}
/*****************************************************************************/
/*                        funcion : bFindCargoBasico                          */
/*****************************************************************************/
BOOL bFindCargoBasico(char *szCodCargoBasico, CARGOSBASICO * pstCargoBasico)
{
  CARGOSBASICO stkey;
  CARGOSBASICO *pCB = (CARGOSBASICO *)NULL;
  BOOL bRes = TRUE;

  	if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
  	{
		strcpy (stkey.szCodCargoBasico, szCodCargoBasico   );
	
	  	if ( (pCB = (CARGOSBASICO *)bsearch(&stkey,pstCargosBasico,NUM_CARGOSBASICO,
	                 sizeof(CARGOSBASICO),ifnCompareGeCargosBasico) )==(CARGOSBASICO *)NULL)
	  	{
	    	iDError (szExeName,ERR021,vInsertarIncidencia,"pstCargosBasico");
	        bRes = FALSE;
	  	}
	  	else
	     	*pstCargoBasico = *pCB;
	}  
  
  return (bRes);

}/************************ Final bFindCargoBasico *****************************/

/**************************************************************************************/
/*  FUNCION : szGetFecZonaImp                                                         */
/*  USO     : Devuelve un puntero a la fecha con la que hay que buscar la zona imposi.*/
/*            Utilizacion de stCiclo estructura global                                */
/**************************************************************************************/
char *szGetFecZonaImp(int iTipoFact)
{
char *szTmp = "";

	if ( stDatosGener.iCodCiclo == iTipoFact )
    {
		szTmp = stCiclo.szFecEmision;
	}else{
		szTmp = szSysDate;
	}
  vDTrazasLog (szExeName,
               "\t\t* Fecha para la Zona Impositiva [%s]\n",LOG05,szTmp);

  return (char *)(szTmp);
}/*************************** Final szGetFecZonaImp **************************/

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
