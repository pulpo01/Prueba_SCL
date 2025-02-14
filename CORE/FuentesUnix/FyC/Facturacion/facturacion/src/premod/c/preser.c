
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
    "./pc/preser.pc"
};


static unsigned int sqlctx = 866075;


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
   unsigned char  *sqhstv[30];
   unsigned long  sqhstl[30];
            int   sqhsts[30];
            short *sqindv[30];
            int   sqinds[30];
   unsigned long  sqharm[30];
   unsigned long  *sqharc[30];
   unsigned short  sqadto[30];
   unsigned short  sqtdso[30];
} sqlstm = {12,30};

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

 static const char *sq0005 = 
"select B.COD_SERVICIO ,B.COD_CONCEPTO ,A.IMP_TARIFA ,A.COD_MONEDA  from GA_T\
ARIFAS A ,GA_ACTUASERV B where (((((((((A.COD_PRODUCTO=:b0 and A.COD_ACTABO=:b\
1) and A.COD_TIPSERV=:b2) and A.COD_SERVICIO=B.COD_SERVICIO) and A.COD_PLANSER\
V=:b3) and A.FEC_DESDE<=TO_DATE(:b4,'YYYYMMDDHH24MISS')) and (A.FEC_HASTA>=TO_\
DATE(:b4,'YYYYMMDDHH24MISS') or A.FEC_HASTA is null )) and B.COD_PRODUCTO=:b0)\
 and B.COD_ACTABO=:b1) and B.COD_TIPSERV=:b2)           ";

 static const char *sq0001 = 
"select  /*+   index (A, PK_GA_SERVSUPLABO)  +*/ A.COD_CONCEPTO ,TO_CHAR(A.FE\
C_ALTACEN,:b0) ,TO_CHAR(A.FEC_BAJABD,:b0) ,TO_CHAR(A.FEC_ALTABD,:b0) ,TO_CHAR(\
A.FEC_BAJACEN,:b0) ,B.IND_PRO ,A.COD_SERVICIO ,C.COD_MONEDA ,C.IMP_TARIFA ,NVL\
(B.IND_COBRETR,0)  from GA_SERVSUPLABO A ,GA_SERVSUPL B ,GA_TARIFAS C where ((\
((((((((((((((A.NUM_ABONADO=:b4 and A.COD_PRODUCTO=:b5) and A.IND_ESTADO<>:b6)\
 and B.COD_PRODUCTO=A.COD_PRODUCTO) and B.COD_SERVICIO=A.COD_SERVICIO) and A.C\
OD_CONCEPTO is  not null ) and A.FEC_ALTACEN is  not null ) and A.FEC_ALTACEN<\
=TO_DATE(:b7,:b0)) and NVL(A.FEC_BAJABD,TO_DATE('30001201000000',:b0))>=TO_DAT\
E(:b10,:b0)) and C.COD_ACTABO=:b12) and C.COD_PRODUCTO=:b5) and C.COD_SERVICIO\
=A.COD_SERVICIO) and C.COD_TIPSERV=:b14) and C.COD_PLANSERV=:b15) and C.FEC_DE\
SDE<=TO_DATE(:b16,:b0)) and C.FEC_HASTA>=TO_DATE(:b16,:b0)) and C.IMP_TARIFA<>\
0.0)           ";

 static const char *sq0002 = 
"select  /*+   index (A, PK_GA_SERVSUPLABO)  +*/ A.COD_CONCEPTO ,TO_CHAR(A.FE\
C_ALTACEN,:b0) ,TO_CHAR(A.FEC_BAJABD,:b0) ,TO_CHAR(A.FEC_ALTABD,:b0) ,TO_CHAR(\
A.FEC_BAJACEN,:b0) ,B.IND_PRO ,A.COD_SERVICIO ,C.COD_MONEDA ,C.IMP_TARIFA ,NVL\
(B.IND_COBRETR,0)  from GA_SERVSUPLABO A ,GA_SERVSUPL B ,GA_TARIFAS C ,GA_SERV\
SUPL_COB_TO D where (((((((((((((((((((A.NUM_ABONADO=:b4 and A.COD_PRODUCTO=:b\
5) and A.IND_ESTADO<>:b6) and B.COD_PRODUCTO=A.COD_PRODUCTO) and B.COD_SERVICI\
O=A.COD_SERVICIO) and A.COD_CONCEPTO is  not null ) and A.FEC_ALTACEN is  not \
null ) and A.FEC_ALTACEN<=TO_DATE(:b7,:b0)) and NVL(A.FEC_BAJABD,TO_DATE('3000\
1201000000',:b0))>=TO_DATE(:b10,:b0)) and A.FEC_ALTACEN<=TO_DATE(:b12,:b0)) an\
d C.COD_ACTABO=:b14) and C.COD_PRODUCTO=:b5) and C.COD_SERVICIO=A.COD_SERVICIO\
) and C.COD_TIPSERV=:b16) and C.COD_PLANSERV=:b17) and C.FEC_DESDE<=TO_DATE(:b\
12,:b0)) and C.FEC_HASTA>=TO_DATE(:b12,:b0)) and C.IMP_TARIFA<>0.0) and D.COD_\
SERVICIO=B.COD_SERVICIO) and D.COD_SERVSUPL=B.COD_SERVSUPL)           ";

 static const char *sq0011 = 
"select ROWID ,TO_CHAR(FEC_DESDE,:b0) ,TO_CHAR(FEC_HASTA,:b0) ,COD_CARGOBASIC\
O ,COD_PLANSERV ,COD_PLANCOM ,TO_CHAR(NUM_CELULAR) ,COD_GRPSERV ,TIP_PLANTARIF\
 ,COD_PLANTARIF ,COD_GRUPO  from GA_INTARCEL where (((((COD_CLIENTE=:b2 and NU\
M_ABONADO=:b3) and IND_NUMERO=:b4) and FEC_DESDE<TO_DATE(:b5,:b0)) and COD_CIC\
LO=:b7) and FEC_HASTA>=TO_DATE(:b8,:b0)) order by FEC_DESDE desc   for update ";

 static const char *sq0027 = 
"select COD_CRITERIO ,VAL_CRITERIO  from FA_CRITSERV where ((COD_SERVICIO=:b0\
 and COD_PRODUCTO=:b1) and COD_CRITERIO=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,3,581,0,4,224,0,0,30,10,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
140,0,0,4,64,0,4,528,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
163,0,0,5,444,0,9,666,0,0,9,9,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
214,0,0,5,0,0,13,677,0,0,4,0,0,1,0,2,5,0,0,2,3,0,0,2,4,0,0,2,5,0,0,
245,0,0,5,0,0,15,742,0,0,0,0,0,1,0,
260,0,0,1,871,0,9,938,0,0,20,20,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
355,0,0,2,1004,0,9,943,0,0,22,22,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
458,0,0,1,0,0,13,957,0,0,10,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,3,0,0,
513,0,0,2,0,0,13,971,0,0,10,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,3,0,0,
568,0,0,6,203,0,6,1159,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,3,0,0,2,
3,0,0,2,5,0,0,2,3,0,0,
615,0,0,7,137,0,4,1259,0,0,3,2,0,1,0,1,97,0,0,1,5,0,0,2,3,0,0,
642,0,0,1,0,0,15,1294,0,0,0,0,0,1,0,
657,0,0,2,0,0,15,1298,0,0,0,0,0,1,0,
672,0,0,8,165,0,4,1561,0,0,3,2,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,
699,0,0,9,55,0,5,1932,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
722,0,0,10,105,0,5,2056,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
749,0,0,11,388,0,9,2519,0,0,10,10,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,97,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,5,0,0,
804,0,0,11,0,0,13,2563,0,0,11,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
863,0,0,11,0,0,15,2592,0,0,0,0,0,1,0,
878,0,0,12,132,0,4,2941,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
913,0,0,13,191,0,4,2955,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
944,0,0,14,184,0,4,2965,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
975,0,0,15,252,0,6,3037,0,0,10,10,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,2,5,0,0,2,4,0,
0,2,5,0,0,2,5,0,0,2,3,0,0,2,97,0,0,2,4,0,0,
1030,0,0,16,147,0,4,3418,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,
1069,0,0,17,186,0,4,3431,0,0,7,6,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,
1112,0,0,18,128,0,4,3466,0,0,5,4,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,
1147,0,0,19,140,0,4,3478,0,0,5,4,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,
1182,0,0,20,182,0,4,3495,0,0,5,4,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,
1217,0,0,21,203,0,6,3601,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,2,3,0,0,
1264,0,0,22,137,0,4,3701,0,0,3,2,0,1,0,1,97,0,0,1,5,0,0,2,3,0,0,
1291,0,0,23,203,0,6,3789,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,2,3,0,0,
1338,0,0,24,118,0,4,4027,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
1361,0,0,25,161,0,4,4142,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1392,0,0,26,111,0,4,4631,0,0,4,2,0,1,0,2,3,0,0,2,3,0,0,1,5,0,0,1,3,0,0,
1423,0,0,27,131,0,9,4679,0,0,3,3,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,
1450,0,0,27,0,0,13,4688,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
1473,0,0,27,0,0,13,4699,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
1496,0,0,27,0,0,15,4710,0,0,0,0,0,1,0,
1511,0,0,28,155,0,4,4818,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,
};


/*****************************************************************************/
/* Funcion     : preser.pc                                                   */
/* Descripcion : Declaracion de funciones para PreBilling Servicios          */
/*****************************************************************************/

#define _PRESER_PC_

#include "preser.h"

extern char * alltrim(char *s);

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


char    szFecUltFact [15];
char    szPlanTarifarioArray [MAX_ARRAY][3+1];
int     ijPtc;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char  szFecBaja_Infaccel[15];/* EXEC SQL VAR szFecBaja_Infaccel IS STRING(15); */ 

     char  szFecDesdeOCargos [15];/* EXEC SQL VAR szFecDesdeOCargos  IS STRING(15); */ 

     char  szpFormatoFec     [17];/* EXEC SQL VAR szpFormatoFec      IS STRING(17); */ 

     long  lhpNumAbonado;
     int   ihpCodProducto;
     int   ihpSeis;
     int   ihpZero;
     char  szpFecHasta       [15];/* EXEC SQL VAR szpFecHasta        IS STRING(15); */ 

     char  szpFecDesde       [15];/* EXEC SQL VAR szpFecDesde        IS STRING(15); */ 

     char  szpFecEmision     [15];/* EXEC SQL VAR szpFecEmision      IS STRING(15); */ 

     char  szpCodActabo       [3];/* EXEC SQL VAR szpCodActabo       IS STRING(3); */ 

     char  szpCodTipServ      [2];/* EXEC SQL VAR szpCodTipServ      IS STRING(2); */ 

     char  szpCodPlanServ     [4];/* EXEC SQL VAR szpCodPlanServ     IS STRING(4); */ 

/* EXEC SQL END DECLARE SECTION; */ 



/* EXEC SQL DECLARE Cur_ServSupl CURSOR for
    SELECT  /o+  index (A, PK_GA_SERVSUPLABO) o/
            A.COD_CONCEPTO,
            TO_CHAR (A.FEC_ALTACEN,:szpFormatoFec),
            TO_CHAR (A.FEC_BAJABD ,:szpFormatoFec),
            TO_CHAR (A.FEC_ALTABD ,:szpFormatoFec),
            TO_CHAR (A.FEC_BAJACEN,:szpFormatoFec),
            B.IND_PRO,
            A.COD_SERVICIO,
            C.COD_MONEDA,
            C.IMP_TARIFA,
            NVL(B.IND_COBRETR,0)  /o P-MIX-09003 o/
       FROM GA_SERVSUPLABO A,
            GA_SERVSUPL B,
            GA_TARIFAS C
      WHERE A.NUM_ABONADO   = :lhpNumAbonado
        AND A.COD_PRODUCTO  = :ihpCodProducto
        AND A.IND_ESTADO   <> :ihpSeis
        AND B.COD_PRODUCTO  = A.COD_PRODUCTO
        AND B.COD_SERVICIO  = A.COD_SERVICIO
        AND A.COD_CONCEPTO  IS NOT NULL
        AND A.FEC_ALTACEN   IS NOT NULL
        AND A.FEC_ALTACEN  <= TO_DATE(:szpFecHasta,:szpFormatoFec)
        AND NVL(A.FEC_BAJABD, TO_DATE('30001201000000',:szpFormatoFec)) >= TO_DATE(:szpFecDesde,:szpFormatoFec)
        /oAND A.FEC_ALTACEN  <=  TO_DATE(:szpFecEmision,:szpFormatoFec)o/ /o P-MIX-09003 o/
        AND C.COD_ACTABO = :szpCodActabo
        AND C.COD_PRODUCTO = :ihpCodProducto
        AND C.COD_SERVICIO = A.COD_SERVICIO
        AND C.COD_TIPSERV = :szpCodTipServ
        AND C.COD_PLANSERV = :szpCodPlanServ
        AND C.FEC_DESDE <= TO_DATE(:szpFecEmision,:szpFormatoFec)
        AND C.FEC_HASTA >= TO_DATE(:szpFecEmision,:szpFormatoFec)
        AND C.IMP_TARIFA <> 0.0; */ 
       

/* EXEC SQL DECLARE Cur_ServSuplSusp CURSOR for
    SELECT  /o+  index (A, PK_GA_SERVSUPLABO) o/
            A.COD_CONCEPTO,
            TO_CHAR (A.FEC_ALTACEN,:szpFormatoFec),
            TO_CHAR (A.FEC_BAJABD ,:szpFormatoFec),
            TO_CHAR (A.FEC_ALTABD ,:szpFormatoFec),
            TO_CHAR (A.FEC_BAJACEN,:szpFormatoFec),
            B.IND_PRO,
            A.COD_SERVICIO,
            C.COD_MONEDA,
            C.IMP_TARIFA,
            NVL(B.IND_COBRETR,0)  /o P-MIX-09003 o/            
       FROM GA_SERVSUPLABO A,
            GA_SERVSUPL B,
            GA_TARIFAS C,
            GA_SERVSUPL_COB_TO D
      WHERE A.NUM_ABONADO   = :lhpNumAbonado
        AND A.COD_PRODUCTO  = :ihpCodProducto
        AND A.IND_ESTADO   <> :ihpSeis
        AND B.COD_PRODUCTO  = A.COD_PRODUCTO
        AND B.COD_SERVICIO  = A.COD_SERVICIO
        AND A.COD_CONCEPTO  IS NOT NULL
        AND A.FEC_ALTACEN   IS NOT NULL
        AND A.FEC_ALTACEN  <= TO_DATE(:szpFecHasta,:szpFormatoFec)
        AND NVL(A.FEC_BAJABD, TO_DATE('30001201000000',:szpFormatoFec)) >= TO_DATE(:szpFecDesde,:szpFormatoFec)
        AND A.FEC_ALTACEN  <=  TO_DATE(:szpFecEmision,:szpFormatoFec)
        AND C.COD_ACTABO = :szpCodActabo
        AND C.COD_PRODUCTO = :ihpCodProducto
        AND C.COD_SERVICIO = A.COD_SERVICIO
        AND C.COD_TIPSERV  = :szpCodTipServ
        AND C.COD_PLANSERV = :szpCodPlanServ
        AND C.FEC_DESDE   <= TO_DATE(:szpFecEmision,:szpFormatoFec)
        AND C.FEC_HASTA   >= TO_DATE(:szpFecEmision,:szpFormatoFec)
        AND C.IMP_TARIFA  <> 0.0
        AND D.COD_SERVICIO = B.COD_SERVICIO
        AND D.COD_SERVSUPL = B.COD_SERVSUPL; */ 


/*****************************************************************************/
/*                        funcion : bIFAbonos                                */
/* -Funcion que carga los Abonados activos cuyos servicios van a ser factura-*/
/*  dos.                                                                     */
/*  En stAbonoCli tendremos los Abonados del Cliente (stCliente.lCodCliente),*/
/*  en la tabla Fa_CicloCli                                                  */
/* -Carga infomacion para los Abonados del cliente sobre las Ga_Infa% (infor-*/
/*  macion sobre el alta del Abonado).                                       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bIFAbonos (ABONOCLI stAboCli,int iTipoFact)
{
    long lInd  = 0   ;
    BOOL bRes  = TRUE;

    vDTrazasLog (szExeName,"\n\t\t* Cargando ABONOS ",LOG03);

    strncpy (stAnomProceso.szDesProceso,"Carga Abonos", sizeof (stAnomProceso.szDesProceso));

    memset (&stEstAbonos,0,sizeof(ESTADIST));
    memset (&stEstCargos,0,sizeof(ESTADIST));
    
    /* Limpiar estructura Plan PTI */
    memset(szPlanTarifarioArray,0,sizeof(szPlanTarifarioArray));
    ijPtc = 0;
    
    /*****/
    
    /*****/    

    while (bRes && lInd < stAboCli.lNumAbonados)
    {
        strcpy(szFecUltFact,stAboCli.pCicloCli[lInd].szFecUltFact);

        bRes = bCargaAbonosCelular (&stAboCli.pCicloCli[lInd],iTipoFact);
        vfnEstadisticas (stAboCli.pCicloCli[lInd].lNumAbonado);
        
        if (bRes)
        {
            lInd++;
        }
    }/* fin del While */

    vfnPrintCBasico ();

    stCliente.iIndFactur = ifnClienteFacturable ();

    return (bRes);
}/************************* Final bIFAbonos   ********************************/

/*****************************************************************************/
/*                        funcion : bCargaAbonosCelular                      */
/* -Funcion que guarda informacion sobre Ga_InfacCel en la estructura global */
/*  stCliente.pAbonados                                                      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaAbonosCelular (CICLOCLI *pCicloCli,int iTipoFact)
{
    int  iNumAbo         = 0 ;
    char szFecDesde [15] = "";
    char szFecHasta [15] = "";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char  szhRowid      [19]   ; /* EXEC SQL VAR szhRowid          IS STRING(19); */ 

         static long  lhNumAbonado         ;
         static long  lhCodCliente         ;
         static int   ihIndActuac          ;
         static short shIndCargos          ;
         static short shIndAlta            ;
         static short shIndDetalle         ;
         static short shIndPenaliza        ;
         static short shIndArriendo        ;
         static short shIndCuotas          ;
         static short shIndSuperTel        ;
         static long  lhCodCiclFact        ;
         static char  szhNumTerminal[16]   ; /* EXEC SQL VAR szhNumTerminal    IS STRING(16); */ 

         static char  szhFecAlta    [15]   ; /* EXEC SQL VAR szhFecAlta        IS STRING(15); */ 

         static char  szhFecBaja       [15]; /* EXEC SQL VAR szhFecBaja        IS STRING(15); */ 

         static char  szhFecFinContrato[15]; /* EXEC SQL VAR szhFecFinContrato IS STRING(15); */ 

         static char  szhNumTeleFija   [16]; /* EXEC SQL VAR szhNumTeleFija    IS STRING(16); */ 

         static int   ihCodSuperTel        ;
         static int   ihIndCobroDetLlam    ;
         static int   ihIndCargoPro        ;
         static int   ihIndFactur          ;
         static int   ihIndBloqueo         ;
         static int   ihIndCuentaCtl       ;
         static short i_shCodSuperTel      ;
         static short i_shIndCobroDetLlam  ;
         static short i_shNumTeleFija      ;
         static int   iUno=1               ;
         static int   iDos=2               ;
         static int   iTres=3              ;
         static int   iCinco=5             ;
         char         szhFecUltFact [14+1] ; /* EXEC SQL VAR szhFecUltFact     IS STRING(14+1); */ 
    /* P-MIX-09003 */
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente = pCicloCli->lCodCliente;
    lhNumAbonado = pCicloCli->lNumAbonado;
    lhCodCiclFact= stCiclo.lCodCiclFact  ;
    
    memset(szhFecUltFact,'\0',sizeof(szhFecUltFact));  /* P-MIX-09003 */
    strcpy(szhFecUltFact,pCicloCli->szFecUltFact);     /* P-MIX-09003 */

    vDTrazasLog (szExeName, "\n\t\t* Parametros de Entrada Ga_Infaccel"
                            "\n\t\t => Cod.Cliente   [%ld]"
                            "\n\t\t => Num.Abonado   [%ld]"
                            "\n\t\t => Cod.CiclFact  [%ld]"
                          , LOG05
                          , lhCodCliente
                          , lhNumAbonado
                          , lhCodCiclFact);

    if (iTipoFact == FACT_CICLO)
    {
    /*******************************************************************************/
    /* IndActuac : Normal (1), Baja (2), Traspaso (3), Liquidacion (4), Rechazo(5) */
    /*******************************************************************************/
       strcpy(szpFormatoFec,"YYYYMMDDHH24MISS");
       /* EXEC SQL SELECT ROWID                            ,
                    TO_CHAR (FEC_ALTA,:szpFormatoFec), TO_CHAR (FEC_BAJA,:szpFormatoFec)     ,
                    IND_ALTA                         , IND_DETALLE                           ,
                    IND_ACTUAC                       , IND_CARGOS                            ,
                    IND_PENALIZA                     , IND_ARRIENDO                          ,
                    IND_CUOTAS                       , TO_CHAR (FEC_FINCONTRA,:szpFormatoFec),
                    TO_CHAR (NUM_CELULAR)            , IND_SUPERTEL                          ,
                    NUM_TELEFIJA                     , IND_CARGOPRO                          ,
                    IND_FACTUR                       , IND_BLOQUEO                           ,
                    IND_CUENCONTROLADA               , COD_SUPERTEL                          ,
                    IND_COBRODETLLAM
             INTO   :szhRowid                             ,
                    :szhFecAlta                           , :szhFecBaja                       ,
                    :shIndAlta                            , :shIndDetalle                     ,
                    :ihIndActuac                          , :shIndCargos                      ,
                    :shIndPenaliza                        , :shIndArriendo                    ,
                    :shIndCuotas                          , :szhFecFinContrato                ,
                    :szhNumTerminal                       , :shIndSuperTel                    ,
                    :szhNumTeleFija   :i_shNumTeleFija    , :ihIndCargoPro                    , 
                    :ihIndFactur                          , :ihIndBloqueo                     , 
                    :ihIndCuentaCtl                       , :ihCodSuperTel    :i_shCodSuperTel, 
                    :ihIndCobroDetLlam:i_shIndCobroDetLlam
             FROM   GA_INFACCEL
             WHERE  COD_CLIENTE = :lhCodCliente
               AND  NUM_ABONADO = :lhNumAbonado
               AND  COD_CICLFACT= :lhCodCiclFact
               AND  IND_ACTUAC  IN ( :iUno, :iDos ,:iTres, :iCinco ) /o  1: Normal  2:Baja  3:Traspaso  5:Rechazo  o/
            FOR UPDATE OF COD_CLIENTE; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 30;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select ROWID ,TO_CHAR(FEC_ALTA,:b0) ,TO_CHAR(FEC_BAJA,\
:b0) ,IND_ALTA ,IND_DETALLE ,IND_ACTUAC ,IND_CARGOS ,IND_PENALIZA ,IND_ARRIEND\
O ,IND_CUOTAS ,TO_CHAR(FEC_FINCONTRA,:b0) ,TO_CHAR(NUM_CELULAR) ,IND_SUPERTEL \
,NUM_TELEFIJA ,IND_CARGOPRO ,IND_FACTUR ,IND_BLOQUEO ,IND_CUENCONTROLADA ,COD_\
SUPERTEL ,IND_COBRODETLLAM into :b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b1\
3,:b14,:b15,:b16:b17,:b18,:b19,:b20,:b21,:b22:b23,:b24:b25  from GA_INFACCEL w\
here (((COD_CLIENTE=:b26 and NUM_ABONADO=:b27) and COD_CICLFACT=:b28) and IND_\
ACTUAC in (:b29,:b30,:b31,:b32)) for update of COD_CLIENTE ";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )5;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szpFormatoFec;
       sqlstm.sqhstl[0] = (unsigned long )17;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szpFormatoFec;
       sqlstm.sqhstl[1] = (unsigned long )17;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szpFormatoFec;
       sqlstm.sqhstl[2] = (unsigned long )17;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)szhRowid;
       sqlstm.sqhstl[3] = (unsigned long )19;
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)szhFecAlta;
       sqlstm.sqhstl[4] = (unsigned long )15;
       sqlstm.sqhsts[4] = (         int  )0;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)szhFecBaja;
       sqlstm.sqhstl[5] = (unsigned long )15;
       sqlstm.sqhsts[5] = (         int  )0;
       sqlstm.sqindv[5] = (         short *)0;
       sqlstm.sqinds[5] = (         int  )0;
       sqlstm.sqharm[5] = (unsigned long )0;
       sqlstm.sqadto[5] = (unsigned short )0;
       sqlstm.sqtdso[5] = (unsigned short )0;
       sqlstm.sqhstv[6] = (unsigned char  *)&shIndAlta;
       sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[6] = (         int  )0;
       sqlstm.sqindv[6] = (         short *)0;
       sqlstm.sqinds[6] = (         int  )0;
       sqlstm.sqharm[6] = (unsigned long )0;
       sqlstm.sqadto[6] = (unsigned short )0;
       sqlstm.sqtdso[6] = (unsigned short )0;
       sqlstm.sqhstv[7] = (unsigned char  *)&shIndDetalle;
       sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[7] = (         int  )0;
       sqlstm.sqindv[7] = (         short *)0;
       sqlstm.sqinds[7] = (         int  )0;
       sqlstm.sqharm[7] = (unsigned long )0;
       sqlstm.sqadto[7] = (unsigned short )0;
       sqlstm.sqtdso[7] = (unsigned short )0;
       sqlstm.sqhstv[8] = (unsigned char  *)&ihIndActuac;
       sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[8] = (         int  )0;
       sqlstm.sqindv[8] = (         short *)0;
       sqlstm.sqinds[8] = (         int  )0;
       sqlstm.sqharm[8] = (unsigned long )0;
       sqlstm.sqadto[8] = (unsigned short )0;
       sqlstm.sqtdso[8] = (unsigned short )0;
       sqlstm.sqhstv[9] = (unsigned char  *)&shIndCargos;
       sqlstm.sqhstl[9] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[9] = (         int  )0;
       sqlstm.sqindv[9] = (         short *)0;
       sqlstm.sqinds[9] = (         int  )0;
       sqlstm.sqharm[9] = (unsigned long )0;
       sqlstm.sqadto[9] = (unsigned short )0;
       sqlstm.sqtdso[9] = (unsigned short )0;
       sqlstm.sqhstv[10] = (unsigned char  *)&shIndPenaliza;
       sqlstm.sqhstl[10] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[10] = (         int  )0;
       sqlstm.sqindv[10] = (         short *)0;
       sqlstm.sqinds[10] = (         int  )0;
       sqlstm.sqharm[10] = (unsigned long )0;
       sqlstm.sqadto[10] = (unsigned short )0;
       sqlstm.sqtdso[10] = (unsigned short )0;
       sqlstm.sqhstv[11] = (unsigned char  *)&shIndArriendo;
       sqlstm.sqhstl[11] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[11] = (         int  )0;
       sqlstm.sqindv[11] = (         short *)0;
       sqlstm.sqinds[11] = (         int  )0;
       sqlstm.sqharm[11] = (unsigned long )0;
       sqlstm.sqadto[11] = (unsigned short )0;
       sqlstm.sqtdso[11] = (unsigned short )0;
       sqlstm.sqhstv[12] = (unsigned char  *)&shIndCuotas;
       sqlstm.sqhstl[12] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[12] = (         int  )0;
       sqlstm.sqindv[12] = (         short *)0;
       sqlstm.sqinds[12] = (         int  )0;
       sqlstm.sqharm[12] = (unsigned long )0;
       sqlstm.sqadto[12] = (unsigned short )0;
       sqlstm.sqtdso[12] = (unsigned short )0;
       sqlstm.sqhstv[13] = (unsigned char  *)szhFecFinContrato;
       sqlstm.sqhstl[13] = (unsigned long )15;
       sqlstm.sqhsts[13] = (         int  )0;
       sqlstm.sqindv[13] = (         short *)0;
       sqlstm.sqinds[13] = (         int  )0;
       sqlstm.sqharm[13] = (unsigned long )0;
       sqlstm.sqadto[13] = (unsigned short )0;
       sqlstm.sqtdso[13] = (unsigned short )0;
       sqlstm.sqhstv[14] = (unsigned char  *)szhNumTerminal;
       sqlstm.sqhstl[14] = (unsigned long )16;
       sqlstm.sqhsts[14] = (         int  )0;
       sqlstm.sqindv[14] = (         short *)0;
       sqlstm.sqinds[14] = (         int  )0;
       sqlstm.sqharm[14] = (unsigned long )0;
       sqlstm.sqadto[14] = (unsigned short )0;
       sqlstm.sqtdso[14] = (unsigned short )0;
       sqlstm.sqhstv[15] = (unsigned char  *)&shIndSuperTel;
       sqlstm.sqhstl[15] = (unsigned long )sizeof(short);
       sqlstm.sqhsts[15] = (         int  )0;
       sqlstm.sqindv[15] = (         short *)0;
       sqlstm.sqinds[15] = (         int  )0;
       sqlstm.sqharm[15] = (unsigned long )0;
       sqlstm.sqadto[15] = (unsigned short )0;
       sqlstm.sqtdso[15] = (unsigned short )0;
       sqlstm.sqhstv[16] = (unsigned char  *)szhNumTeleFija;
       sqlstm.sqhstl[16] = (unsigned long )16;
       sqlstm.sqhsts[16] = (         int  )0;
       sqlstm.sqindv[16] = (         short *)&i_shNumTeleFija;
       sqlstm.sqinds[16] = (         int  )0;
       sqlstm.sqharm[16] = (unsigned long )0;
       sqlstm.sqadto[16] = (unsigned short )0;
       sqlstm.sqtdso[16] = (unsigned short )0;
       sqlstm.sqhstv[17] = (unsigned char  *)&ihIndCargoPro;
       sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[17] = (         int  )0;
       sqlstm.sqindv[17] = (         short *)0;
       sqlstm.sqinds[17] = (         int  )0;
       sqlstm.sqharm[17] = (unsigned long )0;
       sqlstm.sqadto[17] = (unsigned short )0;
       sqlstm.sqtdso[17] = (unsigned short )0;
       sqlstm.sqhstv[18] = (unsigned char  *)&ihIndFactur;
       sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[18] = (         int  )0;
       sqlstm.sqindv[18] = (         short *)0;
       sqlstm.sqinds[18] = (         int  )0;
       sqlstm.sqharm[18] = (unsigned long )0;
       sqlstm.sqadto[18] = (unsigned short )0;
       sqlstm.sqtdso[18] = (unsigned short )0;
       sqlstm.sqhstv[19] = (unsigned char  *)&ihIndBloqueo;
       sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[19] = (         int  )0;
       sqlstm.sqindv[19] = (         short *)0;
       sqlstm.sqinds[19] = (         int  )0;
       sqlstm.sqharm[19] = (unsigned long )0;
       sqlstm.sqadto[19] = (unsigned short )0;
       sqlstm.sqtdso[19] = (unsigned short )0;
       sqlstm.sqhstv[20] = (unsigned char  *)&ihIndCuentaCtl;
       sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[20] = (         int  )0;
       sqlstm.sqindv[20] = (         short *)0;
       sqlstm.sqinds[20] = (         int  )0;
       sqlstm.sqharm[20] = (unsigned long )0;
       sqlstm.sqadto[20] = (unsigned short )0;
       sqlstm.sqtdso[20] = (unsigned short )0;
       sqlstm.sqhstv[21] = (unsigned char  *)&ihCodSuperTel;
       sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[21] = (         int  )0;
       sqlstm.sqindv[21] = (         short *)&i_shCodSuperTel;
       sqlstm.sqinds[21] = (         int  )0;
       sqlstm.sqharm[21] = (unsigned long )0;
       sqlstm.sqadto[21] = (unsigned short )0;
       sqlstm.sqtdso[21] = (unsigned short )0;
       sqlstm.sqhstv[22] = (unsigned char  *)&ihIndCobroDetLlam;
       sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[22] = (         int  )0;
       sqlstm.sqindv[22] = (         short *)&i_shIndCobroDetLlam;
       sqlstm.sqinds[22] = (         int  )0;
       sqlstm.sqharm[22] = (unsigned long )0;
       sqlstm.sqadto[22] = (unsigned short )0;
       sqlstm.sqtdso[22] = (unsigned short )0;
       sqlstm.sqhstv[23] = (unsigned char  *)&lhCodCliente;
       sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[23] = (         int  )0;
       sqlstm.sqindv[23] = (         short *)0;
       sqlstm.sqinds[23] = (         int  )0;
       sqlstm.sqharm[23] = (unsigned long )0;
       sqlstm.sqadto[23] = (unsigned short )0;
       sqlstm.sqtdso[23] = (unsigned short )0;
       sqlstm.sqhstv[24] = (unsigned char  *)&lhNumAbonado;
       sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[24] = (         int  )0;
       sqlstm.sqindv[24] = (         short *)0;
       sqlstm.sqinds[24] = (         int  )0;
       sqlstm.sqharm[24] = (unsigned long )0;
       sqlstm.sqadto[24] = (unsigned short )0;
       sqlstm.sqtdso[24] = (unsigned short )0;
       sqlstm.sqhstv[25] = (unsigned char  *)&lhCodCiclFact;
       sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[25] = (         int  )0;
       sqlstm.sqindv[25] = (         short *)0;
       sqlstm.sqinds[25] = (         int  )0;
       sqlstm.sqharm[25] = (unsigned long )0;
       sqlstm.sqadto[25] = (unsigned short )0;
       sqlstm.sqtdso[25] = (unsigned short )0;
       sqlstm.sqhstv[26] = (unsigned char  *)&iUno;
       sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[26] = (         int  )0;
       sqlstm.sqindv[26] = (         short *)0;
       sqlstm.sqinds[26] = (         int  )0;
       sqlstm.sqharm[26] = (unsigned long )0;
       sqlstm.sqadto[26] = (unsigned short )0;
       sqlstm.sqtdso[26] = (unsigned short )0;
       sqlstm.sqhstv[27] = (unsigned char  *)&iDos;
       sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[27] = (         int  )0;
       sqlstm.sqindv[27] = (         short *)0;
       sqlstm.sqinds[27] = (         int  )0;
       sqlstm.sqharm[27] = (unsigned long )0;
       sqlstm.sqadto[27] = (unsigned short )0;
       sqlstm.sqtdso[27] = (unsigned short )0;
       sqlstm.sqhstv[28] = (unsigned char  *)&iTres;
       sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[28] = (         int  )0;
       sqlstm.sqindv[28] = (         short *)0;
       sqlstm.sqinds[28] = (         int  )0;
       sqlstm.sqharm[28] = (unsigned long )0;
       sqlstm.sqadto[28] = (unsigned short )0;
       sqlstm.sqtdso[28] = (unsigned short )0;
       sqlstm.sqhstv[29] = (unsigned char  *)&iCinco;
       sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[29] = (         int  )0;
       sqlstm.sqindv[29] = (         short *)0;
       sqlstm.sqinds[29] = (         int  )0;
       sqlstm.sqharm[29] = (unsigned long )0;
       sqlstm.sqadto[29] = (unsigned short )0;
       sqlstm.sqtdso[29] = (unsigned short )0;
       sqlstm.sqphsv = sqlstm.sqhstv;
       sqlstm.sqphsl = sqlstm.sqhstl;
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
    {
        vDTrazasLog (szExeName,"\t\t* Select Ga_InfacCel-> [%s]",LOG03, szfnORAerror());
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select Ga_InfacCel->", szfnORAerror());
        return FALSE;
    }
    if (SQLCODE == SQLOK)
    {
        if ( (stCliente.pAbonos =
             (ABONOS *)realloc( (ABONOS *)stCliente.pAbonos,
             (stCliente.iNumAbonos+1)*sizeof(ABONOS) ))==(ABONOS *)NULL)
        {
            vDTrazasLog (szExeName,"\t\t* realloc stCliente.pAbonos ",LOG03);
            iDError (szExeName,ERR005,vInsertarIncidencia,"stCliente.pAbonos");
            return FALSE;
        }
        else
        {
            memset (&stCliente.pAbonos[stCliente.iNumAbonos],0,sizeof(ABONOS))  ;

            stCliente.pAbonos[stCliente.iNumAbonos].lNumAbonado         = lhNumAbonado ;
            stCliente.pAbonos[stCliente.iNumAbonos].iCodProducto        = stDatosGener.iProdCelular   ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndActuacOld       = ihIndActuac  ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndCargos          = shIndCargos  ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndAlta            = shIndAlta    ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndPenaliza        = shIndPenaliza;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndArriendo        = shIndArriendo;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndCuotas          = shIndCuotas  ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndCargoPro        = ihIndCargoPro;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndFactur          = ihIndFactur  ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndBloqueo         = ihIndBloqueo ;
            stCliente.pAbonos[stCliente.iNumAbonos].iIndCuenControlada  = ihIndCuentaCtl;

            strcpy (stCliente.pAbonos[stCliente.iNumAbonos].szRowid  ,szhRowid)  ;
            strcpy (stCliente.pAbonos[stCliente.iNumAbonos].szFecAlta,szhFecAlta);
            strcpy (stCliente.pAbonos[stCliente.iNumAbonos].szFecBaja,szhFecBaja);
            strcpy (stCliente.pAbonos[stCliente.iNumAbonos].szFecFinContrato, szhFecFinContrato);
            strcpy (stCliente.pAbonos[stCliente.iNumAbonos].szNumTerminal, szhNumTerminal);

            stCliente.pAbonos[stCliente.iNumAbonos].pstCBasico          = (CARGOFIJO*)NULL;
            stCliente.pAbonos[stCliente.iNumAbonos].iNumCBasicos        = 0               ;

            pCicloCli->iIndDetalle = shIndDetalle ;
            pCicloCli->iIndSuperTel= shIndSuperTel;
            pCicloCli->iIndFactur  = ihIndFactur  ;

            if (stCliente.iIndSuperTel < 1 && shIndSuperTel == 1)
            {
                stCliente.iIndSuperTel = shIndSuperTel;
            }

            if (i_shNumTeleFija == ORA_NULL)
            {
                pCicloCli->szNumTeleFija [0] = 0;
            }
            else
            {
                strcpy (pCicloCli->szNumTeleFija,szhNumTeleFija);
            }
                
            if (i_shIndCobroDetLlam == ORA_NULL)
            {
                pCicloCli->iIndCobroDetLlam = 0;
            }
            else
            {
                pCicloCli->iIndCobroDetLlam=ihIndCobroDetLlam;
            }

            if (stCliente.iCodOpRedFija <= 0 && i_shCodSuperTel != -1)
            {
                stCliente.iCodOpRedFija = ihCodSuperTel;
            }

            strcpy (pCicloCli->szNumTerminal ,szhNumTerminal)   ;
            strcpy (pCicloCli->szFecFinContra,szhFecFinContrato);
            /***************************************************************/
            /*                     Abonados a Tasar                        */
            /***************************************************************/
            if ( (stCliente.pAbonados =
                 (ABONTAR *)realloc ( (ABONTAR *)stCliente.pAbonados,
                  sizeof (ABONTAR) * (stCliente.iNumAbonados + 1)))
                                      == (ABONTAR *)NULL)
            {
                 vDTrazasLog (szExeName,"\t\t* realloc stCliente.pAbonados ",LOG03);
                 iDError (szExeName,ERR005,vInsertarIncidencia, "stCliente.pAbonados",szfnORAerror());
                 return FALSE;
            }
            memset(&stCliente.pAbonados[stCliente.iNumAbonados],0,sizeof(ABONTAR));

            strcpy (stCliente.pAbonados[stCliente.iNumAbonados].szRowid, szhRowid);

            stCliente.pAbonados[stCliente.iNumAbonados].lNumAbonado =lhNumAbonado ;
            stCliente.pAbonados[stCliente.iNumAbonados].iCodProducto= stDatosGener.iProdCelular ;
            stCliente.pAbonados[stCliente.iNumAbonados].iIndFactur  = ihIndFactur ;
            stCliente.pAbonados[stCliente.iNumAbonados].iNumConcTar = 0           ;
            stCliente.pAbonados[stCliente.iNumAbonados].pConcTar    = (CONCTAR *)NULL;

            strcpy (szFecDesde, stCiclo.szFecDesdeCFijos);

            strcpy (szFecHasta, (iTipoFact == FACT_CICLO)?stCiclo.szFecHastaCFijos:szSysDate);

            iNumAbo = stCliente.iNumAbonos;

            if(!bfnObtImpCargoBasico(&stCliente.pAbonos[iNumAbo], szFecDesde, szFecHasta, 0, iTipoFact, szhFecUltFact))
            {
                vDTrazasLog (szExeName,"\t\t* bfnObtImpCargoBasico retorna FALSE ",LOG03);
                return FALSE;
            }

            /* Plan Tarifario Vigente */
            if (pCicloCli->szCodPlanTarif [0] == 0)
                strcpy (pCicloCli->szCodPlanTarif, stCliente.pAbonos[iNumAbo].szCodPlanTarif);
            if (pCicloCli->lCodGrupo <= 0)
                pCicloCli->lCodGrupo  =
               (stCliente.pAbonos [iNumAbo].iNumCBasicos)?
                stCliente.pAbonos [iNumAbo].pstCBasico [0].lCodGrupo: 0;

            vDTrazasLog (szExeName, "\n\t\t*Numero de Cargos Basicos [%d] \n"
                                  , LOG04,stCliente.pAbonos [iNumAbo].iNumCBasicos);

            if (pCicloCli->szNumTerminal [0] == 0)
                strcpy (pCicloCli->szNumTerminal,
                        stCliente.pAbonos [iNumAbo].szNumTerminal);

            vDTrazasLog (szExeName, "\n\t\t*Tipo de Plan "
                                    "\n\t\t => Tip PLan Tarif  [%s]"
                                  , LOG05
                                  , stCliente.pAbonos[iNumAbo].szTipPlanTarif );

            if (!strcmp (stCliente.pAbonos[iNumAbo].szTipPlanTarif, szINDIVIDUAL))
            {
                /****************************************************************/
                /*   El Plan Comercial es a nivel de Cliente por lo tanto todos */
                /*los Abonados de un Cliente deberian tener todos el mismo Plan */
                /*Comercial.Inicialmente lo inicializamos a ORA_NULL(PreBilling)*/
                /****************************************************************/
                if (stCliente.lCodPlanCom <= 0)
                    stCliente.lCodPlanCom =
                              stCliente.pAbonos[iNumAbo].lCodPlanCom;
                if (stCliente.pAbonos[iNumAbo].iIndCargos)
                {
                  if (!bCargaServGenerales(stCliente.pAbonos[iNumAbo], iTipoFact))
                  {
                       vDTrazasLog (szExeName,"\t\t* bCargaServGenerales retorna FALSE ",LOG03);
                       return FALSE;
                  }
                }
                if (stCliente.pAbonos[iNumAbo].iIndPenaliza)
                {
                    if (!bIFSac (iTipoFact, ihIndFactur, lhNumAbonado, -1))
                    {
                    	 vDTrazasLog (szExeName,"\t\t* bIFSac retorna FALSE ",LOG03);
                         return FALSE;
                    }
                }
                if (stCliente.pAbonos[iNumAbo].iIndCuotas)
                {
                    iNumAbo = stCliente.iNumAbonos;
                    if (!bIFCuotas( stCliente.lCodCliente,
                                    stCliente.pAbonos[iNumAbo].lNumAbonado,
                                    ihIndFactur, iTipoFact))
                    {
                    	vDTrazasLog (szExeName,"\t\t* bIFCuotas retorna FALSE ",LOG03);
                        return FALSE;
                    }
                }
                if (stCliente.pAbonos[iNumAbo].iIndArriendo == 1 && stCliente.pAbonos [iNumAbo].iNumCBasicos > 0)
                {
                    /************************************************************/
                    /* Introduce los arriendos en la estructura de Abonos,(puede*/
                    /* insertar varios) y los prorratea en el caso de ser nece- */
                    /* sario.                                                   */
                    /************************************************************/
                    if (!bCargaArriendos(stCliente.lCodCliente                  ,
                                         stCliente.pAbonos[iNumAbo].lNumAbonado ,
                                         stCliente.pAbonos[iNumAbo].iCodProducto,
                                         stCliente.pAbonos[iNumAbo].szCodGrpServ))
					{
			vDTrazasLog (szExeName,"\t\t* bCargaArriendos retorna FALSE ",LOG03);
                        return FALSE;
                    }
                }

            }/* fin del if TipPlanTarif == 'I' (Individual) */

            if ((!strcmp (stCliente.pAbonos[iNumAbo].szTipPlanTarif,szEMPRESA)) ||
                (!strcmp (stCliente.pAbonos[iNumAbo].szTipPlanTarif,szHOLDING)))
            {

                if (stCliente.pAbonos[iNumAbo].iIndCargos)
                {
                  if (!bCargaServGenerales(stCliente.pAbonos[iNumAbo], iTipoFact))
                  {
                       vDTrazasLog (szExeName,"\t\t* bCargaServGenerales retorna FALSE ",LOG03);
                       return FALSE;
                  }
                }
            }

            vDTrazasLog (szExeName, "\t\t*Numero de Cargos Basicos [%d]"
                                  , LOG04
                                  , stCliente.pAbonos [iNumAbo].iNumCBasicos);

            if (stCliente.iNumServAbo > 0 && stCliente.pAbonos [iNumAbo].iNumCBasicos > 0)
            {
                if (!bfnGetServicios (  stCliente.lCodCliente                 ,
                                        stCliente.iNumServAbo-1               ,
                                        stCliente.pAbonos[iNumAbo].iIndFactur ,
                                        stCliente.pAbonos[iNumAbo].iIndBloqueo,
                                        szhFecUltFact)) /* P-MIX-09003 */
                {
                    vDTrazasLog (szExeName,"\t\t* bfnGetServicios retorna FALSE ",LOG03);
                    return FALSE;
                }
            }
            stCliente.iNumAbonos++  ;
            stCliente.iNumAbonados++;

        }/* fin else */
    }
    return TRUE;
}/************************ Final bCargaAbonosCelular *************************/

