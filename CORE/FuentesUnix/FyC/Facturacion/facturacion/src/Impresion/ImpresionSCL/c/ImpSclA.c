
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
           char  filnam[16];
};
static const struct sqlcxp sqlfpn =
{
    15,
    "./pc/ImpSclA.pc"
};


static unsigned int sqlctx = 1728643;


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
   unsigned char  *sqhstv[13];
   unsigned long  sqhstl[13];
            int   sqhsts[13];
            short *sqindv[13];
            int   sqinds[13];
   unsigned long  sqharm[13];
   unsigned long  *sqharc[13];
   unsigned short  sqadto[13];
   unsigned short  sqtdso[13];
} sqlstm = {12,13};

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
"select NVL(NUM_MES,:b0) ,NVL(NUM_MINREBA,:b0) ,NVL(NUM_MINADIC,:b0) ,NVL(MTO\
_FACTCICLO,:b0)  from FAT_CONMESCLIE where ((COD_CLIENTE=:b4 and NUM_MES<=:b5)\
 and NUM_MES>=:b6) order by NUM_MES desc             ";

 static const char *sq0009 = 
"select COD_CICLFACT ,MTO_FACTCICLO  from FA_CONSUMO_CICLO_CLIE_TO where (COD\
_CLIENTE=:b0 and ROWNUM<=:b1) order by FEC_EMISION asc             ";

 static const char *sq0004 = 
"select A.CORR_MENSAJE ,B.NUM_LINEA ,C.CANT_CARACTLIN ,LTRIM(RTRIM(NVL(B.COD_\
IDIOMA,'1')))  from FA_MENSCICLO A ,FA_MENSAJES B ,FA_PARMENSAJE C where (((((\
(A.COD_CLIENTE=:b0 and A.COD_FORMULARIO=:b1) and B.COD_IDIOMA=:b2) and A.IND_F\
ACTURADO=:b3) and B.CORR_MENSAJE=A.CORR_MENSAJE) and A.COD_FORMULARIO=C.COD_FO\
RMULARIO) and A.COD_BLOQUE=C.COD_BLOQUE) order by A.CORR_MENSAJE,A.COD_BLOQUE,\
B.NUM_LINEA            ";

 static const char *sq0003 = 
"select B.CORR_MENSAJE ,B.NUM_LINEA ,C.CANT_CARACTLIN ,SUBSTR(B.DESC_MENSLIN,\
:b0,132) ,B.COD_IDIOMA  from FA_PARMENSAJE C ,FA_MENSAJES B ,(select unique CO\
RR_MENSAJE ,NUM_LINEAS ,COD_BLOQUE ,IND_FACTURADO ,COD_FORMULARIO  from FA_MEN\
SCICLO where (((((COD_FORMULARIO=:b1 and IND_FACTURADO=:b2) and COD_CLIENTE>:b\
3) and COD_BLOQUE>:b3) and CORR_MENSAJE>:b3) and COD_ORIGEN is  not null )) A \
where ((A.CORR_MENSAJE=B.CORR_MENSAJE and A.COD_FORMULARIO=C.COD_FORMULARIO) a\
nd A.COD_BLOQUE=C.COD_BLOQUE) order by B.CORR_MENSAJE,B.NUM_LINEA            ";

 static const char *sq0002 = 
"select NVL(A.NUM_FOLIOCTC,' ') ,TO_CHAR(A.FEC_EFECTIVIDAD,'YYYYMMDD') ,A.COD\
_CLIENTE ,A.NUM_SECUENCI ,A.COD_TIPDOCUM ,A.NUM_FOLIO ,UPPER(B.DES_TIPDOCUM) ,\
sum((NVL(A.IMPORTE_DEBE,:b0)-NVL(A.IMPORTE_HABER,:b0)))  from CO_CARTERA A ,GE\
_TIPDOCUMEN B where (((((A.COD_CLIENTE=:b2 and A.FEC_ANTIGUEDAD<=TO_DATE(:b3,'\
YYYYMMDD')) and (A.NUM_CUOTA=:b0 or A.NUM_CUOTA is null )) and A.IND_FACTURADO\
=:b5) and B.COD_TIPDOCUM=A.COD_TIPDOCUM) and  not exists (select :b5  from CO_\
CODIGOS F where ((F.NOM_TABLA='CO_CARTERA' and F.NOM_COLUMNA='COD_TIPDOCUM') a\
nd F.COD_VALOR=A.COD_TIPDOCUM))) group by NVL(NUM_FOLIOCTC,' '),A.FEC_EFECTIVI\
DAD,A.COD_CLIENTE,A.NUM_SECUENCI,A.COD_TIPDOCUM,A.NUM_FOLIO,B.DES_TIPDOCUM    \
       ";

 static const char *sq0021 = 
"select distinct COD_TIPDOCUM ,DES_TIPDOCUM  from GE_TIPDOCUMEN            ";

 static const char *sq0022 = 
"select distinct COD_OFICINA ,DES_OFICINA  from GE_OFICINAS            ";

 static const char *sq0023 = 
"select distinct COD_VENDEDOR ,NOM_VENDEDOR  from VE_VENDEDORES            ";

 static const char *sq0025 = 
"select LTRIM(RTRIM(A.COD_OPERADORA_SCL)) ,A.COD_CLIENTE ,B.NOM_CLIENTE ,NVL(\
B.NUM_IDENTTRIB,'AAA') ,NVL(GE_FN_OBTIENE_DIRCLIE(COD_OPERADORA_SCL,12,0,3),' \
')  from GE_OPERADORA_SCL A ,GE_CLIENTES B where (A.COD_CLIENTE=B.COD_CLIENTE \
and A.COD_CLIENTE is  not null )           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,5,137,0,4,134,0,0,3,1,0,1,0,2,4,0,0,2,3,0,0,1,3,0,0,
32,0,0,6,93,0,4,477,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
55,0,0,7,389,0,4,630,0,0,13,5,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
2,3,0,0,2,97,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
122,0,0,8,417,0,4,669,0,0,13,5,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
189,0,0,1,207,0,9,1373,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
232,0,0,1,0,0,13,1384,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
263,0,0,1,0,0,13,1461,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
294,0,0,1,0,0,15,1506,0,0,0,0,0,1,0,
309,0,0,9,143,0,9,1559,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
332,0,0,9,0,0,13,1570,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
355,0,0,9,0,0,15,1591,0,0,0,0,0,1,0,
370,0,0,10,63,0,4,2646,0,0,2,1,0,1,0,1,4,0,0,2,97,0,0,
393,0,0,11,63,0,4,2647,0,0,2,1,0,1,0,1,4,0,0,2,97,0,0,
416,0,0,12,42,0,4,2658,0,0,2,1,0,1,0,1,4,0,0,2,97,0,0,
439,0,0,4,411,0,9,3478,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
470,0,0,4,0,0,13,3488,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
501,0,0,4,0,0,15,3509,0,0,0,0,0,1,0,
516,0,0,13,0,0,17,3624,0,0,1,1,0,1,0,1,9,0,0,
535,0,0,13,0,0,21,3645,0,0,6,6,0,1,0,1,4,0,0,1,4,0,0,1,4,0,0,1,97,0,0,1,3,0,0,
1,97,0,0,
574,0,0,13,0,0,21,3654,0,0,5,5,0,1,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,97,0,0,
609,0,0,14,103,0,5,3809,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
636,0,0,15,103,0,5,3820,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
663,0,0,16,103,0,5,3832,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
690,0,0,3,543,0,9,3907,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
729,0,0,3,0,0,13,3916,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
764,0,0,3,0,0,15,3943,0,0,0,0,0,1,0,
779,0,0,17,83,0,4,3969,0,0,2,1,0,1,0,1,3,0,0,2,9,0,0,
802,0,0,18,83,0,4,3994,0,0,2,1,0,1,0,1,3,0,0,2,9,0,0,
825,0,0,19,60,0,4,4006,0,0,2,1,0,1,0,1,3,0,0,2,9,0,0,
848,0,0,20,61,0,4,4018,0,0,2,1,0,1,0,1,97,0,0,2,9,0,0,
871,0,0,2,707,0,9,4074,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
914,0,0,2,0,0,13,4081,0,0,8,0,0,1,0,2,9,0,0,2,9,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,9,0,0,2,4,0,0,
961,0,0,2,0,0,15,4129,0,0,0,0,0,1,0,
976,0,0,21,74,0,9,4218,0,0,0,0,0,1,0,
991,0,0,21,0,0,13,4230,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
1014,0,0,21,0,0,15,4249,0,0,0,0,0,1,0,
1029,0,0,22,70,0,9,4407,0,0,0,0,0,1,0,
1044,0,0,22,0,0,13,4418,0,0,2,0,0,1,0,2,97,0,0,2,97,0,0,
1067,0,0,22,0,0,15,4461,0,0,0,0,0,1,0,
1082,0,0,23,74,0,9,4548,0,0,0,0,0,1,0,
1097,0,0,23,0,0,13,4560,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
1120,0,0,23,0,0,15,4578,0,0,0,0,0,1,0,
1135,0,0,24,80,0,4,4638,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
1158,0,0,25,275,0,9,4775,0,0,0,0,0,1,0,
1173,0,0,25,0,0,13,4786,0,0,5,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,
1208,0,0,25,0,0,15,4809,0,0,0,0,0,1,0,
};


#include <ImpSclA.h>

/*     EXEC SQL INCLUDE sqlca;
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


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCod_ClienteCur      ;
         int     ihNumMes_Ciclo0Cur    ;
         int     ihNumMes_Ciclo5Cur    ;
         long    lhCodClienteCur       ;
         char    szhFec_EmisionCur  [9];
         char    szhIndFacturadoCur [2];
         int     ihCodFormDetalleCur   ;
         long    lhCodigoClienteCur    ;
         int     ihCodFormDetCur       ;
         char    szhCodIdiomaCur    [6];
         char    szhIndFacturCur    [2];
         int     ihAValorCero       = 0;
         int     ihAValorUno        = 1;
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL DECLARE Cursor_ConsumosMes CURSOR FOR
         SELECT NVL(NUM_MES,:ihAValorCero), 
                NVL(NUM_MINREBA,:ihAValorCero), 
                NVL(NUM_MINADIC,:ihAValorCero), 
                NVL(MTO_FACTCICLO,:ihAValorCero)
         FROM   FAT_CONMESCLIE
         WHERE  COD_CLIENTE = :lhCod_ClienteCur
         AND    NUM_MES <=  :ihNumMes_Ciclo0Cur
         AND    NUM_MES >=  :ihNumMes_Ciclo5Cur
         ORDER BY NUM_MES DESC; */ 


    /* EXEC SQL DECLARE Cursor_SaldoAnte CURSOR FOR
         SELECT NVL(A.NUM_FOLIOCTC,' '),
                TO_CHAR(A.FEC_EFECTIVIDAD,'YYYYMMDD'),
                A.COD_CLIENTE ,
                A.NUM_SECUENCI,
                A.COD_TIPDOCUM,
                A.NUM_FOLIO,
                UPPER(B.DES_TIPDOCUM),
                SUM(NVL(A.IMPORTE_DEBE,:ihAValorCero)-NVL(A.IMPORTE_HABER, :ihAValorCero))
         FROM   CO_CARTERA A ,
                GE_TIPDOCUMEN B
         WHERE  A.COD_CLIENTE     = :lhCodClienteCur
         AND    A.FEC_ANTIGUEDAD <= TO_DATE (:szhFec_EmisionCur ,'YYYYMMDD')
         AND    (A.NUM_CUOTA= :ihAValorCero OR A.NUM_CUOTA IS NULL)
         AND    A.IND_FACTURADO = :ihAValorUno
         AND    B.COD_TIPDOCUM  = A.COD_TIPDOCUM
         AND    NOT EXISTS (SELECT  :ihAValorUno
                            FROM    CO_CODIGOS F
                            WHERE   F.NOM_TABLA     = 'CO_CARTERA'
                            AND     F.NOM_COLUMNA   = 'COD_TIPDOCUM'
                            AND     F.COD_VALOR =A.COD_TIPDOCUM)
         GROUP  BY NVL(NUM_FOLIOCTC,' '),
                   A.FEC_EFECTIVIDAD    ,
                   A.COD_CLIENTE        ,
                   A.NUM_SECUENCI       ,
                   A.COD_TIPDOCUM       ,
                   A.NUM_FOLIO          ,
                   B.DES_TIPDOCUM       ; */ 


    /* EXEC SQL DECLARE Cursor_FaMensajesCiclo CURSOR FOR
         SELECT B.CORR_MENSAJE,
                B.NUM_LINEA,
                C.CANT_CARACTLIN,
                SUBSTR(B.DESC_MENSLIN,:ihAValorUno,132),
                B.COD_IDIOMA
         FROM   FA_PARMENSAJE C ,
                FA_MENSAJES B ,
                (SELECT UNIQUE CORR_MENSAJE, 
                               NUM_LINEAS, 
                               COD_BLOQUE,
                               IND_FACTURADO, 
                               COD_FORMULARIO
                 FROM   FA_MENSCICLO
                 WHERE  COD_FORMULARIO = :ihCodFormDetalleCur
                 AND    IND_FACTURADO  = :szhIndFacturadoCur
                 AND    COD_CLIENTE > :ihAValorCero
                 AND    COD_BLOQUE  > :ihAValorCero  AND CORR_MENSAJE > :ihAValorCero
                 AND    COD_ORIGEN IS NOT NULL) A
         WHERE  A.CORR_MENSAJE   = B.CORR_MENSAJE
         AND    A.COD_FORMULARIO = C.COD_FORMULARIO
         AND    A.COD_BLOQUE     = C.COD_BLOQUE
         ORDER BY B.CORR_MENSAJE, B.NUM_LINEA; */ 


    /* EXEC SQL DECLARE Cursor_Mensajes CURSOR FOR
         SELECT A.CORR_MENSAJE  ,
                B.NUM_LINEA ,
                C.CANT_CARACTLIN,
                LTRIM(RTRIM(NVL(B.COD_IDIOMA,'1')))
         FROM   FA_MENSCICLO    A,
                FA_MENSAJES     B,
                FA_PARMENSAJE   C
        WHERE   A.COD_CLIENTE   = :lhCodigoClienteCur
        AND     A.COD_FORMULARIO= :ihCodFormDetCur
        AND     B.COD_IDIOMA    = :szhCodIdiomaCur
        AND     A.IND_FACTURADO = :szhIndFacturCur
        AND     B.CORR_MENSAJE  = A.CORR_MENSAJE
        AND     A.COD_FORMULARIO= C.COD_FORMULARIO
        AND     A.COD_BLOQUE    = C.COD_BLOQUE
        ORDER BY A.CORR_MENSAJE  ,
                 A.COD_BLOQUE    ,
                 B.NUM_LINEA     ; */ 


/****************************************************************************/
/* Funcion Put_A1100                                                        */
/*  Descripcion : Imprime registro A1100 (Balance Anterior) en el archivo   */
/*                descrito por Fd_ArchImp.                                  */
/*  Entrada     : Fd_ArchImp, lCod_Cliente                                  */
/*  Salida      : Fd_ArchImp modificado                                     */
/*  Predecesor  : PutCaratula                                               */
/****************************************************************************/
int Put_A1100   ( FILE *Fd_ArchImp
                , ST_FACTCLIE *FactDocuClie
                , STSALDO_ANTERIOR *SaldoTot
                , ST_CUOTAS *pstFaCuotas
                , char *zsBufferImpresionArchivo
                , ST_BALANCE *stBalance )
{
    register int     i;
    double  dTotalAPagar;
    char    buffer_local[MAX_BYTE_A1100];
    int     TotalRegs;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         double  dhMonto[7]; 
         int     ihItem[7];
         long    lhCod_Cliente;
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(buffer_local,0,sizeof(buffer_local));
    memset(stBalance, 0, sizeof (ST_BALANCE));
    lhCod_Cliente = FactDocuClie->lCodCliente;

    /* EXEC SQL SELECT SUM(IMP_DOCUMENTO), COD_ITEM
            INTO    :dhMonto,:ihItem
            FROM FAT_BALANCE
            WHERE COD_ITEM BETWEEN 1 AND 5
            AND COD_CLIENTE = :lhCod_Cliente
            GROUP BY COD_ITEM; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select sum(IMP_DOCUMENTO) ,COD_ITEM into :b0,:b1  from FA\
T_BALANCE where (COD_ITEM between 1 and 5 and COD_CLIENTE=:b2) group by COD_IT\
EM";
    sqlstm.iters = (unsigned int  )7;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)dhMonto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )sizeof(double);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)ihItem;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Cliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
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



    if (sqlca.sqlcode < SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        vDTrazasLog("Put_A1100", "Error en ejecucion del SELECT", LOG05);
        return(FALSE);
    }

    TotalRegs = sqlca.sqlerrd[2];

    for (i=0;i<TotalRegs;i++)
    {
        stBalance->dMonto[ihItem[i]] = dhMonto[i];
    }

    /*ACTUALIZACION DE TOTAL FACTURA :*/
    FactDocuClie->dTotFactura = FactDocuClie->dTotCargosMes + stBalance->dMonto[iAJUSTE_CREDITO];

    dTotalAPagar =  FactDocuClie->dTotCargosMes +
            stBalance->dMonto[iAJUSTE_CREDITO] +
            stBalance->dMonto[iBALANCE_ANTERIOR] +
            stBalance->dMonto[iPAGOS_RECIBIDOS] +
            stBalance->dMonto[iPAGOS_REVERTIDOS] +
            stBalance->dMonto[iMISCELANEA];

    stBalance->dMonto[iCARGOS_MES]=FactDocuClie->dTotCargosMes;
    stBalance->dMonto[iTOTAL_FACTURA]=FactDocuClie->dTotFactura;
    stBalance->dMonto[iTOTAL_PAGAR]=dTotalAPagar;

    stBalance->dMonto[iCARGOS_MES]       = stBalance->dMonto[iCARGOS_MES] / FactDocuClie->dImpConversion; 
    stBalance->dMonto[iAJUSTE_CREDITO]   = stBalance->dMonto[iAJUSTE_CREDITO] / FactDocuClie->dImpConversion;
    stBalance->dMonto[iBALANCE_ANTERIOR] = stBalance->dMonto[iBALANCE_ANTERIOR] / FactDocuClie->dImpConversion;
    stBalance->dMonto[iPAGOS_RECIBIDOS]  = stBalance->dMonto[iPAGOS_RECIBIDOS] / FactDocuClie->dImpConversion; 
    stBalance->dMonto[iPAGOS_REVERTIDOS] = stBalance->dMonto[iPAGOS_REVERTIDOS] / FactDocuClie->dImpConversion;
    stBalance->dMonto[iMISCELANEA]       = stBalance->dMonto[iMISCELANEA] / FactDocuClie->dImpConversion; 
    stBalance->dMonto[iTOTAL_FACTURA]    = stBalance->dMonto[iTOTAL_FACTURA] / FactDocuClie->dImpConversion;
    stBalance->dMonto[iTOTAL_PAGAR]      = stBalance->dMonto[iTOTAL_PAGAR] / FactDocuClie->dImpConversion; 

    sprintf(buffer_local,REG_1100,
    fnCnvDouble(stBalance->dMonto[iCARGOS_MES],1),
    fnCnvDouble(stBalance->dMonto[iAJUSTE_CREDITO],1),
    fnCnvDouble(stBalance->dMonto[iBALANCE_ANTERIOR],1),
    fnCnvDouble(stBalance->dMonto[iPAGOS_RECIBIDOS],1),
    fnCnvDouble(stBalance->dMonto[iPAGOS_REVERTIDOS],1),
    fnCnvDouble(stBalance->dMonto[iMISCELANEA],1),
    fnCnvDouble(stBalance->dMonto[iTOTAL_FACTURA],1),
    fnCnvDouble(stBalance->dMonto[iTOTAL_PAGAR],1));

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);
        
    return(TRUE);
}

/*******************************************************************************/
/* Funcion Put_A1200                                                           */
/*  Descripcion : Imprime registro A1200 (Documentos Totales) en el archivo    */
/*                descrito por Fd_ArchImp.                                     */
/*  Entrada     : Fd_ArchImp, estructuras FactDocuClie, SaldoTot y pstFaCuotas */
/*  Salida      : Fd_ArchImp modificado                                        */
/*  Predecesor  : PutCaratula                                                  */
/*******************************************************************************/
int Put_A1200   ( FILE             *Fd_ArchImp
                , ST_FACTCLIE      *FactDocuClie
                , STSALDO_ANTERIOR *SaldoTot
                , ST_CUOTAS        *pstFaCuotas
                , char             *zsBufferImpresionArchivo
                , ST_BALANCE       *stBalance
                , TIPOSIMPUESTOS   *stTiposImpuestos
                , long             lCodCiclFact)
{
    int      iDigVeriF_Total_Pagar = 0;
    double   dTotalAPagar  = 0.0;
    double   dTotalCuotas  = 0.0;
    char     buffer_local[MAX_BYTE_A1200];
    register int i = 0;
    double   dTotCuotPVen  = 0.0;
    int      iIndiceTipoImpuestos; /* P-MIX-09003 77 */
    int      iCodTipoImpuesto;     /* P-MIX-09003 77 */
    long     lIndOrdenTotal;       /* P-MIX-09003 77 */
    long     lCodCiclFacturacion;  /* P-MIX-09003 77 */
    int      iNumRegs = 0;             /* P-MIX-09003 77 */
    
    double       dTotalIva        = 0.0; /* P-MIX-09003 77 */
    double       dTotalRetencion  = 0.0; /* P-MIX-09003 77 */
    double       dTotalPercepcion = 0.0; /* P-MIX-09003 77 */       
    double       dTotalImpuesto   = 0.0; /* P-MIX-09003 77 */    

    memset(buffer_local,0,sizeof(buffer_local));

    strcpy (szModulo, "Put_A1200");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

/* P-MIX-09003 77 */    
    vDTrazasLog (szExeName,"\n\t\t* Tipos Impuestos..(put_a1200) [%d]", LOG06, stTiposImpuestos->iNumRegs);
    
    iNumRegs = stTiposImpuestos->iNumRegs;

    /* Rcorrer estructura de Tipos de Impuestos y sumarlos para Cliente */
    for (i=0;i<iNumRegs;i++)
    {
         vDTrazasLog (szExeName, "\n\t\t=> [%d]: Cod TipImpue..(put_a1200)    [%d]"
                                 "\n\t\t=> [%d]: Descripcion..(put_a1200)     [%s]"
                               , LOG06
                               , i , stTiposImpuestos->stTipoImpuesto[i].iCodTipImpue
                               , i , stTiposImpuestos->stTipoImpuesto[i].szDesTipImpue );
                               
         iCodTipoImpuesto    = stTiposImpuestos->stTipoImpuesto[i].iCodTipImpue;
         lIndOrdenTotal      = FactDocuClie->lIndOrdenTotal;
         lCodCiclFacturacion = lCodCiclFact;
         dTotalImpuesto      = 0.0;         
                               
         if (!bfnSumarImpuestos ( iCodTipoImpuesto, lIndOrdenTotal, lCodCiclFacturacion, &dTotalImpuesto))
         {
              return (FALSE);
         }         
         if (iCodTipoImpuesto == 1)
         {
         	dTotalIva = fnCnvDouble(dTotalImpuesto,1);
         }
         if (iCodTipoImpuesto == 2)
         {
         	dTotalRetencion = fnCnvDouble(dTotalImpuesto,1);         	
         }
         if (iCodTipoImpuesto == 3)
         {
         	dTotalPercepcion = fnCnvDouble(dTotalImpuesto,1);         	
         }                         
    }
/* P-MIX-09003 77 */

    /* Recorrer estructura de cuotas por vencer, sumar solo las que seran impresas */
    for(i=0;i<pstFaCuotas->iNum_RegCuotas_pven;i++)
    {
        if(pstFaCuotas->stReg_pven[i].iInd_Facturado == 2)
            dTotCuotPVen += pstFaCuotas->stReg_pven[i].dMtoCuota;
    }

    dTotalCuotas = pstFaCuotas->dTotalCuotas_venci + dTotCuotPVen;

    vDTrazasLog(szModulo, "\n\t\tIndOrdenTotal                            [%ld] " /* P-MIX-09003 77 */
                          "\n\t\tSUMA SaldoTot->dTotalSaldo                [%f] "
                          "\n\t\tSUMA stBalance->dMonto[iBALANCE_ANTERIOR] [%f] "
                          "\n\t\tSUMA FactDocuClie->dTotCargosMes          [%f] "
                          "\n\t\tSUMA dTotalCuotas                         [%f] "                          
                          "\n\t\tSUMA dTotalIva                            [%f] " /* P-MIX-09003 77 */
                          "\n\t\tSUMA dTotalRetencion                      [%f] " /* P-MIX-09003 77 */
                          "\n\t\tSUMA dTotalPercepcion                     [%f] " /* P-MIX-09003 77 */     
                        , LOG05
                        , FactDocuClie->lIndOrdenTotal        /* P-MIX-09003 77 */
                        , SaldoTot->dTotalSaldo
                        , stBalance->dMonto[iBALANCE_ANTERIOR]
                        , FactDocuClie->dTotCargosMes
                        , dTotalCuotas
                        , dTotalIva                           /* P-MIX-09003 77 */
                        , dTotalRetencion                     /* P-MIX-09003 77 */
                        , dTotalPercepcion);                  /* P-MIX-09003 77 */

    dTotalAPagar =  FactDocuClie->dTotCargosMes +
                    stBalance->dMonto[iAJUSTE_CREDITO] +
                    stBalance->dMonto[iBALANCE_ANTERIOR] +
                    stBalance->dMonto[iPAGOS_RECIBIDOS] +
                    stBalance->dMonto[iPAGOS_REVERTIDOS] +
                    stBalance->dMonto[iMISCELANEA] ;

    dTotalAPagar =  fnCnvDouble(dTotalAPagar,1);
    if(CalculaDigVerif(dTotalAPagar,&iDigVeriF_Total_Pagar) != TRUE)
    {
        iDigVeriF_Total_Pagar = 999;
    }

    FactDocuClie->dTotCargosMes = FactDocuClie->dTotCargosMes / FactDocuClie->dImpConversion;
    SaldoTot->dTotalSaldo       = SaldoTot->dTotalSaldo / FactDocuClie->dImpConversion;
    dTotalCuotas                = dTotalCuotas / FactDocuClie->dImpConversion;
    dTotalAPagar                = dTotalAPagar / FactDocuClie->dImpConversion;    
    dTotalIva                   = dTotalIva / FactDocuClie->dImpConversion;         /* P-MIX-09003 77 */
    dTotalRetencion             = dTotalRetencion / FactDocuClie->dImpConversion;   /* P-MIX-09003 77 */
    dTotalPercepcion            = dTotalPercepcion / FactDocuClie->dImpConversion;  /* P-MIX-09003 77 */

    sprintf( buffer_local,REG_1200,
             fnCnvDouble(FactDocuClie->dTotCargosMes,1),
             fnCnvDouble(SaldoTot->dTotalSaldo,1),
             fnCnvDouble(dTotalCuotas,1),
             dTotalAPagar,
             iDigVeriF_Total_Pagar,
             fnCnvDouble(SaldoTot->dTotalSaldo + FactDocuClie->dTotCargosMes,1),
             fnCnvDouble(dTotalIva,1),         /* P-MIX-09003 77 */
             fnCnvDouble(dTotalRetencion,1),   /* P-MIX-09003 77 */
             fnCnvDouble(dTotalPercepcion,1)); /* P-MIX-09003 77 */

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/***************************** Final Put_A1200 ***********************************/

/*******************************************************************************/
/* Funcion Put_A1250                                                           */
/*  Descripcion : Impresion de cuotas vencidas del cliente.                    */
/*******************************************************************************/
int Put_A1250   ( FILE *Fd_ArchImp
                , ST_CUOTAS *pstFaCuotas
                , char *zsBufferImpresionArchivo)
{

    register int i;
    char    buffer_local[MAX_BYTE_A1250];
    double dMontoTotalDeuda = 0.0; /* Valor total de deuda de financiamiento */
    double dSaldoPendiente  = 0.0; /* Saldo pendiente a la fecha */

    long   lhNum_FolioAux = 0;
    int    j = 0;
    double dAcumMtoCuota = 0.0;

    /* Recorrer la estructura de cuotas vencidas y enviarlas a impresion */
    vDTrazasLog("Put_A1250", "(Put_A1250): Resumen de Cuotas : [%d]", LOG06,pstFaCuotas->iNum_RegCuotas_venci);

    lhNum_FolioAux = pstFaCuotas->stReg_venci[j].lNum_Folio;
    for(i=0;i<pstFaCuotas->iNum_RegCuotas_venci;i++)
    {
        if (pstFaCuotas->iNum_RegCuotas_venci > 1)
        {
            dAcumMtoCuota = dAcumMtoCuota + pstFaCuotas->stReg_venci[i].dMtoCuota;

            if ( pstFaCuotas->stReg_venci[i].lNum_Folio != lhNum_FolioAux )
            {
                /* Obtencion del monto total de la deuda y del saldo pendiente  */
                j = i-1;

                dAcumMtoCuota = dAcumMtoCuota - pstFaCuotas->stReg_venci[i].dMtoCuota;

                ifnObtenerMontosTotalesCuota(pstFaCuotas->stReg_venci[j],&dMontoTotalDeuda,&dSaldoPendiente, 1);

                vDTrazasLog("Put_A1250", "(Put_A1250) CUOTAS : Monto Total deuda retornado: [%015.4f]\n"
                                         "(Put_A1250) CUOTAS : Saldo Pendiente   retornado: [%015.4f]\n"
                                            , LOG06, dMontoTotalDeuda, dSaldoPendiente);

                memset(buffer_local,0,sizeof(buffer_local));
                sprintf(buffer_local,"A1250%15.15ld%-25.25s%3.3d%3.3d%015.4f%015.4f%015.4f\n\0"
                                    ,pstFaCuotas->stReg_venci[j].lNum_Folio
                                ,pstFaCuotas->stReg_venci[j].szPrefPlaza
                                    ,pstFaCuotas->stReg_venci[j].iSecCuota
                    ,pstFaCuotas->stReg_venci[j].iNumCuota
                                    ,dAcumMtoCuota            
                                    ,dMontoTotalDeuda
                                    ,dSaldoPendiente);

                dAcumMtoCuota = pstFaCuotas->stReg_venci[i].dMtoCuota;

                if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                    return(FALSE);
                lhNum_FolioAux = pstFaCuotas->stReg_venci[i].lNum_Folio;
            }
        }
        else
        {
            ifnObtenerMontosTotalesCuota(pstFaCuotas->stReg_venci[i],&dMontoTotalDeuda,&dSaldoPendiente, 1);

            vDTrazasLog("Put_A1250", "(Put_A1250) CUOTAS : Monto Total deuda retornado: [%015.4f]\n"
                                     "(Put_A1250) CUOTAS : Saldo Pendiente   retornado: [%015.4f]\n"
                                        , LOG06, dMontoTotalDeuda, dSaldoPendiente);

            memset(buffer_local,0,sizeof(buffer_local));
            sprintf(buffer_local,"A1250%15.15ld%-25.25s%3.3d%3.3d%015.4f%015.4f%015.4f\n\0"
                                ,pstFaCuotas->stReg_venci[i].lNum_Folio
                            ,pstFaCuotas->stReg_venci[i].szPrefPlaza
                                ,pstFaCuotas->stReg_venci[i].iSecCuota
                ,pstFaCuotas->stReg_venci[i].iNumCuota
                                ,pstFaCuotas->stReg_venci[i].dMtoCuota
                                ,dMontoTotalDeuda
                                ,dSaldoPendiente);

            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);
            lhNum_FolioAux = pstFaCuotas->stReg_venci[i].lNum_Folio;

        }
    }

    if (pstFaCuotas->iNum_RegCuotas_venci > 1)
    {
        i--;

    ifnObtenerMontosTotalesCuota(pstFaCuotas->stReg_venci[i],&dMontoTotalDeuda,&dSaldoPendiente, 1);


    vDTrazasLog("Put_A1250", "(Put_A1250) CUOTAS : Monto Total deuda retornado: [%015.4f]\n"
        "(Put_A1250) CUOTAS : Saldo Pendiente   retornado: [%015.4f]\n"
        , LOG06, dMontoTotalDeuda, dSaldoPendiente);

    memset(buffer_local,0,sizeof(buffer_local));
    sprintf( buffer_local,"A1250%15.15ld%-25.25s%3.3d%3.3d%015.4f%015.4f%015.4f\n\0"
             ,pstFaCuotas->stReg_venci[i].lNum_Folio
             ,pstFaCuotas->stReg_venci[i].szPrefPlaza
             ,pstFaCuotas->stReg_venci[i].iSecCuota
             ,pstFaCuotas->stReg_venci[i].iNumCuota
             ,dAcumMtoCuota 
             ,dMontoTotalDeuda
             ,dSaldoPendiente);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);
    }

    return(TRUE);

}

