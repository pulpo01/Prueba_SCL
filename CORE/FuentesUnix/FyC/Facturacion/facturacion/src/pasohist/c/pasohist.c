
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
    "./pc/pasohist.pc"
};


static unsigned int sqlctx = 3459339;


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
   unsigned char  *sqhstv[26];
   unsigned long  sqhstl[26];
            int   sqhsts[26];
            short *sqindv[26];
            int   sqinds[26];
   unsigned long  sqharm[26];
   unsigned long  *sqharc[26];
   unsigned short  sqadto[26];
   unsigned short  sqtdso[26];
} sqlstm = {12,26};

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

 static const char *sq0008 = 
"select ROWID ,SEQ_CUOTAS ,COD_CLIENTE ,COD_CONCEPTO ,COD_MONEDA ,COD_PRODUCT\
O ,NUM_CUOTAS ,IMP_TOTAL ,IND_PAGADA ,NUM_ABONADO ,NUM_VENTA ,NUM_TRANSACCION \
,COD_CUOTA ,NUM_PAGARE ,COD_MODVENTA ,NUM_SERIELE  from FA_CABCUOTAS where IND\
_PAGADA=1           ";

 static const char *sq0019 = 
"select ROWID ,COD_CLIENTE ,NUM_ABONADO ,COD_CICLFACT ,COD_OPERADOR  from TA_\
ACUMLLAMADASROA where NUM_PROCESO=:b0 order by COD_CLIENTE,NUM_ABONADO,COD_CIC\
LFACT,COD_OPERADOR            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,134,0,4,388,0,0,1,0,0,1,0,2,97,0,0,
24,0,0,2,279,0,4,422,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
47,0,0,3,89,0,4,482,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
70,0,0,4,0,0,17,725,0,0,1,1,0,1,0,1,97,0,0,
89,0,0,4,0,0,21,740,0,0,1,1,0,1,0,1,3,0,0,
108,0,0,5,0,0,17,757,0,0,1,1,0,1,0,1,97,0,0,
127,0,0,5,0,0,21,772,0,0,1,1,0,1,0,1,3,0,0,
146,0,0,6,0,0,17,908,0,0,1,1,0,1,0,1,97,0,0,
165,0,0,6,0,0,21,924,0,0,1,1,0,1,0,1,3,0,0,
184,0,0,7,0,0,17,941,0,0,1,1,0,1,0,1,97,0,0,
203,0,0,7,0,0,21,957,0,0,1,1,0,1,0,1,3,0,0,
222,0,0,8,252,0,9,1107,0,0,0,0,0,1,0,
237,0,0,8,0,0,13,1115,0,0,16,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,
316,0,0,9,280,0,3,1156,0,0,15,15,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,
391,0,0,10,42,0,2,1184,0,0,1,1,0,1,0,1,5,0,0,
410,0,0,8,0,0,15,1201,0,0,0,0,0,1,0,
425,0,0,11,230,0,3,1231,0,0,1,1,0,1,0,1,3,0,0,
444,0,0,12,63,0,2,1255,0,0,1,1,0,1,0,1,3,0,0,
463,0,0,13,366,0,3,1291,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
486,0,0,14,73,0,2,1333,0,0,1,1,0,1,0,1,97,0,0,
505,0,0,15,0,0,17,1381,0,0,1,1,0,1,0,1,97,0,0,
524,0,0,15,0,0,21,1397,0,0,1,1,0,1,0,1,3,0,0,
543,0,0,16,0,0,17,1414,0,0,1,1,0,1,0,1,97,0,0,
562,0,0,16,0,0,21,1430,0,0,1,1,0,1,0,1,3,0,0,
581,0,0,17,0,0,17,1561,0,0,1,1,0,1,0,1,97,0,0,
600,0,0,17,0,0,21,1577,0,0,1,1,0,1,0,1,3,0,0,
619,0,0,18,0,0,17,1594,0,0,1,1,0,1,0,1,97,0,0,
638,0,0,18,0,0,21,1610,0,0,1,1,0,1,0,1,3,0,0,
657,0,0,19,184,0,9,1762,0,0,1,1,0,1,0,1,3,0,0,
676,0,0,19,0,0,13,1794,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
711,0,0,19,0,0,15,1832,0,0,0,0,0,1,0,
726,0,0,20,719,0,3,1887,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
761,0,0,21,252,0,2,1949,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
792,0,0,22,428,0,3,2019,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
815,0,0,23,48,0,2,2068,0,0,1,1,0,1,0,1,5,0,0,
834,0,0,24,0,0,17,2157,0,0,1,1,0,1,0,1,97,0,0,
853,0,0,24,0,0,45,2173,0,0,0,0,0,1,0,
868,0,0,24,0,0,13,2181,0,0,1,0,0,1,0,2,3,0,0,
887,0,0,24,0,0,15,2189,0,0,0,0,0,1,0,
902,0,0,25,0,0,17,2213,0,0,1,1,0,1,0,1,97,0,0,
921,0,0,25,0,0,45,2229,0,0,0,0,0,1,0,
936,0,0,25,0,0,13,2237,0,0,1,0,0,1,0,2,3,0,0,
955,0,0,25,0,0,15,2245,0,0,0,0,0,1,0,
970,0,0,26,0,0,17,2268,0,0,1,1,0,1,0,1,97,0,0,
989,0,0,26,0,0,45,2284,0,0,0,0,0,1,0,
1004,0,0,26,0,0,13,2292,0,0,1,0,0,1,0,2,3,0,0,
1023,0,0,26,0,0,15,2300,0,0,0,0,0,1,0,
1038,0,0,27,0,0,17,2381,0,0,1,1,0,1,0,1,97,0,0,
1057,0,0,27,0,0,21,2389,0,0,1,1,0,1,0,1,97,0,0,
1076,0,0,28,66,0,5,2567,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1099,0,0,29,287,0,3,2594,0,0,14,14,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1170,0,0,30,0,0,17,2718,0,0,1,1,0,1,0,1,97,0,0,
1189,0,0,30,0,0,45,2727,0,0,0,0,0,1,0,
1204,0,0,30,0,0,13,2738,0,0,26,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,5,0,0,2,3,0,
0,2,3,0,0,2,5,0,0,2,3,0,0,2,4,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,
1323,0,0,31,0,0,17,2832,0,0,1,1,0,1,0,1,97,0,0,
1342,0,0,31,0,0,21,2840,0,0,25,25,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,4,0,0,1,4,0,0,1,3,0,0,1,5,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,5,0,0,1,3,0,0,1,3,
0,0,1,5,0,0,1,3,0,0,1,4,0,0,1,5,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,
1457,0,0,32,0,0,17,2879,0,0,1,1,0,1,0,1,97,0,0,
1476,0,0,32,0,0,21,2889,0,0,1,1,0,1,0,1,5,0,0,
1495,0,0,33,192,0,4,3031,0,0,4,2,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
1526,0,0,34,135,0,3,3053,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1553,0,0,35,106,0,5,3135,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1580,0,0,36,0,0,17,3183,0,0,1,1,0,1,0,1,97,0,0,
1599,0,0,36,0,0,45,3201,0,0,1,1,0,1,0,1,3,0,0,
1618,0,0,36,0,0,13,3212,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
1645,0,0,36,0,0,15,3253,0,0,0,0,0,1,0,
1660,0,0,37,0,0,17,3290,0,0,1,1,0,1,0,1,97,0,0,
1679,0,0,37,0,0,45,3308,0,0,1,1,0,1,0,1,3,0,0,
1698,0,0,37,0,0,13,3319,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
1725,0,0,37,0,0,15,3380,0,0,0,0,0,1,0,
1740,0,0,38,0,0,17,3415,0,0,1,1,0,1,0,1,97,0,0,
1759,0,0,38,0,0,45,3433,0,0,1,1,0,1,0,1,3,0,0,
1778,0,0,38,0,0,13,3444,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
1805,0,0,38,0,0,15,3484,0,0,0,0,0,1,0,
1820,0,0,39,0,0,17,3521,0,0,1,1,0,1,0,1,97,0,0,
1839,0,0,39,0,0,21,3532,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1866,0,0,40,0,0,17,3561,0,0,1,1,0,1,0,1,97,0,0,
1885,0,0,40,0,0,21,3573,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1912,0,0,39,0,0,17,3616,0,0,1,1,0,1,0,1,97,0,0,
1931,0,0,39,0,0,21,3627,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1962,0,0,40,0,0,17,3666,0,0,1,1,0,1,0,1,97,0,0,
1981,0,0,40,0,0,21,3678,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2012,0,0,41,252,0,3,4116,0,0,1,1,0,1,0,1,3,0,0,
2031,0,0,42,48,0,2,4141,0,0,1,1,0,1,0,1,3,0,0,
2050,0,0,43,75,0,4,4176,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
2073,0,0,44,0,0,17,4227,0,0,1,1,0,1,0,1,97,0,0,
2092,0,0,44,0,0,21,4243,0,0,1,1,0,1,0,1,3,0,0,
2111,0,0,45,0,0,17,4260,0,0,1,1,0,1,0,1,97,0,0,
2130,0,0,45,0,0,21,4276,0,0,1,1,0,1,0,1,3,0,0,
2149,0,0,46,104,0,4,4493,0,0,1,0,0,1,0,2,3,0,0,
2168,0,0,47,0,0,17,4538,0,0,1,1,0,1,0,1,97,0,0,
2187,0,0,47,0,0,21,4551,0,0,1,1,0,1,0,1,3,0,0,
2206,0,0,48,0,0,17,4611,0,0,1,1,0,1,0,1,97,0,0,
2225,0,0,48,0,0,21,4624,0,0,0,0,0,1,0,
2240,0,0,49,71,0,6,4674,0,0,2,2,0,1,0,2,3,0,0,1,3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : pasohist.pc                                              * */
/* *  Paso a Historico de Facturas y su Detalle                          * */
/* *  Autor : Mauricio Villagra V.                                       * */
/* *********************************************************************** */

#define _PASOHIST_PC_

#include "pasohist.h"

static char szUsage[]=
   "\nUso:   pasohist -u Usuario/Password Opciones"
   "\nOPCIONES:                                   "
   "\n -t Cod_TipDocum                            "
   "\n    -c Cod_CiclFact                         "
   "\n    -a [Acumuladores/Facturas]              "
   "\n -i IndOrdenTotal                           "
   "\n -l [Nivel Log]                             ";


char	szModulo[20];
/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

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

/*  */ 
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


/****************************************************************************/
/*      Funcion :   MAIN                                                    */
/****************************************************************************/

int main(int argc, char *argv[])
{
    extern  char *optarg                ;
    char    opt[]="u:t:c:i:a:l:"        ;
    int     iOpt =0                     ;
    char    szUsuario [63] = ""         ;
    char    *psztmp      = ""           ;
    char    szaux     [10]              ;
    BOOL    bOptUsuario = FALSE         ;
    char    *szDirLogs                  ;
    char    *szNomArchivo               ;
    char    szComando[1024] = ""        ;

    BOOL    bOptCiclo   = FALSE         ;
    BOOL    bOptMasivo  = TRUE          ;
    BOOL    bOptRetPasoHist= FALSE      ;

    memset(&stLineaComando, 0   ,sizeof(PASOHISTLINEACOMANDO));
    memset(&stEstPasoHist,  0   ,sizeof(ESTADISTICASPASHIS));
    memset(&stStatus,       '\0',sizeof(STATUS));

	/* Versionamiento */
	/*fprintf (stderr, "Version [%s] con fecha [%s]\n",szVersionActual, szUltimaModificacion);*/
	fprintf(stderr, "\n  pasohist Version [%s] " __DATE__ " " __TIME__ " COL\n\n",szVersionActual);

    while ( (iOpt = getopt(argc,argv, opt)) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
                    if (strlen (optarg))
                    {
                        strcpy(szUsuario, optarg);
                        bOptUsuario = TRUE;
                        fprintf (stdout," -u %s ", szUsuario);
                    }
                    break;
            case 't':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lTipoDocumen = atol(szaux);
                        fprintf (stdout,"-t %ld ", stLineaComando.lTipoDocumen);
                    }
                    break;
            case 'c':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lCodCiclFact = atol(szaux);
                        fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                    }
                    break;
            case 'i':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lIndOrdenTotal = atol(szaux);
                        fprintf (stdout,"-i %ld ", stLineaComando.lIndOrdenTotal );
                    }
                    break;
            case 'a':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        if (strcmp(szaux,"A") == 0 || strcmp(szaux,"F") == 0)
                        {
                            sprintf(stLineaComando.szTipoPasoHis,"%s\0",szaux);
                            fprintf (stdout,"-a %s ", stLineaComando.szTipoPasoHis);
                        }
                    }
                    break;
            case 'l':
                    if (strlen (optarg))
                    {
                        stStatus.LogNivel =
                        (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                        fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                    }
                    break;
        }
    }
    
    if (!bOptUsuario)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return  (2);
    }
    else
    {
       if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
             return (3);
       }
       else
       {
             strncpy (stLineaComando.szUser,szUsuario,psztmp-szUsuario);
             strcpy  (stLineaComando.szPass, psztmp+1)                 ;
       }
    }

    if (stLineaComando.lTipoDocumen == 0)
    {
        if (stLineaComando.lIndOrdenTotal == 0)
        {
            fprintf (stderr, "\n\t# Faltan Parametros de Entrada: \n%s\n", szUsage);
            return 1;
        }
        bOptMasivo = FALSE;
    }
    else
    {
        if (stLineaComando.lTipoDocumen == 2)
        {
            if (stLineaComando.lCodCiclFact == 0)
            {
                fprintf (stderr, "\n\t# Faltan Parametros de Entrada: (CodCiclFact) \n%s\n", szUsage);
                return 1;
            }
            if (strlen(stLineaComando.szTipoPasoHis) == 0)
            {
                fprintf (stderr, "\n\t# Faltan Parametros de Entrada: (Acumuladores/Facturas) \n%s\n", szUsage);
                return 1;
            }
            bOptCiclo = TRUE;
        }
        bOptMasivo  = TRUE;
    }
    if (stStatus.LogNivel <= 0)
        stStatus.LogNivel = iLOGNIVEL_DEF     ;
    stLineaComando.iNivLog = stStatus.LogNivel;


    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return (3);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------\n",
                stLineaComando.szUser);
    }

	
	/* Carga parametros de la estructura pstParamGener */
	if (!bGetParamDecimales() )
        return FALSE;
    
    
    GargaGedParametros();
	
    if (!bGetDatosGener (&stDatosGener, szSysDate))
         return FALSE;

    /**************************************************************************************/
    szDirLogs   =(char *)malloc(1024);
    szNomArchivo=(char *)malloc(128);
    /**************************************************************************************/
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);
    /**************************************************************************************/
    if (bOptCiclo)
        sprintf(stLineaComando.szDirLogs,"%s/pasohist/%ld/",szDirLogs,stLineaComando.lCodCiclFact);
    else
        sprintf(stLineaComando.szDirLogs,"%s/pasohist/NoCiclo/",szDirLogs);


    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );

    if (system (szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /*********************************************************************************************/
    if (bOptCiclo)
    {
        sprintf(szNomArchivo,"%spasohist_%ld_%s",
                              stLineaComando.szDirLogs,stLineaComando.lCodCiclFact,szSysDate);
    }
    else
    {
        if (bOptMasivo)
        {
            sprintf(szNomArchivo,"%spasohist_%ld_%s",
                                 stLineaComando.szDirLogs,stLineaComando.lTipoDocumen,szSysDate);
        }
        else
        {
            sprintf(szNomArchivo,"%spasohist_%ld_%s",
                                    stLineaComando.szDirLogs,stLineaComando.lIndOrdenTotal,szSysDate);
        }
    }
    /*********************************************************************************************/
    sprintf(stStatus.ErrName,"%s.err",szNomArchivo);
    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de error %s\n", stStatus.ErrName);
        return (4);
    }
    /*********************************************************************************************/
    sprintf(stStatus.LogName, "%s.log",szNomArchivo);
    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de log %s\n",stStatus.LogName);
        fclose(stStatus.ErrFile);
        return (5);
    }
    /*********************************************************************************************/
    /* SAAM-20021230 Obtiene indicador de Tasador */


    if (bOptCiclo) /* SAAM-20030220 Nos aseguramos que es solo para ciclos */
    {
       if (bObtieneIndicadorTasador(stLineaComando.lCodCiclFact)== FALSE)
       {
          fprintf(stderr,"\n ** Error: No puede Obtener el tipo de tasador\n");
          fclose(stStatus.ErrFile);
          return (4);
       }

       if ((stLineaComando.ihIndTasador!=TIPO_TASA_CLASICA)&&(stLineaComando.ihIndTasador!=TIPO_TASA_ON_LINE))
       {
          fprintf(stderr,"\n ** Error: Tasador No corresponde a [0,1] <TASACION CLASICA,TASACION ON LINE>\n");
          fclose(stStatus.ErrFile);
          return (4);
       }
    }

    vDTrazasError(szPasar,  "\n\n\t*************************************"
                              "\n\t****     Errores de pasohist       **"
                              "\n\t*************************************"
                            ,LOG03);

    vDTrazasLog(szPasar,    "\n\n\t*************************************"
                              "\n\t****        Log   pasohist         **"
                              "\n\t*************************************"
                            ,LOG03);
    /*********************************************************************************************/
	/*Version */
	vDTrazasLog   (szPasar, "Version [%s] con fecha [%s]\n",LOG03,szVersionActual, szUltimaModificacion);
    /*********************************************************************************************/

    vDTrazasLog(szPasar,
                            "\n\t\t***  Parametro de Entrada pasohist  ***"
                            "\n\t\t=> Usuario       [%s]"
                            "\n\t\t=> Password      [************]"
                            "\n\t\t=> Cod.TipDocum  [%ld]"
                            "\n\t\t=> Cod.CiclFact  [%ld]"
                            "\n\t\t=> IndOrdenTotal [%ld]"
                            "\n\t\t=> Tipo Tasacion [%d]"
                            "\n\t\t=> Niv.Log       [%d]",
                            LOG05,
                            stLineaComando.szUser,
                            stLineaComando.lTipoDocumen,
                            stLineaComando.lCodCiclFact,
                            stLineaComando.lIndOrdenTotal,
                            stLineaComando.ihIndTasador,
                            stLineaComando.iNivLog);



    if (bOptCiclo)
    {
        bOptRetPasoHist = bfnPasoHistCiclo (stLineaComando.lCodCiclFact, stLineaComando.szTipoPasoHis);
    }

    if(!bOptRetPasoHist)
    {
        fnOraRollBack();
        vDTrazasError(szPasar,  " \n\t------------------------------------"
                                " \n\tProceso Terminado de Forma Irregular"
                                " \n\t------------------------------------"
                                ,LOG03);
        vDTrazasLog(szPasar,    " \n\t------------------------------------"
                                " \n\tProceso Terminado de Forma Irregular"
                                " \n\t------------------------------------"
                                ,LOG03);
        return 3;
    }
    else
    {
        vDTrazasLog  (szPasar,  "\n\t**  Estadisticas de Paso a Historico  **"
                                "\n\t\t\t=> Cantidad de Facturas    :[%d]"
                                "\n\t\t\t=> Cantidad de Clientes    :[%d]"
                                "\n\t\t\t=> Cantidad de Abonados    :[%d]"
                                "\n\t\t\t=> Cantidad de Conceptos   :[%d]"
                                "\n\t****************************************"
                                "****************************************"
                                " \n\t------------------------------------"
                                " \n\tProceso Terminado Correctamente"
                                " \n\t------------------------------------"
                                ,LOG03
                                ,stEstPasoHist.lNumFacturas
                                ,stEstPasoHist.lNumClientes
                                ,stEstPasoHist.lNumAbonados
                                ,stEstPasoHist.lNumConceptos );

        vDTrazasError(szPasar,  " \n\t------------------------------------"
                                " \n\tProceso Terminado Correctamente"
                                " \n\t------------------------------------"
                                ,LOG03);
        if ( !bfnOraCommit())
        {

            vDTrazasLog(szPasar,    " \n\t------------------------------------"
                                    " \n\tFallo en el Commit"
                                    " \n\t------------------------------------"
                                    ,LOG03);
            vDTrazasError(szPasar,  " \n\t------------------------------------"
                                    " \n\tFallo en el Commit"
                                    " \n\t------------------------------------"
                                    ,LOG03);
            return 4;
        }

    }

    if(bfnDisconnectORA(0))
    {
      vDTrazasLog(szPasar,  "\n\t--------------------------------------------"
                            "\n\tDesconectado de  ORACLE"
                            "\n\t--------------------------------------------"
                            ,LOG03);
      vDTrazasError(szPasar,"\n\t--------------------------------------------"
                            "\n\tDesconectado de  ORACLE"
                            "\n\t--------------------------------------------"
                            ,LOG03);

    }
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    return (0);
}/* ********************* Fin Main * *************************************** */


/****************************************************************************/
/*      Funcion :   int GargaGedParametros( void )                          */
/****************************************************************************/

int GargaGedParametros( void )
{
/* Modificación Proyecto Ecu-05002 Codigo de Autorización.
   Se agrega SQL para obtener el campo para saber si aplica el codigo de autorizacion. 
   Las variables del select into estan definidas en el ImpSclSt.h. Se modifica el SQL 
   para que en este mismo se rescate el valor de la tabla y saber si aplica el cod 
   autorizacion (se agrega alias F para ged_parametros).
*/
    strcpy (szModulo, "GargaGedParametros");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);

    /* EXEC SQL
    SELECT VAL_PARAMETRO
      INTO :szAplica_Cod_Autorizacion
      FROM GED_PARAMETROS
      WHERE NOM_PARAMETRO = 'APLICA_CODAUTORIZA'
       AND COD_MODULO = 'FA'
       AND COD_PRODUCTO = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
((NOM_PARAMETRO='APLICA_CODAUTORIZA' and COD_MODULO='FA') and COD_PRODUCTO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szAplica_Cod_Autorizacion;
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


       
    if (sqlca.sqlcode != SQLOK )
    {
        vDTrazasLog(szModulo, "PasoHist Error en SELECT de GargaGedParametros [%d]", LOG02, sqlca.sqlcode);
        return (FALSE);
    }
    return (TRUE);
}/*************************** END GargaGedParametros **************************/

/****************************************************************************/
/*      Funcion :   int szfnObtieneCod_autorizacion (long	lCodCiclo)  */
/****************************************************************************/

int szfnObtieneCod_autorizacion (long	lCodCiclo)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhCodCiclFact;
	/* EXEC SQL END DECLARE SECTION; */ 

	
    strcpy (szModulo, "ObtieneCod_autorizacion");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);
    printf("\nEn funcion ObtieneCod_autorizacion");
    
    lhCodCiclFact = lCodCiclo;
    
    vDTrazasLog(szModulo,"\tlhCodCiclFact [%ld] ",LOG04,lhCodCiclFact);
    
    /* EXEC SQL
    SELECT COD_AUTORIZACION
      INTO :szCod_Autorizacion
      FROM AL_AUTORIZACION_FOLIO_TD A, FA_CICLFACT B, GED_CODIGOS C
     WHERE B.COD_CICLFACT = :lhCodCiclFact
       AND B.FEC_EMISION BETWEEN A.FEC_DESDE AND A.FEC_TERMINO
       AND C.COD_MODULO= 'AL'
       AND C.NOM_TABLA = 'AL_AUTORIZACION_FOLIO_TD'
       AND A.COD_SISTEMA = C.COD_VALOR; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_AUTORIZACION into :b0  from AL_AUTORIZACION_FO\
LIO_TD A ,FA_CICLFACT B ,GED_CODIGOS C where ((((B.COD_CICLFACT=:b1 and B.FEC_\
EMISION between A.FEC_DESDE and A.FEC_TERMINO) and C.COD_MODULO='AL') and C.NO\
M_TABLA='AL_AUTORIZACION_FOLIO_TD') and A.COD_SISTEMA=C.COD_VALOR)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCod_Autorizacion;
    sqlstm.sqhstl[0] = (unsigned long )11;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


       
    /*COD_TIPDOC = :pstTipDocum.stTipDocum
    AND COD_SISTEMA = <PARAMETRO EN GED_PARAMETRO>
    AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA;*/
 
    if (sqlca.sqlcode != SQLOK )
    {
        vDTrazasLog(szModulo, "Error en SELECT de ObtieneCod_autorizacion [%d]", LOG02, sqlca.sqlcode);
        return (FALSE);
    }
    return (TRUE);
     
}/*************************** END szfnObtieneCod_autorizacion **************************/

