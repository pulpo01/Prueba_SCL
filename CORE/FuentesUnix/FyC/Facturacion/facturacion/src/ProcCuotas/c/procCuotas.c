
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
           char  filnam[19];
};
static const struct sqlcxp sqlfpn =
{
    18,
    "./pc/procCuotas.pc"
};


static unsigned int sqlctx = 13862403;


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
   unsigned char  *sqhstv[21];
   unsigned long  sqhstl[21];
            int   sqhsts[21];
            short *sqindv[21];
            int   sqinds[21];
   unsigned long  sqharm[21];
   unsigned long  *sqharc[21];
   unsigned short  sqadto[21];
   unsigned short  sqtdso[21];
} sqlstm = {12,21};

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

 static const char *sq0003 = 
"select distinct CLI.COD_CLIENTE  from FA_CICLOCLI CLI where (((CLI.COD_CICLO\
=:b0 and CLI.IND_MASCARA=:b1) and (CLI.COD_CLIENTE between :b2 and :b3 or 1<>:\
b4)) and exists (select 1  from CO_CARTERA CAR where ((((((CAR.COD_CLIENTE=CLI\
.COD_CLIENTE and NUM_CUOTA>:b5) and COD_TIPDOCUM<>5) and COD_TIPDOCUM<>59) and\
 COD_TIPDOCUM<>60) and COD_TIPDOCUM<>39) and COD_TIPDOCUM<>32)))           ";

 static const char *sq0001 = 
"select NUM_SECUENCI ,COD_TIPDOCUM ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI \
,COD_CONCEPTO ,COLUMNA ,NUM_CUOTA ,SEC_CUOTA ,IND_FACTURADO ,TO_CHAR(FEC_VENCI\
MIE,:b0) ,NVL(NUM_FOLIOCTC,' ') ,(IMPORTE_DEBE-IMPORTE_HABER) ,TO_CHAR(FEC_EFE\
CTIVIDAD,:b0) ,NUM_FOLIO ,NVL(PREF_PLAZA,'000') ,NVL(NUM_ABONADO,:b2)  from CO\
_CARTERA where ((((((COD_CLIENTE=:b3 and NUM_CUOTA>:b4) and COD_TIPDOCUM<>5) a\
nd COD_TIPDOCUM<>59) and COD_TIPDOCUM<>60) and COD_TIPDOCUM<>39) and COD_TIPDO\
CUM<>32) order by NUM_SECUENCI,COD_TIPDOCUM,COD_VENDEDOR_AGENTE,LETRA,COD_CENT\
REMI,COD_CONCEPTO,COLUMNA,NUM_CUOTA            ";

 static const char *sq0002 = 
"select count(:b0)  from GA_INFACCEL where (((COD_CLIENTE=:b1 and NUM_ABONADO\
>=:b2) and COD_CICLFACT=:b3) and IND_ACTUAC=:b4)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,4,0,0,17,235,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,5,0,0,17,243,0,0,1,1,0,1,0,1,97,0,0,
43,0,0,6,0,0,17,251,0,0,1,1,0,1,0,1,97,0,0,
62,0,0,7,0,0,17,259,0,0,1,1,0,1,0,1,97,0,0,
81,0,0,3,385,0,9,781,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,
120,0,0,3,0,0,13,813,0,0,1,0,0,1,0,2,3,0,0,
139,0,0,3,0,0,15,835,0,0,0,0,0,1,0,
154,0,0,8,51,0,2,866,0,0,1,1,0,1,0,1,3,0,0,
173,0,0,9,89,0,2,876,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
200,0,0,1,591,0,9,912,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
235,0,0,1,0,0,13,921,0,0,17,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,9,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,9,0,0,2,9,0,0,2,4,0,0,2,9,0,0,2,3,0,0,
2,9,0,0,2,3,0,0,
318,0,0,1,0,0,15,956,0,0,0,0,0,1,0,
333,0,0,2,135,0,9,1023,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
368,0,0,2,0,0,13,1033,0,0,1,0,0,1,0,2,3,0,0,
387,0,0,2,0,0,15,1050,0,0,0,0,0,1,0,
402,0,0,4,0,0,21,1260,0,0,21,21,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,4,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
501,0,0,10,54,0,1,1421,0,0,0,0,0,1,0,
516,0,0,11,0,0,17,1423,0,0,1,1,0,1,0,1,97,0,0,
535,0,0,11,0,0,45,1446,0,0,1,1,0,1,0,1,3,0,0,
554,0,0,11,0,0,45,1448,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
581,0,0,11,0,0,13,1499,0,0,20,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,
0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
676,0,0,11,0,0,15,1563,0,0,0,0,0,1,0,
691,0,0,5,0,0,21,1615,0,0,11,11,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
750,0,0,6,0,0,21,1652,0,0,1,1,0,1,0,1,5,0,0,
769,0,0,7,0,0,21,1680,0,0,1,1,0,1,0,1,5,0,0,
788,0,0,12,77,0,2,1727,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
815,0,0,13,142,0,6,1748,0,0,5,5,0,1,0,2,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
850,0,0,14,138,0,6,1803,0,0,5,5,0,1,0,2,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/* ***********************************************
              "procCuotas.pc"

15 de Mayo de 2000 :    Mauricio Villagra V.
                        Creacion de Proceso

*********************************************** */
/************************************************************************/
/*  Modificaciones referentes a caidas del proceso en los casos de  */
/*  Prefijo Plaza.                          */
/*  PGonzaleg 16-01-2003                        */
/************************************************************************/

#include "procCuotas.h"

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


#define MAX_CUOTASCREDITOCLIENTE_PLUS MAX_CUOTASCREDITOCLIENTE + 500

/* EXEC SQL BEGIN DECLARE SECTION  ; */ 