/*****************************************************************************/
/*                         funcion : bCargaServOcasionales                   */
/* -Funcion que Carga Servicios Ocasionales para un producto                 */
/* -Utilizamos pstActuaServ (Ga_ActuaServ), pstTarifas (Ga_Tarifas) array's  */
/*  donde se cargan las tablas (variables globales al modulo                 */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaServOcasionales (int iServAbo,int iIndFactur)
{
    int  iNumAct           = 0 ; 
    int  iNumServ          = 0 ;
    int  i                 = 0 ;
    char szFecEmision [15] = "";
    TARIFAS stTarifa;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static int    ihCodProducto     ;
         static char   szhCodActAbo  [3] ;/* EXEC SQL VAR szhCodActAbo   IS STRING(3) ; */ 

         static char   szhCodTipServ [2] ;/* EXEC SQL VAR szhCodTipServ  IS STRING(2) ; */ 

         static char   szhCodServicio[4] ;/* EXEC SQL VAR szhCodServicio IS STRING(4) ; */ 

         static char   szhCodPlanServ[4] ;/* EXEC SQL VAR szhCodPlanServ IS STRING(4) ; */ 

         static char   szhFecEmision [15];/* EXEC SQL VAR szhFecEmision  IS STRING(15); */ 

         static int    ihCodConcepto     ;
         static double dhImpTarifa       ;
         static char   szhCodMoneda  [4] ;/* EXEC SQL VAR szhCodMoneda   IS STRING(4) ; */ 

         static char   szhTipCuenta  [2] ;/* EXEC SQL VAR szhTipCuenta   IS STRING(2) ; */ 

         static long   lhCodCuenta;
    /* EXEC SQL END DECLARE SECTION; */ 


    memset (&stTarifa,0,sizeof(stTarifa));

    if (stCliente.pServAbo == (SERVABO *)NULL)
    {
        return TRUE;
    }

    iNumServ = stCliente.pServAbo[iServAbo].iNumServicios;

    vDTrazasLog (szExeName, "\n\t\t* Carga Servicios Ocasionales"
                            "\n\t\t=> Cliente     [%ld]"
                            "\n\t\t=> Num.Abonado [%ld]"
                            "\n\t\t=> iServAbo    [%ld]"
                            "\n\t\t=> Num.Servic. [%d] "
                          , LOG04, stCliente.lCodCliente
                          , stCliente.pServAbo[iServAbo].lNumAbonado
                          , iServAbo
                          , iNumServ);

    lhCodCuenta = stCliente.lCodCuenta;

    /* EXEC SQL
         SELECT TIP_CUENTA
         INTO   :szhTipCuenta
         FROM   GA_CUENTAS
         WHERE  COD_CUENTA  = :lhCodCuenta; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TIP_CUENTA into :b0  from GA_CUENTAS where COD_CUE\
NTA=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )140;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhTipCuenta;
    sqlstm.sqhstl[0] = (unsigned long )2;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
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
        vDTrazasLog (szExeName, "\n\t\t Error al recuperar GA_CUENTAS de cliente %d  \n"
                              , LOG05
                              , stCliente.lCodCliente);
        return FALSE;
    }

     if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
    {
        stCliente.pServAbo[iServAbo].iIndAlta = 1;
        stCliente.pServAbo [iServAbo].iIndFactur=iIndFactur;

        strcpy (szFecEmision,stCiclo.szFecEmision);
        strcpy (stCliente.pServAbo[iServAbo].szFecValor,szFecEmision);

        for(iNumAct=0;iNumAct<NUM_ACTUASERV;iNumAct++)
        {
            if (strcmp (pstActuaServ[iNumAct].szCodTipServ,SERV_OCASIONAL)==0 &&
                pstActuaServ[iNumAct].iCodConcepto != ORA_NULL)
            {
                strcpy (stTarifa.szCodTipServ  , SERV_OCASIONAL);
                strcpy (stTarifa.szCodServicio , pstActuaServ[iNumAct].szCodServicio);
                strcpy (stTarifa.szCodPlanServ , stCliente.pServAbo[iServAbo].szCodPlanServ);
                strcpy (stTarifa.szFecDesde    , szFecEmision);
                strcpy (stTarifa.szFecHasta    , szFecEmision);

                if (bFindTarifa (&stTarifa))
                {
                    if ( (stCliente.pServAbo[iServAbo].pServicios =(SERVICIOS *)
                        realloc((SERVICIOS*)stCliente.pServAbo[iServAbo].pServicios,
                        (iNumServ+1)*sizeof(SERVICIOS))) == (SERVICIOS *)NULL )
                    {
                        iDError (szExeName, ERR005
                                          , vInsertarIncidencia
                                          , "pServAbo->pServicios");
                        return FALSE;
                    }

                    /* Codigo para funcionalidad de criterios para servicios ocasionales */
                    vDTrazasLog (szExeName, "\n\t\t BfnObtieneValorCrit_PlanTarif (Ciclo)"
                                            "\n\t\t Servicio    : %s "
                                            "\n\t\t Producto    : %d "
                                            "\n\t\t Tipo Cuenta : %s "
                                          , LOG05
                                          , pstActuaServ[iNumAct].szCodServicio
                                          , stCliente.pServAbo[iServAbo].iCodProducto
                                          , szhTipCuenta);

                    if ( BfnObtieneValorCrit_PlanTarif(pstActuaServ[iNumAct].szCodServicio,
                                                                 stCliente.pServAbo[iServAbo].iCodProducto,
                                                                 szhTipCuenta,
                                                                 stCliente.pServAbo[iServAbo].lNumAbonado) )
                    {
                        memset (&stCliente.pServAbo[iServAbo].pServicios[iNumServ],0,sizeof (SERVICIOS));

                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].dImpPeriodo =
                                            stTarifa.dImpTarifa;

                        vDTrazasLog (szExeName, "\t\t Importe servicio : [%f] \n"
                                              , LOG05
                                              , stCliente.pServAbo[iServAbo].pServicios[iNumServ].dImpPeriodo );

                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].dImpConcepto=
                                            fnCnvDouble(stTarifa.dImpTarifa, USOFACT);

                        strcpy(stCliente.pServAbo[iServAbo].pServicios[iNumServ].szCodMoneda,
                                            stTarifa.szCodMoneda);
                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].szFecAltaCen[0]=0;
                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].szFecBajaBD [0]=0;

                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].iCodConcepto=
                                            pstActuaServ[iNumAct].iCodConcepto;
                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].lColumna    = 0   ;
                        stCliente.pServAbo[iServAbo].pServicios[iNumServ].bIndCargo   =FALSE;

                        i = iServAbo;
                        if (!bValidacionServicio(&stCliente.pServAbo[i].pServicios[iNumServ]))
                        {
                            return FALSE;
                        }
                        iNumServ++;
                    }
                    else
                    {
                        vDTrazasLog (szExeName, "\n\t\t Servicio [%s] No cumple criterio\n"
                                              , LOG05,pstActuaServ[iNumAct].szCodServicio);
                    }
                }
            }/* fin IF */
        }
    }/* fin if FACT_CICLO ... */
    else if (stProceso.iCodTipDocum == stDatosGener.iCodBaja)
    {
        /* EXEC SQL DECLARE Cur_Tarifas CURSOR FOR
             SELECT B.COD_SERVICIO,
                    B.COD_CONCEPTO,
                    A.IMP_TARIFA  ,
                    A.COD_MONEDA
              FROM  GA_TARIFAS A, GA_ACTUASERV B
             WHERE  A.COD_PRODUCTO = :ihCodProducto
               AND  A.COD_ACTABO   = :szhCodActAbo
               AND  A.COD_TIPSERV  = :szhCodTipServ
               AND  A.COD_SERVICIO = B.COD_SERVICIO
               AND  A.COD_PLANSERV = :szhCodPlanServ
               AND  A.FEC_DESDE   <= TO_DATE(:szhFecEmision,'YYYYMMDDHH24MISS')
               AND (A.FEC_HASTA   >= TO_DATE(:szhFecEmision,'YYYYMMDDHH24MISS')
               OR   A.FEC_HASTA   IS NULL)
               AND  B.COD_PRODUCTO = :ihCodProducto
               AND  B.COD_ACTABO   = :szhCodActAbo
               AND  B.COD_TIPSERV  = :szhCodTipServ; */ 


        if (strcmp (stCliente.pServAbo[iServAbo].szFecDesde,szSysDate) < 0)
        {
            stCliente.pServAbo[iServAbo].iIndAlta = 1;
            strcpy (stCliente.pServAbo[iServAbo].szFecValor,szSysDate);
        }
        else
        {
            stCliente.pServAbo[iServAbo].iIndAlta = 1;
            strcpy (stCliente.pServAbo[iServAbo].szFecValor,
                    stCliente.pServAbo[iServAbo].szFecDesde);
        }
        stCliente.pServAbo [iServAbo].iIndFactur =  iIndFactur            ;

        strcpy (szhFecEmision,szSysDate)                                  ;
        strcpy (szhCodPlanServ,stCliente.pServAbo[iServAbo].szCodPlanServ);
        ihCodProducto = stCliente.pServAbo[iServAbo].iCodProducto         ;

        strcpy (szhCodTipServ ,SERV_OCASIONAL) ;
        strcpy (szhCodActAbo  ,MOD_FACTURACION);

        /* EXEC SQL OPEN Cur_Tarifas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0005;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )163;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProducto;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodActAbo;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipServ;
        sqlstm.sqhstl[2] = (unsigned long )2;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlanServ;
        sqlstm.sqhstl[3] = (unsigned long )4;
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
        sqlstm.sqhstv[5] = (unsigned char  *)szhFecEmision;
        sqlstm.sqhstl[5] = (unsigned long )15;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihCodProducto;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
        sqlstm.sqhstl[7] = (unsigned long )3;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhCodTipServ;
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


        if (SQLCODE)
        {
            iDError (szExeName, ERR000
                              , vInsertarIncidencia
                              , "Open->Ga_Tarifas A, Ga_ActuaServ B"
                              , szfnORAerror());
            return FALSE;
        }
        while (SQLCODE == SQLOK)
        {
            /* EXEC SQL FETCH Cur_Tarifas INTO :szhCodServicio,
                                            :ihCodConcepto,
                                            :dhImpTarifa  ,
                                            :szhCodMoneda; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )214;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhCodServicio;
            sqlstm.sqhstl[0] = (unsigned long )4;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcepto;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&dhImpTarifa;
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
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
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
                iDError (szExeName, ERR000
                                  , vInsertarIncidencia
                                  , "Fetch->Ga_Tarifas A, Ga_ActuaServ" 
                                  , szfnORAerror());
            }
            if (SQLCODE == SQLOK)
            {
                if ( (stCliente.pServAbo[iServAbo].pServicios =(SERVICIOS *)
                      realloc((SERVICIOS*)stCliente.pServAbo[iServAbo].pServicios,
                     (iNumServ+1)*sizeof(SERVICIOS))) == (SERVICIOS *)NULL )
                {
                    iDError (szExeName,ERR005,vInsertarIncidencia,
                             "pServAbo->pServicios");
                    return FALSE;
                }

                /* Codigo para funcionalidad de criterios para servicios ocasionales */

                vDTrazasLog (szExeName, "\n\t\t BfnObtieneValorCrit_PlanTarif (Baja)"
                                        "\n\t\t Servicio    : %s"
                                        "\n\t\t Producto    : %d"
                                        "\n\t\t Tipo Cuenta : %s"
                                      , LOG05
                                      , pstActuaServ[iNumAct].szCodServicio
                                      , stCliente.pServAbo[iServAbo].iCodProducto
                                      , szhTipCuenta);

                if ( BfnObtieneValorCrit_PlanTarif( szhCodServicio,ihCodProducto,
                                                    szhTipCuenta,stCliente.pServAbo[iServAbo].lNumAbonado) )
                {
                    memset (&stCliente.pServAbo[iServAbo].pServicios[iNumServ],0,
                    sizeof (SERVICIOS));

                    stCliente.pServAbo[iServAbo].pServicios[iNumServ].dImpPeriodo = fnCnvDouble(dhImpTarifa, USOFACT);
                    stCliente.pServAbo[iServAbo].pServicios[iNumServ].dImpConcepto= fnCnvDouble(dhImpTarifa, USOFACT);
                    strcpy(stCliente.pServAbo[iServAbo].pServicios[iNumServ].szCodMoneda, szhCodMoneda);
                    strcpy(stCliente.pServAbo[iServAbo].pServicios[iNumServ].szFecAltaCen, "");
                    strcpy(stCliente.pServAbo[iServAbo].pServicios[iNumServ].szFecBajaBD,"");
                    stCliente.pServAbo[iServAbo].pServicios[iNumServ].iCodConcepto= ihCodConcepto;
                    i = iServAbo;
                    
                    if (!bValidacionServicio(&stCliente.pServAbo[i].pServicios[iNumServ]))
                    {
                           return FALSE;
                    }
                    iNumServ++;
                }
                else
                {
                    vDTrazasLog (szExeName , "\n\t\t Servicio [%s] No cumple criterio  \n"
                                           , LOG05
                                           , szhCodServicio);
                }

            }
        }/* fin While ... */

        if (SQLCODE == SQLNOTFOUND)
        {
            /* EXEC SQL CLOSE Cur_Tarifas; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )245;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            if (SQLCODE)
            {
                iDError (szExeName, ERR000
                                  , vInsertarIncidencia
                                  , "Close->Ga_Tarifas A, Ga_ActuaServ" 
                                  , szfnORAerror());
            }
        }
        return (SQLCODE != SQLOK)?FALSE:TRUE;
    }

    stCliente.pServAbo[iServAbo].iNumServicios = iNumServ;

    vDTrazasLog (szExeName,"\t\t# Num.Servicios Ocasionales [%d]\n",LOG03,
                           stCliente.pServAbo[iServAbo].iNumServicios);
    return TRUE;
}/************************* Final bCargaServOcasionales **********************/


/*****************************************************************************/
/*                          funcion : bCargaServGenerales                    */
/* -Funcion que carga los Servicios Generales para un Abonado                */
/* -Utilizamos pstCargos (Ge_Cargos) array que contiene los reg. de la tabla */
/*  Ge_Cargos (variable global al modulo). Cargamos en stCliente.pCargos     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaServGenerales (ABONOS stAbono,int iTipoFact)
{
    register long iInd = 0;

    vDTrazasLog (szExeName, "\n\t\t* Servicios Generales (Cargos)"
                            "\n\t\t* => Cliente     [%ld]"
                            "\n\t\t* => Num.Abonado [%ld]"
                            "\n\t\t* => Cod.Producto[%d] "
                            "\n\t\t* => Num. Cargos [%ld] "
                            "\n\t\t* => Ind. Factur [%d] "
                          , LOG04
                          , stCliente.lCodCliente
                          , stAbono.lNumAbonado
                          , stAbono.iCodProducto
                          , NUM_CARGOS
                          , stCliente.iIndFactur );

    for (iInd=0;iInd<NUM_CARGOS;iInd++)
    {
       if (pstCargos[iInd].lCodCliente     == stCliente.lCodCliente          &&
           pstCargos[iInd].lNumAbonado     == stAbono.lNumAbonado            &&
           pstCargos[iInd].iCodProducto    == stAbono.iCodProducto           &&
           pstCargos[iInd].lNumTransaccion == 0                              &&
           pstCargos[iInd].lNumFactura     <= 0                              &&
           (iTipoFact == FACT_CICLO))
       {
           if ( (stCliente.pCargos =
                (CARGOS *)realloc ( (CARGOS *)stCliente.pCargos,
                (stCliente.iNumCargos+1)*sizeof (CARGOS) ))== (CARGOS *)NULL)
           {
                 iDError (szExeName,ERR005,vInsertarIncidencia,
                          "stCliente.pCargos");
                 return FALSE;
           }
           memset (&stCliente.pCargos[stCliente.iNumCargos],0,sizeof(CARGOS));
           memcpy (&stCliente.pCargos[stCliente.iNumCargos],&pstCargos[iInd],
                   sizeof (CARGOS));

           pstCargos[iInd].lNumFactura = stProceso.lNumProceso;
           stCliente.pCargos[stCliente.iNumCargos].iIndFactur =  stCliente.iIndFactur ;

           if (!bValidacionCargo (stCliente.iNumCargos))
           {
                return FALSE;
           }
           
           strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodRegion    , stCliente.szCodRegion)   ;
           strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodProvincia , stCliente.szCodProvincia);
           strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodCiudad    , stCliente.szCodCiudad)   ;
           stCliente.pCargos[stCliente.iNumCargos].lNumProceso = stStatus.IdPro;
           stCliente.iNumCargos++;
       }
    }
  return TRUE;
}/************************* Final bCargaServGenerales ************************/

/*****************************************************************************/
/*  funcion : bCargaServSuplementarios                                       */
/* -Funcion que carga los Servicios Suplementarios de un Abonado             */
/*  Utiliza la carga en memoria de la Tabla Ga_Tarifas (pstTarifas)          */
/*  IndEstado => Alta BD (1), Alta Central (2), Baja BD (3), Baja Central (4)*/
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaServSuplementarios (long lCodCliente, 
                                      int  iNumServAbo, 
                                      int  iIndFactur, 
                                      int  iIndBloqueo, 
                                      char *szFecUltFact)
{
    int           i              = 0 ;
    long          plNumFilas     = 0L;
    int           iCont          = 0 ;
    SERVABO       *pTmpSerA      = (SERVABO *)NULL;
    int           piSqlCodeLocal = 0 ;
    PASOPRORRATEO stPasoProrrateo    ;
    GRUPOCOB      stGrupoCob         ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char   szhCodServicio [TAM_HOSTS_PEQ] [4];
         static int    ihCodConcepto  [TAM_HOSTS_PEQ]    ;
         static char   szhFecAltaCen  [TAM_HOSTS_PEQ][15];
         static char   szhFecBajaBD   [TAM_HOSTS_PEQ][15];
         static char   szhFecAltaBD   [TAM_HOSTS_PEQ][15];
         static char   szhFecBajaCen  [TAM_HOSTS_PEQ][15];
         static int    ihIndPro       [TAM_HOSTS_PEQ]    ;
         static double dhImpTarifa    [TAM_HOSTS_PEQ]    ;
         static char   szhCodMoneda   [TAM_HOSTS_PEQ] [4];
         static short  i_shFecAltaCen [TAM_HOSTS_PEQ]    ;
         static short  i_shFecBajaBD  [TAM_HOSTS_PEQ]    ;
         static short  i_shFecAltaBD  [TAM_HOSTS_PEQ]    ;
         static short  i_shFecBajaCen [TAM_HOSTS_PEQ]    ;
         static short  i_shCodConcepto[TAM_HOSTS_PEQ]    ;
         /* P-MIX-09003 */
         static int    ihIndCobRetr   [TAM_HOSTS_PEQ]    ;         
         long          lhNumAbonado                      ; 
         long          lhCodCicloFact                    ;
         long          lhCodConcepto                     ;
         long          lhNumProceso                      ;
         long          lhNumOcurrencias                  ;
         long          lhCodError                        ;
         char          szhMsgError               [3000+1]; /* EXEC SQL VAR szhMsgError   IS STRING(3000+1); */ 

         long          lhEvento                          ;
         char          szhFecUltFact               [14+1]; /* EXEC SQL VAR szhFecUltFact IS STRING(14+1); */ 

         int           ihCantidadMeses                   ;         
         /* P-MIX-09003 */         
         double        dhImporteOverride                 ; /* P-MIX-09003 XX */
         long          lhCodCliente                      ; /* P-MIX-09003 XX */
    /* EXEC SQL END DECLARE SECTION  ; */ 


    memset (&stGrupoCob,0,sizeof (GRUPOCOB));
    memset (szhMsgError,'\0',sizeof (szhMsgError));    
    memset (szhFecUltFact,'\0',sizeof(szhFecUltFact)); /* P-MIX-09003 */

    if (pTmpSerA != (SERVABO *)NULL)
    {
        free (pTmpSerA);
        pTmpSerA = (SERVABO *)NULL;
    }

    pTmpSerA = (SERVABO *)&stCliente.pServAbo[iNumServAbo];

    if (strcmp (pTmpSerA->szFecDesde,stCiclo.szFecDesdeCFijos) < 0)
    {
        pTmpSerA->iIndAlta = 0;
    }
    else
    {
        pTmpSerA->iIndAlta = 1;
    }
    
    vDTrazasLog (szExeName, "\n\t\t*  Carga Servicios Suplementarios"
                            "\n\t\t=> Num.Abonado              [%ld]"
                            "\n\t\t=> Cod.TipServ              [%s] "
                            "\n\t\t=> Cod.PlanServ             [%s] "
                            "\n\t\t=> pTmpSerA->szFecDesde     [%s] "
                            "\n\t\t=> stCiclo.szFecDesdeCFijos [%s] "
                            "\n\t\t=> pTmpSerA->iIndAlta       [%d] "
                            ,LOG05,
                            pTmpSerA->lNumAbonado, SERV_SUPLEMENTARIO,
                            pTmpSerA->szCodPlanServ,
                            pTmpSerA->szFecDesde,
                            stCiclo.szFecDesdeCFijos,
                            pTmpSerA->iIndAlta);    

    strcpy (pTmpSerA->szFecValor, stCiclo.szFecEmision);
    pTmpSerA->iIndFactur = iIndFactur;
    
    strcpy(szhFecUltFact, szFecUltFact); /* P-MIX-09003 */
    
    lhCodCliente = lCodCliente; /* P-MIX-09003 XX */    

    /* variables bind del cursor */
    strcpy(szpFormatoFec,"YYYYMMDDHH24MISS");
    lhpNumAbonado  = pTmpSerA->lNumAbonado;
    ihpCodProducto = 1;
    ihpSeis        = 6;

    strcpy(szpFecHasta  , stCiclo.szFecHastaCFijos);
    strcpy(szpFecDesde  , stCiclo.szFecDesdeCFijos);
    strcpy(szpFecEmision, stCiclo.szFecEmision);

    strcpy(szpCodActabo  , "FA");
    strcpy(szpCodTipServ , SERV_SUPLEMENTARIO);
    strcpy(szpCodPlanServ, pTmpSerA->szCodPlanServ);

    /* variables bind del cursor */

    if (iIndBloqueo == iBLOQUEO_NORMAL)
    {
        /* EXEC SQL OPEN Cur_ServSupl; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0001;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )260;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[0] = (unsigned long )17;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[1] = (unsigned long )17;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[2] = (unsigned long )17;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[3] = (unsigned long )17;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhpNumAbonado;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihpCodProducto;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihpSeis;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szpFecHasta;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[8] = (unsigned long )17;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[9] = (unsigned long )17;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szpFecDesde;
        sqlstm.sqhstl[10] = (unsigned long )15;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[11] = (unsigned long )17;
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szpCodActabo;
        sqlstm.sqhstl[12] = (unsigned long )3;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&ihpCodProducto;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szpCodTipServ;
        sqlstm.sqhstl[14] = (unsigned long )2;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)szpCodPlanServ;
        sqlstm.sqhstl[15] = (unsigned long )4;
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szpFecEmision;
        sqlstm.sqhstl[16] = (unsigned long )15;
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[17] = (unsigned long )17;
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)szpFecEmision;
        sqlstm.sqhstl[18] = (unsigned long )15;
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[19] = (unsigned long )17;
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


    }
    else if (iIndBloqueo == iDESBLOQUEO)
    {
        vDTrazasLog (szExeName, "\n\t\t* Abonado con Suspencion Programada ", LOG06);
        /* EXEC SQL OPEN Cur_ServSuplSusp; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )355;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[0] = (unsigned long )17;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[1] = (unsigned long )17;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[2] = (unsigned long )17;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[3] = (unsigned long )17;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhpNumAbonado;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihpCodProducto;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihpSeis;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szpFecHasta;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[8] = (unsigned long )17;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[9] = (unsigned long )17;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szpFecDesde;
        sqlstm.sqhstl[10] = (unsigned long )15;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[11] = (unsigned long )17;
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szpFecEmision;
        sqlstm.sqhstl[12] = (unsigned long )15;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[13] = (unsigned long )17;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szpCodActabo;
        sqlstm.sqhstl[14] = (unsigned long )3;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&ihpCodProducto;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szpCodTipServ;
        sqlstm.sqhstl[16] = (unsigned long )2;
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)szpCodPlanServ;
        sqlstm.sqhstl[17] = (unsigned long )4;
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)szpFecEmision;
        sqlstm.sqhstl[18] = (unsigned long )15;
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[19] = (unsigned long )17;
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)szpFecEmision;
        sqlstm.sqhstl[20] = (unsigned long )15;
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)szpFormatoFec;
        sqlstm.sqhstl[21] = (unsigned long )17;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }

    if( SQLCODE )
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open => GA_SERVSUPLABO",szfnORAerror ());
    }

    piSqlCodeLocal = SQLCODE;

    while (!piSqlCodeLocal)
    {
        if (iIndBloqueo == iBLOQUEO_NORMAL)
        {
            /* EXEC SQL FETCH Cur_ServSupl
                INTO :ihCodConcepto :i_shCodConcepto,
                     :szhFecAltaCen :i_shFecAltaCen,
                     :szhFecBajaBD  :i_shFecBajaBD,
                     :szhFecAltaBD  :i_shFecAltaBD,
                     :szhFecBajaCen :i_shFecBajaCen,
                     :ihIndPro      ,
                     :szhCodServicio,
                     :szhCodMoneda,
                     :dhImpTarifa,
                     :ihIndCobRetr; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )2000;
            sqlstm.offset = (unsigned int  )458;
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
            sqlstm.sqindv[0] = (         short *)i_shCodConcepto;
            sqlstm.sqinds[0] = (         int  )sizeof(short);
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhFecAltaCen;
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )15;
            sqlstm.sqindv[1] = (         short *)i_shFecAltaCen;
            sqlstm.sqinds[1] = (         int  )sizeof(short);
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhFecBajaBD;
            sqlstm.sqhstl[2] = (unsigned long )15;
            sqlstm.sqhsts[2] = (         int  )15;
            sqlstm.sqindv[2] = (         short *)i_shFecBajaBD;
            sqlstm.sqinds[2] = (         int  )sizeof(short);
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhFecAltaBD;
            sqlstm.sqhstl[3] = (unsigned long )15;
            sqlstm.sqhsts[3] = (         int  )15;
            sqlstm.sqindv[3] = (         short *)i_shFecAltaBD;
            sqlstm.sqinds[3] = (         int  )sizeof(short);
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhFecBajaCen;
            sqlstm.sqhstl[4] = (unsigned long )15;
            sqlstm.sqhsts[4] = (         int  )15;
            sqlstm.sqindv[4] = (         short *)i_shFecBajaCen;
            sqlstm.sqinds[4] = (         int  )sizeof(short);
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)ihIndPro;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[5] = (         int  )sizeof(int);
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqharc[5] = (unsigned long  *)0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhCodServicio;
            sqlstm.sqhstl[6] = (unsigned long )4;
            sqlstm.sqhsts[6] = (         int  )4;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqharc[6] = (unsigned long  *)0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhCodMoneda;
            sqlstm.sqhstl[7] = (unsigned long )4;
            sqlstm.sqhsts[7] = (         int  )4;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqharc[7] = (unsigned long  *)0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)dhImpTarifa;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[8] = (         int  )sizeof(double);
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqharc[8] = (unsigned long  *)0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)ihIndCobRetr;
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


        }
        else if (iIndBloqueo == iDESBLOQUEO)
        {
            /* EXEC SQL FETCH Cur_ServSuplSusp
                INTO :ihCodConcepto :i_shCodConcepto,
                     :szhFecAltaCen :i_shFecAltaCen,
                     :szhFecBajaBD  :i_shFecBajaBD,
                     :szhFecAltaBD  :i_shFecAltaBD,
                     :szhFecBajaCen :i_shFecBajaCen,
                     :ihIndPro      ,
                     :szhCodServicio,
                     :szhCodMoneda,
                     :dhImpTarifa,
                     :ihIndCobRetr; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )2000;
            sqlstm.offset = (unsigned int  )513;
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
            sqlstm.sqindv[0] = (         short *)i_shCodConcepto;
            sqlstm.sqinds[0] = (         int  )sizeof(short);
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhFecAltaCen;
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )15;
            sqlstm.sqindv[1] = (         short *)i_shFecAltaCen;
            sqlstm.sqinds[1] = (         int  )sizeof(short);
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhFecBajaBD;
            sqlstm.sqhstl[2] = (unsigned long )15;
            sqlstm.sqhsts[2] = (         int  )15;
            sqlstm.sqindv[2] = (         short *)i_shFecBajaBD;
            sqlstm.sqinds[2] = (         int  )sizeof(short);
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhFecAltaBD;
            sqlstm.sqhstl[3] = (unsigned long )15;
            sqlstm.sqhsts[3] = (         int  )15;
            sqlstm.sqindv[3] = (         short *)i_shFecAltaBD;
            sqlstm.sqinds[3] = (         int  )sizeof(short);
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhFecBajaCen;
            sqlstm.sqhstl[4] = (unsigned long )15;
            sqlstm.sqhsts[4] = (         int  )15;
            sqlstm.sqindv[4] = (         short *)i_shFecBajaCen;
            sqlstm.sqinds[4] = (         int  )sizeof(short);
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)ihIndPro;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[5] = (         int  )sizeof(int);
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqharc[5] = (unsigned long  *)0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhCodServicio;
            sqlstm.sqhstl[6] = (unsigned long )4;
            sqlstm.sqhsts[6] = (         int  )4;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqharc[6] = (unsigned long  *)0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhCodMoneda;
            sqlstm.sqhstl[7] = (unsigned long )4;
            sqlstm.sqhsts[7] = (         int  )4;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqharc[7] = (unsigned long  *)0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)dhImpTarifa;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[8] = (         int  )sizeof(double);
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqharc[8] = (unsigned long  *)0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)ihIndCobRetr;
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


        }
        
        if (SQLCODE==SQLOK)
        {
            plNumFilas = TAM_HOSTS_PEQ;
        }
        else
        {
            if (SQLCODE==SQLNOTFOUND)
            {
                plNumFilas = sqlca.sqlerrd[2];
            }
            else
            {
                iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> GA_SERVSUPLABO",szfnORAerror ());
                return (FALSE);
            }
        }

        piSqlCodeLocal = SQLCODE;

        if (!plNumFilas)
        {
            break;
        }
        
        vDTrazasLog (szExeName, "\n\t\t* serv. supl [%ld]  ", LOG06, plNumFilas);


        if ( (pTmpSerA->pServicios=(SERVICIOS *)realloc ( (SERVICIOS *)pTmpSerA->pServicios,
             (pTmpSerA->iNumServicios+plNumFilas)*sizeof(SERVICIOS) ))== (SERVICIOS *)NULL)
        {
              iDError (szExeName,ERR005,vInsertarIncidencia, "pServAbo->pServicios");
              return FALSE;
        }
        
        memset (&pTmpSerA->pServicios[pTmpSerA->iNumServicios],0,sizeof (SERVICIOS)*plNumFilas);

        for (iCont = 0 ; iCont < plNumFilas ; iCont++)
        {
            vDTrazasLog (szExeName, "\t\t* Informacion de GA_SERVSUPLABO recuperados "
                                    "\n\t\t=> Cod. concepto  [%d] "
                                    "\n\t\t=> Ind. Prorrateo [%d] "
                                    "\n\t\t=> FEC_ALTACEN    [%s] "
                                    "\n\t\t=> FEC_BAJABD     [%s] "
                                    "\n\t\t=> FEC_ALTABD     [%s] "
                                    "\n\t\t=> FEC_BAJACEN    [%s] "
                                    "\n\t\t=> dImpTarifa     [%f] "
                                    "\n\t\t=> Ind. CobRetr   [%d] "                                    
                                  , LOG05, ihCodConcepto[iCont], ihIndPro[iCont]
                                  , szhFecAltaCen [iCont], szhFecBajaBD [iCont]
                                  , szhFecAltaBD  [iCont], szhFecBajaCen[iCont]
                                  , dhImpTarifa[iCont], ihIndCobRetr[iCont]);

            pTmpSerA->pServicios[pTmpSerA->iNumServicios].iCodConcepto =ihCodConcepto [iCont];
            
            pTmpSerA->pServicios[pTmpSerA->iNumServicios].iIndCobRetr = ihIndCobRetr [iCont];

            if(i_shFecAltaCen [iCont] == ORA_NULL)
            {
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecAltaCen[0] = 0;
                if( i_shFecAltaBD [iCont] != ORA_NULL )
                {
                    strcpy(pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecAltaCen, szhFecAltaBD[iCont]);
                }
            }
            else
            {
                strcpy(pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecAltaCen, szhFecAltaCen[iCont]);
            }
            
            if (i_shFecBajaBD [iCont] == ORA_NULL)
            {
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecBajaBD[0]=0;
                if( i_shFecBajaCen [iCont] != ORA_NULL )
                {
                    strcpy(pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecBajaBD, szhFecBajaCen[iCont]);
                }
            }
            else
            {
                strcpy(pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecBajaBD, szhFecBajaBD[iCont]);
            }
            
            /* P-MIX-09003 OVERRIDE XX */
            dhImporteOverride = 0.0;
            if ( !bFindOverrideSS(lhCodCliente,
                                  lhpNumAbonado,
                                  szhCodServicio[iCont],
                                  &dhImporteOverride))
            {
                vDTrazasLog (szExeName, "\n\t\t* NO Encontro Override para Servicio Suplementario %s"
                                      , LOG05,szhCodServicio[iCont]);
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpPeriodo  = dhImpTarifa[iCont]  ;
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto = dhImpTarifa[iCont]  ;
            }   
            else
            {
                vDTrazasLog (szExeName, "\n\t\t* Encontro Override para Servicio Suplementario [%s] [%f]"
                                      , LOG05
                                      , szhCodServicio[iCont]
                                      , pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpPeriodo);
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpPeriodo  = dhImporteOverride  ;
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto = dhImporteOverride  ;            	
            }         
            /* P-MIX-09003 OVERRIDE XX */

            strcpy(pTmpSerA->pServicios[pTmpSerA->iNumServicios].szCodMoneda, szhCodMoneda[iCont]);

            i = pTmpSerA->iNumServicios;

            stGrupoCob.iCodConcepto = ihCodConcepto[iCont];
            stGrupoCob.iCodProducto = ihpCodProducto      ;
            stGrupoCob.iCodCiclo    = stCiclo.iCodCiclo   ;

            if (!bValidacionServicio (&pTmpSerA->pServicios[pTmpSerA->iNumServicios]))
            {
                vDTrazasLog (szExeName, "\n\t\t*Servicio Suplementario %s NO Valido !"
                                      , LOG05, szhCodServicio[iCont]);
                return FALSE;
            }

            vDTrazasLog (szExeName, "\n\t\t* Valor Convertido al Salir de Validacion de Servicio [%10.4f]"
                                    "\n\t\t* Valor Convertido En La Estructura de Cliente-Abonado-Servicio [%10.4f]"
                                    "\n\t\t* pTmpSerA->iNumServicios [%d]"
                                    , LOG04,pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto
                                    , stCliente.pServAbo[iNumServAbo].pServicios[i].iCodConcepto
                                    , pTmpSerA->iNumServicios);

            strcpy (stGrupoCob.szCodGrupo,pTmpSerA->szCodGrpServ);
            if ( !bFindGrupoCob(&stGrupoCob))
            {
                vDTrazasLog (szExeName, "\n\t\t* NO Encontro grupo de Cobro %s", LOG05,stGrupoCob.szCodGrupo);
                    return FALSE;
            }

            switch (stGrupoCob.iTipCobro)
            {
                case VENCIDO    : pTmpSerA->pServicios[pTmpSerA->iNumServicios].iNumPeriodos = 0;
                          break;
                case ANTICIPADO : pTmpSerA->pServicios[pTmpSerA->iNumServicios].iNumPeriodos = 1;
                          break;
                default     : iDError(szExeName,ERR032,vInsertarIncidencia,stGrupoCob.iTipCobro);
                          return(FALSE);
            }
            
            vDTrazasLog (szExeName, "\n\t\t* switch Tipo de Cobro : [%d]", LOG05,stGrupoCob.iTipCobro);
            
            vDTrazasLog (szExeName, "\n\t\t* switch Num. Periodos : [%d]", LOG05,pTmpSerA->pServicios[pTmpSerA->iNumServicios].iNumPeriodos);

            memset ( &stPasoProrrateo, 0, sizeof(PASOPRORRATEO));

            if (strcmp(pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecAltaCen, szFecUltFact) >0 )
            {
                stPasoProrrateo.sIndAlta = 1;
            }
            else
            {
                stPasoProrrateo.sIndAlta = 0;
            }

            strcpy (stPasoProrrateo.szFecInicio , pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecAltaCen);
            strcpy (stPasoProrrateo.szFecTermino, pTmpSerA->pServicios[pTmpSerA->iNumServicios].szFecBajaBD);
            stPasoProrrateo.dImpServicio = pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpPeriodo;
            stPasoProrrateo.sIndTipoCobro= stGrupoCob.iTipCobro;
            stPasoProrrateo.sIndProrrateo= ihIndPro[iCont];                                                                     

/* P-MIX-09003 */  

            vDTrazasLog( szExeName, "\n** (bCargaServSuplementarios) Ejecución Package FA_SERVICIOS_FACTURACION_PG **"
                                  , LOG05);
                    
            lhNumAbonado   = pTmpSerA->lNumAbonado;
            lhCodCicloFact = stCiclo.lCodCiclFact;
            lhCodConcepto  = stGrupoCob.iCodConcepto;
            lhNumProceso   = stStatus.IdPro;
                 
            /* EXEC SQL EXECUTE
             BEGIN
                  FA_SERVICIOS_FACTURACION_PG.FA_ConsultaCobroAdelantado_PR
                  ( :lhNumAbonado,
                    :lhCodCicloFact,
                    :lhCodConcepto,
                    :lhNumProceso,
                    :lhNumOcurrencias,
                    :lhCodError,
                    :szhMsgError,
                    :lhEvento);
             END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin FA_SERVICIOS_FACTURACION_PG . FA_ConsultaCo\
broAdelantado_PR ( :lhNumAbonado , :lhCodCicloFact , :lhCodConcepto , :lhNumPr\
oceso , :lhNumOcurrencias , :lhCodError , :szhMsgError , :lhEvento ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )568;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCicloFact;
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
            sqlstm.sqhstv[3] = (unsigned char  *)&lhNumProceso;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&lhNumOcurrencias;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&lhCodError;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhMsgError;
            sqlstm.sqhstl[6] = (unsigned long )3001;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)&lhEvento;
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

	 
            
            vDTrazasLog( szExeName, "\n** (bCargaServSuplementarios) Package FA_SERVICIOS_FACTURACION_PG Procedure FA_ConsultaCobroAdelantado_PR() **"
                                              "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                              "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                              "\n\t\t\t=> lhCodConcepto..... [%d]"
                                              "\n\t\t\t=> lhNumPorceso...... [%ld]"
                                              "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                              "\n\t\t\t=> lhCodError........ [%ld]"
                                              "\n\t\t\t=> szhMsgError....... [%s]"
                                              "\n\t\t\t=> lhEvento.......... [%ld]"                                
                                              "\n\t\t\t=> SQLCODE..........  [%d]"                                                                                      
                                            , LOG05
                                            , lhNumAbonado
                                            , lhCodCicloFact
                                            , lhCodConcepto
                                            , lhNumProceso
                                            , lhNumOcurrencias
                                            , lhCodError
                                            , szhMsgError
                                            , lhEvento
                                            , SQLCODE);            
                  
            if ( SQLCODE != SQLOK  || lhCodError != 0)
            {       	
                 vDTrazasError( szExeName , "\n** (bCargaServSuplementarios) Error package FA_SERVICIOS_FACTURACION_PG    **"
                                                 "\n**  en procedure FA_ConsultaCobroAdelantado_PR() **"
                                                 " [%d]  [%s]"
                                               , LOG01,SQLCODE,SQLERRM);                                          
                 vDTrazasLog( szExeName, "\n** (bCargaServSuplementarios) Error en procedure FA_ConsultaCobroAdelantado_PR() **"
                                              "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                              "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                              "\n\t\t\t=> lhCodConcepto..... [%d]"
                                              "\n\t\t\t=> lhNumPorceso...... [%ld]"
                                              "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                              "\n\t\t\t=> lhCodError........ [%ld]"
                                              "\n\t\t\t=> szhMsgError....... [%s]"
                                              "\n\t\t\t=> lhEvento.......... [%ld]"
                                              "\n\t\t\t=> SQLCODE........... [%d]"
                                              "\n\t\t\t=> SQLERRM........... [%s]"                                                                                            
                                            , LOG01
                                            , lhNumAbonado
                                            , lhCodCicloFact
                                            , lhCodConcepto
                                            , lhNumProceso
                                            , lhNumOcurrencias
                                            , lhCodError
                                            , szhMsgError
                                            , lhEvento
                                            , SQLCODE
                                            , SQLERRM);
                 return(FALSE);
            }                           
               
            if ( lhNumOcurrencias > 0)
            {                  
                 pTmpSerA->pServicios[pTmpSerA->iNumServicios].iNumDiasPro = stCiclo.iDiaPeriodo;
                 pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto= fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);
            }
            else
            {
                if( !bfnProrrateoStandar(&stPasoProrrateo))
                {
                    vDTrazasLog (szExeName, "\n\t\t* NO se Prorrate-o el Importe Servicio Suplementario %s", LOG05,szhCodServicio);
                    return FALSE;
                }
                
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].iNumDiasPro = stPasoProrrateo.sDiasAbono;
                pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto= fnCnvDouble(stPasoProrrateo.dImpConcepto, USOFACT);
            
            }

            vDTrazasLog (szExeName, "\n\t** iNumDiasPro    [%d]**"
                                    "\n\t** dImpConcepto   [%f]**"
                                    "\n\t** Fec. Ult. Fact [%s]**"
                                    "\n\t** Fec. Emision   [%s]**"                                    
                                  , LOG05
                                  , pTmpSerA->pServicios[pTmpSerA->iNumServicios].iNumDiasPro
                                  , pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto
                                  , szhFecUltFact
                                  , stCiclo.szFecEmision);                                                 
                                  
            vDTrazasLog (szExeName, "\n\t\t* IndCobRetr [%d]"
                                  , LOG05
                                  , pTmpSerA->pServicios[pTmpSerA->iNumServicios].iIndCobRetr);                                  
             
            if ( pTmpSerA->pServicios[pTmpSerA->iNumServicios].iIndCobRetr != 0 )
            {
                 /* EXEC SQL
                      SELECT MONTHS_BETWEEN( TRUNC(TO_DATE(:stCiclo.szFecEmision,'YYYYMMDDHH24MISS'),'MONTH'), TRUNC(TO_DATE(:szhFecUltFact,'YYYYMMDDHH24MISS'),'MONTH') )
                      INTO   :ihCantidadMeses
                      FROM   DUAL; */ 

{
                 struct sqlexd sqlstm;
                 sqlstm.sqlvsn = 12;
                 sqlstm.arrsiz = 30;
                 sqlstm.sqladtp = &sqladt;
                 sqlstm.sqltdsp = &sqltds;
                 sqlstm.stmt = "select MONTHS_BETWEEN(TRUNC(TO_DATE(:b0,'YYY\
YMMDDHH24MISS'),'MONTH'),TRUNC(TO_DATE(:b1,'YYYYMMDDHH24MISS'),'MONTH')) into \
:b2  from DUAL ";
                 sqlstm.iters = (unsigned int  )1;
                 sqlstm.offset = (unsigned int  )615;
                 sqlstm.selerr = (unsigned short)1;
                 sqlstm.cud = sqlcud0;
                 sqlstm.sqlest = (unsigned char  *)&sqlca;
                 sqlstm.sqlety = (unsigned short)256;
                 sqlstm.occurs = (unsigned int  )0;
                 sqlstm.sqhstv[0] = (unsigned char  *)(stCiclo.szFecEmision);
                 sqlstm.sqhstl[0] = (unsigned long )15;
                 sqlstm.sqhsts[0] = (         int  )0;
                 sqlstm.sqindv[0] = (         short *)0;
                 sqlstm.sqinds[0] = (         int  )0;
                 sqlstm.sqharm[0] = (unsigned long )0;
                 sqlstm.sqadto[0] = (unsigned short )0;
                 sqlstm.sqtdso[0] = (unsigned short )0;
                 sqlstm.sqhstv[1] = (unsigned char  *)szhFecUltFact;
                 sqlstm.sqhstl[1] = (unsigned long )15;
                 sqlstm.sqhsts[1] = (         int  )0;
                 sqlstm.sqindv[1] = (         short *)0;
                 sqlstm.sqinds[1] = (         int  )0;
                 sqlstm.sqharm[1] = (unsigned long )0;
                 sqlstm.sqadto[1] = (unsigned short )0;
                 sqlstm.sqtdso[1] = (unsigned short )0;
                 sqlstm.sqhstv[2] = (unsigned char  *)&ihCantidadMeses;
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


                 
                 if ( SQLCODE != SQLOK )     
                 {
                      vDTrazasError(szExeName, "\n\t* Error en Calculo Meses (bCargaServSuplementarios) [%ld] [%s]"
                                             , LOG01, SQLCODE, szfnORAerror());
                      vDTrazasLog  (szExeName, "\n\t* Error en Calculo Meses (bCargaServSuplementarios) [%ld] [%s]"
                                             , LOG01, SQLCODE, szfnORAerror());
                      ihCantidadMeses = 0;                                             
                 }
                 
                 vDTrazasLog (szExeName, "\n\t\t* Cantidad Meses [%d]"
                                       , LOG05
                                       , ihCantidadMeses);                 
                 
                 if ( ihCantidadMeses > 1)
                 {
                      pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto = pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto * ihCantidadMeses;
                 }
            	
            }                                                                                        
/* P-MIX-09003 */                                    
            vDTrazasLog (szExeName, "\t\t* Importe Servicio Suplementario Prorrateado [%f]"
                                  , LOG05
                                  , pTmpSerA->pServicios[pTmpSerA->iNumServicios].dImpConcepto);

            pTmpSerA->iNumServicios++;
        }
    }

    if (iIndBloqueo == iBLOQUEO_NORMAL)
    { 
        /* EXEC SQL CLOSE Cur_ServSupl; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )642;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else if (iIndBloqueo == iDESBLOQUEO)
    {
        /* EXEC SQL CLOSE Cur_ServSuplSusp; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )657;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }

    if (SQLCODE)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> pServicios",szfnORAerror ());
    }

    vDTrazasLog (szExeName,"\t\t# Num.Servicios Suplementarios [%d]",LOG04,
                 pTmpSerA->iNumServicios - 1);

    return 1;
}/************************* Final bCargaServSuplementarios *******************/

/*****************************************************************************/
/*                         funcion : bInsertaCargosBasicos                   */
/* -Funcion que pasa a Fa_PreFactura los Abonos de Ga_Infac% ie:             */
/*          * stCliente.pAbonos (Cargos Basicos: Ga_Intar%-> Ta_CargosBasico)*/
/*****************************************************************************/
static BOOL bInsertaCargosBasicos (void)
{
    static int    i = 0, iInd = 0,  j = 0    ; 
    static int    iNumRegAbono = 0, k = 0    ;
    static int    iCodConcepto        = 0    ;
    static double dImpConcepto        = 0.0  ;
    static double dImpMontoBase       = 0.0  ; /* P-MIX-09003 134206 */    
    static char   szCodMoneda     [4] = ""   ;
    static char   szDesConcepto  [61] = ""   ;
    static BOOL   bError              = FALSE;
    char   szDia                          [3];
    char   szCantMesesRestar              [2];
    double dImpConceptoAux            = 0.0  ;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char szhFechaHabilAux   [14+1]; /* EXEC SQL VAR szhFechaHabilAux   IS STRING (14+1); */ 

	 char szhFechaHabil      [14+1]; /* EXEC SQL VAR szhFechaHabil      IS STRING (14+1); */ 
	 
	 char szhFechaInput      [14+1]; /* EXEC SQL VAR szhFechaInput      IS STRING (14+1); */ 

	 char szhDiaInput         [2+1]; /* EXEC SQL VAR szhDiaInput        IS STRING (2+1); */ 

	 char szhCantMesesRestar  [1+1]; /* EXEC SQL VAR szhCantMesesRestar IS STRING (1+1); */ 

	 char szhCodMoneda        [3+1]; /* EXEC SQL VAR szhCodMoneda       IS STRING (3+1); */ 

	 double dhImpConcepto          ;	 
    /* EXEC SQL END DECLARE SECTION; */ 
    
    
  memset(szhFechaHabil,'\0',sizeof(szhFechaHabil));
  memset(szhFechaHabilAux,'\0',sizeof(szhFechaHabilAux));  
  memset(szhFechaInput,'\0',sizeof(szhFechaInput));
  memset(szhDiaInput,'\0',sizeof(szhDiaInput));  
  memset(szhCantMesesRestar,'\0',sizeof(szhCantMesesRestar));  
  

  /*--- Inserto Cargos Basicos (stCliente.pAbonos) ---*/
   vDTrazasLog (szExeName, "\n\t\t* Paso a PreFactura CARGOS BASICOS ***"
                           "\n\t\t=> Cod.Cliente        [%ld]"
                           "\n\t\t=> Cod.CiclFact       [%ld]"
                           "\n\t\t=> Num.Cargos Basicos [%d] "
                         , LOG03,stCliente.lCodCliente
                         , stCiclo.lCodCiclFact
                         , stCliente.iNumAbonos);

   for (iInd=0;iInd<stCliente.iNumAbonos;iInd++)
   {
      for (k=0; k<stCliente.pAbonos[iInd].iNumCBasicos; k++)
      {
        /***************************************************************/
        /* En el mismo Registro  puede venir tanto el CodAbono como el */
        /* CodAbonoFin.                                                */
        /***************************************************************/
        if (stCliente.pAbonos[iInd].pstCBasico [k].iNumDiasFin > 0)
            iNumRegAbono = 2;
        else
            iNumRegAbono = 1;
        for (j=0;j<iNumRegAbono;j++)
        {
          i = stPreFactura.iNumRegistros;

          if (j==0)
          {
              /* Primer Abono */
              dImpConcepto  = fnCnvDouble(stCliente.pAbonos[iInd].pstCBasico[k].dImpConcepto, USOFACT);
              dImpMontoBase = fnCnvDouble(stCliente.pAbonos[iInd].pstCBasico[k].dImpMontoBase, USOFACT); /* P-MIX-09003 134206 */              
              iCodConcepto  = stCliente.pAbonos[iInd].pstCBasico[k].iCodAbono   ;

              strcpy (szCodMoneda  ,stCliente.pAbonos[iInd].pstCBasico[k].szCodMoneda);
              strcpy (szDesConcepto,stCliente.pAbonos[iInd].pstCBasico[k].szDesAbono );
          }
          else
          {
              /* Resto Abono */
              dImpConcepto = fnCnvDouble(stCliente.pAbonos[iInd].pstCBasico[k].dImpFinContrato, USOFACT);
              dImpConcepto = fnCnvDouble(stCliente.pAbonos[iInd].pstCBasico[k].dImpFinContrato, USOFACT); /* P-MIX-09003 134206 */
              iCodConcepto = stCliente.pAbonos[iInd].pstCBasico[k].iCodAbonoFin   ;

              strcpy (szDesConcepto,stCliente.pAbonos[iInd].pstCBasico[k].szDesAbonoFin );
              strcpy (szCodMoneda  ,stCliente.pAbonos[iInd].pstCBasico[k].szCodMonedaFin);
          }
          
          
          
          stPreFactura.A_PFactura[i].bOptAbonos    = TRUE                  ;
          stPreFactura.A_PFactura[i].lNumProceso   = stStatus.IdPro        ;
          stPreFactura.A_PFactura[i].lCodCliente   = stCliente.lCodCliente ;
          stPreFactura.A_PFactura[i].dImpMontoBase = dImpMontoBase         ; /* P-MIX-09003 134206 */
          stPreFactura.A_PFactura[i].lNumUnidades  = 1                     ;
          stPreFactura.A_PFactura[i].iIndEstado    = EST_NORMAL            ;
          stPreFactura.A_PFactura[i].iCodTipConce  = ARTICULO              ;
          stPreFactura.A_PFactura[i].lCodPlanCom   = stCliente.lCodPlanCom ;
          stPreFactura.A_PFactura[i].iCodCatImpos  = stCliente.iCodCatImpos;
          stPreFactura.A_PFactura[i].iCodConceRel  = 0                     ;
          stPreFactura.A_PFactura[i].lColumnaRel   = 0                     ;
          stPreFactura.A_PFactura[i].iFlagImpues   = 0                     ;
          stPreFactura.A_PFactura[i].fPrcImpuesto  = 0.0                   ;
          stPreFactura.A_PFactura[i].iFlagDto      = 0                     ;
          stPreFactura.A_PFactura[i].iIndFactur    = stCliente.pAbonos[iInd].iIndFactur;

          strcpy (stPreFactura.A_PFactura[i].szFecEfectividad, szSysDate               );
          strcpy (stPreFactura.A_PFactura[i].szCodRegion     , stCliente.szCodRegion   );
          strcpy (stPreFactura.A_PFactura[i].szCodProvincia  , stCliente.szCodProvincia);
          strcpy (stPreFactura.A_PFactura[i].szCodCiudad     , stCliente.szCodCiudad   );
          strcpy (stPreFactura.A_PFactura[i].szCodModulo     , stCliente.pAbonos[iInd].pstCBasico [k].szCodModulo);
          strcpy (stPreFactura.A_PFactura[i].szDesConcepto   , szDesConcepto           );

          stPreFactura.A_PFactura[i].iCodProducto  =
           (stCliente.pAbonos[iInd].lNumAbonado==0)?stDatosGener.iProdGeneral: stCliente.pAbonos[iInd].iCodProducto;

          stPreFactura.A_PFactura[i].iCodConcepto  = iCodConcepto;

          if (!bGetMaxColPreFa(stPreFactura.A_PFactura[i].iCodConcepto, &stPreFactura.A_PFactura[i].lColumna))
          {
               return FALSE;
          }
          
          strcpy (stPreFactura.A_PFactura[i].szCodMoneda, szCodMoneda         );
          strcpy (stPreFactura.A_PFactura[i].szFecValor , stCiclo.szFecEmision);

          stCliente.pAbonos[iInd].lColumna         = stPreFactura.A_PFactura[i].lColumna ;
          stPreFactura.A_PFactura[i].dImpConcepto  = dImpConcepto ;                                                       
          
          vDTrazasLog (szExeName, "\n\t\t* (bInsertaCargosBasicos) Conversión de Moneda para C. Básico ***"
                                , LOG05);

          if ( dImpMontoBase == 0) /* P-MIX-09003 134206 */
          {
               dhImpConcepto   = dImpConcepto; /* P-MIX-09003 4 */
               dImpConceptoAux = dImpConcepto; /* P-MIX-09003 4 */

               strcpy( szhFechaHabil, stCiclo.szFecDesdeCFijos); /* P-MIX-09003 4 */

               if (!bConversionMoneda ( stCliente.lCodCliente,
                                        stPreFactura.A_PFactura[i].szCodMoneda,
                                        stDatosGener.szCodMoneFact,
                                        szhFechaHabil,
                                        &dhImpConcepto))
               {                                
                   vDTrazasLog (szExeName, "\n\t\t* WARNING (bInsertaCargosBasicos) No se pudo obtener Factor de Conversion ***"
                                         , LOG05);              
               } /* P-MIX-09003 4 */
          
               if ( dhImpConcepto == 0 )
               {
                    stPreFactura.A_PFactura[i].dImpMontoBase = 0;
               }
               else
               {
                    if ( dImpConceptoAux != dhImpConcepto )
                    {
                         stPreFactura.A_PFactura[i].dImpMontoBase = fnCnvDouble(dhImpConcepto, 0) / 
                                                                    fnCnvDouble(dImpConceptoAux, 0);
                    }
                    else
                    {
               	        stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                    }
               } /* P-MIX-09003 4 */
          } /* P-MIX-09003 134206 */
                                       
          stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble(dImpConcepto, 0);
          strcpy (stPreFactura.A_PFactura[i].szNumTerminal, stCliente.pAbonos[iInd].szNumTerminal);
          stPreFactura.A_PFactura[i].lNumAbonado      = (stCliente.pAbonos [iInd].lNumAbonado == 0)?-1:stCliente.pAbonos[iInd].lNumAbonado  ;
          stPreFactura.A_PFactura[i].iIndAlta         = stCliente.pAbonos[iInd].iIndAlta;
          stPreFactura.A_PFactura[i].szNumSerieMec[0] = 0;
          stPreFactura.A_PFactura[i].szNumSerieLe [0] = 0;
          stPreFactura.A_PFactura[i].lCapCode         = ORA_NULL;
          stPreFactura.A_PFactura[i].iFlagImpues      = 0       ;
          stPreFactura.A_PFactura[i].iFlagDto         = 0       ;
          stPreFactura.A_PFactura[i].fPrcImpuesto     = 0.0     ;
          stPreFactura.A_PFactura[i].dValDto          = 0.0     ;
          stPreFactura.A_PFactura[i].iTipDto          = 0       ;
          stPreFactura.A_PFactura[i].lNumVenta        = 0       ;
          stPreFactura.A_PFactura[i].lNumTransaccion  = 0       ;
          stPreFactura.A_PFactura[i].iMesGarantia     = 0       ;
          stPreFactura.A_PFactura[i].iIndSuperTel     = 0       ;
          stPreFactura.A_PFactura[i].iNumPaquete      = 0       ;
          stPreFactura.A_PFactura[i].iIndCuota        = 0       ;
          stPreFactura.A_PFactura[i].iNumCuotas       = 0       ;
          stPreFactura.A_PFactura[i].iOrdCuota        = 0       ;

          strcpy(stPreFactura.A_PFactura[i].szCodPlanTarif  , stCliente.pAbonos[iInd].pstCBasico [k].szCodPlanTarif);
          strcpy(stPreFactura.A_PFactura[i].szCodCargoBasico, stCliente.pAbonos[iInd].pstCBasico [k].szCodCargoBasico);
          strcpy(stPreFactura.A_PFactura[i].szTipPlanTarif  , stCliente.pAbonos[iInd].pstCBasico [k].szTipPlanTarif);

          if (!bfnGetSegCBasico (stPreFactura.A_PFactura[i].lNumAbonado,
                                 stPreFactura.A_PFactura[i].szCodPlanTarif,
                                 stCiclo.lCodCiclFact,
                                 &stPreFactura.A_PFactura[i].lSegConsumido ))
          {
              return (FALSE);
          }

          vPrintRegInsert (i,"Abonos",bError);

          if(bfnIncrementarIndicePreFactura()==FALSE)
          {
              vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
              vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
              return FALSE;
          }
            
          vDTrazasLog (szExeName, "\n\t\t* (bInsertaCargosBasicos) Paso a PreFactura CARGOS BASICOS II ***"
                                  "\n\t\t=> Cod.Cliente        [%ld]"
                                  "\n\t\t=> Num.Abonado        [%ld]"
                                  "\n\t\t=> Plan Tarif.         [%s]"
                                  "\n\t\t=> Imp. Concepto       [%f]"                           
                                , LOG05
                                , stPreFactura.A_PFactura[i].lCodCliente
                                , stPreFactura.A_PFactura[i].lNumAbonado
                                , stPreFactura.A_PFactura[i].szCodPlanTarif
                                , stPreFactura.A_PFactura[i].dImpConcepto); /* P-MIX-09003 */
                                    
        }/* fin for iNumRegistros */

     }/* fin for k ... */

   }/* fin for iInd ... */

   return TRUE;
}/************************ Final bInsertaCargosBasicos ***********************/

BOOL bfnFindMonedaCBasico( char *szCodCargoBasico, 
                           char *szFecEmision, 
                           char *szCodMoneda)                                                                                            
{
    char szFuncion[]="bfnFindMonedaCBasico";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhCodCargoBasico  [3+1]; /* EXEC SQL VAR szhCodCargoBasico  IS STRING (3+1); */ 

         char szhFecEmision     [14+1]; /* EXEC SQL VAR szhFecEmision      IS STRING (14+1); */ 

         char szhCodMoneda       [3+1]; /* EXEC SQL VAR szhCodMoneda       IS STRING (3+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 
	

    memset(szhCodCargoBasico,'\0',sizeof(szhCodCargoBasico));
    memset(szhFecEmision,'\0',sizeof(szhFecEmision));
    memset(szhCodMoneda,'\0',sizeof(szhCodMoneda));
    
    strcpy(szhCodCargoBasico,szCodCargoBasico);
    strcpy(szhFecEmision,szFecEmision);
    
    vDTrazasLog ( szFuncion, "\n\tParametros de Entrada Función bfnFindMonedaCBasico"
	                     "\n\t\t==> Cód.Cargo Básico   [%s]"
	                     "\n\t\t==> Fecha Emision      [%s]"	                     
	                   , LOG05
	                   , szhCodCargoBasico
	                   , szhFecEmision);
	                   
    /* EXEC SQL
         SELECT COD_MONEDA
         INTO   :szhCodMoneda
         FROM   TA_CARGOSBASICO
         WHERE  COD_PRODUCTO    = 1
         AND    COD_CARGOBASICO = :szhCodCargoBasico
         AND    TO_DATE(:szhFecEmision, 'YYYYMMDDHH24MISS') BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_MONEDA into :b0  from TA_CARGOSBASICO where ((\
COD_PRODUCTO=1 and COD_CARGOBASICO=:b1) and TO_DATE(:b2,'YYYYMMDDHH24MISS') be\
tween FEC_DESDE and FEC_HASTA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )672;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodMoneda;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodCargoBasico;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


         
    if (SQLCODE != SQLOK && SQLCODE == SQLNOTFOUND)
    {
	vDTrazasError(szFuncion, "\n\n\tERROR en Select Tabla TA_CARGOSBASICO [%d]:[%s] "
	                       , LOG01,SQLCODE,SQLERRM);
    	vDTrazasLog  (szFuncion, "\n\n\tERROR en Select Tabla TA_CARGOSBASICO [%d]:[%s] "
	                       , LOG01, SQLCODE, SQLERRM);
	                       
	return FALSE;
	                       
    } 
    
    strcpy(szCodMoneda,szhCodMoneda);        
	                     
    vDTrazasLog ( szFuncion, "\n\tParametros de Salida Función bfnFindMonedaCBasico"
	                     "\n\t\t==> Cod. Moneda [%s]"
	                   , LOG05
	                   , szCodMoneda); 	                       
	
    return TRUE;
}

/*****************************************************************************/
/*                         funcion : bEMAbonos                               */
/* -Funcion que pasa a Fa_PreFactura Ge_Cargos y Ta_CargosBasico             */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bEMAbonos (void)
{
     vDTrazasLog (szExeName,
                  "\n\t\t* Paso a PreFactura ABONOS "
                  "\n\t\t=> Cliente [%ld]",LOG03,stCliente.lCodCliente);

     strcpy (stAnomProceso.szDesProceso,"Paso a PreFactura Abonos")     ;

     if (!bInsertaCargosBasicos ())
     {
          return FALSE;
     }
     if (!bEMArriendos ())
     {
          return FALSE;
     }
     if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
     {
         if (!bUpdateIndInfas ())
         {
                return FALSE;
         }
     }
     return TRUE;
}/************************* Final bEMAbonos **********************************/


/*****************************************************************************/
/*                        funcion : bEMServicios                             */
/* -Funcion que pasa a Fa_PreFactura los Servicios Suplementarios y Ocasiona-*/
/*  les de un cliente acumulados en stCliente.pServAbo :                     */
/*          * Serv.Suplementario => Ga_ServSuplAbo y Ga_Tarifas              */
/*          * Serv.Ocasional     => Ga_ActuaServ   y Ga_Tarifas              */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bEMServicios (void)
{
    register int  iInd1  = 0;
    register int  iInd2  = 0;
    int           i      = 0    ;
    BOOL          bError = FALSE;
    double        dImpConceptoAux;

    vDTrazasLog (szExeName, "\n\t\t* Paso a PreFactura de Servicios"
                            "\n\t\t=>Cod.Cliente [%ld]"
                          , LOG04,stCliente.lCodCliente);

    for (iInd1=0;iInd1<stCliente.iNumServAbo;iInd1++)
    {
        for (iInd2=0;iInd2<stCliente.pServAbo[iInd1].iNumServicios;iInd2++)
        {
            if (stCliente.pServAbo[iInd1].pServicios[iInd2].dImpConcepto>=0.01)
            {
                i = stPreFactura.iNumRegistros;

                stPreFactura.A_PFactura[i].bOptServicios= TRUE                 ;
                stPreFactura.A_PFactura[i].lNumProceso  = stStatus.IdPro       ;
                stPreFactura.A_PFactura[i].lCodCliente  = stCliente.lCodCliente;
                stPreFactura.A_PFactura[i].lCodCiclFact = stCiclo.lCodCiclFact ;
                stPreFactura.A_PFactura[i].iIndEstado   = EST_NORMAL           ;
                stPreFactura.A_PFactura[i].iCodTipConce = ARTICULO             ;
                stPreFactura.A_PFactura[i].iIndFactur   = stCliente.pServAbo[iInd1].iIndFactur;

                strcpy (stPreFactura.A_PFactura[i].szFecEfectividad,szSysDate) ;
                strcpy (stPreFactura.A_PFactura[i].szCodRegion     , stCliente.szCodRegion)   ;
                strcpy (stPreFactura.A_PFactura[i].szCodProvincia  , stCliente.szCodProvincia);
                strcpy (stPreFactura.A_PFactura[i].szCodCiudad     , stCliente.szCodCiudad)   ;
                strcpy (stPreFactura.A_PFactura[i].szCodModulo     , "SE");

                stPreFactura.A_PFactura[i].lNumAbonado   = stCliente.pServAbo[iInd1].lNumAbonado ;
                stPreFactura.A_PFactura[i].iCodProducto  = stCliente.pServAbo[iInd1].iCodProducto;
                stPreFactura.A_PFactura[i].iIndAlta      = stCliente.pServAbo[iInd1].iIndAlta    ;
                stPreFactura.A_PFactura[i].lCapCode      = stCliente.pServAbo[iInd1].lCapCode    ;
                stPreFactura.A_PFactura[i].lCodPlanCom   = stCliente.pServAbo[iInd1].lCodPlanCom ;
                stPreFactura.A_PFactura[i].iCodCatImpos  = stCliente.iCodCatImpos                ;

                strcpy (stPreFactura.A_PFactura[i].szFecValor   , stCiclo.szFecEmision);
                strcpy (stPreFactura.A_PFactura[i].szNumTerminal, stCliente.pServAbo[iInd1].szNumTerminal);
                strcpy (stPreFactura.A_PFactura[i].szDesConcepto, stCliente.pServAbo[iInd1].pServicios[iInd2].szDesConcepto);
                stPreFactura.A_PFactura[i].iCodConcepto =         stCliente.pServAbo[iInd1].pServicios[iInd2].iCodConcepto  ;

                if (!bGetMaxColPreFa (stPreFactura.A_PFactura[i].iCodConcepto, &stPreFactura.A_PFactura[i].lColumna))
                {
                     return FALSE;
                }

                stCliente.pServAbo[iInd1].pServicios[iInd2].lColumna = stPreFactura.A_PFactura[i].lColumna ;

                stPreFactura.A_PFactura[i].iCodConceRel   = 0;
                stPreFactura.A_PFactura[i].lColumnaRel    = 0;
                strcpy(stPreFactura.A_PFactura[i].szCodMoneda , stCliente.pServAbo[iInd1].pServicios[iInd2].szCodMoneda);

                stPreFactura.A_PFactura[i].dImpConcepto   = stCliente.pServAbo[iInd1].pServicios[iInd2].dImpConcepto;
                stPreFactura.A_PFactura[i].dImpFacturable = stCliente.pServAbo[iInd1].pServicios[iInd2].dImpConcepto;
                
                dImpConceptoAux = stPreFactura.A_PFactura[i].dImpFacturable; /* P-MIX-09003 4 */

                if (!bConversionMoneda (stCliente.lCodCliente                     ,
                                        stPreFactura.A_PFactura[i].szCodMoneda    ,
                                        stDatosGener.szCodMoneFact                ,
                                        stCiclo.szFecDesdeCFijos                  ,
                                        &stPreFactura.A_PFactura[i].dImpFacturable))
                {
                     return FALSE;
                } /* P-MIX-09003 4 */
                
                if ( stPreFactura.A_PFactura[i].dImpFacturable == 0 )
                {
                     stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                }
                else
                {
                     if (dImpConceptoAux != stPreFactura.A_PFactura[i].dImpFacturable)
                     {
                         stPreFactura.A_PFactura[i].dImpMontoBase = fnCnvDouble(stPreFactura.A_PFactura[i].dImpFacturable, 0) / 
                                                                      fnCnvDouble(dImpConceptoAux, 0);
                     }
                     else
                     {
                     	stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                     }
                } /* P-MIX-09003 4 */                

                stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable, 0);
                stPreFactura.A_PFactura[i].szNumSerieMec[0] = 0;
                stPreFactura.A_PFactura[i].szNumSerieLe [0] = 0;
                stPreFactura.A_PFactura[i].lCapCode        = ORA_NULL;
                stPreFactura.A_PFactura[i].iFlagImpues     = 0       ;
                stPreFactura.A_PFactura[i].iFlagDto        = 0       ;
                stPreFactura.A_PFactura[i].fPrcImpuesto    = 0.0     ;
                stPreFactura.A_PFactura[i].dValDto         = 0.0     ;
                stPreFactura.A_PFactura[i].iTipDto         = 0       ;
                stPreFactura.A_PFactura[i].lNumVenta       = 0       ;
                stPreFactura.A_PFactura[i].lNumTransaccion = 0       ;
                stPreFactura.A_PFactura[i].iMesGarantia    = 0       ;
                stPreFactura.A_PFactura[i].lNumUnidades    = 1       ;
                stPreFactura.A_PFactura[i].iIndSuperTel    = 0       ;
                stPreFactura.A_PFactura[i].iNumPaquete     = 0       ;
                stPreFactura.A_PFactura[i].iIndCuota       = 0       ;
                stPreFactura.A_PFactura[i].iNumCuotas      = 0       ;
                stPreFactura.A_PFactura[i].iOrdCuota       = 0       ;

                vPrintRegInsert (i,"Servicios",bError);

                if(bfnIncrementarIndicePreFactura()==FALSE)
                {
                    vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                    vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                    return FALSE;
                }
            }/* fin if dImpConcepto */
        }/* fin for iInd2 */
    }/* fin for iInd1 */
    return TRUE;
}/************************** Final bEMServicios ******************************/

/*****************************************************************************/
/*                          funcion : bValidacionAbono                       */
/* -Funcion que valida que el CodAbono (Concepto) sea valido ie:             */
/*              * IndActivo = 1 y CodTipConce = 3 y ImpConcepto >= 0.01      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bValidacionAbono (int iCodProducto, long lNumAbonado,
                              CARGOFIJO *pAbo)
{
    int    iRes         = 0    ;
    int    iCodConcepto = 0    ;
    double dImpConcepto = 0.0  ;
    BOOL   bFin         = FALSE;
    BOOL   bPrimeraVez  = TRUE ;

    CONCEPTO stConcepto;

    while (!bFin && iRes == 0)
    {
        dImpConcepto = fnCnvDouble(pAbo->dImpConcepto, USOFACT);
        if (bPrimeraVez)
        {
            iCodConcepto = pAbo->iCodAbono   ;
            if (pAbo->iNumDiasFin == 0)
            {
                bFin = TRUE;
            }
        }
        else
        {
            iCodConcepto= pAbo->iCodAbonoFin;
            bFin        = TRUE              ;
        }
        memset (&stConcepto,0,sizeof(CONCEPTO));
        if (!bFindConcepto (iCodConcepto,&stConcepto))
        {
            iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
            iRes = ERR021                                                ;
        }
        else
        {
            if (bPrimeraVez)
            {
                strcpy (pAbo->szCodMoneda,stConcepto.szCodMoneda  );
                strcpy (pAbo->szDesAbono ,stConcepto.szDesConcepto);
                bPrimeraVez = FALSE;
                vDTrazasLog (szExeName,"\t\t* Cod_Moneda: [%s]  [%s]\n",
                                       LOG05,stConcepto.szCodMoneda,
                                       pAbo->szCodMoneda);
            }
            else
            {
                strcpy (pAbo->szCodMonedaFin,stConcepto.szCodMoneda  );
                strcpy (pAbo->szDesAbonoFin ,stConcepto.szDesConcepto);
            }
            strcpy (pAbo->szCodModulo,stConcepto.szCodModulo);
            if (stConcepto.iIndActivo == 0)
            {
                sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
                        stConcepto.iIndActivo);
                iRes = ERR001;
            }
            else if (dImpConcepto < 0)
            {
                sprintf (stAnomProceso.szObsAnomalia,
                        "%s %lf","Importe menor que Cero",
                        dImpConcepto);
                iRes = ERR001;
            }
            else if (stConcepto.iCodTipConce == IMPUESTO ||
                     stConcepto.iCodTipConce == DESCUENTO)
            {
                sprintf (stAnomProceso.szObsAnomalia,"%s %d",
                            "Tipo de Concepto (Descuento o Impuesto)",
                            stConcepto.iCodTipConce);
                iRes = ERR001;
            }
        }

        if (iRes != 0)
        {
            stAnomProceso.iCodConcepto = pAbo->iCodAbono                   ;
            stAnomProceso.iCodProducto = iCodProducto                      ;
            strcpy (stAnomProceso.szDesProceso,"PreBilling Cargos Basicos");
            stAnomProceso.lNumAbonado  = lNumAbonado                       ;

            stEstAbonos.iNumAnomalias++;
            stEstAbonos.dImpAnomalias += dImpConcepto;
            if (iRes == ERR001)
            {
                iDError (szExeName,ERR001,vInsertarIncidencia,
                            stConcepto.iIndActivo  ,
                            stConcepto.iCodTipConce,
                            dImpConcepto);
            }
        }
        else
        {
            stEstAbonos.iNumCorrectos++;
        }
        stEstAbonos.iNumProcesad++;
    }
    return (iRes == 0)?TRUE:FALSE;
}/***************************** Final bValidacionAbono ***********************/

/*****************************************************************************/
/*                            funcion : vfnEstadistica                       */
/*****************************************************************************/
static void vfnEstadisticas (long lNumAbonado)
{
    vDTrazasLog (szExeName, "\n\t\t* ESTADISTICAS - Cliente[%ld] - Abonado[%ld]"
                            "\n\t\t* Numero de Cargos.................[%d] "
                            "\n\t\t* Numero de Cargos Procesados......[%d] "
                            "\n\t\t* Numero de Cargos Correctos.......[%d] "
                            "\n\t\t* Numero de Anomalias..............[%d] "
                            "\n\t\t* Numero Cargos Basicos Procesados.[%d] "
                            "\n\t\t* Numero Cargos Basicos Correctos..[%d] "
                            "\n\t\t* Numero Cargos Basicos Anomalos...[%d] "
                          , LOG05
                          , stCliente.lCodCliente
                          , lNumAbonado
                          , stCliente.iNumCargos
                          , stEstCargos.iNumProcesad
                          , stEstCargos.iNumCorrectos
                          , stEstCargos.iNumAnomalias
                          , stEstAbonos.iNumProcesad
                          , stEstAbonos.iNumCorrectos
                          , stEstAbonos.iNumAnomalias);
 }/***************************** Final vfnEstadistica *************************/

/*****************************************************************************/
/*                         funcion : bUpdateIndInfas                         */
/* -Funcion que updatea los IndAlta e IndActuac de las tablas Ga_Infac% ie:  */
/*        * Si IndActuacOld == NORMAL => IndAlta = 0                         */
/*        * Si IndActuacOld == RECHAZO=> IndActuac == BAJA                   */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bUpdateIndInfas (void)
{
    char szMsg[50]=""    ;
    int  iInd     = 0    ;
    BOOL bRes     = TRUE ;
    BOOL bUpdate  = FALSE;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char*  szhRowid    ; /* EXEC SQL VAR szhRowid      IS STRING (19); */ 

         static short  shIndAlta   ;
         static short  shIndBloqueo;
    /* EXEC SQL END DECLARE SECTION  ; */ 


    while (bRes && iInd<stCliente.iNumAbonos)
    {
        shIndAlta    = 0;
        shIndBloqueo = 0;

        szhRowid = stCliente.pAbonos[iInd].szRowid;
        /********************************************************************/
        /* Los Registros con Rowid a Null son los de Arriendo               */
        /********************************************************************/
        if (strlen (szhRowid) != 0)
        {
            /*******************************************************/
            /* Si esta bloqueado la linea permanece con el ind_alta*/
            /* a 1, y el estado de bloqueado. Si estamos en bloqueo*/
            /* el NumCBasicos == 0, por lo tanto no Update es False*/
            /*******************************************************/
            shIndAlta = (stCliente.pAbonos[iInd].iIndAlta     ==0)?0       :
                        (stCliente.pAbonos[iInd].iIndBloqueo  ==iBLOQUEADO &&
                        stCliente.pAbonos[iInd].iNumCBasicos == 0)?1:0;

            shIndBloqueo =
                        (stCliente.pAbonos[iInd].iIndBloqueo==iBLOQUEADO ||
                         stCliente.pAbonos[iInd].iIndBloqueo==iDESBLOQUEO)?iBLOQUEO_FACTUR:
                         stCliente.pAbonos[iInd].iIndBloqueo;

            bUpdate= (shIndAlta   !=stCliente.pAbonos[iInd].iIndAlta ||
                   shIndBloqueo!=stCliente.pAbonos[iInd].iIndBloqueo)?TRUE:FALSE;

            if (bUpdate)
            {
                strcpy (szMsg,"Update->Ga_InfacCel");
                /* EXEC SQL
                    UPDATE GA_INFACCEL
                       SET IND_BLOQUEO = :shIndBloqueo
                     WHERE ROWID       = :szhRowid; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 30;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update GA_INFACCEL  set IND_BLOQUEO=:b0 where\
 ROWID=:b1";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )699;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&shIndBloqueo;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
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
                {
                    iDError (szExeName,ERR000,vInsertarIncidencia,szMsg, szfnORAerror());
                    bRes = FALSE;
                }
            }/* fin if Update */
        }
        else
        {
            bRes = FALSE          ;
            iDError (szExeName,ERR000,vInsertarIncidencia,"Update Ga_Infac%", "Rowid null");
        }
        if (bRes)
            iInd++;

    }
    return (bRes);
}/**************************** Final bUpdateIndInfas *************************/

/*****************************************************************************/
/*                             funcion : vFreeAbonos                         */
/*****************************************************************************/
void vFreeAbonos (void)
{
    register int i = 0;

    vDTrazasLog (szExeName, "\t\t=> stCliente.iNumAbonos:[%d]   i:[%d]\n", LOG05, stCliente.iNumAbonos, i);
    for (i=0; i<stCliente.iNumAbonos;i++)
    {
        if (stCliente.pAbonos[i].pstCBasico != (CARGOFIJO *)NULL)
        {
            free (stCliente.pAbonos[i].pstCBasico)             ;
            stCliente.pAbonos[i].pstCBasico = (CARGOFIJO *)NULL;
        }
    }
    if (stCliente.pAbonos != (ABONOS *)NULL)
    {
        free (stCliente.pAbonos)          ;
        stCliente.pAbonos = (ABONOS *)NULL;
   }
   stCliente.iNumAbonos = 0;
}/*************************** Final vFreeAbonos ******************************/

/*****************************************************************************/
/*                             funcion : vFreeServicios                      */
/*****************************************************************************/
void vFreeServicios (void)
{
    register int iInd = 0;

    if (stCliente.pServAbo != (SERVABO *)NULL)
    {
        for (iInd=0;iInd<stCliente.iNumServAbo;iInd++)
        {
             free (stCliente.pServAbo[iInd].pServicios);
             stCliente.pServAbo[iInd].pServicios = (SERVICIOS *)NULL;
             stCliente.pServAbo[iInd].iNumServicios = 0;
        }
        
        free (stCliente.pServAbo);
        stCliente.pServAbo = (SERVABO *)NULL;
    }
    
    stCliente.iNumServAbo = 0;
}/*************************** Final vFreeServicios ***************************/

/*****************************************************************************/
/*                         funcion : bCargaArriendos                         */
/* -Funcion que carga los Arriendos de un Abonado a Facturar en ciclo        */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaArriendos(long  lCodCliente ,
                            long  lNumAbonado ,
                            int   iCodProducto,
                            char *szCodGrpServ)

{

    GRUPOCOB      stGrpCob;
    PASOPRORRATEO stPasoProrrateo;
    register int  iInd = 0;
    int           iNum = 0;

    vDTrazasLog (szExeName,"\n\t\t* Cargando Arriendos"
                           "\n\t\t=> Cod.Cliente    [%ld]"
                           "\n\t\t=> Num.Abonado    [%ld]"
                           "\n\t\t=> Cod.Producto   [%d] ",LOG05,
                           lCodCliente,lNumAbonado,iCodProducto);

    for (iInd=0;iInd<NUM_ARRIENDOS;iInd++)
    {
        if ( (pstArriendo[iInd].lCodCliente == lCodCliente) &&
             (pstArriendo[iInd].lNumAbonado == lNumAbonado) &&
             (pstArriendo[iInd].iCodProducto== iCodProducto) )
        {
            if ((stCliente.pArriendo =
                (ARRIENDO *)realloc ( (ARRIENDO *)stCliente.pArriendo,
                 sizeof (ARRIENDO)*(stCliente.iNumArriendos+1) ) )==(ARRIENDO *)NULL)
            {
                iDError (szExeName,ERR005,vInsertarIncidencia,"stCliente.pArriendo");
                return FALSE;
            }
            memset (&stCliente.pArriendo[stCliente.iNumArriendos],0,sizeof (ARRIENDO));
            memcpy (&stCliente.pArriendo[stCliente.iNumArriendos],&pstArriendo [iInd],sizeof (ARRIENDO));

            strcpy (stCliente.pArriendo[stCliente.iNumArriendos].szCodGrpServ,szCodGrpServ);

            if (strcmp (pstArriendo[iInd].szFecHasta,stCiclo.szFecHastaCFijos) <= 0)
            {
                /*************************************************************/
                /* Si se cumple la Condicion es el ultimo arriendo que se le */
                /* factura, se modifica en la Ga_Infac% el indicativo        */
                /*************************************************************/
                vDTrazasLog (szExeName,
                            "\n\t\t* Parametros Update Ga_InfacCel (IndArriendo = 0)\n"
                            "\t\t=> Cod.Cliente   [%ld]\n"
                            "\t\t=> Num.Abonado   [%ld]\n"
                            "\t\t=> Cod.CiclFact  [%ld]\n",LOG04,
                            lCodCliente,lNumAbonado,stCiclo.lCodCiclFact);

                /* EXEC SQL
                    UPDATE  GA_INFACCEL
                    SET     IND_ARRIENDO  = 0
                    WHERE   COD_CLIENTE   = :lCodCliente
                    AND     NUM_ABONADO   = :lNumAbonado
                    AND     COD_CICLFACT  = :stCiclo.lCodCiclFact; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 30;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update GA_INFACCEL  set IND_ARRIENDO=0 where \
((COD_CLIENTE=:b0 and NUM_ABONADO=:b1) and COD_CICLFACT=:b2)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )722;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
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
                sqlstm.sqhstv[2] = (unsigned char  *)&(stCiclo.lCodCiclFact);
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
                    iDError (szExeName,ERR000,vInsertarIncidencia,"UPDATE  GA_INFACCEL", szfnORAerror());
                    return FALSE;
                }

            }
            iNum = stCliente.iNumArriendos;
            /*****************************************************************/
            /* Esto no deberia ocurrir porque el arriendo deberia estar ce-  */
            /* rrado y el IndArriendo == 0                                   */
            /*****************************************************************/
            if (strcmp (stCliente.pArriendo[iNum].szFecHasta,
                        stCiclo.szFecDesdeCFijos) < 0)
            {
                stCliente.pArriendo[iNum].dImpConcepto = 0.0;
            }
            else
            {
            /****************************** Nuevo Codigo *********************************/

                memset (&stGrpCob,0,sizeof(GRUPOCOB));

                stGrpCob.iCodConcepto  = pstArriendo[iNum].iCodConcepto;
                stGrpCob.iCodProducto  = pstArriendo[iNum].iCodProducto;
                stGrpCob.iCodCiclo     = stCiclo.iCodCiclo;
                strcpy(stGrpCob.szCodGrupo,pstArriendo[iNum].szCodGrpServ);

                if ( !bFindGrupoCob(&stGrpCob))
                {
                     return FALSE;
                }

                memset ( &stPasoProrrateo, 0, sizeof(PASOPRORRATEO));

                strcpy (stPasoProrrateo.szFecInicio,stCliente.pArriendo[iNum].szFecDesde);
                strcpy (stPasoProrrateo.szFecTermino,stCliente.pArriendo[iNum].szFecHasta);
                stPasoProrrateo.dImpServicio = stCliente.pArriendo[iNum].dPrecioMes ;
                stPasoProrrateo.sIndTipoCobro= stGrpCob.iTipCobro;
                stPasoProrrateo.sIndProrrateo= 1;

                if (!bfnProrrateoStandar(&stPasoProrrateo))
                {
                    return FALSE;
                }

                stCliente.pArriendo[iNum].dImpConcepto     = stPasoProrrateo.dImpConcepto;
                stCliente.pArriendo[iNum].iNumDiasArriendo = stPasoProrrateo.sDiasAbono;

                vDTrazasLog (szExeName, "\n\t\t* Importe Arriendo [%f]"
                                      , LOG05
                                      , stCliente.pArriendo[iNum].dImpConcepto);

            } /*FIN ELSE */
        
            if (!bValidacionArriendo (&stCliente.pArriendo[iNum]))
            {
                return FALSE;
            }

            stCliente.iNumArriendos++;
        }

    }/* fin for ... */

    return TRUE;
}/************************* Final bCargaArriendos ****************************/


/*****************************************************************************/
/*                        funcion : bEMArriendos                             */
/* -Funcion que guarda en stPreFactura los Conceptos de Arriendo que tenga el*/
/*  Cliente a procesar.                                                      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bEMArriendos (void)
{
    int           i      = 0;
    register int  iInd   = 0;
    BOOL          bError = FALSE;
    double        dImpConceptoAux;

    for (iInd=0;iInd<stCliente.iNumArriendos;iInd++)
    {
        if (stCliente.pArriendo[i].dImpConcepto >= 0.01)
        {
            i = stPreFactura.iNumRegistros;

            stPreFactura.A_PFactura[i].bOptArriendo= TRUE                 ;
            stPreFactura.A_PFactura[i].lNumProceso = stStatus.IdPro       ;
            stPreFactura.A_PFactura[i].lCodCliente = stCliente.lCodCliente;
            stPreFactura.A_PFactura[i].lCodCiclFact= stCiclo.lCodCiclFact ;
            stPreFactura.A_PFactura[i].iIndFactur  = FACTURABLE           ;
            stPreFactura.A_PFactura[i].iIndEstado  = EST_NORMAL           ;
            stPreFactura.A_PFactura[i].iCodTipConce= ARTICULO             ;

            strcpy (stPreFactura.A_PFactura[i].szFecEfectividad, szSysDate);
            strcpy (stPreFactura.A_PFactura[i].szCodRegion     , stCliente.szCodRegion)   ;
            strcpy (stPreFactura.A_PFactura[i].szCodProvincia  , stCliente.szCodProvincia);
            strcpy (stPreFactura.A_PFactura[i].szCodCiudad     , stCliente.szCodCiudad)   ;
            strcpy (stPreFactura.A_PFactura[i].szCodModulo     , stCliente.pArriendo[iInd].szCodModulo);

            stPreFactura.A_PFactura[i].lNumAbonado   = stCliente.pArriendo[iInd].lNumAbonado ;
            stPreFactura.A_PFactura[i].iCodProducto  = stCliente.pArriendo[iInd].iCodProducto;

            stPreFactura.A_PFactura[i].iIndAlta      = 0;

            stPreFactura.A_PFactura[i].lCodPlanCom   = stCliente.lCodPlanCom ;
            stPreFactura.A_PFactura[i].iCodCatImpos  = stCliente.iCodCatImpos;

            /*************************************************************/
            /* La fecha Valor del Arriendo sera la del Mes en Cursor del */
            /* Arriendo en su caso FecDesdeCFijos.                       */
            /*************************************************************/
            strcpy (stPreFactura.A_PFactura[i].szFecValor   , stCiclo.szFecEmision);
                    /* stCiclo.szFecDesdeCFijos                   ); */
            stPreFactura.A_PFactura[i].szNumTerminal[0] = 0     ;

            strcpy (stPreFactura.A_PFactura[i].szDesConcepto, stCliente.pArriendo [iInd].szDesConcepto   );

            stPreFactura.A_PFactura[i].iCodConcepto = stCliente.pArriendo[iInd].iCodConcepto;
            if (!bGetMaxColPreFa (stPreFactura.A_PFactura[i].iCodConcepto, &stPreFactura.A_PFactura[i].lColumna))
                return FALSE;


            stPreFactura.A_PFactura[i].iCodConceRel   = 0;
            stPreFactura.A_PFactura[i].lColumnaRel    = 0;
            strcpy(stPreFactura.A_PFactura[i].szCodMoneda , stCliente.pArriendo[iInd].szCodMoneda);

            stPreFactura.A_PFactura[i].dImpConcepto   = stCliente.pArriendo[iInd].dImpConcepto;
            stPreFactura.A_PFactura[i].dImpFacturable = stCliente.pArriendo[iInd].dImpConcepto;
            
            dImpConceptoAux = stPreFactura.A_PFactura[i].dImpFacturable; /* P-MIX-09003 4 */
            
            if (!bConversionMoneda (stCliente.lCodCliente                     ,
                                    stPreFactura.A_PFactura[i].szCodMoneda    ,
                                    stDatosGener.szCodMoneFact                ,
                                    stCiclo.szFecDesdeCFijos                  ,
                                    &stPreFactura.A_PFactura[i].dImpFacturable))
            {
                return FALSE;
            } /* P-MIX-09003 4 */            

            if (stPreFactura.A_PFactura[i].dImpFacturable == 0)
            {
                stPreFactura.A_PFactura[i].dImpMontoBase = 0;
            }
            else
            {
            	if (dImpConceptoAux != stPreFactura.A_PFactura[i].dImpFacturable)
            	{
                    stPreFactura.A_PFactura[i].dImpMontoBase = fnCnvDouble(stPreFactura.A_PFactura[i].dImpFacturable,0)/fnCnvDouble(dImpConceptoAux,0);
                }
                else
                {
                    stPreFactura.A_PFactura[i].dImpMontoBase = 0;                	
                }
            } /* P-MIX-09003 4 */

            stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable, 0);
            stPreFactura.A_PFactura[i].szNumSerieMec[0] = 0;
            stPreFactura.A_PFactura[i].szNumSerieLe [0] = 0;
            stPreFactura.A_PFactura[i].lCapCode        = ORA_NULL;
            stPreFactura.A_PFactura[i].iFlagImpues     = 0       ;
            stPreFactura.A_PFactura[i].iFlagDto        = 0       ;
            stPreFactura.A_PFactura[i].fPrcImpuesto    = 0.0     ;
            stPreFactura.A_PFactura[i].dValDto         = 0.0     ;
            stPreFactura.A_PFactura[i].iTipDto         = 0       ;
            stPreFactura.A_PFactura[i].lNumVenta       = 0       ;
            stPreFactura.A_PFactura[i].lNumTransaccion = 0       ;
            stPreFactura.A_PFactura[i].lNumTransaccion = 0       ;
            stPreFactura.A_PFactura[i].iMesGarantia    = 0       ;
            stPreFactura.A_PFactura[i].iIndAlta        = 0       ;
            stPreFactura.A_PFactura[i].iIndSuperTel    = 0       ;
            stPreFactura.A_PFactura[i].iNumPaquete     = 0       ;
            stPreFactura.A_PFactura[i].iIndCuota       = 0       ;
            stPreFactura.A_PFactura[i].iNumCuotas      = 0       ;
            stPreFactura.A_PFactura[i].iOrdCuota       = 0       ;

            vPrintRegInsert (i,"Arriendos",bError);

            if(bfnIncrementarIndicePreFactura()==FALSE)
            {
                vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                return FALSE;
            }

        }
    }
    return TRUE;
}/********************************* Final bEMArriendos ***********************/

