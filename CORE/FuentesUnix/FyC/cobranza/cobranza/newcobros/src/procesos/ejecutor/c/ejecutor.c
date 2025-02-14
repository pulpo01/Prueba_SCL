
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
           char  filnam[17];
};
static const struct sqlcxp sqlfpn =
{
    16,
    "./pc/ejecutor.pc"
};


static unsigned int sqlctx = 3448667;


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

 static const char *sq0010 = 
"select COD_RUTINA  from CO_RUTINAS where TIP_RUTINA=:b0           ";

 static const char *sq0015 = 
"select a.cod_cliente  from (select unique a.cod_cliente  from co_acciones a \
where (((( not exists (select :b0  from co_clieproceso_to where cod_cliente=a.\
cod_cliente) and a.cod_rutina in (select r.cod_rutina  from (select cod_rutina\
  from co_rutinas where (niv_prioridad is  not null  and tip_rutina in (:b1,:b\
2)) order by niv_prioridad desc  ) r where r.cod_rutina=a.cod_rutina)) and a.f\
ec_ejecprog<SYSDATE) and a.cod_estado=:b3) and ROWNUM<=(:b4* 2))) a where ROWN\
UM<=:b4           ";

 static const char *sq0029 = 
"select  /*+  index (A, PK_CO_ACCIONES)  +*/ A.NUM_SECUENCIA ,A.COD_RUTINA  f\
rom CO_RUTINAS R ,CO_ACCIONES A where (((R.COD_RUTINA=A.COD_RUTINA and COD_EST\
ADO=:b0) and FEC_EJECPROG<SYSDATE) and A.COD_CLIENTE=:b1) order by R.NIV_PRIOR\
IDAD desc ,A.FEC_EJECPROG,A.NUM_SECUENCIA            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,0,0,0,60,70,0,0,0,0,0,1,0,
20,0,0,1,67,0,4,128,0,0,2,1,0,1,0,2,5,0,0,1,97,0,0,
43,0,0,2,61,0,5,147,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
66,0,0,3,0,0,29,158,0,0,0,0,0,1,0,
81,0,0,4,62,0,6,429,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
104,0,0,5,110,0,4,436,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
127,0,0,6,62,0,6,476,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
150,0,0,7,152,0,4,489,0,0,4,3,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,3,0,0,
181,0,0,8,171,0,5,509,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
212,0,0,9,0,0,29,520,0,0,0,0,0,1,0,
227,0,0,10,66,0,9,577,0,0,1,1,0,1,0,1,97,0,0,
246,0,0,10,0,0,13,585,0,0,1,0,0,1,0,2,97,0,0,
265,0,0,10,0,0,15,599,0,0,0,0,0,1,0,
280,0,0,11,31,0,2,689,0,0,0,0,0,1,0,
295,0,0,12,0,0,29,696,0,0,0,0,0,1,0,
310,0,0,13,106,0,4,703,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
337,0,0,0,0,0,58,730,0,0,1,1,0,1,0,3,109,0,0,
356,0,0,14,0,0,27,732,0,0,4,4,0,1,0,1,97,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
387,0,0,15,484,0,9,853,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,
426,0,0,15,0,0,13,864,0,0,1,0,0,1,0,2,3,0,0,
445,0,0,15,0,0,15,912,0,0,0,0,0,1,0,
460,0,0,16,70,0,6,966,0,0,1,1,0,1,0,2,5,0,0,
479,0,0,0,0,0,59,1070,0,0,1,1,0,1,0,3,109,0,0,
498,0,0,17,70,0,6,1115,0,0,1,1,0,1,0,2,5,0,0,
517,0,0,18,83,0,3,1129,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
544,0,0,19,0,0,29,1144,0,0,0,0,0,1,0,
559,0,0,20,49,0,2,1169,0,0,1,1,0,1,0,1,3,0,0,
578,0,0,21,0,0,29,1179,0,0,0,0,0,1,0,
593,0,0,22,62,0,6,1288,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
616,0,0,23,130,0,4,1315,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
643,0,0,24,105,0,5,1346,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
674,0,0,25,0,0,31,1355,0,0,0,0,0,1,0,
689,0,0,26,65,0,4,1362,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
712,0,0,27,47,0,2,1379,0,0,1,1,0,1,0,1,3,0,0,
731,0,0,28,0,0,29,1389,0,0,0,0,0,1,0,
746,0,0,29,285,0,9,1417,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
769,0,0,29,0,0,13,1429,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
792,0,0,30,137,0,4,1457,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,
819,0,0,31,135,0,5,1492,0,0,5,5,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
854,0,0,32,0,0,29,1513,0,0,0,0,0,1,0,
869,0,0,33,135,0,5,1576,0,0,5,5,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
904,0,0,34,64,0,4,1605,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
927,0,0,35,47,0,2,1640,0,0,1,1,0,1,0,1,3,0,0,
946,0,0,36,0,0,31,1649,0,0,0,0,0,1,0,
961,0,0,37,135,0,5,1657,0,0,5,5,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
996,0,0,38,181,0,4,1678,0,0,7,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,2,5,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,
1039,0,0,39,99,0,5,1717,0,0,4,4,0,1,0,1,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1070,0,0,40,71,0,3,1741,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
1093,0,0,41,66,0,5,1750,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
1116,0,0,29,0,0,15,1773,0,0,0,0,0,1,0,
1131,0,0,42,71,0,2,1782,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1154,0,0,43,0,0,31,1789,0,0,0,0,0,1,0,
1169,0,0,44,0,0,29,1794,0,0,0,0,0,1,0,
1184,0,0,45,0,0,31,1797,0,0,0,0,0,1,0,
1199,0,0,46,150,0,4,1809,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
1226,0,0,47,62,0,6,1828,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
1249,0,0,48,171,0,5,1840,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1280,0,0,49,0,0,29,1853,0,0,0,0,0,1,0,
1295,0,0,50,269,0,4,1889,0,0,5,4,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,
};


/* =============================================================================
Tipo        :  COLA DE PROCESO
Nombre      :  ejecutor.pc
Descripcion :  Ejecuta las acciones correspondientes al punto de gestion
               en el que se encuentre el cliente.
Recibe      :  Usuario/Password. ( por defecto asume los de la cuenta )
               Nivel de Log ( por defecto asume 3 : Log Normal )
               Nombre de la Cola (Opcional), para nombrar archivos de log
Devuelve    :  Valor entero para indicar el status de termino.
               Interactua con la Base de Datos y el archivo de Log para registrar
               como se desarrolla su ejecucion.
Autor       :  Roy Barrera Richards
Fecha       :  09 - Agosto - 2000
================================================================================ */
#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_
#include "ejecutor.h"
#include <sched.h>
#include <sqlcpr.h>

LINEACOMANDO stLineaComando;     /* Datos con los que se invoco al proceso */
char         szUsuarioConec[20];
char         szPasswConec  [20];

char		 szgCodProceso[5] = "";
char		 szDescError[3024]= "";
int			 iTotAcciones = 0;
long		 lAuxSeqGlobal= 0;	 /* variable de ambito global ( Auxiliar Secuencia en Desenrutamiento) */
PARAMETROS	 stParametrosHilos[MAX_INSTANCIAS];

int   iHiloEjec   = 0;
int   iNumeroHilos= 0, iContinue=0;
int   iResult     = 0, iError   =0;
int   iSec_Padre  = 0;
long  lhContInmu  = 0, lhContPnd=0;
long  lTotalRows  = 0, lhContOk =0;
/* Identificador del thread hijo */

td_Acciones	  stAccionesRev;

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

	char  szhCodEstado   [2];	/* EXEC SQL VAR szhCodEstado IS STRING (2); */ 

	char  szhUser_Cobros[15];	/* EXEC SQL VAR szhUser_Cobros IS STRING(15); */ 

	char  szhProceso     [5];
	char  szhUser       [41];	/* EXEC SQL VAR szhUser    IS STRING(41); */ 

   char  szhSysdate     [9];	/* EXEC SQL VAR szhSysdate IS STRING(9); */ 

   char  szhHH24MISS   [11];
	long  lhCpu             ;
	int   ihNUM_INSTAN      ;
	int   ihCountEstadis    ;
	long  ihTotalClies = 0  ;
   int   iTot_Clies        [MAX_INSTANCIAS];
	sql_context CtxInsBas   [MAX_INSTANCIAS];
	thread_t		threadIdHilo[MAX_INSTANCIAS];
/* EXEC SQL END DECLARE SECTION; */ 


/* ============================================================================= */
/* Variable global utilizada para instancias de BD */
/* ============================================================================= */

int main(int argc,char *argv[])
{
char modulo[]="main";
int iResult = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhEJEC     [5];
	char szhWAIT     [2];
/* EXEC SQL END DECLARE SECTION; */ 

/* EXEC SQL ENABLE THREADS; */ 

{
struct sqlexd sqlstm;
sqlstm.sqlvsn = 12;
sqlstm.arrsiz = 0;
sqlstm.sqladtp = &sqladt;
sqlstm.sqltdsp = &sqltds;
sqlstm.stmt = "";
sqlstm.iters = (unsigned int  )1;
sqlstm.offset = (unsigned int  )5;
sqlstm.cud = sqlcud0;
sqlstm.sqlest = (unsigned char  *)&sqlca;
sqlstm.sqlety = (unsigned short)256;
sqlstm.occurs = (unsigned int  )0;
sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    fprintf(stdout, "\n%s EJECUTOR PID[%ld] VERSION [%s]\n", szGetTime(1),getpid(), szVERSION);
    fflush (stdout);
    strcpy(szhEJEC,"EJEC");
    strcpy(szhWAIT,"W");
    strcpy(szParamExclu,"0");
	 strcpy(szhHH24MISS,"HH24:MI:SS");

    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));
    if (ifnValidaParametros(argc,argv,&stLineaComando) != 0)
    {
        fprintf (stdout,"\n\tError >> Fallo la Validacion de Parametros \n");
        fflush  (stdout);
        ifnMailAlert("EJECUTOR","TODOS","FALLO LA VALIDACION DE PARAMETROS.");
        iResult = 1; /* Fallo validacion */
    }
    else
    {
        /*- Conexion a la Base de Datos -*/
        if (ifnConexionDB(&stLineaComando) != 0)
        {
            fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
            fflush  (stdout);
            ifnMailAlert("EJECUTOR","TODOS","FALLO EN CONEXION A LA BASE.");
            iResult = 2; /* Fallo conexion */
        }
        else
        {
            /*- Prepara Archivo de Log -*/
            if (ifnPreparaArchivoLog() != 0)
            {
                fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
                fflush  (stdout);
                ifnMailAlert("EJECUTOR","TODOS","FALLO EN ARCHIVO DE LOG.");
                iResult = 3;  /* Fallo Log */
            }
            else
            {
                /* inicializa uso de semaforos para funciones que */
                /* estan compartidas con EvalCM y EvalMO          */
                sema_init (&semaflock , 1, NULL, NULL );
                /*- Ejecuta el proceso propiamente tal -*/
                if (ifnEjecutaCola( &stLineaComando ) != 0)
                {
                    fprintf (stdout,"\n\tError >> Fallo el proceso \n");
                    fflush  (stdout);
                    ifnMailAlert("EJECUTOR","TODOS","FALLO DEL PROCESO.");
                    /* en caso de error igual destruye semaforos iniciados */
                    sema_destroy(&semaflock);
                    iResult = 4; /* Fallo Proceso */
                }
                else /* ejecutor salio con 0 ( supuestamente cola de vuelta en wait ) */
                {
                    /* destruye semaforos iniciados */
                    sema_destroy(&semaflock);
                    /********************************/
                    /* EXEC SQL
                    SELECT COD_ESTADO
                    INTO :szhCodEstado
                    FROM CO_COLASPROC
                    WHERE COD_PROCESO=:szhEJEC; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 2;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLAS\
PROC where COD_PROCESO=:b1";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )20;
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
                    sqlstm.sqhstv[1] = (unsigned char  *)szhEJEC;
                    sqlstm.sqhstl[1] = (unsigned long )5;
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


                    if (sqlca.sqlcode)
                    {
                        fprintf (stdout,"\n\tError >> Fallo el proceso ( Validacion Cola Wait ) \n");
                        fflush  (stdout);
                        ifnMailAlert("EJECUTOR","TODOS","FALLO LA VALIDACION FINAL DE LA COLA.");
                        iResult = 5; /* Fallo Proceso */
                    }
                    else
                    {
                        if ( strcmp(szhCodEstado,"W")!=0 )
                        {
                            /* LA COLA ESTA EN UN ESTADO DISTINTO DE WAIT */
                            /* SEÑALAR ESTO COMO ERROR E INTENTAR FORZARLA A WAIT */
                            ifnTrazasLog(modulo,"Regresando la Cola a Espera (%s)",LOG02,szhCodEstado);
                            /* EXEC SQL
                            UPDATE CO_COLASPROC
                            SET COD_ESTADO = :szhWAIT
                            WHERE COD_PROCESO = :szhEJEC ; */ 

{
                            struct sqlexd sqlstm;
                            sqlstm.sqlvsn = 12;
                            sqlstm.arrsiz = 2;
                            sqlstm.sqladtp = &sqladt;
                            sqlstm.sqltdsp = &sqltds;
                            sqlstm.stmt = "update CO_COLASPROC  set COD_ESTA\
DO=:b0 where COD_PROCESO=:b1";
                            sqlstm.iters = (unsigned int  )1;
                            sqlstm.offset = (unsigned int  )43;
                            sqlstm.cud = sqlcud0;
                            sqlstm.sqlest = (unsigned char  *)&sqlca;
                            sqlstm.sqlety = (unsigned short)256;
                            sqlstm.occurs = (unsigned int  )0;
                            sqlstm.sqhstv[0] = (unsigned char  *)szhWAIT;
                            sqlstm.sqhstl[0] = (unsigned long )2;
                            sqlstm.sqhsts[0] = (         int  )0;
                            sqlstm.sqindv[0] = (         short *)0;
                            sqlstm.sqinds[0] = (         int  )0;
                            sqlstm.sqharm[0] = (unsigned long )0;
                            sqlstm.sqadto[0] = (unsigned short )0;
                            sqlstm.sqtdso[0] = (unsigned short )0;
                            sqlstm.sqhstv[1] = (unsigned char  *)szhEJEC;
                            sqlstm.sqhstl[1] = (unsigned long )5;
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


                            if (sqlca.sqlcode)
                            {
                                fprintf (stdout,"\n\tError >> Fallo el proceso ( Update Cola Wait ) %s\n",sqlca.sqlerrm.sqlerrmc );
                                fflush  (stdout);
                                ifnMailAlert("EJECUTOR","TODOS","FALLO AL ACTUALIZAR LA COLA A 'WAIT'.");
                                iResult = 6; /* Fallo Proceso */
                            }
                            /* EXEC SQL COMMIT; */ 

{
                            struct sqlexd sqlstm;
                            sqlstm.sqlvsn = 12;
                            sqlstm.arrsiz = 2;
                            sqlstm.sqladtp = &sqladt;
                            sqlstm.sqltdsp = &sqltds;
                            sqlstm.iters = (unsigned int  )1;
                            sqlstm.offset = (unsigned int  )66;
                            sqlstm.cud = sqlcud0;
                            sqlstm.sqlest = (unsigned char  *)&sqlca;
                            sqlstm.sqlety = (unsigned short)256;
                            sqlstm.occurs = (unsigned int  )0;
                            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                            if (sqlca.sqlcode)
                            {
                                fprintf (stdout,"\n\tError >> Fallo el proceso ( Commit Cola Wait ) %s\n", sqlca.sqlerrm.sqlerrmc );
                                fflush  (stdout);
                                ifnMailAlert("EJECUTOR","TODOS","FALLO EL COMMIT DE LA COLA 'WAIT'.");
                                iResult = 7;
                            }
                            ifnTrazasLog(modulo,"OK. Cola forzada a espera",LOG02);
                        }
                    }
                }

                vfnCierraArchivoLog();
            }
        }
    }

    return iResult;

} /* end main */
/* ============================================================================= */

