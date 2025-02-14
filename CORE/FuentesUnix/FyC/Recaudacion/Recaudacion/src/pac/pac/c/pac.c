
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
           char  filnam[12];
};
static const struct sqlcxp sqlfpn =
{
    11,
    "./pc/pac.pc"
};


static unsigned int sqlctx = 107779;


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
   unsigned char  *sqhstv[28];
   unsigned long  sqhstl[28];
            int   sqhsts[28];
            short *sqindv[28];
            int   sqinds[28];
   unsigned long  sqharm[28];
   unsigned long  *sqharc[28];
   unsigned short  sqadto[28];
   unsigned short  sqtdso[28];
} sqlstm = {12,28};

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
"select B.COD_BANCO ,A.COD_OPERADORA_SCL  from GE_OPERADORA_SCL A ,CO_SERVICI\
OPAC B where (B.COD_BANCO=:b0 and A.COD_OPERADORA_SCL=B.COD_OPERADORA_SCL) ord\
er by B.COD_BANCO            ";

 static const char *sq0010 = 
"select B.COD_BANCO ,A.COD_OPERADORA_SCL  from GE_OPERADORA_SCL A ,CO_SERVICI\
OPAC B where (B.COD_BANCO_GRP=:b0 and A.COD_OPERADORA_SCL=B.COD_OPERADORA_SCL)\
 order by B.COD_BANCO            ";

 static const char *sq0013 = 
"select COD_BANCO ,COD_CLIENTE  from CO_UNIPAC where COD_BANCO=:b0 order by C\
OD_CLIENTE            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,30,251,0,0,0,0,0,1,0,
20,0,0,2,138,0,4,364,0,0,5,4,0,1,0,1,97,0,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
55,0,0,3,138,0,4,390,0,0,5,4,0,1,0,1,97,0,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
90,0,0,4,138,0,4,409,0,0,5,4,0,1,0,1,97,0,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
125,0,0,5,621,0,6,445,0,0,20,20,0,1,0,2,3,0,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,
0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,2,5,0,0,
1,97,0,0,2,5,0,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,
220,0,0,6,196,0,4,623,0,0,12,8,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
283,0,0,7,139,0,4,653,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
306,0,0,8,135,0,4,667,0,0,2,1,0,1,0,2,3,0,0,1,5,0,0,
329,0,0,9,183,0,9,686,0,0,1,1,0,1,0,1,5,0,0,
348,0,0,10,187,0,9,700,0,0,1,1,0,1,0,1,5,0,0,
367,0,0,9,0,0,13,710,0,0,2,0,0,1,0,2,97,0,0,2,97,0,0,
390,0,0,10,0,0,13,713,0,0,2,0,0,1,0,2,97,0,0,2,97,0,0,
413,0,0,11,106,0,4,756,0,0,4,3,0,1,0,1,97,0,0,2,5,0,0,1,97,0,0,1,97,0,0,
444,0,0,9,0,0,15,785,0,0,0,0,0,1,0,
459,0,0,10,0,0,15,791,0,0,0,0,0,1,0,
474,0,0,12,56,0,6,849,0,0,2,2,0,1,0,2,4,0,0,1,3,0,0,
497,0,0,13,98,0,9,1045,0,0,1,1,0,1,0,1,5,0,0,
516,0,0,13,0,0,13,1052,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
539,0,0,13,0,0,15,1139,0,0,0,0,0,1,0,
554,0,0,14,392,0,4,1188,0,0,9,8,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,0,
1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
605,0,0,15,448,0,4,1262,0,0,10,8,0,1,0,1,3,0,0,2,5,0,0,2,3,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
660,0,0,16,264,0,5,1298,0,0,8,8,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,
707,0,0,17,41,0,2,1320,0,0,1,1,0,1,0,1,5,0,0,
726,0,0,18,235,0,4,1384,0,0,6,5,0,1,0,1,97,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,
765,0,0,19,807,0,4,1405,0,0,27,13,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,5,
0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,
5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,1,5,0,0,
1,5,0,0,1,97,0,0,1,5,0,0,
888,0,0,20,705,0,4,1548,0,0,28,11,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,5,0,0,2,5,
0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
4,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,4,0,0,2,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1015,0,0,21,287,0,4,1664,0,0,8,7,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,
1062,0,0,22,177,0,4,1732,0,0,6,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
1,3,0,0,
1101,0,0,23,109,0,3,1864,0,0,5,5,0,1,0,1,5,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,
1136,0,0,24,66,0,4,1968,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1159,0,0,25,151,0,4,1992,0,0,6,5,0,1,0,2,3,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,
1198,0,0,26,401,0,3,2010,0,0,20,20,0,1,0,1,5,0,0,1,97,0,0,1,5,0,0,1,3,0,0,1,3,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,4,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1293,0,0,27,93,0,5,2085,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
1316,0,0,28,183,0,4,2249,0,0,5,3,0,1,0,1,97,0,0,2,5,0,0,2,5,0,0,1,97,0,0,1,5,0,
0,
1351,0,0,29,249,0,4,2310,0,0,6,2,0,1,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,1,3,0,0,
1390,0,0,30,89,0,4,2328,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,97,0,0,
1417,0,0,31,219,0,4,2404,0,0,5,2,0,1,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,
0,
1452,0,0,32,89,0,4,2420,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,97,0,0,
1479,0,0,33,107,0,4,2484,0,0,3,2,0,1,0,1,97,0,0,2,5,0,0,1,3,0,0,
1506,0,0,34,272,0,4,2549,0,0,7,3,0,1,0,1,97,0,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,97,0,0,1,3,0,0,
1549,0,0,35,274,0,4,2626,0,0,7,3,0,1,0,1,97,0,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,97,0,0,1,3,0,0,
1592,0,0,36,222,0,4,2701,0,0,5,2,0,1,0,1,97,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,
0,
1627,0,0,37,125,0,4,2781,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
1658,0,0,38,322,0,4,2804,0,0,9,8,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1709,0,0,39,0,0,17,2834,0,0,1,1,0,1,0,1,5,0,0,
1728,0,0,39,0,0,45,2850,0,0,0,0,0,1,0,
1743,0,0,39,0,0,13,2858,0,0,1,0,0,1,0,2,4,0,0,
1762,0,0,40,125,0,4,2877,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
1793,0,0,41,317,0,4,3008,0,0,9,8,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
};


/*============================================================================
   Nombre     : Pac.pc
   Programa   : Pagos Automaticos de Cuentas
   Autor      : G.A.C  
  =============================================================================*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pasoc.h>
#include <unistd.h>
#include "pac.h"
 
/*---------------------------------------------------------------------------*/
/* Inclusion de	biblioteca para	manejo de interaccion con Oracle.	     	 */
/*---------------------------------------------------------------------------*/
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

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con	Oracle.		     	 */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int  iDecimal;
    int  ihIndicadorSaldo            ;
    int  ihIndicaUniversoPac         ;
    int  ihIndicaReprocesoPac        ;
    int  ihCod_Bcoi                  ;
    char szhFechaddmmyyyy [11]       ; /* EXEC SQL VAR szhFechaddmmyyyy         IS STRING(11); */ 

    char szhFecha_ddmmyyyy[11]       ; /* EXEC SQL VAR szhFecha_ddmmyyyy        IS STRING(11); */ 

    char szhHora_hhmmss   [9]        ; /* EXEC SQL VAR szhHora_hhmmss           IS STRING(9); */ 

    char szhFechaDD       [3]        ; /* EXEC SQL VAR szhFechaDD               IS STRING(3); */ 

    char szFecha1yyyymmdd [9]        ; /* EXEC SQL VAR szFecha1yyyymmdd         IS STRING(9); */ 

    char szFechayyyymmdd  [9]        ; /* EXEC SQL VAR szFechayyyymmdd          IS STRING(9); */ 

    char szFechayymm      [5]        ; /* EXEC SQL VAR szFechayymm              IS STRING(5); */ 

    char szFechayyyymm    [7]        ; /* EXEC SQL VAR szFechayyyymm            IS STRING(7); */ 

    char szFechaCargo     [7]        ; /* EXEC SQL VAR szFechaCargo             IS STRING(7); */ 

    char szhFormatoBanco  [7]        ; /* EXEC SQL VAR szhFormatoBanco          IS STRING(7); */ 

    char szhDescripcionCargo1[21]    ; /* EXEC SQL VAR szhDescripcionCargo1     IS STRING(21); */ 

    char szhDescripcionCargo2[21]    ; /* EXEC SQL VAR szhDescripcionCargo2     IS STRING(21); */ 

    char szhFecValor2         [9]    ; /* EXEC SQL VAR szhFecValor2             IS STRING(9); */ 

    char szhSeqPac           [13]    ; /* EXEC SQL VAR szhSeqPac 		     	 IS STRING(13); */ 
     
    char szhNum_TarjCtacte   [19]    ; /* EXEC SQL VAR szhNum_TarjCtacte  		 IS STRING(13); */ 
     
    char szhFec_Cancelacion   [7]    ; /* EXEC SQL VAR szhFec_Cancelacion		 IS STRING(7); */ 
     
    char szhDDMMYYYY         [11]    ; /* EXEC SQL VAR szhDDMMYYYY	             IS STRING(11); */ 
 
    char szhFecMMYYYY         [7]    ; /* EXEC SQL VAR szhFecMMYYYY	         IS STRING(7); */ 
 
    char szhFecYYMMDD         [7]    ; /* EXEC SQL VAR szhFecYYMMDD	         IS STRING(7); */ 
 
    char szhClaveEstablecimiento[21] ; /* EXEC SQL VAR szhClaveEstablecimiento IS STRING(21); */ 
 

	/* variables bind */    
 	char szhZero			[2];
 	char szhZeroUno         [3];
 	char szhAAA         	[4];
 	char szhBAA         	[4];
 	char szhBAP         	[4];
 	char szhFiller          [2];
 	char szhLetra_C         [2];
    char szhMMYY            [5];
    char szhYYYYMMDD        [9];
    char szh_ddmmyyyy      [11];
    char szhHH24miss       [11];
    char szhyymm	    	[5];
    char szhyyyymm          [7];
    char szhDDMMYY          [7];
    char szhdd_mm_yyyy     [11];
    char szhDD              [3];
    char szhMMYYYY          [7];       
    char szhYYMMDD          [7];
    int  ihValor_Veinte     ;
    int  ihValor_Dos        ;
    int  ihValor_Cero       ;
    int  ihValor_uno        ;
    int  ihValor_tres       ;
    int  ihValor_cuatro     ;
/* EXEC SQL END DECLARE SECTION; */ 
 

/*---------------------------------------------------------------------------*/
/* Definicion de estructuras globales 				             			 */
/*---------------------------------------------------------------------------*/
LINEACOMANDO stLineaComando;
ESTADISTICAS stEstadisticas;
char szFileDat      [150]   ="" ;
char szFileDatGUA1  [150]   ="" ;
char szHora[7];
FICBANCOS	 stFicBancos[iNum];
FA_HISTDOCU	 stHistPac;
UNIVERSO     stUniverso;

/*===========================================================================*/
/* Rutina Principal						             						 */
/*===========================================================================*/
int main(int argc, char *argv[])
{
char modulo[]="Main";
/*---------------------------------------------------------------------------*/
/* Variables Globales.							     						 */
/*---------------------------------------------------------------------------*/
int  iResultado, iFinProc=TRUE;
/*---------------------------------------------------------------------------*/
/* Inicializacion de variables.						     					 */
/*---------------------------------------------------------------------------*/
	lContRegPac   	 = 0;
	lNumOperaciones  = 0;
    lContRegAAA      = 0;  
	ihValor_Veinte   = 20;
	ihValor_Dos      = 2;
	ihValor_Cero     = 0;
	ihValor_uno      = 1;
	ihValor_tres     = 3;
	ihValor_cuatro   = 4;
	strcpy(szhZero      ,"0");
	strcpy(szhFiller    ," ");
	strcpy(szhLetra_C   ,"C");
	strcpy(szhMMYY      ,"MMYY");
	strcpy(szhYYYYMMDD  ,"YYYYMMDD");
	strcpy(szhDDMMYY    ,"DDMMYY");
	strcpy(szh_ddmmyyyy ,"ddmmyyyy");
	strcpy(szhHH24miss  ,"hh24:mi:ss");
	strcpy(szhyymm      ,"yymm");
	strcpy(szhyyyymm    ,"yyyymm");
	strcpy(szhDD        ,"DD");
	strcpy(szhdd_mm_yyyy,"dd/mm/yyyy");
	strcpy(szhZeroUno   ,"01");
	strcpy(szhAAA       ,"AAA");
	strcpy(szhBAA       ,"BAA");
	strcpy(szhBAP       ,"BAP");
    strcpy(szhDDMMYYYY  ,"DD-MM-YYYY");
    strcpy(szhMMYYYY    ,"MMYYYY");
    strcpy(szhYYMMDD    ,"YYMMDD");
	
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura	de linea de comando y de status del programa */
/*---------------------------------------------------------------------------*/
	memset( &stLineaComando	, 0, sizeof(LINEACOMANDO) );
	memset( &stStatus	    , 0, sizeof(STATUS) );
    memset( &stEstadisticas , 0, sizeof(ESTADISTICAS));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos	ingresados como	parametros externos.		     	 */
/*---------------------------------------------------------------------------*/
	iResultado = ifnManejaArgumentos(argc, argv);
  	if (iResultado != 0) exit(1);
/*---------------------------------------------------------------------------*/
/* Conexion a Oracle							     						 */
/*---------------------------------------------------------------------------*/	
	if( !bfnConnectORA( stLineaComando.szUser,stLineaComando.szPass ))	{
		fprintf(stdout, "\n\tUsuario/Passwd Invalido\n\t\t pac  <usuario> <passwd> \n       ");
		return FALSE;	
	} else	{
		fprintf(stdout, "\n\t--------------------------------------------------------------  "
			        	"\n\t* Conectado a ORACLE: Usuario %s Passwd xxxxxxxx   *  "
			        	"\n\t--------------------------------------------------------------\n",stLineaComando.szUser );
	}	
/*---------------------------------------------------------------------------*/
/* Inicializacion del Proceso PAC					     					 */
/*---------------------------------------------------------------------------*/		
	if (!bfnIniciarProcesoPac())	{
		printf("\n\t Error Iniciando el Proceso\n\n");
		return FALSE;
	}
/*---------------------------------------------------------------------------*/
/* Header.								     								 */
/*---------------------------------------------------------------------------*/	
    fprintf(stdout, "\nProcesando ...\n");                                        
    vDTrazasLog( modulo, "%s"      ,LOG03 , szRaya);                    
    vDTrazasLog( modulo, "FECHA            [%s]",LOG03 , szhFecha_ddmmyyyy);
    vDTrazasLog( modulo, "PROGRAMA         [%s]",LOG03 , LOGNAME    );                
    vDTrazasLog( modulo, "%s"                   ,LOG03 , GLOSA_PROG );                
    vDTrazasLog( modulo, "VERSION          [%s]",LOG03 , szhVersion );      
    vDTrazasLog( modulo, "Ultima Revision  [%s]",LOG03 , LAST_REVIEW);                
    vDTrazasLog( modulo, "%s\n"    ,LOG03, szRaya); 

    fprintf( stdout, "%s\n"      , szRaya);                    
    fprintf( stdout, "FECHA            [%s]\n", szhFecha_ddmmyyyy);
    fprintf( stdout, "PROGRAMA         [%s]\n", LOGNAME    );                
    fprintf( stdout, "%s\n"                   , GLOSA_PROG );                
    fprintf( stdout, "VERSION          [%s]\n", szhVersion );      
    fprintf( stdout, "Ultima Revision  [%s]\n", LAST_REVIEW);                
    fprintf( stdout, "%s\n"    , szRaya); 
/*---------------------------------------------------------------------------*/
/* Obtencion de Parametros						     						 */
/*---------------------------------------------------------------------------*/
    if (!bfnGedParametros())	{
		printf("\n\t Error al Obtener Parametros\n\n");
		return FALSE;
	}              
/*---------------------------------------------------------------------------*/
/* Proceso PAC  -  Principal						     					 */
/*---------------------------------------------------------------------------*/		    
	if (!bfnProcesoGenPac())	{
		vDTrazasLog( modulo, "\n\t---------------------------------------"
		"\n\t* Proceso NO termino Correctamente. *"
		"\n\t---------------------------------------\n",LOG03);
		iFinProc=FALSE;
		if (!bfnOraRollBack()) return FALSE; 		
	} else 	{
		if (!bfnOraCommit())	return FALSE; 
	}

	stEstadisticas.lContRegPac= lContRegPac;	
/*---------------------------------------------------------------------------*/
/* Desconexion de Oracle  					             					 */
/*---------------------------------------------------------------------------*/		    
	if (bfnDisconnectORA( 0 )) {
		vDTrazasLog( modulo,   "\t---------------------------------------"
				   			 "\n\t* Desconectado de  ORACLE             *" 
				   			 "\n\t---------------------------------------\n\n"
				   			,LOG03 );
	}
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion	estadistica del	proceso.     		         */
/*---------------------------------------------------------------------------*/
    vDTrazasLog( modulo,  "************************************************" , LOG03);									 
    vDTrazasLog( modulo,  "Estadistica del proceso", LOG03);			 
    vDTrazasLog( modulo,  "************************************************" , LOG03);									 
    vDTrazasLog( modulo,  "Cantidad de Registros del Universo     [%ld]", LOG03,stEstadisticas.lContRegPac);			       
    vDTrazasLog( modulo,  "Cantidad de Registros Procesados       [%ld]", LOG03,stEstadisticas.lContRegPac-stEstadisticas.lRegAnomalo-lContRegAAA);	
    vDTrazasLog( modulo,  "Cantidad de Registros Anomalos         [%ld]", LOG03,stEstadisticas.lRegAnomalo);	
    vDTrazasLog( modulo,  "Cantidad de Registros sin Abonados AAA [%ld]\n", LOG03,lContRegAAA);	
    if (iFinProc)  vDTrazasLog( modulo,  "Proceso [%s] finalizado Ok", LOG03,LOGNAME);
    vDTrazasLog( modulo,  "************************************************\n\n\n" , LOG03);									 
  
    if (iFinProc)  {
	    fprintf(stdout,	"================================================\n");									 
	    fprintf(stdout, "Estadistica del proceso\n");								 
	    fprintf(stdout,	"================================================\n");									 
	    fprintf(stdout, "Cantidad de Registros del Universo     [%ld]\n",stEstadisticas.lContRegPac);			       
	    fprintf(stdout, "Cantidad de Registros Procesados       [%ld]\n",stEstadisticas.lContRegPac-stEstadisticas.lRegAnomalo-lContRegAAA); 
	    fprintf(stdout, "Cantidad de Registros Anomalos         [%ld]\n",stEstadisticas.lRegAnomalo);			       
	    fprintf(stdout, "Cantidad de Registros sin Abonados AAA [%ld]\n\n",lContRegAAA); 
	    fprintf(stdout, "Proceso [%s] finalizado ok.\n\n\n", LOGNAME);
    } else 
	    fprintf(stdout,"\n\t* Proceso genero Anomalias. Favor Revisar. *\n\n");
    
    
/*---------------------------------------------------------------------------*/
/* Cierre de Archivo Banco   					                             */
/*---------------------------------------------------------------------------*/		    	
	fflush(FichBancos);
	fclose	(FichBancos);
	
/*---------------------------------------------------------------------------*/
/* Ordena Archivo Banco   					                                 */
/*---------------------------------------------------------------------------*/		    
  	if (stEstadisticas.lContRegPac-stEstadisticas.lRegAnomalo >0 && strcmp(stLineaComando.szCodBanco,"9999")==0 ){
		iResultado = ifnOrdenaArchivo();
  		if (iResultado != 0) exit(1);
    }	
/*---------------------------------------------------------------------------*/
/* Cierre de Archivos ERROR Y LOG   					                     */
/*---------------------------------------------------------------------------*/		    
	fclose(stStatus.LogFile );
	fclose(stStatus.ErrFile );

    /* EXEC SQL COMMIT	WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

													  
    return(0);
}/************************** Final main **************************************/

/*===========================================================================*/
/* Manejo de argumentos	ingresados como	parametros externos.		     	 */
/*===========================================================================*/
int ifnManejaArgumentos(int argc, char * const argv[])
{
char  modulo[]      = "ifnManejaArgumentos";
char  szUsuario[80] = ""    ;
char  *psztmp               ; 
char  opt[]         = "l:u:b:c:f:" ;

extern char *optarg        ;

BOOL  bArgumentou = FALSE;
BOOL  bArgumentob = FALSE;
BOOL  bArgumentoc = FALSE;
BOOL  bArgumentof = FALSE;
int   iOpt = 0 ;

	while( ( iOpt = getopt( argc, argv, opt ) ) != EOF )
	{
		switch( iOpt )
		{       
			case 'u':
				if(strlen(optarg)>0 )
				{
					strcpy(szUsuario,optarg);
					if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
					{
						fprintf (stderr, "\n\tUsuario Oracle no Valido\n%s\n",szUsage);
						return (1);
					}
					else
					{
						strncpy(stLineaComando.szUser,szUsuario,psztmp-szUsuario);
						strcpy (stLineaComando.szPass,psztmp+1);
					}
					bArgumentou=TRUE; 
				}
				break;  
			
			case 'f':
				if(strlen(optarg)>0 && strlen(optarg)<7)
				{
					stLineaComando.lCodCiclFact=atol(optarg);
					bArgumentof=TRUE; 
				}
				break;  
			
			case 'c':
				if(strlen(optarg)>0 && strlen(optarg)<16)
				{
					strcpy(stLineaComando.szCodBanco,optarg);
					bArgumentoc=TRUE; 
				}
				break;  
			
			case 'l':
				if(strlen(optarg)>0 && strlen(optarg)<2)
				{
					stStatus.LogNivel= atoi(optarg); 
				}
				break;  
			
			case 'b':
				if(strlen(optarg)>0  && strlen(optarg)<3)
				{
					strcpy(stLineaComando.szCicloBanco,optarg);
					bArgumentob=TRUE; 
				}
				break;
		}/* fin switch ... */
	}/* fin while */
	


	if (!bArgumentou || !bArgumentoc || !bArgumentof )	{
		fprintf(stdout,"%s",szUsage);
		return (3)                  ; 
	}
	
	if (stStatus.LogNivel <= 0 ) stStatus.LogNivel = 3; 
		
	return 0;
}/*vManejaArgumentos*/

/*===========================================================================*/
/* Obtencion de Parametros del Proceso 					     				 */
/*===========================================================================*/
BOOL bfnGedParametros()
{
char modulo[]="bfnGedParametros";
char szNulo        [2] ;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhINDICADOR_SALDO    [16];
	char szhModulo             [3];
	char szhINDICADOR_UNIPAC   [17];
	char szhREPROCESO_PAC      [14];
	int    iValorUno  = 1; /* Requerimiento de Soporte - #37161 29.01.2007 capc */
/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhModulo             ,"RE");
	strcpy(szhINDICADOR_SALDO    ,"INDICADOR_SALDO");
	strcpy(szhINDICADOR_UNIPAC   ,"INDICADOR_UNIPAC");
	strcpy(szhREPROCESO_PAC      ,"REPROCESO_PAC");

  	szNulo   [0]=' '; 
  	/*-----------------------------------------------------------------------*/
  	/* Obtencion de Indicador de Saldos				            			 */
  	/*-----------------------------------------------------------------------*/	
  	/* EXEC SQL
  	SELECT TO_NUMBER(NVL(VAL_PARAMETRO, :szhZero))  
  	INTO   :ihIndicadorSaldo
  	FROM   GED_PARAMETROS
	WHERE  NOM_PARAMETRO = :szhINDICADOR_SALDO
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :iValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_NUMBER(NVL(VAL_PARAMETRO,:b0)) into :b1  from GE\
D_PARAMETROS where ((NOM_PARAMETRO=:b2 and COD_MODULO=:b3) and COD_PRODUCTO=:b\
4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )20;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihIndicadorSaldo;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhINDICADOR_SALDO;
   sqlstm.sqhstl[2] = (unsigned long )16;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&iValorUno;
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

 /* Requerimiento de Soporte - #37161 29.01.2007 capc */

    /* Inicio Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */
  	if (SQLCODE==NOTFOUND )  {
  		    ihIndicadorSaldo = ihValor_Cero;
			/*iDError(modulo,ERR000,vInsertarIncidencia,"\t Indicador de Saldo No existe.\n\t\t\t\t ",SQLERRM);*/
			/*return FALSE;*/
	}       
	else if (SQLCODE != SQLOK) {
       		iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO INDICADOR_SALDO. ",SQLERRM);        
       		return FALSE;
  	}
    /* Fin Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */

  	vDTrazasLog(modulo,"\n\t=> Indicador Saldo [%d].",LOG03,ihIndicadorSaldo);

  
  	/*-----------------------------------------------------------------------*/
	/* Indicador de Universo PAC                                             */
  	/*-----------------------------------------------------------------------*/	    
  	/* EXEC SQL
	SELECT TO_NUMBER(NVL(VAL_PARAMETRO, :szhZero))  
	INTO   :ihIndicaUniversoPac
	FROM   GED_PARAMETROS
  	WHERE  NOM_PARAMETRO = :szhINDICADOR_UNIPAC
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :iValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_NUMBER(NVL(VAL_PARAMETRO,:b0)) into :b1  from GE\
D_PARAMETROS where ((NOM_PARAMETRO=:b2 and COD_MODULO=:b3) and COD_PRODUCTO=:b\
4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )55;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihIndicaUniversoPac;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhINDICADOR_UNIPAC;
   sqlstm.sqhstl[2] = (unsigned long )17;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&iValorUno;
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

 /* Requerimiento de Soporte - #37161 29.01.2007 capc */
   	if (SQLCODE == NOTFOUND) {
		ihIndicaUniversoPac = ihValor_Cero;
    	vDTrazasLog (modulo,"\t\t * Warning...Parametro INDICADOR_UNIPAC no existe en tabla GED_PARAMETROS, valor por defecto [%d]",LOG03, ihValor_Cero);
   	}
   	else if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO INDICADOR_UNIPAC. ",SQLERRM);        
        return FALSE;
   	}

  	/*-----------------------------------------------------------------------*/
	/* Indicador de Reproceso PAC                                            */
  	/*-----------------------------------------------------------------------*/	    
  	/* EXEC SQL
	SELECT TO_NUMBER(NVL(VAL_PARAMETRO, :szhZero))  
	INTO   :ihIndicaReprocesoPac
	FROM   GED_PARAMETROS
  	WHERE  NOM_PARAMETRO = :szhREPROCESO_PAC
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :iValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_NUMBER(NVL(VAL_PARAMETRO,:b0)) into :b1  from GE\
D_PARAMETROS where ((NOM_PARAMETRO=:b2 and COD_MODULO=:b3) and COD_PRODUCTO=:b\
4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )90;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihIndicaReprocesoPac;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhREPROCESO_PAC;
   sqlstm.sqhstl[2] = (unsigned long )14;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&iValorUno;
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

 /* Requerimiento de Soporte - #37161 29.01.2007 capc */
   	if (SQLCODE == NOTFOUND) {
		ihIndicaReprocesoPac = ihValor_Cero;
    	vDTrazasLog (modulo,"\t\t * Warning...Parametro REPROCESO_PAC no existe en tabla GED_PARAMETROS, valor por defecto [%d]",LOG03, ihValor_Cero);
   	}
   	else if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO REPROCESO_PAC. ",SQLERRM);        
        return FALSE;
   	}

  	return TRUE;
}/*bfnGedParametros*/

