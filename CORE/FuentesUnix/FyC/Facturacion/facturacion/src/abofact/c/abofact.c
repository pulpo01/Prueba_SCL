
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
    "./pc/abofact.pc"
};


static unsigned int sqlctx = 1720715;


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
   unsigned char  *sqhstv[21];
   unsigned long  sqhstl[21];
            int   sqhsts[21];
            short *sqindv[21];
            int   sqinds[21];
   unsigned long  sqharm[21];
   unsigned long  *sqharc[21];
   unsigned short  sqadto[21];
   unsigned short  sqtdso[21];
} sqlstm = {12,21};

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

 static char *sq0004 = 
"select A.COD_CLIENTE ,A.NUM_ABONADO ,A.COD_CICLFACT ,TO_CHAR(A.FEC_ALTA,'YYY\
YMMDDHH24MISS') ,TO_CHAR(A.FEC_BAJA,'YYYYMMDDHH24MISS') ,A.NUM_CELULAR ,A.IND_\
ACTUAC ,TO_CHAR(A.FEC_FINCONTRA,'YYYYMMDDHH24MISS') ,A.IND_ALTA ,A.IND_DETALLE\
 ,A.IND_FACTUR ,A.IND_CUOTAS ,A.IND_ARRIENDO ,A.IND_CARGOS ,A.IND_PENALIZA ,A.\
IND_SUPERTEL ,A.NUM_TELEFIJA ,A.COD_SUPERTEL ,A.IND_CARGOPRO ,A.IND_CUENCONTRO\
LADA ,A.IND_BLOQUEO  from GA_INFACCEL A where (((((A.COD_CLIENTE>:b0 and A.NUM\
_ABONADO>=:b1) and A.COD_CICLFACT=:b2) and A.IND_ACTUAC in (:b3,:b4,:b5)) and \
A.NUM_ABONADO not  in (select B.NUM_ABONADO  from GA_INFACCEL B where ((A.COD_\
CLIENTE=B.COD_CLIENTE and A.NUM_ABONADO=B.NUM_ABONADO) and B.COD_CICLFACT=:b6)\
)) and ROWNUM<=:b7) order by A.COD_CLIENTE,A.NUM_ABONADO            ";

 static char *sq0005 = 
"select A.COD_CLIENTE ,A.NUM_ABONADO ,A.COD_CICLFACT ,TO_CHAR(A.FEC_ALTA,'YYY\
YMMDDHH24MISS') ,TO_CHAR(A.FEC_BAJA,'YYYYMMDDHH24MISS') ,A.NUM_BEEPER ,A.IND_A\
CTUAC ,TO_CHAR(A.FEC_FINCONTRA,'YYYYMMDDHH24MISS') ,A.IND_ALTA ,A.IND_DETALLE \
,A.IND_FACTUR ,A.IND_CUOTAS ,A.IND_ARRIENDO ,A.IND_CARGOS ,A.IND_PENALIZA ,A.I\
ND_CARGOPRO ,A.IND_CUENCONTROLADA ,A.IND_BLOQUEO  from GA_INFACBEEP A where ((\
(((A.COD_CLIENTE>:b0 and A.NUM_ABONADO>=:b1) and A.COD_CICLFACT=:b2) and A.IND\
_ACTUAC in (:b3,:b4,:b5)) and A.COD_CLIENTE not  in (select B.COD_CLIENTE  fro\
m GA_INFACBEEP B where ((A.COD_CLIENTE=B.COD_CLIENTE and A.NUM_ABONADO=B.NUM_A\
BONADO) and B.COD_CICLFACT=:b6))) and ROWNUM<=:b7) order by A.COD_CLIENTE,A.NU\
M_ABONADO            ";

 static char *sq0011 = 
"select NUM_CARGO  from GE_CARGOS where (COD_CLIENTE=:b0 and NUM_FACTURA=0)  \
         ";

 static char *sq0012 = 
"select IND_PAGADA  from FA_CABCUOTAS where ((COD_CLIENTE=:b0 and COD_PRODUCT\
O=:b1) and NUM_ABONADO=:b2)           ";

 static char *sq0013 = 
"select TO_CHAR(FEC_DESDE,'YYYYMMDD HH24:MI:SS') ,TO_CHAR(FEC_HASTA,'YYYYMMDD\
 HH24:MI:SS')  from FA_ARRIENDO where ((COD_CLIENTE=:b0 and COD_PRODUCTO=:b1) \
and NUM_ABONADO=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,107,0,4,380,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,
32,0,0,2,191,0,4,403,0,0,4,2,0,1,0,2,3,0,0,2,97,0,0,1,5,0,0,1,3,0,0,
63,0,0,3,70,0,4,432,0,0,1,0,0,1,0,2,3,0,0,
82,0,0,4,768,0,9,889,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,
129,0,0,5,721,0,9,928,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,
176,0,0,4,0,0,13,1002,0,0,21,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
275,0,0,5,0,0,13,1028,0,0,18,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,
362,0,0,4,0,0,15,1104,0,0,0,0,0,1,0,
377,0,0,5,0,0,15,1107,0,0,0,0,0,1,0,
392,0,0,6,159,0,4,1180,0,0,6,3,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
431,0,0,7,144,0,4,1236,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
458,0,0,8,103,0,5,1283,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
485,0,0,9,112,0,4,1305,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
516,0,0,10,113,0,4,1344,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
547,0,0,11,85,0,9,1435,0,0,1,1,0,1,0,1,3,0,0,
566,0,0,11,0,0,13,1451,0,0,1,0,0,1,0,2,3,0,0,
585,0,0,11,0,0,15,1480,0,0,0,0,0,1,0,
600,0,0,12,114,0,9,1510,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
627,0,0,12,0,0,13,1526,0,0,1,0,0,1,0,2,3,0,0,
646,0,0,12,0,0,15,1555,0,0,0,0,0,1,0,
661,0,0,13,185,0,9,1586,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
688,0,0,13,0,0,13,1602,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
711,0,0,13,0,0,15,1632,0,0,0,0,0,1,0,
726,0,0,14,165,0,4,1699,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
761,0,0,15,166,0,4,1711,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
796,0,0,16,488,0,3,1783,0,0,21,21,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
895,0,0,17,426,0,3,1830,0,0,18,18,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,
982,0,0,18,120,0,5,2017,0,0,1,1,0,1,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : abofactC.c                                              * */
/* *  Proceso de "Abonados"                                             * */
/* *  Autor : Carlos Arias Leivas                                       * */
/* ********************************************************************** */
/* *  Modificado : 25 de Marzo de 1999                                  * */
/* *               Este proceso se paso a Facturacion el dia 25.03.99   * */
/* *               para ajustar los procesos de facturacion,se cambio   * */
/* *               al makefile, y los programas fuentes eliminado las   * */
/* *               librerias, objetos y funciones relacionadas al modulo* */
/* *               de abonados, en su reemplazo se agregaron funciones  * */
/* *               Facturacion.                                         * */
/* *                                                                    * */
/* * 07/Jun/1999   Paso de unix/src/abofact a facturacion/src/abofact   * */
/* *               (rbr) tarea 1                                        * */
/* *                                                                    * */
/* * 28/Jun/1999   Reorganizacion de Rutinas para Agregar funcionalidad * */
/* *               de replicar Interfaz con Actuacion 2 y 3.            * */
/* * 31/Ago/1999   Agregar funcionalidad de cambios de ciclo en la      * */
/* *               Tabla GE_CLIENTES                                    * */
/* * 20/Dic/1999   Quitar mensaje de registros no replicables por baja  * */
/* *               en archivos de log y de inconsistencias              * */
/* * 26/Abr/2000   Modificar Actualizacion de bloqueo                   * */
/* *               si bloqeo > 1 ==> replico bloqueo = 1                * */
/* *               si no         ==> replicao valor bloqueo             * */
/* *               en archivos de log y de inconsistencias              * */
/* ********************************************************************** */


#define _ABOFACT_C_

#include "abofact.h"

char szUsage[]=
   "\nUso:   abofact -u Usuario/Password    "
   "\n               -c  Ciclo Facturacion  "
   "\n\tOPCIONES:                           "
   "\n\t           -l [LogNivel]            ";


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


/****************************************************************************/
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/

static BOOL bfnReplicaCiclos(long)                  ;
static BOOL bfnCopiaFilasCel (long,long,char*,char*);
static BOOL bfnCopiaFilasBeep(long,long,char*,char*);
static int  ifnOpenInterfaz(int,long,long)          ;
static int  ifnFetchInterfaz(int,GAINTERFACT *,long);
static BOOL bfnCloseInterfaz(int )                  ;
static BOOL SetUpdate(int, GAINTERFACT * , char *)  ;
static BOOL bNumPeriodosBaja(int,GAINTERFACT*,int*) ;
static BOOL bfnInsertInterfaz(int, GAINTERFACT *)   ;
static void vValSTB(GAINTERFACT * )                 ;
static BOOL bfnCambCicloCliente(long)               ;
static void vValCargoPro (GAINTERFACT * )           ;
static void vPrintInconsistencia()                  ;


/*****************************************************************************/
/* main :  modulo principal                                                  */
/*****************************************************************************/
#define DEF_ROWS_FETCH 10000
/* EXEC SQL BEGIN DECLARE SECTION  ; */ 


 int iNumRowsFetch=DEF_ROWS_FETCH;
 int iNumRows=0;
/* EXEC SQL END DECLARE SECTION    ; */ 


