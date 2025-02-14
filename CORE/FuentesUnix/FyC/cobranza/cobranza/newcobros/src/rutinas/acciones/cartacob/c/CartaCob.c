
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
    "./pc/CartaCob.pc"
};


static unsigned int sqlctx = 3445563;


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
   unsigned char  *sqhstv[6];
   unsigned long  sqhstl[6];
            int   sqhsts[6];
            short *sqindv[6];
            int   sqinds[6];
   unsigned long  sqharm[6];
   unsigned long  *sqharc[6];
   unsigned short  sqadto[6];
   unsigned short  sqtdso[6];
} sqlstm = {12,6};

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
5,0,0,1,229,0,4,88,0,0,5,3,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
40,0,0,2,323,0,4,109,0,0,6,4,0,1,0,2,4,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
97,0,0,
79,0,0,3,115,0,4,141,0,0,1,0,0,1,0,2,3,0,0,
98,0,0,4,480,0,4,156,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
125,0,0,5,154,0,4,177,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
};


/* ============================================================================= */
/*
    Tipo       	 :  ACCION
    Nombre     	 :  CartasCob.pc ("MENSJ"->szfnMensCorta)
    Descripcion	 :  Genera archivos la Direccion  y el Monto de la deuda vencida
               	    del cliente dado.
    Recibe     	 :  by Val -> Cod Cliente 
    Devuelve   	 :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
               	    "NOMSJ"-> No hay mensajes definidos y/o generados
               	    "OK"   -> La accion se ejecuto correctamente
    Autor 	     :  Modesto Aranda Contreras
    fecha      	 :  08 - Mayo - 2002 

Modificacion 	:  (Capc ) 22 - Octubre - 2004
		Se agrega parametro de Tipo de Direccion, para query que obtiene la dirección del Cliente.    
		CH-200408232102 Homologado por PGonzalez 23-11-2004
				
Modificacion    :  12-11-2004
		   Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
    
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "CartaCob.h"
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
/* Envia mensajes cortos a abonados del cliente  */
/* ============================================================================= */
char *szfnCartaCob(FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
char   modulo[] = "szfnCartaCob";
int	 iError = 0, ii=0, iMsgGenerados = 0, rr, ik, ilarDir, iresta=0, ilargo=0, iexiste=0;
char	 szhFecAux[9]="", szComando[256]="", szPathCart[256]="";
char   szEncabeza[501]="", szArchivoCart[256]="";
static char 	szAux[9];
double dMtoAux = 0.0 ;
FILE   *fp;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente			= 0  ;
	char	szhCodParam[15]		= "" ;/* EXEC SQL VAR szhCodParam IS STRING (15); */ 

	char	szhDirClie[250]		= "" ;/* EXEC SQL VAR szhDirClie IS STRING (250); */ 

	char	szhNomClie[91]			= "" ;/* EXEC SQL VAR szhNomClie IS STRING (91); */ 

	char	szhNomCampo[51]		= "" ;/* EXEC SQL VAR szhNomCampo IS STRING (51); */ 

	char	szhCadena [1024]		=""  ; /* EXEC SQL VAR szhCadena IS STRING (1024); */ 

	int	ihCodProducto			= 0;
	long	lhNumAbonado			= 0;
	long	lhNumSecuencia			= 0;
	long	lhNumDias				= 0;	
	double	dMtoSaldo 			= 0.0; 
	
	/* Vbles Bind */
	char  szhEPR     [4];
	char  szhCARTA   [6];
	char  szhCARTERA [11];
	char  szhTIPDOCUM[13];
	int   ihValor_uno = 1;
	int   ihValor_tres= 3;
	int   ihTipDirecc = 0; /* CH-200408232102 Homologado por PGonzalez 23-11-2004 */
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 


FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);
		
	memset(szArchivoCart,'\0',sizeof(szArchivoCart));
	memset(szPathCart,'\0',sizeof(szPathCart));

	lhCodCliente = lCliente;
	strcpy(szhEPR     ,"EPR");
	strcpy(szhCARTA   ,"CARTA");
	strcpy(szhCARTERA ,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");
	
	
	/*-Determina el nombre del archivo que corresponde al Pto. de gestion-*/
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT	M.COD_PARAM,
			M.NUM_SECUENCIA
	INTO	:szhCodParam,
			:lhNumSecuencia
	FROM	CO_PARAM_ACCIONES M, CO_ACCIONES C 
	WHERE	C.COD_CLIENTE   = :lhCodCliente
	AND     C.COD_ESTADO    = :szhEPR				/o la accion debe estar en proceso o/
	AND     C.COD_RUTINA    = :szhCARTA		/o accion de Carta de Cobranza o/
	AND     C.NUM_SECUENCIA = M.NUM_SECUENCIA
	AND     M.COD_PARAM  IS NOT NULL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select M.COD_PARAM ,M.NUM_SECUENCIA into :b0,:b1  from CO_PA\
RAM_ACCIONES M ,CO_ACCIONES C where ((((C.COD_CLIENTE=:b2 and C.COD_ESTADO=:b3\
) and C.COD_RUTINA=:b4) and C.NUM_SECUENCIA=M.NUM_SECUENCIA) and M.COD_PARAM i\
s  not null )";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodParam;
 sqlstm.sqhstl[0] = (unsigned long )15;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhEPR;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCARTA;
 sqlstm.sqhstl[4] = (unsigned long )6;
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


	
	if( sqlca.sqlcode != SQLOK )
	{
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Error al consultar CO_PARAM_ACCIONES %s ", LOG02, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
		return "ERPAR";   
	}

	ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Secuencia encontrada => [%ld] ", LOG03, lhCodCliente, lhNumSecuencia );

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0), NVL(TRUNC(SYSDATE)-TRUNC(MIN(FEC_VENCIMIE)),0)
	INTO  :dMtoSaldo,
		    :lhNumDias
	FROM  CO_CARTERA
	WHERE COD_CLIENTE = :lhCodCliente 
	AND   IND_FACTURADO = :ihValor_uno
	AND   FEC_VENCIMIE < TRUNC(SYSDATE)
	AND   COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
		FROM	 CO_CODIGOS
		WHERE NOM_TABLA = :szhCARTERA
		AND	 NOM_COLUMNA = :szhTIPDOCUM); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),0) ,NVL((TRUNC(\
SYSDATE)-TRUNC(min(FEC_VENCIMIE))),0) into :b0,:b1  from CO_CARTERA where (((C\
OD_CLIENTE=:b2 and IND_FACTURADO=:b3) and FEC_VENCIMIE<TRUNC(SYSDATE)) and COD\
_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from CO_CODIGOS where (NOM_TAB\
LA=:b4 and NOM_COLUMNA=:b5)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )40;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dMtoSaldo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumDias;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[5] = (unsigned long )13;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK )
    {
        ifnTrazaHilos( modulo,&pfLog, "SELECT FROM CO_CARTERA(1) (Cliente:%ld) : %s ",LOG02,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
        return "ERCTA";
    }

    if( !dMtoSaldo )
    {
        ifnTrazaHilos( modulo,&pfLog, " El Cliente[%ld] No registra saldo en CO_CARTERA",LOG02,lhCodCliente);  
        return "NOSAL";
    }


	ifnTrazaHilos( modulo,&pfLog, "\t\tCliente:[%ld]-Saldo(despues)[%f]",LOG05,lCliente,dMtoSaldo);
	
	/*PR-200410210627 ***** Se agrega parametro de tipo de dirección   ***** capc 22-10-2004*/
	/*-Obtiene Tipo de Dirección del Cliente-*/
	/* CH-200408232102 Homologado por PGonzalez 23-11-2004 */
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT VAL_PARAMETRO  
	INTO :ihTipDirecc
	FROM GED_PARAMETROS
	WHERE COD_MODULO = 'CO'
	AND NOM_PARAMETRO = 'TIPDIREC_CARTA_COBRO'; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where (CO\
D_MODULO='CO' and NOM_PARAMETRO='TIPDIREC_CARTA_COBRO')";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )79;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihTipDirecc;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( SQLCODE != SQLOK  )
	{
	        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Error al Obtener Tipo direccion del cliente %s ", LOG02, lhCodCliente, SQLERRM );  
	        return "NODIR";
	}
	
	/*-Obtiene direccion Cliente para grabar en archivo-*/
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT NVL(DIR.DES_DIREC1,' ')||';'||NVL(DIR.DES_DIREC2,' ')||';'||NVL(COM.DES_COMUNA,' ')
		   ||';'||NVL(PROV.COD_PROVINCIA,' ')||';'||NVL(DIR.ZIP,' ')||';'
	  INTO :szhDirClie  	   
	  FROM GA_DIRECCLI DIREC ,GE_COMUNAS COM ,GE_DIRECCIONES DIR ,GE_PROVINCIAS PROV 
	 WHERE DIREC.COD_CLIENTE= :lhCodCliente
	   /oAND DIREC.COD_TIPDIRECCION= :ihValor_tres o/
	   AND DIREC.COD_TIPDIRECCION= :ihTipDirecc /oSe agrega parametro del campo Tipo Dirección PR-200410210627 capc  22-10-2004o/ /o CH-200408232102 Homologado por PGonzalez 23-11-2004 o/
	   AND DIREC.COD_DIRECCION= DIR.COD_DIRECCION 
	   AND DIR.COD_COMUNA=COM.COD_COMUNA 
	   AND DIR.COD_PROVINCIA=PROV.COD_PROVINCIA
	   AND DIR.COD_REGION = PROV.COD_REGION; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select (((((((((NVL(DIR.DES_DIREC1,' ')||';')||NVL(DIR.DES_D\
IREC2,' '))||';')||NVL(COM.DES_COMUNA,' '))||';')||NVL(PROV.COD_PROVINCIA,' ')\
)||';')||NVL(DIR.ZIP,' '))||';') into :b0  from GA_DIRECCLI DIREC ,GE_COMUNAS \
COM ,GE_DIRECCIONES DIR ,GE_PROVINCIAS PROV where (((((DIREC.COD_CLIENTE=:b1 a\
nd DIREC.COD_TIPDIRECCION=:b2) and DIREC.COD_DIRECCION=DIR.COD_DIRECCION) and \
DIR.COD_COMUNA=COM.COD_COMUNA) and DIR.COD_PROVINCIA=PROV.COD_PROVINCIA) and D\
IR.COD_REGION=PROV.COD_REGION)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )98;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDirClie;
 sqlstm.sqhstl[0] = (unsigned long )250;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihTipDirecc;
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



	if( sqlca.sqlcode != SQLOK  )
	{
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Error al Obtener direccion del cliente %s ", LOG02, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "NODIR";
	}
	
	/*-Obtiene nombre del cliente-*/
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT	RTRIM(NOM_CLIENTE)||' '||NVL(RTRIM(NOM_APECLIEN1),' ')||' '||NVL(RTRIM(NOM_APECLIEN2),' ')
	INTO	:szhNomClie
	FROM   GE_CLIENTES 
	WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select ((((RTRIM(NOM_CLIENTE)||' ')||NVL(RTRIM(NOM_APECLIEN1\
),' '))||' ')||NVL(RTRIM(NOM_APECLIEN2),' ')) into :b0  from GE_CLIENTES where\
 COD_CLIENTE=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )125;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNomClie;
 sqlstm.sqhstl[0] = (unsigned long )91;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Error al consultar tabla GE_CLIENTES %s ", LOG02, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "NODAT";   
	}
	
	if( sqlca.sqlcode == SQLNOTFOUND )
	{   
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) no esta en tabla GE_CLIENTES %s ", LOG02, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "NOCLI";   
	}
	
	/*-Si no existe, crea el direcctorio del dia -*/
	
	if (ifnSysDateYYYYMMDD(szAux, CXX)!=0) return "PND";
	/*strcpy (szAux,(char *)szSysDate("YYYYMMDD"));  obtiene fecha actual */
	sprintf( szPathCart, "%s/CartaCob/%s\0", getenv("XPC_DAT"),szAux );
	
	sprintf( szComando, "mkdir -p %s\0", szPathCart );
	if (system (szComando)!=0)  /* no pudo crear el directorio */
	{
		fprintf (stderr,"Error al intentar crear directorio de CartaCob\n");
		fflush  (stderr);
		return "PND";
	}
	sprintf( szArchivoCart,"%s/CartaCob_%s.csv",szPathCart, szhCodParam );
	/* Se debe verificar si el archivo existe de lo contrario insertar los encabezados */
  	memset(szComando,'\0',sizeof(szComando));
   sprintf( szComando, "test -s %s\0", szArchivoCart );
	iexiste=WEXITSTATUS(system(szComando));
	
	if((fp = fopen(szArchivoCart,"a")) == (FILE*)NULL )
	{ 
		fprintf (stderr,"Error al crear archivo de Cartas de Cobranza\n");
		fflush  (stderr);
		return "PND";    
	}
	
	ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) valor variable iexiste: %d", LOG03, lhCodCliente, iexiste);  
	/* Si archivo no existe insertar los encabezados */
  	if (iexiste)
	{  
	 fprintf(fp,"COD_CLIENTE;NOMBRE DEL CLIENTE;DIRECCION1;DIRECCION2;PUEBLO;PAIS;ZONA POSTAL;BALANCE;DIAS DE MOROSIDAD\n");		      
	}	
	fprintf( fp, "%d;%s%;%s%.*f;%ld\n", lCliente, szhNomClie, szhDirClie, pstParamGener.iNumDecimal, dMtoSaldo,lhNumDias);
	fclose(fp);
	
	/* se debe borrar el registro de la CO_PARAM_ACCIONES */
	if( !bfnBorrarCoParamAcc(&pfLog, lhNumSecuencia, CXX ) )
	{
		ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Error en bfnBorrarCoParamAcc.", LOG02, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "NOELI";   
	}	
		
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