/*****************************************************************************/
/*                          funcion : bValidacionArriendo                    */
/* -Funcion que valida que el CodConcepto(Concepto) sea valido ie:           */
/*              * IndActivo = 1 y CodTipConce = 3 y ImpConcepto >= 0.01      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bValidacionArriendo (ARRIENDO *pArr)
{
    int iRes = 0;

    CONCEPTO stConcepto;

    memset (&stConcepto,0,sizeof(CONCEPTO));

    if (!bFindConcepto (pArr->iCodConcepto,&stConcepto))
    {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
        iRes = ERR021;
    }
    else
    {
        strcpy (pArr->szDesConcepto,stConcepto.szDesConcepto);
        strcpy (pArr->szCodModulo  ,stConcepto.szCodModulo  );
        if (stConcepto.iIndActivo == 0)
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
                     stConcepto.iIndActivo);
            iRes = ERR001;
        }
        else if (pArr->dImpConcepto < 0)
        {
            sprintf (stAnomProceso.szObsAnomalia,
                     "%s %lf","Importe menor que Cero",
                      pArr->dImpConcepto);
            iRes = ERR001;
        }
        else if  (stConcepto.iCodTipConce == IMPUESTO ||
                  stConcepto.iCodTipConce == DESCUENTO)
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %d",
                      "Tipo de Concepto (Descuento o Impuesto)",
                      stConcepto.iCodTipConce);
            iRes = ERR001;

        }
        else if ( strcmp (pArr->szCodMoneda,stConcepto.szCodMoneda) != 0 )
        {
            if (!bConversionMoneda (stCliente.lCodCliente,
                                    pArr->szCodMoneda,
                                    stConcepto.szCodMoneda,
                                    stCiclo.szFecDesdeCFijos,
                                    &pArr->dImpConcepto))
            {
                iRes = -1;
            }
            else
            {
                strcpy (pArr->szCodMoneda,stConcepto.szCodMoneda); /* P-MIX-09003 4*/
            }
        }
    }
    if (iRes != 0)
    {
        stAnomProceso.iCodConcepto = pArr->iCodConcepto          ;
        stAnomProceso.iCodProducto = pArr->iCodProducto          ;
        strcpy (stAnomProceso.szDesProceso,"PreBilling Arriendo");
        stAnomProceso.lNumAbonado  = pArr->lNumAbonado           ;
        if (iRes == ERR001)
        {
            iDError (szExeName,ERR001,vInsertarIncidencia,
                     stConcepto.iIndActivo  ,
                     stConcepto.iCodTipConce,
                     pArr->dImpConcepto);
        }
    }
    return (iRes == 0)?TRUE:FALSE;
}/**************************** Final bValidacionArriendo ********************/

