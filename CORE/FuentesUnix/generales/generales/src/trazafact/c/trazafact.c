
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
    "./pc/trazafact.pc"
};


static unsigned int sqlctx = 6936203;


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

 static const char *sq0002 = 
"select PROC.DES_PROCESO ,PROC.COD_PROCPREC ,PROC.DES_PROCPREC ,PROC.COD_ESTA\
PREC ,NVL(TRAZ.COD_ESTAPROC,:b0) ,TRAZ.FEC_INICIO ,TRAZ.FEC_TERMINO  from FA_T\
RAZAPROC TRAZ ,(select A.COD_PROCESO COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A\
.COD_PROCPREC COD_PROCPREC ,C.DES_PROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_EST\
APREC  from FA_PROCFACTPREC A ,FA_PROCFACT B ,FA_PROCFACT C where ((A.COD_PROC\
ESO=:b1 and A.COD_PROCESO=B.COD_PROCESO) and A.COD_PROCPREC=C.COD_PROCESO)) PR\
OC where (TRAZ.COD_CICLFACT(+)=:b2 and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) \
order by PROC.COD_PROCESO            ";

 static const char *sq0008 = 
"select PROC.DES_PROCESO ,PROC.COD_PROCPREC ,PROC.DES_PROCPREC ,PROC.COD_ESTA\
PREC ,NVL(TRAZ.COD_ESTAPROC,:b0)  from FA_TRAZAPROC TRAZ ,(select A.COD_PROCES\
O COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A.COD_PROCPREC COD_PROCPREC ,C.DES_P\
ROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_ESTAPREC  from FA_PROCFACTPREC A ,FA_P\
ROCFACT B ,FA_PROCFACT C where ((A.COD_PROCESO=:b1 and A.COD_PROCESO=B.COD_PRO\
CESO) and A.COD_PROCPREC=C.COD_PROCESO)) PROC where ((TRAZ.COD_CICLFACT(+)=:b2\
 and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) and NVL(TRAZ.HOST_ID,:b3)=:b3) ord\
er by PROC.COD_PROCESO            ";

 static const char *sq0012 = 
"select PROC.DES_PROCESO ,PROC.COD_PROCPREC ,PROC.DES_PROCPREC ,PROC.COD_ESTA\
PREC ,NVL(TRAZ.COD_ESTAPROC,:b0)  from FA_TRAZAPROC TRAZ ,(select A.COD_PROCES\
O COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A.COD_PROCPREC COD_PROCPREC ,C.DES_P\
ROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_ESTAPREC  from FA_PROCFACTPREC A ,FA_P\
ROCFACT B ,FA_PROCFACT C where ((A.COD_PROCESO=:b1 and A.COD_PROCESO=B.COD_PRO\
CESO) and A.COD_PROCPREC=C.COD_PROCESO)) PROC where (TRAZ.COD_CICLFACT(+)=:b2 \
and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) order by PROC.COD_PROCESO          \
  ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,130,0,4,79,0,0,6,3,0,1,0,1,5,0,0,1,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,
0,
44,0,0,2,581,0,9,154,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
71,0,0,2,0,0,13,174,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
106,0,0,2,0,0,15,210,0,0,0,0,0,1,0,
121,0,0,3,192,0,4,220,0,0,4,2,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
152,0,0,4,170,0,3,281,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
195,0,0,5,270,0,4,372,0,0,9,2,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,
246,0,0,6,239,0,5,537,0,0,9,9,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
297,0,0,7,130,0,4,646,0,0,6,3,0,1,0,1,5,0,0,1,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,
3,0,0,
336,0,0,8,578,0,9,725,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
371,0,0,8,0,0,13,745,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
406,0,0,8,0,0,15,781,0,0,0,0,0,1,0,
421,0,0,9,221,0,4,791,0,0,5,3,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
456,0,0,10,188,0,3,854,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,5,0,0,
503,0,0,11,130,0,4,955,0,0,6,3,0,1,0,1,5,0,0,1,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,
3,0,0,
542,0,0,12,546,0,9,1033,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
569,0,0,12,0,0,13,1053,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
604,0,0,12,0,0,15,1089,0,0,0,0,0,1,0,
619,0,0,13,221,0,4,1099,0,0,5,3,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
654,0,0,14,188,0,3,1162,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,5,0,0,
701,0,0,15,261,0,4,1252,0,0,12,5,0,1,0,1,5,0,0,1,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
764,0,0,16,240,0,5,1419,0,0,10,10,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
819,0,0,17,120,0,4,1500,0,0,4,2,0,1,0,2,3,0,0,2,3,0,0,1,3,0,0,1,5,0,0,
};


/****************************************************************************/
/* Funcion     : trazafact.pc                                               */
/* Descripcion : Declaracion de funciones para Trazas de Facturacion        */
/* Autor       : Mauricio Villagra Villaobos                                */
/* Fecha       : 24-05-1999                                                 */
/*****************************************************************************/
/* Modificaciones :                                                         */
/*  03-11-1999 : Se modifica funcionalidad de verificacion de procesos pre- */
/*           cedentes ya que se creo la tabla FA_PROCFACTPREC que detalla   */
/*           los procesos precedentes por cada proceso de facturacion, lo   */
/*           que permite definir mas de un proceso precedente para un       */
/*           proceso especifico                                             */
/*                                                                          */
/****************************************************************************/
#define _TRAZAFACT_PC_

#include "errores.h"
#include "trazafact.h"
#include <ctype.h>

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