/*===========================================================================*/
/* Inicializacion del Proceso PAC. Conexion a Oracle, inicializacion de      */
/* archivos log															 	 */
/*===========================================================================*/
BOOL bfnIniciarProcesoPac()
{
char modulo[]="bfnIniciarProcesoPac";
char szFileBanco[60] = "";

	/*-----------------------------------------------------------------------*/
	/* Obtencion y tratamiento de Fecha para ser utilizada en archivos       */
	/*-----------------------------------------------------------------------*/	
	strcpy( szTime, cfnGetTimePac() );
	strncpy(szHora,&szTime[8],13);
	/*-----------------------------------------------------------------------*/
	/* Obtenemos la Fecha y hora del Sistema y Numero de decimales a tratar  */
	/*-----------------------------------------------------------------------*/
	/* EXEC SQL EXECUTE
		BEGIN
			:iDecimal         :=GE_PAC_GENERAL.PARAM_GENERAL('num_decimal');
			:szhFechaddmmyyyy :=TO_CHAR(SYSDATE	,:szh_ddmmyyyy);
	         	:szhHora_hhmmss   :=TO_CHAR(SYSDATE	,:szhHH24miss);
	         	:szFechayyyymmdd  :=TO_CHAR(SYSDATE	,:szhYYYYMMDD)  ;
	         	:szFechayymm      :=TO_CHAR(SYSDATE	,:szhyymm)      ;         	
	         	:szFechaCargo     :=TO_CHAR(SYSDATE	,:szhDDMMYY)   ;
	         	:szhFecha_ddmmyyyy:=TO_CHAR(SYSDATE	,:szhdd_mm_yyyy);
	         	:szhFechaDD       :=TO_CHAR(SYSDATE	,:szhDD)        ;
		   	:szFecha1yyyymmdd :=TO_CHAR(SYSDATE+1,:szhYYYYMMDD) ; 
		   	:szhFecMMYYYY     :=TO_CHAR(SYSDATE,:szhMMYYYY) ; 
		   	:szhFecYYMMDD     :=TO_CHAR(SYSDATE,:szhYYMMDD) ;
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :iDecimal := GE_PAC_GENERAL . PARAM_GENERAL ( 'num_dec\
imal' ) ; :szhFechaddmmyyyy := TO_CHAR ( SYSDATE , :szh_ddmmyyyy ) ; :szhHora_\
hhmmss := TO_CHAR ( SYSDATE , :szhHH24miss ) ; :szFechayyyymmdd := TO_CHAR ( S\
YSDATE , :szhYYYYMMDD ) ; :szFechayymm := TO_CHAR ( SYSDATE , :szhyymm ) ; :sz\
FechaCargo := TO_CHAR ( SYSDATE , :szhDDMMYY ) ; :szhFecha_ddmmyyyy := TO_CHAR\
 ( SYSDATE , :szhdd_mm_yyyy ) ; :szhFechaDD := TO_CHAR ( SYSDATE , :szhDD ) ; \
:szFecha1yyyymmdd := TO_CHAR ( SYSDATE + 1 , :szhYYYYMMDD ) ; :szhFecMMYYYY :=\
 TO_CHAR ( SYSDATE , :szhMMYYYY ) ; :szhFecYYMMDD := TO_CHAR ( SYSDATE , :szhY\
YMMDD ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )125;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iDecimal;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFechaddmmyyyy;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szh_ddmmyyyy;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhHora_hhmmss;
 sqlstm.sqhstl[3] = (unsigned long )9;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhHH24miss;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szFechayyyymmdd;
 sqlstm.sqhstl[5] = (unsigned long )9;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[6] = (unsigned long )9;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szFechayymm;
 sqlstm.sqhstl[7] = (unsigned long )5;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhyymm;
 sqlstm.sqhstl[8] = (unsigned long )5;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szFechaCargo;
 sqlstm.sqhstl[9] = (unsigned long )7;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhDDMMYY;
 sqlstm.sqhstl[10] = (unsigned long )7;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhFecha_ddmmyyyy;
 sqlstm.sqhstl[11] = (unsigned long )11;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhdd_mm_yyyy;
 sqlstm.sqhstl[12] = (unsigned long )11;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhFechaDD;
 sqlstm.sqhstl[13] = (unsigned long )3;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhDD;
 sqlstm.sqhstl[14] = (unsigned long )3;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szFecha1yyyymmdd;
 sqlstm.sqhstl[15] = (unsigned long )9;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)szhFecMMYYYY;
 sqlstm.sqhstl[16] = (unsigned long )7;
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)szhMMYYYY;
 sqlstm.sqhstl[17] = (unsigned long )7;
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)szhFecYYMMDD;
 sqlstm.sqhstl[18] = (unsigned long )7;
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)szhYYMMDD;
 sqlstm.sqhstl[19] = (unsigned long )7;
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



	if (SQLCODE!=SQLOK )  {
		iDError(modulo,ERR000,vInsertarIncidencia,"\nNumero Decimal y Fecha.\n\t ",SQLERRM);
		return FALSE;
	}       


	/*-----------------------------------------------------------------------*/
    /* Generando nombre de archivo PAC									 */
	/*-----------------------------------------------------------------------*/
  	sprintf(szFilePac,"PAC_TM%s_%s.txt",szhFecYYMMDD,szHora);    
	/*-----------------------------------------------------------------------*/
    /* Inicializacion de Archivos LOG										 */
	/*-----------------------------------------------------------------------*/
  	if (ifnAbreArchivosLog(0)!=0) return FALSE;

	vDTrazasError( modulo, "\n\t***************************************************************"
					 	  "\n\t%s  PACC. Proceso Automatico C.C.          Hora : %s      "
						  "\n\t***************************************************************\n\n",LOG03,szhVersion,szhHora_hhmmss);	

	strcpy(stLineaComando.szNomFicPac,szFileBanco);

	return TRUE;
}/* bfnIniciarProcesoPac */

/*===========================================================================*/
/* Funcion que abre los archivos de log y de error                           */
/*===========================================================================*/
int ifnAbreArchivosLog(int iTipfile)
{
char modulo[]="ifnAbreArchivosLog";
char *pathDir               ;
char szComando  [128]   ="" ;
char szPathLog  [128]   ="" ;

   /*-----------------------------------------------------------------------*/
   /* Inicializacion de estructura	de archivo								*/
   /*-----------------------------------------------------------------------*/
	memset(szArchivo,'\0',sizeof(szArchivo));

	sprintf(szArchivo,"pac%s",szTime);
	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

	if (iTipfile == 0) {
		sprintf(szPathLog  ,"%s/LOG/Recaudacion/Pac/%s",pathDir,szFechayyyymmdd);
		free(pathDir);
		sprintf(szComando,"/usr/bin/mkdir -p %s", szPathLog);
		system (szComando);
	
		sprintf(stStatus.ErrName,"%s/%s.err",szPathLog,szArchivo);
		if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL ){
		    fprintf( stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		    return -1;
		}
	
		sprintf(stStatus.LogName,"%s/%s.log",szPathLog,szArchivo);
		if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) {
		    fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
	    	return -1;
	   }
    
	} else {
		sprintf(szPathDat  ,"%s/DAT/Recaudacion/%s",pathDir,szFechayyyymmdd);		
		free(pathDir);
		sprintf(szComando,"/usr/bin/mkdir -p %s", szPathDat);
		system (szComando);
	
		sprintf(szFileDat,"%s/%s\0",szPathDat,szFilePac);
		vDTrazasLog( modulo, "\n\t Fichero PAC : %s\n\n\n", LOG07, szFileDat);
		if( ( FichBancos = fopen( szFileDat,"w" ) ) == (FILE*)NULL )  {
		    vDTrazasError(modulo, "\t\t### Error: No puede abrirse el fichero para enviar al Banco\n\n\t [%s]\n", LOG01, szFilePac );
			return -1;
		}
	}
	
   return 0;
}/* ifnAbreArchivosLog */