/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
char modulo[]="ifnValidaParametros";

/*-- Definicion de variables para controlar la lista de argumentos recibidos ----*/
extern char  *optarg;
extern int  optind, opterr, optopt;
int    iOpt=0;
char   opt[] = ":u:l:n:";
/*-- Variables locales -----------------------------------------------------------*/
char  *psztmp = "";
/*-- Flags de los valores recibidos ----------------------------------------------*/
int  Userflag=0;
int  Logflag=0;

/*-- Seteo de Valores Iniciles y por defecto -------------------------------------*/
    opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;
    memset(szgCodProceso,0,sizeof(szgCodProceso));
    strcpy(szgCodProceso,"EJEC"); /*valor por defecto es "EJEC" por EJECutor */
    strcpy(szhProceso,szgCodProceso);

/*-- En caso de Invocacion sin Parametros ----------------------------------------*/
    if(argc == 1)    {
        return 0; /*ok asume valores por defecto */
    }

/*-- Analisis de los argumentos recibidos ----------------------------------------*/
    while ((iOpt=getopt(argc, argv, opt))!=EOF)
    {
        switch(iOpt)
        {
            case 'u':  /*-- Usuario/Password --*/
                 if(!Userflag)
                {
                    strcpy(pstLC->szUsuarioOra, optarg);
                    Userflag=1;
                    if ((psztmp=(char *)strchr(pstLC->szUsuarioOra,'/'))==(char *)NULL)
                    {
                        fprintf (stderr,"\n\tError >> Usuario no valido. Requiere '/' \n");
                        fflush  (stderr);
                        return -1;
                    }
                    else
                    {
                        strncpy (pstLC->szOraAccount,pstLC->szUsuarioOra,psztmp-pstLC->szUsuarioOra);
                        strcpy  (pstLC->szOraPasswd, psztmp+1);
                    }
                }
                else
                {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;

            case 'l': /*-- Nivel de Log --*/
                if(!Logflag)
                {
                    stStatus.iLogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=1;
                }
                else
                {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;
            case 'n': /*-- Nombre de la Cola (codigo del proceso) --*/
                strcpy(szgCodProceso,optarg);
                break;
            case '?':
                fprintf (stderr,"\n\tError >> opcion '-%c' es desconocida\n",optopt);
                fflush  (stderr);
                return -1;

            case ':':
                fprintf (stderr,"\n\tError >> falta argumento para opcion '-%c'\n",optopt);
                fflush  (stderr);
                return -1;
        }
    }
    pstLC->iLogLevel=stStatus.iLogNivel;
       return 0;

} /* bfnValidaParamatros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB( LINEACOMANDO *pstLC)
{
char modulo[]="ifnConexionDB";

    strcpy(szUsuarioConec,pstLC->szOraAccount);
    strcpy(szPasswConec,pstLC->szOraPasswd);
    if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  )    {
        fprintf (stderr,"\nNo hay conexion a ORACLE \n");
        fflush  (stderr);
        return -1;
    }

    return 0;
}
/* ============================================================================= */

/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
char modulo[]="ifnPreparaArchivoLog";
int sts=0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhPathLogSched[256]; /* EXEC SQL VAR szhPathLogSched IS STRING (256); */ 

/* EXEC SQL END DECLARE SECTION; */ 


   sprintf(stStatus.szFileName,"%s",szgCodProceso);

	sprintf(szhPathLogSched,"%s/CO_SCHEDULER",getenv("XPC_LOG"));

   sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
   sts = ifnAbreArchivoLog(1);

   return sts;

} /* end ifnPreparaArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* if iCreaDir != 0 : crear directorio antes que el archivo                      */
/* ============================================================================= */
int ifnAbreArchivoLog(int iCrearDir)
{
char modulo[]="ifnAbreArchivoLog";
char szArchivoLog[256]=""; /* log */
char szArchivoErr[256]=""; /* errores */
char szArchivoEst[256]=""; /* estadisticas */
char szComando[256]="";
static char szAux[9];

   memset(szArchivoLog,0,sizeof(szArchivoLog)); /* log */
   memset(szArchivoErr,0,sizeof(szArchivoErr)); /* errores */
   memset(szArchivoEst,0,sizeof(szArchivoEst)); /* estadisticas */

   strcpy (szhSysdate,(char *)szSysDate("YYYYMMDD"));
   sprintf(szComando,"mkdir -p %s/%s",stStatus.szLogPathGene,szhSysdate);
   if (system (szComando)!=0)
   {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
   }
   sprintf(szArchivoLog,"%s/%s/%s.log",stStatus.szLogPathGene,szhSysdate,stStatus.szFileName);
   sprintf(szArchivoErr,"%s/%s/%s.err",stStatus.szLogPathGene,szhSysdate,stStatus.szFileName);
   sprintf(szArchivoEst,"%s/%s/%s.est",stStatus.szLogPathGene,szhSysdate,stStatus.szFileName);

   if((stStatus.LogFile = fopen(szArchivoLog,"a")) == (FILE*)NULL )    {
        fprintf (stderr,"Error al crear archivo de Log\n");
        fflush  (stderr);
        return -1;
   }

   if((stStatus.ErrFile = fopen(szArchivoErr,"a")) == (FILE*)NULL )    {
        fprintf (stderr,"Error al crear archivo de Errores\n");
        fflush  (stderr);
        return -1;
   }

   if((stStatus.EstFile = fopen(szArchivoEst,"a")) == (FILE*)NULL )    {
        fprintf (stderr,"Error al crear archivo de Estadisticas\n");
        fflush  (stderr);
        return -1;
   }

	ifnTrazasLog(modulo, "%s - APERTURA DE ARCHIVO - \n\n\t PROCESO => %s - PID => %ld - VERSION => %s.\n", INFALL,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),  szgCodProceso, getpid(), szVERSION);

   return 0;

}/* end ifnAbreArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs  */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
char modulo[]="vfnCierraArchivoLog";

    ifnTrazasLog(modulo, "\n\t%s -  CIERRE  DE ARCHIVO <%ld> -\n\n", INFALL,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

    if ( fclose(stStatus.LogFile) != 0 )    {
        fprintf (stderr,"Error al cerrar archivo de Log\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.ErrFile) != 0 )    {
        fprintf (stderr,"Error al cerrar archivo de Errores\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.EstFile) != 0 )    {
        fprintf (stderr,"Error al cerrar archivo de Estadisticas\n");
        fflush  (stderr);
    }

    return;
} /* end vfnCierraArchivoLog */
/* ============================================================================= */


/* ============================================================================= */
/*  ifnEjecutaCola() : Ejecuta la cola de acciones                               */
/* ============================================================================= */
int ifnEjecutaCola( LINEACOMANDO *pstLComando )
{
char modulo[]="ifnEjecutaCola";
int  i;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihValor_cero = 0;
	int  iDiffSeg     = 0;
	char szIniProc[19]    ; /* EXEC SQL VAR szIniProc IS STRING(19); */ 

	char szFinProc[19]    ; /* EXEC SQL VAR szFinProc IS STRING(19); */ 

   char szTmpProc[19];
/* EXEC SQL END DECLARE SECTION; */ 



   ifnTrazasLog(modulo,"Corriendo la cola lanzada ",LOG05);
   if (!bfnCambiaEstadoCola(szgCodProceso,"L","R"))
   {
        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'L->R' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        return -1;
   } else {
        if (!bfnOraCommit())  {
            ifnTrazasLog(modulo,"En Commit 'L->R' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
            if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,sqlca.sqlerrm.sqlerrmc);
            return -1;
        }
   }

	sqlca.sqlcode=0;
	/* EXEC SQL EXECUTE
		BEGIN
			:szIniProc := TO_CHAR(SYSDATE,:szhHH24MISS );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szIniProc := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; END\
 ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )81;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szIniProc;
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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



	sqlca.sqlcode=0;
	/* EXEC SQL
	SELECT COUNT(*)
	INTO   :ihCountEstadis
	FROM   CO_ESTADISEVA_TO
	WHERE  COD_PROCESO = :szhProceso
	AND    TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_ESTADISEVA_TO where (COD_\
PROCESO=:b1 and TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )104;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCountEstadis;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[1] = (unsigned long )5;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "SELECT count(*) CO_ESTADISEVA_TO - %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	if ((ihCountEstadis == 0) || (sqlca.sqlcode == SQLNOTFOUND )) {
		/* Insertando estadisticas del proceso padre. Secuencia de este corresponde a 0 */
		if (ifnInsertaEstadisticas(iSec_Padre, szhProceso) != 0 )  return -1;
	}

  	/* Carga de datos de uso general*/
	if( !bfnObtieneDatosGenerales())	{
	    ifnTrazasLog( modulo, "Error al realizar carga de bfnObtieneDatosGenerales().", LOG03 );
	    return -1;
	}

	/* Calcula porcentaje de memoria libre y usada */
	if (ifnMemoriaUsada(&lhCpu)!=0) return -1;

	/* Selecciona cantidad  de instancias */
	if (ifnValInstancias(szhProceso, &ihNUM_INSTAN)!=0) return -1;

	memset(szhUser_Cobros,'\0',sizeof(szhUser_Cobros));

	/* Selecciona usuario de la ged_parametro */
	if (ifnUsuarioParam(szhUser_Cobros)!=0) return -1;

	/* llamamos a la funcion que ejecuta las acciones propias del ejecutor */
	if ( ifnEjecutor() < 0)
		ifnMailAlert("EJECUTOR","TODOS","%s",szDescError);

	ifnTrazasLog( modulo, "Saliendo de %s ( Cola Wait )", LOG02, szgCodProceso );

	/****************************************************************************************/
	/* EXEC SQL EXECUTE
		BEGIN
			:szFinProc := TO_CHAR(SYSDATE,:szhHH24MISS);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szFinProc := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; END\
 ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )127;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szFinProc;
 sqlstm.sqhstl[0] = (unsigned long )19;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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



	iDiffSeg = ifnRestaHoras(szIniProc,szFinProc,szTmpProc);
	ifnTrazasLog( modulo, "Actualizar CO_ESTADISEVA_TO con :\n\t\tiDiffSeg  [%d]\n\t\tszIniProc [%s]\n\t\tszFinProc [%s]", LOG03,iDiffSeg,szIniProc,szFinProc);

	ihTotalClies=0;
	ifnTrazasLog( modulo, "lTotalRows [%ld]", LOG03,lTotalRows);
	/* Informacion Estadistica */
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT NVL(SUM(CNT_CLIENTES_PROC),:ihValor_cero)
	INTO   :ihCountEstadis
	FROM   CO_ESTADISEVA_TO
	WHERE  COD_PROCESO = :szhProceso
	AND    SECUENCIA   = :ihValor_cero
	AND    TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum(CNT_CLIENTES_PROC),:b0) into :b1  from CO_EST\
ADISEVA_TO where ((COD_PROCESO=:b2 and SECUENCIA=:b0) and TRUNC(FEC_INGRESO)=T\
RUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )150;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCountEstadis;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[2] = (unsigned long )5;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "SELECT count(*) CO_ESTADISEVA_TO Padre - %s.", LOG00, sqlca.sqlerrm.sqlerrmc );

	} else if (sqlca.sqlcode == SQLNOTFOUND)  {
		ifnTrazasLog(modulo, "Registro deberia existir..!!.", LOG02);

	} else  {

		if (ihCountEstadis < lTotalRows) {
			ihTotalClies=lTotalRows;

			/* actualizando estadisticas del proceso padre. Secuencia corresponde a 0*/
			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			UPDATE CO_ESTADISEVA_TO SET
					 TIEMPO_PROCESO    = :iDiffSeg ,
					 CNT_CLIENTES_PROC = :ihTotalClies,
					 FEC_INGRESO       = SYSDATE
			WHERE  COD_PROCESO       = :szhProceso
			AND    SECUENCIA         = :ihValor_cero
			AND    TRUNC(FEC_INGRESO)= TRUNC(SYSDATE); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_ESTADISEVA_TO  set TIEMPO_PROCESO=:b0,CNT_CLIENT\
ES_PROC=:b1,FEC_INGRESO=SYSDATE where ((COD_PROCESO=:b2 and SECUENCIA=:b3) and\
 TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )181;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&iDiffSeg;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihTotalClies;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhProceso;
   sqlstm.sqhstl[2] = (unsigned long )5;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
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


			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
			   ifnTrazasLog(modulo, "Error al actualizar estadistica del Padre. - %s", LOG00,sqlca.sqlerrm.sqlerrmc);
			}
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )212;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		}

	}

	/* inserta cantidad de instancias */
	if (ifnInsertaParamUnix(szhProceso, ihNUM_INSTAN, lhCpu)!=0)  return -1;
	ifnTrazasLog(modulo,"\n\t       HORA INICIO  : %s "
	                    "\n\t       HORA TERMINO : %s "
	                    "\n\t       TIEMPO TOTAL : %s  (%d segs)"
	                    "\n\t PROMEDIO x CLIENTE : %.5f segs "
	                    "\n",LOG03,szIniProc,szFinProc,szTmpProc,iDiffSeg,(float)((float)iDiffSeg/(float)ihTotalClies) );

   ifnTrazasLog(modulo,"Volviendo la cola a espera ",LOG05);
   if (!bfnCambiaEstadoCola(szgCodProceso,"R","W")) /*'Running->Wait'*/   {
        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'R->W' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
        return -1;

   } else {
        if (!bfnOraCommit())  {
            ifnTrazasLog(modulo,"En Commit 'R->W' : %s",LOG00,sqlca.sqlerrm.sqlerrmc);
            if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,sqlca.sqlerrm.sqlerrmc);
            return -1;
        }
   }

	return 0;

} /* fin ifnEjecutaCola */

