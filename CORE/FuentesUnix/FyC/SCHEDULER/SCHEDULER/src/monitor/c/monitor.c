
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
static struct sqlcxp sqlfpn =
{
    15,
    "./pc/monitor.pc"
};


static unsigned int sqlctx = 1731035;


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
   unsigned char  *sqhstv[7];
   unsigned long  sqhstl[7];
            int   sqhsts[7];
            short *sqindv[7];
            int   sqinds[7];
   unsigned long  sqharm[7];
   unsigned long  *sqharc[7];
   unsigned short  sqadto[7];
   unsigned short  sqtdso[7];
} sqlstm = {12,7};

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
"select num_jobs ,cod_proc ,cod_subpro ,cod_central ,cod_estado ,TO_CHAR(fec_\
ter,'yyyymmddhh24miss') ,tip_ejecucion  from sch_profile where (flg_batch<>'B'\
 and cod_estado<>'ENCOL') order by num_jobs            ";

 static char *sq0009 = 
"select a.cod_proc ,a.cod_subpro ,a.tip_ejecucion ,a.gls_subproc  from sch_de\
talle_proc a ,sch_secejec b where (((a.ind_colas='S' or a.ind_colas='X') and b\
.cod_proc=a.cod_proc) and b.cod_subpro=a.cod_subpro) order by b.correl        \
    ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,31,54,0,0,0,0,0,1,0,
20,0,0,2,209,0,9,90,0,0,0,0,0,1,0,
35,0,0,2,0,0,13,91,0,0,7,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,
0,2,5,0,0,
78,0,0,3,70,0,4,133,0,0,1,0,0,1,0,2,5,0,0,
97,0,0,4,144,0,5,137,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
128,0,0,5,0,0,29,144,0,0,0,0,0,1,0,
143,0,0,6,208,0,3,146,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
178,0,0,7,0,0,29,153,0,0,0,0,0,1,0,
193,0,0,2,0,0,13,163,0,0,7,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,
236,0,0,8,93,0,4,359,0,0,1,0,0,1,0,2,5,0,0,
255,0,0,9,236,0,9,378,0,0,0,0,0,1,0,
270,0,0,9,0,0,13,383,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
301,0,0,9,0,0,13,408,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
332,0,0,10,0,0,27,456,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,10,0,0,1,10,0,0,
};


#include "monitor.h"
#define ACTI      1
#define EJEC      2
#define COMD      3
#define VCOL      4
#define MCPU	  5	 
#define SALE      99


/* EXEC SQL include sqlca;
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

/* EXEC ORACLE OPTION (MAXOPENCURSORS=60); */ 
 

/*===============================================================*/
/* Variables de la base de datos                                 */
/*===============================================================*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

char uid[20];              /* exec sql var uid            is string(20); */ 

char pwd[20];              /* exec sql var pwd            is string(20); */ 

char mcod_proc[11];        /* exec sql var mcod_proc      is string(11); */ 
 
char mcod_subpro[11];      /* exec sql var mcod_subpro    is string(11); */ 
 
char mcod_central[11];     /* exec sql var mcod_central   is string(11); */ 

char mcod_prefcola[3];     /* exec sql var mcod_prefcola  is string(3); */ 
 
char mcod_estado[11];      /* exec sql var mcod_estado    is string(11); */ 
 
char mfec_error[21];       /* exec sql var mfec_error     is string(21); */ 
 
char mnum_jobs[11];        /* exec sql var mnum_jobs      is string(11); */ 

char mtip_ejecucion[10];   /* exec sql var mtip_ejecucion is string(10); */ 

char mgls_subproc[30];     /* exec sql var mgls_subproc   is string(30); */ 


