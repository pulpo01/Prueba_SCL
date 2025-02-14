
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
    "./pc/BalanceInicial.pc"
};


static unsigned int sqlctx = 220254827;


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
   unsigned char  *sqhstv[6];
   unsigned long  sqhstl[6];
            int   sqhsts[6];
            short *sqindv[6];
            int   sqinds[6];
   unsigned long  sqharm[6];
   unsigned long  *sqharc[6];
   unsigned short  sqadto[6];
   unsigned short  sqtdso[6];
} sqlstm = {12,6};

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

 static char *sq0003 = 
"select A.COD_ITEM ,B.COD_TIPDOCUM ,B.IMP_PAGO  from FAD_CONFBALANCE A ,CO_PA\
GOS B where (((((A.COD_ORIGEN='PAGOS' and B.COD_CLIENTE=:b0) and B.FEC_EFECTIV\
IDAD>=TO_DATE(:b1,'YYYYMMDD')) and B.FEC_EFECTIVIDAD<=TO_DATE(:b2,'YYYYMMDD'))\
 and B.COD_TIPDOCUM=A.COD_TIPDOCUM) and A.COD_TIPDOCUM not  in (select COD_VAL\
OR  from CO_CODIGOS where (NOM_COLUMNA='COD_TIPDOCUM' and NOM_TABLA='CO_CARTER\
A'))) order by B.COD_CLIENTE,A.COD_ITEM,B.COD_TIPDOCUM            ";

 static char *sq0004 = 
"select A.COD_ITEM ,B.COD_TIPDOCUM ,B.IMPORTE_DEBE  from FAD_CONFBALANCE A ,C\
O_CARTERA B where ((((((A.COD_ORIGEN='CARTE' and B.COD_CLIENTE=:b0) and B.FEC_\
EFECTIVIDAD>=TO_DATE(:b1,'YYYYMMDD')) and B.FEC_EFECTIVIDAD<=TO_DATE(:b2,'YYYY\
MMDD')) and B.COD_TIPDOCUM=A.COD_TIPDOCUM) and B.IND_FACTURADO=1) and A.COD_TI\
PDOCUM not  in (select COD_VALOR  from CO_CODIGOS where (NOM_COLUMNA='COD_TIPD\
OCUM' and NOM_TABLA='CO_CARTERA'))) order by B.COD_CLIENTE,A.COD_ITEM,B.COD_TI\
PDOCUM            ";

 static char *sq0005 = 
"select A.COD_ITEM ,B.COD_TIPDOCUM ,B.IMPORTE_HABER  from FAD_CONFBALANCE A ,\
CO_CANCELADOS B where (((((B.COD_CLIENTE=:b0 and B.FEC_EFECTIVIDAD>=TO_DATE(:b\
1,'YYYYMMDD')) and B.FEC_EFECTIVIDAD<=TO_DATE(:b2,'YYYYMMDD')) and B.COD_TIPDO\
CUM=A.COD_TIPDOCUM) and A.COD_ORIGEN='VENCI') and A.COD_TIPDOCUM not  in (sele\
ct COD_VALOR  from CO_CODIGOS where (NOM_COLUMNA='COD_TIPDOCUM' and NOM_TABLA=\
'CO_CARTERA'))) order by B.COD_CLIENTE,A.COD_ITEM,B.COD_TIPDOCUM            ";

 static char *sq0007 = 
"select distinct COD_CLIENTE  from FA_CICLOCLI where ((((COD_CLIENTE>=:b0 and\
 COD_CLIENTE<=:b1) and COD_CICLO=:b2) and IND_MASCARA=1) and NUM_PROCESO>=0)  \
         ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,133,0,3,45,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,
0,
44,0,0,2,178,0,5,79,0,0,6,6,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,
83,0,0,3,454,0,9,499,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
110,0,0,3,0,0,13,529,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
141,0,0,3,0,0,15,624,0,0,0,0,0,1,0,
156,0,0,4,484,0,9,706,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
183,0,0,4,0,0,13,735,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
214,0,0,4,0,0,15,837,0,0,0,0,0,1,0,
229,0,0,5,464,0,9,919,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
256,0,0,5,0,0,13,949,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
287,0,0,5,0,0,15,1048,0,0,0,0,0,1,0,
302,0,0,6,144,0,4,1078,0,0,4,1,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,1,3,0,0,
333,0,0,7,163,0,9,1295,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
360,0,0,7,0,0,13,1316,0,0,1,0,0,1,0,2,3,0,0,
379,0,0,8,214,0,4,1438,0,0,6,4,0,1,0,2,4,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : CargaBalance.pc                                          * */
/* *  Carga tablas de balance                                            * */
/* *  Autor : Nelson Contreras Helena                                    * */
/* *  Fecha : 08-02-5-2002                       						 * */
/* *  Parametros :  Codigo de Ciclo de Facturacion           			 * */
/* *            Cliente Inicial                 						 * */
/* *            Cliente Final                   						 * */
/* *            Nivel de log                    						 * */
/* *********************************************************************** */
#include <deftypes.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include "CargaBalance.h"

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


long    lContDoc        = 0;
char    szFecha[20]     = "";
long    lContClientes   = 0;

