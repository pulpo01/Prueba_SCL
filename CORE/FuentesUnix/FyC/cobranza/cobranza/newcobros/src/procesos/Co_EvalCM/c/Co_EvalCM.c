
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
static const struct sqlcxp sqlfpn =
{
    17,
    "./pc/Co_EvalCM.pc"
};


static unsigned int sqlctx = 6910963;


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
   unsigned char  *sqhstv[19];
   unsigned long  sqhstl[19];
            int   sqhsts[19];
            short *sqindv[19];
            int   sqinds[19];
   unsigned long  sqharm[19];
   unsigned long  *sqharc[19];
   unsigned short  sqadto[19];
   unsigned short  sqtdso[19];
} sqlstm = {12,19};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,67,0,4,125,0,0,2,1,0,1,0,2,5,0,0,1,97,0,0,
28,0,0,2,61,0,5,144,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
51,0,0,3,0,0,29,157,0,0,0,0,0,1,0,
66,0,0,4,114,0,4,429,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,97,0,0,
97,0,0,5,118,0,4,443,0,0,4,3,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
128,0,0,6,53,0,4,478,0,0,1,0,0,1,0,2,3,0,0,
147,0,0,7,84,0,5,525,0,0,1,1,0,1,0,1,3,0,0,
166,0,0,8,205,0,4,566,0,0,3,2,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,
193,0,0,9,0,0,17,665,0,0,1,1,0,1,0,1,97,0,0,
212,0,0,9,0,0,45,678,0,0,7,7,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,97,0,0,1,97,0,0,
255,0,0,9,0,0,45,680,0,0,16,16,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,
334,0,0,9,0,0,13,696,0,0,8,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,
2,3,0,0,2,97,0,0,2,3,0,0,
381,0,0,9,0,0,15,721,0,0,0,0,0,1,0,
396,0,0,10,172,0,4,795,0,0,4,3,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
427,0,0,11,465,0,3,1009,0,0,19,19,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,3,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,4,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
518,0,0,12,77,0,5,1040,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
545,0,0,13,59,0,5,1054,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
568,0,0,14,157,0,5,1069,0,0,7,7,0,1,0,1,97,0,0,1,4,0,0,1,4,0,0,1,97,0,0,1,3,0,
0,1,97,0,0,1,3,0,0,
611,0,0,15,113,0,4,1108,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
638,0,0,16,106,0,3,1120,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,
665,0,0,17,124,0,5,1131,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
692,0,0,18,243,0,2,1143,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,5,0,
0,
727,0,0,19,245,0,2,1161,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,5,0,
0,
762,0,0,20,50,0,4,1179,0,0,1,0,0,1,0,2,3,0,0,
781,0,0,21,343,0,3,1190,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,
828,0,0,22,530,0,3,1227,0,0,10,10,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
883,0,0,23,72,0,3,1269,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
906,0,0,24,95,0,5,1289,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
933,0,0,25,0,0,29,1313,0,0,0,0,0,1,0,
948,0,0,26,0,0,31,1317,0,0,0,0,0,1,0,
};


/*==================================================================================
   Nombre      : Co_EvalCM.pc
   Programa    : Proceso evaluador de clientes morosos primerizos, los cuales van ingresando
                     a Co_morosos y Co_acciones con un solo registro.
                     Se ejecuta en : instancias paralelas, en paralelo con el proceso Co_EvalMO
                     y una vez terminado el proceso Co_saldocons.
   Autor       : GAC
   Creado      : Diciembre-2003
==================================================================================*/
#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_
#include "Co_EvalCM.h"
#include <sched.h>

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

LINEACOMANDO stLineaComando;        /* Datos con los que se invoco al proceso */

int  iNumeroHilos= 0, iContinue=0;
int  iResult     = 0, iError   =0;
int  iSec_Padre  = 0;
int  iSec_Hijo   = 0;
long lTotalRows  = 0;
/* Identificador del thread hijo */
thread_t     idHilo[25];
lista_Pto    lsPto;
struct stCliente iLB;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char  szhCodEstado[2]; /* EXEC SQL VAR szhCodEstado IS STRING (2); */ 

     char  szhProceso  [6];
     float fhPorcentajeMem;
     long  lhCpu        ;
     int   ihNUM_INSTAN ;
     int   ihRAN_LISTAS ;
     long  lhSecMoroso   ;

     TCLIENTES sthClientes;

     char  szhUser_Cobros[15]; /* EXEC SQL VAR szhUser_Cobros IS STRING(15); */ 

     char  szhWait       [2];
     char  szhVigente    [2];
     char  szhErr        [4];
     char  szhPnd        [4];
     char  szhEje        [4];
     char  szhCO         [3];
     char  szhUSER       [15];
     int   ihValor_Cero = 0;
     int   ihValor_Uno  = 1;
     int   ihValor_Dos  = 2;
     int   ihValor_Tres = 3;
     
/* EXEC SQL END DECLARE SECTION; */ 


/* ============================================================================= */
/* Funcion: main                                                                 */
/* Objetivo: Funcion principal del programa                                      */
/* ============================================================================= */
int main( int argc, char *argv[] )
{
char modulo[] = "main";
int iResProc = STATUS_OK;
int iRes=0;

    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));
    sprintf(szPROCESO,"EVACM\0");
    rtrim(szPROCESO);
    sprintf(szhProceso,"%s\0",szPROCESO);
    rtrim(szhProceso);
    strcpy(szhWait,WAIT);

    if (ifnValidaParametros(argc,argv,&stLineaComando) != 0) {
        fprintf (stdout,"\n\tError >> Fallo la Validacion de Parametros \n");
        fflush  (stdout);
        iResult = -1;
    } else {
        /*- Conexion a la Base de Datos -*/
        if (ifnConexionDB(&stLineaComando) != 0)   {
            fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
            fflush  (stdout);
            iResult = -2; 

        } 
        else
        {
             /* Chequea que la cola de Saldos Consolidados este en wait */
             while (1) 
             {
                 iRes = ifnVerFinColaAnterior(1);
                 if (iRes < 0) {
                   fprintf (stdout,"\n\tError >> Fallo el proceso \n");
                   fflush  (stdout);
                   iResult = -4; /* Fallo Proceso */
                   return iResult;
                
                } else if (iRes > 0) {
                   fprintf (stdout,"\n\tEl Proceso de Saldos aun se esta ejecutando.....!!!\n\n\n");
                   fflush  (stdout);
                   iResult = 0; /* Fallo Proceso */
                   sleep(10);
                    } else
                        break;
             }
            /*fprintf (stdout,"PASA POR ACA \n");*/
            fflush  (stdout);
            /*- Prepara Archivo de Log - */
            if (ifnPreparaArchivoLog() != 0)
            {
                fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
                fflush  (stdout);
                iResult = -3;  
            } 
            else 
            {
                    /*fprintf (stdout,"PASA POR ACA \n");*/
                    fflush  (stdout);
                /*- Ejecuta el proceso propiamente tal -*/
                    if (ifnEjecutaCola() != 0)   {
                    fprintf (stdout,"\n\tError >> Fallo el proceso \n");
                    fflush  (stdout);
                    iResult = -4; /* Fallo Proceso */

                    } else {
                   
                    /* EXEC SQL 
                    SELECT COD_ESTADO 
                    INTO :szhCodEstado
                    FROM CO_COLASPROC 
                    WHERE COD_PROCESO=:szhProceso; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 2;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLAS\
PROC where COD_PROCESO=:b1";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )5;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstado;
                    sqlstm.sqhstl[0] = (unsigned long )2;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhProceso;
                    sqlstm.sqhstl[1] = (unsigned long )6;
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


                    
                    if (SQLCODE)  {
                        ifnTrazasLog(modulo,"Fallo el proceso ( Validacion Cola Wait ) - %s",LOG02,SQLERRM);
                        fprintf (stdout,"\n\tError >> Fallo el proceso ( Validacion Cola Wait ) \n");
                        fflush  (stdout);
                        /*ifnMailAlert(szhProceso,"TODOS","FALLO LA VALIDACION FINAL DE LA COLA.");*/
                        iResult = -5; /* Fallo Proceso */

                    } else {

                        if ( strcmp(szhCodEstado,"W")!=0 ) {
                            /* LA COLA ESTA EN UN ESTADO DISTINTO DE WAIT */
                            /* SEÒALAR ESTO COMO ERROR E INTENTAR FORZARLA A WAIT */
                            ifnTrazasLog(modulo,"Regresando la Cola a Espera (%s)",LOG02,szhCodEstado);
                            /* EXEC SQL 
                            UPDATE CO_COLASPROC
                            SET COD_ESTADO = :szhWait
                            WHERE COD_PROCESO = :szhProceso ; */ 

{
                            struct sqlexd sqlstm;
                            sqlstm.sqlvsn = 12;
                            sqlstm.arrsiz = 2;
                            sqlstm.sqladtp = &sqladt;
                            sqlstm.sqltdsp = &sqltds;
                            sqlstm.stmt = "update CO_COLASPROC  set COD_ESTA\
DO=:b0 where COD_PROCESO=:b1";
                            sqlstm.iters = (unsigned int  )1;
                            sqlstm.offset = (unsigned int  )28;
                            sqlstm.cud = sqlcud0;
                            sqlstm.sqlest = (unsigned char  *)&sqlca;
                            sqlstm.sqlety = (unsigned short)256;
                            sqlstm.occurs = (unsigned int  )0;
                            sqlstm.sqhstv[0] = (unsigned char  *)szhWait;
                            sqlstm.sqhstl[0] = (unsigned long )2;
                            sqlstm.sqhsts[0] = (         int  )0;
                            sqlstm.sqindv[0] = (         short *)0;
                            sqlstm.sqinds[0] = (         int  )0;
                            sqlstm.sqharm[0] = (unsigned long )0;
                            sqlstm.sqadto[0] = (unsigned short )0;
                            sqlstm.sqtdso[0] = (unsigned short )0;
                            sqlstm.sqhstv[1] = (unsigned char  *)szhProceso;
                            sqlstm.sqhstl[1] = (unsigned long )6;
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



                            if (SQLCODE) {
                                ifnTrazasLog(modulo,"Fallo el proceso ( Update Cola Wait ) - %s",LOG02,SQLERRM);
                                fprintf (stdout,"\n\tError >> Fallo el proceso ( Update Cola Wait ) %s\n",SQLERRM );
                                fflush  (stdout);
                                /*ifnMailAlert(szhProceso,"TODOS","FALLO AL ACTUALIZAR LA COLA A 'WAIT'.");*/
                                iResult = -6; /* Fallo Proceso */
                            }                            

                            /* EXEC SQL COMMIT; */ 

{
                            struct sqlexd sqlstm;
                            sqlstm.sqlvsn = 12;
                            sqlstm.arrsiz = 2;
                            sqlstm.sqladtp = &sqladt;
                            sqlstm.sqltdsp = &sqltds;
                            sqlstm.iters = (unsigned int  )1;
                            sqlstm.offset = (unsigned int  )51;
                            sqlstm.cud = sqlcud0;
                            sqlstm.sqlest = (unsigned char  *)&sqlca;
                            sqlstm.sqlety = (unsigned short)256;
                            sqlstm.occurs = (unsigned int  )0;
                            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                            if (SQLCODE) {
                                          ifnTrazasLog(modulo,"Fallo el proceso ( Commit Cola Wait ) - %s",LOG02,SQLERRM);
                                fprintf (stdout,"\n\tError >> Fallo el proceso ( Commit Cola Wait ) %s\n", SQLERRM );
                                fflush  (stdout);
                                iResult = -7; 
                            }                            
                            ifnTrazasLog(modulo,"COMMIT OK. Cola forzada a espera",LOG02);
                        }
                    }
                    }

               vfnCierraArchivoLog();
                
            }
        }
    }

     return iResult;
}