/* ***************************************************************************/
/*                          funcion : bValidacionServicio                    */
/* -Funcion que valida que el CodConcepto(Concepto) sea valido ie:           */
/*              * IndActivo = 1 y CodTipConce = 3 y ImpConcepto >= 0.01      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bValidacionServicio (SERVICIOS *pSer)
{
    int iRes = 0;
    CONCEPTO stConcepto;
    static double dhImpConcepto      = 0.0  ;

    memset (&stConcepto,0,sizeof(CONCEPTO));

    vDTrazasLog (szExeName, "\t\t* Validacion de Servicios"
                            "\n\t\t=> Codigo Concepto     [%d]"
                            "\n\t\t=> Importe Concepto    [%.f]"
                            ,LOG05,
                            pSer->iCodConcepto,
                            pSer->dImpConcepto );

    stAnomProceso.iCodConcepto = pSer->iCodConcepto;

    if (!bFindConcepto (pSer->iCodConcepto,&stConcepto))
    {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstConcepto");
        iRes = ERR021;
    }
    else
    {
        strcpy (pSer->szDesConcepto, stConcepto.szDesConcepto);
        if (stConcepto.iIndActivo == 0)
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
                     stConcepto.iIndActivo);
            iRes = ERR001;
        }
        else if (pSer->dImpConcepto < 0)
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %lf","Importe menor que Cero",
                     pSer->dImpConcepto);
            iRes = ERR001;
        }
        else if (stConcepto.iCodTipConce == IMPUESTO ||
                stConcepto.iCodTipConce == DESCUENTO)
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %d",
                     "Tipo de Concepto (Descuento o Impuesto)",
                     stConcepto.iCodTipConce);
            iRes = ERR001;

        }
        else if ( strcmp (pSer->szCodMoneda,stConcepto.szCodMoneda) != 0 )
        {
            dhImpConcepto = pSer->dImpConcepto  ;

            if (!bConversionMoneda (stCliente.lCodCliente   ,
                                    pSer->szCodMoneda       ,
                                    stConcepto.szCodMoneda  ,
                                    stCiclo.szFecDesdeCFijos,
                                    &dhImpConcepto          ))
                iRes = -1;
            else
            {
                vDTrazasLog (szExeName, "\n\t\t* Valor Convertido en ValidacionServicio [%.f]",
                                        LOG05,dhImpConcepto);
                strcpy (pSer->szCodMoneda,stConcepto.szCodMoneda);
                pSer->dImpConcepto = fnCnvDouble(dhImpConcepto, USOFACT);
                pSer->dImpPeriodo  = fnCnvDouble(dhImpConcepto, USOFACT);
            } /* P-MIX-09003 4 */
        }
    }

    if (iRes != 0)
    {
        stAnomProceso.iCodConcepto = pSer->iCodConcepto           ;
        stAnomProceso.iCodProducto = stConcepto.iCodProducto      ;
        strcpy (stAnomProceso.szDesProceso,"PreBilling Servicios");

        if (iRes == ERR001)
        {
            iDError (   szExeName,ERR001       ,
                        vInsertarIncidencia    ,
                        stConcepto.iIndActivo  ,
                        stConcepto.iCodTipConce,
                        pSer->dImpConcepto);
        }
    }
    return (iRes == 0)?TRUE:FALSE;
}/***************************** Final bValidacionServicio ********************/

