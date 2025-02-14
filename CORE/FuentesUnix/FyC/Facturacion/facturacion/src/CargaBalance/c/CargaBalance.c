
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
           char  filnam[21];
};
static const struct sqlcxp sqlfpn =
{
    20,
    "./pc/CargaBalance.pc"
};


static unsigned int sqlctx = 55101683;


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

 static const char *sq0007 = 
"select a.COD_TIPDOCUM ,a.DES_TIPDOCUM  from GE_TIPDOCUMEN a where a.COD_TIPD\
OCUM not  in (select b.COD_TIPDOCUM  from FAD_CONFBALANCE b where a.COD_TIPDOC\
UM=b.COD_TIPDOCUM)           ";

 static const char *sq0010 = 
"select A.COD_ITEM ,B.COD_TIPDOCUM ,sum(ROUND(B.IMP_PAGO,2)) ,count(1)  from \
FAD_CONFBALANCE A ,CO_PAGOS B where ((((A.COD_ORIGEN='PAGOS' and B.COD_CLIENTE\
=:b0) and B.FEC_EFECTIVIDAD<=TO_DATE(:b1,'YYYYMMDDHH24MISS')) and B.COD_TIPDOC\
UM=A.COD_TIPDOCUM) and B.COD_CICLFACT_BAL is null ) group by A.COD_ITEM,B.COD_\
TIPDOCUM order by A.COD_ITEM,B.COD_TIPDOCUM            ";

 static const char *sq0012 = 
"select CONF.COD_ITEM ,CONF.COD_TIPDOCUM ,ROUND(sum(TOT_FACTURA),2) ,count(1)\
  from (select COD_TIPDOCUM ,TOT_FACTURA  from FA_HISTDOCU where (((COD_CLIENT\
E=:b0 and FEC_EMISION<=TO_DATE(:b1,'YYYYMMDDHH24MISS')) and COD_CICLFACT_BAL i\
s null ) and IND_BALANCE is null )) DOCU ,FAD_CONFBALANCE CONF where (CONF.COD\
_ORIGEN='DOCUM' and CONF.COD_TIPDOCUM=DOCU.COD_TIPDOCUM) group by CONF.COD_ITE\
M,CONF.COD_TIPDOCUM order by CONF.COD_ITEM,CONF.COD_TIPDOCUM            ";

 static const char *sq0014 = 
"select A.COD_ITEM ,B.COD_TIPDOCUM ,ROUND(sum(B.IMPORTE_DEBE),2) ,count(1)  f\
rom FAD_CONFBALANCE A ,CO_AJUSTES B where ((((A.COD_ORIGEN='AJUST' and B.COD_C\
LIENTE=:b0) and B.FEC_EFECTIVIDAD<=TO_DATE(:b1,'YYYYMMDDHH24MISS')) and B.COD_\
TIPDOCUM=A.COD_TIPDOCUM) and COD_CICLFACT_BAL is null ) group by A.COD_ITEM,B.\
COD_TIPDOCUM order by A.COD_ITEM,B.COD_TIPDOCUM            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,152,0,4,111,0,0,6,4,0,1,0,1,3,0,0,2,4,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,
44,0,0,2,0,0,17,135,0,0,1,1,0,1,0,1,97,0,0,
63,0,0,2,0,0,45,157,0,0,1,1,0,1,0,1,3,0,0,
82,0,0,2,0,0,13,167,0,0,1,0,0,1,0,2,4,0,0,
101,0,0,2,0,0,15,180,0,0,0,0,0,1,0,
116,0,0,3,82,0,5,214,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
143,0,0,4,82,0,5,227,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
170,0,0,5,82,0,5,238,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
197,0,0,6,0,0,17,253,0,0,1,1,0,1,0,1,97,0,0,
216,0,0,6,0,0,21,262,0,0,2,2,0,1,0,1,4,0,0,1,3,0,0,
239,0,0,7,183,0,9,298,0,0,0,0,0,1,0,
254,0,0,7,0,0,13,314,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
277,0,0,7,0,0,15,342,0,0,0,0,0,1,0,
292,0,0,8,133,0,3,387,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
4,0,0,
331,0,0,9,178,0,5,419,0,0,6,6,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
370,0,0,10,365,0,9,940,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
393,0,0,10,0,0,13,962,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,
424,0,0,10,0,0,15,1032,0,0,0,0,0,1,0,
439,0,0,11,259,0,5,1073,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
466,0,0,12,460,0,9,1152,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
489,0,0,12,0,0,13,1174,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,
520,0,0,12,0,0,15,1249,0,0,0,0,0,1,0,
535,0,0,13,310,0,5,1298,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
566,0,0,14,369,0,9,1377,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
589,0,0,14,0,0,13,1399,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,
620,0,0,14,0,0,15,1469,0,0,0,0,0,1,0,
635,0,0,15,261,0,5,1510,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
662,0,0,16,160,0,4,1549,0,0,4,1,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,1,3,0,0,
693,0,0,17,195,0,4,1635,0,0,6,4,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,
732,0,0,18,0,0,17,1687,0,0,1,1,0,1,0,1,97,0,0,
751,0,0,18,0,0,45,1714,0,0,0,0,0,1,0,
766,0,0,18,0,0,13,1735,0,0,3,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,
793,0,0,19,0,0,17,1891,0,0,1,1,0,1,0,1,97,0,0,
812,0,0,19,0,0,21,1901,0,0,0,0,0,1,0,
827,0,0,20,246,0,4,1981,0,0,6,4,0,1,0,2,4,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : CargaBalance.pc                                          * */
/* *  Carga tablas de balance                                            * */
/* *  Autor : Nelson Contreras Helena                                    * */
/* *  Modif : 03-06-2004                                                 * */
/* *  Parametros :  Codigo de Ciclo de Facturacion                       * */
/* *            Cliente Inicial                                          * */
/* *            Cliente Final                                            * */
/* *            Nivel de log                                             * */
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


char    szFecha[20] = ""  ;
long    lContClientes   = 0;


/*
 * Funcion      : bfnPrepare
 * Descripcion  : Funcion se encarga de preparar el cursor y update de tabla ciclo
 */
/*
BOOL bfnPrepare ()
 {
	char szAux2[200];

    sprintf(szAux2, "SELECT ROUND(TOT_CARGOSME, 2) FROM FA_FACTDOCU_%d WHERE COD_CLIENTE = :CodCliente ", stLineaComando.iCodCiclFact);

    vDTrazasLog("CargaBalance", "QUERY [%s]\n", LOG03, szAux2);

    EXEC SQL PREPARE SELECT_CARGO_MENS FROM :szAux2;
    if (sqlca.sqlcode != SQLOK) 
    {
        vDTrazasLog  ("CargaBalance",	"\n\t**  Error en SQL-PREPARE Select CARGOSMEnsual  **"
		                                "\n\t\t=> Error : [%d]  [%s] "
		                                ,LOG01, SQLCODE,SQLERRM);
    	return (FALSE);
	}

    EXEC SQL DECLARE CUR_CARGO_MENS CURSOR FOR SELECT_CARGO_MENS;
    if (sqlca.sqlcode != SQLOK)  
    {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-DECLARE CURSOR Select CARGOSMEnsual  **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }

    sprintf(szAux2, "UPDATE FA_FACTDOCU_%d SET TOT_PAGAR = :TotPagar WHERE COD_CLIENTE = :CodCliente "
    			  , stLineaComando.iCodCiclFact);

    vDTrazasLog("CargaBalance", "QUERY [%s]\n", LOG05, szAux2);

    EXEC SQL PREPARE UPDATE_TOT_PAGAR FROM :szAux2;
    if (sqlca.sqlcode != SQLOK) {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-PREPARE Update Tot_Pagar  **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }


	return (1);
}
*/

