
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
           char  filnam[18];
};
static struct sqlcxp sqlfpn =
{
    17,
    "./pc/enviamail.pc"
};


static unsigned int sqlctx = 6908267;


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

 static char *sq0002 = 
"select a.accion ,a.tipmail ,RTRIM(b.nom_usua) ,RTRIM(b.app_usua) ,RTRIM(b.di\
r_email) ,nvl(b.fono,0)  from sch_rmailproc a ,acc_usuario b where ((((a.cod_p\
roc=:b0 and a.cod_subpro=:b1) and b.fec_term>SYSDATE) and b.flg_mensaje='S') a\
nd b.cod_usua=a.cod_usua)           ";

 static char *sq0004 = 
"select TO_CHAR(TO_DATE(fecha,'yyyymmddhh24miss'),'dd-mon-yyyy hh:mi:ss PM') \
,trim(gls_param) ,trim(motivo) ,trim(tip_ejecucion)  from sch_hprofile ,sch_co\
digos where (((((cod_proc=:b0 and cod_subpro=:b1) and cod_central=:b2) and num\
_jobs=:b3) and cod_tipo='ESTAPROCE') and cod_param=cod_estado) order by fecha \
           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,31,65,0,0,0,0,0,1,0,
20,0,0,2,268,0,9,82,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
43,0,0,2,0,0,13,88,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,
82,0,0,3,146,0,4,104,0,0,6,4,0,1,0,2,5,0,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,
0,0,
121,0,0,4,321,0,9,132,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
152,0,0,4,0,0,13,142,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,
179,0,0,4,0,0,13,153,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,
206,0,0,5,0,0,27,177,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,10,0,0,1,10,0,0,
237,0,0,6,113,0,4,189,0,0,3,2,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,
264,0,0,7,104,0,4,207,0,0,4,3,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
};


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sqlda.h>
#include "tol.h"

#define      SqlNotFound   1403
#define      SqlOk            0
#define      SqlNull       1405

/* exec sql include sqlca;
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

/* exec oracle option (MAXOPENCURSORS=60); */ 
 

/* EXEC SQL BEGIN DECLARE SECTION; */ 

char uid[20];			/* exec sql var uid is string(20); */ 

char pwd[20];			/* exec sql var pwd is string(20); */ 

char cod_proc[11];		/* exec sql var cod_proc is string(11); */ 

char cod_spro[11];		/* exec sql var cod_spro is string(11); */ 

char cod_scri[10];		/* exec sql var cod_scri is string(10); */ 

char cod_central[10];	/* exec sql var cod_central is string(10); */ 

char flg_batch[1];		/* exec sql var flg_batch is string(1); */ 

char nombre_tarea[30];	/* exec sql var nombre_tarea is string(30); */ 


int corr_accion;
int corr_tipmail;
char corr_nombre[15];	/* exec sql var corr_nombre is string(15); */ 

char corr_apellido[20]; /* exec sql var corr_apellido is string(20); */ 

char corr_email[50];	/* exec sql var corr_email is string(50); */ 

char corr_fono[20];		/* exec sql var corr_fono is string(20); */ 

char f_ini[30];			/* exec sql var f_ini is string(30); */ 

char f_ter[30];			/* exec sql var f_ter is string(30); */ 

char fec_par[30];		/* exec sql var fec_par is string(30); */ 

char gls_param[52];     /* exec sql var gls_param is string(52); */ 

char motivo[52];        /* exec sql var motivo is string(52); */ 

char tip_ejecucion[11]; /* exec sql var tip_ejecucion is string(11); */ 

char nom_proc[30];		/* exec sql var nom_proc is string(30); */ 

char str_jobs[11];		/* exec sql var str_jobs is string(11); */ 

long int n_regs;
char comando[80];
char body[10024];
FILE *arch;
long num_jobs=0;
/* EXEC SQL END DECLARE SECTION; */ 


fnFilePatron()
{
}

void fnMsgError(szMsg, iErrNum,bRollCom)
char *szMsg;
int  iErrNum;
int  bRollCom;
{
	char msg[200];
	size_t buf_len, msg_len;
	buf_len = sizeof (msg);
	if (iErrNum != SqlNull) 
	{
		if ((iErrNum != SqlOk) && (iErrNum != SqlNotFound)) 
		{
			printf("ERROR SQL : %d EN %s \n",iErrNum,szMsg);
			sqlglm(msg, &buf_len, &msg_len);
			printf("%.*s\n\n", msg_len, msg);
			if (bRollCom)
				/* exec sql rollback work; */ 

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


			exit(1);
		}
	}
}