/*
 *  Fecha: 09/08/2005
 *  Funcion:        Put_A1120
 *  Descripcion:    Impresion de los documentos emitidos en el periodo de facturacion del cliente.
 */

int Put_A1120(FILE *Fd_ArchImp
            , ST_FACTCLIE  *FactDocuClie
            , ST_CICLOFACT *sthFa_CicloFact
            , char *zsBufferImpresionArchivo
            , long lCodCicloFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente      = 0L;
    char szhFecMinAlta     [10]; /* EXEC SQL VAR szhFecMinAlta IS STRING(10); */ 

    char szhFecMenor   [10] ="";
    /* EXEC SQL END   DECLARE SECTION; */ 


    register int i=0;
    char         buffer_local[MAX_BYTE_A1120];
    DOCSPERIODO  stDocs;
    PAGOS        stPagos;                                 

    memset (buffer_local,0,sizeof(buffer_local));
    memset (&stDocs, 0, sizeof(DOCSPERIODO));
    memset (&stPagos, 0, sizeof(stPagos));           

    /* Obtener la menor fecha de alta del cliente */
    lhCodCliente = FactDocuClie->lCodCliente;

    /* EXEC SQL
        SELECT
            TO_CHAR(MIN(FEC_ALTA),'YYYYMMDD')
        INTO
            :szhFecMinAlta
        FROM
            GA_INFACCEL A
        WHERE
            A.COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(min(FEC_ALTA),'YYYYMMDD') into :b0  from G\
A_INFACCEL A where A.COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )32;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecMinAlta;
    sqlstm.sqhstl[0] = (unsigned long )10;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog("Put_A1120", "[ERROR] (Put_A1120): Error en ejecucion de SELECT", LOG05);
        return(FALSE);
    }

    /* Si la menor fecha de alta < Fecha Desde la cual se generan las tasaciones */
    if(strcmp(szhFecMinAlta,sthFa_CicloFact->fec_desde) < 0 )
    {
        /* La fecha menor sera Fecha Desde Cargos Basicos */
        strcpy(szhFecMenor,sthFa_CicloFact->fec_desde);
    }
    else
    {
        /* La fecha menor sera la menor fecha de alta */
        strcpy(szhFecMenor,szhFecMinAlta);
    }

    /* Consultar la tabla FA_HISTDOCU por los documentos del periodo definido */
    if (!bfnCargarDocsPeriodo(&stDocs.stDocPeriodo, &stDocs.iNumRegs, FactDocuClie->lCodCliente, szhFecMenor,sthFa_CicloFact->fec_hasta))
    {
        vDTrazasLog(szModulo, "Error en bfnCargarDocsPeriodo [%s]", LOG02,SQLERRM);
        return(FALSE);
    }

    for (i=0; i < stDocs.iNumRegs; i++)
    {
        memset(buffer_local,0,sizeof(buffer_local));
        sprintf(buffer_local,"A1120%-5.5s%-3.3s%5.5d%-40.40s%-25.25s%15.15ld%-8.8s%015.4f\n\0"
                            , stDocs.stDocPeriodo[i].szCodOperadora
                            , stDocs.stDocPeriodo[i].szCodOficina
                            , stDocs.stDocPeriodo[i].iCodTipDocum
                            , stDocs.stDocPeriodo[i].szDesTipDocum
                            , stDocs.stDocPeriodo[i].szPrefPlaza
                            , stDocs.stDocPeriodo[i].lNumFolio
                            , stDocs.stDocPeriodo[i].szFecEmision
                            , fnCnvDouble(stDocs.stDocPeriodo[i].dTotFactura,1));

        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            return(FALSE);
    }

    if (!bfnCargaUltsPagos(&stPagos.stPago, &stPagos.iNumRegs, FactDocuClie->lCodCliente, lCodCicloFact))
    {
        vDTrazasLog(szModulo, "Error en bfnCargaUltsPagos [%s]", LOG02,SQLERRM);
        return(FALSE);
    }

    for (i=0; i < stPagos.iNumRegs; i++)
    {
        if(stPagos.stPago[i].lTipPago == 2L)
        {
            memset(buffer_local,0,sizeof(buffer_local));
            sprintf(buffer_local,"A1120%-5.5s%-3.3s%5.5ld%-40.40s%-10.10s%15.15ld%-8.8s%015.4f\n\0"
                                , stPagos.stPago[i].szCodOperadora
                                , " "
                                , stPagos.stPago[i].lCodTipDocum
                                , stPagos.stPago[i].szDecrip
                                , " "
                                , 0L
                                , stPagos.stPago[i].szFecha
                                , fnCnvDouble(stPagos.stPago[i].dMonto,1));

            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);

        }
    }
    return(TRUE);
}
/*************** fin Put_A1120 *************/


/**********************************************************************************/
/*  FUNCION     :    Put_A1130                                                    */
/*  DESCRIPCION :    Identificacion del documento de origen del documento actual. */
/**********************************************************************************/
int Put_A1130 ( FILE        *Fd_ArchImp, 
                ST_FACTCLIE *FactDocuClie,
                char        *zsBufferImpresionArchivo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhCodOperadora [6]     ;
         char    szhCodOficina   [3]     ;
         int     ihCodTipDocum      =   0;
         char    szhPrefPlaza   [26]=  "";
         long    lhNumFolio         =  0L;
         char    szhFecEmision  [11]=  "";
         double  dhTotFactura       = 0.0;
         long    lhNumSecuRel       =  0L;
         char    szhLetraRel[2]     =  "";
         int     ihCodTipDocumRel   =  0;
         long    lhCodVendedorAgRel =  0L;
         long    lhCodCentrRel      =  0L;
         char    szhNumGuia   [25+1]=  ""; /* EXEC SQL VAR szhNumGuia IS STRING(25+1); */ 
 /* P-MIX-09003 */
         long    lhNumDocPedido     =  0L;                                          /* P-MIX-09003 */
         long    lhNumProceso       =  0L;                                          /* P-MIX-09003 */
/* PREFOLIADOS */
         long    lhIndOrdenTotalPre      ; /* P-MIX-09003 136609 */
         char    szhResolucionPre  [25+1]; /* EXEC SQL VAR szhResolucionPre IS STRING(25+1); */ 

         char    szhSeriePre       [10+1]; /* EXEC SQL VAR szhSeriePre      IS STRING(10+1); */ 

         int     ihCodTipDocumPre        ;
         char    szhEtiquetaPre    [10+1]; /* EXEC SQL VAR szhEtiquetaPre   IS STRING(10+1); */ 

         long    lhNumFolioPre           ;
         char    szhPreFoliados   [100+1]; /* EXEC SQL VAR szhPreFoliados   IS STRING(100+1); */ 

    /* EXEC SQL END   DECLARE SECTION; */ 


    char    buffer_local[MAX_BYTE_A1130];

    memset(buffer_local,0,sizeof(buffer_local));
    
/* PREFOLIADOS */    
    memset(szhResolucionPre ,'\0',sizeof(szhResolucionPre));
    memset(szhSeriePre      ,'\0',sizeof(szhSeriePre));
    memset(szhEtiquetaPre   ,'\0',sizeof(szhEtiquetaPre));        
    ihCodTipDocumPre = 0;    
    lhNumFolioPre    = 0;
    memset(szhPreFoliados   ,'\0',sizeof(szhPreFoliados));    

    /* Si el documento actual tiene documento de origen, realizar su busqueda */
    if(FactDocuClie->lNumSecuRel !=0)
    {
    	/* Documento tiene Documento Relacionado */
        lhNumSecuRel       =  FactDocuClie->lNumSecuRel      ;
        strcpy(szhLetraRel ,  FactDocuClie->szLetraRel)      ;
        ihCodTipDocumRel   =  FactDocuClie->iCodTipDocumRel  ;
        lhCodVendedorAgRel =  FactDocuClie->lCodVendedorAgRel;
        lhCodCentrRel      =  FactDocuClie->lCodCentrRel     ;

        vDTrazasLog("Put_A1130", "\n\t** Documento Origen **"
                                 "\n\t======================"
                                 "\n\t\t Num.Secu.Rel. [%ld]"
                                 "\n\t\t Letra Rel.     [%s]"
                                 "\n\t\t Tip.Docum.Rel. [%d]"
                                 "\n\t\t Vendedor.Rel. [%ld]"
                                 "\n\t\t Centr.Rel.    [%ld]"
                                 , LOG04
                                 , lhNumSecuRel
                                 , szhLetraRel
                                 , ihCodTipDocumRel
                                 , lhCodVendedorAgRel
                                 , lhCodCentrRel);

        /* EXEC SQL
            SELECT
                A.IND_ORDENTOTAL,
                A.COD_OPERADORA,
                A.COD_OFICINA,
                A.COD_TIPDOCUM,
                A.PREF_PLAZA,
                A.NUM_FOLIO,
                TO_CHAR(A.FEC_EMISION,'YYYYMMDD'),
                A.TOT_FACTURA
            INTO
                :lhIndOrdenTotalPre ,
                :szhCodOperadora    ,
                :szhCodOficina      ,
                :ihCodTipDocum      ,
                :szhPrefPlaza       ,
                :lhNumFolio         ,
                :szhFecEmision      ,
                :dhTotFactura
            FROM
                FA_HISTDOCU A,FA_TIPDOCUMEN B
            WHERE
                A.NUM_SECUENCI            = :lhNumSecuRel
                AND A.COD_TIPDOCUM        = B.COD_TIPDOCUMMOV
                AND A.COD_TIPDOCUM        = :ihCodTipDocumRel
                AND A.COD_VENDEDOR_AGENTE = :lhCodVendedorAgRel
                AND A.LETRA               = :szhLetraRel
                AND A.COD_CENTREMI        = :lhCodCentrRel; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select A.IND_ORDENTOTAL ,A.COD_OPERADORA ,A.COD_OFICI\
NA ,A.COD_TIPDOCUM ,A.PREF_PLAZA ,A.NUM_FOLIO ,TO_CHAR(A.FEC_EMISION,'YYYYMMDD\
') ,A.TOT_FACTURA into :b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7  from FA_HISTDOCU A ,FA\
_TIPDOCUMEN B where (((((A.NUM_SECUENCI=:b8 and A.COD_TIPDOCUM=B.COD_TIPDOCUMM\
OV) and A.COD_TIPDOCUM=:b9) and A.COD_VENDEDOR_AGENTE=:b10) and A.LETRA=:b11) \
and A.COD_CENTREMI=:b12)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )55;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotalPre;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodOperadora;
        sqlstm.sqhstl[1] = (unsigned long )6;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[2] = (unsigned long )3;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[4] = (unsigned long )26;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhFecEmision;
        sqlstm.sqhstl[6] = (unsigned long )11;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&dhTotFactura;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhNumSecuRel;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&ihCodTipDocumRel;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&lhCodVendedorAgRel;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szhLetraRel;
        sqlstm.sqhstl[11] = (unsigned long )2;
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&lhCodCentrRel;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqphss = sqlstm.sqhsts;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqpins = sqlstm.sqinds;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlstm.sqpadto = sqlstm.sqadto;
        sqlstm.sqptdso = sqlstm.sqtdso;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        if (SQLCODE != SQLOK && SQLCODE!=SQLNOTFOUND)
        {
            vDTrazasLog("Put_A1130", "[ERROR] 1** (Put_A1130): Error en ejecucion de SELECT, Codigo: [%d]"
                                   , LOG01,sqlca.sqlcode);
            return(FALSE);
        }

        /* Supuestos: El doc. origen esta en alguna y solo en una de las dos tablas */
        if(SQLCODE == SQLNOTFOUND)
        {
            /* EXEC SQL
                SELECT
                    A.IND_ORDENTOTAL,
                    A.COD_OPERADORA,
                    A.COD_OFICINA,
                    A.COD_TIPDOCUM,
                    A.PREF_PLAZA,
                    A.NUM_FOLIO,
                    TO_CHAR(A.FEC_EMISION,'YYYYMMDD'),
                    A.TOT_FACTURA
                INTO
                    :lhIndOrdenTotalPre,
                    :szhCodOperadora   ,
                    :szhCodOficina     ,
                    :ihCodTipDocum     ,
                    :szhPrefPlaza      ,
                    :lhNumFolio        ,
                    :szhFecEmision     ,
                    :dhTotFactura
                FROM
                    FA_FACTDOCU_NOCICLO A,FA_TIPDOCUMEN B
                WHERE
                    A.NUM_SECUENCI            = :lhNumSecuRel
                    AND A.COD_TIPDOCUM        = B.COD_TIPDOCUMMOV
                    AND B.IND_CICLO           = 0
                    AND A.COD_TIPDOCUM        = :ihCodTipDocumRel
                    AND A.COD_VENDEDOR_AGENTE = :lhCodVendedorAgRel
                    AND A.LETRA               = :szhLetraRel
                    AND A.COD_CENTREMI        = :lhCodCentrRel; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 13;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select A.IND_ORDENTOTAL ,A.COD_OPERADORA ,A.COD_O\
FICINA ,A.COD_TIPDOCUM ,A.PREF_PLAZA ,A.NUM_FOLIO ,TO_CHAR(A.FEC_EMISION,'YYYY\
MMDD') ,A.TOT_FACTURA into :b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7  from FA_FACTDOCU_N\
OCICLO A ,FA_TIPDOCUMEN B where ((((((A.NUM_SECUENCI=:b8 and A.COD_TIPDOCUM=B.\
COD_TIPDOCUMMOV) and B.IND_CICLO=0) and A.COD_TIPDOCUM=:b9) and A.COD_VENDEDOR\
_AGENTE=:b10) and A.LETRA=:b11) and A.COD_CENTREMI=:b12)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )122;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotalPre;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhCodOperadora;
            sqlstm.sqhstl[1] = (unsigned long )6;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhCodOficina;
            sqlstm.sqhstl[2] = (unsigned long )3;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhPrefPlaza;
            sqlstm.sqhstl[4] = (unsigned long )26;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)szhFecEmision;
            sqlstm.sqhstl[6] = (unsigned long )11;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)&dhTotFactura;
            sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[7] = (         int  )0;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)&lhNumSecuRel;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[8] = (         int  )0;
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)&ihCodTipDocumRel;
            sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[9] = (         int  )0;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)&lhCodVendedorAgRel;
            sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[10] = (         int  )0;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szhLetraRel;
            sqlstm.sqhstl[11] = (unsigned long )2;
            sqlstm.sqhsts[11] = (         int  )0;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)&lhCodCentrRel;
            sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[12] = (         int  )0;
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqphsv = sqlstm.sqhstv;
            sqlstm.sqphsl = sqlstm.sqhstl;
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
                vDTrazasLog("Put_A1130", "[ERROR] (Put_A1130): Error en ejecucion de SELECT, Codigo: [%d]"
                                       , LOG01,sqlca.sqlcode);
                return(FALSE);
            }
        }

        strcpy(szhNumGuia," ");
        
/* PREFOLIADOS */        
/* P-MIX-09003 */

        /*lhIndOrdenTotalPre = FactDocuClie->lIndOrdenTotal;*/ /* P-MIX-09003 136609 */
        strcpy(szhPreFoliados," ");
        if (!bfnFindPrefoliados ( lhIndOrdenTotalPre, 
                                  szhPreFoliados,
                                  szhResolucionPre,
                                  szhSeriePre,
                                  &ihCodTipDocumPre,
                                  szhEtiquetaPre,
                                  &lhNumFolioPre ))
        
        {
             vDTrazasLog("Put_A1130", "(Put_A1130): Impresion sin Pre-Foliados"
                                    , LOG06);
             strcpy(szhPreFoliados," ");
             strcpy(szhResolucionPre," ");
             strcpy(szhSeriePre," ");
             ihCodTipDocumPre = 0;
             strcpy(szhEtiquetaPre," ");
             lhNumFolioPre = 0;                                    
        }
        else
        {
             vDTrazasLog("Put_A1130", "(Put_A1130): Impresion con Pre-Foliados"
                                    , LOG06);        	
        }
        
        sprintf(buffer_local,REG_1130,
                            szhCodOperadora,
                            szhCodOficina  ,
                            ihCodTipDocum  ,
                            szhPrefPlaza   ,
                            lhNumFolio     ,
                            szhFecEmision  ,
                            fnCnvDouble(dhTotFactura,1),
                            szhNumGuia,                   
                            lhNumDocPedido,
                            szhResolucionPre,
                            szhSeriePre,
                            ihCodTipDocumPre,
                            szhEtiquetaPre,
                            lhNumFolioPre); 
/* P-MIX-09003 */

        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);
    }
    else /* P-MIX-09003 */ /* Documento No tiene Dorcumento Relacionado (Origen)*/
    {
    	
        strcpy(szhCodOperadora," ");
        strcpy(szhCodOficina," ");        
        strcpy(szhPrefPlaza," ");
        strcpy(szhFecEmision," ");        
        strcpy(szhPreFoliados," "); /* P-MIX-09003 */
    	
        lhNumProceso      =  FactDocuClie->lNumProceso;        
        bfnBuscaNotaPedido(lhNumProceso,szhNumGuia,&lhNumDocPedido);
        
        lhIndOrdenTotalPre = FactDocuClie->lIndOrdenTotal;
        strcpy(szhPreFoliados," ");
        if (!bfnFindPrefoliados ( lhIndOrdenTotalPre, 
                                  szhPreFoliados,
                                  szhResolucionPre,
                                  szhSeriePre,
                                  &ihCodTipDocumPre,
                                  szhEtiquetaPre,
                                  &lhNumFolioPre ))
        
        {
             vDTrazasLog("Put_A1130", "(Put_A1130): Impresion sin Pre-Foliados"
                                    , LOG06);
             strcpy(szhPreFoliados," ");
             strcpy(szhResolucionPre," ");
             strcpy(szhSeriePre," ");
             ihCodTipDocumPre = 0;
             strcpy(szhEtiquetaPre," ");
             lhNumFolioPre = 0;                                    
        }
        else
        {
             vDTrazasLog("Put_A1130", "(Put_A1130): Impresion con Pre-Foliados"
                                    , LOG06);        	
        }        

        sprintf(buffer_local,REG_1130,
                            szhCodOperadora,
                            szhCodOficina  ,
                            ihCodTipDocum  ,
                            szhPrefPlaza   ,
                            lhNumFolio     ,
                            szhFecEmision  ,
                            fnCnvDouble(dhTotFactura,1),
                            szhNumGuia,                    /* P-MIX-09003 */
                            lhNumDocPedido,                /* P-MIX-09003 */
                            /*szhPreFoliados,*/
                            szhResolucionPre,
                            szhSeriePre,
                            ihCodTipDocumPre,
                            szhEtiquetaPre,
                            lhNumFolioPre);               /* P-MIX-09003 */

        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);    	
    }

    return(TRUE);
}/*********************************** FIN Put_A1130 ***********************************/

/*
Se agrega funcion Put_A1150 para imprimir nuevo registro A1150 con informacion del ultimo pago.
Llama a funcion iCargarDatosUltimoPago que esta en ImpSclFnc.pc que rescata los datos del ultimo pago.
*/

int Put_A1150(FILE *Fd_ArchImp
            , ST_FACTCLIE *FactDocuClie
            , char *zsBufferImpresionArchivo
            , long lCodCicloFact)
{
    char    buffer_local[MAX_BYTE_A1150];
    PAGOS   stPagos;
    register int i;
    memset (&stPagos, 0, sizeof(stPagos));

    if (!bfnCargaUltsPagos(&stPagos.stPago, &stPagos.iNumRegs, FactDocuClie->lCodCliente, lCodCicloFact))
    {
        vDTrazasLog(szModulo, "Error en bfnCargaUltsPagos [%s]", LOG02,SQLERRM);
        return(FALSE);
    }

    for (i=0; i < stPagos.iNumRegs; i++)
    {
        if(stPagos.stPago[i].lTipPago == 1L || stPagos.stPago[i].lTipPago == 3L || stPagos.stPago[i].lTipPago == 4L)  /* ECU-05021 */ /* COL-07041 */
        {
            memset(buffer_local,0,sizeof(buffer_local));
            sprintf(buffer_local,"A1150%-8.8s%-40.40s%015.4f%-80.80s%03.3ld\n\0"
                                , stPagos.stPago[i].szFecha
                                , stPagos.stPago[i].szDecrip
                                , fnCnvDouble(stPagos.stPago[i].dMonto,1)
                                , stPagos.stPago[i].szModPago
                                , stPagos.stPago[i].lTipPago  );

            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);

        }
    }

  return(TRUE);
}/*************** fin Put_A1150 *************/ 


