
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
           char  filnam[22];
};
static struct sqlcxp sqlfpn =
{
    21,
    "./pc/ACU_Conceptos.pc"
};


static unsigned int sqlctx = 110316835;


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
   unsigned char  *sqhstv[12];
   unsigned long  sqhstl[12];
            int   sqhsts[12];
            short *sqindv[12];
            int   sqinds[12];
   unsigned long  sqharm[12];
   unsigned long  *sqharc[12];
   unsigned short  sqadto[12];
   unsigned short  sqtdso[12];
} sqlstm = {12,12};

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
"select A.COD_CONCEPTO ,B.NOM_CONCEPTO ,A.COD_UNIVERSO ,B.COD_TECNOLOGIA ,B.C\
OD_FORMA ,B.TIP_CALCULO ,A.COD_TIPORED ,A.COD_TIPCOMIS ,A.COD_COMISIONISTA ,C.\
COD_PLANCOMIS ,sum(A.IMP_CONCEPTO) ,count(*)   from CMT_VALORIZADOS A ,CMD_CON\
CEPTOS B ,CM_CONCEPTOSTIPORED_TD C where (((A.ID_PERIODO=:b0 and A.COD_CONCEPT\
O=B.COD_CONCEPTO) and A.COD_TIPORED=C.COD_TIPORED) and A.COD_CONCEPTO=C.COD_CO\
NCEPTO) group by A.COD_CONCEPTO,B.NOM_CONCEPTO,A.COD_UNIVERSO,B.COD_TECNOLOGIA\
,B.COD_FORMA,B.TIP_CALCULO,A.COD_TIPORED,A.COD_TIPCOMIS,A.COD_COMISIONISTA,C.C\
OD_PLANCOMIS           ";

 static char *sq0004 = 
"select A.rowid  ,A.COD_TIPORED ,A.COD_PLANCOMIS ,A.COD_CONCEPTO ,A.COD_TIPCO\
MIS ,A.COD_COMISIONISTA ,sum(A.IMP_NETO) ,sum(A.IMP_TOTAL) ,sum(A.IMP_AUTORIZA\
DO) ,sum(TRUNC(((A.IMP_AUTORIZADO* :b0)/100)))  from CMT_FACTURAS_COAP A where\
 (A.ID_PERIODO=:b1 and A.COD_ESTADO=:b2) group by A.rowid ,A.COD_TIPORED,A.COD\
_PLANCOMIS,A.COD_CONCEPTO,A.COD_TIPCOMIS,A.COD_COMISIONISTA           ";

 static char *sq0005 = 
"select A.COD_PERIODO ,A.NUM_PERIODO ,sum(A.IMP_FONDO) ,sum(NVL(B.IMP_CONSUMO\
,0))  from CMT_FONDOS_COAP A ,CMT_CONSUMOS_COAP B where ((((((((MONTHS_BETWEEN\
(TO_DATE(:b0,'YYYYMMDD'),TO_DATE(A.COD_PERIODO,'YYYYMMDD')) between 1 and :b1 \
and A.COD_TIPORED=:b2) and A.COD_PLANCOMIS=:b3) and A.COD_CONCEPTO=:b4) and A.\
COD_TIPCOMIS=:b5) and A.COD_COMISIONISTA=:b6) and A.COD_TIPCOMIS=B.COD_TIPCOMI\
S(+)) and A.COD_COMISIONISTA=B.COD_COMISIONISTA(+)) and A.NUM_PERIODO=B.NUM_PE\
RIODO(+)) group by A.COD_TIPORED,A.COD_TIPCOMIS,A.COD_COMISIONISTA,A.COD_PERIO\
DO,A.NUM_PERIODO order by A.NUM_PERIODO desc             ";

 static char *sq0006 = 
"select distinct COD_TIPORED ,COD_PLANCOMIS ,COD_CONCEPTO ,COD_TIPCOMIS ,COD_\
COMISIONISTA  from CMT_FONDOS_COAP            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,114,0,4,42,0,0,1,0,0,1,0,2,3,0,0,
24,0,0,2,114,0,4,60,0,0,1,0,0,1,0,2,3,0,0,
43,0,0,3,567,0,9,128,0,0,1,1,0,1,0,1,97,0,0,
62,0,0,3,0,0,13,131,0,0,12,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,3,0,0,
125,0,0,3,0,0,15,160,0,0,0,0,0,1,0,
140,0,0,4,380,0,9,218,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
167,0,0,4,0,0,13,221,0,0,10,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
2,3,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,
222,0,0,4,0,0,15,251,0,0,0,0,0,1,0,
237,0,0,5,601,0,9,316,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,
280,0,0,5,0,0,13,319,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,
311,0,0,5,0,0,15,338,0,0,0,0,0,1,0,
326,0,0,6,122,0,9,378,0,0,0,0,0,1,0,
341,0,0,6,0,0,13,381,0,0,5,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
376,0,0,6,0,0,15,402,0,0,0,0,0,1,0,
391,0,0,7,180,0,4,465,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,
430,0,0,8,188,0,3,476,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
481,0,0,9,192,0,3,512,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
532,0,0,10,188,0,3,547,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,
583,0,0,11,140,0,4,580,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
618,0,0,12,177,0,4,590,0,0,7,4,0,1,0,2,3,0,0,2,4,0,0,2,4,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,
661,0,0,13,188,0,3,605,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,
712,0,0,14,256,0,4,674,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,
751,0,0,15,69,0,5,879,0,0,1,1,0,1,0,1,97,0,0,
770,0,0,16,48,0,1,994,0,0,0,0,0,1,0,
785,0,0,17,0,0,30,1126,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa encargado de ejecutar la valoración estándard mensual.           */
/*                                                                           */
/*---------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                  */
/* Inicio: Lunes 26 de Noviembre del 2001.                                   */
/* Fin:                                                                      */
/* Autor : Fabian Aedo Ramirez                                               */
/*---------------------------------------------------------------------------*/
/* Recibira entre sus parametros un COD_PERIODO, con el que cruzara las      */
/*  tablas de Valoracion (CMT_VALORIZADOS) y la de periodos, (CMD_PERIODOS), */
/*  para todos aquellos periodos cuyo indicador de periodo sea mensual.      */
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "ACU_Conceptos.h"
#include "GEN_biblioteca.h"

/*---------------------------------------------------------------------------*/
/* Inclusion de biblioteca para manejo de interaccion con Oracle.            */
/*---------------------------------------------------------------------------*/
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