/*===========================================================================*/
/* Proceso Principal PAC							                         */
/*===========================================================================*/
BOOL bfnProcesoGenPac()
{
/*---------------------------------------------------------------------------*/
/* Inicializacion de Variables  										 	 */
/*---------------------------------------------------------------------------*/
char  modulo[]="bfnProcesoGenPac";
int	  iFinCursorOperadora = 0;
int   iResultado          = 0;
int   iFormato            = 0;
int   i;
long  lhCicloFact;
char  szCod_Servicio     [11];
long  iLastRows    ;
int   iFetchedRows = MAXFETCH;
int   iRetrievRows = MAXFETCH;
char  szhCodOperadora    [6] ;
char  szhCodBanco        [16]; 
char  szhNewCodBanco     [16];

/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

static 	char szhCicloCelu     [4] ; /* EXEC SQL VAR szhCicloCelu    IS STRING(4); */ 

	   	char szhCod_Banco     [16]; /* EXEC SQL VAR szhCod_Banco    IS STRING(16); */ 

	   	char szhFecValor      [15]; /* EXEC SQL VAR szhFecValor     IS STRING(15); */ 

	   	char szhCod_Servicio  [11]; /* EXEC SQL VAR szhCod_Servicio IS STRING(11); */ 

	   	char szhFecVencto     [15]; /* EXEC SQL VAR szhFecVencto    IS STRING(15); */ 

	   	char szhOperadora     [MAXFETCH][6] ;
	   	char szhCodBancoPar   [MAXFETCH][16]; 
		long lhCodBanco;
	    long lMaxFetch ; 
	    char szhYYYYMMDDHHMISS [17];
	    int  ihValor_Quince    ;        	    
		int  ihValor_Cuatro    ;
		int  ihValor_Cinco     ;
		int  ihCuentaAgrupado  ; 
		int	 ihCuentaNoAgrupado; 
/* EXEC SQL END DECLARE SECTION; */ 


	
    vDTrazasLog(modulo,	"\n\t* Parametros de Entrada a (bfnProcesoGenPac)"
						"\n\t=> Nombre Usuario: [%s]"
						"\n\t=> Password      : [xxxxxx]"
						"\n\t=> Ciclo Fact    : [%ld]"
						"\n\t=> Cod Banco     : [%s]"
						"\n\t=> Ciclo Banco   : [%s]"
						"\n\t=> Nombre Fichero: [%s]"
						,LOG03
						,stLineaComando.szUser
						,stLineaComando.lCodCiclFact
						,stLineaComando.szCodBanco
						,stLineaComando.szCicloBanco
						,stLineaComando.szNomFicPac);
	
	/*---------------------------------------------------------------------------*/
	/* Inicializacion de estructuras de Bancos								     */
	/*---------------------------------------------------------------------------*/	
	memset( szhCod_Banco, '\0', sizeof( szhCod_Banco ) );	
	strcpy( szhCod_Banco, stLineaComando.szCodBanco );
	strcpy(szhYYYYMMDDHHMISS,"YYYYMMDDHH24MISS");
	ihValor_Quince = 15;
	ihValor_Cuatro = 4;
	ihValor_Cinco  = 5;
	lhCodBanco = atol( stLineaComando.szCodBanco );
	for( i = 0; i < iNum; i++ ) 	{
		memset( &stFicBancos[i], 0, sizeof( FICBANCOS ) ); 
		stFicBancos[i].final = TRUE;
	}

	/*---------------------------------------------------------------------------*/
	/* Carga la estructura de manejo de decimales para la operadora local        */
	/*---------------------------------------------------------------------------*/	
	if (!bGetParamDecimales())	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar carga de bGetParamDecimales().\n\t\t\t\t ",SQLERRM);
	    return -1;
	}    

	/*---------------------------------------------------------------------------*/
	/* Obtencion de datos del Ciclo de Facturacion 						         */
	/*---------------------------------------------------------------------------*/	
	/* EXEC SQL 
	SELECT  TO_CHAR(SYSDATE,:szhYYYYMMDDHHMISS),
			TO_CHAR(FA_SEQ_PAC.NEXTVAL)        ,
			TO_CHAR(DECODE(COD_CICLO, :ihValor_Quince, :ihValor_Cuatro, :ihValor_Veinte, :ihValor_Cinco, :ihValor_Dos)), 
            TO_CHAR(FEC_VENCIMIE,:szhYYYYMMDD)
	INTO	:szhFecValor  ,
			:szhSeqPac    ,
			:szhCicloCelu , 
			:szhFecVencto 
	FROM 	FA_CICLFACT
	WHERE   COD_CICLFACT = :stLineaComando.lCodCiclFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,:b0) ,TO_CHAR(FA_SEQ_PAC.nextval ) ,T\
O_CHAR(DECODE(COD_CICLO,:b1,:b2,:b3,:b4,:b5)) ,TO_CHAR(FEC_VENCIMIE,:b6) into \
:b7,:b8,:b9,:b10  from FA_CICLFACT where COD_CICLFACT=:b11";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )220;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDDHHMISS;
 sqlstm.sqhstl[0] = (unsigned long )17;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Quince;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Cuatro;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Veinte;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cinco;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Dos;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[6] = (unsigned long )9;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhFecValor;
 sqlstm.sqhstl[7] = (unsigned long )15;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhSeqPac;
 sqlstm.sqhstl[8] = (unsigned long )13;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhCicloCelu;
 sqlstm.sqhstl[9] = (unsigned long )4;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhFecVencto;
 sqlstm.sqhstl[10] = (unsigned long )15;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&(stLineaComando.lCodCiclFact);
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


	
	if (SQLCODE!=SQLOK ) {
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al Seleccionar Fecha y la Secuencia.\n\t\t\t\t ",SQLERRM);
		return FALSE;

	} else	{ 
		strcpy(stHistPac.szFecValor,szhFecValor) ;
		lhCicloFact = stLineaComando.lCodCiclFact;
		strcpy(szhFecVenctoCiclo, szhFecVencto);
	}

    /*---------------------------------------------------------------------------*/
	/* Validacion Banco a procesar			         				 			 */
	/*---------------------------------------------------------------------------*/	
	ihCuentaAgrupado    = 0;
	ihCuentaNoAgrupado  = 0;
	lMaxFetch   = MAXFETCH;
	iLastRows   = 0;

	/* EXEC SQL
	SELECT COUNT(1) 
	INTO   :ihCuentaAgrupado
    	FROM   GE_OPERADORA_SCL A, CO_SERVICIOPAC B
	WHERE  B.COD_BANCO_GRP     = :szhCod_Banco
	AND    A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from GE_OPERADORA_SCL A ,CO_SERVIC\
IOPAC B where (B.COD_BANCO_GRP=:b1 and A.COD_OPERADORA_SCL=B.COD_OPERADORA_SCL\
)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )283;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCuentaAgrupado;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Banco;
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


	
	if (SQLCODE!=SQLOK)	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Consulta en GE_OPERADORA_SCL.\n\t\t\t\t ",SQLERRM);
		return -1;
	} /* end if (SQLCODE!=SQLOK) */

	if (ihCuentaAgrupado == 0)	{
		vDTrazasLog(modulo,"\t\t  Proceso Banco No Agrupado .",LOG03);
		/* EXEC SQL
		SELECT COUNT(1) 
		INTO   :ihCuentaNoAgrupado
    		FROM   GE_OPERADORA_SCL A, CO_SERVICIOPAC B
		WHERE  B.COD_BANCO     = :szhCod_Banco
		AND    A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(1) into :b0  from GE_OPERADORA_SCL A ,CO_SERVI\
CIOPAC B where (B.COD_BANCO=:b1 and A.COD_OPERADORA_SCL=B.COD_OPERADORA_SCL)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )306;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCuentaNoAgrupado;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Banco;
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



		if (ihCuentaNoAgrupado == 0)	{ 
			iDError(modulo,ERR000,vInsertarIncidencia,"\t No Existe BANCO - ",SQLERRM);
			return FALSE;
		} /* if (ihCuentaNoAgrupado == 0) */

  		/* EXEC SQL DECLARE CUR_OPERADORA_NO CURSOR FOR      
		SELECT B.COD_BANCO, A.COD_OPERADORA_SCL    
  		FROM   GE_OPERADORA_SCL A, CO_SERVICIOPAC B
		WHERE  B.COD_BANCO         = :szhCod_Banco
		AND    A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL
		ORDER BY B.COD_BANCO; */ 
	
              
  		/* EXEC SQL OPEN CUR_OPERADORA_NO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )329;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Banco;
    sqlstm.sqhstl[0] = (unsigned long )16;
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

      
		if (SQLCODE!=SQLOK)	{
			iDError(modulo,ERR000,vInsertarIncidencia,"\t en OPEN Cursor CUR_OPERADORA_NO.\n\t\t\t\t ",SQLERRM);
			return -1;
		} /* end if (SQLCODE!=SQLOK) */
	} else {
		vDTrazasLog(modulo,"\t\t  Proceso Bancos Agrupados .",LOG03);
  		/* EXEC SQL DECLARE CUR_OPERADORA CURSOR FOR      
		SELECT B.COD_BANCO, A.COD_OPERADORA_SCL    
  		FROM   GE_OPERADORA_SCL A, CO_SERVICIOPAC B
		WHERE  B.COD_BANCO_GRP     = :szhCod_Banco
		AND    A.COD_OPERADORA_SCL = B.COD_OPERADORA_SCL
		ORDER BY B.COD_BANCO; */ 
	
              
  		/* EXEC SQL OPEN CUR_OPERADORA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0010;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )348;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Banco;
    sqlstm.sqhstl[0] = (unsigned long )16;
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

      
		if (SQLCODE!=SQLOK)	{
			iDError(modulo,ERR000,vInsertarIncidencia,"\t en OPEN Cursor CUR_OPERADORA.\n\t\t\t\t ",SQLERRM);
			return -1;
		} /* end if (SQLCODE!=SQLOK)	*/
	} /* end if (ihCuentaAgrupado == 0)	*/

   	while (iFetchedRows == iRetrievRows)
   	{
			if (ihCuentaNoAgrupado > 0)	{
				/* EXEC SQL for :lMaxFetch  FETCH CUR_OPERADORA_NO
        			INTO :szhCodBancoPar, :szhOperadora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )lMaxFetch;
    sqlstm.offset = (unsigned int  )367;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodBancoPar;
    sqlstm.sqhstl[0] = (unsigned long )16;
    sqlstm.sqhsts[0] = (         int  )16;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhOperadora;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


			} else {
				/* EXEC SQL 
				for :lMaxFetch  FETCH CUR_OPERADORA 
        		INTO  :szhCodBancoPar, 
				  	  :szhOperadora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )lMaxFetch;
    sqlstm.offset = (unsigned int  )390;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodBancoPar;
    sqlstm.sqhstl[0] = (unsigned long )16;
    sqlstm.sqhsts[0] = (         int  )16;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhOperadora;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


			} /* end if (ihCuentaNoAgrupado > 0)	*/

			iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
         		iLastRows    = sqlca.sqlerrd[2];
			vDTrazasLog(modulo,"\t\t iLastRows  [%d].",LOG03,iLastRows);
             
         for (i=0; i < iRetrievRows; i++)
         {                
				strcpy (szhCodBanco    , szhCodBancoPar[i]);
				strcpy (szhCodOperadora, szhOperadora[i]);
				RighTrim(szhCodBanco);
				RighTrim(szhCodOperadora);
				vDTrazasLog(modulo,"\n\t *******************************************************",LOG03);
		    	vDTrazasLog(modulo,"\t\t Registro Banco  ====>  [%d].",LOG03,i);
				vDTrazasLog(modulo,"\t\t CodBanco        ====>  [%s].",LOG03,szhCodBanco);
				vDTrazasLog(modulo,"\t\t Operadora       ====>  [%s].",LOG03,szhCodOperadora);
	
				/*--------------------------------------------------------------*/
				/* Obtencion del Formato del Banco 								*/
				/*--------------------------------------------------------------*/
				if (iFormato == 0 && strcmp(szhCod_Banco,"9999")!=0  && ihCuentaNoAgrupado == 0)  {

					/*----------------------------------------------------------*/
					/* Inicializacion de estructura de Formato de Archivo,      */
					/* Servicio y Banco      								    */
					/*----------------------------------------------------------*/
					memset(&szFormatoBanco,'\0',sizeof(szFormatoBanco));
					if (ifnFormatoPac(szhCod_Banco, szFormatoBanco, szCod_Servicio, szhCodOperadora)!=0) 
						break;
	
					iFormato = 1;
				}
	
				/*--------------------------------------------------------------*/
				/* Obtencion COD_SERVICIO					  					*/
				/*--------------------------------------------------------------*/	
				memset(&szCod_Servicio,'\0',sizeof(szCod_Servicio));
				memset(&szhNewCodBanco,'\0',sizeof(szhNewCodBanco));
	
		    	/* EXEC SQL 
				SELECT NVL(COD_SERVICIO,:szhFiller)
				INTO   :szhCod_Servicio
				FROM   CO_SERVICIOPAC
				WHERE  COD_BANCO	     = :szhCodBanco
				AND    COD_OPERADORA_SCL = :szhCodOperadora; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 20;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select NVL(COD_SERVICIO,:b0) into :b1  from CO_SERVICI\
OPAC where (COD_BANCO=:b2 and COD_OPERADORA_SCL=:b3)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )413;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhFiller;
       sqlstm.sqhstl[0] = (unsigned long )2;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Servicio;
       sqlstm.sqhstl[1] = (unsigned long )11;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szhCodBanco;
       sqlstm.sqhstl[2] = (unsigned long )16;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)szhCodOperadora;
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
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
				if (SQLCODE!=SQLOK ) {
					iDError(modulo,ERR000,vInsertarIncidencia,"\t Al Seleccionar Codigo de Servicio.\n\t\t\t\t ",SQLERRM);
					break;
				}
	
				/*-----------------------------------------------------------------------*/
				/* Asigna codigo de servicio a variable que almacena el codigo de banco  */
				/*-----------------------------------------------------------------------*/
	    		sprintf(szhNewCodBanco,"%s\0",szhCod_Servicio);
	
		    	vDTrazasLog(modulo,"\t\t Banco              ====>  [%s].",LOG03,szhCodBanco);
	    		vDTrazasLog(modulo,"\t\t Codigo de Servicio ====>  [%s].",LOG03,szhCod_Servicio);
				
				iResultado = ifnProcesaPAC(lhCicloFact, szhCodOperadora, szhCodBanco, szhCicloCelu, szhNewCodBanco);
				
		} /* end for */
	} /* end while */

	/*---------------------------------------------------------------------------*/
	/*	Cierra cursor CUR_OPERADORA												 */
	/*---------------------------------------------------------------------------*/	
	if (ihCuentaNoAgrupado > 0)	{	
		/* EXEC SQL CLOSE CUR_OPERADORA_NO; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )444;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		if (SQLCODE )  {
			iDError(modulo,ERR000,vInsertarIncidencia,"\t En CLOSE CUR_OPERADORA_NO.\n\t\t\t\t ",SQLERRM);
			return FALSE;
		}
	} else {
		/* EXEC SQL CLOSE CUR_OPERADORA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )459;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		if (SQLCODE )  {
			iDError(modulo,ERR000,vInsertarIncidencia,"\t En CLOSE CUR_OPERADORA.\n\t\t\t\t ",SQLERRM);
			return FALSE;
		}
	} /* end if (ihCuentaNoAgrupado == 0)*/

	/*-----------------------------------------------------------------------*/
	/*	Si iResultado = 0 quiere decir que la ultima Iteracion vaciamos la   */
	/*  estructura si no Debemos vaciarla en el fichero                      */
	/*-----------------------------------------------------------------------*/
	if (iResultado > 0 )  {       

		if( !bfnInsertFic( stFicBancos, szhCodBanco , szhCodOperadora) ) return FALSE;
		
	}

	if (iResultado < 0) return -1;

	return TRUE;
} /* bfnProcesoGenPac */

/*===========================================================================*/
/*Funcion: ifnProcesaUniverso                                                */
/*===========================================================================*/
int ifnProcesaUniverso(UNIVERSO *pstUniverso, char *pszCicloCelu, char *pszOperadora)
{
char    modulo[]="ifnProcesaUniverso";
long    i        = 0;
double  dTotDebe = 0;
char 	szhCicloCelu  [4]; 
char    szhOperadora  [6];
int	    iControlFunciones; 
int	    iAumentarCont;
char    szhProcedenciaRegistro[2];
int     iRespuesta;  /* Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	double dhSaldo;
	long   lhCod_Cliente;
	int    ihValor_Tres;
/* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhCicloCelu, pszCicloCelu); 
    ihValor_Tres=3;
	strcpy(szhOperadora, pszOperadora);
	lhCod_Cliente=pstUniverso->lCodCliente;
	/*---------------------------------------------------------------------------*/
	/* Traspasando los datos recuperados a las estructuras 						 */
	/*---------------------------------------------------------------------------*/	
	strcpy( stHistPac.szCodBanco, pstUniverso->szCodBanco );
	
	/* Inicio Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */
	/* Obtencion de Saldos                                                 */			
	/* 0 = Monto del documento a cobrar    (Valor por defecto)             */			
	/* 1 = Saldo actual de la cartera                                      */			
	/* 2 = Saldo de la cartera hasta la fecha de emision del documento     */			
	if (ihIndicadorSaldo == 1) {
	
		/* EXEC SQL EXECUTE
    		BEGIN
    			:dhSaldo:=CO_SALDO_FN(:lhCod_Cliente) ;
			END;
		END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin :dhSaldo := CO_SALDO_FN ( :lhCod_Cliente ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )474;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhSaldo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Cliente;
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


		
		if (SQLCODE!=SQLOK )  {
			iDError(modulo,ERR000,vInsertarIncidencia,"\nCalcular Saldo(1)\n\t ",SQLERRM);
			return -1;				
		}
		pstUniverso->dImpDebe = dhSaldo;
	} /* end IF (ihIndicadorSaldo == 1) {*/							

	if (ihIndicadorSaldo == 2) {
		
		iRespuesta = ifnSaldoVencido(lhCod_Cliente, pstUniverso->szFec_emision, &dhSaldo);	
			
		if (iRespuesta != 0 )  {
			iDError(modulo,ERR000,vInsertarIncidencia,"\nCalcular Saldo(2)\n\t ",SQLERRM);
			return -1;				
		}
		pstUniverso->dImpDebe = dhSaldo;
		
	} /* end IF (ihIndicadorSaldo == 2) {*/							
	/* Fin Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */
				
	vDTrazasLog( modulo, "\t lhNumFolio [%ld]",LOG03,pstUniverso->lNumFolio);		
	vDTrazasLog( modulo, "\t dhImpDebe  [%f] ",LOG03,pstUniverso->dImpDebe);	
		
	if (pstUniverso->lNumFolio > 0 && pstUniverso->dImpDebe > 0  ) {
				    
        vDTrazasLog( modulo, "\n\t Traspasando Datos..\n",LOG03);		
		strcpy( stHistPac.szRowid, pstUniverso->szRowid);
		strcpy( stHistPac.szLetra, ( pstUniverso->isLetra == -1 ) ? "" : pstUniverso->szLetra );
				
		strcpy( stHistPac.szCodVendAgent , pstUniverso->szCodVendAgent);
		strcpy( stHistPac.szCodTipDocum  , pstUniverso->szCodTipDocum );
		strcpy( stHistPac.szNomUsuarOra  , pstUniverso->szNomUsuarOra );
		strcpy( stHistPac.szSeqPac       , szhSeqPac        );
		strcpy( stHistPac.szCod_Operadora, pstUniverso->szCodOperadora);
		strcpy( stHistPac.szCod_Plaza    , pstUniverso->szCodPlaza    );
		strcpy( stHistPac.szPref_Plaza   , pstUniverso->szPrefPlaza   );
		strcpy( stHistPac.szCodTipDocu   , pstUniverso->szCodTipDocum );
		strcpy( szhProcedenciaRegistro   , pstUniverso->szProcedenciaReg); 
      	strcpy( stHistPac.szFec_emision  , pstUniverso->szFec_emision);
				
		if (pstUniverso->isFecVencimie != ORA_NULL ) {
			strcpy(stHistPac.szFecVencimie,pstUniverso->szFecVencimie);
			strcpy(szhFecValor2,pstUniverso->szFecVencimie);
			strcpy(szhFec_Cancelacion,pstUniverso->szFec_Cancela);
			
		} else {

			strcpy(stHistPac.szFecVencimie,"");
			strcpy(szhFec_Cancelacion," ");
		}
				
		stHistPac.lCodCliente  = pstUniverso->lCodCliente  ;
		stHistPac.lNumSecuencia= pstUniverso->lNumSecuencia;
		stHistPac.iCodCentremi = pstUniverso->iCodCentremi ;
		stHistPac.lNumFolio    = pstUniverso->lNumFolio    ;
		stHistPac.dImpDebe     = pstUniverso->dImpDebe     ;
		stHistPac.lCodCiclFact = pstUniverso->lCicloFact   ;
		stHistPac.dTot_Factura = pstUniverso->dTotFactura  ;
		stHistPac.dIvas        = pstUniverso->dIva         ;
		
		iControlFunciones = ifnLlenarStBancosPac( &stHistPac, stFicBancos, &iAumentarCont );
				
		if (iControlFunciones != SQLOK		&& 	iControlFunciones != NOTFOUND	&&
			iControlFunciones != -1			&&	iControlFunciones !=  1 )
			return -1;
				
		if (iControlFunciones == NOTFOUND || iControlFunciones == -1)  {       
			/*---------------------------------------------------------------------------*/
			/* Escribiriamos los datos en la tabla de anomalias FA_ANOPAC                */
			/*---------------------------------------------------------------------------*/						
			if (!bfnDBInsertAno(&stHistPac) )
				return -1;

		    } else {			    
				strcpy(stFicBancos[lCon].szCicloBanco , stLineaComando.szCicloBanco); 
				strcpy(stFicBancos[lCon].szCodBanco   , stHistPac.szCodBanco       ); 
				strcpy(stFicBancos[lCon].szciclocelu  , szhCicloCelu               );  
				strcpy(stFicBancos[lCon].szNewCodBanco, pstUniverso->szNewCodBanco );  
				strcpy(stFicBancos[lCon].szFecVencimie, stHistPac.szFecVencimie    ); 
				/* solo si se cambio de cliente, aumentamos el contador del array bancos */
				if (iAumentarCont ) lCon++;
						
				dTotDebe = dTotDebe + pstUniverso->dImpDebe;


				/*---------------------------------------------------------------------------*/
				/* Escribimos en la Base de Datos                                            */
				/*---------------------------------------------------------------------------*/						
				if (!bfnDBInsertPagosPac(&stHistPac))	return -1;
				stFicBancos[lCon].iClienteProcesado = stHistPac.iClienteExiste;

				if (strcmp(szhProcedenciaRegistro,"F")==0)  {   
					if (stHistPac.iClienteExiste == 0) { /* Si el registro no existe en la tabla CO_PAGOSPAC*/
						/*---------------------------------------------------------------------------*/
						/* Si el registro es obtenido desde la FA_HISTDOCU, se debe actualizar	     */
						/* Actualizando FA_HISTDOCU Con el Valor de La Secuencia.                    */
						/*---------------------------------------------------------------------------*/	
                		vDTrazasLog( modulo, "\n\t Entrando a bfnDBUpdateHistDocu",LOG03);
						if (!bfnDBUpdateHistDocu( &stHistPac ) )	return -1;
					} /* end if (stHistPac->iClienteExiste == 0) */
				} /* end if (strcmp(szhProcedenciaRegistro,"F")==0) */
			} /* end if (!bfnDBInsertAno(&stHistPac) )*/
	
			/*---------------------------------------------------------------------------*/
			/* Condicionamos la escritura en el Fichero con las condiciones de Numero de */
			/* Registros es iNum o se ha llegado al Final de los datos                   */
			/*---------------------------------------------------------------------------*/	
				
			/*---------------------------------------------------------------------------*/				
			/* Bucle en la Funcion bfnInsertFic () va de 0 a n-1                         */
			/* Ponemos a iNum -2 ya que siempre tendremos que dejar al final uno libre 	 */
			/*---------------------------------------------------------------------------*/
			if( lCon > ( iNum - 2 ) ) {
                vDTrazasLog( modulo, "\n\t Entrando a bfnInsertFic",LOG03);
				/*---------------------------------------------------------------------------*/
				/* si la variable esta vacia no insertamos en co_pagospac                    */
				/*---------------------------------------------------------------------------*/						
				if( !bfnInsertFic( stFicBancos, stHistPac.szCodBanco , szhOperadora ) )
						return -1;

				for( i = 0; i < iNum; i++ )  {        
					memset(&stFicBancos[i],0,sizeof(FICBANCOS));
					stFicBancos[i].final = TRUE;
				}
				lCon = 0;
			}
	} else {
		
        vDTrazasLog( modulo, "El Folio y/o Importe es menor que 1. Se contabiliza como registro Anomalo.",LOG02);
        lRegAno++;
		
	}/* fin if NumFolio > 0 */

	
	return 0;
}/*ifnProcesaUniverso*/

/*===========================================================================*/
/*Funcion: ifnProcesaPAC                                                     */
/*         Genera y llena estructura stHistPac por un determinado banco      */
/*===========================================================================*/
int ifnProcesaPAC(long plCicloFact, char *pszOperadora, char *pszCodBancoPar, char *pszCicloCelu,  char *pszNewCodBanco)
{
char modulo[]="ifnProcesaPAC";
char szhLetra_I     [3];
char szhOperadora   [6]; 
char szhNewCodBanco[16];
int  iFinCursorBanco= 0;
int  iResultadoHist = 0;
int  iResultadoCart = 0;
int  iResultadoUniv = 0;
int  iHayRegistro   = 0;
int  iResultadoRepr = 0;
int  iResultadoProc = 0;
char szhCicloCelu   [4];     
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long   lhCodCliente         ;
    long   lhCicloFact			;
	int    iVerificaHist        ;
	int    iVerificaCart        ;
    short  i_shCodBanco         ;
    char   szhCodBancoPar   [16]; /* EXEC SQL VAR szhCodBancoPar    IS STRING(16); */ 

    char   szhCodBanco      [16]; /* EXEC SQL VAR szhCodBanco       IS STRING(16); */ 

/* EXEC SQL END DECLARE SECTION; */ 


	lhCicloFact          = plCicloFact;
	strcpy(szhCodBancoPar, pszCodBancoPar);
  	strcpy(szhLetra_I,"I");
	strcpy(szhOperadora  , pszOperadora);
  	strcpy(szhNewCodBanco, pszNewCodBanco);
	strcpy(szhCicloCelu  , pszCicloCelu); 

    vDTrazasLog( modulo, "\n\t Ejecutando Query en ifnProcesaPAC con :",LOG03);		
    vDTrazasLog( modulo, "\t\t szhCodBancoPar     [%s]",LOG03,szhCodBancoPar);		
    vDTrazasLog( modulo, "\t\t szhCicloCelu       [%s]",LOG03,szhCicloCelu);		
    vDTrazasLog( modulo, "\t\t szhNewCodBanco     [%s]\n",LOG03,szhNewCodBanco);		

	/*---------------------------------------------------------------------------*/
	/* Seleccion del universo de datos a procesar  						         */
	/*---------------------------------------------------------------------------*/	
   /* EXEC SQL DECLARE CUR_UNIPAC CURSOR FOR      
   SELECT COD_BANCO , 
    	  COD_CLIENTE 
   FROM   CO_UNIPAC 
   WHERE  COD_BANCO = :szhCodBancoPar	/o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	ORDER BY COD_CLIENTE; */ 


	/* EXEC SQL OPEN CUR_UNIPAC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0013;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )497;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodBancoPar;
 sqlstm.sqhstl[0] = (unsigned long )16;
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


	if (SQLCODE)	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t en OPEN Cursor CUR_UNIPAC sobre CO_UNIPAC.\n\t\t\t\t ",SQLERRM);
		return -1;
	}

	do  {
		/* EXEC SQL FETCH CUR_UNIPAC 
		INTO :szhCodBanco :i_shCodBanco, :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )516;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodBanco;
  sqlstm.sqhstl[0] = (unsigned long )16;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)&i_shCodBanco;
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


	
		if (SQLCODE == NOTFOUND )  {
   		vDTrazasLog( modulo, "\t Fin de Clientes \n",LOG03);		
			iFinCursorBanco = 1;
		} else	{				
			if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  {
				iDError(modulo,ERR000,vInsertarIncidencia,"\t en FETCH del Cursor CUR_UNIPAC.\n\t\t\t\t ",SQLERRM);
				return -1;
			}

			iResultadoProc = 0;
        	vDTrazasLog( modulo, "\t ----------------------------",LOG03);		
			/*-------------------------------------------------------------------------*/
			/* Consulta registro a procesar, sino se utiliza reproceso no es necesario */
	        /*-------------------------------------------------------------------------*/	            
			if(ihIndicaReprocesoPac == 1) {
            			iResultadoProc = ifnVerificaRegProc(lhCodCliente, szhCodBanco, lhCicloFact, szhOperadora);
				vDTrazasLog( modulo, "\t iResultadoProc [%ld]",LOG03, iResultadoProc);		
			} else { iResultadoProc = 1;} 
            	
			/*-------------------------------------------------------------------------*/
			/* Liberando Cliente para Reproceso                                        */
	        /*-------------------------------------------------------------------------*/	            			
			if((ihIndicaReprocesoPac == 1) && (iResultadoProc == 1 )) {
				iResultadoRepr = ifnVerificaReproceso(lhCodCliente, szhCodBanco, lhCicloFact, szhLetra_I, szhOperadora);
				if(iResultadoRepr != 0 ) break;
			} /* end if(ihIndicaReprocesoPac == 1) */

			/*-------------------------------------------------------------------------*/
			/* Procesando Cliente                                                      */
	        /*-------------------------------------------------------------------------*/	            
        	vDTrazasLog( modulo, "\t ----------------------------",LOG03);		
			vDTrazasLog( modulo, "\t Procesando Cliente [%ld]....",LOG03, lhCodCliente);		

			/*-------------------------------------------------------------------------*/
			/* Consulta Cliente en la tabla FA_HISTDOCU                                */
	        /*-------------------------------------------------------------------------*/	            
			if(iResultadoProc == 1 ) {
				iHayRegistro = 0;
				/* Obteniendo datos desde FA_HISTDOCU */
         			iResultadoHist = ifnConsulta_FA_HISTDOCU(lhCodCliente, lhCicloFact, szhLetra_I, szhOperadora, i_shCodBanco, szhCodBanco, szhNewCodBanco);			
				if((iResultadoHist != 0 ) && (iResultadoHist != NOTFOUND ) ) break;
			} 
			/*-------------------------------------------------------------------------*/
			/* Consulta Cliente en la tabla CO_CARTERA                                 */
	        /*-------------------------------------------------------------------------*/	            
			/*if((iResultadoHist == NOTFOUND ) && (ihIndicaUniversoPac == 1) && (iResultadoProc == 1 ) ) { */ 
			/*Incidencia 137489*/
			if((iResultadoHist == NOTFOUND ) && (ihIndicadorSaldo == 1) && (iResultadoProc == 1 ) ) { 
				iVerificaHist = ifnVerificaReg_FA_HISTDOCU(lhCodCliente, lhCicloFact, szhLetra_I, szhOperadora);
				if (iVerificaHist == 0 ) {
					iResultadoCart = ifnConsulta_CO_CARTERA(lhCodCliente, lhCicloFact, i_shCodBanco, szhCodBanco, szhNewCodBanco);					
					if (iResultadoCart == NOTFOUND ) 
						iHayRegistro = 0;
					else {
						iHayRegistro = 1;
					}
				} else {
       				vDTrazasLog( modulo, "\t Registro ya procesado .... Continuamos con el siguiente alegremente....",LOG03);		
					iHayRegistro = 0;
				} /* end if (iVerificaHist == 0) */
			} else {
				if(iResultadoHist == 0 )  { 
					iHayRegistro = 1;
				}
            } /* end if (iResultadoHist == NOTFOUND) */
            	
			/*-------------------------------------------------------------------------*/
			/* Existe registro para ser procesado                                      */
	        /*-------------------------------------------------------------------------*/	
			if ((iHayRegistro == 1) && (iResultadoProc == 1 ))  {	
				iResultadoUniv = ifnProcesaUniverso(&stUniverso, szhCicloCelu, szhOperadora);	
				if (iResultadoUniv < 0) lRegAno++;            	
			} else { 
				vDTrazasLog( modulo, "\t ==>  Cliente [%ld], sin registro para procesar en FA_HISTDOCU y/o CO_CARTERA",LOG03, lhCodCliente);		
			} /* end if (iHayRegistro == 1) */
		}/* else SQLCODE == NOTFOUND */
        
	}while( iFinCursorBanco == 0);
		
    vDTrazasLog( modulo, "\n\n\t ====================>  Fin del Ciclo de Clientes  <====================\n\n",LOG03);		

	stEstadisticas.lContRegPac= lContRegPac;
	stEstadisticas.lRegAnomalo= lRegAno;

	/* EXEC SQL CLOSE CUR_UNIPAC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )539;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE )  {
		iDError(modulo,ERR000,vInsertarIncidencia,"\t En CLOSE CUR_UNIPAC sobre CO_UNIPAC.\n\t\t\t\t ",SQLERRM);
		return -1;
	}

	return lCon;
} /*ifnProcesaPAC*/

/*===========================================================================*/
/*Funcion: ifnVerificaRegProc                                                */
/*         Verifica si registro ya fue procesado                             */
/*===========================================================================*/
int ifnVerificaRegProc(long plCodCliente, char *pszCodBancoPar, long plCicloFact, char *pszOperadora)
{
char   modulo[]="ifnVerificaRegProc";
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente         ;
	long   lhCicloFact          ;
	long   ihIndProcesado       ;
    char   szhCodBanco      [16]; /* EXEC SQL VAR szhCodBanco       IS STRING(16); */ 

    char   szhCodOperadora   [6]; /* EXEC SQL VAR szhCodOperadora   IS STRING(6); */ 

    char   szhFecCiclo      [15]; /* EXEC SQL VAR szhFecCiclo       IS STRING(15); */ 

	char   szhCO_RESPUBANCO [14]; /* EXEC SQL VAR szhCO_RESPUBANCO  IS STRING(14); */ 

	char   szhCOD_RESPUBANCO[15]; /* EXEC SQL VAR szhCOD_RESPUBANCO IS STRING(15); */ 


/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog( modulo, "\t Verificando si registro ya fue procesado ",LOG03);		

    lhCodCliente = plCodCliente;
    lhCicloFact  = plCicloFact;

    strcpy(szhCodOperadora  ,pszOperadora);
    strcpy(szhCodBanco      ,pszCodBancoPar);
	strcpy(szhFecCiclo      , szhFecVenctoCiclo);
    strcpy(szhCO_RESPUBANCO ,"CO_RESPUBANCO");
    strcpy(szhCOD_RESPUBANCO,"COD_RESPUBANCO");

	vDTrazasLog( modulo, "\t 	lhCodCliente    [%ld] ",LOG03, lhCodCliente);		
	vDTrazasLog( modulo, "\t 	szhCodBanco     [%s] ",LOG03, szhCodBanco);		
	vDTrazasLog( modulo, "\t 	szhFecCiclo     [%s] ",LOG03, szhFecCiclo);		
	vDTrazasLog( modulo, "\t 	szhCodOperadora [%s] ",LOG03, szhCodOperadora);		

	ihIndProcesado  = 0;
	/* Consulta si el cliente ya fue procesado sin error */
	/* EXEC SQL
	SELECT TO_NUMBER(NVL(COD_RESPUBANCO, '0'))
    INTO   :ihIndProcesado
	FROM   CO_PAGOSPAC B
	WHERE  B.COD_CLIENTE+0 = :lhCodCliente	    /o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.COD_BANCO||'' = :szhCodBanco	    /o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.COD_TIPDOCUM > 0					/o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.FEC_VALOR > '01-JAN-1990'			/o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.FEC_VENCIMIE = TO_DATE(:szhFecCiclo, :szhYYYYMMDD)
	AND    B.COD_OPERADORA= :szhCodOperadora
    AND    B.IND_PROCESADO= :ihValor_uno
	AND    NOT EXISTS   (SELECT 1 
                    	 FROM   CO_CODIGOS
                         WHERE  NOM_TABLA   = :szhCO_RESPUBANCO
	                     AND    NOM_COLUMNA = :szhCOD_RESPUBANCO
	                     AND    COD_VALOR   = B.COD_RESPUBANCO); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_NUMBER(NVL(COD_RESPUBANCO,'0')) into :b0  from CO_\
PAGOSPAC B where ((((((((B.COD_CLIENTE+0)=:b1 and (B.COD_BANCO||'')=:b2) and B\
.COD_TIPDOCUM>0) and B.FEC_VALOR>'01-JAN-1990') and B.FEC_VENCIMIE=TO_DATE(:b3\
,:b4)) and B.COD_OPERADORA=:b5) and B.IND_PROCESADO=:b6) and  not exists (sele\
ct 1  from CO_CODIGOS where ((NOM_TABLA=:b7 and NOM_COLUMNA=:b8) and COD_VALOR\
=B.COD_RESPUBANCO)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )554;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIndProcesado;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[2] = (unsigned long )16;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecCiclo;
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[4] = (unsigned long )9;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodOperadora;
 sqlstm.sqhstl[5] = (unsigned long )6;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCO_RESPUBANCO;
 sqlstm.sqhstl[7] = (unsigned long )14;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhCOD_RESPUBANCO;
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



	if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar el SELECT sobre CO_PAGOSPAC(1).\n\t\t\t\t ",SQLERRM);
		return SQLCODE;
	}       
	
    if (SQLCODE == NOTFOUND )	ihIndProcesado = 1;

	vDTrazasLog( modulo, "\t 	ihIndProcesado [%ld] ",LOG03, ihIndProcesado);		

	return ihIndProcesado;

} /* end int ifnVerificaRegProc() */

/*===========================================================================*/
/*Funcion: ifnVerificaReproceso                                              */
/*         Verifica si registro debe ser reprocesado, llenando stUniverso    */
/*===========================================================================*/
int ifnVerificaReproceso(long plCodCliente, char *pszCodBancoPar, long plCicloFact, char *pszLetra, char *pszOperadora)
{
char   modulo[]="ifnVerificaReproceso";
int    iVerificaHist;
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente         ;
	long   ihRespubanco         ;
	long   lhCicloFact          ;

	char   szhCO_RESPUBANCO [14]; /* EXEC SQL VAR szhCO_RESPUBANCO  IS STRING(14); */ 

	char   szhCOD_RESPUBANCO[15]; /* EXEC SQL VAR szhCOD_RESPUBANCO IS STRING(15); */ 

    char   szhCodBanco      [16]; /* EXEC SQL VAR szhCodBanco       IS STRING(16); */ 

    char   szhRowid         [20]; /* EXEC SQL VAR szhRowid          IS STRING(20); */ 

    char   szhLetra          [3]; /* EXEC SQL VAR szhLetra          IS STRING(3); */ 

    char   szhCodOperadora   [6]; /* EXEC SQL VAR szhCodOperadora   IS STRING(6); */ 

    char   szhFecCiclo      [15]; /* EXEC SQL VAR szhFecCiclo       IS STRING(15); */ 

/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog( modulo, "\t Verificando Reproceso  ",LOG03);		

    lhCodCliente = plCodCliente;
    lhCicloFact  = plCicloFact;

    strcpy(szhCodOperadora  ,pszOperadora);
    strcpy(szhCodBanco      ,pszCodBancoPar);
    strcpy(szhLetra         ,pszLetra);
    strcpy(szhCO_RESPUBANCO ,"CO_RESPUBANCO");
    strcpy(szhCOD_RESPUBANCO,"COD_RESPUBANCO");
	strcpy(szhFecCiclo, szhFecVenctoCiclo);

	vDTrazasLog( modulo, "\t 	lhCodCliente    [%ld] ",LOG03, lhCodCliente);		
	vDTrazasLog( modulo, "\t 	szhCodBanco     [%s] ",LOG03, szhCodBanco);		
	vDTrazasLog( modulo, "\t 	szhFecCiclo     [%s] ",LOG03, szhFecCiclo);		
	vDTrazasLog( modulo, "\t 	szhCodOperadora [%s] ",LOG03, szhCodOperadora);		

	ihRespubanco  = 0;
	/* Toma el Universo de clientes pac rechazados por ciclo */
	/* EXEC SQL
	SELECT B.ROWID  ,  NVL(B.COD_RESPUBANCO,:ihValor_Cero)
    INTO   :szhRowid, :ihRespubanco
	FROM   CO_PAGOSPAC B
	WHERE  B.COD_CLIENTE+0 = :lhCodCliente	    /o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.COD_BANCO||'' = :szhCodBanco	    /o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.COD_TIPDOCUM > 0					/o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.FEC_VALOR > '01-JAN-1990'			/o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND    B.FEC_VENCIMIE = TO_DATE(:szhFecCiclo, :szhYYYYMMDD)
	AND    B.COD_OPERADORA= :szhCodOperadora
	AND  EXISTS   (SELECT 1
	               FROM  CO_RESPUBANCO
	         	   WHERE EXISTS (SELECT 1 
                    	  		 FROM   CO_CODIGOS
                                 WHERE  NOM_TABLA   = :szhCO_RESPUBANCO
	                             AND    NOM_COLUMNA = :szhCOD_RESPUBANCO
	                             AND    COD_VALOR   = B.COD_RESPUBANCO)
				   AND COD_RESPUBANCO = B.COD_RESPUBANCO); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select B.rowid  ,NVL(B.COD_RESPUBANCO,:b0) into :b1,:b2  fro\
m CO_PAGOSPAC B where (((((((B.COD_CLIENTE+0)=:b3 and (B.COD_BANCO||'')=:b4) a\
nd B.COD_TIPDOCUM>0) and B.FEC_VALOR>'01-JAN-1990') and B.FEC_VENCIMIE=TO_DATE\
(:b5,:b6)) and B.COD_OPERADORA=:b7) and exists (select 1  from CO_RESPUBANCO w\
here (exists (select 1  from CO_CODIGOS where ((NOM_TABLA=:b8 and NOM_COLUMNA=\
:b9) and COD_VALOR=B.COD_RESPUBANCO)) and COD_RESPUBANCO=B.COD_RESPUBANCO)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )605;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihRespubanco;
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
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[4] = (unsigned long )16;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecCiclo;
 sqlstm.sqhstl[5] = (unsigned long )15;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[6] = (unsigned long )9;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCodOperadora;
 sqlstm.sqhstl[7] = (unsigned long )6;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhCO_RESPUBANCO;
 sqlstm.sqhstl[8] = (unsigned long )14;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhCOD_RESPUBANCO;
 sqlstm.sqhstl[9] = (unsigned long )15;
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



	if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar el SELECT sobre CO_PAGOSPAC.\n\t\t\t\t ",SQLERRM);
		return SQLCODE;
	}       

	vDTrazasLog( modulo, "\t 	ihRespubanco    [%d] ",LOG03, ihRespubanco);	
	vDTrazasLog( modulo, "\t 	szhRowid        [%s] ",LOG03, szhRowid);		
	
	if (SQLCODE == NOTFOUND ) return 0;

	if (ihRespubanco > 0 )	{
        /*  Se prepara registro para ser reprocesado */
		iVerificaHist = 0;
        iVerificaHist = ifnVerificaReg_FA_HISTDOCU(lhCodCliente, lhCicloFact, szhLetra, szhCodOperadora);

		vDTrazasLog( modulo, "\t iVerificaHist  [%d] ",LOG03, iVerificaHist);		
		if (iVerificaHist > 0 )	{
			/* EXEC SQL
				UPDATE FA_HISTDOCU
				   SET SEQ_PAC = :ihValor_Cero
				WHERE LETRA          = :szhLetra	  
				AND   COD_CLIENTE    = :lhCodCliente
				AND   COD_CICLFACT   = :lhCicloFact
				AND	  SEQ_PAC        > :ihValor_Cero
				AND	  IND_SUPERTEL   = :ihValor_Cero
				AND   COD_OPERADORA  = :szhCodOperadora
    			AND  EXISTS (SELECT 1 
                 			 FROM  FA_TIPMOVIMIEN
		         			 WHERE COD_TIPMOVIMIEN = :ihValor_Dos	
		         			 AND   COD_TIPDOCUM    = COD_TIPDOCUM); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 20;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update FA_HISTDOCU  set SEQ_PAC=:b0 where ((((((LETRA=:b1 \
and COD_CLIENTE=:b2) and COD_CICLFACT=:b3) and SEQ_PAC>:b0) and IND_SUPERTEL=:\
b0) and COD_OPERADORA=:b6) and exists (select 1  from FA_TIPMOVIMIEN where (CO\
D_TIPMOVIMIEN=:b7 and COD_TIPDOCUM=COD_TIPDOCUM)))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )660;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhLetra;
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
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCicloFact;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhCodOperadora;
   sqlstm.sqhstl[6] = (unsigned long )6;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_Dos;
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

 							 
		
			if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
				iDError(modulo,ERR000,vInsertarIncidencia,"\t Al UPDATE sobre FA_HISTDOCU.\n\t\t\t\t ",SQLERRM);
				return SQLCODE;
			}       

		} /* end if */


		/* EXEC SQL
			delete FROM CO_PAGOSPAC	WHERE  ROWID = :szhRowid; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "delete  from CO_PAGOSPAC  where ROWID=:b0";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )707;
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



		if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
			iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar el DELETE sobre CO_PAGOSPAC.\n\t\t\t\t ",SQLERRM);
			return SQLCODE;
		} 
	} /* end if (ihRespubanco > 0 )*/      

	return 0;

} /* end int ifnVerificaReproceso() */

/*===========================================================================*/
/*Funcion: ifnConsulta_CO_CARTERA                                            */
/*         Consulta y llena estructura stUniverso desde la CO_CARTERA        */
/*===========================================================================*/
int ifnConsulta_CO_CARTERA(long plCodCliente, long plCicloFact, short psCodBanco, char *pszCodBancoPar, char *pszNewCodBanco)
{
char   modulo[]="ifnConsulta_CO_CARTERA";
char   szhProcedenciaReg [3]; 
char   szhNewCodBanco[16];
long   lhCicloFact         ;
short  i_shCodBanco        ;
char   szhCodBanco     [16]; 
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long   lhCodCliente         ;
	    long   lhNumSecuencia       ;
	    long   lhNumFolio           ;
	    int    ihCodCentremi        ;
		int    ihValor_Uno          ;
	    double dhImpDebe            ;
	    short  i_shLetra            ;
	    short  i_shFecVencimie      ;
	    double dhTot_Factura        ;
	    char   szhCodVendAgent   [7]; /* EXEC SQL VAR szhCodVendAgent   IS STRING(7); */ 

	    char   szhLetra          [3]; /* EXEC SQL VAR szhLetra          IS STRING(3); */ 

	    char   szhCodTipDocum    [3]; /* EXEC SQL VAR szhCodTipDocum    IS STRING(3); */ 

	    char   szhPref_Plaza    [26]; /* EXEC SQL VAR szhPref_Plaza     IS STRING(26); */ 

	    char   szhFecVencimie    [9]; /* EXEC SQL VAR szhFecVencimie    IS STRING(9); */ 
		
	    char   szhFecVencimieMax [9]; /* EXEC SQL VAR szhFecVencimieMax IS STRING(9); */ 
		
	    char   szhCod_Operadora  [6]; /* EXEC SQL VAR szhCod_Operadora  IS STRING(6); */ 

	    char   szhCod_Plaza      [6]; /* EXEC SQL VAR szhCod_Plaza      IS STRING(6); */ 

	    char   szhFec_Cancela    [7]; /* EXEC SQL VAR szhFec_Cancela    IS STRING(7); */ 

	    char   szhCO_CARTERA    [11]; /* EXEC SQL VAR szhCO_CARTERA     IS STRING(11); */ 

	    char   szhCOD_TIPDOCUM  [13]; /* EXEC SQL VAR szhCOD_TIPDOCUM   IS STRING(13); */ 

	    char   szhFec_Efectiv   [11]; /* EXEC SQL VAR szhFec_Efectiv    IS STRING(11); */ 
 
/* EXEC SQL END DECLARE SECTION; */ 


		vDTrazasLog( modulo, "\t Consultando la tabla CO_CARTERA ",LOG03);		
		lhCodCliente         = plCodCliente;
		lhCicloFact          = plCicloFact;
		i_shCodBanco		 = psCodBanco;
   	    strcpy(szhProcedenciaReg,"C");   /*Indica procedencia del registro C: CO_CARTERA*/  
		strcpy(szhCodBanco      , pszCodBancoPar); 
   	    strcpy(szhNewCodBanco   , pszNewCodBanco);
   	    strcpy(szhCO_CARTERA    , "CO_CARTERA");
   	    strcpy(szhCOD_TIPDOCUM  , "COD_TIPDOCUM");
		ihValor_Uno = 1;

		/* Maxima fecha de documento */
		/* EXEC SQL
		SELECT NVL(MAX(TO_CHAR(FEC_VENCIMIE,:szhYYYYMMDD)), '0')
		INTO  :szhFecVencimieMax
		FROM  CO_CARTERA
		WHERE COD_CLIENTE   = :lhCodCliente
		AND   IND_FACTURADO = :ihValor_Uno
		AND   NOT EXISTS  (SELECT 1
   		   		 	       FROM   CO_CODIGOS
   					       WHERE  NOM_TABLA   = :szhCO_CARTERA
   					       AND    NOM_COLUMNA = :szhCOD_TIPDOCUM
						   AND    COD_VALOR   = COD_TIPDOCUM); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(max(TO_CHAR(FEC_VENCIMIE,:b0)),'0') into :b1  fr\
om CO_CARTERA where ((COD_CLIENTE=:b2 and IND_FACTURADO=:b3) and  not exists (\
select 1  from CO_CODIGOS where ((NOM_TABLA=:b4 and NOM_COLUMNA=:b5) and COD_V\
ALOR=COD_TIPDOCUM)))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )726;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDD;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecVencimieMax;
  sqlstm.sqhstl[1] = (unsigned long )9;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Uno;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCO_CARTERA;
  sqlstm.sqhstl[4] = (unsigned long )11;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCOD_TIPDOCUM;
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

																 

		if (SQLCODE != SQLOK )	{
			iDError(modulo,ERR000,vInsertarIncidencia,"\t Al consultar maxima fecha de vencimiento sobre CO_CARTERA.\n\t\t\t\t ",SQLERRM);
			return SQLCODE;
		}       

		if (strcmp(szhFecVencimieMax, "0" )== 0) {
			return NOTFOUND;  
		} 

		/* EXEC SQL
		SELECT 	A.NUM_SECUENCI 							 ,
				TO_CHAR(A.COD_VENDEDOR_AGENTE)           ,
				A.LETRA		                             ,
				A.COD_CENTREMI                           ,
				TO_CHAR(A.COD_TIPDOCUM)                  ,
				A.NUM_FOLIO	   ,  A.PREF_PLAZA           ,
				MAX(TO_CHAR(A.FEC_VENCIMIE,:szhYYYYMMDD)),
				:ihValor_Cero                            , 
				A.COD_OPERADORA_SCL                      ,
				A.COD_PLAZA	   ,  :ihValor_Cero          ,
  				TO_CHAR(A.FEC_VENCIMIE,:szhDDMMYY)       , 
  				TO_CHAR(A.FEC_EFECTIVIDAD,:szhDDMMYYYY)       
		INTO    :lhNumSecuencia                     ,
				:szhCodVendAgent                    ,
				:szhLetra        :i_shLetra         ,
				:ihCodCentremi                      ,
				:szhCodTipDocum                     ,
				:lhNumFolio      , :szhPref_Plaza   ,
			    :szhFecVencimie  :i_shFecVencimie   ,
			    :dhImpDebe                          ,     
			    :szhCod_Operadora                   ,
			    :szhCod_Plaza    , :dhTot_Factura   ,
			    :szhFec_Cancela  		            ,			
			    :szhFec_Efectiv   
		FROM  CO_CARTERA A 
		WHERE A.COD_CLIENTE = :lhCodCliente
		AND   A.IND_FACTURADO = :ihValor_Uno
		AND   A.FEC_VENCIMIE  = TO_DATE(:szhFecVencimieMax,:szhYYYYMMDD)  
		AND   NOT EXISTS  (SELECT 1
   		   		 	       FROM   CO_CODIGOS
   					       WHERE  NOM_TABLA   = :szhCO_CARTERA
   					       AND    NOM_COLUMNA = :szhCOD_TIPDOCUM
						   AND    COD_VALOR   = A.COD_TIPDOCUM)																 
		AND   ROWNUM < 2
		GROUP BY A.COD_CLIENTE, A.NUM_SECUENCI, A.COD_VENDEDOR_AGENTE, 
   					 A.LETRA	  , A.COD_CENTREMI, A.COD_TIPDOCUM       , 
					 A.NUM_FOLIO  , A.PREF_PLAZA  , A.COD_OPERADORA_SCL  , 
					 A.COD_PLAZA  , TO_CHAR(A.FEC_VENCIMIE,:szhDDMMYY)   , 
					TO_CHAR(A.FEC_EFECTIVIDAD,:szhDDMMYYYY); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 27;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select A.NUM_SECUENCI ,TO_CHAR(A.COD_VENDEDOR_AGENTE) ,A.LE\
TRA ,A.COD_CENTREMI ,TO_CHAR(A.COD_TIPDOCUM) ,A.NUM_FOLIO ,A.PREF_PLAZA ,max(T\
O_CHAR(A.FEC_VENCIMIE,:b0)) ,:b1 ,A.COD_OPERADORA_SCL ,A.COD_PLAZA ,:b1 ,TO_CH\
AR(A.FEC_VENCIMIE,:b3) ,TO_CHAR(A.FEC_EFECTIVIDAD,:b4) into :b5,:b6,:b7:b8,:b9\
,:b10,:b11,:b12,:b13:b14,:b15,:b16,:b17,:b18,:b19,:b20  from CO_CARTERA A wher\
e ((((A.COD_CLIENTE=:b21 and A.IND_FACTURADO=:b22) and A.FEC_VENCIMIE=TO_DATE(\
:b23,:b0)) and  not exists (select 1  from CO_CODIGOS where ((NOM_TABLA=:b25 a\
nd NOM_COLUMNA=:b26) and COD_VALOR=A.COD_TIPDOCUM))) and ROWNUM<2) group by A.\
COD_CLIENTE,A.NUM_SECUENCI,A.COD_VENDEDOR_AGENTE,A.LETRA,A.COD_CENTREMI,A.COD_\
TIPDOCUM,A.NUM_FOLIO,A.PREF_PLAZA,A.COD_OPERADORA_SCL,A.COD_PLAZA,TO_CHAR(A.FE\
C_VENCIMIE,:b3),TO_CHAR(A.FEC_EFECTIVIDAD,:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )765;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDD;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Cero;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Cero;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhDDMMYY;
  sqlstm.sqhstl[3] = (unsigned long )7;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhDDMMYYYY;
  sqlstm.sqhstl[4] = (unsigned long )11;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuencia;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodVendAgent;
  sqlstm.sqhstl[6] = (unsigned long )7;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[7] = (unsigned long )3;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)&i_shLetra;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentremi;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhCodTipDocum;
  sqlstm.sqhstl[9] = (unsigned long )3;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&lhNumFolio;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhPref_Plaza;
  sqlstm.sqhstl[11] = (unsigned long )26;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhFecVencimie;
  sqlstm.sqhstl[12] = (unsigned long )9;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)&i_shFecVencimie;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&dhImpDebe;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhCod_Operadora;
  sqlstm.sqhstl[14] = (unsigned long )6;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhCod_Plaza;
  sqlstm.sqhstl[15] = (unsigned long )6;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)&dhTot_Factura;
  sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)szhFec_Cancela;
  sqlstm.sqhstl[17] = (unsigned long )7;
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)szhFec_Efectiv;
  sqlstm.sqhstl[18] = (unsigned long )11;
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)&ihValor_Uno;
  sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhFecVencimieMax;
  sqlstm.sqhstl[21] = (unsigned long )9;
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)szhYYYYMMDD;
  sqlstm.sqhstl[22] = (unsigned long )9;
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)szhCO_CARTERA;
  sqlstm.sqhstl[23] = (unsigned long )11;
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)szhCOD_TIPDOCUM;
  sqlstm.sqhstl[24] = (unsigned long )13;
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)szhDDMMYY;
  sqlstm.sqhstl[25] = (unsigned long )7;
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)szhDDMMYYYY;
  sqlstm.sqhstl[26] = (unsigned long )11;
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

   

		if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
			iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar el SELECT sobre CO_CARTERA.\n\t\t\t\t ",SQLERRM);
			return SQLCODE;
		}       
		
		if (SQLCODE == NOTFOUND ) {
			return NOTFOUND;  
		} else { 
			lContRegPac++;
		    vDTrazasLog( modulo, "\n\n\t *****************************************************************************",LOG03);		
		    vDTrazasLog( modulo, "\t        Procesando Registro desde CO_CARTERA  [%ld]  ",LOG03, lContRegPac);		
		    vDTrazasLog( modulo, "\t *****************************************************************************\n\n",LOG03);		
		
			stUniverso.lCicloFact    = lhCicloFact; 
			stUniverso.isCodBanco    = i_shCodBanco;
			stUniverso.lCodCliente   = lhCodCliente;
			stUniverso.lNumSecuencia = lhNumSecuencia;
			stUniverso.isLetra       = i_shLetra;
			stUniverso.iCodCentremi  = ihCodCentremi;
			stUniverso.lNumFolio     = lhNumFolio;
			stUniverso.isFecVencimie = i_shFecVencimie;
			stUniverso.dImpDebe      = dhImpDebe;
			stUniverso.dTotFactura   = dhTot_Factura;
			stUniverso.dSaldo        = dhTot_Factura;
			stUniverso.dIva          = 0;
		                     
			strcpy(stUniverso.szOperadora     , szhCod_Operadora);
			strcpy(stUniverso.szRowid         , " ");
			strcpy(stUniverso.szCodBanco      , szhCodBanco); 
			strcpy(stUniverso.szCodVendAgent  , szhCodVendAgent); 
			strcpy(stUniverso.szLetra         , szhLetra); 
			strcpy(stUniverso.szCodTipDocum   , szhCodTipDocum); 
			strcpy(stUniverso.szPrefPlaza     , szhPref_Plaza); 
			strcpy(stUniverso.szFecVencimie   , szhFecVencimie); 
			strcpy(stUniverso.szNomUsuarOra   , " "); 
			strcpy(stUniverso.szCodOperadora  , szhCod_Operadora); 
			strcpy(stUniverso.szCodPlaza      , szhCod_Plaza); 	
			strcpy(stUniverso.szNewCodBanco   , szhNewCodBanco); 
			strcpy(stUniverso.szFec_Cancela   , szhFec_Cancela);
			strcpy(stUniverso.szProcedenciaReg, szhProcedenciaReg);
			strcpy(stUniverso.szFec_emision   , szhFec_Efectiv);    
		} /* end if (SQLCODE == NOTFOUND ) */

		return 0;

} /* end ifnConsulta_CO_CARTERA */

/*===========================================================================*/
/*Funcion: ifnConsulta_FA_HISTDOCU                                           */
/*         Consulta y llena estructura stUniverso desde la FA_HISTDOCU       */
/*===========================================================================*/
int ifnConsulta_FA_HISTDOCU(long plCodCliente, long plCicloFact, char *psLetra, char *pszOperadora, short psCodBanco, char *pszCodBancoPar, char *pszNewCodBanco)
{
char modulo[]="ifnConsulta_FA_HISTDOCU";
char szhNewCodBanco[16];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long   lhNumSecuencia       ;
   long   lhNumFolio           ;
   long   lhCodCliente         ;
   long   lhCicloFact          ;
   int    ihCodCentremi        ;
   short  i_shLetra            ;
   short  i_shFecVencimie      ;
   short  i_shCodBanco         ;
   double dhImpDebe            ;
   double dhTot_Factura        ;
   double dhIva                ;
   char   szhRowid         [20]; /* EXEC SQL VAR szhRowid          IS STRING(20); */ 

   char   szhCodVendAgent   [7]; /* EXEC SQL VAR szhCodVendAgent   IS STRING(7); */ 

   char   szhCodLetra       [3]; /* EXEC SQL VAR szhCodLetra       IS STRING(3); */ 
 
   char   szhLetra          [3]; /* EXEC SQL VAR szhLetra          IS STRING(3); */ 

   char   szhCodTipDocum    [3]; /* EXEC SQL VAR szhCodTipDocum    IS STRING(3); */ 

   char   szhPref_Plaza    [26]; /* EXEC SQL VAR szhPref_Plaza     IS STRING(26); */ 

   char   szhFecVencimie    [9]; /* EXEC SQL VAR szhFecVencimie    IS STRING(9); */ 
		
   char   szhNomUsuarOra   [31]; /* EXEC SQL VAR szhNomUsuarOra    IS STRING(31); */ 

   char   szhCod_Operadora  [6]; /* EXEC SQL VAR szhCod_Operadora  IS STRING(6); */ 

   char   szhOperadora      [6]; /* EXEC SQL VAR szhOperadora      IS STRING(6); */ 

   char   szhCod_Plaza      [6]; /* EXEC SQL VAR szhCod_Plaza      IS STRING(6); */ 

   char   szhFec_Cancela    [7]; /* EXEC SQL VAR szhFec_Cancela    IS STRING(7); */ 

   char   szhProcedenciaReg [3]; /* EXEC SQL VAR szhProcedenciaReg IS STRING(3); */ 
 
   char   szhCodBanco      [16]; /* EXEC SQL VAR szhCodBanco       IS STRING(16); */ 

   char   szhFec_emision   [11]; /* EXEC SQL VAR szhFec_emision    IS STRING(11); */ 

/* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog( modulo, "\t Consultando la tabla FA_HISTDOCU ",LOG03);		
   lhCodCliente         = plCodCliente;
   lhCicloFact          = plCicloFact;
   i_shCodBanco		    = psCodBanco;
   strcpy(szhCodLetra      , psLetra);
   strcpy(szhOperadora     , pszOperadora); 
   strcpy(szhProcedenciaReg,"F");   /*Indica procedencia del registro F: FA_HISTDOCU*/  
   strcpy(szhCodBanco      , pszCodBancoPar); 
   strcpy(szhNewCodBanco   , pszNewCodBanco);

   vDTrazasLog( modulo, "\t 	lhCodCliente      [%ld] ",LOG03, lhCodCliente);
   vDTrazasLog( modulo, "\t 	lhCicloFact       [%ld] ",LOG03, lhCicloFact);
   vDTrazasLog( modulo, "\t 	szhCodLetra       [%s]  ",LOG03, szhCodLetra);
   vDTrazasLog( modulo, "\t 	szhOperadora      [%s]  ",LOG03, szhOperadora);

	/* EXEC SQL
	SELECT A.ROWID                             , 
           A.NUM_SECUENCI                      ,
           TO_CHAR(A.COD_VENDEDOR_AGENTE)      ,
           A.LETRA		                       , 
           A.COD_CENTREMI                      ,
           TO_CHAR(A.COD_TIPDOCUM)             ,
           A.NUM_FOLIO	   , A.PREF_PLAZA      ,
           TO_CHAR(A.FEC_VENCIMIE,:szhYYYYMMDD),
           A.NOM_USUARORA , A.TOT_PAGAR	       ,
           A.COD_OPERADORA                     ,
           A.COD_PLAZA	                       , 
           A.TOT_FACTURA                       ,
           TO_CHAR(A.FEC_VENCIMIE,:szhDDMMYY)  ,
           NVL(A.ACUM_IVA , :ihValor_Cero)     ,
           TO_CHAR(A.FEC_EMISION,:szhDDMMYYYY)
	INTO     :szhRowid                           ,
			 :lhNumSecuencia                     ,
			 :szhCodVendAgent                    ,
			 :szhLetra        :i_shLetra         ,
			 :ihCodCentremi                      ,
			 :szhCodTipDocum                     ,
			 :lhNumFolio      , :szhPref_Plaza   ,
		     :szhFecVencimie  :i_shFecVencimie   ,
		     :szhNomUsuarOra  , :dhImpDebe       ,
		     :szhCod_Operadora,
		     :szhCod_Plaza    , :dhTot_Factura   ,
		     :szhFec_Cancela                     ,
		     :dhIva                              ,
		     :szhFec_emision
    FROM   FA_HISTDOCU A 
    WHERE  A.LETRA          = :szhCodLetra
	AND    A.COD_CLIENTE    = :lhCodCliente
    AND	   A.COD_CICLFACT   = :lhCicloFact
    AND	   A.SEQ_PAC        = :ihValor_Cero
    AND	   A.IND_SUPERTEL   = :ihValor_Cero
    AND    A.COD_OPERADORA  = :szhOperadora
    AND  EXISTS (SELECT 1 FROM  FA_TIPMOVIMIEN WHERE COD_TIPMOVIMIEN = :ihValor_Dos	AND   COD_TIPDOCUM    = A.COD_TIPDOCUM) 							 
    ORDER BY A.COD_CLIENTE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.rowid  ,A.NUM_SECUENCI ,TO_CHAR(A.COD_VENDEDOR_AGEN\
TE) ,A.LETRA ,A.COD_CENTREMI ,TO_CHAR(A.COD_TIPDOCUM) ,A.NUM_FOLIO ,A.PREF_PLA\
ZA ,TO_CHAR(A.FEC_VENCIMIE,:b0) ,A.NOM_USUARORA ,A.TOT_PAGAR ,A.COD_OPERADORA \
,A.COD_PLAZA ,A.TOT_FACTURA ,TO_CHAR(A.FEC_VENCIMIE,:b1) ,NVL(A.ACUM_IVA,:b2) \
,TO_CHAR(A.FEC_EMISION,:b3) into :b4,:b5,:b6,:b7:b8,:b9,:b10,:b11,:b12,:b13:b1\
4,:b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22  from FA_HISTDOCU A where ((((((A.LE\
TRA=:b23 and A.COD_CLIENTE=:b24) and A.COD_CICLFACT=:b25) and A.SEQ_PAC=:b2) a\
nd A.IND_SUPERTEL=:b2) and A.COD_OPERADORA=:b28) and exists (select 1  from FA\
_TIPMOVIMIEN where (COD_TIPMOVIMIEN=:b29 and COD_TIPDOCUM=A.COD_TIPDOCUM))) or\
der by A.COD_CLIENTE ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )888;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYY;
 sqlstm.sqhstl[1] = (unsigned long )7;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhDDMMYYYY;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[4] = (unsigned long )20;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuencia;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhCodVendAgent;
 sqlstm.sqhstl[6] = (unsigned long )7;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[7] = (unsigned long )3;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)&i_shLetra;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentremi;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhCodTipDocum;
 sqlstm.sqhstl[9] = (unsigned long )3;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhPref_Plaza;
 sqlstm.sqhstl[11] = (unsigned long )26;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhFecVencimie;
 sqlstm.sqhstl[12] = (unsigned long )9;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)&i_shFecVencimie;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhNomUsuarOra;
 sqlstm.sqhstl[13] = (unsigned long )31;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&dhImpDebe;
 sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhCod_Operadora;
 sqlstm.sqhstl[15] = (unsigned long )6;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)szhCod_Plaza;
 sqlstm.sqhstl[16] = (unsigned long )6;
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&dhTot_Factura;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)szhFec_Cancela;
 sqlstm.sqhstl[18] = (unsigned long )7;
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)&dhIva;
 sqlstm.sqhstl[19] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)0;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)szhFec_emision;
 sqlstm.sqhstl[20] = (unsigned long )11;
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)0;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)szhCodLetra;
 sqlstm.sqhstl[21] = (unsigned long )3;
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)0;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)0;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)&lhCicloFact;
 sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)0;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)0;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[25] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)0;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)szhOperadora;
 sqlstm.sqhstl[26] = (unsigned long )6;
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)0;
 sqlstm.sqinds[26] = (         int  )0;
 sqlstm.sqharm[26] = (unsigned long )0;
 sqlstm.sqadto[26] = (unsigned short )0;
 sqlstm.sqtdso[26] = (unsigned short )0;
 sqlstm.sqhstv[27] = (unsigned char  *)&ihValor_Dos;
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


	
		if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
			iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar el SELECT sobre FA_HISTDOCU.\n\t\t\t\t ",SQLERRM);
			return SQLCODE;
		}       

		if (SQLCODE == NOTFOUND ) {
			return NOTFOUND;  
		} else { 

				lContRegPac++;
			    vDTrazasLog( modulo, "\n\n\t *****************************************************************************",LOG03);		
			    vDTrazasLog( modulo, "\t        Procesando Registro desde FA_HISTDOCU [%ld]  ",LOG03, lContRegPac);		
			    vDTrazasLog( modulo, "\t *****************************************************************************\n\n",LOG03);		
			
				stUniverso.lCicloFact    = lhCicloFact; 
				stUniverso.isCodBanco    = i_shCodBanco;
				stUniverso.lCodCliente   = lhCodCliente;
				stUniverso.lNumSecuencia = lhNumSecuencia;
				stUniverso.isLetra       = i_shLetra;
				stUniverso.iCodCentremi  = ihCodCentremi;
				stUniverso.lNumFolio     = lhNumFolio;
				stUniverso.isFecVencimie = i_shFecVencimie;
				stUniverso.dImpDebe      = dhImpDebe;
				stUniverso.dTotFactura   = dhTot_Factura;
				stUniverso.dSaldo        = dhTot_Factura;
				stUniverso.dIva          = dhIva;
			  	vDTrazasLog( modulo, "\t\t stUniverso.dTotFactura     [%f]",LOG07,stUniverso.dTotFactura);		
			  	vDTrazasLog( modulo, "\t\t stUniverso.dIva            [%f]",LOG07,stUniverso.dIva);		
			                     
				strcpy(stUniverso.szOperadora     , szhCod_Operadora);
				strcpy(stUniverso.szRowid         , szhRowid);
				strcpy(stUniverso.szCodBanco      , szhCodBanco); 
				strcpy(stUniverso.szCodVendAgent  , szhCodVendAgent); 
				strcpy(stUniverso.szLetra         , szhLetra); 
				strcpy(stUniverso.szCodTipDocum   , szhCodTipDocum); 
				strcpy(stUniverso.szPrefPlaza     , szhPref_Plaza); 
				strcpy(stUniverso.szFecVencimie   , szhFecVencimie); 
				strcpy(stUniverso.szNomUsuarOra   , szhNomUsuarOra); 
				strcpy(stUniverso.szCodOperadora  , szhCod_Operadora); 
				strcpy(stUniverso.szCodPlaza      , szhCod_Plaza); 	
				strcpy(stUniverso.szNewCodBanco   , szhNewCodBanco); 
				strcpy(stUniverso.szFec_Cancela   , szhFec_Cancela);
				strcpy(stUniverso.szProcedenciaReg, szhProcedenciaReg);
				strcpy(stUniverso.szFec_emision  , szhFec_emision);
			} /* end if (SQLCODE == NOTFOUND ) */

		return 0;

} /* end ifnConsulta_FA_HISTDOCU */

/*===========================================================================*/
/*Funcion: ifnVerificaReg_FA_HISTDOCU                                        */
/*         Verifica si registro ya fue procesado con anterioridad            */
/*===========================================================================*/
int ifnVerificaReg_FA_HISTDOCU(long plCodCliente, long plCicloFact, char *psLetra, char *pszOperadora )
{
char modulo[]="ifnVerificaReg_FA_HISTDOCU";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    int    iVerifica            ;
	    long   lhCodCliente         ;
	    long   lhCicloFact          ;
	    char   szhLetra          [3]; /* EXEC SQL VAR szhLetra          IS STRING(3); */ 

	    char   szhCodOperadora   [6]; /* EXEC SQL VAR szhCodOperadora   IS STRING(6); */ 

/* EXEC SQL END DECLARE SECTION; */ 


	lhCodCliente         = plCodCliente;
	lhCicloFact          = plCicloFact;
	strcpy(szhLetra       , psLetra);
	strcpy(szhCodOperadora, pszOperadora);
	iVerifica            = 0;

   vDTrazasLog( modulo, "\t 	lhCodCliente      [%ld] ",LOG03, lhCodCliente);
   vDTrazasLog( modulo, "\t 	lhCicloFact       [%ld] ",LOG03, lhCicloFact);
   vDTrazasLog( modulo, "\t 	szhLetra          [%s] ",LOG03, szhLetra);
   vDTrazasLog( modulo, "\t 	szhCodOperadora   [%s] ",LOG03, szhCodOperadora);
	/* Verificando que registro no haya sido procesado con anterioridad*/
	/* EXEC SQL
	SELECT  count(1)
	INTO    :iVerifica
	FROM  FA_HISTDOCU A 
	WHERE A.COD_CLIENTE    = :lhCodCliente	/o Requerimiento de Soporte - #37161 29.01.2007 capc o/
	AND	  A.LETRA          = :szhLetra
	AND	  A.COD_CICLFACT   = :lhCicloFact
	AND	  A.SEQ_PAC        > :ihValor_Cero
	AND	  A.IND_SUPERTEL   = :ihValor_Cero
	AND   A.COD_OPERADORA  = :szhCodOperadora
    AND  EXISTS (SELECT 1 
                 FROM  FA_TIPMOVIMIEN
		         WHERE COD_TIPMOVIMIEN = :ihValor_Dos	
		         AND   COD_TIPDOCUM    = A.COD_TIPDOCUM); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from FA_HISTDOCU A where ((((((A.C\
OD_CLIENTE=:b1 and A.LETRA=:b2) and A.COD_CICLFACT=:b3) and A.SEQ_PAC>:b4) and\
 A.IND_SUPERTEL=:b4) and A.COD_OPERADORA=:b6) and exists (select 1  from FA_TI\
PMOVIMIEN where (COD_TIPMOVIMIEN=:b7 and COD_TIPDOCUM=A.COD_TIPDOCUM)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1015;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iVerifica;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCicloFact;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhCodOperadora;
 sqlstm.sqhstl[6] = (unsigned long )6;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_Dos;
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


		
	if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al consultar FA_HISTDOCU.\n\t\t\t\t ",SQLERRM);
		return SQLCODE;
	}       

	vDTrazasLog( modulo, "\t 	Verificando registro en FA_HISTDOCU [%d]",LOG03, iVerifica);		
	return iVerifica;

} /* end ifnVerificaReg_FA_HISTDOCU */

/*===========================================================================*/
/*Funcion: ifnLlenarStBancosPac                                              */
/*         Llena un componente del array de  Structura de datos Fic que esta */
/*         preparada para insertar posteriormente en el fichero.             */
/*===========================================================================*/
int ifnLlenarStBancosPac( FA_HISTDOCU *pstHist, FICBANCOS *pstBancos, int *iAumentarCont )
{
/*---------------------------------------------------------------------------*/
/* Inicializacion de Variables  										 	 */
/*---------------------------------------------------------------------------*/
char 	modulo[]="ifnLlenarStBancosPac";
int   	punto ;
int   	signo ;
long	lConAux = lCon;
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	static long lhCodCliente      ;
	static char szhCodZona   [3]  ;  /* EXEC SQL VAR szhCodZona    IS STRING(3) ; */ 
  
	static char szhCodCentral[3]  ;  /* EXEC SQL VAR szhCodCentral IS STRING(3) ; */ 

	static char szhTelefono  [9]  ;  /* EXEC SQL VAR szhTelefono   IS STRING(9) ; */ 

	static char szhCodBanco  [16] ;  /* EXEC SQL VAR szhCodBanco   IS STRING(16); */ 
 
/* EXEC SQL END DECLARE SECTION; */ 
       
	
	vDTrazasLog( modulo,"\t* Parametros de Entrada a (ifnLlenarStBancosPac)"
						"\n\t\t => Cod Vendedor Agente  [%s] "
						"\n\t\t => Cod Banco .......... [%s]"
						"\n\t\t => Fecha Vencimiento .. [%s]"
						"\n\t\t => Tipo de Documento .. [%s]"
						"\n\t\t => Codigo Cliente    .. [%ld]",
						LOG03
						,pstHist->szCodVendAgent
						,pstHist->szCodBanco
						,pstHist->szFecVencimie
						,pstHist->szCodTipDocum
						,pstHist->lCodCliente);
	
	/*---------------------------------------------------------------------------*/
	/* Obtenci¢n de Datos del Cliente  										 	 */
	/*---------------------------------------------------------------------------*/	
	lhCodCliente = pstHist->lCodCliente;

	/* EXEC SQL
	SELECT /o+ index (CO_UNIPAC PK_CO_UNIPAC) o/ 
			COD_ZONA,
			COD_CENTRAL,
			TO_CHAR(NUM_TELEFONO),
			COD_BANCO ,
			COD_BCOI  
	INTO	:szhCodZona,
			:szhCodCentral,
			:szhTelefono,
			:szhCodBanco,
			:ihCod_Bcoi    
	FROM 	CO_UNIPAC
	WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (CO_UNIPAC PK_CO_UNIPAC)  +*/ COD_ZONA ,C\
OD_CENTRAL ,TO_CHAR(NUM_TELEFONO) ,COD_BANCO ,COD_BCOI into :b0,:b1,:b2,:b3,:b\
4  from CO_UNIPAC where COD_CLIENTE=:b5";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1062;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodZona;
 sqlstm.sqhstl[0] = (unsigned long )3;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodCentral;
 sqlstm.sqhstl[1] = (unsigned long )3;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhTelefono;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[3] = (unsigned long )16;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCod_Bcoi;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (SQLCODE != SQLOK && SQLCODE != NOTFOUND )	{
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al realizar el SELECT sobre CO_UNIPAC.\n\t\t\t\t ",SQLERRM);
		return SQLCODE;
	}       
	
	if (SQLCODE == NOTFOUND )
		return SQLCODE;
	else
	{
		if (strcmp(pstHist->szCodBanco,szhCodBanco) == 0)  { 

			if( lCon > 0 ) 					 /* solo si ya se ha insertado un cliente en la estructura bancos */
			{
				if( lhCodCliente == pstBancos[lCon - 1].lCodCliente )	           /* si se repite el cliente */
				{
					pstBancos[lCon - 1].dmontopago += pstHist->dImpDebe; /* se suman los importes del cliente */					
					*iAumentarCont = 0;
					lConAux--;

				} else {
					/* si no se repite se vacian sus datos a la estructura de bancos */
					strcpy( pstBancos[lCon].szCodZona     , szhCodZona           );
					strcpy( pstBancos[lCon].szcodcentral  , szhCodCentral        );
					strcpy( pstBancos[lCon].szCodBanco    , pstHist->szCodBanco  );
					strcpy( pstBancos[lCon].szPref_Plaza  , pstHist->szPref_Plaza);
		                        strcpy( pstBancos[lCon].szCod_TipDocum, pstHist->szCodTipDocu);
		                        strcpy( pstBancos[lCon].szFec_emision , pstHist->szFec_emision);
                                        
					pstBancos[lCon].iCodBcoi    = ihCod_Bcoi           ;				
					pstBancos[lCon].lCodCliente = lhCodCliente         ;
					pstBancos[lCon].dmontopago  = pstHist->dImpDebe    ;
					pstBancos[lCon].lNumFolio   = pstHist->lNumFolio   ;
					pstBancos[lCon].dTotFactura = pstHist->dTot_Factura;
					pstBancos[lCon].dBIva       = pstHist->dIvas       ;
					pstBancos[lCon].final       = FALSE                ; 
					*iAumentarCont = 1;
				}

			} else {

				strcpy( pstBancos[lCon].szCodZona   , szhCodZona            );
				strcpy( pstBancos[lCon].szcodcentral, szhCodCentral         );
				strcpy( pstBancos[lCon].szCodBanco  , pstHist->szCodBanco   );
				strcpy( pstBancos[lCon].szPref_Plaza, pstHist->szPref_Plaza );
                strcpy( pstBancos[lCon].szCod_TipDocum, pstHist->szCodTipDocu);
				strcpy( pstBancos[lCon].szFec_emision, pstHist->szFec_emision);

				pstBancos[lCon].iCodBcoi   = ihCod_Bcoi           ;
				pstBancos[lCon].lCodCliente= lhCodCliente         ;
				pstBancos[lCon].dmontopago = pstHist->dImpDebe    ;
				pstBancos[lCon].lNumFolio  = pstHist->lNumFolio   ;
    			pstBancos[lCon].dTotFactura= pstHist->dTot_Factura;
				pstBancos[lCon].final      = FALSE                ;   
				*iAumentarCont = 1;
			}
			
			vDTrazasLog( modulo, "\n\t* Se obtuvieron los siguientes los datos de CO_UNIPAC"
								"\n\t\t ==> Codigo Cliente ....... [%ld]"
								"\n\t\t ==> Codigo Zona  ......... [%s]"
								"\n\t\t ==> Codigo Banco ......... [%s]"
								"\n\t\t ==> Monto Pago   ......... [%f]"
								"\n\t\t ==> lCon         ......... [%d]"
								"\n\t* Datos sacados de FA_CICLFACT****",LOG05,
								lhCodCliente        ,
								pstBancos[lConAux].szCodZona,
								pstHist->szCodBanco ,
								pstBancos[lConAux].dmontopago,
								lCon ); 
								
			return SQLOK; 

	    } else {    
			
			vDTrazasLog(modulo,  "\n\tNo Hay Coincidencia entre "
								"COD_BANCO (FA_HISTCLIE<=>CO_UNIPAC)"  
								"\n\t\t ==> Codigo Cliente ...... [%ld]"
								"\n\t\t ==> Codigo Banco (HISTCLIE). [%s]"
								"\n\t\t ==> Codigo Banco (UNIPAC)... [%s]"
								,LOG03
								,lhCodCliente
								,pstHist->szCodBanco
								,szhCodBanco);
			return -1;
		}
	}
} /* ifnLlenarStBancosPac */

/*===========================================================================*/
/*Funcion: bfnDBInsertAno(HistDocu *pstHistPac)                              */
/*        Introduce en la Tabla FA_ANOPAC los datos que tendran efecto para  */
/*        controlar anomalias.                                               */     
/*===========================================================================*/
BOOL bfnDBInsertAno(FA_HISTDOCU *pstHistPac)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
char modulo[]="bfnDBInsertAno";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhSequPac   [13];   /* EXEC SQL VAR szhSequPac IS STRING (13); */ 

	long lhCodCliente     ;
	double dhImpDebe      ;
/* EXEC SQL END DECLARE SECTION; */ 

	
	vDTrazasLog( modulo, "\n\t*Parametros de Entrada ( bfnDBInsertAno )"
						"\n\t Numero de Secuencia : [%s] "
						"\n\t Cod Cliente         : [%ld]"
						"\n\t Importe Debe        : [%d] "
						,LOG03
						,pstHistPac->szSeqPac                
						,pstHistPac->lCodCliente   
						,pstHistPac->dImpDebe        );
	
	strcpy( szhSequPac, pstHistPac->szSeqPac      );
	lhCodCliente      = pstHistPac->lCodCliente    ;
	dhImpDebe         = pstHistPac->dImpDebe       ;
	
	/* EXEC SQL  
	INSERT INTO FA_ANOPAC 
		   (SEQ_PAC     , COD_CLIENTE   , TOT_IMPORTE )
	VALUES (:szhSequPac , :lhCodCliente , GE_PAC_GENERAL.REDONDEA(:dhImpDebe, :iDecimal, :ihValor_Cero)	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into FA_ANOPAC (SEQ_PAC,COD_CLIENTE,TOT_IMPORTE) valu\
es (:b0,:b1,GE_PAC_GENERAL.REDONDEA(:b2,:b3,:b4))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1101;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhSequPac;
 sqlstm.sqhstl[0] = (unsigned long )13;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&dhImpDebe;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&iDecimal;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
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


	
	if (SQLCODE)  {
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al Insertar en la Tabla FA_ANOPAC.\n\t\t\t\t ",SQLERRM);
		return FALSE;

	} else {
		vDTrazasLog( modulo,"\n\t----------------------------------------------------------"
							"\n\tHemos volcado la informacion en la Base de Datos FA_ANOPAC"
							"\n\t----------------------------------------------------------",LOG05);
		return TRUE;
	}
}/* Final bfnDBInsertAno */

/*===========================================================================*/
/*Funcion: bintroducebd(HistDocu stHistPac)                                  */
/*         Introduce en la Tabla CO_PAGOSPAC ls datos obtenidos  introducidos*/ 
/*         en la estructura stHistPac.                                       */
/*===========================================================================*/
BOOL bfnDBInsertPagosPac(FA_HISTDOCU *pstHistPac)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="bfnDBInsertPagosPac";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int    ihIndProcesado           ;
	int    ihIndCancelado           ;
	int    ihCodCentremi            ;  
	int    ihVerificaExistencia     ; 
	long   lhNumFolio               ; 
	long   lhCodCliente             ;
	long   lhNumSecuencia           ; 
	double dhImpDebe                ;                
	char   szhFecValor          [15]; /* EXEC SQL VAR szhFecValor 		IS STRING (15); */ 

	char   szhCodBanco          [16]; /* EXEC SQL VAR szhCodBanco 		IS STRING (16); */ 

	char   szhCodTipDocum        [3]; /* EXEC SQL VAR szhCodTipDocum 	IS STRING (3); */ 

	char   szhCodVendAgent       [7]; /* EXEC SQL VAR szhCodVendAgent 	IS STRING (7); */ 
 
	char   szhLetra              [2]; /* EXEC SQL VAR szhLetra        	IS STRING (2); */ 

	char   szhPref_Plaza        [26]; /* EXEC SQL VAR szhPref_Plaza 	IS STRING (26); */ 

	char   szhFecVencimie        [9]; /* EXEC SQL VAR szhFecVencimie 	IS STRING (9); */ 
	
	char   szhCod_Operadora      [6]; /* EXEC SQL VAR szhCod_Operadora IS STRING (6); */ 

	char   szhCod_Plaza          [6]; /* EXEC SQL VAR szhCod_Plaza 	IS STRING (6); */ 

	long   existe_abocel_AAA=0;
    char   szhFecCiclo          [15]; /* EXEC SQL VAR szhFecCiclo       IS STRING(15); */ 
 
/* EXEC SQL END DECLARE SECTION; */ 

	
	vDTrazasLog( modulo, "\n\n\t* Parametros de entrada en CO_PAGOSPAC"
						"\n\t=> FEC VALOR .............. [%s]"
						"\n\t=> COD_BANCO .............. [%s]"
						"\n\t=> CODCLIENTE ............. [%ld]"
						"\n\t=> NUM SECUENCIA .......... [%ld]"
						"\n\t=> TIP DOCUM  ............. [%s]"
						"\n\t=> COD VENDEDOR AGENTE .... [%s]"
						"\n\t=> LETRA .................. [%s]"
						"\n\t=> COD_CENTREMI ........... [%d]"
						"\n\t=> NUM FOLIO .............. [%ld]"
						"\n\t=> PREF_PLAZA ............. [%s]"
						"\n\t=> FEC VENCIMIENTO ........ [%s]"
						"\n\t=> IMPORTE DEBE ........... [%f]"
						"\n\t=> COD_OPERADORA .......... [%s]"
						"\n\t=> COD_PLAZA .............. [%s]"
                        "\n\t=> FEC_EMISION..............[%s]"
						,LOG04
						,pstHistPac->szFecValor
						,pstHistPac->szCodBanco
						,pstHistPac->lCodCliente
						,pstHistPac->lNumSecuencia
						,pstHistPac->szCodTipDocum
						,pstHistPac->szCodVendAgent
						,pstHistPac->szLetra
						,pstHistPac->iCodCentremi
						,pstHistPac->lNumFolio
						,pstHistPac->szPref_Plaza
						,pstHistPac->szFecVencimie
						,pstHistPac->dImpDebe
						,pstHistPac->szCod_Operadora
						,pstHistPac->szCod_Plaza
						,pstHistPac->szFec_emision);
	
	ihIndProcesado = 0 ;
	ihIndCancelado = 0 ;	
	
	strcpy(szhFecValor  ,    pstHistPac->szFecValor       );
	strcpy(szhCodBanco  ,    pstHistPac->szCodBanco       );
	strcpy(szhCod_Operadora, pstHistPac->szCod_Operadora  );
	strcpy(szhCod_Plaza ,    pstHistPac->szCod_Plaza      ); 
	strcpy(szhPref_Plaza,    pstHistPac->szPref_Plaza     ); 
	
	lhCodCliente   =         pstHistPac->lCodCliente       ;
	lhNumSecuencia =         pstHistPac->lNumSecuencia     ;                  
	strcpy( szhCodTipDocum  ,pstHistPac->szCodTipDocum    );                          
	strcpy( szhCodVendAgent ,pstHistPac->szCodVendAgent   );                          
	strcpy( szhLetra        ,pstHistPac->szLetra          );                         
	ihCodCentremi  =         pstHistPac->iCodCentremi      ;                  
	lhNumFolio     =         pstHistPac->lNumFolio         ;              
	strcpy( szhFecVencimie  ,pstHistPac->szFecVencimie    );                          
	dhImpDebe      =         pstHistPac->dImpDebe          ;
	strcpy(szhFecCiclo      ,szhFecVenctoCiclo); 

    sqlca.sqlcode = 0;
    /* EXEC SQL
    SELECT count(1)            
    INTO  :existe_abocel_AAA
    FROM  GA_ABOCEL A 
    WHERE A.COD_CLIENTE   = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 28;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from GA_ABOCEL A where A.COD_CL\
IENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1136;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&existe_abocel_AAA;
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

	/* Requerimiento de Soporte - #37161 29.01.2007 capc */
    /* AND   A.COD_PRODUCTO  = :ihValor_uno;	 Requerimiento de Soporte - #37161 29.01.2007 capc */

  	if( SQLCODE == SQLNOTFOUND  )  	{ 
  	    existe_abocel_AAA=0;
  	    /*return FALSE;*/
  	}
	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
    	vDTrazasError( modulo,	"\n\n\tError en SELECT Ga_Abocel Unico 1: \n\t%s", LOG01, SQLERRM);
    	 existe_abocel_AAA=0;
    	 return FALSE;
    }   	
   
    /*******************/
	if (existe_abocel_AAA == 0) {
		vDTrazasLog( modulo, "\n\t* No se inserta Cliente [%ld] a tabla CO_PAGOSPAC",LOG03,lhCodCliente );
		vDTrazasLog( modulo, "\n\t* Cliente [%ld] NO tiene Abonados de ALTA (AAA) en tabla GA_ABOCEL",LOG03,lhCodCliente );
		lContRegAAA++;  
	} else {
			ihVerificaExistencia = 0;
			/* EXEC SQL  
			SELECT COUNT(1) 
			INTO   :ihVerificaExistencia
            FROM  CO_PAGOSPAC
			WHERE FEC_VALOR    = TO_DATE(:szhFecCiclo,:szhYYYYMMDD)/oTO_DATE(:szhFecVencimie,:szhYYYYMMDD) #39864 Soporte RyC 25.04.2007 capfo/
			AND   COD_BANCO    = :szhCodBanco
			AND   COD_CLIENTE  = :lhCodCliente
			AND   COD_TIPDOCUM = TO_NUMBER(:szhCodTipDocum ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(1) into :b0  from CO_PAGOSPAC where (((FEC_VA\
LOR=TO_DATE(:b1,:b2) and COD_BANCO=:b3) and COD_CLIENTE=:b4) and COD_TIPDOCUM=\
TO_NUMBER(:b5))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1159;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihVerificaExistencia;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecCiclo;
   sqlstm.sqhstl[1] = (unsigned long )15;
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
   sqlstm.sqhstv[3] = (unsigned char  *)szhCodBanco;
   sqlstm.sqhstl[3] = (unsigned long )16;
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
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipDocum;
   sqlstm.sqhstl[5] = (unsigned long )3;
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


			
			if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
    			vDTrazasError( modulo,	"\n\n\tError en SELECT CO_PAGOSPAC \n\t%s", LOG01, SQLERRM);
    	 		return FALSE;
   			}   	

	        vDTrazasLog( modulo, "\n\t* ihVerificaExistencia   [%d]",LOG03, ihVerificaExistencia);
			pstHistPac->iClienteExiste = ihVerificaExistencia; 
			if( ihVerificaExistencia == 0 )  	{ 
	    		vDTrazasLog( modulo, "\n\t* Insertando en Co_PagosPac",LOG03);
				/* EXEC SQL  
				INSERT INTO CO_PAGOSPAC
				 		(	FEC_VALOR,
							COD_BANCO,
							COD_CLIENTE,
							NUM_SECUENCI,
							COD_TIPDOCUM,
							COD_VENDEDOR_AGENTE,
							LETRA,
							COD_CENTREMI,
							NUM_FOLIO,
							PREF_PLAZA,
							FEC_VENCIMIE,
							IMPORTE_DEBE,
							IND_PROCESADO,
							IND_CANCELADO,
							COD_RESPUBANCO,
							COD_OPERADORA,
							COD_PLAZA )
				VALUES (	TO_DATE(:szhFecCiclo,:szhYYYYMMDD),  /o #39864 Soporte RyC 25.04.2007 capfo/ 
							:szhCodBanco,
							:lhCodCliente,
							:lhNumSecuencia,
							TO_NUMBER(:szhCodTipDocum ),   
							TO_NUMBER(:szhCodVendAgent),
							:szhLetra,
							:ihCodCentremi,
							:lhNumFolio,
							:szhPref_Plaza,
							TO_DATE(:szhFecVencimie,:szhYYYYMMDD), /o #39864 Soporte RyC 25.04.2007 capfo/ 
							GE_PAC_GENERAL.REDONDEA(:dhImpDebe, :iDecimal, :ihValor_Cero),
							:ihIndProcesado,
							:ihIndCancelado,
							0,
							:szhCod_Operadora,
							:szhCod_Plaza); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 28;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_PAGOSPAC (FEC_VALOR,COD_BANCO,COD_CLIENTE,\
NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,NUM_FOLIO,PRE\
F_PLAZA,FEC_VENCIMIE,IMPORTE_DEBE,IND_PROCESADO,IND_CANCELADO,COD_RESPUBANCO,C\
OD_OPERADORA,COD_PLAZA) values (TO_DATE(:b0,:b1),:b2,:b3,:b4,TO_NUMBER(:b5),TO\
_NUMBER(:b6),:b7,:b8,:b9,:b10,TO_DATE(:b11,:b1),GE_PAC_GENERAL.REDONDEA(:b13,:\
b14,:b15),:b16,:b17,0,:b18,:b19)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1198;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecCiclo;
    sqlstm.sqhstl[0] = (unsigned long )15;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodBanco;
    sqlstm.sqhstl[2] = (unsigned long )16;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuencia;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipDocum;
    sqlstm.sqhstl[5] = (unsigned long )3;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodVendAgent;
    sqlstm.sqhstl[6] = (unsigned long )7;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhLetra;
    sqlstm.sqhstl[7] = (unsigned long )2;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentremi;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhPref_Plaza;
    sqlstm.sqhstl[10] = (unsigned long )26;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhFecVencimie;
    sqlstm.sqhstl[11] = (unsigned long )9;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhYYYYMMDD;
    sqlstm.sqhstl[12] = (unsigned long )9;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&dhImpDebe;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&iDecimal;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&ihValor_Cero;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&ihIndProcesado;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihIndCancelado;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhCod_Operadora;
    sqlstm.sqhstl[18] = (unsigned long )6;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhCod_Plaza;
    sqlstm.sqhstl[19] = (unsigned long )6;
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


		
	   			vDTrazasLog( modulo, "\n\t* Pasando el insert de co_pagospac",LOG03);
	
				if (SQLCODE ) {
					iDError(modulo,ERR000,vInsertarIncidencia," Al Insertar en la Tabla CO_PAGOSPAC.\t ",SQLERRM);
					strcpy(stFicBancos[lCon].szCtaCte_Tarj," ");
					pstHistPac->dImpDebe=0;
					return FALSE;
				} else 	{
					vDTrazasLog( modulo,"\n\t-----------------------------------------------"
										"\n\tInsert OK en CO_PAGOSPAC "
										"\n\t-----------------------------------------------",                          
										LOG03);
				} /* end if (SQLCODE )*/
			} else { 
	   			vDTrazasLog( modulo, "\n\t* ATENCION ..... Cliente ya fue procesado o se esta reprocesando...",LOG03);
	   			vDTrazasLog( modulo, "\t* lhCodCliente   [%ld]",LOG03, lhCodCliente);
	   			vDTrazasLog( modulo, "\t* szhFecVencimie [%s]",LOG03, szhFecVencimie);
	   			vDTrazasLog( modulo, "\t* szhCodBanco    [%s]",LOG03, szhCodBanco);
	   			vDTrazasLog( modulo, "\t* szhCodTipDocum [%s]",LOG03, szhCodTipDocum);
				strcpy(stFicBancos[lCon].szCtaCte_Tarj," ");
				pstHistPac->dImpDebe      = 0;    
			} /* end if( SQLCODE == NOTFOUND )*/	
	} /* end if (existe_abocel_AAA == 0) */
	return TRUE;

}/* bfnDBInsertPagosPac */

/*===========================================================================*/
/* Funcion: BOOL bfnDBUpdateHistDocu(HistDocu  *pstHist)                     */
/* Actualizamos la Tabla FA_HISTDOCU introduciendole el Numero de Secuencia. */
/*===========================================================================*/
BOOL bfnDBUpdateHistDocu(FA_HISTDOCU  *pstHist)
{
char modulo[]="bfnDBUpdateHistDocu";
    vDTrazasLog( modulo, "\n\t Inicio bfnDBUpdateHistDocu()",LOG03);
    vDTrazasLog( modulo, "\t pstHist->szSeqPac  [%s]",LOG03,pstHist->szSeqPac);
    vDTrazasLog( modulo, "\t pstHist->szRowid   [%s]",LOG03,pstHist->szRowid);
    
	/* EXEC SQL 
	UPDATE /o+ Rowid (FA_HISTDOCU) o/ FA_HISTDOCU 	SET		
           SEQ_PAC = TO_NUMBER(:pstHist->szSeqPac)
	WHERE  ROWID = :pstHist->szRowid; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update  /*+  Rowid (FA_HISTDOCU)  +*/ FA_HISTDOCU  set SEQ_P\
AC=TO_NUMBER(:b0) where ROWID=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1293;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)(pstHist->szSeqPac);
 sqlstm.sqhstl[0] = (unsigned long )13;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(pstHist->szRowid);
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


	
    vDTrazasLog( modulo, "\n\t Paso Update FA_HISTDOCU",LOG03);
	if (SQLCODE)  {
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al Hacer Update en FA_HISTDOCU.\n\t\t\t\t ",SQLERRM);
		return FALSE;
	}
	else
		vDTrazasLog(modulo,"\t*Actualizacion de Secuencia en FA_HISTDOCU",LOG05);
	return TRUE;
}/* bfnDBUpdateHistDocu */