/****************************************************************************************/
/* Funcion                                                                              */
/*  Descripcion : Imprime registro A1000 (Documento de Cliente) en el archivo descrito  */
/*                por Fd_ArchImp.                                                       */
/*  Entrada     : Fd_ArchImp, estructuras FactDocuClie y sthFa_CicloFact                */
/*  Salida      : Fd_ArchImp modificado                                                 */
/*  Predecesor  : PutCaratula                                                           */
/****************************************************************************************/
int Put_A1000( FILE         *Fd_ArchImp, 
               ST_FACTCLIE  *FactDocuClie, 
               ST_CICLOFACT *sthFa_CicloFact, 
               char         *zsBufferImpresionArchivo, 
               long         lCodCicloFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhTipologia       [30+1]; /* EXEC SQL VAR szhTipologia       IS STRING(30+1); */ 

         char    szhAreaImputable   [30+1]; /* EXEC SQL VAR szhAreaImputable   IS STRING(30+1); */ 

         char    szhAreaSolicitante [30+1]; /* EXEC SQL VAR szhAreaSolicitante IS STRING(30+1); */ 

    /* EXEC SQL END   DECLARE SECTION; */ 
	
	
    int            iDigVer;
    char           buffer_local[MAX_BYTE_A1000];
    int            iSw;
    register int   iInd;
    char           szPlan[4];
    TIPDOC         stTipDoc;
    CODCLI         stCodCli;
    char           sIndDoc_Cero[2];
    char           sFec_Suspension[12];
    long           lCodCli;
    char           sCodAutoriz[11];
    char           sDescPlanTarif[31];
    PLAN_TARIFARIO *pstAux = (PLAN_TARIFARIO *)NULL;
    PLAN_TARIFARIO stkey;
    char           szFecVenCod[10];

    memset(buffer_local,0,sizeof(buffer_local));
    if(CalculaDigVerif((double)FactDocuClie->lCodCliente,&iDigVer)!= TRUE)
    {
       iDigVer = 999;
    }

    if (!bfnFindTipDocum (FactDocuClie->iCodTipDocum, &stTipDoc))
    {
        return FALSE;
    }
    
    vDTrazasLog  ("Put_A1000","\tFactDocuClie->lCodCliente  [%ld]",LOG05,FactDocuClie->lCodCliente);

    if (!bfnFindCodCliente (FactDocuClie->lCodCliente, &stCodCli, lCodCicloFact, FactDocuClie->szFecEmision))
    {
	return FALSE;
    }

    strcpy(szPlan, "XXX");
    iSw = FALSE;

    for (iInd = 0; iInd < stFaDetCons.iNumReg; iInd++)
    {
        if ((stFaDetCons.stDetConsumo[iInd].iCodConcepto == iCodAbonoCel) &&
            (stFaDetCons.stDetConsumo[iInd].lNumAbonado != 0 ))
        {
            alltrim(stFaDetCons.stDetConsumo[iInd].szCod_PlanTarif);
            if ((strcmp(stFaDetCons.stDetConsumo[iInd].szCod_PlanTarif,szPlan)!=0 && 
               (strlen(stFaDetCons.stDetConsumo[iInd].szCod_PlanTarif)) > 0))
            {
                strcpy(szPlan, stFaDetCons.stDetConsumo[iInd].szCod_PlanTarif);
                iSw = TRUE;
                break;
            }
        }
    }

    if (iSw)
    {
        if (pstPlanes.iNumRegPlanTarif > 0)
        {
            strcpy(FactDocuClie->szPlanTarif , szPlan);

            /* Con el codigo de plan tarifario (szPlan) vamos a buscar la descripcion del plan tarifario */
            /* mediante bsearch en estructura pstPlanes declarada en ImpSclSt.h                          */
            strcpy(stkey.szCod_Plantarif,szPlan);
            if ( (pstAux = (PLAN_TARIFARIO *)bsearch (&stkey, pstPlanes.stPlanesTarifarios, pstPlanes.iNumRegPlanTarif,
                sizeof (PLAN_TARIFARIO),ifnCmpCod_PlanTarif ))== (PLAN_TARIFARIO *)NULL)
            {
                vDTrazasLog(szExeName, "Put_A1000: Codigo Plan Tarifario [%s] no encontrado ...", LOG01, szPlan);
                strcpy(szPlan, szCODPLANTARIFARIO_NULL);        
                strcpy(sDescPlanTarif," ");                        
            }
            else
            {
                strcpy(sDescPlanTarif,pstAux->szDes_Plantarif);
            }
        }
        else
        {
            vDTrazasLog  ("Put_A1000","\tNo existen Planes Tarifarios Cargados\n"
             			      "\tSe asume Plan Tarifario NULL\n",LOG05);
            strcpy(szPlan, szCODPLANTARIFARIO_NULL);
            strcpy(sDescPlanTarif," ");
        }
    }
    else
    {
        strcpy(szPlan, szCODPLANTARIFARIO_NULL);
        strcpy(sDescPlanTarif," ");
    }

/* Se agrega indicador (marca) para la impresion de archivos (documentos) con total igual cero. */
    if ((FactDocuClie->dTotFactura >= -0.00001) && (FactDocuClie->dTotFactura <= 0.00001))
    {
        strcpy(sIndDoc_Cero,"1");
    }
    else
    {
        strcpy(sIndDoc_Cero,"0");
    }

    lCodCli=FactDocuClie->lCodCliente;
    if (!iCargaFechaSuspension(lCodCli, FactDocuClie->szFecVencimie, sFec_Suspension))
    {
       strcpy (sFec_Suspension, " " );
    }
    vDTrazasLog("Put_A1000", "Fecha suspension [%s]", LOG05,sFec_Suspension);

    vDTrazasLog("Put_A1000", "Grav. Factura [%f] Num. Terminales [%ld]", 
			     LOG05,stFaDetCons.dGravFactura,stFaDetCons.lNumTerminales);    

    if (strcmp(szAplica_Cod_Autorizacion,"S") == 0)
    {
        strcpy(sCodAutoriz ,stAutorizFolio.szCodAutorizacion);
        strcpy(szFecVenCod ,stAutorizFolio.szFechaVencimiento);
    }
    else
    {
        strcpy(sCodAutoriz ,"");
        strcpy(szFecVenCod ,"");
    }
    
    vDTrazasLog("Put_A1000", "\n\t Cod. Autorización [%s]"
                             "\n\t Fecha Venc. Cod.  [%s]"
                           , LOG05, sCodAutoriz, szFecVenCod);
                           
    /* P-MIX-09003 141767 */
    memset(szhTipologia      ,'\0',sizeof(szhTipologia));
    memset(szhAreaImputable  ,'\0',sizeof(szhAreaImputable));
    memset(szhAreaSolicitante,'\0',sizeof(szhAreaSolicitante)); 
            
    if (!bfnFindMotivo (FactDocuClie->szCodTipologia, FactDocuClie->szCodAreaImputable, FactDocuClie->szCodAreaSolicitante,
                        szhTipologia, szhAreaImputable, szhAreaSolicitante))
    {
	return FALSE;
    }   
    /* P-MIX-09003 141767 */
                                                             
    sprintf ( buffer_local,REG_1000,
              FactDocuClie->lCodCliente,
              iDigVer,
              FactDocuClie->iCodTipDocum,
              FactDocuClie->lNum_Folio,
              FactDocuClie->szNumCtc,
              FactDocuClie->szCodDespacho,
              sthFa_CicloFact->fec_desde,
              sthFa_CicloFact->fec_hasta,
              FactDocuClie->szFecEmision,
              FactDocuClie->szFecVencimie,
              FactDocuClie->szIndDebito,
              FactDocuClie->szCod_Idioma,
              szPlan,
              sDescPlanTarif,
              FactDocuClie->lIndOrdenTotal,
              FactDocuClie->szPrefPlaza,
              FactDocuClie->szCodPlaza,
              stTipDoc.szDesTipDocum,
              stCodCli.szNomApoderado,
              sCodAutoriz,
              fnCnvDouble(stFaDetCons.dGravFactura,1),
              sIndDoc_Cero,
              sFec_Suspension,
              stFaDetCons.lNumTerminales,
              szFecVenCod,
              FactDocuClie->szCodSegmentacion,
              FactDocuClie->szNomEmail,
              FactDocuClie->szCodIdent,
              FactDocuClie->szFecEmi,
              FactDocuClie->szFecUltMod,
              FactDocuClie->szContTecnico,
              FactDocuClie->szResolucion,       
              FactDocuClie->szSerie,            
              FactDocuClie->szEtiqueta,         
              FactDocuClie->szFecResolucion,    
              FactDocuClie->lRanDesde,          
              FactDocuClie->lRanHasta,
              szhTipologia,
              szhAreaImputable,
              szhAreaSolicitante                         
           );           

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
    return(FALSE);

   return(TRUE);
}/***************************Final Put_A1000 ********************************/


/****************************************************************************/
/* Funcion Put_A1010                                                        */
/*  Descripcion : Imprime registro A1010 (Documento de Operdora) en el      */
/*                archivo descrito por Fd_ArchImp.                          */
/*  Entrada     : Fd_ArchImp, estructuras FactDocuClie                      */
/*  Salida      : Fd_ArchImp modificado                                     */
/*  Predecesor  : PutCaratula                                               */
/****************************************************************************/
int Put_A1010(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo, long lCodCicloFact)
{
    int     iDigVer;
    char    buffer_local[MAX_BYTE_A1010];
    char    szhNomVendedor[41];
    OFICINA2    stOfic;
    OPERADORA   stOper;
    VENDEDOR    stVendedor;

    vDTrazasLog ("Put_A1010","\tGE_OPERADORA_SCL (%s) ",LOG04,FactDocuClie->szCodOperadora);

    if (!bfnFindOperadora (FactDocuClie->szCodOperadora, &stOper ))
        return FALSE;


    if (!bfnFindOficina2 (FactDocuClie->szCod_Oficina, &stOfic))
            return FALSE;

    vDTrazasLog ("Put_A1010","\tFactDocuClie->lCodVendedor    [%ld] ",LOG04,FactDocuClie->lCodVendedor);

    if (!bfnFindVendedores (FactDocuClie->lCodVendedor, &stVendedor, lCodCicloFact))
            return FALSE;

    strcpy(szhNomVendedor,stVendedor.szNomVendedor);

    memset(buffer_local,0,sizeof(buffer_local));
    if(CalculaDigVerif((double)stOper.lCodClienteOperadora,&iDigVer)!= TRUE)
    {
        iDigVer = 999;
    }

    sprintf(buffer_local,REG_1010,
        stOper.lCodClienteOperadora,
        iDigVer,
        FactDocuClie->szCodOperadora,
        stOper.szNomOperadora,
        stOper.szNumIdenTRib,
        FactDocuClie->szCod_Oficina,
        stOfic.szDesOficina,
        FactDocuClie->lCodVendedor,
        szhNomVendedor);

        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

   return(TRUE);
}/*****************************Final Put_A1010 ***********************************/


/*****************************************************************************/
/* Funcion Put_A1300                                                         */
/*  Descripcion : Imprime registro A1300 (Registro de Cliente) en el archivo */
/*                descrito por Fd_ArchImp.                                   */
/*  Entrada     : Fd_ArchImp, estructura FactDocuClie                        */
/*      Salida      : Fd_ArchImp modificado                                  */
/*  Predecesor  : PutCaratula                                                */
/*****************************************************************************/
int Put_A1300(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo, long lCodCicloFact)
{
    register int     i;
    char             szNum_Celular[21];
    char             buffer_local[MAX_BYTE_A1300];
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhNomBreCliente [110+1]; /* EXEC SQL VAR szhNomBreCliente IS STRING(110+1); */ 

         char    szhNumIdent       [20+1]; /* EXEC SQL VAR szhNumIdent      IS STRING(20+1); */ 
         
    /* EXEC SQL END DECLARE SECTION; */ 
    
 
    CODCLI  stCodCli;   

    strcpy (szModulo, "Put_A1300");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    memset(buffer_local,0,sizeof(buffer_local));
    memset(szhNomBreCliente,'\0',sizeof(szhNomBreCliente));
    memset(szhNumIdent,'\0',sizeof(szhNumIdent));    

    for (i=0;i < stFaDetCons.iNumReg ;i++)
    {
        if (strcmp(fnQuitaBlancos(stFaDetCons.stDetConsumo[i].szNum_Celular),"0"))
        {
            strcpy(szNum_Celular, stFaDetCons.stDetConsumo[i].szNum_Celular);
            break;
        }
    }

    if (!bfnFindCodCliente (FactDocuClie->lCodCliente, &stCodCli, lCodCicloFact, FactDocuClie->szFecEmision))
    {
        return FALSE;
    }

    /* P-MIX-09003 */
    if (!bfnFindFactura(FactDocuClie->lCodCliente, szhNomBreCliente, lCodCicloFact, 
                        FactDocuClie->szFecEmision, szhNumIdent, FactDocuClie->lNumVenta))
    {
       return FALSE;
    }

    vDTrazasLog(szModulo, "\tIMP-A1300 Retorno Nombre Cliente [%s] ", LOG05,szhNomBreCliente);
    vDTrazasLog(szModulo, "\tIMP-A1300 Retorno Num. Ident     [%s] ", LOG05,szhNumIdent);    
    
    /* P-MIX-09003 */
    if (strcmp(szhNomBreCliente," ") != 0)
    {
   	 vDTrazasLog(szModulo, "\tIMP-A1300 Asignando Nombre Cliente [%s] ", LOG05,szhNomBreCliente);
   	 vDTrazasLog(szModulo, "\tIMP-A1300 Asignando Num. Ident     [%s] ", LOG05,szhNumIdent);   	 
         strcpy(FactDocuClie->szNombre_Clie,szhNomBreCliente);
         strcpy(FactDocuClie->szRut_Cliente,szhNumIdent);
         strcpy(stCodCli.szNumIdent2," ");         
    }
    
    sprintf(buffer_local, REG_1300
                        , FactDocuClie->szRut_Cliente
                        , FactDocuClie->szNombre_Clie
                        , szNum_Celular
                        , stCodCli.iCodSisPago
                        , "        "
                        , stCodCli.szNumIdent2 /* P-MIX-09003*/);
         
    vDTrazasLog(szModulo, "\tIMP-A1300 [%s] ", LOG06, buffer_local);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/*****************************Final Put_A1300 ***********************************/


/****************************************************************************************/
/* Funcion Put_A1400                                                                    */
/*  Descripcion : Imprime registro A1400 (Registro de Direccion de Facturacion ) en el  */
/*            archivo descrito por Fd_ArchImp.                                          */
/*  Entrada     : Fd_ArchImp, estructura FactDocuClie                                   */
/*      Salida      : Fd_ArchImp modificado                                             */
/*  Predecesor  : PutCaratula                                                           */
/****************************************************************************************/
int Put_A1400(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo)
{
    char        buffer_local[MAX_BYTE_A1400];

    memset(buffer_local,0,sizeof(buffer_local));
    strcpy (szModulo, "Put_A1400");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sprintf(buffer_local,REG_1400, FactDocuClie->szDireccion[iDIRECCION_FACTURACION]);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/*****************************Final Put_A1400 ***********************************/

/****************************************************************************************/
/* Funcion Put_A1410                                        */
/*  Descripcion : Imprime registro A1410 (Registro de Direccion de Operadora ) en el  */
/*            archivo descrito por Fd_ArchImp.                  */
/*  Entrada     : Fd_ArchImp, estructura FactDocuClie                   */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A1410(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo)
{
    char        buffer_local[MAX_BYTE_A1410];

    memset(buffer_local,0,sizeof(buffer_local));
    strcpy (szModulo, "Put_A1410");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sprintf(buffer_local,REG_1410, FactDocuClie->szDireccion[iDIRECCION_OPERADORA]);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/*****************************Final Put_A1410 ***********************************/

/****************************************************************************/
/* Funcion Put_A1420                                        */
/*  Descripcion : Imprime registro A1420 (Registro de Direccion de la plaza ) en el  */
/*            archivo descrito por Fd_ArchImp.                  */
/*  Entrada     : Fd_ArchImp, estructura FactDocuClie                   */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A1420(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo)
{
    char        buffer_local[MAX_BYTE_A1420];

    memset(buffer_local,0,sizeof(buffer_local));
    strcpy (szModulo, "Put_A1420");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sprintf(buffer_local,REG_1420, FactDocuClie->szDireccion[iDIRECCION_PLAZA]);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/***************************************Final Put_A1420 ****************************************/

/****************************************************************************/
/* Funcion Put_A1430                                        */
/*  Descripcion : Imprime registro A1430 (Registro de Direccion de la sucursal ) en el  */
/*            archivo descrito por Fd_ArchImp.                  */
/*  Entrada     : Fd_ArchImp, estructura FactDocuClie                   */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A1430(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo)
{
    char        buffer_local[MAX_BYTE_A1430];

    memset(buffer_local,0,sizeof(buffer_local));
    strcpy (szModulo, "Put_A1430");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sprintf(buffer_local,REG_1430, FactDocuClie->szDireccion[iDIRECCION_SUCURSAL]);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/***************************************Final Put_A1430 ****************************************/

/****************************************************************************************/
/* Funcion Put_A1500                                                                    */
/*  Descripcion : Imprime registro A1500 (Registro de Direccion Correspondencia) en el  */
/*                archivo descrito por Fd_ArchImp.                                      */
/*  Entrada     : Fd_ArchImp, estructura FactDocuClie                                   */
/*  Salida      : Fd_ArchImp modificado                                                 */
/*  Predecesor  : PutCaratula                                                           */
/****************************************************************************************/
int Put_A1500(FILE *Fd_ArchImp,ST_FACTCLIE *FactDocuClie, char *zsBufferImpresionArchivo, long lCodCicloFact)
{
    char        buffer_local[MAX_BYTE_A1500];
    CODCLI      stCodCli;

    memset(buffer_local,0,sizeof(buffer_local));
    strcpy (szModulo, "Put_A1500");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);
    
    if (!bfnFindCodCliente (FactDocuClie->lCodCliente, &stCodCli, lCodCicloFact, FactDocuClie->szFecEmision))
            return FALSE;    

    vDTrazasLog(szModulo, "Corespondencia : %s", LOG05,FactDocuClie->szDireccion[iDIRECCION_CORRESPONDENCIA]);

    sprintf(buffer_local, REG_1500,  
                          FactDocuClie->szDireccion[iDIRECCION_CORRESPONDENCIA],
                          stCodCli.szCodCourrier,      /* P-MIX-09003 */
                          stCodCli.szCodZonaCourrier); /* P-MIX-09003 */

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/*****************************Final Put_A1500 ***********************************/

/****************************************************************************/
/* Funcion Put_A1700                                        */
/*  Descripcion : Imprime registro A1700 (Registro de Informacion Consumo) en el    */
/*            archivo descrito por Fd_ArchImp.                  */
/*  Entrada     : Fd_ArchImp, lCodCliente y estructura sthFa_CicloFact          */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A1700(FILE *Fd_ArchImp, long lCod_Cliente, ST_CICLOFACT *psthFaCiclFact, char *zsBufferImpresionArchivo)
{
    int i=0;
    int j;
    char    buffer_local[MAX_BYTE_A1700];

    /* Se agregan variables para calcular los valores maximos */
    long    lMin_Local_Max     =0;
    long    lMin_Adicio_Max    =0;
    double  dMto_FactCiclo_Max =0.0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhMin_Local     ;
        long    lhMin_Adicio    ;
        int     ihNum_Mes       ;
        /* Se agrega variable  "dhMto_FactCiclo"  para recibir el monto de la factura */
        double  dhMto_FactCiclo ;
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(buffer_local,0,sizeof(buffer_local));

    strcpy (szModulo, "Put_A1700");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sqlca.sqlcode = 0;

    lhCod_ClienteCur =lCod_Cliente;
    ihNumMes_Ciclo0Cur = atoi(psthFaCiclFact->szMesCiclo_0);
    ihNumMes_Ciclo5Cur = atoi(psthFaCiclFact->szMesCiclo_5);

    sqlca.sqlcode = 0;

    /* EXEC SQL OPEN Cursor_ConsumosMes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )189;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCod_ClienteCur;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihNumMes_Ciclo0Cur;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihNumMes_Ciclo5Cur;
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


    if(sqlca.sqlcode < SQLOK)   {
        vDTrazasLog(szModulo, "Error en OPEN Cursor_ConsumosMes. Error [%d][%s] ", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    sprintf (buffer_local, REG_INI1700);

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    /* EXEC SQL FETCH Cursor_ConsumosMes
        INTO :ihNum_Mes,
             :lhMin_Local,
             :lhMin_Adicio,
             :dhMto_FactCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )232;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihNum_Mes;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhMin_Local;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhMin_Adicio;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&dhMto_FactCiclo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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



    if (sqlca.sqlcode == SQLNOTFOUND)
    {
        for (j=1;j < 7 ;j++)
        {
            sprintf (buffer_local, REG_1700 ,0,(long)0,(long)0,(long)0,0.0);
            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);

        }

        sprintf (buffer_local, REG_FIN1700 ,(long)0,(long)0,0.0);
        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);

        return(TRUE);
    }
    else
    {
        if (lhMin_Local < 0)
        {
            lhMin_Local = lhMin_Local * -1;
            vDTrazasLog(szModulo, "Monto MinLocal negativo Despues...[%ld]", LOG05, lhMin_Local);

        }

        if (lhMin_Adicio < 0)
        {
            lhMin_Adicio = lhMin_Adicio * -1;
            vDTrazasLog(szModulo, "Monto MinAdicional negativo Despues...[%ld]", LOG05, lhMin_Adicio);
        }

    }

    /* Se corrige FOR para agregar monto factura y calcular valores maximos */

    lMin_Local_Max=lhMin_Local;             
    lMin_Adicio_Max=lhMin_Adicio;           
    dMto_FactCiclo_Max=dhMto_FactCiclo;     

    for (i=1; i < 7; i++)
    {
        if (sqlca.sqlcode == SQLOK)
        {
            sprintf (buffer_local, REG_1700 ,
                ihNum_Mes,
                lhMin_Local,
                lhMin_Adicio,
                lhMin_Local + lhMin_Adicio,
                fnCnvDouble(dhMto_FactCiclo,1));  

            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);

        }
        else
        {
            for (j=i;j < 7 ;j++)
            {
                sprintf (buffer_local, REG_1700 ,0,(long)0,(long)0,(long)0,0.0);
                if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                    return(FALSE);
            }

                lMin_Local_Max=0;          
                lMin_Adicio_Max=0;         
                dMto_FactCiclo_Max=0;      

            break;

        }

        /* EXEC SQL FETCH Cursor_ConsumosMes
            INTO    :ihNum_Mes,
                    :lhMin_Local,
                    :lhMin_Adicio,
                    :dhMto_FactCiclo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )263;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihNum_Mes;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhMin_Local;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhMin_Adicio;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&dhMto_FactCiclo;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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

    

        if (lhMin_Local < 0)
        {
            lhMin_Local = lhMin_Local * -1;
            vDTrazasLog(szModulo, "Monto MinLocal negativo Despues...[%ld]", LOG05, lhMin_Local);

        }

        if (lhMin_Adicio < 0)
        {
            lhMin_Adicio = lhMin_Adicio * -1;
            vDTrazasLog(szModulo, "Monto MinAdicional negativo Despues...[%ld]", LOG05, lhMin_Adicio);
        }

        /* Se agregan estos IF para calcular los valores maximos */

        if (lMin_Local_Max < lhMin_Local)
        {
            lMin_Local_Max = lhMin_Local;
        }
        if (lMin_Adicio_Max < lhMin_Adicio)
        {
            lMin_Adicio_Max = lhMin_Adicio;
        }
        if (dMto_FactCiclo_Max < dhMto_FactCiclo)
        {
            dMto_FactCiclo_Max = dhMto_FactCiclo;
        }

    }

    sprintf (buffer_local, REG_FIN1700 ,
                lMin_Local_Max,
                lMin_Adicio_Max,
                fnCnvDouble(dMto_FactCiclo_Max,1));


    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    /* EXEC SQL CLOSE Cursor_ConsumosMes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )294;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasError(szModulo, "Error en CLOSE Cursor_ConsumosMes. [%d][%s] ", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    return(TRUE);

}/*****************************Final Put_A1700 ***********************************/

int Put_A1710(FILE *Fd_ArchImp
            , ST_FACTCLIE *FactDocuClie
            , char *zsBufferImpresionArchivo
            , long lCodCicloFact)
{
    char    buffer_local_ciclos[400];
    char    buffer_local[400];
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodcliente   = FactDocuClie->lCodCliente;
        long lhCodCiclFact  = 0L;
        double dhMontoCiclo = 0.0;
        long lhNumCiclos = stDatosGener.lCantCiclos;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(szModulo,"Entrando en Funcion Put_A1710()", LOG03);
    vDTrazasLog(szModulo,"lhCodcliente [%ld]", LOG03, lhCodcliente);
    vDTrazasLog(szModulo,"lhNumCiclos  [%ld]", LOG03, lhNumCiclos);
    
    
    memset(buffer_local_ciclos,0,sizeof(buffer_local_ciclos));
    
    /* Obtener parametros sobre ciclos */
    /* EXEC SQL DECLARE c_num_consumos_clientes CURSOR FOR
    SELECT
        COD_CICLFACT
        ,MTO_FACTCICLO
    FROM
        FA_CONSUMO_CICLO_CLIE_TO
    WHERE
        COD_CLIENTE = :lhCodcliente
        AND ROWNUM <= :lhNumCiclos
    ORDER BY FEC_EMISION ASC; */ 


    if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
    {
        vDTrazasLog(szModulo,"Put_A1710: En EXEC SQL DECLARE c_num_consumos_clientes, SQLCODE: [%d]"
        					, LOG01, SQLCODE);
        vDTrazasError(szModulo,"Put_A1710: En EXEC SQL DECLARE c_num_consumos_clientes, SQLCODE: [%d]"
        					  , LOG01, SQLCODE);
        return FALSE;
    }


    /* EXEC SQL OPEN c_num_consumos_clientes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )309;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodcliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCiclos;
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


    if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
    {
        vDTrazasLog(szModulo,"Put_A1710: En EXEC SQL OPEN c_num_consumos_clientes, SQLCODE: [%d]", LOG01, SQLCODE);
        vDTrazasError(szModulo,"Put_A1710: En EXEC SQL OPEN c_num_consumos_clientes, SQLCODE: [%d]", LOG01, SQLCODE);
        return FALSE;
    }

	int ContCicl = 0;
    for (;;)
    {
        /* EXEC SQL FETCH  c_num_consumos_clientes INTO :lhCodCiclFact, :dhMontoCiclo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )332;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhMontoCiclo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
            break;

        if(SQLCODE!=SQLOK)
        {
            vDTrazasLog(szModulo,"Put_A1710: En EXEC SQL FETCH  c_num_consumos_clientes, SQLCODE: [%d]", LOG01, SQLCODE);
            vDTrazasError(szModulo,"Put_A1710: En EXEC SQL FETCH  c_num_consumos_clientes, SQLCODE: [%d]", LOG01, SQLCODE);
            return FALSE;
        }

        sprintf(buffer_local_ciclos ,REG_1710
		                            , buffer_local_ciclos
		                            , lhCodCiclFact
		                            , dhMontoCiclo );

		ContCicl++;

    }

    /* EXEC SQL CLOSE c_num_consumos_clientes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )355;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    /*Inicio Concateno Proceso actual*/
    sprintf(buffer_local_ciclos , REG_1710
	                            , buffer_local_ciclos
	                            , lCodCicloFact
	                            , FactDocuClie->dTotCargosMes );
	ContCicl++;
	/*Fin Concateno Proceso actual*/
    
    
    memset(buffer_local,0,sizeof(buffer_local));
    
    vDTrazasLog(szModulo,"ContCicl  [%d]", LOG03, ContCicl);
    
    for (;ContCicl < (lhNumCiclos+1);ContCicl++)
    {
    	   vDTrazasLog(szModulo,"Rellenando con Blancos", LOG03);
    	   sprintf(buffer_local,"%sA1710                     \n",buffer_local);
    }
    
    sprintf(buffer_local,"%s%s",buffer_local,buffer_local_ciclos);
    
    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
	           return(FALSE);

  return(TRUE);
}/*************** fin Put_A1710 *************/


/****************************************************************************/
/* Funcion Put_A2000                                        */
/*  Descripcion : Imprime registro A2000 (Registro Bloque de Mensajes) en el archivo    */
/*            descrito por Fd_ArchImp.                      */
/*  Entrada     : Fd_ArchImp, estructura Mensajes                   */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/

int Put_A2000(FILE *Fd_ArchImp, ST_MENSAJES *Mensajes, char *zsBufferImpresionArchivo)
{
    int     iIndice;
    char    szIdioma[10];
    char    buffer_local[MAX_BYTE_A2000];

    memset(buffer_local,0,sizeof(buffer_local));

    strcpy (szModulo, "Put_A2000");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sprintf(buffer_local,REG_INI2000);
    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            return(FALSE);

    for (iIndice=0;iIndice < 4 ;iIndice++)
    {
        strcpy(szIdioma, Mensajes->zsCodIdioma[iIndice]);
        FillCodIdioma(szIdioma);

        sprintf(buffer_local,REG_2000,
            Mensajes->iCorrMensaje[iIndice],
            Mensajes->iNumLinea[iIndice],
            Mensajes->iCantCaract[iIndice],
            szIdioma);

        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            return(FALSE);

    }

    sprintf(buffer_local,"\n\0");
    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            return(FALSE);

    return(TRUE);

}/*****************************Final Put_A2000 ***********************************/

/****************************************************************************/
/* Funcion Put_A1800                                        */
/*  Descripcion : Imprime registro A1800 (Registro de Detalle Facturado Nivel 1) en el  */
/*            archivo descrito por Fd_ArchImp.                  */
/*  Entrada     : Fd_ArchImp,  y sthTablaAcum           */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A1800(FILE *Fd_ArchImp, ST_TABLA_ACUM *sthTablaAcum, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas, char *zsBufferImpresionArchivo, double dFact_Conversion) /* P-TMM-03075 */
{
    register int i;
    char        szCodGrupo[50];
    ST_TABLA    sthTabla;
    char        szElemento_1[50];
    char        szElemento_2[50];
    int         iValor;
    char        szResultado[20];
    double      dTotalCuotas;
    char        buffer_local[MAX_BYTE_A1800];
    double      dTotalPrimeraCateg=0.0;        
    double      dTotalSegundaCateg=0.0;        
    double      dTotalNetoImpto=0.0;           

    memset(buffer_local,0,sizeof(buffer_local));
    memset(&sthTabla, 0, sizeof (ST_TABLA));

    strcpy (szModulo, "Put_A1800");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    sthTablaAcum->dTotalCosto=0;

    dTotalCuotas = pstFaCuotas->dTotalCuotas_pven;

    /* Limpia Flag que marca Impuesto relacionado */
    bfnLimpiaFlag(&pstCatImpues);

    for (i=0; i < stFaDetCons.iNumReg; i++ )
    {
        sprintf(szCodGrupo,"%i",stFaDetCons.stDetConsumo[i].iCodGrupo);

        if (strcmp(fnQuitaBlancos(stFaDetCons.stDetConsumo[i].szTip_ConcNoFact)," "))
                strcpy(szElemento_1,"0");
        else
                strcpy(szElemento_1,"1");

        strcpy(szElemento_2, szElemento_1);
        strcat(szElemento_2, szCodGrupo);

        iValor = RetPos(szElemento_2, &sthTabla);

        sthTablaAcum->lSegundos[iValor]          += stFaDetCons.stDetConsumo[i].lSeg_Consumo;
        sthTablaAcum->dCostoFacturaNeto[iValor]  += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
        sthTablaAcum->iCodGrupo[iValor]           = stFaDetCons.stDetConsumo[i].iCodGrupo;
        strcpy(sthTablaAcum->szDesGrupo[iValor]   , stFaDetCons.stDetConsumo[i].szGlosaGrupo);

        if (stFaDetCons.stDetConsumo[i].lSeg_Consumo > 0)
                sthTablaAcum->lTotalSeg  += stFaDetCons.stDetConsumo[i].lSeg_Consumo;

        sthTablaAcum->iFacturable[iValor] = atoi(szElemento_1);

        if(sthTablaAcum->iFacturable[iValor] == 1)
            sthTablaAcum->dTotalCosto += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;

        sprintf(szResultado,"%12.12ld",stFaDetCons.stDetConsumo[i].lSeg_Consumo);

        /* Llama a funcion que Totaliza los impuestos considerando los conceptos relacionados */

        if (stFaDetCons.stDetConsumo[i].iCodTipConce !=1)
        {
            if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[i].iCodConcepto, stFaDetCons.stDetConsumo[i].iColumna,&dTotalPrimeraCateg, &dTotalSegundaCateg ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
                return(FALSE);
            }
           
            dTotalPrimeraCateg = stFaDetCons.stDetConsumo[i].dTotalPrimeraCateg;
            dTotalSegundaCateg = stFaDetCons.stDetConsumo[i].dTotalSegundaCateg;

            sthTablaAcum->dGravPrimeraCategoria[iValor]  += dTotalPrimeraCateg;
            sthTablaAcum->dGravSegundaCategoria[iValor]  += dTotalSegundaCateg;

        }

        strcpy(sthTablaAcum->szTipGrupo [iValor] , stFaDetCons.stDetConsumo[i].szTipGrupo);
        strcpy(sthTablaAcum->szTipUnidad[iValor] , stFaDetCons.stDetConsumo[i].szTipUnidad);
        sthTablaAcum->iNivelImpresion   [iValor] = stFaDetCons.stDetConsumo[i].iNivelImpresion;

    }

    for (i=0; i<sthTabla.iLastPosition ;i++)
    {
        if (sthTablaAcum->iFacturable[i] == 1)
        {
            sprintf(szResultado,"%12.12ld",sthTablaAcum->lSegundos[i]);


            dTotalNetoImpto=sthTablaAcum->dCostoFacturaNeto[i] +
                            sthTablaAcum->dGravPrimeraCategoria[i] +
                            sthTablaAcum->dGravSegundaCategoria[i];

            switch (sthTablaAcum->iCodGrupo[i])
            {
                case COD_GRUPO_SALDANT:{
                    SaldoTot->dTotalSaldo = SaldoTot->dTotalSaldo / dFact_Conversion; /* P-TMM-03075 */
                    sprintf(buffer_local,REG_1800,
                        sthTablaAcum->iFacturable[i],
                        sthTablaAcum->iCodGrupo[i],
                        sthTablaAcum->szDesGrupo[i],
                        fnCnvDouble(SaldoTot->dTotalSaldo,1),
                        szResultado,
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[i],1),
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[i],1),
                        fnCnvDouble(dTotalNetoImpto,1),                       
                        sthTablaAcum->iNivelImpresion[i],            
                        sthTablaAcum->szTipUnidad[i],                
                        sthTablaAcum->szTipGrupo[i]);                

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);

                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
                case COD_GRUPO_CUOTA:{
                    dTotalCuotas = dTotalCuotas / dFact_Conversion;
                    sprintf(buffer_local,REG_1800,
                        sthTablaAcum->iFacturable[i],
                        sthTablaAcum->iCodGrupo[i],
                        sthTablaAcum->szDesGrupo[i],
                        fnCnvDouble(dTotalCuotas,1),
                        szResultado,
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[i],1),
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[i],1),
                        fnCnvDouble(dTotalNetoImpto,1),                       
                        sthTablaAcum->iNivelImpresion[i],       
                        sthTablaAcum->szTipUnidad[i],           
                        sthTablaAcum->szTipGrupo[i]);           

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
                default:{
                    sthTablaAcum->dCostoFacturaNeto[i] = sthTablaAcum->dCostoFacturaNeto[i] / dFact_Conversion;
                    sprintf(buffer_local,REG_1800,
                        sthTablaAcum->iFacturable[i],
                        sthTablaAcum->iCodGrupo[i],
                        sthTablaAcum->szDesGrupo[i],
                        fnCnvDouble(sthTablaAcum->dCostoFacturaNeto[i],1),
                        szResultado,
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[i],1),
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[i],1),
                        fnCnvDouble(dTotalNetoImpto,1),                       
                        sthTablaAcum->iNivelImpresion[i],       
                        sthTablaAcum->szTipUnidad[i],           
                        sthTablaAcum->szTipGrupo[i]);           

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);

                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
            }
        }
    }

    for (i=0; i<sthTabla.iLastPosition ;i++)
    {
        if (sthTablaAcum->iFacturable[i] == 0)
        {
            sprintf(szResultado,"%12.12ld",sthTablaAcum->lSegundos[i]);

            dTotalNetoImpto=sthTablaAcum->dCostoFacturaNeto[i] +
                            sthTablaAcum->dGravPrimeraCategoria[i] +
                            sthTablaAcum->dGravSegundaCategoria[i];

            switch (sthTablaAcum->iCodGrupo[i])
            {
                case COD_GRUPO_SALDANT:{
                    SaldoTot->dTotalSaldo = SaldoTot->dTotalSaldo / dFact_Conversion;
                    sprintf(buffer_local,REG_1800,
                        sthTablaAcum->iFacturable[i],
                        sthTablaAcum->iCodGrupo[i],
                        sthTablaAcum->szDesGrupo[i],
                        fnCnvDouble(SaldoTot->dTotalSaldo,1),
                        szResultado,
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[i],1),   
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[i],1),   
                        fnCnvDouble(dTotalNetoImpto,1),                         
                        sthTablaAcum->iNivelImpresion[i],      
                        sthTablaAcum->szTipUnidad[i],          
                        sthTablaAcum->szTipGrupo[i]);          

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
                case COD_GRUPO_CUOTA:{
                    dTotalCuotas = dTotalCuotas / dFact_Conversion;
                    sprintf(buffer_local,REG_1800,
                        sthTablaAcum->iFacturable[i],
                        sthTablaAcum->iCodGrupo[i],
                        sthTablaAcum->szDesGrupo[i],
                        fnCnvDouble(dTotalCuotas,1),
                        szResultado,
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[i],1),   
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[i],1),   
                        fnCnvDouble(dTotalNetoImpto,1),                         
                        sthTablaAcum->iNivelImpresion[i],       
                        sthTablaAcum->szTipUnidad[i],           
                        sthTablaAcum->szTipGrupo[i]);           

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
                default:{
                    sthTablaAcum->dCostoFacturaNeto[i] = sthTablaAcum->dCostoFacturaNeto[i] / dFact_Conversion;
                    sprintf(buffer_local,REG_1800,
                        sthTablaAcum->iFacturable[i],
                        sthTablaAcum->iCodGrupo[i],
                        sthTablaAcum->szDesGrupo[i],
                        fnCnvDouble(sthTablaAcum->dCostoFacturaNeto[i],1),
                        szResultado,
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[i],1),   
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[i],1),   
                        fnCnvDouble(dTotalNetoImpto,1),                         
                        sthTablaAcum->iNivelImpresion[i],       
                        sthTablaAcum->szTipUnidad[i],           
                        sthTablaAcum->szTipGrupo[i]);           

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
            }
        }
    }

        return (TRUE);
}/*****************************Final Put_A1800 ***********************************/