int ifnInsertaFatBalance (long  lCod_Cliente, int iCod_Item, int iCod_Docum, int iCod_CiclFact, int iCant_Docum, double dImp_Docum)
{
char modulo[]="ifnInsertaFatBalance";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCod_Cliente;
        int     ihCod_Item;
        int     ihCod_Docum;
        int     ihCod_CiclFact;
        int     ihCant_Docum;
        double  dhImp_Docum;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCod_Cliente   = lCod_Cliente;
    ihCod_Item      = iCod_Item;
    ihCod_Docum     = iCod_Docum;
    ihCod_CiclFact  = iCod_CiclFact;
    ihCant_Docum    = iCant_Docum;
    dhImp_Docum     = dImp_Docum;

    /* EXEC SQL
        INSERT INTO FAT_BALANCE
            (COD_CLIENTE    ,
             COD_ITEM   ,
             COD_TIPDOCUM   ,
             COD_CICLFACT   ,
             CAN_DOCUMENTO  ,
             IMP_DOCUMENTO  )
        VALUES (:lhCod_Cliente  ,
                :ihCod_Item     ,
                :ihCod_Docum    ,
                :ihCod_CiclFact ,
                :ihCant_Docum   ,
                :dhImp_Docum    ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_BALANCE (COD_CLIENTE,COD_ITEM,COD_TIPDOCU\
M,COD_CICLFACT,CAN_DOCUMENTO,IMP_DOCUMENTO) values (:b0,:b1,:b2,:b3,:b4,:b5)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_Cliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCod_Item;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCod_Docum;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_CiclFact;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCant_Docum;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&dhImp_Docum;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
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



    vDTrazasLog  (modulo, "\n=> VALORES A INSERTAR "
                          "\n\t lhCod_Cliente   [%ld]"
                          "\n\t ihCod_Item      [%i]"
                          "\n\t ihCod_Docum     [%i]"
                          "\n\t ihCod_CiclFact  [%i]"
                          "\n\t ihCant_Docum    [%i]"
                          "\n\t dhImp_Docum     [%ld]"
                          "\n\t sqlca.sqlcode   [%ld]"
                          , LOG05, lhCod_Cliente, ihCod_Item
                          , ihCod_Docum, ihCod_CiclFact
                          , ihCant_Docum, dhImp_Docum, sqlca.sqlcode   );


    if (sqlca.sqlcode != SQLOK)
    {
        if (sqlca.sqlcode == -1)
        {
            vDTrazasLog  ("ifnInsertaFatBalance", "LLEGO AL UPDATE\n" , LOG05);

            /* EXEC SQL UPDATE FAT_BALANCE
                SET     IMP_DOCUMENTO   = IMP_DOCUMENTO + :dhImp_Docum ,
                    CAN_DOCUMENTO   = CAN_DOCUMENTO + :ihCant_Docum
                WHERE   COD_CLIENTE = :lhCod_Cliente
                AND     COD_ITEM    = :ihCod_Item
                AND     COD_TIPDOCUM    = :ihCod_Docum
                AND COD_CICLFACT    = :ihCod_CiclFact; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 6;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=(IMP_DOCUME\
NTO+:b0),CAN_DOCUMENTO=(CAN_DOCUMENTO+:b1) where (((COD_CLIENTE=:b2 and COD_IT\
EM=:b3) and COD_TIPDOCUM=:b4) and COD_CICLFACT=:b5)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )44;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&dhImp_Docum;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCant_Docum;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
            sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_Item;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihCod_Docum;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_CiclFact;
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
    }

    return (sqlca.sqlcode);
}

/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
    char modulo[]="main";
    char *szUserid_Aux;

    extern  char *optarg             ;
    char    opt[]=":u:c:g:h:l:" ;
    int     iOpt =0                  ;
    BOOL    bRetorno = FALSE         ;
    int      sts;
    char    szHelpString[1024] = " " ;

    memset(&stLineaComando,0    ,sizeof(CARGABALANCELINEACOMANDO));


    sprintf(szHelpString,"\n Argumentos de entrada de proceso : "
                         "\n\t -u Usuario/Password"
                         "\n\t -c Ciclo de Facturacion"
                         "\n\t -g Codigo Cliente Inicial"
                         "\n\t -h Codigo Cliente Final"
                         "\n\t -l Nivel de Log\n");

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
            case 'u':

                strcpy(stLineaComando.szUsuario, optarg);
                if((szUserid_Aux=(char *)strstr(stLineaComando.szUsuario,"/")) == (char *)NULL)
                {
                    fprintf(stderr, "\nUsuario Oracle no es valido\n");
                    return(1);
                }
                else
                {
                    strncpy(stLineaComando.szUser,stLineaComando.szUsuario, szUserid_Aux-stLineaComando.szUsuario);
                    strcpy(stLineaComando.szPass, szUserid_Aux+1);
                }

                    break;
            case 'c':
                if (strlen (optarg))
                {
                    stLineaComando.iCodCiclFact = atoi (optarg);
                    fprintf (stdout," -c%d ", stLineaComando.iCodCiclFact);
                }
                break;
            case 'g':
                if (strlen (optarg))
                {
                    stLineaComando.lCodClienteIni = atoi (optarg);
                    fprintf (stdout," -g%d ", stLineaComando.lCodClienteIni);
                }
                else
                {
                    fprintf(stdout,"Error, Falta parametro Cliente Desde\n" );
                    return 1;
                }
                break;
            case 'h':
                if (strlen (optarg))
                {
                    stLineaComando.lCodClienteFin = atoi (optarg);
                    fprintf (stdout," -h%d ", stLineaComando.lCodClienteFin);
                }
                break;
            case 'l':
                if (strlen (optarg) )
                {
                    stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    fprintf (stdout,"-l%d ", stStatus.LogNivel)     ;
                }
                break;


        }/*End Switch */

    } /* End While */
    fprintf (stdout,"\n");

    /* Validacion de Parametros */

    if ( stLineaComando.lCodClienteIni <= 0 )
    {
        fprintf(stderr, "\n\tCliente Inicial Invalido o no ingresado\n");
        fprintf(stderr,"%s",szHelpString);
        return (1);
    }

    if ( stLineaComando.lCodClienteFin <= 0 )
    {
        fprintf(stderr, "\n\tCliente Final Invalido o no ingresado\n");
        fprintf(stderr,"%s",szHelpString);
        return (1);
    }

    if ( stLineaComando.lCodClienteFin < stLineaComando.lCodClienteIni )
    {
        fprintf(stderr, "\n\tCliente Final Menor que Cliente Inicial\n");
        fprintf(stderr,"%s",szHelpString);
        return (1);
    }

    if ( !stLineaComando.iCodCiclFact )
    {
        fprintf(stderr, "\n\tCiclo facturacion invalido o no ingresado\n");
        fprintf(stderr,"%s",szHelpString);
        return (1);
    }


    if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF     ;

    stLineaComando.iNivLog = stStatus.LogNivel;

    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return (2);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------\n",
                stLineaComando.szUser);
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))
        return FALSE;

    /*************************************************************************/
    /* Crear archivos y directorios de log y errores */

    sts = ifnAbreArchivosLog();


    if ( sts != 0 ) return sts;

    /*************************************************************************/

    vDTrazasLog  ( modulo ,"\n\n\t*******************************************"
                           "\n\n\t****          Log   CargaBalance         **"
                           "\n\n\t*******************************************"
                           "\n\t\t***  Parametro de Entrada CargaBalance  ***"
                           "\n\t\t=> Usuario               [%s]"
                           "\n\t\t=> Ciclo Facturacion     [%d]"
                           "\n\t\t=> Cliente Inicial       [%d]"
                           "\n\t\t=> Cliente Final         [%d]"
                           "\n\t\t=> Niv.Log               [%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.iCodCiclFact
                           ,stLineaComando.lCodClienteIni
                           ,stLineaComando.lCodClienteFin
                           ,stLineaComando.iNivLog);

    /*************************************************************************/
    /*          Proceso Principal                       */
    /*************************************************************************/

    strcpy(modulo,"bCargaBalances");

    vDTrazasLog  ( modulo ,"\n\t\t***  Inicio Proceso principal  ***"
                           ,LOG03);

    bRetorno = bObtieneFechasCiclo(stLineaComando.iCodCiclFact);

    iContLeidos = 0;
    iContTotal  = 0;
    bIndPrimera = TRUE;


    if (!bfnValidaTrazaProc(stLineaComando.iCodCiclFact, iPROC_BALANCE, iIND_FACT_ENPROCESO))
        return FALSE;
    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnValidaTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnValidaTrazaProc", LOG01);
        return FALSE;
    }
    bfnSelectTrazaProc (stLineaComando.iCodCiclFact, iPROC_BALANCE, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);

    bRetorno = bProcesaClientes();


    if (  bRetorno )
        bRetorno = bInsertaRestantes();

    /*************************************************************************/
    /*************************************************************************/
    if (!bfnSelectSysDate(szFecha))
        return FALSE;

    if (!bRetorno) {
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Carga Balance Termino con Error");
    }
    else
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_OK;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Carga Balance Terminado OK");
    }


    bPrintTrazaProc(stTrazaProc);

    if(!bfnUpdateTrazaProc(stTrazaProc))
        return FALSE;
    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnUpdateTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnUpdateTrazaProc", LOG01);
        return FALSE;
    }
    /********************************************************************************/
    if(!bRetorno)
    {
        vDTrazasError( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado de Forma Irregular"
                               " \n\t------------------------------------"
                               ,LOG03);
        return 3;
    }
    else
    {
        vDTrazasLog  ( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado Correctamente"
                               " \n\t------------------------------------\n"
                               ,LOG03);
        vDTrazasError( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado Correctamente"
                               " \n\t------------------------------------\n"
                               ,LOG03);
        if ( !fnOraCommit())
        {
            vDTrazasLog ( modulo , " \n\t------------------------------------"
                                   " \n\tFallo en el Commit"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            vDTrazasError( modulo ," \n\t------------------------------------"
                                   " \n\tFallo en el Commit"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            return 4;
        }

    }

    if(!bfnDisconnectORA(0))
    {
      vDTrazasLog  ( modulo ,"\n\t--------------------------------------------"
                             "\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
      vDTrazasError( modulo ,"\n\t--------------------------------------------"
                             "\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
    }
    else
    {
      vDTrazasLog  ( modulo ,"\n\t--------------------------------------------"
                             "\n\tDesconectado de  ORACLE"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
      vDTrazasError( modulo ,"\n\t--------------------------------------------"
                             "\n\tDesconectado de  ORACLE"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);

    }

    vDTrazasLog  ( modulo , "\n\t\t%s***  Estadisticas Finales  ***\n"
                            "\n\t\t            Clientes Procesados : %d\n"
                           ,LOG03
                           ,cfnGetTime(3)
                           ,lContClientes);


    return (0);
}/* ********************* Fin Main * *************************************** */

/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog(void)
{
    char modulo[]="ifnAbreArchivosLog";

    char *pathDir;
    char szArchivo[32]="";
    char szPath[128]="";
    char szComando[128]="";
    char szRechazadosName[32];

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"CargaBalance"); /* 'FaSched' */

    pathDir=(char *)malloc(128);
    pathDir=szGetEnv("XPF_LOG");
    sprintf(szPath,"%s/CargaBalance/%s",pathDir,cfnGetTime(2)); /* '....log/FaSched/YYYYMMDD/' */
    free(pathDir);

    fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
    sprintf(szComando,"mkdir -p %s", szPath);
    system (szComando);

    fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

    sprintf(stStatus.ErrName,"%s/%s_%s.err",szPath,szArchivo,cfnGetTime(5));
    if((stStatus.ErrFile = fopen(stStatus.ErrName,"w")) == (FILE*)NULL )/* "wb+" */
    {   fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
        return -7;    }

    vDTrazasError(modulo, "%s  << Abre Archivo de Errores >>", LOG04, cfnGetTime(1));

    sprintf(stStatus.LogName,"%s/%s_%s.log",szPath,szArchivo,cfnGetTime(5));
    if((stStatus.LogFile = fopen(stStatus.LogName,"w")) == (FILE*)NULL ) /* "wb+" */
    {   fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
        vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return -8;    }

    vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG04, cfnGetTime(1));


    vDTrazasLog(modulo, "%s << Inicio de CargaBalance >>" , LOG03, cfnGetTime(1));

    return 0;


} /* Fin ifnAbreArchivosLog  */



/********* Procesos para Cargar Tablas de Balance                             ****/
BOOL bCargaCoPagos(long lCodCliente)
{
char modulo[]="bCargaCoPagos";
BOOL r;
BOOL ret;
BOOL bIndInsert;
int i;

long  lCodClienteAux;
int   iCodDocumAux;
int   iCodItemAux;
float fAcumImporte;
int   iContDocum;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     iCodCiclFact;
    long    lCodCli;
    char    szFecDesde[15];
    char    szFecHasta[15];
/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclFact= stLineaComando.iCodCiclFact;
    lCodCli     = lCodCliente;

    strcpy(szFecDesde,sthFaCicloFact.szhFecDesdeLLam);
    strcpy(szFecHasta,sthFaCicloFact.szhFecHastaLLam);

    vDTrazasLog  ( modulo , "\n\t** Select en CO_PAGOS **"
                            "\n\t Cliente         : [%d]"
                            "\n\t Fecha Desde     : [%s]"
                            "\n\t Fecha Hasta     : [%s]"
                            ,LOG05,lCodCli,szFecDesde,szFecHasta);

    /* EXEC SQL DECLARE Cursor_Pagos CURSOR FOR
        SELECT  A.COD_ITEM,
                B.COD_TIPDOCUM,
                B.IMP_PAGO
        FROM FAD_CONFBALANCE A,
             CO_PAGOS        B
        WHERE A.COD_ORIGEN      = 'PAGOS'
        AND   B.COD_CLIENTE     = :lCodCli
        AND   B.FEC_EFECTIVIDAD >= TO_DATE(:szFecDesde,'YYYYMMDD')
        AND   B.FEC_EFECTIVIDAD <= TO_DATE(:szFecHasta,'YYYYMMDD')
        AND   B.COD_TIPDOCUM    = A.COD_TIPDOCUM
        AND   A.COD_TIPDOCUM NOT IN (SELECT COD_VALOR
                                         FROM CO_CODIGOS
                                        WHERE NOM_COLUMNA = 'COD_TIPDOCUM'
                                          AND NOM_TABLA = 'CO_CARTERA')
        ORDER BY B.COD_CLIENTE,A.COD_ITEM,B.COD_TIPDOCUM; */ 


    if ( SQLCODE != SQLOK  && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE Cursor_Pagos  ***"
                              ,LOG03);
        vDTrazasError(modulo,"%s Error DECLARE Cursor_Pagos %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }


    /* EXEC SQL OPEN Cursor_Pagos ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )83;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodCli;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szFecDesde;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szFecHasta;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN Cursor_Pagos  ***"
                              ,LOG03);

        vDTrazasError(modulo,"%s Error OPEN Cursor_Pagos %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    ret = TRUE ;

    iContLeidos     = 0;
    iContTotal      = 0;
    bIndPrimera     = TRUE;

    lCodClienteAux  = 0;
    iCodDocumAux    = 0;
    iCodItemAux     = 0;
    fAcumImporte    = 0.0;
    iContDocum      = 0;


    /* Proceso sobre CO_PAGOS */
    while ( ret )
    {
        /* EXEC SQL FETCH Cursor_Pagos INTO
               :sthCoPagos; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )110;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&sthCoPagos->lhCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&sthCoPagos->ihCodItem;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&sthCoPagos->ihCodDocum;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&sthCoPagos->fhImpPago;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
        sqlstm.sqhsts[3] = (         int  )sizeof(struct COPAGOS);
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



        if ( iContLeidos == 0 )
            iContLeidos = sqlca.sqlerrd[2];
        else
            iContLeidos =  sqlca.sqlerrd[2] - iContTotal;

        iContTotal  = sqlca.sqlerrd[2];

        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE == SQLNOTFOUND )
                ret = FALSE;
            else
            {
                vDTrazasLog  (modulo,"\n\t** Error FETCH Cursor_Pagos  ***"
                                      ,LOG01);
                vDTrazasError(modulo,"\n\t Error FETCH Cursor_Pagos %s\n"
                                    ,LOG03,sqlca.sqlerrm.sqlerrmc);
                fnOraRollBack();
                return FALSE;
            }
        }

        /**** Procesa clientes leidos en FETCH de Pagos ****/
        vDTrazasLog  ( modulo ,"\n\t\t** Pagos leidos : [%d]  ***"
                              ,LOG05,iContLeidos);

        lCodClienteAux = lCodCli;

        if ( bIndPrimera )
        {
            iCodItemAux    = sthCoPagos[0].ihCodItem;
            iCodDocumAux   = sthCoPagos[0].ihCodDocum;
            fAcumImporte   = 0 ;
            bIndPrimera    = FALSE;

        }

        for ( i = 0; i< iContLeidos  ; i++)
        {
            if ((sthCoPagos[i].ihCodItem    != iCodItemAux)     ||
                (sthCoPagos[i].ihCodDocum   != iCodDocumAux)    )
            {
                bIndInsert=bInsertaBalances (lCodClienteAux
                                            ,iCodItemAux
                                            ,iCodDocumAux
                                            ,fAcumImporte
                                            ,iContDocum);

                if ( !bIndInsert )
                {
                    vDTrazasLog  ( modulo ,"\n\t\t** Error en Insert en FAT_BALANCE  ***"
                                          ,LOG03);
                    vDTrazasError(modulo,"%s Error  Error en Insert en FAT_BALANCE \n"
                                ,LOG03
                                ,cfnGetTime(3));
                    fnOraRollBack();
                    return FALSE;
                }

                iCodItemAux    = sthCoPagos[i].ihCodItem;
                iCodDocumAux   = sthCoPagos[i].ihCodDocum;
                fAcumImporte   = sthCoPagos[i].fhImpPago;
                iContDocum     = 1;
            }
            else
            {
                fAcumImporte   = fAcumImporte + sthCoPagos[i].fhImpPago;
                iContDocum     ++;
            }
        }     /* Fin For */

        if ( !ret  && iContLeidos > 0 )
        {
            bIndInsert=bInsertaBalances (lCodClienteAux
                                        ,iCodItemAux
                                        ,iCodDocumAux
                                        ,fAcumImporte
                                        ,iContDocum);
            if ( !bIndInsert )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error en Insert en FAT_BALANCE  ***"
                                      ,LOG03);

                vDTrazasError(modulo,"%s Error en Insert en FAT_BALANCE \n"
                                    ,LOG03
                                    ,cfnGetTime(3));
                fnOraRollBack();
                return FALSE;
            }
        }
    } /* Fin While FETCH Cursor_Pagos */

    /* EXEC SQL CLOSE Cursor_Pagos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )141;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error CLOSE Cursor_Pagos  ***"
                              ,LOG03);
        vDTrazasError(modulo,"%s Error CLOSE Cursor_Pagos %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    return TRUE;
} /* Fin bCargaCoPagos() */



BOOL bCargaCoCartera(long lCodCliente)
{
char modulo[]="bCargaCoCartera";
BOOL r;
BOOL ret;
BOOL bIndInsert;
int i;

long  lCodClienteAux;
int   iCodDocumAux;
int   iCodItemAux;
float fAcumImporte;
int   iContDocum;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     iCodCiclFact;
    long    lCodCli;
    char    szFecDesde[15];
    char    szFecHasta[15];
/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclFact    = stLineaComando.iCodCiclFact;
    lCodCli         = lCodCliente;
    strcpy(szFecDesde,sthFaCicloFact.szhFecDesdeLLam);
    strcpy(szFecHasta,sthFaCicloFact.szhFecHastaLLam);

    vDTrazasLog  ( modulo , "\n\t** Select en CO_CARTERA **"
                            "\n\t Cliente         : [%d]"
                            "\n\t Fecha Desde     : [%s]"
                            "\n\t Fecha Hasta     : [%s]"
                            ,LOG05, lCodCli,szFecDesde,szFecHasta);

    /* EXEC SQL DECLARE Cursor_Cartera CURSOR FOR
        SELECT  A.COD_ITEM,
                B.COD_TIPDOCUM,
                B.IMPORTE_DEBE
        FROM FAD_CONFBALANCE A,
             CO_CARTERA      B
        WHERE A.COD_ORIGEN       = 'CARTE'
        AND   B.COD_CLIENTE      = :lCodCli
        AND   B.FEC_EFECTIVIDAD >= TO_DATE(:szFecDesde,'YYYYMMDD')
        AND   B.FEC_EFECTIVIDAD <= TO_DATE(:szFecHasta,'YYYYMMDD')
        AND   B.COD_TIPDOCUM     = A.COD_TIPDOCUM
        AND   B.IND_FACTURADO    = 1                    /o NCH 09-10-2002 o/
        AND   A.COD_TIPDOCUM NOT IN (SELECT COD_VALOR
                                         FROM CO_CODIGOS
                                        WHERE NOM_COLUMNA = 'COD_TIPDOCUM'
                                          AND NOM_TABLA = 'CO_CARTERA')
        ORDER BY B.COD_CLIENTE,A.COD_ITEM,B.COD_TIPDOCUM; */ 



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE Cursor_Cartera  ***"
                              ,LOG03);

        vDTrazasError(modulo,"%s Error DECLARE Cursor_Cartera %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }


    /* EXEC SQL OPEN Cursor_Cartera ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )156;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodCli;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szFecDesde;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szFecHasta;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN Cursor_Cartera  ***"
                              ,LOG03);
        vDTrazasError(modulo,"%s Error OPEN Cursor_Cartera %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    ret = TRUE ;

    iContLeidos     = 0;
    iContTotal      = 0;
    bIndPrimera     = TRUE;

    lCodClienteAux  = 0;
    iCodDocumAux    = 0;
    iCodItemAux     = 0;
    fAcumImporte    = 0.0;
    iContDocum      = 0;


    /* Proceso sobre CO_CARTERA */
    while ( ret )
    {
        /* EXEC SQL FETCH Cursor_Cartera INTO
               :sthCoCartera; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )183;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&sthCoCartera->lhCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(struct COCARTERA);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&sthCoCartera->ihCodItem;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(struct COCARTERA);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&sthCoCartera->ihCodDocum;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(struct COCARTERA);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&sthCoCartera->fhImpPago;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
        sqlstm.sqhsts[3] = (         int  )sizeof(struct COCARTERA);
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



        if ( iContLeidos == 0 )
            iContLeidos = sqlca.sqlerrd[2];
        else
            iContLeidos =  sqlca.sqlerrd[2] - iContTotal;

        iContTotal  = sqlca.sqlerrd[2];

        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE == SQLNOTFOUND )
                ret = FALSE;
            else
            {
                vDTrazasLog  (modulo,"\n\t\t** Error FETCH Cursor_Cartera  ***"
                                    ,LOG03);
                vDTrazasError(modulo,"%s Error FETCH Cursor_Cartera %s\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc);
                fnOraRollBack();
                return FALSE;
            }
        }

        /**** Procesa clientes leidos en FETCH de Co Cartera ****/

        vDTrazasLog  ( modulo ,"\n\t\t** Co Cartera leidos : [%d]  ***"
                              ,LOG05
                              ,iContLeidos);

        lCodClienteAux = lCodCli;

        if ( bIndPrimera )
        {
            iCodItemAux    = sthCoCartera[0].ihCodItem;
            iCodDocumAux   = sthCoCartera[0].ihCodDocum;
            fAcumImporte   = 0 ;
            bIndPrimera    = FALSE;
        }

        for ( i = 0; i< iContLeidos  ; i++)
        {
            if ((sthCoCartera[i].ihCodItem    != iCodItemAux)       ||
                (sthCoCartera[i].ihCodDocum   != iCodDocumAux)      )
            {
                bIndInsert=bInsertaBalances (lCodClienteAux
                                            ,iCodItemAux
                                            ,iCodDocumAux
                                            ,fAcumImporte
                                            ,iContDocum);
                if ( !bIndInsert )
                {
                    vDTrazasLog  ( modulo ,"\n\t\t** Error en Insert en FAT_BALANCE  ***"
                                          ,LOG03);

                    vDTrazasError(modulo,"%s Error  Error en Insert en FAT_BALANCE \n"
                                        ,LOG03
                                        ,cfnGetTime(3));

                    fnOraRollBack();

                    return FALSE;
                }
                iCodItemAux    = sthCoCartera[i].ihCodItem;
                iCodDocumAux   = sthCoCartera[i].ihCodDocum;
                fAcumImporte   = sthCoCartera[i].fhImpPago;
                iContDocum     = 1;
            }
            else
            {
                fAcumImporte   = fAcumImporte + sthCoCartera[i].fhImpPago;
                iContDocum     ++;
            }
        }     /* Fin For */

        if ( !ret && iContLeidos > 0)
        {
            bIndInsert=bInsertaBalances (lCodClienteAux
                                        ,iCodItemAux
                                        ,iCodDocumAux
                                        ,fAcumImporte
                                        ,iContDocum);

            if ( !bIndInsert )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error en Insert en FAT_BALANCE  ***"
                                      ,LOG03);

                vDTrazasError(modulo,"%s Error en Insert en FAT_BALANCE \n"
                                    ,LOG03
                                    ,cfnGetTime(3));

                fnOraRollBack();

                return FALSE;
            }
        }
    } /* Fin While FETCH Cursor_Cartera */

    /* EXEC SQL CLOSE Cursor_Cartera; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )214;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo ,"\n\t\t** Error CLOSE Cursor_Cartera  ***",LOG03);
        vDTrazasError(modulo,"%s Error CLOSE Cursor_Cartera %s\n"
                            ,LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    return TRUE;

} /* Fin bCargaCoCartera() */


BOOL bCargaCoCancelados(long lCodCliente)
{
char modulo[]="bCargaCoCancelados";
BOOL r;
BOOL ret;
BOOL bIndInsert;
int i;

long  lCodClienteAux;
int   iCodDocumAux;
int   iCodItemAux;
float fAcumImporte;
int   iContDocum;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 int    iCodCiclFact;
 long   lCodCli;
 char   szFecDesde[15];
 char   szFecHasta[15];
/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclFact= stLineaComando.iCodCiclFact;
    lCodCli     = lCodCliente;

    strcpy(szFecDesde,sthFaCicloFact.szhFecDesdeLLam);
    strcpy(szFecHasta,sthFaCicloFact.szhFecHastaLLam);


    vDTrazasLog  ( modulo , "\n\t** Select en CO_CANCELADOS **"
                            "\n\t Cliente         : [%d]"
                            "\n\t Fecha Desde     : [%s]"
                            "\n\t Fecha Hasta     : [%s]"
                            ,LOG05
                            ,lCodCli
                            ,szFecDesde
                            ,szFecHasta);

    /* EXEC SQL DECLARE Cursor_Cancelados CURSOR FOR
        SELECT  A.COD_ITEM,
                B.COD_TIPDOCUM,
                B.IMPORTE_HABER
        FROM FAD_CONFBALANCE A,
             CO_CANCELADOS   B
        WHERE B.COD_CLIENTE      = :lCodCli
        AND   B.FEC_EFECTIVIDAD >= TO_DATE(:szFecDesde,'YYYYMMDD')
        AND   B.FEC_EFECTIVIDAD <= TO_DATE(:szFecHasta,'YYYYMMDD')
        AND   B.COD_TIPDOCUM     = A.COD_TIPDOCUM
        AND   A.COD_ORIGEN       = 'VENCI'
        AND   A.COD_TIPDOCUM NOT IN (SELECT COD_VALOR
                                         FROM CO_CODIGOS
                                        WHERE NOM_COLUMNA = 'COD_TIPDOCUM'
                                          AND NOM_TABLA = 'CO_CARTERA')
        ORDER BY B.COD_CLIENTE,A.COD_ITEM,B.COD_TIPDOCUM; */ 


    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE Cursor_Cancelados  ***"
                              ,LOG03);
        vDTrazasError(modulo,"%s Error DECLARE Cursor_Cancelados %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();

        return FALSE;
    }

    /* EXEC SQL OPEN Cursor_Cancelados ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )229;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodCli;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szFecDesde;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szFecHasta;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN Cursor_Cancelados  ***"
                              ,LOG03);

        vDTrazasError(modulo,"%s Error OPEN Cursor_Cancelados %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    ret = TRUE ;

    iContLeidos     = 0;
    iContTotal      = 0;
    bIndPrimera     = TRUE;

    lCodClienteAux  = 0;
    iCodDocumAux    = 0;
    iCodItemAux     = 0;
    fAcumImporte    = 0.0;
    iContDocum      = 0;


    /* Proceso sobre CO_CANCELADOS */
    while ( ret )
    {
        /* EXEC SQL FETCH Cursor_Cancelados INTO
                   :sthCoCancelados; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )256;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&sthCoCancelados->lhCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(struct COCANCELADOS);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&sthCoCancelados->ihCodItem;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(struct COCANCELADOS);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&sthCoCancelados->ihCodDocum;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(struct COCANCELADOS);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&sthCoCancelados->fhImpPago;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
        sqlstm.sqhsts[3] = (         int  )sizeof(struct COCANCELADOS);
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



        if ( iContLeidos == 0 )
            iContLeidos = sqlca.sqlerrd[2];
        else
            iContLeidos =  sqlca.sqlerrd[2] - iContTotal;

        iContTotal  = sqlca.sqlerrd[2];


        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE == SQLNOTFOUND )
                ret = FALSE;
            else
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error FETCH Cursor_Cancelados  ***"
                                      ,LOG03);

                vDTrazasError(modulo,"%s Error FETCH Cursor_Cancelados %s\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc);
                fnOraRollBack();
                return FALSE;
            }
        }

        /**** Procesa clientes leidos en FETCH de Co Cancelados ****/
        vDTrazasLog  ( modulo ,"\n\t\t** Co Cancelados leidos : [%d]  ***"
                              ,LOG05
                              ,iContLeidos);

        lCodClienteAux = lCodCli;

        if ( bIndPrimera )
        {
            iCodItemAux    = sthCoCancelados[0].ihCodItem;
            iCodDocumAux   = sthCoCancelados[0].ihCodDocum;
            fAcumImporte   = 0 ;
            bIndPrimera    = FALSE;
        }

        for ( i = 0; i< iContLeidos  ; i++)
        {
            if ((sthCoCancelados[i].ihCodItem    != iCodItemAux)        ||
                (sthCoCancelados[i].ihCodDocum   != iCodDocumAux)       )
            {
                bIndInsert=bInsertaBalances (lCodClienteAux
                                            ,iCodItemAux
                                            ,iCodDocumAux
                                            ,fAcumImporte
                                            ,iContDocum);

                if ( !bIndInsert )
                {
                    vDTrazasLog  ( modulo ,"\n\t\t** Error en Insert en FAT_BALANCE  ***"
                                          ,LOG03);
                    vDTrazasError(modulo,"%s Error  Error en Insert en FAT_BALANCE \n"
                                ,LOG03
                                ,cfnGetTime(3));
                    fnOraRollBack();

                    return FALSE;
                }
                iCodItemAux    = sthCoCancelados[i].ihCodItem;
                iCodDocumAux   = sthCoCancelados[i].ihCodDocum;
                fAcumImporte   = sthCoCancelados[i].fhImpPago;
                iContDocum     = 1;
            }
            else
            {
                fAcumImporte   = fAcumImporte + sthCoCancelados[i].fhImpPago;
                iContDocum     ++;
            }
        }     /* Fin For */

        if ( !ret && iContLeidos > 0)
        {
            bIndInsert=bInsertaBalances (lCodClienteAux
                                        ,iCodItemAux
                                        ,iCodDocumAux
                                        ,fAcumImporte
                                        ,iContDocum);
            if ( !bIndInsert )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error en Insert en FAT_BALANCE  ***"
                                      ,LOG03);

                vDTrazasError(modulo,"%s Error en Insert en FAT_BALANCE \n"
                                    ,LOG03
                                    ,cfnGetTime(3));
                fnOraRollBack();
                return FALSE;
            }
        }
    } /* Fin While FETCH Cursor_Cancelados */

    /* EXEC SQL CLOSE Cursor_Cancelados; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )287;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo,"\n\t\t** Error CLOSE Cursor_Cancelados  ***",LOG03);
        vDTrazasError(modulo,"%s Error CLOSE Cursor_Cancelados %s\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    return TRUE;

} /* Fin bCargaCoCancelados() */