/*===========================================================================*/
/*Funcion: bfnInserFic(FICBANCOS *pstBancos);                                */
/*         Genera Fichero: PAC_Fecha.CodBanco                                */
/*===========================================================================*/
BOOL bfnInsertFic( FICBANCOS *pstBancos, char *szCodBanco_param , char *pszOperadora)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables.                         		         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="bfnInsertFic";
int  iCon           = 0;
int  iResultado     = 0;
char szNumTransacciones [7];
char szTotImporteCargos[12];
char szhOperadora       [6]; 
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     long lhCod_Cliente       ; 
/* EXEC SQL END DECLARE SECTION  ; */ 



        if ((strcmp(szFormatoBanco,GUA1)==0)||(strcmp(szFormatoBanco,GUA2)==0))
        {
		 sprintf(szFilePac,"PAC_TM%s_%s.csv",szhFecYYMMDD,szHora);
	}
	/*Inicio P-CSR-11002*/
	else{
		 if (strcmp(szFormatoBanco,CSR1)==0)
		 {
		 	sprintf(szFilePac,"CITI_CargAuto_Telefónica_%s.txt",szhFechaddmmyyyy);	 
		 }
	}
	/*Final P-CSR-11002*/ 
	
	/*----------------------------------------------------------------------*/
	/* Abre y Graba en archivo plano, seg£n formato 						*/
	/*----------------------------------------------------------------------*/	    		
	if (ifnAbreArchivosLog(1)!=0) return FALSE;

	while(!pstBancos[iCon].final)
	{
		vDTrazasLog( modulo,"\n\t* Parametros Tratados en bfnInsertFic"
		                    "\n\t\t=>FORMATO ................ [%s]"
							"\n\t\t=>COD ZONA ............... [%s]"
							"\n\t\t=>COD CENTRAL ............ [%s]"
							"\n\t\t=>CLIENTE ................ [%d]"
							"\n\t\t=>CICLO BANCOS ........... [%s]"
							"\n\t\t=>MONTOPAGO .............. [%f]"
							"\n\t\t=>FINAL .................. [%d]" 
							,LOG03
							,szFormatoBanco
							,pstBancos[iCon].szCodZona 
							,pstBancos[iCon].szcodcentral
							,pstBancos[iCon].lCodCliente
							,pstBancos[iCon].szCicloBanco
							,pstBancos[iCon].dmontopago
							,pstBancos[iCon].final);
		
		/*----------------------------------------------------------------------*/
		/* Inicializacion de Cliente 										    */
		/*----------------------------------------------------------------------*/	    			
        memset(&lhCod_Cliente,0,sizeof(lhCod_Cliente));
        lhCod_Cliente = pstBancos[iCon].lCodCliente;

		/*----------------------------------------------------------------------*/
		/* Formato de Archivo => GUA1 					  					    */
		/*----------------------------------------------------------------------*/	    			 	    
	    if (strcmp(szFormatoBanco,GUA1)==0) {
			iResultado = ifnFormatoGUA1(lhCod_Cliente, iCon, pstBancos);
			if (iResultado < 0) return FALSE;                              
		} 

		/*----------------------------------------------------------------------*/
		/* Formato de Archivo => GUA2 					  					    */
		/*----------------------------------------------------------------------*/	    			 	    
	    if (strcmp(szFormatoBanco,GUA2)==0) {
			iResultado = ifnFormatoGUA2(lhCod_Cliente, iCon, pstBancos);
			if (iResultado < 0) return FALSE;                              
		} 

		/*----------------------------------------------------------------------*/
		/* Formato de Archivo => SAL1 					  					    */
		/*----------------------------------------------------------------------*/	    			 	    
	    if (strcmp(szFormatoBanco,SAL1)==0) {
			iResultado = ifnFormatoSAL1(lhCod_Cliente, iCon, pstBancos);
			if (iResultado < 0) return FALSE;                              
		} 

		/*----------------------------------------------------------------------*/
		/* Formato de Archivo => SAL2 					  					    */
		/*----------------------------------------------------------------------*/	    			 	    
	    if (strcmp(szFormatoBanco,SAL2)==0) {
			iResultado = ifnFormatoSAL2(lhCod_Cliente, iCon, pstBancos);
			if (iResultado < 0) return FALSE;                              
		} 

		/*----------------------------------------------------------------------*/
		/* Formato de Archivo => SAL3 					  					    */
		/*----------------------------------------------------------------------*/	    			 	    
	    if (strcmp(szFormatoBanco,SAL3)==0) {
			iResultado = ifnFormatoSAL3(lhCod_Cliente, iCon, pstBancos);
			if (iResultado < 0) return FALSE;                              
		}
		
		/*----------------------------------------------------------------------*/
		/* Formato de Archivo => CSR1 					  	*/
		/*----------------------------------------------------------------------*/	    			 	    
	    if (strcmp(szFormatoBanco,CSR1)==0) {
			iResultado = ifnFormatoCSR1(lhCod_Cliente, iCon, pstBancos);
			if (iResultado < 0) return FALSE;                              
		} 
		iCon++; 
	 }
	

	vDTrazasLog(modulo,"\n\t\tFINAL .......[%d].",LOG03,pstBancos[iCon].final);
	return TRUE;
} /* bfnInsertFic */