/*****************************************************************************/
/*                        funcion : bfnGetServicios                          */
/* - Carga de Servicios Suplementarios y Servicios Ocasionales               */
/*****************************************************************************/
static BOOL bfnGetServicios (long lCodCliente,
                             int  iNumServs  ,
                             int  iIndFactur ,
                             int  iIndBloqueo,
                             char *szFecUltFact)
{
    int iRes = 1;

    vDTrazasLog (szExeName, "\t*** Generacion de Servicios ***" , LOG05);

    if (bCargaServOcasionales    (iNumServs, iIndFactur))
    {
        if (iIndBloqueo == iBLOQUEO_NORMAL || iIndBloqueo == iDESBLOQUEO)
        {
            if (!bCargaServSuplementarios (lCodCliente, iNumServs, iIndFactur, iIndBloqueo, szFecUltFact))
            {
                iRes = 0;
            }
        }
    }
    return (iRes)?TRUE:FALSE;
}/************************ Final bfnGetServicios *****************************/

/*****************************************************************************/
/*                        funcion : ifnDBOpenIntar                           */
/*****************************************************************************/
static int ifnDBOpenIntar (long  lCodCliente ,
                           char *pszFecDesde ,
                           char *pszFecHasta ,
                           long  lNumAbonado ,
                           int   iCodProducto,
                           int   iCodCiclo   ,
                           int   iIndAlta       )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char  szFecEmision [15];/* EXEC SQL VAR szFecEmision       IS STRING(15); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    char szCaso [25]="";

    if (iCodProducto != stDatosGener.iProdCelular )
    {
        vDTrazasError (szExeName,"\n\t\t=> Producto Desconocido [%d]",
                                 LOG03, iCodProducto);
        return -1                          ;
    }

    strcpy (szFecEmision, stCiclo.szFecEmision);
    strcpy(szpFormatoFec,"YYYYMMDDHH24MISS");
    ihpZero = 0;

    /* EXEC SQL DECLARE Cur_IntarCel CURSOR FOR
         SELECT  ROWID                             ,
                 TO_CHAR (FEC_DESDE,:szpFormatoFec),
                 TO_CHAR (FEC_HASTA,:szpFormatoFec),
                 COD_CARGOBASICO                   ,
                 COD_PLANSERV                      ,
                 COD_PLANCOM                       ,
                 TO_CHAR (NUM_CELULAR)             ,
                 COD_GRPSERV                       ,
                 TIP_PLANTARIF                     ,
                 COD_PLANTARIF                     ,
                 COD_GRUPO
         FROM    GA_INTARCEL
         WHERE   COD_CLIENTE   = :lCodCliente
         AND     NUM_ABONADO   = :lNumAbonado
         AND     IND_NUMERO    = :ihpZero
         AND     FEC_DESDE     < TO_DATE (:pszFecHasta, :szpFormatoFec)
         AND     COD_CICLO     = :iCodCiclo
         AND     FEC_HASTA    >= TO_DATE (:pszFecDesde, :szpFormatoFec)
       /oAND     FEC_DESDE    <= TO_DATE (:szFecEmision,:szpFormatoFec)o/ 
         ORDER BY FEC_DESDE DESC
         FOR UPDATE; */ 


    strcpy (szCaso, "Open=> Ga_IntarCel");

    vDTrazasLog (szExeName,"\n\t\t* Open=> Ga_IntarCel"
                               "\n\t\t=> Cod.Cliente   [%ld]"
                               "\n\t\t=> Num.Abonado   [%ld]"
                               "\n\t\t=> Cod.Producto  [%d] "
                               "\n\t\t=> Cod.Ciclo     [%d] "
                               "\n\t\t=> FechaDesde  >=[%s] "
                               "\n\t\t=> FechaHasta   <[%s] "
                               "\n\t\t=> FechaEmision<=[%s] "                               
                             , LOG05
                             , lCodCliente , lNumAbonado
                             , iCodProducto, iCodCiclo  
                             , pszFecDesde
                             , pszFecHasta
                             , szFecEmision);

    /* EXEC SQL OPEN Cur_IntarCel; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0011;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )749;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szpFormatoFec;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szpFormatoFec;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lNumAbonado;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihpZero;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)pszFecHasta;
    sqlstm.sqhstl[5] = (unsigned long )0;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szpFormatoFec;
    sqlstm.sqhstl[6] = (unsigned long )17;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&iCodCiclo;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)pszFecDesde;
    sqlstm.sqhstl[8] = (unsigned long )0;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szpFormatoFec;
    sqlstm.sqhstl[9] = (unsigned long )17;
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



    if (SQLCODE)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,szCaso,szfnORAerror ());
    }

    return (SQLCODE);

}/************************ Final ifnDBOpenIntar ******************************/