/****************************************************************************/
/* Funcion Put_A1900                                        */
/*  Descripcion : Imprime registro A1900 (Registro de Detalle Facturado Nivel 2) en el  */
/*            archivo descrito por Fd_ArchImp.                  */
/*  Entrada     : Fd_ArchImp y sthTablaAcum           */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A1900(FILE *Fd_ArchImp, ST_TABLA_ACUM *sthTablaAcum, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas,  char *zsBufferImpresionArchivo, DETALLEOPER *pst_MascaraOper, double dFact_Conversion, int iCodTipDocum, int iCodCiclo) /* P-TMM-03075 */
{
    register int ix,i, iPos;
    char        szFacturaSN_KeyAcum[5];
    int         iFacturaSN_KeyAcum;
    char        szLlaveAcumulacion[50];
    ST_TABLA    sthTabla;
    int         iValor;
    char        szResultado[20];
    char        szResultadoReal[20];
    char        szResultadoDcto[20];
    double      dTotalCuotas;
    char        buffer_local[MAX_BYTE_A1900];
    int         iCod_GrupoAnt;
    BOOL        Flg_CabeceraPie;
    ST_TABLA_ORDEN  pstTablaOrden;
    long        lPosicionReal;
    int         iMascara;
    int         iPosicionRegistro;
    double      dTotalPrimeraCateg=0.0;         
    double      dTotalSegundaCateg=0.0;         
    double      dTotalNetoImpto=0.0;            
    double      dTotalPorcenPrimeraCateg=0.0;   
    double      dTotalPorcenSegundaCateg=0.0;   
    char        szLlaveAnterior[50];
    double      dValUnitario=0.0;

    strcpy (szModulo, "Put_A1900");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    memset(&pstTablaOrden, 0, sizeof (ST_TABLA_ORDEN));
    memset(buffer_local,0,sizeof(buffer_local));
    memset(&sthTabla, 0, sizeof (ST_TABLA));

    dTotalCuotas = pstFaCuotas->dTotalCuotas_pven;

/*  Limpia Flag que marca Impuesto relacionado */
    if (stFaDetCons.iNumReg <= 0)
        return (TRUE);

    bfnLimpiaFlag(&pstCatImpues);

    memset (szLlaveAnterior, 0, sizeof(szLlaveAnterior));
    strcpy(szLlaveAnterior,"                    ");
    iValor=0;

    for (i=0; i < stOrden2DetConsumo.iNumRegs; i++ ) /* Se utiliza estructura de orden alterno */
    {
        vDTrazasLog(szModulo, "\t[JQH] i: [%d], stOrden2DetConsumo.iNumRegs: [%d]", LOG05, i, stOrden2DetConsumo.iNumRegs);
        iPos = stOrden2DetConsumo.stOrden[i].iPosicion; /* posicion en la estructura de consumo */

        memset(szFacturaSN_KeyAcum,0,sizeof(szFacturaSN_KeyAcum));
        if(strncmp(stFaDetCons.stDetConsumo[iPos].szTip_ConcNoFact," ",1)==0)
        {
            strcpy(szFacturaSN_KeyAcum,szCONCEP_FACTURABLE);
            iFacturaSN_KeyAcum=iCONCEP_FACTURABLE;
        }
        else
        {
            strcpy(szFacturaSN_KeyAcum,szCONCEP_NO_FACTURABLE);
            iFacturaSN_KeyAcum=iCONCEP_NO_FACTURABLE;
        }
        memset(szLlaveAcumulacion,0,sizeof(szLlaveAcumulacion));/*AFGS - 66237*/
        
        sprintf(szLlaveAcumulacion,"%s|%05d|%05d|%05d|%05d|%05d",
                szFacturaSN_KeyAcum,
                stFaDetCons.stDetConsumo[iPos].iNum_OrdenGr,
                stFaDetCons.stDetConsumo[iPos].iNum_OrdenSubGr,
                stFaDetCons.stDetConsumo[iPos].iNum_OrdenConc,
                stFaDetCons.stDetConsumo[iPos].iCodGrupo,
                stFaDetCons.stDetConsumo[iPos].iCodConcepto);

        /* Si es no ciclo, se adjunta num_celular */
        if(iCodCiclo == 0)
        {


            vDTrazasLog(szModulo, "\t[JQH] szLlaveAcumulacion : [%s], stFaDetCons.stDetConsumo[iPos].szNum_Celular [%s]", LOG05
                                    , szLlaveAcumulacion
                                    , stFaDetCons.stDetConsumo[iPos].szNum_Celular);

            strcat(szLlaveAcumulacion,"|");
            strcat(szLlaveAcumulacion, alltrim(stFaDetCons.stDetConsumo[iPos].szNum_Celular));
            vDTrazasLog(szModulo, "\t[JQH] szLlaveAcumulacion despues de strcat: [%s]",LOG05, szLlaveAcumulacion);

        }

        /* Llama a funcion que Totaliza el porcentaje de impuestos */
        if(strcmp(szLlaveAcumulacion,szLlaveAnterior)!=0)
        {
            strcpy(szLlaveAnterior,szLlaveAcumulacion);

            dTotalPorcenPrimeraCateg=0.0;
            dTotalPorcenSegundaCateg=0.0;

            if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
                return(FALSE);
            }
            else
            {
                sthTablaAcum->dPorcPrimeraCategoria[iValor] = dTotalPorcenPrimeraCateg;
                sthTablaAcum->dPorcSegundaCategoria[iValor] = dTotalPorcenSegundaCateg;
            }
        }
        iValor = RetPos(szLlaveAcumulacion, &sthTabla);

        strcpy(sthTablaAcum->szKey[iValor],szLlaveAcumulacion);

        sthTablaAcum->lSegundos[iValor]           += stFaDetCons.stDetConsumo[iPos].lSeg_Consumo;
        sthTablaAcum->dCostoFacturaNeto[iValor]   += stFaDetCons.stDetConsumo[iPos].dTotalFacturableNet;
        sthTablaAcum->iUnidades[iValor]           += stFaDetCons.stDetConsumo[iPos].iNum_Unidades;
        sthTablaAcum->lCntLlamReal[iValor]        += stFaDetCons.stDetConsumo[iPos].lCntLlamReal;
        sthTablaAcum->lCntLlamDcto[iValor]        += stFaDetCons.stDetConsumo[iPos].lCntLlamDcto;
        sthTablaAcum->lCntLlamFAct[iValor]        += stFaDetCons.stDetConsumo[iPos].lCntLlamFAct;
        sthTablaAcum->lSegundosReal[iValor]       += stFaDetCons.stDetConsumo[iPos].lSeg_ConsumoReal;
        sthTablaAcum->lSegundosDcto[iValor]       += stFaDetCons.stDetConsumo[iPos].lSeg_ConsumoDcto;
        sthTablaAcum->dCostoFacturaReal[iValor]   += stFaDetCons.stDetConsumo[iPos].dTotalFacturableReal;
        sthTablaAcum->dCostoFacturaDcto[iValor]   += stFaDetCons.stDetConsumo[iPos].dTotalFacturableDcto;
        sthTablaAcum->iCodGrupo[iValor]            = stFaDetCons.stDetConsumo[iPos].iCodGrupo;
        sthTablaAcum->iCodConcepto[iValor]         = stFaDetCons.stDetConsumo[iPos].iCodConcepto;
        strcpy (sthTablaAcum->szDesGrupo[iValor]   , stFaDetCons.stDetConsumo[iPos].szGlosaGrupo);
        
        memset (sthTablaAcum->szDesConcepto[iValor],0, sizeof(sthTablaAcum->szDesConcepto[iValor]));
        strcpy (sthTablaAcum->szDesConcepto[iValor], stFaDetCons.stDetConsumo[iPos].szDes_Concepto);

        strcpy(sthTablaAcum->szTipGrupo [iValor] , stFaDetCons.stDetConsumo[iPos].szTipGrupo);
        strcpy(sthTablaAcum->szTipUnidad[iValor] , stFaDetCons.stDetConsumo[iPos].szTipUnidad);
        sthTablaAcum->iNivelImpresion   [iValor] = stFaDetCons.stDetConsumo[iPos].iNivelImpresion;
        sthTablaAcum->dImpValUnitario   [iValor] += stFaDetCons.stDetConsumo[iPos].dImpValUnitario;

        vDTrazasLog(szModulo, "\t[JQH] iValor : [%d]\n"
                              "\t      iPos   : [%d]\n"
                              "\t      sthTablaAcum->szNum_Celular [iValor] : [%s]\n"
                              "\t      stFaDetCons.stDetConsumo[iPos].szNum_Celular : [%s]\n"
                              ,LOG05
                              ,iValor
                              ,iPos
                              ,sthTablaAcum->szNum_Celular [iValor]
                              ,stFaDetCons.stDetConsumo[iPos].szNum_Celular);


        strcpy(sthTablaAcum->szNum_Celular [iValor] , stFaDetCons.stDetConsumo[iPos].szNum_Celular);
        vDTrazasLog(szModulo, "\t[JQH] Despues de strcpy()", LOG05);

        if(stFaDetCons.stDetConsumo[iPos].lSeg_Consumo > 0)
        {
            sthTablaAcum->lTotalSeg  += stFaDetCons.stDetConsumo[iPos].lSeg_Consumo;
        }

        sthTablaAcum->iFacturable[iValor]=iFacturaSN_KeyAcum;

        if(sthTablaAcum->iFacturable[iValor] == iCONCEP_FACTURABLE)
        {
            sthTablaAcum->dTotalCosto += stFaDetCons.stDetConsumo[iPos].dTotalFacturableNet;
            sthTablaAcum->iCantidad   += stFaDetCons.stDetConsumo[iPos].iNum_Unidades;
        }

/*      Llama a funcion que Totaliza los impuestos considerando los conceptos relacionados */

        if (stFaDetCons.stDetConsumo[iPos].iCodTipConce !=1)
        {
            dTotalPrimeraCateg=0.0;
            dTotalSegundaCateg=0.0;
            /* Esta funcion estaba comentariada y se deja igual a Impresor antes del proyecto */
            if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iPos].iCodConcepto, stFaDetCons.stDetConsumo[iPos].iColumna,&dTotalPrimeraCateg, &dTotalSegundaCateg ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
                return(FALSE);
            }
            
            dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iPos].dTotalPrimeraCateg;
            dTotalSegundaCateg = stFaDetCons.stDetConsumo[iPos].dTotalSegundaCateg;

            sthTablaAcum->dGravPrimeraCategoria[iValor]  += dTotalPrimeraCateg;
            sthTablaAcum->dGravSegundaCategoria[iValor]  += dTotalSegundaCateg;


        }

        vDTrazasLog(szModulo, "Put_A1900:ARREGLO DETCONSU (%s|%d|%s|%d|%s|%s|%s|%d|%15.4f)",
                             LOG06,
                             stFaDetCons.stDetConsumo[iPos].szTip_ConcNoFact,
                             stFaDetCons.stDetConsumo[iPos].iNum_OrdenGr,
                             stFaDetCons.stDetConsumo[iPos].szGlosaGrupo,
                             stFaDetCons.stDetConsumo[iPos].iNum_OrdenConc,
                             stFaDetCons.stDetConsumo[iPos].szDes_Concepto,
                             stFaDetCons.stDetConsumo[iPos].szTipGrupo,
                             stFaDetCons.stDetConsumo[iPos].szTipUnidad,
                             stFaDetCons.stDetConsumo[iPos].iNivelImpresion,
                             stFaDetCons.stDetConsumo[iPos].dImpValUnitario);
    } /* fin for de ACUMULACION */


    if (stStatus.LogNivel >= LOG06)
    {
        for (i=0; i < sthTabla.iLastPosition; i++ )
        {
            vDTrazasLog(szModulo, "Put_A1900:ARREGLO ANTES ORDEN [%d](%d|%d|%s|%d|%s|%12.12ld|%15.4f|%d|%ld|%ld|%ld|%s|%s|%d|%15.4f|%f|%f)", LOG06,i,
                                 sthTablaAcum->iFacturable[i],
                                 sthTablaAcum->iCodConcepto[i],
                                 sthTablaAcum->szDesConcepto[i],
                                 sthTablaAcum->iCodGrupo[i],
                                 sthTablaAcum->szDesGrupo[i],
                                 sthTablaAcum->lSegundos[i],
                                 sthTablaAcum->dCostoFacturaNeto[i],
                                 sthTablaAcum->iUnidades[i],
                                 sthTablaAcum->lCntLlamReal[i],
                                 sthTablaAcum->lCntLlamDcto[i],
                                 sthTablaAcum->lCntLlamFAct[i],
                                 sthTablaAcum->szTipGrupo [i],
                                 sthTablaAcum->szTipUnidad[i],
                                 sthTablaAcum->iNivelImpresion[i],
                                 sthTablaAcum->dImpValUnitario[i],
                                 sthTablaAcum->dGravPrimeraCategoria[i],
                                 sthTablaAcum->dGravSegundaCategoria[i]);
            vDTrazasLog(szModulo, "Put_A1900:ARREGLO KEY [%s]", LOG06,sthTablaAcum->szKey[i]);
        }
    }

    /*------------------------------------------------------------------------------------
     ORDENA LOS CONCEPTOS YA ACUMULADOS :
    -------------------------------------------------------------------------------------*/
    if (!bfnOrdenaImpresionRC(sthTablaAcum, &pstTablaOrden, sthTabla.iLastPosition))
    {
        vDTrazasLog(szModulo,"Funcion bfnOrdenaImpresionRC FALLO\n", LOG05);
        return FALSE;
    }

    if (stStatus.LogNivel >= LOG06)
    {
        for (i=0; i<sthTabla.iLastPosition ;i++)
        {
            ix=pstTablaOrden.iSocalo[i];
            vDTrazasLog(szModulo, "Put_A1900:ARREGLO ORDENADO key(%s)socalo(%d)(%d|%d|%s|%d|%s|%s|%s|%d|%15.4f|%f|%f)", LOG06,
                    pstTablaOrden.szKey[ix],
                    ix,
                    sthTablaAcum->iFacturable[ix],
                    sthTablaAcum->iCodGrupo[ix],
                    sthTablaAcum->szDesGrupo[ix],
                    sthTablaAcum->iCodConcepto[ix],
                    sthTablaAcum->szDesConcepto[ix],
                    sthTablaAcum->szTipGrupo [ix],
                    sthTablaAcum->szTipUnidad[ix],
                    sthTablaAcum->iNivelImpresion[ix],
                    sthTablaAcum->dImpValUnitario[ix],
                    sthTablaAcum->dGravPrimeraCategoria[ix],
                    sthTablaAcum->dGravSegundaCategoria[ix]);
        }
    }

    /*------------------------------------------------------------------------------------
     IMPRIME LOS CONCEPTOS ACUMULADOS Y ORDENADOS FACTURABLES
    -------------------------------------------------------------------------------------*/
    iCod_GrupoAnt  = -666;
    Flg_CabeceraPie = FALSE;

    for (i=0; i<sthTabla.iLastPosition ;i++)
    {
        lPosicionReal = pstTablaOrden.iSocalo[i];
        if (sthTablaAcum->iFacturable[lPosicionReal] == iCONCEP_FACTURABLE)
        {
            sprintf(szResultado,"%12.12ld",sthTablaAcum->lSegundos[lPosicionReal]);
            sprintf(szResultadoReal,"%12.12ld",sthTablaAcum->lSegundosReal[lPosicionReal]);
            sprintf(szResultadoDcto,"%12.12ld",sthTablaAcum->lSegundosDcto[lPosicionReal]);

            vDTrazasLog(szModulo, "Put_A1900:ARREGLO GRUPOS FACTURABLE (%d|%ld|%d|%s|%s|%15.4f|%d|%ld|%ld|%ld|%s|%s|%d|%15.4f)",
                            LOG05,i ,lPosicionReal,
                            sthTablaAcum->iCodGrupo[lPosicionReal],
                            sthTablaAcum->szDesGrupo[lPosicionReal],
                            szResultado,
                            sthTablaAcum->dCostoFacturaNeto[lPosicionReal],
                            sthTablaAcum->iUnidades[lPosicionReal],
                            sthTablaAcum->lCntLlamReal[lPosicionReal],
                            sthTablaAcum->lCntLlamDcto[lPosicionReal],
                            sthTablaAcum->lCntLlamFAct[lPosicionReal],
                            sthTablaAcum->szTipGrupo [lPosicionReal],
                            sthTablaAcum->szTipUnidad[lPosicionReal],
                            sthTablaAcum->iNivelImpresion[lPosicionReal],
                            sthTablaAcum->dImpValUnitario[lPosicionReal]);

            switch (sthTablaAcum->iCodGrupo[lPosicionReal])
            {
                case COD_GRUPO_SALDANT:
                    if (SaldoTot->dTotalSaldo < 0)
                        break;
                    if (!strcmp(szResultado,"000000000000") && SaldoTot->dTotalSaldo == 0)
                        continue;
                    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1100",pst_MascaraOper->iCantRegistros,iCodTipDocum);
                    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;
                    if (iMascara == 1)
                        continue;
                    break;
                case COD_GRUPO_CUOTA:
                    if (dTotalCuotas < 0)
                        break;
                    if (!strcmp(szResultado,"000000000000") && dTotalCuotas == 0)
                        continue;
                    break;
                default:
                    if (sthTablaAcum->dCostoFacturaNeto[lPosicionReal] < 0)
                        break;
                    if (sthTablaAcum->iUnidades[lPosicionReal] < 0)
                        break;
                    if (!strcmp(szResultado,"000000000000") && sthTablaAcum->dCostoFacturaNeto[lPosicionReal]==0 && sthTablaAcum->iUnidades[lPosicionReal]== 0)
                        continue;
                    break;
            }

            if (iCod_GrupoAnt != sthTablaAcum->iCodGrupo[lPosicionReal])
            {
                if (Flg_CabeceraPie)
                {
                    strcpy(buffer_local,REG_1999);
                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));

                    Flg_CabeceraPie = FALSE;
                    i--;
                    continue;
                }
                else
                {
                    sprintf (buffer_local,REG_1890,
                            sthTablaAcum->iFacturable[lPosicionReal],
                            sthTablaAcum->iCodGrupo[lPosicionReal],
                            sthTablaAcum->szDesGrupo[lPosicionReal],
                            sthTablaAcum->iNivelImpresion[lPosicionReal],       
                            sthTablaAcum->szTipUnidad[lPosicionReal],           
                            sthTablaAcum->szTipGrupo[lPosicionReal]);           

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    Flg_CabeceraPie = TRUE;

                }
            }

            switch (sthTablaAcum->iCodGrupo[lPosicionReal])
            {
                case COD_GRUPO_SALDANT:
                {
                    SaldoTot->dTotalSaldo = SaldoTot->dTotalSaldo / dFact_Conversion;

                    vDTrazasLog(szModulo, "Put_A1900: Monto Final (SaldoTot->dTotalSaldo / dFact_Conversion) = [%f]\n", LOG05, SaldoTot->dTotalSaldo);

                    sprintf(buffer_local,REG_1900,sthTablaAcum->iCodConcepto[lPosicionReal],
                                              sthTablaAcum->szDesConcepto[lPosicionReal],
                                              fnCnvDouble(SaldoTot->dTotalSaldo,1),
                                              szResultado,0,(long)0,(long)0,(long)0,0.0,0.0,"","",0.0,"",0.0,0.0,0.0,0.0,0.0,
                                              (iCodCiclo == 0)?sthTablaAcum->szNum_Celular [lPosicionReal]:" ");

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;
                }
                case COD_GRUPO_CUOTA:
                {
                    dTotalCuotas = dTotalCuotas / dFact_Conversion;

                    vDTrazasLog(szModulo, "Put_A1900: dTotalCuotas (dTotalCuotas / dFact_Conversion) = [%f]\n", LOG05, dTotalCuotas);

                    sprintf(buffer_local,REG_1900,
                        sthTablaAcum->iCodConcepto[lPosicionReal],
                        sthTablaAcum->szDesConcepto[lPosicionReal],
                        fnCnvDouble(dTotalCuotas,1),
                        szResultado,0,(long)0,(long)0,(long)0,0.0,0.0,"","",0.0,"",0.0,0.0,0.0,0.0,0.0,
                        (iCodCiclo == 0)?sthTablaAcum->szNum_Celular [lPosicionReal]:" ");

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;
                }
                default:
                {
                    sthTablaAcum->dCostoFacturaNeto[lPosicionReal]   = sthTablaAcum->dCostoFacturaNeto[lPosicionReal] / dFact_Conversion; /* P-TMM-03075 */
                    sthTablaAcum->dCostoFacturaReal[lPosicionReal]   = sthTablaAcum->dCostoFacturaReal[lPosicionReal] / dFact_Conversion; /* P-TMM-03075 */
                    sthTablaAcum->dCostoFacturaDcto[lPosicionReal]   = sthTablaAcum->dCostoFacturaDcto[lPosicionReal] / dFact_Conversion; /* P-TMM-03075 */
                    sthTablaAcum->dImpValUnitario  [lPosicionReal]   = sthTablaAcum->dImpValUnitario  [lPosicionReal] / dFact_Conversion; /* P-TMM-03075 */

/*     SCL - FACTURACIÓN - GAP IMPRESIÓN (2 Ó 1)
       Totaliza impuestos
*/
                    dTotalNetoImpto=0.0;

                    dTotalNetoImpto=sthTablaAcum->dCostoFacturaNeto[lPosicionReal] +
                                    sthTablaAcum->dGravPrimeraCategoria[lPosicionReal] +
                                    sthTablaAcum->dGravSegundaCategoria[lPosicionReal];
                                    
                    if(sthTablaAcum->iUnidades[lPosicionReal]<=0)
                        dValUnitario= sthTablaAcum->dCostoFacturaNeto[lPosicionReal];
                    else
                        dValUnitario = sthTablaAcum->dCostoFacturaNeto[lPosicionReal]/(double)sthTablaAcum->iUnidades[lPosicionReal];

                    sprintf(buffer_local,REG_1900,
                        sthTablaAcum->iCodConcepto[lPosicionReal],
                        sthTablaAcum->szDesConcepto[lPosicionReal],
                        fnCnvDouble(sthTablaAcum->dCostoFacturaNeto[lPosicionReal],1),
                        szResultado,
                        sthTablaAcum->iUnidades[lPosicionReal],
                        sthTablaAcum->lCntLlamReal[lPosicionReal],
                        sthTablaAcum->lCntLlamDcto[lPosicionReal],
                        sthTablaAcum->lCntLlamFAct[lPosicionReal],
                        fnCnvDouble(sthTablaAcum->dCostoFacturaReal[lPosicionReal],1),
                        fnCnvDouble(sthTablaAcum->dCostoFacturaDcto[lPosicionReal],1),
                        szResultadoReal,
                        szResultadoDcto,
                        fnCnvDouble(dValUnitario,1),                                     
                        stFaDetCons.stDetConsumo[lPosicionReal].szGlsDescrip,    
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[lPosicionReal],1),
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[lPosicionReal],1),
                        fnCnvDouble(sthTablaAcum->dPorcPrimeraCategoria[lPosicionReal],1),
                        fnCnvDouble(sthTablaAcum->dPorcSegundaCategoria[lPosicionReal],1),
                        fnCnvDouble(dTotalNetoImpto,1),                                   
                        (iCodCiclo == 0)?sthTablaAcum->szNum_Celular [lPosicionReal]:" ");
                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;
                }
            }
            iCod_GrupoAnt = sthTablaAcum->iCodGrupo[lPosicionReal];
        }
    }

    if (Flg_CabeceraPie)
    {
        strcpy(buffer_local,REG_1999);
        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            return(FALSE);
        memset(buffer_local,0,sizeof(buffer_local));
    }

    /*------------------------------------------------------------------------------------
     IMPRIME LOS CONCEPTOS ACUMULADOS Y ORDENADOS NO-FACTURABLES
    -------------------------------------------------------------------------------------*/
    iCod_GrupoAnt  = -666;
    Flg_CabeceraPie = FALSE;
    for (i=0; i<sthTabla.iLastPosition ;i++)
    {
        lPosicionReal = pstTablaOrden.iSocalo[i];
        if (sthTablaAcum->iFacturable[lPosicionReal] == iCONCEP_NO_FACTURABLE)
        {

            sprintf(szResultado,"%12.12ld",sthTablaAcum->lSegundos[lPosicionReal]);
            sprintf(szResultadoReal,"%12.12ld",sthTablaAcum->lSegundosReal[lPosicionReal]);
            sprintf(szResultadoDcto,"%12.12ld",sthTablaAcum->lSegundosDcto[lPosicionReal]);

            vDTrazasLog(szModulo, "Put_A1900:ARREGLO IMPRESION DE GRUPOS NO_FACTURABLE (%d|%d|%s|%s|%15.4f|%d|%ld|%ld|%ld)", LOG05,i,
                        sthTablaAcum->iCodGrupo[lPosicionReal],
                        sthTablaAcum->szDesGrupo[lPosicionReal],
                        szResultado,
                        sthTablaAcum->dCostoFacturaNeto[lPosicionReal],
                        sthTablaAcum->iUnidades[lPosicionReal],
                        sthTablaAcum->lCntLlamReal[lPosicionReal],
                        sthTablaAcum->lCntLlamDcto[lPosicionReal],
                        sthTablaAcum->lCntLlamFAct[lPosicionReal]);

            switch (sthTablaAcum->iCodGrupo[lPosicionReal])
            {
                case COD_GRUPO_SALDANT:
                    if (!strcmp(szResultado,"000000000000") && SaldoTot->dTotalSaldo == 0)
                        continue;
                    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1100",pst_MascaraOper->iCantRegistros, iCodTipDocum);
                    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;
                    if (iMascara == 1)
                        continue;
                    break;
                case COD_GRUPO_CUOTA:
                    if (!strcmp(szResultado,"000000000000") && dTotalCuotas == 0)
                        continue;
                    break;
                default:
                    if (!strcmp(szResultado,"000000000000") && sthTablaAcum->dCostoFacturaNeto[lPosicionReal]==0 && sthTablaAcum->iUnidades[lPosicionReal]== 0)
                        continue;
                    break;
            }

            if (iCod_GrupoAnt != sthTablaAcum->iCodGrupo[lPosicionReal])
            {
                if (Flg_CabeceraPie)
                {
                    strcpy(buffer_local,REG_1999);
                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));

                    Flg_CabeceraPie = FALSE;
                    i--;
                    continue;
                }
                else
                {
                    sprintf (buffer_local,REG_1890,
                            sthTablaAcum->iFacturable[lPosicionReal],
                            sthTablaAcum->iCodGrupo[lPosicionReal],
                            sthTablaAcum->szDesGrupo[lPosicionReal],
                            sthTablaAcum->iNivelImpresion[lPosicionReal],
                            sthTablaAcum->szTipUnidad[lPosicionReal],    
                            sthTablaAcum->szTipGrupo[lPosicionReal]);    

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    Flg_CabeceraPie = TRUE;
                }
            }

            switch (sthTablaAcum->iCodGrupo[lPosicionReal])
            {
                case COD_GRUPO_SALDANT:{
                    SaldoTot->dTotalSaldo = SaldoTot->dTotalSaldo / dFact_Conversion;

                    vDTrazasLog(szModulo, "Put_A1900: Monto Final (SaldoTot->dTotalSaldo / dFact_Conversion) = [%f]\n", LOG05, SaldoTot->dTotalSaldo);

                    sprintf(buffer_local,REG_1900,
                        sthTablaAcum->iCodConcepto[lPosicionReal],
                        sthTablaAcum->szDesConcepto[lPosicionReal],
                        fnCnvDouble(SaldoTot->dTotalSaldo,1),
                        szResultado,0,(long)0,(long)0,(long)0,0.0,0.0,"","",0.0,"",0.0,0.0,0.0,0.0,0.0,
                        (iCodCiclo == 0)?sthTablaAcum->szNum_Celular [lPosicionReal]:" ");

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
                case COD_GRUPO_CUOTA:{
                    dTotalCuotas = dTotalCuotas / dFact_Conversion;

                    vDTrazasLog(szModulo, "Put_A1900: dTotalCuotas (dTotalCuotas / dFact_Conversion) = [%f]\n", LOG05, dTotalCuotas);

                    sprintf(buffer_local,REG_1900,
                        sthTablaAcum->iCodConcepto[lPosicionReal],
                        sthTablaAcum->szDesConcepto[lPosicionReal],
                        fnCnvDouble(dTotalCuotas,1),
                        szResultado,0,(long)0,(long)0,(long)0,0.0,0.0,"","",0.0,"",0.0,0.0,0.0,0.0,0.0,
                        (iCodCiclo == 0)?sthTablaAcum->szNum_Celular [lPosicionReal]:" "); 

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
                default:{
                    sthTablaAcum->dCostoFacturaNeto[lPosicionReal]   = sthTablaAcum->dCostoFacturaNeto[lPosicionReal] / dFact_Conversion; 
                    sthTablaAcum->dCostoFacturaReal[lPosicionReal]   = sthTablaAcum->dCostoFacturaReal[lPosicionReal] / dFact_Conversion; 
                    sthTablaAcum->dCostoFacturaDcto[lPosicionReal]   = sthTablaAcum->dCostoFacturaDcto[lPosicionReal] / dFact_Conversion; 
                    sthTablaAcum->dImpValUnitario  [lPosicionReal]   = sthTablaAcum->dImpValUnitario  [lPosicionReal] / dFact_Conversion; 

/*       SCL - FACTURACIÓN - GAP IMPRESIÓN (2 Ó 1)
         Totaliza  impuestos
*/
                    dTotalNetoImpto=0.0;

                    dTotalNetoImpto=sthTablaAcum->dCostoFacturaNeto[lPosicionReal] +
                                    sthTablaAcum->dGravPrimeraCategoria[lPosicionReal] +
                                    sthTablaAcum->dGravSegundaCategoria[lPosicionReal];

                    if(sthTablaAcum->iUnidades[lPosicionReal]<=0)
                        dValUnitario = sthTablaAcum->dCostoFacturaNeto[lPosicionReal];
                    else
                        dValUnitario = sthTablaAcum->dCostoFacturaNeto[lPosicionReal]/(double)sthTablaAcum->iUnidades[lPosicionReal];

                    sprintf(buffer_local,REG_1900,
                        sthTablaAcum->iCodConcepto[lPosicionReal],
                        sthTablaAcum->szDesConcepto[lPosicionReal],
                        fnCnvDouble(sthTablaAcum->dCostoFacturaNeto[lPosicionReal],1),
                        szResultado,
                        sthTablaAcum->iUnidades[lPosicionReal],
                        sthTablaAcum->lCntLlamReal[lPosicionReal],
                        sthTablaAcum->lCntLlamDcto[lPosicionReal],
                        sthTablaAcum->lCntLlamFAct[lPosicionReal],
                        fnCnvDouble(sthTablaAcum->dCostoFacturaReal[lPosicionReal],1),
                        fnCnvDouble(sthTablaAcum->dCostoFacturaDcto[lPosicionReal],1),
                        szResultadoReal,
                        szResultadoDcto,
                        fnCnvDouble(dValUnitario,1),                                        
                        stFaDetCons.stDetConsumo[lPosicionReal].szGlsDescrip,         		
                        fnCnvDouble(sthTablaAcum->dGravPrimeraCategoria[lPosicionReal],1),  
                        fnCnvDouble(sthTablaAcum->dGravSegundaCategoria[lPosicionReal],1),
                        fnCnvDouble(sthTablaAcum->dPorcPrimeraCategoria[lPosicionReal],1),  
                        fnCnvDouble(sthTablaAcum->dPorcSegundaCategoria[lPosicionReal],1),  
                        fnCnvDouble(dTotalNetoImpto,1),                                     
                        (iCodCiclo == 0)?sthTablaAcum->szNum_Celular [lPosicionReal]:" ");  

                    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                        return(FALSE);
                    memset(buffer_local,0,sizeof(buffer_local));
                    break;}
            }
            iCod_GrupoAnt = sthTablaAcum->iCodGrupo[lPosicionReal];
        }
    }

    if (Flg_CabeceraPie)
    {
        strcpy(buffer_local,REG_1999);
        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            return(FALSE);
        memset(buffer_local,0,sizeof(buffer_local));
    }

    return (TRUE);
}/*****************************Final Put_A1900 ***********************************/

