
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned long magic;
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
           char  filnam[26];
};
static struct sqlcxp sqlfpn =
{
    25,
    "./pc/FaPasoHistCarrier.pc"
};


static unsigned long sqlctx = 1765068315;


static struct sqlexd {
   unsigned int   sqlvsn;
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
            void  **sqphsv;
   unsigned int   *sqphsl;
            int   *sqphss;
            void  **sqpind;
            int   *sqpins;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
            void  *sqhstv[5];
   unsigned int   sqhstl[5];
            int   sqhsts[5];
            void  *sqindv[5];
            int   sqinds[5];
   unsigned int   sqharm[5];
   unsigned int   *sqharc[5];
   unsigned short  sqadto[5];
   unsigned short  sqtdso[5];
} sqlstm = {10,5};

/* SQLLIB Prototypes */
extern sqlcxt (/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned long *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

 static char *sq0001 = 
"select distinct num_abonado ,cod_cliente ,cod_periodo ,cod_operador  from fa\
_acumfortas where (num_proceso=:b0 and cod_operador=:b1)           ";

 static char *sq0008 = 
"select distinct ind_orden  from fa_detfortas_th where (num_proceso=:b0 and c\
od_operador=:b1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{10,4130,0,0,0,
5,0,0,1,143,0,9,77,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
28,0,0,1,0,0,13,91,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
59,0,0,1,0,0,15,109,0,0,0,0,0,1,0,
74,0,0,2,68,0,4,211,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
97,0,0,3,115,0,2,261,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
128,0,0,4,138,0,2,296,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
163,0,0,5,118,0,2,336,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
194,0,0,6,115,0,2,371,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
225,0,0,7,138,0,2,403,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
260,0,0,8,103,0,9,458,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
283,0,0,8,0,0,13,469,0,0,1,0,0,1,0,2,3,0,0,
302,0,0,9,63,0,4,475,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
325,0,0,10,46,0,2,493,0,0,1,1,0,1,0,1,3,0,0,
344,0,0,8,0,0,15,513,0,0,0,0,0,1,0,
359,0,0,11,742,0,3,568,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
394,0,0,12,0,0,29,778,0,0,0,0,0,1,0,
409,0,0,13,0,0,31,789,0,0,0,0,0,1,0,
};


#line 1 "./pc/FaPasoHistCarrier.pc"
/* ********************************************************************** */
/* *  Fichero : FaPasoHistCarrier.pc                                   	* */
/* *  Proceso encargado de llevar a historico el contenido de la	* */
/* *  FA_DETFORTAS y eliminar registros relacionados en las tablas	* */
/* *  FA_ACUMFORTAS, FA_CABFORTAS, FA_DETFORLIQ, FA_ACUMFORLIQ		* */
/* *  Autor : Patricio Gonzalez Gomez	                                * */
/* *  Modif : 								* */
/* *  Parametros : 							* */
/* *         -u Usuario/Password                                        * */
/* *         -c Ciclo de Facturacion	                                * */
/* *         -d Cod_Carrier						* */
/* *         -l Nivel de Log						* */
/* ********************************************************************** */

#define _FA_PASOHISTCARRIER_PC_

#include <deftypes.h>
#include <stdlib.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include "FaPasoHistCarrier.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

char  modulo[30];

/* EXEC SQL INCLUDE sqlca;
 */ 
#line 1 "/app/oracle/OraHome1/precomp/public/sqlca.h"
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

#line 30 "./pc/FaPasoHistCarrier.pc"
/*  */ 
#line 1 "/app/oracle/OraHome1/precomp/public/sqlca.h"
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

#line 30 "./pc/FaPasoHistCarrier.pc"

/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 31 "./pc/FaPasoHistCarrier.pc"

	long		lhNumProceso ;
	long		lhCodCiclFact;
	long		lhCodOperador;
/* EXEC SQL END DECLARE SECTION; */ 
#line 35 "./pc/FaPasoHistCarrier.pc"




/* DESDE AQUI PGG FUNCIONES NUEVAS */
void trim (const char *c, char *result)
{
   char *l;
   char *r;
   for(l=(char *)c;  *l==' '; l++);
   for(r=(char *)c+strlen(c)-1;  *r==' '; r--);

   strncpy(result, l, (r>=l)?r-l+1:1);
   result[r-l+1]=0;
}



/* --------Estructura ACUMFORTAS Desde Aqui */

static int ifnOpenFaAcumFortas (void)
{

    	strcpy(modulo,"ifnOpenFaAcumFortas");

	
	vDTrazasLog(modulo, "\n\t\t* lhNumProceso	[%ld]\n",   LOG05, lhNumProceso);
	vDTrazasLog(modulo, "\n\t\t* lhCodOperador	[%ld]\n",   LOG05, lhCodOperador);
		
        /* EXEC SQL DECLARE Cursor_FaAcumFortas CURSOR FOR
		SELECT 	DISTINCT 
			num_abonado, cod_cliente , 
			cod_periodo, cod_operador
		FROM fa_acumfortas
		WHERE num_proceso  = :lhNumProceso
		  AND cod_operador = :lhCodOperador; */ 
#line 70 "./pc/FaPasoHistCarrier.pc"

    	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* DECLARE=> FA_ACUMFORTAS\n",   LOG05);
                return(SQLCODE);
    	}

        /* EXEC SQL OPEN Cursor_FaAcumFortas; */ 
#line 77 "./pc/FaPasoHistCarrier.pc"