/*****************************************************************************/
/*                        funcion : ifnDBFetchIntar                          */
/*****************************************************************************/
static int ifnDBFetchIntar (CARGOFIJO *pstAbo, int iCodProducto)
{
    char szCaso [35]="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         /* EXEC SQL VAR pstAbo->szRowid          IS STRING (19); */ 

         /* EXEC SQL VAR pstAbo->szFecDesde       IS STRING (15); */ 

         /* EXEC SQL VAR pstAbo->szFecHasta       IS STRING (15); */ 

         /* EXEC SQL VAR pstAbo->szCodCargoBasico IS STRING (4) ; */ 

         /* EXEC SQL VAR pstAbo->szCodPlanServ    IS STRING (4) ; */ 

         /* EXEC SQL VAR pstAbo->szCodGrpServ     IS STRING (3) ; */ 

         /* EXEC SQL VAR pstAbo->szNumTerminal    IS STRING (16); */ 

         /* EXEC SQL VAR pstAbo->szTipPlanTarif   IS STRING (2) ; */ 

         /* EXEC SQL VAR pstAbo->szCodPlanTarif   IS STRING (4) ; */ 

         static short i_shCodGrupo                           ;
    /* EXEC SQL END DECLARE SECTION  ; */ 


    strcpy (szCaso,"Fetch=> Ga_IntarCel ");

    vDTrazasLog (szExeName,"\n\t\t* %s"
                           "\n\t\t=> Cod.Producto [%d]",
                           LOG05, szCaso, iCodProducto);

    if (iCodProducto != stDatosGener.iProdCelular)
    {
        vDTrazasError (szExeName,"\n\t\t=> Producto Desconocido [%d]",LOG03, iCodProducto);
        return -1;
    }
    strcpy (szCaso, "Fetch=> Ga_IntarCel");

    /* EXEC SQL FETCH Cur_IntarCel INTO :pstAbo->szRowid                 ,
                                     :pstAbo->szFecDesde              ,
                                     :pstAbo->szFecHasta              ,
                                     :pstAbo->szCodCargoBasico        ,
                                     :pstAbo->szCodPlanServ           ,
                                     :pstAbo->lCodPlanCom             ,
                                     :pstAbo->szNumTerminal           ,
                                     :pstAbo->szCodGrpServ            ,
                                     :pstAbo->szTipPlanTarif          ,
                                     :pstAbo->szCodPlanTarif          ,
                                     :pstAbo->lCodGrupo :i_shCodGrupo ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )804;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstAbo->szRowid);
    sqlstm.sqhstl[0] = (unsigned long )19;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstAbo->szFecDesde);
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstAbo->szFecHasta);
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstAbo->szCodCargoBasico);
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstAbo->szCodPlanServ);
    sqlstm.sqhstl[4] = (unsigned long )4;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&(pstAbo->lCodPlanCom);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstAbo->szNumTerminal);
    sqlstm.sqhstl[6] = (unsigned long )16;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstAbo->szCodGrpServ);
    sqlstm.sqhstl[7] = (unsigned long )3;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstAbo->szTipPlanTarif);
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstAbo->szCodPlanTarif);
    sqlstm.sqhstl[9] = (unsigned long )4;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&(pstAbo->lCodGrupo);
    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)&i_shCodGrupo;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,szCaso,szfnORAerror());
    }
    return (SQLCODE);
}/*********************** Final ifnDBFetchIntar ******************************/

/*****************************************************************************/
/*                       funcion : ifnDBCloseIntar                           */
/*****************************************************************************/
static int ifnDBCloseIntar (int iCodProducto)
{
    char szCaso [25] = "";

    strcpy (szCaso, "Close=> Ga_IntarCel");

    vDTrazasLog (szExeName,"\t\t* Close=> Ga_IntarCel", LOG05, iCodProducto);
    /* EXEC SQL CLOSE Cur_IntarCel; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )863;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,szCaso,szfnORAerror ());
    }

    return (SQLCODE);
}/************************** Final ifnDBCloseIntar ***************************/

/*****************************************************************************/
/*                          funcion : bfnCargaCargoBasico                    */
/* - Funcion que recupera los Cargos Basicos de un Cliente-Abonado.          */
/* - En el proceso de Ciclo, se podran recuperar varios registros, debido al */
/*   posible cambio de plan tarifario que sufran los abonados pertenecientes */
/*   al mismo cliente. Estos tendran una forma distinta de calcular su impor-*/
/*   te, dependiendo si es el que esta en vigencia, o es un plan antiguo.    */
/*****************************************************************************/
static BOOL bfnCargaCargoBasico (ABONOS *pstAbo,
                                 char   *szFecDesde,
                                 char   *szFecHasta,
                                 int    iBloqueo,
                                 int    iTipoFact)
{
    int        rc              = 0;
    int        iServicios      = 1;
    int        j, flag         = 0;
    int        m               = 0;
    static int iNumDias        = 0;
    char       fec_desde_aux   [9];
    char       fec_hasta_aux   [9];
    CARGOFIJO  stCBasico;

    vDTrazasLog (szExeName, "\n\t\t* Carga Cargos Basicos"
                            "\n\t\t=> Cod.Cliente [%ld]"
                            "\n\t\t=> Num.Abonado [%ld]"
                            "\n\t\t=> Cod.Producto[%ld]"
                            "\n\t\t=> Fec.DesdeCF [%s] "
                            "\n\t\t=> Fec.HastaCF [%s] "
                            "\n\t\t=> Factura Blk.[%d] "
                            "\n\t\t=> Tipo Fact.  [%d] ", LOG04,
                            stCliente.lCodCliente, pstAbo->lNumAbonado,
                            pstAbo->iCodProducto , szFecDesde         ,
                            szFecHasta, iBloqueo , iTipoFact);

    if (ifnDBOpenIntar (stCliente.lCodCliente, szFecDesde, szFecHasta, pstAbo->lNumAbonado ,
                        pstAbo->iCodProducto , stCiclo.iCodCiclo,pstAbo->iIndAlta ))
    {                        
        return FALSE;
    }

    while (rc == 0)
    {
        memset (&stCBasico, 0, sizeof (CARGOFIJO));

        rc = ifnDBFetchIntar (&stCBasico, pstAbo->iCodProducto);

        switch (rc)
        {
            case SQLOK      :
                stCBasico.iCodAbono =stDatosGener.iCodAbonoCel;
                stCBasico.iCodAbonoFin =stDatosGener.iCodAbonoFinCel;
                
                if(pstAbo->iNumCBasicos > 0)
                {
                    if(!strcmp(stCBasico.szCodCargoBasico, pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szCodCargoBasico))
                    {
                        memset(fec_hasta_aux,0,sizeof(fec_hasta_aux));
                        strncpy(fec_hasta_aux,stCBasico.szFecHasta,8);

                        memset(fec_desde_aux,0,sizeof(fec_desde_aux));
                        strncpy(fec_desde_aux,pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecDesde,8);

                        vDTrazasLog (szExeName, "\n\t\t* Hay lagunas entre [%s] vs [%s]", LOG05,fec_desde_aux, fec_hasta_aux);
                        if(strcmp(fec_desde_aux, fec_hasta_aux) != 0)
                        {
                            if(bRestaFechas( pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecDesde, stCBasico.szFecHasta, &iNumDias))
                            {
                                iNumDias *= -1;
                                vDTrazasLog (szExeName, "\t\t* Fecha Hasta [%s] se restan [%d] dias", LOG05,pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecHasta,iNumDias);
                                if(!bSumaDias(pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecHasta, pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecHasta,iNumDias))
                                {
                                    vDTrazasLog(szExeName, "\n\t\t* Problemas al restar %d dia a [%s]\n", LOG02, iNumDias, pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecHasta);
                                }
                                vDTrazasLog (szExeName, "\t\t* Nueva Fecha Hasta [%s].", LOG05,pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecHasta);
                            }
                        }
                        vDTrazasLog (szExeName, "\n\t\t* Fecha desde [%s] se reemplaza por [%s]", LOG05,pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecDesde, stCBasico.szFecDesde);
                        strcpy(pstAbo->pstCBasico[pstAbo->iNumCBasicos-1].szFecDesde, stCBasico.szFecDesde);
                        continue;
                    }
                }

                if (stCliente.szTipPlanTarif [0] == 0)
                {
                      strcpy (stCliente.szTipPlanTarif, stCBasico.szTipPlanTarif);
                }

                if (pstAbo->szCodPlanTarif [0] == 0)
                {
                      strcpy (pstAbo->szCodPlanTarif, stCBasico.szCodPlanTarif);
                }

                if (pstAbo->lCodGrupo <= 0)
                {
                      pstAbo->lCodGrupo = stCBasico.lCodGrupo;
                }

                strcpy (pstAbo->szNumTerminal, stCBasico.szNumTerminal);

                if ((pstAbo->pstCBasico =
                      (CARGOFIJO *)realloc ( (CARGOFIJO *)pstAbo->pstCBasico,
                      (pstAbo->iNumCBasicos + 1) * sizeof (CARGOFIJO)))
                                          == (CARGOFIJO *)NULL)
                {
                    iDError (szExeName,ERR005,vInsertarIncidencia, "pstAbo->pstCBasico");
                        return  (FALSE) ;
                }
                memcpy (&pstAbo->pstCBasico [pstAbo->iNumCBasicos], &stCBasico, sizeof (CARGOFIJO));
                pstAbo->iNumCBasicos++ ;

                if (iServicios)
                {
                    /*********************************************************/
                    /*  Los Cargos Basicos agrupados, tendran las misma infor*/
                    /* macion, para los servicios. CodGrpServ, CodPlanServ,..*/
                    /*  Por ese motivo solo se efectua una vez.              */
                    /*********************************************************/
                    if (!bfnInfServicios (pstAbo, stCBasico))
                        return FALSE ;

                    iServicios = 0;

                }
                break;
            case SQLNOTFOUND:
                break;
            default         :
                return FALSE;
        }/* fin switch */
    }/* fin while */

    m=pstAbo->iNumCBasicos-1;

    if (pstAbo->iNumCBasicos > 1)   /* Tiene mas de 1 registro en GA_INTARCEL ==> Se analiza si */
    {                               /* existe al menos 1 cambio de plan con vigencia inmediata  */
        j=m;
        while( j>0 )
        {
            vDTrazasLog (szExeName, "\n\t\t* Comprobacion traslape de dias Entrada FecDesde [%s] vs FecHasta[%s]", LOG03,pstAbo->pstCBasico[j-1].szFecDesde, pstAbo->pstCBasico[j].szFecHasta);

            memset(fec_desde_aux,0,sizeof(fec_desde_aux));
            strncpy(fec_desde_aux,pstAbo->pstCBasico[j-1].szFecDesde,8);

            memset(fec_hasta_aux,0,sizeof(fec_hasta_aux));
            strncpy(fec_hasta_aux,pstAbo->pstCBasico[j].szFecHasta,8);

            if( strcmp(fec_desde_aux, fec_hasta_aux) == 0 )
            {
                if( !bSumaDias(pstAbo->pstCBasico[j].szFecHasta,pstAbo->pstCBasico[j].szFecHasta,-1) )
                {
                    vDTrazasLog(szExeName, "\n\t\t* Problemas al restar 1 dia a [%s]\n", LOG02, pstAbo->pstCBasico[j].szFecHasta);
                }
                else
                {
                    memset(fec_hasta_aux,0,sizeof(fec_hasta_aux));
                    strncpy(fec_hasta_aux,pstAbo->pstCBasico[j].szFecHasta,8);
                    sprintf(pstAbo->pstCBasico[j].szFecHasta,  "%ld235959", atol(fec_hasta_aux));
                    sprintf(pstAbo->pstCBasico[j-1].szFecDesde,"%ld000000", atol(fec_desde_aux));
                }
            }
            vDTrazasLog (szExeName, "\t\t* Comprobacion traslape de dias Salida  FecDesde [%s] vs FecHasta[%s]"
                                  , LOG05,pstAbo->pstCBasico[j-1].szFecDesde, pstAbo->pstCBasico[j].szFecHasta);
            j--;
        }

        j=m;
        flag=0;

        while((strcmp(pstAbo->pstCBasico[j].szCodCargoBasico, pstAbo->pstCBasico[j-1].szCodCargoBasico)==0) && (j>0))
        {
            j--;
        }
        if(j==0)
        {
            flag=0;                  /* No tiene cambios de plan con vigencia inmediata */
        }
        else
        {
            flag=1;                  /* Existe al menos 1 cambio de plan con vigencia inmediata */
        }
    }

    /*************************************************************************/
    /*    No Tiene Registros Para el Periodo  ( Baja o Traspaso )            */
    /*************************************************************************/
    if (pstAbo->iNumCBasicos == 0)
    {
        vDTrazasLog (szExeName, "\n\t\t* Abonado Sin  Periodo Vigente en Ga_Intar.....", LOG03);
        return TRUE;
    }

    vDTrazasLog (szExeName, "\n\t\t* Cambios de Plan Inmediato: %s"
                            "\n\t\t* Numero de Registros (M): %d"
                            "\n\t\t* Fecha Desde Antes : %s"
                            "\n\t\t* Fecha Hasta Antes : %s"
                            "\n\t\t* Fecha Desde CFijo : %s"
                            "\n\t\t* Fecha Hasta CFijo : %s"
                            ,LOG05
                            ,(flag==1?"SI":"NO")
                            ,m+1
                            ,pstAbo->pstCBasico[0].szFecDesde
                            ,pstAbo->pstCBasico[0].szFecHasta
                            ,szFecDesde
                            ,szFecHasta);

    if((flag==0) && (m > 0))/* Mas de un cargo en GA_INTARCEL */
    {
        if (strcmp(pstAbo->pstCBasico[0].szFecHasta,szFecHasta) > 0 )
        {
            strcpy(pstAbo->pstCBasico[0].szFecHasta,szFecHasta);
        }

        pstAbo->iNumCBasicos=1;
        if (!bRestaFechas ( pstAbo->pstCBasico[j].szFecHasta,
                            pstAbo->pstCBasico[j].szFecDesde,
                            &iNumDias))
        {
            vDTrazasLog(szExeName,  "\n\t\t* Fecha Desde Despues: %s"
                                    "\n\t\t* Fecha Hasta Despues: %s"
                                    "\n\t\t* Numero de Dias     : %d"
                                    , LOG05,pstAbo->pstCBasico[0].szFecDesde
                                    , pstAbo->pstCBasico[0].szFecHasta,iNumDias);
        }
    }
    else
    {
        vDTrazasLog (szExeName, "\n\t\t* Logica especial para Cambio de Plan Inmediato", LOG05);
    }

    if (rc == SQLNOTFOUND)
    {
        if (ifnDBCloseIntar (pstAbo->iCodProducto))
        {
            return FALSE;
        }
    }
    return TRUE;
}/************************** Final bfnCargaCargoBasico ***********************/


/*****************************************************************************/
/*                         funcion : bfnObtImpCargoBasico                    */
/* - En el caso del Abonado 0, el tipo de plan tarifario sera H o E, y sera  */
/*   al abonado 0, al que se le facturara el cargo basico, por lo tanto este */
/*   ira a nivel de Cliente.                                                 */
/*****************************************************************************/
static BOOL bfnObtImpCargoBasico (ABONOS *pstAbo    ,
                                  char   *szFecDesde,
                                  char   *szFecHasta,
                                  int     iBloqueo  ,
                                  int     iTipoFact,
                                  char   *szFecUltFact)
{
    char   szDia             [2+1];
    char   szCantMesesRestar [1+1];
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long   lhCodCliente            ;
         long   lhNumAbonado            ;
         long   lhCodCiclFact           ;
         long   lhIndActEspec           ;
         int    ihIndActuac_CicloAnt    ;
         char   szhCodPlantarif      [4]; /* EXEC SQL VAR szhCodPlantarif    IS STRING(4); */ 

         double dhImpDescuento          ;
         char   szhFecDesdeDcto     [15]; /* EXEC SQL VAR szhFecDesdeDcto    IS STRING(15); */ 

         char   szhFecHastaDcto     [15]; /* EXEC SQL VAR szhFecHastaDcto    IS STRING(15); */ 

         char   szhFecEmision       [15]; /* EXEC SQL VAR szhFecEmision      IS STRING(15); */ 

         long   lhCodRetorno            ;
         char   szhMensRetorno     [100]; /* EXEC SQL VAR szhFecHastaDcto    IS STRING(15); */ 

         double dhNumEvento             ;
/* P-MIX-09003 */         
         char   szhCodPlanTarif    [3+1]; /* EXEC SQL VAR szhCodPlanTarif    IS STRING (3+1); */ 

	 char   szhFechaHabilAux  [14+1]; /* EXEC SQL VAR szhFechaHabilAux   IS STRING (14+1); */ 

	 char   szhFechaHabil     [14+1]; /* EXEC SQL VAR szhFechaHabil      IS STRING (14+1); */ 
	 
	 char   szhFechaInput     [14+1]; /* EXEC SQL VAR szhFechaInput      IS STRING (14+1); */ 

	 char   szhDiaInput        [2+1]; /* EXEC SQL VAR szhDiaInput        IS STRING (2+1); */ 

	 char   szhCantMesesRestar [1+1]; /* EXEC SQL VAR szhCantMesesRestar IS STRING (1+1); */ 

         char   szhFecUltFact     [14+1]; /* EXEC SQL VAR szhFecUltFact      IS STRING(14+1); */ 

         double dhImporteOverride       ; /* P-MIX-09003 XX */
         char   szhCodMoneda       [3+1]; /* EXEC SQL VAR szhCodMoneda       IS STRING(3+1); */ 
 /* P-MIX-09003 XX */
         double dhImpPeriodo            ;
         double dhImpPeriodoAux         ;         
    /* EXEC SQL END DECLARE SECTION; */ 
    
    
    memset(szhFechaHabil,'\0',sizeof(szhFechaHabil));
    memset(szhFechaHabilAux,'\0',sizeof(szhFechaHabilAux));  
    memset(szhFechaInput,'\0',sizeof(szhFechaInput));
    memset(szhDiaInput,'\0',sizeof(szhDiaInput));  
    memset(szhCantMesesRestar,'\0',sizeof(szhCantMesesRestar));         
    memset(szhFecUltFact,'\0',sizeof(szhFecUltFact));    

    int             i       = 0  ;  
    PLANTARIF       stPlanTarif  ;
    CARGOSBASICO    stCargoBasico;

    if (!bfnCargaCargoBasico (pstAbo,szFecDesde,szFecHasta, iBloqueo, iTipoFact))
    {
        return FALSE;
    }

    for(i=0;i<pstAbo->iNumCBasicos; i++)
    {
        if (i > 0 &&
            strcmp(pstAbo->pstCBasico[i-1].szTipPlanTarif, pstAbo->pstCBasico[i].szTipPlanTarif) != 0)
        {
            iDError (szExeName,ERR056,vInsertarIncidencia);
            return  (FALSE)                               ;
        }
        if (pstAbo->iIndBloqueo == iDESBLOQUEO)
        {
            pstAbo->iIndBloqueo = iBLOQUEO_NORMAL;  /* Si no esta suspendido se levanta el bloqueo */
        }

        vDTrazasLog (szExeName,"\n\t* Indicador de Bloqueo [%d]\n",LOG06, pstAbo->iIndBloqueo);
        /********************************************************************/
        /*  El Importe del Cargo Basico sera 0, en los siguientes casos:    */
        /*     1. IndCuentaControlada  <> 0 y <> 1                          */
        /*     2. IndBloqueo = DesBloqueo or Bloqueo_Normal                 */
        /*     3. TipPlanTarif = 'H' or 'E' && pstAbo->lNumAbonado > 0      */
        /********************************************************************/

        ihIndActuac_CicloAnt = 0;
        
        lhNumAbonado = pstAbo->lNumAbonado;        
        
        vDTrazasLog (szExeName, "\n\t* pstAbo->iIndActuacOld [%d]"
                                "\n\t* pstAbo->lNumAbonado   [%ld]\n"
                              , LOG06
                              , pstAbo->iIndActuacOld
                              , pstAbo->lNumAbonado);
        
        
        if(pstAbo->iIndActuacOld == 2 || pstAbo->iIndActuacOld == 3)
        {
                lhCodCliente  = stCliente.lCodCliente;
                lhCodCiclFact = stCiclo.lCodCiclFact  ;
		ihpSeis	      = 6;
				
                /* EXEC SQL SELECT IND_ACTUAC
                         INTO   :lhIndActEspec
                         FROM   GA_INFACCEL
                         WHERE  COD_CLIENTE = :lhCodCliente
                           AND  NUM_ABONADO = :lhNumAbonado
                           AND  COD_CICLFACT= :lhCodCiclFact
                           AND  IND_ACTUAC  = :ihpSeis; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 30;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select IND_ACTUAC into :b0  from GA_INFACCEL \
where (((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CICLFACT=:b3) and IND_AC\
TUAC=:b4)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )878;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhIndActEspec;
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
                sqlstm.sqhstv[4] = (unsigned char  *)&ihpSeis;
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



                if (SQLCODE) {
                    lhIndActEspec = 0;
                   }

                if (lhCodCiclFact <= 99999) 
                {
                    /* EXEC SQL
                    SELECT IND_ACTUAC
                    INTO :ihIndActuac_CicloAnt
                    FROM    GA_INFACCEL
                    WHERE   COD_CLIENTE = :lhCodCliente
                    AND     NUM_ABONADO = :lhNumAbonado
                    AND     COD_CICLFACT= to_number(to_char(add_months(to_date('0' || to_char(:lhCodCiclFact),'DDMMYY'),-1),'DDMMYY')); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 30;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select IND_ACTUAC into :b0  from GA_INFAC\
CEL where ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CICLFACT=to_number(to\
_char(add_months(to_date(('0'||to_char(:b3)),'DDMMYY'),(-1)),'DDMMYY')))";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )913;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndActuac_CicloAnt;
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
                    sqlstm.sqphsv = sqlstm.sqhstv;
                    sqlstm.sqphsl = sqlstm.sqhstl;
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
                    SELECT IND_ACTUAC
                    INTO :ihIndActuac_CicloAnt
                    FROM    GA_INFACCEL
                    WHERE   COD_CLIENTE = :lhCodCliente
                    AND     NUM_ABONADO = :lhNumAbonado
                    AND     COD_CICLFACT= to_number(to_char(add_months(to_date(to_char(:lhCodCiclFact),'DDMMYY'),-1),'DDMMYY')); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 30;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select IND_ACTUAC into :b0  from GA_INFAC\
CEL where ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CICLFACT=to_number(to\
_char(add_months(to_date(to_char(:b3),'DDMMYY'),(-1)),'DDMMYY')))";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )944;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndActuac_CicloAnt;
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
                    sqlstm.sqphsv = sqlstm.sqhstv;
                    sqlstm.sqphsl = sqlstm.sqhstl;
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
                    ihIndActuac_CicloAnt=0;
                }

                vDTrazasLog (szExeName,"\t\t* Obtencion de IndActuac Ciclo Anterior"
                                       "\n\t\t=> COD_CLIENTE          [%ld]"
                                       "\n\t\t=> NUM_ABONADO          [%ld]"
                                       "\n\t\t=> COD_CICLFACT         [%ld]"
                                       "\n\t\t=> IND_CUENCONTROLADA   [%d]"
                                       "\n\t\t=> IND_ACTUAC           [%d]"
                                       "\n\t\t=> IND_ACTUAC CICLO ANT [%d]"
                                        ,LOG03, lhCodCliente, lhNumAbonado, lhCodCiclFact
                                        ,pstAbo->iIndCuenControlada, pstAbo->iIndActuacOld, ihIndActuac_CicloAnt
                            );
        }

        if ((!strcmp(pstAbo->pstCBasico[i].szTipPlanTarif,szINDIVIDUAL) || pstAbo->lNumAbonado == 0) &&
             (pstAbo->iIndBloqueo == iBLOQUEO_NORMAL) &&
             ((pstAbo->iIndCuenControlada  == 0 || (pstAbo->iIndCuenControlada == 1 && pstAbo->iIndActuacOld != 2 && pstAbo->iIndActuacOld != 3)) ||
             (lhIndActEspec == 6 && ihIndActuac_CicloAnt == 2) ||
             (pstAbo->iIndCuenControlada == 1 && ((pstAbo->iIndActuacOld == 2 || pstAbo->iIndActuacOld == 3) &&
                                                  (ihIndActuac_CicloAnt == 0  || ihIndActuac_CicloAnt == 1) ) ) ) )
        {
            vDTrazasLog (szExeName, "\t\t* Obtencion del Importe del Cargo Basico"
            						"\n\t\t=> Cod.Producto      [%d]"
                                    "\n\t\t=> Cod.CargoBasico   [%s]"
                                    "\n\t\t=> Fec.Desde Abonado [%s]"
                                    "\n\t\t=> Fec.Hasta Abonado [%s]"
                                    "\n\t\t=> Fec.Desde CF      [%s]"
                                    "\n\t\t=> Fec.Hasta CF      [%s]"
                                    "\n\t\t=> Fec.Emision       [%s]"
                                    "\n\t\t=> NUM_CARGOSBASICO  [%d]"       ,
                                    LOG04                                   ,
                                    pstAbo->iCodProducto                    ,
                                    pstAbo->pstCBasico[i].szCodCargoBasico  ,
                                    pstAbo->pstCBasico[i].szFecDesde        ,
                                    pstAbo->pstCBasico[i].szFecHasta        ,
                                    szFecDesde                              ,
                                    szFecHasta                              ,
                                    stCiclo.szFecEmision                    ,
                                    NUM_CARGOSBASICO);

            if(pstAbo->iIndActuacOld == 2 || pstAbo->iIndActuacOld == 3)
            {
                vDTrazasLog (szExeName,"\t\t* Cliente con Plan Total dado de Baja Prorrateado\n", LOG04);
            }

            if (iTipoFact == FACT_CICLO)
            {
                memset (&stPlanTarif,0,sizeof(PLANTARIF));
                if ( bFindPlanTarif (pstAbo->iCodProducto ,
                            pstAbo->szCodPlanTarif,
                            &stPlanTarif) )
                {                   	
                    
                     /* iFlgRango Indica que el plan tarifario sea por rangos */
                     if ( stPlanTarif.iFlgRango == 1 )
                     {
                          lhCodCliente = stCliente.lCodCliente;
                          strcpy(szhFecEmision,stCiclo.szFecEmision);

                          /* Se obtiene el descuento al cargo basico asociado al cliente */
                          /* EXEC SQL EXECUTE
                            BEGIN
                              FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR( :lhCodCliente,
                                                                                to_date(:szhFecEmision,:szpFormatoFec),
                                                                                :szhCodPlantarif,
                                                                                :dhImpDescuento,
                                                                                :szhFecDesdeDcto ,
                                                                                :szhFecHastaDcto,
                                                                                :lhCodRetorno,
                                                                                :szhMensRetorno,
                                                                                :dhNumEvento);
                            END;
                          END-EXEC; */ 

{
                          struct sqlexd sqlstm;
                          sqlstm.sqlvsn = 12;
                          sqlstm.arrsiz = 30;
                          sqlstm.sqladtp = &sqladt;
                          sqlstm.sqltdsp = &sqltds;
                          sqlstm.stmt = "begin FA_DCTO_CLTE_SN_PG . FA_CONS_\
DCTO_CLTE_BLSDINAM_PR ( :lhCodCliente , to_date ( :szhFecEmision , :szpFormato\
Fec ) , :szhCodPlantarif , :dhImpDescuento , :szhFecDesdeDcto , :szhFecHastaDc\
to , :lhCodRetorno , :szhMensRetorno , :dhNumEvento ) ; END ;";
                          sqlstm.iters = (unsigned int  )1;
                          sqlstm.offset = (unsigned int  )975;
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
                          sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmision;
                          sqlstm.sqhstl[1] = (unsigned long )15;
                          sqlstm.sqhsts[1] = (         int  )0;
                          sqlstm.sqindv[1] = (         short *)0;
                          sqlstm.sqinds[1] = (         int  )0;
                          sqlstm.sqharm[1] = (unsigned long )0;
                          sqlstm.sqadto[1] = (unsigned short )0;
                          sqlstm.sqtdso[1] = (unsigned short )0;
                          sqlstm.sqhstv[2] = (unsigned char  *)szpFormatoFec;
                          sqlstm.sqhstl[2] = (unsigned long )17;
                          sqlstm.sqhsts[2] = (         int  )0;
                          sqlstm.sqindv[2] = (         short *)0;
                          sqlstm.sqinds[2] = (         int  )0;
                          sqlstm.sqharm[2] = (unsigned long )0;
                          sqlstm.sqadto[2] = (unsigned short )0;
                          sqlstm.sqtdso[2] = (unsigned short )0;
                          sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlantarif;
                          sqlstm.sqhstl[3] = (unsigned long )4;
                          sqlstm.sqhsts[3] = (         int  )0;
                          sqlstm.sqindv[3] = (         short *)0;
                          sqlstm.sqinds[3] = (         int  )0;
                          sqlstm.sqharm[3] = (unsigned long )0;
                          sqlstm.sqadto[3] = (unsigned short )0;
                          sqlstm.sqtdso[3] = (unsigned short )0;
                          sqlstm.sqhstv[4] = (unsigned char  *)&dhImpDescuento;
                          sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
                          sqlstm.sqhsts[4] = (         int  )0;
                          sqlstm.sqindv[4] = (         short *)0;
                          sqlstm.sqinds[4] = (         int  )0;
                          sqlstm.sqharm[4] = (unsigned long )0;
                          sqlstm.sqadto[4] = (unsigned short )0;
                          sqlstm.sqtdso[4] = (unsigned short )0;
                          sqlstm.sqhstv[5] = (unsigned char  *)szhFecDesdeDcto;
                          sqlstm.sqhstl[5] = (unsigned long )15;
                          sqlstm.sqhsts[5] = (         int  )0;
                          sqlstm.sqindv[5] = (         short *)0;
                          sqlstm.sqinds[5] = (         int  )0;
                          sqlstm.sqharm[5] = (unsigned long )0;
                          sqlstm.sqadto[5] = (unsigned short )0;
                          sqlstm.sqtdso[5] = (unsigned short )0;
                          sqlstm.sqhstv[6] = (unsigned char  *)szhFecHastaDcto;
                          sqlstm.sqhstl[6] = (unsigned long )15;
                          sqlstm.sqhsts[6] = (         int  )0;
                          sqlstm.sqindv[6] = (         short *)0;
                          sqlstm.sqinds[6] = (         int  )0;
                          sqlstm.sqharm[6] = (unsigned long )0;
                          sqlstm.sqadto[6] = (unsigned short )0;
                          sqlstm.sqtdso[6] = (unsigned short )0;
                          sqlstm.sqhstv[7] = (unsigned char  *)&lhCodRetorno;
                          sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
                          sqlstm.sqhsts[7] = (         int  )0;
                          sqlstm.sqindv[7] = (         short *)0;
                          sqlstm.sqinds[7] = (         int  )0;
                          sqlstm.sqharm[7] = (unsigned long )0;
                          sqlstm.sqadto[7] = (unsigned short )0;
                          sqlstm.sqtdso[7] = (unsigned short )0;
                          sqlstm.sqhstv[8] = (unsigned char  *)szhMensRetorno;
                          sqlstm.sqhstl[8] = (unsigned long )100;
                          sqlstm.sqhsts[8] = (         int  )0;
                          sqlstm.sqindv[8] = (         short *)0;
                          sqlstm.sqinds[8] = (         int  )0;
                          sqlstm.sqharm[8] = (unsigned long )0;
                          sqlstm.sqadto[8] = (unsigned short )0;
                          sqlstm.sqtdso[8] = (unsigned short )0;
                          sqlstm.sqhstv[9] = (unsigned char  *)&dhNumEvento;
                          sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
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


                          vDTrazasLog (szExeName, "\n\t\t** Retorno Funcion FA_DCTO_CLTE_SN_PG.FA_CONS_DCTO_CLTE_BLSDINAM_PR "
                                                  "\n\t\t   lhCodRetorno[%ld]"
                                                  "\n\t\t   szhMensRetorno[%s]"
                                                , LOG06,lhCodRetorno,szhMensRetorno);
                          if ( lhCodRetorno != 0 )
                          {
                               if ( lhCodRetorno == 1162 ) /* no existe vigencia para esa fecha */
                               {
                                    vDTrazasLog (szExeName, "\n\t\t**No existe descuento a plan tarifario por rangos "
                                                          , LOG04);
                                    dhImpDescuento = 0.0;
                               }
                               else
                               {
                                    return FALSE;
                               }
                          }
                          vDTrazasLog (szExeName, "\n\t\t**descuento a plan tarifario por rangos [%f]"
                                                , LOG05, dhImpDescuento);
                     }
                }
                /* P-MIX-09003 XX */
                dhImporteOverride = 0.0;
                memset (&stCargoBasico,0,sizeof(CARGOSBASICO));               
                memset (szhCodMoneda,'\0',sizeof(szhCodMoneda)); 

                if ( !bFindCargoBasico(pstAbo->pstCBasico[i].szCodCargoBasico, &stCargoBasico))
                {
                     iDError (szExeName,ERR017,vInsertarIncidencia,"Cargo Basico",pstAbo->lNumAbonado);
                }
                else
                {
                     pstAbo->pstCBasico[i].dImpPeriodo= stCargoBasico.dImpCargoBasico;
                     
                     if ( dhImpDescuento > 0.0 )
                     {
                          pstAbo->pstCBasico[i].dImpPeriodo = pstAbo->pstCBasico[i].dImpPeriodo - dhImpDescuento;
                     }
                          
                     if ( pstAbo->pstCBasico[i].dImpPeriodo < 0.0 )
                     {
                          pstAbo->pstCBasico[i].dImpPeriodo = 0.0;
                     }                                                 
                     
                }                

                strcpy( szhFechaHabil, stCiclo.szFecEmision);
                
                if ( !bFindOverrideCB (stCliente.lCodCliente,
                                       lhNumAbonado,
                                       pstAbo->pstCBasico[i].szCodCargoBasico,
                                       &dhImporteOverride))
                {
                     vDTrazasLog (szExeName, "\n\t\t* NO Encontro Override para Cargo Basico %s"
                                           , LOG05,pstAbo->pstCBasico[i].szCodCargoBasico);
                                           
                     dhImpPeriodo    = pstAbo->pstCBasico[i].dImpPeriodo; /* P-MIX-09003 134206 */
                     dhImpPeriodoAux = pstAbo->pstCBasico[i].dImpPeriodo; /* P-MIX-09003 134206 */                                           
                                                                 
                     if ( !bConversionMoneda ( stCliente.lCodCliente,
                                               stCargoBasico.szCodMoneda,
                                               stDatosGener.szCodMoneFact,
                                               szhFechaHabil,
                                               &pstAbo->pstCBasico[i].dImpPeriodo))
                     {
                          return FALSE;
                     } /* P-MIX-09003 4 */                     
         
                     if ( pstAbo->pstCBasico[i].dImpPeriodo == 0 )
                     {
                          pstAbo->pstCBasico[i].dImpMontoBase = 0;
                     }
                     else
                     {
                          if ( dhImpPeriodoAux != pstAbo->pstCBasico[i].dImpPeriodo )
                          { 
                               pstAbo->pstCBasico[i].dImpMontoBase = fnCnvDouble(pstAbo->pstCBasico[i].dImpPeriodo, 0) / 
                                                                fnCnvDouble(dhImpPeriodoAux, 0);
                          }
                          else
                          {
               	               pstAbo->pstCBasico[i].dImpMontoBase = 0;
                          }
                     } /* P-MIX-09003 134206 */
                          
                     vDTrazasLog (szExeName, "\n\t\t** Importe Cargo Basico [%f] **"
                                             "\n\t\t\t Moneda              [%s]"
                                             "\n\t\t\t Fecha               [%s]"
                                             "\n\t\t\t Valor Convertido    [%f]"
                                             "\n\t\t\t Monto Base          [%f]"
                                           , LOG04
                                           , stCargoBasico.dImpCargoBasico
                                           , stCargoBasico.szCodMoneda
                                           , stCiclo.szFecDesdeCFijos
                                           , pstAbo->pstCBasico[i].dImpPeriodo
                                           , pstAbo->pstCBasico[i].dImpMontoBase);
                }
                else
                {
                                          
                    pstAbo->pstCBasico[i].dImpPeriodo = dhImporteOverride;
                    
                    dhImpPeriodo    = pstAbo->pstCBasico[i].dImpPeriodo; /* P-MIX-09003 134206 */
                    dhImpPeriodoAux = pstAbo->pstCBasico[i].dImpPeriodo; /* P-MIX-09003 134206 */                    
                    
                    vDTrazasLog (szExeName, "\n\t\t* Se Encontro Override para Cargo Basico [%s] [%f] "
                                          , LOG05
                                          , pstAbo->pstCBasico[i].szCodCargoBasico
                                          , pstAbo->pstCBasico[i].dImpPeriodo);                    
                    
                    if ( dhImpDescuento > 0.0 )
                    {
                         pstAbo->pstCBasico[i].dImpPeriodo = pstAbo->pstCBasico[i].dImpPeriodo - dhImpDescuento;
                    } 
                    
                    if ( pstAbo->pstCBasico[i].dImpPeriodo < 0.0 )
                    {
                         pstAbo->pstCBasico[i].dImpPeriodo = 0.0;
                    }                 
                     
                    if ( !bConversionMoneda (stCliente.lCodCliente,
                                             stCargoBasico.szCodMoneda,
                                             stDatosGener.szCodMoneFact,
                                             szhFechaHabil,
                                             &pstAbo->pstCBasico[i].dImpPeriodo))
                    {
                         return FALSE;
                    } /* P-MIX-09003 4 */  
                    
                    if ( pstAbo->pstCBasico[i].dImpPeriodo == 0 )
                    {
                         pstAbo->pstCBasico[i].dImpMontoBase = 0;
                    }
                    else
                    {
                         if ( dhImpPeriodoAux != pstAbo->pstCBasico[i].dImpPeriodo )
                         { 
                              pstAbo->pstCBasico[i].dImpMontoBase = fnCnvDouble(pstAbo->pstCBasico[i].dImpPeriodo, 0) / 
                                                                fnCnvDouble(dhImpPeriodoAux, 0);
                         }
                         else
                         {
               	              pstAbo->pstCBasico[i].dImpMontoBase = 0;                    
                         }
                    } /* P-MIX-09003 134206 */                    
                    
                    
                    vDTrazasLog (szExeName, "\n\t\t** Importe Cargo Basico [%f] **"
                                            "\n\t\t\t Moneda              [%s]"
                                            "\n\t\t\t Fecha               [%s]"
                                            "\n\t\t\t Valor Convertido    [%f]"
                                            "\n\t\t\t Monto Base          [%f]"                                            
                                          , LOG04
                                          , stCargoBasico.dImpCargoBasico
                                          , stCargoBasico.szCodMoneda
                                          , stCiclo.szFecDesdeCFijos
                                          , pstAbo->pstCBasico[i].dImpPeriodo
                                          , pstAbo->pstCBasico[i].dImpMontoBase);
                }                
                /* P-MIX-09003 XX */

                  memset(szhCodPlanTarif,'\0',sizeof(szhCodPlanTarif));

                  strcpy(szhCodPlanTarif, pstAbo->szCodPlanTarif);
 
                  vDTrazasLog(szExeName, "\n\t** Cargo Basico MIX-09003 **"
                                         "\n\t****************************"
                                         "\n\t\t  stCliente.lCodCliente       => [%ld]"
                                         "\n\t\t  lhNumAbonado                => [%ld]"
                                         "\n\t\t  stPlanTarif.szIndCompartido => [%s]"
                                         "\n\t\t  pstAbo->szCodPlanTarif      => [%s]"                                                                              
                                       , LOG05
                                       , stCliente.lCodCliente
                                       , lhNumAbonado
                                       , stPlanTarif.szIndCompartido
                                       , szhCodPlanTarif);
                                       
                  if (strcmp(stPlanTarif.szIndCompartido,"1") == 0)
                  {
                      /* Verificar si plan fue procesado */
                      if ( bfnFindArrayPlanTarif(szhCodPlanTarif) )
                      {
                      	  vDTrazasLog (szExeName, "\n\t** Plan Tarifario [%s] procesado **"
                      	                        , LOG06
                      	                        , szhCodPlanTarif);
                      	  pstAbo->pstCBasico[i].dImpPeriodo = 0.0;
                      }
                      else
                      {
                      	  strcpy(szPlanTarifarioArray[ijPtc],szhCodPlanTarif);
                      	  vDTrazasLog (szExeName, "\n\t** Plan Tarifario [%s] ingresado Arreglo **"
                      	                          "\n\t** INDICE [%d] **"
                      	                        , LOG06
                      	                        , szhCodPlanTarif
                      	                        , ijPtc);                      	  
                      	  ijPtc++;
                      }                      
                  }
/* P-MIX-09003 */            
            }
            
        }
        else
        {
            vDTrazasLog (szExeName,"\t* dImpPeriodo igual a cero \n",LOG06);
            pstAbo->pstCBasico[i].dImpPeriodo = 0.0 ;
        }
    }/* fin for ... */
    /*************************************************/
    /* Todos tendran el mismo Tipo de Plan Tarifario */
    /* el mismo Grupo de Servicios, y el mismo Plan  */
    /* comercial.                                    */
    /*************************************************/
    if (pstAbo->iNumCBasicos > 0)
    {
        strcpy (pstAbo->szCodGrpServ  , pstAbo->pstCBasico[0].szCodGrpServ  );
        strcpy (pstAbo->szTipPlanTarif, pstAbo->pstCBasico[0].szTipPlanTarif);

        pstAbo->lCodPlanCom = pstAbo->pstCBasico [0].lCodPlanCom;
    }
    else
    {
        /************************************************************************/
        /*   Fuerza a que el registro de Tipo de Plan Tarifario sea Indivdual   */
        /*   para que considere la rutina de Facturacion de Cargos en           */
        /*   bCargaAbonosCelular.                                               */
        /************************************************************************/
        strcpy (pstAbo->szTipPlanTarif, "I\0");
    }

    strcpy(szhFecUltFact,szFecUltFact);

    if (!bfnTrataCBasico (pstAbo, szhFecUltFact))
    {
        return FALSE;
    }

    return TRUE;
}/************************** Final bfnObtImpCargoBasico **********************/

/*****************************************************************************/
/*                          funcion : vfnPrintCBasico                        */
/*****************************************************************************/
BOOL bfnFindArrayPlanTarif (char *szCodPlanTarif)
{
    int        j = 0    ;
    BOOL bExiste = FALSE; 
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char   szhCodPlanTarif  [4]; /* EXEC SQL VAR szhCodPlanTarif IS STRING(4); */ 
 /* P-MIX-09003 */         
    /* EXEC SQL END DECLARE SECTION; */ 
	
	
    memset(szhCodPlanTarif,'\0',sizeof(szhCodPlanTarif));
    strcpy(szhCodPlanTarif,szCodPlanTarif);
       
    while (strcmp(szPlanTarifarioArray[j],"") != 0)
    {
    	vDTrazasLog (szExeName, "\n\t* Buscando Plan Tarifario procesado [%s]"
    	                        "\n\t* Buscando Plan Tarifario arreglo   [%s]"
    	                        "\n\t* INDICE                            [%d]"
    	                      , LOG06
    	                      , szhCodPlanTarif
    	                      , szPlanTarifarioArray[j]
    	                      , j);
    	if ( strcmp(szPlanTarifarioArray[j],szhCodPlanTarif)==0)
    	{
    	     bExiste = TRUE;
             vDTrazasLog (szExeName, "\n\t* Plan Tarifario encontrado [%s]"
                                   , LOG06
                                   , szPlanTarifarioArray[j]);
    	     break;
    	}
        j++;
        vDTrazasLog (szExeName, "\n\t* Plan Tarifario NO encontrado [%s], sigo buscando ...[%d]"
                              , LOG06
                              , szhCodPlanTarif
                              , j);    	
    }   

    return (bExiste);
}

/*****************************************************************************/
/*                          funcion : vfnPrintCBasico                        */
/*****************************************************************************/
static void vfnPrintCBasico (void)
{
    register int i = 0, j = 0;

    if (stStatus.LogNivel >= LOG05)
    {
        for (j=0;j<stCliente.iNumAbonos;j++)
        {
            vDTrazasLog (szExeName, "\n\t\t* Cargo Basicos del Abonado [%ld]", LOG05,
                                    stCliente.pAbonos[j].lNumAbonado);

            for (i=0;i<stCliente.pAbonos [j].iNumCBasicos;i++)
            {
                vDTrazasLog (szExeName,  "\n\t\t[%d] - Cod.CBasico     [%d] Descripcion [%s]"
                                         "\n\t\t[%d] - Imp.Periodo     [%f]"
                                         "\n\t\t[%d] - Cod.CBasico Fin [%d]"
                                         "\n\t\t[%d] - Des.CBasico Fin [%s]"
                                         "\n\t\t[%d] - Imp.FinContrato [%f]"
                                         "\n\t\t[%d] - Imp.Concepto    [%f]"
                                         "\n\t\t[%d] - Num.Dias CBasico[%d]"
                                         "\n\t\t[%d] - Num.Dias Fin    [%d]"
                                         "\n\t\t[%d] - Tip.PlanTarif   [%s]"
                                         "\n\t\t[%d] - Cod.PlanTarif   [%s]"
                                         "\n\t\t[%d] - Cod.CargoBasico [%s]", LOG05,
                                         i, stCliente.pAbonos[j].pstCBasico [i].iCodAbono      ,
                                            stCliente.pAbonos[j].pstCBasico [i].szDesAbono     ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].dImpPeriodo    ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].iCodAbonoFin   ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].szDesAbonoFin  ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].dImpFinContrato,
                                         i, stCliente.pAbonos[j].pstCBasico [i].dImpConcepto   ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].iNumDiasAbono  ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].iNumDiasFin    ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].szTipPlanTarif ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].szCodPlanTarif ,
                                         i, stCliente.pAbonos[j].pstCBasico [i].szCodCargoBasico);
            }
        }
    }
}/************************** Final vfnPrintCBasico ***************************/