/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
char modulo[] = "ifnValidaParametros";

extern  char  *optarg;
extern  int  optind, opterr, optopt;
int     iOpt = 0;
char    opt[] = ":u:l:n:";
char   *psztmp = "";
int     iUserflag = 0, iLogflag = 0, iError = 0;

   opterr = 0;
    stStatus.iLogNivel = iLOGDEFAULT;

    /* Analisis de los argumentos recibidos */
    while( ( iOpt = getopt( argc, argv, opt ) ) != EOF )
    {
        switch( iOpt )
        {
            case 'u':  /* Usuario/Password */
                    if( !iUserflag )
                    {
                        strcpy( pstLC->szUsuarioOra, optarg );
                        iUserflag = 1;
                        printf("USUARIO [%s]",pstLC->szUsuarioOra);
                        if( ( psztmp = (char *)strchr( pstLC->szUsuarioOra,'/' ) ) == (char *)NULL )
                        {
                            fprintf( stderr, "\n\tError >> Usuario no valido. Requiere '/' \n" );
                            fflush( stderr );
                            return STATUS_ERR;
                        }
                        else
                        {
                            strncpy( pstLC->szOraAccount, pstLC->szUsuarioOra, psztmp-pstLC->szUsuarioOra );
                            strcpy( pstLC->szOraPasswd, psztmp + 1 );
                        }
                    }
                    else
                    {
                        fprintf( stderr, "\n\tError >> opcion '-%c' duplicada\n", optopt );
                        fflush( stderr );
                        return STATUS_ERR;
                    }
                    break;

            case 'l': /*-- Nivel de Log --*/
                    if( !iLogflag )
                    {
                        stStatus.iLogNivel = ( atoi( optarg ) > 0 ) ? atoi( optarg ) : iLOGDEFAULT;
                        iLogflag = 1;
                    }
                    else
                    {
                        fprintf( stderr, "\n\tError >> opcion '-%c' duplicada\n", optopt );
                        fflush( stderr );
                        return STATUS_ERR;
                    }
                    break;

         case 'n': /*-- Nombre de la Cola (codigo del proceso) --*/
              strcpy(szPROCESO,optarg);
              break;

            case '?':
                    fprintf( stderr, "\n\tError >> opcion '-%c' es desconocida\n", optopt );
                    fflush( stderr );
                    return STATUS_ERR;

            case ':':
                    fprintf( stderr, "\n\tError >> falta argumento para opcion '-%c'\n", optopt );
                    fflush( stderr );
                    return STATUS_ERR;
        } /* switch( iOpt ) */
    } /* while( ( iOpt = getopt( argc, argv, opt ) ) != EOF ) */

    pstLC->iLogLevel = stStatus.iLogNivel;

    if( !iUserflag )    {
        fprintf( stderr, "\n\nFalta parametro Usuario/Password.\n" );    
        fflush( stderr );
        iError = 1;
    }        

    if( iError )    {
        fprintf( stderr, "\n\nUso de Programa.\n" );    
        fprintf( stderr, "Co_EvalCM -u<usuario/password> -l<Nivel Log>.\n" );    
        fflush( stderr );
        return STATUS_ERR;
    }

    return STATUS_OK;
} /* int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC ) */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB( LINEACOMANDO *pstLC )
{
char modulo[] = "ifnConexionDB";

    printf("[%s]",pstLC->szOraAccount);
    printf("[%s]",pstLC->szOraPasswd);
    if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  )    {
        fprintf( stderr, "\nNo hay conexion a ORACLE \n" );
        fflush( stderr );
        return STATUS_ERR;
    }

    return STATUS_OK;
}

/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
char modulo[] = "ifnPreparaArchivoLog";
int sts = 0;

    /*fprintf (stdout,"PASA POR ACA1 \n");*/
    fflush  (stdout);

    if(!getenv("XPC_LOG"))
    {
        fprintf (stdout,"VARIABLE DE AMBIENTE XPC_LOG NO FUE SETEADA \n");
        fflush  (stdout);
        exit(1);
    }

    sprintf( stStatus.szFileName, "%s", szPROCESO );
    sprintf( stStatus.szLogPathGene, "%s/CO_SCHEDULER", getenv( "XPC_LOG" ) );

    sts = ifnAbreArchivoLog( 1 ); 
    return sts;
} /* end ifnPreparaArchivoLog */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* ============================================================================= */
int ifnAbreArchivoLog()
{
char modulo[] = "ifnAbreArchivoLog";
char szArchivoErr[256], szArchivoLog[256], szComando[256]; 
static char szAux[9];

   memset( szArchivoLog, '\0', sizeof( szArchivoLog ) ); /* log */         
   memset( szArchivoErr, '\0', sizeof( szArchivoErr ) ); /* errores */     

   strcpy( szAux, (char *)szSysDate( "YYYYMMDD" ) );
   sprintf( szComando, "/usr/bin/mkdir -p %s/%s", stStatus.szLogPathGene, szAux );
   if( system( szComando ) != 0 )    {
        fprintf( stderr, "Error al intentar crear directorio de Log\n" );
        fflush ( stderr );
        return STATUS_ERR;
   }
    
   sprintf( szArchivoLog, "%s/%s/%s.log", stStatus.szLogPathGene, szAux, stStatus.szFileName );
   sprintf( szArchivoErr, "%s/%s/%s.err", stStatus.szLogPathGene, szAux, stStatus.szFileName );
    
   if( ( stStatus.LogFile = fopen( szArchivoLog, "a" ) ) == (FILE*)NULL )   {    
        fprintf( stderr, "Error al crear archivo de Log.\n" );
        fflush( stderr );
        return STATUS_ERR;    
   }
    
   if( ( stStatus.ErrFile = fopen( szArchivoErr, "a" ) ) == (FILE*)NULL )   {    
        fprintf( stderr, "Error al crear archivo de Errores.\n" );
        fflush( stderr );
        STATUS_ERR;    
   }

   fprintf( stStatus.LogFile, "\n\n\t%s - APERTURA DE ARCHIVO SEGUN UNIX <%ld> -\n", szGetTime(1), getpid() );

    return STATUS_OK;
}/* end ifnAbreArchivoLog */

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs        */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
char modulo[] = "vfnCierraArchivoLog";

    fprintf( stStatus.LogFile, "\n\n\t%s - CIERRE DE ARCHIVO SEGUN UNIX <%ld> -\n\n", szGetTime(1), getpid() );

    if( fclose( stStatus.LogFile ) != 0 )    {    
        fprintf( stderr,"Error al cerrar archivo de Log\n" );
        fflush( stderr );
    }

    if( fclose( stStatus.ErrFile ) != 0 )    {    
        fprintf( stderr, "Error al cerrar archivo de Errores\n" );
        fflush( stderr );
    }

    return;
} /* end vfnCierraArchivoLog */

/* ============================================================================= */
/* ifnEjecutaCola(): Ejecuta las acciones propias del proceso                 */
/* ============================================================================= */
int ifnEjecutaCola()
{
char modulo[] = "ifnEjecutaCola";
char szIniProc[9], szFinProc[9], szTmpProc[9];
int  iDifSegs = 0;
int  i, j, k, ierror;

    memset( szIniProc, '\0', sizeof( szIniProc ) );
    memset( szFinProc, '\0', sizeof( szFinProc ) );
    memset( szTmpProc, '\0', sizeof( szTmpProc ) );
    mutex_init(&bufferlock, NULL, NULL );
    sema_init (&semaflock , 1, NULL, NULL );
    strcpy(szhVigente,VIGENTE);
    strcpy(szhCO  ,CO);
    strcpy(szhUSER,USUARIO_COBROS);

    
    sprintf( szIniProc, "%s", szSysDate( "HH24:MI:SS" ) );
    ifnTrazasLog( modulo, "===>>> %s VERSION => [%s].\n", LOG03, szPROCESO, szVERSION );
    ifnTrazasLog( modulo, "Corriendo la cola lanzada", LOG03 );

    /*'Launched->Running'*/
    if( !bfnCambiaEstadoCola( szPROCESO, "L", "R" ) ) 
    {
        if( !bfnOraRollBack() ) ifnTrazasLog( modulo, "En Rollback 'L->R' : %s", LOG00, SQLERRM );
        return STATUS_ERR;

    }
    else
    {
        if( !bfnOraCommit() )
        {
            ifnTrazasLog( modulo, "En Commit 'L->R' : %s", LOG00, SQLERRM );
            if( !bfnOraRollBack() ) 
                ifnTrazasLog( modulo, "En Rollback : %s", LOG00, SQLERRM );
            return STATUS_ERR;    
        }
    }

    /* Calcula porcentaje de memoria libre y usada */
    if (ifnMemoriaUsada(&lhCpu)!=0) return STATUS_ERR;
    /* Carga categorias , acciones y criterios */
    if (ifnPtosCateg (&lsCat) != 0) return STATUS_ERR;

    /* Rescatamos cantidad maxima de instancias en ejecucion */
    /* definidas por el usuario                                     */
    /* EXEC SQL
    SELECT  NVL(TO_NUMBER(CNT_INSTANCIA_USR),:ihValor_Uno)
    INTO    :ihNUM_INSTAN
    FROM    CO_INSTANCIA_TO         
    WHERE   COD_PROCESO = :szhProceso
    AND     ESTADO       = :szhVigente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(TO_NUMBER(CNT_INSTANCIA_USR),:b0) into :b1  fr\
om CO_INSTANCIA_TO where (COD_PROCESO=:b2 and ESTADO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )66;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Uno;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNUM_INSTAN;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhProceso;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhVigente;
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


    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "Error INSTANCIAS_EVAL %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    
    
    if (ihNUM_INSTAN==0) ihNUM_INSTAN=1;
    ifnTrazasLog( modulo, "\n\tINSTANCIAS_EVAL  [%d].", LOG03, ihNUM_INSTAN);  

    /* EXEC SQL
    SELECT VAL_PARAMETRO
    INTO   :szhUser_Cobros
    FROM   GED_PARAMETROS
    WHERE  NOM_PARAMETRO= :szhUSER
    AND    COD_MODULO   = :szhCO
    AND    COD_PRODUCTO = :ihValor_Uno; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )97;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhUser_Cobros;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhUSER;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCO;
    sqlstm.sqhstl[2] = (unsigned long )3;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Uno;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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


    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "Error SELECT VAL_PARAMETRO (USUARIO_COBROS) %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    

    /* Insertando estadisticas del proceso padre. Secuencia de este corresponde a 0 */
    if (ifnInsertaEstadisticas(iSec_Padre, szhProceso) != 0 ) return STATUS_ERR;

    /* seleccion de candidatos a morosos */
    if (ifnCandidatosMorosos() != 0) return STATUS_ERR;    
    /* verificamos que hayan registros por procesar*/
    if (lTotalRows > 0 ) 
    {
         /****************************************************************************************/
         /*Calculamos la cantidad de nodos a pasar por cada hilo*/
         if ( (lTotalRows % ihNUM_INSTAN) ==0 ) 
             ihRAN_LISTAS=(lTotalRows/ihNUM_INSTAN);
         else
             ihRAN_LISTAS=(lTotalRows/ihNUM_INSTAN)+1;

        ifnTrazasLog( modulo, "Cantidad Clientes a Evaluar por Hilo [%d]\n", LOG03,ihRAN_LISTAS);  
        /****************************************************************************************/
        /* De acuerdo al rango se segmenta la lista     */
        if (ifnSeccionaLista(lTotalRows) !=0 ) 
            return STATUS_ERR;

        /* Rescatamos la secuencia para el ult_proceso de la co_morosos
        para que todos los hilos queden con el mismo valor                */
           /* EXEC SQL SELECT CO_SEQ_EVALUADOR.NEXTVAL INTO :lhSecMoroso FROM DUAL; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 4;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "select CO_SEQ_EVALUADOR.nextval  into :b0  from DU\
AL ";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )128;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqhstv[0] = (unsigned char  *)&lhSecMoroso;
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

 
        /****************************************************************************************/
        /* ejecutamos los hilos de acuerdo a la vble ihNUM_INSTAN*/
        if (ifnEjecutaHilos() != 0) 
            return STATUS_ERR;

    }
    else 
    {
        ifnTrazasLog( modulo, "No existen clientes por procesar.", LOG02);  
    }

    vfnEliminaNodoAccion(&stListaAcCM);
    Destruir_lista(&stListaClientes);
    vfnBorraListaCateg(&lsCat);

    /****************************************************************************************/
    /* Informacion Estadistica */
    sprintf( szFinProc, "%s", szSysDate( "HH24:MI:SS" ) );        
    if( ( iDifSegs = ifnRestaHoras( szIniProc, szFinProc, szTmpProc ) ) >= 0 )    {

        if (ifnUpdateEstadisticas( szhProceso, iDifSegs , lTotalRows, iSec_Padre) !=0 ) return STATUS_ERR;
        if (ifnInsertaParamUnix(szhProceso, ihNUM_INSTAN, lhCpu)!=0) return STATUS_ERR;

        ifnTrazasLog( modulo, "\n\n   RESUMEN DEL PROCESO SEGUN ORACLE.\n"
                              "   ==============================================================\n"
                              "   HORA INICIO  => [%s]\n"
                              "   HORA TERMINO => [%s]\n"
                              "   TIEMPO TOTAL => [%s] [%d segs]\n" 
                              "   TOTAL REGISTROS PROCESADOS => [%ld]\n"
                              "   ==============================================================\n",
                              LOG03, szIniProc, szFinProc, szTmpProc, iDifSegs, lTotalRows );
    }
    
    return STATUS_OK;
}

