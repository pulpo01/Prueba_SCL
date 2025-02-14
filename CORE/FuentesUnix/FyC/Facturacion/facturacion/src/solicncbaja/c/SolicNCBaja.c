
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
    "./pc/SolicNCBaja.pc"
};


static unsigned int sqlctx = 27732579;


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
   unsigned char  *sqhstv[10];
   unsigned long  sqhstl[10];
            int   sqhsts[10];
            short *sqindv[10];
            int   sqinds[10];
   unsigned long  sqharm[10];
   unsigned long  *sqharc[10];
   unsigned short  sqadto[10];
   unsigned short  sqtdso[10];
} sqlstm = {12,10};

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
"select ROWID ,COD_CLIENTE ,NUM_ABONADO ,TO_CHAR(FEC_SOLICITUD,'DD-MM-YYYY HH\
24:MI:SS') ,TO_CHAR(FEC_SOLICITUD,'YYYYMMDD') ,FLG_EMISION ,NOM_USUARIO_SOLIC \
 from FAT_SOLICNCBAJA where (COD_CICLFACT=:b0 and FLG_EMISION=0)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,68,0,4,115,0,0,1,0,0,1,0,2,97,0,0,
24,0,0,2,229,0,9,139,0,0,1,1,0,1,0,1,3,0,0,
43,0,0,2,0,0,13,146,0,0,7,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,
3,0,0,2,97,0,0,
86,0,0,2,0,0,15,180,0,0,0,0,0,1,0,
101,0,0,3,54,0,4,197,0,0,1,0,0,1,0,2,3,0,0,
120,0,0,4,45,0,2,221,0,0,1,1,0,1,0,1,5,0,0,
139,0,0,5,305,0,3,269,0,0,10,10,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
194,0,0,6,141,0,6,328,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,
233,0,0,7,89,0,4,335,0,0,3,1,0,1,0,2,3,0,0,2,97,0,0,1,3,0,0,
260,0,0,8,83,0,4,345,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
283,0,0,9,85,0,4,357,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
306,0,0,10,0,0,29,389,0,0,0,0,0,1,0,
321,0,0,11,48,0,1,674,0,0,0,0,0,1,0,
336,0,0,12,0,0,30,724,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las habilitaciones del producto    */
/* para luego pasar a la etapa de valoración.                           */ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Lunes 24 de Octubre del 2001.                                */
/* Fin:                                                                 */
/* Autor : Fabian Aedo Ramirez                                          */
/************************************************************************/
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include <SolicNCBaja.h>
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

char	szhUser[30]="";
char	szhPass[30]="";
char	szhSysDate [15]="";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* -- Muestra el contenido de un nodo de la lista de universo...             */
/*---------------------------------------------------------------------------*/
void	vMuestraRegistro(stUniverso * paux,int pLOG,char * pszFuncName,int iTraza)
{
	if (iTraza == 0)
	{
		vDTrazasLog(szFuncName, "\n\n\tProceso : %s"
									"\n\tCliente          :[%d]"
									"\n\tAbonado          :[%d]"
									"\n\tCiclo            :[%d]"
									"\n\tFecha Baja       :[%s]"
									"\n\tFecha Solicitud  :[%s]"
									"\n\tNumProceso       :[%d]"
									"\n\tFecha Proceso    :[%s]"
									"\n\tFlg.Emision      :[%d]"
									"\n\tGls.Emision      :[%s]"
									"\n\tUsuario Solic    :[%s]"
									"\n\tFecha Ult.Mod.   :[%s]",
									pLOG,
									pszFuncName,
									paux->lCodCliente,
									paux->lNumAbonado,
									paux->iCodCiclFact,
									paux->szFecBaja,
									paux->szFecSolicitud,
									paux->lNumProceso,
									paux->szFecProceso,
									paux->iFlagEmision,
									paux->szGlsEmision,
									paux->szNomUsuarioSolic,
									paux->szFecUltMod);
	}
	else
	{
		vDTrazasError(szFuncName, "\n\n\tProceso : %s"
									"\n\tCliente          :[%d]"
									"\n\tAbonado          :[%d]"
									"\n\tCiclo            :[%d]"
									"\n\tFecha Baja       :[%s]"
									"\n\tFecha Solicitud  :[%s]"
									"\n\tNumProceso       :[%d]"
									"\n\tFecha Proceso    :[%s]"
									"\n\tFlg.Emision      :[%d]"
									"\n\tGls.Emision      :[%s]"
									"\n\tUsuario Solic    :[%s]"
									"\n\tFecha Ult.Mod.   :[%s]",
									pLOG,
									pszFuncName,
									paux->lCodCliente,
									paux->lNumAbonado,
									paux->iCodCiclFact,
									paux->szFecBaja,
									paux->szFecSolicitud,
									paux->lNumProceso,
									paux->szFecProceso,
									paux->iFlagEmision,
									paux->szGlsEmision,
									paux->szNomUsuarioSolic,
									paux->szFecUltMod);

	}
}
/*---------------------------------------------------------------------------*/
/* Se extrae el universo inicial de registros a considerar para Comisiones.  */
/*---------------------------------------------------------------------------*/
void vCreaUniverso()
{
	stUniverso 	* paux;
	long		lCantSolic=0;
	int			i;
	long 		iLastRows    = 0;
	int   		iFetchedRows = MAXFETCH;
	int   		iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lMaxFetch;
		int		ihCodCiclFact;
		
		char	szhRowId[MAXFETCH][20];
		long	lhCodCliente[MAXFETCH];
		long	lhNumAbonado[MAXFETCH];
		char	szhFecSolicitud[MAXFETCH][22];
		char	szhFecBaja[MAXFETCH][9];
		int		ihFlagEmision[MAXFETCH];
		char	szhNomUsuarioSolic[MAXFETCH][31];
		char	szhFecUltMod[22];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') INTO :szhFecUltMod FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') into :b0  fr\
om DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecUltMod;
 sqlstm.sqhstl[0] = (unsigned long )22;
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


	
	vDTrazasLog(szFuncName,"\n\n\tError En SELECT SYSDATE "
	                         "\n\t *** %d ***",LOG03,sqlca.sqlcode);
	
	ihCodCiclFact = stArgs.lCodPeriodo;
	lMaxFetch     = MAXFETCH;

	/* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR SELECT 	
		ROWID,
		COD_CLIENTE, 
		NUM_ABONADO, 
		TO_CHAR(FEC_SOLICITUD,'DD-MM-YYYY HH24:MI:SS'), 
		TO_CHAR(FEC_SOLICITUD,'YYYYMMDD'),
		FLG_EMISION, 
		NOM_USUARIO_SOLIC
		FROM FAT_SOLICNCBAJA
		WHERE COD_CICLFACT = :ihCodCiclFact
		  AND FLG_EMISION  = 0; */ 

		
		
	vDTrazasLog(szFuncName,"\n\n\tError En DECLARE UNIVERSO "
	                         "\n\t *** %d ***",LOG03,sqlca.sqlcode);  
	
	/* EXEC SQL OPEN CUR_UNIVERSO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0002;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )24;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclFact;
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


	
	vDTrazasLog(szFuncName,"\n\n\tError En OPEN UNIVERSO "
	                         "\n\t *** %d ***",LOG03,sqlca.sqlcode);
	
	while(iFetchedRows == iRetrievRows)
	{
		/* EXEC SQL for :lMaxFetch
			 FETCH CUR_UNIVERSO INTO :szhRowId,:lhCodCliente,:lhNumAbonado,
			 :szhFecSolicitud,:szhFecBaja,:ihFlagEmision,:szhNomUsuarioSolic; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )43;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowId;
  sqlstm.sqhstl[0] = (unsigned long )20;
  sqlstm.sqhsts[0] = (         int  )20;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhNumAbonado;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecSolicitud;
  sqlstm.sqhstl[3] = (unsigned long )22;
  sqlstm.sqhsts[3] = (         int  )22;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecBaja;
  sqlstm.sqhstl[4] = (unsigned long )9;
  sqlstm.sqhsts[4] = (         int  )9;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)ihFlagEmision;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )sizeof(int);
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhNomUsuarioSolic;
  sqlstm.sqhstl[6] = (unsigned long )31;
  sqlstm.sqhsts[6] = (         int  )31;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
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


			 
		
		vDTrazasLog(szFuncName,"\n\n\tFETCH UNIVERSO"
	                         "\n\t *** %d ***",LOG03,sqlca.sqlcode);
		
		
		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
		iLastRows = sqlca.sqlerrd[2];
		for (i=0; i < iRetrievRows; i++)
		{
			paux = (stUniverso *) malloc(sizeof(stUniverso));
			
			strcpy(paux->szRowId			,	alm_trim(szhRowId[i]));
			strcpy(paux->szFecSolicitud     ,   alm_trim(szhFecSolicitud[i]));
			strcpy(paux->szFecBaja          ,   alm_trim(szhFecBaja[i]));
			strcpy(paux->szNomUsuarioSolic  ,   alm_trim(szhNomUsuarioSolic[i]));
			strcpy(paux->szFecUltMod        ,   alm_trim(szhFecUltMod));
			strcpy(paux->szFecProceso       ,   alm_trim(szhFecUltMod));

			paux->lCodCliente        =    lhCodCliente[i];
			paux->lNumAbonado        =    lhNumAbonado[i];
			paux->iCodCiclFact       =    ihCodCiclFact;
			paux->iFlagEmision       =    ihFlagEmision[i];
			
			vMuestraRegistro(paux,LOG05,"vCreaUniverso",0);			

			paux->sgte  = lstUniverso;
			lstUniverso = paux;
			lCantSolic++;
		}
	}
	/* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )86;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	
	
	vDTrazasLog(szFuncName, "\nCantidad de Solicitudes de NC leidas....[%d]\n",LOG03,lCantSolic);
	fprintf(stderr,"\nCantidad de Solicitudes de NC leidas....[%d]\n",lCantSolic);
	stStatusProc.iSolProc = lCantSolic;
}
/*---------------------------------------------------------------------------*/
/* Recupera el numero de la secuencia de la ga_seg_transacabo....            */
/*---------------------------------------------------------------------------*/
long	lfnGetNumSecuencia()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	ihNumSec;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL SELECT GA_SEQ_TRANSACABO.NEXTVAL
			INTO :ihNumSec FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )101;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumSec;
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


	
	if(sqlca.sqlcode)
	{
		vDTrazasError("lfnGetNumSecuencia", "Error en ejecucion de la llamada al SELECT DEL nRO DE SECUENCIA \n",LOG03);
		vDTrazasLog("lfnGetNumSecuencia", "\n%s  Error en SELECT GA_SEG_TRANSACABO.NEXTVAL "
							   "\n  *** %s ***", LOG03, cfnGetTime(1),sqlca.sqlerrm.sqlerrmc);
		return(0);
	}
	return(ihNumSec);
}
/*---------------------------------------------------------------------------*/
/* Elimina unregistro desde la tabla de pendientes.                          */
/*---------------------------------------------------------------------------*/
int bfnEliminaPendiente(stUniverso * paux)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhRowId[20];/* EXEC SQL VAR szhRowId       IS STRING(20); */ 

	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhRowId       , paux->szRowId);
	vMuestraRegistro(paux,LOG05,"bfnEliminaPendiente",0);

	/* EXEC SQL DELETE FROM FAT_SOLICNCBAJA
		WHERE ROWID = :szhRowId; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from FAT_SOLICNCBAJA  where ROWID=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )120;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhRowId;
 sqlstm.sqhstl[0] = (unsigned long )20;
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


		
		
	if(sqlca.sqlcode==0)
	{
		return(TRUE);
	}
		
	vDTrazasError(szFuncName,"\n\n\tError Eliminando solicitud Rowid :[%s] "
	                         "\n\t *** %s ***\n",LOG03,szhRowId,sqlca.sqlerrm.sqlerrmc);
	vMuestraRegistro(paux,LOG03,"bfnEliminaPendiente",1);
	return(FALSE);

}
/*---------------------------------------------------------------------------*/
/* Replica regisro en histórico...                                           */
/*---------------------------------------------------------------------------*/
int bfnPasaHistorico(stUniverso * paux)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNumProceso;
		char	szhFecProceso[22];
		int		ihFlagEmision;
		char	szhGlsEmision[61];
		char	szhNomUsuarioSolic[31];
		char	szhFecUltMod[22];		

		long	lhCodCliente;
		long	lhNumAbonado;
		int		ihCodCiclFact;
		char	szhFecSolicitud[22];
	/* EXEC SQL END DECLARE SECTION; */ 

	vMuestraRegistro(paux,LOG05,"bfnPasaHistorico",0);

	lhNumProceso   = paux->lNumProceso;
	ihFlagEmision  = paux->iFlagEmision;
	lhCodCliente   = paux->lCodCliente;
	lhNumAbonado   = paux->lNumAbonado;
	ihCodCiclFact  = paux->iCodCiclFact;

	strcpy(szhGlsEmision       , paux->szGlsEmision);
	strcpy(szhFecUltMod        , paux->szFecUltMod);
	strcpy(szhFecProceso       , paux->szFecProceso);
	strcpy(szhNomUsuarioSolic  , paux->szNomUsuarioSolic);
	strcpy(szhFecSolicitud     , paux->szFecSolicitud);
	
	
	/* EXEC SQL 
	  INSERT INTO FAH_SOLICNCBAJA
		 (COD_CLIENTE, NUM_ABONADO, COD_CICLFACT, FEC_SOLICITUD, 
		  NUM_PROCESO, FEC_PROCESO, FLG_EMISION, GLS_EMISION, 
		  NOM_USUARIO_SOLIC, FEC_ULTMOD)
	  VALUES (:lhCodCliente, :lhNumAbonado, :ihCodCiclFact, TO_DATE(:szhFecSolicitud,'DD-MM-YYYY HH24:MI:SS'), 
		  :lhNumProceso, TO_DATE(:szhFecProceso,'DD-MM-YYYY HH24:MI:SS'), :ihFlagEmision, :szhGlsEmision, 
		  :szhNomUsuarioSolic, TO_DATE(:szhFecUltMod,'DD-MM-YYYY HH24:MI:SS')); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 10;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into FAH_SOLICNCBAJA (COD_CLIENTE,NUM_ABONADO,COD_CIC\
LFACT,FEC_SOLICITUD,NUM_PROCESO,FEC_PROCESO,FLG_EMISION,GLS_EMISION,NOM_USUARI\
O_SOLIC,FEC_ULTMOD) values (:b0,:b1,:b2,TO_DATE(:b3,'DD-MM-YYYY HH24:MI:SS'),:\
b4,TO_DATE(:b5,'DD-MM-YYYY HH24:MI:SS'),:b6,:b7,:b8,TO_DATE(:b9,'DD-MM-YYYY HH\
24:MI:SS'))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )139;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecSolicitud;
 sqlstm.sqhstl[3] = (unsigned long )22;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumProceso;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecProceso;
 sqlstm.sqhstl[5] = (unsigned long )22;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihFlagEmision;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhGlsEmision;
 sqlstm.sqhstl[7] = (unsigned long )61;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhNomUsuarioSolic;
 sqlstm.sqhstl[8] = (unsigned long )31;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhFecUltMod;
 sqlstm.sqhstl[9] = (unsigned long )22;
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


	
		  
	if(sqlca.sqlcode==0)
	{
		return(TRUE);
	}
	
	vDTrazasError(szFuncName,"\n\n\tError En Paso a Historico "
	                         "\n\t *** %s ***",LOG03,sqlca.sqlerrm.sqlerrmc);
	vMuestraRegistro(paux,LOG03,"bfnPasaHistorico",1);
	return(FALSE);
}
/*---------------------------------------------------------------------------*/
/* Procesa el universo...                                                    */
/*---------------------------------------------------------------------------*/
int bfnProcSolicitudes()
{
	stUniverso   * paux;
	long		lCantEmitidas   = 0;
	long		lCantRechazadas = 0;
	int			bResp = TRUE;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhCodCliente;
		char	szhFecSolicitud[22];
		long	lhNumAbonado;
		char	szhNomUsuarioSolic[31];
		int		ihCodCiclFact;
		long	ihNumProceso;
		long	lhNumInterfaz;
		char	szhFecProceso[22];
		char	szhGlsEmision[61];
		char	szhFecUltMod[22];	
		char	szhDesCadena[256];
		int		ihCodRetorno;
	/* EXEC SQL END DECLARE SECTION; */ 


		for(paux = lstUniverso; paux != NULL; paux = paux->sgte)
		{
			ihNumProceso               = lfnGetNumSecuencia();
			if (ihNumProceso == 0)
				return(1);
			lhCodCliente               = paux->lCodCliente;           
			strcpy(szhFecSolicitud     , paux->szFecBaja);    
			lhNumAbonado               = paux->lNumAbonado;           
			strcpy(szhNomUsuarioSolic  , paux->szNomUsuarioSolic); 
			ihCodCiclFact              = paux->iCodCiclFact;           
			lhNumInterfaz              = 0;
			
			vMuestraRegistro(paux,LOG05,"Antes de PL",0);
			
			/* EXEC SQL EXECUTE 
				BEGIN 
					FA_PROC_NCBAJAS(:lhCodCliente,:lhNumAbonado,:szhFecSolicitud,1,:szhNomUsuarioSolic,:ihNumProceso,:ihCodCiclFact);
	      			END;                            
	    		END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 10;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin FA_PROC_NCBAJAS ( :lhCodCliente , :lhNumAbonado , :s\
zhFecSolicitud , 1 , :szhNomUsuarioSolic , :ihNumProceso , :ihCodCiclFact ) ; \
END ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )194;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhFecSolicitud;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNomUsuarioSolic;
   sqlstm.sqhstl[3] = (unsigned long )31;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihNumProceso;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCiclFact;
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


			vMuestraRegistro(paux,LOG05,"Despues de PL",0);
			
			/* EXEC SQL SELECT COD_RETORNO,DES_CADENA INTO :ihCodRetorno,:szhDesCadena
			FROM GA_TRANSACABO
			WHERE NUM_TRANSACCION = :ihNumProceso; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 10;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_RETORNO ,DES_CADENA into :b0,:b1  from GA_TRANS\
ACABO where NUM_TRANSACCION=:b2";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )233;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodRetorno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhDesCadena;
   sqlstm.sqhstl[1] = (unsigned long )256;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihNumProceso;
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


			vDTrazasLog("Procesa Solicitudes","\n\n\tResultado de la PL        :"
											  "\n\t Cod_Retorno: [%d] "
											  "\n\t Des_Cadena : [%s] ",LOG05,
											  ihCodRetorno,alm_trim(szhDesCadena));
			switch(ihCodRetorno)
			{
				case 0:
					/* EXEC SQL SELECT TO_NUMBER(DES_CADENA) 
						INTO :lhNumInterfaz
						FROM GA_TRANSACABO WHERE NUM_TRANSACCION = :ihNumProceso; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 10;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select TO_NUMBER(DES_CADENA) into :b0  from GA_TRANSACAB\
O where NUM_TRANSACCION=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )260;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumInterfaz;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihNumProceso;
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


	
					paux->lNumProceso = lhNumInterfaz;
					paux->iFlagEmision = 0;
					strcpy(paux->szGlsEmision , "PROCESADO POR DESCARGA MASIVA.");
					lCantEmitidas++;
	
					break;
				case 1:
				case 2:
					/* EXEC SQL SELECT SUBSTR(DES_CADENA ,1,59)
						INTO :szhDesCadena
						FROM GA_TRANSACABO WHERE NUM_TRANSACCION = :ihNumProceso; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 10;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select SUBSTR(DES_CADENA,1,59) into :b0  from GA_TRANSAC\
ABO where NUM_TRANSACCION=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )283;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhDesCadena;
     sqlstm.sqhstl[0] = (unsigned long )256;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihNumProceso;
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


	
					strcpy(paux->szGlsEmision , alm_trim(szhDesCadena));
					paux->lNumProceso = 0;
					paux->iFlagEmision = 0;
					lCantRechazadas++;
					break;
				default:
					strcpy(paux->szGlsEmision , "ERROR EN PROCESO. SE CANCELA OPERACION.");
					paux->lNumProceso = 0;
					paux->iFlagEmision = 0;
					lCantRechazadas++;
					break;
			}
				
			bResp = bfnPasaHistorico(paux);	
			
			if (bResp!=TRUE)
				break;
			
			bResp = bfnEliminaPendiente(paux);
			
			
			
			if (bResp!=TRUE)
			{
				break;
			}
			else
			{
				/* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )306;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

	
			}
		} 
		stStatusProc.iSolEmitidas   = lCantEmitidas;
		stStatusProc.iSolRechazadas = lCantRechazadas;
		vDTrazasLog(szFuncName, "\nCantidad de Solicitudes Emitidas  :[%d]\n",LOG03, lCantEmitidas);
		vDTrazasLog(szFuncName, "\nCantidad de Solicitudes Rechazadas:[%d]\n",LOG03, lCantRechazadas);
		return (bResp);
} 
/*---------------------------------------------------------------------------*/
/* Rutina encargada de quitar los espacios de la derecha                     */ 
/*---------------------------------------------------------------------------*/
char * alm_trim(char s[])
{   
	int i,indice=0;   

		for (i=0;i<strlen(s) && s[i]!='\0';i++)
		{       
			if (s[i] != ' ')          
				indice = i;   
		}   
		s[indice+1] = '\0';   
		return s;
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Universo                                       */
/*---------------------------------------------------------------------------*/
void vLiberaUniverso(stUniverso * paux)
{
		if (paux == NULL)
			return;
		else if (paux->sgte == NULL)
		{
			free(paux);
			return;
		}
		vLiberaUniverso(paux->sgte);
}
/*---------------------------------------------------------------------------*/
/* Rutina para manejo y validacion de argumentos ingresados como parametros  */
/* externos.                                                                 */
/*---------------------------------------------------------------------------*/
int  vManejaArgs (int argc, char * const argv[])
{
	int         iOpt = 0;
	extern char *optarg;
	char        opstring[] = ":u:p:l:";
	char        *szUserid_Aux;
	char        userid[70];

		while((iOpt=getopt(argc, argv, opstring)) != EOF)
		{
			switch(iOpt)
			{
			case 'u':
				if(stArgs.bFlagUser == FALSE)
				{
					if(optarg[0]=='-')
					{
						fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
						fprintf(stderr, "%s\n\n", szUso);
						return(1);
					}
					strcpy(userid, optarg);
					if((szUserid_Aux=(char *)strstr(userid,"/")) == (char *)NULL)
					{
						fprintf(stderr, "\nUsuario Oracle no es valido\n");
						fprintf(stderr, "%s\n\n", szUso);
						return(1);
					}
					else
					{
						strncpy(stArgs.szUser, userid, szUserid_Aux-userid);
						strcpy(stArgs.szPass, szUserid_Aux+1);
					}
				}
				else
			 	{
					fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
					fprintf(stderr, "%s\n\n", szUso);
					return(1);
				}
				stArgs.bFlagUser=TRUE;
				break;
	
			case 'p':
				if(stArgs.bFlagPeriodo == FALSE)
				{
					if(optarg[0]=='-')
					{
						fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
						fprintf(stderr, "%s\n\n", szUso);
						return(1);
					}
					stArgs.lCodPeriodo = atol(optarg);
				}
				else
			 	{
					fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
					fprintf(stderr, "%s\n\n", szUso);
					return(1);
				}
				stArgs.bFlagPeriodo = TRUE;
				break;
	
			case 'l':
				if(stArgs.bFlagLogLevel == FALSE)
				{
					if(optarg[0]=='-')
					{
						fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
						fprintf(stderr, "%s\n\n", szUso);
						return(1);
					}
					stArgs.iLogLevel = atoi(optarg);
				}
				else
			 	{
					fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
					fprintf(stderr, "%s\n\n", szUso);
					return(1);
				}
				stArgs.bFlagLogLevel = TRUE;
				break;
			case '?':
				fprintf(stderr, "Opcion -%c no reconocida. Se cancela.\n", optopt);
				fprintf(stderr, "%s\n\n", szUso);
				return(1);
			}  /* Fin switch */
		}     /* Fin while  */
		if(stArgs.bFlagPeriodo == FALSE)
		{
			fprintf(stderr, "%s\n", szRaya);
			fprintf(stderr, "Se requiere argumento -p[Periodo(<YYYYMM>)]\n");
			fprintf(stderr, "%s\n", szRaya);
			fprintf(stderr, "%s\n\n", szUso);
			return(1);
		}
		if(stArgs.bFlagLogLevel == FALSE)
		{
			stArgs.bFlagLogLevel = TRUE;
			stArgs.iLogLevel     = iLOGNIVEL_DEF;
		}
		return(0);
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int 	main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
		char szComando  [128]   ="" ;
		char szBaseName [128]   ="" ;
		int iResp = TRUE;
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
		memset(&stArgs, 0, sizeof(rg_argumentos));
		memset(&stStatusProc, 0, sizeof(rg_estadistica));
		stArgs.bFlagUser     = FALSE;
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
		iResp = vManejaArgs(argc, argv);
		if (iResp!=0) return iResp;
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
/*
        fprintf(stderr,"\n\tcfnGetTime(0):[%s]",cfnGetTime(0));
        fprintf(stderr,"\n\tcfnGetTime(1):[%s]",cfnGetTime(1));
        fprintf(stderr,"\n\tcfnGetTime(2):[%s]",cfnGetTime(2));
        fprintf(stderr,"\n\tcfnGetTime(3):[%s]",cfnGetTime(3));
        fprintf(stderr,"\n\tcfnGetTime(4):[%s]",cfnGetTime(4));
        fprintf(stderr,"\n\tcfnGetTime(5):[%s]",cfnGetTime(5));
        fprintf(stderr,"\n\tcfnGetTime(6):[%s]",cfnGetTime(6));
        fprintf(stderr,"\n\tcfnGetTime(7):[%s]\n\n",cfnGetTime(7));
*/
        fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");
		pszEnvLog = (char * )malloc (10024);
		if ((pszEnvLog = szGetEnv("XPF_LOG")) == (char *)NULL)
        {
           return(1);
        }
        sprintf(pszEnvLog,"%s/SolicNCBaja/%s",pszEnvLog,cfnGetTime(2));
        fprintf(stderr, "Directorio de Logs y Error        : [%s]\n", (char *)pszEnvLog);
        sprintf(szComando,"mkdir -p %s", pszEnvLog);
        system (szComando);
        stStatus.LogNivel = stArgs.iLogLevel;
        
/*---------------------------------------------------------------------------*/
/* Generacion del nombre y creacion del archivo de log y de err.             */
/*---------------------------------------------------------------------------*/
        strcpy(szhSysDate, cfnGetTime(5));
        
        sprintf(stStatus.LogName, "%s/%s_%s.log", (char *)pszEnvLog, LOGNAME, szhSysDate);

        fprintf(stderr, "Archivo de Logs         : [%s]\n", stStatus.LogName);
        if((stStatus.LogFile = fopen(stStatus.LogName, "w")) == (FILE *)NULL)
        {
           fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", stStatus.LogName);
           fprintf(stderr, "Revise su existencia.\n");
           fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
           fprintf(stderr, "Proceso finalizado con error.\n");
           return(1);
        }

        sprintf(stStatus.ErrName, "%s/%s_%s.err", (char *)pszEnvLog, ERRNAME, szhSysDate);

        fprintf(stderr, "Archivo de Error         : [%s]\n", stStatus.ErrName);
        if((stStatus.ErrFile = fopen(stStatus.ErrName, "w")) == (FILE *)NULL)
        {
           fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", stStatus.ErrName);
           fprintf(stderr, "Revise su existencia.\n");
           fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
           fprintf(stderr, "Proceso finalizado con error.\n");
           return(1);
        }

/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
/*		lSegIni=lGetTimer(); */
/*---------------------------------------------------------------------------*/
/* Header.                                                                   */
/*---------------------------------------------------------------------------*/
		fprintf(stderr, "Procesando ...\n");
		strcpy(szFuncName, "main");
		vDTrazasLog(szFuncName, "\n\t *****************************************************"
								"\n\t *** Inicia Proceso de Solicitudes de Nota de Credito."
								"\n\t *** Fecha          : [%s]"
								"\n\t *** %s"
								"\n\t *** VERSION       : [%s]"
								"\n\t *** Username      : [%s] (id = %d)"
								"\n\t *** Base de Datos : [%s]"
								"\n\t *****************************************************",LOG03,
								cfnGetTime(1),GLOSA_PROG,PROG_VERSION,getlogin(), getuid(),
								(strcmp(getenv("ORACLE_SID"), "")!=0?getenv("ORACLE_SID"):getenv("TWO_TASK")));
		
		vDTrazasError(szFuncName, "\n\t *****************************************************"
								"\n\t *** Inicia Proceso de Solicitudes de Nota de Credito."
								"\n\t *** Fecha          : [%s]"
								"\n\t *** %s"
								"\n\t *** VERSION       : [%s]"
								"\n\t *** Username      : [%s] (id = %d)"
								"\n\t *** Base de Datos : [%s]"
								"\n\t *****************************************************",LOG03,
								cfnGetTime(1),GLOSA_PROG,PROG_VERSION,getlogin(), getuid(),
								(strcmp(getenv("ORACLE_SID"), "")!=0?getenv("ORACLE_SID"):getenv("TWO_TASK")));
		
		vDTrazasLog(szFuncName, "\n\t *****************************************************"
								"\n\t *** Argumentos recibidos:"
								"\n\t *** Periodo a Procesar: [%ld]"
								"\n\t *** Nivel de LOG      : [%d]",LOG03,stArgs.lCodPeriodo,stStatus.LogNivel);
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
		strcpy(szhUser, stArgs.szUser);
		strcpy(szhPass, stArgs.szPass);
		if(fnOraConnect(szhUser, szhPass) == FALSE)
		{
			strcpy(szFuncName, "fnOraConnect");
			fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
			vDTrazasLog(szFuncName, "Usuario/Password Oracle no son validos. Se cancela.\n",LOG03);
			vDTrazasError(szFuncName, "Usuario/Password Oracle no son validos. Se cancela.\n",LOG03);
			
			return(1);
		}
		else
		{
			vDTrazasLog(szFuncName, "\nConexion con la base de datos ha sido exitosa.\n",LOG03);
		}
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
		/* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 10;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )321;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
/*---------------------------------------------------------------------------*/
/* Procesamiento principal.                                                  */
/*---------------------------------------------------------------------------*/
		strcpy(szFuncName, "Proceso principal");
		vDTrazasLog(szFuncName, "Inicio procesamiento principal ...\n\n",LOG03);
/*---------------------------------------------------------------------------*/
/*    - Inicia Carga de Universos de Solicitudes                             */
/*---------------------------------------------------------------------------*/
		strcpy(szFuncName,"vCreaUniverso");
		vDTrazasLog(szFuncName, "\n\n[%s] Inicia Carga de Universos de Solicitudes...\n",LOG03 ,cfnGetTime(1));
		fprintf(stderr, "Inicia Carga de Universos de Solicitudes ...\n\n");
		vCreaUniverso();
/*---------------------------------------------------------------------------*/
/*    - Procesa las solicitudes                                              */
/*---------------------------------------------------------------------------*/
		vDTrazasLog(szFuncName,  "\n\n[%s]Procesa las solicitudes...\n",LOG03, cfnGetTime(1));
		fprintf(stderr, "Procesa las solicitudes...\n\n");
		iResp = bfnProcSolicitudes();
		if (iResp!=TRUE) 
		{
			vDTrazasLog(szFuncName,  "\n\n[%s] Error en Procesamiento.\n",LOG03, cfnGetTime(1));			
			fprintf(stderr,"\n\nProceso con error. Se cancela la ejecucion.\n\n");
			return iResp;
		}
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de abonados y universsos.        */
/*---------------------------------------------------------------------------*/
		vDTrazasLog(szFuncName, "\n\n[%s] Libera memoria utilizada por listas.\n", LOG03,cfnGetTime(1));
		fprintf(stderr, "Libera memoria utilizada por listas de abonados y universsos...\n\n");
		vLiberaUniverso(lstUniverso);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/	
/*		lSegFin=lGetTimer();
		stStatusProc.lSegProceso = lSegFin - lSegIni; */
		stStatusProc.lSegProceso = 0; 
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
		vDTrazasLog(szFuncName,"\n\n\t******************************************** "
							   "\n\tEstadistica del proceso"
							   "\n\t------------------------\n"
							   "\n\tSolicitudes Emitidas           : [%d]"
							   "\n\tSolicitudes Rechazadas         : [%d]"
							   "\n\tSolicitudes Procesadas         : [%d]"
							   "\n\tTiempo de Proceso              : [%d][seg]",LOG03,
							    stStatusProc.iSolEmitidas,stStatusProc.iSolRechazadas,
							    stStatusProc.iSolProc,stStatusProc.lSegProceso);
		/* EXEC SQL COMMIT WORK RELEASE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 10;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )336;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 
		fclose(stStatus.LogFile);
    		fclose(stStatus.ErrFile);
		return(0);
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