/* ===================================================================================================== */
/*	Funcion que carga todas las acciones reversas.
	Parametros : stAccionesRev	Guarda las acciones recuperadas.
	             iTotAcciones	Guarda el numero de acciones recuperadas.												*/
/* ===================================================================================================== */
BOOL bfnCargaAccionesReversas( td_Acciones *stAccionesRev )
{
char	modulo[] = "bfnCargaAccionesReversas";
int		iError = 0, i = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodAccionRev[6];
	char  szhLetra_R     [2];
/* EXEC SQL END DECLARE SECTION; */ 


	memset( szhCodAccionRev, '\0', sizeof( szhCodAccionRev ) );
	strcpy(szhLetra_R,"R");

	/* EXEC SQL DECLARE curAccionesRev CURSOR FOR
	SELECT  COD_RUTINA
	FROM    CO_RUTINAS
	WHERE   TIP_RUTINA = :szhLetra_R; */ 


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "DECLARE curAccionesRev %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	/* EXEC SQL OPEN curAccionesRev; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0010;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )227;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_R;
 sqlstm.sqhstl[0] = (unsigned long )2;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "OPEN curAccionesRev %s.", LOG00, sqlca.sqlerrm.sqlerrmc );
		return FALSE;
	}

	for( ; ; )	{
		memset(szhCodAccionRev,'\0',sizeof(szhCodAccionRev));
		/* EXEC SQL FETCH curAccionesRev
		INTO  :szhCodAccionRev; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )246;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodAccionRev;
  sqlstm.sqhstl[0] = (unsigned long )6;
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


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )		{
			ifnTrazasLog( modulo, "FETCH curAccionesRev %s.", LOG00, sqlca.sqlerrm.sqlerrmc );  iError = 1;			;
		}
		if( sqlca.sqlcode == SQLNOTFOUND)		{
			ifnTrazasLog( modulo, "Termino de Datos curAccionesRev.\n", LOG03 );  break;
		}

		strcpy( stAccionesRev->szCodRutina[i], szhCodAccionRev );
		ifnTrazasLog( modulo, "Accion recuperada [%d] [%s].", LOG05, i, stAccionesRev->szCodRutina[i] );
		i++;
	}

	/* EXEC SQL CLOSE curAccionesRev; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )265;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Error CLOSE curAccionesRev => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
	}
	if( iError == 1 )	return FALSE;
	iTotAcciones = i;
	return TRUE;
} /* Fin bfnCargaAccionesReversas */


/* ===================================================================================================== */
/*	Funcion que Verifica si un codigo de accion enviado como parametro, es una accion reversa
	Parametros :stAccionesRev	Estructura con las acciones reversas en el Sistema.
					iTotAcciones	Numero de Acciones reversas en el Sistema.
					szhCodAcc		Codigo de Accion buscado.																	*/
/* ===================================================================================================== */
BOOL bfnEsAccionReversa( FILE **ptArchLog, td_Acciones *stAccionesRev, char *szhCodAcc, sql_context ctxCont )
{
char	modulo[] = "bfnEsAccionReversa";
int		i;
BOOL	bEsReversa = FALSE;
FILE *pfLog;
pfLog = *ptArchLog;

	/*EXEC SQL CONTEXT USE DEFAULT;*/

	ifnTrazaHilos( modulo,&pfLog,  "En funcion %s con Accion de Entrada [%s].", LOG05, modulo, szhCodAcc );

	for( i = 0; i < iTotAcciones; i++ )
	{
		if( strcmp( stAccionesRev->szCodRutina[i], szhCodAcc ) == 0 )
		{
			bEsReversa = TRUE;
			break;
		}
	}
	if (!bEsReversa)
	ifnTrazaHilos( modulo,&pfLog,  "Accion de Entrada [%s] no es reversa.", LOG05, szhCodAcc );

	return bEsReversa;
} /* Fin bfnEsAccionReversa */

/* ========================================================================================= */
/*  Funcion que selecciona clientes para ser procesadas sus acciones pendientes              */
/* ========================================================================================= */
int ifnEjecutor()
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	int	ihClientesALeer = 0;
	char	szhNUM_CLIENTES[13];
	char	szhModulo       [3];
	char	szhPND          [4];
	char	szhLetraA       [2];
	char	szhLetraR       [2];
	int	idhInsTrabajo;
	char	szhUserPass    [65];
	char  szSesuserOra   [50];	/* EXEC SQL VAR szSesuserOra    IS STRING(50); */ 

	int	  ihValorUno = 1;
/* EXEC SQL END DECLARE SECTION; */ 


char	modulo[] = "ifnEjecutor";
int		x, i, ihFlgActiva = 0, ihFlgError = 0;
int		idInsTrabajo, iCntInsDisponible, iCntInsNoDisponible, iCntClientesAsig, iCntIns;
int		iError;
long  	lIdInstanciaLanzada;
BOOL	bAsignarTrabajo, bSalir = FALSE;
char 	szIdInstanciaAux[10];
thread_t	thrIdHiloEnd;
Lista_Clie	pLisClientes = NULL;
void		*pRtnValue;

	ifnTrazasLog( modulo, "Entrando en modulo => [%s].\n", LOG05, modulo );
	memset( szhUserPass, '\0', sizeof( szhUserPass ) );
	memset( szhLetraA, '\0', sizeof( szhLetraA ) );
	memset( szhLetraR, '\0', sizeof( szhLetraR ) );
	strcpy( szhNUM_CLIENTES, "NUM_CLIENTES" );
	strcpy( szhModulo, "CO" );
	strcpy( szhPND, "PND" );
	strcpy( szhLetraA, "A" );
	strcpy( szhLetraR, "R" );

	/*================================================================*/
	/* Se cargan en una estructura el total de reversas de acciones   */
	if( !bfnCargaAccionesReversas( &stAccionesRev)) 	{
		memset(szDescError,'\0',sizeof(szDescError));
		sprintf( szDescError, "Error al Cargar Acciones Reversas." );
		return -1;
	}

	/* EXEC SQL DELETE FROM CO_CLIEPROCESO_TO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_CLIEPROCESO_TO ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )280;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  	{
		ifnTrazasLog( modulo, "Error al limpiar tabla de control de clientes => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		sprintf( szDescError, "Error al limpiar tabla de control de clientes => [%s]", sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )295;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  	{
		ifnTrazasLog( modulo, "COMMIT DELETE CO_CLIEPROCESO_TO => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return -1;
	}

	/* recuperamos el parametro de acciones a recuperar en el arreglo */
	/* EXEC SQL
	SELECT TO_NUMBER( VAL_PARAMETRO )
	INTO  :ihClientesALeer
	FROM  GED_PARAMETROS
	WHERE NOM_PARAMETRO= :szhNUM_CLIENTES
	AND   COD_MODULO   = :szhModulo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_NUMBER(VAL_PARAMETRO) into :b0  from GED_PARAMETRO\
S where (NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )310;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihClientesALeer;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhNUM_CLIENTES;
 sqlstm.sqhstl[1] = (unsigned long )13;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
 sqlstm.sqhstl[2] = (unsigned long )3;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
		ifnTrazasLog( modulo, "Error al recuperar Parametro Acciones a Leer => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		sprintf( szDescError, "Error al recuperar Parametro Acciones a Leer => [%s]", sqlca.sqlerrm.sqlerrmc );
	}

   if( sqlca.sqlcode == SQLNOTFOUND || ihClientesALeer <= 0 )  {
		 /*si no esta definido el parametro, el valor por defecto es un cliente cada vez, al igual si es cero */
		ifnTrazasLog( modulo, "El parametro, no esta definido, se define en 1(un) cliente cada Lectura.", LOG03 );
		ihClientesALeer = 1;
	}
	ifnTrazasLog( modulo, "Parametro ClientesALeer => [%d]\n", LOG03, ihClientesALeer);

	strcpy( szhUserPass, szUsuarioConec);
	strcat( szhUserPass, "/" );
	strcat( szhUserPass, szPasswConec);

	ifnTrazasLog( modulo, "Abriendo Conexiones a BD segun instancias definidas.  szhUserPass [%s]", LOG03,szhUserPass);
	/*Abrimos las instancias de Base de Datos */
	for( i = 1; i < ihNUM_INSTAN+1; i++ )
	{
		/* EXEC SQL CONTEXT ALLOCATE :CtxInsBas[i]; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )337;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&CtxInsBas[i];
  sqlstm.sqhstl[0] = (unsigned long )sizeof(void *);
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


		/* EXEC SQL CONTEXT USE :CtxInsBas[i]; */ 

		/* EXEC SQL CONNECT :szhUserPass; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )10;
  sqlstm.offset = (unsigned int  )356;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhUserPass;
  sqlstm.sqhstl[0] = (unsigned long )65;
  sqlstm.sqhsts[0] = (         int  )65;
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
  sqlstm.sqlcmax = (unsigned int )100;
  sqlstm.sqlcmin = (unsigned int )2;
  sqlstm.sqlcincr = (unsigned int )1;
  sqlstm.sqlctimeout = (unsigned int )0;
  sqlstm.sqlcnowait = (unsigned int )0;
  sqlcxt(&CtxInsBas[i], &sqlctx, &sqlstm, &sqlfpn);
}



	}
	ifnTrazasLog( modulo, "Fin a apertura de Conexiones a BD\n", LOG03);

	/* seteamos la instancia de base de datos por defecto */
	/* EXEC SQL CONTEXT USE DEFAULT; */ 

	/* inicializamos los datos de la estructura de instancias */
	ifnTrazasLog( modulo, "Inicializando datos de estructura de instancias.", LOG05 );

	for( i = 1; i < ihNUM_INSTAN+1; i++ )
	{
		stParametrosHilos[i].bDisponibilidad = TRUE;
		stParametrosHilos[i].idThread = i;
		stParametrosHilos[i].pListaCli = NULL;
		memset( stParametrosHilos[i].szUserOracle, '\0', sizeof( stParametrosHilos[i].szUserOracle ) );
		memset( stParametrosHilos[i].szPassOracle, '\0', sizeof( stParametrosHilos[i].szPassOracle ) );
		stParametrosHilos[i].lIdInstancia = 0;
		stParametrosHilos[i].lCorrInstancia = 0;
	}

	memset( szDescError, '\0', sizeof( szDescError ) );
	iError = 0;
	while( !bSalir )
	{
		bAsignarTrabajo = FALSE;
		idInsTrabajo = 0;
		iCntInsDisponible = 0;
		iCntInsNoDisponible = 0;
		iCntClientesAsig = 0;

		/* revisamos que instancia esta disponible */
		ifnTrazasLog( modulo, "Revisando instancias disponibles.", LOG05 );
		for( iCntIns = 1; iCntIns < ihNUM_INSTAN+1; iCntIns++ )
		{
			ifnTrazasLog( modulo, "REVISANDO Instancia => [%d] Disponibilidad =>[%s].", LOG05,
			iCntIns, ( stParametrosHilos[iCntIns].bDisponibilidad ) ? "Disponible" : "No Disponible" );

			/* mientras haya disponibilidad y no haya error */
			if( stParametrosHilos[iCntIns].bDisponibilidad )
			{
				/* asignamos la primera instancia disponible solamente */
				if( idInsTrabajo == 0 && !iError )
				{
					idInsTrabajo = iCntIns;
					idhInsTrabajo = idInsTrabajo;
					bAsignarTrabajo = TRUE;
					iCntInsNoDisponible++;
				}
				else
				{
					iCntInsDisponible++;;
				}
			}
			else
			{
				iCntInsNoDisponible++;
			}
		} /* for( iCntInstancias = 0; iCntInstancias < ihNUM_INSTAN; iCntInstancias ++ ) */

		ifnTrazasLog( modulo, "** Instancias Disponibles   => [%d]", LOG05, iCntInsDisponible );
		ifnTrazasLog( modulo, "** Instancias no Disponibles=> [%d]", LOG05, iCntInsNoDisponible );

		/* mientras no sea error */
		while( !iError )
		{
			if( bAsignarTrabajo ) /* si hay instancias disponibles se debe asignar trabajo */
			{
				ifnTrazasLog( modulo, "Iniciamos proceso de carga de trabajo para la Instancia => [%d].\n", LOG05, idInsTrabajo );

				sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* recuperamos los clientes que tienen acciones pendientes */
				/*SELECT *+ index (A, PK_CO_ACCIONES) * */
				/* Requerimiento de Soporte - #39107 30-03-2007 capc */

				/*EXEC SQL
				DECLARE CUR_CLIENTES_ACC CURSOR FOR
				SELECT UNIQUE A.COD_CLIENTE
				FROM   CO_ACCIONES A, CO_RUTINAS R
				WHERE  A.COD_ESTADO = :szhPND
				AND    A.FEC_EJECPROG < SYSDATE
				AND    A.COD_RUTINA = R.COD_RUTINA
				AND NOT EXISTS ( SELECT 1
				FROM CO_CLIEPROCESO_TO
				WHERE COD_CLIENTE = A.COD_CLIENTE )
				ORDER  BY A.COD_CLIENTE;*/

				/* Inicio Requerimiento de Soporte - #39340 26-04-2007 mgg */
				/* EXEC SQL
				DECLARE CUR_CLIENTES_ACC CURSOR FOR
				SELECT a.cod_cliente
				  FROM (
						 SELECT UNIQUE a.cod_cliente
						   FROM co_acciones a
						  WHERE NOT EXISTS ( SELECT :ihValorUno
						                       FROM co_clieproceso_to
						                      WHERE cod_cliente = a.cod_cliente
					                       )
				            AND a.cod_rutina IN ( SELECT r.cod_rutina
				                                    FROM (
				                                           SELECT cod_rutina
				                                             FROM co_rutinas
				                                            WHERE niv_prioridad IS NOT NULL
				                                              AND tip_rutina IN ( :szhLetraA, :szhLetraR )
				                                           ORDER BY niv_prioridad DESC
				                                         ) r
				                                   WHERE r.cod_rutina = a.cod_rutina
				                                )
				            AND a.fec_ejecprog < SYSDATE
				            AND a.cod_estado = :szhPND
				            AND ROWNUM <= :ihClientesALeer * 2
				       ) a
				 WHERE ROWNUM <= :ihClientesALeer; */ 

				/* Fin Requerimiento de Soporte - #39340 26-04-2007 mgg */

				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  
				{
					ifnTrazasLog( modulo, "DECLARE CUR_CLIENTES_ACC.", LOG02);
				}

				sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* EXEC SQL
				OPEN CUR_CLIENTES_ACC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0015;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )387;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValorUno;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhLetraA;
    sqlstm.sqhstl[1] = (unsigned long )2;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhLetraR;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhPND;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihClientesALeer;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihClientesALeer;
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



				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  
				{
					ifnTrazasLog( modulo, "OPEN CUR_CLIENTES_ACC.", LOG02);
				}

				while (1)
				{
					sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
					/* EXEC SQL
					FETCH CUR_CLIENTES_ACC
					 INTO :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 6;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )426;
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



					if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  
					{
						ifnTrazasLog( modulo, "Error FETCH CUR_CLIENTES_ACC => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
						sprintf( szDescError, "Error FETCH CUR_CLIENTES_ACC => [%s].", sqlca.sqlerrm.sqlerrmc );
						iError = -1;
						break;
					}

					if( sqlca.sqlcode != SQLNOTFOUND ) 
					{
						/* Insertamos un nodo para el codigo de cliente */
						if( ifnInsertaClie( &pLisClientes ) != 0 )
						{
							ifnTrazasLog( modulo, "Error al Insertar Nodo en pLista_Clie.", LOG00);
							sprintf( szDescError, "Error al Insertar Nodo en pLista_Clie." );
							iError = -1;
							break;
						}

						/* asignamos el codigo de cliente al nuevo nodo */
						pLisClientes->lCod_cliente = lhCodCliente;
						lTotalRows++;
						ifnTrazasLog( modulo, "Hilo => [%d] Cliente => [%d]", LOG05, idInsTrabajo, lhCodCliente );

						/* se aumenta el contador de clientes leidos */
						iCntClientesAsig++;
						iTot_Clies[idInsTrabajo]++; /* clientes por hilo para estadistica del hilo ...(hilo curado en este caso porque va a quedar entero de loco)*/

						/* si los clientes leidos es igual al numero de clientes maximo se sale del ciclo */
						if( iCntClientesAsig == ihClientesALeer )
						{
							ifnTrazasLog( modulo, "Completamos el numero de clientes a leer, salimos del ciclo.\n", LOG05 );
							break;
						}
					}
					else
					{
						ifnTrazasLog( modulo, "Termino de datos cursor CUR_CLIENTES_ACC.\n", LOG05 );
						break;
					} /* if( sqlca.sqlcode != SQLNOTFOUND ) */
				} /* while (1) */

				sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
				/* cerramos el cursor de clientes */
				/* EXEC SQL CLOSE CUR_CLIENTES_ACC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )445;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  
				{
					ifnTrazasLog( modulo, "Error CLOSE CUR_CLIENTES_ACC => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					sprintf( szDescError, "Error CLOSE CUR_CLIENTES_ACC => [%s].", sqlca.sqlerrm.sqlerrmc );
					/*iError = -1;*/
				}

				/* si el ciclo while fetch falla o el cierre del cursor se sale */
				if( iError == -1 )
					iCntClientesAsig = 0;

				ifnTrazasLog( modulo, "Numero de clientes leidos => [%d].", LOG05, iCntClientesAsig );

				if( iCntClientesAsig > 0 ) /* hay clientes a asignar */
				{
					if( ihNUM_INSTAN > 0 )
					{
						/* si se produce un error al registrar los clientes asignados al hilo */
						if( ifnRegistraClientesHilo( idInsTrabajo, pLisClientes ) != 0 ) /* Requerimiento de Soporte - #39340 26-04-2007 mgg */
						{
							/* debemos borrar los clientes asignados al hilo */
							if( ifnEliminaClientesHilo( idInsTrabajo ) != 0 ) /* Requerimiento de Soporte - #39340 26-04-2007 mgg */
							{
								sprintf( szDescError, "Error en la funcion ifnEliminaClientesHilo." );
								iError = -1;
								break;
							}
							sprintf( szDescError, "Error en la funcion ifnRegistraClientesHilo." );
							iError = -1;
							break;
						} /* if( !ifnRegistraClientesHilo( pLisClientes, idInsTrabajo ) ) */
					}  /*if( ihNUM_INSTAN > 1 ) */
	
					stParametrosHilos[idInsTrabajo].bDisponibilidad = FALSE;
					stParametrosHilos[idInsTrabajo].CtxInsBas = CtxInsBas[idInsTrabajo];
					stParametrosHilos[idInsTrabajo].idThread = idInsTrabajo;
					stParametrosHilos[idInsTrabajo].pListaCli = pLisClientes;
					strcpy( stParametrosHilos[idInsTrabajo].szUserOracle, stLineaComando.szOraAccount );
					strcpy( stParametrosHilos[idInsTrabajo].szPassOracle, stLineaComando.szOraPasswd );
					stParametrosHilos[idInsTrabajo].lCorrInstancia++;
	
					ifnTrazasLog( modulo, "El numero de instancia a pasar es el => [%d]", LOG05, stParametrosHilos[idInsTrabajo].idThread);
	
					/* Llama a la funcion que asignara la carga de trabajo al hilo */
					if( ifnGatillaHilos( stParametrosHilos[idInsTrabajo], &lIdInstanciaLanzada ) != 0 )
					{
						sprintf( szDescError, "Error en la funcion ifnGatillaHilos." );
						iError = -1;
						break;
					}
	
					sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
					memset( szSesuserOra, '\0',sizeof(szSesuserOra));
					/* EXEC SQL EXECUTE
						BEGIN
							:szSesuserOra  := sys_context('USERENV','SESSIONID');
						END;
					END-EXEC; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 6;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "begin :szSesuserOra := sys_context ( 'USERENV' , 'SESSIO\
NID' ) ; END ;";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )460;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szSesuserOra;
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


	
					ifnTrazasLog( modulo, "Instancia Base de Datos DEFAULT II Id de Usuario => [%s]", LOG05, szSesuserOra );
	
					stParametrosHilos[idInsTrabajo].lIdInstancia = lIdInstanciaLanzada;
					ifnTrazasLog( modulo, "Para la instancia disponible => [%d] se asigno el ID de Instancia => [%d].", LOG05, idInsTrabajo, lIdInstanciaLanzada );
	
					/* seteamos las variables a usar en el proceso de asignacion de clientes */
					pLisClientes = NULL;
				}
				else
				{
					stParametrosHilos[idInsTrabajo].bDisponibilidad = TRUE;
					iCntInsNoDisponible--;
					iCntInsDisponible++;
				} /* if( iCntClientesAsig > 0 ) */
			} /* if( bAsignarTrabajo ) */

			if (1) break;

		} /* while( iError ) */

		if( iError == -1 ) /* si hay error */
			iCntClientesAsig = 0; /* se setea la variable de clientes a cero esperando a que terminen las instancias en ejecucion para salir */

		/* si todas las intancias permitidas estan disponibles y no hay clientes, esto se termina */
		if( ihNUM_INSTAN == iCntInsDisponible && iCntClientesAsig == 0 )
		{
			ifnTrazasLog( modulo, "No hay mas clientes a procesar se termina la EJECUCION.", LOG03);
			bSalir = TRUE;
		}
		/* si hay instancias permitidas disponibles y hay clientes se debe asignar carga de trabajo */
		else if( iCntInsDisponible > 0  && iCntClientesAsig == ihClientesALeer )
		{
			ifnTrazasLog( modulo, "Hay instancias disponibles y hay clientes, vamos a asignar carga de trabajo a otra instancia.", LOG03);
		}
		else
		{
			ifnTrazasLog( modulo, "Quedamos a la espera que finalice una instancia.", LOG03);

			while( 1 )
			{
				memset( &thrIdHiloEnd, NULL, sizeof( thrIdHiloEnd ) );
				memset(  szIdInstanciaAux, '\0', sizeof(  szIdInstanciaAux ) );

				/*thr_join( 0 , &thrIdHiloEnd , NULL );*/  /* Requerimiento de Soporte - #71598 17-10-2008 mgg */

				thr_join( 0 , &thrIdHiloEnd , &pRtnValue );	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */

				ifnTrazasLog( modulo, "Retorno Hilo thr_join => [%d].\n", LOG03, pRtnValue );

				/*thr_join( threadIdHilo[x] , &thrIdHiloEnd , NULL );*/

				ifnTrazasLog( modulo, "Termino el ID de Instancia => [%d].\n", LOG05, thrIdHiloEnd );

				sprintf( szIdInstanciaAux, "%d", thrIdHiloEnd );
				lIdInstanciaLanzada = atol( szIdInstanciaAux );

				/* Espera que terminen todos los hilos de ejecutarse para continuar el proceso */
				for( x = 1; x <= ihNUM_INSTAN+1; x++ )
				{
					ifnTrazasLog( modulo, "Comparamos stParametrosHilos[x].lIdInstancia => [%d] lIdInstanciaLanzada => [%d].\n", LOG08, stParametrosHilos[x].lIdInstancia, lIdInstanciaLanzada );
					if( stParametrosHilos[x].lIdInstancia == lIdInstanciaLanzada )
					{
						ifnTrazasLog( modulo, "Se encontro la Instancia terminada en la posicion => [%d].\n", LOG08, x );
						break;
					}
				}

				if( x > ihNUM_INSTAN+1 )  
				{
					ifnTrazasLog( modulo, "Aun no termina ninguna instancia.", LOG05 );
				}
				else
				{
					ifnTrazasLog( modulo, "Termino una instancia vamos a asignar carga de trabajo.\n", LOG05 );

					if( ifnEliminaClientesHilo( x ) != 0 ) /* Requerimiento de Soporte - #39340 26-04-2007 mgg */
					{
						sprintf( szDescError, "Error en la funcion ifnEliminaClientesHilo." );
						iError = -1;
					}
		
					stParametrosHilos[x].bDisponibilidad = TRUE;
					stParametrosHilos[x].lIdInstancia = 0;

					/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
					if ( pRtnValue == 2 )
					{
						iError = -1;
					}

					break;
				}
			} /* while( 1 ) */
		} /* if( ihNUM_INSTAN ==  && iCntClientesAsig == 0 ) */
	} /* while( !bSalir ) */

	for( i = 1; i < ihNUM_INSTAN+1; i++ )
	{
		/* EXEC SQL CONTEXT FREE :CtxInsBas[i]; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )479;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&CtxInsBas[i];
  sqlstm.sqhstl[0] = (unsigned long )sizeof(void *);
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

	vfnBorraListaClie( &pLisClientes );

	/* Informacion Estadistica */
	if( ihTotalClies > 0 )
	{
		ifnTrazasLog( modulo, 	"\n\t RESUMEN DEL PROCESO        "
								"\n\t Clientes revisados    = [%ld]"
								"\n\t Acciones Inmunes      = [%ld]"
								"\n\t          Ejecutadas   = [%ld]"
								"\n\t          Pendientes   = [%ld]"
								"\n", LOG03, lTotalRows, lhContInmu, lhContOk, lhContPnd );
	}

	ifnTrazasLog( modulo, "Saliendo de %s", LOG05, modulo );

	if (ihFlgError)
	{
		return ihFlgError;
	}

   return 0;

}/* fin ifnEjecutor */