int iUpdateFatBalance (long lCodCliente)
{
    int     i;
    long    TotalRegs=0;
    double  FatBalance[10];
	char szAux2[200];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            double  dhMonto[10];    /* [CANTIDAD_CAMPO_FATBALANCE] */
            int     ihItem[10];
            long    CodCli;
            double  dTotCargosMes;
            double  dTotalAPagar;
/* 20040310 TM-200403030552 Respaldo Total Real a Pagar */
            double  dTotalAPagarReal;
            char    szFecDesde[15];/* EXEC SQL VAR szFecDesde IS STRING (15); */ 

            const int     ihValorUno   = 1;
            const int     ihValorDos   = 2;
            const int     ihValorCinco = 5;
            const int     ihValorSeis = 6;
            const int     ihValorSiete = 7;
            const int     ihValorOcho = 8;
    /* EXEC SQL END DECLARE SECTION; */ 


    CodCli = lCodCliente;

    /* SE RECUPERA EL SALDO TOTAL */
    strcpy(szFecDesde, sthFaCicloFact.szhFecDesdeLLam);

    vDTrazasLog("CargaBalance", "QRY:SELECT Fat_Balance, Cliente[%ld]\n", LOG05, CodCli);

    for (i=0;i<10;i++) { /* Inicializamos Array */
         dhMonto[i] = 0;
         FatBalance[i] = 0;
        }

    /* EXEC SQL SELECT ROUND(SUM(IMP_DOCUMENTO), :ihValorDos), COD_ITEM
            INTO    :dhMonto,:ihItem
            FROM FAT_BALANCE
            WHERE COD_ITEM BETWEEN :ihValorUno AND :ihValorCinco
            AND COD_CLIENTE = :CodCli
            GROUP BY COD_ITEM; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ROUND(sum(IMP_DOCUMENTO),:b0) ,COD_ITEM into :b1,:\
b2  from FAT_BALANCE where (COD_ITEM between :b3 and :b4 and COD_CLIENTE=:b5) \
group by COD_ITEM";
    sqlstm.iters = (unsigned int  )10;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValorDos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)dhMonto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[1] = (         int  )sizeof(double);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)ihItem;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValorUno;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihValorCinco;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&CodCli;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )sizeof(long);
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



    if (sqlca.sqlcode < SQLOK && sqlca.sqlcode != SQLNOTFOUND)  {
        vDTrazasLog("CargaBalance", "Error en ejecucion del SELECT SQLCODE[%d]", LOG05, sqlca.sqlcode);
        return(FALSE);
    }

    TotalRegs = sqlca.sqlerrd[2];
    vDTrazasLog("CargaBalance", "Fat _Balance[%ld] Registros\n", LOG05, TotalRegs);
    for (i=0;i<TotalRegs;i++) 
    {
    	vDTrazasLog("CargaBalance", "QRY:SELECT FatBalance[%d] = [%f];\n", LOG05, i, dhMonto[i]);
        FatBalance[ihItem[i]] = dhMonto[i];
    }

    sprintf(szAux2, "SELECT ROUND(TOT_CARGOSME, 2) FROM FA_FACTDOCU_%d WHERE COD_CLIENTE = :CodCliente ", stLineaComando.iCodCiclFact);

    vDTrazasLog("CargaBalance", "QUERY [%s]\n", LOG03, szAux2);

    /* EXEC SQL PREPARE SELECT_CARGO_MENS FROM :szAux2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )44;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szAux2;
    sqlstm.sqhstl[0] = (unsigned long )200;
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
        vDTrazasLog  ("CargaBalance",	"\n\t**  Error en SQL-PREPARE Select CARGOSMEnsual  **"
		                                "\n\t\t=> Error : [%d]  [%s] "
		                                ,LOG01, SQLCODE,SQLERRM);
    	return (FALSE);
	}

    /* EXEC SQL DECLARE CUR_CARGO_MENS CURSOR FOR SELECT_CARGO_MENS; */ 


    if (sqlca.sqlcode != SQLOK)  
    {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-DECLARE CURSOR Select CARGOSMEnsual  **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }

	vDTrazasLog("CargaBalance", "QRY:SELECT TOTAL CARGOS MES, Cliente[%ld]\n", LOG05, CodCli);

    /* EXEC SQL OPEN CUR_CARGO_MENS USING :CodCli; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )63;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&CodCli;
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



    if (sqlca.sqlcode != SQLOK) 
    {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-OPEN CURSOR Select CARGOSMEnsual  **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return (FALSE);
       }

    /* EXEC SQL FETCH CUR_CARGO_MENS INTO :dTotCargosMes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )82;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&dTotCargosMes;
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



    vDTrazasLog("CargaBalance", "QRY:SELECT dTotCargosMes[%f];\n", LOG05, dTotCargosMes);

    if (sqlca.sqlcode != SQLOK && SQLCODE != 1403)  {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-FETCH CURSOR Select CARGOSMEnsual  **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return (FALSE);
       }

    vDTrazasLog("CargaBalance", "TOTAL CARGOS MES cliente %ld = [%f]\n", LOG05, CodCli, dTotCargosMes);

    /* EXEC SQL CLOSE CUR_CARGO_MENS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )101;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode != SQLOK) {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-CLOSE CURSOR Select CARGOSMEnsual  **"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, SQLCODE,SQLERRM);
        return (FALSE);
       }

    vDTrazasLog("CargaBalance:", "Retornno SELECT FA_HISTDOCU SQLCODE[%d]", LOG05, sqlca.sqlcode);
    if (sqlca.sqlcode < SQLOK && sqlca.sqlcode != SQLNOTFOUND){
        vDTrazasLog("CargaBalance", "Error en ejecucion del SELECT TOTAL CARGOS MES SQLCODE[%d]", LOG05, sqlca.sqlcode);
        return(FALSE);
       }

    vDTrazasLog("CargaBalance", "\ndTotalAPagar = dTotCargosMes[%f] +  ..."
    							"\n... ITEM[%d](%f) + ITEM[%d](%f) + ..."
    							"\n... ITEM[%d](%f) + ITEM[%d](%f) + ..."
    							"\n... ITEM[%d](%f) "
    							, LOG05 , dTotCargosMes
    							, iAJUSTE_CREDITO , FatBalance[iAJUSTE_CREDITO]
    							, iBALANCE_ANTERIOR, FatBalance[iBALANCE_ANTERIOR]
    							, iPAGOS_RECIBIDOS, FatBalance[iPAGOS_RECIBIDOS]
    							, iPAGOS_REVERTIDOS, FatBalance[iPAGOS_REVERTIDOS]
    							, iMISCELANEA, FatBalance[iMISCELANEA]);
    dTotalAPagar =  dTotCargosMes +
            FatBalance[iAJUSTE_CREDITO] +
            FatBalance[iBALANCE_ANTERIOR] +
            FatBalance[iPAGOS_RECIBIDOS] +
            FatBalance[iPAGOS_REVERTIDOS] +
            FatBalance[iMISCELANEA];

    vDTrazasLog("CargaBalance", "dTotalAPagar = [%f]", LOG05, dTotalAPagar);

    /* EXEC SQL UPDATE FAT_BALANCE
        SET     IMP_DOCUMENTO   = :dTotalAPagar
        WHERE   COD_CLIENTE = :CodCli
        AND     COD_ITEM    = :ihValorOcho; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=:b0 where (COD_CLIE\
NTE=:b1 and COD_ITEM=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )116;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&CodCli;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValorOcho;
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



    if (sqlca.sqlcode != SQLOK) {
        vDTrazasLog("CargaBalance: iUpdateFatBalance", "Error en UPDATE ITEM 8. Error [%d][%s]", LOG05, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
       }

    dTotalAPagarReal = dTotalAPagar;
    if (dTotalAPagar < 0) dTotalAPagar = 0;

    /* EXEC SQL UPDATE FAT_BALANCE
        SET     IMP_DOCUMENTO   = :dTotalAPagar
        WHERE   COD_CLIENTE = :CodCli
        AND     COD_ITEM    = :ihValorSiete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=:b0 where (COD_CLIE\
NTE=:b1 and COD_ITEM=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )143;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&CodCli;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValorSiete;
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



    if (sqlca.sqlcode != SQLOK) {
        vDTrazasLog("CargaBalance: iUpdateFatBalance", "Error en UPDATE ITEM 7. Error [%d][%s]", LOG05, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
       }


    /* EXEC SQL UPDATE FAT_BALANCE
        SET     IMP_DOCUMENTO   = :dTotCargosMes
        WHERE   COD_CLIENTE = :CodCli
        AND     COD_ITEM    = :ihValorSeis; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_BALANCE  set IMP_DOCUMENTO=:b0 where (COD_CLIE\
NTE=:b1 and COD_ITEM=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )170;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dTotCargosMes;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&CodCli;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValorSeis;
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



    if (sqlca.sqlcode != SQLOK) {
        vDTrazasLog("CargaBalance: iUpdateFatBalance", "Error en UPDATE ITEM 6. Error [%d][%s]", LOG05, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
       }

    sprintf(szAux2, "UPDATE FA_FACTDOCU_%d SET TOT_PAGAR = :TotPagar WHERE COD_CLIENTE = :CodCliente "
    			  , stLineaComando.iCodCiclFact);

    vDTrazasLog("CargaBalance", "QUERY [%s]\n", LOG05, szAux2);

    /* EXEC SQL PREPARE UPDATE_TOT_PAGAR FROM :szAux2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )197;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szAux2;
    sqlstm.sqhstl[0] = (unsigned long )200;
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


    if (sqlca.sqlcode != SQLOK) {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-PREPARE Update Tot_Pagar  **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }

	vDTrazasLog("CargaBalance", "QRY:UPDATE TOTAL_PAGAR FA_FACTDOCU, Cliente[%ld]\n", LOG05, CodCli);

    /* EXEC SQL EXECUTE UPDATE_TOT_PAGAR USING :dTotalAPagarReal, :CodCli ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )216;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dTotalAPagarReal;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&CodCli;
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


    if (sqlca.sqlcode != SQLOK)  {
        vDTrazasLog  ("CargaBalance",  "\n\t**  Error en SQL-EXECUTE Update Tot_Pagar **"
                      "\n\t\t=> Error : [%d]  [%s] ",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }

    return(1);
}/*********************************** Final iUpdateFatBalance  ***********************************/

/* 20040310 TM-200403030552  bfnValidaTipoDocumento() Funcion que compara los documentos existentes en GE_TIPDOCUMEN y que no estan en FAD_CONFBALANCE */
/*                          Si encuentra diferencias las imprime en los archivos LOG y ERR y retorna FALSE. Asi se pueden tomar las medidas correctivas */
BOOL bfnValidaTipoDocumento()
{
    char *modulo="bfnValidaTipoDocumento() ";
    BOOL bRetorno;
    int iCantidad;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int iCodTipdocum;
    char szDesTipdocum[41];
/* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL DECLARE Cursor_TipoDocumento CURSOR FOR
        SELECT a.COD_TIPDOCUM, a.DES_TIPDOCUM
          FROM GE_TIPDOCUMEN a
         WHERE a.COD_TIPDOCUM NOT IN ( SELECT b.COD_TIPDOCUM
        								 FROM FAD_CONFBALANCE b
        								WHERE a.COD_TIPDOCUM = b.COD_TIPDOCUM )  ; */ 


    if ( SQLCODE != SQLOK  && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  (modulo,"\n\t\t** Error DECLARE Cursor_TipoDocumento [%d] [%s]\n", LOG03, SQLCODE, SQLERRM);
        vDTrazasError(modulo,"\n\t\t** Error DECLARE Cursor_TipoDocumento [%d] [%s]\n", LOG03, SQLCODE, SQLERRM);
        return FALSE;
    }

    /* EXEC SQL OPEN Cursor_TipoDocumento; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )239;
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
        vDTrazasLog  ( modulo,"\n\t\t** Error OPEN Cursor_TipoDocumento [%d] [%s]\n", LOG03, SQLCODE, SQLERRM);
        vDTrazasError(modulo, "\n\t\t** Error OPEN Cursor_TipoDocumento [%d] ]%s]\n", LOG03, SQLCODE, SQLERRM);
        return FALSE;
    }

    iCantidad=0;
    bRetorno=FALSE;

    while(bRetorno==FALSE)
    {
        memset(szDesTipdocum,0,sizeof(szDesTipdocum));

        /* EXEC SQL FETCH Cursor_TipoDocumento
        INTO :iCodTipdocum, :szDesTipdocum ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )254;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&iCodTipdocum;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szDesTipdocum;
        sqlstm.sqhstl[1] = (unsigned long )41;
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



        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
            vDTrazasLog  (modulo,"\n\t\t** Error en FETCH Cursor_TipoDocumento [%d] [%s]\n",LOG03, SQLCODE, SQLERRM);
            vDTrazasError(modulo,"\n\t\t** Error en FETCH Cursor_TipoDocumento [%d] [%s]\n",LOG03, SQLCODE, SQLERRM);
            return FALSE;
        }
		/* No hay diferencias, esta todo OK */
        if (iCantidad == 0 && SQLCODE == SQLNOTFOUND)
        {
            iCantidad=0;
            break;
        }
		/* Se llego a NO hay mas y conto registros, llego al final del cursor */
        if (iCantidad > 0 && SQLCODE == SQLNOTFOUND)
        {
            bRetorno=1;
            continue;
        }

		/* Encontro registros, SQLCODE == SQLOK */
        iCantidad++;
        vDTrazasLog  (modulo,"\n\t\t** En GE_TIPDOCUMEN Falta Documento %d [%s]",LOG03, iCodTipdocum, szDesTipdocum);
        vDTrazasError(modulo,"\n\t\t** En GE_TIPDOCUMEN Falta Documento %d [%s]",LOG03, iCodTipdocum, szDesTipdocum);
    }

    /* EXEC SQL CLOSE Cursor_TipoDocumento  ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )277;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
        vDTrazasLog  (modulo,"\n\t\t** Error en CLOSE Cursor_TipoDocumento [%d] [%s]",LOG03, SQLCODE, SQLERRM);
        vDTrazasError(modulo,"\n\t\t** Error en CLOSE Cursor_TipoDocumento [%d] [%s]",LOG03, SQLCODE, SQLERRM);
        return FALSE;
    }

	/* Si hay registros, retorna FALSO */
    return((iCantidad?FALSE:1));
}