/*****************************************************************************/
/*                          funcion : dfnDBGetMinConFree                     */
/*****************************************************************************/
static double dfnDBGetMinConFree (long  lCodCliente   ,
                                  long  lNumAbonado   ,
                                  int   iCodProducto  ,
                                  long  lCodCiclFact  ,
                                  long  lCodGrupo     ,
                                  char *szTipPlanTarif,
                                  char *szCodPlanTarif)
{
    static char szCaso [25] = ""   ;
    static BOOL bEnc        = FALSE;

    static double dhSegGratuitos = 0.0;

    ihpZero = 0;
    vDTrazasLog (szExeName, "\n\t\t* Minutos Consumidos Libres"
                            "\n\t\t=> Cod.Cliente [%ld]"
                            "\n\t\t=> Num.Abonado [%ld]"
                            "\n\t\t=> Cod.Producto[%d] "
                            "\n\t\t=> Cod.CiclFact[%ld]"
                            "\n\t\t=> Cod.Grupo   [%ld]"
                            "\n\t\t=> Tip.PlanTar.[%s] "
                            "\n\t\t=> Cod.PlanTar.[%s] ", LOG05,
                            lCodCliente , lNumAbonado, iCodProducto  ,
                            lCodCiclFact, lCodGrupo  , szTipPlanTarif,
                            szCodPlanTarif);

    if (iCodProducto != stDatosGener.iProdCelular )
    {
        vDTrazasError (szExeName,"\n\t\t=> Cod.Producto [%d] Incorrecto", LOG03,iCodProducto);
           return -1                   ;
    }

    if (!strcmp  (szTipPlanTarif, szINDIVIDUAL))
    {
        bEnc = TRUE;
        if (stCiclo.iInd_Tasacion != TIPO_TASA_ON_LINE)
        {
            strcpy (szCaso,"Select=> Ta_AcumAire");

            /* EXEC SQL
                SELECT  NVL(SEG_GRATUITOS,:ihpZero)
                  INTO  :dhSegGratuitos
                  FROM  TA_ACUMAIRE
                 WHERE  NUM_ABONADO  = :lNumAbonado
                   AND  COD_CICLFACT = :lCodCiclFact
                   AND  COD_PLANTARIF= :szCodPlanTarif
                   AND  COD_CLIENTE  = :lCodCliente; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select NVL(SEG_GRATUITOS,:b0) into :b1  from TA_A\
CUMAIRE where (((NUM_ABONADO=:b2 and COD_CICLFACT=:b3) and COD_PLANTARIF=:b4) \
and COD_CLIENTE=:b5)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1030;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihpZero;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&dhSegGratuitos;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lNumAbonado;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lCodCiclFact;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szCodPlanTarif;
            sqlstm.sqhstl[4] = (unsigned long )0;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&lCodCliente;
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
        else
        {
            strcpy (szCaso,"Select=> Tol_Acumoper");

            /* EXEC SQL
                SELECT  NVL(SUM(DUR_DCTO),:ihpZero)
                  INTO  :dhSegGratuitos
                  FROM  TOL_ACUMOPER_TO
                 WHERE  NUM_ABONADO  = :lNumAbonado
                   AND  COD_CICLFACT = :lCodCiclFact
                   AND  COD_PLAN     = :szCodPlanTarif
                   AND  COD_CLIENTE  = :lCodCliente
                   AND  TIP_DCTO     = 'ML'
                   AND  COD_GRUPO    = :ihpZero; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select NVL(sum(DUR_DCTO),:b0) into :b1  from TOL_\
ACUMOPER_TO where (((((NUM_ABONADO=:b2 and COD_CICLFACT=:b3) and COD_PLAN=:b4)\
 and COD_CLIENTE=:b5) and TIP_DCTO='ML') and COD_GRUPO=:b0)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1069;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihpZero;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&dhSegGratuitos;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lNumAbonado;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lCodCiclFact;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szCodPlanTarif;
            sqlstm.sqhstl[4] = (unsigned long )0;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&lCodCliente;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&ihpZero;
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
    }
    else if((strcmp(szTipPlanTarif, szEMPRESA) == 0) && (lNumAbonado != 0))
    {
        vDTrazasLog(szExeName,  "\n\t\t*  Cliente Empresa (Abonado distinto de 0): "
                                "\n\t\t=> Cod. Empresa  [%ld]"
                                "\n\t\t=> Cod. CiclFact [%ld]"
                                "\n\t\t=> Cod. PlanTarif [%s]", LOG05,
                                lCodGrupo, lCodCiclFact, szCodPlanTarif);
        bEnc = TRUE;
        return(0.0);
    }
    else if((strcmp(szTipPlanTarif, szEMPRESA) == 0) && (lNumAbonado == 0))
    {
        vDTrazasLog(szExeName,  "\n\t\t*  Cliente Empresa: "
                                "\n\t\t=> Cod. Empresa  [%ld]"
                                "\n\t\t=> Cod. CiclFact [%ld]"
                                "\n\t\t=> Cod. PlanTarif [%s]", LOG05,
                                lCodGrupo, lCodCiclFact, szCodPlanTarif);
        bEnc = TRUE;

        if (stCiclo.iInd_Tasacion != TIPO_TASA_ON_LINE)
        {
            strcpy(szCaso,"Select => Ta_AcumAireEmp");

            /* EXEC SQL
                SELECT  NVL(SEG_CONSUMIDO, :ihpZero)
                  INTO  :dhSegGratuitos
                  FROM  TA_ACUMAIREEMP
                 WHERE  COD_EMPRESA   = :lCodGrupo
                   AND  COD_CICLFACT  = :lCodCiclFact
                   AND  COD_PLANTARIF = :szCodPlanTarif; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select NVL(SEG_CONSUMIDO,:b0) into :b1  from TA_A\
CUMAIREEMP where ((COD_EMPRESA=:b2 and COD_CICLFACT=:b3) and COD_PLANTARIF=:b4\
)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1112;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihpZero;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&dhSegGratuitos;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lCodGrupo;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lCodCiclFact;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szCodPlanTarif;
            sqlstm.sqhstl[4] = (unsigned long )0;
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
            strcpy (szCaso,"Select=> Tol_Acumoper");

            /* EXEC SQL
                SELECT  NVL(CNT_INICIAL, :ihpZero)
                  INTO  :dhSegGratuitos
                  FROM  TOL_ACUMOPER_TO
                 WHERE  COD_CICLFACT = :lCodCiclFact
                   AND  COD_PLAN     = :szCodPlanTarif
                   AND  TIP_DCTO     = 'ML'
                   AND  COD_GRUPO    = :lCodGrupo; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select NVL(CNT_INICIAL,:b0) into :b1  from TOL_AC\
UMOPER_TO where (((COD_CICLFACT=:b2 and COD_PLAN=:b3) and TIP_DCTO='ML') and C\
OD_GRUPO=:b4)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1147;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihpZero;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&dhSegGratuitos;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lCodCiclFact;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szCodPlanTarif;
            sqlstm.sqhstl[3] = (unsigned long )0;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&lCodGrupo;
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

    }
    else if (!strcmp (szTipPlanTarif, szHOLDING))
    {
        bEnc = TRUE;

        strcpy (szCaso,"Select=> Ta_AcumAireHold");

        /* EXEC SQL
            SELECT /o+ index(TA_ACUMAIREHOLD PK_TA_ACUMAIREHOLD) o/
                    NVL(SEG_CONSUMIDO, :ihpZero)
              INTO  :dhSegGratuitos
              FROM  TA_ACUMAIREHOLD
             WHERE  COD_HOLDING  = :lCodGrupo
               AND  COD_CICLFACT = :lCodCiclFact
               AND  COD_PLANTARIF= :szCodPlanTarif; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select  /*+  index(TA_ACUMAIREHOLD PK_TA_ACUMAIREHOLD\
)  +*/ NVL(SEG_CONSUMIDO,:b0) into :b1  from TA_ACUMAIREHOLD where ((COD_HOLDI\
NG=:b2 and COD_CICLFACT=:b3) and COD_PLANTARIF=:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1182;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihpZero;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhSegGratuitos;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lCodGrupo;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lCodCiclFact;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szCodPlanTarif;
        sqlstm.sqhstl[4] = (unsigned long )0;
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

    if (!bEnc)
    {
        vDTrazasError (szExeName,"\n\t\t=>Tipo Plan Tarifario[%s] Desconocido",LOG03, szTipPlanTarif);
        return -1                            ;
    }

    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        iDError (szExeName,ERR000,vInsertarIncidencia,szCaso,szfnORAerror ());

    vDTrazasLog(szExeName, "\n\t\t* Segundos libres consumidos: [%d]  - Minutos: [%f]",
                           LOG05, dhSegGratuitos,(double)dhSegGratuitos/60.00);

    return (SQLCODE == SQLOK)?(double)dhSegGratuitos/60.00:(SQLCODE == SQLNOTFOUND)?0:-1;

}/************************* Final dfnDBGetMinConsumidos **********************/

/*****************************************************************************/
/*                         funcion : bfnTrataCBasico                         */
/*****************************************************************************/
static BOOL bfnTrataCBasico (ABONOS *pstAbo, char *szFecUltFact)
{
    register int    i  = 0;
    long   lMinFree    = 0; /* Minutos Libres del Plan   */
    double dMinConFree = 0; /* Minutos Libres Consumidos */

    PASOPRORRATEO stPasoProrrateo;
    GRUPOCOB      stGrupoCobro;
    PLANTARIF     stPlanTarif;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         /* P-MIX-09003 */
         long          lhNumAbonado            ; 
         long          lhCodCicloFact          ;
         long          lhCodConcepto           ;
         long          lhNumProceso            ;
         long          lhNumOcurrencias        ;
         long          lhCodError              ;
         char          szhMsgError     [3000+1]; /* EXEC SQL VAR szhMsgError       IS STRING(3000+1); */ 

         long          lhEvento                ;
         int           ihCantidadMeses         ;                 
         int           ihCantidadRentas        ;         
         char          szhCantidadRentas[512+1]; /* EXEC SQL VAR szhCantidadRentas IS STRING(512+1); */ 

         char          szhFecUltFact     [14+1]; /* EXEC SQL VAR szhFecUltFact     IS STRING(14+1); */ 

         /* P-MIX-09003 */         
    /* EXEC SQL END DECLARE SECTION; */ 

    
    memset(szhFecUltFact,'\0',sizeof(szhFecUltFact));
    strcpy(szhFecUltFact,szFecUltFact);

    vDTrazasLog (szExeName, "\t\t* Trata Cargo Basico [%d]", LOG05, pstAbo->iNumCBasicos);

    if (pstAbo->iNumCBasicos == 1)    /* Tiene solo 1 CB para el periodo */
    {
        vDTrazasLog (szExeName, "\t\t* pstCBasico: [%f]", LOG05, pstAbo->pstCBasico[i].dImpPeriodo);
        strcpy(pstAbo->szFecAlta, pstAbo->pstCBasico[0].szFecDesde);
        strcpy(pstAbo->szFecBaja, pstAbo->pstCBasico[0].szFecHasta);

        memset ( &stGrupoCobro,0,sizeof(GRUPOCOB));

        stGrupoCobro.iCodConcepto = pstAbo->pstCBasico[i].iCodAbono;
        stGrupoCobro.iCodProducto = pstAbo->iCodProducto;
        stGrupoCobro.iCodCiclo    = stCiclo.iCodCiclo;
        strcpy(stGrupoCobro.szCodGrupo,pstAbo->szCodGrpServ);

        if ( !bFindGrupoCob(&stGrupoCobro))
              return FALSE;
            
        memset (&stPlanTarif,0,sizeof(PLANTARIF));
           
        if ( !bFindPlanTarif (pstAbo->iCodProducto ,
                              pstAbo->pstCBasico [0].szCodPlanTarif,
                             &stPlanTarif) )
        {
              return FALSE;
        }            

        memset ( &stPasoProrrateo, 0, sizeof(PASOPRORRATEO));

        strcpy (stPasoProrrateo.szFecInicio,pstAbo->szFecAlta);
        strcpy (stPasoProrrateo.szFecTermino,pstAbo->szFecBaja);
        stPasoProrrateo.dImpServicio  = pstAbo->pstCBasico[i].dImpPeriodo;
        stPasoProrrateo.sIndTipoCobro = stPlanTarif.iTipCobro;           
        stPasoProrrateo.sIndProrrateo = pstAbo->iIndCargoPro;
        stPasoProrrateo.sIndAlta      = pstAbo->iIndAlta ;

        vDTrazasLog (szExeName, "\n\t\t* (bfnTrataCBasico) Ind Alta [%d]", LOG05, stPasoProrrateo.sIndAlta);
        
/***************************************************************/ /* P-MIX-09003 132323 */
        
        vDTrazasLog( szExeName, "\n** (bfnTrataCBasico) Ejecución Package FA_SERVICIOS_FACTURACION_PG **", LOG05);

        lhNumAbonado = pstAbo->lNumAbonado;
        lhCodCicloFact = stCiclo.lCodCiclFact;
        lhCodConcepto = stGrupoCobro.iCodConcepto;
        lhNumProceso = stStatus.IdPro;        
        
        /* EXEC SQL EXECUTE
             BEGIN
                  FA_SERVICIOS_FACTURACION_PG.FA_ConsultaCobroAdelantado_PR
                  ( :lhNumAbonado,
                    :lhCodCicloFact,
                    :lhCodConcepto,
                    :lhNumProceso,
                    :lhNumOcurrencias,
                    :lhCodError,
                    :szhMsgError,
                    :lhEvento);
             END;
        END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin FA_SERVICIOS_FACTURACION_PG . FA_ConsultaCobroA\
delantado_PR ( :lhNumAbonado , :lhCodCicloFact , :lhCodConcepto , :lhNumProces\
o , :lhNumOcurrencias , :lhCodError , :szhMsgError , :lhEvento ) ; END ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1217;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCicloFact;
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhNumOcurrencias;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodError;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhMsgError;
        sqlstm.sqhstl[6] = (unsigned long )3001;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lhEvento;
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

        
        
        vDTrazasLog( szExeName, "\n**  (bfnTrataCBasico) Package FA_SERVICIOS_FACTURACION_PG procdure FA_ConsultaCobroAdelantado_PR() **"
                                "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                "\n\t\t\t=> lhCodConcepto..... [%d]"
                                "\n\t\t\t=> lhNumProceso...... [%ld]"
                                "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                "\n\t\t\t=> lhCodError........ [%ld]"
                                "\n\t\t\t=> szhMsgError....... [%s]"
                                "\n\t\t\t=> lhEvento.......... [%ld]"
                                "\n\t\t\t=> SQLCODE .......... [%d]"                                                              
                              , LOG05
                              , lhNumAbonado
                              , lhCodCicloFact
                              , lhCodConcepto
                              , lhNumProceso
                              , lhNumOcurrencias
                              , lhCodError
                              , szhMsgError
                              , lhEvento
                              , SQLCODE);            
                  
        if ( SQLCODE != SQLOK  || lhCodError != 0)
        {       	
             vDTrazasError( szExeName , "\n**  (bfnTrataCBasico) Error package FA_SERVICIOS_FACTURACION_PG    **"
                                        "\n**  en procedure FA_ConsultaCobroAdelantado_PR() **"
                                        " [%d]  [%s]"
                                      , LOG01,SQLCODE,SQLERRM);                                          
             vDTrazasLog( szExeName, "\n**  (bfnTrataCBasico) Error en procdure FA_ConsultaCobroAdelantado_PR() **"
                                     "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                     "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                     "\n\t\t\t=> lhCodConcepto..... [%d]"
                                     "\n\t\t\t=> lhNumProceso...... [%ld]"
                                     "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                     "\n\t\t\t=> lhCodError........ [%ld]"
                                     "\n\t\t\t=> szhMsgError....... [%s]"
                                     "\n\t\t\t=> lhEvento.......... [%ld]"
                                     "\n\t\t\t=> SQLCODE .......... [%d]"
                                     "\n\t\t\t=> SQLERRM........... [%s]"                                              
                                   , LOG01
                                   , lhNumAbonado
                                   , lhCodCicloFact
                                   , lhCodConcepto
                                   , lhNumProceso
                                   , lhNumOcurrencias
                                   , lhCodError
                                   , szhMsgError
                                   , lhEvento
                                   , SQLCODE
                                   , SQLERRM);                                                       
             return(FALSE);
        }        
        
        if ( lhNumOcurrencias > 0 )
        {
             vDTrazasLog( szExeName, "\n** (bfnTrataCBasico) No aplico Prorrateo a Cargo Básico **", LOG05);
             pstAbo->pstCBasico[i].iNumDiasAbono = stCiclo.iDiaPeriodo;
             pstAbo->pstCBasico[i].dImpConcepto = fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);                	
        }
        else
        {
             vDTrazasLog( szExeName, "\n** (bfnTrataCBasico) Función Prorrateo a Cargo Básico **", LOG05);        	
             if(!bfnProrrateoStandar(&stPasoProrrateo))
             {
                 return FALSE;
             }

             pstAbo->pstCBasico[i].iNumDiasAbono = stPasoProrrateo.sDiasAbono;
             pstAbo->pstCBasico[i].dImpConcepto  = stPasoProrrateo.dImpConcepto;

             vDTrazasLog (szExeName, "\t\t* Importe Cargo Basico Prorrateado [%f]"
                                   , LOG05
                                   , pstAbo->pstCBasico[i].dImpConcepto);
        }        
        
/***************************************************************/ /* P-MIX-09003 132323 */
        
        memset(szhFecUltFact,'\0',sizeof(szhFecUltFact));
        strcpy(szhFecUltFact,szFecUltFact);

        if (!bValidacionAbono (pstAbo->iCodProducto, pstAbo->lNumAbonado , &pstAbo->pstCBasico [i]))
        {
            return FALSE;
        }

        vDTrazasLog (szExeName, "\n\t\t* (bfnTrataCBasico) Fecha Ultima Facturacion [%s] *", LOG05,szhFecUltFact);
            
        /* EXEC SQL
             SELECT MONTHS_BETWEEN( TRUNC(TO_DATE(:stCiclo.szFecEmision,'YYYYMMDDHH24MISS'),'MONTH'), 
                                    TRUNC(TO_DATE(:szhFecUltFact,'YYYYMMDDHH24MISS'),'MONTH') )
             INTO   :ihCantidadMeses
             FROM   DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select MONTHS_BETWEEN(TRUNC(TO_DATE(:b0,'YYYYMMDDHH24\
MISS'),'MONTH'),TRUNC(TO_DATE(:b1,'YYYYMMDDHH24MISS'),'MONTH')) into :b2  from\
 DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1264;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)(stCiclo.szFecEmision);
        sqlstm.sqhstl[0] = (unsigned long )15;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecUltFact;
        sqlstm.sqhstl[1] = (unsigned long )15;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCantidadMeses;
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


                 
        if ( SQLCODE != SQLOK )     
        {
             vDTrazasError(szExeName, "\n\t* Error en Calculo Meses (bfnTrataCBasico) [%ld] [%s]"
                                    , LOG01, SQLCODE, szfnORAerror());
             vDTrazasLog  (szExeName, "\n\t* Error en Calculo Meses (bfnTrataCBasico) [%ld] [%s]"
                                    , LOG01, SQLCODE, szfnORAerror());
             ihCantidadMeses = 0;                                             
        }
                 
        vDTrazasLog (szExeName, "\n\t\t* (bfnTrataCBasico) Cantidad Meses [%d]"
                              , LOG05
                              ,ihCantidadMeses);                 
                 
        if ( ihCantidadMeses > 1)
        {
        	
             memset(szhCantidadRentas,'\0',sizeof(szhCantidadRentas));        	
        	
             if (!bGetParamCargosMesesSusp(ihCantidadMeses, szhCantidadRentas))
             {
             	  return (FALSE);
             }	
             
             ihCantidadRentas = atoi(szhCantidadRentas);
             
             vDTrazasLog( szExeName, "\n** (bfnTrataCBasico) Cantidad Rentas [%d] **", LOG05,ihCantidadRentas);
             
             pstAbo->pstCBasico[i].dImpConcepto = pstAbo->pstCBasico[i].dImpConcepto * ihCantidadRentas;
             
             vDTrazasLog( szExeName, "\n** (bfnTrataCBasico) Importe Concepto [%f] **", LOG05,pstAbo->pstCBasico[i].dImpConcepto);
        }
            	          
/* P-MIX-09003 */                        
    }
    else               /* Tiene al menos 1 Cambio de plan con vigencia inmediata */
    {
        for (i=0; i<pstAbo->iNumCBasicos; i++)
        {
            strcpy(pstAbo->szFecAlta, pstAbo->pstCBasico[i].szFecDesde);
            strcpy(pstAbo->szFecBaja, pstAbo->pstCBasico[i].szFecHasta);

            /* Nuevo codigo de prueba TEMA PRORRATEOS NCONTRERAS */

            memset ( &stGrupoCobro,0,sizeof(GRUPOCOB));

            stGrupoCobro.iCodConcepto = pstAbo->pstCBasico[i].iCodAbono;
            stGrupoCobro.iCodProducto = pstAbo->iCodProducto;
            stGrupoCobro.iCodCiclo    = stCiclo.iCodCiclo;
            strcpy(stGrupoCobro.szCodGrupo,pstAbo->szCodGrpServ);

            if ( !bFindGrupoCob(&stGrupoCobro))
                return FALSE;
                
            memset (&stPlanTarif,0,sizeof(PLANTARIF));
           
            if ( !bFindPlanTarif (pstAbo->iCodProducto ,
                                  pstAbo->pstCBasico [i].szCodPlanTarif,
                                  &stPlanTarif) )
            {
                 return FALSE;
            }                

            memset ( &stPasoProrrateo, 0, sizeof(PASOPRORRATEO));

            strcpy (stPasoProrrateo.szFecInicio,pstAbo->szFecAlta);
            strcpy (stPasoProrrateo.szFecTermino,pstAbo->szFecBaja);
            stPasoProrrateo.dImpServicio = pstAbo->pstCBasico[i].dImpPeriodo;
            stPasoProrrateo.sIndTipoCobro= stPlanTarif.iTipCobro;
            stPasoProrrateo.sIndProrrateo= pstAbo->iIndCargoPro;


            stPasoProrrateo.sIndAlta = pstAbo->iIndAlta ;

/* P-MIX-09003 */  

            vDTrazasLog( szExeName, "\n** (bfnTrataCBasico) Ejecución Package FA_SERVICIOS_FACTURACION_PG **", LOG05);
                   
            lhNumAbonado = pstAbo->lNumAbonado;
            lhCodCicloFact = stCiclo.lCodCiclFact;
            lhCodConcepto = stGrupoCobro.iCodConcepto;
            lhNumProceso = stStatus.IdPro;
                 
            /* EXEC SQL EXECUTE
             BEGIN
                  FA_SERVICIOS_FACTURACION_PG.FA_ConsultaCobroAdelantado_PR
                  ( :lhNumAbonado,
                    :lhCodCicloFact,
                    :lhCodConcepto,
                    :lhNumProceso,
                    :lhNumOcurrencias,
                    :lhCodError,
                    :szhMsgError,
                    :lhEvento);
             END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin FA_SERVICIOS_FACTURACION_PG . FA_ConsultaCo\
broAdelantado_PR ( :lhNumAbonado , :lhCodCicloFact , :lhCodConcepto , :lhNumPr\
oceso , :lhNumOcurrencias , :lhCodError , :szhMsgError , :lhEvento ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1291;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCicloFact;
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
            sqlstm.sqhstv[3] = (unsigned char  *)&lhNumProceso;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&lhNumOcurrencias;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&lhCodError;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhMsgError;
            sqlstm.sqhstl[6] = (unsigned long )3001;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)&lhEvento;
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

	 
            
            vDTrazasLog( szExeName, "\n**  (bfnTrataCBasico) Package FA_SERVICIOS_FACTURACION_PG procdure FA_ConsultaCobroAdelantado_PR() **"
                                    "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                    "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                    "\n\t\t\t=> lhCodConcepto..... [%d]"
                                    "\n\t\t\t=> lhNumProceso...... [%ld]"
                                    "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                    "\n\t\t\t=> lhCodError........ [%ld]"
                                    "\n\t\t\t=> szhMsgError....... [%s]"
                                    "\n\t\t\t=> lhEvento.......... [%ld]"
                                    "\n\t\t\t=> SQLCODE .......... [%d]"                                                              
                                  , LOG05
                                  , lhNumAbonado
                                  , lhCodCicloFact
                                  , lhCodConcepto
                                  , lhNumProceso
                                  , lhNumOcurrencias
                                  , lhCodError
                                  , szhMsgError
                                  , lhEvento
                                  , SQLCODE);            
                  
            if ( SQLCODE != SQLOK  || lhCodError != 0)
            {       	
                 vDTrazasError( szExeName , "\n**  (bfnTrataCBasico) Error package FA_SERVICIOS_FACTURACION_PG    **"
                                                 "\n**  en procedure FA_ConsultaCobroAdelantado_PR() **"
                                                 " [%d]  [%s]"
                                               , LOG01,SQLCODE,SQLERRM);                                          
                 vDTrazasLog( szExeName, "\n**  (bfnTrataCBasico) Error en procdure FA_ConsultaCobroAdelantado_PR() **"
                                              "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                              "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                              "\n\t\t\t=> lhCodConcepto..... [%d]"
                                              "\n\t\t\t=> lhNumProceso...... [%ld]"
                                              "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                              "\n\t\t\t=> lhCodError........ [%ld]"
                                              "\n\t\t\t=> szhMsgError....... [%s]"
                                              "\n\t\t\t=> lhEvento.......... [%ld]"
                                              "\n\t\t\t=> SQLCODE .......... [%d]"
                                              "\n\t\t\t=> SQLERRM........... [%s]"                                              
                                            , LOG01
                                            , lhNumAbonado
                                            , lhCodCicloFact
                                            , lhCodConcepto
                                            , lhNumProceso
                                            , lhNumOcurrencias
                                            , lhCodError
                                            , szhMsgError
                                            , lhEvento
                                            , SQLCODE
                                            , SQLERRM);                                                       
                 return(FALSE);
            }      
/* P-MIX-09003 */

            if (i == 0)
            {
/* P-MIX-09003 */            	
                if ( lhNumOcurrencias > 0 )
                {
                     pstAbo->pstCBasico[i].iNumDiasAbono = stCiclo.iDiaPeriodo;
                     pstAbo->pstCBasico[i].dImpConcepto = fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);                	
                }
                else
                {
                     if(!bfnProrrateoStandar(&stPasoProrrateo))
                     {
                        return FALSE;
                     }

                     pstAbo->pstCBasico[i].iNumDiasAbono = stPasoProrrateo.sDiasAbono;
                     pstAbo->pstCBasico[i].dImpConcepto  = stPasoProrrateo.dImpConcepto;

                     vDTrazasLog (szExeName, "\t\t* Importe Cargo Basico Prorrateado [%f]"
                                           , LOG05
                                           , pstAbo->pstCBasico[i].dImpConcepto);
                }
/* P-MIX-09003 */                
            }
            else
            {
                /*************************************************************/
                /* El Cargo Basico en vigencia, se factura con prorrateo en  */
                /* caso que sea prorrateable, y el resto se factura la parte */
                /* proporcional sobre los minutos libres consumidos.         */
                /* Por la forma que tenemos de recoger el C.Basico el primero*/
                /* sera el de vigencia.                                      */
                /*************************************************************/

                memset (&stPlanTarif,0,sizeof(PLANTARIF));
                if ( !bFindPlanTarif (pstAbo->iCodProducto ,
                            pstAbo->pstCBasico [i].szCodPlanTarif,
                            &stPlanTarif) )
                {
                    return FALSE;
                }
                lMinFree = stPlanTarif.lNumUnidades;

                vDTrazasLog(szExeName, "\t\t=> Minutos Free [%ld] - Plan Tarif [%s]",
                             LOG05,lMinFree,pstAbo->pstCBasico[i].szCodPlanTarif);
                if ( lMinFree == 0)
                {
/* P-MIX-09003 */
                     if ( lhNumOcurrencias > 0 )
                     {
                          pstAbo->pstCBasico[i].iNumDiasAbono = stCiclo.iDiaPeriodo;
                          pstAbo->pstCBasico[i].dImpConcepto = fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);                	
                     }
                     else
                     {
                          if(!bfnProrrateoStandar(&stPasoProrrateo))
                          {
                             return FALSE;
                          }

                          pstAbo->pstCBasico[i].iNumDiasAbono = stPasoProrrateo.sDiasAbono;
                          pstAbo->pstCBasico[i].dImpConcepto  = stPasoProrrateo.dImpConcepto;

                          vDTrazasLog (szExeName, "\t\t* Importe Cargo Basico Prorrateado [%f]"
                                                , LOG05
                                                , pstAbo->pstCBasico[i].dImpConcepto);
                     }
/* P-MIX-09003 */
                }
                else
                {
                    dMinConFree = (double) dfnDBGetMinConFree (stCliente.lCodCliente,
                                        pstAbo->lNumAbonado                         ,
                                        pstAbo->iCodProducto                        ,
                                        stCiclo.lCodCiclFact                        ,
                                        pstAbo->pstCBasico [i].lCodGrupo            ,
                                        pstAbo->pstCBasico [i].szTipPlanTarif       ,
                                        pstAbo->pstCBasico [i].szCodPlanTarif)      ;

                    vDTrazasLog (szExeName, "\t\t=> Minutos Free Consumidos [%f]",LOG05, dMinConFree);
                    if (dMinConFree == -1)
                    {
                        return FALSE;
                    }
                    if ( dMinConFree == 0)
                    {
/* P-MIX-09003 */
                         if ( lhNumOcurrencias > 0 )
                         {
                              pstAbo->pstCBasico[i].iNumDiasAbono = stCiclo.iDiaPeriodo;
                              pstAbo->pstCBasico[i].dImpConcepto = fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);                	
                         }
                         else
                         {
                              if(!bfnProrrateoStandar(&stPasoProrrateo))
                              {
                                 return FALSE;
                              }

                              pstAbo->pstCBasico[i].iNumDiasAbono = stPasoProrrateo.sDiasAbono;
                              pstAbo->pstCBasico[i].dImpConcepto  = stPasoProrrateo.dImpConcepto;

                              vDTrazasLog (szExeName, "\t\t* Importe Cargo Basico Prorrateado [%f]"
                                                    , LOG05
                                                    , pstAbo->pstCBasico[i].dImpConcepto);
                         }
/* P-MIX-09003 */
                    }
                    else
                    {
                        pstAbo->pstCBasico [i].dImpPeriodo  =
                        pstAbo->pstCBasico [i].dImpPeriodo  * ((double)dMinConFree/lMinFree);

                        stPasoProrrateo.dImpServicio = pstAbo->pstCBasico[i].dImpPeriodo;
                        
/* P-MIX-09003 */
                        if ( lhNumOcurrencias > 0 )
                        {
                             pstAbo->pstCBasico[i].iNumDiasAbono = stCiclo.iDiaPeriodo;
                             pstAbo->pstCBasico[i].dImpConcepto = fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);                	
                        }                        
                        else
                        {
                             if(!bfnProrrateoStandar(&stPasoProrrateo))
                             {
                                return FALSE;
                             }
                             
                             pstAbo->pstCBasico[i].iNumDiasAbono = stPasoProrrateo.sDiasAbono;
                             pstAbo->pstCBasico[i].dImpConcepto  = stPasoProrrateo.dImpConcepto;

                             vDTrazasLog (szExeName, "\t\t* Importe Cargo Basico Prorrateado [%f]"
                                                   , LOG05
                                                   , pstAbo->pstCBasico[i].dImpConcepto);
                        }
/* P-MIX-09003 */                        
                    }
                }
            }    /* fin else i == 0            */
            
            if (!bValidacionAbono (pstAbo->iCodProducto, pstAbo->lNumAbonado , &pstAbo->pstCBasico [i]))
            {
                return FALSE;
            }
            
        }       /* fin for                    */
    }   /* fin else iNumCBasicos == 1 */
    return TRUE;
}/************************* Final bfnTrataCBasico ****************************/