/* ========================================================================================= */
/*  Funcion que registra en la tabla de control los clientes asignados al hilo               */
/* ========================================================================================= */
int ifnRegistraClientesHilo( int iIDHilo, Lista_Clie pListaClie )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	int	ihIDHilo;
	char  szSesuserOra[50];	/* EXEC SQL VAR szSesuserOra    IS STRING(50); */ 

	char	szhPND          [4];
/* EXEC SQL END DECLARE SECTION; */ 


char modulo[] = "ifnRegistraClientesHilo";
int	 iError = 0;
Lista_Clie	pLisClieRegistrar = NULL;

	strcpy( szhPND, "PND" );
	memset( szSesuserOra, '\0',sizeof(szSesuserOra));
	/* EXEC SQL EXECUTE
		BEGIN
		   :szSesuserOra  := sys_context('USERENV','SESSIONID');
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szSesuserOra := sys_context ( 'USERENV' , 'SESSIONID'\
 ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )498;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szSesuserOra;
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


	ifnTrazasLog( modulo, "Instancia Base de Datos DEFAULT I Id de Usuario => [%s]", LOG05, szSesuserOra );

	pLisClieRegistrar = pListaClie;
	ihIDHilo = iIDHilo;

	while( pLisClieRegistrar != NULL )
	{
		lhCodCliente = pLisClieRegistrar->lCod_cliente;

		/* EXEC SQL
		INSERT INTO CO_CLIEPROCESO_TO  (
			    COD_CLIENTE, COD_ESTADO, ID_HILO  )
		VALUES (:lhCodCliente, :szhPND, :ihIDHilo); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into CO_CLIEPROCESO_TO (COD_CLIENTE,COD_ESTADO,ID_HI\
LO) values (:b0,:b1,:b2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )517;
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
  sqlstm.sqhstv[1] = (unsigned char  *)szhPND;
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihIDHilo;
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



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazasLog( modulo, "HILO => [%d] INSERT CO_CLIEPROCESO_TO => [%s].", LOG00, ihIDHilo, sqlca.sqlerrm.sqlerrmc );
			iError = 1;
			break;
		}

		pLisClieRegistrar = pLisClieRegistrar->sig;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )544;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
		ifnTrazasLog( modulo, "HILO => [%d] COMMIT INSERT CO_CLIEPROCESO_TO => [%s].", LOG00, ihIDHilo, sqlca.sqlerrm.sqlerrmc );
		iError = 1;
	}

	if( iError == 1 )
		ifnTrazasLog( modulo, "ERROR AL REGISTRAR CLIENTES ASIGNADOS A LA INSTANCIA => [%d].", LOG01, ihIDHilo );

	return iError;
} /* int ifnRegistraClientesHilo( int iIDHilo, Lista_Clie pListaClie ) */

