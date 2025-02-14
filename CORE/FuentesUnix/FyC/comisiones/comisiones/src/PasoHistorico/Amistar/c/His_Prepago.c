
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
           char  filnam[20];
};
static struct sqlcxp sqlfpn =
{
    19,
    "./pc/His_Prepago.pc"
};


static unsigned int sqlctx = 27663651;


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
   unsigned char  *sqhstv[1];
   unsigned long  sqhstl[1];
            int   sqhsts[1];
            short *sqindv[1];
            int   sqinds[1];
   unsigned long  sqharm[1];
   unsigned long  *sqharc[1];
   unsigned short  sqadto[1];
   unsigned short  sqtdso[1];
} sqlstm = {12,1};

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
5,0,0,1,596,0,3,53,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,2,326,0,3,108,0,0,1,1,0,1,0,1,3,0,0,
43,0,0,3,430,0,3,140,0,0,1,1,0,1,0,1,3,0,0,
62,0,0,4,61,0,2,195,0,0,1,1,0,1,0,1,3,0,0,
81,0,0,5,52,0,2,203,0,0,1,1,0,1,0,1,97,0,0,
100,0,0,6,57,0,2,212,0,0,1,1,0,1,0,1,3,0,0,
119,0,0,7,48,0,1,335,0,0,0,0,0,1,0,
134,0,0,8,0,0,30,399,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de generar registros historicos de tablas Prepago */
/*----------------------------------------------------------------------*/
/* Version 2 - Revision 00.                                             */
/* Inicio: Martes 16 de Julio de 2002 .                                 */
/* Fin:                                                                 */
/* Autor : Nelson Contreras Helena                                      */
/************************************************************************/
/* 20030929 Marcelo Quiroz G. Versionado Cuzco.                         */
/* Se filtra carga de tablas historicas por los campos id_periodo y     */
/* tip_comis                                                            */
/*                                                                      */
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de libreria para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "His_Prepago.h"
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
	char    szhIdPeriodo[11];
	long    lhCodPeriodo;
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* Carga Tablas Historicas                                                   */
/*---------------------------------------------------------------------------*/
int  iCargaTablasHist()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhIdPeriodo[11];
		char	szNomTablaProceso[31];
		char	szNomTablaHistorica[31];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhIdPeriodo, stCiclo.szIdCiclComis);
	
	fprintf(pfLog , "\n[iCargaTablasHist] Carga los datos en Histórico Ciclo:[%s]\n", szhIdPeriodo);
	fprintf(stderr, "\n[iCargaTablasHist] Carga los datos en Histórico Ciclo:[%s]\n", szhIdPeriodo);

	/* EXEC SQL
    	INSERT INTO CM_HABIL_PREPAGO_TH
                (NUM_GENERAL, 
                 COD_TIPCOMIS, 
                 COD_COMISIONISTA, 
                 COD_AGENCIA, 
                 COD_VEND_FINAL, 
                 COD_OFICINA, 
                 FEC_HABILITACION, 
                 COD_CLIENTE, 
                 NUM_IDENT, 
                 NUM_ABONADO, 
                 NUM_CELULAR, 
                 NUM_SERIE, 
                 COD_ARTICULO, 
                 COD_FABRICANTE, 
                 COD_PERIODO, 
                 ID_PERIODO,
                 IND_PROCEQUI, 
                 COD_TIPORED, 
                 COD_TIPVENDEDOR)
                (SELECT NUM_GENERAL, 
                        COD_TIPCOMIS, 
                        COD_COMISIONISTA, 
                        COD_AGENCIA, 
                        COD_VEND_FINAL, 
                        COD_OFICINA, 
                        FEC_HABILITACION, 
                        COD_CLIENTE, 
                        NUM_IDENT, 
                        NUM_ABONADO, 
                        NUM_CELULAR, 
                        NUM_SERIE, 
                        COD_ARTICULO, 
                        COD_FABRICANTE, 
                        COD_PERIODO, 
                        ID_PERIODO,                  
                        IND_PROCEQUI, 
                 		COD_TIPORED, 
                 		COD_TIPVENDEDOR 
                  FROM CMT_HABIL_PREPAGO
                  WHERE ID_PERIODO = :szhIdPeriodo); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CM_HABIL_PREPAGO_TH (NUM_GENERAL,COD_TIPCOMIS,CO\
D_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,COD_OFICINA,FEC_HABILITACION,COD_CLI\
ENTE,NUM_IDENT,NUM_ABONADO,NUM_CELULAR,NUM_SERIE,COD_ARTICULO,COD_FABRICANTE,C\
OD_PERIODO,ID_PERIODO,IND_PROCEQUI,COD_TIPORED,COD_TIPVENDEDOR)(select NUM_GEN\
ERAL ,COD_TIPCOMIS ,COD_COMISIONISTA ,COD_AGENCIA ,COD_VEND_FINAL ,COD_OFICINA\
 ,FEC_HABILITACION ,COD_CLIENTE ,NUM_IDENT ,NUM_ABONADO ,NUM_CELULAR ,NUM_SERI\
E ,COD_ARTICULO ,COD_FABRICANTE ,COD_PERIODO ,ID_PERIODO ,IND_PROCEQUI ,COD_TI\
PORED ,COD_TIPVENDEDOR  from CMT_HABIL_PREPAGO where ID_PERIODO=:b0)";
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
 if (sqlca.sqlcode < 0) vSqlError();
}


    
    if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
         fprintf(pfLog, "Error al insertar en CM_HABIL_PREPAGO_TH ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }
    
	strcpy(szNomTablaProceso, "CMT_HABIL_PREPAGO");
    strcpy(szNomTablaHistorica, "CM_HABIL_PREPAGO_TH");
	
	vCierraEnlace(szNomTablaProceso,szNomTablaHistorica,szhIdPeriodo);    
    stStatusProc.lRegInsertosPrepago = sqlca.sqlerrd[2] ;
  
	/* EXEC SQL    
    	INSERT INTO CM_TRAF_PREPAGO_TH
                (NUM_CELULAR, 
                 NUM_SERIE, 
                 COD_PERIODO_HAB, 
                 COD_PERIODO_EVAL, 
                 UNI_ENTRADA, 
                 UNI_SALIDA, 
                 UNI_TOTALES, 
                 TIP_UNITAS, 
                 IMP_COMISION)
                (SELECT NUM_CELULAR, 
                        NUM_SERIE, 
                        COD_PERIODO_HAB, 
                        COD_PERIODO_EVAL, 
                        UNI_ENTRADA, 
                        UNI_SALIDA, 
                        UNI_TOTALES, 
                        TIP_UNITAS, 
                        IMP_COMISION
                 FROM CMT_TRAF_PREPAGO
                WHERE COD_PERIODO_EVAL = :lhCodPeriodo); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CM_TRAF_PREPAGO_TH (NUM_CELULAR,NUM_SERIE,COD_PE\
RIODO_HAB,COD_PERIODO_EVAL,UNI_ENTRADA,UNI_SALIDA,UNI_TOTALES,TIP_UNITAS,IMP_C\
OMISION)(select NUM_CELULAR ,NUM_SERIE ,COD_PERIODO_HAB ,COD_PERIODO_EVAL ,UNI\
_ENTRADA ,UNI_SALIDA ,UNI_TOTALES ,TIP_UNITAS ,IMP_COMISION  from CMT_TRAF_PRE\
PAGO where COD_PERIODO_EVAL=:b0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )24;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
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
 if (sqlca.sqlcode < 0) vSqlError();
}


    
    if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
         fprintf(pfLog, "Error al insertar en CM_TRAF_PREPAGO_TH ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }
	strcpy(szNomTablaProceso, "CMT_TRAF_PREPAGO");
    strcpy(szNomTablaHistorica,"CM_TRAF_PREPAGO_TH");
	vCierraEnlace(szNomTablaProceso,szNomTablaHistorica,szhIdPeriodo);      
    
	/* EXEC SQL    
    	INSERT INTO CM_TRAF_CRITERIOS_TH 
                (NUM_GENERAL, 
                 NUM_CRITERIO, 
                 NUM_PERFIL, 
                 NUM_PERIODO, 
                 COD_PERIODO_HAB, 
                 COD_PERIODO_EVAL, 
                 TIP_UNITAS, 
                 UNI_ENTRADA, 
                 UNI_SALIDA, 
                 UNI_TOTAL, 
                 IMP_COMISION, 
                 COD_ORIGEN, 
                 MTO_RECARGA)
        (SELECT NUM_GENERAL, 
        		NUM_CRITERIO, 
        		NUM_PERFIL, 
        		NUM_PERIODO, 
        		COD_PERIODO_HAB, 
        		COD_PERIODO_EVAL, 
        		TIP_UNITAS, 
        		UNI_ENTRADA, 
        		UNI_SALIDA, 
        		UNI_TOTAL, 
        		IMP_COMISION, 
        		COD_ORIGEN, 
        		MTO_RECARGA 
        FROM CM_TRAF_CRITERIOS_TO
       WHERE COD_PERIODO_EVAL = :lhCodPeriodo); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CM_TRAF_CRITERIOS_TH (NUM_GENERAL,NUM_CRITERIO,N\
UM_PERFIL,NUM_PERIODO,COD_PERIODO_HAB,COD_PERIODO_EVAL,TIP_UNITAS,UNI_ENTRADA,\
UNI_SALIDA,UNI_TOTAL,IMP_COMISION,COD_ORIGEN,MTO_RECARGA)(select NUM_GENERAL ,\
NUM_CRITERIO ,NUM_PERFIL ,NUM_PERIODO ,COD_PERIODO_HAB ,COD_PERIODO_EVAL ,TIP_\
UNITAS ,UNI_ENTRADA ,UNI_SALIDA ,UNI_TOTAL ,IMP_COMISION ,COD_ORIGEN ,MTO_RECA\
RGA  from CM_TRAF_CRITERIOS_TO where COD_PERIODO_EVAL=:b0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )43;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
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
 if (sqlca.sqlcode < 0) vSqlError();
}

                                  
    
    if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
         fprintf(pfLog, "Error al insertar en CM_TRAF_CRITERIOS_TH ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }        

	strcpy(szNomTablaProceso, "CM_TRAF_CRITERIOS_TO");
    strcpy(szNomTablaHistorica,"CM_TRAF_CRITERIOS_TH");
	vCierraEnlace(szNomTablaProceso,szNomTablaHistorica,szhIdPeriodo);      
    stStatusProc.lRegInsertosTraf = sqlca.sqlerrd[2] ;
        
    return TRUE;
}
/*---------------------------------------------------------------------------*/
/* Borra tablas actuales                                                    */
/*---------------------------------------------------------------------------*/
int iBorraTablasTo()
{
   	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhCodPeriodo;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	lhCodPeriodo = stCiclo.lCodCiclComis;
    
    /* EXEC SQL DELETE FROM CM_TRAF_CRITERIOS_TO WHERE COD_PERIODO_EVAL = :lhCodPeriodo ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from CM_TRAF_CRITERIOS_TO  where COD_PERIODO_EVAL\
=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )62;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}

 
    if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
         fprintf(pfLog , "\n[iBorraTablasTo]Error al borrar CM_TRAF_CRITERIOS_TO ORA[%d]\n",sqlca.sqlcode);
         fprintf(stderr, "\n[iBorraTablasTo]Error al borrar CM_TRAF_CRITERIOS_TO ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }

    /* EXEC SQL DELETE FROM CMT_HABIL_PREPAGO WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from CMT_HABIL_PREPAGO  where ID_PERIODO=:b0";
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
    if (sqlca.sqlcode < 0) vSqlError();
}

 
    if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
         fprintf(pfLog , "\n[iBorraTablasTo]Error al borrar CMT_HABIL_PREPAGO ORA[%d]\n",sqlca.sqlcode);
         fprintf(stderr, "\n[iBorraTablasTo]Error al borrar CMT_HABIL_PREPAGO ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }

    
    /* EXEC SQL DELETE FROM CMT_TRAF_PREPAGO WHERE COD_PERIODO_EVAL = :lhCodPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from CMT_TRAF_PREPAGO  where COD_PERIODO_EVAL=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )100;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}

 
    if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {
         fprintf(pfLog , "\n[iBorraTablasTo]Error al borrar CMT_TRAF_PREPAGO ORA[%d]\n",sqlca.sqlcode);
         fprintf(stderr, "\n[iBorraTablasTo]Error al borrar CMT_TRAF_PREPAGO ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }

    return TRUE ;
}

/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int     main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
	long  lSegIni, lSegFin;         
	short ibiblio;                      
    int   iRetorno;    
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
    memset(&stCiclo, 0, sizeof(reg_ciclo));
    memset(&stStatusProc, 0, sizeof(rg_estadistica));
    memset(&proceso, 0, sizeof(proceso));
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
    if((pszEnvCfg = (char *)pszEnviron("XPCM_CFG", "")) == (char *)NULL)
    {
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_CFG NO RECONOCIDA.",0,0));
    }
       
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);
/*------------------------------------------------------------*/        
/* Ingresa parametros para estructura que crea archivo de Log */
/*------------------------------------------------------------*/  
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
    fprintf(pfLog, "VERSION             : [%s]\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision     : [%s]\n", LAST_REVIEW);                
	fprintf(pfLog, "Base de datos       : [%s]\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "Usuario ORACLE      : [%s]\n",(char * )sysGetUserName()); 
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )119;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/*    - Recupera fechas que conforman periodo del parametro.                 */
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
    lhCodPeriodo        = stCiclo.lCodCiclComis;
 
/*---------------------------------------------------------------------------------------------*/
/*    - Carga tablas                                                      */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
	fprintf(pfLog ,"\n(vCargaTablasHist) Carga Tabla Historica.\n");
	fprintf(stderr,"\n(vCargaTablasHist) Carga Tabla Historica.\n");
    iRetorno = iCargaTablasHist();       
/*---------------------------------------------------------------------------------------------*/
/*    - Borra tablas ya pasadas a historico                                                    */
/*---------------------------------------------------------------------------------------------*/
    if ( iRetorno )
    {
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(iBorraTablasTo) Borra Tablas Actuales.\n");
		fprintf(stderr,"\n(iBorraTablasTo) Borra Tablas Actuales.\n");
        iRetorno = iBorraTablasTo(); 
    }
    else
        fprintf(pfLog ,"No Carga tablas Historicas , proceso con ERROR\n");	            
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
	fprintf(pfLog,  "Estadistica del proceso\n");
	fprintf(pfLog,  "------------------------\n");
	fprintf(pfLog,  "Segundos Reales Utilizados                  : [%d]\n\n", stStatusProc.lSegProceso);
	fprintf(pfLog,  "Registros pasados a historico Prepago       : [%d]\n"  , stStatusProc.lRegInsertosPrepago);
	fprintf(pfLog,  "Registros pasados a historico Traf Prepago  : [%d]\n"  , stStatusProc.lRegInsertosTraf);   

	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr,"------------------------\n");
	fprintf(stderr, "Segundos Reales Utilizados                  : [%d]\n\n", stStatusProc.lSegProceso);
	fprintf(stderr, "Registros pasados a historico Prepago       : [%d]\n"  , stStatusProc.lRegInsertosPrepago);
	fprintf(stderr, "Registros pasados a historico Traf Prepago  : [%d]\n"  , stStatusProc.lRegInsertosTraf);   

/*---------------------------------------------------------------------------*/
	ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lRegInsertosPrepago);
	if (ibiblio)
	        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )134;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
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