/*****************************************************************************/
/* FUNCION     : bGetParamCargosMesesSusp                                    */
/* DESCRIPCION : Recuperar parámetro Cargos Meses Suspension (679) desde     */
/*               Tabla FAD_PARAMETROS                                        */
/*****************************************************************************/
BOOL bGetParamCargosMesesSusp (int iCantidadMeses, char *szCantidadRentas)
{
    char szFuncion []= "bGetParamCargosMesesSusp";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int  ihCantidadMeses        ;
         char szhCantidadRentas[512+1]; /* EXEC SQL VAR szhCantidadRentas IS STRING(512+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);
    
    memset(szhCantidadRentas,'\0',sizeof(szhCantidadRentas));
    
    ihCantidadMeses = iCantidadMeses;

    /* Obtencion Valor Cargos Meses Suspension */
    /* EXEC SQL
	 SELECT VAL_CARACTER
	 INTO   :szhCantidadRentas
	 FROM   FAD_PARAMETROS
	 WHERE  COD_MODULO='FA'
	 AND    COD_PARAMETRO=679
	 AND    VAL_NUMERICO = :ihCantidadMeses; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_CARACTER into :b0  from FAD_PARAMETROS where (\
(COD_MODULO='FA' and COD_PARAMETRO=679) and VAL_NUMERICO=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1338;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCantidadRentas;
    sqlstm.sqhstl[0] = (unsigned long )513;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCantidadMeses;
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

    
    
    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
    	vDTrazasLog(szFuncion, "\n\t** ERROR, al recuperar parámetro 679 CARGOS_MESES_SUSPENCION [%d] **"
                             , LOG01
                             , sqlca.sqlcode);
        return (FALSE);
    }     
    
    if (sqlca.sqlcode == SQLNOTFOUND)
    {
        strcpy(szhCantidadRentas,"1");  	
    }

    strcpy(szCantidadRentas,szhCantidadRentas);

    
    vDTrazasLog(szFuncion, "\n\t=> Número Rentas [%s] "
                         , LOG04
                         , szCantidadRentas);    

    return (TRUE);
} /************************* FIN bGetParamCargosMesesSusp ************************/

/*****************************************************************************/
/*                         funcion : bfnInfServicios                         */
/* - Informacion para la recuperacion de Servicios Suplementarios            */
/*   y Cargos Ocasionales, se recoge sobre la variable global:               */
/*   stCliente.pServAbo                                                      */
/*****************************************************************************/
static BOOL bfnInfServicios (ABONOS *stAbo, CARGOFIJO stCBasico)
{

    if ( (stCliente.pServAbo =
            (SERVABO *)realloc ( (SERVABO *)stCliente.pServAbo,
                (stCliente.iNumServAbo+1)*sizeof(SERVABO) ))==(SERVABO *)NULL)
    {
        iDError (szExeName,ERR005,vInsertarIncidencia,"stCliente.pServAbo");
            return  (FALSE)               ;
    }
    else
    {
        memset (&stCliente.pServAbo[stCliente.iNumServAbo],0,sizeof(SERVABO));

        strcpy (stCliente.pServAbo[stCliente.iNumServAbo].szRowid,
                stCBasico.szRowid);

        stCliente.pServAbo[stCliente.iNumServAbo].lNumAbonado =
                                                  stAbo->lNumAbonado    ;
        stCliente.pServAbo[stCliente.iNumServAbo].iCodProducto=
                                                  stAbo->iCodProducto   ;
        stCliente.pServAbo[stCliente.iNumServAbo].lCodPlanCom =
                                                  stCBasico.lCodPlanCom;
        stCliente.pServAbo[stCliente.iNumServAbo].lCapCode    =
                                                  stCBasico.lCapCode   ;

        strcpy (stCliente.pServAbo[stCliente.iNumServAbo].szFecDesde,
                stCBasico.szFecDesde)   ;
        strcpy (stCliente.pServAbo[stCliente.iNumServAbo].szFecHasta,
                stCBasico.szFecHasta)   ;
        strcpy (stCliente.pServAbo[stCliente.iNumServAbo].szCodPlanServ,
                stCBasico.szCodPlanServ);
        strcpy (stCliente.pServAbo[stCliente.iNumServAbo].szCodGrpServ,
                stCBasico.szCodGrpServ );
        strcpy (stCliente.pServAbo[stCliente.iNumServAbo].szNumTerminal,
                stCBasico.szNumTerminal);

        stCliente.pServAbo[stCliente.iNumServAbo].iNumServicios=  0           ;
        stCliente.pServAbo[stCliente.iNumServAbo].pServicios=(SERVICIOS *)NULL;
        stCliente.iNumServAbo++;
    }
    return TRUE;

}/************************* Final bfnInfServicios ****************************/


/****************************************************************************/
/*                           Funcion : ifnClienteFacturable                 */
/****************************************************************************/
static int ifnClienteFacturable ()
{
    int i = 0;

    for (i=0;i<stCliente.iNumAbonos;i++)
    {
        if (stCliente.pAbonos [i].iIndFactur == 1)
            break;
    }
    return (i>=stCliente.iNumAbonados)?0:1;

}/************************** Final ifnClienteFacturable *********************/

static BOOL bfnGetSegCBasico ( long lNumAbonado
                             , char *szCodPlantarif
                             , long lCodCiclFact
                             , long *lSegundosFree)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhNumAbonado           ;
        char szhCodPlantarif  [4]   ; /* EXEC SQL VAR szhCodPlantarif IS STRING(4); */ 

        long lhCodCiclFact          ;
        long lhSegundosFree         ;
    /* EXEC SQL END   DECLARE SECTION; */ 


    lhNumAbonado    =   lNumAbonado   ;
    strcpy (szhCodPlantarif,szCodPlantarif);
    lhCodCiclFact   =   lCodCiclFact  ;

    /* EXEC SQL
        SELECT NVL(SUM(SEG_GRATUITOS + SEG_FFENTRANTES + SEG_PROMCONS), 0)
          INTO :lhSegundosFree
          FROM TA_ACUMAIRE
         WHERE NUM_ABONADO  = :lhNumAbonado
           AND COD_PLANTARIF= :szhCodPlantarif
           AND COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(sum(((SEG_GRATUITOS+SEG_FFENTRANTES)+SEG_PROMC\
ONS)),0) into :b0  from TA_ACUMAIRE where ((NUM_ABONADO=:b1 and COD_PLANTARIF=\
:b2) and COD_CICLFACT=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1361;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSegundosFree;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlantarif;
    sqlstm.sqhstl[2] = (unsigned long )4;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(sqlca.sqlcode < SQLOK)
    {
        return (FALSE);
    }

    *lSegundosFree=lhSegundosFree;
    return (TRUE);

}

static BOOL bfnObtieneCantDiasAProrratear (int iDiasTotales, int *iDiasAnt, int *iDiasActual)
{

    vDTrazasLog(szExeName,  "bfnObtieneCantDiasAProrratear  iDiasTotales(%d)\n"
                            "bfnObtieneCantDiasAProrratear  stCiclo.iDiaPeriodo(%d)"
                            ,LOG05, iDiasTotales, stCiclo.iDiaPeriodo);

    *iDiasAnt   = iDiasTotales - stCiclo.iDiaPeriodo;
    *iDiasActual    = stCiclo.iDiaPeriodo;

    vDTrazasLog(szExeName,  "bfnObtieneCantDiasAProrratear  iDiasAnt(%d)\n"
                            "bfnObtieneCantDiasAProrratear  iDiasActual(%d)",LOG05, *iDiasAnt, *iDiasActual);

    return (TRUE);
}


/****************************************************************************************/
/*                        funcion : bfnProrrateoStandar                                 */
/* -Funcion generica  que realiza el prorrateo de cargos recurrentes                    */
/* - Recibe como entrada los siguientes estructura de parametros :                      */
/*  Fec Inicio : Fecha de Inicio del servicio YYYYMMDD                                  */
/*  Fec Termino: Fecha de Termino del servicio YYYYMMDD                                 */
/*  Importe Servicio : Importe del servicio para un periodo compleo                     */
/*  Tipo de cobro    : VENCIDO o ANTICIPADO                                             */
/*  Indicador de Alta: Indicador de alta del servicio                                   */
/*  Indicador de Prorrateo : Indicador si el servicio es prorrateable 1:SI 0:NO         */
/*  Importe Concepto : Importe prorrateado. Resultado del calculo                       */
/*  Dias Prorrateo   : Numero dias en q se prorrateo el importe                         */
/*                                                                                      */
/* Si todo OK retorna TRUE , en caso contrario retorna FALSE                            */
/****************************************************************************************/
/* Modificación: Ya no pregunta si es anticipado o vencido, es más generico que el ant. */
/* se respalda proceso real como preser_real.pc                                         */
/* Fabian aEdo Ramírez Agosto 28, del 2002.                                             */
/****************************************************************************************/
static BOOL bfnProrrateoStandar(PASOPRORRATEO *pCargo)
{
    int iDiasAlta ;
    int iDiasAnt    ;
    int iDiasActual ;

    vDTrazasLog(szExeName,  "\n\t\t* bfnProrrateoStandar"
                "\n\t\t=> Fec Inicio  : [%s]"
                "\n\t\t=> Fec Termino     : [%s]"
                "\n\t\t=> Importe Servicio: [%f]"
                "\n\t\t=> Tipo de cobro   : [%d]"
                "\n\t\t=> Ind Alta        : [%d]",LOG05,
                pCargo->szFecInicio,
                pCargo->szFecTermino,
                pCargo->dImpServicio,
                pCargo->sIndTipoCobro,
                pCargo->sIndAlta);

    vDTrazasLog(szExeName,  "\t\t* bfnProrrateoStandar --> More..."
                "\n\t\t=> pCargo->sIndProrrateo        : [%d]"
                "\n\t\t=> stCiclo.szFecDesdeCFijos     : [%s]"
                "\n\t\t=> stCiclo.szFecHastaCFijos     : [%s]"
                "\n\t\t=> stCiclo.iDiaPeriodo          : [%d]"
                "\n\t\t=> stCiclo.iDiaPeriodoAnt       : [%d]",LOG05,
                pCargo->sIndProrrateo,
                stCiclo.szFecDesdeCFijos,
                stCiclo.szFecHastaCFijos,
                stCiclo.iDiaPeriodo,
                stCiclo.iDiaPeriodoAnt);

    if ( pCargo->sIndProrrateo) /* Si servicio es prorrateable */
    {

        /* CASO 4 :Alta anterior al inicio del ciclo y baja posterior al termino del ciclo */
        if ( strcmp(pCargo->szFecInicio, stCiclo.szFecDesdeCFijos ) <=0 &&
           ( strcmp(pCargo->szFecTermino,stCiclo.szFecHastaCFijos ) > 0 ||
             strcmp(pCargo->szFecTermino,"" ) == 0 ) )
        {
            /* Primera vez que se factura... va hacia atras... */
            if ( pCargo->sIndAlta == 1 )
            {
                if (!bRestaFechas ( stCiclo.szFecHastaCFijos,pCargo->szFecInicio,&iDiasAlta))
                {
                    vDTrazasError (szExeName, "\n\t\t=> Error bRestaFechas"
                                              "\n\t\t=> Fecha 1 : [%s]"
                                              "\n\t\t=> Fecha 2 : [%s]",LOG03,
                                              pCargo->szFecTermino,
                                              stCiclo.szFecDesdeCFijos);
                    return FALSE;
                }
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "\n\t\t* bRestaFechas --> Resultados..."
                                        "\n\t\t=> stCiclo.szFecHastaCFijos     : [%s]"
                                        "\n\t\t=> pCargo->szFecInicio          : [%s]"
                                     ,  LOG05
                                     ,  stCiclo.szFecHastaCFijos
                                     ,  pCargo->szFecInicio);
            }
            else
            {
                iDiasAlta = stCiclo.iDiaPeriodo;
            }

            /* TM-1705 (1-1) ---> TRAZAS */
            vDTrazasLog(szExeName,  "\n\t\t* bRestaFechas --> Dias Alta..."
                                    "\n\t\t=> iDiasAlta  SALIDA     : [%d]"
                                 ,  LOG05
                                 , iDiasAlta);

            if (iDiasAlta > stCiclo.iDiaPeriodo)
            {
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "Dias Alta condicion iDiasAlta > stCiclo.iDiaPeriodo (%d)"
                                     ,  LOG05
                                     ,  iDiasAlta);

                if (!bfnObtieneCantDiasAProrratear (iDiasAlta, &iDiasAnt, &iDiasActual))
                {
                    vDTrazasLog(szExeName,  "\n\t\t CASO 4 :(Obtencion de dias para Prorratear)"
                                            "\n\t\t=> Error en la ejecucion de F(x)  bfnObtieneCantDiasAProrratear"
                                         ,  LOG05);
                    return (FALSE);

                }
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "bfnObtieneCantDiasAProrratear   iDiasAnt (%d) -- iDiasActual (%d)\n",LOG05,
                            iDiasAnt,iDiasActual);


                if ((stCiclo.iDiaPeriodo == 0) || (stCiclo.iDiaPeriodoAnt == 0))
                {
                   /* TM-1705 (1-1) ---> TRAZAS */
                   vDTrazasLog(szExeName,  "stCiclo.iDiaPeriodo == 0) || (stCiclo.iDiaPeriodoAnt == 0\n",LOG05);
                   if (stCiclo.iDiaPeriodo == 0)
                   {
                      if (stCiclo.iDiaPeriodoAnt == 0)
                          pCargo->dImpConcepto = 0.0;
                      else
                      {
                          /* TM-1705 (1-1) ---> TRAZAS */
                          pCargo->dImpConcepto = (double) ((pCargo->dImpServicio * iDiasAlta) / stCiclo.iDiaPeriodoAnt);
                      }
                      /* TM-1705 (1-1) ---> TRAZAS */
                      vDTrazasLog(szExeName,  "pCargo->dImpConcepto A (%f)\n"
                                           ,  LOG05
                                           ,  pCargo->dImpConcepto);
                   }
                   else
                   {
                       if (stCiclo.iDiaPeriodoAnt == 0)
                            if (stCiclo.iDiaPeriodo == 0)
                                pCargo->dImpConcepto = 0.0;
                            else
                            {
                                /* TM-1705 (1-1) ---> TRAZAS */
                                pCargo->dImpConcepto = (double) ((pCargo->dImpServicio * iDiasAlta) / stCiclo.iDiaPeriodo);
                            }
                      /* TM-1705 (1-1) ---> TRAZAS */
                      vDTrazasLog(szExeName,  "pCargo->dImpConcepto B (%f)\n"
                                           ,  LOG05
                                           ,  pCargo->dImpConcepto);
                    }
                }
                else
                {

                    pCargo->dImpConcepto = (double) (((pCargo->dImpServicio * iDiasActual) / stCiclo.iDiaPeriodo) + ((pCargo->dImpServicio * iDiasAnt) / stCiclo.iDiaPeriodoAnt));
                    vDTrazasLog(szExeName,  "CARGO IMPUESTO SERVICIO %lf\n"
                                            "DIAS PERIODO ACTUAL %d\n"
                                            "DIAS ACTUAL %d\n"
                                            "========================\n"
                                            "CARGO IMPUESTO SERVICIO %lf\n"
                                            "DIAS PERIODO ANTERIOR %d\n"
                                            "DIAS ANTERIOR %d\n"
                                            "========================\n"
                                            "TOTAL CARGO IMPUESTO CONCEPTO %lf\n"
                                         ,  LOG05
                                         ,  pCargo->dImpServicio,stCiclo.iDiaPeriodo
                                         ,  iDiasActual
                                         ,  pCargo->dImpServicio,stCiclo.iDiaPeriodoAnt
                                         ,  iDiasAnt,pCargo->dImpConcepto);
                }
            }
            else
            {
                vDTrazasLog(szExeName,  "C  iDiasAlta (%d) -- stCiclo.iDiaPeriodo (%d)\n"
                                     ,  LOG05
                                     ,  iDiasAlta
                                     ,  stCiclo.iDiaPeriodo);
                                     
                if (stCiclo.iDiaPeriodo == 0)
                    pCargo->dImpConcepto = 0.0;
                else
                    pCargo->dImpConcepto = (double) ((pCargo->dImpServicio * iDiasAlta) / stCiclo.iDiaPeriodo);
                    
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "pCargo->dImpConcepto C (%f)\n"
                                     ,  LOG05
                                     ,  pCargo->dImpConcepto);
            }

            pCargo->sDiasAbono   = iDiasAlta;

            vDTrazasLog(szExeName,  "\n\t\t CASO 4 :(A anterior y B posterior)\n"
                                    "\t\t=> Ind Prorrateo   : [%d]\n"
                                    "\t\t=> Dias Abono      : [%d]\n"
                                    "\t\t=> Importe Concepto: [%f]\n",LOG05,
                                    pCargo->sIndProrrateo,
                                    pCargo->sDiasAbono,
                                    pCargo->dImpConcepto);
        }
        /* CASO 1 :Alta y Baja dentro del ciclo en proceso */
        else if (strcmp(pCargo->szFecInicio,stCiclo.szFecDesdeCFijos)  >  0 &&
                 strcmp(pCargo->szFecTermino,stCiclo.szFecHastaCFijos) <= 0 &&
                 strcmp(pCargo->szFecTermino,"" ) != 0 )
        {
            if (!bRestaFechas ( pCargo->szFecTermino,pCargo->szFecInicio,&iDiasAlta))
            {
                vDTrazasError (szExeName,"\n\t\t=> Error bRestaFechas"
                                         "\n\t\t=> Fecha 1 : [%s]"
                                         "\n\t\t=> Fecha 2 : [%s]",LOG03,
                                         pCargo->szFecInicio,
                                         pCargo->szFecTermino);
                return FALSE;
            }

            if (iDiasAlta == 0 ) iDiasAlta = 1;

            pCargo->dImpConcepto = fnCnvDouble((pCargo->dImpServicio * iDiasAlta/stCiclo.iDiaPeriodo), USOFACT);
            pCargo->sDiasAbono   = iDiasAlta;

            vDTrazasLog(szExeName,  "\n\t\t CASO 1 :(A y B dentro del Periodo)\n"
                                    "\t\t=> Ind Prorrateo   : [%d]\n"
                                    "\t\t=> Dias Abono      : [%d]\n"
                                    "\t\t=> Importe Concepto: [%f]\n",LOG05,
                                    pCargo->sIndProrrateo,
                                    pCargo->sDiasAbono,
                                    pCargo->dImpConcepto);
        }
        /* CASO 2 :Alta dentro del ciclo y baja posterior */
        else if (strcmp(pCargo->szFecInicio, stCiclo.szFecDesdeCFijos) > 0 &&
                 strcmp(pCargo->szFecInicio, stCiclo.szFecHastaCFijos) <=0 &&
                (strcmp(pCargo->szFecTermino,stCiclo.szFecHastaCFijos) > 0 ||
                 strcmp(pCargo->szFecTermino,"" ) == 0 ) )
        {

            if (!bRestaFechas ( stCiclo.szFecHastaCFijos,pCargo->szFecInicio,&iDiasAlta))
            {
                vDTrazasError (szExeName,   "\n\t\t=> Error bRestaFechas"
                                            "\n\t\t=> Fecha 1 : [%s]"
                                            "\n\t\t=> Fecha 2 : [%s]",LOG03,
                                            stCiclo.szFecHastaCFijos,
                                            pCargo->szFecInicio);
                return FALSE;
            }

            if (iDiasAlta == 0 ) 
            {
            	iDiasAlta = 1;
            }

            pCargo->dImpConcepto = fnCnvDouble(( (pCargo->dImpServicio * iDiasAlta)/stCiclo.iDiaPeriodo), USOFACT);
            pCargo->sDiasAbono   = iDiasAlta;

            if ((pCargo->sIndAlta == 1)&&(pCargo->sIndTipoCobro == 1)) /* P-MIX-09003 */
            {
            	pCargo->dImpConcepto = pCargo->dImpConcepto + pCargo->dImpServicio;
                vDTrazasLog(szExeName, "\n\t\t* Se agrega Cargo Inicial adelantado. *\n"
                                     , LOG05);
            }

            vDTrazasLog(szExeName,  "\n\t\t CASO 2 :(A dentro y B posterior)\n"
                                    "\t\t=> Ind Prorrateo   : [%d]\n"
                                    "\t\t=> Dias Abono      : [%d]\n"
                                    "\t\t=> Importe Concepto: [%f]\n",LOG05,
                                    pCargo->sIndProrrateo,
                                    pCargo->sDiasAbono,
                                    pCargo->dImpConcepto);

        }
        /* CASO 3 :Alta anterior al inicio de ciclo y baja dentro de ciclo */
        else if( strcmp(pCargo->szFecInicio,stCiclo.szFecDesdeCFijos) <= 0 &&
                 strcmp(pCargo->szFecTermino,stCiclo.szFecDesdeCFijos) >= 0 &&
                 strcmp(pCargo->szFecTermino,stCiclo.szFecHastaCFijos) <= 0 &&
                 strcmp(pCargo->szFecTermino,"" ) != 0)
        {
            /* Primera vez que se factura... va hacia atras... */
            if ( pCargo->sIndAlta == 1 )
            {
                if (!bRestaFechas ( pCargo->szFecTermino,pCargo->szFecInicio,&iDiasAlta))
                {
                    vDTrazasError (szExeName,   "\n\t\t=> Error bRestaFechas"
                                                "\n\t\t=> Fecha 1 : [%s]"
                                                "\n\t\t=> Fecha 2 : [%s]",LOG03,
                                                pCargo->szFecTermino,
                                                pCargo->szFecInicio);
                    return FALSE;
                }
            }
            else
            {
                if (!bRestaFechas ( pCargo->szFecTermino,stCiclo.szFecDesdeCFijos,&iDiasAlta))
                {
                    vDTrazasError (szExeName,   "\n\t\t=> Error bRestaFechas"
                                                "\n\t\t=> Fecha 1 : [%s]"
                                                "\n\t\t=> Fecha 2 : [%s]",LOG03,
                                                pCargo->szFecTermino,
                                                stCiclo.szFecDesdeCFijos);
                         return FALSE;
                }
            }
            if (iDiasAlta == 0 ) iDiasAlta = 1;

        if (iDiasAlta > stCiclo.iDiaPeriodo)
        {
            if (!bfnObtieneCantDiasAProrratear (iDiasAlta, &iDiasAnt, &iDiasActual))
                {
                    vDTrazasLog(szExeName,  "\n\t\t CASO 4 :(Obtencion de dias para Prorratear)\n"
                                    "\t\t=> Error en la ejecucion de F(x)  bfnObtieneCantDiasAProrratear\n", LOG05);
                return (FALSE);

                }

            if ((stCiclo.iDiaPeriodo == 0) || (stCiclo.iDiaPeriodoAnt == 0))
            {
                if (stCiclo.iDiaPeriodo == 0)
                {
                    if (stCiclo.iDiaPeriodoAnt == 0)
                        pCargo->dImpConcepto = 0.0;
                    else
                        pCargo->dImpConcepto = (double) ((pCargo->dImpServicio * iDiasAnt) / stCiclo.iDiaPeriodoAnt);
                }
                else if(stCiclo.iDiaPeriodoAnt == 0)
                    if (stCiclo.iDiaPeriodo == 0)
                        pCargo->dImpConcepto = 0.0;
                    else
                        pCargo->dImpConcepto = (double) ((pCargo->dImpServicio * iDiasActual) / stCiclo.iDiaPeriodo);
            }
            else
            {
                pCargo->dImpConcepto = fnCnvDouble ((((pCargo->dImpServicio * iDiasActual) / stCiclo.iDiaPeriodo) + ((pCargo->dImpServicio * iDiasAnt) / stCiclo.iDiaPeriodoAnt)), USOFACT);
            }
        }
        else
        {
            if (stCiclo.iDiaPeriodo == 0)
                pCargo->dImpConcepto = 0.0;
            else
                pCargo->dImpConcepto = fnCnvDouble (((pCargo->dImpServicio * iDiasAlta) / stCiclo.iDiaPeriodo), USOFACT);
        }

            pCargo->sDiasAbono   = iDiasAlta;

            if ((pCargo->sIndTipoCobro == 1)) /* P-MIX-09003 */
            {
            	pCargo->dImpConcepto = 0;
                vDTrazasLog(szExeName, "\n\t\t* Ultimo Cargo = 0 por Cargo Adelantado. *\n"
                                     , LOG05);            	
            }

            vDTrazasLog(szExeName,  "\n\t\t CASO 3 :(A anterior y B dentro del ciclo)\n"
                                    "\t\t=> Ind Prorrateo   : [%d]\n"
                                    "\t\t=> Dias Abono      : [%d]\n"
                                    "\t\t=> Importe Concepto: [%f]\n",LOG05,
                                    pCargo->sIndProrrateo,
                                    pCargo->sDiasAbono,
                                    pCargo->dImpConcepto);

        }
        /* CASO 5 :Alta y Baja anterior al ciclo en proceso */
        else if ( strcmp(pCargo->szFecInicio,stCiclo.szFecDesdeCFijos)  < 0 &&
                  strcmp(pCargo->szFecTermino,stCiclo.szFecDesdeCFijos) < 0 &&
                  strcmp(pCargo->szFecTermino,"" ) != 0  )
        {
            if (!bRestaFechas ( pCargo->szFecTermino,pCargo->szFecInicio,&iDiasAlta))
            {
                vDTrazasError (szExeName,   "\n\t\t=> Error bRestaFechas"
                                            "\n\t\t=> Fecha 1 : [%s]"
                                            "\n\t\t=> Fecha 2 : [%s]",LOG03,
                                            pCargo->szFecInicio,
                                            pCargo->szFecTermino);
                return FALSE;
            }

            vDTrazasError (szExeName, "\n\t\t=> pCargo->sIndAlta[%d]",LOG03, pCargo->sIndAlta);

            if (pCargo->sIndAlta == 1)
            {
                if (iDiasAlta == 0 ) iDiasAlta = 1;

                pCargo->dImpConcepto = fnCnvDouble((pCargo->dImpServicio * iDiasAlta/stCiclo.iDiaPeriodo), USOFACT);
                pCargo->sDiasAbono   = iDiasAlta;

                vDTrazasLog(szExeName,  "\n\t\t CASO 5 :(A y B anterior al Periodo)\n"
                            "\t\t=> Ind Prorrateo   : [%d]\n"
                            "\t\t=> Dias Abono      : [%d]\n"
                            "\t\t=> Importe Concepto: [%f]\n",LOG05,
                            pCargo->sIndProrrateo,
                            pCargo->sDiasAbono,
                            pCargo->dImpConcepto);
            }
            else {
                vDTrazasLog(szExeName,  "\n\t\t CASO 5 :(A y B anterior al Periodo) Cargo Basico Facturado Previamente (No se Prorraeta)...\n"
                                        "\t\t=> Ind Prorrateo   : [%d]\n"
                                        "\t\t=> Dias Abono      : [%d]\n"
                                        "\t\t=> Importe Concepto: [%f]\n",LOG05,
                                        pCargo->sIndProrrateo,
                                        pCargo->sDiasAbono,
                                    pCargo->dImpConcepto);
            }
        }
        /* CASO 6 :Alta y Baja posterior al ciclo en proceso */
        else if ( strcmp(pCargo->szFecInicio,stCiclo.szFecHastaCFijos)  > 0 &&
                 (strcmp(pCargo->szFecTermino,stCiclo.szFecHastaCFijos) > 0 ||
                  strcmp(pCargo->szFecTermino,"" ) == 0 ) )
        {
            vDTrazasLog(szExeName,  "\n\t\t CASO 6 : A y B  posterior -->Error\n"
                                    "\t\t=> Fecha Alta   : [%s]\n"
                                    "\t\t=> Fecha Baja   : [%s]\n",LOG03,
                                    pCargo->szFecInicio,
                                    pCargo->szFecTermino);

            vDTrazasError(szExeName,"\n\t\t=> Error Prorrateo (A y B posterior) CASO 6"
                                    "\n\t\t=> Fecha Alta : [%s]"
                                    "\n\t\t=> Fecha Baja : [%s]",LOG03,
                                    pCargo->szFecInicio,
                                    pCargo->szFecTermino);
                                    
            pCargo->dImpConcepto = 0.0;
            pCargo->sDiasAbono   = 0;
        }

    }
    else
    { /* Servicio no es prorrateable */

        vDTrazasLog(szExeName,  "\n\t\t Servicio NO prorrateable \n"
                                "\t\t Importe Concepto : [%f]\n",LOG05,
                                pCargo->dImpServicio);

        pCargo->dImpConcepto = fnCnvDouble(pCargo->dImpServicio, USOFACT);
        pCargo->sDiasAbono   = stCiclo.iDiaPeriodo;
    }

    return TRUE;
}
/**************************** Fin bfnProrrateoStandar ***************************************/



/****************************************************************************************/
/*                        funcion : BfnObtieneValorCrit_PlanTarif           */
/* Funcion que verifica si servicio cumple con criterios                */
/* Si todo OK retorna TRUE , en caso contrario FALSE                    */
/* Desarrollado por Nelson Contreras Helena                     */
/****************************************************************************************/
BOOL BfnObtieneValorCrit_PlanTarif(char* szCodServicio, int iCodProducto ,
                                   char* szTipCuenta, long lNumAbonado)
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

static char   szhCodServicio  [3] ;/* EXEC SQL VAR szhCodServicio   IS STRING(3) ; */ 

static int    iIndCriterio = 0    ;
static int    iIndAbonadoCero=0   ;
static int    iAuxCriterio;
static char   szAuxValCriterio[3] ;/* EXEC SQL VAR szAuxValCriterio IS STRING(3) ; */ 

static int    iAuxCodProducto;

/* EXEC SQL END DECLARE SECTION; */ 



    strcpy(szhCodServicio,szCodServicio);
    iAuxCodProducto = iCodProducto;
    iAuxCriterio    = CRIT_PLANTARIF;

    /* EXEC SQL
    SELECT IND_CRITERIO,
           IND_ABONADO0
    INTO   :iIndCriterio,
           :iIndAbonadoCero
    FROM FA_PARAMSERV
    WHERE COD_SERVICIO = :szhCodServicio AND
          COD_PRODUCTO = :iAuxCodProducto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_CRITERIO ,IND_ABONADO0 into :b0,:b1  from FA_P\
ARAMSERV where (COD_SERVICIO=:b2 and COD_PRODUCTO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1392;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iIndCriterio;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iIndAbonadoCero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodServicio;
    sqlstm.sqhstl[2] = (unsigned long )3;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iAuxCodProducto;
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



    vDTrazasLog(szExeName,  "\n\t\t Select en FA_PARAMSERV \n"
                            "\t\t=> CodServicio     : [%s]\n"
                            "\t\t=> CodProducto     : [%d]\n"
                            "\t\t=> Tip Cuenta      : [%s]\n"
                            "\t\t=> Ind Criterio    : [%d]\n"
                            "\t\t=> Ind Abonado Cero: [%d]\n"
                            "\t\t=> SQLCODE      : [%d]\n",LOG05,
                            szCodServicio,
                            iCodProducto,
                            szTipCuenta,
                            iIndCriterio,
                            iIndAbonadoCero,
                            SQLCODE);


    if(SQLCODE == SQLOK || SQLCODE == SQLNOTFOUND)
    {

        if ( iIndCriterio == 0 || SQLCODE == SQLNOTFOUND )
                    return TRUE;

        if ( iIndAbonadoCero == 0 && lNumAbonado == 0 )
                    return FALSE;


        /* EXEC SQL DECLARE Cursor_Criterios CURSOR FOR
        SELECT COD_CRITERIO,
               VAL_CRITERIO
        FROM FA_CRITSERV
        WHERE COD_SERVICIO = :szhCodServicio  AND
              COD_PRODUCTO = :iAuxCodProducto AND
              COD_CRITERIO = :iAuxCriterio ; */ 


        if ( SQLCODE != SQLOK )
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Declare Cursor_Criterios->", szfnORAerror());
            return FALSE;
        }

        /* EXEC SQL OPEN Cursor_Criterios ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0027;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1423;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodServicio;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&iAuxCodProducto;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&iAuxCriterio;
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



        if ( SQLCODE != SQLOK )
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Open Cursor_Criterios->", szfnORAerror());
            return FALSE;
        }


        /* EXEC SQL FETCH Cursor_Criterios INTO
             :iAuxCriterio,
             :szAuxValCriterio; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1450;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&iAuxCriterio;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szAuxValCriterio;
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



        if ( SQLCODE == SQLNOTFOUND )    return  TRUE;

        while ( SQLCODE == SQLOK  )
        {
            if ( !strcmp(szAuxValCriterio,szTipCuenta) )
                return TRUE;

            /* EXEC SQL FETCH Cursor_Criterios INTO
             :iAuxCriterio,
             :szAuxValCriterio; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 30;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )1473;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)&iAuxCriterio;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szAuxValCriterio;
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



             if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
             {
                  iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch Cursor_Criterios->", szfnORAerror());
                  return FALSE;
             }
        }

        /* EXEC SQL CLOSE Cursor_Criterios; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1496;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if ( SQLCODE != SQLOK )
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Close Cursor_Criterios->", szfnORAerror());
            return FALSE;
        }

        return FALSE;
    }
    else
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select fa_paramserv->", szfnORAerror());
        return FALSE;
    }


}/************************* Fin bfnObtieneValorCriterios *********************************/

/******************************************************************************
Funcion         :       ifnCmpGeTarifas
*******************************************************************************/
static int ifnCmpGeTarifas(const void *pvstKey,const void *pvstItem)
{
    TARIFAS *pstKey = (TARIFAS *) pvstKey;
    TARIFAS *pstItem = (TARIFAS *) pvstItem;
    int rc = 0;

    return ( (rc = strcmp ( pstKey->szCodTipServ,
                        pstItem->szCodTipServ) )!= 0)?rc:
            ( (rc = strcmp ( pstKey->szCodServicio,
                        pstItem->szCodServicio))!= 0)?rc:
            ( (rc = strcmp ( pstKey->szCodPlanServ,
                        pstItem->szCodPlanServ))!= 0)?rc:
            ( (rc = strcmp (pstKey->szFecHasta,
                        ""                    ))!= 0)?(((rc = strcmp (pstKey->szFecHasta, pstItem->szFecDesde))> 0)?rc:( (rc = strcmp ( pstKey->szFecDesde,
                        pstItem->szFecDesde)  ) < 0 )?rc:0):
            ( (rc = strcmp ( pstKey->szFecDesde,
                        pstItem->szFecDesde)  ) < 0 )?rc:0;

}

/*****************************************************************************/
/*                       funcion : bFindTarifa                               */
/* -Funcion que busca un registro en pstTarifas (Ge_Tarifas)                 */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bFindTarifa (TARIFAS *pStrucPar)
{
    TARIFAS stkey;
    BOOL bRes = TRUE;
    TARIFAS *pStruc_Aux = (TARIFAS *)NULL;

    strcpy (stkey.szCodTipServ  , pStrucPar->szCodTipServ);
    strcpy (stkey.szCodServicio , pStrucPar->szCodServicio);
    strcpy (stkey.szCodPlanServ , pStrucPar->szCodPlanServ);
    strcpy (stkey.szFecDesde    , pStrucPar->szFecDesde);
    strcpy (stkey.szFecHasta    , pStrucPar->szFecHasta);

    vDTrazasLog (szExeName, "\n\t* Busca Tarifa "
                            "\n\t\t=> Tipo Serv.    [%s]"
                            "\n\t\t=> Codigo Serv.  [%s]"
                            "\n\t\t=> Plan de Serv. [%s]"
                            "\n\t\t=> Fecha         [%s]",
                            LOG05,
                            stkey.szCodTipServ,
                            stkey.szCodServicio,
                            stkey.szCodPlanServ,
                            stkey.szFecDesde);

    if ( (pStruc_Aux = (TARIFAS *)bsearch(&stkey,pstTarifas,NUM_TARIFAS,
                     sizeof(TARIFAS),ifnCmpGeTarifas))==(TARIFAS *)NULL)
    {
        bRes = FALSE;
    }
    else
    {
        pStrucPar->dImpTarifa    = pStruc_Aux->dImpTarifa   ;
        strcpy(pStrucPar->szCodMoneda   , pStruc_Aux->szCodMoneda);
        strcpy(pStrucPar->szIndPeriodico, pStruc_Aux->szIndPeriodico);
        strcpy(pStrucPar->szFecHasta    , pStruc_Aux->szFecHasta);
    }
    
  return bRes;
}/************************** Final bFindTarifa **************************/

static BOOL bfnGetSuspVolProg ( long lNumAbonado
                              , char *szFecConsulta)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhNumAbonado       ;
        char szhFecha [15]      ; /* EXEC SQL VAR szhFecha IS STRING(15); */ 

        char szhCodEstado [4]   ; /* EXEC SQL VAR szhCodEstado IS STRING(4); */ 

        char szhFmtYYYYMMDD [9] ; /* EXEC SQL VAR szhFmtYYYYMMDD IS STRING(9); */ 

        int  ihCount = 0        ;
    /* EXEC SQL END   DECLARE SECTION; */ 


    lhNumAbonado    =   lNumAbonado   ;
    strcpy (szhFecha,szFecConsulta);
    strcpy (szhCodEstado,"SUS");
    strcpy (szhFmtYYYYMMDD,"YYYYMMDD");
    strcpy (szpFormatoFec,"YYYYMMDDHH24MISS");

    vDTrazasLog (szExeName, "\n\t* Consulta Suspencion Voluntaria "
                            "\n\t=> Abonado : [%ld]"
                            "\n\t=> Fecha   : [%s]"
                            , LOG05,lhNumAbonado, szhFecha);

    /* EXEC SQL
        SELECT COUNT(1)
          INTO :ihCount
          FROM PV_DET_SUSPVOLPROG_TO
         WHERE NUM_ABONADO = :lhNumAbonado
           AND TO_CHAR (FEC_SUSPENSION, :szhFmtYYYYMMDD) = TO_CHAR (TO_DATE (:szhFecha,:szpFormatoFec),:szhFmtYYYYMMDD)
           AND ESTADO = :szhCodEstado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from PV_DET_SUSPVOLPROG_TO wher\
e ((NUM_ABONADO=:b1 and TO_CHAR(FEC_SUSPENSION,:b2)=TO_CHAR(TO_DATE(:b3,:b4),:\
b2)) and ESTADO=:b6)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1511;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCount;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhFmtYYYYMMDD;
    sqlstm.sqhstl[2] = (unsigned long )9;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szpFormatoFec;
    sqlstm.sqhstl[4] = (unsigned long )17;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFmtYYYYMMDD;
    sqlstm.sqhstl[5] = (unsigned long )9;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodEstado;
    sqlstm.sqhstl[6] = (unsigned long )4;
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



    if(!ihCount || sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szExeName, "\t* No se encontro el Abonado con suspencion voluntaria para el periodo %d %d", LOG05,ihCount, sqlca.sqlcode);
        return (FALSE);
    }

    return (TRUE);

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

