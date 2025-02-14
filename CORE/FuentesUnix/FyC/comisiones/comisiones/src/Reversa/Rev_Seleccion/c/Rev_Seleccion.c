
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
           char  filnam[22];
};
static struct sqlcxp sqlfpn =
{
    21,
    "./pc/Rev_Seleccion.pc"
};


static unsigned int sqlctx = 110935387;


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
   unsigned char  *sqhstv[2];
   unsigned long  sqhstl[2];
            int   sqhsts[2];
            short *sqindv[2];
            int   sqinds[2];
   unsigned long  sqharm[2];
   unsigned long  *sqharc[2];
   unsigned short  sqadto[2];
   unsigned short  sqtdso[2];
} sqlstm = {12,2};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,52,0,2,41,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,2,52,0,2,51,0,0,1,1,0,1,0,1,97,0,0,
43,0,0,3,51,0,2,62,0,0,1,1,0,1,0,1,97,0,0,
62,0,0,4,52,0,2,72,0,0,1,1,0,1,0,1,97,0,0,
81,0,0,5,55,0,2,82,0,0,1,1,0,1,0,1,97,0,0,
100,0,0,6,114,0,2,100,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
123,0,0,7,51,0,2,111,0,0,1,1,0,1,0,1,97,0,0,
142,0,0,8,55,0,2,122,0,0,1,1,0,1,0,1,97,0,0,
161,0,0,9,50,0,2,132,0,0,1,1,0,1,0,1,97,0,0,
180,0,0,10,51,0,2,142,0,0,1,1,0,1,0,1,97,0,0,
199,0,0,11,56,0,2,152,0,0,1,1,0,1,0,1,97,0,0,
218,0,0,12,52,0,2,162,0,0,1,1,0,1,0,1,97,0,0,
237,0,0,13,59,0,1,272,0,0,0,0,0,1,0,
252,0,0,14,0,0,30,414,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Actualiza estados de cartera: Estados y situaciones de abonados para */
/*                               ser considerados en proceso.           */
/* Ingresa nuevas ventas periodo: Para lo que recurre a Siscel para     */
/*                                recuperar las nuevas ventas.          */
/* Discrimina clientes/abonados a ser procesados.                       */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Lunes 13 de Agosto del 2001.                                 */
/* Por Fabian Aedo Ramírez.                                             */
/*----------------------------------------------------------------------*/
/* 20031001 Marcelo Quiroz G. Versionado Cuzco.                         */
/* Se filtra reversa de tablas mediante el campo ID_PERIODO             */
/*                                                                      */
/************************************************************************/

#include "Rev_Seleccion.h"
#include "GEN_biblioteca.h"

/*---------------------------------------------------------------------------*/
/* Inclusion de biblioteca para manejo de interaccion con Oracle.            */
/*---------------------------------------------------------------------------*/
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


/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
	char    szhIdPeriodo[11];