int ifnInsertaFatBalance (long  lCod_Cliente
						, int iCod_Item
						, int iCod_Docum
						, int iCod_CiclFact
						, int iCant_Docum
						, double dImp_Docum)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCod_Cliente;
        int 	ihCod_Item;
        int 	ihCod_Docum;
        int 	ihCod_CiclFact;
        int 	ihCant_Docum;
        double  dhImp_Docum;
    /* EXEC SQL END DECLARE SECTION; */ 


/*  Si el cliente es 0, no hace nada y retorna     */
    if(lCod_Cliente == 0)
    {
        return (0);
    }

    if ( iCod_Item == iPAGOS_RECIBIDOS || iCod_Item == iAJUSTE_CREDITO)
        dImp_Docum   = dImp_Docum * -1;

    lhCod_Cliente   = lCod_Cliente;
    ihCod_Item  	= iCod_Item;
    ihCod_Docum 	= iCod_Docum;
    ihCod_CiclFact  = iCod_CiclFact;
    ihCant_Docum    = iCant_Docum;
    dhImp_Docum 	= dImp_Docum;

    /* EXEC SQL INSERT INTO FAT_BALANCE
            (COD_CLIENTE    ,
             COD_ITEM   	,
             COD_TIPDOCUM   ,
             COD_CICLFACT   ,
             CAN_DOCUMENTO  ,
             IMP_DOCUMENTO  )
        VALUES (:lhCod_Cliente  ,
                :ihCod_Item 	,
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
    sqlstm.offset = (unsigned int  )292;
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



    vDTrazasLog  ("ifnInsertaFatBalance", " \nVALORES A INSERTAR EN FAT_BALANCE [%d]"
    									  " \n\t\t\tCod. Cliente    [%ld]"
    									  " \n\t\t\tCod. Item  	    [%d]" 
    									  " \n\t\t\tCod. Docum 		[%d]" 
    									  " \n\t\t\tCod. CiclFact   [%d]" 
    									  " \n\t\t\tCant. Docum     [%d]" 
    									  " \n\t\t\tImporte Docum 	[%f]\n" 
    									  , LOG03, sqlca.sqlcode
    									  , lhCod_Cliente, ihCod_Item
    									  , ihCod_Docum, ihCod_CiclFact
    									  , ihCant_Docum, dhImp_Docum  );

    if (sqlca.sqlcode != SQLOK)
    {
        if (sqlca.sqlcode == -1)
        {
            vDTrazasLog  ("ifnInsertaFatBalance", "UPDATE EN FAT_BALANCE \n" , LOG05);

            /* EXEC SQL UPDATE FAT_BALANCE
                SET IMP_DOCUMENTO = IMP_DOCUMENTO + :dhImp_Docum ,
                    CAN_DOCUMENTO = CAN_DOCUMENTO + :ihCant_Docum
                WHERE COD_CLIENTE  = :lhCod_Cliente
                  AND COD_ITEM     = :ihCod_Item
                  AND COD_TIPDOCUM = :ihCod_Docum
                  AND COD_CICLFACT = :ihCod_CiclFact; */ 

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
            sqlstm.offset = (unsigned int  )331;
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



				  if (sqlca.sqlcode != SQLOK)
				  {
					  vDTrazasLog ("ifnInsertaFatBalance", 
								   " REGISTRO NO SE REALIZO UPDATE de FAT_BALANCE CODE[%ld]"
								   " lhCod_Cliente   	[%ld]"
								   " ihCod_Item  		[%d]" 
								   " ihCod_Docum 		[%d]" 
								   " ihCod_CiclFact  	[%d]" 
								   " ihCant_Docum    	[%d]" 
								   " dhImp_Docum 		[%f]" 
								   " SQLERR             [%s]" 
								   , LOG03, sqlca.sqlcode
								   , lhCod_Cliente, ihCod_Item
								   , ihCod_Docum , ihCod_CiclFact
								   , ihCant_Docum, dhImp_Docum, sqlca.sqlerrm.sqlerrmc   );
				  }
        }
        else { /* Rechazo de Incidencia TM-0414 */
            vDTrazasLog ("ifnInsertaFatBalance", 
            			 " REGISTRO NO SE PUDO INSERTAR EN FAT_BALANCE CODE[%ld]"
            			 " VALORES A INSERTAR EN FAT_BALANCE "
            			 " lhCod_Cliente   	[%ld]"
            			 " ihCod_Item  		[%d]" 
            			 " ihCod_Docum 		[%d]" 
            			 " ihCod_CiclFact  	[%d]" 
            			 " ihCant_Docum    	[%d]" 
            			 " dhImp_Docum 		[%f]" 
            			 " sqlca.sqlcode	[%ld]" 
            			 , LOG03, sqlca.sqlcode
            			 , lhCod_Cliente, ihCod_Item
            			 , ihCod_Docum , ihCod_CiclFact
            			 , ihCant_Docum, dhImp_Docum, sqlca.sqlcode   );
            sqlca.sqlcode = 0; /* LA idea es que imprima el error ocurrido en el LOG y que continue... */
        }
    }

	vDTrazasLog  ("ifnInsertaFatBalance", "Retorno de ifnInsertaFatBalance con sqlca.sqlcode=[%d]\n" , LOG05,sqlca.sqlcode);
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
    int     sts;
    char    szHelpString[1024] = " " ;
    int     iExisteHostId = 0        ;  /* XO-200611141251 */
    char    szHostId     [25] = ""   ;  /* XO-200611141251 */
    int     iResultado    = -1       ;  /* XO-200611141251 */
    BOOL    bClieIniFlag  = FALSE    ;  /* XO-200611141251 */
    BOOL    bClieFinFlag  = FALSE    ;  /* XO-200611141251 */

    memset(&stLineaComando,0    ,sizeof(CARGABALANCELINEACOMANDO));

    fprintf(stdout, "\n\tCargaBalance, Fecha de compilacion: [%s]-[%s]\n",__DATE__, __TIME__);

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
                        fprintf (stdout," -g%ld ", stLineaComando.lCodClienteIni);
                        bClieIniFlag = 1;
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
                        fprintf (stdout," -h%ld ", stLineaComando.lCodClienteFin);
                        bClieFinFlag = 1;
                    }
                    break;
            case 'l':
                    if (strlen (optarg) )
                    {
                        stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                        fprintf (stdout,"-l%d ", stStatus.LogNivel)     ;
                    }
                    break;
            case '?':
                    fprintf(stderr,"\n<< ERROR (main): Se ha ingresado parametro desconocido: -%c >>\n%s\n",optopt,szHelpString);
                    return -1;
            case ':':
                    if ( optopt == 'u' ) {
                        fprintf(stderr,"\n<< ERROR (main): Falta parametro para usuario/password o \"/\" >>\n%s\n",szHelpString);
                        return -1;
                    }
                    if ( optopt == 'c' ) {
                        fprintf(stderr,"\n<< ERROR (main): Falta parametro para ciclo de facturacion. >>\n%s\n",szHelpString);
                        return -1;
                    }
                    if ( optopt == 'l' ) {
                        fprintf(stderr,"\n<< ERROR (main): Falta parametro para Nivel de Log. >>\n%s\n",szHelpString);
                        return -1;
                    }
            default:
                    return -1;

        }/*End Switch */

    } /* End While */
    fprintf (stdout,"\n");

    /* Validacion de Parametros */

    if( (bClieIniFlag==1 && bClieFinFlag==FALSE) || (bClieIniFlag==FALSE && bClieFinFlag==1))
    {
        fprintf (stderr,"\n(EE)\t<< Error : falta opcion '-g' o '-h' >>\n%s\n",szHelpString);
        return (FALSE);
    }

    if((bClieIniFlag==1 && bClieFinFlag==1))
        stLineaComando.iExisteRango = 1;
    else
        stLineaComando.iExisteRango = 0;

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

    /**************************************************************************************/
    /* Crear archivos y directorios de log y errores */

    sts = ifnAbreArchivosLog();


    if ( sts != 0 ) return sts;

    /*********************************************************************************************/

    vDTrazasLog  ( modulo ,"\n\n\t*************************************"
                           "\n\n\t****        Log   CargaBalance     **"
                           "\n\n\t*************************************"
                           ,LOG03);

    vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada CargaBalance  ***"
                           "\n\t\t=> Usuario               [%s]"
                           "\n\t\t=> Ciclo Facturacion     [%d]"
                           "\n\t\t=> Cliente Inicial       [%ld]"
                           "\n\t\t=> Cliente Final         [%ld]"
                           "\n\t\t=> Niv.Log               [%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.iCodCiclFact
                           ,stLineaComando.lCodClienteIni
                           ,stLineaComando.lCodClienteFin
                           ,stLineaComando.iNivLog);

    /************************************************************************************/
    /*          Proceso Principal                       */
    /************************************************************************************/

    strcpy(modulo,"bCargaBalances");

    vDTrazasLog  ( modulo ,"\n\t\t***  Inicio Proceso principal  ***"
                           ,LOG03);

    /* XO-200611141251: Obtencion de Host_id si existe, para rescatar rangos de clientes */
    if( (ifnGetHostId(szHostId))!=0 )
        iExisteHostId = 0;
    else
        iExisteHostId = 1;

    /* Rescate de rangos de clientes desde base de datos */
    iResultado = ifnBuscarRangosClientesBD( (long)stLineaComando.iCodCiclFact, &stLineaComando.lCodClienteIni
                                        , &stLineaComando.lCodClienteFin, &stLineaComando.iExisteRango);
    vDTrazasLog(modulo,"\n\t*** Tratando de obtener datos desde base de datos...\n",LOG03);
    switch(iResultado)
    {
        case  0: /* No existe host_id */
            vDTrazasLog(modulo,"\n\t*** No existe Host_id configurado. Se Continua con rangos de linea de comando. ***\n",LOG03);
            break;
        case  1: /* Obtiene Datos BD */
            vDTrazasLog(modulo,"\n\t*** Se han actualizado datos de clientes desde la Base de datos. ***\n",LOG03);
            break;
        case -1: /* Error: No existen rangos en BD. */
            vDTrazasLog(modulo,"\n\t*** No se encuentran Rangos de clientes configurados en base de datos. ***"
                                "\n\t** Saliendo de la aplicacion, revisar configuracion de rangos en base de datos. **"
                                ,LOG01);
            return FALSE;
        default:
            vDTrazasLog(modulo,"\n\t*** No se encuentran Rangos de clientes configurados en base de datos. ***"
                                "\n\t** Saliendo de la aplicacion, revisar configuracion de rangos en base de datos. **"
                                ,LOG01);
            return FALSE;
    }



    vDTrazasLog(modulo,"\n\t*** Datos de Host_id Obtenidos ***\n"
                      "\n\t     Host ID        : [%s]"
                      "\n\t     iExisteHostId  : [%d]"
                      "\n\t     Cliente Inicial: [%ld]"
                      "\n\t     Cliente Final  : [%ld]"
                      "\n\t     Existe Rango   : [%d]"
                      , LOG03
                      , szHostId
                      , iExisteHostId
                      , stLineaComando.lCodClienteIni
                      , stLineaComando.lCodClienteFin
                      , stLineaComando.iExisteRango);



    bRetorno = bObtieneFechasCiclo(stLineaComando.iCodCiclFact);
    if (bRetorno == FALSE)
    {
        vDTrazasLog(modulo,"\n\t*** Imposible Obtener fechas para el ciclo ingresado. ***", LOG01);
        return FALSE;
    }

    iContLeidos = 0;
    iContTotal  = 0;
    bIndPrimera = 1;