void abrir_emaillst()
{
	/* exec sql declare Currelmail cursor for
        SELECT a.accion, a.tipmail, RTRIM(b.nom_usua), RTRIM(b.app_usua), RTRIM(b.dir_email), nvl(b.fono,0)
        FROM   sch_rmailproc a, acc_usuario b
        WHERE  a.cod_proc    = :cod_proc  AND
               a.cod_subpro  = :cod_spro  AND
               b.fec_term    > SYSDATE  AND
               b.flg_mensaje = 'S' AND
               b.cod_usua    = a.cod_usua; */ 


        /* exec sql open Currelmail; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )20;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)cod_proc;
        sqlstm.sqhstl[0] = (unsigned long )11;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)cod_spro;
        sqlstm.sqhstl[1] = (unsigned long )11;
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


	fnMsgError("Abrir Curr-Email" , sqlca.sqlcode,0);
}

int qry_email()
{
	/* EXEC SQL FETCH Currelmail
	INTO :corr_accion, :corr_tipmail, :corr_nombre, :corr_apellido, :corr_email, :corr_fono; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )43;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&corr_accion;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&corr_tipmail;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)corr_nombre;
 sqlstm.sqhstl[2] = (unsigned long )15;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)corr_apellido;
 sqlstm.sqhstl[3] = (unsigned long )20;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)corr_email;
 sqlstm.sqhstl[4] = (unsigned long )50;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)corr_fono;
 sqlstm.sqhstl[5] = (unsigned long )20;
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



	if (sqlca.sqlcode==SqlNotFound)
		return(0);
	else
		return(1);
}

void muestra_primer_his()
{
	trim(fec_par,1,strlen(fec_par),fec_par);
	trim(cod_proc,1,strlen(cod_proc),cod_proc);
	trim(cod_spro,1,strlen(cod_spro),cod_spro);
	trim(cod_central,1,strlen(cod_central),cod_central);

	/* EXEC SQL SELECT num_jobs, TRIM(tip_ejecucion)
		INTO :str_jobs, :tip_ejecucion
		FROM sch_hprofile
		WHERE	cod_proc    = :cod_proc	 AND
				cod_subpro  = :cod_spro	 AND
				cod_central = :cod_central AND
				fecha       = :fec_par; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select num_jobs ,trim(tip_ejecucion) into :b0,:b1  from sch_\
hprofile where (((cod_proc=:b2 and cod_subpro=:b3) and cod_central=:b4) and fe\
cha=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )82;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)str_jobs;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)tip_ejecucion;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)cod_proc;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)cod_spro;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)cod_central;
 sqlstm.sqhstl[4] = (unsigned long )10;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)fec_par;
 sqlstm.sqhstl[5] = (unsigned long )30;
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



  	if (sqlca.sqlcode==SqlNotFound) {
	    num_jobs = 0;
	    strcpy(str_jobs, "*");
       }
    else {
	    num_jobs = atol(str_jobs);

		/* exec sql declare Currelhis cursor for
		SELECT TO_CHAR(TO_DATE(fecha,'yyyymmddhh24miss'),'dd-mon-yyyy hh:mi:ss PM'),
				TRIM(gls_param), 
				TRIM(motivo),
				TRIM(tip_ejecucion)
		FROM sch_hprofile, sch_codigos
		WHERE	cod_proc    = :cod_proc	   AND
				cod_subpro  = :cod_spro	   AND
				cod_central = :cod_central AND
				num_jobs	= :num_jobs    AND
				cod_tipo    = 'ESTAPROCE'  AND
				cod_param   = cod_estado
		ORDER BY fecha; */ 

		/* exec sql open Currelhis; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0004;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )121;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)cod_proc;
  sqlstm.sqhstl[0] = (unsigned long )11;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_spro;
  sqlstm.sqhstl[1] = (unsigned long )11;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)cod_central;
  sqlstm.sqhstl[2] = (unsigned long )10;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&num_jobs;
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
	
}


void muestra_historial(char body[10024])
{
	char linea[150];
	char existe='N';
	/* exec sql FETCH Currelhis INTO :f_ini, :gls_param, :motivo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )152;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)f_ini;
 sqlstm.sqhstl[0] = (unsigned long )30;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)gls_param;
 sqlstm.sqhstl[1] = (unsigned long )52;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)motivo;
 sqlstm.sqhstl[2] = (unsigned long )52;
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


	if (sqlca.sqlcode != SqlNotFound)
	{
		strcat(body,"\n--------------------------------------------------------------------------");
		existe = 'S';
	}

	while (sqlca.sqlcode != SqlNotFound)
	{
		sprintf(linea,"\n%s -> %s. %s",f_ini, gls_param, motivo);
		strcat(body,linea);
		/* exec sql FETCH Currelhis INTO :f_ini, :gls_param, :motivo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )179;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)f_ini;
  sqlstm.sqhstl[0] = (unsigned long )30;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)gls_param;
  sqlstm.sqhstl[1] = (unsigned long )52;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)motivo;
  sqlstm.sqhstl[2] = (unsigned long )52;
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
	if (existe = 'S') strcat(body,"\n--------------------------------------------------------------------------\n");
}

int main (int argc, char **argv)
{
int i;
int cod_ret;


    strcpy(cod_proc,argv[1]);
    strcpy(cod_spro,argv[2]);
    strcpy(cod_scri,argv[3]);
	strcpy(cod_central,argv[4]);
    strcpy(fec_par,argv[5]);
    strcpy(uid,argv[6]);
    strcpy(pwd,argv[7]);
	cod_ret=atoi(argv[8]);

/*	for (i= 1;i<argc ;i++)
		printf("Argumento %d = %s \n",i,argv[i]); */
	nombre_tarea[0]='\0';

	/* EXEC SQL CONNECT :uid IDENTIFIED BY :pwd; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )60;
 sqlstm.offset = (unsigned int  )206;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)uid;
 sqlstm.sqhstl[0] = (unsigned long )20;
 sqlstm.sqhsts[0] = (         int  )20;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)pwd;
 sqlstm.sqhstl[1] = (unsigned long )20;
 sqlstm.sqhsts[1] = (         int  )20;
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
 sqlstm.sqlcmax = (unsigned int )100;
 sqlstm.sqlcmin = (unsigned int )2;
 sqlstm.sqlcincr = (unsigned int )1;
 sqlstm.sqlctimeout = (unsigned int )0;
 sqlstm.sqlcnowait = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	fnMsgError("Connect", sqlca.sqlcode, 0);
/* Busca direciones de Correos asociados */

 	sqlca.sqlcode = 0;
	abrir_emaillst();
	trim(fec_par,1,strlen(fec_par),fec_par);
	n_regs = sqlca.sqlerrd[2];

/* Busca del nombre del proceso */

	sqlca.sqlcode = 0;
	/* EXEC SQL SELECT gls_subproc
		INTO :nom_proc
		FROM sch_detalle_proc
		WHERE	cod_proc    = :cod_proc	   AND
				cod_subpro  = :cod_spro	   AND
				fec_term    > SYSDATE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select gls_subproc into :b0  from sch_detalle_proc where ((c\
od_proc=:b1 and cod_subpro=:b2) and fec_term>SYSDATE)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )237;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)nom_proc;
 sqlstm.sqhstl[0] = (unsigned long )30;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_proc;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)cod_spro;
 sqlstm.sqhstl[2] = (unsigned long )11;
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



	fnMsgError("SELECT SCH_DETALLE_PROC" , sqlca.sqlcode,0);
/* Busca la informacion en la tabla historica */
	muestra_primer_his();

/* Busca nombre de la tarea */
    if (strcmp(cod_scri,"N") == 0) /*El procesos no tiene Tareas */
    {
		strcpy(nombre_tarea,"N");
    } 
	else
	{
		/* EXEC SQL SELECT gls_script 
		INTO :nombre_tarea
		FROM sch_script
		WHERE cod_proc   = :cod_proc   AND
			  cod_subpro = :cod_spro AND
			  cod_script = :cod_scri; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select gls_script into :b0  from sch_script where ((cod_pro\
c=:b1 and cod_subpro=:b2) and cod_script=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )264;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)nombre_tarea;
  sqlstm.sqhstl[0] = (unsigned long )30;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_proc;
  sqlstm.sqhstl[1] = (unsigned long )11;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)cod_spro;
  sqlstm.sqhstl[2] = (unsigned long )11;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)cod_scri;
  sqlstm.sqhstl[3] = (unsigned long )10;
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



        fnMsgError("SELECT SCH_SCRIPT" , sqlca.sqlcode,0);
	}
	if (cod_ret == 1) system("sleep 5");

/* Comienza acrear el mail */
	while (qry_email()) {
		printf("[%d] [%d] [%s] [%s] [%s] [%s] [%d]\n",corr_accion, corr_tipmail, corr_nombre, corr_apellido, corr_email, corr_fono, sqlca.sqlcode);
		if ((corr_accion==2 || corr_accion==3) && cod_ret==0) 
		{
			if (corr_tipmail==1 || corr_tipmail==3) 
			{
				strcpy(body, "Subject: Proceso ");
				strcat(body, nom_proc);
				strcat(body, " terminado normalmente\n\n");
				strcat(body, "Sr(a). ");
				strcat(body, corr_nombre);
				strcat(body, " ");
				strcat(body, corr_apellido);
				strcat(body, "\n");
				strcat(body, "Informamos a usted que el proceso ");
				strcat(body, nom_proc);
				strcat(body, " ha finalizado correctamente.\n\n");
				strcat(body, "Su historial es el siguiente:\n\n");

				if (strcmp(tip_ejecucion,"2") == 0)
				{
					strcat(body, "\nCentral: ");
					strcat(body, cod_central);
				}
				else
					if (strcmp(tip_ejecucion,"3") == 0)
					{
						strcat(body, "\nBase de calculo N°: ");
						strcat(body, cod_central);
					}
				
				if (strcmp(str_jobs, "*") == 0) {
				    strcat(body, "\n\nNo fue posible recuperar el NUM_JOBS, y por lo tanto la historia del proceso.\n");
				   }
				else {
					strcat(body, "\nNúmero de job: ");
					strcat(body, str_jobs);

					muestra_historial(body);
				   }

				strcat(body, "\n\nLe saluda atentamente\n");
				strcat(body, "Administrador de procesos.");
				arch = fopen("EnviaMail_std.txt","w+");
				fprintf(arch, body);
				fclose(arch);
				strcpy(comando,"mail -tw ");
				strcat(comando, corr_email);
				strcat(comando, " < EnviaMail_std.txt");
				system(comando);
				printf("\nCOMANDO 1 : <%s>\n",comando);
			}

			if (corr_tipmail==2 || corr_tipmail==3) 
			{
				strcpy(body, "Subject: Proc. finalizado");
				strcat(body, "Sr(a). ");
				strcat(body, corr_nombre);
				strcat(body, " ");
				strcat(body, corr_apellido);
				strcat(body, "\n");
				strcat(body, "Informamos que el proceso ");
				strcat(body, nom_proc);
				strcat(body, " terminó OK.\n\n");
				strcat(body, "\n\nAtte\n");
				strcat(body, "Adm. de proc.");
				arch = fopen("EnviaMail_cell.txt","w+");
				fprintf(arch, body);
				fclose(arch);
				strcpy(comando,"mail -tw ");
				strcat(comando, corr_fono);
				strcat(comando, " < EnviaMail_cell.txt");
				system(comando);
                printf("\nCOMANDO 2 : <%s>\n",comando);
			}
		}

		if ((corr_accion==1 || corr_accion==3) && cod_ret!=0) 
		{
			if (corr_tipmail==1 || corr_tipmail==3) 
			{
				strcpy(body, "Subject: Error en proceso ");
				strcat(body, nom_proc);
				strcat(body, "\n\nSr(a). ");
				strcat(body, corr_nombre);
				strcat(body, " ");
				strcat(body, corr_apellido);
				strcat(body, "\n");
				strcat(body, "Informamos a usted que el proceso ");
				strcat(body, nom_proc);
				strcat(body, " ha finalizado con error.\n\n");
				strcat(body, "Su historial es el siguiente:\n");
				strcat(body, "-----------------------------");

				if (strlen(nombre_tarea) > 1)
				{
					strcat(body, "\nTarea errónea: ");
					strcat(body, nombre_tarea);
				}

				if (strcmp(tip_ejecucion,"2") == 0)
				{
					strcat(body, "\nCentral: ");
					strcat(body, cod_central);
				}
				else
					if (strcmp(tip_ejecucion,"3") == 0)
					{
						strcat(body, "\nBase de calculo N°: ");
						strcat(body, cod_central);
					}
				
				if (strcmp(str_jobs, "*") == 0) {
				    strcat(body, "\n\nNo fue posible recuperar el NUM_JOBS, y por lo tanto la historia del proceso.\n");
				   }
				else {
					strcat(body, "\nNúmero de job: ");
					strcat(body, str_jobs);

					muestra_historial(body);
				   }
				
				strcat(body, "\n\nLe saluda atentamente\n");
				strcat(body, "Administrador de procesos.");

				arch = fopen("EnviaMail_std.txt","w+");
				fprintf(arch, body);
				fclose(arch);
				strcpy(comando,"mail -tw ");
				strcat(comando, corr_email);
				strcat(comando, " < EnviaMail_std.txt");
				system(comando);
				printf("\nCOMANDO 3 : <%s>\n",comando);
			}

			if (corr_tipmail==2 || corr_tipmail==3) 
			{
				strcpy(body, "Subject: Proc. con error");
				strcat(body, "Sr(a). ");
				strcat(body, corr_nombre);
				strcat(body, " ");
				strcat(body, corr_apellido);
				strcat(body, "\n");
				strcat(body, "Informamos que el proceso ");

				if (strlen(nombre_tarea) > 1)
					strcat(body, nombre_tarea);
				else
					strcat(body, nom_proc);

				strcat(body, " ha finalizado con error.\n\n");
				strcat(body, "\n\nAtte\n");
				strcat(body, "Adm. de proc.");
				arch = fopen("EnviaMail_cell.txt","w+");
				fprintf(arch, body);
				fclose(arch);
				strcpy(comando,"mail -tw ");
				strcat(comando, corr_fono);
				strcat(comando, " < EnviaMail_cell.txt");
				system(comando);
				printf("\nCOMANDO 4 : <%s>\n",comando);
			}
		}
	}
	exit(0);
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