int ifnUpdateExcluidosAcciones(int cod_cliente)
{

    char modulo[] = "ifnUpdateExcluidosAcciones";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int bind_cod_cliente;
    /* EXEC SQL END DECLARE SECTION; */ 


    bind_cod_cliente = cod_cliente;
    /* EXEC SQL UPDATE CO_EXCLUIDOS_ACCIONES_TO SET FEC_INI_EXCLUSION = SYSDATE WHERE COD_CLIENTE = :bind_cod_cliente ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_EXCLUIDOS_ACCIONES_TO  set FEC_INI_EXCLUSION=SY\
SDATE where COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )147;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&bind_cod_cliente;
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



    if( SQLCODE != SQLOK)
    {
        ifnTrazasLog( modulo, "Error UPDATE CO_EXCLUIDOS_ACCIONES_TO %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }

    return STATUS_OK;
}

/* ============================================================================= */
/* Funcion que selecciona los candidatos a morosos                              */
/* ============================================================================= */
int ifnCandidatosMorosos()
{
char modulo[] = "ifnCandidatosMorosos";
long lRowsThisLoop = 0, lRowsProcessed = 0;
int  iRetSQLCODE = 0;
char szIniProc[9], szFinProc[9];
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhCadena [2048];
    int  ihFec_saldo     ;
    char szhCo_cartera   [11];     
    char szhCod_tipdocum [13];
    char szhME            [3];
    char szhMR            [3];
    char szhNatur         [6];
    char szhLetra_e       [2];
/* EXEC SQL END DECLARE SECTION; */ 


    ifnTrazasLog( modulo, "\n\t------ EVALUACION DE CANDIDATOS A MOROSOS. ------\n", LOG03);
    sprintf( szIniProc, "%s", szSysDate( "HH24:MI:SS" ) );
    ifnTrazasLog( modulo, "\tHora Inicio Carga de Datos (Lista) [%s].\n", LOG03 ,szIniProc);
    strcpy(szhLetra_e    ,LETRA_E    );
    strcpy(szhMR ,MR );
    strcpy(szhME ,ME);
    strcpy(szhNatur,NATUR);
    strcpy(szhCo_cartera  ,CO_CARTERA  );
    strcpy(szhCod_tipdocum,COD_TIPDOCUM);
   
    /* EXEC SQL
    SELECT TO_NUMBER(TO_CHAR(TRUNC(SYSDATE),'yyyymmdd')) - nvl(TO_NUMBER(TO_CHAR(MAX(TRUNC(FEC_SALDO)),'yyyymmdd')),to_number(to_char(sysdate-:ihValor_Uno,'yyyymmdd')))
      INTO   :ihFec_saldo
      FROM CO_SALDOCONS_TO
    WHERE  ROWNUM < :ihValor_Dos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select (TO_NUMBER(TO_CHAR(TRUNC(SYSDATE),'yyyymmdd'))-nvl\
(TO_NUMBER(TO_CHAR(max(TRUNC(FEC_SALDO)),'yyyymmdd')),to_number(to_char((sysda\
te-:b0),'yyyymmdd')))) into :b1  from CO_SALDOCONS_TO where ROWNUM<:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )166;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Uno;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihFec_saldo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Dos;
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


    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) 
    {
        ifnTrazasLog( modulo, "\tEn Fec_saldo  CO_SALDOCONS_TO\n\t %s", LOG01, SQLERRM );
        return STATUS_ERR;
    }
    
    /* Variable utilizada en funcion general del calculo del saldo no vencido */
    iFec_Saldo=ihFec_saldo;
    /* Si es 0 se asume que el proceso de saldo ya fue ejecutado para este dia por   */
    /*    lo que se selecciona de la CO_SALDOCONS_TO                                                     */
    /*    En caso contrario se asume que no se ejecuto y se selecciona de la co_cartera    */
    if (ihFec_saldo == 0 )  {    

        sprintf(szhCadena,"SELECT C.COD_CLIENTE ,\n"
                                "       NVL(TO_CHAR(TRUNC(C.FEC_VENCIMIE),'YYYYMMDD'),' '),\n"
                                "       NVL(TO_CHAR(TRUNC(SYSDATE),'YYYYMMDD'),' '),\n"
                                "       :v1  COD_GESTION,\n"
                                "       C.SALDO_VENCIDO,\n"
                                "       TO_NUMBER(:v2)   SEC_MOROSO,\n"
                                "       :v3 COD_CATEGORIA,\n"
                                "       DECODE(E.FEC_INI_EXCLUSION,NULL,DECODE(E.FEC_INGRESO,NULL,0,1),2) \n" /*P-COL-08006 RLM*/
                                "FROM   CO_SALDOCONS_TO C ,\n"
                                "       CO_EXCLUIDOS_ACCIONES_TO E\n" /*P-COL-08006 RLM*/
                                "WHERE  C.FEC_VENCIMIE < TRUNC(SYSDATE)\n"    
                                "AND    NOT EXISTS (SELECT TO_NUMBER(:v4) FROM  CO_MOROSOS N WHERE N.COD_CLIENTE = C.COD_CLIENTE)\n"
                                "AND    C.COD_CLIENTE = E.COD_CLIENTE(+) \n" /*P-COL-08006 RLM*/
                                "AND    E.FEC_INGRESO(+) IS NOT  NULL \n"  /*P-COL-08006 RLM*/
                                "UNION ALL\n"
                                "SELECT C.COD_CLIENTE,\n"
                                "       TO_CHAR(C.FEC_VENCIMIE,'YYYYMMDD'),\n"
                                "       NVL(TO_CHAR(TRUNC(M.FEC_PRORROGA),'YYYYMMDD'),' '),\n"
                                "       :v5 AS COD_GESTION,\n"
                                "       C.SALDO_VENCIDO,\n"
                                "       M.SEC_MOROSO,\n"
                                "       :v6  COD_CATEGORIA,\n"
                                "       DECODE(E.FEC_INI_EXCLUSION,NULL,DECODE(E.FEC_INGRESO,NULL,0,1),2) \n" /*P-COL-08006 RLM*/
                                "FROM   CO_MOROSOS M,\n"
                                "       CO_SALDOCONS_TO C,\n"
                                "       CO_EXCLUIDOS_ACCIONES_TO E\n" /*P-COL-08006 RLM*/
                                "WHERE  M.COD_CLIENTE = C.COD_CLIENTE\n"
                                "AND    M.TIP_MOROSO = :v7 \n"
                                "AND    C.COD_CLIENTE = E.COD_CLIENTE(+) " /*P-COL-08006 RLM*/
                                "AND    E.FEC_INGRESO(+) IS NOT  NULL \n"); /*P-COL-08006 RLM*/
    } else  {

        sprintf(szhCadena,"SELECT C.COD_CLIENTE,\n"
                                "       NVL(TO_CHAR(MIN(TRUNC(C.FEC_VENCIMIE)),'YYYYMMDD'),' '),\n"
                                "       NVL(TO_CHAR(TRUNC(SYSDATE),'YYYYMMDD'),' '),\n"
                                "       :v1  COD_GESTION,\n"
                                "       SUM(C.IMPORTE_DEBE - C.IMPORTE_HABER),\n"
                                "       TO_NUMBER(:v2)  SEC_MOROSO,\n"
                                "       :v3  COD_CATEGORIA,\n"
                                "       DECODE(E.FEC_INI_EXCLUSION,NULL,DECODE(E.FEC_INGRESO,NULL,0,1),2) \n" /*P-COL-08006 RLM*/
                                "FROM   CO_CARTERA C,\n"
                                "       CO_EXCLUIDOS_ACCIONES_TO E \n" /*P-COL-08006 RLM*/
                                "WHERE  C.COD_CLIENTE > TO_NUMBER(:v4)\n"
                                "AND    C.FEC_VENCIMIE < TRUNC(SYSDATE)\n"
                                "AND    C.IND_FACTURADO = TO_NUMBER(:v5)\n"
                                "AND    C.COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)\n"
                                "                              FROM CO_CODIGOS\n"
                                "                              WHERE NOM_TABLA = :v6\n"
                                "                              AND   NOM_COLUMNA = :v7)\n"
                                "AND   NOT EXISTS (SELECT TO_NUMBER(:v8) FROM  CO_MOROSOS N WHERE N.COD_CLIENTE = C.COD_CLIENTE)\n"
                                "AND   C.COD_CLIENTE = E.COD_CLIENTE(+) \n"  /*P-COL-08006 RLM*/
								        "AND   E.FEC_INGRESO(+) IS NOT  NULL\n"  /*P-COL-08006 RLM*/
                                "GROUP BY C.COD_CLIENTE , E.FEC_INGRESO, E.FEC_INI_EXCLUSION \n" /*P-COL-08006 RLM*/
                                "HAVING SUM(IMPORTE_DEBE - IMPORTE_HABER) > TO_NUMBER(:v9)\n"
                                "UNION ALL\n"
                                "SELECT C.COD_CLIENTE,\n"
                                "       TO_CHAR(MIN(C.FEC_VENCIMIE),'YYYYMMDD'),\n"
                                "       NVL(TO_CHAR(MIN(TRUNC(M.FEC_PRORROGA)),'YYYYMMDD'),' '),\n"
                                "       :v10  COD_GESTION,\n"
                                "       SUM(C.IMPORTE_DEBE - C.IMPORTE_HABER) ,\n"
                                "       M.SEC_MOROSO ,\n"
                                "       :v11  COD_CATEGORIA, \n"
                                "       DECODE(E.FEC_INI_EXCLUSION,NULL,DECODE(E.FEC_INGRESO,NULL,0,1),2) \n" /*P-COL-08006 RLM*/
                                "FROM   CO_MOROSOS M, CO_CARTERA C , \n"
                                "       CO_EXCLUIDOS_ACCIONES_TO E\n"  /*P-COL-08006 RLM*/
                                "WHERE  M.COD_CLIENTE = C.COD_CLIENTE\n"
                                "AND    C.FEC_VENCIMIE < TRUNC(SYSDATE)\n" /* XO-200508090319  09-08-2005 Soporte RyC PRM. Homologacin de incidencia XM-200412200216 */
                                "AND    C.IND_FACTURADO = TO_NUMBER(:v12)\n"
                                "AND    C.COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)\n"
                               "                              FROM CO_CODIGOS\n"
                                  "                              WHERE NOM_TABLA = :v13\n"
                                  "                              AND   NOM_COLUMNA = :v14)\n"
                                "AND   M.TIP_MOROSO = :v15\n"
                                "AND   C.COD_CLIENTE = E.COD_CLIENTE(+) \n" /*P-COL-08006 RLM*/
								        "AND    E.FEC_INGRESO(+) IS NOT  NULL\n"  /*P-COL-08006 RLM*/
                                "GROUP BY C.COD_CLIENTE,M.SEC_MOROSO,M.COD_CATEGORIA,E.FEC_INGRESO,E.FEC_INI_EXCLUSION \n"  /*P-COL-08006 RLM*/
                                "HAVING SUM(IMPORTE_DEBE - IMPORTE_HABER) > TO_NUMBER(:v16)\n");
    }

    /*printf("    szhCadena : \n%s\n",szhCadena);*/
    ifnTrazasLog( modulo, "szhCadena : \n%s", LOG06, szhCadena);  
    /* EXEC SQL PREPARE SqlDinamico FROM :szhCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )193;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCadena;
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


    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "Error PREPARE SqlDinamico - %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    

    /* EXEC SQL DECLARE c_ClientesCM CURSOR FOR SqlDinamico; */ 

    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "Error DECLARE c_ClientesCM - %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    

    if (ihFec_saldo == 0 ) {
        /* EXEC SQL OPEN c_ClientesCM USING :szhMR, :ihValor_Cero, :szhNatur, :ihValor_Uno, :szhME, :szhNatur, :szhLetra_e; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )212;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhMR;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Cero;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhNatur;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Uno;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhME;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhNatur;
        sqlstm.sqhstl[5] = (unsigned long )6;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhLetra_e;
        sqlstm.sqhstl[6] = (unsigned long )2;
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


    } else {
        /* EXEC SQL OPEN c_ClientesCM USING :szhMR  , :ihValor_Cero, :szhNatur , :ihValor_Cero,  :ihValor_Uno, :szhCo_cartera , 
                                                   :szhCod_tipdocum, :ihValor_Uno  , :ihValor_Cero, :szhME, :szhNatur, :ihValor_Uno, 
                                                :szhCo_cartera, :szhCod_tipdocum, :szhLetra_e  , :ihValor_Cero ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )255;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhMR;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Cero;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhNatur;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Cero;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Uno;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCo_cartera;
        sqlstm.sqhstl[5] = (unsigned long )11;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCod_tipdocum;
        sqlstm.sqhstl[6] = (unsigned long )13;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_Uno;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&ihValor_Cero;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhME;
        sqlstm.sqhstl[9] = (unsigned long )3;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szhNatur;
        sqlstm.sqhstl[10] = (unsigned long )6;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&ihValor_Uno;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szhCo_cartera;
        sqlstm.sqhstl[12] = (unsigned long )11;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szhCod_tipdocum;
        sqlstm.sqhstl[13] = (unsigned long )13;
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szhLetra_e;
        sqlstm.sqhstl[14] = (unsigned long )2;
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&ihValor_Cero;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
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
                                                    
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "Error OPEN c_ClientesCM %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    

    /* Creo una lista con datos */
    Inicializar_lista(&stListaClientes);
    
    lRowsProcessed=0;
    while( 1 ) 
    {
        /* EXEC SQL 
        FETCH c_ClientesCM
         INTO :sthClientes; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 16;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )30000;
        sqlstm.offset = (unsigned int  )334;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)sthClientes.lCod_Cliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sthClientes.szFec_Vencimiento;
        sqlstm.sqhstl[1] = (unsigned long )9;
        sqlstm.sqhsts[1] = (         int  )9;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sthClientes.szFec_Prorroga;
        sqlstm.sqhstl[2] = (unsigned long )9;
        sqlstm.sqhsts[2] = (         int  )9;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)sthClientes.szCod_Gestion;
        sqlstm.sqhstl[3] = (unsigned long )6;
        sqlstm.sqhsts[3] = (         int  )6;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)sthClientes.dSaldo_Vencido;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[4] = (         int  )sizeof(double);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)sthClientes.lSec_Moroso;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )sizeof(long);
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)sthClientes.szCod_Categoria;
        sqlstm.sqhstl[6] = (unsigned long )6;
        sqlstm.sqhsts[6] = (         int  )6;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)sthClientes.iflg_reclamo;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )sizeof(int);
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



        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
            ifnTrazasLog( modulo, "\tEn FETCH c_ClientesCM\n\t %s", LOG01, SQLERRM );
            iError = STATUS_ERR;
            break;
        }

        lTotalRows = SQLROWS;    /* Total de filas recuperadas */
         iRetSQLCODE = SQLCODE;
         lRowsThisLoop = ( lTotalRows - lRowsProcessed );    /* filas recuperadas en esta iteracion (Total-Procesadas) */
        ifnTrazasLog( modulo, "\tlTotalRows = [%ld], lRowsThisLoop = [%ld]\n\t", LOG03, lTotalRows, lRowsThisLoop );

        if (ifnCargaLista(lRowsThisLoop)!=0) return STATUS_ERR;

      lRowsProcessed = lTotalRows; /* Resetea Contador, Total las filas recuperadas se han procesado */
        if( iRetSQLCODE == SQLNOTFOUND )  {
            ifnTrazasLog( modulo, "\tFin de Datos c_ClientesCM.\n", LOG03 );
            break;
        }
    } 


    /* EXEC SQL CLOSE c_ClientesCM; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )381;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "Error CLOSE c_ClientesCM %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    

    sprintf( szFinProc, "%s", szSysDate( "HH24:MI:SS" ) );
    ifnTrazasLog( modulo, "\tHora Fin Carga de Datos (Lista) [%s].\n", LOG03 ,szFinProc); 
    return STATUS_OK;
}


/* ============================================================================= */
/* Funcion que carga la lista con los campos de la estructura                            */
/* ============================================================================= */
int ifnCargaLista(long lFilas) 
{
char modulo[] = "ifnCargaLista";
int  i, j;
char szCateg [6];

    for( i = 0; i < lFilas; i++ ) {
        
        if (!bfnGetPerfil(sthClientes.lCod_Cliente[i], sthClientes.szCod_Categoria[i]))   return STATUS_ERR;
        iLB.lCod_Cliente  =sthClientes.lCod_Cliente[i];
        iLB.dSaldo_Vencido=sthClientes.dSaldo_Vencido[i];
        iLB.lSec_Moroso   =sthClientes.lSec_Moroso[i];
        iLB.iflg_reclamo  =sthClientes.iflg_reclamo[i];
        sprintf(iLB.szFec_Vencimiento,"%s\0",sthClientes.szFec_Vencimiento[i]);
        sprintf(iLB.szFec_Prorroga   ,"%s\0",sthClientes.szFec_Prorroga[i]);
        sprintf(iLB.szCod_Gestion    ,"%s\0",sthClientes.szCod_Gestion [i]);
        sprintf(iLB.szCod_Categoria  ,"%s\0",sthClientes.szCod_Categoria[i]);
        rtrim(iLB.szFec_Vencimiento);
        rtrim(iLB.szFec_Prorroga);
        rtrim(iLB.szCod_Gestion);
        rtrim(iLB.szCod_Categoria);
        stListaClientes->Accion_sgte=NULL;
        if (Insertar_pos(stListaClientes , iLB,1)) {
            puts("\n\aERROR: No existe memoria suficiente.");
           ifnTrazasLog( modulo, "No existe memoria suficiente.", LOG01);
            return STATUS_ERR;
        }

       ifnTrazasLog( modulo, "\n\t[%03d] sthClientes.lCod_Cliente           [%ld]", LOG06, i, sthClientes.lCod_Cliente[i] );
       ifnTrazasLog( modulo, "[%03d] iLB.lCod_Cliente                   [%ld]", LOG06, i, iLB.lCod_Cliente );
       ifnTrazasLog( modulo, "[%03d] iLB.szFec_Vencimiento              [%s]", LOG06, i, iLB.szFec_Vencimiento );
       ifnTrazasLog( modulo, "[%03d] iLB.szFec_Prorroga                 [%s]", LOG06, i, iLB.szFec_Prorroga );
       ifnTrazasLog( modulo, "[%03d] iLB.szCod_Gestion                  [%s]", LOG06, i, iLB.szCod_Gestion );
       ifnTrazasLog( modulo, "[%03d] iLB.dSaldo_Vencido                 [%f]", LOG06, i, iLB.dSaldo_Vencido );
       ifnTrazasLog( modulo, "[%03d] iLB.szCod_Categoria                [%s]", LOG06, i, iLB.szCod_Categoria );
       ifnTrazasLog( modulo, "[%03d] iLB.lSec_Moroso                    [%ld]", LOG06, i, iLB.lSec_Moroso );
       ifnTrazasLog( modulo, "[%03d] iLB.iflg_reclamo                   [%ld]", LOG06, i, iLB.iflg_reclamo );
       ifnTrazasLog( modulo, "************************************************************************", LOG06);

    }

    return 0;

}
/* ============================================================================= */
/* Funcion que actualiza el cod_categoria de la estructura general               */
/* ============================================================================= */
int ifnInsertaCategoria(int x) 
{
char modulo[]="ifnInsertaCategoria";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char  szDes_Valor [6]; /* EXEC SQL VAR szDes_Valor IS STRING(6); */ 
 
    char  szhGe_Clientes [12];
    char  szhCategoria   [14];
/* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhGe_Clientes,GE_CLIENTES);
    strcpy(szhCategoria,CATEGORIA);

    /* EXEC SQL
    SELECT DES_VALOR 
    INTO   :szDes_Valor
    FROM   CO_CODIGOS  
    WHERE  NOM_TABLA   = :szhGe_Clientes
    AND    NOM_COLUMNA = :szhCategoria
    AND    COD_VALOR   = ( SELECT TO_CHAR(COD_CATEGORIA) FROM GE_CLIENTES WHERE COD_CLIENTE = :sthClientes.lCod_Cliente[x]) ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 16;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DES_VALOR into :b0  from CO_CODIGOS where ((NOM_TA\
BLA=:b1 and NOM_COLUMNA=:b2) and COD_VALOR=(select TO_CHAR(COD_CATEGORIA)  fro\
m GE_CLIENTES where COD_CLIENTE=:b3))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )396;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szDes_Valor;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhGe_Clientes;
    sqlstm.sqhstl[1] = (unsigned long )12;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCategoria;
    sqlstm.sqhstl[2] = (unsigned long )14;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(sthClientes.lCod_Cliente)[x];
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


    
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
        ifnTrazasLog( modulo, "SELECT DES_VALOR FROM CO_CODIGOS  -  %s.", LOG00, SQLERRM );  
        return STATUS_ERR;
    }    

    sprintf(sthClientes.szCod_Categoria[x],"%s\0",szDes_Valor);
    ifnTrazasLog( modulo, "\t\t sthClientes.szCod_Categoria[x]   [%s].", LOG05, sthClientes.szCod_Categoria[x]);  
    
    return 0;

}

/* ================================================================================ */
/* Funcion que segmenta en n partes la lista de acuerdo al valor obtenido entre     */
/* el total de clientes y la cantidad de instancias ingresadas por el usuario       */
/* cuyo resultado se guarda en la variable ihRAN_LISTAS con la cual se podra tener  */
/* la cantidad de hilos    a ejecutar                                                                     */
/* ================================================================================ */
int ifnSeccionaLista(long lTotalReg)
{
char modulo[] = "ifnSeccionaLista";
int  i, j;
stLista pf;

    iNumeroHilos=0;
    if (((pInicio)=(stLista *) malloc(ihNUM_INSTAN * sizeof(stLista))) == NULL)    exit(STATUS_ERR);
    if (((pFinal) =(stLista *) malloc(ihNUM_INSTAN * sizeof(stLista))) == NULL)    exit(STATUS_ERR);

   ifnTrazasLog( modulo, "Comienza segmentacion a lista...lTotalReg [%ld]", LOG03,lTotalReg);
    for(i = 0, j = 0, pf = stListaClientes->sgte; pf && i < lTotalReg; i++ ) {

        if (i == 0) {
            pInicio[j] = stListaClientes;
            iNumeroHilos++;
            
        } else if (i >= ihRAN_LISTAS) {

                if ((i % ihRAN_LISTAS) == 0) {
                    iNumeroHilos++;
                    pFinal[j++]->sgte = NULL;
                    Inicializar_lista(&pInicio[j]);
                    pInicio[j]->sgte = pf;
                }
        }
        pFinal[j] = pf;
        pf = pf->sgte;
    }


    ifnTrazasLog( modulo, "NumeroHilos a Ejecutar [%d]\n\n", LOG03,iNumeroHilos);  

    return 0;
}

/* ============================================================================= */
/* Funcion que ejecuta los hilos que se hayan generado de acuerdo al tama±o de   */
/*    la lista que guarda los clientes a procesar                                      */
/* ============================================================================= */
int ifnEjecutaHilos()
{
char modulo[] = "ifnEjecutaHilos";
int  i, j, error=0; 
long iDiffSeg=0;
char szIniHilo[9], szFinHilo[9], szTmpHilo[9];
stLista lstClies;

    memset( szIniHilo, '\0', sizeof( szIniHilo ) );
    memset( szFinHilo, '\0', sizeof( szFinHilo ) );
    memset( szTmpHilo, '\0', sizeof( szTmpHilo ) );

    sprintf( szIniHilo, "%s", szSysDate( "HH24:MI:SS" ) );
    thr_setconcurrency(iNumeroHilos+1);

    for(i = 0; i < iNumeroHilos; i++)    
    {
        iSec_Hijo++;
        lCliesxHilo[i]=0;
        if (ifnInsertaEstadisticas(iSec_Hijo , szhProceso) != 0 ) 
            return STATUS_ERR;

        error = thr_create (NULL, NULL, vfnEvaluaCM, (void *) &i, NULL, &idHilo[i] );
        if (error != 0)    
        {
            /* Comprobamos el error al arrancar el thread */
            ifnTrazasLog( modulo, "No puedo crear thread", LOG01);  
            exit (STATUS_ERR);
        } 
        sleep(1);
    }
    for(i = 0; i < iNumeroHilos; i++)
    {
      thr_join(idHilo[i], NULL, NULL );
    } 

    for(i = 0; i < iNumeroHilos; i++)
    {
        sprintf( szFinHilo, "%s", szSysDate( "HH24:MI:SS" ) );
        iDiffSeg = ifnRestaHoras( szIniHilo, szFinHilo, szTmpHilo );

        if (ifnUpdateEstadisticas( szPROCESO, iDiffSeg , lCliesxHilo[i], i+1) !=0 ) 
        {
            ifnTrazasLog( modulo, "Ocurrio un error en la funcion ifnUpdateEstadisticas.", LOG01);
        }
    }

    for(i = 0; i < iNumeroHilos; i++)
    {
        lstClies = pInicio[i];
        ifnTrazasLog( modulo, "\n\t**** Envio Segmento [%d] de la Lista para Grabar ****", LOG03,i);  
        ifnGrabaDatosLista(lstClies);
    }

    sema_destroy(&semaflock);
    mutex_destroy(&bufferlock);

    return 0;
}

/* ============================================================================= */
/* Funcion que INSERTA o ACTUALIZA Morosos y Acciones                                        */
/* ============================================================================= */
int ifnGrabaDatosLista (stLista lstClientes)
{
char modulo[] = "ifnGrabaDatosLista";
int i=0, iRet=0 , iRetE=0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente;
    long lhCodCuenta;
    double dhSaldoVencido;
    double dhSaldoNoVencido;
    int ihCntAboCelu;
    int ihCntAboBeep;
    char szhNumIdent[21];
    char szhCodTipIdent[3];
    char szhPtoGestion[6];
    char szhCodComuna[6];
    char szhFecVencimie[11];
    char szhCodGestion[6];
    char szhCodCategoria[6];
    int    iFlagGrabar;
    /* Acciones */
    char   szhCodAccion     [6];
    char   szhFecAccion[9];
    char   szhIndDuplicable[2];
    long   lhNumSeq  ;
    char   szhCodParam   [16];
    int    ihNumProceso;
    long   lhNumEjecutadas;
    char   szhNoasignado [12];
    char   szhLetra_n    [8];
    int    iflg_reclamo;
/* EXEC SQL END DECLARE SECTION; */ 

stLista lstCli;
struct stCliente lstGral;
lstAccCM  lstAccion = NULL;

    ifnTrazasLog( modulo, "* En Funcion %s\n", LOG03, modulo);
    strcpy(szhErr,ERR);
    strcpy(szhPnd,PND);
    strcpy(szhEje,EJE);
    strcpy(szhNoasignado,NO_ASIGNADO);
    strcpy(szhLetra_n,LETRA_N);

    lstCli= lstClientes->sgte;
    while (lstCli != NULL )
    {
        iRet=0;
        iFlagGrabar=lstCli->Campo.iFlagGraba;
        lhCodCliente = lstCli->Campo.lCod_Cliente;
        lhCodCuenta = lstCli->Campo.lCod_Cuenta;
        dhSaldoVencido = lstCli->Campo.dSaldo_Vencido;
        dhSaldoNoVencido = lstCli->Campo.dSaldo_NoVencido;
        ihCntAboCelu = lstCli->Campo.iCnt_Abocelu;
        ihCntAboBeep = lstCli->Campo.iCnt_Abobeep;
        iflg_reclamo = lstCli->Campo.iflg_reclamo;
        strcpy(szhNumIdent,lstCli->Campo.szNum_Ident);
        strcpy(szhCodTipIdent,lstCli->Campo.szCod_Tipident);
        strcpy(szhPtoGestion,lstCli->Campo.szCod_Ptogest);
        strcpy(szhCodComuna,lstCli->Campo.szCod_Comuna);
        strcpy(szhFecVencimie,lstCli->Campo.szFec_Vencimiento);
        strcpy(szhCodGestion,lstCli->Campo.szCod_Gestion);
        strcpy(szhCodCategoria,lstCli->Campo.szCod_Categoria);

        ifnTrazasLog( modulo, "<<<<< ======================================================================================= >>>>>", LOG03);
        ifnTrazasLog( modulo, "iFlagGrabar      [%d]", LOG05, iFlagGrabar);
        ifnTrazasLog( modulo, "lhCodCliente     [%ld]", LOG04, lhCodCliente);
        ifnTrazasLog( modulo, "lhCodCuenta      [%ld]", LOG05, lhCodCuenta);
        ifnTrazasLog( modulo, "dhSaldoVencido   [%f]", LOG05, dhSaldoVencido);
        ifnTrazasLog( modulo, "dhSaldoNoVencido [%f]", LOG05, dhSaldoNoVencido);
        ifnTrazasLog( modulo, "ihCntAboCelu     [%d]", LOG05, ihCntAboCelu);
        ifnTrazasLog( modulo, "ihCntAboBeep     [%d]", LOG05, ihCntAboBeep);
        ifnTrazasLog( modulo, "szhNumIdent      [%s]", LOG05, szhNumIdent);
        ifnTrazasLog( modulo, "szhCodTipIdent   [%s]", LOG05, szhCodTipIdent);
        ifnTrazasLog( modulo, "szhPtoGestion    [%s]", LOG05, szhPtoGestion);
        ifnTrazasLog( modulo, "szhCodComuna     [%s]", LOG05, szhCodComuna);
        ifnTrazasLog( modulo, "szhFecVencimie   [%s]", LOG05, szhFecVencimie);
        ifnTrazasLog( modulo, "szhCodGestion    [%s]", LOG05, szhCodGestion);
        ifnTrazasLog( modulo, "szhCodCategoria  [%s]", LOG04, szhCodCategoria);
        ifnTrazasLog( modulo, "iflg_reclamo     [%ld]\n", LOG04, iflg_reclamo);

        ifnTrazasLog( modulo, "lhSecMoroso      [%d]\n", LOG04, ihValor_Cero); /* XO-200508090319  09-08-2005 Soporte RyC PRM. Homologacin de incidencia TM-200505201419 */

        if (iFlagGrabar == 1 ) 
        { /*  Inserta Nuevo Moroso */
            ifnTrazasLog(modulo, "\t*** Inserta Nuevo Moroso *** [%ld]\n",LOG03,lhCodCliente);  

            /* EXEC SQL 
            INSERT  INTO CO_MOROSOS
                     (COD_CLIENTE         , COD_CUENTA       , NUM_IDENT    ,
                      COD_TIPIDENT        , COD_PTOGEST      , FEC_PTOGEST  , 
                      FEC_INGRESO        , DIA_PRORROGA     , DEU_INICIAL  , 
                      COD_AGENTE          , ULT_PROCESO      , SEC_MOROSO   ,
                      TIP_MOROSO          , FEC_PRORROGA     , COD_CATEGORIA,
                      COD_COMUNA          , FEC_DEUDVENC     , DEU_VENCIDA  ,
                      DEU_NOVENC          , COD_GESTION      , FEC_GESTION  ,
                      CNT_ABOCELU         , CNT_ABOBEEP      , NOM_USUARIO  ) 
            VALUES (:lhCodCliente    , :lhCodCuenta     , :szhNumIdent ,
                      :szhCodTipIdent , :szhPtoGestion    , 
                      SYSDATE            , SYSDATE            , :ihValor_Cero,           
                      :dhSaldoVencido , :szhNoasignado  , :lhSecMoroso    , 
                      :ihValor_Cero    , :szhLetra_n        , NULL            ,
                      RTRIM( :szhCodCategoria ),
                      :szhCodComuna    , TO_DATE(:szhFecVencimie,'YYYYMMDD'),
                      :dhSaldoVencido    , :dhSaldoNoVencido,
                      :szhCodGestion    , SYSDATE            ,
                      :ihCntAboCelu    , :ihCntAboBeep    , USER            ); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 19;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into CO_MOROSOS (COD_CLIENTE,COD_CUENTA,NU\
M_IDENT,COD_TIPIDENT,COD_PTOGEST,FEC_PTOGEST,FEC_INGRESO,DIA_PRORROGA,DEU_INIC\
IAL,COD_AGENTE,ULT_PROCESO,SEC_MOROSO,TIP_MOROSO,FEC_PRORROGA,COD_CATEGORIA,CO\
D_COMUNA,FEC_DEUDVENC,DEU_VENCIDA,DEU_NOVENC,COD_GESTION,FEC_GESTION,CNT_ABOCE\
LU,CNT_ABOBEEP,NOM_USUARIO) values (:b0,:b1,:b2,:b3,:b4,SYSDATE,SYSDATE,:b5,:b\
6,:b7,:b8,:b5,:b10,null ,RTRIM(:b11),:b12,TO_DATE(:b13,'YYYYMMDD'),:b6,:b15,:b\
16,SYSDATE,:b17,:b18,USER)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )427;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuenta;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhNumIdent;
            sqlstm.sqhstl[2] = (unsigned long )21;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipIdent;
            sqlstm.sqhstl[3] = (unsigned long )3;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhPtoGestion;
            sqlstm.sqhstl[4] = (unsigned long )6;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&dhSaldoVencido;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhNoasignado;
            sqlstm.sqhstl[7] = (unsigned long )12;
            sqlstm.sqhsts[7] = (         int  )0;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)&lhSecMoroso;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[8] = (         int  )0;
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_Cero;
            sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[9] = (         int  )0;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_n;
            sqlstm.sqhstl[10] = (unsigned long )8;
            sqlstm.sqhsts[10] = (         int  )0;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szhCodCategoria;
            sqlstm.sqhstl[11] = (unsigned long )6;
            sqlstm.sqhsts[11] = (         int  )0;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)szhCodComuna;
            sqlstm.sqhstl[12] = (unsigned long )6;
            sqlstm.sqhsts[12] = (         int  )0;
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqhstv[13] = (unsigned char  *)szhFecVencimie;
            sqlstm.sqhstl[13] = (unsigned long )11;
            sqlstm.sqhsts[13] = (         int  )0;
            sqlstm.sqindv[13] = (         short *)0;
            sqlstm.sqinds[13] = (         int  )0;
            sqlstm.sqharm[13] = (unsigned long )0;
            sqlstm.sqadto[13] = (unsigned short )0;
            sqlstm.sqtdso[13] = (unsigned short )0;
            sqlstm.sqhstv[14] = (unsigned char  *)&dhSaldoVencido;
            sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[14] = (         int  )0;
            sqlstm.sqindv[14] = (         short *)0;
            sqlstm.sqinds[14] = (         int  )0;
            sqlstm.sqharm[14] = (unsigned long )0;
            sqlstm.sqadto[14] = (unsigned short )0;
            sqlstm.sqtdso[14] = (unsigned short )0;
            sqlstm.sqhstv[15] = (unsigned char  *)&dhSaldoNoVencido;
            sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[15] = (         int  )0;
            sqlstm.sqindv[15] = (         short *)0;
            sqlstm.sqinds[15] = (         int  )0;
            sqlstm.sqharm[15] = (unsigned long )0;
            sqlstm.sqadto[15] = (unsigned short )0;
            sqlstm.sqtdso[15] = (unsigned short )0;
            sqlstm.sqhstv[16] = (unsigned char  *)szhCodGestion;
            sqlstm.sqhstl[16] = (unsigned long )6;
            sqlstm.sqhsts[16] = (         int  )0;
            sqlstm.sqindv[16] = (         short *)0;
            sqlstm.sqinds[16] = (         int  )0;
            sqlstm.sqharm[16] = (unsigned long )0;
            sqlstm.sqadto[16] = (unsigned short )0;
            sqlstm.sqtdso[16] = (unsigned short )0;
            sqlstm.sqhstv[17] = (unsigned char  *)&ihCntAboCelu;
            sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[17] = (         int  )0;
            sqlstm.sqindv[17] = (         short *)0;
            sqlstm.sqinds[17] = (         int  )0;
            sqlstm.sqharm[17] = (unsigned long )0;
            sqlstm.sqadto[17] = (unsigned short )0;
            sqlstm.sqtdso[17] = (unsigned short )0;
            sqlstm.sqhstv[18] = (unsigned char  *)&ihCntAboBeep;
            sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[18] = (         int  )0;
            sqlstm.sqindv[18] = (         short *)0;
            sqlstm.sqinds[18] = (         int  )0;
            sqlstm.sqharm[18] = (unsigned long )0;
            sqlstm.sqadto[18] = (unsigned short )0;
            sqlstm.sqtdso[18] = (unsigned short )0;
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



            if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)  
            {
                ifnTrazasLog(modulo, "Insert CO_MOROSOS - %s",LOG00,SQLERRM);  
                iRet= -1;    
            }

            if (iRet==0) 
            {
                strcpy( szhCodGestion,( ( !strcmp( szhCodGestion, "MR" ) ) ? "CO" : szhCodGestion ) );    /* en la Morosos no va CO, va MR */
                ifnTrazasLog(modulo, "\t Update GA_ABOCEL szhCodGestion [%s]\n",LOG03,szhCodGestion);  
                /* EXEC SQL
                UPDATE    GA_ABOCEL
                SET        COD_ESTADO  = :szhCodGestion
                WHERE    COD_CLIENTE = :lhCodCliente
                AND        COD_USO != :ihValor_Tres; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 19;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update GA_ABOCEL  set COD_ESTADO=:b0 where (C\
OD_CLIENTE=:b1 and COD_USO<>:b2)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )518;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
                sqlstm.sqhstl[0] = (unsigned long )6;
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
                sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Tres;
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



                if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
                {
                    ifnTrazasLog(modulo, "Update de GA_ABOCEL del Cliente:'%ld' Cod_estado:'%s' > %s\n" ,LOG00,lhCodCliente,szhCodGestion,SQLERRM);
                    iRet = -1;
                }
            
                if (iRet==0)
                {
                    /* EXEC SQL
                    UPDATE    GA_ABOBEEP
                    SET        COD_ESTADO  = :szhCodGestion
                    WHERE    COD_CLIENTE = :lhCodCliente; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 19;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "update GA_ABOBEEP  set COD_ESTADO=:b0 whe\
re COD_CLIENTE=:b1";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )545;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestion;
                    sqlstm.sqhstl[0] = (unsigned long )6;
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


                    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
                    {
                        ifnTrazasLog(modulo, "Update de GA_ABOBEEP del Cliente:'%ld' Cod_estado:'%s' > %s\n",LOG00,lhCodCliente,szhCodGestion,SQLERRM);
                        iRet = -1;
                    }
                }
            }
    
        } 
        else if (iFlagGrabar == 0 ) { /* Actualiza datos del Cliente Moroso */
            ifnTrazasLog(modulo, "\t*** Actualiza Saldo y Fecha Nuevo Moroso *** [%ld]\n",LOG03,lhCodCliente);  
            /* EXEC SQL
            UPDATE CO_MOROSOS SET 
                   FEC_DEUDVENC = TO_DATE( :szhFecVencimie, 'YYYYMMDD' ),
                   DEU_VENCIDA  = :dhSaldoVencido  ,
                   DEU_NOVENC   = :dhSaldoNoVencido,
                   TIP_MOROSO   = :szhLetra_n,
                   SEC_MOROSO   = :ihValor_Cero ,
                   COD_AGENTE   = :szhNoasignado
            WHERE COD_CLIENTE  = :lhCodCliente; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 19;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update CO_MOROSOS  set FEC_DEUDVENC=TO_DATE(:b0,'\
YYYYMMDD'),DEU_VENCIDA=:b1,DEU_NOVENC=:b2,TIP_MOROSO=:b3,SEC_MOROSO=:b4,COD_AG\
ENTE=:b5 where COD_CLIENTE=:b6";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )568;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhFecVencimie;
            sqlstm.sqhstl[0] = (unsigned long )11;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoVencido;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&dhSaldoNoVencido;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_n;
            sqlstm.sqhstl[3] = (unsigned long )8;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhNoasignado;
            sqlstm.sqhstl[5] = (unsigned long )12;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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


            if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
                ifnTrazasLog( modulo, "Error a actualizar cliente en CO_MOROSOS => [%ld].\n", LOG00, SQLERRM );
                iRet = -1;
            }
        }    

        if(iflg_reclamo==1)
        {
            iRetE=ifnUpdateExcluidosAcciones(lhCodCliente);
        }

        if ((iFlagGrabar != -1 ) && (iflg_reclamo==0))
        { /*  Graba Acciones del Cliente */
            lstAccion=lstCli->Accion_sgte;
            while (lstAccion != NULL )  
            {
                ifnTrazasLog( modulo, "\t** Graba Acciones del Cliente  => [%ld]\n", LOG03, lhCodCliente);
                strcpy(szhCodAccion,lstAccion->szCod_Accion);
                strcpy(szhFecAccion,lstAccion->szFec_Accion);
                strcpy(szhIndDuplicable,lstAccion->szIndDuplicable);
                strcpy(szhCodParam,lstAccion->szCodParam);
                ihNumProceso    = lstAccion->iNumProceso;
                ifnTrazasLog( modulo, "\t****************************************", LOG05);
                ifnTrazasLog( modulo, "\t** szhCodAccion     => [%s]", LOG04, szhCodAccion);
                ifnTrazasLog( modulo, "\t** szhFecAccion     => [%s]", LOG04, szhFecAccion);
                ifnTrazasLog( modulo, "\t** szhIndDuplicable => [%s]", LOG05, szhIndDuplicable);
                ifnTrazasLog( modulo, "\t** szhCodParam      => [%s]", LOG05, szhCodParam);
                ifnTrazasLog( modulo, "\t** ihNumProceso     => [%d]", LOG05, ihNumProceso);
                ifnTrazasLog( modulo, "\t** iFlagRutinas     => [%d]", LOG05, lstAccion->iFlagRutinas);
    
                /* EXEC SQL
                SELECT NUM_EJECUTADAS
                INTO     :lhNumEjecutadas
                FROM     CO_RUTINAS_DIA
                WHERE     COD_RUTINA    = :szhCodAccion
                AND     FEC_RUTINA    = TO_DATE( :szhFecAccion, 'YYYYMMDD' ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 19;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select NUM_EJECUTADAS into :b0  from CO_RUTIN\
AS_DIA where (COD_RUTINA=:b1 and FEC_RUTINA=TO_DATE(:b2,'YYYYMMDD'))";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )611;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNumEjecutadas;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
                sqlstm.sqhstl[1] = (unsigned long )6;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhFecAccion;
                sqlstm.sqhstl[2] = (unsigned long )9;
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

        
                if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
                    ifnTrazasLog( modulo, "Error SELECT NUM_EJECUTADAS  => [%s].\n", LOG00, SQLERRM );
                    iRet = -1;
                } else  if( SQLCODE == SQLNOTFOUND ) {
    
                        ifnTrazasLog( modulo, "\t\tInsertando en CO_RUTINAS_DIA\n", LOG05);
                        /* EXEC SQL
                        INSERT INTO CO_RUTINAS_DIA 
                                 (COD_RUTINA   , FEC_RUTINA, NUM_EJECUTADAS )
                        VALUES (:szhCodAccion, TO_DATE( :szhFecAccion, 'YYYYMMDD' ), :ihValor_Uno ); */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 19;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.stmt = "insert into CO_RUTINAS_DIA (COD_RUTIN\
A,FEC_RUTINA,NUM_EJECUTADAS) values (:b0,TO_DATE(:b1,'YYYYMMDD'),:b2)";
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )638;
                        sqlstm.cud = sqlcud0;
                        sqlstm.sqlest = (unsigned char  *)&sqlca;
                        sqlstm.sqlety = (unsigned short)256;
                        sqlstm.occurs = (unsigned int  )0;
                        sqlstm.sqhstv[0] = (unsigned char  *)szhCodAccion;
                        sqlstm.sqhstl[0] = (unsigned long )6;
                        sqlstm.sqhsts[0] = (         int  )0;
                        sqlstm.sqindv[0] = (         short *)0;
                        sqlstm.sqinds[0] = (         int  )0;
                        sqlstm.sqharm[0] = (unsigned long )0;
                        sqlstm.sqadto[0] = (unsigned short )0;
                        sqlstm.sqtdso[0] = (unsigned short )0;
                        sqlstm.sqhstv[1] = (unsigned char  *)szhFecAccion;
                        sqlstm.sqhstl[1] = (unsigned long )9;
                        sqlstm.sqhsts[1] = (         int  )0;
                        sqlstm.sqindv[1] = (         short *)0;
                        sqlstm.sqinds[1] = (         int  )0;
                        sqlstm.sqharm[1] = (unsigned long )0;
                        sqlstm.sqadto[1] = (unsigned short )0;
                        sqlstm.sqtdso[1] = (unsigned short )0;
                        sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Uno;
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


                        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
                            ifnTrazasLog( modulo, "Error INSERT INTO CO_RUTINAS_DIA  => [%s].\n", LOG00, SQLERRM );
                            iRet = -1;
                        }
                } else {
    
                    ifnTrazasLog( modulo, "\t\tUpdateando en CO_RUTINAS_DIA\n", LOG05);
                    /* EXEC SQL
                    UPDATE CO_RUTINAS_DIA  SET        
                             NUM_EJECUTADAS = NUM_EJECUTADAS + :ihValor_Uno
                    WHERE     COD_RUTINA    = :szhCodAccion
                    AND     FEC_RUTINA    = TO_DATE( :szhFecAccion, 'YYYYMMDD' ); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 19;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "update CO_RUTINAS_DIA  set NUM_EJECUTADAS\
=(NUM_EJECUTADAS+:b0) where (COD_RUTINA=:b1 and FEC_RUTINA=TO_DATE(:b2,'YYYYMM\
DD'))";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )665;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Uno;
                    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
                    sqlstm.sqhstl[1] = (unsigned long )6;
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhFecAccion;
                    sqlstm.sqhstl[2] = (unsigned long )9;
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

        
                    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
                        ifnTrazasLog( modulo, "Error UPDATE CO_RUTINAS_DIA  => [%s].\n", LOG00, SQLERRM );
                        iRet = -1;
                    }
                }
    
                ifnTrazasLog( modulo, "\tDeleteando FROM CO_ACCERR", LOG04);
                /* EXEC SQL
                DELETE FROM CO_ACCERR
               WHERE NUM_SECUENCIA IN (SELECT NUM_SECUENCIA
                                                    FROM CO_ACCIONES
                                                  WHERE COD_CLIENTE = :lhCodCliente
                                              AND COD_RUTINA IN  ( SELECT R.REV_RUTINA
                                                                              FROM CO_RUTINAS R
                                                                             WHERE COD_RUTINA = :szhCodAccion )
                                                                          AND COD_ESTADO IN ( :szhErr, :szhPnd )
                                                                          AND NOM_USUARIO = :szhUser_Cobros); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 19;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CO_ACCERR  where NUM_SECUENCIA i\
n (select NUM_SECUENCIA  from CO_ACCIONES where (((COD_CLIENTE=:b0 and COD_RUT\
INA in (select R.REV_RUTINA  from CO_RUTINAS R where COD_RUTINA=:b1)) and COD_\
ESTADO in (:b2,:b3)) and NOM_USUARIO=:b4))";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )692;
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
                sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
                sqlstm.sqhstl[1] = (unsigned long )6;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhErr;
                sqlstm.sqhstl[2] = (unsigned long )4;
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhPnd;
                sqlstm.sqhstl[3] = (unsigned long )4;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhUser_Cobros;
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


               
               if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
                    ifnTrazasLog( modulo, "Error DELETE FROM CO_ACCERR => [%s].\n", LOG00, SQLERRM );
                    iRet = -1;
                }
    
                ifnTrazasLog( modulo, "\tDeleteando FROM CO_ACCIONES", LOG04);
                
                /* EXEC SQL
                DELETE FROM CO_ACCIONES
                WHERE  NUM_SECUENCIA IN (SELECT NUM_SECUENCIA
                                                  FROM CO_ACCIONES
                                                WHERE COD_CLIENTE = :lhCodCliente
                                                  AND COD_RUTINA IN (  SELECT R.REV_RUTINA
                                                                             FROM CO_RUTINAS R
                                                                            WHERE COD_RUTINA = :szhCodAccion )
                                                                               AND COD_ESTADO IN ( :szhErr, :szhPnd )
                                                                               AND NOM_USUARIO = :szhUser_Cobros ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 19;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CO_ACCIONES  where NUM_SECUENCIA\
 in (select NUM_SECUENCIA  from CO_ACCIONES where (((COD_CLIENTE=:b0 and COD_R\
UTINA in (select R.REV_RUTINA  from CO_RUTINAS R where COD_RUTINA=:b1)) and CO\
D_ESTADO in (:b2,:b3)) and NOM_USUARIO=:b4))";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )727;
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
                sqlstm.sqhstv[1] = (unsigned char  *)szhCodAccion;
                sqlstm.sqhstl[1] = (unsigned long )6;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhErr;
                sqlstm.sqhstl[2] = (unsigned long )4;
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhPnd;
                sqlstm.sqhstl[3] = (unsigned long )4;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhUser_Cobros;
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


               
               if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    {
                    ifnTrazasLog( modulo, "Error DELETE FROM CO_ACCIONES => [%s].\n", LOG00, SQLERRM );
                    iRet = -1;
                }
    
                /* se obtiene secuencia para id de accion */
               
               /* EXEC SQL SELECT CO_SEQ_ACCION.NEXTVAL INTO :lhNumSeq FROM DUAL; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 19;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "select CO_SEQ_ACCION.nextval  into :b0  from D\
UAL ";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )762;
               sqlstm.selerr = (unsigned short)1;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
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

 
               
               if( SQLCODE != SQLOK )    {
                    ifnTrazasLog( modulo, "Error al Obtener Secuencia => [%s].\n", LOG00, SQLERRM );
                    iRet = -1;
               }
    
                if( !strcmp( szhIndDuplicable, "S" ) )  
                {
                    ifnTrazasLog( modulo, "\t Insert into CO_ACCIONES Duplicable=S", LOG03);

                    /* EXEC SQL 
                    INSERT INTO CO_ACCIONES
                    (
                        COD_CLIENTE        , NUM_SECUENCIA ,
                        COD_RUTINA            , COD_ESTADO     ,
                        FEC_ESTADO            , FEC_EJECPROG  ,
                        NOM_USUARIO        , CNT_ABOCELU   ,
                        CNT_ABOBEEP        , NUM_IDENT     ,
                        COD_TIPIDENT        , DEU_VENCIDA   ,
                        DEU_NOVENC            
                    )    
                    SELECT :lhCodCliente    ,
                           :lhNumSeq        ,
                           :szhCodAccion    ,
                           :szhPnd          ,
                           SYSDATE          ,
                           TO_DATE(:szhFecAccion,'YYYYMMDD') ,
                           USER                  ,
                           :ihValor_Cero      ,
                           :ihValor_Cero      ,
                           NUM_IDENT        , 
                           COD_TIPIDENT     ,
                           DEU_VENCIDA      ,
                           DEU_NOVENC       
                      FROM CO_MOROSOS
                     WHERE COD_CLIENTE = :lhCodCliente; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 19;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into CO_ACCIONES (COD_CLIENTE,NUM_\
SECUENCIA,COD_RUTINA,COD_ESTADO,FEC_ESTADO,FEC_EJECPROG,NOM_USUARIO,CNT_ABOCEL\
U,CNT_ABOBEEP,NUM_IDENT,COD_TIPIDENT,DEU_VENCIDA,DEU_NOVENC)select :b0 ,:b1 ,:\
b2 ,:b3 ,SYSDATE ,TO_DATE(:b4,'YYYYMMDD') ,USER ,:b5 ,:b5 ,NUM_IDENT ,COD_TIPI\
DENT ,DEU_VENCIDA ,DEU_NOVENC  from CO_MOROSOS where COD_CLIENTE=:b0";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )781;
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
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeq;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAccion;
                    sqlstm.sqhstl[2] = (unsigned long )6;
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhPnd;
                    sqlstm.sqhstl[3] = (unsigned long )4;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)szhFecAccion;
                    sqlstm.sqhstl[4] = (unsigned long )9;
                    sqlstm.sqhsts[4] = (         int  )0;
                    sqlstm.sqindv[4] = (         short *)0;
                    sqlstm.sqinds[4] = (         int  )0;
                    sqlstm.sqharm[4] = (unsigned long )0;
                    sqlstm.sqadto[4] = (unsigned short )0;
                    sqlstm.sqtdso[4] = (unsigned short )0;
                    sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
                    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[5] = (         int  )0;
                    sqlstm.sqindv[5] = (         short *)0;
                    sqlstm.sqinds[5] = (         int  )0;
                    sqlstm.sqharm[5] = (unsigned long )0;
                    sqlstm.sqadto[5] = (unsigned short )0;
                    sqlstm.sqtdso[5] = (unsigned short )0;
                    sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_Cero;
                    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[6] = (         int  )0;
                    sqlstm.sqindv[6] = (         short *)0;
                    sqlstm.sqinds[6] = (         int  )0;
                    sqlstm.sqharm[6] = (unsigned long )0;
                    sqlstm.sqadto[6] = (unsigned short )0;
                    sqlstm.sqtdso[6] = (unsigned short )0;
                    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCliente;
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



                    if( SQLCODE != SQLOK )    
                    {
                        ifnTrazasLog( modulo, "Error al insertar nueva accion => [%s].\n", LOG00, SQLERRM );
                        iRet = -1;
                    }
                }  
                else  
                { 
                    ifnTrazasLog( modulo, "\t Insert into CO_ACCIONES Duplicable != S", LOG03);

                    /* EXEC SQL 
                    INSERT INTO CO_ACCIONES
                    (
                        COD_CLIENTE       , NUM_SECUENCIA ,
                        COD_RUTINA        , COD_ESTADO    ,
                        FEC_ESTADO        , FEC_EJECPROG  ,
                        NOM_USUARIO       , CNT_ABOCELU   ,
                        CNT_ABOBEEP       , NUM_IDENT     ,
                        COD_TIPIDENT      , DEU_VENCIDA   ,
                        DEU_NOVENC           
                    )
                    SELECT :lhCodCliente        ,                        
                           :lhNumSeq        ,                 
                           :szhCodAccion    ,                 
                           :szhPnd          ,                 
                           SYSDATE          ,                 
                           TO_DATE(:szhFecAccion,'YYYYMMDD'), 
                           USER             ,
                           :ihValor_Cero    ,
                           :ihValor_Cero    ,
                           M.NUM_IDENT      ,
                           M.COD_TIPIDENT   ,
                           M.DEU_VENCIDA    ,
                           M.DEU_NOVENC
                      FROM CO_MOROSOS M
                     WHERE M.COD_CLIENTE = :lhCodCliente
                       AND M.COD_CLIENTE NOT IN ( SELECT A.COD_CLIENTE
                                                    FROM CO_ACCIONES A
                                                   WHERE A.COD_CLIENTE = M.COD_CLIENTE
                                                     AND A.NUM_SECUENCIA > 0
                                                     AND A.COD_RUTINA = :szhCodAccion
                                                     AND A.COD_ESTADO = :szhEje    ); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 19;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into CO_ACCIONES (COD_CLIENTE,NUM_\
SECUENCIA,COD_RUTINA,COD_ESTADO,FEC_ESTADO,FEC_EJECPROG,NOM_USUARIO,CNT_ABOCEL\
U,CNT_ABOBEEP,NUM_IDENT,COD_TIPIDENT,DEU_VENCIDA,DEU_NOVENC)select :b0 ,:b1 ,:\
b2 ,:b3 ,SYSDATE ,TO_DATE(:b4,'YYYYMMDD') ,USER ,:b5 ,:b5 ,M.NUM_IDENT ,M.COD_\
TIPIDENT ,M.DEU_VENCIDA ,M.DEU_NOVENC  from CO_MOROSOS M where (M.COD_CLIENTE=\
:b0 and M.COD_CLIENTE not  in (select A.COD_CLIENTE  from CO_ACCIONES A where \
(((A.COD_CLIENTE=M.COD_CLIENTE and A.NUM_SECUENCIA>0) and A.COD_RUTINA=:b2) an\
d A.COD_ESTADO=:b9)))";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )828;
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
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSeq;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAccion;
                    sqlstm.sqhstl[2] = (unsigned long )6;
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhPnd;
                    sqlstm.sqhstl[3] = (unsigned long )4;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)szhFecAccion;
                    sqlstm.sqhstl[4] = (unsigned long )9;
                    sqlstm.sqhsts[4] = (         int  )0;
                    sqlstm.sqindv[4] = (         short *)0;
                    sqlstm.sqinds[4] = (         int  )0;
                    sqlstm.sqharm[4] = (unsigned long )0;
                    sqlstm.sqadto[4] = (unsigned short )0;
                    sqlstm.sqtdso[4] = (unsigned short )0;
                    sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
                    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[5] = (         int  )0;
                    sqlstm.sqindv[5] = (         short *)0;
                    sqlstm.sqinds[5] = (         int  )0;
                    sqlstm.sqharm[5] = (unsigned long )0;
                    sqlstm.sqadto[5] = (unsigned short )0;
                    sqlstm.sqtdso[5] = (unsigned short )0;
                    sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_Cero;
                    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[6] = (         int  )0;
                    sqlstm.sqindv[6] = (         short *)0;
                    sqlstm.sqinds[6] = (         int  )0;
                    sqlstm.sqharm[6] = (unsigned long )0;
                    sqlstm.sqadto[6] = (unsigned short )0;
                    sqlstm.sqtdso[6] = (unsigned short )0;
                    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCliente;
                    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[7] = (         int  )0;
                    sqlstm.sqindv[7] = (         short *)0;
                    sqlstm.sqinds[7] = (         int  )0;
                    sqlstm.sqharm[7] = (unsigned long )0;
                    sqlstm.sqadto[7] = (unsigned short )0;
                    sqlstm.sqtdso[7] = (unsigned short )0;
                    sqlstm.sqhstv[8] = (unsigned char  *)szhCodAccion;
                    sqlstm.sqhstl[8] = (unsigned long )6;
                    sqlstm.sqhsts[8] = (         int  )0;
                    sqlstm.sqindv[8] = (         short *)0;
                    sqlstm.sqinds[8] = (         int  )0;
                    sqlstm.sqharm[8] = (unsigned long )0;
                    sqlstm.sqadto[8] = (unsigned short )0;
                    sqlstm.sqtdso[8] = (unsigned short )0;
                    sqlstm.sqhstv[9] = (unsigned char  *)szhEje;
                    sqlstm.sqhstl[9] = (unsigned long )4;
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



                    if( SQLCODE && SQLCODE != SQLNOTFOUND )  
                    {
                        ifnTrazasLog( modulo, "Error al insertar nueva accion Ind=S => [%s].\n", LOG00, SQLERRM );
                        iRet = -1;
                    }
                }                
                
                if( strcmp( szhCodParam, "N" ) != 0 )  
                {
                    /* EXEC SQL
                    INSERT INTO CO_PARAM_ACCIONES 
                    (
                        NUM_SECUENCIA  , COD_PARAM 
                    )
                    VALUES 
                    (
                        :lhNumSeq, :szhCodParam 
                    ); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 19;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into CO_PARAM_ACCIONES (NUM_SECUEN\
CIA,COD_PARAM) values (:b0,:b1)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )883;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSeq;
                    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhCodParam;
                    sqlstm.sqhstl[1] = (unsigned long )16;
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



                    if( SQLCODE != SQLOK )    
                    {
                        ifnTrazasLog( modulo, "Error al insertar en tabla CO_PARAM_ACCIONES, Secuencia ==> [%ld].", LOG00, lhNumSeq );  
                        iRet=-1;        
                    }                    
                }

                ifnTrazasLog( modulo, "\t Actualizando CO_MOROSOS (Pto de Gestion [%s])", LOG03,szhPtoGestion);
                ifnTrazasLog( modulo, "\t Actualizando CO_MOROSOS (Sec_Moroso     [%d])\n", LOG03, ihNumProceso); /* XO-200508090319  09-08-2005 Soporte RyC PRM. Homologacin de incidencia TM-200505201419 */

                /* EXEC SQL 
                UPDATE CO_MOROSOS 
                   SET COD_PTOGEST = :szhPtoGestion, 
                       FEC_PTOGEST = SYSDATE,
                       SEC_MOROSO  = :ihNumProceso
                 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 19;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update CO_MOROSOS  set COD_PTOGEST=:b0,FEC_PT\
OGEST=SYSDATE,SEC_MOROSO=:b1 where COD_CLIENTE=:b2";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )906;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhPtoGestion;
                sqlstm.sqhstl[0] = (unsigned long )6;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&ihNumProceso;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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


                
                if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )    
                {
                    ifnTrazasLog(modulo, "al actualizar nuevo pto gestion (%ld) - %s" ,LOG00,lhCodCliente ,SQLERRM);
                    iRet=1; /* Pasar al siguiente Cliente de este mismo punto de Gestion, deshacer cambios */
                }
                else if ( SQLCODE == SQLNOTFOUND)
                {
                    /* No lo encontro. Significa que el excluidor lo excluyo. Debe hacer Rollback para no generar la accin. */
                    ifnTrazasLog( modulo, "Cliente (%ld) fue Excluido mientras era evaluado.", LOG02, lhCodCliente );
                    iRet=1; /* Pasar al siguiente Cliente, pero deshacer lo hecho para este */
                }

                lstAccion=lstAccion->sgte;
            } /* while (lstAccion != NULL )  */
        }
        if ((iRet==0) && (iFlagGrabar!=-1) && (iRetE==0)) {
            ifnTrazasLog( modulo, "COMMIT al Cliente => [%ld]. iFlagGraba  [%ld]\n\n", LOG04, lhCodCliente,iFlagGrabar );
            /* EXEC SQL COMMIT; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 19;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )933;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            
        } else {
            ifnTrazasLog( modulo, "\tROLLBACK al Cliente => [%ld]. iFlagGraba [%d]\n\n", LOG04, lhCodCliente , iFlagGrabar);
           /* EXEC SQL ROLLBACK; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 19;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )948;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        }
        
        lstCli=lstCli->sgte;

    } /* end while */

    ifnTrazasLog( modulo, "**** Fin del Recorrido del Segmento de la Lista ****\n\n", LOG03);
    return 0;
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