BOOL bObtieneFechasCiclo(int iCodCiclFact)
{
char modulo[]="bObtieneFechasCiclo";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    iCodCiclo;
    char    szFecDesde[15];/* EXEC SQL VAR szFecDesde IS STRING (15); */ 

    char    szFecHasta[15];/* EXEC SQL VAR szFecHasta IS STRING (15); */ 

    int     iCodCicloCli;
/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclo = iCodCiclFact;

    /* EXEC SQL
    SELECT TO_CHAR(FEC_DESDELLAM,'YYYYMMDD'),
           TO_CHAR(FEC_HASTALLAM,'YYYYMMDD'),
           COD_CICLO  INTO
           :szFecDesde,
           :szFecHasta,
           :iCodCicloCli
    FROM FA_CICLFACT
    WHERE COD_CICLFACT = :iCodCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(FEC_DESDELLAM,'YYYYMMDD') ,TO_CHAR(FEC_HAS\
TALLAM,'YYYYMMDD') ,COD_CICLO into :b0,:b1,:b2  from FA_CICLFACT where COD_CIC\
LFACT=:b3";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )302;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szFecDesde;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szFecHasta;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iCodCicloCli;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iCodCiclo;
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




    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo ,"\n\t\t** Error Select FA_CICLFACT  ***"
                             ,LOG03);

        vDTrazasError(modulo,"%s Error Select FA_CICLFACT  %s\n"
                            ,LOG03
                            ,cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    strcpy(sthFaCicloFact.szhFecDesdeLLam,szFecDesde);
    strcpy(sthFaCicloFact.szhFecHastaLLam,szFecHasta);
    sthFaCicloFact.iCodCiclo = iCodCicloCli;

    vDTrazasLog  ( modulo , "\n\t** Select en FA_CICLFACT  ***"
                            "\n\t** Fecha Desde : [%s]     ***"
                            "\n\t** Fecha Hasta : [%s]     ***"
                            ,LOG03
                            ,sthFaCicloFact.szhFecDesdeLLam
                            ,sthFaCicloFact.szhFecHastaLLam);
    return TRUE;
}



BOOL bInsertaBalances(long lCodCliente
                     ,int iCodItem
                     ,int iCodDocum
                     ,float fAcumImporteAux
                     ,int  iContDocumentos)
{
char modulo[]="bInsertaBalances";

int i ;
int Result; /* Incorporado por PGonzalez 5-07-2003 */
int j;      /* Incorporado por PGonzalez 5-07-2003 */

    vDTrazasLog  ( modulo ,"\n\t\t** bInsertaBalances : [%d]  ***"
                          ,LOG05
                          ,iContInsert);

    if ( iContInsert == MAXINSERT   )
    {
        /* Incorporado por PGonzalez 5-07-2003 Desde Aqui */
        for (j = 0; j < MAXINSERT ; j++)
        {
            Result = ifnInsertaFatBalance(  sthFatBalance[j].lhCodCliente,
                                            sthFatBalance[j].ihCodItem,
                                            sthFatBalance[j].ihCodDocum,
                                            sthFatBalance[j].ihCodCiclFact,
                                            sthFatBalance[j].ihCantDocum,
                                            sthFatBalance[j].fhImpDocum);
            if (Result != SQLOK )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error Insert FAT_BALANCES  ***", LOG03);
                vDTrazasError(modulo,"%s Error Insert Balances  %s\n", LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                fnOraRollBack();
                return FALSE;
            }
        }
        /* Incorporado por PGonzalez 5-07-2003 Hasta Aqui */

        iContInsert = 0;
    }
    else
    {
        if ( iCodItem == ITEMPAGRECIB || iCodItem == ITEMAJUSTES)
            sthFatBalance[iContInsert].fhImpDocum   = (float) fAcumImporteAux * -1;
        else
            sthFatBalance[iContInsert].fhImpDocum   = (float) fAcumImporteAux;

        sthFatBalance[iContInsert].lhCodCliente = lCodCliente;
        sthFatBalance[iContInsert].ihCodItem    = iCodItem;
        sthFatBalance[iContInsert].ihCodDocum   = iCodDocum;
        sthFatBalance[iContInsert].ihCodCiclFact= stLineaComando.iCodCiclFact;
        sthFatBalance[iContInsert].ihCantDocum  = iContDocumentos;


        vDTrazasLog  ( modulo , "\n\t\t**  Insert FAT_BALANCES  ***"
                                "\n\t\t** Cliente : [%d] **"
                                "\n\t\t** Item    : [%d] **"
                                "\n\t\t** Docum   : [%d] **"
                                "\n\t\t** Ciclo   : [%d] **"
                                "\n\t\t** No.Docu : [%d] **"
                                "\n\t\t** Importe : [%f] **"
                                ,LOG05
                                ,sthFatBalance[iContInsert].lhCodCliente
                                ,sthFatBalance[iContInsert].ihCodItem
                                ,sthFatBalance[iContInsert].ihCodDocum
                                ,sthFatBalance[iContInsert].ihCodCiclFact
                                ,sthFatBalance[iContInsert].ihCantDocum
                                ,sthFatBalance[iContInsert].fhImpDocum );

        iContInsert ++ ;
    }

    return TRUE;
}