/* EXEC SQL END DECLARE SECTION; */ 

                                                                                                                                     
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE HABILITACIONES CELULAR.              */
/*****************************************************************************/
void    vRevHabCel()
{        
        /* EXEC SQL delete FROM CMT_HABIL_CELULAR
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_HABIL_CELULAR  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                
        stStatusProc.lCantHabCel = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE HABILITACIONES PREPAGO.              */
/*****************************************************************************/
void    vRevHabPre()
{
        /* EXEC SQL delete FROM CMT_HABIL_PREPAGO
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_HABIL_PREPAGO  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )24;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                
                
        stStatusProc.lCantHabPre = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE BONOS POR CARTERA.                   */
/*****************************************************************************/
void    vRevBonosCartera()
{        
        /* EXEC SQL delete FROM CMT_BONOSCARTERA
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_BONOSCARTERA  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )43;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                
        stStatusProc.lCantBonTraf = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE BAJAS PREMATURAS.                    */
/*****************************************************************************/
void    vRevBajasCel()
{
        /* EXEC SQL delete FROM CMT_BAJAS_CELULAR
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_BAJAS_CELULAR  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )62;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                
        stStatusProc.lCantBajas = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE RECHAZOS DE VENTA.                   */
/*****************************************************************************/
void    vRevRechaCel()
{
        /* EXEC SQL delete FROM CMT_RECHAZOS_CELULAR
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_RECHAZOS_CELULAR  where ID_PERIODO=:\
b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )81;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


        
        stStatusProc.lCantRecha = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DE LA CARTERA DE ABONADOS DE DISTRIBUIDORES.         */
/*****************************************************************************/
void    vRevCartera()
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                char    szhFecDesde[22];        /* EXEC SQL VAR szhFecDesde IS STRING(22); */ 

                char    szhFecHasta[22];        /* EXEC SQL VAR szhFecHasta IS STRING(22); */ 
         
        /* EXEC SQL END DECLARE SECTION; */ 


        strcpy(szhFecDesde, stCiclo.szFecDesdeAceptacion);
        strcpy(szhFecHasta, stCiclo.szFecHastaAceptacion);
        
        /* EXEC SQL delete FROM CMT_CARTERA
                WHERE FEC_ACEPREC  > TO_DATE(:szhFecDesde,'DD-MM-YYYY')
                  AND FEC_ACEPREC <= TO_DATE(:szhFecHasta,'DD-MM-YYYY'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_CARTERA  where (FEC_ACEPREC>TO_DATE(\
:b0,'DD-MM-YYYY') and FEC_ACEPREC<=TO_DATE(:b1,'DD-MM-YYYY'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )100;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[0] = (unsigned long )22;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[1] = (unsigned long )22;
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


                  
        stStatusProc.lCantCartera = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DE LA EVALUACIONES DE RIESGO.         */
/*****************************************************************************/
void    vRevEvaluaciones()
{
        /* EXEC SQL delete FROM CMT_EVALUACIONES
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_EVALUACIONES  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )123;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                  
        stStatusProc.lCantEvalua = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DE LA EVALUACIONES DE CHURN.                         */
/*****************************************************************************/
void    vRevEvalChurn()
{        
        iCodError = EXIT_204;   
        /* EXEC SQL delete FROM CM_EVALUA_CHURN_TO
                WHERE ID_CICLCOMIS = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CM_EVALUA_CHURN_TO  where ID_CICLCOMIS=:\
b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )142;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                  
        stStatusProc.lCantChurn = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DE LA CONVENIOS PAC.                                 */
/*****************************************************************************/
void    vRevEvalConvenios()
{
        /* EXEC SQL delete FROM CM_CONVENIOS_TO
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CM_CONVENIOS_TO  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )161;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                  
        stStatusProc.lCantConvenios = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DE ENLACE DE COMISIONES.                             */
/*****************************************************************************/
void    vRevEnlaceHist()
{
        /* EXEC SQL delete FROM CM_ENLACEHIST_TO
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CM_ENLACEHIST_TO  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )180;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                  
        stStatusProc.lCantEnlaces = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE VENTAS PENDIENTES.                   */
/*****************************************************************************/
void    vRevVtasPendientes()
{        
        /* EXEC SQL delete FROM CMT_VENTAS_PENDIENTES
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_VENTAS_PENDIENTES  where ID_PERIODO=\
:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )199;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                
        stStatusProc.lCantVtasPend = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE RETENCIONES.                         */
/*****************************************************************************/
void    vRevRetenciones()
{        
        /* EXEC SQL delete FROM CM_RETENCIONES_TO
                WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CM_RETENCIONES_TO  where ID_PERIODO=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )218;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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


                
        stStatusProc.lCantRetenciones = sqlca.sqlerrd[2];
}
/*****************************************************************************/
/* Rutina principal.                                                         */
/*****************************************************************************/
int     main (int argc, char *argv[])
{      
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
        short ibiblio;
		long  lSegIni, lSegFin;	
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
        lSegIni=lGetTimer();				 
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
        memset(&stStatusProc, 0, sizeof(rg_estadistica));
        memset(&stCiclo, 0, sizeof(reg_ciclo));  
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
        memset(&stArgs, 0, sizeof(rg_argumentos));
        vManejaArgs(argc, argv);
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
		fprintf(stderr, "\nstArgs.szUser        [%s]\n", stArgs.szUser);
		fprintf(stderr, "\nstArgs.szPass        [%s]\n", stArgs.szPass);
	
		strcpy(szhUser, stArgs.szUser);                                                      
		strcpy(szhPass, stArgs.szPass);                                                    
		if(fnOraConnect(szhUser, szhPass) == FALSE)                                          
		{                                                                                  
		   	fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
		   	exit(EXIT_205);                                                            
		}                                                                                  
		else                                                                               
		{                                                                                  
	   		fprintf(stderr, "\nConexion con la base de datos ha sido exitosa.\n");     
	   		fprintf(stderr, "Username: %s\n\n", szhUser);                              
		}
/*---------------------------------------------------------------------------*/
/* Inicia estructura de proceso y bloques.                                   */
/*---------------------------------------------------------------------------*/
        vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,szhUser, stArgs.izSecuencia);
        ibiblio = iAccesa_Traza_Procesos(ABRIR_TRAZA,0,"",0,0);
        if (ibiblio)
        {
            fprintf(stderr, "Error al Abrir Traza");
            fprintf(stderr, "Error [%d] al escribir Traza de Proceso.\n", ibiblio);
            exit(ibiblio);
        }
        
/*---------------------------------------------------------------------------*/
/* Configuracion de idioma espanol para tratamiento de fechas.               */
/*---------------------------------------------------------------------------*/
        if(strcmp(getenv("LC_TIME"), LC_TIME_SPANISH) == 0)
        {
                setlocale(LC_TIME, LC_TIME_SPANISH);
        }
/*---------------------------------------------------------------------------*/
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
        fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");
        if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)
        {
                exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_LOG NO RECONOCIDA.",0,0));
        }
        fprintf(stderr, "Directorio de Logs            : [%s]\n", (char *)pszEnvLog);
/*---------------------------------------------------------------------------*/
/* Generacion del nombre y creacion del archivo de log.                      */
/*---------------------------------------------------------------------------*/
		strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
                strncpy(szhSysDate, pszGetDateLog(),16);                                                            
		strcpy(stArgsLog.szProceso,LOGNAME);                                                                     
		strncpy(stArgsLog.szSysDate,szhSysDate,16);                                                                  
		sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);                       
	                                                                                                         
		if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)                                                          
		{                                                                                                        
		    fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", LOGNAME);                                 
	    	fprintf(stderr, "Revise su existencia.\n");                                                          
	    	fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                
	    	fprintf(stderr, "Proceso finalizado con error.\n");                                                  
        	exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE DATOS NO PUDO SER ABIERTO.",0,0));
		}                                                                                                               
/*---------------------------------------------------------------------------*/
/* Header.                                                                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();                                                               
    	fprintf(stderr, "Procesando ...\n");                                        
    	fprintf(pfLog, "%s\n", szRaya);                    
    	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    	fprintf(pfLog, "%s\n", GLOSA_PROG);                
    	fprintf(pfLog, "VERSION %s\n", PROG_VERSION);      
    	fprintf(pfLog, "Ultima Revision: [%s]\n", LAST_REVIEW);                
    	fprintf(pfLog, "%s\n\n", szRaya);                  

    	fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    	fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
        /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy hh24:mi:ss'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy hh24:\
mi:ss'";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )237;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


/*---------------------------------------------------------------------------*/
/* Procesamiento principal:                                                  */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
    	fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    	fprintf(pfLog,  "Carga estructura de ciclo de proceso...\n\n");       
    	fprintf(stderr, "Carga estructura de ciclo de proceso...\n\n");       
    	if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    	{
	    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    		fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    		fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    		fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    		exit(EXIT_101);
    	}
    	strcpy(szhIdPeriodo , stArgs.szIdPeriodo);   
        fprintf(pfLog,"Fecha DESDE (fec_acep_ant): [%s]\n", stCiclo.szFecDesdeAceptacion);
        fprintf(pfLog,"Fecha HASTA (fec_acep_act): [%s]\n", stCiclo.szFecHastaAceptacion);      
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE HABILITACIONES CELULAR.              */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevHabCel) Eliminando registros desde CMT_HABIL_CELULAR...\n");
		fprintf(stderr,"\n(vRevHabCel) Eliminando registros desde CMT_HABIL_CELULAR...\n");
        vRevHabCel();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE HABILITACIONES PREPAGO.              */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevHabPre) Eliminando registros desde CMT_HABIL_PREPAGO...\n");
		fprintf(stderr,"\n(vRevHabPre) Eliminando registros desde CMT_HABIL_PREPAGO...\n");
        vRevHabPre();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE BONOS POR CARTERA.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevBonosCartera) Eliminando registros desde CMT_BONOSCARTERA...\n");
		fprintf(stderr,"\n(vRevBonosCartera) Eliminando registros desde CMT_BONOSCARTERA...\n");
        vRevBonosCartera();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE BAJAS PREMATURAS.                    */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevBajasCel) Eliminando registros desde CMT_BAJAS_CELULAR...\n");
		fprintf(stderr,"\n(vRevBajasCel) Eliminando registros desde CMT_BAJAS_CELULAR...\n");
        vRevBajasCel();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE RECHAZOS DE VENTA.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevRechaCel) Eliminando registros desde CMT_RECHAZOS_CELULAR...\n");
		fprintf(stderr,"\n(vRevRechaCel) Eliminando registros desde CMT_RECHAZOS_CELULAR...\n");
        vRevRechaCel();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DE LA CARTERA DE ABONADOS DE DISTRIBUIDORES.         */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevCartera) Eliminando registros desde CMT_CARTERA...\n");
		fprintf(stderr,"\n(vRevCartera) Eliminando registros desde CMT_CARTERA...\n");
        vRevCartera();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE VENTAS PENDIENTES.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevVtasPendientes) Eliminando registros desde CMT_VENTAS_PENDIENTES...\n");
		fprintf(stderr,"\n(vRevVtasPendientes) Eliminando registros desde CMT_VENTAS_PENDIENTES...\n");
        vRevVtasPendientes();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE VENTAS PENDIENTES.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevEvalChurn) Eliminando registros desde CM_EVALUA_CHURN_TO...\n");
		fprintf(stderr,"\n(vRevEvalChurn) Eliminando registros desde CM_EVALUA_CHURN_TO...\n");
        vRevEvalChurn();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE VENTAS PENDIENTES.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevEvalConvenios) Eliminando registros desde CM_CONVENIOS_TO...\n");
		fprintf(stderr,"\n(vRevEvalConvenios) Eliminando registros desde CM_CONVENIOS_TO...\n");
        vRevEvalConvenios();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE VENTAS PENDIENTES.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevEvaluaciones) Eliminando registros desde CM_EVALUACIONES_TO...\n");
		fprintf(stderr,"\n(vRevEvaluaciones) Eliminando registros desde CM_EVALUACIONES_TO...\n");
        vRevEvaluaciones();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE RETENCIONES.                         */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevRetenciones) Eliminando registros desde CM_RETENCIONES_TO...\n");
		fprintf(stderr,"\n(vRevRetenciones) Eliminando registros desde CM_RETENCIONES_TO...\n");
        vRevRetenciones();