/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------->>>>> TRADUCCION DEL PTOTOCOLO            <<<<<----------------------------------*/
int trad_protocolo (char *comando)
{
	if (strcmp(comando,"ACTI") == 0 ) return(1);
	if (strcmp(comando,"EJEC") == 0 ) return(2);
	if (strcmp(comando,"COMD") == 0 ) return(3);
	if (strcmp(comando,"VCOL") == 0 ) return(4);
	if (strcmp(comando,"MCPU") == 0 ) return(5);
	if (strcmp(comando,"SALE") == 0 ) return(99);

}

/*----------------------------------------------------------*/
/* Funcion   : fnMsgError                                   */
/* Objetivo  : Manejador de errores sql                     */
/*----------------------------------------------------------*/
fnMsgError(char *szMsg, int  iErrNum,int  bRollCom)
{
 if (iErrNum NE SqlNull) 
 {
     if ((iErrNum NE SqlOk) and (iErrNum NE SqlNotFound))
     {
        printf("ERROR SQL : %d en %s \n",iErrNum,szMsg);
        if (bRollCom)  /* EXEC SQL rollback work; */ 

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

/*---------------------------------->>>>> COMANDOS SOLICITADOS POR EL CLIENTE <<<<<----------------------------------*/
/*---------------------------------------------------------------------------------*/
/*  Busqueda de las tareas en linea inscritas en el registro de procesos de UNIX   */
/*---------------------------------------------------------------------------------*/
int ver_consola(int sock, FILE *logf, char *param)
{
	char buffer[BUFFER_SIZE];
	char xbuffer[35];
	DIR  *dp;
	struct dirent *dirp;
	prpsinfo_t retval;
	int fd,i;
	div_t nsec;
	div_t nhor;
	char horta[20], frm_hora[11], formato[50];
    time_t now;
	float pcpu,pmem;
	strcpy(buffer,"#");
    sqlca.sqlcode = 0;
	if((dp=opendir("/proc"))!=NULL)
	{
		chdir("/proc");
/*--->>> Si existe el directorio 'proc' se hace la consulta a la tabla 'profile' <<<---*/
		/* EXEC SQL DECLARE Currelproc cursor for
		SELECT num_jobs, cod_proc, cod_subpro, cod_central, cod_estado, TO_CHAR(fec_ter,'yyyymmddhh24miss'), tip_ejecucion
		FROM   sch_profile
		WHERE  flg_batch    <> 'B'     AND
			   cod_estado	<> 'ENCOL' 
		ORDER BY num_jobs; */ 

			   
		/* EXEC SQL OPEN Currelproc; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 0;
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
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		/* EXEC SQL FETCH Currelproc into :mnum_jobs, :mcod_proc, :mcod_subpro, :mcod_central, :mcod_estado, :mfec_error, :mtip_ejecucion; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )35;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)mnum_jobs;
  sqlstm.sqhstl[0] = (unsigned long )11;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)mcod_proc;
  sqlstm.sqhstl[1] = (unsigned long )11;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)mcod_subpro;
  sqlstm.sqhstl[2] = (unsigned long )11;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)mcod_central;
  sqlstm.sqhstl[3] = (unsigned long )11;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)mcod_estado;
  sqlstm.sqhstl[4] = (unsigned long )11;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)mfec_error;
  sqlstm.sqhstl[5] = (unsigned long )21;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)mtip_ejecucion;
  sqlstm.sqhstl[6] = (unsigned long )10;
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


		while (sqlca.sqlcode != SqlNotFound)
		{
			if((fd=open(mnum_jobs,O_RDONLY))!=-1)
			{
				if(ioctl(fd,PIOCPSINFO,&retval)!=-1)
				{
					/* Formato de la hora  variable frm_hora */
					now = time(NULL);
					now = difftime(now,retval.pr_start.tv_sec);
					nhor = div(now,3600);
					nsec = div(nhor.rem,60);
     				if (nsec.quot > 9) strcpy(frm_hora,"%4d:%d"); else strcpy(frm_hora,"%4d:0%d");
                    if (nsec.rem  > 9) strcat(frm_hora,":%d");    else strcat(frm_hora,":0%d");
     				cftime(horta,"%M:%S ",&retval.pr_time.tv_sec);
					pcpu = retval.pr_pctcpu * (1 / 327.68);
					pmem = retval.pr_pctmem * (1 / 327.68);
					strcpy(formato,"%6dS%2d");
					strcat(formato,frm_hora);
					strcat(formato,"%5s%2.2f%2.2f%c");
					sprintf(xbuffer, formato,
								    retval.pr_pid,                    /* N— PID                                   A(06) */
					                retval.pr_pri,					  /* Prioridad                                N(02) */
					                nhor.quot, nsec.quot, nsec.rem,   /* Tiempo de Sala                           A(10) */
									horta,							  /* Tiempo de procesador                     A(05) */	
									pmem,							  /* Porcentaje de Memoria                    N(2).2*/
									pcpu,							  /* Porcentaje de CPU                        N(2).2*/
									retval.pr_sname);    			  /* Estado del procesador                    A(01) */
                       /*           retval.pr_cpu);				      /* Cpu actual de proceso                    A(01) */
																	  /* Suma registro                              35  */
					strcat(buffer,xbuffer);
				}
				close(fd);
			}
			else /*Si no encuentra el PID de la base de datos en el sistema, graba el error en la tabla Sch_Profile */
			{
				if(strcmp(mcod_estado,"ERROR") != 0)
				{
					trim(mcod_proc,1,strlen(mcod_proc),mcod_proc);
					trim(mcod_subpro,1,strlen(mcod_subpro),mcod_subpro);
					trim(mcod_central,1,strlen(mcod_central),mcod_central);
					sqlca.sqlcode=0;
					/* EXEC SQL
					SELECT TO_CHAR(SYSDATE,'yyyymmddhh24miss') INTO :mfec_error
					FROM  sch_profile; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select TO_CHAR(SYSDATE,'yyyymmddhh24miss') into :b0  fro\
m sch_profile ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )78;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)mfec_error;
     sqlstm.sqhstl[0] = (unsigned long )21;
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



					/* EXEC SQL
					UPDATE Sch_Profile
					SET  Cod_Estado    = 'ERROR',
						 Fec_Ter       = TO_DATE(:mfec_error,'yyyymmddhh24miss')
					WHERE  cod_proc    = :mcod_proc   AND
						   cod_subpro  = :mcod_subpro AND
						   cod_central = :mcod_central; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update Sch_Profile  set Cod_Estado='ERROR',Fec_Ter=TO_DA\
TE(:b0,'yyyymmddhh24miss') where ((cod_proc=:b1 and cod_subpro=:b2) and cod_ce\
ntral=:b3)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )97;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)mfec_error;
     sqlstm.sqhstl[0] = (unsigned long )21;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)mcod_proc;
     sqlstm.sqhstl[1] = (unsigned long )11;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)mcod_subpro;
     sqlstm.sqhstl[2] = (unsigned long )11;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)mcod_central;
     sqlstm.sqhstl[3] = (unsigned long )11;
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


					/* EXEC SQL COMMIT; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )128;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



					/* EXEC SQL
					INSERT INTO sch_hprofile 
					       (COD_PROC, COD_SUBPRO, COD_CENTRAL, NUM_JOBS, FECHA, 
					       COD_ESTADO, RESPONSABLE, MOTIVO, TIP_EJECUCION) 
					VALUES 
					       (:mcod_proc, :mcod_subpro, :mcod_central, :mnum_jobs, to_char(sysdate, 'YYYYMMDDHH24MISS'), 
					        'ERROR',  'SCHEDULER', NULL, :mtip_ejecucion); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into sch_hprofile (COD_PROC,COD_SUBPRO,COD_CENTRA\
L,NUM_JOBS,FECHA,COD_ESTADO,RESPONSABLE,MOTIVO,TIP_EJECUCION) values (:b0,:b1,\
:b2,:b3,to_char(sysdate,'YYYYMMDDHH24MISS'),'ERROR','SCHEDULER',null ,:b4)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )143;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)mcod_proc;
     sqlstm.sqhstl[0] = (unsigned long )11;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)mcod_subpro;
     sqlstm.sqhstl[1] = (unsigned long )11;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)mcod_central;
     sqlstm.sqhstl[2] = (unsigned long )11;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)mnum_jobs;
     sqlstm.sqhstl[3] = (unsigned long )11;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)mtip_ejecucion;
     sqlstm.sqhstl[4] = (unsigned long )10;
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


					/* EXEC sql commit; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 7;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )178;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



				}
				trim(mnum_jobs,1,strlen(mnum_jobs),mnum_jobs);
				sprintf(xbuffer, "%6sN%14s--------------",
								mnum_jobs,  					      /* N— PID                                   A(06) */
								mfec_error);						  /* Fecha del error                          A(14) */
																	  /* Suma registro                              21   */
				strcat(buffer,xbuffer);
			} /* Fin si comparacion tabla/sistema*/
			/* EXEC SQL FETCH Currelproc into :mnum_jobs, :mcod_proc, :mcod_subpro, :mcod_central, :mcod_estado, :mfec_error, :mtip_ejecucion; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )193;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)mnum_jobs;
   sqlstm.sqhstl[0] = (unsigned long )11;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)mcod_proc;
   sqlstm.sqhstl[1] = (unsigned long )11;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)mcod_subpro;
   sqlstm.sqhstl[2] = (unsigned long )11;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)mcod_central;
   sqlstm.sqhstl[3] = (unsigned long )11;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)mcod_estado;
   sqlstm.sqhstl[4] = (unsigned long )11;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)mfec_error;
   sqlstm.sqhstl[5] = (unsigned long )21;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)mtip_ejecucion;
   sqlstm.sqhstl[6] = (unsigned long )10;
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


		} /*Fin While de la tabla */
		closedir(dp);
		strcat(buffer,"\0");
		if (write_single(sock,logf,buffer) < 0 ) 
		{	
			printf ("Error al grabar write_multi\n");
			return -3;
		}
  		return 1;
	}
	else /* Si no existe el directorio */
	{
		strcpy(buffer,"NO EXISTE DIRECTORIO \0");
		if (write_single(sock,logf,buffer) < 0 ) return -3;
  		return -1;
	}
}

/*---------------------------------------------------------------------------------*/
/*            Visualizacion de la memoria general y el uso de las CPU              */
/*---------------------------------------------------------------------------------*/
int ver_memcpu(int sock, FILE * logf, char * param) 
{
	char buffer [BUFFER_SIZE];
	char command[BUFFER_SIZE];
  	char logs   [BUFFER_SIZE];
	
	char xbuffer[10];
	double cpu_sys[20][2],cpu_paso;
	int tot_cpu = 0,existe;
	DIR  *dp;
	struct dirent *dirp;
	prpsinfo_t retval;
	int fd,i;
	float phys_pg, aphys_pg, pg_size,pcpu;
	long phys_mem, aphys_mem;

	phys_pg = sysconf(_SC_PHYS_PAGES);
	aphys_pg = sysconf(_SC_AVPHYS_PAGES);
	pg_size = sysconf(_SC_PAGESIZE);
	phys_mem=(phys_pg / 1048576) * pg_size;
	aphys_mem=((aphys_pg / 1024) * pg_size) / 1024;
	sprintf(buffer,"MEMORY%10ld%10ld",phys_mem,aphys_mem);

	if((dp=opendir("/proc"))!=NULL)
	{
		chdir("/proc");
		while((dirp=readdir(dp))!=NULL)
		{
			if(dirp->d_name[0]!='.')
			{
				if((fd=open(dirp->d_name,O_RDONLY))!=-1)
				{
					if(ioctl(fd,PIOCPSINFO,&retval)!=-1)
					{
						pcpu = retval.pr_pctcpu * (1 / 327.68);
						existe = 0;
						cpu_paso = retval.pr_cpu;
						for (i = 0; i<=tot_cpu; i++)
						{
							if (cpu_sys[i][0] == retval.pr_cpu)
							{
								existe = 1;
								cpu_sys[i][1] += pcpu;
								break;
							}
						}
						if (existe == 0)
						{
							cpu_sys[tot_cpu][0] = cpu_paso;
							cpu_sys[tot_cpu][1] = pcpu;
							tot_cpu ++;
						}
					}
					close(fd);
				}
			}
		}
		closedir(dp);
		for (i = 0; i<tot_cpu; i++) /* Despliegue de los CPU y sus porcentajes */
		{
			sprintf(xbuffer,"%5.0f%2.2fP",cpu_sys[i][0], cpu_sys[i][1]);
			strcat(buffer,xbuffer);
		}

		strcat(buffer,"\0");
		if (write_single(sock,logf,buffer) < 0 ) 
		{	
			printf ("Error al grabar write_multi\n");
			return -3;
		}
		return 1;
	}
	else /* Si no existe el directorio */
	{
		strcpy(buffer,"NO EXISTE DIRECTORIO \0");
		if (write_single(sock,logf,buffer) < 0 ) return -3;
  		return -1;
	}
}

/*---------------------------------------------------------------------------------*/
/*                               Ejecucion de programas                            */
/*---------------------------------------------------------------------------------*/
int ejecuta_tarea(int sock, FILE * logf, char * param) 
{
	char buffer [BUFFER_SIZE];
  	char command[BUFFER_SIZE];
  	char logs   [BUFFER_SIZE];
  	FILE * pipe = NULL;
	FILE * sh_ejecuta;
	char comandoshel[101];
	char comandomail[101];
	char comandoprg[301];
	char nom_archivo[50];
	if (Njobs < 0) Njobs = 0;
	if (Njobs > 20000) Njobs = 0;
	Njobs ++;
/* Realizamos el servicio solicitado  */
	memset(comandoprg, 0x00, sizeof(comandoprg));
	mid(LineaComando,1,296,comandoprg);
	memset(comandomail, 0x00, sizeof(comandomail));
	mid(LineaComando,297,100,comandomail);
	sprintf(nom_archivo,"sh_ejec_%d%d.sh",Njobs,getpid());
	
	sh_ejecuta=fopen(nom_archivo,"w");
	fprintf(sh_ejecuta,"%s\n",comandoprg);
    fprintf(sh_ejecuta," if [ ! $? =  0 ]\n");
	fprintf(sh_ejecuta," then\n");
	fprintf(sh_ejecuta,"     %s 1 \n",comandomail);
	fprintf(sh_ejecuta," else\n");
	fprintf(sh_ejecuta,"     %s 0 \n",comandomail);
	fprintf(sh_ejecuta," fi;\n\n");
	fprintf(sh_ejecuta," rm %s \n",nom_archivo);
	fprintf(sh_ejecuta," exit 0;\n");
	fclose(sh_ejecuta);

	sprintf(comandoshel,"ksh %s &",nom_archivo);
	system(comandoshel); 
	return 1;
}

/*---------------------------------------------------------------------------------*/
/*                       Ejecucion de comandos de consola                          */
/*---------------------------------------------------------------------------------*/
int ejec_comando(int sock, FILE * logf, char * param) 
{
	char buffer [BUFFER_SIZE];
  	char command[BUFFER_SIZE];
  	char logs   [BUFFER_SIZE];
  	FILE * pipe = NULL;
/* Realizamos el servicio solicitado */
  	sprintf(command, LineaComando, param );

/* Abrimos el pipe de comunicacion con el commando ejecutado */
  	if ( (pipe=popen(command,"r")) == NULL ) {
    	sprintf( logs, "Error creating pipe: %s\0", strerror(errno) );
    	log(logf, logs);
    	return -1; }
/* Decimos que comienza la transmision */
  	if ( write_begin (sock,logf) < 0 ) {
    	pclose( pipe );
    	return -2; }
  	for(;;)
  	{
    	if ( fgets(buffer, BUFFER_SIZE, pipe) == NULL ) break;
    	if ( write_multi(sock,logf,buffer) < 0 ) {
      		pclose( pipe );
      		return -3; }
  	} 
/* Decimos que termina la transmision */
  	if ( write_end (sock,logf) < 0 ) {
    	pclose( pipe );
    	return -4; }
/* Cerramos todo y nos vamos */
  	pclose(pipe);
  	return 1;
}


/*---------------------------------------------------------------------------------*/
/*           Revisa las colas de proceso con relacion a los subprocesos            */
/*---------------------------------------------------------------------------------*/
int ver_colas(int sock, FILE *logf, char *param)
{
    key_t key;
	char buffer[BUFFER_SIZE];
	char xbuffer[70],Id[20];
  	struct msqid_ds queue_ds;
    int datos;
    long i,msqid;
    message_buf  rbuf;

/*--->>> Busca el prefijo de las colas de mensajes <<<---*/
    sqlca.sqlcode=0;
    /* EXEC SQL 
    SELECT cod_param
    INTO  :mcod_prefcola
    FROM  sch_codigos
    WHERE cod_tipo   = 'PREFCOLAS' AND
		  fec_term   > SYSDATE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select cod_param into :b0  from sch_codigos where (cod_ti\
po='PREFCOLAS' and fec_term>SYSDATE)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )236;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)mcod_prefcola;
    sqlstm.sqhstl[0] = (unsigned long )3;
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



    fnMsgError("Select sch_codigos colas ",sqlca.sqlcode,0);

/*--->>> Rescata y crea el cursor de todos los subprocesos que utilicen colas <<<---*/
    sqlca.sqlcode=0;
/* EXEC SQL DECLARE Currelvproc cursor for
    SELECT a.cod_proc, a.cod_subpro, a.tip_ejecucion, a.gls_subproc
    FROM  sch_detalle_proc a, sch_secejec b  
    WHERE (a.ind_colas = 'S' OR a.ind_colas = 'X') AND
		  b.cod_proc   = a.cod_proc AND
		  b.cod_subpro = a.cod_subpro
	ORDER BY b.correl; */ 
 

    /* exec sql open Currelvproc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )255;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



fnMsgError("Open Cursor Currelvproc",sqlca.sqlcode,0);

/*--->>> Busca el primer registro */
    /* exec sql fetch Currelvproc into :mcod_proc, :mcod_subpro, :mtip_ejecucion, :mgls_subproc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )270;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)mcod_proc;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)mcod_subpro;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)mtip_ejecucion;
    sqlstm.sqhstl[2] = (unsigned long )10;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)mgls_subproc;
    sqlstm.sqhstl[3] = (unsigned long )30;
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


    
    fnMsgError("1 fetch Cursor Currelvproc",sqlca.sqlcode,0);
    if (sqlca.sqlcode != 0)
    {
        printf("No se registra informacion para el proceso %s\n",mcod_proc);
        exit(1);
    }

 /* Recorre todas las bases de cßlculo para todos los subprocesos */    
	strcpy(buffer,"#");
	while (sqlca.sqlcode != SqlNotFound)
    {
		trim(mcod_subpro,1,strlen(mcod_subpro),mcod_subpro);
		trim(mcod_prefcola,1,strlen(mcod_prefcola),mcod_prefcola);
		strcpy(Id, mcod_proc);
		strcat(Id, mcod_subpro);

		key = atoi(Id) + atoi(mcod_prefcola);
		if ((msqid = msgget(key, 0666)) >= 0) 
		{   
			i = msgctl(msqid, IPC_STAT, &queue_ds);
			sprintf(xbuffer,"%10s%10s%5s%30s%5d",mcod_proc, mcod_subpro, mtip_ejecucion, mgls_subproc, queue_ds.msg_qnum);
			strcat(buffer,xbuffer);
		}
		/* exec sql fetch Currelvproc into :mcod_proc, :mcod_subpro, :mtip_ejecucion, :mgls_subproc; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )301;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)mcod_proc;
  sqlstm.sqhstl[0] = (unsigned long )11;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)mcod_subpro;
  sqlstm.sqhstl[1] = (unsigned long )11;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)mtip_ejecucion;
  sqlstm.sqhstl[2] = (unsigned long )10;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)mgls_subproc;
  sqlstm.sqhstl[3] = (unsigned long )30;
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


                fnMsgError("2 fetch Cursor Currelvproc",sqlca.sqlcode,0);
    }
    
/* Revisa cola del scheduler */
	strcpy(mgls_subproc,"SCHEDULER");
	strcpy(mcod_proc,"0000000000");
	strcpy(mcod_subpro,"0000000000");
	strcpy(mtip_ejecucion,"11111");
	key = KEYCOLASCH;
	if ((msqid = msgget(key, 0666)) >= 0) 
	{   
		i = msgctl(msqid, IPC_STAT, &queue_ds);
		sprintf(xbuffer,"%10s%10s%5s%30s%5d",mcod_proc, mcod_subpro, mtip_ejecucion, mgls_subproc, queue_ds.msg_qnum);
		strcat(buffer,xbuffer);
	}
/*--->>> Graba buffer de salida <<<----*/
	strcat(buffer,"\0");
	if (write_single(sock,logf,buffer) < 0 ) 
	{	
		printf ("Error al grabar write_single\n");
		return -3;
	}
	return 1;
}
/*-------------------------------->>>>> SECCION HIJA, ATENCION DE REQUERIMIENTOS <<<----------------------------------*/
/*---------------------------------------------------------------------------------*/
/*           Atiende y revisa el protocolo de comunicacion con el cliente          */
/*---------------------------------------------------------------------------------*/
int attend( int sock, FILE * logf )
{
	char buffer  [BUFFER_SIZE];
	char command [BUFFER_SIZE];
	char param   [BUFFER_SIZE];
	char logs    [BUFFER_SIZE];
	char e_tarea [4];
	char accion;

	struct sockaddr_in server, client;
	int                sockO, newsock;
	int                socksize;
	FILE             * logfO = NULL;

	sockO = sock;
	logfO = logf;

/* Conexion con la base de datos */
	
	/* EXEC SQL CONNECT :uid IDENTIFIED BY :pwd; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )60;
 sqlstm.offset = (unsigned int  )332;
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


	sqlca.sqlcode = 0;
	
/* El protocolo de comunicacion es:___________________________________
|                                                                     |
|  El cliente pregunta con un comando + parametros.                   |
|  Formato: COMANDO+PARAM_1|PARAM_2|...|PARAM_N						  |	
|                                                                     |
|  El servidor responde con OK + respuesta o ERROR + mensaje.         | 
|  Formato: OK|RESP_1|RESP_2|...|RESP_N                               |
|           ERROR|MENSAJE                                             |
|                                                                     |
|  En la respuesta del servidor cada grupo de palabras comienza con   |
|  #BEGIN# y termina con #END#                                        |
|																	  |	
|  La secuencia es:                                                   |
|  Cliente pregunta (1 linea) y servidor responde (n lineas).         | 
|_ Enviamos al cliente una se±al para que comienze a hablar __________| */


/* Iniciamos un ciclo en el cual se atenderßn las peticiones del cliente*/
  	for(;;)
  	{
    	if (read_single(sock,logf,command,param) < 0 ) return -2;
        mid(command,1,4,e_tarea);
		switch (trad_protocolo(e_tarea))
		{
		case ACTI:
				    if (ver_consola(sock,logf,param) < 0) return -10;
					break;
		case EJEC: 
				    mid(command,5,strlen(command),LineaComando);
				    if (ejecuta_tarea(sock,logf,param) < 0 ) return -10; 
			        break;
		case COMD: 
				    mid(command,5,strlen(command),LineaComando);
				    if (ejec_comando(sock,logf,LineaComando) < 0 ) return -10; 
                    break;
		case VCOL:
				    if (ver_colas(sock,logf,param) < 0) return -10;
					break;
		case MCPU:
				    if (ver_memcpu(sock,logf,param) < 0) return -10;
					break;
		case SALE:  
			        return 1;
					break;
		default:
				    sprintf(buffer, "ERROR|Comando no conocido: (%s,%s)\0", command,param);
				    if (write_single(sock,logf,buffer) < 0 ) return -3; 
                    break;
		}
  	}
}



/*------------------------------------------>>>>> PROGRAMA PRINCIPAL  <<<--------------------------------------------*/
int main( int argc, char **argv ) 
{
	struct sockaddr_in server, client;
	int                sock, newsock;
	int                socksize;
	FILE              *logf = NULL;
	char               logs[BUFFER_SIZE];
	int				   i;
/* Verificacion de parametros */
	if ( argc < 4 ) 
	{
		fprintf(stderr, "El programa requiere parametros (puerto, usuario BD, password BD [Archivo de log]\n");
		return -1;
	}
	printf("Parametros ingresados \n");
	printf("----------------------\n");
	for (i=0;i<argc;i++)
		printf("Argumento %d: %s\n",i,argv[i]);
	printf("----------------------\n");
	strcpy(uid,argv[2]);
	strcpy(pwd,argv[3]);
	
/* Preparamos el log */
	logf = stdout;
	fflush( stdout );

  /* Creamos el socket de escucha */
	if ( (sock = socket(PF_INET, SOCK_STREAM,0)) < 0 ) 
	{
		perror( "Error creating socket" );
		printf("[SCH:Error]\n");
		return -1;
	}

  /* Construimos la direccin del servidor */
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(atoi(argv[1]) );
  /* Conectamos el socket a la direccin */
	if ( (bind(sock, (struct sockaddr *)&server, sizeof(server))) < 0) 
	{
		if (errno==125)
		{
			printf("[SCH:Ocupado]\n");
		}
		else
		{
		perror("Error binding socket");
			printf("[SCH:Error]\n");
		}
		close( sock );
		return -1;
	}

	/* Escuchamos por el socket */
	if ( listen(sock, MAX_PENDING) < 0 ) 
	{
		perror("Error listening socket");
		printf("[SCH:Error]\n");
		close( sock );
		return -1;
	}

	/* Ignoramos las se±ales de mis hijos */
	signal( SIGCHLD, SIG_IGN );
	for(;;) 
	{
		socksize = sizeof( client );
		/* Esperamos por alguna conexin */
		if ( (newsock = accept(sock, (struct sockaddr *)&client, &socksize)) < 0) 
		{
			/* Si hay problemas en la coneccion las ignoro y sigo esperando
			// Si fui interrumpido por una se±al de un hijo muerto, las ignoro */
			continue;
		}
		switch(fork())
		{
		/* No pudimos crear hijo */
		case -1:
			/*/ Si hay problemas al crear el proceso los ignoro y sigo esperando
			//////////////////// LOG //////////////////*/
			sprintf( logs, "Error al crear proceso hijo: %s\0", strerror(errno) );
			log( logf, logs );
			/*/////////////////// LOG ///////////////////*/
			break;
			/* El hijo se creo bien */
		case  0:
			close(sock);
			/*/////////////////// LOG ///////////////////*/
			if ( attend(newsock,logf) > 0 ) 
			{
				close(newsock);
				exit(1);
			}
			else 
			{
				close(newsock);
				exit(0);
			}
		/*/ Soy el padre */
		default:
			close(newsock);
			break;
		}
	}
}