/****************************************************************************/
/*   funcion BOOL bfnValidaTrazaProc(long CicloFact, long CodProceso)       */
/****************************************************************************/
/*   Proceso que valida condiciones para cargar el trafico del ciclo a      */
/*  facturar en tabla de proceso, controla puntos de retoma.                */
/****************************************************************************/
BOOL bfnValidaTrazaProc(long lCiclParam,int iCodProceso, int iIndFacturacion)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long lhCiclParam            ;
    int  ihIndFacturacion       ;
    char szFecHastaLlam   [15]  ;   /* EXEC SQL VAR szFecHastaLlam     IS STRING(15); */ 

    char szFecActual      [15]  ;   /* EXEC SQL VAR szFecActual        IS STRING(15); */ 


    int  ihCodProceso           ;
    char szhDesProceso    [30]  ;   /* EXEC SQL VAR szhDesProceso      IS STRING(30); */ 

    int  ihCodProcesoPrec       ;
    char szhDesProcesoPrec[30]  ;   /* EXEC SQL VAR szhDesProcesoPrec  IS STRING(30); */ 

    int  ihCodEstaPrec          ;
    int  ihTrazCodEstaProc      ;

    int  ihTrazCodEstaActual;

    int  ihCero                 ;
    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

    char szhChar1         [51]  ; /* EXEC SQL VAR szhChar1  IS STRING(51); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    BOOL bFinCursor_cFaProcTraza=FALSE;
    static char szExeProceso[1024]="bfnValidaTrazaProc";


    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada bfnValidaTrazaProc  **"
                                "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                "\n\t\t=>  Codigo de Proceso        [%d]\n"
                                ,LOG03,lCiclParam,iCodProceso);


    /****************************************************************************/
    /*   Selecciona el Codigo de Ciclo,IND_FACTURACION y la Fecha del Sistema   */
    /****************************************************************************/
    /****************************************************************************/
    /*  Validar Estado de IND_FACTURACION = iIND_FACT_ENPROCESO                 */
    /*  Debe estar marcado como EN PROCESO.  Marcado previamnete por el         */
    /*  proceso de creacion de mascara.                                         */
    /****************************************************************************/
    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando FA_CILCFACT  **",LOG03);

    ihCero = 0;
    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

    lhCiclParam     = lCiclParam                                ;

    /* EXEC SQL SELECT IND_FACTURACION                             ,
                    TO_CHAR(FEC_HASTALLAM,:szhFmtFecha)   ,
                    TO_CHAR(SYSDATE,:szhFmtFecha)
             INTO   :ihIndFacturacion                           ,
                    :szFecHastaLlam                             ,
                    :szFecActual
             FROM   FA_CICLFACT
             WHERE  COD_CICLFACT = :lhCiclParam                 ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_FACTURACION ,TO_CHAR(FEC_HASTALLAM,:b0) ,TO_CH\
AR(SYSDATE,:b0) into :b2,:b3,:b4  from FA_CICLFACT where COD_CICLFACT=:b5";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFacturacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szFecHastaLlam;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szFecActual;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCiclParam;
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




    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  No Existen Datos en FA_CICLFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  No Existen Datos en FA_CICLFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error en Select sobre FA_CILCFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  Error en Select sobre FA_CILCFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }


    if (ihIndFacturacion != iIndFacturacion)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
                                    "\n\t\t=>  Cod_CiclFact                 [%ld]"
                                    "\n\t\t=>  Ind_Facturacion Actual       [%d]"
                                    "\n\t\t=>  Ind_Facturacion Necesario    [%d]"
                                    ,LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);
        vDTrazasError(szExeProceso, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
                                    "\n\t\t=>  Cod_CiclFact                 [%ld]"
                                    "\n\t\t=>  Ind_Facturacion Actual       [%d]"
                                    "\n\t\t=>  Ind_Facturacion Necesario    [%d]"
                                    ,LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);
        return (FALSE);
    }
    /****************************************************************************/
    /*  Selecciona las Condiciones de Procesos Precedentes en la tabla de       */
    /*  de descripcion de procesos FA_PROCFACT y tabla de traza de Procso       */
    /*  FA_TRAZAPROC que contiene la definicion de los procesos de Facturacion  */
    /*  ejecutados.                                                             */
    /****************************************************************************/
    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando Procesos Precedentes en FA_TRAZAPROC - FA_PROCFACT **",LOG03);
    ihCodProceso    = iCodProceso               ;

    /* EXEC SQL DECLARE cFaProcTraza CURSOR FOR
        SELECT  PROC.DES_PROCESO,
                PROC.COD_PROCPREC,
                PROC.DES_PROCPREC,
                PROC.COD_ESTAPREC,
                NVL(TRAZ.COD_ESTAPROC,:ihCero),
                TRAZ.FEC_INICIO,
                TRAZ.FEC_TERMINO
        FROM    FA_TRAZAPROC  TRAZ,
                (SELECT A.COD_PROCESO   COD_PROCESO,
                        B.DES_PROCESO   DES_PROCESO,
                        A.COD_PROCPREC  COD_PROCPREC,
                        C.DES_PROCESO   DES_PROCPREC,
                        A.COD_ESTAPREC  COD_ESTAPREC
                FROM    FA_PROCFACTPREC A ,
                        FA_PROCFACT B ,
                        FA_PROCFACT C
                WHERE   A.COD_PROCESO  = :ihCodProceso
                AND     A.COD_PROCESO  = B.COD_PROCESO
                AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
        WHERE   TRAZ.COD_CICLFACT (+)  = :lhCiclParam
        AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
        ORDER BY PROC.COD_PROCESO; */ 


    /* EXEC SQL OPEN cFaProcTraza; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )44;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        return (FALSE);
    }
    /****************************************************************************/
    bFinCursor_cFaProcTraza = FALSE ;
    do
    {
        /* EXEC SQL FETCH cFaProcTraza INTO
                    :szhDesProceso          ,
                    :ihCodProcesoPrec       ,
                    :szhDesProcesoPrec      ,
                    :ihCodEstaPrec          ,
                    :ihTrazCodEstaProc      ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )71;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhDesProceso;
        sqlstm.sqhstl[0] = (unsigned long )30;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProcesoPrec;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhDesProcesoPrec;
        sqlstm.sqhstl[2] = (unsigned long )30;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodEstaPrec;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihTrazCodEstaProc;
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
}



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szExeProceso, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            vDTrazasError(szExeProceso, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor_cFaProcTraza = TRUE;
        }
        else
        {
            /****************************************************************************/
            /*  Valida que el Estado del Proceso Precedente este Actualizado en la      */
            /*  tabla de Traza  FA_TRAZAPROC.                                           */
            /****************************************************************************/
            if(ihCodEstaPrec != ihTrazCodEstaProc)
            {
                vDTrazasLog  (szExeProceso, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
                                            ,LOG01, szhDesProcesoPrec, szhDesProceso);
                vDTrazasError(szExeProceso, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
                                            ,LOG01, szhDesProcesoPrec, szhDesProceso);
                return(FALSE);
            }
        }
    } while(!bFinCursor_cFaProcTraza);

    /* EXEC SQL CLOSE cFaProcTraza; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )106;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /****************************************************************************/
    /*  Valida Condiciones del Mismo Proceso.                                   */
    /*  Valida si puede Retomar el Proceso o simplemente iniciar por primera vez*/
    /****************************************************************************/

    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando Proceso Actual en FA_TRAZAPROC  **",LOG03);
    ihCodProceso    = iCodProceso               ;

    /* EXEC SQL    SELECT  TRAZ.COD_ESTAPROC   ,PROC.DES_PROCESO
                INTO   :ihTrazCodEstaActual ,:szhDesProceso
                FROM   FA_TRAZAPROC    TRAZ ,
                       FA_PROCFACT     PROC
                WHERE  TRAZ.COD_CICLFACT = :lhCiclParam
                AND    TRAZ.COD_PROCESO  = :ihCodProceso
                AND    TRAZ.COD_PROCESO  = PROC.COD_PROCESO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TRAZ.COD_ESTAPROC ,PROC.DES_PROCESO into :b0,:b1  \
from FA_TRAZAPROC TRAZ ,FA_PROCFACT PROC where ((TRAZ.COD_CICLFACT=:b2 and TRA\
Z.COD_PROCESO=:b3) and TRAZ.COD_PROCESO=PROC.COD_PROCESO)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )121;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTrazCodEstaActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[1] = (unsigned long )30;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProceso;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
                                    "\n\t\t=>  Proceso                      [%d]"
                                    "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                    ,LOG01,iCodProceso,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
                                    "\n\t\t=>  Proceso                      [%d]"
                                    "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                    ,LOG01,iCodProceso,lCiclParam);

        return (FALSE);
    }
    if (SQLCODE == SQLOK)
    {
        /****************************************************************************/
        /*  Valida que el Proceso Este Terminado Ok                                 */
        /****************************************************************************/
        if(ihTrazCodEstaActual == iPROC_EST_OK)
        {
            vDTrazasLog  (szExeProceso, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
                                        "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                        "\n\t\t=>  Codigo de Proceso            [%d]"
                                        "\n\t\t=>  Estado de Proceso            [%d]"
                                        ,LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
            vDTrazasError(szExeProceso, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
                                        "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                        "\n\t\t=>  Codigo de Proceso            [%d]"
                                        "\n\t\t=>  Estado de Proceso            [%d]"
                                        ,LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
            return(FALSE);
        }

        vDTrazasLog  (szExeProceso, "\n\t**  Retomando Proceso  %s **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    "\n\t\t=>  Estado del Proceso       [%d]\n"
                                    ,LOG03,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);

    }
    if (SQLCODE == SQLNOTFOUND)
    {
        /****************************************************************************/
        /*   Proceso NO se ha ejecutado aun para el ciclo de Facturacion.           */
        /*   Inserta Registro en la Tabla de Traza                                  */
        /****************************************************************************/
        ihTrazCodEstaActual = iPROC_EST_RUN;
        vDTrazasLog  (szExeProceso, "\n\t**  Insertando Proceso de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]\n"
                                    ,LOG03,lCiclParam,iCodProceso);

		sprintf (szhChar1, "Proceso Iniciado");
        /* EXEC SQL INSERT INTO
                FA_TRAZAPROC(   COD_CICLFACT        ,
                                COD_PROCESO         ,
                                COD_ESTAPROC        ,
                                FEC_INICIO          ,
                                GLS_PROCESO         ,
                                COD_CLIENTE         ,
                                NUM_ABONADO         ,
                                NUM_REGISTROS       )
                VALUES      (   :lhCiclParam        ,
                                :ihCodProceso       ,
                                :ihTrazCodEstaActual,
                                sysdate             ,
                                :szhChar1		    ,
                                :ihCero             ,
                                :ihCero             ,
                                :ihCero             ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FA_TRAZAPROC (COD_CICLFACT,COD_PROCESO,CO\
D_ESTAPROC,FEC_INICIO,GLS_PROCESO,COD_CLIENTE,NUM_ABONADO,NUM_REGISTROS) value\
s (:b0,:b1,:b2,sysdate,:b3,:b4,:b4,:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )152;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclParam;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihTrazCodEstaActual;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhChar1;
        sqlstm.sqhstl[3] = (unsigned long )51;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihCero;
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


        if ((SQLCODE != SQLOK) && (SQLCODE != SQLUKCONSTRAINT))
        {
            vDTrazasLog  (szExeProceso, "\n\t\t**  Error Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  Error Oracle  %s              "
                                        ,LOG01,iCodProceso,lCiclParam,SQLERRM);
            vDTrazasError(szExeProceso, "\n\t\t**  Error Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  Error Oracle  %s              "
                                        ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        }
        else
        {
        	if (SQLCODE == SQLUKCONSTRAINT)
        	{
	            vDTrazasLog  (szExeProceso, "\n\t\t**  Warning Insertando Proceso [%d]"
	                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
	                                        "\n\t\t=>  El registro ya existía!!!     "
	                                        ,LOG01,iCodProceso,lCiclParam);
	            vDTrazasError(szExeProceso, "\n\t\t**  Warning Insertando Proceso [%d]"
	                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
	                                        "\n\t\t=>  El registro ya existía!!!     "
	                                        ,LOG01,iCodProceso,lCiclParam);
            return (FALSE);
			}
        }
    }
    return (TRUE);
}/**********************   fin  bfnValidaTrazaProc  **************************/




/****************************************************************************/
/*   funcion BOOL bfnSelectTrazaProc (stTrazaProc *)                        */
/****************************************************************************/
/*   Rutina que Selecciona datos des Tabla de Traza de Procesos en la       */
/*   estructura stTrazaProc                                                 */
/****************************************************************************/
BOOL bfnSelectTrazaProc (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long    lhCodCiclfact       ;
    int     ihCodProceso        ;
    int     ihCodEstaProc       ;
    char    szhFecInicio[15]    ;   /* EXEC SQL VAR szhFecInicio       IS STRING(15); */ 

    char    szhFecTermino[15]   ;   /* EXEC SQL VAR szhFecTermino      IS STRING(15); */ 

    char    szhGlsProceso[50]   ;   /* EXEC SQL VAR szhGlsProceso      IS STRING(50); */ 

    long    lhCodCliente        ;
    long    lhNumAbonado        ;
    long    lhNumRegistros      ;

    short   i_szhFecTermino     ;
    short   i_szhGlsProceso     ;
    short   i_lhCodCliente      ;
    short   i_lhNumAbonado      ;
    short   i_lhNumRegistros    ;

    /* EXEC SQL END DECLARE SECTION  ; */ 


    static char szExeProceso[1024]="bfnSelectTrazaProc"     ;

    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada a (bfnSelectTrazaProc) **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    ,LOG05,lCicloFac,iCodProc);


    lhCodCiclfact       = lCicloFac                         ;
    ihCodProceso        = iCodProc                          ;


    /* EXEC SQL    SELECT  COD_ESTAPROC                        ,
                        TO_CHAR(FEC_INICIO ,'yyyymmddhh24miss'),
                        TO_CHAR(FEC_TERMINO,'yyyymmddhh24miss'),
                        GLS_PROCESO                         ,
                        COD_CLIENTE                         ,
                        NUM_ABONADO                         ,
                        NUM_REGISTROS
                INTO    :ihCodEstaProc                      ,
                        :szhFecInicio                       ,
                        :szhFecTermino     :i_szhFecTermino ,
                        :szhGlsProceso     :i_szhGlsProceso ,
                        :lhCodCliente      :i_lhCodCliente  ,
                        :lhNumAbonado      :i_lhNumAbonado  ,
                        :lhNumRegistros    :i_lhNumRegistros
                FROM    FA_TRAZAPROC
                WHERE   COD_CICLFACT = :lhCodCiclfact
                AND     COD_PROCESO  = :ihCodProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTAPROC ,TO_CHAR(FEC_INICIO,'yyyymmddhh24miss\
') ,TO_CHAR(FEC_TERMINO,'yyyymmddhh24miss') ,GLS_PROCESO ,COD_CLIENTE ,NUM_ABO\
NADO ,NUM_REGISTROS into :b0,:b1,:b2:b3,:b4:b5,:b6:b7,:b8:b9,:b10:b11  from FA\
_TRAZAPROC where (COD_CICLFACT=:b12 and COD_PROCESO=:b13)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )195;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecTermino;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)&i_szhFecTermino;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhGlsProceso;
    sqlstm.sqhstl[3] = (unsigned long )50;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&i_szhGlsProceso;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&i_lhCodCliente;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)&i_lhNumAbonado;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumRegistros;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&i_lhNumRegistros;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCiclfact;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProceso;
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




    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (szExeProceso, "\n\t\t**  Error en Select de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d]"
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lCicloFac,iCodProc,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t\t**  Error en Select de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d]"
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lCicloFac,iCodProc,SQLERRM);
        return (FALSE);
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        pstTraza->lCodCiclFact      = lhCodCiclfact     ;
        pstTraza->iCodProceso       = ihCodProceso      ;
        pstTraza->iCodEstaProc      = -1                ;
        strcpy(pstTraza->szFecInicio ,"")               ;
        strcpy(pstTraza->szFecTermino,"")               ;
        strcpy(pstTraza->szGlsProceso,"")               ;
        pstTraza->lCodCliente       = 0                 ;
        pstTraza->lNumAbonado       = 0                 ;
        pstTraza->lNumRegistros     = 0                 ;
    }
    if (SQLCODE == SQLOK )
    {
        pstTraza->lCodCiclFact      = lhCodCiclfact     ;
        pstTraza->iCodProceso       = ihCodProceso      ;
        pstTraza->iCodEstaProc      = ihCodEstaProc     ;
        strcpy(pstTraza->szFecInicio,szhFecInicio)      ;

        if (i_szhFecTermino != ORA_NULL)
            strcpy(pstTraza->szFecTermino,szhFecTermino)    ;
        else
            strcpy(pstTraza->szFecTermino,"")               ;

        if (i_szhGlsProceso != ORA_NULL)
            strcpy(pstTraza->szGlsProceso,szhGlsProceso)    ;
        else
            strcpy(pstTraza->szGlsProceso,"")               ;

        if (i_lhCodCliente  != ORA_NULL)
            pstTraza->lCodCliente       = lhCodCliente      ;
        else
            pstTraza->lCodCliente       = 0                 ;

        if (i_lhNumAbonado != ORA_NULL)
            pstTraza->lNumAbonado       = lhNumAbonado      ;
        else
            pstTraza->lNumAbonado       = 0                 ;

        if (i_lhNumRegistros != ORA_NULL)
            pstTraza->lNumRegistros     = lhNumRegistros    ;
        else
            pstTraza->lNumRegistros     = 0                 ;
    }
    return (TRUE);
}



/****************************************************************************/
/*   funcion BOOL bfnUpdateTrazaProc (stTrazaProc *)                        */
/****************************************************************************/
/*   Rutina que Actualiza Tabla de Traza de Procesos desde estructura       */
/*   stTrazaProc previamente Actualizada.                                   */
/****************************************************************************/
BOOL bfnUpdateTrazaProc (TRAZAPROC pstTraza)
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long    lhCodCiclfact       ;
    int     ihCodProceso        ;
    int     ihCodEstaProc       ;
    char    szhFecInicio[15]    ;   /* EXEC SQL VAR szhFecInicio       IS STRING(15); */ 

    char    szhFecTermino[15]   ;   /* EXEC SQL VAR szhFecTermino      IS STRING(15); */ 

    char    szhGlsProceso[50]   ;   /* EXEC SQL VAR szhGlsProceso      IS STRING(50); */ 

    long    lhCodCliente        ;
    long    lhNumAbonado        ;
    long    lhNumRegistros      ;

    /* EXEC SQL END DECLARE SECTION  ; */ 


    static char szExeProceso[1024]="bfnUpdateTrazaProc"     ;

    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada a (bfnUpdateTrazaProc) **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    ,LOG05,pstTraza.lCodCiclFact,pstTraza.iCodProceso);



    lhCodCiclfact   =   pstTraza.lCodCiclFact      ;
    ihCodProceso    =   pstTraza.iCodProceso       ;
    ihCodEstaProc   =   pstTraza.iCodEstaProc      ;
    strcpy(szhFecInicio,pstTraza.szFecInicio)      ;
    /***************************************************/
    if (strlen(pstTraza.szFecTermino) == 0)
    {
        strcpy(szhFecTermino,"")                    ;
    }
    else
    {
        strcpy(szhFecTermino,pstTraza.szFecTermino) ;
    }
    /***************************************************/
    if (strlen(pstTraza.szGlsProceso) == 0)
    {
        strcpy(szhGlsProceso,"")                    ;
    }
    else
    {
        strcpy(szhGlsProceso,pstTraza.szGlsProceso);
    }
    /***************************************************/
    if (pstTraza.lCodCliente == 0)
    {
        lhCodCliente        = 0                     ;
    }
    else
    {
        lhCodCliente        = pstTraza.lCodCliente ;
    }
    /***************************************************/
    if (pstTraza.lNumAbonado == 0)
    {
        lhNumAbonado        = 0                     ;
    }
    else
    {
        lhNumAbonado        = pstTraza.lNumAbonado ;
    }
    /***************************************************/
    if (pstTraza.lNumRegistros == 0)
    {
        lhNumRegistros      = 0                     ;
    }
    else
    {
        lhNumRegistros      = pstTraza.lNumRegistros;
    }
    /***************************************************/

    /* EXEC SQL    UPDATE  FA_TRAZAPROC
                SET     COD_ESTAPROC    = :ihCodEstaProc                                ,
                        FEC_INICIO      = TO_DATE(:szhFecInicio ,'yyyymmddhh24miss')    ,
                        FEC_TERMINO     = TO_DATE(:szhFecTermino,'yyyymmddhh24miss')    ,
                        GLS_PROCESO     = :szhGlsProceso                                ,
                        COD_CLIENTE     = :lhCodCliente                                 ,
                        NUM_ABONADO     = :lhNumAbonado                                 ,
                        NUM_REGISTROS   = :lhNumRegistros
                WHERE   COD_CICLFACT    = :lhCodCiclfact
                AND     COD_PROCESO     = :ihCodProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_TRAZAPROC  set COD_ESTAPROC=:b0,FEC_INICIO=TO_D\
ATE(:b1,'yyyymmddhh24miss'),FEC_TERMINO=TO_DATE(:b2,'yyyymmddhh24miss'),GLS_PR\
OCESO=:b3,COD_CLIENTE=:b4,NUM_ABONADO=:b5,NUM_REGISTROS=:b6 where (COD_CICLFAC\
T=:b7 and COD_PROCESO=:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )246;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecTermino;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhGlsProceso;
    sqlstm.sqhstl[3] = (unsigned long )50;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumRegistros;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCiclfact;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProceso;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t\t**  Error en Update FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d] "
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lhCodCiclfact,ihCodProceso,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t\t**  Error en Update de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d] "
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lhCodCiclfact,ihCodProceso,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}



void bPrintTrazaProc(TRAZAPROC stpTraza)
{
    vDTrazasLog("bPrintTrazaProc", "\n\t** Traza del Proceso FA_TRAZAPROC **"
                                "\n\t\t=> Codigo Ciclo      [%ld]"
                                "\n\t\t=> Codigo Proceso    [%d]"
                                "\n\t\t=> Estado Proceso    [%d]"
                                "\n\t\t=> Fecha Inicio      [%s]"
                                "\n\t\t=> Fecha Termino     [%s]"
                                "\n\t\t=> Glosa Proceso     [%s]"
                                "\n\t\t=> Clientes          [%ld]"
                                "\n\t\t=> Abonado           [%ld]"
                                "\n\t\t=> Registros         [%ld]",LOG03,
                                stpTraza.lCodCiclFact    ,
                                stpTraza.iCodProceso     ,
                                stpTraza.iCodEstaProc    ,
                                stpTraza.szFecInicio     ,
                                stpTraza.szFecTermino    ,
                                stpTraza.szGlsProceso    ,
                                stpTraza.lCodCliente     ,
                                stpTraza.lNumAbonado     ,
                                stpTraza.lNumRegistros   );
    return;
}


/****************************************************************************/
/*   funcion BOOL bfnValidaTrazaProcHost(long CicloFact, long CodProceso)       */
/****************************************************************************/
/*   Proceso que valida condiciones para cargar el trafico del ciclo a      */
/*  facturar en tabla de proceso, controla puntos de retoma.                */
/****************************************************************************/
BOOL bfnValidaTrazaProcHost(long lCiclParam,int iCodProceso, int iIndFacturacion, char *szHostId)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long lhCiclParam            ;
    int  ihIndFacturacion       ;
    char szFecHastaLlam   [15]  ; /* EXEC SQL VAR szFecHastaLlam     IS STRING(15); */ 

    char szFecActual      [15]  ; /* EXEC SQL VAR szFecActual        IS STRING(15); */ 


    int  ihCodProceso           ;
    char szhDesProceso    [30]  ; /* EXEC SQL VAR szhDesProceso      IS STRING(30); */ 

    int  ihCodProcesoPrec       ;
    char szhDesProcesoPrec[30]  ; /* EXEC SQL VAR szhDesProcesoPrec  IS STRING(30); */ 

    int  ihCodEstaPrec          ;
    int  ihTrazCodEstaProc      ;
    int  ihTrazCodEstaActual    ;

    int  ihCero                 ;
    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

    char szhHostId        [21]  ; /* EXEC SQL VAR szhHostId  IS STRING(21); */ 

    char szhChar1         [51]  ; /* EXEC SQL VAR szhChar1  IS STRING(51); */ 


    /* EXEC SQL END DECLARE SECTION; */ 


    BOOL bFinCursor_cFaProcTraza=FALSE;
    static char szExeProceso[1024]="bfnValidaTrazaProcHost";

    ihCero = 0;
    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada bfnValidaTrazaProcHost  **"
                                "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                "\n\t\t=>  Codigo de Proceso        [%d]\n"
                                "\n\t\t=>  Host_ID                  [%s]\n"
                                ,LOG03,lCiclParam,iCodProceso, szHostId);

    /****************************************************************************/
    /*   Selecciona el Codigo de Ciclo,IND_FACTURACION y la Fecha del Sistema   */
    /****************************************************************************/
    /****************************************************************************/
    /*  Validar Estado de IND_FACTURACION = iIND_FACT_ENPROCESO                 */
    /*  Debe estar marcado como EN PROCESO.  Marcado previamnete por el         */
    /*  proceso de creacion de mascara.                                         */
    /****************************************************************************/
    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando FA_CILCFACT  **",LOG03);

    lhCiclParam     = lCiclParam                                ;

    /* EXEC SQL SELECT IND_FACTURACION                     ,
                    TO_CHAR(FEC_HASTALLAM,:szhFmtFecha) ,
                    TO_CHAR(SYSDATE,:szhFmtFecha)
             INTO   :ihIndFacturacion                   ,
                    :szFecHastaLlam                     ,
                    :szFecActual
             FROM   FA_CICLFACT
             WHERE  COD_CICLFACT = :lhCiclParam         ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_FACTURACION ,TO_CHAR(FEC_HASTALLAM,:b0) ,TO_CH\
AR(SYSDATE,:b0) into :b2,:b3,:b4  from FA_CICLFACT where COD_CICLFACT=:b5";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )297;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFacturacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szFecHastaLlam;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szFecActual;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCiclParam;
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




    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  No Existen Datos en FA_CICLFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  No Existen Datos en FA_CICLFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error en Select sobre FA_CILCFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  Error en Select sobre FA_CILCFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }


    if (ihIndFacturacion != iIndFacturacion)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
                                    "\n\t\t=>  Cod_CiclFact                 [%ld]"
                                    "\n\t\t=>  Ind_Facturacion Actual       [%d]"
                                    "\n\t\t=>  Ind_Facturacion Necesario    [%d]"
                                    ,LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);
        vDTrazasError(szExeProceso, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
                                    "\n\t\t=>  Cod_CiclFact                 [%ld]"
                                    "\n\t\t=>  Ind_Facturacion Actual       [%d]"
                                    "\n\t\t=>  Ind_Facturacion Necesario    [%d]"
                                    ,LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);

        return (FALSE);

    }

    /****************************************************************************/
    /*  Selecciona las Condiciones de Procesos Precedentes en la tabla de       */
    /*  de descripcion de procesos FA_PROCFACT y tabla de traza de Procso       */
    /*  FA_TRAZAPROC que contiene la definicion de los procesos de Facturacion  */
    /*  ejecutados.                                                             */
    /****************************************************************************/
    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando Procesos Precedentes en FA_TRAZAPROC - FA_PROCFACT **",LOG03);

    ihCodProceso    = iCodProceso               ;
    sprintf (szhHostId, "%20s", szHostId);

    /* EXEC SQL DECLARE cFaProcTrazaHost CURSOR FOR
        SELECT  PROC.DES_PROCESO,
                PROC.COD_PROCPREC,
                PROC.DES_PROCPREC,
                PROC.COD_ESTAPREC,
                NVL(TRAZ.COD_ESTAPROC,:ihCero)
        FROM    FA_TRAZAPROC  TRAZ,
                (SELECT A.COD_PROCESO   COD_PROCESO,
                        B.DES_PROCESO   DES_PROCESO,
                        A.COD_PROCPREC  COD_PROCPREC,
                        C.DES_PROCESO   DES_PROCPREC,
                        A.COD_ESTAPREC  COD_ESTAPREC
                FROM    FA_PROCFACTPREC A ,
                        FA_PROCFACT B ,
                        FA_PROCFACT C
                WHERE   A.COD_PROCESO  = :ihCodProceso
                AND     A.COD_PROCESO  = B.COD_PROCESO
                AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
        WHERE   TRAZ.COD_CICLFACT (+)  = :lhCiclParam
        AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
        AND     NVL(TRAZ.HOST_ID,:szhHostId) = :szhHostId
        ORDER BY PROC.COD_PROCESO; */ 


    /* EXEC SQL OPEN cFaProcTrazaHost; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0008;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )336;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[3] = (unsigned long )21;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[4] = (unsigned long )21;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        return (FALSE);
    }
    /****************************************************************************/
    bFinCursor_cFaProcTraza = FALSE ;
    do
    {
        /* EXEC SQL FETCH cFaProcTrazaHost INTO
                    :szhDesProceso          ,
                    :ihCodProcesoPrec       ,
                    :szhDesProcesoPrec      ,
                    :ihCodEstaPrec          ,
                    :ihTrazCodEstaProc      ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )371;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhDesProceso;
        sqlstm.sqhstl[0] = (unsigned long )30;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProcesoPrec;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhDesProcesoPrec;
        sqlstm.sqhstl[2] = (unsigned long )30;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodEstaPrec;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihTrazCodEstaProc;
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
}



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szExeProceso, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            vDTrazasError(szExeProceso, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor_cFaProcTraza = TRUE;
        }
        else
        {
            /****************************************************************************/
            /*  Valida que el Estado del Proceso Precedente este Actualizado en la      */
            /*  tabla de Traza  FA_TRAZAPROC.                                           */
            /****************************************************************************/
            if(ihCodEstaPrec != ihTrazCodEstaProc )
            {
                vDTrazasLog  (szExeProceso, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
                                            ,LOG01, szhDesProcesoPrec, szhDesProceso);
                vDTrazasError(szExeProceso, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
                                            ,LOG01, szhDesProcesoPrec, szhDesProceso);
                return(FALSE);
            }
        }
    } while(!bFinCursor_cFaProcTraza);

    /* EXEC SQL CLOSE cFaProcTrazaHost; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )406;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /****************************************************************************/
    /*  Valida Condiciones del Mismo Proceso.                                   */
    /*  Valida si puede Retomar el Proceso o simplemente iniciar por primera vez*/
    /****************************************************************************/

    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando Proceso Actual en FA_TRAZAPROC  **",LOG03);
    ihCodProceso    = iCodProceso               ;

    /* EXEC SQL    SELECT TRAZ.COD_ESTAPROC   ,PROC.DES_PROCESO
                  INTO :ihTrazCodEstaActual,:szhDesProceso
                  FROM FA_TRAZAPROC TRAZ,
                       FA_PROCFACT  PROC
                 WHERE TRAZ.COD_CICLFACT = :lhCiclParam
                   AND TRAZ.COD_PROCESO  = :ihCodProceso
                   AND TRAZ.COD_PROCESO  = PROC.COD_PROCESO
                   AND TRAZ.HOST_ID      = TRIM (:szhHostId); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TRAZ.COD_ESTAPROC ,PROC.DES_PROCESO into :b0,:b1  \
from FA_TRAZAPROC TRAZ ,FA_PROCFACT PROC where (((TRAZ.COD_CICLFACT=:b2 and TR\
AZ.COD_PROCESO=:b3) and TRAZ.COD_PROCESO=PROC.COD_PROCESO) and TRAZ.HOST_ID=tr\
im(:b4))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )421;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTrazCodEstaActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[1] = (unsigned long )30;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[4] = (unsigned long )21;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
                                    "\n\t\t=>  Proceso               [%d]"
                                    "\n\t\t=>  Cod.Ciclo Facturacion [%ld]"
                                    ,LOG01,iCodProceso,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
                                    "\n\t\t=>  Proceso               [%d]"
                                    "\n\t\t=>  Cod.Ciclo Facturacion [%ld]"
                                    ,LOG01,iCodProceso,lCiclParam);

        return (FALSE);
    }
    if (SQLCODE == SQLOK)
    {
        /****************************************************************************/
        /*  Valida que el Proceso Este Terminado Ok                                 */
        /****************************************************************************/
        if(ihTrazCodEstaActual == iPROC_EST_OK)
        {
            vDTrazasLog  (szExeProceso, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
                                        "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                        "\n\t\t=>  Codigo de Proceso            [%d]"
                                        "\n\t\t=>  Estado de Proceso            [%d]"
                                        ,LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
            vDTrazasError(szExeProceso, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
                                        "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                        "\n\t\t=>  Codigo de Proceso            [%d]"
                                        "\n\t\t=>  Estado de Proceso            [%d]"
                                        ,LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
            return(FALSE);
        }

        vDTrazasLog  (szExeProceso, "\n\t**  Retomando Proceso  %s **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    "\n\t\t=>  Estado del Proceso       [%d]\n"
                                    ,LOG03,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);

    }
    else if (SQLCODE == SQLNOTFOUND)
    {
        /****************************************************************************/
        /*   Proceso NO se ha ejecutado aun para el ciclo de Facturacion.           */
        /*   Inserta Registro en la Tabla de Traza                                  */
        /****************************************************************************/
        ihTrazCodEstaActual = iPROC_EST_RUN;
        vDTrazasLog  (szExeProceso, "\n\t**  Insertando Proceso de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]\n"
                                    ,LOG03,lCiclParam,iCodProceso);

	    sprintf (szhChar1, "Proceso Iniciado");

        /* EXEC SQL INSERT INTO
                FA_TRAZAPROC(   COD_CICLFACT        ,
                                COD_PROCESO         ,
                                COD_ESTAPROC        ,
                                FEC_INICIO          ,
                                GLS_PROCESO         ,
                                COD_CLIENTE         ,
                                NUM_ABONADO         ,
                                NUM_REGISTROS       ,
                                HOST_ID             )
                VALUES      (   :lhCiclParam        ,
                                :ihCodProceso       ,
                                :ihTrazCodEstaActual,
                                sysdate             ,
                                :szhChar1		    ,
                                :ihCero             ,
                                :ihCero             ,
                                :ihCero             ,
                                TRIM (:szhHostId)    ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FA_TRAZAPROC (COD_CICLFACT,COD_PROCESO,CO\
D_ESTAPROC,FEC_INICIO,GLS_PROCESO,COD_CLIENTE,NUM_ABONADO,NUM_REGISTROS,HOST_I\
D) values (:b0,:b1,:b2,sysdate,:b3,:b4,:b4,:b4,trim(:b7))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )456;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclParam;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihTrazCodEstaActual;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhChar1;
        sqlstm.sqhstl[3] = (unsigned long )51;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[7] = (unsigned long )21;
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


        if ((SQLCODE != SQLOK) && (SQLCODE != SQLUKCONSTRAINT))
        {
            vDTrazasLog  (szExeProceso, "\n\t\t**  Error Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  Error Oracle  %s              "
                                        ,LOG01,iCodProceso,lCiclParam,SQLERRM);
            vDTrazasError(szExeProceso, "\n\t\t**  Error Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  Error Oracle  %s              "
                                        ,LOG01,iCodProceso,lCiclParam,SQLERRM);
            return (FALSE);
        }
        else if (SQLCODE == SQLUKCONSTRAINT)
        {
            vDTrazasLog  (szExeProceso, "\n\t\t**  Warning Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  El registro ya existía!!!     "
                                        ,LOG01,iCodProceso,lCiclParam);
            vDTrazasError(szExeProceso, "\n\t\t**  Warning Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  El registro ya existía!!!     "
                                        ,LOG01,iCodProceso,lCiclParam);
            return (FALSE);
        }
    }
    return (TRUE);
}/**********************   fin  bfnValidaTrazaProc  **************************/


/****************************************************************************/
/*   funcion BOOL bfnValidaTrazaProcHostFirst(long CicloFact, long CodProceso)       */
/****************************************************************************/
/*   Proceso que valida condiciones para cargar el trafico del ciclo a      */
/*  facturar en tabla de proceso, controla puntos de retoma.                */
/****************************************************************************/
BOOL bfnValidaTrazaProcHostFirst(long lCiclParam,int iCodProceso, int iIndFacturacion, char *szHostId)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long lhCiclParam            ;
    int  ihIndFacturacion       ;
    char szFecHastaLlam   [15]  ; /* EXEC SQL VAR szFecHastaLlam     IS STRING(15); */ 

    char szFecActual      [15]  ; /* EXEC SQL VAR szFecActual        IS STRING(15); */ 


    int  ihCodProceso           ;
    char szhDesProceso    [30]  ; /* EXEC SQL VAR szhDesProceso      IS STRING(30); */ 

    int  ihCodProcesoPrec       ;
    char szhDesProcesoPrec[30]  ; /* EXEC SQL VAR szhDesProcesoPrec  IS STRING(30); */ 

    int  ihCodEstaPrec          ;
    int  ihTrazCodEstaProc      ;
    int  ihTrazCodEstaActual    ;

    int  ihCero                 ;
    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

    char szhHostId        [21]  ; /* EXEC SQL VAR szhHostId  IS STRING(21); */ 

    char szhChar1         [51]  ; /* EXEC SQL VAR szhChar1  IS STRING(51); */ 


    /* EXEC SQL END DECLARE SECTION; */ 


    BOOL bFinCursor_cFaProcTraza=FALSE;
    static char szExeProceso[1024]="bfnValidaTrazaProc";

    ihCero = 0;
    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");

    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada bfnValidaTrazaProc  **"
                                "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                "\n\t\t=>  Codigo de Proceso        [%d]\n"
                                ,LOG03,lCiclParam,iCodProceso);

    /****************************************************************************/
    /*   Selecciona el Codigo de Ciclo,IND_FACTURACION y la Fecha del Sistema   */
    /****************************************************************************/
    /****************************************************************************/
    /*  Validar Estado de IND_FACTURACION = iIND_FACT_ENPROCESO                 */
    /*  Debe estar marcado como EN PROCESO.  Marcado previamnete por el         */
    /*  proceso de creacion de mascara.                                         */
    /****************************************************************************/
    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando FA_CILCFACT  **",LOG03);

    lhCiclParam     = lCiclParam                                ;

    /* EXEC SQL SELECT IND_FACTURACION                     ,
                    TO_CHAR(FEC_HASTALLAM,:szhFmtFecha) ,
                    TO_CHAR(SYSDATE,:szhFmtFecha)
             INTO   :ihIndFacturacion                   ,
                    :szFecHastaLlam                     ,
                    :szFecActual
             FROM   FA_CICLFACT
             WHERE  COD_CICLFACT = :lhCiclParam         ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_FACTURACION ,TO_CHAR(FEC_HASTALLAM,:b0) ,TO_CH\
AR(SYSDATE,:b0) into :b2,:b3,:b4  from FA_CICLFACT where COD_CICLFACT=:b5";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )503;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFacturacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szFecHastaLlam;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szFecActual;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCiclParam;
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




    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  No Existen Datos en FA_CICLFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  No Existen Datos en FA_CICLFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error en Select sobre FA_CILCFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  Error en Select sobre FA_CILCFACT **"
                                    "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }


    if (ihIndFacturacion != iIndFacturacion)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
                                    "\n\t\t=>  Cod_CiclFact                 [%ld]"
                                    "\n\t\t=>  Ind_Facturacion Actual       [%d]"
                                    "\n\t\t=>  Ind_Facturacion Necesario    [%d]"
                                    ,LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);
        vDTrazasError(szExeProceso, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
                                    "\n\t\t=>  Cod_CiclFact                 [%ld]"
                                    "\n\t\t=>  Ind_Facturacion Actual       [%d]"
                                    "\n\t\t=>  Ind_Facturacion Necesario    [%d]"
                                    ,LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);

        return (FALSE);

    }

    /****************************************************************************/
    /*  Selecciona las Condiciones de Procesos Precedentes en la tabla de       */
    /*  de descripcion de procesos FA_PROCFACT y tabla de traza de Procso       */
    /*  FA_TRAZAPROC que contiene la definicion de los procesos de Facturacion  */
    /*  ejecutados.                                                             */
    /****************************************************************************/
    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando Procesos Precedentes en FA_TRAZAPROC - FA_PROCFACT **",LOG03);

    ihCodProceso    = iCodProceso               ;
    sprintf (szhHostId, "%20s", szHostId);

    /* EXEC SQL DECLARE cFaProcTrazaHostFirst CURSOR FOR
        SELECT  PROC.DES_PROCESO,
                PROC.COD_PROCPREC,
                PROC.DES_PROCPREC,
                PROC.COD_ESTAPREC,
                NVL(TRAZ.COD_ESTAPROC,:ihCero)
        FROM    FA_TRAZAPROC  TRAZ,
                (SELECT A.COD_PROCESO   COD_PROCESO,
                        B.DES_PROCESO   DES_PROCESO,
                        A.COD_PROCPREC  COD_PROCPREC,
                        C.DES_PROCESO   DES_PROCPREC,
                        A.COD_ESTAPREC  COD_ESTAPREC
                FROM    FA_PROCFACTPREC A ,
                        FA_PROCFACT B ,
                        FA_PROCFACT C
                WHERE   A.COD_PROCESO  = :ihCodProceso
                AND     A.COD_PROCESO  = B.COD_PROCESO
                AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
        WHERE   TRAZ.COD_CICLFACT (+)  = :lhCiclParam
        AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
        ORDER BY PROC.COD_PROCESO; */ 


    /* EXEC SQL OPEN cFaProcTrazaHostFirst; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0012;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )542;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,iCodProceso,lCiclParam,SQLERRM);
        return (FALSE);
    }
    /****************************************************************************/
    bFinCursor_cFaProcTraza = FALSE ;
    do
    {
        /* EXEC SQL FETCH cFaProcTrazaHostFirst INTO
                    :szhDesProceso          ,
                    :ihCodProcesoPrec       ,
                    :szhDesProcesoPrec      ,
                    :ihCodEstaPrec          ,
                    :ihTrazCodEstaProc      ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )569;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhDesProceso;
        sqlstm.sqhstl[0] = (unsigned long )30;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProcesoPrec;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhDesProcesoPrec;
        sqlstm.sqhstl[2] = (unsigned long )30;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodEstaPrec;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihTrazCodEstaProc;
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
}



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szExeProceso, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            vDTrazasError(szExeProceso, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor_cFaProcTraza = TRUE;
        }
        else
        {
            /****************************************************************************/
            /*  Valida que el Estado del Proceso Precedente este Actualizado en la      */
            /*  tabla de Traza  FA_TRAZAPROC.                                           */
            /****************************************************************************/
            if(ihCodEstaPrec != ihTrazCodEstaProc)
            {
                vDTrazasLog  (szExeProceso, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
                                            ,LOG01, szhDesProcesoPrec, szhDesProceso);
                vDTrazasError(szExeProceso, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
                                            ,LOG01, szhDesProcesoPrec, szhDesProceso);
                return(FALSE);
            }
        }
    } while(!bFinCursor_cFaProcTraza);

    /* EXEC SQL CLOSE cFaProcTrazaHostFirst; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )604;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /****************************************************************************/
    /*  Valida Condiciones del Mismo Proceso.                                   */
    /*  Valida si puede Retomar el Proceso o simplemente iniciar por primera vez*/
    /****************************************************************************/

    vDTrazasLog  (szExeProceso, "\n\t\t**  Validando Proceso Actual en FA_TRAZAPROC  **",LOG03);
    ihCodProceso    = iCodProceso               ;

    /* EXEC SQL    SELECT TRAZ.COD_ESTAPROC   ,PROC.DES_PROCESO
                  INTO :ihTrazCodEstaActual,:szhDesProceso
                  FROM FA_TRAZAPROC TRAZ,
                       FA_PROCFACT  PROC
                 WHERE TRAZ.COD_CICLFACT = :lhCiclParam
                   AND TRAZ.COD_PROCESO  = :ihCodProceso
                   AND TRAZ.COD_PROCESO  = PROC.COD_PROCESO
                   AND TRAZ.HOST_ID      = TRIM (:szhHostId); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TRAZ.COD_ESTAPROC ,PROC.DES_PROCESO into :b0,:b1  \
from FA_TRAZAPROC TRAZ ,FA_PROCFACT PROC where (((TRAZ.COD_CICLFACT=:b2 and TR\
AZ.COD_PROCESO=:b3) and TRAZ.COD_PROCESO=PROC.COD_PROCESO) and TRAZ.HOST_ID=tr\
im(:b4))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )619;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTrazCodEstaActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[1] = (unsigned long )30;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[4] = (unsigned long )21;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog  (szExeProceso, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
                                    "\n\t\t=>  Proceso               [%d]"
                                    "\n\t\t=>  Cod.Ciclo Facturacion [%ld]"
                                    ,LOG01,iCodProceso,lCiclParam);
        vDTrazasError(szExeProceso, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
                                    "\n\t\t=>  Proceso               [%d]"
                                    "\n\t\t=>  Cod.Ciclo Facturacion [%ld]"
                                    ,LOG01,iCodProceso,lCiclParam);

        return (FALSE);
    }
    if (SQLCODE == SQLOK)
    {
        /****************************************************************************/
        /*  Valida que el Proceso Este Terminado Ok                                 */
        /****************************************************************************/
        if(ihTrazCodEstaActual == iPROC_EST_OK)
        {
            vDTrazasLog  (szExeProceso, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
                                        "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                        "\n\t\t=>  Codigo de Proceso            [%d]"
                                        "\n\t\t=>  Estado de Proceso            [%d]"
                                        ,LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
            vDTrazasError(szExeProceso, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
                                        "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
                                        "\n\t\t=>  Codigo de Proceso            [%d]"
                                        "\n\t\t=>  Estado de Proceso            [%d]"
                                        ,LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
            return(FALSE);
        }

        vDTrazasLog  (szExeProceso, "\n\t**  Retomando Proceso  %s **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    "\n\t\t=>  Estado del Proceso       [%d]\n"
                                    ,LOG03,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);

    }
    else if (SQLCODE == SQLNOTFOUND)
    {
        /****************************************************************************/
        /*   Proceso NO se ha ejecutado aun para el ciclo de Facturacion.           */
        /*   Inserta Registro en la Tabla de Traza                                  */
        /****************************************************************************/
        ihTrazCodEstaActual = iPROC_EST_RUN;
        vDTrazasLog  (szExeProceso, "\n\t**  Insertando Proceso de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]\n"
                                    ,LOG03,lCiclParam,iCodProceso);

	    sprintf (szhChar1, "Proceso Iniciado");

        /* EXEC SQL INSERT INTO
                FA_TRAZAPROC(   COD_CICLFACT        ,
                                COD_PROCESO         ,
                                COD_ESTAPROC        ,
                                FEC_INICIO          ,
                                GLS_PROCESO         ,
                                COD_CLIENTE         ,
                                NUM_ABONADO         ,
                                NUM_REGISTROS       ,
                                HOST_ID             )
                VALUES      (   :lhCiclParam        ,
                                :ihCodProceso       ,
                                :ihTrazCodEstaActual,
                                sysdate             ,
                                :szhChar1		    ,
                                :ihCero             ,
                                :ihCero             ,
                                :ihCero             ,
                                TRIM (:szhHostId)    ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FA_TRAZAPROC (COD_CICLFACT,COD_PROCESO,CO\
D_ESTAPROC,FEC_INICIO,GLS_PROCESO,COD_CLIENTE,NUM_ABONADO,NUM_REGISTROS,HOST_I\
D) values (:b0,:b1,:b2,sysdate,:b3,:b4,:b4,:b4,trim(:b7))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )654;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclParam;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihTrazCodEstaActual;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhChar1;
        sqlstm.sqhstl[3] = (unsigned long )51;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihCero;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhHostId;
        sqlstm.sqhstl[7] = (unsigned long )21;
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


        if ((SQLCODE != SQLOK) && (SQLCODE != SQLUKCONSTRAINT))
        {
            vDTrazasLog  (szExeProceso, "\n\t\t**  Error Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  Error Oracle  %s              "
                                        ,LOG01,iCodProceso,lCiclParam,SQLERRM);
            vDTrazasError(szExeProceso, "\n\t\t**  Error Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  Error Oracle  %s              "
                                        ,LOG01,iCodProceso,lCiclParam,SQLERRM);
            return (FALSE);
        }
        else if (SQLCODE == SQLUKCONSTRAINT)
        {
            vDTrazasLog  (szExeProceso, "\n\t\t**  Warning Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  El registro ya existía!!!     "
                                        ,LOG01,iCodProceso,lCiclParam);
            vDTrazasError(szExeProceso, "\n\t\t**  Warning Insertando Proceso [%d]"
                                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
                                        "\n\t\t=>  El registro ya existía!!!     "
                                        ,LOG01,iCodProceso,lCiclParam);
            return (FALSE);
        }
    }
    return (TRUE);
}/**********************   fin  bfnValidaTrazaProc  **************************/

/****************************************************************************/
/*   funcion BOOL bfnSelectTrazaProcHost (stTrazaProc *)                        */
/****************************************************************************/
/*   Rutina que Selecciona datos des Tabla de Traza de Procesos en la       */
/*   estructura stTrazaProc                                                 */
/****************************************************************************/
BOOL bfnSelectTrazaProcHost (long lCicloFac,int iCodProc, TRAZAPROC * pstTraza, char *szHostId)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long    lhCodCiclfact       ;
    int     ihCodProceso        ;
    int     ihCodEstaProc       ;
    char    szhFecInicio[15]    ;   /* EXEC SQL VAR szhFecInicio       IS STRING(15); */ 

    char    szhFecTermino[15]   ;   /* EXEC SQL VAR szhFecTermino      IS STRING(15); */ 

    char    szhGlsProceso[50]   ;   /* EXEC SQL VAR szhGlsProceso      IS STRING(50); */ 

    long    lhCodCliente        ;
    long    lhNumAbonado        ;
    long    lhNumRegistros      ;

    short   i_szhFecTermino     ;
    short   i_szhGlsProceso     ;
    short   i_lhCodCliente      ;
    short   i_lhNumAbonado      ;
    short   i_lhNumRegistros    ;

    char    szhHostId    [21]   ;   /* EXEC SQL VAR szhHostId      IS STRING(21); */ 

    char szhFmtFecha      [17]  ;   /* EXEC SQL VAR szhFmtFecha    IS STRING(17); */ 

    /* EXEC SQL END DECLARE SECTION  ; */ 


    static char szExeProceso[1024]="bfnSelectTrazaProc"     ;


    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada a (bfnSelectTrazaProc) **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    ,LOG05,lCicloFac,iCodProc);

    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");
    lhCodCiclfact       = lCicloFac      ;
    ihCodProceso        = iCodProc       ;
    sprintf (szhHostId, "%20s", szHostId);

    /* EXEC SQL    SELECT  COD_ESTAPROC                     ,
                        TO_CHAR(FEC_INICIO ,:szhFmtFecha),
                        TO_CHAR(FEC_TERMINO,:szhFmtFecha),
                        GLS_PROCESO                      ,
                        COD_CLIENTE                      ,
                        NUM_ABONADO                      ,
                        NUM_REGISTROS
                INTO    :ihCodEstaProc                   ,
                        :szhFecInicio                    ,
                        :szhFecTermino  :i_szhFecTermino ,
                        :szhGlsProceso  :i_szhGlsProceso ,
                        :lhCodCliente   :i_lhCodCliente  ,
                        :lhNumAbonado   :i_lhNumAbonado  ,
                        :lhNumRegistros :i_lhNumRegistros
                FROM    FA_TRAZAPROC
                WHERE   COD_CICLFACT = :lhCodCiclfact
                AND     COD_PROCESO  = :ihCodProceso
                AND     HOST_ID      = :szhHostId; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTAPROC ,TO_CHAR(FEC_INICIO,:b0) ,TO_CHAR(FEC\
_TERMINO,:b0) ,GLS_PROCESO ,COD_CLIENTE ,NUM_ABONADO ,NUM_REGISTROS into :b2,:\
b3,:b4:b5,:b6:b7,:b8:b9,:b10:b11,:b12:b13  from FA_TRAZAPROC where ((COD_CICLF\
ACT=:b14 and COD_PROCESO=:b15) and HOST_ID=:b16)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )701;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecTermino;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&i_szhFecTermino;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhGlsProceso;
    sqlstm.sqhstl[5] = (unsigned long )50;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)&i_szhGlsProceso;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&i_lhCodCliente;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&i_lhNumAbonado;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumRegistros;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)&i_lhNumRegistros;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhCodCiclfact;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[11] = (unsigned long )21;
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




    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (szExeProceso, "\n\t\t**  Error en Select de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d]"
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lCicloFac,iCodProc,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t\t**  Error en Select de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d]"
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lCicloFac,iCodProc,SQLERRM);
        return (FALSE);
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        pstTraza->lCodCiclFact      = lhCodCiclfact     ;
        pstTraza->iCodProceso       = ihCodProceso      ;
        pstTraza->iCodEstaProc      = -1                ;
        strcpy(pstTraza->szFecInicio ,"")               ;
        strcpy(pstTraza->szFecTermino,"")               ;
        strcpy(pstTraza->szGlsProceso,"")               ;
        pstTraza->lCodCliente       = 0                 ;
        pstTraza->lNumAbonado       = 0                 ;
        pstTraza->lNumRegistros     = 0                 ;
    }
    if (SQLCODE == SQLOK )
    {
        pstTraza->lCodCiclFact      = lhCodCiclfact     ;
        pstTraza->iCodProceso       = ihCodProceso      ;
        pstTraza->iCodEstaProc      = ihCodEstaProc     ;
        strcpy(pstTraza->szFecInicio,szhFecInicio)      ;

        if (i_szhFecTermino != ORA_NULL)
            strcpy(pstTraza->szFecTermino,szhFecTermino)    ;
        else
            strcpy(pstTraza->szFecTermino,"")               ;

        if (i_szhGlsProceso != ORA_NULL)
            strcpy(pstTraza->szGlsProceso,szhGlsProceso)    ;
        else
            strcpy(pstTraza->szGlsProceso,"")               ;

        if (i_lhCodCliente  != ORA_NULL)
            pstTraza->lCodCliente       = lhCodCliente      ;
        else
            pstTraza->lCodCliente       = 0                 ;

        if (i_lhNumAbonado != ORA_NULL)
            pstTraza->lNumAbonado       = lhNumAbonado      ;
        else
            pstTraza->lNumAbonado       = 0                 ;

        if (i_lhNumRegistros != ORA_NULL)
            pstTraza->lNumRegistros     = lhNumRegistros    ;
        else
            pstTraza->lNumRegistros     = 0                 ;
    }
    return (TRUE);
}

/****************************************************************************/
/*   funcion BOOL bfnUpdateTrazaProc (stTrazaProc *)                        */
/****************************************************************************/
/*   Rutina que Actualiza Tabla de Traza de Procesos desde estructura       */
/*   stTrazaProc previamente Actualizada.                                   */
/****************************************************************************/
BOOL bfnUpdateTrazaProcHost (TRAZAPROC pstTraza, char *szHostId)
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long    lhCodCiclfact       ;
    int     ihCodProceso        ;
    int     ihCodEstaProc       ;
    char    szhFecInicio[15]    ; /* EXEC SQL VAR szhFecInicio  IS STRING(15); */ 

    char    szhFecTermino[15]   ; /* EXEC SQL VAR szhFecTermino IS STRING(15); */ 

    char    szhGlsProceso[50]   ; /* EXEC SQL VAR szhGlsProceso IS STRING(50); */ 

    long    lhCodCliente        ;
    long    lhNumAbonado        ;
    long    lhNumRegistros      ;

    char    szhHostId    [21]   ; /* EXEC SQL VAR szhHostId    IS STRING(21); */ 

    char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    static char szExeProceso[1024]="bfnUpdateTrazaProc"     ;

    vDTrazasLog  (szExeProceso, "\n\t**  Parametros de Entrada a (bfnUpdateTrazaProc) **"
                                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
                                    "\n\t\t=>  Codigo de Proceso        [%d]"
                                    ,LOG05,pstTraza.lCodCiclFact,pstTraza.iCodProceso);

    sprintf (szhFmtFecha, "YYYYMMDDHH24MISS");
    lhCodCiclfact   =   pstTraza.lCodCiclFact      ;
    ihCodProceso    =   pstTraza.iCodProceso       ;
    ihCodEstaProc   =   pstTraza.iCodEstaProc      ;
    strcpy(szhFecInicio,pstTraza.szFecInicio)      ;
    sprintf (szhHostId, "%20s", szHostId);

    /***************************************************/
    if (strlen(pstTraza.szFecTermino) == 0)
    {
        strcpy(szhFecTermino,"")                    ;
    }
    else
    {
        strcpy(szhFecTermino,pstTraza.szFecTermino) ;
    }
    /***************************************************/
    if (strlen(pstTraza.szGlsProceso) == 0)
    {
        strcpy(szhGlsProceso,"")                    ;
    }
    else
    {
        strcpy(szhGlsProceso,pstTraza.szGlsProceso);
    }
    /***************************************************/
    if (pstTraza.lCodCliente == 0)
    {
        lhCodCliente        = 0                     ;
    }
    else
    {
        lhCodCliente        = pstTraza.lCodCliente ;
    }
    /***************************************************/
    if (pstTraza.lNumAbonado == 0)
    {
        lhNumAbonado        = 0                     ;
    }
    else
    {
        lhNumAbonado        = pstTraza.lNumAbonado ;
    }
    /***************************************************/
    if (pstTraza.lNumRegistros == 0)
    {
        lhNumRegistros      = 0                     ;
    }
    else
    {
        lhNumRegistros      = pstTraza.lNumRegistros;
    }
    /***************************************************/

    /* EXEC SQL    UPDATE  FA_TRAZAPROC
                SET     COD_ESTAPROC    = :ihCodEstaProc                      ,
                        FEC_INICIO      = nvl(FEC_INICIO,SYSDATE),
                        FEC_TERMINO     = TO_DATE(:szhFecTermino,:szhFmtFecha),
                        GLS_PROCESO     = :szhGlsProceso                      ,
                        COD_CLIENTE     = :lhCodCliente                       ,
                        NUM_ABONADO     = :lhNumAbonado                       ,
                        NUM_REGISTROS   = :lhNumRegistros
                WHERE   COD_CICLFACT    = :lhCodCiclfact
                AND     COD_PROCESO     = :ihCodProceso
                AND     HOST_ID         = TRIM(:szhHostId); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_TRAZAPROC  set COD_ESTAPROC=:b0,FEC_INICIO=nvl(\
FEC_INICIO,SYSDATE),FEC_TERMINO=TO_DATE(:b1,:b2),GLS_PROCESO=:b3,COD_CLIENTE=:\
b4,NUM_ABONADO=:b5,NUM_REGISTROS=:b6 where ((COD_CICLFACT=:b7 and COD_PROCESO=\
:b8) and HOST_ID=trim(:b9))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )764;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecTermino;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[2] = (unsigned long )17;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhGlsProceso;
    sqlstm.sqhstl[3] = (unsigned long )50;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumRegistros;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCiclfact;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhHostId;
    sqlstm.sqhstl[9] = (unsigned long )21;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeProceso, "\n\t\t**  Error en Update FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d] "
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lhCodCiclfact,ihCodProceso,SQLERRM);
        vDTrazasError(szExeProceso, "\n\t\t**  Error en Update de FA_TRAZAPROC  **"
                                    "\n\t\t=>  Codigo Ciclo Facturacion [%ld]"
                                    "\n\t\t=>  Codigo Proceso           [%d] "
                                    "\n\t\t=>  Error Oracle  %s              "
                                    ,LOG01,lhCodCiclfact,ihCodProceso,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}

/*****************************************************************************/
/* Funcion que recupera los rangos de clientes a procesar en la maquina      */
/*****************************************************************************/
int ifnGetHostId (char *szHostID)
{
    char pNameFile[255];
    FILE* pFile;
    char c;
    int i=0;

    memset(pNameFile,'\0',sizeof(pNameFile));
    if(getenv("XPF_CFG"))
    {
        sprintf(pNameFile,"%s/%s",getenv("XPF_CFG"),"host_id.dat");
    }

    if ((pFile = fopen(pNameFile,"rt")) == (FILE *)NULL)
    {
       return(-1);
    }

    c = fgetc(pFile);
    while((isalnum(c) || ispunct(c)) && (c != EOF) )
    {
        szHostID[i] = c;
        i++;
        c = fgetc(pFile);
    }

    szHostID[i] = '\0';

    fclose(pFile);

 return 0;

}

/*****************************************************************************/
/* Funcion que recupera los rangos de clientes a procesar en la maquina      */
/*****************************************************************************/
int	iGetRangosHost (char *szHostID, int iCodCiclFact, long *lCodClienteIni, long *lCodClienteFin)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	 ihCodCiclFact;
	char szhHostId [21]; /* EXEC SQL VAR szhHostId IS STRING (21); */ 

	long lhCodClienteIni;
	long lhCodClienteFin;
	/* EXEC SQL END DECLARE SECTION; */ 


	ihCodCiclFact = iCodCiclFact;
	sprintf(szhHostId, "%20s", szHostID);

	/* EXEC SQL
		SELECT COD_CLIENTEINI,
			   COD_CLIENTEFIN
	      INTO :lhCodClienteIni
	      	  ,:lhCodClienteFin
   	      FROM FA_RANGOSHOST_TO
   		 WHERE COD_CICLFACT = :ihCodCiclFact
   		   AND HOST_ID 		= TRIM (:szhHostId); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CLIENTEINI ,COD_CLIENTEFIN into :b0,:b1  from FA_\
RANGOSHOST_TO where (COD_CICLFACT=:b2 and HOST_ID=trim(:b3))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )819;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteIni;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodClienteFin;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclFact;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhHostId;
 sqlstm.sqhstl[3] = (unsigned long )21;
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



   if(sqlca.sqlcode != SQLOK)
   {
   		return(sqlca.sqlcode);
   }

   *lCodClienteIni  = lhCodClienteIni;
   *lCodClienteFin  = lhCodClienteFin;
   return(0);
}

/*!
 * ifnBuscarRangosClientesBD: Obtiene Rangos de Clientes desde la base de datos
 * @param  lCodCiclFact	Ciclo de facturacion
 * @param  lpClieIni         Rango Cliente inicial
 * @param  lpClieFin         Rango Cliente Final
 * @param  ipExisteRango     Indicador existencia Rango
 * @return 0  No existe host_id
 *         1  Obtiene Datos BD
 *        -1  Error: No existen rangos en BD.
 */
int ifnBuscarRangosClientesBD(long lCodCiclFact,long *lpClieIni, long *lpClieFin, int *ipExisteRango)
{

    char szHostId[20]="";
    long lClieIniBD = 0L;
    long lClieFinBD = 0L;
    int iVal        = 0;

    /*** Obtencion de rangos de clientes, si existen ***/
    if( (ifnGetHostId(szHostId))!=0 )
    {
        iVal = 0;
    }
    else
    {
        /*** Busqueda de rangos de clientes desde Base de Datos ***/
        if( (iGetRangosHost(szHostId, lCodCiclFact, &lClieIniBD, &lClieFinBD))==0 )
        {
            *lpClieIni  = lClieIniBD;
            *lpClieFin  = lClieFinBD;
            *ipExisteRango = 1;
            iVal = 1;
        }
        else
        {
        	iVal = -1;
        }
    }

    return iVal;
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