/****************************************************************************/
/* Funcion Put_A2200                                                        */
/*  Descripcion : Imprime registro A2200 (Registro Total NO Facturado) en   */
/*            el archivo descrito por Fd_ArchImp.                           */
/*  Entrada     : Fd_ArchImp, estructuras SaldoTot y pstFaCuotas            */
/*      Salida      : Fd_ArchImp modificado                                 */
/*  Predecesor  : PutCaratula                                               */
/****************************************************************************/
int Put_A2200 ( FILE *Fd_ArchImp, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas, 
                char *zsBufferImpresionArchivo, double dFact_Conversion)
{
    double  dMontoAcumulado;
    char    buffer_local[MAX_BYTE_A2200];

    memset(buffer_local,0,sizeof(buffer_local));

    dMontoAcumulado =  pstFaCuotas->dTotalCuotas_venci + pstFaCuotas->dTotalCuotas_pven + SaldoTot->dTotalSaldo;
    /*-------------------------------------------------------------------------*/
    /* Se acumulan las cuotas que estan vencidas, y no Vencidas                */
    /* en la misma variable que se utiliza con el saldo anterior.              */
    /*-------------------------------------------------------------------------*/

    dMontoAcumulado = dMontoAcumulado / dFact_Conversion;

    sprintf(buffer_local,REG_2200,fnCnvDouble(dMontoAcumulado,1));
    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);

}/*****************************Final Put_A2200 ***********************************/
/****************************************************************************/
/* Funcion Put_A2100                                                        */
/*  Descripcion : Imprime registro A2100 (Registro Total Facturado) en el archivo   */
/*            descrito por Fd_ArchImp.                      */
/*  Entrada     : Fd_ArchImp estructura sthTablaAcum                    */
/*      Salida      : Fd_ArchImp modificado                         */
/*  Predecesor  : PutCaratula                               */
/****************************************************************************/
int Put_A2100 ( FILE *Fd_ArchImp, ST_TABLA_ACUM sthTablaAcum, 
                char *zsBufferImpresionArchivo, double dFact_Conversion)
{
    char szResultado[20];
    char        buffer_local[MAX_BYTE_A2100];

    memset(buffer_local,0,sizeof(buffer_local));

    sprintf(szResultado,"%12.12ld",sthTablaAcum.lTotalSeg);

    sthTablaAcum.dTotalCosto = sthTablaAcum.dTotalCosto / dFact_Conversion;

    sprintf(buffer_local,REG_2100,fnCnvDouble(sthTablaAcum.dTotalCosto,1),szResultado);
    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);

}/*****************************Final Put_A2100 ***********************************/
/****************************************************************************/
/* Funcion Put_A2300                                                        */
/*  Descripcion : Imprime registro A2300 (Registro Mensajes Documentos no   */
/*            Ciclicos) en el archivo descrito por Fd_ArchImp.              */
/*  Entrada     : Fd_ArchImp, estructura Mensajes_NoCiclo                   */
/*      Salida      : Fd_ArchImp modificado                                 */
/*  Predecesor  : PutCaratula                                               */
/****************************************************************************/
int Put_A2300(FILE *Fd_ArchImp, ST_MENSAJES_NOCICLO *Mensajes_NoCiclo, char *zsBufferImpresionArchivo)
{
    char    buffer_local[MAX_BYTE_A2300];
    int     i;
    memset(buffer_local,0,sizeof(buffer_local));

    for(i=0;i<Mensajes_NoCiclo->iCantLineas;i++)
    {
       sprintf(buffer_local,REG_2300,Mensajes_NoCiclo->szMensajes[i]);

        if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
               return(FALSE);
    }
    return(TRUE);

}/*****************************Final Put_A2300 ***********************************/
int Put_A2400   ( FILE *Fd_ArchImp
                , ST_FACTCLIE *FactDocuClie
                , STSALDO_ANTERIOR *SaldoTot
                , ST_CUOTAS *pstFaCuotas
                , char *zsBufferImpresionArchivo
                , ST_BALANCE *stBalance)
{
    double  dTotalAPagar;
    double  dTotalCuotas;
    char    szMontoEscrito_Ingles [300];
    char    szMontoEscrito_Entero [150];
    char    szMontoEscrito_Decimal[70];
    char    buffer_local[MAX_BYTE_A2400];

    memset(buffer_local,0,sizeof(buffer_local));

    strcpy (szModulo, "Put_A2400");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    dTotalCuotas = fnCnvDouble(pstFaCuotas->dTotalCuotas_venci + pstFaCuotas->dTotalCuotas_pven, 1);

    vDTrazasLog(szModulo, "SUMA SaldoTot->dTotalSaldo                [%f] \n"
                          "SUMA stBalance->dMonto[iBALANCE_ANTERIOR] [%f]  \n"
                          "SUMA FactDocuClie->dTotCargosMes          [%f]  \n"
                          "SUMA dTotalCuotas                         [%f] \n",LOG05,
                          SaldoTot->dTotalSaldo,
                          stBalance->dMonto[iBALANCE_ANTERIOR],
                          FactDocuClie->dTotCargosMes,
                          dTotalCuotas);

    dTotalAPagar =  fnCnvDouble(FactDocuClie->dTotCargosMes,1) ;

    vDTrazasLog(szModulo, "\n\t Cod. Idioma [%s]", LOG05, FactDocuClie->szCod_Idioma);

    if(strcmp(FactDocuClie->szCod_Idioma,"1")==0)
    {
        vDTrazasLog(szModulo, "\n\t Monto Escrito Español", LOG05);
        /* EXEC SQL SELECT PR_MONTO_ESCRITO.mto_escrito(:dTotalAPagar,2) INTO :szMontoEscrito_Entero  FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select PR_MONTO_ESCRITO.mto_escrito(:b0,2) into :b1  \
from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )370;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dTotalAPagar;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szMontoEscrito_Entero;
        sqlstm.sqhstl[1] = (unsigned long )150;
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


        /* EXEC SQL SELECT PR_MONTO_ESCRITO.mto_escrito(:dTotalAPagar,3) INTO :szMontoEscrito_Decimal FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select PR_MONTO_ESCRITO.mto_escrito(:b0,3) into :b1  \
from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )393;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dTotalAPagar;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szMontoEscrito_Decimal;
        sqlstm.sqhstl[1] = (unsigned long )70;
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



        sprintf(buffer_local,REG_2400,szMontoEscrito_Entero,
                                      szMontoEscrito_Decimal,
                                      sthFadParametros.val_caracter[MONTO_ESCRITO_MONEDA],
                                      sthFadParametros.val_caracter[MONTO_ESCRITO_PREFIJO],
                                      sthFadParametros.val_caracter[MONTO_ESCRITO_POSFIJO]);
    }
    else
    {
        vDTrazasLog(szModulo, "\n\t Monto Escrito Ingles", LOG05);    	
        /* EXEC SQL SELECT NUMTOCHAR(:dTotalAPagar) INTO :szMontoEscrito_Ingles FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NUMTOCHAR(:b0) into :b1  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )416;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dTotalAPagar;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szMontoEscrito_Ingles;
        sqlstm.sqhstl[1] = (unsigned long )300;
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


        sprintf(buffer_local,REG_2400_Ingles,szMontoEscrito_Ingles);
    }

    if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
        return(FALSE);

    return(TRUE);
}/*****************************Final Put_A2400 ***********************************/

/*
 * Funcion      :       Put_A2500
 * Descripcion  :       Impresion de los conceptos de cargo(3) y carrier(4) para el cliente en curso,
 *                      junto con sus series de venta y descuentos.
 * Parametros   :   ->  Fd_ArchImp
 *                          Puntero al archivo de Impresion.
 *                  ->  FactDocuClie
 *                          Puntero a estructura contenedora de datos del documento de cliente actual.
 *                  ->  iFlagMascaraA2600
 *                          Indicador de Impresion del registro interno A2600.
 *                  ->  iFlagMascaraA2700
 *                          Indicador de Impresion del registro interno A2600.
 *                  ->  zsBufferImpresionArchivo
 *                          Buffer contenedor de datos a imprimir a archivo.
 * Retorna          TRUE    Si la ejecucion ha sido totalmente exitosa.
 *                  FALSE   Si ha ocurrido algun problema interno en la funcion.
 */
int Put_A2500(FILE *Fd_ArchImp
            , ST_FACTCLIE *FactDocuClie
            , int iFlagMascaraA2600
            , int iFlagMascaraA2700
            , char *zsBufferImpresionArchivo)
{

    register int    i = 0;
    register int    iPos = 0;
    char    buffer_local[MAX_BYTE_A2500];
    double  dTotalNetoImpto       = 0.0;
    double  dGravPrimeraCategoria = 0.0;
    double  dGravSegundaCategoria = 0.0;
    double  dPorcPrimeraCategoria = 0.0;
    double  dPorcSegundaCategoria = 0.0;

    long    lDuracionReal         = 0L;
    long    lDuracionDcto         = 0L;

    strcpy (szModulo, "Put_A2500");

    /* Recorrer la estructura de detalle de consumo */
    for (i=0; i < stOrden2DetConsumo.iNumRegs; i++ ) /* Se utiliza estructura de orden alterno */
    {
        iPos = stOrden2DetConsumo.stOrden[i].iPosicion; /* posicion en la estructura de consumo */

        /* Imprimir todos los codigos de tipo 3 (cargo) y 4 (carrier) */
        if(stFaDetCons.stDetConsumo[iPos].iCodTipConce == 3 || stFaDetCons.stDetConsumo[iPos].iCodTipConce == 4)
        {						
            if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iPos].iCodConcepto, stFaDetCons.stDetConsumo[iPos].iColumna,&dGravPrimeraCategoria, &dGravSegundaCategoria ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
                return(FALSE);
            }
            
            dGravPrimeraCategoria = stFaDetCons.stDetConsumo[iPos].dTotalPrimeraCateg;
            dGravSegundaCategoria = stFaDetCons.stDetConsumo[iPos].dTotalSegundaCateg;

            dPorcPrimeraCategoria=0.0;
            dPorcSegundaCategoria=0.0;

            if (!bfnPorcenImptosCateg(&dPorcPrimeraCategoria, &dPorcSegundaCategoria ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
                return(FALSE);
            }

            dTotalNetoImpto=0.0;
            dTotalNetoImpto = stFaDetCons.stDetConsumo[iPos].dTotalFacturableNet + dGravPrimeraCategoria + dGravSegundaCategoria;


            /* ECU-05021: Validar duracion real y con descuento */

            lDuracionReal = (stFaDetCons.stDetConsumo[iPos].lSeg_ConsumoReal)<0?0L:stFaDetCons.stDetConsumo[iPos].lSeg_ConsumoReal;

            lDuracionDcto = (stFaDetCons.stDetConsumo[iPos].lSeg_ConsumoDcto)<0?0L:stFaDetCons.stDetConsumo[iPos].lSeg_ConsumoDcto;


            /* Imprimir el concepto */
            sprintf(buffer_local,REG_2500,
                stFaDetCons.stDetConsumo[iPos].iCodConcepto,
                stFaDetCons.stDetConsumo[iPos].szDes_Concepto,
                fnCnvDouble(stFaDetCons.stDetConsumo[iPos].dTotalFacturableNet,1),
                stFaDetCons.stDetConsumo[iPos].lSeg_Consumo,      /* szResultado */
                stFaDetCons.stDetConsumo[iPos].iNum_Unidades,
                stFaDetCons.stDetConsumo[iPos].lCntLlamReal,
                stFaDetCons.stDetConsumo[iPos].lCntLlamDcto,
                stFaDetCons.stDetConsumo[iPos].lCntLlamFAct,
                fnCnvDouble(stFaDetCons.stDetConsumo[iPos].dTotalFacturableReal,1),
                fnCnvDouble(stFaDetCons.stDetConsumo[iPos].dTotalFacturableDcto,1),
                lDuracionReal,                          
                lDuracionDcto,                          
                fnCnvDouble(stFaDetCons.stDetConsumo[iPos].dImpValUnitario,1),
                stFaDetCons.stDetConsumo[iPos].szGlsDescrip,
                fnCnvDouble(dGravPrimeraCategoria,1),
                fnCnvDouble(dGravSegundaCategoria,1),
                fnCnvDouble(dPorcPrimeraCategoria,1),
                fnCnvDouble(dPorcSegundaCategoria,1),
                fnCnvDouble(dTotalNetoImpto,1));

            buffer_local[strlen(buffer_local)] = 0;
            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                return(FALSE);
            memset(buffer_local,0,sizeof(buffer_local));

            vDTrazasLog(szModulo,   "(Put_A2500) stFaDetCons.stDetConsumo[%d].lNumVenta     : [%ld]"
                                  "\n(Put_A2500) stFaDetCons.stDetConsumo[%d].szDes_Concepto: [%s]"
                                  "\n(Put_A2500) stFaDetCons.stDetConsumo[%d].iCodConcepto  : [%d]"
                                  , LOG05,i,stFaDetCons.stDetConsumo[iPos].lNumVenta
                                  ,i,stFaDetCons.stDetConsumo[iPos].szDes_Concepto
                                  ,i,stFaDetCons.stDetConsumo[iPos].iCodConcepto);
            if(iFlagMascaraA2600 == 1)
            {
                /* Desplegar registros A2600 */
                if(!Put_A2600(Fd_ArchImp
                                , FactDocuClie
                                , stFaDetCons.stDetConsumo[iPos].lNumVenta
                                , stFaDetCons.stDetConsumo[iPos].iCodConcepto
                                , stFaDetCons.stDetConsumo[iPos].lNumAbonado
                                , stFaDetCons.stDetConsumo[iPos].szDes_Concepto
                                , stFaDetCons.stDetConsumo[iPos].iColumna
                                , zsBufferImpresionArchivo))
                
                    vDTrazasLog(szModulo, "Fallo Put_A2600", LOG05);
            }

            if(iFlagMascaraA2700 == 1)
            {
                /* Desplegar registros A2700 */

                if(!Put_A2700(Fd_ArchImp, stFaDetCons.stDetConsumo[iPos].iCodConcepto,stFaDetCons.stDetConsumo[iPos].iColumna,zsBufferImpresionArchivo))
                    vDTrazasLog(szModulo, "Fallo Put_A2700", LOG05);

            }



        } /* if(stFaDetCons.stDetConsumo[iPos].iCodTipConce == 3 || stFaDetCons.stDetConsumo[iPos].iCodTipConce == 4) */


    } /* for (i=0; i < stFaDetCons.iNumReg; i++ ) */

    return TRUE;
}

/*
 * Funcion      :       Put_A2600
 * Descripcion  :       Impresion de las series de venta asociadas al cliente actual y a la venta ingresada
 *                      por paramentro
 * Parametros   :   ->  Fd_ArchImp
 *                          Puntero al archivo de Impresion.
 *                  ->  FactDocuClie
 *                          Puntero a estructura contenedora de datos del documento de cliente actual.
 *                  ->  lNumVenta
 *                          Numero de venta a buscar.
 *                  ->  zsBufferImpresionArchivo
 *                          Buffer contenedor de datos a imprimir a archivo.
 * Retorna          TRUE    Si la ejecucion ha sido totalmente exitosa.
 *                  FALSE   Si ha ocurrido algun problema interno en la funcion.
 */
int Put_A2600(FILE *Fd_ArchImp
            , ST_FACTCLIE *FactDocuClie
            , long lNumVenta
            , int  iCodConcepto
            , long lNumAbonado
            , char *pszDesConcepto
            , long lColumna
            , char *zsBufferImpresionArchivo)
{

    int     iControlFunciones = 0;
    char    buffer_local[MAX_BYTE_A2600];
    reg_entrada stEntrada;
    stSalida *pstAux = NULL;
    stSalida *pstAux2 = NULL;

    strcpy (szModulo, "Put_A2600");
    vDTrazasLog(szModulo, "(INFO) ******** Entrando  a la funcion [%s] **********"
                          "\n Codigo Cliente  : [%ld]"
                          "\n Num. Venta      : [%ld]"
                          "\n Cod. Tip Docum. : [%d]"
                          ,LOG05
                          ,szModulo
                          ,FactDocuClie->lCodCliente
                          ,lNumVenta
                          ,FactDocuClie->iCodTipDocum);

    /* Evaluar si el documento es factura miscelanea */
    vDTrazasLog(szModulo, "\t(INFO): stDatosGener.iCodMiscela: [%d] ", LOG05, stDatosGener.iCodMiscela);
    if(FactDocuClie->iCodTipDocum == stDatosGener.iCodMiscela)
    {
        /* Cargar los datos necesarios para obtencion de datos para factura miscelanea */
        stEntrada.lNumProceso  = FactDocuClie->lNumProceso;
        stEntrada.iCodConcepto = iCodConcepto;
        stEntrada.iColumna     = lColumna;

        if(pszDesConcepto!=NULL)
            strcpy(stEntrada.szDesConcepto, pszDesConcepto);
        else
            strcpy(stEntrada.szDesConcepto, "");

        ifnObtenerSeriesFactMiscela(&stEntrada);
    }
    else
    {   /* Si el concepto es de venta */
        if(lNumVenta > 0)
        {

            /* Cargar la estructura de entrada de la funcion */
            stEntrada.lCodCliente  = FactDocuClie->lCodCliente;
            stEntrada.lNumVenta    = lNumVenta;

            lstSalida = NULL;
            /* Llamado a la funcion de llenado de la lista de series de venta */
            iControlFunciones = ifnLlenarSeriesDeVenta ( &stEntrada );

            vDTrazasLog(szModulo, "\t(INFO): iControlFunciones: [%d] ", LOG05, iControlFunciones);
            if(!iControlFunciones)
            {
                vDTrazasLog(szModulo, "\t(ERROR): En la funcion ifnLlenarSeriesDeVenta ", LOG05);
                return FALSE;
            }
        }
    }



    /* Imprimir la lista enlazada <lstSalida> */
    pstAux = lstSalida;

    if(lstSalida==NULL)
        vDTrazasLog(szModulo, "\t(Put_A2600) lstSalida es NULL... ", LOG05);

    while(lstSalida!=NULL)
    {
        vDTrazasLog(szModulo, "\tDentro de while A2600... "
                              "\n\t A2600==>lstSalida->iCodConcepto (%d) "
                              "\n\t A2600==>iCodConcepto (%d) "
                              "\n\t A2600 lstSalida->lNumAbonado (%ld) "
                              "\n\t A2600 lNumAbonado (%ld) "
                              , LOG05, lstSalida->iCodConcepto, iCodConcepto, lstSalida->lNumAbonado,lNumAbonado);
        /*se agrega num_abonado XO-*974*/
        if(lNumAbonado>0)
        {
            if ((iCodConcepto==(int)(lstSalida->iCodConcepto))&&(lstSalida->lNumAbonado==lNumAbonado))
            {
                sprintf(buffer_local,REG_2600
                                    ,lstSalida->iCodConcepto
                                    ,lstSalida->szDesConcepto
                                    ,lstSalida->szNumSerie
                                    ,lstSalida->lNumCelular);
                vDTrazasLog(szModulo, "\n\tDentro if A2600... "
                					  "\n\t A2600==>iCodConcepto (%d) "
                					  "\n\t A2600 lstSalida->iCodConcepto (%d) "
                					  "\n\t A2600 lstSalida->szNumSerie (%s) "
                					  "\n\t A2600 lstSalida->lNumAbonado (%ld) "
                					  "\n\t A2600 lNumAbonado (%ld) "
                					  , LOG05, iCodConcepto, lstSalida->iCodConcepto, lstSalida->szNumSerie, lstSalida->lNumAbonado,lNumAbonado);
                if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                    return FALSE;
            }
        }
        else /**Si no viene abonado >0 dejo consulta anterior, solo por concepto XO-*974*/
        {
            if((iCodConcepto==(int)(lstSalida->iCodConcepto)))
            {
                sprintf(buffer_local,REG_2600
                                    ,lstSalida->iCodConcepto
                                    ,lstSalida->szDesConcepto
                                    ,lstSalida->szNumSerie
                                    ,lstSalida->lNumCelular);

                vDTrazasLog(szModulo, "\n\tDentro if else A2600... "
                                      "\n\t A2600==>iCodConcepto (%d) "
                                      "\n\t A2600 lstSalida->iCodConcepto (%d) "
                                      "\n\t A2600 lstSalida->szNumSerie (%s) "
                                      "\n\t A2600 lstSalida->lNumAbonado (%ld) "
                                      "\n\t A2600 lNumAbonado (%ld) "
                                      , LOG05, iCodConcepto, lstSalida->iCodConcepto, lstSalida->szNumSerie, lstSalida->lNumAbonado,lNumAbonado);
                if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
                    return FALSE;
            }
        }
        /* Vamos al proximo nodo */
        lstSalida = lstSalida->sgte;
    }

    /* Liberar la memoria obtenida */
    while(pstAux!=NULL)
    {
        pstAux2= pstAux;
        pstAux = pstAux->sgte;
        free(pstAux2);
    }

    return TRUE;
}


/*
 * Funcion      :       Put_A2700
 * Descripcion  :       Impresion de los conceptos de descuento asociados al concepto de cargo ingresado
 *                      por paramentro.
 * Parametros   :   ->  Fd_ArchImp
 *                          Puntero al archivo de Impresion.
 *                  ->  FactDocuClie
 *                          Puntero a estructura contenedora de datos del documento de cliente actual.
 *                  ->  iCodConcepto
 *                          Codigo de concepto de cargo.
 *                  ->  iColumna
 *                          Columna del concepto de cargo.
 *                  ->  zsBufferImpresionArchivo
 *                          Buffer contenedor de datos a imprimir a archivo.
 * Retorna          TRUE    Si la ejecucion ha sido totalmente exitosa.
 *                  FALSE   Si ha ocurrido algun problema interno en la funcion.
 */
int Put_A2700(FILE *Fd_ArchImp
            , int iCodConcepto
            , int iColumna
            , char *zsBufferImpresionArchivo)
{

    char    buffer_local[MAX_BYTE_A2700];
    int     i=0;
    double  dTotalNetoImpto       = 0.0;
    double  dGravPrimeraCategoria = 0.0;
    double  dGravSegundaCategoria = 0.0;
    double  dPorcPrimeraCategoria = 0.0;
    double  dPorcSegundaCategoria = 0.0;


    strcpy (szModulo, "Put_A2700");
    vDTrazasLog(szModulo, "(INFO) ******** Entrando  a la funcion [%s] **********", LOG05, szModulo);

    /* Recorrer la estructura de consumo en busqueda de conceptos de dcto. relacionados */
    for(i=0;i < stFaDetCons.iNumReg;i++)
    {
        vDTrazasLog(szModulo, "\tDentro de for:... ", LOG06);
        if( stFaDetCons.stDetConsumo[i].iCodConcerel == iCodConcepto && stFaDetCons.stDetConsumo[i].iColumnaRel == iColumna
            && stFaDetCons.stDetConsumo[i].iCodTipConce == 2)
        {
            vDTrazasLog(szModulo, "\tDentro de if:... ", LOG06);
            /* Imprimir los conceptos de descuento */
            if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[i].iCodConcepto, stFaDetCons.stDetConsumo[i].iColumna,&dGravPrimeraCategoria, &dGravSegundaCategoria ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
                return(FALSE);
            }
            

            dGravPrimeraCategoria = stFaDetCons.stDetConsumo[i].dTotalPrimeraCateg;
            dGravSegundaCategoria = stFaDetCons.stDetConsumo[i].dTotalSegundaCateg;

            dPorcPrimeraCategoria=0.0;
            dPorcSegundaCategoria=0.0;
            if (!bfnPorcenImptosCateg(&dPorcPrimeraCategoria, &dPorcSegundaCategoria ))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
                return(FALSE);
            }

            dTotalNetoImpto = stFaDetCons.stDetConsumo[i].dTotalFacturableNet + dGravPrimeraCategoria + dGravSegundaCategoria;

            /* Imprimir el concepto */
            sprintf(buffer_local,REG_2700,
                stFaDetCons.stDetConsumo[i].iCodConcepto,
                stFaDetCons.stDetConsumo[i].szDes_Concepto,
                fnCnvDouble(stFaDetCons.stDetConsumo[i].dTotalFacturableNet,1),
                stFaDetCons.stDetConsumo[i].lSeg_Consumo,      
                stFaDetCons.stDetConsumo[i].iNum_Unidades,
                stFaDetCons.stDetConsumo[i].lCntLlamReal,
                stFaDetCons.stDetConsumo[i].lCntLlamDcto,
                stFaDetCons.stDetConsumo[i].lCntLlamFAct,
                fnCnvDouble(stFaDetCons.stDetConsumo[i].dTotalFacturableReal,1),
                fnCnvDouble(stFaDetCons.stDetConsumo[i].dTotalFacturableDcto,1),
                stFaDetCons.stDetConsumo[i].lSeg_ConsumoReal, 
                stFaDetCons.stDetConsumo[i].lSeg_ConsumoDcto, 
                fnCnvDouble(stFaDetCons.stDetConsumo[i].dImpValUnitario,1),
                stFaDetCons.stDetConsumo[i].szGlsDescrip,
                fnCnvDouble(dGravPrimeraCategoria,1),
                fnCnvDouble(dGravSegundaCategoria,1),
                fnCnvDouble(dPorcPrimeraCategoria,1),
                fnCnvDouble(dPorcSegundaCategoria,1),
                fnCnvDouble(dTotalNetoImpto,1));

            buffer_local[strlen(buffer_local)] = 0;
            if (!bEscribeEnArchivo(Fd_ArchImp, zsBufferImpresionArchivo, buffer_local))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bEscribeEnArchivo ", LOG05);
                return(FALSE);
            }
            memset(buffer_local,0,sizeof(buffer_local));
        }
        else
        {
            vDTrazasLog(szModulo, "\tCondicion de ingreso a if no se cumple. ", LOG06);
        }
    }

    return TRUE;
}