/***********************************************************************************/
/*      Funcion :   BOOL bfnPasoHistCiclo ( long lCodCiclFact, char * szTipPasHis) */
/***********************************************************************************/
/* * Funcion bfnPasoHistCiclo                                                    * */
/* * Realizamos las Llamadas a las siguientes funciones:                         * */
/* * Paso a Cargos                                                               * */
/* * Paso de Arriendos                                                           * */
/* * Paso de Penalizaciones                                                      * */
/* * Paso de Acumulados de Llamadas                                              * */
/* * Paso de Cuotas                                                              * */
/* ******************************************************************************* */

BOOL bfnPasoHistCiclo ( long lCodCiclFact, char * szTipPasHis)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCiclParam        ;
    long lhNumProceso       ;
    /* EXEC SQL END DECLARE SECTION; */ 


    char    szFecha [20]     ="";

    vDTrazasLog ( szPasar , "\n\t Entrada en bfnPasoHistCiclo "
                            "\n\t => Cod_CiclFact ... [%ld]"
                            "\n\t => Tipo de Paso ... [%s]"
                            , LOG05,lCodCiclFact,szTipPasHis);


    lhCiclParam = lCodCiclFact;

    /************************************************************************************/
    /************************************************************************************/
    /*                              PASO HISTORICO DE ACUMULADORES                      */
    /************************************************************************************/
    /************************************************************************************/
    if (strcmp(szTipPasHis,"A") == 0 )
    {
        /* EXEC SQL    SELECT NUM_PROCESO
                    INTO   :lhNumProceso
                    FROM   FA_PROCESOS
                    WHERE  COD_TIPDOCUM =  2               /o   Factura de Ciclo  o/
                    AND    COD_CICLFACT = :lhCiclParam; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NUM_PROCESO into :b0  from FA_PROCESOS where (\
COD_TIPDOCUM=2 and COD_CICLFACT=:b1)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )47;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCiclParam;
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



        if(SQLCODE == SQLNOTFOUND)
        {
            vDTrazasLog  (szPasar,  "\n\t**  No Existen Datos en FA_PROCESOS **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lhCiclParam);
            vDTrazasError(szPasar,  "\n\t**  No Existen Datos en FA_PROCESOS  **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lhCiclParam);
            return (FALSE);
        }
        if(SQLCODE != SQLOK)
        {
            vDTrazasError(szPasar,  "\n\t**  Error en Select sobre FA_PROCESOS (Cod_CiclFact) **"
                                    ,LOG01,lhCiclParam);
            vDTrazasLog  (szPasar,  "\n\t**  Error en Select sobre FA_PROCESOS (Cod_CiclFact) **"
                                    ,LOG01,lhCiclParam);
            return (FALSE);
        }


        if ( lhNumProceso > 0 )
        {
            /****************************************************************************/
            /*  Valida Estado del Proceso de Paso Histrocio de Acumuladores y Conceptos */
            /****************************************************************************/
            if (!bfnValidaTrazaProc(lCodCiclFact, iPROC_PASOHISTO, iIND_FACT_ENPROCESO))
            {
                return FALSE;
            }
            if(!fnOraCommit())
            {
                vDTrazasLog  (szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
                vDTrazasError(szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
                return (FALSE);
            }
            /* ************************************************************************* */
            if (!bfnSelectSysDate(szFecha))
                return (FALSE);
            /* ************************************************************************* */
            bfnSelectTrazaProc ( lCodCiclFact, iPROC_PASOHISTO, &stTrazaProc);
            bPrintTrazaProc(stTrazaProc);

            /* ************************************************************************* */
            /* * Se actualizan las estadisticas ciclo de consumo mensual del cliente   * */
            /* ************************************************************************* */
            if (!bfnUpdateConsMensClie  ())
                return FALSE;
            /* ************************************************************************* */

            if (!bfnDBPasarCargosConProceso (lhNumProceso))
                return FALSE;

            if (!bfnDBPasarPenalizacionesConProceso (lhNumProceso))
                return FALSE;

            if (!bfnDBPasarAllCuotas ())
                return FALSE;

            if (!bfnDBPasarArriendo ())
                return FALSE;

            if (stLineaComando.ihIndTasador == TIPO_TASA_CLASICA)
            {
                if ( !bfnDBPasarAireFraSocConProceso (stDatosGener.iProdCelular, lhNumProceso))
                    return FALSE;

                if ( !bfnDBPasarOperConProceso (stDatosGener.iProdCelular, lhNumProceso))
                    return FALSE;

                if ( !bfnDBPasarRoamingConProceso (stDatosGener.iProdCelular, lhNumProceso, lCodCiclFact, szFecha))
                     return FALSE;
            }
            if (stLineaComando.ihIndTasador == TIPO_TASA_ON_LINE)
            {
                if ( !bfnDBPasarTolAcumOper(stDatosGener.iProdCelular, lhNumProceso))
                    return FALSE;

/*              <Debe incluirse Funcion para Roamin TOL>                */
            }



            if (!bfnInsertFahBalance(lCodCiclFact))
                return FALSE;

            if (!bfnSelectSysDate(szFecha))
                vDTrazasLog(szPasar ,"\n\t*** Error en bfnSelectSysDate (bfnPasoHistCiclo) ***\n",LOG01);
            else
            {
                stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
                strcpy(stTrazaProc.szFecTermino,szFecha)                              ;
                strcpy(stTrazaProc.szGlsProceso,"Paso Historico Acumuladores-Conceptos OK");
                stTrazaProc.lCodCliente        = 0                                      ;
                stTrazaProc.lNumAbonado        = 0                                      ;
                stTrazaProc.lNumRegistros      = 0                                      ;
                bPrintTrazaProc(stTrazaProc);

                if (!bfnUpdateTrazaProc(stTrazaProc))
                    return (FALSE);
                else if(!fnOraCommit())
                {
                    vDTrazasLog  (szPasar , "ERROR AL HACER EL COMMIT EN bfnUpdateTrazaProc ",LOG01, SQLERRM);
                    vDTrazasError(szPasar , "ERROR AL HACER EL COMMIT EN bfnUpdateTrazaProc ",LOG01, SQLERRM);
                    return (FALSE);
                }
            }
        }
    }
    /************************************************************************************/
    /************************************************************************************/
    /*                              PASO HISTORICO DE FACTURAS                          */
    /************************************************************************************/
    /************************************************************************************/
    else if (strcmp(szTipPasHis,"F") == 0 )
    {
        /****************************************************************************/
        /*  Valida Estado del Proceso de Paso Historico de Facturas y Detalle       */
        /****************************************************************************/
        if (!bfnValidaTrazaProc(lCodCiclFact, iPROC_PASOHISTO_FACT, iIND_FACT_ENPROCESO))
        {
           return (FALSE);
        }
        else if(!fnOraCommit())
        {
            vDTrazasLog  (szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            vDTrazasError(szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            return (FALSE);
        }

        bfnSelectTrazaProc ( lCodCiclFact, iPROC_PASOHISTO_FACT, &stTrazaProc);
        bPrintTrazaProc(stTrazaProc);

        if (!bfnDBPasarFacturas(lCodCiclFact))
        {
            return (FALSE);
        }

        if (!bfnSelectSysDate(szFecha))
            vDTrazasLog(szPasar ,"\n\t*** Error en bfnSelectSysDate (bfnPasoHistCiclo) ***\n",LOG01);
        else
        {
            stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
            strcpy(stTrazaProc.szFecTermino,szFecha)                                ;
            strcpy(stTrazaProc.szGlsProceso,"Paso Historico de Facturas OK")        ;
            stTrazaProc.lCodCliente        = 0                                      ;
            stTrazaProc.lNumAbonado        = 0                                      ;
            stTrazaProc.lNumRegistros      = 0                                      ;
            bPrintTrazaProc(stTrazaProc)                                            ;
            if (!bfnUpdateTrazaProc(stTrazaProc))
                return (FALSE);
        }
        /************************************************************************************/
        /************************************************************************************/
        /*                              PASO CONSUMO CICLO CLIENTES                         */
        /************************************************************************************/
        /************************************************************************************/

        /****************************************************************************/
        /*  Valida Estado del Proceso de Paso Consumo Ciclo                         */
        /****************************************************************************/
        if (!bfnValidaTrazaProc(lCodCiclFact, iPROC_PASOCONSUMO_FACT, iIND_FACT_ENPROCESO))
        {
           return (FALSE);
        }
        else if(!fnOraCommit())
        {
            vDTrazasLog  (szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            vDTrazasError(szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            return (FALSE);
        }    
        
        bfnSelectTrazaProc ( lCodCiclFact, iPROC_PASOCONSUMO_FACT, &stTrazaProc);
        bPrintTrazaProc(stTrazaProc);    
 
        if (!bfnPrincipalPasoConsumoCiclo( lCodCiclFact ))
        {
            return (FALSE);
        }
    
        if (!bfnSelectSysDate(szFecha))
        {
            vDTrazasLog(szPasar ,"\n\t*** Error en bfnSelectSysDate (bfnPrincipalPasoConsumoCiclo) ***\n",LOG01);
        }
        else
        {
            stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
            strcpy(stTrazaProc.szFecTermino,szFecha)                                ;
            strcpy(stTrazaProc.szGlsProceso,"Paso Consumo Ciclo OK")                ;
            stTrazaProc.lCodCliente        = 0                                      ;
            stTrazaProc.lNumAbonado        = 0                                      ;
            stTrazaProc.lNumRegistros      = 0                                      ;
            bPrintTrazaProc(stTrazaProc)                                            ;
            if (!bfnUpdateTrazaProc(stTrazaProc))
                return (FALSE);
        }
        
        /* se cambia de posicion */
        
        if (!bfnInsertFaEnlaceHist(lCodCiclFact))
            return (FALSE);
    
    }
    else
    {
        return FALSE;
    }
 
    
    return TRUE;
}/* **************************** * END bfnPasoHistCiclo * ***************************** */


/****************************************************************************/
/*      Funcion :   BOOL bfnDBPasarCargosConProceso( long lNumProceso )     */
/****************************************************************************/
/* * Funcion bfnDBPasarCargosConProceso ( )                               * */
/* * Pasamos datos de la tabla GE_CARGOS --> FA_HISTCARGOS                * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de   * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con el * */
/* * Numero de Factura = lNumProceso                                      * */
/* ************************************************************************ */

BOOL bfnDBPasarCargosConProceso( long lNumProceso )
{
    char    szCadenaInsert[2048]="";
    char    szCadenaDelete[2048]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;


    vDTrazasLog ( szPasar,  "\n\t\t\t Entrada en bfnDBPasarCargosConProceso "
                            "\n\t\t\t\t => NumProceso .. [%ld]"
                            , LOG05,lNumProceso);

    vfnInitCadenaInsertCargos(szCadenaInsert,lNumProceso);
    vfnInitCadenaDeleteCargos(szCadenaDelete,lNumProceso);


    /* EXEC SQL PREPARE sql_insert_cargos FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )70;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )2048;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_insert_cargos  USING    :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )89;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_cargos FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )108;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )2048;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Delete  CARGOS**"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Delete  CARGOS**"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_delete_cargos  USING       :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )127;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Delete CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Delete CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    vDTrazasLog(szPasar," \n\t\t\t\t   Estadisticas  GE_CARGOS "
                        " \n\t\t\t\t    Filas Insertadas     [%ld]      "
                        " \n\t\t\t\t    Filas Borradas       [%ld]      "
                        " \n\t\t\t\t------------------------------------",
                        LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t------------------------------------"
                                " \n\tFallo en el Commit GE_CARGOS        "
                                " \n\t------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t------------------------------------"
                                " \n\tFallo en el Commit GE_CARGOS        "
                                " \n\t------------------------------------",
                                LOG01);
        return (FALSE);
    }
    return (TRUE);
}/* **************** * END bfnDBPasarCargosConProceso * ******************** */

/************************************************************************************/
/*      Funcion :   void vfnInitCadenaInsertCargos (char * szCadena, long lpNumProc)*/
/************************************************************************************/
/* * Inicilaiza Sql para Insertar Cargos en Historico                             * */
/* ******************************************************************************** */

void vfnInitCadenaInsertCargos (char * szCadena, long lpNumProc)
{
    sprintf(szCadena,
        "INSERT INTO FA_HISTCARGOS ( "
                "NUM_CARGO        , COD_CLIENTE      , "
                "COD_PRODUCTO     , COD_CONCEPTO     , "
                "FEC_ALTA         , IMP_CARGO        , "
                "COD_MONEDA       , COD_PLANCOM      , "
                "NUM_UNIDADES     , IND_FACTUR       , "
                "NUM_TRANSACCION  , NUM_VENTA        , "
                "NUM_PAQUETE      , NUM_ABONADO      , "
                "NUM_TERMINAL     , COD_CICLFACT     , "
                "NUM_SERIE        , NUM_SERIEMEC     , "
                "CAP_CODE         , MES_GARANTIA     , "
                "NUM_PREGUIA      , NUM_GUIA         , "
                "NUM_FACTURA      , NUM_PROCESO      , "
                "COD_CONCEPTO_DTO , VAL_DTO          , "
                "TIP_DTO          , IND_CUOTA        , "
                "IND_SUPERTEL     , NOM_USUARIO      ) "
        "SELECT "
                "NUM_CARGO        , COD_CLIENTE      , "
                "COD_PRODUCTO     , COD_CONCEPTO     , "
                "FEC_ALTA         , IMP_CARGO        , "
                "COD_MONEDA       , COD_PLANCOM      , "
                "NUM_UNIDADES     , IND_FACTUR       , "
                "NUM_TRANSACCION  , NUM_VENTA        , "
                "NUM_PAQUETE      , NUM_ABONADO      , "
                "NUM_TERMINAL     , COD_CICLFACT     , "
                "NUM_SERIE        , NUM_SERIEMEC     , "
                "CAP_CODE         , MES_GARANTIA     , "
                "NUM_PREGUIA      , NUM_GUIA         , "
                "NUM_FACTURA      , NUM_FACTURA      , "
                "COD_CONCEPTO_DTO , VAL_DTO          , "
                "TIP_DTO          , IND_CUOTA        , "
                "IND_SUPERTEL     , NOM_USUARORA       "
        "FROM    GE_CARGOS "
        "WHERE   NUM_FACTURA %s :lNumProceso ",(lpNumProc==0?">":"="));
    return;
}/*************************** END vfnInitCadenaInsertCargos **************************/

/************************************************************************************/
/*      Funcion :   void vfnInitCadenaDeleteCargos (char * szCadena, long lpNumProc)*/
/************************************************************************************/
/* * Inicilaiza Sql para Delete de Cargos en Historico                            * */
/* ******************************************************************************** */

void vfnInitCadenaDeleteCargos (char * szCadena, long lpNumProc)
{
    sprintf(szCadena,
            "DELETE "
            "FROM    GE_CARGOS "
            "WHERE   NUM_FACTURA %s :lNumProceso ",(lpNumProc==0?">":"="));
    return;
}/*************************** END vfnInitCadenaDeleteCargos **************************/

/********************************************************************************/
/*      Funcion :   BOOL bfnDBPasarPenalizacionesConProceso ( long lNumProceso) */
/********************************************************************************/
/* * Pasamos datos de la tabla FA_PENALIZACIONES --> FA_HISTPENALIZACIONES    * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de       * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con la     * */
/* * NUM_PROCESO = lhNumProceso                                               * */
/* **************************************************************************** */

BOOL bfnDBPasarPenalizacionesConProceso ( long lNumProceso)
{

    char    szCadenaInsert[1024]="";
    char    szCadenaDelete[1024]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (szPasar,  "\n\t*************************************************"
                            "****************************************************"
    						"\n\t\t\t**  Paso Historico Penalizaciones **"
    						"\n\t*************************************************"
                            "****************************************************",LOG03);

    vDTrazasLog ( szPasar,  "\n\t Entrada en bfnDBPasarPenalizacionesConProceso  "
                            "\n\t => NumProceso .. [%ld]"
                            , LOG05,lNumProceso);

    vfnInitCadenaInsertPenali(szCadenaInsert,lNumProceso);
    vfnInitCadenaDeletePenali(szCadenaDelete,lNumProceso);

    /* EXEC SQL PREPARE sql_insert_penaliza FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )146;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_penaliza    USING    :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )165;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,   "\n\t**  Error en SQL-EXECUTE Insert PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_penaliza FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )184;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Delete PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Delete PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_penaliza    USING       :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )203;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Delete PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Delete PENALIZACIONES **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    vDTrazasLog(szPasar," \n\t\t\t   Estadisticas  CA_PENALIZACIONES "
                        " \n\t\t\t    Filas Insertadas     [%ld]      "
                        " \n\t\t\t    Filas Borradas       [%ld]      "
                        " \n\t\t\t------------------------------------",
                        LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit CA_PENALIZACIONES     "
                                " \n\t-----------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit CA_PENALIZACIONES     "
                                " \n\t-----------------------------------------",
                                LOG01);
        return (FALSE);
    }
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return (TRUE);
}/* ******************* * End bfnDBPasarPenalizaciones * ******************* */

/*************************************************************************************/
/*      Funcion :   void vfnInitCadenaInsertPenali (char * szCadena, long lpNumProc) */
/*************************************************************************************/
/* * Inicilaiza Sql para Insertar Penalizaciones en Historico                      * */
/* ********************************************************************************* */

void vfnInitCadenaInsertPenali (char * szCadena, long lpNumProc)
{
    sprintf(szCadena,
        "INSERT INTO FA_HISTPENAL ( "
        "        NUM_PENALIZ     ,  COD_CLIENTE     , "
        "        TIP_INCIDENCIA  ,  FEC_EFECTIVIDAD , "
        "        COD_MONEDA      ,  IMP_PENALIZA    , "
        "        COD_CONCEPTO    ,  COD_PRODUCTO    , "
        "        NUM_PROCESO     ,  COD_CICLFACT    , "
        "        NUM_ABONADO     ,  FEC_VALOR "
        "                              ) "
        "SELECT  NUM_PENALIZ     ,  COD_CLIENTE     , "
        "        TIP_INCIDENCIA  ,  FEC_EFECTIVIDAD , "
        "        COD_MONEDA      ,  IMP_PENALIZ     , "
        "        COD_CONCEPTO    ,  COD_PRODUCTO    , "
        "        NUM_PROCESO     ,  COD_CICLFACT    , "
        "        NUM_ABONADO     ,  SYSDATE           "
        "FROM    CA_PENALIZACIONES "
        "WHERE   NUM_PROCESO %s :lhNumProceso ",(lpNumProc==0?">":"="));
}

/*************************************************************************************/
/*      Funcion :   void vfnInitCadenaDeletePenali (char * szCadena, long lpNumProc) */
/*************************************************************************************/
/* * Inicilaiza Sql para Deletar Penalizaciones en Historico                       * */
/* ********************************************************************************* */

void vfnInitCadenaDeletePenali (char * szCadena, long lpNumProc)
{
    sprintf(szCadena,
            "DELETE "
            "FROM    CA_PENALIZACIONES "
            "WHERE   NUM_PROCESO %s :lhNumProceso ",(lpNumProc==0?">":"="));
}

/*****************************************************************************/
/*      Funcion :   BOOL bfnDBPasarAllCuotas( void )                         */
/*****************************************************************************/
/* * Pasamos datos de la tabla FA_CABCUOTAS --> FA_HISTCABCUOTAS           * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de    * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con el  * */
/* * Indicador de Pago actrivado en 1                                      * */
/* ************************************************************************* */

BOOL bfnDBPasarAllCuotas( void )
{
    BOOL bFinCursor        = FALSE;

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    short    i_shCodModVenta      ;
    short    i_shNumSerieEle      ;
    char     szhRowid         [20]; /* EXEC SQL VAR szhRowid         IS STRING(20); */ 

    long     lhSeqCuotas          ;
    long     lhCodcliente         ;
    int      ihCodConcepto        ;
    char     szhCodMoneda      [3]; /* EXEC SQL VAR szhCodMoneda      IS STRING(3); */ 

    int      ihCodProducto        ;
    int      ihNumCuotas          ;
    double   dhImpTotal           ;
    int      ihIndPagada          ;
    long     lhNumAbonado         ;
    long     lhNumVenta           ;
    long     lhNumTransaccion     ;
     char     szhCodCuota       [2]; /* EXEC SQL VAR szhCodCuota        IS STRING(2); */ 

    long     lhNumPagare          ;
    int      ihCodModVenta        ;
    char     szhNumSerieEle   [26]; /* EXEC SQL VAR szhNumSerieEle    IS STRING(26); */ 

    /* EXEC SQL END DECLARE SECTION  ; */ 


    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************"
    					  "\n\t\t\t**  Paso Historico Cuotas **"
    					  "\n\t****************************************"
                              "****************************************",LOG03);

    vDTrazasLog ( szPasar, "\n\t Entrada en bfnDBPasarAllCuotas" , LOG05);

    /* EXEC SQL DECLARE Cur_CabCuotas CURSOR FOR
        SELECT
                ROWID           ,
                SEQ_CUOTAS      ,
                COD_CLIENTE     ,
                COD_CONCEPTO    ,
                COD_MONEDA      ,
                COD_PRODUCTO    ,
                NUM_CUOTAS      ,
                IMP_TOTAL       ,
                IND_PAGADA      ,
                NUM_ABONADO     ,
                NUM_VENTA       ,
                NUM_TRANSACCION ,
                COD_CUOTA       ,
                NUM_PAGARE      ,
                COD_MODVENTA    ,
                NUM_SERIELE
        FROM    FA_CABCUOTAS
        WHERE   IND_PAGADA = 1; */ 


    /* EXEC SQL OPEN Cur_CabCuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0008;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )222;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
        vDTrazasError(szPasar, "\n\n\tError al abrir el Cursor sobre FA_CABCUOTAS : %s", LOG01, SQLERRM);
        return FALSE;
    }
    do
    {
        /* EXEC SQL FETCH Cur_CabCuotas INTO
            :szhRowid             ,
            :lhSeqCuotas                   ,
            :lhCodcliente                  ,
            :ihCodConcepto                 ,
            :szhCodMoneda                  ,
            :ihCodProducto                 ,
            :ihNumCuotas                   ,
            :dhImpTotal                    ,
            :ihIndPagada                   ,
            :lhNumAbonado                  ,
            :lhNumVenta                    ,
            :lhNumTransaccion             ,
            :szhCodCuota                   ,
            :lhNumPagare                   ,
            :ihCodModVenta :i_shCodModVenta,
            :szhNumSerieEle:i_shNumSerieEle; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )237;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[0] = (unsigned long )20;
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
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodcliente;
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
        sqlstm.sqhstl[4] = (unsigned long )3;
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
        sqlstm.sqhstv[8] = (unsigned char  *)&ihIndPagada;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
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
        sqlstm.sqhstv[10] = (unsigned char  *)&lhNumVenta;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&lhNumTransaccion;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szhCodCuota;
        sqlstm.sqhstl[12] = (unsigned long )2;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&lhNumPagare;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&ihCodModVenta;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)&i_shCodModVenta;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)szhNumSerieEle;
        sqlstm.sqhstl[15] = (unsigned long )26;
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)&i_shNumSerieEle;
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


        if((SQLCODE == SQLNOTFOUND))
        {
             bFinCursor = TRUE;
        }
        else
        {
            if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
            {
                vDTrazasError(szPasar, "\n\n\tError en el fetch del Cursor FA_CABCUOTAS : %s", LOG01, SQLERRM);
                return FALSE;
            }

            if (i_shCodModVenta == ORA_NULL )
            {
               ihCodModVenta = 0;
            }
            if (i_shNumSerieEle == ORA_NULL )
            {
               strcpy ( szhNumSerieEle , "" );
            }

            /**************************************
                INSERT ------ FA_HISTCABCUOTAS
            **************************************/
             /* EXEC SQL
                INSERT INTO FA_HISTCABCUOTAS    (
                        SEQ_CUOTAS       ,   COD_CLIENTE      ,
                        COD_CONCEPTO     ,   COD_MONEDA       ,
                        COD_PRODUCTO     ,   NUM_CUOTAS       ,
                        IMP_TOTAL        ,   IND_PAGADA       ,
                        NUM_ABONADO      ,   NUM_VENTA        ,
                        NUM_TRANSACCION  ,   COD_CUOTA        ,
                        NUM_PAGARE       ,   COD_MODVENTA     ,
                        NUM_SERIELE      )
                VALUES                          (
                        :lhSeqCuotas     ,   :lhCodcliente    ,
                        :ihCodConcepto   ,   :szhCodMoneda    ,
                        :ihCodProducto   ,   :ihNumCuotas     ,
                        :dhImpTotal      ,   :ihIndPagada     ,
                        :lhNumAbonado    ,   :lhNumVenta      ,
                        :lhNumTransaccion,   :szhCodCuota     ,
                        :lhNumPagare     ,   :ihCodModVenta   ,
                        :szhNumSerieEle  ); */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 16;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.stmt = "insert into FA_HISTCABCUOTAS (SEQ_CUOTAS,COD_CLI\
ENTE,COD_CONCEPTO,COD_MONEDA,COD_PRODUCTO,NUM_CUOTAS,IMP_TOTAL,IND_PAGADA,NUM_\
ABONADO,NUM_VENTA,NUM_TRANSACCION,COD_CUOTA,NUM_PAGARE,COD_MODVENTA,NUM_SERIEL\
E) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14)";
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )316;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqhstv[0] = (unsigned char  *)&lhSeqCuotas;
             sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[0] = (         int  )0;
             sqlstm.sqindv[0] = (         short *)0;
             sqlstm.sqinds[0] = (         int  )0;
             sqlstm.sqharm[0] = (unsigned long )0;
             sqlstm.sqadto[0] = (unsigned short )0;
             sqlstm.sqtdso[0] = (unsigned short )0;
             sqlstm.sqhstv[1] = (unsigned char  *)&lhCodcliente;
             sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
             sqlstm.sqhstv[3] = (unsigned char  *)szhCodMoneda;
             sqlstm.sqhstl[3] = (unsigned long )3;
             sqlstm.sqhsts[3] = (         int  )0;
             sqlstm.sqindv[3] = (         short *)0;
             sqlstm.sqinds[3] = (         int  )0;
             sqlstm.sqharm[3] = (unsigned long )0;
             sqlstm.sqadto[3] = (unsigned short )0;
             sqlstm.sqtdso[3] = (unsigned short )0;
             sqlstm.sqhstv[4] = (unsigned char  *)&ihCodProducto;
             sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
             sqlstm.sqhsts[4] = (         int  )0;
             sqlstm.sqindv[4] = (         short *)0;
             sqlstm.sqinds[4] = (         int  )0;
             sqlstm.sqharm[4] = (unsigned long )0;
             sqlstm.sqadto[4] = (unsigned short )0;
             sqlstm.sqtdso[4] = (unsigned short )0;
             sqlstm.sqhstv[5] = (unsigned char  *)&ihNumCuotas;
             sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
             sqlstm.sqhsts[5] = (         int  )0;
             sqlstm.sqindv[5] = (         short *)0;
             sqlstm.sqinds[5] = (         int  )0;
             sqlstm.sqharm[5] = (unsigned long )0;
             sqlstm.sqadto[5] = (unsigned short )0;
             sqlstm.sqtdso[5] = (unsigned short )0;
             sqlstm.sqhstv[6] = (unsigned char  *)&dhImpTotal;
             sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
             sqlstm.sqhsts[6] = (         int  )0;
             sqlstm.sqindv[6] = (         short *)0;
             sqlstm.sqinds[6] = (         int  )0;
             sqlstm.sqharm[6] = (unsigned long )0;
             sqlstm.sqadto[6] = (unsigned short )0;
             sqlstm.sqtdso[6] = (unsigned short )0;
             sqlstm.sqhstv[7] = (unsigned char  *)&ihIndPagada;
             sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
             sqlstm.sqhsts[7] = (         int  )0;
             sqlstm.sqindv[7] = (         short *)0;
             sqlstm.sqinds[7] = (         int  )0;
             sqlstm.sqharm[7] = (unsigned long )0;
             sqlstm.sqadto[7] = (unsigned short )0;
             sqlstm.sqtdso[7] = (unsigned short )0;
             sqlstm.sqhstv[8] = (unsigned char  *)&lhNumAbonado;
             sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[8] = (         int  )0;
             sqlstm.sqindv[8] = (         short *)0;
             sqlstm.sqinds[8] = (         int  )0;
             sqlstm.sqharm[8] = (unsigned long )0;
             sqlstm.sqadto[8] = (unsigned short )0;
             sqlstm.sqtdso[8] = (unsigned short )0;
             sqlstm.sqhstv[9] = (unsigned char  *)&lhNumVenta;
             sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[9] = (         int  )0;
             sqlstm.sqindv[9] = (         short *)0;
             sqlstm.sqinds[9] = (         int  )0;
             sqlstm.sqharm[9] = (unsigned long )0;
             sqlstm.sqadto[9] = (unsigned short )0;
             sqlstm.sqtdso[9] = (unsigned short )0;
             sqlstm.sqhstv[10] = (unsigned char  *)&lhNumTransaccion;
             sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[10] = (         int  )0;
             sqlstm.sqindv[10] = (         short *)0;
             sqlstm.sqinds[10] = (         int  )0;
             sqlstm.sqharm[10] = (unsigned long )0;
             sqlstm.sqadto[10] = (unsigned short )0;
             sqlstm.sqtdso[10] = (unsigned short )0;
             sqlstm.sqhstv[11] = (unsigned char  *)szhCodCuota;
             sqlstm.sqhstl[11] = (unsigned long )2;
             sqlstm.sqhsts[11] = (         int  )0;
             sqlstm.sqindv[11] = (         short *)0;
             sqlstm.sqinds[11] = (         int  )0;
             sqlstm.sqharm[11] = (unsigned long )0;
             sqlstm.sqadto[11] = (unsigned short )0;
             sqlstm.sqtdso[11] = (unsigned short )0;
             sqlstm.sqhstv[12] = (unsigned char  *)&lhNumPagare;
             sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[12] = (         int  )0;
             sqlstm.sqindv[12] = (         short *)0;
             sqlstm.sqinds[12] = (         int  )0;
             sqlstm.sqharm[12] = (unsigned long )0;
             sqlstm.sqadto[12] = (unsigned short )0;
             sqlstm.sqtdso[12] = (unsigned short )0;
             sqlstm.sqhstv[13] = (unsigned char  *)&ihCodModVenta;
             sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
             sqlstm.sqhsts[13] = (         int  )0;
             sqlstm.sqindv[13] = (         short *)0;
             sqlstm.sqinds[13] = (         int  )0;
             sqlstm.sqharm[13] = (unsigned long )0;
             sqlstm.sqadto[13] = (unsigned short )0;
             sqlstm.sqtdso[13] = (unsigned short )0;
             sqlstm.sqhstv[14] = (unsigned char  *)szhNumSerieEle;
             sqlstm.sqhstl[14] = (unsigned long )26;
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



            if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
            {
                vDTrazasError(szPasar,  "\n\n\tError en el INSERT de FA_HISTCABCUOTAS "
                                        "\n\t Error [%d] [%s] "
                                        , LOG01, SQLCODE, SQLERRM);
                return FALSE;
            }

            /* EXEC SQL
               DELETE
               FROM FA_CABCUOTAS
               WHERE   ROWID  = :szhRowid; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 16;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "delete  from FA_CABCUOTAS  where ROWID=:b0";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )391;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
            sqlstm.sqhstl[0] = (unsigned long )20;
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


            if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
            {
                vDTrazasError(szPasar,  "\n\n\tError en el DELETE de FA_CABCUOTAS "
                                        "\n\t Error [%d] [%s] "
                                        , LOG01, SQLCODE, SQLERRM);
                return FALSE;
            }
            if ( !bfnDBPasarCuotas ( lhSeqCuotas ) )
               return FALSE;
        }

    } while(!bFinCursor);

    /* EXEC SQL CLOSE Cur_CabCuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )410;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
       vDTrazasError(szPasar, "\n\n\tError al cerrar el Cursor sobre FA_CABCUOTAS : %s", LOG01, SQLERRM);
       return FALSE;
    }
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return TRUE;
}/* ********************* *  END bfnDBPasarAllCuotas() * *********************** */

/*****************************************************************************/
/*      Funcion :   BOOL bfnDBPasarCuotas(long lSeqCuotas)                   */
/*****************************************************************************/
/* * Pasamos datos de la tabla FA_CUOTAS--> FA_HISTCUOTAS                  * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de    * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con la  * */
/* *                                                                       * */
/* ************************************************************************* */

BOOL bfnDBPasarCuotas(long lSeqCuotas)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long   lhSeqCuotas;
    /* EXEC SQL END   DECLARE SECTION; */ 


    vDTrazasLog ( szPasar, "\n\t Parametros de Entrada en bfnDBCuotas"
                         , LOG05, lSeqCuotas);

    lhSeqCuotas  =         lSeqCuotas ;
    /* EXEC SQL
        INSERT INTO FA_HISTCUOTAS   (
                SEQ_CUOTAS    ,             ORD_CUOTA     ,
                FEC_EMISION   ,             IMP_CUOTA     ,
                IND_FACTURADO ,             IND_PAGADO    )
        SELECT  SEQ_CUOTAS    ,             ORD_CUOTA     ,
                FEC_EMISION   ,             IMP_CUOTA     ,
                IND_FACTURADO ,             IND_PAGADO
        FROM    FA_CUOTAS
        WHERE   IND_PAGADO =            1
        AND     SEQ_CUOTAS = :lhSeqCuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_HISTCUOTAS (SEQ_CUOTAS,ORD_CUOTA,FEC_EMISI\
ON,IMP_CUOTA,IND_FACTURADO,IND_PAGADO)select SEQ_CUOTAS ,ORD_CUOTA ,FEC_EMISIO\
N ,IMP_CUOTA ,IND_FACTURADO ,IND_PAGADO  from FA_CUOTAS where (IND_PAGADO=1 an\
d SEQ_CUOTAS=:b0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )425;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
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



    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
         vDTrazasError ( szPasar , "\n\t Insert FA_CUOTAS-> FA_HISTCUOTAS"
                                        "\n\t Error [%d] [%s] "
                                        , LOG01, SQLCODE, SQLERRM);
         return FALSE;
    }

    if ( SQLCODE == SQLOK )
    {
        vDTrazasLog ( szPasar, "\n\t Parametros de Entrada (bfnDBDeleteCuotas)", LOG05);

        /* EXEC SQL
            DELETE
            FROM    FA_CUOTAS
            WHERE   IND_PAGADO  = 1
            AND     SEQ_CUOTAS  = :lhSeqCuotas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from FA_CUOTAS  where (IND_PAGADO=1 and SEQ_C\
UOTAS=:b0)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )444;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
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



        if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
            vDTrazasError ( szPasar, "\n\t Delete FA_CUOTAS  "
                                        "\n\t Error [%d] [%s] "
                                        , LOG01, SQLCODE, SQLERRM);
            return FALSE;
        }
    }
    return TRUE;
}/* ******************* * END bfnDBPasarCuotas * *************************** */

/*****************************************************************************/
/*      Funcion :   BOOL bfnDBPasarArriendo( void )                          */
/*****************************************************************************/
/* * Pasamos datos de la tabla FA_ARRIENDOS --> FA_HISTARRIENDOS           * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de    * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con la  * */
/* * FECHA_HASTA < FECHA SYSTEMA                                           * */
/* ************************************************************************* */

BOOL bfnDBPasarArriendo( void )
{
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************"
    					  "\n\t\t\t**  Paso Historico Arriendos **"
    					  "\n\t****************************************"
                              "****************************************",LOG03);


    vDTrazasLog ( szPasar, "\n\t Entrada en bfnDBPasarArriendos" , LOG05);
    /* EXEC SQL
        INSERT INTO FA_HISTARRIENDO (
                COD_CLIENTE                    ,
                NUM_ABONADO                    ,
                FEC_DESDE                      ,
                FEC_HASTA                      ,
                COD_PRODUCTO                   ,
                COD_CONCEPTO                   ,
                COD_ARTICULO                   ,
                PRECIO_MES                     ,
                FEC_HISTORICO                  ,
                COD_MONEDA)
        SELECT
                COD_CLIENTE                    ,
                NUM_ABONADO                    ,
                FEC_DESDE                      ,
                FEC_HASTA                      ,
                COD_PRODUCTO                   ,
                COD_CONCEPTO                   ,
                COD_ARTICULO                   ,
                PRECIO_MES                     ,
                TO_DATE (:szSysDate,'YYYYMMDDHH24MISS'),
                COD_MONEDA
        FROM    FA_ARRIENDO
        WHERE   FEC_HASTA < TO_DATE(:szSysDate,'YYYYMMDDHH24MISS'); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_HISTARRIENDO (COD_CLIENTE,NUM_ABONADO,FEC_\
DESDE,FEC_HASTA,COD_PRODUCTO,COD_CONCEPTO,COD_ARTICULO,PRECIO_MES,FEC_HISTORIC\
O,COD_MONEDA)select COD_CLIENTE ,NUM_ABONADO ,FEC_DESDE ,FEC_HASTA ,COD_PRODUC\
TO ,COD_CONCEPTO ,COD_ARTICULO ,PRECIO_MES ,TO_DATE(:b0,'YYYYMMDDHH24MISS') ,C\
OD_MONEDA  from FA_ARRIENDO where FEC_HASTA<TO_DATE(:b0,'YYYYMMDDHH24MISS')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )463;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSysDate;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szSysDate;
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



    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasError ( szPasar , "\n\t Insert FA_ARRIENDO--> FA_HISTARRIENDO"
                                        "\n\t Error [%d] [%s] "
                                        , LOG01, SQLCODE, SQLERRM);
        return FALSE;
    }

    if ( SQLCODE == SQLNOTFOUND )
    {
        return TRUE;
    }
    else
    {
        vDTrazasLog ( szPasar, "\n\t Parametros de Entrada (bfnDBDeleteArriendos)", LOG05);

        /* EXEC SQL
            DELETE
            FROM    FA_ARRIENDO
            WHERE   FEC_HASTA <  TO_DATE (:szSysDate,'YYYYMMDDHH24MISS'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from FA_ARRIENDO  where FEC_HASTA<TO_DATE(:b0\
,'YYYYMMDDHH24MISS')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )486;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szSysDate;
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



        if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasError ( szPasar, "\n\t Delete FA_ARRIENDO   "
                                        "\n\t Error [%d] [%s] "
                                        , LOG01, SQLCODE, SQLERRM);
            return FALSE;
        }
    }
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return TRUE;
}/* ******************* * END bfnDBPasarArriendo * ************************* */

/*******************************************************************************************/
/*      Funcion :   BOOL bfnDBPasarAireFraSocConProceso ( int iProducto ,long lNumProceso )*/
/*******************************************************************************************/
/* * Pasamos datos de la tabla TA_AIREFRASOC --> FA_HISTACUMLLAM                         * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de                  * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con                   * */
/* * NUM_PROCESO igual al Pasado como parametro en la funcion                            * */
/* *************************************************************************************** */

BOOL bfnDBPasarAireFraSocConProceso ( int iProducto ,long lNumProceso )
{
    char    szCadenaInsert[1024]="";
    char    szCadenaDelete[1024]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************"
    					  "\n\t\t\t**  Paso Historico AcumAirerasoc ==>  FA_HISTACUMLLAM **"
    					  "\n\t****************************************"
                              "****************************************",LOG03);

    vDTrazasLog ( szPasar,  "\n\t Entrada en bfnDBPasarAireFraSocConProceso  "
                            "\n\t => NumProceso .. [%ld]"
                            , LOG05,lNumProceso);

    vfnInitCadenaInsertAireFrasoc(szCadenaInsert,iProducto,lNumProceso);
    vfnInitCadenaDeleteAireFrasoc(szCadenaDelete,lNumProceso);

    /* EXEC SQL PREPARE sql_insert_airefrasoc FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )505;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_airefrasoc  USING    :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )524;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,   "\n\t**  Error en SQL-EXECUTE Insert AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_airefrasoc FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )543;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Delete AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Delete AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_airefrasoc  USING       :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )562;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Delete AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Delete AIREFRASOC **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    vDTrazasLog(szPasar," \n\t\t\t   Estadisticas  TA_ACUMAIREFRASOC  "
                        " \n\t\t\t    Filas Insertadas     [%ld]      "
                        " \n\t\t\t    Filas Borradas       [%ld]      "
                        " \n\t\t\t------------------------------------",
                        LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit TA_ACUMAIREFRASOC     "
                                " \n\t-----------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit TA_ACUMAIREFRASOC     "
                                " \n\t-----------------------------------------",
                                LOG01);
        return (FALSE);
    }
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return (TRUE);
}/* ******************* * END bfnDBPasarAireFraSocConProceso * *********************** */

/*****************************************************************************************************/
/*      Funcion :   void vfnInitCadenaInsertAireFrasoc(char *szCadena, int iProducto,long lpNumProc) */
/*****************************************************************************************************/
/* * Inicilaiza Sql para Insertar TA_ACUMAIREFRASOC en Historico                                   * */
/* ************************************************************************************************* */

void vfnInitCadenaInsertAireFrasoc(char *szCadena, int iProducto,long lpNumProc)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTACUMLLAM ( "
            "        NUM_ABONADO      ,    "
            "        COD_CICLFACT     ,    "
            "        COD_TARIFICACION ,    " /* COD_FRANHORASOC        */
            "        NUM_PULSOS       ,    "
            "        IND_ENTSAL       ,    "
            "        IMP_CONSUMIDO    ,    "
            "        SEG_CONSUMIDO    ,    "
            "        COD_CLIENTE      ,    "
            "        NUM_PROCESO      ,    "
            "        FEC_EFECTIVIDAD  ,    "
            "        COD_PRODUCTO     ,    "
            "        IND_TABLA        )    " /* En ESTE CASO SERA  = 1 */
            "SELECT                        "
            "        NUM_ABONADO      ,    "
            "        COD_CICLFACT     ,    "
            "        COD_FRANHORASOC  ,    "
            "        0                ,    "
            "        IND_ENTSAL       ,    "
            "        IMP_CONSUMIDO    ,    "
            "        SEG_CONSUMIDO    ,    "
            "        COD_CLIENTE      ,    "
            "        NUM_PROCESO      ,    "
            "        SYSDATE          ,    "
            "        %d               ,    "
            "        1                     "
            "FROM    TA_ACUMAIREFRASOC     "
            "WHERE   NUM_PROCESO %s :lhNumProceso ",iProducto,(lpNumProc==0?">":"="));
    return;
}/*************************** END vfnInitCadenaInsertAireFrasoc **************************/

/***************************************************************************************/
/*      Funcion :   void vfnInitCadenaDeleteAireFrasoc(char *szCadena, long lpNumProc) */
/***************************************************************************************/
/* * Inicilaiza Sql para Deletear TA_ACUMAIREFRASOC en Historico                     * */
/* *********************************************************************************** */

void vfnInitCadenaDeleteAireFrasoc(char *szCadena, long lpNumProc)
{
    sprintf(szCadena,
            "DELETE "
            "FROM TA_ACUMAIREFRASOC "
            "WHERE NUM_PROCESO %s :lhNumProceso ",(lpNumProc==0?">":"="));
    return;
}/*************************** END vfnInitCadenaDeleteAireFrasoc **************************/

/***************************************************************************************/
/*      Funcion :   void vfnInitCadenaDeleteAireFrasoc(char *szCadena, long lpNumProc) */
/***************************************************************************************/
/* * Pasamos datos de la tabla TA_ACUMOPER --> FA_HISTACUMLLAM                       * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de              * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con el            * */
/* * NUM_PROCESO =   al Num Proceso pasado en la funcion                             * */
/* *********************************************************************************** */

BOOL bfnDBPasarOperConProceso ( int iProducto , long lNumProceso )
{
    char    szCadenaInsert[1024]="";
    char    szCadenaDelete[1024]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************"
    					  "\n\t\t\t**  Paso Historico AcumOper  ==>  FA_HISTACUMLLAM **"
    					  "\n\t****************************************"
                              "****************************************",LOG03);

    vDTrazasLog ( szPasar,  "\n\t Entrada en bfnDBPasarOperConProceso  "
                            "\n\t => NumProceso .. [%ld]"
                            , LOG05,lNumProceso);

    vfnInitCadenaInsertOper(szCadenaInsert,iProducto,lNumProceso);
    vfnInitCadenaDeleteOper(szCadenaDelete,lNumProceso);

    /* EXEC SQL PREPARE sql_insert_acumoper FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )581;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_acumoper    USING    :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )600;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,   "\n\t**  Error en SQL-EXECUTE Insert OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_acumoper FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )619;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Delete OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Delete OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_acumoper    USING       :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )638;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Delete OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Delete OPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    vDTrazasLog(szPasar," \n\t\t\t   Estadisticas  TA_ACUMOPER        "
                        " \n\t\t\t    Filas Insertadas     [%ld]      "
                        " \n\t\t\t    Filas Borradas       [%ld]      "
                        " \n\t\t\t------------------------------------",
                        LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit TA_ACUMOPER           "
                                " \n\t-----------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit TA_ACUMOPER           "
                                " \n\t-----------------------------------------",
                                LOG01);
        return (FALSE);
    }
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return (TRUE);
}/* ******************* * END bfnDBPasarOperConProceso * ******************* */

/************************************************************************************************/
/*      Funcion :   void vfnInitCadenaInsertOper(char *szCadena, int iProducto, long lpNumProc) */
/************************************************************************************************/
/* * Inicilaiza Sql para Insertar TA_ACUMOPER en Historico                                    * */
/* ******************************************************************************************** */

void vfnInitCadenaInsertOper(char *szCadena, int iProducto, long lpNumProc)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTACUMLLAM ( "
            "        NUM_ABONADO       , "
            "        COD_CICLFACT      , "
            "        COD_TARIFICACION  , "
            "        IMP_CONSUMIDO     , "
            "        SEG_CONSUMIDO     , "
            "        NUM_PULSOS        , "
            "        COD_CLIENTE       , "
            "        NUM_PROCESO       , "
            "        COD_PRODUCTO      , "
            "        FEC_EFECTIVIDAD   , "
            "        IND_ENTSAL        , "
            "        IND_TABLA         ) "
            "SELECT  NUM_ABONADO       , "
            "        COD_CICLFACT      , "
            "        COD_OPERADOR      , "
            "        IMP_CONSUMIDO     , "
            "        SEG_CONSUMIDO     , "
            "        NUM_PULSOS        , "
            "        COD_CLIENTE       , "
            "        NUM_PROCESO       , "
            "        %d                , "
            "        SYSDATE           , "
            "        2                 , "                      /* Llamada Saliente */
            "        2 "
            "FROM    TA_ACUMOPER "
            "WHERE   NUM_PROCESO %s :lhNumProceso ",iProducto,(lpNumProc==0?">":"="));
    return;
}/*************************** END vfnInitCadenaInsertOper **************************/

/*********************************************************************************/
/*      Funcion :   void vfnInitCadenaDeleteOper(char *szCadena, long lpNumProc) */
/*********************************************************************************/
/* * Inicilaiza Sql para Deletear TA_ACUMOPER en Historico                     * */
/* ***************************************************************************** */

void vfnInitCadenaDeleteOper(char *szCadena, long lpNumProc)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    TA_ACUMOPER "
        "WHERE   NUM_PROCESO %s :lhNumProceso ",(lpNumProc==0?">":"="));
    return;
}/*************************** END vfnInitCadenaDeleteOper **************************/

/********************************************************************************************************************/
/*Funcion : BOOL bfnDBPasarRoamingConProceso ( int iProducto , long lNumProceso, long lCiclParam, char * spzFecha ) */
/********************************************************************************************************************/
/*Proceso que Pasa a Historico Llamadas Roaming                                                                     */
/********************************************************************************************************************/

BOOL bfnDBPasarRoamingConProceso ( int iProducto , long lNumProceso, long lCiclParam, char * spzFecha )
{

    BOOL bFinCursor_cTaAcumRoaming = FALSE ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    /* DATOS DE TA_ACUMLLAMADASROA */

    long lhCiclParam        ;
    long lhNumProceso       ;
    char szhRowid       [20];   /* EXEC SQL VAR szhRowid         IS STRING(20); */ 

    long lhCodCliente       ;
    long lhNumAbonado       ;
    long lhCodCiclFact      ;
    long lhCodOperador      ;

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (szPasar,	"\n\t****************************************"
                              "****************************************"
    					  	"\n\t\t\t**  Paso Historico Roaming  ==>  FA_HISTACUMLLAM **"
    					  	"\n\t****************************************"
                              "****************************************"
    					  	"\n\t\t* Parametros Entrada (bfnPasHistRoaming)"
                            "\n\t\t\t---------------------------------------------"
                            "\n\t\t\t=> Numero de Proceso   [%d]                  "
                            ,LOG03,lNumProceso);

    /****************************************************************************/
    /*  Declara Cursor sobre TA_ACUMLLAMADASROA                                 */
    /****************************************************************************/
    lhCiclParam  = lCiclParam ;
    lhNumProceso = lNumProceso;
    bFinCursor_cTaAcumRoaming  = FALSE;

    /* EXEC SQL DECLARE cTaAcumRoaming CURSOR FOR
            SELECT  ROWID           ,
                    COD_CLIENTE     ,
                    NUM_ABONADO     ,
                    COD_CICLFACT    ,
                    COD_OPERADOR
            FROM    TA_ACUMLLAMADASROA
            WHERE   NUM_PROCESO         = :lhNumProceso
            ORDER BY COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, COD_OPERADOR; */ 


    /* EXEC SQL OPEN cTaAcumRoaming; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szPasar,  "\n\t** No Existen Datos en TA_ACUMLLAMADASROA Facturados **"
                                "\n\t\t=> Numero de Proceso     [%ld]"
                                ,LOG01,lhNumProceso);
        vDTrazasError(szPasar,  "\n\t** No Existen Datos en TA_ACUMLLAMADASROA Facturados **"
                                "\n\t\t=> Numero de Proceso     [%ld]"
                                ,LOG01,lhNumProceso);

        return (TRUE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szPasar,  "\n\t**  Error en Select sobre TA_ACUMLLAMADASROA **"
                                "\n\t\t=> Numero de Proceso     [%ld]"
                                ,LOG01,lhNumProceso);
        vDTrazasError(szPasar,  "\n\t**  Error en Select sobre TA_ACUMLLAMADASROA **"
                                "\n\t\t=> Numero de Proceso     [%ld]"
                                ,LOG01,lhNumProceso);
        return (FALSE);
    }

    /****************************************************************************/
    /*  Recorre Cursor de TA_ACUMLLAMADASROA                                    */
    /****************************************************************************/

    do
    {
        /* INIZIALIZAMOS LAS VARIABLES HOST */

        /* EXEC SQL FETCH  cTaAcumRoaming
                INTO    :szhRowid       ,
                        :lhCodCliente   ,
                        :lhNumAbonado   ,
                        :lhCodCiclFact  ,
                        :lhCodOperador  ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )676;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[0] = (unsigned long )20;
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhCodOperador;
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



       if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szPasar, "Error en Cursor  de TA_ACUMLLAMADASROA : %s", LOG01, SQLERRM);
            vDTrazasError(szPasar, "Error en Cursor  de TA_ACUMLLAMADASROA : %s", LOG01, SQLERRM);
            return (FALSE);
        }
        if( SQLCODE == SQLNOTFOUND )
        {
            vDTrazasLog  (szPasar,  "\n\t** No Existen Mas Clientes en TA_ACUMLLAMADASROA **"
                                    "\n\t\t=> Numero de Proceso     [%ld]"
                                    ,LOG03,lhNumProceso);
            bFinCursor_cTaAcumRoaming  = TRUE;
        }
        else
        {
            if (!bfnPasaDetalleRoaming  (lhCodCliente,lhNumAbonado,lhCodCiclFact,lhCodOperador,lhCiclParam))
                return(FALSE);

            if (!bfnPasaAcumRoaming  (szhRowid,spzFecha))
                return(FALSE);

            if(!fnOraCommit())
            {
                vDTrazasLog  (szPasar, "** ERROR EN COMMIT TA_ACUMLLAMADASROA **",LOG01, SQLERRM);
                vDTrazasError(szPasar, "** ERROR EN COMMIT TA_ACUMLLAMADASROA **",LOG01, SQLERRM);
                return (FALSE);
            }
            lTotClientesRoa++ ;
        }  /*  else  Do FETCH  */
    } while(!bFinCursor_cTaAcumRoaming);

    /* EXEC SQL CLOSE cTaAcumRoaming; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
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



    vDTrazasLog(szPasar,"\n\t*** Termino de Proceso Paso Historico de Roaming ***\n"
    					"\n\t** ESTADISTICAS DEL PROCESO PASO HISTORICO ROAMING"
                        "\n\t\t==>  [%10ld] Clientes - Ciclo Procesadas "
                        "\n\t\t==>  [%10ld] Llamadas Procesadas         "
                        "\n\t\t==>  [%10ld] Llamadas Correctas          "
                        "\n\t\t==>  [%10ld] Llamadas Errores            "
                        "\n\t****************************************"
                              "****************************************",
                        LOG03,lTotClientesRoa,lTotLlamadasRoa,lLlamadasOKRoa,lLlamadasErrRoa);

   return (TRUE);
}/*************************** END bfnDBPasarRoamingConProceso **************************/

/************************************************************************************/
/*      Funcion : BOOL bfnPasaDetalleRoaming(  long lCodCliente,long lNumAbonado,   */
/*                                             long lCodCiclFact,long lCodOperador, */
/*                                             long lCicloReal)                     */
/************************************************************************************/
/*  Proceso que Pasa a Historico Detalle de Llamadas Roaming                        */
/************************************************************************************/

BOOL bfnPasaDetalleRoaming(  long lCodCliente,long lNumAbonado,
                             long lCodCiclFact,long lCodOperador,
                             long lCicloReal)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long lhCodCliente           ;
    long lhCodOperador          ;
    long lhNumAbonado           ;
    long lhCodCiclFact          ;
    long lhCodCiclFact_Real     ;

    /* EXEC SQL END DECLARE SECTION; */ 


    long    lFilasInsert    =0  ;
    long    lFilasDelete    =0  ;

    lhCodCliente            = lCodCliente                   ;
    lhNumAbonado            = lNumAbonado                   ;
    lhCodOperador           = lCodOperador                  ;
    lhCodCiclFact           = lCodCiclFact                  ;
    lhCodCiclFact_Real      = lCicloReal;


    vDTrazasLog(szPasar,"\n\t** Parametros de Entrada a bfnPasaDetalleRoaming **"
                                "\n\t\t==>  Codigo Cliente              [%ld]"
                                "\n\t\t==>  Numero Abonado              [%ld]"
                                "\n\t\t==>  Codigo Ciclo Facturacion    [%ld]"
                                "\n\t\t==>  Codigo de Operador          [%ld]"
                                "\n\t\t==>  Ciclo Real de Facturacion   [%ld]"
                                ,LOG05,lCodCliente,lNumAbonado,lCodCiclFact,lCodOperador,lCicloReal);

    /* EXEC SQL
    INSERT INTO FA_LLAMADASROA (
            COD_CLIENTE     ,
            NUM_ABONADO     ,
            COD_CICLFACT    ,
            NUM_MOVIL       ,
            NUM_ASIGNADO    ,
            FEC_LLAMADA     ,
            HOR_LLAMADA     ,
            SEG_AIRE        ,
            SEG_DURA        ,
            IMP_MONTOLARGA  ,
            IMP_MONTOAIRE   ,
            NUM_DESTINO     ,
            IND_ENTSAL      ,
            IND_LARGA       ,
            DES_DESTINO     ,
            NUM_BLOQUE      ,
            SEC_LLAMADAS    )
    SELECT  LLA.COD_CLIENTE     ,
            LLA.NUM_ABONADO     ,
            :lhCodCiclFact_Real ,
            LLA.NUM_MOVIL       ,
            LLA.NUM_ASIGNADO    ,
            LLA.FEC_LLAMADA     ,
            LLA.HOR_LLAMADA     ,
            LLA.SEG_AIRE        ,
            LLA.SEG_DURA        ,
            LLA.IMP_MONTOLARGA  ,
            LLA.IMP_MONTOAIRE   ,
            LLA.NUM_DESTINO     ,
            LLA.IND_ENTSAL      ,
            LLA.IND_LARGA       ,
            LLA.DES_DESTINO     ,
            LLA.NUM_BLOQUE      ,
            LLA.SEC_LLAMADAS
    FROM    TA_LLAMADASROA      LLA,
            TA_CONCILIACION     CON
    WHERE   LLA.COD_CLIENTE  = :lhCodCliente
    AND     LLA.NUM_ABONADO  = :lhNumAbonado
    AND     LLA.COD_CICLFACT = :lhCodCiclFact
    AND     LLA.NUM_BLOQUE   = CON.NUM_BLOQUE
    AND     CON.COD_OPERADOR = :lhCodOperador
    AND     CON.IND_OPERACION = 0; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_LLAMADASROA (COD_CLIENTE,NUM_ABONADO,COD_C\
ICLFACT,NUM_MOVIL,NUM_ASIGNADO,FEC_LLAMADA,HOR_LLAMADA,SEG_AIRE,SEG_DURA,IMP_M\
ONTOLARGA,IMP_MONTOAIRE,NUM_DESTINO,IND_ENTSAL,IND_LARGA,DES_DESTINO,NUM_BLOQU\
E,SEC_LLAMADAS)select LLA.COD_CLIENTE ,LLA.NUM_ABONADO ,:b0 ,LLA.NUM_MOVIL ,LL\
A.NUM_ASIGNADO ,LLA.FEC_LLAMADA ,LLA.HOR_LLAMADA ,LLA.SEG_AIRE ,LLA.SEG_DURA ,\
LLA.IMP_MONTOLARGA ,LLA.IMP_MONTOAIRE ,LLA.NUM_DESTINO ,LLA.IND_ENTSAL ,LLA.IN\
D_LARGA ,LLA.DES_DESTINO ,LLA.NUM_BLOQUE ,LLA.SEC_LLAMADAS  from TA_LLAMADASRO\
A LLA ,TA_CONCILIACION CON where (((((LLA.COD_CLIENTE=:b1 and LLA.NUM_ABONADO=\
:b2) and LLA.COD_CICLFACT=:b3) and LLA.NUM_BLOQUE=CON.NUM_BLOQUE) and CON.COD_\
OPERADOR=:b4) and CON.IND_OPERACION=0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )726;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact_Real;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodOperador;
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




    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-INSERT FA_LLAMADASAROA **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-INSERT FA_LLAMADASAROA **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL
    DELETE
    FROM    TA_LLAMADASROA  A
    WHERE   A.COD_CLIENTE  = :lhCodCliente
    AND     A.NUM_ABONADO  = :lhNumAbonado
    AND     A.COD_CICLFACT = :lhCodCiclFact
    AND     A.NUM_BLOQUE in (   SELECT B.NUM_BLOQUE
                                FROM   TA_CONCILIACION B
                                WHERE  B.COD_OPERADOR   = :lhCodOperador
                                AND    B.IND_OPERACION  = 0
                                AND    B.NUM_BLOQUE     = A.NUM_BLOQUE); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from TA_LLAMADASROA A  where (((A.COD_CLIENTE=:b0\
 and A.NUM_ABONADO=:b1) and A.COD_CICLFACT=:b2) and A.NUM_BLOQUE in (select B.\
NUM_BLOQUE  from TA_CONCILIACION B where ((B.COD_OPERADOR=:b3 and B.IND_OPERAC\
ION=0) and B.NUM_BLOQUE=A.NUM_BLOQUE)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )761;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodOperador;
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



    if ((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-DELETE TA_LLAMADASAROA **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-DELETE TA_LLAMADASAROA **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);


    vDTrazasLog(szPasar," \n\t\t\t   Estadisticas  TA_LLAMADASROA     "
                                " \n\t\t\t    Filas Insertadas     [%ld]      "
                                " \n\t\t\t    Filas Borradas       [%ld]      "
                                " \n\t\t\t------------------------------------",
                                LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    lTotLlamadasRoa +=  lFilasInsert    ;
    lLlamadasOKRoa  +=  lFilasInsert    ;
    return (TRUE);
}/*************************** END bfnPasaDetalleRoaming **************************/


/*********************************************************************************/
/*      Funcion : BOOL bfnPasaAcumRoaming  (char szRowId[20], char * szFechaHoy) */
/*********************************************************************************/
/*  Proceso que Pasa a Historico Acumuladores de Llamadas Roaming                */
/*********************************************************************************/

BOOL bfnPasaAcumRoaming  (char szRowId[20], char * szFechaHoy)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    char szhRowid       [20];   /* EXEC SQL VAR szhRowid         IS STRING(20); */ 

    char szhFecSysdate  [20];   /* EXEC SQL VAR szhFecSysdate    IS STRING(20); */ 


    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhRowid, szRowId);
    strcpy(szhFecSysdate, szFechaHoy);

    vDTrazasLog(szPasar,"\n\t** Parametros de Entrada a bfnPasaAcumRoaming **"
                                "\n\t\t==>  RowId           [%s]"
                                ,LOG05,szRowId);


    /* EXEC SQL
    INSERT INTO FA_HISTACUMLLAM (
            NUM_ABONADO         ,
            COD_CICLFACT        ,
            IND_ENTSAL          ,   /o  2 Salida        o/
            COD_TARIFICACION    ,   /o  Cod. Operador   o/
            IND_TABLA           ,   /o  3 Roaming       o/
            COD_PRODUCTO        ,   /o  1 Celular       o/
            IMP_CONSUMIDO       ,
            SEG_CONSOPER        ,
            IMP_CONSOPER        ,
            SEG_CONSUMIDO       ,
            NUM_PULSOS          ,   /o  0 No tiene      o/
            FEC_EFECTIVIDAD     ,
            NUM_PROCESO         ,
            COD_CLIENTE         )
    SELECT  NUM_ABONADO         ,
            COD_CICLFACT        ,
            2                   ,
            COD_OPERADOR        ,
            3                   ,
            1                   ,
            IMP_CONSUMIDO       ,
            SEG_CONSUMIDO       ,
            IMP_CONSUMIDO       ,
            SEG_CONSUMIDO       ,
            0                   ,
            TO_DATE(:szhFecSysdate,'YYYYMMDDHH24MISS'),
            NUM_PROCESO         ,
            COD_CLIENTE
    FROM    TA_ACUMLLAMADASROA
    WHERE   ROWID = :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_HISTACUMLLAM (NUM_ABONADO,COD_CICLFACT,IND\
_ENTSAL,COD_TARIFICACION,IND_TABLA,COD_PRODUCTO,IMP_CONSUMIDO,SEG_CONSOPER,IMP\
_CONSOPER,SEG_CONSUMIDO,NUM_PULSOS,FEC_EFECTIVIDAD,NUM_PROCESO,COD_CLIENTE)sel\
ect NUM_ABONADO ,COD_CICLFACT ,2 ,COD_OPERADOR ,3 ,1 ,IMP_CONSUMIDO ,SEG_CONSU\
MIDO ,IMP_CONSUMIDO ,SEG_CONSUMIDO ,0 ,TO_DATE(:b0,'YYYYMMDDHH24MISS') ,NUM_PR\
OCESO ,COD_CLIENTE  from TA_ACUMLLAMADASROA where ROWID=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )792;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecSysdate;
    sqlstm.sqhstl[0] = (unsigned long )20;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[1] = (unsigned long )20;
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



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-INSERT TA_ACUMLLAMADASAROA **"
                                        "\n\t\t=> Row Id        [%s]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,szhRowid,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-INSERT TA_ACUMLLAMADASAROA **"
                                        "\n\t\t=> Row Id        [%s]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,szhRowid,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL
    DELETE FROM TA_ACUMLLAMADASROA
    WHERE   ROWID = :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from TA_ACUMLLAMADASROA  where ROWID=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )815;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[0] = (unsigned long )20;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-DELETE TA_ACUMLLAMADASAROA **"
                                        "\n\t\t=> Row Id        [%s]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,szhRowid,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-DELETE  TA_ACUMLLAMADASAROA **"
                                        "\n\t\t=> Row Id        [%s]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,szhRowid,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    return (TRUE);
}/*************************** END bfnPasaAcumRoaming **************************/

/*****************************************************************************/
/*      Funcion : BOOL bfnDBPasarFacturas (long lCodCiclfact)                */
/*****************************************************************************/
/* * Pasamos datos a Tablas Historicas                                     * */
/* *    Shell Remota :                                                     * */
/* *            FA_FACTCONC_CICLO --> FA_HISTCONC_CICLO                    * */
/* *            FA_FACTCLIE_CICLO --> FA_HISTCLIE_CICLO                    * */
/* *            FA_FACTABON_CICLO --> FA_HISTABON_CICLO                    * */
/* *            FA_FACTDOCU_CICLO --> FA_HISTDOCU                          * */
/* ************************************************************************* */

BOOL bfnDBPasarFacturas (long lCodCiclfact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodCiclFact   ;
    long    lhNumReg        ;
    /* EXEC SQL END   DECLARE SECTION; */ 


    char    szNomTabla  [50]    ="";
    char    szCadenaSQL [1024]  ="";
    char    szFechaProc [20]    ="";

    sprintf(szNomTabla,"FA_FACTDOCU_%ld",lCodCiclfact);

    /******************************************************************************/
    if (!bfnSelectSysDate(szFechaProc))
    {
        vDTrazasLog(szPasar ,"\n\t*** Error en bfnSelectSysDate (bfnDBPasarFacturas) ***\n",LOG01);
        return (FALSE);
    }


    lhCodCiclFact = lCodCiclfact;

    vDTrazasLog  (szPasar,	"\n\t****************************************"
                            "****************************************"
    					  	"\n\t\t\t**  Paso Historico FACTURAS **"
    					  	"\n\t****************************************"
                            "****************************************"
							"\n\t Entrada en bfnDBPasarFacturas => Cod. CiclFact  ... [%ld]"
                            ,LOG03,lhCodCiclFact);
/*
   2005/04/25 Indra	Modificacion proyecto P-COL-05001-SCL (Colombia) para documentos en 0 (cero):
   Se condiciona la llamada a la función "bfnDBPasarAvisoPago" con el valor del parametro  distinto de 'S' 
   ('S':documentos facturables con total factura =0)
*/
    vDTrazasLog ( szPasar , " Flag de Procesamiento de documento en cero: [%c]",LOG03,pstParamGener.sDocumentoCero);
    
    if (pstParamGener.sDocumentoCero == 'N')
    {
      
     if (!bfnDBPasarAvisoPago(lhCodCiclFact))
       {
        vDTrazasLog(szPasar,"\n\n\t**  Error en el traspaso de FACTURAS CICLO Monto Cero **"
                            "\n\t\t Error Oracle [%d] [%s]"
                            ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
       }
    }

    /****************************************************************/
    /*  VERIFICAMOS REGISTROS ANULADOS                              */
    /****************************************************************/
    vDTrazasLog ( szPasar , "\n\t\t\t Facturas de Ciclo Anuladas ",LOG03);
    lhNumReg = 0;

    sprintf(szCadenaSQL,"SELECT  NVL(COUNT(1),0) FROM FA_FACTDOCU_%ld WHERE IND_ANULADA != 0",lhCodCiclFact);

    /* EXEC SQL PREPARE sql_count_anulada FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )834;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-PREPARE sql_count_anulada **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE cur_count_anulada CURSOR FOR sql_count_anulada; */ 

    if (SQLCODE)
    {
        vDTrazasError(szPasar,"\n\t**  Error en SQL-DECLARE cur_count_anulada **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN cur_count_anulada; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )853;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-OPEN CURSOR cur_count_anulada **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL FETCH cur_count_anulada INTO :lhNumReg; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )868;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumReg;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-FETCH cur_count_anulada **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL CLOSE cur_count_anulada; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )887;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog ( szPasar , "\n\t\t\t  ==> Cod_CiclFact          [%ld]"
                            "\n\t\t\t  ==> Numero de Facturas    [%ld]"
                            ,(lhNumReg==0?LOG03:LOG01),lhCodCiclFact,lhNumReg);

    if (lhNumReg > 0)
    {
        vDTrazasError( szPasar ,"\n\t ** Documentos Anulados **"
                                "\n\t\t\t\t  ==> Cod_CiclFact          [%ld]"
                                "\n\t\t\t\t  ==> Numero de Facturas    [%ld]"
                                ,LOG01,lhCodCiclFact,lhNumReg);
        return FALSE;
    }


    /****************************************************************/
    /*  VERIFICAMOS REGISTROS NO IMPRESOS                           */
    /****************************************************************/
    vDTrazasLog ( szPasar , "\n\t\t\t Facturas de Ciclo No Impresas ",LOG03);
    lhNumReg = 0;

    sprintf(szCadenaSQL,"SELECT  NVL(COUNT(1),0) FROM FA_FACTDOCU_%ld WHERE IND_IMPRESA <= 0 ",lhCodCiclFact);

    /* EXEC SQL PREPARE sql_count_impresa FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )902;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-PREPARE sql_count_impresa **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE cur_count_impresa CURSOR FOR sql_count_impresa; */ 

    if (SQLCODE)
    {
        vDTrazasError(szPasar,"\n\t**  Error en SQL-DECLARE cur_count_impresa **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN cur_count_impresa; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )921;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-OPEN CURSOR cur_count_impresa **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL FETCH cur_count_impresa INTO :lhNumReg; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )936;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumReg;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-FETCH cur_count_impresa **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL CLOSE cur_count_impresa; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )955;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog ( szPasar , "\n\t\t\t\t  ==> Cod_CiclFact          [%ld]"
                            "\n\t\t\t\t  ==> Numero de Facturas    [%ld]"
                            ,(lhNumReg==0?LOG03:LOG01),lhCodCiclFact,lhNumReg);

    if (lhNumReg > 0)
    {
        vDTrazasError( szPasar ,"\n\t ** Documentos No Impresos  **"
                                "\n\t\t\t\t  ==> Cod_CiclFact          [%ld]"
                                "\n\t\t\t\t  ==> Numero de Facturas    [%ld]"
                                ,LOG01,lhCodCiclFact,lhNumReg);
        return FALSE;
    }
   
    /****************************************************************/
    /*  VERIFICAMOS REGISTROS PASADOS A COBRO                       */
    /****************************************************************/
    vDTrazasLog ( szPasar , "\n\t\t\t Facturas de Ciclo Sin Paso a Cobros ",LOG03);
    lhNumReg = 0;

    sprintf(szCadenaSQL,"SELECT  NVL(COUNT(1),0) FROM FA_FACTDOCU_%ld WHERE IND_PASOCOBRO <= 0",lhCodCiclFact);

    /* EXEC SQL PREPARE sql_count_pasocob FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )970;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-PREPARE sql_count_pasocob **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE cur_count_pasocob CURSOR FOR sql_count_pasocob; */ 

    if (SQLCODE)
    {
        vDTrazasError(szPasar,"\n\t**  Error en SQL-DECLARE cur_count_pasocob **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN cur_count_pasocob; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )989;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-OPEN CURSOR cur_count_pasocob **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL FETCH cur_count_pasocob INTO :lhNumReg; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
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
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumReg;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-FETCH cur_count_pasocob **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL CLOSE cur_count_pasocob; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1023;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog ( szPasar , "\n\t\t\t\t  ==> Cod_CiclFact          [%ld]"
                            "\n\t\t\t\t  ==> Numero de Facturas    [%ld]"
                            ,(lhNumReg==0?LOG03:LOG01),lhCodCiclFact,lhNumReg);

    if (lhNumReg > 0)
    {
        vDTrazasError( szPasar ,"\n\t ** Documentos Sin Paso a Cobros  **"
                                "\n\t\t\t\t  ==> Cod_CiclFact          [%ld]"
                                "\n\t\t\t\t  ==> Numero de Facturas    [%ld]"
                                ,LOG01,lhCodCiclFact,lhNumReg);
        return FALSE;
    }
    
    /************************************************************************/
    if(!fnOraCommit())
    {
        vDTrazasLog  (szPasar , "Error en Commit en bfnDBPasarFacturas",LOG01, SQLERRM);
        vDTrazasError(szPasar , "Error en Commit en bfnDBPasarFacturas",LOG01, SQLERRM);
        return (FALSE);
    }
    /*******WWWW aplica*/
    
    vDTrazasLog  (szPasar , "PGG - szAplica_Cod_Autorizacion	[%s]", LOG03, szAplica_Cod_Autorizacion);
    
    if (strcmp(szAplica_Cod_Autorizacion,"S") == 0) 
    {
    	szfnObtieneCod_autorizacion(lCodCiclfact);
    	
    	
       if (!iUpdate_fa_factdocu_ciclo(lCodCiclfact))
       {
          vDTrazasError(szPasar , "Error en iUpdate_fa_factdocu_ciclo",LOG01, SQLERRM);
          return(FALSE);
       }
    }
    
    /************************************************************************/
    if (!bfnCreateFacturasHist (lCodCiclfact,szFechaProc))
        return (FALSE);
    /************************************************************************/
/* rao: se elimina borrado, este se separa del paso a historico */
/*     if (!bfnCreateFaDetCelular (lCodCiclfact,szFechaProc))                      */
/*         return (FALSE);                                                         */
    /************************************************************************/
    /************************************************************************/
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return TRUE;
}/*************************** END bfnDBPasarFacturas **************************/

/*********************************************************************/
/*      Funcion : int iUpdate_fa_factdocu_ciclo (long lCodCicloFact) */
/*********************************************************************/

/* Modificación Proyecto Ecu-05002 Codigo de Autorización.
   Se crea funcion iUpdate_fa_factdocu_ciclo para actualizar 
   el codigo de autorizacion para el ciclo en curso.
*/

int iUpdate_fa_factdocu_ciclo (long lCodCicloFact) 
{
 char    szCadenaUpdate[4096] ="";

 /* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCicloFact;
 /* EXEC SQL END DECLARE SECTION; */ 

 
  lhCodCicloFact = lCodCicloFact;
  
  vDTrazasLog  ("","lhCodCicloFact [%ld]", LOG05, lhCodCicloFact);
  
  sprintf(szCadenaUpdate,
            "UPDATE FA_FACTDOCU_%ld SET COD_AUTORIZACION = :szCod_Autorizacion "
            "WHERE NUM_FOLIO IS NOT NULL ", lhCodCicloFact);

  vDTrazasLog  ("","szCadenaUpdate 	[%s]", LOG05, szCadenaUpdate);
  vDTrazasLog  ("","szCod_Autorizacion 	[%s]", LOG05, szCod_Autorizacion);
  
         
 /* EXEC SQL PREPARE sql_update_faciclo FROM :szCadenaUpdate; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1038;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaUpdate;
 sqlstm.sqhstl[0] = (unsigned long )4096;
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
    vDTrazasError(szPasar, "\n(iUpdate_fa_factdocu_ciclo) Error en Prepare Updatede   [%s] **"
               ,LOG01, SQLERRM);
    return FALSE;
 }
 /*EXEC SQL EXECUTE sql_update_faciclo; */
 /* EXEC SQL EXECUTE sql_update_faciclo USING :szCod_Autorizacion; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 16;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1057;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCod_Autorizacion;
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
     vDTrazasError(szPasar, "\n**  (iUpdate_fa_factdocu_ciclo) Error en Execute de Update [%s] **"
               ,LOG01, SQLERRM);
     return FALSE;
 }
 
 /* 20050701: Si todo esta OK, retorna TRUE  */
 vDTrazasLog  (""," Salida de la funcion iUpdate_fa_factdocu_ciclo 	Exitosa", LOG05);
 return TRUE;
 
}/*************************** END iUpdate_fa_factdocu_ciclo **************************/

/*******************************************************************************/
/*      Funcion : BOOL bfnCreateFacturasHist (long lCiclParam, char * szFecha) */
/*******************************************************************************/
/* * Pasamos a Historicas Abonados Facturados                                * */
/* *************************************************************************** */

BOOL bfnCreateFacturasHist (long lCiclParam, char * szFecha)
{
    char *szDirKsh              ;
    char *szDirLog              ;
    char szComShell[1024] = ""  ;

    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************"
    					  "\n\t** Ejecutando Paso a Historico de Facturas ** "
    					  "\n\t****************************************"
                              "****************************************",LOG03);

    szDirKsh =(char *)malloc(1024);
    if ((szDirKsh  = szGetEnv("XPF_KSH")) == (char *)NULL)
        return (FALSE);

    szDirLog =(char *)malloc(1024);
    if ((szDirLog  = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);

    sprintf (szComShell,    "/usr/bin/ksh %s/pashist_ciclo.ksh %ld > %s/pasohist/%ld/pashist_ciclo_%s.log 2>&1\0",
                            szDirKsh,lCiclParam,szDirLog,lCiclParam,szFecha);

	vDTrazasLog  (szPasar,"*** => Comando [%s]",LOG05,szComShell);

    if (system (szComShell))
    {
    	vDTrazasLog  (szPasar,"*** => Fallo Comando Remoto [%s]",LOG01,szComShell);
        printf( "\n\t***   Fallo Comando Remoto [%s] \n",szComShell);
        return (FALSE);
    }
    return (TRUE);
}/*************************** END bfnCreateFacturasHist **************************/

/******************************************************************************/
/*      Funcion : BOOL bfnCreateFaDetCelular(long lCiclParam, char * szFecha) */
/******************************************************************************/
/*  Rutina que Ejecuta Shell remota en maquina de Motor de Base de Datos      */
/******************************************************************************/

BOOL bfnCreateFaDetCelular(long lCiclParam, char * szFecha)
{
    char *szDirKsh            ;
    char *szDirLog            ;
    char szComShell[1024] = "";

    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************"
    					  "\n\t** Ejecutando Paso a Historico de Llamadas ** "
    					  "\n\t****************************************"
                              "****************************************",LOG03);

    szDirKsh =(char *)malloc(1024);
    if ((szDirKsh  = szGetEnv("XPF_KSH")) == (char *)NULL)
        return (FALSE);

    szDirLog =(char *)malloc(1024);
    if ((szDirLog  = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);

    sprintf (szComShell,    "/usr/bin/ksh %s/pashist_llamciclo.ksh %ld > %s/pasohist/%ld/pashist_llamciclo_%s.log 2>&1\0",
                            szDirKsh,lCiclParam,szDirLog,lCiclParam,szFecha);

	vDTrazasLog  (szPasar,"*** => Comando [%s]",LOG05,szComShell);

	if (system (szComShell))
    {
        printf( "\n\t***   Fallo Comando Remoto [%s]\n",szComShell);
        return (FALSE);
    }

    return (TRUE);
}/*************************** END bfnCreateFaDetCelular **************************/

/******************************************************************************/
/*      Funcion : BOOL bfnCreateFaDetCelular(long lCiclParam, char * szFecha) */
/******************************************************************************/
/*  Rutina que Inserta Registro en la Tabla de Enlace y Actualiza en estado   */
/*  del proceso de Facturacion IND_FACTURACION = 2 en la tabla FA_CICLFACT    */
/******************************************************************************/

BOOL     bfnInsertFaEnlaceHist(long lCiclParam)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long    lhCodCiclFact       ;
    int     ihIndFacturacion    ;
    char    szhCodAlmac    [2]  ;   /* EXEC SQL VAR szhCodAlmac        IS STRING(2)    ; */ 

    char    szhDetCelular  [40] ;   /* EXEC SQL VAR szhDetCelular      IS STRING(40)   ; */ 

    char    szhDetRoaming  [40] ;   /* EXEC SQL VAR szhDetRoaming      IS STRING(40)   ; */ 

    char    szhDetFortas   [40] ;   /* EXEC SQL VAR szhDetFortas       IS STRING(40)   ; */ 

    char    szhHistAcumLlam[40] ;   /* EXEC SQL VAR szhHistAcumLlam    IS STRING(40)   ; */ 

    char    szhHistClie    [40] ;   /* EXEC SQL VAR szhHistClie        IS STRING(40)   ; */ 

    char    szhHistAboCelu [40] ;   /* EXEC SQL VAR szhHistAboCelu     IS STRING(40)   ; */ 

    char    szhHistAboBeep [40] ;   /* EXEC SQL VAR szhHistAboBeep     IS STRING(40)   ; */ 

    char    szhHistDocu    [40] ;   /* EXEC SQL VAR szhHistDocu        IS STRING(40)   ; */ 

    char    szhHistConc    [40] ;   /* EXEC SQL VAR szhHistConc        IS STRING(40)   ; */ 

    int     ihIndTasador        ; /* SAAM-20021227 */
    char    szhHistecno_th [40] ;   /* EXEC SQL VAR szhHistecno_th     IS STRING(40)   ; */ 
 /* Incorporado por PGonzalez 20-01-2004 */
    char    szhHistPago    [40] ;   /* EXEC SQL VAR szhHistPago        IS STRING(40)   ; */ 
 /* P-COL-07041 */

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (szPasar,"\n\t********************************************************************************"
    					  "\n\t\t\t**  Marca FA_CICLFACT y FA_ENLACE HIST    **"
    					  "\n\t********************************************************************************"
    					  "\n\t\t* Parametros Entrada (bfnInsertFaEnlaceHist)"
                          "\n\t\t\t---------------------------------------------"
                          "\n\t\t==>  Codigo Ciclo Facturacion [%ld]"
                          ,LOG03,lCiclParam);

    /****************************************************************************/
    /*  Inicializa variables de Host                                            */
    /****************************************************************************/
    lhCodCiclFact       =   lCiclParam          ;
    ihIndFacturacion    =   iIND_FACT_TERMINADO ;

    ihIndTasador = stLineaComando.ihIndTasador;


    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-SELECT IND_TASADOR  **"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-SELECT IND_TASADOR  **"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    sprintf(szhCodAlmac         ,"%d"               , 1             );
    sprintf(szhDetCelular       ,"FA_DETCELULAR_%ld", lCiclParam    );
    sprintf(szhDetRoaming       ,"FA_LLAMADASROA"                   );
    sprintf(szhDetFortas        ,"FA_DETFORTAS"                     );
    if (ihIndTasador == TIPO_TASA_CLASICA)
    	sprintf(szhHistAcumLlam     ,"FA_HISTACUMLLAM"              );
    if (ihIndTasador == TIPO_TASA_ON_LINE)
    	sprintf(szhHistAcumLlam     ,"TOL_HISTACUMOPER"             );
    sprintf(szhHistClie         ,"FA_HISTCLIE_%ld"  , lCiclParam    );
    sprintf(szhHistAboCelu      ,"FA_HISTABON_%ld"  , lCiclParam    );
    sprintf(szhHistAboBeep      ,"FA_HISTABON_%ld"  , lCiclParam    );
    sprintf(szhHistDocu         ,"FA_HISTDOCU"                      );
    sprintf(szhHistConc         ,"FA_HISTCONC_%ld"  , lCiclParam    );
    sprintf(szhHistecno_th      ,"FA_HISTECNO_TH_%ld",lCiclParam    ); /* Incorporado por PGonzalez 20-01-2004 */ 
    sprintf(szhHistPago         ,"FA_HISTPAGO_%ld"   ,lCiclParam    ); /* P-COL-07041 */


    /****************************************************************************/
    /*  Marca FA_CICLFACT como Cerrado Ind_facturacion = 3                      */
    /****************************************************************************/

    /* EXEC SQL
    UPDATE  FA_CICLFACT
    SET     IND_FACTURACION = :ihIndFacturacion
    WHERE   COD_CICLFACT    = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_CICLFACT  set IND_FACTURACION=:b0 where COD_CIC\
LFACT=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1076;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndFacturacion;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-UPDATE FA_CICLFACT (Ind_Facturacion = 3)**"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-UPDATE FA_CICLFACT (Ind_Facturacion = 3)**"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);
        return  (FALSE);
    }


    /****************************************************************************/
    /*  Insert Registro en Tabla de Enlace FA_ENLACEHIST                        */
    /****************************************************************************/


    /* EXEC SQL
    INSERT INTO FA_ENLACEHIST (
        COD_CICLFACT    ,
        COD_TIPALMAC    ,
        FA_DETCELULAR   ,
        FA_DETROAMING   ,
        FA_DETFORTAS    ,
        FA_HISTACUMLLAM ,
        FA_HISTCLIE     ,
        FA_HISTABOCELU  ,
        FA_HISTABOBEEP  ,
        FA_HISTDOCU     ,
        FA_HISTCONC     ,
        IND_TASADOR     ,
	    FA_TECNOLOGIAS_TH   , /o Incorporado por PGonzalez 20-01-2004 o/ 
        FA_HISTPAGO      )    /o P-COL-07041 o/
    VALUES (
        :lhCodCiclFact  ,
        :szhCodAlmac    ,
        :szhDetCelular  ,
        :szhDetRoaming  ,
        :szhDetFortas   ,
        :szhHistAcumLlam,
        :szhHistClie    ,
        :szhHistAboCelu ,
        :szhHistAboBeep ,
        :szhHistDocu    ,
        :szhHistConc    ,
        :ihIndTasador   ,
	    :szhHistecno_th , /o Incorporado por PGonzalez 20-01-2004 o/
        :szhHistPago); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_ENLACEHIST (COD_CICLFACT,COD_TIPALMAC,FA_D\
ETCELULAR,FA_DETROAMING,FA_DETFORTAS,FA_HISTACUMLLAM,FA_HISTCLIE,FA_HISTABOCEL\
U,FA_HISTABOBEEP,FA_HISTDOCU,FA_HISTCONC,IND_TASADOR,FA_TECNOLOGIAS_TH,FA_HIST\
PAGO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1099;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAlmac;
    sqlstm.sqhstl[1] = (unsigned long )2;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhDetCelular;
    sqlstm.sqhstl[2] = (unsigned long )40;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhDetRoaming;
    sqlstm.sqhstl[3] = (unsigned long )40;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhDetFortas;
    sqlstm.sqhstl[4] = (unsigned long )40;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhHistAcumLlam;
    sqlstm.sqhstl[5] = (unsigned long )40;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhHistClie;
    sqlstm.sqhstl[6] = (unsigned long )40;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhHistAboCelu;
    sqlstm.sqhstl[7] = (unsigned long )40;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhHistAboBeep;
    sqlstm.sqhstl[8] = (unsigned long )40;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhHistDocu;
    sqlstm.sqhstl[9] = (unsigned long )40;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhHistConc;
    sqlstm.sqhstl[10] = (unsigned long )40;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihIndTasador;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhHistecno_th;
    sqlstm.sqhstl[12] = (unsigned long )40;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhHistPago;
    sqlstm.sqhstl[13] = (unsigned long )40;
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

    /* P-COL-07041 */

    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-INSERT FA_ENLACEHIST **"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);

        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-INSERT FA_ENLACEHIST **"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    return (TRUE);
}/*************************** END bfnInsertFaEnlaceHist ***************************/

/******************************************************************************/
/*      Funcion : BOOL bfnDBPasarAvisoPago(long lCodCiclfact)                 */
/******************************************************************************/
/* Rescata todas las facturas con Tot_Factura = 0                             */
/* traspasandolas a la tabla historica FAH_AVISOPAGO                          */
/* ************************************************************************** */

BOOL bfnDBPasarAvisoPago(long lCodCiclfact)
{
    char    szCadenaSQL [2048]  ="" ;
    BOOL    bFinCursor              ;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhRowid        [20] ; /* EXEC SQL VAR szhRowid         IS STRING(20) ; */ 

    long    lhNumSecuenci        ;
    int     ihCodTipDocum        ;
    long    lhCodVendAgente      ;
    char    szhLetra         [2] ; /* EXEC SQL VAR szhLetra         IS STRING(2)  ; */ 

    int     ihCodCentremi        ;
    double  dhTotPagar           ;
    double  dhTotCargosMe        ;
    long    lhCodCliente         ;
    char    szhFecEmision    [15]; /* EXEC SQL VAR szhFecEmision    IS STRING(15) ; */ 

    double  dhAcumNetoGrav       ;
    double  dhAcumNetoNoGrav     ;
    char    szhIndOrdenTotal [13]; /* EXEC SQL VAR szhIndOrdenTotal IS STRING(13) ; */ 

    double  dhAcumIVA            ;
    long    lhNumProceso         ;
    long    lhNumFolio           ;
    char    szhFecVencimie   [15]; /* EXEC SQL VAR szhFecVencimie   IS STRING(15) ; */ 

    long    lhCodCiclFact        ;
    double  dhImpSaldoAnt        ;
    char    szhNumCTC        [13]; /* EXEC SQL VAR szhNumCTC        IS STRING(13) ; */ 

    double  dhTotFactura         ;
    double  dhTotCuotas          ;
    double  dhTotDescuento       ;
    char    szhCodDespacho   [6] ; /* EXEC SQL VAR szhCodDespacho   IS STRING(6)  ; */ 

    char    szhCodBarras     [21]; /* EXEC SQL VAR szhCodBarras     IS STRING(21) ; */ 

	char    szhPrefPlaza     [11] ; /* EXEC SQL VAR szhPrefPlaza     IS STRING(11)  ; */ 


    /* EXEC SQL END DECLARE SECTION; */ 



    vDTrazasLog ( szPasar, "\n\t Entrada en bfnDBPasarAvisoPago", LOG04);

    sprintf(szCadenaSQL,"SELECT ROWID "
                        ",NUM_SECUENCI "
                        ",COD_TIPDOCUM "
                        ",COD_VENDEDOR_AGENTE "
                        ",LETRA "
                        ",COD_CENTREMI "
                        ",TOT_PAGAR "
                        ",TOT_CARGOSME "
                        ",COD_CLIENTE "
                        ",TO_CHAR (FEC_EMISION,'YYYYMMDDHH24MISS') "
                        ",ACUM_NETOGRAV "
                        ",ACUM_NETONOGRAV "
                        ",ACUM_IVA "
                        ",IND_ORDENTOTAL "
                        ",NUM_PROCESO "
                        ",NUM_FOLIO "
                        ",NVL(TO_CHAR (FEC_VENCIMIE,'YYYYMMDDHH24MISS'), ' ') "
                        ",NVL(COD_CICLFACT,0) "
                        ",NVL(IMP_SALDOANT,0) "
                        ",NVL(NUM_CTC,' ') "
                        ",TOT_FACTURA "
                        ",TOT_CUOTAS "
                        ",TOT_DESCUENTO "
                        ",NVL(COD_DESPACHO,' ') "
                        ",NVL(COD_BARRAS,' ') "
                        ",NVL(PREF_PLAZA,' ') "
                        "FROM    FA_FACTDOCU_%ld "
                        "WHERE   TOT_FACTURA=0  ",lCodCiclfact);

    /* EXEC SQL PREPARE sql_pasa_avisopago FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1170;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2048;
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
        vDTrazasError(szPasar,"\n\t**  Error en SQL-PREPARE sql_pasa_avisopago **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    /* EXEC SQL DECLARE Cur_HistAvisoPago CURSOR FOR sql_pasa_avisopago ; */ 


    /* EXEC SQL OPEN Cur_HistAvisoPago; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
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


    if(SQLCODE)
    {
        vDTrazasError(szPasar, "\n\n\t (bfnDBPasarAvisoPago) Error al abrir el Cursor sobre FA_FACTDOCU_%s : %s"
                     ,LOG01, lCodCiclfact, SQLERRM);
        return FALSE;
    }

    bFinCursor = FALSE;
    do
    {
        /* EXEC SQL FETCH Cur_HistAvisoPago INTO
                         :szhRowid
                        ,:lhNumSecuenci
                        ,:ihCodTipDocum
                        ,:lhCodVendAgente
                        ,:szhLetra
                        ,:ihCodCentremi
                        ,:dhTotPagar
                        ,:dhTotCargosMe
                        ,:lhCodCliente
                        ,:szhFecEmision
                        ,:dhAcumNetoGrav
                        ,:dhAcumNetoNoGrav
                        ,:dhAcumIVA
                        ,:szhIndOrdenTotal
                        ,:lhNumProceso
                        ,:lhNumFolio
                        ,:szhFecVencimie
                        ,:lhCodCiclFact
                        ,:dhImpSaldoAnt
                        ,:szhNumCTC
                        ,:dhTotFactura
                        ,:dhTotCuotas
                        ,:dhTotDescuento
                        ,:szhCodDespacho
                        ,:szhCodBarras
                        ,:szhPrefPlaza; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
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
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[0] = (unsigned long )20;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenci;
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodVendAgente;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
        sqlstm.sqhstl[4] = (unsigned long )2;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentremi;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&dhTotPagar;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&dhTotCargosMe;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
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
        sqlstm.sqhstv[9] = (unsigned char  *)szhFecEmision;
        sqlstm.sqhstl[9] = (unsigned long )15;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&dhAcumNetoGrav;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&dhAcumNetoNoGrav;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&dhAcumIVA;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szhIndOrdenTotal;
        sqlstm.sqhstl[13] = (unsigned long )13;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[17] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)&dhImpSaldoAnt;
        sqlstm.sqhstl[18] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)szhNumCTC;
        sqlstm.sqhstl[19] = (unsigned long )13;
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&dhTotFactura;
        sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)&dhTotCuotas;
        sqlstm.sqhstl[21] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[21] = (         int  )0;
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)&dhTotDescuento;
        sqlstm.sqhstl[22] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[22] = (         int  )0;
        sqlstm.sqindv[22] = (         short *)0;
        sqlstm.sqinds[22] = (         int  )0;
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)szhCodDespacho;
        sqlstm.sqhstl[23] = (unsigned long )6;
        sqlstm.sqhsts[23] = (         int  )0;
        sqlstm.sqindv[23] = (         short *)0;
        sqlstm.sqinds[23] = (         int  )0;
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
        sqlstm.sqhstv[24] = (unsigned char  *)szhCodBarras;
        sqlstm.sqhstl[24] = (unsigned long )21;
        sqlstm.sqhsts[24] = (         int  )0;
        sqlstm.sqindv[24] = (         short *)0;
        sqlstm.sqinds[24] = (         int  )0;
        sqlstm.sqharm[24] = (unsigned long )0;
        sqlstm.sqadto[24] = (unsigned short )0;
        sqlstm.sqtdso[24] = (unsigned short )0;
        sqlstm.sqhstv[25] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[25] = (unsigned long )11;
        sqlstm.sqhsts[25] = (         int  )0;
        sqlstm.sqindv[25] = (         short *)0;
        sqlstm.sqinds[25] = (         int  )0;
        sqlstm.sqharm[25] = (unsigned long )0;
        sqlstm.sqadto[25] = (unsigned short )0;
        sqlstm.sqtdso[25] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if((SQLCODE == SQLNOTFOUND))
        {
             bFinCursor = TRUE;
        }
        else
        {
            if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
            {
                vDTrazasError(szPasar, "\n\t**  (bfnDBPasarAvisoPago) Error en Fetch sobre FA_FACTDOCU_%ld  [%s] **"
                                       ,LOG01,lCodCiclfact, SQLERRM);
                return FALSE;
            }

            sprintf(szCadenaSQL,"INSERT INTO FAH_AVISOPAGO "
                                "(NUM_SECUENCI        "
                                ",COD_TIPDOCUM        "
                                ",COD_VENDEDOR_AGENTE "
                                ",LETRA               "
                                ",COD_CENTREMI        "
                                ",TOT_PAGAR           "
                                ",TOT_CARGOSME        "
                                ",COD_CLIENTE         "
                                ",FEC_EMISION         "
                                ",ACUM_NETOGRAV       "
                                ",ACUM_NETONOGRAV     "
                                ",ACUM_IVA            "
                                ",IND_ORDENTOTAL      "
                                ",NUM_PROCESO         "
                                ",NUM_FOLIO           "
                                ",FEC_VENCIMIE        "
                                ",COD_CICLFACT        "
                                ",IMP_SALDOANT        "
                                ",NUM_CTC             "
                                ",TOT_FACTURA         "
                                ",TOT_CUOTAS          "
                                ",TOT_DESCUENTO       "
                                ",COD_DESPACHO        "
                                ",COD_BARRAS		  "
                                ",PREF_PLAZA)         "
                                "VALUES "
                                "(:lhNumSecuenci    "
                                ",:ihCodTipDocum    "
                                ",:lhCodVendAgente  "
                                ",:szhLetra         "
                                ",:ihCodCentremi    "
                                ",:dhTotPagar       "
                                ",:dhTotCargosMe    "
                                ",:lhCodCliente     "
                                ",TO_DATE(:szFecEmision,'YYYYMMDDHH24MISS') "
                                ",:dAcumNetoGrav    "
                                ",:dAcumNetoNoGrav  "
                                ",:dhAcumIVA        "
                                ",TO_NUMBER (:szhIndOrdenTotal) "
                                ",:lhNumProceso     "
                                ",:lhNumFolio       "
                                ",TO_DATE(:szhFecVencimie,'YYYYMMDDHH24MISS') "
                                ",:lhCodCiclFact    "
                                ",:dhImpSaldoAnt    "
                                ",:szhNumCTC        "
                                ",:dhTotFactura     "
                                ",:dhTotCuotas      "
                                ",:dhTotDescuento   "
                                ",:szhCodDespacho   "
                                ",:szhCodBarras   	"
                                ",:szhPrefPlaza		) ");

            /* EXEC SQL PREPARE sql_insert_avisopago FROM :szCadenaSQL; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 26;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1323;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
            sqlstm.sqhstl[0] = (unsigned long )2048;
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
              vDTrazasError(szPasar, "\n\t**  (bfnDBPasarAvisoPago) Error en Prepare de Insert sobre FAH_AVISOPAGO  [%s] **"
                          ,LOG01, SQLERRM);
              return FALSE;
            }

            /* EXEC SQL EXECUTE sql_insert_avisopago
                   USING     :lhNumSecuenci
                            ,:ihCodTipDocum
                            ,:lhCodVendAgente
                            ,:szhLetra
                            ,:ihCodCentremi
                            ,:dhTotPagar
                            ,:dhTotCargosMe
                            ,:lhCodCliente
                            ,:szhFecEmision
                            ,:dhAcumNetoGrav
                            ,:dhAcumNetoNoGrav
                            ,:dhAcumIVA
                            ,:szhIndOrdenTotal
                            ,:lhNumProceso
                            ,:lhNumFolio
                            ,:szhFecVencimie
                            ,:lhCodCiclFact
                            ,:dhImpSaldoAnt
                            ,:szhNumCTC
                            ,:dhTotFactura
                            ,:dhTotCuotas
                            ,:dhTotDescuento
                            ,:szhCodDespacho
                            ,:szhCodBarras
                            ,:szhPrefPlaza; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 26;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1342;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendAgente;
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
            sqlstm.sqhstv[5] = (unsigned char  *)&dhTotPagar;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&dhTotCargosMe;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
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
            sqlstm.sqhstv[8] = (unsigned char  *)szhFecEmision;
            sqlstm.sqhstl[8] = (unsigned long )15;
            sqlstm.sqhsts[8] = (         int  )0;
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)&dhAcumNetoGrav;
            sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[9] = (         int  )0;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)&dhAcumNetoNoGrav;
            sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[10] = (         int  )0;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)&dhAcumIVA;
            sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[11] = (         int  )0;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)szhIndOrdenTotal;
            sqlstm.sqhstl[12] = (unsigned long )13;
            sqlstm.sqhsts[12] = (         int  )0;
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqhstv[13] = (unsigned char  *)&lhNumProceso;
            sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[13] = (         int  )0;
            sqlstm.sqindv[13] = (         short *)0;
            sqlstm.sqinds[13] = (         int  )0;
            sqlstm.sqharm[13] = (unsigned long )0;
            sqlstm.sqadto[13] = (unsigned short )0;
            sqlstm.sqtdso[13] = (unsigned short )0;
            sqlstm.sqhstv[14] = (unsigned char  *)&lhNumFolio;
            sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[14] = (         int  )0;
            sqlstm.sqindv[14] = (         short *)0;
            sqlstm.sqinds[14] = (         int  )0;
            sqlstm.sqharm[14] = (unsigned long )0;
            sqlstm.sqadto[14] = (unsigned short )0;
            sqlstm.sqtdso[14] = (unsigned short )0;
            sqlstm.sqhstv[15] = (unsigned char  *)szhFecVencimie;
            sqlstm.sqhstl[15] = (unsigned long )15;
            sqlstm.sqhsts[15] = (         int  )0;
            sqlstm.sqindv[15] = (         short *)0;
            sqlstm.sqinds[15] = (         int  )0;
            sqlstm.sqharm[15] = (unsigned long )0;
            sqlstm.sqadto[15] = (unsigned short )0;
            sqlstm.sqtdso[15] = (unsigned short )0;
            sqlstm.sqhstv[16] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[16] = (         int  )0;
            sqlstm.sqindv[16] = (         short *)0;
            sqlstm.sqinds[16] = (         int  )0;
            sqlstm.sqharm[16] = (unsigned long )0;
            sqlstm.sqadto[16] = (unsigned short )0;
            sqlstm.sqtdso[16] = (unsigned short )0;
            sqlstm.sqhstv[17] = (unsigned char  *)&dhImpSaldoAnt;
            sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[17] = (         int  )0;
            sqlstm.sqindv[17] = (         short *)0;
            sqlstm.sqinds[17] = (         int  )0;
            sqlstm.sqharm[17] = (unsigned long )0;
            sqlstm.sqadto[17] = (unsigned short )0;
            sqlstm.sqtdso[17] = (unsigned short )0;
            sqlstm.sqhstv[18] = (unsigned char  *)szhNumCTC;
            sqlstm.sqhstl[18] = (unsigned long )13;
            sqlstm.sqhsts[18] = (         int  )0;
            sqlstm.sqindv[18] = (         short *)0;
            sqlstm.sqinds[18] = (         int  )0;
            sqlstm.sqharm[18] = (unsigned long )0;
            sqlstm.sqadto[18] = (unsigned short )0;
            sqlstm.sqtdso[18] = (unsigned short )0;
            sqlstm.sqhstv[19] = (unsigned char  *)&dhTotFactura;
            sqlstm.sqhstl[19] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[19] = (         int  )0;
            sqlstm.sqindv[19] = (         short *)0;
            sqlstm.sqinds[19] = (         int  )0;
            sqlstm.sqharm[19] = (unsigned long )0;
            sqlstm.sqadto[19] = (unsigned short )0;
            sqlstm.sqtdso[19] = (unsigned short )0;
            sqlstm.sqhstv[20] = (unsigned char  *)&dhTotCuotas;
            sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[20] = (         int  )0;
            sqlstm.sqindv[20] = (         short *)0;
            sqlstm.sqinds[20] = (         int  )0;
            sqlstm.sqharm[20] = (unsigned long )0;
            sqlstm.sqadto[20] = (unsigned short )0;
            sqlstm.sqtdso[20] = (unsigned short )0;
            sqlstm.sqhstv[21] = (unsigned char  *)&dhTotDescuento;
            sqlstm.sqhstl[21] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[21] = (         int  )0;
            sqlstm.sqindv[21] = (         short *)0;
            sqlstm.sqinds[21] = (         int  )0;
            sqlstm.sqharm[21] = (unsigned long )0;
            sqlstm.sqadto[21] = (unsigned short )0;
            sqlstm.sqtdso[21] = (unsigned short )0;
            sqlstm.sqhstv[22] = (unsigned char  *)szhCodDespacho;
            sqlstm.sqhstl[22] = (unsigned long )6;
            sqlstm.sqhsts[22] = (         int  )0;
            sqlstm.sqindv[22] = (         short *)0;
            sqlstm.sqinds[22] = (         int  )0;
            sqlstm.sqharm[22] = (unsigned long )0;
            sqlstm.sqadto[22] = (unsigned short )0;
            sqlstm.sqtdso[22] = (unsigned short )0;
            sqlstm.sqhstv[23] = (unsigned char  *)szhCodBarras;
            sqlstm.sqhstl[23] = (unsigned long )21;
            sqlstm.sqhsts[23] = (         int  )0;
            sqlstm.sqindv[23] = (         short *)0;
            sqlstm.sqinds[23] = (         int  )0;
            sqlstm.sqharm[23] = (unsigned long )0;
            sqlstm.sqadto[23] = (unsigned short )0;
            sqlstm.sqtdso[23] = (unsigned short )0;
            sqlstm.sqhstv[24] = (unsigned char  *)szhPrefPlaza;
            sqlstm.sqhstl[24] = (unsigned long )11;
            sqlstm.sqhsts[24] = (         int  )0;
            sqlstm.sqindv[24] = (         short *)0;
            sqlstm.sqinds[24] = (         int  )0;
            sqlstm.sqharm[24] = (unsigned long )0;
            sqlstm.sqadto[24] = (unsigned short )0;
            sqlstm.sqtdso[24] = (unsigned short )0;
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
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
                vDTrazasError(szPasar, "\n\t**  (bfnDBPasarAvisoPago) Error en Execute de Insert sobre FAH_AVISOPAGO  [%s] **"
                          ,LOG01, SQLERRM);
                return FALSE;
            }

            vDTrazasLog ( szPasar, "\n\t\t (bfnDBPasarAvisoPago) Paso de Avisos de pago, Numero de Secuencia : [%ld]"
                        , LOG03,lhNumSecuenci);

            sprintf(szCadenaSQL,"DELETE FROM FA_FACTDOCU_%ld WHERE ROWID = :szhRowid ",lhCodCiclFact);

            /* EXEC SQL PREPARE sql_delete_factura0 FROM :szCadenaSQL; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 26;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1457;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
            sqlstm.sqhstl[0] = (unsigned long )2048;
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
                vDTrazasLog(szPasar,"\n\n\t**  Error en borrado de Factura Monto cero (PREPARE) **"
                                    "\n\t\t Error Oracle [%ld] [%s]"
                                    ,LOG01,SQLCODE,SQLERRM);
                return FALSE;
            }

            /* EXEC SQL EXECUTE sql_delete_factura0 USING :szhRowid ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 26;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1476;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
            sqlstm.sqhstl[0] = (unsigned long )20;
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



            if (( SQLCODE != SQLOK ))
            {
                vDTrazasError( szPasar ,"\n\t Error en borrado de Factura Monto Cero (EXECUTE)"
                                        "\n\t\t=> Numero de Secuencia   : [%ld]"
                                        "\n\t\t=> Codigo Tipo Documento : [%d] "
                                        "\n\t\t=> Codigo vendedor Agente: [%ld]"
                                        "\n\t\t=> Letra                 : [%s] "
                                        "\n\t\t=> Codigo Centro Emisor  : [%i] "
                                        "\n\t\t=> Error-Ora     [%ld]          "
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01
                                        ,lhNumSecuenci
                                        ,ihCodTipDocum
                                        ,lhCodVendAgente
                                        ,szhLetra
                                        ,ihCodCentremi
                                        ,SQLCODE,SQLERRM);
                return FALSE;
            }
            if ( !bfnOraCommit())
            {
                vDTrazasLog  (szPasar,  " \n\t-----------------------------------------"
                                        " \n\tFallo en el Commit FAH_AVISOPAGO         "
                                        " \n\t-----------------------------------------",
                                        LOG01);
                vDTrazasError(szPasar,  " \n\t-----------------------------------------"
                                        " \n\tFallo en el Commit FAH_AVISOPAGO         "
                                        " \n\t-----------------------------------------",
                                        LOG01);
                return (FALSE);
            }

        }
    } while(!bFinCursor);

    return TRUE;
}/* ******************* * END bfnDBPasarAvisoPago * *************************** */

/*******************************************************/
/*      Funcion : BOOL bfnUpdateConsMensClie  ( void ) */
/*******************************************************/

BOOL bfnUpdateConsMensClie  ( void )
{
    char modulo[]="bfnUpdateConsMensClie";

    char szMesPaso     [8];
    char szNumMes      [8];
    int  iNumMes          ;
    BOOL bIndEjecutado =FALSE ;

    sprintf (szMesPaso, "%ld\0", stLineaComando.lCodCiclFact);

    sprintf (szNumMes, "20%c%c%c%c\0", szMesPaso[strlen(szMesPaso)-2]
                                     , szMesPaso[strlen(szMesPaso)-1]
                                     , szMesPaso[strlen(szMesPaso)-4]
                                     , szMesPaso[strlen(szMesPaso)-3]);

    iNumMes=atoi (szNumMes);
    vDTrazasLog  (modulo,  "\n\t**  Actualizacion Estadistica de Consumo mensual del Cliente **"
                           "\n\t\t==> Numero Mes   [%d]"
                            ,LOG05,iNumMes);

	if (!bfnValidaTrazaEstad(stLineaComando.lCodCiclFact, &bIndEjecutado))
	{
		return (FALSE);
	}
	if(!fnOraCommit())
	{
	    vDTrazasLog  (szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
	    vDTrazasError(szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
	    return (FALSE);
	}
	if (!bIndEjecutado)
	{

	    if (!bfnEstadFactCta(stLineaComando.lCodCiclFact,iNumMes ))
	    {
	        vDTrazasError(modulo,"\n\t**  Error al procesar estadisticas de Factura Ciclo y Cuenta **"
	                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
	        vDTrazasLog  (modulo,"\n\t**  Error al procesar estadisticas de Factura Ciclo y Cuenta **"
	                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
	        return (FALSE);
	    }

	    if (!bfnEstadAireFrasoc(stLineaComando.lCodCiclFact,iNumMes ))
	    {
	        vDTrazasError(modulo,"\n\t**  Error al procesar estadisticas de tabla Ta_AcumAireFrasoc **"
	                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
	        vDTrazasLog  (modulo,"\n\t**  Error al procesar estadisticas de tabla Ta_AcumAireFrasoc **"
	                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
	        return (FALSE);
	    }

	    if (!bfnEstadAire(stLineaComando.lCodCiclFact,iNumMes ))
	    {
	        vDTrazasError(modulo,"\n\t**  Error al procesar estadisticas de tabla Ta_AcumAireFrasoc **"
	                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
	        vDTrazasLog  (modulo,"\n\t**  Error al procesar estadisticas de tabla Ta_AcumAireFrasoc **"
	                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
	        return (FALSE);
	    }

		if (!bfnUpdateTrazaEstad(stLineaComando.lCodCiclFact))
		{
			return (FALSE);
		}
		if(!fnOraCommit())
		{
		    vDTrazasLog  (szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
		    vDTrazasError(szPasar , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
		    return (FALSE);
		}
	}

    return (TRUE);
}/* ******************* * END bfnUpdateConsMensClie* *************************** */

/************************************************************************************/
/*      Funcion : BOOL bfnValidaTrazaEstad (long lCodCiclFact, BOOL* bIndEjecutado) */
/************************************************************************************/

BOOL bfnValidaTrazaEstad (long lCodCiclFact, BOOL* bIndEjecutado)
{
    char modulo[]="bfnValidaTrazaEstad";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long lhCiclParam            ;
    	long lhCodProceso           ;
    	int  ihTrazCodEstaActual	;
	    char szhDesProceso    [30]  ;   /* EXEC SQL VAR szhDesProceso      IS STRING(30); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t**  Entrada en %s **"
                         "\n\t\t=> Codigo Ciclo Fact : [%ld]"
                         ,LOG05, modulo, lCodCiclFact);

    lhCiclParam		= lCodCiclFact ;
   	lhCodProceso    = iPROC_ACTUALIZA_ESTAD;

    /* EXEC SQL    SELECT  TRAZ.COD_ESTAPROC    , PROC.DES_PROCESO
                  INTO  :ihTrazCodEstaActual , :szhDesProceso
                  FROM  FA_TRAZAPROC TRAZ	 , FA_PROCFACT PROC
                 WHERE  TRAZ.COD_CICLFACT = :lhCiclParam
                   AND  TRAZ.COD_PROCESO  = :lhCodProceso
                   AND  TRAZ.COD_PROCESO  = PROC.COD_PROCESO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TRAZ.COD_ESTAPROC ,PROC.DES_PROCESO into :b0,:b1  \
from FA_TRAZAPROC TRAZ ,FA_PROCFACT PROC where ((TRAZ.COD_CICLFACT=:b2 and TRA\
Z.COD_PROCESO=:b3) and TRAZ.COD_PROCESO=PROC.COD_PROCESO)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1495;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTrazCodEstaActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[1] = (unsigned long )30;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCiclParam;
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



	*bIndEjecutado=0;

    switch(SQLCODE)
    {
    	case SQLNOTFOUND:
		        /*****************************************************************/
		        /*   Proceso NO se ha ejecutado aun para el ciclo de Facturacion.*/
		        /*   Inserta Registro en la Tabla de Traza                       */
		        /*****************************************************************/
		        ihTrazCodEstaActual = iPROC_EST_RUN;
		        vDTrazasLog  (modulo, "\n\t**  Insertando Proceso de FA_TRAZAPROC  **"
		                              "\n\t\t=>  Ciclo de Facturacion     [%ld]"
		                              "\n\t\t=>  Codigo de Proceso        [%d]\n"
		                              ,LOG03,lhCiclParam,lhCodProceso);

		        /* EXEC SQL INSERT INTO
		                FA_TRAZAPROC(   COD_CICLFACT        ,
		                                COD_PROCESO         ,
		                                COD_ESTAPROC        ,
		                                FEC_INICIO          ,
		                                GLS_PROCESO         )
		                VALUES      (   :lhCiclParam        ,
		                                :lhCodProceso       ,
		                                :ihTrazCodEstaActual,
		                                sysdate             ,
		                                'Proceso Iniciado'  ); */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 26;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "insert into FA_TRAZAPROC (COD_CICLFACT,COD_PROCESO,\
COD_ESTAPROC,FEC_INICIO,GLS_PROCESO) values (:b0,:b1,:b2,sysdate,'Proceso Inic\
iado')";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1526;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclParam;
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
          sqlstm.sqhstv[2] = (unsigned char  *)&ihTrazCodEstaActual;
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
		            vDTrazasLog  (modulo, "\n\t\t**  Error Insertando Proceso [%d]"
		                                  "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
		                                  "\n\t\t=>  Error Oracle  %s "
		                                  ,LOG01,lhCodProceso,lhCiclParam,SQLERRM);
		            vDTrazasError(modulo, "\n\t\t**  Error Insertando Proceso [%d]"
		                                  "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
		                                  "\n\t\t=>  Error Oracle  %s "
		                                  ,LOG01,lhCodProceso,lhCiclParam,SQLERRM);
		            return (FALSE);
		        }
        		break;
        case SQLOK:
		        /****************************************************************************/
		        /*  Valida que el Proceso Este Terminado Ok                                 */
		        /****************************************************************************/
		        if(ihTrazCodEstaActual == iPROC_EST_OK)
		        {
		            vDTrazasLog  (modulo, "\n\t**  Proceso %s Ya Fue Procesado con Estado OK **"
		                                  "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
		                                  "\n\t\t=>  Codigo de Proceso            [%d]"
		                                  "\n\t\t=>  Estado de Proceso            [%d]"
		                                  ,LOG03,szhDesProceso,lhCiclParam,lhCodProceso,ihTrazCodEstaActual);
					*bIndEjecutado=1;
		        }
		        else
		        {
			        vDTrazasLog  (modulo, "\n\t**  Retomando Proceso  %s **"
			                              "\n\t\t=>  Ciclo de Facturacion     [%ld]"
			                              "\n\t\t=>  Codigo de Proceso        [%d]"
		    	                          "\n\t\t=>  Estado del Proceso       [%d]\n"
		        	                      ,LOG03,szhDesProceso,lhCiclParam,lhCodProceso,ihTrazCodEstaActual);
				}
        		break;
        default:
		        vDTrazasLog  (modulo, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
		                              "\n\t\t=>  Proceso                      [%d]"
		                              "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
		                              ,LOG01,lhCodProceso,lhCiclParam);
		        vDTrazasError(modulo, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
		                              "\n\t\t=>  Proceso                      [%d]"
		                              "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
		                              ,LOG01,lhCodProceso,lhCiclParam);
		        return (FALSE);
	}
	return (TRUE);
}/*************************** END bfnValidaTrazaEstad ***************************/

/***************************************************************/
/*      Funcion : BOOL bfnUpdateTrazaEstad (long lCodCiclFact) */
/***************************************************************/

BOOL bfnUpdateTrazaEstad (long lCodCiclFact)
{
    char modulo[]="bfnUpdateTrazaEstad";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long lhCiclParam    ;
    	long lhCodProceso   ;
    	int  ihCodEstaProc	;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t**  Entrada en %s **"
                         "\n\t\t=> Codigo Ciclo Fact : [%ld]"
                         ,LOG05, modulo, lCodCiclFact);

	lhCiclParam   = lCodCiclFact;
   	lhCodProceso  = iPROC_ACTUALIZA_ESTAD;
	ihCodEstaProc = iPROC_EST_OK ;

    /* EXEC SQL    UPDATE  FA_TRAZAPROC
                SET     COD_ESTAPROC    = :ihCodEstaProc,
                        FEC_TERMINO     = sysdate
                WHERE   COD_CICLFACT    = :lhCiclParam
                AND     COD_PROCESO     = :lhCodProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_TRAZAPROC  set COD_ESTAPROC=:b0,FEC_TERMINO=sys\
date where (COD_CICLFACT=:b1 and COD_PROCESO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1553;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCiclParam;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog  (modulo, "\n\t\t**  Error en Update FA_TRAZAPROC  **"
                              "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                              "\n\t\t=>  Codigo Proceso           [%d] "
                              "\n\t\t=>  Error Oracle  %s              "
                              ,LOG01,lhCiclParam,lhCodProceso,SQLERRM);
        vDTrazasError(modulo, "\n\t\t**  Error en Update de FA_TRAZAPROC  **"
                              "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                              "\n\t\t=>  Codigo Proceso           [%d] "
                              "\n\t\t=>  Error Oracle  %s              "
                              ,LOG01,lhCiclParam,lhCodProceso,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/*************************** END bfnUpdateTrazaEstad ***************************/

/***********************************************************************/
/*      Funcion : BOOL bfnEstadFactCta (long lCodCiclFact,int iNumMes) */
/***********************************************************************/

BOOL bfnEstadFactCta (long lCodCiclFact,int iNumMes)
{
    char modulo[]="bfnEstadFactCta";

    char szCadenaInsert[2048] ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact ;
        long lhCodCliente  ;
        long lhCodCuenta   ;
        long lhTotFactura  ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t**  Entrada en bfnEstadFactCta **"
                         "\n\t\t=> Codigo Ciclo Fact : [%ld]"
                         "\n\t\t=> Numero Mes        : [%d] "
                         ,LOG05,lCodCiclFact,iNumMes  );

    lhCodCiclFact = lCodCiclFact;
    vfnInitCadenaFactCta (szCadenaInsert,lCodCiclFact );

    /* EXEC SQL PREPARE sql_FactCta FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1580;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )2048;
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


    if (SQLCODE)  {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-PREPARE sql_FactCta **"
                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE sql_FactCta **"
                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE Cur_FactCta CURSOR FOR sql_FactCta; */ 

    if (SQLCODE)  {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-DECLARE Cur_FactCta  **"
                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-DECLARE Cur_FactCta  **"
                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN Cur_FactCta USING :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1599;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
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


    if (SQLCODE)   {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_FactCta **"
                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_FactCta **"
                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    while (1)
    {
        /* EXEC SQL FETCH Cur_FactCta INTO
                       :lhCodCliente  ,
                       :lhCodCuenta   ,
                       :lhTotFactura  ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1618;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuenta;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhTotFactura;
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




        if(SQLCODE == SQLNOTFOUND)
        {
             break;
        }

        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
                vDTrazasLog  (modulo,"\n\t**  Error en FETCH CURSOR Cur_FactCta **"
                                     "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasError(modulo,"\n\t**  Error en FETCH CURSOR Cur_FactCta **"
                                     "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return  (FALSE);
        }

        if (SQLCODE == SQLOK)
        {
            vfnInitCadenaInsertFactCta (szCadenaInsert);

            if (!bfnInsertEstadistSimple(szCadenaInsert, lhCodCliente, iNumMes, lhTotFactura))
            {
                vfnInitCadenaUpdateFactCta (szCadenaInsert);

                if (!bfnUpdateEstadistSimple(szCadenaInsert, lhCodCliente, iNumMes, lhTotFactura))
                {
                    vDTrazasError(modulo,"\n\t**  Error al hacer Update del Consumo del Total factura ciclo y Cta. **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    vDTrazasLog  (modulo,"\n\t**  Error al hacer Update del Consumo del Total factura ciclo y Cta. **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    return (FALSE);

                }
            }
        }
    }

    /* EXEC SQL CLOSE Cur_FactCta; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1645;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
       vDTrazasError(szPasar, "\n\n\tError al cerrar el Cursor sobre Ta_AcumAire : %s", LOG01, SQLERRM);
       return FALSE;
    }


    return (TRUE);
}/*************************** END bfnEstadFactCta ***************************/

/*************************************************************************/
/*      Funcion : BOOL bfnEstadAireFrasoc(long lCodCiclFact,int iNumMes) */
/*************************************************************************/

BOOL bfnEstadAireFrasoc(long lCodCiclFact,int iNumMes)
{
    char modulo[]="bfnEstadAireFrasoc";

    char szCadenaInsert[1024] ="";
    char szCadenaUpdate[1024] ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact ;
        long lhCodCliente   ;
        int  ihInddestino   ;
        long lhTotSegDestino;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t**  Entrada en bfnEstadAireFrasoc **"
                         "\n\t\t=> Codigo Ciclo Fact : [%ld]"
                         "\n\t\t=> Numero Mes        : [%d] "
                         ,LOG05,lCodCiclFact,iNumMes  );

    lhCodCiclFact=lCodCiclFact;
    vfnInitCadenaAcumAireFrasoc (szCadenaInsert);

    /* EXEC SQL PREPARE sql_AcumAireFrasoc FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1660;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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


    if (SQLCODE)  {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-PREPARE sql_AcumAireFrasoc **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE sql_AcumAireFrasoc **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE Cur_AcumAireFrasoc CURSOR FOR sql_AcumAireFrasoc; */ 

    if (SQLCODE)  {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-DECLARE Cur_AcumAireFrasoc  **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-DECLARE Cur_AcumAireFrasoc  **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN Cur_AcumAireFrasoc USING :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1679;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
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


    if (SQLCODE)   {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_AcumAireFrasoc **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_AcumAireFrasoc **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    while (1)
    {
        /* EXEC SQL FETCH Cur_AcumAireFrasoc INTO
                       :lhCodCliente   ,
                       :ihInddestino   ,
                       :lhTotSegDestino; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1698;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&ihInddestino;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhTotSegDestino;
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



        if(SQLCODE == SQLNOTFOUND)
        {
             break;
        }

        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
                vDTrazasLog  (modulo,"\n\t**  Error en FETCH CURSOR Cur_AcumAireFrasoc **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasError(modulo,"\n\t**  Error en FETCH CURSOR Cur_AcumAireFrasoc **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return  (FALSE);
        }

        if (SQLCODE == SQLOK)
        {
            if (ihInddestino== 1) /* Trafico Telefonica Movil */
            {
                vfnInitCadenaInsertMinTmovil (szCadenaInsert);
                vfnInitCadenaUpdateMinTmovil (szCadenaUpdate);

            }
            else if (ihInddestino== 2) /* Trafico Red Fija */
            {
                vfnInitCadenaInsertRFija (szCadenaInsert);
                vfnInitCadenaUpdateRFija (szCadenaUpdate);

            }
            else if (ihInddestino== 3) /* Trafico Otras Operadoras Moviles */
            {
                vfnInitCadenaInsertOpera (szCadenaInsert);
                vfnInitCadenaUpdateOpera (szCadenaUpdate);

            }
            else if (ihInddestino== 4) /* Trafico Numeros Frecuentes */
            {
                vfnInitCadenaInsertFrecu (szCadenaInsert);
                vfnInitCadenaUpdateFrecu (szCadenaUpdate);

            }

            if (!bfnInsertEstadistSimple(szCadenaInsert, lhCodCliente, iNumMes, lhTotSegDestino))
            {
                if (!bfnUpdateEstadistSimple(szCadenaUpdate, lhCodCliente, iNumMes, lhTotSegDestino))
                {
                    vDTrazasError(modulo,"\n\t**  Error al hacer Update del Consumo de Segundos por Destino **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    vDTrazasLog  (modulo,"\n\t**  Error al hacer Update del Consumo de Segundos por Destino **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    return (FALSE);

                }
            }
        }
    }

    /* EXEC SQL CLOSE Cur_AcumAireFrasoc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1725;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
       vDTrazasError(szPasar, "\n\n\tError al cerrar el Cursor sobre Ta_AcumAireFrasoc : %s", LOG01, SQLERRM);
       return FALSE;
    }

    return (TRUE);
}/*************************** END bfnEstadAireFrasoc ***************************/

/*******************************************************************/
/*      Funcion : BOOL bfnEstadAire(long lCodCiclFact,int iNumMes) */
/*******************************************************************/

BOOL bfnEstadAire(long lCodCiclFact,int iNumMes)
{
    char modulo[]="bfnEstadAire";

    char szCadenaInsert[1024] ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact ;
        long lhCodCliente   ;
        long lhTotSegGratis;
        long lhTotSegAdicio;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t**  Entrada en bfnEstadAire **"
                         "\n\t\t=> Codigo Ciclo Fact : [%ld]"
                         "\n\t\t=> Numero Mes        : [%d] "
                         ,LOG05,lCodCiclFact,iNumMes  );

    lhCodCiclFact = lCodCiclFact;
    vfnInitCadenaAcumAire (szCadenaInsert);

    /* EXEC SQL PREPARE sql_AcumAire FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1740;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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


    if (SQLCODE)  {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-PREPARE sql_AcumAire **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE sql_AcumAire **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE Cur_AcumAire CURSOR FOR sql_AcumAire; */ 

    if (SQLCODE)  {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-DECLARE Cur_AcumAire  **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-DECLARE Cur_AcumAire  **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN Cur_AcumAire USING :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1759;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
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


    if (SQLCODE)   {
        vDTrazasLog  (modulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_AcumAire **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_AcumAire **"
                                 "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    while (1)
    {
        /* EXEC SQL FETCH Cur_AcumAire INTO
                       :lhCodCliente   ,
                       :lhTotSegGratis ,
                       :lhTotSegAdicio; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1778;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhTotSegGratis;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhTotSegAdicio;
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



        if(SQLCODE == SQLNOTFOUND)
        {
             break;
        }

        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
                vDTrazasLog  (modulo,"\n\t**  Error en FETCH CURSOR Cur_AcumAire **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasError(modulo,"\n\t**  Error en FETCH CURSOR Cur_AcumAire **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return  (FALSE);
        }

        if (SQLCODE == SQLOK)
        {
            vfnInitCadenaInsertAire (szCadenaInsert);

            if (!bfnInsertEstadistDoble(szCadenaInsert, lhCodCliente, iNumMes, lhTotSegGratis, lhTotSegAdicio))
            {
                vfnInitCadenaUpdateAire (szCadenaInsert);

                if (!bfnUpdateEstadistDoble(szCadenaInsert, lhCodCliente, iNumMes, lhTotSegGratis, lhTotSegAdicio))
                {
                    vDTrazasError(modulo,"\n\t**  Error al hacer Update del Consumo de Segundos de Ta_AcumAire **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    vDTrazasLog  (modulo,"\n\t**  Error al hacer Update del Consumo de Segundos de Ta_AcumAire **"
                                         "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    return (FALSE);

                }
            }
        }
    }

    /* EXEC SQL CLOSE Cur_AcumAire; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1805;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
       vDTrazasError(szPasar, "\n\n\tError al cerrar el Cursor sobre Ta_AcumAire : %s", LOG01, SQLERRM);
       return FALSE;
    }


    return (TRUE);
}/*************************** END bfnEstadAire ***************************/

/***************************************************************************************/
/*      Funcion : BOOL bfnInsertEstadistSimple (char *szCadenaInsert,long lCodCliente, */
/*                                              int iNumMes,long lTotEstad)            */
/***************************************************************************************/

BOOL bfnInsertEstadistSimple (char *szCadenaInsert,long lCodCliente,int iNumMes,long lTotEstad)
{
    char modulo[]="bfnInsertEstadistSimple";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long    lhCodCliente;
   			int     ihNumMes    ;
			long    lhTotEstad  ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente=lCodCliente;
    ihNumMes    =iNumMes    ;
    lhTotEstad  =lTotEstad  ;

    vDTrazasLog  (modulo,  "\n\t\t\t**  Entrada en bfnInsertEstadistSimple **"
                           "\n\t\t\t\t=> Cod. Cliente  : [%ld] "
                           "\n\t\t\t\t=> Nro. Mes      : [%d] "
                           "\n\t\t\t\t=> Total Estad.  : [%.0f] "
                           "\n\t\t\t\t=> Cadena SQL    : [%s] "
                           ,LOG05,lhCodCliente,ihNumMes,lhTotEstad, szCadenaInsert);

    /* EXEC SQL PREPARE sql_insert_estadist FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1820;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )0;
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
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Estadisticas **"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Estadisticas **"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_insert_estadist USING :lhCodCliente, :ihNumMes, :lhTotEstad; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1839;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNumMes;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhTotEstad;
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
    {
        return  (FALSE);
    }

    return (TRUE);
}/*************************** END bfnInsertEstadistSimple ***************************/

/***************************************************************************************/
/*      Funcion : BOOL bfnUpdateEstadistSimple (char *szCadenaUpdate,long lCodCliente, */
/*                                              int iNumMes,long lTotEstad)            */
/***************************************************************************************/

BOOL bfnUpdateEstadistSimple (char *szCadenaUpdate,long lCodCliente,int iNumMes,long lTotEstad)
{
    char modulo[]="bfnUpdateEstadistSimple";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long    lhCodCliente;
   			int     ihNumMes    ;
			long    lhTotEstad  ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente=lCodCliente;
    ihNumMes    =iNumMes    ;
    lhTotEstad  =lTotEstad;

    /* EXEC SQL PREPARE sql_update_estadist FROM :szCadenaUpdate; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1866;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaUpdate;
    sqlstm.sqhstl[0] = (unsigned long )0;
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
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Update Estadisticas de Consumo **"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Update Estadisticas de Consumo **"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_update_estadist USING :lhTotEstad, :lhCodCliente, :ihNumMes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1885;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhTotEstad;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihNumMes;
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



    if ( SQLCODE )
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Update Estadisticas de Consumo **"
                                "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Update Estadisticas de Consumo **"
                                "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    return (TRUE);
}/*************************** END bfnUpdateEstadistSimple ***************************/

/*********************************************************************************************/
/*      Funcion : BOOL bfnInsertEstadistDoble (char *szCadenaInsert,long lCodCliente,        */
/*                                             int iNumMes,long lTotEstad1, long lTotEstad2) */
/*********************************************************************************************/

BOOL bfnInsertEstadistDoble (char *szCadenaInsert,long lCodCliente,int iNumMes,long lTotEstad1, long lTotEstad2)
{
    char modulo[]="bfnInsertEstadistDoble";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lhCodCliente;
		int     ihNumMes    ;
		long    lhTotEstad1 ;
		long    lhTotEstad2 ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente = lCodCliente;
    ihNumMes     = iNumMes    ;
    lhTotEstad1  = lTotEstad1 ;
    lhTotEstad2  = lTotEstad2 ;

    vDTrazasLog  (modulo,  "\n\t\t**  Entrada en bfnInsertEstadistDoble **"
                           "\n\t\t\t=> Cod. Cliente          : [%ld] "
                           "\n\t\t\t=> Nro. Mes              : [%d] "
                           "\n\t\t\t=> Total Seg. Gratis     : [%ld] "
                           "\n\t\t\t=> Total Seg. Adicionales: [%ld] "
                           "\n\t\t\t=> Cadena SQL            : [%s] "
                           ,LOG05,lhCodCliente,ihNumMes,lhTotEstad1, lhTotEstad2, szCadenaInsert);

    /* EXEC SQL PREPARE sql_insert_estadist FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1912;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )0;
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
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Estadisticas Ta_AcumAire **"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Estadisticas Ta_AcumAire **"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_insert_estadist USING :lhCodCliente, :ihNumMes, :lhTotEstad1, :lhTotEstad2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1931;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNumMes;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhTotEstad1;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhTotEstad2;
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
        return  (FALSE);
    }

    return (TRUE);
}/*************************** END bfnInsertEstadistDoble ***************************/

/*********************************************************************************************/
/*      Funcion : BOOL bfnUpdateEstadistDoble (char *szCadenaUpdate,long lCodCliente,        */
/*                                             int iNumMes,long lTotEstad1, long lTotEstad2) */
/*********************************************************************************************/

BOOL bfnUpdateEstadistDoble (char *szCadenaUpdate,long lCodCliente,int iNumMes,long lTotEstad1, long lTotEstad2)
{
    char modulo[]="bfnUpdateEstadistDoble";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long    lhCodCliente;
   			int     ihNumMes    ;
			long    lhTotEstad1  ;
			long    lhTotEstad2  ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente= lCodCliente;
    ihNumMes    = iNumMes    ;
    lhTotEstad1 = lTotEstad1 ;
    lhTotEstad2 = lTotEstad2 ;

    vDTrazasLog  (modulo,  "\n\t\t**  Entrada en bfnUpdateEstadistDoble **"
                           "\n\t\t\t=> Cod. Cliente          : [%ld] "
                           "\n\t\t\t=> Nro. Mes              : [%d] "
                           "\n\t\t\t=> Total Seg. Gratis     : [%ld] "
                           "\n\t\t\t=> Total Seg. Adicionales: [%ld] "
                           "\n\t\t\t=> Cadena SQL            : [%s] "
                           ,LOG05,lhCodCliente,ihNumMes,lhTotEstad1, lhTotEstad2, szCadenaUpdate);

    /* EXEC SQL PREPARE sql_update_estadist FROM :szCadenaUpdate; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1962;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaUpdate;
    sqlstm.sqhstl[0] = (unsigned long )0;
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
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Update Estadisticas de Consumo Ta_AcumAire**"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Update Estadisticas de Consumo Ta_AcumAire**"
                               "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_update_estadist USING :lhTotEstad1, :lhTotEstad2, :lhCodCliente, :ihNumMes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1981;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhTotEstad1;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhTotEstad2;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&ihNumMes;
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



    if ( SQLCODE )
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Update Estadisticas de Consumo Ta_AcumAire**"
                                "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Update Estadisticas de Consumo Ta_AcumAire**"
                                "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    return (TRUE);
}/*************************** END bfnUpdateEstadistDoble ***************************/

/*********************************************************************************/
/*      Funcion : void vfnInitCadenaFactCta (char * szCadena,long lCodCiclFact ) */
/*********************************************************************************/
/* Cadenas SQL para estadisticas de consumo del cliente                          */
/*********************************************************************************/

void vfnInitCadenaFactCta (char * szCadena,long lCodCiclFact )
{
    sprintf(szCadena,
            "SELECT A.COD_CLIENTE, A.TOT_FACTURA, B.COD_CUENTA "
              "FROM FA_FACTDOCU_%ld A, GE_CLIENTES B "
             "WHERE A.COD_CLIENTE=B.COD_CLIENTE AND A.COD_CICLFACT = :lhCodCiclFact", lCodCiclFact );

	return;
}/*************************** END vfnInitCadenaFactCta ***************************/

/********************************************************************/
/*      Funcion : void vfnInitCadenaAcumAireFrasoc(char * szCadena) */
/********************************************************************/

void vfnInitCadenaAcumAireFrasoc(char * szCadena)
{
    if (stLineaComando.ihIndTasador == TIPO_TASA_CLASICA)
    {
        sprintf(szCadena,
            "SELECT COD_CLIENTE, IND_DESTINO, SUM(SEG_CONSUMIDO)/60 "
              "FROM TA_ACUMAIREFRASOC "
            "WHERE COD_CICLFACT = :szhCodCiclFact "
            "GROUP BY COD_CLIENTE, IND_DESTINO " );
    }
    else if (stLineaComando.ihIndTasador == TIPO_TASA_ON_LINE)
    {
        sprintf(szCadena,
            "SELECT  TAC.COD_CLIENTE, "
                "DECODE(TAG.COD_TDIR,'PP',1,'PF',2,'PM',3,'PFF',4,1), "
                "SUM(TAC.DUR_FACT/60) "
            "FROM "
                "TOL_AGRULLAM TAG, "
                "TOL_ACUMOPER_TO TAC, "
                "TA_OPERADORES TAP "
            "WHERE "
                "TAC.COD_CICLFACT = :szhCodCiclFact "
            "AND TAC.COD_CARG = TAG.COD_CARG "
            "AND TAC.COD_CARG <> 0 "
            "AND TAC.TIP_DCTO <> 'ML' "
            "AND TAC.COD_OPERADOR = TAP.COD_OPERADOR "
            "AND TAP.COD_TOPE = 'M' "
            "AND TAP.COD_DOPE = 'P' "
            "GROUP BY "
                "TAC.COD_CLIENTE, "
                "DECODE(TAG.COD_TDIR,'PP',1,'PF',2,'PM',3,'PFF',4,1) ");
	}

    return;
}/*************************** END vfnInitCadenaAcumAireFrasoc ***************************/

/********************************************************************/
/*      Funcion : void vfnInitCadenaAcumAire      (char * szCadena) */
/********************************************************************/

void vfnInitCadenaAcumAire      (char * szCadena)
{
    if (stLineaComando.ihIndTasador == TIPO_TASA_CLASICA)
    {
       sprintf(szCadena,
            "SELECT COD_CLIENTE, NVL(SUM (SEG_GRATUITOS)/60, 0), NVL(SUM(SEG_CONSUMIDO-SEG_GRATUITOS)/60, 0) "
              "FROM TA_ACUMAIRE	"
             "WHERE COD_CICLFACT = :lhCodCiclFact "
             "GROUP BY COD_CLIENTE ");
	}
    else if (stLineaComando.ihIndTasador == TIPO_TASA_ON_LINE)
    {
       sprintf(szCadena,
            "SELECT COD_CLIENTE, NVL(SUM(CNT_INICIAL), 0), NVL(SUM((DUR_FACT/60)-CNT_INICIAL), 0) "
              "FROM TOL_ACUMOPER_TO "
            "WHERE COD_CICLFACT = :lhCodCiclFact "
            "AND TIP_DCTO = 'ML' "
            "AND COD_CARG = 0 "
            "GROUP BY COD_CLIENTE " );
    }
    return;
}/*************************** END vfnInitCadenaAcumAire ***************************/

/********************************************************************/
/*      Funcion : void vfnInitCadenaInsertFactCta (char * szCadena) */
/********************************************************************/

void vfnInitCadenaInsertFactCta (char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE "
                    "(COD_CLIENTE   ,   "
				    "NUM_MES        ,   "
					"MTO_FACTCICLO  ,   "
					"MTO_FACTNOCICLO,   "
					"MTO_NCCICLO	,   "
					"MTO_NCNOCICLO  ,   "
					"NUM_MINREBA	,   "
					"NUM_MINADIC	,   "
					"NUM_MINRFIJA   ,   "
					"NUM_MINOPER	,   "
					"NUM_MINFREC	,   "
					"NUM_MINESPE	,   "
					"NUM_MINTMOV	)   "
            "VALUES (:lhCodCliente,     "
					":ihNumMes    ,     "
					":lhTotEstad2 ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            ,     "
					"0            )     ");

	return;
}/*************************** END vfnInitCadenaInsertFactCta ***************************/

/********************************************************************/
/*      Funcion : void vfnInitCadenaUpdateFactCta (char * szCadena) */
/********************************************************************/

void vfnInitCadenaUpdateFactCta (char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET MTO_FACTCICLO=MTO_FACTCICLO + :lhTotEstad2 "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

return;
}/*************************** END vfnInitCadenaUpdateFactCta ***************************/

/**********************************************************************/
/*      Funcion : void vfnInitCadenaInsertMinTmovil (char * szCadena) */
/**********************************************************************/

void vfnInitCadenaInsertMinTmovil (char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE "
                   "(COD_CLIENTE  , "
					"NUM_MES      , "
					"NUM_MINTMOV  , "
					"MTO_FACTCICLO  , "
					"MTO_FACTNOCICLO, "
					"MTO_NCCICLO	, "
					"MTO_NCNOCICLO  , "
					"NUM_MINREBA	, "
					"NUM_MINADIC	, "
					"NUM_MINRFIJA   , "
					"NUM_MINOPER	, "
					"NUM_MINFREC	, "
					"NUM_MINESPE	) "
            "VALUES (:lhCodCliente, "
					":ihNumMes    , "
					":lhTotEstad  , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            ) ");

	return;
}/*************************** END vfnInitCadenaInsertMinTmovil ***************************/

/**********************************************************************/
/*      Funcion : void vfnInitCadenaUpdateMinTmovil (char * szCadena) */
/**********************************************************************/

void vfnInitCadenaUpdateMinTmovil (char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET NUM_MINTMOV=NUM_MINTMOV + :lhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}/*************************** END vfnInitCadenaUpdateMinTmovil ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaInsertRFija (char * szCadena) */
/******************************************************************/

void vfnInitCadenaInsertRFija (char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE "
                   "(COD_CLIENTE  , "
					"NUM_MES      , "
					"NUM_MINRFIJA , "
					"NUM_MINTMOV  ,   "
					"MTO_FACTCICLO  , "
					"MTO_FACTNOCICLO, "
					"MTO_NCCICLO	, "
					"MTO_NCNOCICLO  , "
					"NUM_MINREBA	, "
					"NUM_MINADIC	, "
					"NUM_MINOPER	, "
					"NUM_MINFREC	, "
					"NUM_MINESPE	) "
            "VALUES (:lhCodCliente, "
					":ihNumMes    , "
					":lhTotEstad  , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            ) ");

	return;
}/*************************** END vfnInitCadenaInsertRFija ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaUpdateRFija (char * szCadena) */
/******************************************************************/

void vfnInitCadenaUpdateRFija (char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET NUM_MINRFIJA=NUM_MINRFIJA + :lhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}/*************************** END vfnInitCadenaUpdateRFija ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaInsertOpera (char * szCadena) */
/******************************************************************/

void vfnInitCadenaInsertOpera (char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE "
                   "(COD_CLIENTE  , "
					"NUM_MES      , "
					"NUM_MINOPER  , "
					"NUM_MINRFIJA , "
					"NUM_MINTMOV  ,   "
					"MTO_FACTCICLO  , "
					"MTO_FACTNOCICLO, "
					"MTO_NCCICLO	, "
					"MTO_NCNOCICLO  , "
					"NUM_MINREBA	, "
					"NUM_MINADIC	, "
					"NUM_MINFREC	, "
					"NUM_MINESPE	) "
            "VALUES (:lhCodCliente, "
					":ihNumMes    , "
					":lhTotEstad  , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            ) ");

	return;
}/*************************** END vfnInitCadenaInsertOpera ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaUpdateOpera (char * szCadena) */
/******************************************************************/

void vfnInitCadenaUpdateOpera (char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET NUM_MINOPER=NUM_MINOPER + :lhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}/*************************** END vfnInitCadenaUpdateOpera ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaInsertFrecu (char * szCadena) */
/******************************************************************/

void vfnInitCadenaInsertFrecu (char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE "
                   "(COD_CLIENTE  , "
					"NUM_MES      , "
					"NUM_MINFREC  ,   "
					"NUM_MINOPER  ,   "
					"NUM_MINRFIJA ,   "
					"NUM_MINTMOV  ,   "
					"MTO_FACTCICLO  , "
					"MTO_FACTNOCICLO, "
					"MTO_NCCICLO	, "
					"MTO_NCNOCICLO  , "
					"NUM_MINREBA	, "
					"NUM_MINADIC	, "
					"NUM_MINESPE	) "
            "VALUES (:lhCodCliente, "
					":ihNumMes    , "
					":lhTotEstad  , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            , "
					"0            ) ");

	return;
}/*************************** END vfnInitCadenaInsertFrecu ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaUpdateFrecu (char * szCadena) */
/******************************************************************/

void vfnInitCadenaUpdateFrecu (char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET NUM_MINFREC=NUM_MINFREC + :lhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}/*************************** END vfnInitCadenaUpdateFrecu ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaInsertAire (char * szCadena)  */
/******************************************************************/

void vfnInitCadenaInsertAire (char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE "
                   "(COD_CLIENTE    , "
                    "NUM_MES        , "
					"NUM_MINREBA    , "
					"NUM_MINADIC    , "
					"NUM_MINFREC    , "
					"NUM_MINOPER    , "
					"NUM_MINRFIJA   , "
					"NUM_MINTMOV    , "
					"MTO_FACTCICLO  , "
					"MTO_FACTNOCICLO, "
					"MTO_NCCICLO	, "
					"MTO_NCNOCICLO  , "
					"NUM_MINESPE	)   "
            "VALUES (:lhCodCliente, "
					":ihNumMes    , "
					":lhTotSegGratis, "
					":lhTotSegAdicio, "
					"0              , "
					"0              , "
					"0              , "
					"0              , "
					"0              , "
					"0              , "
					"0              , "
					"0              , "
					"0              )   ");

	return;
}/*************************** END vfnInitCadenaInsertAire ***************************/

/******************************************************************/
/*      Funcion : void vfnInitCadenaUpdateAire (char * szCadena)  */
/******************************************************************/

void vfnInitCadenaUpdateAire (char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET NUM_MINREBA=NUM_MINREBA + :lhTotSegGratis, "
				        "NUM_MINADIC=NUM_MINADIC + :lhTotSegAdicio "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}/*************************** END vfnInitCadenaUpdateAire ***************************/

/***************************************************************/
/*      Funcion : BOOL bfnInsertFahBalance(long lCodCiclFact)  */
/***************************************************************/
/*  Rutina que inserta tablas FAT_BALANCE en historicas        */
/***************************************************************/

BOOL bfnInsertFahBalance(long lCodCiclFact)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCiclFact;
/* EXEC SQL END DECLARE SECTION; */ 


    lhCodCiclFact = lCodCiclFact;

    vDTrazasLog ( "	" , "\n\t\t\t Registros de balance Insert en FAH_BALANCE ",LOG01);

    /* EXEC SQL INSERT INTO FAH_BALANCE
                    (COD_CLIENTE,
                     COD_ITEM,
                     COD_TIPDOCUM,
                     COD_CICLFACT,
                     CAN_DOCUMENTO,
                     IMP_DOCUMENTO,
                     FEC_HISTORICO)
             (SELECT COD_CLIENTE,
                     COD_ITEM,
                     COD_TIPDOCUM,
                     COD_CICLFACT,
                     CAN_DOCUMENTO,
                     IMP_DOCUMENTO,
                     SYSDATE
             FROM FAT_BALANCE
             WHERE COD_CICLFACT = :lhCodCiclFact); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAH_BALANCE (COD_CLIENTE,COD_ITEM,COD_TIPDOCU\
M,COD_CICLFACT,CAN_DOCUMENTO,IMP_DOCUMENTO,FEC_HISTORICO)(select COD_CLIENTE ,\
COD_ITEM ,COD_TIPDOCUM ,COD_CICLFACT ,CAN_DOCUMENTO ,IMP_DOCUMENTO ,SYSDATE  f\
rom FAT_BALANCE where COD_CICLFACT=:b0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2012;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
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
        vDTrazasError("bfnInsertFatBalance","\n\t**  Error INSERT into FAH_BALANCE **"
                                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DELETE FROM FAT_BALANCE
             WHERE COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from FAT_BALANCE  where COD_CICLFACT=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2031;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
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
        vDTrazasError("bfnInsertFatBalance","\n\t**  Error DELETE from  FAT_BALANCE **"
                                             "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

        vDTrazasLog ( "bfnInsertFatBalance" , "\n\t\t\t Registros FAT_BALANCE Borrados : [%d]",LOG01,sqlca.sqlerrd[2]);

    return (TRUE);

}/* ************** END bfnInsertFatBalance ***************** */

/***************************************************************************/
/*      Funcion : BOOL bObtieneIndicadorTasador(long lCodCicloFacturacion) */
/***************************************************************************/
/* Rutina que obtiene el indicador de taasdor, si es Tasación Normal       */
/* o tasacion por TOL                                                      */
/* SAAM-20021230                                                           */
/***************************************************************************/

BOOL bObtieneIndicadorTasador(long lCodCicloFacturacion)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCiclFact;
    int  ihIndTas;
    /* EXEC SQL END DECLARE SECTION; */ 


    stLineaComando.ihIndTasador = 0;

    lhCodCiclFact = lCodCicloFacturacion;

    /* EXEC SQL
    SELECT nvl(IND_TASADOR ,0) /o SAAM-20021230 Asume por defecto valor 0 o/
    INTO   :ihIndTas
    FROM   FA_CICLFACT
    WHERE  COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select nvl(IND_TASADOR,0) into :b0  from FA_CICLFACT wher\
e COD_CICLFACT=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2050;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndTas;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasError("ihObtieneIndicadorTasador","\n\t**  Error SELECT from  FA_CICLFACT **"
                                                  "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  FALSE;
    }

    stLineaComando.ihIndTasador = ihIndTas;

    return TRUE;
}/*************************** END bObtieneIndicadorTasador ***************************/

/*********************************************************************************/
/*      Funcion : BOOL bfnDBPasarTolAcumOper ( int iProducto ,long lNumProceso ) */
/*********************************************************************************/
/* * Pasamos datos de la tabla TOL_ACUMOPER --> TOL_HISTACUMOPER               * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de        * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con         * */
/* * NUM_PROCESO igual al Pasado como parametro en la funcion                  * */
/* * SAAM-20021230                                                             * */
/* ***************************************************************************** */

BOOL bfnDBPasarTolAcumOper ( int iProducto ,long lNumProceso )
{
    char    szCadenaInsert[1024]="";
    char    szCadenaDelete[1024]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (szPasar,"\n\t********************************************************************************"
                          "\n\t\t\t**  Paso Historico TOL_ACUMOPER ==>  TOL_HISTACUMOPER **"
                          "\n\t********************************************************************************"
                          ,LOG03);

    vDTrazasLog ( szPasar,  "\n\t Entrada en bfnDBPasarTolAcumOper  "
                            "\n\t => NumProceso .. [%ld]"
                            , LOG05,lNumProceso);


    vfnInitCadenaInsertTolAcumOper(szCadenaInsert);


    vfnInitCadenaDeleteTolAcumOper(szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_tol FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2073;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_tol  USING    :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2092;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE )
    {

        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,   "\n\t**  Error en SQL-EXECUTE Insert TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_tol FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2111;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Delete TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Delete TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_tol  USING       :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2130;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Delete TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Delete TOL_ACUMOPER **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    vDTrazasLog(szPasar," \n\t\t\t   Estadisticas  TOL_ACUMOPER  "
                        " \n\t\t\t    Filas Insertadas     [%ld]      "
                        " \n\t\t\t    Filas Borradas       [%ld]      "
                        " \n\t\t\t------------------------------------",
                        LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szPasar,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit TOL_ACUMOPER          "
                                " \n\t-----------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t-----------------------------------------"
                                " \n\tFallo en el Commit TOL_ACUMOPER          "
                                " \n\t-----------------------------------------",
                                LOG01);
        return (FALSE);
    }
    vDTrazasLog  (szPasar,"\n\t****************************************"
                              "****************************************",LOG03);
    return (TRUE);

}/*************************** END bfnDBPasarTolAcumOper ***************************/

/**********************************************************************/
/*      Funcion : void vfnInitCadenaInsertTolAcumOper(char *szCadena) */
/**********************************************************************/
/* * Inicilaiza Sql para Insertar TOL_ACUMOPER en Historico         * */
/* ****************************************************************** */

void vfnInitCadenaInsertTolAcumOper(char *szCadena)
{
    sprintf(szCadena,
            "INSERT INTO TOL_HISTACUMOPER( "
                "COD_OPERADOR , "
                "COD_REGI     , "
                "COD_GRUPO    , "
                "COD_CLIENTE  , "
                "NUM_ABONADO  , "
                "COD_CICLFACT , "
                "NUM_PROCESO  , "
                "IND_EXEDENTE , "
                "COD_PLAN     , "
                "IND_BILLETE  , "
                "COD_CARG     , "
                "TIP_DCTO     , "
                "COD_DCTO     , "
                "COD_ITEM     , "
                "IND_UNIDAD   , "
                "CNT_INICIAL  , "
                "CNT_AUX      , "
                "MTO_REAL     , "
                "MTO_FACT     , "
                "MTO_DCTO     , "
                "DUR_REAL     , "
                "DUR_FACT     , "
                "DUR_DCTO     , "
 /* SAAM-20040910 Homologacion HD-200407191173 */
                "TIP_MONE     , "
                "CNT_LLAM_REAL, "
                "CNT_LLAM_DCTO, "
                "CNT_LLAM_FACT, "
                "COD_AREAA    ) " /* SAAM-20060106 Se ioncluye nuevo campo, RA-200512270425 */
            "SELECT "
                "COD_OPERADOR , "
                "COD_REGI     , "
                "COD_GRUPO    , "
                "COD_CLIENTE  , "
                "NUM_ABONADO  , "
                "COD_CICLFACT , "
                "NUM_PROCESO  , "
                "IND_EXEDENTE , "
                "COD_PLAN     , "
                "IND_BILLETE  , "
                "COD_CARG     , "
                "TIP_DCTO     , "
                "COD_DCTO     , "
                "COD_ITEM     , "
                "IND_UNIDAD   , "
                "CNT_INICIAL  , "
                "CNT_AUX      , "
                "MTO_REAL     , "
                "MTO_FACT     , "
                "MTO_DCTO     , "
                "DUR_REAL     , "
                "DUR_FACT     , "
                "DUR_DCTO     , "
 /* SAAM-20040910 Homologacion HD-200407191173 */
                "TIP_MONE     , "
                "CNT_LLAM_REAL, "
                "CNT_LLAM_DCTO, "
                "CNT_LLAM_FACT, "
                "COD_AREAA      " /* SAAM-20060106 Se ioncluye nuevo campo, RA-200512270425 */
            "FROM    TOL_ACUMOPER_TO "
            "WHERE   NUM_PROCESO = :lhNumProceso ");

}/**************** END vfnInitCadenaInsertTolAcumOper *****************/

/**********************************************************************/
/*      Funcion : void vfnInitCadenaDeleteTolAcumOper(char *szCadena) */
/**********************************************************************/
/* * Inicilaiza Sql para Borrar TOL_ACUMOPER en Historico             */
/* ****************************************************************** */

void vfnInitCadenaDeleteTolAcumOper(char *szCadena)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    TOL_ACUMOPER_TO "
        "WHERE   NUM_PROCESO = :lhNumProceso ");

}/**************** END vfnInitCadenaDeleteTolAcumOper *****************/

/***********************************************************************/
/*      Funcion : BOOL bfnPrincipalPasoConsumoCiclo(long lCodCiclFact) */
/***********************************************************************/

BOOL bfnPrincipalPasoConsumoCiclo(long lCodCiclFact)
{
    if ( !bObtieneCantidadCiclos())
    {
        vDTrazasLog  (szPasar,  " \n\t---------------------------------------------------------"
                                " \n\t Fallo en la obtencion de parámetro CANT_CICLOS_INFORMAR "
                                " \n\t---------------------------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t---------------------------------------------------------"
                                " \n\t Fallo en la obtención de parámetro CANT_CICLOS_INFORMAR "
                                " \n\t---------------------------------------------------------",
                                LOG01);
        return (FALSE);
    }         
    
/*  Insertar en Tabla FA_CONSUMO_CICLO_CLIE_TO desde FA_HISTDOCU con lCodCiclFact */


    if ( !bfnDBPasarConsumoCiclo( lCodCiclFact ))
    {
        vDTrazasLog  (szPasar,  " \n\t--------------------------------"
                                " \n\t Fallo Paso Tabla Consumo Ciclo "
                                " \n\t--------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t--------------------------------"
                                " \n\t Fallo Paso Tabla Consumo Ciclo "
                                " \n\t--------------------------------",
                                LOG01);                             
                                
        return (FALSE);
    }
    

/*  Copiar Tabla FA_CONSUMO_CICLO_CLIE_TO a FA_HISTCONSUMO_CLIENTES_lCodCiclFact */

    if ( !bfnDBPasarHistoricoConsumoCiclo( lCodCiclFact ))
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------"
                                " \n\t Fallo Copia Tabla Consumo Ciclo   "
                                " \n\t-----------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t-----------------------------------"
                                " \n\t Fallo Copia Tabla Consumo Ciclo   "
                                " \n\t-----------------------------------",
                                LOG01);    	
        return (FALSE);    	
    } 
       

/*  Borrar Registros desde Tabla FA_CONSUMO_CICLO_CL de acuerdo a Parametro CANT_CICLOS_INFORMAR */

    if ( !bfnDBBorrarNAntiguosConsumoCiclo( ihCantCiclFact ))
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------"
                                " \n\t Fallo Delete Tabla Consumo Ciclo  "
                                " \n\t-----------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t-----------------------------------"
                                " \n\t Fallo Delete Tabla Consumo Ciclo  "
                                " \n\t-----------------------------------",
                                LOG01);    	
        return (FALSE);    	
    }    
    
    return TRUE;    
}/**********************  END bfnPrincipalPasoConsumoCiclo ***********************/

/*************************************************/
/*      Funcion : BOOL bObtieneCantidadCiclos()  */
/*************************************************/

BOOL bObtieneCantidadCiclos()
{
    int iCantCicl;
    
    iCantCicl = 0;

    /* EXEC SQL
      SELECT VALOR_NUMERICO
      INTO   :iCantCicl
      FROM   FA_PARAMETROS_SIMPLES_VW
      WHERE  NOM_PARAMETRO = 'CANT_CICLOS_INFORMAR'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VALOR_NUMERICO into :b0  from FA_PARAMETROS_SIMPLE\
S_VW where NOM_PARAMETRO='CANT_CICLOS_INFORMAR'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2149;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCantCicl;
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
    {
        vDTrazasError("ihObtieneCantidadCiclos","\n\t**  Error SELECT from  FA_PARAMETROS_SIMPLES_VW **"
                                                "\n\t\t=> Error : [%ld]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  FALSE;
    }
    
    if (iCantCicl == 0)
    {
    	vDTrazasError("ihObtieneCantidadCiclos","\n\t**  Error Parámetro CANT_CICLOS_INFORMAR no inicializado. **"
                                                ,LOG01);
        return  FALSE;
    }

    ihCantCiclFact = iCantCicl;

    return TRUE;
}/**********************  END bObtieneCantidadCiclos() ***********************/

/*******************************************************************/
/*      Funcion : BOOL bfnDBPasarConsumoCiclo( long lCodCiclFact ) */
/*******************************************************************/

BOOL bfnDBPasarConsumoCiclo( long lCodCiclFact )
{
    char    szCadenaInsert[1024]="";
    long    lFilasInsert = 0       ;

    sprintf(szCadenaInsert,
        "INSERT INTO FA_CONSUMO_CICLO_CLIE_TO ( "
                "COD_CLIENTE      , COD_CICLFACT     , "
                "FEC_EMISION      , MTO_FACTCICLO    ) "                
        "SELECT "
                "COD_CLIENTE      , COD_CICLFACT     ,"
                "FEC_EMISION      , TOT_CARGOSME      "
        "FROM    FA_HISTDOCU "
        "WHERE   COD_CICLFACT = :lCodCiclFact ");


    /* EXEC SQL PREPARE sql_insert_consumo FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2168;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);                               
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_insert_consumo  USING :lCodCiclFact ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2187;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodCiclFact;
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



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Insert CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);                                                                                 
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);    
   
    vDTrazasLog(szPasar," \n\t\t\t** Estadisticas  FA_CONSUMO_CICLO_CLIE_TO **"
                        " \n\t\t\t=> Filas Insertadas     :[%ld]"
                        " \n\t\t\t------------------------------------------",
                        LOG03,lFilasInsert);

    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t--------------------------------------------"
                                " \n\tFallo en el Commit FA_CONSUMO_CICLO_CLIE_TO "
                                " \n\t--------------------------------------------",
                                LOG01);
        vDTrazasError(szPasar,  " \n\t--------------------------------------------"
                                " \n\tFallo en el Commit FA_CONSUMO_CICLO_CLIE_TO "
                                " \n\t--------------------------------------------",
                                LOG01);                                                              
        return (FALSE);
    }
    
    return (TRUE);
}/* **************** * END bfnDBPasarConsumoCiclo * ******************** */

/*****************************************************************************/
/*      Funcion : BOOL bfnDBPasarHistoricoConsumoCiclo ( long lCodCiclFact ) */
/*****************************************************************************/

BOOL bfnDBPasarHistoricoConsumoCiclo ( long lCodCiclFact )
{
    char    szCadenaSQL[1024] ="";	
    long    lFilasInsert = 0       ;
        
    sprintf(szCadenaSQL,
        "INSERT INTO FA_HISTCONSUMO_CLIENTES_%ld ( "
                "COD_CLIENTE, COD_CICLFACT, "
                "FEC_EMISION, MTO_FACTCICLO) "                
        "SELECT "
                "COD_CLIENTE, COD_CICLFACT, "
                "FEC_EMISION, MTO_FACTCICLO "
        " FROM   FA_CONSUMO_CICLO_CLIE_TO A "
        " WHERE EXISTS (SELECT 1 FROM FA_CICLOCLI B "
		"	             WHERE A.COD_CLIENTE  = B.COD_CLIENTE "
        "			       AND EXISTS (SELECT 1 FROM FA_CICLFACT C "
        "			                    WHERE COD_CICLFACT = %ld "
        "          					      AND B.COD_CICLO = C.COD_CICLO)) "
        , lCodCiclFact, lCodCiclFact);
                
    /* EXEC SQL PREPARE sql_insert_historico FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2206;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-PREPARE Insert HISTORICO CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-PREPARE Insert HISTORICO CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }
    
    /* EXEC SQL EXECUTE sql_insert_historico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2225;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE )
    {
        vDTrazasError(szPasar,  "\n\t**  Error en SQL-EXECUTE Insert HISTORICO CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        vDTrazasLog  (szPasar,  "\n\t**  Error en SQL-EXECUTE Insert HISTORICO CONSUMO CICLO **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);
   
    vDTrazasLog(szPasar," \n\t\t\t** Estadisticas  FA_HISTCONSUMO_CLIENTES_%ld **"
                        " \n\t\t\t=> Filas Insertadas     :[%ld]"
                        " \n\t\t\t---------------------------------------------",
                        LOG03, lCodCiclFact, lFilasInsert);
                                               

    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szPasar,  " \n\t-----------------------------------------------"
                                " \n\tFallo en el Commit FA_HISTCONSUMO_CLIENTES_%ld "
                                " \n\t-----------------------------------------------",
                                LOG01, lCodCiclFact);
        vDTrazasError(szPasar,  " \n\t-----------------------------------------------"
                                " \n\tFallo en el Commit FA_HISTCONSUMO_CLIENTES_%ld "
                                " \n\t-----------------------------------------------",
                                LOG01, lCodCiclFact);
        return (FALSE);
    }        
        
    return TRUE;
}/* **************** * END bfnDBPasarHistoricoConsumoCiclo * ******************** */

/******************************************************************************/
/*      Funcion : BOOL bfnDBBorrarNAntiguosConsumoCiclo ( long lCodCiclFact ) */
/******************************************************************************/
/* Elimina registros de la Tabla FA_CONSUMO_CICLO_CLIE_TO, manteniendo la     */
/* de registros por Cliente de acuerdo al parámetro CANT_FILAS_INFORMAR       */
/******************************************************************************/

BOOL bfnDBBorrarNAntiguosConsumoCiclo (int ihCantCiclFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

     long    lFilasDelete = 0       ;
    /* EXEC SQL END DECLARE SECTION; */ 
	
    
    /* EXEC SQL EXECUTE
        BEGIN
          :lFilasDelete := Fa_Borra_Nconsumo_Fn(:ihCantCiclFact);
        END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :lFilasDelete := Fa_Borra_Nconsumo_Fn ( :ihCantCicl\
Fact ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )2240;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lFilasDelete;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCantCiclFact;
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



    if ((SQLCODE != SQLOK) || (lFilasDelete < 0))
    {
       vDTrazasLog("bfnDBBorrarNAntiguosConsumoCiclo", "Error en DELETE bfnDBBorrarNAntiguosConsumoCiclo(%s)", LOG05,SQLERRM);
       return(FALSE);
    }
    
    vDTrazasLog(szPasar," \n\t\t\t** Estadisticas  FA_CONSUMO_CICLO_CLIE_TO **"
                        " \n\t\t\t--------------------------------------------"
                        " \n\t\t\t=> Parámetro Cantidad Filas Informar :[%d]  "
                        " \n\t\t\t=> Filas Eliminadas                  :[%ld] "
                        " \n\t\t\t--------------------------------------------",
                        LOG03, ihCantCiclFact, lFilasDelete);
    
    return TRUE;
}/* **************** * END bfnDBBorrarNAntiguosConsumoCiclo * ******************** */

/* ************************ FIN MODIFICACIONES JHTO ************************************************* */
/* ************************************************************************************************** */

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
