
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
static const struct sqlcxp sqlfpn =
{
    15,
    "./pc/Bloquea.pc"
};


static unsigned int sqlctx = 1725011;


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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,97,0,4,70,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
40,0,0,2,98,0,4,83,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
75,0,0,3,102,0,4,103,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
110,0,0,4,231,0,4,120,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
145,0,0,5,103,0,4,145,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
180,0,0,6,232,0,4,160,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
215,0,0,7,0,0,17,200,0,0,1,1,0,1,0,1,5,0,0,
234,0,0,7,0,0,45,216,0,0,0,0,0,1,0,
249,0,0,7,0,0,13,226,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
272,0,0,8,128,0,5,236,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
307,0,0,9,129,0,5,249,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
342,0,0,7,0,0,15,285,0,0,0,0,0,1,0,
357,0,0,10,156,0,4,295,0,0,7,6,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
400,0,0,11,157,0,4,313,0,0,7,6,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
};


/* ============================================================================= */
/*
    Tipo        :  ACCION

    Nombre      :  Bloquea.pc ("BLOQU"->szfnBloquea)

    Descripcion :  Bloquea todos los abonados (Celular y Beeper) del cliente dado

    Recibe      :  by Val -> Cod Cliente 

    Devuelve    :  "PND"  -> Ocurrio un error de oracle ( queda registrado en el log )
                   "OK"   -> La accion se ejecuto correctamente

    Autor       :  Roy Barrera Richards
    Fecha       :  10 - Agosto - 2000 
=================================================================	
Modificacion    :  12-11-2004
			Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
============================================================================= */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "Bloquea.h"
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