int main(int argc, char *argv[])
{
    /****  ANTIGUO   ****/
    int  iCont = 0      ;
    long lhCiclParam    ;

    
    /****  NUEVO   ****/
    extern      char *optarg                ;
    char        opt[]="u:c:l:"              ;
    int         iOpt =0                     ;
    char        szUsuario [63] = ""         ;
    char        *psztmp      = ""           ;
    char        szaux     [10]              ;
    char        *szDirLogs                  ;
    char        szComando[1024] = ""        ;
    BOOL        bOptUsuario = FALSE         ;

    memset(&stEstadisCelu   ,0,sizeof(GAINFACESTADIS));
    memset(&stEstadisBeep   ,0,sizeof(GAINFACESTADIS));
    memset(&stLineaComando  ,0,sizeof(LINEACOMANDO));

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
         switch(iOpt)
         {   case 'u':
                 if (strlen (optarg))
                 {
                    strcpy(szUsuario, optarg);
                    bOptUsuario = TRUE;
                    fprintf (stdout," -u %s ", szUsuario);
                 }
                 break;
             case 'c':
                 if (strlen (optarg))
                 {
                    strcpy(szaux,optarg);
                    stLineaComando.lCodCiclFact = atol(szaux);
                    fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                 }
                 break;
             case 'l':
                 if (strlen (optarg))
                 {
                    stStatus.LogNivel =
                    (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                 }
                 break;
             case 'n':
                 if (strlen (optarg))
                 {
		    iNumRowsFetch=(atoi (optarg) > 0)? atoi (optarg):DEF_ROWS_FETCH;
                    fprintf (stdout,"-n %d ", iNumRowsFetch)     ;
                 }
                 break;                 
         }
    }


    if (stLineaComando.lCodCiclFact == 0)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return 1;
    }

    if (!bOptUsuario)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return  (2);
    }
    else
    {
       if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
             return (3);
       }
       else
       {
             strncpy (stLineaComando.szUser,szUsuario,psztmp-szUsuario);
             strcpy  (stLineaComando.szPass, psztmp+1)                 ;
       }
    }

    if (stStatus.LogNivel <= 0)
       stStatus.LogNivel = iLOGNIVEL_DEF     ;
    stLineaComando.iNivLog = stStatus.LogNivel;
    
    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'abofact  <usuario> <passwd> '\n");
        return (3);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------",
                stLineaComando.szUser);
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))
         return FALSE;
    /*******************************************************************************/
    /* **               Obtiene el path del directorio Log                      ** */
    /*******************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return(FALSE);
    /*******************************************************************************/
    /* **  Crea Directorio de Log para el Ciclo a Procesar                      ** */
    /*******************************************************************************/
    sprintf(stLineaComando.szDirLogs,"%s/abofact/%ld/",szDirLogs,stLineaComando.lCodCiclFact);
    sprintf(szComando, "/usr/bin/mkdir  -p %s",stLineaComando.szDirLogs );
    if (system(szComando))
    {     
        printf( "\n\t*** Fallo mkdir de Directorio Logs : %s \n", szComando);
        return(FALSE);
    }
    /*******************************************************************************/
    /* **  Abre Archivo de Errores                                              ** */
    /*******************************************************************************/
    sprintf(stStatus.ErrName, "%sAboFact_%ld_%s.err",
            stLineaComando.szDirLogs, stLineaComando.lCodCiclFact, szSysDate);

    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de error %s\n", stStatus.ErrName);
        return (4);
    }
    /*******************************************************************************/
    /* **  Abre Archivo de Log                                                  ** */
    /*******************************************************************************/
    sprintf(stStatus.LogName, "%sAboFact_%ld_%s.log",
            stLineaComando.szDirLogs, stLineaComando.lCodCiclFact, szSysDate);

    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de log %s\n", stStatus.LogName);
        fclose(stStatus.ErrFile);
        return (5);
    }
    /*******************************************************************************/
    /* **               Obtiene el path del directorio Dat                      ** */
    /*******************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPFACTUR_DAT")) == (char *)NULL)
        return(FALSE);
    /*******************************************************************************/
    /* **  Crea Directorio de Dat para el Ciclo a Procesar                      ** */
    /*******************************************************************************/
    sprintf(stLineaComando.szDirLogs,"%s/abofact/%ld/",szDirLogs,stLineaComando.lCodCiclFact);
    sprintf(szComando, "/usr/bin/mkdir  -p %s",stLineaComando.szDirLogs );
    if (system(szComando))
    {     
        printf( "\n\t*** Fallo mkdir de Directorio Logs : %s \n", szComando);
        return(FALSE);
    }
    /*******************************************************************************/
    /* **  Abre Archivo de Data                                                 ** */
    /*******************************************************************************/
    sprintf(stLineaComando.InconsName, "%sAboFact_%ld_%s.dat",
            stLineaComando.szDirLogs, stLineaComando.lCodCiclFact, szSysDate);

    if( (stLineaComando.InconsFile=fopen(stLineaComando.InconsName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de inconsistencias %s\n", stLineaComando.InconsName);
        return (4);
    }

    /*************************************************************************/
    
    vDTrazasError(szExeAboFact, "\n\n\t*************************************"
                                 "\n\n\t****     Errores de ABOFACT        **"
                                 "\n\n\t*************************************",
                                  LOG03);

    vDTrazasLog(szExeAboFact, "\n\n\t***************************************"
                                 "\n\n\t****        Log   ABOFACT          **"
                                 "\n\n\t*************************************",
                                  LOG03);

    vDTrazasLog(szExeAboFact,
                            "\n\t\tParametro de Salida abofactC.c ***"
                            "\n\t\t=> Usuario      [%s]"
                            "\n\t\t=> Password     [************]"
                            "\n\t\t=> Cod.CiclFact [%ld]"
                            "\n\t\t=> Niv.Log      [%d]",
                            LOG05,
                            stLineaComando.szUser,
                            stLineaComando.lCodCiclFact,
                            stLineaComando.iNivLog);

    if(!bfnReplicaCiclos(stLineaComando.lCodCiclFact))  
       bfnOraRollBackRelease();
    else 
    {
        if (!bfnOraCommit())
        {
           vDTrazasError(szExeAboFact, "\n\n\tError en Commit de Estadisticas (bfnOraCargaHistDocu)", LOG01);
           return FALSE;
        }
    }

    vDTrazasLog (szExeAboFact,  "\n************************************"
                                "**************************************"
                                "\n\tEstadisticas del Proceso        \n"
                                "\n\t\t => Interfaz Celular                     "
                                "\n\t\t\t ==> Abonados Correctos            [%ld]"
                                "\n\t\t\t ==> Abonados Con Errores          [%ld]"
                                "\n\t\t\t ==> Total Abonados Procesados     [%ld]"
                                "\n\n\t\t\t\t ==> Cambios de Ciclo      [%ld]"
                                "\n\t\t\t\t ==> Bajas No Replicadas   [%ld]"
                                "\n************************************"
                                "**************************************"
                                "\n\t\t => Interfaz Beeper                      "
                                "\n\t\t\t ==> Abonados Correctos            [%ld]"
                                "\n\t\t\t ==> Abonados Con Errores          [%ld]"
                                "\n\t\t\t ==> Total Abonados Procesados     [%ld]"
                                "\n\n\t\t\t\t ==> Cambios de Ciclo      [%ld]"
                                "\n\t\t\t\t ==> Bajas No Replicadas   [%ld]"
                                "\n************************************"
                                "**************************************"
                                ,LOG03
                                ,stEstadisCelu.lCorrectos
                                ,stEstadisCelu.lIncorrectos
                                ,stEstadisCelu.lTotales
                                ,stEstadisCelu.lTotCambCiclo            
                                ,stEstadisCelu.lTotBajas
                                ,stEstadisBeep.lCorrectos
                                ,stEstadisBeep.lIncorrectos
                                ,stEstadisBeep.lTotales
                                ,stEstadisBeep.lTotCambCiclo
                                ,stEstadisBeep.lTotBajas);


    if(!bfnDisconnectORA(0))
    {
     /*No estaba conectado*/
    }
    else
        vDTrazasLog(szExeAboFact,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);

        vDTrazasError(szExeAboFact,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    fclose(stLineaComando.InconsFile);
            
}



/*****************************************************************************/
/* bfnReplicaCiclos :                                                        */
/*****************************************************************************/

static BOOL bfnReplicaCiclos(long lCiclParam)
{

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 


    long lhCiclParam                ;
    long lhCodCiclo                 ;
    long lhCodCiclFact              ;
    long lhCodCiclFactFin           ;

    char szFecActual[15]            ;   /* EXEC SQL VAR szFecActual IS STRING(15); */ 

    char szhFecDesdeLlam[15]        ;   /* EXEC SQL VAR szFecActual IS STRING(15); */ 


    /* EXEC SQL END DECLARE SECTION    ; */ 


    vDTrazasLog(szExeAboFact,"\n\t***  Parametro de Entrada bfnReplicaCiclos  ***"
                             "\n\t\t=> Cod_CiclFact     [%ld]",
                             LOG03,lCiclParam );
    
    lhCiclParam = lCiclParam;

    if (lhCiclParam == 0) 
    {
        vDTrazasError(szExeAboFact, "\n\n\t  Error en COD_CICLFACT = [%ld]", LOG01,lhCiclParam);
        vDTrazasLog  (szExeAboFact, "\n\n\t  Error en COD_CICLFACT = [%ld]", LOG01,lhCiclParam);
        return (FALSE);
    }
    else
    {
        lhCodCiclFact    = lhCiclParam ;    
        lhCodCiclo       = 0           ;
        lhCodCiclFactFin = 0           ;
        
        /*  Se paso como parametro el Ciclo                                   */
        /**********************************************************************/
        /* EXEC SQL SELECT COD_CICLO,
                        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') 
                 INTO   :lhCodCiclo , 
                        :szFecActual
                 FROM FA_CICLFACT WHERE COD_CICLFACT = :lhCiclParam; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_CICLO ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')\
 into :b0,:b1  from FA_CICLFACT where COD_CICLFACT=:b2";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szFecActual;
        sqlstm.sqhstl[1] = (unsigned long )15;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCiclParam;
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



        if(SQLCODE == SQLNOTFOUND)
        {
            vDTrazasError(szExeAboFact, "\n\n\t**  No Existen Datos en COD_CICLFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lhCiclParam);
            vDTrazasLog  (szExeAboFact, "\n\n\t**  No Existen Datos en COD_CICLFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lhCiclParam);
            return (FALSE);
        }
        if(SQLCODE != SQLOK)
        {
            vDTrazasError(szExeAboFact, "\n\n\t**  Error en Select sobre FA_CILCFACT (Cod_CiclFact) **",LOG01,lhCiclParam);
            vDTrazasLog  (szExeAboFact, "\n\n\t**  Error en Select sobre FA_CILCFACT (Cod_CiclFact) **",LOG01,lhCiclParam);
            return (FALSE);
        }

        /*   Selecciona Cod_CiclFact Siguiente para el ciclo a Procesar                                    */
        /**********************************************************************/
        /* EXEC SQL SELECT COD_CICLFACT ,
                        TO_CHAR(FEC_DESDELLAM,'YYYYMMDDHH24MISS')
                 INTO   :lhCodCiclFactFin,
                        :szhFecDesdeLlam
                 FROM   FA_CICLFACT
                 WHERE  to_date(:szFecActual,'YYYYMMDDHH24MISS') BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM
                 AND    COD_CICLO=:lhCodCiclo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_CICLFACT ,TO_CHAR(FEC_DESDELLAM,'YYYYMMDDH\
H24MISS') into :b0,:b1  from FA_CICLFACT where (to_date(:b2,'YYYYMMDDHH24MISS'\
) between FEC_DESDELLAM and FEC_HASTALLAM and COD_CICLO=:b3)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )32;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFactFin;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesdeLlam;
        sqlstm.sqhstl[1] = (unsigned long )15;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szFecActual;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclo;
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



        if(SQLCODE == SQLNOTFOUND)
        {
            vDTrazasError(szExeAboFact, "\n\n\t** No Existen Datos en FA_CICLFACT Para Proximo Ciclo **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Fecha Actual          [%s]"
                                        ,LOG01,lhCodCiclo,szFecActual);
            vDTrazasLog  (szExeAboFact, "\n\n\t** No Existen Datos en FA_CICLFACT Para Proximo Ciclo **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Fecha Actual          [%s]"
                                        ,LOG01,lhCodCiclo,szFecActual);
            return (FALSE);
        }
        if(SQLCODE != SQLOK)
        {
            vDTrazasError(szExeAboFact, "\n\n\t**  Error en Select sobre FA_CILCFACT (Cod_Ciclo) **",LOG01);
            vDTrazasLog  (szExeAboFact, "\n\n\t**  Error en Select sobre FA_CILCFACT (Cod_Ciclo) **",LOG01);
            return (FALSE);
        }
            
        /*   Selecciona Cod_CiclFact Para Ciclo STB (SuperTelefono)                                        */
        /*********************************************************************/
        /* EXEC SQL SELECT     COD_CICLO
                 INTO       :lhCodCicloSTM
                 FROM       GA_CTC_DEFVENTA
                 WHERE      IND_TIPVENTA = 'S'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_CICLO into :b0  from GA_CTC_DEFVENTA where\
 IND_TIPVENTA='S'";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )63;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCicloSTM;
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


        if(SQLCODE == SQLNOTFOUND)
        {
            vDTrazasError(szExeAboFact, "\n\n\t** No Existen Datos en GA_CTC_DEFVENTA Para Ciclo STB**"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Fecha Actual          [%s]"
                                        "\t\t\t=>Error  :  %s"
                                        ,LOG01,lhCodCiclo,szFecActual,SQLERRM);
            vDTrazasLog  (szExeAboFact, "\n\n\t** No Existen Datos en GA_CTC_DEFVENTA Para Ciclo STB**"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Fecha Actual          [%s]"
                                        "\t\t\t=>Error  :  %s"
                                        ,LOG01,lhCodCiclo,szFecActual,SQLERRM);
            return (FALSE);
        }

        if(SQLCODE != SQLOK)
        {
            vDTrazasError(szExeAboFact, "\n\n\t**  Error en Select sobre GA_CTC_DEFVENTA **",LOG01);
            vDTrazasLog  (szExeAboFact, "\n\n\t**  Error en Select sobre GA_CTC_DEFVENTA **",LOG01);
            return (FALSE);
        }
            
        /*******************************************************************/
        /********    Replica Registros de la tabla GA_INFACCEL     *********/
        /*******************************************************************/
        vDTrazasLog(szExeAboFact,"\n#######################################"
                                 "############################################"
                                 "\n###########################################"
                                 "########################################"
                                "\n\n\t**  Entrada a bfnCopiaFilasCel **"
                                 "\n\t\t=> Cod_CiclFact        [%ld]"
                                 "\n\t\t=> Cod_CiclFactFin     [%ld]"
                                 "\n\t\t=> Fecha Actual        [%s]"
                                 "\n\t\t=> Ciclo STB           [%ld]"
                                 "\n\t******************************************"
                                 "**************************************",
                                 LOG03, lhCodCiclFact, lhCodCiclFactFin, szFecActual, lhCodCicloSTM);
        
        if (!bfnCopiaFilasCel   (lhCodCiclFact, lhCodCiclFactFin, szFecActual, szhFecDesdeLlam ))
        {
            vDTrazasError(szExeAboFact, "\n\n\t**  Error Al Copiar Filas de GA_INFACCEL **",LOG01);
            vDTrazasLog(szExeAboFact, "\n\n\t**  Error Al Copiar Filas de GA_INFACCEL **",LOG01);
            return (FALSE);
        }
        
        /**********************************************************************/
        /**********   Replica Registros de la tabla GA_INFACBEEP    ***********/
        /**********************************************************************/
        vDTrazasLog(szExeAboFact,"\n#######################################"
                                 "############################################"
                                 "\n###########################################"
                                 "########################################"
                                 "\n\n\t**  Entrada a bfnCopiaFilasBeep **"
                                 "\n\t\t=> Cod_CiclFact        [%ld]"
                                 "\n\t\t=> Cod_CiclFactFin     [%ld]"
                                 "\n\t\t=> Fecha Actual        [%s] "
                                 "\n\t\t=> Ciclo STB           [%ld] "
                                 "\n\t******************************************"
                                 "**************************************",
                                 LOG03,lhCodCiclFact,lhCodCiclFactFin,szFecActual,lhCodCicloSTM);
                                 
        if (!bfnCopiaFilasBeep  (lhCodCiclFact, lhCodCiclFactFin, szFecActual, szhFecDesdeLlam))
        {
            vDTrazasError(szExeAboFact, "\n\n\t**  Error Al Copiar Filas de GA_INFACBEEP **",LOG01);
            vDTrazasLog  (szExeAboFact, "\n\n\t**  Error Al Copiar Filas de GA_INFACBEEP **",LOG01);
            return (FALSE);
        }
   }
   return (TRUE);
}/***********************   Final bfnReplicaCiclos **************************/



/****************************************************************************/
/*   Funcion :  bfnCopiaFilasCel                                            */
/*   BOOL   bfnCopiaFilasCel ( Cod_CiclFact , Cod_CiclFactAux ,             */
/*                             szFecActual,    szhFecDesdeLlam )            */
/*                                                                          */
/****************************************************************************/
static BOOL bfnCopiaFilasCel(  long lhCodCiclFact, long lhCodCiclFactFin, 
                        char* szFecActual,  char* sFecDesdeLlam  )
{
    int         iSqlCodeInt                 = SQLOK     ;
    long        lhCod_CodCliente_Anterior   = 0l        ;    
    long        lhCodCiclFactFinAux         = 0l        ;
    BOOL        bOptErrorInsert             = FALSE     ;
    BOOL        bProceso                    =TRUE;
    int         iNumFetch;
    
    GAINTERFACT stGaInfaccel                            ;
    
  
   while ( bProceso== TRUE)
   {

    iSqlCodeInt = ifnOpenInterfaz(stDatosGener.iProdCelular, lhCodCiclFact, lhCodCiclFactFin);
    iNumRows =0;
        
        
    while ( iSqlCodeInt == SQLOK )
    {
        memset ( &stGaInfaccel, 0 , sizeof ( GAINTERFACT ) );

        iSqlCodeInt = ifnFetchInterfaz(stDatosGener.iProdCelular,&stGaInfaccel,lhCodCiclFactFin); 
		        /* printf("SQLCODE Cliente ==================> %d \n",stGaInfaccel.lCodCliente);
		        printf("SQLCODE ==================> %d \n",iSqlCodeInt); */
        if (iSqlCodeInt == SQLOK)
        {
            /************************************************************************/
            /*  Controla COMMIT por Cliente.                                        */
            /*  No grava abonados del cliente si este no esta Consistente           */
            /************************************************************************/
            if( lhCod_CodCliente_Anterior != stGaInfaccel.lCodCliente &&  
                lhCod_CodCliente_Anterior > 0 ) 
            {
                if (!bfnCambCicloCliente(lhCod_CodCliente_Anterior))
                {
                    vDTrazasLog  (szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
                    vDTrazasError(szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
                    return (FALSE);
                }      

            }
            iNumRows++;
            if(iNumRows >= iNumRowsFetch)
            {
               iNumRows=0;
            }   
            /*printf("CONTADOR  ================> %d \n", iNumRows); */
            
            
            lhCod_CodCliente_Anterior   = stGaInfaccel.lCodCliente;
            stEstadisCelu.lTotales++    ;
            bOptErrorInsert     = FALSE ;
            /*printf("Voy A  SetUpdate \n");*/
            if(!SetUpdate(  stDatosGener.iProdCelular, &stGaInfaccel, szFecActual))
            {
                stEstadisCelu.lIncorrectos++    ;
                bOptErrorInsert=TRUE            ;
                vDTrazasLog  (szExeAboFact, "\n\t**** Error en SetUpdate  ****"
                                            "\n\t Abonado Procesado Con Errores          "
                                            "\n\t\t==> Cliente                      [%ld]"
                                            "\n\t\t==> Abonado                      [%ld]"
                                            "\n\t\t==> Codigo Ciclo Facturacion     [%ld]"
                                            "\n\t****************************************"
                                            "********************************************",
                                            LOG03,stGaInfaccel.lCodCliente,stGaInfaccel.lNumAbonado,
                                            stGaInfaccel.lCodCiclFactNew   );

                vDTrazasError(szExeAboFact, "\n\n\t**    Error en SetUpdate    **"
                                            "\n\t\t==> Cliente              [%ld]"
                                            "\n\t\t==> Abonado              [%ld]"
                                            "\n\t\t==> Producto             [%d ]"
                                            "\n\t\t==> Fecha Actual         [%s ]"
                                            "\n\t\t==> Ind. Arriendo        [%ld]"
                                            "\n\t\t==> Ind. Cuotas          [%ld]"
                                            "\n\t\t==> Ind. Cargos          [%ld]"
                                            "\n\t\t==> Codigo Ciclo Fact.   [%ld]"
                                            "\n\t\t==> Codigo de Ciclo      [%ld]", LOG01,
                                            stGaInfaccel.lCodCliente      ,stGaInfaccel.lNumAbonado      ,
                                            stDatosGener.iProdCelular     ,szFecActual                    ,
                                            stGaInfaccel.lIndArriendo     ,stGaInfaccel.lIndCuotas       ,
                                            stGaInfaccel.lIndCargos       ,stGaInfaccel.lCodCiclFactNew ,
                                            stGaInfaccel.iCodCiclo  );
            }
            /*printf("bOptErrorInsert=%d stGaInfaccel.bOptExiste=%d\n",bOptErrorInsert,stGaInfaccel.bOptExiste);*/
            if((bOptErrorInsert == FALSE) && (stGaInfaccel.bOptExiste == FALSE))
            {
             
                vValSTB(&stGaInfaccel);
                
                vValCargoPro(&stGaInfaccel);
                
                /**************************************************************/
                /* Si Cambio de Ciclo Cambia la Fecha Desde en la GA_INFACCEL */
                /**************************************************************/
                stGaInfaccel.lIndAlta = 0;
                if ( stGaInfaccel.iIndCambio && stGaInfaccel.lIndActuac == iINDACTUAC_NORMAL  )
                {
                /*  strcpy(stGaInfaccel.szFecAlta,sFecDesdeLlam);  Fechas de Alta y Baja en Intarcel    */
                /*  stGaInfaccel.lIndAlta = 1;                                                          */
                }
                /*printf("Voy a bfnInsertInterfaz \n"); */
                if (!bfnInsertInterfaz(stDatosGener.iProdCelular,&stGaInfaccel))
				{
					printf("Error en bfnInsertInterfaz \n");
                    return (FALSE);
				}
                
            }
            if(bOptErrorInsert == FALSE)
            {
                stEstadisCelu.lCorrectos++;
                vDTrazasLog(szExeAboFact,   "\n\t Abonado Procesado Correctamente        "
                                            "\n\t\t==> Cliente                      [%ld]"
                                            "\n\t\t==> Abonado                      [%ld]"
                                            "\n\t\t==> Codigo Ciclo Facturacion     [%ld]"
                                            "\n\t\t==> Indicador de Actuacion       [%d]"
                                            "\n\t****************************************"
                                            "****************************************"
                                            ,LOG03 ,stGaInfaccel.lCodCliente
                                            ,stGaInfaccel.lNumAbonado
                                            ,stGaInfaccel.lCodCiclFactNew
                                            ,stGaInfaccel.lIndActuac);
            }
        }
        else if (iNumRows == 0 && iSqlCodeInt == SQLNOTFOUND)
        {
          iSqlCodeInt = ifnFetchInterfaz(stDatosGener.iProdCelular,&stGaInfaccel,lhCodCiclFactFin); 
          if (iSqlCodeInt == SQLNOTFOUND)
          {
           bProceso=FALSE;
          } 
        }
    }
    
	
    if (!bfnCambCicloCliente(lhCod_CodCliente_Anterior))
    {
        vDTrazasLog  (szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
        vDTrazasError(szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
        return (FALSE);
    }
    
    if (!bfnCloseInterfaz(stDatosGener.iProdCelular))
        return (FALSE);
      /* printf("Commit final \n");     */
    if(!fnOraCommit())
    {
        vDTrazasLog  (szExeAboFact, "ERROR AL HACER EL COMMIT EN GA_INFACCEL",LOG01, SQLERRM);
        vDTrazasError(szExeAboFact, "ERROR AL HACER EL COMMIT EN GA_INFACCEL",LOG01, SQLERRM);
        return (FALSE);
    }

   }
        
    vDTrazasLog(szExeAboFact, "\n\t**  SALIENDO DE bfnCopiaFilasCel ",LOG03);
    
    return TRUE;
}/***********************   Final bfnCopiaFilasCel    ***********************/


/****************************************************************************/
/*   Funcion :  bfnCopiaFilasBeep                                           */
/*   BOOL   bfnCopiaFilasBeep ( Cod_CiclFact , Cod_CiclFactAux              */
/*                              ,szFecActual, szhFecDesdeLlam )             */
/*                                                                          */
/****************************************************************************/

static BOOL bfnCopiaFilasBeep(long lhCodCiclFact, long lhCodCiclFactFin, char* szFecActual, char* sFecDesdeLlam)
{
    int         iSqlCodeInt                 = SQLOK     ;
    long        lhCod_CodCliente_Anterior   = 0l        ;    
    long        lhCodCiclFactFinAux         = 0l        ;
    BOOL        bOptErrorInsert             = FALSE     ;
    BOOL        bProceso                    = TRUE      ;

    GAINTERFACT stGaInfacbeep                            ;
    
   while ( bProceso== TRUE)
   {
    iSqlCodeInt = ifnOpenInterfaz(stDatosGener.iProdBeeper, lhCodCiclFact, lhCodCiclFactFin);

    while ( iSqlCodeInt == SQLOK )
    {
        memset ( &stGaInfacbeep, 0 , sizeof ( GAINTERFACT ) );

        iSqlCodeInt = ifnFetchInterfaz(stDatosGener.iProdBeeper,&stGaInfacbeep,lhCodCiclFactFin); 

        if (iSqlCodeInt == SQLOK)
        {
            /************************************************************************/
            /*  Controla COMMIT por Cliente.                                        */
            /*  No grava abonados del cliente si este no esta Consistente           */
            /************************************************************************/
            if( lhCod_CodCliente_Anterior != stGaInfacbeep.lCodCliente && 
                lhCod_CodCliente_Anterior > 0 ) 
            {
                if (!bfnCambCicloCliente(lhCod_CodCliente_Anterior))
                {
                    vDTrazasLog  (szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
                    vDTrazasError(szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
                    return (FALSE);
                }                                
 
            }
            iNumRows++;
            if(iNumRows >= iNumRowsFetch)
            {
               iNumRows=0;
            }           
            lhCod_CodCliente_Anterior   = stGaInfacbeep.lCodCliente;
            stEstadisBeep.lTotales++    ;
            bOptErrorInsert     = FALSE ;
            if(!SetUpdate(  stDatosGener.iProdBeeper, &stGaInfacbeep, szFecActual))
            {
                stEstadisBeep.lIncorrectos++    ;
                bOptErrorInsert=TRUE            ;
                vDTrazasLog  (szExeAboFact, "\n\t**** Error en SetUpdate  ****"
                                            "\n\t Abonado Procesado Con Errores          "
                                            "\n\t\t==> Cliente                      [%ld]"
                                            "\n\t\t==> Abonado                      [%ld]"
                                            "\n\t\t==> Codigo Ciclo Facturacion     [%ld]"
                                            "\n\t****************************************"
                                            "********************************************",
                                            LOG03,stGaInfacbeep.lCodCliente,stGaInfacbeep.lNumAbonado,
                                            stGaInfacbeep.lCodCiclFactNew   );

                vDTrazasError(szExeAboFact, "\n\n\t**    Error en SetUpdate    **"
                                            "\n\t\t==> Cliente              [%ld]"
                                            "\n\t\t==> Abonado              [%ld]"
                                            "\n\t\t==> Producto             [%d ]"
                                            "\n\t\t==> Fecha Actual         [%s ]"
                                            "\n\t\t==> Ind. Arriendo        [%ld]"
                                            "\n\t\t==> Ind. Cuotas          [%ld]"
                                            "\n\t\t==> Ind. Cargos          [%ld]"
                                            "\n\t\t==> Codigo Ciclo Fact.   [%ld]"
                                            "\n\t\t==> Codigo de Ciclo      [%ld]", LOG01,
                                            stGaInfacbeep.lCodCliente      ,stGaInfacbeep.lNumAbonado      ,
                                            stDatosGener.iProdBeeper       ,szFecActual                     ,
                                            stGaInfacbeep.lIndArriendo     ,stGaInfacbeep.lIndCuotas       ,
                                            stGaInfacbeep.lIndCargos       ,stGaInfacbeep.lCodCiclFactNew ,
                                            stGaInfacbeep.iCodCiclo  );
            }
            if((bOptErrorInsert == FALSE) && (stGaInfacbeep.bOptExiste == FALSE))
            {
             
                vValSTB(&stGaInfacbeep);
                
                vValCargoPro(&stGaInfacbeep);
                
                /**************************************************************/
                /* Si Cambio de Ciclo Cambia la Fecha Desde en la GA_INFACBEEP*/
                /**************************************************************/
                stGaInfacbeep.lIndAlta = 0;
                if ( stGaInfacbeep.iIndCambio && stGaInfacbeep.lIndActuac == iINDACTUAC_NORMAL  )
                {
                /*    strcpy(stGaInfacbeep.szFecAlta,sFecDesdeLlam);    */
                /*    stGaInfacbeep.lIndAlta = 1;                       */
                }
                if (!bfnInsertInterfaz(stDatosGener.iProdBeeper,&stGaInfacbeep))
                    return (FALSE);
                
            }
            if(bOptErrorInsert == FALSE)
            {
                stEstadisBeep.lCorrectos++;
                vDTrazasLog(szExeAboFact,   "\n\t Abonado Procesado Correctamente        "
                                            "\n\t\t==> Cliente                      [%ld]"
                                            "\n\t\t==> Abonado                      [%ld]"
                                            "\n\t\t==> Codigo Ciclo Facturacion     [%ld]"
                                            "\n\t\t==> Indicador de Actuacion       [%d]"
                                            "\n\t****************************************"
                                            "****************************************"
                                            ,LOG03, stGaInfacbeep.lCodCliente
                                            ,stGaInfacbeep.lNumAbonado
                                            ,stGaInfacbeep.lCodCiclFactNew
                                            ,stGaInfacbeep.lIndActuac);
            }
        }
        else if (iNumRows == 0 && iSqlCodeInt == SQLNOTFOUND)
        {
          iSqlCodeInt = ifnFetchInterfaz(stDatosGener.iProdBeeper,&stGaInfacbeep,lhCodCiclFactFin); 
          if (iSqlCodeInt == SQLNOTFOUND)
          {
           bProceso=FALSE;
          } 
        }
    }
    if (!bfnCambCicloCliente(lhCod_CodCliente_Anterior))
    {
        vDTrazasLog  (szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
        vDTrazasError(szExeAboFact, "Error En Cambio de Ciclo en Ge_Clientes",LOG01, SQLERRM);
        return (FALSE);
    }                                
    if (!bfnCloseInterfaz(stDatosGener.iProdBeeper))
        return (FALSE);
            
    if(!fnOraCommit())
    {
        vDTrazasLog  (szExeAboFact, "ERROR AL HACER EL COMMIT EN GA_INFACBEEP",LOG01, SQLERRM);
        vDTrazasError(szExeAboFact, "ERROR AL HACER EL COMMIT EN GA_INFACBEEP",LOG01, SQLERRM);
        return (FALSE);
    }
  }

        
    vDTrazasLog(szExeAboFact, "\n\t**  SALIENDO DE bfnCopiaFilasBeep ",LOG03);
    return TRUE;
}/***********************   Final bfnCopiaFilasBeep  ************************/




/****************************************************************************/
/*                         funcion : ifnOpenInterfaz                        */
/****************************************************************************/

static int ifnOpenInterfaz(int iProducto, long lCiclFactActual,long lCiclFactNuevo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact      = lCiclFactActual       ;
        long lhCodCiclFactFin   = lCiclFactNuevo        ;
        long lhCodCliete        = 0                     ;
        long lhNumAbonado       = 0                     ;
        int  iActuaNormal       = iINDACTUAC_NORMAL     ;
        int  iActuaBaja         = iINDACTUAC_BAJA       ;
        int  iActuacTraspaso    = iINDACTUAC_TRASPASO   ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( szExeAboFact,"\n\t** Open Interfaz %s (ifnOpenInterfaz) **"
                            ,LOG05,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP"));

    
    if (iProducto == stDatosGener.iProdCelular )
    {
        /* EXEC SQL DECLARE cGaInFacCel CURSOR FOR
            SELECT  A.COD_CLIENTE,
                    A.NUM_ABONADO,
                    A.COD_CICLFACT,
                    TO_CHAR(A.FEC_ALTA,'YYYYMMDDHH24MISS'), 
                    TO_CHAR(A.FEC_BAJA,'YYYYMMDDHH24MISS'),
                    A.NUM_CELULAR,
                    A.IND_ACTUAC,
                    TO_CHAR(A.FEC_FINCONTRA,'YYYYMMDDHH24MISS'), 
                    A.IND_ALTA,
                    A.IND_DETALLE, 
                    A.IND_FACTUR,
                    A.IND_CUOTAS,
                    A.IND_ARRIENDO,
                    A.IND_CARGOS,
                    A.IND_PENALIZA,
                    A.IND_SUPERTEL,
                    A.NUM_TELEFIJA,
                    A.COD_SUPERTEL,
                    A.IND_CARGOPRO,
                    A.IND_CUENCONTROLADA,
                    A.IND_BLOQUEO
            FROM    GA_INFACCEL  A
            WHERE   A.COD_CLIENTE >  :lhCodCliete
            AND     A.NUM_ABONADO >= :lhNumAbonado
            AND     A.COD_CICLFACT = :lhCodCiclFact
            AND     A.IND_ACTUAC  IN (  :iActuaNormal   ,
                                        :iActuaBaja     ,
                                        :iActuacTraspaso)
            AND     A.NUM_ABONADO NOT IN  ( SELECT  B.NUM_ABONADO
                                            FROM    GA_INFACCEL B
                                            WHERE   A.COD_CLIENTE  = B.COD_CLIENTE
                                            AND     A.NUM_ABONADO  = B.NUM_ABONADO 
                                            AND     B.COD_CICLFACT = :lhCodCiclFactFin )
             AND     ROWNUM <= :iNumRowsFetch
             ORDER BY A.COD_CLIENTE,A.NUM_ABONADO; */ 

        
        /* EXEC SQL OPEN cGaInFacCel; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0004;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )82;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliete;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&iActuaNormal;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&iActuaBaja;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&iActuacTraspaso;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCiclFactFin;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&iNumRowsFetch;
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
    
    if (iProducto == stDatosGener.iProdBeeper )
    {
        /* EXEC SQL DECLARE cGaInFacBeep CURSOR FOR
            SELECT A.COD_CLIENTE,
                   A.NUM_ABONADO,
                   A.COD_CICLFACT,
                   TO_CHAR(A.FEC_ALTA,'YYYYMMDDHH24MISS'), 
                   TO_CHAR(A.FEC_BAJA,'YYYYMMDDHH24MISS'),
                   A.NUM_BEEPER,
                   A.IND_ACTUAC,
                   TO_CHAR(A.FEC_FINCONTRA,'YYYYMMDDHH24MISS'), 
                   A.IND_ALTA,
                   A.IND_DETALLE, 
                   A.IND_FACTUR,
                   A.IND_CUOTAS,
                   A.IND_ARRIENDO,
                   A.IND_CARGOS, 
                   A.IND_PENALIZA,
                   A.IND_CARGOPRO,                            /o   Debe ser Uno 1      o/
                   A.IND_CUENCONTROLADA,                      /o   Debe ser Cero 0     o/
                   A.IND_BLOQUEO                     
            FROM   GA_INFACBEEP A
            WHERE  A.COD_CLIENTE >  :lhCodCliete
            AND    A.NUM_ABONADO >= :lhNumAbonado
            AND    A.COD_CICLFACT = :lhCodCiclFact
            AND    A.IND_ACTUAC  IN (   :iActuaNormal   ,
                                        :iActuaBaja     ,
                                        :iActuacTraspaso)
            AND    A.COD_CLIENTE NOT IN  (  SELECT  B.COD_CLIENTE
                                            FROM    GA_INFACBEEP B
                                            WHERE   A.COD_CLIENTE  = B.COD_CLIENTE
                                            AND     A.NUM_ABONADO  = B.NUM_ABONADO
                                            AND     B.COD_CICLFACT = :lhCodCiclFactFin )
            AND     ROWNUM <= :iNumRowsFetch                                
            ORDER BY A.COD_CLIENTE,A.NUM_ABONADO; */ 


        /* EXEC SQL OPEN cGaInFacBEEP; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0005;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )129;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliete;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&iActuaNormal;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&iActuaBaja;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&iActuacTraspaso;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCiclFactFin;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&iNumRowsFetch;
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

    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeAboFact, "\n\n\t** No Existen Datos en %s **"
                                    "\n\t\t=> Codigo de Ciclo       [%ld]"
                                    ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP")
                                    ,lhCodCiclFact);
        vDTrazasError(szExeAboFact, "\n\n\t** No Existen Datos en %s **"
                                    "\n\t\t=> Codigo de Ciclo       [%ld]"
                                    ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP")
                                    ,lhCodCiclFact);
        return (SQLCODE);
    }
    
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szExeAboFact, "\n\n\t**  Error en Select sobre %s Cod_CiclFact [%ld] "
                                    "\n\t\t=> Error [%s] **"
                                    ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP")
                                    ,lhCodCiclFact,SQLERRM);
        vDTrazasLog  (szExeAboFact, "\n\n\t**  Error en Select sobre %s Cod_CiclFact [%ld] "
                                    "\n\t\t=> Error [%s] **"
                                    ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP")
                                    ,lhCodCiclFact,SQLERRM);
        return (SQLCODE);
    }
    return (SQLCODE);
}/***********************   Final ifnOpenInterfaz    ************************/




/****************************************************************************/
/*                         funcion : ifnFetchInterfaz                       */
/****************************************************************************/

static int ifnFetchInterfaz(int iProducto ,GAINTERFACT *pstGInterfaz,long lCodCicloFactNue)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


        long lhCOD_CLIENTE          ;
        long lhNUM_ABONADO          ;
        long lhCOD_CICLFACT         ;
        char szhFEC_ALTA[15]        ;   /* EXEC SQL VAR szhFEC_ALTA IS STRING(15); */ 

        char szhFEC_BAJA[15]        ;   /* EXEC SQL VAR szhFEC_BAJA IS STRING(15); */ 

        long lhNUM_CELULAR          ;
        long lhNUM_BEEPER           ;
        long lhIND_ACTUAC           ;
        char szhFEC_FINCONTRA[15]   ;   /* EXEC SQL VAR szhFEC_FINCONTRA IS STRING(15); */ 

        long lhIND_ALTA             ;
        long lhIND_DETALLE          ;
        long lhIND_FACTUR           ;
        long lhIND_CUOTAS           ;
        long lhIND_ARRIENDO         ;
        long lhIND_CARGOS           ;
        long lhIND_PENALIZA         ;
        long lhIND_SUPERTEL         ;
        char szhNUM_TELEFIJA[16]    ;   /* EXEC SQL VAR szhNUM_TELEFIJA IS STRING(16); */ 
 short i_hNumTeleFija;
        long lhCOD_SUPERTEL         ;                                               short i_hCodSuperTel;
        long lhIND_CARGOPRO         ;                                               short i_hIndCargoPro;
        long lhIND_CUENCONTROLADA   ;                                               short i_hIndCuenControlada;
        long lhIND_BLOQUEO          ;                                               short i_hIndBloqueo;

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( szExeAboFact,"\n\t** Fetch Documento %s (ifnFetchDocumentos) **"
                            ,LOG05,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP"));


    if (iProducto == stDatosGener.iProdCelular )
    {
        /* EXEC SQL FETCH cGaInFacCel INTO
            :lhCOD_CLIENTE                                  , 
            :lhNUM_ABONADO                                  , 
            :lhCOD_CICLFACT                                 , 
            :szhFEC_ALTA                                    ,
            :szhFEC_BAJA                                    , 
            :lhNUM_CELULAR                                  , 
            :lhIND_ACTUAC                                   , 
            :szhFEC_FINCONTRA                               ,
            :lhIND_ALTA                                     , 
            :lhIND_DETALLE                                  , 
            :lhIND_FACTUR                                   , 
            :lhIND_CUOTAS                                   ,
            :lhIND_ARRIENDO                                 , 
            :lhIND_CARGOS                                   , 
            :lhIND_PENALIZA                                 , 
            :lhIND_SUPERTEL                                 ,
            :szhNUM_TELEFIJA        :i_hNumTeleFija         ,
            :lhCOD_SUPERTEL         :i_hCodSuperTel         ,
            :lhIND_CARGOPRO         :i_hIndCargoPro         ,
            :lhIND_CUENCONTROLADA   :i_hIndCuenControlada   ,
            :lhIND_BLOQUEO          :i_hIndBloqueo          ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )176;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCOD_CLIENTE;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNUM_ABONADO;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCOD_CICLFACT;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFEC_ALTA;
        sqlstm.sqhstl[3] = (unsigned long )15;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFEC_BAJA;
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhNUM_CELULAR;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhIND_ACTUAC;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFEC_FINCONTRA;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhIND_ALTA;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&lhIND_DETALLE;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&lhIND_FACTUR;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&lhIND_CUOTAS;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&lhIND_ARRIENDO;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&lhIND_CARGOS;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&lhIND_PENALIZA;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&lhIND_SUPERTEL;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szhNUM_TELEFIJA;
        sqlstm.sqhstl[16] = (unsigned long )16;
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)&i_hNumTeleFija;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&lhCOD_SUPERTEL;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)&i_hCodSuperTel;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)&lhIND_CARGOPRO;
        sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)&i_hIndCargoPro;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)&lhIND_CUENCONTROLADA;
        sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)&i_hIndCuenControlada;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&lhIND_BLOQUEO;
        sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)&i_hIndBloqueo;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
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

    if (iProducto == stDatosGener.iProdBeeper)
    {
        /* EXEC SQL FETCH cGaInFacBeep INTO
            :lhCOD_CLIENTE, 
            :lhNUM_ABONADO, 
            :lhCOD_CICLFACT, 
            :szhFEC_ALTA,
            :szhFEC_BAJA, 
            :lhNUM_BEEPER, 
            :lhIND_ACTUAC, 
            :szhFEC_FINCONTRA,
            :lhIND_ALTA, 
            :lhIND_DETALLE, 
            :lhIND_FACTUR, 
            :lhIND_CUOTAS,
            :lhIND_ARRIENDO, 
            :lhIND_CARGOS, 
            :lhIND_PENALIZA, 
            :lhIND_CARGOPRO         :i_hIndCargoPro         ,
            :lhIND_CUENCONTROLADA   :i_hIndCuenControlada   ,
            :lhIND_BLOQUEO          :i_hIndBloqueo          ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )275;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCOD_CLIENTE;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNUM_ABONADO;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCOD_CICLFACT;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFEC_ALTA;
        sqlstm.sqhstl[3] = (unsigned long )15;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFEC_BAJA;
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhNUM_BEEPER;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhIND_ACTUAC;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFEC_FINCONTRA;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhIND_ALTA;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&lhIND_DETALLE;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&lhIND_FACTUR;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&lhIND_CUOTAS;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&lhIND_ARRIENDO;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&lhIND_CARGOS;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&lhIND_PENALIZA;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&lhIND_CARGOPRO;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)&i_hIndCargoPro;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)&lhIND_CUENCONTROLADA;
        sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)&i_hIndCuenControlada;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&lhIND_BLOQUEO;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)&i_hIndBloqueo;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
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
    
    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szExeAboFact  ,"\n\t** Error en Fecth de Cursor de %s : %s"
                                    ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP"),SQLERRM);
        vDTrazasLog  (szExeAboFact  ,"\n\t** Error en Fecth de Cursor de %s : %s"
                                    ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP"),SQLERRM);
    }
    
    if( SQLCODE == SQLOK )
    { 
        pstGInterfaz->lCodCliente        = lhCOD_CLIENTE     ;
        pstGInterfaz->lNumAbonado        = lhNUM_ABONADO     ;
        pstGInterfaz->iCodProducto       = iProducto         ;
        pstGInterfaz->lCodCiclFact       = lhCOD_CICLFACT    ;
        pstGInterfaz->lCodCiclFactNew    = lCodCicloFactNue  ;
        pstGInterfaz->lNumTerminal       = (iProducto == stDatosGener.iProdCelular ? lhNUM_CELULAR : lhNUM_BEEPER);
        pstGInterfaz->lIndActuac         = lhIND_ACTUAC      ;
        pstGInterfaz->lIndAlta           = lhIND_ALTA        ;
        pstGInterfaz->lIndDetalle        = lhIND_DETALLE     ;
        pstGInterfaz->lIndFactur         = lhIND_FACTUR      ;
        pstGInterfaz->lIndCuotas         = lhIND_CUOTAS      ;
        pstGInterfaz->lIndArriendo       = lhIND_ARRIENDO    ;
        pstGInterfaz->lIndCargos         = lhIND_CARGOS      ;
        pstGInterfaz->lIndPenaliza       = 0                 ;  /*  lhIND_PENALIZA    */

        strcpy(pstGInterfaz->szFecAlta,szhFEC_ALTA)          ;

        strcpy(pstGInterfaz->szFecBaja,szhFEC_BAJA)          ;
        strcpy(pstGInterfaz->szFecFinContra,szhFEC_FINCONTRA);

        if (iProducto == stDatosGener.iProdCelular )
        {
            pstGInterfaz->lIndSupertel       = lhIND_SUPERTEL                                           ;
            strcpy(pstGInterfaz->szNumTeleFija,(i_hNumTeleFija == ORA_NULL ? "" : szhNUM_TELEFIJA))    ;
            pstGInterfaz->lCodSupertel       = (i_hCodSuperTel == ORA_NULL ? 0 : lhCOD_SUPERTEL )       ;
        }
        pstGInterfaz->lIndCargoPro       = (i_hIndCargoPro == ORA_NULL ? 0 : lhIND_CARGOPRO )           ;
        pstGInterfaz->lIndCuenControlada = (i_hIndCuenControlada == ORA_NULL ? 0 : lhIND_CUENCONTROLADA);
        pstGInterfaz->lIndBloqueo        = (i_hIndBloqueo == ORA_NULL ? 0 : lhIND_BLOQUEO )             ;
    }
    vDTrazasLog ( szExeAboFact,"\t\t** Codigo de Retorno SQLCODE [%d] **",LOG05,SQLCODE);    
    return (SQLCODE);
}/***********************  Final ifnFetchInterfaz    ************************/


/****************************************************************************/
/*                         funcion : bfnCloseInterfaz                       */
/****************************************************************************/

static BOOL bfnCloseInterfaz(int iProducto)
{
    vDTrazasLog  (szExeAboFact,"\n\t** Close de Interfaz %s (bfnCloseInterfaz)**"
                            ,LOG03,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP"));

    if (iProducto == stDatosGener.iProdCelular )
        /* EXEC SQL CLOSE cGaInFacCel  ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )362;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        
    if (iProducto == stDatosGener.iProdBeeper)
        /* EXEC SQL CLOSE cGaInFacBeep ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )377;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (szExeAboFact,"\n\t** Error en Close de Interfaz %s (bfnCloseInterfaz) :%d  %s **"
                                ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP")
                                ,SQLCODE,SQLERRM);
        vDTrazasError(szExeAboFact,"\n\t** Error en Close de Interfaz %s (bfnCloseInterfaz) :%d  %s **"
                                ,LOG01,(iProducto == stDatosGener.iProdCelular ? "GA_INFACCEL":"GA_INFACBEEP")
                                ,SQLCODE,SQLERRM);
        return (FALSE);         
    }
    return (TRUE);
}/***********************  Final bfnCloseInterfaz    *************************/



/*****************************************************************************/
/*****************************************************************************/
/*   Funcion :  SetUpdate                                                    */
/*   BOOL   SetUpdate ( Cliente, Abonado, Prodcuto , Arriendo, Cuotas,       */
/*                      Cargos, Producto, Cod_Ciclfact, Cod_Ciclo)           */
/*                                                                           */
/*                                                                           */
/*****************************************************************************/
/*****************************************************************************/

static BOOL SetUpdate(int iProducto ,GAINTERFACT *stpGInter , char *szhFecHoy)
{
    BOOL    bFinCursor  = FALSE ;
    int     iNumDias    = 0     ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


        long  lhCodCicloNue         ;
        short i_hCodCicloNue        ;
        long  lhCodCicloActual      ;
        long  lhCiclFactProx        ;
        long  lhIndCambio       = 0 ;
        long  lhIndPagada           ;
        long  lhNumCargo            ;
        char  szhFecDesde[18]       ;   /* EXEC SQL VAR szhFecDesde IS STRING(18); */ 

        char  szhFecHasta[18]       ;   /* EXEC SQL VAR szhFecHasta IS STRING(18); */ 

        long  lhCodClienteAux;

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(szExeAboFact,   "\n\n\t** Parametros de Entrada a SetUpdate  ** "
                                "\n\t\t==> Cliente              [%ld]"
                                "\n\t\t==> Abonado              [%ld]"
                                "\n\t\t==> Producto             [%d]"
                                "\n\t\t==> Fecha Actual         [%s]"
                                "\n\t\t==> Ind. Arriendo        [%ld]"
                                "\n\t\t==> Ind. Cuotas          [%ld]"
                                "\n\t\t==> Ind. Cargos          [%ld]"
                                "\n\t\t==> Codigo Ciclo Fact.   [%ld]"
                                "\n\t\t==> Codigo de Ciclo      [%ld]",
                                LOG05,
                                stpGInter->lCodCliente   ,stpGInter->lNumAbonado       ,
                                iProducto               ,szhFecHoy                   ,
                                stpGInter->lIndArriendo  ,stpGInter->lIndCuotas        ,
                                stpGInter->lIndCargos    ,stpGInter->lCodCiclFactNew  ,
                                stpGInter->iCodCiclo );
    
    stpGInter->iIndCambio       = 0;
    
    /***************************************************************/
    /* Comprobamos si el abonado se ha cambiado de ciclo.          */
    /***************************************************************/

    i_hCodCicloNue = 0;

    /* EXEC SQL SELECT COD_CICLO,
                    COD_CICLONUE,   
                    IND_CAMBIO
             INTO   :lhCodCicloActual, 
                    :lhCodCicloNue  :i_hCodCicloNue, 
                    :lhIndCambio    
             FROM   FA_CICLOCLI
             WHERE  COD_CLIENTE  = :stpGInter->lCodCliente
             AND    COD_PRODUCTO = :iProducto
             AND    NUM_ABONADO  = :stpGInter->lNumAbonado
        FOR UPDATE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CICLO ,COD_CICLONUE ,IND_CAMBIO into :b0,:b1:b\
2,:b3  from FA_CICLOCLI where ((COD_CLIENTE=:b4 and COD_PRODUCTO=:b5) and NUM_\
ABONADO=:b6) for update ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )392;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCicloActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCicloNue;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)&i_hCodCicloNue;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhIndCambio;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(stpGInter->lCodCliente);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&iProducto;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&(stpGInter->lNumAbonado);
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szExeAboFact, "\n\n\t  Error Al Recuperar Registro de FA_CICLOCLI "
                                    "\n\t\t==>  Cliente     [%ld]"
                                    "\n\t\t==>  Abonado     [%ld]"
                                    "\n\t\t==>  Producto    [%d ]"
                                    ,LOG01,stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
        vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Recuperar Registro de FA_CICLOCLI "
                                    "\n\t\t==>  Cliente     [%ld]"
                                    "\n\t\t==>  Abonado     [%ld]"
                                    "\n\t\t==>  Producto    [%d ]"
                                    ,LOG01,stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
        vPrintInconsistencia(stpGInter,INCONS031);
        return (FALSE);
     }

     stpGInter->iCodCiclo   =   lhCodCicloActual    ;            /* Setea el Codigo del Ciclo Antiguo   */
     stpGInter->iCodCicloNew=   lhCodCicloActual    ;

    /***************************************************************/
    /*   Cambio de Ciclo en FA_CICLOCLI ,  Cambia de Cod_CiclFact  */
    /***************************************************************/
    if ((lhIndCambio > 0)  && (lhCodCicloNue != lhCodCicloActual))
    {
        /* Valida el Valor del Campo Cod_Ciclo            */
        /**************************************************/
        if (i_hCodCicloNue == ORA_NULL )
        {
            vDTrazasError(szExeAboFact, "\n\n\t  Error en Cod_CicloNue (Null) de FA_CICLOCLI con IND_CAMBIO == 1 "
                                        "\n\t\t==>  Cliente     [%ld]"
                                        "\n\t\t==>  Abonado     [%ld]"
                                        "\n\t\t==>  Producto    [%d ]"
                                        , LOG01,stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
            vDTrazasLog  (szExeAboFact, "\n\n\t  Error en Cod_CicloNue (Null) de FA_CICLOCLI con IND_CAMBIO == 1 "
                                        "\n\t\t==>  Cliente     [%ld]"
                                        "\n\t\t==>  Abonado     [%ld]"
                                        "\n\t\t==>  Producto    [%d ]"
                                        , LOG01,stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
            return (FALSE);
        }

        /* Busca el nuevo Cod_CiclFact para Cod_CicloNue. */
        /**************************************************/

        /* EXEC SQL    SELECT  COD_CICLFACT
                    INTO    :lhCiclFactProx
                    FROM    FA_CICLFACT
                    WHERE   COD_CICLO = :lhCodCicloNue
                    AND     to_date(:szhFecHoy,'YYYYMMDDHH24MISS') 
                       BETWEEN FEC_DESDELLAM 
                       AND     FEC_HASTALLAM ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_CICLFACT into :b0  from FA_CICLFACT where \
(COD_CICLO=:b1 and to_date(:b2,'YYYYMMDDHH24MISS') between FEC_DESDELLAM and F\
EC_HASTALLAM)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )431;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclFactProx;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCicloNue;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecHoy;
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

 

        if(SQLCODE != SQLOK)
        {    
            vDTrazasError(szExeAboFact, "\n\n\t  Error Al Recuperar Nuevo Cod_CiclFact de FA_CICLFACT "
                                        "\n\t\t==>  Cliente         [%ld]"
                                        "\n\t\t==>  Abonado         [%ld]"
                                        "\n\t\t==>  Producto        [%d]"
                                        "\n\t\t==>  Ciclo           [%ld]"
                                        "\n\t\t==>  Fecha Actual    [%s]"
                                        ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto
                                        ,lhCodCicloNue, szhFecHoy);
            vDTrazasLog   (szExeAboFact, "\n\n\t  Error Al Recuperar Nuevo Cod_CiclFact de FA_CICLFACT "
                                        "\n\t\t==>  Cliente         [%ld]"
                                        "\n\t\t==>  Abonado         [%ld]"
                                        "\n\t\t==>  Producto        [%d]"
                                        "\n\t\t==>  Ciclo           [%ld]"
                                        "\n\t\t==>  Fecha Actual    [%s]"
                                        ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto
                                        ,lhCodCicloNue, szhFecHoy);
            return (FALSE);
        }

        stpGInter->iCodCicloNew     =   lhCodCicloNue   ;   /*  Setea el Codigo del Ciclo Nuevo */
        stpGInter->lCodCiclFactNew  =   lhCiclFactProx  ;
        stpGInter->iIndCambio       = 1                 ;
        
        if (iProducto ==  stDatosGener.iProdCelular)
            stEstadisCelu.lTotCambCiclo++;
        else
            stEstadisBeep.lTotCambCiclo++;
        
        vDTrazasLog(szExeAboFact,   "\n\n\t***  Cambio de Ciclo - Nuevo Cod_CiclFact "
                                    "\n\t\t==>  Cliente     [%ld]"
                                    "\n\t\t==>  Abonado     [%ld]"
                                    "\n\t\t==>  Producto    [%ld ]"
                                    "\n\t\t==>  Ciclo Nuevo [%ld ]"
                                    ,LOG03, stpGInter->lCodCliente, stpGInter->lNumAbonado
                                    ,iProducto, stpGInter->lCodCiclFactNew);
        if (lhIndCambio == 1)
        {
            /* EXEC SQL   
                 UPDATE FA_CICLOCLI
                 SET     IND_CAMBIO   = 2
                 WHERE   COD_CLIENTE = :stpGInter->lCodCliente
                 AND     COD_PRODUCTO= :iProducto            
                 AND     NUM_ABONADO = :stpGInter->lNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 21;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_CICLOCLI  set IND_CAMBIO=2 where ((COD_\
CLIENTE=:b0 and COD_PRODUCTO=:b1) and NUM_ABONADO=:b2)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )458;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(stpGInter->lCodCliente);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&iProducto;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&(stpGInter->lNumAbonado);
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


            if(SQLCODE != SQLOK)
            {
                vDTrazasLog  (szExeAboFact, "\n\n\t** Error en UPDATE Sobre FA_CICLOCLI (IND_CAMBIO = 2) ** "
                                            "\n\t\t==>  Cliente     [%ld]"
                                            "\n\t\t==>  Abonado     [%ld]"
                                            "\n\t\t==>  Producto    [%ld ]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
                vDTrazasError(szExeAboFact, "\n\n\t** Error en UPDATE Sobre FA_CICLOCLI (IND_CAMBIO = 2) %s ** ",
                                            LOG01,SQLERRM);
                return (FALSE);
            }
            vDTrazasLog  (szExeAboFact, "\n\t** Actualiza FA_CICLOCLI  ==> IND_CAMBIO = 2 <== ",LOG03);
        }

        if (iProducto ==  stDatosGener.iProdCelular)
        {
            /* EXEC SQL   
            SELECT  COD_CLIENTE
            INTO    :lhCodClienteAux
            FROM    GA_INFACCEL
            WHERE   COD_CLIENTE  = :stpGInter->lCodCliente 
            AND     NUM_ABONADO  = :stpGInter->lNumAbonado
            AND     COD_CICLFACT = :lhCiclFactProx; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 21;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select COD_CLIENTE into :b0  from GA_INFACCEL whe\
re ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CICLFACT=:b3)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )485;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteAux;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&(stpGInter->lCodCliente);
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&(stpGInter->lNumAbonado);
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCiclFactProx;
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



            if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
            {
                vDTrazasLog(szExeAboFact, "\n\n\t  Error Al Validar Duplicidad en GA_INFACCEL"
                                            "\n\t\t==>  Cliente     [%ld]"
                                            "\n\t\t==>  Abonado     [%ld]"
                                            "\n\t\t==>  Producto    [%d ]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
                vDTrazasError(szExeAboFact, "\n\n\t  Error Al Validar Duplicidad en GA_INFACCEL"
                                            "\n\t\t==>  Cliente     [%ld]"
                                            "\n\t\t==>  Abonado     [%ld]"
                                            "\n\t\t==>  Producto    [%d ]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
                return (FALSE);
            }
            if (SQLCODE == SQLOK)
            {
                stpGInter->bOptExiste  =   TRUE    ;
                vDTrazasLog(szExeAboFact,   "\n\n\t***  Cambio de Ciclo Ya Fue Procesado"
                                    "\n\t\t==>  Cliente     [%ld]"
                                    "\n\t\t==>  Abonado     [%ld]"
                                    "\n\t\t==>  Producto    [%ld ]"
                                    "\n\t\t==>  Ciclo Nuevo [%ld ]"
                                    , LOG03, stpGInter->lCodCliente, stpGInter->lNumAbonado, 
                                    iProducto,lhCiclFactProx);

                 vPrintInconsistencia(stpGInter,INCONS032);
            }
        }

        if (iProducto ==  stDatosGener.iProdBeeper)
        {
            /* EXEC SQL   
            SELECT  COD_CLIENTE
            INTO    :lhCodClienteAux
            FROM    GA_INFACBEEP
            WHERE   COD_CLIENTE  = :stpGInter->lCodCliente
            AND     NUM_ABONADO  = :stpGInter->lNumAbonado
            AND     COD_CICLFACT = :lhCiclFactProx; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 21;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select COD_CLIENTE into :b0  from GA_INFACBEEP wh\
ere ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and COD_CICLFACT=:b3)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )516;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteAux;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&(stpGInter->lCodCliente);
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&(stpGInter->lNumAbonado);
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCiclFactProx;
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



            if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
            {
                vDTrazasLog(szExeAboFact, "\n\n\t  Error Al Validar Duplicidad en GA_INFACBEEP"
                                            "\n\t\t==>  Cliente     [%ld]"
                                            "\n\t\t==>  Abonado     [%ld]"
                                            "\n\t\t==>  Producto    [%d ]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
                vDTrazasError(szExeAboFact, "\n\n\t  Error Al Validar Duplicidad en GA_INFACBEEP"
                                            "\n\t\t==>  Cliente     [%ld]"
                                            "\n\t\t==>  Abonado     [%ld]"
                                            "\n\t\t==>  Producto    [%d ]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado,iProducto);
                return (FALSE);
            }
            if (SQLCODE == SQLOK)
            {
                stpGInter->bOptExiste  =   TRUE    ;
                vDTrazasLog(szExeAboFact,   "\n\n\t***  Cambio de Ciclo Ya Fue Procesado"
                                    "\n\t\t==>  Cliente     [%ld]"
                                    "\n\t\t==>  Abonado     [%ld]"
                                    "\n\t\t==>  Producto    [%ld ]"
                                    "\n\t\t==>  Ciclo Nuevo [%ld ]"
                                    ,LOG03, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                    ,iProducto,lhCiclFactProx);

                 vPrintInconsistencia(stpGInter,INCONS032);
            }
        }
    }

    if(stpGInter->lIndActuac != iINDACTUAC_NORMAL )
    {
/*
        if (!bRestaFechas (szhFecHoy, stpGInter->szFecBaja, &iNumDias))
            return (FALSE);
*/        
        if (!bNumPeriodosBaja( iProducto, stpGInter, &iNumDias))
            return (FALSE);
        
        /*  InumDias Corresponde a la Cantidad de Registros en Baja o Traspaso Replicados */
        
        if ( iNumDias > stDatosGener.iNumDiasBaja )
        {
            vDTrazasLog(szExeAboFact,   "\n\n\t***  Indicador de Actuacion No Replicable ***"
                                        "\n\t\t==>  Cliente             [%ld]"
                                        "\n\t\t==>  Abonado             [%ld]"
                                        "\n\t\t==>  Producto            [%ld]"
                                        "\n\t\t==>  Ind. Actuacion      [%d]"
                                        "\n\t\t==>  Fecha Baja          [%s]"
                                        "\n\t\t==>  Fecha Actual        [%s]"
                                        "\n\t\t==>  Numero de Periodos  [%d]"
                                        "\n\t\t==>  Periodos Maximos    [%d]"
                                        ,LOG05, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                        ,iProducto,stpGInter->lIndActuac
                                        ,stpGInter->szFecBaja,szhFecHoy,
                                        iNumDias,stDatosGener.iNumDiasBaja);
        /*******************************************************
            vPrintInconsistencia(stpGInter,INCONS033);
        ********************************************************/
            stpGInter->bOptExiste = TRUE;             
            if (iProducto ==  stDatosGener.iProdCelular)
                stEstadisCelu.lTotBajas++;
            else
                stEstadisBeep.lTotBajas++;
        }
    }


    /*************************************************************************/
    /* **               Verifica Si Tiene Cargos en GE_CARGOS             ** */
    /* **  Comprobamos si el cliente abonado/producto Tiene Cargos        ** */
    /* **  Pendientes de Facturar.                                        ** */
    /*************************************************************************/

    stpGInter->lIndCargos   = 0     ;
    bFinCursor              = FALSE ;

    /* EXEC SQL DECLARE cGeCargos CURSOR FOR
        SELECT  NUM_CARGO
        FROM    GE_CARGOS
        WHERE   COD_CLIENTE  = :stpGInter->lCodCliente
        AND     NUM_FACTURA  = 0; */ 


    /* EXEC SQL OPEN cGeCargos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0011;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )547;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(stpGInter->lCodCliente);
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


    if (SQLCODE)
    {    
        vDTrazasError(szExeAboFact, "\n\n\t  Error Al Abrir Cursor sobre GE_CARGOS \n %s" , LOG01, SQLERRM);
        vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Abrir Cursor sobre GE_CARGOS"
                                    "\n\t\t==>  Cliente         [%ld]"
                                    "\n\t\t==>  Abonado         [%ld]"
                                    "\n\t\t==>  Producto        [%d]"
                                    "\n\t\t==>  Fecha Actual    [%s]"
                                    "\n\t\t==>  Error           [%s]"
                                    ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                    ,iProducto, szhFecHoy, SQLERRM);
        return (FALSE);
    }
    do
    {
        /* EXEC SQL FETCH cGeCargos
                  INTO :lhNumCargo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )566;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCargo;
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


        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor = TRUE;
        }
        else
        {
            if(SQLCODE != SQLOK)
            {
                vDTrazasError(szExeAboFact, "\n\n\t  Error Fetch sobre GE_CARGOS \n %s" , LOG01, SQLERRM);
                vDTrazasLog  (szExeAboFact, "\n\n\t  Error Fetch sobre GE_CARGOS"
                                            "\n\t\t==>  Cliente         [%ld]"
                                            "\n\t\t==>  Abonado         [%ld]"
                                            "\n\t\t==>  Producto        [%d]"
                                            "\n\t\t==>  Fecha Actual    [%s]"
                                            "\n\t\t==>  Error           [%s]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                            ,iProducto, szhFecHoy, SQLERRM);
                return (FALSE);
            }
            if (lhNumCargo)
            {
               stpGInter->lIndCargos    = 1     ;
               bFinCursor               = TRUE  ;
            }
        }
    }while(!bFinCursor);

    /* EXEC SQL CLOSE cGeCargos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )585;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
         vDTrazasError(szExeAboFact, "\n\n\t  Error Al Cerrar Cursor sobre GE_CARGOS \n %s" , LOG01, SQLERRM);
         vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Cerrar Cursor sobre GE_CARGOS"
                                     "\n\t\t==>  Cliente         [%ld]"
                                     "\n\t\t==>  Abonado         [%ld]"
                                     "\n\t\t==>  Producto        [%d]"
                                     "\n\t\t==>  Fecha Actual    [%s]"
                                     "\n\t\t==>  Error           [%s]"
                                     ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                     ,iProducto, szhFecHoy, SQLERRM);
         return (FALSE);
    }

    /*************************************************************************/
    /* ** Verifica Si Tiene Cuotas en FA_CABCUOTAS                        ** */ 
    /* **  Comprobamos si el cliente abonado/producto ha cancelado todas sus cuotas.          ** */
    /*************************************************************************/
    
    stpGInter->lIndCuotas   = 0     ;
    bFinCursor              = FALSE ;

    /* EXEC SQL DECLARE cFaCabCuotas CURSOR FOR
        SELECT  IND_PAGADA
        FROM    FA_CABCUOTAS
        WHERE   COD_CLIENTE  = :stpGInter->lCodCliente
        AND     COD_PRODUCTO = :iProducto
        AND     NUM_ABONADO  = :stpGInter->lNumAbonado; */ 


    /* EXEC SQL OPEN cFaCabCuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0012;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )600;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(stpGInter->lCodCliente);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iProducto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&(stpGInter->lNumAbonado);
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


    if (SQLCODE)
    {    
        vDTrazasError(szExeAboFact, "\n\n\t  Error Al Abrir Cursor sobre FA_CABCUOTAS \n %s" , LOG01, SQLERRM);
        vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Abrir Cursor sobre FA_CABCUOTAS"
                                    "\n\t\t==>  Cliente         [%ld]"
                                    "\n\t\t==>  Abonado         [%ld]"
                                    "\n\t\t==>  Producto        [%d]"
                                    "\n\t\t==>  Fecha Actual    [%s]"
                                    "\n\t\t==>  Error           [%s]"
                                    ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                    ,iProducto, szhFecHoy, SQLERRM);
        return (FALSE);
    }
    do
    {
        /* EXEC SQL FETCH cFaCabCuotas
                  INTO :lhIndPagada; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )627;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhIndPagada;
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


        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor = TRUE;
        }
        else
        {
            if(SQLCODE != SQLOK)
            {
                vDTrazasError(szExeAboFact, "\n\n\t  Error Fetch sobre FA_CABCUOTAS \n %s" , LOG01, SQLERRM);
                vDTrazasLog  (szExeAboFact, "\n\n\t  Error Fetch sobre FA_CABCUOTAS"
                                            "\n\t\t==>  Cliente         [%ld]"
                                            "\n\t\t==>  Abonado         [%ld]"
                                            "\n\t\t==>  Producto        [%d]"
                                            "\n\t\t==>  Fecha Actual    [%s]"
                                            "\n\t\t==>  Error           [%s]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                            ,iProducto, szhFecHoy, SQLERRM);
                return (FALSE);
            }
            if (lhIndPagada != 0)
            {
               stpGInter->lIndCuotas    = 1     ;
               bFinCursor               = TRUE  ;
            }
        }
    }while(!bFinCursor);

    /* EXEC SQL CLOSE cFaCabCuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )646;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
         vDTrazasError(szExeAboFact, "\n\n\t  Error Al Cerrar Cursor sobre FA_CABCUOTAS \n %s" , LOG01, SQLERRM);
         vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Cerrar Cursor sobre FA_CABCUOTAS"
                                     "\n\t\t==>  Cliente         [%ld]"
                                     "\n\t\t==>  Abonado         [%ld]"
                                     "\n\t\t==>  Producto        [%d]"
                                     "\n\t\t==>  Fecha Actual    [%s]"
                                     "\n\t\t==>  Error           [%s]"
                                     ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                     ,iProducto, szhFecHoy, SQLERRM);
         return (FALSE);
    }

/******************************************************************************/
/* **    Verifica Si Tiene Arriendos Vigentes en FA_ARRIENDO               ** */
/* **   Comprobamos si el cliente abonado/producto tiene periodos de arriendo vigentes.    ** */
/******************************************************************************/

    stpGInter->lIndArriendo = 0     ;
    bFinCursor              = FALSE ;

    /* EXEC SQL DECLARE cFaArriendo CURSOR FOR
        SELECT TO_CHAR(FEC_DESDE,'YYYYMMDD HH24:MI:SS'),
               TO_CHAR(FEC_HASTA,'YYYYMMDD HH24:MI:SS')
          FROM FA_ARRIENDO
         WHERE COD_CLIENTE  = :stpGInter->lCodCliente
           AND COD_PRODUCTO = :iProducto
           AND NUM_ABONADO  = :stpGInter->lNumAbonado; */ 


    /* EXEC SQL OPEN cFaArriendo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0013;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )661;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(stpGInter->lCodCliente);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iProducto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&(stpGInter->lNumAbonado);
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


    if(SQLCODE)
    {
        vDTrazasError(szExeAboFact, "\n\n\t  Error Al Abrir Cursor sobre FA_ARRIENDO \n %s" , LOG01, SQLERRM);
        vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Abrir Cursor sobre FA_ARRIENDO"
                                    "\n\t\t==>  Cliente         [%ld]"
                                    "\n\t\t==>  Abonado         [%ld]"
                                    "\n\t\t==>  Producto        [%d]"
                                    "\n\t\t==>  Fecha Actual    [%s]"
                                    "\n\t\t==>  Error           [%s]"
                                    ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                    ,iProducto, szhFecHoy, SQLERRM);
        return (FALSE);
    }
    do
    {
        /* EXEC SQL FETCH cFaArriendo
                  INTO :szhFecDesde, :szhFecHasta; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )688;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[0] = (unsigned long )18;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[1] = (unsigned long )18;
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



        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor = TRUE;
        }
        else
        {
            if(SQLCODE != SQLOK)
            {
                vDTrazasError(szExeAboFact, "\n\n\t  Error Fetch sobre FA_ARRIENDO \n %s" , LOG01, SQLERRM);
                vDTrazasLog  (szExeAboFact, "\n\n\t  Error Fetch sobre FA_ARRIENDO"
                                            "\n\t\t==>  Cliente         [%ld]"
                                            "\n\t\t==>  Abonado         [%ld]"
                                            "\n\t\t==>  Producto        [%d]"
                                            "\n\t\t==>  Fecha Actual    [%s]"
                                            "\n\t\t==>  Error           [%s]"
                                            ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                            ,iProducto, szhFecHoy, SQLERRM);
                return (FALSE);
            }
            if ((strcmp(szhFecDesde, szhFecHoy) < 1 ) && (strcmp(szhFecHasta, szhFecHoy) > -1))
            {
                stpGInter->lIndArriendo = 1     ;
                bFinCursor              = TRUE  ;
            }
        }
    }while(!bFinCursor);

    /* EXEC SQL CLOSE cFaArriendo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )711;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE)
    {
         vDTrazasError(szExeAboFact, "\n\n\t  Error Al Cerrar Cursor sobre FA_ARRIENDO \n %s" , LOG01, SQLERRM);
         vDTrazasLog  (szExeAboFact, "\n\n\t  Error Al Cerrar Cursor sobre FA_ARRIENDO"
                                     "\n\t\t==>  Cliente         [%ld]"
                                     "\n\t\t==>  Abonado         [%ld]"
                                     "\n\t\t==>  Producto        [%d]"
                                     "\n\t\t==>  Fecha Actual    [%s]"
                                     "\n\t\t==>  Error           [%s]"
                                     ,LOG01, stpGInter->lCodCliente,stpGInter->lNumAbonado
                                     ,iProducto, szhFecHoy, SQLERRM);
         return (FALSE);
    }

/*****************************************************************************/
/* Salida de SetUpdate con Indicadores y Ciclos a Replicar el GA_INFACCEL    */
/*****************************************************************************/
    vDTrazasLog (szExeAboFact, "\n\n\t** Parametros de la Salida de SetUpdate  ** "
                               "\n\t\t==> Cliente              [%ld]"
                               "\n\t\t==> Abonado              [%ld]"
                               "\n\t\t==> Producto             [%d]"
                               "\n\t\t==> Fecha Actual         [%s]"
                               "\n\t\t==> Ind. Arriendo        [%ld]"
                               "\n\t\t==> Ind. Cuotas          [%ld]"
                               "\n\t\t==> Ind. Cargos          [%ld]"
                               "\n\t\t==> Codigo Ciclo Fact.   [%ld]"
                               "\n\t\t==> Codigo de Ciclo      [%ld]"
                               "\n\t\t==> SQLCODE              [%d]"
                               ,LOG05,
                               stpGInter->lCodCliente, stpGInter->lNumAbonado, iProducto, szhFecHoy,
                               stpGInter->lIndArriendo,stpGInter->lIndCuotas, stpGInter->lIndCargos,
                               stpGInter->lCodCiclFactNew,stpGInter->iCodCicloNew,
                               SQLCODE);
    return TRUE;
}/******************************* Fin SetUpdate *****************************/



/****************************************************************************/
/*                         funcion : bNumPeriodosBaja                       */
/****************************************************************************/
static BOOL bNumPeriodosBaja(int iProducto, GAINTERFACT *stpInter, int *iNumPeriodos)
{                       
    char    stGlosa[30];

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        /* EXEC SQL VAR stpInter->szFecAlta      IS STRING (15); */ 

        /* EXEC SQL VAR stpInter->szFecBaja      IS STRING (15); */ 

        int  ihNumPer = -1;
    /* EXEC SQL END DECLARE SECTION    ; */ 
                                                               
                                                               
    vDTrazasLog (szExeAboFact, "\n\n\t** Parametros de Entrada bNumPeriodosBaja **"
                               "\n\t\t==> Cliente              [%ld]"
                               "\n\t\t==> Abonado              [%ld]"
                               "\n\t\t==> Producto             [%d]"
                               "\n\t\t==> Fecha de Alta        [%s]"
                               "\n\t\t==> Fecha de Baja        [%s]"
                               ,LOG03
                               ,stpInter->lCodCliente
                               ,stpInter->lNumAbonado               
                               ,iProducto
                               ,stpInter->szFecAlta
                               ,stpInter->szFecBaja);

    if (iProducto == stDatosGener.iProdCelular )
    {
        /* EXEC SQL 
        SELECT  COUNT(COD_CICLFACT)
        INTO    :ihNumPer
        FROM    GA_INFACCEL
        WHERE   COD_CLIENTE =   :stpInter->lCodCliente   
        AND     NUM_ABONADO =   :stpInter->lNumAbonado
        AND     IND_ACTUAC  =   :stpInter->lIndActuac
        AND     FEC_BAJA    >   TO_DATE(:stpInter->szFecAlta , 'YYYYMMDDHH24MISS'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(COD_CICLFACT) into :b0  from GA_INFACCEL\
 where (((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and IND_ACTUAC=:b3) and FEC_BAJ\
A>TO_DATE(:b4,'YYYYMMDDHH24MISS'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )726;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihNumPer;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(stpInter->lCodCliente);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(stpInter->lNumAbonado);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&(stpInter->lIndActuac);
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)(stpInter->szFecAlta);
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


    }

    if (iProducto == stDatosGener.iProdBeeper )
    {
        /* EXEC SQL 
        SELECT  COUNT(COD_CICLFACT)
        INTO    :ihNumPer
        FROM    GA_INFACBEEP
        WHERE   COD_CLIENTE =   :stpInter->lCodCliente   
        AND     NUM_ABONADO =   :stpInter->lNumAbonado
        AND     IND_ACTUAC  =   :stpInter->lIndActuac
        AND     FEC_BAJA    >   TO_DATE(:stpInter->szFecAlta , 'YYYYMMDDHH24MISS'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(COD_CICLFACT) into :b0  from GA_INFACBEE\
P where (((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and IND_ACTUAC=:b3) and FEC_BA\
JA>TO_DATE(:b4,'YYYYMMDDHH24MISS'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )761;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihNumPer;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(stpInter->lCodCliente);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(stpInter->lNumAbonado);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&(stpInter->lIndActuac);
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)(stpInter->szFecAlta);
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


    }

    if(SQLCODE != SQLOK)
    {
        if (iProducto == stDatosGener.iProdCelular )
            strcpy(stGlosa,"GA_INFACCEL\0");
        if (iProducto == stDatosGener.iProdBeeper  )
            strcpy(stGlosa,"GA_INFACBEEP\0");        
            
        vDTrazasLog  (szExeAboFact, "\n\n\t** Error en Select de Bajas Sobre %s ** ", LOG01,stGlosa);
        vDTrazasError(szExeAboFact, "\n\n\t** Error en Select de Bajas Sobre %s ** "
                                    "\n\t\t==> Cliente              [%ld]"
                                    "\n\t\t==> Abonado              [%ld]"
                                    "\n\t\t==> Fecha de Alta        [%s]"
                                    "\n\t\t==> Fecha de Baja        [%s]"
                                    "\n\t\t==> Error : %s"
                                    ,LOG01
                                    ,stpInter->lCodCliente
                                    ,stpInter->lNumAbonado
                                    ,stpInter->szFecAlta
                                    ,stpInter->szFecBaja,SQLERRM);
        return (FALSE);
    }                                                                              

    vDTrazasLog (szExeAboFact, "\t\t==> Numero de Periodos   [%d]",LOG03,ihNumPer);
    *iNumPeriodos = ihNumPer;
    return (TRUE);                                    
}




/****************************************************************************/
/*                         funcion : bfnInsertInterfaz                      */
/****************************************************************************/

static BOOL bfnInsertInterfaz(int iProducto, GAINTERFACT *pstGInsert)
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        /* EXEC SQL VAR pstGInsert->szFecAlta      IS STRING (15); */ 

        /* EXEC SQL VAR pstGInsert->szFecBaja      IS STRING (15); */ 

        /* EXEC SQL VAR pstGInsert->szFecFinContra IS STRING (15); */ 

        /* EXEC SQL VAR pstGInsert->szNumTeleFija  IS STRING (16); */ 

        /* EXEC SQL VAR pstGInsert->szFecActual    IS STRING (15); */ 

    
        short i_szNumTeleFija       = (strlen(pstGInsert->szNumTeleFija)== 0 ? ORA_NULL : 0 );
        short i_slCodSupertel       = (pstGInsert->lCodSupertel         == 0 ? ORA_NULL : 0 );
        short i_slIndCargoPro       = 0;
        short i_slIndCuenControlada = 0;
        short i_slIndBloqueo        = 0;
    /* EXEC SQL END DECLARE SECTION    ; */ 
              
    char    stGlosa[30];

    /****************************************************************/
    /*  Valida si esta bloqueado de facturacion y lo actualiza como */
    /*  bloqueado                                                   */
    /****************************************************************/
    pstGInsert->lIndBloqueo = (pstGInsert->lIndBloqueo > 1?1:pstGInsert->lIndBloqueo);
    /****************************************************************/
    /* Inserta Registro Cuado No Hay Error Y No Existe Registro     */
    /****************************************************************/
    
    if (iProducto == stDatosGener.iProdCelular )
    {
        /* EXEC SQL INSERT
            INTO GA_INFACCEL (  COD_CLIENTE                     ,
                                NUM_ABONADO                     ,
                                COD_CICLFACT                    ,
                                FEC_ALTA                        ,
                                FEC_BAJA                        ,
                                NUM_CELULAR                     ,
                                IND_ACTUAC                      ,
                                FEC_FINCONTRA                   ,
                                IND_ALTA                        ,
                                IND_DETALLE                     ,
                                IND_FACTUR                      ,
                                IND_CUOTAS                      ,
                                IND_ARRIENDO                    ,
                                IND_CARGOS                      ,
                                IND_PENALIZA                    ,
                                IND_SUPERTEL                    ,
                                NUM_TELEFIJA                    ,
                                COD_SUPERTEL                    ,
                                IND_CARGOPRO                    ,
                                IND_CUENCONTROLADA              ,
                                IND_BLOQUEO                     )
                    VALUES  (   :pstGInsert->lCodCliente        ,
                                :pstGInsert->lNumAbonado        ,
                                :pstGInsert->lCodCiclFactNew    ,
                                TO_DATE(:pstGInsert->szFecAlta  ,   'YYYYMMDDHH24MISS'),
                                TO_DATE(:pstGInsert->szFecBaja  ,   'YYYYMMDDHH24MISS'),
                                :pstGInsert->lNumTerminal       ,
                                :pstGInsert->lIndActuac         ,
                                TO_DATE(:pstGInsert->szFecFinContra,'YYYYMMDDHH24MISS'),
                                :pstGInsert->lIndAlta           ,
                                :pstGInsert->lIndDetalle        ,
                                :pstGInsert->lIndFactur         ,
                                :pstGInsert->lIndCuotas         ,
                                :pstGInsert->lIndArriendo       ,
                                :pstGInsert->lIndCargos         ,
                                :pstGInsert->lIndPenaliza       ,
                                :pstGInsert->lIndSupertel       ,
                                :pstGInsert->szNumTeleFija      :i_szNumTeleFija        ,
                                :pstGInsert->lCodSupertel       :i_slCodSupertel        ,
                                :pstGInsert->lIndCargoPro       :i_slIndCargoPro        ,
                                :pstGInsert->lIndCuenControlada :i_slIndCuenControlada  , 
                                :pstGInsert->lIndBloqueo        :i_slIndBloqueo         ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into GA_INFACCEL (COD_CLIENTE,NUM_ABONADO,COD_\
CICLFACT,FEC_ALTA,FEC_BAJA,NUM_CELULAR,IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,IND_D\
ETALLE,IND_FACTUR,IND_CUOTAS,IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,IND_SUPERTEL\
,NUM_TELEFIJA,COD_SUPERTEL,IND_CARGOPRO,IND_CUENCONTROLADA,IND_BLOQUEO) values\
 (:b0,:b1,:b2,TO_DATE(:b3,'YYYYMMDDHH24MISS'),TO_DATE(:b4,'YYYYMMDDHH24MISS'),\
:b5,:b6,TO_DATE(:b7,'YYYYMMDDHH24MISS'),:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,\
:b16:b17,:b18:b19,:b20:b21,:b22:b23,:b24:b25)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )796;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&(pstGInsert->lCodCliente);
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(pstGInsert->lNumAbonado);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(pstGInsert->lCodCiclFactNew);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)(pstGInsert->szFecAlta);
        sqlstm.sqhstl[3] = (unsigned long )15;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)(pstGInsert->szFecBaja);
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&(pstGInsert->lNumTerminal);
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&(pstGInsert->lIndActuac);
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)(pstGInsert->szFecFinContra);
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&(pstGInsert->lIndAlta);
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&(pstGInsert->lIndDetalle);
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&(pstGInsert->lIndFactur);
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&(pstGInsert->lIndCuotas);
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&(pstGInsert->lIndArriendo);
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&(pstGInsert->lIndCargos);
        sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&(pstGInsert->lIndPenaliza);
        sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&(pstGInsert->lIndSupertel);
        sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)(pstGInsert->szNumTeleFija);
        sqlstm.sqhstl[16] = (unsigned long )16;
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)&i_szNumTeleFija;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&(pstGInsert->lCodSupertel);
        sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)&i_slCodSupertel;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)&(pstGInsert->lIndCargoPro);
        sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[18] = (         int  )0;
        sqlstm.sqindv[18] = (         short *)&i_slIndCargoPro;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)&(pstGInsert->lIndCuenControlada);
        sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[19] = (         int  )0;
        sqlstm.sqindv[19] = (         short *)&i_slIndCuenControlada;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)&(pstGInsert->lIndBloqueo);
        sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[20] = (         int  )0;
        sqlstm.sqindv[20] = (         short *)&i_slIndBloqueo;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
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
    
    if (iProducto == stDatosGener.iProdBeeper )
    {
        /* EXEC SQL INSERT
            INTO GA_INFACBEEP(  COD_CLIENTE                     ,
                                NUM_ABONADO                     ,
                                COD_CICLFACT                    ,
                                FEC_ALTA                        ,
                                FEC_BAJA                        ,
                                NUM_BEEPER                      ,
                                IND_ACTUAC                      ,
                                FEC_FINCONTRA                   ,
                                IND_ALTA                        ,
                                IND_DETALLE                     ,
                                IND_FACTUR                      ,
                                IND_CUOTAS                      ,
                                IND_ARRIENDO                    ,
                                IND_CARGOS                      ,
                                IND_PENALIZA                    ,
/o                              IND_SUPERTEL                    ,
                                NUM_TELEFIJA                    ,
                                COD_SUPERTEL                    ,
o/                              IND_CARGOPRO                    ,
                                IND_CUENCONTROLADA              ,
                                IND_BLOQUEO                     )
                    VALUES  (   :pstGInsert->lCodCliente        ,
                                :pstGInsert->lNumAbonado        ,
                                :pstGInsert->lCodCiclFactNew    ,
                                TO_DATE(:pstGInsert->szFecAlta  ,   'YYYYMMDDHH24MISS'),
                                TO_DATE(:pstGInsert->szFecBaja  ,   'YYYYMMDDHH24MISS'),
                                :pstGInsert->lNumTerminal       ,
                                :pstGInsert->lIndActuac         ,
                                TO_DATE(:pstGInsert->szFecFinContra,'YYYYMMDDHH24MISS'),
                                :pstGInsert->lIndAlta           ,
                                :pstGInsert->lIndDetalle        ,
                                :pstGInsert->lIndFactur         ,
                                :pstGInsert->lIndCuotas         ,
                                :pstGInsert->lIndArriendo       ,
                                :pstGInsert->lIndCargos         ,
                                :pstGInsert->lIndPenaliza       ,
/o                              :pstGInsert->lIndSupertel       ,
                                :pstGInsert->szNumTeleFija      :i_szNumTeleFija        ,
                                :pstGInsert->lCodSupertel       :i_slCodSupertel        ,
o/                              :pstGInsert->lIndCargoPro       :i_slIndCargoPro        ,
                                :pstGInsert->lIndCuenControlada :i_slIndCuenControlada  , 
                                :pstGInsert->lIndBloqueo        :i_slIndBloqueo         ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into GA_INFACBEEP (COD_CLIENTE,NUM_ABONADO,COD\
_CICLFACT,FEC_ALTA,FEC_BAJA,NUM_BEEPER,IND_ACTUAC,FEC_FINCONTRA,IND_ALTA,IND_D\
ETALLE,IND_FACTUR,IND_CUOTAS,IND_ARRIENDO,IND_CARGOS,IND_PENALIZA,IND_CARGOPRO\
,IND_CUENCONTROLADA,IND_BLOQUEO) values (:b0,:b1,:b2,TO_DATE(:b3,'YYYYMMDDHH24\
MISS'),TO_DATE(:b4,'YYYYMMDDHH24MISS'),:b5,:b6,TO_DATE(:b7,'YYYYMMDDHH24MISS')\
,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15:b16,:b17:b18,:b19:b20)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )895;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&(pstGInsert->lCodCliente);
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&(pstGInsert->lNumAbonado);
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&(pstGInsert->lCodCiclFactNew);
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)(pstGInsert->szFecAlta);
        sqlstm.sqhstl[3] = (unsigned long )15;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)(pstGInsert->szFecBaja);
        sqlstm.sqhstl[4] = (unsigned long )15;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&(pstGInsert->lNumTerminal);
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&(pstGInsert->lIndActuac);
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)(pstGInsert->szFecFinContra);
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&(pstGInsert->lIndAlta);
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&(pstGInsert->lIndDetalle);
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&(pstGInsert->lIndFactur);
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&(pstGInsert->lIndCuotas);
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&(pstGInsert->lIndArriendo);
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&(pstGInsert->lIndCargos);
        sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&(pstGInsert->lIndPenaliza);
        sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&(pstGInsert->lIndCargoPro);
        sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)&i_slIndCargoPro;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)&(pstGInsert->lIndCuenControlada);
        sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[16] = (         int  )0;
        sqlstm.sqindv[16] = (         short *)&i_slIndCuenControlada;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)&(pstGInsert->lIndBloqueo);
        sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[17] = (         int  )0;
        sqlstm.sqindv[17] = (         short *)&i_slIndBloqueo;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
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
                                                                                        
    if(SQLCODE != SQLOK)
    {
        if (iProducto == stDatosGener.iProdCelular )
            strcpy(stGlosa,"GA_INFACCEL\0");
        if (iProducto == stDatosGener.iProdBeeper  )
            strcpy(stGlosa,"GA_INFACBEEP\0");        
            
        vDTrazasLog  (szExeAboFact, "\n\n\t** Error en Insert Sobre %s ** ", LOG01,stGlosa);
        vDTrazasError(szExeAboFact, "\n\n\t** Error en Insert Sobre %s ** "
                                    "\n\t\t==>COD_CLIENTE   : [%d]"
                                    "\n\t\t==>NUM_ABONADO   : [%d]"
                                    "\n\t\t==>COD_CICLFACT  : [%d]"
                                    "\n\t\t==>FEC_ALTA      : [%s]"
                                    "\n\t\t==>FEC_BAJA      : [%s]"
                                    "\n\t\t==>NUM_CELULAR   : [%d]"
                                    "\n\t\t==>IND_ACTUAC    : [%d]"
                                    "\n\t\t==>FEC_FINCONTRA : [%s]"
                                    "\n\t\t==>IND_ALTA      : [%d]"
                                    "\n\t\t==>IND_DETALLE   : [%d]"
                                    "\n\t\t==>IND_FACTUR    : [%d]"
                                    "\n\t\t==>IND_CUOTAS    : [%d]"
                                    "\n\t\t==>IND_ARRIENDO  : [%d]"
                                    "\n\t\t==>IND_CARGOS    : [%d]"
                                    "\n\t\t==>IND_PENALIZA  : [%d]"
                                    "\n\t\t==>IND_SUPERTEL  : [%d]"
                                    "\n\t\t==>NUM_TELEFIJA  : [%s]"
                                    "\n\t\t==>COD_OPERADOR  : [%d]"
                                    "\n\t\t==>IND_CARGOPRO  : [%d]"
                                    "\n\t\t==>IND_CUENCONT  : [%d]"
                                    "\n\t\t==>IND_BLOQUEO   : [%d]"
                                    "\n\t\t==>ERROR :%d %s", LOG01, stGlosa,
                                    pstGInsert->lCodCliente         ,    
                                    pstGInsert->lNumAbonado         ,    
                                    pstGInsert->lCodCiclFactNew     ,    
                                    pstGInsert->szFecAlta           ,
                                    pstGInsert->szFecBaja           ,
                                    pstGInsert->lNumTerminal        ,    
                                    pstGInsert->lIndActuac          ,    
                                    pstGInsert->szFecFinContra      ,
                                    pstGInsert->lIndAlta            ,    
                                    pstGInsert->lIndDetalle         ,    
                                    pstGInsert->lIndFactur          ,    
                                    pstGInsert->lIndCuotas          ,    
                                    pstGInsert->lIndArriendo        ,    
                                    pstGInsert->lIndCargos          ,    
                                    pstGInsert->lIndPenaliza        ,    
                                    pstGInsert->lIndSupertel        ,    
                                    pstGInsert->szNumTeleFija       ,
                                    pstGInsert->lCodSupertel        ,
                                    pstGInsert->lIndCargoPro        ,
                                    pstGInsert->lIndCuenControlada  ,
                                    pstGInsert->lIndBloqueo         ,
                                    SQLCODE, SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/************************** Final bfnInsertInterfaz  ************************/




/********************************************************************************/
/* vValSTB : Valida Datos de Supertelefono                                      */
/********************************************************************************/

static void vValSTB(GAINTERFACT * pstGInterfaz)
{
    /*************************************************************/
    /*                     Validacion de STB                     */
    /*************************************************************/

    vDTrazasLog  (szExeAboFact, "\n\t\t** Valida STB  **          "
                                "\n\t\t==> Codigo de Ciclo        [%d]    "
                                "\n\t\t==> Ind. Supertel          [%ld]   "
                                "\n\t\t==> Cod. Supertel          [%ld]   "
                                "\n\t\t==> Num. Telefija          [%s]    ",LOG05,
                                pstGInterfaz->iCodCicloNew,
                                pstGInterfaz->lIndSupertel,
                                pstGInterfaz->lCodSupertel,
                                pstGInterfaz->szNumTeleFija);

    if(pstGInterfaz->iCodCicloNew == lhCodCicloSTM)             /*  El Ciclo es STB                     */
    {
        if (pstGInterfaz->lIndSupertel == 1)                    /*  El Abonado es STB                   */
        {
            if(strlen(pstGInterfaz->szNumTeleFija)==0)          /*  No Tiene Telefono de Red Fija        */
                vPrintInconsistencia(pstGInterfaz,INCONS001);

            if(pstGInterfaz->lCodSupertel == 0)                 /*  No Tiene Operador de Red Fija       */
                vPrintInconsistencia(pstGInterfaz,INCONS002);

        }                                                       /*  El Ciclo es STB                     */
        else                                                    /*  El Abonado No es STB                */
        {
            if(strlen(pstGInterfaz->szNumTeleFija) > 0)         /*  Tiene Telefono de Red Fija          */
                vPrintInconsistencia(pstGInterfaz,INCONS003);

            if(pstGInterfaz->lCodSupertel != 0)                 /*  Tiene Operador de Red Fija          */
                vPrintInconsistencia(pstGInterfaz,INCONS004);
        }
    }
    else                                                        /*  El Ciclo No es STB                  */
    {
        if (pstGInterfaz->lIndSupertel == 1)                    /*  El Abonado es STB                   */
        {
            vPrintInconsistencia(pstGInterfaz,INCONS005);
            
            if(strlen(pstGInterfaz->szNumTeleFija) > 0)         /*  Tiene Telefono de Red Fija           */
                vPrintInconsistencia(pstGInterfaz,INCONS006);

            if(pstGInterfaz->lCodSupertel != 0)                 /*  Tiene Operador de Red Fija          */
                vPrintInconsistencia(pstGInterfaz,INCONS007);

            pstGInterfaz->lIndSupertel = 0           ;
            strcpy(pstGInterfaz->szNumTeleFija,"\0") ;
            pstGInterfaz->lCodSupertel = 0           ;
        }                                                       /*  El Ciclo No es STB                  */
        else                                                    /*  El Abonado No es STB                */
        {
            if(strlen(pstGInterfaz->szNumTeleFija) > 0)         /*  Tiene Telefono de Red Fija          */
                vPrintInconsistencia(pstGInterfaz,INCONS008);
    
            if(pstGInterfaz->lCodSupertel != 0)                 /*  Tiene Operador de Red Fija          */
                vPrintInconsistencia(pstGInterfaz,INCONS009);

        }
    }
    return;
}


/************************************************************************************/
/*   Funcion bfnCambCicloClientes(long lCodCliente)                                 */
/*  Actualiza el codigo de ciclo del cliente si tiene valor distinto de nulo en     */
/*  el campo Cod_CicloNue, dejandolo en nulo despues del Update                     */
/************************************************************************************/
static BOOL bfnCambCicloCliente(long lCodCliente)
{                       
                                                               
    vDTrazasLog (szExeAboFact, "\n\n\t** Parametros de Entrada bfnCambCicloCliente **"
                               "\n\t\t==> Cliente              [%ld]" ,LOG03,lCodCliente);

    /* EXEC SQL 
        UPDATE  GE_CLIENTES
        SET     COD_CICLO    = COD_CICLONUE,
                COD_CICLONUE = NULL
        WHERE   COD_CLIENTE  = :lCodCliente
        AND     COD_CICLONUE IS NOT NULL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 21;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update GE_CLIENTES  set COD_CICLO=COD_CICLONUE,COD_CICLON\
UE=null  where (COD_CLIENTE=:b0 and COD_CICLONUE is  not null )";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )982;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (szExeAboFact, "\n\t** Error en Update de Ciclo en GE_CLIENTES ** "
                                    "\n\t\t\t=>  Cliente    [%ld] "
                                    "\n\t\t\t=>  Errror     [%d] [%s]"
                                    ,LOG01,lCodCliente,SQLCODE,SQLERRM);
        vDTrazasError(szExeAboFact, "\n\t** Error en Update de Ciclo en GE_CLIENTES ** "
                                    "\n\t\t\t=>  Cliente    [%ld] "
                                    "\n\t\t\t=>  Errror     [%d] [%s]"
                                    ,LOG01,lCodCliente,SQLCODE,SQLERRM);
        return (FALSE);
    }
    if (SQLCODE == SQLOK)
        vDTrazasLog (szExeAboFact,  "\n\n\t** Ciclo Actualizado ==> Cliente   [%ld] **" ,LOG03,lCodCliente);

    return (TRUE);                                    
}




/********************************************************************************/
/* vValCargoPro : Valida Datos Ind_CargoPro e Ind_CuenControlada                */
/********************************************************************************/

static void vValCargoPro (GAINTERFACT * pstGInterfaz)
{

    /**************************************************************/
    /*     Validacion de CUENTACONTROLADA - CARGOPROD             */
    /**************************************************************/
    if(pstGInterfaz->lIndCargoPro == 0 && pstGInterfaz->lIndCuenControlada == 0 )
        vPrintInconsistencia(pstGInterfaz,INCONS021);

    if(pstGInterfaz->lIndCargoPro == 1 && pstGInterfaz->lIndCuenControlada == 1 )
        vPrintInconsistencia(pstGInterfaz,INCONS022);

    return;
}


/********************************************************************************/
/* vPrintInconsistencia : Escribe la Incosistencia en Archivo AboFact_Inconsis% */
/********************************************************************************/

static void vPrintInconsistencia (GAINTERFACT *stpGI, char *szGlosa)
{
    fprintf(    stLineaComando.InconsFile,"%10ld %10ld %5d %10ld %10ld %-60s\n",
                stpGI->lCodCliente,
                stpGI->lNumAbonado,
                stpGI->iCodProducto,
                stpGI->lCodCiclFact,
                stpGI->lCodCiclFactNew,
                szGlosa);
    fflush(stLineaComando.InconsFile);
    return;
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

