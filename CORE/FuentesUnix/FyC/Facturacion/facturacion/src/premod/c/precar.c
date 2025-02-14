
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
    "./pc/precar.pc"
};


static unsigned int sqlctx = 865499;


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
   unsigned char  *sqhstv[14];
   unsigned long  sqhstl[14];
            int   sqhsts[14];
            short *sqindv[14];
            int   sqinds[14];
   unsigned long  sqharm[14];
   unsigned long  *sqharc[14];
   unsigned short  sqadto[14];
   unsigned short  sqtdso[14];
} sqlstm = {12,14};

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
"select ROWID ,COD_CLIENTESERV ,NUM_ABONADOSERV ,:b0 ,COD_CARGO_CONTRATADO ,C\
OD_TIPSERV ,COD_SERVICIO ,COD_PLANSERV ,IND_CARGOPRO ,COD_CONCEPTO ,TO_CHAR(FE\
C_ALTA,:b1) ,TO_CHAR(FEC_BAJA,:b1) ,IND_BLOQUEO ,EST_BLOQUEO  from FA_CARGOS_R\
EC_TO where ((((COD_CLIENTESERV=:b3 and FEC_ALTA<=TO_DATE(:b4,:b1)) and FEC_BA\
JA>=TO_DATE(:b6,:b1)) and FEC_DESDECOBR<=TO_DATE(:b4,:b1)) and FEC_HASTACOBR>=\
TO_DATE(:b6,:b1))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,416,0,9,56,0,0,12,12,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
68,0,0,1,0,0,13,70,0,0,14,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
139,0,0,1,0,0,15,101,0,0,0,0,0,1,0,
154,0,0,2,203,0,6,329,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,3,0,0,2,
3,0,0,2,5,0,0,2,3,0,0,
201,0,0,3,115,0,5,549,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
};


/*****************************************************************************/
/* Fichero:      precar.pc                                                   */
/* Descripcion:                                                              */
/*                                                                           */
/* Fecha:        20-07-2007                                                  */
/* Autor:        Jaime Espinoza Matamala                                     */
/*****************************************************************************/

#define _PRECAR_PC_

#include <precar.h>

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


/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char  szpFecHasta     [15];/* EXEC SQL VAR szpFecHasta   IS STRING(15); */ 

    char  szpFecDesde     [15];/* EXEC SQL VAR szpFecDesde   IS STRING(15); */ 

    char  szpFecEmision   [15];/* EXEC SQL VAR szpFecEmision IS STRING(15); */ 

/* EXEC SQL END DECLARE SECTION  ; */ 



