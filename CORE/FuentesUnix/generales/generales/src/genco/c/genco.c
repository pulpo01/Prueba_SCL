
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
    "./pc/genco.pc"
};


static unsigned int sqlctx = 431043;


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
   unsigned char  *sqhstv[27];
   unsigned long  sqhstl[27];
            int   sqhsts[27];
            short *sqindv[27];
            int   sqinds[27];
   unsigned long  sqharm[27];
   unsigned long  *sqharc[27];
   unsigned short  sqadto[27];
   unsigned short  sqtdso[27];
} sqlstm = {12,27};

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

 static const char *sq0024 = 
"select NUM_SECUENCI ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COLUMNA ,(IMP\
ORTE_HABER-IMPORTE_DEBE) ,TO_CHAR(SYSDATE,'YYYYMMDD') ,NUM_ABONADO ,COD_PRODUC\
TO ,NVL(SEC_CUOTA,(-1))  from CO_CARTERA where ((COD_CLIENTE=:b0 and NUM_FOLIO\
=:b1) and COD_TIPDOCUM=39)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,55,0,4,46,0,0,1,0,0,1,0,2,5,0,0,
24,0,0,2,195,0,4,93,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,
0,0,1,3,0,0,
67,0,0,3,152,0,3,116,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,
110,0,0,4,174,0,5,147,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,
153,0,0,5,648,0,3,447,0,0,27,27,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,
276,0,0,6,112,0,4,570,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
303,0,0,7,224,0,4,580,0,0,9,8,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
354,0,0,8,252,0,5,617,0,0,10,10,0,1,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
409,0,0,9,1057,0,3,687,0,0,11,11,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
468,0,0,10,247,0,2,768,0,0,10,10,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
523,0,0,11,123,0,4,806,0,0,1,0,0,1,0,2,3,0,0,
542,0,0,12,48,0,4,843,0,0,1,0,0,1,0,2,3,0,0,
561,0,0,13,47,0,4,848,0,0,1,0,0,1,0,2,3,0,0,
580,0,0,14,47,0,4,853,0,0,1,0,0,1,0,2,3,0,0,
599,0,0,15,53,0,4,858,0,0,1,0,0,1,0,2,3,0,0,
618,0,0,16,53,0,4,863,0,0,1,0,0,1,0,2,3,0,0,
637,0,0,17,55,0,4,868,0,0,1,0,0,1,0,2,3,0,0,
656,0,0,18,52,0,4,873,0,0,1,0,0,1,0,2,3,0,0,
675,0,0,19,50,0,4,878,0,0,1,0,0,1,0,2,3,0,0,
694,0,0,20,50,0,4,883,0,0,1,0,0,1,0,2,3,0,0,
713,0,0,21,56,0,4,888,0,0,1,0,0,1,0,2,3,0,0,
732,0,0,22,0,0,17,931,0,0,1,1,0,1,0,1,5,0,0,
751,0,0,22,0,0,45,947,0,0,0,0,0,1,0,
766,0,0,22,0,0,13,957,0,0,1,0,0,1,0,2,5,0,0,
785,0,0,22,0,0,15,961,0,0,0,0,0,1,0,
800,0,0,23,57,0,4,963,0,0,1,0,0,1,0,2,5,0,0,
819,0,0,24,269,0,9,1040,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
842,0,0,24,0,0,13,1050,0,0,10,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
897,0,0,25,287,0,5,1082,0,0,8,8,0,1,0,1,4,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,
944,0,0,26,282,0,5,1098,0,0,9,9,0,1,0,1,4,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/****************************************************************************/
/*                                                                          */
/*    Descripcion : Funciones generales del modulo de Cobros                */
/*                                                                          */
/*    Modulo      : COBROS.                                                 */
/*                                                                          */
/*    Fichero     : genco.pc                                                */
/*                                                                          */
/*    Programador : Julia Serrano Pozo.                                     */
/*                                                                          */
/*    Fecha       : 21-01-1997                                              */
/*                                                                          */
/*    Modificacion: 21-01-1997                                              */
/*                                                                          */
/****************************************************************************/
/*                                                                          */
/*    Modificacion: 17-03-2004                                              */
/*    Programador: PGonzalez 		                                    */
/****************************************************************************/

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <GenTypes.h>
#include <geora.h>
#include <GenORA.h>
#include <genco.h>

/****************************************************************************/
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

BOOL bfnDBValFecValor(char *szFecValor)
/**
Valida si la fecha pasada por argumento es menor o igual que SYSDATE.
Si en mayor devuelve FALSE.
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szhFecha[9]   ; /* EXEC SQL VAR szhFecha IS STRING(9); */ 

	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL
	SELECT	TO_CHAR(SYSDATE,'yyyymmdd')
	INTO	:szhFecha
	FROM	DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,'yyyymmdd') into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
 sqlstm.sqhstl[0] = (unsigned long )9;
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
		fprintf(stderr,"* Error recuperando fecha de sistema- %d\n",
		sqlca.sqlcode);
		fflush(stderr);                     
		return FALSE;
	}
	
	if (strcmp(szFecValor,szhFecha) > 0)
		return FALSE;
	else
		return TRUE ;

} /* Fin bfnDBValFecValor() */