/* 20040310 TM-200403030552 Se validad existencia de documentos GE_TIPDOCUMEN vs FAD_CONFBALANCE */
    vDTrazasLog(modulo,"\n\t*** Verificando Tipos de Documentos ***\n", LOG03);
    if(!bfnValidaTipoDocumento())
    {
        fprintf(stderr, "\n\n\n\n\n\t\t\t\t\t*** ATENCION ***\n\n\n\t*** Existen documentos en la tabla GE_TIPDOCUMEN NO configurados en la tabla FAD_CONFBALANCE ***\n\n\n\n\n");
        fprintf(stderr, "\t\tRevise la Informacion faltante en el LOG y vuelva a ejecutar CargaBalance\n\n\n\n");
        vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Existen documentos en la tabla GE_TIPDOCUMEN NO configurados en la tabla FAD_CONFBALANCE ***\n", LOG01);
        vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Existen documentos en la tabla GE_TIPDOCUMEN NO configurados en la tabla FAD_CONFBALANCE ***\n", LOG01);
        return FALSE;
    }
    vDTrazasLog(modulo,"\n\t*** Tipos de Documentos Verificados OK ***\n", LOG03);


    if (!bfnWrapperValidaTrazaProc(stLineaComando.iCodCiclFact, iPROC_BALANCE, iIND_FACT_ENPROCESO))
        return FALSE;
    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnWrapperValidaTrazaProc", LOG01);
        return FALSE;
    }
    bfnWrapperSelectTrazaProc (stLineaComando.iCodCiclFact, iPROC_BALANCE, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);


    bRetorno = bProcesaClientes(szHostId, iExisteHostId);


    /********************************************************************************/
    /********************************************************************************/
    bfnWrapperSelectTrazaProc (stLineaComando.iCodCiclFact, iPROC_BALANCE, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);

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

    if(!bfnWrapperUpdateTrazaProc(stTrazaProc))
        return FALSE;
    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnWrapperUpdateTrazaProc", LOG01);
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

/********* Procesos para Cargar Tablas de Balance                        ****/
BOOL bCargaCoPagos(long lCodCliente, char *szFecHasta, int *iIndBalance)
{
char modulo[]="bCargaCoPagos";
BOOL ret;
BOOL bIndInsert;
int i;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 long   lCodCli;
 char	szhFecHasta[15];
/* EXEC SQL END DECLARE SECTION; */ 


    lCodCli     = lCodCliente;
    strcpy(szhFecHasta, szFecHasta);


    vDTrazasLog  ( modulo , "\n\t\t** Select en CO_PAGOS **"
                            "\n\t\t Cliente          : [%d]"
                            "\n\t\t Fecha Hasta Llam : [%s]\n"
                            ,LOG05
                            ,lCodCli
                            ,szhFecHasta);

    /* EXEC SQL DECLARE Cursor_Pagos CURSOR FOR
        SELECT  A.COD_ITEM,
                B.COD_TIPDOCUM,
                SUM(ROUND(B.IMP_PAGO, 2)),
				COUNT(1)
        FROM FAD_CONFBALANCE A,
             CO_PAGOS        B
        WHERE A.COD_ORIGEN      = 'PAGOS'
        AND   B.COD_CLIENTE     = :lCodCli
        AND   B.FEC_EFECTIVIDAD <=  TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')
        AND   B.COD_TIPDOCUM    = A.COD_TIPDOCUM
        AND   B.COD_CICLFACT_BAL IS NULL
        GROUP BY A.COD_ITEM,B.COD_TIPDOCUM
		ORDER BY A.COD_ITEM,B.COD_TIPDOCUM; */ 


    if ( SQLCODE != SQLOK  && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE Cursor_Pagos [%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error DECLARE Cursor_Pagos %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
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
    sqlstm.stmt = sq0010;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )370;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN Cursor_Pagos  [%d]***"
                              ,LOG03, SQLCODE);

        vDTrazasError(modulo,"%s Error OPEN Cursor_Pagos %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }

    ret = 1 ;

    iContLeidos     = 0;
    iContTotal      = 0;
    
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
        sqlstm.offset = (unsigned int  )393;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&sthCoPagos->ihCodItem;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&sthCoPagos->ihCodDocum;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&sthCoPagos->fhImpPago;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&sthCoPagos->iContDocum;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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
                vDTrazasLog  ( modulo ,"\n\t\t** Error FETCH Cursor_Pagos  [%d]***"
                                      ,LOG03, SQLCODE);

                vDTrazasError(modulo,"%s Error FETCH Cursor_Pagos %s [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc, SQLCODE);
                fnOraRollBack();
                return FALSE;
            }
        }

        /**** Procesa clientes leidos en FETCH de Pagos ****/
        vDTrazasLog  ( modulo ,"\n\t\t** Pagos leidos : [%d]  ***"
                              ,LOG05
                              ,iContLeidos);

        
        for ( i = 0; i< iContLeidos  ; i++)
        {
            vDTrazasLog(modulo, "\n\t\tCodCliente     [%d]=[%ld]"
            				    "\n\t\tCodItem        [%d]=[%d]"
            				    "\n\t\tCodDocum       [%d]=[%d]"
            				    "\n\t\tImpPago Total  [%d]=[%f]"
            				    "\n\t\tCantidad Docum [%d]=[%d]\n"
            				    ,LOG05, i, lCodCli
            				    , i, sthCoPagos[i].ihCodItem
            				    , i, sthCoPagos[i].ihCodDocum 
            				    , i, sthCoPagos[i].fhImpPago
            				    , i, sthCoPagos[i].iContDocum);

            bIndInsert=ifnInsertaFatBalance (lCodCli
	                                        ,sthCoPagos[i].ihCodItem
	                                        ,sthCoPagos[i].ihCodDocum
	                                        ,stLineaComando.iCodCiclFact
	                                        ,sthCoPagos[i].iContDocum
	                                        ,sthCoPagos[i].fhImpPago
	                                        );
                                            
            if ( bIndInsert != SQLOK )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error en bCargaCoPagos al Insert en FAT_BALANCE [%d] ***\n"
                                      ,LOG03, bIndInsert);
                vDTrazasError(modulo,"%s Error  Error en bCargaCoPagos al Insert en FAT_BALANCE [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3), bIndInsert);
                fnOraRollBack();
                return FALSE;
            }else{
            	*iIndBalance = 1;
            }
        }     /* Fin For */
    } /* Fin While FETCH Cursor_Pagos */

    /* EXEC SQL CLOSE Cursor_Pagos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )424;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error CLOSE Cursor_Pagos  [%d]***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error CLOSE Cursor_Pagos %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }
    
    return 1;
} /* Fin bCargaCoPagos() */

