
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
    "./pc/exe_batch.pc"
};


static unsigned int sqlctx = 6915275;


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

 static char *sq0010 = 
"select a.cod_proc ,a.cod_subpro ,a.nom_proc ,b.nom_script ,d.nom_ejecu ,b.no\
m_log ,d.flg_forma_ejec ,e.nom_base ,e.nom_user ,e.nom_pass ,a.cod_central ,DE\
CODE(d.log_gener,null ,'N',d.log_gener) ,d.flg_1  from sch_profile a ,sch_deta\
lle_proc b ,sch_proceso d ,acc_aplicacion e where (((((((((a.cod_proc=b.cod_pr\
oc and a.cod_subpro=b.cod_subpro) and d.cod_proc=b.cod_proc) and d.flg_batch='\
B') and a.cod_estado='EMPT') and d.cod_apli=e.cod_apli) and a.fec_ini<=SYSDATE\
) and b.fec_term>SYSDATE) and d.fec_term>SYSDATE) and a.cod_proc not  in (sele\
ct cod_proc  from sch_profile where cod_estado<>'EMPT')) order by a.cod_proc,a\
.correl            ";

 static char *sq0027 = 
"select a.cod_proc ,a.cod_subpro ,a.nom_proc ,TO_CHAR(b.fec_ejec_ini,'yyyymmd\
dhh24miss') ,DECODE(b. interval ,null ,0,b. interval ) ,DECODE(b.cod_interv,nu\
ll ,' ',b.cod_interv) ,DECODE(b.dia_semana,null ,' ',b.dia_semana) ,DECODE(a.n\
um_jobs,null ,0,a.num_jobs) ,DECODE(b.hor_fini,null ,'N',TO_CHAR(b.hor_fini,'H\
H24MI')) ,DECODE(b.hor_fter,null ,'N',TO_CHAR(b.hor_fter,'HH24MI'))  from sch_\
profile a ,sch_proceso b where ((a.flg_batch='B' and b.cod_proc=a.cod_proc) an\
d a.cod_estado='STOP')           ";

 static char *sq0031 = 
"select e.cod_proc ,e.cod_subpro ,e.num_jobs ,e.cod_central ,e.tip_ejecucion \
 from sch_condicion d ,sch_profile e where (((((d.cod_proc=:b0 and d.cod_subpr\
o=:b1) and e.cod_proc=d.cod_procrest) and e.cod_subpro=d.cod_sprocres) and e.c\
od_estado='PAUSX') and d.flg_condact='A')           ";

 static char *sq0051 = 
"select Cod_arch ,Nom_arch ,Path  from sch_archivos where cod_tipo='5'       \
    ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,141,0,4,218,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,97,0,0,1,97,0,0,
36,0,0,2,85,0,5,245,0,0,3,3,0,1,0,1,4,0,0,1,97,0,0,1,97,0,0,
63,0,0,3,0,0,29,251,0,0,0,0,0,1,0,
78,0,0,4,85,0,5,267,0,0,3,3,0,1,0,1,4,0,0,1,97,0,0,1,97,0,0,
105,0,0,5,0,0,29,273,0,0,0,0,0,1,0,
120,0,0,6,0,0,29,298,0,0,0,0,0,1,0,
135,0,0,7,37,0,6,337,0,0,0,0,0,1,0,
150,0,0,8,0,0,31,344,0,0,0,0,0,1,0,
165,0,0,9,0,0,29,349,0,0,0,0,0,1,0,
180,0,0,10,641,0,9,408,0,0,0,0,0,1,0,
195,0,0,10,0,0,13,411,0,0,13,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
262,0,0,11,120,0,5,450,0,0,0,0,0,1,0,
277,0,0,12,0,0,29,456,0,0,0,0,0,1,0,
292,0,0,13,95,0,4,462,0,0,3,1,0,1,0,2,5,0,0,2,5,0,0,1,5,0,0,
319,0,0,10,0,0,13,475,0,0,13,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
386,0,0,14,107,0,4,482,0,0,1,0,0,1,0,2,3,0,0,
405,0,0,10,0,0,13,503,0,0,13,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
472,0,0,15,99,0,5,510,0,0,1,1,0,1,0,1,5,0,0,
491,0,0,16,0,0,29,517,0,0,0,0,0,1,0,
506,0,0,17,139,0,5,522,0,0,4,4,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
537,0,0,18,0,0,29,530,0,0,0,0,0,1,0,
552,0,0,19,138,0,6,534,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
583,0,0,20,0,0,29,542,0,0,0,0,0,1,0,
598,0,0,21,83,0,4,547,0,0,3,2,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,
625,0,0,10,0,0,13,570,0,0,13,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
692,0,0,10,0,0,15,573,0,0,0,0,0,1,0,
707,0,0,22,120,0,5,582,0,0,0,0,0,1,0,
722,0,0,23,0,0,29,588,0,0,0,0,0,1,0,
737,0,0,24,107,0,4,590,0,0,1,0,0,1,0,2,3,0,0,
756,0,0,25,301,0,4,610,0,0,4,3,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
787,0,0,26,280,0,4,629,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
814,0,0,27,499,0,9,695,0,0,0,0,0,1,0,
829,0,0,27,0,0,13,697,0,0,10,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,
5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
884,0,0,28,252,0,4,709,0,0,6,5,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
3,0,0,
923,0,0,29,166,0,6,730,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,
950,0,0,30,0,0,29,738,0,0,0,0,0,1,0,
965,0,0,31,284,0,9,756,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
988,0,0,31,0,0,13,758,0,0,5,0,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
1023,0,0,32,103,0,5,770,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,
1050,0,0,33,224,0,6,780,0,0,6,6,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,
1089,0,0,34,0,0,29,789,0,0,0,0,0,1,0,
1104,0,0,31,0,0,13,794,0,0,5,0,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
1139,0,0,31,0,0,15,796,0,0,0,0,0,1,0,
1154,0,0,35,66,0,4,805,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
1177,0,0,36,103,0,5,848,0,0,3,3,0,1,0,1,4,0,0,1,5,0,0,1,5,0,0,
1204,0,0,37,0,0,29,856,0,0,0,0,0,1,0,
1219,0,0,38,176,0,4,863,0,0,5,2,0,1,0,2,97,0,0,2,5,0,0,2,5,0,0,1,5,0,0,1,5,0,0,
1254,0,0,39,103,0,5,872,0,0,3,3,0,1,0,1,4,0,0,1,5,0,0,1,5,0,0,
1281,0,0,40,0,0,29,880,0,0,0,0,0,1,0,
1296,0,0,27,0,0,13,884,0,0,10,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
1351,0,0,27,0,0,15,887,0,0,0,0,0,1,0,
1366,0,0,41,147,0,2,891,0,0,0,0,0,1,0,
1381,0,0,42,0,0,29,898,0,0,0,0,0,1,0,
1396,0,0,43,0,0,27,955,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,10,0,0,1,10,0,0,
1427,0,0,44,0,0,32,971,0,0,0,0,0,1,0,
1442,0,0,45,0,0,31,991,0,0,0,0,0,1,0,
1457,0,0,46,116,0,5,1003,0,0,4,4,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1488,0,0,47,115,0,5,1013,0,0,5,5,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1523,0,0,48,0,0,29,1022,0,0,0,0,0,1,0,
1538,0,0,49,87,0,2,1031,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,
1565,0,0,50,0,0,29,1038,0,0,0,0,0,1,0,
1580,0,0,51,80,0,9,1059,0,0,0,0,0,1,0,
1595,0,0,51,0,0,13,1060,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,
1622,0,0,51,0,0,13,1085,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,
};


/*---------------------------------------------------------------------------------*/
/*EJECUCION DE PROCESOS BATCH													   */
/*---------------------------------------------------------------------------------*/
/*PROGRAMA           : exe_batch.cpp											   */
/*OBJETIVO           : Ejecutar programas Batch									   */
/*AUTOR              : Claudio Conejero											   */
/*---------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------*/
/*DECLARACION DE BIBLIOTECA														   */
/*---------------------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sqlcpr.h>
#include <scheduler.h>
/*************************************
 Declaracion de Constantes
*************************************/
#define  LOOP			  1
#define  FACTOR_MINUTO	  0.000694444
#define  FACTOR_SEGUNDO	  0.000011574
#define  true             1
#define  false            0
#define  SqlNotFound      1403
#define  SqlNull          1405
#define  SqlORADUP        1
#define  SqlOk            0
#define  SQLORA_NULL      -1
#define  SQLMANYROWS      2112
#define  and              &&
#define  or               ||
#define  NE               !=
#define  blanco           32
/*---------------------------------------------------------------------------------*/

void carga_procesos_en_profile(void);
void ejecuta_procesos_batch(void);
void termina_procesos_detenidos(void);
void EjecutarShell(char *);
int exe_batch(void);
int fnflee_sch_profile(void);
void fnMarca_Inicio_Programa(void);
void fnBorra_sch_profile(void);
void Recupera_Servicios(void);
/*************************************/
/*  Declaracion de Variables Host    */
/*************************************/
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

/* exec oracle option (MAXOPENCURSORS=60); */ 
 