{
#line 77 "./pc/FaPasoHistCarrier.pc"
        struct sqlexd sqlstm;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqlvsn = 10;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.arrsiz = 2;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqladtp = &sqladt;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqltdsp = &sqltds;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.stmt = sq0001;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.iters = (unsigned int  )1;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.offset = (unsigned int  )5;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.selerr = (unsigned short)1;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.cud = sqlcud0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqlety = (unsigned short)256;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.occurs = (unsigned int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstv[0] = (         void  *)&lhNumProceso;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhsts[0] = (         int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqindv[0] = (         void  *)0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqinds[0] = (         int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqharm[0] = (unsigned int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqadto[0] = (unsigned short )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqtdso[0] = (unsigned short )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstv[1] = (         void  *)&lhCodOperador;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhsts[1] = (         int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqindv[1] = (         void  *)0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqinds[1] = (         int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqharm[1] = (unsigned int  )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqadto[1] = (unsigned short )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqtdso[1] = (unsigned short )0;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqphsv = sqlstm.sqhstv;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqphsl = sqlstm.sqhstl;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqphss = sqlstm.sqhsts;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqpind = sqlstm.sqindv;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqpins = sqlstm.sqinds;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqparm = sqlstm.sqharm;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqparc = sqlstm.sqharc;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqpadto = sqlstm.sqadto;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqptdso = sqlstm.sqtdso;
#line 77 "./pc/FaPasoHistCarrier.pc"
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 77 "./pc/FaPasoHistCarrier.pc"
}

#line 77 "./pc/FaPasoHistCarrier.pc"


    	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* OPEN=> FA_ACUMFORTAS\n",   LOG05);
                return(SQLCODE);
    	}

    	return (SQLCODE);
}/***************************** Final ifnOpenFaAcumFortas  **********************/

static BOOL ifnFetchFaAcumFortas (REG_FA_ACUMFORTAS_HOST *pstHost,long *plNumFilas)
{

         /* EXEC SQL FETCH Cursor_FaAcumFortas
             INTO	 :pstHost->lNumAbonado
			,:pstHost->lCodCliente	
			,:pstHost->lCodPeriodo	
			,:pstHost->lCodOperador; */ 
#line 95 "./pc/FaPasoHistCarrier.pc"

{
#line 91 "./pc/FaPasoHistCarrier.pc"
         struct sqlexd sqlstm;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqlvsn = 10;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.arrsiz = 4;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqladtp = &sqladt;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqltdsp = &sqltds;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.iters = (unsigned int  )2000;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.offset = (unsigned int  )28;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.cud = sqlcud0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqlety = (unsigned short)256;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.occurs = (unsigned int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstv[0] = (         void  *)(pstHost->lNumAbonado);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhsts[0] = (         int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqindv[0] = (         void  *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqinds[0] = (         int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharm[0] = (unsigned int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharc[0] = (unsigned int   *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqadto[0] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqtdso[0] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstv[1] = (         void  *)(pstHost->lCodCliente);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhsts[1] = (         int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqindv[1] = (         void  *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqinds[1] = (         int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharm[1] = (unsigned int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharc[1] = (unsigned int   *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqadto[1] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqtdso[1] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstv[2] = (         void  *)(pstHost->lCodPeriodo);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhsts[2] = (         int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqindv[2] = (         void  *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqinds[2] = (         int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharm[2] = (unsigned int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharc[2] = (unsigned int   *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqadto[2] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqtdso[2] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstv[3] = (         void  *)(pstHost->lCodOperador);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqhsts[3] = (         int  )sizeof(long);
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqindv[3] = (         void  *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqinds[3] = (         int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharm[3] = (unsigned int  )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqharc[3] = (unsigned int   *)0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqadto[3] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqtdso[3] = (unsigned short )0;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqphsv = sqlstm.sqhstv;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqphsl = sqlstm.sqhstl;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqphss = sqlstm.sqhsts;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqpind = sqlstm.sqindv;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqpins = sqlstm.sqinds;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqparm = sqlstm.sqharm;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqparc = sqlstm.sqharc;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqpadto = sqlstm.sqadto;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlstm.sqptdso = sqlstm.sqtdso;
#line 91 "./pc/FaPasoHistCarrier.pc"
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 91 "./pc/FaPasoHistCarrier.pc"
}

#line 95 "./pc/FaPasoHistCarrier.pc"


        if (SQLCODE==SQLOK)
                *plNumFilas = TAM_HOSTS_PEQ;
        else
                if (SQLCODE==SQLNOTFOUND)
                        *plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

  	return (SQLCODE);
}/***************************** Final ifnFetchFaAcumFortas ****************/

int ifnCloseFaAcumFortas (void)
{

	/* EXEC SQL CLOSE Cursor_FaAcumFortas; */ 
#line 109 "./pc/FaPasoHistCarrier.pc"

{
#line 109 "./pc/FaPasoHistCarrier.pc"
 struct sqlexd sqlstm;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlvsn = 10;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.arrsiz = 4;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqladtp = &sqladt;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqltdsp = &sqltds;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.iters = (unsigned int  )1;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.offset = (unsigned int  )59;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.cud = sqlcud0;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 109 "./pc/FaPasoHistCarrier.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 109 "./pc/FaPasoHistCarrier.pc"
}

#line 109 "./pc/FaPasoHistCarrier.pc"


	strcpy(modulo,"ifnCloseFaAcumFortas");
	vDTrazasLog(modulo, "\n\t\t* Close=> CURSOR FA_ACUMFORTAS\n",   LOG05);

	return (SQLCODE);
}/**************************** Final ifnCloseFaAcumFortas ******************/

void vfnPrintFaAcumFortas (REG_FA_ACUMFORTAS *pstAcumFortas, int iNumAcumFortas)
{
        int i = 0;

        strcpy(modulo,"vfnPrintFaAcumFortas");

	vDTrazasLog(modulo,"\n\t\t* Despliegue de la Carga de la FA_ACUMFORTAS... [%d]", LOG05 ,iNumAcumFortas);

        for (i=0;i<iNumAcumFortas;i++)
        {
               vDTrazasLog(modulo,	"---------------------------------------\n"
					"pstAcumFortas[%d].lCodCliente	[%ld]\n"
					"pstAcumFortas[%d].lNumAbonado	[%ld]\n"
					"pstAcumFortas[%d].lCodPeriodo	[%ld]\n"
					"pstAcumFortas[%d].lCodOperador	[%ld]\n"
						,LOG05
						,i , pstAcumFortas[i].lCodCliente	
						,i , pstAcumFortas[i].lNumAbonado	
						,i , pstAcumFortas[i].lCodPeriodo	
						,i , pstAcumFortas[i].lCodOperador);

        }
}/*************************** vfnPrintFaAcumFortas *****************************/

int iCargaFaAcumFortas(REG_FA_ACUMFORTAS **pstAcumFortas, int *iNumAcumFortas)
{
        int     rc = 0;
        long    lNumFilas;
        static  REG_FA_ACUMFORTAS_HOST pstAcumFortasHost;
        REG_FA_ACUMFORTAS *pstAcumFortasTemp;
        long lCont;

        strcpy(modulo,"iCargaFaAcumFortas");
        vDTrazasLog(modulo, "\n\t\t* Carga Estructura FA_ACUMFORTAS\n",   LOG05);



        *iNumAcumFortas = 0;
        *pstAcumFortas = NULL;

        if (ifnOpenFaAcumFortas ())
        	return (FALSE);

        while (rc != SQLNOTFOUND)
        {
        rc = ifnFetchFaAcumFortas (&pstAcumFortasHost,&lNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
                        return (FALSE);

                if (!lNumFilas)
                	break;

                *pstAcumFortas =(REG_FA_ACUMFORTAS*) realloc(*pstAcumFortas,(((*iNumAcumFortas)+lNumFilas)*sizeof(REG_FA_ACUMFORTAS)));

                if (!*pstAcumFortas)
                        return (FALSE);

                pstAcumFortasTemp = &(*pstAcumFortas)[(*iNumAcumFortas)];
                memset(pstAcumFortasTemp, 0, sizeof(REG_FA_ACUMFORTAS)*lNumFilas);
                for (lCont = 0 ; lCont < lNumFilas ; lCont++)
                {
                	pstAcumFortasTemp[lCont].lCodCliente 	= pstAcumFortasHost.lCodCliente	[lCont];
                	pstAcumFortasTemp[lCont].lNumAbonado 	= pstAcumFortasHost.lNumAbonado	[lCont];
                	pstAcumFortasTemp[lCont].lCodPeriodo 	= pstAcumFortasHost.lCodPeriodo	[lCont];
                	pstAcumFortasTemp[lCont].lCodOperador	= pstAcumFortasHost.lCodOperador[lCont];
                }
                (*iNumAcumFortas) += lNumFilas;

        }/* fin while */

        vDTrazasLog(modulo,  "\n\t\t* REGISTROS DE LA FA_ACUMFORTAS CARGADOS [%d]\n",   LOG05, *iNumAcumFortas);

        rc = ifnCloseFaAcumFortas();
        if (rc != SQLOK)
                return (FALSE);

        vfnPrintFaAcumFortas (*pstAcumFortas, *iNumAcumFortas);

        return (TRUE);
}/*************************** iCargaFaAcumFortas *****************************/


/* --------Estructura ACUMFORTAS Hasta Aqui */



BOOL bfnCargaEstructuras()
{
	
	
	
	lhCodCiclFact	= stLineaComando.lCodCiclo;
        lhCodOperador   = stLineaComando.lCodCarrier;
        
        /* EXEC SQL SELECT num_proceso   
        	INTO :lhNumProceso
        	FROM FA_PROCESOS     
        	WHERE cod_ciclfact = :lhCodCiclFact; */ 
#line 214 "./pc/FaPasoHistCarrier.pc"

{
#line 211 "./pc/FaPasoHistCarrier.pc"
        struct sqlexd sqlstm;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqlvsn = 10;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.arrsiz = 4;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqladtp = &sqladt;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqltdsp = &sqltds;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.stmt = "select num_proceso into :b0  from FA_PROCESOS where c\
od_ciclfact=:b1";
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.iters = (unsigned int  )1;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.offset = (unsigned int  )74;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.selerr = (unsigned short)1;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.cud = sqlcud0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqlety = (unsigned short)256;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.occurs = (unsigned int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstv[0] = (         void  *)&lhNumProceso;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhsts[0] = (         int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqindv[0] = (         void  *)0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqinds[0] = (         int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqharm[0] = (unsigned int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqadto[0] = (unsigned short )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqtdso[0] = (unsigned short )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstv[1] = (         void  *)&lhCodCiclFact;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqhsts[1] = (         int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqindv[1] = (         void  *)0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqinds[1] = (         int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqharm[1] = (unsigned int  )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqadto[1] = (unsigned short )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqtdso[1] = (unsigned short )0;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqphsv = sqlstm.sqhstv;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqphsl = sqlstm.sqhstl;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqphss = sqlstm.sqhsts;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqpind = sqlstm.sqindv;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqpins = sqlstm.sqinds;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqparm = sqlstm.sqharm;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqparc = sqlstm.sqharc;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqpadto = sqlstm.sqadto;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlstm.sqptdso = sqlstm.sqtdso;
#line 211 "./pc/FaPasoHistCarrier.pc"
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 211 "./pc/FaPasoHistCarrier.pc"
}

#line 214 "./pc/FaPasoHistCarrier.pc"

	
	if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {

        	vDTrazasLog(modulo, "\n\t\t* ERROR EN SELECT FROM FA_PROCESOS\n",   LOG05);
                return(SQLCODE);
    	}
    	if(SQLCODE == SQLNOTFOUND)
        {

        	vDTrazasLog(modulo, "\n\t\t* NUM_PROCESO INEXISTENTE EN FA_PROCESOS\n",   LOG05);
                return(SQLCODE);
    	}    	
    	
	
	if(!iCargaFaAcumFortas(&pstAcumFortas.stAcumFortas, &pstAcumFortas.iCantRegs)!= SQLOK)
	{
		strcpy(modulo, "bfnCargaEstructuras");
		vDTrazasLog(modulo, "Error al Cargar FA_ACUMFORTAS. Proceso se cancela.\n",   LOG05);
		return(FALSE);
	}
	
	return(TRUE);
}

BOOL bfnBorraInfCarrier()
{
	int i=0;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 244 "./pc/FaPasoHistCarrier.pc"
   
		long	lhNumAbonado  	;   
		long	lhCodCliente  	;   
		long	lhCodCiclo    	;   
		long	lhCodOperadora	;   
		long 	lhInd_Orden	;
		long	lhCantidadRegs	;
	/* EXEC SQL END DECLARE SECTION; */ 
#line 251 "./pc/FaPasoHistCarrier.pc"
     


	for (i=0;i<pstAcumFortas.iCantRegs;i++)
        {
        	lhNumAbonado 	= pstAcumFortas.stAcumFortas[i].lNumAbonado	;
		lhCodCliente 	= pstAcumFortas.stAcumFortas[i].lCodCliente	;
		lhCodCiclo   	= pstAcumFortas.stAcumFortas[i].lCodPeriodo	;
		lhCodOperadora	= pstAcumFortas.stAcumFortas[i].lCodOperador    ;
		
		/* EXEC SQL 
			DELETE fa_detfortas
			WHERE cod_cliente  = :lhCodCliente
			  AND num_abonado  = :lhNumAbonado
			  AND cod_periodo  = :lhCodCiclo
			  AND cod_operador = :lhCodOperadora; */ 
#line 266 "./pc/FaPasoHistCarrier.pc"

{
#line 261 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 4;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "delete  from fa_detfortas  where (((cod_cliente=:b0 and num\
_abonado=:b1) and cod_periodo=:b2) and cod_operador=:b3)";
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )97;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCodCliente;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhNumAbonado;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[2] = (         void  *)&lhCodCiclo;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[3] = (         void  *)&lhCodOperadora;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 261 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 261 "./pc/FaPasoHistCarrier.pc"
}

#line 266 "./pc/FaPasoHistCarrier.pc"

		
			
			
		vDTrazasLog(modulo, "DELETE FA_DETFORTAS 	\n"
					"WHERE COD_CLIENTE= %ld \n"
					"AND NUM_ABONADO  = %ld \n"
					"AND COD_PERIODO  = %ld \n"
					"AND COD_OPERADOR = %ld ;\n"
					"-----------------------------------------\n"
					, LOG05
					, lhCodCliente   
					, lhNumAbonado   
					, lhCodCiclo     
					, lhCodOperadora);
		
		
		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DELETE A LA FA_DETFORTAS.	SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
	    	if(SQLCODE == SQLNOTFOUND)
	    	{
	    		vDTrazasLog(modulo, "\n\t\t* NO BORRA NADA DE LA FA_DETFORTAS... NOTFOUND.\n",   LOG05);
	    	}
		
		
		/* EXEC SQL 
			DELETE fa_acumfortas
			WHERE cod_cliente  = :lhCodCliente
			  AND num_abonado  = :lhNumAbonado
			  AND cod_periodo  = :lhCodCiclo  
/o Modificado por RMA Desde aqui 17-05-2005  o/
			  AND cod_operador = :lhCodOperadora
/o Modificado por RMA Hasta aqui 17-05-2005  o/
			  AND num_proceso  = :lhNumProceso; */ 
#line 304 "./pc/FaPasoHistCarrier.pc"

{
#line 296 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "delete  from fa_acumfortas  where ((((cod_cliente=:b0 and n\
um_abonado=:b1) and cod_periodo=:b2) and cod_operador=:b3) and num_proceso=:b4\
)";
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )128;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCodCliente;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhNumAbonado;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[2] = (         void  *)&lhCodCiclo;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[3] = (         void  *)&lhCodOperadora;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[4] = (         void  *)&lhNumProceso;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[4] = (unsigned int  )sizeof(long);
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[4] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[4] = (         void  *)0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[4] = (         int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[4] = (unsigned int  )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[4] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[4] = (unsigned short )0;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 296 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 296 "./pc/FaPasoHistCarrier.pc"
}

#line 304 "./pc/FaPasoHistCarrier.pc"

		
			
		vDTrazasLog(modulo, "DELETE FA_ACUMFORTAS         \n"   
					"WHERE COD_CLIENTE	= %ld \n" 
					"AND NUM_ABONADO	= %ld \n" 
					"AND COD_OPERADOR	= %ld \n" 
					"AND COD_PERIODO	= %ld \n" 
					"AND NUM_PROCESO  	= %ld ;\n"
					"-----------------------------------------\n"
					, LOG05
					, lhCodCliente
					, lhNumAbonado
					, lhCodOperadora  
					, lhCodCiclo  
					, lhNumProceso);
			
			
			
		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DELETE A LA FA_ACUMFORTAS. SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
	    	if(SQLCODE == SQLNOTFOUND)
	    	{
	    		vDTrazasLog(modulo, "\n\t\t* NO BORRA NADA DE LA FA_ACUMFORTAS... NOTFOUND.\n",   LOG05);
	    	}			

/* Incorporado por RM Desde aqui 17-05-2005 */
		/* EXEC SQL
			DELETE fa_subfortas_to
			WHERE cod_cliente  = :lhCodCliente
			  AND num_abonado  = :lhNumAbonado
			  AND cod_periodo  = :lhCodCiclo  
			  AND cod_operador = :lhCodOperadora; */ 
#line 341 "./pc/FaPasoHistCarrier.pc"

{
#line 336 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "delete  from fa_subfortas_to  where (((cod_cliente=:b0 and \
num_abonado=:b1) and cod_periodo=:b2) and cod_operador=:b3)";
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )163;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCodCliente;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhNumAbonado;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[2] = (         void  *)&lhCodCiclo;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[3] = (         void  *)&lhCodOperadora;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 336 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 336 "./pc/FaPasoHistCarrier.pc"
}

#line 341 "./pc/FaPasoHistCarrier.pc"

		
			
		vDTrazasLog(modulo, "DELETE FA_SUBFORTAS_TO        \n"   
					"WHERE COD_CLIENTE	= %ld \n" 
					"AND NUM_ABONADO	= %ld \n" 
					"AND COD_PERIODO	= %ld \n" 
					"AND COD_OPERADOR  	= %ld ;\n"
					"-----------------------------------------\n"
					, LOG05
					, lhCodCliente
					, lhNumAbonado
					, lhCodCiclo  
					, lhCodOperadora);
			
			
			
		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DELETE A LA FA_SUBFORTAS_TO. SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
	    	if(SQLCODE == SQLNOTFOUND)
	    	{
	    		vDTrazasLog(modulo, "\n\t\t* NO BORRA NADA DE LA FA_SUBFORTAS_TO... NOTFOUND.\n",   LOG05);
	    	}	
/* Incorporado por RM Hasta aqui 17-05-2005 */
		
		/* EXEC SQL
			DELETE fa_detforliq
			WHERE cod_cliente  = :lhCodCliente   
			  AND num_abonado  = :lhNumAbonado   
			  AND cod_periodo  = :lhCodCiclo     
			  AND cod_operador = :lhCodOperadora; */ 
#line 376 "./pc/FaPasoHistCarrier.pc"

{
#line 371 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "delete  from fa_detforliq  where (((cod_cliente=:b0 and num\
_abonado=:b1) and cod_periodo=:b2) and cod_operador=:b3)";
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )194;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCodCliente;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhNumAbonado;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[2] = (         void  *)&lhCodCiclo;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[3] = (         void  *)&lhCodOperadora;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 371 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 371 "./pc/FaPasoHistCarrier.pc"
}

#line 376 "./pc/FaPasoHistCarrier.pc"


			
		vDTrazasLog(modulo, "DELETE FA_DETFORLIQ   	\n"            			
					"WHERE COD_CLIENTE	= %ld  \n"
					"AND NUM_ABONADO	= %ld  \n"
					"AND COD_PERIODO  	= %ld  \n"
					"AND COD_OPERADOR 	= %ld  ;\n"
					"-----------------------------------------\n"
					, LOG05
					, lhCodCliente   	
					, lhNumAbonado   	
					, lhCodCiclo     	
					, lhCodOperadora);
			
		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DELETE A LA FA_DETFORLIQ. SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
	    	if(SQLCODE == SQLNOTFOUND)
	    	{
	    		vDTrazasLog(modulo, "\n\t\t* NO BORRA NADA DE LA FA_DETFORLIQ... NOTFOUND.\n",   LOG05);
	    	}		
		
		/* EXEC SQL
			DELETE fa_acumforliq
			WHERE cod_cliente  = :lhCodCliente  
			  AND num_abonado  = :lhNumAbonado  
			  AND cod_periodo  = :lhCodCiclo    
			  AND cod_operador = :lhCodOperadora
			  AND num_proceso  = :lhNumProceso; */ 
#line 409 "./pc/FaPasoHistCarrier.pc"

{
#line 403 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "delete  from fa_acumforliq  where ((((cod_cliente=:b0 and n\
um_abonado=:b1) and cod_periodo=:b2) and cod_operador=:b3) and num_proceso=:b4\
)";
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )225;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCodCliente;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhNumAbonado;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[2] = (         void  *)&lhCodCiclo;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[3] = (         void  *)&lhCodOperadora;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[4] = (         void  *)&lhNumProceso;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[4] = (unsigned int  )sizeof(long);
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[4] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[4] = (         void  *)0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[4] = (         int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[4] = (unsigned int  )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[4] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[4] = (unsigned short )0;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 403 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 403 "./pc/FaPasoHistCarrier.pc"
}

#line 409 "./pc/FaPasoHistCarrier.pc"
 


			vDTrazasLog(modulo, "DELETE FA_ACUMFORLIQ         \n"     
						"WHERE COD_CLIENTE	= %ld \n"
						"AND NUM_ABONADO	= %ld \n"
						"AND COD_PERIODO  	= %ld \n"
						"AND COD_OPERADOR 	= %ld \n"
						"AND NUM_PROCESO  	= %ld ;\n"
						"-----------------------------------------\n"
						, LOG05
						, lhCodCliente   
						, lhNumAbonado   
                        			, lhCodCiclo     
                        			, lhCodOperadora 
                        			, lhNumProceso );


		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DELETE A LA FA_ACUMFORLIQ. SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
	    	if(SQLCODE == SQLNOTFOUND)
	    	{
	    		vDTrazasLog(modulo, "\n\t\t* NO BORRA NADA DE LA FA_ACUMFORLIQ... NOTFOUND.\n",   LOG05);
	    	}
	    	
	}
	
	
	/* EXEC SQL 
		DECLARE Cur_Ind_Orden CURSOR FOR
		SELECT	DISTINCT 
			ind_orden
		FROM fa_detfortas_th
		WHERE num_proceso  = :lhNumProceso
		  AND cod_operador = :lhCodOperador; */ 
#line 448 "./pc/FaPasoHistCarrier.pc"

		
	if(SQLCODE != SQLOK)
        {

        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DECLARE CURSOR FA_DETFORTAS_TH. SQLCODE[%ld]\n",   LOG05, SQLCODE);
                return(SQLCODE);
    	}
	
		
	/* EXEC SQL OPEN Cur_Ind_Orden; */ 
#line 458 "./pc/FaPasoHistCarrier.pc"

{
#line 458 "./pc/FaPasoHistCarrier.pc"
 struct sqlexd sqlstm;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlvsn = 10;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.arrsiz = 5;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqladtp = &sqladt;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqltdsp = &sqltds;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.stmt = sq0008;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.iters = (unsigned int  )1;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.offset = (unsigned int  )260;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.selerr = (unsigned short)1;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.cud = sqlcud0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqhstv[0] = (         void  *)&lhNumProceso;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqhstv[1] = (         void  *)&lhCodOperador;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 458 "./pc/FaPasoHistCarrier.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 458 "./pc/FaPasoHistCarrier.pc"
}

#line 458 "./pc/FaPasoHistCarrier.pc"

	
	if(SQLCODE != SQLOK)
        {

        	vDTrazasLog(modulo, "\n\t\t* ERROR EN OPEN CURSOR FA_DETFORTAS_TH. SQLCODE[%ld]\n",   LOG05, SQLCODE);
                return(SQLCODE);
    	}
    			
	while(1)
	{
		/* EXEC SQL FETCH Cur_Ind_Orden
			INTO :lhInd_Orden; */ 
#line 470 "./pc/FaPasoHistCarrier.pc"

{
#line 469 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )283;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhInd_Orden;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 469 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 469 "./pc/FaPasoHistCarrier.pc"
}

#line 470 "./pc/FaPasoHistCarrier.pc"

					
		if (SQLCODE == SQLNOTFOUND)
			break;
		
		/* EXEC SQL
			SELECT COUNT(1)
			INTO :lhCantidadRegs
			FROM fa_detfortas
			WHERE ind_orden = :lhInd_Orden; */ 
#line 479 "./pc/FaPasoHistCarrier.pc"

{
#line 475 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "select count(1) into :b0  from fa_detfortas where ind_orden\
=:b1";
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )302;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.selerr = (unsigned short)1;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCantidadRegs;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhInd_Orden;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 475 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 475 "./pc/FaPasoHistCarrier.pc"
}

#line 479 "./pc/FaPasoHistCarrier.pc"

		
		
		vDTrazasLog(modulo, "\n\t\t* SELECT COUNT(1)	= [%ld] lhInd_Orden [%ld]\n",   LOG05, lhCantidadRegs, lhInd_Orden);
		
		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN SELECT COUNT(1) FA_DETFORTAS. SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
		if (lhCantidadRegs == 0)
		{
			/* EXEC SQL
				DELETE fa_cabfortas
				WHERE ind_orden = :lhInd_Orden; */ 
#line 495 "./pc/FaPasoHistCarrier.pc"

{
#line 493 "./pc/FaPasoHistCarrier.pc"
   struct sqlexd sqlstm;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqlvsn = 10;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.arrsiz = 5;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqladtp = &sqladt;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqltdsp = &sqltds;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.stmt = "delete  from fa_cabfortas  where ind_orden=:b0";
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.iters = (unsigned int  )1;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.offset = (unsigned int  )325;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.cud = sqlcud0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqlety = (unsigned short)256;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.occurs = (unsigned int  )0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqhstv[0] = (         void  *)&lhInd_Orden;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqhsts[0] = (         int  )0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqindv[0] = (         void  *)0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqinds[0] = (         int  )0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqharm[0] = (unsigned int  )0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqadto[0] = (unsigned short )0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqtdso[0] = (unsigned short )0;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqphsv = sqlstm.sqhstv;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqphsl = sqlstm.sqhstl;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqphss = sqlstm.sqhsts;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqpind = sqlstm.sqindv;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqpins = sqlstm.sqinds;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqparm = sqlstm.sqharm;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqparc = sqlstm.sqharc;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqpadto = sqlstm.sqadto;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlstm.sqptdso = sqlstm.sqtdso;
#line 493 "./pc/FaPasoHistCarrier.pc"
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 493 "./pc/FaPasoHistCarrier.pc"
}

#line 495 "./pc/FaPasoHistCarrier.pc"

			
			if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
		        {
		
		        	vDTrazasLog(modulo, "\n\t\t* ERROR EN DELETE A LA FA_CABFORTAS. SQLCODE[%ld]\n",   LOG05, SQLCODE);
		                return(SQLCODE);
		    	}
		    	
		    	if(SQLCODE == SQLNOTFOUND)
		    	{
		    		vDTrazasLog(modulo, "\n\t\t* NO BORRA NADA DE LA FA_CABFORTAS... NOTFOUND.\n",   LOG05);
		    	}

		
		}	
	}
	
	/* EXEC SQL CLOSE Cur_Ind_Orden; */ 
#line 513 "./pc/FaPasoHistCarrier.pc"

{
#line 513 "./pc/FaPasoHistCarrier.pc"
 struct sqlexd sqlstm;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlvsn = 10;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.arrsiz = 5;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqladtp = &sqladt;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqltdsp = &sqltds;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.iters = (unsigned int  )1;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.offset = (unsigned int  )344;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.cud = sqlcud0;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 513 "./pc/FaPasoHistCarrier.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 513 "./pc/FaPasoHistCarrier.pc"
}

#line 513 "./pc/FaPasoHistCarrier.pc"

	
	if(SQLCODE != SQLOK)
        {

        	vDTrazasLog(modulo, "\n\t\t* ERROR EN CLOSE CURSOR FA_DETFORTAS_TH. SQLCODE[%ld]\n",   LOG05, SQLCODE);
                return(SQLCODE);
    	}
	
	

	
	return(TRUE);

}


BOOL bfnCopiaAHistoricos()
{   	
    	int i=0;
    	
    	/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 534 "./pc/FaPasoHistCarrier.pc"

    		long	lhNumAbonado  ;
    		long	lhCodCliente  ;
    		long	lhCodCiclo    ;
    		long	lhCodOperadora;
    	/* EXEC SQL END DECLARE SECTION; */ 
#line 539 "./pc/FaPasoHistCarrier.pc"

    	
    	vDTrazasLog(modulo, "\t\t* bfnCopiaAHistoricos - lhNumProceso 	[%ld]\n", LOG05, lhNumProceso );
    	vDTrazasLog(modulo, "\t\t* bfnCopiaAHistoricos - lhCodCiclFact	[%ld]\n", LOG05, lhCodCiclFact);
    	vDTrazasLog(modulo, "\t\t* bfnCopiaAHistoricos - lhCodOperador	[%ld]\n", LOG05, lhCodOperador);

	vDTrazasLog(modulo, "\n\t\t* SQLNOTFOUND = [%ld].\n",   LOG05, SQLNOTFOUND);

 	for (i=0;i<pstAcumFortas.iCantRegs;i++)
        {
/*		
		vDTrazasLog(modulo,	"---------------------------------------\n"
					"pstAcumFortas.stAcumFortas[%d].lCodCliente	[%ld]\n"
					"pstAcumFortas.stAcumFortas[%d].lNumAbonado	[%ld]\n"
					"pstAcumFortas.stAcumFortas[%d].lCodPeriodo	[%ld]\n"
					"pstAcumFortas.stAcumFortas[%d].lCodOperador	[%ld]\n"
						,LOG05
						,i , pstAcumFortas.stAcumFortas[i].lCodCliente	
						,i , pstAcumFortas.stAcumFortas[i].lNumAbonado	
						,i , pstAcumFortas.stAcumFortas[i].lCodPeriodo	
						,i , pstAcumFortas.stAcumFortas[i].lCodOperador);
*/

        	lhNumAbonado 	= pstAcumFortas.stAcumFortas[i].lNumAbonado	;
		lhCodCliente 	= pstAcumFortas.stAcumFortas[i].lCodCliente	;
		lhCodCiclo   	= pstAcumFortas.stAcumFortas[i].lCodPeriodo	;
		lhCodOperadora	= pstAcumFortas.stAcumFortas[i].lCodOperador    ;  
		
/* Modificado por RMA Desde aqui 17-05-2005  - Agregó columnas en el INSERT*/
		/* EXEC SQL
			INSERT INTO fa_detfortas_th(
				ind_orden	, cod_periodo	, num_terminal	, fec_call	, 
				hora_call	, tip_reg	, ind_alquiler	, ind_salida	, 
				ind_entrada	, des_entrada	, mod_call	, clave_call	, 
				minutos_tasado	, dur_call	, cod_servicio	, acum_netollam	, 
				acum_iva	, tot_pagar	, cod_trafico	, ind_refactura	, 
				lote		, num_abonado	, cod_cliente	, cod_operador	, 
				seq_forfac	,num_proceso)
			SELECT 	ind_orden	, cod_periodo	, num_terminal	, fec_call	, 
				hora_call	, tip_reg	, ind_alquiler	, ind_salida	, 
				ind_entrada	, des_entrada	, mod_call	, clave_call	, 
				minutos_tasado	, dur_call	, cod_servicio	, acum_netollam	, 
				acum_iva	, tot_pagar	, cod_trafico	, ind_refactura	, 
				lote		, num_abonado	, cod_cliente	, cod_operador	, 
				seq_forfac	, :lhNumProceso
			FROM fa_detfortas
			WHERE cod_periodo  = :lhCodCiclo
			  AND cod_operador = :lhCodOperadora
			  AND num_abonado  = :lhNumAbonado
			  AND cod_cliente  = :lhCodCliente; */ 
#line 588 "./pc/FaPasoHistCarrier.pc"

{
#line 568 "./pc/FaPasoHistCarrier.pc"
  struct sqlexd sqlstm;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlvsn = 10;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.arrsiz = 5;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqladtp = &sqladt;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqltdsp = &sqltds;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.stmt = "insert into fa_detfortas_th (ind_orden,cod_periodo,num_term\
inal,fec_call,hora_call,tip_reg,ind_alquiler,ind_salida,ind_entrada,des_entrad\
a,mod_call,clave_call,minutos_tasado,dur_call,cod_servicio,acum_netollam,acum_\
iva,tot_pagar,cod_trafico,ind_refactura,lote,num_abonado,cod_cliente,cod_opera\
dor,seq_forfac,num_proceso)select ind_orden ,cod_periodo ,num_terminal ,fec_ca\
ll ,hora_call ,tip_reg ,ind_alquiler ,ind_salida ,ind_entrada ,des_entrada ,mo\
d_call ,clave_call ,minutos_tasado ,dur_call ,cod_servicio ,acum_netollam ,acu\
m_iva ,tot_pagar ,cod_trafico ,ind_refactura ,lote ,num_abonado ,cod_cliente ,\
cod_operador ,seq_forfac ,:b0  from fa_detfortas where (((cod_periodo=:b1 and \
cod_operador=:b2) and num_abonado=:b3) and cod_cliente=:b4)";
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.iters = (unsigned int  )1;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.offset = (unsigned int  )359;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.cud = sqlcud0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhNumProceso;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[1] = (         void  *)&lhCodCiclo;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[2] = (         void  *)&lhCodOperadora;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[3] = (         void  *)&lhNumAbonado;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstv[4] = (         void  *)&lhCodCliente;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhstl[4] = (unsigned int  )sizeof(long);
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqhsts[4] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqindv[4] = (         void  *)0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqinds[4] = (         int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqharm[4] = (unsigned int  )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqadto[4] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqtdso[4] = (unsigned short )0;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 568 "./pc/FaPasoHistCarrier.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 568 "./pc/FaPasoHistCarrier.pc"
}

#line 588 "./pc/FaPasoHistCarrier.pc"

/* Modificado por RMA Hasta aqui 17-05-2005  */
		
		if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
	        {
	
	        	vDTrazasLog(modulo, "\n\t\t* ERROR EN INSERT A LA FA_DETFORTAS_TH.	SQLCODE[%ld]\n",   LOG05, SQLCODE);
	                return(SQLCODE);
	    	}
	    	
	    	if(SQLCODE == SQLNOTFOUND)
	    	{
	    		vDTrazasLog(modulo, "\n\t\t* INSERT A LA FA_DETFORTAS_TH... NOTFOUND.\n",   LOG05);
	    	}
	}
	/*
	--- Eliminacion del data se hace en la proxima funcion ... por tal motivo las variables bind 
	--- deberian ser globales y no estar declaradas en esta funcion, si no al comienzo del programa. By PGG ---
	*/
	
	return (TRUE);
}


/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
    char modulo[]="main"		;
    char *szUserid_Aux			;
    extern	char *optarg        	;
    char  	opt[]=":u:c:d:l:" 	;
    int   	iOpt =0             	;
    int   	sts			;
    char  	szHelpString[1024] = " ";
    char  	szLineaComando2[25]= ""	;

    memset(&stLineaComando,0    ,sizeof(LINEACOMANDOCARRIER));


    sprintf(szHelpString,"\n Argumentos de entrada de proceso : "
                         "\n\t  -u Usuario/Password          "  
                         "\n\t  -c Ciclo de Facturacion	     "
                         "\n\t  -d Cod_Carrier		     "   
                         "\n\t  -l Nivel de Log		     \n");

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
		case 'u':
			strcpy(stLineaComando.szUsuario, optarg);
			if((szUserid_Aux=(char *)strstr(stLineaComando.szUsuario,"/")) == (char *)NULL)
			{
				fprintf(stderr, "\nUsuario Oracle no es valido.\n");
				return(1);
			}
			else
			{
				strncpy(stLineaComando.szUser,stLineaComando.szUsuario, szUserid_Aux-stLineaComando.szUsuario);
				strcpy(stLineaComando.szPass, szUserid_Aux+1);
				fprintf (stdout," -u?/? ");
			}
			break;
		case 'd':
			if (strlen (optarg) )
			{
				stLineaComando.lCodCarrier = atoi (optarg);
				fprintf (stdout,"-d%d ", stLineaComando.lCodCarrier);
			}
			else
			{
				fprintf (stderr,"\n\t<< Error : Falta parámetro Codigo de Carrier.\n");
				return (1);
			}
			break;

		case 'c':
	                if (strlen (optarg) )
			{
				stLineaComando.lCodCiclo = atoi (optarg);
				fprintf (stdout,"-d%d ", stLineaComando.lCodCiclo);
			}
			else
			{
				fprintf (stderr,"\n\t<< Error : Falta parámetro Codigo de Ciclo.\n");
				return (1);
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
    	if (strcmp(stLineaComando.szUsuario, "")==0)
    	{
		fprintf(stderr, "\n\tUsuario/Password no ingresado\n");
		fprintf(stderr,"%s",szHelpString);
		return (1);
    	}
    

 	if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF;

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





    	/**************************************************************************************/
    	/* Crear archivos y directorios de log y errores */

    	sts = ifnAbreArchivosLog();


    	if ( sts != 0 ) return sts;

    	/*********************************************************************************************/

    	vDTrazasLog  ( modulo ,	"\n\n\t**********************************************"
                           	"\n\n\t****         Log FaPasoHistCarrier          **"
                           	"\n\n\t**********************************************"
                           ,LOG03);

    	vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada FaPasoHistCarrier  ***"
                           "\n\t\t=> Usuario/Password             [%s]"
                           "\n\t\t=> Ciclo de Facturacion	  [%ld]"
                           "\n\t\t=> Cod_Carrier		  [%ld]"
                           "\n\t\t=> Nivel de Log		  [%ld]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.lCodCiclo
                           ,stLineaComando.lCodCarrier
                           ,stLineaComando.iNivLog);

    	/************************************************************************************/
    	/*			Proceso Principal						*/
    	/************************************************************************************/

    	strcpy(modulo,"FaPasoHistCarrier");




	

    	vDTrazasLog(modulo,"\n\t\t***  Inicio Proceso principal  ***", LOG03);
    	vDTrazasLog(modulo,"\n\t\t*** Carga de datos en estructuras ***\n", LOG03);
	if (!bfnCargaEstructuras())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en funcion bfnCargaEstructuras ***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en funcion bfnCargaEstructuras ***\n", LOG01);
	        return (FALSE);
	}

    	vDTrazasLog(modulo,"\n\t\t*** Copiado de datos de la tabla FA_DETFORTAS a FA_DETFORTAS_TH (Historica)***\n", LOG03);
	if (!bfnCopiaAHistoricos())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en funcion bfnCopiaAHistoricos ***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en funcion bfnCopiaAHistoricos ***\n", LOG01);
	        return (FALSE);
	}

	/* EXEC SQL COMMIT; */ 
#line 778 "./pc/FaPasoHistCarrier.pc"

{
#line 778 "./pc/FaPasoHistCarrier.pc"
 struct sqlexd sqlstm;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlvsn = 10;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.arrsiz = 5;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqladtp = &sqladt;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqltdsp = &sqltds;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.iters = (unsigned int  )1;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.offset = (unsigned int  )394;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.cud = sqlcud0;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 778 "./pc/FaPasoHistCarrier.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 778 "./pc/FaPasoHistCarrier.pc"
}

#line 778 "./pc/FaPasoHistCarrier.pc"


	vDTrazasLog(modulo,"\n\t\t*** Eliminacion de datos de carrier ya procesados luego del respaldo en tabla historica FA_DETFORTAS_TH ***\n", LOG03);
	if (!bfnBorraInfCarrier())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en funcion bfnBorraInfCarrier ***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en funcion bfnBorraInfCarrier ***\n", LOG01);
	        return (FALSE);
	}


	/* EXEC SQL ROLLBACK; */ 
#line 789 "./pc/FaPasoHistCarrier.pc"

{
#line 789 "./pc/FaPasoHistCarrier.pc"
 struct sqlexd sqlstm;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlvsn = 10;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.arrsiz = 5;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqladtp = &sqladt;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqltdsp = &sqltds;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.iters = (unsigned int  )1;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.offset = (unsigned int  )409;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.cud = sqlcud0;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 789 "./pc/FaPasoHistCarrier.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 789 "./pc/FaPasoHistCarrier.pc"
}

#line 789 "./pc/FaPasoHistCarrier.pc"

	
/*
    	if (!bfnOraCommit ())
    	{
        	vDTrazasError(modulo," en Commit", LOG01);
        	vDTrazasLog  (modulo," en Commit", LOG01);
        	return FALSE;
    	}
*/    	

	

	if(!bfnDisconnectORA(0))
	{
		vDTrazasLog  ( modulo ,	"\n\t--------------------------------------------"
					"\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
					"\n\t--------------------------------------------\n"
					,LOG03);
		vDTrazasError( modulo ,	"\n\t--------------------------------------------"
					"\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
					"\n\t--------------------------------------------\n"
					,LOG03);
	}
    	else
    	{
		vDTrazasLog  ( modulo,	"\n\t--------------------------------------------"
					"\n\tDesconectado de  ORACLE"
					"\n\t--------------------------------------------\n"
					,LOG03);
		vDTrazasError( modulo, 	"\n\t--------------------------------------------"
					"\n\tDesconectado de  ORACLE"
					"\n\t--------------------------------------------\n"
					,LOG03);

	}


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
	sprintf(szArchivo,"FaPasoHistCarrier");

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/FaPasoHistCarrier/%s",pathDir,cfnGetTime(2));
	free(pathDir);

	fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

	sprintf(stStatus.ErrName,"%s/%s_%s.err",szPath,szArchivo,cfnGetTime(5));
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"w")) == (FILE*)NULL )
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;
	}

	vDTrazasError(modulo, "%s  << Abre Archivo de Errores >>", LOG04, cfnGetTime(1));

	sprintf(stStatus.LogName,"%s/%s_%s.log",szPath,szArchivo,cfnGetTime(5));
	if((stStatus.LogFile = fopen(stStatus.LogName,"w")) == (FILE*)NULL )
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;
	}

	vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG04, cfnGetTime(1));


	vDTrazasLog(modulo, "%s << Inicio de FaPasoHistCarrier >>" , LOG03, cfnGetTime(1));

	return 0;


} /* Fin ifnAbreArchivosLog  */


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