char    szhUser[30]="";
char    szhPass[30]="";
char    szhSysDate [17]="";
char    szFechaYYYYMMDD[9]="";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Recupera % de Apoyo por Coparticipacion (COAP), desde parametros generales*/
/*---------------------------------------------------------------------------*/
void vRecuperaValCoap()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            int     ihValCoap;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    /* EXEC SQL SELECT VAL_PARAMETRO1 INTO :ihValCoap
            FROM CMD_PARAMETROS
            WHERE COD_TIPCODIGO = 9 
              AND COD_CODIGO = 4 
              AND COD_PARAMETRO = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO1 into :b0  from CMD_PARAMETROS where\
 ((COD_TIPCODIGO=9 and COD_CODIGO=4) and COD_PARAMETRO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValCoap;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


    iValCoap  = ihValCoap;
    fprintf(stderr, "[vRecuperaValCoap]Porcentaje de Aporte Coparticipación:[%d%%]\n",iValCoap);
    fprintf(pfLog , "[vRecuperaValCoap]Porcentaje de Aporte Coparticipación:[%d%%]\n",iValCoap);
}
/*---------------------------------------------------------------------------*/
/* Recupera N° Meses vigencia del fondo COAP.                                */
/*---------------------------------------------------------------------------*/
void vRecuperaMesesCoap()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            int     ihMesesCoap;
    /* EXEC SQL END DECLARE SECTION; */ 

        
    /* EXEC SQL SELECT VAL_PARAMETRO1 INTO :ihMesesCoap
            FROM CMD_PARAMETROS
            WHERE COD_TIPCODIGO = 9 
              AND COD_CODIGO    = 3
              AND COD_PARAMETRO = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO1 into :b0  from CMD_PARAMETROS where\
 ((COD_TIPCODIGO=9 and COD_CODIGO=3) and COD_PARAMETRO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihMesesCoap;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


    iMesesCoap  = ihMesesCoap;
    fprintf(stderr,"[vRecuperaMesesCoap]N° Meses de Vigencia del Fondo COAP:[%d]\n",iMesesCoap);
    fprintf(pfLog ,"[vRecuperaMesesCoap]N° Meses de Vigencia del Fondo COAP:[%d]\n",iMesesCoap);
}
/*---------------------------------------------------------------------------*/
/* Se extrae el universo inicial de registros a considerar para Comisiones.  */
/*---------------------------------------------------------------------------*/
void vCreaUniverso()
{
	stConceptos * paux;
	long		lCantReg=0;
	int         i;
	short       iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch;
	    char    szhIdPeriodo[11];

	    int 	ihCodConcepto[MAXFETCH];
		char	szhNomConcepto[MAXFETCH][61];
	    char    szhCodUniverso[MAXFETCH][7];
		char	szhCodTecnologia[MAXFETCH][8];
		char	szhCodForma[MAXFETCH][11];
		char	szhTipCalculo[MAXFETCH][2];
		int		ihCodTipoRed[MAXFETCH];
	    char    szhCodTipComis[MAXFETCH][3];
	    long	lhCodComisionista[MAXFETCH];
	    double	dhImpConcepto[MAXFETCH];
	    long    lhCantRegistros[MAXFETCH];
	    char	szhCodPlanComis[MAXFETCH][7];
	/* EXEC SQL END DECLARE SECTION; */ 


    lMaxFetch = MAXFETCH;
    strcpy(szhIdPeriodo	, stCiclo.szIdCiclComis);
	fprintf(pfLog ,"\n\n[vCreaUniverso]Carga de Registros para Acumulación de Conceptos.\n");
	fprintf(stderr,"\n\n[vCreaUniverso]Carga de Registros para Acumulación de Conceptos.\n");
    /* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR SELECT  
        A.COD_CONCEPTO,
        B.NOM_CONCEPTO,
    	A.COD_UNIVERSO,
    	B.COD_TECNOLOGIA,
    	B.COD_FORMA,
    	B.TIP_CALCULO,
    	A.COD_TIPORED,
        A.COD_TIPCOMIS,
        A.COD_COMISIONISTA,
        C.COD_PLANCOMIS,
        SUM(A.IMP_CONCEPTO),
        COUNT(*)
        FROM	CMT_VALORIZADOS A,
        		CMD_CONCEPTOS B,
        		CM_CONCEPTOSTIPORED_TD C
        WHERE A.ID_PERIODO   = :szhIdPeriodo
          AND A.COD_CONCEPTO = B.COD_CONCEPTO
          AND A.COD_TIPORED  = C.COD_TIPORED
          AND A.COD_CONCEPTO = C.COD_CONCEPTO
        GROUP BY 	A.COD_CONCEPTO,B.NOM_CONCEPTO,A.COD_UNIVERSO,
			    	B.COD_TECNOLOGIA,B.COD_FORMA,B.TIP_CALCULO,
			    	A.COD_TIPORED, A.COD_TIPCOMIS, A.COD_COMISIONISTA,
			    	C.COD_PLANCOMIS; */ 
 

    /* EXEC SQL OPEN CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )43;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch FETCH CUR_UNIVERSO INTO 
			:ihCodConcepto, :szhNomConcepto, :szhCodUniverso,
			:szhCodTecnologia, :szhCodForma, :szhTipCalculo, 
			:ihCodTipoRed, :szhCodTipComis, :lhCodComisionista, 
			:szhCodPlanComis, :dhImpConcepto, :lhCantRegistros; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )62;
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
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhNomConcepto;
        sqlstm.sqhstl[1] = (unsigned long )61;
        sqlstm.sqhsts[1] = (         int  )61;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodUniverso;
        sqlstm.sqhstl[2] = (unsigned long )7;
        sqlstm.sqhsts[2] = (         int  )7;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodTecnologia;
        sqlstm.sqhstl[3] = (unsigned long )8;
        sqlstm.sqhsts[3] = (         int  )8;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodForma;
        sqlstm.sqhstl[4] = (unsigned long )11;
        sqlstm.sqhsts[4] = (         int  )11;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhTipCalculo;
        sqlstm.sqhstl[5] = (unsigned long )2;
        sqlstm.sqhsts[5] = (         int  )2;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)ihCodTipoRed;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )sizeof(int);
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[7] = (unsigned long )3;
        sqlstm.sqhsts[7] = (         int  )3;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)lhCodComisionista;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )sizeof(long);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhCodPlanComis;
        sqlstm.sqhstl[9] = (unsigned long )7;
        sqlstm.sqhsts[9] = (         int  )7;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)dhImpConcepto;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[10] = (         int  )sizeof(double);
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)lhCantRegistros;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )sizeof(long);
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
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
        if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stConceptos *) malloc(sizeof(stConceptos));
            paux->iCodConcepto            	= ihCodConcepto[i];
            strcpy(paux->szNomConcepto    	, szfnTrim(szhNomConcepto[i]));
            strcpy(paux->szCodUniverso    	, szfnTrim(szhCodUniverso[i]));
            strcpy(paux->szCodTecnologia  	, szfnTrim(szhCodTecnologia[i]));
            strcpy(paux->szCodForma    		, szfnTrim(szhCodForma[i]));
            strcpy(paux->szCodPlanComis    	, szfnTrim(szhCodPlanComis[i]));
			strcpy(paux->szTipCalculo		, szfnTrim(szhTipCalculo[i]));
            paux->iCodTipoRed        		= ihCodTipoRed[i];
            strcpy(paux->szCodTipComis    	, szfnTrim(szhCodTipComis[i]));
            paux->lCodComisionista        	= lhCodComisionista[i];
            strcpy(paux->szIdPeriodo      	, szhIdPeriodo);
            paux->dImpConcepto            	= dhImpConcepto[i];
            paux->lCantRegistros          	= lhCantRegistros[i];
            paux->sgte 						= lstConceptos;
            lstConceptos 					= paux;
            lCantReg++;
		}
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )125;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


	fprintf(pfLog ,"[vCreaUniverso]Cantidad de Registros leídos:[%ld].\n",lCantReg);
	fprintf(stderr,"[vCreaUniverso]Cantidad de Registros leídos:[%ld].\n",lCantReg);
}
/*---------------------------------------------------------------------------*/
/* Recupera listado de facturas para calcular monto requerido por Bono Coap. */
/*---------------------------------------------------------------------------*/
void vRecuperaFacturasCoap()
{
    stFacturas	* paux;
    long        lCantReg=0;
    int         i;
    long        iLastRows    = 0;
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lMaxFetch;
        int     ihValCoap;
        char	szhCodEstadoING[4];
        char    szhRowId[MAXFETCH][19];
        char    szhIdPeriodo[11];

        int		ihCodTipoRed[MAXFETCH];
        char	szhCodPlanComis[MAXFETCH][7];
        int 	ihCodConcepto[MAXFETCH];
        char    szhCodTipComis[MAXFETCH][3];
        int     ihCodComisionista[MAXFETCH];
        double  dhImpNeto[MAXFETCH];
        double  dhImpTotal[MAXFETCH];
        double  dhImpAutorizado[MAXFETCH];
        double	dhImpPonderado[MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 


    fprintf(stderr,"[vRecuperaFacturasCoap]Inicia recuperación de Facturas COAP periodo:[%d]\n",stCiclo.lCodCiclComis);         /* Incorporado Por PGonzaleg 2-1-2003. Modificacion de Periodos. */
    fprintf(pfLog ,"[vRecuperaFacturasCoap]Inicia recuperación de Facturas COAP periodo:[%d]\n",stCiclo.lCodCiclComis);         /* Incorporado Por PGonzaleg 2-1-2003. Modificacion de Periodos. */

	strcpy(szhCodEstadoING 	, "ING");
    ihValCoap 				= iValCoap;
	strcpy(szhIdPeriodo 	, stCiclo.szIdCiclComis);
    lMaxFetch 				= MAXFETCH;

    /* EXEC SQL DECLARE CUR_FACTURAS CURSOR FOR SELECT  
		A.ROWID,
		A.COD_TIPORED,
		A.COD_PLANCOMIS,
		A.COD_CONCEPTO,
		A.COD_TIPCOMIS,
        A.COD_COMISIONISTA,
        SUM(A.IMP_NETO),
        SUM(A.IMP_TOTAL),
        SUM(A.IMP_AUTORIZADO),
        SUM(TRUNC(A.IMP_AUTORIZADO * :ihValCoap/100))
        FROM  CMT_FACTURAS_COAP A
        WHERE A.ID_PERIODO  = :szhIdPeriodo
          AND A.COD_ESTADO   = :szhCodEstadoING
        GROUP BY A.ROWID, A.COD_TIPORED, A.COD_PLANCOMIS, A.COD_CONCEPTO, A.COD_TIPCOMIS, A.COD_COMISIONISTA; */ 


    /* EXEC SQL OPEN CUR_FACTURAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )140;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValCoap;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodEstadoING;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch FETCH CUR_FACTURAS INTO
			:szhRowId, :ihCodTipoRed, :szhCodPlanComis, :ihCodConcepto, 
			:szhCodTipComis, :ihCodComisionista, :dhImpNeto, :dhImpTotal, 
			:dhImpAutorizado, :dhImpPonderado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )167;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowId;
        sqlstm.sqhstl[0] = (unsigned long )19;
        sqlstm.sqhsts[0] = (         int  )19;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)ihCodTipoRed;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(int);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanComis;
        sqlstm.sqhstl[2] = (unsigned long )7;
        sqlstm.sqhsts[2] = (         int  )7;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)ihCodConcepto;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )sizeof(int);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )3;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)ihCodComisionista;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )sizeof(int);
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)dhImpNeto;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )sizeof(double);
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)dhImpTotal;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )sizeof(double);
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)dhImpAutorizado;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )sizeof(double);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)dhImpPonderado;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )sizeof(double);
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
        if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stFacturas *) malloc(sizeof(stFacturas));
            
            strcpy(paux->szRowId		, szfnTrim(szhRowId[i]));
            paux->iCodTipoRed			= ihCodTipoRed[i];
            strcpy(paux->szCodPlanComis	, szfnTrim(szhCodPlanComis[i]));
            paux->iCodConcepto			= ihCodConcepto[i];
            strcpy(paux->szCodTipComis	, szfnTrim(szhCodTipComis[i]));
            paux->lCodComisionista      = ihCodComisionista[i];
            paux->dImpNeto              = dhImpNeto[i];
            paux->dImpTotal             = dhImpTotal[i];
            paux->dImpAutorizado        = dhImpAutorizado[i];
            paux->lCodPeriodo           = stCiclo.lCodCiclComis;
            paux->dImpPonderado         = dhImpPonderado[i];
                    
            paux->sgte 					= lstFacturas;
            lstFacturas 				= paux;
            lCantReg++;
	    }
    }
    fprintf(stderr,"[vRecuperaFacturasCoap]Facturas Coap Recuperadas Para el Periodo:[%d]\n",lCantReg);
    fprintf(pfLog ,"[vRecuperaFacturasCoap]Facturas Coap Recuperadas Para el Periodo:[%d]\n",lCantReg);
    /* EXEC SQL CLOSE CUR_FACTURAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )222;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

    
}
/*---------------------------------------------------------------------------*/
/* Recupera listado de fondos diponibles para aportes COAP.                  */
/*---------------------------------------------------------------------------*/
void vRecuperaDetalleFondosCoap()
{
    stFondosComis * paux;
    stFondos      * qaux;
    int             i;
    long			lCantRegs 	= 0;	
    short           iLastRows    = 0;
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lMaxFetch;
        long    lhCodPeriodo;
        int     ihMesesCoap;
        char    szhCodTipComis[3];
        int     ihCodComisionista;
        int		ihCodTipoRed;
        char	szhCodPlanComis[7];
        int		ihCodConcepto;
        long    lhCodPeriodoIng[MAXFETCH];
        int     ihNumPeriodo[MAXFETCH];
        double  dhImpUsado[MAXFETCH];
        double  dhImpInicial[MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

    ihMesesCoap  = iMesesCoap;
    lhCodPeriodo = stCiclo.lCodCiclComis;
    fprintf(pfLog, "[vRecuperaDetalleFondosCoap]Inicio de Carga de Consumos COAP, para determinar disponibles.\n");
    fprintf(stderr,"[vRecuperaDetalleFondosCoap]Inicio de Carga de Consumos COAP, para determinar disponibles.\n");

    for (paux=lstFondosComis; paux!=NULL; paux=paux->sgte)
    {
        strcpy(szhCodTipComis   , paux->szCodTipComis);
        ihCodComisionista       = paux->lCodComisionista;
		ihCodTipoRed			= paux->iCodTipoRed;
        strcpy(szhCodPlanComis  , paux->szCodPlanComis);
        ihCodConcepto			= paux->iCodConcepto;
		
        lMaxFetch    = MAXFETCH;
        iLastRows    = 0;
        iFetchedRows = MAXFETCH;
        iRetrievRows = MAXFETCH;

        /* EXEC SQL DECLARE CUR_DETALLECOAP_NEW CURSOR for SELECT
        	A.COD_PERIODO,
            A.NUM_PERIODO,
            SUM(A.IMP_FONDO),
            SUM(NVL(B.IMP_CONSUMO,0))
            FROM    CMT_FONDOS_COAP A,CMT_CONSUMOS_COAP B
            WHERE   MONTHS_BETWEEN(TO_DATE(:lhCodPeriodo,'YYYYMMDD'),TO_DATE(A.COD_PERIODO,'YYYYMMDD')) BETWEEN 1 AND :ihMesesCoap
            AND 	A.COD_TIPORED		= :ihCodTipoRed
            AND 	A.COD_PLANCOMIS 	= :szhCodPlanComis
            AND		A.COD_CONCEPTO		= :ihCodConcepto
            AND     A.COD_TIPCOMIS     	= :szhCodTipComis
            AND     A.COD_COMISIONISTA 	= :ihCodComisionista
            AND     A.COD_TIPCOMIS     	= B.COD_TIPCOMIS(+)
            AND     A.COD_COMISIONISTA 	= B.COD_COMISIONISTA(+)
            AND     A.NUM_PERIODO      	= B.NUM_PERIODO(+)
            GROUP   BY A.COD_TIPORED, A.COD_TIPCOMIS, A.COD_COMISIONISTA, A.COD_PERIODO, A.NUM_PERIODO
            ORDER BY A.NUM_PERIODO DESC; */ 


		/* EXEC SQL OPEN CUR_DETALLECOAP_NEW; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0005;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )237;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihMesesCoap;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipoRed;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlanComis;
  sqlstm.sqhstl[3] = (unsigned long )7;
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
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipComis;
  sqlstm.sqhstl[5] = (unsigned long )3;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihCodComisionista;
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
  if (sqlca.sqlcode < 0) vSqlError();
}


        while(iFetchedRows == iRetrievRows)
        {
            /* EXEC SQL for :lMaxFetch FETCH CUR_DETALLECOAP_NEW INTO 
            	:lhCodPeriodoIng, :ihNumPeriodo, :dhImpInicial, :dhImpUsado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )lMaxFetch;
            sqlstm.offset = (unsigned int  )280;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)lhCodPeriodoIng;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )sizeof(long);
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)ihNumPeriodo;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )sizeof(int);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)dhImpInicial;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[2] = (         int  )sizeof(double);
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)dhImpUsado;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[3] = (         int  )sizeof(double);
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
            if (sqlca.sqlcode < 0) vSqlError();
}



            iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows = sqlca.sqlerrd[2];
            for (i=0; i < iRetrievRows; i++)
            {
                qaux = (stFondos *) malloc(sizeof(stFondos));
                qaux->lCodPeriodo       = lhCodPeriodoIng[i];
                qaux->iNumPeriodo       = ihNumPeriodo[i];
                qaux->lImpInicial       = dhImpInicial[i];
                qaux->lImpUsado         = dhImpUsado[i];
                qaux->lImpDisponible    = dhImpInicial[i] - dhImpUsado[i];
                qaux->sgte              = paux->sgte_fondo;
                paux->sgte_fondo        = qaux;
                paux->lImpDisponible    += qaux->lImpDisponible;
                lCantRegs++;
            }               
        }
        /* EXEC SQL CLOSE CUR_DETALLECOAP_NEW; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )311;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


    }
	fprintf(pfLog , "[vRecuperaDetalleFondosCoap]Cantidad de Registros Leidos:[%ld].\n",lCantRegs);
	fprintf(stderr, "[vRecuperaDetalleFondosCoap]Cantidad de Registros Leidos:[%ld].\n",lCantRegs);
}
/*---------------------------------------------------------------------------*/
/* Recupera listado de fondos diponibles para aportes COAP.                  */
/*---------------------------------------------------------------------------*/
void vRecuperaFondosCoap()
{
    stFondosComis * paux;
    long            lCantVentas=0;
    int             i;
    short           iLastRows    = 0;
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lMaxFetch;
        long    lhCodPeriodo;

        int		ihCodTipoRed[MAXFETCH];
	    char	szhCodPlanComis[MAXFETCH][7];
	    int		ihCodConcepto[MAXFETCH];
        char    szhCodTipComis[MAXFETCH][3];
        int     ihCodComisionista[MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 


	fprintf(pfLog ,"\n\n[vRecuperaFondosCoap]Inicia recuperación de Fondos Coap de Distribuidores\n");
	fprintf(stderr,"\n\n[vRecuperaFondosCoap]Inicia recuperación de Fondos Coap de Distribuidores\n");

    lMaxFetch    = MAXFETCH;
    /* EXEC SQL DECLARE CUR_FONDOSCOAP CURSOR FOR SELECT  DISTINCT 
    	COD_TIPORED,
    	COD_PLANCOMIS,
    	COD_CONCEPTO,
    	COD_TIPCOMIS,
        COD_COMISIONISTA
        FROM CMT_FONDOS_COAP; */ 


	/* EXEC SQL OPEN CUR_FONDOSCOAP; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0006;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )326;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	while(iFetchedRows == iRetrievRows)
	{
        /* EXEC SQL for :lMaxFetch FETCH CUR_FONDOSCOAP INTO
        	:ihCodTipoRed, :szhCodPlanComis, :ihCodConcepto, :szhCodTipComis, :ihCodComisionista; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )341;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(int);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
        sqlstm.sqhstl[1] = (unsigned long )7;
        sqlstm.sqhsts[1] = (         int  )7;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)ihCodConcepto;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(int);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[3] = (unsigned long )3;
        sqlstm.sqhsts[3] = (         int  )3;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)ihCodComisionista;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )sizeof(int);
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
        if (sqlca.sqlcode < 0) vSqlError();
}


	
        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
	        paux = (stFondosComis *) malloc(sizeof(stFondosComis));
	
	        paux->iCodTipoRed			= ihCodTipoRed[i];
	        strcpy(paux->szCodPlanComis	, szfnTrim(szhCodPlanComis[i]));
	        paux->iCodConcepto			= ihCodConcepto[i];
	        strcpy(paux->szCodTipComis	, szfnTrim(szhCodTipComis[i]));
	        paux->lCodComisionista      = ihCodComisionista[i];
	        paux->lImpDisponible        = 0;
	        paux->sgte_fondo            = NULL;
	        lCantVentas++;
	        paux->sgte 					= lstFondosComis;
	        lstFondosComis 				= paux;
        }
	}
	/* EXEC SQL CLOSE CUR_FONDOSCOAP; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )376;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}

  
	fprintf(stderr,"[vRecuperaFondosCoap]Cantidad de Registros de Fondo Coap:[%d]\n",lCantVentas);
	fprintf(pfLog ,"[vRecuperaFondosCoap]Cantidad de Registros de Fondo Coap:[%d]\n",lCantVentas);
}

/*---------------------------------------------------------------------------*/
/* FUNCION QUE RETORNA EL IMPORTE AUTORIZADO PARA COAP PARA UN COMISIONISTA. */
/*---------------------------------------------------------------------------*/
long lGetFondoSolicitado(int iCodTipoRed, char * pszPlanComis, int plConcepto, int  plCodComisionista)
{
    stFacturas      * paux;
    long            lValFondo = 0;
    
    paux = lstFacturas;
    while ((paux != NULL)&&((paux->lCodComisionista != plCodComisionista)||(paux->iCodTipoRed != iCodTipoRed)||(paux->iCodConcepto != plConcepto)||strcmp(paux->szCodPlanComis,pszPlanComis)!=0))
        paux = paux->sgte;

    if (paux!=NULL)
        lValFondo = paux->dImpPonderado;
    return(lValFondo);
}
/*---------------------------------------------------------------------------*/
/* FUNCION QUE RETORNA EL FONDO DISPONIBLE DE UN COMISIONISTA (COAP).        */
/*---------------------------------------------------------------------------*/
long lGetFondoDisponible(int iCodTipoRed, char * pszPlanComis, int plConcepto,int  plCodComisionista)
{
    stFondosComis   * paux;
    long            lValFondo = 0;
    paux = lstFondosComis;
    while ((paux != NULL)&&((paux->lCodComisionista != plCodComisionista)||(paux->iCodTipoRed != iCodTipoRed)||(paux->iCodConcepto != plConcepto)||strcmp(paux->szCodPlanComis,pszPlanComis)!=0))
        paux = paux->sgte;

    if (paux != NULL)
        lValFondo = paux->lImpDisponible;
    return(lValFondo);
}
/*---------------------------------------------------------------------------*/
/* RUTINA QUE INSERTA UN REGISTRO EN LA TABLA DE FONDOS COAP.              */
/*---------------------------------------------------------------------------*/
void vInsertaFondoCoap(int iCodTipoRed, char * szCodPlanComis, int lCodConcepto, char * pszCanal, int piComis, long plFondo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodPeriodo;
        char    szhCodTipComis[3];
        int     ihCodComisionista;
        long    lhImpFondo;
        int     ihNumPeriodo;
        int 	ihCodTipoRed;
        char	szhCodPlanComis[7];
        int 	ihCodConcepto;
        char	szhIdPeriodo[11];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy(szhCodTipComis   , pszCanal);
    ihCodComisionista       = piComis;
    lhImpFondo              = plFondo;
    ihCodTipoRed			= iCodTipoRed;
    strcpy(szhCodPlanComis	, szCodPlanComis);
    ihCodConcepto			= lCodConcepto;

    lhCodPeriodo            = stCiclo.lCodCiclComis;
	strcpy(szhIdPeriodo		, stCiclo.szIdCiclComis);

    /* EXEC SQL SELECT NVL(MAX(NUM_PERIODO),0) 
        INTO :ihNumPeriodo 
        FROM CMT_FONDOS_COAP
        WHERE COD_TIPORED 	   = :ihCodTipoRed
          AND COD_PLANCOMIS	   = :szhCodPlanComis
          AND COD_CONCEPTO     = :ihCodConcepto
          AND COD_TIPCOMIS     = :szhCodTipComis
          AND COD_COMISIONISTA = :ihCodComisionista; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(max(NUM_PERIODO),0) into :b0  from CMT_FONDOS_\
COAP where ((((COD_TIPORED=:b1 and COD_PLANCOMIS=:b2) and COD_CONCEPTO=:b3) an\
d COD_TIPCOMIS=:b4) and COD_COMISIONISTA=:b5)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )391;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihNumPeriodo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanComis;
    sqlstm.sqhstl[2] = (unsigned long )7;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodComisionista;
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
    if (sqlca.sqlcode < 0) vSqlError();
}



    ihNumPeriodo+=1;

    /* EXEC SQL INSERT INTO CMT_FONDOS_COAP 
        (COD_TIPORED, COD_PLANCOMIS, COD_CONCEPTO, COD_PERIODO,
         COD_TIPCOMIS,COD_COMISIONISTA,IMP_FONDO,NUM_PERIODO, ID_PERIODO) VALUES 
        (:ihCodTipoRed, :szhCodPlanComis, :ihCodConcepto, :lhCodPeriodo, 
         :szhCodTipComis, :ihCodComisionista, :lhImpFondo, :ihNumPeriodo, :szhIdPeriodo); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_FONDOS_COAP (COD_TIPORED,COD_PLANCOMIS,CO\
D_CONCEPTO,COD_PERIODO,COD_TIPCOMIS,COD_COMISIONISTA,IMP_FONDO,NUM_PERIODO,ID_\
PERIODO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )430;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
    sqlstm.sqhstl[1] = (unsigned long )7;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodComisionista;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhImpFondo;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihNumPeriodo;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


	
	stStatusProc.lCantFondos++;
}
/*---------------------------------------------------------------------------*/
/* RUTINA QUE INSERTA UN REGISTRO EN LA TABLA DE CONSUMOS COAP.              */
/*---------------------------------------------------------------------------*/
void vInsertaConsumoCoap(int iCodTipoRed, char * szCodPlanComis, long lCodConcepto, char * pszCanal, int piComis, long plCargo, int piPeriodo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodPeriodo;
        char    szhCodTipComis[3];
        int     ihCodComisionista;
        long    lhImpConsumo;
        int     ihNumPeriodo;
        int		ihCodTipoRed;
        int		ihCodConcepto;
        char	szhCodPlanComis[7];
        char	szhIdPeriodo[11];
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhCodTipComis   , pszCanal);
    ihCodComisionista       = piComis;
    lhImpConsumo            = plCargo;
    ihNumPeriodo            = piPeriodo;
	ihCodTipoRed			= iCodTipoRed;
	ihCodConcepto			= lCodConcepto;
	strcpy(szhCodPlanComis	, szCodPlanComis);
	
    lhCodPeriodo            = stCiclo.lCodCiclComis;
	strcpy(szhIdPeriodo		, stCiclo.szIdCiclComis);
	
    /* EXEC SQL INSERT INTO CMT_CONSUMOS_COAP 
        (COD_TIPORED, COD_PLANCOMIS,COD_CONCEPTO,COD_PERIODO,COD_TIPCOMIS,
         COD_COMISIONISTA,IMP_CONSUMO,NUM_PERIODO, ID_PERIODO) VALUES 
        (:ihCodTipoRed, :szhCodPlanComis, :ihCodConcepto, :lhCodPeriodo, :szhCodTipComis, 
         :ihCodComisionista, :lhImpConsumo, :ihNumPeriodo, :szhIdPeriodo); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_CONSUMOS_COAP (COD_TIPORED,COD_PLANCOMIS,\
COD_CONCEPTO,COD_PERIODO,COD_TIPCOMIS,COD_COMISIONISTA,IMP_CONSUMO,NUM_PERIODO\
,ID_PERIODO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )481;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
    sqlstm.sqhstl[1] = (unsigned long )7;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodComisionista;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhImpConsumo;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihNumPeriodo;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


	stStatusProc.lCantConsumos++;
}
/*---------------------------------------------------------------------------*/
/* RUTINA QUE INSERTA EL REGISTRO FINAL EN LA TABLA DE ACUMULADOS.           */
/*---------------------------------------------------------------------------*/
void vInsertaAcumulados(int iCodTipoRed, int  piConcepto,  char * pszCanal, int piComis, long plLogro, double plImporte, long plCant)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int     ihCodConcepto;
        long    lhCodPeriodo;
        char    szhIdPeriodo[11];
        char    szhCodTipComis[3];
        int     ihCodComisionista;
        double  dhNumLogro;
        double  dhImpConcepto;
        long    lhNumRegistros;
        int		ihCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 
   
        
    ihCodConcepto           = piConcepto;
    strcpy(szhCodTipComis   , pszCanal);
    ihCodComisionista       = piComis;
    dhNumLogro              = plLogro;
    dhImpConcepto           = plImporte;
    lhNumRegistros          = plCant;
    ihCodTipoRed			= iCodTipoRed;

    lhCodPeriodo            = stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo     , stCiclo.szIdCiclComis);

    /* EXEC SQL INSERT INTO CMT_ACUMULADOS 
        (COD_TIPORED, COD_CONCEPTO, COD_PERIODO, ID_PERIODO, COD_TIPCOMIS,COD_COMISIONISTA,NUM_LOGRO,IMP_CONCEPTO,NUM_REGISTROS)
        VALUES (:ihCodTipoRed, :ihCodConcepto,:lhCodPeriodo,:szhIdPeriodo,:szhCodTipComis,:ihCodComisionista,:dhNumLogro,:dhImpConcepto,:lhNumRegistros); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_ACUMULADOS (COD_TIPORED,COD_CONCEPTO,COD_\
PERIODO,ID_PERIODO,COD_TIPCOMIS,COD_COMISIONISTA,NUM_LOGRO,IMP_CONCEPTO,NUM_RE\
GISTROS) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )532;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodPeriodo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodComisionista;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhNumLogro;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&dhImpConcepto;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumRegistros;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
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
    if (sqlca.sqlcode < 0) vSqlError();
}


	stStatusProc.lCantAcumulados++;
}
/*---------------------------------------------------------------------------*/
/* RUTINA QUE INSERTA EL REGISTRO FINAL EN LA TABLA DE ACUMULADOS.           */
/*---------------------------------------------------------------------------*/
void vRecuperaLogroMetas(int iCodTipoRed, int piConcepto,  char * pszCanal, int piComis)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int     ihCodConcepto;
        long    lhCodPeriodo;
        char    szhIdPeriodo[11];
        char    szhCodTipComis[3];
        int     ihCodComisionista;
        double  dhNumLogro;
        double  lhImpConcepto;
        long    lhNumRegistros;
        int		ihCodTipoRed;
        int		ihCantidad;
    /* EXEC SQL END DECLARE SECTION; */ 
   
    
    ihCodConcepto           = piConcepto;
    strcpy(szhCodTipComis   , pszCanal);
    ihCodComisionista       = piComis;
    ihCodTipoRed			= iCodTipoRed;

    lhCodPeriodo            = stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo     , stCiclo.szIdCiclComis);

	fprintf(stderr, "\n[vRecuperaLogroMetas] Procesa TR:[%d] Conc:[%d] TC:[%s] Comis:[%ld]\n",ihCodTipoRed, ihCodConcepto, szhCodTipComis, ihCodComisionista);

    /* EXEC SQL SELECT COUNT(*)
        INTO :ihCantidad
        FROM CMT_LOGRO_METAS
        WHERE COD_TIPORED 		= :ihCodTipoRed
          AND ID_PERIODO 		= :szhIdPeriodo
          AND COD_CONCEPTO     	= :ihCodConcepto
          AND COD_COMISIONISTA 	= :ihCodComisionista; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(*)  into :b0  from CMT_LOGRO_METAS where (((\
COD_TIPORED=:b1 and ID_PERIODO=:b2) and COD_CONCEPTO=:b3) and COD_COMISIONISTA\
=:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )583;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCantidad;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[2] = (unsigned long )11;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodComisionista;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


    
    if (ihCantidad > 0)
    {
	    /* EXEC SQL SELECT NUM_REGISTROS,VAL_LOGRO,IMP_CONCEPTO
	        INTO :lhNumRegistros, :dhNumLogro, :lhImpConcepto
	        FROM CMT_LOGRO_METAS
	        WHERE COD_TIPORED 		= :ihCodTipoRed
	          AND ID_PERIODO 		= :szhIdPeriodo
	          AND COD_CONCEPTO     	= :ihCodConcepto
	          AND COD_COMISIONISTA 	= :ihCodComisionista; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 12;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select NUM_REGISTROS ,VAL_LOGRO ,IMP_CONCEPTO into :b0,:\
b1,:b2  from CMT_LOGRO_METAS where (((COD_TIPORED=:b3 and ID_PERIODO=:b4) and \
COD_CONCEPTO=:b5) and COD_COMISIONISTA=:b6)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )618;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumRegistros;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&dhNumLogro;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&lhImpConcepto;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipoRed;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhIdPeriodo;
     sqlstm.sqhstl[4] = (unsigned long )11;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&ihCodConcepto;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&ihCodComisionista;
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
     if (sqlca.sqlcode < 0) vSqlError();
}


	}
	else
	{
		lhNumRegistros 	= 0;
		dhNumLogro 		= 0;
		lhImpConcepto	= 0.00;
	}

    /* EXEC SQL INSERT INTO CMT_ACUMULADOS 
        (COD_TIPORED, COD_CONCEPTO, COD_PERIODO, ID_PERIODO, 
        COD_TIPCOMIS,COD_COMISIONISTA,NUM_LOGRO,
        IMP_CONCEPTO,NUM_REGISTROS)
        VALUES (:ihCodTipoRed, :ihCodConcepto, :lhCodPeriodo,
        :szhIdPeriodo, :szhCodTipComis, :ihCodComisionista, :dhNumLogro,
        :lhImpConcepto, :lhNumRegistros); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_ACUMULADOS (COD_TIPORED,COD_CONCEPTO,COD_\
PERIODO,ID_PERIODO,COD_TIPCOMIS,COD_COMISIONISTA,NUM_LOGRO,IMP_CONCEPTO,NUM_RE\
GISTROS) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )661;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodPeriodo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodComisionista;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhNumLogro;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhImpConcepto;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumRegistros;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
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
    if (sqlca.sqlcode < 0) vSqlError();
}


}
/*---------------------------------------------------------------------------*/
/* RUTINA ENCARGADA DE DESCONTAR, DESDE EL FONDO COAP, EL VALOR QUE SE APLICA*/
/*---------------------------------------------------------------------------*/
void vDescuentaCoap(int iCodTipoRed, char * szCodPlanComis, int lCodConcepto,int plCodComisionista,long plMontoApli)
{
    stFondosComis   * paux;
    stFondos        * raux;
    double          lSaldo=0;
    
    char            szCodTipComis[3];
    int             lCodComisionista;
    
    paux = lstFondosComis;
    while((paux->lCodComisionista != plCodComisionista)||(paux->iCodTipoRed != iCodTipoRed)||(paux->iCodConcepto!=lCodConcepto)||strcmp(paux->szCodPlanComis,szCodPlanComis)!=0)
        paux = paux->sgte;

    lCodComisionista        = paux->lCodComisionista;
    strcpy(szCodTipComis    , paux->szCodTipComis);
    
    raux                    = paux->sgte_fondo;
    lSaldo                  = plMontoApli;
    while((raux!=NULL)&&(lSaldo > 0))
    {
        if (lSaldo >= raux->lImpDisponible)
        {
            vInsertaConsumoCoap(iCodTipoRed, szCodPlanComis, lCodConcepto, szCodTipComis, lCodComisionista,raux->lImpDisponible,raux->iNumPeriodo);
            lSaldo               -= raux->lImpDisponible;
            raux->lImpUsado       = raux->lImpInicial;
            raux->lImpDisponible  = 0;
        }
        else
        {
            vInsertaConsumoCoap(iCodTipoRed,  szCodPlanComis, lCodConcepto, szCodTipComis,lCodComisionista,lSaldo,raux->iNumPeriodo);                     /* Incorporado Por PGonzaleg 2-1-2003. Modificacion de Periodos. */
            raux->lImpUsado      += lSaldo;
            raux->lImpDisponible -= lSaldo;
            lSaldo                = 0;                      
        }
        raux = raux->sgte;
    }
}
/*---------------------------------------------------------------------------*/
/* Recupera el monto autorizados para facturas y comprobantes de arriendo.   */
/*  Concepto 3. Bono por Presencia.                                          */
/*---------------------------------------------------------------------------*/
long lGetMtoArriendo(int iCodTipoRed, char * szCodPlanComis, int lCodConcepto,int piComis)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int     ihCodComisionista;
        char	szhIdPeriodo[11];
        long    lhImpArriendo;
        int		ihCodTipoRed;
        char 	szhCodPlanComis[7];
        int		ihCodConcepto;
    /* EXEC SQL END DECLARE SECTION; */ 

    strcpy(szhIdPeriodo		, stCiclo.szIdCiclComis);

	ihCodTipoRed			= iCodTipoRed;
	strcpy(szhCodPlanComis	, szCodPlanComis);
	ihCodConcepto			= lCodConcepto;
    lhImpArriendo           = 0;
    ihCodComisionista       = piComis;
    /* EXEC SQL SELECT NVL(SUM(A.IMP_ARRIENDO),0) 
    	INTO 	:lhImpArriendo
        FROM 	CMT_ARRIENDOS_COMPROB A,
        		CMD_LOCALES_AUTORIZADOS B
       WHERE 	A.COD_TIPORED 		= :ihCodTipoRed
        AND		A.COD_PLANCOMIS		= :szhCodPlanComis
        AND 	A.COD_CONCEPTO		= :ihCodConcepto
        AND 	A.COD_COMISIONISTA 	= :ihCodComisionista
        AND 	A.ID_PERIODO      	= :szhIdPeriodo
        AND 	A.NUM_LOCAL 		= B.NUM_LOCAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(sum(A.IMP_ARRIENDO),0) into :b0  from CMT_ARRI\
ENDOS_COMPROB A ,CMD_LOCALES_AUTORIZADOS B where (((((A.COD_TIPORED=:b1 and A.\
COD_PLANCOMIS=:b2) and A.COD_CONCEPTO=:b3) and A.COD_COMISIONISTA=:b4) and A.I\
D_PERIODO=:b5) and A.NUM_LOCAL=B.NUM_LOCAL)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )712;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhImpArriendo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanComis;
    sqlstm.sqhstl[2] = (unsigned long )7;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodComisionista;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


        
    if (sqlca.sqlcode==0)
		return(lhImpArriendo);
    else
		return(0);
}
/*---------------------------------------------------------------------------*/
/* Determina, en función de la forma comisional y del tipo de cálculo, la    */
/* forma de acumulación que se debe aplica al concepto.                      */
/*---------------------------------------------------------------------------*/
int iGetTipoConcepto(char * pszCodForma, char * pszTipCalculo)
{
	/* formas de comsision que comprenden manejo de metas.... */
	if ((strcmp(pszCodForma,"ALTACONTRA")==0)||(strcmp(pszCodForma,"ALTAPREPAG")==0))
		if (strcmp(pszTipCalculo, "M")==0)
			return CONCEPTO_META;
		else
			return CONCEPTO_NORMAL;
	/* formas de comision con tratamiento de fondo coap */
	if (strcmp(pszCodForma,"FONDOSCOAP")==0)
		return CONCEPTO_BONO;

	/* formas de comision con tratamiento bonificacion de arriendos */
	if (strcmp(pszCodForma,"PRESENCIA")==0)
		return CONCEPTO_ARRIENDO;
	
	/* sino, es normal.... */
	return CONCEPTO_NORMAL;
}
/*---------------------------------------------------------------------------*/
/* Procesa Acumulacion de Conceptos. (incluye tratamiento de COAP).          */
/*---------------------------------------------------------------------------*/
void vProcesaAcumulacion()
{
	stConceptos     * lst_conc;
	
	long    lMontoCoapDisp = 0;
	long    lMontoCoapSoli = 0;
	long    lMontoCoapApli = 0;
	int     iCodConcepto;
	long    lCodPeriodo;
	char    szIdPeriodo[11];
	char    szCodTipComis[3];
	long    lCodComisionista;
	double  dhImpConcepto;
	long    lCantRegistros;
	long    lImpArriendo;
	int		iTipConcepto;
	int		iCodTipoRed;
	char	szCodPlanComis[7];
	int		lCodConcepto;
        
	lCodPeriodo	= stCiclo.lCodCiclComis;
        
    for(lst_conc = lstConceptos; lst_conc!=NULL; lst_conc=lst_conc->sgte)
    {
		strcpy(szIdPeriodo		, lst_conc->szIdPeriodo);
        lCodComisionista     	= lst_conc->lCodComisionista;
        strcpy(szCodTipComis 	, lst_conc->szCodTipComis);
        dhImpConcepto         	= lst_conc->dImpConcepto;
        lCantRegistros       	= lst_conc->lCantRegistros;
        iCodTipoRed				= lst_conc->iCodTipoRed; 
        strcpy(szCodPlanComis	, lst_conc->szCodPlanComis);
        lCodConcepto			= lst_conc->iCodConcepto;
        
		iTipConcepto = iGetTipoConcepto(lst_conc->szCodForma, lst_conc->szTipCalculo);
        switch (iTipConcepto)
        {
        	case CONCEPTO_BONO:
                lMontoCoapSoli = 0;
                lMontoCoapDisp = 0;
                lMontoCoapApli = 0;
                fflush(stderr);
                lMontoCoapSoli = lGetFondoSolicitado(iCodTipoRed, szCodPlanComis, lCodConcepto, lCodComisionista);
                if (lMontoCoapSoli > 0)
                {
                    lMontoCoapDisp = lGetFondoDisponible(iCodTipoRed, szCodPlanComis, lCodConcepto,lCodComisionista);
                    if (lMontoCoapDisp > 0)
                    {
                        if (lMontoCoapDisp >= lMontoCoapSoli)
                            lMontoCoapApli = lMontoCoapSoli;
                        else
                            lMontoCoapApli = lMontoCoapDisp;

                        vDescuentaCoap(iCodTipoRed, szCodPlanComis, lCodConcepto,lCodComisionista,lMontoCoapApli);
                        vInsertaAcumulados(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista,0,lMontoCoapApli,0);
                    }
                    else
                        vInsertaAcumulados(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista,0,0,0);
                }
                else
                    vInsertaAcumulados(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista,0,0,0);
                /* Finalmente, para el concepto COAP se debe almacenar el producto de la "acumulacion" */
                /* en la tabla de fondos COAP.                                                         */
                vInsertaFondoCoap(iCodTipoRed, szCodPlanComis, lCodConcepto,szCodTipComis,lCodComisionista,lst_conc->dImpConcepto);
                break;          
            case CONCEPTO_META:/* Ahora le toca a los conceptos con pre-acumulacion. Metas PYME e INDIVIDUAL*/
                vRecuperaLogroMetas(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista);
                break;
            case CONCEPTO_ARRIENDO: /* Bono por Presencia */
                /* Recupera los montos de arriendo */
                lImpArriendo = lGetMtoArriendo(iCodTipoRed, szCodPlanComis, lCodConcepto, lCodComisionista);
                if (lImpArriendo > dhImpConcepto)
                    vInsertaAcumulados(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista,0,dhImpConcepto,lCantRegistros);
                else
                    vInsertaAcumulados(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista,0,lImpArriendo,lCantRegistros);
                break;
            default:
                vInsertaAcumulados(iCodTipoRed, lCodConcepto,szCodTipComis,lCodComisionista,0,dhImpConcepto,lCantRegistros);
        }
    }
}
/*---------------------------------------------------------------------------*/
/* Muestra el contenido de la lista de facturas por comisionista.            */
/*---------------------------------------------------------------------------*/
void vMuestraFacturas()
{
        stFacturas * paux;
        fprintf(stderr,"\n\nTIPO RED; PERIODO; PLANCOMIS; CONCEPTO; TIPO COMIS.; COMISIONISTA; ACUM. NETO; ACUM. TOTAL; ACUM. AUTORIZADO; APORTE SOLICITADO\n");
        fprintf(stderr,"==============================================================================================================\n");
        for (paux = lstFacturas; paux != NULL; paux = paux->sgte)
        {
                fprintf(stderr,"%d;%d;%s;%d;%d;%d;%d;%d\n",paux->iCodTipoRed,paux->szCodPlanComis, paux->iCodConcepto, paux->lCodPeriodo,
                paux->szCodTipComis,paux->lCodComisionista,paux->dImpNeto,paux->dImpTotal,paux->dImpAutorizado,paux->dImpPonderado);
        }
}
/*---------------------------------------------------------------------------*/
/* Muestra el contenido de la lista de fondos COAP.                          */
/*---------------------------------------------------------------------------*/
void vMuestraFondosCoap()
{
        stFondosComis * paux;
        stFondos      * qaux;
        
        for (paux = lstFondosComis; paux!=NULL; paux=paux->sgte)
        {
                fprintf(stderr,"TIPO RED:[%d] PLANCOMIS:[%s] CONCEPTO:[%ld] TIPO COMISIONISTA:[%s]  COMISIONISTA:[%d] MONTO DISPONIBLE:[%d]\n",
                paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->szCodTipComis, paux->lCodComisionista, paux->lImpDisponible);
        }
        fflush(stderr);
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Conceptos.                                     */
/*---------------------------------------------------------------------------*/
void vLiberaUniverso(stConceptos * paux)
{
        if (paux == NULL)
                return;
        vLiberaUniverso(paux->sgte);
        free(paux);
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Conceptos.                                     */
/*---------------------------------------------------------------------------*/
void vLiberaFacturas(stFacturas * paux)
{
        if (paux == NULL)
                return;
        vLiberaFacturas(paux->sgte);
        free(paux);
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Fondos.                                        */
/*---------------------------------------------------------------------------*/
void vLiberaFondos(stFondos * qaux)
{
        if (qaux == NULL)
                return;
        vLiberaFondos(qaux->sgte);
        free(qaux);
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Conceptos.                                     */
/*---------------------------------------------------------------------------*/
void vLiberaFondosComis(stFondosComis * paux)
{
        if (paux == NULL)
                return;
        vLiberaFondosComis(paux->sgte);
        vLiberaFondos(paux->sgte_fondo);
        free(paux);
}
/*---------------------------------------------------------------------------*/
/* Marca facturas COAP como liquidadas                                       */
/*---------------------------------------------------------------------------*/
void vMarcaFacturasCOAP()
{
    stFacturas * paux;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char	szhRowID[19];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    for ( paux = lstFacturas;paux!=NULL; paux = paux->sgte)  
    {
        strcpy(szhRowID	, paux->szRowId);   
        /* EXEC SQL UPDATE CMT_FACTURAS_COAP A
             SET A.COD_ESTADO = 'LIQ'
             WHERE 	A.ROWID 		= :szhRowID; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CMT_FACTURAS_COAP A  set A.COD_ESTADO='LIQ' wh\
ere A.rowid =:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )751;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowID;
        sqlstm.sqhstl[0] = (unsigned long )19;
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
        if (sqlca.sqlcode < 0) vSqlError();
}


    }    
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
        memset(&stArgs, 0, sizeof(rg_argumentos));
        memset(&stCiclo, 0, sizeof(reg_ciclo));
        memset(&stStatusProc, 0, sizeof(rg_estadistica));
        memset(&proceso, 0, sizeof(proceso));

        stStatusProc.lCantAcumulados = 0;
        stStatusProc.lCantConsumos = 0;
        stStatusProc.lCantFondos = 0;

        stArgs.bFlagUser     = FALSE;
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
        vManejaArgs(argc, argv);
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
    strcpy(szhUser, stArgs.szUser);
    strcpy(szhPass, stArgs.szPass);
    if(fnOraConnect(szhUser, szhPass) == FALSE)
    {
            fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
            exit(EXIT_205);
    }
    else
    {
            fprintf(stderr, "\nConexion con la base de datos ha sido exitosa.\n");
            fprintf(stderr, "Username: %s\n\n", szhUser);
    }
/*---------------------------------------------------------------------------*/
/* Inicia estructura de proceso y bloques.                                   */
/*---------------------------------------------------------------------------*/
    vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,szhUser, stArgs.izSecuencia);
    ibiblio = iAccesa_Traza_Procesos(ABRIR_TRAZA,0,"",0,0);
    if (ibiblio)
    {
        fprintf(stderr, "Error al Abrir Traza");
        fprintf(stderr, "Error [%d] al escribir Traza de Proceso.\n", ibiblio);
        exit(ibiblio);
    }
/*---------------------------------------------------------------------------*/
/* Configuracion de idioma espanol para tratamiento de fechas.               */
/*---------------------------------------------------------------------------*/
    if(strcmp(getenv("LC_TIME"), LC_TIME_SPANISH) == 0)
    {
            setlocale(LC_TIME, LC_TIME_SPANISH);
    }
/*---------------------------------------------------------------------------*/
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)
    {
            exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_LOG NO RECONOCIDA.",0,0));
    }
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);
/*---------------------------------------------------------------------------*/
/* Generacion del nombre y creacion del archivo de log.                      */
/*---------------------------------------------------------------------------*/
	strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
        strncpy(szhSysDate, pszGetDateLog(),16);
	strcpy(stArgsLog.szProceso,LOGNAME);
	strncpy(stArgsLog.szSysDate,szhSysDate,16);
	sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);
	if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)
	{
		fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);
		fprintf(stderr, "Revise su existencia.\n");
		fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
		fprintf(stderr, "Proceso finalizado con error.\n");
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE LOG NO PUDO SER ABIERTO.",0,0));
	}
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Header.                                                                   */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(pfLog, "%s\n", szRaya);                    
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", GLOSA_PROG);                
    fprintf(pfLog, "VERSION %s\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision: [%s]\n", LAST_REVIEW);                
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);

    fprintf(pfLog, "Identificador de Proceso		<%s>\n", stArgs.szProceso);
    fprintf(pfLog, "Identificador de Bloque			<%s>\n", stArgs.szBloque);
    fprintf(pfLog, "Secuencia de Ejecucion			<%d>\n", stArgs.izSecuencia);

	fprintf(pfLog, "Base de datos : %s\n\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "\nUsuario ORACLE      :[ %s ]\n",(char * )sysGetUserName()); 
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )770;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/* Procesamiento principal.                                                  */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inicio procesamiento principal ...\n\n");
/*--------------------------------------------------------------------------*/
/* Carga Fechas de periodo a procesar                                       */
/*--------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Carga fechas que definen el periodo actual...\n\n");  
    fprintf(stderr, "Carga fechas que definen el periodo actual...\n\n");  
    if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    {
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	exit(EXIT_101);
    }
/*---------------------------------------------------------------------------*/
/*    - Crea una lista de universos con la acumulación previa de conceptos.  */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Crea lista de universos acumulación previa de conceptos...\n\n");
    fprintf(stderr, "Crea lista de universos de acumulacion previa...\n\n");
    vCreaUniverso();
/*---------------------------------------------------------------------------*/
/*    - Recupera % de apoyo por concepto de COAP.                            */
/*---------------------------------------------------------------------------*/
	vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
	fprintf(pfLog, "Recupera valor de apoyo (%%) para concepto COAP...\n\n");
	fprintf(stderr, "Recupera valor de apoyo (%%) para concepto COAP...\n\n");
	vRecuperaValCoap();
/*---------------------------------------------------------------------------*/
/*    - Recupera N°Meses de Vigencia de los Fondos COAP.                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Recupera N° Meses vigencia fondos COAP...\n\n");
    fprintf(stderr, "Recupera N° Meses vigencia fondos COAP...\n\n");
    vRecuperaMesesCoap();
/*---------------------------------------------------------------------------*/
/*    - Carga las facturas para COAP.                                        */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Carga facturas para calculo de apoyo por concepto COAP...\n\n");
    fprintf(stderr, "Carga facturas para calculo de apoyo por concepto COAP...\n\n");
    vRecuperaFacturasCoap();
/*---------------------------------------------------------------------------*/
/*    - Muestra en Pantalla resumen de facturas de COAP.                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Muestra solicitud de aporte por comisionista, por concepto COAP...\n\n");
    fprintf(stderr, "Muestra solicitud de aporte por comisionista, por concepto COAP...\n\n");
    vMuestraFacturas(); 
/*---------------------------------------------------------------------------*/
/*    - Carga el estado de los fondos COAP.                                  */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Carga fondos disponibles para concepto COAP...\n\n");
    fprintf(stderr,"Carga fondos disponibles para concepto COAP...\n\n");
    vRecuperaFondosCoap();
/*---------------------------------------------------------------------------*/
/*    - Carga el detalle de los fondos COAP.                                 */
/*---------------------------------------------------------------------------*/
	vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
	fprintf(pfLog, "Carga detalle de fondos disponibles para concepto COAP...\n\n");
	fprintf(stderr,"Carga detalle de fondos disponibles para concepto COAP...\n\n");
	vRecuperaDetalleFondosCoap();
/*---------------------------------------------------------------------------*/
/*    - Muestra en Pantalla estado de fondos de COAP.                        */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Muestra nivel de aporte por comisionista, por concepto COAP...\n\n");
    fprintf(stderr,"Muestra nivel de aporte por comisionista, por concepto COAP...\n\n");
    vMuestraFondosCoap(); 
/*---------------------------------------------------------------------------*/
/*    - Inicia proceso de acumulacion, con tratamiento de fondos COAP.       */
/*---------------------------------------------------------------------------*/
	vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
	fprintf(pfLog, "Inicia proceso de acumulacion, con tratamiento de fondos COAP.\n\n");
	fprintf(stderr, "Inicia proceso de acumulacion, con tratamiento de fondos COAP.\n\n");
	vProcesaAcumulacion();

/*---------------------------------------------------------------------------*/
/*    - Marca como liquidadas las facturas COAP                      .       */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Marca como liquidadas las facturas COAP.\n\n");
    fprintf(stderr, "Marca como liquidadas las facturas COAP.\n\n");
    vMarcaFacturasCOAP();
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de abonados y universsos.        */
/*---------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera memoria utilizada por listas de abonados y universsos...\n\n");
    fprintf(stderr, "Libera memoria utilizada por listas de conceptos...\n\n");
    vLiberaUniverso(lstConceptos);
    fprintf(stderr, "Libera memoria utilizada por listas de Facturas...\n\n");
    vLiberaFacturas(lstFacturas);
    fprintf(stderr, "Libera memoria utilizada por listas de Fondos Coap...\n\n");
    vLiberaFondosComis(lstFondosComis);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog, "\nEstadistica del proceso\n");
    fprintf(pfLog, "------------------------\n");
    fprintf(pfLog, "Segundos reales utilizados                     : [%ld]\n", stStatusProc.lSegProceso);
    fprintf(pfLog, "Registros Insertados (ACUMULADOS):             : [%ld]\n", stStatusProc.lCantAcumulados);
    fprintf(pfLog, "Registros Insertados (CONSUMOS COAP):          : [%ld]\n", stStatusProc.lCantConsumos);
    fprintf(pfLog, "Registros Insertados (FONDOS COAP):            : [%ld]\n", stStatusProc.lCantFondos);

    ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lCantAcumulados);
    if (ibiblio)
            exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )785;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

 

    fprintf(pfLog , "\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
    fprintf(stderr, "\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));

    fclose(pfLog);
    return(EXIT_0);
}