/*---------------------------------------------------------------------------------*/
/*DECLARACION DE VARIABLES GLOBALES												   */
/*---------------------------------------------------------------------------------*/
int diferencia, c, retorno, k, okfn;
char *flg_pend, *comando, *grupo_tmp;
char codlog[11];
char finpaso[100];
char fincom[100];
char comsys[100];
char szMsg[30];
char NomPrgMail[31];               
char PathMail[150];                
char NomPrgCond[31];               
char PathCond[150];                
char path_colas[150];
char prg_colas[11];
char path_log[150];					
/*---------------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------------*/
/*DECLARACION DE VARIABLES														   */
/*---------------------------------------------------------------------------------*/
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

 char szhUsername[30];				/* EXEC SQL var szhUsername is string(30); */ 

 char szhPassword[30]; 				/* EXEC SQL var szhPassword is string(30); */ 

 char szhConexionBase[30];			/* EXEC SQL var szhConexionBase is string(30); */ 

 /*Inicializacin de Variables.													   */
 char nom_proc_start[30];           /* EXEC SQL var nom_proc_start is string(30); */ 

 long int interv;					/* Intervalo de Ejecucin del Proceso BATCH.	*/
 char mfec_paso[20];				/* EXEC SQL var mfec_paso is string(20); */ 

 char mhor_ini[6];                  /* EXEC SQL var mhor_ini is string(6); */ 

 char FechaActual[30];              /* EXEC SQL var FechaActual is string(30); */ 

 char nombre_dia[10];
 double minutos;
 double tot_minutos;
 double tot_segundos;
 char cod_int[10];					/* EXEC SQL var cod_int is string(10); */ 

 long int sec;						/* Secuencia de SCH_CODIGOS del proceso y subproceso.*/
 char fejec[10];					/* EXEC SQL var fejec is string(10); */ 

 char fn_nom_arch[20];				/* EXEC SQL var fn_nom_arch is string(20); */ 

 char fn_path[50];					/* EXEC SQL var fn_path is string(50); */ 

 char *sqlcmd;
 long int pcuenta;
 /* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------------*/
/* Parametros del monitor                                                          */
/*---------------------------------------------------------------------------------*/
char szhsch_proceso[11];              /* EXEC SQL var szhsch_proceso    is string(11); */ 

char szhsch_subproceso[11];           /* EXEC SQL var szhsch_subproceso is string(11); */ 

char szhmodulo[6];                    /* EXEC SQL var szhmodulo         is string(6); */ 

char szhsch_estado[11];               /* EXEC SQL var szhsch_estado     is string(11); */ 

long lhpid;
int  ihcod_estado;
char szhfec_ini[15];                  /* EXEC SQL var szhfec_ini        is string(15); */ 

short ihdc1;

/************************************************************/
/* Funcion    :trim                                         */
/* Objetivo   :                                             */
/************************************************************/
trim(szpalabra,iini,ilargo,szvuelta)
char *szpalabra;
int iini;
int ilargo;
char *szvuelta;
{
    int ii,icr;
    szpalabra += iini - 1;
    for (ii=iini;ii<=(iini + ilargo -1);ii++)
    {
        if (*szpalabra NE blanco)
           {
           *szvuelta = *szpalabra;
           szvuelta++;
           }
        szpalabra++;
    }
   *szvuelta = 0;
}
/************************************************************/
/* Funcion    : mid                                         */
/* Objetivo   :                                             */
/************************************************************/
mid(szpalabra,iini,ilargo,szvuelta)
char *szpalabra;
int iini;
int ilargo;
char *szvuelta;
{
    int ii,icr;
    icr = true;
    if (ilargo < 0)
       {
       ilargo *= -1;
       icr = false;
       }
    szpalabra += iini - 1;
    for (ii=iini;ii<=(iini + ilargo -1);ii++)
    {
        *szvuelta = *szpalabra;
        szvuelta++;szpalabra++;
    }

  if (icr)
   *szvuelta = 0;
}
/*---------------------------------------------------------------------------------*/
/* Revisa si el dia de la semana se encvuentra habilitado en el vector dia_semana  */
/*---------------------------------------------------------------------------------*/
int revisa_dia(char nombre_dia[10], char dia_sem[7])
{
	int ndia=1,dia_ini;
	char ejecuta[1];
	trim(nombre_dia,1,strlen(nombre_dia),nombre_dia);
	if ((strcmp(nombre_dia,"LUNES") == 0) || (strcmp(nombre_dia,"MONDAY") == 0)) 
		ndia = 1;
	else
    if ((strcmp(nombre_dia,"MARTES") == 0) || (strcmp(nombre_dia,"TUESDAY") == 0)) 
		ndia = 2;
	else
    if ((strcmp(nombre_dia,"MI–RCOLES") == 0) || (strcmp(nombre_dia,"WEDNESDAY") == 0)) 
		ndia = 3; 
	else
    if ((strcmp(nombre_dia,"JUEVES")== 0) || (strcmp(nombre_dia,"THURSDAY") == 0)) 
		ndia = 4;
	else
    if ((strcmp(nombre_dia,"VIERNES") == 0) || (strcmp(nombre_dia,"FRIDAY") == 0)) 
		ndia = 5;
	else
    if ((strcmp(nombre_dia,"S¬BADO") == 0) || (strcmp(nombre_dia,"SATURDAY") == 0)) 
		ndia = 6;
	else
    if ((strcmp(nombre_dia,"DOMINGO") == 0) || (strcmp(nombre_dia,"SUNDAY") == 0)) 
		ndia = 7;

	dia_ini = ndia;
	mid(dia_sem,ndia,1,ejecuta);
	if (strcmp(ejecuta,"S") == 0)
	{
		return(1);
	}
	else
	{
		minutos=0;
		do
		{
			minutos += 1 * 60 * 24 * FACTOR_MINUTO;
			if (ndia == 7)
				ndia = 1; 
			else 
				ndia ++;

			mid(dia_sem,ndia,1,ejecuta);
		}
		while (strcmp(ejecuta,"S") != 0);
		return(0);
	}
}