int PutCaratula(ST_FACTCLIE         *FactDocuClie,
                FILE                *Fd_ArchImp,
                ST_MENSAJES         *Mensajes,
                ST_MENSAJES_NOCICLO *Mensajes_NoCiclo,
                STSALDO_ANTERIOR    *SaldoTot,
                ST_CUOTAS           *pstFaCuotas,
                ST_CICLOFACT        *sthFa_CicloFact,
                DETALLEOPER         *pst_MascaraOper,
                char                *zsBufferImpresionArchivo,
                ST_BALANCE          *stBalance,
                TIPOSIMPUESTOS      *stTiposImpuestos,
                long                lCodigoCicloFacturacion)
{

    ST_TABLA_ACUM   sthTablaAcum;
    int             iMascara  ;
    int             iPosicionRegistro;
    register int i;

    strcpy (szModulo, "PutCaratula");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    memset(stBalance, 0, sizeof (ST_BALANCE));
    memset(&sthTablaAcum, 0, sizeof (ST_TABLA_ACUM));

    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1000",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;


    if (iMascara == 1)
    {
        if (!Put_A1000(Fd_ArchImp, FactDocuClie, sthFa_CicloFact, zsBufferImpresionArchivo, lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,30,"No Pudo Imprimir Registro A1000");
            vDTrazasLog(szModulo, "Fallo Put_A1000", LOG05);
            return(FALSE);
        }
    }


    /*  P-COL-05011 PROCESO IMPRESIÓN - NUEVO GAP ADAPTACIONES A SCL TM
     *  Fecha: 2005/08/09.
     *  Impresion de documentos del periodo para el cliente.
     */
    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1120",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;
    if (iMascara == 1 && sthFa_CicloFact->cod_ciclo > 0)
    {
        if (!Put_A1120(Fd_ArchImp, FactDocuClie, sthFa_CicloFact, zsBufferImpresionArchivo, lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,31,"No Pudo Imprimir Registro A1120");
            vDTrazasLog(szModulo, "Fallo Put_A1120", LOG05);
            return(FALSE);
        }
    }


    /*  PROCESO IMPRESIÓN - NUEVO GAP ADAPTACIONES A SCL TM
     *  Identificacion de documento de origen del cliente.
     */
    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1130",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;     
    
    if (iMascara == 1)
    {
        if (!Put_A1130(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,32,"No Pudo Imprimir Registro A1130");
            vDTrazasLog(szModulo, "Fallo Put_A1130", LOG05);
            return(FALSE);
        }
    }

    /*  SCL - FACTURACIÓN - GAP IMPRESIÓN (2 Ó 1)
     *  Se agrega registro de impresion  A1150 para imprimir los datos de ultimo pago.
     */
    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1150",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;
    if (iMascara == 1)
    {
        if (!Put_A1150(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo,lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,33,"No Pudo Imprimir Registro A1150");
            vDTrazasLog(szModulo, "Fallo Put_A1150", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1010",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A1010(Fd_ArchImp,FactDocuClie, zsBufferImpresionArchivo, lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,34,"No Pudo Imprimir Registro A1010");
            vDTrazasLog(szModulo, "Fallo Put_A1010", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1100",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A1100(Fd_ArchImp, FactDocuClie, SaldoTot, pstFaCuotas, zsBufferImpresionArchivo, stBalance))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,35,"No Pudo Imprimir Registro A1100");
            vDTrazasLog(szModulo, "Fallo Put_A1100", LOG05);
            return(FALSE);
        }
    }



    vDTrazasLog("", "stBalance->dMonto[iBALANCE_ANTERIOR] en PutCaratula [%f] ", LOG05, stBalance->dMonto[iBALANCE_ANTERIOR]);


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1200",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if(!Put_A1200(Fd_ArchImp, FactDocuClie, SaldoTot, pstFaCuotas, zsBufferImpresionArchivo, stBalance,stTiposImpuestos,lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,36,"No Pudo Imprimir Registro A1200");
            vDTrazasLog(szModulo, "Fallo Put_A1200", LOG05);
            return(FALSE);
        }
    }

    /*
     *  Se agrega registro de impresion  A1250 para imprimir los cuotas vencidas del cliente.
     */
    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1250",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;
    if (iMascara == 1)
    {
        if(!Put_A1250(Fd_ArchImp, pstFaCuotas, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,37,"No Pudo Imprimir Registro A1250");
            vDTrazasLog(szModulo, "Fallo Put_A1250", LOG05);
            return(FALSE);
        }
    }

    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1300",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if(!Put_A1300(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo, lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,38,"No Pudo Imprimir Registro A1300");
            vDTrazasLog(szModulo, "Fallo Put_A1300", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1400",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if(!Put_A1400(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,39,"No Pudo Imprimir Registro A1400");
            vDTrazasLog(szModulo, "Fallo Put_A1400", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1410",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if(!Put_A1410(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,40,"No Pudo Imprimir Registro A1410");
            vDTrazasLog(szModulo, "Fallo Put_A1410", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1420",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if(!Put_A1420(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,41,"No Pudo Imprimir Registro A1420");
            vDTrazasLog(szModulo, "Fallo Put_A1420", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1430",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if(!Put_A1430(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,42,"No Pudo Imprimir Registro A1430");
            vDTrazasLog(szModulo, "Fallo Put_A1430", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1500",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A1500(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo, lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,43,"No Pudo Imprimir Registro A1500");
            vDTrazasLog(szModulo, "Fallo Put_A1500", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1700",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A1700(Fd_ArchImp, FactDocuClie->lCodCliente, sthFa_CicloFact, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,44,"No Pudo Imprimir Registro A1700");
            vDTrazasLog(szModulo, "Fallo Put_A1700", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1710",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A1710(Fd_ArchImp, FactDocuClie, zsBufferImpresionArchivo, lCodigoCicloFacturacion))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,45,"No Pudo Imprimir Registro A1710");
            vDTrazasLog(szModulo, "Fallo Put_A1710", LOG05);
            return(FALSE);
        }
    }



    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A2000",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A2000(Fd_ArchImp, Mensajes, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,46,"No Pudo Imprimir Registro A2000");
            vDTrazasLog(szModulo, "Fallo Put_A2000", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1800",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A1800(Fd_ArchImp, &sthTablaAcum, SaldoTot, pstFaCuotas, zsBufferImpresionArchivo, FactDocuClie->dImpConversion)) /* P-TMM-03075 */
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,47,"No Pudo Imprimir Registro A1800");
            vDTrazasLog(szModulo, "Fallo Put_A1800", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A1900",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        memset(&sthTablaAcum, 0, sizeof (ST_TABLA_ACUM));
        if (!Put_A1900(Fd_ArchImp, &sthTablaAcum, SaldoTot, pstFaCuotas, zsBufferImpresionArchivo, pst_MascaraOper, FactDocuClie->dImpConversion, FactDocuClie->iCodTipDocum, sthFa_CicloFact->cod_ciclo)) /* P-TMM-03075 */
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,48,"No Pudo Imprimir Registro A1900");
            vDTrazasLog(szModulo, "Fallo Put_A1900", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A2100",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A2100(Fd_ArchImp, sthTablaAcum, zsBufferImpresionArchivo, FactDocuClie->dImpConversion)) /* P-TMM-03075 */
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,49,"No Pudo Imprimir Registro A2100");
            vDTrazasLog(szModulo, "Fallo Put_A2100", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A2200",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A2200(Fd_ArchImp, SaldoTot, pstFaCuotas, zsBufferImpresionArchivo, FactDocuClie->dImpConversion)) /* P-TMM-03075 */
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,50,"No Pudo Imprimir Registro A2200");
            vDTrazasLog(szModulo, "Fallo Put_A2200", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A2300",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A2300(Fd_ArchImp, Mensajes_NoCiclo, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,51,"No Pudo Imprimir Registro A2300");
            vDTrazasLog(szModulo, "Fallo Put_A2300", LOG05);
            return(FALSE);
        }
    }


    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A2400",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

    if (iMascara == 1)
    {
        if (!Put_A2400(Fd_ArchImp, FactDocuClie, SaldoTot, pstFaCuotas, zsBufferImpresionArchivo, stBalance))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,52,"No Pudo Imprimir Registro A2400");
            vDTrazasLog(szModulo, "Fallo Put_A2400", LOG05);
            return(FALSE);
        }
    }

     /* Impresion de series de ventas : A2500. */

    iPosicionRegistro=BuscaMascara(pst_MascaraOper,"A2500",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;
    if (iMascara == 1)
    {
        int iMascaraA2600 = 0;
        int iMascaraA2700 = 0;

        /* Obtencion de la mascara para A2600 */
        iPosicionRegistro = BuscaMascara(pst_MascaraOper,"A2600",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
        iMascaraA2600    = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;

        /* Obtencion de la mascara para A2700 */
        iPosicionRegistro = BuscaMascara(pst_MascaraOper,"A2700",pst_MascaraOper->iCantRegistros, FactDocuClie->iCodTipDocum);
        iMascaraA2700    = (iPosicionRegistro>=0)? pst_MascaraOper->iIndImp[iPosicionRegistro]:0;


        if (!Put_A2500(Fd_ArchImp, FactDocuClie, iMascaraA2600, iMascaraA2700, zsBufferImpresionArchivo))
        {
            fnGrabaAnoProceso (FactDocuClie->lCodCliente, lCodigoCicloFacturacion,53,"No Pudo Imprimir Registro A2500");
            vDTrazasLog(szModulo, "Fallo Put_A2500", LOG05);
            return(FALSE);
        }
    }


    return(TRUE);

}

/***************************************************************************/
/* Procedimiento encargado de obtener los mensajes para cada cliente       */
/* facturado.                                                              */
/***************************************************************************/
int iGetMensajesCliente (long lCodCliente, char *szCodIdioma, ST_MENSAJES * psthFaMensajes, int *iNumLineasMensaje, int ihCodFormDetalle, char * szhIndFacturado)
{
    int iNumMensajesFetch=0;

    strcpy (szModulo, "iGetMensajesCliente");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    memset(psthFaMensajes,0,sizeof(ST_MENSAJES));

    lhCodigoClienteCur = lCodCliente        ;
    ihCodFormDetCur    = ihCodFormDetalle   ;
    strcpy(szhCodIdiomaCur, szCodIdioma    );
    strcpy(szhIndFacturCur, szhIndFacturado);


    /* EXEC SQL OPEN Cursor_Mensajes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )439;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodigoClienteCur;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodFormDetCur;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodIdiomaCur;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhIndFacturCur;
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


    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog(szModulo, "Error en OPEN Cur_GetMensajes. Error [%i][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return (FALSE);
        /*return(sqlca.sqlcode); */
    }

    while(1)
    {
        /* EXEC SQL FETCH Cursor_Mensajes
            INTO :psthFaMensajes; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )50;
        sqlstm.offset = (unsigned int  )470;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)psthFaMensajes->iCorrMensaje;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(int);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)psthFaMensajes->iNumLinea;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(int);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)psthFaMensajes->iCantCaract;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(int);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)psthFaMensajes->zsCodIdioma;
        sqlstm.sqhstl[3] = (unsigned long )6;
        sqlstm.sqhsts[3] = (         int  )6;
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



        if(sqlca.sqlcode < SQLOK)
        {
            vDTrazasLog(szModulo, "Error en FETCH Cur_GetMensajes. Error [%i][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return (FALSE);
        }

        if((sqlca.sqlcode == SQLNOTFOUND) && (iNumMensajesFetch == sqlca.sqlerrd[2]))
        {
            break;
        }

        iNumMensajesFetch = sqlca.sqlerrd[2];

        if (sqlca.sqlcode == SQLNOTFOUND) break;
    }
    *iNumLineasMensaje = sqlca.sqlerrd[2];


    /* EXEC SQL CLOSE Cursor_Mensajes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )501;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog(szModulo, "Error en CLOSE Cur_GetMensajes. Error [%i][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return (FALSE);
    }


    return(TRUE);
}/********************************* Final iGetMensajesCliente ************************************/

int iUpdateFactDocu (long lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas, ST_BALANCE *stBalance, ST_ACUMMTO *AcumMto )
{
    /*AFGS RA-200603160928 -  Incializa variables*/
    char  *pszAux;
    double  dTotalCuotas = 0;
    double  dTotalAPagar = 0;
    register int i = 0;
    double dTotCuotPVen = 0.0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        /* VARCHAR szSqlStmt[1524]; */ 
struct { unsigned short len; unsigned char arr[1524]; } szSqlStmt;

        char    szhNumFolioCtc[13];
        int     ihInd_Impresa = 1;
        double  dhTotalCuotas = 0;      
        double  dhTotalAPagar = 0;      
        double  dhTotalSaldo = 0;       
        char    *szhRowid;              
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhNumFolioCtc,0x00,sizeof(szhNumFolioCtc));

    strcpy (szModulo, "iUpdateFactDocu");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);
    ihInd_Impresa = 1;

    pszAux = (char *)szSqlStmt.arr;
    sprintf(szhNumFolioCtc,"%12.12s\0",FactDocuClie->szNumCtcPago);

    for(i = 0; i < pstFaCuotas -> iNum_RegCuotas_pven; i++)
    {
        if(pstFaCuotas->stReg_pven[i].iInd_Facturado == 2)
            dTotCuotPVen += pstFaCuotas->stReg_pven[i].dMtoCuota;
    }

    dhTotalCuotas = pstFaCuotas->dTotalCuotas_venci + dTotCuotPVen;

    dTotalCuotas = dhTotalCuotas;

    dTotalAPagar =  FactDocuClie->dTotCargosMes +
                    stBalance->dMonto[iAJUSTE_CREDITO] +
                    stBalance->dMonto[iBALANCE_ANTERIOR] +
                    stBalance->dMonto[iPAGOS_RECIBIDOS] +
                    stBalance->dMonto[iPAGOS_REVERTIDOS] +
                    stBalance->dMonto[iMISCELANEA];

    vDTrazasLog(szModulo,   "INFO: DATOS CARGADOS EN dTotalAPagar:\n"
                            "\t\tFactDocuClie->dTotCargosMes          :[%.4f]\n"
                            "\t\tstBalance->dMonto[iAJUSTE_CREDITO]   :[%.4f]\n"
                            "\t\tstBalance->dMonto[iBALANCE_ANTERIOR] :[%.4f]\n"
                            "\t\tstBalance->dMonto[iPAGOS_RECIBIDOS]  :[%.4f]\n"
                            "\t\tstBalance->dMonto[iPAGOS_REVERTIDOS] :[%.4f]\n"
                            "\t\tstBalance->dMonto[iMISCELANEA]       :[%.4f]\n"
                            "\t\tSaldoTot->dTotalSaldo                :[%.4f]\n"
                            "\t\tdTotalCuotas                         :[%.4f]\n"
                            ,LOG05
                            ,FactDocuClie->dTotCargosMes
                            ,stBalance->dMonto[iAJUSTE_CREDITO]
                            ,stBalance->dMonto[iBALANCE_ANTERIOR]
                            ,stBalance->dMonto[iPAGOS_RECIBIDOS]
                            ,stBalance->dMonto[iPAGOS_REVERTIDOS]
                            ,stBalance->dMonto[iMISCELANEA]
                            ,SaldoTot->dTotalSaldo
                            ,dTotalCuotas);


    if (lCodCiclFact)
    {
        sprintf(pszAux, "UPDATE FA_FACTDOCU_%ld ", lCodCiclFact);
    }
    else
    {
        strcpy(pszAux, "UPDATE FA_FACTDOCU_NOCICLO ");
    }

    dhTotalAPagar = dTotalAPagar;      
    dhTotalSaldo  = SaldoTot->dTotalSaldo; 
    szhRowid      = FactDocuClie->szRowid; 

    vDTrazasLog(szModulo,   "INFO PREVIO A UPDATE FA_FACTDOCU...:\n"
                            "\t\tCliente         [%ld]\n"
                            "\t\tdhTotalCuotas   [%f]\n"
                            "\t\tdhTotalAPagar   [%f]\n"
                            "\t\tdhTotalSaldo    [%f]\n"
                            "\t\tszhRowid        [%s]", LOG05,
                            FactDocuClie->lCodCliente,
                            dhTotalCuotas    ,
                            dhTotalAPagar    ,
                            dhTotalSaldo ,
                            szhRowid);


    if ((FactDocuClie->dTotFactura == 0)  && (pstFaCuotas->dTotalCuotas > 0 || SaldoTot->iNum_RegSaldo > 0))
    {
        strcat(pszAux, " SET TOT_CUOTAS = :dhTotalCuotas, TOT_PAGAR = :dhTotalAPagar, IMP_SALDOANT = :dhTotalSaldo, COD_BARRAS = :szhNumFolioCtc, IND_IMPRESA = :ihInd_Impresa WHERE ROWID = :szhRowid "); /* P-TMM-03075 Por Homologación TM-200410271029*/
    }
    else
    {
        strcat(pszAux, " SET TOT_CUOTAS = :dhTotalCuotas, TOT_PAGAR = :dhTotalAPagar, IMP_SALDOANT = :dhTotalSaldo, IND_IMPRESA = :ihInd_Impresa WHERE ROWID = :szhRowid "); /* P-TMM-03075 Por Homologación TM-200410271029*/
    }

    szSqlStmt.len = (short)strlen((char *)szSqlStmt.arr);

    vDTrazasLog(szModulo, "\t\tQRY:UpdateFactDocu \n[%s]", LOG04, pszAux );

    /* EXEC SQL PREPARE QueryFactDocu FROM :szSqlStmt; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )516;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&szSqlStmt;
    sqlstm.sqhstl[0] = (unsigned long )1526;
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


    if (sqlca.sqlcode != SQLOK)
    {

        vDTrazasLog(szModulo,   "FactDocuClie->dTotCargosMes    [%f] \n"
                                "SaldoTot->dTotalSaldo          [%f] \n"
                                "dTotalCuotas                   [%f] \n"
                                "dTotalAPagar                   [%f] \n", LOG01,
                                FactDocuClie->dTotCargosMes,
                                SaldoTot->dTotalSaldo,
                                dTotalCuotas,
                                dTotalAPagar);


        vDTrazasLog(szModulo, "Error en PREPARE QueryFactDocu. Error [%d][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return(FALSE);
    }

    if ((FactDocuClie->dTotFactura == 0)  && (pstFaCuotas->dTotalCuotas > 0 || SaldoTot->iNum_RegSaldo > 0))
    {
        sprintf(szhNumFolioCtc,"%s\0",FactDocuClie->szNumCtcPago);
        /* EXEC SQL EXECUTE QueryFactDocu USING :dhTotalCuotas, 
                                             :dhTotalAPagar, 
                                             :dhTotalSaldo,  
                                             :szhNumFolioCtc,
                                             :ihInd_Impresa, 
                                             :szhRowid; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )535;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhTotalCuotas;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhTotalAPagar;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&dhTotalSaldo;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhNumFolioCtc;
        sqlstm.sqhstl[3] = (unsigned long )13;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihInd_Impresa;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[5] = (unsigned long )0;
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
        /* EXEC SQL EXECUTE QueryFactDocu USING :dhTotalCuotas, 
                                             :dhTotalAPagar, 
                                             :dhTotalSaldo,  
                                             :ihInd_Impresa,
                                             :szhRowid; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )574;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhTotalCuotas;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhTotalAPagar;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&dhTotalSaldo;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihInd_Impresa;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhRowid;
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

    if (sqlca.sqlcode != SQLOK)
    {

        vDTrazasLog(szModulo,   "Cliente            [%ld]\n"
                                "SaldoTot->dTotalSaldo ld   [%f]\n"
                                "SaldoTot->dTotalSaldo f    [%f]\n"
                                "QRY:UpdateFactDocu \n      [%s]\n"
                                "szhRowid   [%s]\n", LOG05,
                                FactDocuClie->lCodCliente,
                                SaldoTot->dTotalSaldo    ,
                                SaldoTot->dTotalSaldo    ,
                                pszAux ,
                                szhRowid);


        vDTrazasLog(szModulo, "Error en EXECUTE Cursor QueryFactDocu. Error [%i][%s]"
                            , LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return(FALSE);
    }


    if (!bfnAcumulaMontos(AcumMto, FactDocuClie->dTotFactura, dTotalCuotas, dTotalAPagar, SaldoTot->dTotalSaldo))
    {
        vDTrazasLog(szModulo, "Error en ejecucion de bfnAcumulaMontos", LOG01);
        return (FALSE);
    }


    return(TRUE);
}/*********************************** Final iUpdateFactDocu  ***********************************/

int iUpdateFactDocu_MC (long lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas, ST_BALANCE *stBalance ,char * szArchivoFinal,int sema,int indicador)
{

    char    szUpdate[1024];
    int     iDigVeriF_Total_Pagar;
    double  dTotalAPagar= 0.0;
    double  dTotalCuotas= 0.0;
    double  dTotCuotPVen= 0.0;
    double  dTotalSaldo = 0.0;
    char    total_pagar[17];
    char    total_cuotas[17];
    char    total_saldo[17];
    char    archivo[255];
    int     i=0;

    strcpy(szModulo, "iUpdateFactDocu_MC");

    vDTrazasLog(szModulo, "Entro a %s",LOG05,szModulo);

    for(i = 0; i < pstFaCuotas -> iNum_RegCuotas_pven; i++)
    {
        if(pstFaCuotas->stReg_pven[i].iInd_Facturado == 2)
            dTotCuotPVen += pstFaCuotas->stReg_pven[i].dMtoCuota;
    }

    dTotalCuotas = pstFaCuotas->dTotalCuotas_venci + dTotCuotPVen;

    dTotalAPagar =  FactDocuClie->dTotCargosMes +
                    stBalance->dMonto[iAJUSTE_CREDITO] +
                    stBalance->dMonto[iBALANCE_ANTERIOR] +
                    stBalance->dMonto[iPAGOS_RECIBIDOS] +
                    stBalance->dMonto[iPAGOS_REVERTIDOS] +
                    stBalance->dMonto[iMISCELANEA];

    dTotalSaldo  = SaldoTot->dTotalSaldo;

    if(CalculaDigVerif(dTotalAPagar,&iDigVeriF_Total_Pagar) !=  TRUE )
    {
        iDigVeriF_Total_Pagar = 999;
    }

    memset(archivo,'\0',sizeof(archivo));
    strncpy(archivo,szArchivoFinal,strlen(szArchivoFinal));

    memset(total_pagar,'\0',sizeof(total_pagar));
    memset(total_cuotas,'\0',sizeof(total_cuotas));
    memset(total_saldo,'\0',sizeof(total_saldo));

    sprintf(total_pagar,"%f",dTotalAPagar);
    sprintf(total_cuotas,"%f",dTotalCuotas);
    sprintf(total_saldo,"%f",dTotalSaldo);

    memset(szUpdate,'\0',sizeof(szUpdate));

    sprintf(szUpdate,"update FA_FACTDOCU_%ld set TOT_CUOTAS = %s ,TOT_PAGAR = %s ,IMP_SALDOANT = %s , IND_IMPRESA=1 WHERE IND_ORDENTOTAL = %ld "
            ,lCodCiclFact,total_cuotas,total_pagar,total_saldo,FactDocuClie->lIndOrdenTotal);

    vDTrazasLog(szModulo,"UPDATE [%s]",LOG05,szUpdate);
    vDTrazasLog(szModulo,"archivo [%s]",LOG05,archivo);
    vDTrazasLog(szModulo,"CodTipDocum [%d]",LOG05,FactDocuClie->iCodTipDocum);
    vDTrazasLog(szModulo,"CodDespacho [%s]",LOG05,FactDocuClie->szCodDespacho);
    vDTrazasLog(szModulo,"IndOrdenTotal [%ld]",LOG05,FactDocuClie->lIndOrdenTotal);

    i = get_registro (sema);

    memset(memoria[0].concatenador[i].szupdate,'\0',sizeof(memoria[0].concatenador[i].szupdate));
    memset(memoria[0].concatenador[i].sznomarchivo,'\0',sizeof(memoria[0].concatenador[i].sznomarchivo));
    memset(memoria[0].concatenador[i].szCod_Despacho,'\0',sizeof(memoria[0].concatenador[i].szCod_Despacho));
    /* Se deja en memoria comando UPDATE de FA_FACTDOCU_%d para que sea ejecutado por el concatenador una */
    /* vez generado el archivo .dat */
    strncpy(memoria[0].concatenador[i].szupdate,szUpdate,strlen(szUpdate));
    strncpy(memoria[0].concatenador[i].sznomarchivo,archivo,strlen(archivo));
    strncpy(memoria[0].concatenador[i].szCod_Despacho,FactDocuClie->szCodDespacho,strlen(FactDocuClie->szCodDespacho));
    memoria[0].concatenador[i].itipdocum = FactDocuClie->iCodTipDocum;
    memoria[0].concatenador[i].marcador = 2 ;
    memoria[0].concatenador[i].bueno = indicador ;
    /**/

    return(TRUE);
}/*********************************** Final iUpdateFactDocu_MC  ***********************************/


int iUpdateFatBalance (int lCodCiclFact, ST_FACTCLIE *FactDocuClie, STSALDO_ANTERIOR *SaldoTot, ST_CUOTAS *pstFaCuotas,  ST_BALANCE *stBalance)
{
    double  dTotalCuotas;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            double  dhMontoNuevo;
            long    lhCod_Cliente;
            double  dhTotalAPagar;
            double  dhTotCargosMes;
            int     ihCodCiclFact;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "iUpdateFatBalance");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    dTotalCuotas = pstFaCuotas->dTotalCuotas_pven;

    dhTotCargosMes = FactDocuClie->dTotCargosMes;

    dhTotalAPagar = FactDocuClie->dTotCargosMes +
                    stBalance->dMonto[iAJUSTE_CREDITO] +
                    stBalance->dMonto[iBALANCE_ANTERIOR] +
                    stBalance->dMonto[iPAGOS_RECIBIDOS] +
                    stBalance->dMonto[iPAGOS_REVERTIDOS] +
                    stBalance->dMonto[iMISCELANEA] +
                    SaldoTot->dTotalSaldo +
                    dTotalCuotas;

    lhCod_Cliente= FactDocuClie->lCodCliente;

    dhMontoNuevo = FactDocuClie->dTotCargosMes + stBalance->dMonto[iAJUSTE_CREDITO];

    ihCodCiclFact = lCodCiclFact;

    /* EXEC SQL UPDATE FAT_BALANCE SET IMP_DOCUMENTO = :dhMontoNuevo
              WHERE COD_CLIENTE  = :lhCod_Cliente
                AND COD_CICLFACT = :ihCodCiclFact
                AND COD_ITEM     = 7; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=:b0 where ((COD_CLI\
ENTE=:b1 and COD_CICLFACT=:b2) and COD_ITEM=7)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )609;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhMontoNuevo;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclFact;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "Error en EXECUTE QueryFatBalance. Error [%d][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return(FALSE);
    }

    /* EXEC SQL UPDATE FAT_BALANCE SET IMP_DOCUMENTO = :dhTotalAPagar
        WHERE COD_CLIENTE   = :lhCod_Cliente
          AND COD_CICLFACT  = :ihCodCiclFact
          AND COD_ITEM      = 8; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=:b0 where ((COD_CLI\
ENTE=:b1 and COD_CICLFACT=:b2) and COD_ITEM=8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )636;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTotalAPagar;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclFact;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "Error en EXECUTE QueryFatBalance2. Error [%d][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return(FALSE);
    }


    /* EXEC SQL UPDATE FAT_BALANCE SET IMP_DOCUMENTO = :dhTotCargosMes
        WHERE COD_CLIENTE  = :lhCod_Cliente
          AND COD_CICLFACT = :ihCodCiclFact
          AND COD_ITEM     = 6; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=:b0 where ((COD_CLI\
ENTE=:b1 and COD_CICLFACT=:b2) and COD_ITEM=6)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )663;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTotCargosMes;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclFact;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        vDTrazasLog(szModulo, "Error en EXECUTE QueryFatBalance3. Error [%d][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return(FALSE);
    }

    return(TRUE);
}/*********************************** Final iUpdateFatBalance  ***********************************/

/***************************************************************************/
/* Procedimiento encargado de recuperar los mensajes para el archivo       */
/***************************************************************************/
int   UnloadMensajes ( char * szPath, char * szhIndFacturado, int  ihCodFormDetalle, LINEACOMANDO * ParEntrada) {

    int     iNum_Lineas=0, i=0;
    char    szArchMensajes[1000]=" ";
    char    szPathDir[1024];
    char    szCodIdioma[6];
    char    szNombreArchivo[220];
    FILE*   pfMens;


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhDesc_MensLin [1000][133]; /* EXEC SQL VAR szhDesc_MensLin IS STRING(133); */ 

        int     ihCorr_Mensaje  [1000]  ;
        int     ihNum_Linea     [1000]  ;
        int     ihCant_Caract   [1000]  ;
        char    ihCodIdioma     [1000][6];   /* EXEC SQL VAR ihCodIdioma IS STRING(6); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "UnloadMensajes");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);



    sprintf(szNombreArchivo,"DetMsg_%d_%s_%ld_%s_%s.dat"
                           ,ParEntrada->iCodTipDocum
                           ,ParEntrada->szCodDespacho
                           ,ParEntrada->lCodCiclFact
                           ,(strcmp(szgHostId,"-1")==0)?"_":szgHostId
                           ,ParEntrada->szFechaHoraSis);

    if(iMakeDir(szPath)!=0)
    {
        vDTrazasLog(szModulo, "Falla al crear el directorio [%s] ", LOG05, szPath);
        return(FALSE);
    }

    sprintf(szPathDir,"%s/",szPath);

    /*------------------------------------------------------------------------------*/
    /* Generacion del nombre del archivo de Detalle de Consumo y apertura del mismo.*/
    /*------------------------------------------------------------------------------*/
    sprintf(szArchMensajes, "%s%s\0", szPathDir, szNombreArchivo);

    vDTrazasLog(szModulo,"Archivo de Detalle de Mensajes   : [%s]\n", LOG05, szArchMensajes);

    if((pfMens = fopen(szArchMensajes, "w")) == (FILE *)NULL)
    {
        vDTrazasLog(szModulo, "\nArchivo [%s] no pudo ser abierto."
                            "\nRevise su existencia."
                            "\nError Numero: %d     %s"
                            "\nProceso finalizado con error."
                            , LOG05, szArchMensajes, errno, strerror(errno));
        return (FALSE);
    }

    strcpy(szhIndFacturadoCur, szhIndFacturado);
    ihCodFormDetalleCur = ihCodFormDetalle;

    /* EXEC SQL OPEN Cursor_FaMensajesCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )690;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihAValorUno;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodFormDetalleCur;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIndFacturadoCur;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihAValorCero;
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


    if(sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo,"Error en OPEN Cursor_FaMensajesCiclo. Error [%d][%s]\n", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    while(1)
    {
        /* EXEC SQL FETCH Cursor_FaMensajesCiclo
            INTO    :ihCorr_Mensaje,
                :ihNum_Linea,
                :ihCant_Caract,
                :szhDesc_MensLin,
                :ihCodIdioma; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )729;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)ihCorr_Mensaje;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(int);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)ihNum_Linea;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(int);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)ihCant_Caract;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(int);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhDesc_MensLin;
        sqlstm.sqhstl[3] = (unsigned long )133;
        sqlstm.sqhsts[3] = (         int  )133;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)ihCodIdioma;
        sqlstm.sqhstl[4] = (unsigned long )6;
        sqlstm.sqhsts[4] = (         int  )6;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
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



        if(sqlca.sqlcode < SQLOK)
        {
            vDTrazasLog (szModulo,"Error en FETCH Cursor_FaMensajesCiclo. Error [%d][%s]\n", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return(FALSE);
        }

        iNum_Lineas=sqlca.sqlerrd[2];
        if(sqlca.sqlcode == SQLNOTFOUND) break;

    }

    vDTrazasLog (szModulo,"Cantidad de lineas de mensaje recuperadas: [%d]\n",LOG05, iNum_Lineas);

    for (i=0;i<iNum_Lineas;i++)
    {
        strcpy(szCodIdioma, ihCodIdioma[i]);
        FillCodIdioma(szCodIdioma);
        fprintf(pfMens ,"%8.8d%2.2d%3.3d%5.5s %-.132s\n",ihCorr_Mensaje[i],ihNum_Linea[i],ihCant_Caract[i],szCodIdioma,szhDesc_MensLin[i]);
    }

    /* EXEC SQL CLOSE Cursor_FaMensajesCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )764;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo,"Error en CLOSE Cursor_FaMensajesCiclo. Error [%i][%s]\n", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    fflush(pfMens);
    fclose(pfMens);

    return(TRUE);
}/*********************************** Final UnloadMensajes ***********************************/

int GetDireccion(ST_FACTCLIE *FactCli)
{
    char dir_noformateada[1000];
    OPERADORA   stOper;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        /* VARCHAR szDireccion [6][301]; */ 
struct { unsigned short len; unsigned char arr[302]; } szDireccion[6];

    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "GetDireccion");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

    /* DIRECCION DE FACTURACION CLIENTE */
    /* EXEC SQL SELECT FA_OBTIENE_DIRCLIE_PG.FA_OBTIENE_DIRCLIE_FN(:FactCli->lCodCliente,20,3,3) INTO :szDireccion[iDIRECCION_FACTURACION] FROM DUAL ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_OBTIENE_DIRCLIE_PG.FA_OBTIENE_DIRCLIE_FN(:b0,20\
,3,3) into :b1  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )779;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(FactCli->lCodCliente);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&szDireccion[iDIRECCION_FACTURACION];
    sqlstm.sqhstl[1] = (unsigned long )303;
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



    sprintf(dir_noformateada,"%.*s\0",szDireccion[iDIRECCION_FACTURACION].len, szDireccion[iDIRECCION_FACTURACION].arr);

    if(!FormateaDireccion(dir_noformateada,FactCli->szDireccion[iDIRECCION_FACTURACION]))
    {
       vDTrazasLog(szModulo,"termino con ERROR DIRECCION_FACTURACION(%s) IND_ORDENTOTAL(%ld)\n",LOG02,dir_noformateada,FactCli->lIndOrdenTotal);
    }

    /* DIRECCION DE OPERADORA */
    vDTrazasLog(szModulo,"Operadora",LOG05);

    if (!bfnFindOperadora (FactCli->szCodOperadora, &stOper ))
        return FALSE;

    sprintf(dir_noformateada,"%s\0",stOper.szDireccion);

    if(!FormateaDireccion(dir_noformateada,FactCli->szDireccion[iDIRECCION_OPERADORA]))
    {
       vDTrazasLog(szModulo,"termino con ERROR DIRECCION_OPERADORA(%s) IND_ORDENTOTAL(%ld)\n",LOG02,dir_noformateada,FactCli->lIndOrdenTotal);
    }

    /* DIRECCION DE PLAZA */
    vDTrazasLog(szModulo,"Plaza",LOG05);

    /* EXEC SQL SELECT FA_OBTIENE_DIRCLIE_PG.FA_OBTIENE_DIRCLIE_FN(:FactCli->iCodOperPlaza,21,0,3) INTO :szDireccion[iDIRECCION_PLAZA] FROM DUAL ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_OBTIENE_DIRCLIE_PG.FA_OBTIENE_DIRCLIE_FN(:b0,21\
,0,3) into :b1  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )802;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(FactCli->iCodOperPlaza);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&szDireccion[iDIRECCION_PLAZA];
    sqlstm.sqhstl[1] = (unsigned long )303;
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



    sprintf(dir_noformateada,"%.*s\0",szDireccion[iDIRECCION_PLAZA].len, szDireccion[iDIRECCION_PLAZA].arr);

    if(!FormateaDireccion(dir_noformateada,FactCli->szDireccion[iDIRECCION_PLAZA]))
    {
       vDTrazasLog(szModulo,"termino con ERROR DIRECCION_PLAZA(%s) IND_ORDENTOTAL(%ld)\n",LOG02,dir_noformateada,FactCli->lIndOrdenTotal);
    }

    /* DIRECCION CORRESPONDENCIA CLIENTE */
    vDTrazasLog(szModulo,"Cliente",LOG05);

    /* EXEC SQL SELECT GE_FN_OBTIENE_DIRCLIE(:FactCli->lCodCliente,1,3,3) INTO :szDireccion[iDIRECCION_CORRESPONDENCIA] FROM DUAL ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select GE_FN_OBTIENE_DIRCLIE(:b0,1,3,3) into :b1  from DU\
AL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )825;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(FactCli->lCodCliente);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&szDireccion[iDIRECCION_CORRESPONDENCIA];
    sqlstm.sqhstl[1] = (unsigned long )303;
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



    sprintf(dir_noformateada,"%.*s\0",szDireccion[iDIRECCION_CORRESPONDENCIA].len, szDireccion[iDIRECCION_CORRESPONDENCIA].arr);

    if(!FormateaDireccion(dir_noformateada,FactCli->szDireccion[iDIRECCION_CORRESPONDENCIA]))
    {
       vDTrazasLog(szModulo,"termino con ERROR DIRECCION_CORRESPONDENCIA(%s) IND_ORDENTOTAL(%ld)\n",LOG02,dir_noformateada,FactCli->lIndOrdenTotal);
    }

    /* DIRECCION SUCURSAL */
    vDTrazasLog(szModulo,"Sucursal",LOG05);

    /* EXEC SQL SELECT GE_FN_OBTIENE_DIRCLIE(:FactCli->szCod_Oficina,10,0,3) INTO :szDireccion[iDIRECCION_SUCURSAL] FROM DUAL ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select GE_FN_OBTIENE_DIRCLIE(:b0,10,0,3) into :b1  from D\
UAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )848;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)(FactCli->szCod_Oficina);
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&szDireccion[iDIRECCION_SUCURSAL];
    sqlstm.sqhstl[1] = (unsigned long )303;
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



    sprintf(dir_noformateada,"%.*s\0",szDireccion[iDIRECCION_SUCURSAL].len, szDireccion[iDIRECCION_SUCURSAL].arr);

    if(!FormateaDireccion(dir_noformateada,FactCli->szDireccion[iDIRECCION_SUCURSAL]))
    {
       vDTrazasLog(szModulo,"termino con ERROR DIRECCION_SUCURSAL(%s) IND_ORDENTOTAL(%ld)\n",LOG02,dir_noformateada,FactCli->lIndOrdenTotal);
    }

    return(TRUE);
}
/****************************************************************************/
/* Funcion que recupera el Saldo Anterior por Concepto                       */
/****************************************************************************/
int SaldoAntConcepto(STSALDO_ANTERIOR  * SaldoTot, long lCodCliente, ST_CICLOFACT *CicloFact)
{
   int   conta,i=0;

   /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long     lhCod_Cliente   [MAX_SALDOS];
    long     lhNum_Secuenci  [MAX_SALDOS];
    int      ihCod_Tipdocum  [MAX_SALDOS];
    long     lhNum_Folio     [MAX_SALDOS];
    double   lhTot_Saldo     [MAX_SALDOS];
    /* VARCHAR  szhNum_FolioCtc [MAX_SALDOS][13]; */ 
struct { unsigned short len; unsigned char arr[14]; } szhNum_FolioCtc[5000];

    /* VARCHAR  szhDes_Tipdocum [MAX_SALDOS][41]; */ 
struct { unsigned short len; unsigned char arr[42]; } szhDes_Tipdocum[5000];

    /* VARCHAR  shzFec_Efectiva [MAX_SALDOS][11]; */ 
struct { unsigned short len; unsigned char arr[14]; } shzFec_Efectiva[5000];


   /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "SaldoAntConcepto");
    vDTrazasLog(szModulo, "\tEntro a %s ", LOG05, szModulo);

   /*SETEO DE ESTRUCTURA A LLENAR*/

   SaldoTot->szFec_Emision [0]=0;
   SaldoTot->dTotalSaldo      =0.0;
   SaldoTot->iNum_RegSaldo    =0;

   for(conta=0;conta<MAX_SALDOS;conta++){
        SaldoTot->stReg[conta].szDes_Saldo    [0]=0;
        SaldoTot->stReg[conta].szFechaEfectiva[0]=0;
        SaldoTot->stReg[conta].szNum_FolioCtc [0]=0;
        SaldoTot->stReg[conta].iCod_Tipdoc       =0;
        SaldoTot->stReg[conta].lCod_Cliente      =0;
        SaldoTot->stReg[conta].lNum_Folio        =0;
        SaldoTot->stReg[conta].lNum_Secuenci     =0;
        SaldoTot->stReg[conta].lNumAbonado       =0;
        SaldoTot->stReg[conta].dTotalSaldoAnt    =0;

   }


    lhCodClienteCur = lCodCliente;
    strcpy(szhFec_EmisionCur,CicloFact->szFec_Emision);

    /* EXEC SQL OPEN Cursor_SaldoAnte ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )871;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodClienteCur;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFec_EmisionCur;
    sqlstm.sqhstl[3] = (unsigned long )9;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihAValorCero;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihAValorUno;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihAValorUno;
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


    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog(szModulo, "Error en OPEN Cur_SaldoAnte. Error [%i][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL FETCH Cursor_SaldoAnte
        INTO
        :szhNum_FolioCtc,
        :shzFec_Efectiva,
        :lhCod_Cliente,
        :lhNum_Secuenci,
        :ihCod_Tipdocum,
        :lhNum_Folio,
        :szhDes_Tipdocum,
        :lhTot_Saldo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )914;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNum_FolioCtc;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )16;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)shzFec_Efectiva;
    sqlstm.sqhstl[1] = (unsigned long )13;
    sqlstm.sqhsts[1] = (         int  )16;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)lhCod_Cliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)lhNum_Secuenci;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )sizeof(long);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)ihCod_Tipdocum;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)lhNum_Folio;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )sizeof(long);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhDes_Tipdocum;
    sqlstm.sqhstl[6] = (unsigned long )43;
    sqlstm.sqhsts[6] = (         int  )44;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)lhTot_Saldo;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
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



    SaldoTot->iNum_RegSaldo=sqlca.sqlerrd[2];


    if(SaldoTot->iNum_RegSaldo<=0)
    {
        vDTrazasLog(szModulo, "No se encontraron Saldos Anteriores", LOG00);
        return(FALSE);
    }

    if(SaldoTot->iNum_RegSaldo>0)
    {
        sprintf(SaldoTot->szFec_Emision,"%s\0",CicloFact->szFec_Emision);
        for (i=0;i< SaldoTot->iNum_RegSaldo;i++)
        {
            SaldoTot->stReg[i].lCod_Cliente    =   lhCod_Cliente[i];
            SaldoTot->stReg[i].lNum_Secuenci   =   lhNum_Secuenci[i];
            SaldoTot->stReg[i].lNum_Folio      =   lhNum_Folio[i];
            SaldoTot->stReg[i].iCod_Tipdoc     =   ihCod_Tipdocum[i];
            SaldoTot->stReg[i].dTotalSaldoAnt  =   lhTot_Saldo[i];

            sprintf(SaldoTot->stReg[i].szNum_FolioCtc,"%.*s\0", szhNum_FolioCtc[i].len, szhNum_FolioCtc[i].arr);
            sprintf(SaldoTot->stReg[i].szDes_Saldo,"%.*s\0",    szhDes_Tipdocum[i].len, szhDes_Tipdocum[i].arr);
            sprintf(SaldoTot->stReg[i].szFechaEfectiva,"%.*s\0",shzFec_Efectiva[i].len, shzFec_Efectiva[i].arr);


            SaldoTot->dTotalSaldo += lhTot_Saldo[i];
        }
    }

    if (stStatus.LogNivel >= LOG05)
    {
        vDTrazasLog (szModulo,"SaldoTot->iNum_RegSaldo [%i]\n",LOG05, SaldoTot->iNum_RegSaldo);
        for (i=0;i< SaldoTot->iNum_RegSaldo;i++)
            vDTrazasLog (szModulo,"SaldoTot->stReg[%i].dTotalSaldoAnt [%f]\n",LOG05, i, SaldoTot->stReg[i].dTotalSaldoAnt);

    }

    /* EXEC SQL CLOSE Cursor_SaldoAnte; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )961;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog(szModulo, "Error en CLOSE Cur_SaldoAnte. Error [%d][%s]", LOG00, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    return(TRUE);
}/********************************** Final SaldoAntConcepto **********************************/


int ifnCmpTipDocum(const void *cad1,const void *cad2)
{
    return  ((TIPDOC *)cad1)->iCodTipDocum -
            ((TIPDOC *)cad2)->iCodTipDocum;
}



BOOL bfnCargaTipDocum (TIPDOC **pstTipDoc, int *iNumTipDocs)
{
    int     rc = 0;
    int     iNumFilas;
    TIPDOC_HOSTS stTipDocHost;
    TIPDOC  *pstTipDocumTemp;
    int  iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Tipos de Documentos y sus Descripciones ", LOG06);

    *iNumTipDocs = 0;
    *pstTipDoc = NULL;

    if (ifnOpenTipDocums())
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchTipDocums (&stTipDocHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstTipDoc =(TIPDOC*) realloc(*pstTipDoc,(((*iNumTipDocs)+iNumFilas)*sizeof(TIPDOC)));

        if (!*pstTipDoc)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaTipDocum", "no se pudo reservar memoria");
            return FALSE;
        }

        pstTipDocumTemp = &(*pstTipDoc)[(*iNumTipDocs)];
        memset(pstTipDocumTemp, 0, sizeof(TIPDOC)*iNumFilas);
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy( pstTipDocumTemp[iCont].szDesTipDocum    ,stTipDocHost.szDesTipDocum[iCont]);
            pstTipDocumTemp[iCont].iCodTipDocum     = stTipDocHost.iCodTipDocum[iCont];
        }
        (*iNumTipDocs) += iNumFilas;

    }/* fin while */

    vDTrazasLog (szExeName,"\n\t\t* Tipos de documentos cargados [% d]", LOG06, *iNumTipDocs);

    rc = ifnCloseTipDocums();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaTipDocum", szfnORAerror ());
        return FALSE;
    }

    qsort((void*)*pstTipDoc, *iNumTipDocs, sizeof(TIPDOC),ifnCmpTipDocum);

    vfnPrintTipDocums (*pstTipDoc, *iNumTipDocs);

    return (TRUE);
}/***************************** Final bfnCargaTipDocum *********************/

int ifnOpenTipDocums(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ge_Tipdocumen", LOG06);

    /* EXEC SQL DECLARE Cur_TipDocum CURSOR FOR
    SELECT DISTINCT COD_TIPDOCUM,
            DES_TIPDOCUM
    FROM   GE_TIPDOCUMEN; */ 


    /* EXEC SQL OPEN Cur_TipDocum; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0021;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )976;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ge_Tipdocumen",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenTipDocums **********************/

BOOL bfnFetchTipDocums (TIPDOC_HOSTS *pstHost,int *piNumFilas)
{

    /* EXEC SQL FETCH Cur_TipDocum
              INTO  :pstHost->iCodTipDocum  ,
                :pstHost->szDesTipDocum ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )991;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->iCodTipDocum);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesTipDocum);
    sqlstm.sqhstl[1] = (unsigned long )41;
    sqlstm.sqhsts[1] = (         int  )41;
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



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> GE_TIPDOCUMEN", szfnORAerror ());
    return SQLCODE;
}/***************************** Final bfnFetchTipDocums ****************/


int ifnCloseTipDocums(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ge_Tipdocumen", LOG06);

    /* EXEC SQL CLOSE Cur_TipDocum; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1014;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> GE_TIPDOCUMEN",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenTipDocums **********************/

void vfnPrintTipDocums (TIPDOC *pstTipDoc, int iNumTipDocs)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Tipos de Documentos [%d]", LOG06, iNumTipDocs);

        for (i=0;i<iNumTipDocs;i++)
        {
             vDTrazasLog (szExeName,    "\n\t\t=> [%d]: Descripcion Tipo de Documento   [%s]"
                            "\n\t\t=> [%d]: Codigo de Tipo de Documento [%d]"
                            ,LOG06
                            ,i, pstTipDoc[i].szDesTipDocum
                            ,i, pstTipDoc[i].iCodTipDocum   );
        }
    }
}/*************************** vfnPrintTipDocums *****************************/


BOOL bfnFindTipDocum (int iCodTipDocum, TIPDOC *pstTipDoc )
{
    TIPDOC  stkey;
    TIPDOC  *pstAux = (TIPDOC *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Tipo de Documento "
                            "\n\t\t=> Cod.TipDocum   [%d]"
                            , LOG05,iCodTipDocum);

    stkey.iCodTipDocum  = iCodTipDocum;

    if ( (pstAux = (TIPDOC *)bsearch (&stkey, pstTipDocum.stTipDocum , pstTipDocum.iNumTipDocum,
        sizeof (TIPDOC),ifnCmpTipDocum ))== (TIPDOC *)NULL)
    {
        vDTrazasLog(szExeName, "Tipo de Documento [%d] no encontrado ...", LOG01, iCodTipDocum);
        return  (FALSE);
    }

    memcpy (pstTipDoc, pstAux, sizeof(TIPDOC));
    return (TRUE);
}



int ifnCmpOficinas2(const void *cad1,const void *cad2)
{
    return ( strcmp (((OFICINA2  *)cad1)->szCodOficina,((OFICINA2  *)cad2)->szCodOficina) );

}

/**************************************************************************/
/*                             funcion : bfnFindOficina                   */
/**************************************************************************/
BOOL bfnFindOficina2 (char *szCodOficina, OFICINA2 *pstOficina )
{
    OFICINA2  stkey;
        OFICINA2  *pstAux = (OFICINA2 *)NULL;

        vDTrazasLog (szExeName, "\n\t\t* Busca Oficina "
                "\n\t\t=> Cod.Oficina   [%s]"
                "\n\t\t=> Num.Oficina   [%d]"
                , LOG05,szCodOficina, pstOficinas2.iNumOficinas);


    strcpy (stkey.szCodOficina,szCodOficina);

    if ( (pstAux = (OFICINA2 *)bsearch (&stkey, pstOficinas2.stOficina, pstOficinas2.iNumOficinas,
                               sizeof (OFICINA2),ifnCmpOficinas ))== (OFICINA2 *)NULL)
    {

        vDTrazasLog(szExeName, "Oficina [%s] no encontrada ...", LOG01, szCodOficina);
        return  (FALSE);
    }

    memcpy (pstOficina, pstAux, sizeof(OFICINA2));

    return TRUE;
}/**************************** Final bfnFindOficina2 *********************/

BOOL bfnCargaOficinas2 (OFICINA2 **pstOfici2, int *iNumOficinas)
{
    int     rc = 0;
    int     iNumFilas;
    OFICINA_HOSTS2 stOficinasHost;
    OFICINA2 *pstOficinasTemp;
    int     iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Oficinas ", LOG06);

    *iNumOficinas = 0;
    *pstOfici2 = NULL;

    if (ifnOpenOficinas2())
        return (FALSE);

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchOficinas2 (&stOficinasHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
            return (FALSE);

        if (!iNumFilas)
        break;

        *pstOfici2 =(OFICINA2*) realloc(*pstOfici2,(((*iNumOficinas)+iNumFilas)*sizeof(OFICINA2)));

        if (!*pstOfici2)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaOficinas2", "no se pudo reservar memoria");
            return (FALSE);
        }

        pstOficinasTemp = &(*pstOfici2)[(*iNumOficinas)];
        memset(pstOficinasTemp, 0, sizeof(OFICINA2)*iNumFilas);
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy(pstOficinasTemp[iCont].szCodOficina  ,alltrim(stOficinasHost.szCodOficina    [iCont]));
            strcpy(pstOficinasTemp[iCont].szDesOficina  ,alltrim(stOficinasHost.szDesOficina    [iCont]));
        }
        (*iNumOficinas) += iNumFilas;

    }/* fin while */

    vDTrazasLog (szExeName,"\n\t\t* Oficinas cargadas [%d]", LOG06, *iNumOficinas);

    rc = ifnCloseOficinas2();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaOficinas2", szfnORAerror ());
        return (FALSE);
    }

    qsort((void*)*pstOfici2, *iNumOficinas, sizeof(OFICINA2),ifnCmpOficinas);

    vfnPrintOficinas2 (*pstOfici2, *iNumOficinas);

    return (TRUE);
}/***************************** Final bfnCargaOficinas2 *********************/