/* ========================================================================================= */
/*  Funcion que elimina de la tabla de control los clientes asignados al hilo                */
/* ========================================================================================= */
int ifnEliminaClientesHilo( int iIDHilo )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int		ihIDHilo;
/* EXEC SQL END DECLARE SECTION; */ 


char modulo[] = "ifnEliminaClientesHilo";
int	 iError = 0;

	ihIDHilo = iIDHilo;
	/* EXEC SQL
	DELETE FROM CO_CLIEPROCESO_TO
	WHERE ID_HILO = :ihIDHilo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_CLIEPROCESO_TO  where ID_HILO=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )559;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIDHilo;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
		ifnTrazasLog( modulo, "HILO => [%d] DELETE CO_CLIEPROCESO_TO => [%s].", LOG00, ihIDHilo, sqlca.sqlerrm.sqlerrmc );
		iError = -1;
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )578;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
		ifnTrazasLog( modulo, "HILO => [%d] COMMIT DELETE CO_CLIEPROCESO_TO => [%s].", LOG00, ihIDHilo, sqlca.sqlerrm.sqlerrmc );
		iError = -1;
	}

	if( iError == -1 )
		ifnTrazasLog( modulo, "ERROR AL ELIMINAR CLIENTES ASIGNADOS A LA INSTANCIA => [%d].", LOG01, ihIDHilo );

	return iError;
} /* int ifnEliminaClientesHilo( int iIDHilo ) */

/* ========================================================================================= */
/*  Funcion que ejecuta los hilos que seran ejecutados                                       */
/* ========================================================================================= */
int ifnGatillaHilos( PARAMETROS pstParametros, long *lIdInstLanzada )
{
char modulo[] = "ifnGatillaHilos";
int  error = 0, i;

	ifnTrazasLog( modulo, "Ingreso a modulo => [%s].", LOG05, modulo );
	ifnTrazasLog( modulo, "     Parametros recibidos.", LOG05 );
	ifnTrazasLog( modulo, "     Thread ID           => [%d].", LOG05, pstParametros.idThread );
	ifnTrazasLog( modulo, "     Disponibilidad      => [%s].", LOG05, ( pstParametros.bDisponibilidad ) ? "Disponible" : "No Disponible" );
	ifnTrazasLog( modulo, "     Correlativo         => [%ld].\n", LOG05, pstParametros.lCorrInstancia );

	/***********************************************************************************************/
	ifnTrazasLog( modulo, "El numero de instancia a lanzar es el => [%d].", LOG05, threadIdHilo[pstParametros.idThread] );
	error = thr_create (NULL, NULL, vProcesaAccionesCliente, (void*) (&pstParametros), NULL, &threadIdHilo[pstParametros.idThread] );
	if( error != 0 )	{
		ifnTrazasLog( modulo, "No puedo crear thread..snif..snif..", LOG01 );
		return -1;
	}

	/* EXEC SQL CONTEXT USE DEFAULT; */ 

	ifnTrazasLog( modulo, "El numero de instancia lanzada es el  => [%d].", LOG05, threadIdHilo[pstParametros.idThread] );

	thr_setconcurrency(thr_getconcurrency()+1);
	/* seteamos la instancia de base de datos por defecto */
	*lIdInstLanzada = threadIdHilo[pstParametros.idThread];

	ifnTrazasLog( modulo, "Fin de modulo => [%s].\n", LOG05, modulo );
	return 0;
}