/*****************************************************************************/
BOOL bfnDBSecCol(DATCON *stCon)
/**
Descripcion: Funcion que obtiene la secuencia de la proxima columna.
Entrada:     stCon, estructura de datos de concepto generado.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int     ihCodTipDocum;
		long    lhCodAgente  ;
		char    *szhLetra    ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int     ihCodCentremi;
		long    lhNumSecuenci;
		int     ihCodConcepto;
		int     ihColumna    ;
		short   shIndColumna ;
	/* EXEC SQL END DECLARE SECTION; */ 


	ihCodTipDocum = stCon->iCodTipDocum;
	lhCodAgente   = stCon->lCodAgente  ;
	szhLetra      = stCon->szLetra     ;
	ihCodCentremi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	ihCodConcepto = stCon->iCodConcepto;
	
	/* EXEC SQL
	SELECT	COLUMNA
	INTO	:ihColumna:shIndColumna
	FROM	CO_SECARTERA
	WHERE	NUM_SECUENCI   = :lhNumSecuenci
	AND		COD_TIPDOCUM     = :ihCodTipDocum
	AND		COD_VENDEDOR_AGENTE     = :lhCodAgente
	AND		LETRA          = :szhLetra
	AND		COD_CENTREMI   = :ihCodCentremi
	AND		COD_CONCEPTO   = :ihCodConcepto
	FOR UPDATE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COLUMNA into :b0:b1  from CO_SECARTERA where (((((NUM\
_SECUENCI=:b2 and COD_TIPDOCUM=:b3) and COD_VENDEDOR_AGENTE=:b4) and LETRA=:b5\
) and COD_CENTREMI=:b6) and COD_CONCEPTO=:b7) for update ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )24;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)&shIndColumna;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
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


	
	if (sqlca.sqlcode < 0 && sqlca.sqlcode != NOT_FOUND)
	{
		fprintf(stderr,"* Error al obtener la secuencia de la columna %d\n", sqlca.sqlcode);
		return FALSE ;
	}
	
	if (sqlca.sqlcode == NOT_FOUND || shIndColumna == ORA_NULL)
	{
		ihColumna		= 0;
		shIndColumna	= 0;
		
		/* EXEC SQL
		INSERT INTO CO_SECARTERA (  NUM_SECUENCI  ,
									COD_TIPDOCUM  ,
									COD_VENDEDOR_AGENTE    ,
									LETRA         ,
									COD_CENTREMI  ,
									COD_CONCEPTO  ,
									COLUMNA       )
		VALUES ( 					:lhNumSecuenci,
									:ihCodTipDocum,
									:lhCodAgente  ,
									:szhLetra     ,
									:ihCodCentremi,
									:ihCodConcepto,
									:ihColumna   :shIndColumna ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into CO_SECARTERA (NUM_SECUENCI,COD_TIPDOCUM,COD_VEN\
DEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA) values (:b0,:b1,:b2,:b3,\
:b4,:b5,:b6:b7)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )67;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodAgente;
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
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)&shIndColumna;
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


		
		if (sqlca.sqlcode != SQLOK)
		{
			fprintf(stderr,"Error al insertar en CO_SECARTERA %d\n", sqlca.sqlcode);
			fflush(stderr);
			return FALSE;
		}
	}
	else
	{
		if (ihColumna == 9999)
			ihColumna = 1;
		else
			ihColumna++;
	}
	
	/* EXEC SQL
	UPDATE	CO_SECARTERA
	SET 	COLUMNA = :ihColumna
	WHERE	NUM_SECUENCI   = :lhNumSecuenci
	AND		COD_TIPDOCUM   = :ihCodTipDocum
	AND		COD_VENDEDOR_AGENTE     = :lhCodAgente
	AND		LETRA          = :szhLetra
	AND		COD_CENTREMI   = :ihCodCentremi
	AND		COD_CONCEPTO   = :ihCodConcepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_SECARTERA  set COLUMNA=:b0 where (((((NUM_SECUENCI\
=:b1 and COD_TIPDOCUM=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA=:b4) and COD\
_CENTREMI=:b5) and COD_CONCEPTO=:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )110;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
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


	
	if( sqlca.sqlcode < 0 )
	{
		fprintf(stderr,"* Error al obtener la secuencia de la columna %d\n", sqlca.sqlcode);
		return FALSE ;
	}
	stCon->iColumna = ihColumna;
	return TRUE;
} /* Fin bfnDBSecCol() */