void revisa_hora_ejecucion(char *mcod_proc, char *mcod_subpro,char *mhor_fini, char *mhor_fter)
{

	int hh_e;
	int hh_i;
	char paso[2];

	/* EXEC SQL
	SELECT TO_CHAR(fec_ini,'HH24MI'), TO_CHAR(fec_ini,'dd/mm/yyyy HH24MI')
	INTO   :mhor_ini, :mfec_paso
	FROM	sch_profile
	WHERE  cod_proc		= :mcod_proc   and
	       cod_subpro	= :mcod_subpro; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(fec_ini,'HH24MI') ,TO_CHAR(fec_ini,'dd/mm/yyy\
y HH24MI') into :b0,:b1  from sch_profile where (cod_proc=:b2 and cod_subpro=:\
b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)mhor_ini;
 sqlstm.sqhstl[0] = (unsigned long )6;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)mfec_paso;
 sqlstm.sqhstl[1] = (unsigned long )20;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)mcod_proc;
 sqlstm.sqhstl[2] = (unsigned long )0;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)mcod_subpro;
 sqlstm.sqhstl[3] = (unsigned long )0;
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


	
	fnMsgError(szMsg, sqlca.sqlcode, false); /*ETS 19/04/2004*/
	mid(mhor_ini,1,2,paso);
	hh_i = atoi(paso) * 60;

	mid(mhor_ini,3,2,paso);
	hh_i += atoi(paso);

	if (strcmp(mhor_fini,"N") != 0)
	{
		if (atoi(mhor_ini) < atoi(mhor_fini)) 
		{
			mid(mhor_fini,1,2,paso);
			hh_e = atoi(paso) * 60;
			mid(mhor_fini,3,2,paso);
			hh_e += atoi(paso);

			interv = hh_e - hh_i;
			minutos = interv * FACTOR_MINUTO;

			sqlca.sqlcode = 0;
			/* EXEC SQL
			UPDATE sch_profile
			SET fec_ini = fec_ini + :minutos
			WHERE  cod_proc = :mcod_proc   AND
				cod_subpro  = :mcod_subpro; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update sch_profile  set fec_ini=(fec_ini+:b0) where (cod_p\
roc=:b1 and cod_subpro=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )36;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&minutos;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)mcod_proc;
   sqlstm.sqhstl[1] = (unsigned long )0;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)mcod_subpro;
   sqlstm.sqhstl[2] = (unsigned long )0;
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


			fnMsgError(szMsg, sqlca.sqlcode, false);
			/* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )63;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



		}
		else
		{
			if (atoi(mhor_ini) > atoi(mhor_fter))
			{
				mid(mhor_fter,1,2,paso);
				hh_e = atoi(paso) * 60;
				mid(mhor_fter,3,2,paso);
				hh_e += atoi(paso);

				interv = (hh_i - hh_e) + 2 ;
				minutos = interv * FACTOR_MINUTO;

				sqlca.sqlcode = 0;
				/* EXEC SQL
				UPDATE sch_profile
				SET fec_ini	= fec_ini - :minutos
				WHERE  cod_proc	= :mcod_proc   AND
					 cod_subpro	= :mcod_subpro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update sch_profile  set fec_ini=(fec_ini-:b0) where (cod_\
proc=:b1 and cod_subpro=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )78;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&minutos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)mcod_proc;
    sqlstm.sqhstl[1] = (unsigned long )0;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)mcod_subpro;
    sqlstm.sqhstl[2] = (unsigned long )0;
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


				fnMsgError(szMsg, sqlca.sqlcode, false);
				/* EXEC SQL commit; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )105;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


			}	
		}
	}
}



/*---------------------------------------------------------------------------------*/
/*Demonio de Ejecucin de Procesos Batch										   */
/*---------------------------------------------------------------------------------*/

int exe_batch()
{
 int swprocese;
 /*Inicializacin de Variables													   */
 sqlca.sqlcode = 0;
 /* Asignacion de Memoria */
 sqlcmd	= (char *) malloc(sizeof(char) * 2000);
 if (sqlca.sqlcode != 0 && sqlca.sqlcode != 100) {
     /*EXEC SQL rollback;*/
     printf("!!! ERROR SQL CODE:(%d)\n", sqlca.sqlcode);
 	 fflush(stdout);
     return (1);
    }
 /* EXEC SQL commit; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )120;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 signal(SIGUSR1,senal_pausa);
 signal(SIGUSR2,senal_terminar);
 signal(SIGCONT,senal_continue);

 while (!SENAL_STOP)
 {
	Recupera_Servicios();
   /*---------------------------------------------------------------------------------*/
   /*Prepara la informacin de los procesos batch que se ejecutarﬂn en forma posterior*/
   /*---------------------------------------------------------------------------------*/
	carga_procesos_en_profile();
   /*---------------------------------------------------------------------------------*/
   /*Prepara la informacin de los procesos batch que se ejecutarﬂn en forma posterior*/
   /*---------------------------------------------------------------------------------*/
	ejecuta_procesos_batch();
   /*---------------------------------------------------------------------------------*/
   /*Detecta los procesos terminados, ejecuta los procesos con restriccin y          */
   /*reinicializa el proceso para su prxima ejecucin.                               */
   /*---------------------------------------------------------------------------------*/
   termina_procesos_detenidos();
   ejecuta_accion();
   sleep(1);
 }
 fnBorra_sch_profile();
 return(0);
}

/*---------------------------------------------------------------------------------*/
/*Prepara la informacin de los procesos batch que se ejecutarﬂn en forma posterior*/
/*---------------------------------------------------------------------------------*/
void carga_procesos_en_profile()
{
 /*--------------------------------------------------------------------*/
 /* Recuperacin de informacin de Procesos y Sub-procesos a ejecutar. */
 /*--------------------------------------------------------------------*/
 /*Determinar procesos batch a ejecutar e insertarlos en la tabla SCH_PROFILE.			   */

 /* EXEC SQL execute 
   BEGIN
       PRO_INS_SCH_PROFILE();
   END;
 END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin PRO_INS_SCH_PROFILE ( ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )135;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 if (sqlca.sqlcode != 0) {
	 /* EXEC SQL rollback; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )150;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	 printf("!!! ERROR al insertar procesos en la tabla ejecutar. (%d)\n", sqlca.sqlcode);
	 fflush(stdout);
	 return;
    }
 /* EXEC SQL commit; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )165;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



 return;
}
/*---------------------------------------------------------------------------------*/
/*Prepara la informacin de los procesos batch que se ejecutarﬂn en forma posterior*/
/*---------------------------------------------------------------------------------*/
void ejecuta_procesos_batch()
{
/*---------------------------------------------------------------------------------*/
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char cod_central_start[10];		/* EXEC SQL var cod_central_start is string(10); */ 

	char cod_proc_start[10];		/* EXEC SQL var cod_proc_start is string(10); */ 

	char cod_subpro_start[10];		/* EXEC SQL var cod_subpro_start is string(10); */ 

	char log_gener_start[150];	    /* EXEC SQL var log_gener_start is string(150); */ 

	char nom_log[20];				/* EXEC SQL var nom_log is string(20); */ 

	char nom_scr[30];				/* EXEC SQL var nom_scr is string(30); */ 

	char path_scr[150];				/* EXEC SQL var path_scr is string(150); */ 

	char nombase[20];				/* EXEC SQL var nombase is string(20); */ 

	char nomuser[20];				/* EXEC SQL var nomuser is string(20); */ 

	char nompass[20];				/* EXEC SQL var nompass is string(20); */ 

	char Flg_1[2];					/* EXEC SQL var Flg_1 is string(2); */ 

	char Esp_Argv[500];				/* EXEC SQL var Esp_Argv is string(500); */ 
 
	/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------------*/
	
	/*------------------------------*/
	/* Ejecucin de Procesos Batch. */
	/*------------------------------*/
	int ex;
	char proc_bloq[21];
	char proc_ant[21];
	char shell_name[20];
	FILE *cmd;
	/*Inicializamos Variables													   */
	ex = 1;
	memset(proc_ant, 0x00, sizeof(proc_ant));
	/*Determinar los procesos a ejecutar de la tabla SCH_PROFILE.				   */
	sqlca.sqlcode = 0;
	/* EXEC SQL declare CurProcBatch cursor for
		select a.cod_proc, a.cod_subpro, a.nom_proc, b.nom_script,	d.nom_ejecu, 
		       b.nom_log, d.flg_forma_ejec, e.nom_base, e.nom_user, e.nom_pass, a.cod_central, 
		       DECODE(d.log_gener,NULL,'N',d.log_gener), d.flg_1  
		from sch_profile        a,
		       sch_detalle_proc	b,
		       sch_proceso	d,
		       acc_aplicacion   e
		where a.cod_proc	  = b.cod_proc			
		and   a.cod_subpro	  = b.cod_subpro		
		and   d.cod_proc          = b.cod_proc			
		and   d.flg_batch	  = 'B'				
		and   a.cod_estado	  = 'EMPT'				
		and   d.cod_apli          = e.cod_apli         
		and   a.fec_ini	         <= SYSDATE            
		and   b.fec_term          > SYSDATE				
		and   d.fec_term          > SYSDATE				
		and   a.cod_proc not in (select cod_proc from sch_profile where cod_estado <> 'EMPT') 
		 order by a.cod_proc, a.correl; */ 

		 
	/* EXEC SQL open CurProcBatch; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0010;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )180;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (sqlca.sqlcode != SqlNotFound)
	{
	/* EXEC SQL fetch CurProcBatch into :cod_proc_start, :cod_subpro_start, :nom_proc_start, :nom_scr, :path_scr, 
		:nom_log, :fejec, :nombase, :nomuser, :nompass, :cod_central_start, :log_gener_start, :Flg_1; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )195;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_start;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_start;
 sqlstm.sqhstl[1] = (unsigned long )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)nom_proc_start;
 sqlstm.sqhstl[2] = (unsigned long )30;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)nom_scr;
 sqlstm.sqhstl[3] = (unsigned long )30;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)path_scr;
 sqlstm.sqhstl[4] = (unsigned long )150;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)nom_log;
 sqlstm.sqhstl[5] = (unsigned long )20;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)fejec;
 sqlstm.sqhstl[6] = (unsigned long )10;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)nombase;
 sqlstm.sqhstl[7] = (unsigned long )20;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)nomuser;
 sqlstm.sqhstl[8] = (unsigned long )20;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)nompass;
 sqlstm.sqhstl[9] = (unsigned long )20;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)cod_central_start;
 sqlstm.sqhstl[10] = (unsigned long )10;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)log_gener_start;
 sqlstm.sqhstl[11] = (unsigned long )150;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)Flg_1;
 sqlstm.sqhstl[12] = (unsigned long )2;
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


	 fnMsgError(szMsg, sqlca.sqlcode, false);
	}
	/* Para cada SubProceso a ejecutar... */
	while (sqlca.sqlcode != SqlNotFound)
	{		 
		trim(cod_proc_start, 1, strlen(cod_proc_start), cod_proc_start);
		trim(cod_subpro_start, 1, strlen(cod_subpro_start), cod_subpro_start);
		trim(nom_scr, 1, strlen(nom_scr), nom_scr);
		trim(path_scr, 1, strlen(path_scr), path_scr);
		trim(nom_log, 1, strlen(nom_log), nom_log);
		trim(fejec, 1, strlen(fejec), fejec);
		
                trim(nombase, 1, strlen(nombase), nombase);
		trim(nomuser, 1, strlen(nomuser), nomuser);
		trim(nompass, 1, strlen(nompass), nompass);
		trim(cod_central_start, 1, strlen(cod_central_start), cod_central_start);
		trim(log_gener_start,1,strlen(log_gener_start),log_gener_start);
		
                trim(Flg_1, 1, strlen(Flg_1), Flg_1);

		if (strncmp(Flg_1, "N", 1) == 0)
		{
			strcpy(nombase, " ");
		}		
		
		if (strcmp(proc_ant, cod_proc_start) != 0) 
		{
			strcpy(proc_ant, cod_proc_start);
			trim(proc_ant,1,strlen(proc_ant),proc_ant);
			if (ex==0)
			{
				fprintf(cmd,"rm sh_batch_%d.sh \n",sec); 
				fclose(cmd);      /* cerramos el archivo para poder ejecutarlo */
				strcpy(codlog,proc_ant); 
				EjecutarShell(shell_name); /* Ejecuta Shell con todos los SubProcesos, del proceso actual. */

				/*Incrementamos el Secuencial actual desde SCH_CODIGOS	*/
				/* EXEC SQL 
					update sch_codigos
					set	gls_param = to_char(to_number(gls_param) + 1)
					where cod_tipo  = 'CORRELATIV' and
						  cod_param = 'NUMJOB'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update sch_codigos  set gls_param=to_char((to_number(gls_\
param)+1)) where (cod_tipo='CORRELATIV' and cod_param='NUMJOB')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )262;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


				fnMsgError(szMsg, sqlca.sqlcode, false);
				/* EXEC SQL commit; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
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


				ex = 1;
			}
			/***** Busca Funcion Condicional **********/
			memset(proc_bloq, 0x00, sizeof(proc_bloq));
			sqlca.sqlcode = 0;
			/* EXEC SQL 
				select nom_arch, path  
				  into :fn_nom_arch, :fn_path
				  from sch_archivos   
				 where cod_arch	= :cod_proc_start and fec_term > SYSDATE; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select nom_arch ,path into :b0,:b1  from sch_archivos wher\
e (cod_arch=:b2 and fec_term>SYSDATE)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )292;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)fn_nom_arch;
   sqlstm.sqhstl[0] = (unsigned long )20;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)fn_path;
   sqlstm.sqhstl[1] = (unsigned long )50;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)cod_proc_start;
   sqlstm.sqhstl[2] = (unsigned long )10;
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
				sprintf(comsys, "%s/%s %s u%s/%s \n", fn_path, fn_nom_arch, cod_proc_start, nomuser, nompass);
				printf("comsys [%s]\n",comsys);
				if (system(comsys)) 
				{
					 strcpy(proc_bloq,cod_proc_start);
					 trim(proc_bloq,1,strlen(proc_bloq),proc_bloq);
  					 /* EXEC SQL fetch CurProcBatch into :cod_proc_start, :cod_subpro_start, :nom_proc_start, :nom_scr, :path_scr, 
						:nom_log, :fejec, :nombase, :nomuser, :nompass, :cod_central_start, :log_gener_start, :Flg_1; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )319;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_start;
        sqlstm.sqhstl[0] = (unsigned long )10;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_start;
        sqlstm.sqhstl[1] = (unsigned long )10;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)nom_proc_start;
        sqlstm.sqhstl[2] = (unsigned long )30;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)nom_scr;
        sqlstm.sqhstl[3] = (unsigned long )30;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)path_scr;
        sqlstm.sqhstl[4] = (unsigned long )150;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)nom_log;
        sqlstm.sqhstl[5] = (unsigned long )20;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)fejec;
        sqlstm.sqhstl[6] = (unsigned long )10;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)nombase;
        sqlstm.sqhstl[7] = (unsigned long )20;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)nomuser;
        sqlstm.sqhstl[8] = (unsigned long )20;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)nompass;
        sqlstm.sqhstl[9] = (unsigned long )20;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)cod_central_start;
        sqlstm.sqhstl[10] = (unsigned long )10;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)log_gener_start;
        sqlstm.sqhstl[11] = (unsigned long )150;
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)Flg_1;
        sqlstm.sqhstl[12] = (unsigned long )2;
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


					 continue;
				}
			}
			 /******** Recuperamos el Secuencial actual desde SCH_CODIGOS	*/
			sqlca.sqlcode = 0;
			/* EXEC SQL 
			select to_number(gls_param)
			  into :sec
			  from sch_codigos
			where cod_tipo  = 'CORRELATIV' and
				  cod_param = 'NUMJOB'; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select to_number(gls_param) into :b0  from sch_codigos whe\
re (cod_tipo='CORRELATIV' and cod_param='NUMJOB')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )386;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&sec;
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


			/******** Preparamos el nombre de siguiente shell a ejecutar			 */
			memset(shell_name, 0x00, sizeof(shell_name));
			sprintf(shell_name, "sh_batch_%d.sh", sec);
			/******** Abrimos el archivo para escribir... */
			cmd = fopen(shell_name, "w");
			if (cmd == NULL)
			{
				 printf("Error al abrir el archivo : <%s>\n", shell_name);
				 fflush(stdout);
				 return;
			}
			ex = 0;
		}
		if (strcmp(cod_proc_start,proc_bloq)==0)
		{
			/* EXEC SQL fetch CurProcBatch into :cod_proc_start, :cod_subpro_start, :nom_proc_start, :nom_scr, :path_scr, 
				:nom_log, :fejec, :nombase, :nomuser, :nompass, :cod_central_start, :log_gener_start, :Flg_1; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )405;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_start;
   sqlstm.sqhstl[0] = (unsigned long )10;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_start;
   sqlstm.sqhstl[1] = (unsigned long )10;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)nom_proc_start;
   sqlstm.sqhstl[2] = (unsigned long )30;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)nom_scr;
   sqlstm.sqhstl[3] = (unsigned long )30;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)path_scr;
   sqlstm.sqhstl[4] = (unsigned long )150;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)nom_log;
   sqlstm.sqhstl[5] = (unsigned long )20;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)fejec;
   sqlstm.sqhstl[6] = (unsigned long )10;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)nombase;
   sqlstm.sqhstl[7] = (unsigned long )20;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)nomuser;
   sqlstm.sqhstl[8] = (unsigned long )20;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)nompass;
   sqlstm.sqhstl[9] = (unsigned long )20;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)cod_central_start;
   sqlstm.sqhstl[10] = (unsigned long )10;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)log_gener_start;
   sqlstm.sqhstl[11] = (unsigned long )150;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)Flg_1;
   sqlstm.sqhstl[12] = (unsigned long )2;
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


			continue;
		}
		/*Si la ejecucin de este proceso es înica, lo desactivamos... */
		if (strncmp(fejec, "U", 1) == 0)
		{
			/* EXEC SQL
				update sch_proceso
				set flg_ejecucion		= 'I',
					user_bloq           = 'SCHEDULER',
					fec_bloq            = sysdate
				where  cod_proc			= :cod_proc_start; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update sch_proceso  set flg_ejecucion='I',user_bloq='SCHED\
ULER',fec_bloq=sysdate where cod_proc=:b0";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )472;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_start;
   sqlstm.sqhstl[0] = (unsigned long )10;
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


			fnMsgError(szMsg, sqlca.sqlcode, false);
			/* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )491;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		}
		/*Busca la fecha actual */
	    SCHfecha_sistema(FechaActual,1);
		/* Actualizamos la profile con el encolamiento */
		/* EXEC SQL
			update sch_profile
			   set cod_estado	= 'ENCOL',
			       num_jobs		= :sec,
			       fec_ultejec  = to_date(:FechaActual,'yyyymmddhh24miss')
			where cod_proc		= :cod_proc_start and
				  cod_subpro	= :cod_subpro_start; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update sch_profile  set cod_estado='ENCOL',num_jobs=:b0,fec\
_ultejec=to_date(:b1,'yyyymmddhh24miss') where (cod_proc=:b2 and cod_subpro=:b\
3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )506;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&sec;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)FechaActual;
  sqlstm.sqhstl[1] = (unsigned long )30;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)cod_proc_start;
  sqlstm.sqhstl[2] = (unsigned long )10;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)cod_subpro_start;
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


		fnMsgError(szMsg, sqlca.sqlcode, false);
		/* EXEC SQL commit; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )537;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		/*--------------------------------------------------------------------------------*/
		/* Actualizar el HPROFILE con el proceso que queda encolado                       */
		/*--------------------------------------------------------------------------------*/
		 /* EXEC SQL execute 
		   BEGIN
			   PRO_INS_SCH_HPROFILE (:cod_proc_start, :cod_subpro_start, '1', :sec, :FechaActual, 
									'PLAY', 'SCHEDULER', NULL, '9');
		   END;
		 END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin PRO_INS_SCH_HPROFILE ( :cod_proc_start , :cod_subpro\
_start , '1' , :sec , :FechaActual , 'PLAY' , 'SCHEDULER' , NULL , '9' ) ; END\
 ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )552;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_start;
   sqlstm.sqhstl[0] = (unsigned long )10;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_start;
   sqlstm.sqhstl[1] = (unsigned long )10;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&sec;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)FechaActual;
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


		fnMsgError(szMsg, sqlca.sqlcode, false);

		/* EXEC SQL commit; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )583;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		/*Busca parametros especiales */
		sqlca.sqlcode = 0;
		strcpy(Esp_Argv,"");
		memset(Esp_Argv, 0x00, sizeof(Esp_Argv));
		/* EXEC SQL 
			select gls_argv
			  into :Esp_Argv 
			  from sch_paramesp
			 where cod_proc   = :cod_proc_start
			   and cod_subpro = :cod_subpro_start; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select gls_argv into :b0  from sch_paramesp where (cod_proc\
=:b1 and cod_subpro=:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )598;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)Esp_Argv;
  sqlstm.sqhstl[0] = (unsigned long )500;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_proc_start;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)cod_subpro_start;
  sqlstm.sqhstl[2] = (unsigned long )10;
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


		/* Armar Shell a ejecutar	*/
		fprintf(cmd, "%s/%s %s %s %d %s %s\n", PathCond, NomPrgCond, cod_proc_start, cod_subpro_start, sec, szhUsername, szhPassword);
		fprintf(cmd," if [ $? =  0 ]\n");
		fprintf(cmd," then\n");
		/*Path/Nombre ArgEsp Proceso SubProceso Secuencia Usuario Password > PathLog/Log.Secuencia */
		fprintf(cmd, "  %s/%s %s %s %s %d %s %s %s > %s%s.%d 2>&1\n", path_scr, nom_scr, Esp_Argv, cod_proc_start, cod_subpro_start, sec, nomuser, nompass, nombase, path_log, nom_log, sec); 
		fprintf(cmd,"   if [ ! $? =  0 ]\n");
		fprintf(cmd,"   then\n");
		fprintf(cmd,"      %s/%s %s %s N %s %s %s %s 1\n", PathMail, NomPrgMail, cod_proc_start, cod_subpro_start, cod_central_start, FechaActual, szhUsername, szhPassword );
		if (strcmp(log_gener_start,"N") != 0) fprintf(cmd,"   cat %s%s.%d >> %s.%d\n",path_log, nom_log, sec, log_gener_start,sec);
		fprintf(cmd,"      exit 1\n");
		fprintf(cmd,"   else\n");
		fprintf(cmd,"      %s/%s %s %s N %s %s %s %s 0\n", PathMail, NomPrgMail, cod_proc_start, cod_subpro_start, cod_central_start, FechaActual, szhUsername, szhPassword );
		fprintf(cmd,"   fi;\n\n");
		if (strcmp(log_gener_start,"N") != 0) fprintf(cmd,"   cat %s%s.%d >> %s.%d\n",path_log, nom_log, sec, log_gener_start,sec);
		fprintf(cmd," fi;\n\n");
		/* Buscamos el siguiente registro */
		/* EXEC SQL fetch CurProcBatch into :cod_proc_start, :cod_subpro_start, :nom_proc_start, :nom_scr, :path_scr, 
			:nom_log, :fejec, :nombase, :nomuser, :nompass, :cod_central_start, :log_gener_start, :Flg_1; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )625;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_start;
  sqlstm.sqhstl[0] = (unsigned long )10;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_start;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)nom_proc_start;
  sqlstm.sqhstl[2] = (unsigned long )30;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)nom_scr;
  sqlstm.sqhstl[3] = (unsigned long )30;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)path_scr;
  sqlstm.sqhstl[4] = (unsigned long )150;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)nom_log;
  sqlstm.sqhstl[5] = (unsigned long )20;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)fejec;
  sqlstm.sqhstl[6] = (unsigned long )10;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)nombase;
  sqlstm.sqhstl[7] = (unsigned long )20;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)nomuser;
  sqlstm.sqhstl[8] = (unsigned long )20;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)nompass;
  sqlstm.sqhstl[9] = (unsigned long )20;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)cod_central_start;
  sqlstm.sqhstl[10] = (unsigned long )10;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)log_gener_start;
  sqlstm.sqhstl[11] = (unsigned long )150;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)Flg_1;
  sqlstm.sqhstl[12] = (unsigned long )2;
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


	 } /* Fin del While del cursor CurProcBatch */
	 /* EXEC SQL close CurProcBatch; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )692;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	 if (ex == 0)
	 {
		 fprintf(cmd,"rm sh_batch_%d.sh \n",sec); 
		 fclose(cmd);
		 strcpy(codlog,cod_proc_start);

		 EjecutarShell(shell_name); /* Ejecutar Shell con todos los SubProcesos */
		 /* Incrementamos el Secuencial actual desde SCH_CODIGOS		*/
		/* EXEC SQL 
			update sch_codigos
			   set	gls_param = to_char(to_number(gls_param) + 1)
			where cod_tipo  = 'CORRELATIV' and
				  cod_param = 'NUMJOB'; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update sch_codigos  set gls_param=to_char((to_number(gls_pa\
ram)+1)) where (cod_tipo='CORRELATIV' and cod_param='NUMJOB')";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )707;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		fnMsgError(szMsg, sqlca.sqlcode, false);
		 /* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )722;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		 /*Recuperamos el Secuencial actual desde SCH_CODIGOS	*/
		 /* EXEC SQL
			select to_number(gls_param)
			  into :sec
			  from sch_codigos
			where cod_tipo  = 'CORRELATIV' and
				  cod_param = 'NUMJOB'; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select to_number(gls_param) into :b0  from sch_codigos whe\
re (cod_tipo='CORRELATIV' and cod_param='NUMJOB')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )737;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&sec;
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
	return;
}


/*================================================================*/
/* Funcion   : VerRestriccion                                     */
/* Objetivo  : Busca procesos con mﬂs prioridad corriendo.		  */
/*================================================================*/
int VerRestriccion(char *Tcod_proc, char *Tcod_subpro, long Tnum_job)
{
	long pcuenta;
	pcuenta = 0;
	sqlca.sqlcode = 0;
	/* EXEC SQL 
		SELECT count(e.cod_proc)
		INTO   :pcuenta
		FROM   sch_condicion d,
			   sch_profile	 e
		WHERE	d.cod_proc		= :Tcod_proc		AND
				d.cod_subpro	= :Tcod_subpro		AND
				e.num_jobs	= :Tnum_job			AND
				e.cod_proc	= d.cod_procrest	AND
				e.cod_subpro	= d.cod_sprocres	AND
		        d.flg_restric	= 'R'				AND
		        d.flg_condact	= 'A'				AND 
		       (e.cod_estado	= 'PLAY'			OR
		        e.cod_estado	= 'ENCOL'); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(e.cod_proc) into :b0  from sch_condicion d ,sch\
_profile e where (((((((d.cod_proc=:b1 and d.cod_subpro=:b2) and e.num_jobs=:b\
3) and e.cod_proc=d.cod_procrest) and e.cod_subpro=d.cod_sprocres) and d.flg_r\
estric='R') and d.flg_condact='A') and (e.cod_estado='PLAY' or e.cod_estado='E\
NCOL'))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )756;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&pcuenta;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)Tcod_proc;
 sqlstm.sqhstl[1] = (unsigned long )0;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)Tcod_subpro;
 sqlstm.sqhstl[2] = (unsigned long )0;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&Tnum_job;
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

 
	fnMsgError("Consulta restriccion", sqlca.sqlcode, 0);
	if (pcuenta) return(1);

	pcuenta = 0;
	sqlca.sqlcode = 0;
	/* EXEC SQL 
		SELECT count(e.cod_proc)
		INTO   :pcuenta
		FROM   sch_condicion d,
			   sch_profile	 e
		WHERE	d.cod_procrest	= :Tcod_proc	AND
			d.cod_sprocres	= :Tcod_subpro	AND
			e.cod_proc	= d.cod_proc	AND
			e.cod_subpro	= d.cod_subpro	AND
		        d.flg_restric	= 'I'				AND
		        d.flg_condact	= 'A'				AND 
		       (e.cod_estado	= 'PLAY'			OR
		        e.cod_estado	= 'ENCOL'); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(e.cod_proc) into :b0  from sch_condicion d ,sch\
_profile e where ((((((d.cod_procrest=:b1 and d.cod_sprocres=:b2) and e.cod_pr\
oc=d.cod_proc) and e.cod_subpro=d.cod_subpro) and d.flg_restric='I') and d.flg\
_condact='A') and (e.cod_estado='PLAY' or e.cod_estado='ENCOL'))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )787;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&pcuenta;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)Tcod_proc;
 sqlstm.sqhstl[1] = (unsigned long )0;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)Tcod_subpro;
 sqlstm.sqhstl[2] = (unsigned long )0;
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

 
	fnMsgError("Consulta imperativo", sqlca.sqlcode, 0);
	if (pcuenta) return(1);

	return(0);
}

/*---------------------------------------------------------------------------------*/
/*Detecta los procesos terminados, ejecuta los procesos con restriccin y		   */
/*reinicializa el proceso para su prxima ejecucin.							   */
/*---------------------------------------------------------------------------------*/
void termina_procesos_detenidos()
{
/*---------------------------------------------------------------------------------*/
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long int num_job, nro_pid;
	long int num_job_act;
	char cod_proc_end[10];			/* EXEC SQL var cod_proc_end is string(10); */ 

	char cod_subpro_end[10];		/* EXEC SQL var cod_subpro_end is string(10); */ 

	char nom_proc_end[30];          /* EXEC SQL var nom_proc_end is string(30); */ 

	char cod_proc_act[10];			/* EXEC SQL var cod_proc_act is string(10); */ 

	char cod_subpro_act[10];		/* EXEC SQL var cod_subpro_act is string(10); */ 

	char cod_central_act[5];        /* EXEC SQL var cod_central_act is string(5); */ 

	char tip_ejecucion_act[10];     /* EXEC SQL var tip_ejecucion_act is string(10); */ 

	char f_ejec[15];				/* EXEC SQL var f_ejec is string(15); */ 

	char dia_semana[10];			/* EXEC SQL var dia_semana is string(10); */ 

	char hor_fini[6];               /* EXEC SQL var hor_fini is string(6); */ 

	char hor_fter[6];               /* EXEC SQL var hor_fter is string(6); */ 

	char esta_inactivo[10];			/* EXEC SQL var esta_inactivo is string(10); */ 

	/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------------*/

  int puede_ejecutar,ejecuto_rest;
  char comando_colas[100];

 /*-----------------------------------------------*/
 /* Deteccin de Târmino de ejecucin de Proceso. */
 /*-----------------------------------------------*/
 /*Buscar los procesos Terminados.				  */
 sqlca.sqlcode = 0;
 /* EXEC SQL declare CurProcSTP cursor for 
 select a.cod_proc, a.cod_subpro, a.nom_proc, 
		TO_CHAR(b.fec_ejec_ini,'yyyymmddhh24miss'), 
		DECODE(b.interval,NULL,0,b.interval),
		DECODE(b.cod_interv,NULL,' ',b.cod_interv),
		DECODE(b.dia_semana,NULL,' ',b.dia_semana),
		DECODE(a.num_jobs,NULL,0,a.num_jobs),
		DECODE(b.hor_fini,NULL,'N',TO_CHAR(b.hor_fini,'HH24MI')), 
		DECODE(b.hor_fter,NULL,'N',TO_CHAR(b.hor_fter,'HH24MI')) 
 from	sch_profile a,	sch_proceso b
 where  a.flg_batch     = 'B'		 
 and	b.cod_proc	= a.cod_proc 
 and	a.cod_estado	= 'STOP'; */ 

 
 /* EXEC SQL open CurProcSTP; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0027;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )814;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


 fnMsgError(szMsg, sqlca.sqlcode, false);
 /* EXEC SQL fetch CurProcSTP into :cod_proc_end, :cod_subpro_end, :nom_proc_end, :f_ejec, :interv, :cod_int, :dia_semana, :num_job, :hor_fini, :hor_fter; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )829;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_end;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_end;
 sqlstm.sqhstl[1] = (unsigned long )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)nom_proc_end;
 sqlstm.sqhstl[2] = (unsigned long )30;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)f_ejec;
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&interv;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)cod_int;
 sqlstm.sqhstl[5] = (unsigned long )10;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)dia_semana;
 sqlstm.sqhstl[6] = (unsigned long )10;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&num_job;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)hor_fini;
 sqlstm.sqhstl[8] = (unsigned long )6;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)hor_fter;
 sqlstm.sqhstl[9] = (unsigned long )6;
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


 fnMsgError(szMsg, sqlca.sqlcode, false);
 /*Para cada Proceso detenido...										   */
while (sqlca.sqlcode != SqlNotFound)
{
	trim(cod_proc_end, 1, strlen(cod_proc_end), cod_proc_end);
	trim(cod_subpro_end, 1, strlen(cod_subpro_end), cod_subpro_end);
	trim(f_ejec, 1, strlen(f_ejec), f_ejec);
	trim(cod_int, 1, strlen(cod_int), cod_int);
	/*--------------------------------------------------------------------------------*/
	/*                           Envia la se±al a la tarea                            */
	/*--------------------------------------------------------------------------------*/
		/* EXEC SQL SELECT b.nro_pid
			INTO :nro_pid
			FROM sch_detalle_proc a, sch_jobs b
			WHERE a.cod_proc    = :cod_proc_end   AND
				  a.cod_subpro  = :cod_subpro_end AND
				  a.ind_colas   <> 'N'            AND	
				  b.fec_iniexec IN (SELECT MAX(fec_iniexec) 
									     FROM sch_jobs
										 WHERE cod_proc    = :cod_proc_end   AND
											   cod_subpro  = :cod_subpro_end AND
											   num_jobs    = :num_job); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select b.nro_pid into :b0  from sch_detalle_proc a ,sch_job\
s b where (((a.cod_proc=:b1 and a.cod_subpro=:b2) and a.ind_colas<>'N') and b.\
fec_iniexec in (select max(fec_iniexec)  from sch_jobs where ((cod_proc=:b1 an\
d cod_subpro=:b2) and num_jobs=:b5)))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )884;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&nro_pid;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_proc_end;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)cod_subpro_end;
  sqlstm.sqhstl[2] = (unsigned long )10;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)cod_proc_end;
  sqlstm.sqhstl[3] = (unsigned long )10;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)cod_subpro_end;
  sqlstm.sqhstl[4] = (unsigned long )10;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&num_job;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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


		fnMsgError(szMsg, sqlca.sqlcode, 0);
		if (nro_pid > 0 && sqlca.sqlcode != SqlNotFound)
		{
			sigsend (P_PID,nro_pid,SIGUSR2);
			printf("Envi senal a PID batch [%ld] \n", nro_pid);
		}

	/*--------------------------------------------------------------------------------*/
	/*                     Actualizar el HPROFILE del Proceso                         */
	/*--------------------------------------------------------------------------------*/
	 /* EXEC SQL execute 
	   BEGIN
		   PRO_INS_SCH_HPROFILE (:cod_proc_end, :cod_subpro_end, '1', :num_job, 
			to_char(sysdate, 'YYYYMMDDHH24MISS'), 'STOP',  'SCHEDULER', NULL, '9');
	   END;
	 END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin PRO_INS_SCH_HPROFILE ( :cod_proc_end , :cod_subpro_en\
d , '1' , :num_job , to_char ( sysdate , 'YYYYMMDDHH24MISS' ) , 'STOP' , 'SCHE\
DULER' , NULL , '9' ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )923;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_end;
  sqlstm.sqhstl[0] = (unsigned long )10;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_end;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&num_job;
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


	/*Commit de la transaccin */
	fnMsgError(szMsg, sqlca.sqlcode, false);
	/* EXEC SQL commit; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )950;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

        
	fnMsgError(szMsg, sqlca.sqlcode, false);
	/*--------------------------------------------------------*/
	/* Recuperar y Ejecutar los subprogramas con restriccin. */
	/*--------------------------------------------------------*/
	trim(cod_proc_end,1,strlen(cod_proc_end),cod_proc_end);
	trim(cod_subpro_end,1,strlen(cod_subpro_end),cod_subpro_end);
	sqlca.sqlcode = 0;
	/* EXEC SQL declare CurProcPlay cursor for
		select e.cod_proc,		e.cod_subpro,  e.num_jobs, e.cod_central, e.tip_ejecucion
			from   sch_condicion   d,
				   sch_profile		e
			where	d.cod_proc	    = :cod_proc_end		and
					d.cod_subpro    = :cod_subpro_end	and
					e.cod_proc		= d.cod_procrest    and
					e.cod_subpro	= d.cod_sprocres	and
					e.cod_estado	= 'PAUSX'			and
					d.flg_condact	= 'A'; */ 

	/* EXEC SQL open CurProcPlay; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0031;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )965;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_end;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_end;
 sqlstm.sqhstl[1] = (unsigned long )10;
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


	fnMsgError(szMsg, sqlca.sqlcode, false);
	/* EXEC SQL fetch CurProcPlay into :cod_proc_act, :cod_subpro_act, :num_job_act, :cod_central_act, :tip_ejecucion_act; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )988;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_act;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_act;
 sqlstm.sqhstl[1] = (unsigned long )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&num_job_act;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)cod_central_act;
 sqlstm.sqhstl[3] = (unsigned long )5;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)tip_ejecucion_act;
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


	fnMsgError(szMsg, sqlca.sqlcode, false);
	/*Para cada SubProceso a ejecutar...										   */
	ejecuto_rest = 0;
	while (sqlca.sqlcode != SqlNotFound)
	{
		trim(cod_proc_act,1,strlen(cod_proc_act),cod_proc_act);
		trim(cod_subpro_act,1,strlen(cod_subpro_act),cod_subpro_act);
		trim(cod_central_act,1,strlen(cod_central_act),cod_central_act);

		if ( !(VerRestriccion(cod_proc_act, cod_subpro_act, num_job_act)) ) 
		{
			/* EXEC SQL
			update sch_profile
			   set    cod_estado		   = 'PLAY'
			   where	cod_proc    = :cod_proc_act   and
						cod_subpro  = :cod_subpro_act and
						cod_central = :cod_central_act; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update sch_profile  set cod_estado='PLAY' where ((cod_proc\
=:b0 and cod_subpro=:b1) and cod_central=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1023;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_act;
   sqlstm.sqhstl[0] = (unsigned long )10;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_act;
   sqlstm.sqhstl[1] = (unsigned long )10;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)cod_central_act;
   sqlstm.sqhstl[2] = (unsigned long )5;
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


			   fnMsgError(szMsg, sqlca.sqlcode, false);
			/*--------------------------------------------------------------------------------*/
			/* Actualizar el HPROFILE del Proceso recien terminado, para su prxima ejecucin. */
			/*--------------------------------------------------------------------------------*/
			 /* EXEC SQL execute 
			   BEGIN
				  PRO_INS_SCH_HPROFILE (:cod_proc_act, :cod_subpro_act, :cod_central_act, :num_job_act, 
										to_char(sysdate, 'YYYYMMDDHH24MISS'), 'PLAY', :nom_proc_start, 
										'Condiciones de ejecucion', :tip_ejecucion_act);
			   END;
			 END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin PRO_INS_SCH_HPROFILE ( :cod_proc_act , :cod_subpro_\
act , :cod_central_act , :num_job_act , to_char ( sysdate , 'YYYYMMDDHH24MISS'\
 ) , 'PLAY' , :nom_proc_start , 'Condiciones de ejecucion' , :tip_ejecucion_ac\
t ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1050;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_act;
    sqlstm.sqhstl[0] = (unsigned long )10;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_act;
    sqlstm.sqhstl[1] = (unsigned long )10;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)cod_central_act;
    sqlstm.sqhstl[2] = (unsigned long )5;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&num_job_act;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)nom_proc_start;
    sqlstm.sqhstl[4] = (unsigned long )30;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)tip_ejecucion_act;
    sqlstm.sqhstl[5] = (unsigned long )10;
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


			fnMsgError(szMsg, sqlca.sqlcode, false);
			/*Commit de la transaccin	*/
			/* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1089;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

        
			fnMsgError(szMsg, sqlca.sqlcode, false);
			fnMsgError(szMsg, sqlca.sqlcode, false);
			ejecuto_rest = 1;
		}
		/* EXEC SQL fetch CurProcPlay into :cod_proc_act, :cod_subpro_act, :num_job_act, :cod_central_act, :tip_ejecucion_act; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1104;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_act;
  sqlstm.sqhstl[0] = (unsigned long )10;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_act;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&num_job_act;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)cod_central_act;
  sqlstm.sqhstl[3] = (unsigned long )5;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)tip_ejecucion_act;
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


	} /* Fin del while del cursor CurProcPlay */
	/* EXEC SQL close CurProcPlay; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1139;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (ejecuto_rest)
	{
		sprintf(comando_colas,"%s/%s PLAY %s %s ",path_colas,prg_colas,szhUsername, szhPassword);
		system(comando_colas);
	}
	
	sqlca.sqlcode = 0;	 
	/* EXEC SQL
	select flg_ejecucion
			into   :esta_inactivo
			from	sch_proceso
			where   cod_proc = :cod_proc_end; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select flg_ejecucion into :b0  from sch_proceso where cod_pr\
oc=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1154;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)esta_inactivo;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_proc_end;
 sqlstm.sqhstl[1] = (unsigned long )10;
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


	trim(esta_inactivo, 1, strlen(esta_inactivo), esta_inactivo);
	if (strncmp(esta_inactivo, "I", 1) != 0)
	{
		tot_minutos = 0;
		tot_segundos = 0;
		/* 1 X cantidad_segundos */
		if (strcmp(cod_int, "SEG") == 0)
			tot_segundos = 1 * interv * FACTOR_SEGUNDO;
		else
		{
			/* 60 segundos X cantidad_minutos */
			if (strcmp(cod_int, "MIN") == 0)
				tot_segundos = 1 * 60 * interv * FACTOR_SEGUNDO;
			else
			{
				/* 60 segundos X 60 minutos X cantidad_horas */
				if (strcmp(cod_int, "HOR") == 0)
					tot_segundos = 1 * 60 * 60 * interv * FACTOR_SEGUNDO;
				else
				{
					/* 60 segundos X 60 minutos X 24 horas X cantidad_dias */
					if (strcmp(cod_int, "DIA") == 0)
						tot_segundos = 1 * 60 * 60 * 24 * interv * FACTOR_SEGUNDO;
					else
					{
						/* 60 segundos X 60 minutos X 24 horas X 7 dias_semana X cantidad_dias */
						if (strcmp(cod_int, "SEM") == 0)
							tot_segundos = 1 * 60 * 60 * 24 * 7 * interv * FACTOR_SEGUNDO;
						else
						{
							/* 60 segundos X 60 minutos X 24 horas X 30 dias(prom_mesual) X cantidad_dias */
							if (strcmp(cod_int, "MES") == 0)
								tot_segundos = 1 * 60 * 60 * 24 * 30 * interv * FACTOR_SEGUNDO;
						}
					}
				}
			}
		}
		/* EXEC SQL
		UPDATE sch_profile
			SET fec_ini				= fec_ini + :tot_segundos,
				cod_estado			= 'EMPT'
			WHERE   cod_proc		= :cod_proc_end AND
					cod_subpro		= :cod_subpro_end; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update sch_profile  set fec_ini=(fec_ini+:b0),cod_estado='E\
MPT' where (cod_proc=:b1 and cod_subpro=:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1177;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&tot_segundos;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)cod_proc_end;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)cod_subpro_end;
  sqlstm.sqhstl[2] = (unsigned long )10;
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


		/*Commit de la transaccin	*/
		fnMsgError(szMsg, sqlca.sqlcode, false);
		/* EXEC SQL commit; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1204;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



		/*--------------------------------------------------------------------------------*/
		/* Revisa si puede ejecutarse en el dça										   */
		/*--------------------------------------------------------------------------------*/
		revisa_hora_ejecucion(cod_proc_end,cod_subpro_end,hor_fini,hor_fter);
		sqlca.sqlcode = 0;
		/* EXEC SQL
		SELECT upper(to_char(fec_ini,'day')), TO_CHAR(fec_ini,'HH24MI'), TO_CHAR(fec_ini,'dd/mm/yyyy HH24MI')
			INTO   :nombre_dia, :mhor_ini, :mfec_paso
			FROM	sch_profile
			WHERE   cod_proc	= :cod_proc_end   and
					cod_subpro	= :cod_subpro_end; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select upper(to_char(fec_ini,'day')) ,TO_CHAR(fec_ini,'HH24\
MI') ,TO_CHAR(fec_ini,'dd/mm/yyyy HH24MI') into :b0,:b1,:b2  from sch_profile \
where (cod_proc=:b3 and cod_subpro=:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1219;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)nombre_dia;
  sqlstm.sqhstl[0] = (unsigned long )10;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)mhor_ini;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)mfec_paso;
  sqlstm.sqhstl[2] = (unsigned long )20;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)cod_proc_end;
  sqlstm.sqhstl[3] = (unsigned long )10;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)cod_subpro_end;
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


		fnMsgError(szMsg, sqlca.sqlcode, false); /*ETS 19/04/2004*/
		if (!(revisa_dia(nombre_dia, dia_semana)))
		{
			/* EXEC SQL
			UPDATE sch_profile
				SET fec_ini			= fec_ini + :minutos,
					cod_estado		= 'EMPT'
				WHERE   cod_proc	= :cod_proc_end AND
						cod_subpro	= :cod_subpro_end; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update sch_profile  set fec_ini=(fec_ini+:b0),cod_estado='\
EMPT' where (cod_proc=:b1 and cod_subpro=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1254;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&minutos;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)cod_proc_end;
   sqlstm.sqhstl[1] = (unsigned long )10;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)cod_subpro_end;
   sqlstm.sqhstl[2] = (unsigned long )10;
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


			/*Commit de la transaccin	*/
			fnMsgError(szMsg, sqlca.sqlcode, false);
			/* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1281;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

         
		}
	}
	/* Buscamos el siguiente registro */
	/* EXEC SQL fetch CurProcSTP into :cod_proc_end, :cod_subpro_end, :nom_proc_end, :f_ejec, :interv, :cod_int, :dia_semana, :num_job, :hor_fini, :hor_fter; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1296;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)cod_proc_end;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)cod_subpro_end;
 sqlstm.sqhstl[1] = (unsigned long )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)nom_proc_end;
 sqlstm.sqhstl[2] = (unsigned long )30;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)f_ejec;
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&interv;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)cod_int;
 sqlstm.sqhstl[5] = (unsigned long )10;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)dia_semana;
 sqlstm.sqhstl[6] = (unsigned long )10;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&num_job;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)hor_fini;
 sqlstm.sqhstl[8] = (unsigned long )6;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)hor_fter;
 sqlstm.sqhstl[9] = (unsigned long )6;
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


	fnMsgError(szMsg, sqlca.sqlcode, false);
} /* Fin del While del cursor CurProcSTP */
 /* EXEC SQL close CurProcSTP; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1351;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


/*--------------------------------------------------------
   Eliminar los procesos bloqueados de la SCH_PROFILE.    
  --------------------------------------------------------*/
 /* EXEC SQL
 delete sch_profile
 where  flg_batch  = 'B'				and
		cod_estado = 'STOP'             and
		cod_proc in (select cod_proc from sch_proceso where flg_ejecucion = 'I'); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from sch_profile  where ((flg_batch='B' and cod_esta\
do='STOP') and cod_proc in (select cod_proc  from sch_proceso where flg_ejecuc\
ion='I'))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1366;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


/*Commit de la transaccin	*/
 fnMsgError(szMsg, sqlca.sqlcode, false); 
 /* EXEC SQL commit; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1381;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

        
 return;
}

void EjecutarShell(char *cmd_shell)
{
 char comm[100];
 printf(" %s \n", cmd_shell);
 memset(comm, 0x00, sizeof(comm));
 sprintf(comm, "ksh %s &", cmd_shell);
 system(comm); 
}

/*---------------------------------------------------------------------------------*/
/*PROGRAMA PRINCIPAL (MAIN)														   */
/*---------------------------------------------------------------------------------*/
main(argc,argv)
int     argc ;
char  **argv ;
{
char szcod_proceso[11];
char szcod_subproceso[11];
char szcod_central[6];

	switch (argc)
	{
    case 12: strcpy(szcod_central,argv[3]);
             strcpy(szhmodulo,szcod_central);
             strcpy(szcod_proceso,argv[4]);
             strcpy(szcod_subproceso,argv[5]);
             strcpy(szhfec_ini,argv[6]);
             trim(szhfec_ini,1,strlen(szhfec_ini),szhfec_ini);
             trim(szhmodulo,1,strlen(szhmodulo),szhmodulo);
             strcpy(szhsch_proceso,szcod_proceso);
             strcpy(szhsch_subproceso,szcod_subproceso);
             strcpy(szhUsername,argv[9]);
             strcpy(szhPassword,argv[10]);
	     strcpy(szhConexionBase,argv[11]);
             break;
    	     default:printf("   PROGRAMA                   : exe_batch \n");
	             printf("   VERSION                    : 1.1 \n");
	             printf("   FECHA VERSION              : 21-05-2004 \n");
	             printf( " Numero de parametros erroneo .\n"); 
       	    fflush(stdout);
	exit(1);
	}
	SCHfecha_sistema(FechaActual,0);
	printf("+-------------------------------------------------------------------------------------+\n");
	printf("|                         SERVICIO DE AGENDA DE EJECUCIONES BATCH                     |\n");
	printf("+-------------------------------------------------------------------------------------+\n");
	printf("   ADMINISTRACION DE PROCESOS                                 %s \n",FechaActual);
	printf("   Instancia de Base de Datos : %s \n",szhConexionBase);
	printf("   Usuario                    : %s \n",szhUsername);
	printf("+-------------------------------------------------------------------------------------+\n");


	/* EXEC SQL WHENEVER SQLERROR GOTO ERROR; */ 

	/* EXEC SQL connect :szhUsername identified by :szhPassword; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )60;
 sqlstm.offset = (unsigned int  )1396;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUsername;
 sqlstm.sqhstl[0] = (unsigned long )30;
 sqlstm.sqhsts[0] = (         int  )30;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhPassword;
 sqlstm.sqhstl[1] = (unsigned long )30;
 sqlstm.sqhsts[1] = (         int  )30;
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
 if (sqlca.sqlcode < 0) goto ERROR;
}


	printf("Conexion Base de Datos, Sqlcode=(%d).\n", sqlca.sqlcode);

	/* Marca del inicio en la profile */
	fnMarca_Inicio_Programa();

	exe_batch();

	SCHfecha_sistema(FechaActual,0);
	printf("+-------------------------------------------------------------------------------------+\n");
	printf("|  Fin de la Ejecucion                                        %23s|\n",FechaActual);
	printf("+-------------------------------------------------------------------------------------+\n");
	exit(0);

	ERROR :
	/* EXEC SQL WHENEVER SQLERROR CONTINUE; */ 

	/* EXEC SQL ROLLBACK WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1427;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	printf("Main Error, Sqlcode=(%d).\n", sqlca.sqlcode);
	exit(1);
} /* Fin Principal */

/************************************************************/
/* Funcion   : fnMsgError                                   */
/* Objetivo  : manejador de errores sql                     */
/************************************************************/ 
fnMsgError(szMsg, iErrNum, bRollCom)
char *szMsg;
int  iErrNum;
int  bRollCom;
{
 if (iErrNum NE SqlNull) {
 if ((iErrNum NE SqlOk) and (iErrNum NE SqlNotFound))
  {
       printf("ERROR SQL : %d EN %s \n", iErrNum, szMsg);
	   fflush(stdout);
       if (bRollCom) 
         /* EXEC SQL rollback work; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 13;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )1442;
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
/************************************************************/
/* Funcion    : fnMarca_Inicio_Programa                     */
/* Objetivo   : Marcar el PID del Proceso                   */
/************************************************************/
void fnMarca_Inicio_Programa(void)
{
   lhpid=getpid();
   /* EXEC SQL update sch_profile
               set num_jobs    = :lhpid,
                   cod_estado  = 'PLAY'
             Where cod_proc    = :szhsch_proceso
               and cod_subpro  = :szhsch_subproceso
               and cod_central = :szhmodulo
             ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update sch_profile  set num_jobs=:b0,cod_estado='PLAY' whe\
re ((cod_proc=:b1 and cod_subpro=:b2) and cod_central=:b3)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1457;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhpid;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhsch_proceso;
   sqlstm.sqhstl[1] = (unsigned long )11;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhsch_subproceso;
   sqlstm.sqhstl[2] = (unsigned long )11;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhmodulo;
   sqlstm.sqhstl[3] = (unsigned long )6;
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



   fnMsgError("Update Sch_profile.",sqlca.sqlcode,true);

   /* EXEC SQL update sch_hprofile
               set num_jobs		= :lhpid
             Where cod_proc     = :szhsch_proceso
               and cod_subpro   = :szhsch_subproceso
               and cod_central	= :szhmodulo
               and fecha        = :szhfec_ini
             ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update sch_hprofile  set num_jobs=:b0 where (((cod_proc=:b\
1 and cod_subpro=:b2) and cod_central=:b3) and fecha=:b4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1488;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhpid;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhsch_proceso;
   sqlstm.sqhstl[1] = (unsigned long )11;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhsch_subproceso;
   sqlstm.sqhstl[2] = (unsigned long )11;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhmodulo;
   sqlstm.sqhstl[3] = (unsigned long )6;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhfec_ini;
   sqlstm.sqhstl[4] = (unsigned long )15;
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



   fnMsgError("Update Sch_hprofile.",sqlca.sqlcode,true);
   /* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1523;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


}

/************************************************************/
/* Funcion    : fnBorra_sch_profile                         */
/* Objetivo   : Actualiza la tabla de Procesos Activos      */
/************************************************************/
void fnBorra_sch_profile(void)
{
   /* EXEC SQL delete from sch_profile
             Where cod_proc    = :szhsch_proceso
               and cod_subpro  = :szhsch_subproceso
               and cod_central = :szhmodulo
             ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "delete  from sch_profile  where ((cod_proc=:b0 and cod_sub\
pro=:b1) and cod_central=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1538;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhsch_proceso;
   sqlstm.sqhstl[0] = (unsigned long )11;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhsch_subproceso;
   sqlstm.sqhstl[1] = (unsigned long )11;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhmodulo;
   sqlstm.sqhstl[2] = (unsigned long )6;
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



   fnMsgError("Delete Sch_profile.",sqlca.sqlcode,true);
   /* EXEC SQL commit; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1565;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


}

/*************************************************************/
/* Funcion    : Recupera_Servicios                           */
/* Objetivo   : Recupera los nombres y ubicacion de servicios*/
/*************************************************************/
void Recupera_Servicios()
{
/*---------------------------------------------------------------------------------*/
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char cod_arch[6];            /* EXEC SQL var cod_arch is string(6); */ 

	char nom_arch[16];           /* EXEC SQL var nom_arch is string(16); */ 

	char path[151];              /* EXEC SQL var path     is string(151); */ 

	/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------------*/

	/* EXEC SQL declare CurServicios cursor for
	    select Cod_arch, Nom_arch, Path 
	    from	sch_archivos 
	    where	cod_tipo = '5'; */ 

        /* EXEC SQL open CurServicios; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0051;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1580;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	    /* EXEC SQL fetch CurServicios into :cod_arch, :nom_arch, :path; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 13;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1595;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)cod_arch;
     sqlstm.sqhstl[0] = (unsigned long )6;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)nom_arch;
     sqlstm.sqhstl[1] = (unsigned long )16;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)path;
     sqlstm.sqhstl[2] = (unsigned long )151;
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


        fnMsgError(szMsg, sqlca.sqlcode, false);
    
	while (sqlca.sqlcode != SqlNotFound)
	{
		trim(path, 1, strlen(path), path);
		if (strcmp(cod_arch,"SHLOG") == 0 )
		{
			strcpy(path_log,path);
		}
		else if (strcmp(cod_arch,"SHMAI") == 0 )
		{
			strcpy(NomPrgMail,nom_arch);
			strcpy(PathMail,path);
		}
		else if (strcmp(cod_arch,"SHCON") == 0 )
		{
			strcpy(NomPrgCond,nom_arch);
			strcpy(PathCond,path);
		}
		else if (strcmp(cod_arch,"SHMSG") == 0 )
		{
			strcpy(prg_colas,nom_arch);
			strcpy(path_colas,path);
		}
		/* EXEC SQL fetch CurServicios into :cod_arch, :nom_arch, :path; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1622;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)cod_arch;
  sqlstm.sqhstl[0] = (unsigned long )6;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)nom_arch;
  sqlstm.sqhstl[1] = (unsigned long )16;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)path;
  sqlstm.sqhstl[2] = (unsigned long )151;
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


		fnMsgError(szMsg, sqlca.sqlcode, false);
	}
}

/******************************************************************************************/
/** Informacin de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisin                                            : */
/**  %PR% */
/** Autor de la Revisin                                : */
/**  %AUTHOR% */
/** Estado de la Revisin ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creacin de la Revisin                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