/* ========================================================================================= */
/*  Funcion que genera los hilos que seran ejecutados                                        */
/* ========================================================================================= */
void *vProcesaAccionesCliente( void *pstParam )
{
PARAMETROS *stParametros = (PARAMETROS*) pstParam;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int		idhInsTrabajo       ;
	long	lhCod_cliente       ;
	char	szSesuserOra    [50]; /* EXEC SQL VAR szSesuserOra    IS STRING(50); */ 

	char	szhPND           [4];
	char	szhEPR           [4];
	char	szhUserPass     [65];
	char 	szahCodAcc [MAX_ACC][6]; /* EXEC SQL VAR szahCodAcc IS STRING(6); */ 
 /* Codigo de la Accion */
	long 	lahNumSeq  [MAX_ACC];    /* Secuencia de la Accion */
	char	szhCodRutina     [6]; /* EXEC SQL VAR szhCodRutina IS STRING(6); */ 

	int		ihAboCeluGlobal     ;
	int		ihAboBeepGlobal     ;
	char	szhEstado        [4];
	double	dhDeuVencida= 0    ;
	char	szTipMoroso      [2];
	char	szhRet           [6]; /* EXEC SQL VAR szhRet IS STRING(6); */ 
   /* Valor de Retorno de la Accion */
	int		ihFlgInmune  = 0    ;
	int		ihValor_cero = 0    ;
	int   	ihCountHilo         ;
	long  	iDiffSeg = 0        ;
	char 	szIniHilo        [9]; /* EXEC SQL VAR szIniHilo IS STRING(9); */ 

	char  	szFinHilo        [9]; /* EXEC SQL VAR szFinHilo IS STRING(9); */ 

	char  	szTmpHilo        [9];
	char  	szhFecDefinitiva[15]; /* EXEC SQL VAR szhFecDefinitiva IS STRING(15); */ 

	char  	szhFecTentativa [15]; /* EXEC SQL VAR szhFecTentativa IS STRING(15); */ 

	int  	iNumSesenta      = 60;
	int  	iNumVeinticuatro = 24;
	char 	szhYYYYMMDDHH24MISS[17];
	sql_context CXX;
	char  szhTipRutina [2]; /* EXEC SQL VAR szhTipRutina IS STRING(2); */ 
 /* XO-200508200408 Soporte RyC 24-08-2005 capc*/

/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "vProcesaAccionesCliente";
char szNomArchLog[30];
int  i=0, j=0 , ihFlgActiva=0,  iAccionEjecutada = 0;
int  iEsInmune, iError=0, bSalir;
long lRowsCiclo = 0;
char *pszRet;
long bEsAccionReversa = 0; /* XO-200508200408 Soporte RyC 24-08-2005 capc*/

Lista_Clie pListaAux = NULL;
struct sqlca sqlca;
FILE *pfLog;

	memset( szIniHilo, '\0', sizeof( szIniHilo ) );
	memset( szFinHilo, '\0', sizeof( szFinHilo ) );
	memset( szTmpHilo, '\0', sizeof( szTmpHilo ) );
	memset( szNomArchLog, '\0', sizeof( szNomArchLog ) );
	memset( szSesuserOra, '\0', sizeof( szSesuserOra ) );
	strcpy( szhPND, "PND" );
	strcpy( szhEPR, "EPR" );
	strcpy(szhYYYYMMDDHH24MISS,"YYYYMMDDHH24MISS");

/*thr_exit((void *)2);*/

	CXX = stParametros->CtxInsBas;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	/* EXEC SQL EXECUTE
		BEGIN
			:szIniHilo := TO_CHAR(SYSDATE,:szhHH24MISS);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szIniHilo := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; END\
 ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )593;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szIniHilo;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



   sprintf( szNomArchLog, "%s_%02d\0", stStatus.szFileName, stParametros->idThread );

	/* Apertura de archivo log hijo */
	if( ifnAbreArchivoLogHiloEjecEx( szNomArchLog, &pfLog, szhSysdate) != 0 )
		thr_exit(NULL);

	ifnTrazaHilos( modulo, &pfLog, "=======================================================", LOG03);
	ifnTrazaHilos( modulo, &pfLog, "*** INICIO ARCHIVO LOG DE EJECUTOR HIJO --->  [%s]  ***\n", LOG03, szNomArchLog );

	ifnTrazaHilos( modulo, &pfLog, "Ingreso a modulo => [%s].", LOG05, modulo );
	ifnTrazaHilos( modulo, &pfLog, "\t Parametros recibidos.", LOG05 );
	ifnTrazaHilos( modulo, &pfLog, "\t Thread ID           => [%d].", LOG05, stParametros->idThread );
	ifnTrazaHilos( modulo, &pfLog, "\t Disponibilidad      => [%s].", LOG05, ( stParametros->bDisponibilidad ) ? "Disponible" : "No Disponible" );
	ifnTrazaHilos( modulo, &pfLog, "\t Usuario             => [%s].", LOG05, stParametros->szUserOracle );
	ifnTrazaHilos( modulo, &pfLog, "\t Password            => [XXXXXX].", LOG05);
	ifnTrazaHilos( modulo, &pfLog, "\t Correlativo         => [%ld].\n", LOG05, stParametros->lCorrInstancia );

	pListaAux = stParametros->pListaCli;
	idhInsTrabajo = stParametros->idThread;

	ifnTrazaHilos( modulo, &pfLog, "Revisando Estadistica Hilo [%d] [%s]", LOG03, idhInsTrabajo,szhProceso);
	/* EXEC SQL
	SELECT COUNT(*)
	  INTO :ihCountHilo
	  FROM CO_ESTADISEVA_TO
	 WHERE COD_PROCESO = :szhProceso
	   AND SECUENCIA   = :idhInsTrabajo
	   AND TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_ESTADISEVA_TO where ((COD\
_PROCESO=:b1 and SECUENCIA=:b2) and TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )616;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCountHilo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[1] = (unsigned long )5;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&idhInsTrabajo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo, &pfLog, "SELECT count(*) CO_ESTADISEVA_TO idhInsTrabajo [%d] - %s.", LOG00, idhInsTrabajo, sqlca.sqlerrm.sqlerrmc );
		thr_exit((void *)2);
		/*thr_exit(NULL);*/
	}

	if ((ihCountHilo == 0) || (sqlca.sqlcode == SQLNOTFOUND))
	{
		/* Insertando estadisticas del proceso hijo.  */
		if (ifnInsertaEstadisticasContex( &pfLog, idhInsTrabajo, szhProceso, CXX) != 0 )
			thr_exit((void *)2);
			/*thr_exit(NULL);*/
	}

	i = 0;
	while( pListaAux != NULL )
	{
		i++;
		lhCod_cliente = pListaAux->lCod_cliente;
		ifnTrazaHilos( modulo, &pfLog, "Posicion => [%d] Cliente => [%ld]", LOG05, i, lhCod_cliente );

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		UPDATE CO_CLIEPROCESO_TO SET
		       COD_ESTADO  = :szhEPR
		WHERE  COD_CLIENTE = :lhCod_cliente
		AND    ID_HILO     = :idhInsTrabajo
		AND    COD_ESTADO  = :szhPND; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_CLIEPROCESO_TO  set COD_ESTADO=:b0 where ((COD_CL\
IENTE=:b1 and ID_HILO=:b2) and COD_ESTADO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )643;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhEPR;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&idhInsTrabajo;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhPND;
  sqlstm.sqhstl[3] = (unsigned long )4;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo, &pfLog, "Error en UPDATE EPR CO_CLIEPROCESO_TO => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			/* EXEC SQL ROLLBACK; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 6;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )674;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			break;
		}

		/****************************************************************/
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* Recupera TIP_MOROSO del Cliente */
		/* EXEC SQL
		SELECT TIP_MOROSO
		INTO   :szTipMoroso
		FROM   CO_MOROSOS
		WHERE  COD_CLIENTE = :lhCod_cliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select TIP_MOROSO into :b0  from CO_MOROSOS where COD_CLIEN\
TE=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )689;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szTipMoroso;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			memset(szDescError,'\0',sizeof(szDescError));
			sprintf (szDescError, "Error SELECT TIP_MOROSO => [%s].", sqlca.sqlerrm.sqlerrmc );
			ifnTrazaHilos( modulo,&pfLog, "Error SELECT TIP_MOROSO => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			thr_exit((void *)2);	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
			/*thr_exit(NULL);*/
		}

		if( sqlca.sqlcode == SQLNOTFOUND ) {

			ifnTrazaHilos( modulo,&pfLog, "Cliente:[%d] no esta en CO_MOROSOS. Se eliminan Acciones del cliente.", LOG03, lhCod_cliente);
		   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		   /* EXEC SQL
		   DELETE CO_ACCIONES
		   WHERE  COD_CLIENTE = :lhCod_cliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 6;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "delete  from CO_ACCIONES  where COD_CLIENTE=:b0";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )712;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_cliente;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		   if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
		      ifnTrazaHilos( modulo,&pfLog ,"Error al eliminar Acciones del cliente => [%ld] en la CO_MOROSOS.", LOG00, sqlca.sqlerrm.sqlerrmc ,lhCod_cliente);
			  thr_exit((void *)2);	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
			  /*thr_exit(NULL);*/
		   }

			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 6;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )731;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			ifnTrazaHilos( modulo,&pfLog, "Caliente [%ld] eliminado de Co_acciones.\n",LOG03,lhCod_cliente);

		} else
			ifnTrazaHilos( modulo,&pfLog, "Cliente [%ld] aun es moroso [%s].\n",LOG03,lhCod_cliente,szTipMoroso);


	  ifnTrazaHilos( modulo, &pfLog, "\n\t<<<<<<<<<========= Cliente  [%ld] =========>>>>>>>>", LOG05, lhCod_cliente );
		/* recuperamos los clientes que tienen acciones pendientes */
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		DECLARE curAccionesCliente CURSOR FOR
		SELECT /o+ index (A, PK_CO_ACCIONES) o/
				A.NUM_SECUENCIA, A.COD_RUTINA
		FROM   CO_RUTINAS R, CO_ACCIONES A
		WHERE  R.COD_RUTINA = A.COD_RUTINA
		AND    COD_ESTADO  = :szhPND
		AND    FEC_EJECPROG < SYSDATE
		AND    A.COD_CLIENTE = :lhCod_cliente
		ORDER  BY R.NIV_PRIORIDAD DESC, A.FEC_EJECPROG, A.NUM_SECUENCIA; */ 


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo, &pfLog, "Error DECLARE curAccionesCliente => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			thr_exit((void *)2);	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
			/*thr_exit(NULL);*/
		}

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL
		OPEN curAccionesCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0029;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )746;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhPND;
  sqlstm.sqhstl[0] = (unsigned long )4;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo, &pfLog, "Error OPEN curAccionesCliente => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			thr_exit((void *)2);	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
			/*thr_exit(NULL);*/
		}

		bSalir=FALSE;
		while (!bSalir)
		{
			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			/* EXEC SQL
			FETCH curAccionesCliente
			INTO  :lahNumSeq, :szahCodAcc ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 6;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )100;
   sqlstm.offset = (unsigned int  )769;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)lahNumSeq;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )sizeof(long);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szahCodAcc;
   sqlstm.sqhstl[1] = (unsigned long )6;
   sqlstm.sqhsts[1] = (         int  )6;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
				ifnTrazaHilos( modulo, &pfLog, "Error FETCH curAccionesCliente => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
				iError = -1;
				break;
			}

			if( sqlca.sqlcode == SQLNOTFOUND )	{
				ifnTrazaHilos( modulo, &pfLog, "Termino de Datos Fetch curAccionesCliente.", LOG03 );
				bSalir=TRUE;
			}

			lRowsCiclo = sqlca.sqlerrd[2];
			ifnTrazaHilos( modulo, &pfLog, "lRowsCiclo [%ld]", LOG05, lRowsCiclo);
			/*========================================================*/
			/* Recorremos acciones para para procesarlas una a una    */
			for( j = 0; j < lRowsCiclo; j++ )
			{
				iAccionEjecutada=0;
				ifnTrazaHilos( modulo,&pfLog, "=====> ACCION  =====> [%s]  j[%d]", LOG05, szahCodAcc[j], j);
				ifnTrazaHilos( modulo,&pfLog, "lahNumSeq  [%ld] - szahCodAcc  [%s]",LOG07,lahNumSeq[j],szahCodAcc[j]);
				iEsInmune=FALSE;

				/*========================================================*/
				/* Verificamos si el cliente es inmune a la accion        */
				/* EXEC SQL
				SELECT COUNT(*)
				INTO   :ihFlgInmune
				FROM   CO_INMUNES
				WHERE  COD_CLIENTE = :lhCod_cliente
				AND    COD_ACCION  = RTRIM(:szahCodAcc[j])
				AND    NVL(FEC_HASTA,SYSDATE) >= TRUNC(SYSDATE); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(*)  into :b0  from CO_INMUNES where ((COD_CL\
IENTE=:b1 and COD_ACCION=RTRIM(:b2)) and NVL(FEC_HASTA,SYSDATE)>=TRUNC(SYSDATE\
))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )792;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihFlgInmune;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szahCodAcc[j];
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* inmunidad con tope de fecha */

				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
					ifnTrazaHilos( modulo,&pfLog, "Error SELECT CO_INMUNES => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					iEsInmune = TRUE;/* Solo para que siga ejecutando una nueva accion */

				}

				if (ihFlgInmune) {
					lhContInmu++;
					ifnTrazaHilos( modulo,&pfLog, "Cliente es Inmune no se aplica ACCION.\n", LOG03);
				}
				else
					ifnTrazaHilos( modulo,&pfLog, "Cliente NO es Inmune...bien\n", LOG03);

				if (ihFlgInmune > 0)
				{
					/* Cliente es INMUNE a la accion por lo tanto se marca como INM en co_acciones */
					strcpy( szhEstado, "INM" );
					iEsInmune = TRUE;
				}
				else
				{
					/* Cliente no es inmune a la accion por lo tanto se procesa. EPR en co_acciones */
					strcpy(szhEstado,"EPR");
				}

				/*******************************************/
				sqlca.sqlcode=0;
		    	/* EXEC SQL
		    	UPDATE CO_ACCIONES SET
		    	       COD_ESTADO  = :szhEstado,
		           	 FEC_ESTADO  = SYSDATE,
			   		 CNT_ABOCELU = :ihValor_cero,
			   		 CNT_ABOBEEP = :ihValor_cero
		    	WHERE COD_CLIENTE  = :lhCod_cliente
		    	AND NUM_SECUENCIA  = :lahNumSeq[j]; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 6;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update CO_ACCIONES  set COD_ESTADO=:b0,FEC_ESTADO=SYSD\
ATE,CNT_ABOCELU=:b1,CNT_ABOBEEP=:b1 where (COD_CLIENTE=:b3 and NUM_SECUENCIA=:\
b4)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )819;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
       sqlstm.sqhstl[0] = (unsigned long )4;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
       sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
       sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
       sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)&lahNumSeq[j];
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
       sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
					ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCIONES INM-EPR [%ld] * [%ld] - %s",LOG00,lhCod_cliente,lahNumSeq[j],sqlca.sqlerrm.sqlerrmc);
					iEsInmune = TRUE;/* Solo para que siga ejecutando una nueva accion */
				}
				else if( sqlca.sqlcode == SQLNOTFOUND ) {
					ifnTrazaHilos( modulo,&pfLog, "(1.-) No encontro CO_ACCIONES [%ld] [%ld] [%s].",LOG03,lhCod_cliente,lahNumSeq[j],szhEstado);
					iEsInmune = TRUE;/* Solo para que siga ejecutando una nueva accion */
				}
				/*******************************************/

			   sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			   /* comitt a transaccion en co_acciones */
				/* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )854;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
					ifnTrazaHilos( modulo, &pfLog, "Error en COMMIT ESTADO ACCION => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
					iEsInmune = TRUE; /*Solo para que siga ejecutando una nueva accion */
				}


				/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
		   		sema_wait(&semaflock);
				/* No es inmune se procesa la accion */
				if (!iEsInmune)
				{
					/* XO-200508200408 Soporte RyC 26-08-2005 capc*/
					if( !bfnGetSaldoVencidoCXX( &pfLog,lhCod_cliente, &dhDeuVencida, CXX ) ) /* Requerimiento de Soporte - #39107 30-03-2007 capc */
						{
							/*ihFlgError = 1; *NoMail*/
							break; /* aborta ciclo anormal */
						}

					ifnTrazaHilos( modulo,&pfLog,"Cliente => [%d] Deuda Vencida => [%.0f] .", LOG03,lhCod_cliente, dhDeuVencida);

					/*==========================================================*/
					/* Ejecuta la accion del cliente                            */
	            for( i = 0; i < MAXACC ; i++ )							/* recorre la lista de acciones */
	            {
						iAboCeluGlobal = 0  ; iAboBeepGlobal = 0;
						iMRAboCeluGlobal = 0; iMRAboBeepGlobal = 0;
						/*Inicio HM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia CH-200412272562  03-01-2005 Soporte RyC PRM*/
						iNumSeqGlobal = lahNumSeq[j];

						/*Fin*/

	            	if( !strcmp( stAccion[i].szCodigo, szahCodAcc[j] ) )	/* verifica que accion es pertinente */
	              	{

							ifnTrazaHilos( modulo,&pfLog,"Número de secuecia de acción a ejecutar [%ld]", LOG05,iNumSeqGlobal);  /* Requerimiento de Soporte - #39107 30-03-2007 capc */
							ifnTrazaHilos( modulo,&pfLog, "Ejecutando accion [%s]\n", LOG05, szahCodAcc[j]);
					   		pszRet = (* stAccion[i].szNombre)(&pfLog, lhCod_cliente, CXX);    /*ejecuta la accion */
							ifnTrazaHilos( modulo,&pfLog,"Cliente [%ld] ",LOG05,lhCod_cliente);

							memset(szhRet,'\0',sizeof(szhRet));
							sprintf(szhRet,"%s\0",pszRet);
							iAccionEjecutada=1;
							ifnTrazaHilos( modulo,&pfLog, "Resultado de la accion [%s]\n", LOG05, szhRet );
							break;/* para que no siga buscando más acciones que ejecutar */
						} /* endif comparacion accion */
					} /* end for lista de acciones */

					/* No se ejecuto accion alguna */
					if (iAccionEjecutada==0)
					{
						ifnTrazaHilos( modulo,&pfLog,"No Encontro la Accion [%s] en la lista , NO EJECUTO NADA ",LOG01,szahCodAcc[j]);
						strcpy(szhRet,"ERR");
					}

					/* Ejecucion fue correcta */
					if (strcmp(szhRet,"OK")== 0)
					{
						strcpy(szhEstado,"EJE");
						ihAboCeluGlobal=iAboCeluGlobal;
						ihAboBeepGlobal=iAboBeepGlobal;
						/*******************************************/
						sqlca.sqlcode=0;
				    	/* EXEC SQL
				    	UPDATE CO_ACCIONES SET
				    	       COD_ESTADO    = :szhEstado,
				           	   FEC_ESTADO    = SYSDATE,
					   		   CNT_ABOCELU	= :ihAboCeluGlobal,
					   		   CNT_ABOBEEP	= :ihAboBeepGlobal
				    	WHERE  COD_CLIENTE   = :lhCod_cliente
				    	AND    NUM_SECUENCIA = :lahNumSeq[j]; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 6;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "update CO_ACCIONES  set COD_ESTADO=:b0,FEC_ESTADO=SY\
SDATE,CNT_ABOCELU=:b1,CNT_ABOBEEP=:b2 where (COD_CLIENTE=:b3 and NUM_SECUENCIA\
=:b4)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )869;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
         sqlstm.sqhstl[0] = (unsigned long )4;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&ihAboCeluGlobal;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&ihAboBeepGlobal;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lahNumSeq[j];
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
         sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



						if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
							ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCIONES EJE [%ld] * [%ld] - %s",LOG00,lhCod_cliente,lahNumSeq[j],sqlca.sqlerrm.sqlerrmc);
							/*break; */
						}
						else
						{
							/* Solamente si hay abonados afectados por la accion, se actualiza la gestion del cliente */
							if( iAboCeluGlobal > 0 || iAboBeepGlobal > 0 )	{

								if( !bfnFindNewCodGestionContex( &pfLog, lhCod_cliente, 0, CXX ))	 {
									ifnTrazaHilos( modulo,&pfLog, "Fallo al actualizar el estado del cliente '%ld' en las Tablas GA_ABOCEL y GA_ABOBEEP tras la accion %ld (%s)", LOG01, lhCod_cliente,lahNumSeq[j],szahCodAcc[j]);
									memset(szDescError,'\0',sizeof(szDescError));
									sprintf(szDescError,"Fallo al actualizar el estado del cliente '%ld' en las Tablas GA_ABOCEL y GA_ABOBEEP tras la accion %ld (%s)",lhCod_cliente,lahNumSeq[j],szahCodAcc[j]);
								}
							}

							/*========================================================*/
							/* XO-200508200408 Soporte RyC 24-08-2005 capc*/
							/* Verificamos si Accion es Reversa        */
							sqlca.sqlcode=0;
							/* EXEC SQL
							SELECT TIP_RUTINA
							INTO   :szhTipRutina
							FROM   CO_RUTINAS
							WHERE  COD_RUTINA = :szahCodAcc[j]; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 6;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select TIP_RUTINA into :b0  from CO_RUTINAS where COD_\
RUTINA=:b1";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )904;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhTipRutina;
       sqlstm.sqhstl[0] = (unsigned long )2;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szahCodAcc[j];
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
       sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



							if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
								ifnTrazaHilos( modulo,&pfLog, "Error SELECT CO_RUTINAS 1 => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
							}

							if (strcmp(szhTipRutina, "R") == 0)	{
								bEsAccionReversa=1;
							}
							ifnTrazaHilos( modulo,&pfLog,"Tip_Rutina [%s] ",LOG05,szhTipRutina); /* XO-200508200408 Soporte RyC 24-08-2005 capc*/
							/*========================================================================================*/
							/* si es una accion reversa */
							if( bEsAccionReversa == 1) { /* XO-200508200408 Soporte RyC 24-08-2005 capc*/
								/* si no tiene deuda vencida o tiene cambio de categoria */
								if( dhDeuVencida <= 0 || strcmp(szTipMoroso,"C")==0 ) {
									/* verificamos si el cliente debe pasar a historicos y si es asi lo pasamos */
									ifnTrazaHilos( modulo,&pfLog,"Pasando a historico cliente [%ld] ",LOG05,lhCod_cliente);
									if( !bfnPasoHistoricoGeneralContex( &pfLog, lhCod_cliente, 0, CXX ) ) break;
								}
								if( dhDeuVencida > 0) {
									ifnTrazaHilos( modulo,&pfLog,"Cliente => [%d] No pasa a Historico Deuda Vencida es mayor a 0=> [%.0f] .", LOG03,lhCod_cliente, dhDeuVencida);
								  }

							}
							/*========================================================================================*/
						}
						lhContOk++;/* acciones ok*/

						/* XO-200508280499 RVC  */
						/* Se elimina la accion si es que existe en CO_ACCERR cuando ha cambiado a estado EJE */
						sqlca.sqlcode = 0;
						/* EXEC SQL
						DELETE FROM CO_ACCERR
						WHERE  NUM_SECUENCIA = :lahNumSeq[j]; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 6;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "delete  from CO_ACCERR  where NUM_SECUENCIA=:b0";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )927;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lahNumSeq[j];
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
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


						if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
							ifnTrazaHilos( modulo,&pfLog, "Error DELETE CO_ACCERR => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
						}

					} else { /* if (strcmp(szhRet,"OK")== 0) */

						/* EXEC SQL ROLLBACK; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 6;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )946;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


						if (strcmp(szhRet,"PND")== 0)
							strcpy(szhEstado,"PND");
					   	else
					   		strcpy(szhEstado,"ERR");

						/*******************************************/
						sqlca.sqlcode=0;
				    	/* EXEC SQL
				    	UPDATE CO_ACCIONES SET
				    	       COD_ESTADO    = :szhEstado,
				           	 FEC_ESTADO    = SYSDATE,
					   		 CNT_ABOCELU	= :ihValor_cero,
					   		 CNT_ABOBEEP	= :ihValor_cero
				    	WHERE  COD_CLIENTE   = :lhCod_cliente
				    	AND    NUM_SECUENCIA = :lahNumSeq[j]; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 6;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "update CO_ACCIONES  set COD_ESTADO=:b0,FEC_ESTADO=SY\
SDATE,CNT_ABOCELU=:b1,CNT_ABOBEEP=:b1 where (COD_CLIENTE=:b3 and NUM_SECUENCIA\
=:b4)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )961;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
         sqlstm.sqhstl[0] = (unsigned long )4;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_cliente;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lahNumSeq[j];
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
         sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



						if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
							ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCIONES PND [%ld] * [%ld] - %s",LOG00,lhCod_cliente,lahNumSeq[j],sqlca.sqlerrm.sqlerrmc);
							/*break; */
						}
						else
						{

							if (strcmp(szhEstado,"PND")== 0) {

				            memset(szhFecTentativa,'\0',sizeof(szhFecTentativa));
				            memset(szhFecDefinitiva,'\0',sizeof(szhFecDefinitiva));

				            /* EXEC SQL
				            SELECT TO_CHAR( SYSDATE + ( C.NUM_DELTAHORAS / ( :iNumVeinticuatro * :iNumSesenta ) ), :szhYYYYMMDDHH24MISS )
				            INTO   :szhFecTentativa
				            FROM   CO_ACCIONES CO, CO_COLASPROC C
				            WHERE  C.COD_PROCESO   =  :szhProceso
				            AND    CO.COD_CLIENTE   = :lhCod_cliente
				            AND    CO.NUM_SECUENCIA = :lahNumSeq[j]; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select TO_CHAR((SYSDATE+(C.NUM_DELTAHORAS/(:b\
0* :b1))),:b2) into :b3  from CO_ACCIONES CO ,CO_COLASPROC C where ((C.COD_PRO\
CESO=:b4 and CO.COD_CLIENTE=:b5) and CO.NUM_SECUENCIA=:b6)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )996;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&iNumVeinticuatro;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&iNumSesenta;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDDHH24MISS;
                sqlstm.sqhstl[2] = (unsigned long )17;
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhFecTentativa;
                sqlstm.sqhstl[3] = (unsigned long )15;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhProceso;
                sqlstm.sqhstl[4] = (unsigned long )5;
                sqlstm.sqhsts[4] = (         int  )0;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)&lhCod_cliente;
                sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[5] = (         int  )0;
                sqlstm.sqindv[5] = (         short *)0;
                sqlstm.sqinds[5] = (         int  )0;
                sqlstm.sqharm[5] = (unsigned long )0;
                sqlstm.sqadto[5] = (unsigned short )0;
                sqlstm.sqtdso[5] = (unsigned short )0;
                sqlstm.sqhstv[6] = (unsigned char  *)&lahNumSeq[j];
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
                sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



								if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
								{
								    ifnTrazaHilos( modulo,&pfLog, "Select from CO_ACCIONES [%ld][%ld][%s] %s",LOG00,lhCod_cliente,lahNumSeq[j],szhEstado,SQLERRM);
								    thr_exit((void *)2);	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
								    /*thr_exit(NULL);*/
								}
								else if( SQLCODE == SQLNOTFOUND )
								{
								   ifnTrazaHilos( modulo,&pfLog, "No encontro CO_ACCIONES [%ld][%ld][%s].",LOG00,lhCod_cliente,lahNumSeq[j],szhEstado);

								} else {

									strncpy(szhFecDefinitiva,szhFecTentativa,8); /* 'YYYYMMDD' */

									if (ifnDetFechaEjecucionContex(&pfLog, szahCodAcc[j], szhFecDefinitiva, CXX)!=0) /* fmto: YYYYMMDD */
									{
									    ifnTrazaHilos( modulo,&pfLog, "al obtener fecha definitiva para la accion %ld '%s' (Cliente:%ld): %s",LOG00, lahNumSeq[j], szahCodAcc[j], lhCod_cliente, SQLERRM);
									}
									else
									{
									   if ( strncmp(szhFecDefinitiva,szhFecTentativa,8) == 0 ) /* SI DIO EL MISMO DIA DE HOY COMO FEC_DEFINITIVA */
									   {
									        strcpy(szhFecDefinitiva,szhFecTentativa); /* 'YYYYMMDDHH24MISS' */
									   }
									   else
									   {
									        szhFecDefinitiva[8]='\0'; /* YYYYMMDD\0 */
									        strcat(szhFecDefinitiva,"000000"); /* YYYYMMDDHH24MISS */
									   }
									   szhFecDefinitiva[14]='\0';

										/* EXEC SQL
										UPDATE CO_ACCIONES
										SET    FEC_EJECPROG  = TO_DATE(:szhFecDefinitiva,:szhYYYYMMDDHH24MISS)
										WHERE  COD_CLIENTE   = :lhCod_cliente
										AND    NUM_SECUENCIA = :lahNumSeq[j] ; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 7;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "update CO_ACCIONES  set FEC_EJECPROG=TO_DATE(:b0,:b\
1) where (COD_CLIENTE=:b2 and NUM_SECUENCIA=:b3)";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )1039;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)szhFecDefinitiva;
          sqlstm.sqhstl[0] = (unsigned long )15;
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDDHH24MISS;
          sqlstm.sqhstl[1] = (unsigned long )17;
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_cliente;
          sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[2] = (         int  )0;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)&lahNumSeq[j];
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
          sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



										if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
										{
										    ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCIONES 2 [%ld][%ld][%s] %s",LOG00,lhCod_cliente,lahNumSeq[j],szhEstado,SQLERRM);
										    thr_exit((void *)2);	/* Requerimiento de Soporte - #71598 17-10-2008 mgg */
										    /*thr_exit(NULL);*/
										}
										else if( SQLCODE == SQLNOTFOUND )
										{
										 ifnTrazaHilos( modulo,&pfLog, "No encontro CO_ACCIONES [%ld][%ld][%s].",LOG00,lhCod_cliente,lahNumSeq[j],szhEstado);

										}
									}
								}

							}

							sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
							ifnTrazaHilos( modulo,&pfLog, "Insert con lhNumSeq [%ld] , szhEstado [%s]", LOG05, lahNumSeq[j], szhEstado);
							/* EXEC SQL
							INSERT INTO CO_ACCERR
									 (NUM_SECUENCIA, COD_ERROR      )
							VALUES (:lahNumSeq[j], RTRIM(:szhEstado) ); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 7;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "insert into CO_ACCERR (NUM_SECUENCIA,COD_ERROR) values\
 (:b0,RTRIM(:b1))";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )1070;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lahNumSeq[j];
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhEstado;
       sqlstm.sqhstl[1] = (unsigned long )4;
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
       sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



							if ( sqlca.sqlcode != SQLOK ) {

								sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
								ifnTrazaHilos( modulo,&pfLog, "Update CO_ACCERR con lahNumSeq[j] [%ld] , szhEstado [%s]", LOG05, lahNumSeq[j], szhEstado);
								/* EXEC SQL
								UPDATE CO_ACCERR SET
										 COD_ERROR     = RTRIM(:szhEstado)
								WHERE  NUM_SECUENCIA = :lahNumSeq[j]; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CO_ACCERR  set COD_ERROR=RTRIM(:b0) where NUM_\
SECUENCIA=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1093;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
        sqlstm.sqhstl[0] = (unsigned long )4;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lahNumSeq[j];
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
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



								if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
									ifnTrazaHilos( modulo,&pfLog,"***** UPDATE CO_ACCERR 1 %s",LOG00,sqlca.sqlerrm.sqlerrmc);
								}
							}
						}/* if - else */
						lhContPnd++;/* accione pendientes */

					} /* if (strcmp(szhRet,"OK")== 0) */

				}/* if (!iEsInmune)  */
				sema_post(&semaflock);
				/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/

			} /*for( j = 0; j < lRowsCiclo; j++ )*/
		} /* while (1) */

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* cerramos el cursor de clientes */
		/* EXEC SQL CLOSE curAccionesCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1116;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo, &pfLog, "Error CLOSE curAccionesCliente => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			iError = -1;
		}

		/****************************************************************/

		/* EXEC SQL
		DELETE FROM CO_CLIEPROCESO_TO
		 WHERE COD_CLIENTE = :lhCod_cliente
		   AND ID_HILO = :idhInsTrabajo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "delete  from CO_CLIEPROCESO_TO  where (COD_CLIENTE=:b0 and \
ID_HILO=:b1)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1131;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_cliente;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&idhInsTrabajo;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo, &pfLog, "Error en UPDATE EPR CO_CLIEPROCESO_TO => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			/* EXEC SQL ROLLBACK; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1154;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			break;
		}

		sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
		/* EXEC SQL COMMIT; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1169;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {
			ifnTrazaHilos( modulo, &pfLog, "Error en COMMIT => [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
			/* EXEC SQL ROLLBACK; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1184;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			break;
		}


		pListaAux = pListaAux->sig;
	}/* while (pListaAux != NULL)  */

	ifnTrazaHilos( modulo, &pfLog, "\n\tActualizar Hijo en CO_ESTADISEVA_TO.   (idhInsTrabajo :[%d])", LOG03,idhInsTrabajo);
	/**********************************************************************************************/

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
	/* EXEC SQL
	SELECT NVL(SUM(CNT_CLIENTES_PROC),0)
	INTO   :ihCountHilo
	FROM   CO_ESTADISEVA_TO
	WHERE  COD_PROCESO = :szhProceso
	AND    SECUENCIA   = :idhInsTrabajo
	AND    TRUNC(FEC_INGRESO) = TRUNC(SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum(CNT_CLIENTES_PROC),0) into :b0  from CO_ESTAD\
ISEVA_TO where ((COD_PROCESO=:b1 and SECUENCIA=:b2) and TRUNC(FEC_INGRESO)=TRU\
NC(SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1199;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCountHilo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhProceso;
 sqlstm.sqhstl[1] = (unsigned long )5;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&idhInsTrabajo;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{
		ifnTrazaHilos( modulo, &pfLog, "SELECT count(*) CO_ESTADISEVA_TO idhInsTrabajo [%d] - %s.", LOG00, idhInsTrabajo, sqlca.sqlerrm.sqlerrmc );

	} else if (sqlca.sqlcode == SQLNOTFOUND)  {
		ifnTrazaHilos( modulo, &pfLog, "Registro deberia existir..!!.", LOG02);

	} else  {

		ifnTrazaHilos( modulo, &pfLog, "\tihCountHilo  [%d]   iTot_Clies[idhInsTrabajo] [%d]", LOG03,ihCountHilo,iTot_Clies[idhInsTrabajo]);
		if (ihCountHilo < iTot_Clies[idhInsTrabajo]) {

			/* EXEC SQL EXECUTE
				BEGIN
					:szFinHilo := TO_CHAR(SYSDATE,:szhHH24MISS);
				END;
			END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin :szFinHilo := TO_CHAR ( SYSDATE , :szhHH24MISS ) ; E\
ND ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1226;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szFinHilo;
   sqlstm.sqhstl[0] = (unsigned long )9;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhHH24MISS;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			iDiffSeg = ifnRestaHoras( szIniHilo, szFinHilo, szTmpHilo );
			ifnTrazaHilos( modulo, &pfLog, "Actualizar CO_ESTADISEVA_TO con :\n\t\tiDiffSeg  [%d]\n\t\tszIniHilo [%s]\n\t\tszFinHilo [%s]", LOG03,iDiffSeg,szIniHilo,szFinHilo);

			/* actualizando estadisticas del proceso hijo. Secuencia corresponde a la del thread */
			sqlca.sqlcode=0; /* se resetea la vble sql para evitar un posible brain damage*/
			ifnTrazaHilos( modulo, &pfLog, "\tiTot_Clies   [%d]\n\t\tszhProceso   [%s]\n\t\tidhInsTrabajo[%d]", LOG03,iTot_Clies[idhInsTrabajo],szhProceso,idhInsTrabajo);
			/* EXEC SQL
			UPDATE CO_ESTADISEVA_TO
			   SET TIEMPO_PROCESO    = :iDiffSeg ,
			       CNT_CLIENTES_PROC = :iTot_Clies[idhInsTrabajo],
			       FEC_INGRESO       = SYSDATE
			 WHERE COD_PROCESO       = :szhProceso
			   AND SECUENCIA         = :idhInsTrabajo
			   AND TRUNC(FEC_INGRESO)= TRUNC(SYSDATE); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_ESTADISEVA_TO  set TIEMPO_PROCESO=:b0,CNT_CLIENT\
ES_PROC=:b1,FEC_INGRESO=SYSDATE where ((COD_PROCESO=:b2 and SECUENCIA=:b3) and\
 TRUNC(FEC_INGRESO)=TRUNC(SYSDATE))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1249;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&iDiffSeg;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&iTot_Clies[idhInsTrabajo];
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhProceso;
   sqlstm.sqhstl[2] = (unsigned long )5;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&idhInsTrabajo;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
			{
			   ifnTrazaHilos( modulo, &pfLog, "Error al actualizar estadistica del Hilo [%d]", LOG03,idhInsTrabajo );
			}
			/* EXEC SQL COMMIT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1280;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		}
	}
	/**********************************************************************************************/
	iTot_Clies[idhInsTrabajo]=0;

	ifnTrazaHilos( modulo, &pfLog, "\n\t*** FIN ARCHIVO LOG DE EJECUTOR HIJO ***\n\n", LOG03 );
	vfnCierraArchivoLogHil(&pfLog);
	thr_exit(NULL);

}/* fin vProcesaAccionesCliente */