/*===========================================================================*/
/*Funcion: ifnFormatoPac (char *szCodBancoPac,char *pszFormatoBanco,         */
/*                        char *pszCod_Servicio)                             */
/* Selecciona el codigo de servicio del banco que aparecera en el archivo    */
/*===========================================================================*/
int ifnFormatoPac (char *szCodBancoPac, char *pszFormatoBanco, char *pszCod_Servicio, char *pszOperadora)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoPac";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhCod_Banco      [16];
    char szhOperadora      [6] ; /* EXEC SQL VAR szhOperadora    IS STRING(6) ; */ 
 
/* EXEC SQL END DECLARE SECTION; */ 

   
   /*-----------------------------------------------------------------------*/
   /* Seleccion de Formato para Banco							             */
   /*-----------------------------------------------------------------------*/	    
   vDTrazasLog(modulo,"\n\t Funcion ifnFormatoPac(). Seleccion de Formato para Banco.",LOG03);

   sprintf(szhCod_Banco,"%s\0",szCodBancoPac);
   strcpy(szhOperadora, pszOperadora);

   vDTrazasLog(modulo,"\t\t szCodBancoPac  [%s]",LOG03,szhCod_Banco);
   vDTrazasLog(modulo,"\t\t szhOperadora   [%s]\n",LOG03,szhOperadora);
	      
   /* EXEC SQL
   SELECT COD_FORMATO  	 , NVL(COD_CONVENIO,:szhFiller) 
   INTO   :szhFormatoBanco , :szhClaveEstablecimiento
   FROM   CO_SERVICIOPAC
   WHERE  COD_BANCO   	  = (SELECT COD_BANCO_GRP FROM CO_SERVICIOPAC WHERE COD_BANCO = :szhCod_Banco)
   AND    COD_OPERADORA_SCL = :szhOperadora; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_FORMATO ,NVL(COD_CONVENIO,:b0) into :b1,:b2  fr\
om CO_SERVICIOPAC where (COD_BANCO=(select COD_BANCO_GRP  from CO_SERVICIOPAC \
where COD_BANCO=:b3) and COD_OPERADORA_SCL=:b4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1316;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhFiller;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoBanco;
   sqlstm.sqhstl[1] = (unsigned long )7;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhClaveEstablecimiento;
   sqlstm.sqhstl[2] = (unsigned long )21;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhCod_Banco;
   sqlstm.sqhstl[3] = (unsigned long )16;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhOperadora;
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


       
        
	if (SQLCODE==NOTFOUND )  {
		iDError(modulo,ERR000,vInsertarIncidencia," Codigo de Formato no existe.\t ",SQLERRM);
		return -1;
	}       

	if (SQLCODE!=SQLOK )  {
		iDError(modulo,ERR000,vInsertarIncidencia,"\nSELECT COD_SERVICIO.\n\t ",SQLERRM);
		return -1;
	}       

	RighTrim(szhFormatoBanco);
		
   /*-----------------------------------------------------------------------*/
	/* Formato de Banco 									                 */
   /*-----------------------------------------------------------------------*/	    
   sprintf(pszFormatoBanco,"%s\0",szhFormatoBanco);

   vDTrazasLog(modulo,"\t\t Formato del Banco  ====>  [%s].",LOG03,pszFormatoBanco);
   return 0;

}/* ifnFormatoPac */