int     giMinNumCuotas       ;
long    glhCodCliente        ;
int     gihCodCiclo          ;
long    glahNumSecuenci      [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
int     giahCodTipDocum      [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
long    glahCodVendedorAgente[MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
/* VARCHAR gszahLetra           [MAX_CUOTASCREDITOCLIENTE_PLUS][2]   ; */ 
struct { unsigned short len; unsigned char arr[2]; } gszahLetra[5000];

int     giahCodCentremi      [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
int     giahCodConcepto      [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
int     giahColumna          [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
int     giahNumCuota         [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
int     giahSecCuota         [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
int     giahIndFacturado     [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
/* VARCHAR gszahFecVencimie     [MAX_CUOTASCREDITOCLIENTE_PLUS][20]  ; */ 
struct { unsigned short len; unsigned char arr[22]; } gszahFecVencimie[5000];

/* VARCHAR gszahNumFolioCTC     [MAX_CUOTASCREDITOCLIENTE_PLUS][12]  ; */ 
struct { unsigned short len; unsigned char arr[14]; } gszahNumFolioCTC[5000];

double  gdahMtoCuota         [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
/* VARCHAR gszahFecCompra       [MAX_CUOTASCREDITOCLIENTE_PLUS][20]  ; */ 
struct { unsigned short len; unsigned char arr[22]; } gszahFecCompra[5000];

long    glahNum_Folio        [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;
/*RA-200510310009*largo pref_plaza*/
/*VARCHAR gszhPref_Plaza       [MAX_CUOTASCREDITOCLIENTE_PLUS][4]   ;*/
/* VARCHAR gszhPref_Plaza       [MAX_CUOTASCREDITOCLIENTE_PLUS][11]  ; */ 
struct { unsigned short len; unsigned char arr[14]; } gszhPref_Plaza[5000];

/*RA-200510310009*largo pref_plaza*/
long    glahNumAbonado       [MAX_CUOTASCREDITOCLIENTE_PLUS]      ;


char *szSQL_INSERT_FA_CUOTCREDITO =
" INSERT INTO FA_CUOTCREDITO      (  "
"         IND_ORDENTOTAL          ,  "
"         COD_CLIENTE             ,  "
"         NUM_SECUENCI            ,  "
"         COD_TIPDOCUM            ,  "
"         COD_VENDEDOR_AGENTE     ,  "
"         LETRA                   ,  "
"         COD_CENTREMI            ,  "
"         COD_CONCEPTO            ,  "
"         COLUMNA                 ,  "
"         NUM_CUOTA               ,  "
"         SEC_CUOTA               ,  "
"         COD_CICLFACT            ,  "
"         IND_FACTURADO           ,  "
"         FEC_VENCIMIE            ,  "
"         NUM_FOLIOCTC            ,  "
"         MTO_CUOTA               ,  "
"         FEC_COMPRA              ,  "
"         IND_IMPRESO             ,  "
"         NUM_FOLIO               ,  "
"         PREF_PLAZA              ,  "
"         NUM_ABONADO           )    "
" VALUES (:ihIndOrdentotal        ,  "
"         :lhCodCliente           ,  "
"         :lhNumSecuenci          ,  "
"         :ihCodTipDocum          ,  "
"         :lhCodVendedorAgente    ,  "
"         :szhLetra               ,  "
"         :ihCodCentremi          ,  "
"         :ihCodConcepto          ,  "
"         :ihColumna              ,  "
"         :ihNumCuota             ,  "
"         :ihSecCuota             ,  "
"         :lhCodCiclFact          ,  "
"         :ihIndFacturado         ,  "
"         TO_DATE(:szhFecVencimie,'YYYYMMDDHH24MISS'),  "
"         :szhNumFolioCTC         ,  "
"         :dhMtoCuota             ,  "
"         TO_DATE(:szhFecCompra,'YYYYMMDDHH24MISS') ,  "
"         :ihIndImpreso           ,  "
"         :lhNum_Folio            ,  "
"         :szhPref_Plaza          ,  "
"         :lhNumAbonado         )    ";

char *szSQL_UPDATE_CO_CARTERA =
" UPDATE  CO_CARTERA                                   "
" SET     IND_FACTURADO       =   :ihIndFacturado ,    "
"         NUM_FOLIOCTC        =   :szhNumFolio    ,    "
"         FEC_VENCIMIE        =   TO_DATE(:szhFecVencimien,'YYYYMMDDHH24MISS') "
" WHERE   COD_CLIENTE         =   :lhCodCliente        "
" AND     NUM_SECUENCI        =   :lhNumSecuenci       "
" AND     COD_TIPDOCUM        =   :ihCodTipDocum       "
" AND     COD_VENDEDOR_AGENTE =   :lhCodVendedorAgente "
" AND     LETRA               =   :szhLetra            "
" AND     COD_CENTREMI        =   :ihCodCentremi       "
" AND     COD_CONCEPTO        =   :ihCodConcepto       "
" AND     COLUMNA             =   :ihColumna           ";

char *szSQL_INSERT_FA_HISTCUOTCREDITO =
" INSERT INTO FA_HISTCUOTCREDITO (      "
"             IND_ORDENTOTAL          , "
"             COD_CLIENTE             , "
"             NUM_SECUENCI            , "
"             COD_TIPDOCUM            , "
"             COD_VENDEDOR_AGENTE     , "
"             LETRA                   , "
"             COD_CENTREMI            , "
"             COD_CONCEPTO            , "
"             COLUMNA                 , "
"             NUM_CUOTA               , "
"             SEC_CUOTA               , "
"             COD_CICLFACT            , "
"             IND_FACTURADO           , "
"             FEC_VENCIMIE            , "
"             NUM_FOLIOCTC            , "
"             MTO_CUOTA               , "
"             FEC_COMPRA              , "
"             IND_IMPRESO             , "
"             NUM_FOLIO               , "
"             PREF_PLAZA              , "
"             NUM_ABONADO           )   "
" SELECT      IND_ORDENTOTAL          , "
"             COD_CLIENTE             , "
"             NUM_SECUENCI            , "
"             COD_TIPDOCUM            , "
"             COD_VENDEDOR_AGENTE     , "
"             LETRA                   , "
"             COD_CENTREMI            , "
"             COD_CONCEPTO            , "
"             COLUMNA                 , "
"             NUM_CUOTA               , "
"             SEC_CUOTA               , "
"             COD_CICLFACT            , "
"             IND_FACTURADO           , "
"             FEC_VENCIMIE            , "
"             NUM_FOLIOCTC            , "
"             MTO_CUOTA               , "
"             FEC_COMPRA              , "
"             IND_IMPRESO             , "
"             NUM_FOLIO               , "
"             PREF_PLAZA              , "
"             NUM_ABONADO               "
" FROM        FA_CUOTCREDITO            "
" WHERE       ROWID       =   :szhRowid ";

char *szSQL_DELETE_FA_CUOTCREDITO =
" DELETE FROM FA_CUOTCREDITO            "
" WHERE       ROWID       =   :szhRowid ";

/*******************************************************************/
/* Globales                                                        */
/*******************************************************************/

    char    gszFormatoFec  [17];/* EXEC SQL VAR gszFormatoFec IS STRING(17); */ 

    long    glhCodCicloFact   = 0L;
    int     gihIndActuacAlta  = NORMAL;
    int     giCero            = 0;
    int     giUno             = 1;
    int     gihIndMascara     = 0;
    long    glhRngIniClie     = 0L;
    long    glhRngFinClie     = 0L;
    long    gihIngRngClientes = 0;

/* EXEC SQL END DECLARE SECTION    ; */ 


/* EXEC SQL DECLARE CURSOR_SELECT_CO_CARTERA CURSOR FOR
    SELECT  NUM_SECUENCI            ,
            COD_TIPDOCUM            ,
            COD_VENDEDOR_AGENTE     ,
            LETRA                   ,
            COD_CENTREMI            ,
            COD_CONCEPTO            ,
            COLUMNA                 ,
            NUM_CUOTA               ,
            SEC_CUOTA               ,
            IND_FACTURADO           ,
            TO_CHAR(FEC_VENCIMIE,:gszFormatoFec) ,
            NVL(NUM_FOLIOCTC,' ')   ,
            (IMPORTE_DEBE-IMPORTE_HABER) ,
            TO_CHAR(FEC_EFECTIVIDAD,:gszFormatoFec) ,
            NUM_FOLIO     ,
            NVL(PREF_PLAZA,'000')   ,
            NVL(NUM_ABONADO,:giCero)
    FROM    CO_CARTERA
    WHERE COD_CLIENTE = :glhCodCliente
      AND NUM_CUOTA   > :giMinNumCuotas
      AND COD_TIPDOCUM != 5
      AND COD_TIPDOCUM != 59
      AND COD_TIPDOCUM != 60
      AND COD_TIPDOCUM != 39
      AND COD_TIPDOCUM != 32
    ORDER BY NUM_SECUENCI,
             COD_TIPDOCUM,
             COD_VENDEDOR_AGENTE,LETRA,
             COD_CENTREMI,
             COD_CONCEPTO,
             COLUMNA,
             NUM_CUOTA; */ 


/* EXEC SQL DECLARE CURSOR_INFACCEL CURSOR FOR
    SELECT COUNT(:giUno)
      FROM GA_INFACCEL
     WHERE COD_CLIENTE  = :glhCodCliente
       AND NUM_ABONADO >= :giCero
       AND COD_CICLFACT = :glhCodCicloFact
       AND IND_ACTUAC   = :gihIndActuacAlta; */ 



/* EXEC SQL DECLARE cCursor_Cliente_Cuotas CURSOR FOR
    SELECT DISTINCT CLI.COD_CLIENTE
      FROM FA_CICLOCLI CLI
     WHERE CLI.COD_CICLO    = :gihCodCiclo
       AND CLI.IND_MASCARA  = :gihIndMascara
       AND ((CLI.COD_CLIENTE BETWEEN :glhRngIniClie AND :glhRngFinClie) OR (1 <> :gihIngRngClientes))
       AND EXISTS (SELECT 1
                    FROM CO_CARTERA  CAR
                   WHERE CAR.COD_CLIENTE = CLI.COD_CLIENTE
                     AND NUM_CUOTA   > :giMinNumCuotas
                     AND COD_TIPDOCUM != 5
                     AND COD_TIPDOCUM != 59
                     AND COD_TIPDOCUM != 60
                     AND COD_TIPDOCUM != 39
                     AND COD_TIPDOCUM != 32); */ 


BOOL bfnPreparaQuerysBind()
{
    char *modulo="bfnPreparaQuerysBind";

    /* EXEC SQL PREPARE SQL_INSERT_FA_CUOTCREDITO FROM :szSQL_INSERT_FA_CUOTCREDITO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSQL_INSERT_FA_CUOTCREDITO;
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


    if( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE SQL_INSERT_FA_CUOTCREDITO **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }

    /* EXEC SQL PREPARE SQL_UPDATE_CO_CARTERA FROM :szSQL_UPDATE_CO_CARTERA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSQL_UPDATE_CO_CARTERA;
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


    if( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE SQL_UPDATE_CO_CARTERA **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }

    /* EXEC SQL PREPARE SQL_INSERT_FA_HISTCUOTCREDITO FROM :szSQL_INSERT_FA_HISTCUOTCREDITO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )43;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSQL_INSERT_FA_HISTCUOTCREDITO;
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


    if( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE SQL_INSERT_FA_HISTCUOTCREDITO **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }

    /* EXEC SQL PREPARE SQL_DELETE_FA_CUOTCREDITO FROM :szSQL_DELETE_FA_CUOTCREDITO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )62;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSQL_DELETE_FA_CUOTCREDITO;
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


    if( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n\t**  Error en SQL-PREPARE SQL_DELETE_FA_CUOTCREDITO **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }
    return(TRUE);
}

/* ******************************************************************************** */
/* main : Rutina principal */
/* ******************************************************************************** */
int main(int argc,char *argv[])
{
    char modulo[]="main";
    char szHostId[25]="";
    long lClieIniBD = 0L;
    long lClieFinBD = 0L;
    char szFechaInicio[20]="";

    ARGSENTRADA  stArgsEntrada;
    ESTADISTICAS stEstTiempo;

    memset(&stArgsEntrada,0,sizeof(ARGSENTRADA));
    memset(&stEstTiempo,0,sizeof(ESTADISTICAS));

    vfnIniciarEstProc(&stEstTiempo);

    /* 20051123: Informacion de la version de compilacion */
    printf("\n(II)\t*** procCuotas, Version de compilacion: [%s] - [%s] ***\n",__DATE__,__TIME__);

    if (!bfnValidaParametros (argc, argv, &stArgsEntrada))
        return (RET_ERROR_PARAMETROS);

    vfnImprimirArgsEntrada(CONSOLA,stArgsEntrada);

    if (!bfnAbreArchivosLog(stArgsEntrada.iModProceso,stArgsEntrada.lCodCiclFact,stArgsEntrada.iLogLevel))
        return (RET_ERROR_ARCHIVOSLOG);

    if (!ifnAcessoOracle(stArgsEntrada.szOraAccount,stArgsEntrada.szOraPasswd))
        return (RET_ERROR_ACCESSORA);

    /* Tomar fecha de inicio de proceso */
    if (!bfnSelectSysDate(szFechaInicio))
        return FALSE;
    strcpy(stArgsEntrada.szHoraInicProc, szFechaInicio);

    /*** Obtencion de rangos de clientes, si existen ***/
    if( (ifnGetHostId(szHostId))!=0 )
    {
        vDTrazasLog(modulo, "(AVISO) main(): No se rescatan datos de Rango de clientes desde base de datos\n"
                            "\t\tSe mantienen datos ingresados desde linea de comando (Si existen).", LOG05);
    }
    else
    {
        /*** Busqueda de rangos de clientes desde Base de Datos ***/
        vDTrazasLog(modulo,"(INFO) main(): Tratando de obtener Rangos de clientes desde Base de Datos...\n", LOG05);
        if( (iGetRangosHost(szHostId, stArgsEntrada.lCodCiclFact, &lClieIniBD, &lClieFinBD))==0 )
        {
            stArgsEntrada.lClienteIni = lClieIniBD;
            stArgsEntrada.lClienteFin = lClieFinBD;
            stArgsEntrada.bIngRngClientes = TRUE;
        }
        else
        {
            vDTrazasLog(modulo, "(AVISO) main(): No se rescatan datos de Rango de clientes desde base de datos\n"
                                "\t\tSe mantienen datos ingresados desde linea de comando (Si existen).", LOG05);
        }
    }

    stCiclo.lCodCiclFact = stArgsEntrada.lCodCiclFact;

    if(!bFindCiclFact(&stCiclo))
        return (FALSE);

    stArgsEntrada.iCodCiclo = stCiclo.iCodCiclo; 

    vfnImprimirArgsEntrada(TRAZASLOG,stArgsEntrada);

    if (!bfnPreparaQuerysBind())
        return(RET_ERROR_ACCESSORA-1);

    if (stArgsEntrada.iModProceso == MODO_PROCESO_GENERACION)
    {
        if (!bprocGenCuota(stArgsEntrada))
        {
            vDTrazasError(modulo,"\n(EE)\t%s Termino Anormal de Generacion de Cuotas \n", LOG03, cfnGetTime(1));
            vDTrazasLog  (modulo,"\n(EE)\t%s Termino Anormal de Generacion de Cuotas \n", LOG03, cfnGetTime(1));
            return (RET_ERROR_GENERACION);
        }
/*  rao: se separa del proceso de carga de cuotas, tambien se modifca el universo cCursor_Cliente_Cuotas */
/*        if ( !bprocCargaUltimoPago(stArgsEntrada))                                                                */
/*        {                                                                                                         */
/*            vDTrazasError(modulo,"\n(EE)\t%s Termino Anormal de Validacion de Package \n", LOG03, cfnGetTime(1)); */
/*            vDTrazasLog  (modulo,"\n(EE)\t%s Termino Anormal de Validacion de Package \n", LOG03, cfnGetTime(1)); */
/*            return (RET_ERROR_GENERACION);                                                                        */
/*        }                                                                                                         */
    }

    if ((stArgsEntrada.iModProceso == MODO_PROCESO_HISTORICOS) && (!bprocHisCuota(stArgsEntrada)))
    {
        vDTrazasError(modulo,"\n(EE)\t%s Termino Anormal de Historico de Cuotas \n", LOG03, cfnGetTime(1));
        vDTrazasLog  (modulo,"\n(EE)\t%s Termino Anormal de Historico de Cuotas \n", LOG03, cfnGetTime(1));
        return (RET_ERROR_HISTORICO);
    }

    vfnImprimirEstProc(&stEstTiempo);

    fprintf(stdout,"\n");
    vDTrazasError(modulo,"\n(II)\t%s Termino Normal de la Aplicacion\n", LOG03, cfnGetTime(1));
    vDTrazasLog  (modulo,"\n(II)\t%s Termino Normal de la Aplicacion\n", LOG03, cfnGetTime(1));

    return (0);
} /********************************  Fin  main  *************************************/

/* ******************************************************************************** */
/* bfnValidaParametros : verifica los parametros de la invocacion  */
/* ******************************************************************************** */
BOOL bfnValidaParametros (  int     argc            ,
                            char    *argv[]          ,
                            ARGSENTRADA *pstArgsEntrada)
{
    extern char *optarg;
    extern int opterr, optopt;
    char opt[] = ":u:c:l:GHi:f:";
    int iOpt=0;
    char *psztmp = "";
    char szUser [64] = "";

    BOOL Userflag=FALSE;
    BOOL ModGenflag=FALSE;
    BOOL ModHisflag=FALSE;
    BOOL Cicflag=FALSE;
    BOOL Logflag=FALSE;
    BOOL bClieIniFlag=FALSE;
    BOOL bClieFinFlag=FALSE;

    opterr=0;

    if(argc == 1)
    {
        fprintf (stderr,"\n(EE)\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
        return (FALSE);
    }

    while ( (iOpt = getopt(argc, argv , opt) ) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
                if(Userflag==FALSE)
                {
                    strcpy(szUser, optarg);
                    Userflag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n(EE)\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'G':
                if(ModGenflag==FALSE)
                {
                    pstArgsEntrada->iModProceso = MODO_PROCESO_GENERACION;
                    ModGenflag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n(EE)\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'H':
                if(ModHisflag==FALSE)
                {
                    pstArgsEntrada->iModProceso = MODO_PROCESO_HISTORICOS;
                    ModHisflag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n(EE)\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'c':
                if(Cicflag==FALSE)
                {
                    pstArgsEntrada->lCodCiclFact=atol(optarg);
                    Cicflag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n(EE)\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'l':
                if(Logflag==FALSE)
                {
                    pstArgsEntrada->iLogLevel=atoi(optarg);
                    Logflag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n(EE)\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'i':
                pstArgsEntrada->lClienteIni = atol(optarg);
                bClieIniFlag = TRUE;
                break;

            case 'f':
                pstArgsEntrada->lClienteFin = atol(optarg);
                bClieFinFlag = TRUE;
                break;

            case '?':
                fprintf(stdout,"\n(EE)\t<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
                return (FALSE);

            case ':':
                fprintf(stdout,"\n(EE)\t<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
                return (FALSE);
        }/* endswitch */
    } /* enwhile */

    if ((ModGenflag == FALSE)  && (ModHisflag == FALSE))
    {
        fprintf (stderr,"\n(EE)\t<< Error : falta opcion '-G' o '-H' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if ((ModGenflag == TRUE)  && (ModHisflag == TRUE))
    {
        fprintf (stderr,"\n(EE)\t<< Opciones Excluyentes '-G' y '-H' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if(Cicflag==FALSE)
    {
        fprintf (stderr,"\n(EE)\t<< Error : falta opcion '-c' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if(Userflag==TRUE)
    {
        if ( (psztmp=(char *)strstr(szUser,"/") )==(char *)NULL )
        {
            fprintf (stderr,"\n(EE)\t<< Error : usuario no valido. Requiere \"/\" >>\n%s\n",szUsage);
            return (FALSE);
        }
        else
        {
            strncpy (pstArgsEntrada->szOraAccount,szUser,psztmp-szUser);
            strcpy  (pstArgsEntrada->szOraPasswd, psztmp+1);
        }
    }

    if(Logflag==FALSE)
    {
        fprintf (stderr,"\n(EE)\t<< Error : falta opcion '-l' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if( (bClieIniFlag==TRUE && bClieFinFlag==FALSE) || (bClieIniFlag==FALSE && bClieFinFlag==TRUE))
    {
        fprintf (stderr,"\n(EE)\t<< Error : falta opcion '-i' o '-f' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if((bClieIniFlag==TRUE && bClieFinFlag==TRUE))
        pstArgsEntrada->bIngRngClientes = TRUE;
    else
        pstArgsEntrada->bIngRngClientes = FALSE;

    if(pstArgsEntrada->lClienteIni - pstArgsEntrada->lClienteFin > 0L)
    {
        fprintf (stderr,"(EE)\t<< Error : Cliente inicial debe ser menor a Cliente final >>\n%s\n",szUsage);
        return (FALSE);
    }
    return (TRUE); /* Validacion ok */
} /***************************  Fin  bfnValidaParametros  ***************************/


/* ******************************************************************************** */
/* ifnAcessoOracle : Se conecta y trabaja sobre la base de Datos */
/* ******************************************************************************** */
BOOL ifnAcessoOracle(char    *szOraAccount  ,
                     char    *szOraPasswd   )
{
    char    modulo[]="ifnAcessoOracle";

    char    szUsuario[64]="";
    char    szAux[16]="";
    char    *psztmp = "";
    char    szhNomUsuarOra[32]="";
    char    szhPasUsuarOra[32]="";

    strcpy(szhNomUsuarOra,szOraAccount);
    strcpy(szhPasUsuarOra,szOraPasswd);

/*  Formateo adecuado del Usuario/Password recuperado de la base */
    memset(szUsuario,0,sizeof(szUsuario));

    if ( (psztmp=(char *)strstr(szhNomUsuarOra,"\\$") )!=(char *)NULL )
    {
        sprintf(szUsuario,"%s/%s",szhNomUsuarOra,szhPasUsuarOra);
    }
    else if ((psztmp=(char *)strchr(szhNomUsuarOra,'$') )!=(char *)NULL )
    {
        memset(szAux,0,sizeof(szAux));
        strncpy (szAux,szhNomUsuarOra,psztmp-szhNomUsuarOra);
        sprintf (szUsuario,"%s\\%s/%s",szAux,psztmp,szhPasUsuarOra);
    }
    else
    {
        sprintf(szUsuario,"%s/%s",szhNomUsuarOra,szhPasUsuarOra);
    }

    if (!fnOraConnect(szOraAccount,szOraPasswd))
    {
        vDTrazasError(modulo, " No Hay Conexion a la Base de Datos", LOG01);
        return (FALSE);
    }
    vDTrazasLog(modulo,"(II)\t%s Conectado a la Base de Datos", LOG03, cfnGetTime(1));
    return (TRUE);
} /*********************************  Fin  ifnAcessoOracle *******************************/



/* ************************************************************************************* */
/* bfnAbreArchivosLog                                                                    */
/* ************************************************************************************* */
BOOL bfnAbreArchivosLog(    int     iModProceso     ,
                            long    lCodCiclFact    ,
                            int     iLogLevel       )
{
    char modulo[]="bfnAbreArchivosLog";

    char *pathDir;
    char szArchivo[52]="";
    char szPath[128]="";
    char szComando[128]="";

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"procCuotas_%3s_%s",(iModProceso == MODO_PROCESO_GENERACION? "Gen":"His"),cfnGetTime(5));

    pathDir=(char *)malloc(128);
    pathDir=szGetEnv("XPF_LOG");
    sprintf(szPath,"%s/procCuotas/%ld",pathDir,lCodCiclFact);
    free(pathDir);

    fprintf( stdout, "\n\tCrea Directorio Log  : %s\n", szPath);
    sprintf(szComando,"mkdir -p %s", szPath);
    system (szComando);

    fprintf( stdout, "\n\tCrea Archivo Log/Err : %s\n\n", szArchivo);

    stStatus.LogNivel = iLogLevel;

    sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
    if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
    {
        fprintf( stderr, "\n\t<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
        return (FALSE);
    }

    vDTrazasError(modulo, "(II)\t%s << Abre Archivo de Errores >>", LOG03, cfnGetTime(1));

    sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
    if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
    {
        fprintf(stderr, "\n\t<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
        vDTrazasError(modulo, " << No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return (FALSE);
    }

    vDTrazasLog(modulo, "(II)\t%s << Abre Archivo de Log >>", LOG03, cfnGetTime(1));
    return (TRUE);
}
/****************************    Fin bfnAbreArchivosLog   ******************************/

/* ******************************************************************************** */
/*  bprocGenCuota()  : Generacion de Cuotas                                         */
/* ******************************************************************************** */
BOOL bprocGenCuota(ARGSENTRADA stArgsEntrada)
{
    char    modulo[]   = "bprocGenCuota"    ;
    char    szFecha[20]= ""                 ;
    int     iSqlCodeInt= SQLOK              ;
    long    lCodCliente=0                   ;
    CUOTCREDITOCLIENTE  stCuotasCliente     ;
    /********************************************************************************/

    if (!bfnWrapperValidaTrazaProc(stArgsEntrada.lCodCiclFact, iPROC_GENCUOTAS, iIND_FACT_ENPROCESO))
        return (FALSE);

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        return (FALSE);
    }
    bfnWrapperSelectTrazaProc (stArgsEntrada.lCodCiclFact, iPROC_GENCUOTAS, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);

    if (!bfnDeleteFaCuotCredito(stArgsEntrada))
        return (FALSE);

    iSqlCodeInt = ifnOpenClientesFaCicloCli(stArgsEntrada);

    while ( iSqlCodeInt == SQLOK )
    {
        lCodCliente=0;
        iSqlCodeInt = ifnFetchClienteFaCicloCli(&lCodCliente);

        if (iSqlCodeInt == SQLOK)
        {
            vDTrazasLog  (modulo,"\n\t** Procesando Cliente [%ld]",LOG03, lCodCliente);
            memset(&stCuotasCliente, 0 , sizeof(CUOTCREDITOCLIENTE));

            if (!bCargaCuotasClienteCartera(stArgsEntrada.lCodCiclFact,lCodCliente,&stCuotasCliente))
                return (FALSE);

            if (stCuotasCliente.iNumCuotasCliente > 0)
            {
                if (!bfnClienteDeBajaInter(stArgsEntrada.lCodCiclFact,lCodCliente,&stCuotasCliente))
                    return (FALSE);

                if (!bfnInsertCuotasFaCuotCredito(stCuotasCliente))
                    return (FALSE);
            }
        }
    }

    if (!bfnCloseClienteFaCicloCli())
        return (FALSE);

    if (!bfnSelectSysDate(szFecha))
        return FALSE;

    if (iSqlCodeInt != SQLNOTFOUND )
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecInicio,stArgsEntrada.szHoraInicProc);
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion de Cuotas Termino con Error");
    }
    else
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_OK;
        strcpy(stTrazaProc.szFecInicio,stArgsEntrada.szHoraInicProc);
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion de Cuotas Terminado OK");
    }

    bPrintTrazaProc(stTrazaProc);

    if(!bfnWrapperUpdateTrazaProc(stTrazaProc))
        return FALSE;

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        return FALSE;
    }
    return (TRUE);
}/*********************************** Fin bprocGenCuota *****************************/


/* **********************************************************************************/
/*  ifnOpenClientesFaCicloCli()  : Abre Cursor de Clietes                           */
/* ******************************************************************************** */
int ifnOpenClientesFaCicloCli(ARGSENTRADA stArgsEnt)
{
    char modulo[]   = "ifnOpenClientesFaCicloCli";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact    = 0L;
        int  ihIndMascara     = 1 ;
        long lhRngIniClie     = 0L;
        long lhRngFinClie     = 0L;
        int  ihIngRngClientes = 0 ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,   "(II) **(ifnOpenClientesFaCicloCli), Parametros de entrada:"
                            "\n\tCod_CiclFact    : [%ld]"
                            "\n\tlClienteIni     : [%ld]"
                            "\n\tlClienteFin     : [%ld]"
                            "\n\tbIngRngClientes : [%ld]"
                            , LOG05
                            , stArgsEnt.lCodCiclFact
                            , stArgsEnt.lClienteIni
                            , stArgsEnt.lClienteFin
                            , stArgsEnt.bIngRngClientes);

    lhCodCiclFact  = stArgsEnt.lCodCiclFact;
    lhRngIniClie   = stArgsEnt.lClienteIni;
    lhRngFinClie   = stArgsEnt.lClienteFin;

    ihIngRngClientes = (stArgsEnt.bIngRngClientes == TRUE)?1:0;

    vDTrazasLog  (modulo,"(II) **(ifnOpenClientesFaCicloCli), ihIngRngClientes : [%d]", LOG05, ihIngRngClientes);

    glhCodCicloFact   =  lhCodCiclFact;
    glhRngIniClie     =  lhRngIniClie ;
    glhRngFinClie     =  lhRngFinClie ;
    gihIndMascara     =  ihIndMascara;
    gihIngRngClientes =  ihIngRngClientes;
    gihCodCiclo       =  stArgsEnt.iCodCiclo;
    giMinNumCuotas    =  MIN_CUOTASCREDITOCLIENTE;

    /* EXEC SQL OPEN cCursor_Cliente_Cuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )81;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&gihCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&gihIndMascara;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&glhRngIniClie;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&glhRngFinClie;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&gihIngRngClientes;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&giMinNumCuotas;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (modulo," ** No Existen Datos en cCursor_Cliente_Cuotas **",LOG01);
        vDTrazasError(modulo," ** No Existen Datos en cCursor_Cliente_Cuotas **",LOG01);
        return (SQLCODE);
    }

    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en Open cCursor_Cliente_Cuotas **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en Open cCursor_Cliente_Cuotas **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }
    vDTrazasLog  (modulo," (ifnOpenClientesFaCicloCli) Cantidad de clientes cargados: [%d] **",LOG05, sqlca.sqlerrd[2]);
    return (SQLCODE);
}/*************************** Fin ifnOpenClientesFaCicloCli ************************/


/* ******************************************************************************** */
/*  ifnFetchClienteFaCicloCli()  : Fetch de Cliente                               */
/* ******************************************************************************** */
int ifnFetchClienteFaCicloCli(long *lCodCliente)
{
    char modulo[]   = "ifnFetchClienteFaCicloCli";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCliente;
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL FETCH cCursor_Cliente_Cuotas INTO :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )120;
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Fecth Cursor cCursor_Cliente_Cuotas %s ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Fecth Cursor cCursor_Cliente_Cuotas %s ",LOG01,SQLERRM);
    }

    if( SQLCODE == SQLOK )
        *lCodCliente = lhCodCliente;

    return (SQLCODE);
}/************************* Fin ifnFetchClienteFaCicloCli *************************/


/* ******************************************************************************** */
/*  bfnCloseClienteFaCicloCli()  : Cierra Cursor de Clientes                      */
/* ******************************************************************************** */
BOOL bfnCloseClienteFaCicloCli(void)
{
    char modulo[]   = "bfnCloseClienteFaCicloCli";

    /* EXEC SQL CLOSE cCursor_Cliente_Cuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )139;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/************************* Fin bfnCloseClienteFaCicloCli *************************/



/* ******************************************************************************** */
/*  bfnDeleteFaCuotCredito()  : Elimina Cuotas del Ciclo  antes de Cargar             */
/* ******************************************************************************** */
BOOL bfnDeleteFaCuotCredito (/*long lCodCicloFact*/ ARGSENTRADA stArgsEnt)
{
    char modulo[]   = "bfnDeleteFaCuotCredito";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact;
        long lhRngIniClie = 0L;
        long lhRngFinClie = 0L;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCiclFact = stArgsEnt.lCodCiclFact  ;

    vDTrazasLog  (modulo,"\n\t**(bfnDeleteFaCuotCredito) Eliminando Cuotas Cargadas...", LOG03);

    if(stArgsEnt.bIngRngClientes == FALSE)
    {
        /* EXEC SQL
            DELETE
            FROM    FA_CUOTCREDITO
            WHERE   COD_CICLFACT = :lhCodCiclFact; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from FA_CUOTCREDITO  where COD_CICLFACT=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )154;
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


    }
    else
    {
        lhRngIniClie = stArgsEnt.lClienteIni;
        lhRngFinClie = stArgsEnt.lClienteFin;

        /* EXEC SQL
            DELETE
            FROM    FA_CUOTCREDITO
            WHERE   COD_CICLFACT = :lhCodCiclFact
            AND     COD_CLIENTE BETWEEN :lhRngIniClie  AND :lhRngFinClie; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from FA_CUOTCREDITO  where (COD_CICLFACT=:b0 \
and COD_CLIENTE between :b1 and :b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )173;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhRngIniClie;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhRngFinClie;
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


    }

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en Delete en FA_CUOTCREDITO **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en Delete en FA_CUOTCREDITO **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/***************************** Fin bfnDeleteFaCuotCredito ****************************/

/* ******************************************************************************** */
/*  bCargaCuotasClienteCartera()  : Carga Cuotas del Cliente en Memoria                    */
/* ******************************************************************************** */

BOOL bCargaCuotasClienteCartera(long lCodCiclFact, long lCodCliente, CUOTCREDITOCLIENTE *pstCuotasCliente)
{
    char    modulo[]= "bCargaCuotasClienteCartera";
    int     i=0;
    int     iNumCuotas;

    sprintf(gszFormatoFec, "YYYYMMDDHH24MISS");
    giCero = 0;
    glhCodCliente =  lCodCliente             ;
    giMinNumCuotas=  MIN_CUOTASCREDITOCLIENTE;


    vDTrazasLog  (modulo,"\t\t**(bCargaCuotasClienteCartera) Cargando Cuotas en Memoria Cliente [%ld]", LOG04,glhCodCliente);

    /* EXEC SQL OPEN CURSOR_SELECT_CO_CARTERA ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )200;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)gszFormatoFec;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)gszFormatoFec;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&giCero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&glhCodCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&giMinNumCuotas;
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
        vDTrazasError(modulo,"\n Error en SQL OPEN CURSOR_SELECT_CO_CARTERA"
                             "\n [%d]  [%s]\n", LOG05,SQLCODE,SQLERRM);
        vDTrazasLog(modulo,"\n << Error en SQL OPEN CURSOR_SELECT_CO_CARTERA>>",LOG05);
        return  (FALSE);
    }

    /* EXEC SQL FETCH CURSOR_SELECT_CO_CARTERA INTO :glahNumSecuenci         ,
                                                 :giahCodTipDocum         ,
                                                 :glahCodVendedorAgente   ,
                                                 :gszahLetra              ,
                                                 :giahCodCentremi         ,
                                                 :giahCodConcepto         ,
                                                 :giahColumna             ,
                                                 :giahNumCuota            ,
                                                 :giahSecCuota            ,
                                                 :giahIndFacturado        ,
                                                 :gszahFecVencimie        ,
                                                 :gszahNumFolioCTC        ,
                                                 :gdahMtoCuota            ,
                                                 :gszahFecCompra          ,
                                                 :glahNum_Folio           ,
                                                 :gszhPref_Plaza          ,
                                                 :glahNumAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )235;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)glahNumSecuenci;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)giahCodTipDocum;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)glahCodVendedorAgente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)gszahLetra;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )4;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)giahCodCentremi;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)giahCodConcepto;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )sizeof(int);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)giahColumna;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)giahNumCuota;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )sizeof(int);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)giahSecCuota;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )sizeof(int);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)giahIndFacturado;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )sizeof(int);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)gszahFecVencimie;
    sqlstm.sqhstl[10] = (unsigned long )22;
    sqlstm.sqhsts[10] = (         int  )24;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)gszahNumFolioCTC;
    sqlstm.sqhstl[11] = (unsigned long )14;
    sqlstm.sqhsts[11] = (         int  )16;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)gdahMtoCuota;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[12] = (         int  )sizeof(double);
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)gszahFecCompra;
    sqlstm.sqhstl[13] = (unsigned long )22;
    sqlstm.sqhsts[13] = (         int  )24;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)glahNum_Folio;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[14] = (         int  )sizeof(long);
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqharc[14] = (unsigned long  *)0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)gszhPref_Plaza;
    sqlstm.sqhstl[15] = (unsigned long )13;
    sqlstm.sqhsts[15] = (         int  )16;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqharc[15] = (unsigned long  *)0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)glahNumAbonado;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[16] = (         int  )sizeof(long);
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqharc[16] = (unsigned long  *)0;
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



    iNumCuotas = sqlca.sqlerrd[2];

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Select de Cuotas en CO_CARTERA [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Select de Cuotas en CO_CARTERA [%s]",LOG01,SQLERRM);
        return (FALSE);
    }
    if( SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(modulo,"** Cantidad de Cuotas Exede Maximi Permitido [%d] > [%d]"
                            ,LOG01,SQLROWS,MAX_CUOTASCREDITOCLIENTE);
        vDTrazasLog  (modulo,"** Cantidad de Cuotas Exede Maximi Permitido [%d] > [%d]"
                            ,LOG01,SQLROWS,MAX_CUOTASCREDITOCLIENTE);
        return (FALSE);
    }

    /* EXEC SQL CLOSE CURSOR_SELECT_CO_CARTERA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )318;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n Error en SQL CLOSE CURSOR_SELECT_CO_CARTERA"
                             "\n [%d]  [%s]\n", LOG05,SQLCODE,SQLERRM);
        vDTrazasLog(modulo,"\n << Error en SQL CLOSE CURSOR_SELECT_CO_CARTERA>>",LOG05);
        return  (FALSE);
    }

    for (i=0;i<iNumCuotas;i++)
    {
        pstCuotasCliente->iNumCuotasCliente++;
        pstCuotasCliente->stRegCuota[i].lCodCliente         =   lCodCliente              ;
        pstCuotasCliente->stRegCuota[i].lNumSecuenci        =   glahNumSecuenci        [i];
        pstCuotasCliente->stRegCuota[i].iCodTipDocum        =   giahCodTipDocum        [i];
        pstCuotasCliente->stRegCuota[i].lCodVendedorAgente  =   glahCodVendedorAgente  [i];
        sprintf(pstCuotasCliente->stRegCuota[i].szLetra,"%.*s\0",gszahLetra      [i].len, gszahLetra      [i].arr);
        pstCuotasCliente->stRegCuota[i].iCodCentremi        =   giahCodCentremi        [i];
        pstCuotasCliente->stRegCuota[i].iCodConcepto        =   giahCodConcepto        [i];
        pstCuotasCliente->stRegCuota[i].iColumna            =   giahColumna            [i];
        pstCuotasCliente->stRegCuota[i].iNumCuota           =   giahNumCuota           [i];
        pstCuotasCliente->stRegCuota[i].iSecCuota           =   giahSecCuota           [i];
        pstCuotasCliente->stRegCuota[i].lCodCiclFact        =   lCodCiclFact             ;
        pstCuotasCliente->stRegCuota[i].iIndFacturado       =   giahIndFacturado       [i];
        sprintf(pstCuotasCliente->stRegCuota[i].szFecVencimie,"%.*s\0",gszahFecVencimie[i].len, gszahFecVencimie[i].arr);
        sprintf(pstCuotasCliente->stRegCuota[i].szNumFolioCTC,"%.*s\0",gszahNumFolioCTC[i].len, gszahNumFolioCTC[i].arr);
        pstCuotasCliente->stRegCuota[i].dMtoCuota           =   gdahMtoCuota           [i];
        sprintf(pstCuotasCliente->stRegCuota[i].szFecCompra  ,"%.*s\0",gszahFecCompra  [i].len, gszahFecCompra  [i].arr);
        pstCuotasCliente->stRegCuota[i].lNum_Folio          =   glahNum_Folio          [i];
        sprintf(pstCuotasCliente->stRegCuota[i].szPrefPlaza,"%.*s\0",gszhPref_Plaza[i].len, gszhPref_Plaza[i].arr);
        pstCuotasCliente->stRegCuota[i].lNumAbonado         =   glahNumAbonado         [i];    /* 20051123 */
    }
    vDTrazasLog  (modulo,"\t\t\t**Total Cuotas [%d]", LOG05,iNumCuotas);
    return (TRUE);
}/***************************** Fin bCargaCuotasClienteCartera  ****************************/


/* ******************************************************************************** */
/*  bfnClienteDeBajaInter()  : Valida Si Cliente esta de Baja                            */
/* ******************************************************************************** */

BOOL bfnClienteDeBajaInter(long lCodCiclFact, long lCodCliente, CUOTCREDITOCLIENTE *pstCuotasCliente)
{
    char modulo[]   = "bfnClienteDeBajaInter" ;

    CUOTCREDITOCLIENTE stmpCuotas           ;
    int i,j;

    /* EXEC SQL BEGIN DECLARE SECTION          ; */ 

        int     ihAltaCliente               ;
    /* EXEC SQL END DECLARE SECTION            ; */ 


    vDTrazasLog  (modulo,   "\t\t**(bfnClienteDeBajaInter) Valida Si Cliente esta de Baja "
                            "\n\t\t\t**  Ciclo Facturacion  [%ld]"
                            "\n\t\t\t**  Cliente            [%ld]"
                            "\n\t\t\t**  Ind_Actuac         [%d]"
                            ,LOG04 ,lCodCiclFact, lCodCliente, NORMAL);

    /** CO-0062 21.04.2006 **/

    glhCodCliente    = lCodCliente ;
    gihIndActuacAlta = NORMAL      ;
    giUno            = 1;
    giCero           = 0;

    /** CO-0062 21.04.2006 **/

    /* EXEC SQL OPEN CURSOR_INFACCEL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )333;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&giUno;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&glhCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&giCero;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&glhCodCicloFact;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&gihIndActuacAlta;
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
        vDTrazasError(modulo,"\n Error en SQL OPEN CURSOR_INFACCEL"
                             "\n [%d]  [%s]\n", LOG05,SQLCODE,SQLERRM);
        vDTrazasLog(modulo,"\n << Error en SQL OPEN CURSOR_INFACCEL>>",LOG05);
        return  (FALSE);
    }

    /* EXEC SQL FETCH CURSOR_INFACCEL INTO :ihAltaCliente ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )368;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihAltaCliente;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n Error en SQL FETCH CURSOR_INFACCEL"
                             "\n [%d]  [%s]\n", LOG05,SQLCODE,SQLERRM);
        vDTrazasLog(modulo,"\n << Error en SQL FETCH CURSOR_INFACCEL>>",LOG05);
        return  (FALSE);
    }

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Select de Abonados en INFACCEL-INFACBEEP [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Select de Abonados en INFACCEL-INFACBEEP [%s]",LOG01,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL CLOSE CURSOR_INFACCEL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )387;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n Error en SQL CLOSE CURSOR_INFACCEL"
                             "\n [%d]  [%s]\n", LOG05,SQLCODE,SQLERRM);
        vDTrazasLog(modulo,"\n << Error en SQL CLOSE CURSOR_INFACCEL>>",LOG05);
        return  (FALSE);
    }

    memset(&stmpCuotas,0,sizeof(CUOTCREDITOCLIENTE));

    vDTrazasLog  (modulo,"\t\t\t**(bfnClienteDeBajaInter) Cliente Con [%d] Abonados de Alta [%s]"
                        ,LOG04,ihAltaCliente,stCiclo.szFecEmision);

    if (ihAltaCliente > 0)      /*  Cliente con al menos un Abonado de Aalta    */
    {                           /*  Eliminar Registros de Cuotas No Vencidas    */
        for (i=0;i<pstCuotasCliente->iNumCuotasCliente;i++)
        {
            vDTrazasLog  (modulo,"\t\t\t\ti=[%d], pstCuotasCliente->stRegCuota[i].szFecVencimie :[%s] , stCiclo.szFecEmision:[%s]"
                                ,LOG05,i,pstCuotasCliente->stRegCuota[i].szFecVencimie, stCiclo.szFecEmision);
            if (strcmp(pstCuotasCliente->stRegCuota[i].szFecVencimie,stCiclo.szFecEmision) <= 0)
            {
                vDTrazasLog  (modulo,"\t\t\t\ti=[%d] => [%s] <= [%s]"
                                    ,LOG05,i,pstCuotasCliente->stRegCuota[i].szFecVencimie, stCiclo.szFecEmision);
                j=stmpCuotas.iNumCuotasCliente;
                stmpCuotas.stRegCuota[j].lCodCliente            = pstCuotasCliente->stRegCuota[i].lCodCliente         ;
                stmpCuotas.stRegCuota[j].lNumSecuenci           = pstCuotasCliente->stRegCuota[i].lNumSecuenci        ;
                stmpCuotas.stRegCuota[j].iCodTipDocum           = pstCuotasCliente->stRegCuota[i].iCodTipDocum        ;
                stmpCuotas.stRegCuota[j].lCodVendedorAgente     = pstCuotasCliente->stRegCuota[i].lCodVendedorAgente  ;
                strcpy(stmpCuotas.stRegCuota[j].szLetra         , pstCuotasCliente->stRegCuota[i].szLetra            );
                stmpCuotas.stRegCuota[j].iCodCentremi           = pstCuotasCliente->stRegCuota[i].iCodCentremi        ;
                stmpCuotas.stRegCuota[j].iCodConcepto           = pstCuotasCliente->stRegCuota[i].iCodConcepto        ;
                stmpCuotas.stRegCuota[j].iColumna               = pstCuotasCliente->stRegCuota[i].iColumna            ;
                stmpCuotas.stRegCuota[j].iNumCuota              = pstCuotasCliente->stRegCuota[i].iNumCuota           ;
                stmpCuotas.stRegCuota[j].iSecCuota              = pstCuotasCliente->stRegCuota[i].iSecCuota           ;
                stmpCuotas.stRegCuota[j].lCodCiclFact           = pstCuotasCliente->stRegCuota[i].lCodCiclFact        ;
                stmpCuotas.stRegCuota[j].iIndFacturado          = pstCuotasCliente->stRegCuota[i].iIndFacturado       ;
                strcpy(stmpCuotas.stRegCuota[j].szFecVencimie   , pstCuotasCliente->stRegCuota[i].szFecVencimie      );
                strcpy(stmpCuotas.stRegCuota[j].szNumFolioCTC   , pstCuotasCliente->stRegCuota[i].szNumFolioCTC      );
                stmpCuotas.stRegCuota[j].dMtoCuota              = pstCuotasCliente->stRegCuota[i].dMtoCuota           ;
                strcpy(stmpCuotas.stRegCuota[j].szFecCompra     , pstCuotasCliente->stRegCuota[i].szFecCompra        );
                stmpCuotas.stRegCuota[j].lNum_Folio             = pstCuotasCliente->stRegCuota[i].lNum_Folio          ;
                strcpy(stmpCuotas.stRegCuota[j].szPrefPlaza     , pstCuotasCliente->stRegCuota[i].szPrefPlaza        );
                stmpCuotas.stRegCuota[j].lNumAbonado            = pstCuotasCliente->stRegCuota[i].lNumAbonado         ;
                stmpCuotas.iNumCuotasCliente++;
            }
        }
        /*** CO-0062 21.04.2006
             Si el cliente no tiene cuotas vencidas o por vencer en el ciclo se ingresa un registro dummy
             a la FA_CUOTCREDITO para mostrar el registro A1250 **/
        if (stmpCuotas.iNumCuotasCliente == 0)
        {
            j=stmpCuotas.iNumCuotasCliente;
            stmpCuotas.stRegCuota[j].lCodCliente            = pstCuotasCliente->stRegCuota[0].lCodCliente         ;
            stmpCuotas.stRegCuota[j].lNumSecuenci           = pstCuotasCliente->stRegCuota[0].lNumSecuenci        ;
            stmpCuotas.stRegCuota[j].iCodTipDocum           = pstCuotasCliente->stRegCuota[0].iCodTipDocum        ;
            stmpCuotas.stRegCuota[j].lCodVendedorAgente     = pstCuotasCliente->stRegCuota[0].lCodVendedorAgente  ;
            strcpy(stmpCuotas.stRegCuota[j].szLetra         , pstCuotasCliente->stRegCuota[0].szLetra            );
            stmpCuotas.stRegCuota[j].iCodCentremi           = pstCuotasCliente->stRegCuota[0].iCodCentremi        ;
            stmpCuotas.stRegCuota[j].iCodConcepto           = pstCuotasCliente->stRegCuota[0].iCodConcepto        ;
            stmpCuotas.stRegCuota[j].iColumna               =  -1                                                 ;
            stmpCuotas.stRegCuota[j].iNumCuota              = pstCuotasCliente->stRegCuota[0].iNumCuota           ;
            stmpCuotas.stRegCuota[j].lCodCiclFact           = pstCuotasCliente->stRegCuota[0].lCodCiclFact        ;
            stmpCuotas.stRegCuota[j].iIndFacturado          = 2                                                   ;
            strcpy(stmpCuotas.stRegCuota[j].szFecVencimie   , stCiclo.szFecDesdeLlam                             );
            strcpy(stmpCuotas.stRegCuota[j].szNumFolioCTC   , pstCuotasCliente->stRegCuota[0].szNumFolioCTC      );
            stmpCuotas.stRegCuota[j].dMtoCuota              = 0                                                   ;
            strcpy(stmpCuotas.stRegCuota[j].szFecCompra     , pstCuotasCliente->stRegCuota[0].szFecCompra        );
            stmpCuotas.stRegCuota[j].lNum_Folio             = pstCuotasCliente->stRegCuota[0].lNum_Folio          ;
            strcpy(stmpCuotas.stRegCuota[j].szPrefPlaza     , pstCuotasCliente->stRegCuota[0].szPrefPlaza        );
            stmpCuotas.stRegCuota[j].lNumAbonado            = pstCuotasCliente->stRegCuota[0].lNumAbonado         ;
            stmpCuotas.iNumCuotasCliente++;
        }
        /*** CO-0062 21.04.2006 ***/
        memcpy(pstCuotasCliente , &stmpCuotas , sizeof(CUOTCREDITOCLIENTE));
    }
    return (1);
}/*****************************   Fin bfnClienteDeBajaInter   ****************************/



/* ******************************************************************************** */
/*  bfnInsertCuotasFaCuotCredito()  : Inserta Cuotas del Cliente FA_CUOTCREDITO           */
/* ******************************************************************************** */

BOOL bfnInsertCuotasFaCuotCredito(CUOTCREDITOCLIENTE pstCuotasCliente)
{
    char modulo[]   = "bfnInsertCuotasFaCuotCredito";
    int  i = 0;
    int	iSecAux=0;

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        long    lhCodCliente       ;
        long    lhNumSecuenci      ;
        int     ihCodTipDocum      ;
        long    lhCodVendedorAgente;
        char    szhLetra        [2];    /* EXEC SQL VAR szhLetra       IS STRING (2); */ 

        int     ihCodCentremi      ;
        int     ihCodConcepto      ;
        int     ihColumna          ;
        int     ihNumCuota         ;
        int     ihSecCuota         ;
        long    lhCodCiclFact      ;
        int     ihIndFacturado     ;
        char    szhFecVencimie [20];    /* EXEC SQL VAR szhFecVencimie IS STRING (20); */ 

        char    szhNumFolioCTC [12];    /* EXEC SQL VAR szhNumFolioCTC IS STRING (12); */ 

        double  dhMtoCuota         ;
        char    szhFecCompra   [20];    /* EXEC SQL VAR szhFecCompra   IS STRING (20); */ 

        int     ihIndImpreso       ;
        long    ihIndOrdentotal    ;
        long    lhNum_Folio        ;
        char    szhPref_Plaza   [11];    /* EXEC SQL VAR szhPref_Plaza   IS STRING (11); */ 

        long    lhNumAbonado= 0L    ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    vDTrazasLog  (modulo,"\t\t**(bfnInsertCuotasFaCuotCredito) Inserta Cuotas de en FA_CUOTCREDITO [%d]"
                        , LOG04, pstCuotasCliente.iNumCuotasCliente);


    /* PGG SOPORTE CO-084 28-04-2006 */
    if (pstCuotasCliente.iNumCuotasCliente > 0)
    {
        iSecAux = pstCuotasCliente.stRegCuota[0].iSecCuota;
        for (i=0;i<pstCuotasCliente.iNumCuotasCliente;i++)
        {
             if (pstCuotasCliente.stRegCuota[i].iSecCuota > iSecAux)
                  iSecAux = pstCuotasCliente.stRegCuota[i].iSecCuota;
        }
    }


    for (i=0;i<pstCuotasCliente.iNumCuotasCliente;i++)
    {
        lhCodCliente            =pstCuotasCliente.stRegCuota[i].lCodCliente         ;
        lhNumSecuenci           =pstCuotasCliente.stRegCuota[i].lNumSecuenci        ;
        ihCodTipDocum           =pstCuotasCliente.stRegCuota[i].iCodTipDocum        ;
        lhCodVendedorAgente     =pstCuotasCliente.stRegCuota[i].lCodVendedorAgente  ;
        strcpy(szhLetra         ,pstCuotasCliente.stRegCuota[i].szLetra             );
        ihCodCentremi           =pstCuotasCliente.stRegCuota[i].iCodCentremi        ;
        ihCodConcepto           =pstCuotasCliente.stRegCuota[i].iCodConcepto        ;
        ihColumna               =pstCuotasCliente.stRegCuota[i].iColumna            ;
        ihNumCuota              =pstCuotasCliente.stRegCuota[i].iNumCuota           ;
        ihSecCuota              =pstCuotasCliente.stRegCuota[i].iSecCuota           ;
        lhCodCiclFact           =pstCuotasCliente.stRegCuota[i].lCodCiclFact        ;
        ihIndFacturado          =pstCuotasCliente.stRegCuota[i].iIndFacturado       ;

	/* PGG SOPORTE CO-084 28-04-2006 */
        if (iSecAux == pstCuotasCliente.stRegCuota[i].iSecCuota)
            strcpy(szhFecVencimie   ,stCiclo.szFecVencimie);
        else
            strcpy(szhFecVencimie   ,pstCuotasCliente.stRegCuota[i].szFecVencimie       );

        strcpy(szhNumFolioCTC   ,pstCuotasCliente.stRegCuota[i].szNumFolioCTC       );
        dhMtoCuota              =pstCuotasCliente.stRegCuota[i].dMtoCuota           ;
        strcpy(szhFecCompra     ,pstCuotasCliente.stRegCuota[i].szFecCompra         );
        lhNum_Folio             =pstCuotasCliente.stRegCuota[i].lNum_Folio          ;
        strcpy(szhPref_Plaza    ,pstCuotasCliente.stRegCuota[i].szPrefPlaza         );/*PHB:agregue pref_plaza*/
        lhNumAbonado            =pstCuotasCliente.stRegCuota[i].lNumAbonado         ; /* 20051123 */
        /** CO-0062 21.04.2006 **/
        if (ihIndFacturado == 2) /* Si el registro corresponde a DUMMY */
        	ihIndImpreso 		= 2;
        else
	        ihIndImpreso        = 0;

        ihIndOrdentotal         = 0;

        vDTrazasLog  (modulo,"\n**Registro de Cuotas  [%d]"
                             "\n**lahIndOrdenTotal    [%d] => [%ld]   "
                             "\n**lahCodCliente       [%d] => [%ld]   "
                             "\n**lahNumSecuenci      [%d] => [%ld]   "
                             "\n**iahCodTipDocum      [%d] => [%d]    "
                             "\n**lahCodVendedorAgente[%d] => [%ld]   "
                             "\n**szahLetra           [%d] => [%s]    "
                             "\n**iahCodCentremi      [%d] => [%d]    "
                             "\n**iahCodConcepto      [%d] => [%d]    "
                             "\n**iahColumna          [%d] => [%d]    "
                             "\n**iahNumCuota         [%d] => [%d]    "
                             "\n**iahSecCuota         [%d] => [%d]    "
                             "\n**lahCodCiclFact      [%d] => [%ld]   "
                             "\n**iahIndFacturado     [%d] => [%d]    "
                             "\n**szahFecVencimie     [%d] => [%s]    "
                             "\n**szahNumFolioCTC     [%d] => [%s]    "
                             "\n**dahMtoCuota         [%d] => [%14.4f]"
                             "\n**szahFecCompra       [%d] => [%s]    "
                             "\n**lhNum_Folio         [%d] => [%ld]   "
                             "\n**szhPref_Plaza       [%d] => [%s]    "
                             "\n**lhNumAbonado        [%d] => [%ld]   "
                             "\n**ihIndImpreso        [%d] => [%d]    "
                             ,LOG05,i,i,ihIndOrdentotal
                             ,i,lhCodCliente
                             ,i,lhNumSecuenci
                             ,i,ihCodTipDocum
                             ,i,lhCodVendedorAgente
                             ,i,szhLetra
                             ,i,ihCodCentremi
                             ,i,ihCodConcepto
                             ,i,ihColumna
                             ,i,ihNumCuota
                             ,i,ihSecCuota
                             ,i,lhCodCiclFact
                             ,i,ihIndFacturado
                             ,i,szhFecVencimie
                             ,i,szhNumFolioCTC
                             ,i,dhMtoCuota
                             ,i,szhFecCompra
                             ,i,lhNum_Folio
                             ,i,szhPref_Plaza
                             ,i,lhNumAbonado
                             ,i,ihIndImpreso);

        /* EXEC SQL EXECUTE SQL_INSERT_FA_CUOTCREDITO USING :ihIndOrdentotal     ,
                                                         :lhCodCliente        ,
                                                         :lhNumSecuenci       ,
                                                         :ihCodTipDocum       ,
                                                         :lhCodVendedorAgente ,
                                                         :szhLetra            ,
                                                         :ihCodCentremi       ,
                                                         :ihCodConcepto       ,
                                                         :ihColumna           ,
                                                         :ihNumCuota          ,
                                                         :ihSecCuota          ,
                                                         :lhCodCiclFact       ,
                                                         :ihIndFacturado      ,
                                                         :szhFecVencimie      ,
                                                         :szhNumFolioCTC      ,
                                                         :dhMtoCuota          ,
                                                         :szhFecCompra        ,
                                                         :ihIndImpreso        ,
                                                         :lhNum_Folio         ,
                                                         :szhPref_Plaza       ,
                                                         :lhNumAbonado        ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )402;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihIndOrdentotal;
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
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorAgente;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
        sqlstm.sqhstl[5] = (unsigned long )2;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentremi;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&ihNumCuota;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&ihSecCuota;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&ihIndFacturado;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szhFecVencimie;
        sqlstm.sqhstl[13] = (unsigned long )20;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szhNumFolioCTC;
        sqlstm.sqhstl[14] = (unsigned long )12;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&dhMtoCuota;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szhFecCompra;
        sqlstm.sqhstl[16] = (unsigned long )20;
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&ihIndImpreso;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)&lhNum_Folio;
        sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)szhPref_Plaza;
        sqlstm.sqhstl[19] = (unsigned long )11;
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
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
            vDTrazasError(modulo," en Insert de Cuotas en FA_CUOTCREDITO [%s]",LOG01,SQLERRM);
            vDTrazasLog  (modulo," en Insert de Cuotas en FA_CUOTCREDITO [%s]",LOG01,SQLERRM);
            return (FALSE);
        }
    }
    return (TRUE);
}/***************************** Fin bfnInsertCuotasFaCuotCredito **************************/

/* ******************************************************************************** */
/*  bprocHisCuota()  : Historico de Cuotas                                          */
/* ******************************************************************************** */
BOOL bprocHisCuota(ARGSENTRADA stArgsEnt)
{
    char        modulo[]   = "bprocHisCuota";
    char        szFecha[20]= ""             ;
    int         iSqlCodeInt= SQLOK          ;
    CUOTCREDITO stCuotas                    ;

    if (!bfnWrapperValidaTrazaProc(stArgsEnt.lCodCiclFact, iPROC_HISTCUOTAS, iIND_FACT_ENPROCESO))
        return (FALSE);

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        return (FALSE);
    }

    bfnWrapperSelectTrazaProc (stArgsEnt.lCodCiclFact, iPROC_HISTCUOTAS, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);

    /********************************************************************************/
    /********************************************************************************/
    iSqlCodeInt = ifnOpenCuotasFaCuotCredito(stArgsEnt);
    while ( iSqlCodeInt == SQLOK )
    {
        memset(&stCuotas,0,sizeof(CUOTCREDITO));
        iSqlCodeInt = ifnFetchCuotaFaCuotCredito(&stCuotas);
        if (iSqlCodeInt == SQLOK)
        {
            vDTrazasLog  (modulo,"\n\t** Procesando Cliente [%ld]",LOG03,stCuotas.lCodCliente);

            if (stCuotas.iIndImpreso == IND_IMPRESO_OK)
                if (!bfnUpdateCuotaCartera(stCuotas))
                    return (FALSE);

            if (!bfnInsertHistCuotasCiclo(stCuotas))
                return (FALSE);

            if (!bfnDeleteHistCuotasCiclo(stCuotas))
                return (FALSE);
        }
    }

    if (!bfnCloseCuotasFaCuotCredito())
        return (FALSE);

    if (!bfnSelectSysDate(szFecha))
        return FALSE;

    if (iSqlCodeInt != SQLNOTFOUND )
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecInicio,stArgsEnt.szHoraInicProc);
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Historico de Cuotas Termino con Error");
    }
    else
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_OK;
        strcpy(stTrazaProc.szFecInicio,stArgsEnt.szHoraInicProc);
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Historico de Cuotas Terminado OK");
    }

    bPrintTrazaProc(stTrazaProc);

    if(!bfnWrapperUpdateTrazaProc(stTrazaProc))
        return (FALSE);

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        return FALSE;
    }

    return (TRUE);
}/*********************************** Fin bprocHisCuota *****************************/





/* ******************************************************************************** */
/*  ifnOpenCuotasFaCuotCredito()  : Abre Cursor de Cuotas                         */
/* ******************************************************************************** */
int ifnOpenCuotasFaCuotCredito(ARGSENTRADA stArgsEnt)
{
    char modulo[]   = "ifnOpenCuotasFaCuotCredito";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact  = stArgsEnt.lCodCiclFact;
        long lhRngIniClie   = stArgsEnt.lClienteIni;
        long lhRngFinClie   = stArgsEnt.lClienteFin;
        char szhSqlCad[2048]= "";
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t**(ifnOpenCuotasFaCuotCredito)  Cod_CiclFact [%ld]", LOG05,stArgsEnt.lCodCiclFact);

    sprintf(szhSqlCad,  "SELECT  ROWID               ,           "
                        "\n        COD_CLIENTE         ,         "
                        "\n        NUM_SECUENCI        ,         "
                        "\n        COD_TIPDOCUM        ,         "
                        "\n        COD_VENDEDOR_AGENTE ,         "
                        "\n        LETRA               ,         "
                        "\n        COD_CENTREMI        ,         "
                        "\n        COD_CONCEPTO        ,         "
                        "\n        COLUMNA             ,         "
                        "\n        NUM_CUOTA           ,         "
                        "\n        SEC_CUOTA           ,         "
                        "\n        COD_CICLFACT        ,         "
                        "\n        IND_FACTURADO       ,         "
                        "\n        FEC_VENCIMIE        ,         "
                        "\n        NUM_FOLIOCTC        ,         "
                        "\n        MTO_CUOTA           ,         "
                        "\n        FEC_COMPRA          ,         "
                        "\n        IND_IMPRESO         ,         "
                        "\n        NUM_FOLIO       ,             "
                        "\n        NVL(PREF_PLAZA, '0000000000') "
                        "\nFROM    FA_CUOTCREDITO  A             "
                        "\nWHERE   A.COD_CICLFACT  = :v1");

    if(stArgsEnt.bIngRngClientes == TRUE)
        strcat(szhSqlCad, "\nAND A.COD_CLIENTE BETWEEN :v2 AND :v3");

    vDTrazasLog  (modulo,"\n(II)\t**(ifnOpenCuotasFaCuotCredito)  Consulta SQL:\n[%s]", LOG05,szhSqlCad);

    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT = 'yyyymmddhh24miss'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'yyyymmddhh24miss'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )501;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /* EXEC SQL PREPARE sql_stmt_cuot_credito FROM :szhSqlCad; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )516;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhSqlCad;
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
        vDTrazasError(modulo, " en PREPARE sql_stmt_cuot_credito FROM :szhSqlCad **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " PREPARE sql_stmt_cuot_credito FROM :szhSqlCad **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }

    /* EXEC SQL DECLARE cCursor_Cuotas_CuotCredito CURSOR FOR  sql_stmt_cuot_credito; */ 


    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " DECLARE cCursor_Cuotas_CuotCredito CURSOR FOR  sql_stmt_cuot_credito **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " DECLARE cCursor_Cuotas_CuotCredito CURSOR FOR  sql_stmt_cuot_credito **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }

    if(stArgsEnt.bIngRngClientes == FALSE)
        /* EXEC SQL OPEN cCursor_Cuotas_CuotCredito USING :lhCodCiclFact; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )535;
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


    else
        /* EXEC SQL OPEN cCursor_Cuotas_CuotCredito USING :lhCodCiclFact, :lhRngIniClie,:lhRngFinClie; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )554;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhRngIniClie;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhRngFinClie;
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
        vDTrazasLog  (modulo," ** No Existen Datos en cCursor_Cuotas_CuotCredito **",LOG01);
        vDTrazasError(modulo," ** No Existen Datos en cCursor_Cuotas_CuotCredito **",LOG01);
        return (SQLCODE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en Open cCursor_Cuotas_CuotCredito **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en Open cCursor_Cuotas_CuotCredito **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }
    return (SQLCODE);
}/************************* Fin ifnOpenCuotasFaCuotCredito **************************/




/* ******************************************************************************** */
/*  ifnFetchCuotaFaCuotCredito()  : Fetch de Cuota                                  */
/* ******************************************************************************** */
int ifnFetchCuotaFaCuotCredito (CUOTCREDITO *pstCuotas)
{
    char modulo[]   = "ifnFetchCuotaFaCuotCredito";
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        char    szhRowid            [20]="" ;   /* EXEC SQL VAR szhRowid       IS STRING(20); */ 

        long    lhCodCliente                ;
        long    lhNumSecuenci               ;
        int     ihCodTipDocum               ;
        long    lhCodVendedorAgente         ;
        char    szhLetra            [2]=""  ;   /* EXEC SQL VAR szhLetra       IS STRING(2); */ 

        int     ihCodCentremi               ;
        int     ihCodConcepto               ;
        int     ihColumna                   ;
        int     ihNumCuota                  ;
        int     ihSecCuota                  ;
        long    ihCodCiclFact               ;
        int     ihIndFacturado              ;
        char    szhFecVencimie      [20]="" ;   /* EXEC SQL VAR szhFecVencimie IS STRING(20); */ 

        char    szhNumFolioCTC      [12]="" ;   /* EXEC SQL VAR szhNumFolioCTC IS STRING(12); */ 

        double  dhMtoCuota                  ;
        char    szhFecCompra        [20]="" ;   /* EXEC SQL VAR szhFecCompra   IS STRING(20); */ 

        int     ihIndImpreso                ;
        long    lhNum_Folio                 ;
        char    szhPref_Plaza       [11] ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    /* EXEC SQL FETCH cCursor_Cuotas_CuotCredito INTO
            :szhRowid           ,
            :lhCodCliente       ,
            :lhNumSecuenci      ,
            :ihCodTipDocum      ,
            :lhCodVendedorAgente,
            :szhLetra           ,
            :ihCodCentremi      ,
            :ihCodConcepto      ,
            :ihColumna          ,
            :ihNumCuota         ,
            :ihSecCuota         ,
            :ihCodCiclFact      ,
            :ihIndFacturado     ,
            :szhFecVencimie     ,
            :szhNumFolioCTC     ,
            :dhMtoCuota         ,
            :szhFecCompra       ,
            :ihIndImpreso       ,
            :lhNum_Folio        ,
            :szhPref_Plaza  ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )581;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorAgente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentremi;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihNumCuota;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihSecCuota;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihCodCiclFact;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihIndFacturado;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhFecVencimie;
    sqlstm.sqhstl[13] = (unsigned long )20;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhNumFolioCTC;
    sqlstm.sqhstl[14] = (unsigned long )12;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&dhMtoCuota;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhFecCompra;
    sqlstm.sqhstl[16] = (unsigned long )20;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihIndImpreso;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&lhNum_Folio;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhPref_Plaza;
    sqlstm.sqhstl[19] = (unsigned long )11;
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

/*PHB:agregue pref_plaza*/

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Fecth Cursor cCursor_Cuotas_CuotCredito %s ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Fecth Cursor cCursor_Cuotas_CuotCredito %s ",LOG01,SQLERRM);
    }

    if( SQLCODE == SQLOK )
    {
        strcpy(pstCuotas->szRowId       ,   szhRowid            );
        pstCuotas->lCodCliente          =   lhCodCliente        ;
        pstCuotas->lNumSecuenci         =   lhNumSecuenci       ;
        pstCuotas->iCodTipDocum         =   ihCodTipDocum       ;
        pstCuotas->lCodVendedorAgente   =   lhCodVendedorAgente ;
        strcpy(pstCuotas->szLetra       ,   szhLetra            );
        pstCuotas->iCodCentremi         =   ihCodCentremi       ;
        pstCuotas->iCodConcepto         =   ihCodConcepto       ;
        pstCuotas->iColumna             =   ihColumna           ;
        pstCuotas->iNumCuota            =   ihNumCuota          ;
        pstCuotas->iSecCuota            =   ihSecCuota          ;
        pstCuotas->lCodCiclFact         =   ihCodCiclFact       ;
        pstCuotas->iIndFacturado        =   ihIndFacturado      ;
        strcpy(pstCuotas->szFecVencimie ,   szhFecVencimie      );
        strcpy(pstCuotas->szNumFolioCTC ,   szhNumFolioCTC      );
        pstCuotas->dMtoCuota            =   dhMtoCuota          ;
        strcpy(pstCuotas->szFecCompra   ,   szhFecCompra        );
        pstCuotas->iIndImpreso          =   ihIndImpreso        ;
        pstCuotas->lNum_Folio           =   lhNum_Folio         ;
        strcpy(pstCuotas->szPrefPlaza   ,   szhPref_Plaza       );/*PHB:agregue pref_plaza*/
    }
    return (SQLCODE);
}/************************* Fin ifnFetchCuotaFaCuotCredito  *************************/




/* ******************************************************************************** */
/*  bfnCloseCuotasFaCuotCredito()  : Cierra Cursor de Cuotas                        */
/* ******************************************************************************** */
BOOL bfnCloseCuotasFaCuotCredito(void)
{
    char modulo[]   = "bfnCloseCuotasFaCuotCredito";

    /* EXEC SQL CLOSE cCursor_Cuotas_CuotCredito; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )676;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/************************* Fin bfnCloseCuotasFaCuotCredito *************************/




/* ******************************************************************************** */
/*  bfnUpdateCuotaCartera()  : Update en Cartera de Cuotas Informadas               */
/* ******************************************************************************** */
BOOL bfnUpdateCuotaCartera(CUOTCREDITO pstCuotas)
{
    char modulo[]   = "bfnUpdateCuotaCartera";

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        long    lhCodCliente                ;
        long    lhNumSecuenci               ;
        int     ihCodTipDocum               ;
        long    lhCodVendedorAgente         ;
        char    szhLetra            [2]=""  ;   /* EXEC SQL VAR szhLetra           IS STRING(2); */ 

        int     ihCodCentremi               ;
        int     ihCodConcepto               ;
        int     ihColumna                   ;
        int     ihIndFacturado              ;
        char    szhNumFolio         [12]    ;   /* EXEC SQL VAR szhNumFolio        IS STRING(12); */ 

        char    szhPrefPlaza        [11]    ;
        char    szhFecVencimien     [20]    ;   /* EXEC SQL VAR szhFecVencimien    IS STRING(20); */ 

    /* EXEC SQL END DECLARE SECTION    ; */ 



    lhCodCliente            =   pstCuotas.lCodCliente       ;
    lhNumSecuenci           =   pstCuotas.lNumSecuenci      ;
    ihCodTipDocum           =   pstCuotas.iCodTipDocum      ;
    lhCodVendedorAgente     =   pstCuotas.lCodVendedorAgente;
    strcpy(szhLetra         ,   pstCuotas.szLetra           );
    ihCodCentremi           =   pstCuotas.iCodCentremi      ;
    ihCodConcepto           =   pstCuotas.iCodConcepto      ;
    ihColumna               =   pstCuotas.iColumna          ;
    ihIndFacturado          =   IND_IMPRESO_OK              ;
    strcpy(szhNumFolio      ,   pstCuotas.szNumFolioCTC     );
    strcpy(szhPrefPlaza     ,   pstCuotas.szPrefPlaza       );/*PHB:agregue pref_plaza*/
    strcpy(szhFecVencimien  ,   pstCuotas.szFecVencimie     );

    vDTrazasLog  (modulo,"\t\t**(bfnUpdateCuotaCartera) Update Cuota Informada en Co_Cartera ", LOG03);

    /* EXEC SQL EXECUTE SQL_UPDATE_CO_CARTERA USING :ihIndFacturado        ,
                                                 :szhNumFolio           ,
                                                 :szhFecVencimien       ,
                                                 :lhCodCliente          ,
                                                 :lhNumSecuenci         ,
                                                 :ihCodTipDocum         ,
                                                 :lhCodVendedorAgente   ,
                                                 :szhLetra              ,
                                                 :ihCodCentremi         ,
                                                 :ihCodConcepto         ,
                                                 :ihColumna             ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )691;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndFacturado;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNumFolio;
    sqlstm.sqhstl[1] = (unsigned long )12;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecVencimien;
    sqlstm.sqhstl[2] = (unsigned long )20;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenci;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[9] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihColumna;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Update Co_Cartera [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Update Co_Cartera [%s]",LOG01,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}

/* ******************************************************************************** */
/*  bfnInsertHistCuotasCiclo()  : Inserta Registros de Cuotas en Historico          */
/* ******************************************************************************** */
BOOL bfnInsertHistCuotasCiclo(CUOTCREDITO pstCuotas)
{
    char modulo[]   = "bfnInsertHistCuotasCiclo";

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        char    szhRowid            [20]="" ;   /* EXEC SQL VAR szhRowid       IS STRING(20); */ 

    /* EXEC SQL END DECLARE SECTION    ; */ 


    strcpy(szhRowid,pstCuotas.szRowId);

    vDTrazasLog  (modulo,"\t\t**(bfnInsertHistCuotasCiclo) Inserta Cuotas en FA_HISTCUOTCREDITO", LOG03);

    /* EXEC SQL EXECUTE SQL_INSERT_FA_HISTCUOTCREDITO USING :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )750;
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




    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Insert de Cuotas en FA_HISTCUOTCREDITO [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Insert de Cuotas en FA_HISTCUOTCREDITO [%s]",LOG01,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/*************************** Fin bfnInsertHistCuotasCiclo **************************/


/* ******************************************************************************** */
/*  bfnDeleteHistCuotasCiclo()  : Elimina Registros de Cuotas                       */
/* ******************************************************************************** */
BOOL bfnDeleteHistCuotasCiclo (CUOTCREDITO pstCuotas)
{
    char modulo[]   = "bfnDeleteHistCuotasCiclo";

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        char    szhRowid            [20]="" ;   /* EXEC SQL VAR szhRowid       IS STRING(20); */ 

    /* EXEC SQL END DECLARE SECTION    ; */ 


    strcpy(szhRowid,pstCuotas.szRowId);

    vDTrazasLog  (modulo,"\t\t**(bfnDeleteHistCuotasCiclo) Elimina Cuotas de FA_CUOTCREDITO", LOG03);

    /* EXEC SQL EXECUTE SQL_DELETE_FA_CUOTCREDITO USING :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )769;
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Delete de Cuotas en FA_CUOTCREDITO [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Delete de Cuotas en FA_CUOTCREDITO [%s]",LOG01,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/********************************* Fin bfnDeleteHistCuotasCiclo ************************/

/* ******************************************************************************** */
/*  bprocCargaUltimoPago()  : Validacion Package                                    */
/* ******************************************************************************** */
BOOL bprocCargaUltimoPago(ARGSENTRADA stArgsEntrada )
{
    char        modulo[]   = "bprocCargaUltimoPago";
    char        szFecha[20]= ""             ;
    /********************************************************************************/
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szResultado_fn[1024];
    long lhCodCiclFact;
    long lhRngIniClie      = 0L;
    long lhRngFinClie      = 0L;
    int  ihIngrRngClientes = 0;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"(bprocCargaUltimoPago) Parametros de Entrada:"
                         "\n\t stArgsEntrada.lCodCiclFact    :[%ld]"
                         "\n\t stArgsEntrada.lClienteIni     :[%ld]"
                         "\n\t stArgsEntrada.lClienteFin     :[%ld]"
                         "\n\t stArgsEntrada.bIngRngClientes :[%d]"
                        , LOG05
                        , stArgsEntrada.lCodCiclFact
                        , stArgsEntrada.lClienteIni
                        , stArgsEntrada.lClienteFin
                        , stArgsEntrada.bIngRngClientes);


    lhCodCiclFact     =  stArgsEntrada.lCodCiclFact;     /* Ciclo de facturacion */
    lhRngIniClie      =  stArgsEntrada.lClienteIni;      /* Rango inicial de clientes */
    lhRngFinClie      =  stArgsEntrada.lClienteFin;      /* Rango final de clientes   */

    ihIngrRngClientes  = (stArgsEntrada.bIngRngClientes == TRUE)?1:0;

    /*Borrado de tabla  */

    /* EXEC SQL
        DELETE CO_ULTPAGO_TT
        WHERE ((COD_CLIENTE BETWEEN :lhRngIniClie AND :lhRngFinClie) OR (1 <> :ihIngrRngClientes)); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from CO_ULTPAGO_TT  where (COD_CLIENTE between :b\
0 and :b1 or 1<>:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )788;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhRngIniClie;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhRngFinClie;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIngrRngClientes;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (modulo,"(bprocCargaUltimoPago) Atencion: SQLCODE !=SQLOK en EXEC SQL DELETE CO_ULTPAGO_TT"
                             "\n\t\t sqlca.sqlcode: [%d]"
                            , LOG03
                            , SQLCODE);
    }

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bprocCargaUltimoPago", LOG01);
        vDTrazasLog  (modulo," en Commit bprocCargaUltimoPago", LOG01);
        return FALSE;
    }

    szResultado_fn[0] = '\0';

    /* EXEC SQL EXECUTE
        BEGIN
         :szResultado_fn := CO_ULTPAGO_PG.CO_CARGATOTALPAGOS_FN(:lhCodCiclFact, :ihIngrRngClientes, :lhRngIniClie, :lhRngFinClie);
      END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szResultado_fn := CO_ULTPAGO_PG . CO_CARGATOTALPAG\
OS_FN ( :lhCodCiclFact , :ihIngrRngClientes , :lhRngIniClie , :lhRngFinClie ) \
; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )815;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szResultado_fn;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIngrRngClientes;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhRngIniClie;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhRngFinClie;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Ejecucion de CO_ULTPAGO_PG.CO_CARGATOTALPAGOS_FN, sqlca.sqlcode:[%d]", LOG01,sqlca.sqlcode);
        vDTrazasLog  (modulo," en Ejecucion de CO_ULTPAGO_PG.CO_CARGATOTALPAGOS_FN, sqlca.sqlcode:[%d]", LOG01,sqlca.sqlcode);
        return FALSE;
    }


    if(szResultado_fn==NULL)
    {
        vDTrazasLog  (modulo,"* Atencion: szResultado_fn == NULL, Se reemplaza por cadena vacia.", LOG03);
        strcpy(szResultado_fn, "");
    }

    vDTrazasLog  (modulo," Resultado Pagos: [%s]", LOG04, alltrim(szResultado_fn));

    if (!bfnSelectSysDate(szFecha))
    {
        vDTrazasLog  (modulo,"\n\n\tError en funcion bfnSelectSysDate() \n",LOG01);
        vDTrazasError(modulo,"\n\n\tError en funcion bfnSelectSysDate() \n",LOG01);
        return FALSE;
    }

    if(strncmp(szResultado_fn,"ERROR",5)==0)
    {
        vDTrazasLog  (modulo,"\n\n\tError en funcion CO_CARGAPAGOS_FN \n",LOG01);
        vDTrazasError(modulo,"\n\n\tError en funcion CO_CARGAPAGOS_FN \n",LOG01);
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecInicio,stArgsEntrada.szHoraInicProc);
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion CO_CARGAPAGOS_FN con Error");
    }
    else
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_OK;
        strcpy(stTrazaProc.szFecInicio,stArgsEntrada.szHoraInicProc);
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion CO_CARGAPAGOS_FN  Terminado OK");
    }

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bprocCargaUltimoPago", LOG01);
        vDTrazasLog  (modulo," en Commit bprocCargaUltimoPago", LOG01);
        return FALSE;
    }

    vDTrazasLog  (modulo," Procesa Ajustes, Ciclo [%ld] ", LOG04, lhCodCiclFact);

    /* EXEC SQL EXECUTE
        BEGIN
         :szResultado_fn := CO_ULTPAGO_PG.CO_CARGAJUSTES_FN(:lhCodCiclFact, :ihIngrRngClientes, :lhRngIniClie, :lhRngFinClie);
      END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szResultado_fn := CO_ULTPAGO_PG . CO_CARGAJUSTES_F\
N ( :lhCodCiclFact , :ihIngrRngClientes , :lhRngIniClie , :lhRngFinClie ) ; EN\
D ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )850;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szResultado_fn;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIngrRngClientes;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhRngIniClie;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhRngFinClie;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Ejecucion de CO_ULTPAGO_PG.CO_CARGAJUSTES_FN, sqlca.sqlcode:[%d]", LOG01,sqlca.sqlcode);
        vDTrazasLog  (modulo," en Ejecucion de CO_ULTPAGO_PG.CO_CARGAJUSTES_FN, sqlca.sqlcode:[%d]", LOG01,sqlca.sqlcode);
        return FALSE;
    }

    if(szResultado_fn==NULL)
    {
        vDTrazasLog  (modulo,"* Atencion: szResultado_fn == NULL, Se reemplaza por cadena vacia.", LOG03);
        strcpy(szResultado_fn, "");
    }

    vDTrazasLog  (modulo," Resultado Ajustes: [%s]", LOG04, alltrim(szResultado_fn));

    if (!bfnSelectSysDate(szFecha))
    {
        vDTrazasLog  (modulo,"\n\n\tError en funcion bfnSelectSysDate() \n",LOG01);
        vDTrazasError(modulo,"\n\n\tError en funcion bfnSelectSysDate() \n",LOG01);
        return FALSE;
    }

    if(strncmp(szResultado_fn,"ERROR",5)==0)
    {
        vDTrazasLog  (modulo,"\n\n\tError en funcion CO_CARGAPAGOS_FN.CO_CARGAJUSTES_FN \n",LOG01);
        vDTrazasError(modulo,"\n\n\tError en funcion CO_CARGAPAGOS_FN.CO_CARGAJUSTES_FN \n",LOG01);
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion CO_CARGAJUSTES_FN con Error");
    }
    else
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_OK;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Generacion CO_CARGAJUSTES_FN Terminado OK");
    }

    bPrintTrazaProc(stTrazaProc);

    if(!bfnWrapperUpdateTrazaProc(stTrazaProc))
        return FALSE;

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bprocCargaUltimoPago", LOG01);
        vDTrazasLog  (modulo," en Commit bprocCargaUltimoPago", LOG01);
        return FALSE;
    }

    if(  stTrazaProc.iCodEstaProc == iPROC_EST_ERR)
     return FALSE;

    return TRUE;

}

#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) )
        return(s);
    while( *p<=32 && *p>1 )
        p++;
    strcpy(s,p);
    return(s);
}

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) )
        return(s);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )
        p--;
    *(++p)=0;
    return(s);
}

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
}


void vfnImprimirArgsEntrada(int iDestino, ARGSENTRADA stArgsEntrada)
{

    char *modulo="vfnImprimirArgsEntrada";

    switch(iDestino)
    {
        case CONSOLA:
            fprintf(stdout, "(II)\tArgumentos de entrada:\n"
                        "\t\tiModProceso      : [%d] \n"
                        "\t\tlCodCiclFact     : [%ld]\n"
                        "\t\tszOraAccount     : [%s] \n"
                        "\t\tszOraPasswd      : [%s] \n"
                        "\t\tiLogLevel        : [%d] \n"
                        "\t\tlClienteIni      : [%ld]\n"
                        "\t\tlClienteFin      : [%ld]\n"
                        "\t\tbIngRngClientes  : [%d]\n"
                        "\t\tiCodCiclo        : [%d]\n"
                        ,stArgsEntrada.iModProceso
                        ,stArgsEntrada.lCodCiclFact
                        ,stArgsEntrada.szOraAccount
                        ,stArgsEntrada.szOraPasswd
                        ,stArgsEntrada.iLogLevel
                        ,stArgsEntrada.lClienteIni
                        ,stArgsEntrada.lClienteFin
                        ,stArgsEntrada.bIngRngClientes
                        ,stArgsEntrada.iCodCiclo);
            break;
        case TRAZASLOG:
            vDTrazasLog(modulo, "(II)\tArgumentos de entrada:\n"
                        "\t\tiModProceso      : [%d] \n"
                        "\t\tlCodCiclFact     : [%ld]\n"
                        "\t\tszOraAccount     : [%s] \n"
                        "\t\tszOraPasswd      : [%s] \n"
                        "\t\tiLogLevel        : [%d] \n"
                        "\t\tlClienteIni      : [%ld]\n"
                        "\t\tlClienteFin      : [%ld]\n"
                        "\t\tbIngRngClientes  : [%d]\n"
                        "\t\tiCodCiclo        : [%d]\n"
                        ,LOG05
                        ,stArgsEntrada.iModProceso
                        ,stArgsEntrada.lCodCiclFact
                        ,stArgsEntrada.szOraAccount
                        ,stArgsEntrada.szOraPasswd
                        ,stArgsEntrada.iLogLevel
                        ,stArgsEntrada.lClienteIni
                        ,stArgsEntrada.lClienteFin
                        ,stArgsEntrada.bIngRngClientes);
            break;
    }
    return;
}

/*
 * Funcion      : bfnValidarTrazaDeProceso
 * Descripcion  : Funcion "wrapper" que ejecuta la validacion de traza de acuerdo a
 *                si existe o no defincion de Host_id en la configuracion de maquina.
 */
BOOL bfnWrapperValidaTrazaProc(long lCodCiclFact,int iCodProceso, int iIndFacturacion)
{

    char szHostId[25];


    if( (ifnGetHostId(szHostId))!=0 )
    {
        if (!bfnValidaTrazaProc( lCodCiclFact, iCodProceso, iIndFacturacion))
            return (FALSE);

    }
    else
    {
        if (!bfnValidaTrazaProcHost( lCodCiclFact, iCodProceso, iIndFacturacion, szHostId))
            return (FALSE);

    }

    return (TRUE);

}

/*
 * Funcion      : bfnWrapperSelectTrazaProc
 * Descripcion  : Funcion "wrapper" que selecciona datos de traza de acuerdo a
 *                si existe o no defincion de Host_id en la configuracion de maquina.
 */
BOOL bfnWrapperSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza)
{
    char szHostId[25];

    if( (ifnGetHostId(szHostId))!=0 )
    {
        if (!bfnSelectTrazaProc (lCicloFac, iCodProc, pstTraza))
            return (FALSE);
    }
    else
    {
        if (!bfnSelectTrazaProcHost (lCicloFac, iCodProc, pstTraza, szHostId))
            return (FALSE);
    }

    return (TRUE);

}

/*
 * Funcion      : bfnWrapperUpdateTrazaProc
 * Descripcion  : Funcion "wrapper" que actualiza datos de traza de acuerdo a
 *                si existe o no defincion de Host_id en la configuracion de maquina.
 */
BOOL bfnWrapperUpdateTrazaProc (TRAZAPROC pstTraza)
{
    char szHostId[25];

    if( (ifnGetHostId(szHostId))!=0 )
    {
        if (!bfnUpdateTrazaProc (pstTraza))
            return (FALSE);
    }
    else
    {
        if (!bfnUpdateTrazaProcHost (pstTraza, szHostId))
            return (FALSE);
    }

    return (TRUE);

}

void    vfnIniciarEstProc( ESTADISTICAS *pstEstad)
{

    time(&pstEstad->tmTiempoProcIni);
    pstEstad->clTiempoCPUIni = clock();
}

void    vfnImprimirEstProc( ESTADISTICAS *pstEstad)
{
    char    *modulo="vfnImprimirEstProc";
    double  dDifProc = 0.0;
    double  dDifCPU  = 0.0;

    time(&pstEstad->tmTiempoProcFin);
    pstEstad->clTiempoCPUFin = clock();

    dDifProc = difftime (pstEstad->tmTiempoProcFin,pstEstad->tmTiempoProcIni);
    dDifCPU  = ((double) (pstEstad->clTiempoCPUFin - pstEstad->clTiempoCPUIni)) / CLOCKS_PER_SEC;
    vDTrazasLog(modulo,
                    "\n----------------------------------"
                    "\n|ESTADISTICAS DE TIEMPO DEL PROCESO|"
                    "\n----------------------------------"
                    "\nTiempo total del Proceso : [%10.2f] segundos."
                    "\nTiempo total de  CPU     : [%10.2f] segundos."
                    ,LOG03
                    ,dDifProc
                    ,dDifCPU);

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