/*****************************************************************************/
/*                         funcion : iOpenCargosRec                          */
/*****************************************************************************/
static int iOpenCargosRec (long lhCodCliente)
{
    static char  szFormatoFec[17]  ; /* EXEC SQL VAR szFormatoFec  IS STRING(17); */ 

    int    ihUno;
    
    strcpy(szFormatoFec,"YYYYMMDDHH24MISS");
    ihUno = 1;
    
    /* EXEC SQL DECLARE Cur_CargosRecurrentes CURSOR FOR
	 SELECT	  ROWID                                ,
	          COD_CLIENTESERV                      ,
	          NUM_ABONADOSERV                      ,
	          :ihUno                               ,
	          COD_CARGO_CONTRATADO                 ,
	          COD_TIPSERV                          ,
	          COD_SERVICIO                         ,
	          COD_PLANSERV                         ,	
	          IND_CARGOPRO                         ,
	          COD_CONCEPTO                         ,
	          TO_CHAR(FEC_ALTA,:szFormatoFec)      ,
	          TO_CHAR(FEC_BAJA,:szFormatoFec)      ,
	          IND_BLOQUEO                          ,
	          EST_BLOQUEO                          
	FROM      FA_CARGOS_REC_TO
	WHERE     COD_CLIENTESERV = :lhCodCliente
	AND       FEC_ALTA  <= TO_DATE(:szpFecHasta,:szFormatoFec)                                    
        AND       FEC_BAJA  >= TO_DATE(:szpFecDesde,:szFormatoFec) 
      /oAND       FEC_ALTA  <=  TO_DATE(:szpFecEmision,:szFormatoFec)o/ /o P-MIX-09003 o/
        AND FEC_DESDECOBR <= TO_DATE(:szpFecHasta,:szFormatoFec)
	AND FEC_HASTACOBR >= TO_DATE(:szpFecDesde,:szFormatoFec); */ 


  	/* EXEC SQL OPEN Cur_CargosRecurrentes; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0001;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )5;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihUno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[1] = (unsigned long )17;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[2] = (unsigned long )17;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szpFecHasta;
   sqlstm.sqhstl[4] = (unsigned long )15;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[5] = (unsigned long )17;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szpFecDesde;
   sqlstm.sqhstl[6] = (unsigned long )15;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[7] = (unsigned long )17;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szpFecHasta;
   sqlstm.sqhstl[8] = (unsigned long )15;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szFormatoFec;
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
   sqlstm.sqhstv[11] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[11] = (unsigned long )17;
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
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->FA_CARGOS_REC_TO", szfnORAerror());

    return SQLCODE;
}/*********************** Final iOpenCargosRec *******************************/

/******************************************************************************
Funcion		:     	iFetchCargosRec
*******************************************************************************/
int  iFetchCargosRec(CARGORECURRENTE_HOST *pstHost, CARGORECURRENTE_HOST_NULL *pstHostNull, long *plNumFilas)
{
	
    /* EXEC SQL FETCH Cur_CargosRecurrentes INTO
                        :pstHost->szRowid                             ,
                        :pstHost->lhCodCliente                        ,/oListoo/
                        :pstHost->lhNumAbonado                        ,/oListoo/
                        :pstHost->lhCodProducto                       ,/oListoo/
                        :pstHost->lhCodCargoCont                      ,/oListoo/
                        :pstHost->szhCodTipServ:pstHostNull->i_shCodTipServ        ,
                        :pstHost->szhCodServicio:pstHostNull->i_shCodServicio      ,
                        :pstHost->szhCodPlanServ:pstHostNull->i_shCodPlanServ      ,
                        :pstHost->shIndCargoPro                       ,/oListoo/
                        :pstHost->ihCodConcepto                       ,/oListoo/
                        :pstHost->szhFecAlta                          ,/oListoo/
                        :pstHost->szhFecBaja:pstHostNull->i_shFecBaja              ,/oListoo/
                        :pstHost->szhIndBloqueo:pstHostNull->i_shIndBloqueo        ,
                        :pstHost->szhEstBloqueo:pstHostNull->i_shEstBloqueo        ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )30000;
    sqlstm.offset = (unsigned int  )68;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRowid);
    sqlstm.sqhstl[0] = (unsigned long )19;
    sqlstm.sqhsts[0] = (         int  )19;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lhCodCliente);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lhNumAbonado);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )sizeof(long);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->lhCodProducto);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )sizeof(long);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->lhCodCargoCont);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )sizeof(long);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szhCodTipServ);
    sqlstm.sqhstl[5] = (unsigned long )4;
    sqlstm.sqhsts[5] = (         int  )4;
    sqlstm.sqindv[5] = (         short *)(pstHostNull->i_shCodTipServ);
    sqlstm.sqinds[5] = (         int  )sizeof(short);
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szhCodServicio);
    sqlstm.sqhstl[6] = (unsigned long )6;
    sqlstm.sqhsts[6] = (         int  )6;
    sqlstm.sqindv[6] = (         short *)(pstHostNull->i_shCodServicio);
    sqlstm.sqinds[6] = (         int  )sizeof(short);
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szhCodPlanServ);
    sqlstm.sqhstl[7] = (unsigned long )6;
    sqlstm.sqhsts[7] = (         int  )6;
    sqlstm.sqindv[7] = (         short *)(pstHostNull->i_shCodPlanServ);
    sqlstm.sqinds[7] = (         int  )sizeof(short);
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->shIndCargoPro);
    sqlstm.sqhstl[8] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[8] = (         int  )sizeof(short);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->ihCodConcepto);
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )sizeof(int);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szhFecAlta);
    sqlstm.sqhstl[10] = (unsigned long )15;
    sqlstm.sqhsts[10] = (         int  )15;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->szhFecBaja);
    sqlstm.sqhstl[11] = (unsigned long )15;
    sqlstm.sqhsts[11] = (         int  )15;
    sqlstm.sqindv[11] = (         short *)(pstHostNull->i_shFecBaja);
    sqlstm.sqinds[11] = (         int  )sizeof(short);
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->szhIndBloqueo);
    sqlstm.sqhstl[12] = (unsigned long )6;
    sqlstm.sqhsts[12] = (         int  )6;
    sqlstm.sqindv[12] = (         short *)(pstHostNull->i_shIndBloqueo);
    sqlstm.sqinds[12] = (         int  )sizeof(short);
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->szhEstBloqueo);
    sqlstm.sqhstl[13] = (unsigned long )6;
    sqlstm.sqhsts[13] = (         int  )6;
    sqlstm.sqindv[13] = (         short *)(pstHostNull->i_shEstBloqueo);
    sqlstm.sqinds[13] = (         int  )sizeof(short);
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
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


	
	
    if (SQLCODE==SQLOK)
	*plNumFilas = TAM_HOST;
    else
	if (sqlca.sqlcode==NOTFOUND)
	    *plNumFilas = sqlca.sqlerrd[2] % TAM_HOST;

    return SQLCODE;
}

/*****************************************************************************/
/*                        funcion : iCloseConceptos                          */
/*****************************************************************************/
static int iCloseCargosRec (void)
{
    /* EXEC SQL CLOSE Cur_CargosRecurrentes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
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



    if (SQLCODE != SQLOK)
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Close->FA_CARGOS_REC_TO",szfnORAerror());
        return  FALSE;
    }

    return SQLCODE;
}/********************** Final iCloseConceptos *******************************/

/*****************************************************************************/
/*                        funcion : bEMCargosRecurrentes                */
/*****************************************************************************/
BOOL bEMCargosRecurrentes (void)
{
  
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char*  szhFecDesde  ; /* EXEC SQL VAR szhFecDesde IS STRING(15); */ 

         static long   lhCodCliente ;
  	 short  shIndAlta           ;
         static int   iCero       =0;
/* P-MIX-09003 */
         long   lhNumAbonado        ; 
         long   lhCodCicloFact      ;
         long   lhCodConcepto       ;
         long   lhNumProceso        ;
         long   lhNumOcurrencias    ;
         long   lhCodError          ;
         char   szhMsgError [3000+1]; /* EXEC SQL VAR szhMsgError IS STRING(3000+1); */ 

         long   lhEvento            ;
/* P-MIX-09003 */    
         double dhImporteOverride   ; /* P-MIX-09003 XX */              
    /* EXEC SQL END DECLARE SECTION; */ 
      

    int    i = 0;
    int    iIndAbo=0;
    long   lCont;
    BOOL   bRes = FALSE;
    int    iOra;
    long   lNumFilas;
    static CARGORECURRENTE_HOST stCargoRecHost;
    static CARGORECURRENTE_HOST_NULL stCargoRecHostNull;
    double dImpConceptoAux;
  
    PASOPRORRATEO     stPasoProrrateo;
    GRUPOCOB          stGrupoCob;
    CARGOSRECURRENTES stTempCargoRec;
    CONCEPTO          stConcepto;
    SERVABO           *pTmpSerA = (SERVABO *)NULL;
  
    lhCodCliente  = stCliente.lCodCliente;
    strcpy(szpFecHasta  , stCiclo.szFecHastaCFijos);
    strcpy(szpFecDesde  , stCiclo.szFecDesdeCFijos);
    strcpy(szpFecEmision, stCiclo.szFecEmision);    

    vDTrazasLog (szExeName, "\n\t\t* Parametros de Entrada bfnCargaRecurrentes (FACT_CICLO)\n"
                            "\t\t=> Cod.Cliente  [%ld]\n"
                            "\t\t=> Fec.Desde     [%s] \n"
                            "\t\t=> Fec.Hasta     [%s] \n"
                            "\t\t=> Fec.Emision   [%s] \n"
                          , LOG03
                          , lhCodCliente
                          , szpFecDesde
                          , szpFecHasta
                          , szpFecEmision );
                   
    iOra = iOpenCargosRec(lhCodCliente);
  
    if ( iOra != SQLOK )
    {
	 vDTrazasLog  (szExeName,">> ERROR: Al Realizar Open al cursor Cur_CargosRecurrentes  <<",LOG03);
         vDTrazasError(szExeName,">> ERROR: Al Realizar Open al cursor Cur_CargosRecurrentes  <<",LOG03);
	 return FALSE;
    }
  
    while( iOra != NOTFOUND )
    {
           iOra = iFetchCargosRec(&stCargoRecHost,&stCargoRecHostNull,&lNumFilas);
           if ( iOra != SQLOK  && iOra != NOTFOUND )
	   {
		vDTrazasLog  (szExeName,">> ERROR: Al Realizar Fetch al cursor Cur_CargosRecurrentes  <<",LOG03);
    		vDTrazasError(szExeName,">> ERROR: Al Realizar Fetch al cursor Cur_CargosRecurrentes  <<",LOG03);
		return FALSE;
	   }

	   if (!lNumFilas)
	   {
		break;
	   }

	   for ( lCont = 0 ; lCont < lNumFilas ; lCont++ )
	   {
           
                i = stPreFactura.iNumRegistros;
           
                if (stCargoRecHostNull.i_shCodTipServ [lCont] == ORA_NULL) strcpy (stCargoRecHost.szhCodTipServ [lCont],"");
                if (stCargoRecHostNull.i_shCodServicio[lCont] == ORA_NULL) strcpy (stCargoRecHost.szhCodServicio[lCont],"");
                if (stCargoRecHostNull.i_shCodPlanServ[lCont] == ORA_NULL) strcpy (stCargoRecHost.szhCodPlanServ[lCont],"");
                if (stCargoRecHostNull.i_shFecBaja    [lCont] == ORA_NULL) strcpy (stCargoRecHost.szhFecBaja    [lCont],"");
                if (stCargoRecHostNull.i_shIndBloqueo [lCont] == ORA_NULL) strcpy (stCargoRecHost.szhIndBloqueo [lCont],"");
                if (stCargoRecHostNull.i_shEstBloqueo [lCont] == ORA_NULL) strcpy (stCargoRecHost.szhEstBloqueo [lCont],"");
           
                bRes = FALSE;
                for ( iIndAbo=0;iIndAbo<stCliente.iNumServAbo;iIndAbo++ )
                {
           	      if ( stCliente.pServAbo[iIndAbo].lNumAbonado == stCargoRecHost.lhNumAbonado[lCont] )
           	      {
           		   vDTrazasLog (szExeName, "\n\t\t* pServAbo - Encontro Abonado [%ld]", LOG03,stCargoRecHost.lhNumAbonado[lCont]);
           		   pTmpSerA = (SERVABO *)&stCliente.pServAbo[iIndAbo];
           		   bRes = TRUE;
           	      }
		}
		
		if( !bRes )
                {
           	    vDTrazasLog (szExeName, "\n\t\t* pServAbo - NO se encontro numero de abonado [%ld]"
           	                          , LOG03
           	                          , stCargoRecHost.lhNumAbonado[lCont]);
           	    continue; /* P-MIX-09003 */
                }
		   
                bRes = FALSE;
                for ( iIndAbo=0;iIndAbo<stCliente.iNumAbonos;iIndAbo++ )
                {
           	      if ( stCliente.pAbonos[iIndAbo].lNumAbonado == stCargoRecHost.lhNumAbonado[lCont] )
           	      {
           		   vDTrazasLog (szExeName, "\n\t\t* pAbonos - Encontro Abonado [%ld]"
           		                         , LOG03
           		                         , stCargoRecHost.lhNumAbonado[lCont]);
           		   shIndAlta = stCliente.pAbonos[iIndAbo].iIndAlta;
           		   bRes = TRUE;
           	      }
		}
		
                if( !bRes )
                {
           	    vDTrazasLog (szExeName, "\n\t\t* pAbonos - NO se encontro numero de abonado [%ld] para obtener ind_alta"
           	                          , LOG03
           	                          , stCargoRecHost.lhNumAbonado[lCont]);
           	    continue; /* P-MIX-09003 */
                }
           
                memset (&stTempCargoRec,0,sizeof(CARGOSRECURRENTES));
                stTempCargoRec.lCodCargo = stCargoRecHost.lhCodCargoCont[lCont];
                
                /* P-MIX-09003 OVERRIDE XX */
                
                if( !bFindCargoRecurrente(&stTempCargoRec) )
                {
           	     vDTrazasLog (szExeName, "\n\t\t* NO se encontro el monto al Cod.Cargo [%ld]"
           	                           , LOG03
           	                           , stCargoRecHost.lhCodCargoCont[lCont]);
           	     return FALSE;
                }
                else
                {
           	     vDTrazasLog (szExeName, "\n\t\t* bFindCargoRecurrente lhCodCargoCont [%ld]"
                                             "\n\t\t* szCodMoneda [%s]"
                                             "\n\t\t* dMontoImporte [%10.4f]"
           		                   , LOG03
           				   , stCargoRecHost.lhCodCargoCont[lCont]
           				   , stTempCargoRec.szCodMoneda
           				   , stTempCargoRec.dMontoImporte);                	
                }       
                
                dhImporteOverride = 0.0;                
                
                if ( !bFindOverridePA (lhCodCliente,
                                       stCargoRecHost.lhNumAbonado[lCont],
                                       stTempCargoRec.lCodCargo,
                                       &dhImporteOverride))
                {
                     vDTrazasLog (szExeName, "\n\t\t* NO Encontro Override para Planes Adicionales %ld"
                                           , LOG05,stTempCargoRec.lCodCargo);
                }   
                else
                {
                     vDTrazasLog (szExeName, "\n\t\t* Encontro Override para Planes Adicionales %ld"
                                           , LOG05,stCargoRecHost.lhCodCargoCont[lCont]);
                     stTempCargoRec.dMontoImporte  = dhImporteOverride  ;
                }         
                /* P-MIX-09003 OVERRIDE XX */                
           
                memset (&stGrupoCob,0,sizeof (GRUPOCOB));
                stGrupoCob.iCodConcepto = stCargoRecHost.ihCodConcepto[lCont];
                stGrupoCob.iCodProducto = stCargoRecHost.lhCodProducto[lCont];
                stGrupoCob.iCodCiclo    = stCiclo.iCodCiclo   ;
                strcpy (stGrupoCob.szCodGrupo,pTmpSerA->szCodGrpServ);
           
                if ( !bFindGrupoCob(&stGrupoCob) )
                {
                     vDTrazasLog (szExeName, "\n\t\t* NO Encontro grupo de Cobro %s"
                                           , LOG03
                                           , stGrupoCob.szCodGrupo);
                     return FALSE;
                }
                
                dImpConceptoAux = stTempCargoRec.dMontoImporte;

                if ( !bConversionMoneda ( stCliente.lCodCliente       , 
                                          stTempCargoRec.szCodMoneda  ,
           		       	          stDatosGener.szCodMoneFact  ,
                                          szpFecDesde                 ,
                                         &stTempCargoRec.dMontoImporte))
                {
                     return FALSE;
                } /* P-MIX-09003 4 */          
           
                memset ( &stPasoProrrateo, 0, sizeof(PASOPRORRATEO));

                stPasoProrrateo.sIndAlta = shIndAlta;
                strcpy (stPasoProrrateo.szFecInicio , stCargoRecHost.szhFecAlta[lCont]);
                strcpy (stPasoProrrateo.szFecTermino, stCargoRecHost.szhFecBaja[lCont]);
                stPasoProrrateo.dImpServicio = stTempCargoRec.dMontoImporte;
                stPasoProrrateo.sIndTipoCobro= stGrupoCob.iTipCobro; 
                stPasoProrrateo.sIndProrrateo= stCargoRecHost.shIndCargoPro[lCont];
                
/* P-MIX-09003 */                

                vDTrazasLog( szExeName, "\n** (bEMCargosRecurrentes) Ejecución Package FA_SERVICIOS_FACTURACION_PG **"
                                      , LOG05);
                                      
                lhNumAbonado = stCargoRecHost.lhNumAbonado[lCont];
                lhCodCicloFact = stCiclo.lCodCiclFact;
                lhCodConcepto = stCargoRecHost.ihCodConcepto[lCont];
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
                sqlstm.arrsiz = 14;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "begin FA_SERVICIOS_FACTURACION_PG . FA_Consul\
taCobroAdelantado_PR ( :lhNumAbonado , :lhCodCicloFact , :lhCodConcepto , :lhN\
umProceso , :lhNumOcurrencias , :lhCodError , :szhMsgError , :lhEvento ) ; END\
 ;";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )154;
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


                
                vDTrazasLog( szExeName, "\n**  (bEMCargosRecurrentes) Package FA_SERVICIOS_FACTURACION_PG Procedure FA_ConsultaCobroAdelantado_PR() **"
                                             "\n\t\t\t=> lhNumAbonado...... [%ld]"
                                             "\n\t\t\t=> lhCodCicloFact.... [%ld]"
                                             "\n\t\t\t=> lhCodConcepto..... [%d]"
                                             "\n\t\t\t=> lhNumPorceso...... [%ld]"
                                             "\n\t\t\t=> lhNumOcurrencias.. [%ld]"                                              
                                             "\n\t\t\t=> lhCodError........ [%ld]"
                                             "\n\t\t\t=> szhMsgError....... [%s]"
                                             "\n\t\t\t=> lhEvento.......... [%ld]"
                                             "\n\t\t\t=> SQLCODE........... [%d]"                                                                                          
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
                     vDTrazasError( szExeName , "\n**  (bEMCargosRecurrentes) Error package FA_SERVICIOS_FACTURACION_PG    **"
                                                "\n**  en procedure FA_ConsultaCobroAdelantado_PR() **"
                                                " [%d]  [%s]"
                                              , LOG01,SQLCODE,SQLERRM);                                          
                     vDTrazasLog( szExeName, "\n**  (bEMCargosRecurrentes) Error en procedure FA_ConsultaCobroAdelantado_PR() **"
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
                      
                if ( lhNumOcurrencias > 0 )
                {
                     stPreFactura.A_PFactura[i].dImpConcepto = fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT);
	   	     vDTrazasLog (szExeName, "\t\t* Importe Servicio Suplementario Sin Prorrateado [%f], Numero de dias [%d]"
	   	                           , LOG05
	   	                           , fnCnvDouble(stPasoProrrateo.dImpServicio, USOFACT)
	   	                           , stCiclo.iDiaPeriodo);                     
                }  
                else
                {
                     if( !bfnProrrateoStandar(&stPasoProrrateo) )
                     {
                         vDTrazasLog (szExeName, "\n\t\t* NO se Prorrate-o el Importe Cargo Recurrente %s"
                                               , LOG03
                                               , stCargoRecHost.szhCodServicio[lCont]);
                         return FALSE;
                     }
	   	     vDTrazasLog (szExeName, "\t\t* Importe Servicio Suplementario Prorrateado [%f], Numero de dias prorrateados [%d]"
	   	                           , LOG05
	   	                           , fnCnvDouble(stPasoProrrateo.dImpConcepto, USOFACT)
	   	                           , stPasoProrrateo.sDiasAbono);
                }
/* P-MIX-09003 */        
                stPreFactura.A_PFactura[i].bOptServicios= TRUE;
                stPreFactura.A_PFactura[i].lNumProceso  = stStatus.IdPro;
                stPreFactura.A_PFactura[i].lCodCliente  = lhCodCliente;                                 
                stPreFactura.A_PFactura[i].lCodCiclFact = stCiclo.lCodCiclFact;
                stPreFactura.A_PFactura[i].iIndEstado   = EST_NORMAL;           
                stPreFactura.A_PFactura[i].iCodTipConce = ARTICULO;
                stPreFactura.A_PFactura[i].iIndFactur   = 1;
	
	        strcpy (stPreFactura.A_PFactura[i].szFecEfectividad,szSysDate);
                strcpy (stPreFactura.A_PFactura[i].szCodRegion     ,stCliente.szCodRegion);
                strcpy (stPreFactura.A_PFactura[i].szCodProvincia  ,stCliente.szCodProvincia);
                strcpy (stPreFactura.A_PFactura[i].szCodCiudad     ,stCliente.szCodCiudad);
                strcpy (stPreFactura.A_PFactura[i].szCodModulo     , "FA");
                stPreFactura.A_PFactura[i].lNumAbonado   = stCargoRecHost.lhNumAbonado[lCont];
                stPreFactura.A_PFactura[i].iCodProducto  = stCargoRecHost.lhCodProducto[lCont];
                stPreFactura.A_PFactura[i].iIndAlta      = stPasoProrrateo.sIndAlta;
                stPreFactura.A_PFactura[i].lCapCode      = pTmpSerA->lCapCode;
          	
                stPreFactura.A_PFactura[i].lCodPlanCom   = pTmpSerA->lCodPlanCom;
                stPreFactura.A_PFactura[i].iCodCatImpos  = stCliente.iCodCatImpos;
	   
	        strcpy (stPreFactura.A_PFactura[i].szFecValor   ,stCiclo.szFecEmision);
                strcpy (stPreFactura.A_PFactura[i].szNumTerminal,pTmpSerA->szNumTerminal);
                stPreFactura.A_PFactura[i].iCodConcepto = stCargoRecHost.ihCodConcepto[lCont];                                  /*Listo*/
           
                memset ( &stConcepto, 0, sizeof(CONCEPTO));
           
                if ( !bFindConcepto (stCargoRecHost.ihCodConcepto[lCont],&stConcepto) )
		{
		     iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
		     return FALSE;
		}
		else
		{
		     if ( stConcepto.iIndActivo == 0 )
		     {
		         sprintf (stAnomProceso.szObsAnomalia, "%s %d","Ind.Activo Cero"
		                                             , stConcepto.iIndActivo);
		           return FALSE;
		     }
		}        
           
                strcpy (stPreFactura.A_PFactura[i].szDesConcepto,stConcepto.szDesConcepto);
           
                if ( !bGetMaxColPreFa ( stPreFactura.A_PFactura[i].iCodConcepto,
                                        &stPreFactura.A_PFactura[i].lColumna) )
                {
                     return FALSE;
                }
                
                if (stPasoProrrateo.dImpServicio == 0)
                {
                    stPreFactura.A_PFactura[i].dImpMontoBase    = 0;
                }
                else              
                {
                    if (dImpConceptoAux != stPasoProrrateo.dImpServicio)
                    {
                        stPreFactura.A_PFactura[i].dImpMontoBase    = fnCnvDouble(stPasoProrrateo.dImpServicio,0)/fnCnvDouble(dImpConceptoAux,0);
                    }
                    else
                    {
                    	stPreFactura.A_PFactura[i].dImpMontoBase    = 0;
                    }
                }

                stPreFactura.A_PFactura[i].iCodConceRel   = 0;
                stPreFactura.A_PFactura[i].lColumnaRel    = 0;
                strcpy(stPreFactura.A_PFactura[i].szCodMoneda ,stTempCargoRec.szCodMoneda);
                stPreFactura.A_PFactura[i].dImpConcepto   = fnCnvDouble(stPasoProrrateo.dImpConcepto, USOFACT);
                stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble(stPasoProrrateo.dImpConcepto, USOFACT);
                stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable,USOFACT);                
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
			
                if( bfnIncrementarIndicePreFactura()==FALSE )
                {
                   vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                   vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                   return FALSE;
                } 

	        if( !bUpdateCargosRecurrentes(stCargoRecHost.szRowid[lCont]) )
	        {
	            vDTrazasLog  (szExeName,">> ERROR: Al Actualizar el detalle del Cargo Regucurrente <<",LOG01);
	            return FALSE;
	        }
           }/* for (lCont = 0 ; lCont < lNumFilas ; lCont++) */    
    }/* fin while ... */
  
    iOra = iCloseCargosRec();
    if ( iOra != SQLOK )
    {
	 vDTrazasLog  (szExeName,">> ERROR: Al Realizar Close al cursor Cur_CargosRecurrentes  <<",LOG03);
         vDTrazasError(szExeName,">> ERROR: Al Realizar Close al cursor Cur_CargosRecurrentes  <<",LOG03);
	 return FALSE;
    }
  
    return TRUE;
}/************************* Final bfnCargaCargosRecurrentes ********************/

static BOOL bUpdateCargosRecurrentes(char *szRowid)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

   	long  lhNumProceso   ;
   	long  lhCodCiclFac   ;
   	char  szhRowid       [19]; /* EXEC SQL VAR szhRowid IS STRING(19); */ 

   	char  szFormatoFec[17]  ; /* EXEC SQL VAR szFormatoFec  IS STRING(17); */ 

   	/* EXEC SQL END DECLARE SECTION  ; */ 

   	
    strcpy(szhRowid, szRowid);
   	lhNumProceso = stStatus.IdPro;
   	lhCodCiclFac = stCiclo.lCodCiclFact;

   	strcpy(szFormatoFec,"YYYYMMDDHH24MISS");

   /* EXEC SQL UPDATE 
                   FA_CARGOS_REC_TO
            SET    FEC_ULTFACTURA  = TO_DATE (:szpFecEmision,:szFormatoFec),
	  			   COD_ULTCICLFACT = :lhCodCiclFac ,
	  			   NUM_ULTPROCESO  = :lhNumProceso       
            WHERE  ROWID = :szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update FA_CARGOS_REC_TO  set FEC_ULTFACTURA=TO_DATE(:b0,:b\
1),COD_ULTCICLFACT=:b2,NUM_ULTPROCESO=:b3 where ROWID=:b4";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )201;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szpFecEmision;
   sqlstm.sqhstl[0] = (unsigned long )15;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[1] = (unsigned long )17;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFac;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szhRowid;
   sqlstm.sqhstl[4] = (unsigned long )19;
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
       iDError (szExeName,ERR000,vInsertarIncidencia,"Update->Fa_Cargos_Rec_To",
                szfnORAerror());

   return (SQLCODE)?FALSE:TRUE;
}


/* PGG SOPORTE: 15-09-2005 Funcion nueva que obtiene la cantidad de dias a prorratear, tanto del periodo actual, como del anterior */
static BOOL bfnObtieneCantDiasAProrratear (int iDiasTotales, int *iDiasAnt, int *iDiasActual)
{

    vDTrazasLog(szExeName,  "bfnObtieneCantDiasAProrratear  iDiasTotales(%d)\n"
                            "bfnObtieneCantDiasAProrratear  stCiclo.iDiaPeriodo(%d)"
                            ,LOG03, iDiasTotales, stCiclo.iDiaPeriodo);

    *iDiasAnt   = iDiasTotales - stCiclo.iDiaPeriodo;
    *iDiasActual    = stCiclo.iDiaPeriodo;

    vDTrazasLog(szExeName,  "bfnObtieneCantDiasAProrratear  iDiasAnt(%d)\n"
                            "bfnObtieneCantDiasAProrratear  iDiasActual(%d)",LOG03, *iDiasAnt, *iDiasActual);

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
    int iDiasAnt    ;   /* PGG SOPORTE: 15-09-2005 */
    int iDiasActual ;       /* PGG SOPORTE: 15-09-2005 */

    vDTrazasLog(szExeName,  "\n\t\t* bfnProrrateoStandar CR"
                "\n\t\t=> Fec Inicio  : [%s]"
                "\n\t\t=> Fec Termino     : [%s]"
                "\n\t\t=> Importe Servicio: [%f]"
                "\n\t\t=> Tipo de cobro   : [%d]"
                "\n\t\t=> Ind Alta        : [%d]",LOG03,
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
                "\n\t\t=> stCiclo.iDiaPeriodoAnt       : [%d]",LOG03,
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
                            "\n\t\t=> pCargo->szFecInicio          : [%s]",LOG03,
                            stCiclo.szFecHastaCFijos,
                            pCargo->szFecInicio);
            }
            else
            {
                iDiasAlta = stCiclo.iDiaPeriodo;
            }

            /* TM-1705 (1-1) ---> TRAZAS */
            vDTrazasLog(szExeName,  "\n\t\t* bRestaFechas --> Dias Alta..."
                        			"\n\t\t=> iDiasAlta  SALIDA     : [%d]",LOG03,
                        iDiasAlta);                     

            if (iDiasAlta > stCiclo.iDiaPeriodo)
            {
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "Dias Alta condicion iDiasAlta > stCiclo.iDiaPeriodo (%d)",LOG03,
                        iDiasAlta);

                if (!bfnObtieneCantDiasAProrratear (iDiasAlta, &iDiasAnt, &iDiasActual))
                {
                    vDTrazasLog(szExeName,  "\n\t\t CASO 4 :(Obtencion de dias para Prorratear)"
                                "\n\t\t=> Error en la ejecucion de F(x)  bfnObtieneCantDiasAProrratear", LOG03);
                    return (FALSE);

                }
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "bfnObtieneCantDiasAProrratear   iDiasAnt (%d) -- iDiasActual (%d)\n",LOG03,
                            iDiasAnt,iDiasActual);


                if ((stCiclo.iDiaPeriodo == 0) || (stCiclo.iDiaPeriodoAnt == 0))
                {
                   /* TM-1705 (1-1) ---> TRAZAS */
                   vDTrazasLog(szExeName,  "stCiclo.iDiaPeriodo == 0) || (stCiclo.iDiaPeriodoAnt == 0\n",LOG03);
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
                      vDTrazasLog(szExeName,  "pCargo->dImpConcepto A (%f)\n",LOG03, pCargo->dImpConcepto);
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
                      vDTrazasLog(szExeName,  "pCargo->dImpConcepto B (%f)\n",LOG03, pCargo->dImpConcepto);
                    }
                }
                else
                {

                    pCargo->dImpConcepto = (double) (((pCargo->dImpServicio * iDiasActual) / stCiclo.iDiaPeriodo) + 
                                                     ((pCargo->dImpServicio * iDiasAnt) / stCiclo.iDiaPeriodoAnt));
                    vDTrazasLog(szExeName,  "CARGO IMPUESTO SERVICIO %lf\n"
                                            "DIAS PERIODO ACTUAL %d\n"
                                            "DIAS ACTUAL %d\n"
                                            "========================\n"
                                            "CARGO IMPUESTO SERVICIO %lf\n"
                                            "DIAS PERIODO ANTERIOR %d\n"
                                            "DIAS ANTERIOR %d\n"
                                            "========================\n"
                                            "TOTAL CARGO IMPUESTO CONCEPTO %lf\n"
                                            ,LOG03,pCargo->dImpServicio,stCiclo.iDiaPeriodo,iDiasActual
                                            ,pCargo->dImpServicio,stCiclo.iDiaPeriodoAnt,iDiasAnt,pCargo->dImpConcepto);
                }
            }
            else
            {
                vDTrazasLog(szExeName,  "C  iDiasAlta (%d) -- stCiclo.iDiaPeriodo (%d)\n",LOG03, iDiasAlta, stCiclo.iDiaPeriodo);
                if (stCiclo.iDiaPeriodo == 0)
                    pCargo->dImpConcepto = 0.0;
                else
                    pCargo->dImpConcepto = (double) ((pCargo->dImpServicio * iDiasAlta) / stCiclo.iDiaPeriodo);
                /* TM-1705 (1-1) ---> TRAZAS */
                vDTrazasLog(szExeName,  "pCargo->dImpConcepto C (%f)\n",LOG03, pCargo->dImpConcepto);
            }

            pCargo->sDiasAbono   = iDiasAlta;

            vDTrazasLog(szExeName,  "\n\t\t CASO 4 :(A anterior y B posterior)\n"
                                    "\t\t=> Ind Prorrateo   : [%d]\n"
                                    "\t\t=> Dias Abono      : [%d]\n"
                                    "\t\t=> Importe Concepto: [%f]\n",LOG03,
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
                                    "\t\t=> Importe Concepto: [%f]\n",LOG03,
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

            if (iDiasAlta == 0 ) iDiasAlta = 1;

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
                                    "\t\t=> Importe Concepto: [%f]\n",LOG03,
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
                                    "\t\t=> Error en la ejecucion de F(x)  bfnObtieneCantDiasAProrratear\n", LOG03);
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
                                    "\t\t=> Importe Concepto: [%f]\n",LOG03,
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
                            "\t\t=> Importe Concepto: [%f]\n",LOG03,
                            pCargo->sIndProrrateo,
                            pCargo->sDiasAbono,
                            pCargo->dImpConcepto);
            }
            else {
                vDTrazasLog(szExeName,  "\n\t\t CASO 5 :(A y B anterior al Periodo) Cargo Basico Facturado Previamente (No se Prorraeta)...\n"
                                        "\t\t=> Ind Prorrateo   : [%d]\n"
                                        "\t\t=> Dias Abono      : [%d]\n"
                                        "\t\t=> Importe Concepto: [%f]\n",LOG03,
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
                                "\t\t Importe Concepto : [%f]\n",LOG03,
                                pCargo->dImpServicio);

        pCargo->dImpConcepto = fnCnvDouble(pCargo->dImpServicio, USOFACT);
        pCargo->sDiasAbono   = stCiclo.iDiaPeriodo;
    }

    return TRUE;
}
/**************************** Fin bfnProrrateoStandar ***************************************/