/*===========================================================================*/
/* Funcion ifnFormatoGUA1 : Imprime en archivo csv, segun formato GUA1     */
/*===========================================================================*/
int ifnFormatoGUA1(long plCod_Cliente, int piCon, FICBANCOS * psBancos)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables									         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoGUA1";
int  iCon;
char szMontoFin  [18];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhNum_Tarjeta   [19]; /* EXEC SQL VAR szhNum_Tarjeta   IS STRING(19); */ 

     char szhFec_vencitarj  [7]; /* EXEC SQL VAR szhFec_vencitarj IS STRING(7); */ 

     char szhNom_email    [256]; /* EXEC SQL VAR szhNom_email     IS STRING(256); */ 

     char szhNom_cliente   [93]; /* EXEC SQL VAR szhNom_cliente   IS STRING(93); */ 

     char szhNum_Folio      [9]; /* EXEC SQL VAR szhNum_Folio     IS STRING(9); */ 

     long lhCod_Cliente     ; 
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(modulo,"\tEn funcion [%s].\n",LOG03,modulo);
    memset(&szMontoFin,'\0',sizeof(szMontoFin));
    memset(&szhNum_Folio,'\0',sizeof(szhNum_Folio));
	iCon          = piCon        ;
	lhCod_Cliente = plCod_Cliente;
           
           
  	/* EXEC SQL
  	SELECT UNIQUE NVL(NUM_TARJETA,:szhZero), 
           NVL(TO_CHAR(fec_vencitarj,'MMYYYY'),'000000'),
           NVL(nom_email,'N/A'),
           nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2
  	INTO   :szhNum_Tarjeta   , 
           :szhFec_vencitarj,
           :szhNom_email,
           :szhNom_cliente
  	FROM   GE_CLIENTES
  	WHERE  COD_CLIENTE = :lhCod_Cliente
  	AND    FEC_BAJA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(NUM_TARJETA,:b0) ,NVL(TO_CHAR(fec_vencit\
arj,'MMYYYY'),'000000') ,NVL(nom_email,'N/A') ,((((nom_cliente||' ')||nom_apec\
lien1)||' ')||nom_apeclien2) into :b1,:b2,:b3,:b4  from GE_CLIENTES where (COD\
_CLIENTE=:b5 and FEC_BAJA is null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1351;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNum_Tarjeta;
   sqlstm.sqhstl[1] = (unsigned long )19;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFec_vencitarj;
   sqlstm.sqhstl[2] = (unsigned long )7;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNom_email;
   sqlstm.sqhstl[3] = (unsigned long )256;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNom_cliente;
   sqlstm.sqhstl[4] = (unsigned long )93;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCod_Cliente;
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


  	
  	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   	  vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes GUA1 : \n\t%s", LOG01, SQLERRM);
   	  return -1;
  	}       
	
	/* EXEC SQL 
	SELECT NUM_FOLIO 
	  INTO :szhNum_Folio
	  FROM CO_PAGOSPAC 
	 WHERE COD_CLIENTE = :lhCod_Cliente
	   AND IND_PROCESADO=:szhZero; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NUM_FOLIO into :b0  from CO_PAGOSPAC where (COD_CLIEN\
TE=:b1 and IND_PROCESADO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1390;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Folio;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Cliente;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhZero;
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


	
	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   	  vDTrazasError( modulo,	"\n\n\tError en SELECT CO_PAGOSPAC GUA1 : \n\t%s", LOG01, SQLERRM);
   	  return -1;
  	}       
	
	
	/* Inicio Incidencia 132205 - 29.04.2010 - TMG-TMS */	
  	/*sprintf(szMontoFin,"%.f\0",(psBancos[iCon].dmontopago)*100);*/
  	sprintf(szMontoFin,"%.2f\0",psBancos[iCon].dmontopago);
  	/* Fin Incidencia 132205 - 29.04.2010 - TMG-TMS */
  	vDTrazasLog(modulo,"\t szMontoFin        [%s]",LOG03,szMontoFin);
  	vDTrazasLog(modulo,"\t lhCod_Cliente     [%ld]",LOG03,lhCod_Cliente);
  	/*vDTrazasLog(modulo,"\t szhSeqPac         [%s]",LOG03,szhSeqPac);*/
  	vDTrazasLog(modulo,"\t szhNum_Folio         [%s]",LOG03,szhNum_Folio);
  	vDTrazasLog(modulo,"\t szhNum_Tarjeta    [%s]",LOG03,szhNum_Tarjeta);
  	vDTrazasLog(modulo,"\t szhFec_vencitarj  [%s]",LOG03,szhFec_vencitarj);
  	vDTrazasLog(modulo,"\t szhFechaddmmyyyy  [%s]",LOG03,szhFechaddmmyyyy);
  	vDTrazasLog(modulo,"\t szhNom_email      [%s]",LOG03,szhNom_email);
  	vDTrazasLog(modulo,"\t szhNom_cliente    [%s]",LOG03,szhNom_cliente);

  	if( (fprintf( FichBancos , "1,%ld,%s,%s,%s,%s,%s,%s,%s\n" ,
          			           lhCod_Cliente    , 
          			           /*szhSeqPac      ,*/
          			           szhNum_Folio     ,
           			           szhNum_Tarjeta   ,                    			            
           			           szhFec_vencitarj ,
           			           szMontoFin       ,
           			           szhFechaddmmyyyy ,
           			           szhNom_email     , 
          			           szhNom_cliente   ) ) == -1 )
                    			           
	{	
		vDTrazasError(modulo,"Error al Escribir Registro Detalle en Fichero con Banco [%d]",LOG01,atoi(psBancos[iCon].szCodBanco));
		return -1; 
	}

	return 0;

}/*ifnFormatoGUA1*/