/*---------------------------------------------------------------------------*/
/* RUTINA PARA LIMPIEZA DEL UNIVERSO DE VENTAS PENDIENTES.                   */
/*---------------------------------------------------------------------------*/
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vRevEnlaceHist) Eliminando registros desde CM_ENLACEHIST_TO...\n");
		fprintf(stderr,"\n(vRevEnlaceHist) Eliminando registros desde CM_ENLACEHIST_TO...\n");
        vRevEnlaceHist();
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
        lSegFin=lGetTimer();
        stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
        fprintf(pfLog, "\nEstadistica del proceso\n");
        fprintf(pfLog, "------------------------\n");
        fprintf(pfLog, "Segundos reales utilizados                      : [%d]\n", stStatusProc.lSegProceso);
        fprintf(pfLog, "Ventas Contrato eliminadas                      : [%d]\n", stStatusProc.lCantHabCel);
        fprintf(pfLog, "Habilitaciones Amistar eliminadas               : [%d]\n", stStatusProc.lCantHabPre);
        fprintf(pfLog, "Registros de recaudacion cartera eliminados     : [%d]\n", stStatusProc.lCantBonTraf);
        fprintf(pfLog, "Bajas de contrato prepamaturas eliminadas       : [%d]\n", stStatusProc.lCantBajas);
        fprintf(pfLog, "Rechazos de Venta eliminados                    : [%d]\n", stStatusProc.lCantRecha);
        fprintf(pfLog, "Ventas Pendientes eliminadas                    : [%d]\n", stStatusProc.lCantVtasPend);
        fprintf(pfLog, "Registros de cartera de abonado eliminados      : [%d]\n", stStatusProc.lCantCartera);
        fprintf(pfLog, "Evaluaciones de Riesgo eliminadas               : [%d]\n", stStatusProc.lCantEvalua);
        fprintf(pfLog, "Evaluaciones de la vble. CHURN eliminadas       : [%d]\n", stStatusProc.lCantChurn);
        fprintf(pfLog, "Retenciones eliminadas                          : [%d]\n", stStatusProc.lCantRetenciones);
        fprintf(pfLog, "Convenios PAC eliminados                        : [%d]\n", stStatusProc.lCantConvenios);
        fprintf(pfLog, "Registros de Enlace Historico eliminados        : [%d]\n", stStatusProc.lCantEnlaces);

        ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,0);
        if (ibiblio)
                exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
        /* EXEC SQL COMMIT WORK RELEASE; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )252;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 
          
		vFechaHora();
		fprintf(stderr, "Programa [%s] finalizado ok.\n", basename(argv[0]));
		fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
		fprintf(pfLog, "Proceso [%s] finalizado ok.\n", basename(argv[0]));
		fclose(pfLog);
		return(EXIT_0);        
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