/* ============================================================================= */
/* funcion de Bloquea todos los abonados de un cliente */
/* ============================================================================= */
char  *szfnBloquea(FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
char modulo[]="szfnBloqueo";
int iError = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente       = 0  ;
	long lhCodCiclFact      = 0  ;
	int  ihProducto         = 0  ;
	int  ihAnulacionBaja    = 6  ;
	char szhCadena [1024]   =""  ; /* EXEC SQL VAR szhCadena IS STRING (1024); */ 

	int  iCuentaAboCelu = 0;
	int  iCuentaAboBeep = 0;   
	char szhBAA        [4];
	char szhBAP        [4];
	char szhAAA        [4];
	char szhSTP        [4];
	int  ihValor_cero = 0;
	int  ihValor_uno  = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 
    
	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);

	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG05, modulo );
  	lhCodCliente = lCliente;
	iAboCeluGlobal = 0;
	iAboBeepGlobal = 0;
	strcpy(szhBAP,"BAP");
	strcpy(szhBAA,"BAA");
	strcpy(szhAAA,"AAA");
	strcpy(szhSTP,"STP");
 
	/* verifica si todos los abonados estan suspendidos */
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT COUNT(:ihValor_uno)
	INTO	 :iCuentaAboCelu
	FROM	 GA_ABOCEL
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_SITUACION IN ( :szhAAA, :szhSTP ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(:b0) into :b1  from GA_ABOCEL where (COD_CLIENT\
E=:b2 and COD_SITUACION in (:b3,:b4))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboCelu;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhAAA;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhSTP;
 sqlstm.sqhstl[4] = (unsigned long )4;
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


   if (sqlca.sqlcode)
   {
        ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Select Ga_AboCel %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
   }

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT COUNT(:ihValor_uno)
	INTO	 :iCuentaAboBeep
	FROM	 GA_ABOBEEP
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_SITUACION IN ( :szhAAA, :szhSTP ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(:b0) into :b1  from GA_ABOBEEP where (COD_CLIEN\
TE=:b2 and COD_SITUACION in (:b3,:b4))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )40;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboBeep;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhAAA;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhSTP;
 sqlstm.sqhstl[4] = (unsigned long )4;
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


   if (sqlca.sqlcode)
   {
        ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Select Ga_AboBeep %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
   }

	if ( iCuentaAboCelu + iCuentaAboBeep > 0 )
   {
        ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Tiene abonados en AAA o STP.",LOG02,lhCodCliente);  
        return "PND";
   }

	/* valida que el cliente tenga el ciclo actual de la fa_ciclfact en la ga_infaccel o ga_infacbeep */
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT COUNT(:ihValor_uno)
	INTO	 :iCuentaAboCelu
	FROM	 GA_ABOCEL
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_SITUACION NOT IN (:szhBAA,:szhBAP); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(:b0) into :b1  from GA_ABOCEL where (COD_CLIENT\
E=:b2 and COD_SITUACION not  in (:b3,:b4))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )75;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboCelu;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhBAA;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhBAP;
 sqlstm.sqhstl[4] = (unsigned long )4;
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



	   if (sqlca.sqlcode)
   {
        ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Select Ga_Abocel %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
   }

	ifnTrazaHilos( modulo,&pfLog, "iCuentaAboCelu [%d] ",LOG05,iCuentaAboCelu);  
	if ( iCuentaAboCelu > 0 )
	{
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
		/* EXEC SQL
		SELECT COUNT(:ihValor_uno)
		INTO	 :iCuentaAboCelu
		FROM	 GA_INFACCEL
		WHERE	 COD_CLIENTE = :lhCodCliente
		AND	 COD_CICLFACT IN (SELECT	COD_CICLFACT
									   FROM	FA_CICLFACT
									   WHERE	IND_FACTURACION = :ihValor_cero
									   AND SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM )
		AND 	NUM_ABONADO != :ihValor_cero; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(:b0) into :b1  from GA_INFACCEL where ((COD_CL\
IENTE=:b2 and COD_CICLFACT in (select COD_CICLFACT  from FA_CICLFACT where (IN\
D_FACTURACION=:b3 and SYSDATE between FEC_DESDELLAM and FEC_HASTALLAM))) and N\
UM_ABONADO<>:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )110;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboCelu;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
		
    	if (sqlca.sqlcode)
    	{
        	ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Select Ga_InfacCel %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        	return "PND";
    	}

		if ( iCuentaAboCelu == 0 )
    	{
        	ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] No tiene el ciclo actual abierto en ga_infaccel.",LOG02,lhCodCliente);  
        	return "PND";
    	}
	}

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT	COUNT(:ihValor_uno)
	INTO	:iCuentaAboBeep
	FROM	GA_ABOBEEP
	WHERE	COD_CLIENTE = :lhCodCliente
	AND	COD_SITUACION NOT IN (:szhBAA,:szhBAP); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(:b0) into :b1  from GA_ABOBEEP where (COD_CLIEN\
TE=:b2 and COD_SITUACION not  in (:b3,:b4))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )145;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboBeep;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhBAA;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhBAP;
 sqlstm.sqhstl[4] = (unsigned long )4;
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

 
   if (sqlca.sqlcode)
   {
        ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Select Ga_AboBeep %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
   }

	if ( iCuentaAboBeep > 0 )
	{
      sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
		/* EXEC SQL
		SELECT COUNT(:ihValor_uno)
		INTO	 :iCuentaAboBeep
		FROM	 GA_INFACBEEP
		WHERE	 COD_CLIENTE = :lhCodCliente
		AND	 COD_CICLFACT IN (SELECT	COD_CICLFACT
									   FROM	FA_CICLFACT
									   WHERE	IND_FACTURACION = :ihValor_cero
									   AND		SYSDATE BETWEEN FEC_DESDELLAM AND FEC_HASTALLAM )
		AND 	NUM_ABONADO != :ihValor_cero; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(:b0) into :b1  from GA_INFACBEEP where ((COD_C\
LIENTE=:b2 and COD_CICLFACT in (select COD_CICLFACT  from FA_CICLFACT where (I\
ND_FACTURACION=:b3 and SYSDATE between FEC_DESDELLAM and FEC_HASTALLAM))) and \
NUM_ABONADO<>:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )180;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboBeep;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
		
    	if (sqlca.sqlcode)
    	{
        	ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] Select Ga_InfacBeep %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        	return "PND";
    	}
 
		if ( iCuentaAboBeep == 0 )
    	{
        	ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] No tiene el ciclo actual abierto en la ga_infacbeep.",LOG02,lhCodCliente); 
        	return "PND";
    	}
	}

    sprintf(szhCadena, " SELECT '1', A.COD_CICLFACT "
                       " FROM GA_INFACCEL B, FA_CICLFACT A "
                       " WHERE B.COD_CLIENTE = %ld "
                       " AND B.COD_CICLFACT = A.COD_CICLFACT "
                       " AND A.IND_FACTURACION = 0 "
                       " UNION ALL "
                       " SELECT '2', C.COD_CICLFACT "
                       " FROM GA_INFACBEEP D, FA_CICLFACT C "
                       " WHERE D.COD_CLIENTE = %ld "
                       " AND D.COD_CICLFACT = C.COD_CICLFACT "
                       " AND C.IND_FACTURACION = 0 "
                       ,lCliente,lCliente  );

    ifnTrazaHilos( modulo,&pfLog, "\n%s\n",LOG05,szhCadena);  

    sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
    /* EXEC SQL PREPARE sqlDinamico FROM :szhCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )215;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCadena;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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


    if (sqlca.sqlcode != SQLOK)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Prepare %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
    }

    sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
    /* EXEC SQL DECLARE curCiclos CURSOR FOR sqlDinamico; */ 

    if (sqlca.sqlcode != SQLOK)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Declare %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
    }

    sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
    /* EXEC SQL OPEN curCiclos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )234;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode != SQLOK)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Open %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
    }

    for(;;) /* forever */
    {
        sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
        /* EXEC SQL FETCH curCiclos INTO :ihProducto, lhCodCiclFact; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )249;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihProducto;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
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


        if (sqlca.sqlcode) 
        {
            iError=1;
            break;  /* fin del ciclo */
        }
          
        if (ihProducto == 1 ) /* Celular */  
        {
            sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
            /* EXEC SQL
			UPDATE GA_INFACCEL
			SET IND_BLOQUEO = :ihValor_uno
            WHERE COD_CLIENTE = :lhCodCliente 
            AND COD_CICLFACT = :lhCodCiclFact
            AND IND_ACTUAC != :ihAnulacionBaja
			AND IND_BLOQUEO = :ihValor_cero; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 5;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update GA_INFACCEL  set IND_BLOQUEO=:b0 where (((\
COD_CLIENTE=:b1 and COD_CICLFACT=:b2) and IND_ACTUAC<>:b3) and IND_BLOQUEO=:b4\
)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )272;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&ihAnulacionBaja;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			iAboCeluGlobal = iAboCeluGlobal + sqlca.sqlerrd[2]; /* Nro. de Registros actualizados */
        }
        else
        {
            sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
            /* EXEC SQL
			UPDATE GA_INFACBEEP
			SET IND_BLOQUEO = :ihValor_uno
            WHERE COD_CLIENTE = :lhCodCliente 
            AND COD_CICLFACT = :lhCodCiclFact
            AND IND_ACTUAC != :ihAnulacionBaja
			AND IND_BLOQUEO = :ihValor_cero; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 5;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update GA_INFACBEEP  set IND_BLOQUEO=:b0 where ((\
(COD_CLIENTE=:b1 and COD_CICLFACT=:b2) and IND_ACTUAC<>:b3) and IND_BLOQUEO=:b\
4)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )307;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&ihAnulacionBaja;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



			iAboBeepGlobal = iAboBeepGlobal + sqlca.sqlerrd[2]; /* Nro. de Registros actualizados */
        }
        
        if (sqlca.sqlcode) 
        {
            iError=2;
            break;
        }
    }
 
    if (sqlca.sqlcode == SQLNOTFOUND)
    {
        ifnTrazaHilos( modulo,&pfLog, "Ok. Alcanzado fin de datos ",LOG05);  
    }
    else
    {
        if (iError==1)
        {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Fetch %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        }
        else 
        {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)UPDATE %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        }
        return "PND";
    }
    
    sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
    /* EXEC SQL CLOSE curCiclos ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )342;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Close %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND";
    }
 
	/*- MGG 01/03/2001, Se cuenta la cantidad total a la fecha, de abonados celulares y -*/
	/*- beepers afectados por la accion, para guardar estadistica en la tabla co_morosos-*/ 
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL 
	SELECT COUNT(:ihValor_uno)
	INTO   :iCuentaAboCelu
	FROM   ga_infaccel
	WHERE  cod_cliente   = :lhCodCliente
	AND    cod_ciclfact  = :lhCodCiclFact
	AND    ind_actuac   != :ihAnulacionBaja
	AND    ind_bloqueo   = :ihValor_uno
	AND    num_abonado != :ihValor_cero; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(:b0) into :b1  from ga_infaccel where ((((cod_c\
liente=:b2 and cod_ciclfact=:b3) and ind_actuac<>:b4) and ind_bloqueo=:b0) and\
 num_abonado<>:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )357;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboCelu;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihAnulacionBaja;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_cero;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
			 
    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND) 
    {
        ifnTrazaHilos( modulo,&pfLog, "Recuperando abonados bloqueados GA_INFACCEL (Cliente:%ld) %s"
                           ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
        return "PND";
    }

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL 
	SELECT COUNT(:ihValor_uno)
	INTO   :iCuentaAboBeep
	FROM   ga_infacbeep
	WHERE  cod_cliente   = :lhCodCliente
	AND    cod_ciclfact  = :lhCodCiclFact
	AND    ind_actuac   != :ihAnulacionBaja
	AND    ind_bloqueo   = :ihValor_uno
	AND    num_abonado != :ihValor_cero; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(:b0) into :b1  from ga_infacbeep where ((((cod_\
cliente=:b2 and cod_ciclfact=:b3) and ind_actuac<>:b4) and ind_bloqueo=:b0) an\
d num_abonado<>:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )400;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCuentaAboBeep;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihAnulacionBaja;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_cero;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 
	
    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND) 
    {
        ifnTrazaHilos( modulo,&pfLog, "Recuperando abonados bloqueados GA_INFACBEEP (Cliente:%ld) %s"
                           ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
        return "PND";
    }

	iAboCeluGlobal = iCuentaAboCelu;
	iAboBeepGlobal = iCuentaAboBeep;
	iMRAboCeluGlobal = iCuentaAboCelu;
	iMRAboBeepGlobal = iCuentaAboBeep;
   ifnTrazaHilos( modulo,&pfLog, "Cliente:[%ld] se BLOQUEO AboCelu:[%d] AboBeep:[%d]", LOG05, lhCodCliente, iAboCeluGlobal, iAboBeepGlobal );

    return "OK";   
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