BOOL bUpdateCoPagos(long lCodCliente, char *szFecHasta)
{
char modulo[]="bUpdateCoPagos";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 long   lCodCli;
 char	szhFecHasta[15];
 int   iCodCicloFact   ;
/* EXEC SQL END DECLARE SECTION; */ 


    lCodCli     = lCodCliente;
    strcpy(szhFecHasta, szFecHasta);
    iCodCicloFact   = stLineaComando.iCodCiclFact;


    vDTrazasLog  ( modulo , "\n\t\t** Update en CO_PAGOS **"
                            "\n\t\t Cliente          : [%d]"
                            "\n\t\t Fecha Hasta Llam : [%s]"
                            "\n\t\t CodCicloFact     : [%d]"
                            ,LOG05
                            ,lCodCli
                            ,szhFecHasta
                            ,iCodCicloFact);


		/* EXEC SQL UPDATE CO_PAGOS
		 SET COD_CICLFACT_BAL = :iCodCicloFact
        WHERE COD_CLIENTE     = :lCodCli
        AND   FEC_EFECTIVIDAD <=  TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')
        AND   COD_CICLFACT_BAL IS NULL
        AND   EXISTS ( SELECT 1 
        			   FROM FAD_CONFBALANCE F
			  		   WHERE F.COD_ORIGEN      = 'PAGOS'
					   AND   COD_TIPDOCUM = F.COD_TIPDOCUM )
        ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_PAGOS  set COD_CICLFACT_BAL=:b0 where (((COD_CLIE\
NTE=:b1 and FEC_EFECTIVIDAD<=TO_DATE(:b2,'YYYYMMDDHH24MISS')) and COD_CICLFACT\
_BAL is null ) and exists (select 1  from FAD_CONFBALANCE F where (F.COD_ORIGE\
N='PAGOS' and COD_TIPDOCUM=F.COD_TIPDOCUM)))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )439;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&iCodCicloFact;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lCodCli;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
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



    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error Al Actualizar Tabla CO_PAGOS [%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error Al Actualizar Tabla CO_PAGOS %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }
	return TRUE;
}

BOOL bCargaBalanceDocu(long lCodCliente, char *szFecHasta, int *iIndBalance)
{
 char modulo[]="bCargaBalanceDocu";
 BOOL ret;
 BOOL bIndInsert;
 int i;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lCodCli;
    char	szhFecHasta[15];
/* EXEC SQL END DECLARE SECTION; */ 


    lCodCli         = lCodCliente;
    strcpy(szhFecHasta, szFecHasta);
    
    
    vDTrazasLog  ( modulo , "\n\t\t** Select en Balance de Documentos **"
                            "\n\t\t Cliente          : [%d]"
                            "\n\t\t Fecha Hasta Llam : [%s]"
                            ,LOG05
                            ,lCodCli
                            ,szhFecHasta);

    /* EXEC SQL DECLARE Cursor_BalanceDocum CURSOR FOR
        SELECT  CONF.COD_ITEM,
	 			CONF.COD_TIPDOCUM,
	 			ROUND (SUM (TOT_FACTURA),2),
	 			COUNT(1)
		FROM (SELECT COD_TIPDOCUM,
  	       			 TOT_FACTURA
        	  	FROM FA_HISTDOCU 
       		  	WHERE COD_CLIENTE  = :lCodCli
         	  	AND   FEC_EMISION <= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')
         	  	AND   COD_CICLFACT_BAL IS NULL
 				AND   IND_BALANCE IS NULL) DOCU,
	  		 FAD_CONFBALANCE CONF
		WHERE CONF.COD_ORIGEN   = 'DOCUM'
  		AND CONF.COD_TIPDOCUM = DOCU.COD_TIPDOCUM
		GROUP BY CONF.COD_ITEM, CONF.COD_TIPDOCUM
		ORDER BY CONF.COD_ITEM, CONF.COD_TIPDOCUM; */ 



    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE Cursor_BalanceDocum [%d] ***"
                              ,LOG03, SQLCODE);

        vDTrazasError(modulo,"%s Error DECLARE Cursor_BalanceDocum %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }


    /* EXEC SQL OPEN Cursor_BalanceDocum ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0012;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )466;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN Cursor_BalanceDocum [%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error OPEN Cursor_BalanceDocum %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }

    ret = 1 ;

    iContLeidos     = 0;
    iContTotal      = 0;
    

    
    while ( ret )
    {
        /* EXEC SQL FETCH Cursor_BalanceDocum INTO
               :sthBalDocum; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )489;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&sthBalDocum->ihCodItem;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&sthBalDocum->ihCodDocum;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&sthBalDocum->fhImpPago;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&sthBalDocum->iContDocum;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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
                vDTrazasLog  ( modulo ,"\n\t\t** Error FETCH Cursor_BalanceDocum [%d] ***"
                                      ,LOG03, SQLCODE);
                vDTrazasError(modulo,"%s Error FETCH Cursor_BalanceDocum %s [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc, SQLCODE);
                fnOraRollBack();

                return FALSE;
            }
        }

        /**** Procesa clientes leidos en FETCH de Co Cartera ****/

        vDTrazasLog  ( modulo ,"\n\t\t** Balances leidos : [%d]  ***"
                              ,LOG05
                              ,iContLeidos);

        
        for ( i = 0; i< iContLeidos  ; i++)
        {
            
             
            vDTrazasLog(modulo, "\n\t\tCodCliente     [%d]=[%ld]"
            					"\n\t\tCodItem        [%d]=[%d]"
            					"\n\t\tCodDocum       [%d]=[%d]"
            					"\n\t\tImpPago Total  [%d]=[%f]"
            				    "\n\t\tCantidad Docum [%d]=[%d]"
            					, LOG05, i, lCodCli
            					, i, sthBalDocum[i].ihCodItem
            					, i, sthBalDocum[i].ihCodDocum 
            					, i, sthBalDocum[i].fhImpPago
            					, i, sthBalDocum[i].iContDocum);

            bIndInsert=ifnInsertaFatBalance (lCodCli
	                                        ,sthBalDocum[i].ihCodItem
	                                        ,sthBalDocum[i].ihCodDocum
	                                        ,stLineaComando.iCodCiclFact
	                                        ,sthBalDocum[i].iContDocum
	                                        ,sthBalDocum[i].fhImpPago);
            
            if ( bIndInsert != SQLOK )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error en bCargaBalanceDocu al Insert en FAT_BALANCE [%d]  ***\n"
                                      ,LOG03, bIndInsert);

                vDTrazasError(modulo,"%s Error  Error en bCargaBalanceDocu al Insert en FAT_BALANCE [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3), bIndInsert);

                fnOraRollBack();
                return FALSE;
            }else{
            	*iIndBalance = 1;
            }
        }     /* Fin For */

    } /* Fin While FETCH Cursor_Cartera */

    /* EXEC SQL CLOSE Cursor_BalanceDocum; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )520;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error CLOSE Cursor_BalanceDocum [%d] ***"
                              ,LOG03, SQLCODE);

        vDTrazasError(modulo,"%s Error CLOSE Cursor_BalanceDocum %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);

        fnOraRollBack();

        return FALSE;
    }

    return 1;

} /* Fin bCargaBalanceDocu() */