BOOL bInsertaRestantes(void)
{
int     i;
int     Result;
char modulo[]="bInsertaRestantes";

    vDTrazasLog  ( modulo ,"\n\t\t*** Restantes Insert : [%d]  ***"
                          , LOG03, iContInsert);

    for (i =0 ; i < iContInsert ; i++)
    {
        Result = ifnInsertaFatBalance(  sthFatBalance[i].lhCodCliente,
                                        sthFatBalance[i].ihCodItem,
                                        sthFatBalance[i].ihCodDocum,
                                        sthFatBalance[i].ihCodCiclFact,
                                        sthFatBalance[i].ihCantDocum,
                                        sthFatBalance[i].fhImpDocum);

        vDTrazasLog  ( modulo , "\n\t\t****** %d ->Cliente   : [%d]  ***"
                                "\n\t\t******      Item      : [%d]  ***"
                                "\n\t\t******      Docum     : [%d]  ***"
                                "\n\t\t******      Ciclo     : [%d]  ***"
                                "\n\t\t******      Cant Docu : [%d]  ***"
                                "\n\t\t******      Importe   : [%f]  ***"
                                ,LOG05
                                ,i
                                ,sthFatBalance[i].lhCodCliente
                                ,sthFatBalance[i].ihCodItem
                                ,sthFatBalance[i].ihCodDocum
                                ,sthFatBalance[i].ihCodCiclFact
                                ,sthFatBalance[i].ihCantDocum
                                ,sthFatBalance[i].fhImpDocum );

        if (Result != SQLOK )
        {
            vDTrazasLog  ( modulo ,"\n\t\t** Error Insert FAT_BALANCES  ***", LOG03);
            vDTrazasError(modulo,"%s Error Insert Balances  %s\n", LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
            fnOraRollBack();
            return FALSE;
        }

    } /* End For */

    iContInsert = 0;

    return TRUE;
}

/************************************************************************/
/* Funcion :  bProcesaClientes                      */
/*      Realiza proceso principal de carga de balance           */
/************************************************************************/

BOOL bProcesaClientes (void)
{

char modulo[]="bProcesaClientes";
BOOL bExiste = TRUE;
int   i;
int   iContLeidos = 0;
int   iContTotal  = 0;


/* EXEC SQL BEGIN DECLARE SECTION; */ 

 int    iCodCiclo;
 long   lCodClienteIni;
 long   lCodClienteFin;
/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclo       = sthFaCicloFact.iCodCiclo;
    lCodClienteIni  = stLineaComando.lCodClienteIni;
    lCodClienteFin  = stLineaComando.lCodClienteFin;

    vDTrazasLog  ( modulo ,"\n\t\t*** bProcesaClientes    ***"
                           "\n\t\t=> Ciclo Facturacion     [%d]"
                           "\n\t\t=> Cliente Inicial       [%d]"
                           "\n\t\t=> Cliente Final         [%d]"
                           ,LOG03
                           ,stLineaComando.iCodCiclFact
                           ,stLineaComando.lCodClienteIni
                           ,stLineaComando.lCodClienteFin);

    /* EXEC SQL DECLARE Cursor_Clientes CURSOR FOR
        SELECT DISTINCT COD_CLIENTE
        FROM   FA_CICLOCLI
        WHERE  COD_CLIENTE >=   :lCodClienteIni
        AND    COD_CLIENTE <=   :lCodClienteFin
        AND    COD_CICLO    =   :iCodCiclo
        AND    IND_MASCARA  = 1
        AND    NUM_PROCESO >= 0 ; */ 



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error Declare Cusor_Clientes  ***"
                              ,LOG03);
        vDTrazasError(modulo,"%s Error Declare Cursor_Clientes  %s\n"
                            ,LOG03
                            ,cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    /* EXEC SQL OPEN Cursor_Clientes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )333;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodClienteIni;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCodClienteFin;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iCodCiclo;
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
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN  Cusor_Clientes SQLCODE : [%d] ***"
                              ,LOG03
                              ,sqlca.sqlcode);
        vDTrazasError(modulo,"%s Error Open Cursor_Clientes  %s\n"
                            ,LOG03
                            ,cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc);

        fnOraRollBack();
        return FALSE;
    }

    iContLeidos = 0;
    iContTotal  = 0;

    while ( bExiste )
    {
        /* EXEC SQL FETCH Cursor_Clientes INTO
                :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )360;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lhCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
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



        if ( iContLeidos == 0 )
            iContLeidos = sqlca.sqlerrd[2];
        else
            iContLeidos =  sqlca.sqlerrd[2] - iContTotal;

        iContTotal  = sqlca.sqlerrd[2];

        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE != SQLNOTFOUND )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error Open Cusor_Clientes  ***"
                                      ,LOG03);
                vDTrazasError(modulo,"%s Error Open Cursor_Clientes  %s\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc);
                fnOraRollBack();
                return FALSE;
            }
            else
            {
                vDTrazasLog  ( modulo ,"\n\t\t** No existen registros para proceso  ***"
                                      ,LOG03);
                bExiste = FALSE;
            }
        }

        vDTrazasLog  ( modulo ,"\n\t\t** Clientes leidos : [%d]  ***"
                              ,LOG03
                              ,iContLeidos);

        for ( i = 0 ; i < iContLeidos ; i++ )
        {
            lContClientes++;
            vDTrazasLog  ( modulo ,"\n\t\t**Procesando Cliente : [%d]  ***"
                                  ,LOG05,lhCodCliente[i]);

            if (!bCargaCoPagos(lhCodCliente[i]))
                return FALSE;

            if (!bCargaCoCartera(lhCodCliente[i]))
                return FALSE;

            if (!bCargaCoCancelados(lhCodCliente[i]))
                return FALSE;

            if (!bCargaItemesCero(lhCodCliente[i], ITEMCARGCORR, FACTCICLAFEC))
                return FALSE;

            if (!bCargaItemesCero(lhCodCliente[i], ITEMTOTFACTU, FACTCICLAFEC))
                return FALSE;

            if (!bCargaItemesCero(lhCodCliente[i], ITEMTOTPAGAR, FACTCICLAFEC))
                return FALSE;

            if (!bCargaBalanceAnterior(lhCodCliente[i]))
                return FALSE;
        }
    } /* End While */

    return TRUE;
}

/************************************************************************/
/* Funcion :  bCargaItemesCero                                          */
/* Carga itemes en cero                                                 */
/************************************************************************/

BOOL bCargaItemesCero(long lCodCliente, int iCodItem, int iCodTipDocum)
{
char modulo[]="bCargaItemesCero";
int  Result;


    Result = ifnInsertaFatBalance(  lCodCliente,
                                iCodItem,
                                iCodTipDocum,
                                stLineaComando.iCodCiclFact,
                                0,
                                0);
    if ( Result != SQLOK )
    {
        vDTrazasLog ( modulo,"\n\t\t** Error Insert FAT_BALANCES ***"
                             "\n\t\t** Codigo de Item : [%d] - Tipo de Doc. : [%d]"
                             ,LOG03, iCodItem,iCodTipDocum);
        vDTrazasError(modulo,"%s Error Insert Balances Cargos Corrientes  %s\n"
                             "\n\t\t** Codigo de Item : [%d] - Tipo de Doc. : [%d]"
                            ,LOG03, cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc, iCodItem,iCodTipDocum);
        fnOraRollBack();
        return FALSE;
    }

    return TRUE;
}


BOOL bCargaBalanceAnterior(long lCodCliente)
{
char modulo[]="bCargaBalanceAnterior";
int     Result;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodCliente;
    int     ihCodCiclo;
    int     ihCodItem;
    int     ihCodTipDocum;
    double  dImpDocumento;
    int     iCantDocum;
/* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente    = lCodCliente;
    ihCodCiclo      = stLineaComando.iCodCiclFact;
    ihCodItem       = ITEMTOTPAGAR;
    ihCodTipDocum   = FACTCICLAFEC;

   /* Obtiene balance anterior de tablas historicas */

    /* EXEC  SQL
          SELECT IMP_DOCUMENTO, CAN_DOCUMENTO INTO
               :dImpDocumento, :iCantDocum
          FROM FAH_BALANCE
          WHERE COD_CLIENTE = :lCodCliente AND
                FEC_HISTORICO = ( SELECT MAX(FEC_HISTORICO)
                                  FROM FAH_BALANCE
                                  WHERE COD_CLIENTE = :lCodCliente
                                  AND   COD_ITEM = :ihCodItem)
                AND COD_ITEM = :ihCodItem ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IMP_DOCUMENTO ,CAN_DOCUMENTO into :b0,:b1  from FA\
H_BALANCE where ((COD_CLIENTE=:b2 and FEC_HISTORICO=(select max(FEC_HISTORICO)\
  from FAH_BALANCE where (COD_CLIENTE=:b2 and COD_ITEM=:b4))) and COD_ITEM=:b4\
)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )379;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dImpDocumento;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iCantDocum;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodItem;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodItem;
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



    if ( SQLCODE != SQLOK )
    {
        if (SQLCODE == SQLNOTFOUND)
        {
            vDTrazasLog  ( modulo ,"\n\t\t** Cliente %d sin balance anterior  ***"
                                  ,LOG03,lCodCliente);
            dImpDocumento = 0;
            iCantDocum = 0;
        }
        else
        {
            vDTrazasLog  ( modulo ,"\n\t\t** Error Select FAH_BALANCE  ***",LOG03);
            vDTrazasError(modulo,"%s  Error Select FAH_BALANCE  %s\n"
                    ,LOG03
                    ,cfnGetTime(3)
                    ,sqlca.sqlerrm.sqlerrmc);
            fnOraRollBack();
            return FALSE;
        }
    }

    ihCodItem    =ITEMBALANTER;

    vDTrazasLog  ( modulo ,"\n dImpDocumento [%ld]\n", LOG03, dImpDocumento);

    Result = ifnInsertaFatBalance(lhCodCliente,
                              ihCodItem,
                              ihCodTipDocum,
                              ihCodCiclo,
                              iCantDocum,
                              dImpDocumento);


    if ( Result != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error Insert FAT_BALANCE Balance Anterior ***", LOG03);
        vDTrazasError(modulo,"%s  Error Insert FAT_BALANCE Balance Anterior %s\n"
                     ,LOG03,cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);
        fnOraRollBack();
        return FALSE;
    }

    return TRUE;
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