int ifnOpenOficinas2 (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> Ge_Oficinas;Ge_Direcciones;Ge_Ciudades", LOG06);

    /* EXEC SQL DECLARE Cur_Oficinas CURSOR FOR
            SELECT DISTINCT COD_OFICINA, DES_OFICINA
        FROM   GE_OFICINAS; */ 


    /* EXEC SQL OPEN Cur_Oficinas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0022;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1029;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ge_Oficinas",
            szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenOficinas2 **********************/

BOOL bfnFetchOficinas2 (OFICINA_HOSTS2 *pstHost,int *piNumFilas)
{
    /* EXEC SQL FETCH Cur_Oficinas
            INTO    :pstHost->szCodOficina  ,
                :pstHost->szDesOficina  ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )1044;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodOficina);
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )3;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szDesOficina);
    sqlstm.sqhstl[1] = (unsigned long )41;
    sqlstm.sqhsts[1] = (         int  )41;
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



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Oficinas",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bfnFetchOficinas2 ****************/

/****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                    */
/****************************************************************************/
void vfnPrintOficinas2 (OFICINA2 *pstOficina, int iNumOficinas)
{
  int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Oficinas [%d]", LOG06, iNumOficinas);

        for (i=0;i<iNumOficinas;i++)
        {
             vDTrazasLog (szExeName,"\n\t\t=> [%d]: Codigo Oficina      [%s]"
                                    "\n\t\t=> [%d]: Descripcion Oficina [%s]"
                                    ,LOG06
                                    ,i, pstOficina[i].szCodOficina
                                    ,i, pstOficina[i].szDesOficina );

        }
    }
}/*************************** vfnPrintOficinas2 *****************************/

int ifnCloseOficinas2 (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Oficinas", LOG06);

  /* EXEC SQL CLOSE Cur_Oficinas; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1067;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Oficinas",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnCloseOficinas2 ******************/




int ifnCmpVendedores(const void *cad1,const void *cad2)
{
    return  ((VENDEDOR *)cad1)->lCodVendedor -
            ((VENDEDOR *)cad2)->lCodVendedor;
}

BOOL bfnCargaVendedores (VENDEDOR **pstVendedor, int *iNumVendedores)
{
    int     rc = 0;
    int    iNumFilas;
    VENDEDOR_HOSTS stVendedorHost;
    VENDEDOR    *pstVendedorTemp;
    int  iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Codigos de Vendedores y sus Nombres", LOG06);

    *iNumVendedores = 0;
    *pstVendedor = NULL;

    if (ifnOpenVendedores())
        return FALSE;

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchVendedores(&stVendedorHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!iNumFilas)
            break;

        *pstVendedor =(VENDEDOR*) realloc(*pstVendedor,(((*iNumVendedores)+iNumFilas)*sizeof(VENDEDOR)));

        if (!*pstVendedor)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaVendedores", "no se pudo reservar memoria");
            return FALSE;
        }

        pstVendedorTemp = &(*pstVendedor)[(*iNumVendedores)];
        memset(pstVendedorTemp, 0, sizeof(VENDEDOR)*iNumFilas);
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy( pstVendedorTemp[iCont].szNomVendedor    ,stVendedorHost.szNomVendedor[iCont]);
            pstVendedorTemp[iCont].lCodVendedor     =stVendedorHost.lCodVendedor[iCont];
        }
        (*iNumVendedores) += iNumFilas;

    }/* fin while */

    vDTrazasLog (szExeName,"\n\t\t* Codigos de Vendedores cargados [%d]", LOG06, *iNumVendedores);

    rc = ifnCloseVendedores();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaVendedores", szfnORAerror ());
        return FALSE;
    }

    qsort((void*)*pstVendedor, *iNumVendedores, sizeof(VENDEDOR),ifnCmpVendedores);

    vfnPrintVendedores(*pstVendedor, *iNumVendedores);

    return (TRUE);
}/***************************** Final bfnCargaVendedores *********************/