BOOL bUpdateBalanceDocu(long lCodCliente, char *szFecHasta, int iIndBalance)
{
char modulo[]="bUpdateBalanceDocu";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 long   lCodCli;
 char	szhFecHasta[15];
 int   iCodCicloFact   ;
 int   ihIndBalance    ;
/* EXEC SQL END DECLARE SECTION; */ 


    lCodCli      = lCodCliente;
    ihIndBalance = iIndBalance;
    strcpy(szhFecHasta, szFecHasta);
    iCodCicloFact   = stLineaComando.iCodCiclFact;


    vDTrazasLog  ( modulo , "\n\t\t** Update en Balance Documentos **"
                            "\n\t\t Cliente          : [%d]"
                            "\n\t\t Fecha Hasta Llam : [%s]"
                            "\n\t\t CodCicloFact     : [%d]"
                            "\n\t\t iIndBalance      : [%d]"
                            ,LOG05
                            ,lCodCli
                            ,szhFecHasta
                            ,iCodCicloFact
                            ,iIndBalance);


	/* EXEC SQL UPDATE FA_HISTDOCU
	 SET COD_CICLFACT_BAL = :iCodCicloFact ,
	 	 IND_BALANCE      = :ihIndBalance	 	  
    WHERE COD_CLIENTE  = :lCodCli
    AND   FEC_EMISION <= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')
    AND   COD_CICLFACT_BAL IS NULL
	AND   IND_BALANCE IS NULL
	AND   EXISTS ( SELECT 1 
       			   FROM FAD_CONFBALANCE CONF
		  		   WHERE CONF.COD_ORIGEN   = 'DOCUM'
				   AND   COD_TIPDOCUM = CONF.COD_TIPDOCUM )
    ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update FA_HISTDOCU  set COD_CICLFACT_BAL=:b0,IND_BALANCE=:b1\
 where ((((COD_CLIENTE=:b2 and FEC_EMISION<=TO_DATE(:b3,'YYYYMMDDHH24MISS')) a\
nd COD_CICLFACT_BAL is null ) and IND_BALANCE is null ) and exists (select 1  \
from FAD_CONFBALANCE CONF where (CONF.COD_ORIGEN='DOCUM' and COD_TIPDOCUM=CONF\
.COD_TIPDOCUM)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )535;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iCodCicloFact;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihIndBalance;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lCodCli;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
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



    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error Al Actualizar Tabla FA_HISTDOCU [%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error Al Actualizar Tabla FA_HISTDOCU %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }
    
	return TRUE;
}



BOOL bCargaCoAjustes(long lCodCliente, char *szFecHasta, int *iIndBalance)
{
char modulo[]="bCargaCoAjustes";
BOOL ret;
BOOL bIndInsert;
int i;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 long   lCodCli;
 char	szhFecHasta[15];
/* EXEC SQL END DECLARE SECTION; */ 


    lCodCli     = lCodCliente;
    strcpy(szhFecHasta, szFecHasta);


    vDTrazasLog  ( modulo , "\n\t\t** Select en CO_AJUSTES **"
                            "\n\t\t Cliente          : [%d]"
                            "\n\t\t Fecha Hasta Llam : [%s]"
                            ,LOG05
                            ,lCodCli
                            ,szhFecHasta);

    /* EXEC SQL DECLARE Cursor_Ajustes CURSOR FOR
        SELECT  A.COD_ITEM,
        		B.COD_TIPDOCUM,
        		ROUND(sum (B.IMPORTE_DEBE), 2),
	  			count(1)	
		FROM 	FAD_CONFBALANCE A,
     			CO_AJUSTES      B
		WHERE A.COD_ORIGEN      = 'AJUST'
		AND   B.COD_CLIENTE     = :lCodCli
		AND   B.FEC_EFECTIVIDAD<= TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')
		AND   B.COD_TIPDOCUM    = A.COD_TIPDOCUM
		AND   COD_CICLFACT_BAL IS NULL
		group by A.COD_ITEM, B.COD_TIPDOCUM
		ORDER BY A.COD_ITEM, B.COD_TIPDOCUM; */ 

;

    if ( SQLCODE != SQLOK  && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE Cursor_Ajustes [%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error DECLARE Cursor_Ajustes %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }

    /* EXEC SQL OPEN Cursor_Ajustes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0014;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )566;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN Cursor_Ajustes  [%d]***"
                              ,LOG03, SQLCODE);

        vDTrazasError(modulo,"%s Error OPEN Cursor_Ajustes %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }

    ret = 1 ;

    iContLeidos     = 0;
    iContTotal      = 0;
    
    /* Proceso sobre Cursor_Ajustes */
    while ( ret )
    {
        /* EXEC SQL FETCH Cursor_Ajustes INTO
               :sthCoAjustes; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )589;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&sthCoAjustes->ihCodItem;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&sthCoAjustes->ihCodDocum;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&sthCoAjustes->fhImpPago;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )sizeof(struct COPAGOS);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&sthCoAjustes->iContDocum;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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
                vDTrazasLog  ( modulo ,"\n\t\t** Error FETCH Cursor_Ajustes  [%d]***"
                                      ,LOG03, SQLCODE);

                vDTrazasError(modulo,"%s Error FETCH Cursor_Ajustes %s [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc, SQLCODE);
                fnOraRollBack();
                return FALSE;
            }
        }

        /**** Procesa clientes leidos en FETCH de Pagos ****/
        vDTrazasLog  ( modulo ,"\n\t\t** Ajustes leidos : [%d]  ***"
                              ,LOG05
                              ,iContLeidos);

        
        for ( i = 0; i< iContLeidos  ; i++)
        {
            vDTrazasLog(modulo, "\n\t\tCodCliente     [%d]=[%ld]"
            				    "\n\t\tCodItem        [%d]=[%d]"
            				    "\n\t\tCodDocum       [%d]=[%d]"
            				    "\n\t\tImpPago Total  [%d]=[%f]"
            				    "\n\t\tCantidad Docum [%d]=[%d]"
            				    ,LOG05, i, lCodCli
            				    , i, sthCoAjustes[i].ihCodItem
            				    , i, sthCoAjustes[i].ihCodDocum 
            				    , i, sthCoAjustes[i].fhImpPago
            				    , i, sthCoAjustes[i].iContDocum);

            bIndInsert=ifnInsertaFatBalance (lCodCli
	                                        ,sthCoAjustes[i].ihCodItem
	                                        ,sthCoAjustes[i].ihCodDocum
	                                        ,stLineaComando.iCodCiclFact
	                                        ,sthCoAjustes[i].iContDocum
	                                        ,sthCoAjustes[i].fhImpPago
	                                        );
                                            
            if ( bIndInsert != SQLOK )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error en bCargaCoAjustes al Insert en FAT_BALANCE [%d] ***\n"
                                      ,LOG03, bIndInsert);
                vDTrazasError(modulo,"%s Error  Error en bCargaCoAjustes al Insert en FAT_BALANCE [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3), bIndInsert);
                fnOraRollBack();
                return FALSE;
            }else{
            	*iIndBalance = 1;
            }
        }     /* Fin For */
    } /* Fin While FETCH Cursor_Ajustes */

    /* EXEC SQL CLOSE Cursor_Ajustes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )620;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error CLOSE Cursor_Ajustes  [%d]***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error CLOSE Cursor_Ajustes %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }

    return 1;
} /* Fin bCargaCoAjustes() */

BOOL bUpdateCoAjustes(long lCodCliente, char *szFecHasta)
{
char modulo[]="bUpdateCoAjustes";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 long   lCodCli;
 char	szhFecHasta[15];
 int   iCodCicloFact   ;
/* EXEC SQL END DECLARE SECTION; */ 


    lCodCli     = lCodCliente;
    strcpy(szhFecHasta, szFecHasta);
    iCodCicloFact   = stLineaComando.iCodCiclFact;


    vDTrazasLog  ( modulo , "\n\t\t** Update en CO_AJUSES **"
                            "\n\t\t Cliente          : [%d]"
                            "\n\t\t Fecha Hasta Llam : [%s]"
                            "\n\t\t CodCicloFact     : [%d]"
                            ,LOG05
                            ,lCodCli
                            ,szhFecHasta
                            ,iCodCicloFact);


		/* EXEC SQL UPDATE CO_AJUSTES
		 SET COD_CICLFACT_BAL = :iCodCicloFact
        WHERE COD_CLIENTE     = :lCodCli
        AND   FEC_EFECTIVIDAD <=  TO_DATE(:szhFecHasta,'YYYYMMDDHH24MISS')
        AND   COD_CICLFACT_BAL IS NULL
        AND   EXISTS ( SELECT 1 
        			   FROM FAD_CONFBALANCE F
			  		   WHERE F.COD_ORIGEN      = 'AJUST'
					   AND   COD_TIPDOCUM = F.COD_TIPDOCUM )
        ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_AJUSTES  set COD_CICLFACT_BAL=:b0 where (((COD_CL\
IENTE=:b1 and FEC_EFECTIVIDAD<=TO_DATE(:b2,'YYYYMMDDHH24MISS')) and COD_CICLFA\
CT_BAL is null ) and exists (select 1  from FAD_CONFBALANCE F where (F.COD_ORI\
GEN='AJUST' and COD_TIPDOCUM=F.COD_TIPDOCUM)))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )635;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&iCodCicloFact;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lCodCli;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
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



    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error Al Actualizar Tabla CO_AJUSTES [%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error Al Actualizar Tabla CO_AJUSTES %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }
	return TRUE;
}

BOOL bObtieneFechasCiclo(int iCodCiclFact)
{
char modulo[]="bObtieneFechasCiclo";

/* EXEC SQL BEGIN DECLARE SECTION; */ 


long	iCodCiclo;
char    szFecDesde[15];/* EXEC SQL VAR szFecDesde IS STRING (15); */ 

char    szFecHasta[15];/* EXEC SQL VAR szFecHasta IS STRING (15); */ 

int     iCodCicloCli;

/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclo = iCodCiclFact;

    /* EXEC SQL
    SELECT TO_CHAR(FEC_DESDELLAM,'YYYYMMDDHH24MISS'),
           TO_CHAR(FEC_HASTALLAM,'YYYYMMDDHH24MISS'),
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
    sqlstm.stmt = "select TO_CHAR(FEC_DESDELLAM,'YYYYMMDDHH24MISS') ,TO_CHAR\
(FEC_HASTALLAM,'YYYYMMDDHH24MISS') ,COD_CICLO into :b0,:b1,:b2  from FA_CICLFA\
CT where COD_CICLFACT=:b3";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )662;
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
        vDTrazasLog  (modulo ,"\n\t\t** Error Select FA_CICLFACT [%d] ***"
                             ,LOG03, SQLCODE);

        vDTrazasError(modulo,"%s Error Select FA_CICLFACT  %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc, SQLCODE);
        fnOraRollBack();
        return FALSE;
    }

    strcpy(szFecUltFact, szFecDesde); /* PGG SOPORTE CO-059 17-04-2006 */
    strcpy( szFecActual, szFecHasta); /* PGG SOPORTE CO-059 17-04-2006 */

    strcpy(sthFaCicloFact.szhFecDesdeLLam, szFecDesde);
    strcpy(sthFaCicloFact.szhFecHastaLLam, szFecHasta);
    sthFaCicloFact.iCodCiclo = iCodCicloCli;

    vDTrazasLog  ( modulo , "\n\t\t** Select en FA_CICLFACT  ***"
                            "\n\t\t** Fecha Desde : [%s]     ***"
                            "\n\t\t** Fecha Hasta : [%s]     ***"
                            ,LOG03
                            ,sthFaCicloFact.szhFecDesdeLLam
                            ,sthFaCicloFact.szhFecHastaLLam);
    return 1;
}


/************************************************************************/
/* Funcion :  bProcesaClientes                                          */
/*      Realiza proceso principal de carga de balance                   */
/************************************************************************/
BOOL bProcesaClientes (const char *szpHostId, int iExisteHostId)
{

char modulo[]="bProcesaClientes";
BOOL bExiste = 1;
int   i;
int   iContLeidos = 0;
int   iContTotal  = 0;
char  szCadenaSQL [1024];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

 int    iCodCiclo;
 int    iCodCicloFact;
 long   lCodClienteIni;
 long   lCodClienteFin;
 char   FEC_PARTIDA[15];/* EXEC SQL VAR FEC_PARTIDA IS STRING (15); */ 

 char   FEC_HASTA[15];/* EXEC SQL VAR FEC_HASTA IS STRING (15); */ 

 char   szFecHasta[15];/* EXEC SQL VAR szFecHasta IS STRING (15); */ 

 int    ihExisteHostId;
 char   szhHostId[25]=""; /* EXEC SQL VAR szhHostId IS STRING (25); */ 

 int    ihCodProceso = 3000;
 int    ihExisteRangoClientes = 0;
 const 	int ihValorCero= 0;
 const 	int ihValorUno = 1;
 int	iIndBalance;
 
 long	lhCodCliente [MAXCLIENTES];
 char   szhFecEmision[MAXCLIENTES][15];
 char   szhRowid     [MAXCLIENTES][19];

/* EXEC SQL END DECLARE SECTION; */ 


    iCodCiclo       = sthFaCicloFact.iCodCiclo;
    lCodClienteIni  = stLineaComando.lCodClienteIni;
    lCodClienteFin  = stLineaComando.lCodClienteFin;
    iCodCicloFact   = stLineaComando.iCodCiclFact;
    ihExisteHostId  = iExisteHostId;
    strcpy(szhHostId, szpHostId);
    ihExisteRangoClientes = stLineaComando.iExisteRango;
    strcpy(szFecHasta,sthFaCicloFact.szhFecHastaLLam);

    /* EXEC SQL
        SELECT TO_CHAR(SYSDATE - 365, 'YYYYMMDDHH24MISS'),
               TO_CHAR(FEC_INICIO, 'YYYYMMDDHH24MISS')
        INTO   :FEC_PARTIDA, :FEC_HASTA
        FROM   FA_TRAZAPROC
        WHERE   COD_PROCESO = :ihCodProceso
        AND COD_CICLFACT    = :iCodCicloFact
        AND ( (HOST_ID = :szhHostId) OR ( 1 <> :ihExisteHostId) ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR((SYSDATE-365),'YYYYMMDDHH24MISS') ,TO_CHAR\
(FEC_INICIO,'YYYYMMDDHH24MISS') into :b0,:b1  from FA_TRAZAPROC where ((COD_PR\
OCESO=:b2 and COD_CICLFACT=:b3) and (HOST_ID=:b4 or 1<>:b5))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )693;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)FEC_PARTIDA;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)FEC_HASTA;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iCodCicloFact;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[4] = (unsigned long )25;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihExisteHostId;
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
        strcpy( FEC_PARTIDA, "20030501000000");
        strcpy( FEC_HASTA,   "30000101235959");
    }
    /* ASIGNAMOS LA FECHA ACTUAL COMO FECHA HASTA */
    /* strcpy( szFecActual, FEC_HASTA); */ /* PGG SOPORTE Se comenta para usar la fec_hastallam de la Fa_ciclfact CO-059 17-04-2006 */
    SQLCODE = 0;

	/* realiza prepare para tablas ciclo */
/*  if (!bfnPrepare ())																			   
  {																							   
      vDTrazasLog  ( modulo ,"\n\t\t** Error en PREPARE de tablas ciclo[%d] ***",LOG00, SQLCODE);
  }																							   */

    vDTrazasLog  ( modulo ,"\n\t\t*** bProcesaClientes  ***"
                           "\n\t\t=> Ciclo Facturacion     [%d]"
                           "\n\t\t=> Ciclo Clientes        [%d]"
                           "\n\t\t=> Cliente Inicial       [%ld]"
                           "\n\t\t=> Cliente Final         [%ld]"
                           "\n\t\t=> Existe Rng Clientes   [%d]"
                           ,LOG03
                           ,stLineaComando.iCodCiclFact
                           ,iCodCiclo
                           ,stLineaComando.lCodClienteIni
                           ,stLineaComando.lCodClienteFin
                           ,stLineaComando.iExisteRango);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    
    sprintf(szCadenaSQL," SELECT DISTINCT COD_CLIENTE \n"
    					"\t , TO_CHAR(FEC_EMISION,'YYYYMMDDHH24MISS') \n"
						"\t , ROWID \n"
						"\t FROM FA_FACTDOCU_%d\n"
						"\t WHERE COD_CICLFACT = %d\n"
						"\t AND ( (COD_CLIENTE BETWEEN %ld AND %ld) OR (1 <> %d) )\n"
						"\t AND (IND_BALANCE = 0 OR IND_BALANCE IS NULL)\n"
						, iCodCicloFact, iCodCicloFact, lCodClienteIni, lCodClienteFin, ihExisteRangoClientes);
    					
    vDTrazasLog ( modulo,"\n\t** CadenaSQL  para Select de clientes.**\n\t%s"
                         ,LOG04, szCadenaSQL);


	/* EXEC SQL PREPARE stConsultaDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )732;
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



	if (SQLCODE) {
		vDTrazasError(modulo,"<< Fallo en 'PREPARE' de la Consulta de Clientes >>\n\t%s",
					  LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Consulta de Clientes >>",
					  LOG01);
	    return SQLCODE;
	}
    
    
    
    
    /* EXEC SQL DECLARE Cursor_Clientes CURSOR for stConsultaDinamica; */ 


    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error Declare Cusor_Clientes {%d] ***"
                              ,LOG03, SQLCODE);
        vDTrazasError(modulo,"%s Error Declare Cursor_Clientes  %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc, SQLCODE);
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
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )751;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN  Cusor_Clientes SQLCODE : [%d] ***"
                              ,LOG03
                              ,sqlca.sqlcode);
        vDTrazasError(modulo,"%s Error Open Cursor_Clientes  %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3)
                            ,sqlca.sqlerrm.sqlerrmc, sqlca.sqlcode);

        fnOraRollBack();
        return FALSE;
    }

    iContLeidos = 0;
    iContTotal  = 0;

    while ( bExiste )
    {
        /* EXEC SQL FETCH Cursor_Clientes INTO
                :lhCodCliente,
                :szhFecEmision,
                :szhRowid; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )766;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmision;
        sqlstm.sqhstl[1] = (unsigned long )15;
        sqlstm.sqhsts[1] = (         int  )15;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[2] = (unsigned long )19;
        sqlstm.sqhsts[2] = (         int  )19;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        vDTrazasLog  ( modulo ,"\n\t\t** Resultado FETCH : [%d]  ***"
                              ,LOG04
                              ,SQLCODE);

        if ( iContLeidos == 0 )
            iContLeidos = sqlca.sqlerrd[2];
        else
            iContLeidos =  sqlca.sqlerrd[2] - iContTotal;

        iContTotal  = sqlca.sqlerrd[2];

        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE != SQLNOTFOUND )
            {
                vDTrazasLog  ( modulo ,"\n\t\t** Error Open Cusor_Clientes [%d] ***"
                                      ,LOG03, SQLCODE);
                vDTrazasError(modulo,"%s Error Open Cursor_Clientes  %s [%d]\n"
                                    ,LOG03
                                    ,cfnGetTime(3)
                                    ,sqlca.sqlerrm.sqlerrmc, SQLCODE);
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

        vDTrazasLog  ( modulo ,"\n\t\t** Clientes leidos : [%d]  ***",LOG03,iContLeidos);

        for ( i = 0 ; i < iContLeidos ; i++ )
        {
            lContClientes++;
            
            iIndBalance = 3;

        	SQLCODE = 0;

        	vDTrazasLog  ( modulo ,"\n\t\t**Procesando Cliente : [%d] , Fec. Emision [%s] -- FecUltFact[%s] ***"
                          		  ,LOG05
                          		  ,lhCodCliente[i],szhFecEmision[i], szFecUltFact);

            if (!bCargaCoPagos(lhCodCliente[i], szFecHasta,&iIndBalance))
                return FALSE;
                
            if (!bUpdateCoPagos(lhCodCliente[i], szFecHasta))
            	return FALSE;

            if (!bCargaBalanceDocu(lhCodCliente[i], szFecHasta,&iIndBalance))
                return FALSE;
            
            if (!bUpdateBalanceDocu(lhCodCliente[i], szFecHasta,iIndBalance))
            	return FALSE;
            
            if (!bCargaCoAjustes(lhCodCliente[i], szFecHasta,&iIndBalance))
                return FALSE;
                
            if (!bUpdateCoAjustes(lhCodCliente[i], szFecHasta))
                return FALSE;

            if (!bCargaItemesCero(lhCodCliente[i], iCARGOS_MES, FACTCICLAFEC))
                return FALSE;

            if (!bCargaItemesCero(lhCodCliente[i],iTOTAL_FACTURA, FACTCICLAFEC))
                return FALSE;

            if (!bCargaItemesCero(lhCodCliente[i], iTOTAL_PAGAR, FACTCICLAFEC))
                return FALSE;

            if (!bCargaBalanceAnterior(lhCodCliente[i]))
                return FALSE;

            /* Incidencia TM-%0414 */
            if (iUpdateFatBalance(lhCodCliente[i])) 
            {
				vDTrazasLog  ( "bProcesaClientes","\n\t\t** UPDATE FAT_BALANCE OK ***",LOG03);
            }
            else  
			{
                vDTrazasLog ( 	"bProcesaClientes", 
                				" REGISTRO NO SE PUDO INSERTAR EN FAT_BALANCE CODE[%ld]"
                				" VALORES A INSERTAR EN FAT_BALANCE "
                 				" lhCod_Cliente  [%ld]"
                 				, LOG03, sqlca.sqlcode, lhCodCliente[i] );
                 return FALSE;
            }
            
            
            /*Actualiza Indice Balance*/
            if (iUpdateIndBalance(szhRowid[i], iIndBalance)) 
            {
				vDTrazasLog  ( "bProcesaClientes","\n\t\t** UPDATE Indice Balance OK , Cliente [%ld], Indice [%d] ***",LOG03,lhCodCliente[i],iIndBalance);
            }
            else  
			{
                vDTrazasLog ( 	"bProcesaClientes", 
                				" No se puedo actualizar el indice balance para el cliente [%ld] CODE[%ld]"
                				, LOG03, lhCodCliente[i], sqlca.sqlcode );
                 return FALSE;
            }
            
        }
    } /* End While */

    return 1;
}