/*****************************************************************************/
BOOL bfnDBIntCartera(DATCON *stConGen,long lCodCliente)
/**
Descripcion: Funcion que introduce en cartera el concepto generado.
Entrada:     stConGen, estructura de concepto generado.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
{

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lhCodCliente          ;
		int     ihCodTipDocum         ;
		long    lhCodAgente           ;
		char    *szhLetra             ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int     ihCodCentremi         ;
		long    lhNumSecuenci         ;
		int     ihCodConcepto         ;
		int     ihColumna             ;
		double  dhImporteDebe         ;
		double  dhImporteHaber        ;
		int     ihCodProducto         ;
		int     ihIndContado          ;
		int     ihIndFacturado        ;
		char    szhFecEfectividad  [9]; /* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 

		char    szhFecVencimie     [9]; /* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 

		char    szhFecCaducida     [9]; /* EXEC SQL VAR szhFecCaducida IS STRING(9); */ 

		char    szhFecAntiguedad   [9]; /* EXEC SQL VAR szhFecAntiguedad IS STRING(9); */ 

		char    szhFecPago         [9]; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

		long    lhNumAbonado          ;
		long    lhNumFolio            ;
		long    lhNumCuota            ;
		int     ihSecCuota            ;
		long    lhNumTransa           ;
		long    lhNumVenta            ;
		char    szhFolioCTC       [12]; /* EXEC SQL VAR szhFolioCTC IS STRING(12); */ 

		short   shIndFecVencimie      ;
		short   shIndFecCaducida      ;
		short   shIndFecAntiguedad    ;
		short   shIndFecPago	      ;
		short   shIndNumAbonado       ;
		short   shIndNumFolio         ;
		short   shIndNumCuota         ;
		short   shIndSecCuota         ;
		short   shIndNumTransa        ;
		short   shIndNumVenta         ;
		short   shIndFolioCTC         ;
		char    szhPrefPlaza      [25+1]; /* EXEC SQL VAR szhPrefPlaza IS STRING(25+1); */ 

		char    szhCodOperadoraScl [6]; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 

		char    szhCodPlaza        [6]; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 

		short   shIndPrefPlaza        ;
		short   shIndCodOperadoraScl  ;
		short   shIndCodPlaza         ;
		
	/* EXEC SQL END DECLARE SECTION; */ 

	
	BOOL bResul;

	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )
	{
		fprintf( stderr, "Error al realizar carga de bGetParamDecimales()." );
		return FALSE;
	}

	lhCodCliente  = lCodCliente           ;
	ihCodTipDocum = stConGen->iCodTipDocum;
	lhCodAgente   = stConGen->lCodAgente  ;
	szhLetra      = stConGen->szLetra     ;
	ihCodCentremi = stConGen->iCodCentremi;
	lhNumSecuenci = stConGen->lNumSecuenci;
	ihCodConcepto = stConGen->iCodConcepto;
	ihCodProducto = stConGen->iCodProducto;
	
	bResul = bfnDBSecCol(stConGen);
	
	if (!bResul)
		return FALSE;

	ihColumna = stConGen->iColumna;
	
	dhImporteDebe = stConGen->dImporteDebe;
	dhImporteHaber = stConGen->dImporteHaber;
	
	ihIndContado = stConGen->iIndContado;
	ihIndFacturado = stConGen->iIndFacturado;
	
	strcpy(szhFecEfectividad,stConGen->szFecEfectividad);

	if (strlen(stConGen->szFecVencimie) == 0)
	{
		strcpy(szhFecVencimie,"");
		shIndFecVencimie = ORA_NULL;
	}
	else
	{
		strcpy(szhFecVencimie,stConGen->szFecVencimie);
		shIndFecVencimie = 0;
	}
	
	if (strlen(stConGen->szFecCaducida) == 0)
	{
		strcpy(szhFecCaducida,"");
		shIndFecCaducida = ORA_NULL;
	}
	else
	{
		strcpy(szhFecCaducida,stConGen->szFecCaducida);
		shIndFecCaducida = 0;
	}
	
	if (strlen(stConGen->szFecAntiguedad) == 0)
	{
		strcpy(szhFecAntiguedad,"");
		shIndFecAntiguedad = ORA_NULL;
	}
	else
	{
		strcpy(szhFecAntiguedad,stConGen->szFecAntiguedad);
		shIndFecAntiguedad = 0;
	}

	if (strlen(stConGen->szFecPago) == 0)
	{
		strcpy(szhFecPago,"");
		shIndFecPago = ORA_NULL;
	}
	else
	{
		strcpy(szhFecPago,stConGen->szFecPago);
		shIndFecPago = 0;
	}
	
	if (stConGen->lNumAbonado == ORA_NULL)
	{
		lhNumAbonado = ORA_NULL;
		shIndNumAbonado = ORA_NULL;
	}
	else
	{
		shIndNumAbonado = 0;
		lhNumAbonado = stConGen->lNumAbonado;
	}

	if (stConGen->lNumFolio == ORA_NULL)
	{
		lhNumFolio = ORA_NULL;
		shIndNumFolio = ORA_NULL;
	}
	else
	{
		shIndNumFolio = 0;
		lhNumFolio = stConGen->lNumFolio;
	}

	if (stConGen->lNumCuota == ORA_NULL)
	{
		lhNumCuota = ORA_NULL;
		shIndNumCuota = ORA_NULL;
	}
	else
	{
		shIndNumCuota = 0;
		lhNumCuota = stConGen->lNumCuota;
	}

	if (stConGen->iSecCuota == ORA_NULL)
	{
		ihSecCuota = ORA_NULL;
		shIndSecCuota = ORA_NULL;
	}
	else
	{
		shIndSecCuota = 0;
		ihSecCuota = stConGen->iSecCuota;
	}

	if (stConGen->lNumTransa == ORA_NULL)
	{
		lhNumTransa = ORA_NULL;
		shIndNumTransa = ORA_NULL;
	}
	else
	{
		shIndNumTransa = 0;
		lhNumTransa = stConGen->lNumTransa;
	}

	if (stConGen->lNumVenta == ORA_NULL)
	{
		lhNumVenta = ORA_NULL;
		shIndNumVenta = ORA_NULL;
	}
	else
	{
		shIndNumVenta = 0;
		lhNumVenta = stConGen->lNumVenta;
	}

	if (strlen(stConGen->szFolioCTC) == 0)
	{
		strcpy(szhFolioCTC,"");
		shIndFolioCTC = ORA_NULL;
	}
	else
	{
		strcpy(szhFolioCTC,stConGen->szFolioCTC);
		shIndFolioCTC = 0;
	}
	
	if (strlen(stConGen->szPrefPlaza) == 0)
	{
		strcpy(szhPrefPlaza,"");
		shIndPrefPlaza = ORA_NULL;
	}
	else
	{
		strcpy(szhPrefPlaza,stConGen->szPrefPlaza);
		shIndPrefPlaza = 0;
	}

	if (strlen(stConGen->szCodOperadoraScl) == 0)
	{
		strcpy(szhCodOperadoraScl,"");
		shIndCodOperadoraScl = ORA_NULL;
	}
	else
	{
		strcpy(szhCodOperadoraScl,stConGen->szCodOperadoraScl);
		shIndCodOperadoraScl = 0;
	}

	if (strlen(stConGen->szCodPlaza) == 0)
	{
		strcpy(szhCodPlaza,"");
		shIndPrefPlaza = ORA_NULL;
	}
	else
	{
		strcpy(szhCodPlaza,stConGen->szCodPlaza);
		shIndCodPlaza = 0;
	}
		
	/* manejo de decimales segun la operadora local */
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	/* manejo de decimales segun la operadora local */
	dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

	/***************************************************/
	fprintf( stdout,"cliente           [%ld]\n", lhCodCliente );
	fprintf( stdout,"tipdocum          [%d]\n",	ihCodTipDocum );
	fprintf( stdout,"agente            [%ld]\n", lhCodAgente );
	fprintf( stdout,"letra             [%s]\n",	szhLetra );
	fprintf( stdout,"centremi          [%d]\n",	ihCodCentremi );
	fprintf( stdout,"numsecuenci       [%ld]\n", lhNumSecuenci );
	fprintf( stdout,"concepto          [%d]\n",	ihCodConcepto );
	fprintf( stdout,"columna           [%d]\n",	ihColumna );
	fprintf( stdout,"producto          [%d]\n",	ihCodProducto );
	fprintf( stdout,"importe debe      [%f]\n",	dhImporteDebe );
	fprintf( stdout,"importe haber     [%f]\n",	dhImporteHaber );
	fprintf( stdout,"contado           [%d]\n",	ihIndContado );
	fprintf( stdout,"facturado         [%d]\n",	ihIndFacturado );
	fprintf( stdout,"fecha efectividad [%s]\n",	szhFecEfectividad );
	fprintf( stdout,"fecha vencimiento [%s]\n",	szhFecVencimie );
	fprintf( stdout,"fecha caducidad   [%s]\n",	szhFecCaducida );
	fprintf( stdout,"fecha antiguedad  [%s]\n",	szhFecAntiguedad );
	fprintf( stdout,"fecha Pago        [%s]\n",	szhFecPago );
	fprintf( stdout,"num abonado       [%ld]\n", lhNumAbonado );
	fprintf( stdout,"num folio         [%ld]\n", lhNumFolio );
	fprintf( stdout,"num cuota         [%ld]\n", lhNumCuota );
	fprintf( stdout,"sec cuota         [%d]\n",	ihSecCuota );
	fprintf( stdout,"num transa        [%ld]\n", lhNumTransa );
	fprintf( stdout,"num venta         [%ld]\n", lhNumVenta );
	fprintf( stdout,"FolioCTC          [%s]\n",	szhFolioCTC );
	fprintf( stdout,"prefijo plaza     [%s]\n",	szhPrefPlaza );        
	fprintf( stdout,"codigo operadora  [%s]\n",	szhCodOperadoraScl );  
	fprintf( stdout,"codigo plaza      [%s]\n",	szhCodPlaza );         
	fflush(stdout);
	/***************************************************/
	
	/* EXEC SQL 
	INSERT INTO CO_CARTERA	(	COD_CLIENTE   ,
								NUM_SECUENCI  ,
								COD_TIPDOCUM  ,
								COD_VENDEDOR_AGENTE    ,
								LETRA         ,
								COD_CENTREMI  ,
								COD_CONCEPTO  ,
								COLUMNA       ,
								COD_PRODUCTO  ,
								IMPORTE_DEBE  ,
								IMPORTE_HABER ,
								IND_CONTADO   ,
								IND_FACTURADO ,
								FEC_EFECTIVIDAD,
								FEC_VENCIMIE  ,
								FEC_CADUCIDA  ,
								FEC_ANTIGUEDAD,
								FEC_PAGO	,
								NUM_ABONADO   ,
								NUM_FOLIO     ,
								NUM_CUOTA     ,
								SEC_CUOTA     ,
								NUM_TRANSACCION,
								NUM_VENTA     ,
								NUM_FOLIOCTC  ,
						                PREF_PLAZA    ,
                				                COD_OPERADORA_SCL,
                				                COD_PLAZA         )
	VALUES					(	:lhCodCliente ,
								:lhNumSecuenci,
								:ihCodTipDocum,
								:lhCodAgente  ,
								:szhLetra     ,
								:ihCodCentremi,
								:ihCodConcepto,
								:ihColumna    ,
								:ihCodProducto,
								:dhImporteDebe,
								:dhImporteHaber,
								:ihIndContado ,
								:ihIndFacturado,
								TO_DATE(:szhFecEfectividad,'YYYYMMDD'),
								TO_DATE(:szhFecVencimie:shIndFecVencimie,'YYYYMMDD'),
								SYSDATE, /o antes TO_DATE(TO_CHAR(:szhFecCaducida:shIndFecCaducida),'YYYYMMDD'), o/
								TO_DATE(:szhFecAntiguedad:shIndFecAntiguedad,'YYYYMMDD'),
								TO_DATE(:szhFecPago:shIndFecPago,'YYYYMMDD'),
								:lhNumAbonado:shIndNumAbonado,
								:lhNumFolio:shIndNumFolio,
								:lhNumCuota:shIndNumCuota,
								:ihSecCuota:shIndSecCuota,
								:lhNumTransa:shIndNumTransa,
								:lhNumVenta:shIndNumVenta,
								:szhFolioCTC:shIndFolioCTC,
						       	        :szhPrefPlaza:shIndPrefPlaza,
	          					        :szhCodOperadoraScl:shIndCodOperadoraScl,
	          					        :szhCodPlaza:shIndCodPlaza ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_CARTERA (COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCU\
M,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMP\
ORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_VENCIMIE\
,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_ABONADO,NUM_FOLIO,NUM_CUOTA,SEC_CUOT\
A,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_PLAZA,COD_OPERADORA_SCL,COD_PLAZ\
A) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,TO_DATE(:b13\
,'YYYYMMDD'),TO_DATE(:b14:b15,'YYYYMMDD'),SYSDATE,TO_DATE(:b16:b17,'YYYYMMDD')\
,TO_DATE(:b18:b19,'YYYYMMDD'),:b20:b21,:b22:b23,:b24:b25,:b26:b27,:b28:b29,:b3\
0:b31,:b32:b33,:b34:b35,:b36:b37,:b38:b39)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )153;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&dhImporteHaber;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&ihIndContado;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[13] = (unsigned char  *)szhFecEfectividad;
 sqlstm.sqhstl[13] = (unsigned long )9;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhFecVencimie;
 sqlstm.sqhstl[14] = (unsigned long )9;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)&shIndFecVencimie;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhFecAntiguedad;
 sqlstm.sqhstl[15] = (unsigned long )9;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)&shIndFecAntiguedad;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)szhFecPago;
 sqlstm.sqhstl[16] = (unsigned long )9;
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)&shIndFecPago;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)&shIndNumAbonado;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)&shIndNumFolio;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)&lhNumCuota;
 sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)&shIndNumCuota;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)&ihSecCuota;
 sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)&shIndSecCuota;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)&lhNumTransa;
 sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)&shIndNumTransa;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)&lhNumVenta;
 sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)&shIndNumVenta;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)szhFolioCTC;
 sqlstm.sqhstl[23] = (unsigned long )12;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)&shIndFolioCTC;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)szhPrefPlaza;
 sqlstm.sqhstl[24] = (unsigned long )26;
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)&shIndPrefPlaza;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)szhCodOperadoraScl;
 sqlstm.sqhstl[25] = (unsigned long )6;
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)&shIndCodOperadoraScl;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)szhCodPlaza;
 sqlstm.sqhstl[26] = (unsigned long )6;
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)&shIndCodPlaza;
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



	if( sqlca.sqlcode != 0 )
	{
		fprintf(stderr,"ERROR al insertar en CO_CARTERA %d : %s\n",sqlca.sqlcode,sqlca.sqlerrm.sqlerrmc);
		fflush(stderr);
		return FALSE;
	}
	fprintf( stdout, "se ha insertado un registro en cartera\n" );
	fflush(stdout);
	return TRUE;

}/* Fin bfnDBIntCartera() */
/*****************************************************************************/
BOOL bfnDBUpdCartera(DATCON *stCon,long lCodCliente)
/**
Descripcion: Modifica el importe del concepto
Salida     : True, si todo va ok
             False, si se genera algun error
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int    ihCodTipDocum   ;
		long   lhCodAgente     ;
		char   *szhLetra       ; /* EXEC SQL VAR szhLetra     IS STRING(2); */ 

		int    ihCodCentrEmi   ;
		long   lhNumSecuenci   ;
		int    ihCodConcepto   ;
		int    ihColumna       ;
		char   *szhFecHistorico; /* EXEC SQL VAR szhFecHistorico IS STRING(9); */ 

		int    ihCodProducto   ;
		long   lhNumAbonado    ;
		double dhImporteHaber  ;
		double dhImporteDebe   ;
		long   lhCodCliente    ;
		long   lhNumFolio      ;
		int    ihFlgCastigo    ;
		double dhImpHaberAnt   ;
		double dhMtoPago       ;
		int    ihSecCuota      ;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	lhCodCliente  = lCodCliente;
	lhNumFolio    = stCon->lNumFolio   ;
	ihCodTipDocum = stCon->iCodTipDocum;
	ihCodCentrEmi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	lhCodAgente   = stCon->lCodAgente ;
	szhLetra      = stCon->szLetra     ;
	ihCodConcepto = stCon->iCodConcepto;
	ihColumna     = stCon->iColumna;
	ihCodProducto = stCon->iCodProducto;
	lhNumAbonado  = stCon->lNumAbonado;
	dhImporteHaber= stCon->dImporteHaber;
	dhImporteDebe = stCon->dImporteDebe;

	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )
	{
		fprintf( stderr, "Error al realizar carga de bGetParamDecimales()." );
		return FALSE;
	}

	/*if ( ihCodTipDocum == 1 || ihCodTipDocum == 2 || ihCodTipDocum == 18 || ihCodTipDocum == 23 ) */
	if( ihCodConcepto != 2 && ihCodConcepto != 6  ) /* MGG_31-01-02 por mandato de JLR */
	{
		/* Valida si tiene Castigos asociados */
		/* EXEC SQL
		SELECT	NVL(COUNT(*),0)
		INTO	:ihFlgCastigo
		FROM	CO_CARTERA
		WHERE	COD_CLIENTE = :lhCodCliente
		AND		NUM_FOLIO = :lhNumFolio
		AND		COD_CONCEPTO = 6; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 27;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(count(*) ,0) into :b0  from CO_CARTERA where ((C\
OD_CLIENTE=:b1 and NUM_FOLIO=:b2) and COD_CONCEPTO=6)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )276;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihFlgCastigo;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
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

 /* castigo */
		
		if( ihFlgCastigo )
		{
			/* EXEC SQL
			SELECT	IMPORTE_HABER
			INTO	:dhImpHaberAnt
			FROM	CO_CARTERA
			WHERE	COD_CLIENTE    = :lhCodCliente
			AND		NUM_SECUENCI   = :lhNumSecuenci
			AND		COD_TIPDOCUM   = :ihCodTipDocum
			AND		COD_VENDEDOR_AGENTE = :lhCodAgente
			AND		LETRA          = :szhLetra
			AND		COD_CENTREMI   = :ihCodCentrEmi
			AND		COD_CONCEPTO   = :ihCodConcepto
			AND		COLUMNA        = :ihColumna; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 27;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select IMPORTE_HABER into :b0  from CO_CARTERA where (((((\
((COD_CLIENTE=:b1 and NUM_SECUENCI=:b2) and COD_TIPDOCUM=:b3) and COD_VENDEDOR\
_AGENTE=:b4) and LETRA=:b5) and COD_CENTREMI=:b6) and COD_CONCEPTO=:b7) and CO\
LUMNA=:b8)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )303;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhImpHaberAnt;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCodAgente;
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
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentrEmi;
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
   sqlstm.sqphsv = sqlstm.sqhstv;
   sqlstm.sqphsl = sqlstm.sqhstl;
   sqlstm.sqphss = sqlstm.sqhsts;
   sqlstm.sqpind = sqlstm.sqindv;
   sqlstm.sqpins = sqlstm.sqinds;
   sqlstm.sqparm = sqlstm.sqharm;
   sqlstm.sqparc = sqlstm.sqharc;
   sqlstm.sqpadto = sqlstm.sqadto;
   sqlstm.sqptdso = sqlstm.sqtdso;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		
			if( sqlca.sqlcode != 0 )
			{
				fprintf(stderr,"\nError en SELECT a la CO_CARTERA %d\n",sqlca.sqlcode);
				fflush(stderr);
				return FALSE;
			}
			
			dhMtoPago = dhImporteHaber - dhImpHaberAnt;
			if(dhMtoPago > 0)
			{
				if(!bfnDBUpdCastigo(lhCodCliente,lhNumFolio,dhMtoPago))
				{
					fprintf(stderr,"\nERROR en llamada a procedimiento bfnDBUpdCastigo\n");
					fflush(stderr);
					return FALSE;
				}
			}
		}
	}
	
	dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	
	/* Modifica de cartera el importe */
	/* EXEC SQL
	UPDATE	CO_CARTERA
	SET		IMPORTE_HABER	= :dhImporteHaber,
			IMPORTE_DEBE	= :dhImporteDebe,
			FEC_PAGO		= SYSDATE
	WHERE	COD_CLIENTE = :lhCodCliente
	AND		NUM_SECUENCI   	= :lhNumSecuenci
	AND		COD_TIPDOCUM   	= :ihCodTipDocum
	AND		COD_VENDEDOR_AGENTE = :lhCodAgente
	AND		LETRA          	= :szhLetra
	AND		COD_CENTREMI   	= :ihCodCentrEmi
	AND		COD_CONCEPTO   	= :ihCodConcepto
	AND		COLUMNA        	= :ihColumna; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_CARTERA  set IMPORTE_HABER=:b0,IMPORTE_DEBE=:b1,FE\
C_PAGO=SYSDATE where (((((((COD_CLIENTE=:b2 and NUM_SECUENCI=:b3) and COD_TIPD\
OCUM=:b4) and COD_VENDEDOR_AGENTE=:b5) and LETRA=:b6) and COD_CENTREMI=:b7) an\
d COD_CONCEPTO=:b8) and COLUMNA=:b9)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )354;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteHaber;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
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



	if( sqlca.sqlcode != 0 )
	{
		fprintf(stderr,"* Error en update co_cartera %d\n",sqlca.sqlcode);
		fflush(stderr);
		return FALSE;
	}
	
	return TRUE;
} /* Fin bfnDBUpdCartera() */
/*****************************************************************************/
BOOL bfnDBLlevarACanCtos(DATCON *stCon,long lCodCliente,char *szFecHis)
/**
Descripcion: Mueve el concepto de argumento y todos sus relacionados de
             cartera a cancelados.
Salida     : En caso de error devuelve FALSE.
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long   lhCodCliente    ;
		int    ihCodTipDocum   ;
		long   lhCodAgente     ;
		char   *szhLetra       ; /* EXEC SQL VAR szhLetra     IS STRING(2); */ 

		int    ihCodCentrEmi   ;
		long   lhNumSecuenci   ;
		int    ihCodConcepto   ;
		int    ihColumna       ;
		char   *szhFecHistorico; /* EXEC SQL VAR szhFecHistorico IS STRING(9); */ 

		int    ihCodProducto   ;
		long   lhNumAbonado    ;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	fprintf(stdout,"\bfnDBLlevarACanCtos() \n");
	
	/* Prepara datos para "move" */
	lhCodCliente  = lCodCliente ;
	ihCodTipDocum = stCon->iCodTipDocum;
	lhCodAgente   = stCon->lCodAgente ;
	szhLetra      = stCon->szLetra     ;
	ihCodCentrEmi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	ihCodConcepto = stCon->iCodConcepto;
	ihColumna     = stCon->iColumna;
	ihCodProducto = stCon->iCodProducto;
	lhNumAbonado  = stCon->lNumAbonado;
	
	szhFecHistorico = szFecHis;
	fprintf(stdout,"Cliente %ld\n",lhCodCliente);
	fprintf(stderr, "\nFecha HISTORI: %s\n", szhFecHistorico);
	fprintf(stdout,"tipdocum %d\n",ihCodTipDocum);
	fprintf(stdout,"agente %ld\n",lhCodAgente);
	fprintf(stdout,"letra %s\n",szhLetra);
	fprintf(stdout,"centremi %d\n",ihCodCentrEmi);
	fprintf(stdout,"secuen %d\n",lhNumSecuenci);
	fprintf(stdout,"concepto %d\n",ihCodConcepto); 
	fprintf(stdout,"columna %d\n",ihColumna); 
	
	/* EXEC SQL 
	INSERT INTO CO_CANCELADOS (	COD_CLIENTE    ,
								NUM_SECUENCI   ,
								COD_TIPDOCUM   ,
								COD_VENDEDOR_AGENTE     ,
								LETRA          ,
								COD_CENTREMI   ,
								COD_CONCEPTO   ,
								COLUMNA        ,
								COD_PRODUCTO   ,
								IMPORTE_DEBE   ,
								IMPORTE_HABER  ,
								IND_CONTADO    ,
								IND_FACTURADO  ,
								FEC_EFECTIVIDAD,
								FEC_CANCELACION,
								IND_PORTADOR   ,
								FEC_VENCIMIE   ,
								FEC_CADUCIDA   ,
								FEC_ANTIGUEDAD ,
								FEC_PAGO       ,
								NUM_ABONADO    ,
								NUM_FOLIO      ,
								NUM_CUOTA      ,
								SEC_CUOTA      ,
								NUM_TRANSACCION,
								NUM_VENTA      ,
								NUM_FOLIOCTC   ,
						                PREF_PLAZA         , 
                				                COD_OPERADORA_SCL  , 
                				                COD_PLAZA          ) 
	SELECT	COD_CLIENTE    ,
			NUM_SECUENCI   ,
			COD_TIPDOCUM   ,
			COD_VENDEDOR_AGENTE     ,
			LETRA          ,
			COD_CENTREMI   ,
			COD_CONCEPTO   ,
			COLUMNA        ,
			COD_PRODUCTO   ,
			IMPORTE_DEBE   ,
			IMPORTE_HABER  ,
			IND_CONTADO    ,
			IND_FACTURADO  ,
			FEC_EFECTIVIDAD,
			TO_DATE(:szhFecHistorico,'yyyymmdd'),
			0,
			FEC_VENCIMIE   ,
			FEC_CADUCIDA   ,
			FEC_ANTIGUEDAD ,
			SYSDATE        ,
			NUM_ABONADO    ,
			NUM_FOLIO      ,
			NUM_CUOTA      ,
			SEC_CUOTA      ,
			NUM_TRANSACCION,
			NUM_VENTA      ,
			NUM_FOLIOCTC   ,
                        PREF_PLAZA         ,
			COD_OPERADORA_SCL  ,
			COD_PLAZA           
	FROM	CO_CARTERA
	WHERE	COD_CLIENTE        = :lhCodCliente
	AND		NUM_SECUENCI   = :lhNumSecuenci
	AND		COD_TIPDOCUM   = :ihCodTipDocum
	AND		COD_VENDEDOR_AGENTE     = :lhCodAgente
	AND		LETRA          = :szhLetra
	AND		COD_CENTREMI   = :ihCodCentrEmi
	AND		COD_PRODUCTO   = :ihCodProducto
	AND		NUM_ABONADO    = :lhNumAbonado
	AND		COD_CONCEPTO   = :ihCodConcepto
	AND		COLUMNA        = :ihColumna; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlbuft((void **)0, 
   "insert into CO_CANCELADOS (COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCUM,COD_VEN\
DEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMPORTE_DE\
BE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_CANCELACION,I\
ND_PORTADOR,FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_ABONADO,NU\
M_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_PLAZ\
A,COD_OPERADORA_SCL,COD_PLAZA)select COD_CLIENTE ,NUM_SECUENCI ,COD_TIPDOCUM\
 ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COD_CONCEPTO ,COLUMNA ,COD_PRODU\
CTO ,IMPORTE_DEBE ,IMPORTE_HABER ,IND_CONTADO ,IND_FACTURADO ,FEC_EFECTIVIDA\
D ,TO_DATE(:b0,'yyyymmdd') ,0 ,FEC_VENCIMIE ,FEC_CADUCIDA ,FEC_ANTIGUEDAD ,S\
YSDATE ,NUM_ABONADO ,NUM_FOLIO ,NUM_CUOTA ,SEC_CUOTA ,NUM_TRANSACCION ,NUM_V\
ENTA ,NUM_FOLIOCTC ,PREF_PLAZA ,COD_OPERADORA_SCL ,COD_PLAZA  from CO_CARTER\
A where (((((((((COD_CLIENTE=:b1 and NUM_SECUENCI=:b2) and COD_TIPDOCUM=:b3)\
 and COD_VENDEDOR_AGENTE=:b4) and LETRA=:b5) and COD_CENTREMI=:b6) and COD_P\
RODUCTO=:b7) and NUM_ABONADO=:b8) and CO");
 sqlstm.stmt = "D_CONCEPTO=:b9) and COLUMNA=:b10)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )409;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecHistorico;
 sqlstm.sqhstl[0] = (unsigned long )9;
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
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodAgente;
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodProducto;
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


	
	if( sqlca.sqlcode != 0 )
	{
		fprintf(stderr,"* Error en Insert CANCELADOS %s\n", sqlca.sqlerrm.sqlerrmc);
		fflush(stderr);
		return FALSE;
	}
	
	/* Borramos de cartera */
	/* EXEC SQL
	DELETE 	CO_CARTERA
	WHERE  	COD_CLIENTE    = :lhCodCliente
	AND		NUM_SECUENCI   = :lhNumSecuenci
	AND		COD_TIPDOCUM   = :ihCodTipDocum
	AND		COD_VENDEDOR_AGENTE	= :lhCodAgente
	AND		LETRA          = :szhLetra
	AND		COD_CENTREMI   = :ihCodCentrEmi
	AND		COD_CONCEPTO   = :ihCodConcepto
	AND		COLUMNA        = :ihColumna
	AND		COD_PRODUCTO   = :ihCodProducto
	AND		NUM_ABONADO    = :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_CARTERA  where (((((((((COD_CLIENTE=:b0 and \
NUM_SECUENCI=:b1) and COD_TIPDOCUM=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA\
=:b4) and COD_CENTREMI=:b5) and COD_CONCEPTO=:b6) and COLUMNA=:b7) and COD_PRO\
DUCTO=:b8) and NUM_ABONADO=:b9)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )468;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
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
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (sqlca.sqlcode != 0)
	{
	fprintf(stderr,"* Error en Delete %s\n",sqlca.sqlerrm.sqlerrmc);
	fflush(stderr);
	return FALSE;
	}
	
	return TRUE;
} /* Fin DBLlevarACanCtos(.)  */

/*****************************************************************************/
BOOL bfnDBObtConCre(int *iCodConcepto)
/**
Descripcion: Obtener el codigo de concepto credito
Salida     : True, si todo va ok
             False, si se genera algun error
**/
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 


      int    ihCodConcepto   ;

   /* EXEC SQL END DECLARE SECTION; */ 


  	/* Obtener el concepto abono */
  	/* EXEC SQL
		SELECT A.COD_CONCEPTO
		INTO :ihCodConcepto
		FROM CO_CONCEPTOS A, CO_TIPCONCEP B
		WHERE A.COD_TIPCONCE = B.COD_TIPCONCE
		AND   B.IND_ABONO = 1; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 27;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.COD_CONCEPTO into :b0  from CO_CONCEPTOS A ,CO_TI\
PCONCEP B where (A.COD_TIPCONCE=B.COD_TIPCONCE and B.IND_ABONO=1)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )523;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
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



  	if (sqlca.sqlcode != 0)
  	{
    	 fprintf(stderr,"* Error al obtener el concepto abono %d\n",sqlca.sqlcode);
         fflush(stderr);																				
     	 return FALSE;
  	}

	*iCodConcepto = ihCodConcepto;

   return TRUE;

} /* Fin bfnDBObtConCre() */
/*****************************************************************************/
int iDBTomarSecuencia(int iCodTipDocum,int iCodCentrEmi,char *szLetra, long* lNumSec)
{
/** Funcion que recupera el numero de secuencia de la tabla que le corresponda
en funcion del tipo de documento   **/

  /* EXEC SQL BEGIN DECLARE SECTION; */ 


   long lhNumSec    ;

  /* EXEC SQL END DECLARE SECTION; */ 


  fprintf(stderr,"DBTomarSecuencia() \n");
  fprintf(stdout,"Documento : %d \n",iCodTipDocum);

	switch(iCodTipDocum)
	{
		case iDOCPAGO:
  			/* EXEC SQL 
				SELECT CO_SEQ_PAGO.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_PAGO.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )542;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCNCI:
  			/* EXEC SQL 
				SELECT CO_SEQ_NCI.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_NCI.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )561;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCNDI:
  			/* EXEC SQL 
				SELECT CO_SEQ_NDI.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_NDI.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )580;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCCARTAPAGO:
  			/* EXEC SQL 
				SELECT CO_SEQ_CARTAPAGO.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_CARTAPAGO.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )599;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCPAGOCUOTA:
  			/* EXEC SQL 
				SELECT CO_SEQ_PAGOCUOTA.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_PAGOCUOTA.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )618;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCPAGOCARRIER:
  			/* EXEC SQL 
				SELECT CO_SEQ_PAGOCARRIER.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_PAGOCARRIER.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )637;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCRESPALDO:
  			/* EXEC SQL 
				SELECT CO_SEQ_RESPALDO.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_RESPALDO.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )656;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCPAGARE:
  			/* EXEC SQL 
				SELECT CO_SEQ_PAGARE.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_PAGARE.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )675;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCRECEXT:
  			/* EXEC SQL 
				SELECT CO_SEQ_RECEXT.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_RECEXT.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )694;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
		case iDOCCCONTA:
  			/* EXEC SQL 
				SELECT CO_SEQ_CASTCONTABLE.NEXTVAL INTO :lhNumSec
             FROM DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 27;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select CO_SEQ_CASTCONTABLE.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )713;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSec;
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


			break;
	}

  	if(sqlca.sqlcode != 0) 
    		return sqlca.sqlcode;

  	fprintf(stdout,"Secuencia : %d \n",lhNumSec);
  *lNumSec = lhNumSec;

  return 0;

} /* Fin ifnDBTomarSecuencia(...) */

/****************************************************************************
	Crea Directorio(si no existe) con la Fecha del dia en el PATH 
	asociado al campo de la CO_DATGEN que recibe por parametro
****************************************************************************/
BOOL bfnDBCreaDirPath(char *szColumnName, char *szRetPath)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 


char szhColumnName[20]   ; /* EXEC SQL VAR szhColumnName IS STRING(20); */ 

char szhDatGenPath[255]  ; /* EXEC SQL VAR szhDatGenPath IS STRING(255); */ 

char szhQuery     [50]   ; /* EXEC SQL VAR szhQuery      IS STRING(50); */ 

char szhFecha     [11]   ; /* EXEC SQL VAR szhFecha      IS STRING(11); */ 

char szhMkDir     [300]  ; /* EXEC SQL VAR szhMkDir      IS STRING(300); */ 


/* EXEC SQL END DECLARE SECTION; */ 


	if (strncmp(szColumnName,"PATH",4))
   	{
		fprintf(stderr,"ERROR en bfnDBCreaDirPath : el parametro recibido no comienza con PATH.\n");
		fflush(stderr);
		return FALSE;
	}

	strcpy(szhQuery,"SELECT ");
	strcat(szhQuery,szColumnName);
	strcat(szhQuery," FROM CO_DATGEN ");

	/* EXEC SQL PREPARE sql_query_alias FROM :szhQuery; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )732;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
 sqlstm.sqhstl[0] = (unsigned long )50;
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


	if ( sqlca.sqlcode != SQLOK )
   	{
		fprintf(stderr,"ERROR en bfnDBCreaDirPath : en SQL-PREPARE del select.\n");
		fflush(stderr);
		return FALSE;
	}

	/* EXEC SQL DECLARE cursor_alias CURSOR FOR sql_query_alias; */ 

	if ( sqlca.sqlcode != SQLOK )
   	{
		fprintf(stderr,"ERROR en bfnDBCreaDirPath : en declaracion del Cursor.\n");
		fflush(stderr);
		return FALSE;
	}

	/* EXEC SQL OPEN cursor_alias; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
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


	if ( sqlca.sqlcode != SQLOK )
   	{
		fprintf(stderr,"ERROR en bfnDBCreaDirPath : en Open del Cursor.\n");
		fflush(stderr);
		return FALSE;
	}

	for (;;)
	{
		/* EXEC SQL FETCH cursor_alias INTO :szhDatGenPath; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 27;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )766;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhDatGenPath;
  sqlstm.sqhstl[0] = (unsigned long )255;
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


		if ( sqlca.sqlcode == NOT_FOUND )
			break;
	}
	/* EXEC SQL CLOSE cursor_alias; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )785;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	/* EXEC SQL
		SELECT TO_CHAR(SYSDATE,'dd-mm-yyyy')
		INTO :szhFecha
		FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,'dd-mm-yyyy') into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )800;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
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


	if (sqlca.sqlcode != SQLOK)
	{
		fprintf(stderr,"ERROR en bfnDBCreaDirPath : Al seleccionar Fecha.\n");
		fflush(stderr);
		return FALSE;
	}
	strcat(szhDatGenPath,"/");
	strcat(szhDatGenPath,szhFecha);
	strcpy(szRetPath,szhDatGenPath);

	strcpy(szhMkDir,"mkdir -p ");
	strcat(szhMkDir,szhDatGenPath);

	if (system(szhMkDir)) 
	{
		fprintf(stderr,"ERROR en bfnDBCreaDirPath : Al Crear directorio %s\n",szRetPath);
		fflush(stderr);
		return FALSE;
	}

	return TRUE;

} /* Fin bfnDBCreaDirPath() */

/*****************************************************************************/
BOOL bfnDBUpdCastigo(long lCodCliente,long lNumFolio,double dMtoPago)
/**
Descripcion: Modifica el importe Debe del Castigo
Salida     : True, si todo va ok
             False, si se genera algun error
**/
{
	DATCON	stCon;
  /* EXEC SQL BEGIN DECLARE SECTION; */ 


      char   szhLetra[2]     ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int    ihCodCentrEmi   ;
      long   lhNumSecuenci   ;
      long   lhNumAbonado    ;
      long   lhCodVendedorAgente   ;
      int    ihColumna       ;
      int    ihCodProducto   ;
      int    ihCodCentremi   ;
      int    ihFlgCancelados ;
      double dhMtoSaldo      ;
      double dhMtoDebe       ;
      char   szhFecHist[9]   ; /* EXEC SQL VAR szhFecHist IS STRING(9); */ 

      int    ihSecCuota      ;
   /* EXEC SQL END DECLARE SECTION; */ 


	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )
	{
		fprintf( stderr, "Error al realizar carga de bGetParamDecimales()." );
		return FALSE;
	}

   /* EXEC SQL DECLARE CASTIGOS_ASOC CURSOR FOR
		SELECT	NUM_SECUENCI,
			COD_VENDEDOR_AGENTE,
			LETRA,
			COD_CENTREMI,
			COLUMNA,
			IMPORTE_HABER - IMPORTE_DEBE,
			TO_CHAR(SYSDATE,'YYYYMMDD'),
			NUM_ABONADO,
			COD_PRODUCTO,
			NVL(SEC_CUOTA,-1)
		FROM	CO_CARTERA
		WHERE	COD_CLIENTE = :lCodCliente
		AND	NUM_FOLIO   = :lNumFolio
		AND	COD_TIPDOCUM = 39; */ 


	/* EXEC SQL OPEN CASTIGOS_ASOC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 27;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0024;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )819;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lNumFolio;
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


	if (sqlca.sqlcode != SQLOK)
	{
		fprintf(stderr,"\nERROR al Abrir Cursor CASTIGOS_ASOC.\n");
		fflush(stderr);
		return FALSE;
	}

	while(1)
	{
		/* EXEC SQL FETCH CASTIGOS_ASOC INTO
			:lhNumSecuenci,
			:lhCodVendedorAgente,
			:szhLetra,
			:ihCodCentremi,
			:ihColumna,
			:dhMtoSaldo,
			:szhFecHist,
			:lhNumAbonado,
			:ihCodProducto,
			:ihSecCuota; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 27;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )842;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedorAgente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentremi;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&dhMtoSaldo;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhFecHist;
  sqlstm.sqhstl[6] = (unsigned long )9;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
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
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
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


		if (sqlca.sqlcode == NOT_FOUND)
			break;

		if (dMtoPago >= dhMtoSaldo)
		{
			dhMtoDebe = dhMtoSaldo;
			dMtoPago = dMtoPago - dhMtoSaldo;
			ihFlgCancelados = 1;
		}
		else
		{
			dhMtoDebe = dMtoPago;
			dMtoPago = 0;
			ihFlgCancelados = 0;
		}

		/* manejo de decimales segun la operadora local */
		dhMtoDebe = fnCnvDouble( dhMtoDebe, 0 );

        if ( ihSecCuota == -1 ) /* Valor Null */
        {
			/* EXEC SQL
			UPDATE	CO_CARTERA
			SET		IMPORTE_DEBE = IMPORTE_DEBE + :dhMtoDebe,
					FEC_PAGO = TO_DATE(:szhFecHist,'YYYYMMDD')
			WHERE	COD_CLIENTE = :lCodCliente
			AND		NUM_SECUENCI = :lhNumSecuenci
			AND		COD_TIPDOCUM = 39
			AND		COD_VENDEDOR_AGENTE = :lhCodVendedorAgente
			AND		LETRA = :szhLetra
			AND		COD_CENTREMI = :ihCodCentremi
			AND		COD_CONCEPTO = 6
			AND		COLUMNA = :ihColumna
			AND		SEC_CUOTA IS NULL ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 27;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_CARTERA  set IMPORTE_DEBE=(IMPORTE_DEBE+:b0),FEC\
_PAGO=TO_DATE(:b1,'YYYYMMDD') where ((((((((COD_CLIENTE=:b2 and NUM_SECUENCI=:\
b3) and COD_TIPDOCUM=39) and COD_VENDEDOR_AGENTE=:b4) and LETRA=:b5) and COD_C\
ENTREMI=:b6) and COD_CONCEPTO=6) and COLUMNA=:b7) and SEC_CUOTA is null )";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )897;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhMtoDebe;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecHist;
   sqlstm.sqhstl[1] = (unsigned long )9;
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
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
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


	    }
	    else /* Valor No Null */
	    {
			/* EXEC SQL
			UPDATE	CO_CARTERA
			SET		IMPORTE_DEBE = IMPORTE_DEBE + :dhMtoDebe,
					FEC_PAGO = TO_DATE(:szhFecHist,'YYYYMMDD')
			WHERE	COD_CLIENTE = :lCodCliente
			AND		NUM_SECUENCI = :lhNumSecuenci
			AND		COD_TIPDOCUM = 39
			AND		COD_VENDEDOR_AGENTE = :lhCodVendedorAgente
			AND		LETRA = :szhLetra
			AND		COD_CENTREMI = :ihCodCentremi
			AND		COD_CONCEPTO = 6
			AND		COLUMNA = :ihColumna
			AND		SEC_CUOTA = :ihSecCuota ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 27;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_CARTERA  set IMPORTE_DEBE=(IMPORTE_DEBE+:b0),FEC\
_PAGO=TO_DATE(:b1,'YYYYMMDD') where ((((((((COD_CLIENTE=:b2 and NUM_SECUENCI=:\
b3) and COD_TIPDOCUM=39) and COD_VENDEDOR_AGENTE=:b4) and LETRA=:b5) and COD_C\
ENTREMI=:b6) and COD_CONCEPTO=6) and COLUMNA=:b7) and SEC_CUOTA=:b8)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )944;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhMtoDebe;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhFecHist;
   sqlstm.sqhstl[1] = (unsigned long )9;
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
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&ihSecCuota;
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


	    }
	    
		if (sqlca.sqlcode != SQLOK)
		{
			fprintf(stderr,"\nERROR al ACTUALIZAR la CO_CARTERA %s\n", sqlca.sqlerrm.sqlerrmc);
			fflush(stderr);
			return FALSE;
		}

		if (ihFlgCancelados) /* si cancelo el registro, lo pasa a Cancelados */
		{
			stCon.lNumSecuenci = lhNumSecuenci;
			stCon.iCodTipDocum = 39;
			stCon.lCodAgente   = lhCodVendedorAgente;
			strcpy(stCon.szLetra,szhLetra);
			stCon.iCodCentremi = ihCodCentremi;
			stCon.iCodConcepto = 6;
			stCon.iColumna     = ihColumna;
			stCon.iCodProducto = ihCodProducto;
			stCon.lNumAbonado  = lhNumAbonado ;

			if (!bfnDBLlevarACanCtos(&stCon,lCodCliente,szhFecHist))
			{
				fprintf(stderr,"\nERROR en llamada a procedimiento bfnDBLlevarACanCtos\n");
				fflush(stderr);
				return FALSE;
			}
		}

		if (dMtoPago < 1) /* si no queda mas dinero */
			break;
	} /* end while */

	return TRUE;
}
/*****************************************************************************/
double fnRedondea(double dMonto,int iCntDecimales)
{
	char szTemp[20]="";
	sprintf(szTemp,"%.*f",iCntDecimales, dMonto + 0.0000001);
	return (double)atof(szTemp);
}

/* ============================================================================= */
/* szGetTime : Recupera la fecha del sistema en el formato deseado (pudiendo ser */
/*             fecha y hora) Permite cualquier valor numerico, con las sgtes     */
/*             restricciones                                                     */
/*              fmto = 0 : fecha de hoy en fmto por defecto (dd/mm/yyyy)         */
/*              fmto > 0 : fecha de hoy en fmto definido en el switch (y/u hora) */
/*              fmto < 0 : fecha pasada en fmto 2(yyyymmdd), vuelve 'fmto' dias  */
/* ============================================================================= */
char *szGetTime(int fmto)
{
	char modulo[]="szGetTime";

	static time_t timer;
	static size_t nbytes;
	static char szTime[26]="";
	int iDia = 86400;

	memset(szTime,'\0',26);
	
	if (fmto >= 0)
	{	
		timer = time((time_t *)0);
	}
	else
	{	
		timer = time((time_t *)0)+fmto*iDia; 
		fmto = 2;
	}

	switch (fmto)
	{
		case 1 :
				nbytes = strftime(szTime, 26, "[%d-%b-%Y] [%H:%M:%S]", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> [04-Feb-2000] [11:22:38] (escritura de log)*/
		case 2 :
				nbytes = strftime(szTime, 26, "%Y%m%d", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000->  20000204  (nombre de archivo) */
		case 3 :
				nbytes = strftime(szTime, 26, "[%H:%M:%S]", (struct tm *)localtime(&timer));	
				break; /* Ej.: 11 horas, 22 minutos, 38 segundos ->  [11:22:38] (escritura de log) */
		case 4 :
				nbytes = strftime(szTime, 26, "%H%M%S", (struct tm *)localtime(&timer));	
				break; /* Ej.: 11 horas, 22 minutos, 38 segundos ->  112238 (nombre de archivo) */
		case 5 :
				nbytes = strftime(szTime, 26, "%Y%m%d_%H%M%S", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 20000204_112238 (nombre de archivo: 1_3)*/
		case 6 :
				nbytes = strftime(szTime, 26, "%j", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 035 (fecha juliana 001-366 )*/
		case 7 :
				nbytes = strftime(szTime, 26, "%Y%m%d%H%M%S", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 20000204112238 (tipo Oracle)*/
		default :
				nbytes = strftime(szTime, 26, "%d/%m/%Y", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 04/02/2000 (formato comun)*/
	}
	
	return (char *) szTime;
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