/*===========================================================================*/
/* Funcion ifnFormatoGUA2 : Imprime en archivo txt, segun formato GUA2       */
/*===========================================================================*/
int ifnFormatoGUA2(long plCod_Cliente, int piCon, FICBANCOS * psBancos)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables									         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoGUA2";
int  iCon;
char szMontoFin  [9];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhNum_Tarjeta  [19]; /* EXEC SQL VAR szhNum_Tarjeta   IS STRING(19); */ 

     char szhFec_vencitarj [5]; /* EXEC SQL VAR szhFec_vencitarj IS STRING(5); */ 

     char szhNom_cliente  [93]; /* EXEC SQL VAR szhNom_cliente   IS STRING(93); */ 

     char szhNum_Folio     [9]; /* EXEC SQL VAR szhNum_Folio     IS STRING(9); */ 

     long lhCod_Cliente     ; 
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(modulo,"\tEn funcion [%s].\n",LOG03,modulo);
    memset(&szMontoFin,'\0',sizeof(szMontoFin));
    memset(&szhNum_Folio,'\0',sizeof(szhNum_Folio));
    iCon          = piCon        ;
	lhCod_Cliente = plCod_Cliente;
           
  	/* EXEC SQL
  	SELECT UNIQUE NVL(NUM_TARJETA,:szhZero), 
           NVL(TO_CHAR(fec_vencitarj,'MMYY'),'0000'),
           nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2
  	INTO   :szhNum_Tarjeta  , 
           :szhFec_vencitarj,
           :szhNom_cliente
  	FROM   GE_CLIENTES
  	WHERE  COD_CLIENTE = :lhCod_Cliente
  	AND    FEC_BAJA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(NUM_TARJETA,:b0) ,NVL(TO_CHAR(fec_vencit\
arj,'MMYY'),'0000') ,((((nom_cliente||' ')||nom_apeclien1)||' ')||nom_apeclien\
2) into :b1,:b2,:b3  from GE_CLIENTES where (COD_CLIENTE=:b4 and FEC_BAJA is n\
ull )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1417;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNum_Tarjeta;
   sqlstm.sqhstl[1] = (unsigned long )19;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFec_vencitarj;
   sqlstm.sqhstl[2] = (unsigned long )5;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNom_cliente;
   sqlstm.sqhstl[3] = (unsigned long )93;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCod_Cliente;
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


  	
  	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   	   vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes GUA1 : \n\t%s", LOG01, SQLERRM);
   	   return -1;
  	}       
         
        /* EXEC SQL 
	SELECT NUM_FOLIO 
	  INTO :szhNum_Folio
	  FROM CO_PAGOSPAC 
	 WHERE COD_CLIENTE = :lhCod_Cliente
	   AND IND_PROCESADO=:szhZero; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 28;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NUM_FOLIO into :b0  from CO_PAGOSPAC where (CO\
D_CLIENTE=:b1 and IND_PROCESADO=:b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1452;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Folio;
        sqlstm.sqhstl[0] = (unsigned long )9;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Cliente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhZero;
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


	
	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   	  vDTrazasError( modulo,	"\n\n\tError en SELECT CO_PAGOSPAC GUA2 : \n\t%s", LOG01, SQLERRM);
   	  return -1;
  	}       
  
  	sprintf(szMontoFin,"%.f\0",(psBancos[iCon].dmontopago)*100);
  	vDTrazasLog(modulo,"\t szMontoFin               [%07s]",LOG03,szMontoFin);
  	vDTrazasLog(modulo,"\t szhClaveEstablecimiento  [%8s]",LOG03,szhClaveEstablecimiento);
  	vDTrazasLog(modulo,"\t szhNum_Tarjeta           [%016s]",LOG03,szhNum_Tarjeta);
  	vDTrazasLog(modulo,"\t szhFec_vencitarj         [%04s]",LOG03,szhFec_vencitarj);
  	vDTrazasLog(modulo,"\t lhCod_Cliente            [%010ld]",LOG03,lhCod_Cliente);
  	vDTrazasLog(modulo,"\t szhNum_Folio             [%s]",LOG03,szhNum_Folio);

  	if( (fprintf( FichBancos , "%06s%8s%016s%04s%08s%010ld\n" ,
          			           /*szhSeqPac        ,*/
          			           szhNum_Folio        ,
          			           szhClaveEstablecimiento,
           			           szhNum_Tarjeta   ,                    			            
           			           szhFec_vencitarj ,
           			           szMontoFin       ,
          			           lhCod_Cliente    ) ) == -1 )
                    			           
	{	
	    vDTrazasError(modulo,"Error al Escribir Registro Detalle en Fichero con Banco [%d]",LOG01,atoi(psBancos[iCon].szCodBanco));
		return -1; 
	}

	return 0;

}/*ifnFormatoGUA2*/


/*===========================================================================*/
/* Funcion ifnFormatoSAL1 : Imprime en archivo txt, segun formato SAL1       */
/*===========================================================================*/
int ifnFormatoSAL1(long plCod_Cliente, int piCon, FICBANCOS * psBancos)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables									         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoSAL1";
int  iCon;
char szMontoFin  [19];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhNum_Tarjeta [19]; /* EXEC SQL VAR szhNum_Tarjeta IS STRING(19); */ 

     long lhCod_Cliente     ; 
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(modulo,"\tEn funcion [%s].\n",LOG03,modulo);
    memset(&szMontoFin,'\0',sizeof(szMontoFin));
	iCon = piCon        ;
	lhCod_Cliente = plCod_Cliente;
           
           
  	/* EXEC SQL
  	SELECT UNIQUE NVL(NUM_TARJETA,:szhZero) 
  	INTO   :szhNum_Tarjeta    
  	FROM   GE_CLIENTES
  	WHERE  COD_CLIENTE = :lhCod_Cliente
  	AND    FEC_BAJA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(NUM_TARJETA,:b0) into :b1  from GE_CLIEN\
TES where (COD_CLIENTE=:b2 and FEC_BAJA is null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1479;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNum_Tarjeta;
   sqlstm.sqhstl[1] = (unsigned long )19;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Cliente;
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


  	
  	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   	  vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes GUA1 : \n\t%s", LOG01, SQLERRM);
   	  return -1;
  	}       

  	sprintf(szMontoFin,"%.f\0",(psBancos[iCon].dmontopago)*100);
  	vDTrazasLog(modulo,"\t lhCod_Cliente     [%090ld]",LOG03,lhCod_Cliente);
  	vDTrazasLog(modulo,"\t szhNum_Tarjeta    [%020s]",LOG03,szhNum_Tarjeta);
  	vDTrazasLog(modulo,"\t lNumFolio         [%010ld]",LOG03,psBancos[iCon].lNumFolio);
  	vDTrazasLog(modulo,"\t szFecVencimie     [%8s]",LOG03,psBancos[iCon].szFecVencimie);
  	vDTrazasLog(modulo,"\t szMontoFin        [%018s]",LOG03,szMontoFin);

  	if( (fprintf( FichBancos , "%090ld%020s%010ld%s%018s\n" , 
          			           lhCod_Cliente  ,
          			           szhNum_Tarjeta ,
          			           psBancos[iCon].lNumFolio,
          			           psBancos[iCon].szFecVencimie,
           			           szMontoFin   ) ) == -1 )
                    			           
	{	
		vDTrazasError(modulo,"Error al Escribir Registro Detalle en Fichero con Banco [%d]",LOG01,atoi(psBancos[iCon].szCodBanco));
		return -1; 
	}

	return 0;

}/*ifnFormatoSAL1*/


/*===========================================================================*/
/* Funcion ifnFormatoSAL2 : Imprime en archivo txt, segun formato SAL2     */
/*===========================================================================*/
int ifnFormatoSAL2(long plCod_Cliente, int piCon, FICBANCOS * psBancos)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables									         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoSAL2";
int  iCon;
char szMontoFin  [19];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhNum_Tarjeta   [19]; /* EXEC SQL VAR szhNum_Tarjeta IS STRING(19); */ 

     char szhFec_vencitarj  [7]; /* EXEC SQL VAR szhFec_vencitarj IS STRING(7); */ 

     char szhNom_cliente   [93]; /* EXEC SQL VAR szhNom_cliente IS STRING(93); */ 

     long lhCod_Cliente        ; 
     char szhFec_vencimto   [9];
     char szhFec_vencimiento[9];
/* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog(modulo,"\tEn funcion [%s].\n",LOG03,modulo);
   memset(&szMontoFin,'\0',sizeof(szMontoFin));
	iCon = piCon        ;
	lhCod_Cliente = plCod_Cliente;
	strcpy(szhFec_vencimto,psBancos[iCon].szFecVencimie);
           
  	/* EXEC SQL
  	SELECT UNIQUE NVL(NUM_TARJETA,:szhZero), 
           NVL(TO_CHAR(fec_vencitarj,'MMYYYY'),'000000'),
           nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2,
           TO_CHAR(TO_DATE(:szhFec_vencimto,'yyyymmdd'),'ddmmyyyy')
  	INTO   :szhNum_Tarjeta   , 
           :szhFec_vencitarj,
           :szhNom_cliente,
           :szhFec_vencimiento
  	FROM   GE_CLIENTES
  	WHERE  COD_CLIENTE = :lhCod_Cliente
  	AND    FEC_BAJA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(NUM_TARJETA,:b0) ,NVL(TO_CHAR(fec_vencit\
arj,'MMYYYY'),'000000') ,((((nom_cliente||' ')||nom_apeclien1)||' ')||nom_apec\
lien2) ,TO_CHAR(TO_DATE(:b1,'yyyymmdd'),'ddmmyyyy') into :b2,:b3,:b4,:b5  from\
 GE_CLIENTES where (COD_CLIENTE=:b6 and FEC_BAJA is null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1506;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFec_vencimto;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhNum_Tarjeta;
   sqlstm.sqhstl[2] = (unsigned long )19;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhFec_vencitarj;
   sqlstm.sqhstl[3] = (unsigned long )7;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNom_cliente;
   sqlstm.sqhstl[4] = (unsigned long )93;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFec_vencimiento;
   sqlstm.sqhstl[5] = (unsigned long )9;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_Cliente;
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


  	
  	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   		vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes GUA1 : \n\t%s", LOG01, SQLERRM);
   		return -1;
  	}       

  	sprintf(szMontoFin,"%.f\0",(psBancos[iCon].dmontopago)*100);
  	vDTrazasLog(modulo,"\t lhCod_Cliente     [%010ld]",LOG03,lhCod_Cliente);
  	vDTrazasLog(modulo,"\t lNumFolio         [%010ld]",LOG03,psBancos[iCon].lNumFolio);
  	vDTrazasLog(modulo,"\t szhNum_Tarjeta    [%020s]",LOG03,szhNum_Tarjeta);
  	vDTrazasLog(modulo,"\t szhFec_vencitarj  [%6s]",LOG03,szhFec_vencitarj);
  	vDTrazasLog(modulo,"\t szMontoFin        [%018s]",LOG03,szMontoFin);
  	vDTrazasLog(modulo,"\t szhFec_vencimiento[%s]",LOG03,szhFec_vencimiento);
  	vDTrazasLog(modulo,"\t szhClaveEstablecimiento [%010s]",LOG03,szhClaveEstablecimiento);
  	vDTrazasLog(modulo,"\t szhNom_cliente    [%150s]",LOG03,szhNom_cliente);

  	if( (fprintf( FichBancos , "00001%010ld%010ld%020s%6s%018s%s%010s%-150s\n" , 
          			           lhCod_Cliente  ,
          			           psBancos[iCon].lNumFolio,
          			           szhNum_Tarjeta ,
          			           szhFec_vencitarj,
          			           szMontoFin,
          			           szhFec_vencimiento,
          			           szhClaveEstablecimiento,
           			           szhNom_cliente   ) ) == -1 )
                    			           
	{	
		vDTrazasError(modulo,"Error al Escribir Registro Detalle en Fichero con Banco [%d]",LOG01,atoi(psBancos[iCon].szCodBanco));
		return -1; 
	}

	return 0;

}/*ifnFormatoSAL2*/