int ifnOpenVendedores(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> VE_VENDEDORES", LOG06);

    /* EXEC SQL DECLARE Cur_Vendedores CURSOR for
        SELECT DISTINCT COD_VENDEDOR, NOM_VENDEDOR
        FROM   VE_VENDEDORES; */ 


    /* EXEC SQL OPEN Cur_Vendedores; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0023;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1082;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> VE_VENDEDORES",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenVendedores **********************/

BOOL bfnFetchVendedores (VENDEDOR_HOSTS *pstHost,int *piNumFilas)
{

    /* EXEC SQL FETCH Cur_Vendedores
              INTO  :pstHost->lCodVendedor  ,
                :pstHost->szNomVendedor ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )1097;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCodVendedor);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szNomVendedor);
    sqlstm.sqhstl[1] = (unsigned long )41;
    sqlstm.sqhsts[1] = (         int  )41;
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



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> VE_VENDEDORES", szfnORAerror ());
    return SQLCODE;
}/***************************** Final bfnFetchVendedores ****************/

int ifnCloseVendedores(void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> VE_VENDEDORES", LOG06);

    /* EXEC SQL CLOSE Cur_Vendedores; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1120;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Cursor=> VE_VENDEDORES",
                 szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnCloseVendedores **********************/

void vfnPrintVendedores (VENDEDOR *pstCodVend, int iNumVendedores)
{
    int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Codigos de Vendedores [%d]", LOG06, iNumVendedores);

        for (i=0;i<iNumVendedores;i++)
        {
             vDTrazasLog (szExeName,"\t\t=> [%d]: Codigo de Vendedor [%ld] : Nombre [%s]"
                            		,LOG06
                            		,i, pstCodVend[i].lCodVendedor, pstCodVend[i].szNomVendedor);

        }
    }
}/*************************** vfnPrintVendedores *****************************/


BOOL bfnFindVendedores (long lCodigoVendedor, VENDEDOR *pstCodVende, long lCodCiclFact)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodVendedor;
        char    szhNomVendedor[41];
    /* EXEC SQL END DECLARE SECTION; */ 


    VENDEDOR  stkey;
    VENDEDOR  *pstAux = (VENDEDOR *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Codigo de Vendedor "
                            "\n\t\t=> Cod.Vendedor   [%ld]"
                            , LOG05,lCodigoVendedor);

    stkey.lCodVendedor  = lCodigoVendedor;
    if (lCodCiclFact)
    {
        if ( (pstAux = (VENDEDOR *)bsearch (&stkey, pstVendedores.stVendedores , pstVendedores.iNumVendedores,
            sizeof (VENDEDOR),ifnCmpVendedores ))== (VENDEDOR *)NULL)
        {

            vDTrazasLog(szExeName, "Codigo de Vendedor [%ld] no encontrado ...", LOG01, lCodigoVendedor);
            return  (FALSE);
        }

        memcpy (pstCodVende, pstAux, sizeof(VENDEDOR));
    }
    else
    {
        lhCodVendedor = lCodigoVendedor;

        /* EXEC SQL SELECT NVL(NOM_VENDEDOR, '.')
            INTO :szhNomVendedor
            FROM   VE_VENDEDORES
            WHERE  COD_VENDEDOR =  :lhCodVendedor; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NVL(NOM_VENDEDOR,'.') into :b0  from VE_VENDED\
ORES where COD_VENDEDOR=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1135;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhNomVendedor;
        sqlstm.sqhstl[0] = (unsigned long )41;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedor;
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
                iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> VE_VENDEDORES",
                        szfnORAerror ());
                return FALSE;
            }
            else
            {
                pstCodVende->lCodVendedor = lhCodVendedor;
                strcpy (pstCodVende->szNomVendedor, szhNomVendedor);

            }
    }
    return (TRUE);
}


/**************************************************************************/
/*                             funcion : ifnCmpOperadoras                 */
/**************************************************************************/
int ifnCmpOperadoras(const void *cad1,const void *cad2)
{
    return ( strcmp (((OPERADORA *)cad1)->szCodOperadora,((OPERADORA *)cad2)->szCodOperadora) );

}

/**************************************************************************/
/*                             funcion : bfnFindOficina                   */
/**************************************************************************/
BOOL bfnFindOperadora (char *szCodOper, OPERADORA *pstOper )
{
    OPERADORA  stkey;
    OPERADORA  *pstAux = (OPERADORA *)NULL;

    vDTrazasLog (szExeName, "\n\t\t* Busca Operadora "
                            "\n\t\t=> Cod.Operadora   [%s]"
                            "\n\t\t=> Num.Operadoras  [%d]"
                            , LOG05,szCodOper, pstOperadoras.iNumOperadoras);


    strcpy (stkey.szCodOperadora,szCodOper);

    if ( (pstAux = (OPERADORA *)bsearch (&stkey, pstOperadoras.stOperadora, pstOperadoras.iNumOperadoras,
                               sizeof (OPERADORA),ifnCmpOperadoras ))== (OPERADORA *)NULL)
    {
        vDTrazasLog(szExeName, "Operadora [%s] no encontrada.", LOG01, szCodOper);
        return  (FALSE)                                                   ;
    }

    memcpy (pstOper, pstAux, sizeof(OPERADORA));

    return TRUE;
}/**************************** Final bfnFindOficina2 *********************/

BOOL bfnCargaOperadora (OPERADORA **pstOper, int *iNumOperadoras)
{
    int     rc = 0;
    int     iNumFilas;
    OPERADORA_HOSTS stOperadorasHost;
    OPERADORA *pstOperadoraTemp;
    int  iCont;

    vDTrazasLog (szExeName,"\n\t* Carga Operadoras ", LOG06);

    *iNumOperadoras = 0;
    *pstOper = NULL;

    if (ifnOpenOperadoras())
        return (FALSE);

    while (rc != SQLNOTFOUND)
    {
        rc = bfnFetchOperadoras (&stOperadorasHost,&iNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
            return (FALSE);

        if (!iNumFilas)
        break;

        *pstOper =(OPERADORA*) realloc(*pstOper,(((*iNumOperadoras)+iNumFilas)*sizeof(OPERADORA)));

        if (!*pstOper)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnCargaOperadora", "no se pudo reservar memoria");
            return (FALSE);
        }

        pstOperadoraTemp = &(*pstOper)[(*iNumOperadoras)];
        memset(pstOperadoraTemp, 0, sizeof(OPERADORA)*iNumFilas);
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy(pstOperadoraTemp[iCont].szCodOperadora   ,alltrim(stOperadorasHost.szCodOperadora    [iCont]));
            pstOperadoraTemp[iCont].lCodClienteOperadora    = stOperadorasHost.lCodClienteOperadora [iCont];
            strcpy(pstOperadoraTemp[iCont].szNomOperadora   ,alltrim(stOperadorasHost.szNomOperadora    [iCont]));
            strcpy(pstOperadoraTemp[iCont].szNumIdenTRib    ,alltrim(stOperadorasHost.szNumIdenTRib [iCont]));
            strcpy(pstOperadoraTemp[iCont].szDireccion      , alltrim(stOperadorasHost.szDireccion[iCont]));
        }
        (*iNumOperadoras) += iNumFilas;

    }/* fin while */

    vDTrazasLog (szExeName,"\n\t\t* Operadoras cargadas [%d]", LOG06, *iNumOperadoras);

    rc = ifnCloseOperadoras();
    if (rc != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Error bfnCargaOperadora", szfnORAerror ());
        return (FALSE);
    }

    qsort((void*)*pstOper, *iNumOperadoras, sizeof(OPERADORA),ifnCmpOperadoras);

    vfnPrintOperadoras (*pstOper, *iNumOperadoras);

    return (TRUE);
}/***************************** Final bfnCargaOperadora *********************/

int ifnOpenOperadoras (void)
{
    vDTrazasLog (szExeName,"\n\t\t* Open=> GE_OPERADORA_SCL", LOG06);

    /* EXEC SQL DECLARE Cur_Operadoras CURSOR FOR
        SELECT  LTRIM(RTRIM(A.COD_OPERADORA_SCL)),
            A.COD_CLIENTE,
            B.NOM_CLIENTE,
            NVL(B.NUM_IDENTTRIB,'AAA'),
            NVL(GE_FN_OBTIENE_DIRCLIE(COD_OPERADORA_SCL,12,0,3),' ')
        FROM    GE_OPERADORA_SCL A,GE_CLIENTES B
        WHERE   A.COD_CLIENTE=B.COD_CLIENTE
                AND     A.COD_CLIENTE IS NOT NULL; */ 


    /* EXEC SQL OPEN Cur_Operadoras; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0025;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1158;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Ge_Oficinas",
            szfnORAerror ());

    return SQLCODE;
}/***************************** Final ifnOpenOficinas2 **********************/

BOOL bfnFetchOperadoras (OPERADORA_HOSTS *pstHost,int *piNumFilas)
{
    /* EXEC SQL FETCH Cur_Operadoras
            INTO    :pstHost->szCodOperadora    ,
                    :pstHost->lCodClienteOperadora  ,
                    :pstHost->szNomOperadora,
                    :pstHost->szNumIdenTRib ,
                    :pstHost->szDireccion; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )100;
    sqlstm.offset = (unsigned int  )1173;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szCodOperadora);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lCodClienteOperadora);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szNomOperadora);
    sqlstm.sqhstl[2] = (unsigned long )51;
    sqlstm.sqhsts[2] = (         int  )51;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szNumIdenTRib);
    sqlstm.sqhstl[3] = (unsigned long )21;
    sqlstm.sqhsts[3] = (         int  )21;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szDireccion);
    sqlstm.sqhstl[4] = (unsigned long )301;
    sqlstm.sqhsts[4] = (         int  )301;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
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



    if (SQLCODE==SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE==SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;
        else
            iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch=> Oficinas",
               szfnORAerror ());

  return SQLCODE;
}/***************************** Final bfnFetchOficinas2 ****************/

int ifnCloseOperadoras (void)
{
  vDTrazasLog (szExeName,"\n\t\t* Close=> Oficinas", LOG06);

  /* EXEC SQL CLOSE Cur_Operadoras; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1208;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if (SQLCODE != SQLOK)
    iDError (szExeName,ERR000,vInsertarIncidencia,"Close=> Oficinas",
             szfnORAerror ());

  return SQLCODE;
}/**************************** Final ifnCloseOficinas2 ******************/

/****************************************************************************/
/*                           funcion : vfnPrintFaCiclFact                    */
/****************************************************************************/
void vfnPrintOperadoras (OPERADORA *pstOper, int iNumOper)
{
  int i = 0;

    if (stStatus.LogNivel >= LOG06)
    {
        vDTrazasLog (szExeName,"\n\t\t* Carga Tabla Operadoras [%d]", LOG06, iNumOper);

        for (i=0;i<iNumOper;i++)
        {
             vDTrazasLog (szExeName,    "\n\t\t=> [%d]: Codigo Operadora    [%s]"
                        "\n\t\t=> [%d]: Nombre Operadora    [%ld]"
                        "\n\t\t=> [%d]: Vendedor Operadora  [%s]"
                        "\n\t\t=> [%d]: Iden.Trib Operadora [%s]"
                            ,LOG06
                        ,i, pstOper[i].szCodOperadora
                        ,i, pstOper[i].lCodClienteOperadora
                        ,i, pstOper[i].szNomOperadora
                        ,i, pstOper[i].szNumIdenTRib );
        }
    }
}/*************************** vfnPrintOficinas2 *****************************/




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