/* Requerimiento de Soporte - #39107 30-03-2007 capc */
BOOL bfnGetSaldoVencidoCXX(FILE **ptArchLog, long lCodCliente, double *pdSaldoVenc, sql_context ctxCont  )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long   lhCodCliente;
	double dhSaldoVenc  = 0.0;
	char   szhCARTERA    [11];
	char   szhTIPDOCUM   [13];
	int    ihValor_uno  = 1  ;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "bfnGetSaldoVencidoCXX";
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo : [%s].", LOG05, modulo );
	lhCodCliente = lCodCliente;
	strcpy(szhCARTERA ,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT NVL( SUM( IMPORTE_DEBE - IMPORTE_HABER ), 0 )
	INTO  :dhSaldoVenc
	FROM  CO_CARTERA
	WHERE COD_CLIENTE = :lhCodCliente
	AND   IND_FACTURADO = :ihValor_uno
	AND   FEC_VENCIMIE < TRUNC( SYSDATE )
	AND   COD_TIPDOCUM NOT IN (SELECT	TO_NUMBER(COD_VALOR)
								      FROM	CO_CODIGOS
								      WHERE	NOM_TABLA = :szhCARTERA
								      AND NOM_COLUMNA = :szhTIPDOCUM); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),0) into :b0  fr\
om CO_CARTERA where (((COD_CLIENTE=:b1 and IND_FACTURADO=:b2) and FEC_VENCIMIE\
<TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from C\
O_CODIGOS where (NOM_TABLA=:b3 and NOM_COLUMNA=:b4)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1295;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhSaldoVenc;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[4] = (unsigned long )13;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
        ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld] Obteniendo Saldo Vencido => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
        return FALSE;
   }

	*pdSaldoVenc = dhSaldoVenc;
   return TRUE;
} /* bfnGetSaldoVencidoCXX */

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