/*===========================================================================*/
/* Funcion ifnFormatoSAL3 : Imprime en archivo txt, segun formato SAL3       */
/*===========================================================================*/
int ifnFormatoSAL3(long plCod_Cliente, int piCon, FICBANCOS * psBancos)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables									         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoSAL3";
int  iCon;
char szMontoFin  [19];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhNum_Tarjeta    [19]; /* EXEC SQL VAR szhNum_Tarjeta IS STRING(19); */ 

     char szhFec_vencitarj   [7]; /* EXEC SQL VAR szhFec_vencitarj IS STRING(7); */ 

     char szhNom_cliente    [93]; /* EXEC SQL VAR szhNom_cliente IS STRING(93); */ 

     long lhCod_Cliente         ; 
     char szhFec_vencimto    [9];
     char szhFec_vencimiento[11];
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(modulo,"\tEn funcion [%s].\n",LOG03,modulo);
    memset(&szMontoFin,'\0',sizeof(szMontoFin));
	iCon = piCon        ;
	lhCod_Cliente = plCod_Cliente;
	strcpy(szhFec_vencimto,psBancos[iCon].szFecVencimie);
           
  	/* EXEC SQL
  	SELECT UNIQUE NVL(NUM_TARJETA,:szhZero), 
           NVL(TO_CHAR(fec_vencitarj,'MMYYYY'),'000000'),
           nom_cliente||' '||nom_apeclien1||' '||nom_apeclien2,
           TO_CHAR(TO_DATE(:szhFec_vencimto,'yyyymmdd'),'dd-mm-yyyy')
  	INTO   :szhNum_Tarjeta   , 
           :szhFec_vencitarj,
           :szhNom_cliente,
           :szhFec_vencimiento
  	FROM   GE_CLIENTES
  	WHERE  COD_CLIENTE = :lhCod_Cliente
  	AND    FEC_BAJA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(NUM_TARJETA,:b0) ,NVL(TO_CHAR(fec_vencit\
arj,'MMYYYY'),'000000') ,((((nom_cliente||' ')||nom_apeclien1)||' ')||nom_apec\
lien2) ,TO_CHAR(TO_DATE(:b1,'yyyymmdd'),'dd-mm-yyyy') into :b2,:b3,:b4,:b5  fr\
om GE_CLIENTES where (COD_CLIENTE=:b6 and FEC_BAJA is null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1549;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFec_vencimto;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhNum_Tarjeta;
   sqlstm.sqhstl[2] = (unsigned long )19;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhFec_vencitarj;
   sqlstm.sqhstl[3] = (unsigned long )7;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhNom_cliente;
   sqlstm.sqhstl[4] = (unsigned long )93;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFec_vencimiento;
   sqlstm.sqhstl[5] = (unsigned long )11;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_Cliente;
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


  	
  	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   		vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes GUA1 : \n\t%s", LOG01, SQLERRM);
   		return -1;
  	}       

  	sprintf(szMontoFin,"%.f\0",(psBancos[iCon].dmontopago)*100);
  	vDTrazasLog(modulo,"\t lhCod_Cliente           [%010ld]",LOG03,lhCod_Cliente);
  	vDTrazasLog(modulo,"\t lNumFolio               [%010ld]",LOG03,psBancos[iCon].lNumFolio);
  	vDTrazasLog(modulo,"\t szhNum_Tarjeta          [%020s]",LOG03,szhNum_Tarjeta);
  	vDTrazasLog(modulo,"\t szhFec_vencitarj        [%6s]",LOG03,szhFec_vencitarj);
  	vDTrazasLog(modulo,"\t szMontoFin              [%018s]",LOG03,szMontoFin);
  	vDTrazasLog(modulo,"\t szFecVencimie           [%s]",LOG03,szhFec_vencimiento);
  	vDTrazasLog(modulo,"\t szhClaveEstablecimiento [%010s]",LOG03,szhClaveEstablecimiento);
  	vDTrazasLog(modulo,"\t szhNom_cliente          [%150s]",LOG03,szhNom_cliente);

  	if( (fprintf( FichBancos , "00001%010ld%010ld%018s%s%-150s%020s%6s%010s%90s\n" , 
          			           lhCod_Cliente  ,
          			           psBancos[iCon].lNumFolio,
          			           szMontoFin,
          			           szhFec_vencimiento, 
          			           szhNom_cliente,
          			           szhNum_Tarjeta ,
          			           szhFec_vencitarj,
          			           szhClaveEstablecimiento,
           			           szFiller   ) ) == -1 )
                    			           
	{	
		vDTrazasError(modulo,"Error al Escribir Registro Detalle en Fichero con Banco [%d]",LOG01,atoi(psBancos[iCon].szCodBanco));
		return -1; 
	}

	return 0;

}/*ifnFormatoSAL3*/

/*===========================================================================*/
/* Funcion ifnFormatoCSR1 : Imprime en archivo txt, segun formato CSR1       */
/*===========================================================================*/
int ifnFormatoCSR1(long plCod_Cliente, int piCon, FICBANCOS * psBancos)
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables									         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoCSR1";
int  iCon;
char szMontoFin  [19];
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhNum_Tarjeta    [19]; /* EXEC SQL VAR szhNum_Tarjeta IS STRING(19); */ 

     char szhFec_vencitarj   [7]; /* EXEC SQL VAR szhFec_vencitarj IS STRING(7); */ 

     char szhNom_cliente    [93]; /* EXEC SQL VAR szhNom_cliente IS STRING(93); */ 

     long lhCod_Cliente         ; 
     char szhInfAdicional   [11];
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(modulo,"\tEn funcion [%s].\n",LOG03,modulo);
    memset(&szMontoFin,'\0',sizeof(szMontoFin));
	iCon = piCon        ;
	lhCod_Cliente = plCod_Cliente;
           
  	/* EXEC SQL
  	SELECT UNIQUE NVL(NUM_TARJETA,:szhZero), 
           NVL(TO_CHAR(fec_vencitarj,'MMYY'),'0000'),
           SUBSTR((rtrim(nom_cliente)||' '||rtrim(nom_apeclien1)),0,35)
  	INTO   :szhNum_Tarjeta   , 
           :szhFec_vencitarj,
           :szhNom_cliente
  	FROM   GE_CLIENTES
  	WHERE  COD_CLIENTE = :lhCod_Cliente
  	AND    FEC_BAJA IS NULL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(NUM_TARJETA,:b0) ,NVL(TO_CHAR(fec_vencit\
arj,'MMYY'),'0000') ,SUBSTR(((rtrim(nom_cliente)||' ')||rtrim(nom_apeclien1)),\
0,35) into :b1,:b2,:b3  from GE_CLIENTES where (COD_CLIENTE=:b4 and FEC_BAJA i\
s null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1592;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhZero;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNum_Tarjeta;
   sqlstm.sqhstl[1] = (unsigned long )19;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFec_vencitarj;
   sqlstm.sqhstl[2] = (unsigned long )7;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNom_cliente;
   sqlstm.sqhstl[3] = (unsigned long )93;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCod_Cliente;
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


  	
  	if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
   		vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes CSR1 : \n\t%s", LOG01, SQLERRM);
   		return -1;
  	}       

  	sprintf(szMontoFin,"%9.2f",(psBancos[iCon].dmontopago));
  	vDTrazasLog(modulo,"\t Código Cliente        [%010ld]",LOG03,lhCod_Cliente);
  	vDTrazasLog(modulo,"\t Numero Tarjeta        [%16s]",LOG03,szhNum_Tarjeta);
  	vDTrazasLog(modulo,"\t Vencimiento Tarjeta   [%4s]",LOG03,szhFec_vencitarj);
  	vDTrazasLog(modulo,"\t Nombre del cliente    [%35s]",LOG03,szhNom_cliente);
  	vDTrazasLog(modulo,"\t Monto Transacción     [%12s]",LOG03,szMontoFin);
  	vDTrazasLog(modulo,"\t Fecha           	     [%8s]",LOG03,szFechayyyymmdd);
  	vDTrazasLog(modulo,"\t Información adicional [% 21s]",LOG03,szhInfAdicional);

  	if( (fprintf( FichBancos , "%010ld %16s %4s %-35s % 12s %8s % 21s\n" , 
          			           lhCod_Cliente,
          			           szhNum_Tarjeta,
          			           szhFec_vencitarj,
          			           szhNom_cliente, 
          			           szMontoFin,
          			           szFechayyyymmdd,
          			           szhInfAdicional  ) ) == -1 )
                    			           
	{	
		vDTrazasError(modulo,"Error al Escribir Registro Detalle en Fichero con Banco [%d]",LOG01,atoi(psBancos[iCon].szCodBanco));
		return -1; 
	}

	return 0;

}/*ifnFormatoCSR1*/


/*==================================================================================*/
/* Funcion que selecciona los montos por concepto IVA e ICE                         */
/* Si el indicador de saldo es 1 rescatamos los montos de la cartera				*/
/* Si el indicador de saldo es 0 rescatamos la suma del imp_facturable de la tabla  */
/* fa_factconc_ciclo efectuando la busqueda en la fa_histdocu y la fa_factcobr      */
/*==================================================================================*/
int ifnValores_Iva_Ice(long plCod_cliente, double *pdValor_Iva, double *pdValor_Ice, long plCod_Ciclfact, int piFlag)
{
char modulo[]="ifnValores_Iva_Ice";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente   ;
	int    ihCod_Concepto  ;
	double dhValor_concepto;
	long   lhCod_Ciclfact  ;
	char   szhQuery  [1048]; /* EXEC SQL VAR szhQuery IS STRING(1048); */ 
 
				
	int    iCont      = 0;
	int    iValorCero = 0;
	int    iValorUno  = 1;
	char   szhCartera  [11];
	char   szhTipDocum [13];
	char   szhValor_IVA[18];
	char   szhValor_ICE[18];
	char   szhCod_Modulo[3];
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog( modulo, "\tEn funcion [%s]   <====>  Cliente [%ld]   Ciclo [%ld]  Flag [%d] ", LOG05,modulo,plCod_cliente,plCod_Ciclfact, piFlag);
	strcpy(szhCartera   ,"CO_CARTERA");
	strcpy(szhTipDocum  ,"COD_TIPDOCUM");
	strcpy(szhValor_IVA ,"VALOR_IVA_ECU_COL");
	strcpy(szhValor_ICE ,"VALOR_ICE_ECU_COL");
	strcpy(szhCod_Modulo,"CO");
    lhCod_cliente  = plCod_cliente;
	lhCod_Ciclfact = plCod_Ciclfact;

	/* Seleccionamos el parametro para el valor_iva*/
	/* EXEC SQL
	SELECT UNIQUE VAL_PARAMETRO 
	INTO   :ihCod_Concepto
	FROM   GED_PARAMETROS 
	WHERE  NOM_PARAMETRO = :szhValor_IVA
	AND    COD_MODULO    = :szhCod_Modulo
	AND    COD_PRODUCTO  = :iValorUno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select unique VAL_PARAMETRO into :b0  from GED_PARAMETROS wh\
ere ((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1627;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Concepto;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhValor_IVA;
 sqlstm.sqhstl[1] = (unsigned long )18;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&iValorUno;
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

 /* Requerimiento de Soporte - #37161 29-01-2007 CAPC */

	if (SQLCODE == SQLNOTFOUND)	{
		iDError(modulo,ERR000,vInsertarIncidencia,"Parametro [VALOR_IVA_ECU_COL] no esta definido",SQLERRM);
		return -1;
	}
	if (SQLCODE != SQLOK ) {
		iDError(modulo,ERR000,vInsertarIncidencia,"Select Parametro [VALOR_IVA_ECU_COL]",SQLERRM);
		return -1;
	}
	
	/* Atento en este ciclo a un posible brain damage... */
	iCont=0;
	while (1) {

		if (piFlag==1) {
			/* Seleccionamos datos de la Co_Cartera*/
		   /* EXEC SQL
		   SELECT NVL(SUM(A.IMPORTE_DEBE - A.IMPORTE_HABER),:iValorCero)
		   INTO   :dhValor_concepto
		   FROM   CO_CARTERA A
		   WHERE  A.COD_CLIENTE   = :lhCod_cliente
		   AND    A.COD_CONCEPTO  = :ihCod_Concepto
		   AND    A.COD_PRODUCTO+0 = :iValorUno /o Requerimiento de Soporte - #37161 29-01-2007 CAPC o/
	  	   AND    A.IND_FACTURADO = :iValorUno
		   AND NOT EXISTS (SELECT :iValorUno 
			                FROM  CO_CODIGOS COD
		  	 	  	        WHERE COD.COD_VALOR   = A.COD_TIPDOCUM 
		  		  	        AND   COD.NOM_COLUMNA = :szhTipDocum 
                            			AND   COD.NOM_TABLA   = :szhCartera); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 28;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select NVL(sum((A.IMPORTE_DEBE-A.IMPORTE_HABER)),:b0) in\
to :b1  from CO_CARTERA A where ((((A.COD_CLIENTE=:b2 and A.COD_CONCEPTO=:b3) \
and (A.COD_PRODUCTO+0)=:b4) and A.IND_FACTURADO=:b4) and  not exists (select :\
b4  from CO_CODIGOS COD where ((COD.COD_VALOR=A.COD_TIPDOCUM and COD.NOM_COLUM\
NA=:b7) and COD.NOM_TABLA=:b8)))";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1658;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&iValorCero;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&dhValor_concepto;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
     sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_Concepto;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&iValorUno;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&iValorUno;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&iValorUno;
     sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhTipDocum;
     sqlstm.sqhstl[7] = (unsigned long )13;
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)szhCartera;
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


		
			if( (SQLCODE != SQLOK ) && (SQLCODE != SQLNOTFOUND))	{
				iDError(modulo,ERR000,vInsertarIncidencia,"Select Valor Iva-Ice ",SQLERRM);
				return -1;
			}

		} else  {
			memset( szhQuery, '\0', sizeof( szhQuery ) );
			/* Seleccionamos datos de la facturacion facturizable facturada facturablemente*/
			
			sprintf( szhQuery,
			"\tSELECT NVL(SUM(IMP_FACTURABLE),%d) \n"
			"\tFROM   FA_FACTCONC_%ld  \n"
			"\tWHERE  IND_ORDENTOTAL IN (SELECT UNIQUE IND_ORDENTOTAL FROM FA_HISTDOCU WHERE COD_CLIENTE = %ld) \n" 
			"\tAND    COD_CONCEPTO   IN (SELECT COD_CONCFACT FROM FA_FACTCOBR WHERE COD_CONCCOBR  = %d)\n",iValorCero, lhCod_Ciclfact, lhCod_cliente , ihCod_Concepto);
			
			vDTrazasLog( modulo, "\tszhQuery de Iva e Ice\n\t [%s]", LOG09,szhQuery);
			/* EXEC SQL PREPARE SqlDinamico FROM :szhQuery; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 28;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1709;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
   sqlstm.sqhstl[0] = (unsigned long )1048;
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


			if( SQLCODE != SQLOK ) {
				iDError( modulo, ERR000, vInsertarIncidencia, "PREPARE CURSOR_DINAMICO\n", SQLERRM );
				return -1;

			} else {

				/* declara el cursor dinamico a partir del sql válido */
				/* EXEC SQL DECLARE cursor_dinamico CURSOR FOR SqlDinamico; */ 

				if( SQLCODE != SQLOK )    {
					iDError( modulo, ERR000, vInsertarIncidencia, "DECLARE CURSOR_DINAMICO\n", SQLERRM );
					return -1;

				} else {
					
					/* abre el cursor dinamico */
					/* EXEC SQL OPEN cursor_dinamico; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 28;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1728;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


					if( SQLCODE != SQLOK )  {
						iDError( modulo, ERR000, vInsertarIncidencia, "OPEN CURSOR_DINAMICO\n", SQLERRM );
						return -1;
					
					} else {
						/* no se efectua un while para el fetch puesto que este deberia traer un solo registro */
						/* en caso contrario denunciar el hecho al 7310000*/
						/* EXEC SQL 
						FETCH cursor_dinamico
						INTO :dhValor_concepto; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 28;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1743;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)&dhValor_concepto;
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


						if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )    {
							iDError( modulo, ERR000, vInsertarIncidencia, "FETCH CURSOR_DINAMICO\n", SQLERRM );
							return -1;
						
						} /* endif FETCH*/
					} /* endif OPEN*/
				} /* endif DECLARE*/
			} /* endif PREPARE*/
		} /* endif if (piFlag==1)*/
		
	
	    if (iCont > 0) break;
	    *pdValor_Iva=dhValor_concepto;
	    iCont++; /*Se incrementa para salir de bucle*/

		/* Seleccionamos el parametro para el valor_ice*/
		/* EXEC SQL
		SELECT UNIQUE VAL_PARAMETRO 
		INTO   :ihCod_Concepto
		FROM   GED_PARAMETROS 
		WHERE  NOM_PARAMETRO = :szhValor_ICE
		AND    COD_MODULO    = :szhCod_Modulo
		AND    COD_PRODUCTO  = :iValorUno; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 28;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select unique VAL_PARAMETRO into :b0  from GED_PARAMETROS w\
here ((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1762;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Concepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhValor_ICE;
  sqlstm.sqhstl[1] = (unsigned long )18;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&iValorUno;
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

 /* Requerimiento de Soporte - #37161 29-01-2007 CAPC */
	
		if (SQLCODE == SQLNOTFOUND)	{
			iDError(modulo,ERR000,vInsertarIncidencia,"Parametro [VALOR_ICE_ECU_COL] no esta definido",SQLERRM);
			return -1;
		}
		if (SQLCODE != SQLOK ) {
			iDError(modulo,ERR000,vInsertarIncidencia,"Select Parametro [VALOR_ICE_ECU_COL]",SQLERRM);
			return -1;
		}
		
	}/* Fin while (1)*/
   
    *pdValor_Ice=dhValor_concepto;
    vDTrazasLog( modulo, "\t\t dValor_Iva  [%f]", LOG05,*pdValor_Iva);
    vDTrazasLog( modulo, "\t\t pdValor_Ice [%f]\n", LOG05,*pdValor_Ice);

	return 0;
}

	
/*===========================================================================*/
/* Ordenamiento x banco Archivo Salida		     	 */
/*===========================================================================*/
int ifnOrdenaArchivo(void)
{
char modulo[]="ifnOrdenaArchivo";
char szComando      [500]; 

   vDTrazasLog(modulo,"\t=> Ordenando Archivo [%s].\n",LOG03,szFileDat);
   memset(&szComando,'\0',sizeof(szComando));
   strcpy(szComando,"sort -o ");
   strcat(szComando,szFileDat);
   strcat(szComando,"-tmp");   /* Salida */
   strcat(szComando," +0.0 -0.31 +0.145 +0.146 -0.148 ");
   strcat(szComando,szFileDat);  /* Entrada */
   system(szComando);
   
   memset(&szComando,'\0',sizeof(szComando));
   strcpy(szComando,"mv ");
   strcat(szComando,szFileDat);
   strcat(szComando,"-tmp  ");
   strcat(szComando,szFileDat);
   system(szComando);
   return (0);
}
/*===========================================================================*/
/* Funcion RighTrim : Limpia blancos a la derecha                            */
/*===========================================================================*/
int RighTrim (char *szVar)
{
int  iLenVar = 0;
int  i       = 0;

   iLenVar = strlen(szVar);
   for (i=iLenVar-1;i>-1;i--) {
        if (szVar[i]==' ') {
            szVar[i]='\0';
        } else break;
   }
   return (0);        
} /* RighTrim */

/*===========================================================================*/
/* Tratamiento de Fecha para ser utilizada en nombre de archivos             */
/*===========================================================================*/
char* cfnGetTimePac()
{
	int i;
	char c[255] = "";
	char a[255] = "";
	time_t ltime;
	
	time(&ltime);
	
	strcpy(c,ctime(&ltime));
	
	for( i = 22; i < 24; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i =  4; i <  7; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i =  8; i < 10; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	strcat(a,"_");
	
	for( i = 11; i < 13; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i = 14; i < 16; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i = 17; i < 19; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	return (char*)a;
} /* cfnGetTimePac */

/* Inicio Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */
/*========================================================================================================================*/
/* Funcion que obtiene el saldo de la cartera que se encuentra pendiente desde la fecha de emision del documento a cobrar */
/*========================================================================================================================*/
int ifnSaldoVencido(long plCod_cliente, char * psFechaEmision, double *pdSaldo)
{
char modulo[]="ifnSaldoVencido";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente    ;
	int    iValorCero    = 0;
	int    iValorUno     = 1;
	double dhMontoSaldo     ;
	char   szhCartera   [11]; /* EXEC SQL VAR szhCartera   IS STRING(11); */ 
 
	char   szhTipDocum  [13]; /* EXEC SQL VAR szhTipDocum  IS STRING(13); */ 
 
    char   szFecEmision [11]; /* EXEC SQL VAR szFecEmision IS STRING(11); */ 
 
/* EXEC SQL END DECLARE SECTION; */ 


	lhCod_cliente = plCod_cliente;
	strcpy(szhCartera   ,"CO_CARTERA");
	strcpy(szhTipDocum  ,"COD_TIPDOCUM");
	strcpy(szFecEmision , psFechaEmision);

    vDTrazasLog( modulo, "\tEn funcion [%s]   ====>  Cliente [%ld] ", LOG05,modulo,lhCod_cliente);

    /* Obtenemos el saldo desde la Co_Cartera */
    /* EXEC SQL
    SELECT NVL(SUM(A.IMPORTE_DEBE - A.IMPORTE_HABER),:iValorCero)
    INTO   :dhMontoSaldo
    FROM   CO_CARTERA A
    WHERE  A.COD_CLIENTE      = :lhCod_cliente
    AND    TRUNC(A.FEC_EFECTIVIDAD) <= TO_DATE(:szFecEmision, :szhDDMMYYYY)
    AND    A.IND_FACTURADO    = :iValorUno
    AND NOT EXISTS (SELECT :iValorUno 
	                FROM  CO_CODIGOS COD
  	 	  	        WHERE COD.COD_VALOR   = A.COD_TIPDOCUM 
  		  	        AND   COD.NOM_COLUMNA = :szhTipDocum 
                    AND   COD.NOM_TABLA   = :szhCartera); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 28;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(sum((A.IMPORTE_DEBE-A.IMPORTE_HABER)),:b0) int\
o :b1  from CO_CARTERA A where (((A.COD_CLIENTE=:b2 and TRUNC(A.FEC_EFECTIVIDA\
D)<=TO_DATE(:b3,:b4)) and A.IND_FACTURADO=:b5) and  not exists (select :b5  fr\
om CO_CODIGOS COD where ((COD.COD_VALOR=A.COD_TIPDOCUM and COD.NOM_COLUMNA=:b7\
) and COD.NOM_TABLA=:b8)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1793;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&dhMontoSaldo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
    sqlstm.sqhstv[3] = (unsigned char  *)szFecEmision;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhDDMMYYYY;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&iValorUno;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&iValorUno;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhTipDocum;
    sqlstm.sqhstl[7] = (unsigned long )13;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhCartera;
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


		
	if ( (SQLCODE != SQLOK ) && (SQLCODE != SQLNOTFOUND))	{
		iDError(modulo,ERR000,vInsertarIncidencia,"Select Saldo Vencido ",SQLERRM);
		return -1;
	}

	*pdSaldo = dhMontoSaldo;

	return 0;

} /* end ifnSaldoVencido */
/* Fin Requerimiento de Soporte - #68003 - 14.07.2008 Soporte - MQG */


/******************************************************************************************/
/** Informaci¢n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi¢n                                            : */
/**  %PR% */
/** Autor de la Revisi¢n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi¢n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci¢n de la Revisi¢n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