/****************************************************************************/
/*                         funcion : bfnUpdateIndConsumosLibroIva                     */
/****************************************************************************/
BOOL iUpdateIndBalance( char *szRowid, int iIndBalance)
{
char modulo[]="Update Ind Balance";
static char szCadenaSQL[1024];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     int   ihIndBalance    ;
     int   iCodCicloFact   ;
	 char  szhRowid   [19] ;
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Inicio de iUpdateIndBalance***\n",LOG04);

	strcpy(szhRowid,szRowid);
	ihIndBalance = iIndBalance;
	iCodCicloFact   = stLineaComando.iCodCiclFact;
	

    vDTrazasLog (modulo,"\n\t*** iCodCicloFact [%d]***"
                        "\n\t*** ihIndBalance  [%d]***"
                        "\n\t*** lhCodCiclFBal [%ld]***"
                        "\n\t*** szhRowid      [%s]***"
                        ,LOG04       ,iCodCicloFact
                        ,ihIndBalance,iCodCicloFact,szhRowid);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    
    sprintf(szCadenaSQL," UPDATE FA_FACTDOCU_%d SET "
						"\t IND_BALANCE = %d, "
						"\t COD_CICLFACT_BAL = %ld "
						"\t WHERE ROWID = '%s' "
						, iCodCicloFact, ihIndBalance, iCodCicloFact, szhRowid);
						
	vDTrazasLog (modulo,"\n\t*** szCadenaSQL***"
                        "\n\t*** [%s] ***"
                        ,LOG04       ,szCadenaSQL);

	/* EXEC SQL PREPARE stUpdateTabla FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )793;
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


	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) {
            
            vDTrazasLog  ( modulo ,"\n\t\t** Error en 'PREPARE' de Update Indice balance [%d] ***"
                              ,LOG03, SQLCODE);
        	vDTrazasError(modulo,"%s Error en 'PREPARE' de Update Indice balance %s [%d]\n"
                            ,LOG03
                            ,cfnGetTime(3), sqlca.sqlerrm.sqlerrmc, SQLCODE);
        return FALSE;
    }
    /* EXEC SQL EXECUTE stUpdateTabla ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )812;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) {
		vDTrazasError(modulo,"\n\t<< Error en 'UPDATE' Indice Balance >>\n\t[%d] : [%s]",
					  LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"\n\t<< Error en 'UPDATE' Indice Balance >>\n\t[%d] : [%s]",
					  LOG01,SQLCODE,SQLERRM);
	    return FALSE;
	}
	return TRUE;
}
/****************************************************************************/


/************************************************************************/
/* Funcion :  bCargaItemesCero                                          */
/* Carga itemes en cero                                                 */
/************************************************************************/

BOOL bCargaItemesCero(long lCodCliente, int iCodItem, int iCodTipDocum)
{
char modulo[]="bCargaItemesCero";
int     Result;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente;
    int  ihCodCiclo;
    int  ihCodItem;
    int  ihCodTipDocum;
/* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente    = lCodCliente;
    ihCodCiclo      = stLineaComando.iCodCiclFact;
    ihCodItem       = iCodItem;
    ihCodTipDocum   = iCodTipDocum;

    Result = ifnInsertaFatBalance(  lhCodCliente,
                                    ihCodItem,
                                    ihCodTipDocum,
                                    ihCodCiclo,
                                    0,
                                    0.0);
    if ( Result != SQLOK )
    {
        vDTrazasLog  ( modulo , "\n\t\t** Error Insert FAT_BALANCES ***"
                				"\n\t\t** Codigo de Item : [%d] - Tipo de Doc. : [%d]"
                                ,LOG03, ihCodItem,ihCodTipDocum);
        vDTrazasError(modulo,"%s Error Insert Balances Cargos Corrientes  %s\n"
                    		 "\n\t\t** Codigo de Item : [%d] - Tipo de Doc. : [%d]"
		                    ,LOG03
		                    ,cfnGetTime(3)
		                    ,sqlca.sqlerrm.sqlerrmc
		                    , ihCodItem,ihCodTipDocum);
        fnOraRollBack();
        return FALSE;
    }

    return 1;
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
    ihCodItem   	= iTOTAL_PAGAR;
    ihCodTipDocum   = FACTCICLAFEC;

   /* Obtiene balance anterior de tablas historicas */
    /* EXEC  SQL
          SELECT ROUND(NVL(IMP_DOCUMENTO, 0), 2), ROUND(NVL(CAN_DOCUMENTO, 0), 2)
            INTO :dImpDocumento, :iCantDocum
            FROM FAH_BALANCE
           WHERE COD_CLIENTE = :lCodCliente
             AND FEC_HISTORICO = ( SELECT MAX(FEC_HISTORICO)
                                     FROM FAH_BALANCE
                                    WHERE COD_CLIENTE = :lCodCliente
                                      AND COD_ITEM    = :ihCodItem)
             AND COD_ITEM = :ihCodItem ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ROUND(NVL(IMP_DOCUMENTO,0),2) ,ROUND(NVL(CAN_DOCUM\
ENTO,0),2) into :b0,:b1  from FAH_BALANCE where ((COD_CLIENTE=:b2 and FEC_HIST\
ORICO=(select max(FEC_HISTORICO)  from FAH_BALANCE where (COD_CLIENTE=:b2 and \
COD_ITEM=:b4))) and COD_ITEM=:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )827;
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
            vDTrazasLog  ( modulo ,"\n\t\t** Cliente %ld sin balance anterior  ***"
                                  ,LOG03,lCodCliente);
            dImpDocumento = 0;
            iCantDocum = 0;
        }
        else
        {
            vDTrazasLog  (modulo,"\n\t\t** Error Select FAH_BALANCE  ***",LOG03);
            vDTrazasError(modulo,"%s  Error Select FAH_BALANCE  %s\n"
			                    ,LOG03
			                    ,cfnGetTime(3)
			                    ,sqlca.sqlerrm.sqlerrmc);
            fnOraRollBack();
            return FALSE;
        }
    }

    ihCodItem    =iBALANCE_ANTERIOR;

    vDTrazasLog  ( modulo ,"\n dImpDocumento [%f]\n", LOG03, dImpDocumento);  /* Corrección para que imprima correctamente el monto. */

    Result = ifnInsertaFatBalance(lhCodCliente,
                              ihCodItem,
                              ihCodTipDocum,
                              ihCodCiclo,
                              iCantDocum,
                              dImpDocumento);


    if ( Result != SQLOK )
        {
            vDTrazasLog  ( modulo ,"\n\t\t** Error Insert FAT_BALANCE Balance Anterior [%d] ***", LOG03, Result);
            vDTrazasError(modulo,"%s  Error Insert FAT_BALANCE Balance Anterior %s [%d]\n"
                    ,LOG03
                    ,cfnGetTime(3)
                    ,sqlca.sqlerrm.sqlerrmc, Result);
        fnOraRollBack();
        return FALSE;
    }
    return 1;
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

    return (1);

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

    return (1);

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

    return (1);

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

